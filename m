Return-Path: <linux-kernel+bounces-63976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB10685373A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4181F231EC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1BC5FEF6;
	Tue, 13 Feb 2024 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKHhYaeo"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D0B5FBB5;
	Tue, 13 Feb 2024 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844987; cv=none; b=MIK+YWBy+DCmCBTlzF6Wb2CgsmfH3f5xeQINZDzbv0ez2Z8xJp0NLvV/LHa8uUYcLym4EuOQjJQLA8/SiofoRipzI95yX7kwi0goL2QPODP30NWt+Q6LDIAmRCBL7hex399XfZuVJqKGJJf1kkQtEemh0jfzlkF1zVOkA7NvHzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844987; c=relaxed/simple;
	bh=mjmEg/6Q3rSOWsCjzIpsBAIuas/iBfGgROiAASE43cA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lzlsa9u7eYV8eA+et4Hcm9NcXs1CiB5TOhSRORTWoYee/dHydBulsVUqYeCgBO/GgI1SSvwQvxvqpkg+u+htdzF8qBYPO9k9UIYvDe7EUeMN+0Ptispg/VO8DsuxtL+RfMe/MNbTzvRE9PJTThk38tLg+tA2qaSH9+yNXdWlAzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKHhYaeo; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-290c5c705d5so986521a91.0;
        Tue, 13 Feb 2024 09:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707844985; x=1708449785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjmEg/6Q3rSOWsCjzIpsBAIuas/iBfGgROiAASE43cA=;
        b=HKHhYaeo3cZ8z84ZilS5FKjxTuBK1acUfXKycVehS0SazfkxsOmhKPvCnCqPaCN22J
         Svl6QTfxnk4T/M1/2YH8oyhmGTWzP7dYkZQTfuinosIf2LrH97KAqyRFwJVwrwA3fF2Z
         g5xX5Flsw1FZcxAapg/iO3pv9F+XaRsgsCU4oeIi0ISSPXPCpN8zhbOqwOdT7ShTBLaP
         w5jKeiCiAo/0ySvO/881lhSwgnrsPpQ9QGbD12WDjqikVF1ndI+4VEyBe1fWyg2lxYnm
         qPOni+kcX45ZIIu4yv4x/8efT3LVNG5/TubFgQQjMyLQd4jwvJRVe++FdhlWxcdk9S+0
         bpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707844985; x=1708449785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjmEg/6Q3rSOWsCjzIpsBAIuas/iBfGgROiAASE43cA=;
        b=qmJz9HD5G6B4Y7fQ93RnO+PUE8sirdOUfbyEDyBNF/En3IvpLOofYofPqTu9ZSL35q
         TGU3qQWbniF1g1APSA6DBwzudib6dgPAozUNFSXl4nlNicqa/mMvJP7Blw7cjtvMvBjq
         COvydKyg9WnLOrNibWLlCl7P6VYNDVr/f7RPbXgSqy6s5uQGoF8mqs3FqiTMlAuLtliT
         UVfUi9QWSBhI2Dxy07myacS0ZAXtzkE+2eBMrmIqIy9qancSoZKpN9R078RUzNpW5wLS
         0zNlkJ2oAnslgQktTyRqWptUMiPzN8IMTXfQPqpcd55xO9hstKgHYtMsIz+QeDj+u9WB
         tv6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlCVbHNQ+N4rlYDG8zE1BZw9LFyDin3Hq//3W0y2H3d8kDSTbzYmXscuAuiaypifxVnFP36/RMavk587VdxT3OdhB6OhMGRJqbWMuskmQcqoQftP4UB3m8/0RnBigLq31DbEXxSvB1
X-Gm-Message-State: AOJu0YxPFVODW9+Rev0Yn6x03EpX3J9SGc4iffXQ/h6z5965N1M6pCdw
	C4PWOn5AwiCcGXx74ohwbKzGUYt6XM0Hqfxp1xglY+DxWcw70lbEFL0e/BzKipcIUtPXha0zu8W
	63WSbrtSfnrSjNKAPT59ZyJ+8vZQ=
X-Google-Smtp-Source: AGHT+IHyWbnAbhgYmg9qvuwrKRqdGf18Qtp/hf6y3X8hqyT+QZL902aJc1N5SOAWWYm3Nu/ZGTNtr0sUSNeTT+e5DUo=
X-Received: by 2002:a17:90a:558e:b0:297:18f8:ac02 with SMTP id
 c14-20020a17090a558e00b0029718f8ac02mr103398pji.2.1707844985305; Tue, 13 Feb
 2024 09:23:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202115330.wxkbfmvd76sy3a6a@runtux.com> <20240213170657.puwlx5pjl3odcs2k@runtux.com>
In-Reply-To: <20240213170657.puwlx5pjl3odcs2k@runtux.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 13 Feb 2024 14:22:53 -0300
Message-ID: <CAOMZO5CD7+E_BBH+oQ8HUdBeRFZxWW7s2uJgS5eaQAW_Fe4CNg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] spi-mxs: Fix chipselect glitch
To: Ralf Schlatterbeck <rsc@runtux.com>
Cc: Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	NXP Linux Team <linux-imx@nxp.com>, linux-spi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ralf,

On Tue, Feb 13, 2024 at 2:07=E2=80=AFPM Ralf Schlatterbeck <rsc@runtux.com>=
 wrote:
>
> On Fri, Feb 02, 2024 at 12:53:30PM +0100, Ralf Schlatterbeck wrote:
> > There was a change in the mxs-dma engine that uses a new custom flag.
> > The change was not applied to the mxs spi driver.
> > This results in chipselect being deasserted too early.
> > This fixes the chipselect problem by using the new flag in the mxs-spi
> > driver.
> >
> > Fixes: ceeeb99cd821 ("dmaengine: mxs: rename custom flag")
> > Signed-off-by: Ralf Schlatterbeck <rsc@runtux.com>
> > ---
> > For oscilloscope screenshots and a verbose explanation see my blog post
> > at https://blog.runtux.com/posts/2024/02/01/

I suggest putting the link to your detailed explanation into the
commit log as this is useful information.

Reviewed-by: Fabio Estevam <festevam@gmail.com>


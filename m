Return-Path: <linux-kernel+bounces-86406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 273B786C4F8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9883B23A28
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEA95B68F;
	Thu, 29 Feb 2024 09:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v6vBqw74"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3645B685
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198694; cv=none; b=RiabHUEqm8FxCUzEDntiHC89zdSgrRi+z0nJs6ul1I3zLPCl1gyxUJgaP/lJryiQ0vJJnVjdSiT+nkU0+JyiooMVRobpAiiX+sZJpGF/1p8SmbfETN2icLgz+U3bUwJOIJvsKEcn7EOwONcyJd/jXKRn9ob3ohe8zgX+XI4iv8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198694; c=relaxed/simple;
	bh=XgXKQRyPRkOd5imcOO1De6VPE1wNBifTMp3skwabjRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ah1O6s+iw9x2On1TwrgDvwrt9fqBBMeqDwJZ8r0pfEEJJYqn6yC+nRuybzOF/mPzMOKp0yolsAWC4Jyoh2jcxQDy9drGKgZOZj5onlDsVum1HxpsLIJ0DUyAzcf0C3Lkgr9ld/CfEJ/+tCSzspqkS3oGISJxirW2kcvbIxhEIZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v6vBqw74; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcbc6a6808fso699761276.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709198692; x=1709803492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgXKQRyPRkOd5imcOO1De6VPE1wNBifTMp3skwabjRc=;
        b=v6vBqw74d53slVj6eUS5oP4PDIc7FrUrmVD3iWhvkfxsV3I3zDoqQJkcNaRyRLREZ6
         RhjWGwvhFL99ywRdARPbXUBlb7/XcArkLTUhpqy6AEKI8FWjHVe0HyhS/m8x9TyRN4cY
         C/sP3ySRvmnuj/WoECf6qSKQ1RRZy9IanYSZ35yiQt4wNWjvqzuS45+JdBrgGWx6fZQu
         fL5m724TmHt8neG50fsHohOhG34QRmdddE0qIt1auUTGvYiD93KK5j/ohbH79LMB/+4l
         FwjBtZ0GtFiPPWp5keoJBRo8dNTmSnD3vDjXvTg8owOVUxB0psQy5eNtcObc9q4SLaHD
         +3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709198692; x=1709803492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgXKQRyPRkOd5imcOO1De6VPE1wNBifTMp3skwabjRc=;
        b=cSbncoBv+fhlSK7vYMQ2Ze0hltEkj7Mk8tWwlKeqGGl890VBUOjxEeKZKWutTnBnfe
         /WLTCs3+Cj5hREDxZE4Hr/kjQQRqlO5ao6NGP0liPveTt3KsPqyT0XFTkXQ31PDlAQJD
         ZWMLQ8LZ//yd2+P7eXgDgT6GwBWav6afaXdo382ZDKmWfBjVam/DL/YF3cgY7FTHrYCL
         P654mUVPulzxIQgItoRJ8LIR5Dtv3bFFBgiJAUAaTZyPfRuDaIuVfzeMkqrr5Lw8MfN6
         guDnbAchsw05Thhv8tPaYtmIu2vNO8BlFovJN3wSOgQplB7ccEglkBSJ+prb1tJKMkyg
         E8OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgTS0Ne2suPGfqJVLsqoqmO7FF6PK9ngQno070QlLa9OHsDm5zob7gknD4m32Jo1B055BRQPN6hl4vm8xObCcFi6gKhHEdd3PZeTQJ
X-Gm-Message-State: AOJu0YyGdgUJ6TYtiux2UNQQh3k9EEQgMpyREbQOMgas1k0X6VhMojXk
	4wUEEtQ2qTSGcIgBMMP679c0XLMGoFDqDF3BdxKlo8kJNdRyYGi/32DAs432KOyZ+/154RsLEzH
	fUORLv4jGOHYV+3xeYSB7Et8iuOq7D/xn6nm+Vw==
X-Google-Smtp-Source: AGHT+IHnSluj8noDkCdA/Cr1alfd3L//OLqOP/CsIY5MpMGMSAYZTI1jAe+ZOvEXeVS7SN/cMHdb2IbecrkNGXkvUmU=
X-Received: by 2002:a25:3343:0:b0:dc6:b779:7887 with SMTP id
 z64-20020a253343000000b00dc6b7797887mr1579268ybz.20.1709198691706; Thu, 29
 Feb 2024 01:24:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com> <20240228-mbly-gpio-v2-7-3ba757474006@bootlin.com>
In-Reply-To: <20240228-mbly-gpio-v2-7-3ba757474006@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 10:24:40 +0100
Message-ID: <CACRpkda6hnuaEhpdXJ-S-60EdLVi4nay9bEb-Hf0sw-=d_XKVg@mail.gmail.com>
Subject: Re: [PATCH v2 07/30] pinctrl: nomadik: Kconfig: allow building with COMPILE_TEST
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 12:28=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@boot=
lin.com> wrote:

> PINCTRL_NOMADIK, PINCTRL_STN8815 and PINCTRL_DB8500 depend on ARCH_U8500
> or ARCH_NOMADIK. Add COMPILE_TEST as an option to allow test building
> the driver.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Patch applied to my immutable branch.

Yours,
Linus Walleij


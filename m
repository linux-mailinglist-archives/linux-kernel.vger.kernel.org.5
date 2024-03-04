Return-Path: <linux-kernel+bounces-90493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EAC870010
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09FB286611
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9052383B4;
	Mon,  4 Mar 2024 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrmvrCY+"
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEBD2BAF5;
	Mon,  4 Mar 2024 11:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550898; cv=none; b=G20DK2P4uXK88f82TbXmMdB8I+pXHgxluJsMMuG31xbOZyl/xZ/hHSdFEphqjuRILDYCRTXnlLL0g7DIEcyUe3h0/7i2FDqZ6Pz42h28Pz4Fw/XN5S1BLDZhKtYkaLztaZ86gKBluRPOU+i8LFwfCxsJAYgMelmHoTVWpkLkEo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550898; c=relaxed/simple;
	bh=JwLdcqmZRnkW9gPpAQ+L4jnbQV3urHf3TejzewIeCkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8YNuYIuFjRO9p64VzIMD4924FKsVAPDt3ATRR9RrI9q/uhUO3hOTY5X8RaPPnERrDbT+ZmYwQew3wYnpNCjNcrRoRfRlOLVZb9lp+0ZHmJYxk6AvX6/J73RW2uGd0Yw4eUF0auDZmcE6zrM2e74TCG16SE/2zO4taD+o/V82U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrmvrCY+; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-6905b62ed2aso10063756d6.1;
        Mon, 04 Mar 2024 03:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709550895; x=1710155695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwLdcqmZRnkW9gPpAQ+L4jnbQV3urHf3TejzewIeCkQ=;
        b=KrmvrCY+a+95o/a6iFVGKI6M5oQAW1+a7XiDBXvT041YW6GehCTcX4mgTcFV6WUsqz
         jklgp6hclCjA/VUlwGCnnrGvAV6AUvpRXLKz2bhEvQkyKlC3kuOZj7CEiILSbwHa3uNu
         kGz/QyKqMWKGMobSWlGPLB4T2iEQd5sLEV1REXqw9+UuTfba0hxo1ZASN7KO4bQKj8At
         tIMWoQ4DnxXdnsxZgDOA8gtg2A6SAyRREFBbSMyn3s9jUNCDb9X++1qTPdwZSDFQra2V
         ctet+rlA5U9xeOxtLcfIJmlYPE0lGz11yUYI5LyRBX4QqmMdLqFcSksJdN+dT1QpAZBb
         3kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709550895; x=1710155695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JwLdcqmZRnkW9gPpAQ+L4jnbQV3urHf3TejzewIeCkQ=;
        b=BGvU8K4fsUb2wRy0b6r58UHORQ9dmZGKMY8KjFFDwqzj/UIKWKNVfejukvB+dZjFVa
         xkNdw7vHnXFaspb8czJ2yZ5dOk4nqeRS44karqWlvtpKme3w5dcXLQ81N3sjKEe+llVw
         sXvHhz2F8VQyN7/VpFVGclS/uAox5JyvtB7hFcBRHOhvvVqUX5mERQ953jkpyLAIro+U
         epiUu+4fbcU9lZLGDTu/gafjECM8oxyO/qgjRjBwlqnZ4daZEJwAEbyFOH+wlgHTwSTk
         0uOPPr78DXdOHcJxV9ZaWsp9NFw1PPGV2apwAtx3GeZ9356HZgINiG0+7d7Xph0xUZPV
         gPkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz7rrK6DMIMfTJJowcECrUuRX+lJUTrApmSD04Ei/70pb595KxKlKLxArPWZ4lLdvXh5RNkhLpVc6Qq4TCmCylR+0V9/r5xUI+h5C6EzAWMWyfSlDjFIPwHOaSWeq5uGB0AkHW
X-Gm-Message-State: AOJu0YzSUBtvuAWmTZdhGxtqlqDj2SUHytLuZ/X3RSbg1m64FNCj93T/
	gTmAbJhIk6viKP9kjkvWZuco6EN6MWrhfBtMEGK9zz06prKumsQswL6F1zCJRJDvVab/TMcpWxg
	qmv1eji1Zn5uGs2/anfMUG8tUvw==
X-Google-Smtp-Source: AGHT+IEMLC2mrj9BRq8KVos+YXgcHdIPGSPwAd/XPK13XTBzjhg4BEd2/xYi9X+t0f99ibPlO9ql7kGqndUVjUrPr2s=
X-Received: by 2002:ad4:4588:0:b0:690:7d2b:6326 with SMTP id
 x8-20020ad44588000000b006907d2b6326mr687568qvu.11.1709550895628; Mon, 04 Mar
 2024 03:14:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240303114139.GA11018@didi-ThinkCentre-M920t-N000> <CAL+tcoDAmA4q+FxJchgA1LQ2fxhD8oRdjDOmVPeJ1-eSnkSt5Q@mail.gmail.com>
In-Reply-To: <CAL+tcoDAmA4q+FxJchgA1LQ2fxhD8oRdjDOmVPeJ1-eSnkSt5Q@mail.gmail.com>
From: yuanli fu <fuyuanli0722@gmail.com>
Date: Mon, 4 Mar 2024 19:14:42 +0800
Message-ID: <CABbqxmcJ+bybv0e-Rby9Q1jVR59Na_XE9MBee+f_zu0HUTmvqA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net/nlmon: Cancel setting the fields of
 statistics to zero.
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	fuyuanli@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jason Xing <kerneljasonxing@gmail.com> =E4=BA=8E2024=E5=B9=B43=E6=9C=884=E6=
=97=A5=E5=91=A8=E4=B8=80 15:05=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Mar 3, 2024 at 7:43=E2=80=AFPM fuyuanli <fuyuanli@didiglobal.com>=
 wrote:
> >
> > Since fields of rtnl_link_stats64 have been set to zero in the previous
> > dev_get_stats function, there is no need to set them again in the
> > ndo_get_stats64 function.
> >
> > Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
> > Link: https://lore.kernel.org/netdev/20240302105224.GA7223@didi-ThinkCe=
ntre-M920t-N000/
>
> Suggested-by: Jason Xing <kerneljasonxing@gmail.com>
> See https://lore.kernel.org/all/CAL+tcoA=3DFVBJi2eJgAELhWG_f+N-kwmrHc+XRf=
KXhYk2RJcPKg@mail.gmail.com/
OK, I will submit a v3 patch which updating commit message, thanks.
>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
>


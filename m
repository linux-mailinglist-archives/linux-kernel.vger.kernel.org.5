Return-Path: <linux-kernel+bounces-144732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DED8A49F0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1139285364
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE327364A4;
	Mon, 15 Apr 2024 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8oAdr2V"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6F32E652;
	Mon, 15 Apr 2024 08:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168731; cv=none; b=nPJgjwEvGKZHGxfpkiZ3jHa/LR1HitTU9SafGGPzBEEH6jkoPEhqap/eTRR5vulAxBcmcVBIM1c+fX+OYMCcTkt0D5F1x9TDrevmS3qMXdLayeGItmPxB9zTiWy7F38EW+xCmg0avq0+K/PU8YuoPSeR3Sfn40EX7/937Sh34xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168731; c=relaxed/simple;
	bh=NpcniozpPt9boUvcAsa1UdUXW8oXvKi1grpXE8WSU68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AovCKWd+M8CW8RtUK4JkXd9laX+yOAAtOvX0+ukFgeK/Wfq9e6rIGWLJoFr2obuM3+77NhGpRrMx8ulrPXuLbNPrsc9bhveS6ZDyTJKQgFzVOervmWuB9bBxPYRx1IGb3Ep/IrA102Zto7UeNwpUw5C4IE4H09OhFGxHMN4xGL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8oAdr2V; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34388753650so1224237f8f.3;
        Mon, 15 Apr 2024 01:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713168728; x=1713773528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8ktRnuwwJD2DRhjNKjclFVyrZGUNxQQFBXCM7JC/O4=;
        b=E8oAdr2VaDRYWbBmX9Fp0U+a7pZgWOtqAT9w8L8sNYJjWnuE15CjEkluNItBzRUjBU
         VlE3dEeXFEToUyK27zbVXMW3Cf24Qbf4QHqdRpt6ROSBqqj7lICdiJDZZlYquQDAJI/u
         UUAcRfBzcXwBQsSN9L58hpXvLZ2u9/FlbTvos38U3YsQNbm1IDQXeJYvJg+CaZ8yK9f1
         n4IPYoQInBOhMNTvKbS3WstuZlKrjUbZS2QrFsgP9wJOki9eCXhXD0aO3F6TRXvUs4VN
         T+YC+XakUldXf5oEl8CMSkYetGj08gTQcc/bJc97rK1b6DOOl/r3UyvHT5ODhNCrE8ry
         Anyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713168728; x=1713773528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8ktRnuwwJD2DRhjNKjclFVyrZGUNxQQFBXCM7JC/O4=;
        b=Z9ZIYxuCNs8dmEIPqkpaapiOyp7cQKJ0zdL0/5nP7pYuoyclgsxg7wQ3rdRu4XbLsx
         /Y5V3cpGmftUIRYkwFfHE+muX+SpPOoxxV6p7+ypGvLvM6Iy5Y5tn4//CQyJzSkYpIdH
         wL4+UyyjF+GWjoUtYfE1f04KXZNyFBbXna7E+E+0FfaNgbF/qsNQIsB2DRHJovCA/aiM
         ukSsD6bHeLBav8GGdVsBTvTSQexESl0PHOy9YMtR83tD26kiE1griqX7uyO2wk2ezNO+
         PB3nJ5Ihwi3EiztLDueC2Io1bOnE44r+8Dmv3lCdaNLEMxUCq9h9dOr8MqH4MRzJAQj2
         zbNw==
X-Forwarded-Encrypted: i=1; AJvYcCVRonHUoQu4wVteN/7TxGFW7XJgWTZOu0ZSyKic2GK/H89qbK86vA9WfiC2c5W5zigsrRtPr3nB/WBKvgg6YW0gl72Yh9utiRJsPJzpvd/mr1JBXthbtJt/KvNKeINRTTfEe1Ej7f8q
X-Gm-Message-State: AOJu0YytWbVId+piMnEUbhw49Zq59XfgIXSgLcusi7Bj2BAGAS3JkKCp
	n6RAAIhnctj79/JpCAdxCG65wprKOxuPs4BicSUX2QCT7ZEy5lbTeqV2iOAnhOK20nwfbOJlKYS
	uVkAFEz0n0xtXWSAV4+BX0c5dEF87QaWM
X-Google-Smtp-Source: AGHT+IGPpgOfPoWKLNOAQ//SW1OaYbwqkVNt2ffxIAvsTVr1e7gebj/lU1kAVscIZt1oZ8Ilyor2LLWmLlsF7Z/OMhg=
X-Received: by 2002:a05:6000:2a5:b0:343:de7b:2019 with SMTP id
 l5-20020a05600002a500b00343de7b2019mr8327423wry.51.1713168727910; Mon, 15 Apr
 2024 01:12:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415070620.133143-1-richard.xnu.clark@gmail.com> <52c08a01-8357-44dd-b727-a06438ec6c30@intel.com>
In-Reply-To: <52c08a01-8357-44dd-b727-a06438ec6c30@intel.com>
From: richard clark <richard.xnu.clark@gmail.com>
Date: Mon, 15 Apr 2024 16:11:56 +0800
Message-ID: <CAJNi4rOyuXdHOifib6kX0Wdb5O5LXPEm9nsvEMe-jbCz9GyQww@mail.gmail.com>
Subject: Re: [PATCH] sdhci: Fix SD card detection issue
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 3:18=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 15/04/24 10:06, Richard Clark wrote:
> > The mmc_gpio_get_cd(...) will return 0 called from sdhci_get_cd(...), w=
hich means
> > the card is not present. Actually, the card detection pin is active low=
 by default
> > according to the SDHCI psec, thus the card detection result is not corr=
ect, more
>
> SDHCI spec covers the SDHCI lines.  GPIO is separate.
>
> > specificly below if condition is true in mmc_rescan(...):
> >       ...
> >       if (mmc_card_is_removable(host) && host->ops->get_cd &&
> >               host->ops->get_cd(host) =3D=3D 0) {
> >               ...
> >               goto out;
> >       }
> > The SD card device will have no chance to be created.
> >
> > This commit fixes this detection issue via the MMC_CAP2_CD_ACTIVE_HIGH =
cap2 flag,
> > parsed from the 'cd-inverted' property of DT.
>
> What hardware / driver is it?
sdhci-tegra on Orin.
> >
> > Signed-off-by: Richard Clark <richard.xnu.clark@gmail.com>
> > ---
> >  drivers/mmc/host/sdhci.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index c79f73459915..79f33a161ca8 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -2483,6 +2483,9 @@ static int sdhci_get_cd(struct mmc_host *mmc)
> >        * Try slot gpio detect, if defined it take precedence
> >        * over build in controller functionality
> >        */
> > +     if (!(mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH))
> > +             gpio_cd =3D !gpio_cd;
>
> MMC_CAP2_CD_ACTIVE_HIGH is already handled in
> mmc_gpiod_request_cd(), and this turns an error (gpio_cd < 0)
> into 0, which is not right.

But in case of 'cd-inverted' is not specified, the gpio CD pin return
0 which will be explained as card is not present.
>
> > +
> >       if (gpio_cd >=3D 0)
> >               return !!gpio_cd;
> >
>


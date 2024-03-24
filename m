Return-Path: <linux-kernel+bounces-112541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D79887B55
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 02:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE0A1C2146D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 01:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2811C17F5;
	Sun, 24 Mar 2024 01:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="se+G+HbX"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D639B10F4
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 01:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711243506; cv=none; b=pDzmNFSZFLxkc8zRUFgqidulJf99mTIzVQLUkCtJo86kiplMeKxUkSqkygfp5u+o9f07bCwIlFdMvvjHsTuhLVnulbpczihZjVAc2iOSBkwsvAjo+U9R8y/JwMBKxYtZliuzC1Shkj5UhzMko9b3Dc7nt9SjrHE+f/PRY2sYQbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711243506; c=relaxed/simple;
	bh=2QN/DLgDGXz+HG0//uVaymyVYF9CRcZ2ka4xK9A6/cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyTp+1eiN24bNah5FKZJMIIg7UhEY/kHpFk4WDfixkMfiByuawgVTEwHQ95dVcToUGRWsdkd5eQt3jbhAUebGu1tt4Pm8R/Jqq0CX3XTte/NCdQWlvV8xaauNnWGDhcL6sjIFRQgM+uCKKIQRYkbE3jeNQ2/LGyofAnKE61lULQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=se+G+HbX; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e6b22af648so2886910b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 18:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1711243503; x=1711848303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LzkhJwRQhOpnuxfYahJxkJR2Jm2xIqxG//Pzm2qwvz8=;
        b=se+G+HbXb+sthj6GMdyaSJc3AogkuBPQ4AyLXniXl06U/8WLM2EZVxq65X1uH1XapV
         F0Knk85Saovv2mzpWEy7dDWBhYklwud/dvg3ZuR4Cz7zDd5N15is/8jlLWckaoKKVmOH
         u0KNqnOu9I5w1BdtJwNPV8LWpjezny4/xM7/kHwTknznwfd9+vzefnQN97z+isBitpog
         aMupXXpwFxXjN6yayfOn0Ch0nKBOYnfz9QKLol4ceq7XkDu45o5MMgJVV6bHvRm3H3bv
         ocFgXBk64lsUR++t3ykM+gNbywR7kJBgDd2M1Gybk9bff/WauXkKXQx5+agmzpYToVq+
         n9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711243503; x=1711848303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzkhJwRQhOpnuxfYahJxkJR2Jm2xIqxG//Pzm2qwvz8=;
        b=iycuvSBc2/Sm76IK/83wvOVM5r2D09ovI4SwT/bVQw6ISxX/a2MlYv8DhdC9bVSERA
         z7O8wGNTElNzA9JWVAY3wlii8k6Hmx2A3oSjQnKX5jRWBIZrQ5/TQd7520vEPV/a/PJC
         ynB+7ZbY4yIjHdCwJGkQVZvb7M0/z77dGPWFe8Pr86YZHvSZwlBpygH02lXM4XOcAXq3
         hVXIt9CeaV8AKk3RSpEKzp8PeaEEqypgXIArLVDwM0COFMj5JbeJoeCRurl2zkrfjuru
         XMj0it5cQ4w2VDX+mXIeo7+s35bl0d7l9UXUDNDMTwoyrKBKd/CjYI4ctylWaEoj+4JA
         8yDw==
X-Forwarded-Encrypted: i=1; AJvYcCUnSE3ioShpD98qxMWf+GHlhJ7Y5r9dyM1ehCoXyCrpUsjfNWFZ+70ADrq3pOgPn9lIXitJJtqDIqMxQYVYiu/FyrXRN4+WJPkx+vpZ
X-Gm-Message-State: AOJu0YzoVYjwjluOwXGW7FXjOnLvDq2x9+A1xWSOGSlP54CKhDIHvHSs
	fSh/UMyX0/zHGMip+yumYSu1nzebgFC/Muv5d+j6BQHW0DxzFi78FEqtOuwHSWk=
X-Google-Smtp-Source: AGHT+IFF+lye/rdq8D9ARjDal8stTvsLUFgpD0E23JVfqmmpnnP960+SS+4KzaoTP/zPBnjkrzjPew==
X-Received: by 2002:a17:90a:f683:b0:2a0:569f:fa92 with SMTP id cl3-20020a17090af68300b002a0569ffa92mr2759903pjb.0.1711243503151;
        Sat, 23 Mar 2024 18:25:03 -0700 (PDT)
Received: from x1 ([2601:1c2:1802:170:66c8:e9a6:59a1:e5e2])
        by smtp.gmail.com with ESMTPSA id kx16-20020a17090b229000b0029b77fbeb7fsm7815393pjb.16.2024.03.23.18.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 18:25:02 -0700 (PDT)
Date: Sat, 23 Mar 2024 18:25:00 -0700
From: Drew Fustini <drew@pdp7.com>
To: Maxim Kiselev <bigunclemax@gmail.com>
Cc: xry111@xry111.site, Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org,
	dfustini@baylibre.com, guoren@kernel.org, jkridner@beagleboard.org,
	jszhang@kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	robertcnelson@beagleboard.org, Rob Herring <robh+dt@kernel.org>,
	wefu@redhat.com
Subject: Re: [PATCH v8 4/4] riscv: dts: thead: Enable LicheePi 4A eMMC and
 microSD
Message-ID: <Zf+A7KEYL/tZb9/N@x1>
References: <CALHCpMhc1F5Ue7U_gsDXREHUZRVQJNYRCJxYxoNqbN=-39jf7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALHCpMhc1F5Ue7U_gsDXREHUZRVQJNYRCJxYxoNqbN=-39jf7A@mail.gmail.com>

On Wed, Mar 20, 2024 at 03:28:19PM +0300, Maxim Kiselev wrote:
> Hi Xi, Drew
> 
> I have the same problem with SD on my LicheePi 4A.
> 
> After some investigations I found how to fix this tuning error.
> Here is the patch that increases tuning loop count from
> 40(MAX_TUNING_LOOP at sdhci.c) to 128.
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c
> b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 8d6cfb648096..da8f5820fb69 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -706,6 +706,7 @@ static int th1520_execute_tuning(struct sdhci_host
> *host, u32 opcode)
> 
>         /* perform tuning */
>         sdhci_start_tuning(host);
> +       host->tuning_loop_count = 128:
>         host->tuning_err = __sdhci_execute_tuning(host, opcode);
>         if (host->tuning_err) {
>                 /* disable auto-tuning upon tuning error */
> 
> After that change tuning works fine. The same value of loop count is
> used in RevyOS BSP
> https://github.com/revyos/thead-kernel/blob/c6d4e5df18a17903d012ffd89e67d0ee5ce6cf2d/drivers/mmc/host/sdhci-of-dwcmshc.c#L185
> 
> Honestly, it looks a little bit strange for me.
> 
> It seems that the tuning algorithm requires to move through
> all the taps of delay line(128 taps?) even if we use THRESHOLD_MODE
> instend LARGEST_WIN_MODE (I mean bit 2 in AT_CTRL_R(0x540) register).
> 
> Xi, could you also test my fix on your board?

Thanks for figuring this out!

When I was upstreaming support, I noticed __sdhci_execute_tuning() in
T-Head's version of sdhci-of-dwcmshc.c seemed to duplicate what already
existed in drivers/mmc/host/sdhci.c. I had thought T-Head copied it
because it was a static function.

9cc811a342be ("mmc: sdhci: add __sdhci_execute_tuning() to header")
allowed me to remove __sdhci_execute_tuning() from sdhci-of-dwcmshc.
However, I overlooked this resulted in changing the tuning loop from
128 back to the upstream default of 40.

Before this change, the microSD did work for me on the lpi4 but I would
see the following:

[    4.182483] mmc1: Tuning failed, falling back to fixed sampling clock
[    4.189022] sdhci-dwcmshc ffe7090000.mmc: tuning failed: -11
[    4.194734] mmc1: tuning execution failed: -5
[    4.287899] mmc1: new high speed SDHC card at address aaaa
[    4.299763] mmcblk1: mmc1:aaaa SD32G 29.7 GiB
[    4.316963]  mmcblk1: p1 p2

root@lpi4amain:~# cat /sys/kernel/debug/mmc1/ios
clock:		50000000 Hz
actual clock:	49500000 Hz
vdd:		21 (3.3 ~ 3.4 V)
bus mode:	2 (push-pull)
chip select:	0 (don't care)
power mode:	2 (on)
bus width:	2 (4 bits)
timing spec:	2 (sd high-speed)
signal voltage:	0 (3.30 V)
driver type:	0 (driver type B)

With the change to 128, I no longer see the tuning failure and the
microSD continues to work okay:

[    4.307040] mmc1: new ultra high speed SDR104 SDHC card at address aaaa
[    4.320462] mmcblk1: mmc1:aaaa SD32G 29.7 GiB
[    4.338646]  mmcblk1: p1 p2

root@lpi4amain:/sys/kernel/debug/mmc1# cat ios
clock:		198000000 Hz
actual clock:	198000000 Hz
vdd:		21 (3.3 ~ 3.4 V)
bus mode:	2 (push-pull)
chip select:	0 (don't care)
power mode:	2 (on)
bus width:	2 (4 bits)
timing spec:	6 (sd uhs SDR104)
signal voltage:	1 (1.80 V)
driver type:	0 (driver type B)

This has the benefit of the card now works at 198 MHz in SDR104 mode
instead of 50 MHz when tuning failed.

Tested-by: Drew Fustini <drew@pdp7.com>

thanks,
drew


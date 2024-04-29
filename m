Return-Path: <linux-kernel+bounces-162564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 738DF8B5D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010331F214CF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5EA81723;
	Mon, 29 Apr 2024 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nd0Xyy12"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F66C81745;
	Mon, 29 Apr 2024 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403977; cv=none; b=C58NbrrSF15rEjcivRREVx+GTGZHXzwc4dN2uEEIQmCi092IAhksYFJxOC2RUSZOxGeCfNFbgT+kN5t2ocyQHI6CESIcL77n6RYCIk4vCt0qJBxfu322MiLyiRGs1GqlaNKwviAwBc48dTRhUeb+bFfbMYTClPwh5+IDNoIttro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403977; c=relaxed/simple;
	bh=Lq3bIjU4eSarBTAXtS8WyC+NFdUGRQk6vzmvx4W4Ff4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOrkxyVL23l3BEklKsEbL69azSMSTksib1jKDSPFJwxIC1JTdDaxZ7DjwGUqu9zH1YGpx8SYrq78sIRSany/5ZN1TWhMOTkJ+AEJWbOJR8qhKsmS3o3K7eS03Z7KeqvQviNMf3LrBudapKHDd7c5tau43RHq07RbjF+hg0Di7bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nd0Xyy12; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57222fc625aso5189688a12.3;
        Mon, 29 Apr 2024 08:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714403972; x=1715008772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9C3JVcEDpwsOADlHUtbqCqSAuCy7fwWOq+zvdoWz3k=;
        b=nd0Xyy12y19RtvAZgY7lPbrKCM8wwgGaoeF1kFwy5I9v7kNin98/y9qhAEu1kZV5Q+
         wPZS49MpVS3Xd9BPFgfiK5sWe1TF9docmjWJXYnpGy52VrI74ErGGMnzZSqhHD9TxzeM
         /PfMICIIPahFjgdCZAbIJhOANdnPuOfjOl56g8gnX3qTMKf/hkv1hHriQuY48WAMwGH6
         vUoVCjyFIVVFXvliwpNZ9aofuUn10i+NPsJ6myYDBCp4vOfx3vbpISxExbGv7l/A8qNf
         A0ALgZdsvD/fSCT4EtNmvhN0uo+jwiH+8yCB8lIs19o6PH8oXNXsVygVQZAGtWG2cRxQ
         E2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714403972; x=1715008772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9C3JVcEDpwsOADlHUtbqCqSAuCy7fwWOq+zvdoWz3k=;
        b=XJCoQS1iKAPUdLuxEyEJWDjxJVfLANroxWfURh+9G0Ie0oo19qKdzHd/Wh630PXGgt
         zC9gogO2h1hugKdegxWAo3TOqaMcAD4YhzV2WRIu19liaNRWF2kcmAAknfnUtgmeh2TH
         /iVwXNcTsyIyP+hcIr0qBhoEO6bwgpV91itslTeO6faG0i6DT16NENKPYOSC9v1u58IO
         a/x0gSX0VfPHi8ZRhSb+cRXzO5XoAQLPrz2BE9fPWoBo0prZle+pLNDmsxlm39bpMtIB
         DXLOKAhESUpO0ltXf69coL5AFPmKYS3DgMjr2gx/6XXgIeBDXtk7Qipw5I9mM4kXrxMp
         0KMA==
X-Forwarded-Encrypted: i=1; AJvYcCUjxjij9F6vhReII5pQsluxDVo9FdnKfc74Q65mJsqUp2IHCgMtFOUSkka2pTJD86RmDt15A+2znuQVV6s5tUzVAuH1wOv12hu4LpD+
X-Gm-Message-State: AOJu0YwibKyJUIGoDTqqWYU7fWhtTGaCdd2+LKdm8y8JUKPC9M3c8r8Y
	EuQXF9mVo3rM612BCEk/dIzXYOoUEefPCtdsg7b8nL5i3b+ZC+wLAi+VUlti
X-Google-Smtp-Source: AGHT+IG9T5aL2XPvLCDwTfqYe8F/ZRUPCN2K8XAmythmr2DqFYhUB73oLbiJ/x39cBvXRLd32dGw9g==
X-Received: by 2002:a05:6402:1d9b:b0:572:664c:83f2 with SMTP id dk27-20020a0564021d9b00b00572664c83f2mr5493405edb.27.1714403972190;
        Mon, 29 Apr 2024 08:19:32 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id es21-20020a056402381500b005725c56b35bsm3568025edb.71.2024.04.29.08.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:19:31 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-spi@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 6/8] spi: sun4i: use 'time_left' variable with
 wait_for_completion_timeout()
Date: Mon, 29 Apr 2024 17:19:30 +0200
Message-ID: <4560843.LvFx2qVVIh@jernej-laptop>
In-Reply-To: <20240429112843.67628-7-wsa+renesas@sang-engineering.com>
References:
 <20240429112843.67628-1-wsa+renesas@sang-engineering.com>
 <20240429112843.67628-7-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne ponedeljek, 29. april 2024 ob 13:28:39 GMT +2 je Wolfram Sang napisal(a):
> There is a confusing pattern in the kernel to use a variable named 'timeout' to
> store the result of wait_for_completion_timeout() causing patterns like:
> 
> 	timeout = wait_for_completion_timeout(...)
> 	if (!timeout) return -ETIMEDOUT;
> 
> with all kinds of permutations. Use 'time_left' as a variable to make the code
> self explaining.
> 
> Fix to the proper variable type 'unsigned long' while here.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/spi/spi-sun4i.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index 11d8bd27b3e9..2ee6755b43f5 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -206,7 +206,8 @@ static int sun4i_spi_transfer_one(struct spi_controller *host,
>  				  struct spi_transfer *tfr)
>  {
>  	struct sun4i_spi *sspi = spi_controller_get_devdata(host);
> -	unsigned int mclk_rate, div, timeout;
> +	unsigned int mclk_rate, div;
> +	unsigned long time_left;
>  	unsigned int start, end, tx_time;
>  	unsigned int tx_len = 0;
>  	int ret = 0;
> @@ -327,10 +328,10 @@ static int sun4i_spi_transfer_one(struct spi_controller *host,
>  
>  	tx_time = max(tfr->len * 8 * 2 / (tfr->speed_hz / 1000), 100U);
>  	start = jiffies;
> -	timeout = wait_for_completion_timeout(&sspi->done,
> -					      msecs_to_jiffies(tx_time));
> +	time_left = wait_for_completion_timeout(&sspi->done,
> +						msecs_to_jiffies(tx_time));
>  	end = jiffies;
> -	if (!timeout) {
> +	if (!time_left) {
>  		dev_warn(&host->dev,
>  			 "%s: timeout transferring %u bytes@%iHz for %i(%i)ms",
>  			 dev_name(&spi->dev), tfr->len, tfr->speed_hz,
> 






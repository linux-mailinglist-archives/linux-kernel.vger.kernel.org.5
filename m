Return-Path: <linux-kernel+bounces-121928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B64F88EF98
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A9771C2B718
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4257E152195;
	Wed, 27 Mar 2024 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBxovmex"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE86712D20E;
	Wed, 27 Mar 2024 19:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569217; cv=none; b=B+wH0NArVB61kwNi4K0QoxvYOowtsL7pm3t07jTcLV09s62tT+cBup2BtzQdPL4crduhz0iCVqr3WA/s5/tJ92v+uc+vf9sfVaeLsNY7l61tgY3KM+UtY3QW2lhRjAWeNPrIV2JD56bWuwXo3Ug1iYl3KeEEMXXtZRo41haBImI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569217; c=relaxed/simple;
	bh=ljsJCTmbqL+1Z6c/Njgs93wJGruVEOG6LewDHWZFBDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cnfOO5CqIeLxCmWGZO7H51abLRgUAKiz+DtHlZ6gWMK6euSAkr5wQM091aGMGLDNFpqeWR7ONtWTV7kkSMW3tlnpAQF6ok0RV6eMN5733BO8RX9SGPZFi+yUhzL5dTnHh6qR1KOCbh3RynORpa0a91Hla87vF+ZQ6EmmR8I7qMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBxovmex; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a4715d4c2cbso25575066b.1;
        Wed, 27 Mar 2024 12:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711569214; x=1712174014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdNTF6Kva1P11bABP85E0dh07br2jNGfWJsQyRATEsM=;
        b=BBxovmexgv30ZJIVg5EEmg+uWauTEJL69vbzUan6S9sbJaNDpenARGmsRA+rdRZavr
         7C7VoxGMnl7d54noop4+DmQF/xpN6/7obKcUpdBpZaurnxVJJKCcahsSVvnj5Di7uzd1
         NHPDH5X4A7tARUGSAY+6BCPP7N0qU7WXZ+r9DEzT1egYB60V3V1Qxe0di1Q0s6XmOU9z
         lQZltl224I46JOXLQQgbH3DyT/ygt/nG6D/zSoWxn5XOfPbUWyVnnwnpUIzzBhRIi6Qh
         A+G4OCrN/HJrCHPYgbSEXqqzfXV2dANoBxP32OEkFu+VCL/FSxgUdKICKtpHf6ZbQhQ3
         /J+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711569214; x=1712174014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdNTF6Kva1P11bABP85E0dh07br2jNGfWJsQyRATEsM=;
        b=UXGT0mSqUOXlAsQzMq70a92xPsq9xUjfB1JITq1c+uHibznRN45p9UOKahYEi64keI
         xl/qX/kHeqIg0D/ni3uzRFGU3OUsjhdp+Y57liMXmP8D3NMqs2VT6wsV+A9IGX7NM4f1
         HyrrnTiNovohfXhkLwqNsGHmy/0BvKBn0+xOFGNBY09HYpjSBTBlGH6qyeinWHw9wZh4
         PTj0sl818M02wjKHgh8mD+VKAlDRdvqaJ92SQjB7fP57ppRHHmf+5sRcna9TtsAWHs3E
         jqyO/1VgM9q0dIRaFPyPYWTKwa/vMoS2Dp4wdRgi3yyLQBNOS9fNS9oFhRBtlR26e85Q
         W4jw==
X-Forwarded-Encrypted: i=1; AJvYcCUiJygnoIEYvHH8v1ugTetDDZnxNPv1yLwY10r9Phq4SjgU+Z1YIOEeSCOIpVyzyHdSLQ7+wLOjFkC8hrXwDu9iZzEs5eR5QurpdccD
X-Gm-Message-State: AOJu0YzJrl/v21s7zuy/VPtaOnBzNZnmkvIaM7A5TuYtpk81IWYoWZZB
	MWQ8T/BH2QNlhcB7w/O9y42jwUjJeTDz4TpR9Lxe7c+oS2zvlhPHonFitEdJkk0=
X-Google-Smtp-Source: AGHT+IEJHCTAYc5wMgN6Si7Qw5l/pWCJQkkzN4bIwHlGrIGZr8/mrHXa8XC/hK8xrg65wMHL8M4lnw==
X-Received: by 2002:a17:906:e59:b0:a4e:a7a:84e0 with SMTP id q25-20020a1709060e5900b00a4e0a7a84e0mr335504eji.34.1711569213895;
        Wed, 27 Mar 2024 12:53:33 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id z11-20020a1709060acb00b00a4733982ba9sm5757294ejf.160.2024.03.27.12.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 12:53:33 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 John Watts <contact@jookia.org>
Cc: linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 John Watts <contact@jookia.org>
Subject: Re: [PATCH] ASoC: sunxi: sun4i-i2s: Enable 32-bit audio formats
Date: Wed, 27 Mar 2024 20:53:32 +0100
Message-ID: <23447395.6Emhk5qWAg@jernej-laptop>
In-Reply-To: <20240326-sunxi_s32-v1-1-899f71dcb1e6@jookia.org>
References: <20240326-sunxi_s32-v1-1-899f71dcb1e6@jookia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne torek, 26. marec 2024 ob 04:50:03 CET je John Watts napisal(a):
> The I2S driver already supports and checks for 32-bit sample sizes,
> so indicate this size is available for use in the DAI driver.
> 
> This change has been tested on the T113-S3, but it should work just
> fine on older hardware as get_sr checks for sample size support
> correctly according to each core's datasheet.
> 
> Signed-off-by: John Watts <contact@jookia.org>
> ---
> This patch enables support for 32-bit audio in the sunxi I2S driver.
> 
> I have only tested this on the Allwinner T113 but I'm fairly
> certain it will work on older boards.
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index a736f632bf0b..aeea852141c1 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -1103,7 +1103,8 @@ static const struct snd_soc_dai_ops sun4i_i2s_dai_ops = {
>  
>  #define SUN4I_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
>  			 SNDRV_PCM_FMTBIT_S20_LE | \
> -			 SNDRV_PCM_FMTBIT_S24_LE)
> +			 SNDRV_PCM_FMTBIT_S24_LE | \
> +			 SNDRV_PCM_FMTBIT_S32_LE)

I wish it would be that simple. SUN4I_FORMATS is cross section of all I2S
variants that are supported by this driver. If you check A10, you'll see that
it doesn't support S32.

If you want to add support for S32, you'll have to add new quirk for each
variant.

Best regards,
Jernej

>  
>  static struct snd_soc_dai_driver sun4i_i2s_dai = {
>  	.capture = {
> 
> ---
> base-commit: 72fb52fb0ac44b6a1edd9bc390e44bce3acccd26
> change-id: 20240326-sunxi_s32-f2ab25b8e688
> 
> Best regards,
> 






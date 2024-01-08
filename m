Return-Path: <linux-kernel+bounces-20122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A28D8827A06
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 22:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3987328509B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C282055E7E;
	Mon,  8 Jan 2024 21:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ycR7xWHR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B267256442
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 21:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-467021612acso344865137.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 13:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704748324; x=1705353124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YBGJtvh92bb/MQJAenOPY/iQdorsefTTda6AN+tF6dQ=;
        b=ycR7xWHRYKszqBr4SqRWaE+NQH41ZzUWB7v8aYV9MoSr6Qv/ymtz/4CE6k2AfNXXXu
         IyoERCZ0NPcR4yJotJr+fzZvD5gBODlrsso8A02wLHOlXamaXoU6ifpeQYNeqn1CFfLU
         vlfsbyddCTV5N6U2zeE1f7gINpwYeaM+zqJE1X43os3iAXcDLh0a/utlVHpFJUzyq6ZV
         a4/MXsUZCQVRh6031Z9o4rNvhrItRFeshED4q9GWAD4M8ZJm9oBXaimwOXIe39Iq7QI5
         XoNy2JCu790UxU3fuDE8cRE/Ju20wiPTtfNMAXMLARDj6vXkY1z0bOUjc8246ogG/t5s
         sQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704748324; x=1705353124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBGJtvh92bb/MQJAenOPY/iQdorsefTTda6AN+tF6dQ=;
        b=SoAAlcSBX/jDSCLxqwQ0pbYFVNMbVhOg1BG4EA8mFTUmDJIzAjHUg2GkJdVMO1s34X
         skjGZMAd2gm8oqxN2izm1ZALlHAScNBRr7JujL0U20eh+h2L8QA2gfDkeinUvnrz4E92
         mfOogENtNguFQ+uIVEsUFOGeKaxSJq2PS3m38TErWzaBdE8oMwkK3tvLK9pmJN4jpmdJ
         8aFAs7kc+ENL5dOcpyiX1yQc8/lcfZskn8e378ukDQWp+FZRDJQgAZFuNSwHNmIqvHwl
         JyjavOJ8UnUFsiuiY7jSD79L4M4blJ6Ihbgrs8BTMbgmNOGHgioEEEP9quKoVW/gEnjC
         tPYg==
X-Gm-Message-State: AOJu0Ywy9Nsw8XseCvj0ZqW/U+PldcSCm9yX4e269fF4Ii7rd+ujKkq/
	TCDSprDGUjBBln5HMZq3TfPxzc6xJQ78Ig==
X-Google-Smtp-Source: AGHT+IH3EQQvsaMhKI85+JDKyxLi0PolQ2SDP4LRpa4fw3WIbC3ZktiUYL5iLbnJ2jlU4GzE/GMXnw==
X-Received: by 2002:a05:6102:158e:b0:467:da9e:3bd0 with SMTP id g14-20020a056102158e00b00467da9e3bd0mr929523vsv.23.1704748324588;
        Mon, 08 Jan 2024 13:12:04 -0800 (PST)
Received: from ubuntu-server-vm-macos (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id g19-20020a05610209d300b0046695b658dcsm92939vsi.30.2024.01.08.13.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 13:12:04 -0800 (PST)
Date: Mon, 8 Jan 2024 21:06:52 +0000
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, alexandre.torgue@foss.st.com, linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/10] counter: stm32-timer-cnt: add support for
 overflow events
Message-ID: <ZZxj7BpXFyGbcrpi@ubuntu-server-vm-macos>
References: <20231220145726.640627-1-fabrice.gasnier@foss.st.com>
 <20231220145726.640627-10-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eTyfW+fM+V9Seofn"
Content-Disposition: inline
In-Reply-To: <20231220145726.640627-10-fabrice.gasnier@foss.st.com>


--eTyfW+fM+V9Seofn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 20, 2023 at 03:57:25PM +0100, Fabrice Gasnier wrote:
> diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
> index ca35af30745f..9eb17481b07f 100644
> --- a/include/linux/mfd/stm32-timers.h
> +++ b/include/linux/mfd/stm32-timers.h
> @@ -41,6 +41,11 @@
>  #define TIM_SMCR_SMS	(BIT(0) | BIT(1) | BIT(2)) /* Slave mode selection */
>  #define TIM_SMCR_TS	(BIT(4) | BIT(5) | BIT(6)) /* Trigger selection */
>  #define TIM_DIER_UIE	BIT(0)	/* Update interrupt	   */
> +#define TIM_DIER_CC1IE	BIT(1)  /* CC1 Interrupt Enable    */
> +#define TIM_DIER_CC2IE	BIT(2)  /* CC2 Interrupt Enable    */
> +#define TIM_DIER_CC3IE	BIT(3)  /* CC3 Interrupt Enable    */
> +#define TIM_DIER_CC4IE	BIT(4)  /* CC4 Interrupt Enable    */
> +#define TIM_DIER_CC_IE(x)	BIT((x) + 1) /* CC1, CC2, CC3, CC4 interrupt enable */
>  #define TIM_DIER_UDE	BIT(8)  /* Update DMA request Enable */
>  #define TIM_DIER_CC1DE	BIT(9)  /* CC1 DMA request Enable  */
>  #define TIM_DIER_CC2DE	BIT(10) /* CC2 DMA request Enable  */
> @@ -49,6 +54,7 @@
>  #define TIM_DIER_COMDE	BIT(13) /* COM DMA request Enable  */
>  #define TIM_DIER_TDE	BIT(14) /* Trigger DMA request Enable */
>  #define TIM_SR_UIF	BIT(0)	/* Update interrupt flag   */
> +#define TIM_SR_CC_IF(x)	BIT((x) + 1) /* CC1, CC2, CC3, CC4 interrupt flag */
>  #define TIM_EGR_UG	BIT(0)	/* Update Generation       */
>  #define TIM_CCMR_PE	BIT(3)	/* Channel Preload Enable  */
>  #define TIM_CCMR_M1	(BIT(6) | BIT(5))  /* Channel PWM Mode 1 */
> @@ -60,16 +66,23 @@
>  #define TIM_CCMR_CC1S_TI2	BIT(1)	/* IC1/IC3 selects TI2/TI4 */
>  #define TIM_CCMR_CC2S_TI2	BIT(8)	/* IC2/IC4 selects TI2/TI4 */
>  #define TIM_CCMR_CC2S_TI1	BIT(9)	/* IC2/IC4 selects TI1/TI3 */
> +#define TIM_CCMR_CC3S		(BIT(0) | BIT(1)) /* Capture/compare 3 sel */
> +#define TIM_CCMR_CC4S		(BIT(8) | BIT(9)) /* Capture/compare 4 sel */
> +#define TIM_CCMR_CC3S_TI3	BIT(0)	/* IC3 selects TI3 */
> +#define TIM_CCMR_CC4S_TI4	BIT(8)	/* IC4 selects TI4 */
>  #define TIM_CCER_CC1E	BIT(0)	/* Capt/Comp 1  out Ena    */
>  #define TIM_CCER_CC1P	BIT(1)	/* Capt/Comp 1  Polarity   */
>  #define TIM_CCER_CC1NE	BIT(2)	/* Capt/Comp 1N out Ena    */
>  #define TIM_CCER_CC1NP	BIT(3)	/* Capt/Comp 1N Polarity   */
>  #define TIM_CCER_CC2E	BIT(4)	/* Capt/Comp 2  out Ena    */
>  #define TIM_CCER_CC2P	BIT(5)	/* Capt/Comp 2  Polarity   */
> +#define TIM_CCER_CC2NP	BIT(7)	/* Capt/Comp 2N Polarity   */
>  #define TIM_CCER_CC3E	BIT(8)	/* Capt/Comp 3  out Ena    */
>  #define TIM_CCER_CC3P	BIT(9)	/* Capt/Comp 3  Polarity   */
> +#define TIM_CCER_CC3NP	BIT(11)	/* Capt/Comp 3N Polarity   */
>  #define TIM_CCER_CC4E	BIT(12)	/* Capt/Comp 4  out Ena    */
>  #define TIM_CCER_CC4P	BIT(13)	/* Capt/Comp 4  Polarity   */
> +#define TIM_CCER_CC4NP	BIT(15)	/* Capt/Comp 4N Polarity   */

I forgot to mention that you should move the introduction of these
defines to the subsequent patch adding support for capture events
because that's where the defines are actually used.

William Breathitt Gray

--eTyfW+fM+V9Seofn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZZxj7AAKCRC1SFbKvhIj
K+hKAQDcvx+8TB+sVsYW8HmeYUBMwLZvZN/fvDizKykS/fZDcQD+JaDR+HGTgp3B
Lc5+qDJlEopQuesY+K90Tw2taDDrxQY=
=S2kh
-----END PGP SIGNATURE-----

--eTyfW+fM+V9Seofn--


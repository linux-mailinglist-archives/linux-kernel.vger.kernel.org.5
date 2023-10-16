Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1213E7C9EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjJPFj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjJPFj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:39:26 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7958D9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 22:39:21 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-405524e6768so39404545e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 22:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697434760; x=1698039560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SAhyhyywQsJApEGes0Z+kLzxA9BFQIkO86pnB4KjlYM=;
        b=GHsYBy+o0PX9OOTjy83gK5JqD3Oeb+TpMfdyU1gGxduAlwFpmkLtVcEeU/rghz8xCY
         Wdui7xhzGDU4RJ1DXqrWr1USST+ZztKhBl1Sc2RxSgNyXSjOgqGqSim4Ny+tVusE0SCv
         TFDFEy0sPnRBBQFEcmmaHO9JCG0r3jE7Ikrj21PBbHvCRxzPwuCaws09snaeZbtBMvnu
         72s9cy/cTOWEMEbAg1JE47BbEeKc5HPJvR4SX4F3txuEKxxhUuAgeDo7CVf49cHuyLUp
         G0spAybCD91cuI7jQvcqjE7gkCZsYYqy5jad9IpUn/QqbKPOrLQ0m8eoHhnhmcSIYC6x
         1WyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697434760; x=1698039560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAhyhyywQsJApEGes0Z+kLzxA9BFQIkO86pnB4KjlYM=;
        b=OZebfE63S1czVTOR/HzFdwIXZssqhTI/E2wrEyHaLRrnOCKPhZqSnQfO5JelUioP1/
         hnMAlGFFvBBfdrYQDTEGJ0txueTHhD3Jm/TpZyv/gHrCyuBWrbDC7G1Wbr9GwK5W6fdE
         sPmZ9u1iT3ExAfZ79ApcML8MBnAf8Zb7o4K+5KWlY4w1evVXVr08YsooR1gchmtKiQX0
         JvLPE4kgW/mbYPTOKaLjq2fRrOjtxD7XgAwadVqopsCL3GaPOCxfkBWgGdrjZxEyxD4q
         D9lekLMq5nMJGHpNnlbPVgoim6p0GanMpi4TMRSGDa9k8RCcBG+omCKjk18RerEi2QzW
         Nq/Q==
X-Gm-Message-State: AOJu0YzKnYAVSGhaaJHtj3wrhnwKlDVw3KZiAuBKJK2NOOlLjLnKZ1a7
        XITSUljN9/3smBLUG40RPFTvEg==
X-Google-Smtp-Source: AGHT+IHHH39CYBAqvsSK1af/YmT2zspK8LPta7U0tTel7SK8+/JS/p2F4kC53nRhcqFg6aa5y5joRg==
X-Received: by 2002:adf:ea42:0:b0:32d:a57b:8c8e with SMTP id j2-20020adfea42000000b0032da57b8c8emr4192772wrn.53.1697434760301;
        Sun, 15 Oct 2023 22:39:20 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e28-20020adfa45c000000b0032d892e70b4sm12196991wra.37.2023.10.15.22.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 22:39:19 -0700 (PDT)
Date:   Mon, 16 Oct 2023 08:39:16 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Gilbert Adikankwu <gilbertadikankwu@gmail.com>
Cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192u: Align descendant arguments
Message-ID: <3620a5eb-34d8-49ae-a925-66f85a62e09c@kadam.mountain>
References: <ZSuYUmX5P5M0Ok/I@gilbert-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSuYUmX5P5M0Ok/I@gilbert-PC>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2023 at 08:44:18AM +0100, Gilbert Adikankwu wrote:
> diff --git a/drivers/staging/rtl8192u/r8190_rtl8256.c b/drivers/staging/rtl8192u/r8190_rtl8256.c
> index 54747fda552f..a81e88894e01 100644
> --- a/drivers/staging/rtl8192u/r8190_rtl8256.c
> +++ b/drivers/staging/rtl8192u/r8190_rtl8256.c
> @@ -46,17 +46,17 @@ void phy_set_rf8256_bandwidth(struct net_device *dev, enum ht_channel_width Band
>  				    priv->card_8192_version == VERSION_819XU_B) {
>  					/* 8256 D-cut, E-cut, xiong: consider it later! */
>  					rtl8192_phy_SetRFReg(dev,
> -						(enum rf90_radio_path_e)eRFPath,
> -						0x0b, bMask12Bits, 0x100); /* phy para:1ba */
> +							     (enum rf90_radio_path_e)eRFPath,
> +							     0x0b, bMask12Bits, 0x100); /* phy para:1ba */

These ones go too long indented like this.  The other sections are fine
but just leave leave this file as it was.

regards,
dan carpenter

>  					rtl8192_phy_SetRFReg(dev,
> -						(enum rf90_radio_path_e)eRFPath,
> -						0x2c, bMask12Bits, 0x3d7);
> +							     (enum rf90_radio_path_e)eRFPath,
> +							     0x2c, bMask12Bits, 0x3d7);
>  					rtl8192_phy_SetRFReg(dev,
> -						(enum rf90_radio_path_e)eRFPath,
> -						0x0e, bMask12Bits, 0x021);
> +							     (enum rf90_radio_path_e)eRFPath,
> +							     0x0e, bMask12Bits, 0x021);
>  					rtl8192_phy_SetRFReg(dev,
> -						(enum rf90_radio_path_e)eRFPath,
> -						0x14, bMask12Bits, 0x5ab);
> +							     (enum rf90_radio_path_e)eRFPath,
> +							     0x14, bMask12Bits, 0x5ab);
>  				} else {
>  					RT_TRACE(COMP_ERR, "%s(): unknown hardware version\n", __func__);
>  					}


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0D47EDD4F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbjKPJD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjKPJD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:03:56 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F966A1;
        Thu, 16 Nov 2023 01:03:53 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5ab94fc098cso404509a12.1;
        Thu, 16 Nov 2023 01:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700125433; x=1700730233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=El/JfzGdZ4cMju9ybKXdrUj42W3161BOT77MsxODMx8=;
        b=SJfy8Dk2PNOzId9DBNElQjRhRrrvFXp2Hz652mR8k+QC2ThKaUUrrU07tqTU/ZBK7s
         sqy+pJawSnfUVRnNji8pK7Opi1jE6ynFbX5veXfB1ox1P8ISRhVcuNzWOfCgLUoNQshk
         T4b6K+6mRNbt6GYxTZ2P/UJ7GLqjM+z6gVHJONfB+oa79mQF4h3yAHKLk8Xa6jxtpKAw
         rNXOGCHhcawFzanD3dSJrOCQri1WqYYh1vfRgTXFm10vkRr3hBzttbwLmIvt1X+Dtb2L
         HSPSwYVRXLiv5uRr10hFI/fbWgyC9x15Vh8TgpjXqoWulrfz1XtXSQW/01NMMmx1TjYO
         O+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700125433; x=1700730233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=El/JfzGdZ4cMju9ybKXdrUj42W3161BOT77MsxODMx8=;
        b=kJ3mF3V1IznO2M2F3m4yRAFX8CZRiimh6QFaGCN5s4Tf+4s6rGYId4YTPjIIOzEUxP
         ivZfVjS61MGKWVfb58UY7O/HEo12LWVXXMeEaxV24dA3/PVHHnHpFbhwnmX+c0vtcEg4
         URGCwBHPt2SPOsB8Kc8d2vQk9ok8g4f1o8SPE5okRcDftND25kSn1ETYUeeSaejUA26h
         1HesAumn6DuezdFPu8L6apCgOUtAZWGP1wdru4Tce0+Gd5UMGCFVmIvyxoYPvzyoiPqo
         bYvQHPwCEi0Bfi0y0f20S8yADu3aDTdPJWiIW2d/8THSgWkrzIAcJYS/cljeqQ8cBWhJ
         vtAg==
X-Gm-Message-State: AOJu0YwCTfu6cb2qCekQ16V9cpeALFHB8d6yMO6EoRhm251XUOHCzgJS
        qKYCIbovc5EzmJYuQK5kEIaFPOprj/A=
X-Google-Smtp-Source: AGHT+IE+XnVtHVDDLImPTdv+2cnMqX8bIVDLZFUPG6yE3ukBY7Txy26hFOCQSLLo5BZbUnIOQ8uFLA==
X-Received: by 2002:a17:902:dad1:b0:1cc:70e4:28c7 with SMTP id q17-20020a170902dad100b001cc70e428c7mr8844794plx.18.1700125432659;
        Thu, 16 Nov 2023 01:03:52 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j8-20020a17090276c800b001cc52ca2dfbsm8650307plt.120.2023.11.16.01.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 01:03:52 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 16 Nov 2023 01:03:51 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Xing Tong Wu <xingtong_wu@163.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, xingtong.wu@siemens.com,
        tobias.schaffner@siemens.com, gerd.haeussler.ext@siemens.com
Subject: Re: [PATCH 1/3] hwmon: (nct6775) Fix incomplete register array
Message-ID: <0ae18abe-121e-4a1c-a9aa-6b10db0c68d1@roeck-us.net>
References: <20231116022330.2696-1-xingtong_wu@163.com>
 <20231116022330.2696-2-xingtong_wu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116022330.2696-2-xingtong_wu@163.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 10:23:28AM +0800, Xing Tong Wu wrote:
> From: Xing Tong Wu <xingtong.wu@siemens.com>
> 
> The nct6116 specification actually includes 5 PWMs, but only 3
> PWMs are present in the array. To address this, the missing 2
> PWMs have been added to the array.
> 
> Signed-off-by: Xing Tong Wu <xingtong.wu@siemens.com>
> ---
>  drivers/hwmon/nct6775-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
> index d928eb8ae5a3..2111f0cd9787 100644
> --- a/drivers/hwmon/nct6775-core.c
> +++ b/drivers/hwmon/nct6775-core.c
> @@ -769,7 +769,7 @@ static const u16 NCT6106_FAN_PULSE_SHIFT[] = { 0, 2, 4 };
>  
>  static const u8 NCT6106_REG_PWM_MODE[] = { 0xf3, 0xf3, 0xf3 };
>  static const u8 NCT6106_PWM_MODE_MASK[] = { 0x01, 0x02, 0x04 };
> -static const u16 NCT6106_REG_PWM_READ[] = { 0x4a, 0x4b, 0x4c };
> +static const u16 NCT6106_REG_PWM_READ[] = { 0x4a, 0x4b, 0x4c, 0xd8, 0xd9 };

I'll have to check the datasheet if this is generic, but at the very least
it is incomplete and REG_PWM_MODE as well as REG_PWM_MODE_MASK would
have to be updated as well. Also, I don't see an update to has_pwm,
meaning the two additional pwm controls won't ever be used/enabled.

Guenter

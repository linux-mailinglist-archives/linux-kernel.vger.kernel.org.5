Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C1D80B61B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 20:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjLIT3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 14:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLIT3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 14:29:00 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD76B7;
        Sat,  9 Dec 2023 11:29:07 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-67aa00ea853so20421056d6.2;
        Sat, 09 Dec 2023 11:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702150146; x=1702754946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AZjI6eW/j0C4pjx0/V8+b02DUdTKD9CUny5GmPYexxc=;
        b=mYWJbKiswZCqu+xjHSXEKNJ84gThziotmE+0RrfnA3CRgNR5FtMJ8OwfkRiBrSUdTQ
         ehZIQ8GahTuR8KHLhnbOcQLtLWWn1tEebaULe2NpHmperI+14zOvIIF5BgO2mLDWMOi7
         T/0+rc5IeMXFIAa8DQqViF37E+OCdr7lp8845YOumyxGbXOhygV0Y9u0heUDVVxc2/G8
         /eUbnxs9zfR8W50owJp+MsovnvlnKI3jSJ4Wo8XkD71bHAf2JTvKlMfmzNHA9Orb4cNm
         QFb2/u8ZsLbNXY2murOm82G88vLqdmO6ImFsC/Vr0EVQGx5Xf4Uv2AXATTypv4veCGBw
         ZjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702150146; x=1702754946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZjI6eW/j0C4pjx0/V8+b02DUdTKD9CUny5GmPYexxc=;
        b=DaVGJnzn6lJboQS4JfL+9dprnuEbzGFSTSrzgaxRCW0QwzJKjoJyjaEmc5zzcCmsfF
         HXN8SKLPQMfdWY6uLId/GEYx0D5EkgxummR6EOFI613nL9XWsgnq/m5tyA/eGG5HtnXh
         wcV/6YNZEpH0QN/P+eb8AmXx7JjmKhbDtRYk+juRE6i8mVogSVUHhLCnp40UBnlfJ9cc
         ymQWw0cUEMC1uvSPHwjVq+kUMuDKaU/dZ976i+9gmTBbNyngh9jnKnt+K7NvZPCToIjo
         glU37+XvYqxOu0xL1OQo5pXGlwH+obd9t7Gr19R2oj1x71PweU15skOjzzB3B/vT4jnf
         0Bug==
X-Gm-Message-State: AOJu0Yyyvim4cwZoBEiKDV23Nua0hBwV+4UpZdxi5JNXxganB19Uxc+r
        BR94vzSf3UrTC6ROUecoADY=
X-Google-Smtp-Source: AGHT+IGFrpnZiJSQ0VU6Wui/nwJyNhYgaePqWQ1kawPnu209/5DZYJi4ClrTG/rsL4DfUGDaB0hBiw==
X-Received: by 2002:a0c:e9d0:0:b0:67e:c64c:45d3 with SMTP id q16-20020a0ce9d0000000b0067ec64c45d3mr718491qvo.88.1702150146224;
        Sat, 09 Dec 2023 11:29:06 -0800 (PST)
Received: from abdel ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id c10-20020a0ceb4a000000b0067a27108513sm1797168qvq.67.2023.12.09.11.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 11:29:05 -0800 (PST)
Date:   Sat, 9 Dec 2023 14:28:55 -0500
From:   Abdel Alkuor <alkuor@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, lars@metafoo.de, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: temperature: Add AMS AS6200
Message-ID: <ZXS/9+lcD+/ptfKr@abdel>
References: <20231202041651.719963-1-alkuor@gmail.com>
 <20231203-wrecking-sneer-d34f19c39f04@spud>
 <ZW6IqoelmMhTgjgW@abdel>
 <20231206174050.12ad1c98@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206174050.12ad1c98@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 05:40:50PM +0000, Jonathan Cameron wrote:
> On Mon, 4 Dec 2023 21:19:22 -0500
> Abdel Alkuor <alkuor@gmail.com> wrote:
>
Hi Jonathan,
> I'd not noticed this.  Why is this an IIO driver rather than an hwmon one?
> 
> Mostly we do that only for very high accuracy or weird temperature sensors
> (infrared ones for example or things with complex thermocouple handling).
> Simpler devices meant for hardware monitoring type applications typically go
> in hwmon.
> 
> We have the iio to hwmon bridge driver for things that naturally have uses
> where IIO features are needed, but which get used for hwmon sometimes.
> Not sure this is enough IIO focused though, so perhaps list out why you
> think it should be in IIO?
No specific reason. I thought IIO is the de facto for such sensors. I'll
use hwmon instead.

Thanks the clarification.

Abdel

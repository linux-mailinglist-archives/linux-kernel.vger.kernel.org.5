Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793E27DAA96
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 04:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjJ2D0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 23:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2D0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 23:26:32 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DC993;
        Sat, 28 Oct 2023 20:26:30 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-58441865ffaso2141192eaf.1;
        Sat, 28 Oct 2023 20:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698549989; x=1699154789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uRnOiKu4nI2Ad98Fhq/Hp7MEOJFLr/EtLs46UGel2iA=;
        b=h8UPyLTJBk2+k4nCpLx3QDfZLtoPam+mROLh3rlj90Jtz7JuW79vsmRyAhMv7gaSIU
         oC21x+4NouHbKLccEi93UIsJopRE5jyfMOMzo2Fqbv//BcL52Q6be612rI+IY+a3Pj33
         oQPv/1dkTjvMNDAxVaFXgHyiyUQiGB4X9bfmw4cAj+L8OL6SHy1cjcFBOzxezwZDvm9Y
         78B2z8IXf8AidizO/6WbdME7PBZM6VnXsmKyOcHRKs2dXMhWMwwHmsSOYSbPGCcn5Gz5
         7et6Vvh98xVSllSP10g91Eq6S5ucP3E1nhyAeQZ8C3RF+3ADQnaUeoFsOsukK1lW6e4W
         iAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698549989; x=1699154789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRnOiKu4nI2Ad98Fhq/Hp7MEOJFLr/EtLs46UGel2iA=;
        b=oV2ZuES2kon66rlrOeU1FW/GU2xG4cTpdF62EdaJMwZW8qTk+aqlyE+Ca8ngp1QAuH
         gbEdHiKOppOk0OHcEOEte2Y06QOe4yGiU3FBB950rXB0fpk+rMgpoG7fOtfjxGxRmCOl
         epBkSCtl37me0HKiEOmXblL3eQkadTSF2iYTgeYO8G9JYAxeUIZxVM/WtTIEZkPsxH9T
         yaqluB+AAjzyQuGYjtFD5AjyXE9wnFZDhW4m7Y9BMCDGlYtoCQMnpPliim1zeUePnwHR
         breNznQPl0/Surd273tuH2JBNqP2Xq+q0lI6bFwQRBhm6dQE1WxpbwqFyD+hWBnGtBae
         e4iw==
X-Gm-Message-State: AOJu0YxuFGVpBwgLKgJ98tkSlXOaKzVdP5wLezAlN53YdA4HwMdcHrQ7
        ZxvvRLIeXIrD5n1bYfimRAc=
X-Google-Smtp-Source: AGHT+IHZJdq2Kpp+5seJOpPFzrlrJs3ax3hBLtrf0qwiyEAh+NCm2a8Skd3c6XCuCvY7X9R1wMer2Q==
X-Received: by 2002:a05:6358:6f9a:b0:168:e9d2:6568 with SMTP id s26-20020a0563586f9a00b00168e9d26568mr7611380rwn.25.1698549989091;
        Sat, 28 Oct 2023 20:26:29 -0700 (PDT)
Received: from google.com ([205.220.129.30])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902e98b00b001cc0d1af177sm712442plb.229.2023.10.28.20.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 20:26:28 -0700 (PDT)
Date:   Sun, 29 Oct 2023 03:26:06 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Wei-Shih Lin <frank101417@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: Add driver for Novatek NT519XX series
 touchscreen devices
Message-ID: <ZT3QzhXr8OaOCfx2@google.com>
References: <20231025082054.1190-1-Weishih_Lin@novatek.com.tw>
 <20231025082054.1190-3-Weishih_Lin@novatek.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025082054.1190-3-Weishih_Lin@novatek.com.tw>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei-Shih,

On Wed, Oct 25, 2023 at 04:20:54PM +0800, Wei-Shih Lin wrote:
> This patch adds support for Novatek NT519XX series touchscreen devices.
> Existing Novatek touchscreen driver code developed for Acer Iconia One 7
> B1-750 tablet with Novatek IC NT11205 is novatek-nvt-ts.c in the path
> drivers/input/touchscreen/. However, this patch supports touch features
> for automotive display with Novatek TDDI NT519XX.

How different the protocol of this part from NT11205? Can the existing
driver be modified to support both variants?

You already got feedback from Krzysztof, on top of his, if we want to
continue with a separate driver:

- it should use standard device properties
- it should use gpiod API
- it looks like it will benefit of regmap's paging support
- helpers like nvt_irq_enable() should not be used - your code should
  know whether itq is enabled or disabled at all times
- all caps are reserved for macros (CTP_I2C_WRITE and others)
- I am sure we have crc8 helpers in the kernel
- please use u8, u16, etc in the kernel code instead of uint8_t,
  uint16_t
- your driver will likely benefit from devm APIs
- no compile-time conditionals like "#if TOUCH_MAX_FINGER_NUM > 1"

Thanks.

-- 
Dmitry

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A5880025E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 05:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjLAEHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 23:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLAEHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 23:07:06 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EB310E4;
        Thu, 30 Nov 2023 20:07:13 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-58cf894544cso947663eaf.3;
        Thu, 30 Nov 2023 20:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701403632; x=1702008432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9AxdArqmUcj2pv9md3tfZU0IvTX7PKLiBCMspHt1eJo=;
        b=hrAUAlPLDfyxwpMIGcelP7VVkIEHMROb4EhlBwFgO1a8lKYnUsGV/NeiFb/27YfoKU
         aVW2eNXV6FIalPkA36LRuyF4/2k4y+7QFDUnxFWmAbcFNAKTfhd4UxTk1V6FYK2NtraP
         3FISUXh2aZeOKm/KKIghGqU8s3GfZEHvWZTxiEaF5j1wWmvp1rWvuCM76oMYhdcbsltb
         b/LSI+AUar7X2isZNNGKlu9zNAeJr8YTt2+gmDzwnDFo46xL5K2GL5UzjEOf5J5002zs
         0cArCzYyhFzbQggh6jf5Y+TXczZ4FwQeKeJOSAeTA4sE8Q79LmSdonVH5WuFv8g78zEe
         +4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701403632; x=1702008432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9AxdArqmUcj2pv9md3tfZU0IvTX7PKLiBCMspHt1eJo=;
        b=Ml2R2tE8fobldDdMWf/MoY42gaogujB0f+IdgUbIkUA1X1XknoBQ6b0o/aa5wz3nnf
         hoBez979X9hk0jeQHVkHnleRA0xg7wOOBiz214T2SE8ys5qU7RnM5h1+LW2Vuck1YC2N
         0V3d7ApQP/NAy/U7QVREcibuCHnOYGaNAztGGgOsrH/sENUcnOB6os9EzZ3ueJMxw/xw
         /0l1IJ709i9KhlCszXGCJ6WDvYvwOWG06Xgpc0Vae5InLia1g5RcEmz1f+hXYr4cKEdI
         dlPp4X3NcdGu8eRX5nYwmKu0xe725FtRpD55hEqht2+8E3ZQ2uB1oFCfcupFWJazy6PB
         b4PQ==
X-Gm-Message-State: AOJu0YwX0aVOgLdn6ETmIxoqsDVR2Rt09NIrUSZzVbCwYKcz7S0Kh6ef
        cmv5ShWIFhIp2KePahP+Jm8a0JN9MkQ=
X-Google-Smtp-Source: AGHT+IGD60A3RjgXqf0JCMQ3KQFK+3uQfHJyTA57jtwyjHTquwkogVYZLQ77By+KGbFAHb2rxsnM/A==
X-Received: by 2002:a4a:851e:0:b0:58d:7ec8:9c5c with SMTP id k30-20020a4a851e000000b0058d7ec89c5cmr1461385ooh.0.1701403632218;
        Thu, 30 Nov 2023 20:07:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z9-20020a4ade49000000b0058d8b0c4bbdsm409049oot.32.2023.11.30.20.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 20:07:11 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 30 Nov 2023 20:07:10 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Tremblay <etremblay@distech-controls.com>,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v1 1/3] hwmon: tmp513: Don't use "proxy" headers
Message-ID: <83068455-ecbf-45dc-8143-023164f6bfb6@roeck-us.net>
References: <20231128180654.395692-1-andriy.shevchenko@linux.intel.com>
 <20231128180654.395692-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128180654.395692-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 08:06:02PM +0200, Andy Shevchenko wrote:
> The driver uses math.h and not util_macros.h.
> 
> All the same for the kernel.h, replace it with what the driver is using.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied.

Guenter

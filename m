Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F5479A0D6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 02:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjIKArM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 20:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjIKArL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 20:47:11 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6D3132;
        Sun, 10 Sep 2023 17:47:07 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-5738949f62cso2586504eaf.0;
        Sun, 10 Sep 2023 17:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694393226; x=1694998026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LxeWUire9Y44jgsLn2xTx+DLhtNWXIjUAg2KAMs97VM=;
        b=OxIywk7HsQTLVINq9N9mCbM9I7/20ZUniZcVNk6zpx/t7v2DSMLyTJ27xkUe3ewRmH
         GTcY8eoqGp1iGg46gF/QdNi2Z4KxrOJv2YM6QEd5IPdGK31LucPR0DiAT90ZuUoa0BtC
         1nSWQLSNtnILxed1nMICqyzCoQsUGn4dXgmJOvD1w6MsIgGSS2x1jNMQ8g+vRVbitSyx
         ZgmPZXdcU/0l01MERMV0qxE1HSgzC0NwoHK7kINn9p2aqXGhqbolKxq9TDGnHmheeq7/
         cspsHxbQZ3GwwjsqAURsqTQ6NkhyggocPTmxTE+hkY2yR/R20b208uvb0l4UJZ5O6NP6
         /ztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694393226; x=1694998026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxeWUire9Y44jgsLn2xTx+DLhtNWXIjUAg2KAMs97VM=;
        b=VA0zdPUQSMoYcglHbZYoDO/bV+9U4rXWvdordJ5hxxg8rnTdb18j5irpXCmM4BhUuL
         aPwjJBPXtSkNc4M/PRkvm71UedJRITOR8afH4z/cC0hZgvsB5+ftHY6YVcMhgGA1TW6m
         /QiQIC0XRGFClrKRvFOTrVDkz1q5ibUkOtcx76vG5gBrGA2xyLQSKgQzOLf7R2uoYNoE
         Umm0S3rEurEeKj5VtwQIpUB0f5GR2eVUvqeK4Y9Em668262VijX784eprCEswwyAVZA8
         bDkONBQoIrSyTCqXNdP/qdEKV1iAx7QAlrVjxEIY7I5F480U+O/VopC0dzYJiSlqgnOg
         2u3Q==
X-Gm-Message-State: AOJu0YwlydrnvCUNr9c5mv9YZCeiNnnaEHxPjp+T1yy4Ac8GNruW3MC4
        l6rCuWo+Mlrem3d5GQTnQVk=
X-Google-Smtp-Source: AGHT+IGPLd79Smg6LWOjveSqNZ6xig+n2kCz+trsGdPNSbZjMqL9f6BERrpAnMGntFIhdseIa6+nzA==
X-Received: by 2002:a05:687c:14c:b0:1d5:c134:cecb with SMTP id yn12-20020a05687c014c00b001d5c134cecbmr1372333oab.1.1694393226527;
        Sun, 10 Sep 2023 17:47:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a28-20020a637f1c000000b00565cc03f150sm4481413pgd.45.2023.09.10.17.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 17:47:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 10 Sep 2023 17:47:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Eric Tremblay <etremblay@distech-controls.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v6 2/2] hwmon: tmp513: Simplify tmp51x_read_properties()
Message-ID: <8a3645fb-2c8a-4d72-98a7-0d0e76bcf353@roeck-us.net>
References: <20230907071404.24334-1-biju.das.jz@bp.renesas.com>
 <20230907071404.24334-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907071404.24334-3-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 08:14:04AM +0100, Biju Das wrote:
> Simplify tmp51x_read_properties() by replacing 'nfactor' ->'data->nfactor'
> in device_property_read_u32_array() and drop the local variable as it is
> unused.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied.

Thanks,
Guenter

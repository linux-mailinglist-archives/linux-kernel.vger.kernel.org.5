Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7855D7D73BB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbjJYS7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjJYS7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:59:19 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E87123;
        Wed, 25 Oct 2023 11:59:17 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cc04494653so39285ad.2;
        Wed, 25 Oct 2023 11:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698260357; x=1698865157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wT/xmiiSCLh2Y6rSvgnA+8oiaYPyDP9YFnNHMvs/gJ0=;
        b=eWJCIBHzvGSr9z63EcWSkpu65+T5sAWpoqU1jWhnGkWPfaltRsUfKQErEl0iP644Gv
         kYQRkMXZQKwJBoP8b733EAU26fv/T3gm8oYBx4vzG60JTAFp6ZR1U3I2FhabA+C35b5B
         YwFi8sajmf3B20r3Y+82Byo6YeVJsAQ2plAmQ0MsP21CVXc4ZU+XP/hxZGfcgvZViApv
         99lCM4CnjnbYYi/bO6PKQlO/6WE+0CkPqZpVsLzgLTVGQqr+Qz+qhSshwVtsXfBj6zpB
         /1sNAMeRWgqTtmswPLnFA+fXADdJtQaYUehFxwR6MpU1sAUX/ByWGIHgvRl7dMexTlag
         kZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698260357; x=1698865157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wT/xmiiSCLh2Y6rSvgnA+8oiaYPyDP9YFnNHMvs/gJ0=;
        b=pbW5CkKjUgKWVru/E+jnSDLLTEo9XolIP2div3dPf/y08u+3Dmq7e4VT8i4YjzJDha
         O9EHHtbGXV9eyI2JRfqImCt+8Z6g4wK3QHi5DObtoh7qlkHPfEjZvti5q9ZF/4lzlg14
         gnweDqozPKfjCHwLahYhvBUVH+5usTHiMgwf6jwxe6A3R7QqBT7pgL5X+lNrL5mYJSZt
         TXywV+6bbyNu97A/LQxV7DxPRQH0VZ4d96iz4oBfodjSMXD/9KbiyBPWsHKcmI/KBrjX
         9vzDwZo/kyaLBSqSuVRflX6e6aswS+THQDkYlfb49n0/1zQf8VJuxwYhZJ+VjKlghFZf
         4l5g==
X-Gm-Message-State: AOJu0YxVjuLL7+2/E1eWXZbX92TggvsDJkCuv8mpBjFKyWCOddq6/2v5
        kXk8tu3uPp3DEaK7T2sHPEa7niEDkmI=
X-Google-Smtp-Source: AGHT+IFhm4YyvzAerma1M6k1s4kSO5X5DGgk6SBjZTke2iY40XTEWUcHPEcDP9BOolEpzhECGXlMAw==
X-Received: by 2002:a17:903:294f:b0:1ca:5d1a:e77f with SMTP id li15-20020a170903294f00b001ca5d1ae77fmr11322986plb.43.1698260357028;
        Wed, 25 Oct 2023 11:59:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jf20-20020a170903269400b001ca4c7bee0csm9591441plb.232.2023.10.25.11.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 11:59:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 25 Oct 2023 11:59:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, Jonathan.Cameron@huawei.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v3 5/6] hwmon: nct6775: use acpi_dev_hid_uid_match() for
 matching _HID and _UID
Message-ID: <1de5bd70-5001-4661-93e5-6135597bd9c1@roeck-us.net>
References: <20231024062018.23839-1-raag.jadav@intel.com>
 <20231024062018.23839-6-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024062018.23839-6-raag.jadav@intel.com>
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

On Tue, Oct 24, 2023 at 11:50:17AM +0530, Raag Jadav wrote:
> Convert manual _UID references to use the standard ACPI helper.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Applied.

Guenter

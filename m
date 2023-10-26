Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEFD7D79C6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 02:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjJZAsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 20:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjJZAsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 20:48:18 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77365132;
        Wed, 25 Oct 2023 17:48:16 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-41cd1fe4645so2430491cf.0;
        Wed, 25 Oct 2023 17:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698281295; x=1698886095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LbvC3Jr6GlBODTrG4s/DZw4mHWi0s4/azQU3339hmps=;
        b=BFUDTZUXwX4W9xjfJUdy61TiKqPCLJSqofh2NEiG4SnqgvFQTFt/VnkN3VRvnN22mI
         p03lnj/8EAuD9JjEJNeuJisFPVO3zObwsiFdPT4IBxgIAkho6F7PcTylBX79ncqzDCq/
         kI62lghnJJ+g9VfMeDrk011N8VvXb4KzvtP/Vk7AA4WL+YYdPBC1ixBKv3h3wijeEsCI
         +d3PxDsDHbFsH/fft2+LX/iCVZeoXAPbMlTmE1TW+mAUXe5ahZIcxnRFKnKSi3YxEZfL
         Ru2b9n5vWyoW5SLyi+fLKCobrt8Ux5i/zhPF0j+dAgeqkDfYYgboJ8OwILhtaVm7j+bp
         26gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698281295; x=1698886095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbvC3Jr6GlBODTrG4s/DZw4mHWi0s4/azQU3339hmps=;
        b=CVEvRQ+t/3Sdl5qWFPozQCKUbIOG/4R1OeCl1egFVYe/85UTqutp6AQBC5zHzP5Cpp
         qhVCYmTUx3tgmx2mehRFOmhghQyKxRj01v5wDwla5Y1Lhtb3DvvQ/CDKpz7fZOyuE2a7
         1C6xv95RKBUXQ2hfuH/IOuQ2Sq+3iwSg42I8tJqFyn0UiesACzO9cGzsWOVwl3H9IyZh
         pFO0sMyQZjEtpfDtnKJrO8Tq/3AN859+CWn9UTWM7rTRn/4Ncn6G7RMeyhsk0XLCkip8
         RzWzTvr/rOKMS29SOrieqz4UR9BlGu4O9dGDHLCrLjh8UtbidoKAoohTM+9P+IlBk/8D
         N/yA==
X-Gm-Message-State: AOJu0Yyq/leW3rp60R+DXcubKi/wbYgAHSXN1gx/c5NthNqwS3FCwTlg
        2BxKLHgfD+WYblZRUvIZZJSmsNGAQa8=
X-Google-Smtp-Source: AGHT+IEySCJt7Lqaa+DiGWDnDKQ/owwawYZ/7VU9DPmC43dSf7qa5qhE0e7NJ3pGXYodwM1xaYpMWQ==
X-Received: by 2002:ac8:7e8a:0:b0:418:1b8f:4cde with SMTP id w10-20020ac87e8a000000b004181b8f4cdemr23683078qtj.45.1698281295449;
        Wed, 25 Oct 2023 17:48:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m124-20020a0de382000000b0059b2be24f88sm5448010ywe.143.2023.10.25.17.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 17:48:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 25 Oct 2023 17:48:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Cc:     joel@jms.id.au, andrew@aj.id.au, eajames@linux.ibm.com,
        ninad@linux.ibm.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (pmbus/max31785) Add delay between bus accesses
Message-ID: <bbbf3668-aa7a-4489-85b0-333cf394abe9@roeck-us.net>
References: <20231023180804.3068154-1-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023180804.3068154-1-lakshmiy@us.ibm.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 01:08:03PM -0500, Lakshmi Yadlapati wrote:
> Changes since V1:
> 1. Changed the max31785_wait macro to a function, following the conventions
>   used in other drivers that had the same issue.
> 2. Changed the function names from max31785_i2c_smbus* to max31785_i2c_* and
>   from max31785_pmbus_* to _max31785_*, making them more concise.
> 

Please check Documentation/process/submitting-patches.rst
for the expected patch format, specifically details on how
description and change log are supposed to look like.

Guenter

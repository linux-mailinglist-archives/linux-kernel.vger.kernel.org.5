Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E82801390
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 20:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379511AbjLAT1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 14:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAT06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 14:26:58 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75528FF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 11:27:04 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7b411be1eb7so55721639f.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 11:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701458824; x=1702063624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zxbnoQx/nMO3csvBWjNwC5Mq4pYrHDkgnOkoncy/UY4=;
        b=lHRHCLPSmYaiU8p368t0Ka164t1LUb+61Ai6O52icUAHLjO8QR8m/T7T3gvztHMOVg
         ceYo02T8+pxrp9Cuo2ZqE3//ta1sezFtHzejeAWjjIH+D6WjMfszFtF2Lpb+Kcjl3zql
         IR96Y7MGxafgk0/yXmkwh5wRZJMbc1qE1Y6qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701458824; x=1702063624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxbnoQx/nMO3csvBWjNwC5Mq4pYrHDkgnOkoncy/UY4=;
        b=eH68bk6r3XLGjRi29kn+ozHGhdJtEXrXAXicyB28umXTun+WO/eKgPCADhV2+D5uaD
         qWSBeYJfx8dM6N4s54UIrbxxUYiGHZRd1go1GrYYhITaVjZz2dD0RbdcxnYX/fkszxbH
         4vMgQ7pN1zbMIAGM+nZlAGDu3S0NURGbDT1qo4ZVjSs/LLSwefRL3ZVQthU/W6fnzUJ1
         8C+/4B/bECncKWiO5SitFhoqhLKE3CwFk5AsTj2fwbQqhJ2D7bYRFzyanmIFsPpOfSjN
         TK8q4lPQ4Q3/1JBvHuNfn6Nxax7BqpQ24wcphOhKnZmsz+CEwh4JCCqfqj6vM2gIYRpq
         PZsg==
X-Gm-Message-State: AOJu0YwndysPsyLNn5fhYeeRS+vVrsNA5yicZqOtmshgVqawrolxYdf1
        pG1fgfWZaHol2KDZivQwQ2fkYtP+DyDHqro0opY=
X-Google-Smtp-Source: AGHT+IFSCQgVGHQSoNZmAPFpaHlv8EMYdYDp05jfBi12SoTDVOlnXB4T3ElwkoFlb2dY2c3okoIEIg==
X-Received: by 2002:a05:6602:2241:b0:7b3:9612:e37b with SMTP id o1-20020a056602224100b007b39612e37bmr19850ioo.14.1701458822447;
        Fri, 01 Dec 2023 11:27:02 -0800 (PST)
Received: from localhost (74.120.171.34.bc.googleusercontent.com. [34.171.120.74])
        by smtp.gmail.com with UTF8SMTPSA id do36-20020a0566384ca400b00466788701e8sm997722jab.122.2023.12.01.11.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 11:27:01 -0800 (PST)
Date:   Fri, 1 Dec 2023 19:27:00 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Frieder Schrempf <frieder@fris.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Anand Moon <linux.amoon@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Rob Herring <robh@kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [RESEND PATCH v2 1/3] usb: misc: onboard_usb_hub: Print symbolic
 error names
Message-ID: <ZWozhDkH1C5hlYIv@google.com>
References: <20231127112234.109073-1-frieder@fris.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231127112234.109073-1-frieder@fris.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 12:22:24PM +0100, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Instead of printing the decimal error codes, let's use the more
> human-readable symbolic error names provided by the %pe printk
> format specifier.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Acked-by: Matthias Kaehlcke <mka@chromium.org>

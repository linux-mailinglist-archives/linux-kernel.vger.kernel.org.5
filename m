Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8965A7847DC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237350AbjHVQjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjHVQjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:39:44 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917C71BE;
        Tue, 22 Aug 2023 09:39:42 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68a3f1d8be2so2144119b3a.3;
        Tue, 22 Aug 2023 09:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692722382; x=1693327182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xIZD1wHA6+5KOjBvCb5coNIt9as6PZ9mXi9uNciQwzQ=;
        b=f8HWCjpZB13n4B+lbsQdY/Z2K55x+wL/VHE6WqmDH4yW3NKrtpVA2uOBBIfeEU+ikg
         Qvt56pYOIrcJhezMxFVqBLo6zntGdSNIIeHUIRk/c44cjvAWfBht9TaUhngpkhDIJyq/
         lQzHId4QnYfvsYX1jkE0so0+DfYN0exUPWpIe/0WqBijplGUxGHfFlkY6VgTSw8ch57Z
         n2FQFHVm3wR/Xr3OEbPLMFwx4OfCF/BPMMtGWjByyCebW0DfLoX7gY1QVgAjllO/KJJA
         Bg94GKgQNg6mN11qxU+dy76pFNx3As6rtrSPwala+bv2GPH4KCa4OonEH759QplqItCk
         056A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692722382; x=1693327182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIZD1wHA6+5KOjBvCb5coNIt9as6PZ9mXi9uNciQwzQ=;
        b=LJTMmrJUaiboFtI95ovKYObAD2bH9YYBCEYSkUQrPXgYOq0ZeSQP54DpH6qQCNAvhS
         aSzAQ/XvA21ZeVt59dB4tdzqbv0zJPXIXsSIyXPwVuQij28TXt5lrVxcardNqZy7oa6S
         IVS1CpI5DD0es/HqDFYBGb7lJ1BAX7y+7t/GAMZaBw89rWtpSYxmeKbJHoRMbPe8KxSI
         dDJQDGImedqInQvj/3ApCoeQH5N++JLMgYR1Du7MtI9HsMS5eNtPTOTJpDRwtrW32OX/
         e9tiGqiE+QJWbYEONuiSAeo1NhFoYLdD67GAqAZMD+U18I5rW/OPtoy0UJwjiOpsFYvw
         Z44Q==
X-Gm-Message-State: AOJu0YxsRWKl6OuZVuYBO3zkv36Z1N0gPfror2kAwsLhFDlOqaE6mHCk
        phMoP1BZqREfmdscpW7KNQcI2c73ZbI=
X-Google-Smtp-Source: AGHT+IFrmiT6RsoUKY2m2tWMQn6lowky7TSCwaS8elzF0vu8OaK2QArogWLdBf5g6KB5/I+d0ngTeA==
X-Received: by 2002:a05:6a20:7da9:b0:140:6fa9:7004 with SMTP id v41-20020a056a207da900b001406fa97004mr13033357pzj.46.1692722381802;
        Tue, 22 Aug 2023 09:39:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m18-20020a637d52000000b005649cee408fsm8294680pgn.0.2023.08.22.09.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 09:39:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 22 Aug 2023 09:39:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rob Herring <robh@kernel.org>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 1/1] watchdog: simatic: Use idiomatic selection of P2SB
Message-ID: <499aeb3a-f6cc-46b8-826f-237e6c5ace31@roeck-us.net>
References: <20230822141859.2139630-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822141859.2139630-1-andriy.shevchenko@linux.intel.com>
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

On Tue, Aug 22, 2023 at 05:18:59PM +0300, Andy Shevchenko wrote:
> While it's pretty much theoretical to be otherwise, make sure
> that P2SB is selected only for X86. This is idiomatic dependency
> which is used by all others who select it. Use it for Simatic
> as well.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

Hans, can you take this one as well ?

Thanks,
Guenter

> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index a75f6acb986b..751458959411 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1685,7 +1685,7 @@ config SIEMENS_SIMATIC_IPC_WDT
>  	depends on SIEMENS_SIMATIC_IPC && PCI
>  	default y
>  	select WATCHDOG_CORE
> -	select P2SB
> +	select P2SB if X86
>  	help
>  	  This driver adds support for several watchdogs found in Industrial
>  	  PCs from Siemens.
> -- 
> 2.40.0.1.gaa8946217a0b
> 

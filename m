Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99B477C3CD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 01:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjHNXPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 19:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbjHNXOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 19:14:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0784910F4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 16:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692054837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=THE30SasYOk7GRpj1crEM/R/YR6biFAHq9J7CisS99U=;
        b=C6Z6QDW6+CWf0D4EQEAXJlKkob/Rm8pX4VQmmCTwmuYqGRNU/GQqRhY0SnkH7UuIT5++0X
        RxfzZAIXSdmbwRVG/IU9g8AhdI1pAoamj59RyL0+3CLRIQXQ0XdoEvJ1aFm1hJoCFM3xwS
        ZWnn0CXHGFRsxGFl3wGwwsI1h4iQrHo=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-OrhSYUtuNo-2vAFOu7V8BQ-1; Mon, 14 Aug 2023 19:13:56 -0400
X-MC-Unique: OrhSYUtuNo-2vAFOu7V8BQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-565aee6e925so1605143a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 16:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692054835; x=1692659635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THE30SasYOk7GRpj1crEM/R/YR6biFAHq9J7CisS99U=;
        b=jNSSJcWEsaS7d0D7aF0LslbvXRII4i4JWGbzs5/ji5qyKkUVSt5TD6qi6kuPD1H3Co
         66WJJuqjc2l1j3mzB3kBbGOh15S5YuQkmCbDBoIv2ImsR8qUmURuAhn41GZWwEk+wQDo
         Fb5vq64dWUQUuUADSwRqkpzsyEcZcYOTsc+cxEvnTjlUXHmzBKWv87RQYa/4FavPHwH9
         4Ps4IpaYezYgwtlGxszUua3nE3RyLnkMSj3cxnQ7hxd/7hIyW4WQTXSV6ZuMVYRHlTjz
         6Y13EmtoiVZNdC/Sa4p0pMFAglVQxdGkKHzcmuW0/q+yFRmlp/YW58FbdUG3Tl+DcQf4
         6x4w==
X-Gm-Message-State: AOJu0YxNF0JDt24K5EDByeeJt5dnUS6JIMz2+3mKqeFAx2jelv6eQp80
        t9HdLQHnNAAxbq593JYUfu6e2o+zBxP805+ZEajSvv2mXUi9GL3MMZVGMw55BPEtdzAIWWsR56z
        1ApW4vXHhZtuug4cmukNs0P6I
X-Received: by 2002:a05:6a20:9383:b0:130:7803:57bd with SMTP id x3-20020a056a20938300b00130780357bdmr11277860pzh.3.1692054835351;
        Mon, 14 Aug 2023 16:13:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjENeL6XsZJ9mZ+BkCpOaC1eLAfNa4JPtq/hdBfyLaDaRLVp/nCTPdfNINr4xIrA91xOQIeA==
X-Received: by 2002:a05:6a20:9383:b0:130:7803:57bd with SMTP id x3-20020a056a20938300b00130780357bdmr11277831pzh.3.1692054835020;
        Mon, 14 Aug 2023 16:13:55 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902758700b001b9e9edbf43sm10033090pll.171.2023.08.14.16.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 16:13:54 -0700 (PDT)
Date:   Mon, 14 Aug 2023 16:13:53 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Richard Cochran <richardcochran@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] tpm_tis: Revert "tpm_tis: Disable interrupts on ThinkPad
 T490s"
Message-ID: <enaeow6numvzp74rrwpdqhjqs635ofqttj7o7gdoqfrsgbhihi@eb7ueum3r5w5>
References: <20230814164054.64280-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814164054.64280-1-jarkko@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 07:40:53PM +0300, Jarkko Sakkinen wrote:
> Since for MMIO driver using FIFO registers, also known as tpm_tis, the
> default (and tbh recommended) behaviour is now the polling mode, the
> "tristate" workaround is no longer for benefit.
> 
> If someone wants to explicitly enable IRQs for a TPM chip that should be
> without question allowed. It could very well be a piece hardware in the
> existing deny list because of e.g. firmware update or something similar.
> 
> While at it, document the module parameter, as this was not done in 2006
> when it first appeared in the mainline.
> 
> Link: https://lore.kernel.org/linux-integrity/20201015214430.17937-1-jsnitsel@redhat.com/
> Link: https://lore.kernel.org/all/1145393776.4829.19.camel@localhost.localdomain/
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

I was just typing an email to say that it looks like 6aaf663ee04a ("tpm_tis: Opt-in interrupts") will require
updating tpm_tis_disable_irq(), but you are already dealing with it. :)

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  .../admin-guide/kernel-parameters.txt         |  7 ++
>  drivers/char/tpm/tpm_tis.c                    | 93 +------------------
>  2 files changed, 9 insertions(+), 91 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 722b6eca2e93..6354aa779178 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6340,6 +6340,13 @@
>  			This will guarantee that all the other pcrs
>  			are saved.
>  
> +	tpm_tis.interrupts= [HW,TPM]
> +			Enable interrupts for the MMIO based physical layer
> +			for the FIFO interface. By default it is set to false
> +			(0). For more information about TPM hardware interfaces
> +			defined by Trusted Computing Group (TCG) look up to
> +			https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/
> +
>  	tp_printk	[FTRACE]
>  			Have the tracepoints sent to printk as well as the
>  			tracing ring buffer. This is useful for early boot up
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index 7fa3d91042b2..077fdb73740c 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -27,7 +27,6 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/kernel.h>
> -#include <linux/dmi.h>
>  #include "tpm.h"
>  #include "tpm_tis_core.h"
>  
> @@ -89,8 +88,8 @@ static inline void tpm_tis_iowrite32(u32 b, void __iomem *iobase, u32 addr)
>  	tpm_tis_flush(iobase);
>  }
>  
> -static int interrupts;
> -module_param(interrupts, int, 0444);
> +static bool interrupts;
> +module_param(interrupts, bool, 0444);
>  MODULE_PARM_DESC(interrupts, "Enable interrupts");
>  
>  static bool itpm;
> @@ -103,92 +102,6 @@ module_param(force, bool, 0444);
>  MODULE_PARM_DESC(force, "Force device probe rather than using ACPI entry");
>  #endif
>  
> -static int tpm_tis_disable_irq(const struct dmi_system_id *d)
> -{
> -	if (interrupts == -1) {
> -		pr_notice("tpm_tis: %s detected: disabling interrupts.\n", d->ident);
> -		interrupts = 0;
> -	}
> -
> -	return 0;
> -}
> -
> -static const struct dmi_system_id tpm_tis_dmi_table[] = {
> -	{
> -		.callback = tpm_tis_disable_irq,
> -		.ident = "Framework Laptop (12th Gen Intel Core)",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Framework"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Laptop (12th Gen Intel Core)"),
> -		},
> -	},
> -	{
> -		.callback = tpm_tis_disable_irq,
> -		.ident = "Framework Laptop (13th Gen Intel Core)",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Framework"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Laptop (13th Gen Intel Core)"),
> -		},
> -	},
> -	{
> -		.callback = tpm_tis_disable_irq,
> -		.ident = "ThinkPad T490s",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T490s"),
> -		},
> -	},
> -	{
> -		.callback = tpm_tis_disable_irq,
> -		.ident = "ThinkStation P360 Tiny",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkStation P360 Tiny"),
> -		},
> -	},
> -	{
> -		.callback = tpm_tis_disable_irq,
> -		.ident = "ThinkPad L490",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L490"),
> -		},
> -	},
> -	{
> -		.callback = tpm_tis_disable_irq,
> -		.ident = "ThinkPad L590",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L590"),
> -		},
> -	},
> -	{
> -		.callback = tpm_tis_disable_irq,
> -		.ident = "ThinkStation P620",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkStation P620"),
> -		},
> -	},
> -	{
> -		.callback = tpm_tis_disable_irq,
> -		.ident = "TUXEDO InfinityBook S 15/17 Gen7",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "TUXEDO InfinityBook S 15/17 Gen7"),
> -		},
> -	},
> -	{
> -		.callback = tpm_tis_disable_irq,
> -		.ident = "UPX-TGL",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "AAEON"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "UPX-TGL01"),
> -		},
> -	},
> -	{}
> -};
> -
>  #if defined(CONFIG_PNP) && defined(CONFIG_ACPI)
>  static int has_hid(struct acpi_device *dev, const char *hid)
>  {
> @@ -312,8 +225,6 @@ static int tpm_tis_init(struct device *dev, struct tpm_info *tpm_info)
>  	int irq = -1;
>  	int rc;
>  
> -	dmi_check_system(tpm_tis_dmi_table);
> -
>  	rc = check_acpi_tpm2(dev);
>  	if (rc)
>  		return rc;
> -- 
> 2.39.2
> 


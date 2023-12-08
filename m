Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DA080A78D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574357AbjLHPhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574346AbjLHPha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:37:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C1AFB;
        Fri,  8 Dec 2023 07:37:36 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702049855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qpuimodUdW8zgrX5wnIyyA5XNxEfhHnhG0ILtEY+Jk4=;
        b=gifSKc6eAb2P/t8HNvj3vxjNSJb44gvASUJxIsB4aV7cMB06dwwQqBs+mMr0fqes7ZUozG
        8auB+8QuChwFt6f14pYA8mYsinxNjzrzt6q8ozXqEmV8S5nv2zVmY593R+ej7enyvB7A9j
        H4eKz0nlE342EK859/DBgv2NuFaoSXG5JowUVHXEmVUyRjmoMn7ll0W10SFQC0AJgY/kHa
        LD3VO46Sb1FWF5ghxWBBlapjSS9rMcHmErpVd2BELGS6C/JcUOR/HB5SxEVezpYKOBBTUe
        V+npU1WR8jMhLuFPSdMHZUndqjm9Ln1PTkrUM8ORdG2GLDODLbRkPmvEN1zCCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702049855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qpuimodUdW8zgrX5wnIyyA5XNxEfhHnhG0ILtEY+Jk4=;
        b=BTSTsldgInTEUdy5FSkB6toRPsZXTVayxOYQv9PVDD3bKraPwy8zGbtS0lO9IkCbUjKy1P
        nQBpcNyav4dT8iCA==
To:     James Tai <james.tai@realtek.com>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        James Tai <james.tai@realtek.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 3/6] irqchip: Introduce RTD1319 support using the
 Realtek common interrupt controller driver
In-Reply-To: <20231129054339.3054202-4-james.tai@realtek.com>
References: <20231129054339.3054202-1-james.tai@realtek.com>
 <20231129054339.3054202-4-james.tai@realtek.com>
Date:   Fri, 08 Dec 2023 16:37:34 +0100
Message-ID: <87a5qkso1t.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29 2023 at 13:43, James Tai wrote:
> Add support for the RTD1319 platform.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes:
> https://lore.kernel.org/oe-kbuild-all/202311061208.hJmxGqym-lkp@intel.com/

Again: These tags are just wrong.

> +static struct platform_driver realtek_intc_rtd1319_driver = {
> +	.probe = rtd1319_intc_probe,
> +	.driver = {
> +		.name = "realtek_intc_rtd1319",
> +		.of_match_table = realtek_intc_rtd1319_dt_matches,
> +		.suppress_bind_attrs = true,
> +		.pm = &realtek_intc_rtd1319_pm_ops,
> +	},

	.probe	= rtd1319_intc_probe,
	.driver	= {
		.name			= "realtek_intc_rtd1319",
		.of_match_table		= realtek_intc_rtd1319_dt_matches,
                ....
                
Please.

> +};
> +
> +static int __init realtek_intc_rtd1319_init(void)
> +{
> +	return platform_driver_register(&realtek_intc_rtd1319_driver);
> +}
> +core_initcall(realtek_intc_rtd1319_init);

What? This can be built as a module. So how is core_initcall() in any
way correct here? module_init() perhaps?

Thanks,

        tglx



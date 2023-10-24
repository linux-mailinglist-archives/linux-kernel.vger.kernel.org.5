Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBB17D46EA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 07:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjJXFb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 01:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjJXFb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 01:31:56 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CABE9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 22:31:55 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6bd73395bceso2992312b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 22:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698125514; x=1698730314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TMgZBMWXzo4q6vwznsY5I4wwZsoXDFPKydTpbp5gDQw=;
        b=JKroqlfcHG8a6N6YvGdwfOhxawfooodjYM0sMf7u1n2XvdJKgBRVvlXS303QotoGo8
         XgJVqiLnq9Qy/W6lpRtsp2rPHRX7g+d5DEpLykgIkHlrnD0KmYt3BJFJ7FvHhm7EHcao
         DLFJaIHXHQkXR32FiQXVPsRUzkjojKN5IK27jqP9+4eqV3B/pCk25ucgPEe4q7NGCSb1
         l7LDZoQEm/1zeGWiVeHuimbZC8KTg1SKU+yhGBEEVZghGfcQ2kTMRbo4stf8vSO4rq1n
         o2r2nGy/kKMgIaumLtBvfPZHe5ZBNyiiFzZrMczFzSTaujCiYHdNBRjczMI785zEWFZD
         o/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698125514; x=1698730314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMgZBMWXzo4q6vwznsY5I4wwZsoXDFPKydTpbp5gDQw=;
        b=v7etYk6I48BeJCUZjarMQHbXgPOjzIWY2L5NKJQ9EaavRCu5OYytVthH7IfKrwotrB
         lE8e323iNTbPU6H0/XEBKhZkkhZzT2tI5ivK3d5gKnxQPk7MmHaoy4mYxcjeAI4yvaJA
         rMRk5LCB5yXAyJ/fMb8Jr88OsXQoZVzUuw1VVN7y9+MHVYtzdkrAxkG7tQhnFt+aiF2H
         VDNys+JxL3gCwv5JYjZCFthLQjaiZ6rdHTHyEw8MQhiC0M6J6hGrEamWWjZ1NRn308fR
         alQw7hxgUpec6OU2KkbphEKIfMSae07VsrWV6zK0YTU2D+c95oRcEzvmrjoXoFf9Dp51
         DuMA==
X-Gm-Message-State: AOJu0YxAe5n+nIB3XnZeSOriw1LvL1iwhuPSI4Ue16BJnqFoCPp6Omem
        Rlay6b2GDjITFIdsD/JGumaEVQ==
X-Google-Smtp-Source: AGHT+IEXabVD0I42LfRfAleaLrDfaEeikt+nTW/LvpW+v1yM0hF9QKpCxuvRXO4yGRldBbG6ljXApg==
X-Received: by 2002:a05:6a20:7348:b0:17b:2c56:70bc with SMTP id v8-20020a056a20734800b0017b2c5670bcmr2083668pzc.10.1698125514459;
        Mon, 23 Oct 2023 22:31:54 -0700 (PDT)
Received: from sunil-laptop ([2409:4071:6e9d:1e7:259:d68d:db3b:3cc])
        by smtp.gmail.com with ESMTPSA id y15-20020aa79aef000000b0068883728c16sm7216982pfp.144.2023.10.23.22.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 22:31:53 -0700 (PDT)
Date:   Tue, 24 Oct 2023 11:01:37 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v11 12/14] irqchip/riscv-aplic: Add support for MSI-mode
Message-ID: <ZTdWueglO1iXuS1D@sunil-laptop>
References: <20231023172800.315343-1-apatel@ventanamicro.com>
 <20231023172800.315343-13-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023172800.315343-13-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup,

On Mon, Oct 23, 2023 at 10:57:58PM +0530, Anup Patel wrote:
> The RISC-V advanced platform-level interrupt controller (APLIC) has
> two modes of operation: 1) Direct mode and 2) MSI mode.
> (For more details, refer https://github.com/riscv/riscv-aia)
> 
> In APLIC MSI-mode, wired interrupts are forwared as message signaled
> interrupts (MSIs) to CPUs via IMSIC.
> 
> We extend the existing APLIC irqchip driver to support MSI-mode for
> RISC-V platforms having both wired interrupts and MSIs.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
[...]
> +int aplic_msi_setup(struct device *dev, void __iomem *regs)
> +{
> +	const struct imsic_global_config *imsic_global;
> +	struct irq_domain *irqdomain;
> +	struct aplic_priv *priv;
> +	struct aplic_msicfg *mc;
> +	phys_addr_t pa;
> +	int rc;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	rc = aplic_setup_priv(priv, dev, regs);
> +	if (!priv) {
This should check rc instead of priv.

> +		dev_err(dev, "failed to create APLIC context\n");
> +		return rc;
> +	}
> +	mc = &priv->msicfg;
> +
> +	/*
> +	 * The APLIC outgoing MSI config registers assume target MSI
> +	 * controller to be RISC-V AIA IMSIC controller.
> +	 */
> +	imsic_global = imsic_get_global_config();
> +	if (!imsic_global) {
> +		dev_err(dev, "IMSIC global config not found\n");
> +		return -ENODEV;
For all error return paths, priv should be freed.

Thanks,
Sunil

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EADA7D4FA3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjJXMRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjJXMRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:17:37 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D443E120
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:17:35 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c518a1d83fso69655281fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698149854; x=1698754654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ywtG2aeiT8ekMrOBNJIRKZ2eAujslOOqomAOrufM1SU=;
        b=k1wMLfrIdkE6GXBBoWRlTFzU2BJVrSzy/l6w4wEagHDHkcFTQAjwgY4m7GNH7oySB3
         JaDYJRo121rKHEODJt4i0hXLW7D/m2c+J6D6AO0rwxFM7hqnnv9LYIvebRkK8gsrpHnF
         Gu/Z5OwHZuwM2gShw8bP06ifZf3qZSM4d365zFZWaucx91Rp3del9gDUGBux1GmP3lyK
         gSBdmd5alvGnHAE9YFPT7au+3WQLe7qBAtEAWzdGwz+MsdA9KWGvAVzFFeRkCTII+uvU
         006zBgU0zy4YyxVLoYWIonEyP+IiqWpqvTQIa9+ZYLRr4KelDCeObUcr6BObA+ljT/bR
         i9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698149854; x=1698754654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywtG2aeiT8ekMrOBNJIRKZ2eAujslOOqomAOrufM1SU=;
        b=uDfOvZm0zGX2RxYuNP0lmdSv92Q1mh0+13C9W7+nE9UDzfblKTQqvJiEI8J68ygMlk
         vVyfhiAB5yxlL3ZjmclYm+Rd/oWe39BGjtwDcR3KoigmyQN22axoQb2Z5yGYkwyErDV5
         fzN4ZqiXm/6LCgAB10kLzO2H6KNT03MHbzSo4AIq60fhDCOAv84ULu6FRKfwnrvDoBMQ
         aWbHXM7W3UOlTP5xz9OI8aCt+MpQw6uOn925ZrmuIfpd9uNT3NAN46ZWESaVJQJoyYkS
         eMSEtfdYHm2fUIq/PSqUO0CDS4NqzyX4nT4zKFV7fYbGnVyLobF/xng+b9f9spvvvpuB
         lTTA==
X-Gm-Message-State: AOJu0YwnBVyihDob7a7kWkO08sqFc6O8d+PaZBdwuU4WiBMxoTgLRH+N
        4RXFwszwtJPKeGOQLVnaAFJ0Wg==
X-Google-Smtp-Source: AGHT+IE6d/oSgQ9Dz+s2s/99KBYyI90JUkFW07BAyv9IhWTLc2F/oa76kzHgi2ODHuo+aGO9M6mljQ==
X-Received: by 2002:a05:651c:1699:b0:2c0:cfa:a1a0 with SMTP id bd25-20020a05651c169900b002c00cfaa1a0mr8057527ljb.46.1698149854070;
        Tue, 24 Oct 2023 05:17:34 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b0040775501256sm11871874wmq.16.2023.10.24.05.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 05:17:33 -0700 (PDT)
Date:   Tue, 24 Oct 2023 14:17:32 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
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
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v11 05/14] irqchip/riscv-intc: Add support for RISC-V AIA
Message-ID: <20231024-4aa004731cc3edf5f6e51031@orel>
References: <20231023172800.315343-1-apatel@ventanamicro.com>
 <20231023172800.315343-6-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023172800.315343-6-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 10:57:51PM +0530, Anup Patel wrote:
> The RISC-V advanced interrupt architecture (AIA) extends the per-HART
> local interrupts in following ways:
> 1. Minimum 64 local interrupts for both RV32 and RV64
> 2. Ability to process multiple pending local interrupts in same
>    interrupt handler
> 3. Priority configuration for each local interrupts
> 4. Special CSRs to configure/access the per-HART MSI controller
> 
> We add support for #1 and #2 described above in the RISC-V intc driver.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  drivers/irqchip/irq-riscv-intc.c | 34 ++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

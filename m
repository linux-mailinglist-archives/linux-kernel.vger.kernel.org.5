Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E54C751F54
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjGMK5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjGMK5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:57:12 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE49C199D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:57:10 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99384a80af7so82086966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1689245829; x=1691837829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c9NtgBLjv1J96zLCU/pO/Q7azYyogqr/cagIRcD64aI=;
        b=gj7kW8GV0O+RnxEUvB7Rzg92T+cWgaDBZOj/LehCMJmClgK/jAbkEyOOD74xx2BxB0
         aU2wUxt3DFCdM9tzd5JjcJUPXSoZDtRPlYrKTsP3IcYQLSMBinBJV8suJ+v37y+DASZE
         VReqO0d0RaoyVVG+/RKukaeB4OzssFWjZKq1q5ZgSBTuwlof83ML2aYwvWOWYazMbx0R
         HotbzEFISAwilTgLj8Ap8pLnJta6CiLKzIKo9BRtfOM6Lk/dgcJa8rc/G0ojulEbvmyA
         52usDTRQRfBRN9kkhvEVcjDK5u34uly8pnzMqz9C1JPnVLCvaFBdbzyVy2odpJySNsrP
         ii2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689245829; x=1691837829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9NtgBLjv1J96zLCU/pO/Q7azYyogqr/cagIRcD64aI=;
        b=V1ybN+p5tmsEA1nWZ/rq6Z3Z2Jv01kPFePJ51fRnTtlgKDALpu3Y9wph10WmAoNSFy
         Uvb4JK12+705V4DI0hJ7XM1F+il0K6ktO5mqSKFqpR3zr43FeRxoAeWREGcqtBejL1Oz
         Z6UL4I3wicYto/mHPEF/SHHk+1/Zv0yMqgH8k4njWtlgT5sbNGQY8wrjuYCqX3QAF/bf
         PfvAwdmooDJ2cA9bMjI0mkmXobyEuiXPLHjI/rcdqXoOYF37+lVm05nEI46mq+KiNctG
         gYyATzQFu/uRUAYADCF9qqTcSsuwC3ZgeTaM7T6zZm1rsfMJr3icK2Vsm8x6MPAS7bVQ
         2k4g==
X-Gm-Message-State: ABy/qLaG0H+MhL7njtZ9Ku0ir+3jGqekSSXKAtYm5zDEeRGkGU0BWGDC
        SghFbHlEy4fYZMzsUcF+hPCGMw==
X-Google-Smtp-Source: APBJJlFU4O4KO6QzME5VoehHAND0oIP1yprw6Nl8SlJa+4axe1vxNp8uN0pFbJlOPz1ClqZEcY+osQ==
X-Received: by 2002:a17:906:30d3:b0:982:82aa:86b1 with SMTP id b19-20020a17090630d300b0098282aa86b1mr920230ejb.43.1689245829265;
        Thu, 13 Jul 2023 03:57:09 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ay9-20020a170906d28900b00992bea2e9d2sm3835016ejb.62.2023.07.13.03.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 03:57:08 -0700 (PDT)
Date:   Thu, 13 Jul 2023 12:57:07 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Samuel Ortiz <sameo@rivosinc.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] RISC-V: KVM: Factor-out ONE_REG related code to its
 own source file
Message-ID: <20230713-40f6804b248987add29f83aa@orel>
References: <20230712161047.1764756-1-apatel@ventanamicro.com>
 <20230712161047.1764756-2-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712161047.1764756-2-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 09:40:41PM +0530, Anup Patel wrote:
> The VCPU ONE_REG interface has grown over time and it will continue
> to grow with new ISA extensions and other features. Let us move all
> ONE_REG related code to its own source file so that vcpu.c only
> focuses only on high-level VCPU functions.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/kvm_host.h |   6 +
>  arch/riscv/kvm/Makefile           |   1 +
>  arch/riscv/kvm/vcpu.c             | 529 +----------------------------
>  arch/riscv/kvm/vcpu_onereg.c      | 547 ++++++++++++++++++++++++++++++
>  4 files changed, 555 insertions(+), 528 deletions(-)
>  create mode 100644 arch/riscv/kvm/vcpu_onereg.c
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

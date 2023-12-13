Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364BD811AA7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbjLMRQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjLMRQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:16:56 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24548100
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:17:02 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-33644eeb305so20982f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702487820; x=1703092620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C506FxcdrW3cyYw/Gu8XEv6qnEjyNrzFxfEz8PrYaS0=;
        b=V2pepHrydbC0zouOnBsWtdNiaYBMrzlYkPFHnJVCD8qFfqvz8Rw0sGhz5h7UFTVqrw
         zNC29ppyk/blvrSTLx9xLBWXiGW+24K3DXwaSR8T2vIhg4CKGwbB3BbmLdurqzMdKVoC
         m6fcFyfpNyyIbAPPXrt6kjvrcW1S1JHr7jeP3/o/QFKfNS+uM/5iiMc6Xtu0WWrAvy1x
         jTegrUi/WEH03MA2tr/1LItpAvCqNzY91x5qK57WAn9a6WtC2H3ynjjK64SMLttRAslr
         8Nwbbsd7T7dYviUWmHx4pojGWUqlfAbbSL5y5XGAAliPsUwsYib53EOpWfkHZapbTSbB
         /e1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702487820; x=1703092620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C506FxcdrW3cyYw/Gu8XEv6qnEjyNrzFxfEz8PrYaS0=;
        b=ctZd5Y57n0oyFCL7/V/1mZWJeVxmBUOfSAXn+Ir+7xieo8DlOyb7+Lhe81QirBLe6W
         e/80/DjCHc+hr1xmgJJwDfyqL+kl8DImuTstLVPYTSKR+jnBpYtV9TE7omTg+IJxDS+M
         k7NGAWwK4YIQrWdUXYiDmx/qmqW8yqwV0NCb8R9hGU6N+sxl6a3YPIuB+R5LXBIvRDzn
         PIHQmNA/mMDlYTfTI22TKIYzMucLIUwbVB+gCABJDceEP34X1mxXyneWkxr2SDEhcdo+
         eNK22gsO0/Wld7zZjU59uJuIdbEsgaLgRfIgF+FTsW0b8QEP8T2xP+TOTOwpBAtTDz20
         tFGw==
X-Gm-Message-State: AOJu0YwJfIRKmSKWFdt5by3BKQlbqwoJM+dttHIh2mNuPevOkPPj69y1
        KvQofD6a1XsMhymgJ8sVv05sew==
X-Google-Smtp-Source: AGHT+IEVDrfNO7CiPC4KOQpU3GVq/lmfkGprbr9y6hJhwCs4R3hB+0wxmUeWY8FRM2GIz0IX65tHbA==
X-Received: by 2002:a5d:4fc5:0:b0:336:3749:83b9 with SMTP id h5-20020a5d4fc5000000b00336374983b9mr797373wrw.108.1702487820605;
        Wed, 13 Dec 2023 09:17:00 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id o8-20020a5d4a88000000b00334b302e97fsm13746137wrq.96.2023.12.13.09.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 09:17:00 -0800 (PST)
Date:   Wed, 13 Dec 2023 18:16:59 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Shuah Khan <shuah@kernel.org>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 02/15] RISC-V: KVM: Allow Zbc extension for Guest/VM
Message-ID: <20231213-73671e24dacd8ae821943638@orel>
References: <20231128145357.413321-1-apatel@ventanamicro.com>
 <20231128145357.413321-3-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128145357.413321-3-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 08:23:44PM +0530, Anup Patel wrote:
> We extend the KVM ISA extension ONE_REG interface to allow KVM
> user space to detect and enable Zbc extension for Guest/VM.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/uapi/asm/kvm.h | 1 +
>  arch/riscv/kvm/vcpu_onereg.c      | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
> index 60d3b21dead7..518b368b41e5 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -139,6 +139,7 @@ enum KVM_RISCV_ISA_EXT_ID {
>  	KVM_RISCV_ISA_EXT_ZIHPM,
>  	KVM_RISCV_ISA_EXT_SMSTATEEN,
>  	KVM_RISCV_ISA_EXT_ZICOND,
> +	KVM_RISCV_ISA_EXT_ZBC,
>  	KVM_RISCV_ISA_EXT_MAX,
>  };
>  
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index f8c9fa0c03c5..f789517c9fae 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -42,6 +42,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
>  	KVM_ISA_EXT_ARR(SVPBMT),
>  	KVM_ISA_EXT_ARR(ZBA),
>  	KVM_ISA_EXT_ARR(ZBB),
> +	KVM_ISA_EXT_ARR(ZBC),
>  	KVM_ISA_EXT_ARR(ZBS),
>  	KVM_ISA_EXT_ARR(ZICBOM),
>  	KVM_ISA_EXT_ARR(ZICBOZ),
> @@ -92,6 +93,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
>  	case KVM_RISCV_ISA_EXT_SVNAPOT:
>  	case KVM_RISCV_ISA_EXT_ZBA:
>  	case KVM_RISCV_ISA_EXT_ZBB:
> +	case KVM_RISCV_ISA_EXT_ZBC:
>  	case KVM_RISCV_ISA_EXT_ZBS:
>  	case KVM_RISCV_ISA_EXT_ZICNTR:
>  	case KVM_RISCV_ISA_EXT_ZICOND:
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A47A811B49
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjLMRgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbjLMRgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:36:20 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299D6109
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:36:26 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c38de1ee4so50030035e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702488984; x=1703093784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nar7AGpkKCMY3vU9wBOjKXihyoMWUwSDoyGxla1FSMU=;
        b=D4TjJmicgwyiuxU/0EQRMLlqFgwKB643M+Ls0ZrdgfTQzDGPaGC1+l7UiKTUp3QOIb
         x99r8Tj1EMoiw66hZVfozvkOmJQGuciegH+usdnX50mw1fwPKvm3dbT4ryBibHhL66d6
         B47I+JJQf6UKoeaxkSAv3Ud8TJU8S5rclkVcf1oTRsg+Qdr5z4/dMJ+nMul+SVdwKLvG
         b2eXFTTcUMyVlEcNOZ4lQaEDl/pHOGVoRtSTsj9qoYJzVBdSOk6mFBPsxejolZHdf4Y7
         85IQ993ek78WZ0ma1S7V/wEtRYvrdQBP4KkshvfvIAJ6IQB9tvvQQ2fzvtN7KJxa+Rsr
         Zk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702488984; x=1703093784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nar7AGpkKCMY3vU9wBOjKXihyoMWUwSDoyGxla1FSMU=;
        b=rdJtpuuMCM8rlfpFJYdNxHhYbVIt7+gajZMqxQfbkL9vZ6/FQr5R85rpD/aH4jl6Mm
         KvPt3GKCGLIpzEfjJniJdjpFCPcVjfgjmVXk8ppkSlcRSpACO9kB8zCDEIxcC51Ckuz/
         8atzpfBfVCMnERHcWw0lFasEA43jCc6JK/0JXz2vvn1R6ZHNCvJ3H+i+OwYroVRYEmTm
         dU6h/w3b0jQyecM3DWENSLRFwovF8y+o11uM8ueeiGVrqLB6Lk7KERf2Z5RfKDoqTwoT
         3hQ/YT4rkjsU2+V8+02WeWkhgKf2nQT714G0+HMseZsKJBQaP3rOcXCGkQWCwkLgj+zi
         s9Ww==
X-Gm-Message-State: AOJu0YxA5KHZO+WKcfuZ2Q8RXFFSfqKO7KfVUjfsDE6NqZQj30hKbLyE
        YRcOSgx0qlqMgQaSCsYfJh2skg==
X-Google-Smtp-Source: AGHT+IEK2Pp7nkWqxvEj/mdVNQpoa5hctJ9KTENrVC46QZLfOUyzk+bN6eF4FhiRrxtksDL5J5C+hw==
X-Received: by 2002:a05:600c:3590:b0:40c:2c56:4f37 with SMTP id p16-20020a05600c359000b0040c2c564f37mr4662038wmq.36.1702488984605;
        Wed, 13 Dec 2023 09:36:24 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c4f5000b0040c57e4ea28sm4720420wmq.17.2023.12.13.09.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 09:36:24 -0800 (PST)
Date:   Wed, 13 Dec 2023 18:36:23 +0100
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
Subject: Re: [PATCH 04/15] RISC-V: KVM: Allow scalar crypto extensions for
 Guest/VM
Message-ID: <20231213-1c93d927d30feb6d09739e94@orel>
References: <20231128145357.413321-1-apatel@ventanamicro.com>
 <20231128145357.413321-5-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128145357.413321-5-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 08:23:46PM +0530, Anup Patel wrote:
> We extend the KVM ISA extension ONE_REG interface to allow KVM
> user space to detect and enable scalar crypto extensions for
> Guest/VM. This includes extensions Zbkb, Zbkc, Zbkx, Zknd, Zkne,
> Zknh, Zkr, Zksed, Zksh, and Zkt.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/uapi/asm/kvm.h | 10 ++++++++++
>  arch/riscv/kvm/vcpu_onereg.c      | 20 ++++++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
> index 518b368b41e5..7b54fa215d6d 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -140,6 +140,16 @@ enum KVM_RISCV_ISA_EXT_ID {
>  	KVM_RISCV_ISA_EXT_SMSTATEEN,
>  	KVM_RISCV_ISA_EXT_ZICOND,
>  	KVM_RISCV_ISA_EXT_ZBC,
> +	KVM_RISCV_ISA_EXT_ZBKB,
> +	KVM_RISCV_ISA_EXT_ZBKC,
> +	KVM_RISCV_ISA_EXT_ZBKX,
> +	KVM_RISCV_ISA_EXT_ZKND,
> +	KVM_RISCV_ISA_EXT_ZKNE,
> +	KVM_RISCV_ISA_EXT_ZKNH,
> +	KVM_RISCV_ISA_EXT_ZKR,
> +	KVM_RISCV_ISA_EXT_ZKSED,
> +	KVM_RISCV_ISA_EXT_ZKSH,
> +	KVM_RISCV_ISA_EXT_ZKT,
>  	KVM_RISCV_ISA_EXT_MAX,
>  };
>  
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index f789517c9fae..b0beebd4f86e 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -43,6 +43,9 @@ static const unsigned long kvm_isa_ext_arr[] = {
>  	KVM_ISA_EXT_ARR(ZBA),
>  	KVM_ISA_EXT_ARR(ZBB),
>  	KVM_ISA_EXT_ARR(ZBC),
> +	KVM_ISA_EXT_ARR(ZBKB),
> +	KVM_ISA_EXT_ARR(ZBKC),
> +	KVM_ISA_EXT_ARR(ZBKX),
>  	KVM_ISA_EXT_ARR(ZBS),
>  	KVM_ISA_EXT_ARR(ZICBOM),
>  	KVM_ISA_EXT_ARR(ZICBOZ),
> @@ -52,6 +55,13 @@ static const unsigned long kvm_isa_ext_arr[] = {
>  	KVM_ISA_EXT_ARR(ZIFENCEI),
>  	KVM_ISA_EXT_ARR(ZIHINTPAUSE),
>  	KVM_ISA_EXT_ARR(ZIHPM),
> +	KVM_ISA_EXT_ARR(ZKND),
> +	KVM_ISA_EXT_ARR(ZKNE),
> +	KVM_ISA_EXT_ARR(ZKNH),
> +	KVM_ISA_EXT_ARR(ZKR),
> +	KVM_ISA_EXT_ARR(ZKSED),
> +	KVM_ISA_EXT_ARR(ZKSH),
> +	KVM_ISA_EXT_ARR(ZKT),
>  };
>  
>  static unsigned long kvm_riscv_vcpu_base2isa_ext(unsigned long base_ext)
> @@ -94,6 +104,9 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
>  	case KVM_RISCV_ISA_EXT_ZBA:
>  	case KVM_RISCV_ISA_EXT_ZBB:
>  	case KVM_RISCV_ISA_EXT_ZBC:
> +	case KVM_RISCV_ISA_EXT_ZBKB:
> +	case KVM_RISCV_ISA_EXT_ZBKC:
> +	case KVM_RISCV_ISA_EXT_ZBKX:
>  	case KVM_RISCV_ISA_EXT_ZBS:
>  	case KVM_RISCV_ISA_EXT_ZICNTR:
>  	case KVM_RISCV_ISA_EXT_ZICOND:
> @@ -101,6 +114,13 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
>  	case KVM_RISCV_ISA_EXT_ZIFENCEI:
>  	case KVM_RISCV_ISA_EXT_ZIHINTPAUSE:
>  	case KVM_RISCV_ISA_EXT_ZIHPM:
> +	case KVM_RISCV_ISA_EXT_ZKND:
> +	case KVM_RISCV_ISA_EXT_ZKNE:
> +	case KVM_RISCV_ISA_EXT_ZKNH:
> +	case KVM_RISCV_ISA_EXT_ZKR:
> +	case KVM_RISCV_ISA_EXT_ZKSED:
> +	case KVM_RISCV_ISA_EXT_ZKSH:
> +	case KVM_RISCV_ISA_EXT_ZKT:
>  		return false;
>  	/* Extensions which can be disabled using Smstateen */
>  	case KVM_RISCV_ISA_EXT_SSAIA:
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

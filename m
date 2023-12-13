Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78223811AC7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbjLMRTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjLMRTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:19:34 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6A5129
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:19:40 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c3fe6c08fso48132725e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702487978; x=1703092778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W3BG24W610lJuKV/MW/fbLfcOspFMJtOeERiQaIiRWM=;
        b=D0KAKx8N4MOccXzvsRUZwfL8OuCPtt3k7XEY9o9U6Ih3o+HdBLv6i4JjXRresI2HZ+
         wanjfnLKZVo68KteA3Zw+i7+NbBdBjEJJEE9vSdH3EUFIkSz+QBF8q/s/jdm7kcHU8R/
         gXPfscw1sWibuwuqwo2lwqQxJbXz6M3BIsEVuBJqb79Lqe1LrGNOFebPQ+r3IC7POhRX
         MK4Wrx23J5YbUz386TcdmtUd318S1eQEvV8IoyskZ3UqEjuI239KKX4WJCQ0mIcLMoVv
         MUJ9U/QgfjVAndSoKONembXEsWkpKqW9RsiaoVANQgOTkXM47AH4sjS11iY/ItjloGWk
         cUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702487978; x=1703092778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3BG24W610lJuKV/MW/fbLfcOspFMJtOeERiQaIiRWM=;
        b=K0pi91urBsVu5u2SrftoWsXxG1Zfqunj1do1FpR9yciMU6TCgFC8V+8Kti6TzmCSUk
         BIKgp/rMBoltwSruW2T4YnVEDmYtS4fSqfuLx4Lqpe43PUKIPV3fdMMLeAVxBhNGQJB1
         RXNHK3tH5sjXfik0C3CpbF9dGwn5wU0a/3Ptv5dyYoFSZNV7T/Nz6kBatDchVHVpYuc0
         lMWO/uzZQFNpOekXaFOjdos9jqX3hmpUBTcoyT7Ub1b5In6ORwmbFwkIdtjfEMSm3nM9
         7XyKS3R6xO5nKFqzD/3Ltgy43lQjeYCfM5iFJRSdLxayJyAEcw81yzw54MYTrEq3xcq4
         DdOA==
X-Gm-Message-State: AOJu0YyA0FWXTbHs4kbgimBbuWHTfWwNrMbHxt+cpmfDwySjj13gTN5w
        GnkMMH46LtZSrW+vAV9dWtnkEQ==
X-Google-Smtp-Source: AGHT+IFLcGLrThHqoGdIdS0RECHOQeVt4478xU7EiOcPPKGKy3QIAr+KLDIgxCltoydbRPGDwIQ3TA==
X-Received: by 2002:a05:600c:4749:b0:40c:a11:19df with SMTP id w9-20020a05600c474900b0040c0a1119dfmr2878247wmo.180.1702487978245;
        Wed, 13 Dec 2023 09:19:38 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id r20-20020a05600c459400b0040b349c91acsm23318063wmo.16.2023.12.13.09.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 09:19:37 -0800 (PST)
Date:   Wed, 13 Dec 2023 18:19:37 +0100
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
Subject: Re: [PATCH 03/15] KVM: riscv: selftests: Add Zbc extension to
 get-reg-list test
Message-ID: <20231213-1082f104e8ba65ee3db6aa3a@orel>
References: <20231128145357.413321-1-apatel@ventanamicro.com>
 <20231128145357.413321-4-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128145357.413321-4-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 08:23:45PM +0530, Anup Patel wrote:
> The KVM RISC-V allows Zbc extension for Guest/VM so let us add
> this extension to get-reg-list test.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> index b6b4b6d7dacd..4b75b011f2d8 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -44,6 +44,7 @@ bool filter_reg(__u64 reg)
>  	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVPBMT:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBA:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBB:
> +	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBC:

Assuming this gets rebased on [1] then this line becomes

  case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZBC:

[1] https://lore.kernel.org/linux-riscv/20231213170951.93453-8-ajones@ventanamicro.com/

>  	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBS:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOM:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOZ:
> @@ -361,6 +362,7 @@ static const char *isa_ext_id_to_str(const char *prefix, __u64 id)
>  		KVM_ISA_EXT_ARR(SVPBMT),
>  		KVM_ISA_EXT_ARR(ZBA),
>  		KVM_ISA_EXT_ARR(ZBB),
> +		KVM_ISA_EXT_ARR(ZBC),
>  		KVM_ISA_EXT_ARR(ZBS),
>  		KVM_ISA_EXT_ARR(ZICBOM),
>  		KVM_ISA_EXT_ARR(ZICBOZ),
> @@ -739,6 +741,7 @@ KVM_ISA_EXT_SIMPLE_CONFIG(svnapot, SVNAPOT);
>  KVM_ISA_EXT_SIMPLE_CONFIG(svpbmt, SVPBMT);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zba, ZBA);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zbb, ZBB);
> +KVM_ISA_EXT_SIMPLE_CONFIG(zbc, ZBC);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zbs, ZBS);
>  KVM_ISA_EXT_SUBLIST_CONFIG(zicbom, ZICBOM);
>  KVM_ISA_EXT_SUBLIST_CONFIG(zicboz, ZICBOZ);
> @@ -761,6 +764,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
>  	&config_svpbmt,
>  	&config_zba,
>  	&config_zbb,
> +	&config_zbc,
>  	&config_zbs,
>  	&config_zicbom,
>  	&config_zicboz,
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>


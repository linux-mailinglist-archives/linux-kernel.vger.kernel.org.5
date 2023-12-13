Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA0F811566
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442029AbjLMO7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441983AbjLMO7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:59:42 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112D0EA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:59:48 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3333074512bso4332605f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702479586; x=1703084386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8DBUvhPtbZDawFoEzfTVNDryKtEimlM9O26B02EurUc=;
        b=OtVrnzEi+1+FqmHQ6hXGbGKSlqhU94O5bqiLpzByfRxUL/IqKXmYjC+Fz36sQ+/Iw9
         b1lrOA4lMNLdV+dVq5q/InU+q1FassFNWGKqyw6Y66spj8Kq34lbyoXMuUqQRp8SejgL
         zq5Hxk2xYrQwB+D/O37MAeLo5Whq+mAHBHpzXZv4Ln89h6IBor1ZIJG/97Ib+yuXE4di
         Up5+tOyjs/hRNhq62RNFDQZzVvzD6D/xMbex7/IIsRFWF1evjyZJpsWFdAmNnn+DGKCr
         f6UyVrdpec//nO+AfbMi2VYxwHq9k7CtHQwIyaJo6oXS0zncVP4S1RWsLqtO4x4SdxpP
         mR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702479586; x=1703084386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DBUvhPtbZDawFoEzfTVNDryKtEimlM9O26B02EurUc=;
        b=BxNA86TVFtpeDF4eKf7NSNHMkH8o3pqvDeiA6bBvQacG8aZl62VfjJe40S7NEAhqUI
         AYUpSJih7G8f4Xxi6rb50mcs7jADm7xX8WU6WVUvKTTYplNpCmha+kQ5RJkVGRQeBjs1
         xQcWjp6GWuQ9lojk2q+aL59j/ouwNf4X3SDR21IUHoX0Y3xzzpZ9EMfEzdK/QhMKWjVd
         HJ0EMyMCPWOPfM6QIwhXUDh9MYZQFWIP6PQuokvsHSIQ9XFJGZvy0f7IpSXVBPRsBs75
         F5wN0Ipw2fhOXOQw2yt/VPL57npvV3+vzm6s+A6ne2hjZKwnFa3Ds0luSm9/TtJ4X4J3
         cTnQ==
X-Gm-Message-State: AOJu0YxsZZoThRC69YL51QSPQP37nze8kjWBSMNQssZaGMtdlrJep7Pp
        Maric4ffG9Rvw9q7Ifon+r4tzQ==
X-Google-Smtp-Source: AGHT+IGLUXcjN5NhvYEVkfAJzzQF0Pn/hNoBqUffZURU7B7poOc4GgowWX8hQYY9gAB9PB13DPz48g==
X-Received: by 2002:a5d:4529:0:b0:336:42b2:5988 with SMTP id j9-20020a5d4529000000b0033642b25988mr327330wra.27.1702479586515;
        Wed, 13 Dec 2023 06:59:46 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id d12-20020adfa40c000000b003333fa3d043sm13651788wra.12.2023.12.13.06.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:59:46 -0800 (PST)
Date:   Wed, 13 Dec 2023 15:59:45 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
        greentime.hu@sifive.com, vincent.chen@sifive.com, tjytimi@163.com,
        alex@ghiti.fr, conor.dooley@microchip.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Haibo Xu <haibo1.xu@intel.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] KVM: riscv: selftests: Add Svadu Extension to
 get-reg-list testt
Message-ID: <20231213-3b68f487a41af1e3f3c96cf2@orel>
References: <20231102120129.11261-1-yongxuan.wang@sifive.com>
 <20231102120129.11261-5-yongxuan.wang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102120129.11261-5-yongxuan.wang@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 12:01:25PM +0000, Yong-Xuan Wang wrote:
> Update the get-reg-list test to test the Svadu Extension is available
> for guest OS.
> 
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> ---
>  .../testing/selftests/kvm/riscv/get-reg-list.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> index 9f99ea42f45f..972538d76f48 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -49,6 +49,7 @@ bool filter_reg(__u64 reg)
>  	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICSR:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIFENCEI:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIHPM:
> +	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVADU:
>  		return true;
>  	/* AIA registers are always available when Ssaia can't be disabled */
>  	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(siselect):
> @@ -340,6 +341,7 @@ static const char *isa_ext_id_to_str(__u64 id)
>  		"KVM_RISCV_ISA_EXT_ZICSR",
>  		"KVM_RISCV_ISA_EXT_ZIFENCEI",
>  		"KVM_RISCV_ISA_EXT_ZIHPM",
> +		"KVM_RISCV_ISA_EXT_SVADU",
>  	};
>  
>  	if (reg_off >= ARRAY_SIZE(kvm_isa_ext_reg_name)) {
> @@ -700,6 +702,10 @@ static __u64 fp_d_regs[] = {
>  	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_D,
>  };
>  
> +static __u64 svadu_regs[] = {
> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVADU,
> +};
> +
>  #define BASE_SUBLIST \
>  	{"base", .regs = base_regs, .regs_n = ARRAY_SIZE(base_regs), \
>  	 .skips_set = base_skips_set, .skips_set_n = ARRAY_SIZE(base_skips_set),}
> @@ -739,6 +745,9 @@ static __u64 fp_d_regs[] = {
>  #define FP_D_REGS_SUBLIST \
>  	{"fp_d", .feature = KVM_RISCV_ISA_EXT_D, .regs = fp_d_regs, \
>  		.regs_n = ARRAY_SIZE(fp_d_regs),}
> +#define SVADU_REGS_SUBLIST \
> +	{"svadu", .feature = KVM_RISCV_ISA_EXT_SVADU, .regs = svadu_regs, \
> +		.regs_n = ARRAY_SIZE(svadu_regs),}
>  
>  static struct vcpu_reg_list h_config = {
>  	.sublists = {
> @@ -876,6 +885,14 @@ static struct vcpu_reg_list fp_d_config = {
>  	},
>  };
>  
> +static struct vcpu_reg_list svadu_config = {
> +	.sublists = {
> +	BASE_SUBLIST,
> +	SVADU_REGS_SUBLIST,
> +	{0},
> +	},
> +};
> +
>  struct vcpu_reg_list *vcpu_configs[] = {
>  	&h_config,
>  	&zicbom_config,
> @@ -894,5 +911,6 @@ struct vcpu_reg_list *vcpu_configs[] = {
>  	&aia_config,
>  	&fp_f_config,
>  	&fp_d_config,
> +	&svadu_config,
>  };
>  int vcpu_configs_n = ARRAY_SIZE(vcpu_configs);
> -- 
> 2.17.1
>

We should rebase this on [1] since it changes sublist management.

[1] https://lore.kernel.org/all/20231128145357.413321-2-apatel@ventanamicro.com/

Thanks,
drew

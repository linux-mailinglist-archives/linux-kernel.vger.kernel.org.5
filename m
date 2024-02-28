Return-Path: <linux-kernel+bounces-85065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AA986AFEE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27D46B26068
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118E914CACE;
	Wed, 28 Feb 2024 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OUXK/3LT"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA4D1474D8
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125670; cv=none; b=mVa4YojjNhRWSIqBIoMFGnvwExM47+y1rAyKvfyHYu3cI77DmdylTpeG01YH0Up6nSEFdzkiNvB+4OuX3e3yBXHue8QxjwGKhtV0vRKKd1X9Yoq1czFLyICJxwsLvoukIpUdnxRR5EFzcbwDbb8OcmM5esFXDrZcNLSEjmg9tP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125670; c=relaxed/simple;
	bh=lnm+0EEdegAjRqKT4byJnEVNNkPFSOBtM19dPMn2Bzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRBoowqJwdh3Hk/nn/I9SCl4r6b4BCSPkUz0c8KjmW956NDdDFgPDpf8guQ/RqP7hbLLayjggzlFTJ7MIsdC289Xz6VIzz74GEQxQfCTW60H2tHj77bBj+pJya2xjJfsEd3r+OAxjMqEXFF6nSUB78J6mlpCh6MwVvRlGx6DdJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OUXK/3LT; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a43f922b2c5so84235166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709125665; x=1709730465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uyEO6boa+xJ/OQch4N2V/Css5OUzCe/Ii8yKVOFLc2o=;
        b=OUXK/3LTKhbdyQbLtfnVmMJZLzIY+m3Awboab9MSNs5NwpVENWUCqKXR+YpAfeDIgk
         znNiBjpkcKsSK5LWX+bvgJ1sd8RocSIlluyWk8gSfiZ16zAQ89bG91MAYC58owfoFUQI
         ECwYS0HSgqStYFKkAUPUmpiqAdwvspBQIoJiOoxVZmVSYUKdzT4lDoGPOuvLaPQW6cdE
         yHR8zt03CS5+3Bdxbm9DP0LDz834recZ5LsuYd3ij1vZQHMpImPcOeUL1/AFkxvJNhw3
         uNs1OGcuhIAhXsfNtuTTqWr328g2mtut8gOXQaqRpjGr6CY3q1Wv9Jz6UAUWZMVBz3Hs
         hGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125665; x=1709730465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyEO6boa+xJ/OQch4N2V/Css5OUzCe/Ii8yKVOFLc2o=;
        b=cudNVGnOtA31/Pnt7QZZRlJwrAmiFlw7qBfcWirRgAp/wz7/qx7Qj9HQ23yW+B01sL
         ycpFtgi5p4Q8MCd4h8/nk59qU6HwgcrXe9OeCmguh4t93f7CyGGfBBrHKWXW5oDHudVr
         UKhoY+ecPFqcmTurQ5eYZyLb8ZWWncCP5mbjT3z/h6TAfI3Nn1d8RjyYG7K5l4x/gWgK
         IuxLrJ7MSKU2+tXpTra8cHcQ+rFy1ox6DxpLZCcozVLz03qgInYl28gSMtRDPHGktqw5
         rC9L+7WSvQlbDheQIJVFyxQSLQBk5pZnnvccxjvMG+5WdFkYTIGDKJNOMuWEyYQPw4QU
         QPWg==
X-Forwarded-Encrypted: i=1; AJvYcCWqBHre49f5tObWvOV3E/3/yl574Pk9C/Mn3AHASr0p2wAyRI0gf7xIr/648sK3cEnMqjnUqeuJ3jDTqKPs2W2MRotOA/2IztjDKGdV
X-Gm-Message-State: AOJu0YwzxvtXgrhgXYHvAjBPZ2XBZj7vjHZNSjrlSkGpQBJX9dFKq8bN
	jhOYXseKcK3kVXkigBkVCBF8UkKVPjvkB+xINy9i/sqQ4HeiPuwblHOQwnrDT3Q=
X-Google-Smtp-Source: AGHT+IHz6Q/4cwrnVSPpcLF88omhchUxt+jZb2vdilR4dpr1cIS/m3RQ1nQ+HOnDHiBkqjyTNNA/5Q==
X-Received: by 2002:a17:906:5651:b0:a43:164c:cb3a with SMTP id v17-20020a170906565100b00a43164ccb3amr6249584ejr.53.1709125665459;
        Wed, 28 Feb 2024 05:07:45 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ts7-20020a170907c5c700b00a43f4722eaesm705990ejc.103.2024.02.28.05.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:07:45 -0800 (PST)
Date: Wed, 28 Feb 2024 14:07:44 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/5] KVM: riscv: selftests: Add Ztso extension to
 get-reg-list test
Message-ID: <20240228-8e0f8611d2f45f71c04ead57@orel>
References: <20240214123757.305347-1-apatel@ventanamicro.com>
 <20240214123757.305347-4-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214123757.305347-4-apatel@ventanamicro.com>

On Wed, Feb 14, 2024 at 06:07:55PM +0530, Anup Patel wrote:
> The KVM RISC-V allows Ztso extension for Guest/VM so let us
> add this extension to get-reg-list test.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> index 9d9c50b68207..5429453561d7 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -73,6 +73,7 @@ bool filter_reg(__u64 reg)
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZKSED:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZKSH:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZKT:
> +	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZTSO:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZVBB:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZVBC:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZVFH:
> @@ -436,6 +437,7 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
>  		KVM_ISA_EXT_ARR(ZKSED),
>  		KVM_ISA_EXT_ARR(ZKSH),
>  		KVM_ISA_EXT_ARR(ZKT),
> +		KVM_ISA_EXT_ARR(ZTSO),
>  		KVM_ISA_EXT_ARR(ZVBB),
>  		KVM_ISA_EXT_ARR(ZVBC),
>  		KVM_ISA_EXT_ARR(ZVFH),
> @@ -957,6 +959,7 @@ KVM_ISA_EXT_SIMPLE_CONFIG(zkr, ZKR);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zksed, ZKSED);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zksh, ZKSH);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zkt, ZKT);
> +KVM_ISA_EXT_SIMPLE_CONFIG(ztso, ZTSO);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zvbb, ZVBB);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zvbc, ZVBC);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zvfh, ZVFH);
> @@ -1010,6 +1013,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
>  	&config_zksed,
>  	&config_zksh,
>  	&config_zkt,
> +	&config_ztso,
>  	&config_zvbb,
>  	&config_zvbc,
>  	&config_zvfh,
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>


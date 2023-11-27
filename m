Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4997FA2E7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjK0Oe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbjK0OeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:34:08 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8593865
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:32:41 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-35cb62e3905so5554885ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701095560; x=1701700360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=576agieZsbz96FiroK7MxYXEH2pDI3CMW/6FzJlxhYw=;
        b=lkocpGUk5mMM6YHccsm29CP+zyKk3th9gRHqNNZcGZ5tKx49nJk+W5k1SSwulXKjnE
         M2eG1uLDQJG949TEZ0FmWuvJCoKYBtxG8rd9Sa19dD3Mamkl/BZWYAk8EXIxDdBvHVst
         ZIbgZIsr9zraVTvWblQ2CDuHXA01iJ8CXFmrPqlmDQ8ciDs16ezA6cpWj64QVM/Oqmqr
         k9xLV8gBd0WnSI8/ZoNy/MraCmxN3zTJSU3/7+wFDozP1WjPCqQXdhuNJQK0WOUhaYZn
         tlscKTwvRfZS7cN1yFuOBJFinel3wxXASsNZdkh7/0UYFLKOM/AqILGgrKEJK5mEddEy
         i3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701095560; x=1701700360;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=576agieZsbz96FiroK7MxYXEH2pDI3CMW/6FzJlxhYw=;
        b=RZOUHnm+ShFjzzf1LGBmcIWdDx0HVmVwVYzIVhuBvQJOwJwwCkzaFoyu4ZimfqoDZ8
         8Wg+K3pE8IRFwbDBSoNVZ4D7a4aavyoqkZQj3oRzYS2awoPVT6vm/G0KdPdbLa374RYz
         Vd3cjb2OBMLV1AWyca7RJRZmHiRD90S8oAt9ChnKGb0CYKyVWoc4TJn1+0J2zRq/ZUxz
         uwsdY1GrrMrwr4fVJ8QyDOwtXZSsqBjVoTugZq10WARzhLvqaZJgzlWo1zN26GudyhAb
         ksc5sWblXGABU2+ZiYHLTJn4Er5aTjOVFN+z+ECUn8PBL2kUDqkA7vapYdyIfz58sHcP
         l4sw==
X-Gm-Message-State: AOJu0YwqUWL3tlB4PnZW3JY8SaeBi3JvoQKnx979NZto7NE/81/vqvH2
        onv/K+bWcC9ZamGsYO5uVmxvrA==
X-Google-Smtp-Source: AGHT+IG/WGxpvGREvrXBuOJjwOgK3X/z7+Um3ekxoELlMVLqyywHQeQ7S80IRt40ldOt+Chf9dKILA==
X-Received: by 2002:a05:6e02:388a:b0:35c:5131:cc9f with SMTP id cn10-20020a056e02388a00b0035c5131cc9fmr13225931ilb.23.1701095560675;
        Mon, 27 Nov 2023 06:32:40 -0800 (PST)
Received: from ?IPV6:2605:a601:adae:4500:2dd6:4d2f:2741:8d95? ([2605:a601:adae:4500:2dd6:4d2f:2741:8d95])
        by smtp.gmail.com with ESMTPSA id l15-20020a056e020e4f00b0035b0b56e0e1sm1987657ilk.53.2023.11.27.06.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 06:32:40 -0800 (PST)
Message-ID: <2de6d526-918b-44f6-b26a-a0f30c42c5b3@sifive.com>
Date:   Mon, 27 Nov 2023 08:32:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] RISC-V: Expose Ssdtso via hwprobe API
Content-Language: en-US
To:     Christoph Muellner <christoph.muellner@vrull.eu>
References: <20231124072142.2786653-1-christoph.muellner@vrull.eu>
 <20231124072142.2786653-3-christoph.muellner@vrull.eu>
Cc:     linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Guo Ren <guoren@kernel.org>,
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Daniel Lustig <dlustig@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20231124072142.2786653-3-christoph.muellner@vrull.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 2023-11-24 1:21 AM, Christoph Muellner wrote:
> From: Christoph Müllner <christoph.muellner@vrull.eu>
> 
> This patch adds Ssdtso to the list of extensions which
> are announced to user-space using te hwprobe API.
> 
> Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
> ---
>  Documentation/arch/riscv/hwprobe.rst  | 3 +++
>  arch/riscv/include/uapi/asm/hwprobe.h | 1 +
>  arch/riscv/kernel/sys_riscv.c         | 1 +
>  3 files changed, 5 insertions(+)
> 
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
> index 7b2384de471f..8de3349e0ca2 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -80,6 +80,9 @@ The following keys are defined:
>    * :c:macro:`RISCV_HWPROBE_EXT_ZICBOZ`: The Zicboz extension is supported, as
>         ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
>  
> +  * :c:macro:`RISCV_HWPROBE_EXT_ZICBOZ`: The Ssdtso extension is supported, as

Should be RISCV_HWPROBE_EXT_SSDTSO.

Regards,
Samuel

> +       in version v1.0-draft2 of the corresponding extension.
> +
>  * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
>    information about the selected set of processors.
>  
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> index b659ffcfcdb4..ed450c64e6b2 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -30,6 +30,7 @@ struct riscv_hwprobe {
>  #define		RISCV_HWPROBE_EXT_ZBB		(1 << 4)
>  #define		RISCV_HWPROBE_EXT_ZBS		(1 << 5)
>  #define		RISCV_HWPROBE_EXT_ZICBOZ	(1 << 6)
> +#define		RISCV_HWPROBE_EXT_SSDTSO	(1 << 7)
>  #define RISCV_HWPROBE_KEY_CPUPERF_0	5
>  #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
>  #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> index c712037dbe10..c654f43b9699 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -162,6 +162,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
>  		EXT_KEY(ZBB);
>  		EXT_KEY(ZBS);
>  		EXT_KEY(ZICBOZ);
> +		EXT_KEY(SSDTSO);
>  #undef EXT_KEY
>  	}
>  


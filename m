Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AF67C6E66
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378293AbjJLMn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343872AbjJLMnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:43:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7743091
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:43:22 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32337a39009so187740f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697114601; x=1697719401; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2PTo8D4RniwPWfnLSwST03jUfEH27ZqxImSpo2iKD0U=;
        b=xTm8VeR1s4Ey3xDL8WHa6fujFaMERiqYYcVLGrxeCLtMYPa8JCfAwLR6HP4PHtN+ax
         Wgz/4unSb/hd+v6I23T+k7Ri30qSUtsuhE8qQjHQ6SE80QKUGEbgQPig/2SrcG6828sk
         /D+Iv9be+NBO3PDIYlIuwYHIPOerBhY4njJeeJ9jHpmsv+UxZB9Rr0a7GY4QbS3Vj1Fm
         7BhWQXo7Pf0Zap5uIdEPqKb33l/OG83gXtBcfEvkkWF2yNrzUuxUPaiRgstoU+VXryEZ
         sjeVP7xFZhnVntlcfE0/zeReJ5DZmoy935nVGcQNebGFEaSuM10uQg0B/Lf+nu/U4bdX
         z7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697114601; x=1697719401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2PTo8D4RniwPWfnLSwST03jUfEH27ZqxImSpo2iKD0U=;
        b=S2pObqvj9uSbPgmr3BJzvgv+xtXtG6nf/DgiH3raQVbteSCWwiC0b7kSJoRvygYy9z
         d2vsAR8Ydy9adcOtFP+4xFbzGLviO0rVpFf03T5TtodC0Vl3YwdREuzlhuh1997L2VlO
         rKZP3K+/MaMm0QF3brSJ4P4apdMjrY3eL/smP4mgCjGgqaiRXotKDDIPfy2xGNdTVTMV
         sjH9XEc8J3KgVbLbvHH7ybcjDg9gmoZaBm4bt022kixlLtlCWzltDHtxBe8tRWz6I6Vn
         4SaXe8Sh3Jn+K3/E0xJ9hdjJiRO3STTxD9Rp2fcwpEEdgLHlJ0ds+Osnh4nZMY6VwWuy
         s71g==
X-Gm-Message-State: AOJu0YxQidEiVQnfBUW7/AM8TO3DsKSOV5DjUpMWgddxzm8lJY7Cqmio
        YyktknuXpab0d5ehkFOowhryyg==
X-Google-Smtp-Source: AGHT+IH68Cupe5msSVy6FrdJwuGjM46iOIqt4/Ht702cWr2lracdmexvQeKL+NR6J36QnG7vRCBFKg==
X-Received: by 2002:adf:cf0a:0:b0:31a:e54e:c790 with SMTP id o10-20020adfcf0a000000b0031ae54ec790mr20264351wrj.6.1697114600879;
        Thu, 12 Oct 2023 05:43:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:3fed:c1e5:145f:8179? ([2a01:e0a:999:a3a0:3fed:c1e5:145f:8179])
        by smtp.gmail.com with ESMTPSA id v6-20020adff686000000b0031980294e9fsm18116898wrp.116.2023.10.12.05.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 05:43:20 -0700 (PDT)
Message-ID: <41b3c8c8-260d-4de1-92a4-245973274a60@rivosinc.com>
Date:   Thu, 12 Oct 2023 14:43:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] riscv: errata: thead: use riscv_nonstd_cache_ops
 for CMO
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
References: <20231001103433.3187-1-jszhang@kernel.org>
 <20231001103433.3187-2-jszhang@kernel.org>
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20231001103433.3187-2-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/10/2023 12:34, Jisheng Zhang wrote:
> Previously, we use alternative mechanism to dynamically patch
> the CMO operations for THEAD C906/C910 during boot for performance
> reason. But as pointed out by Arnd, "there is already a significant
> cost in accessing the invalidated cache lines afterwards, which is
> likely going to be much higher than the cost of an indirect branch".
> And indeed, there's no performance difference with GMAC and EMMC per
> my test on Sipeed Lichee Pi 4A board.
> 
> Use riscv_nonstd_cache_ops for THEAD C906/C910 CMO to simplify
> the alternative code, and to acchieve Arnd's goal -- "I think
> moving the THEAD ops at the same level as all nonstandard operations
> makes sense, but I'd still leave CMO as an explicit fast path that
> avoids the indirect branch. This seems like the right thing to do both
> for readability and for platforms on which the indirect branch has a
> noticeable overhead."
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Tested-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> ---
>  arch/riscv/Kconfig.errata            |  1 +
>  arch/riscv/errata/thead/errata.c     | 75 +++++++++++++++++++++++++++-
>  arch/riscv/include/asm/errata_list.h | 50 +++----------------
>  3 files changed, 80 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> index 566bcefeab50..d7972914f9de 100644
> --- a/arch/riscv/Kconfig.errata
> +++ b/arch/riscv/Kconfig.errata
> @@ -78,6 +78,7 @@ config ERRATA_THEAD_CMO
>  	bool "Apply T-Head cache management errata"
>  	depends on ERRATA_THEAD && MMU
>  	select RISCV_DMA_NONCOHERENT
> +	select RISCV_NONSTANDARD_CACHE_OPS
>  	default y
>  	help
>  	  This will apply the cache management errata to handle the
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> index 0554ed4bf087..3fefeb1b456e 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -12,8 +12,10 @@
>  #include <asm/alternative.h>
>  #include <asm/cacheflush.h>
>  #include <asm/cpufeature.h>
> +#include <asm/dma-noncoherent.h>
>  #include <asm/errata_list.h>
>  #include <asm/hwprobe.h>
> +#include <asm/io.h>
>  #include <asm/patch.h>
>  #include <asm/vendorid_list.h>
>  
> @@ -33,6 +35,75 @@ static bool errata_probe_pbmt(unsigned int stage,
>  	return false;
>  }
>  
> +/*
> + * dcache.ipa rs1 (invalidate, physical address)
> + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> + *   0000001    01010      rs1       000      00000  0001011
> + * dache.iva rs1 (invalida, virtual address)

Small typo here: invalidate instead of invalida

Thanks,

Clément

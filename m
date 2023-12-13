Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD828113C5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbjLMNzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbjLMNy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:54:58 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6B0D4D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:52:56 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c31f18274so65112075e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702475536; x=1703080336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PTROWi090VipJqK8OYHPEAxaQ5DHXWxJFjKYJmaz5R0=;
        b=A95HT764fiLL7ms92fZISKQ35BNeohhRyD+oaUKWGxBw1YEqGqwmU1Cc9qFBwgqdpu
         /mls630FnXkQLDq+D8z84e7jiizeAEGeCE0efZgncB8C1iY3VnjaM2KrYMM7cazWXnPZ
         vozpm0lqRTm5unbu7CyBTudS/d7rxmGZl4NErYy3zwp/QGMNOudxLi7e+okNuzX52SSe
         rFfdqGOzvI1kALr0KPWk4A+PJMOBSzCzSK1YWfPJEQ2sFqngOzC4YrILmRQBmxYGxHSr
         Ttj9NnKWU8MdAO3/JEFZiTqTvYBJTwgqcLv+Tfyeu+aqPOlkeR8tYmRn2aTvudWxpynO
         4E9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702475536; x=1703080336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTROWi090VipJqK8OYHPEAxaQ5DHXWxJFjKYJmaz5R0=;
        b=WTAyKjFSAYl31Qk3a/gPQqrc3Ia2wOYQtNLsQhosJbVf91PLHUt9pkWo9f1Qv82ufS
         RhQKkH7dwg6+UApg11O5dY3x6lgpS+p/hTkqiCuojslMjifdoxyprO+L9tEQirwrYAN+
         b/sufZHQ+9KbnJ0w7UcMUI0/fsqdkE4OpJTzhSVNTU2mlCzrJLJmhGVoR/y+dCDZcl+M
         FycBuEhxvwxTRU7Mda/wrBeQbCZVvS3r4+x0wzLeoL6FI4++3mIfHEkrUc9+OCynFGyy
         wWxvqSR6qeBPneGZtRd0ZnKFFlxoS/EZqB06qLewNGkTQjty49lJyY6xujyhzxf/OoUA
         AiiA==
X-Gm-Message-State: AOJu0Yw9cE8H6eIm6wQH4dAUv1mSAVIe3lNthIUgyxa0NtAtRiMeAgGm
        VvKN3w/GspnynMH00XLyIUavCQ==
X-Google-Smtp-Source: AGHT+IF5kmk8LVZ85W7N3gISbpDLPY8LvD+Hn6K1kJJ6Gm74g8cpX+vaNl8XPZV2r1+Itxbw0xZgcg==
X-Received: by 2002:a05:600c:220f:b0:40c:2100:60b1 with SMTP id z15-20020a05600c220f00b0040c210060b1mr3672409wml.178.1702475536469;
        Wed, 13 Dec 2023 05:52:16 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id s13-20020a05600c384d00b004030e8ff964sm22836432wmr.34.2023.12.13.05.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 05:52:16 -0800 (PST)
Date:   Wed, 13 Dec 2023 14:52:15 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        wchen <waylingii@gmail.com>, Jisheng Zhang <jszhang@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Minda Chen <minda.chen@starfivetech.com>,
        Sean Christopherson <seanjc@google.com>,
        Like Xu <likexu@tencent.com>, Peter Xu <peterx@redhat.com>,
        Vipin Sharma <vipinsh@google.com>,
        Thomas Huth <thuth@redhat.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v4 03/11] KVM: selftests: Add CONFIG_64BIT definition for
 the build
Message-ID: <20231213-b7a894416841716b792da2d5@orel>
References: <cover.1702371136.git.haibo1.xu@intel.com>
 <227b86955b24583b5cacedc8480e8f5d7e4fabf8.1702371136.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <227b86955b24583b5cacedc8480e8f5d7e4fabf8.1702371136.git.haibo1.xu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 05:31:12PM +0800, Haibo Xu wrote:
> Since only 64bit KVM selftests were supported on all architectures,
> add the CONFIG_64BIT definition in kvm/Makefile to ensure only 64bit
> definitions were available in the corresponding included files.
> 
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  tools/testing/selftests/kvm/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 4838ea899bbb..bb03e278a163 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -225,7 +225,7 @@ else
>  LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
>  endif
>  CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
> -	-Wno-gnu-variable-sized-type-not-at-end -MD\
> +	-Wno-gnu-variable-sized-type-not-at-end -MD -DCONFIG_64BIT \
>  	-fno-builtin-memcmp -fno-builtin-memcpy -fno-builtin-memset \
>  	-fno-builtin-strnlen \
>  	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

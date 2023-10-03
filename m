Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF09E7B6666
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjJCK2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjJCK2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:28:50 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFD393
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 03:28:46 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9a645e54806so127831566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 03:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1696328924; x=1696933724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XsdqrdEkDSj8N1JGo8GS+Y+t1N9Ffxo49rjL66LLWiU=;
        b=AnijDntiuPAlvazd2otnRUr/eS5Rx8+nCMfjIoN2pNGVEWpMW1eIaGTuNPQo5lMZcY
         3uDN84z7/CxAU2z0vhjs22weuKICOxhF7xp229U53IqDKWoljoj2qysJwphNIyc1dUip
         EQhBPjIvyAFkiDpbDvopG0HFcJht+Mkh95OYUfUJtdLFVY3ZRZC+hEPZN4wLFPoQEicF
         FQTo/Dhc9a/ySVVpF5z95os3QmtNrQYeTQl/M37TRvTPDO4luKYY1KzP+cweByzw3neE
         uCrfdZNfm20LZiVUhLVDdFuY1IGh030qyzoWbnhkBxe56jlSBKaJHIIAOZ4piJs37Zzp
         UTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696328924; x=1696933724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsdqrdEkDSj8N1JGo8GS+Y+t1N9Ffxo49rjL66LLWiU=;
        b=jOtbAL5A+3SsCshjKZTLzJOXnhYfFazsexWIBn2dBHUddcZ/+FN6kHEJ3ea0hIJoun
         vuOHx/0UB51oDX7Rjd3Jn1HPZq2YzwNLejZ/7tJ5o+lkAzWh1UGBXABMnMqqsL/2jfLC
         F9aLaYguOcJ+JKEwEBBRwA1ySpYqTDQj/JIvCA1wsvYUyQLKxuJ+yKx/qdWW0C0YqSIE
         A4clNG0tgqfNWkIJN0FtbPAEWDOfAJZonXQW7P5dt4Tx4IKQ7md1pLlccCSIvnqPKY6f
         /E8RuZmvRg1fPXM3BKdzO1e2z54yKni6DYO/ChmH+llOujr1AuILOqhixojqissf1g0q
         zknw==
X-Gm-Message-State: AOJu0YwDG4V3bAxLJF9NA1QJPZBkogRrLHmPSLCNZgbIT/VHudDdy9yL
        M2Rds5WU5fyKHPT6kCrsahP00Q==
X-Google-Smtp-Source: AGHT+IG9ar/of5h3vBdRHdNrUbHgfPXCJHKRmFUO92+SzwFtgCwBykQiZdbI9ipIbOFvP0+0VOSg1w==
X-Received: by 2002:a17:906:109e:b0:9ae:6d0:84f7 with SMTP id u30-20020a170906109e00b009ae06d084f7mr11197111eju.32.1696328924382;
        Tue, 03 Oct 2023 03:28:44 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id op19-20020a170906bcf300b009adc743340fsm822007ejb.197.2023.10.03.03.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 03:28:43 -0700 (PDT)
Date:   Tue, 3 Oct 2023 12:28:42 +0200
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
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v3 2/9] KVM: selftests: Unify the makefile rule for split
 targets
Message-ID: <20231003-d44206f71d0b22e539833697@orel>
References: <cover.1694421911.git.haibo1.xu@intel.com>
 <cda6cc71c9bdde87fe87f6c2dec4f03ca249dd62.1694421911.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda6cc71c9bdde87fe87f6c2dec4f03ca249dd62.1694421911.git.haibo1.xu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 09:36:56AM +0800, Haibo Xu wrote:
> A separate makefile rule was used for split targets which was added
> in patch(KVM: arm64: selftests: Split get-reg-list test code). This
> could be avoided by minor changes to the recipes of current rule.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  tools/testing/selftests/kvm/Makefile | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index a3bb36fb3cfc..7972269e8c5f 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -249,13 +249,10 @@ TEST_DEP_FILES += $(patsubst %.o, %.d, $(SPLIT_TESTS_OBJS))
>  -include $(TEST_DEP_FILES)
>  
>  $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): %: %.o
> -	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBKVM_OBJS) $(LDLIBS) -o $@
> +	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $^ $(LDLIBS) -o $@
>  $(TEST_GEN_OBJ): $(OUTPUT)/%.o: %.c
>  	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
>  
> -$(SPLIT_TESTS_TARGETS): %: %.o $(SPLIT_TESTS_OBJS)
> -	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $^ $(LDLIBS) -o $@
> -
>  EXTRA_CLEAN += $(LIBKVM_OBJS) $(TEST_DEP_FILES) $(TEST_GEN_OBJ) $(SPLIT_TESTS_OBJS) cscope.*
>  
>  x := $(shell mkdir -p $(sort $(dir $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ))))
> @@ -274,6 +271,7 @@ $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
>  x := $(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
>  $(TEST_GEN_PROGS): $(LIBKVM_OBJS)
>  $(TEST_GEN_PROGS_EXTENDED): $(LIBKVM_OBJS)
> +$(SPLIT_TESTS_TARGETS): $(OUTPUT)/%: $(ARCH_DIR)/%.o
>  
>  cscope: include_paths = $(LINUX_TOOL_INCLUDE) $(LINUX_HDR_PATH) include lib ..
>  cscope:
> -- 
> 2.34.1
>

I just noticed that with and without this patch we're building the
arch-specific part in tools/testing/selftests/kvm/riscv even when we have
an $(OUTPUT) directory (e.g. O=build). Those build artifacts should be in
build/kselftest/kvm/riscv instead.

Thanks,
drew

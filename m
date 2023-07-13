Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6E1752059
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbjGMLrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbjGMLrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:47:06 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB15F1980
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:47:04 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fba86f069bso1052139e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1689248823; x=1691840823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QkC/3t6yahhwYAX2k86ggdtjKfFNk+a6lEAlP8/kgtI=;
        b=XAKsv4MoO/pKibEQ1G2CxsRmfD4VxbDZYvIirjY6OXu8ih4sjnTABAP2qIo5bTi/QD
         SHFBqh/cuCdWLLorn87tm9mdBEO3tFDBINMZBhaRv/sSKTWvZQ00GwJG0l0DVPQ5etLW
         pUrf64TZuPnwMe1Xadtq7tOKmmCJeuzF94VxWwrJ6lPrTBNevvDfLzBfGsl3vm5yud/9
         xGls/5rypS0CrWc0LgHmAZy8sKQPiD5bVYStR5VB9s9ab6xeWbUqrqLfBGGLsnWb0UzF
         ekNn1bl8z9lJGkYkNLyHscniyNBZij/Xj9bKz/r0y+lJRLguC1gcAx33nnZW8phrdHtU
         CUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689248823; x=1691840823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkC/3t6yahhwYAX2k86ggdtjKfFNk+a6lEAlP8/kgtI=;
        b=fU5tOUXvghp+8nC6d4xYrrNIzptXK+6yQqyXJmF1JCMgJt9tB59Lk5Xcj2AEXv/Y2r
         sDZ5ktZZSwtU3OUS4Ic/I2sanjjwNB6vK8V8TqpZOdnhk6waKpUQbHSKfKz0YH10ZnfV
         LWHFJ1nWJOlOgYTpaV89lyqEaFepABeuJzu42BBBeVsIsJMU6/WS8DzdcEe46rbDnwRV
         cQ4suAML4V2YkbfKUoFvADCbMvoNcVvsXzGyr8bzjQxQ9pdvygdoD5fcrX3K8vmT/zdW
         9//TlEsAJiqkywT3yPkXYfZZ63947fVkbF0CLCZbAmm5WwFIAgNBkFaWg079MI9TNrYF
         t2qw==
X-Gm-Message-State: ABy/qLaDZ8O50Mv1ff3MR1WoZX4kqTVQc53JGIuCHjxrcw+li3aMmMAT
        uBnG9WHUGLRqT27oAdslLFSfgw==
X-Google-Smtp-Source: APBJJlF6RRZg1uMcOi0ji+OK2OsaBE+8f5isAdIDj2SLfzUC25uBdhHZhXHCZHvkywy8/uPhboxaTA==
X-Received: by 2002:a05:6512:4002:b0:4f9:69e9:4fa6 with SMTP id br2-20020a056512400200b004f969e94fa6mr1149012lfb.23.1689248823117;
        Thu, 13 Jul 2023 04:47:03 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id y26-20020a056402135a00b0051e0c0d0a8bsm4166887edw.7.2023.07.13.04.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 04:47:02 -0700 (PDT)
Date:   Thu, 13 Jul 2023 13:47:01 +0200
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
Subject: Re: [PATCH 5/7] RISC-V: KVM: Sort ISA extensions alphabetically in
 ONE_REG interface
Message-ID: <20230713-8e31c6213e0d7359898b7c17@orel>
References: <20230712161047.1764756-1-apatel@ventanamicro.com>
 <20230712161047.1764756-6-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712161047.1764756-6-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 09:40:45PM +0530, Anup Patel wrote:
> Let us sort isa extensions alphabetically in kvm_isa_ext_arr[] and
> kvm_riscv_vcpu_isa_disable_allowed() so that future insertions are
> more predictable.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/kvm/vcpu_onereg.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

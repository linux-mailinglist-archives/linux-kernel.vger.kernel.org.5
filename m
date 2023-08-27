Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2199F78A166
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 22:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjH0Uf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 16:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjH0Uf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 16:35:26 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EF7127;
        Sun, 27 Aug 2023 13:35:24 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so7345053a12.1;
        Sun, 27 Aug 2023 13:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693168522; x=1693773322;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tdmuji/W/78o9EtHwL+JzoXBf9mqsVcxBfeCxlt2PZU=;
        b=aKgXg3fVYHKOzKjCht8IRUo2h7TYJ/yKSoC/n3RcGVetO4Uu331be4SzHs8VbEoyZH
         5PA2lAL3iRUp8bRAdM6e1y407h/zKUKbXy2n0gTTj0QPFLVqtKa8CMO+KT/zVTs3m/7i
         5BAYa5IZnr4lpPbCKq35T9n+jxys3kzID4xGZmAu2tcFd5WO6STkvtr/GY7R5PsOTvGq
         6dkFKsCdYWN9nXq1c131h/i0KIxhibsQGYfDLIagAAkkRlztQUH3VRLHdVViZpb7ue/N
         kj5e5/2VhskRCQghd80wponTWq10ySGgxRe+npr9X4wCG2X264XEbkqpaCq/xrnaRY6W
         wOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693168522; x=1693773322;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tdmuji/W/78o9EtHwL+JzoXBf9mqsVcxBfeCxlt2PZU=;
        b=DrqB4CdBSKw+OGDX7UFHpy41jX8rvcZGUFjU15v+CWBPtzZnZrjBDY4UGFY/DjRr+D
         dan5zCPW5FHdW/80BW+wDsi1qX7/75X0UETCNm/AzMEuWXY2c+SXK52PEdT6rOvWstzx
         MddCFJ5fIoa2iljnVwFxvxY9Dp4eNx1sJ/jXL5U7Ao3bxluEH3ezNFqrvhTeMQsH/rJv
         eWuYPNblyqNlWmvHb+onTpX7JmivOjmTdQdEioQTjl25b758B170gvdj76n4yc8OfY4r
         pNMFf/V3y1WezMUB3bmxYHWGlfJlOFt036WHkvtzRzfwKDXWERGXJ6/uvS1T5EeJ6ruZ
         EqFw==
X-Gm-Message-State: AOJu0YzNjd4GfTZBQb0WrJIWC+VmTcFpVyWKmsL0iqwUDVQFHewW0MTk
        IJEcvJEtEcWi5B2e11/zMfU=
X-Google-Smtp-Source: AGHT+IGHniIaOVrRE2PcfpimVnCxJswxCY0hAnsvcig3JUrKxAYxOpkzgXqOvOr/2l1sAhAUOdcVZA==
X-Received: by 2002:a17:907:e92:b0:9a2:25da:d71e with SMTP id ho18-20020a1709070e9200b009a225dad71emr8748989ejc.0.1693168522455;
        Sun, 27 Aug 2023 13:35:22 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id q24-20020a17090622d800b0099d804da2e9sm3770795eja.225.2023.08.27.13.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 13:35:21 -0700 (PDT)
Date:   Sun, 27 Aug 2023 22:35:21 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] riscv: Only consider swbp/ss handlers for correct
 privileged mode
Message-ID: <ZOuziWaJpYV0LfB3@nam-dell>
References: <20230827114003.224958-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230827114003.224958-1-bjorn@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 01:40:03PM +0200, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> RISC-V software breakpoint trap handlers are used for {k,u}probes.
> 
> When trapping from kernelmode, only the kernelmode handlers should be
> considered. Vice versa, only usermode handlers for usermode
> traps. This is not the case on RISC-V, which can trigger a bug if a
> userspace process uses uprobes, and a WARN() is triggered from
> kernelmode (which is implemented via {c.,}ebreak).
> 
> The kernel will trap on the kernelmode {c.,}ebreak, look for uprobes
> handlers, realize incorrectly that uprobes need to be handled, and
> exit the trap handler early. The trap returns to re-executing the
> {c.,}ebreak, and enter an infinite trap-loop.
> 
> The issue was found running the BPF selftest [1].
> 
> Fix this issue by only considering the swbp/ss handlers for
> kernel/usermode respectively. Also, move CONFIG ifdeffery from traps.c
> to the asm/{k,u}probes.h headers.
> 
> Note that linux/uprobes.h only include asm/uprobes.h if CONFIG_UPROBES
> is defined, which is why asm/uprobes.h needs to be unconditionally
> included in traps.c
> 
> Link: https://lore.kernel.org/linux-riscv/87v8d19aun.fsf@all.your.base.are.belong.to.us/ # [1]
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308271841.HlnnHFL7-lkp@intel.com/
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Fixes: 74784081aac8 ("riscv: Add uprobes supported")
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>

Reviewed-by: Nam Cao <namcaov@gmail.com>

Best regards,
Nam

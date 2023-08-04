Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E8F7708C6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjHDTQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHDTQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:16:28 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2F213E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 12:16:27 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c136ee106so336602966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 12:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691176585; x=1691781385;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TpiHH7yxmEW4ZBDV3OldglgWshd7L0knNrNdUQpdioM=;
        b=YAJzdBxxg5mIQRYms2BEh1R5Vm+87M4Q4TxeLUT6RyrNijHzA/zfWa8H8kWGxrNPHb
         pLSQGkFGRC+bMMLmtKGGjHbeBd7mRqnaM0RKHQ2SMoRcTLsMqb2dROGdWVGPAC4ALPFF
         p1+gVQ4GPOE3Cm6pvuRdA+HVsql1vapaQmn19SIqM+B3mtcjWWQBA2y/6aduYUN4jb+t
         CcZst0NISMfL4c15+SsZy4YBTodkMOkR0y62BIV5NxDTS3XIY4ZukAzfDH8UEOmg/qkZ
         ocgWF8BBF4w8GT1kFaFlkO+lMdUN61/bXJOa6YS6Dj8y40C6WWgdChIiQ6VVDs1Yl3hO
         TP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691176585; x=1691781385;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TpiHH7yxmEW4ZBDV3OldglgWshd7L0knNrNdUQpdioM=;
        b=gwSAkKhX/X8ExYIiYLPgx+jj85T5Th7+aSJ1LK/WnSglWmIzaX1m6JmYcTu5vjU7Rk
         g8bvTpWP59sbzj1153WRYCjJCOVONG21jh0iWyOVD88u+pR3D+eU/aMMx3kmZRoVIY0k
         5BdUAsCrocbDXj3FziyLM5Wja2W0g1tbayVhabJzTSXx4Mp2DLZlUFyS33eZ3ZtGrgzg
         KhiOOZWl7QBk/YloMaLCl7x2hiRNB8D96rb03xd3ltQL+pKVyRBfplzfVR3lLoJwXh4a
         bAI/60JvJne9hFxJWA108JcrtM4EHtFHcCCUjTFhxRViS6isZ7XWbhbGDj/ZkA+5sOTt
         sqgQ==
X-Gm-Message-State: AOJu0YwV+ymfzQ0Nt2qLghEqTFae03jRuiQD/irFfaZ1bL7pZoejO28U
        Nyi+2of1MvAhknwSGDjK3WQ=
X-Google-Smtp-Source: AGHT+IGjiRI/I3SynytvWznDJVkkJOCwpXVTgQMOfC1uzhrWOpNOGeKDVgG0KCt2koY6YDgn1s2Ftg==
X-Received: by 2002:a17:906:2182:b0:991:e7c2:d0be with SMTP id 2-20020a170906218200b00991e7c2d0bemr2435265eju.63.1691176585274;
        Fri, 04 Aug 2023 12:16:25 -0700 (PDT)
Received: from andrea (host-82-57-177-142.retail.telecomitalia.it. [82.57.177.142])
        by smtp.gmail.com with ESMTPSA id d24-20020a170906c21800b00989828a42e8sm1693018ejz.154.2023.08.04.12.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 12:16:24 -0700 (PDT)
Date:   Fri, 4 Aug 2023 21:16:20 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     paulmck@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, mmaas@google.com, hboehm@google.com,
        striker@us.ibm.com
Subject: Re: [RFC PATCH] membarrier: riscv: Provide core serializing command
Message-ID: <ZM1OhJY8/PZ/osTH@andrea>
References: <20230803040111.5101-1-parri.andrea@gmail.com>
 <ZMvLoI6PxLR8RJvR@andrea>
 <4bf79f06-4593-134a-04dd-b8f89e96a1b8@efficios.com>
 <ZMxDe0gXKYbY5jgt@andrea>
 <65350c17-3fcf-a057-a280-f6a5d36dcb21@efficios.com>
 <ZM0STfpkRSfNQBt8@andrea>
 <ab562167-e4a5-4a7d-7722-a4f99848d63e@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab562167-e4a5-4a7d-7722-a4f99848d63e@efficios.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 02:05:55PM -0400, Mathieu Desnoyers wrote:
> On 8/4/23 10:59, Andrea Parri wrote:
> > > What is the relationship between FENCE.I and instruction cache flush on
> > > RISC-V ?
> > 
> > The exact nature of this relationship is implementation-dependent.  From
> > commentary included in the ISA portion referred to in the changelog:
> > 
> >    A simple implementation can flush the local instruction cache and
> >    the instruction pipeline when the FENCE.I is executed.  A more
> >    complex implementation might snoop the instruction (data) cache on
> >    every data (instruction) cache miss, or use an inclusive unified
> >    private L2 cache to invalidate lines from the primary instruction
> >    cache when they are being written by a local store instruction.  If
> >    instruction and data caches are kept coherent in this way, or if
> >    the memory system consists of only uncached RAMs, then just the
> >    fetch pipeline needs to be flushed at a FENCE.I.  [..]
> > 
> > Mmh, does this help?
> 
> Quoting
> 
> https://github.com/riscv/riscv-isa-manual/releases/download/Ratified-IMAFDQC/riscv-spec-20191213.pdf
> 
> Chapter 3 "“Zifencei” Instruction-Fetch Fence, Version 2.0"
> 
> "First, it has been recognized that on some systems, FENCE.I will be expensive to implement
> and alternate mechanisms are being discussed in the memory model task group. In particular,
> for designs that have an incoherent instruction cache and an incoherent data cache, or where
> the instruction cache refill does not snoop a coherent data cache, both caches must be completely
> flushed when a FENCE.I instruction is encountered. This problem is exacerbated when there are
> multiple levels of I and D cache in front of a unified cache or outer memory system.
> 
> Second, the instruction is not powerful enough to make available at user level in a Unix-like
> operating system environment. The FENCE.I only synchronizes the local hart, and the OS can
> reschedule the user hart to a different physical hart after the FENCE.I. This would require the
> OS to execute an additional FENCE.I as part of every context migration. For this reason, the
> standard Linux ABI has removed FENCE.I from user-level and now requires a system call to
> maintain instruction-fetch coherence, which allows the OS to minimize the number of FENCE.I
> executions required on current systems and provides forward-compatibility with future improved
> instruction-fetch coherence mechanisms.
> 
> Future approaches to instruction-fetch coherence under discussion include providing more
> restricted versions of FENCE.I that only target a given address specified in rs1, and/or allowing
> software to use an ABI that relies on machine-mode cache-maintenance operations."
> 
> I start to suspect that even the people working on the riscv memory model have noticed
> that letting a single instruction such as FENCE.I take care of both cache coherency
> *and* flush the instruction pipeline will be a performance bottleneck, because it
> can only clear the whole instruction cache.
> 
> Other architectures are either cache-coherent, or have cache flushing which can be
> performed on a range of addresses. This is kept apart from whatever instruction
> flushes the instruction pipeline of the processor.
> 
> By keeping instruction cache flushing separate from instruction pipeline flush, we can
> let membarrier (and context switches, including thread migration) only care about the
> instruction pipeline part, and leave instruction cache flush to either a dedicated
> system call, or to specialized instructions which are available from user-mode.
> 
> Considering that FENCE.I is forced to invalidate the whole i-cache, I don't think you
> will get away with executing it from switch_mm without making performance go down the
> drain on cache incoherent implementations.
> 
> In my opinion, what we would need from RISC-V for membarrier (and context switch) is a
> lightweight version of FENCE.I which only flushes the instruction pipeline of the local
> processor. This should ideally come with a way for architectures with incoherent caches
> to flush the relevant address ranges of the i-cache which are modified by a JIT. This
> i-cache flush would not be required to flush the instruction pipeline, as it is typical
> to batch invalidation of various address ranges together and issue a single instruction
> pipeline flush on each CPU at the end. The i-cache flush could either be done by new
> instructions available from user-space (similar to aarch64), or through privileged
> instructions available through system calls (similar to arm cacheflush).

Thanks for the remarks, Mathieu.  I think it will be very helpful to
RISC-V architects (and memory model people) to have this context and
reasoning written down.

  Andrea

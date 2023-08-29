Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CBA78CC82
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238534AbjH2SzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238602AbjH2Sy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:54:59 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2667719A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:54:56 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bf8e5ab39so626037066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693335294; x=1693940094;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7rkeLzlKLJm6uIQxs6qrmHZPlBWb8A/YK44W7thpWJg=;
        b=Q6SSiEaCrCkveJreuDnQ2goaa7FhBqB8eCiRKCGytyRoe1AQaSX/9r06XagFo7RffS
         yobhr3xSrN3Cv32B4w0M9rzuiZ70qTqmC+fM3sGRMETsTMPLEUfwcqkuKAU6NHAGk7OU
         R3wJuKLczA9Wz2ZVEwLcymk7BJQIKugtPaeIgEmTKbfMdoGq06run9f/+B7RxpVLPp/t
         NxtsWVAh294H/o+XsBFU3dfZSm1mErvi4VKIPWuB6DpyLHi9evttCzrW5OUdvojTb0Jf
         sP3mBl3F4b+aUQGn+sqb8grhjMfQdhkAJSYDtvf1MAyYoxPT9pt5HPMwF5UdPCa9fMqf
         1A9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693335294; x=1693940094;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7rkeLzlKLJm6uIQxs6qrmHZPlBWb8A/YK44W7thpWJg=;
        b=gpK8y9tjHpiWwnwspCcnl7+3ckZO0uaR76sOduAKpE6uOZ3ogiABBF5uArgPlERL4Q
         YgIimiCCqVkg3wjuuR98UZWQ/Ybb5G4QMF+9oMeZkMPLNJC0ynS3BVRnv7CkCHBe2hp3
         jheE9JEd5uW/jxc/jL4t78Qo4d1JFnVYVkAJ56bFqpmWGh8+9fO7sj2EkYOoBuempAyf
         nlvoWI7kcrQNEYvJJ41iFtmqaqcFQj/9FFUlRQDs9RcTEadcKuDMuz03Lso7cNlOtp+c
         E/cqaUcXmhuZnMJ5jMgfRq3nj4D08cwBRXnBeG0DbIUP5eRS+sGQFUCtR5ZZbrdF6FP2
         MxoQ==
X-Gm-Message-State: AOJu0YzhEaiGQ6eBoZsKR41x+UrcnJqyU+x7eOssvoM7RDugEptcbVnr
        8qnbMcD1MDm+cQ00EgDEO7mX2e8vAkQ=
X-Google-Smtp-Source: AGHT+IFcqzFt/WzR0tUdIWAOMjVgkWSBdToB/3XihxPZP5cmyTOr+ZsfKHhhDnE69wepr3vSv8v/Hg==
X-Received: by 2002:a17:906:cc52:b0:9a2:139:f466 with SMTP id mm18-20020a170906cc5200b009a20139f466mr12104379ejb.13.1693335294289;
        Tue, 29 Aug 2023 11:54:54 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id kb12-20020a1709070f8c00b0099297782aa9sm6195916ejc.49.2023.08.29.11.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 11:54:53 -0700 (PDT)
Date:   Tue, 29 Aug 2023 20:54:52 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guoren@kernel.org
Subject: Re: [PATCH] riscv: provide riscv-specific is_trap_insn()
Message-ID: <ZO4+/P9B29Bpb0Yz@nam-dell>
References: <20230827205641.46836-1-namcaov@gmail.com>
 <874jkjl4e1.fsf@all.your.base.are.belong.to.us>
 <ZOyhozSq3S36eRSq@nam-dell>
 <ZOymDqhE9STgx4Mm@nam-dell>
 <87edjmz864.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87edjmz864.fsf@all.your.base.are.belong.to.us>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 08:14:59AM +0200, Björn Töpel wrote:
> Nam Cao <namcaov@gmail.com> writes:
> 
> > On Mon, Aug 28, 2023 at 03:31:15PM +0200, Nam Cao wrote:
> >> On Mon, Aug 28, 2023 at 02:48:06PM +0200, Björn Töpel wrote:
> >> > Nam Cao <namcaov@gmail.com> writes:
> >> > 
> >> > > uprobes expects is_trap_insn() to return true for any trap instructions,
> >> > > not just the one used for installing uprobe. The current default
> >> > > implementation only returns true for 16-bit c.ebreak if C extension is
> >> > > enabled. This can confuse uprobes if a 32-bit ebreak generates a trap
> >> > > exception from userspace: uprobes asks is_trap_insn() who says there is no
> >> > > trap, so uprobes assume a probe was there before but has been removed, and
> >> > > return to the trap instruction. This cause an infinite loop of entering
> >> > > and exiting trap handler.
> >> > >
> >> > > Instead of using the default implementation, implement this function
> >> > > speficially for riscv which checks for both ebreak and c.ebreak.
> >> > 
> >> > I took this for a spin, and it indeed fixes this new hang! Nice!
> >> 
> >> Great! Thanks for testing it.
> >>  
> >> > However, when I tried setting an uprobe on the ebreak instruction
> >> > (offset 0x118) from your example [1], the probe does not show up in the
> >> > trace buffer.
> >> > 
> >> > Any ideas?
> >> 
> >> >From my understanding, both uprobes and kprobes refuse to install break points
> >> into existing trap instructions. Otherwise, we may conflict with something else
> >> that is also using trap instructions.
> >
> > I just realize you probably ask this because uprobe can still be installed before
> > applying the patch. But I think that is another bug that my patch also
> > accidentally fix: uprobes should not install breakpoint into ebreak instructions,
> > but it incorrectly does so because it does not even know about the existence of
> > 32-bit ebreak.
> 
> FWIW, I can still install the uprobe at an ebreak with you patch. It's
> not hit, but succeeds to install.

It seems uprobes install failures are completely silent (see uprobe_mmap() in
kernel/events/uprobes.c). So I think although uprobes install seems fine, it
actually is not.

Best regards,
Nam

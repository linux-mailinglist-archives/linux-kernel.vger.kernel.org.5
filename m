Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DE578B23F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjH1NuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjH1NuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:50:12 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666EBC0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:50:09 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99c0cb7285fso428297966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693230608; x=1693835408;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eYLHQZ/VfLwLQyibj4IKPDu2aeAoL6UJSE7o4fV5D3k=;
        b=EWucoSA6NQNmv6r92bln9D7hVGM10sQdVq+0ZKodxwMnW2akgpj6isYLJwfpWBTrEY
         mLIuBD3gztqz/r8rkQoCx1e66ihra6fnIEWqjgmggwnDlc3KNhnqyBfWKZL0ly6T+M9q
         bGRGFzIACsDkitfXZY1zyj4s7vtM+QeXWBfYNDiDD1RlzVzcgIsvIwYNQz/ea+FX6/3E
         yo4oeub9+M39khJF7uq5T8SVx1BV0jTo8XEL92te3is5AyAoLlFacJQq0v5WRmNQcZR4
         97+ZDXp/7lS5GvpX/xttTUxPxIR4vgKxQPz+wXtC2bMyb5VhcDxs5LDDkU4kUMlHuxKT
         ztuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693230608; x=1693835408;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eYLHQZ/VfLwLQyibj4IKPDu2aeAoL6UJSE7o4fV5D3k=;
        b=R7tr0VJgyMZlzpv6JN+3vj45Al2b9MHYhsOoX+yKXkgSDyrbDSoHvwY117Ag/efV3Y
         NXIKAv408zj8FiaeOeF7RNQyaX9R/ms3YrvBrxjYRVaqGuM2qCwBTXH9niraaf+bcXp6
         4/zeXGwqG5b4cQpJl5bLDKxSEfGXCG3NPJR+TWcJDNsQbBTTbkwAdjKtOUu7QhqYyb2Q
         4hKS/fVV1/d3mj3m8KNTLQUQZeYPv0hdy5qN+1COAQhc+lUxv6PleHxIp5JTUhteaI/1
         C4BCtUpAb8zaisa6oxM16LxFjx4NvvcGpXTigbdMiH2HmSfXw2BK8hVNTeR3c6o8Ah0M
         UObQ==
X-Gm-Message-State: AOJu0YyZuITeXjmQ3DaXytTdvQSdKrhiDJTytbWlD3rsf8O56Y7ZoH8l
        xVcnoq+FDBdxdJyxo1Zdtr8=
X-Google-Smtp-Source: AGHT+IEQC34b5l09N1nBCyWKKSCdGRenYmagb8UWJBwQctY4cJS3ep9dRRDx/kNRBmMD95wQPb8IYg==
X-Received: by 2002:a17:906:53d9:b0:9a1:aa7b:482e with SMTP id p25-20020a17090653d900b009a1aa7b482emr13917168ejo.26.1693230607614;
        Mon, 28 Aug 2023 06:50:07 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id p20-20020a17090635d400b0099bd8c1f67esm4696054ejb.109.2023.08.28.06.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 06:50:07 -0700 (PDT)
Date:   Mon, 28 Aug 2023 15:50:06 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guoren@kernel.org
Subject: Re: [PATCH] riscv: provide riscv-specific is_trap_insn()
Message-ID: <ZOymDqhE9STgx4Mm@nam-dell>
References: <20230827205641.46836-1-namcaov@gmail.com>
 <874jkjl4e1.fsf@all.your.base.are.belong.to.us>
 <ZOyhozSq3S36eRSq@nam-dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZOyhozSq3S36eRSq@nam-dell>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 03:31:15PM +0200, Nam Cao wrote:
> On Mon, Aug 28, 2023 at 02:48:06PM +0200, Björn Töpel wrote:
> > Nam Cao <namcaov@gmail.com> writes:
> > 
> > > uprobes expects is_trap_insn() to return true for any trap instructions,
> > > not just the one used for installing uprobe. The current default
> > > implementation only returns true for 16-bit c.ebreak if C extension is
> > > enabled. This can confuse uprobes if a 32-bit ebreak generates a trap
> > > exception from userspace: uprobes asks is_trap_insn() who says there is no
> > > trap, so uprobes assume a probe was there before but has been removed, and
> > > return to the trap instruction. This cause an infinite loop of entering
> > > and exiting trap handler.
> > >
> > > Instead of using the default implementation, implement this function
> > > speficially for riscv which checks for both ebreak and c.ebreak.
> > 
> > I took this for a spin, and it indeed fixes this new hang! Nice!
> 
> Great! Thanks for testing it.
>  
> > However, when I tried setting an uprobe on the ebreak instruction
> > (offset 0x118) from your example [1], the probe does not show up in the
> > trace buffer.
> > 
> > Any ideas?
> 
> >From my understanding, both uprobes and kprobes refuse to install break points
> into existing trap instructions. Otherwise, we may conflict with something else
> that is also using trap instructions.

I just realize you probably ask this because uprobe can still be installed before
applying the patch. But I think that is another bug that my patch also
accidentally fix: uprobes should not install breakpoint into ebreak instructions,
but it incorrectly does so because it does not even know about the existence of
32-bit ebreak.

Best regards,
Nam

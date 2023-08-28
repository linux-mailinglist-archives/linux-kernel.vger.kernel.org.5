Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2024A78B1ED
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjH1Nb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjH1NbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:31:20 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32007128
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:31:18 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c3c8adb27so395983666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693229476; x=1693834276;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J4F0xok8iSguLrceI1R+cP2UDwaDgtc8df9nO/kRk58=;
        b=Xq8Ut29lcHD8oi1Nrg6IVUoSD6PllAmapPg+i55jSjGmbEIXHur5rANJGut9k6ay8M
         MGN8cIsMJa3UEltfdTdU5LYnldRBRG8Hgy8aGS88W6VRD9LzTt4hO53OfRoVmdxWq12l
         cKX5365XOMY/PT2KKYqAt34YKAfKQBXo5P+ZNy1+JZRfMCF/m6I9eKuwz4Gf/0AyqbLL
         b7qhUmDqOBMrfpRMlVQPTSzH19nlQ0uNbrcxKA0+Zfh7OPuSQJMjJIV+IsfqNRRio8No
         Hdvzld3O6s/ozWpPApOVg1jXGMHAujS6q91dPkXuhaOw6JrdFq9SUXsvWmxY8JRkN2qD
         3elg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693229476; x=1693834276;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J4F0xok8iSguLrceI1R+cP2UDwaDgtc8df9nO/kRk58=;
        b=FU2WEcIfLuBIEif4ck+6GiQJGV5sUS++QXX980Ubgbljoo8nvyewSEvdGkulh7S/hm
         irZXqD+PnfWHCB+t0wZAn9nWkd+oP3fPDzaPXq/Pd0vqvpZjemRcDHirqNhAlILHs0hc
         G+IEUk8uGZM0J+l64ZHlhnkSvxSTq9iri7+uONkHFPv5gn1knG1KGuCNxBRyJ6AtIkQ3
         0gK1kVk/RA6yghdpvXPO/g4AEy3aE+kQz3454twSWSAfaQf0kTOga4gsdgirgsRWNqYN
         8NoxHA3GfyY+jcqkrguHz/kN59n8eDOsCKLM2+ORUBR0HkIxkjHw5IE7k4zS+yfkEouI
         Otxw==
X-Gm-Message-State: AOJu0YyPS61rFaOZ45qansB/fC6Kbo2gLXLYXsVYhTx3sys/afUBiNAo
        og/pumwas9MFJJwX4pHxpUg=
X-Google-Smtp-Source: AGHT+IEevoaUFlo+XVGkG/Su7M0zsQH3rcxIRPrBFo25Ik3pI5AToux6RP2Jye1EIsHpMOJ6Ax1p/g==
X-Received: by 2002:a17:906:3152:b0:9a1:d29c:6aaa with SMTP id e18-20020a170906315200b009a1d29c6aaamr11749253eje.39.1693229476398;
        Mon, 28 Aug 2023 06:31:16 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id p23-20020a170906839700b0099d9b50d786sm4670029ejx.199.2023.08.28.06.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 06:31:15 -0700 (PDT)
Date:   Mon, 28 Aug 2023 15:31:15 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guoren@kernel.org
Subject: Re: [PATCH] riscv: provide riscv-specific is_trap_insn()
Message-ID: <ZOyhozSq3S36eRSq@nam-dell>
References: <20230827205641.46836-1-namcaov@gmail.com>
 <874jkjl4e1.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874jkjl4e1.fsf@all.your.base.are.belong.to.us>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 02:48:06PM +0200, Björn Töpel wrote:
> Nam Cao <namcaov@gmail.com> writes:
> 
> > uprobes expects is_trap_insn() to return true for any trap instructions,
> > not just the one used for installing uprobe. The current default
> > implementation only returns true for 16-bit c.ebreak if C extension is
> > enabled. This can confuse uprobes if a 32-bit ebreak generates a trap
> > exception from userspace: uprobes asks is_trap_insn() who says there is no
> > trap, so uprobes assume a probe was there before but has been removed, and
> > return to the trap instruction. This cause an infinite loop of entering
> > and exiting trap handler.
> >
> > Instead of using the default implementation, implement this function
> > speficially for riscv which checks for both ebreak and c.ebreak.
> 
> I took this for a spin, and it indeed fixes this new hang! Nice!

Great! Thanks for testing it.
 
> However, when I tried setting an uprobe on the ebreak instruction
> (offset 0x118) from your example [1], the probe does not show up in the
> trace buffer.
> 
> Any ideas?

From my understanding, both uprobes and kprobes refuse to install break points
into existing trap instructions. Otherwise, we may conflict with something else
that is also using trap instructions.

Best regards,
Nam

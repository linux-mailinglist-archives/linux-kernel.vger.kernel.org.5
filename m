Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A883376EB3B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbjHCNxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjHCNxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:53:46 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F6D196
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 06:53:45 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so222864866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 06:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691070824; x=1691675624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ejd3tpdC1zaV/w7ewmBn4nRM+R1O4uRxApY6GI0ypWU=;
        b=MrSf1vv9VKN509zhlwdLejJnhpoBtnZEiwJpWn2QCVgcbHDN1t95geCJd7z/xyVvcd
         zjc3ycorHtrZUUBopYNEQy2wfxaT72wQ8vBuDiNQmGprRNcuW67Ce4c18tW2SD4u415H
         Wyu2qc4+2APAz/kXJo8c/rqU3rQ4nkUuP13P+x1ZlD4pKX1ta6a3mqOaczr1FnVdhbB4
         49GCdSsjdyZZkeQcco9vcUhgvFptGP5EbR4zPc3TATosuK1+DdWEHhfPAMjItY82lUSx
         NFpoiOE963jvsAsWTJRIw6s9C7svICTxPyR1Y+f7HLpVqqKxqfn6JLBRdho9HW5DUDt8
         ns1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691070824; x=1691675624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ejd3tpdC1zaV/w7ewmBn4nRM+R1O4uRxApY6GI0ypWU=;
        b=DaWeCdXT5FijS9YSrdQRLLAtzPFpEittjwLedCjlt0DaJzEqv4a38l7gbdGBUNHC4w
         AimNizZOV7xvYlu/Iv/wj9yVYdoQF+F6hm3tZ/V5T5WUrudUv9phP8aZ97sgS20ika0x
         V8Gd74mPO+ekMciRFl5QYGoh8wlLD1tV2/6ViT+j626MHVk4+V/6CBuoJ6cszO9OwuA7
         z3r1TGcHNAFp6Qnne/4uZwugRYyT1kN391saIIVlipdZsL6nAfgzt/4ztc9XV8hA00j9
         b1Z20wHfbCjCmE95qJdYhLM+aBbVoZgssGVBSQdak0ai11klX8JZ34eyOplfjg664MRX
         s6Jg==
X-Gm-Message-State: ABy/qLZCXtnOU8Hq1uWxGC0Gjk+tl245BMZNTftJoCzPVB62QYaUZbWk
        6n3Z9Kn0OLqQKJFn8abWjGI=
X-Google-Smtp-Source: APBJJlHuIoaTBbpnUrcFFXT7fPGxu/0lXWN0OwVoj+05bI0S+IwQ8VVonMPQFmEKY5BIDHPRexQbLA==
X-Received: by 2002:a17:906:974b:b0:988:8efc:54fa with SMTP id o11-20020a170906974b00b009888efc54famr10650437ejy.37.1691070823469;
        Thu, 03 Aug 2023 06:53:43 -0700 (PDT)
Received: from andrea (host-82-57-177-142.retail.telecomitalia.it. [82.57.177.142])
        by smtp.gmail.com with ESMTPSA id a11-20020a17090680cb00b0099b921de301sm10561131ejx.159.2023.08.03.06.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 06:53:42 -0700 (PDT)
Date:   Thu, 3 Aug 2023 15:53:37 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Leonardo Bras <leobras@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v2 0/3] Deduplicate RISCV cmpxchg.h and atomic.c
 macros
Message-ID: <ZMuxYXQgR446JwUp@andrea>
References: <20230803051401.710236-2-leobras@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803051401.710236-2-leobras@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 02:13:57AM -0300, Leonardo Bras wrote:
> I unified previous patchsets into a single one, since the work is related.
> 
> While studying riscv's cmpxchg.h file, I got really interested in
> understanding how RISCV asm implemented the different versions of
> {cmp,}xchg.
> 
> When I understood the pattern, it made sense for me to remove the
> duplications and create macros to make it easier to understand what exactly
> changes between the versions: Instruction sufixes & barriers.
> 
> Also, did the same kind of work on atomic.c.
> 
> Note to Guo Ren:
> I did some further improvement after your previous reviews, so I ended
> up afraid including your Reviewed-by before cheching if the changes are
> ok for you. Please check it out again, I just removed some helper macros
> that were not being used elsewhere in the kernel.
> 
> Thanks!
> Leo
> 
> 
> Changes since squashed cmpxchg:
> - Unified with atomic.c patchset 
> - Rebased on top of torvalds/master (thanks Andrea Parri!)
> - Removed helper macros that were not being used elsewhere in the kernel.
> 
> Changes since (cmpxchg) RFCv3:
> - Squashed the 6 original patches in 2: one for cmpxchg and one for xchg
> https://lore.kernel.org/all/20230404163741.2762165-1-leobras@redhat.com/
> 
> Changes since (cmpxchg) RFCv2:
> - Fixed  macros that depend on having a local variable with a magic name
> - Previous cast to (long) is now only applied on 4-bytes cmpxchg
> https://lore.kernel.org/all/20230321074249.2221674-1-leobras@redhat.com/
> 
> Changes since (cmpxchg) RFCv1:
> - Fixed patch 4/6 suffix from 'w.aqrl' to '.w.aqrl', to avoid build error
> https://lore.kernel.org/all/20230318080059.1109286-1-leobras@redhat.com/
> 
> 
> Leonardo Bras (3):
>   riscv/cmpxchg: Deduplicate xchg() asm functions
>   riscv/cmpxchg: Deduplicate cmpxchg() asm and macros
>   riscv/atomic.h : Deduplicate arch_atomic.*
> 
>  arch/riscv/include/asm/atomic.h  | 164 ++++++++--------
>  arch/riscv/include/asm/cmpxchg.h | 318 +++++--------------------------
>  2 files changed, 123 insertions(+), 359 deletions(-)

LGTM.  For the series,

Reviewed-by: Andrea Parri <parri.andrea@gmail.com>

  Andrea

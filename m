Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7963179766A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjIGQIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239702AbjIGQIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:08:07 -0400
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455755273
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:01:27 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2bd0a5a5abbso19971071fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1694102378; x=1694707178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XeBbVRtX/aIWzlXHiHUn4OCigEvkTh1dLDX2VajCG9M=;
        b=UP5XyroKB0Y3e7lamt2PRAeVY7AuKb4R1unhykqUb6TzR2MrfUL9fRsan1cQZwqYqg
         rjjtDD7YgXEn4l8M8UWxXYFe49RNwPII5D1qtroCGwvYfJVVsM/TOpziqVKcF6UmkUSm
         La//BYI75jdPL2Cl+Z4V0kolecj8fMVE8nKaZDrOqbaBeP7uUtC4bBdsawdn2z/cSEGf
         5ZVvI24v/rMonbor58wghOY3QcabbzJ8rqJm0Ufb4/a27kziboBECVQaZ4ZGv3CKkQEp
         8i7zmJTdNVTHE3xQX5OgrspuhwDVEMLslZ4wYIC15l2fLnLn51SU1iWfvEy2o51TK0So
         JDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694102378; x=1694707178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeBbVRtX/aIWzlXHiHUn4OCigEvkTh1dLDX2VajCG9M=;
        b=Lu1kseXjnvkire+4IhauLBlGaOPdS9AVLyWnPBCMW5XWGJlZELJ032V+CPZVQAv8wt
         bhdz8gyzktxzY5J0yeZMkdtjSBlYpZy+pVQlGH1yC+ranZL7/7ygwWxcoftpaxu9pDyq
         Br7PDcEz6wNYHMYxS5w7To7D4wJuaX5swem6J0SIkcE8ReOnMD7twR08D/woMxVoIsc8
         m6o4FEbXbL5mbTf4ESj1NoAMI/xcE/cEi0n/KbEkIJcxON5XqVFQqHc1DwjX3NsEMPzm
         LlnzEeh3lyG2mGPcYPhITEboFpVJ9mxdYXADyY6MJIWmsR1WVHY4HAcSqTkdzSI7eoxm
         VGvg==
X-Gm-Message-State: AOJu0YxskmwvzMi8LHgAgw+U6udWOtMf6YAheR5vm6HUpT03gC/k8iDQ
        lE5jUDNWQuPAcvDz2+pGpzFH1p61iYczER6y1H8=
X-Google-Smtp-Source: AGHT+IGEGmreaznUgLT0wco7186DbxtRAxnnEI6albp1jZXrz+2WijzMa2iZXNVK2n5/iINTQ0Yxlw==
X-Received: by 2002:adf:fd4d:0:b0:316:fb57:26d1 with SMTP id h13-20020adffd4d000000b00316fb5726d1mr4496582wrs.8.1694076710917;
        Thu, 07 Sep 2023 01:51:50 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id l21-20020a1c7915000000b003fef6881350sm1853914wme.25.2023.09.07.01.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 01:51:50 -0700 (PDT)
Date:   Thu, 7 Sep 2023 10:51:49 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, jrtc27@jrtc27.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        bpf@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, rostedt@goodmis.org,
        Ard Biesheuvel <ardb@kernel.org>, anup@brainfault.org,
        atishp@atishpatra.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bjorn@kernel.org, luke.r.nels@gmail.com, xi.wang@gmail.com,
        namcaov@gmail.com
Subject: Re: [PATCH 00/10] RISC-V: Refactor instructions
Message-ID: <20230907-304f53e7de4e0386d04f4dcf@orel>
References: <ZN5OJO/xOWUjLK2w@ghost>
 <mhng-7d609dde-ad47-42ed-a47b-6206e719020a@palmer-ri-x1c9a>
 <20230818-63347af7195b7385c146778d@orel>
 <ZPjKGd7VstwIKDV5@ghost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPjKGd7VstwIKDV5@ghost>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 11:51:05AM -0700, Charlie Jenkins wrote:
> On Fri, Aug 18, 2023 at 09:30:32AM +0200, Andrew Jones wrote:
> > On Thu, Aug 17, 2023 at 10:52:22AM -0700, Palmer Dabbelt wrote:
> > > On Thu, 17 Aug 2023 09:43:16 PDT (-0700), Charlie Jenkins wrote:
> > ...
> > > > It seems to me that it will be significantly more challenging to use
> > > > riscv-opcodes than it would for people to just hand create the macros
> > > > that they need.
> > > 
> > > Ya, riscv-opcodes is pretty custy.  We stopped using it elsewhere ages ago.
> > 
> > Ah, pity I didn't know the history of it or I wouldn't have suggested it,
> > wasting Charlie's time (sorry, Charlie!). So everywhere that needs
> > encodings are manually scraping them from the PDFs? Or maybe we can write
> > our own parser which converts adoc/wavedrom files[1] to Linux C?
> > 
> > [1] https://github.com/riscv/riscv-isa-manual/tree/main/src/images/wavedrom
> 
> The problem with the wavedrom files is that there are no standard for
> how each instruction is identified. The title of of the adoc gives some
> insight and there is generally a funct3 or specific opcode that is
> associated with the instruction but it would be kind of messy to write a
> script to parse that. I think manually constructing the instructions is
> fine. When somebody wants to add a new instruction they probably will
> not need to add very many at a time, so it should be only a couple of
> lines that they will be able to test.
>

OK, we'll just have to prop our eyelids open with toothpicks to get
through the review of the initial mass conversion.

Thanks,
drew

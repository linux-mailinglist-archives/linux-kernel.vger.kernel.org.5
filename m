Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22242811111
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377653AbjLMMYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377400AbjLMMYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:24:15 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E642FCF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:24:21 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c32df9174so59986375e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702470260; x=1703075060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Do9us9KI9YVf91TMl8txltk4WC8U3fmMGLk20+eGOw=;
        b=IlCk1Bv8B+MsKoDZk7TyTUFP1ksnlXbm7VYIUSuyZ+bOkGfz9UtosGWiY8UClofvxU
         5N2fXi1cBlAou57GWZIrSC9aU67ZGljTffUKWKYghqsFYTPzsdzpTzmqy9nPHI4C4Gf+
         LAsGayOphK3ALb3LS5uAbDRH05Gc0qo76FrDBHKCp3fMWAsJ03d9YqIAQv4Q7Ep7uPFP
         lpAlx4lzUVOxw+LK6wrJwJiQQkqhyLS5QlznEJo/jtlFxgowrMvfTzoIPGK870omKuHO
         CNC2Qgqm/WIAabhG1fK2bQR1SRAYjhI+9Ctb7mhZeHq7Z/C6eiDbt3shzIqvzYd6UIg4
         rPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702470260; x=1703075060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Do9us9KI9YVf91TMl8txltk4WC8U3fmMGLk20+eGOw=;
        b=CqXW035gEEl8cSIbjgzzMOMIx2Du+BRF1gjXeSmgdmEtuqoxv1hsLo8wrbolUPScPl
         d2xRkHx4g7ERCV+HOZf1aXCF2pdGmbCj+juHEuR4U6a3yHq0HMJDYZo5CATG4pYcF3KC
         fI2NF0eQ5DCSxq3CyhpFSqewkmPZMICNoj+XOjaSL5IXT8kl+I/V5QeR9/HaA89CdBE5
         DA24ttoKyGtxYoPDdaX0w1bFcP1/b3cXUOGhqcLerUg+p6zMQz5xUkpUgboQQprw/3Ty
         Op8UAdb8/CEOdfHGsLNIYa/xpza+zE2FDGvdkTstzf0jgzizGQPfqT/PB1+PSWB3iR0Y
         Pe1A==
X-Gm-Message-State: AOJu0YxJJpx5idiiaxpQW/P443sK/5O4a/UFQc4YboZzZUAiRB6ClcPY
        R/mT94jxck9UZP8R93mECr9o7Q==
X-Google-Smtp-Source: AGHT+IFH3rJTleJTU4xsQNweH6i96bFDZCHpyMZmqgOvAispGx7uzx5Me7DqfOkSWHH7fB2FceGEow==
X-Received: by 2002:a05:600c:1715:b0:40b:5e21:c5cd with SMTP id c21-20020a05600c171500b0040b5e21c5cdmr2457031wmn.155.1702470260169;
        Wed, 13 Dec 2023 04:24:20 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id fl9-20020a05600c0b8900b0040b43da0bbasm20393302wmb.30.2023.12.13.04.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 04:24:19 -0800 (PST)
Date:   Wed, 13 Dec 2023 13:24:18 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Deepak Gupta <debug@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, apatel@ventanamicro.com, guoren@kernel.org,
        mchitale@ventanamicro.com, waylingii@gmail.com,
        greentime.hu@sifive.com, samitolvanen@google.com,
        Bjorn Topel <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        jeeheng.sia@starfivetech.com, Heiko Stuebner <heiko@sntech.de>,
        Evan Green <evan@rivosinc.com>, jszhang@kernel.org,
        cleger@rivosinc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] riscv: envcfg save and restore on trap entry/exit
Message-ID: <20231213-707b4e8b5a91ceedd557eb12@orel>
References: <20231212235003.2036221-1-debug@rivosinc.com>
 <mhng-ae72b5fd-358d-48e2-87cf-f571b67afe9e@palmer-ri-x1c9a>
 <ZXkCs9ypok5X/Wx2@debug.ba.rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXkCs9ypok5X/Wx2@debug.ba.rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 05:02:43PM -0800, Deepak Gupta wrote:
> On Tue, Dec 12, 2023 at 04:53:48PM -0800, Palmer Dabbelt wrote:
> > On Tue, 12 Dec 2023 15:49:25 PST (-0800), debug@rivosinc.com wrote:
> > > envcfg CSR defines enabling bits for cache management instructions and soon
> > > will control enabling for control flow integrity and pointer masking features.
> > > 
> > > Control flow integrity and pointer masking features need to be enabled on per
> > > thread basis. Additionally, I believe cache management instructions need to be
> > > enabled on per thread basis. As an example a seccomped task on riscv may be
> > > restricted to not use cache management instructions
> > 
> > Do we have anything in the kernel that actually does that?  Generally we
> > need some use, I couldn't find any user-mode writable envcfg bits in any
> > extesions I looked at (admittidly just CFI and pointer masking), and
> > unless I'm missing something there's no per-thread state in the kernel.
> > 
> 
> Cache management operations?
> As of now kernel blindly enables that for all the user mode. It will be good if
> that is enabled on per-thread basis. Sure, all threads can have it enabled by
> default. But if strict seccomp is enabled, I would argue that cache management
> operations for that thread to be disabled as is done on other arches. As an
> example x86 disable rdtsc on strict seccomp. RISCV allows this CMO extension
> and I expect CMO to leverage this (currently it
> doesn't).
> 
> I was being opportunistic here so that I can reduce number of patches on CFI
> enabling patchset.
> 
> Will it be okay if I revise this patch to include with a usecase to restrict CMO
> (say for case of strict seccomp on risc-v)?

I opted to only expose cache block zero since giving userspace the
ability to invalidate cache blocks seems risky from a side-channel attack
perspective.

I'm no security expert, so feedback welcome, but I don't see a risk with
userspace being granted cbo.zero, even for strict seccomp processes.

Thanks,
drew

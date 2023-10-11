Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63FE7C6066
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 00:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376533AbjJKWhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 18:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbjJKWhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 18:37:32 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B55CA
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 15:37:31 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso51594666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 15:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697063849; x=1697668649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLpT5o7Cvx9fo5trMXpfCzqTo5OLTt4P6i5IBd2WXFo=;
        b=RlPw/dlrBBS3Fhviaa4MmaT4hF9dWdeKdpXoZ2lpJEXNt7z1bmfUgRo7F6sL9U6aGG
         AFBZbr6bIomV6hSOZI2MI5bgscC5+HDRIcZGBVyHexMoLgx/2GT4olX9O4c6D3t0IxHQ
         gzg0yTn7/k4ApkvuAk8XvyBWniO4uktxRTD+74MIz4gJ+6r5mPMhRFLUEfvL/qmQj7gm
         ECSzAL4EvyZ94ZxC1s5dZFI4RdtL1kNsKa7Jz8/Y8++bUBjpKPHw9mJJTpd9Zm2ZX2zW
         LSmi0yMRs0EJ0DSfc+8HZxXEGFj7ebEbJOw936VCTKxtTLPCHLf9LITXBECl8r0W2dJw
         yTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697063849; x=1697668649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLpT5o7Cvx9fo5trMXpfCzqTo5OLTt4P6i5IBd2WXFo=;
        b=Ia2N9tqzJKHmKGvRsOhhp4bIzZK4cnXK1Qc4RhW3ZRoAKFfSP3cuggNs2fNFsiwwNQ
         NL0gKUTEXQXoUqplBn0Ogr8Aw8b1576PlNUNU34is1/pYj1mXMkY1LX6pMnS0X6LNHvz
         RESTaHsjHzrVS5/OcS/e6l58KycN8B4g0v9KwMOkhKnmvDakiIMXc22kySHW+Q2C+rFM
         9B0wU6wTUhM9SwmL1tDD6ySBrWPUmxVmVpnOrhMfGcUDFH0ZXcQmnzutP6LXGXzl8Blm
         WM1su8eR/Je91SxZurz0FdZU98IOl9yhX7fR/9oGpv60soSkf5xCUHii8IArjrejthf5
         gZnQ==
X-Gm-Message-State: AOJu0Yz4dcGfFOeTqS6Ncr15ZN+/j3hNdGPBxEqC7sLdJwRKPQBqtTmU
        BcrPFlsaS7+0gkpOgYvgfvs=
X-Google-Smtp-Source: AGHT+IGaXGFBRLUeG8/EETq4utoBiIGb3bTJkZ48YDoiHxUTPf8MrbZkt4zn5r9X/SnODv2VOxLCpw==
X-Received: by 2002:a17:906:221c:b0:9a5:b876:b1e3 with SMTP id s28-20020a170906221c00b009a5b876b1e3mr18483488ejs.20.1697063849591;
        Wed, 11 Oct 2023 15:37:29 -0700 (PDT)
Received: from gmail.com (1F2EF405.nat.pool.telekom.hu. [31.46.244.5])
        by smtp.gmail.com with ESMTPSA id j24-20020a170906051800b00993470682e5sm10250709eja.32.2023.10.11.15.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 15:37:28 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 12 Oct 2023 00:37:26 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
Message-ID: <ZScjptMn3fDmMFdg@gmail.com>
References: <20231010164234.140750-1-ubizjak@gmail.com>
 <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <CAFULd4Y8NSArDqH=VMy8F97eNosUUGxrBMEyHH=MytjUBSCmjg@mail.gmail.com>
 <CAHk-=whMr8V_q3dq4iS0dpx4Nssu+aYWz+mA36p2ykA+OXTjXA@mail.gmail.com>
 <CAFULd4afyYK0-wAOo3oJDapX0iyu86m5+vVn9c35gk8fd6iwRQ@mail.gmail.com>
 <CAHk-=wiLyA0g3BvQ_nsF2PWi-FDtcNS5+4-ai1FX-xFzTBeTzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiLyA0g3BvQ_nsF2PWi-FDtcNS5+4-ai1FX-xFzTBeTzg@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > The only drawback is a larger binary size:
> >
> >   text    data     bss     dec     hex filename
> > 25546594        4387686  808452 30742732        1d518cc vmlinux-new.o
> > 25515256        4387814  808452 30711522        1d49ee2 vmlinux-old.o
> >
> > that increases by 31k (0.123%), probably due to 1578 rdgsbase alternatives.
> 
> I'm actually surprised that it increases the text size. The 'rdgsbase'
> instruction should be smaller than a 'mov %gs', so I would have
> expected the *data* size to increase due to the alternatives tables,
> but not the text size.
> 
> [ Looks around ]
> 
> Oh. It's because we put the altinstructions into the text section.
> That's kind of silly, but whatever.

Yeah, we should probably move .altinstructions from init-text to .init.data 
or so? Contains a bunch of other sections too that don't get executed 
directly ... and in fact has some non-code data structures too, such as ... 
".apicdrivers". :-/

I suspect people put all that into .text because it was the easiest place 
to modify in the x86 linker script, and linker scripts are arguably scary. 

Will check all this.

Thanks,

	Ingo

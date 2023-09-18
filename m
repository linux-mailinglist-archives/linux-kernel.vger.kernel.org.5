Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B517A4F03
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjIRQdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjIRQce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:32:34 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355AE2715
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:17:52 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-576918d0a42so2825484eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695053871; x=1695658671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2rBowV5k7lk2ieUe+gHPEvDWhBOkpthR4x1/BaQpS1E=;
        b=ESaHyDhWEulbPo6HdTI8dpbxc78878phm1n7MTeZWOcJ1glIlDFB+xvREUCeBiF31u
         ZYoc0Y3VCiJBk3x9AGNvfPKdY6FrH3bCOSEb3Dkrph1fbhg7zAcPSd4b98mHfLlmIU1W
         2gVeR2PNdPG73CAz326pM8+sBULieLySXErI9f5dK7lNSKRQDHQdKNBbzoO8GIklD3UH
         +uWySu2PI4Ybv6+cMxQY1GICAc+7ucSB98SwS7NY1Gqbv3dyv3hB4XVYdFQ19qZBiW+r
         6bYXjKAzpFVHw2ZVlCKyVEp/WmOpzMI6ILOFjCSc2Io0PvFM+pGfYmSh4HQ+nSvLqAld
         vitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695053871; x=1695658671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rBowV5k7lk2ieUe+gHPEvDWhBOkpthR4x1/BaQpS1E=;
        b=OAIcP60gkLvqTThvNg+IodNtFoj1FaRQgKRBWgtpfG7Lz2suX7V5THyQt6sSSVBQhw
         gEjet1yVT9uKsD2ydDIK/nPc3LNo8/KhxR91nwlAsibWhmpPtlMpB30w9uuLzBr9vbGv
         cewlGUXtsTvyozUwJGa3I8gdh77j/wuyTXjCrIY0c0F58FECWqVcZc/JuXyMV9ViU6Ed
         AfYy2Xhw/FW17tAKIb5xBaePvI8rF05qvPhGOgiPZfcxK3CaWE0bXmm32OmSjHba7Ssk
         GLfJWbphUhmzb4zR2W86cyLsPN1etNBJQvNxIzym5mto0qyPoIQoULQPomJwpOIrO0ge
         vhEA==
X-Gm-Message-State: AOJu0YyMbHccJmLRhupBzewkeJcQ+9MT12fAfisAeT3frNIw+MlsMZVy
        hAa6w3+lRWzhZu7RoEC4p2DmQg==
X-Google-Smtp-Source: AGHT+IEIIPi01LMzDkzmjlUBhug1qKaxU6nRjVuZ+XGbMUgkxm1Qfw0TLzJDUPnbwFfEuT1QKajmag==
X-Received: by 2002:a05:6358:7207:b0:13f:411:c1a9 with SMTP id h7-20020a056358720700b0013f0411c1a9mr13490229rwa.17.1695053871422;
        Mon, 18 Sep 2023 09:17:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id pz10-20020ad4550a000000b00656260e67afsm3340834qvb.115.2023.09.18.09.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 09:17:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qiGwY-0005mj-Ao;
        Mon, 18 Sep 2023 13:17:50 -0300
Date:   Mon, 18 Sep 2023 13:17:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Anish Ghulati <aghulati@google.com>,
        Venkatesh Srinivas <venkateshs@chromium.org>,
        Andrew Thornton <andrewth@google.com>
Subject: Re: [PATCH 06/26] KVM: Drop CONFIG_KVM_VFIO and just look at KVM+VFIO
Message-ID: <20230918161750.GM13795@ziepe.ca>
References: <20230916003118.2540661-1-seanjc@google.com>
 <20230916003118.2540661-7-seanjc@google.com>
 <20230918152946.GJ13795@ziepe.ca>
 <ZQhySMjmuyW2Czas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQhySMjmuyW2Czas@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 08:52:40AM -0700, Sean Christopherson wrote:

> > I wonder if we should be making the VFIO drivers that need the kvm to
> > ask for it? 'select CONFIG_NEED_VFIO_KVM' or something?
> 
> I wondered the same thing, if only to make it easier to track which
> drivers actually end up interacting directly with KVM.

There are two usages I've seen..

GVT's uage is just totally broken:

https://lore.kernel.org/kvm/661447fd-b041-c08d-cedc-341b31c405f8@intel.com/

It is trying to use KVM to write protect IOVA DMA memory, and it just
doesn't work. If we want to do something like this the core vfio code
should provide this service and it should be wired into KVM
properly.

power and s390 have actual architectural "virtual machines" and they
need actual arch operations to install VFIO devices into those
things. In this regard having the arch opt into the integration would
make some sense. I expect this will get worse in our CC future where
VFIO devices will need to be passed into arch specific CC code
somehow.

This arch stuff isn't cleanly done, the code is sprinkled all over the
place. Some in mdevs, some in PCI arch code, some in #ifdefs..

Maybe the CC people will clean it up instead of making the mess bigger :)

Jason

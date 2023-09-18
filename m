Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75187A4C85
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjIRPfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjIRPeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:34:46 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F398612A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:32:53 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-773ac11de71so231971585a.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695050988; x=1695655788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nmpxNm78kWfejPgZcglZLNttpcA+aOzIbjCglm6BlEY=;
        b=iBJjtY1Ysirfv1RRP/4GMFsA9mAYIyTD+UT+03ccEzw5EDMfzI6oHpUfK8Q3Sqw87y
         Zm/P9T2GpKrNeY3Z+Rh6l9JQ7V8/LokfQ0pn60Ci8ONqKxKW79C55fa2gXht15GQtX0C
         64WAiH79mX6EDqXdD+ArVitvUY5CKqtZTl0umfdK4fTyvquNvBdiX4JPqK3ooJ1QxdGS
         o7ZQMofak1jK09GksMgjLmyQUtOYCy+i+ogq8qJW1HCgANjPt08PkP0dPyDSXfaa065n
         iiT30ne1wvQ0++9UDY2eu9bW18A0hCTSXa9+3HrXmAh7UBcckDKTVmBhlaWUbxztFEV5
         fdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050988; x=1695655788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmpxNm78kWfejPgZcglZLNttpcA+aOzIbjCglm6BlEY=;
        b=ElCArsQp7RKgBKYQnwmVqKPsOvQcDsbbN9DBm7BRrmdHSLD6PnujeB3c3QkJ/UPpj+
         WuYvgyRzsaHJgi/3572olS6ot5VCK3K8ca5NurugNbwGY4Sv2MeDs626TmiyPoLx8Ou7
         XLlwzsvJ/bpaiOozzup8DG0xbD8ta/XOQJjjsXs/M/RqVxC71kACZ9Y9XrOhFbYGa5Bt
         sguMpdwdMDx0Y8BsstmHe1qBT3Sdi7By9H4bFpK5XbvWROtkYMU9kCVr9MIrvnPLNuGb
         OYZ8gU/4VVC8FdPekjavH+S0DY1+AI7CFpE5rmbiESm+PSFCStq45xyKEHFYcIyN99BU
         QcqQ==
X-Gm-Message-State: AOJu0Yz+++8c2ezsnENd1ED4LRkFwpV2gAAmtMy7AzVHktVVWPjE4NZy
        reTDeU/CjiPMABFv8KZqqEaJyQ==
X-Google-Smtp-Source: AGHT+IE5R1x821mq0T9l2iChMZP/v62/zLl2heVXzUEZigk+bm+oq/r6FG+m4/T/InbSxJxTjGr9mw==
X-Received: by 2002:a05:620a:2887:b0:76d:aa93:2e3c with SMTP id j7-20020a05620a288700b0076daa932e3cmr11157815qkp.24.1695050987781;
        Mon, 18 Sep 2023 08:29:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id s4-20020a05620a16a400b0076d0312b8basm3183843qkj.131.2023.09.18.08.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 08:29:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qiGC2-0005S2-Ku;
        Mon, 18 Sep 2023 12:29:46 -0300
Date:   Mon, 18 Sep 2023 12:29:46 -0300
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
Message-ID: <20230918152946.GJ13795@ziepe.ca>
References: <20230916003118.2540661-1-seanjc@google.com>
 <20230916003118.2540661-7-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230916003118.2540661-7-seanjc@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 05:30:58PM -0700, Sean Christopherson wrote:
> Drop KVM's KVM_VFIO Kconfig, and instead compile in VFIO support if
> and only if VFIO itself is enabled.  Similar to the recent change to have
> VFIO stop looking at HAVE_KVM, compiling in support for talking to VFIO
> just because the architecture supports VFIO is nonsensical.
> 
> This fixes a bug where RISC-V doesn't select KVM_VFIO, i.e. would silently
> fail to do connect KVM and VFIO, even though RISC-V supports VFIO.  The
> bug is benign as the only driver in all of Linux that actually uses the
> KVM reference provided by VFIO is KVM-GT, which is x86/Intel specific.

Hmm, I recall that all the S390 drivers need it as well.

static int vfio_ap_mdev_open_device(struct vfio_device *vdev)
{
        struct ap_matrix_mdev *matrix_mdev =
                container_of(vdev, struct ap_matrix_mdev, vdev);

        if (!vdev->kvm)
                return -EINVAL;

        return vfio_ap_mdev_set_kvm(matrix_mdev, vdev->kvm);


I wonder if we should be making the VFIO drivers that need the kvm to
ask for it? 'select CONFIG_NEED_VFIO_KVM' or something?

Regardless, I fully agree with getting rid of the arch flag.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> --- a/virt/kvm/Makefile.kvm
> +++ b/virt/kvm/Makefile.kvm
> @@ -6,7 +6,9 @@
>  KVM ?= ../../../virt/kvm
>  
>  kvm-y := $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o
> -kvm-$(CONFIG_KVM_VFIO) += $(KVM)/vfio.o
> +ifdef CONFIG_VFIO
> +kvm-y += $(KVM)/vfio.o
> +endif

I wonder if kvm-m magically works in kbuild so you don't need the ifdef?

Jason

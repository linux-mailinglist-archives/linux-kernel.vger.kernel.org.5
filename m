Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904A980446B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344009AbjLECEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjLECEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:04:51 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74006101
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:04:54 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db9612b8997so1827895276.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 18:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701741893; x=1702346693; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xVyruI1oo2P7CyHRmmgriyFiz+nPrbAf0CEnIIEh14g=;
        b=rIVxUr5HF1UWZD+e8dN8lnLSaduP/tA82w1nW37ow7y6kke/Y60ewkAdYxBIxHGFvW
         oTx9HYCNuKgIvcqCy3UBAQvUfrpa0QQtBt6LYFkUOooub3UVuMCW8UPz1LcClL8hc0+l
         t0LRzyanWLcpEWcGwQevGMfdrjbmxYa2JEvdCAGqurTpj5qqa/htUr6zZAzAr2CCxBrZ
         MT2AttwokEpPIoGLIBKbxmXEMNknfM5dUr1Tj2RmOcbeIUVmBsXexndDYrgBr8ZKo0WZ
         NEkOtSHYPN9wElsuO/0pP89lPMQH3a/3yHGsF5r8DplhJ7mVs9+MjCxs+OhFVYe8MWEH
         0rJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701741893; x=1702346693;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xVyruI1oo2P7CyHRmmgriyFiz+nPrbAf0CEnIIEh14g=;
        b=Him4WLEswvwjviF8VKlKGvCq+lZB+DjkZT5awbODbCwaq6sNUME0dd7Slgu+mnqXKA
         VnMfWmgrojYZyafcILds12ClaMbRh1kOh8iE6IONdKJE/Gz9zUcbUpRa6QrvizzTijwb
         QOb2+TLbShZDl3ZNJWnxbPdeHxE5ud/M1Wn4rGh+woB8x9dtn6oJrKil57mUSZGu/zTT
         XIhy1x0oZjJBx07JAl+RxclivRJDwpFPJlWtRXuo5u+8FPZkrAJ9C8gxZAYWenqFdvVn
         qkI2/dFryq67O+JSbvOFhg2CQfL7HzGfpbLbFSbpDZDP32IZKN0xeulbyOjGy8WSUoNV
         DHYQ==
X-Gm-Message-State: AOJu0YwbGC1HcA+GNCPL5deGelM6rUnuEu4gg2Btn9F5qplEh4h1e2e7
        e+PYYaEVP4QmU9X1aM1ZAJN6dexNARg=
X-Google-Smtp-Source: AGHT+IGvt/BYarzOkQvF7MzafR7wtNxUC6N6zaGdRUBy9JL4XvnY9hVW0ChWiHwIRD7CBWunxA8ujFYeYug=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ca84:0:b0:db5:4692:3ab7 with SMTP id
 a126-20020a25ca84000000b00db546923ab7mr337717ybg.8.1701741893679; Mon, 04 Dec
 2023 18:04:53 -0800 (PST)
Date:   Mon, 4 Dec 2023 18:04:52 -0800
In-Reply-To: <1a5b18b2-3072-46d9-9d44-38589cb54e40@intel.com>
Mime-Version: 1.0
References: <cover.1699527082.git.kai.huang@intel.com> <9e80873fac878aa5d697cbcd4d456d01e1009d1f.1699527082.git.kai.huang@intel.com>
 <b3b265f9-48fa-4574-a925-cbdaaa44a689@intel.com> <afc875ace6f9f955557f5c7e811b3046278e4c51.camel@intel.com>
 <bcff605a-3b8d-4dcc-a5cb-63dab1a74ed4@intel.com> <dfbfe327704f65575219d8b895cf9f55985758da.camel@intel.com>
 <9b221937-42df-4381-b79f-05fb41155f7a@intel.com> <c12073937fcca2c2e72f9964675ef4ac5dddb6fb.camel@intel.com>
 <1a5b18b2-3072-46d9-9d44-38589cb54e40@intel.com>
Message-ID: <ZW6FRBnOwYV-UCkY@google.com>
Subject: Re: [PATCH v15 22/23] x86/mce: Improve error log of kernel space TDX
 #MC due to erratum
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kai Huang <kai.huang@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        Chao Gao <chao.gao@intel.com>, Tony Luck <tony.luck@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "sagis@google.com" <sagis@google.com>,
        "imammedo@redhat.com" <imammedo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>, Len Brown <len.brown@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ying Huang <ying.huang@intel.com>,
        Dan J Williams <dan.j.williams@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023, Dave Hansen wrote:
> On 12/4/23 15:24, Huang, Kai wrote:
> > On Mon, 2023-12-04 at 14:04 -0800, Hansen, Dave wrote:
> ...
> > In ancient time KVM used to immediately enable VMX when it is loaded, but later
> > it was changed to only enable VMX when there's active VM because of the above
> > reason.
> > 
> > See commit 10474ae8945ce ("KVM: Activate Virtualization On Demand").

Huh, I always just assumed it was some backwards thinking about enabling VMX/SVM
being "dangerous" or something.

> Fine.  This doesn't need to change ... until you load TDX.  Once you
> initialize the TDX module, no more out-of-tree VMMs for you.

It's not just out-of-tree hypervisors, which IMO should be little more than an
afterthought.  The other more important issue is that being post-VMXON blocks INIT,
i.e. VMX needs to be disabled before reboot, suspend, etc.  Forcing kvm_usage_count
would work, but it would essentially turn "graceful" reboots, i.e. reboots where
the host isn't running VMs and thus VMX is already disabled.  Having VMX be enabled
so long as KVM is loaded would turn all reboots into the "oh crap, the system is
rebooting, quick do VMXOFF!" variety.

> That doesn't seem too insane.  This is yet *ANOTHER* reason that doing
> dynamic TDX module initialization is a good idea.
> 
> >> It's not wrong to say that TDX is a KVM user.  If KVm wants
> >> 'kvm_usage_count' to go back to 0, it can shut down the TDX module.  Then
> >> there's no PAMT to worry about.
> >>
> >> The shutdown would be something like:
> >>
> >>       1. TDX module shutdown
> >>       2. Deallocate/Convert PAMT
> >>       3. vmxoff
> >>
> >> Then, no SEAMCALL failure because of vmxoff can cause a PAMT-induced #MC
> >> to be missed.
> > 
> > The limitation is once the TDX module is shutdown, it cannot be initialized
> > again unless it is runtimely updated.
> > 
> > Long-termly, if we go this design then there might be other problems when other
> > kernel components are using TDX.  For example, the VT-d driver will need to be
> > changed to support TDX-IO, and it will need to enable TDX module much earlier
> > than KVM to do some initialization.  It might need to some TDX work (e.g.,
> > cleanup) while KVM is unloaded.  I am not super familiar with TDX-IO but looks
> > we might have some problem here if we go with such design.
> 
> The burden for who does vmxon will simply need to change from KVM itself
> to some common code that KVM depends on.  Probably not dissimilar to
> those nutty (sorry folks, just calling it as I see 'em) multi-KVM module

You misspelled "amazing" ;-)

> patches that are floating around.

Joking aside, why shove TDX module ownership into KVM?  It honestly sounds like
a terrible fit, even without the whole TDX-IO mess.  KVM state is largely ephemeral,
in the sense that loading and unloading kvm.ko doesn't allocate/free much memory
or do all that much initialization or teardown.

TDX on the other hand is quite different.  IIRC the PAMT is hundreds of MiB, maybe
over a GiB in most expected use cases?  And also IIRC, TDH.SYS.INIT is rather
long running operation, blocks IRQs, NMIs, (SMIs?), etc.

So rather than shove TDX ownership into KVM and force KVM to figure out how to
manage the TDX module, why not do what us nutty people are suggesting and move
hardware enabling and TDX-module management into a dedicated base module (bonus
points if you call it vac.ko ;-) ).

Alternatively, we could have a dedicated kernel module for TDX, e.g. tdx.ko, and
then have tdx.ko and kvm.ko depend on vac.ko.  But I think that ends up being
quite gross and unnecessary, e.g. in such a setup, kvm-intel.ko ideally wouldn't
take a hard dependency on tdx.ko, as auto-loading tdx.ko would defeat some of the
purpose of the split, and KVM shouldn't fail to load just because TDX isn't supported.
But that'd mean conditionally doing request_module("tdx") or whatever and would
create other conundrums.

(Oof, typing that out made me realize that KVM depends on the PSP driver if
CONFIG_KVM_AMD_SEV=y, even if if the platform owner has no intention of ever using
SEV/SEV-ES.  IIUC, it works because sp_mod_init() just registers a driver, i.e.
doesn't fail out of there's no PSP.  That's kinda gross).

Anyways, vac.ko provides an API to grab a reference to the TDX module, e.g. the
"create a VM" API gets extended to say "create a VM of the TDX variety", and then
vac.ko manages its refcounts to VMX and TDX accordingly.  And KVM obviously keeps
its existing behavior of getting and putting references for each VM.

That way userspace gets to decide when to (un)load tdx.ko without needing to add
a KVM module param or whatever to allow forcefully unloading tdx.ko (which would
be bizarre and probably quite difficult to implement correctly), and unloading
kvm-intel.ko wouldn't require unloading the TDX module.

The end behavior might not be all that different in the short term, but it would
give us more options, e.g. for this erratum, it would be quite easy for vac.ko to
let usersepace choose between keeping VMX "on" (while the TDX module is loaded)
and potentially having imperfect #MC messages.

And out-of-tree hypervisors could even use vac.ko's exported APIs to manage hardware
enabling if they so choose.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495F47BED51
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378604AbjJIV0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378269AbjJIV0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:26:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E6D9E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:26:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a3a98b34dso884570276.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 14:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696886798; x=1697491598; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HGGD5jvAnQPh9X54uhY2HVxAcITGPm3/bi/jB8262X0=;
        b=Xdscn/4xHytY63mUdNFzyvBkwTqnx52EVI9XpQS1F26gO2DyP9VC/PXrFujcWxof52
         RhBDeIEzmSaQiSPasdBwcoehVeqBnrHpp4mamHjmBRg2mbE4uUyodv+b6Gmp8xxKaABw
         1V4ankST6ljZ+tQi0Y1CIStc7fbozJIl3AdVi1QoutyGWC7Iq4xu24r3bm8425t7Ma6S
         S7eapAmkRxYQHgW62/4BGag30cjGRPgFFgzXoC8ibW1H73ViU5iH8RhXeOolmZWmet4G
         GhX1R0CX/FphPDV4bXr9GuAr7K9duv/T8k2IB7cLN9ZZ8R1tcRD6NibKLJiJwgZiFftS
         FAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696886798; x=1697491598;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HGGD5jvAnQPh9X54uhY2HVxAcITGPm3/bi/jB8262X0=;
        b=gjgJXQwapTVN+X4DKUrpB6yeuG0prBu0T8FcSTne1s3YgRnudXWIFzojnTcy2LeSjt
         jHw2o9CsMm51h4yqP2fLeMAqfkIm/s17gUoP6Q+H15ujNtT9CgzXEiqWIDC8f0HLpj8A
         QadXuhE4uASKUACS9JpKhKFKGIQQlXHCfmHNxJk119CNVFcuMlLShy1rAGcg47OQvfhp
         BjPohStypZu5Hi88VSOH5sWBs7qwFvGJfpItR5C36kq0rj58Eg3VWnT0RKv2/GDqX4LM
         wv0K9FmukwRU6yHqgVqYQ/7YG+TJ3d4iBG3++zuodEt+K9QT99Gl693K8cUFodkEhbnD
         WDYw==
X-Gm-Message-State: AOJu0YyGCidxxAfGq2RSCJWFVSS4CYo5a/3iJ0bXb7I1zUJWcHvh9k9n
        6+C5BoTwGftL4q/sXsk9VQgXFbsxvsU=
X-Google-Smtp-Source: AGHT+IGUR7tnyVX3YniAsk76wBc55GPRGTcusyN75iiKCoSqD06qOne/hCWTr78soI83EQZDfoIFAAinDY8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:138d:b0:d9a:4e29:6353 with SMTP id
 x13-20020a056902138d00b00d9a4e296353mr13218ybu.0.1696886798378; Mon, 09 Oct
 2023 14:26:38 -0700 (PDT)
Date:   Mon, 9 Oct 2023 14:26:36 -0700
In-Reply-To: <20231009204037.GK800259@ZenIV>
Mime-Version: 1.0
References: <20230928180651.1525674-1-pbonzini@redhat.com> <169595365500.1386813.6579237770749312873.b4-ty@google.com>
 <20231009022248.GD800259@ZenIV> <ZSQO4fHaAxDkbGyz@google.com>
 <20231009200608.GJ800259@ZenIV> <ZSRgdgQe3fseEQpf@google.com> <20231009204037.GK800259@ZenIV>
Message-ID: <ZSRwDItBbsn2IfWl@google.com>
Subject: Re: [PATCH gmem FIXUP] kvm: guestmem: do not use a file system
From:   Sean Christopherson <seanjc@google.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023, Al Viro wrote:
> On Mon, Oct 09, 2023 at 01:20:06PM -0700, Sean Christopherson wrote:
> > On Mon, Oct 09, 2023, Al Viro wrote:
> > > On Mon, Oct 09, 2023 at 07:32:48AM -0700, Sean Christopherson wrote:
> > > 
> > > > Yeah, we found that out the hard way.  Is using the "secure" variant to get a
> > > > per-file inode a sane approach, or is that abuse that's going to bite us too?
> > > > 
> > > > 	/*
> > > > 	 * Use the so called "secure" variant, which creates a unique inode
> > > > 	 * instead of reusing a single inode.  Each guest_memfd instance needs
> > > > 	 * its own inode to track the size, flags, etc.
> > > > 	 */
> > > > 	file = anon_inode_getfile_secure(anon_name, &kvm_gmem_fops, gmem,
> > > > 					 O_RDWR, NULL);
> > > 
> > > Umm...  Is there any chance that your call site will ever be in a module?
> > > If not, you are probably OK with that variant.
> > 
> > Yes, this code can be compiled as a module.  I assume there issues with the inode
> > outliving the module?
> 
> The entire file, actually...  If you are using that mechanism in a module, you
> need to initialize kvm_gmem_fops.owner to THIS_MODULE; AFAICS, you don't have
> that done.

Ah, that's handled indirectly handled by a chain of refcounted objects.  Every
VM that KVM creates gets a reference to the module, and each guest_memfd instance
gets a reference to its owning VM.

Thanks much for the help!

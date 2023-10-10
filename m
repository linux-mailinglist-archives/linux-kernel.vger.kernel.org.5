Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C5A7BEFBD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 02:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379213AbjJJA1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 20:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379189AbjJJA1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 20:27:08 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CA89F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 17:27:07 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-27cdde1ee5fso402305a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 17:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696897626; x=1697502426; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oeawgZymjR1McP4t75YvRrkqJDZW25xAyrZ8fBe5iAg=;
        b=wGyJ/LYpx0JgUoZqXqWI0ut5Ny/EqInfeZqaNaznToVSiLNCMfwMl4fV97cpsnTxx4
         FlGVWrpdSHHMN9u8Khhi8CcY2MIu2B5bErhdGdwzi393m7Ck6EbNNZzoS/xrMyV1tdE1
         l6fCRjFo7uowkBLQoOJ7q/iEYPh6eayI8LZcIscy+lVbJa6flPiU8FIJxw/sz1JpZfWx
         LFxYThCULn7fJHJE+Iciso6fQNmROvp0TK+0lvCpfvFmoprukrqP4AcNJYM0GQMmCRHv
         gT/OeB/p8E1OlCBg5GTLotsqOW7ZHCOF1Exxr22337wl41F7P24KzJ4d8k+mZdatAKCh
         +itg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696897626; x=1697502426;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oeawgZymjR1McP4t75YvRrkqJDZW25xAyrZ8fBe5iAg=;
        b=xBICWErVeShf2nnaNQSnNLQj/GeHEG4i/dVNJnyXN4mDysLacGnMGhna3KBeySmV4Y
         Fk6ZASheiqzTUjbUtcokEHSy8skDeaYU69rSCNoIrQaq8JwQ2Bt9tVb/yutzju2KWpYj
         jyQBC17O2v9Z+x2T6Nzjx4yiR82VNAjuY2HhAqsX/pdcZ0+oqb5HR56mmq8+nloNldbe
         NBQDWU660F9dBg7jD3T/UX6C1x7e4gADsdJrzlj/tJJAt8E6pYSlmXogAD1b+6W98tOp
         jBNodYUw9W9b1rR/RoUUrKcf1RhSUoiRokry++BT4HUQwYDuXZWpDZ58E/SHH/1jaJIe
         RukQ==
X-Gm-Message-State: AOJu0Yx5PFGZCCYcRLiYSHIIJn3Y2NlLIlKF/dfUtvpKaXKGsQAjJZHd
        Lj7kkMdkfWAbUyMv8F2pjQYDJzBgVJw=
X-Google-Smtp-Source: AGHT+IG814lzonIZl8N0J+mVapYgnqFN9AMsQW8kkoIlBd1VyLm+5IhFUOTzxRNTw4UiItRbWgZcvOB2G9I=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1092:b0:274:974b:9b2b with SMTP id
 gj18-20020a17090b109200b00274974b9b2bmr284236pjb.0.1696897626570; Mon, 09 Oct
 2023 17:27:06 -0700 (PDT)
Date:   Mon, 9 Oct 2023 17:27:04 -0700
In-Reply-To: <20231010000910.GM800259@ZenIV>
Mime-Version: 1.0
References: <20230928180651.1525674-1-pbonzini@redhat.com> <169595365500.1386813.6579237770749312873.b4-ty@google.com>
 <20231009022248.GD800259@ZenIV> <ZSQO4fHaAxDkbGyz@google.com>
 <20231009200608.GJ800259@ZenIV> <ZSRgdgQe3fseEQpf@google.com>
 <20231009204037.GK800259@ZenIV> <ZSRwDItBbsn2IfWl@google.com> <20231010000910.GM800259@ZenIV>
Message-ID: <ZSSaWPc5wjU9k1Kw@google.com>
Subject: Re: [PATCH gmem FIXUP] kvm: guestmem: do not use a file system
From:   Sean Christopherson <seanjc@google.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023, Al Viro wrote:
> On Mon, Oct 09, 2023 at 02:26:36PM -0700, Sean Christopherson wrote:
> > On Mon, Oct 09, 2023, Al Viro wrote:
> > > On Mon, Oct 09, 2023 at 01:20:06PM -0700, Sean Christopherson wrote:
> > > > On Mon, Oct 09, 2023, Al Viro wrote:
> > > > > On Mon, Oct 09, 2023 at 07:32:48AM -0700, Sean Christopherson wrote:
> > > > > 
> > > > > > Yeah, we found that out the hard way.  Is using the "secure" variant to get a
> > > > > > per-file inode a sane approach, or is that abuse that's going to bite us too?
> > > > > > 
> > > > > > 	/*
> > > > > > 	 * Use the so called "secure" variant, which creates a unique inode
> > > > > > 	 * instead of reusing a single inode.  Each guest_memfd instance needs
> > > > > > 	 * its own inode to track the size, flags, etc.
> > > > > > 	 */
> > > > > > 	file = anon_inode_getfile_secure(anon_name, &kvm_gmem_fops, gmem,
> > > > > > 					 O_RDWR, NULL);
> > > > > 
> > > > > Umm...  Is there any chance that your call site will ever be in a module?
> > > > > If not, you are probably OK with that variant.
> > > > 
> > > > Yes, this code can be compiled as a module.  I assume there issues with the inode
> > > > outliving the module?
> > > 
> > > The entire file, actually...  If you are using that mechanism in a module, you
> > > need to initialize kvm_gmem_fops.owner to THIS_MODULE; AFAICS, you don't have
> > > that done.
> > 
> > Ah, that's handled indirectly handled by a chain of refcounted objects.  Every
> > VM that KVM creates gets a reference to the module, and each guest_memfd instance
> > gets a reference to its owning VM.
> 
> Umm... what's the usual call chain leading to final drop of refcount of that
> module?

If the last reference is effectively held by guest_memfd, it would be:

  kvm_gmem_release(), a.k.a. file_operations.release()
  |
  -> kvm_put_kvm()
     |
     -> kvm_destroy_vm()
        |
        -> module_put(kvm_chardev_ops.owner);

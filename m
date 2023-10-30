Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B427DBF13
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 18:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbjJ3Rgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 13:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjJ3Rgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 13:36:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52D2BD
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 10:36:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da0cb98f66cso3729039276.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 10:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698687398; x=1699292198; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8vz5wnkmcum9q1qyUnxUAw0SL2P8FyU7ENITNbJXLW0=;
        b=IJ+HG5gmjGGXOT93f4QQPYaODHQbGWsLrxBlu9v1CiL/tQZc49J7kkSCcpVbTJYjAl
         frOe/7O1B1ApWk6iP402yUruSSXgE/82RqaAv/5FV35aAPliA6eeGS+HJ2vkI2WEGCtn
         dijCEVQt3sBDAZxiBpGVdGEpxJaTm6FOeboGz1oRPOKH5mHhWzQyYUg2HHkIQGVhS79v
         lxhf7U8dEJl7pa4xVL77Zre8jZoPCsoRieZkSEdMDZzxCSda/AG/966WYAuNpvlxpA9e
         aPHM4Vc1rY0dI03YZ+PMBICToB+YJXrPao3gOGSW6wjtN4Xf2dM7gU3jKE+mMzRoFTmR
         5Q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698687398; x=1699292198;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8vz5wnkmcum9q1qyUnxUAw0SL2P8FyU7ENITNbJXLW0=;
        b=hUgzmR4g4/nTLd6dkwMV2R+Li3PakmcDxgRCxaSfEDuxE1/GdZHptCRxd+t/FqwGa2
         h2Sia2t07WspzPr0x3CVSR/KT1omcte0tqkQoaW6MBIwBw52VsTldzUUdUpISfiACrb1
         Tko2aAvPnezSLBPSfMxZmthFSmgvVZoUidIDAeZgKOmq2QOfE6aeZoLiuuIh90xot8T5
         rFFFRsMo12gaoLRuhRmu9qzLVSA6XHfInUglhIsWcGbMBNjTYPjTwNEGEhewiWF1Glw8
         K+/OFKkr3s/fA0Jpc5hLTUUO+E/G62+bsKaCi9e8W7Bbun6LokcXwlkySgn+2QmY7Ik9
         b2Hg==
X-Gm-Message-State: AOJu0YzJzPKuUNER9sVkbJB0/+muBL0eaeyX1MylL8pDouw9XMxpKFBT
        Kn35VdAwblMiig0bi5bzJSqxn36i4N4=
X-Google-Smtp-Source: AGHT+IEEffbEmQjd4o2X7fGwPqKpFD/uxoIxAWj4vvpPaQwpwy726tAOw84DngpKljDqNb2fsvt5pi0rExE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:a93:b0:d9a:e6ae:ddb7 with SMTP id
 cd19-20020a0569020a9300b00d9ae6aeddb7mr186866ybb.7.1698687398064; Mon, 30 Oct
 2023 10:36:38 -0700 (PDT)
Date:   Mon, 30 Oct 2023 10:36:36 -0700
In-Reply-To: <146168ae-900d-4eee-9a47-a1ba2ea57aa6@redhat.com>
Mime-Version: 1.0
References: <20231030141728.1406118-1-nik.borisov@suse.com>
 <ZT_UtjWSKCwgBxb_@google.com> <146168ae-900d-4eee-9a47-a1ba2ea57aa6@redhat.com>
Message-ID: <ZT_ppBmxdd6917cl@google.com>
Subject: Re: [PATCH] KVM: x86: User mutex guards to eliminate __kvm_x86_vendor_init()
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Oct 30, 2023, Paolo Bonzini wrote:
> On 10/30/23 17:07, Sean Christopherson wrote:
> > On Mon, Oct 30, 2023, Nikolay Borisov wrote:
> > > Current separation between (__){0,1}kvm_x86_vendor_init() is superfluos as
> > 
> > superfluous
> > 
> > But this intro is actively misleading.  The double-underscore variant most definitely
> > isn't superfluous, e.g. it eliminates the need for gotos reduces the probability
> > of incorrect error codes, bugs in the error handling, etc.  It _becomes_ superflous
> > after switching to guard(mutex).
> > 
> > IMO, this is one of the instances where the then solution problem appoach is
> > counter-productive.  If there are no objections, I'll massage the change log to
> > the below when applying (for 6.8, in a few weeks).
> 
> I think this is a "Speak Now or Forever Rest in Peace" situation.  I'm going
> to wait a couple days more for reviews to come in, post a v14 myself, and
> apply the series to kvm/next as soon as Linus merges the 6.7 changes.  The
> series will be based on the 6.7 tags/for-linus, and when 6.7-rc1 comes up,
> I'll do this to straighten the history:

Heh, I'm pretty sure you meant to respond to the guest_memfd series.

> 	git checkout kvm/next
> 	git tag -s -f kvm-gmem HEAD
> 	git reset --hard v6.7-rc1
> 	git merge tags/kvm-gmem
> 	# fix conflict with Christian Brauner's VFS series
> 	git commit
> 	git push kvm
> 
> 6.8 is not going to be out for four months, and I'm pretty sure that
> anything discovered within "a few weeks" can be applied on top, and the
> heaviness of a 35-patch series will outweigh any imperfections by a long
> margin).
> 
> (Full disclosure: this is _also_ because I want to apply this series to the
> RHEL kernel, and Red Hat has a high level of disdain for non-upstream
> patches.  But it's mostly because I want all dependencies to be able to move
> on and be developed on top of stock kvm/next).

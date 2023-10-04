Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABE17B8D5B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244460AbjJDT2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243581AbjJDT2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:28:33 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB4ACE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 12:28:30 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-27756e0e4d8so110597a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 12:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696447709; x=1697052509; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xxSoyXSvQVFxo0yBpA42WtLsckD9IYXTzkM+s4NdFLg=;
        b=J4ARSByz8SZNb1g5TisIR/uRRSd536grGwuuUf4HB0+ZPL+Llp3IT3vWjj6bfOCq2k
         x5hHcKjbrXBbIdLqsuZT1sbFk5ARIf2+kZZoU/MgDm+aKtm84IiWT++76fi88L8epw9n
         /eLdcQwhTO374lHZzKQY2Y7b5aunZgFCMiJC9ro+YxxqRCO5Ms6p3OnFYlghhZ/ZInOE
         DVyIS65+XZyiRm0zM1hiRjnIvcSuw1KVaH4IvMKf8p8xLU8mFsrJXRnki019iXxHV/45
         0QDonqdWoLlLjRZdnITqvZOYx+ODI+vj5iL+QVq6nxbMCiHIdB+OMLvEdeO0hR/zGpDE
         X4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696447709; x=1697052509;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xxSoyXSvQVFxo0yBpA42WtLsckD9IYXTzkM+s4NdFLg=;
        b=SoNdn/xCNOs8H6HkhumuvIvHV8XTkplqh++5iZi67gu2w6zuXWfD4isdsu3+yGykOc
         WfkP4wi+yWM1RKauMwjPDXpImf7F/rDFL6koA7d53Rin8lKb467rSOxzes5esPPuEvz6
         8c0MKuXRaevBVlo29gF59ILqEgYYg1wS5RVUGlsYadxUTngpVOf8Ekc/NyazyKYoFVOF
         OJhiT+MsldDmi0zU/4AfGxfHWJM+qBo6LfFhd0uOZH0ZpLqTgEoVnf5pI31Mv/uvNIf0
         +pVc96T1IoydTFPZ/WTpw8a3oDUyc7EyXQW+Kiz92hBSJ/ZVSWMVh8nzrn1Ce3E/XVxH
         Bkkg==
X-Gm-Message-State: AOJu0YxvL13wzrblCvjE5gd1eLakzQk+dda7TTtRkqdPZhsXEPETWMqu
        bTiupAqZzQtM+v3Wgfhrmp2Ks4acwl0=
X-Google-Smtp-Source: AGHT+IHGAprULVNsSMDBVG60XyQUOGoBMWDKQKvodunVgyK5JsoH87cSPgPFTgldXtBYelcr+QQgTGCa55U=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:4584:b0:269:6494:cbc8 with SMTP id
 v4-20020a17090a458400b002696494cbc8mr51185pjg.4.1696447709563; Wed, 04 Oct
 2023 12:28:29 -0700 (PDT)
Date:   Wed, 4 Oct 2023 12:28:28 -0700
In-Reply-To: <169592099261.2962597.3938666115023271118.b4-ty@google.com>
Mime-Version: 1.0
References: <CAPm50aKwbZGeXPK5uig18Br8CF1hOS71CE2j_dLX+ub7oJdpGg@mail.gmail.com>
 <169592099261.2962597.3938666115023271118.b4-ty@google.com>
Message-ID: <ZR283JqDK3vLEt5A@google.com>
Subject: Re: [PATCH RESEND] KVM: X86: Reduce size of kvm_vcpu_arch structure
 when CONFIG_KVM_XEN=n
From:   Sean Christopherson <seanjc@google.com>
To:     pbonzini@redhat.com, Hao Peng <flyingpenghao@gmail.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023, Sean Christopherson wrote:
> On Tue, 05 Sep 2023 09:07:09 +0800, Hao Peng wrote:
> > When CONFIG_KVM_XEN=n, the size of kvm_vcpu_arch can be reduced
> > from 5100+ to 4400+ by adding macro control.
> 
> Applied to kvm-x86 misc.  Please fix whatever mail client you're using to send
> patches, the patch was heavily whitespace damaged.  I fixed up this one because
> it was easy to fix and a straightforward patch.
> 
> [1/1] KVM: X86: Reduce size of kvm_vcpu_arch structure when CONFIG_KVM_XEN=n
>       https://github.com/kvm-x86/linux/commit/fd00e095a031

FYI, I've moved this to "kvm-x86 xen".  There are enough Xen patches coming in
that I didn't want to dump them all in "misc", and I also didn't want to have
one lone Xen patch in a different pull request.

[1/1] KVM: X86: Reduce size of kvm_vcpu_arch structure when CONFIG_KVM_XEN=n
      https://github.com/kvm-x86/linux/commit/ee11ab6bb04e

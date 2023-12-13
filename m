Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C37F811ACD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjLMRVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMRVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:21:10 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EE1E4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:21:15 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dbcd9f4396eso498549276.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702488075; x=1703092875; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AUER+D4xe6qS+B1oKWs50YXOCoyXjBc3WM+/yGcEVoE=;
        b=QX5FBp6jzLZh5gCBAy2h22nqyENcL1EB0kJ6BPSIS6XmNIWrAL81u6cc59Im04Jyqq
         3vUYKZJsGlaLxdzw5y59C4uIAyaCCkLr5ectb/2dcWVoXfhmCWy5WSQ4u1pFakISSTZd
         qB7c1oBpTT6WZYCS50ohGRS14xxOLVEVRTDpKmYzCm8QsGxE75jWUH4Onj0pHkaUW9rz
         bikNqc27HabAtCTJ9sKNkC40++VJDl8yaxhylNyQ0SUv0to/Frb7Zi4YDNx7XTHjLYT2
         CFr+DrWgfS0BOpEUx/PDVD7vdkZqbPQk7AnKYyAU1+Uv6D0IM1vv17W5cA/QvsyTsQHF
         eWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702488075; x=1703092875;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AUER+D4xe6qS+B1oKWs50YXOCoyXjBc3WM+/yGcEVoE=;
        b=Dt1NCxDoO9mHhSOrOkOh1NZ5J0y832MDrIVn5g/MzPf6z7LYJm6HhNlgadrnSRh2MG
         pNExti3dLlR22/lrPzG/uYjZib0GCJIFbJbAKu1UUo7E/VhTjlxHMq2sfy/VU6UEqep1
         aSIvCqTfypsU4pTbs7b80TqAHOen7+7Qo45PggI4CKPKzhVTMv7ysETYeGaJ2e1abwBO
         ca4SA9Ps3QlAAD7sAvuLBOVNWFqzBib8QAMf1Ec0DUNsox1MA/5AFciipKAOHySzquvZ
         8X08DV7zkZ2A++kygwQ6W98M0QtzazfciwjTlVkTowJADgXA4UymFnK1TjbdSdIfMSIc
         4b/g==
X-Gm-Message-State: AOJu0Ywy84UNmHPsh41GPKRCzHJ1dCApTOJmOayBg7PQg3phllvtOKL0
        fgqS4EQd72di6vLrwUsQUjWYvson6Tg=
X-Google-Smtp-Source: AGHT+IHxxvfKb7sYphqiEH80MgNn6no+WlSe6mwkjghyGVLAhz51UUraQXN2vSCIrd3Mg+DzJsjQQlvELHM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:150:b0:da0:3da9:ce08 with SMTP id
 p16-20020a056902015000b00da03da9ce08mr91009ybh.10.1702488074979; Wed, 13 Dec
 2023 09:21:14 -0800 (PST)
Date:   Wed, 13 Dec 2023 09:21:13 -0800
In-Reply-To: <184e253d-06c4-419e-b2b4-7cce1f875ba5@redhat.com>
Mime-Version: 1.0
References: <20231208184628.2297994-1-pbonzini@redhat.com> <ZXPRGzgWFqFdI_ep@google.com>
 <184e253d-06c4-419e-b2b4-7cce1f875ba5@redhat.com>
Message-ID: <ZXnoCadq2J3cPz2r@google.com>
Subject: Re: [PATCH] KVM: selftests: fix supported_flags for aarch64
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Shaoqin Huang <shahuang@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023, Paolo Bonzini wrote:
> On 12/9/23 03:29, Sean Christopherson wrote:
> > On Fri, Dec 08, 2023, Paolo Bonzini wrote:
> > > KVM/Arm supports readonly memslots; fix the calculation of
> > > supported_flags in set_memory_region_test.c, otherwise the
> > > test fails.
> > 
> > You got beat by a few hours, and by a better solution ;-)
> > 
> > https://lore.kernel.org/all/20231208033505.2930064-1-shahuang@redhat.com
> 
> Better but also wrong---and my patch has the debatable merit of more
> clearly exposing the wrongness.  Testing individual architectures is bad,
> but testing __KVM_HAVE_READONLY_MEM makes the test fail when running a new
> test on an old kernel.

But we already crossed that bridge and burned it for good measure by switching
to KVM_SET_USER_MEMORY_REGION2, i.e. as of commit

  8d99e347c097 ("KVM: selftests: Convert lib's mem regions to KVM_SET_USER_MEMORY_REGION2")

selftests built against a new kernel can't run on an old kernel.  Building KVM
selftests requires kernel headers, so while not having a hard requirement that
the uapi headers are fresh would be nice, I don't think it buys all that much.

If we wanted to assert that x86, arm64, etc. enumerate __KVM_HAVE_READONLY_MEM,
i.e. ensure that read-only memory is supported as expected, then that can be done
as a completely unrelated test.

IMO, one of the big selling points of selftests over KUT is that we can punt on
supporting old kernels since selftests are in-tree.  I don't think it's at all
unreasonable to require that selftests be built against the target kernel, and
by doing so we can signficantly reduce the maintenance burden.  The kernel needs
to be backwards compatibile, but I don't see why selftests need to be backwards
compatible.

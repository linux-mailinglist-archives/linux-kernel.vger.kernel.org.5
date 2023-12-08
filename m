Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC7E80ABF6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574490AbjLHSVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjLHSVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:21:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692C584
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 10:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702059683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nLSlZUtE+vJwKxCXyAw/ZXA+/0tHeruZDXjXe1PSA+M=;
        b=Jp8954kYPW/iQdjoT44C7yPk/SORNe6y4rAytWRSl45PFBZUZgtWWFtOok+aWLg9R4Ptvt
        zXBR5yg+wCz4/Y+Uh/+/a5JoQ92dg7MLZoXzwYU6pOaprSkjW6ecfbvjK0idypz4eWz+9K
        8nN4TCjlawNytMIIeQcC/qQ/yrPuqyU=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-G_akDZTBOy-Rh6ckJcnQMw-1; Fri, 08 Dec 2023 13:21:22 -0500
X-MC-Unique: G_akDZTBOy-Rh6ckJcnQMw-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1faeac8b074so4680645fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 10:21:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702059681; x=1702664481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLSlZUtE+vJwKxCXyAw/ZXA+/0tHeruZDXjXe1PSA+M=;
        b=NK6tCLzDQxydNVEkABLkqeVp2+o2Rr1QjtIWJHJc/wgsZeYTToVrqrKBR1rbqSr4F5
         5rN+d5wG6DgqpvfGlxoBQBz5PTxL/eZwYAsUP/pDx3ViRtCwyHpZIey6oR9x3oMuFuYe
         Wyq9zfXZbnPVL84FZB/mm6F1F3Mn2UwT5Jj2+2TGf+7C6IL4x3hZiikO7c9i5Bj+DVNT
         Kt74z4PYt9v5zlj14pMB63dDKb6+gNVqDTo/v+5kdVax1FaJTCU5DrZknV1opu+st0Pj
         1tANtF/wEyMhTWBh5daIxYxhYVaPjZIIs513IBvvZOflt+8X9URvfzeW00H8+p71sAHA
         JLFw==
X-Gm-Message-State: AOJu0YxH6jcMeSVPPEqe6YU4+zmNCY1CDC2eAom4D2C1xq6b+/nBFQ1+
        djDgTcb16hHjIWLBUqOAKDWycFguz79EdimvjyOPvE2Gz/mRGWufdxhy3AudqcBwZDWpu4JRSOJ
        xBzBvAc6qIX3lJS1AE7EYdRN3dyjyYS3ndX4mXYiD
X-Received: by 2002:a05:6870:71d6:b0:1fb:34a7:ebbd with SMTP id p22-20020a05687071d600b001fb34a7ebbdmr566702oag.1.1702059681262;
        Fri, 08 Dec 2023 10:21:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbZzm5wC8wbpVxKq67MC5ECzNPzJFHkvrILIXuTMUoBGMt7D79VxJBXO0NVoVtV46/R206KUxojGA6kEUpH2c=
X-Received: by 2002:a05:6870:71d6:b0:1fb:34a7:ebbd with SMTP id
 p22-20020a05687071d600b001fb34a7ebbdmr566694oag.1.1702059681015; Fri, 08 Dec
 2023 10:21:21 -0800 (PST)
MIME-Version: 1.0
References: <20231208021708.1707327-1-seanjc@google.com>
In-Reply-To: <20231208021708.1707327-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Fri, 8 Dec 2023 19:21:08 +0100
Message-ID: <CABgObfbgs0z0Pe37T=TJprEkq0dZngSxKKKVnM74xHg6eFGegg@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: selftests: Fixes and cleanups for 6.7-rcN
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 3:17=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> Please pull selftests fixes/cleanups for 6.7.  The big change is adding
> __printf() annotation to the guest printf/assert helpers, which is waaay
> better than me playing whack-a-mole when tests fail (I'm still laughing
> at myself for not realizing what that annotation does).
>
> The following changes since commit e9e60c82fe391d04db55a91c733df4a017c28b=
2f:
>
>   selftests/kvm: fix compilation on non-x86_64 platforms (2023-11-21 11:5=
8:25 -0500)

This would be a 6.8 change though.

I singled out "KVM: selftests: Actually print out magic token in NX
hugepages skip message" and "KVM: selftests: add -MP to CFLAGS" and
pulled the rest into kvm/next, which means we'll have a couple dup
commits but nothing too bad.

Paolo

>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-selftests-6.7-rcN
>
> for you to fetch changes up to 1b2658e4c709135fe1910423d3216632f641baf9:
>
>   KVM: selftests: Annotate guest ucall, printf, and assert helpers with _=
_printf() (2023-12-01 08:15:41 -0800)
>
> ----------------------------------------------------------------
> KVM selftests fixes for 6.7-rcN:
>
>  - Fix an annoying goof where the NX hugepage test prints out garbage
>    instead of the magic token needed to run the text.
>
>  - Fix build errors when a header is delete/moved due to a missing flag
>    in the Makefile.
>
>  - Detect if KVM bugged/killed a selftest's VM and print out a helpful
>    message instead of complaining that a random ioctl() failed.
>
>  - Annotate the guest printf/assert helpers with __printf(), and fix the
>    various bugs that were lurking due to lack of said annotation.
>
> ----------------------------------------------------------------
> David Woodhouse (1):
>       KVM: selftests: add -MP to CFLAGS
>
> Sean Christopherson (7):
>       KVM: selftests: Drop the single-underscore ioctl() helpers
>       KVM: selftests: Add logic to detect if ioctl() failed because VM wa=
s killed
>       KVM: selftests: Remove x86's so called "MMIO warning" test
>       KVM: selftests: Fix MWAIT error message when guest assertion fails
>       KVM: selftests: Fix benign %llx vs. %lx issues in guest asserts
>       KVM: selftests: Fix broken assert messages in Hyper-V features test
>       KVM: selftests: Annotate guest ucall, printf, and assert helpers wi=
th __printf()
>
> angquan yu (1):
>       KVM: selftests: Actually print out magic token in NX hugepages skip=
 message
>
>  tools/testing/selftests/kvm/Makefile               |   3 +-
>  .../testing/selftests/kvm/include/kvm_util_base.h  |  75 ++++++++-----
>  tools/testing/selftests/kvm/include/test_util.h    |   2 +-
>  tools/testing/selftests/kvm/include/ucall_common.h |   7 +-
>  tools/testing/selftests/kvm/lib/kvm_util.c         |   2 +-
>  .../testing/selftests/kvm/set_memory_region_test.c |   6 +-
>  .../testing/selftests/kvm/x86_64/hyperv_features.c |  10 +-
>  .../selftests/kvm/x86_64/mmio_warning_test.c       | 121 ---------------=
------
>  .../selftests/kvm/x86_64/monitor_mwait_test.c      |   6 +-
>  .../selftests/kvm/x86_64/nx_huge_pages_test.c      |   2 +-
>  .../kvm/x86_64/private_mem_conversions_test.c      |   2 +-
>  .../kvm/x86_64/svm_nested_soft_inject_test.c       |   4 +-
>  .../selftests/kvm/x86_64/vmx_pmu_caps_test.c       |   2 +-
>  .../testing/selftests/kvm/x86_64/xcr0_cpuid_test.c |   8 +-
>  14 files changed, 78 insertions(+), 172 deletions(-)
>  delete mode 100644 tools/testing/selftests/kvm/x86_64/mmio_warning_test.=
c
>


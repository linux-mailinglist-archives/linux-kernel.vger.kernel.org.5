Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DE878028D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 02:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356690AbjHRAJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 20:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356659AbjHRAJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 20:09:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AF43AAA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 17:09:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d672f55d48dso428837276.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 17:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692317353; x=1692922153;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BLLO+u/OT5chdoeLR8F8hFvDKYI8Fp7aAauLQAtPX1A=;
        b=BGaFvA2Zuc3NZdVSHTtuulR9e/pDkx3JhhBtIMyK9tqIE8ZSUBJjoqaZF3k69VEi2q
         kNpZYy3sitD2xuPxGOlRb/hCABn484oxq9SrAgG+LizBFuYG+tivd16AoQ5lbLlCLIQ4
         bWsVUUqrr7Ht37ztZnf8+uy4kUvhtY4i6NLYrd34DIxeUARUIt8ZE1Xj/enJylspblk6
         FWGGDkZsDZ+zOkdQykvQ4AEpTnnNq6MW+zfAo4n8AH4baez6olBZQJ6Cs7wWH2R/nL7F
         PfqAOa+GJN+JD6Uj8rE9bOnauV830shzIAQRjgfU1sNzXl7Ule/sfhNsfXt5xpGk4h+F
         fFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692317353; x=1692922153;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BLLO+u/OT5chdoeLR8F8hFvDKYI8Fp7aAauLQAtPX1A=;
        b=CoWM8Bc+h9qlfOw3eFL6+sHdiFnNvVnVFZjSNzcEnQkGy+rMlDC2I8VL8/NA0q36lJ
         amvt90hNMTUuS68KM9V+/u90CSNnxm/QhHqxcgfHbdUcGARg8gM+tL+KUNknI2MmGoI9
         wF3GYwpCb3p3rNK8HUGsq2XWyDSZ6CETz+jCStg57WOC6jmxn11hWkFCtFwy3Y12OUHt
         /K9fqKBHsKQK6HU/HCYYpJYOqmvUaX03EvAJb/bWh1b5QADVGEMLkqXEevmO1BDl5Ezx
         snJU0uIf3OXTnFyQNCbilsaF1rENAvVzusKno264phykCSEzCoC+YpVyqyqqdWXdQgBu
         yIMQ==
X-Gm-Message-State: AOJu0YycFm5BueOIhVu3wyI4vzpg8wvwi9pQHd7J/2AuXdWQa/j07u1R
        1XE8smxaBfkLoIRRzI54jnfuiB+NQtg=
X-Google-Smtp-Source: AGHT+IHKHrf99ixJMKRLXpufhlfXlQffDae9waK57qBJdE0W8LSMBtBoy/QMDtjZaYiVnEPiucbkhKBjnuU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d8c5:0:b0:d4f:22c:69a3 with SMTP id
 p188-20020a25d8c5000000b00d4f022c69a3mr13874ybg.10.1692317353082; Thu, 17 Aug
 2023 17:09:13 -0700 (PDT)
Date:   Thu, 17 Aug 2023 17:08:38 -0700
In-Reply-To: <20230814140339.47732-1-yuehaibing@huawei.com>
Mime-Version: 1.0
References: <20230814140339.47732-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <169229955442.1259727.3577431568257591049.b4-ty@google.com>
Subject: Re: [PATCH v2 -next] kvm_host: Remove unused declarations
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com,
        Yue Haibing <yuehaibing@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        nitesh@redhat.com, scottwood@freescale.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023 22:03:39 +0800, Yue Haibing wrote:
> Commit 07f0a7bdec5c ("kvm: destroy emulated devices on VM exit") removed the
> functions but not these declarations.
> Commit 7ee30bc132c6 ("KVM: x86: deliver KVM IOAPIC scan request to target vCPUs")
> declared but never implemented kvm_make_cpus_request_mask()
> 
> 

Applied to kvm-x86 generic, though I split it into two patches.  The removal
of kvm_make_cpus_request_mask() is surprisingly interesting, and likely related
to the spurious declaration.  The exclusive/all versions use "cpus", whereas
the inclusive mask helper uses "vcpus".  I'm guessing the spurious declaration
came in because the original author tried to match the exclusive/all versions.

IMO, "vcpus" is obviously better terminology, e.g. differentiates from
kvm_kick_many_cpus(), which targets physical CPUs.  I think we should rename
kvm_make_all_cpus_request() and kvm_make_all_cpus_request_except() to use
"vcpus", but that's a much larger patch (trivial, but large).  I'll send that
cleanup for the 6.7 cycle.

Thanks!

[1/2] KVM: Remove unused kvm_device_{get,put}() declarations
      https://github.com/kvm-x86/linux/commit/1f8403953f05
[2/2] KVM: Remove unused kvm_make_cpus_request_mask() declaration
      https://github.com/kvm-x86/linux/commit/458933d33af2

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes

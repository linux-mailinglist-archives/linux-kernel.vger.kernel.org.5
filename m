Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15BD777C55
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbjHJPhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbjHJPhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:37:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB98270B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:37:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d1d9814b89fso1147475276.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691681870; x=1692286670;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RoY5fOsDyhMWL64WpuejCY8O9zoZQHOm1KweocaouSo=;
        b=0ZyUSeFGxBOCrv92MDbJZR5/LMl3+/9zloKTRjCl1i1R3bQ4cKAg5sU4rpzrOUEAuT
         K+Nx3tsUqwOomD30XLOMHJUVc0K8wbgp6Vv0E7+YuNNlSQ83AZ7aIQ10K9A8UiDasw1n
         zRAhu34Yu0T7QnwSH9EWSvnVG0aspz6lJM8Ix2oT0rKrNfOgvgFrovIzMU0H6mdb2Zab
         TewCZMVYEoCt7EMap40ZmAMFtk/lbRcWm9ETw+4CBGrInv6nwWRxIgp9aBhAH5Xz9tZE
         XHQ1o7fRWwMYmV0qCBp9hEq+r3p1NUSrBFZUNxbB6s7AzilFZ+NsnyGKYGvjYRQp3e99
         Aoiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691681870; x=1692286670;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RoY5fOsDyhMWL64WpuejCY8O9zoZQHOm1KweocaouSo=;
        b=GrKzOvg4q3qkYSpd52OplQ7yBro50vJlHU5gUGxD42YeBiKyrb/FKOFcEp+ypDOEBh
         tWmShh2LcaUsLvCp+AdMxvxEbp8WT86eyKq1I/TumSa0Qbs01vAafRo2WRHSM0GRkLd7
         b4CK2tNThffffEoH6cNVhtAJtsrPQYtUMxYDoqo10Q8P1DKuQux1P4nFM/I4Rzf0M7SC
         bNCSUhHLAGhzeVKmiwHU+sSWWj0+2HMqfYnG1hTFt0Rm1476f+/gg+mmU+6LTh2FvIaE
         NNlxwMKZtv2rHFIT7kRWKfkGQbQDBVyt8ssstxceRfJxAyQnuSzPiLn+nqDSovFyiyOJ
         O22Q==
X-Gm-Message-State: AOJu0YwRuX5fbFm+XNoIh6K3A4btQAF3u9sQ1leT6s1weyPmsQ6GfLEC
        nd+FZ9mPssHPE7dvrMWBKd/auzugpGU=
X-Google-Smtp-Source: AGHT+IFPcqYZQb7qmOIJ0atSqU7MDX1p8ghlBFjYJJzXQ9tZQjRlNSPReCf6KJyOLSJk1796V0LeOWwhaQQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:74c:0:b0:d42:42f8:93bf with SMTP id
 s12-20020a5b074c000000b00d4242f893bfmr48232ybq.0.1691681870506; Thu, 10 Aug
 2023 08:37:50 -0700 (PDT)
Date:   Thu, 10 Aug 2023 08:37:48 -0700
In-Reply-To: <8396a9f6-fbc4-1e62-b6a9-3df568fd15a2@redhat.com>
Mime-Version: 1.0
References: <20230803042732.88515-1-weijiang.yang@intel.com>
 <20230803042732.88515-10-weijiang.yang@intel.com> <ZMuMN/8Qa1sjJR/n@chao-email>
 <bfc0b3cb-c17a-0ad6-6378-0c4e38f23024@intel.com> <ZM1jV3UPL0AMpVDI@google.com>
 <806e26c2-8d21-9cc9-a0b7-7787dd231729@intel.com> <c871cc44-b6a0-06e3-493b-33ddf4fa6e05@intel.com>
 <8396a9f6-fbc4-1e62-b6a9-3df568fd15a2@redhat.com>
Message-ID: <ZNUETFZK7K5zyr3X@google.com>
Subject: Re: [PATCH v5 09/19] KVM:x86: Make guest supervisor states as
 non-XSAVE managed
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        Chao Gao <chao.gao@intel.com>, john.allen@amd.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rick.p.edgecombe@intel.com, binbin.wu@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023, Paolo Bonzini wrote:
> On 8/10/23 16:29, Dave Hansen wrote:
> > On 8/10/23 02:29, Yang, Weijiang wrote:
> > ...
> > > When KVM enumerates shadow stack support for guest in CPUID(0x7,
> > > 0).ECX[bit7], architecturally it claims both SS user and supervisor
> > > mode are supported. Although the latter is not supported in Linux,
> > > but in virtualization world, the guest OS could be non-Linux system,
> > > so KVM supervisor state support is necessary in this case.
> > 
> > What actual OSes need this support?
> 
> I think Xen could use it when running nested.  But KVM cannot expose support
> for CET in CPUID, and at the same time fake support for
> MSR_IA32_PL{0,1,2}_SSP (e.g. inject a #GP if it's ever written to a nonzero
> value).
> 
> I suppose we could invent our own paravirtualized CPUID bit for "supervisor
> IBT works but supervisor SHSTK doesn't".  Linux could check that but I don't
> think it's a good idea.
> 
> So... do, or do not.  There is no try. :)

> > I want to hear more about who is going to use CET_S state under KVM in
> > practice.  I don't want to touch it if this is some kind of purely
> > academic exercise.  But it's also silly to hack some kind of temporary
> > solution into KVM that we'll rip out in a year when real supervisor
> > shadow stack support comes along.

As Paolo alluded to, this is about KVM faithfully emulating the architecture.
There is no combination of CPUID bits that allows KVM to advertise SHSTK for
userspace without advertising SHSTK for supervisor.

Whether or not there are any users in the short term is unfortunately irrelevant
from KVM's perspective.

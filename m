Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026D67FC374
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346439AbjK1Sgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjK1Sgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:36:52 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865FF137
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:36:58 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6cbb6ff734dso6296423b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701196618; x=1701801418; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O91Uupu7339NvmzBM4XpIhItH5W0W9g2NalbW1uqHV0=;
        b=sXXfDUciz3s5t18qTXQqBPK0QRwHfDoXwAHLBU4FEbt76xy1CCyIfzYuINW0OGaZOc
         XPzTg0drGDNmcCFF26U3n0TA3PCX281VYHUlfgar61NIF/yexlnBqzXat2Z5osQMPHzE
         8AGltxMkbm2DKUvdmyFPb10AV1JVK7oMxll17zb3i13DMt/ybgcnaH3sVfBsw47QmkNc
         uH47mDEfMcL/q5d7r8q7bfXf+NOlaJe/mNA1Q38Y2M+60IhIRrenlddv0U/HBxo8gi3j
         bbk6WaNjlp7KxifGRbbyfDWH01VDgjWZudsdj1h+2QshJnUtl7Uy7aNlRy5XbbrroEwt
         zG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701196618; x=1701801418;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O91Uupu7339NvmzBM4XpIhItH5W0W9g2NalbW1uqHV0=;
        b=JEG9JwM2V+zrkb8k24N6101NFOpWfXU7TXnMCYZ69jrbmIolc4XjOZwfRyAXA/tYRk
         QT0Xnpy81YJjKJ+TyraNuoG/3TTvUGX/y1ukpqHaS8rSealHMgmM8EB89y6zNZvCkH1p
         yw5RiVm9rFUOG/Z8kbV44fe/C2h9wuHcqkMa0Fe9dZJC5Y9pTOR9YwNXlWD5xaDKBGPT
         3/ltTs9PmdrKxjetHQcft1UY3GZGcGuzglYuHVLCLorT5SEazVnKU/iFytvJQSeV2S6g
         b6Te0yUZLCMKN85CFvWGtOj4zX3G3bbEvbMwuLv+QDtOR/RfwP7CwDxM+F0WNywAah6b
         MqwA==
X-Gm-Message-State: AOJu0YyDAvSerQvZ8nEpj/pzKlj/kmCuKPnqLUUEw/cBGSe8A+QQSCol
        CU9JnbscAF4f8NKAM+opNmjfhzz/t+A=
X-Google-Smtp-Source: AGHT+IHHKYVk1YH4G56UI7cwpbQhbgUXkv7M9X5puoa7iZZH1O4DvGlAXRcA0vIVhRPQPUJ+/0kD/V/tQ/s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1389:b0:6cb:95ab:cf8d with SMTP id
 t9-20020a056a00138900b006cb95abcf8dmr4156728pfg.6.1701196618074; Tue, 28 Nov
 2023 10:36:58 -0800 (PST)
Date:   Tue, 28 Nov 2023 10:36:56 -0800
In-Reply-To: <c964b29b08854b2779a75584cf2c3bb1e5ccb26a.camel@redhat.com>
Mime-Version: 1.0
References: <20231107182159.404770-1-seanjc@google.com> <c964b29b08854b2779a75584cf2c3bb1e5ccb26a.camel@redhat.com>
Message-ID: <ZWYzSMWtwDiSFUR1@google.com>
Subject: Re: [PATCH] KVM: selftests: Fix MWAIT error message when guest
 assertion fails
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sun, Nov 19, 2023, Maxim Levitsky wrote:
> On Tue, 2023-11-07 at 10:21 -0800, Sean Christopherson wrote:
> > Print out the test and vector as intended when a guest assert fails an
> > assertion regarding MONITOR/MWAIT faulting.  Unfortunately, the guest
> > printf support doesn't detect such issues at compile-time, so the bug
> > manifests as a confusing error message, e.g. in the most confusing case,
> > the test complains that it got vector "0" instead of expected vector "0".
> > 
> > Fixes: 0f52e4aaa614 ("KVM: selftests: Convert the MONITOR/MWAIT test to use printf guest asserts")
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c b/tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c
> > index 80aa3d8b18f8..853802641e1e 100644
> > --- a/tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c
> > +++ b/tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c
> > @@ -27,10 +27,12 @@ do {									\
> >  									\
> >  	if (fault_wanted)						\
> >  		__GUEST_ASSERT((vector) == UD_VECTOR,			\
> > -			       "Expected #UD on " insn " for testcase '0x%x', got '0x%x'", vector); \
> > +			       "Expected #UD on " insn " for testcase '0x%x', got '0x%x'", \
> > +			       testcase, vector);			\
> >  	else								\
> >  		__GUEST_ASSERT(!(vector),				\
> > -			       "Expected success on " insn " for testcase '0x%x', got '0x%x'", vector); \
> > +			       "Expected success on " insn " for testcase '0x%x', got '0x%x'", \
> > +			       testcase, vector);			\
> >  } while (0)
> >  
> >  static void guest_monitor_wait(int testcase)
> > 
> > base-commit: 45b890f7689eb0aba454fc5831d2d79763781677
> 
> I think that these days the gcc (and llvm likely) support printf annotations,
> and usually complain, we should look at adding these to have a warning in
> such cases.

Huh.  Well now I feel quite stupid for not realizing that's what

	__attribute__((__format__(printf, ...)))

is for.  There's even a handy dandy __printf() macro now.  I'll post a v2 with
the annotations and fixes for all existing violations.

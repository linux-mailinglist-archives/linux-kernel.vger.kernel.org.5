Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FA67E2A2D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjKFQp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFQpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:45:54 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15846191
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 08:45:52 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5aecf6e30e9so63484417b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 08:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699289151; x=1699893951; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aOiMdoM502S2KW47u+OJd6KgkJY8UT00qBsOiFWsPPc=;
        b=Jq2+XEWiyUJsJPCSRmHnk6MACYI4JIuS5Vr4/gGLw8fHmEfcHMboDCmaOIWmGC2nkG
         6qQ0NWu5zkYAivmwzlyfHaXjHmT4jJsj+JjTKahBVYh9llYVINU2o+OrIQx4ZOa9ounk
         mV8+v3mtAttKhxqaE0xfR4sDr54NPKoREA1a3OTuYJp0Y5TaO6a5aLQ+IPgJ80Lz8YFf
         Zf7+lVl45jtEJfTb+Kc3ql0513p0jc6kp7I7y6AS/c8EJmHhGIuyf0rc1WzqL6swOZzX
         MWMlE5gzQ3agyruVHSA9GoasLJK5L46lsjVbTxLRvAHw37+JYIMJIJYHnsuJtWZBy2f6
         jH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699289151; x=1699893951;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aOiMdoM502S2KW47u+OJd6KgkJY8UT00qBsOiFWsPPc=;
        b=Czy1MpYSWYR2NBnXqoVeuoBHPjM/c7cOZrh57UkMoIIL5I3jZUuYkZr4IofPuyHH7Q
         JkQbAKUK7ThanSAb6NTOX2wsRonDbF2G1hxI8X5UO3WMbHFiw2HkkJqKQhoKAn/Lhf+t
         xswKBplkqjkXAQU4NUx2dTy80DAnc8VvO1tW6BWueWXPGvzAWDmF1ErVuJlzO+3K0mbr
         vsyi8XE24os8uNZoimiumca1TVfUlHC+8C5t5G8N/eUjXLVEu31ZnajuaBMlj1ur8OSV
         MuRoKlnYFfq8eRd/D1UVW9s+Eo3rvaL4Cr16ytHJ+qNTo32zbew4cl9IbsKPgfPCUL0c
         gi9Q==
X-Gm-Message-State: AOJu0YwA8J84itiRJE68j5iRk1Ene/0p3ut87nzcKU+dfvbAhNHzOXCr
        vxfX4rqpwK+AyoH6l+yXA7wgywsB2AU=
X-Google-Smtp-Source: AGHT+IGzgx6Xrns9ibInxlOaaTlB1HMfvVJO1aF0Ilz0hUdWqLLXikJDl0rzl1f3edD8+cyAQV+3hR8QkVw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:c789:0:b0:d9a:c218:8177 with SMTP id
 w131-20020a25c789000000b00d9ac2188177mr514830ybe.8.1699289151328; Mon, 06 Nov
 2023 08:45:51 -0800 (PST)
Date:   Mon, 6 Nov 2023 08:45:49 -0800
In-Reply-To: <874ae0019fb33784520270db7d5213af0d42290d.camel@redhat.com>
Mime-Version: 1.0
References: <20231010200220.897953-1-john.allen@amd.com> <20231010200220.897953-4-john.allen@amd.com>
 <8484053f-2777-eb55-a30c-64125fbfc3ec@amd.com> <ZS7PubpX4k/LXGNq@johallen-workstation>
 <c65817b0-7fa6-7c0b-6423-5f33062c9665@amd.com> <874ae0019fb33784520270db7d5213af0d42290d.camel@redhat.com>
Message-ID: <ZUkYPfxHmMZB03iv@google.com>
Subject: Re: [PATCH 3/9] KVM: x86: SVM: Pass through shadow stack MSRs
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     nikunj@amd.com, John Allen <john.allen@amd.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, weijiang.yang@intel.com,
        rick.p.edgecombe@intel.com, x86@kernel.org,
        thomas.lendacky@amd.com, bp@alien8.de
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023, Maxim Levitsky wrote:
> On Wed, 2023-10-18 at 16:57 +0530, Nikunj A. Dadhania wrote:
> > On 10/17/2023 11:47 PM, John Allen wrote:
> > In that case, intercept should be cleared from the very beginning.
> > 
> > +	{ .index = MSR_IA32_PL0_SSP,                    .always = true },
> > +	{ .index = MSR_IA32_PL1_SSP,                    .always = true },
> > +	{ .index = MSR_IA32_PL2_SSP,                    .always = true },
> > +	{ .index = MSR_IA32_PL3_SSP,                    .always = true },
> 
> .always is only true when a MSR is *always* passed through. CET msrs are only
> passed through when CET is supported.
> 
> Therefore I don't expect that we ever add another msr to this list which has
> .always = true.
> 
> In fact the .always = True for X86_64 arch msrs like MSR_GS_BASE/MSR_FS_BASE
> and such is not 100% correct too - when we start a VM which doesn't have
> cpuid bit X86_FEATURE_LM, these msrs should not exist and I think that we
> have a kvm unit test that fails because of this on 32 bit but I didn't bother
> yet to fix it.
> 
> .always probably needs to be dropped completely.

FWIW, I have a half-baked series to clean up SVM's MSR interception code and
converge the SVM and VMX APIs.  E.g. set_msr_interception_bitmap()'s inverted
polarity confuses me every time I look at its usage.

I can hunt down the branch if someone plans on tackling this code.

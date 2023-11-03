Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F5E7E0430
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377752AbjKCOCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377744AbjKCOCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:02:13 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48E61BC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 07:02:10 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5af592fed43so27757327b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 07:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699020130; x=1699624930; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vb+9RYEjnomUPpbNpxqOTLjP3moxOF2MeghLG8Ocm5Q=;
        b=hYvYIue6naFKM5SdZNzv3pM4bor9uY+uQjF4or5O9sGazevZ+YOhkEBNnBYwD8SIPJ
         TnNaYTeFZFgQ6kzYn1WaCpLWp6oqiIISEJTLhIhblinHLs24mY18dx/Lw7q03KU9f43l
         v0CCPKNbKHa7Z1N7uoqtVGlKTfJU1DaglNOvH9ueMO7mIfZocnFakr3PNVDbiMU5mT1R
         q3p5Zy451LivN8EHZc2p4hMyJb5KUrNoQkk29vj11w5YU++BiF3ph14PpNq5Xw99j6Jz
         1BsEPWoEf2nD+idkA8GAzWsyJm5D9bEP0ze4lh8BUsiFGE2Y9nl/lXVVUBjsIg/wNyR4
         YCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699020130; x=1699624930;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vb+9RYEjnomUPpbNpxqOTLjP3moxOF2MeghLG8Ocm5Q=;
        b=MMsVvc3SDyhUFDPep7HVYQMDvkqZtrGMjnpOUXl6H7Uo9DDF+Kl4IomGjNOq+Zv8Qb
         eL4MIDXyqNfqL1yJ+TZ/ElP6YU1V2/yE0/65GeKH1gf+IeC4oXKieVP0CPVvtqJ7ase7
         cehZHPHDAHnE8ZkPvQNZaIhjet5IednMb1kQd47HEioCJL8NGsnADz2/tTuTt+AKf+F6
         YSniOlgUZTozeudGShYZFLBIKolYznti/j3JBxKOWTV2FDQWvtFd5r+JVa6A7VaIqzi9
         yez4Lf+oJwSmpuCjmHRO6PMFhVKK955hRPu5qtcCqqTiUz7KMzexgpCzaS/LKXP2esJu
         b2qg==
X-Gm-Message-State: AOJu0YxzjVBvMdm8t8U7SlK+3WWCISfQ1XinAJ10n//ppirkMxs1up7O
        erfSt/LvYnasKkHxmJyX5AZMKCw3G1s=
X-Google-Smtp-Source: AGHT+IGEA1BvGiRWNQjrbq7aKq8bZ+jodDO8Ix7KIjtF8dmXoXMo1O1r7lSdH3mz9BX0C3GycpAGBkiz/BY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:5215:0:b0:5a7:acc1:5142 with SMTP id
 g21-20020a815215000000b005a7acc15142mr55197ywb.8.1699020129602; Fri, 03 Nov
 2023 07:02:09 -0700 (PDT)
Date:   Fri, 3 Nov 2023 07:02:07 -0700
In-Reply-To: <10fd9a3e-1bc2-7d4d-0535-162854fc5e9d@intel.com>
Mime-Version: 1.0
References: <20230914063325.85503-1-weijiang.yang@intel.com>
 <20230914063325.85503-15-weijiang.yang@intel.com> <2b1973ee44498039c97d4d11de3a93b0f3b1d2d8.camel@redhat.com>
 <ZUKTd_a00fs1nyyk@google.com> <10fd9a3e-1bc2-7d4d-0535-162854fc5e9d@intel.com>
Message-ID: <ZUT9X9GbDbkHRhd5@google.com>
Subject: Re: [PATCH v6 14/25] KVM: x86: Load guest FPU state when access
 XSAVE-managed MSRs
From:   Sean Christopherson <seanjc@google.com>
To:     Weijiang Yang <weijiang.yang@intel.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, pbonzini@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023, Weijiang Yang wrote:
> On 11/2/2023 2:05 AM, Sean Christopherson wrote:
> > /*
> >   * Returns true if the MSR in question is managed via XSTATE, i.e. is context
> >   * switched with the rest of guest FPU state.
> >   */
> > static bool is_xstate_managed_msr(u32 index)
> 
> How about is_xfeature_msr()? xfeature is XSAVE-Supported-Feature, just to align with SDM
> convention.

My vote remains for is_xstate_managed_msr().  is_xfeature_msr() could also refer
to MSRs that control XSTATE features, e.g. XSS.

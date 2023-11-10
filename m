Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5587E7E78
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345457AbjKJRpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345957AbjKJRoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:44:09 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0591A39CEE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:51:22 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-daa2684f67eso1691291276.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699627881; x=1700232681; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0mloYI4ZoLlQinekJcU/lurgLOSGND62aO9fKE274N0=;
        b=A0RhG0QzUR2cP7qmBFogt1s+A3mu+i+sr05ow5cRIJGSQOzcKQ8DFkKZBMKLFrYmO/
         KRPQj8GslF9joEmC8E+Fvq+IXAK3qZxlIytoa/In0dxtTQ25zhPDIkCy9fAuTVjSHy9F
         ZwWdtPPdR8wfzJwXxfqr7Nh7mHguvRtlbl1745I30oloZTMj3y392Dqy1euN2F1wjCnm
         VCAbuqtRI09rD10x3jdjN/YJQwkjXJZkQnvNc+CfXzk1pHa7W9pcQHpccJo+xmoS2iAd
         d0u7CReIoZAl2BpgZaj6PSpDtq3Be2nksYXXB1vxV+HESvM7rHHVD9kRKuzejF5QFEyu
         iLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699627881; x=1700232681;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0mloYI4ZoLlQinekJcU/lurgLOSGND62aO9fKE274N0=;
        b=FWk61FwSttG1L6+5ojPBQnhs2AqTBBmG1bhY6jyToFgueZFoq6vr9U+AqSFotUoAat
         m/ZHj31Ri212IPi0nmsA9ixN7C/QTstlPPQB2hEYEVMygE/jVEX8E0jYF7KI7VFtRPXJ
         zH9iRW8BJIKKZHzuAvmCfcDy3zuSzzBv8Ypp3cGLdDJwfjE3q5Abb5x0BOv8oWfc3Dqc
         emyuUAT7KZWzexbzlYjGP+e+Pk1OhmbmyinZwi96Dr5raKys/WmH4PJKAJv9LxavImoD
         3ghiKAYrf28rODHubgygDslGAblwT6kwOLLCHJ7lokbJZUrG5u64LBdxXk0NU7c+rxYx
         wVuA==
X-Gm-Message-State: AOJu0YwHpd23uckWy6q9BA5i4ddFwk3lWYd00MHQkSX1tgQUOJAZ3LpP
        fp2nLClM9XNBLXRMc2OwM5UA9fIDBpw=
X-Google-Smtp-Source: AGHT+IH3/OeuatOzR2sFBSWymG2OgAYclU8eTE9kiFo/7nRT84eGi909cRo3wqw1PhQmUAKhID8qy0DK6Ig=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:384:b0:da0:37e1:558e with SMTP id
 f4-20020a056902038400b00da037e1558emr91865ybs.6.1699627881224; Fri, 10 Nov
 2023 06:51:21 -0800 (PST)
Date:   Fri, 10 Nov 2023 06:51:19 -0800
In-Reply-To: <5d0c1946-0b22-4983-868b-db7f79fe16bc@linux.intel.com>
Mime-Version: 1.0
References: <20231110021306.1269082-1-seanjc@google.com> <20231110021306.1269082-8-seanjc@google.com>
 <5d0c1946-0b22-4983-868b-db7f79fe16bc@linux.intel.com>
Message-ID: <ZU5DZ110JPvcmZp0@google.com>
Subject: Re: [PATCH v8 07/26] KVM: x86/pmu: Apply "fast" RDPMC only to Intel PMUs
From:   Sean Christopherson <seanjc@google.com>
To:     Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Jim Mattson <jmattson@google.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Like Xu <likexu@tencent.com>
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

On Fri, Nov 10, 2023, Dapeng Mi wrote:
> 
> On 11/10/2023 10:12 AM, Sean Christopherson wrote:
> > Move the handling of "fast" RDPMC instructions, which drop bits 63:31 of
> 
> 63:32?

Oof, yeah.

> > @@ -55,12 +59,17 @@ static struct kvm_pmc *intel_pmc_idx_to_pmc(struct kvm_pmu *pmu, int pmc_idx)
> >   	}
> >   }
> > +static u32 intel_rdpmc_get_masked_idx(struct kvm_pmu *pmu, u32 idx)
> 
> inline?

No, for functions that are visible only to the local compilation unit, there's
no reason to use "inline".  "inline" is just a hint, and modern compilers are
smart enough to inline functions when appropriate without a hint, e.g. gcc and
clang inline this on all my configurations.  Compilers may also ignore the hint,
e.g. KASAN=y tends to produce some really amusing results.

A longer explanation/rant here: https://lore.kernel.org/all/ZAdfX+S323JVWNZC@google.com

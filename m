Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA55765952
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjG0Q6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjG0Q60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:58:26 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C9030FA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:58:22 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58456435437so12023307b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690477102; x=1691081902;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4xYefQnfYtKpl5Tvn3l6r22ye4r6Itm+ri5XwBUllms=;
        b=bXZyyVDXb3SULma4QEYC8oUf1j1vR/cFOkHUcZEp5PBKPPq03xmjHa7FH/F6yXfnDw
         wL8rm5SzewNXwG2IGQlV+dQfPQ14oFzONBXVRyyThW+iYO/As6z+KMf8cbkbhbVDRfK/
         9pytweYZDZZG8kkYhDTIx2ovp5BFmnr6Iw4zOUo6ila3ezKEUD/+iSkRk/KmvMT/anfj
         r5IRzqVflMC6/dbrTFu9Q+uvAa8xmHxf21jE8dtJNJ3tcYib1PnsHtsZZO/+l824IG2w
         BvGp1/C8zsDfHG1PlpEzzBGD3/66tobtjS9i1HlSfuYE5Dy+EHIl9GovebECoSzNF8Jw
         nqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690477102; x=1691081902;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4xYefQnfYtKpl5Tvn3l6r22ye4r6Itm+ri5XwBUllms=;
        b=hwS1iml4CedNpg0M8+Z+ug2Hx3Sl3RuHN7sBfoHURyH91zYFrw2e4ii85xm7jsViw9
         W2Pb4t9R6BQsuPuQGqtI7PHkuHgoLirr3rmecj9zsa6oQ7fB4Qszk9A5ohINcg27WUqL
         URHBE3ch3WaModi3g29dO3ZMhX+thQc5XqoZpJktUcv6fxTDFLPhvsz6s7h9cscmR3vp
         VigjKIAfjGpnjJZ/e26VvAhpZgIORB0dhiZXbqC0odhzALmAc1IadMZSngtJrBkjT/CL
         OZuQ4yVle/WYQ1LNl4Z5ooHequaKsIcLTf31Tzi4NXZFYMG1oEa0E4FoJvINlSb/8Bfj
         kxtw==
X-Gm-Message-State: ABy/qLahjILG/QUj2kYr5atjbkKn5tlUBDYZA5grEsf9uHZ5regJafr/
        w2c5Ej37hoNGbn1JONGNcbcFCkiihAs=
X-Google-Smtp-Source: APBJJlF+PSqQxfnn2LQeexAEMrTg+4SAEMxe7lFjkKkPuT9k101/25+MOgQiH0DwUWwlKBWbnws/GhVq8ig=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:c08f:0:b0:d10:5b67:843c with SMTP id
 c137-20020a25c08f000000b00d105b67843cmr32796ybf.4.1690477102279; Thu, 27 Jul
 2023 09:58:22 -0700 (PDT)
Date:   Thu, 27 Jul 2023 09:58:20 -0700
In-Reply-To: <ZMIflGq2i3m3bNLU@chao-email>
Mime-Version: 1.0
References: <20230721030352.72414-1-weijiang.yang@intel.com>
 <20230721030352.72414-10-weijiang.yang@intel.com> <ZMDMQHwlj9m7C39s@chao-email>
 <67250373-c5f4-d1d7-9334-4c9e6a43ab63@intel.com> <ZMEjudsdr8WEiw3b@chao-email>
 <4565ab4b-f386-7b70-4634-627e92acbb45@intel.com> <ZMIflGq2i3m3bNLU@chao-email>
Message-ID: <ZMKiLI2oEHivN000@google.com>
Subject: Re: [PATCH v4 09/20] KVM:x86: Add common code of CET MSR access
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Gao <chao.gao@intel.com>
Cc:     Weijiang Yang <weijiang.yang@intel.com>, pbonzini@redhat.com,
        peterz@infradead.org, john.allen@amd.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com,
        binbin.wu@linux.intel.com
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

On Thu, Jul 27, 2023, Chao Gao wrote:
> >> -	case MSR_KVM_GUEST_SSP:
> >> -	case MSR_IA32_PL0_SSP ... MSR_IA32_INT_SSP_TAB:
> >> 	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
> >> 		if (!kvm_cet_is_msr_accessible(vcpu, msr_info))
> >> 			return 1;
> >> 		if (is_noncanonical_address(data, vcpu))
> >> 			return 1;
> >> 		if (!IS_ALIGNED(data, 4))
> >> 			return 1;
> >> 		if (msr == MSR_IA32_PL0_SSP || msr == MSR_IA32_PL1_SSP ||
> >> 		    msr == MSR_IA32_PL2_SSP) {
> >> 			vcpu->arch.cet_s_ssp[msr - MSR_IA32_PL0_SSP] = data;
> >> 		} else if (msr == MSR_IA32_PL3_SSP) {
> >> 			kvm_set_xsave_msr(msr_info);
> >> 		}
> >> 		break;
> >> 
> >> 
> >> 
> >> BTW, shouldn't bit2:0 of MSR_KVM_GUEST_SSP be 0? i.e., for MSR_KVM_GUEST_SSP,
> >> the alignment check should be IS_ALIGNED(data, 8).
> >
> >The check for GUEST_SSP should be consistent with that of PLx_SSPs, otherwise
> >there would be issues
> 
> OK. I had the question because Gil said in a previous email:
> 
> 	IDT event delivery, when changing to rings 0-2 will load SSP from the
> 	MSR corresponding to the new ring.  These transitions check that bits
> 	2:0 of the new value are all zero and will generate a nested fault if
> 	any of those bits are set.  (Far CALL using a call gate also checks this
> 	if changing CPL.)
> 
> it sounds to me, at least for CPL0-2, SSP (or the synethic
> MSR_KVM_GUEST_SSP) should be 8-byte aligned. Otherwise, there will be a
> nested fault when trying to load SSP.

Yes, but that's the guest's problem.  KVM's responsibility is purely to faithfully
emulate hardware, which in this case means requiring that bits 1:0 be cleared on
the WRMSR.  *Architecturally*, software is allowed to set bit 2, and only if/when
the vCPU consumes the "bad" value by transitioning to the relevant CPL will the
CPU generate a fault.

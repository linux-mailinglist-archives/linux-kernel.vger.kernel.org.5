Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865B37E8101
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345003AbjKJSV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345487AbjKJSST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:18:19 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EFB3A216
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 07:02:01 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-28035cf4306so2913878a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 07:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699628521; x=1700233321; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mUJOBd/q/zD8P/9fxYVqe+7Mn835Ht5oRjEbFlzm6ss=;
        b=d7g6DehcfOXh0WImbji5j74arnOzVM1VpJbGkEfOo9q9ZAPDuQoC3TLLZPEzqJwtte
         bKm4LRgj0uCjtVy+rcSEurq81Ss5rC0eH/0244wO0RBAgA8bnAN8RyeE9ZpVaUc9Lcny
         OBho8P6xf/1gfwIEsWX6KRy7vhS1pMXU8q1tP3whCuljMLxGrVGp+zMkgeYn63cdR49W
         IsoOn1nQN291XTRlszSR2XxRKZSdtfcQ3lvgSzMlb1u3SslpL6aaoJm6yJvefTBXr7X5
         dt+3GpdPt8mtVDytxDQOxoLhHMiQ2uvRpEhXrVZI9JloCAnK7yM++AS861M6O/f7H/a9
         ubJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699628521; x=1700233321;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mUJOBd/q/zD8P/9fxYVqe+7Mn835Ht5oRjEbFlzm6ss=;
        b=D9Bbr6JW+Q5YIHE9lCWnBof2lAYY9NQuikNp4XsX44dw0hZ/BvvcFfAQ1zC53f1tn0
         WdMAog52pPv6/9Rp+DTUmbH4Hu6mak+0LOMT4wU8wH0tkNejSqa93/rHAjP7WbEvnqt7
         2VsmIJCeCofE5JotaHqNFgfzHxeTGfqJqH4YQJDzUKgrJN6PXZCGElvugBxi6n719ynz
         5geftM5vbiEJ4Nsz7hs+D4tA0o1JT07Sw5aDIHSMJ3mJT/x+aSAu8cy7Rhcf3LM8uCYU
         YyqnQ9upkW91o94QLZbMNGFkjFE95izajRy+lb0JqZH5xcYv5ut1lf7ZELnEDlTbc2Tr
         Lp4A==
X-Gm-Message-State: AOJu0YxeKhAgJg92rfTqJWRhnkMJCtRH8MsXM9c5t7k1YRu8w7DHSOna
        vMOGimtaLZ3FEPqiqIM0utPDzdXOp1g=
X-Google-Smtp-Source: AGHT+IFHFXmPh2IP8eqRtqbtd5bg1yzaW0Y1DYymt0WnGq/mXyiUB5zukmj7/mdI/J660eypT96mt10mzSY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:896:b0:27d:2945:ad97 with SMTP id
 bj22-20020a17090b089600b0027d2945ad97mr745496pjb.2.1699628521096; Fri, 10 Nov
 2023 07:02:01 -0800 (PST)
Date:   Fri, 10 Nov 2023 07:01:59 -0800
In-Reply-To: <SA1PR11MB6734B37AB5DDCD14A41A6ABBA8AEA@SA1PR11MB6734.namprd11.prod.outlook.com>
Mime-Version: 1.0
References: <20231108183003.5981-1-xin3.li@intel.com> <20231108183003.5981-6-xin3.li@intel.com>
 <ZUyeATu4Fd2xI0+h@chao-email> <ZUz3cPmnqSq7Lol9@google.com> <SA1PR11MB6734B37AB5DDCD14A41A6ABBA8AEA@SA1PR11MB6734.namprd11.prod.outlook.com>
Message-ID: <ZU5F58_KRIHzxrMp@google.com>
Subject: Re: [PATCH v1 05/23] KVM: VMX: Initialize FRED VM entry/exit controls
 in vmcs_config
From:   Sean Christopherson <seanjc@google.com>
To:     Xin3 Li <xin3.li@intel.com>
Cc:     Chao Gao <chao.gao@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
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

On Fri, Nov 10, 2023, Xin3 Li wrote:
> > > >+	if (cpu_feature_enabled(X86_FEATURE_FRED) &&
> > > >+	    !(_vmentry_control & VM_ENTRY_LOAD_IA32_FRED)) {
> > > >+		pr_warn_once("FRED enabled but no VMX VM-Entry
> > LOAD_IA32_FRED control: %x\n",
> > > >+			     _vmentry_control);
> > >
> > > Can we just hide FRED from guests like what KVM does for other
> > > features which have similar dependencies? see vmx_set_cpu_caps().
> > 
> > Both of these warnings should simply be dropped.  The
> > error_on_inconsistent_vmcs_config stuff is for inconsistencies within the allowed
> > VMCS fields.  Having a feature that is supported in bare metal but not virtualized
> > is perfectly legal, if uncommon.
> 
> I deliberately keep it, at least for now, because these checks are helpful
> during the development of nVMX FRED.  It will be helpful for other VMMs
> being developed/tested on KVM.

No, remove it.  It's architecturally legal for a CPU to support a feature in bare
metal but not provide virtualization support.

> > What *is* needed is for KVM to refuse to virtualize FRED if the entry/exit controls
> > aren't consistent.  E.g. if at least one control is present, and at least one
> > control is missing.   I.e. KVM needs a version of vmcs_entry_exit_pairs that can
> > deal with SECONDAY_VM_EXIT controls.
> 
> I agree there are better ways.  But maybe after or before VMX FRED.

Uh, no.  This is not optional.  FRED is the first feature that uses SECONDAY_VM_EXIT
controls, so FRED gets the honor of adding the necessary infrastructure support.

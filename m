Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723B97727C9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjHGOaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbjHGOaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:30:08 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E5C10CF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 07:30:05 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bbbc4ae328so35603385ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 07:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691418605; x=1692023405;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bMdPzG2XrCBcIhVHkWNK3nWK0wLFcxVC5hw4AAEh6/o=;
        b=r+pL34KOKCyCvT1G6ujMdYSsC+crCp5k626T+yQFecWvtFUQ1hf0pqfn3YDsJ/9MCe
         XgoOpSipaVd1TJGBElPgSMYRBZwWMyleJsuAHgioDjuxBzdsQRfw+pWAw14w/98Ebwne
         8rFuc+wzPBMLyeiPXpvIKUNXsn/1a+QC8grStbv8jVZZNhHnvvvDrNZBWRcOYFiK3nxt
         GrDnM8OsLDSVxp3PN9+4FFiuPV+zJf0jR6XmgQzFSAl/M0Nn1aKHZDBHBy32tB+394A3
         VA0ooqPDPOzMGDu1c3/MCB4ECYeeYsf/ZARv6vtUTb0v12spGSddiSTHJ+svdK6g/I7h
         uHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691418605; x=1692023405;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bMdPzG2XrCBcIhVHkWNK3nWK0wLFcxVC5hw4AAEh6/o=;
        b=Fg8RdTP3enz3M+xEbyQnvZg1efNo/Pyqth9RtnOriCh3CX7VyDVMVIIGIxoRy//4mW
         dqMMPif4O6udEMnjnA+c3x/mZ6Sc5EUmCiqjs7b/Tp07OVGFc2rQLmqsq0UI/9VuEpJl
         I/4BiEEpBiIhrad0Y4q8O6q3TKPhAS9BVEhDpsOr17Bec/TAhB/rmZjC5J05kOnDoPR5
         Fpsc5PZiG3FPtmH8Pr8CWVfCZESZAGbC9eXu7C1YJb011nnXPIHMKu49KxeVgTJyADai
         9VX6HYYhWnMSY3uNOz+BkpjhNNdJ8eoOG9Hs7GRTL31FHiKqegE2bOJW6t8U6GBgFY7x
         pigw==
X-Gm-Message-State: AOJu0YzPTLndkIBOYlcWcMqZBfXwsVZxW9qkq+onoOvqPDAyBElIUC3l
        nlmokHdFaJ5LJEwMqXxTo9XGm28JTmk=
X-Google-Smtp-Source: AGHT+IGomqVsnwl3zZAfC62MD1t+0pP4FGydWER6MsEYy/PY4td7kLcqKxXda0j7BcBmIz10jftfPDmWgKo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:244f:b0:1b8:c666:207a with SMTP id
 l15-20020a170903244f00b001b8c666207amr38755pls.9.1691418604729; Mon, 07 Aug
 2023 07:30:04 -0700 (PDT)
Date:   Mon, 7 Aug 2023 07:30:03 -0700
In-Reply-To: <030a485fb852c4604371adc3aeb5511ac6501b88.camel@intel.com>
Mime-Version: 1.0
References: <cover.1690369495.git.kai.huang@intel.com> <b57460d1d12d1f6eac9073cefd6976812b1eef5f.1690369495.git.kai.huang@intel.com>
 <20230806113623.f7am5levfsllpko7@box.shutemov.name> <030a485fb852c4604371adc3aeb5511ac6501b88.camel@intel.com>
Message-ID: <ZND+Cs8roqwnGba4@google.com>
Subject: Re: [PATCH v3 10/12] x86/virt/tdx: Wire up basic SEAMCALL functions
From:   Sean Christopherson <seanjc@google.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>
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

On Mon, Aug 07, 2023, Kai Huang wrote:
> 
> > >  
> > > +config INTEL_TDX_HOST
> > > +	bool "Intel Trust Domain Extensions (TDX) host support"
> > > +	depends on CPU_SUP_INTEL
> > > +	depends on X86_64
> > > +	depends on KVM_INTEL
> > 
> > Hm. I expected KVM_INTEL to depend on CPU_SUP_INTEL, but apparently no.
> > Any reasons why?
> 
> Hmm.. Not sure :-)

Centuar and Zhaoxin CPUs also support VMX.

  commit 8f63aaf5c493c6502a058585cdfa3c71cdf8c44a
  Author: Sean Christopherson <seanjc@google.com>
  Date:   Fri Dec 20 20:45:13 2019 -0800

    KVM: VMX: Allow KVM_INTEL when building for Centaur and/or Zhaoxin CPUs
    
    Change the dependency for KVM_INTEL, i.e. KVM w/ VMX, from Intel CPUs to
    any CPU that supports the IA32_FEAT_CTL MSR and thus VMX functionality.
    This effectively allows building KVM_INTEL for Centaur and Zhaoxin CPUs.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F6E805C60
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjLEQy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbjLEQyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:54:39 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E631713
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:53:50 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1d03cf821e3so26704175ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 08:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701795230; x=1702400030; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XMQYF2quagt/GPGUodoc4MiIW5ZQeF7Y4GziD01rWxY=;
        b=jKUL6Pb2ELt3dBIcP8SfhUzC2eRufsrPX+BPDTaA6tkwYPYCQJEAQHDG11BWQS9xME
         KBaPHlUeak7SGC/WHLeCJ2WRLzgTDsKROnHd2r2O7UxR66/i2tAwB2CiwYo72gOuG0l0
         8kSdblTIhXmsAjNdAXCejlwHNbozSfjUu6VO28TFyl1Oue3+fPMss2cNDsmHBUvSTATO
         YK3T0G+qzrPlnrPIHfnkQtZC4GNHGy0Dzvq536Q9nPqUJC85/R/k0y0fpaib/tS3YlZr
         MHIfI4y/FAFPWOA5CX/enymHMqpEdzur0J8JMl3nZipCYDwgt/Vu8MQaWZu2yuoWI5mZ
         QmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701795230; x=1702400030;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMQYF2quagt/GPGUodoc4MiIW5ZQeF7Y4GziD01rWxY=;
        b=iF28PZ9pRBvmgTRgDSHSHvs9C+M0FjqZgUyxzQe3JmIUmMhhG1B0tzM91uGUBjdnaK
         1mv0/6rEQDufTp0kUQeM+K9b/sEC8Qn1hI7aSvQwBZYX2wkm49iDGnUlUh9QPijmTAC8
         zvloATqFsXif1TW4gOYFZfPWHUkx6xbUypYUnP9dUpTzV8wO78J2cI9541ygFWTR7QK3
         Lc2hbTrqbqFoNMRWU8PG7O3MUhXl1OOzGDLzsej/gIsSEMnUtehTTRVTyq7h6ahnbMw3
         wO1OnGkdlXT3jlUbPy6ggCr4V3+DFy5q7Oeg2NvVQfqd33KS1eIK+O8LeRUJ346HMaOs
         PmWg==
X-Gm-Message-State: AOJu0YyhGMAR4/4cjzXkQZLYfUeg8fv7thCHZYoduJ7ndRmxJPFKuboE
        ItCsiZrnHhAhIMYfbxeALeIFd7lM/fY=
X-Google-Smtp-Source: AGHT+IEkDPF5kg0eFiaPieQqBbhN1nYVZJAxhuI3lfBP6e8BzlpfCIUB7mriD7s7nOD1m+hVQsJUWt4xndE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:8504:b0:1d0:96b7:7f4 with SMTP id
 bj4-20020a170902850400b001d096b707f4mr104464plb.12.1701795229655; Tue, 05 Dec
 2023 08:53:49 -0800 (PST)
Date:   Tue, 5 Dec 2023 08:53:48 -0800
In-Reply-To: <ae972860-cc45-48b0-ba3e-bb2fbad5856a@intel.com>
Mime-Version: 1.0
References: <9e80873fac878aa5d697cbcd4d456d01e1009d1f.1699527082.git.kai.huang@intel.com>
 <b3b265f9-48fa-4574-a925-cbdaaa44a689@intel.com> <afc875ace6f9f955557f5c7e811b3046278e4c51.camel@intel.com>
 <bcff605a-3b8d-4dcc-a5cb-63dab1a74ed4@intel.com> <dfbfe327704f65575219d8b895cf9f55985758da.camel@intel.com>
 <9b221937-42df-4381-b79f-05fb41155f7a@intel.com> <c12073937fcca2c2e72f9964675ef4ac5dddb6fb.camel@intel.com>
 <1a5b18b2-3072-46d9-9d44-38589cb54e40@intel.com> <ZW6FRBnOwYV-UCkY@google.com>
 <ae972860-cc45-48b0-ba3e-bb2fbad5856a@intel.com>
Message-ID: <ZW9VnKLSMGh9PAJy@google.com>
Subject: Re: [PATCH v15 22/23] x86/mce: Improve error log of kernel space TDX
 #MC due to erratum
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kai Huang <kai.huang@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        Chao Gao <chao.gao@intel.com>, Tony Luck <tony.luck@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "sagis@google.com" <sagis@google.com>,
        "imammedo@redhat.com" <imammedo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>, Len Brown <len.brown@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ying Huang <ying.huang@intel.com>,
        Dan J Williams <dan.j.williams@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
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

On Tue, Dec 05, 2023, Dave Hansen wrote:
> On 12/4/23 18:04, Sean Christopherson wrote:
> > Joking aside, why shove TDX module ownership into KVM?  It honestly sounds like
> > a terrible fit, even without the whole TDX-IO mess.  KVM state is largely ephemeral,
> > in the sense that loading and unloading kvm.ko doesn't allocate/free much memory
> > or do all that much initialization or teardown.
> 
> Yeah, you have a good point there.  We really do need some core code to
> manage VMXON/OFF now that there is increased interest outside of
> _purely_ running VMs.
> 
> For the purposes of _this_ patch, I think I'm happy to leave open the
> possibility that SEAMCALL can simply fail due to VMXOFF.  For now, it
> means that we can't attribute #MC's to the PAMT unless a VM is running
> but that seems like a reasonable compromise for the moment.

+1

> Once TDX gains the ability to "pin" VMXON, the added precision here will
> be appreciated.

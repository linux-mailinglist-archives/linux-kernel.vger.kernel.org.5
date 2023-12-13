Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FEB811AD6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379311AbjLMRWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMRWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:22:30 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CFD99
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:22:36 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5c67bf38266so6311259a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702488156; x=1703092956; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ViX/Qqiqk/4TxTiVczHsfkpJiJjwcbO6aH0GOTDDcw=;
        b=sCQ1KzGo1oVcAYIwnwgSkQDwNHzbjcssvfqw1qI34mRibe66RZ4IoL9Z++Z/SJP0K8
         d9JtWO5wq5FcyWeSPbvbaZSXJtEvysW8NvGwfkNg5mXjwLOThzd+nfyYT5k63lxa1PhL
         p0rVga1Wpv2PhRqd5hAEk46N5ksmo5LfOxuWK18Dpl9WE2v8hOTsjSz9riPo6B6Wqtd/
         QeU70OLWrGHppL1/oQSDNrRipHrotzvSaa5R27oXQ3/WcGSQCPZ28wfVQrrxw4pCdIET
         1gMMhIJ+FJsZpP0GXCGsQmKoZkDliEC7Pk5XHdSJh3l0b6xtt+qKLnHJcsOj/fDxYLLz
         +t0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702488156; x=1703092956;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ViX/Qqiqk/4TxTiVczHsfkpJiJjwcbO6aH0GOTDDcw=;
        b=CSX+Mpx2vF7OssbUsbs43yRpL88qNbC6IhXyOEn3tUTbnoXdAW5KjKS8RbyTSYB1Fs
         Cs7LlysFdCpTYHYV3Jzu5AeJVzECi2NdryQ6QG0tNnP7oiPdg7rCxj8NgVo/pqadzt2d
         3kc4gRFqpN3VxBFD+Vn+4xPtcRLDQCqZSxqRC3Elf3JIP3B0JdOjXa4eILw/Kx63mtCx
         dM1D5SBW0Hgb3+LYkCyJiaWckI9jhF0MQhj0S1+BBnbdC5TLK4uDY6eAfuYh6xy8dcb3
         t8bJvttlcrcJN3QJLvHUz2/vhwfknXHfC/mdT+X0raJzfG28S/RwYwTyX4lEeuWzujLJ
         4ByA==
X-Gm-Message-State: AOJu0YxQ0yJi/0t3kccAjwgImzotuKHPPQQ3J4rq1LtCG2WhYWGDzl41
        9NDgNqDQpEpTWhKPeM9mI2nXpL9G6Lg=
X-Google-Smtp-Source: AGHT+IHDC+0wF7yt+7K1uyt/r/lMDTjmVPeporp00WV6ZNCML8y1Mv3AsmJMG9SX/ub7Z9qJkWpnW9vU16Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:51e:b0:5ca:3b18:9ec6 with SMTP id
 bx30-20020a056a02051e00b005ca3b189ec6mr328107pgb.5.1702488156338; Wed, 13 Dec
 2023 09:22:36 -0800 (PST)
Date:   Wed, 13 Dec 2023 09:22:34 -0800
In-Reply-To: <20231211231035.743cesujphsp5eve@box.shutemov.name>
Mime-Version: 1.0
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
 <20231205004510.27164-6-kirill.shutemov@linux.intel.com> <20231211231035.743cesujphsp5eve@box.shutemov.name>
Message-ID: <ZXnoWuaXvRkJjlDK@google.com>
Subject: Re: [PATCHv4 05/14] x86/kvm: Do not try to disable kvmclock if it was
 not enabled
From:   Sean Christopherson <seanjc@google.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>
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

On Tue, Dec 12, 2023, Kirill A. Shutemov wrote:
> On Tue, Dec 05, 2023 at 03:45:01AM +0300, Kirill A. Shutemov wrote:
> > kvm_guest_cpu_offline() tries to disable kvmclock regardless if it is
> > present in the VM. It leads to write to a MSR that doesn't exist on some
> > configurations, namely in TDX guest:
> > 
> > 	unchecked MSR access error: WRMSR to 0x12 (tried to write 0x0000000000000000)
> > 	at rIP: 0xffffffff8110687c (kvmclock_disable+0x1c/0x30)
> > 
> > kvmclock enabling is gated by CLOCKSOURCE and CLOCKSOURCE2 KVM paravirt
> > features.
> > 
> > Do not disable kvmclock if it was not enabled.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Fixes: c02027b5742b ("x86/kvm: Disable kvmclock on all CPUs on shutdown")
> > Reviewed-by: Sean Christopherson <seanjc@google.com>
> > Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Wanpeng Li <wanpengli@tencent.com>
> 
> Paolo, Sean, any chance you can get it in through KVM tree while the rest
> of kexec patchset is pending? The problem is visible on normal reboot too.

Paolo is going to grab this (possibly for 6.7-rc?).  I'll keep this tagged on my
end in case that doesn't happen "soon".

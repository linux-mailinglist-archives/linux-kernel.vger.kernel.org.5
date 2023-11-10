Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1647E806D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345177AbjKJSKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235699AbjKJSIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:08:39 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BA839771
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:42:19 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cc323b2aa3so20735605ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699627339; x=1700232139; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cAE/2qCVfcZ3otx9bQAYIo/PNAUnkqGy0i3eyU52UyE=;
        b=II5SHqo1EDopzChyOeBnGQD0xObsXxXhpDV2JfDt3BOIKIfp5sSabDyKi38x1JPl9n
         SV6XX6gOv7EVpo396O0XUzpNCSJQGJDOtXRSMRFIHIIbfcbLI3/Qg7ahdk+yD5zB4bmx
         JLPf1ofBuXO8r3E7BacC46Z2Xnn1lUgn0sTDn6VIpXSxevJY+O6fy6aRDNpWaNZ200t6
         DSXaqVPCc/3nK7c2UYWIZOIQikJOc2jJtxAhB2hyVJVdFDZbjj/i+IgzEOO02fSPh+zA
         i+EcGA8u/GKDZIcoYq9O0Q6IOl5/LWgkglvM72u49HDXwr9u9iWgo67yQBLMDf3Wk34e
         Tcrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699627339; x=1700232139;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cAE/2qCVfcZ3otx9bQAYIo/PNAUnkqGy0i3eyU52UyE=;
        b=Oze/ekKmHKU5MugO5h9m4wDsLb947wMV0xrMP1r0WqX2HLYLrHk3lm/eQ74CEenhPq
         phrha0jkMj+e0EsOHInsC95q+rPD0OClAkR9nPWVgPRZ5IYjw88gFFND+4VmShyXIGkE
         0b2KXHGAC1I5wbHRo/9ZC4O+rPehkiuXyEsBuyGnD2r58msdJD5430oYPGaSbGyNoavJ
         CkrSWGD+IuugYiQGOctsi1ZRlZf8Jc+xNnvtccvErdmh3sKf4KrZ9HmCNO0jqbKgH0sv
         40awmFaCPCOIGYcvAM+fo2ltKSgz0Iagrlr+QzHrkjTSSJB88S0YQZ5LI1WSyMqh8wY2
         5aOw==
X-Gm-Message-State: AOJu0Yxx7gSJfZdIAwnJ6p5sItm1dVj7pgQ3zgIkB9vzexHRp6ba/WhU
        b9F4ZukUVQ7S/T6fxdhuH35yozZTMf8=
X-Google-Smtp-Source: AGHT+IHUyUglQQ5Iq6YcS3ieW5J3j76629QvUPSMq2rltNnXjeTxzedB/8Bki3safek88Mw4ogVSOLZO7Bk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:efc1:b0:1cc:2bd6:b54a with SMTP id
 ja1-20020a170902efc100b001cc2bd6b54amr1259976plb.10.1699627338829; Fri, 10
 Nov 2023 06:42:18 -0800 (PST)
Date:   Fri, 10 Nov 2023 06:42:17 -0800
In-Reply-To: <202311100209.zIaZqZhg-lkp@intel.com>
Mime-Version: 1.0
References: <70c2a2277f57b804c715c5b4b4aa0b3561ed6a4f.1699383993.git.isaku.yamahata@intel.com>
 <202311100209.zIaZqZhg-lkp@intel.com>
Message-ID: <ZU5BSSg_AbJnec7j@google.com>
Subject: Re: [PATCH 2/2] KVM: X86: Add a capability to configure bus frequency
 for APIC timer
From:   Sean Christopherson <seanjc@google.com>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        isaku.yamahata@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
        erdemaktas@google.com, Vishal Annapurve <vannapurve@google.com>
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

On Fri, Nov 10, 2023, kernel test robot wrote:
> Hi,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on kvm/queue]
> [also build test ERROR on linus/master next-20231109]
> [cannot apply to mst-vhost/linux-next kvm/linux-next v6.6]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/isaku-yamahata-intel-com/KVM-x86-Make-the-hardcoded-APIC-bus-frequency-vm-variable/20231108-032736
> base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
> patch link:    https://lore.kernel.org/r/70c2a2277f57b804c715c5b4b4aa0b3561ed6a4f.1699383993.git.isaku.yamahata%40intel.com
> patch subject: [PATCH 2/2] KVM: X86: Add a capability to configure bus frequency for APIC timer
> config: i386-buildonly-randconfig-002-20231109 (https://download.01.org/0day-ci/archive/20231110/202311100209.zIaZqZhg-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231110/202311100209.zIaZqZhg-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <yujie.liu@intel.com>
> | Closes: https://lore.kernel.org/r/202311100209.zIaZqZhg-lkp@intel.com/
> 
> All errors (this is a 32-bit build, new ones prefixed by >>):
> 
>    ld: arch/x86/kvm/x86.o: in function `kvm_vm_ioctl_enable_cap':
> >> x86.c:(.text+0x1265b): undefined reference to `__udivdi3'

Heh, this inscrutable error is due to 64-bit division on 32-bit kernels.

	u64 bus_frequency = cap->args[0];
	u64 bus_cycle_ns;

	if (!bus_frequency)
		return -EINVAL;

	bus_cycle_ns = 1000000000UL / bus_frequency;  <========

I don't see any reason to allow 64-bit values, e.g. Intel's CPUID 0x15 only
supports a 32-bit frequency in Hz.  I.e. just truncate it to a u32.

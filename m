Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AEB7801E5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 01:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356237AbjHQXo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 19:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356242AbjHQXo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 19:44:29 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A8D35BB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 16:44:27 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1bdcdbc356dso5245525ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 16:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692315867; x=1692920667;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uiZ3s0sLfG2R1/VWg5E95FrDyHVZ3RMPRj5oAvekuRs=;
        b=Fmo8R4pkPRdoFL4utJW8nqPWHAVWkbWVPAlmnJn3GoiseSHYbv6sTNE+4gH7lNPP99
         n9s5eCvsmrqQTveCjACdptLqpslFBwXNKRhk7521DsTPfA757R0I2gK91p6gI3uf0I91
         bfj7GOBoukWUY06npGrJS2uW2Nxk7RK7PEWPx9v6mKZJgfrjCXfw7xGQC9Grz4Dxno6J
         b8kpqOJWmTIbPNletqyxcXWyE4UyqoMYY1CLI9aIUdDlUvnTqZq51u9Nx6LVircrwMK2
         yIA/DAT2OUWVgbjQaqxLoSZ7oV6FR4Y3DfziHql4OsHCYoVSk9t3jiza0jXvU0X72wXV
         lPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692315867; x=1692920667;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uiZ3s0sLfG2R1/VWg5E95FrDyHVZ3RMPRj5oAvekuRs=;
        b=RpU1G08asskOFUQhXNjo7X1wnaM18knjYwnLgtqJp1Euh31KkcBjq0MhU6+OBUIEbU
         /w70cgdbTPOR72fJkM4Kju3u249y+NvZ/bZq21koAuePpy+MtR/NsHreV7j567mPECyY
         iPxohBe+aaNlEurmh8eowlI+Va/TJOXVquuWNZyQCOZcxFqZf9pt/qzj979oqLTqTE07
         oVGthbGOWgN+pFiWAy5yEUl2eAIMIcHyrKsWv7V6y7k/UqgBnc2a94wLBA57XwdeHIUr
         bi5g4yF9V05aKZCYSJGDoxI9FAuLvvb0K3SoK49Lyucyl4RhFbBMskLAknStTbd4gdmw
         1iQg==
X-Gm-Message-State: AOJu0YzY99q2OJZHt3kyk7pfNYj56vx9fI4uIQ6McF0DoK6rAv+M2Ary
        gZ6EKjFfYn8GH3ZcO1qy9G0CY+SsWtg=
X-Google-Smtp-Source: AGHT+IGqqd5eTGmvyGRQXhnh/Ml15OLNi7xclCEoJ1Pnpf0vLIITNizhmWmgRClWEivg/tn7Eddiyl5UKyQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:eccd:b0:1b8:5878:7871 with SMTP id
 a13-20020a170902eccd00b001b858787871mr340740plh.13.1692315867232; Thu, 17 Aug
 2023 16:44:27 -0700 (PDT)
Date:   Thu, 17 Aug 2023 16:44:25 -0700
In-Reply-To: <MW5PR84MB17135D3B5BC50FCFD3D9DEEE9B1AA@MW5PR84MB1713.NAMPRD84.PROD.OUTLOOK.COM>
Mime-Version: 1.0
References: <20230815153537.113861-1-kyle.meyer@hpe.com> <ZNuxtU7kxnv1L88H@google.com>
 <MW5PR84MB17135D3B5BC50FCFD3D9DEEE9B1AA@MW5PR84MB1713.NAMPRD84.PROD.OUTLOOK.COM>
Message-ID: <ZN6w2SxyZMKKxtb/@google.com>
Subject: Re: [PATCH] KVM: x86: Increase KVM_MAX_VCPUS to 4096
From:   Sean Christopherson <seanjc@google.com>
To:     Kyle Meyer <kyle.meyer@hpe.com>
Cc:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hasen@linux.intel.com" <dave.hasen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "dmatlack@google.com" <dmatlack@google.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023, Kyle Meyer wrote:
> > > 4096 is the current maximum value because of the Hyper-V TLFS. See
> > > BUILD_BUG_ON in arch/x86/kvm/hyperv.c, commit 79661c3, and Vitaly's
> > > comment on https://lore.kernel.org/all/87r136shcc.fsf@redhat.com.
> >
> > Mostly out of curiosity, do you care about Hyper-V support?   If not, at some
> > point it'd probably be worth exploring a CONFIG_KVM_HYPERV option to allow
> > disabling KVM's Hyper-V support at compile time so that we're not bound by the
> > restrictions of the TLFS.
> 
> Yes, I care about Hyper-V support. I would like this limitation to be addressed
> in the future.
> 
> > Rather than tightly couple this to MAXSMP, what if we add a Kconfig?  I know of
> > at least one scenario, SVM's AVIC/x2AVIC, where it would be desirable to configure
> > KVM to a much smaller maximum.  The biggest downside I can think of is that KVM
> > selftests would need to be updated (they assume the max is >=512), and some of the
> > tests might be completely invalid if KVM_MAX_VCPUS is too low (<256?).
> 
> That sounds good to me. I would prefer to set the range from 1024 to 4096 in
> this patch.

Yeah, that's probably for the best. 

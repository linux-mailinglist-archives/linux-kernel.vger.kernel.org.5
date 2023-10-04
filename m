Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00CE7B75A2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 02:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238320AbjJDAH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 20:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjJDAH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 20:07:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8C29B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 17:07:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d81a47e12b5so2233282276.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 17:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696378044; x=1696982844; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SCChu475pVfip1pDwbHdwIY6LAU4+An6h8yh5xS6rAg=;
        b=VVNP/7yZCsM/EykEitOpJlpp+N5Ini1lWSwWuwk15sX3mRnxDwEA26zA7dtE3TXZ9o
         nCTK3RkO4YF80P0qsGKnUVBYyvDJEBjuraQeeNx6JyN1MHqJkhs/e2kRarX6jDD+XKzQ
         4+R9ZpGsRi51BEKgbe1q07bFno+RH8eNZzdMKSf70eS6JAWMnUKW1q9z75UpnYbztDju
         8kMMjoeS+CDhbNJy36AoSfKXMFbT0XgR7+EBmpSQto8BGuQfhAmSDjTNnT+2fbhC7KSo
         kyCiGkUuOK9Y1h8glyNpDUUs1u0wU03mPBP6fAyYdaWQYvI0AvgveKgtEzG/ynsCIHLK
         xNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696378044; x=1696982844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SCChu475pVfip1pDwbHdwIY6LAU4+An6h8yh5xS6rAg=;
        b=UUP79HrTfXy6M7DjoFCQKA9gOrgnQU69sn6HiucPezbXpJN2YtgH8SuRRRpjYShS0U
         Mg12pc3iPyL2qP+qBbEWbKoag0jF7111IL/Uc9lbIWqc+dlBBfVDFsm7LommzPpgvawE
         PNDAiO9MDFvTXXrrkvQ4Gfd6Tj711CmvyZyaTz5aC6P8stAy4vNYUcEdZbMoQFt6wz9u
         tiNJnwZX45+ERWkBs2lVtac3KDiim+hAfvWcVRGs07OUSqdptqmIlaT6dPYLQHgTLzPA
         wb9umqcd6ZOxYxw6UNcpKisaFz9kibU1lQ5bUqt99bh8ZXv/mFId4gYq7YC/eqR1HwB/
         GHhg==
X-Gm-Message-State: AOJu0YxER00EZmyAWi7e9zl5wWW9jUWWfRB+uscPEvwfiI22DXoH6r9a
        F9d0+tZiQhVUKitIvi0Rk3TLbUR086c=
X-Google-Smtp-Source: AGHT+IHWqwohiZzAYIiaKuBWJwJPUegXuR0C9YUMouuDN4wbx3kmV3iNhJdEzxVPEMO2JlX2mIfMnQsEbu0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:13cc:b0:d91:8876:2040 with SMTP id
 y12-20020a05690213cc00b00d9188762040mr11869ybu.5.1696378044229; Tue, 03 Oct
 2023 17:07:24 -0700 (PDT)
Date:   Tue, 3 Oct 2023 17:07:22 -0700
In-Reply-To: <20EAA3C4-A9F4-4EC1-AE0C-D540CC2E024A@infradead.org>
Mime-Version: 1.0
References: <20230926230649.67852-1-dongli.zhang@oracle.com>
 <377d9706-cc10-dfb8-5326-96c83c47338d@oracle.com> <36f3dbb1-61d7-e90a-02cf-9f151a1a3d35@oracle.com>
 <ZRWnVDMKNezAzr2m@google.com> <a461bf3f-c17e-9c3f-56aa-726225e8391d@oracle.com>
 <884aa233ef46d5209b2d1c92ce992f50a76bd656.camel@infradead.org>
 <ZRrxtagy7vJO5tgU@google.com> <52a3cea2084482fc67e35a0bf37453f84dcd6297.camel@infradead.org>
 <ZRtl94_rIif3GRpu@google.com> <20EAA3C4-A9F4-4EC1-AE0C-D540CC2E024A@infradead.org>
Message-ID: <ZRysuu8YJg0cLCt4@google.com>
Subject: Re: [PATCH RFC 1/1] KVM: x86: add param to update master clock periodically
From:   Sean Christopherson <seanjc@google.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Dongli Zhang <dongli.zhang@oracle.com>,
        Joe Jin <joe.jin@oracle.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com
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

On Tue, Oct 03, 2023, David Woodhouse wrote:
> 
> 
> On 3 October 2023 01:53:11 BST, Sean Christopherson <seanjc@google.com> wrote:
> >I think there is still use for synchronizing with the host's view of time, e.g.
> >to deal with lost time across host suspend+resume.
> >
> >So I don't think we can completely sever KVM's paravirt clocks from host time,
> >at least not without harming use cases that rely on the host's view to keep
> >accurate time.  And honestly at that point, the right answer would be to stop
> >advertising paravirt clocks entirely.
> >
> >But I do think we can address the issues that Dongli and David are obversing
> >where guest time drifts even though the host kernel's base time hasn't changed.
> >If I've pieced everything together correctly, the drift can be eliminated simply
> >by using the paravirt clock algorithm when converting the delta from the raw TSC
> >to nanoseconds.
> >
> >This is *very* lightly tested, as in it compiles and doesn't explode, but that's
> >about all I've tested.
> 
> Hm, I don't think I like this.

Yeah, I don't like it either.  I'll respond to your other mail with details, but
this is a dead end anything.

> You're making get_monotonic_raw() not *actually* return the monotonic_raw
> clock, but basically return the kvmclock instead? And why? So that when KVM
> attempts to synchronize the kvmclock to the monotonic_raw clock, it gets
> tricked into actually synchronizing the kvmclock to *itself*?
> 
> If you get this right, don't we have a fairly complex piece of code that has
> precisely *no* effect? 
> 
> Can't we just *refrain* from synchronizing the kvmclock to *anything*, in the
> CONSTANT_TSC case? Why do we do that anyway?
> 
> (Suspend/resume, live update and live migration are different. In *those*
> cases we may need to preserve both the guest TSC and kvmclock based on either
> the host TSC or CLOCK_TAI. But that's different.)

The issue is that the timekeeping code doesn't provide a notification mechanism
to *just* get updates for things like suspend/reume.  We could maybe do something
in KVM like unregister the notifier if the TSC is constant, and manually refresh
on suspend/resume.  But that's pretty gross too, and I'd definitely be concerned
that we missed something.

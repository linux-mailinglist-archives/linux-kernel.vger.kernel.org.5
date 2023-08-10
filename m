Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF027777C6F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbjHJPlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbjHJPlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:41:18 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427D826B9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:41:17 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5868992ddd4so14629257b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691682076; x=1692286876;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/WtGf0h5CncOSaqTiuNKL5UrEMZuYNWdm8HHY3JpqR8=;
        b=1HM/o9GT5W6xPOOgpHKfzvvpV7lU0Wj1rCnCqdJbNn47dXUhb/wMa+aEfE4YXy2OiD
         0P/FUbU8WDKqdvLRTEGvGaU/5i0jsp875zfL6WgkM9CPKn7jCyjjkF2DgTrnat008Dhd
         rjJxiF0G53UGr1ukFDPPHiRVDJPx6VzOva54SgjGxd7FxZJCCCQFhMrpre3c9ethg+iR
         0e1kVeWrSzsKkAvTgG26kjiLHCxCaOYC0gO50qMivRiPTYe/SI6lUvAJ+pGpSooaXKzI
         OPVmnL4Q3n/ISA/xp5hnWdtjbrV1Z61MQpPb+am3DxnaS2wu+HB1MEuN+BnSoTSDhY3Y
         sJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691682076; x=1692286876;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/WtGf0h5CncOSaqTiuNKL5UrEMZuYNWdm8HHY3JpqR8=;
        b=WC1DelPIEQgGeoWYRa/8dBih4OoYl8gw1P+TxxhIRgeZQ4V4F1CM4fThmjFchsIrE9
         dBYOzIKPyP37HDgcoxWgTRj16HyJgNW6KOVHjbVbBa8JGrYXT4H1Vkvz7AREbFKKqL/q
         ztJp8uj635J7ZNSiAsgCpHJP2UvmGNFoe3HwmHwcITAEP5HKzttuQ33A4YchVDIn1IUB
         RPgABAMSGLrjXWzLEhXgfsiE+0Y+OSN6f6hEB2ipr7zQv7LmAww+Xsv+dh8wqEADhRzo
         TB6vJyzHWzXT0PO6hL+ePHljVOlqVb2MZ1WHVEIpBRKioe+uHq1P4n5n8DNUFiHB6vRX
         /a/A==
X-Gm-Message-State: AOJu0YwUxmoTRWnjO+EDfwL31vmysDlQhz+3gF6geQC8e5xKXeek0nXI
        NOGx4R4cPSjepBVEQgMwBjBTapxpYdU=
X-Google-Smtp-Source: AGHT+IG2a4LzCzXKIUuYBIJcR0ffZM366KAOS5FFEkMlfjQF/GkGNK5iXWe5lXEZxANQwLfExUrLpLQ5PWM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:160d:b0:d4d:deb:7ce0 with SMTP id
 bw13-20020a056902160d00b00d4d0deb7ce0mr52915ybb.13.1691682076565; Thu, 10 Aug
 2023 08:41:16 -0700 (PDT)
Date:   Thu, 10 Aug 2023 08:41:14 -0700
In-Reply-To: <ZNRTO0hY8GJBrnOg@yzhao56-desk.sh.intel.com>
Mime-Version: 1.0
References: <20221223005739.1295925-1-seanjc@google.com> <20221223005739.1295925-20-seanjc@google.com>
 <5581418b-2e1c-6011-f0a4-580df7e00b44@gmail.com> <ZNEni2XZuwiPgqaC@google.com>
 <ZNLlseYag5DniUg3@yzhao56-desk.sh.intel.com> <ZNOjyf2OHQZYfMEJ@google.com>
 <ZNQfX4JHTJu1Qtl0@yzhao56-desk.sh.intel.com> <ZNRTO0hY8GJBrnOg@yzhao56-desk.sh.intel.com>
Message-ID: <ZNUFGljM5oet11xN@google.com>
Subject: Re: [PATCH 19/27] KVM: x86/mmu: Use page-track notifiers iff there
 are external users
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     Like Xu <like.xu.linux@gmail.com>, kvm@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Ben Gardon <bgardon@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        intel-gvt-dev@lists.freedesktop.org,
        Zhi Wang <zhi.a.wang@intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023, Yan Zhao wrote:
> On Thu, Aug 10, 2023 at 07:21:03AM +0800, Yan Zhao wrote:
> > > Reading the value after acquiring mmu_lock ensures that both vCPUs will see whatever
> > > value "loses" the race, i.e. whatever written value is processed second ('Y' in the
> > > above sequence).
> > I suspect that vCPU0 may still generate a wrong SPTE if vCPU1 wrote 4
> > bytes while vCPU0 wrote 8 bytes, though the chances are very low.
> > 
> This could happen in below sequence:
> vCPU0 updates a PTE to AABBCCDD;
> vCPU1 updates a PTE to EEFFGGHH in two writes.
> (each character stands for a byte)
> 
> vCPU0                  vCPU1   
> write AABBCCDD
>                        write GGHH
>                        detect 4 bytes write and hold on sync
> sync SPTE w/ AABBGGHH
>                        write EEFF
>                        sync SPTE w/ EEFFGGHH
> 
> 
> Do you think it worth below serialization work?

No, because I don't see any KVM bugs with the above sequence.  If the guest doesn't
ensure *all* writes from vCPU0 and vCPU1 are fully serialized, then it is completely
legal for hardware (KVM in this case) to consume AABBGGHH as a PTE.  The only thing
the guest shouldn't see is EEFFCCDD, but I don't see how that can happen.

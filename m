Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93507B379A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 18:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbjI2QOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 12:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbjI2QOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 12:14:20 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55031A8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 09:14:16 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1c6181dacf6so130381135ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 09:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696004056; x=1696608856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5skWGmr/3S1EV5oU9piDC1flXM6/+tWSaNvDFeT87cs=;
        b=3mkn182tRGksSm6zMIS+x6jKBVhNk8Kts8GUP3N4/WPclHGGIdl9ouyJqKiLRk8pSI
         5Od6j6ADp8KGqrRUzIiPADgCY++33tQqAvZ0Y4mG1A7gUHZK4OEFUOMq54sI8n1F0uYs
         calKd8htswKHWnkUdQ4qXs3h3HwxYgI09XUk457VBg0rPwi+5yCTBl1MXsIBH0wzdqqY
         00Jys8fdEuISuLrdO92feX+p2Z4B7D2id76E2JJcOtFwhcLAe3L2GXJNgms8/Rg9g9lQ
         7OQSKLKfvekHkW/0qNF4BV4ABUAxkiu+4eUCKPJTayr1+ei8cmGPJUcs4YBa0jE5X8T7
         fJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696004056; x=1696608856;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5skWGmr/3S1EV5oU9piDC1flXM6/+tWSaNvDFeT87cs=;
        b=vHo7ZAMUuB1+StB2j6TtdAugn5PVc/ZrMbD7ucNd3Y9GSLaWRWFUbksM1zExnW1fuX
         LuBJICPcWoxNqYedXMxfvbwEiU3r/JNv9e5Ns8grTt2NZRd+IZbFerTIhH5njNPMogYW
         Xumi3ygYT52MbXtvXni9gDk2OnlsAmh4NkD3JLHrlExKZ5oUlgnKM2m/gaZwQ8joeImc
         SoSO7LmE2XCUv6Qhw74glUHQl23i2FSktip2n+Qjjd5B9pBJwn4c+d9FhXmoUKR/AL4h
         A+oPn7CJmyDSvd4PqQHTUVeDUeL20IfjO3i6tpt7SS86vD3OoXEUJJMyoiXPwvneZEpN
         7Z+g==
X-Gm-Message-State: AOJu0YxBaEB6XhOUktsS9ywxhe5fb7P59LvXYuMuFCkx6Mds5BA2UM/G
        BmFeJLQqec3BdAdNGBHaMG8WiNVhVyI=
X-Google-Smtp-Source: AGHT+IFzcDalr71n1wHlD/rSAKgxUeg4VzqSEk5yK/ggS/ezOgq1OafMiKP9KvlxVQ7MgNGrRGTBuZzzwlg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ce8a:b0:1c7:2294:cac4 with SMTP id
 f10-20020a170902ce8a00b001c72294cac4mr69378plg.13.1696004056192; Fri, 29 Sep
 2023 09:14:16 -0700 (PDT)
Date:   Fri, 29 Sep 2023 09:14:14 -0700
In-Reply-To: <6bc63f82495501f9664b7d19bd8c7ba64329d37b.camel@redhat.com>
Mime-Version: 1.0
References: <20230928162959.1514661-1-pbonzini@redhat.com> <20230928162959.1514661-3-pbonzini@redhat.com>
 <6bc63f82495501f9664b7d19bd8c7ba64329d37b.camel@redhat.com>
Message-ID: <ZRb31g0PBR588XwK@google.com>
Subject: Re: [PATCH 2/3] KVM: x86/mmu: remove unnecessary "bool shared"
 argument from iterators
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023, Maxim Levitsky wrote:
> =D0=A3 =D1=87=D1=82, 2023-09-28 =D1=83 12:29 -0400, Paolo Bonzini =D0=BF=
=D0=B8=D1=88=D0=B5:
> > The "bool shared" argument is more or less unnecessary in the
> > for_each_*_tdp_mmu_root_yield_safe() macros.  Many users check for
> > the lock before calling it; all of them either call small functions
> > that do the check, or end up calling tdp_mmu_set_spte_atomic() and
> > tdp_mmu_iter_set_spte().  Add a few assertions to make up for the
> > lost check in for_each_*_tdp_mmu_root_yield_safe(), but even this
> > is probably overkill and mostly for documentation reasons.
>=20
> Why not to leave the 'kvm_lockdep_assert_mmu_lock_held' but drop the shar=
ed
> argument from it?  and then use lockdep_assert_held. If I am not mistaken=
,
> lockdep_assert_held should assert if the lock is held for read or write.

+1, I don't see any downside to asserting that mmu_lock is held when iterat=
ing.

It'll be a redundant assertion 99% of the time, but it's not like performan=
ce
matters all that much when running with lockdep enabled.  And I find lockde=
p
assertions to be wonderful documentation.

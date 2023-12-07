Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07968808DD9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjLGQbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443321AbjLGQbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:31:05 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252E912D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 08:31:12 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5c5daf2baccso11297647b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 08:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701966671; x=1702571471; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5rIP8xiIeStLAZxAKenikHJEOOwixpMvqcR8yCub0Xc=;
        b=sMxnsD/8UW1venRLzWrYQDXljCWKOCPybe/VCyNmXLC+x8UoRUbe/CX+BfK2BfLY1G
         eKqP3ZyzwFKeDKLM7oZldXIAUOB/zetvlFY/tz9GT5RuRpLTLxljXxrR0vmGL+PX7uuM
         +krG91QILeNdcNNl6MQ2VC92N9PePPlnVNwV9g11dicgZb2moOh7rUedpg+qXQLkAPy1
         5Fvz+4Ug6MRqU2FDMUcf0459sQDtVJeuSDpFxHfWaYClMXAwcBxXI54u0zGubc5luK1m
         Ye9J3cRNnOhQNWSW6RY3G/aOovyumE8hmy33WY8yYfNX2gsuRrt3HrMe7PFqHmJQPlZX
         k+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701966671; x=1702571471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rIP8xiIeStLAZxAKenikHJEOOwixpMvqcR8yCub0Xc=;
        b=LJJcUkrXBJI/aJBHB3QSOWdQntx7bDWI9LCuYOJZe5advf1Kf/MzU0ahA5ZW6Hneq9
         RMdEJygdtpLJDFbf+VqUSIrjFGp4yXmTBFeVmMYpIDNFoTs7Cb67aEkbsGSb5iQgTS29
         paTiZNSGbjUxoL+fTAZX7i6C7nXdgYNSyb0ThnTOyHhZ4aWcEcWGBQXGh+pZfdk48IlL
         QhVvlkd9PuvDtO6uAzmeZJ3gl6gPKNtH5/qzWpc1KsAEBhf/p4ecETyyp8ZX4iWl420Z
         OaQpPOQ0pytVr6tk1AnRCkH3ii3fhX3pR6DtJO5UlBhcSqv2EeP2EkDiPv2uRp+LW5e3
         nNPw==
X-Gm-Message-State: AOJu0YzV0+9dNMCjpoItDZl/VQ+qE3mRphnirmXZB+BeLiV1UPpj69+8
        K5F5aYq+/YIuVRkC4KRIKK8pWU58kpw=
X-Google-Smtp-Source: AGHT+IEh9Rr8D8QQlvOmctOaR9hVclvbUIw+QMeJkaeNbeH5dAiquzhAL9U2TiuYPw8pniVHDfDH/0NQKc8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:cc44:0:b0:d9a:e3d9:99bd with SMTP id
 l65-20020a25cc44000000b00d9ae3d999bdmr35659ybf.5.1701966671331; Thu, 07 Dec
 2023 08:31:11 -0800 (PST)
Date:   Thu, 7 Dec 2023 08:31:09 -0800
In-Reply-To: <6cd419ff-97d9-495b-bc9c-0c53c4b1e3d1@gmail.com>
Mime-Version: 1.0
References: <20231206032054.55070-1-likexu@tencent.com> <ZXCTppx4II1sbRAl@google.com>
 <6cd419ff-97d9-495b-bc9c-0c53c4b1e3d1@gmail.com>
Message-ID: <ZXHzTaZU1TY_HEVC@google.com>
Subject: Re: [PATCH v2] KVM: x86/intr: Explicitly check NMI from guest to
 eliminate false positives
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Dec 07, 2023, Like Xu wrote:
> On 6/12/2023 11:30 pm, Sean Christopherson wrote:
> > Please don't make up random prefixes.  This should really be "x86/pmu".
> 
> Thanks.
> 
> I'm hesitant to categorize about NMI handling into kvm/pmu scope.

Why?  Literally the only thing this can affect is PMU behavior.  Even if there's
a bug that affects the kernel's PMU, that's still x86/pmu as far as KVM is
concerned.

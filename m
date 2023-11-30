Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E987FE65C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344108AbjK3Bo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344112AbjK3Bo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:44:27 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B8E10FA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 17:44:32 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d04540d5aaso7124507b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 17:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701308671; x=1701913471; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lIh510cpMHfh3TBI1frcYo4YiRPmPneVHA94hyn0mXc=;
        b=reudPNSdD+Y5u+i1xfvLIpmXjjjpu0mXb7sUbxg1gab/NxtdH8s+aLXp4IMr+QAPdw
         jOV7HjwoY/bGWO/DHZ6WE2f93CySxGq9JHn9kwMMZSOqZBOlTzp9rpBW57uAq5B2jtal
         z4Hr+CXinBclqFwP6XiFPKaTeFzuu2sz635Qb35+1S7hl+f+AOKxL6mdtGZrAj5h4kEc
         xW+lW0f16GDcYqmDPm+9rMjGjWIJb1+SejsiWj0KepMiUyUps3tcrWBETCugBrAePsHN
         c1dD6Zdg2N8DzaJjqAoPzhJQSZVg4+En6vGoBY/zO78el7eNVK1VqgqI8feqUDJp1IGx
         h1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701308671; x=1701913471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lIh510cpMHfh3TBI1frcYo4YiRPmPneVHA94hyn0mXc=;
        b=E6NQgL/T00Kbvh6OAFWAbYMIFFWDr71LWPMLMEu0R2rNwfmeWRD/bY28C4TpMyjZxL
         Ls0Mp2kisCIsGEAhsWQQ6YpbPLFNOKOCusv5Px6KNYnnG8ury5MM0xEGgNzRB43PSl25
         efBWp4yfG9NCcZPlAkDHdyJGJ1PCcH8lX/OEaGD7ubEK36S3HQDX99kNVDg+AbcUNbLD
         DObweBaoGUeVCxjb+Bh0YL8PjZQGrimd86i+uv3gbFJmox+OOgekPrvPYu/1ukZy1JFN
         IAlBiYg+Kz7Feiw4W7gcIY4S57zYqy0h9Bn45TaL4/cKtSUWJNqYAC7NPENMiW/BCr0D
         8fgg==
X-Gm-Message-State: AOJu0YwzQFkSC1enOmeFmIORcJrM2aWfH3hluZ7wTKPgygQEFKGRK0+B
        g5RNfljhN2sKpJXZZ8LyZ2oYU0ULdKY=
X-Google-Smtp-Source: AGHT+IF0+6CDCMesMb0RO3PcrV94LZtjPZHEQAI+diEFrXVS+tB63G2kCA++hrLRPuC3DQA7tBO4x6A+Kg8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:2c05:b0:5bf:5b75:ff91 with SMTP id
 eo5-20020a05690c2c0500b005bf5b75ff91mr525978ywb.4.1701308671263; Wed, 29 Nov
 2023 17:44:31 -0800 (PST)
Date:   Wed, 29 Nov 2023 17:44:11 -0800
In-Reply-To: <20230815220030.560372-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230815220030.560372-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <170129841796.533238.1884968868194664460.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: Remove x86's so called "MMIO warning" test
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Luczaj <mhal@rbox.co>
Content-Type: text/plain; charset="utf-8"
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

On Tue, 15 Aug 2023 15:00:30 -0700, Sean Christopherson wrote:
> Remove x86's mmio_warning_test, as it is unnecessarily complex (there's no
> reason to fork, spawn threads, initialize srand(), etc..), unnecessarily
> restrictive (triggering triple fault is not unique to Intel CPUs without
> unrestricted guest), and provides no meaningful coverage beyond what
> basic fuzzing can achieve (running a vCPU with garbage is fuzzing's bread
> and butter).
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Remove x86's so called "MMIO warning" test
      https://github.com/kvm-x86/linux/commit/e29f5d0c3c7c

--
https://github.com/kvm-x86/linux/tree/next

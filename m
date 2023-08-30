Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BD978D0ED
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 02:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241370AbjH3AHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 20:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241372AbjH3AGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 20:06:49 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A801BD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 17:06:45 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-56fb25e0c0dso5304567a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 17:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693354005; x=1693958805; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=mmVAJQqEiiaP0dT7KUePJgnR8yOxVh+XkfAGxrkTx5I=;
        b=Vo74GgObXpti+PQ4RRyXWvADA87UxepQn/8ppyZup2oZGk0FIyJw4yjwCv6oy/IPtK
         DAwPl+OF8yJCpk/dhvVo3VSF/shPpnsXa0oyoqYB0BdgkgifU53CuO5ZK/9aFAtPzl4Y
         wosw4Gie4H25WOzJt3RTO/mmdzuKH0QxQW33KFsjX2UpAvYOeYXq4IJhtxhnKpP/GSNh
         Is9J7+KNBlwjH0uuJh1dpEDujfAV9g9SeL9L9gbukgSbhEFBKtYUL+8CIzGHxUULh3C8
         V4OorVZwJMp+UxhMMEXKZqxjox6zxXZpE9rV4gFxPsVQJsEDTFczL248s6HL4fjL0k4c
         3Hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693354005; x=1693958805;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mmVAJQqEiiaP0dT7KUePJgnR8yOxVh+XkfAGxrkTx5I=;
        b=InkAODBR7kubxwkgTUIjBF2Irx8a6SPSNbHQ5YCoB5zmiLNJkRvxoixnSD/AxK6WmX
         Ln5cErjD/LcqkD0QqeIhBM/LpXXewFFFOYRpsY6R1TTqkNzaZyZYtcycaFq0OcmkLsvs
         cKNCwEWLbhzgrAt6QODkLFnw9OAKSJJEk+U8pJMw/ORgHbSeZSqffjT4A0pUpH2ZGHl1
         AzEPUWp1NGCJWQGY9/kEkiEei5H+HFD4/WUqKfWm3BJDzkW6B/9dXo09NMk2bP2pP4A4
         6FaZSFUKWeaFGVkuhphzKX/6wsjM+FFNpQFXlrjPy0bifxG3gnA9mh4zPedYIcEMhXj6
         UmjQ==
X-Gm-Message-State: AOJu0YwMoPIAxDy2Bnvk3/4m43P3e7w2lLdyq8SrTfP6nX2Jv9L71f4Q
        T2WFmkCqDc0hb9gijg3JAPiNejF73Rc=
X-Google-Smtp-Source: AGHT+IFNS0f5HHkcJY/0cdZRk0qDcQ8bJT3ohNST4etWqbnqeYUDD1mvHT4phfX1t13/QaYk9etYLsU/QQY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:3c54:0:b0:564:cfab:5648 with SMTP id
 i20-20020a633c54000000b00564cfab5648mr87472pgn.3.1693354005257; Tue, 29 Aug
 2023 17:06:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 29 Aug 2023 17:06:30 -0700
In-Reply-To: <20230830000633.3158416-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230830000633.3158416-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230830000633.3158416-5-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: PMU changes for 6.6
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull a light round of PMU changes for 6.6.  Basically just a single
cleanup.  Note, there's a counter truncation fix that I have been neglecting
for a few weeks[*], I'm planning on getting back to that after the merge window.

[*] https://lore.kernel.org/all/20230504120042.785651-1-rkagan@amazon.de

The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-pmu-6.6

for you to fetch changes up to 6de2ccc169683bf81feba163834dae7cdebdd826:

  KVM: x86/pmu: Move .hw_event_available() check out of PMC filter helper (2023-08-02 16:44:36 -0700)

----------------------------------------------------------------
KVM x86 PMU changes for 6.6:

 - Clean up KVM's handling of Intel architectural events

----------------------------------------------------------------
Sean Christopherson (4):
      KVM: x86/pmu: Use enums instead of hardcoded magic for arch event indices
      KVM: x86/pmu: Simplify intel_hw_event_available()
      KVM: x86/pmu: Require nr fixed_pmc_events to match nr max fixed counters
      KVM: x86/pmu: Move .hw_event_available() check out of PMC filter helper

 arch/x86/kvm/pmu.c           |  4 +--
 arch/x86/kvm/vmx/pmu_intel.c | 81 ++++++++++++++++++++++++++++++--------------
 2 files changed, 56 insertions(+), 29 deletions(-)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38168123C8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 01:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442843AbjLNASK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 19:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbjLNASJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 19:18:09 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288ACDD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:18:11 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5ca26c07848so86948607b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702513090; x=1703117890; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1T9KSqGwtMQv1hbNnbP8po9bAmmjqCZKAuvRphoWag=;
        b=QljGPwke04rTAIDpxA57e8MCTdWrGyzqMN/uqmv2hZx8HqDwpbYHRybX+f18RbsG0m
         wd46C0oeTmjRT0KGmlGl8vQru/PWK00dHimIU0rkzCCxEK6AWlN1Rrwc/AYT9Rrf05hL
         DYCimFEUTIfM1zXFoR5iaif/zz2CQueikYCxqK3f64Bsl4vDcTjmRRYOXcvMvbfrF2IR
         tF+JMMDOZIb+GTXqBdovPbPMU/n+YoFhcCwsVZTP9IDxmS6xAzHEc/UP/OivMuYvr4Q7
         gYROy4S0EPdxF2Tx3Xgtm0oFh3xixDocyzYEvydTa8YJ/OwozzjiJgqGB+elC21I+El1
         lqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702513090; x=1703117890;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a1T9KSqGwtMQv1hbNnbP8po9bAmmjqCZKAuvRphoWag=;
        b=WKhZgbseeAWyoQRNR3Vq79DxZ3VWrOWrfcoHSix/VDGNas8zb7BWDJ2SWYOAIu0d8C
         qw3U2uSI8KhbSkw+urTI2QcpujbJOYZf+itac3pNEgu6FWZc0Zahb/eS70Fm+owZstrg
         E4jYMJjDZVSjMr8sRlJ+yFOh1WW9wgIcNZvRf9vvZJeS9pzOqUSQNzP5aN1fc134Qc0j
         gWQ2Fg2mFNM4y5pAJJzGeZAAt9rLgSO2esyp4+DtVYAHauOBWGqJ++MnVR6lvqyjB8Ku
         KPmN5WPieliswbN2NGT8hDtiaJ6/Ol4yXX3+zOstGo1jkUx7CxLTp7zweO6/LJpYJdKM
         2UyA==
X-Gm-Message-State: AOJu0YyTa8Vt4Qox1bmTUWEQCQuT8g7G9MYt1JNeXX14m1ApZ0FJ4N43
        pqwV3vLb8diFkjVEy3A3+Uc0iLmltNA=
X-Google-Smtp-Source: AGHT+IFmk5v2l4+Tqax5+3GuiZuNT+GmYDfAm4pBLEOyYVVFFdfKEC01FLTLs+5lL7EdyQE6E4BpTfIGm7U=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:b84f:0:b0:dbc:1b46:9aeb with SMTP id
 b15-20020a25b84f000000b00dbc1b469aebmr71552ybm.2.1702513090354; Wed, 13 Dec
 2023 16:18:10 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 13 Dec 2023 16:17:53 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214001753.779022-1-seanjc@google.com>
Subject: [ANNOUNCE / RFC] PUCK Future Topics
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Peter Xu <peterx@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Isaku Yamahata <isaku.yamahata@linux.intel.com>,
        David Matlack <dmatlack@google.com>,
        Yan Zhao <yan.y.zhao@intel.com>, Marc Zyngier <maz@kernel.org>,
        Michael Roth <michael.roth@amd.com>,
        Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!  There are a handful of PUCK topics that I want to get scheduled, and
would like your help/input in confirming attendance to ensure we reach critical
mass.

If you are on the Cc, please confirm that you are willing and able to attend
PUCK on the proposed/tentative date for any topics tagged with your name.  Or
if you simply don't want to attend, I suppose that's a valid answer too. :-)

If you are not on the Cc but want to ensure that you can be present for a given
topic, please speak up asap if you have a conflict.  I will do my best to
accomodate everyone's schedules, and the more warning I get the easier that will
be.

Note, the proposed schedule is largely arbitrary, I am not wedded to any
particular order.  The only known conflict at this time is the guest_memfd()
post-copy discussion can't land on Jan 10th.

Thanks!


2024.01.03 - Post-copy for guest_memfd()
    Needs: David M, Paolo, Peter Xu, James, Oliver, Aaron

2024.01.10 - Unified uAPI for protected VMs
    Needs: Paolo, Isaku, Mike R

2024.01.17 - Memtypes for non-coherent MDA
    Needs: Paolo, Yan, Oliver, Marc, more ARM folks?

2024.01.24 - TDP MMU for IOMMU
    Needs: Paolo, Yan, Jason, ???


P.S. if you're wondering, what the puck is PUCK?

  Time:  6am PDT
  Video: https://meet.google.com/vdb-aeqo-knk
  Phone: https://tel.meet/vdb-aeqo-knk?pin=3003112178656

  Calendar: https://calendar.google.com/calendar/u/0?cid=Y182MWE1YjFmNjQ0NzM5YmY1YmVkN2U1ZWE1ZmMzNjY5Y2UzMmEyNTQ0YzVkYjFjN2M4OTE3MDJjYTUwOTBjN2Q1QGdyb3VwLmNhbGVuZGFyLmdvb2dsZS5jb20
  Drive:    https://drive.google.com/drive/folders/1aTqCrvTsQI9T4qLhhLs_l986SngGlhPH?resourcekey=0-FDy0ykM3RerZedI8R-zj4A&usp=drive_link

  https://lore.kernel.org/all/20230512231026.799267-1-seanjc@google.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BA37D196C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 00:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjJTW6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 18:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjJTW6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 18:58:14 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279D6D7F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 15:58:12 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6bd5730bef9so1204676b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 15:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697842691; x=1698447491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SrppkFveU0fvDNdY36XrefeVlH08k8+eMXH9fdF2ahI=;
        b=o1rpwW6U5Omzs2U1BUOTjUuRO27P6kGowYTlDYhpw/00BKK2Ep/COfFhbcf5XKaPTQ
         toWq5v12clc8UeA/w/MKYUXaNFYxWfcWzoF+SZd75cI/gX2kVRD/tSYmAb9CH4IJ8Wvp
         N8tXXjKG0j5Ph9Z9EDs2abM8pEBNOR+ammehGDJjoyyZ3UIc6LzhLVGfVAGcAF526hs8
         snHhlHYO2FvjefgUoJrq43cD96psDS7mOWFiOqPxC8nOOt/9R/t+OhcmQxgiUH8057Mm
         q5gI9cUHodOX1UYir/6nJe6QRwTvst/CXIFBX5M3zPNU8tvSE5Elrx+86Fbgkf2Awm0g
         dmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697842691; x=1698447491;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SrppkFveU0fvDNdY36XrefeVlH08k8+eMXH9fdF2ahI=;
        b=RL1KYLj3woJmpFl+ZnFYFCcIGwZC46uYli46kF588darrPlWdDSdVPTwJnjnfK/OMR
         M5oolu3x3JZSC5rvTldW89IbAmalGONzpc8bqiqK8Zgkz2v1EgDbFA4yds7errjMlWhb
         UGROX6Kwz7WCFY1GFAeCduPpO6klozSYWrqR6AAPMM25vRRdzTVYnHJDRHu5hYGL29Pi
         zgnAC6Noh5BvK1SZwKLvimkwqGi/TgdGfEEik1FxKFweqwuy/nQag59fRP9oriw8zIlQ
         QALTZdnHWOMoERQyagaPuiiRUkfVnIYldeVPhTv3xXp2n5tWXCLVgTEotoTeGwfcsF3R
         p3uA==
X-Gm-Message-State: AOJu0Yxj/JI1EFiOKs+yOT5RYZkVNzQQhV44uAKDmHxT2QZHq/TuPcsh
        ma4fJ0uQiYx9JgTo6H62msQfU2iC4/U=
X-Google-Smtp-Source: AGHT+IHSVZv9jju1/ELecw1EVpvoQU379lbFaP9R/rbK4eU/20BIUMhAW8Vy3g3gpGIqO/cRuobIeZbk1C8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:be1:b0:690:bc3f:4fe2 with SMTP id
 x33-20020a056a000be100b00690bc3f4fe2mr103940pfu.1.1697842691387; Fri, 20 Oct
 2023 15:58:11 -0700 (PDT)
Date:   Fri, 20 Oct 2023 15:56:27 -0700
In-Reply-To: <20230905182006.2964-1-zeming@nfschina.com>
Mime-Version: 1.0
References: <20230905182006.2964-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <169766488985.1913247.10258683336910491113.b4-ty@google.com>
Subject: =?UTF-8?Q?Re=3A_=5Bv2_PATCH=5D_x86=2Fkvm=2Fmmu=3A_Remove_unnecessary_=E2=80=98NU?=
        =?UTF-8?Q?LL=E2=80=99_values_from_sptep?=
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, Li zeming <zeming@nfschina.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Sep 2023 02:20:06 +0800, Li zeming wrote:
> Remove spte and sptep initialization assignments, add sptep assignment
> check and processing.

Applied to kvm-x86 mmu, with a beefed up changelog.  Thanks!

[1/1] x86/kvm/mmu: Remove unnecessary =E2=80=98NULL=E2=80=99 values from sp=
tep
      https://github.com/kvm-x86/linux/commit/1de9992f9de0

--
https://github.com/kvm-x86/linux/tree/next

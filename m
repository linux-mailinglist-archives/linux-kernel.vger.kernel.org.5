Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506EE800150
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 02:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376477AbjLAB4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 20:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjLAB4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 20:56:08 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E4C19E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:56:14 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5ccc8b7f578so28599077b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701395774; x=1702000574; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UpBBsyYVohX+FTYFefwcFtMNMJUH3TaZgqYxYwvBXOY=;
        b=g5m715rXsbq9RB3bNRG5/IBH8hxMp04MOk0EWtbLXOSTJCO6vpUpL1MsKBIJxrBGJL
         K+O+W2A9Htua6xG3Gn8lu66ukoMwPz3TRWKyKe1UlUJ94evpam+AiB35gDT9LN1x0lt4
         rzqgGZiVJfufOgTX/Ewp0vLSBRDAjBFgxbZf24NffVTQNrkDSsa+OZJ71akRtQcZcQVO
         cqHwNVguBSRWagwWAD97eAvEPIvwtWVITzNY9X5v3U4gufeQQ8RriFGfUFPqL/NRwi23
         Gr1ei7C3Not9JRfnEoEPz1TITofmdN4WoWkYAaHO3v7DBzatXykvcMYg5g/nMUVZABUE
         k4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701395774; x=1702000574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UpBBsyYVohX+FTYFefwcFtMNMJUH3TaZgqYxYwvBXOY=;
        b=siGPb+Q2OodO/JiLM7mJEhqLRXn0RxermgshgAFl+2ZKzHC8zT6l6KYe8gns8BG0yV
         udPC2zrY0sB9W/0M9WFXPO86zjvatWe1cmJy0PEC/s62X04vT6RDVA18wjgen0qZo1r1
         5eaSiDCuWLLbVGK043UxqU1oF3CQHdjWinZfHbjT8TjZVvnPyOdKKQ14UYgf571b2hy1
         OJkPfq4oZP5OEGTHJTogPaEO7B+FsHP3uPPrCgVDXgHCfpKdYmYzlwezPvdUMFR5lY3L
         sJwQCn3dEx5Mn7OjSkJXmrq+BtoNHjD1bkJtJ26x/tWHHEOuJ5GZNUN8P0J5TYV73/Kw
         G06g==
X-Gm-Message-State: AOJu0Yy2fVSMR3ur3mzVtrdOJWb8QKcS+OPSCH9QnEhakFdqX/08dW1k
        GTTqYrVuujNKL0QyrHo+up/teNZQFhA=
X-Google-Smtp-Source: AGHT+IGzAbxxayMyLDqWERzPqpD5Bo/x0IIJ65uHtJJNm2ABavlKe6+btFUsWJ9cdfFF3T0n1HeMmR7p1Cw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:3d44:0:b0:db4:7ac:fea6 with SMTP id
 k65-20020a253d44000000b00db407acfea6mr711502yba.7.1701395774125; Thu, 30 Nov
 2023 17:56:14 -0800 (PST)
Date:   Thu, 30 Nov 2023 17:52:24 -0800
In-Reply-To: <20231103230541.352265-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231103230541.352265-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <170137839352.665680.16618790592517929019.b4-ty@google.com>
Subject: Re: [PATCH v2 0/6] KVM: x86/pmu: Clean up emulated PMC event handling
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Mingwei Zhang <mizhang@google.com>,
        Roman Kagan <rkagan@amazon.de>,
        Jim Mattson <jmattson@google.com>,
        Like Xu <like.xu.linux@gmail.com>
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

On Fri, 03 Nov 2023 16:05:35 -0700, Sean Christopherson wrote:
> The ultimate goal of this series is to track emulated counter events using
> a dedicated variable instead of trying to track the previous counter value.
> Tracking the previous counter value is flawed as it takes a snapshot at
> every emulated event, but only checks for overflow prior to VM-Enter, i.e.
> KVM could miss an overflow if KVM ever supports emulating event types that
> can occur multiple times in a single VM-Exit.
> 
> [...]

Applied to kvm-x86 pmu, thanks!

[1/6] KVM: x86/pmu: Move PMU reset logic to common x86 code
      https://github.com/kvm-x86/linux/commit/cbb359d81a26
[2/6] KVM: x86/pmu: Reset the PMU, i.e. stop counters, before refreshing
      https://github.com/kvm-x86/linux/commit/1647b52757d5
[3/6] KVM: x86/pmu: Stop calling kvm_pmu_reset() at RESET (it's redundant)
      https://github.com/kvm-x86/linux/commit/f2f63f7ec6fd
[4/6] KVM: x86/pmu: Remove manual clearing of fields in kvm_pmu_init()
      https://github.com/kvm-x86/linux/commit/ec61b2306dfd
[5/6] KVM: x86/pmu: Update sample period in pmc_write_counter()
      https://github.com/kvm-x86/linux/commit/89acf1237b81
[6/6] KVM: x86/pmu: Track emulated counter events instead of previous counter
      https://github.com/kvm-x86/linux/commit/fd89499a5151

--
https://github.com/kvm-x86/linux/tree/next

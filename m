Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945F87CE82E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjJRTwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjJRTv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:51:59 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC88125
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 12:51:57 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7b3ae01c0so109895277b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 12:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697658717; x=1698263517; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XxNGxplnRcKicvl9elf0eksz/zUsfRFCHbPYJJi0Jms=;
        b=2yFIUvemrMyQm7Mwh38tlhfmlAxzJ2OfKBn3/8z+JtN7GNwqrXv54F3bPq15iwT+SY
         8NhXN9/F9PSyhXvwa69SrJbUdcVLINYe+OGJgIDIOPJpMMKuv/76KK0d4JrcMEYzCWfO
         3CqjxMvrZCs4CaLleVEQLIOgyTnyMdEH1AZ6/hP2YLb3ewL1rmZYSr7wIOMa4ekJncUm
         yTaMjrYkt5AsIYeVXU1voTziy0bAYLOSJspMaFVjufZ3aClWT95nDU3r6anJBefmkRPD
         FkY4rHLX5GA2uWO32l8HBumbczZWr2hJz3JIo8o35w5FxLgxFdHc4OqTIgD/EL+v83jn
         oIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697658717; x=1698263517;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XxNGxplnRcKicvl9elf0eksz/zUsfRFCHbPYJJi0Jms=;
        b=T2Oa6vMjpRvzyIUNN73t/3rX7mMTKn+qlLtJ5jVh48Dtw3yKfygLjpr8wQhehUEnci
         U3I3Fy9Iuy93XRKOh5t2KAqE4t0vNdzxIn/+yXrNfBHlowyleyulFXLHu4kHV2HIqDmh
         9ArUpaOHy2WeMvRDAqKtZ30WJKCqrUG5AUJD7TWjK/CdVQemVQajNe03J3lqBvWzDcSM
         CTrpLpBvJlY6UjEx8oPTDZ6K7h34nmIoAARB79SmRDGWm3FMqche83dSNK4BmOVmFJbf
         EUPwuxG3fT9VwIpa53YxbKKOXAHkWKQTanYYjeg22ANu4RRZg1bHY6sFiC0ILcV6o/R0
         RFaQ==
X-Gm-Message-State: AOJu0Yz3kcuNo//MJlbXeNCTGykn5yOd741dcN3iwLlN8xRAsuksUNTG
        9dlNVr1zY73TQ7r7wS2WlvEyYP/diQ8=
X-Google-Smtp-Source: AGHT+IH8mbsoOPbifI+g5j5HdKo44HJUpSWqmP9rWHO11K+B582hq0O9pfInmGEi9RtDTPn5LrNYMVrFwwg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:ca46:0:b0:5a2:3de0:24a9 with SMTP id
 m67-20020a0dca46000000b005a23de024a9mr7443ywd.1.1697658717103; Wed, 18 Oct
 2023 12:51:57 -0700 (PDT)
Date:   Wed, 18 Oct 2023 12:51:55 -0700
In-Reply-To: <20231006175715.105517-1-dongli.zhang@oracle.com>
Mime-Version: 1.0
References: <20231006175715.105517-1-dongli.zhang@oracle.com>
Message-ID: <ZTA3W-f4sOX3LHfi@google.com>
Subject: Re: [PATCH 1/1] selftests: KVM: add test to print boottime wallclock
From:   Sean Christopherson <seanjc@google.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, dwmw2@infradead.org, joe.jin@oracle.com
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

On Fri, Oct 06, 2023, Dongli Zhang wrote:
> As inspired by the discussion in [1], the boottime wallclock may drift due
> to the fact that the masterclock (or host monotonic clock) and kvmclock are
> calculated based on the algorithms in different domains.
> 
> This is to introduce a testcase to print the boottime wallclock
> periodically to help diagnose the wallclock drift issue in the future.
> 
> The idea is to wrmsr the MSR_KVM_WALL_CLOCK_NEW, and read the boottime
> wallclock nanoseconds immediately.

This doesn't actually test anything of interest though.  IIUC, it requires a human
looking at the output for it to provide any value.  And it requires a manual
cancelation, which makes it even less suitable for selftests.

I like the idea, e.g. I bet there are more utilities that could be written that
utilize the selftests infrastructure, just not sure what to do with this (assuming
it can't be massaged into an actual test).

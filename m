Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B32780CE4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239055AbjHRNsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377369AbjHRNri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:47:38 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6194218
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 06:46:55 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-55c7d9edd16so1237858a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 06:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692366389; x=1692971189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jNlR4KxrzE72vpNuTyvfyVvbrBWXFgdYpu7h9tDZYwU=;
        b=vtgMMSNPRqRJdWk7DyvvesFPY2OKKk3Wr7T5UwkfgFFO5g1QQJFjlFXnDFSHqiiEhe
         lD1aF4LgRzwD94FWX/Pz6c0u5HK7icnntQ1CaUHS9vHM9IfBLQRx/IMRnqrJ2XvhouId
         0Moq9CjzTasCUtU+i24RHqrDECGkg8c4HxeYW+3hVVSOqSMUWJWhjsUvHOJDfm1QKkX6
         RjHcybduEWy7snz7CQD66T2zmTu38UEDu/nBqhGMu91SIcVhwqvGGoeO5Bpr4NZT3IDo
         iT5uJvB/M1Eiu/YSbP5jaRC7KPWjfci5ugAcpMnSVIZdcBjjnH/rWontMjdvVjfSl3nK
         j/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692366389; x=1692971189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jNlR4KxrzE72vpNuTyvfyVvbrBWXFgdYpu7h9tDZYwU=;
        b=WMefzqfxzR2A6pZ8P6yizcTKjfy1Np/urwK+HIon9877rpudHf1UXGMWQbNS8HTDqg
         JBs1QOFP0ea63AtVZ3pYKDDH6KdgNJk0NZHKQunx+jDxXGxMGQUu09sNeX4gPTIKIHKA
         IJph5jrO/3R1mMRJ0deBaXLZKDf+XhqBuqEb84jTT3P/xWDFcVL68HZD7qbXAztEY67k
         K149U72Y67So4mqgI9aAWlz/pwf0QnBkdMP6Wplytm4nQtyXUtgy0wWeUX2/kK8sA01K
         8UviDLnqjPKi1esE3gKoKcdMX1gcMxdLbLcBCGTy9h29rKbyu1P713/og+qU7IJGoSPs
         +RqQ==
X-Gm-Message-State: AOJu0YzEvCQXFny8tKF2aWO9vBSTZBpf2UtqImk0qF8ZDjqT8XMLTMLk
        YK3x8Efse08S69E7DbN5eHddnIvE0HU=
X-Google-Smtp-Source: AGHT+IFmESdYKpgGUbBQHEYsCSENkDJqn8Y0SDC8FdMY70toMQGagfsR2ZiXJMY8GWX5/b2Nj3MnFnTrH+0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:7b10:0:b0:565:eb0b:6daf with SMTP id
 w16-20020a637b10000000b00565eb0b6dafmr443690pgc.7.1692366388693; Fri, 18 Aug
 2023 06:46:28 -0700 (PDT)
Date:   Fri, 18 Aug 2023 06:46:26 -0700
In-Reply-To: <ZN9FQf343+kt1YsX@yzhao56-desk.sh.intel.com>
Mime-Version: 1.0
References: <20230808085056.14644-1-yan.y.zhao@intel.com> <ZN0S28lkbo6+D7aF@google.com>
 <ZN1jBFBH4C2bFjzZ@yzhao56-desk.sh.intel.com> <ZN5elYQ5szQndN8n@google.com> <ZN9FQf343+kt1YsX@yzhao56-desk.sh.intel.com>
Message-ID: <ZN92MtFkIF3E79/u@google.com>
Subject: Re: [PATCH 0/2] KVM: x86/mmu: .change_pte() optimization in TDP MMU
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com
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

On Fri, Aug 18, 2023, Yan Zhao wrote:
> On Thu, Aug 17, 2023 at 10:53:25AM -0700, Sean Christopherson wrote:
> > And FWIW, removing .change_pte() entirely, even without any other optimizations,
> > will also benefit those guests, as it will remove a source of mmu_lock contention
> > along with all of the overhead of invoking callbacks, walking memslots, etc.  And
> > removing .change_pte() will benefit *all* guests by eliminating unrelated callbacks,
> > i.e. callbacks when memory for the VMM takes a CoW fault.
> >
> If with above "always write_fault = true" solution, I think it's better.

Another option would be to allow a per-mm override of use_zero_page, but I think
I like the KVM memslot route more as it provides better granularity, doesn't
prevent CoW for VMM memory, and works even if THP isn't being used.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEF9773BC4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 17:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjHHPzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 11:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjHHPxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:53:23 -0400
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7323E4EFC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:43:15 -0700 (PDT)
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-6bc6e6390fcso10518961a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691509049; x=1692113849;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HGXHZ3drdzK75vM8gHoxCvKjL0tQ6wzVt3s6s+3IffU=;
        b=3dpYgx1B01W+/RrPyK/R2ULeC2NRShxIN/J+bE4WylMtcBdEUzhgF/bxT0fpHXvBog
         M9Q4op1p6rbwS3/3/wOwsjObC7hZXwibEH4axFah4jA+mFBaYMgSUF51yW2RJqelP9YK
         hupdGiFtPQmoNWnFUCFCAbFbf7PWW/W2nRP4sh7QPUVlrWOO/Xw8xNh6UqZyT1wAx8h7
         mQ1WyCkKxZy8k04UNxEzus4+ZNdjixITzqizQJKwjDznPhbAWvEih0q4cK6SDbtyKPEV
         riD/D9tze69z0N0KtYvF946k99EYB17xzv/quue3JnxSXTS6OfYP7y2Ez9s0YuPLmHBm
         iX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509049; x=1692113849;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HGXHZ3drdzK75vM8gHoxCvKjL0tQ6wzVt3s6s+3IffU=;
        b=OrxHDYQ127pJJQZS28wUs7+h4ekpTHhSVonqXfl/1MoNwL9U6IT689HRChE68Y7pal
         ZIoAdvWW+E5e3owDXvirYXZ9D/W9chaoceLJg2muhS1qD+nRcDcf4ENz75JvkvhEzs6S
         q0AqKZwKBAzaHFOCBHHqJ55DMM8bOzjnLEngaqdjzXtM54NhlP+BFT9kHMc3FxU0ZPMl
         eaUq1jQe1C2bokE3ICCD/YPWOQkbiKWl4/QbmZnw8w5XNQRv1CzeS/LSCwrec+qv9yzJ
         v2jBjBYbO4LINmao/sMDpiZ+9ycyQ0Q7jRG30qSy3E9QTXBwtrs4OJca5v6gVn46EJw3
         ow9g==
X-Gm-Message-State: AOJu0YwWXdTpe7jq8yH6Qf6uZKeHFei4tYT4YUCgzwVWqt2hKhoZ80+U
        DXJVsqZOwiQbcUsyRfbPYySFvbrAKxQ=
X-Google-Smtp-Source: AGHT+IHIu+df+uNKRHuZ1U7hdYtwjQKpOkRRORgxpZw3jGTJRzS8amVnvOKjBjsEBYetabpmhnKN6Bq+h1o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:1e88:0:b0:d10:a33d:36b6 with SMTP id
 e130-20020a251e88000000b00d10a33d36b6mr118914ybe.0.1691505071871; Tue, 08 Aug
 2023 07:31:11 -0700 (PDT)
Date:   Tue, 8 Aug 2023 14:31:10 +0000
In-Reply-To: <20230808114006.73970-1-likexu@tencent.com>
Mime-Version: 1.0
References: <20230808114006.73970-1-likexu@tencent.com>
Message-ID: <ZNJRrqk1cFFo5BoP@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: Remove unused "const u8 *new" for kvm_mmu_track_write()
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> The incoming parameter @new has not been required since commit 0e0fee5c539b
> ("kvm: mmu: Fix race in emulated page table writes"). And the callback
> kvmgt_page_track_write() registered by KVMGT still formally consumes it.
> 
> No functional change intended.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>

No need to give me credit, you spotted the unnecessary param, all I did was confirm
that it wasn't needed.

> -void kvm_mmu_track_write(struct kvm_vcpu *vcpu, gpa_t gpa, const u8 *new,
> -			 int bytes)
> +void kvm_mmu_track_write(struct kvm_vcpu *vcpu, gpa_t gpa, int bytes)
>  {
>  	gfn_t gfn = gpa >> PAGE_SHIFT;
>  	struct kvm_mmu_page *sp;
> diff --git a/arch/x86/kvm/mmu/page_track.h b/arch/x86/kvm/mmu/page_track.h
> index 62f98c6c5af3..ea5dfd53b5c4 100644
> --- a/arch/x86/kvm/mmu/page_track.h
> +++ b/arch/x86/kvm/mmu/page_track.h
> @@ -52,7 +52,7 @@ static inline void kvm_page_track_write(struct kvm_vcpu *vcpu, gpa_t gpa,

Please remove it from the entire kvm_page_track_write() chain.  Yes, it will be
a larger patch and need an ack from the KVMGT folks, but there is no reason to
only do a partial cleanup

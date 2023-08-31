Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D19878F1E5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbjHaR1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjHaR1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:27:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57F21B2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:27:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d74711fd72eso871678276.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693502859; x=1694107659; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IGpYSMSGMaMzVYXbXpIcBRTqVDSQW/Rx6E1NVn3C2WI=;
        b=D2LvzS5dZiZ9/CK/5zTOt29VtHM3TidntcLTu9rBgty3Ip1WQOB2Pncaeh81DelHiu
         qv2zsU8zwc2TR1kfkrsKa3I9GUmmIbTAVHx1b1cII05lZjRlQxk9LYXVNhJxIhWGEkch
         lzaYSy8N7uoNqEL6DBOZgSDI765n3B7AYzD/5+UGJKOFBQ592DsX9Zwuyo/NIOvobr60
         qKXj9AsgoLf+sTuc/qOhb+BK9aCcggX3KUc7GWAoo33R3hcjtX2LzOcPWRfK9yxpTrVq
         BRfadbG7DVT+JCzInnxekjgMtJYZq2MIuXG/Mx8Lr9WSo+AsOmdXs87Espn/T2I9PF61
         kVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693502859; x=1694107659;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGpYSMSGMaMzVYXbXpIcBRTqVDSQW/Rx6E1NVn3C2WI=;
        b=DlbQmu9IinrgriO81RlrjtNqJ1nrGCOz3P8jUIPl/7MrkMR4IShul5ef4DdOYGU4Az
         J6ZjhHNBLwwRWP+ajk/Xi99WvUKryJHjKfG4LNcRFn3Ad2h27TIe9199qQQVlDeTfJcZ
         bgaXltuOecBS70uYwbUwAiFUswSjzhyMK6/V0uxLnPchieLBBTefrIyw7TwuaqdnbHG0
         XKqmvbRCDXok13DZHLa5uRFa6oM7KLi8XfdomhGuoU33z+xoQCSvTamgSyZBo2pm8VgQ
         1GaxCzog0s3LgS43mV8d2W9K+Bti+jXszmL3og87fEc5HPvYK4GW2gyrb0U3Ej3Vhcop
         2NAg==
X-Gm-Message-State: AOJu0YyO5S+TVYQkz02CYaRkVdv0v+fX/qFCMY6oSTbOEdvD7naGsmiL
        P2U+ySqdJT1ZsHkQ5boLdi7fqxzP4dc=
X-Google-Smtp-Source: AGHT+IHM52+LHk+bvLLVf508Bnog5bhIewQ3dWNXxgaPeqnmLFShqhUA5zjqg8Ns0fvK1Y9OaOvKBSAvIJc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1828:b0:d09:6ba9:69ec with SMTP id
 cf40-20020a056902182800b00d096ba969ecmr9641ybb.4.1693502859202; Thu, 31 Aug
 2023 10:27:39 -0700 (PDT)
Date:   Thu, 31 Aug 2023 10:27:37 -0700
In-Reply-To: <20230830000633.3158416-4-seanjc@google.com>
Mime-Version: 1.0
References: <20230830000633.3158416-1-seanjc@google.com> <20230830000633.3158416-4-seanjc@google.com>
Message-ID: <ZPDNielH+HOYV89u@google.com>
Subject: Re: [GIT PULL] KVM: x86: MMU changes for 6.6
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Like

On Tue, Aug 29, 2023, Sean Christopherson wrote:
> Please pull MMU changes for 6.6, with a healthy dose of KVMGT cleanups mixed in.
> The other highlight is finally purging the old MMU_DEBUG code and replacing it
> with CONFIG_KVM_PROVE_MMU.
> 
> All KVMGT patches have been reviewed/acked and tested by KVMGT folks.  A *huge*
> thanks to them for all the reviews and testing, and to Yan in particular.

FYI, Like found a brown paper bag bug[*] that causes selftests that move memory
regions to fail when compiled with CONFIG_KVM_EXTERNAL_WRITE_TRACKING=y.  I'm
redoing testing today with that forced on, but barring more falling, the fix is:

diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index b5af8249eb09..cfd0b8092d06 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -306,5 +306,5 @@ void kvm_page_track_flush_slot(struct kvm *kvm, struct kvm_memory_slot *slot)
 
 bool kvm_page_track_has_external_user(struct kvm *kvm)
 {
-       return hlist_empty(&kvm->arch.track_notifier_head.track_notifier_list);
+       return !hlist_empty(&kvm->arch.track_notifier_head.track_notifier_list);
 }


[*] https://lkml.kernel.org/r/7a6488f2-fef4-6709-6a95-168b0c034ff4%40gmail.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445157DF9CD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377186AbjKBSRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbjKBSQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A2213E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698948962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dm/JjHi370CidasORpTf+wVzVufl6jy0cXiZxdhplD4=;
        b=aWeqHmmgf9gIF60xiFGqspXOIYwgQq2OYn/pASWJiP8ZJuCJQFbBbSjpGhWZIpI17MVuRk
        QojJ9GbPcRwnSWgtLFqncR2B9dp7jq2taxPAOBtiHNoyjVQzp8Hdzy2JTTugCFbmFgRNGh
        vQDEj5VxyIwR7o+03ViOe9BdaPgxjjA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-MT1NWaaxOMGWmyjbKRwrVw-1; Thu, 02 Nov 2023 14:16:00 -0400
X-MC-Unique: MT1NWaaxOMGWmyjbKRwrVw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4084f909b4cso2578975e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 11:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698948960; x=1699553760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dm/JjHi370CidasORpTf+wVzVufl6jy0cXiZxdhplD4=;
        b=Xc6BMxdRbWe1LXPdmMC2GSBO6mDVlxHUXHnW05vD79fFjm0oroJAIgj32hWhCSlK2/
         HKSAOEAg6KkjORZyKXG319ZmtZutj9ZISdxHFMEYNbgdWdoytbabtN5uwAN1yugHSnvK
         v21jG85xu6yGrHoc5+Owt5tBpoMynMnY+vV3N5/3RWGq5G2fDxnlvlgFBDKSmLiBHJbv
         Pi7HyGSI85Y5dpWFnYMe94b6lKe/6l4MsGjOhSh7RjS7HNmqaDxyh5GiG/HzJFMawg74
         GYjySTAwkqwFrPHdcQpTThOsH9UBqB+aXKCo2GUtpBN3Dz6wD3mjVrfAn9qnGV8L38LT
         Dmgw==
X-Gm-Message-State: AOJu0YwD5UKDelnKv0iZj2HheKlAF0dwEmu6PbUhbyi6MsBcCMNZV6LP
        OsWCB72wKlbc/qR02PPTeGsW+9cpPmEEcAnYklZi80KRHVJBughpGG68QwVVKJonasajxqXvDfR
        2ME53YkugI7+ED5fbBMZWelcg
X-Received: by 2002:a05:600c:35d6:b0:3fe:21a6:a18 with SMTP id r22-20020a05600c35d600b003fe21a60a18mr15692777wmq.3.1698948959790;
        Thu, 02 Nov 2023 11:15:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdSFZUxYnwUz4IzHW2eQMQDQi7I71cXUtCaaSMnHVgWWbl2msHbfrBfeDCbf3D1IMoAJPZeQ==
X-Received: by 2002:a05:600c:35d6:b0:3fe:21a6:a18 with SMTP id r22-20020a05600c35d600b003fe21a60a18mr15692766wmq.3.1698948959456;
        Thu, 02 Nov 2023 11:15:59 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c5:d600:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b004076f522058sm3879929wms.0.2023.11.02.11.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 11:15:58 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH 0/3] Use new wrappers to copy userspace arrays
Date:   Thu,  2 Nov 2023 19:15:23 +0100
Message-ID: <20231102181526.43279-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Linus recently merged [1] the wrapper functions memdup_array_user() and
vmemdup_array_user() in include/linux/string.h for Kernel v6.7

I am currently adding them to all places where (v)memdup_user() had been
used to copy arrays.

The wrapper is different to the wrapped functions only in that it might
return -EOVERFLOW. So this new error code might get pushed up to
userspace. I hope this is fine.

I felt that it might be a good idea to land those three patches here
with a single series, since they all touch something KVM-related.

Kind regards,
P.

[1] https://lore.kernel.org/all/169886743808.2396.17544791408117731525.pr-tracker-bot@kernel.org/

Philipp Stanner (3):
  arch/x86/kvm: copy user-array with overflow-check
  arch/s390/kvm: copy userspace-array safely
  virt/kvm: copy userspace-array safely

 arch/s390/kvm/guestdbg.c | 4 ++--
 arch/x86/kvm/cpuid.c     | 4 ++--
 virt/kvm/kvm_main.c      | 5 ++---
 3 files changed, 6 insertions(+), 7 deletions(-)

-- 
2.41.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBB28017C4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441894AbjLAXaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjLAXah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:30:37 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73D01AD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 15:30:41 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d1b2153ba1so45057467b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 15:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701473441; x=1702078241; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pFtKRJPt7zxEv0tffHLPtKUpr/5KbMlnf6dTP8uAgt0=;
        b=V9lJelFVfAuMQvXoED5BRlK0yRV7Q6YtuMUejP5T5kSVcloGibl/w6DnhFyiAqkJJU
         CBPlK8ygcuRKI2ASo2D3ctXvp3PuYvmBLO4ijkqb3rIMY00mE2hMD0RJhE7v39+7UtoB
         pnmHVCtFhzB1mXCMjy+JslGJOXf2K8F9TDq/4UrEutHtLEKjs/q2e7xtzqrlwKoHm4O0
         uQ8bCkPl2RKbVL7NDPXrEO+LYcq1y+/yM2rsIJENQw7h0fB92LBvK7rDkrM4O2Pk1JFe
         qkRbvOmeB0Sc1ai2TYkH5ELdEm20fcH8m/OsjvB4xsyMTRjezEuDc5Z/U6oSfnE3uzXY
         9Fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701473441; x=1702078241;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pFtKRJPt7zxEv0tffHLPtKUpr/5KbMlnf6dTP8uAgt0=;
        b=eQOn8ez64RWbyNZaUB2hPTfDSnaauMQ3lZac6pvmnt58+HBFZXQ2uGjvlWYW/2uIgE
         xUZdSfxI9n9e2sgyksS1uZRCs93SQsuR5d8nqtOfIf+Wi6S9UtI02rPHPkLx+SfFqDA8
         gGM90WKh/UKu4yC1XvTQ2FWPZsWw0q1dKevkJqdFPBTRqnYTmLOgB5lhXWKdRwHAz9Ja
         pGCBLXfDO7ev6tkYTpT9PAKGQZBhuqDOym36R6ob3BOQ5H6CLDkl9BbgVUKKFd0txpOt
         QiQe83QS24fhdYGGsgYvb+TP8jM6ZP8L0EEbqZgGc048EZPLtzXq+CGY8LBV3e9o8JZC
         b6Iw==
X-Gm-Message-State: AOJu0YxiVn8/q0MgKIVFcN7Vatbole+oGAElJpWN48mLLdjbcMPlFyj1
        8nraCR5bhnrcfuX7f/EAtDnOE9674Pc=
X-Google-Smtp-Source: AGHT+IFB9y2kEWO8Kpe0q9euDjDBWyWXgxQFrXBuoZzF9XdZUaidnZVS7jJDK5kMO6grQ22oMvcjhXzqCVk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:d40f:0:b0:59b:e684:3c7a with SMTP id
 w15-20020a0dd40f000000b0059be6843c7amr886798ywd.4.1701473441225; Fri, 01 Dec
 2023 15:30:41 -0800 (PST)
Date:   Fri,  1 Dec 2023 15:30:33 -0800
In-Reply-To: <20231007064019.17472-1-likexu@tencent.com>
Mime-Version: 1.0
References: <20231007064019.17472-1-likexu@tencent.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <170144728224.840084.5797440525158883360.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86/xsave: Remove 'return void' expression for 'void function'
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 Oct 2023 14:40:19 +0800, Like Xu wrote:
> The requested info will be stored in 'guest_xsave->region' referenced by
> the incoming pointer "struct kvm_xsave *guest_xsave", thus there is no need
> to explicitly use return void expression for a void function "static void
> kvm_vcpu_ioctl_x86_get_xsave(...)". The issue is caught with [-Wpedantic].
> 
> 

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: x86/xsave: Remove 'return void' expression for 'void function'
      https://github.com/kvm-x86/linux/commit/ef8d89033c3f

--
https://github.com/kvm-x86/linux/tree/next

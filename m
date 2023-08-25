Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B941788BA5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245188AbjHYO0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343856AbjHYO0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:26:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D021995
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:26:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d78452de9cbso548843276.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692973564; x=1693578364;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xpKO/2A0f/no2QIyIWC8bhx4Rp180QUhRFsJmxIIf6k=;
        b=cFkJgG2HgF7ql8/QY+ZSKA5R4EJ76QgRByuQImcO66jhdIVOsnThPj+OKN+Ka6GwJw
         LDwJfXmt37njPox0SCKS6HtdoZWM6ZKAnPvo2IWC4fidM5IoeqCr98Znox9XCvkaOkg5
         iR1mizqaTnQ20ylmolDwwgohXf1moQkKWuvlGg2fcH00GWrBQnzdlZKkNw3Jd9zs56Ed
         gS+vllTY2iAPKvfWqIWBGqVi40qrXnxr1UFnnWPm2zibyB1cY+HQlv1SAkMJAajDCGOA
         OtAqtn0S9nghmDwRoYT6UPKoghUIrjFerywtwSCDiMxj9N0IOlJb3F+6yZUT9TY27QWL
         SdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692973564; x=1693578364;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xpKO/2A0f/no2QIyIWC8bhx4Rp180QUhRFsJmxIIf6k=;
        b=j3ZlUVRZxI9GbWsVeAKixMtbrFzENqw5ktFGkgdmZp9rM2kOwx19oa/lRwiE5Zz4a2
         3TZBKlAhdtxTzwWMiVBEkV4jTdUZOGCQe5G/OinpxKcy7VMsqNIMozHfjk23PerapYnI
         sY7P00qmy6oA1wLzcrRa/U7nlVfYFN6jpkOaRVxyTsBmYs7ICGi/BWHEqO6M2OePgqj1
         7LOsOvSAfxdhlIeoESFN2cJgCdBTKmJiUhywwmBTTa7x57ZK1as9BAnMNTCWD4MNarSH
         d0/bmkJpofu5WNtIemPnfbgBVBGm8jyofdFEIygqy4f5bmqlAC1IWZ+kfcSdyepn6NIi
         eEYw==
X-Gm-Message-State: AOJu0YxPvVAScGHHTg8Y6YnKKEPm6UR8MdfDz4n4vM86ziktD85MjJyA
        r+8+wNLtlpt+iUHReh7A/qGzXuQ1wz8=
X-Google-Smtp-Source: AGHT+IE64T9Kdj2ejG3B4Nr6Y45EuDCgAtQzT7hL9ZXXsmCS3yNmRUay9Xn0CHteK3xz97jhmqj3De9Ue1E=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:7450:0:b0:d7a:a879:614d with SMTP id
 p77-20020a257450000000b00d7aa879614dmr22384ybc.1.1692973564238; Fri, 25 Aug
 2023 07:26:04 -0700 (PDT)
Date:   Fri, 25 Aug 2023 07:26:02 -0700
In-Reply-To: <cdad0a8b-0994-d2f3-7c68-e632ce4facf7@amd.com>
Mime-Version: 1.0
References: <67fba65c-ba2a-4681-a9bc-2a6e8f0bcb92.chenpeihong.cph@alibaba-inc.com>
 <ZOYfxgSy/SxCn0Wq@google.com> <174aa0da-0b05-a2dc-7884-4f7b57abcc37@amd.com>
 <ZOdnuDZUd4mevCqe@google.com> <cdad0a8b-0994-d2f3-7c68-e632ce4facf7@amd.com>
Message-ID: <ZOi5+rMYTVpmdQ2+@google.com>
Subject: Re: Question about AMD SVM's virtual NMI support in Linux kernel mainline
From:   Sean Christopherson <seanjc@google.com>
To:     Santosh Shukla <santosh.shukla@amd.com>
Cc:     "=?utf-8?B?6ZmI5Z+56bi/KOS5mOm4vyk=?=" 
        <chenpeihong.cph@alibaba-inc.com>, mlevitsk <mlevitsk@redhat.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Aug 25, 2023, Santosh Shukla wrote:
> Hi Sean,
> >> Yes, HW does set BLOCKING_MASK when HW takes the pending vNMI event.
> > 
> > I'm not asking about the pending vNMI case, which is clearly spelled out in the
> > APM.  I'm asking about directly injecting an NMI via:
> > 
> > 	svm->vmcb->control.event_inj = SVM_EVTINJ_VALID | SVM_EVTINJ_TYPE_NMI;
> >
> 
> Yes. This is documented in APM as well.
> https://www.amd.com/system/files/TechDocs/24593.pdf : "15.21.10 NMI Virtualization"
> 
> "
> If Event Injection is used to inject an NMI when NMI Virtualization is enabled,
> VMRUN sets V_NMI_MASK in the guest state.
> "

Awesome, thank you!

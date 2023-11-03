Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DC27E0BFF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 00:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjKCXKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 19:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjKCXKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 19:10:19 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CF4D48
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 16:10:16 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5afacc566f3so34767027b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 16:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699053016; x=1699657816; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NGYqbU2Pt3l58GxHHNn56r5S3wILmJgK40ILXYIhwmI=;
        b=1GA1HxykMWMhRIIVzJToDwLykI31ZDNJ+f1IWQ1dDKzLMbcbYGlMd98qGfCkweN/UE
         InUiKT7mHfx005NI5Qibdlm30xqO4CfuUcwDdEUEHtTkBmUHKQ5wLiH6nn5llGGGjDhC
         P/38oEXdHlVbp0dJi06wiUtx7xTrpWrAHpnp6jOtu1/uXK4V0l3HrWD6Y3wOLieu2MDr
         XrzdCfKGe+PwXckv2kTmtEq0ym0MkH7npz3xxD0H5TsTlu9PhVT1v8zk5d44vQDeOGmV
         hcHa1IoF81NZndHAFB6gfO4Vs6Vx7gbzjrF+N4g8UzfMSmDBTBVrdYJdKt7h4klRabdB
         cn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699053016; x=1699657816;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGYqbU2Pt3l58GxHHNn56r5S3wILmJgK40ILXYIhwmI=;
        b=w+UGPNgUDQxULBvZBjmjcj1V26WG0MKQGkV2V9YjbaQ3+rAvxOMdJK73pcjSelBwdY
         QHGszfetSheDX7Xu5EOusvEdyUksJfXJY2VfoBpbo2E875/QdrHIQTEccYD6oYpie7A8
         zX6mVC3ws69OhgCebGBVRHFn0UL32NGCL4n+SxHOWKYdrsrJR5mbiEgeoAzYxyesjtAG
         2suEyNEIThEB/Z/S4jdFXc8GIjPAy/33BV6x2ytpBSVvNxs+z1FxrOioUMO8CwVRCMWw
         XAFr23QZ0TA4FxWhOu/9vCwhj5CaRe27MXmzdbrmQ7pnDcS4Gis6OHYqGouEEtK194CQ
         qyrg==
X-Gm-Message-State: AOJu0YwzDlcpu2b5qpTVi5cdlCC8gr5cTkk5A1aIlzfJXe4zFH5t44Z4
        sb0dJo9pdVd0PKkNeL8uWi+rG/uO/TY=
X-Google-Smtp-Source: AGHT+IHqfufR9/zt4mNTXWa535MIbE/HOSJFf3xf59ZPSkzAgrlvBxT9Wi3CSIEs6ia/QcBMUrxJuOinaz8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:2516:0:b0:d8b:737f:8246 with SMTP id
 l22-20020a252516000000b00d8b737f8246mr415633ybl.2.1699053016128; Fri, 03 Nov
 2023 16:10:16 -0700 (PDT)
Date:   Fri, 3 Nov 2023 16:10:14 -0700
In-Reply-To: <b47e82a4-2c01-4207-b4f8-296243061202@xen.org>
Mime-Version: 1.0
References: <20231002095740.1472907-1-paul@xen.org> <20231002095740.1472907-5-paul@xen.org>
 <ZUGQhfH3HE-y6_5C@google.com> <b47e82a4-2c01-4207-b4f8-296243061202@xen.org>
Message-ID: <ZUV91k9cUZt9jTbm@google.com>
Subject: Re: [PATCH v7 04/11] KVM: pfncache: base offset check on khva rather
 than gpa
From:   Sean Christopherson <seanjc@google.com>
To:     paul@xen.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Durrant <pdurrant@amazon.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023, Paul Durrant wrote:
> On 31/10/2023 23:40, Sean Christopherson wrote:
> > On Mon, Oct 02, 2023, Paul Durrant wrote:
> > > From: Paul Durrant <pdurrant@amazon.com>
> > > 
> > > After a subsequent patch, the gpa may not always be set whereas khva will
> > > (as long as the cache valid flag is also set).
> > 
> > This holds true only because there are no users of KVM_GUEST_USES_PFN, and
> > because hva_to_pfn_retry() rather oddly adds the offset to a NULL khva.
> > 
> > I think it's time to admit using this to map PFNs into the guest is a bad idea
> > and rip out KVM_GUEST_USES_PFN before fully relying on khva.
> > 
> > https://lore.kernel.org/all/ZQiR8IpqOZrOpzHC@google.com
> 
> Is this something you want me to fix?

Yes?  I don't want to snowball your series, but I also really don't like the
confusion that is introduced by relying on khva while KVM_GUEST_USES_PFN is still
a thing.

Can you give it a shot, and then holler if it's a bigger mess than I'm anticipating?
I'm assuming/hoping it's a relatively small, one-off patch, but I haven't actually
dug through in-depth to figure out what all needs to change.

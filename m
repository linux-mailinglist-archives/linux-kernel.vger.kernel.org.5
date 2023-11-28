Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90027FC1F0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346685AbjK1SBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346369AbjK1SBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:01:20 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6011A5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:01:27 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5c1f17f0198so5047354a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701194487; x=1701799287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLq05PNDVda9aScY/SisztbkXwqXqd3sYjTGw5PUJeI=;
        b=EFDaRbTODs3BrLwQvjzLNpQxJURlV70rN4ctLh/5vrYOgTcW20BBhtPEHzoxVPzZtB
         tJ8Nj4QGZoqT0v2D+pNr0GbnzcilrX0TLY6wFgm0HuMYK4TZp5E2bmYfzp6MiycbtZMD
         z6smNynd+a1HNprx8/XMHmqAiDwxJ6y5w0YQ/xRY9BkYN05qg4JdFUCJ7K45NdgylMSC
         8JjDR403Gd6pBeLRjNHFc2JUk3WEs7Blni3P1BvWjneSrJKxS2wRk/CpIgCKavc+MCTX
         1gXOOxIj7RV4Va3fPGirpnH8O2T1wi603kCsBHtNAwQ9NpuUgbdLcIY3kCM8TiLgkkB9
         OVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701194487; x=1701799287;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eLq05PNDVda9aScY/SisztbkXwqXqd3sYjTGw5PUJeI=;
        b=hMfjR9JI/Gqh/Q1JPSqO0v4eGci1T4RNTyhHUe33Q4gSe5Kz90Zxacnx2Wp9MgdtWV
         BGsxFptkjl5QOF09wJ3An1Zuf7pB/qN5zqgTweDrdUSif9ahnvBX3ioa1mmMTl7UHQXp
         vx7eLtrquqoCzCqT2lPD2/gnuovjBEL91b3+UsXQTr5o+oobFmTzahxKeIJyZta3Mnj8
         1GTGLrDIm3wmS51x3C0p6F7HCGSJhQv+aoxOFIPAJv9dRqF23aZ+NRcAqV88w7WWkhOy
         gXNLfmm1nHibppgYSQKBqIt6l/9LQXbGWsWDiAJOJrPw6/tOiyA56qpytOGl726NIjZl
         +fhw==
X-Gm-Message-State: AOJu0Yxv6GXW29bM71i1Hw5LqdM3r67ylVvsUoTx7O6iPxb+PBRVtVkX
        iEihCsjxD5Zi2WVFeYogMPUQKifzV2Y=
X-Google-Smtp-Source: AGHT+IFNpNFIXlxB0zt8OdAQTgvseJ7SAZR+7oHRbWOjuUMCt1O25ZyuOpH9EBjJdRLzVlyQWSuhW+kqEvA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:4a:0:b0:5bd:bf7a:d167 with SMTP id
 71-20020a63004a000000b005bdbf7ad167mr2483762pga.9.1701194486901; Tue, 28 Nov
 2023 10:01:26 -0800 (PST)
Date:   Tue, 28 Nov 2023 10:01:25 -0800
In-Reply-To: <CAJhGHyAiYxyiC+oepgqHofBpKVXLyqOUS=PjXppesx4AS3++-w@mail.gmail.com>
Mime-Version: 1.0
References: <20231107202002.667900-1-aghulati@google.com> <20231107202002.667900-10-aghulati@google.com>
 <CAJhGHyAiYxyiC+oepgqHofBpKVXLyqOUS=PjXppesx4AS3++-w@mail.gmail.com>
Message-ID: <ZWYq9W3D8JCAPoc8@google.com>
Subject: Re: [RFC PATCH 09/14] KVM: x86: Move shared KVM state into VAC
From:   Sean Christopherson <seanjc@google.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Anish Ghulati <aghulati@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        hpa@zytor.com, Vitaly Kuznetsov <vkuznets@redhat.com>,
        peterz@infradead.org, paulmck@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Venkatesh Srinivas <venkateshs@chromium.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Nov 17, 2023, Lai Jiangshan wrote:
> On Wed, Nov 8, 2023 at 4:21=E2=80=AFAM Anish Ghulati <aghulati@google.com=
> wrote:
> >
> > From: Venkatesh Srinivas <venkateshs@chromium.org>
> >
> > Move kcpu_kick_mask and vm_running_vcpu* from arch neutral KVM code int=
o
> > VAC.
>=20
> Hello, Venkatesh, Anish
>=20
> IMO, the allocation code for cpu_kick_mask has to be moved too.

I'm pretty sure this patch should be dropped.  I can't think of any reason =
why
cpu_kick_mask needs to be in VAC, and kvm_running_vcpu definitely needs to =
be
per-KVM.

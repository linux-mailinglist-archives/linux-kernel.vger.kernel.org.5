Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F877C8EA0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 23:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjJMVCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 17:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJMVCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 17:02:30 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0C9B7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:02:29 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c9d140fcddso21882845ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697230948; x=1697835748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDt833gpv5jt5jkNaSbrafWuiiiwZtQQlsR8tC9fqjo=;
        b=w79PfHsmD/oNNMTQk6CvI2yncyQuOAkM+kTJAnI76uvrlVFTErkvPD0truC9xflJuN
         6bxaj/699MjixR/yFhie2z7X8xW8AFhjcMJWY9N4BrDRJ+V7i69ykrSLFWq0FWya6zFA
         VGx2Ye1L4o1ASquB9pXVworLMw245qyveGWwCYhqKYidlCzNH7Qeol38lI89qhn1OOiG
         dVz3+7Aw7NPuoVQOEW6YvATELlhXlSBx7raMfL5961Pjr0zK7QuXXO50ORNi3a3avy3S
         uWMRPmCg0172KE99H320QFTHTlaVsSe3/sTIy5MQqGgofKaQcau+LkuYVtJS5gudjS6D
         ++2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697230948; x=1697835748;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EDt833gpv5jt5jkNaSbrafWuiiiwZtQQlsR8tC9fqjo=;
        b=hm5/WqYQ/T6XGzyqLH4g3AXpX/Igjzq8XcPrdCqXiVvnvy2ktF8UmQFyadqBcp+jRk
         lba9U3hWIY3/KRTA70QrEfbcdIglbJNBP0jFT1En77XWRM+R7p58a9jIK1W3UDMER0IH
         Wi0mnhauF4yb3JuMwAqhv1KalGZckDuAqMCgXz4DoyZEIJxHGR03dO+bjXOMd9/JBNU2
         fXSVFtnx+xoSvKF+pBvn7UZFosUDj4gA3VIbQi7rNuTD+knP+Lf3i0/d5aYKo11h6MEJ
         zkM/J9BTdfngjLoqTheuSUnBUVBPwRHVZnLpCSnh7v7ysHGIS/8CXkIAEsVxoMlwhQX9
         ZGTw==
X-Gm-Message-State: AOJu0YzD03zadVogulyCgAzpBk3df7IVZkj4afyo1xLjr3ZfYCaiPCIE
        9R9g6cPQPZFyhwkrO10fOVr5irABYQM=
X-Google-Smtp-Source: AGHT+IE8M4iiJrgQN6iyv9nl15swMUQzSfqTaE3mB2MjuslIriTKpPjacBrAYJL6ktH+O4aNjrY3ojTPoS0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:a387:b0:1ca:1e12:7c85 with SMTP id
 x7-20020a170902a38700b001ca1e127c85mr23522pla.3.1697230948465; Fri, 13 Oct
 2023 14:02:28 -0700 (PDT)
Date:   Fri, 13 Oct 2023 14:02:26 -0700
In-Reply-To: <CAFULd4bTyKKw+=SuTVbFXzgqqV+XU-kGaO5eBcXck5BUpvoUJg@mail.gmail.com>
Mime-Version: 1.0
References: <20231011204150.51166-1-ubizjak@gmail.com> <ZSlqo-k2htjN1gPh@google.com>
 <CAFULd4bTyKKw+=SuTVbFXzgqqV+XU-kGaO5eBcXck5BUpvoUJg@mail.gmail.com>
Message-ID: <ZSmwYmxjgC0p0wdr@google.com>
Subject: Re: [PATCH tip] x86/percpu: Rewrite arch_raw_cpu_ptr()
From:   Sean Christopherson <seanjc@google.com>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023, Uros Bizjak wrote:
> On Fri, Oct 13, 2023 at 6:04=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Wed, Oct 11, 2023, Uros Bizjak wrote:
> > > Additionaly, the patch introduces 'rdgsbase' alternative for CPUs wit=
h
> > > X86_FEATURE_FSGSBASE. The rdgsbase instruction *probably* will end up
> > > only decoding in the first decoder etc. But we're talking single-cycl=
e
> > > kind of effects, and the rdgsbase case should be much better from
> > > a cache perspective and might use fewer memory pipeline resources to
> > > offset the fact that it uses an unusual front end decoder resource...
> >
> > The switch to RDGSBASE should be a separate patch, and should come with=
 actual
> > performance numbers.
>=20
> This *is* the patch to switch to RDGSBASE. The propagation of
> arguments is a nice side-effect of the patch. due to the explicit
> addition of the offset addend to the %gs base. This patch is
> alternative implementation of [1]
>=20
> [1] x86/percpu: Use C for arch_raw_cpu_ptr(),
> https://lore.kernel.org/lkml/20231010164234.140750-1-ubizjak@gmail.com/

Me confused, can't you first switch to MOV with tcp_ptr__ +=3D (unsigned lo=
ng)(ptr),
and then introduce the RDGSBASE alternative?

> Unfortunately, I have no idea on how to measure the impact of such a
> low-level feature, so I'll at least need some guidance. The "gut
> feeling" says that special instruction, intended to support the
> feature, is always better than emulating said feature with a memory
> access.

AIUI, {RD,WR}{FS,GS}BASE were added as faster alternatives to {RD,WR}MSR, n=
ot to
accelerate actual accesses to per-CPU data, TLS, etc.  E.g. loading a 64-bi=
t base
via a MOV to FS/GS is impossible.  And presumably saving a userspace contro=
lled
by actually accessing FS/GS is dangerous for one reason or another.

The instructions are guarded by a CR4 bit, the ucode cost just to check CR4=
.FSGSBASE
is probably non-trivial.

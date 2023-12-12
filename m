Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9C680F444
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbjLLRSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjLLRSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:18:10 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5F2A0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:18:16 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dbcc8f895daso139569276.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702401496; x=1703006296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYZqQZ0C1vTq1Q5ZgORnfs0Fnsc+4+uug2eKsahCD6s=;
        b=rAdRlyB49LqjGc2UkgdDCZMJ8AJtP3agvepRBHQCjSXAP65azbwRkNSC55KcfsYZpl
         /wt56DVAKCZFKM62GxbPuGi8EWezBlnOWQq4z9sPtme7hloMB2vRTRdG6yFRxOvMbzg4
         xDQdyJM8KTn1KD47ckKUU58YUnXyC56PoPIHf1vCeSbaIlyp0+cGNKs+BpE20QNWZsFV
         Is10v1qxaGf91lD0hTTclv74sZOKHfabDVvcbBWm8EweIsf5ip187o/csHRc8LBNrMSr
         kp1alQp02PZtC1MVIJI/bXA5e3qPdZNMsb+ORh5ShLMxhSGOYFYKMOP0fP9nG2ABcQLq
         r8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702401496; x=1703006296;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AYZqQZ0C1vTq1Q5ZgORnfs0Fnsc+4+uug2eKsahCD6s=;
        b=GdkD8455mtj1QpmbTA42wsSjZn9lySnBHRzTU3JGXBv6d+Jc/QhDZd7LI/BpKLQe4T
         COQ/YU8Y5HPRBOpBgOnIkqFirOvQXXuSPvFeZHjRbBqBNAHKzkU4TqgiMYtY/jCAnlNR
         OWoXcS9OntGyPpBN2D/jiDYxlkd9YwTMmV1DqjOIEA29E9hGGJBjIwfssmfPXI0nn/z+
         HmPDY+m2RCMjrtxa2miKzoA75cB6b01c3N3PoTxovnZ9RPqU7+Uea8P5oiguDnTXGJX8
         G/ujYmf2Pmq+bHEJFuKox61PfSd/ECrNsUFMrKvgotIYlkE7lHp10gwVBYoQDGQZ0HcN
         Pefg==
X-Gm-Message-State: AOJu0Ywhs8jQpYTH3hkrV4p0fxlcuDP2/D4u1gXNqTtO2EAqWnlPZBE9
        Mr8gg7/+pIlbLItVIX2aOCgXfLuvkEA=
X-Google-Smtp-Source: AGHT+IECIs8G3jM2WZyRE4oWJhjBQvPB3/u39KEvPcuAITAWFWLvSUfQ0hYgQ8mlsjkrjvzsZAZLs8GXAU0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:150:b0:da0:3da9:ce08 with SMTP id
 p16-20020a056902015000b00da03da9ce08mr64114ybh.10.1702401495879; Tue, 12 Dec
 2023 09:18:15 -0800 (PST)
Date:   Tue, 12 Dec 2023 09:18:14 -0800
In-Reply-To: <e40d3884-bf39-8286-627f-e0ce7dacfcbe@loongson.cn>
Mime-Version: 1.0
References: <20231130111804.2227570-1-zhaotianrui@loongson.cn>
 <20231130111804.2227570-2-zhaotianrui@loongson.cn> <e40d3884-bf39-8286-627f-e0ce7dacfcbe@loongson.cn>
Message-ID: <ZXiV1rMrXY0hNgvZ@google.com>
Subject: Re: [PATCH v5 1/4] KVM: selftests: Add KVM selftests header files for LoongArch
From:   Sean Christopherson <seanjc@google.com>
To:     zhaotianrui <zhaotianrui@loongson.cn>
Cc:     Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vishal Annapurve <vannapurve@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Peter Xu <peterx@redhat.com>,
        Vipin Sharma <vipinsh@google.com>, maobibo@loongson.cn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023, zhaotianrui wrote:
> Hi, Sean:
>=20
> I want to change the definition of=C2=A0 DEFAULT_GUEST_TEST_MEM in the co=
mmon
> file "memstress.h", like this:
>=20
>  /* Default guest test virtual memory offset */
> +#ifndef DEFAULT_GUEST_TEST_MEM
>  #define DEFAULT_GUEST_TEST_MEM		0xc0000000
> +#endif
>=20
> As this address should be re-defined in LoongArch headers.

Why?  E.g. is 0xc0000000 unconditionally reserved, not guaranteed to be val=
id,
something else?

> So, do you have any suggesstion?

Hmm, I think ideally kvm_util_base.h would define a range of memory that ca=
n be
used by tests for arbitrary data.  Multiple tests use 0xc0000000, which is =
not
entirely arbitrary, i.e. it doesn't _need_ to be 0xc0000000, but 0xc0000000=
 is
convenient because it's 32-bit addressable and doesn't overlap reserved are=
as in
other architectures.

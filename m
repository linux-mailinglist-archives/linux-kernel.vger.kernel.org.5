Return-Path: <linux-kernel+bounces-18357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6E1825C01
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082C21F24616
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01428360B0;
	Fri,  5 Jan 2024 20:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mwtEYtFF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B443609A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 20:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-28c5c622a3cso21510a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 12:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704488273; x=1705093073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDAsfdMogSDCfbb8LPdGnJzEk+5kvJhLWVCCdsIfXj0=;
        b=mwtEYtFFPBDsr7uPfZYsu7MpBKGo5yqmF4kAjJ0wjpj/QSuQJERbr5DltampW1lmyT
         PnYCbgytCmWiURhJVYAswjVvltSxoidF4yjbh7aQPQLG8kGrnY9onTI5HHCvSAZtYNre
         9IlNbp9uJCSXHlUDry2+9W6UOD0tNFIRji/gweJiw30K6lBK+8fPBuvWBwCd2d8Ig46g
         446PmHB/+Q6ez8DNR01QfyEPS3Cy4SqfzaLAA2SQYZoTkkqm8FjUUHwSMtR8p6qDSFqv
         oP25x6zozKbZL4DU0PHFyglwZ/Yf8Q9ktK4UFkHiV0vpeXTAQ8sHervqXc5GIUNoJJaW
         VL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704488273; x=1705093073;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UDAsfdMogSDCfbb8LPdGnJzEk+5kvJhLWVCCdsIfXj0=;
        b=hju1XMOwMHrCuoKmQ+6wVMn20DXyqo5JR96x2CDmXs+6Jldr1hWWw5e2EH7nZjhKMk
         WUWnzjKQEetN2lZWOWt+ObJXpQmYFW+ePiE5icg30Lf8wOWVpvh1zcEgOX5SQTKsWe1d
         3+RExb4bhwSHGtpSheLcGaiVMQFNF1OYkItx2RYYdd+9h4HDxqaanvzusIVJEDwIzFac
         3bNyF7J/o1b2IOxJ446xEIee8+PhNyvhRuEg8HYszgIGqgwZzMFNVOn/dsO1cZz+yqrQ
         EllsSWTP5nSgclQnWUrTzlSTRUItqbxFQxip/g6pu7+RxhYAyJMorIMntLPzmImXu6Oj
         dwrw==
X-Gm-Message-State: AOJu0YxJWpYst36TbSUVEDxnRk9WUZMzG2nSOjTfXQbOjSpvdSN12FHy
	8OBeK/AgBQEEV8kex8VyQpDQHnPOv6BCSybG/Q==
X-Google-Smtp-Source: AGHT+IH2BGvfmcG0nldgOODhjfplVd4m+RYalMqnfASMv3Enm7oVuRn36cPTIL2avUwOiSQvre8jkwOwlx8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4b89:b0:28c:f855:e15 with SMTP id
 lr9-20020a17090b4b8900b0028cf8550e15mr290pjb.4.1704488273302; Fri, 05 Jan
 2024 12:57:53 -0800 (PST)
Date: Fri, 5 Jan 2024 12:57:51 -0800
In-Reply-To: <CABgObfYvuBeN6Vhp7TUBP9g8G8H2DvMQ=RJGWGNdCoS8k+AWfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240104205959.4128825-1-pbonzini@redhat.com> <20240104205959.4128825-2-pbonzini@redhat.com>
 <ZZhUzm9r5Z5l567Z@google.com> <CABgObfYvuBeN6Vhp7TUBP9g8G8H2DvMQ=RJGWGNdCoS8k+AWfw@mail.gmail.com>
Message-ID: <ZZhtT7gha4PnJm-E@google.com>
Subject: Re: [PATCH 1/4] KVM: introduce CONFIG_KVM_COMMON
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, ajones@ventanamicro.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 05, 2024, Paolo Bonzini wrote:
> On Fri, Jan 5, 2024 at 8:13=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> > > Start by introducing such a new Kconfig symbol, CONFIG_KVM_COMMON.
> > > Unlike CONFIG_HAVE_KVM, it is selected by CONFIG_KVM, not by
> > > architecture code.
> >
> > Why?  I don't get it, just have code that cares do IS_ENABLED(CONFIG_KV=
M).  Except
> > for the MIPS usage of HAVE_KVM that you solved by adding CPU_SUPPORTS_V=
Z, I got
> > all the way there using just CONFIG_KVM[*].
> >
> > Ah, and so does this series for the most part, the only usage of CONFIG=
_KVM_COMMON
> > is in scripts/gdb/linux/constants.py.in.  Honestly, adding a Kconfig ju=
st so that
> > VMX's posted interrupts that arrive in the host can be printed when KVM=
 is built
> > as a module is a waste of a Kconfig.
>=20
> There is one extra thing that CONFIG_KVM_COMMON does, which is to
> avoid having to select common requirements in all architectures.

Oooh, gotcha.  FWIW, I would love to unify the "menuconfig VIRTUALIZATION" =
and
"config KVM" entries, but I can't think of a sane way to do that without en=
ding
up with something like KVM_COMMON. :-/

> I jotted this to solve the reported randconfig failure, which is why
> CONFIG_KVM_COMMON only requires "select EVENTFD", but looking more
> closely it should also select PREEMPT_NOTIFIERS and INTERVAL_TREE.
> Both are used by virt/kvm/kvm_main.c, and loongarch + riscv both lack
> INTERVAL_TREE so I do think it's a good idea to introduce this symbol
> (though it requires a v2).
>=20
> > [*] https://lore.kernel.org/all/20230916003118.2540661-12-seanjc@google=
.com
>=20
> I guess you mean
> https://lore.kernel.org/all/20230916003118.2540661-8-seanjc@google.com/.

Doh, yes.


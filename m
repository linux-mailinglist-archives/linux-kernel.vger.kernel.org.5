Return-Path: <linux-kernel+bounces-19583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D99E0826F36
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56FC61F22FB6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14624174D;
	Mon,  8 Jan 2024 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fXo7KrSZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3394121B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704719085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K16gTYHcW3R+U7Fg39fSoUOy5CumITmRVkwMwFkvd8c=;
	b=fXo7KrSZGqvTEpn+nRHOQE3oC7TYDTy/aPqR496VAGVugdsha5aQAQeHuf07uUD36pyP7f
	6YziVtJprGqklCX4VTbaFkvGTEIwbFyxzj4kv/wYRTl6iZ2q4uY5i+QwL691cP7N2ClbD+
	0XDZfVov7lpYfxMIe+EcKAgAeHTEi3U=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-U8uRejfwP02oRalqakJbNA-1; Mon, 08 Jan 2024 08:04:43 -0500
X-MC-Unique: U8uRejfwP02oRalqakJbNA-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6dc90c0466bso1788529a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 05:04:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704719082; x=1705323882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K16gTYHcW3R+U7Fg39fSoUOy5CumITmRVkwMwFkvd8c=;
        b=Qe0ugPv2msgU5CQr138aMU73PJT7zXGhVGQxN2JqKld/Qr/jvExel/qNoBDxfDkDpf
         oaPIJiCpl04pBH+KgUM+hGcSDT3m41BVCreguclIsL0ywRoP3V/zuYoDsUrSikw7vHoa
         T06oK1fqKatFALsEDoDLgAHEv2n/mE5T8gc+U/DooiJ2oCWINqXvzF4VXXmH0MqZ+x8Q
         gJW2kScmSl5VIswZCC03Ju3Tp+epq6lqcKZZYRZ9+lZHHVgEv37N7NOXN7eejWzn40rx
         5WGX7vlzkfvT9GbphEEm9E5s8RQ3CzOfZW77g2vCN0nurdFAggzcmpFT3qh+EcOqYpYO
         6LQg==
X-Gm-Message-State: AOJu0YyZCnOjbkLQwh4ItuglcZDNL8qIM4wfCJuo2z4cJy3Xdc8x2nbR
	Ow5ugDrdyp9ZW3hHChdDn2EtIpPjb1u5oLawA9RtbWqIYL0a2LoFnF50NF9wAZgfZ5BLDb2CH1s
	UiEqesMt+FS3f973dzDyin9jQKhbMdMtfmgr2FBsIFGWU7OlqVPBlmaSwY2Y=
X-Received: by 2002:a9d:664d:0:b0:6dc:2d7e:b2f4 with SMTP id q13-20020a9d664d000000b006dc2d7eb2f4mr2116207otm.4.1704719082418;
        Mon, 08 Jan 2024 05:04:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJsw+mq7pUDEB0Bq9kX+hhDOVQWcrJXsPRITXHjSedjN0kt38eLG+cS531y0mNTOrAMDIBwzKJXx4sRT8okts=
X-Received: by 2002:a9d:664d:0:b0:6dc:2d7e:b2f4 with SMTP id
 q13-20020a9d664d000000b006dc2d7eb2f4mr2116198otm.4.1704719082117; Mon, 08 Jan
 2024 05:04:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104193303.3175844-1-seanjc@google.com> <20240104193303.3175844-4-seanjc@google.com>
In-Reply-To: <20240104193303.3175844-4-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 8 Jan 2024 14:04:30 +0100
Message-ID: <CABgObfaBJQTm2stHFCsb8g0BKPsnnMYTvPfrqtc8aBmOcOimLQ@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: LAM support for 6.8
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 8:33=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> LAM virtualization support.  FWIW, I intended to send this in early-ish
> December as you've asked in the past, but December was basically a lost c=
ause
> for me in terms of doing upstream work.  :-/
>
> The following changes since commit e9e60c82fe391d04db55a91c733df4a017c28b=
2f:
>
>   selftests/kvm: fix compilation on non-x86_64 platforms (2023-11-21 11:5=
8:25 -0500)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-lam-6.8
>
> for you to fetch changes up to 183bdd161c2b773a62f01d1c030f5a3a5b7c33b5:
>
>   KVM: x86: Use KVM-governed feature framework to track "LAM enabled" (20=
23-11-28 17:54:09 -0800)

Patches are surprisingly small for this. What's the state of tests
(https://www.spinics.net/lists/kvm/msg313712.html) though?

Thanks,

Paolo

> ----------------------------------------------------------------
> KVM x86 support for virtualizing Linear Address Masking (LAM)
>
> Add KVM support for Linear Address Masking (LAM).  LAM tweaks the canonic=
ality
> checks for most virtual address usage in 64-bit mode, such that only the =
most
> significant bit of the untranslated address bits must match the polarity =
of the
> last translated address bit.  This allows software to use ignored, untran=
slated
> address bits for metadata, e.g. to efficiently tag pointers for address
> sanitization.
>
> LAM can be enabled separately for user pointers and supervisor pointers, =
and
> for userspace LAM can be select between 48-bit and 57-bit masking
>
>  - 48-bit LAM: metadata bits 62:48, i.e. LAM width of 15.
>  - 57-bit LAM: metadata bits 62:57, i.e. LAM width of 6.
>
> For user pointers, LAM enabling utilizes two previously-reserved high bit=
s from
> CR3 (similar to how PCID_NOFLUSH uses bit 63): LAM_U48 and LAM_U57, bits =
62 and
> 61 respectively.  Note, if LAM_57 is set, LAM_U48 is ignored, i.e.:
>
>  - CR3.LAM_U48=3D0 && CR3.LAM_U57=3D0 =3D=3D LAM disabled for user pointe=
rs
>  - CR3.LAM_U48=3D1 && CR3.LAM_U57=3D0 =3D=3D LAM-48 enabled for user poin=
ters
>  - CR3.LAM_U48=3Dx && CR3.LAM_U57=3D1 =3D=3D LAM-57 enabled for user poin=
ters
>
> For supervisor pointers, LAM is controlled by a single bit, CR4.LAM_SUP, =
with
> the 48-bit versus 57-bit LAM behavior following the current paging mode, =
i.e.:
>
>  - CR4.LAM_SUP=3D0 && CR4.LA57=3Dx =3D=3D LAM disabled for supervisor poi=
nters
>  - CR4.LAM_SUP=3D1 && CR4.LA57=3D0 =3D=3D LAM-48 enabled for supervisor p=
ointers
>  - CR4.LAM_SUP=3D1 && CR4.LA57=3D1 =3D=3D LAM-57 enabled for supervisor p=
ointers
>
> The modified LAM canonicality checks:
>  - LAM_S48                : [ 1 ][ metadata ][ 1 ]
>                               63               47
>  - LAM_U48                : [ 0 ][ metadata ][ 0 ]
>                               63               47
>  - LAM_S57                : [ 1 ][ metadata ][ 1 ]
>                               63               56
>  - LAM_U57 + 5-lvl paging : [ 0 ][ metadata ][ 0 ]
>                               63               56
>  - LAM_U57 + 4-lvl paging : [ 0 ][ metadata ][ 0...0 ]
>                               63               56..47
>
> The bulk of KVM support for LAM is to emulate LAM's modified canonicality
> checks.  The approach taken by KVM is to "fill" the metadata bits using t=
he
> highest bit of the translated address, e.g. for LAM-48, bit 47 is sign-ex=
tended
> to bits 62:48.  The most significant bit, 63, is *not* modified, i.e. its=
 value
> from the raw, untagged virtual address is kept for the canonicality check=
. This
> untagging allows
>
> Aside from emulating LAM's canonical checks behavior, LAM has the usual K=
VM
> touchpoints for selectable features: enumeration (CPUID.7.1:EAX.LAM[bit 2=
6],
> enabling via CR3 and CR4 bits, etc.
>
> ----------------------------------------------------------------
> Binbin Wu (9):
>       KVM: x86: Consolidate flags for __linearize()
>       KVM: x86: Add an emulation flag for implicit system access
>       KVM: x86: Add X86EMUL_F_INVLPG and pass it in em_invlpg()
>       KVM: x86/mmu: Drop non-PA bits when getting GFN for guest's PGD
>       KVM: x86: Add & use kvm_vcpu_is_legal_cr3() to check CR3's legality
>       KVM: x86: Remove kvm_vcpu_is_illegal_gpa()
>       KVM: x86: Introduce get_untagged_addr() in kvm_x86_ops and call it =
in emulator
>       KVM: x86: Untag addresses for LAM emulation where applicable
>       KVM: x86: Use KVM-governed feature framework to track "LAM enabled"
>
> Robert Hoo (3):
>       KVM: x86: Virtualize LAM for supervisor pointer
>       KVM: x86: Virtualize LAM for user pointer
>       KVM: x86: Advertise and enable LAM (user and supervisor)
>
>  arch/x86/include/asm/kvm-x86-ops.h |  1 +
>  arch/x86/include/asm/kvm_host.h    |  5 +++-
>  arch/x86/kvm/cpuid.c               |  2 +-
>  arch/x86/kvm/cpuid.h               | 13 +++++----
>  arch/x86/kvm/emulate.c             | 27 ++++++++++---------
>  arch/x86/kvm/governed_features.h   |  1 +
>  arch/x86/kvm/kvm_emulate.h         |  9 +++++++
>  arch/x86/kvm/mmu.h                 |  8 ++++++
>  arch/x86/kvm/mmu/mmu.c             |  2 +-
>  arch/x86/kvm/mmu/mmu_internal.h    |  1 +
>  arch/x86/kvm/mmu/paging_tmpl.h     |  2 +-
>  arch/x86/kvm/svm/nested.c          |  4 +--
>  arch/x86/kvm/vmx/nested.c          | 11 +++++---
>  arch/x86/kvm/vmx/sgx.c             |  1 +
>  arch/x86/kvm/vmx/vmx.c             | 55 ++++++++++++++++++++++++++++++++=
++++--
>  arch/x86/kvm/vmx/vmx.h             |  2 ++
>  arch/x86/kvm/x86.c                 | 18 +++++++++++--
>  arch/x86/kvm/x86.h                 |  2 ++
>  18 files changed, 134 insertions(+), 30 deletions(-)
>



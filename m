Return-Path: <linux-kernel+bounces-19580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BD3826F19
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95AA8283B1B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F2941221;
	Mon,  8 Jan 2024 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fe2EfzqT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F6041212
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704718707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lSelulcvnKE/3GrBpLw9pzPjSsB+J8h6YDrw26eu480=;
	b=fe2EfzqTGRaiE1+z1iXtiTnUrWgba+b+Mk2Un3WLl4ij9KbdMxcuRLVVvkfc6yg6gZuy0B
	CLlMkSk7vKgiT+x2kRrEYW1BSnsPCdB5EoreTuE2l6LUPRBzLFY+TGvPtIkKeUdr9FtJ55
	zdcgxTRVDAAw4x8JaQjq/NnvvPzzQbk=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-JvqQnDvLPvGTP5TUgJV2Fw-1; Mon, 08 Jan 2024 07:58:26 -0500
X-MC-Unique: JvqQnDvLPvGTP5TUgJV2Fw-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-7cbe4ce6badso538021241.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 04:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704718705; x=1705323505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSelulcvnKE/3GrBpLw9pzPjSsB+J8h6YDrw26eu480=;
        b=DkPVr4mc47QIX1mDQzp7+eQdFtu2wlKegpIlvBv11HQ2bWm/rexAoJv33qz0PQMmYQ
         CfE1LbaZMv1QFJAT9d1A4TX+l5yVP/vnIp4E/G4uxeW4o7irYgeNnj38NpgzIrpzB4XJ
         KvxJbzPFrc8Vd0jQ6pJ2zZhOvFn+Fl2MIKKP3zyV0bGDk6cAlui3XxtEsTgNRNMLsABy
         m1F8kFKyoB+M6wngOohb8aQT6U8krw+oxXA7uix5HNh1hqUOivACzdIZGFJ60/um8pIF
         qSopbvumPgsl5d74pgJ/YpurGrqH4p0ANA/hZsXtTgILjNCPHXz6HcitdhbtJlootSBR
         ki/g==
X-Gm-Message-State: AOJu0YzAqieOD5mjwLLqC+d4k5qsaeB91HMLAFsQ7SaC/FL1VGD4uChe
	FRdCS+iqig3DO41C6hbDP62MhWsDjCTjX2xtagNuBMIzACtLaWQ9yxhxg2pfNZ5kImp2CrJwOA6
	1TdADK0hqhECTlhFjiKYCeERw6v9Im4s451mC1TAt2EupiYhM
X-Received: by 2002:a05:6102:32c3:b0:467:c620:2ca6 with SMTP id o3-20020a05610232c300b00467c6202ca6mr1052962vss.17.1704718705500;
        Mon, 08 Jan 2024 04:58:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKSVUGs7BVL3BdtFjy45+2FHYrgGv+oG3o6UXZHhFff0T6HCckIodjFGBXnoZK+FlkGMhwHoRTckhVhLLGoSI=
X-Received: by 2002:a05:6102:32c3:b0:467:c620:2ca6 with SMTP id
 o3-20020a05610232c300b00467c6202ca6mr1052956vss.17.1704718705195; Mon, 08 Jan
 2024 04:58:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104193303.3175844-1-seanjc@google.com> <20240104193303.3175844-5-seanjc@google.com>
In-Reply-To: <20240104193303.3175844-5-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 8 Jan 2024 13:58:12 +0100
Message-ID: <CABgObfbGtN5AZrqNAhwT7qawuNZA9UW_CoHDULzT191b=eb78Q@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: Misc changes for 6.8
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 8:33=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> A variety of one-off changes...
>
> The following changes since commit e9e60c82fe391d04db55a91c733df4a017c28b=
2f:
>
>   selftests/kvm: fix compilation on non-x86_64 platforms (2023-11-21 11:5=
8:25 -0500)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-misc-6.8
>
> for you to fetch changes up to 15223c4f973a6120665ece9ce1ad17aec0be0e6c:
>
>   KVM: SVM,VMX: Use %rip-relative addressing to access kvm_rebooting (202=
3-11-30 12:51:54 -0800)
>
> ----------------------------------------------------------------
> KVM x86 misc changes for 6.8:
>
>  - Turn off KVM_WERROR by default for all configs so that it's not
>    inadvertantly enabled by non-KVM developers, which can be problematic =
for
>    subsystems that require no regressions for W=3D1 builds.
>
>  - Advertise all of the host-supported CPUID bits that enumerate IA32_SPE=
C_CTRL
>    "features".
>
>  - Don't force a masterclock update when a vCPU synchronizes to the curre=
nt TSC
>    generation, as updating the masterclock can cause kvmclock's time to "=
jump"
>    unexpectedly, e.g. when userspace hotplugs a pre-created vCPU.
>
>  - Use RIP-relative address to read kvm_rebooting in the VM-Enter fault p=
aths,
>    partly as a super minor optimization, but mostly to make KVM play nice=
 with
>    position independent executable builds.
>
> ----------------------------------------------------------------

Pulled, thanks.

Paolo

> Jim Mattson (2):
>       KVM: x86: Advertise CPUID.(EAX=3D7,ECX=3D2):EDX[5:0] to userspace
>       KVM: x86: Use a switch statement and macros in __feature_translate(=
)
>
> Sean Christopherson (2):
>       KVM: x86: Turn off KVM_WERROR by default for all configs
>       KVM: x86: Don't unnecessarily force masterclock update on vCPU hotp=
lug
>
> Uros Bizjak (1):
>       KVM: SVM,VMX: Use %rip-relative addressing to access kvm_rebooting
>
>  arch/x86/kvm/Kconfig         | 14 +++++++-------
>  arch/x86/kvm/cpuid.c         | 21 ++++++++++++++++++---
>  arch/x86/kvm/reverse_cpuid.h | 33 ++++++++++++++++++++++-----------
>  arch/x86/kvm/svm/vmenter.S   | 10 +++++-----
>  arch/x86/kvm/vmx/vmenter.S   |  2 +-
>  arch/x86/kvm/x86.c           | 29 ++++++++++++++++-------------
>  6 files changed, 69 insertions(+), 40 deletions(-)
>



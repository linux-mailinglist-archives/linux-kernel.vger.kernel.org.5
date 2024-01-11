Return-Path: <linux-kernel+bounces-23848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB3D82B2B5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1471F25534
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEF951002;
	Thu, 11 Jan 2024 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hu35eUdn"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3773A4F88D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e6fe91c706so97343047b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704989873; x=1705594673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MNwF2q8Tqzvuux5qfLzTW373Vk2NJ0AwKrucCR5qckw=;
        b=Hu35eUdnldiKW2QsfHrxLROlSgnpoR+iseAx6uKiUGpvxMkj4KfTc1IjHoxRuNBxLt
         0YH90tkRwUIcgca7S1XETTthQVvK22MN4VrFJkRRM0mpquTr4CZnhx7nExmoa+eyrg+C
         GbQZEYuMitfPEUW5lFEcAQqiHRVsmw8w0mj9hpl5DCYQ0yIv1xk/oBn8IUavDDqhQlGM
         0FogVMCSEYkl7sWPFaNJXQsFqFJO8QfjhtUDiK31JiBuKB82eq2ZYjvRTYBdT4Jh18gl
         WSjlwpm2RFYR7qEEhMCUTqacP5IfIsgS3zUFp7Y6007mZ7nJZnxMKWINpSg8Cq5hnseW
         V8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704989873; x=1705594673;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MNwF2q8Tqzvuux5qfLzTW373Vk2NJ0AwKrucCR5qckw=;
        b=hByrK5T1v8I0d+PuNwoSia/IhFkWL2YnJN/+YityZYHsbaMaWbqh7d4aG1JRmhJY4I
         y7fXKr2LVSywmpW0ioWUFaBD4Kk+f7E4LcI+BD3+rCW+n165caj2F1YdPG87vyGoHJmb
         vzrDpln9ccs3LOUjRzlLKItJybnJxHrLu/raxZFtNo+CQXwn7JH0JSnoMWgamfWJ4VbN
         ZYX8aDKJ+njCqPoc2XjWHOVQOigHJOADWKJr9HgxR84/VFDTTP9A6P602E9tQr3INvMR
         QiAzBBO2LqtFrREBPJljYRtg/QEO3B/9sN3qkAD02KTYmlx6CSU11akKnFaPBqAZdX39
         /Ycg==
X-Gm-Message-State: AOJu0YxGsRxrPRTHJOK8lHz9OlBziLvBa/7qIkAIggONM4Nb8/9VpasU
	dsAOLWiCk9OLiq0232Dt1I+h5u68rZyEbhuUMQ==
X-Google-Smtp-Source: AGHT+IFa/SsdGe2zg7NOzSbhrUyblhd+VvkzxHQSgBRWyN71cgDyQQ2rZIb2G6wErjLtnOfoUM3wHPSIx88=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:8741:0:b0:5de:9c9f:3ee4 with SMTP id
 x62-20020a818741000000b005de9c9f3ee4mr5824ywf.6.1704989873296; Thu, 11 Jan
 2024 08:17:53 -0800 (PST)
Date: Thu, 11 Jan 2024 08:17:51 -0800
In-Reply-To: <CABgObfYqDsFGf4nm_g9Kfbe7heupnLLDWRsnrhh=LNSjFAmqmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240110002340.485595-1-seanjc@google.com> <CABgObfYqDsFGf4nm_g9Kfbe7heupnLLDWRsnrhh=LNSjFAmqmQ@mail.gmail.com>
Message-ID: <ZaAUr7hoG0s28hpX@google.com>
Subject: Re: [PATCH] x86/cpu: Add a VMX flag to enumerate 5-level EPT support
 to userspace
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yi Lai <yi1.lai@intel.com>, 
	Tao Su <tao1.su@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024, Paolo Bonzini wrote:
> On Wed, Jan 10, 2024 at 1:23=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > Add a VMX flag in /proc/cpuinfo, ept_5level, so that userspace can quer=
y
> > whether or not the CPU supports 5-level EPT paging.
>=20
> I think this is a good idea independent of the selftests issue.
>=20
> For selftests, we could get similar info from the feature MSR
> mechanism, i.e. KVM_GET_MSRS(MSR_IA32_VMX_EPT_VPID_CAP), but only on
> Intel and only if nested virtualization is enabled, so that's
> inferior.
>=20
> A better idea for selftests is to add a new KVM_CAP_PHYS_ADDR_SIZE,
> which could be implemented by all architectures and especially by both
> x86 vendors.

Doh.  I was thinking this wouldn't be a problem on AMD, but a guest can gen=
erate
52-bit GPAs even without LA57.

> However, I am not sure for example if different VM types (read: TDX?) cou=
ld
> have different maximum physical addresses, and that would have to be take=
n
> into consideration when designing the API.


Return-Path: <linux-kernel+bounces-24075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD40182B674
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23251C21133
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060765812C;
	Thu, 11 Jan 2024 21:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A0pJnAwl"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E088056B78
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 21:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso738a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 13:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705007560; x=1705612360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXKMeHE0UqYe035FlRaJ7XqcpRM1yLnLjZRHyMyh4RI=;
        b=A0pJnAwlc3jj58tN5TdixN1NUYwmxPk28pfOGrjL/cjQ/JWFR+GjcW5PqyGpl+J3PL
         wKnXWxQ7LzlzX5GFAy5fRe7C88aq7eRfYnfsqqqDP1aVLjbOqumFCXTx5b+n7K5U4EyF
         W0Ix5ITX8CzYtCeVIcDY1QmiL1nv+qiMKyYJvg4eNsV8t+NljbVZ3DqUxjLNqR5TV+IL
         89MlpkLvDwCFlxedRJcwG+N4puB8WMvommLG6los0YBDVoF9dJjbRfQvbeOx9CVNrlSe
         HyOfizhxezj8RuP6EOAxvtN5b+cBxjunRaB1lwcj6ntvoSn16hVK8afJi+hReOqUTYzJ
         mLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705007560; x=1705612360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXKMeHE0UqYe035FlRaJ7XqcpRM1yLnLjZRHyMyh4RI=;
        b=Robv9+S1jI3ajYLgt4t1a3/20oTBorxe3FZN55UJyXW1cPEJshVzPgal2AtRlMLb5X
         CEqCXGsRvA1ixBWkSeq4FXnvNUJlfn1SY2HI2Jji5PmHgmbNv5nlXiPDwhztvGLpberV
         7iHgybUGPzaYwGAxwmInwgtmO96hz+swxiu21pTiQ1uqb6ManVODSaQQZ0jXqPq5xj47
         p2fkkABURVjPGqifqyJFwHs0hV9NbyoQcHfgRMZlOYc9x/UQhX7nVwieOhEqE6sT8j3P
         AIfXQr4vZ3i5gtxElR6TeJDasKvJ3AiivbcxaqMuZd4d0c1J2DvYP+fxZFdl26GZt1/p
         XlwQ==
X-Gm-Message-State: AOJu0Yw7QXIiZUePD00vKFACkCGYFXg4Ji4Lq5/I2ns5r+hC31F/bMt2
	Lhk5bO1vMC7R63UQ2cMcdfcz03eifPER3OcsMGrSsyeU/sfW
X-Google-Smtp-Source: AGHT+IFA1psE8PhsjwaWCXa6scrGZNo5bxthRkTx7YaDJIkZjv5TnCu2SGzCwTWoqP9VFprLwwk3ZRTim4wWr+rUtNw=
X-Received: by 2002:aa7:d9d6:0:b0:557:3c8a:7242 with SMTP id
 v22-20020aa7d9d6000000b005573c8a7242mr192200eds.3.1705007559991; Thu, 11 Jan
 2024 13:12:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110002340.485595-1-seanjc@google.com> <ZZ42Vs3uAPwBmezn@chao-email>
 <ZZ7FMWuTHOV-_Gn7@google.com> <ZZ9X5anB/HGS8JR6@linux.bj.intel.com>
 <ZaAWXSvMgIMkxr50@google.com> <CABgObfaByKFKRtLpY1yAJFmcY1WxWcn3tpeVw7Nho+qk0PFUbQ@mail.gmail.com>
In-Reply-To: <CABgObfaByKFKRtLpY1yAJFmcY1WxWcn3tpeVw7Nho+qk0PFUbQ@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 11 Jan 2024 13:12:24 -0800
Message-ID: <CALMp9eQzZkGsg2aUeK0vy--qOGCOXpHByGrNK4SFU38jYQZT9A@mail.gmail.com>
Subject: Re: [PATCH] x86/cpu: Add a VMX flag to enumerate 5-level EPT support
 to userspace
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, Tao Su <tao1.su@linux.intel.com>, 
	Chao Gao <chao.gao@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Yi Lai <yi1.lai@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 12:02=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> On Thu, Jan 11, 2024 at 5:25=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > > It is unusual to assign a huge RAM to guest, but passthrough a device=
 also may trigger
> > > this issue which we have met, i.e. alloc memslot for the 64bit BAR wh=
ich can set
> > > bits[51:48]. BIOS can control the BAR address, e.g. seabios moved 64b=
it pci window
> > > to end of address space by using advertised physical bits[1].
> >
> > Drat.  Do you know if these CPUs are going to be productized?  We'll st=
ill need
> > something in KVM either way, but whether or not the problems are more o=
r less
> > limited to funky software setups might influence how we address this.
>
> Wait, we do have an API for guest physical address size. It's
> KVM_GET_SUPPORTED_CPUID2: the # of bits is in leaf 0x80000008, bits
> 0:7 of EAX. In fact that leaf is what firmware uses to place the BARs.
> So it just needs to be adjusted for VMX in __do_cpuid_func, and looked
> up in selftests.

We've discussed this. The only *supported* value for guest.MAXPHYADDR
is host.MAXPHYADDR.

If EPT doesn't also support that value, then the only *supported*
configuration is shadow paging.

If someone wants to run with scissors, that's fine, but don't abuse
KVM_GET_SUPPORTED_CPUID2 to return an *unsupported* configuration.


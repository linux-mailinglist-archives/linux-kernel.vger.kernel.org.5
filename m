Return-Path: <linux-kernel+bounces-101135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9DD87A2EC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7D41F22499
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 06:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797F013AD9;
	Wed, 13 Mar 2024 06:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhYCXFI0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EEE134AD;
	Wed, 13 Mar 2024 06:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710310871; cv=none; b=B69OI5CtYgD1/8mD2Wdm/UFFSHfn/3gpm9owL+G0D2jIKbNInX4t4/sA75sFxrPqdfn8lifCzZa+aAQN9kfahDhgrq6Kbff7hL8Z9dseNqLD0ZnRsby87nrTR8QHKYgJn1KHyAaO2ELzNvHSCGiiJZTO3cQgOleD7CdyoD0+igU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710310871; c=relaxed/simple;
	bh=EPw8e/w2xSm3NHGve5v9/ek70f9QhUmv8BOnvxYj4Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPHaixHpNvFTX/B+qyXRHUEwS2mRB1YPPF18fJaWELJQ9iTettEPaQOWaA6aynNPmYb92LzfciXx69y6x+A4IUV4X94FK24K9gi18OwrKHlREowcXcHL7aKqrqnYkn+Oi02z6Oo+Nc8DbnvTv703JFtHQuT3jpNFGVMQIzBcdb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhYCXFI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DB4C43394;
	Wed, 13 Mar 2024 06:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710310871;
	bh=EPw8e/w2xSm3NHGve5v9/ek70f9QhUmv8BOnvxYj4Xo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FhYCXFI0QI/o3Gj2Bo+N15oaw6m38zRgPEB6NroGStto3CyuGayLWOWUL/E4siQI8
	 9s39DhDXfZ+8Lwd0nh4iyboF1XsscFXuELPTyk44qk3d/m/dfKn4DXqYcs4ViL5gYL
	 0gfQCag92xpjVmoXye1b5uvyL6Rypu0wQab/syoFJx2+Wf+/KowhOHSxGY/PKweiBX
	 QbGrT1Q87DVWrj5/WmKOqJtREUC9WKUhnxo53gAO0O6wz9/G/jzgJfEp2FpgxW2Lc+
	 8GwQuV3bDk/6SYWWVY6WUveiojbh/FqGccnkhw3pgCkpXJNbyGqsGkjA4ebeix4mR/
	 FgFhlaVMKbphA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51323dfce59so4631579e87.3;
        Tue, 12 Mar 2024 23:21:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWUwxv7zdEOmqQVaRc/p7wrWYvHJf74Q+6IdcaQ9at7MgWKYUmSh8UKCz7K5iZ7cSdKhu4ers5RfsaPYpJx9EUGaCRzzQ9huhWVJMF2PLZT4qR5LFebWnOQutX87a+rjcvAvP3oOdV81w==
X-Gm-Message-State: AOJu0YzopidVaqIxih0HG+dXcDZ3R4NkatAYqo6yDhwu0pE5rs4yVAc5
	NfSkIHZlZ9Wnb3v+ieXbQ6AoXWkJaR8Vl0bojQSckRyY9b0va9FCwQ6zJMPhrGklYlFAU1aI7AX
	cUYxYbWqf3UmQS4JS9Um88D8fW5I=
X-Google-Smtp-Source: AGHT+IGgtSaFsoXuyPfMfrQ74aFVHUDiMTCWWAU+KEtddvyBQBjy2sz9m7lnXhzYDoKzDxYRLNrLYdEULpa1L3x6lzU=
X-Received: by 2002:a05:6512:34ce:b0:513:4766:2713 with SMTP id
 w14-20020a05651234ce00b0051347662713mr7384351lfr.59.1710310869358; Tue, 12
 Mar 2024 23:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130082722.2912576-1-maobibo@loongson.cn> <20240130082722.2912576-4-maobibo@loongson.cn>
 <87a5o4iti4.ffs@tglx>
In-Reply-To: <87a5o4iti4.ffs@tglx>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 13 Mar 2024 14:20:58 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6Qqz54yQ8uehjx+jEhwCzNzeFfN=gHttLaq_xYQJZchg@mail.gmail.com>
Message-ID: <CAAhV-H6Qqz54yQ8uehjx+jEhwCzNzeFfN=gHttLaq_xYQJZchg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] irqchip/loongson-eiointc: Refine irq affinity
 setting during resume
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sergey Shtylyov <s.shtylyov@omp.ru>, lvjianmin@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Thomas,

On Tue, Feb 13, 2024 at 5:49=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Tue, Jan 30 2024 at 16:27, Bibo Mao wrote:
> > During suspend and resume, CPUs except CPU0 can be hot-unpluged and IRQ=
s
> > will be migrated to CPU0. So it is not necessary to restore irq affinit=
y
> > for eiointc irq controller when system resumes.
>
> That's not the reason. The point is that eiointc_router_init() which is
> invoked in the resume path affines all interrupts to CPU0, so the
> restore operation is redundant, no?
I'm sorry for the late response but I think this is a little wrong.
When irq_migrate_all_off_this_cpu() is called at hot-unplug, if an
irqdesc is irqd_affinity_is_managed() then its affinity is untouched
(doesn't change to CPU0). Then after resume we should not keep its
affinity on CPU0 set by eiointc_router_init() , but need to restore
its old affinity.

Huacai

>
> > This patch removes this piece of code about irq affinity restoring in
> > function eiointc_resume().
>
> Again. 'This patch' is pointless because we already know that this is a
> patch, no?
>


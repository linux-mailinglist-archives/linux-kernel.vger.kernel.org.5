Return-Path: <linux-kernel+bounces-103405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D1B87BEFE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862BA1C21066
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86CA2A8D0;
	Thu, 14 Mar 2024 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqF6Mctb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1557B1D69C;
	Thu, 14 Mar 2024 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710426867; cv=none; b=ViHExBnWRZI3MOTy5h7Wd1vlYvtjGqYcknXjuy0CklUwALTkWaDPr9Xh46yjvOghpqFRrmd9arH8AlbmQ1lYDM1q1xweTB2VDuZnnXJXSL5QpaTY/wyKMcDV349Eq1jdLZAslnGFjldTooEZsOHr8F95im+Za8FG3NZVKkgtKaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710426867; c=relaxed/simple;
	bh=F1z0AfWKlLkkCun7/hMCnmPAH+tmcKjyoADj3DnOJQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWd3QJFONre+e+8ir/olEc3jnvdD6Rc+FIe7CLBrIzwkTfYqsSKQXNJtQb+YP48Rla5RJ3hZC0MoeP903a+9NIi1SzUS14yhp/ZD5R6JaxQtZLhelwxkwsZE4jU4CjZU/9njF3ta0BP5vK4cuMzduRb/f8WCUXG4JHf6wOrwTO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqF6Mctb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8A3C43394;
	Thu, 14 Mar 2024 14:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710426866;
	bh=F1z0AfWKlLkkCun7/hMCnmPAH+tmcKjyoADj3DnOJQA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QqF6Mctb0ZgUTjLC36sBWQEf4dLFp2woGaTMecGs39y9ItZbc/dUmbU5mb1nD/h9n
	 FRXtWDV4UcUt6q+q4R5QoY189nTuv/201q1K9Q39lSkgoRDf8tJfbjeFvECcPX3W6s
	 B/HZfBpAewPSVrRJkuKlC6qAwmGcJLBmK0FwMSBc5kPCgCDFii1KtB/bx5QFfChkrV
	 1zc95vpZ3IwdTtaVgTZPDndkzmKmKZQE5+eZo7XlqhG3DFQvIPrkmEmH0UWqHKZSQa
	 pxYUt3XRZ4b6DQYS6s+nlNKm53CZYF5inaZoiq+mh2rqOhPPFbbCpZK53SQlPtN24l
	 WhjmOVavl1TqA==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a466381b411so121500466b.2;
        Thu, 14 Mar 2024 07:34:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+dJGH2xNtcwxYQheVzGbF3i28OxI5qwkwp+i89x1McIfEF74qvfjHg/p4ZMJiZNR2NDslDSNkhuwi9ZhEdhnwTk8GPIRpf0D2cAD4gi0mWa/C6M5cMMWjMs4UEC8mtCMJGIMdplj1sg==
X-Gm-Message-State: AOJu0YxRCKp7jveREmNTBH9yeb0ejczwbzd0Ef/W5d7PuB8mjNQnjIIA
	d59Av1wNiRONjp1HISeJTauLHDjmd6ugmaahSKNCl/ElcmJxAWN0hBl0xvW7SVNdldwm9f3DB/G
	TRkPKt8Tx7f0EAaD44XUgJrpzdk4=
X-Google-Smtp-Source: AGHT+IGui5mhpgq3DAIBkBqfQISdum5e9FrUH3asnZUzgWlVyRtkONMs6/1BduAhfCxBQjRS/chHd3dIzSEspmytxGA=
X-Received: by 2002:a17:907:208a:b0:a46:636a:2c23 with SMTP id
 pv10-20020a170907208a00b00a46636a2c23mr677266ejb.34.1710426865460; Thu, 14
 Mar 2024 07:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130082722.2912576-1-maobibo@loongson.cn> <20240130082722.2912576-4-maobibo@loongson.cn>
 <87a5o4iti4.ffs@tglx> <CAAhV-H6Qqz54yQ8uehjx+jEhwCzNzeFfN=gHttLaq_xYQJZchg@mail.gmail.com>
 <87plvynw5b.ffs@tglx>
In-Reply-To: <87plvynw5b.ffs@tglx>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 14 Mar 2024 22:34:15 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5_13RfWdmYFpw82iR-au6PBLqKUvEbwG+A2Q=8=0r=Ng@mail.gmail.com>
Message-ID: <CAAhV-H5_13RfWdmYFpw82iR-au6PBLqKUvEbwG+A2Q=8=0r=Ng@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] irqchip/loongson-eiointc: Refine irq affinity
 setting during resume
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sergey Shtylyov <s.shtylyov@omp.ru>, lvjianmin@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 8:39=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Wed, Mar 13 2024 at 14:20, Huacai Chen wrote:
> > On Tue, Feb 13, 2024 at 5:49=E2=80=AFPM Thomas Gleixner <tglx@linutroni=
x.de> wrote:
> >>
> >> On Tue, Jan 30 2024 at 16:27, Bibo Mao wrote:
> >> > During suspend and resume, CPUs except CPU0 can be hot-unpluged and =
IRQs
> >> > will be migrated to CPU0. So it is not necessary to restore irq affi=
nity
> >> > for eiointc irq controller when system resumes.
> >>
> >> That's not the reason. The point is that eiointc_router_init() which i=
s
> >> invoked in the resume path affines all interrupts to CPU0, so the
> >> restore operation is redundant, no?
> > I'm sorry for the late response but I think this is a little wrong.
> > When irq_migrate_all_off_this_cpu() is called at hot-unplug, if an
> > irqdesc is irqd_affinity_is_managed() then its affinity is untouched
> > (doesn't change to CPU0). Then after resume we should not keep its
> > affinity on CPU0 set by eiointc_router_init() , but need to restore
> > its old affinity.
>
> Affinity is restored when the interrupt is started up again, so yes the
> affinity setting should not be changed.
OK, thanks.

Huacai


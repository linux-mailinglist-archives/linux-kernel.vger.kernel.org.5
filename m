Return-Path: <linux-kernel+bounces-83656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4D2869CDC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE5D1C2415E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786DE219EA;
	Tue, 27 Feb 2024 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L06IGUwV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B674020DD3;
	Tue, 27 Feb 2024 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052822; cv=none; b=W/cDyk6Bw1rsxen8j876esu4VoPhaPAS5wtzY0wMIZfSPFm/Lrdx8/Pu8G8p7Ud8VyDBal/4hPxmJHJF6JgL0tYzQdc++ny/DoHIS2nmZmaiff2Mr3FpvCc0tMX1R75y048h1AI6KeWZlOL8Ur9GspytzAQMMXScZKgwynGDk1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052822; c=relaxed/simple;
	bh=rTVznIzRoo7ftBFMSk3M6Jhh3OfJTP2NXWI3JNzboA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+KWG2vA5PCR7Fs4IEBAQAHtpfx9FvWwc/7b+qKn43rL6BLVC9mPHuvGKqL/YRUANWbgbw85SGQOatCDiZWdYmwOr0Txtxds3osmylRgJMWszEzPS+3+WZN9SP0FdHFEGgLT0MO+RVYpwlAACxIJkYSDYHTIvj7oy1QUORDu2yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L06IGUwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C975BC433C7;
	Tue, 27 Feb 2024 16:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709052822;
	bh=rTVznIzRoo7ftBFMSk3M6Jhh3OfJTP2NXWI3JNzboA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L06IGUwViZdc6tmmuKSKWefjzHwXE3dvZ/jMg0VJIpADs+24U8auHGPZTkVqHxhUu
	 E4Y+aYrJKr+5615JhB3YpqECQ3sjv3ORArxjtuVWycDK2voWCiSVyUf77OAnJHWHGS
	 Prf5TaX3JYyLLwie9Rny0/8NbFC/OjiluOZAlq056YVScw/U1ZFCdOPYtlukIfVqJO
	 cU4sX/KZITTdg82DMiPrLshpB3IJZzrJGA7iPNxE2kooQAYwphqbM2ViFCM5HjhxVi
	 yD9mI4Sl799Arp3ARhaQi+UfuUWbrYYZV602ZOiFXI/m+B9aYQ2tnpot5SaPWsmCoL
	 Y1x1gkB+/wwBg==
Date: Tue, 27 Feb 2024 10:53:39 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Gross <agross@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Guru Das Srinagesh <quic_gurus@quicinc.com>, 
	Andrew Halaney <ahalaney@redhat.com>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Deepti Jaggi <quic_djaggi@quicinc.com>
Subject: Re: [PATCH v7 08/12] firmware: qcom: qseecom: convert to using the
 TZ allocator
Message-ID: <odnisr4flot3rgwwqpjob3qtw63jow7hcj4guy6ao6spdz6fm4@wtcm62o3hgxm>
References: <20240205182810.58382-1-brgl@bgdev.pl>
 <20240205182810.58382-9-brgl@bgdev.pl>
 <yu5uhamdlygti3jo73ipy3gxhcmgxrm5g6imgqg6ksleim4ton@npvzlex2j4xi>
 <CAMRc=Mctm-cyYPpu-Vb+fr1cWJPUW49shaa9HEXYp+rkF_CHUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mctm-cyYPpu-Vb+fr1cWJPUW49shaa9HEXYp+rkF_CHUw@mail.gmail.com>

On Tue, Feb 20, 2024 at 10:54:02AM +0100, Bartosz Golaszewski wrote:
> On Sun, Feb 18, 2024 at 4:08 AM Bjorn Andersson <andersson@kernel.org> wrote:
> >
> > On Mon, Feb 05, 2024 at 07:28:06PM +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Drop the DMA mapping operations from qcom_scm_qseecom_app_send() and
> > > convert all users of it in the qseecom module to using the TZ allocator
> > > for creating SCM call buffers.
> >
> > This reads as if this is removal of duplication, now that we have the TZ
> > allocation. But wasn't there something about you not being able to mix
> > and match shmbridge and non-shmbridge allocations in the interface, so
> > this transition is actually required? Or did I get that wrong and this
> > just reduction in duplication?
> >
> 
> What is the question exactly? Yes it is required because once we
> enable SHM bridge, "normal" memory will no longer be accepted for SCM
> calls.
> 

This fact is not covered anywhere in the series.

> > > Together with using the cleanup macros,
> > > it has the added benefit of a significant code shrink.
> >
> > That is true, but the move to using cleanup macros at the same time as
> > changing the implementation makes it unnecessarily hard to reason about
> > this patch.
> >
> > This patch would be much better if split in two.
> >
> 
> I disagree. If we have a better interface in place, then let's use it
> right away, otherwise it's just useless churn.
> 

The functional change and the use of cleanup macros, could be done
independently of each other, each one fully beneficial on their own.

As such I don't find it hard to claim that they are two independent
changes.

> > > As this is
> > > largely a module separate from the SCM driver, let's use a separate
> > > memory pool.
> > >
> >
> > This module is effectively used to read and write EFI variables today.
> > Is that worth statically removing 256kb of DDR for? Is this done solely
> > because it logically makes sense, or did you choose this for a reason?
> >
> 
> Well, it will stop working (with SHM bridge enabled) if we don't. We
> can possibly release the pool once we know we'll no longer need to
> access EFI variables but I'm not sure if that makes sense? Or maybe
> remove the pool after some time of driver inactivity and create a new
> one when it's needed again?
> 

Sounds like a good motivation to me, let's document it so that the next
guy understand why this was done.

Regards,
Bjorn

> Bart
> 
> [snip]


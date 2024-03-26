Return-Path: <linux-kernel+bounces-119445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EBF88C907
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5017EB27D6F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E3913CAB2;
	Tue, 26 Mar 2024 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6C92dz6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E73B13CA98;
	Tue, 26 Mar 2024 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470027; cv=none; b=Fw4GL4TrfuRDdq7Gpqb6IDhhkJ4Mr6nXSTj5g5tjPHpKviFSvVwNqdAXVa7qbDwdMqt7ZXcQu+zeNFL2g8mbismeGw0d38j/6BDO1lOdCvD+1okBB/7ZccwyTkHUuh4XdfNqHtPSGGzgcg2RhwXMDGjmlsG1KVRcP+rlTaO63wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470027; c=relaxed/simple;
	bh=tH7ShG5e19q5dk8DGs/7rFZaClfulgISrGFPuWcP0mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWAkjnaQ1RMfxJ58iRTpgBFDJVYthH8VLGqhuMzy8ShmMWfbB0sREts2gNmmNku0lYma4XhaWgAmoud6U135rXq1jjTPvZhHJn1Vneiqj5Rz+tl3i3Rtc+C0/CYv9aaa3IRjD07a2R0IF3vhoe9mEfnitb08LSet+FGkD++e8lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6C92dz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EE8C43394;
	Tue, 26 Mar 2024 16:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711470026;
	bh=tH7ShG5e19q5dk8DGs/7rFZaClfulgISrGFPuWcP0mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e6C92dz6raZp0WrjtLHCxqpCcVWV3awH3jwOkT/LShocw+towYCYzHIpMxVqVR6ci
	 S4vUVgmYGNay0dotswGf42xd6YmI7FN3UtHnq6i4yoeLo+CYBvI39oh+zvkPu/nwP6
	 ze88G0lKQJKrmGrEVoi348mOb39+eZjNn3WGMk9Elebb301GZ8pneFWt9kNFD/0BoR
	 C2ADW6obNGlsFyXcw3F6Z0qvBucbUllRtd/Dd06q/8Xx85VfeplO6YXdN3Kd3Ia0RI
	 O4dyir2E/RrcwhToChH4LNMoUI3HwPM4CWyWULbzkCZysMCLqQdXDQiswmdtYCXJOZ
	 munyLNIT7r7zQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rp9XO-000000006Yi-1ZUs;
	Tue, 26 Mar 2024 17:20:35 +0100
Date: Tue, 26 Mar 2024 17:20:34 +0100
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Subject: Re: [PATCH] Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode
 exists in DT"
Message-ID: <ZgL10ur0825LgWVK@hovoldconsulting.com>
References: <CABBYNZJ0ukd_8=SFzy8CEwgP7hV5unodca0NZ2zDZh+jPJsEFQ@mail.gmail.com>
 <ZgGzWWV4Lh2Nal--@hovoldconsulting.com>
 <CABBYNZJaXUhu1A+NyVT-TAJw49zcV6TMdGeVy2F+AVKWBOVC-g@mail.gmail.com>
 <ZgHVFjAZ1uqEiUa2@hovoldconsulting.com>
 <CABBYNZJUVhNKVD=s+=eYJ1q+j1W8rVSRqM4bKPbxT=TKrnZdoQ@mail.gmail.com>
 <ZgHbPo57UKUxK7G8@hovoldconsulting.com>
 <CABBYNZJFzDaLdXsdNEP1384JaJEN5E78cgmWfOus_LGOREGsWA@mail.gmail.com>
 <ZgJ0okobGv5nPreG@hovoldconsulting.com>
 <CABBYNZKJJuPHEwyXFRi8Z=P0GyaY-HdamsxmV8sR+R97ETTmEg@mail.gmail.com>
 <ZgLnOHiCzo5AQzra@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZgLnOHiCzo5AQzra@hovoldconsulting.com>

Hi Luiz,

On Tue, Mar 26, 2024 at 04:18:16PM +0100, Johan Hovold wrote:
> On Tue, Mar 26, 2024 at 10:17:13AM -0400, Luiz Augusto von Dentz wrote:
> > On Tue, Mar 26, 2024 at 3:09 AM Johan Hovold <johan@kernel.org> wrote:
> > > On Mon, Mar 25, 2024 at 04:31:53PM -0400, Luiz Augusto von Dentz wrote:

> > > > All the
> > > > CI automation is done on bluetooth-next and if you are asking to be
> > > > done via bluetooth tree which is based on the latest rc that is not
> > > > how things works here, we usually first apply to bluetooth-next and in
> > > > case it needs to be backported then it later done via pull-request.
> > >
> > > The revert fixes a regression in 6.7-rc7 and should get to Linus as soon
> > > as possible and I assume you have some way to get fixes into mainline
> > > for the current development cycle.
> > 
> > Yeah I will send it later today to be included in the next rc release
> > and since it is marked for stable that shall trigger the process of
> > backporting it.
> > 
> > > The series fixes a critical bug in the Qualcomm driver and should
> > > similarly get into mainline as soon as possible to avoid having people
> > > unknowingly start relying on the broken behaviour (reversed address).
> > > The bug in this case is older, but since the bug is severe and we're
> > > only at rc1, I don't think this one should wait for 6.10 either.

I just double checked the bluetooth-next branch and everything looks
good now (revert + endianness fix series). Thanks!

Did I understand you correctly that you'll be able to get all five
commits into 6.9 during this development cycle (e.g. 6.9-rc2)?
 
Johan


Return-Path: <linux-kernel+bounces-85201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F16E86B226
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C2F2B25CED
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F47F612FC;
	Wed, 28 Feb 2024 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Dst0ycDr"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E852F15A4B0
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131452; cv=none; b=AF31ILDVBlHRkWA2pU4qOXOz5gTBIPzCDqLAZns+ncZzh+ea7OolQ1BOLr8ogEq6U73OcGdoxAWRg3EowL0nsDBnojmLvhnFNLniSQklXVCV9/ocsqUeiW258I8ySkZVxW4vb2Q/fS3XMD+DGZ0xDu0WRF0hXjbvieAsY/5p568=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131452; c=relaxed/simple;
	bh=rgyFRb2qJ/LTVeYOGlUVm9UR8z2N1d7h6w79Dmp9Ppg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJybveevCWs4rKWcOyw2IY28XP5066iSJ4anFB6VuMw7TooLWZ3m8k9VwB1m5VQWXVC+36vn/kDNhfI+aAssioLFgoGb/4jJi04JOpbDas7ZCJdgctkdINNa6hIaME/IE4PI5HHI5jZAQg62z0kVdMzW3tlHqrUtsqPNHtPjDtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Dst0ycDr; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709131448;
	bh=rgyFRb2qJ/LTVeYOGlUVm9UR8z2N1d7h6w79Dmp9Ppg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dst0ycDrdetbBG5Wnte7R6a20PkjM4HySfNehnxSczktkhVi7nQFMFnSZPOUDyoXq
	 YNbrqS412UlF/fOzoT11/dQi9I1tA9syE72Fw1oeT3dqa+9nV6cZss1Iu/yq1jITGx
	 W+/0hrQN4gSC3F/XCb2Snlpy+GESeJj21ZXX6yeA4zDNzjlFWcYXnpvFd5ZLmnu3Gg
	 5l5zdloEiM05JmznCcWiKuL3mTJAkgBDhz5T73ljZpLtb/9rQ+r4maUmUD6nJE0gK1
	 Iok4PQA+IqJFsMFLSfiKclw8ZxgMVBnwuHN2cehlud74SqG08clxHyIrE4x2fnTl2z
	 wmMOZHZBBaJkg==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 50252378204B;
	Wed, 28 Feb 2024 14:44:06 +0000 (UTC)
Date: Wed, 28 Feb 2024 09:44:04 -0500
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] soc: mediatek: cmdq: Don't log an error when
 gce-client-reg is not found
Message-ID: <957b44d3-ef48-4682-8db5-3261e582ac8f@notapiano>
References: <20240226-gce-client-reg-log-dbg-v1-1-f0fff97c30c7@collabora.com>
 <6389f1e3-57b2-453a-af6f-6bc7f725ad31@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6389f1e3-57b2-453a-af6f-6bc7f725ad31@collabora.com>

On Wed, Feb 28, 2024 at 10:41:15AM +0100, AngeloGioacchino Del Regno wrote:
> Il 26/02/24 22:31, Nícolas F. R. A. Prado ha scritto:
> > Most of the callers to this function do not require CMDQ support, it is
> > optional, so the missing property shouldn't cause an error message.
> > Furthermore, the callers that do require CMDQ support already log at the
> > error level when an error is returned.
> > 
> > Change the log message in this helper to be printed at the debug level
> > instead.
> 
> CMDQ is optional, yes. At least, for some devices it is.
> 
> Full story, though, wants that if you use the CPU for register manipulation
> instead of programming the GCE (even with threading, fantastic!) you will
> trigger various performance issues.
> 
> In the end, you *don't want* to use the CPU if GCE is available!
> 
> The reasons why the CMDQ/GCE is optional are:
>  - You can check register-by-register r/w for debugging scenarios by using
>    the CPU to manipulate them instead of having something magically doing
>    that for you at a certain (pre-set, yes, but still!) point;
>  - Not all SoCs have the same amount of GCE threads and channels, some may
>    support writing to IP block X through the GCE, some may not, but both
>    may support writing for IP block Y through this mailbox;
>  - MediaTek chose to support both ways, enabling means to debug stuff upstream,
>    the other choice would've been to never support CPU register R/W on some IPs
> 
>    ... and btw - about the last part: Kudos, MediaTek.

Thank you for all the insight! :)

> 
> Now, I also get why you're raising this, but we have to find an agreement here
> on a different way to proceed that satisfies all of us.
> 
> First of all..
> 
> Which device on which SoC is missing the GCE client register DT property?
> Do said SoC really not have a GCE client register for that device?

This is what I see:

On mt8192-asurada-spherion:
mediatek-mutex 14001000.mutex: error -2 can't parse gce-client-reg property (0)

On mt8195-cherry-tomato:
mtk-mmsys 14000000.syscon: error -2 can't parse gce-client-reg property (0)
mtk-mmsys 14f00000.syscon: error -2 can't parse gce-client-reg property (0)
mediatek-mutex 1c016000.mutex: error -2 can't parse gce-client-reg property (0)
mtk-mmsys 1c01a000.syscon: error -2 can't parse gce-client-reg property (0)
mediatek-mutex 1c101000.mutex: error -2 can't parse gce-client-reg property (0)

So yes, there are a few missing. I will send patches adding them so we can get
the best performance possible upstream.

> 
> Is any upstream supported SoC really lacking a GCE register for the upstream
> supported IPs?
> 
> I'm not sure.... :-)
> 
> P.S.: I guess that the alternative (that I somewhat dislike, and you can probably
>       understand why after reading the reasons above) would be to turn that into a
>       dev_info() instead...
> 
> P.P.S.: Having no GCE usually means that there's a performance issue! In that case,
>         it's ... a mistake, so, an error, kind-of.... :-)

Given the performance impact, I agree that debug, and even info level is not a
good option. At the same time, the hardware still works correctly without the
GCE (as we have been running it so far without even realizing!), so I think
calling it an error is too much, and a warning would be the most suitable level,
as we just want to warn userspace: "Hey user, be advised that you're missing
GCE, so you'll get worse performance! It will still work though". What do you
think?

Thanks,
Nícolas


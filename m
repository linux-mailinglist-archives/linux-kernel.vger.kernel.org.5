Return-Path: <linux-kernel+bounces-130610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6800897A7E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146281C26E58
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CF615667B;
	Wed,  3 Apr 2024 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qcAhwz51"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453A0156663;
	Wed,  3 Apr 2024 21:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712178829; cv=none; b=qeRTy0JSyeYphvEPhpYUG/F0l1/qiziSJL2kUVrpg3aTom7M3SIjWjxHJnNk/xu/lqYKYQQ3jIcYrXcezNmo9YoRKE4nlYo3RUnhOrBMLXbUBh5elTtfGhYRhdkXikwxeVRYFCtuP4zWiKmc0GfKo8fRIELcyHuYghqdy0WwMxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712178829; c=relaxed/simple;
	bh=A63swF0NGtwa4y1vtkAq5Zk0Yp4g068uJTxXmn8Afd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCK5xuEud2NM0w4azvYmJ6/vIJYBzwzhtBZeeD5mtqhx59z64+dtf3pWFDRct9UDaNgr2Toov2/1LoFvXa21G5QngEp/EubH7hu/OANDRoxs7a6UQDg81l9Bp3ZjaqhKrHNZC2mE2wDv8ncuVi4e73/rZ+RQDJ8wi8B2x1tFfos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qcAhwz51; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712178826;
	bh=A63swF0NGtwa4y1vtkAq5Zk0Yp4g068uJTxXmn8Afd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qcAhwz51NDjcmLMjMRi/zox0xmX5lsI1Rr2tTZrzWWWz/9mA7LSbVYz7Hci7Ew4id
	 1F7eNbZHsZso1j8597z0gnhOB8G6qhf/bEoC9OWds0qh41gOSYgucuV2xsD/fMBtBq
	 OUT4w3neJyVb2a/SrrOFqhS/EuYHrGwnz8POAoWXEp0BYpbCkDysX374Ltr6fVCcWR
	 2UCnKyQUGH4Ux70SdvGPzJxtCnvKogTLbbZe4ZSOWA/hW2oh9jnF983jUT8Jj8KG8N
	 1bodhTlhcLUDNF/q4hDH4lT9A5jg7ZBffRxgBM/5OB0beTb8wHbhUyQ4qNMqohTONx
	 AhEn/qVTSBHrA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dbrouwer)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C1DD237813DC;
	Wed,  3 Apr 2024 21:13:45 +0000 (UTC)
Date: Wed, 3 Apr 2024 14:13:43 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Shreeya Patel <shreeya.patel@collabora.com>, mchehab@kernel.org,
	hverkuil@xs4all.nl, hverkuil-cisco@xs4all.nl, heiko@sntech.de,
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	p.zabel@pengutronix.de, shawn.wen@rock-chips.com,
	kernel@collabora.com, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-arm@lists.infradead.org
Subject: Re: [PATCH v3 0/6] Add Synopsys DesignWare HDMI RX Controller
Message-ID: <Zg3Gh8P97GaBtgAB@mz550>
References: <20240327225057.672304-1-shreeya.patel@collabora.com>
 <35e566-660d2080-1-7eb9eb00@16488675>
 <a2f88176-b4e1-4202-843c-a00c5a2b1622@linaro.org>
 <35f774-660d3b80-3-513fcf80@97941910>
 <86150c89-11d5-4d52-987e-974b1a03018f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86150c89-11d5-4d52-987e-974b1a03018f@linaro.org>

On Wed, Apr 03, 2024 at 01:24:05PM +0200, Krzysztof Kozlowski wrote:
> On 03/04/2024 13:20, Shreeya Patel wrote:
> > On Wednesday, April 03, 2024 15:51 IST, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> > 
> >> On 03/04/2024 11:24, Shreeya Patel wrote:
> >>> On Thursday, March 28, 2024 04:20 IST, Shreeya Patel <shreeya.patel@collabora.com> wrote:
> >>>
> >>>> This series implements support for the Synopsys DesignWare
> >>>> HDMI RX Controller, being compliant with standard HDMI 1.4b
> >>>> and HDMI 2.0.
> >>>>
> >>>
> >>> Hi Mauro and Hans,
> >>>
> >>> I haven't received any reviews so far. Hence, this is just a gentle reminder to review this patch series.
> >>
> >> Why did you put clk changes here? These go via different subsystem. That
> >> might be one of obstacles for your patchset.
> >>
> > 
> > I added clock changes in this patch series because HDMIRX driver depends on it.
> > I thought it is wrong to send the driver patches which don't even compile?
> 
> Hm, why HDMIRX driver depends on clock? How? This sounds really wrong.
> Please get it reviewed internally first.
> 
> > 
> > Since you are a more experienced developer, can you help me understand what would
> > be the right way to send patches in such scenarios?
> 
> I am not the substitute for your Collabora engineers and peers. You do
> not get free work from the community. First, do the work and review
> internally, to solve all trivial things, like how to submit patches
> upstream or how to make your driver buildable, and then ask community
> for the review.

I don't think Shreeya was asking for "free" work from the community.
Her question wasn't trivial or obvious since reasonable people seem to sometimes
disagree about where to send a patch especially if it's needed to make a series compile.
I heard the issue was already resolved but had to say something since this accusation
seemed so unfair.

> 
> Best regards,
> Krzysztof
> 
> 


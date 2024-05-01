Return-Path: <linux-kernel+bounces-165180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F358B8924
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3005C1F231A1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554995FEF2;
	Wed,  1 May 2024 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BVDh0Yk6"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93F856B63;
	Wed,  1 May 2024 11:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714562414; cv=none; b=tRsva6PVhjY+h/qilwPURxzbjAhv4VbGKd3UhSUOVAqlchQrHuYQc0Q8LQANpnhLHNAzLTVCuJgpkAQB2ipkKBEqGntqZd17zVjie1hl3vzFiQoB/VBevf7w/IN7oqoyupj6HXkTDE7KNKfsae8n1cWyqrf5hyR6Fi7SkLO+EJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714562414; c=relaxed/simple;
	bh=VdaxhUn/XM6Ym1rOWk8SQaeNn5/QJQcnrhKtg4irLf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6VOpakN3EwgsCxEPuIaHJMValg5hEmmnAge1wHL+3RP+9a6oMK7Bp+r/j7NgdBfjHpDzByzfPIXLEfgMuEtKkm/XYiolL0tSKnluWM6r/NNNxLTs0EE4YQf1JDLvBZAA+GxmAGCwAbda6PH/QjnmYrM0GFrinfEluqGWUajwqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BVDh0Yk6; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BFD2324000C;
	Wed,  1 May 2024 11:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714562403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+cNJcR4HKthr4uVQ8bZMEc3QTkCQ0VDxcnetbrScSKg=;
	b=BVDh0Yk6zShpiP0lUaFPccR0hocR9I7SgxGCP1iFeWYYv8Hjj3fFidC+tuWwRSRv7ygAHx
	Y0239OrhnxD0dawobTnFpggmXx2SNnDuluNCBRXuirnvhg4JvuYz4KctaDHzWErIHMpLYD
	fkKR9MmCCBXK7DIK0NqceuT+odWLR3bB2/70HJOaWSbMXR+o4IxeTYyFPDwoGamqe87AbO
	lKZI1frIGFZqDPgB94mNLtTtwVlcNfYnBSm9YJbfnvot02lfclM9UnnwSracs4zwF5QcTh
	olBgKp5IBR28GBPHyLOvVV2houTWn+b66Xze0nXZuuqgtM6SleFZiYxJFyVJfQ==
Date: Wed, 1 May 2024 13:20:01 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Cc: Inochi Amaoto <inochiama@outlook.com>, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dlan@gentoo.org
Subject: Re: [PATCH v8 2/2] rtc: sophgo: add rtc support for Sophgo CV1800 SoC
Message-ID: <20240501112001dc47d549@mail.local>
References: <20240204044143.415915-1-qiujingbao.dlmu@gmail.com>
 <20240204044143.415915-3-qiujingbao.dlmu@gmail.com>
 <IA1PR20MB49533772D594D18204E9F9EEBB192@IA1PR20MB4953.namprd20.prod.outlook.com>
 <CAJRtX8Rz0BhbtBJq+gSRTU3vsOwfyWjrqJ-Q1fqr7ZFeY2uaNQ@mail.gmail.com>
 <IA1PR20MB495377FCD5101F85B02BB5BCBB192@IA1PR20MB4953.namprd20.prod.outlook.com>
 <CAJRtX8Ruh4BethYcGM2RueNBDioXpn8dJ3yvUD4iW_1cmiVFqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJRtX8Ruh4BethYcGM2RueNBDioXpn8dJ3yvUD4iW_1cmiVFqg@mail.gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 01/05/2024 17:14:43+0800, Jingbao Qiu wrote:
> On Wed, May 1, 2024 at 3:43 PM Inochi Amaoto <inochiama@outlook.com> wrote:
> >
> > On Wed, May 01, 2024 at 01:03:58PM GMT, Jingbao Qiu wrote:
> > > Hi, Inochi
> > >
> > > On Wed, May 1, 2024 at 10:19 AM Inochi Amaoto <inochiama@outlook.com> wrote:
> 
> > > > Another thing is that I do not think is a good way to let the
> > > > rtc driver access RTC_CTRL area directly. You have already
> > > > know there is a 8051 device in the 0x05025000. It is necessary
> > > > to make some room for this device. Maybe you want to implement
> > > > them all in the rtc driver? If so, I do think it is a bad idea.
> > >
> > >
> > > Do you mean that RTC drivers should not directly access the 0x05025000 address?
> > > Because there is an 8051 subsystem on this address.
> >
> > Yes. At least we need some mechanism to share these address between
> > this devices.
> >
> > > Firstly, I do not intend to implement 8051 in the RTC driver,
> > > but the 8051 subsystem is located within a module independently
> > > powered by the RTC.
> > > So if we want to implement the 8051 subsystem in the future, it can be
> > > used as a node in RTC? I'm not sure.
> >
> > Yes, this is what I care about.
> >
> > > Then, Alexandre told me that there are operations related to PM in
> > > RTC, such as the following files.
> > > This matches the description of address 0x05025000.
> > >
> > > drivers/rtc/rtc jz4740. c
> > >
> >
> > I do not think this is something related to the PM. 8051 is more
> > like remoteproc. So it is necessary to arrange them carefully.
> >
> 
> You are right.
> I learned from official documents that 8051 works in the RTC domain.
> Linux does not provide relevant interfaces to operate 8051,
> Just providing a mailbox for communication between them, or through
> interruptions.
> I don't understand how 8051 works, so I shouldn't write to the
> corresponding registers in RTC.
> 
> https://milkv.io/docs/duo/getting-started/8051core

Then you will have to have a driver for the 8051 firmware before being
able to access registers that are outside of the RTC range. However, I
se the firmware is using RTC_INFOx without any form of locking but I
guess this just means Linux will have to ensure it never writes to
those.

> 
> 
> > > > > 2.25.1
> > > > >

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


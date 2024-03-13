Return-Path: <linux-kernel+bounces-101641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D4987A9C8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B10DAB233A5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F7CC127;
	Wed, 13 Mar 2024 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NanRpLdQ"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF4F4A07;
	Wed, 13 Mar 2024 14:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710341467; cv=none; b=UNaV2iMBFxr0Ae+dFlFaw7GM9d5lNo3+jQLqmmwzkTYirNixvg9OFk2rILCeDHx45HNsw6l9hluIGR0QW+jhbiGyo7VRP1bPYFUmRoODgQ8pQmx9uMgPml/KsJHFZ7kxHfnTlkCrIsbA0zuNKmKLKr5gM/6E7wKkPCBo0HVtosM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710341467; c=relaxed/simple;
	bh=XoSkEQZquKyZCCzKctPvka6Uyyakyksn1egML4TSArQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJJtamQ3ED8Vh40HM8/Xl8LZeS3A+1uJIx4mTjZFOAVLSXdtYBsZdkMqJ3r9fa7RRLJAGvF/LVsjdQFQgr3RzzD4oKYWLy3buhMLUupQ8147kITJ4IUg8ewokYp8FneZYX3xMKui6zCU/MsKXFm3/S6EzG0QYZ6PsZ/5QBkr08A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NanRpLdQ; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 31F8F1C0009;
	Wed, 13 Mar 2024 14:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710341457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8VJkHw9Sd5alOnv5C50Y3H8ffoBOxoKu755mmz9UUEI=;
	b=NanRpLdQ1MKcQhvI41Tc50fWxjFE6Ck2VgQfOtWkPRHoqBld3vHI/Df6Mt37+cqK3PfJSa
	4zJ/kPmXzvsfOvjrZ7OupGuHiG0S78UA2iKK9Wkc+DUWGnjxUpWckZ2Rk6q+KWUEGJPVef
	lSW/qwmCFjWiBShrjbjamuTxCqNpaAf1fdyeVwCJyZ0V1UBbzHAiWDEWCscClK4Le61Om/
	A38TN5xhY+0WJIBKLCkD7KKFIo7jHhQIpy36lWks5LyFUG0yAJCtwQx2RhVnRXtKXxm64X
	iQT301CSo1jomtMpFfVDud/Tppvvx2d9Y8bbHkN0yTPFMwJo1e8Yaj9WXKoflg==
Date: Wed, 13 Mar 2024 15:50:54 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	virtio-dev@lists.oasis-open.org,
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"Christopher S. Hall" <christopher.s.hall@intel.com>,
	Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	"Ridoux, Julien" <ridouxj@amazon.com>
Subject: Re: [RFC PATCH v3 0/7] Add virtio_rtc module and related changes
Message-ID: <202403131450547f373268@mail.local>
References: <0e21e3e2be26acd70b5575b9932b3a911c9fe721.camel@infradead.org>
 <204c6339-e80d-4a98-8d07-a11eeb729497@opensynergy.com>
 <667c8d944ce9ea5c570b82b1858a70cc67b2f3e4.camel@infradead.org>
 <f6940954-334a-458b-af32-f03d8efbe607@opensynergy.com>
 <57704b2658e643fce30468dffd8c1477607f59fb.camel@infradead.org>
 <d796d9a5-8eda-4528-a6d8-1c4eba24aa1e@opensynergy.com>
 <202403131118010e7ed5bf@mail.local>
 <dcd07f0b733a90ac3f3c43a4614967bbb3ef14ad.camel@infradead.org>
 <20240313125813ec78d5a9@mail.local>
 <96be7312f7bddaf06c690e082a8028fa8b511deb.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96be7312f7bddaf06c690e082a8028fa8b511deb.camel@infradead.org>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 13/03/2024 14:06:42+0000, David Woodhouse wrote:
> If you're asking why patch 7/7 in Peter's series exists to expose the
> virtio clock through RTC, and you're not particularly interested in the
> first six, I suppose that's a fair question. As is the question of "why
> is it called virtio_rtc not virtio_ptp?". 
> 

Exactly my question, thanks :)

> But let me turn it around: if the kernel has access to this virtio
> device and *not* any other RTC, why *wouldn't* the kernel use the time
> from it? The fact that it can optionally *also* provide paired readings
> with the CPU counter doesn't actually *hurt* for the RTC use case, does
> it?

As long as it doesn't behave differently from the other RTC, I'm fine
with this. This is important because I don't want to carry any special
infrastructure for this driver or to have to special case this driver
later on because it is incompatible with some evolution of the
subsystem.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


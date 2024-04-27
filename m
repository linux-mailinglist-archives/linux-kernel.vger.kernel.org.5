Return-Path: <linux-kernel+bounces-161049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B87088B466B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 15:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7427D1F25454
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 13:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAA14EB42;
	Sat, 27 Apr 2024 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b="g8B9bonx"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212971E52C
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714224014; cv=none; b=QsTX76ABg7S6yg+SK2vYy/a9GJBHBwHv8Q1dDQiQ1v2xo5mYygMlHtVOQeHGjJqsLsoA2YZTMsAnO/NcwQFahqOj2PwY6x8BanoYsjKG35zn2aqiQrowoRIFwPJH7AoLeHfWhxPkZkMyIsXkz0SRq1KiYV/4+bQLR4piVNXmwJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714224014; c=relaxed/simple;
	bh=qGZsG3j18QQWTwG3FyZU680t+pfqkUZrh2Bog1r6/3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHA/UloAJJJSdSVrlUk+Q52pggAoEeA3fKt8E+E1aEvTsMG2GrALyAsMjK0zANkA9qjbuukaq2nYCLzWgeTY9Kj1EzBEyxrB+JW/N4HDuDgcjX+9PwIuqtVPR9F/7HYbfDw7yaspuBeBWDiSlhP3+AIQKDpTLE8nCFMgXoKugYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf; spf=pass smtp.mailfrom=kl.wtf; dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b=g8B9bonx; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kl.wtf
Message-ID: <5aa9f745-7f6a-4873-90ba-79c55335905c@kl.wtf>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kl.wtf; s=key1;
	t=1714224009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfOtXc6WViAFRFYSE9QdU+nVX4O2bjwoGvRSijHrSaM=;
	b=g8B9bonxr/NxRCijwImAog+YkojH/DdvOaVtPehL2YW8S8sgLF8/Dgg3hdpWu2CtUivp1G
	9UsHw1aWBdZhY8wRAFgG1DV6UqF6ERheEuTveZU7T9PG8LkHl5ZoEfY6irhR6UkkyANFjf
	yKTipIPyFNZIPYleZfsx68M3TDTj8Y0G0wBaqm9WR7eIpHXtAj6nfz717lwNfU5Fxl+cTS
	epJNBbQvSDZ1vOANYXl/XxbECnfKzyVgBP1QtLeX7eTKKCdvCJmjr8df/St3Gdsq3ezmRX
	Isus1BSgWlhtSvS9m33IkOqrn9psMBTmm6aRXmBVfvcs6vFBsdNOCnApIQU3Ag==
Date: Sat, 27 Apr 2024 15:20:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/3] HID: i2c-hid: Rely on HID descriptor fetch to
 probe
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dtor@chromium.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Douglas Anderson <dianders@chromium.org>, Hans de Goede
 <hdegoede@redhat.com>, Maxime Ripard <mripard@kernel.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Johan Hovold <johan+linaro@kernel.org>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, Radoslaw Biernacki <rad@chromium.org>,
 Lukasz Majczak <lma@chromium.org>
References: <20240426225739.2166-1-kl@kl.wtf>
 <20240426225739.2166-2-kl@kl.wtf> <ZixvUNooESC02cJK@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kenny Levinsen <kl@kl.wtf>
In-Reply-To: <ZixvUNooESC02cJK@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/27/24 5:21 AM, Dmitry Torokhov wrote:
> I really think we should differentiate the cases "we do not know if
> there is a device" vs "we do known that there is a device and we have
> strong expectation of what that device is, and we do not expect
> communication to fail".

My reasoning was that there is no difference between looking for address 
acknowledge on a probe read vs. a real command. Unfortunately, I ran 
into some issues with error code consistency that Doug highlighted...

Considering that the smbus probe bails on *any* error, it's really only 
ACK'd address + NACK'd register that remains, and I thought it maybe 
wouldn't be too harmful to just always have a debug log as suggested. 
However, I would still like *more* good errors by being specific about 
the error condition, and I plan to send some patches to get the number 
of drivers sending ENXIO up so we can comfortably rely on it in a future 
i2c-hid patch.

If you don't think it's acceptable to leave this as a pure debug print 
for now, I'll send a patch with just a minor clean-up and Łukasz' delays 
- then I'll try this again later when the driver situation has improved. 
I've been rapid-firing revisions, so I'll await an ACK this time... :)

---

For some context, I started looking at the i2c-hid driver after a recent 
regression around assumed Windows behavior, and found that the actual 
behavior differed a lot from our assumptions. Windows gets the job done 
notably quicker, with fewer messages and with shorter albeit differently 
placed delays.

My plan is to send patches that clean up and aligns our traffic more, 
speeding things up and hopefully deprecating some quirks. To that end, I 
would also like to get rid of the dummy read once we're comfortable with it.


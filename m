Return-Path: <linux-kernel+bounces-29078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D857830800
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6F81F234B3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A522032F;
	Wed, 17 Jan 2024 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iTM2+qGk"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E78020305
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705501565; cv=none; b=GzESjTBA43ZyYL0+B/ycGKPwNqdRFkjR8SRzHtLwAdBigBSXN8019uiDsxFpKII4Wrs0Q9O4nOrOTc4ibiCAXffL+M220M0ten/QC1XKiu45PK/k/AYuwiI+6ZZQ1mCrWH46StLaqi3vSCX0xeD1AK/1lZsFIfH9u3ZlYx1OnaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705501565; c=relaxed/simple;
	bh=IZH1c4qN0Nyx3Qk86dKABx77jYlSji40Miq7xcjuCTY=;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID; b=aCsh10J+i2JxIOja5I+BnEsxdO2+z4DG4kUmFnFTOVd1nXaAoLtPf5cDg4Vx5RTevK+cS8UdIt0kL1l6Sdk4sKteGY1s+tM2k46wSOKuWU3LN73QzwyJUCIRtGh0lsIrili3K6tXDzCS3gKvRuGVUKOgMi2mTV0RAclsaNflCXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=iTM2+qGk; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TFSfX3cp8z9scX;
	Wed, 17 Jan 2024 15:18:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1705501124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/04+AUA96JyRGSg7FmQ1Co1hzmApsEtK4+LDUq5qS9I=;
	b=iTM2+qGklqomZrkR34x42hazC6kJ+uog03ScY7x+OSQ+DV8q006tTFpvfLKKULMIBRiWqv
	27EL7iDbCy3fj06IcW2/nA9snnoZ1mVGwxb0sjVItvJfcbcbrPRzmIIMsCtIUdJHx1utqX
	iPGZOTjyAMDlsbbhtmX4sji/Tq5cLiwpnleaR9feX9p53K5sKdyyjMYvrIxhWLdTr/XZMS
	f8kEpLtVb4oZWUy2ygT7u/DRkJRsvxCvHxSRknEkc41Hao6kXYMWU9+9+UEiHAcBWDYEJI
	etDj9lIp3kF4OjJdtUQlYD0Oy4YxpA22IM/DhB6dTh7upk9IVj0HCzWbAKpyHg==
Message-ID: <48824a5d-223a-4ad2-b198-5fcb75a9cfde@mailbox.org>
Date: Wed, 17 Jan 2024 15:18:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] drm/atomic: Allow drivers to write their own plane
 check for async
Content-Language: de-CH-frami, en-CA
To: Xaver Hugl <xaver.hugl@gmail.com>, Pekka Paalanen <ppaalanen@gmail.com>
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, daniel@ffwll.ch,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 alexander.deucher@amd.com, Joshua Ashton <joshua@froggi.es>,
 Dave Airlie <airlied@gmail.com>, christian.koenig@amd.com
References: <20240116045159.1015510-1-andrealmeid@igalia.com>
 <20240116114522.5b83d8b6@eldfell>
 <a6099681-1ae9-48ef-99bc-d3c919007413@igalia.com>
 <20240116151414.10b831e6@eldfell>
 <47c6866a-34d6-48b1-a977-d21c48d991dc@igalia.com>
 <CAFZQkGyOQ5Tfu++-cHqgZ9NOJxqxm8cAF5XT18LmisuPAUbXAg@mail.gmail.com>
 <20240117105509.1984837f@eldfell>
 <CAFZQkGzite-CZoJcV80kNPe==OWFZa_cR1x3QRKuLd=HdOFw-A@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <CAFZQkGzite-CZoJcV80kNPe==OWFZa_cR1x3QRKuLd=HdOFw-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: pgtcyajtxp3yqt1pxr8ffrrr7u18ejhe
X-MBO-RS-ID: f6b5e7383e43717d63d

On 2024-01-17 13:57, Xaver Hugl wrote:
> Am Mi., 17. Jan. 2024 um 09:55 Uhr schrieb Pekka Paalanen <ppaalanen@gmail.com>:
>> Is it important enough to be special-cased, e.g. to be always allowed
>> with async commits?
> 
> I thought so, and sent a patch to dri-devel to make it happen, but
> there are some
> concerns about untested driver paths.
> https://lists.freedesktop.org/archives/dri-devel/2024-January/437511.html
> 
>> Now that I think of it, if userspace needs to wait for the in-fence
>> itself before kicking KMS async, that would defeat much of the async's
>> point, right? And cases where in-fence is not necessary are so rare
>> they might not even exist?
>>
>> So if driver/hardware cannot do IN_FENCE_FD with async, is there any
>> use of supporting async to begin with?
> 
> KWin never commits a buffer where IN_FENCE_FD would actually delay the
> pageflip; it's really only used to disable implicit sync, as there's some edge
> cases where it can wrongly delay the pageflip. The waiting for buffers to become
> readable on the compositor side isn't really significant in terms of latency.
> 
> If hardware doesn't support IN_FENCE_FD with async commits, checking if the
> fence is already signaled at commit time would thus still make things work, at
> least for KWin.

That's how IN_FENCE_FD (and implicit sync) is handled anyway, in common code: It waits for all fences to signal before calling into the driver to commit the atomic commit.

I can't see why this wouldn't work with async commits, the same as with synchronous ones, with any driver.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer



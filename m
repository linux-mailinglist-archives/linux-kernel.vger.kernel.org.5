Return-Path: <linux-kernel+bounces-138954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A49EA89FC8C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59FF71F221F7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076B7179672;
	Wed, 10 Apr 2024 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qfr1P/cv"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC45217966F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712765477; cv=none; b=TeX0keUy0LyyB4P3KBDzU6FNKNzbK2dz1xdpNFFcAYBb5krd9MqSook2lLYSVcVCLj/ufRia8X6H4czEClQs2D8mbwnt553kUp0Czz7MFX4qE8yeDap1NzpVcsx44FqXT+5UDclzJD7PYrXdTIvr4T8NfiRReE4JyP3A/x/XCW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712765477; c=relaxed/simple;
	bh=uSG2l5o+Q79nj3UeD5xKuQOR/gwI5ezOeDJXvmNQMr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FiNd/M52yDO0nSfoOsIcHblOIYIbZFRpsgRI2E/K/6HKqhSLJzwLDWG7rdm+hpfD5EkuKsWFfUQKQ8l02foswEg6tldKRyJ44Cy7jtqz48p0J+PuABKzciT7bE2l0+xW3lTkYmE90kFFFGJ12pbgdTn48QdhGHY9Ls8UNVq5/D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qfr1P/cv; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712765474;
	bh=uSG2l5o+Q79nj3UeD5xKuQOR/gwI5ezOeDJXvmNQMr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qfr1P/cv6RgE5xtO2uYwAMhAovIA7FqZz0NBanGp3220Ms2NWEpxrVSyADBxJzvk6
	 lBidnOiHOdb2tCWF6AVsP1XR/HZkz/rLrMUHasj6Uxz19TnRSpWyuMs5aQUu/nkwGs
	 HdGXayO9RBsMGezgMxhfLDGug8+ssyYTs3EF29s/O4Fz3RKDGtUvA2CqqxK+nAtrD2
	 kLm31bDZk7zlSAqFSQfUQKvtUlNex19vnR7Fjc72ITf+bTzygOL0x3b47wDPlMagSn
	 lyihPeoWIGQbJeROVt2Ma2CF6yf6+0yQPvDAT5XncTSwbMQBvuJOy5vE04jsP0Fktg
	 0+ljtnNj5Ql9Q==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7B95F37820FA;
	Wed, 10 Apr 2024 16:11:13 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: tglx@linutronix.de
Cc: kernel@collabora.com,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	regressions@leemhuis.info,
	regressions@lists.linux.dev,
	x86@kernel.org
Subject: Re: [REGRESSION] mainline boot regression on AMD Stoney Ridge Chromebooks
Date: Wed, 10 Apr 2024 18:11:41 +0200
Message-Id: <20240410161141.261818-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878r1l48xn.ffs@tglx>
References: <878r1l48xn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Thomas,

On 4/10/24 15:57, Thomas Gleixner wrote:
> Laura!
> 
> On Wed, Apr 10 2024 at 10:15, Laura Nao wrote:
>> On 4/9/24 14:25, Thomas Gleixner wrote:
>>> Can you please replace that patch with the one below?
>>
>> So, with this patch applied on top of ace278e7eca6 the kernel doesn't
>> boot anymore - reference test job:
>> https://lava.collabora.dev/scheduler/job/13324010
>>
>> I see the only change between the second and third patch you provided,
>> besides the debug prints, is:
>>
>> -	if (!topo_is_converted(c))
>> -		return;
>> -
> 
> Right. So this limits the area to search significantly.
> 
>> Printing the debug information without this probably doesn't really help,
>> but just in case it's useful: I tried excluding the change above from the
>> patch while leaving everything else unchanged - reference test job:
>> https://lava.collabora.dev/scheduler/job/13324298 (also pasted the
>> kernel log here for easier consultation:
>> https://pastebin.com/raw/TQBDvCah)
>>
>> Hope this helps,
> 
> It does. Good idea!
> 
> I just moved the exit check a bit so we should see the scan info. That
> should tell me what goes south.
>

Here's the full kernel log with the latest patch applied: 
https://pastebin.com/raw/r2CkP396

Reference test job: https://lava.collabora.dev/scheduler/job/13328709

Thanks!

Laura


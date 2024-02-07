Return-Path: <linux-kernel+bounces-56965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D43B84D1E6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC2B1C22240
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4BE84FBD;
	Wed,  7 Feb 2024 19:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ulJ/1lr2"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE4B1D54A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707332519; cv=none; b=Vpd45WYK3lDC+MLnhkXTKZEPyRgo8Gpgtp5LSNqN8stgFd+T1mk/7RyjJMb7mDjRHkxgUBVLI8wi0MPt+qhqEoCCFcbDa4ZKKAo+UK11rNV/203PlQrfvYtlIHgExGC3DjIsVnM7l0rIDKtrHyHAT/++pH1/x+Z7RIlaua/ABlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707332519; c=relaxed/simple;
	bh=w000UkAU+4sCDykj3/3sg9oncRCfqOlnXkz069WB1eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=oRmPL5rVvOHWWiWb8nkl25di1j3CMkZHjLDrdmZclcONYetWydernKFYBowAhT0TfraYlYOEHv2tsUZbTzAIxc3NRO03OHYmQZk+PAIcGDdSFgUU3xqrIJqvfuuRDu7ufPs8pNU206Yal0BJUsntZ/6rDFghLmpLhvFTZNGNRTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ulJ/1lr2; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240207185553euoutp01be80c65d9cbfd7b6e8655da6c71cf8a1~xqYwt48Fl2163521635euoutp01E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:55:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240207185553euoutp01be80c65d9cbfd7b6e8655da6c71cf8a1~xqYwt48Fl2163521635euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707332153;
	bh=5rpQabQArO6WrFeRKp9w0RIl8t36d0/Om1vvb7sR6SA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ulJ/1lr227gb1SZmBwJsgtwRhlBc++284Wi0ltD4P9alGJyJQPTQ9L+VqrZQhykFr
	 mCtjPWFNnh9JNvfZI2Krif975NuU65ChHihD75OXifJetchXFhZLjzoK5pXHmuvSFk
	 fwoRf8YIBDfcHSpugCz+Xqajr2GAFfAV0D7t6W9s=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240207185552eucas1p2f150f638d00653fde9f00900a8a578f9~xqYwZj1MH3210732107eucas1p2w;
	Wed,  7 Feb 2024 18:55:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 74.4D.09539.832D3C56; Wed,  7
	Feb 2024 18:55:52 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240207185552eucas1p1c58470c4076af2ec22456285ade3cbef~xqYwDTMRF3234232342eucas1p16;
	Wed,  7 Feb 2024 18:55:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240207185552eusmtrp259ee4a41328bbb5ced1c69805f886db6~xqYwCtiSs0864308643eusmtrp2V;
	Wed,  7 Feb 2024 18:55:52 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-2a-65c3d238f609
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id F1.32.10702.832D3C56; Wed,  7
	Feb 2024 18:55:52 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240207185551eusmtip1c30f337cefb866dcde349cf82500225b~xqYvVXJSU1256712567eusmtip1g;
	Wed,  7 Feb 2024 18:55:51 +0000 (GMT)
Message-ID: <2f125955-8c7c-465c-938c-8768f7ca360b@samsung.com>
Date: Wed, 7 Feb 2024 19:55:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PM: sleep: Restore asynchronous device resume
 optimization
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
	<linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Nathan
	Chancellor <nathan@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, Lai Jiangshan
	<jiangshanlai@gmail.com>, Naohiro.Aota@wdc.com, kernel-team@meta.com
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <ZcOyW_Q1FC35oxob@slm.duckdns.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsWy7djP87oWlw6nGmxcb2Ixde1uJot9F9ew
	WVzeNYfN4nPvEUaLicc3s1q0r3zKZjH3y1RmizOnL7FafNyzgdHi1/KjjBbH14Y7cHvsnHWX
	3WPTqk42jzvX9rB5zDsZ6HHuYoXHlqvtLB6fN8l5tB/oZgrgiOKySUnNySxLLdK3S+DKmLO/
	uOAXW8W2X6/ZGhjPs3YxcnBICJhIzJpj0MXIySEksIJR4tcFGwj7C6PEh8PMEPZnRomWdQkg
	Nkj5oi272bsYuYDiyxklljb0sUAUfWSU+DEzFsTmFbCTOLh9IVgzi4CKxPnXO5kg4oISJ2c+
	AasXFZCXuH9rBjuILSwQIvH67FFWEJtZQFzi1pP5YPUiAm4Sc6dvZwJZxixwlUnizKfFYAk2
	AUOJrrddbCA2p4C+xOJfe5khmuUltr+dwwzSICHQzSmx69JaNoizXSTeLj/ICmELS7w6voUd
	wpaR+L9zPhNEQzujxILf96GcCYwSDc9vMUJUWUvcOfeLDRRezAKaEut36UOEHSVal2yABiOf
	xI23ghBH8ElM2jadGSLMK9HRJgRRrSYx6/g6uLUHL1xinsCoNAspXGYh+X8WkndmIexdwMiy
	ilE8tbQ4Nz212DAvtVyvODG3uDQvXS85P3cTIzB5nf53/NMOxrmvPuodYmTiYDzEKMHBrCTC
	a7bjQKoQb0piZVVqUX58UWlOavEhRmkOFiVxXtUU+VQhgfTEktTs1NSC1CKYLBMHp1QDk7v9
	jJIXxcel/b3PP31o61DVIW82W7ot7MkkhRuHmrXtvn/sP3BwQUEFY+mqGsFzB5kuxX5XFC47
	x923qi0wl1fBlbV796SZdpFpu56si1qY7DSTN3B/0Po9N3VFxMRWiV7jsV3iksNleIpHcIvV
	rgZmpWk7ZSes/6/nt/D+VVWOct/lj1dsvi7xj+3RMfNH2XWTQ9m2+1UwXTWTdd5vXDbf6kpQ
	2AupDeUHhPfM3nHPQV7zhXnrxEub7l41m/np9fRlHzbPDD9p/9zc7Nyi3asWB4l53mN5sf8g
	o+cx2adbOI949ljt4wn5aL7EsjhsC1+reTXb9jm5Aa+DHf4es+/yyC93M9a++u7bnqY7cUos
	xRmJhlrMRcWJALwxxOzNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xu7oWlw6nGiz9LWcxde1uJot9F9ew
	WVzeNYfN4nPvEUaLicc3s1q0r3zKZjH3y1RmizOnL7FafNyzgdHi1/KjjBbH14Y7cHvsnHWX
	3WPTqk42jzvX9rB5zDsZ6HHuYoXHlqvtLB6fN8l5tB/oZgrgiNKzKcovLUlVyMgvLrFVija0
	MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLmLO/uOAXW8W2X6/ZGhjPs3YxcnJI
	CJhILNqym72LkYtDSGApo8SsLzMYIRIyEienNUAVCUv8udbFBlH0nlFiw/uFbCAJXgE7iYPb
	FzKD2CwCKhLnX+9kgogLSpyc+YQFxBYVkJe4f2sGO4gtLBAi8frsUbChzALiEreezAerFxFw
	k5g7fTsTRPw6k0TfWzuIZbOZJeaffAd2EZuAoUTX2y6wxZwC+hKLf+1lhmgwk+ja2sUIYctL
	bH87h3kCo9AsJHfMQrJvFpKWWUhaFjCyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiM2m3H
	fm7Zwbjy1Ue9Q4xMHIyHGCU4mJVEeM12HEgV4k1JrKxKLcqPLyrNSS0+xGgKDIyJzFKiyfnA
	tJFXEm9oZmBqaGJmaWBqaWasJM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp1cBU/ShK3aD/hnlV
	ZLJovpTQPF6JFisL3u/TFy375tJ7sL7xXdOD8D8Wy64+Kqi6uuDCnmN2ZplSG2S/x77ZXPPr
	Hf+CDvHaSGlzJVn9NfMzX68xmtR+U6Cryv9+xinuR7+UpYru3XvEkbds86n0eyZ/7XfwOoSf
	uHWusn97gNfW25dUzZTb5r8uP3JkgdvrAB6GIL7E/8mfVmzqef2nc4mUIu+O6qMiyh3G13Kv
	6DEGJCXrCVw4e0G/UXTDppI/p2Zxb/yZbhNy4JH7qtZrMlJLb+X8y4p0s5rkHfUu42/i9c5f
	jUt9by49vuBsskPY+sOtm779yZjTqMpffC7bdNmO+y8z83vK1Fl5/n9Zz/hEiaU4I9FQi7mo
	OBEA0At4A2MDAAA=
X-CMS-MailID: 20240207185552eucas1p1c58470c4076af2ec22456285ade3cbef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240207103144eucas1p16b601a73ff347d2542f8380b25921491
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240207103144eucas1p16b601a73ff347d2542f8380b25921491
References: <CGME20240207103144eucas1p16b601a73ff347d2542f8380b25921491@eucas1p1.samsung.com>
	<10423008.nUPlyArG6x@kreacher>
	<708a65cc-79ec-44a6-8454-a93d0f3114c3@samsung.com>
	<CAJZ5v0hn=KgaWn9pwtLsH2a8n61BNxzb1xrNoxUfEi3o9OAZGw@mail.gmail.com>
	<4a043533-009f-4db9-b107-c8374be28d2b@samsung.com>
	<CAJZ5v0hDmwaFEtLc8yDc4cXn2wODXAqATe0+_Hpm9QPODUPMQw@mail.gmail.com>
	<ZcOyW_Q1FC35oxob@slm.duckdns.org>

On 07.02.2024 17:39, Tejun Heo wrote:
> On Wed, Feb 07, 2024 at 12:25:46PM +0100, Rafael J. Wysocki wrote:
>> The other one is that what happens during async resume does not meet
>> the assumptions of commit 5797b1c18919 (for example, it can easily
>> produce a chain of interdependent work items longer than 8) and so it
>> breaks things.
> Ah, that's fascinating. But aren't CPUs all brought up online before devices
> are resumed? If so, the max_active should already be way higher than the
> WQ_DFL_MIN_ACTIVE. Also, are these multi node NUMA machines? Otherwise, it
> really shouldn't affect anything. One easy way to verify would be just
> bumping up WQ_DFL_MIN_ACTIVE and see what happens.

I've increased WQ_DFL_MIN_ACTIVE from 8 to 32 and all the system 
suspend/resume issues went away. :)

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland



Return-Path: <linux-kernel+bounces-145494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727DF8A56E7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1180B22397
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6A080BF0;
	Mon, 15 Apr 2024 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="kv5aOIDr"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA52280046;
	Mon, 15 Apr 2024 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713196839; cv=none; b=lKnNXAvQRI8ZvTLOkmLiPczmFzTz0nP4nY+TsskXqrO9fCWywjDCLpC2buSt/6hZsDwn/tRDjeuJDJhHfjVynvPtfHoDVnGSTY0wyXlxqQfTAEoeqfggp8o94e+vnFDVQ3K1uZZYKawQwCplAgsyUurIz65OUgMBmQ9kSCURtwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713196839; c=relaxed/simple;
	bh=woclFQ0u2R0xYszRsrlHP/w9y2mSS2I3BkA4RJODMdE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=eiyQf3+7NtlbKgffLm27nBwuK3sH5S2LVAJDnVhJMftBYyzPiKaX8xz5HQxkOY55rfxnVdsSzC63nrpTSL1ebvCz3rcj5IrKmFijESLADJsfsLr6Kx7UC1/a4Vk7IjBmvQ1jwgRJNd4vrTglxTP3rcT5l+O8YPrrF/IQwuZqWrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=kv5aOIDr; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713196813; x=1713801613; i=markus.elfring@web.de;
	bh=gEid9mVIvQwKSv0gsgGmmkqLxA26ARZ4aUrfwj6ixXM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kv5aOIDrPi2CMbH7ujwtpAQAl3CRgCqVe/r5b/xH4iMZ11y7ZXCOo8r/AHLSxBe5
	 QdvV67aSH3ybC7/wSSUdpMBKWsTvLe/xLMQ6cDwpsKLK7FFud2LhKzwzrcve+akze
	 l2dIl70IsFR5JDOpR0XUXBpnl9myTm/ul72UbB7N1XoF7x8MFDYZoVsaUy8MaavMn
	 Nyq9JwbtM4/o/N/ZbluW2Ruvq1L3CbxFmCypddDZabwwRvshDgIBFaEsxEw6LRN1E
	 jjeL3kz4AxGLCAjN2PzlrwMCfe9WnvBAQii/7dPpmyXoVVN5MbaZrND0702bmFz5z
	 ncnfKFKCcpH7naq/og==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MA4fI-1s3ZUl1CGY-00BqkD; Mon, 15
 Apr 2024 18:00:13 +0200
Message-ID: <fc63ccb9-3160-4ba4-9016-df2b298943ab@web.de>
Date: Mon, 15 Apr 2024 18:00:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dan Carpenter <dan.carpenter@linaro.org>,
 kernel-janitors@vger.kernel.org,
 Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
References: <b32e80cf-b385-40cd-b8ec-77ec73e07530@moroto.mountain>
Subject: Re: [PATCH] regmap: kunit: Fix an NULL vs IS_ERR() check
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b32e80cf-b385-40cd-b8ec-77ec73e07530@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IfilJjow+UP3a7TUxSHV7U9R8GQM9VZIZh+wSJMFdtRsPyb65uR
 Q2kUz7ppXk8eO5Xbv46JKaXt1bCLgaZdySEYStRNBVkislQJ05n0SFt10t6xECVIulOCEqX
 ANOtAQ9lOteKsKyJ/yxAoeTi64+PflEN+J18i+QYkOgnLAs+ho8swvJWL9qKyphWn3+Z8wx
 Kq54PdmE6aK3K11e0JnOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RGQFDRTPJvI=;T+YujsSHvo7kWexAzyW8iUwV6yP
 T+yrRuhcy4jK+jqzV2lJ5FKtc9IMGMrPSV2YrOlCVRF1sZUK2RA/Pl/V3RiG1I56KlsKNz/vR
 dqdA45ksk9qMgENmczED8qjetYuvF7kXKUW7ceHBrgXATG6DLL/jYSLOK27sMZsA/p8R0jDhm
 IoTAVl8YkliDW4lGhpgH/QOG+8Zt2W9AtUWsArQLP5xiQLjMjzWzBoDF1Qbkj2JcLj7982vT3
 iF220e8Env/lcMAZuwQhQiTJ0FJSK8gzyVvW/ZnHRjYWCHe8YxOc7wOaP18NCNhUuQgIBoykg
 rse0vCP88/xAauqSa8Z3UaGFWLbwjUYUAKHfnNfGYvZT/BnKFGdyY4ySoS692aXhExdMneWmx
 +voH9xqCLHhRWgyKTBlHNyYGwk3D2fIXuiXywOxHHWU4Kf7gC1OsDIIxshYapHyKQYFL1AwQh
 SYAPmat4GcfHLxXaG841nOOwwkfUafRTv+g69FIYmATRti41S0M5qB9UUbhwgnEFCwwEiH4IB
 t5P2mLR8ChVX3fx+wVPhrwxzlcS+mTYekP/p9PQ093C6z+ueW1zqHytI8pUr6uKVuuBTJ4qdi
 Ng2KvyeEz5Q1fIEnVho90KgycQK1t2LtgPlyp+3zIj3nx3grjjblhVQTdo9RRzVrJJKkM2F6p
 zlnVyFxQQRDQp+sg9F4DPQboZQpXOiTjipp+lVd03K3OMZxuocCxt/KuqmNrE/7F9dTecBd4a
 9H7HUXryvdjeMBBNoskn+ZSV4SG7VXGelzBsHeavvP9BWvpCUBW0aYUIflTgYMIZiqK2947CN
 QGS4oRmU2yt2VkYsgPbUJugmvvfNLN35eCkh37mT8ZcJA=

> The kunit_device_register() function returns error pointers, not NULL.
> Passing an error pointer to get_device() will lead to an Oops.  Also
> get_device() returns the same device you passed to it. =E2=80=A6

How do you think about to convert this adjustment into a patch series
with two update steps?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc4#n81

Regards,
Markus


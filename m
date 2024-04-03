Return-Path: <linux-kernel+bounces-129415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC2D896A72
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29AA1F25C6B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BD112CD9A;
	Wed,  3 Apr 2024 09:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="p1TiY3WA"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3C885929
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712136292; cv=none; b=rIWidwaQdSk9TIsDZetfMUOzvqElhKdWUrZHsoF7ZaZlW3WMQjzOLKNYHNex0DEsTj9Cuwe/+sL2bOyaVKON45fWkSUBqW2StPGM9mxfttTNQ2MIwiX/NKW1vuvknJmJ9lA1w2nI7JC77tvVCu+jgB3XCHchw58Kdg0BJm3yVxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712136292; c=relaxed/simple;
	bh=MmhcRQqnp4D2RnUjym/iPhtvSpqZEVKItC65nUiphMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ix9YUxvRVSdnkiHGFegQ8sYRGdMjzSMWVYKuHZF03OyLuVsUzAb9pR1E4qux1FakJ6CNOrJEjpY0tb/5HlDipdaYZIyU4E1qn7ClBdkWi2EZJ7wslEuHwrqOEE6A4AKfPkYorne0dyjCmLxmZ8YjOb0EPUrvbJlij6TnXw2PbTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=p1TiY3WA; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.175.29] (host-88-217-226-44.customer.m-online.net [88.217.226.44])
	(Authenticated sender: g.gottleuber@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 8CADA2FC011E;
	Wed,  3 Apr 2024 11:24:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1712136282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uj0mT6ecsQmbbD3y84s+Blq2Eu930+4GVa0se5gXceQ=;
	b=p1TiY3WAXu4vSaL3Qv6MAobK13vs1HWOeO3ktp0jZJACSf79Xz4kf7vvJbxzuc/2y3yEZQ
	GmxyZQbzptUSq+DetyjQLiRqC8fyws80Yk2EOfmjZTX/ZxsDInaw9Ipg7mfEVHMojvngHc
	qLRuEQi+igaq0Y/txxXvEEm91iH6OqI=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=g.gottleuber@tuxedocomputers.com smtp.mailfrom=g.gottleuber@tuxedocomputers.com
Message-ID: <f7a70add-4d65-40a4-91ff-70bc14a64467@tuxedocomputers.com>
Date: Wed, 3 Apr 2024 11:24:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Add sleep quirk for Samsung 990 Evo
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Werner Sembach <wse@tuxedocomputers.com>,
 Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Georg Gottleuber <ggo@tuxedocomputers.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240328130923.61752-1-wse@tuxedocomputers.com>
 <20240402131658.GA31963@lst.de>
 <230e3f41-9f6b-42fd-a411-567abbaebbbe@tuxedocomputers.com>
 <ZgwtYpbcyM_ffjaF@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Georg Gottleuber <g.gottleuber@tuxedocomputers.com>
In-Reply-To: <ZgwtYpbcyM_ffjaF@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 02.04.24 um 18:08 schrieb Keith Busch:
> On Tue, Apr 02, 2024 at 05:13:48PM +0200, Georg Gottleuber wrote:
>> Am 02.04.24 um 15:16 schrieb Christoph Hellwig:
>>> On Thu, Mar 28, 2024 at 02:09:22PM +0100, Werner Sembach wrote:
>>>> From: Georg Gottleuber <ggo@tuxedocomputers.com>
>>>>
>>>> On some TUXEDO platforms, a Samsung 990 Evo NVMe leads to a high
>>>> power consumption in s2idle sleep (2-3 watts).
>>>>
>>>> This patch applies 'Force No Simple Suspend' quirk to achieve a
>>>> sleep with a lower power consumption, typically around 0.5 watts.
>>>
>>> Does this only apply to a specific SSD or all SSDs on this platform?
>>> How do these platforms even get into the conditional?  Probably
>>> through acpi_storage_d3 setting, which probably is set incorrectly
>>> for the platform?  Any chance to just fix that?
>>
>> Yes, this only apply to a specific SSD. I tested these SSDs (on
>> PH4PRX1_PH6PRX1):
>> * Kingston NV1, SNVS250G
>> * Samsung 980, MZ-V8V500
>> * Samsung 970 Evo, S46DNX0K900454D
>> * Samsung 980 Pro, S69ENX0T709932L
>>
>> S2idle consumes around 0.4 watts with these SSDs. But with a Samsung 990 Evo
>> s2idle on this platform consumes 3.7 to 4.4 watts (6.8 vs 6.5 kernel).
> 
> For all these different SSDs you tested in this platform, do you see the
> "platform quirk: setting simple suspend" in the dmesg? I just want to
> confirm if the platform is changing the reported acpi_storage_d3 value
> for different SSD models or if they're all the same.

Yes, without my quirk for all tested SSDs (including Samsung 990 Evo) 
"platform quirk: setting simple suspend" is printed in dmesg.


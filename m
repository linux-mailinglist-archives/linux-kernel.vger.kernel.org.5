Return-Path: <linux-kernel+bounces-68230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D6C85779D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 058C0B23A38
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1C51B7F2;
	Fri, 16 Feb 2024 08:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DCp86L2O"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB3417C6D;
	Fri, 16 Feb 2024 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071720; cv=none; b=Ep4/r29+oSZKx4C5C77c1/lG+YXFLmgNVAr1tj26cvr2PR6ckv0pzA4O13a1qpQcBddkc0GdG5by4c5XniPpDVg2e8lfyYKrNIDC5IYqwMpqEcHRJnPldx4LOycuQ0lXyn4RCnutPj6GEW/DYPqbRGECsj0bGNoJqYsqcKXhyKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071720; c=relaxed/simple;
	bh=17YuGSWNnvaESQUxsKqIZ8ErS9M7/eC1wp10xD+VRvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f6RApxMf35DjcFAX8yDCX063ZpP+K73/OersGquSgr1dgmeFHdLlBB8nPQ1zSJHFMSMasIfuWetRrnSNYLTYGweuHf8v92U1yNkgja6OmMBQQOe61TvdlC2iGX37BkNvCFymGzH9IAysQn+tKF78okmAfpL5kWNdSsYZDXoNnqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DCp86L2O; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 19C8D240002;
	Fri, 16 Feb 2024 08:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708071715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nQ7n7vJ3T7jmQEpQrLnWjO1SkU+X7w1Ya56xiu60aDU=;
	b=DCp86L2OwxjKLPSjRNMQxDuIBmV+QxGv6TcZKfGE6dAjftj57X/uwD6/x60UFZ7tmnrdU6
	MycQDWQ8CkX6I4X0eq+6eHpGwNkhwfcWxkSIaAVvGqVDrjBulUbIgpmLiAZPdbVYD7WxYL
	sTbBssAx+DNC7D49sx1yq/4u3XSWlewM2pThV0ExpAuriqQi0owtGGDjRY7E64wqmOuC9k
	jWBob6qc9dD/Muah6FgZWNDZNgN5JDp1G9Hv+l7OzDe3xCiyjJbx65cNAgLbW+E2ojjhI2
	nxMY//HzSgIOEDC1Ak+oxjP6HkKPgjUZg9IysJYJje45pdJq7kqBiEVOQUfOhg==
Message-ID: <d539e013-7205-4661-9b13-b359e5bd8610@bootlin.com>
Date: Fri, 16 Feb 2024 09:21:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: nl80211: force WLAN_AKM_SUITE_SAE in big endian
 in NL80211_CMD_EXTERNAL_AUTH
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Ajay Singh <ajay.kathat@microchip.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Igor Mitsyanko <imitsyanko@quantenna.com>,
 Sergey Matyukevich <geomatsi@gmail.com>
References: <20240215-nl80211_fix_akm_suites_endianness-v1-0-57e902632f9d@bootlin.com>
 <20240215-nl80211_fix_akm_suites_endianness-v1-1-57e902632f9d@bootlin.com>
 <87cysxekbc.fsf@kernel.org>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <87cysxekbc.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 2/15/24 17:58, Kalle Valo wrote:
> Alexis Lothoré <alexis.lothore@bootlin.com> writes:
> 
>> User-space supplicant (observed at least on wpa_supplicant) historically
>> parses the NL80211_ATTR_AKM_SUITES from the NL80211_CMD_EXTERNAL_AUTH
>> message as big endian _only_ when its value is WLAN_AKM_SUITE_SAE, while
>> processing anything else in host endian. This behavior makes any driver
>> relying on SAE external auth to switch AKM suite to big endian if it is
>> WLAN_AKM_SUITE_SAE. A fix bringing compatibility with both endianness
>> has been brought into wpa_supplicant, however we must keep compatibility
>> with older versions, while trying to reduce the occurences of this manual
>> conversion in wireless drivers.
>>
>> Add the be32 conversion specifically on WLAN_AKM_SUITE_SAE in nl80211 layer
>> to keep compatibility with older wpa_supplicant versions.
>>
>> Suggested-by: Johannes Berg <johannes@sipsolutions.net>
>> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
> 
> A pointer to the discussion would be nice to have:
> 
> Link: https://lore.kernel.org/all/09eeb7d4-c922-45ee-a1ac-59942153dbce@bootlin.com/
> 
> I assume Johannes can add that.

Ah yes, indeed. Johannes, please let me know if you prefer me to resend it with
the link in the commit message.

> Alexis, thanks so much for working on this! This has been bugging me for
> long but never found the time to investigate it.

I'm glad to help, especially since I have the corresponding hardware. This
warning was on my radar, and your last complaint about remaining sparse warnings
in the wireless tree eventually triggered the action :)

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



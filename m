Return-Path: <linux-kernel+bounces-160126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9B58B3980
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027A61F222AA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CAB1487DC;
	Fri, 26 Apr 2024 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="hFUkgExE"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFC614831E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714140542; cv=none; b=MvP8BMYAV2iPee/aMOjwa9kuYpA0PK85Idr7omYWO14Q4UI/Dt2a+K5mYhbZ51YqwhbYt10zNx6LRa4EeCfqAaLxmx0TEb/n86QlEQuBXNAB/v1l2u+3dX5Lms6iVH32Em0KyIe6pUcp6nCGCa7I+OXJqMEVLTUAGTFUwsEUZvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714140542; c=relaxed/simple;
	bh=DMfPsJI+x4eojjHjJGFM2J7iEqss95KVx7jQp+0J128=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=hDZ1UY+jSr6m7kfsQBWOe68Hq5XPNWqEWhGB+xUUdgzml6MIkDd6XwXw2cfIHsY8Ikm9udTvay+GZCUnMbVyNnWKO9MN1z2lLHCXTFXbPQrRrxgC0s6JzvDMPaCIrZBbJP7d95BedQsGBjvpIC8PWEqGtWWEzerhugePtgCSP/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tronnes.org; spf=pass smtp.mailfrom=tronnes.org; dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b=hFUkgExE; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tronnes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tronnes.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
	; s=ds202312; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Cc:
	References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
	:List-Post:List-Owner:List-Archive;
	bh=RxhcjK/A9ltE8vS9iwHLvd+KtyalxnkR44emY4L0uhc=; b=hFUkgExEUfg9oDD0ogIkTAkBOI
	fw/jSV+0O2urwyQvLHdy5d4tRxSlc9+nSWIa5V53NLipFvjYdHsOFl2xwhCiFpE7dEVTzOgsRHw/p
	MONoU/CVwNA65I0wHJuwa152nUn+Qv04/HmfY0tBfJ70AVAJmzzKSm6P1IC9SjT2ZuvBUOMMKy/UI
	jFuSQwRC27hYh42iBdh6ID/xsFFaTAMv5bQooPrLANAtv+m3zO4CK+LxsazLyUpLhQ4APGZwZXZw/
	4iccGcUrke5EHrBFM7LXR8WZt2ge150vswksmmYboEkTfVn7Col2X9cVu6cWVLPz6I4uZFefAF0e1
	XryZ2MBw==;
Received: from [2a01:799:962:4900:815f:3dd0:60d8:6458] (port=49646)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <noralf@tronnes.org>)
	id 1s0MG0-00E0w1-P7;
	Fri, 26 Apr 2024 16:08:56 +0200
Message-ID: <06ff6468-be94-4ebc-826a-15c22af4e34d@tronnes.org>
Date: Fri, 26 Apr 2024 16:08:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/tiny: ili9225: drop driver owner assignment
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 David Lechner <david@lechnology.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240327174842.519758-1-krzysztof.kozlowski@linaro.org>
 <74fe0120-379c-4a18-a680-536304b8ac2e@linaro.org>
Content-Language: en-US
Cc: noralf@tronnes.org
From: =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
In-Reply-To: <74fe0120-379c-4a18-a680-536304b8ac2e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/24/24 08:45, Krzysztof Kozlowski wrote:
> On 27/03/2024 18:48, Krzysztof Kozlowski wrote:
>> Core in spi_register_driver() already sets the .owner, so driver
>> does not need to.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/gpu/drm/tiny/ili9225.c | 1 -
>>  1 file changed, 1 deletion(-)
> 
> It has been almost a month. Any comments on this patchset? Can this be
> picked up?
> 

Thanks for cleaning up, patches applied to drm-misc-next.

Noralf.


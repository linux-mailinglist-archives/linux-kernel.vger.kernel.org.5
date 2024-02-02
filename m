Return-Path: <linux-kernel+bounces-49640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5893A846D4E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4A028D058
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A2778B66;
	Fri,  2 Feb 2024 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IqjrXPRT"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFA7487BF;
	Fri,  2 Feb 2024 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706868285; cv=none; b=odBGZj1nprEFxiMx2zXSfCdc51iTDPdKEBcI/B6T9+hH0LPj+j6kEuWlE4H/Y66kD7ENizz10NfdaBsTWGFsNBGKIYB1g8Jd2A+FDBTy9wJ/98I4QbI/WvyJD4So0msOYQPP3JAJyZm0jMINZdSSCMo8M/Q/Tt99uRSliW8ERVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706868285; c=relaxed/simple;
	bh=G8VN6DuWYyD1MCRfMqLBXot7d9Cgp4lfEnXEDGwQyn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jktEQsBD4FGZ6iYHsH1Rut/gaMPRdJDIz2BeFMOWSyiR9poHmmfacRX3c2H+6a8/uAlpPmMU5m20/s66/SgRK5Y5YT/L2U0cC870Sfuze7k9j0iSY2OsQmNuYUNUNa6F7mjQlTaJqy6115y/5FovI0owFulEmzc8CflsLH4xsSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IqjrXPRT; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706868281;
	bh=G8VN6DuWYyD1MCRfMqLBXot7d9Cgp4lfEnXEDGwQyn8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IqjrXPRTabQJePD33N1JEYtVFDiMMP1VnUHxXV11bOfrCJGNWg3BfpHXgdhn5tWE7
	 ufv8t6B9+HtdYavkowk0Ay9SOTxWpv8sefQA6jGL/ku8+yFhy/wYOlDaICt22aTfX7
	 ot6ywsQAUEvfQnJJ0PzLbViOGiiWaxDXqUS2NhJDADwlHr52eEE+utsjpoEQIa22/0
	 oEdafAbqhOhCDzvFJQK/EP2AXDwGEa6Pa+udcRoPL5wUNLYfyvNNe8x1+J6QtyZ6Wn
	 KTnSHGtSY5VPw08fOt9hdi2tzhprN6DsUeDmQ3jlXFGz2eOZdNEdhcT2SZqN0jmExc
	 5qq6Ot6E6be2A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id ACDEC378047F;
	Fri,  2 Feb 2024 10:04:39 +0000 (UTC)
Message-ID: <3e3aa372-cca4-4d3b-81e3-53abe3f384f2@collabora.com>
Date: Fri, 2 Feb 2024 11:04:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/18] thermal: Directly use
 thermal_zone_platform_params for thermal_zone_device
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: daniel.lezcano@linaro.org, miquel.raynal@bootlin.com,
 rui.zhang@intel.com, lukasz.luba@arm.com, support.opensource@diasemi.com,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, linux-imx@nxp.com, andersson@kernel.org,
 konrad.dybcio@linaro.org, amitk@kernel.org, thara.gopinath@gmail.com,
 niklas.soderlund@ragnatech.se, srinivas.pandruvada@linux.intel.com,
 baolin.wang@linux.alibaba.com, u.kleine-koenig@pengutronix.de,
 hayashi.kunihiko@socionext.com, d-gole@ti.com, linus.walleij@linaro.org,
 DLG-Adam.Ward.opensource@dm.renesas.com, error27@gmail.com, heiko@sntech.de,
 hdegoede@redhat.com, jernej.skrabec@gmail.com, f.fainelli@gmail.com,
 bchihi@baylibre.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, kernel@collabora.com
References: <20240130111250.185718-1-angelogioacchino.delregno@collabora.com>
 <20240130111250.185718-4-angelogioacchino.delregno@collabora.com>
 <CAJZ5v0g6YNDAUxaWK9KfM0tt2x4wqaCap4--UjSauwmfYiEgoA@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAJZ5v0g6YNDAUxaWK9KfM0tt2x4wqaCap4--UjSauwmfYiEgoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 01/02/24 20:42, Rafael J. Wysocki ha scritto:
> On Tue, Jan 30, 2024 at 12:13 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Remove all duplicate members from thermal_zone_device and directly
>> use the corresponding ones from struct thermal_zone_platform_params.
> 
> I totally disagree with this approach.
> 
> It does make sense to store these things in a tz directly.
> 
> 1. devdata allows the caller of the thermal zone to get to their own
> information on it conveniently.  This patch makes it harder.
> 2. It makes sense to copy type into tz to allow the zone creator to
> free the string (should they want to do that).
> 3. It would make sense to copy the contents of the trips[] table to tz
> to allow the zone creator to free their initial table.  This doesn't
> happen today, but it is in the works and your patch goes against this.
> 4. It makes sense to copy num_trips directly to tz, because it is
> closely related to trips[].
> 5. It makes sense to copy ops directly into tz, because this will
> allow zone creators to use const ops for zone registration.  Again,
> this doesn't happen today, but it is in the works and this patch goes
> against this.
> 
> As far as I'm concerned, this one is a total no-go.
> 

I'm sad for all the work that went into this - but at the same time I can also
understand your reasons.

I'll drop this one then!

Cheers,
Angelo

> Thanks!



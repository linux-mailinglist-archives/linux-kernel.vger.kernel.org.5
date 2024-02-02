Return-Path: <linux-kernel+bounces-49645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9CF846D69
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C33B2B247D6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D525179DCE;
	Fri,  2 Feb 2024 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SFr2seHN"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FF57C084;
	Fri,  2 Feb 2024 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706868658; cv=none; b=gnfgq7ernueKl2IgZ87BMcFCVkrgCSpdY9SPWTGWEX/QxVJwwskLd9gqFNIXdWgfXyWfjf5sy6wqYFW07vMmZ0051cHWlvF/ceJmlnononcQ64tGD8pQhCS8zJXX6msh24dXp9EYRdaChsVdCU/5zi4qJ8VwE9H2Z4K9qXn65nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706868658; c=relaxed/simple;
	bh=7/NtgM7POVlL/qsd67IvVANnHVtgkkq13BDU1rG2sow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvVKbfRWzAg4Q588TiQQSFstbavhada7AbdegvSwoj+nIY7TTPbbc7fUOiojhzQlJ+xZXG2uFLFLB3FUrxIO/iAb57a8Tb7BpRTdnPnyMR9oViNI1uhL2icHabgTqe/sLFS+QnRdP698icIfS0ebf65fx/LUZxZxXKDvfdeq5c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SFr2seHN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706868654;
	bh=7/NtgM7POVlL/qsd67IvVANnHVtgkkq13BDU1rG2sow=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SFr2seHNJQQHo9BBuC+NGMGdD/kv3Fz3jTKZu6zsnNCUOGGmA/hubOtnHRcgb8iwr
	 p4f3XnXa4zlR0UKwQ5q3BGtajbPyfoHSzoN2GMmQ0/kBH4/BkOZXa9oCRFrdkOA/7E
	 K8farMZWArbqNBLEhGRGcwLcc8mOTAfXykQjpf/hWF9QyRKCF2gCrcE5ijaUkfAf9W
	 ppn/+P3c7iVuuveYNkLMDGvXe6/j5lkMrqCUcbs65PPCdq8pm2nsROBy3QqPpptgEF
	 ZfYVajzxHIicOJqFOSBiOgcS2zkLcHpsmZgZHbfH4rjUcFqlqGu9qxfImGGdmnl0Dl
	 wNJ35d2virISg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5875A378047F;
	Fri,  2 Feb 2024 10:10:52 +0000 (UTC)
Message-ID: <eec1d1f7-6d8f-46e9-8ce5-4d7319da7d9e@collabora.com>
Date: Fri, 2 Feb 2024 11:10:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/18] thermal: intel: pch_thermal: Migrate to
 thermal_zone_device_register()
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
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, kernel@collabora.com
References: <20240130111250.185718-1-angelogioacchino.delregno@collabora.com>
 <20240130111250.185718-9-angelogioacchino.delregno@collabora.com>
 <CAJZ5v0ifn7eg9WrpNF2_PB62gE_BzV2Vx5_k7ebOoZWdQNVWaQ@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAJZ5v0ifn7eg9WrpNF2_PB62gE_BzV2Vx5_k7ebOoZWdQNVWaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 01/02/24 20:51, Rafael J. Wysocki ha scritto:
> On Tue, Jan 30, 2024 at 12:13 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> The thermal API has a new thermal_zone_device_register() function which
>> is deprecating the older thermal_zone_device_register_with_trips() and
>> thermal_tripless_zone_device_register().
>>
>> Migrate to the new thermal zone device registration function.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/thermal/intel/intel_pch_thermal.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
>> index b3905e34c507..73d7c2ac7dbc 100644
>> --- a/drivers/thermal/intel/intel_pch_thermal.c
>> +++ b/drivers/thermal/intel/intel_pch_thermal.c
>> @@ -160,6 +160,7 @@ static int intel_pch_thermal_probe(struct pci_dev *pdev,
>>                                     const struct pci_device_id *id)
>>   {
>>          enum pch_board_ids board_id = id->driver_data;
>> +       struct thermal_zone_device_params tzdp;
>>          struct pch_thermal_device *ptd;
>>          int nr_trips = 0;
>>          u16 trip_temp;
>> @@ -233,10 +234,13 @@ static int intel_pch_thermal_probe(struct pci_dev *pdev,
>>
>>          nr_trips += pch_wpt_add_acpi_psv_trip(ptd, nr_trips);
>>
>> -       ptd->tzd = thermal_zone_device_register_with_trips(board_names[board_id],
>> -                                                          ptd->trips, nr_trips,
>> -                                                          0, ptd, &tzd_ops,
>> -                                                          NULL, 0, 0);
>> +       tzdp.tzp.type = board_names[board_id];
>> +       tzdp.tzp.devdata = ptd;
>> +       tzdp.tzp.trips = ptd->trips;
>> +       tzdp.tzp.num_trips = nr_trips;
>> +       tzdp.tzp.ops = &tzd_ops;
>> +
>> +       ptd->tzd = thermal_zone_device_register(&tzdp);
> 
> IMV, this should be
> 
> ptd->tzd = thermal_zone_device_register(board_names[board_id],
> ptd->trips, nr_trips, &tzd_ops, ptd, NULL);
> 
> and the tzdp variable is not necessary even.
> 

The whole point of thermal_zone_device_register() taking just one parameter was
that those older functions were taking a bit too many params, and with the
introduction of Thermal Zone name we'd be adding even more.

For intel_pch_thermal, things are more or less the same, assignments are done there
line by line... but for most of the others, IMO it's easier and schematized as a
single stack-initialized structure that could even be constified in the future.

> Analogously in the rest of the series (ie. patches [4-18/18]).
> 
>>          if (IS_ERR(ptd->tzd)) {
>>                  dev_err(&pdev->dev, "Failed to register thermal zone %s\n",
>>                          board_names[board_id]);
>> --



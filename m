Return-Path: <linux-kernel+bounces-103628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E7D87C223
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87161F22210
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1AF745FD;
	Thu, 14 Mar 2024 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VnhCHumO"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D57C745E0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 17:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710437419; cv=none; b=m91JFnsPb3JwGnHnxfGTw0DJ54wC/lMS8SuWnWrwA4WPZjNAaY4QMng7pNcJDjOnKORFfTYo474oQNNec9xsEiSNQ53hagSZIJghGkBj1KFMqhlZKngfz/rXhNcAUs2jPQIGFh61mD5ZBuABWGASEIGAA8nCSpzYVluvXdowMMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710437419; c=relaxed/simple;
	bh=mvbufNwV6uuDAXa1Za1BY8YcXWB+UiVwFDzPNSHkqwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9Ngj3Ka+XcKMbzK6fqXL3W5wvCXu/UpGtwRBHaPBBpzq5grRBs+m2EGY8LwVPe+rxOdg68OMubr+s1z6uYZmvVPokbKxDFmvrP6rONLbaRhsBFrBF1YVMD+a3sh3x6iIQM/F5QTn3F2n5gWwwQ907PYqyo9BgtJHTIZS5RPrSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VnhCHumO; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a9ed95ec-aafe-49f6-93dd-c94c73620de2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710437415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JEBIKds7ABWFBzR1V0Wt+1agR4evvGmxh9zbarQta3w=;
	b=VnhCHumOkxcleb39VeThgoudLqqD/mLpqBVDSxM7QxzkuClZzRHq7SMzyrTSMLIitFAQqa
	eofiaPewK/4Z3tmEtoiz49+xrtpK5vINFQ2y5oanaW0uQgI45+yiPeqxQk/nxO93d95i2l
	TtXVPnZt2RVGUdfC51fYAD+ERj7kAPQ=
Date: Thu, 14 Mar 2024 13:30:11 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] iio: xilinx-ams: Don't include ams_ctrl_channels in
 scan_mask
Content-Language: en-US
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Conall O'Griofa <conall.ogriofa@amd.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>
References: <20240311162800.11074-1-sean.anderson@linux.dev>
 <20240314154824.37150a54@jic23-huawei>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240314154824.37150a54@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/14/24 11:48, Jonathan Cameron wrote:
> On Mon, 11 Mar 2024 12:28:00 -0400
> Sean Anderson <sean.anderson@linux.dev> wrote:
> 
>> ams_enable_channel_sequence constructs a "scan_mask" for all the PS and
>> PL channels. This works out fine, since scan_index for these channels is
>> less than 64. However, it also includes the ams_ctrl_channels, where
>> scan_index is greater than 64, triggering undefined behavior. Since we
>> don't need these channels anyway, just exclude them.
>> 
>> Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> 
> Hi Sean,
> 
> I'd ideally like to understand why we have channels with such large
> scan indexes.  Those values should only be used for buffered capture.
> It feels like they are being abused here.  Can we set them to -1 instead
> and check based on that?
> For a channel, a scan index of -1 means it can't be captured via the buffered
> interfaces but only accessed via sysfs reads.
> I think that's what we have here?

From what I can tell, none of the channels support buffered reads. And
we can't naïvely convert the scan_index to -1, since that causes sysfs
naming conflicts (not to mention the compatibility break).

> 
> I just feel like if we leave these as things stand, we will get bitten
> by similar bugs in the future.  At least with -1 it should be obvious why!

There are just as likely to be bugs confusing the PL/PS subdevices...

FWIW I had no trouble identifying the channels involved with this bug.

--Sean

> Jonathan
> 
> 
>> ---
>> 
>>  drivers/iio/adc/xilinx-ams.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
>> index a55396c1f8b2..4de7ce598e4d 100644
>> --- a/drivers/iio/adc/xilinx-ams.c
>> +++ b/drivers/iio/adc/xilinx-ams.c
>> @@ -414,8 +414,12 @@ static void ams_enable_channel_sequence(struct iio_dev *indio_dev)
>>  
>>  	/* Run calibration of PS & PL as part of the sequence */
>>  	scan_mask = BIT(0) | BIT(AMS_PS_SEQ_MAX);
>> -	for (i = 0; i < indio_dev->num_channels; i++)
>> -		scan_mask |= BIT_ULL(indio_dev->channels[i].scan_index);
>> +	for (i = 0; i < indio_dev->num_channels; i++) {
>> +		const struct iio_chan_spec *chan = &indio_dev->channels[i];
>> +
>> +		if (chan->scan_index < AMS_CTRL_SEQ_BASE)
>> +			scan_mask |= BIT_ULL(chan->scan_index);
>> +	}
>>  
>>  	if (ams->ps_base) {
>>  		/* put sysmon in a soft reset to change the sequence */
> 


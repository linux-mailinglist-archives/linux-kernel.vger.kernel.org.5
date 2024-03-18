Return-Path: <linux-kernel+bounces-106498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E6D87EF7D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B5B5B22233
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E6155E40;
	Mon, 18 Mar 2024 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SuphmOWZ"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8FB55C14
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710785550; cv=none; b=oFzAuFO3JQdlGASKfViFR2+DIopKe8R/frWSohny9mOlNYAcRgldsSqEn8bOcDgg+pCFHTwCkD4xOZRTykTzbr+/+1omdO07FcttRGHF4170YE3ndLembHXRJQS8BcmGG++ybLNLx0X+hChZ9xc7HJ8pM72g3oK2A7RFX1eU/xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710785550; c=relaxed/simple;
	bh=q0sZurVySS4J85bcn1Qd/r3D0KSYIDLkRWzpFrhP7wU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMEohUBhVUL+rQgVXMQIKB4mz2A4OTiY7hUiuQBB0lQxlq9KQGm47DsIIVms6VeKyyDNI7ah9rDt/G/U3I36KF/ApuWwkF02cDikQTyANcw5jEEDBC2vqVc1l8bi5wZiuzziazDRNkF+XW+CgKcoOVP+a7irkoF8bOa98mx74/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SuphmOWZ; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <66a7d0c1-b5c0-4789-82ef-0f72b68bec44@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710785546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PdqzyKI2koakcy8YsZ2jjX7q7e8S3iio9zSn4TLLUgE=;
	b=SuphmOWZaFROvQhwZIlGghHV0KPq2y3Pl672PwMULOJaIdI8Sv2nd2uVHWuiqGYkhn44MC
	eOBhR57lphO9vqYRiRZQQmyk5nm6u1dRMV54pyKP1EfOXm4b2hfyfQt+lP70Mu83H5PRiV
	Y6obgMQFF50IgPKs/CsuqKjG4/6JhoY=
Date: Mon, 18 Mar 2024 14:12:22 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 5/6] drm: zynqmp_dp: Optionally ignore DPCD errors
Content-Language: en-US
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 linux-kernel@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
 linux-arm-kernel@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>
References: <20240315230916.1759060-1-sean.anderson@linux.dev>
 <20240315230916.1759060-6-sean.anderson@linux.dev>
 <20240318174757.GL13682@pendragon.ideasonboard.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240318174757.GL13682@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/18/24 13:47, Laurent Pinchart wrote:
> Hi Sean,
> 
> Thank you for the patch.
> 
> On Fri, Mar 15, 2024 at 07:09:15PM -0400, Sean Anderson wrote:
>> When testing, it's convenient to be able to ignore DPCD errors if there
>> is test equipment which can't emulate a DPRX connected to the output.
>> Add some (currently-unused) options to ignore these errors and just
>> reconfigure our internal registers as we usually would.
> 
> This seems to be a problem that is not limited to the ZynqMP DP.
> Wouldn't it be better to solve it in the DRM DP DPCD helpers instead ?
> You could expose a parameter on the AUX bus in debugfs to ignore errors,
> and cause the drm_dp_dpcd_write*() functions to return 0.

I think this is probably the easiest thing. I'll add this for v2.

I think something similar might be nice for HPD events (instead of always
ignoring them in test mode). This would make it easier to add DPRX-driven
testing in the future.

--Sean

>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>> 
>>  drivers/gpu/drm/xlnx/zynqmp_dp.c | 37 ++++++++++++++++++++------------
>>  1 file changed, 23 insertions(+), 14 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
>> index 24043847dab4..040f7b88ee51 100644
>> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
>> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
>> @@ -628,6 +628,7 @@ static void zynqmp_dp_adjust_train(struct zynqmp_dp *dp,
>>   * zynqmp_dp_update_vs_emph - Update the training values
>>   * @dp: DisplayPort IP core structure
>>   * @train_set: A set of training values
>> + * @ignore_dpcd: Ignore DPCD errors
>>   *
>>   * Update the training values based on the request from sink. The mapped values
>>   * are predefined, and values(vs, pe, pc) are from the device manual.
>> @@ -635,15 +636,19 @@ static void zynqmp_dp_adjust_train(struct zynqmp_dp *dp,
>>   * Return: 0 if vs and emph are updated successfully, or the error code returned
>>   * by drm_dp_dpcd_write().
>>   */
>> -static int zynqmp_dp_update_vs_emph(struct zynqmp_dp *dp, u8 *train_set)
>> +static int zynqmp_dp_update_vs_emph(struct zynqmp_dp *dp, u8 *train_set,
>> +				    bool ignore_dpcd)
>>  {
>>  	unsigned int i;
>>  	int ret;
>>  
>>  	ret = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_LANE0_SET, train_set,
>>  				dp->mode.lane_cnt);
>> -	if (ret < 0)
>> -		return ret;
>> +	if (ret < 0) {
>> +		if (!ignore_dpcd)
>> +			return ret;
>> +		dev_warn(dp->dev, "failed to update vs/emph\n");
>> +	}
>>  
>>  	for (i = 0; i < dp->mode.lane_cnt; i++) {
>>  		u32 reg = ZYNQMP_DP_SUB_TX_PHY_PRECURSOR_LANE_0 + i * 4;
>> @@ -692,7 +697,7 @@ static int zynqmp_dp_link_train_cr(struct zynqmp_dp *dp)
>>  	 * So, This loop should exit before 512 iterations
>>  	 */
>>  	for (max_tries = 0; max_tries < 512; max_tries++) {
>> -		ret = zynqmp_dp_update_vs_emph(dp, dp->train_set);
>> +		ret = zynqmp_dp_update_vs_emph(dp, dp->train_set, false);
>>  		if (ret)
>>  			return ret;
>>  
>> @@ -757,7 +762,7 @@ static int zynqmp_dp_link_train_ce(struct zynqmp_dp *dp)
>>  		return ret;
>>  
>>  	for (tries = 0; tries < DP_MAX_TRAINING_TRIES; tries++) {
>> -		ret = zynqmp_dp_update_vs_emph(dp, dp->train_set);
>> +		ret = zynqmp_dp_update_vs_emph(dp, dp->train_set, false);
>>  		if (ret)
>>  			return ret;
>>  
>> @@ -785,11 +790,12 @@ static int zynqmp_dp_link_train_ce(struct zynqmp_dp *dp)
>>   * @lane_cnt: The number of lanes to use
>>   * @enhanced: Use enhanced framing
>>   * @downspread: Enable spread-spectrum clocking
>> + * @ignore_dpcd: Ignore DPCD errors; useful for testing
>>   *
>>   * Return: 0 on success, or -errno on failure
>>   */
>>  static int zynqmp_dp_setup(struct zynqmp_dp *dp, u8 bw_code, u8 lane_cnt,
>> -			   bool enhanced, bool downspread)
>> +			   bool enhanced, bool downspread, bool ignore_dpcd)
>>  {
>>  	u32 reg;
>>  	u8 aux_lane_cnt = lane_cnt;
>> @@ -812,21 +818,24 @@ static int zynqmp_dp_setup(struct zynqmp_dp *dp, u8 bw_code, u8 lane_cnt,
>>  
>>  	ret = drm_dp_dpcd_writeb(&dp->aux, DP_LANE_COUNT_SET, aux_lane_cnt);
>>  	if (ret < 0) {
>> -		dev_err(dp->dev, "failed to set lane count\n");
>> -		return ret;
>> +		dev_warn(dp->dev, "failed to set lane count\n");
>> +		if (!ignore_dpcd)
>> +			return ret;
>>  	}
>>  
>>  	ret = drm_dp_dpcd_writeb(&dp->aux, DP_MAIN_LINK_CHANNEL_CODING_SET,
>>  				 DP_SET_ANSI_8B10B);
>>  	if (ret < 0) {
>> -		dev_err(dp->dev, "failed to set ANSI 8B/10B encoding\n");
>> -		return ret;
>> +		dev_warn(dp->dev, "failed to set ANSI 8B/10B encoding\n");
>> +		if (!ignore_dpcd)
>> +			return ret;
>>  	}
>>  
>>  	ret = drm_dp_dpcd_writeb(&dp->aux, DP_LINK_BW_SET, bw_code);
>>  	if (ret < 0) {
>> -		dev_err(dp->dev, "failed to set DP bandwidth\n");
>> -		return ret;
>> +		dev_warn(dp->dev, "failed to set DP bandwidth\n");
>> +		if (!ignore_dpcd)
>> +			return ret;
>>  	}
>>  
>>  	zynqmp_dp_write(dp, ZYNQMP_DP_LINK_BW_SET, bw_code);
>> @@ -860,7 +869,7 @@ static int zynqmp_dp_train(struct zynqmp_dp *dp)
>>  
>>  	ret = zynqmp_dp_setup(dp, dp->mode.bw_code, dp->mode.lane_cnt,
>>  			      drm_dp_enhanced_frame_cap(dp->dpcd),
>> -			      dp->dpcd[3] & 0x1);
>> +			      dp->dpcd[3] & 0x1, false);
>>  	if (ret)
>>  		return ret;
>>  
>> @@ -877,7 +886,7 @@ static int zynqmp_dp_train(struct zynqmp_dp *dp)
>>  	ret = drm_dp_dpcd_writeb(&dp->aux, DP_TRAINING_PATTERN_SET,
>>  				 DP_TRAINING_PATTERN_DISABLE);
>>  	if (ret < 0) {
>> -		dev_err(dp->dev, "failed to disable training pattern\n");
>> +		dev_warn(dp->dev, "failed to disable training pattern\n");
>>  		return ret;
>>  	}
>>  	zynqmp_dp_write(dp, ZYNQMP_DP_TRAINING_PATTERN_SET,
> 



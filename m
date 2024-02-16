Return-Path: <linux-kernel+bounces-68541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 681CC857BFB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 748071C23D9F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22E978662;
	Fri, 16 Feb 2024 11:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VjhKYgWT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0921453385;
	Fri, 16 Feb 2024 11:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708083911; cv=none; b=PiY1yb7qUdHZgT9kfghzTR5O0OqLCNampft4ThuVI8svPFFcM6v1GdN+UtrRVbk8pUkOSq9bU8iVfgf7T7SG7s9KS2mZuizIrMpyQAElrcWWmpEDsPtJp6selFT5Qq4MrbC0AGt2ls0lEraken5PY3j1NybbWESK52BHVJMZ80E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708083911; c=relaxed/simple;
	bh=mRBF7+w/UhoTbou2jml16IOzj0jHowaNlat8Mii96JE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZH4GQ9Gig+ih8fR0M/dHx7SG+C9nZ9ljs9FFhkFQIqzKjLiqP0fzCAL53RCxoEWeRTD6BwR6QYKDsh/GXqnSDBUccvV9smN8YxG8LgZv1Bgwn4pIwv5bRr5kzg5pA79C18q4a1h/6Ljl/7CF0T6EVDrwg/gqJtJvdeVD2WiscSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VjhKYgWT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GAdI1K010032;
	Fri, 16 Feb 2024 11:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=FbhITBTJkpzDUA0S3Nn4DWF06crj1C5mUCjUAsD57SM=; b=Vj
	hKYgWTGzzZoGTVdITxb6Fh6bhs+rCnYlqXoA6ENJYt3Ah3xSHrRBNyFD2NQ1IFH7
	K7MZqhUuuTFm1u/FIjd3yNZAZQ0dDYV9np/BelPIIA6vZKYixBvYWUppNTpV1bW6
	IqZE5sxg8rB6rA4vjyVuP8Ar2mOG9nbmjF8YVsrv6nE2AbkopcaeWWM4g+n9Nt6s
	ZRQnAl1/9TLSyDogrMR9ZQiey6hNGT7MEa/Jnght1uCuBdvq5buwRcyfU/XmLQJP
	5nG8MiCHcyoOfFhBSi4pM1ltuvHP7F0sqeXrXnr61b6vEP8cxMuaPcTB8dmNsd4s
	eR3/eUqfJ0JjiAjh2TBA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9qbc1wg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 11:44:45 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41GBiio2011674
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 11:44:44 GMT
Received: from [10.218.16.59] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 16 Feb
 2024 03:44:33 -0800
Message-ID: <5dc98cf8-3146-400c-be2a-b0a1ec2368f7@quicinc.com>
Date: Fri, 16 Feb 2024 17:14:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
Content-Language: en-US
To: Jonathan Cameron <jic23@kernel.org>
CC: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <daniel.lezcano@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <lars@metafoo.de>, <luca@z3ntu.xyz>,
        <marijn.suijten@somainline.org>, <agross@kernel.org>,
        <sboyd@kernel.org>, <rafael@kernel.org>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>, <linus.walleij@linaro.org>,
        <quic_subbaram@quicinc.com>, <quic_collinsd@quicinc.com>,
        <quic_amelende@quicinc.com>, <quic_kamalw@quicinc.com>,
        <kernel@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-arm-msm-owner@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <cros-qcom-dts-watchers@chromium.org>
References: <20231231171237.3322376-1-quic_jprakash@quicinc.com>
 <20231231171237.3322376-4-quic_jprakash@quicinc.com>
 <20240101175453.5807483a@jic23-huawei>
From: Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <20240101175453.5807483a@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9Y1DnBZcC0CSA59oL9H_9bwEqTanH5RT
X-Proofpoint-ORIG-GUID: 9Y1DnBZcC0CSA59oL9H_9bwEqTanH5RT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_09,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160094

Hi Jonathan,

(Resending this mail for tracking on mailing lists, as it got rejected 
from lists the first time due to HTML)

On 1/1/2024 11:24 PM, Jonathan Cameron wrote:
> On Sun, 31 Dec 2023 22:42:37 +0530
> Jishnu Prakash <quic_jprakash@quicinc.com> wrote:
> 
>> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
>> with all SW communication to ADC going through PMK8550 which
>> communicates with other PMICs through PBS.
>>


>> +
>> +	for (i = 0; i < adc->nchannels; i++) {
>> +		bool upper_set = false, lower_set = false;
>> +		int temp, offset;
>> +		u16 code = 0;
>> +
>> +		chan_prop = &adc->chan_props[i];
>> +		offset = chan_prop->tm_chan_index;
>> +
>> +		if (!chan_prop->adc_tm)
>> +			continue;
>> +
>> +		mutex_lock(&adc->lock);
>> +		if (chan_prop->sdam_index != sdam_index) {
> 
> Perhaps factor this block out as indent already high and adding scoped_guard would
> make it worse.

I don't think I can completely factor it out, as we need to update 
several local variables here (sdam_index, tm_status, buf, also chan_prop 
above), but I'll try to reduce it as much as possible.

> 
>> +			sdam_index = chan_prop->sdam_index;
>> +			ret = adc5_gen3_read(adc, sdam_index, ADC5_GEN3_TM_HIGH_STS,
>> +					tm_status, 2);
>> +			if (ret) {
>> +				dev_err(adc->dev, "adc read TM status failed with %d\n", ret);
>> +				goto out;
>> +			}


>> +
>> +static void adc5_gen3_disable(void *data)
>> +{
>> +	struct adc5_chip *adc = data;
>> +	int i;
>> +
>> +	if (adc->n_tm_channels)
>> +		cancel_work_sync(&adc->tm_handler_work);
> If this is required before the place where a simple
> devm_request_irq() will result in the irqs being cleaned up
> them register this callback earlier to avoid problems there.
> 

On checking again, it looks like I can just use devm_request_irq() and 
avoid having to free irqs explicitly here and elsewhere. I'll  still 
need to call cancel_work_sync() and I think you have also asked me to 
keep this call in another comment below. I have another question for it 
below.

>> +
>> +	for (i = 0; i < adc->num_sdams; i++)
>> +		free_irq(adc->base[i].irq, adc);
>> +
>> +	mutex_lock(&adc->lock);
>> +	/* Disable all available TM channels */
>> +	for (i = 0; i < adc->nchannels; i++) {
>> +		if (!adc->chan_props[i].adc_tm)
>> +			continue;
>> +		adc5_gen3_poll_wait_hs(adc, adc->chan_props[i].sdam_index);
>> +		_adc_tm5_gen3_disable_channel(&adc->chan_props[i]);
>> +	}
>> +
>> +	mutex_unlock(&adc->lock);
>> +}
> 


>> +
>> +	prop->hw_settle_time = VADC_DEF_HW_SETTLE_TIME;
> 
> I'd prefer to see you has through the value that maps to this after qcom_adc5_hw_settle_time_from_dt
> so then you can just set a default in value and call the rest of the code unconditionally.
> Same for the cases that follow.

I can remove the return check for fwnode_property_read_u32() as you 
suggested, but I think we still need to keep the return check for 
qcom_adc5_hw_settle_time_from_dt(), to check in case values unsupported 
in this ADC HW are set in DT. Same for the other properties.

> 
>> +	ret = fwnode_property_read_u32(fwnode, "qcom,hw-settle-time", &value);
>> +	if (!ret) {
>> +		ret = qcom_adc5_hw_settle_time_from_dt(value,
>> +						data->hw_settle_1);
>> +		if (ret < 0)
>> +			return dev_err_probe(dev, ret, "%#x invalid hw-settle-time %d us\n",
>> +				chan, value);
>> +		prop->hw_settle_time = ret;
>> +	}
>> +


>> +
>> +	chan_props = adc->chan_props;
>> +	adc->n_tm_channels = 0;
>> +	iio_chan = adc->iio_chans;
>> +	adc->data = device_get_match_data(adc->dev);
>> +	if (!adc->data)
>> +		adc->data = &adc5_gen3_data_pmic;
> 
> Why do you need a default?  Add a comment so we remember the reasoning.

On second thought, this may not be needed, I'll remove this.

> 
> 
>> +
>> +	device_for_each_child_node(adc->dev, child) {
>> +		ret = adc5_gen3_get_fw_channel_data(adc, chan_props, child, adc->data);
>> +		if (ret < 0) {


>> +
>> +		ret = platform_get_irq_byname(pdev, adc->base[i].irq_name);
>> +		if (ret < 0) {
>> +			kfree(reg);
>> +			dev_err(dev, "Getting IRQ %d by name failed, ret = %d\n",
>> +					adc->base[i].irq, ret);
>> +			goto err_irq;
>> +		}
>> +		adc->base[i].irq = ret;
>> +
>> +		ret = request_irq(adc->base[i].irq, adc5_gen3_isr, 0, adc->base[i].irq_name, adc);
> 
> Don't mix devm and non dev calls.  And don't group up multiple things in one devm callback
> as it almost always leads to bugs where for example only some irqs are allocated.

I can replace request_irq() with devm_request_irq(). But when you say 
not to group up multiple things in one devm callback, do you mean the 
devm_add_action() callback I added below or something else right here?



> 
>> +		if (ret < 0) {
>> +			kfree(reg);
>> +			dev_err(dev, "Failed to request SDAM%d irq, ret = %d\n", i, ret);
>> +			goto err_irq;
>> +		}
>> +	}
>> +	kfree(reg);
> 
> I would factor out this code and allocation of reg so you can easily use scope
> based cleanup (see linux/cleanup.h) to avoid the kfree(reg) entries that
> make for awkward code flow.
> 

The kfrees are not really needed, I'll just use devm_kcalloc to allocate 
memory for the "reg" variable. With this and devm_request_irq, I think a 
scoped guard would not be needed here.


> 
> 
>> +
>> +	ret = devm_add_action(dev, adc5_gen3_disable, adc);
> As above, this action does multiple things. Also use devm_add_action_or_reset() to cleanup
> if the devm registration fails without needing to do it manually.

I'll change it to devm_add_action_or_reset(), but do you mean I should 
call devm_add_action_or_reset() twice to register two separate callbacks 
instead of just adc5_gen3_disable? Like one for calling 
cancel_work_sync() alone and the other for the loop where we disable all 
TM channels?


> 
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to register adc disablement devm action, %d\n", ret);
>> +		goto err_irq;
>> +	}
>> +


>> +
>> +	if (adc->n_tm_channels)
>> +		INIT_WORK(&adc->tm_handler_work, tm_handler_work);
> 
> Until this init work seems unlikely you should be calling the cancel
> work in gen3_disable()

We are already calling cancel_work_sync() in adc5_gen3_disable....is 
there any change needed?


I'll address all your other comments in the next patchset.


Thanks,

Jishnu

> 
> 
>> +
>> +	indio_dev->name = pdev->name;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->info = &adc5_gen3_info;
>> +	indio_dev->channels = adc->iio_chans;
>> +	indio_dev->num_channels = adc->nchannels;
>> +
>> +	ret = devm_iio_device_register(dev, indio_dev);
>> +	if (!ret)
>> +		return 0;
> Please keep error conditions as the out of line path.
> 
> 	if (ret)
> 		goto err_irq;
> 
> 	return 0;
> 
> 
>> +
>> +err_irq:
>> +	for (i = 0; i < adc->num_sdams; i++)
>> +		free_irq(adc->base[i].irq, adc);
> 
> Already freed by a devm cleanup handler.
> 
>> +
>> +	return ret;
>> +}
> 


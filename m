Return-Path: <linux-kernel+bounces-146284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E7A8A6334
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F3C2866B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6571A3BB23;
	Tue, 16 Apr 2024 05:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OEdYyjHG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FE91FA1;
	Tue, 16 Apr 2024 05:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713246328; cv=none; b=i2gnKe/EU29mLm4oFb8yO/XvFOLzdqE93lCSpQzazvNeSIQiegUJmzwHf64ef3sCIK+o/+5G7Hhd7v2WVReNZE/lLE/OTi9vOB+RZXAuNB289riVhJK/Ek/wFlcsPKMbvDxSDhAf2f032QHejHLiO6GnHu4FCJHS+4nD7Q1jjUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713246328; c=relaxed/simple;
	bh=YwGsIv8xfq5BgTWG1Fl6HOm/VwjAIi1O3kYC6m1La5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZlfEPHtz+WpUy3xF4q/2OBdWvR3gnXY4JDGCE8aCH71+xe+NoKq8YmfqwnuTuFRIR2M7SVnWwz3exX6PnNNk7Nx7y9xKF2I/aogbn4jNoIsxlS4oUgTcaFn8wYNOL2pRGtlDD7iDV0RU4DVB6KZaWVwFZ12KilGgQ5Nu8W5izVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OEdYyjHG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43G1OYBL018775;
	Tue, 16 Apr 2024 05:45:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Lm4snjilVOnrWSUtHCVQ8VwoR2bvqt7xK1cAHv8/IcQ=; b=OE
	dYyjHG6NlobPMiPY1rvlJImFDv1elFgrCJP5xmE9liwSN06UWLzFGNrOJSU71Oz5
	sMA3qsOCmQbRic4GBbBhp41kaDh16iwOHGRWWeVHoMMJ0f4PXPwpWrJbw953bo5e
	ZpZBwtTJTPnebAc3TNtCqU/pGUD7hqiKMX2DRNBVEbZRX2S7L8GXP8ngIN8ZaPbP
	NRlOFPaWoNhBn2CIgqQ13/SVY4Y503UO/qkNHZXFUyvcT1LkaRETAiLzgIwkxwZi
	0Pb6/rCpEemgoCfZ4MEPD08syZEZed7P5F4ruvkxNYeocmCTLb7+C4TYMLsEPnZl
	Ns+cmpU6oS+lBnx1BbZQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xhbg88wk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 05:45:23 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43G5jMQ7020848
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 05:45:22 GMT
Received: from [10.239.29.179] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Apr
 2024 22:45:20 -0700
Message-ID: <a62cb28a-e6ab-4f60-9210-b7aa8e0c34e0@quicinc.com>
Date: Tue, 16 Apr 2024 13:45:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] bus: mhi: host: Add sysfs entry to force device to
 enter EDL
To: Manivannan Sadhasivam <mani@kernel.org>
CC: <quic_jhugo@quicinc.com>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_cang@quicinc.com>, <quic_mrana@quicinc.com>
References: <1713170945-44640-1-git-send-email-quic_qianyu@quicinc.com>
 <1713170945-44640-2-git-send-email-quic_qianyu@quicinc.com>
 <20240415115616.GF7537@thinkpad>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <20240415115616.GF7537@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GkEnRks3-gBJpxp1S878OUUo2hiOXMq_
X-Proofpoint-ORIG-GUID: GkEnRks3-gBJpxp1S878OUUo2hiOXMq_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_02,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404160033


On 4/15/2024 7:56 PM, Manivannan Sadhasivam wrote:
> On Mon, Apr 15, 2024 at 04:49:03PM +0800, Qiang Yu wrote:
>> Add sysfs entry to allow users of MHI bus force device to enter EDL.
>> Considering that the way to enter EDL mode varies from device to device and
>> some devices even do not support EDL. Hence, add a callback edl_trigger in
>> mhi controller as part of the sysfs entry to be invoked and MHI core will
>> only create EDL sysfs entry for mhi controller that provides edl_trigger
>> callback. All of the process a specific device required to enter EDL mode
>> can be placed in this callback.
>>
>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>> ---
>>   Documentation/ABI/stable/sysfs-bus-mhi | 11 +++++++++++
>>   drivers/bus/mhi/host/init.c            | 35 ++++++++++++++++++++++++++++++++++
>>   include/linux/mhi.h                    |  2 ++
>>   3 files changed, 48 insertions(+)
>>
>> diff --git a/Documentation/ABI/stable/sysfs-bus-mhi b/Documentation/ABI/stable/sysfs-bus-mhi
>> index 1a47f9e..d0bf9ae 100644
>> --- a/Documentation/ABI/stable/sysfs-bus-mhi
>> +++ b/Documentation/ABI/stable/sysfs-bus-mhi
>> @@ -29,3 +29,14 @@ Description:	Initiates a SoC reset on the MHI controller.  A SoC reset is
>>                   This can be useful as a method of recovery if the device is
>>                   non-responsive, or as a means of loading new firmware as a
>>                   system administration task.
>> +
>> +What:           /sys/bus/mhi/devices/.../force_edl
> s/force_edl/trigger_edl
>
>> +Date:           April 2024
>> +KernelVersion:  6.9
>> +Contact:        mhi@lists.linux.dev
>> +Description:    Force devices to enter EDL (emergency download) mode. Only MHI
> How can the user trigger EDL mode? Writing to this file? If so, what is the
> value?

User can trigger EDL mode by writing a non-zero value to this file.

>
> 'Emergency Download'
>
>> +                controller that supports EDL mode and provides a mechanism for
>> +                manually triggering EDL contains this file. Once in EDL mode,
> 'This entry only exists for devices capable of entering the EDL mode using the
> standard EDL triggering mechanism defined in the MHI spec <insert the version>.'
>
>> +                the flash programmer image can be downloaded to the device to
>> +                enter the flash programmer execution environment. This can be
>> +                useful if user wants to update firmware.
> It'd be good to mention the OS tool like QDL that is used to download firmware
> over EDL.

OK, can I add an additionnal line like this
Users:          Any OS tools that is used to download firmware over EDL 
like QDL.

>
>> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
>> index 44f9349..333ac94 100644
>> --- a/drivers/bus/mhi/host/init.c
>> +++ b/drivers/bus/mhi/host/init.c
>> @@ -127,6 +127,32 @@ static ssize_t soc_reset_store(struct device *dev,
>>   }
>>   static DEVICE_ATTR_WO(soc_reset);
>>   
>> +static ssize_t force_edl_store(struct device *dev,
> s/force_edl/trigger_edl
>
>> +			       struct device_attribute *attr,
>> +			       const char *buf, size_t count)
>> +{
>> +	struct mhi_device *mhi_dev = to_mhi_device(dev);
>> +	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
>> +	unsigned long val;
>> +	int ret;
>> +
>> +	ret = kstrtoul(buf, 10, &val);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Could not parse string: %d\n", ret);
> No need to print error.
>
>> +		return ret;
>> +	}
>> +
>> +	if (!val)
>> +		return count;
> What does this mean?

If user want to trigger EDL mode,he has to write a non-zero value to this
file. If he writes zero, nothing will happen.

Do we need to limit the valid value to a specific value like 1?

>
>> +
>> +	ret = mhi_cntrl->edl_trigger(mhi_cntrl);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return count;
>> +}
>> +static DEVICE_ATTR_WO(force_edl);
>> +
>>   static struct attribute *mhi_dev_attrs[] = {
>>   	&dev_attr_serial_number.attr,
>>   	&dev_attr_oem_pk_hash.attr,
>> @@ -1018,6 +1044,12 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
>>   	if (ret)
>>   		goto err_release_dev;
>>   
>> +	if (mhi_cntrl->edl_trigger) {
>> +		ret = sysfs_create_file(&mhi_dev->dev.kobj, &dev_attr_force_edl.attr);
>> +		if (ret)
>> +			goto err_release_dev;
>> +	}
>> +
>>   	mhi_cntrl->mhi_dev = mhi_dev;
>>   
>>   	mhi_create_debugfs(mhi_cntrl);
>> @@ -1051,6 +1083,9 @@ void mhi_unregister_controller(struct mhi_controller *mhi_cntrl)
>>   	mhi_deinit_free_irq(mhi_cntrl);
>>   	mhi_destroy_debugfs(mhi_cntrl);
>>   
>> +	if (mhi_cntrl->edl_trigger)
>> +		sysfs_remove_file(&mhi_dev->dev.kobj, &dev_attr_force_edl.attr);
>> +
>>   	destroy_workqueue(mhi_cntrl->hiprio_wq);
>>   	kfree(mhi_cntrl->mhi_cmd);
>>   	kfree(mhi_cntrl->mhi_event);
>> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
>> index cde01e1..8280545 100644
>> --- a/include/linux/mhi.h
>> +++ b/include/linux/mhi.h
>> @@ -353,6 +353,7 @@ struct mhi_controller_config {
>>    * @read_reg: Read a MHI register via the physical link (required)
>>    * @write_reg: Write a MHI register via the physical link (required)
>>    * @reset: Controller specific reset function (optional)
>> + * @edl_trigger: CB function to enter EDL mode (optional)
> s/enter/trigger
>
> - Mani
>


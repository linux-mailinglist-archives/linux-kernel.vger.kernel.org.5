Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0248A7CED15
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 03:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjJSBBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 21:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjJSBBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 21:01:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA47B8;
        Wed, 18 Oct 2023 18:01:10 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39J0VwMb031097;
        Thu, 19 Oct 2023 01:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cR1dwz0zXrLfTDcJcqzJYdtdZWzRK0fZ1IO29Q5Vzxw=;
 b=UyKHNnGHiU45oj+7DOr0fR6/vIuf0UMhACCTkf3dO2j2IXb0ARbdutVkQNfTEKmKy0D/
 2gH43Xubt53BjRxgqxrZx1Nd9ZpQnt9sP1bKRGNLVvGBbXlzFgiMPZlO4dQZasD6xyuj
 CH7dT6uGdcJKNj87tUDmOSGlXEZWgeQv3XqieGAN2kCxu+yk40OKR2yC6Hf3gtlDj6HW
 DGsLFH/PaCl2qvy3ha7eeO9a9Bj5SX3+XoJ4GeZsMKfLTxp1FwDtZp8lKj8kPDz6YAmU
 9YcYF+tpkoPuunvMJwYnFequcNcKkrdE0m17pTI3HTSBQJIk7iE3D3p/opbeHzYCJXn8 3A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ttg82sde0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 01:00:54 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39J10rq6015142
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 01:00:53 GMT
Received: from [10.110.123.255] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 18 Oct
 2023 18:00:52 -0700
Message-ID: <1620550b-bbd5-bca3-c95b-6a01d3aed7f7@quicinc.com>
Date:   Wed, 18 Oct 2023 18:00:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v9 28/34] ASoC: qcom: qdsp6: Add support to track
 available USB PCM devices
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20231017200109.11407-1-quic_wcheng@quicinc.com>
 <20231017200109.11407-29-quic_wcheng@quicinc.com>
 <7d596a0a-fb98-458a-bd74-d22f15c0f0d8@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <7d596a0a-fb98-458a-bd74-d22f15c0f0d8@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _DIVjw2Tl3aBovN25ss1PqPWynBB9R_n
X-Proofpoint-ORIG-GUID: _DIVjw2Tl3aBovN25ss1PqPWynBB9R_n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_19,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310190005
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 10/17/2023 3:43 PM, Pierre-Louis Bossart wrote:
> 
> 
> On 10/17/23 15:01, Wesley Cheng wrote:
>> The USB backend should know about which sound resources are being shared
>> between the ASoC and USB SND paths.  This can be utilized to properly
>> select and maintain the offloading devices.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   sound/soc/qcom/qdsp6/q6usb.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/sound/soc/qcom/qdsp6/q6usb.c b/sound/soc/qcom/qdsp6/q6usb.c
>> index 329a7d4a3c01..d697cbe7f184 100644
>> --- a/sound/soc/qcom/qdsp6/q6usb.c
>> +++ b/sound/soc/qcom/qdsp6/q6usb.c
>> @@ -25,10 +25,18 @@
>>   
>>   #define SID_MASK	0xF
>>   
>> +struct q6usb_status {
>> +	unsigned int num_pcm;
> 
> how would one know which ones are capture and which ones are playback?
> 
> This really looks like a playback-only assumption, despite earlier
> mentions of capture supported.
> 

Yes, playback only, which is the reasoning for only having one parameter 
here.  I will rename it though to be clearer.

Thanks
Wesley Cheng

>> +	unsigned int chip_index;
>> +	unsigned int pcm_index;
>> +};
>> +
>>   struct q6usb_port_data {
>>   	struct q6afe_usb_cfg usb_cfg;
>>   	struct snd_soc_usb *usb;
>>   	struct q6usb_offload priv;
>> +	unsigned long available_card_slot;
>> +	struct q6usb_status status[SNDRV_CARDS];
>>   	int active_idx;
>>   };
>>   
>> @@ -110,6 +118,14 @@ static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb,
>>   	if (connected) {
>>   		/* We only track the latest USB headset plugged in */
>>   		data->active_idx = sdev->card_idx;
>> +
>> +		set_bit(sdev->card_idx, &data->available_card_slot);
>> +		data->status[sdev->card_idx].num_pcm = sdev->num_playback;
> 
> there you go...
> 
>> +		data->status[sdev->card_idx].chip_index = sdev->chip_idx;
>> +	} else {
>> +		clear_bit(sdev->card_idx, &data->available_card_slot);
>> +		data->status[sdev->card_idx].num_pcm = 0;
>> +		data->status[sdev->card_idx].chip_index = 0;
>>   	}
>>   
>>   	return 0;

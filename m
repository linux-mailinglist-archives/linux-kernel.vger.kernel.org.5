Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF6E7B0D05
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 21:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjI0T6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 15:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjI0T6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 15:58:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F9110E;
        Wed, 27 Sep 2023 12:58:17 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RJRS1m018853;
        Wed, 27 Sep 2023 19:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rYcnAHiw6usl3QH9sjFDJFDGeRzeKYUgES1JtPSdelw=;
 b=I2Tcn7LVEa0xJm0dobfdy3MRwSAvjCXeSjk6bcEKgzVEFJe7As6IgXbfMOl9iu6zh2gP
 c9pQX7TYcpEJqKf48ohFp6LBwDVw3sBIeJ85rP8bl4lzmsNa8gj56SmUAMIklooW78NI
 b+6nGkufnORaiQVOXJy3YpNMIB+m3kteyeMjl8ZLX9sEGBV2i9xqs4L1I4CSj1fkZpI6
 DrCRoW4HCFvaTSab4LfCmrtbxVOa0gc0g/b7SLVCgDTwJbV6HzFqo+trC8kk4GS4gaBv
 NtSDWCqZIFh0j6N6LemFJq0MXyATfTfOL9AvUhuE1F1JkiPqYP7dGA4uVbYWz0O5U0tS iQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tcfp6hhcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 19:57:54 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38RJvqZn029066
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 19:57:52 GMT
Received: from [10.110.25.80] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 27 Sep
 2023 12:57:52 -0700
Message-ID: <cdd947b2-0272-723b-77ad-c81c5417eac7@quicinc.com>
Date:   Wed, 27 Sep 2023 12:57:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 06/33] ASoC: Add SOC USB APIs for adding an USB backend
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20230921214843.18450-1-quic_wcheng@quicinc.com>
 <20230921214843.18450-7-quic_wcheng@quicinc.com>
 <ZRRAxSlk8uvsfMcx@finisterre.sirena.org.uk>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <ZRRAxSlk8uvsfMcx@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QlIsD3uzMaugVSohs0dpbsgua4zKq2wZ
X-Proofpoint-GUID: QlIsD3uzMaugVSohs0dpbsgua4zKq2wZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_12,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1011 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 mlxlogscore=482 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270169
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 9/27/2023 7:48 AM, Mark Brown wrote:
> On Thu, Sep 21, 2023 at 02:48:16PM -0700, Wesley Cheng wrote:
> 
>> +static struct device_node *snd_soc_find_phandle(struct device *dev)
>> +{
>> +	struct device_node *node;
>> +
>> +	node = of_parse_phandle(dev->of_node, "usb-soc-be", 0);
> 
> Very nitpicky but this function possibly wants a _usb_ in the name, not
> that it *super* matters with it being static.  Or it could just be
> inlined into the only user and not worry about the naming at all.
> 

Thanks for the review!  Sure, let me reshuffle things around a bit and 
just get rid of this function entirely and inline it to the API below.

>> +/**
>> + * snd_soc_usb_get_priv_data() - Retrieve private data stored
>> + * @dev: device reference
>> + *
>> + * Fetch the private data stored in the USB SND SOC structure.
>> + *
>> + */
>> +void *snd_soc_usb_get_priv_data(struct device *dev)
>> +{
>> +	struct snd_soc_usb *ctx;
>> +
>> +	ctx = snd_soc_find_usb_ctx(dev);
>> +	if (!ctx) {
>> +		/* Check if backend device */
>> +		mutex_lock(&ctx_mutex);
>> +		list_for_each_entry(ctx, &usb_ctx_list, list) {
>> +			if (dev->of_node == ctx->dev->of_node) {
>> +				mutex_unlock(&ctx_mutex);
>> +				goto out;
>> +			}
>> +		}
>> +		mutex_unlock(&ctx_mutex);
>> +		ctx = NULL;
>> +	}
> 
> This seems a lot more expensive than I'd expect for a get_priv_data
> operation, usually it's just a container_of() or other constant time
> pulling out of a pointer rather than a linked list walk - the sort of
> thing that people put at the start of functions and do all the time.
> If we need this I think it needs a name that's more clearly tied to the
> use case.
> 
> I didn't actually find the user of this though?

So the end user of this would be the qc_audio_offload driver, within 
prepare_qmi_response().  This is to fetch some information about the 
DPCM backend during the stream enable request.

Previously, I limited the # of snd_soc_usb ports to be registered to 
one, but that would affect the scalability of this layer.  Hence, adding 
a list instead increased the complexity.  Will rename this accordingly.

Thanks
Wesley Cheng


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C4A7632F2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbjGZJ5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjGZJ4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:56:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E6C1724;
        Wed, 26 Jul 2023 02:55:42 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q69iHS020307;
        Wed, 26 Jul 2023 09:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kzoRlk5carqDtnNugenB7ivRrMCCf/zpBHHPfUp3Oj4=;
 b=TMj/B3aR8u2F9lVF8q3b6K36G6EL5G6jLmiP5l1bwdxrxcze8qX/cJdh1qjTAIZQiwmM
 rMGUv6MrtVfC1tThbXa7dLaPCtODBFKQm2EYt3JkncUV1oTHZooG33IQlWdNuJe7aD23
 A2eYo47t0vSCsdgxbScnWzmNXK83eMCbUBzoP7iABFlT4H3znxgwoYmFtmmAFkeifqPW
 U5RCYR6RG7kBMymBOMYn8ZctxC2DyCCe1M2zPhMn184JThevO8XU4q1GfxE31XrKrdix
 6h01rXRJMQMHbgkeDYFN/0ShJAD9PS/GXpRujHla5U3scNx3r2hC6VIo1AnP4xnJU5Ij TA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2draakfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 09:55:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36Q9taq6019132
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 09:55:36 GMT
Received: from [10.217.219.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 26 Jul
 2023 02:55:06 -0700
Message-ID: <3f4ebebb-b1cb-27da-053f-146c8699c16e@quicinc.com>
Date:   Wed, 26 Jul 2023 15:25:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: usb: common: usb-conn-gpio: Prevent bailing out if initial role
 is none
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1688638258-23806-1-git-send-email-quic_prashk@quicinc.com>
 <2023072517-revocable-squiggly-de1c@gregkh>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <2023072517-revocable-squiggly-de1c@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cd4gVA2QL_lvy8E-sUR62OOQGKXsn8UP
X-Proofpoint-ORIG-GUID: cd4gVA2QL_lvy8E-sUR62OOQGKXsn8UP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_04,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307260088
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25-07-23 09:04 pm, Greg Kroah-Hartman wrote:
> On Thu, Jul 06, 2023 at 03:40:58PM +0530, Prashanth K wrote:
>> Currently if we bootup a device without cable connected, then
>> usb-conn-gpio won't call set_role() since last_role is same as
>> current role. This happens because during probe last_role gets
>> initialised to zero.
>>
>> To avoid this, add a new flag initial_det in usb_conn_info,
>> which is used to prevent bailing out during init detection.
>>
>> Fixes: 4602f3bff266 ("usb: common: add USB GPIO based connection detection driver")
>> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
>> ---
>>   drivers/usb/common/usb-conn-gpio.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
>> index 766005d..46290ff 100644
>> --- a/drivers/usb/common/usb-conn-gpio.c
>> +++ b/drivers/usb/common/usb-conn-gpio.c
>> @@ -42,6 +42,7 @@ struct usb_conn_info {
>>   
>>   	struct power_supply_desc desc;
>>   	struct power_supply *charger;
>> +	bool initial_det;
> 
> What does "initial_det" mean?  Please document this better.
> 
Yea sure, will update that. It was supposed to mean initial_detection.
>>   };
>>   
>>   /*
>> @@ -86,11 +87,13 @@ static void usb_conn_detect_cable(struct work_struct *work)
>>   	dev_dbg(info->dev, "role %s -> %s, gpios: id %d, vbus %d\n",
>>   		usb_role_string(info->last_role), usb_role_string(role), id, vbus);
>>   
>> -	if (info->last_role == role) {
>> +	if (!info->initial_det && info->last_role == role) {
>>   		dev_warn(info->dev, "repeated role: %s\n", usb_role_string(role));
>>   		return;
>>   	}
>>   
>> +	info->initial_det = false;
>> +
>>   	if (info->last_role == USB_ROLE_HOST && info->vbus)
>>   		regulator_disable(info->vbus);
>>   
>> @@ -258,6 +261,7 @@ static int usb_conn_probe(struct platform_device *pdev)
>>   	device_set_wakeup_capable(&pdev->dev, true);
>>   
>>   	/* Perform initial detection */
>> +	info->initial_det = true;
> 
> What is protecting this from changing right after you test for it?
> 
> thanks,
> 
> greg k-h

Hi Greg, this variable is only used/changed by usb_conn_detect_cable() 
which is called in next line. So the chance of it changing is none.
Basically this initial_det flag points if its initial detection or not.
If yes, then prevent bailing out in usb_conn_detect_cable(). Please let 
me know if your comment was regarding something else.

Regards,
Prashanth K

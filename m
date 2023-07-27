Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042C27644F4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 06:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjG0EgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 00:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjG0Efr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:35:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E322D71;
        Wed, 26 Jul 2023 21:35:34 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R4MGde016218;
        Thu, 27 Jul 2023 04:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lr1O2/fqY/tdCWW1Hc/tNbvb7RuLU+SK6JLc95tIgxc=;
 b=K2AsIZryO2C5Euep2CCWCIafDbpuM351m0jNqIiiTMMKRSE9VQFQqE97NSjxun1qQa/o
 lKeo8MR3EYSzBthQj/bPNsdd1RxoIKNUI9cxTGimWZPBSGVjs5gwAXIF2KWeRE0GOQOc
 /iGUCYoUk2r72ENifrtgv3IcA9ZQlSe0JYTZwwsMySiASNPPA3ydefmSOD/Pgwij02Xy
 6jZA8ydkCqKAuBUvM0qtKCuxlp5OOuWFyTbHqzGhR5MxmXezQHFOjVR/1waZ9jfZlmYv
 kF5nMFJOQNSwYjk+hrpIQfFlrOaSKL5m7AmPYZusEDDaKU1nJLDc+AS0OgBCT+drr5de eQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s31059xtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 04:35:29 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36R4Z36h023268
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 04:35:03 GMT
Received: from [10.239.104.229] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 26 Jul
 2023 21:35:01 -0700
Message-ID: <3c590f6f-bb57-b932-b746-8a189bac332c@quicinc.com>
Date:   Thu, 27 Jul 2023 12:34:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v12 1/2] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth SoC QCA2066
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
CC:     <marcel@holtmann.org>, <linux-kernel@vger.kernel.org>,
        <linux-bluetooth@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_bgodavar@quicinc.com>, <quic_hemantg@quicinc.com>
References: <20230726052245.609987-1-quic_tjiang@quicinc.com>
 <20230726052245.609987-2-quic_tjiang@quicinc.com>
 <ZMDETVMUmJxmbIvW@hovoldconsulting.com>
From:   Tim Jiang <quic_tjiang@quicinc.com>
In-Reply-To: <ZMDETVMUmJxmbIvW@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qof94Jn64lVETVQ9R7S0CMQPK9vtvEeg
X-Proofpoint-GUID: qof94Jn64lVETVQ9R7S0CMQPK9vtvEeg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307270041
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan:

   I will address your comments in v13 version.


regards

On 7/26/23 14:59, Johan Hovold wrote:
> Please fix up the subject of this patch, which should be different from
> patch 2/2 and instead summarise what *this* patch does.
>
> Note that keeping the same 2/2 subject on the cover letter is fine as
> 2/2 is the primary patch and sort of summarises the series.
>
> On Wed, Jul 26, 2023 at 01:22:44PM +0800, Tim Jiang wrote:
>> This patch make the print btsoc type expression more clearly.
>>
>> Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
>> ---
>>   drivers/bluetooth/btqca.h   |  1 +
>>   drivers/bluetooth/hci_qca.c | 34 ++++++++++++++++++++++++++++++----
>>   2 files changed, 31 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
>> index b884095bcd9d..529382f0abb1 100644
>> --- a/drivers/bluetooth/btqca.h
>> +++ b/drivers/bluetooth/btqca.h
>> @@ -148,6 +148,7 @@ enum qca_btsoc_type {
>>   	QCA_QCA6390,
>>   	QCA_WCN6750,
>>   	QCA_WCN6855,
>> +	QCA_QCA2066,
> This belongs in the next patch.
>
> These are currently not sorted by probably should be to make it easier
> to look up and add new entries. This could be done in a third,
> preparatory, patch.
>
>>   };
>>   
>>   #if IS_ENABLED(CONFIG_BT_QCA)
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 9b785c947d96..453000df7aec 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -1748,6 +1748,7 @@ static int qca_setup(struct hci_uart *hu)
>>   	const char *firmware_name = qca_get_firmware_name(hu);
>>   	int ret;
>>   	struct qca_btsoc_version ver;
>> +	const char *soc_name;
>>   
>>   	ret = qca_check_speeds(hu);
>>   	if (ret)
>> @@ -1762,10 +1763,35 @@ static int qca_setup(struct hci_uart *hu)
>>   	 */
>>   	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
>>   
>> -	bt_dev_info(hdev, "setting up %s",
>> -		qca_is_wcn399x(soc_type) ? "wcn399x" :
>> -		(soc_type == QCA_WCN6750) ? "wcn6750" :
>> -		(soc_type == QCA_WCN6855) ? "wcn6855" : "ROME/QCA6390");
>> +	switch (soc_type) {
>> +	case QCA_AR3002:
>> +		soc_name = "ar300x";
>> +		break;
>> +	case QCA_ROME:
>> +		soc_name = "ROME";
>> +		break;
>> +	case QCA_WCN3990:
>> +	case QCA_WCN3991:
>> +	case QCA_WCN3998:
>> +		soc_name = "wcn399x";
>> +		break;
>> +	case QCA_QCA2066:
>> +		soc_name = "QCA2066";
>> +		break;
> This also belongs in the next patch.
>
>> +	case QCA_QCA6390:
>> +		soc_name = "QCA6390";
>> +		break;
>> +	case QCA_WCN6750:
>> +		soc_name = "wcn6750";
>> +		break;
>> +	case QCA_WCN6855:
>> +		soc_name = "wcn6855";
>> +		break;
>> +	default:
>> +		soc_name = "unknown soc";
>> +		break;
>> +	}
> And you should probably sort the above as well.
>
>> +	bt_dev_info(hdev, "setting up %s", soc_name);
>>   
>>   	qca->memdump_state = QCA_MEMDUMP_IDLE;
> Johan

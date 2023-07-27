Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1D1764922
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjG0HoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbjG0Hma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:42:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E41E4C09;
        Thu, 27 Jul 2023 00:36:30 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R3unVG008044;
        Thu, 27 Jul 2023 07:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2n/MYezEYjuO1nj9ZfoKPomZfREMkLf5ekX0WIwT4h8=;
 b=JC641ezSWjDqpke2Cv+Jjmae6/oN2AKdu9j9UrhWETgJQ50AA1S7CZWx2ssAA/7Q6Zc5
 ID9ORnfd2iaArM6ZqNxIfaxYdIonRCrAmSXF+Fk9gMebw+zXGrJFGIslDHDcwQ4XpxlP
 ZY9mFle6maz54VXoorFN2G6lew00ek3YNdkkfFqkzkbxPFOjybchXnT93t0xYfIMsZsI
 zL45CTFo+46734n+qouqTE/zmGbQIQ/rxuUJ3u1vr5F1PpFx8X5ysA7EDIYZn6/EJ4rU
 DIYg8KdunvQHGhzV1xIfkIySkZnS5SnrqdWINBGZwkmSljiCi9guDaNIgXj4i0Htl15A Yg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2vq9js56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 07:35:32 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36R7ZUSt018739
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 07:35:30 GMT
Received: from [10.239.104.229] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 27 Jul
 2023 00:34:55 -0700
Message-ID: <11643479-3411-381e-4708-7259f6a15668@quicinc.com>
Date:   Thu, 27 Jul 2023 15:34:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v13 1/2] Bluetooth: hci_qca: adjust qca btsoc type print
 expression
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
CC:     <marcel@holtmann.org>, <luiz.dentz@gmail.com>,
        <johan.hedberg@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-bluetooth@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_bgodavar@quicinc.com>, <quic_hemantg@quicinc.com>
References: <20230727044011.965205-1-quic_tjiang@quicinc.com>
 <20230727044011.965205-2-quic_tjiang@quicinc.com>
 <ZMIcZqpN-CBgCFS8@hovoldconsulting.com>
From:   Tim Jiang <quic_tjiang@quicinc.com>
In-Reply-To: <ZMIcZqpN-CBgCFS8@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NPA0S_RtKGLAK7Xvp7mhLVeEydqQckmI
X-Proofpoint-GUID: NPA0S_RtKGLAK7Xvp7mhLVeEydqQckmI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999 spamscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307270066
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/27/23 15:27, Johan Hovold wrote:
> On Thu, Jul 27, 2023 at 12:40:10PM +0800, Tim Jiang wrote:
>> This patch make the print btsoc type expression more clearly.
>>
>> Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
>> ---
>>   drivers/bluetooth/hci_qca.c | 31 +++++++++++++++++++++++++++----
>>   1 file changed, 27 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 9b785c947d96..e11d47210e80 100644
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
>> @@ -1762,10 +1763,32 @@ static int qca_setup(struct hci_uart *hu)
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
>> +	case QCA_QCA6390:
>> +		soc_name = "QCA6390";
>> +		break;
>> +	case QCA_WCN3990:
>> +	case QCA_WCN3991:
>> +	case QCA_WCN3998:
>> +		soc_name = "wcn399x";
>> +		break;
>> +	case QCA_WCN6750:
>> +		soc_name = "wcn6750";
>> +		break;
>> +	case QCA_WCN6855:
>> +		soc_name = "wcn6855";
>> +		break;
> I still think the above should be sorted (alphabetically) as maintaining
> these lists otherwise soon becomes harder than it should be. And similar
> throughout the driver.
[Tim] Hi Johan: I think we no need to sort it, we only add the new btsoc 
name following the older one, for example , ar300x is the oldest , ROME 
is new than ar300x, actually qca2066 is newer version chip than qca6390, 
so I does not think we need to sort it.
>
>> +	default:
>> +		soc_name = "unknown soc";
>> +		break;
>> +	}
>> +	bt_dev_info(hdev, "setting up %s", soc_name);
> Johan

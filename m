Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177A4764A00
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjG0IFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbjG0IDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:03:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF47358E;
        Thu, 27 Jul 2023 01:01:28 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R49ANP014045;
        Thu, 27 Jul 2023 08:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EpGEqHEtVuiyctoCu/5k9/dNHQcMQ8mjxKuHodDwHM4=;
 b=fKYaxCQ/cnLMcP/Rp3WiXF86PaLv6Y2FWo3iN4cEZG+EHCX5KV9b/eNdy4VtSuxXtfH8
 uBXHTaakiYFqBUgTivBEsZCOCFJZytC14NN++vSJRQL3I233G/DgtXeFxIVBqtluzscj
 psM68vJ+WU28KB5EGTJdQfN0axpIEJrEOAwSqF57fs9WyyxIU0jhDl7ybcj/yH+0bplA
 Bz765rSlVM+hC9zQxbLx/UE2OPQRQA2U5o3g8vXssAKvagcbGk36t354pU47NPWhro4d
 la0siJ3scKelzNeusBMGWm0o7mEbIso7tGzolJCp+Hg3t1lSoGX64S4yTeas84qOxSaz 2g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3afys1xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 08:01:18 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36R81HDH004175
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 08:01:17 GMT
Received: from [10.239.104.229] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 27 Jul
 2023 01:00:46 -0700
Message-ID: <23d58498-60a5-9de5-0bf1-71bf636da110@quicinc.com>
Date:   Thu, 27 Jul 2023 16:00:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v13 2/2] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth SoC QCA2066
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
CC:     <marcel@holtmann.org>, <luiz.dentz@gmail.com>,
        <johan.hedberg@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-bluetooth@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_bgodavar@quicinc.com>, <quic_hemantg@quicinc.com>
References: <20230727044011.965205-1-quic_tjiang@quicinc.com>
 <20230727044011.965205-3-quic_tjiang@quicinc.com>
 <ZMIdE1ffQEmFMC8V@hovoldconsulting.com>
From:   Tim Jiang <quic_tjiang@quicinc.com>
In-Reply-To: <ZMIdE1ffQEmFMC8V@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cw5-0mNxoWPS5M9XlO-9Y4ZNVcWB6IDQ
X-Proofpoint-ORIG-GUID: cw5-0mNxoWPS5M9XlO-9Y4ZNVcWB6IDQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=946
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270070
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/27/23 15:30, Johan Hovold wrote:
> On Thu, Jul 27, 2023 at 12:40:11PM +0800, Tim Jiang wrote:
>> This patch adds support for QCA2066 firmware patch and NVM downloading.
>> as the RF performance of QCA2066 SOC chip from different foundries may
>> vary. Therefore we use different NVM to configure them based on board ID.
>>
>> Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
>> ---
>   
>> @@ -1931,6 +1934,12 @@ static const struct qca_device_data qca_soc_data_wcn3998 __maybe_unused = {
>>   	.num_vregs = 4,
>>   };
>>   
>> +static const struct qca_device_data qca_soc_data_qca2066 __maybe_unused = {
>> +	.soc_type = QCA_QCA2066,
>> +	.num_vregs = 0,
>> +};
>> +
>> +
> Stray newline.
[Tim] sorry for this typo, will address it in v14 , thank you.
>
>>   static const struct qca_device_data qca_soc_data_qca6390 __maybe_unused = {
>>   	.soc_type = QCA_QCA6390,
>>   	.num_vregs = 0,
> Johan

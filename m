Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBA179D00C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbjILLe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbjILLd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:33:58 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A611703;
        Tue, 12 Sep 2023 04:33:27 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C9hK3G017949;
        Tue, 12 Sep 2023 11:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zMaARZlcYQLkkzusDpZ0KZOEJPy402eycqTbduCNAZY=;
 b=PUppaESB7NMwcrhIrZ1hhrQmGVmPlWlpP/EYzB3fiiIZ94EhLCPX2+yadfrgrOkV0jQk
 DFTH2/iCuoa7P2/vQh7l/0x1kljRq1RtHPPK4pPtSyjOgP2jnw+W42NP+y6QZXIKC8Nt
 UryX030/lD+EFtIKp99q/vj+Dcpo93QgVdV9JOHEqkGz54s4kaXoQjv8+Nsu8JnNy0yt
 bdFQchBBwrYDWriHj7ruXJi1x8mWcVFQ54NRjsMtqjjlrBSSsmbkZRawt57N2OyiOet6
 KDj8gcr9A5tR0Fyog68NR2hqn4mgnD0XnulMvszNAotgLSQ9W4UUlkQ6Eqbtw5j4Rr6g CA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t29b0hq5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 11:33:15 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38CBXECq026886
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 11:33:14 GMT
Received: from [10.214.227.50] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 12 Sep
 2023 04:33:08 -0700
Message-ID: <9a623b21-0c57-4674-b419-f5c4b3a12385@quicinc.com>
Date:   Tue, 12 Sep 2023 17:03:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mtd: rawnand: qcom: unmap dma address during probe
 failure
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <mani@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_charante@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_pkondeti@quicinc.com>
References: <20230912101814.7748-1-quic_bibekkum@quicinc.com>
 <20230912122640.1ed25673@xps-13>
From:   Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <20230912122640.1ed25673@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Z3dipDbPql6FllqJwQVtbiJdbDQkIrqZ
X-Proofpoint-ORIG-GUID: Z3dipDbPql6FllqJwQVtbiJdbDQkIrqZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_09,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309120094
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 9/12/2023 3:56 PM, Miquel Raynal wrote:
> Hi Bibek,
> 
> quic_bibekkum@quicinc.com wrote on Tue, 12 Sep 2023 15:48:14 +0530:
> 
> Title: s/during/upon/?
> 
>> Fix address argument of nand controller currently being
>> passed to dma_unmap_resource() in probe error path.
> 
> What about:
> 

Sure, this looks more compact and simpler.
will use this for the title.
	v

> 	Unmap the right resource upon probe failure: we currently
> 	provide the physical address of the DMA region rather than the
> 	output of dma_map_resource() which is obviously wrong.
> 
	^
Will keep the rest in commit description. Thanks for this suggestion

>> This address argument should be the dma address returned by
>> dma_map_resource() instead of the physical address of nand controller.
>>
>>
>> Fixes: 7330fc505af4 ("mtd: rawnand: qcom: stop using phys_to_dma()")
>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>> ---
>> v3: Incorporated comments from Miquel
>>      - Modified the commit message and title as per suggestions.
>>
>> v2: Incorporated comments from Pavan/Mani.
>>      https://lore.kernel.org/all/20230911133026.29868-1-quic_bibekkum@quicinc.com/
>>
>> v1: https://lore.kernel.org/all/20230907092854.11408-1-quic_bibekkum@quicinc.com/
>>
>>   drivers/mtd/nand/raw/qcom_nandc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
>> index 64499c1b3603..b079605c84d3 100644
>> --- a/drivers/mtd/nand/raw/qcom_nandc.c
>> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
>> @@ -3444,7 +3444,7 @@ static int qcom_nandc_probe(struct platform_device *pdev)
>>   err_aon_clk:
>>   	clk_disable_unprepare(nandc->core_clk);
>>   err_core_clk:
>> -	dma_unmap_resource(dev, res->start, resource_size(res),
>> +	dma_unmap_resource(dev, nandc->base_dma, resource_size(res),
>>   			   DMA_BIDIRECTIONAL, 0);
>>   	return ret;
>>   }
>> --
>> 2.17.1
>>
> 
> 
> Thanks,
> Miquèl

Thanks & regards,
Bibek

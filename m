Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B2F7D0278
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346498AbjJST0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346477AbjJST0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:26:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E016126;
        Thu, 19 Oct 2023 12:25:57 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39JHS4wG021989;
        Thu, 19 Oct 2023 19:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7nZlr836Z1yRwKSJGkQXZps55FXeuMStkqXPcw7VZbM=;
 b=md0+6fSVejV8AMgpKlPvnBLl4J3FgpVtckN9oWAateqmPfpdkPBiI86G6LuaSblLw6UL
 r8DyTGz9RV+c/V2HTw5AesWtqrxjTxwXfgB8mxMm0UFqbmrO3fMq07cmq4yj7FdYmfyH
 8nrCTTZ6DL4nMFLP0NMMqU7pEI+ZZeXUzmql10dl+Nyz4OVUqdo4wNitnAFjlrtWIb8f
 DHe3yjPLyUFi2UBC1FoDOQgopgqP4HP/AXmrN0ls7nkxL0c3vRNo+JYD30clGBtGHLoX
 LOBd1TafidfkchfJfwD8eAUYCeuCD75TfJ/GkGhyP4gTfve0uhE2RsLSzyrE9EJcWk9l ew== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tu14csexk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 19:25:37 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39JJPZKQ008993
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 19:25:35 GMT
Received: from [10.110.99.208] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 19 Oct
 2023 12:25:35 -0700
Message-ID: <2e300bef-3722-8b00-2bdf-e9386796f38f@quicinc.com>
Date:   Thu, 19 Oct 2023 12:25:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v9 30/34] ASoC: qcom: qdsp6: Add SND kcontrol for fetching
 offload status
Content-Language: en-US
From:   Wesley Cheng <quic_wcheng@quicinc.com>
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
 <20231017200109.11407-31-quic_wcheng@quicinc.com>
 <92971bbf-b890-4e41-8ef1-9213e15d81b2@linux.intel.com>
 <c9c5f13f-b3e7-6591-f277-cd86162152e4@quicinc.com>
In-Reply-To: <c9c5f13f-b3e7-6591-f277-cd86162152e4@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: szZLkW7qgmVniayGieMMDVKlAabQiICH
X-Proofpoint-ORIG-GUID: szZLkW7qgmVniayGieMMDVKlAabQiICH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_18,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=459 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0
 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190164
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 10/18/2023 6:41 PM, Wesley Cheng wrote:
> Hi Pierre,
> 
> On 10/17/2023 3:53 PM, Pierre-Louis Bossart wrote:
>>
>>
>> On 10/17/23 15:01, Wesley Cheng wrote:
>>> Add a kcontrol to the platform sound card to fetch the current offload
>>> status.  This can allow for userspace to ensure/check which USB SND
>>> resources are actually busy versus having to attempt opening the USB SND
>>> devices, which will result in an error if offloading is active.
>>
>> I think I mentioned this a while back, but why not add the status in the
>> USB card itself? That's a generic component that all userspace agent
>> could query. Having a QCOM-specific control doesn't make the life of
>> userspace easier IMHO.
>>
>>
> 
> Will take a look at this based on the comments you had in the other 
> kcontrol patch.  Seeing if we can move it to a more generic layer.
> 

I think it would make more sense to see if we can keep all the offload 
kcontrols under the sound card exposed by the platform.  Especially, if 
we are going to modify the components string of the card to signify that 
it supports USB offload.

Thanks
Wesley Cheng

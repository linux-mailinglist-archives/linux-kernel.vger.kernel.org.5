Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8594679CF13
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbjILLAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbjILK7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:59:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA17A1999;
        Tue, 12 Sep 2023 03:59:18 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CAanN5016859;
        Tue, 12 Sep 2023 10:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=d0G9D1vZOsIBjPr1jWZ0C0X24Lo5P1Mi+kONZxrjof4=;
 b=GrBXKnMhkfKIQbfZFTerncZV0rSSyukpQYqMr1amHrvG/56cEASnRGEZtN+iQz4zRi+j
 WaZ0D4Z9SAGnfY/d1JuWmePJPxXJT8qW47yWinV/4o4j1+23+LgrDxi296lzkQz/bvMo
 U3JPZfTQ6Lm2GHcoFXRpa7FX1kLnbYCoP6Aj8x9KhJ8Hvfb9K+JkptWUnazAkg6yBOx+
 Gu2FICGzotfGMroWYFIsJb/St+vBWnKw6GfrHxM7LDie18qynA2RahR1kUVcSs71mGjT
 GQ4HAY2WX8Bt+3OtHWN2b/zSTnrmVWiSyyPaXqBhy6DhSIrlI3vrqAogE/5RV+eAc7LY 7g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t22hyjqrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 10:59:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38CAxCBu015803
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 10:59:12 GMT
Received: from [10.214.66.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 12 Sep
 2023 03:59:06 -0700
Message-ID: <66ea5d71-5d3e-430e-a38a-b866af255120@quicinc.com>
Date:   Tue, 12 Sep 2023 16:28:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] interconnect: qcom: Add SDX75 interconnect
 provider driver
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <djakov@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>
References: <1694513046-24064-1-git-send-email-quic_rohiagar@quicinc.com>
 <1694513046-24064-3-git-send-email-quic_rohiagar@quicinc.com>
 <b49fe557-a601-4219-a365-afb50dddd64e@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <b49fe557-a601-4219-a365-afb50dddd64e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2XuKufF7G9bCBQkBXOxDIE6lKoxRbbAn
X-Proofpoint-GUID: 2XuKufF7G9bCBQkBXOxDIE6lKoxRbbAn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_08,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxlogscore=924 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309120092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/12/2023 3:36 PM, Konrad Dybcio wrote:
> On 12.09.2023 12:04, Rohit Agarwal wrote:
>> Add driver for the Qualcomm interconnect buses found in SDX75.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
> [...]
>
>> +
>> +static struct qcom_icc_bcm * const dc_noc_bcms[] = {
>> +};
> Surely this shouldn't be necessary?
Ok. Will drop this.

Thanks,
Rohit.
>
> Konrad

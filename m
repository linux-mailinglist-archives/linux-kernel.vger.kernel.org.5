Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BE2772D15
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjHGRez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjHGRex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:34:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85055F9;
        Mon,  7 Aug 2023 10:34:52 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 377H1UNR006191;
        Mon, 7 Aug 2023 17:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ayIUv30cKBFqtzxnKsc+A+U+A6120Vy/VZjRRC7ftUY=;
 b=bn0OS0UcdPTlaOCDZPIwcQgtdRYqzg0d/htpaaT/7W4Pn/+RWG6UGXIeyi6aup/EKb5z
 hEkhoEOoTURjsMPeIKSN6FRKOS8/MGb/K9doRsTUecMhq9LcyiZNs8P8GiqRZPjG210Y
 dPgpAd5SenYbTdF/g8lgYnb56Wz2ThFjzt/BWb+9bETqkgaJuS7doZ9gIZMspGDKVW07
 mHMFk2BKCmDC0ZdEwaqRI7UAO9K/9TErKigAVFCbhT8ghQC++0Mp4e0SKEdfRVCF0DM2
 PMXMOofX6fNf3NPQbM1bxDhbxo4QMqk3lEEAYFqpIr9BxFOZNvjLXJCgcYFZ6NykElR4 +Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sax18s165-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 17:34:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 377HY3tK009634
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Aug 2023 17:34:03 GMT
Received: from [10.50.29.168] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 7 Aug
 2023 10:33:58 -0700
Message-ID: <75c25eac-e92c-5ca2-4ef6-06ee89584ce6@quicinc.com>
Date:   Mon, 7 Aug 2023 23:03:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V25 0/3] misc: Add driver support for Data Capture and
 Compare unit(DCC)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Trilok Soni <quic_tsoni@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>,
        Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        "Rajendra Nayak" <quic_rjendra@quicinc.com>
References: <cover.1687945879.git.quic_schowdhu@quicinc.com>
 <f25f8c43-2996-23ff-e6af-9e39b7fced86@quicinc.com>
 <774b688f-0324-9097-6504-58d15a3e6afb@quicinc.com>
 <2023080438-reacquire-obsessed-3e81@gregkh>
 <2023080408-zoom-defraud-1ae8@gregkh>
Content-Language: en-US
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <2023080408-zoom-defraud-1ae8@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: t7LGmfv5Gg0ZH668W6KF0jTmIyG0--Vw
X-Proofpoint-ORIG-GUID: t7LGmfv5Gg0ZH668W6KF0jTmIyG0--Vw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_19,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070161
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/4/2023 7:19 PM, Greg Kroah-Hartman wrote:
> On Fri, Aug 04, 2023 at 03:47:26PM +0200, Greg Kroah-Hartman wrote:
>> On Thu, Aug 03, 2023 at 07:35:18AM -0700, Trilok Soni wrote:
>>> On 8/3/2023 12:06 AM, Souradeep Chowdhury wrote:
>>>>
>>>>
>>>> On 6/28/2023 3:53 PM, Souradeep Chowdhury wrote:
>>>
>>> ...
>>>
>>>>>
>>>>> https://git.codelinaro.org/clo/le/platform/vendor/qcom-opensource/tools/-/tree/opensource-tools.lnx.1.0.r176-rel/dcc_parser
>>>>>
>>>>> Changes in v25
>>>>>
>>>>> * Updated the documentation of the structure dcc_config_entry as per
>>>>> the comments in V23
>>>>> * Updated the documentation of the dcc Kconfig definition as per
>>>>> comment in V24
>>>>> * Used u64 where applicable
>>>>> * Removed the mutex locks where it is not needed
>>>>> * Removed the use of unlikely keyword
>>>>> * Renamed "nr_link_list" to "max_link_list"
>>>>>
>>>>> Souradeep Chowdhury (3):
>>>>>     dt-bindings: misc: qcom,dcc: Add the dtschema
>>>>>     misc: dcc: Add driver support for Data Capture and Compare unit(DCC)
>>>>>     MAINTAINERS: Add the entry for DCC(Data Capture and Compare) driver
>>>>>       support
>>>>>
>>>>>    Documentation/ABI/testing/debugfs-driver-dcc  |   10 +-
>>>>>    .../devicetree/bindings/misc/qcom,dcc.yaml    |   44 +
>>>>>    MAINTAINERS                                   |    8 +
>>>>>    drivers/misc/Kconfig                          |    8 +
>>>>>    drivers/misc/Makefile                         |    1 +
>>>>>    drivers/misc/qcom-dcc.c                       | 1312 +++++++++++++++++
>>>>>    6 files changed, 1378 insertions(+), 5 deletions(-)
>>>>>    create mode 100644 Documentation/devicetree/bindings/misc/qcom,dcc.yaml
>>>>>    create mode 100644 drivers/misc/qcom-dcc.c
>>>>
>>>> Gentle Ping
>>>
>>> Thank you for the reminder Souradeep. Greg and others, please see if we need
>>> any changes here or it can be picked up?
>>
>> It would help if the code would actually build:
>>
>> drivers/misc/qcom-dcc.c: In function ‘ready_read’:
>> drivers/misc/qcom-dcc.c:853:13: error: unused variable ‘ret’ [-Werror=unused-variable]
>>    853 |         int ret = 0;
>>        |             ^~~
>>
>> {sigh}
>>
>> How in the world was this ever tested?
> 
> Ok, next time I want to see some QCOM engineers to sign off on this that
> it was actually tested and they can back it up that this is ready to be
> merged.  When the code doesn't even build, that is a huge red flag that
> this whole thing is being rushed as it obviously was never tested in the
> form that was submitted for inclusion.
> 
> You all know better than this.

My apologies on missing out on this, it is a W=1 level compilation 
warning that got suppressed on a normal kernel build. I will be
posting V26 by correcting this. Otherwise, this driver has no
functional issues and is already ported in downstream kernels.

> 
> greg k-h

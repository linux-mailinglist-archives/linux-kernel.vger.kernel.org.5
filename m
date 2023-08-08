Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02393773743
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 05:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjHHDCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 23:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHHDCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 23:02:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FD310D3;
        Mon,  7 Aug 2023 20:02:30 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3782MfV7025489;
        Tue, 8 Aug 2023 03:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aFtzoNl4y4lvbvaP2g/HGPsHP90SAc8cYVHqU/YrCxc=;
 b=e8mI9z6pgWfKtKqVQyCuBmh5htUFjGqccV3z/2oAeEYJasuGLN3mj8iEU4nJQCJNKVeK
 JYxrywcQgg6YFy/LAUKpLG6DsZVchG06/orELf08NBtawT331aAsTXsx03YTKgMw2lPV
 G0zfIj0/q/VOThRh9ByY2mC2/Yt9D6YTowQ6wxH7O1MwFqHeM766DLBc0SENKdMOHdrY
 2gc1W7aOyLWYtwiecYo7kuIWXPheU/yd2qNxh94mK0LV1BQEzH+eq0uTghuwU1SJS6YF
 6/y5TNPQr6+YL1RkskFsRVqa80q3ET/CqoVBikAgvByPSVNTioh60vfnOKv5ec3s90r1 Vw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sb7bb8k97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 03:02:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 378325HC027201
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Aug 2023 03:02:05 GMT
Received: from [10.50.30.63] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 7 Aug
 2023 20:02:01 -0700
Message-ID: <58ff2350-9e07-36a3-e7a6-f882b292bc35@quicinc.com>
Date:   Tue, 8 Aug 2023 08:31:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V25 0/3] misc: Add driver support for Data Capture and
 Compare unit(DCC)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Andy Gross <agross@kernel.org>,
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
 <75c25eac-e92c-5ca2-4ef6-06ee89584ce6@quicinc.com>
 <2023080753-decode-outgoing-b6c6@gregkh>
Content-Language: en-US
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <2023080753-decode-outgoing-b6c6@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eq2g4EHpoqaQuw7jecakTqTERzJ-Cqdf
X-Proofpoint-ORIG-GUID: eq2g4EHpoqaQuw7jecakTqTERzJ-Cqdf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_28,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080025
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/7/2023 11:14 PM, Greg Kroah-Hartman wrote:
> On Mon, Aug 07, 2023 at 11:03:45PM +0530, Souradeep Chowdhury wrote:
>>
>>
>> On 8/4/2023 7:19 PM, Greg Kroah-Hartman wrote:
>>> On Fri, Aug 04, 2023 at 03:47:26PM +0200, Greg Kroah-Hartman wrote:
>>>> On Thu, Aug 03, 2023 at 07:35:18AM -0700, Trilok Soni wrote:
>>>>> On 8/3/2023 12:06 AM, Souradeep Chowdhury wrote:
>>>>>>
>>>>>>
>>>>>> On 6/28/2023 3:53 PM, Souradeep Chowdhury wrote:
>>>>>
>>>>> ...
>>>>>
>>>>>>>
>>>>>>> https://git.codelinaro.org/clo/le/platform/vendor/qcom-opensource/tools/-/tree/opensource-tools.lnx.1.0.r176-rel/dcc_parser
>>>>>>>
>>>>>>> Changes in v25
>>>>>>>
>>>>>>> * Updated the documentation of the structure dcc_config_entry as per
>>>>>>> the comments in V23
>>>>>>> * Updated the documentation of the dcc Kconfig definition as per
>>>>>>> comment in V24
>>>>>>> * Used u64 where applicable
>>>>>>> * Removed the mutex locks where it is not needed
>>>>>>> * Removed the use of unlikely keyword
>>>>>>> * Renamed "nr_link_list" to "max_link_list"
>>>>>>>
>>>>>>> Souradeep Chowdhury (3):
>>>>>>>      dt-bindings: misc: qcom,dcc: Add the dtschema
>>>>>>>      misc: dcc: Add driver support for Data Capture and Compare unit(DCC)
>>>>>>>      MAINTAINERS: Add the entry for DCC(Data Capture and Compare) driver
>>>>>>>        support
>>>>>>>
>>>>>>>     Documentation/ABI/testing/debugfs-driver-dcc  |   10 +-
>>>>>>>     .../devicetree/bindings/misc/qcom,dcc.yaml    |   44 +
>>>>>>>     MAINTAINERS                                   |    8 +
>>>>>>>     drivers/misc/Kconfig                          |    8 +
>>>>>>>     drivers/misc/Makefile                         |    1 +
>>>>>>>     drivers/misc/qcom-dcc.c                       | 1312 +++++++++++++++++
>>>>>>>     6 files changed, 1378 insertions(+), 5 deletions(-)
>>>>>>>     create mode 100644 Documentation/devicetree/bindings/misc/qcom,dcc.yaml
>>>>>>>     create mode 100644 drivers/misc/qcom-dcc.c
>>>>>>
>>>>>> Gentle Ping
>>>>>
>>>>> Thank you for the reminder Souradeep. Greg and others, please see if we need
>>>>> any changes here or it can be picked up?
>>>>
>>>> It would help if the code would actually build:
>>>>
>>>> drivers/misc/qcom-dcc.c: In function ‘ready_read’:
>>>> drivers/misc/qcom-dcc.c:853:13: error: unused variable ‘ret’ [-Werror=unused-variable]
>>>>     853 |         int ret = 0;
>>>>         |             ^~~
>>>>
>>>> {sigh}
>>>>
>>>> How in the world was this ever tested?
>>>
>>> Ok, next time I want to see some QCOM engineers to sign off on this that
>>> it was actually tested and they can back it up that this is ready to be
>>> merged.  When the code doesn't even build, that is a huge red flag that
>>> this whole thing is being rushed as it obviously was never tested in the
>>> form that was submitted for inclusion.
>>>
>>> You all know better than this.
>>
>> My apologies on missing out on this, it is a W=1 level compilation warning
>> that got suppressed on a normal kernel build.
> 
> No, not at all, it showed up on my "normal kernel build", I do not have
> "W=1" set at all.
> 
> If you did a simple "make allmodconfig" I am pretty sure it would have
> tripped this.
> 
> How exactly was this tested?

My toolchain interprets this as a W=1 level warning rather than an 
error. So I am able to build the kernel with it. Probably because I
am using an older version. Will correct this in the next version.

> 
> thanks,
> 
> greg k-h

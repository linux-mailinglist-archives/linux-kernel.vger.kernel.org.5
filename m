Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354D476ECC0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbjHCOhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjHCOhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:37:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A61524A;
        Thu,  3 Aug 2023 07:36:12 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373EJRix025489;
        Thu, 3 Aug 2023 14:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fNAvu0glUC7orvVuI8D5tnkb1EFqrPjO1TlyEH3Kf1A=;
 b=gHguUEmCb31GdB1NXtR7ulhaSn8EzJls3eylMjPoLpxM1lKQtGviovF31hf1oyu7udae
 LcL4IBsyqa9RLpxLAp/TuySu1cA/yLhIg/X/MiVQQG4HLzmoLNXkx56iPbjhh8VgqQrH
 /HEsgh5XAPiXFrxdmMO8TAlrdagfNqcWxDB3e74RrnwP3+1TsR2bWi9t4H16HiOo5XcQ
 tqWjdsBj93YDiwagWY1ewk4789+rGNU/mCDu/p3oG0O+SOyev69UNoQTL90ZM1X9aTa+
 scps1lhSosjFVTKYyZVwr+DOTc63lpuZ4M1694Z1OjeMB9aiXGhlBtNuXrt26ns36RS4 1w== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s8dv5013m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 14:35:20 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 373EZKbW000923
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 14:35:20 GMT
Received: from [10.110.54.109] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 3 Aug
 2023 07:35:19 -0700
Message-ID: <774b688f-0324-9097-6504-58d15a3e6afb@quicinc.com>
Date:   Thu, 3 Aug 2023 07:35:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V25 0/3] misc: Add driver support for Data Capture and
 Compare unit(DCC)
Content-Language: en-US
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1687945879.git.quic_schowdhu@quicinc.com>
 <f25f8c43-2996-23ff-e6af-9e39b7fced86@quicinc.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <f25f8c43-2996-23ff-e6af-9e39b7fced86@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3bDD16gGqm4EkJMhwU3EEZ52FkhJMWai
X-Proofpoint-ORIG-GUID: 3bDD16gGqm4EkJMhwU3EEZ52FkhJMWai
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_14,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308030131
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/2023 12:06 AM, Souradeep Chowdhury wrote:
> 
> 
> On 6/28/2023 3:53 PM, Souradeep Chowdhury wrote:

...

>>
>> https://git.codelinaro.org/clo/le/platform/vendor/qcom-opensource/tools/-/tree/opensource-tools.lnx.1.0.r176-rel/dcc_parser
>>
>> Changes in v25
>>
>> * Updated the documentation of the structure dcc_config_entry as per 
>> the comments in V23
>> * Updated the documentation of the dcc Kconfig definition as per 
>> comment in V24
>> * Used u64 where applicable
>> * Removed the mutex locks where it is not needed
>> * Removed the use of unlikely keyword
>> * Renamed "nr_link_list" to "max_link_list"
>>
>> Souradeep Chowdhury (3):
>>    dt-bindings: misc: qcom,dcc: Add the dtschema
>>    misc: dcc: Add driver support for Data Capture and Compare unit(DCC)
>>    MAINTAINERS: Add the entry for DCC(Data Capture and Compare) driver
>>      support
>>
>>   Documentation/ABI/testing/debugfs-driver-dcc  |   10 +-
>>   .../devicetree/bindings/misc/qcom,dcc.yaml    |   44 +
>>   MAINTAINERS                                   |    8 +
>>   drivers/misc/Kconfig                          |    8 +
>>   drivers/misc/Makefile                         |    1 +
>>   drivers/misc/qcom-dcc.c                       | 1312 +++++++++++++++++
>>   6 files changed, 1378 insertions(+), 5 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/misc/qcom,dcc.yaml
>>   create mode 100644 drivers/misc/qcom-dcc.c
> 
> Gentle Ping

Thank you for the reminder Souradeep. Greg and others, please see if we 
need any changes here or it can be picked up?

-- 
---Trilok Soni


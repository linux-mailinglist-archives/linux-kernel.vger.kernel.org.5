Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA62B7D51D0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbjJXNbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjJXNbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:31:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832D56EA0;
        Tue, 24 Oct 2023 06:31:05 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OCrOwg026883;
        Tue, 24 Oct 2023 13:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3ghYYP6Zkll1M7e2fyWbrRlDpTUtu0CKI3Q54WrKXIk=;
 b=DOGTk+WMeTzIasGQtIyOSbgxYNOHEF91E1d0CktNttmWksjzp5Xr357rbR+1MXT1ohs1
 fVdrWkUCsBTOFmpU67pqGJRTkwV186zUXcQOl2frRdZuAAOZwD1N7L5B0/TFjHkoIfKi
 F0LKiBHaUnGPVTPO2/+eoUQX3pZ0wsk2/iUtH73MdzKV4ehoJEMtUr5VUkX/bd4oCOR+
 /gXTAppZl6mKB2O7tu6Zbtzkzi8KK+qrvy5MO+a7dSCZAhRPVQcowS1AaK5wdu4ra3XJ
 v2R2LqsCaP/xGNV/IGeuopSggAVuMYgPeC/0zFwvKXD8mg1h/O7wG1vWuNSiH838NI+l Fw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tx7r80utw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 13:30:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39ODUt0B005792
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 13:30:55 GMT
Received: from [10.216.17.94] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 24 Oct
 2023 06:30:52 -0700
Message-ID: <f3a4c114-b430-47ce-a746-4a840994dc58@quicinc.com>
Date:   Tue, 24 Oct 2023 18:59:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3 v7] Misc SCM changes
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <p.zabel@pengutronix.de>, <linus.walleij@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1696440338-12561-1-git-send-email-quic_mojha@quicinc.com>
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <1696440338-12561-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cRb-B8lA7NFtoORQMLneK3lPI_Vf1rZf
X-Proofpoint-GUID: cRb-B8lA7NFtoORQMLneK3lPI_Vf1rZf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_14,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310240116
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/4/2023 10:55 PM, Mukesh Ojha wrote:
> I have given version to this series as v7 as it has already
> gone through v6 and later got added to minidump patch series
> However, these 3 patches can go independently and has no
> relation with minidump hence, separated it from minidump series.


Mukesh, Can you rebase this series on top of linux-next, since there is 
a conflict?


Bjorn, after rebase is done, will you able to pick it up for v6.7 if 
there is a time? These patches(#1  and #3) are required for the crash 
dump collection on IPQ9574 and IPQ5332 SoCs.


>
> Change from minidump-v5(13/17-15/17):https://lore.kernel.org/lkml/1694429639-21484-1-git-send-email-quic_mojha@quicinc.com/
>   - Removed mistakenly added macros.
>     https://lore.kernel.org/lkml/9da888dc-401a-4cbb-b616-b4654fa79e35@quicinc.com/
>   - Added Acked-by tag from Linus.w to 2/3.
>
> Changes from dload series v6: https://lore.kernel.org/lkml/1680076012-10785-1-git-send-email-quic_mojha@quicinc.com/
>   - Rebased it on latest tag available on linux-next
>   - Added missed Poovendhan sign-off on 15/17 and tested-by tag from
>     Kathiravan. Thanks to him for testing and reminding me of missing sign-off.
>   - Addressed comments made on dload mode patch v6 version
>
> Changes in v6:
>    - Applied suggested API change(at v4) by [dmitry.baryshkov]
>
> Changes in v5: https://lore.kernel.org/lkml/1680017869-22421-1-git-send-email-quic_mojha@quicinc.com/
>    - Tried to fix the issue reported by kernel test robot
>      https://lore.kernel.org/lkml/202303280535.acb66sQT-lkp@intel.com/
>
>    - Applied some of the improvement suggested by [Bjorn.andersson]
>   
>      . Dropped 'both' instead support full,mini or mini,full for setting download
>      mode to collect both minidump and full dump.
>      
>      . logging improvement.
>      
>
> Changes in v4: https://lore.kernel.org/lkml/1679935281-18445-1-git-send-email-quic_mojha@quicinc.com/
>    - val should be shifted within the function [srinivas.kandagatla]
>      i.e new = (old & ~mask) | (val << ffs(mask) - 1);
>    - Added Acked-by [linus.walleij] on pinctrl change.
>
> Changes in v3 : https://lore.kernel.org/lkml/1679070482-8391-1-git-send-email-quic_mojha@quicinc.com/
>   - Removed [1] from the series and sent as a separate patch[2], although this series
>     should be applied on top [2].
>    [1] https://lore.kernel.org/lkml/1677664555-30191-2-git-send-email-quic_mojha@quicinc.com/
>    [2] https://lore.kernel.org/lkml/1678979666-551-1-git-send-email-quic_mojha@quicinc.com/
>   - Introduce new exported symbol on suggestion from [srinivas.kandagatla]
>   - Use the symbol from drivers/pinctrl/qcom/pinctrl-msm.c.
>   - Addressed comment given by [dmitry.baryshkov]
>   - Converted non-standard Originally-by to Signed-off-by.
>
> Changes in v2: https://lore.kernel.org/lkml/1677664555-30191-1-git-send-email-quic_mojha@quicinc.com/
>   - Addressed comment made by [bjorn]
>   - Added download mask.
>   - Passed download mode as parameter
>   - Accept human accepatable download mode string.
>   - enable = !!dload_mode
>   - Shifted module param callback to somewhere down in
>     the file so that it no longer need to know the
>     prototype of qcom_scm_set_download_mode()
>   - updated commit text.
>
> Mukesh Ojha (3):
>    firmware: qcom_scm: provide a read-modify-write function
>    pinctrl: qcom: Use qcom_scm_io_update_field()
>    firmware: scm: Modify only the download bits in TCSR register
>
>   drivers/firmware/qcom_scm.c            | 32 ++++++++++++++++++++++++++++++--
>   drivers/pinctrl/qcom/pinctrl-msm.c     | 10 ++++------
>   include/linux/firmware/qcom/qcom_scm.h |  2 ++
>   3 files changed, 36 insertions(+), 8 deletions(-)
>

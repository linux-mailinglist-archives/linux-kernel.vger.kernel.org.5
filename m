Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB4D7FAA9B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjK0Tuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjK0Tup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:50:45 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B556C10CA;
        Mon, 27 Nov 2023 11:50:51 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARFJN4k026954;
        Mon, 27 Nov 2023 19:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=xx3ph+X+6fmNeu0VE3E8kkIP8/jldxtnFkLaySCwVXw=;
 b=mpmEtfGCNLMr5qdU8KVHZQ/7GQQckgZXepcDRwuxBjOQsKWjlimiOI6jCc90UaDfl/RQ
 /3qsmH9Zk5bRCFPHZbhxFHhBIg4dxVYafa83lKIYCosWLvwqChD6esI9K+89Ln073bhO
 SMqe/WE7XBiH5b+QqY38I2QgdNUfsaOFrZitYyyMJpVKWHLkTP66hOf5kyx+OL8fj93g
 R+fF69StE3N6e/P3b/MHER/OWiZlAZ12nAXdgc4XsrLz2xek6dYz3FFh1bgFxz+hhQIJ
 CXm1PXOUCIejX17R4PTzx4rnrjqkhOXEmXuCyBrkV5CaGHuC01z/OCHSmbNwYTX52hho eA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3umwn5rs9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 19:50:38 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ARJocG8004114
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 19:50:38 GMT
Received: from [10.216.56.80] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 27 Nov
 2023 11:50:35 -0800
Message-ID: <653abe51-cc6a-7bb0-6a10-6dc33389cb68@quicinc.com>
Date:   Tue, 28 Nov 2023 01:20:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v10 0/4] Misc SCM driver changes
Content-Language: en-US
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linus.walleij@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1698945247-16033-1-git-send-email-quic_mojha@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <1698945247-16033-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GU0iX8YLJuuJ_I-Wcw9YXe_P4kv5Qi8z
X-Proofpoint-GUID: GU0iX8YLJuuJ_I-Wcw9YXe_P4kv5Qi8z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_18,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 spamscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311270137
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn,

Any comments on these patches?

-Mukesh

On 11/2/2023 10:44 PM, Mukesh Ojha wrote:
> First two changes changes are needed to enable download mode on
> chipset like IPQ9574 and IPQ5332 SoCs as for these targets others
> bits in download mode registers are used for different purpose
> and earlier kernel code was mistakenly overwrite the other bits.
> 
> First three changes(1/4-3/4) are SCM driver specific while 4/4 from
> pinctrl try to use the introduced API(1/3).
> 
> Changes from v9: https://lore.kernel.org/lkml/1698648967-974-1-git-send-email-quic_mojha@quicinc.com/
>   - Added 3/4 new patch.
>   - commit subject modification.
> 
> Change from v8: https://lore.kernel.org/lkml/1698235506-16993-1-git-send-email-quic_mojha@quicinc.com/
>   - Introduce enum for dload mode constants as per suggestion from [Elliot].
>   - Rebased on linux-next.
> 
> Changes from v7: https://lore.kernel.org/lkml/1696440338-12561-1-git-send-email-quic_mojha@quicinc.com/
>   - Rebased it on next-20231025.
>   - Added reviewed-by tag and take care of comment made about
>     commit text should be in imperative mode.
>   - Modified the name of the API to qcom_scm_io_rmw() as per suggestion
>     made by [Dmitry]
>   - Moved spinlock inside qcom_scm structure.
>   - Corrected the patch order as per subsystem SCM first then pinctrl.
> 
> Change from minidump-v5(13/17-15/17):https://lore.kernel.org/lkml/1694429639-21484-1-git-send-email-quic_mojha@quicinc.com/ - Removed mistakenly added macros.
>     https://lore.kernel.org/lkml/9da888dc-401a-4cbb-b616-b4654fa79e35@quicinc.com/
>   - Added Acked-by tag from Linus.w to 2/3.
> Change from minidump-v5(13/17-15/17):https://lore.kernel.org/lkml/1694429639-21484-1-git-send-email-quic_mojha@quicinc.com/
>   - Removed mistakenly added macros.
>     https://lore.kernel.org/lkml/9da888dc-401a-4cbb-b616-b4654fa79e35@quicinc.com/
>   - Added Acked-by tag from Linus.w to 2/3.
> 
> Changes in v6: https://lore.kernel.org/lkml/1680076012-10785-1-git-send-email-quic_mojha@quicinc.com/
>   - Rebased it on latest tag available on linux-next
>   - Added missed Poovendhan sign-off on 15/17 and tested-by tag from
>     Kathiravan. Thanks to him for testing and reminding me of missing sign-off.
>   - Addressed comments made on dload mode patch v6 version
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
> 
> Mukesh Ojha (4):
>    firmware: qcom: scm: provide a read-modify-write function
>    firmware: qcom: scm: Modify only the download bits in TCSR register
>    firmware: qcom: scm: Rework dload mode availability check
>    pinctrl: qcom: Use qcom_scm_io_rmw() function
> 
>   drivers/firmware/qcom/qcom_scm.c       | 50 ++++++++++++++++++++++++++++------
>   drivers/pinctrl/qcom/pinctrl-msm.c     | 10 +++----
>   include/linux/firmware/qcom/qcom_scm.h |  1 +
>   3 files changed, 47 insertions(+), 14 deletions(-)
> 

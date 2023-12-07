Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8D48082F6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjLGI0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLGI0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:26:50 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541F6D3;
        Thu,  7 Dec 2023 00:26:55 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B76inA2010319;
        Thu, 7 Dec 2023 08:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Xaj0x4k+ld+u2kOVUKdwjXgYdYvrFQwDvRLXmQnItnw=;
 b=msSUWIQWDHZ6naQJYFmyMCk/QPX8jnPE6KKa6j4xnPcDZY+YvHnae0YwLL2yYPnzALv5
 R+smGzzh3j7NraelEKYPk7kvsyGaqIUQMMHh+EMlzapyHweMs7a9lgE6D7LaDmxgjrmV
 B9jQpMkwQ40fn2LvPGe54WSeFq2gKyFZDWg+OrXr91vDxotFAdnfQTtIpYyscN+DVIb0
 H9An11g1iIMSPjkG8fF6cU1MzoIYsgUPlmOP6U2GysUew7wrdKsKzb1qBLBvRDNYoc50
 sr+lSO4bXO/yDL6UFGlGfM2XN21BZnDY4zzejCZDwrti7Z/jEI5qoUFayiMqu3UtSQ/i 2Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uu2trguxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 08:26:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B78QIEC027546
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Dec 2023 08:26:18 GMT
Received: from [10.253.37.252] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Dec
 2023 00:26:14 -0800
Message-ID: <cfd282bf-4e19-471f-9de2-18e286bce8bc@quicinc.com>
Date:   Thu, 7 Dec 2023 16:26:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/10] Enable HS-G5 support on SM8550
To:     <neil.armstrong@linaro.org>, <bvanassche@acm.org>,
        <mani@kernel.org>, <adrian.hunter@intel.com>, <vkoul@kernel.org>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "open list:ARM/Mediatek SoC support:Keyword:mediatek" 
        <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support:Keyword:mediatek" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support:Keyword:mediatek" 
        <linux-mediatek@lists.infradead.org>
References: <1701520577-31163-1-git-send-email-quic_cang@quicinc.com>
 <e851f59a-a8fe-42fa-a3e3-65fc5b8f3269@linaro.org>
Content-Language: en-US
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <e851f59a-a8fe-42fa-a3e3-65fc5b8f3269@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 20h9VHmRNRiOcuKPsvRWwmYo31i8tXaW
X-Proofpoint-ORIG-GUID: 20h9VHmRNRiOcuKPsvRWwmYo31i8tXaW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_06,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1011 mlxscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312070067
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On 12/7/2023 4:22 PM, neil.armstrong@linaro.org wrote:
> Hi Can,
> 
> On 02/12/2023 13:36, Can Guo wrote:
>> This series enables HS-G5 support on SM8550.
>>
>> This series is rebased on below changes from Mani -
>> https://patchwork.kernel.org/project/linux-scsi/patch/20230908145329.154024-1-manivannan.sadhasivam@linaro.org/
>> https://patchwork.kernel.org/project/linux-scsi/patch/20230908145329.154024-2-manivannan.sadhasivam@linaro.org/
>>
>> This series is tested on below HW combinations -
>> SM8550 MTP + UFS4.0
>> SM8550 QRD + UFS3.1
>> SM8450 MTP + UFS3.1 (for regression test)
>> SM8350 MTP + UFS3.1 (for regression test)
>>
>> Note that during reboot test on above platforms, I occasinally hit PA 
>> (PHY)
>> error during the 2nd init, this is not related with this series. A fix 
>> for
>> this is mentioned in below patchwork -
>>
>> https://patchwork.kernel.org/project/linux-scsi/patch/1698145815-17396-1-git-send-email-quic_ziqichen@quicinc.com/
>>
>> Also note that on platforms, which have two sets of UFS PHY settings are
>> provided (say G4 and no-G4, G5 and no-G5). The two sets of PHY 
>> settings are
>> basically programming different values to different registers, mixing the
>> two sets and/or overwriting one set with another set is definitely not
>> blessed by UFS PHY designers. For SM8550, this series will make sure we
>> honor the rule. However, for old targets Mani and I will fix them in
>> another series in future.
> 
> You dropped my tested-by tags, but I did a new test with v8 and:
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
> 

Thank you so much for testing this series.

I am sorry that I dropped the tested-by tags, since I slightly updated 
the last patch in this series, so I thought I should not apply the 
Tested-by tags from you.

Thanks,
Can Guo.

> Thanks,
> Neil
> 
>>
>> v7 -> v8:
>> In "scsi: ufs: ufs-qcom: Add support for UFS device version 
>> detection", fixed a BUG introduced from v6 -> v7. The spare register 
>> is added since HW ver 5, although reading the spare register on HW ver 
>> 4 is just getting 0x0, to be on the safe side, we are exluding HW ver 4.
>>
>> v6 -> v7:
>> 1. Rebased on linux-next, based SM8650 PHY settings are merged there, 
>> no changes to patches for UFS driver
>> 2. Addressed comments from Mani
>>
>> v5 -> v6:
>> 1. Rebased on scsi-queue-6.8
>> 2. Addressed comments from Dmitry and Mani in patches to 
>> phy-qcom-qmp-ufs.c
>>
>> v4 -> v5:
>> Removed two useless debug prints in patch #9
>>
>> v3 -> v4:
>> Used .tbls_hs_overlay array instead of adding more tables with 
>> different names like .tbls_hs_g5
>>
>> v2 -> v3:
>> 1. Addressed comments from Andrew, Mani and Bart in patch #1
>> 2. Added patch #2 as per request from Andrew and Mani
>> 3. Added patch #4 to fix a common issue on old targets, it is not 
>> necessary
>>     for this series, but put in this series only because it would be 
>> easier
>>     to maintain and no need to rebase
>> 4. Addressed comments from Dmitry and Mani in patches to 
>> phy-qcom-qmp-ufs.c
>>
>> v1 -> v2:
>> 1. Removed 2 changes which were exposing power info in sysfs
>> 2. Removed 1 change which was moving data structs to phy-qcom-qmp-ufs.h
>> 3. Added one new change (the 1st one) to clean up usage of 
>> ufs_dev_params based on comments from Mani
>> 4. Adjusted the logic of UFS device version detection according to 
>> comments from Mani:
>>     4.1 For HW version < 0x5, go through dual init
>>       4.2 For HW version >= 0x5
>>         a. If UFS device version is populated, one init is required
>>         b. If UFS device version is not populated, go through dual init
>>
>> Bao D. Nguyen (1):
>>    scsi: ufs: ufs-qcom: Add support for UFS device version detection
>>
>> Can Guo (9):
>>    scsi: ufs: host: Rename structure ufs_dev_params to ufs_host_params
>>    scsi: ufs: ufs-qcom: No need to set hs_rate after
>>      ufshcd_init_host_param()
>>    scsi: ufs: ufs-qcom: Setup host power mode during init
>>    scsi: ufs: ufs-qcom: Allow the first init start with the maximum
>>      supported gear
>>    scsi: ufs: ufs-qcom: Limit HS-G5 Rate-A to hosts with HW version 5
>>    scsi: ufs: ufs-qcom: Set initial PHY gear to max HS gear for HW ver 4
>>      and newer
>>    scsi: ufs: ufs-qcom: Check return value of phy_set_mode_ext()
>>    phy: qualcomm: phy-qcom-qmp-ufs: Rectify SM8550 UFS HS-G4 PHY Settings
>>    phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed Gear 5 support for
>>      SM8550
>>
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h     |   2 +
>>   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h |   2 +
>>   .../qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |   9 +
>>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 191 
>> ++++++++++++++++++---
>>   drivers/ufs/host/ufs-exynos.c                      |   7 +-
>>   drivers/ufs/host/ufs-hisi.c                        |  11 +-
>>   drivers/ufs/host/ufs-mediatek.c                    |  12 +-
>>   drivers/ufs/host/ufs-qcom.c                        |  97 ++++++++---
>>   drivers/ufs/host/ufs-qcom.h                        |   7 +-
>>   drivers/ufs/host/ufshcd-pltfrm.c                   |  69 ++++----
>>   drivers/ufs/host/ufshcd-pltfrm.h                   |  10 +-
>>   11 files changed, 309 insertions(+), 108 deletions(-)
>>
> 

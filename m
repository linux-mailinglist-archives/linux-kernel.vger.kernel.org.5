Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B623B7F6A52
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 02:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjKXB4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 20:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjKXB43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 20:56:29 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BD1D7F;
        Thu, 23 Nov 2023 17:56:34 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AO1nrVc010703;
        Fri, 24 Nov 2023 01:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=bKXuh++ZqwEZA9C3H/cwpqmOWdyZdH7ObxuMLPbyP0M=;
 b=NrltqsvzXEr0EScQOlkOJ4CU2vS6y1/CQ9MWWeNUCEdP26gR8o/19tE7WR6yTWuLhCKE
 E2UMeMQQbgiHCCBaJtJ9b6J/19mWeMSBssUDYVo2vuCr3McUS1qhPDjR5rTI4n5dq44l
 rA6MmEJYckuC/AfBrPifNM5mWMZgug5bG2tc2StXkIu/+YW+zMmcVyrNLOPweFPnqi8n
 H3g2k5uXcceaz6r7wDz9OIX67e0B81Jy87jV2Ru46LcjDvdnEGie5/t+Eivpvth5nk98
 rwtcxnSoC3Iaa9c8U0FDwVecNcZ0KzeJ4oLG/HyUfaLPBA7K1jlQWFMBjGt9JpWFWQJY Iw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uj7gjs46u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 01:55:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AO1taJK025184
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 01:55:37 GMT
Received: from [10.253.9.129] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 23 Nov
 2023 17:55:33 -0800
Message-ID: <c19dee05-a08d-4793-85a9-4527f85ad5ee@quicinc.com>
Date:   Fri, 24 Nov 2023 09:55:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed
 Gear 5 support for SM8550
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <bvanassche@acm.org>, <mani@kernel.org>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1700729190-17268-1-git-send-email-quic_cang@quicinc.com>
 <1700729190-17268-10-git-send-email-quic_cang@quicinc.com>
 <CAA8EJpouw-tu+Kz7ExQo+x1p5+fxqRzj=8fZY8GCM6fxB_USYw@mail.gmail.com>
Content-Language: en-US
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <CAA8EJpouw-tu+Kz7ExQo+x1p5+fxqRzj=8fZY8GCM6fxB_USYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XrcMH2O--mJqxqQhl5NDSDkrHDBM6-O8
X-Proofpoint-GUID: XrcMH2O--mJqxqQhl5NDSDkrHDBM6-O8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311240012
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/2023 8:35 PM, Dmitry Baryshkov wrote:
> On Thu, 23 Nov 2023 at 10:47, Can Guo <quic_cang@quicinc.com> wrote:
>>
>> On SM8550, two sets of UFS PHY settings are provided, one set is to support
>> HS-G5, another set is to support HS-G4 and lower gears. The two sets of PHY
>> settings are programming different values to different registers, mixing
>> the two sets and/or overwriting one set with another set is definitely not
>> blessed by UFS PHY designers.
>>
>> To add HS-G5 support for SM8550, split the two sets of PHY settings into
>> their dedicated overlay tables, only the common parts of the two sets of
>> PHY settings are left in the .tbls.
>>
>> Consider we are going to add even higher gear support in future, to avoid
>> adding more tables with different names, rename the .tbls_hs_g4 and make it
>> an array, a size of 2 is enough as of now.
>>
>> In this case, .tbls alone is not a complete set of PHY settings, so either
>> tbls_hs_overlay[0] or tbls_hs_overlay[1] must be applied on top of the
>> .tbls to become a complete set of PHY settings.
>>
>> Signed-off-by: Can Guo <quic_cang@quicinc.com>
>>
>> -static void qmp_ufs_init_registers(struct qmp_ufs *qmp, const struct qmp_phy_cfg *cfg)
>> +static bool qmp_ufs_match_gear_overlay(struct qmp_ufs *qmp, const struct qmp_phy_cfg *cfg, int *i)
> 
> You can simply return int from this function. -EINVAL would mean that
> the setting was not found. Also this can make max_supported_gear
> unused.

I will return int in next version, but I'd like to keep the 
max_support_gear, because for platforms which only .tbls is provided (no 
overlay case), we need the max_supported_gear to tell whether the 
requested submode is exceeding the capability provided by the PHY settings.

> 
>> +{
>> +       u32 max_gear, floor_max_gear = cfg->max_supported_gear;
>> +       bool found = false;
>> +       int j;
>> +
>> +       for (j = 0; j < NUM_OVERLAY; j ++) {
>> +               max_gear = cfg->tbls_hs_overlay[j].max_gear;
>> +
>> +               if (max_gear == 0)
>> +                       continue;
>> +
>> +               /* Direct matching, bail */
>> +               if (qmp->submode == max_gear) {
>> +                       *i = j;
>> +                       return true;
>> +               }
>> +
>> +               /* If no direct matching, the lowest gear is the best matching */
>> +               if (max_gear < floor_max_gear) {
>> +                       *i = j;
>> +                       found = true;
>> +                       floor_max_gear = max_gear;
>> +               }
> 
> We know that the table is sorted. So we can return an index of the
> first setting that fits.

For SM8550, it is OK, because no-G5 settings are in overlay[0] and G5 
settings are in overlay[1], applying one overlay is a must.
.tbls                        | support nothing as it is incomplete
.tbls + .tbls_hs_overlay[0]  | support G4 and lower gears
.tb.s + .tbls_hs_overlay[1]  | support G5

But for previously added platforms, no. I put it this way for two reasons -

1. In case the tables are not sorted.
2. For previously added targets, whose configs support G4 and no-G4:
.tbls                        | support G3 and lower gears
.tbls + .tbls_hs_overlay     | support G4
if we anways return an index of the first setting that fits, for these 
targets, the G4 settings would always be programmed, no matter UFS 
driver requests for G2/G3/G4. On these targets, as dual UFS init is 
there to find the most power saving PHY settings, when UFS driver 
requests for G2/G3, .tbls_hs_overlay should NOT be applied. Otherwise, 
it defeats all the efforts which Mani had spent for the dual UFS init.

Thanks,
Can Guo.
> 
>> +       }
>> +
>> +       return found;
>> +}
>> +
>> +static int qmp_ufs_init_registers(struct qmp_ufs *qmp, const struct qmp_phy_cfg *cfg)
>>   {
>> +       bool apply_overlay;
>> +       int i;
>> +
>> +       if (qmp->submode > cfg->max_supported_gear || qmp->submode == 0) {
>> +               dev_err(qmp->dev, "Invalid PHY submode %u\n", qmp->submode);
>> +               return -EINVAL;
>> +       }
>> +
>> +       apply_overlay = qmp_ufs_match_gear_overlay(qmp, cfg, &i);
>> +
>>          qmp_ufs_serdes_init(qmp, &cfg->tbls);
>> +       if (apply_overlay)
>> +               qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_overlay[i]);
>> +
>>          if (qmp->mode == PHY_MODE_UFS_HS_B)
>>                  qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_b);
>> +
>>          qmp_ufs_lanes_init(qmp, &cfg->tbls);
>> -       if (qmp->submode == UFS_HS_G4)
>> -               qmp_ufs_lanes_init(qmp, &cfg->tbls_hs_g4);
>> +       if (apply_overlay)
>> +               qmp_ufs_lanes_init(qmp, &cfg->tbls_hs_overlay[i]);
>> +
>>          qmp_ufs_pcs_init(qmp, &cfg->tbls);
>> -       if (qmp->submode == UFS_HS_G4)
>> -               qmp_ufs_pcs_init(qmp, &cfg->tbls_hs_g4);
>> +       if (apply_overlay)
>> +               qmp_ufs_pcs_init(qmp, &cfg->tbls_hs_overlay[i]);
>> +
>> +       return 0;
>>   }
>>
>>   static int qmp_ufs_com_init(struct qmp_ufs *qmp)
>> @@ -1331,7 +1461,9 @@ static int qmp_ufs_power_on(struct phy *phy)
>>          unsigned int val;
>>          int ret;
>>
>> -       qmp_ufs_init_registers(qmp, cfg);
>> +       ret = qmp_ufs_init_registers(qmp, cfg);
>> +       if (ret)
>> +               return ret;
>>
>>          ret = reset_control_deassert(qmp->ufs_reset);
>>          if (ret)
>> --
>> 2.7.4
>>
>>
> 
> 

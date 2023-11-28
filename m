Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0AE7FB51F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbjK1JBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjK1JBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:01:01 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78242198;
        Tue, 28 Nov 2023 01:01:04 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS5S1cU001271;
        Tue, 28 Nov 2023 09:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=QNUfJP5CeHay+odZ5ulMZu+ozmExmA/WZe/PCTme/DY=;
 b=l7aFcmLdZI1heAuASu2Q5JmMVorhQXJC5ZuMAvcOm+a+UWqB7gzTyqKn6dd14ZGn0Cl+
 cr0TfZhRov6FB0+Z52IF5SufTeySWVBhIfQ8imRnw+7olCXcwxCuu2DNLaAbCXVT6dVt
 J6rNd6TVXjF2SvflFp0ns9jIFbAy++VnNrs3F2vippWXqxGjqTnICYYbeZUQq2wrbqQc
 ZkN0t9oW+gzlMBE9pwtDQ3hlwlaN56U2EMbP5wU8B9iyhOsXRR2Ht2XdbvKa9yOSc10g
 9+bzX7aWleytlrXB1Y0d2RDJipHkLqor5SX6ZM+Pg7ASKJPOJDFCdyP2qnbLURldsOTQ DA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3un04bhpne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 09:00:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AS90EDZ029313
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 09:00:14 GMT
Received: from [10.253.11.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 28 Nov
 2023 01:00:11 -0800
Message-ID: <f989335d-5b63-4a2c-b778-5d315ed5874f@quicinc.com>
Date:   Tue, 28 Nov 2023 17:00:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed
 Gear 5 support for SM8550
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <bvanassche@acm.org>, <adrian.hunter@intel.com>,
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
 <20231128064721.GJ3088@thinkpad>
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <20231128064721.GJ3088@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9FxvVzWu_21JcRrCVEpDnKKh4Bybp0IQ
X-Proofpoint-GUID: 9FxvVzWu_21JcRrCVEpDnKKh4Bybp0IQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_07,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/2023 2:47 PM, Manivannan Sadhasivam wrote:
> On Thu, Nov 23, 2023 at 12:46:29AM -0800, Can Guo wrote:
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
> 
> Thanks for the update! This really helps in minimizing the changes for future
> gears.
> 
>> Signed-off-by: Can Guo <quic_cang@quicinc.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h     |   2 +
>>   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h |   2 +
>>   .../qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |   9 ++
>>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 174 ++++++++++++++++++---
>>   4 files changed, 166 insertions(+), 21 deletions(-)
>>
>>   
> 
> [...]
> 
>> -static void qmp_ufs_init_registers(struct qmp_ufs *qmp, const struct qmp_phy_cfg *cfg)
>> +static bool qmp_ufs_match_gear_overlay(struct qmp_ufs *qmp, const struct qmp_phy_cfg *cfg, int *i)
>> +{
>> +	u32 max_gear, floor_max_gear = cfg->max_supported_gear;
>> +	bool found = false;
>> +	int j;
>> +
>> +	for (j = 0; j < NUM_OVERLAY; j ++) {
>> +		max_gear = cfg->tbls_hs_overlay[j].max_gear;
>> +
>> +		if (max_gear == 0)
> 
> Is this condition possible for hs_overlay tables?

Yes, now there are 2 overlays for SM8550, but only one overlay for the 
rest targets. For those who has only one overlay, this check fits them.

> 
>> +			continue;
>> +
>> +		/* Direct matching, bail */
>> +		if (qmp->submode == max_gear) {
>> +			*i = j;
>> +			return true;
>> +		}
>> +
>> +		/* If no direct matching, the lowest gear is the best matching */
>> +		if (max_gear < floor_max_gear) {
> 
> Can you start the loop from max? If looks odd to set the matching params in the
> first iteration itself and then checking the next one.

OK, will start from j = NUM_VERLAY - 1; in next version. When I wrote 
the code, I was not expecting the max is always in the last overlay, 
they can come in any orders.

> 
>> +			*i = j;
>> +			found = true;
>> +			floor_max_gear = max_gear;
>> +		}
>> +	}
>> +
>> +	return found;
>> +}
>> +
>> +static int qmp_ufs_init_registers(struct qmp_ufs *qmp, const struct qmp_phy_cfg *cfg)
>>   {
>> +	bool apply_overlay;
>> +	int i;
>> +
>> +	if (qmp->submode > cfg->max_supported_gear || qmp->submode == 0) {
>> +		dev_err(qmp->dev, "Invalid PHY submode %u\n", qmp->submode);
>> +		return -EINVAL;
>> +	}
> 
> This check should be moved to qmp_ufs_set_mode().

OK.

Thanks,
Can Guo.

> 
> Rest LGTM.
> 
> - Mani
> 

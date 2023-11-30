Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C90E7FEBF2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbjK3JhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjK3Jg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:36:57 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926F210EA;
        Thu, 30 Nov 2023 01:37:03 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AU5T9PF000721;
        Thu, 30 Nov 2023 09:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7DXq0IJTQ+FmmDgMWi46tSD3Vccr1EVY3N/GzopIth0=;
 b=S4b+luvtVCgjjUxSt9DOZ2tP+6+OqUT10iFDn/V0k7D0bbbJ7N4CttdkCzJ2coa4lMgj
 SoeJmrMqn2T440qSixj2vgG3T/fwLBxeGGyWZWb+m6YsIVEg4E5PwfeXcIWmJMsYOBuC
 9zWeyv101kD7UETtu/6+ooT/CgtVD3lHPnErAh6iAZl6dJFKgaopRaEIo5ljwApUA24T
 8ekOPxQmixqJVrCZOySyg6BsNpH4broHBCUa0LZNs07o9grr+n+zEitk4cJeJLx2GEW6
 HWp6lkWDGCsEmWcxoQJw/hg+eP0y5XAJBjYFfwcYx7MFROTjQTHAPuMLRMDnKaENitDm ug== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3up2byudv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 09:36:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AU9ZuMW007555
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 09:35:56 GMT
Received: from [10.253.11.15] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 30 Nov
 2023 01:35:52 -0800
Message-ID: <7de9b68f-e9b4-4fe4-9670-5b4f4e2513df@quicinc.com>
Date:   Thu, 30 Nov 2023 17:35:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/10] phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed
 Gear 5 support for SM8550
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <bvanassche@acm.org>, <adrian.hunter@intel.com>,
        <cmd4@qualcomm.com>, <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1701246516-11626-1-git-send-email-quic_cang@quicinc.com>
 <1701246516-11626-9-git-send-email-quic_cang@quicinc.com>
 <20231130071240.GG3043@thinkpad>
 <367744ed-a7e4-485b-b855-2cb26ef1ee16@quicinc.com>
 <20231130083827.GM3043@thinkpad>
 <c112b051-05ba-45f0-a9f3-f0da5afad4f7@quicinc.com>
 <20231130093423.GO3043@thinkpad>
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <20231130093423.GO3043@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sGbQ8X4kNid2d1CPCNUCWtet_lnbErRR
X-Proofpoint-ORIG-GUID: sGbQ8X4kNid2d1CPCNUCWtet_lnbErRR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_07,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311300071
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/2023 5:34 PM, Manivannan Sadhasivam wrote:
> On Thu, Nov 30, 2023 at 04:49:12PM +0800, Can Guo wrote:
>>
>>
>> On 11/30/2023 4:38 PM, Manivannan Sadhasivam wrote:
>>> On Thu, Nov 30, 2023 at 04:14:25PM +0800, Can Guo wrote:
> 
> [...]
> 
>>>>>> +static int qmp_ufs_get_gear_overlay(struct qmp_ufs *qmp, const struct qmp_phy_cfg *cfg)
>>>>>> +{
>>>>>> +	u32 max_gear, floor_max_gear = cfg->max_supported_gear;
>>>>>> +	int i = NUM_OVERLAY - 1;
>>>>>
>>>>> Just use i directly in the for loop. Also, please rename "i" with "idx" to make
>>>>> it clear.
>>>>
>>>> OK
>>>>
>>>>>
>>>>>> +	int ret = -EINVAL;
>>>>>> +
>>>>>> +	for (; i >= 0; i --) {
>>>>>
>>>>> i--
>>>>>
>>>>>> +		max_gear = cfg->tbls_hs_overlay[i].max_gear;
>>>>>> +
>>>>>> +		if (max_gear == 0)
>>>>>> +			continue;
>>>>>
>>>>> You are setting max_gear even for targets with a single overlay. How can this
>>>>> become 0?
>>>>
>>>> Say 8550 has two overlays, 8450 has one overlay. We are sweeping all
>>>> overlays as NUM_OVERLAY == 2, so for 8450, there is one overlay initialized,
>>>> another one not initialized (max_gear == 0), we are skipping the one which
>>>> is not initialized.
>>>>
>>>
>>> This is confusing at its best :) Please check for the existence of the actual
>>> table instead. Like,
>>>
>>> 	for (idx = NUM_OVERLAY - 1; i >= 0, i--) {
>>>
>>> 		/* Skip if the table is not available */
>>> 		if (!cfg->tbls_hs_overlay[i].serdes)
>>> 			continue;
>>>
>>> 		...
>>> 	}
>>
>> We cannot expect overlay must has its own serdes, or tx/rx/pcs, hence I am
>> checking max_gear intead of any specific member.
>>
> 
> Hmm, then please add the comment as I suggested above.

Sure

Thanks,
Can Guo.

> 
>>>
>>>>>
>>>>>> +
>>>>>> +		/* Direct matching, bail */
>>>>>> +		if (qmp->submode == max_gear)
>>>>>> +			return i;
>>>>>> +
>>>>>> +		/* If no direct matching, the lowest gear is the best matching */
>>>>>> +		if (max_gear < floor_max_gear) {
>>>>>> +			ret = i;
>>>>>> +			floor_max_gear = max_gear;
>>>>>> +		}
>>>>>> +	}
>>>>>> +
>>>>>> +	return ret;
>>>>>> +}
>>>>>> +
>>>>>>     static void qmp_ufs_init_registers(struct qmp_ufs *qmp, const struct qmp_phy_cfg *cfg)
>>>>>>     {
>>>>>> +	int i;
>>>>>> +	bool apply_overlay = false;
>>>>>> +
>>>>>> +	i = qmp_ufs_get_gear_overlay(qmp, cfg);
>>>>>> +	if (i >= 0)
>>>>>> +		apply_overlay = true;
>>>>>
>>>>> How about?
>>>>>
>>>>> ```
>>>>> 	int idx;
>>>>>
>>>>> 	idx = qmp_ufs_get_gear_overlay(qmp, cfg);
>>>>>
>>>>> 	qmp_ufs_serdes_init(qmp, &cfg->tbls);
>>>>> 	qmp_ufs_lanes_init(qmp, &cfg->tbls);
>>>>> 	...
>>>>>
>>>>> 	if (idx >= 0) {
>>>>> 		qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_overlay[idx]);
>>>>> 		qmp_ufs_lanes_init(qmp, &cfg->tbls_hs_overlay[idx]);
>>>>> 		...
>>>>> 	}
>>>>> ```
>>>>>
>>>>> Since the ordering doesn't matter for init sequence, you can program the overlay
>>>>> tables under a single condition.
>>>>
>>>> We can do that, but we need to be careful. When I say (in my previous reply)
>>>> the ordering does not matter, that saying is from the UFS PHY HPG doc.
>>>> However, in SW implementation, the 'tbls_hs_b' is actually overwriting one
>>>> COM_VCO_TUNE_MAP register, the same register is also programmed by common
>>>> table or overlay table. So qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_b) should
>>>> come after overlays.
>>>>
>>>
>>> Then you can program tbls_hs_b after overlay tables. Wouldn't that work?
>>
>> I am programming tbls_hs_b after overlay tables, just a heads up in case you
>> are surprised :).
>>
> 
> Cool!
> 
> - Mani
> 

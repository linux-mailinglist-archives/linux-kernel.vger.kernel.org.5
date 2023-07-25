Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD24760CC1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjGYIPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjGYIPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:15:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9E8E7B;
        Tue, 25 Jul 2023 01:15:16 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P88xAK009682;
        Tue, 25 Jul 2023 08:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PCz3mEeQgque/FOOfchegotNtCY9cjznSwkh8xlUE6w=;
 b=VEUputmX7WLBs0Z5vbz8qjRSVucxS/15nHFR9d103lbpDrdozJy2+nvXx5j+DSTMqwUq
 8HPsYpbr6RJ3I5Fc37RvB4r+99HyvmkR/Jn4q0EziultKVKSByBfJlNKulCMTmzB9uKj
 4AFu5euWC/yz8THaETSA/Gyu/PzoW3AMX4eGQGz1ExNQsE6FxjwF7X62tUXobLPyo1/P
 1/KMWJyDlbRddwC5R8X9yy7jDQqcNFbIWV9YcMGe6qpBKYk2ntw4G5idhv3rO7233NrT
 TH30Glbx1o0KOlb96wM/6KTym/B/PVszgVfhhvpfZTkhUQcOBnkXkZo3FMWscO4ksNtU EA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1s1jt6b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 08:15:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36P8F2ct005670
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 08:15:02 GMT
Received: from [10.214.66.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 25 Jul
 2023 01:14:59 -0700
Message-ID: <a3a401fe-dbc6-03dd-ce6f-13abf30ef984@quicinc.com>
Date:   Tue, 25 Jul 2023 13:44:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/2] dt-bindings: power: qcom,rpmhpd: Add Generic RPMh PD
 indexes
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Pavan Kondeti <quic_pkondeti@quicinc.com>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <1689744162-9421-1-git-send-email-quic_rohiagar@quicinc.com>
 <1689744162-9421-2-git-send-email-quic_rohiagar@quicinc.com>
 <e77c39fe-b7cf-49b3-9260-ecf4872e8fdf@quicinc.com>
 <7517b2ca-7d7f-dc0c-7f60-a6281b37ab40@quicinc.com>
 <a4zztrn6jhblozdswba7psqtvjt5l765mfr3yl4llsm5gsyqef@7x6q7yabydvm>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <a4zztrn6jhblozdswba7psqtvjt5l765mfr3yl4llsm5gsyqef@7x6q7yabydvm>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c6-FyxMlGSQV51UxzQhwKxX-VDQo3ZmI
X-Proofpoint-ORIG-GUID: c6-FyxMlGSQV51UxzQhwKxX-VDQo3ZmI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_04,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=899 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250072
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/22/2023 8:35 AM, Bjorn Andersson wrote:
> On Fri, Jul 21, 2023 at 06:47:42PM +0530, Rohit Agarwal wrote:
>> On 7/21/2023 11:14 AM, Pavan Kondeti wrote:
>>> On Wed, Jul 19, 2023 at 10:52:41AM +0530, Rohit Agarwal wrote:
>>>> diff --git a/include/dt-bindings/power/qcom,rpmhpd.h b/include/dt-bindings/power/qcom,rpmhpd.h
> [..]
>>>> +
>>>> +#endif
>>>> -- 
>>> I see the PD performance levels (RPMH_REGULATOR_LEVEL_xxx) are still
>>> coming from qcom-rpmpd.h. Which means Socs with RPMh also need to
>>> include the older header for these definitions along with this newly
>>> created header. something to improve for the clarity sake?
>> Agreed. I think we can move these to the new header so that the new SoC with
>> RPMH can completely
>> move to rpmhpd.h.
> Sounds very reasonable, please do that in a follow up patch.
> I'm picking this as is.
I have a doubt related to this about sending the patches.

Since I will be moving the regulators level into the same rpmhpd.h 
header, we
would need to update all the qcom soc dtsi file changes as well. Also 
there is a
remaining dt-bindings patch that update the older rpmhpd bindings to 
these new
ones basically the cleanup is remaining.
Shall I create a unified series updating all these in one and tagging 
all the the
related maintainers in the CC
OR
should I create separate series where the dt changes are updated first 
then the
followup cleanup dt-bindings series?

Thanks,
Rohit.
> Thanks,
> Bjorn

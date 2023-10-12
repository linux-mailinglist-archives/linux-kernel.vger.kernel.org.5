Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F8A7C73A4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379597AbjJLRDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379560AbjJLRDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:03:50 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA30E0;
        Thu, 12 Oct 2023 10:03:47 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CCrf1c021857;
        Thu, 12 Oct 2023 17:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NH4khoV/UCQiLLBbnfOuncfM7J/RzeWNi52YYS+gsgo=;
 b=N1SzZNU+2aQyQ2TV1xhzHf2k0ar5ChTMzfnKO3s58yE1L9SpAQn0aeyC3AIzRBYQnRMH
 pfQeELhTecTXtmInO5D5aZm9TfjIKZHQW5N92nLvf/TauZJGaNR1n567kla3MNxxNcnp
 02Ol7EJ9v5BW1jUPkBA3ObcXHZ3i63nI1Wb0jBx6aVOLcDs/QD7TiD5EMM3TkXq4eMau
 SUTFp20w/rg7/3/A6w+I4x4FYaXVTFlHfoSRFclIhloNr2fWs6/KhnQzKYy3iy655Nix
 j4PlShpSIkT2uHRj1ZPavTgbOuSxgb2GhTRAIn5OVGtXN/N+hhTHaEkjTBLbFk/6UieW YQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tnv1rbft8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 17:03:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39CH3alO003878
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 17:03:36 GMT
Received: from [10.216.13.237] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 12 Oct
 2023 10:03:33 -0700
Message-ID: <502135a8-6e82-4361-b0fc-e683694ca2cd@quicinc.com>
Date:   Thu, 12 Oct 2023 22:33:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the usb tree
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>, <vkoul@kernel.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231004132247.01c3bfeb@canb.auug.org.au>
 <2023100410-concave-explore-95bf@gregkh>
 <e26b26ff-9e88-4455-9172-1afb520583e7@quicinc.com>
 <2023100445-cymbal-glade-52c8@gregkh>
 <044a2146-f859-44b3-bcf7-66b68d3e7787@quicinc.com>
 <2023100912-tiara-pout-ba98@gregkh>
 <CAA8EJpo-cvf3vkvBe+5nF1FpDMXzWJZkaL6n0BAjPvg7xHQ_+w@mail.gmail.com>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <CAA8EJpo-cvf3vkvBe+5nF1FpDMXzWJZkaL6n0BAjPvg7xHQ_+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4EkdUgrCgLqqYTwxxwKRUQJk4tnqrQcS
X-Proofpoint-GUID: 4EkdUgrCgLqqYTwxxwKRUQJk4tnqrQcS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 clxscore=1011 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 mlxlogscore=843 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310120141
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/9/2023 3:19 PM, Dmitry Baryshkov wrote:
> On Mon, 9 Oct 2023 at 12:48, Greg KH <gregkh@linuxfoundation.org> wrote:
>> On Mon, Oct 09, 2023 at 02:48:27PM +0530, Rohit Agarwal wrote:
>>> On 10/4/2023 6:16 PM, Greg KH wrote:
>>>> On Wed, Oct 04, 2023 at 12:17:27PM +0530, Rohit Agarwal wrote:
>>>>> On 10/4/2023 12:13 PM, Greg KH wrote:
>>>>>> On Wed, Oct 04, 2023 at 01:22:47PM +1100, Stephen Rothwell wrote:
>>>>>>> Hi all,
>>>>>>>
>>>>>>> After merging the usb tree, today's linux-next build (x86_64 allmodconfig)
>>>>>>> failed like this:
>>>>>>>
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:156:43: error: 'QPHY_V6_PCS_SW_RESET' undeclared here (not in a function); did you mean 'QPHY_V2_PCS_SW_RESET'?
>>>>>>>      156 |         [QPHY_SW_RESET]                 = QPHY_V6_PCS_SW_RESET,
>>>>>>>          |                                           ^~~~~~~~~~~~~~~~~~~~
>>>>>>>          |                                           QPHY_V2_PCS_SW_RESET
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:157:43: error: 'QPHY_V6_PCS_START_CONTROL' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_START_CONTROL'?
>>>>>>>      157 |         [QPHY_START_CTRL]               = QPHY_V6_PCS_START_CONTROL,
>>>>>>>          |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>>          |                                           QPHY_V3_PCS_START_CONTROL
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:158:43: error: 'QPHY_V6_PCS_PCS_STATUS1' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_PCS_STATUS1'?
>>>>>>>      158 |         [QPHY_PCS_STATUS]               = QPHY_V6_PCS_PCS_STATUS1,
>>>>>>>          |                                           ^~~~~~~~~~~~~~~~~~~~~~~
>>>>>>>          |                                           QPHY_V5_PCS_PCS_STATUS1
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:159:43: error: 'QPHY_V6_PCS_POWER_DOWN_CONTROL' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_POWER_DOWN_CONTROL'?
>>>>>>>      159 |         [QPHY_PCS_POWER_DOWN_CONTROL]   = QPHY_V6_PCS_POWER_DOWN_CONTROL,
>>>>>>>          |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>>          |                                           QPHY_V3_PCS_POWER_DOWN_CONTROL
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:162:43: error: 'QPHY_V6_PCS_USB3_AUTONOMOUS_MODE_CTRL' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_USB3_AUTONOMOUS_MODE_CTRL'?
>>>>>>>      162 |         [QPHY_PCS_AUTONOMOUS_MODE_CTRL] = QPHY_V6_PCS_USB3_AUTONOMOUS_MODE_CTRL,
>>>>>>>          |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>>          |                                           QPHY_V5_PCS_USB3_AUTONOMOUS_MODE_CTRL
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:163:44: error: 'QPHY_V6_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR'?
>>>>>>>      163 |         [QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V6_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
>>>>>>>          |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>>          |                                            QPHY_V5_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:991:26: error: 'QPHY_V6_PCS_LOCK_DETECT_CONFIG1' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_LOCK_DETECT_CONFIG1'?
>>>>>>>      991 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG1, 0xc4),
>>>>>>>          |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>>>>       78 |                 .offset = o,            \
>>>>>>>          |                           ^
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:992:26: error: 'QPHY_V6_PCS_LOCK_DETECT_CONFIG2' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_LOCK_DETECT_CONFIG2'?
>>>>>>>      992 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG2, 0x89),
>>>>>>>          |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>>>>       78 |                 .offset = o,            \
>>>>>>>          |                           ^
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:993:26: error: 'QPHY_V6_PCS_LOCK_DETECT_CONFIG3' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_LOCK_DETECT_CONFIG3'?
>>>>>>>      993 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG3, 0x20),
>>>>>>>          |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>>>>       78 |                 .offset = o,            \
>>>>>>>          |                           ^
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:994:26: error: 'QPHY_V6_PCS_LOCK_DETECT_CONFIG6' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_LOCK_DETECT_CONFIG6'?
>>>>>>>      994 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG6, 0x13),
>>>>>>>          |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>>>>       78 |                 .offset = o,            \
>>>>>>>          |                           ^
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:997:26: error: 'QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_L' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_L'?
>>>>>>>      997 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
>>>>>>>          |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>>>>       78 |                 .offset = o,            \
>>>>>>>          |                           ^
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:998:26: error: 'QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_H' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_H'?
>>>>>>>      998 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
>>>>>>>          |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>>>>       78 |                 .offset = o,            \
>>>>>>>          |                           ^
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:999:26: error: 'QPHY_V6_PCS_CDR_RESET_TIME' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_CDR_RESET_TIME'?
>>>>>>>      999 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_CDR_RESET_TIME, 0x0a),
>>>>>>>          |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>>>>       78 |                 .offset = o,            \
>>>>>>>          |                           ^
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1000:26: error: 'QPHY_V6_PCS_ALIGN_DETECT_CONFIG1' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_ALIGN_DETECT_CONFIG1'?
>>>>>>>     1000 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_ALIGN_DETECT_CONFIG1, 0x88),
>>>>>>>          |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>>>>       78 |                 .offset = o,            \
>>>>>>>          |                           ^
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1001:26: error: 'QPHY_V6_PCS_ALIGN_DETECT_CONFIG2' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_ALIGN_DETECT_CONFIG2'?
>>>>>>>     1001 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_ALIGN_DETECT_CONFIG2, 0x13),
>>>>>>>          |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>>>>       78 |                 .offset = o,            \
>>>>>>>          |                           ^
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1003:26: error: 'QPHY_V6_PCS_EQ_CONFIG1' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_EQ_CONFIG1'?
>>>>>>>     1003 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_EQ_CONFIG1, 0x4b),
>>>>>>>          |                          ^~~~~~~~~~~~~~~~~~~~~~
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>>>>       78 |                 .offset = o,            \
>>>>>>>          |                           ^
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1004:26: error: 'QPHY_V6_PCS_EQ_CONFIG5' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_EQ_CONFIG5'?
>>>>>>>     1004 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_EQ_CONFIG5, 0x10),
>>>>>>>          |                          ^~~~~~~~~~~~~~~~~~~~~~
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>>>>       78 |                 .offset = o,            \
>>>>>>>          |                           ^
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1008:26: error: 'QPHY_V6_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL'?
>>>>>>>     1008 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
>>>>>>>          |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>>>>       78 |                 .offset = o,            \
>>>>>>>          |                           ^
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1009:26: error: 'QPHY_V6_PCS_USB3_RXEQTRAINING_DFE_TIME_S2' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_USB3_RXEQTRAINING_DFE_TIME_S2'?
>>>>>>>     1009 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
>>>>>>>          |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>>>>       78 |                 .offset = o,            \
>>>>>>>          |                           ^
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1010:26: error: 'QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_L' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_USB3_RCVR_DTCT_DLY_U3_L'?
>>>>>>>     1010 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_L, 0x40),
>>>>>>>          |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>>>>       78 |                 .offset = o,            \
>>>>>>>          |                           ^
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1011:26: error: 'QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_H' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_USB3_RCVR_DTCT_DLY_U3_H'?
>>>>>>>     1011 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_H, 0x00),
>>>>>>>          |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>>>>       78 |                 .offset = o,            \
>>>>>>>          |                           ^
>>>>>>>
>>>>>>> Caused by commit
>>>>>>>
>>>>>>>      685dbd1b2306 ("phy: qcom-qmp-usb: Add Qualcomm SDX75 USB3 PHY support")
>>>>>>>
>>>>>>> I have used the usb tree from next-20231003 for today.
>>>>>> Thanks, I've now reverted this from my tree.
>>>>> As mentioned in the cover letter of these changes, the series was dependent
>>>>> on the other submitted series [1], [2].
>>>> Ah, I missed that, I almost never read cover letters :)
>>>>
>>>>> Can you also pick these series [1], [2] to resolve this build failures.
>>>>> [1] https://lore.kernel.org/all/20230911203842.778411-1-dmitry.baryshkov@linaro.org/
>>>>> [2] https://lore.kernel.org/linux-phy/20230824211952.1397699-1-dmitry.baryshkov@linaro.org/
>>>> How about you just send this change with these others, or all of them as
>>>> one big series so they can be applied in the proper order?
>>> Adding Dmitry as well.
>>>
>>> I see some of the dependent patches are already applied and the patches from
>>> [2] are not.
>>> Since all the rest dependent changes are already applied,
>>> you can pick series[2] and then this series that should also be fine.
>>> Please let me know if this is fine?
>> What is "this" series?  I don't have any of these in my inbox at all
>> anymore, sorry.  Please resend the pending patches that need to be
>> applied to my usb tree and I will be glad to do so.
> Actually, I wonder why the PHY patches were merged through the USB
> tree, maybe that is the issue here.
Yes Actually these patches needs to go via phy tree. Can you please drop 
patch 1/5, 2/5 and 5/5
from the series [3] (keeping [1] and [2] same reference from above to 
avoid confusion).

[3] 
https://lore.kernel.org/all/1695359525-4548-1-git-send-email-quic_rohiagar@quicinc.com/

At the same time requesting Vinod to please pick the patches 1/5, 2/5 
and 5/5 from series [3] and series [2].

Thanks,
Rohit.

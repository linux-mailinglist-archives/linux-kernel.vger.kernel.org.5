Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A837BD696
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345681AbjJIJSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345623AbjJIJSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:18:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1266A3;
        Mon,  9 Oct 2023 02:18:42 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3999H05Z024838;
        Mon, 9 Oct 2023 09:18:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=42uL0Miy/BOYuXAbYidv+fw7jxLzFyLKKp+kUs5+6Xg=;
 b=UCdF5YQqe6s7CONlTmH5Gan1BAz+PUBvabw2p/RZFexA6hSnVZj+XgxQKcXZojQlVmFm
 LmuzS2yqlPwc4kp9LN+34V6ece0H/z2q9dQqE2nTZXFfNQFgKoZQCJV+LGCzv7mmTLXC
 XoKBYUnrEZ43TwGZ7TT5e8HEAGw0vFUl1Tjl6DYuOuGa+y60HiTZ6xoSgBq4m0GJBPPv
 f1Rj/k5zglJlxFL1sDU+PsNTd8G6unipbBcQksR6fQvuUWMXCH4hcFNCNia6Ujh1wy32
 0560n3YvGNLPp3o5g+iTT+4yQPdtOpSDstOlFqm9qRK6J/7OVPI9UTX5u6P7CE3pPYt1 uw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tkh879xq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 09:18:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3999IWsr028891
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Oct 2023 09:18:32 GMT
Received: from [10.214.66.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 9 Oct
 2023 02:18:31 -0700
Message-ID: <044a2146-f859-44b3-bcf7-66b68d3e7787@quicinc.com>
Date:   Mon, 9 Oct 2023 14:48:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the usb tree
To:     Greg KH <greg@kroah.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231004132247.01c3bfeb@canb.auug.org.au>
 <2023100410-concave-explore-95bf@gregkh>
 <e26b26ff-9e88-4455-9172-1afb520583e7@quicinc.com>
 <2023100445-cymbal-glade-52c8@gregkh>
Content-Language: en-US
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <2023100445-cymbal-glade-52c8@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iXAyWcdqTSzkC_rv50Uye4Hk0RcyBCPa
X-Proofpoint-GUID: iXAyWcdqTSzkC_rv50Uye4Hk0RcyBCPa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_07,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 impostorscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=789
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310090077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/4/2023 6:16 PM, Greg KH wrote:
> On Wed, Oct 04, 2023 at 12:17:27PM +0530, Rohit Agarwal wrote:
>> On 10/4/2023 12:13 PM, Greg KH wrote:
>>> On Wed, Oct 04, 2023 at 01:22:47PM +1100, Stephen Rothwell wrote:
>>>> Hi all,
>>>>
>>>> After merging the usb tree, today's linux-next build (x86_64 allmodconfig)
>>>> failed like this:
>>>>
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:156:43: error: 'QPHY_V6_PCS_SW_RESET' undeclared here (not in a function); did you mean 'QPHY_V2_PCS_SW_RESET'?
>>>>     156 |         [QPHY_SW_RESET]                 = QPHY_V6_PCS_SW_RESET,
>>>>         |                                           ^~~~~~~~~~~~~~~~~~~~
>>>>         |                                           QPHY_V2_PCS_SW_RESET
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:157:43: error: 'QPHY_V6_PCS_START_CONTROL' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_START_CONTROL'?
>>>>     157 |         [QPHY_START_CTRL]               = QPHY_V6_PCS_START_CONTROL,
>>>>         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
>>>>         |                                           QPHY_V3_PCS_START_CONTROL
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:158:43: error: 'QPHY_V6_PCS_PCS_STATUS1' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_PCS_STATUS1'?
>>>>     158 |         [QPHY_PCS_STATUS]               = QPHY_V6_PCS_PCS_STATUS1,
>>>>         |                                           ^~~~~~~~~~~~~~~~~~~~~~~
>>>>         |                                           QPHY_V5_PCS_PCS_STATUS1
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:159:43: error: 'QPHY_V6_PCS_POWER_DOWN_CONTROL' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_POWER_DOWN_CONTROL'?
>>>>     159 |         [QPHY_PCS_POWER_DOWN_CONTROL]   = QPHY_V6_PCS_POWER_DOWN_CONTROL,
>>>>         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>         |                                           QPHY_V3_PCS_POWER_DOWN_CONTROL
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:162:43: error: 'QPHY_V6_PCS_USB3_AUTONOMOUS_MODE_CTRL' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_USB3_AUTONOMOUS_MODE_CTRL'?
>>>>     162 |         [QPHY_PCS_AUTONOMOUS_MODE_CTRL] = QPHY_V6_PCS_USB3_AUTONOMOUS_MODE_CTRL,
>>>>         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>         |                                           QPHY_V5_PCS_USB3_AUTONOMOUS_MODE_CTRL
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:163:44: error: 'QPHY_V6_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR'?
>>>>     163 |         [QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V6_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
>>>>         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>         |                                            QPHY_V5_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:991:26: error: 'QPHY_V6_PCS_LOCK_DETECT_CONFIG1' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_LOCK_DETECT_CONFIG1'?
>>>>     991 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG1, 0xc4),
>>>>         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>      78 |                 .offset = o,            \
>>>>         |                           ^
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:992:26: error: 'QPHY_V6_PCS_LOCK_DETECT_CONFIG2' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_LOCK_DETECT_CONFIG2'?
>>>>     992 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG2, 0x89),
>>>>         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>      78 |                 .offset = o,            \
>>>>         |                           ^
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:993:26: error: 'QPHY_V6_PCS_LOCK_DETECT_CONFIG3' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_LOCK_DETECT_CONFIG3'?
>>>>     993 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG3, 0x20),
>>>>         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>      78 |                 .offset = o,            \
>>>>         |                           ^
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:994:26: error: 'QPHY_V6_PCS_LOCK_DETECT_CONFIG6' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_LOCK_DETECT_CONFIG6'?
>>>>     994 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG6, 0x13),
>>>>         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>      78 |                 .offset = o,            \
>>>>         |                           ^
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:997:26: error: 'QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_L' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_L'?
>>>>     997 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
>>>>         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>      78 |                 .offset = o,            \
>>>>         |                           ^
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:998:26: error: 'QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_H' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_H'?
>>>>     998 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
>>>>         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>      78 |                 .offset = o,            \
>>>>         |                           ^
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:999:26: error: 'QPHY_V6_PCS_CDR_RESET_TIME' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_CDR_RESET_TIME'?
>>>>     999 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_CDR_RESET_TIME, 0x0a),
>>>>         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>      78 |                 .offset = o,            \
>>>>         |                           ^
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1000:26: error: 'QPHY_V6_PCS_ALIGN_DETECT_CONFIG1' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_ALIGN_DETECT_CONFIG1'?
>>>>    1000 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_ALIGN_DETECT_CONFIG1, 0x88),
>>>>         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>      78 |                 .offset = o,            \
>>>>         |                           ^
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1001:26: error: 'QPHY_V6_PCS_ALIGN_DETECT_CONFIG2' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_ALIGN_DETECT_CONFIG2'?
>>>>    1001 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_ALIGN_DETECT_CONFIG2, 0x13),
>>>>         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>      78 |                 .offset = o,            \
>>>>         |                           ^
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1003:26: error: 'QPHY_V6_PCS_EQ_CONFIG1' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_EQ_CONFIG1'?
>>>>    1003 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_EQ_CONFIG1, 0x4b),
>>>>         |                          ^~~~~~~~~~~~~~~~~~~~~~
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>      78 |                 .offset = o,            \
>>>>         |                           ^
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1004:26: error: 'QPHY_V6_PCS_EQ_CONFIG5' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_EQ_CONFIG5'?
>>>>    1004 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_EQ_CONFIG5, 0x10),
>>>>         |                          ^~~~~~~~~~~~~~~~~~~~~~
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>      78 |                 .offset = o,            \
>>>>         |                           ^
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1008:26: error: 'QPHY_V6_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL'?
>>>>    1008 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
>>>>         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>      78 |                 .offset = o,            \
>>>>         |                           ^
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1009:26: error: 'QPHY_V6_PCS_USB3_RXEQTRAINING_DFE_TIME_S2' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_USB3_RXEQTRAINING_DFE_TIME_S2'?
>>>>    1009 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
>>>>         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>      78 |                 .offset = o,            \
>>>>         |                           ^
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1010:26: error: 'QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_L' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_USB3_RCVR_DTCT_DLY_U3_L'?
>>>>    1010 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_L, 0x40),
>>>>         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>      78 |                 .offset = o,            \
>>>>         |                           ^
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1011:26: error: 'QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_H' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_USB3_RCVR_DTCT_DLY_U3_H'?
>>>>    1011 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_H, 0x00),
>>>>         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>>>>      78 |                 .offset = o,            \
>>>>         |                           ^
>>>>
>>>> Caused by commit
>>>>
>>>>     685dbd1b2306 ("phy: qcom-qmp-usb: Add Qualcomm SDX75 USB3 PHY support")
>>>>
>>>> I have used the usb tree from next-20231003 for today.
>>> Thanks, I've now reverted this from my tree.
>> As mentioned in the cover letter of these changes, the series was dependent
>> on the other submitted series [1], [2].
> Ah, I missed that, I almost never read cover letters :)
>
>> Can you also pick these series [1], [2] to resolve this build failures.
>> [1] https://lore.kernel.org/all/20230911203842.778411-1-dmitry.baryshkov@linaro.org/
>> [2] https://lore.kernel.org/linux-phy/20230824211952.1397699-1-dmitry.baryshkov@linaro.org/
> How about you just send this change with these others, or all of them as
> one big series so they can be applied in the proper order?
Adding Dmitry as well.

I see some of the dependent patches are already applied and the patches 
from [2] are not.
Since all the rest dependent changes are already applied,
you can pick series[2] and then this series that should also be fine.
Please let me know if this is fine?

Thanks,
Rohit.
> thanks,
>
> greg k-h

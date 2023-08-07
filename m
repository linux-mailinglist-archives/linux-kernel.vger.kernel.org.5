Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19020771912
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 06:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjHGElk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 00:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjHGElh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 00:41:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7D210F3;
        Sun,  6 Aug 2023 21:41:36 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3774QDmd016997;
        Mon, 7 Aug 2023 04:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=qcppdkim1;
 bh=L/AODu6CiGzGr9FCJsPeSE9hoze7s8us5qkCMSXX18o=;
 b=VQFrzCxgAF5qJ/tQAmatax3uWgAJjH00KxlPVVHis+gHIuaSMoPAdCIa9YNvzTdb/98b
 OkO6B7HVLPYrBqLR5CoAsGpzBD11npNbjm5F99u+NZOsn+iq2bwen1vNPzvEcmvI/4tP
 ZTkWCTcn6KsdQaZmtXMQMgryN2vY3u7goI4C/lUCxU0Y80jyXmjmkMhI/cqlyCUcTgMS
 vBQg8fcPpcSrK/hfBDT1i/O6o+j7GafX9h6fMBmmx0xPL1Ipsz3pd9IPG2Mpo3PNqNUa
 9sS0t3zvTHIZI9gE8kup8ACke53mXDOa4DeGMgm+SP6XzubXcGnb2ro5gArdGJOiwsiP Eg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s9bsutqck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 04:41:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3774fVDY024504
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Aug 2023 04:41:31 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 6 Aug 2023 21:41:27 -0700
Date:   Mon, 7 Aug 2023 10:11:24 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_jackp@quicinc.com>
Subject: Re: [PATCH 3/8] arm64: dts: qcom: Add PMIC pm7550ba dtsi
Message-ID: <161713d4-1c95-4822-ac66-dbc7c2d8b421@quicinc.com>
References: <1690970366-30982-1-git-send-email-quic_rohiagar@quicinc.com>
 <1690970366-30982-4-git-send-email-quic_rohiagar@quicinc.com>
 <ce1af969-427a-3e4d-e85c-32d629755d9a@linaro.org>
 <bb374ec4-3dfa-42f1-dffb-fc8505625b73@quicinc.com>
 <2e97b032-4ca5-e59c-c891-2ed9ca39d237@linaro.org>
 <7941f5de-547c-4a92-9af1-a1c0add1ace4@quicinc.com>
 <dfe57d75-f0ff-41fb-bc81-0dc84dcfef7e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dfe57d75-f0ff-41fb-bc81-0dc84dcfef7e@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: T9m0EKq7IGi08IUHQM-3QZAy1U5Sedua
X-Proofpoint-ORIG-GUID: T9m0EKq7IGi08IUHQM-3QZAy1U5Sedua
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_02,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 mlxlogscore=322 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070042
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 06:58:34PM +0200, Konrad Dybcio wrote:
> On 3.08.2023 07:06, Pavan Kondeti wrote:
> > 
> > On Wed, Aug 02, 2023 at 03:14:19PM +0200, Konrad Dybcio wrote:
> >> On 2.08.2023 15:13, Rohit Agarwal wrote:
> >>>
> >>> On 8/2/2023 6:12 PM, Konrad Dybcio wrote:
> >>>> On 2.08.2023 11:59, Rohit Agarwal wrote:
> >>>>> Add dtsi for PMIC pm7550ba found in Qualcomm platforms.
> >>>>>
> >>>>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> >>>>> ---
> >>>> Subject: "PMIC pm7550ba" -> "pm7550ba PMIC"
> >>>>
> >>>> [...]
> >>>>
> >>>>> +
> >>>>> +        pm7550ba_eusb2_repeater: phy@fd00 {
> >>>>> +            compatible = "qcom,pm8550b-eusb2-repeater";
> >>>> A new compatible should be introduced, so that it goes like this:
> >>>>
> >>>> compatible = "qcom,pm7550ba-eusb2-repeater", "qcom,pm8550b-eusb2-repeater";
> >>> Just a doubt, Since the compatible can be same why we need to introduce a new compatible.
> >>> Should every soc have a compatible string?
> >> If it turns out that we need to add a quirk for PM7550BA 3 years down
> >> the line, this approach lets us fix it for users that never updated
> >> their device trees.
> >>
> > 
> > Trying to make my understanding clear.
> > 
> > eUSB repeater is a peripheral in the PMIC. Do we need a separate
> > compatible even if the peripheral is same in two different PMIC chips?
> > I believe eUSB peripheral has some identification registers to apply any
> > quirks in future.
> Perhaps, but keeping the compatible tied to the specific hardware is
> the way to go with the device tree. Most components don't have such
> information avaiable, and since at introduction time there wasn't
> any better name for it, "pm8550b-eusb2-repeater" was chosen.
> 

Thanks for the clarification and guidance. We can introduce a new
compatible and use qcom,pm8550b-eusb2-repeater as generic binding.

Thanks,
Pavan

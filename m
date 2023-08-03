Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8F276DF8C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 07:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjHCFHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 01:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjHCFHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 01:07:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A4510C1;
        Wed,  2 Aug 2023 22:07:03 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3733rn4B008712;
        Thu, 3 Aug 2023 05:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=qcppdkim1;
 bh=xpFDekMwUSJDrYjwp01Mb07R7FJlMGi3Al6Moa/52lQ=;
 b=cVoQubhdUyn4Fu0dT+m332rwLdUODBVAW6PIG7Chc3BAy+Lz5pim5rQeWNEBAwzCtRwS
 QDKke5oCVt4rloQ4//cD3F7pU1BWtih5wFIlrtLr2QAWC9PEnkQGsRysihIBypuOgk8/
 yAjDBbl2c3sunXnW9oED2UiDai+dxrByF94ddSJjM95FTxd2qMQkFJTUgjEJGZPQUR9g
 blMubf6dAneRPAykUt+bM8hStt/H+Ew5YNpjn50BOiKWD20q7ZgSMNxq7ugz/pTF+wsG
 lC6molMEIDjbFzvC+OVMf1axQbf6qk+uyRVL/0l2XWomf/A7QWUfeAcbI7EPzcqG3mpa 7Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s75dgc5ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 05:06:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37356qCC011877
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 05:06:52 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 22:06:48 -0700
Date:   Thu, 3 Aug 2023 10:36:45 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Rohit Agarwal <quic_rohiagar@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_jackp@quicinc.com>
Subject: Re: [PATCH 3/8] arm64: dts: qcom: Add PMIC pm7550ba dtsi
Message-ID: <7941f5de-547c-4a92-9af1-a1c0add1ace4@quicinc.com>
References: <1690970366-30982-1-git-send-email-quic_rohiagar@quicinc.com>
 <1690970366-30982-4-git-send-email-quic_rohiagar@quicinc.com>
 <ce1af969-427a-3e4d-e85c-32d629755d9a@linaro.org>
 <bb374ec4-3dfa-42f1-dffb-fc8505625b73@quicinc.com>
 <2e97b032-4ca5-e59c-c891-2ed9ca39d237@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e97b032-4ca5-e59c-c891-2ed9ca39d237@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: C-OcsofTPxVkeCo3JK--U4bpNshGPn-s
X-Proofpoint-ORIG-GUID: C-OcsofTPxVkeCo3JK--U4bpNshGPn-s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_02,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 mlxlogscore=279 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308030046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Aug 02, 2023 at 03:14:19PM +0200, Konrad Dybcio wrote:
> On 2.08.2023 15:13, Rohit Agarwal wrote:
> > 
> > On 8/2/2023 6:12 PM, Konrad Dybcio wrote:
> >> On 2.08.2023 11:59, Rohit Agarwal wrote:
> >>> Add dtsi for PMIC pm7550ba found in Qualcomm platforms.
> >>>
> >>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> >>> ---
> >> Subject: "PMIC pm7550ba" -> "pm7550ba PMIC"
> >>
> >> [...]
> >>
> >>> +
> >>> +        pm7550ba_eusb2_repeater: phy@fd00 {
> >>> +            compatible = "qcom,pm8550b-eusb2-repeater";
> >> A new compatible should be introduced, so that it goes like this:
> >>
> >> compatible = "qcom,pm7550ba-eusb2-repeater", "qcom,pm8550b-eusb2-repeater";
> > Just a doubt, Since the compatible can be same why we need to introduce a new compatible.
> > Should every soc have a compatible string?
> If it turns out that we need to add a quirk for PM7550BA 3 years down
> the line, this approach lets us fix it for users that never updated
> their device trees.
> 

Trying to make my understanding clear.

eUSB repeater is a peripheral in the PMIC. Do we need a separate
compatible even if the peripheral is same in two different PMIC chips?
I believe eUSB peripheral has some identification registers to apply any
quirks in future.

Adding Jack who would know more about any deltas between the PMICs in
sdx75 and sm8550.

Thanks,
Pavan

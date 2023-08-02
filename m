Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7472076D632
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjHBR5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjHBR5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:57:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380B19C;
        Wed,  2 Aug 2023 10:57:21 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372HYZlV001884;
        Wed, 2 Aug 2023 17:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=LrzR88o+DIj7W/tEDw0tIz5VvK34qlOm4eMbpqUNBiw=;
 b=SVCHGX8h36IG/gv504EsZinMMlDLNbGwQi97qErFC3GKOLKpXW3qzRg62NnzPOqYW46S
 VDCYqctLArfJCYDC+HsInFWTnIDtpdR9RtavS1kl6NeWrx7+gQld2FyDX6yPJ2fOuU9C
 h2Oemm1MlDZIhlMeLa6YOiFGRmmR7B6ISfTZ34IQ1C4PQmh28lmRR8jopYlRjmPJzSMa
 M9XDORmm82uHEaUEKUlxs6Y/faPMt7N+1pGZQUvoHVY83ZFgnXBkHoJQXWWb5DeZJVeh
 aQsXonlWeSxqugx3vyx8d0BKD2Njr4GQuEdLI7nQV0RmJEAi+Zny0FV8KWVW6jvopzLU zg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s72gquju5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 17:57:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 372HvHkt022081
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 17:57:17 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 10:57:17 -0700
Date:   Wed, 2 Aug 2023 10:57:15 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Rohit Agarwal <quic_rohiagar@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/8] arm64: dts: qcom: sdx75-idp: Add regulator nodes
Message-ID: <20230802175715.GJ1428172@hu-bjorande-lv.qualcomm.com>
References: <1690970366-30982-1-git-send-email-quic_rohiagar@quicinc.com>
 <1690970366-30982-9-git-send-email-quic_rohiagar@quicinc.com>
 <41b9bbd2-e58f-810d-ad3b-715423ffe74b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <41b9bbd2-e58f-810d-ad3b-715423ffe74b@linaro.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KYVvwMTgX8Az_itE7xG6rELIjHWeH6Tm
X-Proofpoint-ORIG-GUID: KYVvwMTgX8Az_itE7xG6rELIjHWeH6Tm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_14,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=760 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020158
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 02:49:56PM +0200, Konrad Dybcio wrote:
> On 2.08.2023 11:59, Rohit Agarwal wrote:
> > Add the regulators found on SDX75 IDP.
> > 
> > Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> > ---
> [...]
> 
> 
> > +		vreg_s2b_1p224: smps2 {
> Even though most RPMh devices use the schematic-like names, I think naming
> the labels like pmicname_regname, e.g. pm8550_l2 would be easier to read..
> (Bjorn, Krzysztof - opinions?)
> 

Using the naming from the schematics is preferred, and avoid various
levels of ambiguity.

> On top of that, please add labels to all of the regulators you're
> introducing to limit unnecessary diff in the future.
> 

There are cases where regulators are left on by the bootloader, but
doesn't have a function, or name, in the particular board. In this case
it might be unnecessary (or not possible) to label the regulator, but we
still might want to list the regulator so it will be turned off
automatically.

But such decision is explicit and should be mentioned either in a
comment or in the commit message.

Regards,
Bjorn

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71121807F75
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 05:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjLGEMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 23:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjLGEMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 23:12:44 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C5C1B4;
        Wed,  6 Dec 2023 20:12:50 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B73GL2b029931;
        Thu, 7 Dec 2023 04:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=DPjpRrL/za+yxHGpGqV2m9WYI4TpbKPjkDDWOXeGb5Q=;
 b=ICgKLPeJdePNqAw7oxNYtNJ7GmCThS5k5hGsozeqtkZ+Rn+uwJvvY5mJfuMr38+5MQBV
 Ha9YVzvfucP1CJO/2Ni30vC/3KtXtChWIZ+jjLBDPWJZI25qkDPgA8BJPJauvEEEsguo
 3QBjfn2LAsdgwzkWLnrOjTTIQDanvYnWEsFxbjpjHslV3mmMGApzxRGLi3esDU1+p1N1
 DAgMEVf9skz/WmAMnMxDazED4iNrHPK2LMuqEg2o6zyZcgs+Le3PHdUP2kxet+cr8Iov
 SnzVJQG8cmjF5HbeLq0aW63BHqn2bQ+Kpen78J0u4bUXmn0/o7MCgcFVLtxUfez6l4XE 9A== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uu2p88en5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 04:12:45 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B74CiCo029623
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Dec 2023 04:12:44 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Dec 2023 20:12:40 -0800
Date:   Thu, 7 Dec 2023 09:42:36 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] arm64: dts: qcom: ipq9574: Fix USB
 'vdda-pll-supply'
Message-ID: <ZXFGNLhyEZC924T8@hu-varada-blr.qualcomm.com>
References: <cover.1701160842.git.varada@hu-varada-blr.qualcomm.com>
 <f98bbf0a515236709d999010f08c8f2470a31209.1701160842.git.varada@hu-varada-blr.qualcomm.com>
 <832a6d4f-f561-4cf5-b1cb-7e4b2d4d50b4@linaro.org>
 <ZWW9oF24YUGfev+2@hu-varada-blr.qualcomm.com>
 <0acdc122-b7fa-4bb4-b838-6420cd43d0e0@linaro.org>
 <ZXBdHQpJYBmZbd76@hu-varada-blr.qualcomm.com>
 <a1cfc6af-080c-4aa1-8200-e230640f7ca3@linaro.org>
 <81bdac87-59e0-4618-a51d-ebe5cec6f54c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <81bdac87-59e0-4618-a51d-ebe5cec6f54c@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VAN8zApSXwIIpBwsY36r2XSOLDZYu73a
X-Proofpoint-ORIG-GUID: VAN8zApSXwIIpBwsY36r2XSOLDZYu73a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_01,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=836 mlxscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312070033
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 01:33:17PM +0100, Krzysztof Kozlowski wrote:
> On 06/12/2023 13:31, Krzysztof Kozlowski wrote:
> > On 06/12/2023 12:38, Varadarajan Narayanan wrote:
> >> On Tue, Nov 28, 2023 at 03:01:12PM +0100, Krzysztof Kozlowski wrote:
> >>> On 28/11/2023 11:14, Varadarajan Narayanan wrote:
> >>>> On Tue, Nov 28, 2023 at 09:51:50AM +0100, Krzysztof Kozlowski wrote:
> >>>>> On 28/11/2023 09:46, Varadarajan Narayanan wrote:
> >>>>>> From: Varadarajan Narayanan <quic_varada@quicinc.com>
> >>>>>>
> >>>>>> The earlier patch ec4f047679d5, incorrectly used 'l2'
> >>>>>> as the vdda-pll-supply. However, 'l5' is the correct
> >>>>>> ldo that supplies power to the USB PHY.
> >>>>>>
> >>>>>> Fixes: ec4f047679d5 ("arm64: dts: qcom: ipq9574: Enable USB")
> >>>>>
> >>>>> Doesn't this depend on the driver change?
> >>>>
> >>>> Yes, will mention in the cover letter.
> >>>
> >>> This commit should have it in its changelog ---
> >>>
> >>>>
> >>>>> It affects both existing
> >>>>> kernel and backports which you claim here should happen.
> >>>>
> >>>> Ok. Will include stable@vger.kernel.org in the next revision.
> >>>
> >>> I wasn't speaking about Cc. You indicated this should be backported.
> >>> Then please backport it, without previous commit, and check the result.
> >>> Is stable tree working correctly or not?
> >>
> >> Without the previous commit, it would fail in both the latest
> >> and stable tree. (Please see below for the error messages and
> >> stack dump)
> >>
> >> The previous commit is necessary for this commit to work.
> >
> > Yep, exactly. It's visible from the patches. I don't know how to solve
> > this exactly. The Fixes tag here is logically correct, but then any
> > backporting must include previous commit. Dependency can be provided in
> > cc-stable tag, but you did not cc-stable, I suppose on purpose.

It was not on purpose. Got lucky :).
Shall I separate the patches and wait till the first one gets
merged (in stable and top of tree) and then post the second one?

> > If this is chosen by AUTOSEL, are you going to check if backport
> > includes previous patch and object/review such backport?
>
> One more point. Except issues with backporting, you did not annotate any
> dependency so patches can be applied independently. This will lead to
> non-bisectable tree or even broken tree. What's more DTS goes always via
> separate tree and branches, so this patch must be delayed.
>
> You always must explicitly mention such dependencies and changes to
> default applying process, so maintainers know what to do. Nothing like
> this was explained anywhere here.

Sorry, my mistake. Will be careful in future.

Thanks for the feedback.

Regards
Varada

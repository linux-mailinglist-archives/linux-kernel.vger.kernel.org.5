Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27A77FB6E9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbjK1KPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjK1KPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:15:02 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDB4DC;
        Tue, 28 Nov 2023 02:15:09 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS5GINw015575;
        Tue, 28 Nov 2023 10:15:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=HjUiSUZwj5j8IsIno6+2NrMwnJbKBPe36Zpz4kUjDlM=;
 b=mWYu+PS8/Kb/2NbcG1+geidoQ/l8f2Fpb4O4rUgmhiTmtF+5xose2zN9cKjIlvmoUKwL
 hPhbfKqDYG0zndkV/TPBPz4bvJrlTR1jUXEY44QMhdVcy6nlwCds7vbTf8x9kas9mb7b
 8n3hGWK47yBrQxWO68i+lweDnBnl7+SxfRBCHfkbpRXq6bzPh65mA2IOWlRbUh/98p7f
 896YpIJshKu6BBdXn6jcIwegRPgDoQjgn+PYGJxNtzoGu3ltpMxEhYhy/jG/uXNXvomE
 KSH41rT4R12THKztNW909p7Q1Xq0x4JR58Pk6TIWzj8BsyRkqood0F68yCnvJ9wu69Ns jw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3umsvak2fb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 10:15:05 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ASAF4ts004551
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 10:15:04 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 28 Nov 2023 02:15:00 -0800
Date:   Tue, 28 Nov 2023 15:44:56 +0530
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
Message-ID: <ZWW9oF24YUGfev+2@hu-varada-blr.qualcomm.com>
References: <cover.1701160842.git.varada@hu-varada-blr.qualcomm.com>
 <f98bbf0a515236709d999010f08c8f2470a31209.1701160842.git.varada@hu-varada-blr.qualcomm.com>
 <832a6d4f-f561-4cf5-b1cb-7e4b2d4d50b4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <832a6d4f-f561-4cf5-b1cb-7e4b2d4d50b4@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Fdx1m2JwOburAe_Bgh71eb1fJwy9qrqN
X-Proofpoint-GUID: Fdx1m2JwOburAe_Bgh71eb1fJwy9qrqN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_09,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=245 phishscore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311280081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 09:51:50AM +0100, Krzysztof Kozlowski wrote:
> On 28/11/2023 09:46, Varadarajan Narayanan wrote:
> > From: Varadarajan Narayanan <quic_varada@quicinc.com>
> >
> > The earlier patch ec4f047679d5, incorrectly used 'l2'
> > as the vdda-pll-supply. However, 'l5' is the correct
> > ldo that supplies power to the USB PHY.
> >
> > Fixes: ec4f047679d5 ("arm64: dts: qcom: ipq9574: Enable USB")
>
> Doesn't this depend on the driver change?

Yes, will mention in the cover letter.

> It affects both existing
> kernel and backports which you claim here should happen.

Ok. Will include stable@vger.kernel.org in the next revision.

Thanks
Varada

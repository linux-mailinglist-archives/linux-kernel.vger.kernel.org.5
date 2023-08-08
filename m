Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED27774D1F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjHHVhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjHHVhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:37:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689FCE0;
        Tue,  8 Aug 2023 14:36:54 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378LV7Hj018705;
        Tue, 8 Aug 2023 21:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=Qk6K9+TYy+1m4aEUOdLzo2C2V+e6vt2G0LOr/J3Kpo0=;
 b=AxHaOfdl45f8/pnPxB+2OUJa8sz8CYhD8vcCJqN/x4y+/fkKTUBlN773qlqAHinhNtwR
 52AS/8nLBDr7aJtfcQ86neEX1Pq6SexveN22cexNb0yRcIfA3ANhmC+/GrNAhtkfyvBF
 ZZQRj2L2PzN10KwfJGOl9DGo9TWw6VsGKQ+AWXj3A8B40VjW6DcfCuO3dIt/2MgOWfsN
 PudvDnTplLXLgVRNCEauduhudSmZnxwULD0joqIc9t5xWZvmbwaNDrN507vGR52ixbUv
 mOJqYeNIPANMOgBxor0/e7WH1g9OIi1Y/GITxQzYqvG15dn/0E9MtObzTRt9uLHq+Z2W PA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sbppch05e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 21:36:49 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 378LamUv010257
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Aug 2023 21:36:48 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 8 Aug 2023 14:36:47 -0700
Date:   Tue, 8 Aug 2023 14:36:46 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Eric Chanudet <echanude@redhat.com>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: sa8540p-ride: enable rtc
Message-ID: <20230808213646.GK1428172@hu-bjorande-lv.qualcomm.com>
References: <20230718145105.3464105-1-echanude@redhat.com>
 <dtussvqzf7x5p633pxt3julkffhzt5rxwp3aghs4ocj5odq4la@ed6jhcv76hbk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dtussvqzf7x5p633pxt3julkffhzt5rxwp3aghs4ocj5odq4la@ed6jhcv76hbk>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 49BktmncCXWbgiWUX3N8J99I3BA-44fm
X-Proofpoint-GUID: 49BktmncCXWbgiWUX3N8J99I3BA-44fm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_20,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=957 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080192
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 08:59:30PM -0700, Bjorn Andersson wrote:
> On Tue, Jul 18, 2023 at 10:46:10AM -0400, Eric Chanudet wrote:
> > diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> [..]
> > +&pmm8540a_sdam_7 {
> > +	status = "okay";
> > +
> > +	rtc_offset: rtc-offset@ac {
> > +		reg = <0xac 0x4>;
> 
> I'm still trying to get confirmation that this is a good choice.
> 

I'm recommended that you use 0xa0 from SDAM2, "preferably in the second
PMM8540", instead.

Can you please give this a try, Eric?

Regards,
Bjorn

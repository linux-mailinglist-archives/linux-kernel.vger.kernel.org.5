Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028347E6D45
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbjKIPWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbjKIPWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:22:20 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F14A358E;
        Thu,  9 Nov 2023 07:22:18 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9CaW35023720;
        Thu, 9 Nov 2023 15:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=yQEoRSdF6qSesctAfZADz7nEZoVXc95UoU1NqxQT3Bg=;
 b=ltztnPpIJky02TcQqqeOZzzgwAjuJYPI+BAVVoOcXzU9e7JsdbI9U1mixdmhOtRG+cqo
 OZpc0sd0HA44xheOMhez/eu4zfNo6AKmBgI0DjBxXgarpvElgaRaR9v6762G8mlleJJI
 6yuF2WNyaFZ41hdLXA2rGkV1Y9Oj6DLi6AR+qQYpqcOAxvIXm3Wadhumr7vdpieGAdEO
 yY8vh1Iw7b0zY6rMrVqF06FuNqV193fg+tcyr4INkqBBGXyFhdMlUbN4+zyKeYwZQKpa
 9Ig1M7SI53JZePCt6eLVU8BpjHXY7z0LSwgiZHc1ZAkwhCuVld/GiwjkuLIMvMOI+vls ew== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u8ka1a7sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 15:22:07 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A9FM6dp020141
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Nov 2023 15:22:06 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 9 Nov 2023 07:22:06 -0800
Date:   Thu, 9 Nov 2023 07:22:04 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Dang Huynh <danct12@riseup.net>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 8/8] soc: qcom: socinfo: Add PM8937 Power IC
Message-ID: <20231109152204.GD3553829@hu-bjorande-lv.qualcomm.com>
References: <20231106-pm8937-v1-0-ec51d9eeec53@riseup.net>
 <20231106-pm8937-v1-8-ec51d9eeec53@riseup.net>
 <6715dfd5-acf5-434c-a9bd-0a5bcdd72010@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6715dfd5-acf5-434c-a9bd-0a5bcdd72010@linaro.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Kg2lboyyytK6CT4e6tUTgqbweZRvYWX4
X-Proofpoint-GUID: Kg2lboyyytK6CT4e6tUTgqbweZRvYWX4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_12,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxscore=0 mlxlogscore=430 adultscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 10:30:34PM +0100, Konrad Dybcio wrote:
> 
> 
> On 11/6/23 13:08, Dang Huynh wrote:
> > The PM8917 and PM8937 uses the same SUBTYPE ID.
> > 
> > The PM8937 is found in boards with MSM8917, MSM8937 and MSM8940
> > and APQ variants.
> > 
> > Signed-off-by: Dang Huynh <danct12@riseup.net>
> > ---
> Are they secretly the same thing? Do you know somebody with a PM8917-
> equipped device to check that theory out?
> 

PM8917 and PM8937 are not the same.

Regards,
Bjorn

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13C98091D3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbjLGTrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjLGTrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:47:13 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B08E10EF;
        Thu,  7 Dec 2023 11:47:19 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7HaXv0025803;
        Thu, 7 Dec 2023 19:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=qcppdkim1;
 bh=NF0QjdXOzsYzP6ZLyN8MP/4RJJ3NV8QqXpHthSi5yfI=;
 b=btLjF+Q1EtSAGUjZW7YiuSwa26dzZMtyJK1231oGJKzHmy0Z/M6VEZwEiCwixzp7+Y3q
 xWnH2zrJKzxfGAbAdT+cBztOWBTtQ/d+iY1l5rcRSOL2hdLjQRnC52k/Yd55m+cYhecC
 8TLsXulbL+IW+Gxjk45er/kwNlxdPJmFO9lvzUsOaCtFpzOD0rUaw1D/tLinO9E56dUf
 I62Phr2JgJASrO/J/vfillCX0NFZ/DdzXYmcHJ78fnWEHigVTFo2UULLWNgfdb1YOxs4
 /Rc5d93INgGTkSoSWGIXeIDftDKRqBXCOg92eKGKcac/8zqBl2So9T0JwiJaphP08j2x dg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uubdm1pbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 19:47:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B7Jl3Rx022664
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Dec 2023 19:47:03 GMT
Received: from hu-akhilpo-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Dec 2023 11:46:58 -0800
Date:   Fri, 8 Dec 2023 01:16:55 +0530
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     Danila Tikhonov <danila@jiaxyga.com>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <robdclark@gmail.com>, <quic_abhinavk@quicinc.com>,
        <sean@poorly.run>, <marijn.suijten@somainline.org>,
        <airlied@gmail.com>, <daniel@ffwll.ch>, <johan+linaro@kernel.org>,
        <andersson@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] drm/msm/adreno: Add support for SM7150 SoC machine
Message-ID: <n3y5vfgznufdzdkyv6ygtohkepat5ayrpklearjw6jin57ussu@6uds6wtgaeaq>
References: <20230926174243.161422-1-danila@jiaxyga.com>
 <20230926174243.161422-2-danila@jiaxyga.com>
 <42a1d0ab-4e8d-461d-bb2c-977a793e52b2@linaro.org>
 <1695755445.902336096@f165.i.mail.ru>
 <84e63b82-4fef-416b-8dbe-3838ad788824@linaro.org>
 <c684d0a7-3336-48e3-9d2b-5c92f9132550@linaro.org>
 <f76637f9-8242-4258-932e-b879145a5cfd@linaro.org>
 <99ffd03f-b888-4222-939b-603c10f2307b@jiaxyga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99ffd03f-b888-4222-939b-603c10f2307b@jiaxyga.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GqjrpESuv_j_AGaNy9HqaIuR4ssENHFN
X-Proofpoint-GUID: GqjrpESuv_j_AGaNy9HqaIuR4ssENHFN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_17,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=954
 adultscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 clxscore=1011 phishscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312070165
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 12:03:56AM +0300, Danila Tikhonov wrote:
> 
> sc7180/sm7125 (atoll) expects speedbins from atoll.dtsi:
> And has a parameter: /delete-property/ qcom,gpu-speed-bin;
> 107 for 504Mhz max freq, pwrlevel 4
> 130 for 610Mhz max freq, pwrlevel 3
> 159 for 750Mhz max freq, pwrlevel 5
> 169 for 800Mhz max freq, pwrlevel 2
> 174 for 825Mhz max freq, pwrlevel 1 (Downstream says 172, but thats probably
> typo)
A bit confused. where do you see 172 in downstream code? It is 174 in the downstream
code when I checked.
> For rest of the speed bins, speed-bin value is calulated as
> FMAX/4.8MHz + 2 round up to zero decimal places.
> 
> sm7150 (sdmmagpie) expects speedbins from sdmmagpie-gpu.dtsi:
> 128 for 610Mhz max freq, pwrlevel 3
> 146 for 700Mhz max freq, pwrlevel 2
> 167 for 800Mhz max freq, pwrlevel 4
> 172 for 504Mhz max freq, pwrlevel 1
> For rest of the speed bins, speed-bin value is calulated as
> FMAX/4.8 MHz round up to zero decimal places.
> 
> Creating a new entry does not make much sense.
> I can suggest expanding the standard entry:
> 
> .speedbins = ADRENO_SPEEDBINS(
>     { 0, 0 },
>     /* sc7180/sm7125 */
>     { 107, 3 },
>     { 130, 4 },
>     { 159, 5 },
>     { 168, 1 }, has already
>     { 174, 2 }, has already
>     /* sm7150 */
>     { 128, 1 },
>     { 146, 2 },
>     { 167, 3 },
>     { 172, 4 }, ),
> 

A difference I see between atoll and sdmmagpie is that the former
doesn't support 180Mhz. If you want to do the same, then you need to use
a new bit in the supported-hw bitfield instead of reusing an existing one.
Generally it is better to stick to exactly what downstream does.

-Akhil.

> All the best,
> Danila
> 
> On 11/22/23 23:28, Konrad Dybcio wrote:
> > 
> > 
> > On 10/16/23 16:32, Dmitry Baryshkov wrote:
> > > On 26/09/2023 23:03, Konrad Dybcio wrote:
> > > > On 26.09.2023 21:10, Danila Tikhonov wrote:
> > > > > 
> > > > > I think you mean by name downstream dt - sdmmagpie-gpu.dtsi
> > > > > 
> > > > > You can see the forked version of the mainline here:
> > > > > https://github.com/sm7150-mainline/linux/blob/next/arch/arm64/boot/dts/qcom/sm7150.dtsi
> > > > > 
> > > > > 
> > > > > All fdt that we got here, if it is useful for you:
> > > > > https://github.com/sm7150-mainline/downstream-fdt
> > > > > 
> > > > > Best wishes, Danila
> > > > Taking a look at downstream, atoll.dtsi (SC7180) includes
> > > > sdmmagpie-gpu.dtsi.
> > > > 
> > > > Bottom line is, they share the speed bins, so it should be
> > > > fine to just extend the existing entry.
> > > 
> > > But then atoll.dtsi rewrites speed bins and pwrlevel bins. So they
> > > are not shared.
> > +Akhil
> > 
> > could you please check internally?
> > 
> > Konrad
> 

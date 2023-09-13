Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0328179DD90
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 03:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238028AbjIMBaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 21:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjIMBaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 21:30:11 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB29810E6;
        Tue, 12 Sep 2023 18:30:07 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38D0t6Bq007935;
        Wed, 13 Sep 2023 01:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=uRBI9opgeNWKU7JkoyaAlhvxGF4XiO7Ki7rjehaRTZU=;
 b=pjOOSuAU9aTnVEgfUTdMRgnBQrFewmT2g+zv+800iSsgB8C7JSoMZYfcTk/Wc3uiIXGg
 c8Hn2mQMibDAvgElDSBgQd4xuFq2YrWqoWoJZ2qxEbDqNip5tCyQV1bZv4y7PYIW557y
 1ttOAdQbO1wQPVAsAa6/zIvUE6vDy8UcrYYnkZ1Y5Eos23i8DhLzYEv6xcqb35Qgv6uI
 i5fkyZ5ep0v3EockGXX6C6Z95EPh/lRMVGGSInx17Cu8X93A4L3wb1uWxCvlex22tCwT
 USi6/2iXDbpFXkZlkOqGUsjHUTYZom8cH0U8o3/xRu4OkiYdpszV4hhP643etWACyuAR oA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t2ygr8dd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 01:29:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38D1Tr1i027648
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 01:29:53 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 12 Sep 2023 18:29:52 -0700
Date:   Tue, 12 Sep 2023 18:29:51 -0700
From:   Mike Tipton <quic_mdtipton@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/53] icc-rpmh multi-RSC voting groundwork
Message-ID: <20230913012951.GA19284@hu-mdtipton-lv.qualcomm.com>
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
 <c067a45f-9629-d516-9e56-36538e4ff6db@kernel.org>
 <20230807215739.GA9621@hu-mdtipton-lv.qualcomm.com>
 <10520827-dc01-475c-b09a-35cefc9e0a62@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <10520827-dc01-475c-b09a-35cefc9e0a62@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Jx15JH6gwGlVH_vgYd4PLRPyD2M4TQi1
X-Proofpoint-ORIG-GUID: Jx15JH6gwGlVH_vgYd4PLRPyD2M4TQi1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_24,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 impostorscore=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130011
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 02:14:14PM +0200, Konrad Dybcio wrote:
> > The general idea is that we could use tags for this. So, instead of...
> > 
> >   path = icc_get(dev, MASTER_MDP_DISP, SLAVE_EBI1_DISP);
> > 
> > it would be...
> > 
> >   path = icc_get(dev, MASTER_MDP, SLAVE_EBI1);
> >   icc_set_tag(path, QCOM_ICC_TAG_VOTER_DISP);
> > 
> > I have an early prototype with basic testing already. I can hopefully
> > clean it up and post for review in the next couple of weeks.
> I was initially not very happy with this approach (overloading tags
> with additional information), but it grew on me over time.
> 
> My only concern is that if we reserve say bits 16-31 for path tags
> (remember, dt-bindings are ABI), we may eventually run out of them.

The voter tags wouldn't require bitmasks like the bucket tags do. We'd
just need an integer for each voter shifted into the proper position in
the tag value. Thus, reserving N bits for the voters would give us 2**N
voters, which should be plenty. For example:

  #define QCOM_ICC_VOTERS_START           16
  #define QCOM_ICC_VOTERS_END             23

  #define QCOM_ICC_TAG_VOTER_HLOS         (0 << QCOM_ICC_VOTERS_START)
  #define QCOM_ICC_TAG_VOTER_DISP         (1 << QCOM_ICC_VOTERS_START)
  #define QCOM_ICC_TAG_VOTER_CAM_IFE_0    (2 << QCOM_ICC_VOTERS_START)
  #define QCOM_ICC_TAG_VOTER_CAM_IFE_1    (3 << QCOM_ICC_VOTERS_START)
  #define QCOM_ICC_TAG_VOTER_CAM_IFE_2    (4 << QCOM_ICC_VOTERS_START)

The applicable voters should likely be defined in the target-specific
headers, rather than the common qcom,icc.h. The bit range used for them
could be common, but each target may only support a small subset of the
total set of possible voters across all targets.

Clients requiring multiple voters for the same logical path should be
rare. On the off-chance they require that, they could just request the
same path multiple times with different voter tags applied and call
icc_set_bw() for each of them separately.

I'm back from travel and vacation and plan to pick this up again soon.

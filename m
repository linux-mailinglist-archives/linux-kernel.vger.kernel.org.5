Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A361D7A233D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbjIOQGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235725AbjIOQFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:05:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0795101;
        Fri, 15 Sep 2023 09:05:40 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FD4qp8030120;
        Fri, 15 Sep 2023 16:05:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=hZOSoryLz/oMKtxYiMHTGbPDAmJb4iqKx9FAwvaOf7c=;
 b=Q0Wc1UutUxoIDs5I8uunYXHNwMbqJuoq/hGJi2RLLki22wUzOBysRiJry/WR/90hWk9R
 pq32oRkMaGMoOOzyFFsQ3MfMpdwYgf31DzwQ/SEuYHjgujH5tHYZfst6C3sYiIAV/T98
 15pWZLmLC0by28BfB7ZJ3c88rdjeXcukI6l9+u2ejIwiXfTgzFkCo5CLSahEHok1Vbc4
 AxEggKkGu0MBugLhPNYNfb8xLXTF46stULU9ImHpG5iqDRv2LG45qGgem7v0CimFAMWa
 yv+0uL+SzLnYXcopOrlP62d1SauFmTvLFFm2HSg13rujm/6CSAbIhWh1M9YU93hPj0zE /A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4g2ssmrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 16:05:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38FG5R24008298
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 16:05:27 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 15 Sep 2023 09:05:27 -0700
Date:   Fri, 15 Sep 2023 09:05:25 -0700
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
Message-ID: <20230915160525.GA14240@hu-mdtipton-lv.qualcomm.com>
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
 <c067a45f-9629-d516-9e56-36538e4ff6db@kernel.org>
 <20230807215739.GA9621@hu-mdtipton-lv.qualcomm.com>
 <10520827-dc01-475c-b09a-35cefc9e0a62@linaro.org>
 <20230913012951.GA19284@hu-mdtipton-lv.qualcomm.com>
 <ffc58838-c306-49f3-a90a-95b2cf02ae3d@linaro.org>
 <20230914023239.GA25147@hu-mdtipton-lv.qualcomm.com>
 <978fd46d-8142-41e6-9c62-df678018d6c2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <978fd46d-8142-41e6-9c62-df678018d6c2@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FdqQz3_f9hM-uonH0jWnPsjr7s9Yizxs
X-Proofpoint-ORIG-GUID: FdqQz3_f9hM-uonH0jWnPsjr7s9Yizxs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_12,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 03:43:27PM +0200, Konrad Dybcio wrote:
> On 14.09.2023 04:32, Mike Tipton wrote:
> > On Wed, Sep 13, 2023 at 10:31:49AM +0200, Konrad Dybcio wrote:
> >>> The applicable voters should likely be defined in the target-specific
> >>> headers, rather than the common qcom,icc.h. The bit range used for them
> >>> could be common, but each target may only support a small subset of the
> >>> total set of possible voters across all targets.
> >> I'm not sure how client drivers would then choose the
> >> correct path other than
> >>
> >> switch (soc) {
> >> case 8450:
> >> 	tag = QCOM_ICC_TAG_VOTER_8450_HLOS;
> >> 	break;
> >> case 8550:
> >> 	tag = QCOM_ICC_TAG_VOTER_8550_HLOS;
> >> 	break;
> >> ...
> >> }
> >>
> >> which would be unacceptable.
> > 
> > The same general way it's handled for the endpoint bindings, which are
> > already target-specific. 
> > 
> > Any client drivers hardcoding the endpoint bindings in their driver
> > would have to include the appropriate, target-specific binding header
> > (e.g. qcom,sm8550-rpmh.h). That would only be possible if their driver
> > file is itself target-specific. Otherwise, it would have to pull the
> > endpoint bindings from devicetree. Or just use the recommended
> > of_icc_get() and let devicetree do everything for them. Same for the
> > target-specific voter tag bindings.
> > 
> > Clients can also specify their tags in devicetree. They don't actually
> > have to call icc_set_tag() directly. For example:
> > 
> >     #include <dt-bindings/interconnect/qcom,sm8450.h>
> > 
> >     interconnects = <&mmss_noc MASTER_MDP QCOM_ICC_TAG_VOTER_DISP
> >                      &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_VOTER_DISP>;
> > 
> > Then when they call of_icc_get() for this path it'll automatically have
> > QCOM_ICC_TAG_VOTER_DISP set for them.
> I think I'd skew towards the "define everything in the DT" approach.
> 
> One thing that makes me uneasy to go on with this approach is the
> question whether there is a case in which we would want to switch
> from e.g. voting through DISP to voting through APPS (or similar)
> from within a single device.

It shouldn't be common. But it could be done fairly simply by listing
paths for each different voter in the dt properties. 

    interconnects = <&mmss_noc MASTER_MDP QCOM_ICC_TAG_VOTER_APPS
                     &mc_virt SLAVE_EBI1  QCOM_ICC_TAG_VOTER_APPS>,
                    <&mmss_noc MASTER_MDP QCOM_ICC_TAG_VOTER_DISP
                     &mc_virt SLAVE_EBI1  QCOM_ICC_TAG_VOTER_DISP>,
    interconnect-names = "path-apps-voter",
                         "path-disp-voter";


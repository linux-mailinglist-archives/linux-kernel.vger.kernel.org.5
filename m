Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52ED379F822
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjINCc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjINCc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:32:58 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEEC1AD;
        Wed, 13 Sep 2023 19:32:54 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E0uCgg019721;
        Thu, 14 Sep 2023 02:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=IgO3mqpLSWVJHvkh+qBggAdQouLFnxNzFgwRRXD33KE=;
 b=g2o3bZy4O+PkbvDLTSF4huJnpfmXwCcxOG+jE6ayjwIAYikwYOPrlN+qwsnsXOwoDeow
 uTc6+dhK4uwlguBVMfGjrjSgCy7cYPi1SIaqBEoRXSzMKmaPZ1zPyTUY7CXAIJuY8yZK
 +8KcQiQ2G+y4ZurHlK4nnfo0F1D8ilXjCG+r3VvThetFp5F/F7sJkUvCjc2HFqNkTPRt
 +AItnt1y4nx71rSc/C7yC/of8xXoqynz2UGHBZA+rwHZizVg9ZfU0wYYPjJG73Jc7NAV
 FCqwz4i1+p8imApttBUdA9HaZv5ZjAV1V5P3CaPcJBC65ZBkm8Z3nPfyFGSh+F/zxVA7 Lw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t2y7qbg9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 02:32:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38E2WetV031475
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 02:32:40 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 13 Sep 2023 19:32:40 -0700
Date:   Wed, 13 Sep 2023 19:32:39 -0700
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
Message-ID: <20230914023239.GA25147@hu-mdtipton-lv.qualcomm.com>
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
 <c067a45f-9629-d516-9e56-36538e4ff6db@kernel.org>
 <20230807215739.GA9621@hu-mdtipton-lv.qualcomm.com>
 <10520827-dc01-475c-b09a-35cefc9e0a62@linaro.org>
 <20230913012951.GA19284@hu-mdtipton-lv.qualcomm.com>
 <ffc58838-c306-49f3-a90a-95b2cf02ae3d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ffc58838-c306-49f3-a90a-95b2cf02ae3d@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0dFrF8mWXndu0a5H5z8d_erqmvHIcWJ5
X-Proofpoint-ORIG-GUID: 0dFrF8mWXndu0a5H5z8d_erqmvHIcWJ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_19,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 spamscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140020
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 10:31:49AM +0200, Konrad Dybcio wrote:
> > The applicable voters should likely be defined in the target-specific
> > headers, rather than the common qcom,icc.h. The bit range used for them
> > could be common, but each target may only support a small subset of the
> > total set of possible voters across all targets.
> I'm not sure how client drivers would then choose the
> correct path other than
> 
> switch (soc) {
> case 8450:
> 	tag = QCOM_ICC_TAG_VOTER_8450_HLOS;
> 	break;
> case 8550:
> 	tag = QCOM_ICC_TAG_VOTER_8550_HLOS;
> 	break;
> ...
> }
> 
> which would be unacceptable.

The same general way it's handled for the endpoint bindings, which are
already target-specific. 

Any client drivers hardcoding the endpoint bindings in their driver
would have to include the appropriate, target-specific binding header
(e.g. qcom,sm8550-rpmh.h). That would only be possible if their driver
file is itself target-specific. Otherwise, it would have to pull the
endpoint bindings from devicetree. Or just use the recommended
of_icc_get() and let devicetree do everything for them. Same for the
target-specific voter tag bindings.

Clients can also specify their tags in devicetree. They don't actually
have to call icc_set_tag() directly. For example:

    #include <dt-bindings/interconnect/qcom,sm8450.h>

    interconnects = <&mmss_noc MASTER_MDP QCOM_ICC_TAG_VOTER_DISP
                     &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_VOTER_DISP>;

Then when they call of_icc_get() for this path it'll automatically have
QCOM_ICC_TAG_VOTER_DISP set for them.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9397731BE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 23:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjHGV6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 17:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjHGV6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 17:58:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB53FDB;
        Mon,  7 Aug 2023 14:57:53 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 377LgpjA008701;
        Mon, 7 Aug 2023 21:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=QPCAV9pyNoC0h6RfGBJgwpUbQEL+UJj8rm3tn0R9vW4=;
 b=irmgA6P67oB7glk8LWMvE96ZiST3DuE2xRYvn4JdPRSHkI0p4IQmIN6517uaX4/K6uJr
 JXAuI1UWiQ2Gw3WrtrCkD9eYLY7+ZiBrVVVmdSnbc4OnaW2UiHXf6hFUAP9QDvQinv00
 k4dL/9mG5WeifKJIG73pHEjnKoR+FSW7XZcCGkgTAKEFJmOp02GKes+/8V54GIo4cYp+
 UCM8OiPui/uJYPJ9GYPn6M+6XUlioIamm6mAEGjAD2EVm5xtaHBLCI/26NLnRKie4XkM
 pzWlEd+dfGe0ylZ3hLP60LgnKqMNjIyTRQ9X8s+RL5KTdEbitOWGirchlOdC9clmhawk dw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3saxbbsbmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 21:57:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 377Lvf6G012050
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Aug 2023 21:57:41 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 7 Aug 2023 14:57:40 -0700
Date:   Mon, 7 Aug 2023 14:57:39 -0700
From:   Mike Tipton <quic_mdtipton@quicinc.com>
To:     Georgi Djakov <djakov@kernel.org>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/53] icc-rpmh multi-RSC voting groundwork
Message-ID: <20230807215739.GA9621@hu-mdtipton-lv.qualcomm.com>
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
 <c067a45f-9629-d516-9e56-36538e4ff6db@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c067a45f-9629-d516-9e56-36538e4ff6db@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KEfak8hgRYBt2UyjLGg6DaQalcjhtdha
X-Proofpoint-GUID: KEfak8hgRYBt2UyjLGg6DaQalcjhtdha
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_24,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 spamscore=0 clxscore=1011 impostorscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070199
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 07:48:08PM +0300, Georgi Djakov wrote:
> Hi Konrad,
> 
> On 11.07.23 15:17, Konrad Dybcio wrote:
> > Many parts of Qualcomm SoCs are entirely independent of each other and can
> > run when the other parts are off. The RPMh system architecture embraces
> > this by giving each (loosely defined) subsystem its own connection (as in,
> > physical wires) to the AOSS, terminated by per-subsystem RSCs (Resource
> > State Coordinators) that barter for power, bandwidth etc.
> > 
> > This series introduces the groundwork necessary for voting for resources
> > through non-APPS RSCs. It should allow for lower-latency vote adjustments
> > (e.g. for very high bandwidth / multiple displays) and could potentially
> > allow for full APSS collapse while keeping e.g. MDSS operating (say
> > refreshing an image from a RAM buffer).
> 
> This is good stuff. Thanks for working on it! Actually the path tagging,
> that have been introduced some time ago could be used for supporting the
> multiple RSCs. Today we can get the tags from DT, and tag the path with
> some DISP_RSC flag (for example) and avoid the qcom,bcm-voter-idx property.
> 
> Mike has been also looking into this, so maybe he can share his thoughts.
> 

Yeah, the current way we've been supporting multiple voters (e.g. RSCs)
doesn't scale. We currently duplicate the topology for any path that
requires a secondary, non-APSS voter. Which means we have duplicates
nodes and bindings for each hop in those paths, even though there's only
a single logical path.

For example, in qcom/sm8550.c, each node and BCM ending with _disp,
_ife_0, _ife_1, or _ife_2 is a duplicate. The only reason they exist is
to allow clients to target their votes to the non-APPS voters. And to
provide separate, voter-specific buckets of aggregation. But everything
else about them is 100% identical to their default APPS counterparts.
For sm8550, this amounts to roughly 643 extra lines of code.

Initially there was only the one secondary display voter, so the scaling
problem wasn't a huge issue. But sm8550 has four voters. And future SOCs
will have even more.

We should only define the logical topology once. The ratio of NOC ports
to interconnect nodes should be 1:1, rather than 1:N where N is the
number of voters that care about them.

The general idea is that we could use tags for this. So, instead of...

  path = icc_get(dev, MASTER_MDP_DISP, SLAVE_EBI1_DISP);

it would be...

  path = icc_get(dev, MASTER_MDP, SLAVE_EBI1);
  icc_set_tag(path, QCOM_ICC_TAG_VOTER_DISP);

I have an early prototype with basic testing already. I can hopefully
clean it up and post for review in the next couple of weeks.

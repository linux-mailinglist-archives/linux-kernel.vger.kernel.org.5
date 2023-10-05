Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B517BAEC3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 00:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjJEWUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 18:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjJEWUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 18:20:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAC79E;
        Thu,  5 Oct 2023 15:20:38 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395MCovx011432;
        Thu, 5 Oct 2023 22:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=VtvUZyDxaVYZXARp1Fmae+hVYKfon/wKrJEtk7Yz5n0=;
 b=R/W7+3H1VDQnr9rMxOa3pi7dbl06gMlwgYgRlIh3CdwhFFt4vIyvwtoLhyNX/KwhDkjb
 BwE4Ze2/oQXahoKOxyoVSM1y8E0k2Vtmf5wXvi/SJx1781NunhrkLuDUUlNMoNHG4V8i
 yeU0OwcIgHo01OSMFQeke+OJ34VWL4hewOm6JyNKSS6zd0Lw66u4N6oQMVFyeliTNKIu
 ewrsjSzwXuM9lvDtIo1Ymqs40eC5J/extRj2CWfMJqFrhXhm6cdh9jEQ4PhNyR8eIo+a
 J4M1ospAJIMb0nW/waPvUYchgg76P14JsLZudE3Brdgjr9UCy37bJrNN0wKLr4Lyunsl 9g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3thn05a3wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 22:20:18 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 395MKHlg017242
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Oct 2023 22:20:17 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 5 Oct 2023 15:20:17 -0700
Date:   Thu, 5 Oct 2023 15:20:16 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Nikunj Kela <quic_nkela@quicinc.com>, <cristian.marussi@arm.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] firmware: arm_scmi: Add qcom hvc/shmem transport
 support
Message-ID: <20231005222016.GI3553829@hu-bjorande-lv.qualcomm.com>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230911194359.27547-1-quic_nkela@quicinc.com>
 <20230911194359.27547-5-quic_nkela@quicinc.com>
 <20231003111914.63z35sn3r3k7drtp@bogus>
 <6246714a-3b40-e1b6-640e-560ba55b6436@quicinc.com>
 <20231004160630.pxspafszlt6o7oj6@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231004160630.pxspafszlt6o7oj6@bogus>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UDw0cKnzIBCJJ4L7j24wEV5YOwKBRLD4
X-Proofpoint-GUID: UDw0cKnzIBCJJ4L7j24wEV5YOwKBRLD4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_16,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 mlxscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310050169
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 05:06:30PM +0100, Sudeep Holla wrote:
> On Tue, Oct 03, 2023 at 09:16:27AM -0700, Nikunj Kela wrote:
> > On 10/3/2023 4:19 AM, Sudeep Holla wrote:
> > > On Mon, Sep 11, 2023 at 12:43:59PM -0700, Nikunj Kela wrote:
> > > > diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
[..]
> > > > @@ -63,6 +66,8 @@ struct scmi_smc {
> > > >   	u32 func_id;
> > > >   	u32 param_page;
> > > >   	u32 param_offset;
> > > > +	u64 cap_id;
> > > Can it be unsigned long instead so that it just works for both 32 and 64 bit.
> > 
> > My first version of this patch was ulong but Bjorn suggested to make this
> > structure size fixed i.e. architecture independent. Hence changed it to u64.
> > If you are ok with ulong, I can change it back to ulong.
> >
> 
> SMCCC pre-v1.2 used the common structure in that way. I don't see any issue
> with that. I haven't followed Bjorn suggestions/comments though.
> 

My request was that funcId and capId is an ABI between the firmware and
the OS, so I'd like for that to use well defined, fixed sized, data
types - if nothing else just for documentation purpose.

These values will be truncated when passed to arm_smccc_1_1_invoke()
anyways, so I don't have any opinion against using unsigned long here...


PS. I understand why func_id is u32, but why are param_page and
param_offset u32?

Regards,
Bjorn

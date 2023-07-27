Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEE776441C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 05:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjG0DBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 23:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjG0DBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 23:01:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F741BCB;
        Wed, 26 Jul 2023 20:00:59 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R2JCa1009162;
        Thu, 27 Jul 2023 03:00:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=j4aARu0MkArEU5RCLOwlPl8+9JwP9fo0BEv/2Jdj1/g=;
 b=mSaSXrcpOO7LNktBZnxbNwhcmsY7qcvu8dX6CejE5OEuSp1vdXarOu96D2h1Rs20pJuP
 MbS3MsZ4smx3LLAn7O6UjZ7bJL5URvw0bKg5+h4VquRp1YNlEE8LGMozCzAcwr5lh9pm
 3dwmS4asu5+Oxr7biROh75QS0DB9TXULNnrtlnFPU/rjJG3sN1VW5jRmV2HaFhSAFZCh
 WRXQuy8v0b6oyYd4CyWDWpH6BsWxoz3QGXc8vqvTl5S/ezwRa9HetgichqQJAqEIJcyq
 ekpzEfDrDyYhguMgU4+M1ABUOu7oEC5WjhatUPmIqM9+5QIxFndThjLgEMW9Q3UoZB2g HQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s336t1j6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 03:00:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36R30mM4013784
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 03:00:48 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 26 Jul 2023 20:00:43 -0700
Date:   Thu, 27 Jul 2023 08:30:39 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
CC:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Sebastian Reichel" <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        "Prasad Sodagudi" <quic_psodagud@quicinc.com>
Subject: Re: [RFC PATCH 4/4] power: reset: Implement a PSCI SYSTEM_RESET2
 reboot-mode driver
Message-ID: <c1c2653e-4f3b-45f2-9325-d0ed8572a346@quicinc.com>
References: <20230724223057.1208122-1-quic_eberman@quicinc.com>
 <20230724223057.1208122-5-quic_eberman@quicinc.com>
 <46744a2e-139c-4e4e-89b2-66346f64c3f2@quicinc.com>
 <6a0ea31d-814b-6745-d301-c1f6dadf9718@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6a0ea31d-814b-6745-d301-c1f6dadf9718@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5uIHP9ddzcxBs_J2QaGvp2NLe92urYsY
X-Proofpoint-GUID: 5uIHP9ddzcxBs_J2QaGvp2NLe92urYsY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 mlxlogscore=794 adultscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270026
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 10:19:01AM -0700, Elliot Berman wrote:
> 
> 
> On 7/26/2023 3:41 AM, Pavan Kondeti wrote:
> > On Mon, Jul 24, 2023 at 03:30:54PM -0700, Elliot Berman wrote:
> > > PSCI implements a restart notifier for architectural defined resets.
> > > The SYSTEM_RESET2 allows vendor firmware to define additional reset
> > > types which could be mapped to the reboot reason.
> > > 
> > > Implement a driver to wire the reboot-mode framework to make vendor
> > > SYSTEM_RESET2 calls on reboot.
> > > 
> > > Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> > 
> > Do we need to skip the PSCI call from the existing PSCI restart notifier
> > which gets called after your newly introduced callback from reboot mode
> > notifier?
> > 
> 
> No need, the vendor SYSTEM_RESET2 call shouldn't return if the call worked.
> 

From the documentation of restart handlers, restarting from reboot
notifiers may not be correct. Since you hooked it up with reboot-mode
driver framework, you may restart the system much early before the
actual machine restart kicks in. Pls check. 

Thanks,
Pavan

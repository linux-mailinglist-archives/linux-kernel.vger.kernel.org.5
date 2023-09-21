Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4633D7AA4EB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjIUW0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbjIUWZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:25:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA1A6E90;
        Thu, 21 Sep 2023 10:05:22 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LBPFsB015981;
        Thu, 21 Sep 2023 13:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=cD5Or24CZG81ZUTaaF+5Vpj9oUT+HOKZ5Ed4kTL/4UM=;
 b=fDXsRMv2cxiHx925ps72qevFS8eYbv887C5VeEW3NjJDItoDd2HGvz+lkF6jQ8FBsejO
 Uz99BoNrOwiWmQe7KQ5dED6cvG9x5MgL73T1zpquMJr8usXzdVCEdESRAxOOQEs5RccX
 YsKgg9ITuOkfpD2vjxcbHbUx6kAh+gWOe0ZI/B1bIm+tKc968sqC4JCRQuQZ+WofKgbu
 178rSic6zncbtvSSYPzA9XDBbwJepCfYD57e9Lhs0CAwtSOa5nvNeC5Fg+sVY9wShxpv
 l42hJY2kqEl9bnWalvWjMMRb48IHI7bw1p9x4zTIM2iYn9tKENTOpPdER6UrA9Our885 Eg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t87511u14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 13:58:46 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38LDwkB3023005
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 13:58:46 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 21 Sep 2023 06:58:45 -0700
Date:   Thu, 21 Sep 2023 06:58:44 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Can Guo <quic_cang@quicinc.com>, <quic_nguyenb@quicinc.com>,
        <quic_nitirawa@quicinc.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>
Subject: Re: [PATCH 4/6] phy: qualcomm: phy-qcom-qmp-ufs: Move data structs
 and setting tables to header
Message-ID: <20230921135844.GJ1487598@hu-bjorande-lv.qualcomm.com>
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
 <1694411968-14413-5-git-send-email-quic_cang@quicinc.com>
 <CAA8EJpoWnXeJKPB04kJW6Qo7ifAnt1u2ZSiq+W2HWOez=hi5gA@mail.gmail.com>
 <20230919121524.GD4732@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230919121524.GD4732@thinkpad>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IW9xvv3U4ODVgGvl-Jx7bxMrXq2se5ma
X-Proofpoint-ORIG-GUID: IW9xvv3U4ODVgGvl-Jx7bxMrXq2se5ma
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_11,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 phishscore=0 mlxlogscore=953 impostorscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309210121
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 02:15:24PM +0200, Manivannan Sadhasivam wrote:
> On Thu, Sep 14, 2023 at 03:28:59PM +0300, Dmitry Baryshkov wrote:
> > On Mon, 11 Sept 2023 at 09:01, Can Guo <quic_cang@quicinc.com> wrote:
> > >
> > > To make the code more readable, move the data structs and PHY settting
> > > tables to a header file, namely the phy-qcom-qmp-ufs.h.
> > >
> > > Signed-off-by: Can Guo <quic_cang@quicinc.com>
> > > ---
> > >  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 802 +------------------------------
> > >  drivers/phy/qualcomm/phy-qcom-qmp-ufs.h | 805 ++++++++++++++++++++++++++++++++
> > >  2 files changed, 806 insertions(+), 801 deletions(-)
> > >  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-ufs.h
> > 
> > Is there any reason to do so? Other than just moving stuff around, it
> > doesn't give us anything. This header will not be shared with any
> > other driver. Just moving data tables to the header (ugh, static data
> > in the header) doesn't make code more readable.
> > 
> 
> I think the motive here is to move the static tables to one file and have the
> rest of the code in another. Because, the static tables itself occupy 1.2k LoC
> now and it is going to grow. So let's keep them in a single file to avoid mixing
> it with rest of the driver code.
> 

To me, the problem with the current layout is that we have:
* structures
* data
* structures
* implementation

So to find the second structures you need to jump somewhere in the
middle of the file. If we shift those up, it's easy to jump between the
three portions of the file.

Regards,
Bjorn

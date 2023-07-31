Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB46769AED
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjGaPjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjGaPju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:39:50 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA56AE0;
        Mon, 31 Jul 2023 08:39:49 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VE2WvD024128;
        Mon, 31 Jul 2023 15:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=mqdgDMedgXDsMg8vog/VIYIJoUvfxDyZ66BXl2u6HuQ=;
 b=g0fE7tOx4EndgYJqJ+FBpa4bQFAYy4AUt/FZPB3D8oe3WKxIkSlUxG54/tNGtIfHGxCa
 gms6vbqoZsEMlYXqePPHfWpeRjx2r6uGwbjQmM2ClHEBhjZ2QnKh+znYN07nvCRYVHD4
 kK81eKU1aIPP6lPh8NgPdG3sQWTJjlsPR3/ef3Jn1JiMwcYjOh4HNOVJ9xw6yVVf2iio
 DeJMN9SddbUyacNlDhrTfdrtCUFHyYW+USFHG4tr5LALOXrp4YJ9dirRHTTaww4La1BY
 GneeeHg7h/bwgTsCHL7oaJDj0lRXMFfj3Ctzvfrx98zGoY/BFTRDOAgbGNnX8A8ObOP1 fA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6d8grsgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 15:39:41 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36VFdes9000601
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 15:39:40 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 08:39:40 -0700
Date:   Mon, 31 Jul 2023 08:39:38 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>,
        Alex Elder <elder@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
Subject: Re: [PATCH 2/4] soc: qcom: aoss: Add debugfs interface for sending
 messages
Message-ID: <20230731153938.GF1428172@hu-bjorande-lv.qualcomm.com>
References: <20230731041013.2950307-1-quic_bjorande@quicinc.com>
 <20230731041013.2950307-3-quic_bjorande@quicinc.com>
 <21dfb855-8f44-4a4c-9dba-52eb5ae46b9b@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <21dfb855-8f44-4a4c-9dba-52eb5ae46b9b@lunn.ch>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xdBwbo7bfTmDlyBRAK8Mm44zJddJyOlv
X-Proofpoint-GUID: xdBwbo7bfTmDlyBRAK8Mm44zJddJyOlv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_08,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 priorityscore=1501 clxscore=1011 mlxlogscore=961
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 10:21:31AM +0200, Andrew Lunn wrote:
> On Sun, Jul 30, 2023 at 09:10:11PM -0700, Bjorn Andersson wrote:
> > From: Chris Lew <clew@codeaurora.org>
> > 
> > In addition to the normal runtime commands, the Always On Processor
> > (AOP) provides a number of debug commands which can be used during
> > system debugging for things such as preventing power collapse or placing
> > floor votes for certain resources. Some of these are documented in the
> > Robotics RB5 "Debug AOP ADB" linked below.
> > 
> > Provide a debugfs interface for the developer/tester to send these
> > commands to the AOP.
> 
> This sort of sending arbitrary binary blob commands is not liked,
> since it allow user space closed source drivers. At minimum, please
> provide a file per command, with the kernel marshalling parameters
> into the binary format, and decoding any returned values.
> 

Thanks for your input Andrew, that is a valid concern.

The interface is in debugfs and as such wouldn't be suitable for closed
source drivers, as in the majority of our shipping software debugfs
isn't enabled.

Regards,
Bjorn

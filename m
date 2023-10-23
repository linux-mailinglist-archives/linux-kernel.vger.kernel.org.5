Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF457D431D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 01:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjJWXL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 19:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJWXL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 19:11:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AC7FD;
        Mon, 23 Oct 2023 16:11:25 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NNAxWq028760;
        Mon, 23 Oct 2023 23:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=+ggcstRBUlOxqI1C8WEvKLN88XC31ynI06bBPZH6x8o=;
 b=JrtGwX3UqANkRGvDEI937zvUheFhV3tVuX5JrLWlGNz8AbT5q+aR/IqMjT/DKrZFYU2j
 t/u9QIXi6A5rkQQLdprjSVJSDUxaQewI4WMvZ+ln7AGOtesHDhpClDHYvVcI76Ed0xjr
 teNQoZIoy+ms0Q2V66qq9VjkhkOY6Yd4xaoiBWFtg4BsHibG5VXi/cSs9uXoWm0OosUq
 oDWdiQrPdVFtFesaZpBIrOpXIHo9Tuxwg7zniqeNz3CaGJVjfSh71cvs3DQoA/Zq4Vxy
 MynQs6NQ4JUDzkFfmxPkXdr7zfH18kFMKCPNaKjb5Zkdbcpym/8kB8bOVND5BIDACpCy Dw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3twxw5gbev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 23:11:16 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39NNBFTN018082
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 23:11:15 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 23 Oct 2023 16:11:15 -0700
Date:   Mon, 23 Oct 2023 16:11:14 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH RFC 1/2] regulator: core: Disable unused regulators with
 unknown status
Message-ID: <20231023231114.GO3553829@hu-bjorande-lv.qualcomm.com>
References: <20231004-reg-smd-unused-v1-0-5d682493d555@kernkonzept.com>
 <20231004-reg-smd-unused-v1-1-5d682493d555@kernkonzept.com>
 <80307316-f55e-4540-9c5f-655844c3b3f4@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <80307316-f55e-4540-9c5f-655844c3b3f4@sirena.org.uk>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: drb0EoN6pcsxpKnK2EJ5p4HbtYMr4k9W
X-Proofpoint-GUID: drb0EoN6pcsxpKnK2EJ5p4HbtYMr4k9W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_21,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 bulkscore=0 impostorscore=0 phishscore=0
 mlxlogscore=501 priorityscore=1501 suspectscore=0 clxscore=1011
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310230203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 01:09:11PM +0100, Mark Brown wrote:
> On Wed, Oct 04, 2023 at 04:17:17PM +0200, Stephan Gerhold wrote:
> 
> > Instead of -EINVAL we could also use a different return code to indicate
> > the initial status is unknown. Or maybe there is some other option that
> > would be easier? This is working for me but I'm sending it as RFC to get
> > more feedback. :)
> 
> The more normal thing here would be -EBUSY I think - -EINVAL kind of
> indicates that the operation will never work while in reality it could
> possibly work in future.  Though for the RPMH it's not really the case
> that it ever supports readback, what it does is have it's own reference
> counting in the driver.  Rather than doing this we should probably have
> logic in the core which sees that the driver has a write operation but
> no read operation and implements appropriate behaviour.

I like the suggestion to not implement is_enabled, and handle that in
the core instead, for all three generations of our rpm-based regulators.

Regards,
Bjorn

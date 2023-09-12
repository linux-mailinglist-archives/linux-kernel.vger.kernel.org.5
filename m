Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D6E79C17D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjILBOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjILBOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:14:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BDE6FDD1;
        Mon, 11 Sep 2023 18:03:36 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C0KXkH031847;
        Tue, 12 Sep 2023 00:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=b+ZDvkvQfKietDBjdlhgqxs9r2mzT6RnU3pGyGd2BkA=;
 b=XSPS0PTtdcMZxd6ljmCdyxivBX0e0Llbz4hMM1uUnMpq90hn0OTRUTyBkH7/HydYrrMR
 YTF2AgTo5PKj+DF6euX8I6G7AgrmyuaW8NKAGrMMwUxc74XFT4AbY2FuxNl2vxp9VN5c
 msoAWjjKQXZlI3VkQa1SH2FEjUGweATifEvcE8WCBv8XicDrVmKdBNx5GyfBu2HYE1NW
 U6/oISTtd8NH4lq5xcavPb/oA8VDWBlvoAoDFJ34Gp6ZF8uufpX/wv1K+4UKRvX8xEz/
 nwSBYJebtY+chzhxl4AADpDlSnzat6fdpot3CKwZ8bMonFH8v69FJG0ExQwmaR7R9+6u Yg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t29b0gggd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 00:39:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38C0daBH012692
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 00:39:36 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 11 Sep 2023 17:39:24 -0700
Date:   Tue, 12 Sep 2023 06:09:21 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
CC:     Pavan Kondeti <quic_pkondeti@quicinc.com>, <corbet@lwn.net>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <matthias.bgg@gmail.com>,
        <kgene@kernel.org>, <alim.akhtar@samsung.com>,
        <bmasney@redhat.com>, <quic_tsoni@quicinc.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <kernel@quicinc.com>
Subject: Re: [PATCH v5 09/17] pstore/ram: Use dynamic ramoops reserve resource
Message-ID: <d69a1822-0972-419a-ae8b-b6979733a18b@quicinc.com>
References: <1694290578-17733-1-git-send-email-quic_mojha@quicinc.com>
 <1694290578-17733-10-git-send-email-quic_mojha@quicinc.com>
 <20425ace-3ef5-4eaf-8319-999bafa34a07@quicinc.com>
 <35c9d1b1-0f48-b873-d703-c880f3b91422@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <35c9d1b1-0f48-b873-d703-c880f3b91422@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tfU2_hR73glnule_LYZ8-x9Z18vDoumI
X-Proofpoint-ORIG-GUID: tfU2_hR73glnule_LYZ8-x9Z18vDoumI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_19,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=719
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309120003
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 04:21:44PM +0530, Mukesh Ojha wrote:
> 
> 
> On 9/11/2023 11:03 AM, Pavan Kondeti wrote:
> > On Sun, Sep 10, 2023 at 01:46:10AM +0530, Mukesh Ojha wrote:
> > > As dynamic ramoops command line parsing is now added, so
> > > lets add the support in ramoops driver to get the resource
> > > structure and add it during platform device registration.
> > > 
> > > Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> > > ---
> > >   fs/pstore/ram.c | 10 +++++++---
> > >   1 file changed, 7 insertions(+), 3 deletions(-)
> > > 
> > 
> > Documentation/admin-guide/ramoops.rst might need an update as well.
> 
> I have said in the cover-letter under changes in v5, it is open for
> comment and not yet documented it yet.
> 
Sure.

To easy on the reviewers, the under cut portion of a specific patch could be
used to add footer notes like TODO/Testing etc. In this case, I was lazy to 
read the loong cover letter posted in this series ;-)

Thanks,
Pavan

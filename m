Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D167DFD91
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 01:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjKCAiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 20:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjKCAiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 20:38:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A068E;
        Thu,  2 Nov 2023 17:38:15 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2LfG2A031600;
        Fri, 3 Nov 2023 00:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=PKoZbrBdKC6gVqUDvxOdh5KIEkcYsyM6kdJ9ddFOU48=;
 b=ewPG2Llxt+3GzThpcYz7AsCDxKqy/uS6NG8FCqXvOue1OMtMst001+d+0cvm+tAN0BZN
 6YaSy9ZeAOaSTdufe769RrD65zmYHZDdiGKy5aVKuYnfFxEm3KpBlXShCrwHMv847EMT
 AEllA37JSi2V/M+krf66nD0lhh5MrC2/bI/7UAIiNhL1PJI5LS4BMA2s4C2fCQJzqJLh
 nPIK/kV0ICdp7eQRZPGnuUGngesjsp3QnX/qPy3LATZWzbu9E9VL/SlQoTyQAiWqQOqA
 jBIPa+ExikMqisM6B0Gt7+RUl1rA69gbR8Ty1mkyZ6DKtk67Wnk414M/CkZbxYgsCAI0 UA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u47dy1xh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 00:38:11 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A30cAEv007350
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Nov 2023 00:38:10 GMT
Received: from quicinc.com (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 2 Nov
 2023 17:38:07 -0700
Date:   Thu, 2 Nov 2023 17:38:05 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
CC:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>
Subject: Re: [PATCH] firmware: qcom-scm: Support multiple waitq contexts
Message-ID: <ZURA7W5zGWOkkIsY@quicinc.com>
Mail-Followup-To: Jeff Johnson <quic_jjohnson@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com
References: <20231027-multi-wqs-v1-1-d47cd7f3590f@quicinc.com>
 <3f5f42e5-265f-40f1-af38-7057622270d2@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3f5f42e5-265f-40f1-af38-7057622270d2@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NrMFXJsAYGlSbu0dZzI4r6rTempQHNoq
X-Proofpoint-ORIG-GUID: NrMFXJsAYGlSbu0dZzI4r6rTempQHNoq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_10,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=636
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030002
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 27 2023 16:44, Jeff Johnson wrote:
> On 10/27/2023 3:37 PM, Guru Das Srinagesh wrote:
> > Currently, only a single waitqueue context is supported (zero). Firmware
> 
> which firmware?

It's the same combination of hypervisor + ARM Trustzone software mentioned in
the earlier commit 6bf325992236 ("firmware: qcom: scm: Add wait-queue handling
logic").
> 
> > now supports multiple waitqueue contexts, so add support to dynamically
> > create and support as many unique waitqueue contexts as firmware returns
> > to the driver.
> > 
> > This is done by using the idr framework to create a hash table for
> 
> why idr?
> Per https://docs.kernel.org/core-api/idr.html
> "The IDR interface is deprecated; please use the XArray instead."

Will replace idr with xarray in next patchset.

Thank you.

Guru Das.

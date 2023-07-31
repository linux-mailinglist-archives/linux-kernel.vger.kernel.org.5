Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5502C769BAB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbjGaQBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbjGaQBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:01:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C577197;
        Mon, 31 Jul 2023 09:01:13 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VE1VDB012426;
        Mon, 31 Jul 2023 16:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=GcDKsKo8fbevrhIXLWWuXCyr22wPubcrOhkn7U4G2wU=;
 b=Kirwau4+mmmj40StS9ofvIdsSfZNtnNXCWvUjcruVfyStwR+nQLEWk6PE2DuLxTcKkBi
 YjSPjB4YnwwStDT2oDN3Gnp033JIjSvnwW/L2b161QCyO4vtN1LcL6SRgIhT2hYphFUi
 V/iO/EqBAuPy1d0n3QtbAQvxoP8kf2k3Bu1bqDjY2Oekq/lRjxdSmoWe5bHA+G3k2qY4
 PHxcKmg8KVMwWYl91Z7YHynE6zHpMUMLjKS/Xj3fg6+LcHKWN1KTUGZ/0Fx8OAdrAnYZ
 t7rj+21qfZd5k3Ie8t2KIcXraaBDP0rbYAKYVRenhY+e1xNsME44L1zUZsXGLazPR8xc ZA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4ucemhw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 16:01:09 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36VG18IV027420
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 16:01:08 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 09:01:07 -0700
Date:   Mon, 31 Jul 2023 09:01:06 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Chris Lew <quic_clew@quicinc.com>,
        Alex Elder <elder@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
Subject: Re: [PATCH 2/4] soc: qcom: aoss: Add debugfs interface for sending
 messages
Message-ID: <20230731160106.GG1428172@hu-bjorande-lv.qualcomm.com>
References: <20230731041013.2950307-1-quic_bjorande@quicinc.com>
 <20230731041013.2950307-3-quic_bjorande@quicinc.com>
 <93dd0930-8699-9995-c9ac-d361c4c385f1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <93dd0930-8699-9995-c9ac-d361c4c385f1@linaro.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nLjVhk4AKItdu-cZO103CU00SpJcGAhO
X-Proofpoint-ORIG-GUID: nLjVhk4AKItdu-cZO103CU00SpJcGAhO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_08,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=793 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310144
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 10:15:34AM +0200, Konrad Dybcio wrote:
> On 31.07.2023 06:10, Bjorn Andersson wrote:
> > From: Chris Lew <clew@codeaurora.org>
> No QUIC email?
> 

That's the author and s-o-b address of the patch. mailmap will help you
if you want to reach him.

> [...]
> 
> 
> > +static ssize_t qmp_debugfs_write(struct file *file, const char __user *userstr,
> > +				 size_t len, loff_t *pos)
> > +{
> > +	struct qmp *qmp = file->private_data;
> > +	char buf[QMP_MSG_LEN];
> > +	int ret;
> > +
> > +	if (!len || len > QMP_MSG_LEN)
> >=? Otherwise the last char may be overwritten by the NULL termination
> couple lines below
> 

My mind had a '\0' accounted for in len as well, but you're right.

Thanks,
Bjorn

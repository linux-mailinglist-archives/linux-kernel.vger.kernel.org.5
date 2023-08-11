Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2571F779B5E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbjHKXcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjHKXcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:32:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C69FE73;
        Fri, 11 Aug 2023 16:32:41 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BNIJhL013100;
        Fri, 11 Aug 2023 23:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=tVxQT/uo3q79LMp8MH0+J/g9GRf0muzCXMvQGw8c9O4=;
 b=WRM8vP8e1EZWIy22SLl5baTAAcNN8lw5vKPRYHwW4TyzD+6bJ6C0uc1LR9q5BzGW7jiU
 IHJqmbh/DrQ1/QCH86Ip/DBrbGeL+PYKSOSuvA6uCTC39TigIjrc+5Ouw2Mt0ijFRuDd
 jm/mWBayxJ26igS5cqfzJ7WAsQRBAB7bn9IvFyImdcvETFlwdt3K+Yqv8eFU/5ffYNLE
 H72skWGuKYI9uNEx0JSVNaf+QykOQNgbRlgOUd3UJBrQmOgondhQBgR9JUEjb7iMRMLs
 YQFcWzkAdpHtUXDFzEgzuEvF8/47Pj0kjqeicHJT5SK4zUYtJnk+ZCJLwhG9X2BL/FSi CA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sd8yday4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 23:32:31 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37BNWUYW023285
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 23:32:30 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 11 Aug 2023 16:32:30 -0700
Date:   Fri, 11 Aug 2023 16:32:28 -0700
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
Subject: Re: [PATCH v2 2/4] soc: qcom: aoss: Add debugfs interface for
 sending messages
Message-ID: <20230811233228.GT1428172@hu-bjorande-lv.qualcomm.com>
References: <20230811205839.727373-1-quic_bjorande@quicinc.com>
 <20230811205839.727373-3-quic_bjorande@quicinc.com>
 <d212e5a7-e9e5-4297-85fb-030818f7c647@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d212e5a7-e9e5-4297-85fb-030818f7c647@lunn.ch>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uebHvILEP_ieCmYIW2FpH9Tbf_xAkrJj
X-Proofpoint-ORIG-GUID: uebHvILEP_ieCmYIW2FpH9Tbf_xAkrJj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_15,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308110215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 11:01:50PM +0200, Andrew Lunn wrote:
> > +static ssize_t qmp_debugfs_write(struct file *file, const char __user *userstr,
> > +				 size_t len, loff_t *pos)
> > +{
> > +	struct qmp *qmp = file->private_data;
> > +	char buf[QMP_MSG_LEN];
> > +	int ret;
> > +
> > +	if (!len || len >= QMP_MSG_LEN)
> > +		return -EINVAL;
> > +
> > +	if (copy_from_user(buf, userstr, len))
> > +		return -EFAULT;
> > +	buf[len] = '\0';
> > +
> > +	ret = qmp_send(qmp, buf);
> > +	if (ret < 0)
> > +		return ret;
> 
> Sorry, but you still appear to be sending binary blobs from userspace
> to the firmware. This is not liked.
> 

As mentioned in the cover letter, I do recognize your concern here. I
don't see it as a realistic way to work around the kernel for reasons of
being proprietary - given that we don't have debugfs mounted in the vast
majority of product.

I do however recognize the benefit of this interface for fellow upstream
engineers.

> The documentation you pointed to has three commands. Please implement
> three debugfs files, one per command.
> 

The documentation pointed to has 4 classes ("class"), but this is not
the full set, each class has N resources ("res") and each resource has a
varying value space - "off", "mol", "enabled", "disabled", "max" to take
the examples from the documentation, other classes takes integers as
argument. Some classes has a fourth key...

Further more, the list of classes, resources and values varies from
target to target.

We're composing the lists of commands, but I'm not sure that it will be
feasible to spell out all the valid commands, on a per-target basis.
It is just a debug feature, I don't want it to take up a significant
portion of the driver.


The alternative is to continue carrying this as an out-of-tree patch,
the only people suffering from that are the ones working exclusively
in on the upstream kernel.

Regards,
Bjorn

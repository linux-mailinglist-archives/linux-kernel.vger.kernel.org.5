Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B3B7543F2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 22:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbjGNUvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 16:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjGNUvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 16:51:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5522690;
        Fri, 14 Jul 2023 13:51:30 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36EKWbpa025942;
        Fri, 14 Jul 2023 20:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=Byv2b8DHUY8Pg0x3vwdkLZFZAN2z6M/pt/aiIbaK5KM=;
 b=fM7g2OeY5Icx11Oc+PIVB74a4ZoZL4B5JVzChPXhPnMxbHIOX3j8CcUnO5nYYvRWh/Ca
 HACqmRguZNjEFRh41vJhlpG2S7oBSx00n2mzfG3aDGyXHyiuLPeRNuzMap5teggQc4hh
 EQyTj//k+eUvXvKGqucOuM1ZJkIq9qJbcizjkL+t5TsgeKwOdXlIUvZEfMm2X5jSLl+o
 squ1+XcIHsiArOqz/sq1ONdHQnfXshKQ98LblZKqtW/piv9x+NsAQAbWLBNmhXB33RGG
 LJTjTVzSshu6tt6RqaDPfjC+cvA8UAarCRH7cfRfiOO6eC6u7/iRPbraG5obR9BlBCN2 gw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtpujts1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 20:51:25 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36EKpOlD009539
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 20:51:24 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 14 Jul 2023 13:51:24 -0700
Date:   Fri, 14 Jul 2023 13:51:22 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Andrew Halaney <ahalaney@redhat.com>
CC:     Ninad Naik <quic_ninanaik@quicinc.com>, <andersson@kernel.org>,
        <agross@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppareek@quicinc.com>,
        <psodagud@quicinc.com>, <quic_kprasan@quicinc.com>
Subject: Re: [PATCH] pinctrl: qcom: Add intr_target_width to define
 intr_target_bit field width
Message-ID: <20230714205122.GA3975260@hu-bjorande-lv.qualcomm.com>
References: <20230714061010.15817-1-quic_ninanaik@quicinc.com>
 <p5vyji2weclwgshyxbf2evzpzefckzyecjnoada7dvzbuenxsb@55abp36rrbub>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <p5vyji2weclwgshyxbf2evzpzefckzyecjnoada7dvzbuenxsb@55abp36rrbub>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pMaGXtSjkbIe0I8_so-7wedfoB9uCr88
X-Proofpoint-ORIG-GUID: pMaGXtSjkbIe0I8_so-7wedfoB9uCr88
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_10,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307140191
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 01:17:12PM -0500, Andrew Halaney wrote:
> On Fri, Jul 14, 2023 at 11:40:09AM +0530, Ninad Naik wrote:
> > SA8775 and newer target have added support for an increased number of
> > interrupt targets. To implement this change, the intr_target field, which
> > is used to configure the interrupt target in the interrupt configuration
> > register is increased from 3 bits to 4 bits.
> > 
> > In accordance to these updates, a new intr_target_width member is
> > introduced in msm_pingroup structure. This member stores the value of
> > width of intr_target field in the interrupt configuration register. This
> > value is used to dynamically calculate and generate mask for setting the
> > intr_target field. By default, this mask is set to 3 bit wide, to ensure
> > backward compatibility with the older targets.
> > 
> > Signed-off-by: Ninad Naik <quic_ninanaik@quicinc.com>
> 
> Thanks for the patch. Naive question (without really reading the code),
> but what practical affect does this have?
> 
> i.e. does this change behavior of how IRQs were handled before this
> patch vs after on this platform?
> 

Yes, the affected field denotes where interrupts should be routed and
without this patch not all the bits where updated.

> To shed some light on the question, there's a GPIO IRQ for the ethernet
> phy on this platform that is purposely _not_ described because it didn't
> ever trigger, resulting in the interface staying down. Things work
> fine without the IRQ (the driver goes into polling mode).
> The explanation I got was very brief and attributed it to a "hardware issue".
> 
> I'm wondering if I should re-evaluate that, and if this was the
> "hardware issue".
> 

It's plausible that your interrupt fired elsewhere. Definitely worth
giving that scenario another test run.

Regards,
Bjorn

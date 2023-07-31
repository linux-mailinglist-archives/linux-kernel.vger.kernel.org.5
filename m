Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A621776A123
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjGaTW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjGaTWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:22:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B5FE7;
        Mon, 31 Jul 2023 12:22:44 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VIqSMR017918;
        Mon, 31 Jul 2023 19:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=ESgIBhM8PclVUNk0F/NZo2cL3NGm1V+s4RPf/RAUiSY=;
 b=aNY9WktTs6LBTGZ3Vci8QN3vGFyFOq15yC3ut2ACZpXbAJ6Z6Tv4nCzl/pt/6QUTFChs
 kL77vaWunMzriLa4HM0ZnZbT/IvIMFdhGH9et8hDsnVVLqW/Yhgrjwjpcfe9TPbe1y7I
 3to19GOOGMEdUGp3fCKHfZfpHEvqumkiXOkelfy+dnC+q3qee246VYvtiTaD9nF8ot6P
 z8avBt0cNTBttIyjDpUibBmq+0TCVp0edgLfPYfx0a1hivecq0uqg8tv20IJHoKHZCDz
 zVhJwDliRe7WiCormfJhjPNcNPWU8MnfXzyKeGMzIWTdJSgzjsg5WDXAFbUVmbm6Z3AN zA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6j4er3f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 19:22:31 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36VJMVPK002178
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 19:22:31 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 12:22:30 -0700
Date:   Mon, 31 Jul 2023 12:22:29 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Anjelique Melendez <quic_amelende@quicinc.com>, <pavel@ucw.cz>,
        <lee@kernel.org>, <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <luca.weiss@fairphone.com>, <u.kleine-koenig@pengutronix.de>,
        <quic_subbaram@quicinc.com>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] soc: qcom: add QCOM PBS driver
Message-ID: <20230731192229.GH1428172@hu-bjorande-lv.qualcomm.com>
References: <20230725193423.25047-1-quic_amelende@quicinc.com>
 <20230725193423.25047-4-quic_amelende@quicinc.com>
 <de3b4739-5446-c1ab-571f-a36c4aff5e0f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <de3b4739-5446-c1ab-571f-a36c4aff5e0f@linaro.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 87JFBv1-jbwAmph4uY8cNJX3TGlBepgm
X-Proofpoint-ORIG-GUID: 87JFBv1-jbwAmph4uY8cNJX3TGlBepgm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_13,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310175
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 05:36:08PM +0200, Konrad Dybcio wrote:
> On 25.07.2023 21:34, Anjelique Melendez wrote:
> > +struct pbs_dev *get_pbs_client_device(struct device *dev)
> > +{
> > +	struct device_node *pbs_dev_node;
> > +	struct platform_device *pdev;
> > +	struct pbs_dev *pbs;
> > +
> > +	pbs_dev_node = of_parse_phandle(dev->of_node, "qcom,pbs", 0);
> > +	if (!pbs_dev_node) {
> > +		dev_err(dev, "Missing qcom,pbs property\n");
> > +		return ERR_PTR(-ENODEV);
> > +	}
> > +
> > +	pdev = of_find_device_by_node(pbs_dev_node);
> > +	if (!pdev) {
> > +		dev_err(dev, "Unable to find PBS dev_node\n");
> > +		pbs = ERR_PTR(-EPROBE_DEFER);
> > +		goto out;
> > +	}
> > +
> > +	pbs = platform_get_drvdata(pdev);
> > +	if (!pbs) {
> This check seems unnecessary, the PBS driver would have had to fail
> probing if set_drvdata never got called.
> 

That's not necessarily the case, the platform_device will exist before
the probe function has been invoked. So checking this sounds
appropriate.

But if we have a valid link, but no drvdata, perhaps it would be more
appropriate to return -EPROBE_DEFER?

Regards,
Bjorn

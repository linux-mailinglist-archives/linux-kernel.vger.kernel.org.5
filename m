Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26FD7B2D12
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 09:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjI2Hcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 03:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjI2Hcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 03:32:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20DC1A7;
        Fri, 29 Sep 2023 00:32:42 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38T743Sl032337;
        Fri, 29 Sep 2023 07:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=1DN22jsaJg5O2CBt7TjgYJ08jbMjYR7N9ig9ufUnkxQ=;
 b=PiGjT8hfZnyU/ld7IbHtZ4Wg6Dzub1ICHd7S0R8WenDGhjYY9oYps/ovaJRhhFKgmfba
 FM+hwv7CYDaPi3kdQ+ehiv1PDdhYKQZ2v6pqYo9sBy93DbncBk4zjCJuLV11TsLC++9a
 fObWEDj3QrUyzBINfYKanf+bQjrWh3FtvlRNj7NYQGJ1E2CWijzEKtEBYXk29F0vaPs6
 uEJv8rp6E+LjyDvA3zbtn29YghjvmJD7HST6wrpiW4X+gP998i6aGs7WfkATwOvef4UU
 C5sD3PYKRk34VVGn6b5lZFJjtKi36OVvu/srx2NwlzdUnX8P4OnM0zUrGxEomY2eC/TE 3A== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tctcnkxcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 07:32:28 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38T7WRRe002804
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 07:32:27 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 29 Sep 2023 00:32:21 -0700
Date:   Fri, 29 Sep 2023 13:02:17 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     <ilia.lin@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_kathirav@quicinc.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v1 04/10] clk: qcom: apss-ipq6018: ipq5332: add safe
 source switch for a53pll
Message-ID: <20230929073216.GB15001@varda-linux.qualcomm.com>
References: <cover.1693996662.git.quic_varada@quicinc.com>
 <5e3c29df2b42cceb8072b00546a78e1b99b2d374.1693996662.git.quic_varada@quicinc.com>
 <b0508a69-130d-4b05-9dfc-399e482dc2ae@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b0508a69-130d-4b05-9dfc-399e482dc2ae@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: t8oLmcMdK30vg9q39g9Z7_94n6YfOXsV
X-Proofpoint-ORIG-GUID: t8oLmcMdK30vg9q39g9Z7_94n6YfOXsV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_05,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 10:31:55AM +0200, Konrad Dybcio wrote:
> On 7.09.2023 07:21, Varadarajan Narayanan wrote:
> > Stromer Plus PLL found on IPQ53xx doesn't support dynamic
> > frequency scaling. To achieve the same, we need to park the APPS
> > PLL source to GPLL0, re configure the PLL and then switch the
> > source to APSS_PLL_EARLY.
> >
> > To support this, register a clock notifier to get the PRE_RATE
> > and POST_RATE notification. Change the APSS PLL source to GPLL0
> > when PRE_RATE notification is received, then configure the PLL
> > and then change back the source to APSS_PLL_EARLY.
> >
> > Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >  drivers/clk/qcom/apss-ipq6018.c | 54 ++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 53 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
> > index 4e13a08..ffb6ab5 100644
> > --- a/drivers/clk/qcom/apss-ipq6018.c
> > +++ b/drivers/clk/qcom/apss-ipq6018.c
> > @@ -9,8 +9,11 @@
> >  #include <linux/clk-provider.h>
> >  #include <linux/regmap.h>
> >  #include <linux/module.h>
> > +#include <linux/clk.h>
> > +#include <linux/soc/qcom/smem.h>
> >
> >  #include <dt-bindings/clock/qcom,apss-ipq.h>
> > +#include <dt-bindings/arm/qcom,ids.h>
> >
> >  #include "common.h"
> >  #include "clk-regmap.h"
> > @@ -84,15 +87,64 @@ static const struct qcom_cc_desc apss_ipq6018_desc = {
> >  	.num_clks = ARRAY_SIZE(apss_ipq6018_clks),
> >  };
> >
> > +static int cpu_clk_notifier_fn(struct notifier_block *nb, unsigned long action,
> > +				void *data)
> > +{
> > +	u8 index;
> > +	int err;
> > +
> > +	if (action == PRE_RATE_CHANGE)
> > +		index = P_GPLL0;
> > +	else if (action == POST_RATE_CHANGE)
> > +		index = P_APSS_PLL_EARLY;
> > +	else
> > +		return 0;
> > +
> > +	err = clk_rcg2_mux_closest_ops.set_parent(&apcs_alias0_clk_src.clkr.hw,
> > +						  index);
> Adding a variable for clk_hw within the apcs_alias0 clock would
> make this easier to digest, I think.
>
> And if we wanna be even less error-prone, you can reference the
> ops of this clock in an indirect way.

Will change it as

	struct clk_hw *hw;

	hw = &apcs_alias0_clk_src.clkr.hw;
	err = hw->init->ops->set_parent(hw, index);

> > +	return notifier_from_errno(err);
> > +}
> > +
> > +static struct notifier_block cpu_clk_notifier = {
> > +	.notifier_call = cpu_clk_notifier_fn,
> > +};
> > +
> >  static int apss_ipq6018_probe(struct platform_device *pdev)
> >  {
> >  	struct regmap *regmap;
> > +	u32 soc_id;
> > +	int ret;
> > +
> > +	ret = qcom_smem_get_soc_id(&soc_id);
> > +	if (ret)
> > +		return ret;
> >
> >  	regmap = dev_get_regmap(pdev->dev.parent, NULL);
> >  	if (!regmap)
> >  		return -ENODEV;
> >
> > -	return qcom_cc_really_probe(pdev, &apss_ipq6018_desc, regmap);
> > +	ret = qcom_cc_really_probe(pdev, &apss_ipq6018_desc, regmap);
> > +	if (ret)
> > +		return ret;
> > +
> > +	switch (soc_id) {
> > +	/*
> > +	 * Only below variants of IPQ53xx support scaling
> > +	 */
> 1. /* Keep this in a 1-line comment */

Ok

> 2. why? explain the reasoning in the commit message

Ok

Thanks
Varada

> > +	case QCOM_ID_IPQ5332:
> > +	case QCOM_ID_IPQ5322:
> > +	case QCOM_ID_IPQ5300:
> > +		ret = clk_notifier_register(apcs_alias0_clk_src.clkr.hw.clk,
> > +						&cpu_clk_notifier);
> > +		if (ret)
> > +			return ret;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return 0;
> >  }
> >
> >  static struct platform_driver apss_ipq6018_driver = {

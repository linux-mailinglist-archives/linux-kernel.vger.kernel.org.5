Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D127D086D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 08:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376317AbjJTGYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 02:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346657AbjJTGYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 02:24:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7668FD46;
        Thu, 19 Oct 2023 23:24:39 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39K4ibkH017443;
        Fri, 20 Oct 2023 06:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=kdsmuoB4vo4vbJNxy9hOF477lLkyRu0sUxQ2vkByobk=;
 b=UK0ZFGfE+yST1ZEckDDVAKbIdwfhpX+IpVGOrhqVDSWGdm57ggXdSFn7axIKsH4GdSHv
 vJartB234BunBulJgJuBM8xc80YMMNmaOJvUgaWuVS00fkWX3g5rlBwJbNWWqD5UJbT4
 XBiLvzPlTrGEKm4rr/wYWbNC54kZPC9gZObnq9GoKPwwgy2LNrD3S3WrYSQ/w/dssFtI
 /g9GTP1+koQxF9/fAPvMEQheDnpscMuvDh7Y6gCDHlASnaWrbs/fQTZvngrbqIrihfq5
 ZXzHnlfnu1m9Ckst97cBLqmTS9IYWZ40Z8YaNjSxXp9BPY/nIhudxP3j6N7zRG9TO/H6 FQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tubwmrwsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 06:24:13 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39K6OCsA003997
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 06:24:12 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 19 Oct 2023 23:24:06 -0700
Date:   Fri, 20 Oct 2023 11:54:02 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>,
        <sivaprak@codeaurora.org>, <quic_kathirav@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4 1/9] clk: qcom: config IPQ_APSS_6018 should depend on
 QCOM_SMEM
Message-ID: <20231020062401.GA7240@varda-linux.qualcomm.com>
References: <cover.1697694811.git.quic_varada@quicinc.com>
 <9796f8e752c4de94b0939e4512bc646a5e72fc32.1697694811.git.quic_varada@quicinc.com>
 <CAA8EJprLvQ6Mzo-JLetNDESftRaJGDe46UtWChWx+BQRu1aJQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJprLvQ6Mzo-JLetNDESftRaJGDe46UtWChWx+BQRu1aJQA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kluM01a2KufYbIpLGKfCNrIEWproAlf8
X-Proofpoint-ORIG-GUID: kluM01a2KufYbIpLGKfCNrIEWproAlf8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_04,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310200054
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 04:12:25PM +0300, Dmitry Baryshkov wrote:
> On Thu, 19 Oct 2023 at 11:42, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
> >
> > The config IPQ_APSS_6018 should depend on QCOM_SMEM, to
> > avoid the following error.
>
> Which error?

Sorry. I assumed that it would refer to the info mentioned in the
'Reported-by' & 'Closes' tags.

Have included the error message in the commit log, addressed other
comments and posted v5. Kindly take a look.

Thanks
Varada

> > Fixes: 5e77b4ef1b19 ("clk: qcom: Add ipq6018 apss clock controller")
> > Reported-by: kernel test robot <yujie.liu@intel.com>
> > Closes: https://lore.kernel.org/r/202310181650.g8THtfsm-lkp@intel.com/
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >  drivers/clk/qcom/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> > index 3194c8b..ad1acd9 100644
> > --- a/drivers/clk/qcom/Kconfig
> > +++ b/drivers/clk/qcom/Kconfig
> > @@ -131,6 +131,7 @@ config IPQ_APSS_6018
> >         tristate "IPQ APSS Clock Controller"
> >         select IPQ_APSS_PLL
> >         depends on QCOM_APCS_IPC || COMPILE_TEST
> > +       depends on QCOM_SMEM
> >         help
> >           Support for APSS clock controller on IPQ platforms. The
> >           APSS clock controller manages the Mux and enable block that feeds the
> > --
> > 2.7.4
> >
>
>
> --
> With best wishes
> Dmitry

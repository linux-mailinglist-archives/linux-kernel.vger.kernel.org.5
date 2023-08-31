Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE05378E96B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244832AbjHaJaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 05:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjHaJau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:30:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD6ECDD;
        Thu, 31 Aug 2023 02:30:47 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37V9RNpD015667;
        Thu, 31 Aug 2023 09:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=A4FM5Ir5byOJyGSv8Y9c+sr2exQIrOCrArK40xB6VVw=;
 b=U+peTBDOAHCnOQTXnAp+RlAUV7gSUTuJaU1jMU6lwNNdSyofbQBuJQwCqeAxyKt5ijTb
 K8Ape0KRGxR9uhBSHr913QHkDL3B2iT/l1SsM/hGbBgwFBAiJYIGMFcnFdt4KZcQG5Oa
 HdFD3cJals5wqWOS2MdMG/gt6R4yrmS3ag7mKufeLKq85qQkDN56t428sb4sXrdFz5+C
 SVFUizCxL4kpjkMDVRFgmlq2N5acycyy074MuEpRCEPrTic0V5T3l2XVhJHpc55XYqU2
 iaHnf4P6aEcT5pIQkyagu8FRVRDcbp1Oe0P3HZfa4mjZR4ATEqEBSNieERp8c8ct0JnX qg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3stks5rhb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 09:30:40 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37V9Udcl019356
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 09:30:39 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 31 Aug 2023 02:30:36 -0700
Date:   Thu, 31 Aug 2023 15:00:32 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mturquette@baylibre.com>
Subject: Re: [PATCH] clk: qcom: ipq5332: Drop set rate parent from gpll0
 dependent clocks
Message-ID: <20230831093031.GB29822@varda-linux.qualcomm.com>
References: <1693377310-8540-1-git-send-email-quic_varada@quicinc.com>
 <12a65758db2058322898cc505fcb8cf7.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <12a65758db2058322898cc505fcb8cf7.sboyd@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AXsLcsT7GA5JGzNAc0B5yZabDqrBn9PL
X-Proofpoint-ORIG-GUID: AXsLcsT7GA5JGzNAc0B5yZabDqrBn9PL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_07,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 mlxlogscore=730 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310085
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 04:37:40PM -0700, Stephen Boyd wrote:
> Quoting Varadarajan Narayanan (2023-08-29 23:35:10)
> > IPQ5332's GPLL0's nominal/turbo frequency is 800MHz.
> > This must not be scaled based on the requirement of
> > dependent clocks. Hence remove the CLK_SET_RATE_PARENT
> > flag.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
>
> Any Fixes tag?

Have posted v2 with Fixes tag. Please take a look.

Thanks
Varada

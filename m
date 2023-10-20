Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E337D0A33
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbjJTIEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbjJTIEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:04:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595C1114;
        Fri, 20 Oct 2023 01:04:20 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39K59fDg021735;
        Fri, 20 Oct 2023 08:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=E+vIHWF/VOHbQWF6DKPX7lBOBO/cN3atD6Cyf9pPEZE=;
 b=I4x70mWgsspem5v5hqZK+HgA2c4ihNr4uO8V78xJqGhxmWy9ShLn3/iUKw13w73ajXUu
 5Mh9rs2AYn21hXyT0tAXyPRnXx+enxSb+e7AnN36YqqC9h0aC6qoKUEYRc3ub2Ock4ah
 nEMi/a5zh30gBPzjYvrZm8nvQoNH9kqZC2LdTXfExbQzHJdsvTk9t9Czl0IqE6x/uizC
 xoFhpgLGh8J+OoRnX0x/ZiQs9iIivUIL+grAj+u377BZ4gq8cbpg4yLU/hq0ofIJURmQ
 ZO8icFwdZoysESgZCzvwvKMOUlg6WN1k7per9EqCrV//hePLRDktM+2Gl/1v29eCYUK5 Lg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tubxd1500-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 08:03:50 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39K83n8L027193
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 08:03:49 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 20 Oct 2023 01:03:43 -0700
Date:   Fri, 20 Oct 2023 13:33:39 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <rafael@kernel.org>,
        <ilia.lin@kernel.org>, <sivaprak@codeaurora.org>,
        <quic_kathirav@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v5 0/9] Enable cpufreq for IPQ5332 & IPQ9574
Message-ID: <20231020080339.GA6197@varda-linux.qualcomm.com>
References: <cover.1697781921.git.quic_varada@quicinc.com>
 <20231020070947.cwigtaa2haij56hz@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231020070947.cwigtaa2haij56hz@vireshk-i7>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kl9QQGze8np2GKWYd7S3IcrDapboGmle
X-Proofpoint-ORIG-GUID: kl9QQGze8np2GKWYd7S3IcrDapboGmle
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_06,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 mlxlogscore=594 lowpriorityscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310200066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 12:39:47PM +0530, Viresh Kumar wrote:
> On 20-10-23, 11:49, Varadarajan Narayanan wrote:
> > Varadarajan Narayanan (9):
> >   cpufreq: qti: Enable cpufreq for ipq53xx
> >   cpufreq: qti: Introduce cpufreq for ipq95xx
>
> Can I pick just these two ?

ipq53xx patch is dependent on the previous safe source switching
patch, hence not safe to pick that.

	No -> cpufreq: qti: Enable cpufreq for ipq53xx
	Yes -> cpufreq: qti: Introduce cpufreq for ipq95xx

Thanks
Varada

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B664F7DC70A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343594AbjJaHPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343556AbjJaHPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:15:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2575E6;
        Tue, 31 Oct 2023 00:15:06 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39V5vXEm022977;
        Tue, 31 Oct 2023 07:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=fyoVIufeQ3J9szxJL+AgrsKGMVdQwv+n/oXu3lDKeOc=;
 b=AWnLbQzPccylBfyj2ZJ/ox9RbZISURUy9ustAygx1z5znUUVBWY4/jX+5EJC1XjqXh/u
 eEJOUlcI6INRas4SQWtu2grdZAbdc6X0duGIPshMiDC+MsOqJPaWKqK9ScovleJaIHBg
 xJT7/eA4ql9uJ9r3ydrLVjdiWgIMqnOGCnmKhfgESml+h6HfR8WatMoYvhWQwsmHCPJH
 Avpr/dmA/RcENfX8mp5VU6g7zzS8XvAMhW2ZXBrmx3OpsDTZmHQAil15659WjstMvgSR
 y/aGDNq9u+eVlMr2GJ+Ki2c0hcNdM0LS+2NfCFooTbLzAx6IE1BLBFCC2cttbtYwm1Hf GQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2c4rt74u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 07:14:32 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39V7EVQ1001327
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 07:14:31 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 31 Oct 2023 00:14:26 -0700
Date:   Tue, 31 Oct 2023 12:44:21 +0530
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
Message-ID: <20231031071420.GA17892@varda-linux.qualcomm.com>
References: <cover.1697781921.git.quic_varada@quicinc.com>
 <20231020070947.cwigtaa2haij56hz@vireshk-i7>
 <20231020080339.GA6197@varda-linux.qualcomm.com>
 <20231025062508.vccrmkem45p3fnwe@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231025062508.vccrmkem45p3fnwe@vireshk-i7>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KBUZYiSlMm5uy4l7aOsAet9Ytnt1rwd8
X-Proofpoint-GUID: KBUZYiSlMm5uy4l7aOsAet9Ytnt1rwd8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxlogscore=671
 malwarescore=0 mlxscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310054
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 11:55:08AM +0530, Viresh Kumar wrote:
> On 20-10-23, 13:33, Varadarajan Narayanan wrote:
> > On Fri, Oct 20, 2023 at 12:39:47PM +0530, Viresh Kumar wrote:
> > > On 20-10-23, 11:49, Varadarajan Narayanan wrote:
> > > > Varadarajan Narayanan (9):
> > > >   cpufreq: qti: Enable cpufreq for ipq53xx
> > > >   cpufreq: qti: Introduce cpufreq for ipq95xx
> > >
> > > Can I pick just these two ?
> >
> > ipq53xx patch is dependent on the previous safe source switching
> > patch, hence not safe to pick that.
> >
> > 	No -> cpufreq: qti: Enable cpufreq for ipq53xx
> > 	Yes -> cpufreq: qti: Introduce cpufreq for ipq95xx
>
> The patches don't apply cleanly. Please resend.

Have posted v6 with just these two patches and rebased
to latest top. Please pick that.

Thanks
Varada

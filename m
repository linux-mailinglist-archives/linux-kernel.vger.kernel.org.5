Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9A678B5A4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjH1Qvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjH1Qvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:51:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F7311D;
        Mon, 28 Aug 2023 09:51:31 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SFqH6a024952;
        Mon, 28 Aug 2023 16:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=9PBrR4jk55eipB1X4aqSkySykCN0uMDYG07U4ikjyAM=;
 b=nN/XBuAKQ8eLwATKEkSMeBqYNYuTcgBRacvpQqyCXP3N0t72pp3D0IR4hqljz7LrRfyx
 wncPy6ZKgc7c16wysZdrS+3JWdUUd4mCFcE0DNdzMGcb1ErfoBxFzZ+BSt8cwgeC5K6u
 97DGdmoTfPiGEaRygyTM7a1MSL9LRgf7ZAgPTPHBrkQJm8Z5Wf1LpmSCimBCNPJDNuod
 7/YZMbH8EtQh/j2a65LUwht6W9QNSt1i7/d+RLGyjH5Q7ADdQylLr4Sn3JpSUqLtL2ug
 d3gSEJmLCgmaZ50CB4yHsgH7SOGE6ItHax8Wr2oLZLtJivZrNWVSn+N5bfr9yJF869vS 7w== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sq9m8v729-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 16:51:02 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37SGp1Fg009324
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 16:51:01 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 28 Aug
 2023 09:50:59 -0700
Date:   Mon, 28 Aug 2023 09:50:57 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Jani Nikula <jani.nikula@intel.com>
CC:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <quic_pkondeti@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, <workflows@vger.kernel.org>,
        <tools@linux.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] scripts: Add add-maintainer.py
Message-ID: <20230828165057.GB23466@quicinc.com>
Mail-Followup-To: Jani Nikula <jani.nikula@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quic_pkondeti@quicinc.com, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, workflows@vger.kernel.org,
        tools@linux.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <cover.1693037031.git.quic_gurus@quicinc.com>
 <141b9fcab2208ace3001df4fc10e3dfd42b9f5d9.1693037031.git.quic_gurus@quicinc.com>
 <87jztf37ny.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87jztf37ny.fsf@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VhG6oX1ZF1JTKIw_AvnNzhY7zv28Elfv
X-Proofpoint-GUID: VhG6oX1ZF1JTKIw_AvnNzhY7zv28Elfv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_14,2023-08-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 clxscore=1011 mlxscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=705
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 28 2023 11:14, Jani Nikula wrote:
> On Sat, 26 Aug 2023, Guru Das Srinagesh <quic_gurus@quicinc.com> wrote:
> > This script runs get_maintainer.py on a given patch file (or multiple
> > patch files) and adds its output to the patch file in place with the
> > appropriate email headers "To: " or "Cc: " as the case may be. These new
> > headers are added after the "From: " line in the patch.
> 
> FWIW, I personally prefer tooling to operate on git branches and commits
> than patches. For me, the patches are just an intermediate step in
> getting the commits from my git branch to the mailing list. That's not
> where I add the Cc's, but rather in the commits in my local branch,
> where they're preserved. YMMV.

Could you please share more details about your workflow? Specifically, how you
fit `get_maintainer.pl` in it.

Thank you.

Guru Das.

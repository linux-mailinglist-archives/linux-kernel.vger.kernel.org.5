Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6411B788D88
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 19:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344151AbjHYRBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 13:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjHYRAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 13:00:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5128B10C3;
        Fri, 25 Aug 2023 10:00:37 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PECkBC007918;
        Fri, 25 Aug 2023 17:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=7Ydgg4pJaP0kD/peIFkbYTaUPPhfK1TO7rA2tT1SOeY=;
 b=d45kYWA7bW6ja0UE41uWifh5k8ojFYavxroKfQZSXOMxftRbU9DqkWYLyzfNuQQytH9p
 V/D837m9AeWRQjmJQbFHBFoYR+/3LWrlYYcfYZEF+8tTTvQkv//1bYp8VVYO10Pp+sPC
 f9kO9AaXUALKMVyDVnN4kRo7TAFDTacqetTzkzNb2ua7mgjQ0ucJs0HeLC7g2t9tj88n
 D4sVcf/tA1/ydmI/FbuEym7sSxUOWe0YSNKi6jxCHCsRqop9q68loKljVagUjykaPmmh
 c18uDlGG9JcnJQIIv8mc9t7kOrCpNfPu48CI4mdLsim1PzKUMZXj1qs9/V/SDT8p8IwP mA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3spmm69h4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 17:00:05 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37PH02Bv025880
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 17:00:04 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 25 Aug
 2023 10:00:03 -0700
Date:   Fri, 25 Aug 2023 10:00:01 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Nicolas Schier <nicolas@fjasle.eu>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kees Cook" <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <quic_pkondeti@quicinc.com>, <u.kleine-koenig@pengutronix.de>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: Re: [PATCH v2 1/1] scripts: Add add-maintainer.py
Message-ID: <20230825170001.GB22659@quicinc.com>
Mail-Followup-To: Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quic_pkondeti@quicinc.com, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <cover.1691049436.git.quic_gurus@quicinc.com>
 <829b08342568735095bbd3f8c44f435f44688018.1691049436.git.quic_gurus@quicinc.com>
 <ZOYicEP8D7kNGFin@fjasle.eu>
 <20230824214436.GA22659@quicinc.com>
 <ZOiUOcMOeYvMzq58@bergen.fjasle.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZOiUOcMOeYvMzq58@bergen.fjasle.eu>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fz34qtDuVkPWFCbAnbkWr5SxCT20PqW0
X-Proofpoint-GUID: fz34qtDuVkPWFCbAnbkWr5SxCT20PqW0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_15,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1015 mlxscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=630 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250152
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 25 2023 13:44, Nicolas Schier wrote:
> On Thu 24 Aug 2023 14:44:36 GMT, Guru Das Srinagesh wrote:
> > > While testing, I thought that adding addresses without filtering-out duplicates
> > > was odd; but as git-send-email does the unique filtering, it doesn't matter.
> > 
> > Since I'm using `set()` in this script, the uniqueness is guaranteed here as
> > well - there won't be any duplicates.
> 
> I thought about patch files that already have 'To/Cc' headers (e.g.  
> 'git format-patch --to=... --cc=...' or by running add-maintainer.py 
> multiple times for updating the lists of recipients.  The result is a 
> patch file with possible duplicated lines; but as written: it does 
> matter, effectively.

Sorry, did you mean "does" or "does *not*"?

I'll make sure to test v3 of this script out on patches that have To/Cc already
included and also run it multiple times on the same patch (effectively the same
thing).

Thank you.

Guru Das.

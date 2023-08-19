Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA327816A6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 04:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243822AbjHSCXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 22:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243139AbjHSCXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 22:23:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299494220;
        Fri, 18 Aug 2023 19:23:41 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37J28eG0024117;
        Sat, 19 Aug 2023 02:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=Y7wUdd8mIwuOKvZRM2XNur6MRCReVF+gnC7I6Ti0ydU=;
 b=FcW7Dkx1uBjj/D8zCX0TTPbFRzshQfBVGLQ4a50MITWDh2E9XeDRfAP1WwTQFzOszGx3
 oj1ffnXR0RDFkxecgge44q4VyE4ft0MmjJPsEckKvlnyHVsSdWZimkwj+dZt0ukq4Oi5
 bceHbGxMQCGZZXpslpIWO1iCaoRcCFbozwxJiBP0oihkP7R1Ga8l+HCWHHzAFZrteC2O
 sYKZcNMOwfWtg69LZf2D0mIbT70E/eFsrpdL3KrcPx5s5/IIgC3TPLfwVEQ8h+QObio3
 jNca+HTx1kGe2ounu7qY6Pt9dcClZ7K/wW4vLjGoQgPNSG8bNQhi65RsJqv/JKMbXPbc Zw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3shsd0jvej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Aug 2023 02:23:23 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37J2NMmV010189
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Aug 2023 02:23:22 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 18 Aug
 2023 19:23:21 -0700
Date:   Fri, 18 Aug 2023 19:23:20 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        Kees Cook <keescook@chromium.org>,
        "Bjorn Andersson" <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, Will Deacon <will@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <quic_pkondeti@quicinc.com>, <u.kleine-koenig@pengutronix.de>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        "Guru Das Srinagesh" <quic_gurus@quicinc.com>
Subject: Re: [PATCH v2 0/1] Add add-maintainer.py script
Message-ID: <20230819022320.GC22393@quicinc.com>
Mail-Followup-To: Neil Armstrong <neil.armstrong@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quic_pkondeti@quicinc.com, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <cover.1691049436.git.quic_gurus@quicinc.com>
 <27b8f21c-f705-ba65-5b2e-912fb97a85a9@linaro.org>
 <20230810184939.GA31860@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230810184939.GA31860@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ExLQ3j45KPITeeFstXUGw-qTjWqCZazg
X-Proofpoint-ORIG-GUID: ExLQ3j45KPITeeFstXUGw-qTjWqCZazg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_29,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 adultscore=0 mlxlogscore=559 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308190021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 10 2023 11:49, Guru Das Srinagesh wrote:
> On Aug 03 2023 11:16, Neil Armstrong wrote:
> > Hi,
> > 
> > On 03/08/2023 10:23, Guru Das Srinagesh wrote:
> > >When pushing patches to upstream, the `get_maintainer.pl` script is used to
> > >determine whom to send the patches to. Instead of having to manually process
> > >the output of the script, add a wrapper script to do that for you.
> > >
> > >The add-maintainer.py script adds maintainers (and mailing lists) to a patch,
> > >editing it in-place.
> > 
> > FYI the b4 prep command does this:
> > https://github.com/mricon/b4/blob/e8045d1353165cc065b2f1b180bf1b0846af510e/b4/ez.py#L2055
> > 
> > Perhaps it could be useful to make sure the output is similar ?
> > 
> > So far I've been very satisfied by the output of b4 auto_to_cc.
> 
> Thank you - let me check this tool out.

I gave `b4` a spin and specifically compared the results of `b4 prep
--auto-to-cc` vs this script. I notice from the code that b4 calls
`get_maintainer.pl` with the following flags:

    --nogit --nogit-fallback --nogit-chief-penguins

I can add these to this script too.

And it collects maintainers and lists by passing, respectively, `--nol` and
`--nom` in two separate calls whereas this script parses the actual roles by
making only one call. b4's approach seems cleaner.

The perl script also can provide just the reviewers by passing `--nol --nom`.

b4 and this script both do:

    - Create set-union of all maintainers and all lists from all patches in a
      series.
    - Apply the same addresses to all patches in a series.

The main thing b4 doesn't do (which this script does) is:

    - add only that specific patch's maintainers as "To: ", and
    - the other maintainers from the other patches as "Cc: " 

Overall, b4 seems like a fantastic feature-rich tool for managing and sending
patches.

Thank you for sharing the link to the actual code - it was very instructive.

Guru Das.

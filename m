Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47AC781671
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 03:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243362AbjHSBeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 21:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241952AbjHSBdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 21:33:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDF3272D;
        Fri, 18 Aug 2023 18:33:34 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37J1EFhH000646;
        Sat, 19 Aug 2023 01:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=/nheY/iUEN8kTSous6Kxe+kn4fcnQDy/yMwkoJBqaGU=;
 b=mNBUSeXO/+uoA1vRY0Cl6XsFZSK+2VPLLs71gNoavyDVoyyFgdhlAhG4byTYayjGsHxd
 8RsvlOkD8pt6omTZKXdc8jmxVA/FiAOkic2LFbzrZlXruqm5w53YjW+lY3U5KWznPtV8
 AYe4NKIoFPTCiDuc1XMb6hQ/IYx5w/JsCugGP0IDTzwKUvDwJVBC9FNCpJeNBGd9yIpX
 vx/kmGdLBVXoIkasJXJSivfam6i4IcGqaLkWS9qX9MzPihies2z6GYnxOj9lLV9sq/QK
 7UdXOTKHsuR6tpgv94Wa+K+Exsems2hYr7tNqVAAzdmqsmFXiPP9UHPDcrlQR/KypCo8 Bg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3shsd0ju6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Aug 2023 01:33:07 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37J1X6dd001510
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Aug 2023 01:33:06 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 18 Aug
 2023 18:33:05 -0700
Date:   Fri, 18 Aug 2023 18:33:04 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "Kees Cook" <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <quic_pkondeti@quicinc.com>, <u.kleine-koenig@pengutronix.de>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 0/1] Add add-maintainer.py script
Message-ID: <20230819013303.GA22393@quicinc.com>
Mail-Followup-To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
 <20230810185526.GC31860@quicinc.com>
 <4d94d0fd-72d4-0196-3a30-3e1efb9f5aca@linaro.org>
 <20230816171538.GB26279@quicinc.com>
 <6fb1176f-90f1-7a65-3ab5-f6447418c51e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6fb1176f-90f1-7a65-3ab5-f6447418c51e@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WhmHuQE8I7-E65WCSPveQnCup9-NoBff
X-Proofpoint-ORIG-GUID: WhmHuQE8I7-E65WCSPveQnCup9-NoBff
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_29,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 adultscore=0 mlxlogscore=739 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308190012
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 18 2023 10:43, Krzysztof Kozlowski wrote:
> >> For newcomers, OTOH, I would either recommend simple workflow or just
> >> use b4. Why? Because if you cannot use git-send-email, then it means
> >> your email setup will make your life difficult and adding maintainers to
> >> existing patch won't help you.
> > 
> > You've mentioned a "simple workflow" many times - could you please share more
> > details on the steps you follow in your workflow for sending patches?
> 
> I shared it on LKML few times already (and Rob's git send-email identity
> is also on LKML), so one more time:
> 
> https://github.com/krzk/tools/blob/master/linux/.bash_aliases_linux#L91

Thank you for sharing this - it is really neat indeed and you certainly don't
need a step #2 with this method.

However, I see areas for improvement in the alias:
- Subsystem-specific mailing lists, maintainers, reviewers, and other roles are
  all marked as "To: " sans distinction via the alias whereas
  `add-maintainer.py` and `b4` both provide marking of lists as "Cc: " which
  seems aesthetically and semantically more pleasing.
- Only `add-maintainer.py` allows for maintainers to be selectively in "To: "
  and "Cc: " for patches in a series depending on whether they are the
  maintainers for that particular patch or not.

> >> This tool depends on the command line and shell interface of
> >> scripts/get_maintainers.pl which is another reason why it might not be a
> >> good idea.
> > 
> > Could you please elaborate on why depending on the output of
> > `get_maintainer.pl` is a bad idea? It's what everyone uses, no?
> 
> No, because if interface changes you need to update two tools.

But `b4 prep --auto-to-cc` also uses `get_maintainer.pl`!

Also, in your previous email you said to "just use b4", which also depends on
the command line and shell interface of `get_maintainers.pl`. Depending on
`get_maintainer.pl` is therefore perfectly okay - there is no need to reinvent
it or disregard it for whatever reasons.

Thank you.

Guru Das.

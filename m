Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC1276DAF1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 00:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjHBWr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 18:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjHBWrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 18:47:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2B1211D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 15:47:23 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372KWK16024564;
        Wed, 2 Aug 2023 22:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=o4q2+jILHE2sS/7ABN9AcHCB0XPqWQLtOj2mo/sfduQ=;
 b=SMqYkqNiooKTNVGxr3kAYoMJlN7XDB9Af3b+v2kG9C4GJNSellGgkQPPzSRuYsynHMdW
 MhqWC3zhTVCwp827kbpRhYUWWosMyK9f5NFls4ZwlugNzZ3iLnfHG0EZWUIjWBEOM2up
 v4dbTbk8Sc3Vrf3hyaYS+AOk3ofo5qXqF+lLVPaTWCky+Cn+AHhmAslna8Z3br3zu3cT
 cJP4GVXwaQAymIOfZVUXk+Jo9tw8jiEukgTzAp3Z4FFRz6lH9qe6p4Nqwzt8MOjv6U/5
 XHxdx70gUztYLaVjfZ4CfRB9t9kmsLIJpWW7KQV3WrgixEviqx8HrvImnGoLgo8V/KQ+ 7g== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s7upp0j23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 22:47:01 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 372Ml0tS023663
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 22:47:00 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 2 Aug
 2023 15:46:59 -0700
Date:   Wed, 2 Aug 2023 15:46:58 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        Kees Cook <keescook@chromium.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] scripts: Add add-maintainer.py
Message-ID: <20230802224658.GA17567@quicinc.com>
References: <cover.1690951441.git.quic_gurus@quicinc.com>
 <0d000c48e939beaa97c744c0a8b652396a0b045d.1690951441.git.quic_gurus@quicinc.com>
 <63764b84-3ebd-4081-836f-4863af196228@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63764b84-3ebd-4081-836f-4863af196228@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6bsRaLTgxOlxyrRN1EYuoXZThk_trr0R
X-Proofpoint-ORIG-GUID: 6bsRaLTgxOlxyrRN1EYuoXZThk_trr0R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_18,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=534 bulkscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020201
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 02 2023 15:35, Pavan Kondeti wrote:
> Thanks Guru for submitting this script. In my limited testing, I don't
> find any issues. It works as expected.

Great! Thank you so much for testing this script.

> If I run this script on a series which spans across different lists,
> there is a possiblity that we send partial series to certain lists. What
> is the best way to deal with this? one way is to include union of all
> lists in CC while sending the series with primary maintainer in TO. Can
> the script print those values for easier workflow?

Thanks for bringing this up - I was hoping to start a conversation on this.

Your suggestion seems logical to me. I can update v2 of this script adding an
`-a` flag that will add all maintainers to all patches following the scheme of
gathering the union of all maintainers, lists and "others" separately.

Hoping to get feedback from other maintainers on this point as well. Should I
expand the audience of this patch some more? I addressed this to whomever
`get_maintainer.pl -f ./scripts/` listed, plus Bjorn.

Guru Das.

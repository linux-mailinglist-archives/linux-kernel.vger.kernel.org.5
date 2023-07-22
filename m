Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B48B75DE5E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 21:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjGVTl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 15:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjGVTl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 15:41:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342662707;
        Sat, 22 Jul 2023 12:41:37 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36MJUTwu020067;
        Sat, 22 Jul 2023 19:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lTyqRrAz0M+mSVTdCULJfxi4Kvp6m47KIN1XFC6azao=;
 b=Tulg/cMYBdauh+BmOtTSWVDCXPZaY9nVDjB6ixukET0D/mLLVXAJZDfAVtQXKe0SsV/g
 Eib272VpV2/In7yOGxQKyQZ2LCXClaCiyK+oxTxkgtFMd6Cj6gfbwz/7mYzjbG6f1XQz
 IpQ9oAXzqw6SLnDMLHcWG9pd3xqBh/coGJsOse/OqGMIqGociC29aPSUPuMpayCFdkBs
 iBbyOuywsUk4AYwMltlpa+cme1zYES4WaL321ftlGxk8gBKHYla/xGGh8v7c5PjjDGTp
 +jKHXuiZJhVu2ABPZ3c5v+otttx9QcZdfNbvBnMaO92SsqgGjrxbIFzXJ1xoDFTGDLaE Zg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s064dgw8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Jul 2023 19:40:58 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36MJetTj001500
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Jul 2023 19:40:55 GMT
Received: from [10.110.24.156] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sat, 22 Jul
 2023 12:40:52 -0700
Message-ID: <a19818a4-3457-7362-4deb-b981fdc9ba84@quicinc.com>
Date:   Sat, 22 Jul 2023 12:40:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] scripts/check-uapi.sh: add stgdiff support
Content-Language: en-US
To:     Giuliano Procida <gprocida@google.com>, <quic_johmoo@quicinc.com>
CC:     <masahiroy@kernel.org>, <nathan@kernel.org>,
        <ndesaulniers@google.com>, <nicolas@fjasle.eu>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <rdunlap@infradead.org>, <arnd@arndb.de>, <andersson@kernel.org>,
        <tkjos@google.com>, <maennich@google.com>,
        <kernel-team@android.com>, <libabigail@sourceware.org>,
        <jorcrous@amazon.com>, <quic_satyap@quicinc.com>,
        <quic_eberman@quicinc.com>, <quic_gurus@quicinc.com>
References: <20230407203456.27141-2-quic_johmoo@quicinc.com>
 <20230720161053.1213680-1-gprocida@google.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <20230720161053.1213680-1-gprocida@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: X7PsJVrYMn_-7N-VhobBVNHwA6iB6cqa
X-Proofpoint-ORIG-GUID: X7PsJVrYMn_-7N-VhobBVNHwA6iB6cqa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-22_08,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 phishscore=0 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307220180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/2023 9:10 AM, Giuliano Procida wrote:
> Hi John.
> 
> I spent a few minutes adding stgdiff support to the script. It's
> really just for illustration purposes.
> 
> As I think you know, STG doesn't yet exist as a project outside of
> AOSP. Nevertheless, this may be useful to you as-is.
> 
> STG has quite a different philosophy to libabigil in terms of
> filtering out certain kinds of differences. Some of the things (like
> enum enumerator additions) are not considered harmless. The reasoning
> behind this is basically...
> https://en.wikipedia.org/wiki/Covariance_and_contravariance_(computer_science)
> 
> However, it does have --ignore interface_addition (and the related
> --ignore type_definition_addition) which can be used to detect whether
> one ABI is a subset of another.
> 
> I am looking at adding support for macro definitions (gcc -g3) to STG
> which will then let us cover significantly more of the UAPI surface.
> 
> Unfortunately, there are some headers which use anonymous enums to
> define constants (e.g. and ironically BTF). ABI tracking these types
> would require something a bit hacky. Or we could just name them.

Thank you Giuliano for trying the script w/ stg. We will review the 
modifications below.

Just to update everyone here that John is looking into the libabigail 
changes to reduce the false positives as discussed earlier in the email 
thread. There is some progress on the libabigail mailing list. Once we 
have enough changes made in the libabigail, John will update here with 
his results.

We have also submitted abstract in LPC 2023 Android MC as well about the 
UAPI checker. We hope to make a good progress before LPC.

---Trilok Soni

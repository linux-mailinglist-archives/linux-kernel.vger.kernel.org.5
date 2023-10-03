Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95DB7B63DA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239301AbjJCINX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239290AbjJCINO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:13:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14E43581;
        Tue,  3 Oct 2023 01:11:06 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39388sFc005589;
        Tue, 3 Oct 2023 08:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=5n3qb3b+RTOFdY1QjE2GxrPwNaTfoq/sfZG5D1vc39g=;
 b=ICv1ljB6s5z/V4FB9lKlOgu3FFQEiCeMkfbLXhhWYfHUlLQ4YipXe6BXBBXtbC9EY4EL
 HjpWMtUgUakUnbslHqvn/XsO4BGJD37jrimJ4LrbDPWQ5JmDk86dia5z9OC6V3JJpC0v
 dCnU/dyw3fg0OeEL4xFDbWtu0M8ZgXabxb/zHD3BpJxKdzi06msBtPO2NrmQa/lleweh
 n5XxXhLWlDDK4TEOj6b1JTtTuBDKVeGVAqoBJRF6Ypseb845kC7WV2L0HXunIatl4qsh
 ur9hW0fjNA3P0oopCY+f3qmqKaVak+dUDqyG/nGKPofRynoj5lOaD7E8wUw4//tVzYD9 Bg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tgaw5gfd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 08:09:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39389tKw000532
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Oct 2023 08:09:55 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 3 Oct 2023 01:09:49 -0700
Date:   Tue, 3 Oct 2023 13:39:46 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Nikhil V <quic_nprakash@quicinc.com>
CC:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_kprasan@quicinc.com>, <quic_mpilaniy@quicinc.com>,
        <quic_shrekk@quicinc.com>, <mpleshivenkov@google.com>,
        <ericyin@google.com>
Subject: Re: [RFC PATCH 0/4] PM: hibernate: LZ4 compression support
Message-ID: <d09df865-93b2-4ae8-870d-54fcca2e4d83@quicinc.com>
References: <cover.1695711299.git.quic_nprakash@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1695711299.git.quic_nprakash@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5QWevzHVVa8fa4jX_ruVFYCOq2kxzCxw
X-Proofpoint-GUID: 5QWevzHVVa8fa4jX_ruVFYCOq2kxzCxw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_04,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 priorityscore=1501 clxscore=1011 impostorscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 02:27:10PM +0530, Nikhil V wrote:
> This patch series covers the following:
> 1. Renaming lzo* to generic names, except for lzo_xxx() APIs. This is
> used in the next patch where we move to crypto based APIs for
> compression. There are no functional changes introduced by this
> approach.
> 
> 
> 2. Replace LZO library calls with crypto generic APIs
> 
> Currently for hibernation, LZO is the only compression algorithm
> available and uses the existing LZO library calls. However, there
> is no flexibility to switch to other algorithms which provides better
> results. The main idea is that different compression algorithms have
> different characteristics and hibernation may benefit when it uses
> alternate algorithms.
> 
> By moving to crypto based APIs, it lays a foundation to use other
> compression algorithms for hibernation.
> 
> 
> 3. LZ4 compression
> Extend the support for LZ4 compression to be used with hibernation.
> The main idea is that different compression algorithms
> have different characteristics and hibernation may benefit when it uses
> any of these algorithms: a default algorithm, having higher
> compression rate but is slower(compression/decompression) and a
> secondary algorithm, that is faster(compression/decompression) but has
> lower compression rate.
> 
> LZ4 algorithm has better decompression speeds over LZO. This reduces
> the hibernation image restore time.
> As per test results:
>                                     LZO             LZ4
> Size before Compression(bytes)   682696704       682393600
> Size after Compression(bytes)    146502402       155993547
> Decompression Rate               335.02 MB/s     501.05 MB/s
> Restore time                       4.4s             3.8s
> 
> LZO is the default compression algorithm used for hibernation. Enable
> CONFIG_HIBERNATION_DEF_COMP_LZ4 to set the default compressor as LZ4.
> 
> Compression Benchmarks: https://github.com/lz4/lz4
> 
> 4. Support to select compression algorithm
> 
> Currently the default compression algorithm is selected based on Kconfig.
> Introduce a kernel command line parameter "hib_compression" to
> override this behaviour.
> 
> Users can set "hib_compression" command line parameter to specify
> the algorithm.
> Usage:
>     LZO: hib_compression=lzo
>     LZ4: hib_compression=lz4
> LZO is the default compression algorithm used with hibernation.
> 
> Nikhil V (4):
>   PM: hibernate: Rename lzo* to make it generic
>   PM: hibernate: Move to crypto APIs for LZO compression
>   PM: hibernate: Add support for LZ4 compression for hibernation
>   PM: hibernate: Support to select compression algorithm
> 
>  .../admin-guide/kernel-parameters.txt         |   6 +
>  kernel/power/Kconfig                          |  25 ++-
>  kernel/power/hibernate.c                      |  83 +++++++-
>  kernel/power/power.h                          |  19 ++
>  kernel/power/swap.c                           | 189 +++++++++++-------
>  5 files changed, 248 insertions(+), 74 deletions(-)
> 

I have tested this series on x86 QEMU with v6.6-rc3 (plus another patch
from pm-next tree i.e "PM: hibernate: use __get_safe_page() rather than
touching the list"). It works as advertised.

Thanks,
Pavan

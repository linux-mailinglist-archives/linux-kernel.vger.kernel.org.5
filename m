Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA7D77AFD0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 05:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjHNDAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 23:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjHNDAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 23:00:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0158E6E
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 20:00:15 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37E1LI2J031672;
        Mon, 14 Aug 2023 03:00:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=kpoHseV1ZR3Ms5Z9Bz6xSvtbp8MV4AHxl0LiaxE/mR4=;
 b=SSUtMLLoq8G+EuvkpqtNBD6roqUxoK8G5V28juttvUUZzH64vvOPGBqLS0H21aJ6ElIj
 pKRq0Y8uDmBvn4t1Uy6Btw8VfOl0tfsnttxgP34YlxbuPrS0JyvoablAFUd70MPwO7iG
 UjvNnJZhCvuI8ugi/fVPRflrCgL/uNhwkrdVS9gAXIvwhCHQg5fGJlGafLBcHYDYnPXU
 qoVp8QDW6RgYXBhzCVsSuZ4ThRFSGfma1IYbRhA9FOAB4e52q/JfQyD/1vYjQ+CkJ6dQ
 DCckk8zL8h31S3Q3EJ2NE7qLYRsjakF8f4OZ0hn8Ar15EiwJKpDqXJvO+u+umam8bSdK 4A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se40rjkfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 03:00:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37E309iF007388
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 03:00:09 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 13 Aug 2023 20:00:07 -0700
Date:   Mon, 14 Aug 2023 08:30:04 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Bibek Kumar Patro <quic_bibekkum@quicinc.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_charante@quicinc.com>
Subject: Re: [PATCH v2] cma: introduce CMA_ALLOC_DEBUG config
Message-ID: <c576a86e-7df0-410e-bcdd-b7831727475d@quicinc.com>
References: <20230809131640.18791-1-quic_bibekkum@quicinc.com>
 <20230810095451.cada824810441ecc955e2b2e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230810095451.cada824810441ecc955e2b2e@linux-foundation.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rHaV6EuOXoy21C-vIpfwVtzZmLSC4kFq
X-Proofpoint-GUID: rHaV6EuOXoy21C-vIpfwVtzZmLSC4kFq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-13_24,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 mlxlogscore=919 suspectscore=0 clxscore=1011 adultscore=0 mlxscore=0
 phishscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140026
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bibek,

On Thu, Aug 10, 2023 at 09:54:51AM -0700, Andrew Morton wrote:
> On Wed, 9 Aug 2023 18:46:40 +0530 Bibek Kumar Patro <quic_bibekkum@quicinc.com> wrote:
> 
> > Currently enabling CONFIG_CMA_DEBUG enables DEBUG preprocessor macro.
> > If DEBUG is defined, it's equivalent to a printk with KERN_DEBUG loglevel
> > flooding the dmesg buffer with pr_debug prints from mm/cma driver and from
> > included files as well. This results in excessive amount of CMA logging and
> > also might distract the debug teams with unrelated KERN_DEBUG prints.One of
> > the ways engineers currently tackle this problem is by passing loglevel=N
> > though commandline to suppress KERN_DEBUG messages. This approach can
> > sometimes become tiresome due to its repetitive nature.
> > This patch proposes an alternative approach by introducing a simple new
> > config CONFIG_CMA_ALLOC_DEBUG which only shows the cma bit allocation
> > status in case of cma failure and do not enable DEBUG preprocessor macro
> > from CONFIG_CMA_DEBUG avoiding excessive CMA logging from pr_debug.
> > Engineers and tech teams seeking only for bitmap status in case of cma
> > failure can use this simple config instead of worrying about changing
> > the loglevel or trying other similar workarounds.
> 
> Would it be better to control this at runtime?  With a /proc or /sys tunable?

IIUC, Andrew is asking/suggesting that would a runtime knob be useful
here?

For ex:

/proc/sys/vm/cma_dump_on_failure : This needs to be registerd in the
cma.c . grep for "register_sysctl_init" in mm code. We can set this to
true by default in case CMA_DEBUG is enabled so that current users are
not affected.

/sys/kernel/mm/cma/bitmap_dump_on_failure : This needs to stay in
cma_sysfs.c code

Thanks,
Pavan



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9BA78A4C6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 05:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjH1DSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 23:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjH1DSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 23:18:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8301D11D
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 20:18:34 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37S1xDSi003685;
        Mon, 28 Aug 2023 03:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=QdtGBDjslaHljY4LOmpeC+l3UeDvNVbpOeTZzL5o8SM=;
 b=IcSeXWtfOKJs9bbD5M9lZ7r1p1ssaD3HvfEtr/QjTKnzOTKYox39aAnO40X/Dioyw/ro
 R4cJNtaa7I0HMmcAlYxPA9KowwdUUvdDQ86FvdKvq0R599dKYPFHG9Jz86ZO3FVV1y8a
 51WwalLID7XgFKeMLg3dTohSvL+3gvzFZuwAy+4VkmNl/vn+9sydVHZXwWQFycmZB3+3
 aQj/sXuYOG+Vztx8jDNtO4R5Ac0zXyQBDBaT9qpgwc3ze2F7+3FlpsG4FhIRkWaSKH6l
 YBMXHPvLRjwNcd0CEoj8KyTTbZ1BsYESZdVTDCqpOS2iETOjnAW7mbVm/hKiWu5SSuM8 0Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sq6ruanah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 03:18:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37S3ITZG021103
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 03:18:29 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sun, 27 Aug 2023 20:18:26 -0700
Date:   Mon, 28 Aug 2023 08:48:23 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Bibek Kumar Patro <quic_bibekkum@quicinc.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        <quic_charante@quicinc.com>
Subject: Re: [PATCH v2] cma: introduce CMA_ALLOC_DEBUG config
Message-ID: <5df81e82-a4b9-42b8-92ce-daa194016740@quicinc.com>
References: <20230809131640.18791-1-quic_bibekkum@quicinc.com>
 <20230810095451.cada824810441ecc955e2b2e@linux-foundation.org>
 <c576a86e-7df0-410e-bcdd-b7831727475d@quicinc.com>
 <9ab7df09-e128-4940-ace5-0cc5ffa1ec4d@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9ab7df09-e128-4940-ace5-0cc5ffa1ec4d@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eDfNco2hcny-TE3HV9pnFymj0nJX_cwD
X-Proofpoint-GUID: eDfNco2hcny-TE3HV9pnFymj0nJX_cwD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-27_22,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 mlxlogscore=931 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308280029
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 06:38:13PM +0530, Bibek Kumar Patro wrote:
> On 8/14/2023 8:30 AM, Pavan Kondeti wrote:
> > Bibek,
> > 
> > On Thu, Aug 10, 2023 at 09:54:51AM -0700, Andrew Morton wrote:
> > > On Wed, 9 Aug 2023 18:46:40 +0530 Bibek Kumar Patro <quic_bibekkum@quicinc.com> wrote:
> > > 
> > > > Currently enabling CONFIG_CMA_DEBUG enables DEBUG preprocessor macro.
> > > > If DEBUG is defined, it's equivalent to a printk with KERN_DEBUG loglevel
> > > > flooding the dmesg buffer with pr_debug prints from mm/cma driver and from
> > > > included files as well. This results in excessive amount of CMA logging and
> > > > also might distract the debug teams with unrelated KERN_DEBUG prints.One of
> > > > the ways engineers currently tackle this problem is by passing loglevel=N
> > > > though commandline to suppress KERN_DEBUG messages. This approach can
> > > > sometimes become tiresome due to its repetitive nature.
> > > > This patch proposes an alternative approach by introducing a simple new
> > > > config CONFIG_CMA_ALLOC_DEBUG which only shows the cma bit allocation
> > > > status in case of cma failure and do not enable DEBUG preprocessor macro
> > > > from CONFIG_CMA_DEBUG avoiding excessive CMA logging from pr_debug.
> > > > Engineers and tech teams seeking only for bitmap status in case of cma
> > > > failure can use this simple config instead of worrying about changing
> > > > the loglevel or trying other similar workarounds.
> > > 
> > > Would it be better to control this at runtime?  With a /proc or /sys tunable?
> > 
> 
> Thanks Andrew for suggestion and Pavan for the details, tunable approach
> looks viable too since we get to control this during runtime, but had
> one query in mind where your inputs would help. In case any engineer wishes
> to check boot time CMA failures, would it be easier to use a
> CONFIG or /proc , /sys tunable?
> (Assuming for /proc or /sys tunable, one has to modify the
> init/post_boot scripts to mount the fs and set the tunable to true )
> 

Good point about on how to enable this during boot. A sysctl knob is
good here since it can be turned on/off via kernel commandline. This
means, you don't need to modify the kernel image and wait for the
userspace to come up. See
Documentation/admin-guide/kernel-parameters.txt (grep for sysctl) for
more details.

Thanks,
Pavan

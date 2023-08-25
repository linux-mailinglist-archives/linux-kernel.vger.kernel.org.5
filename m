Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AF2788815
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244922AbjHYNJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242886AbjHYNJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:09:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922D4198A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 06:09:04 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PCeNOp019270;
        Fri, 25 Aug 2023 13:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cwouXUzDVAXE+Y59+Ft45l5xh4x2UQkftIjvqRmh1+I=;
 b=K3UoJeofuUcz39fRSiHM57vDMcqDHq8J8n2XdNE++bcQ+iO/7qAyzNpyN4XgxlRnn2qK
 l+WSwzfIlEeU9chZcDpJJ03mcOAnHwiJBuw5W+FU9812k9TETTcJnGPad8O6j2MbDiBE
 smtgFAPZd2E6LkeMbot3DD13FkQ1TJBS35IsE+k9Q+64Khkp0FKvNlVuSiXxVVoguIM6
 xqEBz5GHqYryXul0rEenDnTVpi5Njj426ScEz/HaH0IEduxk9tJDkjzL4pN48aZYyni2
 vcmIqNfoVdQGWAt/n3V8qpwbkxthpHmpwc3pzsRcfQVxjv7fimihk8EO7h2FaX+GqlLc kw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3spmn38xds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 13:08:58 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37PD8MXO027216
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 13:08:22 GMT
Received: from [10.214.66.253] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 25 Aug
 2023 06:08:20 -0700
Message-ID: <9ab7df09-e128-4940-ace5-0cc5ffa1ec4d@quicinc.com>
Date:   Fri, 25 Aug 2023 18:38:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cma: introduce CMA_ALLOC_DEBUG config
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        <quic_charante@quicinc.com>
References: <20230809131640.18791-1-quic_bibekkum@quicinc.com>
 <20230810095451.cada824810441ecc955e2b2e@linux-foundation.org>
 <c576a86e-7df0-410e-bcdd-b7831727475d@quicinc.com>
From:   Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <c576a86e-7df0-410e-bcdd-b7831727475d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FhtS749M2VOErv0kSOfkotJpLQuIrwiE
X-Proofpoint-GUID: FhtS749M2VOErv0kSOfkotJpLQuIrwiE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_10,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250116
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/2023 8:30 AM, Pavan Kondeti wrote:
> Bibek,
> 
> On Thu, Aug 10, 2023 at 09:54:51AM -0700, Andrew Morton wrote:
>> On Wed, 9 Aug 2023 18:46:40 +0530 Bibek Kumar Patro <quic_bibekkum@quicinc.com> wrote:
>>
>>> Currently enabling CONFIG_CMA_DEBUG enables DEBUG preprocessor macro.
>>> If DEBUG is defined, it's equivalent to a printk with KERN_DEBUG loglevel
>>> flooding the dmesg buffer with pr_debug prints from mm/cma driver and from
>>> included files as well. This results in excessive amount of CMA logging and
>>> also might distract the debug teams with unrelated KERN_DEBUG prints.One of
>>> the ways engineers currently tackle this problem is by passing loglevel=N
>>> though commandline to suppress KERN_DEBUG messages. This approach can
>>> sometimes become tiresome due to its repetitive nature.
>>> This patch proposes an alternative approach by introducing a simple new
>>> config CONFIG_CMA_ALLOC_DEBUG which only shows the cma bit allocation
>>> status in case of cma failure and do not enable DEBUG preprocessor macro
>>> from CONFIG_CMA_DEBUG avoiding excessive CMA logging from pr_debug.
>>> Engineers and tech teams seeking only for bitmap status in case of cma
>>> failure can use this simple config instead of worrying about changing
>>> the loglevel or trying other similar workarounds.
>>
>> Would it be better to control this at runtime?  With a /proc or /sys tunable?
> 

Thanks Andrew for suggestion and Pavan for the details, tunable approach
looks viable too since we get to control this during runtime, but had
one query in mind where your inputs would help. In case any engineer 
wishes to check boot time CMA failures, would it be easier to use a
CONFIG or /proc , /sys tunable?
(Assuming for /proc or /sys tunable, one has to modify the
init/post_boot scripts to mount the fs and set the tunable to true )

> IIUC, Andrew is asking/suggesting that would a runtime knob be useful
> here?
> 
> For ex:
> 
> /proc/sys/vm/cma_dump_on_failure : This needs to be registerd in the
> cma.c . grep for "register_sysctl_init" in mm code. We can set this to
> true by default in case CMA_DEBUG is enabled so that current users are
> not affected.
> 
> /sys/kernel/mm/cma/bitmap_dump_on_failure : This needs to stay in
> cma_sysfs.c code
> 
> Thanks,
> Pavan
> 
> 

Thanks,
Bibek

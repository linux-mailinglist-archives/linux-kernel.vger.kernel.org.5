Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D647787AF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 08:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjHKGy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 02:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjHKGy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 02:54:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA362127
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 23:54:56 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37B3uiP0000780;
        Fri, 11 Aug 2023 06:54:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LRIRVABkXAVxZmaAaZfUWt+U4vRxzVNLCPyv4TTJSmA=;
 b=Mn/Dgp2ILVSNdWnlpibV3MzCuLQdnoTZQdNSRYaSpNGdQWm7lhgxlcsNsWzT+w8M0lHs
 N6+vRTFir3dQcEJkXuo+ckjXMDgwWhkzLd0yB4g06AdheB2lEtA1xcP6PWg8CTTsJ2Dz
 GNelu9PPf3Dq0voqVPKO4Wpf4oSRrPB6heid+3IhT9toJCuk2LbjOuRWq2UhNzD02A7j
 99B15RJVoQmn42kZmYbW6EgrNsydI/mE9ki7K2bb8ojPQ0xNLmlRq1XTAXtsMVSEpCBM
 xhJdYS6qR1YMS7HFxdLSNiaEoRRyBtADbGjJwyPFWyD3u8/nLkgKKoG3nkJwsYX+2Abn ig== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sd9030rvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 06:54:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37B6snQU032245
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 06:54:50 GMT
Received: from [10.214.227.50] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 10 Aug
 2023 23:54:32 -0700
Message-ID: <77045024-cf1d-472a-9cf5-5b492a4a0e02@quicinc.com>
Date:   Fri, 11 Aug 2023 12:24:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cma: introduce CMA_ALLOC_DEBUG config
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_charante@quicinc.com>
References: <20230809131640.18791-1-quic_bibekkum@quicinc.com>
 <20230810095451.cada824810441ecc955e2b2e@linux-foundation.org>
From:   Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <20230810095451.cada824810441ecc955e2b2e@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TK5bbxsSwLNxu7V9ysnoX50iuu0XjZLY
X-Proofpoint-GUID: TK5bbxsSwLNxu7V9ysnoX50iuu0XjZLY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_20,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=899 adultscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/2023 10:24 PM, Andrew Morton wrote:
> On Wed, 9 Aug 2023 18:46:40 +0530 Bibek Kumar Patro <quic_bibekkum@quicinc.com> wrote:
> 
>> Currently enabling CONFIG_CMA_DEBUG enables DEBUG preprocessor macro.
>> If DEBUG is defined, it's equivalent to a printk with KERN_DEBUG loglevel
>> flooding the dmesg buffer with pr_debug prints from mm/cma driver and from
>> included files as well. This results in excessive amount of CMA logging and
>> also might distract the debug teams with unrelated KERN_DEBUG prints.One of
>> the ways engineers currently tackle this problem is by passing loglevel=N
>> though commandline to suppress KERN_DEBUG messages. This approach can
>> sometimes become tiresome due to its repetitive nature.
>> This patch proposes an alternative approach by introducing a simple new
>> config CONFIG_CMA_ALLOC_DEBUG which only shows the cma bit allocation
>> status in case of cma failure and do not enable DEBUG preprocessor macro
>> from CONFIG_CMA_DEBUG avoiding excessive CMA logging from pr_debug.
>> Engineers and tech teams seeking only for bitmap status in case of cma
>> failure can use this simple config instead of worrying about changing
>> the loglevel or trying other similar workarounds.
> 
> Would it be better to control this at runtime?  With a /proc or /sys tunable?

Currently it's being controlled at runtime by changing the 
/proc/sys/kernel/printk tunable or through loglevel value in cmdline but 
issue faced by engineers in both these approach is these tunable value 
would reset every time on reboot and won't retain the set value. So 
these approaches are being used as workarounds only as of now.
Also another issue with the earlier CMA_DEBUG config is the text code 
size might increase (It might be minuscule sometimes but will happen) 
due to all pr_debug in the code.


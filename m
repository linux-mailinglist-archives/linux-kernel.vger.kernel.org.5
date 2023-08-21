Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D502178232A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 07:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjHUF11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 01:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjHUF10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 01:27:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF52A3;
        Sun, 20 Aug 2023 22:27:24 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37L3KoRn018641;
        Mon, 21 Aug 2023 05:27:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yjumNJXyqfOlB+UO6Ta2QA1Ouh8k+27uo0RUWIkZHRs=;
 b=a6rwGgT0ZJ4YZB2Fb+aw8/SwiHITAgmGTSDUidKBDNqVLCfKso3jni/jd54dp75t57G5
 TCD48RFmFTbd/XKwqqWCec//ITIa4nfm/5/YxNuYCuIux5Jm9vFBOYkmdImwivXoNUa0
 PoQfQEJpqe8xWT4Z73QKBS4QPD9mcjJG/lI6zSquP6phvb/D39H4a/wTorchyKW0mF8E
 ihSaT2NQeXTtA/L8VlGc8TdH6b2dt74ZlFKWwJZ60h2WJDbrFUyITCAR3FgvFzdhb60N
 OABMGWs9isZXQ+NC4cdtVPGuPdDYK116yzWCMS2MRpncL769aqjdt0+++UL2c58a+4PW ow== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sjpwwju7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 05:27:10 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37L5R9kl024030
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 05:27:09 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 20 Aug
 2023 22:27:07 -0700
Message-ID: <1ce7a14b-b21e-4e6d-2773-7505c5f17c37@quicinc.com>
Date:   Mon, 21 Aug 2023 10:57:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: linux-next: build failure after merge of the nvmem tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230815202508.0523ecce@canb.auug.org.au>
 <20230821094845.440c96b2@canb.auug.org.au>
Content-Language: en-US
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <20230821094845.440c96b2@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: opOFfhgt4wENtkgT7SoFmd0pAz5_6hXt
X-Proofpoint-ORIG-GUID: opOFfhgt4wENtkgT7SoFmd0pAz5_6hXt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-20_15,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1011
 bulkscore=0 mlxlogscore=777 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308210050
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/2023 5:18 AM, Stephen Rothwell wrote:
> Hi all,
>
> On Tue, 15 Aug 2023 20:25:08 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> After merging the nvmem tree, today's linux-next build (x86_64
>> allmodconfig) failed like this:
>>
>> drivers/nvmem/sec-qfprom.c: In function 'sec_qfprom_probe':
>> drivers/nvmem/sec-qfprom.c:59:13: error: unused variable 'ret' [-Werror=unused-variable]
>>     59 |         int ret;
>>        |             ^~~
>> cc1: all warnings being treated as errors
>>
>> Caused by commit
>>
>>    9c7f2bce8a0e ("nvmem: sec-qfprom: Add Qualcomm secure QFPROM support")
>>
>> I have used the nvmem tree from next-20230809 for today.
> Ping?
>

Hi Stephen,
Had already submitted a change for this -
https://lore.kernel.org/all/20230816130057.28717-1-quic_kbajaj@quicinc.com/

Thanks
Komal

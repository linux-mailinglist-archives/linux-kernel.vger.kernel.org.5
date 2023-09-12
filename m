Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145CF79CC43
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjILJrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjILJrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:47:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C3B12E;
        Tue, 12 Sep 2023 02:47:09 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C98utC000883;
        Tue, 12 Sep 2023 09:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=iBud7bDwgB/NkAvNOZ5XH0nzWWSfAmK24B93zv8Y0zg=;
 b=QdsGspPnJ/v9W1U1h5QbW8T9QcK8JFtFNHI5XMrahMxozMOmJcJ76YlKX2YmNmOxz5tg
 QJB2R9Mx4LIFCB5Tk2gYi8AIo9VJdJUES9Ss12CVKt+TbM2wkCd8JAZJhGj0mUwSScBu
 KFDOupZ9DdwJZ9EGVmDfFSJ380dMFQmpPTAy/CnzjvM5juqT8ZuYD6n/YtO33skUccaV
 y3s0pD1CJGkNe5oOeN8Wk4kiSH2qGsV6EwnoSHBdFp+q7TUnB0a2oFssPzv+Mo9XWzcK
 zB0y/94i4a1a4ymHBuJnxxjtI+IG3N/I2wyBKbHqCsGAs988LdMwg9GdmUKFIaTz1R54 jw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t20yy2pbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 09:46:43 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38C9kg95025681
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 09:46:42 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 12 Sep
 2023 02:46:23 -0700
Message-ID: <78509d6a-e721-2395-b5f6-321227e76556@quicinc.com>
Date:   Tue, 12 Sep 2023 15:16:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 09/17] pstore/ram: Use dynamic ramoops reserve resource
Content-Language: en-US
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <matthias.bgg@gmail.com>,
        <kgene@kernel.org>, <alim.akhtar@samsung.com>,
        <bmasney@redhat.com>, <quic_tsoni@quicinc.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <kernel@quicinc.com>
References: <1694290578-17733-1-git-send-email-quic_mojha@quicinc.com>
 <1694290578-17733-10-git-send-email-quic_mojha@quicinc.com>
 <20425ace-3ef5-4eaf-8319-999bafa34a07@quicinc.com>
 <35c9d1b1-0f48-b873-d703-c880f3b91422@quicinc.com>
 <d69a1822-0972-419a-ae8b-b6979733a18b@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <d69a1822-0972-419a-ae8b-b6979733a18b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KKdfHQi5R8bi5R4sr-NcU0C0Fz2dstUE
X-Proofpoint-GUID: KKdfHQi5R8bi5R4sr-NcU0C0Fz2dstUE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_07,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxscore=0 mlxlogscore=841 bulkscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309120081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/2023 6:09 AM, Pavan Kondeti wrote:
> On Mon, Sep 11, 2023 at 04:21:44PM +0530, Mukesh Ojha wrote:
>>
>>
>> On 9/11/2023 11:03 AM, Pavan Kondeti wrote:
>>> On Sun, Sep 10, 2023 at 01:46:10AM +0530, Mukesh Ojha wrote:
>>>> As dynamic ramoops command line parsing is now added, so
>>>> lets add the support in ramoops driver to get the resource
>>>> structure and add it during platform device registration.
>>>>
>>>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>>> ---
>>>>    fs/pstore/ram.c | 10 +++++++---
>>>>    1 file changed, 7 insertions(+), 3 deletions(-)
>>>>
>>>
>>> Documentation/admin-guide/ramoops.rst might need an update as well.
>>
>> I have said in the cover-letter under changes in v5, it is open for
>> comment and not yet documented it yet.
>>
> Sure.
> 
> To easy on the reviewers, the under cut portion of a specific patch could be
> used to add footer notes like TODO/Testing etc. In this case, I was lazy to
> read the loong cover letter posted in this series ;-)

I have seen it, will comment related to particular patch under --- .
Thanks for suggestion.

-Mukesh

> 
> Thanks,
> Pavan

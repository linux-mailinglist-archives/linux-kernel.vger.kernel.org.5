Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075247F0A6C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 03:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjKTCBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 21:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjKTCBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 21:01:24 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4478E136;
        Sun, 19 Nov 2023 18:01:20 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK1euYn013633;
        Mon, 20 Nov 2023 02:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jovKGGjPM9h2UjswPH46XZgSaqKmCLFkmO95bIWrsdU=;
 b=SNNCIFmK72sOnyR+tRJALjMLsAb0pJElUcIzDMBZRxPihrfdpLWHrgmSdstJRQ+oWZQ9
 uaHYTfAx5oxvfCNAnJGTMh65Gb4fuV6zFiFUerV+YN8DvpHgdDzKTIentuIKwcIojNF0
 bEhk6GHkDEmgoHK2J2Q/J4xTU/XUaakG5FpGg7ZGWHc7Er9sL+shJQrfO1JI0QiiUsia
 WRs2742nMh4OLb5fZ8qQ9FMR55oc7i41DLdjqNaIoQOPRkls8kNgiGMPeqDacdMjZtpB
 FBCikPB+2/E1QAzvX97+a1MR7zKjCxo94QxxK6mtDe6YFEOHko1gDfnKTOq1XZDFp2I+ 1g== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uenneakp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 02:00:50 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AK20nRc017322
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 02:00:49 GMT
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 19 Nov
 2023 18:00:43 -0800
Message-ID: <3fbc49da-99ac-4499-84df-064f3dc429d2@quicinc.com>
Date:   Mon, 20 Nov 2023 10:00:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] ARM: kprobes: Explicitly reserve r7 for local
 variables
To:     Ard Biesheuvel <ardb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
CC:     <linux@armlinux.org.uk>, <mhiramat@kernel.org>,
        <kernel@quicinc.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_lijuang@quicinc.com>, <stable@vger.kernel.org>
References: <20231115095830.20607-1-quic_aiquny@quicinc.com>
 <20231116172418.GA174808@dev-arch.thelio-3990X>
 <CAMj1kXE4stcFikmxBMY19CR4J0+EpaNW8J=xVyFVY3A7F7BpRQ@mail.gmail.com>
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <CAMj1kXE4stcFikmxBMY19CR4J0+EpaNW8J=xVyFVY3A7F7BpRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: j0KCJ4ghVOg7mzkoXZdCrBZaDSakwziG
X-Proofpoint-GUID: j0KCJ4ghVOg7mzkoXZdCrBZaDSakwziG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-19_21,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0
 mlxlogscore=563 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200013
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/2023 1:36 AM, Ard Biesheuvel wrote:
> On Fri, 17 Nov 2023 at 03:24, Nathan Chancellor <nathan@kernel.org> wrote:
>>
>> On Wed, Nov 15, 2023 at 05:58:30PM +0800, Maria Yu wrote:
>>> Registers r7 is removed in clobber list, so compiler may choose r7 for
>>> local variables usage, while r7 will be actually updated by the inline asm
>>> code. This caused the runtime behavior wrong.
>>> While those kind of reserved registers cannot be set to clobber list
>>> because of error like "inline asm clobber list contains reserved
>>> registers".
>>> Explicitly reserve r7 by adding attribute no-omit-frame-pointer for needed
>>> function, then in T32 asm code r7 is used as a frame pointer and is not
>>> available for use as a general-purpose register.
>>> Note that "no-omit-frame-pointer" will make the code size a little bigger
>>> to store the stack frame pointer. So limited to needed functions can have
>>> the less impact than the full source file.
>>>
>>> Fixes: dd12e97f3c72 ("ARM: kprobes: treat R7 as the frame pointer register in Thumb2 builds")
>>> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
>>> Cc: stable@vger.kernel.org
>>
>> This causes warnings with clang:
>>
>>    arch/arm/probes/kprobes/actions-thumb.c:441:47: warning: unknown attribute 'optimize' ignored [-Wunknown-attributes]
>>      441 | static unsigned long __kprobes __attribute__((optimize("no-omit-frame-pointer")))
>>          |                                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/arm/probes/kprobes/actions-thumb.c:524:38: warning: unknown attribute 'optimize' ignored [-Wunknown-attributes]
>>      524 | static void __kprobes __attribute__((optimize("no-omit-frame-pointer")))
>>          |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/arm/probes/kprobes/actions-thumb.c:560:38: warning: unknown attribute 'optimize' ignored [-Wunknown-attributes]
>>      560 | static void __kprobes __attribute__((optimize("no-omit-frame-pointer")))
>>          |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/arm/probes/kprobes/actions-thumb.c:579:38: warning: unknown attribute 'optimize' ignored [-Wunknown-attributes]
>>      579 | static void __kprobes __attribute__((optimize("no-omit-frame-pointer")))
>>          |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    4 warnings generated.
>>
>> Furthermore, as far as I am aware, the optimize attribute has other issues so
>> its use is discouraged, see commits 080b6f407635 ("bpf: Don't rely on GCC
>> __attribute__((optimize)) to disable GCSE") and a7223f5bfcae ("powerpc: Avoid
>> broken GCC __attribute__((optimize))").

Thx for trying this. I was tested with arm-linux-gnueabihf-gcc and not 
notice this.
>>
> 
> Ah yes, apalogies for missing that. I did a test build with Clang but
> I did not spot the errors. So
> 
> Unreviewed-by: ....
> 
> Maria, please use the Makefile based per-file CFLAGS override that I
> suggested before. There is really no reason to make this per-function.
Ok. I will upload a new patchset.

-- 
Thx and BRs,
Aiqun(Maria) Yu


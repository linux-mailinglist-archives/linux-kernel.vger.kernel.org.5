Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCF17D2ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjJWJtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjJWJte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:49:34 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D99DF;
        Mon, 23 Oct 2023 02:49:32 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N7RcDM013265;
        Mon, 23 Oct 2023 09:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uAis2Z2YJ8m6fp9s7ZYGV9g504DoRV6kbL9/qC8m2YI=;
 b=lM23yY2D71+XL49fhDw4F/3Pwr4lXYOJvtHuquXN5hGDqbKn9Hon1otDxLU5i75/FnW2
 NhzbO/cyGqPOGvHK8GaknI06j1OmQCmM1yRBGyj9e5NHEpSjI1yrtToc+QWB/J1gcyfH
 51cWuZ052mN5QGWbmuj/y5dPRcB6BgsJ6aiFipqFKOtbtx0Rof9TJ7dtw9kOtTPix4Wk
 fgLkkOzKb2VqJ37mydwV1aIFvZSLHDow/OgZBgf/39ruiEbThsE57vUg2+uGTk8Ry6P5
 6UIfekXM/aGtuIHttI0UGG5EdWDtF8eNqLgW7Ld63ebINjYf24zvk3nd19FgrdwothWW +w== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv6r2bnm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 09:49:20 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39N9nJCt012461
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 09:49:19 GMT
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 23 Oct
 2023 02:49:14 -0700
Message-ID: <966a8ad0-d79b-7aca-e492-ff27394b3c3c@quicinc.com>
Date:   Mon, 23 Oct 2023 17:49:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] arm64: module: PLT allowed even !RANDOM_BASE
To:     Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>
References: <20231023075714.21672-1-quic_aiquny@quicinc.com>
 <56c2d30b-2f25-4613-aab1-00fccbd2fa05@app.fastmail.com>
 <ZTY2rdkY5FfTBUVL@FVFF77S0Q05N>
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <ZTY2rdkY5FfTBUVL@FVFF77S0Q05N>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KAxWGEJDp-f38L9NxugngdQiJ_pW2bHG
X-Proofpoint-GUID: KAxWGEJDp-f38L9NxugngdQiJ_pW2bHG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_07,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 clxscore=1011 priorityscore=1501 phishscore=0 spamscore=0
 mlxlogscore=348 impostorscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230084
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/2023 5:02 PM, Mark Rutland wrote:
> On Mon, Oct 23, 2023 at 10:08:33AM +0200, Arnd Bergmann wrote:
>> On Mon, Oct 23, 2023, at 09:57, Maria Yu wrote:
>>> Module PLT feature can be enabled even when RANDOM_BASE is disabled.
>>> Break BLT entry counts of relocation types will make module plt entry
>>> allocation fail and finally exec format error for even correct and plt
>>> allocation available modules.
> 
> Has an actual problem been seen in practice, or was this found by looking at
> the code?
I've encounter an actual problem when disalbe CONFIG_RADOM_BASE and the 
kernel module have the exec format error issue.
> 
>>>
>>> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
>>
>> Adding Ard Biesheuvel to Cc, as he added the check in commit
>> a257e02579e42 ("arm64/kernel: don't ban ADRP to work around
>> Cortex-A53 erratum #843419")
Thx for adding Ard. Will keep him in next patchset as well.
> 
> I think that the actual mistake is in commit:
> 
>    3e35d303ab7d22c4 ("arm64: module: rework module VA range selection")
> 
> Prior to that commit, when CONFIG_RANDOMIZE_BASE=n all modules and code had to
> be within 128M of each other, and so there were no PLTs necessary for B/BL.
> After that commit we can have a 2G module range regardless of
> CONFIG_RANDOMIZE_BASE, and PLTs may be necessary for B/BL.
> 
> We should have removed the check for !CONFIG_RANDOMIZE_BASE as part of that.

Agree with you.
> 
>>>   arch/arm64/kernel/module-plts.c | 3 ---
>>>   1 file changed, 3 deletions(-)
>>>
>>> diff --git a/arch/arm64/kernel/module-plts.c
>>> b/arch/arm64/kernel/module-plts.c
>>> index bd69a4e7cd60..21a67d52d7a0 100644
>>> --- a/arch/arm64/kernel/module-plts.c
>>> +++ b/arch/arm64/kernel/module-plts.c
>>> @@ -167,9 +167,6 @@ static unsigned int count_plts(Elf64_Sym *syms,
>>> Elf64_Rela *rela, int num,
>>>   		switch (ELF64_R_TYPE(rela[i].r_info)) {
>>>   		case R_AARCH64_JUMP26:
>>>   		case R_AARCH64_CALL26:
>>> -			if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
>>> -				break;
>>> -
>>>   			/*
>>>   			 * We only have to consider branch targets that resolve
>>>   			 * to symbols that are defined in a different section.
>>
>> I see there are two such checks (in partition_branch_plt_relas()
>> and in count_plts()), can you explain in more detail how you
>> concluded that one of them is correct but the other one is not?
> 
> I believe that the one in partition_branch_plt_relas() needs to go too; that's
> just a minor optimization for the case where there shouldn't be any PLTs for
> B/BL, and it no longer holds after the module VA range rework.
> 
> That was introduced in commit:
> 
>    d4e0340919fb9190 ("arm64/module: Optimize module load time by optimizing PLT counting")
The functionality is the same from my try with plt allocated kernel 
modules. While the PLT entry can be dramatically reduced from ~50000 to 
~500 after fix in partition_branch_plt_relas.

I will send out the second patchset with fix in 
partition_branch_plt_relas (remove check of CONFIG_RANDOMIZE_BASE) 
tomorrow if no more other comments today.
> 
> Thanks,
> Mark.

-- 
Thx and BRs,
Aiqun(Maria) Yu


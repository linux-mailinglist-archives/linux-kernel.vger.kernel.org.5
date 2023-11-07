Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB4E7E3522
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 07:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjKGGQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 01:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjKGGQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 01:16:17 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C92125
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 22:16:14 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A75s4xm001604;
        Tue, 7 Nov 2023 06:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=XTuBFmO7ENXv8sHBkUduRIGztLoZ1LNHpIjdwxgs+qw=;
 b=X4dg6lEjJ653bFnsjU/NvVO5FYdYCxvWYoQ/Uo8Yo7Rae7p63RoBtxK4aCacc4TxXF7i
 Y5mmAej7R0Eb0yt5JuKt+159p4b3sdwaNZjfz3++/qLyMozR+yMWk0KL0/D4KLg28GeO
 jpABOlnRofYOi/yZfeZHJCqidaJ6VP3Nb8BXqJeS05f9i23piLHhKMDPIJCM2iCejDWs
 FnCPFDOnYutD1TCJX7DZR048SGVrkBc7vB0HyKJT+GDFhMwfBKPsJbgGs4mYM1LbFyQ1
 SFW2U5PARPq18heJ/2VA5MeCArE8m6G30wSx7G3/7KMT+R4C9fJ11xithv3hXKMckzdy +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7ewtaesg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 06:15:59 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A75u09w010075;
        Tue, 7 Nov 2023 06:15:58 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7ewtaes9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 06:15:58 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A74fYoq008058;
        Tue, 7 Nov 2023 06:15:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u61skej3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 06:15:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A76FtB861669846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Nov 2023 06:15:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE54620043;
        Tue,  7 Nov 2023 06:15:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68B6420040;
        Tue,  7 Nov 2023 06:15:54 +0000 (GMT)
Received: from [9.109.212.144] (unknown [9.109.212.144])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  7 Nov 2023 06:15:54 +0000 (GMT)
Message-ID: <eb3decba-f76c-476b-97fe-7fdc8c228514@linux.ibm.com>
Date:   Tue, 7 Nov 2023 11:45:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 37/37] powerpc: Support execute-only on all powerpc
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Russell Currey <ruscur@russell.cc>,
        Kees Cook <keescook@chromium.org>
References: <cover.1695659959.git.christophe.leroy@csgroup.eu>
 <4283ea9cbef9ff2fbee468904800e1962bc8fc18.1695659959.git.christophe.leroy@csgroup.eu>
 <874ji4af3a.fsf@linux.ibm.com>
 <efcfb376-5b43-4f35-e1d2-8cfce782ae3d@csgroup.eu>
Content-Language: en-US
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <efcfb376-5b43-4f35-e1d2-8cfce782ae3d@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3yPmJhz10CHejs9z_g7t5_5f2qhKUVHo
X-Proofpoint-ORIG-GUID: 3aJgXd30mbrlM_2urXr1OVsqXMwA156y
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311070049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/23 6:53 PM, Christophe Leroy wrote:
> 
> 
> Le 02/11/2023 à 06:39, Aneesh Kumar K.V a écrit :
>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>
>>> Introduce PAGE_EXECONLY_X macro which provides exec-only rights.
>>> The _X may be seen as redundant with the EXECONLY but it helps
>>> keep consistancy, all macros having the EXEC right have _X.
>>>
>>> And put it next to PAGE_NONE as PAGE_EXECONLY_X is
>>> somehow PAGE_NONE + EXEC just like all other SOMETHING_X are
>>> just SOMETHING + EXEC.
>>>
>>> On book3s/64 PAGE_EXECONLY becomes PAGE_READONLY_X.
>>>
>>> On book3s/64, as PAGE_EXECONLY is only valid for Radix add
>>> VM_READ flag in vm_get_page_prot() for non-Radix.
>>>
>>> And update access_error() so that a non exec fault on a VM_EXEC only
>>> mapping is always invalid, even when the underlying layer don't
>>> always generate a fault for that.
>>>
>>> For 8xx, set PAGE_EXECONLY_X as _PAGE_NA | _PAGE_EXEC.
>>> For others, only set it as just _PAGE_EXEC
>>>
>>> With that change, 8xx, e500 and 44x fully honor execute-only
>>> protection.
>>>
>>> On 40x that is a partial implementation of execute-only. The
>>> implementation won't be complete because once a TLB has been loaded
>>> via the Instruction TLB miss handler, it will be possible to read
>>> the page. But at least it can't be read unless it is executed first.
>>>
>>> On 603 MMU, TLB missed are handled by SW and there are separate
>>> DTLB and ITLB. Execute-only is therefore now supported by not loading
>>> DTLB when read access is not permitted.
>>>
>>> On hash (604) MMU it is more tricky because hash table is common to
>>> load/store and execute. Nevertheless it is still possible to check
>>> whether _PAGE_READ is set before loading hash table for a load/store
>>> access. At least it can't be read unless it is executed first.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>> Cc: Russell Currey <ruscur@russell.cc>
>>> Cc: Kees Cook <keescook@chromium.org>
>>> ---
>>>   arch/powerpc/include/asm/book3s/32/pgtable.h |  2 +-
>>>   arch/powerpc/include/asm/book3s/64/pgtable.h |  4 +---
>>>   arch/powerpc/include/asm/nohash/32/pte-8xx.h |  1 +
>>>   arch/powerpc/include/asm/nohash/pgtable.h    |  2 +-
>>>   arch/powerpc/include/asm/nohash/pte-e500.h   |  1 +
>>>   arch/powerpc/include/asm/pgtable-masks.h     |  2 ++
>>>   arch/powerpc/mm/book3s64/pgtable.c           | 10 ++++------
>>>   arch/powerpc/mm/fault.c                      |  9 +++++----
>>>   arch/powerpc/mm/pgtable.c                    |  4 ++--
>>>   9 files changed, 18 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
>>> index 244621c88510..52971ee30717 100644
>>> --- a/arch/powerpc/include/asm/book3s/32/pgtable.h
>>> +++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
>>> @@ -425,7 +425,7 @@ static inline bool pte_access_permitted(pte_t pte, bool write)
>>>   {
>>>   	/*
>>>   	 * A read-only access is controlled by _PAGE_READ bit.
>>> -	 * We have _PAGE_READ set for WRITE and EXECUTE
>>> +	 * We have _PAGE_READ set for WRITE
>>>   	 */
>>>   	if (!pte_present(pte) || !pte_read(pte))
>>>   		return false;
>>>
>>
>> Should this now be updated to check for EXEC bit ?
> 
> I don't think so based on what I see in arm64: 
> https://elixir.bootlin.com/linux/v6.6/source/arch/arm64/include/asm/pgtable.h#L146
> 

But then there can be a get_user_pages() (FOLL_GET) on an exec only pte right?
if we are going to access the page data(FOLL_PIN), then yes exec only mapping should
fail for that. But if we using it to do struct page manipulation we need pte_access_permitted
to return true for exec only mapping?


-aneesh



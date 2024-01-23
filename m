Return-Path: <linux-kernel+bounces-34745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F95883870C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2831C22A18
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F55CA71;
	Tue, 23 Jan 2024 06:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JiGB6Uqg"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D50017741;
	Tue, 23 Jan 2024 06:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705989635; cv=none; b=W2r/8fEhUFrj5IIg0qkCdCvx+wu13UeV/j+ZcG1DeIrDtzTT5UyNB+iVAuhCGvcq6qQ889UPs0CgrYOh66vwVAmnmjy6GK3n6WRXhs2t7cOw7MDV/48wuEXPaQ7EAPKBm9nyz6HFH1h6GRXOf7YIDwertmpdNWBXgd0R56/nYSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705989635; c=relaxed/simple;
	bh=5hSCJZi++0Sd6LDGc/RMYR0xl0xZ3GeQ2gQnU/IwadE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OY+EWBBrO6B9RQsV4qjgh0Inz7uYS8oVDqowptSM7IRBgwmucqsC9eqkm6KHYIf2wGgh3r1fo0S2zv207+13TZEfWPMj2ShhtaJJIg9zdAq9PqVTP7OHlerjZemqj8N8QgdJfnKNG/v9amxH5jT8TX8rWq++2krO6QO+JCfUjL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JiGB6Uqg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40N5xtfY024780;
	Tue, 23 Jan 2024 05:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=bbrIoepZvXLf6MShb+TMBqKlLRQn1dMUAvxBA25868I=;
 b=JiGB6Uqgh+c8YJKqwFL6yI5v4eB58MLG5WvgVL16Q2MKEoTMO9WpdskZ+Nol7zBHKe9B
 Kxxnv/adZsJXk8DUCtoV7EA9B5q8aLMR9jXdDP4azCUHXh5GOdvNpaU+x63j6GeRNqZE
 12e8qyfweBtzvgHVRoWXioQBK/Tv28i+LDsqVjuQnvyHh+b+2NLDqpVWkg3Sa6ZoQemf
 tSGjaAv346WFkaNQ+hyVSEKTJLVKTuBHA1WDu1FOigzH97YBguU0DsZhimXYkoKMACcz
 pUzxqMhdP3HoWS+jJGMsaF7yDkNVu91kHSVCbTHCrkRIOv/yXwhO3ZPR9qZqRWuT8HI2 Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vt7m7g6a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 05:59:57 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40N5xsHK024722;
	Tue, 23 Jan 2024 05:59:55 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vt7m7g5qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 05:59:55 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40N3t8Fa028239;
	Tue, 23 Jan 2024 05:56:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vru72cu1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 05:56:32 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40N5uU8B3801640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 05:56:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E63620043;
	Tue, 23 Jan 2024 05:56:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1772820040;
	Tue, 23 Jan 2024 05:56:30 +0000 (GMT)
Received: from [9.152.212.51] (unknown [9.152.212.51])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jan 2024 05:56:30 +0000 (GMT)
Message-ID: <ceffdc69-982b-4909-95df-5b6a8a277f20@linux.ibm.com>
Date: Tue, 23 Jan 2024 06:56:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/7] Clean up perf mem
To: kajoljain <kjain@linux.ibm.com>, "Liang, Kan"
 <kan.liang@linux.intel.com>,
        acme@kernel.org, irogers@google.com, peterz@infradead.org,
        mingo@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, john.g.garry@oracle.com, will@kernel.org,
        james.clark@arm.com, mike.leach@linaro.org, leo.yan@linaro.org,
        yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
        ravi.bangoria@amd.com, atrajeev@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20231213195154.1085945-1-kan.liang@linux.intel.com>
 <a0abfee5-4dcd-3eb5-82fe-1a0dcdade038@linux.ibm.com>
 <befb6acd-86be-4255-af96-38865affc56c@linux.intel.com>
 <8bfadc86-e137-4a9f-a9ce-0bc62464c195@linux.intel.com>
 <057a1c19-3117-1aec-41d6-4950c599b862@linux.ibm.com>
 <692e16f9-062c-4b3c-bd66-a16bac68216c@linux.intel.com>
 <cd7dc93f-ade9-6403-a732-2daca8e6cff9@linux.ibm.com>
 <a0540796-1933-4057-8282-aa219ddda4fe@linux.intel.com>
 <6ace2f9f-b073-e22b-0dd6-69c52814d49a@linux.ibm.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <6ace2f9f-b073-e22b-0dd6-69c52814d49a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KL80KZcYCqfXpBJl328r9zEghtdw4rIz
X-Proofpoint-ORIG-GUID: LA8MT5juvh_oMTjwIFViKgi192DKZSk8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_02,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 mlxscore=0 clxscore=1011 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230041

On 1/23/24 06:30, kajoljain wrote:
> 
> 
> On 1/16/24 22:07, Liang, Kan wrote:
>>
>>
>> On 2024-01-16 9:05 a.m., kajoljain wrote:
>>>> For powerpc, the patch 3 introduced a perf_mem_events_power, which
>>>> doesn't have ldlat. But it only be assigned to the pmu->is_core. I'm not
>>>> sure if it's the problem.
>>> Hi Kan,
>>>  Correct there were some small issues with patch 3, I added fix for that.
>>>
>>
>> Thanks Kajol Jain! I will fold your fix into V4.
>>
>>>> Also, S390 still uses the default perf_mem_events, which includes ldlat.
>>>> I'm not sure if S390 supports the ldlat.
>>> I checked it, I didn't find ldlat parameter defined in arch/s390
>>> directory. I think its better to make default ldlat value as false
>>> in tools/perf/util/mem-events.c file.
>>
>> The s390 may not be the only user for the default perf_mem_events[] in
>> the tools/perf/util/mem-events.c. We probably cannot change the default
>> value.
>> We may share the perf_mem_events_power[] between powerpc and s390. (We
>> did the similar share for arm and arm64.)
>>
>> How about the below patch (not tested.)
>>
>> diff --git a/tools/perf/arch/s390/util/pmu.c
>> b/tools/perf/arch/s390/util/pmu.c
>> index 225d7dc2379c..411034c984bb 100644
>> --- a/tools/perf/arch/s390/util/pmu.c
>> +++ b/tools/perf/arch/s390/util/pmu.c
>> @@ -8,6 +8,7 @@
>>  #include <string.h>
>>
>>  #include "../../../util/pmu.h"
>> +#include "../../powerpc/util/mem-events.h"
>>
>>  #define        S390_PMUPAI_CRYPTO      "pai_crypto"
>>  #define        S390_PMUPAI_EXT         "pai_ext"
>> @@ -21,5 +22,5 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
>>                 pmu->selectable = true;
>>
>>         if (pmu->is_core)
>> -               pmu->mem_events = perf_mem_events;
>> +               pmu->mem_events = perf_mem_events_power;
>>  }
>>
>>
>>
>> However, the original s390 code doesn't include any s390 specific code
>> for perf_mem. So I thought it uses the default perf_mem_events[].
>> Is there something I missed?
>>
>> Or does the s390 even support mem events? If not, I may remove the
>> mem_events from s390.
> 
> Hi Kan,
>    I don't have s390 system to do testing. But from my end I am fine
> with the changes.
> 
> Thanks,
> Kajol Jain
> 

s390 does not support perf mem at all. Right now it is save to remove it from s390.
Thanks

>>
>> Thanks,
>> Kan
> 

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294



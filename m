Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8066E753605
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbjGNJF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbjGNJFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:05:22 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D4F30E9;
        Fri, 14 Jul 2023 02:05:14 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36E8qmem018529;
        Fri, 14 Jul 2023 09:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=bxIm0fdUOnrazPTgn9N/1DQLzfOepforDs5jVfGTaFE=;
 b=HydMc01rar3APdzJL21fPsiLM3RlgJg0CNVdLjNrR95Dhl7EH/wFnezr2N/IfwoDgrTT
 P4iWYqa/wU23cJttIjQJlV1GnQ8CzifANIE2cJ2jWmWEKRTve/+s4fKyLFRKQ3t+mc4E
 sNiVEmcDS1YygN8Ixhx0JCu3xX9I7ehQtbIyukjjnlVw2b7O0KRhmoIysdVmA49D3vwe
 edc5voTIuJ6U8lm+5jnUt0BJOm+kUuAV/3zKp/XjopVgmwQimMl73QnLBMdxn5wpq5A1
 K6omVpAtb6YrFRZU6ak5OGZZX2cJ1vzozQpUk9GaFoK9tT2sbUMRPhtz1x791A5euUWW pQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ru380085q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 09:05:06 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36E3e5on004142;
        Fri, 14 Jul 2023 09:05:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3rtpxb875v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 09:05:03 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36E950eP12845616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 09:05:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8D862004B;
        Fri, 14 Jul 2023 09:04:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D9AF20043;
        Fri, 14 Jul 2023 09:04:56 +0000 (GMT)
Received: from [9.171.52.229] (unknown [9.171.52.229])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 14 Jul 2023 09:04:55 +0000 (GMT)
Message-ID: <248c3dc1-0e42-982a-01de-41b6dbf491f9@linux.ibm.com>
Date:   Fri, 14 Jul 2023 14:34:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] cpupower: Fix cpuidle_set to accept only numeric
 values for idle-set operation.
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
        trenn@suse.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ricklind@linux.vnet.ibm.com, latha@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com,
        Pavithra Prakash <pavrampu@linux.vnet.ibm.com>,
        likhitha@linux.ibm.com
References: <20230410121054.61622-1-likhitha@linux.ibm.com>
 <0197f2b8-96a3-22f6-aa14-960afdfd2e8d@linuxfoundation.org>
From:   Likhitha Korrapati <likhitha@linux.ibm.com>
In-Reply-To: <0197f2b8-96a3-22f6-aa14-960afdfd2e8d@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CcEWwWfxI00-_RuzKT67DQ0A0msCip1k
X-Proofpoint-GUID: CcEWwWfxI00-_RuzKT67DQ0A0msCip1k
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_04,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140082
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

Thank you for reviewing.

On 11/04/23 04:22, Shuah Khan wrote:
> On 4/10/23 06:10, Korrapati Likhitha wrote:
>> From: Likhitha Korrapati <likhitha@linux.ibm.com>
>>
>> For both the d and e options in 'cpupower idle_set' command, an
>> atoi() conversion is done without checking if the input argument
>> is all numeric. So, an atoi conversion is done on any character
>> provided as input and the CPU idle_set operation continues with
>> that integer value, which may not be what is intended or entirely
>> correct.
>>
>> The output of cpuidle-set before patch is as follows:
>>
>> [root@xxx cpupower]# cpupower idle-set -e 1$
>> Idlestate 1 enabled on CPU 0
>> [snip]
>> Idlestate 1 enabled on CPU 47
>>
>> [root@xxx cpupower]# cpupower idle-set -e 11
>> Idlestate 11 not available on CPU 0
>> [snip]
>> Idlestate 11 not available on CPU 47
>>
>> [root@xxx cpupower]# cpupower idle-set -d 12
>> Idlestate 12 not available on CPU 0
>> [snip]
>> Idlestate 12 not available on CPU 47
>>
>> [root@xxx cpupower]# cpupower idle-set -d qw
>> Idlestate 0 disabled on CPU 0
>> [snip]
>> Idlestate 0 disabled on CPU 47
>>
>> This patch adds a check for both d and e options in cpuidle-set.c
>> to see that the idle_set value is all numeric before doing a
>> string-to-int conversion.
>>
>> The output of cpuidle-set after the patch is as below:
>>
>> [root@xxx cpupower]# ./cpupower idle-set -e 1$
>> Bad idle_set value: 1$. Integer expected
>>
>> [root@xxx cpupower]# ./cpupower idle-set -e 11
>> Idlestate 11 not available on CPU 0
>> [snip]
>> Idlestate 11 not available on CPU 47
>>
>> [root@xxx cpupower]# ./cpupower idle-set -d 12
>> Idlestate 12 not available on CPU 0
>> [snip]
>> Idlestate 12 not available on CPU 47
>>
>> [root@xxx cpupower]# ./cpupower idle-set -d qw
>> Bad idle_set value: qw. Integer expected
>>
>> Signed-off-by: Likhitha Korrapati <likhitha@linux.ibm.com>
>> Signed-off-by: Brahadambal Srinivasan <latha@linux.vnet.ibm.com>
>> Reported-by: Pavithra Prakash <pavrampu@linux.vnet.ibm.com>
>> Reviewed-by: Rick Lindsley <ricklind@linux.vnet.ibm.com>
>> ---
>>
>> ** changes since v1 [1] **
>>
>> - Addressed reviewed comments from v1.
>> - Slightly reworded the commit for clarity.
>>
>> [1] 
>> https://lore.kernel.org/all/20210105122452.8687-1-latha@linux.vnet.ibm.com/
>>
>>   tools/power/cpupower/utils/cpuidle-set.c     | 25 ++++++++++++++++----
>>   tools/power/cpupower/utils/helpers/helpers.h |  8 +++++++
>>   tools/power/cpupower/utils/helpers/misc.c    | 17 +++++++++++++
>>   3 files changed, 45 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/power/cpupower/utils/cpuidle-set.c 
>> b/tools/power/cpupower/utils/cpuidle-set.c
>> index 46158928f9ad..1bfe16d27c2d 100644
>> --- a/tools/power/cpupower/utils/cpuidle-set.c
>> +++ b/tools/power/cpupower/utils/cpuidle-set.c
>> @@ -47,7 +47,12 @@ int cmd_idle_set(int argc, char **argv)
>>                   break;
>>               }
>>               param = ret;
>> -            idlestate = atoi(optarg);
>> +            if (is_stringnumeric(optarg))
>> +                idlestate = atoi(optarg);
>> +            else {
>> +                printf(_("Bad idle_set value: %s. Integer 
>> expected\n"), optarg);
>> +                exit(EXIT_FAILURE);
>> +            }
>
> Why can't we do this once instead of duplicating the code under
> 'd' and 'e'
>
> Also have you tried using isdigit(idlestate) - works just fine
> for me.
idlestate = atoi(optarg)
The function atoi() is used to convert optarg to an integer. However, 
optarg can potentially be a special character, alphanumeric, or an 
alphabet, such as "q1", "1!", "qw", etc. In such cases, atoi converts 
them to 0, which is an integer. Consequently, the value of idlestate 
becomes 0. This is incorrect because the actual input provided by the 
user is an invalid input like "q1", "1!", "qw", and idlestate gets set 
to 0 in an invalid error condition. isdigit() on this unintended 0 will 
be treated as a good case and not error out as invalid input. and also 
idlestate is already an integer because it is from atoi() ouput. so 
isdigit(idlestate) will be a redundant check.

To handle all these scenarios, we used strtol, which is a string to long 
integer converter. This function is similar to strtoull used in case D 
for latency. This approach allows us to properly handle invalid inputs 
and avoid relying on the isdigit function to determine the validity of 
idlestate, as the value obtained from atoi(optarg) may not be a valid 
idlestate.

I will address the duplication of code under 'd' and 'e' as part of v3.

Thanks,
Likhitha


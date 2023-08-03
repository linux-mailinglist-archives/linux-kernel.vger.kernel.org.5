Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568AA76E8BC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbjHCMrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjHCMrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:47:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17812198A;
        Thu,  3 Aug 2023 05:47:03 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373Cf1HE030571;
        Thu, 3 Aug 2023 12:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Up5lPwvWwcAHCfun11IlNsNymawAvbNSo22c9NGV3/0=;
 b=JDqxog76O9NiIK4r1COjPnPx6a5l6+66k5+LUmxQwmPSHwPCQpn7ixyKE2Tr+C3JogT+
 nwJnsKVZV9oLC/XVT49QJeMbYj1QK/K4aukYyFV+aj9zQRhPQdYld6OAPy+LDG6KKIb1
 bmXmPi9mCAffYVGjrT44momJH4Z7XiXEV/f7LozyobLDuVyxnbeEMq+ZKGczLF2LExFw
 VMKoUJpT139azW9Iu/nJ7e7wH+q9gzaRv7x05wWmVn6GmNfjDZwSG6IyVb//LdHbuewA
 ogLVavwAkXDVkOJPj8h7yxlM+vHgSKO00mVvpQwF+xjQVPhKJOfHgd4nXkApHvkxJj6e nw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8c1ggv76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 12:46:54 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 373AsZmH017001;
        Thu, 3 Aug 2023 12:46:53 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s5dfynpu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 12:46:53 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 373Ckq5U16187702
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Aug 2023 12:46:52 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEC5258060;
        Thu,  3 Aug 2023 12:46:52 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E0EA58056;
        Thu,  3 Aug 2023 12:46:52 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  3 Aug 2023 12:46:52 +0000 (GMT)
Message-ID: <4150bf8c-7321-0dab-ab54-dca7d54c1f3d@linux.ibm.com>
Date:   Thu, 3 Aug 2023 08:46:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: boot-time vtpm helper (was "Re: <void>")
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <CUIRLIY5N6CI.3O9UKOY2N5BS7@suppilovahvero>
 <CUISH28XXJGN.EWZ3CWAQ7G1C@suppilovahvero>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CUISH28XXJGN.EWZ3CWAQ7G1C@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MXzbe-pUtxzjd0E_P2u8gzHKyI0NFtGn
X-Proofpoint-ORIG-GUID: MXzbe-pUtxzjd0E_P2u8gzHKyI0NFtGn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_12,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=949 clxscore=1015 spamscore=0 malwarescore=0
 adultscore=0 impostorscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308030113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/23 05:06, Jarkko Sakkinen wrote:
> On Thu Aug 3, 2023 at 11:25 AM EEST, Jarkko Sakkinen wrote:
>> Hi,
>>
>> I have a working PoC for boot-time initialization of vtpm inside
>> tpm_vtpm_proxy. ATM, it uses the Linux firmware interface to load a ELF
>> binary for the vtpm, and delivers a communication end for the helper
>> process.
>>
>> It is a great feature with the current narrow scope for continuous
>> integration. Obviously the scope could be later on extended to e.g.

Since VMs with vTPMs exist, which CI/CD environment would one use this in?

Where does the binary for the vtpm live when it's loaded with the firmware interface?

>> from unencrypted plain text to a vTPM living inside SGX enclave.

I would run swtpm inside an SGX enclave using Gramine.

Regards,
    Stefan

>>
>> I could send an RFC of this, if there is wider interest for the
>> topic.
>>
>> BR, Jarkko
> 
> I'm sorry, I'm trying learn aerc, and unfortunately forgot to add a subject.
> 
> BR, Jarkko

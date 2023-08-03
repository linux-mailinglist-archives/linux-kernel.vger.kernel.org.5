Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FE376DCF5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 02:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjHCA5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 20:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjHCA5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 20:57:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517D226B0;
        Wed,  2 Aug 2023 17:57:04 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3730fecq025844;
        Thu, 3 Aug 2023 00:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=jmkQEw53pUWR0UBuP984zIVOfazrdtIEuNlyOUI5ZZU=;
 b=M6cQVI0LWWGgB8UKC45EHTtj4HRi7gVt0z7DjFWSZ37XR6XtbmN3npebaqnEeC4ARNvx
 qBphfrsNrtqBqIYrzah4jfyZ4iH+eSUZX0pOix0tJNTGZ2LicrDBJVVqwxYLzyqtugWG
 L9gutQRnECoG8dmw4BDAaKk8hV1aqHOUp93kERPZpH9H18900F4+yf5LsE0AbAkDZeGU
 LR/+bKb2rve7VeyKe+shB4vI938+ZJunGlFaoI1m1Om0G9BrtU/egUunznfNjJGJCvtu
 7o4TD9FA5TcLD8RIEb4yiPoAGSzdEp8aU+FsvCTia26/T498H+gNyScKiS+Txo+Cee9z cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8179gww8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 00:56:45 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3730iGdS032755;
        Thu, 3 Aug 2023 00:56:44 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8179gwt6-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 00:56:44 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 372MfdTl015578;
        Thu, 3 Aug 2023 00:34:35 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s5e3n93rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 00:34:35 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3730YZTn42140104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Aug 2023 00:34:35 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D73258050;
        Thu,  3 Aug 2023 00:34:35 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCE0058045;
        Thu,  3 Aug 2023 00:34:33 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  3 Aug 2023 00:34:33 +0000 (GMT)
Message-ID: <e21da81e-5e18-1aec-cc63-f316cdf0d2fc@linux.ibm.com>
Date:   Wed, 2 Aug 2023 20:34:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
Content-Language: en-US
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniil Stas <daniil.stas@posteo.net>,
        Mario Limonciello <mario.limonciello@amd.com>,
        James.Bottomley@hansenpartnership.com, Jason@zx2c4.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@leemhuis.info, stable@vger.kernel.org
References: <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com>
 <20230727195019.41abb48d@g14> <67eefe98-e6df-e152-3169-44329e22478d@amd.com>
 <20230727200527.4080c595@g14>
 <CAHk-=whqT0PxBazwfjWwoHQQFzZt50tV6Jfgq3iYceKMJtyuUg@mail.gmail.com>
 <CUGAV1Y993FB.1O2Q691015Z2C@seitikki>
 <CAHk-=whphk8Jp=NYmnm7Qv+vZ6ScYCz+rV8a2G1nD-AQY3z+mQ@mail.gmail.com>
 <CUHF67ZOFOTN.1UFE7Q1IFRQMX@suppilovahvero>
 <CAHk-=wgK0Z-LrJGExwG=e=oxjD93LJhY3jMmi_2O2_Pkjf8Tsg@mail.gmail.com>
 <CUHG1TB7IELF.PVXOXEXBGEPP@suppilovahvero>
 <ejqnhdrhktfrhcb76bxx6y73hydjov34t7m4wrvzjc22gdtzts@p4g7yqxdnijn>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <ejqnhdrhktfrhcb76bxx6y73hydjov34t7m4wrvzjc22gdtzts@p4g7yqxdnijn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Odd5d8PJL65wwCtxuBEiLvglHKN7Wn02
X-Proofpoint-ORIG-GUID: X0UOYzpL91UBanjjrMqCZBDATt-De4VZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_20,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 impostorscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308030004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/23 19:13, Jerry Snitselaar wrote:
> On Tue, Aug 01, 2023 at 10:09:58PM +0300, Jarkko Sakkinen wrote:
>> On Tue Aug 1, 2023 at 9:42 PM EEST, Linus Torvalds wrote:
>>> On Tue, 1 Aug 2023 at 11:28, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>>>>
>>>> I would disable it inside tpm_crb driver, which is the driver used
>>>> for fTPM's: they are identified by MSFT0101 ACPI identifier.
>>>>
>>>> I think the right scope is still AMD because we don't have such
>>>> regressions with Intel fTPM.
>>>
>>> I'm ok with that.
>>>
>>>> I.e. I would move the helper I created inside tpm_crb driver, and
>>>> a new flag, let's say "TPM_CHIP_FLAG_HWRNG_DISABLED", which tpm_crb
>>>> sets before calling tpm_chip_register().
>>>>
>>>> Finally, tpm_add_hwrng() needs the following invariant:
>>>>
>>>>          if (chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
>>>>                  return 0;
>>>>
>>>> How does this sound? I can refine this quickly from my first trial.
>>>
>>> Sounds fine.
>>
>> Mario, it would be good if you could send a fix candidate but take my
>> suggestion for a new TPM chip flag into account, while doing it. Please
>> send it as a separate patch, not attachment to this thread.
>>
>> I can test and ack it, if it looks reasonable.
>>
>>> My only worry comes from my ignorance: do these fTPM devices *always*
>>> end up being enumerated through CRB, or do they potentially look
>>> "normal enough" that you can actually end up using them even without
>>> having that CRB driver loaded?
>>
>> I know that QEMU has TPM passthrough but I don't know how it behaves
>> exactly.
>>
> 
> I just created a passthrough tpm device with a guest which it is using
> the tis driver, while the host is using crb (and apparently one of the
> amd devices that has an impacted fTPM). It looks like there is a
> complete separation between the frontend and backends, with the front
> end providing either a tis or crb interface to the guest, and then the
> backend sending commands by writing to the passthrough device that was
> given, such as /dev/tpm0, or an emulator such as swtpm. Stefan can
> probably explain it much better than I.


You explained it well... The passthrough TPM is only good for one VM (if
at all), and all other VMs on the same machine should use a vTPM. Even
one VM sharing the TPM with the host creates a potential mess with the
shared resources of the TPM, such as the state of the PCRs.

When that guest VM using the passthrough device now identifies the underlying
hardware TPM's firmware version it will also take the same action to disable
the TPM as a source for randomness. But then a VM with a passthrough TPM
device should be rather rare...

> 
>>> Put another way: is the CRB driver the _only_ way they are visible, or
>>> could some people hit on this through the TPM TIS interface if they
>>> have CRB disabled?
>>
>> I'm not aware of such implementations.

CRB and TIS are two distinct MMIO type of interfaces with different registers etc.

AMD could theoretically build a fTPM with a CRB interface and then another one with the same firmware and the TIS, but why would they?

    Stefan


>>
>>> I see, for example, that qemu ends up emulating the TIS layer, and it
>>> might end up forwarding the TPM requests to something that is natively
>>> CRB?
>>>
>>> But again: I don't know enough about CRB vs TIS, so the above may be a
>>> stupid question.



>>>
>>>             Linus
>>
>> I would focus exactly what is known not to work and disable exactly
>> that.
>>
>> If someone still wants to enable TPM on such hardware, we can later
>> on add a kernel command-line flag to enforce hwrng. This ofc based
>> on user feedback, not something I would add right now.
>>
>> BR, Jarkko
> 

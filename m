Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F310A7D7DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344194AbjJZHrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZHrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:47:19 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F6AA1;
        Thu, 26 Oct 2023 00:47:17 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q7DBrI017974;
        Thu, 26 Oct 2023 07:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Nlz74d/1GvcLdqKD3c2msBQ0no2S2Exe23d/V0iKX/k=;
 b=g0wFMs7+BEXpKGnF6e3juuq2iah5oFG/1Vvd+II8I/GVYjuqNV4ZmiR7mNF6y8g4LnEa
 ihpLlAP+QFj05lMoqBJAjCpGI216Sc7BoNypcZe5BCHPBV7K9wcquFeepAQwLs+KwYtP
 kjXFmSXUU09/uYWkQOyHYUBYtyDn/vaq30PhYPk5FRAMmS0ihE8ZiihL8dPpN8Uv3K26
 dd5diLlMU86BVbxOH++GArzYDiVPHFbXFqIOd+QGsCapRG8R8ywsun5XBkVljpJJgv0M
 Zji3xFKDvLmrq4B043HLqS2Mjkxz7VNDYfpAwQfcxK5ee3cJ2qFNYxtBhZ2DLJKJ79o4 pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tykde1awu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 07:47:07 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39Q7iXEH018357;
        Thu, 26 Oct 2023 07:47:07 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tykde1awc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 07:47:07 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q7KRqt024403;
        Thu, 26 Oct 2023 07:47:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tvu6kc8bd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 07:47:06 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39Q7l3Ft24052286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 07:47:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4B1C20049;
        Thu, 26 Oct 2023 07:47:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B292820040;
        Thu, 26 Oct 2023 07:47:03 +0000 (GMT)
Received: from [9.152.212.65] (unknown [9.152.212.65])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 26 Oct 2023 07:47:03 +0000 (GMT)
Message-ID: <41b5ad2b-0b9e-a624-9ab3-43ad264076a6@linux.ibm.com>
Date:   Thu, 26 Oct 2023 09:47:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] perf report: Add s390 raw data interpretation for PAI
 counters
To:     Namhyung Kim <namhyung@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com
References: <20231024091729.4180034-1-tmricht@linux.ibm.com>
 <CAM9d7cgzDrO-mU9A6twYqgZ1JFaU1Lj-RC+Lmz3gpxU7gFUr=g@mail.gmail.com>
Content-Language: en-US
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <CAM9d7cgzDrO-mU9A6twYqgZ1JFaU1Lj-RC+Lmz3gpxU7gFUr=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bb0S97yFBd3X6kSSX23QhcD6T1iv5gJG
X-Proofpoint-ORIG-GUID: KIxaedPIOMLpV3j7oLAdG_VfpG24U5ER
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_05,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310260064
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/23 19:00, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Oct 24, 2023 at 2:17 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>
>> commit 1bf54f32f525 ("s390/pai: Add support for cryptography counters")
>> added support for Processor Activity Instrumentation Facility (PAI)
>> counters.  These counters values are added as raw data with the perf
>> sample during perf record.
>> Now add support to display these counters in perf report command.
>> The counter number, its assigned name and value is now printed in
>> addition to the hexadecimal output.
>>
>> Output before:
>>  # perf report -D
>>
>>  6 514766399626050 0x7b058 [0x48]: PERF_RECORD_SAMPLE(IP, 0x1):
>>                                 303977/303977: 0 period: 1 addr: 0
>>  ... thread: paitest:303977
>>  ...... dso: <not found>
>>
>>  0x7b0a0@/root/perf.data.paicrypto [0x48]: event: 9
>>  .
>>  . ... raw event: size 72 bytes
>>  . 0000:  00 00 00 09 00 01 00 48 00 00 00 00 00 00 00 00  .......H........
>>  . 0010:  00 04 a3 69 00 04 a3 69 00 01 d4 2d 76 de a0 bb  ...i...i...-v...
>>  . 0020:  00 00 00 00 00 01 5c 53 00 00 00 06 00 00 00 00  ......\S........
>>  . 0030:  00 00 00 00 00 00 00 01 00 00 00 0c 00 07 00 00  ................
>>  . 0040:  00 00 00 53 96 af 00 00                          ...S....
>>
>> Output after:
>>  # perf report -D
>>
>>  6 514766399626050 0x7b058 [0x48]: PERF_RECORD_SAMPLE(IP, 0x1):
>>                                 303977/303977: 0 period: 1 addr: 0
>>  ... thread: paitest:303977
>>  ...... dso: <not found>
>>
>>  0x7b0a0@/root/perf.data.paicrypto [0x48]: event: 9
>>  .
>>  . ... raw event: size 72 bytes
>>  . 0000:  00 00 00 09 00 01 00 48 00 00 00 00 00 00 00 00  .......H........
>>  . 0010:  00 04 a3 69 00 04 a3 69 00 01 d4 2d 76 de a0 bb  ...i...i...-v...
>>  . 0020:  00 00 00 00 00 01 5c 53 00 00 00 06 00 00 00 00  ......\S........
>>  . 0030:  00 00 00 00 00 00 00 01 00 00 00 0c 00 07 00 00  ................
>>  . 0040:  00 00 00 53 96 af 00 00                          ...S....
>>
>>         Counter:007 km_aes_128 Value:0x00000000005396af     <--- new
>>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> ---
>>  tools/perf/util/s390-cpumcf-kernel.h |  2 +
>>  tools/perf/util/s390-sample-raw.c    | 89 ++++++++++++++++++++++++++--
>>  2 files changed, 85 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/perf/util/s390-cpumcf-kernel.h b/tools/perf/util/s390-cpumcf-kernel.h
>> index f55ca07f3ca1..74b36644e384 100644
>> --- a/tools/perf/util/s390-cpumcf-kernel.h
>> +++ b/tools/perf/util/s390-cpumcf-kernel.h
>> @@ -12,6 +12,8 @@
>>  #define        S390_CPUMCF_DIAG_DEF    0xfeef  /* Counter diagnostic entry ID */
>>  #define        PERF_EVENT_CPUM_CF_DIAG 0xBC000 /* Event: Counter sets */
>>  #define PERF_EVENT_CPUM_SF_DIAG        0xBD000 /* Event: Combined-sampling */
>> +#define PERF_EVENT_PAI_CRYPTO_ALL      0x1000 /* Event: CRYPTO_ALL */
>> +#define PERF_EVENT_PAI_NNPA_ALL        0x1800 /* Event: NNPA_ALL */
>>
>>  struct cf_ctrset_entry {       /* CPU-M CF counter set entry (8 byte) */
>>         unsigned int def:16;    /* 0-15  Data Entry Format */
>> diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
>> index 115b16edb451..f360aed3bf0a 100644
>> --- a/tools/perf/util/s390-sample-raw.c
>> +++ b/tools/perf/util/s390-sample-raw.c
>> @@ -125,6 +125,9 @@ static int get_counterset_start(int setnr)
>>                 return 128;
>>         case CPUMF_CTR_SET_MT_DIAG:             /* Diagnostic counter set */
>>                 return 448;
>> +       case PERF_EVENT_PAI_NNPA_ALL:           /* PAI NNPA counter set */
>> +       case PERF_EVENT_PAI_CRYPTO_ALL:         /* PAI CRYPTO counter set */
>> +               return setnr;
>>         default:
>>                 return -1;
>>         }
>> @@ -212,27 +215,101 @@ static void s390_cpumcfdg_dump(struct perf_pmu *pmu, struct perf_sample *sample)
>>         }
>>  }
>>
>> +/*
>> + * Check for consistency of PAI_CRYPTO/PAI_NNPA raw data.
>> + */
>> +struct pai_data {              /* Event number and value */
>> +       u16 event_nr;
>> +       u64 event_val;
>> +} __packed;
>> +
>> +/*
>> + * Test for valid raw data. At least one PAI event should be in the raw
>> + * data section.
>> + */
>> +static bool s390_pai_all_test(struct perf_sample *sample)
>> +{
>> +       unsigned char *buf = sample->raw_data;
>> +       size_t len = sample->raw_size;
>> +
>> +       if (len < 0xa || !buf)
>> +               return false;
>> +       return true;
>> +}
>> +
>> +static void s390_pai_all_dump(struct evsel *evsel, struct perf_sample *sample)
>> +{
>> +       size_t len = sample->raw_size, offset = 0;
>> +       unsigned char *p = sample->raw_data;
>> +       const char *color = PERF_COLOR_BLUE;
>> +       struct pai_data pai_data;
>> +       char *ev_name;
>> +
>> +       evsel->pmu = perf_pmus__find_by_type(evsel->core.attr.type);
> 
> Does it need to find evsel->pmu everytime?
> 
> Thanks,
> Namhyung
> 

Function evlist__s390_sample_raw() is assigned to member
  evlist::trace_event_sample_raw
as call back in function evlist__init_trace_event_sample_raw()
only after it has been verified that the perf.data file was created
on s390 platform.  Function evlist__s390_sample_raw() is only invoked
when investigating a perf data file created on a s390.

Debugging revealed that member evsel::pmu was set to NULL on
function entry. Setting evsel::pmu to the PMU retrieves the counter
names. If the PMU is not found, the NULL pointer remains and
no counter names are displayed. Same behavior as before.

I hope the clearifies the patch....

Thanks.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294


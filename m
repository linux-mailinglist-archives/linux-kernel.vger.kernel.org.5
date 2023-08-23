Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3307478523D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjHWIE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbjHWIEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:04:01 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2048.outbound.protection.outlook.com [40.92.99.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3923CD0;
        Wed, 23 Aug 2023 01:03:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFzvI/8LFRxvl8EDwN9C6LsDwATY704D/0vcHFq9h1EJt1rd2m/gFuWc0VKSMowsNj6BF3rT/gMYanAuFjKaTJ7jdA1n2B58ie+qKIrMhSiRilKuG2VFHWfT54/L4vdMXbE+yn2zbroo22Dg7KY+mXngsj/afsQ9/XZHPr2Fnp6+1D2R84kTiAr5/t2dwhkLIAulakLxTm9T1xpWJjWRpXwMkyH71ApnC8/aKcXxYmUWRqM6M8itflCmPXsidkfZ7BRsgBOO+X9gfNVhzvJkibHB187cUDcICcdQAbODBtH6wduur9203Tz1Oyualv6IUxtbPrsHs8WpmPWb4Xv/kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wwq7kSz4Or/JJ0SDpVt+oX1bmeLTvlYlAfwH51Pv160=;
 b=NbION7noi4G0r4qNty2GxKCnlTgudgd7H6VNfpD1YcekZexTQmzdyWK10sgxhXfpxTAwor677sSiSVSxK12V+lHeAOHGAUSE0wHFLUAh/slrJcopoRZmRjM+t7o3L+K5oHCAjsJjXzBhmlvf2X+pmXNR+TTlxZRwNVA944CMrVYgwvHQJpku3GdhalhDKh+Jap6/q9xQdeDl7zv6pj3vckbveIB7OFuOZRJEXQAH1nnwu5fVAG/ZZxA7Ta5CjkHC/Cz3crCGRAarolo3sBxdn9k7COnmMrW8DmmuCa3L7TOq3WqBv18B7jVmcJtrXHQd8cgW/CNWEstI7c6pwU319g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wwq7kSz4Or/JJ0SDpVt+oX1bmeLTvlYlAfwH51Pv160=;
 b=ELILRZynxQAoimM8JA4JEjO0IlaOeC5mo8f7qXj9fxSbm06bNup0e63fRk5LCdkhrqzaMgjV6I0z27b2DT5pcB3XGrKxD4Ev8NfRZPaoDlts5mUqgI5Ygq4GaZPzqdGhyn6Ry3i/Ep+nAgPCoUBAtqS1dKyGOdyCzHK2RCr5j9euztSWV5lMCC3FpPSZzA6uV+MB1dyTBZ3Xcu62SK7W6lDZD1L8oV7dKqhTEnvRVEUtuuJUusQDnLgy3zfgr8hgR/Bvv64tPkfDf/0AwgcmGyQIaEKA6gm7Gwg7S3KYiPA4XDL4cBftONywDRlbiHCpMfBlW8yuWpUiEWb9wC4Ulw==
Received: from TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:242::11)
 by OS3P286MB1917.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.16; Wed, 23 Aug
 2023 08:03:50 +0000
Received: from TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM
 ([fe80::320e:3328:32e4:a3ce]) by TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM
 ([fe80::320e:3328:32e4:a3ce%4]) with mapi id 15.20.6723.015; Wed, 23 Aug 2023
 08:03:50 +0000
Message-ID: <TYCP286MB2607279A11E7F97D249FD4CCB11CA@TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM>
Date:   Wed, 23 Aug 2023 16:03:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] HID: i2c-hid: use print_hex_dump_debug to print report
 descriptor
Content-Language: en-US
To:     Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        dmitry.torokhov@gmail.com, linux@weissschuh.net,
        hdegoede@redhat.com, rrangel@chromium.org,
        u.kleine-koenig@pengutronix.de, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Riwen Lu <luriwen@kylinos.cn>
References: <TYCP286MB2607175E9C15DB17A2102AEAB114A@TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM>
 <OS3P286MB259916DCE3D992135FF05F4CB115A@OS3P286MB2599.JPNP286.PROD.OUTLOOK.COM>
 <87msyq5m7y.fsf@protonmail.com>
From:   Riwen Lu <luriwen@hotmail.com>
In-Reply-To: <87msyq5m7y.fsf@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [8309/KKw1N78k/Vs7f3KFaIOEg5SKDE/]
X-ClientProxiedBy: TYCP286CA0139.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::7) To TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:242::11)
X-Microsoft-Original-Message-ID: <11fa8040-b735-931e-bf56-26650b3cb8dd@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2607:EE_|OS3P286MB1917:EE_
X-MS-Office365-Filtering-Correlation-Id: 512c2b11-d53e-4edd-fe02-08dba3af7c14
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yR1lu2/TiNDVuD0v6eKSILvQD4aXjLM70z9G0xhLWtsxRWMUMEH40OG6Ip5XZK2sHFWkdqgTfscCi2BSBAYA7CCEv60GNdTWf+ygIbDy39isSsTZ50qfZPeFi3y/HfbBHqv3U8NAbkpDxdfPWYEReCUD4BeZKb749/NW2p0uqU0C+hopNwSRU7hOolCZBgGIUPzcAEwm5u6afAo8OBkGlXrrbtZIyXdUw9rmfNnbVPfgaV5JTM1zNOQqxViO+s9B2euWNgwae9S4Jl0QbdDrEena2JMI7IWb063myJc78/d2ee3AG1OcVuzzOYAC9Njmor+o1OOprPjsk5QiSpE7tpkxQtd9jT50b2/NGfsqv0ETFV6C1NpYedQ1bAnql6C4L3CRfgshnxmJ8GVOrewsvCNZpy45vscPHDRjiZrEMote3W9bm8QeoV/9CrBiQXcK3euIWuhjEPy6KhAWFVMxNbbueqVpO4NBQYAVsV/tVtIwHqjYherVunfcrc8Mo5NC0B3cnrxl07cIiClJRfYsusZ1QE6ozOzLZmOLbwj0NZ8=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M09ZVklaWDE2UTN2eTdWVE5RTXhrQ0dJL0ZieFdPVDBiR2VVazhtbjVxWE9N?=
 =?utf-8?B?U0tMM2h4dGhwaE1kVzA1Ykd3Nm1ldU8vUjFYMG5zbERyYWo1VFJha0c1SFZs?=
 =?utf-8?B?OUN0cDNURS93dTJBL1hwMEFlMXM5S0FkZ283NEEwb1gxbmVidkdEVGdHeWtN?=
 =?utf-8?B?dFZGRTVORGRCQVh4T1plMnJsVngzcVAzVEhPbE9sSWdoRGN4dXBzY3dZdFlQ?=
 =?utf-8?B?NzNCV2NzSnJFdk5udnVObEVJaWlXL29iblUyNFRTSWJQQ2I1cjRTcU9IT0RP?=
 =?utf-8?B?ZHZaekFFU1g2ZENZV2RGckl5ek5xaUlZeWU2RmtyK2tqK0pjTkRKSXZvMVY3?=
 =?utf-8?B?NkxnMHA2WUdJSHVKVUg5eEV2QjYxOUpLVkdXSVdoRHBKS2dqemwwQUtZY0M4?=
 =?utf-8?B?YllmWXdNbGwwbTNSTlE1YVo4TWFGQ3JOQnRudURpU3ErUnBzaHhPdVdkZis5?=
 =?utf-8?B?eVJSd0wyZURjVHdkMGZTZmFyZVp5MzRXelJOaVBCMWc1MDJvY2VxWUVrTmZC?=
 =?utf-8?B?amZtMGkyaVhuVTFCZjFScGNUVkFzOWdEWCs0aXVRSHEwSm9IZGRua2tkMklI?=
 =?utf-8?B?eDVqaU1aY1JmZUlYWGhiT2ltbTdlQ2d4MkdwcUVIV0FtWStWZjhiZWFlcStQ?=
 =?utf-8?B?eW9JdW95Q3RwUUVIeHRybFRCUVRYdkhNOUdUMDdWdFRHUWlSOFlOOEU5S085?=
 =?utf-8?B?bGxPS01PTHdjK0xYMDYzL1MwZVhHRGdmMkIzMzFWUVhzZHJpcGtsNytXbGFW?=
 =?utf-8?B?RnVzNkdlWlFpSit3TWtPTk9LanA3anVycVY1R3Bwc0dXRG11SEZMc0xPZ1F2?=
 =?utf-8?B?Nmt2dFFwbmJsUW0rUGdyRUlQdkhsMnpmNU5vWnB5SFNzQkQzbTBUNHB1RlF1?=
 =?utf-8?B?Q1U5LzBGeWsybFNRTDNST2F2OUFLd0JBbllpaHdzUjkwV0xXbUxlaVBaQVpn?=
 =?utf-8?B?L2NlRCtWWnlVRnR6VHlqYzhHTkpwK2pFbU5CZXU1RVF0bGgwYTVzMlFUeStw?=
 =?utf-8?B?OWpUajRxZC8vS2tRRmltbHdQN2doVXdkYzJZK1lGU1ovYjErbkt3czIxTDFt?=
 =?utf-8?B?N2ZkTDZqTUdGUHVTS2YzR211d3QrcURiRkhuRjNqeDhyYkJpam1mRHVqdXUr?=
 =?utf-8?B?SGtBdjA4ZkN1Z0hMZGlXVDZQMGZ5OWw2NzhGcy9Cd3NlMFh5azgvSDNpNmJY?=
 =?utf-8?B?SUJsUXRjUjlsSlFwOThiZUE0bUZnajBOSlhtVi9KTWh0V0pKTXlsTCtmL24v?=
 =?utf-8?B?VGFCejJTMWtQV0ZRRmlZT1FZUS9CTTZra2YrV1FUaVRGb1J5MVNKT1o3MUNQ?=
 =?utf-8?B?V0xST1pML3ZIK1owWERRYkRRNGNkWGtWK0pNWCtEdkNmcXBOTzkyMVRXM2xh?=
 =?utf-8?B?R3pqYTRUUkVPdjMwRFpFL0JKSjZ5UXZXVnYvMzBUdk1ZSERMclpiZ1lDUCsv?=
 =?utf-8?B?QXVkVFBNa1ZoOGhIY1Y2bkd0RHRJMVJqdFJYTzV6bGVPR29tZVFvdW5tYkly?=
 =?utf-8?B?SFQwWjNLb3JQSGNZL05aQUpKdjJLUVZYN25hWkY5TjduOHloTVo3SUNKS0E0?=
 =?utf-8?B?cDdwZGtOeW5QZGJWdGo0aVVlblV2ZE9KZm9JRG9Tb2NRME80bDdOK0FJbUpJ?=
 =?utf-8?B?TjVhMWUreHl2UEZPN3QrY0NzRmduTEE9PQ==?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 512c2b11-d53e-4edd-fe02-08dba3af7c14
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 08:03:50.1744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1917
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/8/17 12:25, Rahul Rameshbabu 写道:
> 
> On Wed, 16 Aug, 2023 16:38:19 +0800 "Riwen Lu" <luriwen@hotmail.com> wrote:
>> From: Riwen Lu <luriwen@kylinos.cn>
>>
>> The format '%*ph' print up to 64 bytes long as a hex string with ' '
>> sepatator. Usually the size of report descriptor is larger than 64
>> bytes, so consider using print_hex_dump_debug to print out all of it for
>> better debugging.
>>
>> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
>>
>> ---
>> v1->v2:
>>   - Add a prefix for the hex dump.
>> ---
>>   drivers/hid/i2c-hid/i2c-hid-core.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
>> index efbba0465eef..fd82e9042da5 100644
>> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
>> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
>> @@ -772,7 +772,9 @@ static int i2c_hid_parse(struct hid_device *hid)
>>   		}
>>   	}
>>
>> -	i2c_hid_dbg(ihid, "Report Descriptor: %*ph\n", rsize, rdesc);
>> +	i2c_hid_dbg(ihid, "Report Descriptor\n");
> 
> Instead of just indicating that the report descriptor dump begins with
> the above print, I think it makes more sense for the print to be changed
> to a pair of begin/end or "cut here" prints similar to what you see in
> oops messages. This will help individuals reading reports copied by bug
> reporters validate that the complete descriptor dump is present.
> 
> Something along the lines of what is done in sound/soc/sof/debug.c.
> 
I don't think it's necessary to add a pair of begin/end prints like 
that. However, I can print out the size of the report descriptor through 
i2c_hid_dbg. And print_hex_dump_debug prints each line with a "Report 
Descriptor" prefix and an offset, so it's easy to know if the descriptor 
dump is complete.
The dump message is similar to the following.
i2c_hid i2c-PNP0C50:00: Report Descriptor size: 0x144
Report Descriptor: 00000000: 05 01 09 02 a1 01 85 01 09 01 a1 00 05 09 19 01
Report Descriptor: 00000010: 29 02 15 00 25 01 75 01 95 02 81 02 95 06 81 03
Report Descriptor: 00000020: 05 01 09 30 09 31 09 38 15 81 25 7f 75 08 95 03
Report Descriptor: 00000030: 81 06 c0 c0 05 0d 09 05 a1 01 85 04 09 22 a1 02
Report Descriptor: 00000040: 15 00 25 01 09 47 09 42 95 02 75 01 81 02 95 01
Report Descriptor: 00000050: 75 03 25 02 09 51 81 02 75 01 95 03 81 03 05 01
Report Descriptor: 00000060: 15 00 26 5b 05 75 10 55 0d 65 11 09 30 35 00 46
Report Descriptor: 00000070: 46 2a 95 01 81 02 46 59 17 26 f4 02 09 31 81 02
Report Descriptor: 00000080: 05 0d 15 00 25 64 95 03 c0 55 0c 66 01 10 47 ff
Report Descriptor: 00000090: ff 00 00 27 ff ff 00 00 75 10 95 01 09 56 81 02
Report Descriptor: 000000a0: 09 54 25 7f 95 01 75 08 81 02 05 09 09 01 25 01
Report Descriptor: 000000b0: 75 01 95 01 81 02 95 07 81 03 09 c5 75 20 95 01
Report Descriptor: 000000c0: 81 03 05 0d 85 02 09 55 09 59 75 04 95 02 25 0f
Report Descriptor: 000000d0: b1 02 85 07 09 60 75 01 95 01 15 00 25 01 b1 02
Report Descriptor: 000000e0: 95 07 b1 03 06 00 ff 85 08 09 c5 15 00 26 ff 00
Report Descriptor: 000000f0: 75 08 96 00 01 b1 02 c0 05 0d 09 0e a1 01 85 03
Report Descriptor: 00000100: 09 22 a1 02 09 52 15 00 25 0a 75 08 95 01 b1 02
Report Descriptor: 00000110: c0 09 22 a1 00 85 05 09 57 09 58 75 01 95 02 25
Report Descriptor: 00000120: 03 b1 02 95 06 b1 03 c0 c0 06 00 ff 09 01 a1 01
Report Descriptor: 00000130: 15 00 26 ff 00 75 08 85 06 95 3f 09 01 81 02 09
Report Descriptor: 00000140: 01 91 02 c0

Thanks.

>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/sof/debug.c?id=4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6#n407
> 
>> +	print_hex_dump_debug("Report Descriptor: ", DUMP_PREFIX_OFFSET, 16, 1,
>> +			rdesc, rsize, false);
>>
> 
> --
> Thanks,
> 
> Rahul Rameshbabu
> 


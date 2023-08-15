Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1783B77C764
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbjHOGES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbjHOGDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:03:35 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2020.outbound.protection.outlook.com [40.92.98.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27023173D;
        Mon, 14 Aug 2023 23:03:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5XsoTiaCode7nVHLQRLZ/qHRPwO7gXAlM48GxmyB0T1IgN3bpeTzg8afRFBsmdK2BjOlZGGTACIPmIRmfZAGgNAC+4Z5pllVd8IfBSHriZB/8t9S72iVQXXRb0UvswXzMq5c499TML7wxi5QQhJVjRv5lucEP0Cw8yqigexCkakesRt3mmIlMski0wrxsVU9lKN72PXOGfxf1iwB1OjG1xHU1DpJPYPYcMKbBYBEraRIV+fAe/mfAcYfiebY7q2SsIR6YK1lpqPMgwUMe23/ovAaYkNvoDRmAvmDlZmXt3aej7eJn7l0ArN0K+UU4nTWLPapmMVy6HaUfXGHGYqTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=271xfenowj6ZsG19VuZqT+Ea9bs2lYU9Yfa8drHqBTA=;
 b=bRMXIU86dOdwrr/eLXrczyZwPLEoUFSsJI8EBVkaL067LnEWERsjPv5T2rWalDjBCx5LAxtDiTjjRnSvhDGBLEW8Fk/TrdH5QmF3H5XocuE+FReeUYMxTKsK/1GlhAJ+QP88xUil9pUZzBLkmOrhtAEiOGNC7J8sUqq6xrseS9s9Rd6T3J6pjCk+qFIyeXw+/WtC+c1zOgfswtSfl4v2t/QgT/z414Wd5TTPgnyAYc7x5Jcsrikzoi0/K/Lxya2EWoxQP5FC/6fYavgGyuOO8moKFoEBRy1Z8uovamTLPxagwzWKtdmPBePk1NIVvbdXcodCUYLNztj1HcnjfzLvZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=271xfenowj6ZsG19VuZqT+Ea9bs2lYU9Yfa8drHqBTA=;
 b=TsoSKuHzvRJvW/GHz38CDpXdXlqky+vIzEh6NlxXvua+gVoxfYH7dzmRPlx5Cqa+CzAk0xZvPnzeTzspdTKyMF7u5OXSFxd/wrOOvtkbaj93RVCO42iWA1qjDgLtRgq7N6SExzcBaYTKNKp8CMLqr4YYG7nIgaoY38UhAmujLJpIDnIirV418iH62Shk9N/QzOa6MSkAH1Y//lJBXDTEneKH8ZK7wonr2V/ANIKVAAzgpvY4WoLOmJtJLHS0uicGnSqaQ8TsEV0V0cTFU8M1dc0lBCa+YKhgoj+r1DZNyZMcnATmnc4/9rATVyfkfthVKdMimuGEZQeL7t85/k7C3g==
Received: from TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:242::11)
 by TYWP286MB3319.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 06:03:05 +0000
Received: from TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM
 ([fe80::320e:3328:32e4:a3ce]) by TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM
 ([fe80::320e:3328:32e4:a3ce%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 06:03:05 +0000
Message-ID: <TYCP286MB260715E63D023C52591264C5B114A@TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM>
Date:   Tue, 15 Aug 2023 14:02:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] HID: i2c-hid: use print_hex_dump_debug to print report
 descriptor
To:     Jiri Kosina <jikos@kernel.org>
Cc:     benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        linux@weissschuh.net, hdegoede@redhat.com, rrangel@chromium.org,
        u.kleine-koenig@pengutronix.de, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Riwen Lu <luriwen@kylinos.cn>
References: <TYCP286MB260706B19C5E30EE2774784EB129A@TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM>
 <nycvar.YFH.7.76.2308141126330.14207@cbobk.fhfr.pm>
Content-Language: en-US
From:   Riwen Lu <luriwen@hotmail.com>
In-Reply-To: <nycvar.YFH.7.76.2308141126330.14207@cbobk.fhfr.pm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [pHUsWBMioNisFnHVQv2p9rUJRElm0gQa]
X-ClientProxiedBy: TYWP286CA0016.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::21) To TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:242::11)
X-Microsoft-Original-Message-ID: <48a87202-26fc-5b09-f2d4-6e316e723f6a@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2607:EE_|TYWP286MB3319:EE_
X-MS-Office365-Filtering-Correlation-Id: cda2f8de-daa2-4d09-9757-08db9d554a79
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m0XgjF+yUZd8dMJi0PXlwi7MyOR5COCCs6/7vr1wazRMKLW2v4KWM+S+cMQUJk6AL6rE6DzmwsJUCA6CQviGNoG27v5LdK5QFU7BilL26F8J99LvvzvP+YCYG9/+/gSm80U2881b13cdM+xwVjnYJQujWNTW6ceqs3fNOZD6BbqSHEXa5T7unq6Ofod4EzvuVdbmHAUFqN1JI85XOUlIWwA/b9JGvQiZRrFW2y7QAUt49DNGTkvvxtkvNxU4la8ksc8NMY86zwINdSZS74CsfHR3EJeZc2lfKERYoXqeZavdsGzUnkzYqHizyIf+oPegnJ+j38gNCnbT0k8Qs91z6rbXHQFofvUvN/VvY6R09HfyZZ3CagwA5GRXXicih9yiKswjnZPRIcRUEKCZHQRYjNvPbZ45S5O72p/1idXNrFGM1s9IVTfpR09DtR4P9G2LQlyP4K6fDoLJ7m7WfCI9Hdb3jXNYSgw5T9AYZe4fLwD5X9Co46493m0GBO9bk7lk64BZURsaI+g4xm7sn3Suaz5u007SnhLit1SO42QX5xHOfU8VM3k+taBlzVUTFwGN
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RS9MbWZKNkZxSlVUSVRWWE15MmtBaTlVczBzbGpSRFNYK0wvakJaT2lueXVV?=
 =?utf-8?B?R3BXZC9ONUVjcG1PajhNUUxDK255RFFNRk9LV3c3NmZENjlkWGFnNURkODMy?=
 =?utf-8?B?S0JjMlllbWwwSzI5OGJteWVHam1wdC90ZGlET0VHUjVZalVkUStGc04wNWNj?=
 =?utf-8?B?MG0yNEdlWm9aTzFaNXJGeW82b1htaVZxRTR0dzQyeVRoeXBXUU9nWXB5K1Nt?=
 =?utf-8?B?M1NJU0Vxa01vbXJLNHFPc28rTWlnWlhlZGphSGxvNndMSHcyQ1pMNXpmM3NF?=
 =?utf-8?B?NHl2a3VtZ1VVUWZOSmo2MzRvVEl4Z2RLVWc1cXFRdGllRFlIZnpWRnBuYW9r?=
 =?utf-8?B?RTBKbk1hSVpFQlZsQ1Q0ZzFFQlNuRjYwNWZheVZ2emUwMGx1eGE5amNISFdz?=
 =?utf-8?B?STV3S1dFdGVEcXlyNE9ldy9TODMzcjcrTlkrOFlUN1VNQ0w3c2RJS3QvRVg1?=
 =?utf-8?B?TkJUTXRCeDZSRlRwK2xiQWVnR0hlbTlNT2dHTjA2dWs4L01qekcwanRTNXNs?=
 =?utf-8?B?MzZVbjgwMktqNkY4Ly9RU0Q2RktpSW0wWFR4a3o1UU1nOUhuOGF4Rk42ejNH?=
 =?utf-8?B?T0VqUHk2aEhUWkZPNmFIelpzcE1kU1VaSlhFUzhPT05SQlRIUEhrcys1Zk1m?=
 =?utf-8?B?QW5udDZYMnhMd05Ubm8xWUo1NUtBUisrRlJuVTFyMUM1NXFrdHArQUIxck9G?=
 =?utf-8?B?eGVaNCtoNG9TbmNWcFlFa29OZ1dSTnlYdFpSZXZRRmc2QlRkZnhpcUpRSGtM?=
 =?utf-8?B?OXBzNnZOKzBBYjFOazhGUmRCTzhzeTJlRzI4MHlLM3VxZ0NEak5UM2NXVGk0?=
 =?utf-8?B?TE00SW42VlgvTVA3ektHWXBtazJlUWpPOC9yNUNPNldvY3hLVVlWWlc0M3FU?=
 =?utf-8?B?b1hOekxhNEJvZTJvZkJ4UWYzMm9YcmhPam4vQzZHUVB6U21qSy9oaVNhTWdu?=
 =?utf-8?B?K0lIZTNOWFR2MXRHTk1NVFVVTE5kMC9MNFJJOUs2d1Q2eHhFeUcyb2oxM0Rq?=
 =?utf-8?B?M2RGOXRyR3grT1dpbzFERFp2RjJmaEtmcVkrOUx1SHNON01hUzZUY2NYN1VU?=
 =?utf-8?B?T0M4blpZRlM4OEFlQXpLKzFjQ0cwcENPeTZlelFMTWFFWVZZWkZNRXhVaFNh?=
 =?utf-8?B?TnVtR1RCT2RJZDVEazhrWm13OW1Dc3ZRVzRkWEk1anhEMFgydGZ5Y2lPb3My?=
 =?utf-8?B?Vzl5cUNoS0NkNDlsUm9CdFJzcFJieGUxUnNTMEsrcjhoNUozSFdITUJCY1h3?=
 =?utf-8?B?SHNDU3lSN0hSUmpIblBmMlBWZk5XaFRoUmFsUERtU0JCQk5Jc3JBUVcxOU9F?=
 =?utf-8?B?aDJmWTBwV255VUdyNitGRU0yL1R0RFNXbVRuTU1sMlovZDR2clBWYVc0T0N1?=
 =?utf-8?B?NExhVE4yUXpPM2J6UHlQR3NkUlVKb1VWdjV4WURKUFZEUlVYbjgwaG5aeU5P?=
 =?utf-8?B?MXVTclh1TG44MmtLMGYzYWh0Zy9VYndxdXFaNzcybGMzcjMvcmxqRm5KZ0NK?=
 =?utf-8?B?cXZZN1MrZWJKdWZnR2VhZWZNU1NJMDEvNUtmWk5pMlA5OHF2amlSUXVpMFlu?=
 =?utf-8?B?aGlNeG1wcHphMW5sbHZkSW1GaHFNc2NYNTh5TDVlQTFBU1ZhT0pUVjUvaEc0?=
 =?utf-8?B?OU1ZeEZldHM2UmFZSTVQVEhhU09kS0E9PQ==?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cda2f8de-daa2-4d09-9757-08db9d554a79
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 06:03:05.2704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3319
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/8/14 17:26, Jiri Kosina 写道:
> On Mon, 3 Jul 2023, Riwen Lu wrote:
> 
>> From: Riwen Lu <luriwen@kylinos.cn>
>>
>> The format '%*ph' print up to 64 bytes long as a hex string with ' '
>> sepatator. Usually the size of report descriptor is larger than 64
>> bytes, so consider using print_hex_dump_debug to print out all of it for
>> better debugging.
>>
>> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
>> ---
>>   drivers/hid/i2c-hid/i2c-hid-core.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
>> index efbba0465eef..8e97fc01c852 100644
>> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
>> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
>> @@ -772,7 +772,9 @@ static int i2c_hid_parse(struct hid_device *hid)
>>   		}
>>   	}
>>   
>> -	i2c_hid_dbg(ihid, "Report Descriptor: %*ph\n", rsize, rdesc);
>> +	i2c_hid_dbg(ihid, "Report Descriptor\n");
>> +	print_hex_dump_debug("  ", DUMP_PREFIX_OFFSET, 16, 1,
>> +			rdesc, rsize, false);
> 
> But that would dump it unconditionally, while i2c_hid_dbg() is
> conditional.
> 
Function print_hex_dump_debug() dump messages is as conditional as 
i2c_hid_dbg().

The function i2c_hid_dbg() defines as follows:
#define i2c_hid_dbg(ihid, ...) dev_dbg(&(ihid)->client->dev, __VA_ARGS__)

dev_dbg() depends on the same macro as print_hex_dump_debug().


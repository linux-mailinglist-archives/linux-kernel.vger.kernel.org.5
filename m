Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8547C784C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 23:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442277AbjJLVBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 17:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344156AbjJLVBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 17:01:09 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2056.outbound.protection.outlook.com [40.107.241.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13CE9D;
        Thu, 12 Oct 2023 14:01:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLdPoUbrnWof0Hcr4oRYB3pHZaG/37gJq2ngrwv0x+PvKUZsPRTG26e43u+x5gB4jnMCOIuXMKEzbobEvjv+DWpbCsYvno4xOzIgWpMQkzJIuM28dVQYhMgKlYWLiYV9ku9k9i4S6YQpvErrugT4Nsc7zmVFTjuvQVnUhRkEd0cjfVQXX1RV1q1HEJ5sPiPhIl62lG0Lmv9Nszni48iWBb5GH+oMLv6lQLXTRBLRCVrRKn8bpJvb306n8mgduQcKpBp5wtSlhWgjxwz6hyF4sq2TEKMJdJn9SzzPClQSuDEFw5Hb6GbT9IBIwTmieiUrlPbvDu2ZrtwYOAEhU72glw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeBSR2Lk8RN0AqudQz9fzJa5uFU0XcIb1aME/+sZBqg=;
 b=R3NjJFFWL8f+j6rvmhw6qAxUlIQUJ6P1TGBCqAevUL50RqSFOrh//Q+Z72pugZQ0Sl6wjkCPD16TgaxxVddGqBTWAFb60ayUy5EGr2BErhQt4ACEM7tCbzmveDRUx380xFn51XGox4hZFGFb4y2odCFAJ06im/eM1UcPhOr7YGNljY95BK7dNAuPXQN76R2magzLoQdMIO0FoPrpHahNW1X+8vBW1LjBNZLdR3g5JxE494Oh5mrvf9yEPr8I4qIuv9oTo2wFbkknTD1Zo4dqAj1dH5t2QCBFiFTUIFC1upvDx0j4ZtQFpMFsJZK+f/axUEY/1ej7Oc0uEz8ivb2HnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeBSR2Lk8RN0AqudQz9fzJa5uFU0XcIb1aME/+sZBqg=;
 b=SkG9y3pT1PaqBKEThvUGpGBQFhXTm6m/7f9uAFm9iTUAckMM0fyMXB87+9IMo7o8sE31o74VxhZMsUlkNchJHXTV0qN/bkt5dnncr+bLhRCfAVNPFchrwWqijIvlf82vJJsRvfiG4ifM7lHMCtkvZ2JwwPdMEY2h+lOmRk3fWYQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AM9P193MB1619.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:30d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 21:01:04 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59%3]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 21:01:04 +0000
Message-ID: <da9a9d10-2568-4960-b9f8-9d43cbc1b295@kunbus.com>
Date:   Thu, 12 Oct 2023 23:01:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] serial: core: fix sanitizing check for RTS
 settings
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LinoSanfilippo@gmx.de, Lukas Wunner <lukas@wunner.de>,
        p.rosenberger@kunbus.com, stable@vger.kernel.org
References: <20231011181544.7893-1-l.sanfilippo@kunbus.com>
 <20231011181544.7893-4-l.sanfilippo@kunbus.com>
 <40e4c6b1-e217-2926-a351-bf685a5b775f@linux.intel.com>
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <40e4c6b1-e217-2926-a351-bf685a5b775f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::6) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AM9P193MB1619:EE_
X-MS-Office365-Filtering-Correlation-Id: 31727f27-e1e7-4286-7ad9-08dbcb6658b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 47VqCUhLefPOhWKR8EEGOC94/o4TSlgSOQTEfpa01rmqjfOSRlyVCD/OsP/k+03srFY8GMwY3I6Zk527PRRXb8QtgLnd8OqCb5gSqVRPQev6qudK+b9Unug3N8ePU7puBrgcD8M1eI0Ac43h+lM38ixoz7Q8EViFf2ziCYLH3Eivg2UN6iMf1DX76VRolEGd8d3rEaPgryELV6GKOI0aERYEt+DC8IORMQloZYNlS/Faa3kbQwtQUDCIDgSr7tgub4t8gTbe3GZpVks3AuBTp8ttdcGJ7ynUhyvetJYaKuK/bEC57NawxZgooEAJhjtiYqvmTHDniWGkccyaVqS3B8cyyKIQcZoq6Ncx97u7PkMnNr73UE8s4ZBnXo9xO3Awo10hB4JGHntSKacgrqdquCAyRnG3hyl6KQTIOb+q4Bv+clr9S002XnJ+iYDKej8dmSK2cKisIJfXu4zDlCNZxVRJsmxexDyINUbDRJfGgMeMcIw63vZJ+hNRZm7fctXW2xpuystgq72i8cawbYCPwWDzcwdoedRkX+B57ORJd6AA3bPUIFRKJaJReBx9By+4PewuktbXoZnrhtkNZWozEZD7NGyVpPr6djrUR7O67jT4+NOAiHmxdd4j53vAIoamg1AWxl01W4WhdLmoUs5M1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39840400004)(136003)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(7416002)(2906002)(86362001)(36756003)(31696002)(53546011)(38100700002)(316002)(2616005)(6916009)(41300700001)(54906003)(66476007)(66946007)(66556008)(31686004)(6666004)(6486002)(6506007)(478600001)(6512007)(5660300002)(83380400001)(52116002)(8936002)(8676002)(66574015)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEJ5WHBuRTZDd1pNQnRLMnZKYjE3WmExM01aYWZSWDVvSEwrZEJvdEg1SWJH?=
 =?utf-8?B?c0NkYUZDSWxsT2NNZmRkVEdYYzIvZ01KMEF5dm9VM0p1OXcxLyt2a0U2R3d5?=
 =?utf-8?B?VnZoNEUreFI2MDcxZ2tzdlFVRkh3Y2JxemphMWhJTkJlZzhYb29oZGJVTC9l?=
 =?utf-8?B?Nk9WUVVKRHUvay85b0d2cUlSRzdhTEowanRjWVBBejlJcWNOSXJqcWVhVXJl?=
 =?utf-8?B?ckh0akpZUHhlemk2UWE2UkxUam5PNCtuVTlzZUxmU3ZjOG42NnRzYlM1OUpL?=
 =?utf-8?B?SDAwL0lRQlVLVDZhL1hSeExZK05sOFNIc3dpU3VyMFV6VCt5SHBYVVQ4Z2FY?=
 =?utf-8?B?NEJjQ3FkT3lEYlVWWGszN053WERmVmxFWUkwMjIxNDd5QWVaNmhkdE5GNlZV?=
 =?utf-8?B?SEFQUDBLWTZoNGM5WGVydGE5YnRpalIxVkFkSVA0VlBJVkg1ck9OY1Bici9J?=
 =?utf-8?B?bnFtTElSZXJSWEJKU2s5UFg4QnV4ZGJHbkEvOTJ3THlLNXhDZHkzd1dyTWIx?=
 =?utf-8?B?OVJxTnFYeVhzUVFoNm9qQWRwaVo4bWFwTGhZVG9HaHJzVFo1OXVYV2p1bUsz?=
 =?utf-8?B?UmhoQ01PTWpVU0hXR0ZqWU9aT1BlczZuTGVVYUYzM1h5b0c2bzZhZzZ1UndM?=
 =?utf-8?B?UGVFZGRyUWtGWVV3L0xZb3I0WUlDdVZUM2pydnpNS3F4L3A4UTZMMDNSVTh5?=
 =?utf-8?B?cU93RG5pL2tKZGM2a0p6aFRyekpyR2YzV1pIZUVINmUwSmlwVVRVQnVaWnVu?=
 =?utf-8?B?YUZQbzRQRlVWZ25CUm1aZ0dtU0lJajdZZkhRbnorRmFqRjVlSkdPTXptc2lY?=
 =?utf-8?B?Y1VMVktDZWM1RmRYVjZhN2g1UUpOUFRRZzM3OEdmdi9JZzlRNFpKQ25tbEZs?=
 =?utf-8?B?WnJHMVM2VlJWeXYyamRBc3E3d1doWVFmbm1yc3VEVzA4UjU2UHVVdGVOa2I4?=
 =?utf-8?B?N1A5ajYzZjRxSlIvUlJnR2VEWUx6U0RsSnNPZk9ob2N6TUV1WnkzelJRTXdn?=
 =?utf-8?B?MFdJeWtXZGZtSkNQSkdmUmhtak0rK1QwUkdibXFSWUJlZ0tkc1pWZStyL00w?=
 =?utf-8?B?QWloZzFZblNSRFBHTDB1TzVRSE5vQWxwZzZmZmZYQlBzR1NKS3QreFdRbm1p?=
 =?utf-8?B?SkRMZmZ3SXhZMHJRSWR4bGFTRUJFNjFHNkdRMGVSZnNPVkZlM1BZbURxTSs3?=
 =?utf-8?B?TFJFSCttbmZXVzVqaUd0czNpd0xRUEJScjV5RkdaZWRmbGsvL2d1MDF2NlRV?=
 =?utf-8?B?UVdRclZBWnRaVVowbThtV3AraVFQMmNWUzZGQzVCakJveFpMUlRQUEhnVURa?=
 =?utf-8?B?S0NOQTkvUzVyYUJjZkZiSUdWZFJOWlNRM2RBOUl0aHh0OWR6R09RSlMzRy85?=
 =?utf-8?B?YngrK21YbmJpdmtxTCtEN1dxSjNzVExiWmxTbGNnMUNxdmdlYXFBenZvWHk2?=
 =?utf-8?B?OGlOMVllZjdmRGhhRzJobEVJWlMvblRteGptSDNVZXhLemNGSWJBVU9ibjZC?=
 =?utf-8?B?VnZ0T3RKZzNZOWU0TFhBR3pRNEh4MzlUTGpPYlZLZjVpWEZWcGRnNmFsSUNK?=
 =?utf-8?B?T1BtelMzcFNHRU9mWWlSL3BpZEUvR1EwZ2hUaERGd3hINzdQNTNmM3o4anRp?=
 =?utf-8?B?OEpITDFXV0NpbWhqeUFnd2dDNjVxbkwzdkdGQ1lCMzByVHNURGVjbkxveHdl?=
 =?utf-8?B?QkxMNDhiU3J2dFhlY0YrQStuTzNkbDQ4cm1RTnhiV21qcFoxSkdDSUpQWFYz?=
 =?utf-8?B?TkQrVUFtSTdmdk1xZU4yRGZiZFd4RDd6T1VxdE9JZW4zcUM4bElNQzk3aEVZ?=
 =?utf-8?B?MEdsT0xMUTN2R1hINWNKQTVLV2dUL1Rpd0VFMEdtQmt0a0VlQnFTdEpWNlQ1?=
 =?utf-8?B?TW9SRDNha1IycnFkc3lybHpnYjJEQmdTQ1hOL3NKTFY1Nmx5TVQ0YmJCV0Nt?=
 =?utf-8?B?aldyYjNvWThuVEhnL25XdHM0eFFSQ0dnZC9FY2pCQVZiTG1vMTRjQnNudnF6?=
 =?utf-8?B?VlFHaWZrWmUwVzNwVkI3TG11aCtSRjNybW1iZ0Z6N3BQdjhMVkg5Zmxtdk95?=
 =?utf-8?B?U3RMT1lGUzgxOERHNnRFRjJQWlE3TjVDNUpqSjNyN3hVc2UzZGE3UjNkMkxO?=
 =?utf-8?B?N1R2ZllWSXFtRm42aWJjYXFJenBoQVN6UGEwRVo2SlZzY3hxTFpyU0FhTzZW?=
 =?utf-8?Q?b/KvMdvj6H9idurxVY0kzKcqIwP/sB2Qpw185JJlo8ba?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31727f27-e1e7-4286-7ad9-08dbcb6658b3
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 21:01:04.2456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mGoSCzxgoR32XVim/730bpdUa7uOJxjcHIVub49fUHY9ynd9hYQN54p9QtTyGJSp2xcmT0R2hqUYRScgY0J6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1619
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12.10.23 15:10, Ilpo Järvinen wrote:

> 
> 
> On Wed, 11 Oct 2023, Lino Sanfilippo wrote:
> 
>> Among other things uart_sanitize_serial_rs485() tests the sanity of the RTS
>> settings in a RS485 configuration that has been passed by userspace.
>> If RTS-on-send and RTS-after-send are both set or unset the configuration
>> is adjusted and RTS-after-send is disabled and RTS-on-send enabled.
>>
>> This however makes only sense if both RTS modes are actually supported by
>> the driver.
>>
>> With commit be2e2cb1d281 ("serial: Sanitize rs485_struct") the code does
>> take the driver support into account but only checks if one of both RTS
>> modes are supported. This may lead to the errorneous result of RTS-on-send
>> being set even if only RTS-after-send is supported.
>>
>> Fix this by changing the implemented logic: First clear all unsupported
>> flags in the RS485 configuration, then adjust an invalid RTS setting by
>> taking into account which RTS mode is supported.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: be2e2cb1d281 ("serial: Sanitize rs485_struct")
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>> ---
>>  drivers/tty/serial/serial_core.c | 28 ++++++++++++++++++----------
>>  1 file changed, 18 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
>> index 697c36dc7ec8..f4feebf8200f 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -1370,19 +1370,27 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
>>               return;
>>       }
>>
>> +     rs485->flags &= supported_flags;
>> +
>>       /* Pick sane settings if the user hasn't */
>> -     if ((supported_flags & (SER_RS485_RTS_ON_SEND|SER_RS485_RTS_AFTER_SEND)) &&
>> -         !(rs485->flags & SER_RS485_RTS_ON_SEND) ==
>> +     if (!(rs485->flags & SER_RS485_RTS_ON_SEND) ==
>>           !(rs485->flags & SER_RS485_RTS_AFTER_SEND)) {
>> -             dev_warn_ratelimited(port->dev,
>> -                     "%s (%d): invalid RTS setting, using RTS_ON_SEND instead\n",
>> -                     port->name, port->line);
>> -             rs485->flags |= SER_RS485_RTS_ON_SEND;
>> -             rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
>> -             supported_flags |= SER_RS485_RTS_ON_SEND|SER_RS485_RTS_AFTER_SEND;
>> -     }
>> +             if (supported_flags & SER_RS485_RTS_ON_SEND) {
>> +                     rs485->flags |= SER_RS485_RTS_ON_SEND;
>> +                     rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
>>
>> -     rs485->flags &= supported_flags;
>> +                     dev_warn_ratelimited(port->dev,
>> +                             "%s (%d): invalid RTS setting, using RTS_ON_SEND instead\n",
>> +                             port->name, port->line);
>> +             } else {
>> +                     rs485->flags |= SER_RS485_RTS_AFTER_SEND;
>> +                     rs485->flags &= ~SER_RS485_RTS_ON_SEND;
> 
> So if neither of the flags is supported, what will happen? You might want
> add if after that else?
>

I would consider this a bug in the driver, as at least one of both modes 
has to be supported. If the driver does not have at least one of both flags
set in rs485_supported.flags we could print a warning though. Would you prefer that?

Regards,
Lino

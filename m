Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE08080EF06
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376847AbjLLOlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbjLLOlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:41:37 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26C9D2;
        Tue, 12 Dec 2023 06:41:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkaxGaFWAKAktpLGuEl3QDk2AR/xHvOgEf6vFts8l1KRGvYDcvevyBI/qJ8VKOKE45ZrcPEcAm1XWaz6BEF2I+e3ZHcqYMGOclOH4o+UxUvIL84embyr1wf5btUgo6coFT2eFb3nFPjFFdVgc1KRpzh1QrI4YRAdPK81jwbNVvhGpVUsh7kXQDM5uBJAOKQYXXHBqXO6qR9vwj+T7Wsf5whVhDxr8X60BlcaD7f349HiNlp7yVCK3YuFEpFaHhgkgO+Rae7S1VUToKgYfakd6cHumWo6TpgVnHbNkQsCutPv4UceQpXoiQmEijXy+d9bH9XOf7+VyBY4LVGjyJTJqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9VOjES6Ojt7If4FWnGdWSFQowJINlbf9MgsSBYe6Mk=;
 b=FT3bCCEKvDF4kiZf+MfC1gjJNQFa6TNh90n/4Ft2c+Ggmkf0QkdHHtAqcnUQGSZK7yLSa4V8DPJEMo9ZsYqAzp+4nTFbJRTkrb+jRM13iDFz3b9Feuzz+c/SK3KQac0ywIWEHaTZ4uWk0XOiKH7iW4UI3znuYVUE2vtG70o0wHAPsZ6xI3OueE6DVu4hI+3lMTT4iMBob+zOPB06sJ8mnELnbHlrxabfNRZFnxdYgK0LBoQR13bvoZanXfUS5XeEYGPNdHX3wYv9F4AC9p5qwuYxHxv0XZ7iccC2eTGxB7ORjxTZP7L+yylzYqZPj4uyAxbiGwDrV3BT4GRDOpXFPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9VOjES6Ojt7If4FWnGdWSFQowJINlbf9MgsSBYe6Mk=;
 b=CSsr4jazGOILGcDrfuCPUopW+7WGpwaOkt8598srJninJ0RIknopHIpbDGS+192uWk0EHJDpE6wDYvwfcoshq6LveVt+t2PyiOzCNGLelwfPB8VY6Uuqxu+Lon12lVMXSYflK0mXN66/y4V7ueGNvTUIEnYvPHKC9s2wxeZCq9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB8802.eurprd08.prod.outlook.com (2603:10a6:20b:5bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 14:41:39 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 14:41:39 +0000
Message-ID: <f942ad57-e2e1-4896-83f5-a1acc0805afa@wolfvision.net>
Date:   Tue, 12 Dec 2023 15:41:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] usb: typec: tipd: add function to request firmware
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231207-tps6598x_update-v1-0-dc21b5301d91@wolfvision.net>
 <20231207-tps6598x_update-v1-2-dc21b5301d91@wolfvision.net>
 <ZXMudF++A9/y4TNk@kuha.fi.intel.com>
 <196acb44-fb0d-45b6-a9c3-b5a289a41917@wolfvision.net>
 <ZXhq/IJp9KVCkQYb@kuha.fi.intel.com>
Content-Language: en-US
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <ZXhq/IJp9KVCkQYb@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: FR4P281CA0193.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::17) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS8PR08MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: 1903c4dd-5db7-42b3-05e8-08dbfb20725e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R87y1eNpzvBlx9TfQvhrFauZmPcYX5Q3R3pEmCvAcYmwGX3r0c6X9RFnMqvOKhHwjbvhJ5h03ASlCXZcXmwBqH+o/WacaZm+d7BR3DPbzMEFmm83+vYCpBBCV99UN0ya9ItUjkX8m5Dl6wEg6dN7GRejJhdrM6rKbx8zPC0HFawSQ0WJKTSEMi+FV6UNg94RkZQY5kJhmRPydZtgqX5hshNrneU0sbfCpGrRGy6/yZYpf6tWYgbPTFqHPx9VUYcQc5d2Q2zKDw8+eeCCUWSh8AZtF/6+tXws9TIp3b992zY6sqYCLW2GPOYpCEgM60jCAwiLIjVLsg8iNE10Kmqtybxg7/RTFIzE4WzTRxC3wE4YPE39t7VBO6seBIsMQH4J3EbX+NRjxzZj3dSTlA9jrFrBZLGDQRO8KnFywjv9fct212TgwHdaThVU3Nb85pciYHjjtRhwPtL1roBu2emELJnz1OqO90PpYchCichxlgZ/qC9rRQ2II6uINeyQVDjkRGUgSgunVFmtrGoCBFcj0zixdVx+xaAj/ha/f/XptWgVxut+EG1wZLayQZIwdyNHe2DAoubpMYxg+b8CAgO+f1L9vqEUEncgOA7R5QDWaqf83EZ38BB/pU0Uho66pyPNJH92tejcTSvIXqgo4+jkBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39850400004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(5660300002)(44832011)(2906002)(31686004)(8936002)(8676002)(4326008)(316002)(6916009)(66476007)(66556008)(38100700002)(31696002)(53546011)(6506007)(41300700001)(6666004)(86362001)(45080400002)(66946007)(478600001)(6486002)(83380400001)(2616005)(966005)(36756003)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWdLTXM3Q2xlZXloRGo0V2lONVUrM2UwaHdNcVkrUlh3OG9pdHJoU29xZWVY?=
 =?utf-8?B?RXpndFNZNmZPQ0FjU2lVL1p2NTA2SXVITDhzVjhFQVJ2bGNqQjVFV2cvMWFt?=
 =?utf-8?B?YWtBaTU2UGRQRTRuRmdLQm5hSWtvUTgvdnlwNlU0bDY5K2xkcUNVU0d2eXFv?=
 =?utf-8?B?eHB6ZU45TWIrR0gvYUVia1VJZGRlb08zWEdrUGlGbTBCM0I3TlI5WmsxVGha?=
 =?utf-8?B?UEMvRnM1aG9lL3JyZTc1R0VVcGx6RW9TMDFZWlRKWnBiaExzUGhKVWFwbXJI?=
 =?utf-8?B?RDJ6dloyYlZaYmZQVkZPTkhrQWF6U3I2Wmkwc2YzQ1lpRmpXMHdsQXh2SVVS?=
 =?utf-8?B?MWhxWDlNaklhM25aY1NqTi9FVVVEekZrQWpFNlB1a3JhTVQrQUs3eGlaaGtC?=
 =?utf-8?B?WFE3VCtEUmx3TWNRUWRSUWY0VUdoUFdtb2VxN3ljdDk5T0xtQWlTdlR1MlAw?=
 =?utf-8?B?ZWs0QklWRFkwY09zSW9FUjhJTDZFNkVPUHhCeFBFaityNHZjc1NMcTgyK3RD?=
 =?utf-8?B?N0k1N2VPMFZGVUpZOXorVXhuY0RHQ0NqYWVtVDFGaHZvMEVMUkZCVzRxaGZw?=
 =?utf-8?B?cml3MFhHT3NQSXBlbDdDNFc1S09ETFdRNlJSR3pFb2hTZjRhV1JzbzhMdUR6?=
 =?utf-8?B?TVZmU2o5cW5jaFExN2pkaVVHRXpLK09VZWFCUm5VWG1yL1BVMWVTMGpoVndL?=
 =?utf-8?B?UTJEeHJrYW9oKzY2S29IYzBsTHN2Q3E2Q1NHWDZYRVBCYVZvaCtYNW9BazJ0?=
 =?utf-8?B?Ujd2WUhvNzdsNWxsZWF3bkpOa0IydjVvZGpXclhPeDFGOUQ1dEFxUzYzVEds?=
 =?utf-8?B?T1cyWm11S0M2dCtUQjRBVGhTZjd5R3k0Zy9pd3czNEphUmFaTHliUlQ0Q2JC?=
 =?utf-8?B?dG9lRmlNZ3V5Tmk2WTdWNFMwL0dUbWV6bWtIUUNyK0hLUWhWQ2ZGM3hmTWVw?=
 =?utf-8?B?NnExSE5tdCtqVjF5aWtKRDhZV0M4Ymx3TVhDeWg3OHVCVTlDbHNDSmdsK2hT?=
 =?utf-8?B?c3dIUlVMb05EMDZtM3VncytvbHgyYUhKTkZFenU5KzhFZVVVeG51QnhVVytM?=
 =?utf-8?B?a1Eva3lFdTVaRUJiL0p2NGpRaFhqMDhYMFVrNkx2aUhaajBlN1F1VG5vakph?=
 =?utf-8?B?TjUwZzV1Q0RQbjdCbWtWTEtuck9xWERPS1JNK0NoZmZyeVJXSGhIcGFuczFt?=
 =?utf-8?B?MU4xL1hNbDMvblhkWmliK25jRkFoaTJsYjhKT0JCVHdUN0d1R3ZoZUtLUG1i?=
 =?utf-8?B?dFZNRUN4ejhCM29iRmtqYVdBMGpTa3Q5YXhINE9sbldTTEJxeFF6bXJyZmhO?=
 =?utf-8?B?UUI2ZzZvNUJPcE9IWGUxOGp3WTRBTjlFQ21TcnFaVHNFYTJDRlAxaUZBcmJN?=
 =?utf-8?B?dHA3My9MdUM4azRpVEJrTnZLZkd2V2pWMWppZ0ZnNlplTHFaTUNaQUpYZVg5?=
 =?utf-8?B?L29pcThFQkVTcTg4czF6M1l0SzUxY1lML0ZBMyt3YWFvYnNTOWhBQStaQUpX?=
 =?utf-8?B?aU5UV3lna2pVWDNoVjhUbzRRQ0VzSCtwRjhkNTRFVXdLSmQ2Q1M0VUlRTzl1?=
 =?utf-8?B?L2FrcFJ1YTU1dlBGKytCK0UybC94QnhIQXlPcE5OUk9qRUNhUnNSc040d0o3?=
 =?utf-8?B?ZVVIOWYxZGQyL1BXUDZKZVd0SkxTL002MlVOYlpiZzJ0UzhPMURTR1plL0pm?=
 =?utf-8?B?dzY2eE8yMFJ6bU40TzBobiszVG5Nc0FPOFBFYWtEMmNKTUVUNGYwdm9uNXR3?=
 =?utf-8?B?Q1JPb3hkM2VIZVYwM01jQjlVcmpPdDZZZm9lTkhDeG1RNXBWYVJ5Y0hPNTA2?=
 =?utf-8?B?RmRYN1BYUWd3aHhNY3dBV1h5RjJTR0puL0xLYkdiQnJZdXlwd1g5Zk1WTHIr?=
 =?utf-8?B?SCthTG9wMXYvQTFTNUR2T3N6Y3pYdStOUWlRcGs5MkZtdStBQy9qZVVZdENr?=
 =?utf-8?B?SUZzcE9BMGNSRk8yZ0t3a2JzdVFZVlk2bVBPMXd6LzNKdjFBczJoTVIxM2Ns?=
 =?utf-8?B?REFmay90dkpmekdPU0ZtVndUZXJKdi9iRnhIQUdQTE1tRlpHV04xemF2eVBw?=
 =?utf-8?B?SXo3VCtnN29KSVRuNEY5TGh3Qkw0SlNiWlNkaURPR0Q2dUUrNVRTNjdsMEVy?=
 =?utf-8?B?a2FKbXRnZkVBVFk5Nm9HTGRwempLZHEzVjV6bUxOMnlwbk5FTGpKdElsb1do?=
 =?utf-8?B?OElGZFJINWhnc3k2UVNTTmhOVlFvVDhqVFBBcDFEbzNaR3hKbHFJOEVjc1Ez?=
 =?utf-8?Q?QfzAmBcJ5U81dEQ49lxoPVrRj4rcU1BWdoBnu/t220=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1903c4dd-5db7-42b3-05e8-08dbfb20725e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 14:41:38.1162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVY/LY2Fw1o57xwjvVO0wjbXqE3RZkYe4LfghSvsyUZ09A3iYjFPYy5j+TpinAOH7+OazeLCfIhRUYb8vNVXcrxV6UEQrzLKht5bHgirkbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8802
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.12.23 15:15, Heikki Krogerus wrote:
> Hi,
> 
> On Fri, Dec 08, 2023 at 07:58:52PM +0100, Javier Carrasco wrote:
>> Hi Heikki,
>>
>> On 08.12.23 15:55, Heikki Krogerus wrote:
>>
>>>> +	ret = request_firmware(fw, firmware_name, tps->dev);
>>>> +	if (ret) {
>>>> +		dev_err(tps->dev, "failed to retrieve \"%s\"\n", firmware_name);
>>>> +		/* probe deferring in case the file system is not ready */
>>>> +		return (ret == -ENOENT) ? -EPROBE_DEFER : ret;
>>>
>>> It's more likely that the firmware really isn't available, and it will
>>> never be available in this case. I think there is only one place in
>>> kernel where failing request_firmware() can lead to deferred probe
>>> (drivers/tee/optee/smc_abi.c) and there the code can actually see the
>>> system state - that's actually the condition.
>>>
>>> So just return dev_err_probe() here:
>>>
>>> 	ret = request_firmware(fw, firmware_name, tps->dev);
>>> 	if (ret)
>>>                 return dev_err_probe(tps->dev, ret, "failed to retrieve \"%s\"", firmware_name);
>>>
>> Thank you for your feedback.
>>
>> This solution arose from a real use case: in the system I am using to
>> test the tps65987d, the filesystem is not ready when the probe function
>> is called. If I just return on -ENOENT, the device will never get the
>> update.
> 
> Just like all the other devices that require firmware. This driver is
> no different from the others, and it is also not the only one that
> needs the firmware only in special cases. Just make the firmware part
> of your ramdisk, or build the driver as a module.

I wonder why then there is no general solution that does not force the
driver to be built as a module. If there is none, the documentation
should mention that somehow (sorry if it does, I missed it). Actually a
solution like the one implemented in the driver you mentioned could be
used by any driver that can wait to be updated when the system is
running.

> Are these firmwares available linux-firmware (or are the going to be)?
> https://git.kernel.org/?p=linux/kernel/git/firmware/linux-firmware.git
> 
> thanks,
> 
The firmware (at least for the tps6598x) can be tailored with a TI
specific tool and it depends on the use case, so I suppose making it
public does not make much sense.

Best regards,
Javier Carrasco

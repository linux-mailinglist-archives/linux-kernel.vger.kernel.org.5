Return-Path: <linux-kernel+bounces-26252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E48982DD89
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97BD61F22385
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79C517BB9;
	Mon, 15 Jan 2024 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="KG8rkYtL"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2080.outbound.protection.outlook.com [40.107.13.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175A5171AE;
	Mon, 15 Jan 2024 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UU8B1n7Sbla/Wt2tMYOY1D8bYBRgML52mPkoi0Rd+6g9P559l+0rJBeKHOnYO3iIcwUnKN54aD/LTnb4BcftLv3/zD/oB708ZjYYwRgJQk6X9VeXzve5auEgT1gwzsfzgwyiaS2T8N9h0JuzAjG2+oqduK8ddichVGfj73KO4Sl3LYQxwIKQq1lFE0b0xO29XT5DcReAgrVshmXRpMk4Y59B57Dwm5JKsN2UNXViKkfRoCXDGS3xZgd0Fcpwo4Ccfn8JAy/riMCzZnudWgbTdif3Qhfl9BurD65ber9gxJ+nZo2Hnds7mkAWGDmGbNZLyd3fhgsbt0vY3g19yo2lxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGbHWQpD0mRei5GLbU2coqa5dQy2/7JNUgn7pyeENKM=;
 b=Xzzxy4niU+uvqmV2SDZQzUnCaZZtAzs1d446jjlVEpE2I7jJgI10SNYMHW4IBNJWOPLuDfI8UtArYIdVm8FdMMvnGq/N/EatSVKZSc7ZO7KuUIXL8ePpO5JFPltoTrGyXKQDXhn+rdPgbbzzB/nbaY7mD+ySLXgF3H4XMt3tWrHiPsAur6Hcko3DnY3DGNUfJG/ISbM8aL5fMudMJ8MCSs8+2mRQ08RutJpxKFc9OleTP/NJMk/CwG7hYW/5m+30BmW6bq11+ltE1RRDx9Hx6Zol9nX/lwWglQdA4eg8rIvmsan6aTQsM4v5EjXdEBrieuDbZCc8ZXGuKzCmypllHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGbHWQpD0mRei5GLbU2coqa5dQy2/7JNUgn7pyeENKM=;
 b=KG8rkYtL5rPWy672gYasU0IL4qVjKAY32PzBUXLiYqi4VymtrWp2NnTkL9Xm1jxPIWaOT6X5shlUFIquXY1WkV9h1he4tFHm8TP2OxtacV80LAb+kyReFslqjPB45ofhC2sH3pWdDxi6b4FH1xRL+rur3xA26EtQc1Sls7RT4uk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by GVXPR08MB10542.eurprd08.prod.outlook.com (2603:10a6:150:150::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Mon, 15 Jan
 2024 16:24:29 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 16:24:29 +0000
Message-ID: <b7f76546-9998-43e0-abff-a4e73817dbae@wolfvision.net>
Date: Mon, 15 Jan 2024 17:24:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ASoC: dt-bindings: xmos,xvf3500: add bindings for
 XMOS XVF3500
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
References: <20240115-feature-xvf3500_driver-v1-0-ed9cfb48bb85@wolfvision.net>
 <20240115-feature-xvf3500_driver-v1-2-ed9cfb48bb85@wolfvision.net>
 <333c2986-c7c2-4a46-90cf-b59ae206e55a@linaro.org>
 <96abddcc-fa65-4f27-84fe-2281fe0fcf1c@wolfvision.net>
 <644f7f02-405d-47fb-bc72-4d54e897255f@linaro.org>
 <5db4b898-93d5-446f-bfed-b57847f9967a@wolfvision.net>
 <435f502c-1e1b-4d40-8dcc-34487905d69c@linaro.org>
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <435f502c-1e1b-4d40-8dcc-34487905d69c@linaro.org>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: VI1PR03CA0077.eurprd03.prod.outlook.com
 (2603:10a6:803:50::48) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|GVXPR08MB10542:EE_
X-MS-Office365-Filtering-Correlation-Id: 86446e70-a6d9-4df9-fbb8-08dc15e672a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/Db5KyhSbaWbAOXEx/8OrW8idhfO+H22bsWOHoMILUN1qPmClIdAs8YLrgW9xM6VqW3Ts1Bie4WV8EkzZEztpXFrSHBRHvPcXl2ybGegaoBufFfO9QLoeJY3hY88ALNlLXgDvdsV7C4/hqhL0G3LFQzZPOSM6fO+ga7mrE/N5e8OGoOxDRynuHJeJtBZhrb23qm231maizgVdUj/8zL/EZCekMT9OztyLb/6WhGFnHJ6hKYQce90D2GMDNmlC+W1bCHPNsxRrzCuXa7SIf3bgtEXOg/GXIbN8oF+YtYW97KyAV3hEnnsWAmmiyLk87E+JkLb8Rz42yLQxZZ7M5+UcQ+fdVy/6wwch0s7Gkr4ggrdHnP9eJdAioecT+n0TzD9pWZ7dN/IT1ZZh6lifj+rp9vU1SHMk4Bww28UEC7r31IXTEPCk8CNGmhkW42o7VTYSPhfr87oVLgR/eHRi8Zf92f+k0ZUEaJar27TRyXfPhz17bUvW537Xu4F43Nlhip6FZq4M6gctR1j6ORBKkfkM88KNBOblYPJNfXpG94TfAgVS+d/BtsVf3S4kzyOFGNXlFYspMVqzbvWiIJ5NRYMQ13x2bLRGRcPyrhWcJ3SM2KfL+pzozlaEQIxGuhDE6i5dAK/AX+cKYhPMOUZNTn98w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39850400004)(366004)(346002)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(44832011)(8936002)(8676002)(4326008)(53546011)(2906002)(7416002)(5660300002)(41300700001)(86362001)(31696002)(36756003)(45080400002)(478600001)(2616005)(26005)(6506007)(6512007)(66476007)(316002)(38100700002)(66946007)(66556008)(966005)(6486002)(110136005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVNGWkplWXJCeno0Q3VFN1dJL2U3eDJFV3RqdlYrK2pKMGg1T3FJS3RFNjlB?=
 =?utf-8?B?VEtEM1pMNTlUdFJZWFRyNjJORitTeTRONk5OZXJqb1hUaFBoNFRtZStYMll1?=
 =?utf-8?B?cTNjV1lUR1dEMkVXQ3Z0RlY0R1VDVnBtRW9WbGtOMGJsZ2xqcnhZSVdQUUJy?=
 =?utf-8?B?bUhqRW9jK255M0RwRFhpRVNzOTZna25HTmJNUk1pSjhnQkdVd1YrV1lyVTZ1?=
 =?utf-8?B?TllZcjBDRThma2ZoMWdlSU9WYjBwVVY5Vjd6cmJneWloMDhxKzNEcGFMbHBo?=
 =?utf-8?B?dHFKdVU1VCtxdFhFNzgrRkE2TksxbFRDNGw1NWV2bGhTdlNNeS9FNytrb2Nt?=
 =?utf-8?B?aXduK0VaMW0vQ3dZV2FZSXR1SUtnc1JGMjA5UTdaU2RleENOSFFNNDlWelNi?=
 =?utf-8?B?ZjVGcGJrYnhvRlNWd21YeU0xcWQrUVVRN29KY3NDQkY2YXJFZXE5M1dybjJm?=
 =?utf-8?B?N1FRYi9RRHdCSXcweWhiSEkxUmgzRFEzbGVQdXBlS3R0emJxdDNROFNnYlJQ?=
 =?utf-8?B?dU9yOFBMS1RIOGlkcnBwdnBKZ2drN0ExWUNnYXNoTEZXZCtJTFZEWVduYnp6?=
 =?utf-8?B?aG1rTnQ2VTlibXArWjFnWlJXaGUvaTJXdzhXU01qbzAvVFNZT0YvR3dKbWk4?=
 =?utf-8?B?RWhDczJldkxoY0hUdHZzMWVsWUUwUzdHclVsYXI1cDNJbitIMjQweFJ0LzVk?=
 =?utf-8?B?akRQVjJCM014SzBkc3NFamw4UWdkUXEyaUg1UmtMUStuUzJWQWxFS2hTLzZp?=
 =?utf-8?B?d3hpUDZydzBuNEk2czZzRGFpNWdVZk5wUkZETjhyS2orU3JUYWRjb1FoOTJG?=
 =?utf-8?B?NDBRaGVZeGxOWno1NHlaYWFzRVdicnNydlNYYmNnU0Yxak5iYVJkRWtFR1lh?=
 =?utf-8?B?ODJ3dEZIUEdFQWZyc1ptb2JuOUdQaXBaSTN1V0xUM3lxU05LRkhCbUdrT0JO?=
 =?utf-8?B?SzBWREorSzdHQ01CNEo0N2lVZWJVQnhCYzNxb2RjZ0VTYTB5b2dobGtjK2tv?=
 =?utf-8?B?Umprdi8zd1Z0MGY3c0FvSXpGajJGUXk3NmhROWZCME04SlRPelhMa0RtRXFm?=
 =?utf-8?B?dHZPUG96bmNaVmhBZm9YSjA2N2RmOHNldkZVbmJYOUEycVBSWUtMa2NzMVVC?=
 =?utf-8?B?SUFzVjdacU9WVTErZWhqZnN4T1piazRzVVoxeHFUdHlhSm8zNGY0VFIzSzhm?=
 =?utf-8?B?WDlkbGNRcHRaRkp3aUJLVlBPYXBrTkg1RkhlejhvdXB4UUdwM3EzQlBXbHh4?=
 =?utf-8?B?RUhvYlhPRzhiN1VKUGd3RUhGVnlxR0RQeUFhR0Y5Z2NwZHdwdWNBaXN0YlJx?=
 =?utf-8?B?V1RmWWhBb3h5SmhyazBuYTRialNyTFVXYXFBekxRNlFCV01KaWkyNFBQUllE?=
 =?utf-8?B?dlNXeXZGMHg5SmUrU1VIL1EwYy9qT3ZETHlNZFFMdVN1WFh1c1BQR1hsakgv?=
 =?utf-8?B?RnA2dWRYNy92YWoweERQY3lRTDlpNzRhMnRkVFdhLzE0d1AwcC84MHd3ai9S?=
 =?utf-8?B?cUJFcENkMDZVVEg5a3FKNUkwdFl2czVjekIyeWw1Y2Vaek00RHNDd1Q3S0NK?=
 =?utf-8?B?OHA4VzBzdlF4QklyblNBNGVNbHY4ZlgxNktDMzU3d25yanU5TEtqcjZSK0Jm?=
 =?utf-8?B?TkI2VHBMNHFQNTZVRTRuREphbGpHbmJ1a3VEV2VRZTR5U09OWE5jZW8waGVV?=
 =?utf-8?B?eHg2bEZ6VHJhRWlKS0NvZFhvTVYwZ054NDZuTUx1YUdKbDkzT2psRmwxZEE4?=
 =?utf-8?B?eldQNGFSd0RGQUVERHI0L3hJSlpMYWRLY2hUMXNXTHZ1L3RjZVhiSEZYNzlD?=
 =?utf-8?B?MHdXeE1DMlFneWtJSWtmUFNJZUlpNFFHSllIQnBKTFN5RzV1SzNpRS83N1A2?=
 =?utf-8?B?T1BpeDE0NjUyWXpucUVzcVRZcDZnWDVNbHlwNnpkcU9DN0w2ODB6dVM0UElS?=
 =?utf-8?B?SWNMdHBQRFRQWWRidzlwMDBVaXJ2RHNKWW9FVW95YnpuL09teUZabWg3alNS?=
 =?utf-8?B?L0tHVDZ1RVZPT1lEcWRCakF6Ry9RQ2dKR2l6bWZqRGlnK2M1WVhHSFdLZTRt?=
 =?utf-8?B?cFAyQlBoamplcFlGMHNrbktiVkRUREk1WWZzb2VxTmM4ZUtuQWZzUE96OUVk?=
 =?utf-8?B?UWxjRXdKYjZrTy9XRElOK0tFY1ppQWhIOUdsd3FsaS9wc3hqNU9LTVd6R2pK?=
 =?utf-8?Q?BDwd81YCRYDSmyn2AkhCrbo=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 86446e70-a6d9-4df9-fbb8-08dc15e672a5
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 16:24:29.1460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zH9rlN5IMy0uSGjzuK/veTCLKeGV/48v9seRQRNoLS6UI+z2abhvLXreDUcINjVXttkS5h5V54uWzAAeL0oWyb+4Fr8vSYjO5YQ1w5nBp0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10542


On 15.01.24 17:03, Krzysztof Kozlowski wrote:
> On 15/01/2024 16:59, Javier Carrasco wrote:
>>>> The voice data and any other information can be retrieved directly via
>>>> USB from userspace. Once in normal operation, the device acts as a
>>>> regular "onboard" USB device and the driver does not need to do any
>>>> further management.
>>>
>>> So is this an USB device? If yes, then shouldn't be just auto-discovered
>>> and you add here some bindings for other device? This looks like coding
>>> power sequence not in USB node, but in some other, new node.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> It is an USB device that requires two power supplies and a reset to
>> boot. Afterwards it is auto-discovered and functions normally as a
>> regular USB device. In that sense it works like the onboard USB HUBs:
>>
>> https://github.com/torvalds/linux/blob/master/drivers/usb/misc/onboard_usb_hub.c
>>
>> The onboard USB HUB driver is of course more complex because it has to
>> support other features, but the idea of enabling the power supplies and
>> toggling the reset signal is essentially the same.
>>
> 
> Yeah, about that... so this is not really correct device representation
> for DT. There is no such device as XVF3500 outside of USB bus. There is
> XVF3500 but on USB bus and this should be there. In the past we allowed
> such root-level devices just because we did not have other way to handle
> them. Now we have.
> 
> Best regards,
> Krzysztof
> 

Do you mean that the XVF3500 should not be represented as a platform
device and instead it should turn into an USB device represented as a
node of an USB controller? Something like this (Rockchip SoC):

&usb_host1_xhci {
	...

	xvf3500 {
		...
	};
};

Did I get you right or is that not the correct representation? Thank you
again.

Best regards,
Javier Carrasco



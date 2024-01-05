Return-Path: <linux-kernel+bounces-18294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1E1825B0E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08134B22780
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3174D35F14;
	Fri,  5 Jan 2024 19:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="GekeLV98"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2072.outbound.protection.outlook.com [40.107.13.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3BC35EFA;
	Fri,  5 Jan 2024 19:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvCAojJ/h3sdUhbxz9j/Hrhs/S0MzTuu/r43odsFvU5YkPYJPt8BfOSroyTXw1VR5wndUEkh7FlSALEpVq5LtiRkAy3xS3qPaO0OwlhekpAPy4bSqqpVYWZQPb7bDPjsfoa7LztaMC3fXgRmqKEHwhjiJSQuRV+rUn+PFqMR+EYotyXnmTqQJLAPP2cOz9POEUJhfAOwngU1cxWw92GmLzwXQ3HEMNm65WQHTBiXCRXdPBi6o2xlubBG7BWv/6d69KeHdOzRWAj97ph5smgZG3kdvS+A+x55BE3G0SUqXZPdBvYgd5FcwwDCVMjm/wNmh7+Vlwwcd5ZD2rf4yDjG2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRVDPGwkkQ4fOM8h5y3L1BAMJJ4fHxtb6RFYIwQknqk=;
 b=NK1x+ooAp5GWyQRZPbW7O7oeDO6D+0PDEwwVEwBgYyHkTNVUbZnAw3nuarZK5vBZtGwvuW+tIoLSBja2HoKvhSbCbUsj6rJvdjRuMKn3ulA+H2NSrDfEVV1s8eT7yTx85DYVtabQILDcZZq+2IvwaPhL+cOi3CsQsa3AfjiUyoZZwp77zDf7R+U0SwfcAsldAIsGh0XKYa1cP5QHSbVEWQXJqOdtzaJ8k2HO9QZpH3HkrFd8Kyn222U7jbfGwK6lK/p27YgM0eI8/Mcu3DggwYeOXQltYvVPfOR1R4w75SNPkeCtUGNA08j9Jr0jmqaxtJ16412Q60s6RtoHRsvgag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRVDPGwkkQ4fOM8h5y3L1BAMJJ4fHxtb6RFYIwQknqk=;
 b=GekeLV98CW+gkNhYsx8nIZ58gl/f8LLIenv7DD+3mXXMeQwR20HFL1kT748FEevXQrWTUcIryQ1DLJ4v10NFD6xj0QiIgwo5LCg2kRagGw2KuRzxBKQv0UH+79M2UJyz0CPPOcpD800SYImEUSU6kA1Gm+4SEMakpUSzUXSrvN4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DU0PR08MB8043.eurprd08.prod.outlook.com (2603:10a6:10:3e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Fri, 5 Jan
 2024 19:21:28 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7135.023; Fri, 5 Jan 2024
 19:21:28 +0000
Message-ID: <12ac3718-2c69-4d11-8ea4-b555f2321232@wolfvision.net>
Date: Fri, 5 Jan 2024 20:21:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] Input: touch-overlay - Add touchscreen overlay
 handling
To: Jeff LaBundy <jeff@labundy.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>,
 Bastian Hecht <hechtb@gmail.com>,
 Michael Riesch <michael.riesch@wolfvision.net>,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20230510-feature-ts_virtobj_patch-v6-0-d8a605975153@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v6-2-d8a605975153@wolfvision.net>
 <ZZB9x+0eNL8e+xI3@nixie71>
Content-Language: en-US
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <ZZB9x+0eNL8e+xI3@nixie71>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::7) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DU0PR08MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: 01955407-036f-4ea1-0e3e-08dc0e2383eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rv8TJJ1nPu+/U+YDOF48hGdRDUTeJ5goKewkuVWmxQKfyutvz8WdajGU9xsdtNttR3S6aJOQayxuyNxrAI8QBjkRp038U+EE8AXyfBOzDBrcpo2WIlSw+PiEK3r4SYr3/PM9N0m5D0n7rGy8b4vxUjejXzpC+aCS8KucOfB6D5SjjokTMeMU30Aen8zfPV5uj8nbno0upSPTP999KKn8+UZlFP818kLuswENDEXnkCmlYbka/Yq//ERBgJAzV6icbCb3kINwkzqhVCnu9EXGZkvkYpOPc2mTHN/AE/nvxdbWFtQhudiGTCvpt8OqykUaGCVh0cWTh54MPIvq4ydJwHFhdp7h3ExlFW2YckJ0ZBmKLCqkePTsNKVBYmHO8EnsIw008DKqTmdvtSmuvq3n6uDk6bFG+M6lkH1C0/WMRmfqugsxr8MDpPwcxFjOzte473ocHuPVUVTd0vpgYStuibvtkjrx8m1lhPOr4xh9NKLW5Y4Sqvj9FeroSj0VimL+bDYlS7T6pWH+VFfgkHPYMiwfRMo//+fA24Ong0L4Wq3AJDfHQq3ZA11+JVAstuyWsv0KeSApp3XbyxiDv3KyeZF/sVgCsubPocirE3B2tw9gnJ8iTssvyw1NxfJffTgwUZMfPS3R7b8mWW84hPvP+Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39850400004)(376002)(136003)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(38100700002)(36756003)(31686004)(31696002)(86362001)(53546011)(478600001)(6666004)(8676002)(6486002)(8936002)(4326008)(2616005)(83380400001)(66946007)(66556008)(54906003)(66476007)(6916009)(316002)(6506007)(6512007)(2906002)(41300700001)(44832011)(7416002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVNvT3hkdytkUTZSTUtpcVVXSG1aampoaS9aNXMzaVN2cE92VnlCTk10ZCtq?=
 =?utf-8?B?Wk0zN0xqR3V2TDBOUGczZlJPelFqTk5NcXhqL3ZHMzN2dzJ6cEQ4bG5ualZu?=
 =?utf-8?B?blVrLytPQXhBdU5ZVDZYY1pJUVNDejBRdDdJRE9FVWZLNUhFclNXNGFRTG1i?=
 =?utf-8?B?aUluQ2JNVVZTVU1XSlRHb045ZWNIQk92TXJkcWhTOTRtdzVybnNRTFFodDRH?=
 =?utf-8?B?aXZNc2hva245SU9hcU5jRjJKMEpBTVFWaHIvZjYwWWVCV1lnTERJUFN2WWx1?=
 =?utf-8?B?Q05aZnlpT3Q0YWgvQ0VCOWhvOThiYkxjbm95R1Q0VlJxOGdyRTBvRzFKY0w2?=
 =?utf-8?B?NjU0U0FFaXdCRHBsSkp1YVRQQlNmMEd0ZUVyS1dVREkrYVFtWHhKbnBsSWtm?=
 =?utf-8?B?ektVR3Y5bndsaENkUUhacGJVVGh0UCt6eEd1dHc5REVmdGFSclM3OGNoQlpX?=
 =?utf-8?B?WGlTSEM5akNhbk0xb0g1V095M3hlcXlqVFBzdjlSL0JIK2M5eC9zT2pYTU56?=
 =?utf-8?B?V3ZoV1FtMUUzcXgyeUUrWXQzalZwZnpNRHdkMi9CRTV2OW9lRnNuWkw3NTda?=
 =?utf-8?B?dnpwaUZEdmZCUS8xWkdMYzBBczBOdjhkRkwwOGJneFYyLzA3Vnp2SzNqRWNq?=
 =?utf-8?B?V05VWXBNRzJUKzZPb2NnZmIxcURYeFpqUmFQblJTSFVDakxwa2F3VFRuMzZ2?=
 =?utf-8?B?aXV0aWFkMythbWNIT0o2RGlRWGkzMmoxbyt3bk1LdXVVY3lTL2tUT0hRVHIr?=
 =?utf-8?B?ZG5YLzdNamtrUy95V2xzQUhsM3lZNEM0Q21sY3BrYTRFSTR0RTdHMG82cjlU?=
 =?utf-8?B?L0V6T2tFYWdicTdPQXB4U2Nzc1ppWThFT1ZFVjFIb2s3bHU1WW9HVVo1TFI2?=
 =?utf-8?B?bWlsOEtIREF0c3V5N3cyRGdQdHJJc0psYnI5M0NUYzBZYkRMUXBUaDJlYk1O?=
 =?utf-8?B?N0NqWE1WWjJWNmtqTXhmeFBZRHlaOTR6MjJlQjZnYUxwVUNMcWpSUThZaHds?=
 =?utf-8?B?dThBbFg5eUtvNXJsWDVDTnl5Wm9HeGFBbGQxeWozaWs1eWttNFpkMkdiWFh4?=
 =?utf-8?B?S3lEMWJhZzE3QmUxeTYreUNqZVAvc1BZQnpJNzlheGpKRlllbWpVL0tvdk9t?=
 =?utf-8?B?SXhTRThYVDM3TGlYWFNzNEpTeGxjVDVjajJ5K3JocFpGVzdrZXhJTlN3aDY4?=
 =?utf-8?B?R2cxeFU5YS9ReDlXSy9FT0prWHpBOEs0NCtaeGVWai9HMldObU11RUpRajFk?=
 =?utf-8?B?Y2JIMXlzWTNoVUV6UUUyUnhyVXg5RjhnTHl4UGE3V1hTVWgwWXZkZE5IQlJk?=
 =?utf-8?B?a0d3VURuUml4MkpKeHVtQmptTmxuZGdLWEt5b1B4R0kvVWlERDFQTW45ZEFs?=
 =?utf-8?B?dmNJMkMzMFBtM1pNSkdCblRqWmlka2NFMW1JZlM5aFN2SGQvbDEwekk5Y0FL?=
 =?utf-8?B?T2hFcjdTYzhRaGY4MCtkUjRHbHFkODdkM3V6TElRQXoyVnJMRTdma1c5NkFa?=
 =?utf-8?B?TjgxcmtvL1hmejJZVEpVdDA2YjU4ckp6SlE2UGxqZHlyUURIeDZqZGJta0ZN?=
 =?utf-8?B?QnpiV09BQmw1WXo4WFdYbmUwU3ZPSEFadXl5Q1FCRVh2S04yYlRJZVRvVHZa?=
 =?utf-8?B?cHMvbWFGajNYQkN0N1hVdU5LUXlhbXM4ZWhhYmkrZ1FwZHphbm9nOXUwdTFJ?=
 =?utf-8?B?aHJvMjNpT1BSZFZpaWZiMW55YzZVcW1TZFRJbWo4S1E2a1JCTnFHNUxoOU04?=
 =?utf-8?B?TUNGK0hNbGovVWh5MWl0ajlVVlRCU1I3OENhL1FhZ3UyRE5xTmFNNHpWOVBD?=
 =?utf-8?B?dDZwdHhkSXYzZ3UyZDczVUlQZWlOR2tuRG9RRFdja3I5MEdKcnJaR0VXdWZs?=
 =?utf-8?B?ckMxSy85cE50UHJZa295NEU4RjM4UGdNYzJHTGVUdU9RNXBPazhyWU1IblFZ?=
 =?utf-8?B?S2h0L1loV3pQUEprZDc3WmQrMXozd0tRWGFaWFJXQkJsaTI5QnVBTCtPcVNM?=
 =?utf-8?B?bENxemprV2oyN2RKbndaSVliMXdBSDNOcVJjc08wY3MzQlgraW9JdG5NTEV1?=
 =?utf-8?B?a0djNWw3RWRlZ21YYVRlR2lVVTJ0Z092QTRTSmdER0ZxL3M1V1hSaVNIYlh0?=
 =?utf-8?B?aUQzcmN6R0lPWlJRS2pLR0N6VU9wb2phUGxKWWpKVkh2YkRIL3IxSUZGRFFU?=
 =?utf-8?B?OFd4Tlc2TGlseWJFcjJwZ1B5aWovTUpETloxT0JVUmdwamp4NjdvMFZDbng1?=
 =?utf-8?Q?OM2dSKkL2B/V5Y3w7bNHLtzkaqnsywtSEGlbQG/QsQ=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 01955407-036f-4ea1-0e3e-08dc0e2383eb
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 19:21:28.1169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9NJ/Cadfx0IQiR9PVzt05jb2EA3UnVdM/xp8OABCbeVA+wHlLfSc/8ZfGQ5k650yzx/Rt7oNJ2rszK9hDCL7RYKbJW6XpDg1nrLWpGv3rBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8043

Hi Jeff,

On 30.12.23 21:29, Jeff LaBundy wrote:
> Having reviewed this version in detail, it's clear how the implementation
> imposes this restriction. However, it's not clear why we have to have this
> restriction straight out of the gate; it also breaks the "square doughnut"
> example we discussed in v5, where a button resides inside a touch surface
> which is split into four discrete rectangles that report X/Y coordinates
> relative to the same origin.
> 
> From my naive point of view, a driver should merely pass a contact's ID
> (for HW that can track contacts), coordinates, and pressure. Your helper(s)
> are then responisble for iterating over the list, determining the segment
> in which the coordinates fall, and then reporting the event by way of
> input_report_abs() or input_report_key() based on whether or not a keycode
> is defined.
> 
> I think the problem with that approach is that touchscreen drivers only
> report coordinates when the pressure is nonzero. The process of dropping
> a contact, i.e. button release for some segments, happens inside input-mt
> by virtue of the driver calling input_mt_sync_frame().
> 
> It makes sense now why you are duplicating the contact tracking to a degree
> here. Therefore, it's starting to look more and more like the overlay segment
> handling needs to move into the input-mt core, where much of the information
> you need already exists.
> 
> If we look at input_mt_report_pointer_emulation(), the concept of button
> release is already happening; all we really want to do here is gently
> expand the core to understand that some ranges of coordinates are simply
> quantized to a keycode with binary pressure (i.e. press/release).
> 
> In addition to removing duplicate code as well as the restriction of supporting
> only one X/Y surface, moving overlay support into the input-mt core would
> remove the need to modify each touchscreen driver one at a time with what
> are largely the same nontrivial changes. If we think about it more, the
> touchscreen controller itself is not changing, so the driver really shouldn't
> have to change much either.
> 
> Stated another way, I think it's a better design pattern if we let drivers
> continue to do their job of merely lobbing hardware state to the input
> subsytem via input_mt_slot(), touchscreen_report_pos() and input_mt_sync_frame(),
> then leave it to the input subsystem alone to iterate over the list and
> determine whether some coordinates must be handled differently.
> 
> The main drawback to this approach is that the overlay buttons would need
> to go back to being part of the touchscreen input device as in v1, as opposed
> to giving the driver the flexibility of splitting the buttons and X/Y surfaces
> into two separate input devices.
> 
> When we first discussed this with Peter, we agreed that splitting them into two
> input devices grants the most flexibility, in case user space opts to inhibit
> one but not the other, etc. However since the buttons and X/Y surfaces are all
> part of the same physical substrate, it seems the chances of user space being
> interested in one but not the other are low.
> 
> Furthermore, folding the buttons and X/Y surfaces back into the same input
> device would remove the need for each touchscreen driver to preemptively
> allocate a second input device, but then remove it later as in patch [4/4]
> in case the helpers did not find any buttons.
> 
> What are your thoughts on evolving the approach in this way? It's obviously
> another big change and carries some risk to the core, so I'm curious to hear
> Dmitry's and others' thoughts as well. I appreciate that you've been iterating
> on this for some time, and good is not the enemy of great; therefore, maybe
> a compromise is to move forward with the current approach in support of the
> hardware you have today, then work it into the input-mt core over time. But
> it would be nice to avoid ripping up participating touchscreen drivers twice.
> 
> Thank you for your patience and continued effort. In the meantime, please note
> some minor comments that are independent of this architectural decision.
> 

Thanks again for your thorough reviews and proposals to improve the code.

I am basically open to any solution that improves the quality of the
feature. If I get you right, moving everything to the input-mt core
would hide the overlay stuff from the device drivers (which sounds good)
and a bit of code could be simplified by using the existing infrastructure.

On the other hand, adding this feature to the input-mt core right away
increases the risk of breaking things that many users need. We are
already using this feature in some prototypes since v1 without any issue
so far, but it would be great if it could be tested under different
circumstances (hardware, configurations, etc.) before it goes into the
core, wouldn't it?

I would also like to know what more experienced people think about it,
if we should go all out and add it to the input-mt core now or as you
also suggested, move forward with the current approach and let it
"mature" first. The cost of that would be modifying device driver code
twice, but I suppose that not so many drivers will add this feature in
the next kernel iterations... maybe you? it sounds like that you might
have a use case for it :)

>> +struct button {
>> +	u32 key;
>> +	bool pressed;
>> +	int slot;
>> +};
>> +
>> +struct touch_overlay_segment {
>> +	struct list_head list;
>> +	u32 x_origin;
>> +	u32 y_origin;
>> +	u32 x_size;
>> +	u32 y_size;
>> +	struct button *btn;
> 
> I think you can simply declare the struct itself here as opposed to a pointer to
> one; this would avoid a second call to devm_kzalloc().
> 

That was the other option I mentioned in my reply and I am fine with the
modification you propose.

>> +	if (fwnode_property_present(segment_node, "linux,code")) {
> 
> Instead of walking the device tree twice by calling fwnode_property_present()
> followed by fwnode_property_read_u32(), you can simply check whether the
> latter returns -EINVAL, which indicates the optional property was absent.
> 

Ack.

>> +		segment->btn = devm_kzalloc(dev, sizeof(*segment->btn),
>> +					    GFP_KERNEL);
>> +		if (!segment->btn)
>> +			return -ENOMEM;
>> +


>> +	fwnode_for_each_child_node(overlay, fw_segment) {
>> +		segment = devm_kzalloc(dev, sizeof(*segment), GFP_KERNEL);
>> +		if (!segment) {
>> +			error = -ENOMEM;
>> +			goto put_overlay;
> 
> For this and the below case where you exit the loop early in case of an
> error, you must call fwnode_handle_put(fw_segment) manually. The reference
> count is handled automatically only when the loop iterates and terminates
> naturally.
> 
> Since nothing else happens between the loop and the 'put_overlay' label,
> you can also replace the goto with a break and remove the label altogether.
> 

Ack.

> 
> Kind regards,
> Jeff LaBundy


Thanks and best regards,
Javier Carrasco


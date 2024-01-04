Return-Path: <linux-kernel+bounces-17195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47505824974
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2F251F2342D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD132C697;
	Thu,  4 Jan 2024 20:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="kQP2Ms/d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2053.outbound.protection.outlook.com [40.107.104.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2232C691;
	Thu,  4 Jan 2024 20:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bjq9eRgVQB0ntFPUr259E7WV++aFJhhZSEJ5KFuAh6EUDqVLo4HA4KhgG/0JWVUoPxB3h76Bj/OZpl+kESAOOm+uXQDPEktkUZSj95cZu4mj3kqZ+CMPbDoiR98aIwLgfeuYBcd9Bm2sf0Q6ka3Bg5SOE5pW3ywS1x6gWLT/S5XIlWos3a/MvUz5zUbZpoaTeFSpSMUPpv9+eFM+SYhmyYhYv/MJ6r2C3ycA8+8saB9empYjb1zILx8YcjHr3mvy2ibfYoLq74qx9Y3VbWHNd3x32LZjjUL+8lYdJbUYER76uLvy6amwT/jIy4c4KXsMnA67Nwb4g7A30wLu6VE51w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JGUcjr8VjcXt9VDHdYAgUfJeqPGWYQU1MSpypEyJ/k=;
 b=BuQgOtHi7qa/20xqk863XWtKDd3guo1icvyVMO8BdsZCVfoiXpa+C6zlGtgSx5/8TzHmHSkbXkC2lL++8CtmwEFUqMzJw/tojxGewCM+YaZw04slGv3DNAN3WUJBTRCmXnTU8XIlG3BKfLrmYxtDpjBZBo61exai0Xk4W8YD4We74D99JW/46Kbdbf91E/1VY5Rhu9TRbS3hEvlRg1wIPtJfc2mhQsQIkWpz8TaDyo8FZV7DvUyw1AMHPn0rUYD621TbNzFhs4ei6Psn8s4i4bFIVdn863VDR0+i+5DP1KxsE0hqdOmllQiu1x56+0aoJB9B0tztLqlk+VIsLFZgjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JGUcjr8VjcXt9VDHdYAgUfJeqPGWYQU1MSpypEyJ/k=;
 b=kQP2Ms/dK+GUkP5tQKF9DJHkt6eziXvBSJLMZbWn589FDbNPc14TYHybSrgkNgb9fJ2Z5MwL2MVk65u48EqgXcz62P2v7km+XhZy79SQAt61/QH7YxIMw5yil+U7xghep0FgT+VU4OuKyBNODce/v5FHk8HnAfeFwM44svLCwOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PR3PR08MB5706.eurprd08.prod.outlook.com (2603:10a6:102:80::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 20:15:30 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 20:15:30 +0000
Message-ID: <ee37ec0f-13e8-4eed-a675-94e315de7c15@wolfvision.net>
Date: Thu, 4 Jan 2024 21:15:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] usb: typec: tipd: add patch update support for
 tps6598x
Content-Language: en-US
To: Dhruva Gole <d-gole@ti.com>, Roger Quadros <rogerq@kernel.org>
Cc: Jai Luthra <j-luthra@ti.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, vigneshr@ti.com,
 nm@ti.com
References: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
 <vmngazj6si7xxss7txenezkcukqje2glhvvs7ipdcx3vjiqvlk@ohmmhhhlryws>
 <2nqiaxakx6setx4tzgddnbjadbh7miegz5p6wamsbbiyrfuq3x@un2uxajbswkg>
 <e9e8dd9f-b11b-43fc-8d76-6734dbddb540@kernel.org>
 <20240104185242.tf2fvgf56ehajqd5@dhruva>
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <20240104185242.tf2fvgf56ehajqd5@dhruva>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: FR3P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::9) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PR3PR08MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2d8e65-1d84-4368-f032-08dc0d61e60a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MxiZov/gltidj4MRAin+bIM2l9h9UEgId6tnOE8NVnn8jxspoHiHoA0YrL0ANbMkAAPbvOctVtAJZIHoDjBYlA4sQnV9lxxhgxjERvx/6jujN2K4N9LmJGeyeyU/qLNlHEIC/V3e3rRh8oEkd2oKtorW+CMUeOSG+MTDkBPrFyRtIZkcuGfb18udzVNFyhZKZG9kavZzLjjJW1uuxrnQzA+gTDz84ZBGySeh+yfO0OgyzS51Z8f21IVkvazxJRzmBsc99ObMKQo7MqU4jiJi2HiiaMZCwx3LhDW69BClTA7nEnN6RRA5dEmnZfm04i3FHKv9Ali3Q3duusgyS2FXDgzzxjLXIYWLbutqeAhwO9fXxUf3lO2+WmJaiA6DsA9H19L6rKt7hOTfOn/Udy1215Vu5hCLzH9njQBLBOv7OM0ePq7HHgOIPVyVRIUNc3wfQ6xsmFxZpAlEt/StFndx9KYBacnDC7AGJTpsFYZO5Ia419Dul0qHG69EoHl27/CYqj7anIWPd2BGbGaK+jq+zBniPkFqqBxRrmDo+79qX+9Ag5dLsnLRZOzfi3MEoKc2+MjOr8PB6yXAIE+v8z8RZ4AuHXeKHzTLIu65tKFrHGPY7mTAhsYf79BSNNR22svtrmCcpsfdRo4116FIMuYFPQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39850400004)(366004)(396003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38100700002)(36756003)(31686004)(31696002)(86362001)(6512007)(53546011)(6666004)(966005)(478600001)(6506007)(6486002)(45080400002)(8676002)(44832011)(8936002)(2616005)(66476007)(66946007)(66556008)(316002)(4326008)(110136005)(54906003)(41300700001)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1oySFRBdGZqTkJwd0ttY0ZySVplUUhKazRzSVJ3Y2NtNUZYdUhkRGtWN3FH?=
 =?utf-8?B?aXJ4SXJZMjRwekRTNU9td2J5NUlWeE8rcVhRMG5VMXZuRHNDR2JLeTl1ZldN?=
 =?utf-8?B?UVY1VGhob09jY2lNOHkzWHhubjZJL0dYbjJ6RzcrSHpYUVVGODd3bW9iM0xY?=
 =?utf-8?B?TDlqd0hDelB0NlRKNGdxVHBJNHl5emMzNG9QZlU4NGM4RUtHcTQwNElCRlJy?=
 =?utf-8?B?Nzl3YzMvMGs5eFo5SUsxWWVqZ0o2MzRYdHcwS1NLSTB5VER4WlVGbXdsV1gv?=
 =?utf-8?B?UkFMNWFWdEV5VVhvcXV0ZG5ENXlwbE03NFRSaHZaM1dOb3I0S1U4NFRnVmZF?=
 =?utf-8?B?WHRtcldoak1qaS81d3BrQzVEQmhWanptSldWR1FBMTNOU2g4bTd4QmtLcGtX?=
 =?utf-8?B?NUlkY3NwVFg2R1N5TWJnRC9LSnRGZnNkZ1FqYUk3Q2k4ZTZXRHV3Vi9waFBn?=
 =?utf-8?B?QTBXRE1zZXJUaTlNSkI1eVI4VjNxeWZKbTN0bWlyVXZNK3ZCS01vdUNWQnVB?=
 =?utf-8?B?L0VnUXRPNi9HUWF5TGVGK3UwTjJSUEdtMVNvRmUwMVYvSzAwbFlnc1VqT3M0?=
 =?utf-8?B?M2FpU0ZvN012Y21ma2dGM0NzNE96WnhnWDNiTkQ3NHlXUWh4SDFHVUNxSTh1?=
 =?utf-8?B?MVNBbElnT0JJK0UxTjFZUHg2S0lkRGdJUHh6dlRwdC92LzBTaXdDSFN5d3d4?=
 =?utf-8?B?ZTFkTXpsdDJVc3JWazdTRU4zcG1RYkt6eGpnaDNWak9QelB6Y1NaTHA2dlZW?=
 =?utf-8?B?SGY1aWdMZFgxaStpYXhZcnNra2Q5ejN0blB1aWRjeGlNSndhcXBzeUQydGJJ?=
 =?utf-8?B?d1pFS0N4VDNaRFQ5Q2QzZU8wZ2pIS1A2cGhMaERKNGtuYVhXdTJHT0lhd3hD?=
 =?utf-8?B?a3FDVDV3bDVCaWZtaGFrT0t6TnBmZEZrN0txbmRIRlFSZng2ME0vZVh2czZi?=
 =?utf-8?B?eUdTek5hYjNlWTRaLy9IK1d5UmRQRWhLRjVqSW4vWGNMakgxUEJBVC9pZVR2?=
 =?utf-8?B?bUJvbGNzVWhseDhIM3FYL1ZkSllsUENVV3dSN0Rwb1ZjdGpiZGlrTDFnZEdN?=
 =?utf-8?B?RlVhZTR5QUFobTRGcXpzWm5zTE1mQ05IS2NPSENvNUtsbWttcjFlanlaeDBG?=
 =?utf-8?B?S29OS1NUczRlWmxrMFloVGFTcThKZG85TEJKOFlFeVVBSGE3dHFka0t3ME9R?=
 =?utf-8?B?Um1uSGNmVTk3Mmh2c3A2MDZUQ3FtLzdDNXNsNFpSc0FLdXoyYVUzV0ljRmps?=
 =?utf-8?B?SVNHREx3ZEJwcmovaEpnKy9nUlQ3U2NxeG1DTXRPcjc4VXUvMTV3ZEQxNDUv?=
 =?utf-8?B?eDkwWGJ3MzIrV1hzaWZDRU5mMXA1UTk1NFVsSlREdHg3dnNTWjJ0ZC9ZdWQx?=
 =?utf-8?B?RWV0ZDluRkN0dXQ5S213dHZUM2lFVElRWUZHYWZNQWtPUWErM3hVRkZlNi92?=
 =?utf-8?B?NGtZUStKdWZRTWliWmo3NzAyRlVpR0wzTDVkbzFXdFJEenBTTmlGMUFpNG5D?=
 =?utf-8?B?S1lsK0x5ZUhYMVNHeWNuVUJGTlg5QUN3cCszUjhEaE14WWg4eHJpem5yRGlM?=
 =?utf-8?B?ejZLOTZjRUVKbWtiMGZ0eGs1M3dhT2pObi9DQUhWTU5QQk9xaVhtOXU4VG5Q?=
 =?utf-8?B?UWFoL3hTWXV6TzcwYjNYTTkvNGNEUXNrTHVYRGh4OUFFTXVPa1JZbkgxQU1Y?=
 =?utf-8?B?U1FKTXBLRUJad0JpTmFlVStXenJ6c3pJdXVYVFZjL2RETFIrL1h5R3U2akF3?=
 =?utf-8?B?OVZiSkFpbnMzcEh2MGhRUEkwbGZ3K1FFYzVVRGlFdVRVWlkzOG9nazQvK1V4?=
 =?utf-8?B?L2MrM3duaWtjRUtPZ1ByamQxMEp5U2UxUFFKVFVjdml1NG9TNUNOcDFsT05m?=
 =?utf-8?B?UWdjTjlDalRZTjdvbmFxWFBMZFRFWnNIdURpRWNsQU1rYUg0THBoWEpISnRD?=
 =?utf-8?B?SFg4MEo1QU41S0c0NVNYdjRYQ2JwVld5Zjd4cFhvM0xKQ2hGU1BMeE0xNE15?=
 =?utf-8?B?dlpNZ0hIRjBHRjlvSVVPaUpFUzlDeHRvWGVmWVBPQUhaT09CcWl5TStBRnZB?=
 =?utf-8?B?Snd5c3F5NUdZRnJtUXg2c2RveFNKRmxpMEh4ZEx2c3hIVG9IdVJYZTdDd2tB?=
 =?utf-8?B?RFRDZUdhM0o0Y0ZHZ0crSmRINFl4a2RnQkhNMmxCR3FVZUFucXhhREJzY3hj?=
 =?utf-8?B?Q1dNZGdSem1hSGpLeTN2ekZYQW5JeHRWaWJ4Z3dzTjFPZDBORVpLNm43ZDZT?=
 =?utf-8?Q?Bwq+kPTLqHrcNklKiWlJh8Xcxj3DdgUZ4kTeF6ZjNM=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2d8e65-1d84-4368-f032-08dc0d61e60a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 20:15:30.3714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PybDfI9x36/0+hrEUvA1c592nDl2eZbuBvpQyVeTXyAsa8KrpmjEpmi38AaAx7C3+m0YSFmKqjElYxzc5Dh804P/Eby1OuL23gUQMt8nAs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5706

On 04.01.24 19:52, Dhruva Gole wrote:

> 
> This series also broke boot on TI SK-AM62x [0].
> 

>>
>> This looks like a correct fix to me.
>> Could you please send a proper PATCH with Fixes tag? Thanks!
> 
> Thanks for reviewing this Roger, the same patch above worked for me to
> fix SK-AM62x as well [1].
> 
> [0] https://storage.kernelci.org/next/master/next-20240103/arm64/defconfig/gcc-10/lab-ti/baseline-nfs-am62xx_sk-fs.txt
> [1] https://gist.github.com/DhruvaG2000/326b5d7fab4be95f20cd0aac4125f577
> 
Hi Dhruva,

I am glad that you guys found a fix that quickly.

it seems that you guys work for the device manufacturer (because of your
email addresses), so I was wondering if you could explain (or provide
the documentation) why the tps6598x should not receive the GAID command
and a reset crashes the system. Everything looks exactly the same as for
the tps25750, but in that case there are no complaints from sending a
cold reset.

Thanks again and best regards,
Javier Carrasco


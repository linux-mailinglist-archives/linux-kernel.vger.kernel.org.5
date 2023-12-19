Return-Path: <linux-kernel+bounces-5555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 909B1818C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389A82811D5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E001D54D;
	Tue, 19 Dec 2023 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T5f5sobH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEAD1D549
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ka0HvjXdt7pLjxEKoXX/Fm7IpEenfLYawGbV/lqgqmR1TAlOPbWyaXmYUbVbooszR6KlV0cwyypxTwnCwO+LWxjdRJTgk1a7/ucxvSmaAGKCcqenQLhdwytrvn595bWxBCigLQulH0KXGIMLGo6f0OnrdTTrZ6yiXlDUjV4CH43XWG/gEfX06hukfQI8ljAVrbHEdHnl/0wdia9UNEgTPCP+2RTRRpU4OZkom9CpWDujJ3J//tnxI+DwafpMj6X+hHqKdTVYrV94FgU1ztaLQ8JnMkLjQ4uCCMRtdw00hjSg3L8RGCctElduwXTHXNytNwxTQ5PPwC8EKpXE2EUqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAX56HPx9moxp4aoD2cUEr045acgrzI2wdhcrJJvo1Q=;
 b=BtAfypBFMTeF+MVjsTjFTV917/BLV9bxaH4LHgWMh4w5jpdzhZKF3QM9r3tAhQI38QR6Af475IYz6h7QFXheBs7V8yCIDLJPYXT3/q1RKTj4WlouJcMDVqm4cnaz2LBrbBN7rf596vA5OP/4Gar64sByyRQ3zZaWg4d4A/4P8RhlM4Waefr8JsKKxkqtxiwujrB5UIYd415T6/D931kvFWw6dUm6kdpOB9bUIIN49bEQDVcvnJtWhP+yQj9MvLoNm6Alpo5C1dXNOpsBQ6DDiVUgTDGOWadEZfIkG4IEgVTuqnPS4rSNeQ6Pj6L6dXASfXvQdmMuPlZpE4qXHR7eEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAX56HPx9moxp4aoD2cUEr045acgrzI2wdhcrJJvo1Q=;
 b=T5f5sobHfBsNm33Zy5FSf0nma8EsSzC1jSHo+0RkaU/fAGVMphLTZPvpIf1Qd5VEEu/5PYV8Vtlot3UpJASqTXzFVTC75pICfPzoYPGLuLavGoR4frJMWc4GsqXj2FMsgOKeaWljTMFcnw0iuUlt8Yv54F3z/Mm2lWJfzAJQiuSghLiNHm7LDNoAYGFx0wW4PdBKmyBvs8oFtiqzUD+/TklVDGMLhGu4AWceR+4nGynQCpH9yY0D2Fc4rYie8hY/21+P4WPnOd/3K9zcMsWvCYFJzm6+AEy+GuEGk97AQTC5Ic6XxSZjtz21NjF7YJGmbCZWuxGRQQ/fLtJcBkzKzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DS7PR12MB6046.namprd12.prod.outlook.com (2603:10b6:8:85::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 16:26:47 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 16:26:47 +0000
Message-ID: <6f56726b-8deb-4e67-bdeb-4cfbe56237b0@nvidia.com>
Date: Tue, 19 Dec 2023 18:26:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] nvme: add csi, ms and nuse to sysfs
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20231218165954.29652-1-dwagner@suse.de>
 <ZYDN_G-VP2_pn3kC@kbusch-mbp.dhcp.thefacebook.com>
 <acd4f5b1-b1d7-40e0-ac80-573e2d5cfe85@nvidia.com>
 <ZYG_zlnvfLOJHEJM@kbusch-mbp>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <ZYG_zlnvfLOJHEJM@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0099.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::14) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DS7PR12MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: 98090d25-c3a5-4343-1f9e-08dc00af4c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VVaJ0iO8k3pGRSyyTFsLpENz82lkUq2qYWUShrhzfzm6W1jAwdQfNkB9e6Q04QoCvT7WfzB3y64PCJsoiXLLppRj4qm+IlrXNGO0ZXKcHsSzlcT76u6YiTv30FLYBM808qrqktLdqZfwQt/YA6N5pQ8mWMSgdIYAiqfswTJS/TigQ21Z3W3Bou2uYK6e0pvhsGBw4IQkDObEhs2ojYfkKCpNBIZjFD8MQQw+kL+JS2ihhpP/H9m0hCpS/wzo7Nn42FgXDyXT2SywMiykfCufsWGBx4tlQz6oBiFFXwN1sLGcjlQdSIQXvo3pv7eDUgvTkrEm3Jd5RfYg66ksFuHjQS8RVcbL3DPUIA2ZpUj8i4qCkeXEek7INy/mrMQ1HhU1iLWg4HOtIScpjt4OgrPvg30od03YB5i/DzwBjGAcKTjh0MTpcgAdyVPuvaOQuknA4WeTURLA4evxE+qNCvBl2iuMWEc0UImoKs4uWILvh2UP1VT3nOeuKlXdZyIYBt5j0EOyzJqLLjE/iWJ5lXhOnfftFH5zU32igvjNYdzAvyeAd8TnpgGPhn93Lqe89jBwAmL7fWcAUnERYPzch04cIHtLmh11587YDETVwKG5cMmlnj6EjqkfohrA3M2u1LHFZHYqNx3MiCGk0grye3Y39w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(39860400002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6506007)(6666004)(83380400001)(31696002)(38100700002)(86362001)(41300700001)(5660300002)(6916009)(66476007)(8936002)(8676002)(66556008)(316002)(53546011)(6512007)(66946007)(2616005)(26005)(2906002)(107886003)(6486002)(4326008)(54906003)(478600001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0o3VHI0ODVZYkdENGduSTlleGNEKzd3RnZCcjB1M3g0ZGZiYnphN3pKUFds?=
 =?utf-8?B?UjlqL1h6dHNUeis2ZGJZdnlFMVNzMHJtbmJvYWpzcUF6WmFVTDFQaXlldFVy?=
 =?utf-8?B?WVIrMUcwZmRxMG16TXZXVVFVUjV0M05zZXFZM05XZ0pmaXBGN3NlaDJjcmlW?=
 =?utf-8?B?bUs1bzZBL0d1M3ZCU2luOGZPYldpRHlnLzdML0hnNG9LcTlNci9sTDRiRVlQ?=
 =?utf-8?B?WVFMc2k0SXRkOXJNckRucmRiSHhIMGd2SExIZm1CWnppRzQ2OG1CWnhxelF4?=
 =?utf-8?B?UmlrVGs2WGlIejJ0SEpKdjdudktUa2lzV3pTcG1sRkpvM3dnSEtLc1c0VUZF?=
 =?utf-8?B?dmpYZWhFbFFVK2xBbmNFY2YvaHBhdC9veDVRSEJlcDNSV1k5d25rbUh6MGY1?=
 =?utf-8?B?QXRsYlp1dis1bS84MThZUGpIVWJWUlY0Z0RHS1dJZVBnYy9iaE5zMUpNTWlL?=
 =?utf-8?B?SlYxWWplSGR3aGp4d3BsWlk3WklYUzRlVCtUb08vdHlCSnkwU2FmRkZkSi9Z?=
 =?utf-8?B?dXV1N0ZuZHJOcXdMOEhBa1EvOVhwUmlpV2kwR1pSZGVYakltWFdGL1JrSm40?=
 =?utf-8?B?elJnVjRRUFNyUzVvdHIrcFE5UXB2TUlYa3c1VGJiaFhiMW9rNWkyaEsxMjZS?=
 =?utf-8?B?YUcyYk1rT2ZNYmowQVNkUGxFekJBVm9ZY1prbUpRWmllTmdub3JXZ25EQ3F4?=
 =?utf-8?B?dVpyK1JVemZtYzdRUWhJM2F5QnU4aFRmSUlOZWZrcFMxZ3dWZ2VER3hEYWJU?=
 =?utf-8?B?aEJXYUZmWE5kZDNHWGZ6cEd1K01SWUZUVlhPNXJEbVpIVldUbS9aK1VTN0tK?=
 =?utf-8?B?UWpyWmUweHRwdFBDYUtYclcyQ2JwZXVhQVZjL0ZlbEJTR2wxcWgyd0NwbVQr?=
 =?utf-8?B?SXNhOXdVWk1CbkRFUkNjYTJyTWFNN3Z0cDl2ZC9xWU5aR1I3R2dMdEFGLzBx?=
 =?utf-8?B?bnVPRkUyMExmTHVhQy9vNElhM2FxUy9FZnU2bXcxNHhUMk5xR1FJUVIrZVpo?=
 =?utf-8?B?STN0dHhQbk5SWWdING02Tm54bEJ2NmpVYmRXeURhNmx6UDBYM09sc1F3QzBl?=
 =?utf-8?B?RHgwUGw3ampHemsvTkZwQzhRSTFwdmFVZVFwUStwN0FXR3VPL0ZFc0dMRytM?=
 =?utf-8?B?V05pVTVJYnQ0eFdkUm5seXlsVzdIK2ZuUlZPa2trR29IanNYNm82R3UvaTUw?=
 =?utf-8?B?eHdUQjVDWEJoMUR1K2ZRY1dERW8yTGVGeTdvakQ1a0pmZjhjak0zWmxxYkEy?=
 =?utf-8?B?V2dreDBHMDJTaGZ5RzYyVkhOem5lUmxyU1Z5RlBsQWZmNXZxZktKQWV5RVRZ?=
 =?utf-8?B?djJYYUJqb3V6blBoV0lwMUtXS1RSU2V1L01XMGx5UWdKU1NwZ1dGWUNRVkNm?=
 =?utf-8?B?UC95UFZQeGlTM3l4S2cyWkZrWXc1N3ZwTktMZnVqOWhjYWJmSGpMWHdnRy95?=
 =?utf-8?B?UXJlSGZiOHNwbjJDdEc5UUpGeWZtQWF2ckgwV3I3Y2V0SklLRGhQUXFrWXp2?=
 =?utf-8?B?YU1nVkFNUWFZN3NPWWJFQnVRUThBWERFNVh5NnZoajhRb3hYUmhLaGt6amlT?=
 =?utf-8?B?Y002eDRwaXNCcENQSFIyZlVMMkRFalBKbzJNS0NDcGhVZW1oaFVSbndjUGps?=
 =?utf-8?B?VnQzZWMxZmQ2Wjl6eHRnTFh3cUFXRVNUbWpXM1BPSDROWFh0MUhzOU9oM0JH?=
 =?utf-8?B?US9MTGY4bEZPTXk5RFBLWGp4dmZRMTF5MU53clZBSXk5TXBsYlVkYmFEQXF3?=
 =?utf-8?B?U0U3azh1Z2FkdXp6YTRnNGFSV2NDbHp3QmhCK0ZWUkMrTDY1M3hIbURnYysz?=
 =?utf-8?B?TmdpUUVpd3Azc1FUcVVYVkhuT0RSZGt6QmhJR3NneVdnVlIvKzB6bjVaVlJQ?=
 =?utf-8?B?eGZmTzhNcHFpb0ppL3crWGIwNlFSOVd0WS9ZNFhqeDVGUXQ4cjJIdTg5cUNG?=
 =?utf-8?B?U2lUbGpwNVpBU3BrMGtBNUZIUmVibUx0REtVK0U0SENzZzBHeVFBNVVXRVY0?=
 =?utf-8?B?cmtiQ1RTeDJuWVBjN2FvVjhEd2NaV1JXU2VKZXVObTJIUGViRW13RkorOHNn?=
 =?utf-8?B?T3lDMFlFQnF3QnVyeW1Ib05FTTBuOEZ1R1BxSEE3YU9BcTNaazRPR2QvSmJj?=
 =?utf-8?B?MGVyK3hzN2hWSTFqZ3RMUXBOejlOQjlTemNmZWxlRzYweUU0UWE3ZXVidlo3?=
 =?utf-8?B?bUE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98090d25-c3a5-4343-1f9e-08dc00af4c0c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 16:26:47.6955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S0wpMaJdVjshDFaZ5q9Q3mfFphh2Y8fh7ZmLijfwrf41SqiKpQ7FLj4MQVdObz9HUCekmCvuGgOrAHSLXKx+og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6046



On 19/12/2023 18:07, Keith Busch wrote:
> On Tue, Dec 19, 2023 at 04:42:20PM +0200, Max Gurtovoy wrote:
>> Hi Keith,
>>
>> On 19/12/2023 0:55, Keith Busch wrote:
>>> On Mon, Dec 18, 2023 at 05:59:48PM +0100, Daniel Wagner wrote:
>>>> Rebased on the current nvme/nvme-6.8 branch and added the Review tags. Also
>>>> addressed the printk format issue pointed out by Chaitanya.
>>>
>>> Thanks, added to nvme-6.8.
>>
>> I'm rebasing my fixes to the PI bug (which are not trivial) on top of
>> nvme-6.8 and Daniel's series.
>> I've found that this branch is missing some fixes from the master that I've
>> added manually to local nvme-6.8 branch.
>> When do you plan to rebase the nvme-6.8 on top of master ?
>> It will be helpful, otherwise my patches will not apply cleanly on your
>> branch. :)
> 
> linux-nvme pulls go through Jens' linux-block repo, so we have to be
> based on the appropriate branch from there. We already have some late
> fixes in 6.7 that create minor merge conflicts for our existing 6.8
> branch, so we may provide a reference resolution branch with the pull
> request if conflicts are non-trivial. That might be an option for your
> fixes if you can make them work atop existing nvme-6.8 without the
> conflicting 6.7 changes.
> 
> Sometime after the next merge window opens, Jens will rebase his 6.8
> block tree to Linus', and we usually get a 2nd feature pull request
> within the merge window from that new baseline. That might be an option
> if you want to wait a couple more weeks.

I see. I think that after finishing the latest testing I'll send the 
version on top of nvme-6.8 + my local branch patches I took from 6.7.
We will start the reviewing process and probably will converge in a week 
or two. Then we will see what is the status of the linux-block repo and 
decide how to continue.


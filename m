Return-Path: <linux-kernel+bounces-28820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F4C830361
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 690EFB214F1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FA91BC54;
	Wed, 17 Jan 2024 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="u06Z6ETn"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011004.outbound.protection.outlook.com [52.101.128.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68821B956
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705486676; cv=fail; b=rQRPMI0uXBqi4A3fFFBpfCL8g1D/KMiiCLPrMRfumgxDhS1cqQdww8KtUDoAkFTbh5IEOWau5mJtn8u6ZSGpadT7ipc/OAmJrClqj+KnjBvPj6uQ5hgXJK03jePm5uHklb7GUXhJKQCF0vhmtd6qAuxxNIg6Xpm5M2Em0zYthH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705486676; c=relaxed/simple;
	bh=nR8bYzdTZOsKTBnNhMIqyV/FET22wUw11Bd/c7Ko6ow=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=cY1wIctebeikJ0uDj/fBUtTWoXUyFwSRVtBXzezNOCB9Y8pcn2CQBk5N1FaeXusya5ML9mu8Sc4Tuw+SIxeIWcsFyieK1ToTQ6rGNXzbMCChD85Tcg83hAXGAqfZSlmhTunYE+ihtZL9jkAVswHdCQKmcdoWjohRSEtLui0Uk+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=u06Z6ETn; arc=fail smtp.client-ip=52.101.128.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMzLFfFSwWZYt7Qw0+YaALN9v5sGPupUOpQCAZpFVjQjGEldmSyl6rrc8/PpyY5ltbbGeefrI3i2wDBSuDW1yfEdw+jE8GbbRIt80y+L1hqSaq7j9m5gkL8p1HdtrPaLKPyp2SvbQGojd2XtjCsV5VkGbT7muUm691bRswal/HqhH4yF46zoBdX4FGXqrnftwAbH+aOmNH96pfbnQT+juj5v/iTQGecLtGuWfzTpaErjQcSi5Ty3VOL651X5K7V3rdxNbcO+MAMqJTJZLUFHTz3QM2BXt28B+Gk1KJc3FtyUYpaRDitTBPC+fI7KBxk/eLga3oWuJGqavgt9dO6Tdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvxpNaIlJMqTpsQkuuh3sXRCvDqQTBotcXWI752ns1U=;
 b=grNdb+fDMuckydkuqXqgx3erskigQfU47+CDAU7hHT9qIbwOfx8xXP2/nqKr/UiiDaBg4gRyFXcL2GhWl+nK08jaGQfXQ2F476t1Eeo2gfoJzNCra2my2DvhjgNX1QgV3ges4/7clcNwLvi5nu1rxJKnaqtettGDzIGCTNyrO1QlYC+CvFPIBPwqU6jcA8xfWkJHjBEFhvH9XnxNpCTRQyCNKM36FC2bOx7w1aaYjdQqbUQEkxmgfSRzhFHuv/QPxncvZPnwHWaM5YZL9YrZInwxkji9u0NBuvnCpECnH+zdncNY+6lSmxKPYnfA5BtjGf03uooKNRoVJ5JfPG9EfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvxpNaIlJMqTpsQkuuh3sXRCvDqQTBotcXWI752ns1U=;
 b=u06Z6ETnsiuujjTBIDoEzJW69VYIU2PzM6mSdpQmc9T+MAETXBEWr3NBLTXOg3dRaJQe3YFWjBscJFA+KI5WB8jsDu/UaGkvyh/ftVO009wP5O9Js8JQBDyJZU07jf28XS/1yQEykW0W1CEwOfSvQ747tXNhlTClm4UjOStWdcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from PSAPR02MB4727.apcprd02.prod.outlook.com (2603:1096:301:90::7)
 by SEZPR02MB6955.apcprd02.prod.outlook.com (2603:1096:101:18f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 10:17:50 +0000
Received: from PSAPR02MB4727.apcprd02.prod.outlook.com
 ([fe80::f4:dbf7:9c0c:5388]) by PSAPR02MB4727.apcprd02.prod.outlook.com
 ([fe80::f4:dbf7:9c0c:5388%4]) with mapi id 15.20.7181.027; Wed, 17 Jan 2024
 10:17:50 +0000
Message-ID: <601da6d0-8e22-4e6f-a791-5db9d5ebc793@oppo.com>
Date: Wed, 17 Jan 2024 18:17:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: fix NULL pointer dereference in
 f2fs_submit_page_write()
Content-Language: en-US
To: Wenjie Qi <qwjhust@gmail.com>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, hustqwj@hust.edu.cn,
 linux-f2fs-devel@lists.sourceforge.net, chao@kernel.org
References: <20240116141138.1245-1-qwjhust@gmail.com>
 <CACOAw_yL7fLmjLkK29yEb3hgTqoDO2hntOX5LMHmWjZWWix1ig@mail.gmail.com>
 <CAGFpFsSSg+Xs9TAw8qOadUxj8kYfyc+h3cCu_UJsxXUzMu50vQ@mail.gmail.com>
From: Yongpeng Yang <yangyongpeng1@oppo.com>
In-Reply-To: <CAGFpFsSSg+Xs9TAw8qOadUxj8kYfyc+h3cCu_UJsxXUzMu50vQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0175.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::31) To PSAPR02MB4727.apcprd02.prod.outlook.com
 (2603:1096:301:90::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR02MB4727:EE_|SEZPR02MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ad543d6-36a9-41ba-bfcd-08dc17458f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aDShqMc2uogl9BSeN8OGKwbFjNjVGeGi2lpJ+pOzYaHZM9Zh3muNVOxCnu9YlQpfkN88asIF+COtolH6l56Mz6H/AwbYU0HPxZcYkCQZF4Dd3Bh+8zrQAhSR5Q5pi57jJ0WsisMdXrlZ61mdf9Wc2pwSv49t3pR6jBmD4POAJZLPzOzweLbgzIGN9hZ7ZanPloTzOo1hgdoQSdlFtSvpRPPc0kcJmZ79gzgh8t1y95ivARPx+MxmVLQGPP8vrJ1uex5o2V2J3ukBRJ+7zv85D0+x4AJ1VyrtN8s5VosXEIV1MRw9MUw8GajZt7rQZaibTo/6qj7qU2ZXLHDkYy88otGH9o+eWcTXR0QKTsFnYRcYze7V9J/ks5STjMrR+vfaCXai9cGVTo95c5Cqva3stjWKXJjaw8sylP91t60oK+iHQWm6YARHO6Yqf39wWaKEi3FH8CRggnmaraC9tjUqRDynoiqq4K+COf2McmXXYUMrtFe3yFAkJKKI4dHhLNErmIe1u39w557ETRp55mJ5yJ5B1pjauGVp0b9Yg8uJ+wv9CShw3chiG6J7YFtcb9HH4V4Wt10cJvnxgxOF2W6DLFd1u9RjEv7Ec7PeEb9nuEi46bfgxj5n7N/MNRyjt7oZl+YcVX6rXz6wJoLyb2qPxA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR02MB4727.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(2616005)(26005)(83380400001)(86362001)(31696002)(36756003)(41300700001)(66476007)(5660300002)(66946007)(8676002)(66556008)(4326008)(6506007)(6512007)(8936002)(38100700002)(6916009)(316002)(6486002)(2906002)(966005)(53546011)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEZqTXRHRTFrUFNWMWIvMnpOcXdzeU1RYkMyZGE5b1JUanMvaVI3ZDZIMWda?=
 =?utf-8?B?Ym5ua0c0cGlhNnpqZDQ0TFl1RDN1WGxaamVLVEVPbnRHTExCd2xFenBuMlc5?=
 =?utf-8?B?c3RlOTJRVERFb2VLZ2FQN0dFOG44dTNraDh0cWxlQlhSYmJUb1FVU1lmWlV6?=
 =?utf-8?B?WWZTRUtiNGNxVTM4QldBRDl4SkZDd3Vob2RpdjhSbEJkQXJycTNNclpIRXh2?=
 =?utf-8?B?dlg5MjhtMFUrUHhCVC9CaGdwNWV4NTFoblIwWWpFOGtNRHNuSjRXbVMyZ1VS?=
 =?utf-8?B?MURYTmJFeGlUbGRWbE54NXdlOUdaSm9kQzN1dGN5eXhCbmVWdEl0OVVNbFA1?=
 =?utf-8?B?RzFDMGdYb3JpZ0V1UUpjcldVeStiZllBWGhhdnZRQnVXUExJSlJpWlZiZm1K?=
 =?utf-8?B?czZYU1c5SGFwbjFaYW0vb0gwM0N6cUJpRTdxQVJXL1Y2MXVlRFRnUFAyN0JD?=
 =?utf-8?B?Y3RJT3pYT2xvTkxaOXh2emt3N213OHhXWGNvV2E4cy8rU2kvMEI0OGlGNjAw?=
 =?utf-8?B?WnlhSk1oWTkxSDhocDBQaSsyRzRTMWg4STZkeVc2SHhqcGhES1pzcFU2akhH?=
 =?utf-8?B?Y1BxV2Y2V0Rwai9HZmdyOXlKSktoWGJoNjZXZHhMcWZzRXlsRis1RVRFSjcy?=
 =?utf-8?B?WnAvOFRXclQwb2VhUTdpMGltZWQ4Wm9keGJ3eFVoNGozQUFrWEtSZUpJMC94?=
 =?utf-8?B?cW5tVklZK0RSRUk3UE9DL3NjZmZING1TZ29qakx1OXlNcGY1eklISC95aG80?=
 =?utf-8?B?Rjk2SEY5bExZYk4vM2pBMHVtd2dwQzFjRmR1L1B3UkpwMmJyTVpXdUFUSHR0?=
 =?utf-8?B?N29VUXE4d0Z1cUttemoycFNKVmhDcXhBUjZQak9oRmNlZkd6cmJ2VkJKOUsx?=
 =?utf-8?B?UEVZMzQrMW5tblZWOW5PZTlNSHZBMGFXQStxOC9Kc3k4ekk4bnBkUGp2TXl2?=
 =?utf-8?B?UzlMakhNUlRHUVFHNW8wY2JWNUMrVGs3QVlxZW40RzhiMHEwTHdSSzY0TUE5?=
 =?utf-8?B?eVhBdFE5TG5MQ1BERlFIMS9zeUIyUllZZng0Y29PSmU0Ymc5eENFeW1HTzVT?=
 =?utf-8?B?cGVpbGprbVFNTUNPMk1jVHkzbjY5dUoyTS93SVcySzgrUWpzcms1VEd4MnRx?=
 =?utf-8?B?OElzdFV1TUpGOXpqeWk0QTMrRmNKSWI0UTZBS3pYN1dSaGxldFlnZ3kvWGZI?=
 =?utf-8?B?bmd4L2hpS1ZEckYyWUh0UjZyaUozakk2ZzhpOXNYcGZINCtHNm9CdmpuSjRu?=
 =?utf-8?B?NmlZRWxrc2h4dS9zWWZsOFc1ZXd3c0VyZFZaMW4vdlNvM2JYQms0NjZGbG9G?=
 =?utf-8?B?UGRnUmF2SHJDc1lOMHRROHVRYWN4S0syaW1HeUp4eWxhN1kvNnB1ellCRFN5?=
 =?utf-8?B?akFpamI5azk2Q0d1T04yQncwMytPQTVmWkJMMSsxU3paK1R5Ni9qSy9vUWhJ?=
 =?utf-8?B?RGJuOEpYTW9GWXY2cTZWSWFTMHpNWDhnenEvaUtnSUdxOW5MVEdPYnBxa3Zw?=
 =?utf-8?B?eVFZdWlzdVVkdkhHNmwrN2pZK0hYTWc4UUMyNldMQmt4VG9XQlJraldCTUZy?=
 =?utf-8?B?c2FnanlFTXI4cmE5NnZrZFhvQUxOV0hRQnpsVkVEQkh2ZUs3MU9ISnU1SU9Z?=
 =?utf-8?B?c3pmOWxpOU5VcmF2azR5OUgyNjA5Q0drUGhFR1h1SlN0RndVWGZIdE9uRmVH?=
 =?utf-8?B?d2hoQXFFbmNDd21BSzRVNlJYMmFCcmxCL0Y4aGkvRHBxS0E3RzZrUVpRdlEx?=
 =?utf-8?B?aTNHT2ZDUjY5aTBpd2NUbkV6Y01VdlNORUdrbHgwb2NuMzZhTGh5SjkxSnJC?=
 =?utf-8?B?blhIQThua0IzaktKL3VMM3JKcUFGWGY5TXU4RDNXbERiUHdzeWNyeEhQSUMx?=
 =?utf-8?B?K3d4Rlc2SUEwbk5sdGpkUENEN0MzOTBWbmhXeG9hWEdyZzlMK0ZNaklhZStq?=
 =?utf-8?B?Z25QZTFXOC9JRDM1REdESmZWUE1neXpaUlRHU3JhcjlxdmtRTG1mbjdKekYy?=
 =?utf-8?B?b3NjT2RxZEtLWFBHV0tCNDZpVVFqTi96Yjd6MDZQYWFEeDZhQ2o1dFpxQVRU?=
 =?utf-8?B?am5kNUk0V3Y2UWRQTjdHNy9tOFhLRkRGVDh0UHV0dXNrQmdMMjVpaSt1Skwv?=
 =?utf-8?B?OTVsS3VWbk8zeWtCcXlmc1lsZE04a1dJR2VNVTMxdndJbk9nT2NWNXJQRGI5?=
 =?utf-8?B?Ync9PQ==?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad543d6-36a9-41ba-bfcd-08dc17458f36
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4727.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 10:17:50.4488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfFf0ZPS196+so4YuqKS/fPA6H2PsQ3mO5bZNX4YeNw1jHVkNX4jEf75p1P3XrysuoZ8TsoQnf7X1sHYxa53oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB6955

Hello Wenjie,
This patch does not prevent the simultaneous truth of 
list_empty(&io->io_list), fio->in_list, and is_end_zone_blkaddr(sbi, 
fio->new_blkaddr). NULL pointer dereference error still exists in 
“bio_get(io->bio)”. Is that correct?

On 1/17/2024 9:39 AM, Wenjie Qi wrote:
> Hello Daeho,
> I don't think moving just the "out" label will work.
> If a fio is zone end and in_list = 1, that fio is missed without being judged.
> 
> On Wed, Jan 17, 2024 at 5:58 AM Daeho Jeong <daeho43@gmail.com> wrote:
>>
>> On Tue, Jan 16, 2024 at 6:13 AM Wenjie Qi <qwjhust@gmail.com> wrote:
>>>
>>> BUG: kernel NULL pointer dereference, address: 0000000000000014
>>> RIP: 0010:f2fs_submit_page_write+0x6cf/0x780 [f2fs]
>>> Call Trace:
>>> <TASK>
>>> ? show_regs+0x6e/0x80
>>> ? __die+0x29/0x70
>>> ? page_fault_oops+0x154/0x4a0
>>> ? prb_read_valid+0x20/0x30
>>> ? __irq_work_queue_local+0x39/0xd0
>>> ? irq_work_queue+0x36/0x70
>>> ? do_user_addr_fault+0x314/0x6c0
>>> ? exc_page_fault+0x7d/0x190
>>> ? asm_exc_page_fault+0x2b/0x30
>>> ? f2fs_submit_page_write+0x6cf/0x780 [f2fs]
>>> ? f2fs_submit_page_write+0x736/0x780 [f2fs]
>>> do_write_page+0x50/0x170 [f2fs]
>>> f2fs_outplace_write_data+0x61/0xb0 [f2fs]
>>> f2fs_do_write_data_page+0x3f8/0x660 [f2fs]
>>> f2fs_write_single_data_page+0x5bb/0x7a0 [f2fs]
>>> f2fs_write_cache_pages+0x3da/0xbe0 [f2fs]
>>> ...
>>> It is possible that other threads have added this fio to io->bio
>>> and submitted the io->bio before entering f2fs_submit_page_write().
>>> At this point io->bio = NULL.
>>> If is_end_zone_blkaddr(sbi, fio->new_blkaddr) of this fio is true,
>>> then an NULL pointer dereference error occurs at bio_get(io->bio).
>>> The original code for determining zone end was after "out:",
>>> which would have missed some fio who is zone end. I've moved
>>>   this code before "skip:" to make sure it's done for each fio.
>>>
>>> Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
>>> ---
>>>   fs/f2fs/data.c | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index dce8defdf4c7..4f445906db8b 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -1080,10 +1080,6 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>>>          io->last_block_in_bio = fio->new_blkaddr;
>>>
>>>          trace_f2fs_submit_page_write(fio->page, fio);
>>> -skip:
>>> -       if (fio->in_list)
>>> -               goto next;
>>> -out:
>>>   #ifdef CONFIG_BLK_DEV_ZONED
>>>          if (f2fs_sb_has_blkzoned(sbi) && btype < META &&
>>>                          is_end_zone_blkaddr(sbi, fio->new_blkaddr)) {
>>> @@ -1096,6 +1092,10 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>>>                  __submit_merged_bio(io);
>>>          }
>>>   #endif
>>> +skip:
>>> +       if (fio->in_list)
>>> +               goto next;
>>> +out:
>>
>> How about moving only the "out" label instead of the whole block from
>> "skip" to "out"?
>>
>>>          if (is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN) ||
>>>                                  !f2fs_is_checkpoint_ready(sbi))
>>>                  __submit_merged_bio(io);
>>> --
>>> 2.34.1
>>>
>>>
>>>
>>> _______________________________________________
>>> Linux-f2fs-devel mailing list
>>> Linux-f2fs-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


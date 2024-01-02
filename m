Return-Path: <linux-kernel+bounces-14614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB8A821FA8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306EF1F22C06
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8893F15493;
	Tue,  2 Jan 2024 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="khFIsCR8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3D815480
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVNDkTM9zNeaq2n8k9MfD3YLpwLlqQoM2jbJD0PUuKEoK4alZBRku8lrW72hks2DZUJsnYweeT+xl+ST5pb+Cn/bM8Xq3aL9lp9J/VVY/hKvGbwxBkiLg0mWqUbMhpQzKXu9BIwYI98omyHoLhPvMTSOjCc0WNEW+GmDT1FDfHmzcP87oSmh7mNBEspTqd3xXDj0CoRJr0pJcmzhs9dAvVpwcm69Ci5Xo2hUfr+GjwjGAsAobge9iY1qZXHlTr9jKtXV0mk6K0t+w95B5DGvjPHf9RE8jTRC4RlBVd9LCV/PdYrmCu7tbnYXdyPkfKQYiGn0SuUHJQntSxzAyFAXVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5vQ00LvX7lFUNuYhulFq4RAr247+9t8DvD+EW177wQ=;
 b=jWUyNVN2uaYt4KBVfxKNAdz5dY5MCopfqRaWBkoyaGWVe3XDrUBj8mtnYnyphYYIo1knTt0xfWNeYbfNdQWzSk3Gw08YcPPofIW7xs6fVYd3ilYFCSF/tGe8U89MNvAZwZQGypIdlGp1GT4qeBfCIdnGverQckKx5YW1mhYQCGBf+xCQQE/ismCr3AOpAPHm4hcb+hEZbbx72thoTx51ZIhW6cnuc0VXf3KYk/XByZmiVbAzX8nfG2jfUEGUoKJ+qfXS0LX9pnjnHLFeOo4rF34e/knGMyfwCBMr1coqYvNjEDzXJ01H3JqHaXpNkmA0bMVv/C4a+fB2OSs1DCCgPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5vQ00LvX7lFUNuYhulFq4RAr247+9t8DvD+EW177wQ=;
 b=khFIsCR8KIMF+wK+DNCbIMwEh0W/6MLxYoeGQsBKLJ8Ce5rWpDzhZuqIAZ7yiN1gEj1S2DYNY7a+b2XwPH2Loj4GP3pPrvMP10hS3oJ66Lp2Pnf632BNb5Puzz8MHqtYk/5SfWh00y0f+I4tB+cMhSL8EbFue0HrP1FX5lhNgMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Tue, 2 Jan
 2024 16:47:14 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43%6]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 16:47:14 +0000
Message-ID: <112f5047-5a5e-42cc-90b5-f9c2711fa5db@amd.com>
Date: Tue, 2 Jan 2024 10:47:12 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] virt: sev-guest: Convert to platform remove callback
 returning void
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Dan Williams <dan.j.williams@intel.com>,
 Dionna Glaze <dionnaglaze@google.com>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org
References: <cover.1703596577.git.u.kleine-koenig@pengutronix.de>
 <52826a50250304ab0af14c594009f7b901c2cd31.1703596577.git.u.kleine-koenig@pengutronix.de>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <52826a50250304ab0af14c594009f7b901c2cd31.1703596577.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0029.namprd21.prod.outlook.com
 (2603:10b6:805:106::39) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DM6PR12MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a3e8c0-e858-46ee-5a54-08dc0bb27932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Qg3zEoNfaPejjdBjMR8qRpJ0Y1hgnMQwa+/qmIsTmHvseQB4x5byCyb6tbf78HbiCPgWI93yrzxz86e/3rRYlIrCt0sn1t2EF5ZLdpcXHl+XYG5QKDlX8AO/mF9GiHJdvp9i3C9ast0qrAE04Qqwul1RLoWtxLM78Skw0P6GYWi7No2nMs1K+Zmr3KATwJ0Qi2G9pMi8P1OXdM9zBPoOZdhMRkC2bMl6JG2yBPaAY860BAs64tB8QqlFQgfF4bYFVRCY/wrzvy0eo5yUN2V1pqAL3Rh+dANVDI6Id9YJc7Vno4cl1dvo9RyLGm4AUnnO3XiFZF6s3ZgUekqOttpbn7PFI4YsWbFtAWiC9fnKnzKyj421829vYBumc74p9iSwAXlqIz/PO0P7H3TvzDUQn3qJn/MAQtJIwufPlhTTDUf9Yj+Oq1ymdXnFBJ9WsmRR/dU4skDQPd76TYx9u3TYwWm5ozx7PVPdWQwjVPmhnxyJCnqa+CUxUWd7bcrEekNjV13VCaPmtfHMDqDgrS1yUzbaE+g7ZJ1jXgHGMacRgrFNch4fTUWrOzA6wP6xj8/C6ifAfGhMntng0aBpDynYjYbm6/UdlcbNy4uXbBa2ykIOxCzprXPuAEBYKkXVbKxJfvjXl1dhUqkXyfZLszPONG81q2CsvlfKtJP5oYb8tSDLfvz2rXIDq85WtFjUZBxo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(346002)(396003)(230173577357003)(230273577357003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(4326008)(8676002)(2906002)(8936002)(83380400001)(38100700002)(66574015)(26005)(5660300002)(2616005)(478600001)(6506007)(6486002)(31686004)(6512007)(36756003)(41300700001)(66476007)(66946007)(86362001)(31696002)(66556008)(316002)(53546011)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGt4c0ttWkN0YjczTWdoWDhsRnFGTzN2ZnQveWN1M01rZEwxUE9rakFPMlBR?=
 =?utf-8?B?OXJJZHNvU3hQdmlseU1zVUVVa0tpT1EwTWtBM0k4Mmk3Ym9uVi9IWWxYZGox?=
 =?utf-8?B?V2N6SlRwNG9LeGpnYk1ITlNSZFdoaHNZM3lnQUlXY2xCVVZScHppOTJXOXF0?=
 =?utf-8?B?M0FFVlFPZE9tR0tGMWRuTzBOSkRyQURyL2ZieGVVVFBGS0k4M0kyTTM2V0tm?=
 =?utf-8?B?R1JFNDRMaHJGajFvVStHcTVncEQ5UW9KRk5SYlVXeitqQ2ZPeDVhM3Vob05t?=
 =?utf-8?B?bXNMMzRZcmRwV1pRRDlGWU5URFRaSms5Y2VYaGpYOGg0ejgyVTBVVjdTS0VX?=
 =?utf-8?B?b2p1NEM1eEhNczlTT0pITmlEVnJ6bnVZRElGWFd5WnorZFcvZE9xWkRTY0dh?=
 =?utf-8?B?dkRrY1hLanNlUmpwYkNnelBnc0tpd1FHbEw1dkxlSVZtcjl3Q2pwWVVXakRP?=
 =?utf-8?B?Qm5hYWxXS3plMnpQdFd4WkFVV2RzNitxTHVSWmkrMTRKalR4ZTNnMnF3cGhm?=
 =?utf-8?B?MjdlQ0E0TU1DL1dCV3g2OVIvV1NxSm8xZHBOd3AwaFdQZVV2amFua0lsNCtk?=
 =?utf-8?B?TDJxWjc0T1FFV1VlOWp3VmFnTkNlMHNqaEdYdHBaR3lseXU4TUtEeE9mNTBV?=
 =?utf-8?B?WWx4QmVUbURyYXRxSlJMWWhZejdFZ1g4QmhQUWVTdFFLQ0FJNFFFTlNUZzZj?=
 =?utf-8?B?RFJJZ0loZyszOUMzejVGbWQ0VXhnOE44b2lPTGo1MGpOUDdiSm9wSzRVai9m?=
 =?utf-8?B?NnNHL2lab3J0N21tTnIyQ3hXdlFwZ3VVa1RFeXpEZExXTzF2VkU4MDgvdEdV?=
 =?utf-8?B?dHE2YTRpcGQ1SFJ2cEI2TGFkOUxkZDdNUUp5b0lsZ0k4YlVFSFd6Q2tXMHJs?=
 =?utf-8?B?RGxlSUNNbHR5bTBsUGd3MWQwSGN2RlB5Z1BpZ1MrdnVZcjBlQzhNWmRMM3Qr?=
 =?utf-8?B?cFhDdGRDaEc5d0ROMFU5SHJVMTh5RXV3MGVzZ3drbFhsUzdqWkN4eDREQUtr?=
 =?utf-8?B?QnkzcHFtNzZIN2RiaG91N2NzeFI2VURDMnI5UFN1enZreGxDQ1AvVFl6WEpz?=
 =?utf-8?B?eEJaa1BVaUJvQU1ZdlEwWFBhZWk3S2ZUWGo5aVlpMXRKMHN4aWFXZDZ0ekp3?=
 =?utf-8?B?eFJVbkptcVp5Nm9RRXZwa2xZbEZNWXhTOWFoTVI1Z2tLNGZsYTN6UFVNRWJN?=
 =?utf-8?B?eS9qaFdJM2U0OHVpTXJCcDU4WjlsTkdIOEJzSk55bkE1OXRmMHYwcjZIcmpx?=
 =?utf-8?B?elArTkNjajBnTDdpVlA3V0dIejU3ZkFjUk0vWVptNms0VUZXSEpyRS9IckNJ?=
 =?utf-8?B?eGlab2FSTGN3L1FWci9tc0NNWXVzTnI3aTY0V0xuZElvU3hIekFmdlJvUWcz?=
 =?utf-8?B?dkJORDMrOVpTaHpJZGd3NFFaMUlaOHNVRnY5U1VlZ3ZiYVdSY2VvbkFyUmV0?=
 =?utf-8?B?SjJxSWRvOFFKZ0o3VDVCNC9uWU1OTlB4Q1Ftb0tocEZBMFNBU3h3aUpaUmZ3?=
 =?utf-8?B?Zkd0RXViUXJtSzFLOHRYeS9KTnpmeDdsS21FeFBHRkxQajkwUi9KM0xyQi9E?=
 =?utf-8?B?UW1hUlQ0TzNNbEQ1b1J1M01aYjZrWUdpdWlUZmxIbFpaZEdjS3V4THhaaVg4?=
 =?utf-8?B?N3JmZjZwTE9oaWwrWEpzb2NmNXRTbVZHSHYzT0c1eW5mTmNDemtvOC9uRnRV?=
 =?utf-8?B?UHREa0hzWE82bm1XQ055RC9mVHVFTHRzbnhNQUgzTExpSlJWMVNpQnRLVVJ5?=
 =?utf-8?B?emhWV0c0eDZ5VUxQT2Q4dS95RnIzVXM2RFZ1NVlzcDFmSkNOZXgwTlBaR0E2?=
 =?utf-8?B?N3grd2RweGpCWHp2bVd1WDhDV0RjeEJFcS9oajN4MkloSy8vT0pMMEZjQkp1?=
 =?utf-8?B?dUpOd0ZOVWkzZnhUWE5xZVhRai9mWTFmWmVLeFEvNmYxNzgxT0E1Qnk4Sm9h?=
 =?utf-8?B?R2d3ak80cXF2MUQxWGNVbW55d3BTUmJqZGlnWTd5NXJFQTBvSXRsSjlubXdQ?=
 =?utf-8?B?RGhTN1VzcHFyeEtISkxkWHJmaUhEZHVlMHN5WnBDM0Z5YzhhT1lMaCtEZWpa?=
 =?utf-8?B?UExnOHRMYjkwQUxZMklmVXlIK0NON0hvc05sbHEvRjJ5T2c4ajlPTk50M1hF?=
 =?utf-8?Q?hOa8sx5Ta2ViItGS1fZnmdaBv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a3e8c0-e858-46ee-5a54-08dc0bb27932
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 16:47:14.6710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FikzZoLyIQSrnBXM+GkkvmpXFCLzgmmb81gsDNgcNYOJUtJnrup5L8OSXTSVCpa4wm/q2beJlEJwI4DDw/rXqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202

On 12/26/23 07:28, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   drivers/virt/coco/sev-guest/sev-guest.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index bc564adcf499..87f241825bc3 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -994,7 +994,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
>   	return ret;
>   }
>   
> -static int __exit sev_guest_remove(struct platform_device *pdev)
> +static void __exit sev_guest_remove(struct platform_device *pdev)
>   {
>   	struct snp_guest_dev *snp_dev = platform_get_drvdata(pdev);
>   
> @@ -1003,8 +1003,6 @@ static int __exit sev_guest_remove(struct platform_device *pdev)
>   	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
>   	deinit_crypto(snp_dev->crypto);
>   	misc_deregister(&snp_dev->misc);
> -
> -	return 0;
>   }
>   
>   /*
> @@ -1013,7 +1011,7 @@ static int __exit sev_guest_remove(struct platform_device *pdev)
>    * with the SEV-SNP support, it is named "sev-guest".
>    */
>   static struct platform_driver sev_guest_driver = {
> -	.remove		= __exit_p(sev_guest_remove),
> +	.remove_new	= __exit_p(sev_guest_remove),
>   	.driver		= {
>   		.name = "sev-guest",
>   	},


Return-Path: <linux-kernel+bounces-25710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF5C82D4E1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E8E1C21252
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6141C566E;
	Mon, 15 Jan 2024 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ujl8pTkV"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F470523E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJATULX988nirKflZszwWl5SNHlK1QcYQ5CCMbrIKw6xfYaHn3+nMvi7u/XYijP5z20KNdy3l6PqSQWJIYJiJTsuTIVNfE5TafbfowlUsVMxMHNvIgVKHCRNQr5pVws5J87pq1lZFuw3+zm6wmv1r+yJ2W8mwS9wzEvFQQxgWLu8YImr1fIv0qqBUYaBhSX0k8aWr6UTmOK0njw4JDqGu4U2Qs2U7dq6qs7wD+01tu3NYeGxLkQetqOiA7BVB39h3iCGV6UEqAkD39zpNfIjMK5m109ppnGwF7jEo4BNSkAo6NyOIiqtDj1S5NHi3xS2o8EU6Ck2PhU5VR+W2iNPVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivEGA31K/l8TOtj8/UrjGQ1cpicCMMmM2TC3ux8n3r8=;
 b=RkIPP/D6TPgoaef54L9IQYwhD1/EsN+RMA0+SBOXAuoIUQU7q9rXrqbO1RZByA0GuUcqnfj5zao3D2XD9Qmkw5RAobt7gaFAh0B/6cSrg8galOYrOuQPiNr5S67f402DYBw5B1swcQex2qU73uF6gyCYW/pRa/BrRsE7EV8HbU/EzzbPwEeiOWioTJTss81a7t8BO2ZQD0HJYGR6SHfC7gRouy4nUj1HN8EFCLtElCm9cvkd6ekiumOV8iCvL96Smqb1eqGqiCjuWgiviXHPmtpUdM3tu6TRBksTFvlqVmHcTrHcT/R992BOxTx/FeMhz4flr7jRTXSC2IT4HY0l7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivEGA31K/l8TOtj8/UrjGQ1cpicCMMmM2TC3ux8n3r8=;
 b=Ujl8pTkVQ/S64IySLl5FvVhrNk3o5qaH5qe6v46flQasoLoVAKfKpyVlrFzT0PrOc5h+7MIVhYq7znu1DrJuunuZ0ll2yg8iZRDZ+138RsGS9GS2dOhMPqcPbrTwVN/Kk5IePA1dx/LSWzACltPF90Zlul+7LxikTJuyjMLBtY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by DM4PR12MB7645.namprd12.prod.outlook.com (2603:10b6:8:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 15 Jan
 2024 08:12:54 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7181.018; Mon, 15 Jan 2024
 08:12:54 +0000
Message-ID: <40acc2a6-0619-4cf6-ae0a-7438b07b0967@amd.com>
Date: Mon, 15 Jan 2024 09:12:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: zynq: slcr: fix function prototype kernel-doc
 warnings
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, patches@armlinux.org.uk
References: <20240114051730.16796-1-rdunlap@infradead.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240114051730.16796-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0004.eurprd02.prod.outlook.com
 (2603:10a6:803:14::17) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|DM4PR12MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: e067ca1e-bf55-49f3-c76f-08dc15a1c677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qN1R6dxWqrpecdfzGq4eQvkCFV8ib5DIu/P9nr/E67yIw5oTjUHyMqLNU1rg0ggGWaYNVnbgldElxKBktpf0pMk6M5Vr+olpBSJqQUgbTNAXKEssePVrNSm2AI/fyDzoPlSMAr7qPNuN6cUJ6cKouhNh1vlskTmPGOwSyjT84Fw4xcKegmtvy9BGZPsZYVeWjTFOazBYJpY1Ayf5DKvXaJq6HDxn8ox0c3yk5fyMqyRKRr8rymyyUmCi/7lYk0t4Tsl+Z6VNemOg68lo/19qRN26JZW3JkHi1bPL1ZXJPjSZbUe0Rd587OV/lWmR6weXmge2Qc1RRGRLiT6RhRqfnzMcaP4Gr8Trj7mWqS3eZwbwerLtb+a+CoVX2QJGakDJ3c0g1vXZe9ztGvaFJR2ifMYvQdVrDmVFf/xoa6F6BnXM4kYtcOWVoJdBXnvPlHf14+bhOjjZcXLmoo7N7uVtV8W4ku7PnndE06ivQNFi7CBprrW7F2Nree1VyyubdXIpjuyEkx4uZt4OAzlGBR3weqzCR2qSD0fIdJNJnZVhDqZsGgyHmFJP/3bUmreAmTCVmIVSbGMkrOjo+u6CvJzAc3CsxEWkLeAd/fBXooVxS7lmTP04s2Fm5oTdOz1pueqDR8Ob50szgL0+3Or+WUnPL863oPWXD+ZBY6Hruun683V0w2d2UHqUswyG8qoAJZjs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(230273577357003)(230173577357003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31686004)(83380400001)(66476007)(41300700001)(66556008)(66946007)(86362001)(316002)(36756003)(31696002)(38100700002)(5660300002)(6512007)(2616005)(53546011)(6486002)(478600001)(26005)(2906002)(8676002)(4326008)(44832011)(6666004)(6506007)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGtaOE1PS2l0d0k2Qk1ZOEdTVEw1TXNxcCtxa0gxL2ZGUUZMbi9aRXNxV21H?=
 =?utf-8?B?ZlAyeWdhblB0d0FzT2lPbktKTmhiR2Q0QU9PT29OMlJHZ01hYTNNQ3paMmRq?=
 =?utf-8?B?SGNHVG0wZThJMlN6bFRvWTU0NWErUVN6eHBTWmpZVTlITnM0blZJeFBJVE0x?=
 =?utf-8?B?ZnBkK2I3RGpVWFVSYnRnUHFucEJVZjZaRlh6RWRHc2hoNTAwY0d4V2FZSVhI?=
 =?utf-8?B?QjcrMURSZUFHVGtzaXNwRkNwM1dlTExiUUgzNVZtblhYNks0NTJ4WFA2N3NB?=
 =?utf-8?B?bk5idnpKUVFJWTIvYmlLUHdQWmtZNUk2L2pnamk5cHdkK1VoL1llNjRGbjNh?=
 =?utf-8?B?Ym5SNG5DWGxSalNZRVJRNnRacjlZMzlrakx3L0pkMDdzNFZ4UFQwRjBGYVAv?=
 =?utf-8?B?RFJRRkxiYWw0UlNmZnNFVWltMmhqZ3dQd1VHWXZHc3pIb3ViMG1qMUx6TmZv?=
 =?utf-8?B?Ymc5VFNnaXhBUyttYWxRcHorQlhVc053NU1aRWIxanhIUDdtQVhZV0RzcTVh?=
 =?utf-8?B?QVRJYWtsRmJ6Zngybnd3dFlZQUEyTHdZZ3Q4YXBMVHJQQkVTZnFROXJWM05s?=
 =?utf-8?B?cnJmT1UzK25VNTRCZ0x0dG1JYlNUWVBidGhhd3hiWVpsNmVFeGRVbmIzcDUw?=
 =?utf-8?B?TDY5cXozSVFOZlZ3M0FacHFhY295K3hFS0IyNk9LMXp5clhkNUZrR3J6Y3pi?=
 =?utf-8?B?YmNpUG5EOGtVZUNWSDgrb2R2a0NkczY4NVAySVQvZm54c1hIeE9KV2Q2aGJu?=
 =?utf-8?B?OFFUODVYSUptVDcycnp2Rk9kMkFhRUE2dGJ2YWZNVmJTMXRiSXY5MFp5b3RP?=
 =?utf-8?B?RERndERpQTRHSTduaWZwZ1BOZjd5VTRJQ3F2YXUySEtjbWhuOU9wV1RPV1Rp?=
 =?utf-8?B?bFdhUnRnQkk3aXczZlZFZHNaTkptQTBYdjdyMDErQVV4dEMvcGJwQlhhNzVy?=
 =?utf-8?B?Z0crclVaNk9HTGFObXp0d2xUSno5REVGR010U3c5VnJoY01sT04reEE0UHFp?=
 =?utf-8?B?UjNiUGxiZVBHZldrVDNCbVZBMjcwbTJJbDBhOEJlclQ4SllYNkEzWHkwa0Rh?=
 =?utf-8?B?cEhnZkVVOTdUMHIvbFN1eTBqc0R3RnRwUWcvVHBxZFFjQ0tFSGJiRVpTdGZq?=
 =?utf-8?B?dGRGZ25vcUppcG9rSkZXRzZyT281V1pMWGtQMVV4T01JSm1FMGhpT2JoWG1C?=
 =?utf-8?B?cE1xem51WjdDRXRIR1VoeGNjZ0NUeldoYjBaRnhPcjJsM2ZUQjB2dnU1ZWVV?=
 =?utf-8?B?ZTFIbnl3ZnZ3NGwyeUVWNko0cXdPRHdkTGtoVlNZVDBGY29yMlNGSVNmaTFN?=
 =?utf-8?B?QzJFenhicFNvLzZoTFBwMWw0YkcwbTRGR24ycnQzMDVadm9mUk1FTXhvQ2ZN?=
 =?utf-8?B?cEMyNFNmRGFjK3kvb01NMHFqd2s0alRMRVltWWpqaXlwQkkyY296U0R1V0N0?=
 =?utf-8?B?ZUtZaS9EUUovbC8zZDRXU09JMDVudjJaLzZORVhURGk1ajEveUhHZkUvbWxv?=
 =?utf-8?B?WWhwTEw5alBsb0ZqK0xLRjBWTUFab3ZkRCtNRVpSRlJVcUNwVmZLUFFUeG1I?=
 =?utf-8?B?TTlnUzVtQlVVNTQ5cGFURFg5dElodTQ2Rm1LNGRHWWVTVHdTcmVHb0hCU2pM?=
 =?utf-8?B?ZTBCTVJnVkRob0V0SldyTW9vc0xoTmtUZXNLeGNYa1N6am1EOHBBaUMrY1dW?=
 =?utf-8?B?azBDVTdOZ0w1b3ducU1hdElsY3JVT2VqVHpsVWVCa21mandaOXN3eWQydG5Y?=
 =?utf-8?B?UXY1d1l6L2tDbzgrYVczMW9BTkFlZGdWUlFsRlhMWEhiZWhPSGhUTjdZU0Q0?=
 =?utf-8?B?SUtPcXA4U0F5VkVCMjduTWJUcmFNUG0zRzdiRDZuc052aDJDZWR2OEpJQXdL?=
 =?utf-8?B?SDBBZjNCVnBQUGo2T2RNRkpFdS9sbHpDM1AwdkNOUGg3SHZDT3lhWU5BcXB2?=
 =?utf-8?B?YWNadnJPWlVhRUROWGU5RWk5L2l5Nkp6bGNpLzZHSkFlUjYwa2liZFZDNGI5?=
 =?utf-8?B?R2FZd3Q0M0ZUeXdkVVJ6ZnNLS09VUGNGWjZ5SVlTWkVVKzg0SG9DOHNBZHd6?=
 =?utf-8?B?a0VjclkxdzlzSTF3RVRZRVpVWWxsQ0g1WmFJL3hQd29HTzRmTFZVeWxVd0Qz?=
 =?utf-8?Q?y33G6zshj9OquyRRv/Aom/esc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e067ca1e-bf55-49f3-c76f-08dc15a1c677
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 08:12:54.5653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U12T5K8JOSDvmaNqJUN1GVBlQCvbP2FkYbZlzzjAr+evpy9y8ZWoX4BVPVRJU3qL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7645



On 1/14/24 06:17, Randy Dunlap wrote:
> Use the same name in the function prototype description and the function
> to prevent kernel-doc warnings:
> 
> slcr.c:158: warning: expecting prototype for zynq_slcr_cpu_state(). Prototype was for zynq_slcr_cpu_state_read() instead
> slcr.c:176: warning: expecting prototype for zynq_slcr_cpu_state(). Prototype was for zynq_slcr_cpu_state_write() instead
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: patches@armlinux.org.uk
> ---
> KernelVersion: 0dd3ee31125508cd67f7e717
> 
>   arch/arm/mach-zynq/slcr.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff -- a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
> --- a/arch/arm/mach-zynq/slcr.c
> +++ b/arch/arm/mach-zynq/slcr.c
> @@ -146,7 +146,7 @@ void zynq_slcr_cpu_stop(int cpu)
>   }
>   
>   /**
> - * zynq_slcr_cpu_state - Read/write cpu state
> + * zynq_slcr_cpu_state_read - Read cpu state
>    * @cpu:	cpu number
>    *
>    * SLCR_REBOOT_STATUS save upper 2 bits (31/30 cpu states for cpu0 and cpu1)
> @@ -165,7 +165,7 @@ bool zynq_slcr_cpu_state_read(int cpu)
>   }
>   
>   /**
> - * zynq_slcr_cpu_state - Read/write cpu state
> + * zynq_slcr_cpu_state_write - Write cpu state
>    * @cpu:	cpu number
>    * @die:	cpu state - true if cpu is going to die
>    *


Applied.
Thanks,
Michal


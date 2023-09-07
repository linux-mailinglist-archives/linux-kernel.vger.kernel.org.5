Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48ED7797AE3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242664AbjIGRzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbjIGRzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:55:38 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7462A1FFD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:55:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSt6lM37CIKKuIoo2C5kgemPjqgODg3MZVycGrVcFHMZZSLOuXTZSNw0V4UX9L0zjMHeUEL1Zyf/QCLSKtlcmx+8KjqS0KknzSe81wAHsJP0lY35GnPikCQeYvpLctR89J9TSfA+h3a1rYp2nwUdDIih2otwhlMcI40dh0K3kOkXUp1rofalpRFnVwD3XGcQazlJj7YrB40GL2nhGmylKEudN4nnCBRIr6pawgKcidfPl5shVq+kvXCuLzN3XLh1CJQf4/9IZrDvubxuSi4uWpPxax5YwU1bXVPa7Xqe8Khw6c4Pri+Ro20+CBQLJVtTvdIxgDa45Gm0CzjBRXJBSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YcYoK9lex5zQLin0eYdsemdjywuWTyN/m5NuBo0m7o=;
 b=Kr6/H5iUmT4vPxhkfKDj58wQHoaXne+ie4ow6WNV/DWJvToLXXbD4c3uu+F3JEn8h7rN7hhF6Up12kX6dgPAEgY1q4MzAIyBHKlJ/m00UGWQ2mId2cjGrbJi4Ep8x2pVibh4rwk7ff2UlOACDJ3W8uNbGImZ2KOr9g28FgEvgb73cwIm3Gn5dV/JCapAzRa72lKBEiQAACRbAyOqDSTl3EThgD3pK4j3rVokMDl8ovPnlFVdAbjqO7ExxUGdYsieaxcggcRb1s8eWQW+eZSJBwTnve8taRbAt9F7OArhzQqmrIeeybUPkJYVQrRWrRImte3DTy247dW24b+pJ1KKNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YcYoK9lex5zQLin0eYdsemdjywuWTyN/m5NuBo0m7o=;
 b=QU4WxrJmNGODrEJY2NyCsFxHDJUOsWZKK3PlwyJ67ZE26zKlZXmALAoQQ2ipj3BYIsmA/fm/NoUDgwxO6u1pltvzXeujZ6tLhz9lPJzjKm2acJOeSHcahGVmsSLuPr9DDwHi2owj5zF2AR/iejpq3x/8PaNBik5vKb12U5BQfQg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7)
 by DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 17:54:56 +0000
Received: from BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::266b:49f3:3cba:406d]) by BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::266b:49f3:3cba:406d%4]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 17:54:56 +0000
Message-ID: <da25bef4-7e6e-8e4b-ad9e-96d1c8729095@amd.com>
Date:   Thu, 7 Sep 2023 23:24:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/2] iommu/iova: Manage the depot list size
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, zhangzekun11@huawei.com,
        john.g.garry@oracle.com, jsnitsel@redhat.com,
        "wyes.karny@amd.com vasant.hegde"@amd.com
References: <cover.1692641204.git.robin.murphy@arm.com>
 <4eb00390132b93bbc113bef2205e9df54f888710.1692641204.git.robin.murphy@arm.com>
From:   "Srivastava, Dheeraj Kumar" <dheerajkumar.srivastava@amd.com>
In-Reply-To: <4eb00390132b93bbc113bef2205e9df54f888710.1692641204.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::24) To BN9PR12MB5163.namprd12.prod.outlook.com
 (2603:10b6:408:11c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5163:EE_|DM4PR12MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bf14e35-1408-4d87-9609-08dbafcb8b91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4wbTcCM5l2sGE974ZtsFAer9Ho1UwJEt7gRb/erZOYyWqIwHnQokkg6cCuOgV5QluFfToyumkO8yMhLcGF5mlQaCAUGRxtzCpIBJMyfWANaCPB/8JmlWwmbVyLzyqdCdGk0NEMZLS2oMGGcF0MFCfkAuzC2M3ZA0VZih3iw9DAl2vinIklWfgESe67pH8hDIGgUDWjb7LZqtI2Ol5pAooXEI2EwpSjhGn/611pYNo5LH8xl1slFZCrAXeV2T7nwvN5JcMxtpVGC9BNc+BVy4886rT7CVteQvA0ty6li7TkQoNe697ZSXh+DQpBc5qi0LHWJOXtRhvJBW4NCXz7Fh0CsHimeHb+tyJf4WDiSv1Glo6sONd9y+Ds7wphPpVzfzsIXim7cRuHjQavsdHCzvT1AgP8l2tnGea+sNY7WQpRfdc5kGENZ6ElJSYk9m/+WogPFj8Lf0kGS6r5k5h0cV8Wofn6vuLbr39Y4Hge1coTQOt3PpsDPtgdXejSwMyEfAN6iGa8c1eW/vwNVt4mc5/hh+THEU9o1pkTCFxQC6kC0UiulgtjQjtHloJccR4TJi5TrvsUJq+eqAhuWoBMlrCejhOLh7AeFaQ13+TEQ2SxIMpSA5G3UW9pqSd6Xqa5nsYgbHNUrfR3ScE+oFUMSNHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(136003)(366004)(1800799009)(186009)(451199024)(8676002)(4326008)(8936002)(83380400001)(478600001)(66476007)(66946007)(66556008)(53546011)(6486002)(6512007)(26005)(6506007)(6666004)(45080400002)(41300700001)(30864003)(316002)(2906002)(5660300002)(38100700002)(2616005)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekx0OXBxM2FUQko0anlQZU1tVFd4Y3pENEpRWW4zMUVaemRrUlE5RURTWDNS?=
 =?utf-8?B?K0RZRHVmZTFGVzdQampsOXJuRVNwei91L2dMNW4xYTFBK251OTk2d1d6NDg1?=
 =?utf-8?B?aUxvM2V3dGZ1UzlnV3J3OFZIQUdRTWF3d2FFU1FyOVJNemdNc245WVBlcjRV?=
 =?utf-8?B?NTExOEZ5U0tYUEM1VVQ3WnJ0VzAzaVR6MnBrSmlacDN5TXZjSW16Y2NDMjM1?=
 =?utf-8?B?aHZUN3VXSEM0dEwvNEp3NWVvekI4VGMxUnk5ZTFTUm9ac2FvZlVzWi9BODh4?=
 =?utf-8?B?MExMUFc1MTEyUUp6VnY5bU9Ed0FHbi9EWXlXQ2ZvV1pCNWtMMGMvSDZXdFFS?=
 =?utf-8?B?L1l3NWFwOEFKL2pHZVdhcmd1UUNvVW5RL3U2OTg5ZUZYcDVoSEg4djNEQmZz?=
 =?utf-8?B?RmorSTFnU24ya1hPRVRNRlN4ZFVwdWdZNTgrcjNiTFJYMHA4bis1MTZEY3Ur?=
 =?utf-8?B?aUlzUklNQlQ1OTkwT0RObXRqQW93eGhUaHIxWnc5MUFyTDhWcHRsN1VXRmRl?=
 =?utf-8?B?VTliaVlyOVJRL2pFa2sxK0xCRi85dW5ISjJJOU1HTmJvSnU3eE8wcDdzN0Vq?=
 =?utf-8?B?eG1SSW8vSFFkMkszV2M1VExmYWd1MEplOFRZOURFcWRYSS91Nit4UStxc1Fs?=
 =?utf-8?B?VEJuN2dTNTBpVFZSQytKbGNjNHA1WlI4Vk9KREFKUmxxdCtGeHFRVUNLZmZF?=
 =?utf-8?B?MlRvZSsrZUxaYUw3aHFYdW1Ncm9HSkpIbm1BOEk4QWZRZnFHVTNwR3pzcEJj?=
 =?utf-8?B?R3JqN3RGZHBkTVFTazNLR2JMK1U2ZFhYUUhSTlZlaCtlbUVDYWtiR0pTc0ov?=
 =?utf-8?B?WkIvWk4wOEttZHdKdEtoWnYyRitkVGpSeTNFV0lqN1BzVW96OEloYUVVejFy?=
 =?utf-8?B?OCtkQ3p3TlhOTGl2OUVHSXB1bHNXY3dqUWR3ZENHdGZ0Nys2RXZlRi9VRmdp?=
 =?utf-8?B?MnViYTlzd2tndVBxdkVoOHBnbkNTdWVHZEFjeitIM0hYMVI4eDJ5TmRMZ0RG?=
 =?utf-8?B?YmhjM3JSZ1ZUQmN5NnpVZ1hsSkhreUJYQUNlOVZ0aFhicHNxUnZ2YkdreHMv?=
 =?utf-8?B?KzVCUk40UUd3STVORzJGUHNQUW5pYnVBMXZYS01KUEM4SG5jdlpEZ0RWalBO?=
 =?utf-8?B?V0UyWjBpdUJzbjJCMVVFek9WcTd4MHBBKzhkRlJ5cndVelFMeUJtMDgrL3lD?=
 =?utf-8?B?aHRYeGowc2JKZHZPTUJkVEUxN2NYcXVyYkZRb2hObjdnZjcvMTFQaUNLY0FV?=
 =?utf-8?B?Y1Z0UEUwaXhOV1FQRG5NTjNwdXIydEJiQzNJRUxKZVV0VFhwZHcyejdzYnpo?=
 =?utf-8?B?WGVYN0R0NWlOdmtKdHo4VnBrSDV0N0RPdWNUMnUwWjhLT3lTN0Z6UWk5TUY4?=
 =?utf-8?B?UjhaUDI3a0V0YmtYZlVYanFKU0U3enZ2WUtwNzNtRHpEZnJ2dDlmRU40TS9t?=
 =?utf-8?B?UXNoZHhpeTZycnM2V3gyMjBwSlNVUHB2VE5pdVM0b3JHekEyVDBBaDZTcWF6?=
 =?utf-8?B?Mk1wOXJMVkFrYUlsSVY3UVpMOXJoM3F2UUpVeFZIM0FEbk9TZGZMb0xZcXpk?=
 =?utf-8?B?MDRhY3Vnc3FweEY5YUlhT0FWVURDWmhKbVJiOTBvR1pkRnpiYlYrR1dqM0Rr?=
 =?utf-8?B?bE9McGxkR0RISHBqSk1pWGQ5MjRDTTVlU1Y1L2RXeGtJTWVWbUtuaHhaTDIx?=
 =?utf-8?B?QS9odGJvRElOREF3dVdpdVdCSGYvblZTZnM2a091NlJmQ1R0KzBCYkJXa0FN?=
 =?utf-8?B?a3FvcXRRSXVrTWdEVlg2TGs0Tk1lR0JrUVpvcVlTSkZDcGxlckJsZjFINEdX?=
 =?utf-8?B?ZExtenl0dWR3cVdBWUdTb3FRRSsydFRTNGVkWUJXc3Vrcmt5Wi9KTUNsamQ5?=
 =?utf-8?B?cVYzRHZEZy9wZlNzeCsyZml1UTl5dkg2OU8yU2ZUNmlLbVhvY3Q2Zjd4YzB0?=
 =?utf-8?B?NHh0ZkxQUloxbHh6TmRUcnN2dkpWZ2IvLzE2TDFJUk0vdzBqNDdiS1E4Smc0?=
 =?utf-8?B?NmlFand1NWJKaDBvMjUzK2RlemdIaENWL3RRTjNHUi9VZWd5UXBHTDQ1WitB?=
 =?utf-8?B?eDhybnhDQmhZM2E5ZjZlSkVXNEdXTHRtbXAwNWlVSUFjZ0tMcFp5c1J1NEFj?=
 =?utf-8?Q?jRyn52EGaNr9GlgzB98pv1GZA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf14e35-1408-4d87-9609-08dbafcb8b91
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 17:54:56.3311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +2JHzBZQpHfcXX+wf+pZpo6uwv/++l8cpVjDYxrLaJpeVJR1YUBdHgEsPo+UVleWO7WQ6blcOm1XEuEMf0sABw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7742
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 8/21/2023 11:52 PM, Robin Murphy wrote:
> Automatically scaling the depot up to suit the peak capacity of a
> workload is all well and good, but it would be nice to have a way to
> scale it back down again if the workload changes. To that end, add
> backround reclaim that will gradually free surplus magazines if the
> depot size remains above a reasonable threshold for long enough.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v2: fix reschedule delay typo
> 
>   drivers/iommu/iova.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index dd2309e9a6c5..436f42855c29 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -11,6 +11,7 @@
>   #include <linux/smp.h>
>   #include <linux/bitops.h>
>   #include <linux/cpu.h>
> +#include <linux/workqueue.h>
>   
>   /* The anchor node sits above the top of the usable address space */
>   #define IOVA_ANCHOR	~0UL
> @@ -627,6 +628,8 @@ EXPORT_SYMBOL_GPL(reserve_iova);
>    */
>   #define IOVA_MAG_SIZE 127
>   
> +#define IOVA_DEPOT_DELAY msecs_to_jiffies(100)
> +
>   struct iova_magazine {
>   	union {
>   		unsigned long size;
> @@ -644,8 +647,11 @@ struct iova_cpu_rcache {
>   
>   struct iova_rcache {
>   	spinlock_t lock;
> +	unsigned int depot_size;
>   	struct iova_magazine *depot;
>   	struct iova_cpu_rcache __percpu *cpu_rcaches;
> +	struct iova_domain *iovad;
> +	struct delayed_work work;
>   };
>   
>   static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
> @@ -726,6 +732,7 @@ static struct iova_magazine *iova_depot_pop(struct iova_rcache *rcache)
>   
>   	rcache->depot = mag->next;
>   	mag->size = IOVA_MAG_SIZE;
> +	rcache->depot_size--;
>   	return mag;
>   }
>   
> @@ -733,6 +740,24 @@ static void iova_depot_push(struct iova_rcache *rcache, struct iova_magazine *ma
>   {
>   	mag->next = rcache->depot;
>   	rcache->depot = mag;
> +	rcache->depot_size++;
> +}
> +
> +static void iova_depot_work_func(struct work_struct *work)
> +{
> +	struct iova_rcache *rcache = container_of(work, typeof(*rcache), work.work);
> +	struct iova_magazine *mag = NULL;
> +
> +	spin_lock(&rcache->lock);
> +	if (rcache->depot_size > num_online_cpus())
> +		mag = iova_depot_pop(rcache);
> +	spin_unlock(&rcache->lock);
> +

Running fio test on nvme disk is causing hard LOCKUP issue with the 
below kernel logs

[ 7620.507689] watchdog: Watchdog detected hard LOCKUP on cpu 334
[ 7620.507694] Modules linked in: nvme_fabrics intel_rapl_msr 
intel_rapl_common amd64_edac edac_mce_amd kvm_amd kvm rapl wmi_bmof 
ipmi_ssif binfmt_misc nls_iso8859_1 input_leds joydev acpi_ipmi ipmi_si 
ccp ipmi_devintf k10temp ipmi_msghandler mac_hid sch_fq_codel 
dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua msr ramoops 
reed_solomon pstore_blk pstore_zone efi_pstore ip_tables x_tables 
autofs4 btrfs blake2b_generic raid10 raid456 async_raid6_recov 
async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 
raid0 multipath linear hid_generic usbhid ast dax_hmem i2c_algo_bit hid 
drm_shmem_helper drm_kms_helper cxl_acpi crct10dif_pclmul crc32_pclmul 
ghash_clmulni_intel sha512_ssse3 aesni_intel crypto_simd cryptd cxl_core 
nvme ahci drm tg3 nvme_core xhci_pci libahci i2c_piix4 xhci_pci_renesas wmi
[ 7620.507795] CPU: 334 PID: 3524 Comm: kworker/334:1 Not tainted 
6.5.0-woiovapatchfix #1
[ 7620.507800] Hardware name: AMD Corporation
[ 7620.507803] Workqueue: events iova_depot_work_func
[ 7620.507813] RIP: 0010:native_queued_spin_lock_slowpath+0x8b/0x300
[ 7620.507823] Code: 24 0f b6 d2 c1 e2 08 30 e4 09 d0 a9 00 01 ff ff 0f 
85 f6 01 00 00 85 c0 74 14 41 0f b6 04 24 84 c0 74 0b f3 90 41 0f b6 04 
24 <84> c0 75 f5 b8 01 00 00 00 66 41 89 04 24 5b 41 5c 41 5d 41 5e 41
[ 7620.507826] RSP: 0018:ffa000001e450c60 EFLAGS: 00000002
[ 7620.507830] RAX: 0000000000000001 RBX: 000000000000007f RCX: 
0000000000000001
[ 7620.507832] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
ff11000167b7c000
[ 7620.507834] RBP: ffa000001e450c88 R08: 0000000000000086 R09: 
ff110055f3bf9800
[ 7620.507836] R10: 0000000000001000 R11: ffa000001e450ff8 R12: 
ff11000167b7c000
[ 7620.507838] R13: ff110060639dce08 R14: 000000000007fc54 R15: 
ff110055f3bf9800
[ 7620.507840] FS:  0000000000000000(0000) GS:ff11005ecf380000(0000) 
knlGS:0000000000000000
[ 7620.507843] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7620.507846] CR2: 00007f3678bc4010 CR3: 000000016e00c003 CR4: 
0000000000771ee0
[ 7620.507848] PKRU: 55555554
[ 7620.507850] Call Trace:
[ 7620.507852]  <NMI>
[ 7620.507857]  ? show_regs+0x6e/0x80
[ 7620.507865]  ? watchdog_hardlockup_check+0x16e/0x330
[ 7620.507872]  ? srso_alias_return_thunk+0x5/0x7f
[ 7620.507877]  ? watchdog_overflow_callback+0x70/0x80
[ 7620.507883]  ? __perf_event_overflow+0x13b/0x2b0
[ 7620.507888]  ? x86_perf_event_set_period+0xe7/0x1d0
[ 7620.507895]  ? perf_event_overflow+0x1d/0x30
[ 7620.507901]  ? amd_pmu_v2_handle_irq+0x158/0x2f0
[ 7620.507911]  ? srso_alias_return_thunk+0x5/0x7f
[ 7620.507914]  ? flush_tlb_one_kernel+0x12/0x30
[ 7620.507920]  ? srso_alias_return_thunk+0x5/0x7f
[ 7620.507923]  ? set_pte_vaddr_p4d+0x5c/0x70
[ 7620.507931]  ? srso_alias_return_thunk+0x5/0x7f
[ 7620.507933]  ? set_pte_vaddr+0x80/0xb0
[ 7620.507938]  ? srso_alias_return_thunk+0x5/0x7f
[ 7620.507942]  ? srso_alias_return_thunk+0x5/0x7f
[ 7620.507945]  ? native_set_fixmap+0x6d/0x90
[ 7620.507949]  ? srso_alias_return_thunk+0x5/0x7f
[ 7620.507952]  ? ghes_copy_tofrom_phys+0x79/0x120
[ 7620.507960]  ? srso_alias_return_thunk+0x5/0x7f
[ 7620.507962]  ? __ghes_peek_estatus.isra.0+0x4e/0xc0
[ 7620.507968]  ? srso_alias_return_thunk+0x5/0x7f
[ 7620.507973]  ? perf_event_nmi_handler+0x31/0x60
[ 7620.507978]  ? nmi_handle+0x68/0x180
[ 7620.507985]  ? default_do_nmi+0x45/0x120
[ 7620.507991]  ? exc_nmi+0x142/0x1c0
[ 7620.507996]  ? end_repeat_nmi+0x16/0x67
[ 7620.508006]  ? native_queued_spin_lock_slowpath+0x8b/0x300
[ 7620.508012]  ? native_queued_spin_lock_slowpath+0x8b/0x300
[ 7620.508019]  ? native_queued_spin_lock_slowpath+0x8b/0x300
[ 7620.508024]  </NMI>
[ 7620.508026]  <IRQ>
[ 7620.508029]  _raw_spin_lock+0x2d/0x40
[ 7620.508034]  free_iova_fast+0x12e/0x1b0
[ 7620.508041]  fq_ring_free+0x9b/0x150
[ 7620.508045]  ? amd_iommu_unmap_pages+0x49/0x130
[ 7620.508051]  iommu_dma_free_iova+0x10c/0x300
[ 7620.508058]  __iommu_dma_unmap+0xca/0x140
[ 7620.508067]  iommu_dma_unmap_page+0x4f/0xb0
[ 7620.508073]  dma_unmap_page_attrs+0x183/0x1c0
[ 7620.508081]  nvme_unmap_data+0x105/0x150 [nvme]
[ 7620.508095]  nvme_pci_complete_batch+0xaf/0xd0 [nvme]
[ 7620.508106]  nvme_irq+0x7b/0x90 [nvme]
[ 7620.508116]  ? __pfx_nvme_pci_complete_batch+0x10/0x10 [nvme]
[ 7620.508125]  __handle_irq_event_percpu+0x50/0x1b0
[ 7620.508133]  handle_irq_event+0x3d/0x80
[ 7620.508138]  handle_edge_irq+0x90/0x240
[ 7620.508143]  __common_interrupt+0x52/0x100
[ 7620.508149]  ? srso_alias_return_thunk+0x5/0x7f
[ 7620.508153]  common_interrupt+0x8d/0xa0
[ 7620.508157]  </IRQ>
[ 7620.508158]  <TASK>
[ 7620.508161]  asm_common_interrupt+0x2b/0x40
[ 7620.508165] RIP: 0010:iova_depot_work_func+0x28/0xb0
[ 7620.508170] Code: 90 90 f3 0f 1e fa 0f 1f 44 00 00 55 48 89 e5 41 56 
4c 8d 77 e0 41 55 41 54 49 89 fc 4c 89 f7 e8 2e 9d 5e 00 8b 05 58 d6 bb 
01 <41> 39 44 24 e4 77 14 4c 89 f7 e8 f9 9d 5e 00 41 5c 41 5d 41 5e 5d
[ 7620.508173] RSP: 0018:ffa0000025513e30 EFLAGS: 00000246
[ 7620.508176] RAX: 0000000000000200 RBX: ff110001988f4540 RCX: 
ff11005ecf3b3ca8
[ 7620.508178] RDX: 0000000000000001 RSI: ff110001000420b0 RDI: 
ff11000167b7c000
[ 7620.508180] RBP: ffa0000025513e48 R08: ff110001000420b0 R09: 
ff110001988f45c0
[ 7620.508181] R10: 0000000000000007 R11: 0000000000000007 R12: 
ff11000167b7c020
[ 7620.508183] R13: ff110001001f1600 R14: ff11000167b7c000 R15: 
ff110001001f1605
[ 7620.508193]  process_one_work+0x178/0x350
[ 7620.508202]  ? __pfx_worker_thread+0x10/0x10
[ 7620.508207]  worker_thread+0x2f7/0x420
[ 7620.508215]  ? __pfx_worker_thread+0x10/0x10
[ 7620.508220]  kthread+0xf8/0x130
[ 7620.508226]  ? __pfx_kthread+0x10/0x10
[ 7620.508231]  ret_from_fork+0x3d/0x60
[ 7620.508235]  ? __pfx_kthread+0x10/0x10
[ 7620.508240]  ret_from_fork_asm+0x1b/0x30
[ 7620.508252]  </TASK>

Looking into the trace and your patch figured out that in 
iova_depot_work_func workqueue function rcache->lock is taken via 
spin_lock. But the same lock will be taken from IRQ context also.
So, to prevent IRQ when the rcache->lock is taken we should disable IRQ.
Therefore use spin_lock_irqsave in place of normal spin_lock.

Below changes fixes the issue

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 436f42855c29..d30e453d0fb4 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -747,11 +747,12 @@ static void iova_depot_work_func(struct 
work_struct *work)
  {
	struct iova_rcache *rcache = container_of(work, typeof(*rcache), 
work.work);
	struct iova_magazine *mag = NULL;
+	unsigned long flags;

-	spin_lock(&rcache->lock);
+	spin_lock_irqsave(&rcache->lock, flags);
	if (rcache->depot_size > num_online_cpus())
		mag = iova_depot_pop(rcache);
-	spin_unlock(&rcache->lock);
+	spin_unlock_irqrestore(&rcache->lock, flags);

	if (mag) {
		iova_magazine_free_pfns(mag, rcache->iovad);


> +	if (mag) {
> +		iova_magazine_free_pfns(mag, rcache->iovad);
> +		iova_magazine_free(mag);
> +		schedule_delayed_work(&rcache->work, IOVA_DEPOT_DELAY);
> +	}
>   }
>   
>   int iova_domain_init_rcaches(struct iova_domain *iovad)
> @@ -752,6 +777,8 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
>   
>   		rcache = &iovad->rcaches[i];
>   		spin_lock_init(&rcache->lock);
> +		rcache->iovad = iovad;
> +		INIT_DELAYED_WORK(&rcache->work, iova_depot_work_func);
>   		rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache),
>   						     cache_line_size());
>   		if (!rcache->cpu_rcaches) {
> @@ -812,6 +839,7 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>   			spin_lock(&rcache->lock);
>   			iova_depot_push(rcache, cpu_rcache->loaded);
>   			spin_unlock(&rcache->lock);
> +			schedule_delayed_work(&rcache->work, IOVA_DEPOT_DELAY);
>   
>   			cpu_rcache->loaded = new_mag;
>   			can_insert = true;
> @@ -912,6 +940,7 @@ static void free_iova_rcaches(struct iova_domain *iovad)
>   			iova_magazine_free(cpu_rcache->prev);
>   		}
>   		free_percpu(rcache->cpu_rcaches);
> +		cancel_delayed_work_sync(&rcache->work);
>   		while (rcache->depot)
>   			iova_magazine_free(iova_depot_pop(rcache));
>   	}

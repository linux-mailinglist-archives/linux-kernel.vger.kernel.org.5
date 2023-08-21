Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4C478251B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbjHUIMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbjHUIMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:12:16 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82420B9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:12:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Et2o75pnLtVxqs5mV7RM2AueFfbINcxcxFeqw69TMr8esGC1bfSqcMPbCvFEYPvkQLStxYlKS88bLQ1UKr2wzLpgfdAhL8g9gkrUTXryN/CV5ylccLr/NNpfuoHs4McUiVWhTt5ffBqGmA3FA0DEePi2DKGvh0fFBCx+DrirZGZtIV5DRaa6ZbbNVERP6JU7pReHXn6VVLiSg0aEbPRurf7nJQhfr1I+7WtHvOHM0K66XgYYJ7X7DsIe8DfhgBgj9rGYrX6/qbP0DwnsDexkd1eGPqVIhNOTe61sqGNjbNSQ0VKkHaxZs2zmIHhgNF1DQshT+nLYp42eCzaCozhTQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fy8axMDgLwzvNdV4ggaGS3hwzAP8hqLYgl+dyHp+80Y=;
 b=TmtquVIgdPAeFOxLndtvhkxxTlJivJoQFjqRuo7OqCDK1u78gttgZBi+44m7CYX7r1kn/rVQbyQXfpTCPIv0ZmFbJnr6w6e1YDFalNfRHoM/UzXXCQKpyTHjSTR0rJCOab6DZQh0CvRXRCGgaMDtUpOfeVY7/AoldWEAPMxbmxZoAN7Snq99k2sGriL5NylgI1f/yAnzFI6+SnAdKqm8afvKNLe9PKnR1z8oIEkBu0AioGHV8vtUWePDqB6oxk5avFYYRvd465gAf5KOUJ5XzarQgFltpfBhyAn1p9aC12iU0TSQ2ekCwXAU1TrC999z3xwTnVYAwOIHi8RwZ7cWJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fy8axMDgLwzvNdV4ggaGS3hwzAP8hqLYgl+dyHp+80Y=;
 b=5kobxtKyQoRM+T1CLm6NYlPIEGN+pwD5NkVmSB/nmQRLEuzfNyd597T0IeZL2YEMX83t2ylQb2INSYJFQOM0yuPL7boajOPPnIkbX8MRbZ418RHwSLTmgZhPfyzjwKfrhidkSubfjfBc1djf2ixsPx3rpNnCTRoomsWJEcYp/F8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7)
 by PH7PR12MB8037.namprd12.prod.outlook.com (2603:10b6:510:27d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 08:12:08 +0000
Received: from BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::266b:49f3:3cba:406d]) by BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::266b:49f3:3cba:406d%4]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 08:12:08 +0000
Message-ID: <3689f036-5d48-0e4d-56fc-9d96823b9547@amd.com>
Date:   Mon, 21 Aug 2023 13:41:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] iommu/iova: Make the rcache depot scale better
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, john.g.garry@oracle.com,
        zhangzekun11@huawei.com
References: <cover.1692033783.git.robin.murphy@arm.com>
 <2c3a0f6b381ae5f743c1b28bbc6eae486160f3b7.1692033783.git.robin.murphy@arm.com>
From:   "Srivastava, Dheeraj Kumar" <dheerajkumar.srivastava@amd.com>
In-Reply-To: <2c3a0f6b381ae5f743c1b28bbc6eae486160f3b7.1692033783.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0229.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::11) To BN9PR12MB5163.namprd12.prod.outlook.com
 (2603:10b6:408:11c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5163:EE_|PH7PR12MB8037:EE_
X-MS-Office365-Filtering-Correlation-Id: c151bf01-cc1b-457a-4104-08dba21e504e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FT77sbry+vXauwzZOrrWA95gSukvC/mq8cKc0edpXSPyIeGsytCuYWZiZ3A9o2H819+7JE8caMupNhrVbFFV1/CIJMJXuGxG/WMWWhxgCcIO7bpFinNMzPBGJHbY5UWuBfUsx8vAEzRqrbw4yHf5jjutoF6bqrxn2kE47DUYI0ychm5pTU9/k0umioE2Alk5/BEn8X0QXOSpP21n+IiBZZbmeT0Amj7JoCryNYdT8fVXlA77CwANGPkVOgOdc0me2nzTQH6hKOvkyV22k8sKcL6PpCIcOUBh2P2rpLECWhFh9YywhcJO9Z2V/0SuwsWc0B1D5ZePrlF8lUNSo3bPZ42pxXNJJyLZ47IoOGGaWjAnzOrs6rk5BdARDHzI1MxKA019NxU+6Y9fbn1wWTu4Zaib7gnqf7jlwSWBy/dyiq1bzzMTpZ2A7eVA94BGuNxjG4BQDRmpg4SiWEFfGiNew2gTiJxY43JEGkny8d3AwQw8fxXn6fRPn2c9IBeYLAAk9l2mBJ7mGLEozLn/cJY0uCOnuzu3LNnY05wZvspARR6uMcyfMcSApCWA7qRZusU/pAr9G03t/OALaHz6XkG4ZGoYaWovm45BpRmRTm+jnWnTFNXZzRCnK6k2lgBNcSj8Lqx6ST5RTnziTQB1gGvVtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199024)(186009)(1800799009)(2906002)(83380400001)(45080400002)(53546011)(38100700002)(6506007)(6486002)(5660300002)(26005)(86362001)(31686004)(31696002)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(66556008)(66476007)(478600001)(6666004)(19627235002)(41300700001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG5iZHNSZk51azNZdSs2UG8zNXhMaExzVU5Odk9WVGxQK1QzUXM5RjFUeXhZ?=
 =?utf-8?B?UU5HRFZJdWxPQWpzazNJY0U3NWo3RDB4L3pZSCs4bUYvQzJaRTVPNGhCTDZx?=
 =?utf-8?B?aysxZjljdTlSUnBFMWw0OFZMUzYwYm1Ic3MwcEFhR2trWXh1ck4rSGJRdmJH?=
 =?utf-8?B?WENvWDY0aEJ0WXRRN3FmTm82Z0JkeStqTWFxTFg2ZytsQjFOWHVwdnZCSm5W?=
 =?utf-8?B?aG8wbnk3RThTRGREL1NYTkIyNW5mZUlYM20xc3FQV3MrNGdBUE9BajFqWk9k?=
 =?utf-8?B?bXBBdVZnd044dUJ1QXJzZ00yV1VhN2pWdHpDaFp0VkNCeUo4eFZzSmxBTWls?=
 =?utf-8?B?QWIwalViT25vekdPQVRPdmNvdDRsUUc3UGxZSVFQcFRUSW5kSll6T2pUaWY1?=
 =?utf-8?B?V2tkbURvYWtMUGlhaXZhM29uR0FPbDBsVUFCOTlNLytGd1pWeXlrdnVoV0Rw?=
 =?utf-8?B?ZGpOSWIxRnE2MDQ3UkVJbnY0a3JYWGN4ckFGUHkzWXdqazdmZ2FvQWg3cGNr?=
 =?utf-8?B?eEg1U05qUkpDTkpWMytXN1B6dENTajNtNkYwc3lkYldyS3g5THQ3Wmh5OGFw?=
 =?utf-8?B?MkVxZXcveTVQN2RsVU9PNUlqRTRVNGVXZW90V09nMURlbEpGcDJQcGJyK2NQ?=
 =?utf-8?B?Y3dJSlB5b2YybWdJWHUwaUY2dkljK2o0MzJYNGc4MFRjdHQ4TzAycmd3NEI3?=
 =?utf-8?B?ZTkzTWpaSGgxaC9xeXUwdzdNU1JTOTBOaXZXdng0bVd5Y1NMdTJ0bmM4dVZl?=
 =?utf-8?B?NDZRcTlHZzhYOEkvWko2UUNxTW0xdkRyNXhnRTJhL3ArbGhySS9DNkU3cCtL?=
 =?utf-8?B?dlJrZ2JHanlRSk8rVXl2QStyeW10clUxdU5PcXpXUjFqV0ROUlBONlRQK1ly?=
 =?utf-8?B?QTI4QUxTaWVwNXhtc1FtSm1KMnZWMS9WemM4WTJpZDJXeC9ibVhRSmdBOXlj?=
 =?utf-8?B?Y1FrSzV6YlBQY000UFJlU2h0cExyYmRoRUxVVGZSWkxzZlptWW1yelVrdU95?=
 =?utf-8?B?VUVxMmxBc1BUOG5CTDQ3MW5mcDNYYUE4SElEYzg5OE5jRXZJRjlOSjBVd2NQ?=
 =?utf-8?B?TEE4N3RNcjZwZmpSc1orRWZlMUlaMGdub0pwemJVNjBCc0xIT2NEelhnSkNo?=
 =?utf-8?B?RzVZdFRBM0JTZkhPRHpZOXBNS3BrdnVteTkvSGlIcnB6M3NtQ0ZTWnRrTVAr?=
 =?utf-8?B?cUxFaG1vM2FZdEdwS1hnZnhzMGRTYlI4cyt6UHdrUFF1Q1FlbEU3eHFXbjc5?=
 =?utf-8?B?V0ZhZjVIZFRFY1c5TjR6ZDIrS2xvSVZ0R0Y1eGhXS084QUJXNTFRdXJsYktz?=
 =?utf-8?B?MVFHN005SENZUzh1Zmo2NVBtUXA1bjVVV2xSTGxHOFpScVRHb244YlVWazRJ?=
 =?utf-8?B?QS9RcDVUdHhwcGlEaGJDMDFVWXlseGduV1d5QUNPRVdjT0EvQlpCemZmdW5U?=
 =?utf-8?B?NHI3dTBTN0xTWmdqRU9DNWtZTFpwK25ZRDdmOGtTUW5hWGJxQUdQSm1xUTJD?=
 =?utf-8?B?NXhxeHExUCtra2tyRTNSUS9pOTVXZjJkSGFvUnNoUUdVQnFMNms3blViNFQ5?=
 =?utf-8?B?UUpTb0ZoU1ZkVlhPRHUwYWtMNHdCM1FvSlRVL0ZxVmRtT0V0MzNDN0ttUVhM?=
 =?utf-8?B?SmxKMkF3M2pDNDgvcFhmdzhJcXdzZ1BNZmJlb3prRllWaEU1eTQyU2FhNlEv?=
 =?utf-8?B?UkZsVGJMODczdEpyc3NHRVV1UlRMRzRwcFFkVzYvTERCZytEM1d2bEZpVDRy?=
 =?utf-8?B?Q2pRQjZ2L1RxWEU0M3QweHFUdVp6ZTRrWVVwaWtoQ3hhc3FUQmlZRFR4QUtw?=
 =?utf-8?B?Z1FjNnpEMmdITTlvV3poSmlFc2JLR05CSFh6SVVUREdpWVlhRjJvTzdjSWQ0?=
 =?utf-8?B?V3BvTHJKbFZFNXN3eEFvM0ZwZEFrUWR6THZBMURBM1FjYmw1dy9xMDNXWmp0?=
 =?utf-8?B?Q2tQYmdFalVVb3RoSEhKY1RuNXd2Z3FJcFdXOUwzWnVUV1dCNzJRb1ZXb1c5?=
 =?utf-8?B?NnMzbkVHY1QxbmlzQW9QNXJwMjZ4REhsdTArcURYVFMzME94ajBxU2g5dk9Y?=
 =?utf-8?B?cW1TQ1BDN3VhN25yVEt4dktGbVN2MWlZeDkzdzk3cjZhdkZlVm81aS9SZE5Z?=
 =?utf-8?Q?tho14q4Ov+xI2ETETbu5UQqXx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c151bf01-cc1b-457a-4104-08dba21e504e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 08:12:08.6421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6x6SgZUVlhCDkTDsxzZu7qO6LFzPHI0W9kwgkH5N3lgB20dvNKY8YIDvkOzg9fAUceD22zXrqq/kphvWo5tBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8037
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Robin,

On 8/14/2023 11:23 PM, Robin Murphy wrote:
> The algorithm in the original paper specifies the storage of full
> magazines in the depot as an unbounded list rather than a fixed-size
> array. It turns out to be pretty straightforward to do this in our
> implementation with no significant loss of efficiency. This allows
> the depot to scale up to the working set sizes of larger systems,
> while also potentially saving some memory on smaller ones too.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/iova.c | 65 ++++++++++++++++++++++++--------------------
>   1 file changed, 36 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 10b964600948..d2de6fb0e9f4 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -625,10 +625,16 @@ EXPORT_SYMBOL_GPL(reserve_iova);
>    * will be wasted.
>    */
>   #define IOVA_MAG_SIZE 127
> -#define MAX_GLOBAL_MAGS 32	/* magazines per bin */
>   
>   struct iova_magazine {
> -	unsigned long size;
> +	/*
> +	 * Only full magazines are inserted into the depot, so we can avoid
> +	 * a separate list head and preserve maximum space-efficiency.
> +	 */
> +	union {
> +		unsigned long size;
> +		struct iova_magazine *next;
> +	};
>   	unsigned long pfns[IOVA_MAG_SIZE];
>   };
>   
> @@ -640,8 +646,7 @@ struct iova_cpu_rcache {
>   
>   struct iova_rcache {
>   	spinlock_t lock;
> -	unsigned long depot_size;
> -	struct iova_magazine *depot[MAX_GLOBAL_MAGS];
> +	struct iova_magazine *depot;
>   	struct iova_cpu_rcache __percpu *cpu_rcaches;
>   };
>   
> @@ -717,6 +722,21 @@ static void iova_magazine_push(struct iova_magazine *mag, unsigned long pfn)
>   	mag->pfns[mag->size++] = pfn;
>   }
>   
> +static struct iova_magazine *iova_depot_pop(struct iova_rcache *rcache)
> +{
> +	struct iova_magazine *mag = rcache->depot;
> +
> +	rcache->depot = mag->next;

While doing routine domain change test for a device ("unbind device from 
driver -> change domain of the device -> bind device back to the 
driver"), i ran into the following NULL pointer dereferencing issue.

[  599.020261] BUG: kernel NULL pointer dereference, address: 
0000000000000000
[  599.020986] #PF: supervisor read access in kernel mode
[  599.021588] #PF: error_code(0x0000) - not-present page
[  599.022180] PGD 0 P4D 0
[  599.022770] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  599.023365] CPU: 68 PID: 3122 Comm: avocado Not tainted 
6.5.0-rc6-ChngDomainIssue #16
[  599.023970] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS 
2.3.6 07/06/2021
[  599.024571] RIP: 0010:free_iova_rcaches+0x9c/0x110
[  599.025170] Code: d1 ff 39 05 36 d2 bc 01 48 89 c3 77 b4 49 8b 7f 10 
e8 b8 69 93 ff 49 8d 7f 20 e8 6f e4 6b ff eb 05 e8 48 ba 93 ff 49 8b 7f 
08 <48> 8b 07 49 89 47 08 48 c7 07 7f 00 00 00 41 83 6f 04 01 48 85 ff
[  599.026436] RSP: 0018:ffffb78b4c9f7c68 EFLAGS: 00010296
[  599.027075] RAX: ffffffff9fa8c100 RBX: 0000000000000080 RCX: 
0000000000000005
[  599.027719] RDX: 0000000000000000 RSI: 000000007fffffff RDI: 
0000000000000000
[  599.028359] RBP: ffffb78b4c9f7c98 R08: 0000000000000000 R09: 
0000000000000006
[  599.028995] R10: 0000000000000000 R11: 0000000000000000 R12: 
0000000000000000
[  599.029636] R13: ffff93910d9c6008 R14: ffffd78b3bde1000 R15: 
ffff9391144ebc00
[  599.030283] FS:  00007fa5c9e5c000(0000) GS:ffff93cf72700000(0000) 
knlGS:0000000000000000
[  599.030941] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  599.031588] CR2: 0000000000000000 CR3: 000000013f526006 CR4: 
0000000000770ee0
[  599.032237] PKRU: 55555554
[  599.032878] Call Trace:
[  599.033512]  <TASK>
[  599.034140]  ? show_regs+0x6e/0x80
[  599.034769]  ? __die+0x29/0x70
[  599.035393]  ? page_fault_oops+0x154/0x4a0
[  599.036021]  ? __x86_return_thunk+0x9/0x10
[  599.036647]  ? do_user_addr_fault+0x318/0x6b0
[  599.037258]  ? __x86_return_thunk+0x9/0x10
[  599.037866]  ? __slab_free+0xc7/0x320
[  599.038472]  ? exc_page_fault+0x7d/0x190
[  599.039074]  ? asm_exc_page_fault+0x2b/0x30
[  599.039683]  ? free_iova_rcaches+0x9c/0x110
[  599.040286]  ? free_iova_rcaches+0x91/0x110
[  599.040875]  ? __x86_return_thunk+0x9/0x10
[  599.041460]  put_iova_domain+0x32/0xa0
[  599.042041]  iommu_put_dma_cookie+0x177/0x1b0
[  599.042620]  iommu_domain_free+0x1f/0x50
[  599.043194]  iommu_setup_default_domain+0x2fb/0x420
[  599.043774]  iommu_group_store_type+0xb6/0x210
[  599.044362]  iommu_group_attr_store+0x21/0x40
[  599.044938]  sysfs_kf_write+0x42/0x50
[  599.045511]  kernfs_fop_write_iter+0x143/0x1d0
[  599.046084]  vfs_write+0x2c2/0x3f0
[  599.046653]  ksys_write+0x6b/0xf0
[  599.047219]  __x64_sys_write+0x1d/0x30
[  599.047782]  do_syscall_64+0x60/0x90
[  599.048346]  ? syscall_exit_to_user_mode+0x2a/0x50
[  599.048911]  ? __x64_sys_lseek+0x1c/0x30
[  599.049465]  ? __x86_return_thunk+0x9/0x10
[  599.050013]  ? do_syscall_64+0x6d/0x90
[  599.050562]  ? do_syscall_64+0x6d/0x90
[  599.051098]  ? do_syscall_64+0x6d/0x90
[  599.051625]  ? __x86_return_thunk+0x9/0x10
[  599.052149]  ? exc_page_fault+0x8e/0x190
[  599.052665]  entry_SYSCALL_64_after_hwframe+0x73/0xdd
[  599.053180] RIP: 0033:0x7fa5c9d14a6f
[  599.053670] Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 19 c0 f7 
ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 5c c0 f7 ff 48
[  599.054672] RSP: 002b:00007ffdeb05f540 EFLAGS: 00000293 ORIG_RAX: 
0000000000000001
[  599.055182] RAX: ffffffffffffffda RBX: 0000557de3275a80 RCX: 
00007fa5c9d14a6f
[  599.055692] RDX: 0000000000000003 RSI: 0000557de418ff60 RDI: 
0000000000000011
[  599.056203] RBP: 0000557de39a25e0 R08: 0000000000000000 R09: 
0000000000000000
[  599.056718] R10: 0000000000000000 R11: 0000000000000293 R12: 
0000000000000003
[  599.057227] R13: 00007fa5c9e5bf80 R14: 0000000000000011 R15: 
0000557de418ff60
[  599.057738]  </TASK>
[  599.058227] Modules linked in: xt_CHECKSUM xt_MASQUERADE xt_conntrack 
ipt_REJECT nf_reject_ipv4 xt_tcpudp nft_compat nft_chain_nat nf_nat 
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink bridge 
stp llc ipmi_ssif binfmt_misc nls_iso8859_1 intel_rapl_msr 
intel_rapl_common amd64_edac edac_mce_amd kvm_amd kvm dell_smbios dcdbas 
rapl dell_wmi_descriptor wmi_bmof joydev input_leds ccp ptdma k10temp 
acpi_ipmi ipmi_si acpi_power_meter mac_hid sch_fq_codel dm_multipath 
scsi_dh_rdac ipmi_devintf scsi_dh_emc ipmi_msghandler scsi_dh_alua msr 
ramoops reed_solomon pstore_blk pstore_zone efi_pstore ip_tables 
x_tables autofs4 hid_generic usbhid hid btrfs blake2b_generic raid10 
raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor 
raid6_pq libcrc32c raid1 raid0 multipath linear mgag200 i2c_algo_bit 
drm_shmem_helper drm_kms_helper crct10dif_pclmul crc32_pclmul 
ghash_clmulni_intel sha512_ssse3 aesni_intel crypto_simd cryptd nvme drm 
mpt3sas tg3 ahci nvme_core libahci xhci_pci raid_class i2c_piix4
[  599.058423]  xhci_pci_renesas scsi_transport_sas wmi
[  599.064210] CR2: 0000000000000000
[  599.064841] ---[ end trace 0000000000000000 ]---
--

Looking at the RIP: free_iova_rcaches+0x9c/0x110 pointed me to the above 
line leading me to believe we are popping element from an empty stack. 
Following hunk fixed the issue for me:

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 76a7d694708e..899f1c2ba62a 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -732,6 +732,9 @@ static struct iova_magazine *iova_depot_pop(struct 
iova_rcache *rcache)
  {
  	struct iova_magazine *mag = rcache->depot;

+	if (!mag)
+		return NULL;
+
  	rcache->depot = mag->next;
  	mag->size = IOVA_MAG_SIZE;
  	rcache->depot_size--;
--

> +	mag->size = IOVA_MAG_SIZE;
> +	return mag;
> +}
> +

--
Thanks and Regards
Dheeraj Kumar Srivastava


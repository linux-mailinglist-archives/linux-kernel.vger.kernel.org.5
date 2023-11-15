Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763867EC452
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344103AbjKOOFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344065AbjKOOFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:05:16 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD94AC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:05:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkbcvbiCLrlAm2XLNFk3jJHMiC3+CLQXYUd+vBU6XWXUJhgoAvEewacBgFUzhKynDfd6o2OtGjTOGUi7/MvJL9NCyOZdMxXvbMBW9ufyvU0XuLf/AKzIOSqK1nuO6ox9ZS/zMT1i5L1331ftf8nWoAW1ftmEn9PuS5j+6mTGB39Kmcd++eGV6nWWhpo0sRYUeCsB4LjOA60TR8SGso5FP5aT6KuTDXOFqzA4YoXjR+Nsk7Wss2wwKfpLGe2gKRyaTa2IIDqUjOyZXTeq3os/wKb8Q47C70bkRL2qq2TNca0klQQazmSSmmyATaa1+7dEE0+aySYgAxcNQEGnvmh2dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShZT6oJk9VVykarWcy9Xqg4RQoyFDUNFgydkzUe/mxM=;
 b=gppKgRfQcO09Kgl9XOI+x4hl1UGyUDUU8MaS6RlglK8qSgdpc2t5psIqyRD8/sZVTPDgXbHFbdA6HFCMewmkJy04gH8sYbAnVZZj6hGN+K/jJfV7AFJ31PTDllJ2M16YbWKjCq9rUyjgdBKNNbj3pSCOYf9etwPmzOMNBaZFT0T2ef6nds3dpDs0LiD/kgNYseN7xHLALllAlsi9yGfkBCxxcGK7wdSyPtnZBTc0erq0P2LEvCQlpw+bKwk93iTlx2IH9aaODJUQAK496AVzCt87EIbxnZD+tCKO4J+JbF40xJdDlevQisIgqXCVS1Sm29Re8WxiGc4i5OgIpFRcqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShZT6oJk9VVykarWcy9Xqg4RQoyFDUNFgydkzUe/mxM=;
 b=SVMtpZtOv7T8AIQW8ayXJ0PX3FLwjG8IXXzx3eWCq54SiQt/4PKAa1dKe5zgj617mNcyeZrQk6qSunEIz8/6l/ENVH2gtrw5CsimPtIz6gnnP8DrHIS3SviridhZOaXH+Z+tSH6aQcob7pj0I7RYnfTGEmJjUfj0K/6ZqBLt71o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CH3PR12MB9147.namprd12.prod.outlook.com (2603:10b6:610:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 14:05:09 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 14:05:09 +0000
Message-ID: <511b866a-b851-4019-aed4-2c11f24eece3@amd.com>
Date:   Wed, 15 Nov 2023 15:05:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: xilinx: fix unhandled SGI warning message
Content-Language: en-US
To:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        abhyuday.godhasara@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@amd.com, Tanmay Shah <tanmay.shah@xilinx.com>
References: <1698431039-2734260-1-git-send-email-radhey.shyam.pandey@amd.com>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <1698431039-2734260-1-git-send-email-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0094.namprd07.prod.outlook.com
 (2603:10b6:510:4::9) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CH3PR12MB9147:EE_
X-MS-Office365-Filtering-Correlation-Id: a39b00d9-837d-4457-4807-08dbe5e3e080
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hfDgF6ejALb+1JcRTl0C5jnyXqYnXeltDuzm30k06nF929HyamGPhGVZsZdG6S8XSqgImc9pNxGGd8YVaz6EgHP9bfS9EhThXf3tUQ7hPczEuamjPcMomUpuPK/RyTH0OI56NTxfD9cJjircVFOnaTFce9cD2nA/O+CnzZNFvBtnFlyif3bG44znSJqNuIcmzKexYc3iN12bAgVIj16uAzhQDe0fwLMVjDRRLBUZpid/FtjO7s5q4RZhCQ5GTGTJULXMI/WyUO7yJHWRAoZfPHdfo/Uix1HLFNGxIlB8T/+ZQQMYCLqAJXyDOhYgXx4Uc0s6+K9XLRihNNQgj/xJSldxS7YvZ0F1LwRLQ1NCunppVuKT/OSWVFauWJmxRTvDY3sDxMaqbDjtTmvA9P1moZkNsMgeuwXKKfoHFcYEXBT8WAOfm6G6TaXAQhSVuO7MF9x/1Vooa8ElcIiOx8Slw/7sHi1qVu5JRJBHDJRZMWhzLCTrcFUAWHPL2s0DyctIjLvgMDqUZhhEi3jQJ8Va35WFrZubucoC6YbGbrHP2Oej58qYDGhiQSw7WtUMrqYWqIK2+JpUdh2u7JubQ9+KZZAgrNQ6N/WhtZGFYV5ytoPFBRN7evq6UP57tZ6m8tejhR/yWwCg4k/nyswZo+MZ7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(38100700002)(83380400001)(8936002)(4326008)(66476007)(66556008)(8676002)(66946007)(31686004)(36756003)(41300700001)(26005)(31696002)(2616005)(6512007)(6506007)(53546011)(6666004)(478600001)(6486002)(2906002)(44832011)(316002)(86362001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wkw1UDFzTnlVWW43eXJ4MkdrSy9LTTVlVXAvTWFKVG05M24xZDdxcWpic3dW?=
 =?utf-8?B?U1BZWnNNT3JIcVdSM0ZCUXVEdUNMQTNsUUZVVGR1U21UbVdHUFZ5NXY1VUs1?=
 =?utf-8?B?a3Z5Unc5UUJaT1BGUE80L0x1bWRNeEFTVFRDWjlXUVk2R0QwUVhFVWNNOXZE?=
 =?utf-8?B?RjdFVlI4U1JSTUFNTkpSWVM2WndaaThpSEVXK0VtSGVpL1BVSGNKVi9LV2wz?=
 =?utf-8?B?RFJZamtSZUFUaXptbkJ0MmdvbXNqcjhiSm4rbkUvN2ZEczQzQkR0d2cyekhR?=
 =?utf-8?B?Q1FoU2pzMnJjYk9wL3VxVGllZEJYajA0QXhHQjBmcHBtNlUxUFVwSWtRRmk0?=
 =?utf-8?B?dERmQ0Nnbno0aWllNWJMZStFSzlsYVFiUG56OUkrRU16RzkxbXdUQmZrMlNC?=
 =?utf-8?B?QnVvZ09tNVNEYm80akxzRll6a0l6RnI3SkxYZTN4aWhuVE1aMjJydjBkKzBu?=
 =?utf-8?B?TmNDd3NNeWFkOFRYb0hCZng2MmFYd2tkdjlRODgyWnVhYjBqNXBZTDF2Q1Va?=
 =?utf-8?B?amxtbUxFT0Q5UWppYkJjNTFKcHcvV3NHUHAwYzQzU3c4RWtDL0F3T3JsTUs4?=
 =?utf-8?B?SzY4UzJYY1ZzN2xRcXdEQkYzNWY1YmJlSk1SV21EVEI4Z2Y1eTEzMzFTaUpt?=
 =?utf-8?B?RzVobTVsRmpQQWVmL1AwcW9wcC9TaUdWNkxUcTNLU1ltcGtyQVNFUG55a1lT?=
 =?utf-8?B?V3FlSWtOTmErdnBLQnNHTTQ0WjRld0JBa3FIKzJtT05KcGpSL0ZUTlB0bWc4?=
 =?utf-8?B?dTNrRkRwSkxEak1QNTVldmRUS0czWUEvR1pMcGJJMmltcG5KQ0VWaW54SE45?=
 =?utf-8?B?WXJsTmF3S0lYS1VEWFl3QlYxRm44dUVuQ2tVSjNBSThWalh3WmJJQ0pVWFk4?=
 =?utf-8?B?WW03WmJuUk1ZSm53cWdWMFBiRURSK0d6bFdIS0Z1blN4dzFJcEF2NFBmdjdy?=
 =?utf-8?B?S21SN2dtR28yNVNxOU9NWDRnSVJNaXlsa3BFQTh5VXpMbC9sV3d4WjcyeUE2?=
 =?utf-8?B?RDV2V04yUUZ5dzhGUUlaR1JyOVkzSkxlelJOVlJMQitIV202TG9JazBYZWxS?=
 =?utf-8?B?eWlDa1hpRG1GYkVUK2N0cGpMSmwvN1Q2MTgrUk1QNEJkTld4bUNGQlFpVHVY?=
 =?utf-8?B?eVhaSnczaHU1M0pwRGw4cGxVQ3hleDZTYVVWeC8zTzQ0WXJNTWhiUTBDak5i?=
 =?utf-8?B?cGtScGkxTXdmTUd1amxTUHhzNWNJaTd1WTBEZURIYWxWR3lyT0lOOWVUZGYw?=
 =?utf-8?B?YjY5ZVd6Z01RcVpQcTNFNFpCYWxDalpLMVZHVVFISldxVmVMRkdWU3JpdnFH?=
 =?utf-8?B?M3J5eWRWVkMvamQxVEMwTDJidWlFUmV0MDBNUXgrMFZDNFdnTnZkWitUS3p4?=
 =?utf-8?B?d1huZVc1ZStreGNLU3Y5d1pXZHVmN3Rmb0hrWEhpMS9KVjlqRHNjR2QzZUVN?=
 =?utf-8?B?MDJqN1Z6U29OT3EvSDhrdXdjbkVCRWhvclZMdGxZM0lhQllNYTRBaHJ4Vnkx?=
 =?utf-8?B?SkJvNHZKTDVlbW1oNmZ0ZFJoZDRBNEhXTTdseGxXaDhiQm9weEZRVDNReUlx?=
 =?utf-8?B?T1Z4WjBGT0JQMGZiRm5wR0hPSWJUK052Zm9lQ0h3NlVWUmt3Mkd2dUlyZXA1?=
 =?utf-8?B?a3pUVmlEbEx3ZElYM3ZmbjRBRnF1T1I5blFiQzl2UXpWVjRiM3MwaUhKdWZ6?=
 =?utf-8?B?d0pTaFlaV2oyb1RlaWlEUEpCazNUVkNNNmxFMkJYS3hCUlBSYmRvTm5yQm5I?=
 =?utf-8?B?S2dJME1XS090TjkyZ0ZzdkxsWkxpb2xKWUJBSXRGeVJjc1RmZWI5RTcyRGRa?=
 =?utf-8?B?eEg5UzVGZ1VGY2NGNDFpNEI2QlFUMHIvWkZQSitlN0xZK2VwNlo3My9wb3FQ?=
 =?utf-8?B?SktFdHpEZGtqbXJhR1I1OUJSOHowd1I5bU5kYStZUzlNTEw4bjIxRjBnQ2Nq?=
 =?utf-8?B?emJ0eWFtWEpNc3BjREppaFdvTmZHeDgzcEtBclU2MEloWHFpWUhXNGtISkhT?=
 =?utf-8?B?N1h5b1FWanNUUTRjd1h0ZFRIWVJSQWpkWHl5VmZKSVd6UEI1NFIvdzhFSGRM?=
 =?utf-8?B?LzhqTEVEN0tRTXF5TTFLWlJqdm5BWXNsVTM1S2xBd0c1cStFQ21JNk1hWG5T?=
 =?utf-8?Q?fbQLhCgpk56ogsz603iBz9hrf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a39b00d9-837d-4457-4807-08dbe5e3e080
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:05:09.1034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uUy7btVWSyoHLzTq0tuFm7ZNBapjq3teNjB7WNfgeDQEB1XNVnq5iCFghj51nFbe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9147
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/23 20:23, Radhey Shyam Pandey wrote:
> From: Tanmay Shah <tanmay.shah@xilinx.com>
> 
> Xen broadcasts SGI to each VM when multiple VMs run on Xen hypervisor. In
> such case spurious SGI is expected if one event is registered by one VM and
> not registered by another VM. We let users know that Unhandled SGI is not
> error and expected if kernel is running on Xen hypervisor.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
>   drivers/soc/xilinx/xlnx_event_manager.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
> index 86a048a10a13..6356b80ce57b 100644
> --- a/drivers/soc/xilinx/xlnx_event_manager.c
> +++ b/drivers/soc/xilinx/xlnx_event_manager.c
> @@ -477,7 +477,7 @@ static void xlnx_call_notify_cb_handler(const u32 *payload)
>   		}
>   	}
>   	if (!is_callback_found)
> -		pr_warn("Didn't find any registered callback for 0x%x 0x%x\n",
> +		pr_warn("Unhandled SGI node 0x%x event 0x%x. Expected with Xen hypervisor\n",
>   			payload[1], payload[2]);
>   }
>   

Applied.
M

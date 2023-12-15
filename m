Return-Path: <linux-kernel+bounces-1411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A25CC814E94
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5211F2130A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9894D49F6E;
	Fri, 15 Dec 2023 17:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0Aq+x8UP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6076D4B5B3;
	Fri, 15 Dec 2023 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRpN/4fdTJZrGx38IUGnB6rtHiDIIa0FOtewoswAXqMfNzOja9ZyYPAIzaSgLx865kPTcEdGwmWguoN6jV8e47jIjNw5PJeGeKEs8Cv/Jny2k841zR4HujhQJK6FiYQt5hKUslR/mjQDl9IT2GWrp4a80wzkqGkKg/9RUdZJvTtUj+j6g8Mt8fb+H4U0azxIgVp0wSP11pg8LjoIjpWrddAiZ8TD9R5+m9HzKE2+5V0fOTgvaAvwy1+LS/2vEcSkG5IckrI0ULVLQR1F+p4DGOMBm2vSylt3nzqbwixlo3RhOQR8nVX+g7z2XBpItmpo4RfOvqmuJAYH1Tsy5X231w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDaGjddj6oREkN7REYbXEAYwjbiEXIo82iY1xLNoyfw=;
 b=U+VsHGrjU/gILLI/QMmJvrl4QLhScUUDtpM36cXm73cqiikIRHtkMWCYIlTfI9lPxsXoivm1xtxkiWVVkoL2d4ZULmpSvP0xX0OBc5KsYnTPu3vEr3G6eeWDFI1HmM5GDatWBBbLKe1PPTM2Y5N7ZAAzNCNSfW5b2Ig+fUSuiboUatG85E38SkFHxFy6tT7t+0B2lyw8A1wdcPg7xgIIW7bVAhIPdGuur25UiKihWRFFgEjbFYen8u1NKTqo2+7gOWnVIcNidG3h+PFVv0t2FlZD7Hf5W0GbpZelqDxv+MkxlSXXuYAgHVUSYFVhvmDGIA6zNhiW6C3El4G3z0sZQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDaGjddj6oREkN7REYbXEAYwjbiEXIo82iY1xLNoyfw=;
 b=0Aq+x8UPu+kbkDDOj2o6KOXSAQ8P/gNUIWlTWWhq9BdwDONy4MoTdPHQmlW8cbFSW6cEx7Pz9zjGlAzhrNQjx93mC38go/QAoJhW+Dr93FNcoUEHuSfbTGgX3tukkaPBIOU+IlMoVahYK3GhjU6aABUDUoC78luoIRT+d6r6pFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by DM4PR12MB5890.namprd12.prod.outlook.com (2603:10b6:8:66::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.32; Fri, 15 Dec
 2023 17:16:07 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bec4:77b3:e1d1:5615]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bec4:77b3:e1d1:5615%5]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 17:16:04 +0000
Message-ID: <0edc953a-0357-d054-d9a2-e9a86e90233d@amd.com>
Date: Fri, 15 Dec 2023 09:16:00 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [net PATCH] i40e: fix use-after-free in i40e_aqc_add_filters()
Content-Language: en-US
To: Ke Xiao <xiaoke@sangfor.com.cn>, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: dinghui@sangfor.com.cn, zhudi2@huawei.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231213104912.16153-1-xiaoke@sangfor.com.cn>
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20231213104912.16153-1-xiaoke@sangfor.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::31) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|DM4PR12MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: 25c215b7-4eec-418b-10d4-08dbfd9184c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eqIKzStThsvZj3v7wMjT0NKbp3qkkqbTvut1L+1+R7Y7XIQHUuXtR/ThxOlHEmdhh0qOUnBcAY1wLhziFGwUAXoe+R3ayTjGLXx5oTNa7aMb8B/7kfya2+bz9wc4C952OgqCFm1yxrDcK+s2v/EVArvDFiuc6A8TZMoJP7sM+BtlWqCe9cVb/gh2wtMjGZeSh3P5YADfepInvr30rmOOp0vAaISw64V1vNQgvZpPdxjf6z+uSXawt6GQHKZgSni6XNfw3a9VS8+QWOv0C3JvI9N3eCr8P3Kw5rKTAIUrftWjCQqwPL2zEIQsFCH1yWS/qk5i5O+UV/BsD0k0ctwSFZngZFlyeDmhZOtUEPzyinLY9YQ8trS+QrUMAMG3adkT/8RswETqjVY1SxUEBBcmXSp20hPH6YdeqXyRzacQFNIRED9Hxj2yymismipBcwth4pCbUxPYPHTrlsiqA2iIdufs3kHMKSvs1+usCOvHGVIHf1zWH8dKqN3wmDh9e+SZVGpYQdUprCA+DvSOGJzNPAFIaHS5ErAx1wZcBtBJwg5qWeFEmV4r4H2c4oPRub0LeTy3cvxKfNr9OatBr95OGQsEEu+o8lXQS2jf2xv+Ce/0dus7SSaFR2VCTZHjCcV4iyDNx+XGD1Lb8ZWJ+DD3KF7GfMnyvblCr+cJVO95kv+PR+F/GKjPKbtICi3me4Ns
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(230273577357003)(230173577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(26005)(2616005)(53546011)(6666004)(6512007)(6506007)(38100700002)(31696002)(36756003)(41300700001)(8676002)(8936002)(4326008)(478600001)(5660300002)(7416002)(2906002)(83380400001)(6486002)(66946007)(66556008)(66476007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVhBUk8vSUJzbUFnSlpIaWRZazZQYWo5bko0dVA4Vll0MkwrVTc2RFYxZUpU?=
 =?utf-8?B?aGRxRFcybzBzbnV3OC9DQUljd3hHNTl1bGF1RGh5MEkwWmIwQ3pBY084NG5H?=
 =?utf-8?B?Qzg4L2ZWMDVuc3R4elAyMCs4R09sWVF5UDZLR3JKNnQ0dENFWS9NVVZoMzI1?=
 =?utf-8?B?U0ROamRDRWdQOXNkYXdNeklVRHFOMVd0bmFtTkw3ejA4K2E3U3h2S3ZEbHVP?=
 =?utf-8?B?U09uQXlieHBOOW12RDhHRTNxY056UVZYbW1yVWZzL0VDdTRCK0dKaGtXQUUz?=
 =?utf-8?B?b005M0pWWlJaMXRtNzVoSVJDY0hzY2VoQnJZMmdJdTZJeUJlYkRMNm1HZk0r?=
 =?utf-8?B?M2VZSGNFLzRTeXB2Ly9hQi9HeURiNzV1d0NqaFFNTHN3am1iRU1sbGVTL3Vq?=
 =?utf-8?B?ODZ3d1cyMWozbTZQdUlISUczaHBYdUlYU0s0cVpVNHdnU255L1l6c0pFMnBx?=
 =?utf-8?B?YTJucVpFeDR3bTNJMmd1Uy9VYVNhUHRkOTB3MlljbnpSdk1LN0JKNjcwbStQ?=
 =?utf-8?B?QzlBbjkvSFMvZ3VETDluMEtaNnhxdm1EbmtVNmtjWlMzQU5jM1hQV1FTaHpV?=
 =?utf-8?B?WjJmQnpna0tyMTUxQW5IclJOZGpCSDBqdWd0cTJKb0YwejNiRkRMREU2VktM?=
 =?utf-8?B?TU0yWnNCWm52UmFkaGp6eWVDbms1ZjJlSTQ0azJFVUVnRlZkdXdORDlpWjVE?=
 =?utf-8?B?R1ozUFhaRUkyN0YraXcyZi9CdStOeXgvRTVTU096ZFIwWTNoYnFzYlY1VDBi?=
 =?utf-8?B?RTBGaHpNaTJsWlZPbzF4eVZTaFRLeStad3ZrNUtWZ1FUWkNYR0p2dmQrUzh2?=
 =?utf-8?B?R0FwcmI3STg2Q3liZ2Q0M3FIL0dNV3FXMzFYK1NoQUxIdGFUYVgxS2ZFSjdX?=
 =?utf-8?B?enQ5TEEybUF4alhvbnhLM1ROOXpFWmpaVmMybStmVEV3VXVsMzA2YTF3ZmVl?=
 =?utf-8?B?SHBVeGhibHI3c3VLTWFHYXVDOXY0L0xhVHh2YnV1b1ZpUXNjYXhqdk9iZXl0?=
 =?utf-8?B?N2VnUkhSSHFRK2syVGRBZTRNSjJNZi9NeDFVWm1HR1RIaDZJNTFyaW4wQnVu?=
 =?utf-8?B?YTdnSUdvbXZvcmpIdUw5WTBVTWo2em43MFhKekpEcmtoYnkxUkR2WjBtYmlT?=
 =?utf-8?B?SURaSGYyN1hQRnFRdVhYaXQwK0xSeU1DTndweVpFamE2ZkVLUzZFWnVzRmpI?=
 =?utf-8?B?QnRoalBPNEZKc2lBeVdPN1VhTHlCQmRyTHBNYzRvaHE4RkNsNnJhQjF0eEdT?=
 =?utf-8?B?ZEtKaDA5TGxDbWFISytKc2ZUQmlsL3oybFZvNGlVWFNhWCtaSHNVZ0VHa3FX?=
 =?utf-8?B?UGRKQklvOXdKdkg4Ty9EY3dkUFg5ZnNyVzZRRGYrQjNvZEErR2dvbnM2K2Yv?=
 =?utf-8?B?TTE3WDgwQm9Jcm0rSTFWZTU2ZUdramh2clVGb0ZhUThhbXFDOFY3WDE5bm05?=
 =?utf-8?B?ckdGeUhtc2lWMnFqOExwWTB3WHloLzZTK05CNEZjNVhadFRHM0ZDdENDQmlz?=
 =?utf-8?B?ODNUeHF0eWcycW54UytHeFJ5UEVHOUhraHQ1Y3NpNkhwK0JDaE8wTHpncS9k?=
 =?utf-8?B?VGhNQnkwMkV0a3ZhWk4zSlFrVVEvcGxwdEhxVk1GeXJmSHlKZDFhTDV4UkR5?=
 =?utf-8?B?UXdMV0JoS2RubDZPVlhCRlZTU01KQmVoN3V4UXBoL1NqSzdINjk4VTRPOW84?=
 =?utf-8?B?Q0xGLzFxU0U1ZHlSa1RuK2hMNUQ2YUI1UWFyR2RrWTV0czVpclNZRnZFaDlS?=
 =?utf-8?B?Y1duaWhibWk0WnBQWktmTVJHUTErRzJvM0dLcU9vNmFLY3hVdytjUElobnBz?=
 =?utf-8?B?UXlPdU1HelVZVUVNa01FV3ZmYjRrMlU1b2JTMGJkK1d1alQraVZJRTBlQ0xn?=
 =?utf-8?B?WVFrendySk9hN1VtTVQyRmxYZ3o2TUJReHlISzlILzluc1pXOWIxMktlOEJY?=
 =?utf-8?B?cFh5Q21EQWJJUFA0Z0s2cEUrVjVvekJLYXN0RDlTNXRxa0hZc2xWcDVodDhP?=
 =?utf-8?B?QmRNdW5PVjQxa1Q2VjY0RnorWTBiWDRRcGlheU5NWWpFZ0YxMG9QQXhDdFZ5?=
 =?utf-8?B?SVlrajgvUnlNeUNYWXVjY29RMEFFUGMvaEVadXRhUDBySGllMDRwS09xZ1dv?=
 =?utf-8?Q?zs8T0PHBl2oz/GIK7Cj3ux2rl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c215b7-4eec-418b-10d4-08dbfd9184c1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 17:16:04.3742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: at3akw0b+sOtpedpT54+r4mL0F+wLWOOXFgizA3roLphIQpPYv4xFbkhgZij87+C+DFFhW99/EKGR9n5rHaXfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5890

On 12/13/2023 2:49 AM, Ke Xiao wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Commit 3116f59c12bd ("i40e: fix use-after-free in
> i40e_sync_filters_subtask()") avoided use-after-free issues,
> by increasing refcount during update the VSI filter list to
> the HW. However, it missed the unicast situation.
> 
> When deleting an unicast FDB entry, the i40e driver will release
> the mac_filter, and i40e_service_task will concurrently request
> firmware to add the mac_filter, which will lead to the following
> use-after-free issue.
> 
> Fix again for both netdev->uc and netdev->mc.
> 
> BUG: KASAN: use-after-free in i40e_aqc_add_filters+0x55c/0x5b0 [i40e]
> Read of size 2 at addr ffff888eb3452d60 by task kworker/8:7/6379
> 
> CPU: 8 PID: 6379 Comm: kworker/8:7 Kdump: loaded Tainted: G
> Workqueue: i40e i40e_service_task [i40e]
> Call Trace:
>   dump_stack+0x71/0xab
>   print_address_description+0x6b/0x290
>   kasan_report+0x14a/0x2b0
>   i40e_aqc_add_filters+0x55c/0x5b0 [i40e]
>   i40e_sync_vsi_filters+0x1676/0x39c0 [i40e]
>   i40e_service_task+0x1397/0x2bb0 [i40e]
>   process_one_work+0x56a/0x11f0
>   worker_thread+0x8f/0xf40
>   kthread+0x2a0/0x390
>   ret_from_fork+0x1f/0x40
> 
> Allocated by task 21948:
>   kasan_kmalloc+0xa6/0xd0
>   kmem_cache_alloc_trace+0xdb/0x1c0
>   i40e_add_filter+0x11e/0x520 [i40e]
>   i40e_addr_sync+0x37/0x60 [i40e]
>   __hw_addr_sync_dev+0x1f5/0x2f0
>   i40e_set_rx_mode+0x61/0x1e0 [i40e]
>   dev_uc_add_excl+0x137/0x190
>   i40e_ndo_fdb_add+0x161/0x260 [i40e]
>   rtnl_fdb_add+0x567/0x950
>   rtnetlink_rcv_msg+0x5db/0x880
>   netlink_rcv_skb+0x254/0x380
>   netlink_unicast+0x454/0x610
>   netlink_sendmsg+0x747/0xb00
>   sock_sendmsg+0xe2/0x120
>   __sys_sendto+0x1ae/0x290
>   __x64_sys_sendto+0xdd/0x1b0
>   do_syscall_64+0xa0/0x370
>   entry_SYSCALL_64_after_hwframe+0x65/0xca
> 
> Freed by task 21948:
>   __kasan_slab_free+0x137/0x190
>   kfree+0x8b/0x1b0
>   __i40e_del_filter+0x116/0x1e0 [i40e]
>   i40e_del_mac_filter+0x16c/0x300 [i40e]
>   i40e_addr_unsync+0x134/0x1b0 [i40e]
>   __hw_addr_sync_dev+0xff/0x2f0
>   i40e_set_rx_mode+0x61/0x1e0 [i40e]
>   dev_uc_del+0x77/0x90
>   rtnl_fdb_del+0x6a5/0x860
>   rtnetlink_rcv_msg+0x5db/0x880
>   netlink_rcv_skb+0x254/0x380
>   netlink_unicast+0x454/0x610
>   netlink_sendmsg+0x747/0xb00
>   sock_sendmsg+0xe2/0x120
>   __sys_sendto+0x1ae/0x290
>   __x64_sys_sendto+0xdd/0x1b0
>   do_syscall_64+0xa0/0x370
>   entry_SYSCALL_64_after_hwframe+0x65/0xca
> 
> Fixes: 3116f59c12bd ("i40e: fix use-after-free in i40e_sync_filters_subtask()")
> Fixes: 41c445ff0f48 ("i40e: main driver core")
> Signed-off-by: Ke Xiao <xiaoke@sangfor.com.cn>
> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
> Cc: Di Zhu <zhudi2@huawei.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_main.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 1ab8dbe2d880..16b574d69843 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -108,11 +108,17 @@ static void netdev_hw_addr_refcnt(struct i40e_mac_filter *f,
>                                    struct net_device *netdev, int delta)
>   {
>          struct netdev_hw_addr *ha;
> +       struct netdev_hw_addr_list *ha_list;

Nit, needs to be in Reverse Christmas Tree (RCT) order.
> 
>          if (!f || !netdev)
>                  return;
> 
> -       netdev_for_each_mc_addr(ha, netdev) {
> +       if (is_unicast_ether_addr(f->macaddr) || is_link_local_ether_addr(f->macaddr))
> +               ha_list = &netdev->uc;
> +       else
> +               ha_list = &netdev->mc;
> +
> +       netdev_hw_addr_list_for_each(ha, ha_list) {
>                  if (ether_addr_equal(ha->addr, f->macaddr)) {
>                          ha->refcount += delta;
>                          if (ha->refcount <= 0)
> --
> 2.17.1
> 
> 


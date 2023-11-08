Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791737E532F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344004AbjKHKPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235492AbjKHKPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:15:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E5F1726;
        Wed,  8 Nov 2023 02:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699438550; x=1730974550;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qwSLstQkFoViqbKhrx7BfQMmIZd4aN/h/3T9h7XjXHk=;
  b=ECcP4udLSCoCxgFU6G1XZp/wsMCPuVCceQ9G8+ZR4L8u0e2GHdSJo6Gn
   o4fU51/YT/bN//D2g5HkKYeM9xTT8fNaIxdlWGPVc51D7y7eOwaVf0DLD
   UREW/60+aSEit1fm2OUMG/qoxUYuYelra6VoiedcPP4pU0pehW4jjRP05
   yhP4G2EXJIPwxTsggGhbNsUdtUl8rOK2XtBTU0gtOqCoR2SBtgKNCvocV
   0DP+pjOyvETxtOIyLEiUOIJbxubVYSZlSvK4Gc3T4tinQGgYbAlRQGkVU
   Eeou/8Gl/iWUL7fwfKOq9d/PLIbDogUSOA2CdCb4IsAaLroWxuWM2ievY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="420840656"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="420840656"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 02:15:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="792149634"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="792149634"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Nov 2023 02:15:49 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 02:15:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 02:15:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 8 Nov 2023 02:15:48 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 8 Nov 2023 02:15:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgF1sKRlDlb2ssoeGlEml8NTs+vCaE29JhvSs517b7i+eP0d99AfCndWMv6RVsEzqo3fARB1JQ1Bz81NGUJzeEQJ1jW2WpEzRIqHNb5dqrxPYYP1BZzi9NMewGrXo2A5DarIgo+QMRlkd1U7VkIRLz9XExL/2LVNLiIJ4/oLJ4NwVxjTgLMMGV+07RMymC/L5zZrBxP9tXSYq8CgHg5GC4KE3DTG9b1G1uE/I72AM2zxttRGyqoaCaEI6A+cyMLK46OC4Yp4ddbdlJQRoMdVXp0YJiw+zcLHF4siyShF2qDTc9yF173QWylvq1U1L3Md6fCOiPQxaL2/5vx1U3sjxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjX0NWR8w9pQl/bujXUgc5zWsqOn9exXX64MozJ5doE=;
 b=fcYo/ZglouDaZEsPixmMYj3qCmPe9v40PxSaBtG/N1nbHLkw5jhvCH7k8DV5iLVB8n/HtUvtHYMYcoA147Bpx/jPq6kjAHZhSJjOW6Q7OZ5y+bjEiXKChg+fVO/twfCnz4te+zdzbZdkcM4yUTRswboxvR+RCpHM0LziF8/4HaBX39m53xP4Ny3KQu3rp5Ap0u6lpI2cdn+Y9JTPeKHt2RGgAF5IRXTVAHqUZFKegeqG1MjJvvp7xqF/vCB/QClq9DsWga6iShW5GDKUaoYX072cD2e/QmwQSYGAoIo4nuys3ADlkIVbmHsbd2f3XrAcOugnHwKAHYB3K8jClOu6qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by MW3PR11MB4746.namprd11.prod.outlook.com (2603:10b6:303:5f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 10:15:45 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::4bff:ef3:3532:d7eb]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::4bff:ef3:3532:d7eb%5]) with mapi id 15.20.6954.029; Wed, 8 Nov 2023
 10:15:45 +0000
Message-ID: <70911c92-4272-cff6-857e-c95842b644c8@intel.com>
Date:   Wed, 8 Nov 2023 11:15:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH RESEND] ptp: Fixes a null pointer dereference in ptp_ioctl
Content-Language: en-US
To:     Yuran Pereira <yuran.pereira@hotmail.com>,
        <richardcochran@gmail.com>, <netdev@vger.kernel.org>
CC:     <eadavis@qq.com>, <davem@davemloft.net>, <reibax@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        <syzbot+8a78ecea7ac1a2ea26e5@syzkaller.appspotmail.com>
References: <DB3PR10MB6835D68E7E632532155AE585E8A9A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <DB3PR10MB6835D68E7E632532155AE585E8A9A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::14) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|MW3PR11MB4746:EE_
X-MS-Office365-Filtering-Correlation-Id: d06fd6b0-1d01-448e-d70f-08dbe043ab6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iSKGMTZwgaOaDMemsdOVoHHHBAHif5m7nIlTPLhasdwui6rxx5FjDDIvRQjesb7zvg/x3Hw2x+V7yFBMCGLBjIvlDV7RXpW3K1qhPQrxhTmHmBpCajiFPjsumK2IlGGBWiRcXM05YVU/srifP09cbvDM8h+uz64EoAJbgUUJmxjQChiJaZDfFAf44A4mq/GKhqXhFe1csMQs8kUZXCZ0efXzlc225KSEBN3q12pccqGk755gCMSheyJXxU0Isgeu3tUUVHRS9gclxmFs9QjtQmiggQ3NTeXLiTigC5U1X7oxzqJnYyzgNbZspPhHFm3t5tRQzPYQhPl4t7OaKlbJXgizhbfat0x8CYbd7PebIlEoO7LQIEfM229WwZdBWrZyQr2Oath8O7E2+90w2SZZtZ8egR3q0DPjGWYd36b7gOwoOoyipJoVP4XPMVqiqn6NHMlJJGcDMx81cO8E6npDIcxfUSO9R7XdR0/x53U2RLSGfuJ1a7CwWM9eSMU51q0RSdO6xb7jdythG26mamWr02X9stPCZHXYayPzeEckk1NeRaPVzskxZGmkjMqJM5hFwFK2HXcCeUXZuyyvBdbeC32OaD+o0mbNmz7mrXxZ72JJvt9Qto9b1fUTkZW7U63HO8Vk0fvzAVkxuhsGcRmL8p46SaN9kMtDnpFrQNi9VAk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(83380400001)(31696002)(38100700002)(36756003)(86362001)(82960400001)(26005)(6666004)(6506007)(53546011)(4326008)(478600001)(8676002)(8936002)(6512007)(6486002)(66476007)(966005)(66556008)(41300700001)(66946007)(316002)(31686004)(45080400002)(5660300002)(2616005)(99710200001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnEvVE1uSEFhVjd6Vzk3WGJZVUFlOWJiQlpKNXZxd25Od3E5dE5WMm52Z3Vm?=
 =?utf-8?B?RkM1bDA2anNKM3k0RXZ6djV6a2YremJKNVlGV3VqcXVEY0N0bXFTc2E1MEQ3?=
 =?utf-8?B?WHRJUURzUmFHTkQyUGpGOUpwdWdRK3d4SU5pRkZiYVIvakJPT0pRMkpLbWZV?=
 =?utf-8?B?bVpNNE9FTmsvbjhqdU9McFpWYUh6aTgralVwaU1JQWFVdGdXTnZCVDZsNkxM?=
 =?utf-8?B?cThQb0xlM3lSY3ZCbEtGdjBKUkJYYUFRRlJ6a3J1MUlYSmNNMUlBdHJXN01H?=
 =?utf-8?B?bElTem5kc3I0d1VzL0JjZCtZVDVoZjIxZ0VOUWV2NURpc2kvb2ZMRStvOTJR?=
 =?utf-8?B?SFBkWUIvYk9WbGhxeW9jcWgvTXBSM3hzVXh2QjBLR2ZpMmp2TG04dVN6aWtC?=
 =?utf-8?B?K09FWjVNZlNyMlNhQ2FPREtZRndUSlRvblNGUnNtbTRSNHBvSEJrYnFQdU55?=
 =?utf-8?B?RnJPMmxtSWVIdWFHRERmK0NVdFlUdFBJT3lYKzZOQW1pU1pvRDZmUGt1aXdW?=
 =?utf-8?B?YkR1TXovWm4zbXNoTmVRMkJSNko0ZU9SZXNXNDlRSnJzZlV6b2FFTlJteU5Y?=
 =?utf-8?B?VUFrS3drR3NLa0YwT2N5cmpWN3JLMXdZbzIyM2F4NkVOOE1TY2ZCbE5XUUll?=
 =?utf-8?B?WVN3bkIway9RM1d5RXM2L1RjODNEVmUzUlRVMWhBOU13UzE4UWthQXlTRE5u?=
 =?utf-8?B?ZWlhSzBxa3hDOXhpYkNLSkJLd0FZSS80Sm43TzJDaHFDNDkyYkhySHUrNDJV?=
 =?utf-8?B?c1JyV3lLWTFIczQxVXVCUmQ4Q0ZURXdPQ2pkNVBFaVZKZVhkN0gzam83d3px?=
 =?utf-8?B?SWVSbVlONnp0TzdoYytLeXhpeUJ1QTg2a3RkQVVzMmhoTE9OenVpN0dHVE1q?=
 =?utf-8?B?WkJvRnhaODl1ekNsQys0WDVHNXJaeE0xRVhrbFZHeEduWDdaMVFlUVk1Ny93?=
 =?utf-8?B?aytGOHdxcEpyK1JFckljQWo1OTJDc21UV0FQUytZdDB0TldsYXRhUzFQYTdm?=
 =?utf-8?B?V0MwMXpsR2dFY3Z0dVVCU0kwRklJWmVTR1NQM01raTZkZkRwYnNBWWk0VGd2?=
 =?utf-8?B?TXJiV0xheDF4dVNUWVQ2MWJPb2haSnJsT0lGRGJhcnNTajVuS1BwS3hyeUY1?=
 =?utf-8?B?UWNDWUR3YkV1cEd6bUp4S3gxbUd1YzBSWEg1SDVpSkdNb2JHbmVDd2hBVS9a?=
 =?utf-8?B?VmpaMDBwa1RSQ1VXWTM4ZGhHQlc0NjFkdW5FVURsVXV2TnVWNFFDeXBuZlUv?=
 =?utf-8?B?V2tuc202Y3FvYzAzYkV2aWFyZzZwS1VCbFp5YU95VjdqMTRhRzQzR3lQa2JM?=
 =?utf-8?B?aW1qWXNyQWxzQVZneFA2WkZrS2huam5RcXdFR3Y1cFNxVzNaMkVoanJKRnBh?=
 =?utf-8?B?UDhMVGZVWXA5Skp0T0VGV2t6cCtqNlUwYytteFBEcmlhTk95dlpzc1NRdmd4?=
 =?utf-8?B?dnMzT3NSMlBaVGpWVEJSUjF2MkZkaTRMV0VkVExJRTBIVHhFNGhGNUM2bFlz?=
 =?utf-8?B?SmpFeXZENEZwVUJycmh4UExSKzRTME1MdlJtY1NmcURqbDFlb0tYSDFYVjMy?=
 =?utf-8?B?Si9vdzZBb0Qwb3J2ajFXV2tjVDdmYXhNdjk2K1hacEZIRFlRL0trMmxhOTdF?=
 =?utf-8?B?cnYxeUdXVG9vd2djdXpEcG5nelBRM1dMRWREaVg3TmNJUmNoUU9FYmJONytU?=
 =?utf-8?B?ck9FUkMzWjBLMkdaYWlGRlZSMnQ4K1lUREtsOXVCRnppa1dBSFMwKzI4VlZO?=
 =?utf-8?B?aGZoYzJoU2FvUlF1aWJ5ODd5bUpYM0MrNUlKdTkxdTFYc3BwM1JjSjZsTjgx?=
 =?utf-8?B?UzNETVdRcnJtb2RFbjdoS2dTMXJ5czNnNmQ2ZENGbXZaOGVqaEpueXFhb2lz?=
 =?utf-8?B?Rlk1NFZRYWt2WHFsckx1WEVNbCsxMnJ0M1M0VHR3aFdoeGZsUUR1N3ducmM3?=
 =?utf-8?B?THFscVFLY0xKNE9RNzZSUERYd3pLMDQrazlqUkxtZTVKZkRFOEEzY2pldG4z?=
 =?utf-8?B?OUJXaFVzUndONnhtQnQ5MDltRmJCY2JtOEdDcFFEb2NRNEQ1UWE3aC9qNVZ2?=
 =?utf-8?B?cEZxc3hEQzlaODFIMHlZdjNTU0ZMYURWTk9EaTlDN1k3Q0tuajFLaU1nanZJ?=
 =?utf-8?B?Nmt5VmN3b1FRYStqKzhCTFF5emM1VW1CYUhHcy9oV1NvUDBYYk5HTzJ5T0lY?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d06fd6b0-1d01-448e-d70f-08dbe043ab6f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 10:15:44.9358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOLE3/iAipxasZxMWLpLVC/yM7GmH1T1vOcZeg4B5Je6joiqHlxrqugDoOQ7lKsOa5MoiF2s6IkuI669AQDU/q+ZICMoQcSkjVNgwgsJwDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4746
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/23 21:48, Yuran Pereira wrote:
> Syzkaller found a null pointer dereference in ptp_ioctl
> originating from the lack of a null check for tsevq.
> 
> ```
> general protection fault, probably for non-canonical
> 	address 0xdffffc000000020b: 0000 [#1] PREEMPT SMP KASAN
> KASAN: probably user-memory-access in range
> 	[0x0000000000001058-0x000000000000105f]
> CPU: 0 PID: 5053 Comm: syz-executor353 Not tainted
> 	6.6.0-syzkaller-10396-g4652b8e4f3ff #0
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> 	BIOS Google 10/09/2023
> RIP: 0010:ptp_ioctl+0xcb7/0x1d10 drivers/ptp/ptp_chardev.c:476
> ...
> Call Trace:
>   <TASK>
>   posix_clock_ioctl+0xf8/0x160 kernel/time/posix-clock.c:86
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:871 [inline]
>   __se_sys_ioctl fs/ioctl.c:857 [inline]
>   __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
>   do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>   do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
>   entry_SYSCALL_64_after_hwframe+0x63/0x6b
> ```
> 
> This patch fixes the issue by adding a check for tsevq and
> ensuring ptp_ioctl returns with an error if tsevq is null.
> 
> Reported-by: syzbot+8a78ecea7ac1a2ea26e5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=8a78ecea7ac1a2ea26e5
> Fixes: c5a445b1e934 ("ptp: support event queue reader channel masks")
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> ---
>   drivers/ptp/ptp_chardev.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> index 282cd7d24077..5b36c34629a0 100644
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -173,6 +173,8 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
>   	int enable, err = 0;
>   
>   	tsevq = pccontext->private_clkdata;
> +	if (!tsevq)
> +		return -EINVAL;
>   
>   	switch (cmd) {
>   

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>


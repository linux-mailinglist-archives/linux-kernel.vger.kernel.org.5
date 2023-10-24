Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBBF7D440C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjJXAad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjJXAa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:30:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4053510DE;
        Mon, 23 Oct 2023 17:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698107418; x=1729643418;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fWi4P9kYY9tJCRbrQy20LcGxchFKSoXUPQ9r7JG8gww=;
  b=ehVxm2KR607/l/anvf4a8z3pOAXXj17blivOaugpwJLJ0ychRofEh46X
   jP6xhPZDYHwx41QgH0K0/VcUdKf2HR1okVs3kOKhXwwz6tf0+iLKBj+1W
   IvaZStPZgtVUY2JG0Kl7slbutmOuweY28vKssJO/668nXq0IskPeZl/El
   0wWOJlp43a65XC4Nuhs6Qd5Ak0J6WFq89ZIuRv5arqwCi/Erbx5e12/mn
   Nfp2yO5PA0aNNIgdWRq7rm42Zf+261PgklXj/zOoqhbh756bb7F3OQVsM
   4yFx0WKMQrCnNsad8yQnr6Q7XF7loYqxTmk7dj3E40Q5dyJyJrqxHABDy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="372021159"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="372021159"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 17:30:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="1005492294"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="1005492294"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 17:30:16 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 17:30:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 17:30:16 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 17:30:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LG6h+x4DOMtqBZCKA+Isig3T3kGyjzH4DoWCc9iL+hBIROPYX0X4yjQQ9dKFSKksMFNB0LhPFr76Zzh8X6+ss2vbbx/99cf0FQJA7bOjsPNUtq/qL00x4vTCIWAWXPU5sq9+AwsR/A4Rhtw9tecRldgO9bqH34lBc8sxMHEguWo0Iif6+VvsrIAj3T503J5OxHxAuP9FLmUsk92eN0ua1oqrRhUJ0jAWjhYLoTbXFjiFgYOalgMVYibGc3+AX8doV7TIDYYwJQyw5X2CUiIeL8eL7Wont30yQpe81iFh2wxkF6eFOYpdazqln+hjjQbspQKhnT5TrFsT6BdpRNdlLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bgq30Ys2bwoyZpR5pn9CWdycw1SuaKlyOq1T/NEtyFU=;
 b=LYrAnVyPr3sctPbU+koBZlchQ5YMiCL+wqq1y+JayHM6DB7D8oWFvVGdtuBknKKtROVUsOL+OG0IAg3pBXNvzIlv8R08xNKAKcO+YmgaNfiBzNyfQZwSOER0M6MmiBZ1MzJy6mbMfLlb7RzUf7A7lGK7nEeDQTxA9DAA0fMiX2/X6r9ykpV5hSNXT+RumMSR4dD31a5JN5+h8lvpe0TfEv05/cl9BQet27r5V6K1tuUaskhttM92/Jk5x+C6k7ozgN577gz6CNZA2gFP369ihBEYob6E/SiJAnG6RaePSnPDmkX/Y9H8bz+1O/EiB4J6ktfWwjQjKL4OwKb6D8Lgmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB6527.namprd11.prod.outlook.com (2603:10b6:8:8e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 00:30:05 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1%4]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 00:30:05 +0000
Message-ID: <00c8d676-0389-47aa-b50a-66a9aa737ff8@intel.com>
Date:   Mon, 23 Oct 2023 17:29:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] liquidio: Simplify octeon_download_firmware()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        <dchickles@marvell.com>, <sburla@marvell.com>,
        <fmanlunas@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <veerasenareddy.burru@cavium.com>
CC:     <felix.manlunas@cavium.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <cover.1698007858.git.christophe.jaillet@wanadoo.fr>
 <0278c7dfbc23f78a2d85060369132782f8466090.1698007858.git.christophe.jaillet@wanadoo.fr>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <0278c7dfbc23f78a2d85060369132782f8466090.1698007858.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:303:2b::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM4PR11MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d8c214f-0f2e-47a4-c794-08dbd4285e26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 61TAFzlf2JtcIZxlKglbr58/qmn906CB6JH/8VggJpYBDoCIOhlqgecmTaEsYZX6fdv1lRzzPFVYMM+wlnEnkvGp0U8ZfmIB038srDKAe/AjwigJhe4kvRJBf/kT8p05nvS9j3RlkaXnlLpNSfAjRIRI8pznv1FQMZjvaPbYbPAvwysj5f8jNjtU1aCKunF49hR+tZ/oIVfR5OvBWPtIzR6/+KXXqrEyGpY0LgfyT5UVge0KapbhDAmRqs/p18VfbnJ5/LlDKDh4nCWVggTb3ZjN0esTIp88tPslwe4KQkXLwBOLOgcpOgTt9FZLo7RyKKygmwcLFmdJ3cag3TISp+AKgTjN+lNgVUssEgw48aMl3YHmSiQVfHS0S++FpR5Xi7nawOkh/inLjuCNjJo5OPxTZpff40A1G9AoOA6bGCt5vMuBnmeJnKY+X7fvZQmIVFeQbr2noX6phxjOA8PsFeiVwQd2E/2wJQd3A7MtdKncCmc2+vFsQZRKsofLOO0I6U6OV0kmJ5vsq8jYmwwDeZBvpA6t1/FRkmcJMnhT+GvPernzRKGBAjkWgd0DOWBcf685OP4QqCrdELOQVYkNoV0OEXi+Ms4H6Vhw0k9pDfyHNDKr8m9UhUsughGJsu2H/tvggU/HNgnirRZArjP87g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(41300700001)(2906002)(38100700002)(66476007)(2616005)(66946007)(316002)(82960400001)(66556008)(6506007)(26005)(478600001)(6486002)(53546011)(6512007)(83380400001)(86362001)(7416002)(36756003)(31696002)(5660300002)(4326008)(8676002)(8936002)(6666004)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDJBWGNyQlBvV2Y3dmpLNGVwUkRlNUd4V29kZTUxUzZyTTVGMkI2ZktMOVU1?=
 =?utf-8?B?RFB1QzBYNzNNT1FvUjZjY3doeVVIVHFZVjZDL2FwcitsbTdEbUJZUW1RQ00r?=
 =?utf-8?B?RkpncXdsVVJSeWtGN3B5TmNjNVUwemN0eXlYRXVTc3IyWktQem5KS3ErTzhZ?=
 =?utf-8?B?M2xGemwzVU1UclhmTUtlTXo3VDlVcU5pOFR5VkNtZnkxMG44alVhaCtXbnRq?=
 =?utf-8?B?Qm1EWm9URi8yU3pqTFpDUHlRa2tEWmJzWXZGNGpRaDYxcmpHc1VRUEhNYXBn?=
 =?utf-8?B?WTBaQTRrcXFseTNEcU44N05nNGFiWHFFbXluWWxGMXNYZnFnbVFBZTZoOVlL?=
 =?utf-8?B?OXoyQnZHeG1Fek5KbDlYWVJMeEZvOXU2bEhsVkFPenZKY1owbFFLbnl0bkt1?=
 =?utf-8?B?Wm9YQ1EwaWNvcXBLOWo0bFljelZIYmVsdGVXSWhaZnFGY0VwQ01mMGRQQXgw?=
 =?utf-8?B?SlJkTWcra3VEM00yTHlvS3lnQ3Ywb1RBUVZ6d3lZMSthS0FrZVZFdjVnQVZ1?=
 =?utf-8?B?NmhCanNYUW5ucVJLTWRmQ2J6SmpWRmxtN2VPNUJkdmJkSTFVSEhJaFhXbG5H?=
 =?utf-8?B?d3lYazNNR2dIQ3E3bDNhWGNyKzJySHRPWlE1N21BR3NsOTd6dnMrVXVqaXE2?=
 =?utf-8?B?RXJHc0xVTTg3OUZWR0gyUlFDOTBTSXFkMWRUVU1CVGx1a3RrdXNRbHpBZGhF?=
 =?utf-8?B?NnNkdi9vZkwzU25zNkZXZGY1bkZEU1R0U3F1Wm1aaTJxb3RESS9FaGQ3T2U3?=
 =?utf-8?B?bEJ0Tmh5RE1qT3E0ZCtHUkU1QXYyRGxqUU5wbXRnQWVaZ1RlUnVHQzQrOElj?=
 =?utf-8?B?NnkyOTZIdDVPdS9TbEZkcS9yOUpwQlBjb1N2L0pSNzFNLzJRU2Zyd1dSbGE1?=
 =?utf-8?B?N0swUnVxMHJGT29KVkR4Vk54V0JBUmdianVyNDZBNVUyZHNCb3J4UGtzUWdJ?=
 =?utf-8?B?dEVtWTI4UzRvSFhGMkNRWk1qOENQcmJuREs4S3dER3dnN1ZJMEV1T3NUdTFQ?=
 =?utf-8?B?TS90ZFdWakpuYkpsdWJjVWJ4KzF6M05NL2N1RE52SkhHUlFCWll2Nm5HYXlR?=
 =?utf-8?B?R1R0RmV1c0lvbXRJa0ppZkZFMUtZZW1Ucm9rZFVDSWoyaXdwNWRLbDJySFpR?=
 =?utf-8?B?TkZyZm0xWDBNd1hJQno3c3dTc25mVll4alVLY3RpWjRXaGdFSnIyQ1N2K21J?=
 =?utf-8?B?WXoxVWRoZmxnWmE2UUxPN0hqem5rTzZMZWxHeVZQbXBwOCtPUzBoUGltaXQx?=
 =?utf-8?B?aCtiNGNxV2JuMjQyZFRqY3AwUTYrVjI3bS9Gay81c3c0cDNUVWFkN3RXRXBR?=
 =?utf-8?B?NG5kUjB4M0tTdlNTa3BlU1VrQmNKRE5zVXpFcDBOMU94c2c4WmFXdER4SUkr?=
 =?utf-8?B?Z2dvVmFML2g4ZHB0bGhKK2xETW10RldrdElDUVJ0RHlpZ1k1Y3ZObUVycUI5?=
 =?utf-8?B?MjJXdU9MSW9XT3ZIRmJxVU9sSTdoa2Q2dldlcmJkWlA2WHpHMFhXeURaS3ow?=
 =?utf-8?B?Vy84Mk5tMUpMbUZOdlZocTJrN2xzc1lqRXZZSnN3SzdtWHFLMFNmeTFQTXVz?=
 =?utf-8?B?bHFpREp6RVo2Z3pLYVpKcmh0T0hwM054L2h3dGhKT2lyWmJ1SWMrSHg5YTJC?=
 =?utf-8?B?ZnhFNDIyM2VWbHFwMG8rbk9EdHZIclVQMGEzOG1iS3ZEaUNDVjdCSEpVeWpM?=
 =?utf-8?B?YjUwTnJKM1pEdXBwbVo3NjlZYTY3OU52QXdhZzZPczVxdG9SWEhXQXFxazdR?=
 =?utf-8?B?V21TMTIzK1FrMGpYNTF4OVByWlRkN1U0cGpIMmo1cTh6aFB5Z29PVC90YXZs?=
 =?utf-8?B?TjQ5SGppN1hGM1AxaHNXdGpEV216THhueDJ1ckdwMkMrMHBjMk5iM1FnN1Nk?=
 =?utf-8?B?ZWhGQVFFTVNlRTBOY3dJK2VhMnp5TVhxWXFmZlVwV0E4RW9jSElTRlFOLzUx?=
 =?utf-8?B?dDVoVmJodmlxdG5RODlzaEdsNnVpZnl5b0ZHSVJ5ZzlVN0dkN01VWHBONWE2?=
 =?utf-8?B?bGVRb1dlSGppeFB2WEVGV1RyaHowd3lrQjl1WXhaVEJlZ2cvQS9UN2VNREpm?=
 =?utf-8?B?dEFJaXR1OTcwaHNvYS9jemw5Vzd4SlpZY3NTbWpQRDF2TE5kN1JPOXVNb3lC?=
 =?utf-8?B?c1BwaXJiUmhKcEpMaFFndG1maWlTRlAwRTdSN2ora20xU2hTUVdHaXRRdlVI?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8c214f-0f2e-47a4-c794-08dbd4285e26
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 00:30:05.0215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ew3uQpAPvegoxpguVbxSGV8SEPdVv+BsYPohObt68PkD4aufc6QI7FYCWrAoXpw4P7p1VS3XyCBkCpK9N3wfgHEJ+3GQbOdbjs7TuAq0vEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6527
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/22/2023 1:59 PM, Christophe JAILLET wrote:
> In order to remove the usage of strncat(), write directly at the rigth
> place in the 'h->bootcmd' array and check if the output is truncated.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> The goal is to potentially remove the strncat() function from the kernel.
> Their are only few users and most of them use it wrongly.
> 
> This patch is compile tested only.
> ---
>  .../net/ethernet/cavium/liquidio/octeon_console.c   | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_console.c b/drivers/net/ethernet/cavium/liquidio/octeon_console.c
> index bd6baf2872a5..f1f0d7a0309a 100644
> --- a/drivers/net/ethernet/cavium/liquidio/octeon_console.c
> +++ b/drivers/net/ethernet/cavium/liquidio/octeon_console.c
> @@ -802,19 +802,17 @@ static int octeon_console_read(struct octeon_device *oct, u32 console_num,
>  }
>  
>  #define FBUF_SIZE	(4 * 1024 * 1024)
> -#define MAX_BOOTTIME_SIZE    80
>  
>  int octeon_download_firmware(struct octeon_device *oct, const u8 *data,
>  			     size_t size)
>  {
>  	struct octeon_firmware_file_header *h;
> -	char boottime[MAX_BOOTTIME_SIZE];
>  	struct timespec64 ts;
>  	u32 crc32_result;
> +	u32 i, rem, used;
>  	u64 load_addr;
>  	u32 image_len;
>  	int ret = 0;
> -	u32 i, rem;
>  
>  	if (size < sizeof(struct octeon_firmware_file_header)) {
>  		dev_err(&oct->pci_dev->dev, "Firmware file too small (%d < %d).\n",
> @@ -896,16 +894,15 @@ int octeon_download_firmware(struct octeon_device *oct, const u8 *data,
>  	 * Octeon always uses UTC time. so timezone information is not sent.
>  	 */
>  	ktime_get_real_ts64(&ts);
> -	ret = snprintf(boottime, MAX_BOOTTIME_SIZE,
> +
> +	used = strnlen(h->bootcmd, sizeof(h->bootcmd));
> +	ret = snprintf(h->bootcmd + used, sizeof(h->bootcmd) - used,
>  		       " time_sec=%lld time_nsec=%ld",
>  		       (s64)ts.tv_sec, ts.tv_nsec);

Maybe I am missing something here, but why not combine the boottime with
the original write of bootcmd? I guess this is being updated
periodically? The overall solution used here feels like the wrong way to
do it... I guess the bootcmd is setup else where but I couldn't find the
relevant code for that.

What you did seems ok to me, but it still feels like there is a simpler
way to achieve the desired result.

Thanks,
Jake

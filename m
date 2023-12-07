Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB06808C18
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443495AbjLGPnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbjLGPnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:43:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3076710F7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701963829; x=1733499829;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g5go5E6yw+YpYc381GEscm64stVZBIKwrU1yPV68bX0=;
  b=HfKgquXYVQI5wxrmu0ENNkLR5jQDEYV5EV6yxm60lbOLMFsr/lb74MRG
   cDvzoUhlQQGURx+1MgvSxG7ZfaS5Mh0SJdqOhFcJSWDUwJkzmhYIPDIbc
   6e8fsDhcvJs68+LVKWhYHNUPeHiFpXiEYnvLZcHwAO6rtXXQmwjHZIvzX
   SIjSSaq+4mdPB26RVDLG26ADnhoDcnr3YGvyl4JDTEAiJmWDeHc6jiHEC
   ATwC88ItbOuSteCcyVZwHUro2OMAcpmWDzFNdAXldhMBON7WzEfHBTFax
   UTW17P/j3xl07wE0PazHyFLFMDsBrLkdBxTniPPrL1fsvFfbnFlULXHUG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="393987393"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="393987393"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 07:43:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="945078673"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="945078673"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 07:43:48 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 07:43:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 07:43:47 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 07:43:47 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 07:43:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGp7YRiKKLOtYOcSsRXXJ+6TnP5lKQ0LAQmyvPsaHHzYLNjtm4B9xuzzi4dfyzcPL5IDxnzJxTXSFCbC4xO+2XOqxK7i1EBI6fCHdE+JTAGk1+dTUe7mKQc4HYoMkEkGMtDRDXJpqJ0m6HWje98lxoAU6FWT4T93ety2FXQp0281itKaxzaADMEGSywhyX/FlHiO9ATO/9NKUvFhJAAlmTLxsh2WSlLu3SxZ0fzn5RO6GtPx7DGnVuY9LmGu/QyPUu/qRPzWvvCH/Ho3BcnuMbeCzmB9JCW5vazUp/6W5JsB1rqoeSkd/GzffTViZEQTeXbBNAmV00I7xF4wEknNWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WU40mmlk6Hi711hn2F7ZaKi59fgZPMqFfPMvgizGjOs=;
 b=FtfD75wa1drKjLAbvCPWqxlPhNw7yoSGuzLwvq78Bl4xS9MoqeCFFOeC6Fdb5umXEhzKnl3PZJcU/TW2Fg5UQzGxuRuqlaZyYPXM3PYv/cISYM6fgQZZINZJOsf4byFLlD3+myPSwhcw0AkvAye0tHj0UAch1klSRWX772kYVUNueUM7krPdg32wdvJI7FjohIS77Wf5WCMUJEMq0YantDHazQ7kKhd0PSgwqteR6RqMYWO8FoO19Qa6uMl0Wv5QpPcWWY4eo2eV786IqSwtZ1YpzF32PI+29lHXVVtBZ+xafUb+DLc5zFMi2qm5uy9F8Oe4AKeDMigaOTTtJvZYKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CH0PR11MB5473.namprd11.prod.outlook.com (2603:10b6:610:d4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 15:43:45 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 15:43:44 +0000
Message-ID: <23a91617-4562-4399-a8c6-df2f3f28c7a9@intel.com>
Date:   Thu, 7 Dec 2023 08:43:42 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] nvdimm-btt: fix a potential memleak in btt_freelist_init
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
CC:     Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <20231207034332.24107-1-dinghao.liu@zju.edu.cn>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231207034332.24107-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0180.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::35) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CH0PR11MB5473:EE_
X-MS-Office365-Filtering-Correlation-Id: 35b1ca92-895c-4ded-adc3-08dbf73b4b83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q1hUSDm/g+s6RRS/lIskIyd8rFXD54NZeEvutZl3qtgISNbUgPWdZh/3ixb0Sz3OhSr445NXvZNwmBHktzxTiOWidc2LnR5WW384JHsVvZxt7m/7vAPKKvKD3fR/0jm4Dvh7WBwv3PVK3TeKTVzrQW6MtMhIw1d8L2IFGKuvYz0g8ZnwS3UElAxrfPzKj67II7DHUbF40x2poSsngmMP4Az5pOtiCUCbkTEz8bjfVi3tnN069vcWgq79pbO0i2mKqk+QH8QkngBHvcMzPIvg/rs6sWCY1IjcJohijDCrrA/h8pSeyvXClegdn50aUNKbhgiLZ979Hj50SpYNOXUm2JnOLuXSBWpiipOE8CH22VXFesgOofzVDKI/asfBeb5QiydLLBgkeS1wB43ATPfE+GV7hf/5mLErIfFaFaJnLmV1bl7oFFrXjrksetKRj+cbTrI3ongV4X7ajUxxYmN8oyL/ukx25CMWlxsv8J2VW/L60iKsX443iAa0K+HDQ651elLm6wYz8GEyZFZZoDbV6eNxDRE6x19jR7DsdPdKFhxORtUlUT3lvvSFrfNAkENoGDh660zYZ1R62zkDKZBl0lG3d2+qpV6X4Otn02/c6FY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(8936002)(8676002)(82960400001)(83380400001)(41300700001)(36756003)(26005)(6916009)(316002)(31696002)(4326008)(86362001)(6486002)(966005)(66946007)(66556008)(66476007)(54906003)(6512007)(2616005)(2906002)(478600001)(44832011)(53546011)(5660300002)(6506007)(31686004)(38100700002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWFHK2RRVG9RblZwd1VXelI3bFU1QTY0SEpIb3JLc056MVhlVmtKVzc3cXVy?=
 =?utf-8?B?OEdzdFNzMTZQMGFvSnJMSUZFNyt1ZVBlNzJwa2p5OU4rNi9qNXpjRTVBS0Ru?=
 =?utf-8?B?bWlnTmthQXVFekVLSFJZUk9Od1lYQkZoSzFqbkJjQUJNM0JhMXlOT3RWMitp?=
 =?utf-8?B?cytPNzc2QU9Jb0F5dllCU1poS0N1ckxCTllxdGRKeUladmJ1V0w3dHQ5OUVy?=
 =?utf-8?B?RmdyZUtveUlKODFoaThVZGpHenJ1Z2FHUzhhMkh6cmVpTXpCY3MwbExrc2VK?=
 =?utf-8?B?K1FiUE44VWVTdkFaQXVCeFkyOUhNUVBWd3B2YW50eStydzZuUWhOV3o2cEsw?=
 =?utf-8?B?dUxUUDRSNlBwejZvVzRPaGZaS1VxWWI2K1gyS1J5bTUvVy9TQ1U4VGFqWDJs?=
 =?utf-8?B?V1oyQzFzamN0TzNzOGVkVjJjZXVMcVVkcTZBNG1VSnpCVWtpaldJV0EwdmV6?=
 =?utf-8?B?bGEzaEJ3Qkhld2xhUVV2WjFodWFGYUw1VTVYQmE3U1VYdTkzZ3dCM3h6QlNG?=
 =?utf-8?B?aTAyOFBCOXN1eEFJeG5Jek1GTXowM0MrS09HNVRIbnJKek15YXA4dGVXN1pm?=
 =?utf-8?B?ZEF0bEFaTzJBaGgxaTA4Um1QT3pQMEt1WUk1NVVya0djUFdDNkh6Q2Jqbmh4?=
 =?utf-8?B?cHhTRi9QQzgvNk1UV0dZSy9hNXdGODVEbVEyczdkS3lkQndmNmN4aHF0Zmxo?=
 =?utf-8?B?NkYvdjV4TWJveE5qb3c0RHQ2TzFMVFdJM2dOWVFXa2tYQXJ2VWlJSStvTXFM?=
 =?utf-8?B?S016WElIOTlRdW1FNVBPc1pTRjRENnU4ZnkzY3J5YjlLaXJGd3dXYkNwWEpt?=
 =?utf-8?B?eTc3WU5lR2pobHRxVHBiM1UvOHVBVE1kYmJvLzBuMWNvY0s0NXRPd2pkTVR6?=
 =?utf-8?B?Y25jeHpLSE13R1ZZSThaa3MyUzRFWW9POUVkaEJRRVhHTUl6RS90Qlp1dm50?=
 =?utf-8?B?Q2ZFL3JPOCs3c0w0QWxiNEtwb1VnNWVSSjZCTEthVXpEdCsvRnFrUFBsdXJM?=
 =?utf-8?B?TkNZVkJ0K3FrVmFZeExPVWE5WmZRMEt6NDNhRUJYVGw3S040K05YVjFDc0RN?=
 =?utf-8?B?MDV2NlVZa2M4cWtGd1U4RWFFdkZDZk5LRkF3M3FkWjkvT3hzdzAzcHlKdytL?=
 =?utf-8?B?Skp0dncvK2ZDeXY0dzhhMFl0NEVIc29GVjAzTzkrR3dqMTVRQkcyb3pmMkhJ?=
 =?utf-8?B?bjZHcEJTU2hpR2wwdXA2RnlaSVJYS0g1OWVZUmtoenFVSXhPeDZsUi9MaVJW?=
 =?utf-8?B?YjNrclVhZEhza1ZiNkFjUXcxWDh4bGEzTGxndFRwVVM2OExSN21UUmFjalg2?=
 =?utf-8?B?eTJkR1dwVzhYY05oY3hrUEJidFRhVW0rL1lRR1pJS3B0N2Irc1l4UzBOaU5l?=
 =?utf-8?B?eG56dTJ1YjRJeU5abkNhblBBaTQ5bXFzcy8vNS9ZUVNlMU01YkxieVc4R2I2?=
 =?utf-8?B?eE1ybURoRDdCZnpUdFdpNnlpT0gwT1JwcENHN2s2cDlNcHpFSzVJWTA1M3dy?=
 =?utf-8?B?dHBSc0IveE9ZMFR2ODk4ZGZMa2lqTTRPa0F3RVNkZEExZnFKbmp2SjdsUVZQ?=
 =?utf-8?B?OUhQUTlHUGR0aGZiMnF6ckUxY1EzL2VDWVVMSUgwZmdRZExNbHhTRWoxRVNS?=
 =?utf-8?B?Z2RqWmQxSTh4anNPVUZZS1JKemVHUVZvUkdJSFR3RmFSNXhXU2xEbjlBdys5?=
 =?utf-8?B?MlZ4eFdwSGRhcVRNUlR5SWU1VmhTcDZoOHJOWnR2OGZ2T3dQNGZXenBaWFU0?=
 =?utf-8?B?d1FOTVBrTzZ4U2xicVhTcWpMejNEeWJ5TWtnaENKUWdjUG5BYWY3OGcxOThJ?=
 =?utf-8?B?WTNxTFNNbUUrZVNrdVZ5d1A1VVVidWtJbEVOZzc5NmZYZEt6NEYzazQyUy9G?=
 =?utf-8?B?blFxcmpkOGNNbXA4SHJiZ2k3RHZKdVVWb2h0VUJxQlQvQzhYd0RlRThCNU5F?=
 =?utf-8?B?OXU2VGNKMjR6QmRsazNTNU0wQUFXUlQzZ3BNRUlLdGQzWjhlV1lHWG81Q2dH?=
 =?utf-8?B?dmRnS0tPWEh2dlJxUEN0Z1FJNCtMTHgwd0FuK0lYd290S2UzR21VRzhYWCth?=
 =?utf-8?B?blNiTGlRZ2pWMGhvWUZPbnpHek1qNGp4WGo5bnVlN3Z3MUlONFBjRUgzZFhj?=
 =?utf-8?Q?RiH9q/bHwrYRWeZy6X4gNpW1f?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b1ca92-895c-4ded-adc3-08dbf73b4b83
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 15:43:44.7317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yea1k/i8yVBgsUQ/gnFu9nz1ILW0Z6P9tuidq19zg44ysPTqfyuA6zJzpg1vlgJpLdNJFG3gQDbRHkZ4aM49Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5473
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/23 20:43, Dinghao Liu wrote:
> When an error happens in btt_freelist_init(), its caller
> discover_arenas() will directly free arena, which makes
> arena->freelist allocated in btt_freelist_init() a leaked
> memory. Fix this by freeing arena->freelist in all error
> handling paths of btt_freelist_init().
> 
> Fixes: 5212e11fde4d ("nd_btt: atomic sector updates")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

How about use the new scope based resource management and we can avoid the goto mess altogether?
https://lwn.net/Articles/934679/


> ---
>  drivers/nvdimm/btt.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
> index d5593b0dc700..d8c4ba8bfdda 100644
> --- a/drivers/nvdimm/btt.c
> +++ b/drivers/nvdimm/btt.c
> @@ -544,8 +544,10 @@ static int btt_freelist_init(struct arena_info *arena)
>  
>  	for (i = 0; i < arena->nfree; i++) {
>  		new = btt_log_read(arena, i, &log_new, LOG_NEW_ENT);
> -		if (new < 0)
> -			return new;
> +		if (new < 0) {
> +			ret = new;
> +			goto out_free;
> +		}
>  
>  		/* old and new map entries with any flags stripped out */
>  		log_oldmap = ent_lba(le32_to_cpu(log_new.old_map));
> @@ -577,7 +579,7 @@ static int btt_freelist_init(struct arena_info *arena)
>  		ret = btt_map_read(arena, le32_to_cpu(log_new.lba), &map_entry,
>  				NULL, NULL, 0);
>  		if (ret)
> -			return ret;
> +			goto out_free;
>  
>  		/*
>  		 * The map_entry from btt_read_map is stripped of any flag bits,
> @@ -594,11 +596,16 @@ static int btt_freelist_init(struct arena_info *arena)
>  			ret = btt_map_write(arena, le32_to_cpu(log_new.lba),
>  					le32_to_cpu(log_new.new_map), 0, 0, 0);
>  			if (ret)
> -				return ret;
> +				goto out_free;
>  		}
>  	}
>  
>  	return 0;
> +
> +out_free:
> +	kfree(arena->freelist);
> +	arena->freelist = NULL;
> +	return ret;
>  }
>  
>  static bool ent_is_padding(struct log_entry *ent)

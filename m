Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EC881350A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573827AbjLNPmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjLNPmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:42:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8558B2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702568570; x=1734104570;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=85X5k5Gb1mvc/ptXBfLE8wKhGNT+OitJXxLMLl2qjqU=;
  b=XBOvXJlcvQu4sfZWp3dXI/7d9gIX6VH2MWIFafvgpP17Uyq74o4ON8LB
   OI815NvNMIoIQsO0HMljLT7mRbb0cpgkSDxnpqURFEujIS8p0id5Hdf1t
   G4jIBB0uA/JkLjhhNWJ8s2BRzSOOTf9JpqTtGDv4foDrEYCSGmn61to7M
   e54thEij8YmYwCazM5cor+36sJmS7eGKI+KH4z4cA2jEo5TcrxL9LGwtl
   duGMCUBrdZEP/Gx9WR2XxsIKsY0/6r/gqRdMXVea0ht1xpI3DXHHsXSaa
   FmzS+lM0s6xUddmxrkBfOy3PMx8+rxgH5ar/do7QEf7STK2lRuimwfp1u
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="385549500"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="385549500"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 07:42:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="724097174"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="724097174"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 07:42:50 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 07:42:50 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 07:42:50 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 07:42:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNCqtETgvtGRbH+lbY/qoIYbGcQGKJ/7UvCIRJf3FnVyTsJh3jlf6THLlcvgesNJlJCmF8pXfsOyVSgkx29NbNakA2XFGHCQMD8VGSg9RC6UyGwzZCzfpj127HN7orTJo4elhj+Bv7ZkCe00ZTvuTJkf+dJrHBYUAurzUd52elgXUMcdxkWCyPxkA/RVc+mV60VOfYQSJShMjSVNOqFtR6+pzpsgYWvMmJmqrwnjAnlvr6Fyb8tEEP6hB46PDs9qwvrCXQWfAR5JSR7QsZYWBZKvCH195ac526ibmTFM+L6TtE8PGwfCUmrXgvz+pX64R4aW/8izZL9btaLw+dU1MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbaCZfddO/y3ZQkgDSCeTifnCMrWbIPhEApwkO3hV00=;
 b=dibuQMjNnSOuGOmv2Bxz0EA9BkXodAsZGBvkdx3zNV6leFtH2KmxKzxWrT9u/UPS3j1kI+0j21xNIY96Nz+Sqh1v+Rf9Mv4WPGU0UnDPygRRBodV4XeSDCh2bar9o35yzfeiGNB3sfdY2d3jWfEA1BgcF9toZq3zXuw2zkliDPqY+7l/Zdc97q7QgkTh7Dy79M+XYSTzdMFSqwRczTaZoK9Jhff1KIw1tr/EOqhYXRlFLmyRM5Y+zTy/nDiAzsJ7ngQ2pCQRI42dYruKZ9OeY0qmddWGBTnkXN56XdVbViE/tvrcin56aPOV7apKnjElz+86TYN+zAy6QfgPn+Br+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SN7PR11MB6921.namprd11.prod.outlook.com (2603:10b6:806:2a8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 15:42:48 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 15:42:47 +0000
Message-ID: <470a8f03-02aa-4e74-ab69-7722db1b619f@intel.com>
Date:   Thu, 14 Dec 2023 08:42:45 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] [v2] nvdimm-btt: simplify code with the scope based
 resource management
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <20231214083919.22218-1-dinghao.liu@zju.edu.cn>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231214083919.22218-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::16) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SN7PR11MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: a44e21f3-121d-4510-1592-08dbfcbb5278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wUk5Kkys2Wns/RZxbbC4w0F0Bbhgw8K52CHN5E34SrX7c2CnynmakP0dBl71m1kYaOy6RU8On8WhTvzTtrrl7EgSrP535khg4IFtz3rwAYm3XZ3kDyJqS4yHpWxtuifewmBH7hY2h7cDLCxMuTf9bBEkKOlcM0cYEtmVwfgbZCuAO+rAM92Ri3o7mvTn6NZI/3GvVSKB4ANTQzqcLlSbJkyNHB5cGPpqLNxB4Dq3+H/kSyj5x5XxeHcU2gKosNtrzylmIDe9nacQ9gzUEszLsP4gAisqWZWVOd7G3GijJBP5xnV1aZOH0s+qQFEYnhYCtWwUk7Zr2LC+7VM//XjojXjqJVisjt3S8xgq5+Fyx4kjfILWKe3pmdCbhkLLPAyuAbY+KnKyjNzdQblkiZiPZaLaatvT/VRkZ5ThedbeIUEoL3sgBSEHqOaKg5ly3VFl0ZVMItd7yheCNsu3AoQgrVGLkHe5bZZyJqUiHuWv/MGbkyC4waq272pCd8E22ffDx7XQsRbjypWuZCmB44KVSmBAfu2hUB7y4Edmmdf77M8UcNGRqBIAjQpU0QWuvTrBPO3Nl6ZiZRvQJ9lIF0JYHYyJRj5nRNfpOkx+yRRP1W6hEFR5DH2Yd0AsM004TQE0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6512007)(36756003)(478600001)(6486002)(83380400001)(86362001)(2616005)(41300700001)(31696002)(5660300002)(44832011)(2906002)(26005)(8936002)(8676002)(82960400001)(4326008)(38100700002)(66556008)(54906003)(66946007)(66476007)(316002)(6916009)(6506007)(31686004)(53546011)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2JJaXpsOUhxdEtaLzNLYWFYZFR2VUxUb05HbTBqT1UzZzV2TGFyUUxGOEd2?=
 =?utf-8?B?TGI5cVFWdVVoWWRVUk8rK3M2QkhUdUdIVGpsUm01VmxlV0J1YVo2V1dwY2pm?=
 =?utf-8?B?cXZ4ZGd0ajNnbHUvMnE1TzNUUFFxMEUrdnFWVUJHS3Fla2t3Z1hxdEhPcSty?=
 =?utf-8?B?aTJRRTJENmFKRUVhZFFIc1haUzhqZnBmSEpRYXpJaEhCUldudTlkOGFySE5m?=
 =?utf-8?B?bHhhTHJneDdqQUhhZGphNFk0NitCNzVteURsaVFWZ01yVW5xN2F0cGNibXFa?=
 =?utf-8?B?RDZudVpVMkZmZ3ZHdkVoSXZCTnI0MUpHZG43ODk4aDdiUUw0aExNSWpFTDZm?=
 =?utf-8?B?b3dGMy9ML0pQRE5PMEJabGFLTk9GdTRDd2FMaFF0Mzg5dGo5YlN0THEzNnRZ?=
 =?utf-8?B?MGMvdEdTVndmaGt4bWttb2pwYmJSWUZ0Y1lHbGwxWFBQWGx5RUhuSnEvTmVu?=
 =?utf-8?B?K2NYYmRIU2t2WU1Cd2VPR0djYzNwRVJnL3dhaEZ0NmdSSVJ5dG9xQWJjMVpY?=
 =?utf-8?B?cDBCWUtjT3l4dVhRREh6QzJ6czhsNWxqWUFkT2didE52cjR4eEVTZ1paaU9i?=
 =?utf-8?B?UEdFSkxIL05naWp3emMrWEtkYVRDNmo0OUw3UkVBQmM4RjJ5QXFsWVNmQTRu?=
 =?utf-8?B?eTdMWWYwVlBnUDcvZmhieU85QmdOUHNUYjdneW45NE1US255R2JQL1laMzg3?=
 =?utf-8?B?NE9FNFM0K3kramd5WUVUMWtpdkM4QlJsVjY4TU56SG1rUGx1MWVPZ1JIZ2xO?=
 =?utf-8?B?N3V0RURVT1ZkbGhOck9xelRERFYyMll2K3dsZVdxTUFnTU1VWkhhdFhNRlFo?=
 =?utf-8?B?enVMcXo5M2RuN2dNSHdhWVlBWUIxYWhnMExRL1B6RzBuQU9scE1YMDZESkV0?=
 =?utf-8?B?L3M0QndYZUxaYitiRGd4cTA2VDBMSzN2QzIyczlmK3NEeWVLWlNsQnpUamdM?=
 =?utf-8?B?dzVsNlN3bG9qcVRzY1p2enY0VjgvdUJwUWhLWDhzRHJVVnhyOStvdWJxVjRl?=
 =?utf-8?B?VFY3cUc4R2FwZU9rU01HMTdwUm9TdzZ4R0ZlUjRHWEZ1eDBmUDluUmdVZGdj?=
 =?utf-8?B?R0x0QnBGYzJPdGp4U2ZXMldndTNFVk14QmNYVjJiazNidG1CcHhYdGRkMWNz?=
 =?utf-8?B?RGYydG5mVmlPRlVhT3dzdktTMXRlL2h1YkpyZVFaYUhuMStWU3lWZGc1M1dZ?=
 =?utf-8?B?dE5BeVM1b3VpaCs3WXF1OWU3RVhxZGR4M2UybzlHN2VWN3ZVcWlVYTJnZG5v?=
 =?utf-8?B?aURWQ1lZWDg2UVBFclEwUFY0SGVoQkNhUzA1RGdLblNBa0tNV0IrZUxQWTVs?=
 =?utf-8?B?aTRiRHdRUEM1T3crUFcwZHhiWkZCd3RJRFkwbER3ZEZ4RzlGTENmWUlNQXFZ?=
 =?utf-8?B?QmtuL2pqOWRJQXUzVVF4SlRKUitzNDNRVndDU3hYVm94WmNvWkxyYWgwbEFL?=
 =?utf-8?B?bmZHQWc1MGFsYStQUW9iZWpSYWhVdlVSUzROMG43Sm5kN2ZCQ2JZS0RoRmtI?=
 =?utf-8?B?dkVLTE1aaVIwQ2FrRVJwZXF2ZEp5eEFiY1lUa0F0dXpqNEZlc0FXa3I1YmY3?=
 =?utf-8?B?MlcwRVdhWmFGUEpIVDN1OVh5aGUyK3k5R1FEc3FuaXluU25Maiswb1BkUDJp?=
 =?utf-8?B?dHBWNXgzd05CVTJ4aFlnVVpERlBxMHgxVWJpbVE2NXRFUUhOTkhqenFxWnVi?=
 =?utf-8?B?aEcrOTBPVkVQSittcE5Fb0lMYTJXaUdjaG1EOFFIazZ2Z2d0Z0VRNzlsdEZT?=
 =?utf-8?B?d0pSRTFOQlBvWFZXTlVFQzVNTW9SZ291ZTIwNXFJejZXVFpqbnFvY1djWUVm?=
 =?utf-8?B?R3RvakdOWjZLK216WDAvRW5jb0hFZzVxNGdUS2tpMHRaZXA1YkdJTmdwM0Fo?=
 =?utf-8?B?V2pmUHc0NzNBb0xpVTk1cFdjMkhiS3pZR1VwOUY4blNNa3VmdHJGaUJ2eHJF?=
 =?utf-8?B?WXc0bzJ0T2l5TzBEMU0yb0NHZmhjZFhUUXQrcU5pMURFU0NyQTNwYTBGcjVh?=
 =?utf-8?B?U3ZmeGxqQUtDMENaYUxYQm9qUkdwUVU2UXJUWndDT3E3ZXNvWnorZisyN1ZC?=
 =?utf-8?B?dGQxeVZKbnVwcHZFTUxNVXovWjBZa1NsMEJTcEpKamlWZzQwR3dHWXhFL3FS?=
 =?utf-8?Q?XWOmx4Uu3gWeZ2UIKudbNzoJw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a44e21f3-121d-4510-1592-08dbfcbb5278
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 15:42:47.8522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxkMO3YnLUErM5abGoXl04CngLXMh/eRUCV6oxZcldm3XI97ZrGUOraHCDNydxiG7HgAccm8VNXR9PEOl9QDrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6921
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/23 01:39, Dinghao Liu wrote:
> Use the scope based resource management (defined in
> linux/cleanup.h) to automate resource lifetime
> control on struct btt_sb *super in discover_arenas().
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> 
> Changelog:
> 
> v2: Set the __free attribute before kzalloc.
> ---
>  drivers/nvdimm/btt.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
> index d5593b0dc700..32a9e2f543c5 100644
> --- a/drivers/nvdimm/btt.c
> +++ b/drivers/nvdimm/btt.c
> @@ -16,6 +16,7 @@
>  #include <linux/fs.h>
>  #include <linux/nd.h>
>  #include <linux/backing-dev.h>
> +#include <linux/cleanup.h>
>  #include "btt.h"
>  #include "nd.h"
>  
> @@ -847,23 +848,20 @@ static int discover_arenas(struct btt *btt)
>  {
>  	int ret = 0;
>  	struct arena_info *arena;
> -	struct btt_sb *super;
>  	size_t remaining = btt->rawsize;
>  	u64 cur_nlba = 0;
>  	size_t cur_off = 0;
>  	int num_arenas = 0;
>  
> -	super = kzalloc(sizeof(*super), GFP_KERNEL);
> +	struct btt_sb *super __free(kfree) = kzalloc(sizeof(*super), GFP_KERNEL);
>  	if (!super)
>  		return -ENOMEM;
>  
>  	while (remaining) {
>  		/* Alloc memory for arena */
>  		arena = alloc_arena(btt, 0, 0, 0);
> -		if (!arena) {
> -			ret = -ENOMEM;
> -			goto out_super;
> -		}
> +		if (!arena)
> +			return -ENOMEM;
>  
>  		arena->infooff = cur_off;
>  		ret = btt_info_read(arena, super);
> @@ -919,14 +917,11 @@ static int discover_arenas(struct btt *btt)
>  	btt->nlba = cur_nlba;
>  	btt->init_state = INIT_READY;
>  
> -	kfree(super);
>  	return ret;
>  
>   out:
>  	kfree(arena);
>  	free_arenas(btt);
> - out_super:
> -	kfree(super);
>  	return ret;
>  }
>  

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEBF78F611
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 01:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347846AbjHaXUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 19:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjHaXT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 19:19:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9010FE54;
        Thu, 31 Aug 2023 16:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693523995; x=1725059995;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hh1LFQ4DYtoSthtgI/YqAirLSV8B9G4zGLUEZOGL6J8=;
  b=Dtl9RQOuYWo8mqDgwOlAzBSfXlSt7Jwl/v8eagDMU1BTFyI8/GfTc8p4
   aGm9eVnKK0/6Yd0/uxqc21hM1QXOdeo20A0cFA777rTbNNyaLjl/w3DE8
   bK1LX8dborcNG4XmLUhyC86pEkLDCAr/RgR6otHUG7YEqIcgpFnpq+f5r
   piXhkwrMU6fSkhfMNyoqbmXVJPe6OXz3ak3S7cN2t8rSYxihzn/vXbBNA
   C06SY0MUGqz8w0BTLwuydJqIZViayqYXzom6SlQPMY+d+xkFSCXW2aGR2
   dVlavWTyEY/RN94hbGKgMBriKLZnEp38TyqwfyVVma7goZVRmZngA4FRx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="376026105"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="376026105"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 16:19:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="768981033"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="768981033"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 16:19:54 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 16:19:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 16:19:54 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 16:19:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qv9IvMTRz8vlh0s8NvvHBPw4nv8QCZlwcmrS0DK0geynJrig85/wXHQ5oxmIhj0aobTlPipqSH4SVQyBGNhNV0qqDdq3JNVPZBnXV/lS+6obKXQ7CrclVMIKTemp2KOeqgQ/jp3jEWF/eXX9UzXEQv0e/Nbt8yFUsdg6+iEb69BNVBhWXOad41x9CG4Ep/oYj3RGPROTIN6z1NWe1KdbO+hskvjoVWF2BarYi4iUHctbmD3SPU3I0Molhw7wk17dDWdVy94pXjBCTIt4jjkBmecGxyZmtyNLFnzNKk3Ogl3LKEQqcnEyUimwCgPr5r9xhFvpYOSt3FkihHzMUGBsug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8zxQ83MlkKKzrPFlmrhmUEAHU5JcZCtpuYPV1oTZGs=;
 b=SW/CeEMogBdRp8tbrfxOSkOBmDyQFhtFZwTCh3eKj51wGkMFw52M5BeCyffoOqMLe8YaCMPopMGD7nmTcpHjJeZCcXCbWpWLG+O1SbaxKK1q6eFkbXQ7KIajKzU7Ph9ZRAnZRxmXl7SN2q8kwEoscaofXUQeXaHQTP7gsjIT2oF+r7PhjgRAzvlcrVnfHFtkqYuqmsyzsOt4VfKbhgz7ijL76DNB7oarobyXrsDkKhJiSAcrC3LXLDe8XitpXfMAHOnju9eJ2eGqFdToM9147qa9xBp1Pm4UdoM64CQB/ZGjTFY+c/38HfJaxC7Sj61dAotZRE1eL2DqcxGS0lEjQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CYYPR11MB8407.namprd11.prod.outlook.com (2603:10b6:930:c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Thu, 31 Aug
 2023 23:19:49 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6745.022; Thu, 31 Aug 2023
 23:19:49 +0000
Message-ID: <65c609be-3dd9-8b73-d4b1-cb8cacb1a40a@intel.com>
Date:   Thu, 31 Aug 2023 16:19:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH RFC v2 17/18] tools/testing/cxl: Add DC Regions to mock
 mem data
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-17-f740c47e7916@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-17-f740c47e7916@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:a03:180::37) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CYYPR11MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: 38219083-4220-4a87-1c46-08dbaa78c55f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RSnaTRQyo9yGs9O8DnfvYPzVXwUz3LfECTfQBUv6mj/sOV2c3IZACqXEWqXSk8SfnSZfq1myDPub5Vayg8VmfGlONLK9CCVUKFV/ylAcutQioUdLVjPkaU+JqRH2DOg5AKryOVoycMcVBVpKqml6vHb3KpASVTlJ11OHxXRMcV+Eo7V+xGl1vYLfo9eDagS+mNVnbYDqonU2ACcAr2Qb/sIdRl6pm8enKX0K00uNvkbkdscI3ktG3S3O67qqyQhFAH3gX5cKx3oPEk2yZ84DfdvfBta6KPMefxmloPzHU+okgjcuu7LkRLEKG17NbDAhXj4I4e0/FVkks9/Q8NM7xd83olZnr6ZI+lGx3EVuYS7D1llOdEYxWPx/PKIWzHB+w5jt9GKEQFpHIsC9Vt4gf6bvMiVxcEm39jU37wahsz6Q3Z6BfikHq54U/1F7bjBpwzSLB7NJUowcmhVdm3rBAWg/5ZaolYVvffajecY+PkeI6nRBnnVkNJK2x2GqFag+M7AKAslsi5pMv6EBCS1Gqir6bLYBgFVoa8NNO3+Fx7SxROwVMehrzE5ozGuvoB7sW4r3O67zmWwzs9vYHF9gTnU/Sj1mXSmdaH8fsygz21i2ZGe1BCmR21arC4UujhfI8z06yd1fgJK0WE4k1BStaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(39860400002)(366004)(186009)(1800799009)(451199024)(8936002)(6666004)(478600001)(110136005)(53546011)(31686004)(66946007)(66556008)(6506007)(6486002)(66476007)(54906003)(6636002)(316002)(38100700002)(41300700001)(82960400001)(6512007)(44832011)(26005)(83380400001)(5660300002)(36756003)(2616005)(2906002)(31696002)(86362001)(30864003)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ai9JZGtyWXkvbElzR01QZktrUUUyOEJYSk5QSlZpckRJdXNUWHNrRXdjR0Vh?=
 =?utf-8?B?emZuV0JsdXoxTjI1c1ZoSjY4WG1rQTk2cytPcy9xVWZGU1Rpb2JLcml1RGpJ?=
 =?utf-8?B?RGRZREljMFR0bWhRcEdETzF0RHVrMzQ5aWFPVDNKM1ZJZkVRUE9nZFp2djZY?=
 =?utf-8?B?cnd5SVVobGgrSC8yRGFpaUhxZVRKUzhEdHpUOUk3akZRdWlpTDJ4WFRSVjhi?=
 =?utf-8?B?MU04RHE3SjFJN0pucUQ1clNVRkliQVBQbnMvVXI1Tk43elorWmVGeWN4Y054?=
 =?utf-8?B?NGw2emttS3I2aEpJNGgwNklWTGpSdUtzcmhwck5uV3BnaU9FVHhGdDM5UDZq?=
 =?utf-8?B?VjFBLyt5eWJ1Z0hpeUNqaEFRWFlaN1k0TEZqS1VybXB2ZlN0SUp0bW42U1NK?=
 =?utf-8?B?Ump5RFJKMlg2V3FOVm03ZXhrN1RVcjZNd1QvcjZ4bTI3N25LRFRMSW5Ma2h5?=
 =?utf-8?B?WmFnd1d3NGNuOCthQlJBeGpwcnUyNG9TVGh6bmp5ZVlQYnpRODQ0Y3pJZHBE?=
 =?utf-8?B?SG93bFVDNUhxUVJWN1M5MldFeTVCZlN4RTVvTnVZTGVIbkVZN0wwanFKbGVE?=
 =?utf-8?B?aEFZNUhWdW00RVdSeUtyOStVbzBWd3h5NmFNWGdkNFRRa2UxTERXWWt4cXJy?=
 =?utf-8?B?S1Vsa05hYnNBcHY5RTZTSjJ3Z3k2NDFsWXB5dDNkcVlCc2EvbmhRL2ZxSURz?=
 =?utf-8?B?WWVtcUp0VHRDNzVQTTBEdGdCa2lZeUVqVUhMTnhGOStVdmgwZ3M5NjV6ZmVL?=
 =?utf-8?B?WHlMM2d1MEkxMThxMFo4V0pBVXo1cHVvZ0hNcll0Q0VwbnZzS2YxbnJTMkRM?=
 =?utf-8?B?cjhoa0JZRnc0ck1uSk5KcnFkNzBpOEtTM21tSURrVS9zNExaS1Fta1FBNU4z?=
 =?utf-8?B?L2tickNyczV0RFFzdjVkVlMrR0JmeU9jMXhUNGFxbG5ZTUhyYmZvWUJEMi9l?=
 =?utf-8?B?MFdTMDhrYVlwbnZQS0JRaFh0Wm9YUDJTdUM3ZVFXdUZrUnBOY2VOWDdRVklV?=
 =?utf-8?B?aVo0T1JVV0hXY0NGdlMzK3FVU21nL2MxYkRhdlF4S0dFOTdQR0JsTjgzMUEw?=
 =?utf-8?B?T2tOc0dFWEFWcUcwblozQWdlQUVlWldMK3V4cEUwVGdmbWRYUjA0eXVjMEVZ?=
 =?utf-8?B?WTcwK0VGRVJIb3RUblIrYXZlVkpiSGVOTTlUUVc4NlRrV2VQUFdVWWpFc0tj?=
 =?utf-8?B?OWJmeEZGbXdaRmxlVjJuNE5PWThVbm1xTVlRazlrODhuS2tQdjNtRHZpWjBj?=
 =?utf-8?B?RjYxZjM2UnVCS0grelRlY2RRNXdnY2hqYW9Yc3hQUVRDQ3lWcTRkUW45dUpQ?=
 =?utf-8?B?WFBmN29rVlc2WUprU2xzR013dGhRR1ZxL28vQjd5NllRa2FKZXF0NnpWekp2?=
 =?utf-8?B?ZnVFUHpCWFNXTjJQNzAzVll3bk1xbFBEUmZwd2ltS0ZZUVVOTUdwdFVTbWtw?=
 =?utf-8?B?R0Rubi9aa2E5SWpCaWU4Z3RlaTc3Q3FmN0tEd2Z4bFU1dkxOT0dUWlVIK2ht?=
 =?utf-8?B?Q0ZXWFFmYTAvY0U0WXYyVWg0Y1pDUWxZMXdqT2Jya25wL2hOWUJRenBmbDh2?=
 =?utf-8?B?VlJPOFhqRSs2aWo1K2c3R3MzeC9iUDdaSjh6bXQ1VjVHWjBGUnkxRTYra2w1?=
 =?utf-8?B?aDd5ZDdnZVl1R2dVSjRzenlDZjJLM2JFWWJiZEZPU1MzeFRPV2ozZ0Rpb1dr?=
 =?utf-8?B?Mm80OEJaNU84aHphY2tCV00vTWlSQWE0L0NCd3ZPVFdLSS9DVEdJYWg2emZx?=
 =?utf-8?B?VklzdjZXbkd0WGlhVTNob2tKNzJBL0V5L2ZGbnBmaXl4YzhVNktncDJDaE5V?=
 =?utf-8?B?SjhLN2M3UTZIRnZ4eGZkMVJsV0xPWnFBSGZ3a3ZYTUwzYnI0TXpJV0RWazM0?=
 =?utf-8?B?RGZ4YU95SUpTdWd3L1U2RUdNZXZEaXZOTWJvaHk3N3hWd2ZRalh6ckVRS0Zu?=
 =?utf-8?B?SWZIWHBDV2M5N1hNakZVSVFCWnBTNklZbUhFMHFJbjJteEhpMS9WeDNmbDdh?=
 =?utf-8?B?c1JlRVk0Q2xWdy9obW05Q0ludkExWE9uZnY0aVZBV3FIRkF2SjA0NXVjbEJG?=
 =?utf-8?B?cjkvTWhPTitNaXdaK0phYTVCNXVRazZqNytqOTdFMUM5cUtmQmJKNWExR1hI?=
 =?utf-8?Q?IZyVgx7OMpCifj02poUHjynwT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38219083-4220-4a87-1c46-08dbaa78c55f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 23:19:48.9723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uaNyGJ8H35NbFNJBThzqcNKZRwahfCYmdKQojzc2I1gZXgthtFZzpB6mCWKCSdRxXsTg1bz4HDu4qREa8db0qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8407
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/23 22:21, Ira Weiny wrote:
> To test DC regions the mock memory devices will need to store
> information about the regions and manage fake extent data.
> 
> Define mock_dc_region information within the mock memory data.  Add
> sysfs entries on the mock device to inject and delete extents.
> 
> The inject format is <start>:<length>:<tag>
> The delete format is <start>
> 
> Add DC mailbox commands to the CEL and implement those commands.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   tools/testing/cxl/test/mem.c | 449 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 449 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 6a036c8d215d..d6041a2145c5 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -18,6 +18,7 @@
>   #define FW_SLOTS 3
>   #define DEV_SIZE SZ_2G
>   #define EFFECT(x) (1U << x)
> +#define BASE_DYNAMIC_CAP_DPA DEV_SIZE
>   
>   #define MOCK_INJECT_DEV_MAX 8
>   #define MOCK_INJECT_TEST_MAX 128
> @@ -89,6 +90,22 @@ static struct cxl_cel_entry mock_cel[] = {
>   		.effect = cpu_to_le16(EFFECT(CONF_CHANGE_COLD_RESET) |
>   				      EFFECT(CONF_CHANGE_IMMEDIATE)),
>   	},
> +	{
> +		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_DC_CONFIG),
> +		.effect = CXL_CMD_EFFECT_NONE,
> +	},
> +	{
> +		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_DC_EXTENT_LIST),
> +		.effect = CXL_CMD_EFFECT_NONE,
> +	},
> +	{
> +		.opcode = cpu_to_le16(CXL_MBOX_OP_ADD_DC_RESPONSE),
> +		.effect = cpu_to_le16(EFFECT(CONF_CHANGE_IMMEDIATE)),
> +	},
> +	{
> +		.opcode = cpu_to_le16(CXL_MBOX_OP_RELEASE_DC),
> +		.effect = cpu_to_le16(EFFECT(CONF_CHANGE_IMMEDIATE)),
> +	},
>   };
>   
>   /* See CXL 2.0 Table 181 Get Health Info Output Payload */
> @@ -147,6 +164,7 @@ struct mock_event_store {
>   	u32 ev_status;
>   };
>   
> +#define NUM_MOCK_DC_REGIONS 2
>   struct cxl_mockmem_data {
>   	void *lsa;
>   	void *fw;
> @@ -161,6 +179,10 @@ struct cxl_mockmem_data {
>   	struct mock_event_store mes;
>   	u8 event_buf[SZ_4K];
>   	u64 timestamp;
> +	struct cxl_dc_region_config dc_regions[NUM_MOCK_DC_REGIONS];
> +	u32 dc_ext_generation;
> +	struct xarray dc_extents;
> +	struct xarray dc_accepted_exts;
>   };
>   
>   static struct mock_event_log *event_find_log(struct device *dev, int log_type)
> @@ -529,6 +551,98 @@ static void cxl_mock_event_trigger(struct device *dev)
>   	cxl_mem_get_event_records(mes->mds, mes->ev_status);
>   }
>   
> +static int devm_add_extent(struct device *dev, u64 start, u64 length,
> +			   const char *tag)
> +{
> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
> +	struct cxl_dc_extent_data *extent;
> +
> +	extent = devm_kzalloc(dev, sizeof(*extent), GFP_KERNEL);
> +	if (!extent) {
> +		dev_dbg(dev, "Failed to allocate extent\n");
> +		return -ENOMEM;
> +	}
> +	extent->dpa_start = start;
> +	extent->length = length;
> +	memcpy(extent->tag, tag, min(sizeof(extent->tag), strlen(tag)));
> +
> +	if (xa_insert(&mdata->dc_extents, start, extent, GFP_KERNEL)) {
> +		devm_kfree(dev, extent);
> +		dev_err(dev, "Failed xarry insert %llx\n", start);
> +		return -EINVAL;
> +	}
> +	mdata->dc_ext_generation++;
> +
> +	return 0;
> +}
> +
> +static int dc_accept_extent(struct device *dev, u64 start)
> +{
> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
> +
> +	dev_dbg(dev, "Accepting extent 0x%llx\n", start);
> +	return xa_insert(&mdata->dc_accepted_exts, start, (void *)start,
> +			 GFP_KERNEL);
> +}
> +
> +static void release_dc_ext(void *md)
> +{
> +	struct cxl_mockmem_data *mdata = md;
> +
> +	xa_destroy(&mdata->dc_extents);
> +	xa_destroy(&mdata->dc_accepted_exts);
> +}
> +
> +static int cxl_mock_dc_region_setup(struct device *dev)
> +{
> +#define DUMMY_EXT_OFFSET SZ_256M
> +#define DUMMY_EXT_LENGTH SZ_256M
> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
> +	u64 base_dpa = BASE_DYNAMIC_CAP_DPA;
> +	u32 dsmad_handle = 0xFADE;
> +	u64 decode_length = SZ_2G;
> +	u64 block_size = SZ_512;
> +	/* For testing make this smaller than decode length */
> +	u64 length = SZ_1G;
> +	int rc;
> +
> +	xa_init(&mdata->dc_extents);
> +	xa_init(&mdata->dc_accepted_exts);
> +
> +	rc = devm_add_action_or_reset(dev, release_dc_ext, mdata);
> +	if (rc)
> +		return rc;
> +
> +	for (int i = 0; i < NUM_MOCK_DC_REGIONS; i++) {
> +		struct cxl_dc_region_config *conf = &mdata->dc_regions[i];
> +
> +		dev_dbg(dev, "Creating DC region DC%d DPA:%llx LEN:%llx\n",
> +			i, base_dpa, length);
> +
> +		conf->region_base = cpu_to_le64(base_dpa);
> +		conf->region_decode_length = cpu_to_le64(decode_length /
> +						CXL_CAPACITY_MULTIPLIER);
> +		conf->region_length = cpu_to_le64(length);
> +		conf->region_block_size = cpu_to_le64(block_size);
> +		conf->region_dsmad_handle = cpu_to_le32(dsmad_handle);
> +		dsmad_handle++;
> +
> +		/* Pretend we have some previous accepted extents */
> +		rc = devm_add_extent(dev, base_dpa + DUMMY_EXT_OFFSET,
> +				     DUMMY_EXT_LENGTH, "CXL-TEST");
> +		if (rc)
> +			return rc;
> +
> +		rc = dc_accept_extent(dev, base_dpa + DUMMY_EXT_OFFSET);
> +		if (rc)
> +			return rc;
> +
> +		base_dpa += decode_length;
> +	}
> +
> +	return 0;
> +}
> +
>   static int mock_gsl(struct cxl_mbox_cmd *cmd)
>   {
>   	if (cmd->size_out < sizeof(mock_gsl_payload))
> @@ -1315,6 +1429,148 @@ static int mock_activate_fw(struct cxl_mockmem_data *mdata,
>   	return -EINVAL;
>   }
>   
> +static int mock_get_dc_config(struct device *dev,
> +			      struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_mbox_get_dc_config *dc_config = cmd->payload_in;
> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
> +	u8 region_requested, region_start_idx, region_ret_cnt;
> +	struct cxl_mbox_dynamic_capacity *resp;
> +
> +	region_requested = dc_config->region_count;
> +	if (NUM_MOCK_DC_REGIONS < region_requested)
> +		region_requested = NUM_MOCK_DC_REGIONS;
> +
> +	if (cmd->size_out < struct_size(resp, region, region_requested))
> +		return -EINVAL;
> +
> +	memset(cmd->payload_out, 0, cmd->size_out);
> +	resp = cmd->payload_out;
> +
> +	region_start_idx = dc_config->start_region_index;
> +	region_ret_cnt = 0;
> +	for (int i = 0; i < NUM_MOCK_DC_REGIONS; i++) {
> +		if (i >= region_start_idx) {
> +			memcpy(&resp->region[region_ret_cnt],
> +				&mdata->dc_regions[i],
> +				sizeof(resp->region[region_ret_cnt]));
> +			region_ret_cnt++;
> +		}
> +	}
> +	resp->avail_region_count = region_ret_cnt;
> +
> +	dev_dbg(dev, "Returning %d dc regions\n", region_ret_cnt);
> +	return 0;
> +}
> +
> +
> +static int mock_get_dc_extent_list(struct device *dev,
> +				   struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
> +	struct cxl_mbox_get_dc_extent *get = cmd->payload_in;
> +	struct cxl_mbox_dc_extents *resp = cmd->payload_out;
> +	u32 total_avail = 0, total_ret = 0;
> +	struct cxl_dc_extent_data *ext;
> +	u32 ext_count, start_idx;
> +	unsigned long i;
> +
> +	ext_count = le32_to_cpu(get->extent_cnt);
> +	start_idx = le32_to_cpu(get->start_extent_index);
> +
> +	memset(resp, 0, sizeof(*resp));
> +
> +	/*
> +	 * Total available needs to be calculated and returned regardless of
> +	 * how many can actually be returned.
> +	 */
> +	xa_for_each(&mdata->dc_extents, i, ext)
> +		total_avail++;
> +
> +	if (start_idx > total_avail)
> +		return -EINVAL;
> +
> +	xa_for_each(&mdata->dc_extents, i, ext) {
> +		if (total_ret >= ext_count)
> +			break;
> +
> +		if (total_ret >= start_idx) {
> +			resp->extent[total_ret].start_dpa =
> +						cpu_to_le64(ext->dpa_start);
> +			resp->extent[total_ret].length =
> +						cpu_to_le64(ext->length);
> +			memcpy(&resp->extent[total_ret].tag, ext->tag,
> +					sizeof(resp->extent[total_ret]));
> +			resp->extent[total_ret].shared_extn_seq =
> +					cpu_to_le16(ext->shared_extent_seq);
> +			total_ret++;
> +		}
> +	}
> +
> +	resp->ret_extent_cnt = cpu_to_le32(total_ret);
> +	resp->total_extent_cnt = cpu_to_le32(total_avail);
> +	resp->extent_list_num = cpu_to_le32(mdata->dc_ext_generation);
> +
> +	dev_dbg(dev, "Returning %d extents of %d total\n",
> +		total_ret, total_avail);
> +
> +	return 0;
> +}
> +
> +static int mock_add_dc_response(struct device *dev,
> +				struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_mbox_dc_response *req = cmd->payload_in;
> +	u32 list_size = le32_to_cpu(req->extent_list_size);
> +
> +	for (int i = 0; i < list_size; i++) {
> +		u64 start = le64_to_cpu(req->extent_list[i].dpa_start);
> +		int rc;
> +
> +		dev_dbg(dev, "Extent 0x%llx accepted by HOST\n", start);
> +		rc = dc_accept_extent(dev, start);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dc_delete_extent(struct device *dev, unsigned long long start)
> +{
> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
> +	void *ext;
> +
> +	dev_dbg(dev, "Deleting extent at %llx\n", start);
> +
> +	ext = xa_erase(&mdata->dc_extents, start);
> +	if (!ext) {
> +		dev_err(dev, "No extent found at %llx\n", start);
> +		return -EINVAL;
> +	}
> +	devm_kfree(dev, ext);
> +	mdata->dc_ext_generation++;
> +
> +	return 0;
> +}
> +
> +static int mock_dc_release(struct device *dev,
> +			   struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
> +	struct cxl_mbox_dc_response *req = cmd->payload_in;
> +	u32 list_size = le32_to_cpu(req->extent_list_size);
> +
> +	for (int i = 0; i < list_size; i++) {
> +		u64 start = le64_to_cpu(req->extent_list[i].dpa_start);
> +
> +		dev_dbg(dev, "Extent 0x%llx released by HOST\n", start);
> +		xa_erase(&mdata->dc_accepted_exts, start);
> +	}
> +
> +	return 0;
> +}
> +
>   static int cxl_mock_mbox_send(struct cxl_memdev_state *mds,
>   			      struct cxl_mbox_cmd *cmd)
>   {
> @@ -1399,6 +1655,18 @@ static int cxl_mock_mbox_send(struct cxl_memdev_state *mds,
>   	case CXL_MBOX_OP_ACTIVATE_FW:
>   		rc = mock_activate_fw(mdata, cmd);
>   		break;
> +	case CXL_MBOX_OP_GET_DC_CONFIG:
> +		rc = mock_get_dc_config(dev, cmd);
> +		break;
> +	case CXL_MBOX_OP_GET_DC_EXTENT_LIST:
> +		rc = mock_get_dc_extent_list(dev, cmd);
> +		break;
> +	case CXL_MBOX_OP_ADD_DC_RESPONSE:
> +		rc = mock_add_dc_response(dev, cmd);
> +		break;
> +	case CXL_MBOX_OP_RELEASE_DC:
> +		rc = mock_dc_release(dev, cmd);
> +		break;
>   	default:
>   		break;
>   	}
> @@ -1467,6 +1735,10 @@ static int __cxl_mock_mem_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   	dev_set_drvdata(dev, mdata);
>   
> +	rc = cxl_mock_dc_region_setup(dev);
> +	if (rc)
> +		return rc;
> +
>   	mdata->lsa = vmalloc(LSA_SIZE);
>   	if (!mdata->lsa)
>   		return -ENOMEM;
> @@ -1515,6 +1787,10 @@ static int __cxl_mock_mem_probe(struct platform_device *pdev)
>   	if (rc)
>   		return rc;
>   
> +	rc = cxl_dev_dynamic_capacity_identify(mds);
> +	if (rc)
> +		return rc;
> +
>   	rc = cxl_mem_create_range_info(mds);
>   	if (rc)
>   		return rc;
> @@ -1528,6 +1804,10 @@ static int __cxl_mock_mem_probe(struct platform_device *pdev)
>   	if (IS_ERR(cxlmd))
>   		return PTR_ERR(cxlmd);
>   
> +	rc = cxl_dev_get_dynamic_capacity_extents(mds);
> +	if (rc)
> +		return rc;
> +
>   	rc = cxl_memdev_setup_fw_upload(mds);
>   	if (rc)
>   		return rc;
> @@ -1669,10 +1949,179 @@ static ssize_t fw_buf_checksum_show(struct device *dev,
>   
>   static DEVICE_ATTR_RO(fw_buf_checksum);
>   
> +/* Returns if the proposed extent is valid */
> +static bool new_extent_valid(struct device *dev, size_t new_start,
> +			     size_t new_len)
> +{
> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
> +	struct cxl_dc_extent_data *extent;
> +	size_t new_end, i;
> +
> +	if (!new_len)
> +		return -EINVAL;
> +
> +	new_end = new_start + new_len;
> +
> +	dev_dbg(dev, "New extent %zx-%zx\n", new_start, new_end);
> +
> +	/* Overlap with other extent? */
> +	xa_for_each(&mdata->dc_extents, i, extent) {
> +		size_t ext_end = extent->dpa_start + extent->length;
> +
> +		if (extent->dpa_start <= new_start && new_start < ext_end) {
> +			dev_err(dev, "Extent overlap: Start %llu ?<= %zx ?<= %zx\n",
> +				extent->dpa_start, new_start, ext_end);
> +			return false;
> +		}
> +		if (extent->dpa_start <= new_end && new_end < ext_end) {
> +			dev_err(dev, "Extent overlap: End %llx ?<= %zx ?<= %zx\n",
> +				extent->dpa_start, new_end, ext_end);
> +			return false;
> +		}
> +	}
> +
> +	/* Ensure it is in a region and is valid for that regions block size */
> +	for (int i = 0; i < NUM_MOCK_DC_REGIONS; i++) {
> +		struct cxl_dc_region_config *dc_region = &mdata->dc_regions[i];
> +		size_t reg_start, reg_end;
> +
> +		reg_start = le64_to_cpu(dc_region->region_base);
> +		reg_end = le64_to_cpu(dc_region->region_length);
> +		reg_end += reg_start;
> +
> +		dev_dbg(dev, "Region %d: %zx-%zx\n", i, reg_start, reg_end);
> +
> +		if (reg_start >= new_start && new_end < reg_end) {
> +			u64 block_size = le64_to_cpu(dc_region->region_block_size);
> +
> +			if (new_start % block_size || new_len % block_size) {
> +				dev_err(dev, "Extent not aligned to block size: start %zx; len %zx; block_size 0x%llx\n",
> +					new_start, new_len, block_size);
> +				return false;
> +			}
> +
> +			dev_dbg(dev, "Extent in region %d\n", i);
> +			return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +/*
> + * Format <start>:<length>:<tag>
> + *
> + * start and length must be a multiple of the configured region block size.
> + * Tag can be any string up to 16 bytes.
> + *
> + * Extents must be exclusive of other extents
> + */
> +static ssize_t dc_inject_extent_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	char *start_str __free(kfree) = kstrdup(buf, GFP_KERNEL);
> +	unsigned long long start, length;
> +	char *len_str, *tag_str;
> +	size_t buf_len = count;
> +	int rc;
> +
> +	if (!start_str)
> +		return -ENOMEM;
> +
> +	len_str = strnchr(start_str, buf_len, ':');
> +	if (!len_str) {
> +		dev_err(dev, "Extent failed to find len_str: %s\n", start_str);
> +		return -EINVAL;
> +	}
> +
> +	*len_str = '\0';
> +	len_str += 1;
> +	buf_len -= strlen(start_str);
> +
> +	tag_str = strnchr(len_str, buf_len, ':');
> +	if (!tag_str) {
> +		dev_err(dev, "Extent failed to find tag_str: %s\n", len_str);
> +		return -EINVAL;
> +	}
> +	*tag_str = '\0';
> +	tag_str += 1;
> +
> +	if (kstrtoull(start_str, 0, &start)) {
> +		dev_err(dev, "Extent failed to parse start: %s\n", start_str);
> +		return -EINVAL;
> +	}
> +	if (kstrtoull(len_str, 0, &length)) {
> +		dev_err(dev, "Extent failed to parse length: %s\n", len_str);
> +		return -EINVAL;
> +	}
> +
> +	if (!new_extent_valid(dev, start, length))
> +		return -EINVAL;
> +
> +	rc = devm_add_extent(dev, start, length, tag_str);
> +	if (rc)
> +		return rc;
> +
> +	return count;
> +}
> +static DEVICE_ATTR_WO(dc_inject_extent);
> +
> +static ssize_t dc_del_extent_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t count)
> +{
> +	unsigned long long start;
> +	int rc;
> +
> +	if (kstrtoull(buf, 0, &start)) {
> +		dev_err(dev, "Extent failed to parse start value\n");
> +		return -EINVAL;
> +	}
> +
> +	rc = dc_delete_extent(dev, start);
> +	if (rc)
> +		return rc;
> +
> +	return count;
> +}
> +static DEVICE_ATTR_WO(dc_del_extent);
> +
> +static ssize_t dc_force_del_extent_store(struct device *dev,
> +					 struct device_attribute *attr,
> +					 const char *buf, size_t count)
> +{
> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
> +	unsigned long long start;
> +	void *ext;
> +	int rc;
> +
> +	if (kstrtoull(buf, 0, &start)) {
> +		dev_err(dev, "Extent failed to parse start value\n");
> +		return -EINVAL;
> +	}
> +
> +	ext = xa_erase(&mdata->dc_accepted_exts, start);
> +	if (ext)
> +		dev_dbg(dev, "Forcing remove of accepted extent: %llx\n",
> +			start);
> +
> +	dev_dbg(dev, "Forcing delete of extent at %llx\n", start);
> +	rc = dc_delete_extent(dev, start);
> +	if (rc)
> +		return rc;
> +
> +	return count;
> +}
> +static DEVICE_ATTR_WO(dc_force_del_extent);
> +
>   static struct attribute *cxl_mock_mem_attrs[] = {
>   	&dev_attr_security_lock.attr,
>   	&dev_attr_event_trigger.attr,
>   	&dev_attr_fw_buf_checksum.attr,
> +	&dev_attr_dc_inject_extent.attr,
> +	&dev_attr_dc_del_extent.attr,
> +	&dev_attr_dc_force_del_extent.attr,
>   	NULL
>   };
>   ATTRIBUTE_GROUPS(cxl_mock_mem);
> 

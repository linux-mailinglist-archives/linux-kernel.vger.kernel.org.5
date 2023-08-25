Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3760C7882A9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243959AbjHYIvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243935AbjHYIu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:50:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E191BCD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692953455; x=1724489455;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=kxGvtoXKkZec+kiynVtOvy9/MSXZZ88P1EabzeuuKmA=;
  b=B9OIMf+L/QzBWwvr7u1EQ4PTDoElfDoooAMt7US8wequ8L/A0kYOxM/v
   xeIS/tyD/GdKkTxovnPEX5NHFHHXINlX9dsHIMg6DlIEDpB6lcsu2g8ST
   DgDFKl2Wx4vzAamm71SZBoLr6h1XKWU8XkXx4q6juZJzwtDJeyrROpNWd
   6wd0EBSVC31zzeaI61RSUsneIkyvfFZpW9uHq34C5ZxnWujqLjfuq2YIR
   qQreOTrP05/RSKU9xg20X3oIw/C58MStkynN63x4mjvd4JkHm0j35AoM2
   5nD+hiJsD1O95heIzLBps6gdPwDqh7lD3NQx0CYGLo4mBblBaLKVvQ0ZO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="405668249"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="405668249"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 01:50:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="687237141"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="687237141"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 25 Aug 2023 01:50:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 01:50:53 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 01:50:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 01:50:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 01:50:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cs6GDhZCb6JVOpb9R7ce1oJ42h11YSl1Trk9ZsuCNtUk3ERLowsKBm1nDRDGJPdwamPieBNkkYp5Ago/w22Nm5Et9lhSVY+rDLhNsoJvkn+gvf44sYoopcwN/KaPzXBmR9m037jGAeDkEHUwgPkqfcpP0Lt/JCkX2WXuHBm0DAnOiF3K4Be0bFnv3CMXHLLqpsPnl3k+gma2umz9D7gzmqA7Dy+lP5BYkdla7kMD1bFxpq7O30NXP71fUVPYLhpX1f3QQB4q9dvMS+LgjPr/PFzNeI/mUEWN0KalBFwqRlBtV7hsVbFTBT+4jwnUFJjnCnBVffXI479NJSbXBYYwXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JW4hR/mXcarxYnSiMNeSsdEGfTdQLwi12OEV/8EZnbQ=;
 b=g2mvnwcR1TX7tAxuoenaJgFBZy+jkOMALkSv/l1bFD71/mlTMSb/9ZQWc00l1EFk8ok6f5naCgsTefHnia0DhZSZpSSEMIN2r/7GS2WXpr2jfpBtyW0lJphLjwu8cD7DpCB11/S++xMJVrg6QOE+ZV676dnxylDVs+2zt8F2jHG2ppJR9F87yTWWEKoR45bUhRVg+oOunGVgZA/DEjlZqEGydhnDqNmoOuCjFfHxk+7VF2itEitHlJFe/h8qi9fa6Ut/R7sGF6SqIut+xff7WwSh5PNmPh3wCM25GX+n+dsQECVZ8Mb4wI5TtcCUVwhbiO3qvHEvi56+z1j4uLWeRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by PH0PR11MB4902.namprd11.prod.outlook.com (2603:10b6:510:37::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 08:50:50 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107%4]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 08:50:50 +0000
Date:   Fri, 25 Aug 2023 10:50:40 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        <fenghua.yu@intel.com>
Subject: Re: [PATCH 1/3] selftests/resctrl: Fix schemata write error check
Message-ID: <viypgry5j2xk6txo6kwsqo4kmlag267krhg67oyhiooi4cd7db@ii4cin3btjo5>
References: <cover.1692880423.git.maciej.wieczor-retman@intel.com>
 <e7ea177261ded70f0c781841b0fb67fb1eb8909d.1692880423.git.maciej.wieczor-retman@intel.com>
 <5c6a2065-6771-ed87-c5ed-843f4e184ff8@linux.intel.com>
 <c3yp5kkhrc75tvytkbmep7xknqgomyn52xpogqzsy3sp7kwefm@ikzmp6rgzisr>
 <32f9983a-42e-7cce-8192-bba8bbb93955@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32f9983a-42e-7cce-8192-bba8bbb93955@linux.intel.com>
X-ClientProxiedBy: FR3P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::20) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|PH0PR11MB4902:EE_
X-MS-Office365-Filtering-Correlation-Id: a05bb8c6-a8e4-437e-7c62-08dba54861c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6fe5XUK5Sbspy9rftmi2npPBgnZvD/yTl8BRfH4GQgHT18ZxQMR7hqF6b+bCns9eB7sROqHbSHFnED8hFQaa4FLzyxOaWm6dy1AKBXlkBIyaQiq6nFSW94Wop7s5P4wAEtu6AL4XhB/XpA/8jwJlOYrjGU6wO6Vh/YAtDoeLpoYim62HRvYf8dAoSHc7QVCWpvkQ4Uv+EyxwHIoi4MRUTtVVcinxVXEqvUisXs1eJkIJAatm/5ga01vhH4LZCsgNE63yuPJKNZ1nAYoRtAgZNHzMyLHpnm8Hc9gKesv+7AS5XOM0H+5SJ1ylCiqjGriBgcXkC3dvKciAg63bHtQNroOOa+YioeFhOVD8qjbBVVyB4SwdLEXhpd2X8bYVwc7wiQ+iQ3JmE34s2vBagIzOh+YHSOaYuLS0BSKslC3AUkYt/LniOCmJHZ3K7Y+3tK1pZpXSgi/Unj3UoGxn1zWWXgQqmoz/qcX5VZEgU40WIOI0CHUF6bFwu48aAfqCIydPRnGtgLNURYeqXWN5hx7VQFo5lm4mo+7+FJIXCRhvzM16tebroihrrpoRgYY04SO4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199024)(186009)(1800799009)(54906003)(6506007)(33716001)(66476007)(66556008)(66946007)(6512007)(316002)(6916009)(82960400001)(478600001)(26005)(6666004)(38100700002)(41300700001)(86362001)(9686003)(6486002)(2906002)(53546011)(8936002)(4326008)(8676002)(5660300002)(66574015)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?VEfRwkJWZgEkfUNTTjVJIgNIwHQJUPqexNVZeLxq8UN39jHwHJexTkmo5C?=
 =?iso-8859-1?Q?5ht+WVkTBzp9gg1wk72r/JX8U4xwIo+94C8KOczHkphWoGpTSq6qW+F30z?=
 =?iso-8859-1?Q?cdx6F31aD9Z05u5oJYZp5yF3rTdqUneVprm7NMovJbBsChvifLKw6MAKZV?=
 =?iso-8859-1?Q?ZA9t5ocBFT2BZbnoYqLTIN9l1/oK9DgOx3quNAuD/w9KL+rvDhwb+0Vv2Y?=
 =?iso-8859-1?Q?gCk6Fga+HDbXwnI2+EY3cNIlKnPtU6Tt9cgapy7YjodEmE3dg0xroNglz3?=
 =?iso-8859-1?Q?ORd2qiwRqVAult3KFXasRCkpCL+FJ1ag6QpYzmfhoMEyL3Vgv/Qiazp+nW?=
 =?iso-8859-1?Q?deGG4E03PHo8Dxn1p3zjymYYAEsMivBkQqTwbdRnOkDUXvtejHXwh+O7Ii?=
 =?iso-8859-1?Q?ACr9xr2KAG5PJqqNk8akgx2caqrUQ+7qA+WmEVzFJNvqoaG7NMrJ5zSlpY?=
 =?iso-8859-1?Q?7vm5NEIDVZgnW50Ii3Z8dDqYiDbxXBTnTbu6UGjcZzDnF/yP8yVGlLt7O8?=
 =?iso-8859-1?Q?1fnyXbuS8gwk2Is5BSU45BGPgCCoWtLBL62s2hFhjxt/E5rGb3VU44avLD?=
 =?iso-8859-1?Q?OKJXJhxKvbFxxQKzIxSttWD5N9ktzx0NJABUkfZ/tEousDhYRXFCtNjUe3?=
 =?iso-8859-1?Q?cbqXiDDEuhIHHeWfUK9nnn2xw9urfYVTHJxolXJ5+fLd4OUEc6guexGZww?=
 =?iso-8859-1?Q?3KXGq/m635p8zSFQM03ljw8EPaN4Fm8Q9eCs19XkWGuKBmIZVJo5NwExre?=
 =?iso-8859-1?Q?vagLKgw6h7FRVOK+Eb0EeB6Czd3C6VCAd8cT9Xzf4MOkF+mFwwPp0pL3js?=
 =?iso-8859-1?Q?iJ22JXct6haKVcOIHB9k8nNp/1/dLMINIVLSFzfVCqtlw3S8sWgmT7xplY?=
 =?iso-8859-1?Q?p7lDS5E06iFLBxtAIseGiHOEDSPqUFJsRIG0mSwAYVGBQFzEGijDGY70ug?=
 =?iso-8859-1?Q?/NabINY5QeBukwhrbHhjOPLbTw5eGbZBGaT2KLtA/TRzrjkuwnOW3ZpQXU?=
 =?iso-8859-1?Q?wCGRYW5dWp57JG/kA2OfIXSe5hs9oSCPjxYfIhoZ7nQKSyVyOMed/OOKcv?=
 =?iso-8859-1?Q?FsSTx/tuF28aNGZDsVGAuv/YYBUj/U97D7b1BcBuOIxH9gjbNZ3WXwc4S0?=
 =?iso-8859-1?Q?7PytWeaV2vhCYfHsZ006afGhL37Wzskdi2qglFMQXjIGNYoUHz/qWG6cEB?=
 =?iso-8859-1?Q?6p/JgoM0FLVNbwvFavgPs5+h2FO9Mqb4pj4ToECFEp7buOOb4P0VEsTNvz?=
 =?iso-8859-1?Q?nI3h1f5n3JDZW7iTm/xFtLA2cVPH6NjY2loIkF55HB8UFhk/DYQHHcqT/v?=
 =?iso-8859-1?Q?RsQuZ0qXyXRd2JsaH8iZgA910A7Qb4FJOfDtPEw7VSfVSO/2U0Q5FDr4eW?=
 =?iso-8859-1?Q?C4yxMcXaqgfcZIstIzuFXMyTEpdP2OPgVMvgdkr/naV5H4Y3sqRFfwISRI?=
 =?iso-8859-1?Q?7en6/G1qjSzrDDapqSvGjEF8Tn3WUb0ix7AKgqZ4w3y4rWcw79ioH44uY6?=
 =?iso-8859-1?Q?IKeZnpJDky7PzIgWknY1YO1KVA8vF1zE+C0KNUVmHo7ZvmSNIuoWnIkj8R?=
 =?iso-8859-1?Q?5M6vJEJO+TgDFo8zvERGx1r4TbGsQRkWnTi+4K18vmjvo3x4njlVj9nKBb?=
 =?iso-8859-1?Q?Pg5Fe0+CJBH+OK4cObqnxxUKgDsoRaSgWc7IEsgzvS5drtLzAXbKs+g3HH?=
 =?iso-8859-1?Q?QMWNt+esNUQkd41jUjA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a05bb8c6-a8e4-437e-7c62-08dba54861c4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 08:50:50.0681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7TJTJmrGWFGctZniexsOxgHKaDQXeEx5/i1nEEKVWCfEFMhA9Fq2gdSvfPiNo7YwXtIRFbQkw0d93AJoqg4yDGPE2QuvleBM84o5aHWsJ4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4902
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-25 at 11:43:22 +0300, Ilpo Järvinen wrote:
>On Fri, 25 Aug 2023, Maciej Wieczór-Retman wrote:
>> On 2023-08-24 at 15:52:05 +0300, Ilpo Järvinen wrote:
>> >Ki,
>> >
>> >You're lacking a few people from the To/Cc list. Please see KERNEL 
>> >SELFTEST FRAMEWORK entry in MAINTAINERS.
>> 
>> Thank you, I thought I checked the MAINTAINERS file well enough. I'll
>> add them in the next version
>> 
>> >On Thu, 24 Aug 2023, Wieczor-Retman, Maciej wrote:
>> >
>> >> Writing bitmasks to the schemata can fail when the bitmask doesn't
>> >> adhere to some constraints defined by what a particular CPU supports.
>> >> Some example of constraints are max length or being having contiguous
>> >
>> >"being having" is not good English.
>> 
>> Thanks, I'll change it
>> 
>> >> bits. The driver should properly return errors when any rule concerning
>> >> bitmask format is broken.
>> >> 
>> >> Resctrl FS returns error codes from fprintf() only when fclose() is
>> >> called.
>> >
>> >I wonder if this is actually related to libc doing buffering between 
>> >fprintf() and the actual write() syscall.
>> 
>> I started looking and apparently in the manpages for fclose [1] it says
>> it uses fflush() to flush any buffered data in the stream. So that would
>> probably confirm that it does buffering there.
>> 
>> In this case is there a situation when the fprintf() before fclose()
>> would report an error? I'm thinking if there is a point to keep error
>> checking after both function calls or just fclose(). 
>>
>> Or would putting additional fflush() after fprintf() make some sense?
>> To have separate error checks for both function calls.
>
>Another approach would be to use syscalls directly (open, write, and 
>close to eliminate the buffering entirely. Given schema is already 
>written into local variable first, it would be quite straightforward to do 
>that conversion.

Okay, I'll try that then, thanks

-- 
Kind regards
Maciej Wieczór-Retman

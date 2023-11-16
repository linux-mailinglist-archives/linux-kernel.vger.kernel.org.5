Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7193E7EE05E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345156AbjKPMH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344966AbjKPMH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 07:07:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6907B4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 04:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700136443; x=1731672443;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PIQiI/3VCnUOzFYj4fcu77lU7azmJVfn3s2xvBfExaM=;
  b=XhZTusuhw0I1zrIy/HAgdOCofS+cjWX6ur7zi+KibSzfLNXBIvLpPbLy
   4TfotwoELdeCtNIUNcpVmslo9EEj02+kaeuDK4CWdzEOPbvaWtvoGtZgL
   eClx1K7ULnIV3axlYiOyfS+/N5acrDx2sUO5EGGa1ylf5T2XlHIjegAzG
   wQogOL2DMxogDMGp72Q+ikyXz7gydRyQRbbuiuBNRsj+mcjbQU78IXRKN
   hgc3dVp1WMZAuhAh8twcsh4VXKDG6447pwEGL8ryL68PTzQaeNONqTdxv
   F2wByomJDhTDdn9LO/AaNCUKO4QFOFqnTVbmUJ+OiUEpX2dU3jdSlo+kj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="393925848"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="393925848"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 04:07:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="765284815"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="765284815"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 04:07:21 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 04:07:21 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 04:07:21 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 04:07:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlVRWPefruwVHGF8Bik9sI1s0+9mXdAYo7GbNBowM/GbkbWzW3i4ZEO+/w9Zxp3V9RgooD83BbASdqta5U+b0xlXiJfFPZofsRFJ+2U91rGkftTnc30170VdrFObbqzCY0ouR5KtNk/AsIcQGCaCTjSfIHrwUzs/JSgYlOruG35o9xdUOMt+1rXrBPk5YZSW9QmYXW1buaLjwjPz+HPNRMHOlSZ5gdzzl6MKRq+Rvli2JlR7asK+rrvTEI5Zpz/DqOvKAWQfoGy6ptJajKNqevdIWILAe9bSFoddGofuBkzC57aljopW/SsoqovWVCkNV25PDXEmGbGDBAR7AoNfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9tRhGQVyMPF4yNHNOdwBHjsCVCZRA/clhWjBZ4ucXM=;
 b=Porzt778sAXwqzCtA+T+0+e5t1LBga3725z93v55fAvRXYMQSZdljHtJTNsc66djy9YbTPV5DvRYB6JKC20m6zsTOq1Vsh6vrSKhgv2a4xWhZcvOpxjGQBQIbS04iv/NYT0J/x65hUsJ3BgNstTKkAa2stWhJeiLegYaiBzGThGsUC5NEuw5CzXB5FEMiZ3cI/oKeJ0+0V6uHsac1zy/1IypLQIA+wZMuJECoOJloYUBm3mE/PvoepfunLMu1cvzO9r5dCsFVId/pbfJk4gd4rMAY/vIhDIbzqbSD4VqV1rwf87skYwP08kEYRaaAK10V8F9Jq8iiyuKFfs7VVGLHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CH0PR11MB8213.namprd11.prod.outlook.com (2603:10b6:610:18b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 12:07:19 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%7]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 12:07:18 +0000
Message-ID: <0c95b547-ed2a-4967-b561-1e6defa4c5f4@intel.com>
Date:   Thu, 16 Nov 2023 13:06:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: net/core/page_pool.c:590:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
CC:     kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Alexander Duyck <alexanderduyck@fb.com>
References: <202311160339.DbhaH8LX-lkp@intel.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <202311160339.DbhaH8LX-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::7) To BYAPR11MB3624.namprd11.prod.outlook.com
 (2603:10b6:a03:b1::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CH0PR11MB8213:EE_
X-MS-Office365-Filtering-Correlation-Id: c9387086-11dd-4d7e-56ab-08dbe69c9358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qpdbVWj5tqwfVa7DfjP2YMiOhevW66pPZnbPLGVXGSJ9uICiXDSGnMRqjtEauNO2ORx2EcUecwndFT+OIQv6lpjdeGBddq1nX9kZ98R8lyw/I9uk7iwRoj9wrFtIBfLLxEYFxNWNKQS3gOY0ZS9eMNZDROz0RLFdpEIcD6Jn3OiegZALYbNwScmW1ybhgRk9CENAuFFb6Mg5zz+rhhHrhuDn8javCv/CgBrFZKYL/ATuTm3HSNJk8b/w0K0rq8Q59cPeJiyrbeHL096VA6y99aaxnizO9H+PYzpiGuzMZ3viu/C3mZ4fwA9OnBggBug77sW6nGjfEjCfbgPHjV3IgWwYOfB95FJlfk2J7MBenLj73VOmEhpfHw9vXiI8SFSQ0QEMpKWCfAXrDN4Ykt4a/SrAHVMZUPHMBRfO76i7d6wFpDrOoig3ieorNyGepw3/YTfosIMjicF5W4BlEoallU8S34rrrp1NL7ITioqHYeMI2ndI8Ax3LeN0+bGSVSZZgpj4V9Pth14On4z6DrjAEHwydJvnPHMydPeE8ooz48hfEP5d47MA6d/5kSAgtJXEHcsp00ShBJ9+NdCTjxIZ+f1uFUjUDtff9IMjiUO1HmfjJ3ozM1YXHQrNuxXu8WG8XtkAD/L6eXJX9H7HHVWXarwFXLXsidkpeKmYL7KAqfOzZNVlrIDXqO3yJVpwsZR0zzgoH5WHCSlO76mH7hWM5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(230273577357003)(230173577357003)(1800799009)(64100799003)(186009)(451199024)(2906002)(41300700001)(316002)(66556008)(54906003)(66476007)(6916009)(36756003)(8936002)(8676002)(66946007)(4326008)(38100700002)(478600001)(966005)(5660300002)(86362001)(31686004)(31696002)(6486002)(83380400001)(82960400001)(26005)(6512007)(2616005)(6666004)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmJ4WVl6Qm1oNzhxamJYWVhmelVNVFRRTm5TelYzWlRZMU1GbDl0ektsdDdu?=
 =?utf-8?B?eFdFbmJiSGRkV0hmUjJFTzZiem9VVE42V0ZnemprdVZxMWYvQW83MENqR04z?=
 =?utf-8?B?dkQ1bFE2R2tEUHVHNWxyS2E5YkxybkVUbUxTVldtajVCTmFISW1XVU1wSjdS?=
 =?utf-8?B?ZEkzemxlV24zcHdxeVI5ZUFWU3lWRzR6bjR0YjYxeXBtVkpIQUsrSytQcC8r?=
 =?utf-8?B?RGVFcDN4anJITVRJWlpSYktmZDQzdVE3OW9ubkY3TkZ5SURnelpYcDhKdXpU?=
 =?utf-8?B?ZU55WUtZdmMxVjJWQ3RHYnp5NWt3cHRodjVhR1JiSlVoTDBQVjV2UzZxcytV?=
 =?utf-8?B?MFQyZXVRNEhhVFhMNGduOUNOTE9ueVY2eHNsSHdVcGdmbitDT3dxY3BEZUo2?=
 =?utf-8?B?NmdpWUwyWHhqQVFZamljRlorN3BxWWx6Q21NOE41eWk2eTdOMGZNUkJoQnpy?=
 =?utf-8?B?Y2E2dFpONVlSMStWdlQ1bnorM1NaN0hzRUd6cWY4aXJGT2tKUnBiVXNvRnNH?=
 =?utf-8?B?clNVajJEeUpGNmNFR1g0c3M4Ui95a01TcWFoUCtYM0N2L1RHVE5CM2ozVHJi?=
 =?utf-8?B?WC9BMzVQMzY4WlEyTFpNeklSZzdPSHU1T1IxNXFqS0Y1TFpqSlZ3cEc1d2kw?=
 =?utf-8?B?azdBWktBS1lhdDZzMk9PM1hlNGNpRkczdzV2elEzbFRDa2h3L0NsbzEyY1gy?=
 =?utf-8?B?S0FqaGhYV2hYYnNVMGRqT29CQ3JvS0JHdkNnQUtraXQzMDRvTTBmeXh6S2RV?=
 =?utf-8?B?dEFmUFZ4KzViVUNrSVRralNQOGlkWEpoYVhvL1krM1B0bWFoK0pjOE9GN29H?=
 =?utf-8?B?UWpTR3ZHdG10SkRTOGhic3ZRQnk5L25BTXNuN0l4eVljaktGYzVpMEE5QlVW?=
 =?utf-8?B?RG1ieGxzUTdhZ0RkejNjWm1HWUJyekw4TkcrK3p3TlA1dFFIWSs1TWxFUWFO?=
 =?utf-8?B?U3ZWSTQ5TG5RR3FLdzRxYkRlT0FsYnpyTkR6SnFDZFhHOVcxa2JpNHc0eUhv?=
 =?utf-8?B?YXFZSGJXSFhUNk9jek5EcGZYcXFiZ3FFcFRFdHNGRmhud2tnTitYK3YxSE5j?=
 =?utf-8?B?MmkyN2VLaTB0a2hwQVZWLzR3TTM4WUtiTCtweUwyeFpMazVWY25Ca2N5SkxQ?=
 =?utf-8?B?OXNjYVVHdWxSeHRRZ3pzaVJDTEMwUEZvcFErakJhSHZackhCZWx6RnBaeGds?=
 =?utf-8?B?WXJyU0dYbmVzVUtSaStkaGtieWU5OGJzU0pxYXpROWhieVczbm8rTTB6TTF4?=
 =?utf-8?B?VVVBY20wbGZkTnRPamRtVlVnVSsrNVVJUEhkU3lCYnluNnRjK25wcUdxYllL?=
 =?utf-8?B?bUNXd3VxK2VaYjB1c2xSNHZvcnZmT2NoYmRITEZKZ1dRd0F1SUFINFM1b2wz?=
 =?utf-8?B?RGNFR0c3dUJ5emdBOUhMcmgxVjFDNWdTVTFQcTRSYjRRWFdKQytvQmdZajlr?=
 =?utf-8?B?THFjeUxqTWQ1cE5lTEpFZ3FxT2UzV29kNlhrOHplbDFMc1NBenA1bGJGcGJn?=
 =?utf-8?B?VzFtbXlWbUgwN1M4b1ZKbWJQTmpFMFhTaHIxSDJrcWdmTjNDbXpHRWxwTUNK?=
 =?utf-8?B?emRORXB6anQxSDlRVkNadmY5YTNvb3Z0Kys5WmF3ZWpCY3lMUnlRYmh1dlRC?=
 =?utf-8?B?aG83UlJSOHlTMnJPeHdVL2N3dEs0OGtiZHlweEdscW4ra01MSG01RU9Ebmdi?=
 =?utf-8?B?UC9BUmFnYUhZdjZGa1lrVHROcEdNMTdFbzU1QnZISjJ0WTdMVHN4Y0RudVFE?=
 =?utf-8?B?N1dpTXp6SFhESS9DOC9WdHNxNEpXYzVuSitVdnFRNEphR2poZjlkcXVFdGtl?=
 =?utf-8?B?aW9sTnFQNUhWUzlTZlJnRkFMZkQ2NGxnUDNUMXgwNTQ0eTVxdWRQdTlRaEJR?=
 =?utf-8?B?VHY2SzF2SkVXUUZvQ2M3em1jSm9leVRuaVRiVXBvVVI5cUplZys4UnBENUlx?=
 =?utf-8?B?NER1dEVwMlR1ZkpPUHdkeXhqWkxxTUhkaW8xaGE2bHJFN1FDaWJXOXJUSXNu?=
 =?utf-8?B?Rkw1SmtxS0Zyejg2Y1FUTzdvTHQ4Zm1oTEdXWWRMczRwWnhUOUluQzhLSEdt?=
 =?utf-8?B?SUl6R1QraWlueC9sRzN6eGZ2Zm5RbXpqV0Z2STdsaUluU0xtVENiaGFNbllV?=
 =?utf-8?B?a2hPVlBkeUs3aE9vVDEzU09Ba1VUSzNzc25YeGFDejlxOXFsWEVuV3JJRCti?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9387086-11dd-4d7e-56ab-08dbe69c9358
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3624.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 12:07:18.2984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6yI3VU/M7PLq6p58sKaTDdAb7id6e4ruPacOpoa1aGzc0DulGPLZJc4UOxS0nx7LpHqsNNW+E9wZsfCLhoM1SxKLIp+yLEnvsmhjolrn9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8213
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kernel Test Robot <lkp@intel.com>
Date: Thu, 16 Nov 2023 03:12:24 +0800

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
> commit: ff4e538c8c3e675a15e1e49509c55951832e0451 page_pool: add a lockdep check for recycling in hardirq
> date:   3 months ago
> config: loongarch-randconfig-r133-20231107 (https://download.01.org/0day-ci/archive/20231116/202311160339.DbhaH8LX-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20231116/202311160339.DbhaH8LX-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311160339.DbhaH8LX-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
>>> net/core/page_pool.c:590:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
>    net/core/page_pool.c:590:9: sparse:     expected void *ptr
>    net/core/page_pool.c:590:9: sparse:     got unsigned int [noderef] __percpu *

Eeehhh... False-positive?

Thanks,
Olek

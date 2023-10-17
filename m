Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2EC7CB8D3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 05:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbjJQDCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 23:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjJQDCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 23:02:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1BB93
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 20:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697511750; x=1729047750;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PvegMtH+xm1jvp5vRi2DBhtyBIgpaqlswHQ5qWNtdFY=;
  b=AV/ZDzKPgFYzBysuqNVD1M9ehnwYhMBYPvn1CFByK76+vD6d2U/cRH7f
   3LvVTP3auJ5mzisZ02Zbg6t/sGFQ43o7RAjGyupWvp0fQFH1D/cYx2Oln
   KFxW5yVK3oB+cKCrot/LJg66FN2UpVOGHNRBrS1wTO3sbIjb0JAq8rHBZ
   UJ0qqYtk7Z7+Lev7+51EhQlO3isB67juxcg5juWBXbhX1vFoQJ8d18+z5
   mR+NeqUXAkhjxghJhCsu57qzksLg0swK4ku5zg0DeFSrle0amc9DDOaYs
   mHkUacyOkaewsCCREanG5GFMio6re2jHZQdrBcW12PYizCCfo4Xk1/yoF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="365949030"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="365949030"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 20:02:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="879657083"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="879657083"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 20:02:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 20:02:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 20:02:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 20:02:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 20:02:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQSWKYszDz8j8O93VhAaJTAFwMtwPIHliqI8BoT8amwiLZ0Gekxl+BdSKXDxicYduH1LRGfdoTNAfe6Uer4Gw5LpkdQgQQvp+/rQ14VvX3yzcUl1Diebowia+91ET+38nwbhybHh1x+bOoGtsl57kQkcr3gahKO7AGXYzFjMKYucCJ+S97Qd7TF4Vqjb8+ftSXy5oAw2WCtqGd2UfBWuePw3WzjTTUW5JSt6asqG74V3kXCyyJmVV4bpPZD2LldlE7GT3ln/zG0sDHJ1QnsH2vzKAw+8EvmEjKHHBxVtb3OvEBhtj9vAx6Kd9Wp26PLWovJDGKjp3al+0dl7Zk8wXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZyYbWrBSvxKpua5xIdhK0hqX/2LFlg6QH8RrMDEpmA=;
 b=UzLJtTOPjJI6IaeNyZk8fGqzo7eYofZD3ldGpwwjdE9IfE+HfB3RGB8sBvJZWcM8rRDKkWajZNY6ZHU0hgE6CY9xwZEQ+6lFbmDeE3862237g+FLxuIMP6CUwr7S1fKyWJO/Z9ypPb5hRb16GHxMjEfBnJf8LZK8JPGJtLjalNPWIQXL2rxoj+CYC4qER6cM9ha4eH4aj7zQP0fOPaC1s1fK+vH9eOOdNxgguDAbeUVM+esdTdCJHrJUETAUKEuUBdA1ppEtsxERTGmM9Q3VDbF7lFW58L6evWQDTUujXuAWm/Ud98dO3ASGHzappoMVstFOyQBdbL6wpU9Me7Ow8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5469.namprd11.prod.outlook.com (2603:10b6:5:399::13)
 by CY8PR11MB7876.namprd11.prod.outlook.com (2603:10b6:930:7d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Tue, 17 Oct
 2023 03:02:18 +0000
Received: from DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::8df:98a8:95d7:5bf4]) by DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::8df:98a8:95d7:5bf4%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 03:02:18 +0000
Message-ID: <74e3348c-e02a-7b78-beef-9bcf16b8c7f7@intel.com>
Date:   Tue, 17 Oct 2023 11:02:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATH v5 3/3] iommu/vt-d: debugfs: Support dumping a specified
 page table
Content-Language: en-US
To:     Baolu Lu <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
        Tian Kevin <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20231013135811.73953-1-Jingqi.liu@intel.com>
 <20231013135811.73953-4-Jingqi.liu@intel.com>
 <fd56b69d-d9ea-411c-9eaa-454b3d64f51e@linux.intel.com>
From:   "Liu, Jingqi" <jingqi.liu@intel.com>
In-Reply-To: <fd56b69d-d9ea-411c-9eaa-454b3d64f51e@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:820:c::13) To DM4PR11MB5469.namprd11.prod.outlook.com
 (2603:10b6:5:399::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5469:EE_|CY8PR11MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: 069ad351-92ce-48c1-9a53-08dbcebd792e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cpqR1XhD8WD75WwB/hZ2Wy3tlA/9dm6cerjndYbiQ2RQIlMTA9SvIZUi3/FRk3IF8Hlgi9xO75+9tXcdrxPFUCEcgF+0ZjSzT7/gM07VINjFV9slsDFGPxxJELsYv2lnhPCmz09f4Rqozf/WDD56D5QOW9qbVpPXl7cdo5KnNOxY57bSxOINlqPjJx+Ouh1NTSnJ6QRmDxz6pXskC5P2TbCLyKGYeZtgiQXmF45UWdclNcJm/onnlk4sCrerGsajC0K5DyACCZSwxdok3y1B9KNAnQXeD85nU7djI4NFv0NhGyhgki8jjOUcFOceAPj2GWyO8tRO00V6P2TeRMW6bTudFg0RUsyEAeK3soaPBMNOfBg+nHUZM2eu/Sz7Ed0qfB+90yWcTMWDYYsEQhUhSYnfoE7HY8LVhWoCBImDGtTZl/Rfuffz/nhZJYWCNA5gZQblJK4ZF7U5kQrpeBX8Fex00eQX4T2og6AUNRfbpVSDG3zNP6FgV7FpXfD0mAjVAmuoiSlbUd+u7/o+tx5jJOhewuBZ58GicijKGJTfp5U25S5umVQF5ysZrzz89wxNqOMZFHwLRdl2B3wjM90bKx4hxXjp69BRdopTjf2SMb5X+L9/Uzx7qXe/5N0bHfdH6BEGzJB4+cSXT8XOp1wL6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5469.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(478600001)(53546011)(26005)(2616005)(6506007)(31686004)(6512007)(6666004)(4326008)(66556008)(8936002)(8676002)(83380400001)(5660300002)(41300700001)(66476007)(316002)(66946007)(4744005)(2906002)(38100700002)(110136005)(6486002)(31696002)(86362001)(36756003)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L01VNkQvcGlPak1naExSbllhT2E0SlBCYXhCNzdySUJPakM3THlRbjQrN1Y1?=
 =?utf-8?B?R2Vld0pwc1lpNFpXZmUxT0RrUGNRVnRSTm9oSFBTWEowbWhERXp4NlVJaVdj?=
 =?utf-8?B?aWJTU1JGL3VVZ3UzcVphQnJ3eTBIbSsrNGVkRjdHamdIWnJzUCs3MTl3VG1r?=
 =?utf-8?B?N2UvbWZYYWZlcXNjS2VLZmJmakhOSUI5Zjc0cElna29LZEp6dVNIQWdXNlhS?=
 =?utf-8?B?bThWbEpweGdaT2t4YjRWV3pmeU5GaVNKK21DWGdlUGNwNFlXYnhtUmRqamxE?=
 =?utf-8?B?Qms0Q0hLWGkxMnFad2pwZzlrYlhNeXhTeTZzeS9aS0VOL0g2Y2krZzhmYlNw?=
 =?utf-8?B?TC9MMlRVWEF0MHo4RWFyTzI1RmRJS3hYTVg3NVBjeHRxbis2NFU5QlBiQkJ6?=
 =?utf-8?B?UlAwbzE0dnYyWXlldnlwc0RKa2lsZWdRVnRvWTZQdmRIQWgxWEpmbDlmd29q?=
 =?utf-8?B?SFpDUmFMV0luUDkwZ3kyRFEzc1J1YjJsSFFlWU96d2Qxbko4c1ZpQm9FT1ZC?=
 =?utf-8?B?bHdaV2o2YXlxc2VGWTFkRy9RckFsZHNuTGZvWHh3Q25nclVRejQwY21OTmNk?=
 =?utf-8?B?TnpYVnlsMmZzS2c1Nkp2NW9laFpJTHFCbTJET2R4SVpudXhYLzV6M2d6NjlS?=
 =?utf-8?B?N2N0aGZqODNzY25kL3hjSmRGOVZ5YTZBTTJXVjlFS2hvazk3WTBwQlI3TXRY?=
 =?utf-8?B?dDZycWdKZHdRaUFPOEpNVEdjSnlVSTltRnljOGJyU1VhWDZCTkkrdjNyYmFQ?=
 =?utf-8?B?NVNvZmVHWjJ6YUJHcERKSGk3dDZsRTJlRW92S0hFS1ZtSEFqT0pJbUlYeG8x?=
 =?utf-8?B?L3YrdXFRZVp3ZU5uWFdLT1RtbDkvNFl2dGw2aGdCdC9pbFpRVmdmTmd1SEZD?=
 =?utf-8?B?dFBrcWhnNEs5dTljS29VMi9ZTjZlRnFCZFhvRURJeWhRYlV3QzhOcktocXFn?=
 =?utf-8?B?dlVMNUF1WUMxbnd5dmxpQnJFOWNNS2RuWGlRbHNaOVZ5OVdQT01BckE5dkts?=
 =?utf-8?B?RWlkK3dNQmJDZmkxNWZQRklMVGlpa2Q4ZmVjeVU0alNWLzFWQ1cyc2c0KzV5?=
 =?utf-8?B?WjVpQ3E4R3VLSE9WMkZKUU0rS0F4SXRMcUx1QmNIMFl6Q3Y4RTNRQmhxYTJU?=
 =?utf-8?B?QUNONEI3WXFvWGlsT3c4RW0yZmkxaGZTTTJ1bWMzSEFEVEZuVkVtSm5iTG83?=
 =?utf-8?B?U08yai9kUzFCeHEzanFVd2xPbjVRN3Q3N3gzdUQ0UkdVZk9QSHdyRzFYb1Fi?=
 =?utf-8?B?dVBxZmFRdzhaeFArYVpMa1A0V3Y5cGpiVlBKUmdJVkNua0xOblJvSUZFTGh5?=
 =?utf-8?B?Q0NYZm4yaFBjbTNrRXRmUVZwMGlhQmhvb0ZJTHZybmtKNjIzMnhEK1NvY3NS?=
 =?utf-8?B?bldPODViSFQ4VWJWMjBPM1BXMEFDbnlZc0txdHh4R3p6blJHMWFHZUJaTGdq?=
 =?utf-8?B?SUsrbU1oMzlMK0RuVzI1YTlOa0M5cEhTM09pRVRZUythK3g2OTh1eUhWcXZB?=
 =?utf-8?B?Q1M0MjRISVc2UUVpRC9DZGVEWTJIV3M5MGRIbXhzMW80aHoyNExtV1Mra3cr?=
 =?utf-8?B?eURTK2pwRjFNWXpCK2tQZUN4a011cEhNN0FGWlc4N3laajk4LzFzUjkrbFdx?=
 =?utf-8?B?SSt0ekNPQ0x3TUdTNlVpV2N4c0VOMVFLYi92YUR6U2Z1VEZKQ2l4NXp6VlY1?=
 =?utf-8?B?bHJVRVZHU3dtTndRS3RVWk1EY2dyZldzd3EwRmkrNFBLVkRuK0VaS1h4a25r?=
 =?utf-8?B?djNRVDlyOURoc0Fva1JnMTRhdEl0SnBMMzZEUFNHUGRzMzFvMGYvTkhkNEo2?=
 =?utf-8?B?bkxMczdvVWQrQ2dpOHB6TVdYU096SnVRT3JVaGVKTVJWMzdySjRzTHZqeElj?=
 =?utf-8?B?bTNoUUo5WitSL2JOWnpLMXRubTMvWXlzSXVZTW53TnV1VkpNNkYyQjNkVWNl?=
 =?utf-8?B?RWdwRVFMdHJBNWowWDZzTmJ5N1E5c1NDSmtjSGNCVEt4d1B0ajZ4VEhJUFdN?=
 =?utf-8?B?dldaUFhKQUlwaGVpQy9ieUpTajBOWHJRUmNEbE5qNUdqYW1Qck83VGtQM2cy?=
 =?utf-8?B?SG9hVGZXMTFQY0xJaGcxSW85UnZ6SGJtYS80cGdENWkzTjFiVStIdk5wZUpP?=
 =?utf-8?Q?ixgJsK5MPkXTMLtOabepdruxI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 069ad351-92ce-48c1-9a53-08dbcebd792e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5469.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 03:02:18.3716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Ynbz2XDTPFIWaL8pKzn716tPArANMpZiYsIo5eNEn6i7pk29tDPqXFT90q0LDNISbzqOZu+f+3xNzrzacLtdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7876
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/16/2023 11:04 AM, Baolu Lu wrote:
> On 10/13/23 9:58 PM, Jingqi Liu wrote:
>>
......
>> +        if (scalable) {    /* scalable mode */
>> +            struct pasid_dir_entry *dir_tbl, *dir_entry;
>> +            struct pasid_entry *pasid_tbl, *pasid_tbl_entry;
>> +            u16 pasid_dir_size, dir_idx, tbl_idx, pgtt;
>> +            u64 pasid_dir_ptr;
>
> 0day robot complained:
>
>    drivers/iommu/intel/debugfs.c: In function 
> 'domain_translation_struct_show':
> >> drivers/iommu/intel/debugfs.c:401:29: warning: variable 
> 'pasid_dir_size' set but not used [-Wunused-but-set-variable]
>      401 |                         u16 pasid_dir_size, dir_idx, 
> tbl_idx, pgtt;
>          |                             ^~~~~~~~~~~~~~
>
> I have removed pasid_dir_size and queue the whole series for v6.7.
>
Thanks Baolu.
Indeed. It's an unused variable.

BR,
Jingqi
> Thank you!
>
> Best regards,
> baolu


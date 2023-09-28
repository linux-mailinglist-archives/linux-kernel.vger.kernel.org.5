Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D207B16CD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjI1JDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjI1JDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:03:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFDAB7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695891780; x=1727427780;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DriKrKlzHHimZfygxsUHNPJLyBkG/w19HKbg6Xr6Y40=;
  b=WWzF4mb/j62UkLOf1EZ8BK1Zpqfk4euu6zkNA1B58fswQPSxY4kswhHq
   gY+Mw0rp6aPGWrUfTDWttz6ZAvzU7zjnd2CuyrzuCuJux5LigWBaiBbrX
   ARa/dulnDirRTue+bDyeF41k5zuIqip3cQalIWOiTvZgpHtTBUzdahgut
   v32QiymPRkyOwpEZr0g329Bc/UNnXI3VuoRngSBvSN4YnQfnbanKAYqEm
   ZRfWP29xGBdBH490l+XDHrH6FSDYY4EDrOh6akj9hqlZDyIuMclTwM4sk
   OajeccLlW8V3ewUxxB1xoS7Ofu32k5294qe7Fe4Emx4bGdD6qahGXkqFa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="412929049"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="412929049"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 02:02:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="996479396"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="996479396"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Sep 2023 02:02:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 02:02:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 02:02:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 28 Sep 2023 02:02:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 28 Sep 2023 02:02:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMmFdAYUZ6nVwhuIRuCcU60OoXw9P0NG5GOLEY5tMnwWKQprOE/lDk/m888uIcgeXTpzhXjtGTu3R5uMebgeQV0IwMReaN2T79gOBHkk36QlGtleXec87jJyKQLoPCvWSswmbtk5ur82Uha6AENgt0YB3zDvI0yv4Niz+IGYFg9D6y3pRlrIw/Ujxkj2tSxASNx5t2s5we1+aJIMSI/R420S4F4Dy12L5UThcUh8aPhiFRNj6p1r665RrkCESM9A6vxIrAYoF4R3ZT5b109Xdhtm/qc+DTTQhm8DK8o7NBBKJ/eIPnrLcVj69uftCxZ1BZaCwIV8R8xbgr0af/yd3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dv3Iu85Jo8TUbJiHIKobI5TfPNhve2Q3x83tB8A5uOw=;
 b=IIogt5sgf2aX5A7n61uA9meCuJH8BSDi9aZsPdWlwB5+w1UWhrTXXfe70IJcZZUWC+4BzsIphOz5Jx0lEqSb/Mpb28I3PeYmnmVUYpIg45F/QpNHl+4mT9FvDCpAV97f85DdZdLm7DLNPT4qg/C4rvudMgzI6Uge6zq6J6plLWIrGnP/9BRRQDIWD5ARsMonUvCE5ZF766ytz81znEj59mj9Nxs7fItanEoqhpS+uNAXF+m7pQnjv2xnFGpKnEG0LrLg9QvFrRyxdlPrKkFFLCSHd+DP5VRT9cPCZqM6UBxXYGslHsX0osIUK01EBAWIDlFL8FsdFvphElGVL+Y7Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5469.namprd11.prod.outlook.com (2603:10b6:5:399::13)
 by DM4PR11MB5993.namprd11.prod.outlook.com (2603:10b6:8:5c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Thu, 28 Sep
 2023 09:02:51 +0000
Received: from DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::8df:98a8:95d7:5bf4]) by DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::8df:98a8:95d7:5bf4%6]) with mapi id 15.20.6838.024; Thu, 28 Sep 2023
 09:02:50 +0000
Message-ID: <196f7651-31d8-349d-9db9-dfeaa272542e@intel.com>
Date:   Thu, 28 Sep 2023 17:02:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATH v3 2/3] iommu/vt-d: debugfs: Create/remove debugfs file per
 {device, pasid}
Content-Language: en-US
To:     Baolu Lu <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
        Tian Kevin <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20230927151536.67319-1-Jingqi.liu@intel.com>
 <20230927151536.67319-3-Jingqi.liu@intel.com>
 <8d931037-500f-1dff-5fb6-fe60d2e8af7d@linux.intel.com>
From:   "Liu, Jingqi" <jingqi.liu@intel.com>
In-Reply-To: <8d931037-500f-1dff-5fb6-fe60d2e8af7d@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0063.apcprd02.prod.outlook.com
 (2603:1096:4:54::27) To DM4PR11MB5469.namprd11.prod.outlook.com
 (2603:10b6:5:399::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5469:EE_|DM4PR11MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e1f18d-6cd8-4562-50a0-08dbc001b159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fCUDY/18ZY2dEMbZphdN+olOQlPR826v+xLlR8URHYFBSuYXHJgcuoBu92oLKgq6V4rXJ0gRJtHEid6uzuKjCi/87NRyJ+xGjvUJJPueqMPPmMaqind0kbbQQ+YKnmtZD5YCN1SZCajO82Rn3kTvzy00INt2Z+dV7LMuy95yZR+Lr3LGWTjAPKPtSFsq8Z+8dEc/I2q0nbuXmHYmUGFcCJhJ+UKmPxZ8Xpk6PvpKQ7B6XXINY5JnRwpJd7ZablcgCiA4wyeg2e6KfsvURnLiR7we5NwnEd8vMSJBTbH10rDZq3PxS6maemJX66PfoshtkBXXeFlcc4F+pIwP6blcTVjzZ8537IkD0/4VEKOcEpbNfq+cj9TvGlLoKZCTgZcUZVyrsSQXVSClPVQ9whiJb8h+7QP0cqCUelH5XY6gsnciB84pfEP4lB3We/YP1ZWkmmcVk1eLgx5Ac/oFZKx4MsEAnintYZbJ4MBZb/32awOuJpsg1VE7/WKKgXmU3a2LMumauSaCXbysLgB1o03ScQ1CfbAZLrOKRoZDb5xps32qmhZb233ouW1DIl9tmB5fjwNKzWbdMsJtJK9u09k5/eW6jTjlWv2ostuzehGlA1fKNJcSxOfNXrAFQ0DL/dyL4Ja2gzGMMEL/76ku+JwKxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5469.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(66946007)(41300700001)(5660300002)(8936002)(4326008)(82960400001)(83380400001)(38100700002)(66556008)(31686004)(110136005)(66476007)(26005)(316002)(8676002)(86362001)(2616005)(31696002)(6486002)(6512007)(6506007)(2906002)(36756003)(478600001)(53546011)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXcvSXRuSFB1S0RGdi84NFJEdERGOUNmNHVYbTlnK1BlNStER05raWJBSHZK?=
 =?utf-8?B?UnhtTVVnVllGMy9DNWZsVFI5WkJsRnB6WWJDMzRFbk91aWswRnQrdGJZTEJk?=
 =?utf-8?B?bXN3Z1EzZ29yQ0g3RmJZNk9kRUxLTW8wOXBxWDBLcnpSSU40TitQMGpyUkdJ?=
 =?utf-8?B?Q29UTXlQTHRabDhaMXNWenNLMTJNaGs4NldmNlJ1UFo3cXJydGttQWg4Z2tQ?=
 =?utf-8?B?RlBrMnp0bTFDSkN0OHpEelJZaHpXZGk1ZENCN1FqeXR0MXFJUUxOaS94Z3pH?=
 =?utf-8?B?Y1hIaW16b2c0RjcrVXRWMCtiem9XZ3JKZnloVThWTVFwUW9mRVB6Qlhqb2ZZ?=
 =?utf-8?B?dnlGbDhvN1ZwdjJKUVhoUWU3VVY5S3FkdjJkRXhKdW45QjhranJlODBxTnkr?=
 =?utf-8?B?U2JDd0NEL0FLbWxZNDhIaUtwN3VoZXpuQjREY283dE1aQ2lINFpaYmo3NHdk?=
 =?utf-8?B?QTZjV1JhTjZKSG5rR2paTE9vZDNYVTVJQXplMEVqWWI0NlYyYzNjSzJxWXlC?=
 =?utf-8?B?djhhTnR5dnorVkliTThweDU5OGVYTWZJdytZQVY4Yms0RldQOHZ1VHpOeXBl?=
 =?utf-8?B?MmVkMFNFeFFwUTY4c1hDcmpYM21tVUdDS2plUDBybSttOFN1R3kzNjFTc1ha?=
 =?utf-8?B?ZVA1YnBFVHVzaGM0RVN2VjJ6MGdYSW52Nzd4a0VPZHhaaDVkSTYydkl3MVRw?=
 =?utf-8?B?c0lxc1hIK2ZFb1Ywd2x3R1Y5aXJ0ZzFYRkJObGRNbCtMaUhpNUVPMy9SMXRB?=
 =?utf-8?B?Z0tlR0FsWkozUTJtV0d5eS9mcFpQb0pOdUNiVTBXYjlDTS9Nc3BGc3kwUE9s?=
 =?utf-8?B?M2YzT1h5WkpnVzhldG5FTk1GdHd1bUcxcGdCRlpubTkzZFFIM0FyZTVhcU5P?=
 =?utf-8?B?M2RNR1F4aGxOb2xZN1pjczhqQXQ2ZlVPdTdsblJXenFjR0RkTGlxZURCT0I5?=
 =?utf-8?B?UWxnNVNERE9YUXU0alRTOGhEZnZwUnkvSmQvYWZMSmtqU1RJOHZZZHo4RUVv?=
 =?utf-8?B?bVNVR0x3QUYwM1V1WjkxS01aVzVLUm5xQk1wNldPYUxQZWg5MkdOdzVTditE?=
 =?utf-8?B?RndyT1Y3WlZyeC9RVE1KaGNzQ204SlNnOXUxVnZzZnllcnJ0a0hyWHdOK3dD?=
 =?utf-8?B?clJ6dHZmcGRaRmVNNlVIT2tmRjNhMEtCZ2lNbXFoNUE0dWdwaXRJK3RwaEJt?=
 =?utf-8?B?TzFEdUxlWVd5REpDNG4zbWdDT3lJY3Rqam50WnFhQXdDeE45cjd5WTB5Q3ZL?=
 =?utf-8?B?TVBDelpxbkFMQnQ1S0dtWjRDTkErZWc4OGRRSVJtVXhhczVzSmZtZzlmRWFR?=
 =?utf-8?B?YklQdHlkUm9NZUV5NDdNc0V5S3A4ck1YSlNDS1AyRHJ2S1lZUURlV29CWVVZ?=
 =?utf-8?B?a05KUnNtdUl0K3VpbVhRc1JLM1N3ZXlEVFN1ZEZJNjBFVFB6c0F1MTRmeWFp?=
 =?utf-8?B?M0VZY0xMQnM1TFRGRHR3VmpjaEZ4OGh2dXNQSnlrY3pKdFBpRFA5bVYvY0tz?=
 =?utf-8?B?dTc2bTNhNTZzeDdPVHExUmg0TmU3blFVV3ZZWmhlSXE4c1ZwSmU5WGlZT3RD?=
 =?utf-8?B?bWdMdmdxaVFsUklLTWE3NWY4eTlUUWk1M1Rya1ZiMDJVM0pJcVphTGdmWFQ5?=
 =?utf-8?B?Z3YwaEpHcU01QzVaZ21GSGJ2Rit6YTlDYlhQYVd3N24xeUo4TnJ5Zy9pUHhn?=
 =?utf-8?B?dllrU3hlaDB6L2RqWmN6T1FzNTNwUEMvdjVKdzZYQmdIcDV2akpSZVVmb1JM?=
 =?utf-8?B?M1JVSXFYZi9OOG04Tm9ublRoZzhURjJ4Nncyb0pzczV6Zm9TMjJTbERRZi9t?=
 =?utf-8?B?dkRmN243ekNTVDd4OUVjekVxM3BMcVdvK1RQMllZUWVhMnhRUHA4Qkx2STA1?=
 =?utf-8?B?bzVtVkxHVmZWdHNpYjdXc0JCcDk4TUtZalpVNXRQd3ltak0rMEYxM3ZOejg2?=
 =?utf-8?B?TFJ4VWhLbm9Ya2lTbExlODd5b2x2Y0NNQ1ZpNlZVclBGNFlEYkRQekM1UzBw?=
 =?utf-8?B?UmhhS3BpSTZsYmFKUENZclhVaHVuUG5ocTVUWWs3aUNMZ1FjMmJ0b3FDbnhk?=
 =?utf-8?B?dDVPaDdaRytSWmQ4YmZzU2R6Um1BRVZPRFAvd0hydm9JTGlRUDVJYXJWUjZF?=
 =?utf-8?Q?7I2IHxmM2E2w0Zsg2T0N7aarY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e1f18d-6cd8-4562-50a0-08dbc001b159
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5469.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 09:02:50.9187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08LOXcUHYRC8GWoh7Jk3+4KI/ElF923HmrD1mOz/y+D2qnFYimSzIVujw07jSGVWh3Z/ECi8XC8cmts3zky+3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5993
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/28/2023 9:58 AM, Baolu Lu wrote:
> On 9/27/23 11:15 PM, Jingqi Liu wrote:
......
>> +
>> +/* Create a debugfs directory for each device. */
>> +void intel_iommu_debugfs_create_dev(struct device *dev)
>> +{
>> +    struct dentry *dev_dir;
>> +
>> +    dev_dir = debugfs_lookup(dev_name(dev), intel_iommu_debug);
>> +    if (!dev_dir) {
>> +        dev_dir = debugfs_create_dir(dev_name(dev), intel_iommu_debug);
>> +        if (IS_ERR(dev_dir))
>> +            pr_info("%s: Failed to create debugfs directory.\n",
>> +                dev_name(dev));
>> +    } else
>> +        dput(dev_dir);
>> +}
>
> Above could simply be like this:
>
> void intel_iommu_debugfs_create_dev(struct device *dev)
> {
>     struct device_domain_info *info = dev_iommu_priv_get(dev);
>
>     info->debugfs_entry = debugfs_create_dir(dev_name(dev),
>             intel_iommu_debug);
> }
>
> Isn't it?
Thanks. Good point.
If add an "info->debugfs_dentry" to the device "info" to save the dentry 
of device
debugfs directory, there's no need to lookup the dentry by debugfs_lookup().
Just simply get it from the device "info".

>
>> +
>> +void intel_iommu_debugfs_remove_dev(struct device *dev)
>> +{
>> +    struct dentry *dev_dir, *sub_dir, *dentry;
>> +    struct list_head *plist;
>> +
>> +    dev_dir = debugfs_lookup(dev_name(dev), intel_iommu_debug);
>> +    if (!dev_dir)
>> +        return;
>> +
>> +    list_for_each(plist, &(dev_dir->d_subdirs)) {
>> +        sub_dir = list_entry(plist, struct dentry, d_child);
>> +        if(sub_dir) {
>> +            dentry = debugfs_lookup("domain_translation_struct",
>> +                        sub_dir);
>> +            if (!dentry)
>> +                continue;
>> +
>> +            if (dentry->d_inode->i_private)
>> +                kfree(dentry->d_inode->i_private);
>> +
>> +            dput(dentry);
>> +        }
>> +    }
>> +
>> +    debugfs_remove_recursive(dev_dir);
>> +    dput(dev_dir);
>> +}
>
> And this could simply be like this:
>
> void intel_iommu_debugfs_remove_dev(struct device *dev)
> {
>     struct device_domain_info *info = dev_iommu_priv_get(dev);
>
>     debugfs_remove(info->debugfs_entry);
> }
>
Yes.
Just get the debugfs dentry of device simply for removing.
This helper should be called before the "info" is freed
in intel_iommu_release_device(). Like this:

+      intel_iommu_debugfs_remove_dev(dev);
         kfree(info);

>> +
>> +/*
>> + * Create a debugfs directory per pair of {device, pasid},
>> + * then create the corresponding debugfs file in this directory
>> + * for user to dump its page table. e.g.
>> + * 
>> /sys/kernel/debug/iommu/intel/0000:00:01.0/0/domain_translation_struct
>> + */
>> +void intel_iommu_debugfs_create_dev_pasid(struct iommu_domain *domain,
>> +                      struct device *dev, u32 pasid)
>> +{
>> +    struct dentry *dev_dir, *pasid_dir;
>> +    struct show_domain_info *sinfo;
>> +    char dir_name[10];
>> +
>> +    /*
>> +     * The debugfs only dumps the page tables whose mappings are 
>> created
>> +     * and destroyed by the iommu_map/unmap() interfaces. Check the
>> +     * mapping type of the domain before creating debugfs directory.
>> +     */
>> +    if (!domain || !(domain->type & __IOMMU_DOMAIN_PAGING))
>> +        return;
>> +
>> +    dev_dir = debugfs_lookup(dev_name(dev), intel_iommu_debug);
>> +    if (!dev_dir)
>> +        return;
>> +
>> +    sprintf(dir_name, "%x", pasid);
>> +    pasid_dir = debugfs_create_dir(dir_name, dev_dir);
>> +    if (IS_ERR(pasid_dir))
>> +        goto dput_out;
>> +
>> +    sinfo = kzalloc(sizeof(*sinfo), GFP_KERNEL);
>> +    if (!sinfo)
>> +        goto dput_out;
>> +
>> +    sinfo->dev = dev;
>> +    sinfo->pasid = pasid;
>> +    debugfs_create_file("domain_translation_struct", 0444,
>> +                pasid_dir, sinfo,
>> +                &domain_translation_struct_fops);
>> +dput_out:
>> +    dput(dev_dir);
>> +}
>
> And here,
>
> void intel_iommu_debugfs_create_dev_pasid(struct iommu_domain *domain,
>                       struct device *dev, u32 pasid)
> {
>     sprintf(dir_name, "%x", pasid);
>     dev_pasid->debugfs_entry = debugfs_create_dir(dir_name,
>             info->debugfs_entry);
>
>     debugfs_create_file("domain_translation_struct", 0444,
>                 dev_pasid->debugfs_entry, dev_pasid,
>                 &domain_translation_struct_fops);
> }
>
Thanks.
You mean to add 'debugfs_entry' in below structure.
     struct dev_pasid_info *dev_pasid;
This structure is also allocated per pair of {dev, pasid}.
The debugfs dentry of  {dev, pasid} can be simply obtained from 
'dev_pasid_info'.

So the 'dev_pasid_info' can be passed as a parameter of this helper, right ?
Like this:
void intel_iommu_debugfs_create_dev_pasid(struct iommu_domain *domain,
                       struct dev_pasid_info *dev_pasid) ;
>> +
>> +/*
>> + * Remove the debugfs directory and file corresponding to each pair of
>> + * {device, pasid}.
>> + */
>> +void intel_iommu_debugfs_remove_dev_pasid(struct device *dev, u32 
>> pasid)
>> +{
>> +    struct dentry *dev_dir, *pasid_dir, *dentry;
>> +    char dir_name[10];
>> +
>> +    dev_dir = debugfs_lookup(dev_name(dev), intel_iommu_debug);
>> +    if (!dev_dir)
>> +        return;
>> +
>> +    sprintf(dir_name, "%x", pasid);
>> +    pasid_dir = debugfs_lookup(dir_name, dev_dir);
>> +    if (!pasid_dir)
>> +        goto dput_dev;
>> +
>> +    dentry = debugfs_lookup("domain_translation_struct", pasid_dir);
>> +    if (!dentry)
>> +        goto dput_pasid;
>> +
>> +    if (dentry->d_inode->i_private)
>> +        kfree(dentry->d_inode->i_private);
>> +
>> +    debugfs_remove_recursive(pasid_dir);
>> +
>> +    dput(dentry);
>> +dput_pasid:
>> +    dput(pasid_dir);
>> +dput_dev:
>> +    dput(dev_dir);
>> +}
>
> The same thing here:
>
>     debugfs_remove(dev_pasid->debugfs_entry);
>
Yes.
Just get the debugfs dentry from "dev_pasid" instead of 'debugfs_lookup()'.
And this helper should be called before the "struct dev_pasid_info" is freed
in intel_iommu_remove_dev_pasid().
Like this:

+        intel_iommu_debugfs_remove_dev_pasid(dev, pasid);
           kfree(dev_pasid);

>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index dd8ff358867d..af9c989035a2 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -2488,6 +2488,13 @@ static int dmar_domain_attach_device(struct 
>> dmar_domain *domain,
>>         iommu_enable_pci_caps(info);
>>   +    /*
>> +     * Create a debugfs directory specified by RID_PASID
>> +     * in the debugfs device directory.
>> +     */
>> + intel_iommu_debugfs_create_dev_pasid(&info->domain->domain,
>> +                                 dev, IOMMU_NO_PASID);
>
> The function name is self-explained. So no need to add comments. Ditto
> to all other places.
>
Indeed.
I'll delete all related comments.

Thanks,
Jingqi



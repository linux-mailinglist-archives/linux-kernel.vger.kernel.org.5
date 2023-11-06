Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9287E1B99
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjKFIDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjKFIDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:03:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AAB9B;
        Mon,  6 Nov 2023 00:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699257789; x=1730793789;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hL5vGQHY6ysRobFZhmuJKqDRslOEH0W9qY0DB+IAXK4=;
  b=mANjO8/r1Vh8lADS2kPFzLCvi6dkf1G6vNCf0enOiscYyAub1hTmn+Re
   PnMx0p0z8eOjaG1C8GVRzMosEvGwHeyQvf9hnxUIds/Qt2owijnRMkYMq
   coc2G0+kKKtnTkURKb4ZjK5sZlQtcUTqbJzRX4mrunk/8Xi34nzONenMb
   mEclkSn+mk9QBI1H0QxuWmNs7s2PRIKqkl7BwltrRK5Z/Ir/tR79up9ry
   GU70WIEFMWgR3a+Mmeu8I1IHPAhmr4fvsqx4ndmjdcWpn9k0+WxdnuQUp
   q7V1zHKs/LpEvk48w8qgDYt/jUA0W4JQOtcjQFWmcdp62Y+zjwV2/DJtY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="393123815"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="393123815"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 00:03:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="852899441"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="852899441"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 00:03:08 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 00:03:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 00:03:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 00:03:07 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 00:03:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcOKq+OoHf5t1zcmmWCPoo9l6rSkjI8hW2zb05SoeD4hr4SWHOaRqKQBqE6W+CL7g1dIGvhPdXQLG8BJd7PwwikiJwaEttyT2/H6SrCXGy4IgT8tZhthdy6KmL1QCm3aQzaXgSuiv5Xo4YpHdCx2RGhOZwC4tOFYL1+vJCy9N9L3I/kmdZYP7xWjTK0Qw8h5N1cUCLH9nnrj/CFYaMy07NY0l1qnYn/7tPCfDwJ/PiZOLLmHYY0rJJLPbh7Ubif3s6TS4Sp1pK0RfzszNcinjblLO+vt6cq41ryebmNRq8OM5wiAUlDx1EgO2nN2gvolUn/WnotXjklBT73VAD3Mlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiRYvam2wedCSASW9MpgA3sIUXkDp+yOUUY+Xj+ibxM=;
 b=Wr6K+imBjKyahHQSTTu8glAa91aZtOE5zCfJ6z10gGuvaV7wODGz6G2kobgEC1pbO50Uwn5+Qa5br7szFTpDXiqvBJ9SBf+jBUwc9Gu+LPgDFnu1oKH4V89ww3iOU3XGAa2tCJQ5fu7UYNwtAkSg8GqRzSUY7OCnM1uc9PqZT54FKyPL2tV6xXN6fFb+tdVBZMU4FJ31qiWlzA5OhgnslXtGyakFnIRrhsZcnrTXro/iZS/SlkEmJEty8J7aJtkbGIFP0RogcW317+B2VUzUIRyNnOQgMWJk1rejK214pATi7gBoaMhbSWUt1fEetEM63mKh+w/CoF3LAEKrktRWjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM8PR11MB5655.namprd11.prod.outlook.com (2603:10b6:8:28::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 08:03:04 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%4]) with mapi id 15.20.6954.024; Mon, 6 Nov 2023
 08:03:04 +0000
Message-ID: <7f2acf73-c687-420e-bc99-70082f918733@intel.com>
Date:   Mon, 6 Nov 2023 16:05:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>
CC:     <mst@redhat.com>, <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <netdev@vger.kernel.org>
References: <20231103171641.1703146-1-lulu@redhat.com>
 <CACGkMEvaKw9g0EmNdFh3=iZm3rD-mo_BtaBA3F5bwqNq4NV3Dw@mail.gmail.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <CACGkMEvaKw9g0EmNdFh3=iZm3rD-mo_BtaBA3F5bwqNq4NV3Dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM8PR11MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b813176-ff9d-4d97-5a66-08dbde9ecd8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DEgxMCkzc6LXkPWaBD/VNJsC7s0FEpaqRStuFZmAj53z2m0JmFHcs67tHzN4hHijGHb3P6SWxMsE48H2+4p4VEMO8o+ElgveElFHa3G0H1ZXvuL4IBltygbiuDWI4ZWe/BN53ni0kJ4+BUYHdgMZy4kD2fqe1Sjd445/Tu7K7qb4gtA+e+m7w2V1yCF0LJKWhrq/lsJcZxgZik24cYnfvSgMBGY36mnB9zXcEzK9fvb9KPCMp+8Emk4uqEXx/pDoi8irjgy3w6nNP3iM6IN6Wt/CHIY7ys8qDz+vU23xxWZvpxUvkwMXIxh67SqLvm1dSfp/IW5WpepxzU/No0w7Mw3832FyPPPoqGcagIqaNXMMcFIS1Rv8NoyhedKGoSRCIVZWs6Do46KgEc2xvrTPZ1tDeayNBXvSw5K+Thq89Ls6Byaf0VhYmzN+kympEjpxUoSohhN3X6cmFfN6FD5pB7Q5t3+7CpFZjwrdKQq3dp6u9mJbTg24nF0qWuNOevb2rMuMy2D7D6cyvADNxV1hzTLYLY1FWuWAy0tcqYoddVB9xs9dhhct8oiPoLEWsdfgVupPy+GTSqKuWa4PW5qqp+aG75TILZrBgVplWiFKNGIyD2J6l+cH5LvKUPU8FfQvJi5WfIk/vGG551px3qFgfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(346002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(478600001)(41300700001)(6506007)(53546011)(2616005)(6486002)(966005)(6512007)(6666004)(316002)(83380400001)(8936002)(8676002)(4326008)(5660300002)(26005)(66476007)(110136005)(66556008)(66946007)(38100700002)(2906002)(31686004)(86362001)(31696002)(82960400001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q25pSytpci9ZNDJJOW1yVXd5SjJGVDYrQ2RuUmRUeEJUWm5PaTExT0NJVGlp?=
 =?utf-8?B?NGxaWHhkZDYxTzdDTmZyQnZVTDBQWDFmV1p4V2M5M1BMTTl6THVDOHFGVmlJ?=
 =?utf-8?B?SmZTL2h1cXJpTUhuK3VqcGFvcXNXWnFKRS9VUkh5c0J6aERhNGF6K0NPdEVr?=
 =?utf-8?B?MjRlblBudjIveitZT0c0SVN1bHFPZnVnYm95T2NTQ2pBQ0JBanZyakFoUm1B?=
 =?utf-8?B?RktBa003REV5TXlBQlFzTWlhc1NDRkQvaG04MEdTdmtJQzR0RzVuU05XTFNH?=
 =?utf-8?B?M203Q0RPNHYzS3M3N3JURGFQR2MyRkRkZVpTaCt2ZDBNL3kwMjdrWGxQWDBB?=
 =?utf-8?B?bW9TaXJuODA2Vys0RDBWV0o0V1VKMUhaL29WMnhQODd6R2RMeGxZcjB2cmd5?=
 =?utf-8?B?bnBWc3c2aXVwRTdOV3lLQXZ5WUI2Q2dXMkpFT2VVOUkxYXh0Vmg2b01oNWJi?=
 =?utf-8?B?VGNWamI5bnVaSjBjQ0lPbG9DWkNuS0dWL1hSZi9WK2NEYUJuSUFvM01GVnMv?=
 =?utf-8?B?Q0lHYkluSlpSNFc3TitpWUsySTNSRHgvanY2MXRVSjNWNkpEVHNDV25LY0tW?=
 =?utf-8?B?RzZKQ0hoUHl3bG1aTWFxVk1CTUk2a3ZkL2xvOWp2TW1iMGZhdlFkWVFTUWZi?=
 =?utf-8?B?b21FRVdxejhEQVFhZ2w5c3RiK2JPZXBBMWdaME9WVkEwZ3NmRWdwWHd0bUVi?=
 =?utf-8?B?dWQ1a0J2YWhQWjVOZjVTREx3WC9DVldEcnpiL1R0dFpmUmxFNE81TkNudE5k?=
 =?utf-8?B?eC9zeWlVM0NhTjJuT2hQR2tZYjNRbnRYRUpPa3Q1RkhlVm4vMEt2azRQRFdE?=
 =?utf-8?B?SU55bFhTMFNFNEZhaU5UaGlJbGVJYzlCZy8xUHYrOUlBL1RCMmIvSmtrQUhC?=
 =?utf-8?B?amlVSHB4OU44eHlrcGxuYXp2T0MxS0FoZURuZnk4MkNJam12ck03b0tjYlRl?=
 =?utf-8?B?UXpXb1lGMmh3V3I1WGl0dHRvVjgrOTd3VW9Cd1RqNVBBTGdsT3EraWVGbGdR?=
 =?utf-8?B?dSs3b29rTEpHNUhObW5PbUxQWmtKSi9WT3RvZlcyb3FxU1lvOHdCMUUreGhv?=
 =?utf-8?B?TCtkb2p3UVcwdGJWSUNpVHZwVDNVdGNOWWROZzQ3NVZHRmxhNUxaUEJaOE1k?=
 =?utf-8?B?alU4dnppRzhZY0QxbThtRURaOFVZODNvZXJ5WThRajdwZ0xUTTE0ZkhqYlNP?=
 =?utf-8?B?ZElTSElCeTNBa3ZkS0Z5TFVJYzlUejRpZC81aVlyL2IrUVh6L3U1eUs2R045?=
 =?utf-8?B?dW1pWHYrb3U5MWVHQTFwdVZxRUFZSFA1NmlKMk51NExWb3VMZ01xN05qVEZZ?=
 =?utf-8?B?L1FBa1Z3WTVUUktDY1BZL2gvMm8wOFlxZTdxZmJlNkJJVktPbG5qOUNZbldI?=
 =?utf-8?B?eHNXM3JaOXdHbHpsNFN1b1loR1dVTVBQZWdOSUZNa3B3ekZmN1lMNmFpbmpl?=
 =?utf-8?B?ZW5mQXFNMnc2ay8wbUlaZHBrZ1ptWXpiSW5qSlpKUHpZMVVrNk91Z2VkRXEz?=
 =?utf-8?B?TUVoTVJqbkxtQVRPbmtoQld5TEZPS3l2ZEpyOTlCNElNaW8ycGwva0xmM3Rk?=
 =?utf-8?B?dHp0Sm1qcmFoOUZjQ1FjZ1c4MGhCODI2Ukk1d0pKUWYzbE9EUWJlTCtJQkJi?=
 =?utf-8?B?Tk5WRUdJKzJrbEJNTFRmZEJleHVqeWNtMVVSV2JpM2RwaWYvSHVCeXpFZncz?=
 =?utf-8?B?QVhpNkRVU1U1eldKOWtqRWZjK1RreXlKekduZnlnODZtTUR2a3dSQmMxRnE2?=
 =?utf-8?B?cENyY0ZSMXAwdW1UVndaYWQxSDFMVHlTSTlnYlN5NWJwbnIrbW03RFNkMnBY?=
 =?utf-8?B?OFhrdGQxbWRTTjFNRm5KZGtqQVYzMjIxVTBGcWN3eExVaEZmTE9rUXFBd3Np?=
 =?utf-8?B?MGZQM0J4TFBaVjhSMm0xV2Z4WjlhbStBYW85SzlJSmcwRU9JWURGZU1RYmtH?=
 =?utf-8?B?OFRsTDRkZ1lTSjhNYmNOSjhkMUIzamlYVzhRVnZ1TWFvU3N3NlVNTkdVT0ZW?=
 =?utf-8?B?VEd1cnMrc0V0ZTJteU9uM3JuOE44aWFKVWZwYXA3THR6WVVHbW1Ea2dJVjZp?=
 =?utf-8?B?ZTRpbktZTG9od1JxWUdCdm5nV3hDcGFkWGs2OTQ1d0pQTm92dzJvNWlkbnpD?=
 =?utf-8?Q?Ie4n1CwtOxTgpn84KVg3EQ8vA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b813176-ff9d-4d97-5a66-08dbde9ecd8f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 08:03:04.0869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSVxY/TDwgMDT5uJvN5CCOxteXY1xxYggupv59qM4ToLqvViWzlqkcq0xqo66wJqtUaDqQEQ1foB7zxu3pEtsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5655
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/6 12:11, Jason Wang wrote:
> On Sat, Nov 4, 2023 at 1:16 AM Cindy Lu <lulu@redhat.com> wrote:
>>
>>
>> Hi All
>> This code provides the iommufd support for vdpa device
>> This code fixes the bugs from the last version and also add the asid support. rebase on kernel
>> v6,6-rc3
>> Test passed in the physical device (vp_vdpa), but  there are still some problems in the emulated device (vdpa_sim_net),
>> I will continue working on it
>>
>> The kernel code is
>> https://gitlab.com/lulu6/vhost/-/tree/iommufdRFC_v1
>>
>> Signed-off-by: Cindy Lu <lulu@redhat.com>
> 
> It would be better to have a change summary here.

yeah, the version number is also incorrect.

> Thanks
> 
>>
>>
>> Cindy Lu (8):
>>    vhost/iommufd: Add the functions support iommufd
>>    Kconfig: Add the new file vhost/iommufd
>>    vhost: Add 3 new uapi to support iommufd
>>    vdpa: Add new vdpa_config_ops to support iommufd
>>    vdpa_sim :Add support for iommufd
>>    vdpa: change the map/unmap process to support iommufd
>>    vp_vdpa::Add support for iommufd
>>    iommu: expose the function iommu_device_use_default_domain
>>
>>   drivers/iommu/iommu.c             |   2 +
>>   drivers/vdpa/vdpa_sim/vdpa_sim.c  |   8 ++
>>   drivers/vdpa/virtio_pci/vp_vdpa.c |   4 +
>>   drivers/vhost/Kconfig             |   1 +
>>   drivers/vhost/Makefile            |   1 +
>>   drivers/vhost/iommufd.c           | 178 +++++++++++++++++++++++++
>>   drivers/vhost/vdpa.c              | 210 +++++++++++++++++++++++++++++-
>>   drivers/vhost/vhost.h             |  21 +++
>>   include/linux/vdpa.h              |  38 +++++-
>>   include/uapi/linux/vhost.h        |  66 ++++++++++
>>   10 files changed, 525 insertions(+), 4 deletions(-)
>>   create mode 100644 drivers/vhost/iommufd.c
>>
>> --
>> 2.34.3
>>
> 

-- 
Regards,
Yi Liu

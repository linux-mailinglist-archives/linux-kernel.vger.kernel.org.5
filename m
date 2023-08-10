Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B397778D6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbjHJMwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbjHJMwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:52:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29BAC5;
        Thu, 10 Aug 2023 05:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691671968; x=1723207968;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RzLRFeLuH2zlFhUyq3XOMIdcKl0bxxCnnDchCSmgBmU=;
  b=Ya/bC4CN6uJjI6sHd2Q90PfRDfHXer9njQ3g4SgY6HarNXTIRDzzzAGu
   fGvEc2lcu2YRoZik8M2jpSLz+2SfH12EbYWvGI4gHBiL756rh1B0II3Fm
   wDJu4LFg2fsHWa2EcCXMOzlcd8lpyVnA8gVEgf4EUk4SqVPeW6EIyJiAg
   TPL8lroQqSCY6TiKHMwcmtOWNSMWOwo7/Z35ybRsXBSvVrzCZckkRoKW4
   zIc77ioTp7bJ7eLsywh0i9SJg455xLvza//oiBrHl1B6CxVoejzFRV3km
   ttmB+cRR7VqNhJ5rPtEeRN47JXuCyF7kY1K57VLmPjrxSdHb7V3CHm6wA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="435285187"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="435285187"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 05:52:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="797601156"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="797601156"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 10 Aug 2023 05:52:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 05:52:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 05:52:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 05:52:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYThHWPo9dm/UHziUnQdKFC+X9/Gj2Cx69btItOSf+4AxxThkMwRcP+Z71qBynWtRIETQfBCTAGRgolxUpY2hvQ80C8GTz5XJEvRrBLQwwxwi5BuC3ANvSRBjmaWBk7igovLecD7+7iVdCrhWzjmsA7cpPBC/xH0w9DF8kQeLaaYaGStp5P6Ngls2YBcO/93uh/msitGAf8QGt7j67PEkNo95iCUVHSFGtuA4TRzxQbUt83QBLGPlhjzcvjRtUmBKJgExXOuuaTYVP7Vo9OE9Hv8OG9dAjZux4zUJJyURSccGd74BV1RRIqUOt/2S58S3pz3HWgO7/+wISE7F10BVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvW6OYYiJ/3l1fCokHzjMMIDjvDcA+02eGv9NtoZkFE=;
 b=KOYshoE9w63XpgACQO7SR/Gxy4rvvCyCSnZHLFKmbryjs6f32DmDraq1J0YGGoy9b9vZmHrrnost2bP0pCkmfqZI1HhNCBvRzkoW+bRV1T6TnN1hPhaRGqLq9EUCuP4quaX+Ht+YwCzv+KmyLbt5qFp/b4mICcB/KDsDeLiMDixglfvXHfZVdtO4zR75WYOKY5PeDA27G6Kgx0yjVROMRPShUZL2/faF1UZEWOCAg0es3AqYklS8DG9ohQeA/xHaJFIyQW1vJ16edlrgPkKTHlzx6SiGG4sr4pWok9sEd2M2FQh5FDMwwFiS1aj00sqwAMCWRmkhkRLFulILWcWwFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by CH0PR11MB8168.namprd11.prod.outlook.com (2603:10b6:610:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 12:52:44 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::aa6e:f274:83d0:a0d2]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::aa6e:f274:83d0:a0d2%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 12:52:44 +0000
Message-ID: <38f4dcfd-ccee-3481-a862-58b269bc0acc@intel.com>
Date:   Thu, 10 Aug 2023 14:52:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net v2 0/2] Fix VF to VM attach detach
To:     Petr Oros <poros@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "Keller, Jacob E" <jacob.e.keller@intel.com>,
        "Maziarz, Kamil" <kamil.maziarz@intel.com>,
        "dawidx.wesierski@intel.com" <dawidx.wesierski@intel.com>,
        "Palczewski, Mateusz" <mateusz.palczewski@intel.com>,
        "Laba, SlawomirX" <slawomirx.laba@intel.com>,
        "Zulinski, NorbertX" <norbertx.zulinski@intel.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "horms@kernel.org" <horms@kernel.org>
References: <20230809151529.842798-1-poros@redhat.com>
Content-Language: en-US
In-Reply-To: <20230809151529.842798-1-poros@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::9) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|CH0PR11MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b203af-8ac6-46ff-85cc-08db99a0b0b2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1BCQphnlG3C+Tsr+QqfmiCnCxVlDOuZFqpNJZImNM82phWqDpTF/9U0yW0Uj0/5Mu+9RxdEPSbAzetlc2lPfjjQLOPJxKIQ7gkKiG5PMK7pJdcPna1WsBmHJOzkF0mGosyOvwMM2FAABmOYjSsInW+wSnq8xBEGnHyq31s2Wwle8dA4uYeqsSLgR8SuIGhCwiEUP2oLqy4HIRWDx0FL0q5iFF2DdRHMP02EfuFP6idwe4kUY7HYP8H6yw4Q2E8orjOw941CpFwaVsFPO4kQRpxjHTJXiw6hGUUqYB+XAOkt/0ME+qfdQjk0Z+o8CmhX17F100OvcVElrA0/hx4ht70wchJe1pg5tbGY1YnitylWhlsOxXehzySZa1wZluOAX7DcsXBSQs3un+ONkTadOr/vriW0DcuUdYCzNNqa9P5NZ2bItGg1cCVvscbrA+fkwOugbWm12k3PNBkFlp4s+FKwyNYiWFOkt761kJRs8xD4/UUI2Pav84gzGBJ4wyKpRgqXudbPXpc3GFLVlsCK9J6kQP4YcMpT8X/mZXbwTzvrUyNNOS2+KSvvKsHYRPjiwVm2lDbnamZfZ1hqG5+ZHYAyctBvtLsvk3xknOqTHALYriSexxH0CMWsRb129b20nlfByUpbCeuV7+Fzza1WJIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(396003)(39860400002)(136003)(366004)(186006)(1800799006)(451199021)(66476007)(66556008)(66946007)(41300700001)(6512007)(966005)(6486002)(6666004)(36756003)(4326008)(5660300002)(8676002)(31686004)(8936002)(316002)(54906003)(110136005)(4744005)(478600001)(2906002)(38100700002)(82960400001)(83380400001)(26005)(2616005)(86362001)(6506007)(31696002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZStFSHl4ZmVjK1hDV3RJOUN5YVYxcit5Zm9oMVVxSTRDOWdQc1g0T0xWc2lW?=
 =?utf-8?B?WWRUMnRhaThYYysxcDI5Z2tWeWQ0a3hHclpuRXBGUkZWT00xZ0ZJVm5EaGd0?=
 =?utf-8?B?ZVFUUlhpSHRVS2hRbGNPcGZyTUVZc3hxYmxLd3YwRlF4ei9hbTBPbGRLVmU0?=
 =?utf-8?B?eW1OempBQ3BrVm1OMVIxTXR2TG05MjBueDBHUFRVTVd5M21kY2FsS2ovN1dt?=
 =?utf-8?B?WGthNCswNWtJSHlWNENnYTFidFI5a0hpRkFoemFFcktvWm1GUG9pbWJnS09P?=
 =?utf-8?B?aWFEODVubjJVUDQ3UzBORlBtOENuOE9vVVBDc0g0TDNiN1MvbEV3dVhEeXRI?=
 =?utf-8?B?Mk53dE5jRnhrN3JKaFhXMTI2eUdtZ09Zd1J5K0JVWjFnZUxNMy8vdGVEV2Na?=
 =?utf-8?B?UFpEanNSTm1IaUNOUWJXRzFncEZ0eXRFMFJ5Um1zU20xenV0OVJrTTh3dE1O?=
 =?utf-8?B?enNmV2UyT29MaU1NZ2kxbmFmTXBzOWZSZzh2OVhlbWVyYy9wSmcxQk9QOCtL?=
 =?utf-8?B?eFUrUW8ybjlycmtnS0d5WXdjZVBCZGpkUStIT1Iwa25GRlRUQWNYeHdoeTZD?=
 =?utf-8?B?Z1VmVkNSMmVNQlNibk9Pdkd2TEZUQStaM3REOVdWNlhWaTZ1NGMyZGIwRWxm?=
 =?utf-8?B?MVhwc01hTjFXRThjd2RTakNpL3dBYTUzMHRmSmZhU3c4b2U1Zm1OVHVyTHhj?=
 =?utf-8?B?SmdDZEZhT1FCWnJCZjNaSXo1M3dQZE9QdDR0YTlIZTZHdUN1anpoQ2FHM0c5?=
 =?utf-8?B?UkdvQXpJQ2VJREw3dmZmaXhrZzNGOHJ6SDJjT01SWm9rT3BWU2FUSjZlU0c3?=
 =?utf-8?B?dVBob1d2SVE0WkxOcmRobWpWdHg5L2xoS3BsVzJLQXpvdCt4UHl6Vi9kRHdo?=
 =?utf-8?B?N3FLc3lFWXJPaTEvcDlQWVNuUjFvb3htbVFmZkE4UmxzRFFGRGl4RHhuTWs0?=
 =?utf-8?B?Ylg0N21nMkJaUVJnbkhJQ0d5L3lMMUg2c1RIVnRUbTlFWklwNmduVXRsQnlI?=
 =?utf-8?B?WUYvRG5RQ0pHOHg4SHhQdUZkcHZ6SSsrNWVlZ1lhYm5kenRCSFVkWU5Sb04v?=
 =?utf-8?B?dmdXSWdqM2pTOCs5SGI2SEFDR0xNaVJVL1dWb1VRTnNybkdjK3VUYzRQd1Uy?=
 =?utf-8?B?M1BzSDJiT2pVRG0yVVc3SWFKZUVTSkVNaFBnSEx1bHN2VnBBNHh2TitmMjRa?=
 =?utf-8?B?QytvNWwvZjhzU2p6TjRMMXU2L0NRV2RqQkNla29DVlplalVUNjB2Ulh1TlF3?=
 =?utf-8?B?eTNJQzNiYjg5M20rNVRSMlVBdFVYeTcvMk9xSlNRN0FEbHBlOVV5N3ZjMkt5?=
 =?utf-8?B?cFN2dUNsUUo1SkRvSjU1ZndrSjNNVGVqYzJlVjJCd2tVaEFqVWtLTmJXODcw?=
 =?utf-8?B?ZUgvQmdlTDdmM04xaWNFYjV0Z1FoeHlJa0dtbTl6UE0wRy91UGo4YjFLV0RI?=
 =?utf-8?B?WnpVZUpUMzFPdkpuUWZoWXhmMVplLzdkZXoyc05rUWo0cGR6M2ZPV0xtdnF2?=
 =?utf-8?B?SGs4NlNZVW5GN3Nia25OUEhRTnpwUmdzbHYwMUFqQVNmNHAzZEFsNlFGNzBP?=
 =?utf-8?B?b2VPemd3VlZ0T3loZnRPNUFpaTJiamloczZJQXljS1ZHbHpwTFdLSXNSWFhQ?=
 =?utf-8?B?aHN3YmF3Tm1XN2cydWpadVRaNlhSbzVGaU5LSSt0WUtYY1k3Y3lkdk12TzVI?=
 =?utf-8?B?VGp4UUhpcHZVTTkzR2lxb096amtHZEtSR0loL2tEelFYbmc2YnhSMCtIWUhE?=
 =?utf-8?B?aXdrczY4R2xNSHpRQ0s2WStvVEkyV2lENE83dU4veDRPOEYxWnI3Q20yWDUz?=
 =?utf-8?B?MTVCSEQzbjBmeFRoNmxUTHY3NjcyYkkyZUg1ZzRSRzNPZFV2ZytYMkNQZzF4?=
 =?utf-8?B?RTRuQ1dJZjNWRFhwcGowV2U5dWh4YkdiUXlKYmdzWU9pYkVnVS9IRmRiWnlt?=
 =?utf-8?B?c28rM3d2R2hsV1IvQWNPV1pSRnFncjRwb3hydDlpUDJQWE9wbXhNYkxPNENB?=
 =?utf-8?B?aWZmQzdwd1dNcUtnU1o4T25sOXgvTTdEcWpnMUpiSlEzMzJwa29QN00vd1ph?=
 =?utf-8?B?eW5sWUY3VFR2N2ZoRmVtZDBxL1VYNnpYK1FFNkhVNmUvZGdBRjJiWm1SSGZK?=
 =?utf-8?B?SGxaQkMzbU96KytpQ3NieHNqRlRCZitQN0owdzZXWmo3Q1I4ZXBjRUEzWUlI?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b203af-8ac6-46ff-85cc-08db99a0b0b2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 12:52:44.3808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7PkJj9YLhAUku445hfpuixoFjxQq+HdgUiRTDt3IxRHVjuYic4enR2ep/W9/MyBGGWT7q5NMvpdoN6ssf6WZr1xqcONgUxYpyC6NOCeDLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8168
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/23 17:15, Petr Oros wrote:
> v2: fixed typos in the description of the second patch
> 
> v1: https://lore.kernel.org/netdev/20230807094831.696626-1-poros@redhat.com/
> 
> Petr Oros (2):
>    Revert "ice: Fix ice VF reset during iavf initialization"
>    ice: Fix NULL pointer deref during VF reset
> 
>   drivers/net/ethernet/intel/ice/ice_sriov.c    |  8 ++---
>   drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 34 +++++--------------
>   drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  1 -
>   drivers/net/ethernet/intel/ice/ice_virtchnl.c |  1 -
>   4 files changed, 12 insertions(+), 32 deletions(-)
> 

You have forgot to propagate reviewed-by tags from v1 (Simon's, Jake's, 
mine)

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

(I'm not sure if I should copy-paste not mine RBs here?)

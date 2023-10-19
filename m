Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013197D042E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346598AbjJSVt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbjJSVtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:49:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2B0115;
        Thu, 19 Oct 2023 14:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697752190; x=1729288190;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Sb7KbAIIFg8Q6dDtlP+Ls2HW3rpbFdLxbHlHTVWIwW8=;
  b=W3eGJyEkopHNg6lMsJoQ6W+6Rh6hvS2kDA+2SX9hty4QTwxo8zZoJQNE
   kXZ55wNFDB0meH5IjoR2zWN6S+BAkLtC2AIYv6A/U0EDj9pLDDrhOuEja
   1T+eVkvfFof0xbLJO5MmRiJrEXrsjK2BPHc64Dctgivukv3TPlcSm1Xiu
   AdR1CPyddQ5C49kRJiiLuLL3kdAMWxf0GTtmzNbS8LwQhPV09OlkoTn6V
   Mth6It+Nhuk7i1jBLzn2VwQIzP8XoEqdXMnSWisetdWC3e5aDKD/5BJSQ
   l+f+RTbiokbZSGMvMnaxOvTO3E6w/AzR+gK9Bq/7CL1sMElQHwzCPSD67
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="365718136"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="365718136"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 14:49:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="873649270"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="873649270"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 14:49:49 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 14:49:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 14:49:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 14:49:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 14:49:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYIJdXdJmyAltzWZ/Intyv+F1xSZBBbNrgaCmGzRe1HhUBQQzj0Ggk3EXhM3XALmJrWVpTKyXXbNSim8iRp4IVnFdVjtSNZHC5vbGG+WIyz8ptoF3xltlHU+YWBHMn8OM+CThlYS2lQfdhA9CiOVUMNr86CID/lpikpNCC25Lx7DhfKBfvCkNjeXVmsf5A17lOhjrujFfy0M8S9Jipm1JJpq08ISFfdGdD+OVzP1a99DEXT5sQ4bX6mWfOEh+vQKBVNG66qO3cQlqbTdeRNVwUZP9S6F1E0MaOCLICfyIb3wCtvX4w9yKWK2kBOPqLdW6s7uDVSAH3oqnPy4cFVP3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOvf1e+qAXxZ8vZaqjhKMsBpxE7md9AmCNowsBiE/X0=;
 b=P0R76xKJvKjXGqu91X76IjQe4WM4yAluvw3Y9ocia1X+Jh8T+b+IXqX+nTkvH0zmCAv07ngETKLxER4lu1Zg8+liqAY52MOhv7gQfdgg8QL83EbEaWRrAuJ5Rt48Rgtl5UopLzrjO9mFQ1IExdpcdlLK5y30QEjS1c/hDLB1UbKWXP6TtswMaHIkHrXjvZIMIMC2Cvrx8eDGArX/bhOwhDRGALxZ42KeMLH5h2WjM6abeNEI6YEmRizuP+d0oSk+UqRgx4VajAPEHvh8ArgRiSdgCeBbv9NDBvajdz7YVhRmbisLpiMdycp4cGoSnHqnYZw1knGDncUc8m1hdN+UGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by MN0PR11MB6058.namprd11.prod.outlook.com (2603:10b6:208:376::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Thu, 19 Oct
 2023 21:49:44 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6907.021; Thu, 19 Oct 2023
 21:49:44 +0000
Message-ID: <78a9a07b-0a94-4b38-75c7-8bc240468430@intel.com>
Date:   Thu, 19 Oct 2023 23:49:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net-next v3 01/11] devlink: retain error in struct
 devlink_fmsg
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>
CC:     Jiri Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "Cai Huoqing" <cai.huoqing@linux.dev>,
        George Cherian <george.cherian@marvell.com>,
        Danielle Ratson <danieller@nvidia.com>,
        "Moshe Shemesh" <moshe@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Coiby Xu <coiby.xu@gmail.com>,
        Brett Creeley <brett.creeley@amd.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Eran Ben Elisha <eranbe@nvidia.com>,
        Aya Levin <ayal@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Jiri Pirko <jiri@nvidia.com>
References: <20231018202647.44769-1-przemyslaw.kitszel@intel.com>
 <20231018202647.44769-2-przemyslaw.kitszel@intel.com>
 <20231019130037.GI2100445@kernel.org>
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231019130037.GI2100445@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::15) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|MN0PR11MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: ae12336e-44df-4910-5df3-08dbd0ed4e3d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BRLOn6NdjmFTmO0ZurZ6fWGJmC1lB5Q7Y8VteAAUj//iKuN7wDa05FZj4v5B5JN1ma5l+p3IUlfYG5oRbQ4vdeNGhEvdrJyH1MUw8JRiOuZjF7ZZyitttapCog8She9gP0K0bgfa8dtDqUgnK1ke3XOR2YPWDxmAxOfLDMVmG0dtBHPeSpzkwdopXcVD+zKNbE5MI91OytPOF6+abRYokjRpNnry57gzB8uxhEQakNNPUaDMX2Y6DHlUKeGShLj934mOKgV3Fglgm/R2YBc2SSkSXet4xQ0p0oU7qI57bq08/oySMxgrAxEhHcTDP/P/UHd7w5jRsTi1wQNC5TS2+iTQ9WJtXOwn1zIQHC0OGRoIkK5J+RgUD/mT9exmBGLfiMBRdH34xL6si15iL3cQ/UJVW0lOVbjfz3BO1DoK6q4IiXn8mehMgYUJoGRPEvGU7SdYOJFS+dkyAYPihGseQ4HxNEdkrEPJ02Ysuz99sdGfSGESH8tEkykFIrdVauiBwK4lv6O8DM0FlYTJljcqvrVGyoPysSXxnLAxpogCikFUcZumCAC6VzL89sTMUaaH4G+2Z8GB3LwW5OpyGCyy5feaeYKsBb7gCnRC6UPEbk9xev1LUpEBE8A/R/zr6vrM6k9x1cbLjlYOir/zCfYocw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(136003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(26005)(5660300002)(7406005)(7416002)(6506007)(6666004)(31686004)(2906002)(4326008)(8936002)(8676002)(6512007)(41300700001)(66476007)(54906003)(66946007)(66556008)(6916009)(316002)(6486002)(478600001)(53546011)(36756003)(83380400001)(38100700002)(2616005)(31696002)(86362001)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3VOWWthSUlVdm9wZmRucjV3VS84U1Evc1EwaGdwamZJd09MMTBRSWgrQ0Nm?=
 =?utf-8?B?SlFrNFhZVklVTzhGZUU5QUpwYmk1U2hENCtDZTVKS2VUemJFQmpUT0xsRkxK?=
 =?utf-8?B?WFo4K2VTNVlXN2FDTEpwdWpGRmNLYldDKzNraG55UzVENGdrZDFaSW5PRGg5?=
 =?utf-8?B?M2dOY1o1K1MyOXVGbjB3cFBuV2FSaEpoc0lPcjJuNldHTktpNVNmSGc2aTJt?=
 =?utf-8?B?ZUtFOG5nUjRrSU5iSmczUW9WMlgwL1dXRGh5bHBjNWJSenJTZ1NhM0xzR3RD?=
 =?utf-8?B?cVpuQ28zVzdmT0xqeWhXejJRZ2tkNk9mNGVFclREMHlHNFV6M1ZxaHJLM3BN?=
 =?utf-8?B?eGFFQ2FzQTNKMmVhYVQwVDJyZ2E1TlFuNUhKa3ZLVmpsek9vNEJxTzE1QmJw?=
 =?utf-8?B?YlNmZ2ZaeCs0Y2UrTU9Qek1sQUhYbjE2SkZKNWoyaENETVcwdTNGOXMxYUlz?=
 =?utf-8?B?RHdYNzJVWktsWGMyVTlNVmxPRklTcDZjcHoxOHNqRDhOU0ZxQjVNMGh0YUZO?=
 =?utf-8?B?V3VRNUZtaGRTSVE5aXhqMTZTckdmaDR4QWU0dlJOaWFqcEJ6bHVSR2VCS0FL?=
 =?utf-8?B?dFRQSFpYbFJRY1ZaUnhQbk5rMUZvSDVGRnM2OVhJMEg5RFZuRzQ4c3ZtRHUz?=
 =?utf-8?B?T0thN0Q2dmFWc3l3UVFlM1Rja1htSE9qbVRaYmlFMnNxMWNpenY4WEo3Nzc5?=
 =?utf-8?B?QjBOWTNQUVpGZHdSZ044S2p6eGc0UW5MQ0gvV1Fhd3FucmhCOGgzSDVWUllI?=
 =?utf-8?B?U2lXNmZUdndDd1FuVkZSTHAwczNZWG1McGN2UjBrNE54em4rUmFyTGNVbFBt?=
 =?utf-8?B?dVJqRjA4TXNMSTVadDRVOGxwKzYzYjEycWRaUVFCZnRxY0hzc0NZVHNCODFV?=
 =?utf-8?B?b1BVMjJLaU5sYXhBdjBmL3VmT3VxdXFqZWk2blc2Tm5ZYmtRSDYrTklZZjQ4?=
 =?utf-8?B?anNVS1RLajNWTll6Tks3SkJ6TW5FVEI1dm93d1RTYmlrYlZaY2RMZGlxVUFJ?=
 =?utf-8?B?KzdPanJQMkcrV2RRUDVqYlUzc3JpM2VicjNoR2ZFTEZyeWlQRFdJd2dLdGJZ?=
 =?utf-8?B?UEFJK3Nsbjh6Zzc4d0ttellWd3FHdWJEaWtPVVRKQ3p4MHdmMlh5UzhOZGpJ?=
 =?utf-8?B?akV4WEFlMDZITk9aWnIrTHkrMHl3TThOMEhGOEZjQmFtMThDL2FhQWo1cE5w?=
 =?utf-8?B?UHJzQVloS1owRFJBdGkwZmRLc3psNy9YWWlyWE9aVWlPSjVqUXFuVEpzMDRu?=
 =?utf-8?B?RXhjcHdRT1Qzbk9JeThmNUJxcXgwbWo2dWU2bGxIeloxbk5iNFpZQTJkbzJs?=
 =?utf-8?B?dWJXUkZ5M1AvRkU0RjR6TDl3UUo4Wnd2OEF4bDRxaDVkdTQvc3h0TlNtcnVk?=
 =?utf-8?B?RGE1bVA2VExUQSt3RVNtVFBpVldUSDluWk5seituQWVWQ2xmaWhmNlFYUmZw?=
 =?utf-8?B?S2dSbTE2UVRlR0RXREIwQi9IVUdjYUNrQ1RONkM0MlpPa3NucnJ3OXhJRGRJ?=
 =?utf-8?B?eVRPTExIQzhYeTVlb2phZDhTRDBIL3ZXSVE4Vk9vQVcwSzFGZy9sV2MzTWdj?=
 =?utf-8?B?b2FGUXB0a3MvTWtYN21kN3dTaHFISDZONy9PUkFHUVF1SmVVZXgrcnpTMHcx?=
 =?utf-8?B?RmMyRkcvTzJaVzFmWWdWclVMRjYzcERkQzNNRU0xV3I0bExYazFTdWlKQXlR?=
 =?utf-8?B?OHplVXloUDNXaEo3MnhPSlNaVlIzZlFTSzZyV05Lbm8zOUN1TkRzVjRURXQ4?=
 =?utf-8?B?WnR1S1AyVk0vdnNKcENaZ3p1ZHVaL25CNmdWTHpVSmljaFExbWNCOXozbzJX?=
 =?utf-8?B?U0JTdEFVSlpmNVVGYVYxL3NXNGJ5TjNRS1NZZWJZMlRTakk2cVp0ZkR4N0x3?=
 =?utf-8?B?MXIxTVRDRVZRTHZ1cUQwY3JaVTFDRDlia3J2OW9TSDhvUFRUQmFxSHlUYzVE?=
 =?utf-8?B?TitONDZCY3hqUTExODRwNjlkMVhvT2RMSTF2QlJ0MFdRUG04aVg0NFUvaGR0?=
 =?utf-8?B?VUNKcXNUaVk5enJsei9vOFBKVE5GZHprWVRUL3NZeFBlbFdUM05hRndGN2RD?=
 =?utf-8?B?U0Y5ZXBDVFZUMnNZZzFRR0hXN3JmeFBHSm83MDFsTjJCOUhRUFh6MCtrTVFE?=
 =?utf-8?B?WlE5bEg1aEZGeWhFWTVNVDd1UFNmU1M5aG5zOUtGSFpvWXRuNXdRSTRTakwx?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae12336e-44df-4910-5df3-08dbd0ed4e3d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 21:49:44.4420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIMVVtu1BM5FSkRUU5FKx7RkuWk60peWkZym/nbUqQ0bL26BWj9R+FxJH/vz2Ym4WFbaX1VxT+NLTgRQoVBWWQ6cv+lLzOhguClcB+AYCk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6058
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/23 15:00, Simon Horman wrote:
> On Wed, Oct 18, 2023 at 10:26:37PM +0200, Przemek Kitszel wrote:
>> Retain error value in struct devlink_fmsg, to relieve drivers from
>> checking it after each call.
>> Note that fmsg is an in-memory builder/buffer of formatted message,
>> so it's not the case that half baked message was sent somewhere.
>>
>> We could find following scheme in multiple drivers:
>>    err = devlink_fmsg_obj_nest_start(fmsg);
>>    if (err)
>>    	return err;
>>    err = devlink_fmsg_string_pair_put(fmsg, "src", src);
>>    if (err)
>>    	return err;
>>    err = devlink_fmsg_something(fmsg, foo, bar);
>>    if (err)
>> 	return err;
>>    // and so on...
>>    err = devlink_fmsg_obj_nest_end(fmsg);
>>
>> With retaining error API that translates to:
>>    devlink_fmsg_obj_nest_start(fmsg);
>>    devlink_fmsg_string_pair_put(fmsg, "src", src);
>>    devlink_fmsg_something(fmsg, foo, bar);
>>    // and so on...
>>    devlink_fmsg_obj_nest_end(fmsg);
>>
>> What means we check error just when is time to send.
>>
>> Possible error scenarios are developer error (API misuse) and memory
>> exhaustion, both cases are good candidates to choose readability
>> over fastest possible exit.
>>
>> Note that this patch keeps returning errors, to allow per-driver conversion
>> to the new API, but those are not needed at this point already.
>>
>> This commit itself is an illustration of benefits for the dev-user,
>> more of it will be in separate commits of the series.
>>
>> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> ...
> 
>> @@ -1027,14 +934,12 @@ int devlink_fmsg_binary_pair_put(struct devlink_fmsg *fmsg, const char *name,
> 
> Hi Przemek,
> 
> The line before this hunk is:
> 
> 		err = devlink_fmsg_binary_put(fmsg, value + offset, data_size);
> 
> And, as of this patch, the implementation of
> devlink_fmsg_binary_pair_nest_start() looks like this:
> 
> int devlink_fmsg_binary_put(struct devlink_fmsg *fmsg, const void *value,
>                              u16 value_len)
> {
>          if (!fmsg->putting_binary)
>                  return -EINVAL;
> 
>          return devlink_fmsg_put_value(fmsg, value, value_len, NLA_BINARY);
> }
> 
> Which may return an error, if the if condition is met, without setting
> fmsg->err.
> 
>>   		if (err)
>>   			break;
>>   		/* Exit from loop with a break (instead of
>> -		 * return) to make sure putting_binary is turned off in
>> -		 * devlink_fmsg_binary_pair_nest_end
>> +		 * return) to make sure putting_binary is turned off
>>   		 */
>>   	}
>>   
>> -	end_err = devlink_fmsg_binary_pair_nest_end(fmsg);
>> -	if (end_err)
>> -		err = end_err;
> 
> Prior to this patch, the value of err from the loop above was preserved,
> unless devlink_fmsg_binary_pair_nest_end generated an error.
> 
>> +	err = devlink_fmsg_binary_pair_nest_end(fmsg);
> 
> But now it looks like this is only the case if fmsg->err corresponds to err
> when the loop was exited.
> 
> Or in other words, the err returned by devlink_fmsg_binary_put()
> is not propagated to the caller if !fmsg->putting_binary.
> 
> If so, is this intentional?

In scope of devlink_fmsg_binary_pair_put() all it's fine, and perhaps
that lead me into thinking that it's fine in *general*, which is not,
as devlink_fmsg_binary_put() is exported (so it's return value should
be preserved).

On the other note, it's called in two places (one of which was just
covered, and the second place is mlx5e_health_rsc_fmsg_binary(), which
really just mimics what we have here. So this is also fine in practice.

Last patch of the series fixes it for general case, so barring
pathological cherry-picks or reverts we are safe.
Do you want a v4 with that fixed?

Other thing is that this function could be changed into some internal 
helper without export.

> 
>> +	fmsg->putting_binary = false;
>>   
>>   	return err;
>>   }
>> -- 
>> 2.38.1
>>
> 


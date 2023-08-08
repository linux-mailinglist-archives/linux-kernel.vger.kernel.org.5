Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90447774E11
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 00:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjHHWLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 18:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjHHWLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 18:11:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E314E51;
        Tue,  8 Aug 2023 15:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691532667; x=1723068667;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yFVVP0+cfR5F8lXELh1PhqDissCFFwvl9Ybjd88oX98=;
  b=VF+GDvJKTtIXYBl6qjtHnFSSGQpPUTX8JIvA607EoOqAKpj9QOZqG+PU
   O+gAJErXxVyeL3VSB2Z4kBN6IxX1d/tAgh2s+715HRWkrgLiPLFumpKbk
   uH8zwNDjPRBpWmU75VLIejB+FRDjPPuj7hAB6Y7vyxN5AadOyalwsWQ7X
   c9P6/uLVrm1tTFn5n+mXtOp5ZXC6iGX9VzdGVd/iQn4jxTPnd20GoHXJG
   sXBOBl85foQSmDLuZARUZsWu0WzYSRVr37M1h+9ToPJBnxX/BPyGSCd9p
   1tlihF77HK2c9DxrUa7e32QvxrHsCNYPi00TMZBw6/vjdClQ+PSPmcqiu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="355925759"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="355925759"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 15:11:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="796886748"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="796886748"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 08 Aug 2023 15:11:06 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 15:11:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 15:11:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 15:11:05 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 15:11:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAwznULqfy4mO4PvJjCaQ1R0D9hkCydPlj8qhqq05kCSEYK5gU2oB5eE8IUrl/HXhAlg6NN55/axaY8arZBXyx+GZy6RJUsZ0T3wyFwYqk+NCmYUCzBxM7RIyO+Wze6X7jSeZx4BA3YyBvcIzhahFUE/WsW6QMFK8A0qPXNDTeksQ0mo0iFHFj5ySzCoDsqe5UTAXF7KCwxW/1HdrALzhg4NPBjmw0YxiXw09aoRm1YzfqT1n8oK0Oycjz7FCXVXeRvp4IprWKiQUmfQLwqEyNqMuAEvQBuibBM2PHWl6GTl6bBUker/9XJ8V/c6hyusGi3oORXEKpmTqWxDMafrIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDcruYEKEt53EVNMx0oLYSOa/x7EUJPFJ4Uk/H2Iv0I=;
 b=fYRGkX3TVZpYZGMj+WShGyju9bPDsf9iLvUiqAdPVW6YwUsaOk69crBmucDrNf7WSuEgiALVkmzFFy4KeBfVUkBzYV/2THhePpu2Ju9wv3mHwnA/bhfBWDrtSpfab8hmoWBti8RjWvQU4O4E7zB+0zGNbfEgkTJcA0MI0d2CdsDQqEGbr5VDSohUKBC5nCuf9+Sz9RPlraDkHp951Vo+aBQMaXwhQGSmpcmr/cRZt5MgBQcFul822K5kVLNcxUf9OcR6SqaRrDGjBv5OdxTg/wN3yX4y/Mo/miqACdI4v+Zq2yT2nj0jKtlHeJLJKG7ip0IxNyYmMRarN8SrQzwqiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW6PR11MB8340.namprd11.prod.outlook.com (2603:10b6:303:23e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Tue, 8 Aug
 2023 22:11:02 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::cb4c:eb85:42f6:e3ae]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::cb4c:eb85:42f6:e3ae%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 22:11:02 +0000
Message-ID: <9ec85f45-4724-4695-a853-16c5efcf8151@intel.com>
Date:   Tue, 8 Aug 2023 15:10:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net 0/2] Fix VF to VM attach detach
Content-Language: en-US
To:     Petr Oros <poros@redhat.com>, <netdev@vger.kernel.org>
CC:     <jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <przemyslawx.patynowski@intel.com>,
        <kamil.maziarz@intel.com>, <dawidx.wesierski@intel.com>,
        <mateusz.palczewski@intel.com>, <slawomirx.laba@intel.com>,
        <norbertx.zulinski@intel.com>, <intel-wired-lan@lists.osuosl.org>,
        <linux-kernel@vger.kernel.org>
References: <20230807094831.696626-1-poros@redhat.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230807094831.696626-1-poros@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0209.namprd03.prod.outlook.com
 (2603:10b6:303:b8::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW6PR11MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e82a61-2c28-4be1-7f8f-08db985c5a0e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dt//su7c4MsfDwCN2MbTy/N/8/yu7ee01sHZ5JH8mZ/0ZfLfTCesmV7t26PnOP7YTEt7Br491EqYliqH30seKeUbZRFwoSSUsv18suiPFBHXX26oLCX+zd58XWUFdCC+F+2FkHk8BZTAdfru69HPovH+b3ZhruTq3tzbnimC43+MUIj9CvjUYeEhtxgG/5L5k+mYhFpdc1FSGZ1s8fnrlCtvFDx6/boScI4UegNnM53zEVEs/ZKZU56GSYqgm+IIp+1raM36PoDs1Onv/CU4lu/wAjZ0m7pEEZBTFVo33XeDEq1LFZvwTMXrlrXMSktbm8pVBufDSQ+k6qSyrmETlv+1XX7COYADrwKG/d5n0/r+F+1pN20qtrIyNJVLYvgsMaaYCt9KGXT5LmOx9mKqiY1Or6dRpbZqxNJfJFBCnk9TEfW3sxuR0ejCMM76OEMxfYiOSGL/Lni/2lnHgPiDf4Ebh52EAUR1+gAOmbnlZp0eivr/AWt16YNL/5m9QaQ+IitteZ23B3fgqB1eDIBPShEH3NTcUDRYbSDJNwUtXdBxA925xhzTO2BCpvf7q8S2AziQDo6DbM0qGYQm8FgHEJVxkb5F7ZXNWys1xIz/8GhnYMrw8X+pCLEpdKrgyQG5SJ/z2pazKtm5EQtZZMgF9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(396003)(136003)(376002)(186006)(1800799005)(451199021)(6506007)(2616005)(36756003)(26005)(53546011)(31686004)(6486002)(6666004)(6512007)(478600001)(82960400001)(38100700002)(66946007)(66556008)(66476007)(4326008)(316002)(41300700001)(8676002)(5660300002)(8936002)(2906002)(83380400001)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFBnRXdRbUdEYVBYWE9UWE5EbW4vc3p1QnJIZ0UxSTNjdi9hZm45bld6MnNs?=
 =?utf-8?B?ekhSckpiZytScEV3dUhPMG4vWWpmOHlNTWt4SnhINE9jNkRjZG4yWkFFTWlG?=
 =?utf-8?B?d3RMcnFGcFQ3WEU5TjdNQlVRRDRwZzlIZWxWK0xZOEp0L1hGd3UxcFFweUx3?=
 =?utf-8?B?WWxOR3FHMlAxNU45Z2lZQXZLSHRnYzRvUkhBN2dwU2E2ZE1zUjd1SkYrM3RZ?=
 =?utf-8?B?aGVuaEwvbllxZ2laTFQxc2RYZFFub01zM2E1UnBjTUw4UDhlSGdDQi9WWitq?=
 =?utf-8?B?Y01JeDRTWitmbmNDRGFsVnEwZ29DVW1vTWpvb2hNRHVZWWRXcTNJbTdxMUhR?=
 =?utf-8?B?TFdCdEJiWVpCeHpwSW9aRU5NUkVnUXJYMUdvUnBORmRwREI3dEJBSmFPOHl5?=
 =?utf-8?B?MkJaK0oxek82eEw0cnhaYjFJdTFvM0RjNFp1OW9iU1Y3OEZKV0liclEwcHd2?=
 =?utf-8?B?ZnlIT0s5V0FuUzNtamFZMzZoRTNQbUZQdUhhaVhNd1d0NzVabUZGT0ZqSVlJ?=
 =?utf-8?B?cDNlbUdTSlZia3ZFeTZYZ1ROUGUxN0xIajRWL0pQZmQ0U0NDa0t0UWxWMFlW?=
 =?utf-8?B?NmFBNkdCdHdnQ0ZCYjI3SUhmNXk4aGFYNThtYTMvWjNnVHBFTE8zc2dzb2ww?=
 =?utf-8?B?K3h5UTM5bXFodDJxcnM5LzRFZ3lIb3RUZlpjN2FRUWdxaUZHWlNZN25RQkxZ?=
 =?utf-8?B?N0cvSHFKZGJGOHBWb3lmZ2dpOTZzNGd0TGVudElrZE5jbjJyYkFMd2x1cXlp?=
 =?utf-8?B?ZndIRS9sU3RPVUJ1d3ExVmFtYkc3b250MWF0dW14ZTc4V3BOak5Za3J4Vzd0?=
 =?utf-8?B?TWtsZlplVVBRRFBXOTE5WmxrS3lJWkQyQWlKZkpwWjdNM1ZMNTBOMzR6U3lH?=
 =?utf-8?B?dTlnTzljaHVndElQeVZIbjJ1YVFFUjJrSmJjMlJtYjAwTXFpSGNwdDBxNU5D?=
 =?utf-8?B?dW9VYlR1S3gzNEhFWVVGVVRrS3J5NnlEUzh6WGNiN1dLYnhVWmwwNm9Kaklk?=
 =?utf-8?B?OWZIZGU1L3g2WnlOVEtjYkR0MWt0VE9hYlJ1Z0hRa3V4cFNBVTY0ZE5rOG1v?=
 =?utf-8?B?TFljOXhGUzhRdHFHL0oydE1ZSHdMM1V6anVJenBOM1dTaXFvYTlqWU9pbEt5?=
 =?utf-8?B?dFBaLzUwYTR4bVMzWVZCVlRsNXJteGJTUEZJUHQvU2E1Sk8zSWp2NVMxVnJ1?=
 =?utf-8?B?MkUrT09PNUhjcDdBQVNjVjlKbTh2UlY0R21VKzZOS2g1TENkN3RVZGRGdWVm?=
 =?utf-8?B?WkQ3eXN5aU1mM0lKa3BidUhmRDRIdk9jM3lSc0NNa1hUbHRyZGt6Nk9DdzFt?=
 =?utf-8?B?MXhKN1RibkhCSi9xdkdkRzZqMHlEbFFmSm13ZWJKeld6QVN5c1RjRlJadnd1?=
 =?utf-8?B?eUkzeUlqamdLc0F1K0ZEWjk0OWFVVnY3cHVVUXcrbGFRQW9vbzcvUThzYUxw?=
 =?utf-8?B?TFU1enA2bzgyRDZMNEdPRzJqUzMyY2JpMVdhZ1ZSeC9ac2VEVWtnWFQydlMw?=
 =?utf-8?B?T3NRMXozcjB5VmdVVE5UQy90bkxOdlJ5ZjEyRnppWHFvdE02aGE1Wk1GUXJC?=
 =?utf-8?B?ZFpzYVZ6MTJPM2VpOTNQR1hxZElZT05iVmh1c1V1M1BJYStlNklUR1h2NExS?=
 =?utf-8?B?WFNOaXo0UzJwMW42ajg4bmRMQmw4QzA0Q1d0YlhDdWk3alFURTRYbFFEbEV0?=
 =?utf-8?B?WE15cUV4LzltTUM1RldXQVBuOU5iVzd3M1AzQkJUdndhSHJxbFRYVU1LRnoy?=
 =?utf-8?B?aExzSzhBTm1oSFpxSTBDRWVvSHdRQytjTXRBZDdoVDV0LzRISEE2NnlZd2s3?=
 =?utf-8?B?b1N0emluazh6SFJZa29jU3Q5ejlYem1OWHBzOXFFVUxIWlN0Tzk1cWV5cjZr?=
 =?utf-8?B?eWFLbGNFTXJNeWNsWkpDZ2oyZ0U3OWI0aTdvWkRmaFNtbXN5MnhPVEJxRnRY?=
 =?utf-8?B?YWZudVlNQm41Wkp0WXM3V3piMlozYWdrRFZKRmxKRWdNL2krK3NmaG00L1lD?=
 =?utf-8?B?MDZhSEVOYVJ1eHN2a3AvOHQ5VjVmNXQzV2xoT3J4M2o5ZHBza1NaUUFBSkp1?=
 =?utf-8?B?ZEF0eXFnTHZZOTgrd1lrNHBTNTZraXFkYjcwTUxUTTNyem5XamswSjlDQXBL?=
 =?utf-8?B?bHIvR2ZiYVhadi8zODE2OTFaUVZVdks5Wnd3R3BwaDdXNkpuOXpPdUpMS3k5?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e82a61-2c28-4be1-7f8f-08db985c5a0e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 22:11:01.9963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+6i9mkt/WN6NmXG6FRIuzS/vyAWy3MXn9hwHSZA1ulDFjTKobEZmoPEezbIL2zgNgklEOw0EWZxnIMGsrCh66Tu+RYNIVKRe+uC3WOnAbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8340
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/7/2023 2:48 AM, Petr Oros wrote:
> Petr Oros (2):
>   Revert "ice: Fix ice VF reset during iavf initialization"
>   ice: Fix NULL pointer deref during VF reset
> 
>  drivers/net/ethernet/intel/ice/ice_sriov.c    |  8 ++---
>  drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 34 +++++--------------
>  drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  1 -
>  drivers/net/ethernet/intel/ice/ice_virtchnl.c |  1 -
>  4 files changed, 12 insertions(+), 32 deletions(-)
> 


I reviewed the commit message for the reverted commit and I concur that
any sort of issue that it fixed with respect to concurrent resets is
better fixed by the 2nd commit of this series.

The motivation for the original commit appears to be to prevent a reset
from happening while the VF is still resetting. I think this motivation
is incorrect for a few reasons:

1) as described by the revert above, if the VF has not had iAVF load on
it yet (such as when its been assigned to the pass through PCI driver),
it will never initialize, and thus we can't ever reset the device.

2) It does not make sense for the PF to rely on or assume behavior of
the VF (i.e. that it will properly initialize) and I believe it should
be allowed to reset the device without regard to the state of the VF
driver. It is a bug in the VF driver if this causes problems for it. I
think we recently fixed several issues here in iAVF.

With that in mind, I think this series of fixes is good.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

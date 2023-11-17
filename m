Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2717EFC43
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 00:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346336AbjKQXvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 18:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKQXvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 18:51:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC1592;
        Fri, 17 Nov 2023 15:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700265075; x=1731801075;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x+f8iFqNzkmdCAzRlMsZgZ5ByswuoJK12bNvmCJxbTg=;
  b=Bh02h//SR+YUNLFt7V49MGK6bB+y0L8PlSC4/lNJF3bWuHpoBjAZnrZA
   AR079Av4T4657PEhhSZ+y980HxgZB/i3ipjWUdEzbjgj0l/K5ax1ownct
   jVL5/7ibFqSiPj0/TMIOVlaDv94uUmwQlkHt/G1bkOp8LboJdNiGjyhtU
   iIJvB8c5al748o5a1Hh3q/pTSCRuqKab6/GKNh4urBZzO1ncYRrxFcLo4
   WrnRE2g1t1T9LWPUsjGchS0n0d2mzYb8Bnu1864tK84j+kgEYSSeoracV
   mXrXapuCRwqaYyXCBr5E9cpgM5ZP7j1mFCn+io5pFaZaVFcfwH6n9lBvh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="4471677"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="4471677"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 15:51:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="715681134"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="715681134"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Nov 2023 15:51:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 15:51:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 17 Nov 2023 15:51:13 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 17 Nov 2023 15:51:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+F3jCoGENDZ6gtlEuUV4xYc6xuQmD+apf3METH7dZJfkcOWIskL4rwGmzxwo/HxmQFc6C/zgeVuLqxqQHBQXYred4b5QlcjSx8JHIqyJ4gX2xlu5sM5Uc0UI52/5Iy6DYfAf1MvJ8QONdo7FkJ+wbwL+EN3nytHiHyKm+h64BZmd33pZjgWK9XGL9lLrwPfUdOOJL7s70VnxsRzeeR8de17VcpULNJt6ASrmNRI8NCuoCU0tGNDQjv+wvIA0AvyrI4cpj4BRk2M0xuySUQPQwaI0g8gWuTu0yfojWVwp9IfUVR78ngDR4Su2q78jGi5k4Uj75A8NQwDqiPMHcGphw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jE2TT2nH2Qsaeq8IZ9k14b5iFgvOguPjzY4PiPNgXuE=;
 b=UChPjZR76XmBJy40KLBgY1etX/Kf2kbbsBevR8cvPhgz0McTZ0JU1sYrRKAzBfG9Gotet1KphbXD+/uGbUzQGjezR6ZTjA2xcYPdaIcCLsocEQDQXox+m3CCfhW4EdfP2OHtXrtK/hoa43Vwb+OMvLaCKIHicExXMNX9Mk4kqOFs0awTiXxztTssjfgYytF/UWtfhkIeBt9BokmRWVXYkng0JQs+iRv7wn047vxj6njQHvQNYrqsuPo0sogLLhditt4r7DLP4T14cQHi4DdlcMF0bi/aTGmFs6uzrX6E7Gn2nI/3Bjam2MeUGxKnZCw/ueFXy1imTbH7oeQaSRvKSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS7PR11MB7906.namprd11.prod.outlook.com (2603:10b6:8:ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25; Fri, 17 Nov
 2023 23:51:11 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.7002.022; Fri, 17 Nov 2023
 23:51:10 +0000
Message-ID: <03b2fde9-945c-4b28-9177-5e195c866c32@intel.com>
Date:   Fri, 17 Nov 2023 15:51:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: microchip: lan743x : bidirectional
 throughput improvement
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>,
        Vishvambar Panth S <vishvambarpanth.s@microchip.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kuba@kernel.org>, <bryan.whitehead@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>
References: <20231116054350.620420-1-vishvambarpanth.s@microchip.com>
 <20231117181602.GP164483@vergenet.net>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231117181602.GP164483@vergenet.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0346.namprd03.prod.outlook.com
 (2603:10b6:303:dc::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS7PR11MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f9ad91f-6dba-4773-6b2f-08dbe7c812f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bN5o1HUYEiH1OtV8INf8RfpXidE5MAtYxpOtiWu0mxpnTvFTLFEGs6WaC9htOeynj8XOyrySA9T34pbynMzj+DU+Uo3vrzCSNUS/oKCY1nGHNc4+kbJbhxWxsL4G31I6I7dbCpxoYfVtINIt6czK7hEQhi40j+xwY3J1XyxOXiCfWNzvIsBNxR9fWa2MPSTrpoyjPSm+uuhiNXqRMr44Q8kPn2Dh5huHy/ETfV8PjdxZDbVB23QoFSBDf49JX67yUop/uJojUn2af2t6kOt/m85BWrWa3rbq/N8h3Q3qNb6/s1hTPU84+XGBcXn1CYBdTQFd9P3H5T6jsEVz6aKgROUcm8SNOoOGgVBQwPM2GuEVrmchsa53X3UA9llKUfgxXbbNY2LlDJgKYB5+35XCRxk71bDrfZUhx3CewFwri4HBFUQ/8fQ3aACgZBD7ocgIdyfwoZKl9O1ElTAa05QmQif8QG8KZyc4a07LaDxoyAQESWOH3o0CByO1Hx/fgj1EP/lT+h9jI0hyCqYLaCYmswMyeIAd13JTYdNb+nWMkuVMAhYwdrMb6wUgw1SXeVMF746WMVeyKFjOvHpb2bUYxEYhF5XZ/BNOn/Ui3D0ak0n1C/QY89hMHLkiqokN+SPn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(230922051799003)(186009)(1800799011)(451199024)(64100799003)(66946007)(66476007)(66556008)(110136005)(31686004)(31696002)(86362001)(2906002)(8936002)(4326008)(8676002)(82960400001)(38100700002)(316002)(5660300002)(7416002)(6486002)(966005)(83380400001)(478600001)(26005)(41300700001)(6666004)(2616005)(6512007)(36756003)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnJaTmN6Nnk1eDVCKzJhQzlpZkduSzB6dk9GVmlYY3A1SU1kemY2VUhNekpB?=
 =?utf-8?B?Sm1qNnNGdUljQ1A3anBWM2ZmVFhUUURhKzNLaFZRLzFFNDh2cC9ZTHEyWmpS?=
 =?utf-8?B?NHM0a0Fvck8xNFRoc2ZZVEJvT29rTEFrcU9ZMzNibnRBMGh5T2d4enJNZ3ZI?=
 =?utf-8?B?VFZWeGFGTWdydVF4Y2FiaU5Pdm02U1BlV0s4Nnk3MW9YcmtrOFpyc1Z1RjF3?=
 =?utf-8?B?YWNEV3loeXdtUy81TC83Yjg2RzNrNGNjR3FrTFA0emR4SjRjazY5YW9NUkFP?=
 =?utf-8?B?akdOTUZGbDJBYW9IUi9uYldjZzc1NkFPZnRMb094aGpkelNXcTVKdXczdXo1?=
 =?utf-8?B?ZmNJMFpGcWlyOVNreldOc09TUktiaDI3dVdtU2VNak83cmRvbVRuSkp0QlI4?=
 =?utf-8?B?c242S0U1b1I1a1RZV1B2LzY2RWR6cm9XcDIrTExNQTdmUUFaeXFqSmJ0VzdW?=
 =?utf-8?B?ZkVZUFhoanNTWFhMOFNxaTJQZ2h6WnJQUVV5eU9iNGM1UThkdnBnc0t4eGpF?=
 =?utf-8?B?bDRPRTVxUnZ5Y0d0WHFzeXBiUmpiMlMrbFNNY1hVdTU1SFRDQXFpeHpHN2NG?=
 =?utf-8?B?a2JnTXBJS3JJVFpPWG1WNEs2RGtKS0k5LzBzU2lIZ1VCdFp1dUdpQVk3d3lT?=
 =?utf-8?B?blBZbUo2NWVpVFZGd24yYXFnUHdEMFU4SGZMT3ZiZTZSTVg0d1NNS3NRMk55?=
 =?utf-8?B?OUh5N1ErbTJpY1F1M2tyYjVUd1lVREloUlVWZTVCRUlUOWR4RXMvZ0FYQ1FX?=
 =?utf-8?B?cjhGNXQ1d2NhQncvalBzc3pzOERJcytVVExTUVpQUTRVY3lFWkJJYkMzd1N2?=
 =?utf-8?B?ZTBDQnhiakVwNENESFNJYVhtWGM4TnMyd05mNG1pOXNtamtHZytITjBKL01p?=
 =?utf-8?B?czdTV1N4U2F6ZWVMbCtDOThiOXBSQnNmNGtCa0RwclBOSFlJWlN2Mnh4UnRC?=
 =?utf-8?B?alhyQlJOaFQ1WmZTb3R2QmVUYmVjUDQ1Um9qZEM1ZWJaSEI0ZW94cHlRUDZa?=
 =?utf-8?B?SFRCT1hOcllDaWRpZTlFcHl0STNpTUZsT0xyVjdHRytWTEE3WjNNelQvSHhR?=
 =?utf-8?B?NFloZjNtNjQvQjh2YzBrQkRuQkp2cCtCZWFxdGVMMi9SMGtrZjc1K1hxOUtT?=
 =?utf-8?B?ZWhoM2EwSUtLR3Y5cEVPY213UEc5M1BRY1UyOEZVZVY2Q2pxOWhZNlUwYlhK?=
 =?utf-8?B?WU1RSWVTR1VMNUZTWmd1SHhscWlsMytQVlByUXBMcGRrVStqZU1kWi9kU3BP?=
 =?utf-8?B?eUtLVDJpMWhVRDF3T3JKUWVibjFUREIwcEdxUmRBUFU1T2cvbHFBaVBrdG9O?=
 =?utf-8?B?cUd2enZuSlJsZFRKVkJKSDhYYmI2TlRYaDhQSHhRdVN5ZWxlYkVIVjYxMXBF?=
 =?utf-8?B?VTIzbnN4VDUvRlRnUXJqU0pkNmtTTHBIUXFtMXRzOTVQUmlkY01BSEpWVWFW?=
 =?utf-8?B?dU5BRjVsZkFSZFNwK3RLVTBzdGxVa2J1ZWpycFl2WW5zN1hIMC9JdGNLVG9k?=
 =?utf-8?B?YUNlSm9hR2RLWkFlT3psaUQ1ZXNNb3hFWVJTQnI2U0Y3YWw0VlJjWldqb1pw?=
 =?utf-8?B?NU92MG5JdWhCL3c1SWZ4R1ViOE9qWGd6THRxUVF6WjVvNGhCOWFGUkVXcGhq?=
 =?utf-8?B?cmREcWFTZVFCS3I3SW5kQ1FMeTkzdVVCL0N4OWpaRkd3QWtOcm5IdytuR3Ur?=
 =?utf-8?B?akI0MmNCTHVSVXFUcEFwY3hNUnBLMjM0T0Z4MHdnTGZiVnU1RDJDUGFsMlc0?=
 =?utf-8?B?R3FPM05ySVkvZU0zeXpXTXo0Nk12dm8yNUEvbklMV1l1dzF3aXFvczRPaDdj?=
 =?utf-8?B?Q0ZtbVRuODFIaXlZNG56NEZodS9EUXZaQ0RKdW5KNmNqbkVZdVNGbGRmZVlP?=
 =?utf-8?B?YnJ4bEFDL09SaDc2eHBRVGdvMzJEZzhTN2RRYmhPYSs0S0NJMXNla0tkNmFM?=
 =?utf-8?B?THVWVUIrN21kdTNiUUpraWg4bFQ5OXB2NDd0YTBYYWtBWGc5Y2grM2R5T25k?=
 =?utf-8?B?TFE2RFhhRFp3VVg0SjNMeWhxaXVxeWZxcFpXQnJsMzRVbWFMWm5TUTR6cXJz?=
 =?utf-8?B?eU45RndrOEdka0RHUElzNS9aelR2ejIwdlhyTmtEdmcza2VFVlV5aUxZazVn?=
 =?utf-8?B?WVN6RmhtdGxSQ2g3UUNKSEIxazk4WGZDUDRjZXV5Rzl3SWJlNWJieWkrOWNl?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9ad91f-6dba-4773-6b2f-08dbe7c812f3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 23:51:10.1513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0fRJNzCRsyQzJ7K/n9Hlvlwm+fjmgItCQSdQ02QUzMSQuOnjrplLJ3TPmxFpErwzdG+gec+Unq0wzMJBOLRqxRIPfuLzDAAeL17DPCEXrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7906
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/2023 10:16 AM, Simon Horman wrote:
> On Thu, Nov 16, 2023 at 11:13:50AM +0530, Vishvambar Panth S wrote:
>> The LAN743x/PCI11xxx DMA descriptors are always 4 dwords long, but the
>> device supports placing the descriptors in memory back to back or
>> reserving space in between them using its DMA_DESCRIPTOR_SPACE (DSPACE)
>> configurable hardware setting. Currently DSPACE is unnecessarily set to
>> match the host's L1 cache line size, resulting in space reserved in
>> between descriptors in most platforms and causing a suboptimal behavior
>> (single PCIe Mem transaction per descriptor). By changing the setting
>> to DSPACE=16 many descriptors can be packed in a single PCIe Mem
>> transaction resulting in a massive performance improvement in
>> bidirectional tests without any negative effects.
>> Tested and verified improvements on x64 PC and several ARM platforms
>> (typical data below)
>>
>> Test setup 1: x64 PC with LAN7430 ---> x64 PC
>>
>> iperf3 UDP bidirectional with DSPACE set to L1 CACHE Size:
>> - - - - - - - - - - - - - - - - - - - - - - - - -
>> [ ID][Role] Interval           Transfer     Bitrate
>> [  5][TX-C]   0.00-10.00  sec   170 MBytes   143 Mbits/sec  sender
>> [  5][TX-C]   0.00-10.04  sec   169 MBytes   141 Mbits/sec  receiver
>> [  7][RX-C]   0.00-10.00  sec  1.02 GBytes   876 Mbits/sec  sender
>> [  7][RX-C]   0.00-10.04  sec  1.02 GBytes   870 Mbits/sec  receiver
>>
>> iperf3 UDP bidirectional with DSPACE set to 16 Bytes
>> - - - - - - - - - - - - - - - - - - - - - - - - -
>> [ ID][Role] Interval           Transfer     Bitrate
>> [  5][TX-C]   0.00-10.00  sec  1.11 GBytes   956 Mbits/sec  sender
>> [  5][TX-C]   0.00-10.04  sec  1.11 GBytes   951 Mbits/sec  receiver
>> [  7][RX-C]   0.00-10.00  sec  1.10 GBytes   948 Mbits/sec  sender
>> [  7][RX-C]   0.00-10.04  sec  1.10 GBytes   942 Mbits/sec  receiver
>>
>> Test setup 2 : RK3399 with LAN7430 ---> x64 PC
>>
>> RK3399 Spec:
>> The SOM-RK3399 is ARM module designed and developed by FriendlyElec.
>> Cores: 64-bit Dual Core Cortex-A72 + Quad Core Cortex-A53
>> Frequency: Cortex-A72(up to 2.0GHz), Cortex-A53(up to 1.5GHz)
>> PCIe: PCIe x4, compatible with PCIe 2.1, Dual operation mode
>>
>> iperf3 UDP bidirectional with DSPACE set to L1 CACHE Size:
>> - - - - - - - - - - - - - - - - - - - - - - - - -
>> [ ID][Role] Interval           Transfer     Bitrate
>> [  5][TX-C]   0.00-10.00  sec   534 MBytes   448 Mbits/sec  sender
>> [  5][TX-C]   0.00-10.05  sec   534 MBytes   446 Mbits/sec  receiver
>> [  7][RX-C]   0.00-10.00  sec  1.12 GBytes   961 Mbits/sec  sender
>> [  7][RX-C]   0.00-10.05  sec  1.11 GBytes   946 Mbits/sec  receiver
>>
>> iperf3 UDP bidirectional with DSPACE set to 16 Bytes
>> - - - - - - - - - - - - - - - - - - - - - - - - -
>> [ ID][Role] Interval           Transfer     Bitrate
>> [  5][TX-C]   0.00-10.00  sec   966 MBytes   810 Mbits/sec   sender
>> [  5][TX-C]   0.00-10.04  sec   965 MBytes   806 Mbits/sec   receiver
>> [  7][RX-C]   0.00-10.00  sec  1.11 GBytes   956 Mbits/sec   sender
>> [  7][RX-C]   0.00-10.04  sec  1.07 GBytes   919 Mbits/sec   receiver
>>
>> Signed-off-by: Vishvambar Panth S <vishvambarpanth.s@microchip.com>
> 
> Thanks,
> 
> I think you should have included Jacob's Reviewed-by tag from
> the previous posting of this patch [1].
> 
> And echoing his comments there, a very nice performance boost :)
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> [1] https://lore.kernel.org/netdev/e5ffec56-5512-1acc-b85c-ac0771634c22@intel.com/

For the record, this version also looks good to me!

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

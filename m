Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6367AE247
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbjIYXao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjIYXal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:30:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3396F116;
        Mon, 25 Sep 2023 16:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695684635; x=1727220635;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WEfKaoWjs1ASM8QFDiRSg7B1HTPDirkHj4Yyty9fVMM=;
  b=KMpw9hcgdkLnsgv6Wc1ajljH0djNYaYl24s5s+jml9scW09VDo4i9vGx
   PXLztbR2B0sTr7d2Aq1psUlfzMfL/KTfBulxPdKvErKiylRRPsKh4NKVr
   7uRhr7xbp5AA3el330X/EAl1CtMPi9cI5NWXKRNBbCwU5sF87fI/xfz/I
   fAot3ILUFiDoCRuXxhyafIGB4swpnrml6A0gCRsXoWGD52yax32bfXDu8
   G9YZu89Yq854YXNypAa0uB29GOUqllO62Ppw4x9I/ZXrZ+spYug/OcJOM
   IclcQ6MYNKzLYfTl1+Z1rIzFfzSO5ew3gQkZsoQJwgbLFkbZC4b37c2X3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="412354346"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="412354346"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 16:30:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="742125593"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="742125593"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 16:30:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 16:30:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 16:30:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 16:30:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 16:30:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJKGwf2L+pjPfGZPdyKAwvKnNP+OSOpCA25b4FW5rV+KDdWrWZB7jnYLBOkFSLllDSJH2epggVOeSZ2rV97zZb8UgKWsjq6PPMUfQS04akiTHpXLegQhRzlwFdXZPns0Q8x1CWybvpecNfQWHt870cIgDOj/mJRvQFd8baLmbIRx2N0FN5ttpqYjz+7sK2tS6H9qnGdt2yXIwPz3dVQM3wbM9B+b44Xw3NEd4VSaeBYhh2tlsmX+nW5laFvcrWLYnbIfQfGkuF8siduxM6RxupzAm4ijiDU9bFsSnpOuciGDNeg8fafU2gdVV6KgigLeQ8hJcbHJu8gikkLTnX1nGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naUp2dzruOoaOXMuNbDZi2KGVgVAYdxYJZzvwoG82O8=;
 b=lIPR7SLehhDjahNpAPml77LRoqqgEZlQMcjE2IIhGEthSh5Oq9qA6/NGrVxZvh8GOc+bgOjl08eYBTk5ah0Ff5+ca2au1G+RFU0oKWga4rcexIRwYaMcAjhbkF1G2j3DNHQzzPxVRokruCnvBRbfLjSVGXcd4C+soIklG2nZOkFPTrVFA2AVPIP01nc1qDPMgDZuOyQ75AbG3wfQfpJZhJUN/d7PNbUzgmpHYv9Ui8n1/grHOOj5y+0ZF6qPBeSGV1QrXTPIF1nruuLwwvb9ex3UETY0biZq3Fko+yKu9y4IU7MdhK0U6BTRMCXXCqw2IOkiUYKRA2xbb3HUOStLpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB7611.namprd11.prod.outlook.com (2603:10b6:806:304::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 23:30:25 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 23:30:25 +0000
Message-ID: <2da0c9a0-ebb4-f7fa-89f6-d32ce558fa00@intel.com>
Date:   Mon, 25 Sep 2023 16:30:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v5 7/8] x86/resctrl: Update documentation with Sub-NUMA
 cluster changes
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Shuah Khan" <skhan@linuxfoundation.org>, <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-8-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230829234426.64421-8-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: ebc69206-fa9d-49a9-4a92-08dbbe1f6522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3vsGYidXYXXyilfCMIARPeVDs19p6Bv1IeDU4j7rlvSJPkrtCDvN4zQJ6BspL8i1r4df/ej9zKskzaYKCJ8WYCRXeS/O5F8RZAAMHHLi9lUsu4Z3wTqt/pe6kh1O3WYQFNrrkbVUm7bjN7etAPe27mvAAcuk/R4brUvmVhAsyvdeMVWrlLcC5zsaNmctA0oMItzfLYH3RqKNNB191/9jUfaoCocPB1FnQx0LXTkb40JXYJgfhZnpi6jF1okHThEw/DREga104OkqsReWAgxg+0F5WLQLaQ/brWajFABpO2ss9I7WLj/Ta5x66NSOvS0W+wb3ohl8bOHzZ4KpfY35i7oPOLpyJrQKHMLvOTCuYgsyKH08Vi4s3VK/81fAUu83y3hTwCsWVmzPwzPpfucBJ9N7JnF+NS0vgSsrwadW//gRiWYBdeqhECiVafyYt5pLeeDrXLUURw9AsqrEw2rnVH/boLyrFwzUyGJA449+804srbPJhtYQbwW1+w6nVMdZZZm1JwqMO6hO9C1b6Gw1s88J6jAW6vgvd7PzYBZzgMViQ2nMqS2l986LCGwNHQfv631+GQT15dmX3uQdibgylDjfgmJHwWWZZF2fkXbB4T6aGDS+Xqh8uEgz/aCbjDI8gv8BSsbcsyZjJjfqt+UjRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(396003)(346002)(230922051799003)(186009)(451199024)(1800799009)(7416002)(8936002)(4326008)(5660300002)(44832011)(8676002)(31686004)(2906002)(316002)(41300700001)(66556008)(110136005)(54906003)(66946007)(66476007)(26005)(6666004)(53546011)(2616005)(6512007)(82960400001)(36756003)(31696002)(86362001)(478600001)(6486002)(6506007)(38100700002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0d1K1JodkVVK1hzdUdMS253cTIrVEN6M0prcyt1NzI0a3Y4ZnJiY2xPOXJm?=
 =?utf-8?B?TktVYXZic3JJTHhMSnBQMG9RQ05nSjFRNjZXdFRHREgxR0xqTWM4UjU0Vmdm?=
 =?utf-8?B?cW5EMTVaNzNIeUM2Z0VxTG5STjVQOFM3V24rS21ldzE0N2JCMjFhV0h0S0pv?=
 =?utf-8?B?QkhxS3plQ1pFNzRMWlN1ZDN6Sys0MjJQeTFRRjlsaW9RRjl3MXA1S3cxZUJl?=
 =?utf-8?B?ZGxnVTdkMDRmemJkRTQ1aHBvUXJmYWgyUVhyNkZTaXpNS3VjbXkwaXFLUmZB?=
 =?utf-8?B?QUdvR0dIcWlWaHNXdkdJaXY4N2VpVUd1VGNjTytGYy9MbHdwNVhSbW9xUnZw?=
 =?utf-8?B?M2dldDBCVHRES1pxcVl0YVROQ3RWVFBoRGVZcmJUOGhCMlFZbzA0NEJ2VExx?=
 =?utf-8?B?bncrVE5seEI5aUFSLzJtS2lXblcybE5LVEl5MWNIa2RGVEhTemdZTUppVDVq?=
 =?utf-8?B?N21PQWhxY3BKMEFJRlZ4QnJGdk1DZkgvRHNHZ2RWK3gydmRTbUV5THNrQlhu?=
 =?utf-8?B?OTFqSWRrdW5FSWNERk9PUzFya2NuTU50dCszYVB0R0hFajJZVk1RMTNOZFZ3?=
 =?utf-8?B?b1BuOFJqV1lla3JDSTdoUXYyRFlxaTQyRmNKbHVYWFJHTzBOVWRvR2Q1Y1pm?=
 =?utf-8?B?c2wzTmkwUjJ2TjlVem00VHNESjBCQjl0ejlRM0NMdU9oamVxYktMTVFhVEV4?=
 =?utf-8?B?QlYyZEV4WkdGYWF3bGd2b0lBWjBwSXgxNks5alZ6ZTZSNXBaYU9xenBnV1VU?=
 =?utf-8?B?UytydEliUGtYa3VwNG1uY012cytjbHB5NStDTlhnQksrcXd3Z3pmVEcrMGRD?=
 =?utf-8?B?R01UK1hvaXNxWTRwY3pieCtqWE1aNG9BeEVxWStUVEFqWW5CUjVmOTNPN3NO?=
 =?utf-8?B?RUl6M3h1QnBHMHNmNFBBY210NzNZL3RPeUtuc09sWXRiS3hyYkJvMnR4VXR3?=
 =?utf-8?B?SmJ4Q1RqUUE5NkpPdVBZdUVENDZtL1BLVW5BVDFyVEdlYWt1U2lCVnhkN000?=
 =?utf-8?B?Nk5HaXlYY21Ec2pseG9Uamp6bndNSElJcTlJU01id0ZFVGFjOGJVNHllRlBn?=
 =?utf-8?B?MVNUZXJIQzU4R1pPM29TZkl4MmQ0K3d6YlBSYWpoTFViMGRuWHhZREFMaVVR?=
 =?utf-8?B?UVFSVE1JL0o2ZlphQ29GVmpQdHBnejI4eFVQYW8zdDdibmR1UDRwaEV1Sjly?=
 =?utf-8?B?aTgvL1V1TlU0ODJzaHJENFdNdG1mQmRzMHRXaitFUzMzMXZyMjRwbG5oUkRW?=
 =?utf-8?B?eFdGRVdQNi9yK1FPTC82U3NVSW0vd1hnV0lVOHhIeUxCdGZ5VnJoRERXMFJv?=
 =?utf-8?B?aEhxNFhKaDFib0VWOEtNN0YvODRsajczcXBLVGZjdlBwT0ZkUEVlM1o2VFJD?=
 =?utf-8?B?RlVnd1I4YlExRlNOS3RDYnJrNlBZSUN0OVpEV2ZBNm5FMkZ0cHdWQlBQM1pi?=
 =?utf-8?B?dEhkczQ4SUgvNUQ4VnNCeFRZWDg3N3VmREl0TklvK3F1MmlEdTBzQXN1UnBB?=
 =?utf-8?B?T1hXYm1Gb1doODMrQnRIS1duUDVFakoyV0ZrSGVwMWRDajRjWDM0MDNUcFhz?=
 =?utf-8?B?MTkxYng0aXhLNk1LdVEzUW5XWTFsMk81cUxBSmNyUUVnMFhDaGJ4MDN1ZmZG?=
 =?utf-8?B?V3FzWDRybUhFS1dnMEY3UHlNWisrMmUyMGpMZlRHRmNXTWh1dUVjNUxQbWhz?=
 =?utf-8?B?WU56TTB5TC91ckVSNWdVRm42UVhyaUxGM2NuRCs2UVBMTldqUVZOa3doUVFS?=
 =?utf-8?B?SUg2MFRlZXVOZk9zV05MRDV6YlovdWc4L2Zoc2J2MGRuQzBXM2VzbVVKdnRn?=
 =?utf-8?B?QVlLcDROYXpQMWZDWUY4Qk5uZ2lEUW5aMVpJSFZtMGt0eWVRT0daTHI0ZUl2?=
 =?utf-8?B?eXB0UDR6YWYwL2FXZFN6T3grVU12NkdtYzM1UEFIVjV6MXc4U0RhMDVXSnlr?=
 =?utf-8?B?NjA4SXhad1U4WUxZWWJOTWplcmdmM0JnUHVtTEpVNUVnRkxpUzY1YWU4MURL?=
 =?utf-8?B?dVJmcWpIdGptZjJhR2NMS0xtR0dEWjM3MCtNOG93L3hMQWVDWUNoOFBXK1VZ?=
 =?utf-8?B?YVN0MGFqbEl4QUo5RTNxNW4vdjlGNnYvZHd3cStFOGNSdXMwczdDUjVVcWw1?=
 =?utf-8?B?KzRoZlVYVnB1NHJjYjJzaFA3aDFJV3hPb0VTYWpBOXk3MnFrd25DS25WVFVh?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc69206-fa9d-49a9-4a92-08dbbe1f6522
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 23:30:25.4137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57FlH8Gdt8T20nLIX0pJT2uMcf9i/7cKI+EnIDmChR0y3rdHJyoWdzlhGLU0aWlZNeJnm5NKpbntVE2BsO8xt95FGORDpGgD5slu3LTUBho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7611
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 8/29/2023 4:44 PM, Tony Luck wrote:
> With Sub-NUMA Cluster mode enabled the scope of monitoring resources is
> per-NODE instead of per-L3 cache. Suffixes of directories with "L3" in
> their name refer to Sub-NUMA nodes instead of L3 cache ids.
> 
> Users should be aware that SNC mode also affects the amount of L3 cache
> available for allocation within each SNC node.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  Documentation/arch/x86/resctrl.rst | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index cb05d90111b4..407764f43f25 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -345,9 +345,15 @@ When control is enabled all CTRL_MON groups will also contain:
>  When monitoring is enabled all MON groups will also contain:
>  
>  "mon_data":
> -	This contains a set of files organized by L3 domain and by
> -	RDT event. E.g. on a system with two L3 domains there will
> -	be subdirectories "mon_L3_00" and "mon_L3_01".	Each of these
> +	This contains a set of files organized by L3 domain or by NUMA
> +	node (depending on whether Sub-NUMA Cluster (SNC) mode is disabled
> +	or enabled respectively) and by RDT event. E.g. on a system with
> +	SNC mode disabled with two L3 domains there will be subdirectories
> +	"mon_L3_00" and "mon_L3_01". The numerical suffix refers to the
> +	L3 cache id.  With SNC enabled the directory names are the same,
> +	but the numerical suffix refers to the node id.
> +        Mappings from node ids to CPUs are available in the
> +        /sys/devices/system/node/node*/cpulist files. Each of these

Please be consistent with tabs vs spaces.

>  	directories have one file per event (e.g. "llc_occupancy",
>  	"mbm_total_bytes", and "mbm_local_bytes"). In a MON group these
>  	files provide a read out of the current value of the event for
> @@ -452,6 +458,19 @@ and 0xA are not.  On a system with a 20-bit mask each bit represents 5%
>  of the capacity of the cache. You could partition the cache into four
>  equal parts with masks: 0x1f, 0x3e0, 0x7c00, 0xf8000.
>  
> +Notes on Sub-NUMA Cluster mode
> +==============================
> +When SNC mode is enabled the "llc_occupancy", "mbm_total_bytes", and
> +"mbm_local_bytes" will only give accurate results for well behaved NUMA
> +applications. I.e. those that perform the majority of memory accesses
> +to memory on the local NUMA node to the CPU where the task is executing.
> +

Following our discussion of the cover letter I believe this will change to
be specific about what user space can expect and what is actually "accurate".

> +The cache allocation feature still provides the same number of
> +bits in a mask to control allocation into the L3 cache. But each
> +of those ways has its capacity reduced because the cache is divided
> +between the SNC nodes. The values reported in the resctrl
> +"size" files are adjusted accordingly.
> +
>  Memory bandwidth Allocation and monitoring
>  ==========================================
>  

Reinette

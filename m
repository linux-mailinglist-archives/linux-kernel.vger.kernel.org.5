Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2E57AE0A1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 23:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjIYVVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 17:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIYVVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 17:21:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2320103;
        Mon, 25 Sep 2023 14:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695676855; x=1727212855;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9w+IJoY9+9h7Vj3k1p3YXexB7WKnNQJzMY1aGOPc8+0=;
  b=QGJiGcBDPAPkJoMIzUwPWbZZpHE+fMBS6/7da0VLIe/+NeTL4yIe6FMn
   B5fTeGhlWvHD8+4C4SgzYVm1qnBLYPTHApxaF0mkxAjut4P2igLejc3mr
   U9tWOlNSYOZoh7dz6cQF0Msr4fbDxWeVVARfpG5tlxJ4mg1G98G77nhhF
   vM1TUzSepDQ07r4nQVWAyR+URCFf6t0dIJzPwoHPK3fQUxhWFb9uNREic
   PAeBdhOFnQ5c91SsiUcWebL4PFqrG5DDUVhlaCyvYm6k4sFiOB2vE6Y+7
   POqBHjyszI1N8Kq5Ckkl+C+4kIegNSrNhwfB7G1BIRxtJ/vAvbR2YhqjA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445518196"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="445518196"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 14:20:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="818784656"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="818784656"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 14:20:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 14:20:19 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 14:20:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 14:20:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 14:20:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tb2t3U/Ku9dXEAx+0k8psgoUtpyM9S8CVDbUt6nnswkyQ/7DvAxNqu8avWSE/UTXxOliWQpPgyAg/O7jGMsg6vD46PtWG6G+W8cXovYpCZO36IUq9AwTMAgwwQFKCgzxrMJM+wMRxQt65mRWsxg7ci1hgBoFXdf5PH5au/qOZl4Te51RWtpo9TsES/XAEnJABoijzstXhMT2jPjvivR+8gzuZic9LK6PMRYO84t4ZOpIuLyyKGdlxJ1nAf6uOvA85nMylfXoLUflRkA7rV6aXJRrUOnpSjJ36t0TtYqPSyKCpjd0+DzE7Inea4GXNgy1oDtpx0jVh9nikUbhRqECNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2qJlx0Fa3wWWgn71UUn64Jn7y9hQebc9tdjh3R4zdM=;
 b=i5/wpZRoWEOwFen0zId2W+s5cFdqJO3V1NZCCMcIbNyKv3xmZ99Czf/MErtw7fQg0HzNooVW9Gp8j3cjDSgNHi30s5fhteAGfuc4y9WhQlxixGC/M2l19Ep2p3jTSoSUMbE/ukvKp5OuIHwMy3jwwc7OSxp4z+7aMejhwB9SLkqyDYOhcg6sUIzt07vIgQNw+c8AcoXAjNfsiOl4mJ7LcQx3eIjXqQs8JdjG/QhndWiO8vtqAkiT6sFgRv0IRmTM8eeWDrb1pGDtfX4j0Jmm/28ZEBb1mqzkUS47R2Ccd24PITRLOFkHOa4rtKrDmxWCfeyjOTYw1wAk+8IPsJesgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CH0PR11MB8190.namprd11.prod.outlook.com (2603:10b6:610:188::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Mon, 25 Sep
 2023 21:20:13 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::cdca:c91f:da79:a1db]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::cdca:c91f:da79:a1db%3]) with mapi id 15.20.6792.024; Mon, 25 Sep 2023
 21:20:12 +0000
Message-ID: <2cea29c6-e29b-3b8a-b627-506aa327872e@intel.com>
Date:   Mon, 25 Sep 2023 14:20:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v10 09/10] x86/resctrl: Add support for the files for MON
 groups only
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <reinette.chatre@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <paulmck@kernel.org>, <akpm@linux-foundation.org>,
        <quic_neeraju@quicinc.com>, <rdunlap@infradead.org>,
        <damien.lemoal@opensource.wdc.com>, <songmuchun@bytedance.com>,
        <peterz@infradead.org>, <jpoimboe@kernel.org>,
        <pbonzini@redhat.com>, <chang.seok.bae@intel.com>,
        <pawan.kumar.gupta@linux.intel.com>, <jmattson@google.com>,
        <daniel.sneddon@linux.intel.com>, <sandipan.das@amd.com>,
        <tony.luck@intel.com>, <james.morse@arm.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bagasdotme@gmail.com>, <eranian@google.com>,
        <christophe.leroy@csgroup.eu>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>
References: <20230915224227.1336967-1-babu.moger@amd.com>
 <20230915224227.1336967-10-babu.moger@amd.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230915224227.1336967-10-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:a03:180::17) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|CH0PR11MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: 131877b9-a45d-4623-e867-08dbbe0d3477
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8imM31gaxVDFplERCod3fMTOtogJWSSmi0SxAHCIhuen5V2jEPp0uaYA4Zg8v2FIH6/ku84EDSNLVTNQLCqSxPvubzFcLTkZTp0QpmI1JEtBnxn5nixUoFeByt3KeGjQsmHR3nCiCEssGnfBKn4hAx5A8OsmGFri4cW3YnSTgo310aYZIRVzDcG0Ku8VPMaE3S3Jl6KCxmOZGoVQQAPdUN6aYozWThsUNwdLvjP4nZBWl1BYvKRcHL1wS/mYZA1f08TmBY4E3ONrd/HRlFmnQHXwWGskaOmaOcjQ7CYTgxki/miqRe7fXGiWsqM719K7wdA2R+esmnUF8w2DwbewJEBUsbdAYHyPwXoboBzFMbrjJrJi2uujQCe8dCSOr6OAnDk4vZXKuMdwCGdddMqbC/RWskg75SRCM8Sd09ns/r3WR9IZAQjBcGAW6eyKFC0/ryano5EjGr5enmGHoipfcNCF32l6sk7hF4+8DDabNR+wVVXwMIQ3J6KuXMVNwdYdUiORb5tQRJ9cVtLJMwGTntBxnuhoHrPhXmvJAguvCZ1cjDRx8rEdnLEe6MjY/PJa/lELTfuAi0IWtoB7Oi7Tr7FUdYTZL8GDpWQAYrD0GVBNH4pecLt3aPflpr7d7jHsUanHEP4y6xgxLIN2kCv6nA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(230922051799003)(186009)(451199024)(1800799009)(8676002)(8936002)(4326008)(44832011)(5660300002)(31686004)(7406005)(7416002)(41300700001)(316002)(66476007)(26005)(66556008)(53546011)(6512007)(66946007)(38100700002)(82960400001)(2616005)(6506007)(4744005)(31696002)(86362001)(6486002)(2906002)(478600001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU5vcVR3TTBDLzNCVFFlMndieVZKR2pkWStacFZxTUFNOWo3K0QxTnJWd05w?=
 =?utf-8?B?VjJnNWNTNXFVbVBKT2VBKzY1d25WTFo5a2JIVEV3MFpzRGpVaEdGR2ZWL0hM?=
 =?utf-8?B?Y0RVMldTc2UrbVlBOUsrRTVCLzE1cysyd2ZldmlCSmpISHowZnNrZVJLK2lp?=
 =?utf-8?B?NmlpaWY2UUdXZisvMmYzVkVSZCsrSzNmeFhpRmJvOVZRdm02azlrL0tuL3dy?=
 =?utf-8?B?UFlmdXBXTWkybEZaODZNNW5lZ2UyOVBsV1MxRk13RGlhbHZxYVU5WUJ1Z2U1?=
 =?utf-8?B?UzhrbkRVSjNnMEM5emVDQlRrMG1Gd1R4aEUrQTlQRjFkUnA3ZG5YZGxrWHdZ?=
 =?utf-8?B?OU9CQ3AzSk8wUlovemVCczBWMXZNd0I5cExabHE2ZEhmc3Y0YlVGQ2cxWW1r?=
 =?utf-8?B?anRmdnp2cVdtSDV3U0ZnbWtWRWNTUE9sUml1R3JFeU5XdU9kZW11R0pLcXdZ?=
 =?utf-8?B?eDFZallLRlVlUUtweWxMVjg5Uk5PQ3NWUitPbkhvNFdzTmdsejRmTFBIazZv?=
 =?utf-8?B?aVRHcVZzdVFyYzMrYjIrTU5CcjVBcXNxNTVybVMrRGVNZ3ZZdnloWWNwN2t1?=
 =?utf-8?B?ZWM4V0FTa3ZoK0oycGJ4NDdFbklHemlON0NFN2thRytuaW5GeVp3RHdIQUk5?=
 =?utf-8?B?MWc2Ry9ZVzNWam9DVW5UblVkRVhRd1VtUWZqeEVPYkpGRHdSdFR0ZnZlM2U0?=
 =?utf-8?B?a1lsVXluT1YxTWpQRU8rdnhOUEVlK2ZLMlFFcVpOWnJrckc5Y2JpUHNzcFlH?=
 =?utf-8?B?TElCaGFmaVh6TWVJN0t2MlY1Q0owTXVVNE1QbUlTTVlsRG9TeTNRTGJWUk9o?=
 =?utf-8?B?c0RaMXk0MUxoeXVpc2ZoMjUxelNneFpGNG1hcU5sRG9EZ1gxNWpQQjVhWHNP?=
 =?utf-8?B?ZjNGZlJyR0FLQzBmY0o3K2VXQ1FIZldxWHZiTE9BVTVOR3lXZzQxYk1wSGlD?=
 =?utf-8?B?aElRYUF0L3dCN1ZnZlhLRmg4SFR4cWYxc1NxUkxCSEVma0dxTW1EYUtmelBv?=
 =?utf-8?B?R1dFMkMwRnlKbVZ0SU9NZVJ2Q25yV2VlcmVQcTFXRWZtUHoyaEVIbmk3azVF?=
 =?utf-8?B?enBVVGVwdnJhc2ZxaCs2SW5QZFdpL0lDRXA4bnJvb1RwaE90M3hOUXhFSVhF?=
 =?utf-8?B?VEMvTFZXaDZqU3dZV2psQjZpaC8vbGVTQ3RoTTVrV2FGUHBTa1RrU0hVbkNh?=
 =?utf-8?B?OE82K0RvSHRaZE1qOGpTV2NrSmNPdVg1MStSR2pOem5kSjR4a1dTeGJuZWkw?=
 =?utf-8?B?dzJUOFI3QWVjK2FYVzBraGdDeCt5WGJOaXluaTUrNDdDaSsyY0NNazh3RUVR?=
 =?utf-8?B?WHQ0TVlXL0FFR1E0MGRVTWl0NHlsNnlqRnBhWUxTLzdDSVpNbkQxeVR3ZHNh?=
 =?utf-8?B?d3U2Q1BmQTBCSUVSTHBGU2g4Wmp2ejFhM1JFVmJGY2tjR21Kb25NdWlpY1A4?=
 =?utf-8?B?NjJ6Y0sxTWVSMm5hdUpTSmRPajJTbUptdzcxbjQxUDZPMmdkcjVTZzVwSzFl?=
 =?utf-8?B?YkYzUWRpTjBnMDBVSmdyMmtJeEJxWk9YV2h4em1KcnZpTEhBbzVuUEZ0dTdB?=
 =?utf-8?B?R3RZNTMxcnYrMzZzWjUyTnhPeDZVZC9WWWFHT2EwaUgxZXVMRyswVmdOdWxa?=
 =?utf-8?B?SXA1SjAvZ3NKdXVZWkJWZkgxc0hvaE9TdW40RzBZekxDWmxVa1UxZEpURTNs?=
 =?utf-8?B?aEVidTdlejFTR3MyeGpIUjFJMk0xYmJnWndHSUhtcGkyUC81WUd2MGF4TC91?=
 =?utf-8?B?UXlHc0ZRNXl1bEJFeXBVYVZxb04waENBYmJhdWRkWU80U3IvVTc4amhkMEZV?=
 =?utf-8?B?SHVQYWpOcERTTVpFTGJHbWZhWXp2WW15NlFxcFBlRmp4UCtnN3BGdnhleVVR?=
 =?utf-8?B?aTQrbkZzQjhyUmZEZEpFaFN2OWJkblJyRGFNRzR0RUIwMlg1elVSaFRoZHFD?=
 =?utf-8?B?MERmQTg5ZWRJa201VEt3dU95QWN1UkVtc0FGUmFhakZCMnFpMjJXL0t1ZTM4?=
 =?utf-8?B?MW45YzBqV0ZybkVxNzNuWHVFQUZ6OHJZeGZTOXJxR0pHZFF1bVc2SlhoUnlv?=
 =?utf-8?B?eksvSW1qWG1tOE1CUkRsd3R3N0FPcjNvNGpmMG12bld3ZlQ5blJ0bDR6bGhE?=
 =?utf-8?Q?qsbigWHBnqsyndsI5Y4foh+Qa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 131877b9-a45d-4623-e867-08dbbe0d3477
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 21:20:12.9312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZOgCk5+hPq7f5gizF9z3nKgBLO9N5UZjR8E+v8V8+qkBT0r4EICTXyqG/0nZF9gwYDBwg6SiCk4OJMrNHmQarw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8190
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/15/23 15:42, Babu Moger wrote:
> There are 3 types resctrl root files.
> 1. RFTYPE_BASE : Files common for both MON and CTRL groups
> 2. RFTYPE_BASE | RFTYPE_CTRL : Files only for CTRL groups
> 3. RFTYPE_BASE | RFTYPE_MON : Files only for MON groups
> 
> Files only for the MON groups are not supported now. Add the
> support to create these files.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua


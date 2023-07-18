Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF5975891E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 01:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjGRXp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 19:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGRXp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 19:45:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7889F1;
        Tue, 18 Jul 2023 16:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689723954; x=1721259954;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ptsoAW22ezd/TZy1m393Kk/VYy4l/Id8I5rXtWFk8No=;
  b=JKFXiR0dsT6d+Emkdr7Bok3gJuCq6gwYk6T2Dn5iJMdKy46OS11igyn1
   XtGbtrb4SdG28AWrSalB1LYKeaZM63eMkdu+AOv7cs44zinanEdF68VNY
   CcEtszcpFLnJlA57j00gBEgatNOXav8rKHCVYk8GpYUPzi6RqWPw7/wE4
   pEAJOarRZlIAM4TnEKe72SWEg8ghw138vlsEQEsdauR48/CDdnv7DpRci
   LvcBcTyLCUrAIGF+CZ9+nJ8swLwVh9mAec9XAziDXRuZBAqWxTACASQna
   uM0U+bLB+pBK6X/9ewppD3bdTU17V2BXIFzGxmw6FV5A3SV8+jbPytGxn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="346637856"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="346637856"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 16:45:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="727127002"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="727127002"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jul 2023 16:45:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 16:45:53 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 16:45:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 16:45:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 16:45:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlkVcKMG8GHWotuutkwJp95QNoQhgY26D1UJYa86hqTpgCyY1N8r77gRwup0IVKIpyt5PdWGp9imnAk1PDUFw4gqeVyyya1/oWQRb5fXSuzgteEvsemclJuG2oCgfL0N7vScw6awuRv2+/30r1ZlwT7HPRqRVWG2Ykk1tYEE0Ku5s1PhmV1Pt1qNK9VPIHz7AsgGHYLmUrZyfuWJB7MgKHyP+KRL0waniF/STbuOOJ3O8R3aFPeZf2Hdn2dY8ON758HfG8vTXe5SFaVCcQ84LTA3rFNHA9G2gnN25GLYG6oT1dXfFwyV9PZKf3fCOc52IqXthiRPq36sjzWAIszvrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyxv5261PGvjgdWi1O/pHoogYLH39EvZ9W+lmVHUQK0=;
 b=Wo2iYEKpOspJS8uGFU+Ma6WmxkQ7zSzwlXSFmrffdotZQdGhOqYZtmPGwthiRKwOep9Y9TdYUz7FDgGpjz8xuAp6f6JAHWgPsA4yoxDGt57EnWtnQsItRODl6dismB4aj6D5zvjqFlcleV5yRqhsPx/kNxc0PECb7AZ+KjJQ0Q4hfzE9d482T6CMPK1HEn2sxitMY+6nLpLutZGacHq7jbBWrIcfadBf7e3lBgTb1pJX26DHfhpWsiW5qJ+M1F3xGWVtNJYe4m3/+hgL5FJ+MRI1rbFerPFxI6hCvLSPD3nMyrLC3f8IGZqxH2NuMQlgSwWj5RNuJG9kAZej7GagPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7460.namprd11.prod.outlook.com (2603:10b6:8:142::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 23:45:50 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::116c:1030:6e1a:be28]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::116c:1030:6e1a:be28%5]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 23:45:50 +0000
Message-ID: <076a76c9-ab57-cae2-e6e4-99d26921b578@intel.com>
Date:   Tue, 18 Jul 2023 16:45:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/8] x86/resctrl: Add a new node-scoped resource to
 rdt_resources_all[]
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230713163207.219710-4-tony.luck@intel.com>
 <769521ee-6907-1613-442f-e2915a8ea554@intel.com>
 <ZLcY1MQr5/Ibnv7N@agluck-desk3>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZLcY1MQr5/Ibnv7N@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:303:b4::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: f0979587-07d3-406e-f3ec-08db87e91dc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oTvX82QAXM1WyZRiI17ESG+eC6nbECd5mh5f1d7rE/unw+RiwG+e8jOPkhdmXFoaAsz5rLVqNI1KpDetLjMP5oVdpQOtae5esWdLnfxc03Cm43PnYFFh4E2TbG3QDH8M9tVK7E83RIyo/OxZFVOyujKBCxA+lWGCS57FvB4a7TN8YN+8/jCWba1/fHY1RKKwDk3J0m9si7T9tV5drggqvTjwOvSGozTfAbZs3BuH1ncCOLfZgD55NP3Y0U72vL5mpCDXxrDWae7+pMV/BgqDNXjSzARrM7xNteoCrFqvxlkjXWmSqeeuaeuEeowG3ElSPt7Y/uVMERCMrE0ZoI3fF8kpDLdImq4ZkHCCETPh4sibghyZBXYqZIXEiy9m/jKTvIDymbLjEmGlWVNtwb5FWRKmbV7HJG3IQbnqVp6Sc1hbKIIBMoje/4O/lGUaDLb00q161PCkr87JpcWG0QdS3UB1rKtS6lAvYJ6CdRSXBO5PCHh+OvhCSvSXobR0G3/i5AD5e8QQbqETx7UZSj/eA0A0Be00HdySZc7W7eFz2DNE6VxPJG80zvNV0/BTvHcuYtFgGHgOPsLz67ruJOgs4vpom/8qoPvYFPuvmVlIsSZsEM2zkXxZWrPIJ7a1OYheAg8PDIecw8p/riDjrJT4Qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(8676002)(7416002)(44832011)(41300700001)(82960400001)(86362001)(5660300002)(8936002)(38100700002)(6862004)(4326008)(6636002)(316002)(83380400001)(2616005)(66476007)(66946007)(66556008)(31686004)(2906002)(36756003)(31696002)(53546011)(54906003)(37006003)(478600001)(6512007)(6486002)(6666004)(186003)(26005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2tkOG5rUS9VU29QbEpGMkNxWERFVmdIdU5UMEloY3E1Y2FSVFdjSXp3SmtT?=
 =?utf-8?B?d3NYdHlBbXA3WUxhYjFmRUNYUE1pZFBnNUM2TDdxZFNEMEJ0cXQwaUFxK0Zp?=
 =?utf-8?B?OTRhbFdobnJieUtCc0p4dWNTTVBMN28wY3JOQnRCZWdmRnE2ejMyc0R1b2JP?=
 =?utf-8?B?MDcrM3BLYjF5VnBoenU1cUpyVU9ITXBrYWpWejkybHFzSUxkQVlIeENWMzZu?=
 =?utf-8?B?Mkc2Myt1TGwvYjdsWUh3b3o2S21mbnp3cSs2L0VUTWNTRGsrcndIWk5ZOENy?=
 =?utf-8?B?UE9YWFlVc0VXOUxhRy9HSWlHOUtVRysvZnRONk1ZRGd5TUl3ZE13aXRUSVZX?=
 =?utf-8?B?amgwZ3J6a2RKa2lqMzNzeXNYeVhZblZXWnJCMFlHS1Y3NXZFdER5WlNhU0lF?=
 =?utf-8?B?clB0MVRtZ1RsZzZRMDZaTCtCSHBUbWNDM2djWURYTTV6K1ppMyszN2dYVEtC?=
 =?utf-8?B?b2lVVU95dXdnd3dkeWE2Y3hxVFd2a2h2QjZwVWFiTU5IcW1nVjNiVWdSbExD?=
 =?utf-8?B?UUlsL0dxZFVEeGdvVE5aTVFUcFhDVEFnQ0xOa3VlSjFqZGE5NDFwRjVIdlZv?=
 =?utf-8?B?VC9ZcSttV1NPT2s2ZnQ2QUpSb2E0UzRDeERiSTBYcWxnQWNPZGE2ZzZOd2NG?=
 =?utf-8?B?b0JuQTVrNTFxRkV6QzZreTlqdjExKys4clZCd0FMZ0VYcFplUkFDWWJTQzcv?=
 =?utf-8?B?QkRvdjBsU3Q0N3VCdzhGUVRWRzlxRjRiZXE1aUhmN2NyS1lvVWVFWDh6dEIy?=
 =?utf-8?B?VGoyR05FS09aZEt3M1BYSkhMV3g1MnVpSE9SYmhrSEtWYlAzNnM0T0hHUldU?=
 =?utf-8?B?VnpJcVgyNE9WU0NGQXY0V1hBbXNDTHQwSWJ3NFB1QVFrRUxlYjk5RTZRSU0y?=
 =?utf-8?B?TVowa0JUNHFNRk50RWtqbjB0Rmh5MHY4VlM3WFZ3N0p3RVd3WmZRUnVMYkhQ?=
 =?utf-8?B?WldmWGVDcUIvNlNUNWFQVXYzZElhdTU2d1M2a1pUZndtT0JKRndIREdNTWpW?=
 =?utf-8?B?eFkrK1hzTUV0VkNucDdqSnozNUtQM0pFQVRSQ2p4L3ZrQ296VUM0b1owbGFB?=
 =?utf-8?B?cGVVM05UV2VZNi85THhRTlc0aTFYRFFUVkg2TTJqQ3BLd1JUN2NQby84MGhY?=
 =?utf-8?B?aExiZjA5OWQvdDhHSXpLb1ZDUERXaDJsVFJpZERzNUpZZTJlOXhSK0N2dTNU?=
 =?utf-8?B?cDdpQVd1d0JXVWttV2Q4VFlPWHZwWUtBMFUvT08xdWVjbXgzamo3cFlxZXJP?=
 =?utf-8?B?R2NJZ0VkOWJiS2ZmNUpuUDBabUswS2hkUENHQXI5bUk3TnNIV2RteFJwdU9a?=
 =?utf-8?B?eU5RK015dGIyTERLL1haSEJ6MTMyWU82Y2NwRHdBLytuNEltZ3JnOWVYaGpW?=
 =?utf-8?B?eURIUFRhZEZWWmVzMisrWFRhTVdDSVVURUtvNWJZaWlHZSs2bXU1d1JTYS9x?=
 =?utf-8?B?dkU4SG5idWlVNUtaQWdIZzZncXRQQk5OYzZRVHkyWU4xZ0pmRlJzQ0E5V3JN?=
 =?utf-8?B?TTlkNHFHc2JwazFLQWxua0xBbS9KT0ZjOGdLL01CbFZlQTBYNTY2MEtvZlJj?=
 =?utf-8?B?NklyMXZFSEFBZnV6Tkd1QnA2MU1WQWhZeHVLVFdiQnEvVnVTdTFQdSt4RDFF?=
 =?utf-8?B?T3ExSmZFd3BpNVVTM3B0bzk2cVBxZEZ0MDdSQTVnYllsSEIyeC9zWFZRaExo?=
 =?utf-8?B?cWI5SjRGb2Vkc01sODdjWTkrWDBGWGRDR3h3SFg4Z0NZajJYTkpqVzUzT05m?=
 =?utf-8?B?ckM4OGd4Ynl0Sk1yR2Nrb01RTEtxTUp1M0FuZzNUUTNpYXpicDlCRkFzcmJX?=
 =?utf-8?B?ZFZqNjVENzU4SjZpck1xd2tKenBvVmV4NDlIOUNKSm9wdFpZOGhYaUNVMno4?=
 =?utf-8?B?a1dvU2ZuaWxGZFR2SE9sVC9xb3E0MkhiR3dRdzIvRkxkQUd1SFJET0pKY2cw?=
 =?utf-8?B?Y29ySy9sTTBNTDNqdytGWFAyUzBVMXN2NUlCZWdBOEw5VTk3YUZWZjVyQUJV?=
 =?utf-8?B?Ymp6UXJ3UHdORERVVDNXOEtMMVZmeWk0QW1oTUhnTjVoRlN5bkRkRlo4UTVG?=
 =?utf-8?B?ZStYWFpjZTROajQ3K0NQaHF4WDFtQy9SWWhrVkVIY0hzRHZ2QnFGK3hWU1hQ?=
 =?utf-8?B?UlBQU0drclp6byt3bjVzYmVUWm9DSjluWEFqRGhMUUFWcnh3OW9HQWEzMUdK?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0979587-07d3-406e-f3ec-08db87e91dc3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 23:45:50.2053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MuIA8etuLwzohzvDf/R9efhIjsgLqOXyi8YwOAq0ntX3j4ShLG/OBJkdUm2WtIxtVrP1Y50RJtiDndQXPO6N3/5vJNVTRxyGHCM2tVFcX/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7460
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 7/18/2023 3:57 PM, Tony Luck wrote:
> On Tue, Jul 18, 2023 at 01:40:32PM -0700, Reinette Chatre wrote:
>>> +	[RDT_RESOURCE_NODE] =
>>> +	{
>>> +		.r_resctrl = {
>>> +			.rid			= RDT_RESOURCE_NODE,
>>> +			.name			= "L3",
>>> +			.scope			= SCOPE_NODE,
>>> +			.domains		= domain_init(RDT_RESOURCE_NODE),
>>> +			.fflags			= 0,
>>> +		},
>>> +	},
>>>  };
>>
>> So the new resource has the same name, from user perspective,
>> as RDT_RESOURCE_L3. From this perspective it thus seems to be a
>> shadow of RDT_RESOURCE_L3 that is used as alternative for some properties
>> of the actual RDT_RESOURCE_L3? This is starting to look as though this
>> solution is wrenching itself into current architecture.
>>
>> >From what I can tell the monitoring in SNC environment needs a different
>> domain list because of the change in scope. What else is needed in the
>> resource that is different from the existing L3 resource? Could the
>> monitoring scope of a resource not instead be made distinct from its
>> allocation scope? By default monitoring and allocation scope will be
>> the same and thus use the same domain list but when SNC is enabled
>> then monitoring uses a different domain list.
> 
> Answering this part first, because my choice here affects a bunch
> of the code that also raised comments from you.

Indeed.

> 
> The crux of the issue is that when SNC mode is enabled the scope
> for L3 monitoring functions changes to "node" scope, while the
> scope of L3 control functions (CAT, CDP) remains at L3 cache scope.
> 
> My solution was to just create a new resource. But you have an
> interesing alternate solution. Add an extra domain list to the
> resource structure to allow creation of distinct domain lists
> for this case where the scope for control and monitor functions
> differs.
> 
> So change the resource structure like this:
> 
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 8334eeacfec5..01590aa59a67 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -168,10 +168,12 @@ struct rdt_resource {
>  	bool			alloc_capable;
>  	bool			mon_capable;
>  	int			num_rmid;
> -	int			cache_level;
> +	int			ctrl_scope;
> +	int			mon_scope;

I am not sure about getting rid of cache_level so fast.
I see regarding the current problem being solved that
ctrl_scope would have the same values as cache_level but
I find that adding this level of indirection while keeping
the comparison with cacheinfo->level to create a trap
for future mistakes.


>  	struct resctrl_cache	cache;
>  	struct resctrl_membw	membw;
> -	struct list_head	domains;
> +	struct list_head	ctrl_domains;
> +	struct list_head	mon_domains;
>  	char			*name;
>  	int			data_width;
>  	u32			default_ctrl;
> 
> and build/use separate domain lists for when this resource is
> being referenced for allocation/monitoring. E.g. domain_add_cpu()
> would check "r->alloc_capable" and add a cpu to the ctrl_domains
> list based on the ctrl_scope value. It would do the same with
> mon_capable / mon_domains / mon_scope.
> 
> If ctrl_scope == mon_scope, just build one list as you suggest above.

Yes, this is the idea. Thank you for considering it. Something else
to consider that may make this even cleaner/simpler would be to review
struct rdt_domain and struct rdt_hw_domain members for "monitor" vs "control"
usage. These structs could potentially be split further into separate
"control" and "monitor" variants. For example, "struct rdt_domain" split into
"struct rdt_ctrl_domain" and "struct rdt_mon_domain". If there is a clean
split then resctrl can always create two lists with the unnecessary duplication
eliminated when two domain lists are created. This would also
eliminate the need to scatter ctrl_scope == mon_scope checks throughout. 

> 
> Maybe there are more places that walk the list of control domains than
> walk the list of monitor domains. Need to audit this set:
> 
> $ git grep list_for_each.*domains -- arch/x86/kernel/cpu/resctrl
> arch/x86/kernel/cpu/resctrl/core.c:     list_for_each_entry(d, &r->domains, list) {
> arch/x86/kernel/cpu/resctrl/core.c:     list_for_each(l, &r->domains) {
> arch/x86/kernel/cpu/resctrl/ctrlmondata.c:      list_for_each_entry(d, &r->domains, list) {
> arch/x86/kernel/cpu/resctrl/ctrlmondata.c:      list_for_each_entry(d, &r->domains, list) {
> arch/x86/kernel/cpu/resctrl/ctrlmondata.c:      list_for_each_entry(dom, &r->domains, list) {
> arch/x86/kernel/cpu/resctrl/monitor.c:  list_for_each_entry(d, &r->domains, list) {
> arch/x86/kernel/cpu/resctrl/pseudo_lock.c:              list_for_each_entry(d_i, &r->domains, list) {
> arch/x86/kernel/cpu/resctrl/rdtgroup.c:         list_for_each_entry(dom, &r->domains, list)
> arch/x86/kernel/cpu/resctrl/rdtgroup.c: list_for_each_entry(dom, &r->domains, list) {
> arch/x86/kernel/cpu/resctrl/rdtgroup.c:         list_for_each_entry(d, &r->domains, list) {
> arch/x86/kernel/cpu/resctrl/rdtgroup.c:         list_for_each_entry(d, &r->domains, list) {
> arch/x86/kernel/cpu/resctrl/rdtgroup.c: list_for_each_entry(dom, &r->domains, list) {
> arch/x86/kernel/cpu/resctrl/rdtgroup.c: list_for_each_entry(d, &r->domains, list) {
> arch/x86/kernel/cpu/resctrl/rdtgroup.c: list_for_each_entry(d, &r_l->domains, list) {
> arch/x86/kernel/cpu/resctrl/rdtgroup.c: list_for_each_entry(d, &r->domains, list) {
> arch/x86/kernel/cpu/resctrl/rdtgroup.c:         list_for_each_entry(dom, &r->domains, list)
> arch/x86/kernel/cpu/resctrl/rdtgroup.c: list_for_each_entry(d, &r->domains, list) {
> arch/x86/kernel/cpu/resctrl/rdtgroup.c: list_for_each_entry(dom, &r->domains, list) {
> arch/x86/kernel/cpu/resctrl/rdtgroup.c: list_for_each_entry(d, &s->res->domains, list) {
> arch/x86/kernel/cpu/resctrl/rdtgroup.c: list_for_each_entry(d, &r->domains, list) {
> 
> Maybe "domains" can keep its name and make a "list_for_each_monitor_domain()" macro
> to pick the right list to walk?

It is not clear to me how "domains" can keep its name. If I understand
the macro would be useful if scope always needs to be considered. I wonder
if the list walkers may not mostly just walk the appropriate list directly
if resctrl always creates separate "control domain" and "monitor domain"
lists.

> I don't think this will reduce the amount of code change in a
> significant way. But it may be conceptually easier to follow
> what is going on.

Reducing the amount of code changed is not a goal to me. If I understand
correctly I think that adapting resctrl to support different monitor and
control scope could create a foundation into which SNC can slot in smoothly. 

Reinette



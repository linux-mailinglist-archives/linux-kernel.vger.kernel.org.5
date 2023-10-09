Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F4E7BE4C9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376771AbjJIPcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376791AbjJIPcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:32:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBCEB9;
        Mon,  9 Oct 2023 08:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696865533; x=1728401533;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ckXLtDDLaHk9wFWPI433PwaZ92FzMGSPxIE3pD0cSU4=;
  b=OcRgEhjIvRRaUfpC9kTiXDrHPrI0p4UCW+6NJR9znPjwVkFHg7s54irS
   BlnF/fuLMQKEkO28hgjbmfpK0ciS5DDNTD33xzvok8fJ5uVNUHTFUQxJJ
   9/6QVZhsWSAY8J/Zy6LcGG3zB/XamsVrZU5q5J7rEX/ddmVeIArG/NeNg
   nedM2yR4mvF3i2NxgkWA311oRR/2qyOylwejNYK578+GUIgpFYWrvzCT2
   /YBAQAKF/k/En3fyz0l8ihQ2xoIkrCgEZTA23SU0r4M+DMvCepV/PoW5/
   myQtz8HkTebygR1xT3AuZ+5vPvXxjzBRNWJhIZpgyG/KFokJi12Nw8UXN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="470434567"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="470434567"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 08:32:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="896803652"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="896803652"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 08:30:33 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 08:32:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 08:32:12 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 08:32:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0lurTqhLSMWBMPsFTTVW5bNYUov5mhJjkuQJdop6AnzfGMn/V9pv8nkpU/6Frap5M1ckSk5cH6LTD9nvit4hpcMKij/uUrPzJAt62zP0DSJrH9Uoul/gzMGEwYTn9HxXAzEhnOTafi2HYddAf2Df5Q2Qrg4E+qHiNGAfe3clI44OvHs25ZpA50wysczJLcMPjNjNyEVLaEOw2aVJJe7WO8/GtmMoaheWJNWmdP6fMHoPLJJL2ht91q6jfq6ylUhyIxYvv/btZHRBo/fJoPgdiCqnmfFQHwciLc3BP0IKQ6lq3rfwVJb2wIUXJqPjH4FZGmO+l6Fa2pC6Q+gSJJ3kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMBRe3mHLJu+JG3mlnYfJmmMlYyyln3zsUtyN2a70P0=;
 b=UUkbLaEELZ+9yyZb7BWGdZbGnjEgonFK//jtN/I/CMAxABC0CAMCbIEwrW498ntWRkW2n2ErdJmgJE/xeJgFOn2O0/VwzsV60M1TBnOHp+U23GHVLUR/YQNNSkUrTeovWdzGpXjYYKBREXsxKumycXlkZNR9IkunpDcY4TNdY+raxzR845yIgYClaz8VDohZTpoVK6GVLon4elMPvFUJ5lRCqa5ERAEddrIqOX2oDWAs/XIGXZFmnzTrWKPxtOU1XOOs+nv522Nj/8FGI7pxFuFp/graDjiY4fYVs+yVVek9dTAvajnqQNPwM4eA1X6ySoqZb69eMJuUlyxO55bPuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB8320.namprd11.prod.outlook.com (2603:10b6:806:37c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 15:32:10 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 15:32:09 +0000
Message-ID: <0587b6f5-51d7-4d5a-9114-6c836b12f6f9@intel.com>
Date:   Mon, 9 Oct 2023 08:32:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] x86/resctrl: Non-contiguous bitmasks in Intel CAT
To:     Borislav Petkov <bp@alien8.de>
CC:     Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        <fenghua.yu@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <corbet@lwn.net>, <x86@kernel.org>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <ilpo.jarvinen@linux.intel.com>
References: <cover.1696493034.git.maciej.wieczor-retman@intel.com>
 <533ccc1b-7566-444e-8549-184fd272f666@intel.com>
 <20231009124033.GBZSP0wcAT494wHWqG@fat_crate.local>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231009124033.GBZSP0wcAT494wHWqG@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0282.namprd04.prod.outlook.com
 (2603:10b6:303:89::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: 19a42a08-f7f4-4efc-5ce2-08dbc8dce6fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pisYnb+R8pKSddxM29Vg8Iyh/o3d4tPKtOiwv21fVgEVoqgsgkEtuD/Gk0dePArmwTfwN3qdUFgfkErlW43Uv5M4cYCbT4QuSQhBhxJCIdjHH9McGnzMzThk8VU7egAXUjFEy5FQZkcKTGreJffGBPyDgEVxk/C6/yejSw3eiy6dqziPeEw0BcXy9qlLetJtwNa+WjRBU8gbhIPPQn1bvemdwsomcQbi+2IkT3MwhJmwNT7sK+4LFWNRZIBPcVjUBSmyv+EnWlZFvfLmTYZOQ+XAlM7t5u108j60BUamKNO1LCIgaOhJkfB8UN4rbEGctN0OInPiIvLbuB3GjcAIKgJsfBwVNcpQzv7srokPlK3cz9eNq1G/qt2zLBm89ZvC+Kb89jsce2kEHgaUDvGwyUcXD+o53ejVowvXMhNJ2QID+gJ2ZDrpPfpEvJlW8pF7LmaraIVAgCL87Fmr1DvRDsbeuUyADhjeZircXLJatIP0+NSc/vOLsZCLIovgfVoJobE7Tur1I1Ki23lsOgUoClfS/KZ3uxkf+JDtKtLLdZ7tJm15c014E8qz7UGX8pylM1GKBr+a0jdu19aJXGRUiTMenT4Uw5k//qJBgzueMPB12DxzVcLyQdzO9CZoAQVSdGxTF489GFCJVKNZcp2K4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(366004)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(6512007)(6506007)(53546011)(2616005)(26005)(316002)(66476007)(7416002)(66946007)(6916009)(66556008)(8676002)(8936002)(4326008)(5660300002)(41300700001)(44832011)(966005)(478600001)(6486002)(36756003)(38100700002)(82960400001)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXJJSzNFMlJRejNaRHpxeUhqSUtyNXR3MnplVmV6Y2FDdGIyTWQwVkl4dXVV?=
 =?utf-8?B?UnQyWHVrenpNNU1xaEdlamtJcEFnRjRXTXBqK3A3em9LaGdKOUtzUmptS2Fh?=
 =?utf-8?B?OTVoZFcveGtadWg0bXFkTXozSC81dTNQaENXMEdOUTM2eEJvUnhRcm55WHAw?=
 =?utf-8?B?Zjg1R2FLeHdjMkF2TGhKNktCYm1lRUFIbHU3ZVd0aEFSTU1UdkhpRVBBeURi?=
 =?utf-8?B?NzZFTC9nZkZ6QzZmVjBqR3lDb1d2K2RrR2ZoVVhmbFVVQVNzaDVka1E3eVVL?=
 =?utf-8?B?K2xGcngzVlpNTGRyeVF4MUtiTkIwcDJ6L3AvVnZra3FGYkh2QjUwNCtLMy83?=
 =?utf-8?B?Z3JZVTJSSVBLYTZnWVFmcUVaWHVqRzZKeWNtdXVNaDBtaitmcFRGT09GNkdK?=
 =?utf-8?B?WTd6MWkwb3BkeWczRTJqSDFJd1F1UUtHMmRCMjJUQXlVbHE5WUovVWJwRkVO?=
 =?utf-8?B?dERONXFHQzhucW5IZHBEcnRsc0t1R2RheXRwVXppckxrRTQwNUVpeXpOT2c5?=
 =?utf-8?B?Z055SCtLVmllUGw1am5Na3NzMy9EYWx4dzN1MC91L1FIb1ZFV2hES2pyT1R5?=
 =?utf-8?B?OVU5N050OG5HMmV3eHEwdy9YaXdUMUJRQzhHWmY1cTNpR2NXdXJPRDRkTlI2?=
 =?utf-8?B?ekcvR3lJQ3RjNGcybEtqNWhJdmtDUmM5SWRNcUplWEtETy80aE8vYnNidHNr?=
 =?utf-8?B?WERxNk5ueXdkSkFzUWhnQ0J5QldpZFpGUEdnZ2xtQkNUaFA4d3NoVUpDY254?=
 =?utf-8?B?ZE1KeXN3NVl1WmY5VlBXZUpGRVlqWUJRUjQySDROYUd5Qmx1WHZ1UXE2VG5E?=
 =?utf-8?B?eVFoazYvaTlaM3ZNT2dpVEtVOW1IRE1WWGVqdS9vRmlFRWZqZzhsTzVFcGl2?=
 =?utf-8?B?RDhjSmMxc3FuMnFCaDgwN2FlSm9KdldpeGptSTA4cjB1UEFJRmdGMUtsT1U3?=
 =?utf-8?B?ZWs0dVFrbWxwd3QyaHNMTUVEa3FpQWxqSTVtbVRuQXZMMktFbWpwZ0NhS0lU?=
 =?utf-8?B?TG9CcjNackpJTGc4a1BhSWxKZit3SUZWVElxZE9IZkxaa1BySWMzYjhDaG5a?=
 =?utf-8?B?cHpBVnArVnF3WWVsQlEzSHlHTVc5NEhjQm5qS2UzMWdWT1RMdGtOV21TeU1I?=
 =?utf-8?B?VTJUdVRlZTZ4SUVuS082OXBBOCs3QXJPb1FrTUszSHFSLy9zWS90V0EraEdh?=
 =?utf-8?B?ZGNGMm5YYXdYbnJINjdjT29nN0FFY3ZzWmlWbnVTQit3Sk8wbS9MM2JtU3Vy?=
 =?utf-8?B?aGhyL1dhdUVyVjlMVzdKL3cvVyt3d1ExTnIrTk5YdHdjZlIzMTZlSmxVYlF3?=
 =?utf-8?B?OHhUMjdJVm5PM203bWJJaG42VmRITEU5UXFWYmE3djhyWlBzaWlVSzRXdkJl?=
 =?utf-8?B?VDJXYTFLaHM3VXFiY0pZWTEzeEY2UEExVHJwVm1SNFp4Q0U5T0RFMSsxbXBj?=
 =?utf-8?B?QzE1Z1FLelV0UmNJRXpwNCtCNm9EMXJVWThmSWlnM0YrdlJ2Q1pZVFhxUWxD?=
 =?utf-8?B?c0dJZ1N2bGZlWjIvYXNPQVFXb2VoUkFxTk1rL3lDMzRZSDVnTlJ6c3UyV0tT?=
 =?utf-8?B?NW9HQlZBYXQzeWdzS3Bqc3ljZU1xV3U0emtDM1V1ZzNTNm5TRW1XOFk2LzNC?=
 =?utf-8?B?L2lLUzNmRjlSMS9mR3VhT05FYTgwczJYMm1GUFpuNFBlUjdTcnkvaE13b2k1?=
 =?utf-8?B?b0dCdFFFNzJyUGpIamxveWRJZWVSa1ZEVkh4VGFidHozMGFkOG5Db1B0aUdN?=
 =?utf-8?B?OXpVWHIxb29hTEd4cVpJbHNsVG5kbnFiVWlyLzhZSUkzOUNPc3R5bGI2NGFH?=
 =?utf-8?B?WlZjWm91a1pueDRlMXhENUt2NXBjakZWR0oza0piRVBXbm9BR1BHSld3VHJW?=
 =?utf-8?B?M1VMb1E3NkZ4cFhUZk4yRHFBWHBZK3R0SSsrdXREa056V2RBZjA5d3Z4SVJm?=
 =?utf-8?B?blFFVGRHZHFEVUVXK28vakdjWi9mSGh2bzk3a1Bxa2p2UURuS2h3V0I5dWZO?=
 =?utf-8?B?S1JYaUE2K05SNDQ5VGdrT3VFODlobTVzdjNLWGdKUkNYc1VIelNGZ2FoZ09l?=
 =?utf-8?B?WWFWS2VBajFVb2V5NGZxbnd4dkFrVktPbFdwSVZTWHA0SkpuSFpDMFYxS2d0?=
 =?utf-8?B?Rk1QVnk3LzZZWCtOeFBvdXk5cmdVUkU3alQ0UzdlMHFIdEdQL2duK3UvYk9v?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a42a08-f7f4-4efc-5ce2-08dbc8dce6fc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 15:32:09.8351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqDckXj/VwqYIPz1kPoAg34dmf8m6h9N9872FGCxMlY6zxba/9W8oEf47XSG3qyJ+r8uqHA7qpRJ9YtwKFNkk+rmPa54o3OtZsiIzRvKnJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8320
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 10/9/2023 5:40 AM, Borislav Petkov wrote:
> On Fri, Oct 06, 2023 at 10:53:52AM -0700, Reinette Chatre wrote:
>> This work conflicts with Babu's series [1] that is also ready for inclusion.
>> We could wait for outcome of next level review to determine who will need
> 
> Who is "next level review"?

This is just a term I made up for when a series is deemed ready to be 
considered for inclusion by x86 maintainer team.

>> to rebase. It may help to provide a snippet of the conflict resolution
>> in anticipation of Babu's series being merged first (I will propose exactly
>> the same to Babu for the scenario of this work merged first).
> 
> Just lemme know which ones I should merge first and the others can be
> rebased on top.

I believe that Babu's series is ready for inclusion and can be merged first.
It is at:
https://lore.kernel.org/lkml/20231003235430.1231238-1-babu.moger@amd.com/

Maciej is already planning to send a new version of this series and can
rebase on top of Babu's work at that time.

Thank you very much.

Reinette

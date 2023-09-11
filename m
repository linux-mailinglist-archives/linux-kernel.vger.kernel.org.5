Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F297F79B07D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347726AbjIKVZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244404AbjIKUXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:23:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452D6185;
        Mon, 11 Sep 2023 13:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694463823; x=1725999823;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NrKKsKAel8nQKma+NMb6SDBmDVzXhS3gaVtyeLjS6TM=;
  b=fbGE+M2OiPjJAE0+TUB2BD/01mY2FVtiHu8RZTlWVXxn8+3GrU9PJd62
   r9qzMrYlmWzjx0lWu7PQDLyEiMc+jJJsfKs8/qzMbau/zrNHEWN78y4rZ
   d3Cj3t8mmMoPwl4qEYfC6/LiV0tl0jHhLj8sUCfRxQBcB6ddfe/HfgZ/a
   zkxtT5FlQfasJEfQL0eXwJPumbs4e+VZK2xbEOuTyvLjasuBhmAmSLuk9
   ea9ZlbGiknGlaWS+oA2O9wPkD3yDeiMaqOV3J4cBl3dIBuI8Xyt6tbT4a
   r1HmPtMgJerx3utYQhotlKf5RMUPIBXpEGfepVXPfGZE2wSstu4puDCEz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="363227745"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="363227745"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 13:23:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="813524054"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="813524054"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 13:23:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 13:23:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 13:23:41 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 13:23:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIv8bIa9gDNMOg1Pnz1cjgUFAnTO7hAniJcNxnAsjd+FIu+zXjrAkKb4oOvcgmU4toOoSQNwYUfcNOTgehO3yvhyVGHCa+C6DcdhEJ+CNoKntIfkKrr/ggba5ZH1g/QyqJJzeBpN6jGh1JQ7AjpxJnI5uUSv5OQf+TD4eDGR/1GkVuCBHOXy5FiKagyZfU0+9rVHq1WCAKnWWkl4Iq/6kCNYzDL97/VOldnHhRFnmSV4pqPD0XxlmcHidGD5PsS/uPSBNFb3N5hn1yp1cqupgtGke/Aw/gaoaJ5BZKD+esynQnFobMU5T7VMaJHIX6ZbUWzGvBH1YUCNe09iIjHN4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gersAJnpX8ys9HTYtv7B12SO+ZR+t4k9muz8rKGXlAQ=;
 b=GzPHlR2E9Lw9Vcy9+wSgHWjFv99dbu5DsmJuDgOMURhda0qAFumfZLdm2xgFPAXwNk9qI4rkiCZizTSy2GnzvQAQPFdB2o1GqnUmpWrMWfsvEferfr3qCWqjW5s7kAIX7HtYr15DuQkzKFyHT0yqBUzrLf7JsGS2Oyyse8/rUnZbZYLa69ZBhbXZrYX/uDpZXMxMVrh6TRcrFQvQmlGeTPL6bIZCGrjD6cP+sc06WXqYsR8R4V57QBzoLear4NloICG2Rdu3HQMOya668LRiSKExMftOMCsmrpBWciInnko/Tj95W+3j3zWjF+f6rF3J/48Ly6AL08QxmvSPpDCBfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB7741.namprd11.prod.outlook.com (2603:10b6:208:400::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Mon, 11 Sep
 2023 20:23:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 20:23:39 +0000
Message-ID: <45e81506-3c43-95ba-56a4-38e1bb2e42dc@intel.com>
Date:   Mon, 11 Sep 2023 13:23:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH v5 0/8] Add support for Sub-NUMA cluster (SNC) systems
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230829234426.64421-1-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0246.namprd04.prod.outlook.com
 (2603:10b6:303:88::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fdb37cf-df47-4107-8833-08dbb304fba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +POVTIiPs98hihKMu79Fd+H6pS/o3mZ6cyEJfrNIjzASs5enTu7wCIlvRpn910Q8h5F/4M+/+UCwAirLRt1VZzAIBXzET7kc+V5Wyl1OHWLK49f1g8mDj9eJ7Z1g2cObR3R6X0uNwabKQXFiNYcn91iVQCwhQih6VVdTcObWVjHd50e/IW24oasKTjF3GG/QaJSJRHWuydw2/wGDsd8U2NHIpzUXPyS6k9Lvml9PneqnoUxCdCYvm8pBfusFUtXgfcLnnSE3qP0iu/o36yKIc8QM7QhgaOKUnOjfmHsw4fhO80ft1rOHmHXnZGJib7Zq6PmMO0BZThFpSIe0P1n0yY7yNYoConoTOyk+Y82tNDrHZiF2eYpIhVz9aTDo0WdGGHU5trFEyALoiQeDi0ag1JtbCSUms2OVE7pdesWRGvgyXmDlR+s9ZwznuKsOUPmIaHj0lKdbnT+ag1F8J4tVm9Etb1UxzOlqvmggWTDaMGLHxpFcrZRFv16xVnZTw/KkUlnE1uqphlc6qqcwpYkPxrzBAGELrMfpgb4zzbhHiuNrPFre5BdhNVt2PGQkVyRDNHpT/1V97JRms+8R20X2zgH1B8Di8NlWT//gPyEsDCoeyepMJkenE/4RRcErRlwx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(346002)(366004)(186009)(451199024)(1800799009)(41300700001)(2906002)(7416002)(316002)(26005)(31686004)(66556008)(44832011)(478600001)(66476007)(8936002)(66946007)(8676002)(4326008)(54906003)(966005)(110136005)(5660300002)(6666004)(53546011)(6486002)(6506007)(6512007)(36756003)(2616005)(83380400001)(38100700002)(82960400001)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzBKUzBET3k1WHJ4b2x5V2ZQcDc2VGdWNUVZaCtUTysya2Y0eXZTU1dKd0Nv?=
 =?utf-8?B?dWpEdTY1OGl5MitCM0dBck5qUWl1bDFkQVM5SEZvbzVka1Q3WWgwU0xLbVRv?=
 =?utf-8?B?bFJFaDNjSXh2VTZNTWh3T2hyUTdEbTRUc1paTS9jT3FsdW1mT0Zvd3N3enFG?=
 =?utf-8?B?cXJvY2JRUjdWakNTVEpmLzVIOVJNVHU2TC9PUEk4YUZscXRyRHl4YUwzRGlM?=
 =?utf-8?B?Wkgzdk1kNDF1ZU1UNEg1RENuSzB3NUttbENuMXhRQmZ4MzdsSE8ra2pBY0p2?=
 =?utf-8?B?VmRyMXNHYTNkRnVqVzBYODVhY1l6VG1BQjg2VHhLNlprZlhRcCtlUWJ5Y1I3?=
 =?utf-8?B?TkxoZEorcHhQT3RsNVVFZ3EzRjVtWmFVV0dEeTF2Z1B4NXdVUUtPUitCT3NT?=
 =?utf-8?B?ek12S1Z5Uit2ZXp2ekFVaVJuV1ZubjRIYUcyZ2xHZGRleFZRa0dWaFVsNVp5?=
 =?utf-8?B?N3NxTkZ6Mkp6WFJEWnhqc1NEV0liaEhqdUJoNytjUUFNV3p6b2xiME14MGVW?=
 =?utf-8?B?RVpNd001SEVEQk4rK0puU2FiUFJZazVrWCtXTmUwZmwwR2EvdURyK0JOQzc1?=
 =?utf-8?B?V1VmRlFVQ2h5M3RsZXVPRjVVQmQzdllqWFl0cWIwVTNWRDNmcXMwcmFYRytZ?=
 =?utf-8?B?Y1RVTkt4SjhNQUsyNWZKYXo4SjkxSmt0OEN2by9WZjRKL3Izd1NLQmppMkVq?=
 =?utf-8?B?VmVWUHY3WlpCU2R6M2RsYkQ4NUxQTFNTdzVSN0RUcWNxbHVDMlptdWZXb1Va?=
 =?utf-8?B?c0phdURhSk96cDR2ZzFmMFZ1UFRmVXp2VFdwS2Uzd2NrOGJlRnlBa0RmN1Zw?=
 =?utf-8?B?U1dsNWg0clUxamNiQ3dHMW42Z0RwMzdqeTZRbUVFQU84amwyZ2tRV3YwL0hY?=
 =?utf-8?B?TWFmV3UzUkxPUW5zalpzdCtmSW5BMjJ3d3ltdW4yeVpXZnVtWHIraTZsVU80?=
 =?utf-8?B?a1pEbGZEMEkrdmxPTFpLY1ltYzd0S3hZUFYyeHpPZUxhQzlHTjYwRXphVDg4?=
 =?utf-8?B?WnU1dTBMNDl3TTlQZTQ4VllwR3YwOWNJbWkya25WdDVWcXREUk1rOGNGVWdY?=
 =?utf-8?B?RXQ1bFZ3eDdMTENhZWtQYzUyNlErM1JQSU84V0lsdldmWjRvQzhiTjE3VW9C?=
 =?utf-8?B?SzBZODNhWUErRWgxTnEwZUsyYXhLWXJCd05uQ3I3aG5WM0I4RUNLbldEYTgw?=
 =?utf-8?B?aWFDcm1tUVU5V2pxTWEwMzc1YUQ3RmZnQmxZVngxUy9SVmZweEdNYUZaQ3Bk?=
 =?utf-8?B?ZndDRHVxNFhQNGEvRjROK0k2UENjVWF6ZHE1M040cW1BbGhjYWQ1TTBSa1B2?=
 =?utf-8?B?SUIrUEsyK2RsRitGUENMTDRLdU5CL0hnQVlPNWtqN09mTDBvYlpuQ3pjdVVS?=
 =?utf-8?B?bEtTMVhXZUtLOW5rM1ZyUnZrRjJWdWc2YWlXYW5yYUhiRGxyQTNlSHc2anls?=
 =?utf-8?B?SXdPUjN5MHl5OVdIeHkzZDJIS3ZRWlYzRTBlZTk3aHppcUVZNjZXSUcyZU9D?=
 =?utf-8?B?MmxIMDhHTll5NlJJL1owSWdpZSs5d1NoM3NkOVZUKzVxakx0ZnNoNWNDUHh5?=
 =?utf-8?B?bmh2eTFQL3c2NmxHazI3Y25XdVZ5bDB3VmxRc2thVU53L3BDVlVCMkhkVFBO?=
 =?utf-8?B?OWtCRTNRM3dvSFJ2YWxYRFp4U01FSThoOHREdDdubUVqUE5NcmVMNCtKcjA4?=
 =?utf-8?B?OElvRUd0U0ptRHlYYSswdHIvcTNvZXR0dVRpOEtpRi9HWjNsbGVXYjFQcWdQ?=
 =?utf-8?B?MDZzUE1CUVE0MmdOQTJqWURVYlRUUDVad2Q2bitVOXR1RlB0STA0Ui9DSHIx?=
 =?utf-8?B?TUtCOHJGUGY3Ryt1cE9zZ25yOFFZRXlMTUtQTW5EZ09YeTNJKzJYM1BBS3Vy?=
 =?utf-8?B?d1U2aU50NlpVamxBQ1d0NjZPRFJmNjFhYTdJSFJaMEFzdTBJZGF4ZGpiZ1pl?=
 =?utf-8?B?MGxVeDJNbHY2dGFIYXBGNWVSay9saXJNblR0MHhLQmdNbFJ5eFN2QXBnWitp?=
 =?utf-8?B?RjB6WXordnByKys3YlRaV01mWE5Hd3kwTGhqM0QyS0U4NUFIOXQvSGxoaUZN?=
 =?utf-8?B?aVJRcVZoV25Geitid09kL284eTArQTB2cGl2T2JUaXZLS2ZXa1FOU2N5c3g5?=
 =?utf-8?B?Y0sxcUNtVEVxYllyakhqc1RkQ0hRSmJUSVAyQmJtSkhXTzM1WDBUQ1NOOHBX?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fdb37cf-df47-4107-8833-08dbb304fba6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 20:23:38.7427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n//k53E4u8+uRlCqRmGlbLlCrpEd1+z4t2duhU/jSHGzLwSheOX/A2sXBQawDzichGBck6+2lsda4bR+RKyq4SbpiR/kfk9DskyvgqW4CwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7741
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 8/29/2023 4:44 PM, Tony Luck wrote:
> The Sub-NUMA cluster feature on some Intel processors partitions
> the CPUs that share an L3 cache into two or more sets. This plays
> havoc with the Resource Director Technology (RDT) monitoring features.
> Prior to this patch Intel has advised that SNC and RDT are incompatible.
> 
> Some of these CPU support an MSR that can partition the RMID
> counters in the same way. This allows for monitoring features
> to be used (with the caveat that memory accesses between different
> SNC NUMA nodes may still not be counted accuratlely.

Same typo as in V4.

> 
> Note that this patch series improves resctrl reporting considerably
> on systems with SNC enabled, but there will still be some anomalies
> for processes accessing memory from other sub-NUMA nodes.

I have the same question as with V4 that was not answered in that email
thread nor in this new version.
https://lore.kernel.org/lkml/e350514e-76ed-14ea-3e74-c0852658182f@intel.com/

I stop my review of this series here.

Reinette

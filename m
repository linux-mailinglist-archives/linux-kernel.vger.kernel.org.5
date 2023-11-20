Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163817F202E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjKTWY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjKTWYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:24:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0F7C7;
        Mon, 20 Nov 2023 14:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700519061; x=1732055061;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JOgqkv9q8xQw6y/RtUkdDRXFlOSLarAkukt80m6YNdo=;
  b=evWOvFKjRbCgiN4E54ZsHwzOE4DzKEwHinwWaiMuy5cL/xjIBcAyqWP7
   dY9iZWkJram4xp52So0myR4vYBtKYu3xIGgWmdymw4il364OQ/bO4Gv54
   UAuE4jGRzqbo4f8hOWamhq3d9Ue+MbM2BVTBAc+85xCZP1EFGHVeL20qU
   b9fIu9fDUZGW+F3F8sG1QZ0Kc0kV92k+wDjKbYGtXPnvo1Txxjjcgw9Tv
   /GN3au3awJgWadWyYGtlSAsPvie9qn4ZMu9KnbBYi3lPjehl0CHTK3nXa
   XmvIvggm1TA6Q/PtzO5DGFDEUHy4Hq8KVT2+Q2C3l4t7Zh0Qib7m+1hyG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="395646133"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="395646133"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 14:24:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="716351995"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="716351995"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 14:24:20 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 14:24:20 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 14:24:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 14:24:19 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 14:24:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oe7jrpp+cmK5lf7ZRdSwtpLBwPW9s8uiwui+7Y4ZacIJktgEiWyykWsZMrM0E3sqQkRbTRDY9xPDhUnHNGAEGPYpOHfxEjAE1jOBSUwnAOzpOxAEQfmTdCaw5G9nr3wfC5cbA2PZj5FpNfxruCfEqU/2AirxemIYGrFFhCLFrxgAjcT5mK6dvZwFxLTpf1U35CqzUQ0hkQjMP9BFsb7Cxai+wekRZx3l807kcCmj65XWGrVIS0xxthPrym+zI4zk4ZOi4hOnErYxyB/orMXq/UazevvZRlarV1KUW2meTAgjuN0QtMRNLiT2t5SLZWEoGvlu/C7Nq4nL8VW84d+1Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhA0kwtd5IkHogucvS2F6PWeNTaP0Hn9PAqqf2OZqRM=;
 b=WTTuh+OdksYr/w1MHPZ+IeI/6OrluM1SbAefDVKacBraRrc6elAoACuzgiC4nBJiNu5RXTeQKkvIeKr0f91GupsfZqmiNxQSoPmzJn0lbZQHGm5+5n/hh74U8YAbTcNPkpg1NvDfKa9A7jWg2bd8PcAH8tkvmB3iuZgx2mQMLzUD9UCPEE52djuFXPVq2M9bA9K+efObDqTTO34EOtxYQSAMsow2ZKN/3Ekn796ZhonsWYRW756dQVx9bochl8eNc6U7YY+I3gEfJOCAekUujSvYGhcUUZvhNCfVEyRzgki0iBo2UE8iiqlZgxSfh9dvaYFiwn6REsdGK6P0tHv1zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6031.namprd11.prod.outlook.com (2603:10b6:510:1d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 22:24:17 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7002.019; Mon, 20 Nov 2023
 22:24:16 +0000
Message-ID: <c6982c26-738b-43fc-a2d6-35fa7cf2c70c@intel.com>
Date:   Mon, 20 Nov 2023 14:24:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 7/8] x86/resctrl: Sub NUMA Cluster detection and
 enable
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
References: <20231031211708.37390-1-tony.luck@intel.com>
 <20231109230915.73600-1-tony.luck@intel.com>
 <20231109230915.73600-8-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231109230915.73600-8-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0001.namprd16.prod.outlook.com (2603:10b6:907::14)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 96bd34ae-042c-4262-8f23-08dbea176ebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zewlxtXy1fAlojIHNSjRgcGaRpuLs4+N4x6gCxjIdh/xOHHEa19IQEaOIk+eqkSqkwvdziEegpepIKbyZnnuKjN61bsF0z1s9923qltUFiOqtjBJxil2slMKDnpsGb4QjoFUz/7gMe+BJ/7ID2PE1jfxFQuBZ3xFKJz4FzAb52hr4qu/BJgAOj7sBOMxjBolF1VRsafnxpTTBBbrF15JdKlyAB241xsry1+Frna14+KY+3DjPB2WtlrzKi2o56uQ6gk1mpXMxO6jDR54Y1Ij5pAr8nHsJR4T85114LGJkTj+ZFLbPUaFb1y2SuSrc3g9LZtR4TbCCZahyUtXIcHkfbOx3ILx3HZmC4zL7OHNv9ctqWPsLDKgn8LyXnCR20hMkcg2Xc5hdhrq9sCut96B8BOvk3AJgWSMUxzH/P42p4EWpUW+dG/MtyOseqpd+8ntJrAjUnlARkKcqoX8xF/3+8aspP+ug9LgIYEYpB+PJCmLNY+tuZ1min1/wKhadyG35F0c+KrS+62pA7TgjB9lWksH23VPQP1rvrLZvjlDPSuEJHQO3/PkaUlgNInhqC9aOS3TTM8JYxNHsBlDugKVvbKZsEubwPS3DK8bxtywD96U5q771YfWBvsxKJHPO4tEirz4DhBf2yhX+bCYXlWocQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(39860400002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(31686004)(6486002)(66476007)(66946007)(54906003)(66556008)(2906002)(41300700001)(82960400001)(8936002)(8676002)(36756003)(31696002)(86362001)(5660300002)(7416002)(44832011)(4326008)(4744005)(53546011)(6512007)(478600001)(316002)(6506007)(38100700002)(26005)(110136005)(83380400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmNsZkprWnBNdDlBUjYzamRQcHhhZFhrNHRvMTBpb1pnVUV4VTB4cFlMK2tX?=
 =?utf-8?B?OEw4RHEvS0RIR3BEYlYrZEhXVlZ2SFN6dUNUM2tiTFJyUkp0ZFkveVp0ZWhn?=
 =?utf-8?B?eG04ZzQ1MjM1S0MwOHBGTEQ0K0ZYZEN4SEs3M3BOSWFtMDl1Tjh6RGlBVW8v?=
 =?utf-8?B?TXZCR1pNKzFBMm8wa0Y3M0FwTkJDWlhEYVo4d2haWDZGK2hGdEs4bGZlT2xI?=
 =?utf-8?B?YWhkZHZFNUtXeEEwNnd4SWJjUzYreTR4TGNyZGhsbmJsbEducG5UaG1JWmUv?=
 =?utf-8?B?NDlJWWthNjdtcnlMdTYzS1cxTWVDdHRndDlUYjQ4TmluZzRuejdrUUVSczF6?=
 =?utf-8?B?b1daSFY1TkFGZWI5WVJhZWhCWC85MXpqWHpadldQcTlaSk1kMFpRMWd0T2p0?=
 =?utf-8?B?WGZ6Y1lZUTRCYmtNQUxDZjNMeUlWZmY2bTAybi9nNzR1S0lqKzFIVXlzcHFh?=
 =?utf-8?B?b3dnNlRhR1MyR2JrZ0lUZU5pZ0o0QnVEbXFaUldjWDAvVTRVbDZXSnhzdG9D?=
 =?utf-8?B?emttemswdkloUXNvYy9Zd25hNy9ZWkFrdU9GL0ozdVdBQ09PMklHZzVUcG9W?=
 =?utf-8?B?V3RCb09oekJLRGV6RTArTkJxL0ZYeURWWkhWTmxlaGI5TVZHLy9SQ0dsb2xh?=
 =?utf-8?B?TW1LTERpTUJVMUNPRUZPLzZDU05YYVIyQXZ0bE9xbGw0NDZWdGxKY3lJQlpa?=
 =?utf-8?B?V1RZSWVaNmp2cFpucDc4TktpcUJ5UGlzL3FGOHhObGNOdDd1S1Z4Sk9LVkFk?=
 =?utf-8?B?d1BEUTRmVG9lblZlOHpueWwraFZLRDJhNEpTNVdaK0pEM1Y2UnNuc0VHeGxS?=
 =?utf-8?B?M1g0TWJwRnkyY3hkOVFEQzVNU3V4dDB1bFlnVURzZDRqSGVVYVY5dUQ2eW4r?=
 =?utf-8?B?MENJMWQzaEV2VEsyNzZOOGtHMXdlWWlnN0U0T1BCQVBjM0dHeVkvU2ZiMWk5?=
 =?utf-8?B?ZjlqYTBaUmxrUWFuOVQ3N04wZ3BQYWZHMnVxaDk5TXZWejNZNXdKQWR6UDh5?=
 =?utf-8?B?NWlWaVBTR2RwdGt6NXpEUkx2cUI5RGhJOFVSaFc3dHNqTXFwWFFtbWJZb1Z2?=
 =?utf-8?B?U2R3R216WkFLaDJEWmRxN00zN0tUSE9XTGFxNzB0SCtPeUVQekdTZDIrNlYx?=
 =?utf-8?B?aWdxNzE1L1B2UjNxMzU4aXRRalFvL0dSUFRxVHh3QVBCNENTM3M2SHRVRVFl?=
 =?utf-8?B?Z2xyY3JLN1Nzc3NpOXQ0cHRJeiszYXREdXZoMldhMmV1dGZaVVdaVG5TNE9E?=
 =?utf-8?B?VTR1SXhYVVZNNkJLUGIzY2ZXNkNrK1EwbUUyN1VKZldTdzkxQzNYNG1wWFNI?=
 =?utf-8?B?L3hldTVFb0NCSzFBdFA3dy9JRkxMUFhhbkpnOUVzZmRSaS9vWFEvbXFhMlk2?=
 =?utf-8?B?SFAxRHhoZjdIYkIvMVNsQXRXRjNIeFJjZ1dOMlhLa2l1ZEFkR0ZpNnhlaDhO?=
 =?utf-8?B?a0x3ejlHR0QzOTZHQ2EvSXdrUlBLd25RWGNrRElmVzRhSW5NWDRtNVYxMFB4?=
 =?utf-8?B?dHp2bk45Vm14OEFudU5HbUZ4QTZTa2NJZUdoTWs2QmY1c3J0dEs0VVpHOGQ5?=
 =?utf-8?B?RXo2dzlRZ1hDZ0ZaNzdjcG9BMWE3NnJrdG41WVNKRVA3UEZ6dkV5TFVYeFo0?=
 =?utf-8?B?emNSaXA1QytTOVJaazd5Yjl3VHNzSTloMmJ2cFZJZ2NkNVRVQ0tkUGFEVEhY?=
 =?utf-8?B?YUxmczhrVUc0OCtmWkt6QlVSTStzb25qMmlSUVRyZzJqNXpVRCthaEl0dDdU?=
 =?utf-8?B?UzZVNURGQWtxcUtuWWw2dVFINU8yMFo4c3Q4SGp4RnJobU9WZEJMaTJ3OTZ3?=
 =?utf-8?B?WTVoemdtdWFKc2F5MEVQYnp2blhta1htK2tacnF1ZEQwanJYenBtTHRIemda?=
 =?utf-8?B?REU4bHE4YUhJMS9pM1VVUTR0SFVIc0pIZkR0MDY1OEttSlU2TDNkMVFuMm5T?=
 =?utf-8?B?ODlKVnYwaktiREVUMHliTmZjZEN0SlZBTmg0Tngwc2owNmUrQXpmdUphckQx?=
 =?utf-8?B?dEpUVzl5S2QvTmRQMUNVdWhKWE9YOHpQUlFCOWJTK01EbG1rNEY3STdOU2xS?=
 =?utf-8?B?RzFFTWZLUHBNU0FzdnZxTmovMGF4ZWUxOUxtZnBkL0gwbUFvaTd5T3piZUcx?=
 =?utf-8?B?enB6VVIwek9IelozM1h1VXY4YWJxWVU2c2xZZFZSR0U0VHdBSUsvcG5zYm5t?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96bd34ae-042c-4262-8f23-08dbea176ebf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 22:24:16.7641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vA0vEVhNg2z+KYo7o9hs2mCKV+iBJFyAtZp8MnvvNhWDqj0Lyex8pqBSQGeuvz4adCdqQonp2eEZ4WSYdhU9HUW5nldrQ7SomRSZgG68AnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6031
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 11/9/2023 3:09 PM, Tony Luck wrote:
> There isn't a simple hardware bit that indicates whether a CPU is
> running in Sub NUMA Cluster (SNC) mode. Infer the state by comparing
> the ratio of NUMA nodes to L3 cache instances.
> 
> When SNC mode is detected, reconfigure the RMID counters by updating
> the MSR_RMID_SNC_CONFIG MSR on each socket as CPUs are seen.
> 
> Clearing bit zero of the MSR divides the RMIDs and renumbers the ones
> on the second SNC node to start from zero.
> 
> Reviewed-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---

(note ordering of commit tags)

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

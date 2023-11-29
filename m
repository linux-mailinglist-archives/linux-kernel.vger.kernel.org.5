Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013BA7FD8C8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjK2N6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbjK2NlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:41:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4757ECA;
        Wed, 29 Nov 2023 05:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701265281; x=1732801281;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O7wGOaZRZSbQQ/d5aveDQ1Pjyy/ixDtVQRLMOQuPs4o=;
  b=LCciSEJ1NkB1FSAQM/16rTVTMvnV5ewzwFwVeUdITmq2O1Rni3Td/eeA
   FJ5KmJ0+1sftd6ssvAJPrZipFJLywf4VutDVC2UOA8W+Va7dSeay2+MdQ
   m2hja4a8aLXoiU/Q9dWqWlqzwhLwBafr9TQCE1NUm5zFbHr2/sov3hd9Q
   5304MBu4Gy8tt03rIcfjLutYTquav6jFE8LJ2DR9SgIQCbo+VXsR7Gtik
   yba58DMcDxitZ/Cj75ZaN4diSBh8oW5NmefxhsGcWLLpsAmoYaHf+tn/9
   cnoMIIUGJdbEuGFriLZclMO31zm90pe0RJy8J5/EZB3X8lbW2CNGdvRLK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="378193692"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="378193692"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 05:41:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="768923469"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="768923469"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Nov 2023 05:41:20 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 05:41:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 05:41:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 29 Nov 2023 05:41:19 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 29 Nov 2023 05:41:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkd4BEdtAOj0CYSYMYQfQPzwSH1Q6Rhlt8dAKvSdDPMDLFD1RUVVWE/q3ADQqajmW7Lks5sBedR3eVWS0QA57sx0SOfadTYgV90pF6ZFjb2sdDq0h5pddyczOzufkxUZUtQUSU5+6Av6epMwXPmeK+yD65EpUSMhO4hQPnUNnxXLJZk0k/cvKUu9eI6OMUTUVMb6NlbqonQtuDRnEbrjkeQKXW4mJh947GYmb95c87pR2dZsC3FbTljDeZsAPs5v0A4FGPHzFRvs2ScsULFoL91zGVJ1BINxGIhiyPkqvLWYdhhd/YQCsqWLT9cQXc/MIfuHMqpQQkv/EHn/1KMnlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7wGOaZRZSbQQ/d5aveDQ1Pjyy/ixDtVQRLMOQuPs4o=;
 b=IoOxlXBd9FfM+IHHb5H3+P6RHNhsiVnPeXdKfCxB0Gsill5Pogarv4dzDBNAd9GtF2PbpLd/09mxK8DdAGVy5F88Sq/z5zZz9aET04ltqr0h07URNNuGIy7GFbnrADgTCzBWOilrdWKNYt98Mjh+GQ3kw8Fw2VYMQX3iFWsOYKwNtla7TccMSdXpmizucPgG5YdX/ALUR0nDI5Gh5ItUtpgpRab9AKRc4RRI8nrSY9fOqXAjMN6D+yF9D9AOUmRsCDCypMn7PMdgli0UowhahojTf6EU1HUtrmaRAhDhMYCvCr1pV/FJED/Vk0CovzMWgmunk/sw9RXbuetkjC6ldg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CH3PR11MB7676.namprd11.prod.outlook.com (2603:10b6:610:127::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 13:41:17 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 13:41:17 +0000
Message-ID: <e43fc483-3d9c-4ca0-a976-f89226266112@intel.com>
Date:   Wed, 29 Nov 2023 14:40:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 13/14] libie: add per-queue Page Pool stats
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        "David Christensen" <drc@linux.vnet.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "Paul Menzel" <pmenzel@molgen.mpg.de>, <netdev@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
 <20231124154732.1623518-14-aleksander.lobakin@intel.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20231124154732.1623518-14-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR05CA0016.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::21) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CH3PR11MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c911fd5-d558-4b9d-7768-08dbf0e0dc92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EsKnI1S1m2nYQQLdXS8gh7mtSn8w3jX+yvb5yCAscWeLb82MPuS/T8RCFWfn5LGDBoOk84FY2ac243fT1gec4JyzFxEbT1RkrVKDTcCn7pWePDe7F30LWOGcnAR6SUJ4SVu/5l0GHtibjKZDApHDovPHM2Vl/qgdre3DRVy0qIQHZaXc/tI/E0iOdluSyNXs6YQsFdVkX5+1Wb3RgJHfx5yCYFBlLdr9s/a/GeolGZKYjwQ3PYss0TU7RdUrrw46YWjnga6YMjjZtsrxIkGcpJNt+UxHR2FHQLOYjriinDSUzE8B42bMpEqbFbmY5c6rIytBGdLWiBxVoxQa8QRcNNou5Bw7vs5Y3++dgsL/b4KPVPK6W3INLYu2uDmgOPyIkCGTUeH/oNbTM7PvZTIQ1CGCk1OVI1cBPAGBfggpSrPNvIgL9Eo4+52MibBLKkY5+ZBw1qa0T+ymn3K3J49GgCxmglE9rO1DmQWGrFwho9vfh6qqfB8R4CThA1W5fLm6dZsRn0A7hEsOEK5ZC828lACXKFq8ErOizyxUo+V3nZZfOXOTJHAJnfz1j17DNXUOoAUYFRK0kx1c2giE/ECbPJXW7Se1zgoYkgUlJXMAEOJwj0fF8iPU3rjtE2nPHfX/B7Twi1oWq8OpJVYmftWkpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(38100700002)(41300700001)(36756003)(31686004)(83380400001)(7416002)(5660300002)(82960400001)(26005)(86362001)(2616005)(2906002)(6512007)(6506007)(6666004)(8676002)(4326008)(8936002)(31696002)(478600001)(6916009)(66946007)(316002)(66476007)(66556008)(6486002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dENRSGJCTDJaTUxOY3daZlJjOWJlNUI3Z2V0d0dUdkpwQm5yZkxzOSs1NnNH?=
 =?utf-8?B?c211dVBscGVRcnVGQ0IwemtYVGpVL2FVRytodlBCRCtIL1o5TS9BK2lONHNs?=
 =?utf-8?B?TUdDYmhkSzcxYkdkWjcxZHNFV24xRmFFaWgzVjJxRkpham5MckFDQjd0Qkdz?=
 =?utf-8?B?c2hMMEE5Sjd0K3dZcUhlK3lzL0tHRUc0RVBWRDRhYlJXR216QjNoNlk2RUw2?=
 =?utf-8?B?WWxWTThRWGFrMUZiRnZab2gwbDdyWGNqUVI3SFRNQjI1SHprbFc3WTFGSVRR?=
 =?utf-8?B?Y3haZmJtK21ta081dVJEOHVrRXpTTjFwUTdDVXZMOGwreXRhU2JxQWlLNHBK?=
 =?utf-8?B?TWVRWjZNM2pyVGpMR21uTk84TkY1RXZuNlhuQ1RpbXVVa2oyNTV3dzdUQnJX?=
 =?utf-8?B?WnNsWnZieXJvOEVXRjY1QjIxUmsxbGQzT1VIOUZ1akJ0djNHM3JEc1ZmOXdB?=
 =?utf-8?B?VXkraVZBK0V6TE1UWGt6OG5FYW5EbC9JaTdUd3c3V3dlSmc3U2RIUEdHdkYw?=
 =?utf-8?B?QmpENEdmelc4dUxWOFpHcHB5cCtGVTdsSHhTUVpXUktLRk40bEpKdE52VVRY?=
 =?utf-8?B?eDNWeHhJYndVeHNPN1pQK3g0UHlQQlpFSWdCR29BbjJVY0NNZnFLcDFzYWty?=
 =?utf-8?B?K0V0dnNZNDJydFZoak5zcXZxckJyeTlkZW1BSC9qS1lmZXhHUXRHUlRnVzBw?=
 =?utf-8?B?Y0hER1oreHlnM1RHOUdkKzZ0dXM5UHViV3dvblJDQ2tCaC9MMTRCMTUyY3pG?=
 =?utf-8?B?UnhBbFAyRTRkQUgzc05wVnI3MlBzL0dka0I3RUlkMDkxR1VZTWQ4bFVGTklm?=
 =?utf-8?B?YUoxSVFWTkV0UE5uT0M5a1ZGUGF0VHZHVm1PUlZyWU9yc2RGMERzd2hldHB6?=
 =?utf-8?B?U2ZlSXJnbm9Kb2drR2lEdmdtUUk2b2tKdnVqak5YUVFDSm5tN3lmclhmY3Y5?=
 =?utf-8?B?U2o5blY4WnJ0SDV6UWlsSHIwTU02YnduRUtjVlV0allDd01PSVdXWU1nRlhU?=
 =?utf-8?B?Wld0eFJuamdDMFNFaVBVdUE3dmxzK0ZTR25WcTlLRmszRUxBdkgwWFlRVGNt?=
 =?utf-8?B?WTNOTk1kL2Y2TlViTGJNYUdrSFdXaFFGMDM0SjFmYzltM0o1V1lRSjVrUHE3?=
 =?utf-8?B?b3RNS3ZsOFV0OUNjS2FxZGdTWXIzYXMyRWlLcGNiOGQ4d2lGSnBsZEdVbk9N?=
 =?utf-8?B?MzBETmh6UVIrZ05HMjdoaVBGTmlld29vUTcrTElTcE5DZUdMTThIKzB2Zm90?=
 =?utf-8?B?ZW5wL05oTGR0L2dQSzdIa3VIMEplUHZuQVNyNUlVTlVlZFY0VTdiOTk0VkE3?=
 =?utf-8?B?ZGVDUUhqU00xcEQyKytSaldMZENWNmQwSE0yMWV0SjFlQlFoYUhmSUVhZWRt?=
 =?utf-8?B?Qmo3Ni9CNmRwZGxQN1VTMXVDb3o2aWo4L1h4K1d5SzU2bHFUNTUxMXdtN0g5?=
 =?utf-8?B?V1JqM2VIazJQQStGVjlMa3BlNjNQWFZ1K3hUTlZNOWlpN2p0ZDZzbU5kQ1lL?=
 =?utf-8?B?RkxISmFlWlRQK3NJeERkQVVYYysvaU9HeDQxWmd4UXg5cklIcVdnaS9LR3pO?=
 =?utf-8?B?WklkaUYzbkVOTElEYXRvVjllZGwrRFJyQnNJV0dxZ1RJdHU4MXJwZlprajFZ?=
 =?utf-8?B?MU15Y2xjMGRWYWJYZUZKbCszWEd2T2pEczFTdkZlaHpHczJzem1Ta1hETXZM?=
 =?utf-8?B?WFd6c3VZMmF5T3ppTGV2eVZLbDdGRHNzVGlwMnNpdnVSSkNVZER3SjJmdExl?=
 =?utf-8?B?UmRCTlFObE54VUhvR0N6ZzhVQ243eXNGNWc2SzZYWFE5RnNUL0NKRmhGK3dB?=
 =?utf-8?B?S29RbVByaTdaMGJGSnErVVdYeE1hL2RxNDRrUVBKL3Z2dnFTR2pleDVtVXNr?=
 =?utf-8?B?VGViRE1uY3R5TUdwTGJsdFdNWm1FOXU4YVM3b3BJTUlQbkZOWW9XVFBuYnU1?=
 =?utf-8?B?ZUdSRmRKeDM0MHB1RGRWSktCZmxlR24rOFhwc25Kb2RHdUpZWnlGM1ltK3F4?=
 =?utf-8?B?TEcxc1lXeit5UHBkcHZnTzgyQWxqWkd1UW04YzhwWGg5d2d1M0JkM3c1OWZa?=
 =?utf-8?B?NEY1RlNNNTVzTlorWkhKaEExVVBDZytFMml3R2VET1F6cGgyaUVLeGRWSHBK?=
 =?utf-8?B?SmRGZmhNdlJJdCsvdG1KbVNkdU4vczY0eVJNa1dWb1hSS2ZNWXI4WmpOS0pQ?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c911fd5-d558-4b9d-7768-08dbf0e0dc92
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 13:41:16.9221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npAg3UsFp+/HO0KZDWdFRGCnLsesEcKimXsqYKjtjm0daH5yhrJz4h6U03199zZKoekJyAoRgN4hmGTezNjNmqdtPoFed3UHHvFB5MUh5ik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7676
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

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Fri, 24 Nov 2023 16:47:31 +0100

> Expand the libie generic per-queue stats with the generic Page Pool
> stats provided by the API itself, when CONFIG_PAGE_POOL_STATS is
> enabled. When it's not, there'll be no such fields in the stats
> structure, so no space wasted.

Jakub,

Do I get it correctly that after Page Pool Netlink introspection was
merged, this commit makes no sense and we shouln't add PP stats to the
drivers private ones?

> They are also a bit special in terms of how they are obtained. One
> &page_pool accumulates statistics until it's destroyed obviously, which
> happens on ifdown. So, in order to not lose any statistics, get the
> stats and store them in the queue container before destroying the pool.
> This container survives ifups/downs, so it basically stores the
> statistics accumulated since the very first pool was allocated on this
> queue. When it's needed to export the stats, first get the numbers from
> this container and then add the "live" numbers -- the ones that the
> current active pool returns. The result values will always represent
> the actual device-lifetime stats.
> There's a cast from &page_pool_stats to `u64 *` in a couple functions,
> but they are guarded with stats asserts to make sure it's safe to do.
> FWIW it saves a lot of object code.

Thanks,
Olek

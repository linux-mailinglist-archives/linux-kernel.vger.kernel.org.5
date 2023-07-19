Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3860E758B4C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 04:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjGSC2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 22:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGSC2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 22:28:44 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D331BC3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 19:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689733722; x=1721269722;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YyU+uwH/2YAQydG3UKVUyZZSiVbY+2lSvuRzFWYfxuQ=;
  b=U7no3UL35YngCN6JNISn5qvx2UObwKBiraHpTcWeofS7doxnyVatoKav
   pLHg531G7ORHXP7ZE3b9jNAnIhqWOHp4zWC4hWZdD/2fqQDHdC1DMTX+4
   PlC1Mb+N7qmWOLhPwfoFbQnssewC6TwhflgcpvcVyfP9SDproQNI3hDBZ
   HDPISRvmpzPHy4g+d3MZW1bBE6teYafv2b8qeLZ3jziEZtn34homoLNIj
   BSN5TdqGTxPnxcB3WNw+VLPekdKtgE4uKdm81tHLEqaCWlDr0Z50LCFtf
   IIrc7YmOAZ5xjYZwLKcgaS1rKT2ntXn96XOlDiO5QPIO8wwNdNX8aUE3j
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="356303495"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="356303495"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 19:28:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="723837434"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="723837434"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 18 Jul 2023 19:28:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 19:28:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 19:28:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 19:28:41 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 19:28:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTZRWadx0ME+MxRc6tOAPWwhnd2y4dVHAs7MMdcb3SNi9r9BiTPw6c70WqmDw0BF3wLsOHpY4yVT9iWETz1R01pqB15nH57GV+vlOO0JZrcMjVkXFFBM8tOwVY4rtBKk/cEcL/Mit64tiKM276NFJNYj2UxZzRV4LugRxx1U8B+B/85upHtr4dptEK55qFwiiRxP6NEpxDGpwmpZiefLXUHOsoQxsxVzrJyWV5U3KaYgZPpYo2VKlj2q9+W9RoOGEc6vTC0T4wztf3fZ/xgJ2iHsNQprMURUM/mVHmw77fn9lx8v6mXAqkfwvCbpm/CZv0fGtbcXDDiKfftlrdJFSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+pk3zMQekeoBId/92gh0ed4BVyipsuqakgQnx6nf68=;
 b=XXoszK2uQej1A6f8L/bfKTRe9NbWC9BRMPf1REyB146gCuAvZeeXZE0EOCGmqW2UutA7OAAUARd3BdiFtZnPliTpSGOYOXsU4Y6n5YhJtbJ9ZpzsvyAW0+3EDJwfXGOeRX4ra+7R2e1qdVFKisiX4IcXQ/K8FpgrIUvkaaJhpYmeI3oD1LouvPdmLFHM9pRxmnY+k4pufYjjnIkB2PZhiPN5zMhUyVNpfns2FB2I0CBmOCRlSPigAJV8Urr6KDvi/5ygHSgSdFUYP/BY+t7Ucii4pkCy4bsGKDPvSZvUA2e6SHecuFhwklIRpweLHnvpfs0NrEfHyG7qZqCna06NPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH0PR11MB5094.namprd11.prod.outlook.com (2603:10b6:510:3f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 02:28:39 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e%5]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 02:28:39 +0000
Message-ID: <e3044d46-3b38-dc2e-b8d2-8ec1033f85e7@intel.com>
Date:   Wed, 19 Jul 2023 10:28:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 3/3] mm: mlock: update mlock_pte_range to handle
 large folio
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>
CC:     Yu Zhao <yuzhao@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <willy@infradead.org>, <david@redhat.com>, <ryan.roberts@arm.com>,
        <shy828301@gmail.com>, Hugh Dickins <hughd@google.com>
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
 <20230712060144.3006358-4-fengwei.yin@intel.com>
 <CAOUHufYef--8MxFettL6fOGjVx2vyZHZQU6EEaTCoW0XBvuC8Q@mail.gmail.com>
 <CAOUHufZ6=9P_=CAOQyw0xw-3q707q-1FVV09dBNDC-hpcpj2Pg@mail.gmail.com>
 <40cbc39e-5179-c2f4-3cea-0a98395aaff1@intel.com>
 <CAOUHufZHyEvU-c2O6B6stM_QVMxc22zV4Szn52myYqjdZvptUA@mail.gmail.com>
 <16844254-7248-f557-b1eb-b8b102c877a2@intel.com>
 <CAJD7tkYAkVOE2caqEj_hTmm47Kex451prBQ1wKTRUiOwnDcwNA@mail.gmail.com>
 <b995e802-1500-6930-79d0-8cc4bfe89589@intel.com>
 <CAJD7tkZtHku-kaK02MAdgaxNzr9hQkPty=cw44R_9HdTS+Pd5w@mail.gmail.com>
 <CAJD7tkZWXdHwpW5AeKqmn6TVCXm1wmKr-2RN2baRJ7c4ciTJng@mail.gmail.com>
 <208aff10-8a32-6ab8-f03a-7f3c9d3ca0f7@intel.com>
 <CAJD7tkYT6EZMwit8C9MTftUxMmuWtn2YpZ+NSVhy0xVCYuafsg@mail.gmail.com>
 <438d6f6d-2571-69d9-844e-9af9e6b4f820@intel.com>
 <CAJD7tkYWH8umBFgmxPmeOkRF=pauVW=MvyyN+z17XMHN+q8JKg@mail.gmail.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <CAJD7tkYWH8umBFgmxPmeOkRF=pauVW=MvyyN+z17XMHN+q8JKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH0PR11MB5094:EE_
X-MS-Office365-Filtering-Correlation-Id: dacaff49-d753-4fd4-8d6b-08db87ffdcca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dLcrLRShdx8SugFRCPQCbKp0zBFP4U8uI1HmluhuFui1jwz1caFiRuwz0Y8foSSe7JIQ3xzMVzNdy+2fA5ObcXN7xtEI6nCsQ4nDSj+TM3dUeXbZENpaT9Epp9fe+OH8L+VtEGZZsmuUFQrgCFg8nvw1Q23OOttt7Jn7ZlIaU+QKYQiaCJcW58cZjMgBSNvwa5PJo/YPXt9P65yhqnWFYo3r627ExPnaCJkI6fq9746cXNGmSumaHEzVIyXOAEw6NO6wtXc1X6UzTM/QMu+ceNNtS/4dWauXIRONAe3i8Hc8fwyZWvywvD6KndE/isb1jUAu8VS5A3q8kafXZ3g7JKWtVmHmm9mzLBfMKaxYGkGBkkJ9AMLfVu7tNKmW1AUk9o18nWyudTf+0DTWIBqYG2IuqpSp0UtZkiDhJHgiWrhSiL6P4y86dLgsZXdTUbYW4iZ1FFhzTToCcxexJyr3rH4+NWBSuuM5ja+ln9UC7dQ35cvy6yxYomcsdSCJ9+WGrC2pvnvLBnTeagzNz0aMmbB+Kj/8XqV1havIf7i5t4nDyfwQQj3FX7DhVjNKruFn3vIzJ2AJQsE1k+roo0PpDc5YT4y+rjjO+1mc1k8bag99xcoJiiSZnPEYE4irtr5GgTf8dxep2o99ZBMoKWkxAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(478600001)(31686004)(38100700002)(82960400001)(6666004)(31696002)(86362001)(6486002)(66476007)(66556008)(4326008)(66946007)(6916009)(316002)(83380400001)(2906002)(6512007)(36756003)(26005)(6506007)(186003)(54906003)(2616005)(41300700001)(8676002)(8936002)(5660300002)(53546011)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXVmZFc2akJKNEFlM0RrY2x3aGVHNCtaRVl5dXlRT1JBTkppVytXMjZYd3Jn?=
 =?utf-8?B?emQySVgyZ0lrOVJqK3YrMFNBZmlXNzhza0QvNkNSUVFmUVRXMkJGK2pNY1lM?=
 =?utf-8?B?aDlOdnpYWUIzdEMrTTF4blZoRTdHdGlvSmt6dmp5SjE2TGpkN0FKbklHTVNT?=
 =?utf-8?B?Q3FORUh6VndudUtRQit0QWpsVzJNNXNuZlArc2dZZW9SRi9OZm9ZWmxUeEFW?=
 =?utf-8?B?K3lUejFMbVhDcVlMSjdoRUxqN1NsL0ROeUhVUHprNFhvNzYrWjY4d0RvblZL?=
 =?utf-8?B?VEg3RGQ4YlF3WnlYRFd2S1ZCVHc1UVR6R3pHMHJzOXFtVnNDejVBVUVESXZI?=
 =?utf-8?B?RzBSREJESVVDMHkrbk1LbEp5YUxqeWxPM2FhbXRRUmlOb1Q2V0tTVENjMVhs?=
 =?utf-8?B?Y0ZqMEJKT3dJOGRPNVRqa2RDRmszdVBYNnNZaFZ4MEFkUjc4OEdGb3lJZ3Y3?=
 =?utf-8?B?anh0U0Z4YUtoN3hQQzh3U2RaKzRSeExoTlZURW5DMGtBWmx1UHVEYVZVeThj?=
 =?utf-8?B?NnYrMGRJbEx2RkkxUVVud3g4Yy93YWN0VDRkYmY3S2gzeDBMdUJNV1N1ZFVv?=
 =?utf-8?B?c1NRcFRMSDRLbTlmSGoxQ2NyYkFMYWQvMFpXR0EvRE15blFFOGNwTFBVTFZu?=
 =?utf-8?B?YWY2a2FKL1V4SDZadzAwNVArKzlMdjdzQStiV2xlajJhS2Q4RVNhaldPcE1n?=
 =?utf-8?B?NUVmU3h6eHBmZ0d5TnpnWjZ0Tm0wQWRkeGxOY3hiU1QxemxiQUtOSWZ2QS9H?=
 =?utf-8?B?aDZLVnA3SzJxdmFqRGJJa1ZSbDk0bzAwZ2tQbGg2ZXZWUUwxMzVXQ21XNEtH?=
 =?utf-8?B?L0lpRXhDd2psRllwbGJ2NEhaTVR3QlA3Y1AyODhISURyelZpTytDQjVGT2Mv?=
 =?utf-8?B?Z3JWZ2NGakMrVVZna0tiK3RhWGd3V3NlQ2lGbjNCcWtLWndTYkY2QU1OWm1m?=
 =?utf-8?B?T3VjWlRyZnoyYXVqa1RhRG5vdlFVSmpFcHJxaHc1clpBYkhaVGF3OGVKTDdy?=
 =?utf-8?B?QmVhS0NDb2NXMmNHUzUzaFN0N2xZcEgzUjVXaGRnVXgyZGIrQXdEMlRYd2VQ?=
 =?utf-8?B?Zjd4ajZkMnR3WHFTUkErU1ZGdWgycWI1c09Za2ZHMTFYeWVqTkJIdEtxcDhr?=
 =?utf-8?B?UFNOeURVcnJqemNhSjVqeG1QczFlZEp3STNmTWxFVTZGOCtoUkVsM3BvUmRu?=
 =?utf-8?B?M2dmdUZPTDREcTdzb2xQYndLZEpNWmZ5dCttUTJ2eTdISEw2S21FcTNqSVZR?=
 =?utf-8?B?ZVRsamZRandydDVBQUJpbzYzdnRPdUdrVlRKNldBeTJIR212TnRuaTRwaU1N?=
 =?utf-8?B?K3RtRmY5V3Q0VlNYZEp0Qm9NSzFqdjBlZ0VSRHJMa004bDJ3TGVPWmUvazRq?=
 =?utf-8?B?bW9zZmpXV214WVMxUER6blhsTzJDUzdvTzdwZUlNRDkraXVleUJaMnQ1dnpo?=
 =?utf-8?B?SHZIMTRiRHV1Vmk1LzJPenlaNXA5OFN5UjBubkIvMytkdUZRdDE2L3R2MlhR?=
 =?utf-8?B?Y3BySHNSaWFjd3FPa2Z5M2U3MTVXbkFEOVhZaVF4Ymt2TVRpMkxYNENkdWJv?=
 =?utf-8?B?M1NNQm5SK1UvWUZYNFdzamFHRVczakt0VXkxeTdUQ2FlQ2pSbFVJakpEREc2?=
 =?utf-8?B?aEVjZ2dvOFdLQmthRXYrM0FoaWJpMGkvd3d6STV5d3l3VGJhTFg5RFB6bVlH?=
 =?utf-8?B?RENsQlM0a1IyRzYzNXhjditJSmdxZWk1UmV6Y2duSkd6cGVQb3hlV2ROdStL?=
 =?utf-8?B?SWZ3VFhMNmpvT1lNN0ZwL3BUVHdBZUdOaG9xa1p2bDBiYkRFcmdTRmNqRUE3?=
 =?utf-8?B?L3RRcEhoK3JXbzIrOEdQTVduWmZxRlJTN3hKbjlkZysyM2lWZ2RLelFQS0Q4?=
 =?utf-8?B?UmpKSVZDRyttZk53Q09uK3lyRHJsUnhHb3dKdnFIUVYzTW01SVNvT2V6RVlJ?=
 =?utf-8?B?ZTI5Q0NNNkhwM2pTaVVPeWg2NzF2R3dUZFpaLzVseXZtcFFVbVB6Vjk3Qk5h?=
 =?utf-8?B?K0FwNE93dEZyVm1ENHl4UW82SllCOFRHVFhzQk0vVkZqcTZEWStBaWJzYThO?=
 =?utf-8?B?YWtTN1h3YzliRTJJOXJ3THdKMU1VV3lNd0VkL0UxUi9oQTFMMW55TS8wdXNv?=
 =?utf-8?B?KytuVTJaRnhFTjY2QmFIWFhhY3JXS2RhYVZhMFNlWndVQ1ZtOVF4TzdMeVJn?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dacaff49-d753-4fd4-8d6b-08db87ffdcca
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 02:28:39.4446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUewhgczVvGvD7BWP/toPS2CQHteYsj9NNBMsMW/zj6xsZN+A4zxCUSPZ/TCGabnKUvNNUByXFV7cX0OIw52kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5094
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/23 10:22, Yosry Ahmed wrote:
> On Tue, Jul 18, 2023 at 7:10 PM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>
>>
>>
>> On 7/19/23 10:00, Yosry Ahmed wrote:
>>> On Tue, Jul 18, 2023 at 6:57 PM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>>
>>>>
>>>> On 7/19/23 09:52, Yosry Ahmed wrote:
>>>>> On Tue, Jul 18, 2023 at 6:32 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>>>>>> On Tue, Jul 18, 2023 at 4:47 PM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 7/19/23 06:48, Yosry Ahmed wrote:
>>>>>>>> On Sun, Jul 16, 2023 at 6:58 PM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 7/17/23 08:35, Yu Zhao wrote:
>>>>>>>>>> On Sun, Jul 16, 2023 at 6:00 PM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>>>>>>>>> On 7/15/2023 2:06 PM, Yu Zhao wrote:
>>>>>>>>>>>> There is a problem here that I didn't have the time to elaborate: we
>>>>>>>>>>>> can't mlock() a folio that is within the range but not fully mapped
>>>>>>>>>>>> because this folio can be on the deferred split queue. When the split
>>>>>>>>>>>> happens, those unmapped folios (not mapped by this vma but are mapped
>>>>>>>>>>>> into other vmas) will be stranded on the unevictable lru.
>>>>>>>>>>> This should be fine unless I missed something. During large folio split,
>>>>>>>>>>> the unmap_folio() will be migrate(anon)/unmap(file) folio. Folio will be
>>>>>>>>>>> munlocked in unmap_folio(). So the head/tail pages will be evictable always.
>>>>>>>>>> It's close but not entirely accurate: munlock can fail on isolated folios.
>>>>>>>>> Yes. The munlock just clear PG_mlocked bit but with PG_unevictable left.
>>>>>>>>>
>>>>>>>>> Could this also happen against normal 4K page? I mean when user try to munlock
>>>>>>>>> a normal 4K page and this 4K page is isolated. So it become unevictable page?
>>>>>>>> Looks like it can be possible. If cpu 1 is in __munlock_folio() and
>>>>>>>> cpu 2 is isolating the folio for any purpose:
>>>>>>>>
>>>>>>>> cpu1                                        cpu2
>>>>>>>>                                                 isolate folio
>>>>>>>> folio_test_clear_lru() // 0
>>>>>>>>                                                 putback folio // add
>>>>>>>> to unevictable list
>>>>>>>> folio_test_clear_mlocked()
>>>>>>> Yes. Yu showed this sequence to me in another email. I thought the putback_lru()
>>>>>>> could correct the none-mlocked but unevictable folio. But it doesn't because
>>>>>>> of this race.
>>>>>> (+Hugh Dickins for vis)
>>>>>>
>>>>>> Yu, I am not familiar with the split_folio() case, so I am not sure it
>>>>>> is the same exact race I stated above.
>>>>>>
>>>>>> Can you confirm whether or not doing folio_test_clear_mlocked() before
>>>>>> folio_test_clear_lru() would fix the race you are referring to? IIUC,
>>>>>> in this case, we make sure we clear PG_mlocked before we try to to
>>>>>> clear PG_lru. If we fail to clear it, then someone else have the folio
>>>>>> isolated after we clear PG_mlocked, so we can be sure that when they
>>>>>> put the folio back it will be correctly made evictable.
>>>>>>
>>>>>> Is my understanding correct?
>>>>> Hmm, actually this might not be enough. In folio_add_lru() we will
>>>>> call folio_batch_add_and_move(), which calls lru_add_fn() and *then*
>>>>> sets PG_lru. Since we check folio_evictable() in lru_add_fn(), the
>>>>> race can still happen:
>>>>>
>>>>>
>>>>> cpu1                              cpu2
>>>>>                                       folio_evictable() //false
>>>>> folio_test_clear_mlocked()
>>>>> folio_test_clear_lru() //false
>>>>>                                       folio_set_lru()
>>>>>
>>>>> Relying on PG_lru for synchronization might not be enough with the
>>>>> current code. We might need to revert 2262ace60713 ("mm/munlock:
>>>>> delete smp_mb() from __pagevec_lru_add_fn()").
>>>>>
>>>>> Sorry for going back and forth here, I am thinking out loud.
>>>>
>>>> Yes. Currently, the order in lru_add_fn() is not correct.
>>>>
>>>> I think we should move folio_test_clear_lru(folio) into
>>>>
>>>> lru locked range. As the lru lock here was expected to
>>>>
>>>> use for sync here. Check the comment in lru_add_fn().
>>>
>>> Right, I am wondering if it would be better to just revert
>>> 2262ace60713 and rely on the memory barrier and operations ordering
>>> instead of the lru lock. The lru lock is heavily contended as-is, so
>>> avoiding using it where possible is preferable I assume.
>> My understanding is set_lru after add folio to lru list is correct.
>> Once folio_set_lru(), others can do isolation of this folio. But if
>> this folio is not in lru list yet, what could happen? It's not required
>> to hold lru lock to do isolation.
> 
> IIUC, clearing PG_lru is an atomic lockless operation to make sure no
> one else is isolating the folio, but then you need to hold the lruvec
> lock and actually delete the folio from the lru to complete its
> isolation. This is my read of folio_isolate_lru().
> 
> Anyway, whether we rely on the lruvec lock or memory barrier +
> operation ordering doesn't make a huge difference (I think?). The code
> seemed to work with the latter before mlock_count was introduced.
> 
> If we decide to go with the latter, I can integrate the fix into the
> refresh of my mlock_count rework RFC series (as it would be dependent
> on that series). If we decide to go with the lruvec, then it can be
> done as part of this series, or separately.
Let's wait the response from Huge and Yu. :).

> 
> Thanks.
> 
>>
>>>
>>>>
>>>>
>>>> Regards
>>>>
>>>> Yin, Fengwei
>>>>
>>>>
>>>>>
>>>>>> If yes, I can add this fix to my next version of the RFC series to
>>>>>> rework mlock_count. It would be a lot more complicated with the
>>>>>> current implementation (as I stated in a previous email).
>>>>>>
>>>>>>>>
>>>>>>>> The page would be stranded on the unevictable list in this case, no?
>>>>>>>> Maybe we should only try to isolate the page (clear PG_lru) after we
>>>>>>>> possibly clear PG_mlocked? In this case if we fail to isolate we know
>>>>>>>> for sure that whoever has the page isolated will observe that
>>>>>>>> PG_mlocked is clear and correctly make the page evictable.
>>>>>>>>
>>>>>>>> This probably would be complicated with the current implementation, as
>>>>>>>> we first need to decrement mlock_count to determine if we want to
>>>>>>>> clear PG_mlocked, and to do so we need to isolate the page as
>>>>>>>> mlock_count overlays page->lru. With the proposal in [1] to rework
>>>>>>>> mlock_count, it might be much simpler as far as I can tell. I intend
>>>>>>>> to refresh this proposal soon-ish.
>>>>>>>>
>>>>>>>> [1]https://lore.kernel.org/lkml/20230618065719.1363271-1-yosryahmed@google.com/
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Regards
>>>>>>>>> Yin, Fengwei
>>>>>>>>>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96052755949
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 03:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjGQB6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 21:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjGQB6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 21:58:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE85CE52
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 18:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689559124; x=1721095124;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iq2OnQSHuSRhcQzxpo1ahnHXKdTqttfKICoMNhKVP9w=;
  b=iyLaK6PCbmyCZOgoOPwLVKDJSlSMDqyweuXAJvT8PHtfYA4CMW69bzbA
   d6cJqcTxK3WWGU6k0Wb7q7pLce/ORgDhpN2iKyQYy7bsfGtz/p7bzchp4
   13w0zi4ibodFbtg8H2+2AfTc8o0gTjcxrFL53brKNitXLKgRWHFRnqpE7
   /PMWjyjA6jmhSv5j4If3lX4czfn0Stzv21Pi9hm98Gr1ljoZtG2rKaZti
   /DipgFD9qO9ODTMTE6fHHu8xbOK6IYh8sfWZY4bI2nUoCLYAh5I2BTGOB
   0BkOI6PXtULvf+BkvPMboCEAz7pYcItFt1OtEyaOOOGTVWHId30Eb0PiJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="431996085"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="431996085"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 18:58:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="969685806"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="969685806"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jul 2023 18:58:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 16 Jul 2023 18:58:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 16 Jul 2023 18:58:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 16 Jul 2023 18:58:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBIzNisZ6+CvJisKX6cJFkicqt4jNHfmWqIFirGmw4AYrLhJZSUT+r2EmEm2mV2FZWm6TmeO1e2LTR455nTZRkUwI3tSwBn098zcRSPEpVhyWFZFB48tAdJeCtrVcDR/wTI1bE/qicf/mTjzf6IryNKOs7uWoc5kw36BeBQAT/37LIQMu9m2bYcI/1KLIFKZRmHM0B/EzWKI1ZbAvKutKmyZZgRnVoPVQHGUhqFqyH0yUP4NQGPTBSQHszWQ/NCOt6XuaF1A+JqmXoG5f9h7Vun2A0yjCDRCRxCgu73SPfh18+zSc8pNonf5RdRl9HxXM4wIOY9bUVgxgTHRbh+G4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrunnL/4hISazryaKy8Ie1pj+2d3NVyjMUwkCcGoR9k=;
 b=WMsOOPixkSpLWTWdYAksFB2op3upTCc28/nkpAtq5Hpxo2+NxrR8E4b74UOmD26pZsiGo8hsN2nEE801DRlrQtIWx5tgggKpeC9e48BrFHkC3eetVfH82RSDAWopV6pHsjpAteM5aHt4Y+OcjTwP6XWbtD8VK+faJ0qybEZD5S9CJhWrwBxtSCwAaFUM9wqw+//ZLUHf58KArzzjbxV0Pch330BX24Au7BvrE+4OzaHzMKVnRWTJjnzRQw+bt7mek20PUyOMxn2FyRjtOI1Wcug++6UrHUu5cx+AarBj5bTXlAlHn86bUi6RcALfoj8bH0Mj1taYzWItOX9At0f0Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CY8PR11MB7340.namprd11.prod.outlook.com (2603:10b6:930:84::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 01:58:39 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 01:58:39 +0000
Message-ID: <16844254-7248-f557-b1eb-b8b102c877a2@intel.com>
Date:   Mon, 17 Jul 2023 09:58:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 3/3] mm: mlock: update mlock_pte_range to handle
 large folio
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <david@redhat.com>, <ryan.roberts@arm.com>, <shy828301@gmail.com>
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
 <20230712060144.3006358-4-fengwei.yin@intel.com>
 <CAOUHufYef--8MxFettL6fOGjVx2vyZHZQU6EEaTCoW0XBvuC8Q@mail.gmail.com>
 <CAOUHufZ6=9P_=CAOQyw0xw-3q707q-1FVV09dBNDC-hpcpj2Pg@mail.gmail.com>
 <40cbc39e-5179-c2f4-3cea-0a98395aaff1@intel.com>
 <CAOUHufZHyEvU-c2O6B6stM_QVMxc22zV4Szn52myYqjdZvptUA@mail.gmail.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufZHyEvU-c2O6B6stM_QVMxc22zV4Szn52myYqjdZvptUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CY8PR11MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b6fb45e-928a-4abf-6bea-08db86695713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sCkiLXYn31QNdbROY7suaQw/f0OcHHr0mfpGoPIRapPIdd9ewfqJ8u4ZC2xFWSLZBj6RflTs20TdWHjJz+8XtGKd87wgeUSgc7M/3wZ7WkHxXfHfJxAN6cAHx/4LS052YuUu46Reqo/DC1PldMjj4+5Mw2cFCed8SJRrbtr/F9VbhdTRUd36ECJKRsSmx/UK/wlfKTeBGtVlL5NWtYLVSWpWVzTvkJ+ZWGWlG3xz+KdJPznLQrwgJ5WBNqrMxL/UCzsvXHjGuebON6JMKffunTaHahcO6WQ7iSwfCnLBA4VEb/H4l3Sn8TutSO3K7lbX2vH6OG2xpVUGq45wSDxcxWWg9ZNiT0nezioplT5FiXZ0kiUh+AZmrApfAsvECsrbFeO7tBd783PG4IzIx1yVwN1p0zRffEsc52OX/2zuhhJgLeSvNZPqzKfdWeL+oSIhoX7AMmA7rNeAFvCfQ+UEZ4IOZzoaoPVZ54tyhB+bh2tvIdktW72k2ig72uVVI5iuao062UCBDWAfLgHZcTx+HDS45SnximX7J2kyWu2beqFocqq84tqXMbPbb8tQKef0zZwjNSHIAruHZqrLFP0SF9sJx+od3w6KHXtKo8oNMv8P2tnFZ0kZX6F9AAVdJTG6hUeEEamezMwyl92oaltXSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(31686004)(478600001)(6486002)(2616005)(83380400001)(31696002)(86362001)(2906002)(186003)(53546011)(6506007)(36756003)(26005)(6512007)(316002)(38100700002)(82960400001)(6916009)(4326008)(66556008)(66946007)(66476007)(41300700001)(8676002)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1lIZHpRUzAwWkJBM00rdW8xRUp6cDRIR0d3Z3RZbStzU1RaUmVKT2NMQStQ?=
 =?utf-8?B?eW16Mk9IdUo3ODlUZE00TlVTZk9NenJmeTlWMVpoMmhPWmt6ZFpieW91bUY2?=
 =?utf-8?B?L0V5dVdZdDFmYllPRWxDc2x0Mjk2eTVic1BhcmNKN0IyMk1nNGl4UUMwK2VP?=
 =?utf-8?B?Z1Y1VkV4NW1heFNESTBZV3hMTCtjbTI3RXhpNzdXUzI5UVYvVk1jN0J3Q2xL?=
 =?utf-8?B?a3VKajM2QUlqcWpxVVdZakYyYTBYL3FjTEdpQUpybFlxRjJMbUhVMmg3eVlh?=
 =?utf-8?B?ZGRHMkUzbnc1MWYydU1DMEFST083L3VPeHpOalNubkVybnFKbnhNM0ZLeTI1?=
 =?utf-8?B?VFRqcHpzQ0dPbDJ6MzZHS2VUT0d3aEh4SXBVRFZWYVl0T3lSdnk4M0ZZZlV6?=
 =?utf-8?B?OTk3RmE4dkNQeVNlK2wwOTkweWcrbXpSNnhrSFJlKzNLVy8rV3VHRW4zNWhO?=
 =?utf-8?B?N3VIbkF2STJNbUVyS1E5M21hVkR1YXdPa2tPWm9jOXpZNkJheU5hQm45S2Zq?=
 =?utf-8?B?VEFMdlRmTG8yTmlYbXFHVFArejFtNFc2eVlsMm9BOW41TCtMaXgzVnhMK283?=
 =?utf-8?B?NGRXdXlWeHN4bGh4dGRjcWVBTGc4SndvR3V0R2YwM09SV25YUS9FZWZLTEV2?=
 =?utf-8?B?VDJTenErQW53ZTMxbHQ0azlRSmdLRU5nOTludlN1N0RvekxXOGVZYWVteVV3?=
 =?utf-8?B?am5CT0RJclhDU0JhWWtVbUt0VldJOENuTXpTWnc4YXJVSGdCNXU4Q3Z2TlIr?=
 =?utf-8?B?alZHRVpvK290TWEwWjNCRWd6UjVIRS9GVjBRMEFVTFB2WENtOStKVC92VGVS?=
 =?utf-8?B?SFFyWVB6WjJyV3lETStFVlhqVGJyQmV2MjFzTUlpVDY5U2pLc0VEckFUclF5?=
 =?utf-8?B?bDhJejRpNVVHL2t5V2lpU3ZoWlpvMlE0WnhnaGNOZ2R3Y0NWQkN2Qk1tZ2VK?=
 =?utf-8?B?bk4zcE40LzR5WGdEeGppa0l1M0NqUWZCUkpRVEpWejhFaXRtZjhGdzVEbFVB?=
 =?utf-8?B?OFF5RTIzelhtU3ZySmREQnNRRS85bStmOU52V2pNWG82K3M2Z2krekFtOHNk?=
 =?utf-8?B?NXczeWpCTFN2WkpDUmt2S2tBcTR6L2NSL3ZxOFJyYSt6SWJGdTlzMVhpOEZ2?=
 =?utf-8?B?SzVGYmNMdlNMWVU2TlpYbWZENkgwbkRORnZnS0hsUFBnTlZWSFpMblNJa1ZC?=
 =?utf-8?B?TE9mT2NVa1dSa1NPNlowY2kyTWQ3Y3BSQmNMQVFaODVrdUcxV2xKL3VQUmdK?=
 =?utf-8?B?YnF1UGZMNDN1K1pMKy9aODBiV2RSZHVhWTFhb1pEdlNiVE5ONTZqQWV4OTBj?=
 =?utf-8?B?MlZoT2dOQ1RhNDBnMHVhdUd6aVBmRnVjMjJ4a0lRY251dGxKSUx2NEhqbytR?=
 =?utf-8?B?eVZEYzRCTkY2N3V1VUEzeE5RUUVMOFhXZTRSdVhPS0Z6WE5YQ3Z2bmZmQUhP?=
 =?utf-8?B?R0I1Y1BEUjNIenJ5K1A3Zy9zd2s4N282ZVdUTG1nUUdpYkhPSnNkKzdPTEhG?=
 =?utf-8?B?RFpDV3VnZEk3bXhLTmtUR1R4cHdGWnNXVTBmZURuV1BGdGtKRGo1VGpOckov?=
 =?utf-8?B?QzJseUN5Q3Bzd0IrbU40TnFqN0I4YW9naVFuTkdTVjVvNktQZmFhS3VnZXc1?=
 =?utf-8?B?YjcvbGYrN3Z5WkFBaUdaMVZzVHRDcXo5cVllSTRLbXpCQXIzb29qNjIyZ1J6?=
 =?utf-8?B?ODNKazg3R0xuYXEwN1l5RmprVlhsZkhoL3Fzd25FMk9CZEg0WXFkRlZuMm5O?=
 =?utf-8?B?QnFLN2lxblcxcWpqTFMrcWo2eVp5OHVtZUFhMDVDSDNIYUVTYTd2QWZ6Q2Jm?=
 =?utf-8?B?MzVjSkRRYklZRlYrdW9SRlhWVkRzVUpNcFYzdW9BYVBITkVVMytjS2dmQzE1?=
 =?utf-8?B?b2kwYnFaNVRPYkpGOUowWmJoZy9DMko3ZGdqc2YzVm9KUTdYdnlkak5tMzV0?=
 =?utf-8?B?OG1GdU5qWlB5UzhacGk3M3JLMXJPY0RnMTZualJ6cmlJSFkreEF4WjlxaFNw?=
 =?utf-8?B?Q2wvOWFtbzBENUFWS0NzUDlJR2syTS9hNVIyNU5VOWw2QTJDeStrd0ZaM1E2?=
 =?utf-8?B?eHQzcS91VW5rSHpUczN6OXNha2l4bTNLSGVGZXRaS3Bkc1pXWC9KMkg0N0VY?=
 =?utf-8?B?c3dBN3Nkd0xGWnJnMzdjc3pPeFdLaTBQcnhQWjY2Z0JqMG15dVpmVmNIQkUz?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6fb45e-928a-4abf-6bea-08db86695713
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 01:58:39.6362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4f+HdXlgMdPrFwV2t2tgcM6pX1cO0QqCxbjeyHJJScvq39wAWGpU+0c7vx/z79Q/neUMDKFu6GLzUy3og9Wz5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7340
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/23 08:35, Yu Zhao wrote:
> On Sun, Jul 16, 2023 at 6:00 PM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>
>> On 7/15/2023 2:06 PM, Yu Zhao wrote:
>>> There is a problem here that I didn't have the time to elaborate: we
>>> can't mlock() a folio that is within the range but not fully mapped
>>> because this folio can be on the deferred split queue. When the split
>>> happens, those unmapped folios (not mapped by this vma but are mapped
>>> into other vmas) will be stranded on the unevictable lru.
>>
>> This should be fine unless I missed something. During large folio split,
>> the unmap_folio() will be migrate(anon)/unmap(file) folio. Folio will be
>> munlocked in unmap_folio(). So the head/tail pages will be evictable always.
> 
> It's close but not entirely accurate: munlock can fail on isolated folios.
Yes. The munlock just clear PG_mlocked bit but with PG_unevictable left.

Could this also happen against normal 4K page? I mean when user try to munlock
a normal 4K page and this 4K page is isolated. So it become unevictable page?


Regards
Yin, Fengwei

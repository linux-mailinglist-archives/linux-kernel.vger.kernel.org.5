Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A53A755DFD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjGQINJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjGQIM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:12:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D21132
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689581572; x=1721117572;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jlSlV6oD0TxJ/7jAD7Fwkb3+Em32k9NkE37Jeb+2SiA=;
  b=OYIXmjw7RM2xeDZCEyvq+ElOu26irnzenTK/u97LPAQmE7AGG6pmm8S0
   4in3JVfSM3oOnAk0EPMR+0BmE7JWJqy39ZIJm9WHQNcgRYLIMIdej4qe+
   9m0QyFox/3v3ITFaLKQvpNchBKqVixeHE5ky70z3yUuNNz1pXBsQzxCC1
   9wSauzYaIKx4+/ITemb7ak7YPQtqTtAlnux+BbmFZmX17SG9NKhBH1h+F
   KG8B3zsI+VBk47QyGi1eUXvi5k3FGnOf2CCm0mZz6Cfw/RmzxYQhf8w2H
   jgxTSDXolv69YwkBPt8PdGmd2XgPodY8q+DbIjoeEz2DaN7AG32r91N4E
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="355809062"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="355809062"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 01:12:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="969785038"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="969785038"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jul 2023 01:12:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 01:12:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 01:12:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 17 Jul 2023 01:12:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 01:12:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OosnNEyqBTVtypWNlOkr73iaqhR6z2jtuHARbAKwVzBVNq83jJpRKyONGR5GFORKo/wDTyK8XQSY2InXLL7+Mwn5cpyAgyaj6BKRo4eEiAGQ2+PNTDa50kV/gsUygX59ffoy7GVUQg56BtJdMS4mgi+Yyl+h6GLRja1HK8DQQsOBT4wOLVkYFd3CWVn4p8YJLc28t1SaJzCZHdR50lOwEtuENSnWwT739blEqfp3lYpexdNINexpVzE0iad0llDZijGaVSWVs7qnZniM5l8svpDPraITXqzeVlom6eMm94BlRh2NgjORGJihabYBGzCYj+BrGcyc9uNRai4RwDLMYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eC7DF7TNoS2aNW3KM+8jQbSkR4tdJnjUAJJ+Ur4CbuM=;
 b=TEnnBJG10PCUWM3YIq5vJuKhu1Gyu0xnZn+NVMT5nZPU4bemKnrY1jOGCGzZ8AQ4qiiimcruVZTWpjTdiOwyuzJsSXSD7lgusTJuVGiQeyiTj/r4AU5bGaO5fm0GsVmX9BlrJKZEiUU8cgoRcxvEm3YxRwMPdrNWtMdtllqw+PboWqU/X6cDpeHrr5cGDEHOaAGmU3pOu99u/GNyQPdZ3LLU/959PfPyPHcbkolEfkDSL3N81ZD1x/alNUTI0rDaytOZ6iyh0LnD7+dc4tH+KSlYoDghO1PzdrklgDmCSi5HxIjfmivkPh3wYx3l0KrxlXuUgRStreQuwnrRxYD24g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MW4PR11MB5871.namprd11.prod.outlook.com (2603:10b6:303:188::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 08:12:43 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 08:12:43 +0000
Message-ID: <d93030e9-938e-f394-8067-a7307f6acd30@intel.com>
Date:   Mon, 17 Jul 2023 16:12:39 +0800
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
X-ClientProxiedBy: SI2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:4:186::6) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|MW4PR11MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a4e3c80-3663-491e-8bae-08db869d981f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UdOI+ijfGgmJ9m85kqcqBeFOEkZJAx+RV7Zx2nUaBs2ENGVFmN7yb3n8YNIZBqtnU+OMo7ghEc+y3//kqBQe+WwB6olpga1hbWOgmJH+uw6kt2jBc4mQqb+bsuXMqO0o1B29ca8i0JbCdrAysDlmnwrDIzYGFTrEMXdHbfMw2y7g8QFAOTN8wyU0T6sQ4MLfT46V2k6VeqTjvw5YZ4l8HASc7Ld9n4Mmr4P6ZC8t7wAj7StezNQulHqAkr/69njLxu03o0QyC0kFAH4bObG516cSKMN+0Nn3BvVXTCb14DBJBnr4/Dqk165W7TiJvYBdfmZjcqcMIVhq/YQI7vqxFzD0fPLA4QDVerCnqBE6+mOnYdsVOQn5FGSagIkxGqB8c6izgGWvrFaKutL3dJLLrS8hCT5ISwbDtVJH9l4mw0v1kRwmByIBVBlVgC/a1XYvbnm8JEojHl49Rya/yq6wda4gZbpmJ8OltseK/WMmSj2oATrnMpJa2NNmtr4oM4CBA3p5+f3J5D1ke39XG5TvQKG7caW6bE/KAuJISADOeEQ1cPuad/uPHkWA+1EjbAMAa2VgoUX/SBVkmVBIfpdqPulWn6STNAV99lhSYytD9m4kaL9ZjvbatdYKz3fLSE2+rzrOZeY+32ft7v/LjoZdhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199021)(316002)(41300700001)(83380400001)(53546011)(31686004)(186003)(6512007)(2616005)(26005)(6506007)(6486002)(478600001)(82960400001)(6666004)(4326008)(6916009)(66946007)(66476007)(66556008)(38100700002)(86362001)(31696002)(8676002)(5660300002)(8936002)(36756003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWxOQk4vNVhWMG5mNjA5TjJDYU9OcCs0TkFKdHh0bSs0aWhKRWR5V1VZbDlN?=
 =?utf-8?B?L2F5NnE5OUJYT3VsbUpocFNuUlRjZ3VWa2wrcjJzTG1rNVFwM1NxaC85dmo0?=
 =?utf-8?B?MGZTV3hVMDBQRVByMTY4N1A2NUZBMTBaVUx2YzI1eEtTRkJ4bFhnSDFEeW5o?=
 =?utf-8?B?eDJtWVh4a0ZlYWRnOGlxRkowVlIrcHpTM3pueUVOQklIa01wOWx3RzRZTjdp?=
 =?utf-8?B?V2FkQkZ2Q2NkSGFabUZVbk9sQ2MwRE1rSTFUNENON1pnTm1TWHRVcmxwWUVK?=
 =?utf-8?B?TmlxMytwK09aZmNNbHZUWFUwcUR3eThYVElSanJ5TU9VYmRDSEJOaFAyVXJu?=
 =?utf-8?B?SEJRZUgyWGxSYi81TmVzVWtGY3VTWlZuV1ZkOC9tUkpuTjVHdlVtaTJ1MmNW?=
 =?utf-8?B?OE16TWxmV2FuWHI4VzltUVV2Ymt1elMrWWpJV29KRnZLd0FycXVQaUU0djR1?=
 =?utf-8?B?YXA3L2JYWWtJbkkrcHpwaVlWTkp4c1U4V1hPL0FTQWI5R2xYOWIzUWhtRlFP?=
 =?utf-8?B?enlCUnNaMWsvNXN6ODBvaitHRkpZREE1a0RkdTVpUXArN0kxN3NSYVBtRjNz?=
 =?utf-8?B?akdNWXk3N0YxdHdiQlQ0SUZtODhHekVjVU85Z0MvSTB4ZGdQcDR4VU9EbEVT?=
 =?utf-8?B?eTNpbzliblVCdlZLM2tZUkdaa1B1TTdnaXIvY25vTnZHM0VMZHljbVNmR0Er?=
 =?utf-8?B?bVpOWDVYaTY0R2htR0liOG01ZXZxbjRZZThXMVlQL1ltbzlVVDZDaGlsZnJF?=
 =?utf-8?B?dk8wV1Q0N09CbGhBUHh1Y3JJNmhtRzdxcXBkck9jRnc2aUZaYXh6NWRNQ21B?=
 =?utf-8?B?TXJ1YkFxOUpSamN6ODZ2L3dFaUY5SHFPYXQ2Y0ZUY3RaVVY3dFBxdVRGVEhL?=
 =?utf-8?B?alV1RWYwRTZ0MjVXR3VhZzNmYTJZVEh6T1d4UTROTG9FeW9WdVBxY1NEUWFU?=
 =?utf-8?B?OWgzMTU0R0RzK3lMcmNYS1hjTG9hZkxTRStPc3UxdUY5YXlpeDI3bzltQVBm?=
 =?utf-8?B?WnM2SjhEVzE0MWJKZDZPTU52L24wRkkwbldhTFUzdzJEZnJBM0dOSVVxaEk1?=
 =?utf-8?B?K2ZBTXp4Z1dJNnhtdHBRdEwrZmhOb041NFBRMGVDVTBOTTlVQzdxYjBHV1V0?=
 =?utf-8?B?dU4weE5VOXgvRHJrRGFDUXk3akkyWEozMnF1RU9Ja3hpak4xMFA1OEMrc0hZ?=
 =?utf-8?B?NXRuaFpWZEg1YWRpMnpBa1E1L0FDN2pZYmJENllVRk5lV3J5NThpTUZINW9F?=
 =?utf-8?B?RkF0L3Brbm5IbWVqaTZUeFRvNllHVlMzSkxkQ1FvSXFRTUhpdi9kVGZNcCs1?=
 =?utf-8?B?RUZVTjdHUzlpbWgzSFgwZkIvQkpVNHM2d2RQcXpnam9uUWJLVU5QcFBUSFpU?=
 =?utf-8?B?UjZHcU1nMkVWT3NNMjF4d29pMCtWTzd6VE1DQXBrNmlNS1ZsVzlaWEN4cFpB?=
 =?utf-8?B?VDRwQVRwTjdJK3QvRm1ZZVQxRnJKSGdFbmpvUkxkeW5uZGxCUDRibDVrbGZU?=
 =?utf-8?B?c3FmY0N3S0NQN05mT2IzZFRkN1JuY2FPQnp5Q2MxNDJ2N1AvOUVQRVlObkVw?=
 =?utf-8?B?S3NPZkVyYUl5dzhYWXFkRUxzNGxFTElNNENXQjAvMkl0UW5NRXoyR0RPQ0RD?=
 =?utf-8?B?Y0I2ZWEzZzRVR0h2YytEWHJJZEZ3T2pUcEkwMU94Rks4QS9yTkxYL0ZkQTYv?=
 =?utf-8?B?VGVuMDdITTFmUDlnRFhYSTJ0Nk9qbUNPOTdvRzdib2hORGNFNjFsN2xmWm5j?=
 =?utf-8?B?MFM2aVRYcWRnZ2l1bC9MQWZGSUs3SW0rOEJJR0x6SXRjdjdxTjM4NVpEcmw4?=
 =?utf-8?B?U0FINmhpQ2gzZ3RuWnhQNTVYTWkvS0NnbDlTUVJDM0RBUTNQZ1NyWlltMTho?=
 =?utf-8?B?dDJvVkEvNVpBTFR4aGhPQXUxcE05RXBIS3dQWFVKdVRXT3hwNGtGZXdJQmEx?=
 =?utf-8?B?M3lGT1QzaFNKRkdQN2RUQ3BkMkQrVE9Tc0NTNDgyMi9qc0g2NW9JTEgzL09t?=
 =?utf-8?B?d2Z3YzFaMm1ETTQzeS9uY2tDSTRUUUFGUWFWS0M0cWNjTFNrd0ZvMVk2QWlF?=
 =?utf-8?B?MkxRWHBKQmowS2tkTmpLdEVyWTgxeGFTOW9RUTgrS0tNL2NBdWJVOUNsRFFy?=
 =?utf-8?Q?aMeBsjt1806LrNyWFjRgy8owc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4e3c80-3663-491e-8bae-08db869d981f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 08:12:42.6021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MICP0amb18oJWK27C78Y+nWZx613VXzdKctEVAB2OZgB5tBP9QSZSyPyK2JLZD4lWnezTNyZ+w6mpHXrK2hqNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5871
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

I suppose normal 4K page can hit this problem also and following patch could
fix it:

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1080209a568bb..839b8398aa613 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2498,7 +2498,7 @@ static unsigned int move_folios_to_lru(struct lruvec *lruvec,
 
                VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
                list_del(&folio->lru);
-               if (unlikely(!folio_evictable(folio))) {
+               if (unlikely(!folio_evictable(folio) || folio_test_unevictable(folio))) {
                        spin_unlock_irq(&lruvec->lru_lock);
                        folio_putback_lru(folio);
                        spin_lock_irq(&lruvec->lru_lock);
@@ -2723,7 +2723,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
                folio = lru_to_folio(&l_hold);
                list_del(&folio->lru);
 
-               if (unlikely(!folio_evictable(folio))) {
+               if (unlikely(!folio_evictable(folio) || folio_test_unevictable(folio))) {
                        folio_putback_lru(folio);
                        continue;
                }
@@ -5182,7 +5182,7 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
        sc->nr_reclaimed += reclaimed;
 
        list_for_each_entry_safe_reverse(folio, next, &list, lru) {
-               if (!folio_evictable(folio)) {
+               if (!folio_evictable(folio) || folio_test_unevictable(folio)) {
                        list_del(&folio->lru);
                        folio_putback_lru(folio);
                        continue;



Regards
Yin, Fengwei


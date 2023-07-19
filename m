Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835E5758B25
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 04:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjGSCJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 22:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGSCJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 22:09:57 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AABD12F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 19:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689732596; x=1721268596;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EQiUyhfTI2mSDAMRsT32pv4/ZpmxUFsAry79dtRQru4=;
  b=YnGOvChAqunasMO4Ptnk2JdXaSxee1Xj1UMuXxeXxXQCv1e+/6EPhnyd
   v4BaQT2CuCmh8L/37GsK57nounECMZ3nGVGWXMaS5lx/rrueDCCSKYcpA
   z2t93ziv1IGfd6tc4/kJvNn0J6T64N75mb1ZoyvrL7uUUPrrg0nFnv2uc
   pDShP3svgPReLsKDQNN7iHqBTD6TUyXn3wgpb0lyYeN90ap6s769lZ4qy
   jOxVOJ+XmG/QCs9r7chFgqZkr95RjGRWSWHlQ/w7tjCoHVlIw4Gankx+i
   CvlE9wpuAT27eidtgn8lAmFd5O7rg5XYgRSoaIlVxr+EKDVgtIdiFzA+9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="430117802"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="430117802"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 19:09:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="867293577"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jul 2023 19:09:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 19:09:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 19:09:55 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 19:09:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GK4jAs8w0G4oy3qCoUSPRRqrSq3Te6uLd731HaCk7G0vHqEhW9lEgU/Pfwwj7FZxBE4pw7ZcbG78M6L5VdeiFoP7Ow68d5Z2uXuBg4/1Fka5cYqp2cnHn0WR4lrmkr9c2vj6d+r6yKc41fsl62J3xI/OYaVhzVS/T9nRG26AjzGW2EtOOhFd3DUChNiwLkSLiAfgNmFt3Gz2xpJBFJ+RqSIfecZmccLN+cy3E2n0nLQ+6UD37IqsZEyEooI+57zxWkGoNAB8f/VNJQ5EY6IX6wdt8+WAuqIQwgiTxXILpIBgFlO0ftNeoB+rpn4xClWwkBqvjDyVmvJyXh25+lg5qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tguEC2nzAwcsVHlW176tsJn5+6XvmHXUSA632qTUiyU=;
 b=VPFnGZJZJZCG2Pmql2GXVVHO+cYMBBcwo8YwYZf+jGYzC5es14751ueznquqRQwQFuhgIL82pjmZ8JTK046WHxSkwPMHAwYNLjwQM8GTHGR0BAHKbtNZBRYCL4zR0aoRJyfedpsSPTYV9JoQViguFEKI+pZ3mX9ND8imNxsy0ggcch3Qcy+qHQON963ZMd2INf9dnrranWmdokH5HzlpAWTzKROAq3nNf23qsJh6EiAPwQ2TzB8V9zgffaknQmIezjn0F187cBvYgvZy+2NgEtnVNnHqzsOXgKBVjl9r7YygPNlXuz++2qM0Y9QWu0Ms4sXjsqewoxcA90qWJ3UVWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by BL1PR11MB5224.namprd11.prod.outlook.com (2603:10b6:208:30a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 02:09:52 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e%5]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 02:09:52 +0000
Message-ID: <438d6f6d-2571-69d9-844e-9af9e6b4f820@intel.com>
Date:   Wed, 19 Jul 2023 10:09:53 +0800
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
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <CAJD7tkYT6EZMwit8C9MTftUxMmuWtn2YpZ+NSVhy0xVCYuafsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|BL1PR11MB5224:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee32cd7-f1eb-437f-04fc-08db87fd3ce2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t/jna7wOxJSP9ncBxyKFeCxGshLBJ8HT5yuEUvQMM0MXhh1pV6ZdR8ZSc6vQ50KYaQAQ1R7l5rUhE+bLLSDhzFVl673yJghL48xEZyDztFiTb7gOn+7TrRN+lekTBdMkAS67KoTcUciZ/5Pk9l1dPvHgSAHWhyqDQUXYxPN/vsARYxDFKcqp9zgyy3vRUSIiYpq6CVU87ApXteTByirr4TXgZ+MRid9Fvo3DAaLr1p9dYoSyleDZpbLMX62MarFcK+kg70Msv8Y4uWdM57oeD6n12yOFSxooMp3/HojZ5kGaRVuqHlbtGQBCjD8z0Rleoo1gQsFFnIsehTa2NH9G6ZoOXNb1vaPVO2gh7jGMa8+/GjudNMF/wnBHX5fHv0XHzJFFSd3MQJCQxtYDJjyiymyOVT+fWENi5Y6aW3UHHCsR3coaxzHQXnU3xoh6jaFryoZamDpnVY+OSxIDQAKZ5NNJXhMHdY1tTYMVvFDVfqIIRbnvc+drlgBNk0X59XpPLqSgncwwDCYuro90BC7TcRa6TSHB6En6oj5yyA01GUZScn9wWVt9FHjaU7vbCKpG2StiEgfjgR9ugI2rmixnV+2mLTcBAtGO45xPNQ7OqG+bNdLzwM0Rf5gncHMG/bVymvJndKlOI37C4CKqQu5hfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(396003)(366004)(136003)(451199021)(83380400001)(54906003)(26005)(6512007)(6506007)(53546011)(36756003)(31696002)(6486002)(86362001)(186003)(2906002)(2616005)(478600001)(66556008)(6916009)(66476007)(4326008)(316002)(5660300002)(66946007)(82960400001)(8676002)(31686004)(8936002)(7416002)(41300700001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFVjQ2w3WWEvQXR3WGt3dkFqN3hKV0xrZHVOTXN0TkVYVld6UDU0QVZ5Z2lE?=
 =?utf-8?B?RmV1QmJSSFRnbVFhMjdGS0c0ZkRtT2J6RTdaRTZUNEZWU2Z6UVA4bUpzUFZi?=
 =?utf-8?B?MjhMeEt2dkJxeC9HNCtSb3VmOU9qYTRJN0VPWDFubHpuZjhMOEMyTlIyR3l2?=
 =?utf-8?B?UkdEVnZwcTErdE54OEJITE8vT25QOVpjdzJxQ25GV3M3emw3aDlBcW84c1hs?=
 =?utf-8?B?N05sc2tWcnFUeDBGMFVqUTRmN0hQL1o3dWJrbVBUdFNJWERxOVhZWk1EYzV2?=
 =?utf-8?B?bmJKa3R5TzBoL0tCNkQrUzBKN2owZy9xUmJhYzFlVzNONG5qNXFSTlZlNk5t?=
 =?utf-8?B?SGgwQVY1MStNSWpLNHV3VEFVeDdXSC9CTDRBaEVkNHNhSUJhRVFIS2E1TVdC?=
 =?utf-8?B?blRPbnlSUHlnNWxkcm1VUnE2Q0lKdXlzajJHU3YvUVVDTC9zUDBCbFFqUlVL?=
 =?utf-8?B?WGhyTFF3SmxTRDRMTEgwZWtMUVNOb2paNGNlU2RGWG00SFRaLzZhOVBVSlkv?=
 =?utf-8?B?NFpOL1B6eWwrQ2g4eW5TY3lwK25Hc1Q1ckZOcndxS0YvT1RVNk4yb1piRkYw?=
 =?utf-8?B?eWlBb0RiUytVWVQ1Z0E0SGJzeVkvY0Q2WndETktrQ3l3SFJRb3JobWNBSFFi?=
 =?utf-8?B?VnhSeVRuWnlHN1lad3NHZWx3QjdzY1F2ZDVJSjZESmtyak0wcFF0Uml6VFdC?=
 =?utf-8?B?Wi8rbkx4RjNGNzd3ZXVObmFTVHMzUUdXYWpzVzZubmNnUWN2SGNDQk1Va29s?=
 =?utf-8?B?RkI0WWlYQjUyS3JOT1l4QUhicjQvSmZUTW9oT29pZ01EZnYrVUplVDYxNjJD?=
 =?utf-8?B?OXpuM0FrUDVybVBoOGFwSy80U1ViV1dGYmo5RXFWaGE3OFF5Nkl5eFNPbUx3?=
 =?utf-8?B?dHBmcVpVY0ZLY25RYTByYWtsVnJkd3JwdVhVc1E5TlUzd1cyZ2F1Q0NoNWxi?=
 =?utf-8?B?dHNWN1NBM3kwNkhRVVZIc3pKR0RqVTNHQkJocXYyb0dXYk5ZZUpMZnkzem5N?=
 =?utf-8?B?T1U0WS9OMmJSZUJ1OWcvdi9kUlU2OHJ0QXFaR09zeGdseTIrVGR4dEdXczhh?=
 =?utf-8?B?RFJOUzhkbFNJNzdkaEJQbzNaMUxobFd6UGR2MERoY0RlYjdQekhFMGdIeC9o?=
 =?utf-8?B?TU1uS3NIUUxDK0kyNjhGSWwweXhkNldNUnI4TFJ1aDRSaHdjWmdxWXJJVGNN?=
 =?utf-8?B?S1BhTkVoKzU4SG5WdU9KemlweGtDTFFETDl1WTBMT2tnZ2llemF3UHhoNElE?=
 =?utf-8?B?ajF6czdxMjBCdkxJalBzL1dwSTdJTzZOSTdha01aRldsWjlpWFdHSEJuZjNx?=
 =?utf-8?B?VTJuMExiUkRyU0VwTlVsRE5RVTJPNWlSczZkU1dxR3FPN24rbEVXWGV4dXZr?=
 =?utf-8?B?TTBiRVVsZHpiejlzaHUza00vUnlkZU9TcjZIUzJ4dHpxUFFiWUpyTnM0Y1pG?=
 =?utf-8?B?ZGRidnZicitDSVR2MHZKMVQ5cnZUbUdtMXdsVFlXYzlubW8xc0R5YlR1T3Vt?=
 =?utf-8?B?TXhDRnBKekJValNwMkFWL1g4UC9XM1FuS0hEN1VheG9yY3Jka0VjYlI2c1cx?=
 =?utf-8?B?TTNkN1czR2l2bHI5bFJRcC9IU0NONUFIMDN5N0gremRGS1ZqNGNxaEh1OEhx?=
 =?utf-8?B?RGhLQ3dNRzFhWW9GZVZLWnZZQjZRNVZaM1pnOE9nc0NtZHc5bkZlRndwZnNj?=
 =?utf-8?B?dnZBaG1FV1EwOUc1bHJEMWE5Si84V2tDQXNyQmpiTW4zUXpLMTJacEFRL0Ja?=
 =?utf-8?B?UXRHWXRZT1lESHJPVDJ6NkpHUEZ3TjhuZDBDWDJiTUtqenRFSDhlaFBRbENR?=
 =?utf-8?B?em8vT2dYRmZvb3Y3MkZhQTBlRlhRbjREbExrRTNlSFVkT1VkbnM4VnplcG12?=
 =?utf-8?B?QWhPNVpwVVZEMDQyOHBHTEdVV2NIQlhYZU91b3F5SlZrSG5aYVNsZjRTOStW?=
 =?utf-8?B?SFZMY1dRM1daaEQ4VFZiQTFhdUh6V1RVVXVmdUVUalowSmcxWnF3WGgrMTNh?=
 =?utf-8?B?UnNobGdnVXI0TUNwMzl1RmI0Tmt6TVZGQm85Z3FrOWRvWEJGL2JEc1pNN1lS?=
 =?utf-8?B?L2VYamFrNkROTTJVRHJMQm52QTFHRUpkSXM4aUtqOGtmR0NqSUZSSkxhczBr?=
 =?utf-8?B?eHlEQjRBWGlmeE9MRHBhN3pXUEkyalF4UElPdkJQV1NkVndJRDkrSXFkTE5K?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee32cd7-f1eb-437f-04fc-08db87fd3ce2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 02:09:52.3561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgcG0HKwlpnneHVA1iBgP+7TrJVUd0889ao6hUHR0EeuxH30MVqXlQzsyhPen9dtRpTDeFrUaqw4gvn1LrwK7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5224
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



On 7/19/23 10:00, Yosry Ahmed wrote:
> On Tue, Jul 18, 2023 at 6:57 PM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>
>>
>> On 7/19/23 09:52, Yosry Ahmed wrote:
>>> On Tue, Jul 18, 2023 at 6:32 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>>>> On Tue, Jul 18, 2023 at 4:47 PM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>>>
>>>>>
>>>>> On 7/19/23 06:48, Yosry Ahmed wrote:
>>>>>> On Sun, Jul 16, 2023 at 6:58 PM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 7/17/23 08:35, Yu Zhao wrote:
>>>>>>>> On Sun, Jul 16, 2023 at 6:00 PM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>>>>>>> On 7/15/2023 2:06 PM, Yu Zhao wrote:
>>>>>>>>>> There is a problem here that I didn't have the time to elaborate: we
>>>>>>>>>> can't mlock() a folio that is within the range but not fully mapped
>>>>>>>>>> because this folio can be on the deferred split queue. When the split
>>>>>>>>>> happens, those unmapped folios (not mapped by this vma but are mapped
>>>>>>>>>> into other vmas) will be stranded on the unevictable lru.
>>>>>>>>> This should be fine unless I missed something. During large folio split,
>>>>>>>>> the unmap_folio() will be migrate(anon)/unmap(file) folio. Folio will be
>>>>>>>>> munlocked in unmap_folio(). So the head/tail pages will be evictable always.
>>>>>>>> It's close but not entirely accurate: munlock can fail on isolated folios.
>>>>>>> Yes. The munlock just clear PG_mlocked bit but with PG_unevictable left.
>>>>>>>
>>>>>>> Could this also happen against normal 4K page? I mean when user try to munlock
>>>>>>> a normal 4K page and this 4K page is isolated. So it become unevictable page?
>>>>>> Looks like it can be possible. If cpu 1 is in __munlock_folio() and
>>>>>> cpu 2 is isolating the folio for any purpose:
>>>>>>
>>>>>> cpu1                                        cpu2
>>>>>>                                                 isolate folio
>>>>>> folio_test_clear_lru() // 0
>>>>>>                                                 putback folio // add
>>>>>> to unevictable list
>>>>>> folio_test_clear_mlocked()
>>>>> Yes. Yu showed this sequence to me in another email. I thought the putback_lru()
>>>>> could correct the none-mlocked but unevictable folio. But it doesn't because
>>>>> of this race.
>>>> (+Hugh Dickins for vis)
>>>>
>>>> Yu, I am not familiar with the split_folio() case, so I am not sure it
>>>> is the same exact race I stated above.
>>>>
>>>> Can you confirm whether or not doing folio_test_clear_mlocked() before
>>>> folio_test_clear_lru() would fix the race you are referring to? IIUC,
>>>> in this case, we make sure we clear PG_mlocked before we try to to
>>>> clear PG_lru. If we fail to clear it, then someone else have the folio
>>>> isolated after we clear PG_mlocked, so we can be sure that when they
>>>> put the folio back it will be correctly made evictable.
>>>>
>>>> Is my understanding correct?
>>> Hmm, actually this might not be enough. In folio_add_lru() we will
>>> call folio_batch_add_and_move(), which calls lru_add_fn() and *then*
>>> sets PG_lru. Since we check folio_evictable() in lru_add_fn(), the
>>> race can still happen:
>>>
>>>
>>> cpu1                              cpu2
>>>                                       folio_evictable() //false
>>> folio_test_clear_mlocked()
>>> folio_test_clear_lru() //false
>>>                                       folio_set_lru()
>>>
>>> Relying on PG_lru for synchronization might not be enough with the
>>> current code. We might need to revert 2262ace60713 ("mm/munlock:
>>> delete smp_mb() from __pagevec_lru_add_fn()").
>>>
>>> Sorry for going back and forth here, I am thinking out loud.
>>
>> Yes. Currently, the order in lru_add_fn() is not correct.
>>
>> I think we should move folio_test_clear_lru(folio) into
>>
>> lru locked range. As the lru lock here was expected to
>>
>> use for sync here. Check the comment in lru_add_fn().
> 
> Right, I am wondering if it would be better to just revert
> 2262ace60713 and rely on the memory barrier and operations ordering
> instead of the lru lock. The lru lock is heavily contended as-is, so
> avoiding using it where possible is preferable I assume.
My understanding is set_lru after add folio to lru list is correct.
Once folio_set_lru(), others can do isolation of this folio. But if
this folio is not in lru list yet, what could happen? It's not required
to hold lru lock to do isolation.

> 
>>
>>
>> Regards
>>
>> Yin, Fengwei
>>
>>
>>>
>>>> If yes, I can add this fix to my next version of the RFC series to
>>>> rework mlock_count. It would be a lot more complicated with the
>>>> current implementation (as I stated in a previous email).
>>>>
>>>>>>
>>>>>> The page would be stranded on the unevictable list in this case, no?
>>>>>> Maybe we should only try to isolate the page (clear PG_lru) after we
>>>>>> possibly clear PG_mlocked? In this case if we fail to isolate we know
>>>>>> for sure that whoever has the page isolated will observe that
>>>>>> PG_mlocked is clear and correctly make the page evictable.
>>>>>>
>>>>>> This probably would be complicated with the current implementation, as
>>>>>> we first need to decrement mlock_count to determine if we want to
>>>>>> clear PG_mlocked, and to do so we need to isolate the page as
>>>>>> mlock_count overlays page->lru. With the proposal in [1] to rework
>>>>>> mlock_count, it might be much simpler as far as I can tell. I intend
>>>>>> to refresh this proposal soon-ish.
>>>>>>
>>>>>> [1]https://lore.kernel.org/lkml/20230618065719.1363271-1-yosryahmed@google.com/
>>>>>>
>>>>>>>
>>>>>>> Regards
>>>>>>> Yin, Fengwei
>>>>>>>

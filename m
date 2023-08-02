Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBE076CF32
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbjHBNvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjHBNvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:51:21 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086CFDC
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 06:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690984279; x=1722520279;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OuVhBLDzlrEY5QSqpx/BJiA9NkVpEibbkakNAngzFH4=;
  b=XxgpZ0IHzbEWNBbWhFrxjZ1ZKpvo8Dsjev/9ifb9n7JBL+S/YOmm6kBU
   3D8Jtt9qYTaVTHQL0lboXmyZMKQ5XSNJoM5At4RrePVMjFRn7JYsCIPyF
   KhOJ2he56gozcXFPy/PBh0AaZfXTBFchvgF/2XjJwEju9sDxeINqy07L+
   22uKCWEMhexASoCJgcm096qHXg7zbXxCut0hI0oIxpd0mZTK4NNXM1VWB
   IwjhAgio4FNF9fZHFP3HOjJlg2BT86d6sjiNXvLBAvDjhOTB5et9HGuQx
   +HCtAD6PolVhZGwSX4aJmq+x2xg9kT2o98j591TlVUCgc9iWIoALaTOsQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="349887829"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="349887829"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 06:51:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="722861118"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="722861118"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 02 Aug 2023 06:51:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 06:51:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 06:51:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 06:51:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGxdpVPEwvE2G/vheY4TqavFgKvtRcxtQpKbTBk/fE+33r4pgNtIpIoNrIlTLCYET0IiXJh+3i0/w2MAuxvGcJeGNLlNkFYNWgwU1UxcsVAWXOzW0D/pr9UhqjQommyPnytfmUSkN556bnGazjbwezwGoKQdoy0R/0ny00O6hTXsq3C5Ngn4lgp4aY+RQgPfGPntxB26tra19Rq/g6PHSD8MTVhdg3KblsXyZl6eCzcVG6RNL4s7UCHpBTOE7t/lpJheJnuUhwaJYuZEVGyx2CcWJ/OxnBgU3SUh/wbzQVvtYUQkHy+/spwsfBE/+/g1J0JL1sGxY4Bt62EU20VojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPpFNzesyRTOiYipocDcdLL/KE9IKXmwkE0UIvDpKfo=;
 b=mwGlBdm9o/faSHh/YqYbWcZpQWOaGISm8zbpkTMt4rjxfYMOdMHvb48/HF1bMjkq5XNhaQg02Bb5MJVqa0AF/6/LawJPGSvTdOhuVXY5JulnxsZrLdy2uYI0UcDV/FTWMuqSA38gnYE50rWFHJO6oUtxaZf1639GzWyuu1jAjd4+GvOkAyJM2lfatT8MqUWYyQcycteduUd4usKcsZ9ZuL+bkgIu3VsfdHyDFsPPdBeSYRAWgz4+QfwnQGJ8zy6YOvlcfrBNahDt19Wb0xOofnY7jNXOavw8DYbLkCC27bVyUgsgfV33iuK7l2Rq40uJEnpDyjii8Wlc0MjhxL66cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SJ0PR11MB4975.namprd11.prod.outlook.com (2603:10b6:a03:2d0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 13:51:14 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 13:51:14 +0000
Message-ID: <83f8e273-6d28-1986-99e6-df574f5e04ca@intel.com>
Date:   Wed, 2 Aug 2023 21:51:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/5] mm: LARGE_ANON_FOLIO for improved performance
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, Yu Zhao <yuzhao@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230726095146.2826796-1-ryan.roberts@arm.com>
 <20230726095146.2826796-3-ryan.roberts@arm.com>
 <CAOUHufackQzy+yXOzaej+G6DNYK-k9GAUHAK6Vq79BFHr7KwAQ@mail.gmail.com>
 <CAOUHufZ70cMR=hnMW0_J9BeWRPwXVUDoeRhES+wq19r1SioGuA@mail.gmail.com>
 <8c0710e0-a75a-b315-dae1-dd93092e4bd6@arm.com>
 <CAOUHufb8D-8qOhB55WhHgX5dOgrPcrpOZhiA7q9JMi=w6cqEoA@mail.gmail.com>
 <d628df5d-9ff6-f830-ba72-a2b7df7e5d51@arm.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <d628df5d-9ff6-f830-ba72-a2b7df7e5d51@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SJ0PR11MB4975:EE_
X-MS-Office365-Filtering-Correlation-Id: d8ee4a82-12fb-45c0-936b-08db935f8947
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/P3haZqWKHTUXh2+4ezh/9/8ZNag87Ccy/7hf+/6WGw8X6LoBHttOII9o3XotJBuIAJIaa/pKmZJFcolM6yO4CCayvJ04gIj1JE0t9KbaJ2pImsHjrZYGvG7Lt7q0/IIUbbNTmgXFjZ2FPOr6VE96l/cxRujYwthj2ZvuK5PhroOXMqxdtnZXCleJVmw23hDYZM9QqUf2U/SMkqK8Pv1Iq1eSwopiUYUZBk56dtLhtvm6nQWza+lB3v9NDY5Bkhc2WqRymw+aQJz4bTxkpLX02pZQTOFwg0KQQbkqFhWviqL/rTB7NnkpIpZ5qs7Ed4BfkbRFnezbQhpUL9yCZ65tGV+jcIz/p5ffXxQ3VYYSJE6xzB+4tGDv/A4xfUQuPCEFyvfi8PRi0NWoKh69C9/hhF/jTuxZ8iGx0uM7ScYYRPMLr+ykDa8u+kAlPyq/4uUOT1XeBqbG8/ORZvLSb2StUbFvwbWoNJIyC2A9b77n6GWA0Ejj3vUc0Vzh5U9XyQL4C/MS4jSPhRwn/lu1b/dCXa4nety5gWRpKwgmo08ScOFw0ZTSzBTKjxeQLPHTESJzUnM7Qp8RbuMrZO92wdE0vTJopgww8+Q3TZqx/wkwa27ivFWr5mGZp0H9CCWKcspAqhwnWdUj7NdUkDWr5/sOPNfVpW1Clwh3hniFPIn8nmfkSP5SD4HphUnyZAus4A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(8936002)(8676002)(31686004)(7416002)(30864003)(41300700001)(5660300002)(66899021)(2906002)(83380400001)(2616005)(186003)(86362001)(478600001)(54906003)(110136005)(316002)(53546011)(26005)(82960400001)(6506007)(38100700002)(66946007)(6666004)(66476007)(66556008)(31696002)(6486002)(4326008)(6512007)(966005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dURKWW1ldXV1aUJzT2FoY0VhUHp3MkVySlNGam5icXN0Qll3U0krcXd0QkJO?=
 =?utf-8?B?MjJJZW5kdlRxSlpaYzZIRnFTQ0piRTQ5M2duZnp2cTdpTTgyVDlheHlsUEtH?=
 =?utf-8?B?SFBFN3dNWW9yMU1JZVFYbSsyVzZ3VFloeE00OU9SRGd4RG5rYUJkZUhqNDgy?=
 =?utf-8?B?d3pUcTh2MmlxanJLdlduTkROd21HSVpROGVPeGQ2Ry9lbmg3d2pxODE4eHhS?=
 =?utf-8?B?LzZqRW8zbWgwNlM1YlJySExmMDBQT0ljQ3JxQWdKWFdmYkZoNmJuemJ4SHk3?=
 =?utf-8?B?dVZqOEZmVmtncm1mcVMzZTcwNm5JSS83QzRDYVlneDFNdkNIMDNZRVFZYUJR?=
 =?utf-8?B?V3VucHlNWWEzaVZXSDk5L0hmWDlDemxrRThuOC82NU0wbGlEQS9rOTJkdDJo?=
 =?utf-8?B?bFNlb3V5bWhnSVdPeWJBc3RCS2oyWTRER3JCNzFibHEvQXpDL3JGYTlqWUdH?=
 =?utf-8?B?bFg1eVlrOXQ0Q25uZ3lrU1hFTlQwdmpiWW1VR1JVQnppZXM5RXBPRGhBeHo1?=
 =?utf-8?B?R1RFa0c5WERIakZyUEpPYWRFdEllVnNYemRidWZ2NmQ3aHpkL2J6WkxMZENP?=
 =?utf-8?B?dmIzdWRucHhtdXBmdGw1Nll4WExpYkZvSGgyL2FKUnBScmRGS1JRbEFYMndv?=
 =?utf-8?B?bUt0bUwzNzdyRU5ZRk5wRER2QzEyc1dacllzYXN5aHYrOGFqZi9YN1lYZUVI?=
 =?utf-8?B?WXQzcDgyWTY0ekdaWUJydGVPaDl5OHVUa0Nqb3ZPcHdlc2JqTHUwL25oSlJu?=
 =?utf-8?B?N1I2clh1R1ptMkRrazgwTUVRWS9WdC9FSTNiVFB3dWFwZ3VqNE1hSGcvbEN0?=
 =?utf-8?B?N3JNQ21wZzFkSkJXTTJxYmYzNlhSS1ZHUTR2TVd1b09zOVA3cC9mMXJSaUZq?=
 =?utf-8?B?bnE1VzZMQzd1eTA4NUhjWGpTTzZPWjF1bGovM0dWSlk2V09MYnpoSjgrM3hL?=
 =?utf-8?B?WWlUM0Rna3lTdG1Zb0VmTFZaS3JkYmxVOG1RclczVkJ4NE0yYnEwZlJDakd6?=
 =?utf-8?B?bWJJb2FScEFjSFA3YUJOcVVReFU3SWJsWUZZRU9qaDZEL1dzWXVpMXR1QXBJ?=
 =?utf-8?B?c21VUHFwRDMzKy9BUm5KS3Z3TFBjL3M3bjhaL1FCbHFLTjFKWmJoR2dOUTJH?=
 =?utf-8?B?cDNtUDR1MlhSUVVBTms2d0U3d2M0QVBad2hyS3krR2c4Wm9KN2Erc1pPY2Vt?=
 =?utf-8?B?OVZRSkpKV0N5WjZVR2FyZjhwcThHTDIyNVNYRkQ1NE04bUUrTUpnRFhReGtC?=
 =?utf-8?B?Z0IrZDlYR25kVU8vVHk4ZGxSb2t6U0poV0tzKyt1K3VpdWcrZzRrdlh5cDIw?=
 =?utf-8?B?cUpsYU0xTVFMd0h6bWNDUkdYdTJ5Umo5d0lwV0REWVYxSEVTUStwRW8yRito?=
 =?utf-8?B?RE9wbXFod2Z3MkdQREYvcmJFenhvdDl6eGdSMlM0WllDeHZsMmdHTDRHQmls?=
 =?utf-8?B?bzFUcDNoN0k5MTlkL2hWM0lLWWNISTBrd0padEs1OUJJMm1lMUt5ZDFPbWxK?=
 =?utf-8?B?OHJWbElQcE1iRnZ4R3FGTmtSVnhjWDA0T3EvdXVHRkQ5d0UwM2tXMlVYZEJ3?=
 =?utf-8?B?blYrMWE5MjNqN016bFRaTzJrcFYvamRHT3o5UGRlemk2QXc4US9YWDZHWkNz?=
 =?utf-8?B?UjY4U3hsOGQwc082dU9RSldhRTNub0c5dGg2NmNqakNocWp3aVZteDduZkhn?=
 =?utf-8?B?a3hERlEyZ0Rmb29lWlRFbWpyVzZsdnZFWEtBVWV4enkwa29ZMUdIUk56eUxO?=
 =?utf-8?B?U3lyQXZCend1ellzMjQxb3NPc1FhRnY5TW1kQllTNlFjQSt3YldZcC8wZTlv?=
 =?utf-8?B?ZW1tZzJjMTJzSEpNMEsyZFBsSjdKaXpkcGQreUxlVFNHdGpKQTE5czZIU2ZV?=
 =?utf-8?B?bmxrUW5WU0NKbnRQb0FyeDRGUllWamhSMUx3RjJweCt4RkMxZmpiSGRzODhu?=
 =?utf-8?B?N0VTNnZIbk5naUxRZzY0c3pYZm5qaGxzcWZlZjVzVUxTY0cwaFdrMDNtaUJU?=
 =?utf-8?B?emEzTTJ0aStCZndoRUs1dVRjQy9sLzlJWEhtUE5YcWlHZnVUVm5uOU9xOEZD?=
 =?utf-8?B?UHJheFhOejVtTGJlRU43VGtMQTRWL3RoeW5hWWx0U0dXUURsTWVoS1FyQmVw?=
 =?utf-8?B?ZURZWXU5Q3c2V1hnUHZXV2hZUDNFWTlBK1ZGQWY5c0NxbURZOFYyOTFCamkx?=
 =?utf-8?B?Nnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ee4a82-12fb-45c0-936b-08db935f8947
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 13:51:13.9795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZUOOX07j7fFlvH/wZZk/o5hB8y7ZAZ30FZXWHJcI2bluDv4/x5rxkLJBcqMmTvaSEaQeULyK+nsf16vAavgs4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4975
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



On 8/2/2023 4:02 PM, Ryan Roberts wrote:
> On 01/08/2023 07:36, Yu Zhao wrote:
>> On Fri, Jul 28, 2023 at 4:13 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>
>>> On 27/07/2023 05:31, Yu Zhao wrote:
>>>> On Wed, Jul 26, 2023 at 10:41 AM Yu Zhao <yuzhao@google.com> wrote:
>>>>>
>>>>> On Wed, Jul 26, 2023 at 3:52 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>
>>>>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to be
>>>>>> allocated in large folios of a determined order. All pages of the large
>>>>>> folio are pte-mapped during the same page fault, significantly reducing
>>>>>> the number of page faults. The number of per-page operations (e.g. ref
>>>>>> counting, rmap management lru list management) are also significantly
>>>>>> reduced since those ops now become per-folio.
>>>>>>
>>>>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
>>>>>> which defaults to disabled for now; The long term aim is for this to
>>>>>> defaut to enabled, but there are some risks around internal
>>>>>> fragmentation that need to be better understood first.
>>>>>>
>>>>>> When enabled, the folio order is determined as such: For a vma, process
>>>>>> or system that has explicitly disabled THP, we continue to allocate
>>>>>> order-0. THP is most likely disabled to avoid any possible internal
>>>>>> fragmentation so we honour that request.
>>>>>>
>>>>>> Otherwise, the return value of arch_wants_pte_order() is used. For vmas
>>>>>> that have not explicitly opted-in to use transparent hugepages (e.g.
>>>>>> where thp=madvise and the vma does not have MADV_HUGEPAGE), then
>>>>>> arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever is
>>>>>> bigger). This allows for a performance boost without requiring any
>>>>>> explicit opt-in from the workload while limitting internal
>>>>>> fragmentation.
>>>>>>
>>>>>> If the preferred order can't be used (e.g. because the folio would
>>>>>> breach the bounds of the vma, or because ptes in the region are already
>>>>>> mapped) then we fall back to a suitable lower order; first
>>>>>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>>>>>>
>>>>>> arch_wants_pte_order() can be overridden by the architecture if desired.
>>>>>> Some architectures (e.g. arm64) can coalsece TLB entries if a contiguous
>>>>>> set of ptes map physically contigious, naturally aligned memory, so this
>>>>>> mechanism allows the architecture to optimize as required.
>>>>>>
>>>>>> Here we add the default implementation of arch_wants_pte_order(), used
>>>>>> when the architecture does not define it, which returns -1, implying
>>>>>> that the HW has no preference. In this case, mm will choose it's own
>>>>>> default order.
>>>>>>
>>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>>> ---
>>>>>>  include/linux/pgtable.h |  13 ++++
>>>>>>  mm/Kconfig              |  10 +++
>>>>>>  mm/memory.c             | 166 ++++++++++++++++++++++++++++++++++++----
>>>>>>  3 files changed, 172 insertions(+), 17 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>>>>> index 5063b482e34f..2a1d83775837 100644
>>>>>> --- a/include/linux/pgtable.h
>>>>>> +++ b/include/linux/pgtable.h
>>>>>> @@ -313,6 +313,19 @@ static inline bool arch_has_hw_pte_young(void)
>>>>>>  }
>>>>>>  #endif
>>>>>>
>>>>>> +#ifndef arch_wants_pte_order
>>>>>> +/*
>>>>>> + * Returns preferred folio order for pte-mapped memory. Must be in range [0,
>>>>>> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires large folios
>>>>>> + * to be at least order-2. Negative value implies that the HW has no preference
>>>>>> + * and mm will choose it's own default order.
>>>>>> + */
>>>>>> +static inline int arch_wants_pte_order(void)
>>>>>> +{
>>>>>> +       return -1;
>>>>>> +}
>>>>>> +#endif
>>>>>> +
>>>>>>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>>>>>>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>>>>>                                        unsigned long address,
>>>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>>>> index 09130434e30d..fa61ea160447 100644
>>>>>> --- a/mm/Kconfig
>>>>>> +++ b/mm/Kconfig
>>>>>> @@ -1238,4 +1238,14 @@ config LOCK_MM_AND_FIND_VMA
>>>>>>
>>>>>>  source "mm/damon/Kconfig"
>>>>>>
>>>>>> +config LARGE_ANON_FOLIO
>>>>>> +       bool "Allocate large folios for anonymous memory"
>>>>>> +       depends on TRANSPARENT_HUGEPAGE
>>>>>> +       default n
>>>>>> +       help
>>>>>> +         Use large (bigger than order-0) folios to back anonymous memory where
>>>>>> +         possible, even for pte-mapped memory. This reduces the number of page
>>>>>> +         faults, as well as other per-page overheads to improve performance for
>>>>>> +         many workloads.
>>>>>> +
>>>>>>  endmenu
>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>> index 01f39e8144ef..64c3f242c49a 100644
>>>>>> --- a/mm/memory.c
>>>>>> +++ b/mm/memory.c
>>>>>> @@ -4050,6 +4050,127 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>>>         return ret;
>>>>>>  }
>>>>>>
>>>>>> +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_pages)
>>>>>> +{
>>>>>> +       int i;
>>>>>> +
>>>>>> +       if (nr_pages == 1)
>>>>>> +               return vmf_pte_changed(vmf);
>>>>>> +
>>>>>> +       for (i = 0; i < nr_pages; i++) {
>>>>>> +               if (!pte_none(ptep_get_lockless(vmf->pte + i)))
>>>>>> +                       return true;
>>>>>> +       }
>>>>>> +
>>>>>> +       return false;
>>>>>> +}
>>>>>> +
>>>>>> +#ifdef CONFIG_LARGE_ANON_FOLIO
>>>>>> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
>>>>>> +               (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAGE_SHIFT)
>>>>>> +
>>>>>> +static int anon_folio_order(struct vm_area_struct *vma)
>>>>>> +{
>>>>>> +       int order;
>>>>>> +
>>>>>> +       /*
>>>>>> +        * If THP is explicitly disabled for either the vma, the process or the
>>>>>> +        * system, then this is very likely intended to limit internal
>>>>>> +        * fragmentation; in this case, don't attempt to allocate a large
>>>>>> +        * anonymous folio.
>>>>>> +        *
>>>>>> +        * Else, if the vma is eligible for thp, allocate a large folio of the
>>>>>> +        * size preferred by the arch. Or if the arch requested a very small
>>>>>> +        * size or didn't request a size, then use PAGE_ALLOC_COSTLY_ORDER,
>>>>>> +        * which still meets the arch's requirements but means we still take
>>>>>> +        * advantage of SW optimizations (e.g. fewer page faults).
>>>>>> +        *
>>>>>> +        * Finally if thp is enabled but the vma isn't eligible, take the
>>>>>> +        * arch-preferred size and limit it to ANON_FOLIO_MAX_ORDER_UNHINTED.
>>>>>> +        * This ensures workloads that have not explicitly opted-in take benefit
>>>>>> +        * while capping the potential for internal fragmentation.
>>>>>> +        */
>>>>>
>>>>> What empirical evidence is SZ_64K based on?
>>>>> What workloads would benefit from it?
>>>>> How much would they benefit from it?
>>>>> Would they benefit more or less from different values?
>>>>> How much internal fragmentation would it cause?
>>>>> What cost function was used to arrive at the conclusion that its
>>>>> benefits outweigh its costs?
>>>
>>> Sorry this has taken a little while to reply to; I've been re-running my perf
>>> tests with the modern patches to recomfirm old data.
>>
>> Thanks for the data!
>>
>>> In terms of empirical evidence, I've run the kernel compilation benchmark (yes I
>>> know its a narrow use case, but I figure some data is better than no data), for
>>> all values of ANON_FOLIO_MAX_ORDER_UNHINTED {4k, 16k, 32k, 64k, 128k, 256k}.
>>>
>>> I've run each test 15 times across 5 system reboots on Ampere Altra (arm64),
>>
>> What about x86 and ppc? Do we expect they might perform similarly wrt
>> different page sizes?
> 
> It's my assumption that they should behave similarly, but I haven't actually
> tested it. Thanks to Yin Fengwei for the kind offer to run these tests on x86!
> 
> Yin: I have a test tool that will automate running this and gather up the
> results. Not sure if this is useful to you? I can share if you want? I also
> slightly modified the code to add a boot param to set the
> ANON_FOLIO_MAX_ORDER_UNHINTED value, and the test tool automatically injected
> the values.
Not necessary. I started to run the test. I suppose I could share the test result
tomorrow.


Regards
Yin, Fengwei

> 
>>
>>> with the kernel configured for 4K base pages - I could rerun for other base page
>>> sizes if we want to go further down this route.
>>>
>>> I've captured run time and peak memory usage, and taken the mean. The stdev for
>>> the peak memory usage is big-ish, but I'm confident this still captures the
>>> central tendancy well:
>>>
>>> | MAX_ORDER_UNHINTED |   real-time |   kern-time |   user-time | peak memory |
>>> |:-------------------|------------:|------------:|------------:|:------------|
>>> | 4k                 |        0.0% |        0.0% |        0.0% |        0.0% |
>>> | 16k                |       -3.6% |      -26.5% |       -0.5% |       -0.1% |
>>> | 32k                |       -4.8% |      -37.4% |       -0.6% |       -0.1% |
>>> | 64k                |       -5.7% |      -42.0% |       -0.6% |       -1.1% |
>>> | 128k               |       -5.6% |      -42.1% |       -0.7% |        1.4% |
>>> | 256k               |       -4.9% |      -41.9% |       -0.4% |        1.9% |
>>>
>>> 64K looks like the clear sweet spot to me.
>>
>> Were the tests done under memory pressure? 
> 
> No. I have the capability to run these tests in a memcg with limited max memory
> though to force swap. I planned to do some sweeps increasing memory pressure,
> all for ANON_FOLIO_MAX_ORDER_UNHINTED=64k. Doing this for all values above will
> take too much time, but I could do them at a single value of max memory if that
> helps? I'm not sure how I would choose that single value though? (probably do
> the sweep for 64k then choose a sensible point on that graph?).
> 
> I agree 64KB might be a
>> reasonable value, but I don't think we can or need to make a
>> conclusion at this point: there are still pending questions from my
>> list.
> 
> You mean there are still pending questions from your list above, or you have
> others that you havent asked yet? If the former, I've answered all of the above
> to the best of my ability. My view is that this value is always going to be
> tuned empirically so its difficult to answer with absolutes. What can I do to
> improve confidence? If the latter, then please let me know your other questions.
> 
>>
>> Just to double check: we only need ANON_FOLIO_MAX_ORDER_UNHINTED
>> because of hugepage_vma_check(), is it correct?
> 
> tldr; yes, correct.
> 
> My problem is that for arm64 16k and 64k base page configs, the contpte size is
> 2M. It's my view that this is too big to allocate when it has not been
> explicitly asked for. And I think experience with THP (which is 2M for 4K
> systems today) demonstrates that. But I would still like to benefit from reduced
> SW overhead where possible (i.e. reduced page faults), and I would still like to
> use the contpte 2M mappings when the user has signalled that they can tolerate
> the potential internal fragmentation (MADV_HUGEPAGE).
> 
> In practical terms, ANON_FOLIO_MAX_ORDER_UNHINTED does not affect arm64/4K at
> all (because the contpte size is 64K) and it does not impact the other 4K base
> page arches, which don't currently implement arch_wants_pte_order() meaning they
> get the default PAGE_ALLOC_COSTLY_ORDER=3=32k.
> 
>>
>>> I know you have argued for using a page order in the past, rather than a size in
>>> bytes. But my argument is that user space is mostly doing mmaps based on sizes
>>> independent of the base page size (an assumption!) and a system's memory is
>>> obviously a fixed quantity that doesn't it doesn't change with base page size.
>>> So it feels more natural to limit internal fragmentation based on an absolute
>>> size rather than a quantity of pages. Kyril have also suggested using absolute
>>> sizes in the past [1].
>>>
>>> It's also worth mentioning that the file-backed memory "fault_around" mechanism
>>> chooses 64K.
>>
>> This example actually is against your argument:
>> 1. There have been multiple reports that fault around hurt
>> performances and had to be disabled for some workloads over the years> -- ANON_FOLIO_MAX_ORDER_UNHINTED is likely to cause regressions too.
> 
> I don't see how ANON_FOLIO_MAX_ORDER_UNHINTED can cause regressions; it's adding
> a limit making the behaviour of Large Anon Folios more similar to the old
> behaviour than it otherwise would be. Without it, we will be allocating 2M
> folios in some cases which would be much more likely to cause regression in
> unprepared apps IMHO.
> 
>> 2. Not only can fault around be disabled, its default value can be
>> changed too -- this series can't do either.
> 
> I had a mechanism for that in the previous version, but discussion concluded
> that we should avoid adding the control for now and add it only if/when we have
> identified a workload that will benefit.
> 
>> 3. Most importantly, fault around does not do high-order allocations
>> -- this series does, and high-order allocations can be very difficult
>> under memory pressure.
> 
> But ANON_FOLIO_MAX_ORDER_UNHINTED *reduces* the order from what it otherwise
> would be. So I don't see how its making things worse?
> 
>>
>>> If this approach really looks unacceptable, I have a couple of other ideas. But
>>> I personally favour the approach that is already in the patch.
>>
>> I understand. If the answer to my question above is yes, then let's
>> take a step back and figure out whether overloading existing ABIs is
>> acceptable or not. Does this sound good to you?
> 
> Yes, good idea. Hopefully my explanation above (and all the previous threads)
> gives you a good idea for the problem as I see it, and how I think hooking the
> THP hints is helpful to the solution. If I've understood David's previuous
> remarks correctly, then this also aligns with David's opinions (David you could
> confirm/deny this please?). Could you explain your position that hooking these
> ABIs is a bad approach?
> 
>>
>>> 1) Add a large/small flag to arch_wants_pte_order(). arm64, at least, actually
>>> has 2 mechanisms, HPA and contpte. Currently arm64 is always returning the
>>> contpte order, but with a flag, it could return contpte order for large, and HPA
>>> order for small. (I know we previously passed the vma and we didn't like that,
>>> and this is pretty similar). I still think the SW (core-mm) needs a way to
>>> sensibly limit internal fragmentation though, so personally I still think having
>>> an upper limit in this case is useful.
>>>
>>> 2) More radical: move to a per-vma auto-tuning solution, which looks at the
>>> fault pattern and maintains an allocation order in the VMA, which is modified
>>> based on fault pattern. e.g. When we get faults that occur immediately adjacent
>>> to the allocated range, we increase; when we get faults not connected to
>>> previously allocated pages we decrease. I think it's an interesting thing to
>>> look at, but certainly prefer that it's not part of an MVP implementation.
>>>
>>> [1]
>>> https://lore.kernel.org/linux-mm/20230414140948.7pcaz6niyr2tpa7s@box.shutemov.name/
>>>
>>>
>>>>>
>>>>>> +       if ((vma->vm_flags & VM_NOHUGEPAGE) ||
>>>>>> +           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags) ||
>>>>>> +           !hugepage_flags_enabled())
>>>>>> +               order = 0;
>>>>>> +       else {
>>>>>> +               order = max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORDER);
>>>>>> +
>>>>>> +               if (!hugepage_vma_check(vma, vma->vm_flags, false, true, true))
>>>>>> +                       order = min(order, ANON_FOLIO_MAX_ORDER_UNHINTED);
>>>>>> +       }
>>>>
>>>> I'm a bit surprised to see the above: why can we overload existing
>>>> ABIs? I don't think we can.
>>>
>>> I think this is all covered by the conversation with David against v2; see [2]
>>> and proceeding replies. Argument is that VM_NOHUGEPAGE (and friends) is really a
>>> request from user space to optimize for the least memory wastage possible and
>>> avoid populating ptes that have not been expressly requested.
>>>
>>> [2]
>>> https://lore.kernel.org/linux-mm/524bacd2-4a47-2b8b-6685-c46e31a01631@redhat.com/
>>
>> Thanks for the info.
>>
>> I think there might be a misunderstanding here.
>>
>> David, can you please clarify whether you suggested we overland
>> (change the semantics) of existing ABIs?
>>
>> This sounds like a big red flag to me. If that's really what you
>> suggest, can you shed some light on why this is acceptable to existing
>> userspace at all?
>>
>> Thanks.
> 

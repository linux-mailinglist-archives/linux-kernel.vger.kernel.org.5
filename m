Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D272976C0EE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 01:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjHAXci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 19:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHAXcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 19:32:35 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248E32139
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 16:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690932754; x=1722468754;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DszI0xWwFeDYA93t/pHiL7d5VXJIDxn4QHN6Hd9dN2o=;
  b=b2KaPMZ0gO4LwPGmAA1V4bbJAqTgUFdfUJ/GzTVLQco1433MAgiYD4RN
   MAefxFevPK3cRQdmztHIwe8uuFp+fWJM4gy+iTAcn+a0DVh0YewF996z0
   F2dtI/5cAdblmP2eotLB6AZ4G37Y7qDJLJGxm3I/kUyUEs42lnpbH9seL
   PW5MT5O6UIUClFwEKsZXUCq/IQ3mmra8kvnsllfsJvsmw973wy6tz7iU7
   7Nl/ma3WNk7tSt86q2DEDPV+1sy6A7scnV7XZnaWCKoJoOk3t4S/EoXWr
   U2CDpeMaBeQoJTaW2sN1rM9zxUCIyR92BechLhMsonFYlJfEtiFaaI/Bn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="373078233"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="373078233"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 16:32:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="818967083"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="818967083"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Aug 2023 16:32:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 16:32:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 16:32:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 16:32:32 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 16:32:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JahLxRL6MLXR0VOSh5bv1VZCDZ+jqVaEcb+OjtEhfwNk7c6y+w9cgVAfUY2fJvmhtHpSDa/HKPf1WcH0AhXHEWc2YkmNmt6ZnheQwXiMFI94GrZGEnxcYqxMq8FcTcWLvvQW7Ce2fB1WZn3GWoHrKCxBFJk5v02GUqQ/jwRYQlfgy1JanIKefdReL1F6X1Sq/aL20PYq5ZzbT8kcvmdFDHXBUOdNcSjI5FFJW7pbcZgtPE2TGS+hU7qCUhNJ02whoxO9wIySNGG0HLcNbHvyeld+sFQaCdzw61C4r2rQQXFI16UbgONqpJI2DRggAyJJXQRhkdEqALRbBWn+NnJSyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpYemUv0CNKQLL590yBfWDW+R9fYHfOWrAHBSsuA0fA=;
 b=JREvwz/yCPqUi0zSeFtPPuo/35KESddXYgHo3i7zOPYG89KvvW5Svo7qt9IqCmCDrdEkrVTSxR3R4L1NacvhFKXf8Grn/xH6IUvr5T7rX9Tty9z0s+xGDKeQTNJGP5blJ5NfFZEOSjxH0RXw8y42UA5WVejLpFQfw9bzqD+8HZMzUwuXRjn7mttNBviyBB6KnAbfaB4H8IGIBLuZgZwnVkUHx6gGByHPJ44QA5qUj3xmE98T59NXAW9QLZRFELtTFfE6fFdl5DY2DzNDvqxS0so6gbrKfjBALqNOKWFLVf0M8xmjFikwqwiQWzltkxxCoq65Dw8lNcmW+q3C5RsVVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MN0PR11MB6157.namprd11.prod.outlook.com (2603:10b6:208:3cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 23:32:29 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6631.045; Tue, 1 Aug 2023
 23:32:29 +0000
Message-ID: <e95d9f98-b41f-5ab7-198b-b75a8cc6cb26@intel.com>
Date:   Wed, 2 Aug 2023 07:30:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v4 2/5] mm: LARGE_ANON_FOLIO for improved performance
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>, Ryan Roberts <ryan.roberts@arm.com>
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
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufb8D-8qOhB55WhHgX5dOgrPcrpOZhiA7q9JMi=w6cqEoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|MN0PR11MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e57518-ac44-422d-fb06-08db92e791a7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6dtT4K4XsSr0cwKtyePaiUXTBPWDQNYhdDdSqwvyXQ3osyE5lTtgkz4MhvhBnYIrXTnAjKxBt2jRFTZSdc3OkBAorPZwa0+GZAc+CImHkyfw2uxL1hqlgCSrvsFIqh3tu2YAPIt+NFAUO2AQ/ZHJMO/ZfShz/m7qiCiQ3DDyOhDofAv1DbDgU1S2AidtLw+Yqo9dAY3qUGbuRFvfsw2dFEGsBmVg+UW+mdxMlymN6JeHsDqE1A4UU9Lti19jn3WHBgISKkclj4uTvfaVKVHsozASMBQ3sLbYsRXy2jiG7OHcTc+BKYCo5FIKF1iJPRuGQgysIoK31vhlZm+3DghGyIGp0o5ZsvnRZdPLSp4G4NlUkdlMb9/qVoXqRQaWGgDRPr6KavYD4MCQpADDG4wd5PLn7+dSAUlpoJcU148TyVvMF8Ver6EFp9nRphxcBHn9eJFslqNG92j43H2q/eqW8Rc8TWvLPvxVftIGArTj2dNoMyYVFoZBnrOMuwCIcLa4H/05qFIzYDbOD9l2NperWBXk7hPumAlNioqvtBq/omZshWifCIEw9FERSipFvHWun7CpFS3ybNyy1bAVWK0p6/CTkqG5GY+pm1jlwaVExRJH/KJydI0QhEWYZ4kML/jr7dmCNE8j6Q9vl04bV8qzixVz7FoTRhUknA1r1fLAozRioQXm9b3VAkIltipsGTlG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(6486002)(6666004)(6512007)(966005)(31696002)(86362001)(2616005)(186003)(36756003)(83380400001)(26005)(6506007)(53546011)(38100700002)(4326008)(30864003)(66946007)(66556008)(2906002)(82960400001)(316002)(66476007)(7416002)(5660300002)(41300700001)(31686004)(8676002)(8936002)(478600001)(110136005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW5Bd0wwRkdnNXZvcCs4T1pyd1dkVmREdWlUcnhMNVVRTEVPS2tqTndiQndB?=
 =?utf-8?B?T0I3RkhlSTBpUUhkY0plOWlMRWRNd3hHK3pwdWdSNEZyMk9lN0pTTHpGQXRZ?=
 =?utf-8?B?alg4RHplZXNCZWZaSXBjM0luL2pCUmxlOHVvZVRFOHlWTEIyQzJZUXZRekZ6?=
 =?utf-8?B?Y3NVQnNGditFaklQd1hnSnJzZFUxYXo5NEwwT1JXZnNBM1VudVZmQjVmcVYv?=
 =?utf-8?B?dVFiOW1uTzd3RkV5U3BiY29kZkM0MVlhOCt1K3JXZUt5TlhOb3JjM3NkbktT?=
 =?utf-8?B?YjVmRVJQTksxbTJBVm5iWmNsc20xT1VQaHNnUi9ZbldpK0ZOeDdmSEo5WWJq?=
 =?utf-8?B?S3hwemRMRFRwUExSejIxci9Yam84clJPdFM3UXVBNnZaWmhkWnhwRGlpejYw?=
 =?utf-8?B?amZCemVGMlFTUHdHK0ppUkVwQVJoZ3RlQjZlbmF5M3JGTDRITlVTNUFseWxU?=
 =?utf-8?B?VFRQbkxOclBSR290eTNDL004cHV0ZGVxRTA4ODNCYms2Tk1DcWtyOTBhWkNJ?=
 =?utf-8?B?UDR6OE9FeThLR2x3MW9zTTQrU29qMUx2YVJpWjNlcHhITXVFcVh5azNnRmxE?=
 =?utf-8?B?dlVPYmJ6R2t5Y1daLzdrQXVBcFYxZGxWckNHY2w1V0Z0ZDdWeFFQekZMcWRS?=
 =?utf-8?B?QXF1MmFmYkgzTElxOEFwL0lpaUtGWCtyK1paL0RRdmpWaHdDcGlWcVg0SVdD?=
 =?utf-8?B?cEIrcm9EdmRLdzc4T2h6YjVQWEhuTmFhc0pxMjJyNThmeTlrNXZ0TVVPN2F4?=
 =?utf-8?B?Z1ozY1dEdlU4MWNrVVU4d0VaQXNGZVdqdXR5SXlaN0dvUzdLNGVkK0d4cGdX?=
 =?utf-8?B?cmtlWHdxakg4OUhHRWZwaXJiMmwxb3RMbFNWQzZZcDgycTh1aHk0K0Q4R1pQ?=
 =?utf-8?B?VzEvYTdad3M3eHVpYWRudWlCVU9hak1UeG54ZytBK1Q1UTBYOGhxZnFwWWNr?=
 =?utf-8?B?amN5SDRLbmd0djJnLzBRYTkyaGwvVWRvT1JHeWQvek5OTENMMGJEMFBFMkIz?=
 =?utf-8?B?WVZRM1U4citNVUtNYTByL2hMQ2JMWmdYZEZHZVdUdytySVkvZXVKdGVxL1Rq?=
 =?utf-8?B?TlNoazhhOGNYUWZJVjcvK0ZNTkczVlpQaENYV3lVUTI4ci9nT0FSbW9UMXBp?=
 =?utf-8?B?YzdyRXMyTHNoeWh4NXB0QXlocS84eGVTL2t0V01HQ2c0cy9Sb2tkdTdQa0Nq?=
 =?utf-8?B?WVQycENNb3I1K1hPMDFGc1V0V0VWMnVFaFVTRW1QSk1uemVmcUtnVXh6SnUr?=
 =?utf-8?B?MURWVmtEM29URWVhS3hsMWk4dlVEb3pnblBsRlM1ZGJIZmZsSDA0eGRMZnZI?=
 =?utf-8?B?K1dWMGZLOWp2Qlp2VkJ1bzk4Wk5mRGY1M2ZZdGxCV0NXdVdSUDU4am1rRDlX?=
 =?utf-8?B?WEdEQXFsU2ErVnJwT3BidjJZak5FN0NWdThzL1ZtZEh1eWxqZUJGMzR1YzZm?=
 =?utf-8?B?SFk0WkdES1VSRFpZbVlsclVRTUhUekl1UzAyZDhkK0FrV0Q1bUUrMFF4QTNV?=
 =?utf-8?B?TC8rcjVoSnlxUGNPOUJkQjhadkhScTJpdXBrRGJtUnpsQWRrYUdMMlBCdHRC?=
 =?utf-8?B?RlJzRUNLcXB5bWZWblRQU1hsSUFZOUsvOHFUdzIrUWtOOEloWkJBbnExcStt?=
 =?utf-8?B?aTlZekNiRVEzb29NOERndTRxQlgrUCtWYmJ6QVU0Z2djUzBNSjBYYWlScWVU?=
 =?utf-8?B?a3hveDR1aDM4VkhWTzNldzFNQ0ZraGhTMFZmaXF0MDd5VHdRbGNQeWROYStx?=
 =?utf-8?B?QWpXSTlGdThRMkNYajNKb0NtVC9SWTgzcGo3SVoraUtURXVUVnl0L0I2cFRO?=
 =?utf-8?B?WkI3cHVieFBnamZDb1UxYVZUaFZ2SGNqTzJlZXBuR0R0MzU5NmR6QjFzS1R0?=
 =?utf-8?B?dXkrODBLeHZUc3VZa1RiNythSDlhMGJBMzR5eWN1T1ZsYms2b2dtYUMxa0ZK?=
 =?utf-8?B?TnJmUER0ZmhoL2VzOXB0MTE4RjgvbkY3QjFUalQ4cW5ZdUlXc0o4YjZMaHgy?=
 =?utf-8?B?MVdKMWw4RlpvcUtQQmJIOHh6YlhiQnh5ZUJlWlp3dCszamh4NEJQZmlGYWl2?=
 =?utf-8?B?K09vdkpGdmRxeTBuUE9lbDMvWldUaHYwN2w1VTBxM0twOVdML2NjN3RGU2or?=
 =?utf-8?Q?SRK9M8IpFUrUtSg959+7UdxdB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e57518-ac44-422d-fb06-08db92e791a7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 23:32:29.4216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjSVN3ca3Yu4fP6SkTb2Us0sJ8HFCpd8ylLccHNSemYzfwuxQ8H2ou2BTFNy9IoBzD+cHTasLWbTadmVMTQIjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6157
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



On 8/1/23 14:36, Yu Zhao wrote:
> On Fri, Jul 28, 2023 at 4:13 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 27/07/2023 05:31, Yu Zhao wrote:
>>> On Wed, Jul 26, 2023 at 10:41 AM Yu Zhao <yuzhao@google.com> wrote:
>>>>
>>>> On Wed, Jul 26, 2023 at 3:52 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>
>>>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to be
>>>>> allocated in large folios of a determined order. All pages of the large
>>>>> folio are pte-mapped during the same page fault, significantly reducing
>>>>> the number of page faults. The number of per-page operations (e.g. ref
>>>>> counting, rmap management lru list management) are also significantly
>>>>> reduced since those ops now become per-folio.
>>>>>
>>>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
>>>>> which defaults to disabled for now; The long term aim is for this to
>>>>> defaut to enabled, but there are some risks around internal
>>>>> fragmentation that need to be better understood first.
>>>>>
>>>>> When enabled, the folio order is determined as such: For a vma, process
>>>>> or system that has explicitly disabled THP, we continue to allocate
>>>>> order-0. THP is most likely disabled to avoid any possible internal
>>>>> fragmentation so we honour that request.
>>>>>
>>>>> Otherwise, the return value of arch_wants_pte_order() is used. For vmas
>>>>> that have not explicitly opted-in to use transparent hugepages (e.g.
>>>>> where thp=madvise and the vma does not have MADV_HUGEPAGE), then
>>>>> arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever is
>>>>> bigger). This allows for a performance boost without requiring any
>>>>> explicit opt-in from the workload while limitting internal
>>>>> fragmentation.
>>>>>
>>>>> If the preferred order can't be used (e.g. because the folio would
>>>>> breach the bounds of the vma, or because ptes in the region are already
>>>>> mapped) then we fall back to a suitable lower order; first
>>>>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>>>>>
>>>>> arch_wants_pte_order() can be overridden by the architecture if desired.
>>>>> Some architectures (e.g. arm64) can coalsece TLB entries if a contiguous
>>>>> set of ptes map physically contigious, naturally aligned memory, so this
>>>>> mechanism allows the architecture to optimize as required.
>>>>>
>>>>> Here we add the default implementation of arch_wants_pte_order(), used
>>>>> when the architecture does not define it, which returns -1, implying
>>>>> that the HW has no preference. In this case, mm will choose it's own
>>>>> default order.
>>>>>
>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>> ---
>>>>>  include/linux/pgtable.h |  13 ++++
>>>>>  mm/Kconfig              |  10 +++
>>>>>  mm/memory.c             | 166 ++++++++++++++++++++++++++++++++++++----
>>>>>  3 files changed, 172 insertions(+), 17 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>>>> index 5063b482e34f..2a1d83775837 100644
>>>>> --- a/include/linux/pgtable.h
>>>>> +++ b/include/linux/pgtable.h
>>>>> @@ -313,6 +313,19 @@ static inline bool arch_has_hw_pte_young(void)
>>>>>  }
>>>>>  #endif
>>>>>
>>>>> +#ifndef arch_wants_pte_order
>>>>> +/*
>>>>> + * Returns preferred folio order for pte-mapped memory. Must be in range [0,
>>>>> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires large folios
>>>>> + * to be at least order-2. Negative value implies that the HW has no preference
>>>>> + * and mm will choose it's own default order.
>>>>> + */
>>>>> +static inline int arch_wants_pte_order(void)
>>>>> +{
>>>>> +       return -1;
>>>>> +}
>>>>> +#endif
>>>>> +
>>>>>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>>>>>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>>>>                                        unsigned long address,
>>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>>> index 09130434e30d..fa61ea160447 100644
>>>>> --- a/mm/Kconfig
>>>>> +++ b/mm/Kconfig
>>>>> @@ -1238,4 +1238,14 @@ config LOCK_MM_AND_FIND_VMA
>>>>>
>>>>>  source "mm/damon/Kconfig"
>>>>>
>>>>> +config LARGE_ANON_FOLIO
>>>>> +       bool "Allocate large folios for anonymous memory"
>>>>> +       depends on TRANSPARENT_HUGEPAGE
>>>>> +       default n
>>>>> +       help
>>>>> +         Use large (bigger than order-0) folios to back anonymous memory where
>>>>> +         possible, even for pte-mapped memory. This reduces the number of page
>>>>> +         faults, as well as other per-page overheads to improve performance for
>>>>> +         many workloads.
>>>>> +
>>>>>  endmenu
>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>> index 01f39e8144ef..64c3f242c49a 100644
>>>>> --- a/mm/memory.c
>>>>> +++ b/mm/memory.c
>>>>> @@ -4050,6 +4050,127 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>>         return ret;
>>>>>  }
>>>>>
>>>>> +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_pages)
>>>>> +{
>>>>> +       int i;
>>>>> +
>>>>> +       if (nr_pages == 1)
>>>>> +               return vmf_pte_changed(vmf);
>>>>> +
>>>>> +       for (i = 0; i < nr_pages; i++) {
>>>>> +               if (!pte_none(ptep_get_lockless(vmf->pte + i)))
>>>>> +                       return true;
>>>>> +       }
>>>>> +
>>>>> +       return false;
>>>>> +}
>>>>> +
>>>>> +#ifdef CONFIG_LARGE_ANON_FOLIO
>>>>> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
>>>>> +               (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAGE_SHIFT)
>>>>> +
>>>>> +static int anon_folio_order(struct vm_area_struct *vma)
>>>>> +{
>>>>> +       int order;
>>>>> +
>>>>> +       /*
>>>>> +        * If THP is explicitly disabled for either the vma, the process or the
>>>>> +        * system, then this is very likely intended to limit internal
>>>>> +        * fragmentation; in this case, don't attempt to allocate a large
>>>>> +        * anonymous folio.
>>>>> +        *
>>>>> +        * Else, if the vma is eligible for thp, allocate a large folio of the
>>>>> +        * size preferred by the arch. Or if the arch requested a very small
>>>>> +        * size or didn't request a size, then use PAGE_ALLOC_COSTLY_ORDER,
>>>>> +        * which still meets the arch's requirements but means we still take
>>>>> +        * advantage of SW optimizations (e.g. fewer page faults).
>>>>> +        *
>>>>> +        * Finally if thp is enabled but the vma isn't eligible, take the
>>>>> +        * arch-preferred size and limit it to ANON_FOLIO_MAX_ORDER_UNHINTED.
>>>>> +        * This ensures workloads that have not explicitly opted-in take benefit
>>>>> +        * while capping the potential for internal fragmentation.
>>>>> +        */
>>>>
>>>> What empirical evidence is SZ_64K based on?
>>>> What workloads would benefit from it?
>>>> How much would they benefit from it?
>>>> Would they benefit more or less from different values?
>>>> How much internal fragmentation would it cause?
>>>> What cost function was used to arrive at the conclusion that its
>>>> benefits outweigh its costs?
>>
>> Sorry this has taken a little while to reply to; I've been re-running my perf
>> tests with the modern patches to recomfirm old data.
> 
> Thanks for the data!
> 
>> In terms of empirical evidence, I've run the kernel compilation benchmark (yes I
>> know its a narrow use case, but I figure some data is better than no data), for
>> all values of ANON_FOLIO_MAX_ORDER_UNHINTED {4k, 16k, 32k, 64k, 128k, 256k}.
>>
>> I've run each test 15 times across 5 system reboots on Ampere Altra (arm64),
> 
> What about x86 and ppc? Do we expect they might perform similarly wrt
> different page sizes?
I will run the same text on Intel x86 platform.

Regards
Yin, Fengwei

> 
>> with the kernel configured for 4K base pages - I could rerun for other base page
>> sizes if we want to go further down this route.
>>
>> I've captured run time and peak memory usage, and taken the mean. The stdev for
>> the peak memory usage is big-ish, but I'm confident this still captures the
>> central tendancy well:
>>
>> | MAX_ORDER_UNHINTED |   real-time |   kern-time |   user-time | peak memory |
>> |:-------------------|------------:|------------:|------------:|:------------|
>> | 4k                 |        0.0% |        0.0% |        0.0% |        0.0% |
>> | 16k                |       -3.6% |      -26.5% |       -0.5% |       -0.1% |
>> | 32k                |       -4.8% |      -37.4% |       -0.6% |       -0.1% |
>> | 64k                |       -5.7% |      -42.0% |       -0.6% |       -1.1% |
>> | 128k               |       -5.6% |      -42.1% |       -0.7% |        1.4% |
>> | 256k               |       -4.9% |      -41.9% |       -0.4% |        1.9% |
>>
>> 64K looks like the clear sweet spot to me.
> 
> Were the tests done under memory pressure? I agree 64KB might be a
> reasonable value, but I don't think we can or need to make a
> conclusion at this point: there are still pending questions from my
> list.
> 
> Just to double check: we only need ANON_FOLIO_MAX_ORDER_UNHINTED
> because of hugepage_vma_check(), is it correct?
> 
>> I know you have argued for using a page order in the past, rather than a size in
>> bytes. But my argument is that user space is mostly doing mmaps based on sizes
>> independent of the base page size (an assumption!) and a system's memory is
>> obviously a fixed quantity that doesn't it doesn't change with base page size.
>> So it feels more natural to limit internal fragmentation based on an absolute
>> size rather than a quantity of pages. Kyril have also suggested using absolute
>> sizes in the past [1].
>>
>> It's also worth mentioning that the file-backed memory "fault_around" mechanism
>> chooses 64K.
> 
> This example actually is against your argument:
> 1. There have been multiple reports that fault around hurt
> performances and had to be disabled for some workloads over the years
> -- ANON_FOLIO_MAX_ORDER_UNHINTED is likely to cause regressions too.
> 2. Not only can fault around be disabled, its default value can be
> changed too -- this series can't do either.
> 3. Most importantly, fault around does not do high-order allocations
> -- this series does, and high-order allocations can be very difficult
> under memory pressure.
> 
>> If this approach really looks unacceptable, I have a couple of other ideas. But
>> I personally favour the approach that is already in the patch.
> 
> I understand. If the answer to my question above is yes, then let's
> take a step back and figure out whether overloading existing ABIs is
> acceptable or not. Does this sound good to you?
> 
>> 1) Add a large/small flag to arch_wants_pte_order(). arm64, at least, actually
>> has 2 mechanisms, HPA and contpte. Currently arm64 is always returning the
>> contpte order, but with a flag, it could return contpte order for large, and HPA
>> order for small. (I know we previously passed the vma and we didn't like that,
>> and this is pretty similar). I still think the SW (core-mm) needs a way to
>> sensibly limit internal fragmentation though, so personally I still think having
>> an upper limit in this case is useful.
>>
>> 2) More radical: move to a per-vma auto-tuning solution, which looks at the
>> fault pattern and maintains an allocation order in the VMA, which is modified
>> based on fault pattern. e.g. When we get faults that occur immediately adjacent
>> to the allocated range, we increase; when we get faults not connected to
>> previously allocated pages we decrease. I think it's an interesting thing to
>> look at, but certainly prefer that it's not part of an MVP implementation.
>>
>> [1]
>> https://lore.kernel.org/linux-mm/20230414140948.7pcaz6niyr2tpa7s@box.shutemov.name/
>>
>>
>>>>
>>>>> +       if ((vma->vm_flags & VM_NOHUGEPAGE) ||
>>>>> +           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags) ||
>>>>> +           !hugepage_flags_enabled())
>>>>> +               order = 0;
>>>>> +       else {
>>>>> +               order = max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORDER);
>>>>> +
>>>>> +               if (!hugepage_vma_check(vma, vma->vm_flags, false, true, true))
>>>>> +                       order = min(order, ANON_FOLIO_MAX_ORDER_UNHINTED);
>>>>> +       }
>>>
>>> I'm a bit surprised to see the above: why can we overload existing
>>> ABIs? I don't think we can.
>>
>> I think this is all covered by the conversation with David against v2; see [2]
>> and proceeding replies. Argument is that VM_NOHUGEPAGE (and friends) is really a
>> request from user space to optimize for the least memory wastage possible and
>> avoid populating ptes that have not been expressly requested.
>>
>> [2]
>> https://lore.kernel.org/linux-mm/524bacd2-4a47-2b8b-6685-c46e31a01631@redhat.com/
> 
> Thanks for the info.
> 
> I think there might be a misunderstanding here.
> 
> David, can you please clarify whether you suggested we overland
> (change the semantics) of existing ABIs?
> 
> This sounds like a big red flag to me. If that's really what you
> suggest, can you shed some light on why this is acceptable to existing
> userspace at all?
> 
> Thanks.

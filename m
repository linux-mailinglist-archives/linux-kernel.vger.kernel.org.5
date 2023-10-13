Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AE47C8C2C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjJMRQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJMRQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:16:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5137FA9;
        Fri, 13 Oct 2023 10:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697217417; x=1728753417;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sTBZAKymEpf0JuzfY3IN46DSKhJcKKMUuCvhZdxBluM=;
  b=IYqH9BHdYeQetjptxyOGBINqP5UIbV46CG2FmdjRNVvnCTIovSUlwEVm
   LPKJ6FYchUA6CDJDG1goEOOynqhMG2qWTV+XfRfbW03Z0f+Pgu65PNdn2
   JmKBXwlb1ku57lKB2PQXu4Xb9VAiSdk/Uh2JeSdI7CJjrURqWbMhPcAcz
   jzf0br2+Xx8yMSsL3IyjIPxZsoIGqSOk6HGpoAwJl3ERrluEJ+DcNiFMT
   M1OQL83Yme5eBB763GAep91VvMrxJg7uZ1hGmu6LZK9C7ih5rZocyGAw6
   D30PdziG6E7IW8IPXJJ79N1JoVfiZrqMDYzGqBPiG1QNjY1sYV1HvFd3V
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="370293887"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="370293887"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 10:16:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="878600633"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="878600633"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 10:16:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 10:16:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 10:16:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 10:16:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 10:16:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKf78eYiC6FWPDExrZHAYXOy2j6fnKBWsgMD+rWcGGXX+ux64ybJH15iY1FmYEotnkookui829AQvNo4TnTzbgCVl8xB+KCYIVaFyB2ZSDXqJRGReVZUyeA6rE8rDOBAco+NYTT/xTAwTv9bjbQZhAUNo3g9AVz8HYl7DnP3YHVZcxpCNeY5119ZX0GhuYcfVoQrv8Cw+nAdtCUi/bQQRymFMUClDtPZWZrMB1z7xpjgLgqvef3ezapMTX+HxG81527W+ATgO7dvqpne0FSjJM/iXmu5KTWQSSE9uy4Oby/8MK62OPlJAf0v/sX1ses6rWRcyom8MTm2mp+yD+ajaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+hCfgsytcJ5yFTJowhhNXRrt73udfUbtCerZ7MlbMw=;
 b=Ta2CDuKrU0LnLsYkkAmu7CrS6Nl8f4Zmbpnp7A1cGd5v/dQwki2OVTWzddVQJ3MN/cqme73XJ7lIF0V0ybu3Lt6qcm9djWWi1jHxDVkWwJoCD3xxlSfnn/UN1Xmwk7yo/LRPfrd7EbqbhB5mrrLX0bo0aXHwR687rWRwdUh8XH2gIH6TME8r0F8tLvh6PyW6AxcH/Oarg66al+At25ObBPVb7S97dpBaFjaqGYKHlVL5/6BSpjzOr6apc6IlXA5W7JD3XbRsJwxP4nAhr7+pqOjkrtuzUPQr9KSybJ/qLzfY/FgCv/xkl+aMvLtTLiDPP20MYENMBPobR8g5eVdGjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Fri, 13 Oct
 2023 17:16:50 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 17:16:49 +0000
Message-ID: <32668ca1-e316-427a-883c-af931d42851c@intel.com>
Date:   Fri, 13 Oct 2023 10:16:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next 3/3] idpf: fix undefined
 reference to tcp_gro_complete() when !CONFIG_INET
To:     Jakub Kicinski <kuba@kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michalik, Michal" <michal.michalik@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "Olech, Milena" <milena.olech@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20230920180745.1607563-1-aleksander.lobakin@intel.com>
 <20230920180745.1607563-4-aleksander.lobakin@intel.com>
 <2038f544-859f-4ffb-9840-37c1ba289259@infradead.org>
 <0df556eb-71b2-9612-a81d-cd83c27a2cd7@intel.com>
 <8eaece43-a30d-45e8-9610-28ed2af842fc@infradead.org>
 <b5c1030a-9831-4580-8684-7c68f5888131@infradead.org>
 <CO1PR11MB508965D49B6144B0CC7E5221D6D3A@CO1PR11MB5089.namprd11.prod.outlook.com>
 <20231012163153.7fe61b40@kernel.org>
Content-Language: en-US
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231012163153.7fe61b40@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0121.namprd04.prod.outlook.com
 (2603:10b6:303:84::6) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB4839:EE_
X-MS-Office365-Filtering-Correlation-Id: da542879-1609-4113-677b-08dbcc102f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7OFC7OUbehrRtqDNlo8muwgt89Q+5Qgd5WDA/D6jC9IqvIreX/zjekUSXxZw+Co0AwWUnjmApia0GxpiD07gy17kC9Y3JMGRaR6yos7o3/36v1/LR2y+uDc79FoCNYefg7KCpoTVyez6huw12WDnuBAIiy/mENgA/df5lVtjb2YAAnMyb5slhOU/dR/q8nOatuvLcSH1XbuO+aVy9hlZKxy627E/5KVrjk9Bbf5RYucZCIR013NaEuvLFht+gJhU1hk7B2R1Z5NDS8nPZl3BPhTS7VcEFTARDuZdL75xV3iYjkhXwFSPAVt+aqsQvlIRG2ufXmOy1+mfrshNJdSo29WYJ2bkUBPGB5lUcpI+xRU4rH37nkxisXH9qcXfVlv8ig/WNcrm/udtl8Ohfs2bkxlP5Jctil4e7W2TPgD1i92nBTHuZgcZ0RSy2iOYH6b8oKCbLeRbXKdrYpeQzvTlF/ikz3P+cCCEpT9eT0BMGOqewikjmwUE8J2gemcD69tQ/rmawFYYl2EvVBYuhVfMUIQ4l6VgPnytvb4Fb1E1E81ATD5UmTL1Yd/QVY4EGTYnnJ9Su52UhS0Ry59QfJgppXTVhZ8bEg4pDBi7ZJrz9+GGvI88NBqBaupbQqdsqlyeXJIpd8/M/NTHr30TqfSklGN9uzchqxW5BNiykSRnSh9j/JQBbNIPFg3UsLhb1QjL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(346002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6512007)(6486002)(478600001)(36756003)(31696002)(86362001)(966005)(6506007)(53546011)(6916009)(38100700002)(6666004)(8676002)(8936002)(4326008)(316002)(82960400001)(5660300002)(66476007)(54906003)(66556008)(41300700001)(7416002)(66946007)(2906002)(26005)(31686004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0hwSU5KOFZ4aHF3Mm9iOUMwWFRoSy94ek9qNW4zZGdua3R2Z3ZUc3U5RHFY?=
 =?utf-8?B?aG81Mm9LWVA4N1FmUkk3eWpORkpqcCtlTEZNK0hmQjczbVByMlJPem5lazVx?=
 =?utf-8?B?N0dqZU9OSkJidDdmdFlkYmVwV2JsNDBPZElRTnZKL3o3ZGFpWE1OOC8zSVNa?=
 =?utf-8?B?RXBTcVBodU11V3gyTGZRVTlSZU5sTmpzTzVXK0pqakN2cEVJdFAvQXZaMFIv?=
 =?utf-8?B?VFdtTlh0bVhKc1ZUTkRkRHEySCt5bHhYRDA4RFdCdkowWktIS1RZc3dxclVU?=
 =?utf-8?B?aFE4aEpCN0JsWjU3QjVrK2UwT0FpeUNhNVA1Q09ER2RRa2FoKzJkYzB4UmUw?=
 =?utf-8?B?dzMwd3Zzak16djh5NkFDRDlHYlRYbENraDlSeUpWVDJQZkw3U01zYzJUdWpI?=
 =?utf-8?B?emdXd3hTM28vUXgyQUVLbnc1VEl0QVNRdTJGY3lNVHdJdCszSnBVOXZaY00y?=
 =?utf-8?B?bjFNTU5NYWtCUlFaTVI2S25JcjA3VmhRYzBucUduM05BenV3LzN6dmdXK0JV?=
 =?utf-8?B?dU1JWEJ6M1ZRVFQ2Z25ZcTRrVVVGbmk0VVZlN1d4bldpdmc4YUxRSnNYb1BR?=
 =?utf-8?B?UExFczFqRVh3NXprWE11TG4vT05zUUhXSDMvRnNKTlpNem10U09ZT1VIQTJt?=
 =?utf-8?B?SkI3T2JBcGFZampRSmtSYkZKS3Rua28zeG1tejN3a0M4VTIyRG1VckVDbEh4?=
 =?utf-8?B?QVV6dmVtZzNFMUlyMVl0Rmh1TDFocUoxZ3dvcXgvckVCR0lBeGpmNlg0MVh1?=
 =?utf-8?B?RUE2dlcrSFRqNW12c2ZVQlQ5OG45U1h2U3R3SHNSOTNGbnR3NGJka1NrMktC?=
 =?utf-8?B?em85Yld5L285eXRGL1NPdEc4YUFpS1FUaTcvREhlNkhNZmwzb0NnejRvcGhR?=
 =?utf-8?B?VjkrTnQvNkp2YlpsaWorYkxBRGZvUWFKYTdkeUMvMXhDM2xRb1ZrOFN1ZlZK?=
 =?utf-8?B?U3l3dmtLS3QyMlZ5TUNDMHdkVVROaVRwOVFuVU5DQzZBL3dSb21YN0oyZVB0?=
 =?utf-8?B?d1B4NEx6RjUwVjZBUFZKcEY0bVMzS28vb1FCN1JXaXdJMVU3MldVMHlwdFBI?=
 =?utf-8?B?Z0xlTm1nd0xaem9xRUZUOUNQQlhYZHVvU0R3b0I5dmtuZS90M3hha2tXOWQ3?=
 =?utf-8?B?MURqazkwTXNuVmVWWWthVlF6clNNbi9HcmVpc1FuN3YzbWNJemV2Z1RVRStO?=
 =?utf-8?B?ZjU2MVFDME11NUFRcmJ4aTV1K1ArOGwraG1DNHdVU205UTBjcXIzM1poU09D?=
 =?utf-8?B?ZVBHUlZseU5rVVRPTXp6NWgxb2FoRGtBc2V6Z0VTUENtNzhuV0dib2RSRTY4?=
 =?utf-8?B?bWc4ZUtCdnBSSFJJdlhpcDZGSUxIV0FjV0o5S1NIQ2tScEZnbHdkR0pFbmEy?=
 =?utf-8?B?MEhSdUFVMU0vTkxKbmpEaG83cFVuOXBZUDRyNzJqK2pNTFJETjVUbmtlOTN0?=
 =?utf-8?B?V1ptYUVzMDkxZmVSVXJBRFY3bXF0aTdXQ291RXpTQTV2NlN6MFpiak1IWFdF?=
 =?utf-8?B?ZEpVK29JOHFkeU1YV2NsdHYybHBHUnFYTmRUZEVtbXJRQWtpeDdOSmE2WGxi?=
 =?utf-8?B?MkppclpKWlFTaVJlcnltS20xWTZNT3JWSFhreFUvVFRRU0RHNTEyNVdxNnVO?=
 =?utf-8?B?YVFhbWxIbFRFUGNreHEyeGdKZy9iVWhFRkY4ekIwUGVhck5WMTVPZUFaWE9O?=
 =?utf-8?B?UlMwV1lxTDl5Rk9QeUYvV0tiUW5NOTRoZ25USzhZRzg1eS9ScmRTTXA5WHJ1?=
 =?utf-8?B?Y1pKbklnNzhuVkhRNWxCVWI2OUw5Yml6bk9kNm5jMWgxQTN2UXRJYnhBdDg2?=
 =?utf-8?B?bDArTjZKSFFkOHVzZndMbzlMalpyR0RqaHBveHp5eDNCcUJkNnBJakNyejIz?=
 =?utf-8?B?UlZjMXVoNTJCOXFaWHlOQlRoc1krbXZPb3UyTFRwK1JrSzNoanFnR002SWNa?=
 =?utf-8?B?dFlHRmk2VFl6Z0NCZnZCUW9IVU0rTUM2bFl5dnJ2YjBMVlkwRW0yQXl2dWlI?=
 =?utf-8?B?YndQK1lQWkp1RlBYZjFleXNkMlZPcUNibnhocUhXWk9CUC9ZTi9ldUozQWxQ?=
 =?utf-8?B?cjRLWkNZMDdzcFVtTnIxSU12ZktHVnMzRnVTWTJMRytmeXNuZk15T3JpWU1y?=
 =?utf-8?B?VmNNK3dubFMzV3BWa1VzL1VkcTdtVFYrMlVoYUM4SFpOL1B4dTNLR1orL2w5?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da542879-1609-4113-677b-08dbcc102f7b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 17:16:49.2570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5qOBN00wgvjD+yNOdYM7ma38EEY8kkNkwc41NyhFYQWITpikr5A6NmyR5wOTkiUkWXAvv6K+G0wGbf5msRSNx+2VuMMCswzFMKuuV28tRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4839
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2023 4:31 PM, Jakub Kicinski wrote:
> On Thu, 12 Oct 2023 18:34:00 +0000 Keller, Jacob E wrote:
>>> Even if this is just > v6.6 kernels (i.e., linux-next),
>>> it would be very good to get a fix merged for these build errors.
>>> I keep getting build errors in linux-next....
>>
>> A standalone version for the idpf driver fix was posted at [1], and
>> another alternative fix was posted at [2]
>>
>> Fixes for the ice driver have already merged.
>>
>> [1]:
>> https://lore.kernel.org/netdev/20230921125936.1621191-1-aleksander.lobakin@intel.com/
>> [2]:
>> https://lore.kernel.org/netdev/20230925155858.651425-1-arnd@kernel.org/
>>
>> The fix from Arnd got approval from Olek, but it seems like it
>> stalled out after asking about stubs. I'm fine with either approach
>> but would  also like to see a fix merge soon.
> 
> The suggestion of making NET == INET is quite tempting but requires
> extra consideration. Since nobody seems to have the cycles, let's
> go with the stubs?
> 

Yea. I think NET == INET would cause a bit more challenge in the
immediate term. Its possibly worth exploring but it would be nice to get
the build bots happy first.

I can take the time this morning to work on a version that implements
the stub, and post it.

Thanks,
Jake

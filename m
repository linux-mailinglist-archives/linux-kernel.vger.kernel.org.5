Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65137F2B8A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjKULQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKULQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:16:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FBE83;
        Tue, 21 Nov 2023 03:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700565381; x=1732101381;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=elVfpZHQxvaK8UHMtV1iFKkJFgElHj6tqCYznTTUucg=;
  b=ZwZB0gUdhbTfhWh2v8/b+ZApkCiij4WJCFtdaKVDr20LAWx3PCeuSsHq
   +EXV46PQwIUq6ihONe55Yc7tARTzaAmSUVuJDU9YphJWTKyf/3WZssG2S
   Z70BJCU7dCDapjfBJBFvRukQjb4CruSn4jaX/KYiWcW4VGdrlXB9SOvlt
   IolSkLd78ZAOUzGIR+sdwQNhCwxPwA0LQ7wWA8Wk4UPfq7qCFD7EVTWqH
   1g3R89jLDEKAaATv5Ptie1MEJ1k033CM764NhJS9rFbiSbpNsfSxt7Cia
   djvDqoJKurqcK7Kh6WvJ8SOTzUEoIRvPnFOWBdbhzWdSTIp/b1IaPeehk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="376855720"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="376855720"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 03:15:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="837026655"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="837026655"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2023 03:15:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 03:15:56 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 03:15:56 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 03:15:56 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 03:15:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n++Z5lQWNXC5F2Y2YXX6tL53loeA76lptC3z6a/GnrRd2VSfw5cR3V1DOBVUVO0N4l6RtqOOmaGpF8MnQgB9OW3Yyb3EmQb1+ryzo1zB4t4VNRb3Sr9LFv12nF50Ne/j/CVAzkfGPOLw2NmKLkmpBAK3AMpStvrlKlca7+UrAs6aVFkHaoFuLSOm5EOuw+SoYEhdotOfXx8EgG1wRqG4EojxWK/D7rA2QChBJmP+nQo5Q+r1wUI7CJtKkAtkpWAO3mOvkNzuknfxLkG8lv53WBvUgLvi+eWAKbJCPn/ReFNQBLqWuqIMM6V2dszbQPbn1PTuRZm+FB8R2JCJ6SWt/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZjndI0OIpo0iBZsmNXKWq2D/OcCpI1o7zaef+OYHuY=;
 b=lfJfiZMDmfJC/JsP1R0EHGI7jjfn0bzj30APpg8yWspTdB4w2sVHdIh42f7BFAQ5qGATwh8QLRD9rqFsDsclpouki50N4vLNpf5qFmBX7vYcdtziOZgADnCbVAZCeymetyq5VSUqB5cnSkEdgusBLo8C453nqg1QSih1UPBsSRXy2jxRMZYaqgKOH7MdPuTvWOdAGTQZnYndpR1L4bUVmV4IUg40GRn+uMWObb6IIcEsTtkiFf/yB82U/mpUZ6f1GRw7bw+Ecx405c7/JKBZ0p4tTMAu69T9xjEHnsJmwEbBbBCMXjXkq6x8FiJnaBWsHV1RAdv48cqUs+OjSTRZHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH7PR11MB8478.namprd11.prod.outlook.com (2603:10b6:510:308::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 11:15:54 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%7]) with mapi id 15.20.7002.026; Tue, 21 Nov 2023
 11:15:53 +0000
Message-ID: <e5b458fa-c7ad-424d-8416-2947d684b5dc@intel.com>
Date:   Tue, 21 Nov 2023 12:15:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next] i40e: Use correct buffer size
Content-Language: en-US
To:     Kunwu Chan <chentao@kylinos.cn>
CC:     <horms@kernel.org>, <anthony.l.nguyen@intel.com>,
        <davem@davemloft.net>, <edumazet@google.com>,
        <intel-wired-lan@lists.osuosl.org>, <jeffrey.t.kirsher@intel.com>,
        <jesse.brandeburg@intel.com>, <kuba@kernel.org>,
        <kunwu.chan@hotmail.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>,
        <shannon.nelson@amd.com>
References: <20231113093112.GL705326@kernel.org>
 <20231115031444.33381-1-chentao@kylinos.cn>
 <55e07c56-da57-41aa-bc96-e446fad24276@intel.com>
 <4b551600-f1a3-4efe-b3e9-99cb4536f487@kylinos.cn>
 <2c61c232-1bbb-4cae-bb7f-92a7f2298e97@intel.com>
 <55b77a28-a680-4465-bb57-2a5cb20ce06a@kylinos.cn>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <55b77a28-a680-4465-bb57-2a5cb20ce06a@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0404.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::6) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH7PR11MB8478:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b855b5f-f594-411d-fa2c-08dbea8339b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5svfr7t5EawNhbWyZj7bssOADyCWJ5XhWAOlsSRMtaoBBTFD0LgAeD+x01izIE/ZMbXCRwu/V6Bi77dzYyXgDAnwKmuBThvutxqNlkOuOYdnFi/6DD22eMni/zGf+zcMVfv/yM0oY8u/XuX3LDSc/WpxJ34sxvHIB2ndMRd1WA9jsA+BTYWJfKB5EAksyVPrtFaJvY6z+CDeRoP4nxpzwpFv6aGN0YhoAfzF8l2mxrx8vI1Q+ms0ut5B7yjPnkGX8+bOnczb68VylRyqNbphviXH6Xj6xFtPIy3z7HysEqrRShAxPnXH1ZjQGndy2L51+hYQORJpF8ek/nthbOdc/mMzzLfeXnXOV8r1ehWcqjNFT4l4/XliOK80oYeamKV/ahYQAWIMWqVospZ465USmJKBC1ROsQ8pfza3oRDnjUtDDKZdAuXLhzcspbpjeF+RB35i3eZ0HJXBO+rtS8xQHI77otMyyphzfPm8ndDcql2UvgKBH80UZGJUe8lbKW7kK3ZOOwe7saDrc9t2IZ1HnWEMZFmLIOCpAr9MN6jkyBi6p3x4wXAvSfoPTs06n+5AsWhgfyQ1Yte0NuD2p30vFXp4MncTAPgoEAN1Mn8P8j1Bv8UeoPRdwStR+QPAbzDTDe0l+ytgDBYLfNJmobZK0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6486002)(83380400001)(6506007)(6512007)(478600001)(31686004)(2616005)(6666004)(26005)(82960400001)(38100700002)(66556008)(66946007)(6916009)(316002)(66476007)(31696002)(86362001)(5660300002)(7416002)(2906002)(41300700001)(8936002)(8676002)(4326008)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0t5cnVTcXZvRVF4ak4vMGdZZ21XSXZDZ0JNU21LdE5mcTRMSS9MbjB1YVZB?=
 =?utf-8?B?dmdIdGlyZERTR1pNM2xPRVRjbHNXLzYxaTUzNitNT1dXckZxQ0cvQmxYemQx?=
 =?utf-8?B?cjl2bmJwWnVGWWU4eG9oVWhMOFBMb201a0NlVUM3dVNXcTBmdDJZMmJmNDhD?=
 =?utf-8?B?bkVlbW5wVHZML1FCN2VpUHA3K0RpazRNRU9nNEpLbDY1T0ZlMnQ1THJNVlF1?=
 =?utf-8?B?QndhUUw5bUoxaTN0T3MxNFZxR0VCRGl6YkpXZVpOOC9NVzU2cGtmWkJadlN0?=
 =?utf-8?B?U0dkTUlkc0ZrTXRTNzFvLzBYeCt2N0p6SVFiaTNSazJSbUpuUjVneHVQZjZG?=
 =?utf-8?B?RU4rYkxiTFNEVFJZRDY5bHc0VTdIa2JjSU8xYjJpR3VWamMxbC84VXd3L1ZK?=
 =?utf-8?B?ZlhBNzlYK3AwckpPSWN5SkxwZEZEYjhkZkM2UzdaditjaS9mVlZFNENqYy9m?=
 =?utf-8?B?Z3ZiNGE2dlJTMTBEellKQXRlTmJ5V2ZucnRBY3dOdnNwbjZUQ29Wd1pTckNy?=
 =?utf-8?B?NXZsL0FEckl2dFBibzJzaUt4VjUxWDFIZ2xHUzEya1d4MElkekEwU2wyQ2NL?=
 =?utf-8?B?WW4zYzJobVFuOWdwTThwd3RicllUd3p6TnQxMmpYMWRUMUFTVktVN2dZNFFF?=
 =?utf-8?B?U2daYWlscjdlRzB1K0tIbGdJY2N3OUZkdnZZeUUvRENHQ2VqTUtKdVYxWUVy?=
 =?utf-8?B?VHM2TzB4OUdOR3VQNnhqRlJIRTFwZzI2Z0w1aVRmK1Nhb2FsZTVzc2JibkF6?=
 =?utf-8?B?SWNIK0hUV3ZxVzNsRkUvRVJBSDQyWWRNTWJTV0ZzeUpvd3FVMUJUKytCWWg3?=
 =?utf-8?B?a05BaEM3akt5d0o4RHdQdTJTWTFOb3NKSVJMd2VVKy9WQ1VhRFBHbG9BUVZk?=
 =?utf-8?B?VHEyWHU5L25yb2V2V2czc21FQlJJSDF2bm1FV0R6VlhNWkJSaCtxSkp2cjJh?=
 =?utf-8?B?T2R0NlQ0QmFoUXUwWTdWbFNwMjF5a2NaakZ0TXJQUlhVeWtkd29idnVFaFRh?=
 =?utf-8?B?MkYrcUd0bGk5T25hSy9EbnpKMGdPMDl6ZXR6MXcvMGR0WjlHd2lCU3ViYm1k?=
 =?utf-8?B?Q3BkM1FidnlEbGRKQXMvd3pLMXQvbEk0VCs3K0FJeTB4Qk5PSlJlZ3liK3FV?=
 =?utf-8?B?dEd6T3hoczlOQmRPWVhyUGxtcGg2K2xLNktyaENmNFY2V2ViaXdvVXlmRm03?=
 =?utf-8?B?VndkeTdLcjFtbmMxWFBWSS9aTmllUkVFcXgvaENPVVRjYWF2VHUxQ3EyWWxm?=
 =?utf-8?B?RjBwUnVyYndPdnJ0TXFENCtHT0kzbGpncUpSN1JnSFdndm9oNTRTKzk3TWkr?=
 =?utf-8?B?VFlLMkRpYmsyeTlHOU5kUXl4L2RaMEJGbXB1ZVFsNGszcWs2enJBN3FwWDkr?=
 =?utf-8?B?SWUvRWx6Zk9wVmxkTkkwUlBUYU44eDNsK1BIZTBMM1FURGlFTUFiN0ZCemJj?=
 =?utf-8?B?WmRBVnlkclBhTlRtcEtQWkxuSm1YWVU5L0c5SUpNVjlwTnVSU3FLNVAwL2J6?=
 =?utf-8?B?N3ZXZzRVcERtYk50WXUydFBnQmJhWHYveW1NU2hhNVBLa3lCLzdTeU8xUWoz?=
 =?utf-8?B?MXgvdEs5QkZQWWVudHk5K0ZzSjQvQ3RlVzhPcjRKMmhrV0tlMDlnbjRZMXFE?=
 =?utf-8?B?Vkt5TXJiY0xiZG56bWNoOS96ZmF2Zk5tclg2MXRDQnArd2dyR3lDVnMrdUNB?=
 =?utf-8?B?T3lxZXEwSnFsdHF1NENzSXVFRmE1alFNQmNra1V6RWVzY1pNQTd0OVZIWUhS?=
 =?utf-8?B?Q3U1R2I4MUYxK052WkpvTElDR2FtNktsNmFTTXBnT3ZTZ05DYXg3RXZ6L3ZF?=
 =?utf-8?B?c1lrUDNodWNvTnZ4TytxZ0cyL2xWSkFCR0tYZUV6ZmYzVXcwaTRiNWU3QVZW?=
 =?utf-8?B?eGwrTnFLWCt1ZTUvK2xJbjlhMXh0YlFNYVpNcjJMNE5CMmVEUkJHUGtJdzIz?=
 =?utf-8?B?TXJKV0xDSUt0TS9xa2xRdGpWeGtCZmZ6cGVyVExMUzVHa2lKbHpqWVJsK01I?=
 =?utf-8?B?UU5LNzRRcjNLSFBKQTJNRDd2NWhENDk5aUVIODlsazNUY1ZPbytaTnY4MzU1?=
 =?utf-8?B?ZjZPbWtzTEZVSTYyM0tVM1RiOElhZUhpcytxa0ZtVWdRQVJBWHBvemtiSWxI?=
 =?utf-8?B?dWJBZHlpT0NrQ2kyTHdpUDA4YnZTZHg3NW5QWnU0amxMUzlTeS9XbUo5YXFo?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b855b5f-f594-411d-fa2c-08dbea8339b5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 11:15:53.5685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvoFpLc3GdQEwuuqsphnf/twhzW/Q6Mqky+6GELkc4lM8BUWMxhQ7ShUSnbczxN+QmkUAo6os2h8R4LK0bSul/Te+Stw+6t182POpwgkyXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8478
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

From: Kunwu Chan <chentao@kylinos.cn>
Date: Tue, 21 Nov 2023 10:12:17 +0800

> Thanks for your reply. I understand what you mean, i.e. the caller of
> 'kasprintf' is responsible for calling 'kfree' to free up memory.
> 
> My concern is that in many scenarios, the requested memory will be
> released after a period of use.
> 
> Has anyone else forgotten to free up the requested memory when using
> 'kasprintf'? e.g. 'dam_heap_init' calls 'dma_heap_devnode' to allocate
> memory:
> dam_heap_init
>     -> dma_heap_devnode
>           -> kasprintf
>             ->kvasprintf
>                  ->kmalloc_node_track_caller
>                   -> __kmalloc_node_track_caller
>                       -> __do_kmalloc_node
>                           -> kasan_kmalloc
> 
> 
> There is no function like 'dam_heap_exit' to free the memmory allocated
> by dma_heap_devnode.
> 
> Another case is 'cpuid_devnode'. Will this cause a memory leak, and is
> there a better way to avoid the memory leak in this case?
> 
> Or is there a uniform place in the memory management module to free up
> this memory?

If the lifetime of the allocated buffer equals to the lifetime of the
kernel, i.e. it's allocated once at kernel init and then used throughout
the whole uptime, there's no need to free this piece.
Temporary buffers or buffers allocated from a driver are a different
story, their lifetime is shorter, which means you always need to
manually free each of them on exit.

> 
> Thanks,
> Kunwu
Thanks,
Olek

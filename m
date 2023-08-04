Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DE8770626
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjHDQi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjHDQiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:38:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEADE7;
        Fri,  4 Aug 2023 09:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691167099; x=1722703099;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NzL2RZwnEHb4Q9WQdA+ityHPfJplbt84qWMWrW8T+mg=;
  b=DJaKkM1GEZF7VyFrUajEHgaN8QCbf7fopcccsa8S8K0smMwLkYstv5iS
   Weg+YHhOd+MVhmgyJT6n/JgAYFRQp3o3XnHR71lQiuMWUs7tRtgeYouro
   dOdPnDFjVOt1PMB9PyKOPvd2HCse/MR8IzbqSNFWKs0pCS2Uj0Bt3Z8bD
   ZcNJsWJ22PD1jTTQw+/seOsoDVipNWK+f71kcBK1Ncr9ZcITa495/IxZ+
   AubrOUkzuDtoin4TsRzMQaOuaHLD4hxE4gVozYjqDotmrt48c0sZUAIGF
   4UJ0l4QYb3VnBozzZBYToNJ8VuBifcTSJ4crGhMw/MCfNdoID+laZ81tB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="436515014"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="436515014"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 09:38:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="765173160"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="765173160"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 04 Aug 2023 09:38:17 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 09:38:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 09:38:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 09:38:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyEdIGgKHZpn3sbcLQDhfXg9js/QHw+WBd3u5BlxyLAPyV7aFzKYEOqaskH+tN25eoY123m29Beo1QaxiWUM5HaRIkvaxqUq8f0Wzwb6GIGFOcnXAVPXuLcmddpP8gpjg35GlfQXVylrAc2WTTn+sViRDC+futIN5XoJQnKNTTh262QMl+8H5QbYyhubXn0Q09pXLws/mYuTsVCEZewjSM8kwGLEUYS7H0lox5nBmh73lCXQHtBLtzw3DoPuf2534F3vA4ObloSnriwEg6jdZGWNVPxHUEHjb/6gCu53JYjFXOwYfrnWHLhhHOyEDYzn7U2TZHQklkcf0ks13TsaGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygT04tMXr/tUCxB/tci6ZSBcBhyH/QLXU3Ur8GO2MJM=;
 b=G9MK4ep5VAuCXkAdStw0Pm5Mltp9HwbPOX0p5NuGdJS97++NtNsZTY2hjg6jm7LsWf+8yNSHLjcfVZd6PCUgTxXARi87FY9s7kTK8hCeDlHKmKh+l0A7s1HGhP+RSL5MVKeCR/MQzxpmlHd7/sq+YvFnpgkWHbZ7omLduwLhUhVNHH7ESb4ownmBm0M8VQhZ7UHjHO/v8NbsahG/KHTJ7JCDYkqunKL1Nfk170/+dHeYW2pheMe17y8/kkPx1IyC+Isp8LrqOkGFCxHQyIGfaT9yDXuvXMOaFxLnBtdcBEOglifzf1IEeNndKQPYIdY2BJlVMhd7boHbdzueIzMISQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SN7PR11MB6993.namprd11.prod.outlook.com (2603:10b6:806:2ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 16:38:15 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 16:38:15 +0000
Message-ID: <88dce445-180c-72d9-c7a5-f0a18a18c747@intel.com>
Date:   Fri, 4 Aug 2023 18:38:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next 0/3] virtchnl: fix fake 1-elem arrays
Content-Language: en-US
To:     Tony Nguyen <anthony.l.nguyen@intel.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>, <netdev@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
References: <20230728155207.10042-1-aleksander.lobakin@intel.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230728155207.10042-1-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::17) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SN7PR11MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: be768310-b8ba-4305-217a-08db9509336c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GRfqngciksLOLwjYdPUWPQX3cW6kL4KHeCR57OUv6XcnBr8IfYtj4XynoEWW9nArk4QPDdEKiNVXx5HtWRkYqGaU51GK0fGdNnr5nE8j5ysLki6/knuwz7pWKg6eu/0Yhi029Xvc1342pon+SxgqB/QJKmBrISFOKr8bbGth2+/E9ggjXayj6kWfLUzL/GCx1uROJC8EcDUi5F2VykOKUK+S+Xxc9qdSZfPWsPIbllOgHb5vwXtUh19aAuhQLp4NlzjrdiNuzFY3dWPzXrb8/BVV0RImspKEYToIFt5twYC9cEtE2mEczrtm0OwrqR3WPUYdJUpM9z0MqIoyWN50EO69zk196shSWyPx4Z2SiDMJAXQ45jRUWdZYZwj1U14GfGIXIksm1ZOTyAYClC3jQoHTI7JanofV6OxM4AItg0cAjCVd9LaITjw4yYE0dONQwQvUec0Xxi+NTHxobf3D3hrrSAwOTKvT3bDdtrK70Kd85iQWyYYjZoC1Y7pkOB9YQnh0ewlTe0XyEW6eeNI35eYASE489pA305Fs3rnkCT0OtxacjjHcnMKXg+Ik17as9vRXDmRmDc2ieeJiw74uV11ujnn2+t0UmWOXYaRYVI7HhWGfALl85Ou45xcB/C2+9g55pzmc8yLpm0jHK2tQDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(1800799003)(186006)(66556008)(66476007)(66946007)(2616005)(316002)(4326008)(6636002)(5660300002)(6862004)(26005)(41300700001)(7416002)(6506007)(8676002)(8936002)(31696002)(54906003)(37006003)(478600001)(6486002)(6666004)(6512007)(31686004)(38100700002)(82960400001)(2906002)(86362001)(36756003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFFZTWlrV0gvdU9XRS84anN2SzdvY1g2aGFJcXdCQURpbHZiRFAwSVVhU2hU?=
 =?utf-8?B?cE0vczZ5Mk10TkUxQ2toWERJanJkbGNOdHIyTnd2Y0tMMHZMUE5VM0RMcGZ0?=
 =?utf-8?B?aFpqZGVBYzcvdmJDZ3RqMUZlT2srSEVTc3poek16bFgxc2grVHZCRVZFd3o4?=
 =?utf-8?B?ajJMNUNJbnhNMlBmbFdYemxqSUluMThEYVlnV2NzazFrR2sycGdNUUFzVSt2?=
 =?utf-8?B?UW9wTGo1bmhpOFQrUVdSQjlVaXpVK2YrRS9CNTliK1h2d2hiTWs4ZUVUZkl6?=
 =?utf-8?B?SkZlQzZieEdDMHRTcVdMWUpnWm1sRFFvMFEzWDc0L2RMMGlFT2ZwVHNQcmVR?=
 =?utf-8?B?ZVhtWFZWYUl0T3Q2Ykl1TUtya2VyQi93TVhneXFoelh6OTF6RFFLNStDeUJH?=
 =?utf-8?B?TEthOTZnL1J0QXZQS2JHR2hzUi9FN2Z4RDYxKzhGd2F5THlWN2V1MFE4cDlw?=
 =?utf-8?B?ZFBmdTJFaDlLK3NnMnNRb2FXaTlnd0NPRy9HSUM1eWhUOTVKL2NwNG8vR1RE?=
 =?utf-8?B?bXJmTEdEOFJlcnNOc2hMMEpZREdRMWtNdUpOS0xhYVVPbTBuZXh5ZklJN0FR?=
 =?utf-8?B?NlBOU3gwU3pJSGppZXNyaHhId0FGeFdrTmp3RlJTMGxlWmVsOUc3STBJcnE4?=
 =?utf-8?B?WG1PejA2MTM5QStYUGVEbTdQbXd2VmdmZ0o2UWFKYkNvem1JVXlOalVmaU01?=
 =?utf-8?B?VlQwM082MUZOVmF1b3p0SHluUjE5WTl6ZndDcUFHb2Y3cUhNbWV6U3hNUW9X?=
 =?utf-8?B?NTg4VXdXb01qNzhFSGo0eUg4L0xoaXdmc3NsYnJ1NUxzYnpIaEFUSGJlMUpZ?=
 =?utf-8?B?K3ZmR3pTclIzYkZ4Mm5JYXE0T1d3bUF0M1VlRVFlMnIrem03Y2pWYnVYOUgw?=
 =?utf-8?B?ZlllMk5GSVlIMDZNRUVpcUd5c2R1MDM0YTBaOFBSOGpGd0M4RW80V1o1QUFX?=
 =?utf-8?B?S1hKWnpiR2FEMDB4dVlJa1RBZ2RjU2tHdERnbllSazNRT0NRelp5S04yc0Zw?=
 =?utf-8?B?c3o5dFI5b2RkclNmTFVVYWFGYmh2enB2NFJxY1NqZGZsUEh1SzZhWkRBdlhV?=
 =?utf-8?B?b1RrT1pMZW5kR3d0ZjZWYWt5RGJuZHN5M0FPODE1Z1E2emdYOHNOaVNkWlBF?=
 =?utf-8?B?RWtJYWx3bGZCREQwWmhIa0kxbWx1NElJREhuQ1VVS2t1QnFnUS9qZFpCVDhl?=
 =?utf-8?B?bGw0eXEzUWtoVHhmS2IrOTBjYmR6R3Bpam83Vlpuc0ZxSTRndllMUE56aHZy?=
 =?utf-8?B?RVBqSGRoRGFLSEcvU2lvUDJwbTV3Z2hmdTdzdm9IOTN2Z2h2OUptaWhsR3B4?=
 =?utf-8?B?QUY1WnoyR0luUUNSVG1qL0V2dll0U1lEYVRHZW9qdzc0cUk3VW5iNTlCdm5z?=
 =?utf-8?B?Y3BPTzVrQXJ4TzZiU2RDMjBJUG14Z3JrbDdyUWgybHdjdDNHVkhNV3VZU01Z?=
 =?utf-8?B?c1ErRDNmbERhWElwUUVteDVjUjRZcXJldDFJVTFOK1lOZzNqcGdCZkkrMlE2?=
 =?utf-8?B?VlkyMG5TdlkwK3c1Rmp5ZWh5WWh6YllhSTBhQmQ0U3QvMUZEenNkQy9Ua2l4?=
 =?utf-8?B?UHF2U1FzU2N5aFNSVGZRM0JIRmRQMjF1bzBIeHlTTmc2em1LTzFNMVZTeXJB?=
 =?utf-8?B?azBlOW1nL0FGTTQvaWJwL3Q5cGd3UzhtOTdHNnY2c1ArZ3NzeDNma2RYaUxS?=
 =?utf-8?B?eDN4Nmk2ZDZDY1lHOS9pK0d6eXJZaVNjVDl5U1JPR012M1paUjNrQXFOWmdn?=
 =?utf-8?B?RVdLVGxYWjdDVHc3ZkJleGxxa0VjWEwyRTJlbFRKSmZ4ZmFhZkYwUkl2T2s2?=
 =?utf-8?B?K2lraFBwZFcxWXVPRHA4VWNyanVUc0lKem5FTG1yb1IxNmUyUEczeUkxQnhH?=
 =?utf-8?B?WEpNczZhZkRmYUJRUGN5Nnc5aVBWdEZWL2VCbG95ZmtyQjJZUHRpWlAvUHpM?=
 =?utf-8?B?aitiUHRwYmNma3htNHlnNStVN2hwV0tKQ3dsVmxFaWUzbkNmYkhTL09KWWE4?=
 =?utf-8?B?V0NQV1FpdmVnazRwakIxalJGeGZId21MUS9MSFhjanhBZkpuRUY4QTZQZ040?=
 =?utf-8?B?R01YK1pNT0dHUnFxSkhrMTllYUZEVXJROTRibWljWUxSZ2tYWkhOaHhBdFhR?=
 =?utf-8?B?TUNMWlJ6U1pLbEVaSmF0OVdvWDVBLytJVEpoY3NqK1VUVXRxM25Gc1lrQUp0?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be768310-b8ba-4305-217a-08db9509336c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 16:38:15.5350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +KYpUlLzhnyLQvTxXwadePbAu+/97iiXtQu65xyGANT0zsbJIGYKLiC9Jwg8AwA0/37W8feVV9IWofIdKX2OxA+rVNxd7isbjq63gp4voiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6993
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Fri, 28 Jul 2023 17:52:04 +0200

> 6.5-rc1 started spitting warning splats when composing virtchnl
> messages, precisely on virtchnl_rss_key and virtchnl_lut:
> 
> [   84.167709] memcpy: detected field-spanning write (size 52) of single
> field "vrk->key" at drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1095
> (size 1)
> [   84.169915] WARNING: CPU: 3 PID: 11 at drivers/net/ethernet/intel/
> iavf/iavf_virtchnl.c:1095 iavf_set_rss_key+0x123/0x140 [iavf]

[...]

>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |   9 +-
>  drivers/net/ethernet/intel/iavf/iavf.h        |   6 +-
>  drivers/net/ethernet/intel/iavf/iavf_client.c |   4 +-
>  drivers/net/ethernet/intel/iavf/iavf_client.h |   2 +-
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  75 +++++------
>  drivers/net/ethernet/intel/ice/ice_virtchnl.c |   2 +-
>  include/linux/avf/virtchnl.h                  | 127 +++++++++++-------
>  7 files changed, 124 insertions(+), 101 deletions(-)
> 

Tony, could you please take it via your next tree? I'd like the
validation to make sure more different host <-> guest pairs work.

(with Kees' tags, assuming he reviewed and approved the whole series, I
 asked about #2 already)

Thanks,
Olek

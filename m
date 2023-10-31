Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465137DD6BE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 20:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343817AbjJaTrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 15:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjJaTq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 15:46:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FB8C9;
        Tue, 31 Oct 2023 12:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698781616; x=1730317616;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6qRXvMoI6GFZWxhkzWfIujyTfeFBnqM4/jeGRFDI9nw=;
  b=I7dg3O7W6LpSlFt2uKC/whBiKqFCAEujHoFGcz0rFNJuF384o0O8z4fm
   r7VGR8rxB/cyO09apZy4eXAXZ//63bT8x9F9evvMYeIZYx2NrAkxJ9IDl
   RbQrirM2EVbG6RVrmd1X67KVCrynmtognJLuwDgCuSdFTSq1Mad18S56T
   /cOEJnnfoVibjFJPBeSSETDWtzcCMbHl6A9+3s3x+REmmX45uKziDoiLr
   dtfPgRWmchjJllfQXnzy2CdrOPrig1qjdpFlHGTF1PJmqLFYbiwEg6J+D
   +oU3YEsQN08xKL8NOiR7LF7D3eTv37rfJAEm6VfXlLiYEC/c4Jzk1AmQu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="367707574"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="367707574"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 12:46:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="826536638"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="826536638"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2023 12:46:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 12:46:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 12:46:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 12:46:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yi0NHlXyx/lT9vlYISoADz6xTujLtGM75aNvQoOU3B0/ZqeZekqZwFMZEsBs1BajOfTHwgsF8g2VNTGRhTsVB/zlsudmBVXQKjO6g7+ZUe6kBam8dwUA7lsvu22d4ILSz6TQrwCZI0HERLjNmicB+rIfgt9CoRYrRfDxqHhIQBsuKDHxKR1+YU7D2Qvr3v7aBTgCSGICzRNaG1qH2P02Lfs2jypBbbWDVWW+/EKS99qrx2sZVnM1p/yqCY468J4xOcdp5wmEqG7Fe9OEH34nG/99mO7AacY5bFZ/YlHBLzbLjAgBW/TPMyEWtPQw+n/ad/JmenoTwLkyiNR/3T9IKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/hPpcHDPm4W/XTfXpKuuGjk0Xdo48WLk8doXEJ7yDQ=;
 b=ZiD4X5FZfZwEmuXvY1X4hwGK4TZa91HfY2HYJVqBhXG5Wm+lFYsqmwwUJNiLLUpGss2H8itBR/VuD+tVqC7PzYCIS8EuwJCxqhuLxGaTU4dF6yui0nAkmM+duC26oWWm23ANXTmnJWE8Y+nMImfnylKNoSRjbnIL6o1LYudYjjeYQYDDpIKNg/ItqqmnjWF86q/Y6YxCmU7QIFoRyJpsuumJuXVBgY/nXvii3FKFOq/Mu0JkqLZ9EhLl3MX0mFrO7Mdo9bdoCOTl6dBoK8PAGYOevQMij62jgcR9ZGudokd9/FCadTXt+Gh00WCQnU+W0AeDZJg0Bk7wGrkAdevS3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB7639.namprd11.prod.outlook.com (2603:10b6:806:32a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 19:46:52 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::5e89:2476:6382:34b1]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::5e89:2476:6382:34b1%4]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 19:46:52 +0000
Message-ID: <f2f3a5dc-8b00-400a-9d3f-f10663ce8857@intel.com>
Date:   Tue, 31 Oct 2023 12:46:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] r8169: Coalesce r8169_mac_ocp_write/modify calls
 to reduce spinlock stalls
Content-Language: en-US
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>,
        Lu Baolu <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>, <nic_swsd@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Marco Elver <elver@google.com>
References: <20231029110442.347448-1-mirsad.todorovac@alu.unizg.hr>
 <e7a6b0c1-9fc6-480c-a135-7e142514d0e7@intel.com>
 <a85e41ab-7cfa-413a-a446-f1b65c09c9ab@gmail.com>
 <e1c666d8-c7f0-440e-b362-3dbb7a67b242@intel.com>
 <19e2d5fc-7e30-4bb2-943c-f83b44099192@alu.unizg.hr>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <19e2d5fc-7e30-4bb2-943c-f83b44099192@alu.unizg.hr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0017.namprd16.prod.outlook.com (2603:10b6:907::30)
 To CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c58e57-4269-4f24-a0ca-08dbda4a2130
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rSGeB6nntX0Dl43k6nGBi9HilXW9U4GKrhas56W6VA2jTIxYZGAC/HV24Ai5GulmRpMEk/Zptrf13d1jjUUCQP5mH3GkJWOc+dHFnWzy+2p+d7BbcqlO1dyLmIWhw/vL/r4b+8ijMWQHbYefAgDuU+H9vwnN7Q8vTmUgJzerjvFOhkjnh+ECsHkU9iOxESxDw3QsFVNVM9FFPaj9hdkY10e3+L3g4j9fcmA4/4KRHfxj5udpfn7ltnIAJsjwO11AC/WLgJGVSfKmyhHRc21t+ndwSAIwDvbxQ7icgcOmpsm8UI49UnZctN/7ryEm9nrKr/Qg9HFB6wGhX3lt1mT3FKOXy2AG0yXOAQrZG1BA+vP5ktu4R1O0qPIfWbIRtZ1xEFPoKw/U0QbFGku+AwIjpUcKRmsEU+pN3hL2Ib93eDxsi7XRI7X6I05H9ZNgO6ftNWsvnCJJWO1Wc1kJn2aGXK08ApeaBu5sGr+3OsbH4dg7wOARSThkdtMJMMeEJobVLmrlYJ3Lx/yGqawUUJWbHyIgPE4JXFVswRztPYMZNDGmxffjboPAk4tNhgKY3k/sJk3Piy+hNg/mbUILnnWJAWunGTSL+s0Pc6cKmMHUGWHYfEni/F0dYBuWzPyJPZBBxTzHcs1c0Tnd5gTJp+2pCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(366004)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(8936002)(4326008)(8676002)(5660300002)(66556008)(54906003)(66476007)(66946007)(110136005)(7416002)(478600001)(2906002)(31686004)(6486002)(316002)(41300700001)(6506007)(2616005)(53546011)(26005)(36756003)(6512007)(82960400001)(86362001)(31696002)(558084003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTJHVjVqUlFJQmNCaHlJcENzRUhWZ01xN3RsNE5WdDhscjVOSWlOOUk4cnlZ?=
 =?utf-8?B?cE14Y0hGWWsxMXB6Tm1WMUZyVUs2a0tvOFFtQWJ1UjVoTkszd2Z5dStsc1pN?=
 =?utf-8?B?Nm4rdThKOXZxdVBrNXQ0ckh6aDE4cEFGYXh3NTNzNlgzekxsRXJyeWt4S0xM?=
 =?utf-8?B?aGhIM3VjNHZIVlpldXNNN01uaGd6TEZjSThMTllpZmZBZnZ5WE5nb1psZG1Z?=
 =?utf-8?B?Y3pYSVhMY3R1U1F1V2wvcHA5MUMrRGN5TGMyS3pzOHRacDM0WmtPTWdZbFYz?=
 =?utf-8?B?eGp1UnJzS0lnaVRZREwyWUZEb01HODN2cDZHRVlDM2lrY0RFSVBXcTNsRVNV?=
 =?utf-8?B?bXZaSnFsaldqV0dhM3orUE9qY1psbUF5TDZPWnVCYWR0NFlEd0hWTnRzbXJS?=
 =?utf-8?B?RTBEd3hvQi9HZTVFOTF1QUlRZzVhNmhPK3I5NHBNcTdsVXl6UGMwY0NUNGtv?=
 =?utf-8?B?bjNVUzFVdkRLNmptVUFGUEVxd0FzcTZLbmVtUHZaQVVYUGRCT1huQkVqejdw?=
 =?utf-8?B?VXpObCtJazIwWVVNYTJkM3NlVW55RGk2aXBGVmd0UXI0K1ZoaE5yZytIRTVk?=
 =?utf-8?B?TGdtZUxXd2pHckgvZTVRS3ppQ3dyOEZ6ZCtHRS9mN0dZMWt5emNLb3MwcWVz?=
 =?utf-8?B?VDhrWko4dHN4U2lxZ2hobjdaNnBub0VtZWlFcVJRdVFxZVNhQXZPWHFhWHk1?=
 =?utf-8?B?YmxqakRvRkhQZlV6czNUb0UzaTIrQVNqcENxaDRXREI3M2FuZjhEcUtNL0Vz?=
 =?utf-8?B?ZlplMksvaWd1ZitWOENJV1djLzY3QkJLNEFubE5QYkVyeWt2THpkUXVDM1gw?=
 =?utf-8?B?cDNXNW9OUmczeVFhc3NQRExmWW5XYUF0RlNhRFZjNDNjRXFvdkpyaE1IWlhT?=
 =?utf-8?B?dU4rbWl5azV0ZFFVYlV0aE1zNkdHN2xjNENwMGtndWkyaXd3STJOSisvMWNU?=
 =?utf-8?B?Y3JQTEU3ck1aL2xlNnMwNFpneUpMQVVBSmE0Q1JjVDA0d2plUVZNeDhkTXo5?=
 =?utf-8?B?RVVSYS9oaTFpMzM0em56QXc3bTluaERYeHlZWitqNlk5bnRmeTBwdzI4WUpP?=
 =?utf-8?B?WDlQNGtqcTgzNThwdUExZml4UWttS21kQVV4U3lCaUxlSEN0M0dhQkpKSGdo?=
 =?utf-8?B?Z0V2b28zcUMzRjJZUHVHYnFBaWZReEh0azIwUUxrY0VtditTR1JFRVkrMFQ3?=
 =?utf-8?B?eHBRQkZCMHdRREJycDdOTERtWldUL2IxNkZ1SXhLdFZsdTZBWGFrZktTVkFN?=
 =?utf-8?B?Y0VhamhTTGkxQTNUa1FVeENhbEhERDF4eGltcm8zSzFla0FHZG96bGg3RkdY?=
 =?utf-8?B?VmhMVVhtZkUvUkVjTTJyalE5NlliQTBrTllUZTg3ZDhpaXNnelRHdXpiclhS?=
 =?utf-8?B?ZXd3dmE4MkhNTDNyN2hQNVhobVBGR09SVitWOFU5RXBRZm5QVDJSci96M3l6?=
 =?utf-8?B?cXZUSlJCQS9oTE1hNWduZXBSTnNXWWovcjFzYXYxcU1QY2xSZytoL3F3VHNk?=
 =?utf-8?B?MlFJNmJGNjA4ZzBLS0ZudXF3K2NCM1IvQW1wczlYYmFqRkQrODNHVFRJY21L?=
 =?utf-8?B?YzlnQzc0c0lhT3gxc1Jzdk9Fdmd4MkVQR1djOHdvdG4zeW1NcU1UU0R5bkw1?=
 =?utf-8?B?a1JndVAzSmt3VkRvWUpHaWNhVVBxVm42ZWF5VEo0alVOQXQ1cDgxNFVXNWhM?=
 =?utf-8?B?NmsxMlhKaDllcUkwYXUvNlFkTzc5dFBpQzdqUVRXZFlhZEF4dWwwZDE0OGhu?=
 =?utf-8?B?Qk1VU3hNTnpzeWdwS3lKbFhjeDZMYksrQlNOQVdoaVI3WHlUeXZSbmlkZU5N?=
 =?utf-8?B?amRYdWNrbWFQVTVuVVJJRlpldGExQ1d5TWJuSSt4TlZmMVZFa1NWc3dXU3kx?=
 =?utf-8?B?d1g3ZUxHSzA4R2VWWkdqK3ZKdnBTa1MwcHZLNG5CYzgwdzQ1SGNyeitVMmpP?=
 =?utf-8?B?YVBSRC93SjJGNTR0VE5PenlMOXBRRlQ1eDg3S0JEdE9DWTAxTU1ubVMycWRD?=
 =?utf-8?B?T0JIdm1YbzIxUW50UVd4Vm9KV0lLb3dtUDJpcGVLNTY5aDZuUVBLR0xoZ3lF?=
 =?utf-8?B?UE8vVjJzNmVuc3E1d21JYnFUeXdSMkVXaGhld1pqcHl6c2h0MWE2RnRnNHVU?=
 =?utf-8?B?bWZoM1VrSUJSczdaZ1NnV3hhNllZQ2Z6a24xZWljVHRJeUU5WFJRbHo3dGVp?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c58e57-4269-4f24-a0ca-08dbda4a2130
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 19:46:52.4263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXbSWcZlFXbH1//PljBlzsM0Xy8/d9u4pJNeYBq9hUlD0m/G7S+vHdRWK/2WEedOQ6F4EMxYdaWXcByAHF+NQrMMB2Wwy7V/hJBEeQX3w5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7639
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/30/2023 8:51 PM, Mirsad Todorovac wrote:
> Am I allowed to keep Mr. Keller's Reviewed-by: tags on the reviewed diffs provided
> that I fix the cover letter issue and objections?
> 

I have no objections as long as the content otherwise remains the same :)

Thanks,
Jake

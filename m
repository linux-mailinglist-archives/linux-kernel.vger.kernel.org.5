Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C457D14C1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 19:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377862AbjJTRVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 13:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjJTRVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 13:21:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF3D13E;
        Fri, 20 Oct 2023 10:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697822474; x=1729358474;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HZiQo6p7kF5wLeOo+3EOlPcaTUGwEbGCoHco1nL/aHE=;
  b=OI9YguVmH4zKjV0crVWXNEPBCFs8saR3oX/TjAi+6oLr6EboBN2LfEYh
   PKI4fmdLObIxphFDt6ibASGGAfoUnvZB4QwoLHUUEEbvOho6XhGFjIvAn
   i6jeqlz7wQb5io9goOp4VtKUiNGMTluWypLDdLUVqQyd8DrnpU4whdaFC
   9jOqRF+dtCpmK5K4TjBYrvI+SKvI8w34sBmqi7QsNmXdseZq354I1QF7+
   rcPfgZYeRzruP8Yi/xMSY1Bvm+IYS21djrATyfeGTA+KCnuJFF7mkLx53
   i+KhOIugfaJuZliWc0+O7iP/qsIJO07H15/UOwsZSx74X72mRHqJUWxiw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="365877029"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="365877029"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 10:21:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="792474800"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="792474800"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 10:21:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 10:21:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 10:21:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 10:21:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbTgIElQP0k7bah/GQwq+XKfjKoLwVdzDI65JTwpzn/YKK7IJtuMv3G57S/B9ceRyJoFwWjVQBxfe8vLkcINAp71zC9pJl2varjWWz0Rc1PGPjjQ1WG/nVfGolqUC2TLjPXH9t5YVHZ60lO9FpRjLop6wtCIX28FGhGLPDpdCriYsc68CpLmkabjn2AocYMSsu3agYEaJ00lg7DWXZEDdF6Pt8oIBUn4f7Tm4SCHnl7/eO2yiJSlYISlDuiIh/uznx/JFHuVb/d5Auoip4UGzN7YaOCGzPhadaYrNcStEVcRrTtV2gKbw/bnE7gAaijoDxOUu2nIAO835DWWFideIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZ/loWz7dm7Vnj589swRxzvXC/5qPi3xYovd99MHPnw=;
 b=aj8MVzcBw+KkxFps+GlGoz8aMJ+Ezk704wcbgJCHh0YNRkXBonpAmzwEnf3m/BY2PM7n8MePM7cZmf7KFS28EHCtwEYjmO2J3J0m0ACS35kkDJSFqdK6qgbjXkuPMNijjc32FO98PiWMvsqwMeBK4g8uV5hmHwnnnYfGjNrnnFfWzMGISQ0fvHDtzsG3N6b5cFQad5ECQCB4xk+glKzEYcfC99H4PrJnBgdZlCcTn/gmIFsJqx7k/UXmXHp5dXdZW0AyafTbCRkGWF2bsWe6iXPfPOeRBgEwuezbAkInttaLNztW0rQ9gAMiQAtH8Jt6D6GAJMgq8Tum6yNZKZp3qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW4PR11MB6761.namprd11.prod.outlook.com (2603:10b6:303:20d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47; Fri, 20 Oct
 2023 17:21:05 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4%4]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 17:21:05 +0000
Message-ID: <999161da-4f03-42db-b444-d9f094163479@intel.com>
Date:   Fri, 20 Oct 2023 10:21:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next] net: microchip: lan743x: improve throughput
 with rx timestamp config
Content-Language: en-US
To:     Vishvambar Panth S <vishvambarpanth.s@microchip.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <kuba@kernel.org>
CC:     <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <richardcochran@gmail.com>
References: <20231020185801.25649-1-vishvambarpanth.s@microchip.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231020185801.25649-1-vishvambarpanth.s@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:303:8c::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW4PR11MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2f6bf6-298e-4c57-6f6b-08dbd190f137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XzAn0rxwHIAijYmTRTbUbANrc5OOUVH4sLKOwoHzQ8IT71EemxrvywfBNjk5t+SIgp3s2/NlKzkDiSA+HbiSruYa7z6Pyk7AC5ThpPALOoK2++UF5q+fo19+zWFrKdYV3n26fkaSg9TZ+Zj5KZ4vjXE6MJ1Y5nVn4PfZyVVzIShjdPpC2m02OGSzqxL/zmLMVB3lmVhkKR4x51U2nVBu2YDviwQ2O3TzPjVRYf/Lthzhgv3XYYPrEDZo8PAheAIDO0FtUUZ2rOtbAiahk9bntxL1x5cS6PdFcPTB3A0DB0IgareRNvpYeSd5X8pUiAXxjEyROTwXKdAeIBpcaU3rj0gGddEhBXaz5fn0C/CSocicyEcfpehe459ZqyZi14oVQHkXXl4+TPJupBilC/qK0MGondEI58tobS4eqTsJaoUxWs9MPYxkwRWvOL84iTOxP0nHz74We47fT4R1nUlNHjN07dQXN0ZY4i5Ml5UzFHPn4G/H3BfGuuJ7hM79XEe2AyWcMw91Spt0izp1ve2t8C7265DrEf/EiPxcqwr2OowCNChVetkmvdZpKcrNWetw1v/IDgU4roEGjUhPNcjmvWWcjnToPmiaAPzGWygTEEgQBEY6O0jwfccLKp3feQPHwdg6qU9nU5DafzhQHLmzUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(366004)(346002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(86362001)(8936002)(31696002)(38100700002)(31686004)(82960400001)(6512007)(53546011)(2616005)(41300700001)(66476007)(5660300002)(6506007)(316002)(26005)(8676002)(2906002)(7416002)(66556008)(66946007)(36756003)(6486002)(4326008)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGVjb2xMTW9senRpSTlqK2pOd3U5UGtTV2F5dkIzaHRTNjZLclBUV0Z5NEZY?=
 =?utf-8?B?ZkljdjlRaFQvaGN2dmFWbDQwZVd4enNjdWhCK0dZTEJ0anNBZ1BnL0NuSndR?=
 =?utf-8?B?ZUtSRnVnUHJhc1VJMEJFUHYxaTY3OHhmb0p5aTNlV21kay9GNDZoTlNMcWpx?=
 =?utf-8?B?Q2o3WWtYRzJtV1ZWZzBCeFNyNElRSXRUTE5TVC9mYmJUaHN3NXlyaVc4bmtl?=
 =?utf-8?B?L1BFK0tqR1E2bUl5TUNjNWw0cXNxK044eWhuR295R1NiYWwrS2JlOVQ1bDZE?=
 =?utf-8?B?dENqVDFHQlJDNDF0dlFJSlFnVmJ2OVc5NEIzZWN4Z0xvY3RNOEdYdVFUckli?=
 =?utf-8?B?TzRseXIyTWgvSjZSc21MQmRYUEUzQzhtdTQ2QmpIZENhUGt4dTA0dFloMkk5?=
 =?utf-8?B?MUhlQkFwalZteHcyaWR4MTR6bUZOM25qTUlNaGNCYkpBL0dVMnhucUgyQ3hw?=
 =?utf-8?B?U25DVE1jUHJOeDdWZzZvZk0yalF6N2h5T2Jibzl0cVFydnpQczZDR3dmNzhJ?=
 =?utf-8?B?NE13NG52YjYzaVBPdVpjdFYvQksyN1paVXNDblIyT1V2a3RSMlNoRWZQaVIx?=
 =?utf-8?B?NFhyRThRNHhjRmxDY1JMclRmZkwxVkF3QzQxd3VER2FKQ2FOYUE2Q0ZsZjAr?=
 =?utf-8?B?SzZtWjEwTW1vb3M3OFMzNzBiM01GODF3b2JxSjVWUnNyVVI4dnIzSm5DYktr?=
 =?utf-8?B?eEdmYmFmdlBwWWJ0eWt3MWhidlJRQmEvdHdpa2Iwb1FRNXVqektCb0h1aUNh?=
 =?utf-8?B?WngrRFE4YzgzN1daUURIUG14Z1pycUFzeTIvcWt1MnRhaUFCUXdVZVpFdENU?=
 =?utf-8?B?THpweVd1WEN6Mlp0TFhPS2RKMXBEeGQweEFac09yVnBuSk9TT1J2bmxKcS8r?=
 =?utf-8?B?Z1JYaU9LaU9sWW1LcFN4SHVvNGtqSmViam5BZUJpUlhrZm1abWlMRDdCc0ZJ?=
 =?utf-8?B?U1dEcHVkWTJiMGlxVFBkaUpCclVKZU9TUGlKZ0NJa0pWR2NlRytiZmdzc2dD?=
 =?utf-8?B?Q2FWQXlqQnRhUEhWUGRZbWxIWldjQTBacmJ5TGdXcnFaMWp4SWhOVStiemkr?=
 =?utf-8?B?WkgvQ2FGVWx6Q3ZlVDBkVUZ4KzZ0MEVDTzN2WURlNW0wWGlGQWNtLzJyc1pG?=
 =?utf-8?B?dUJ4ZEl4MUdTSnlxTEFGcHFTSEgyZTFxR2h0K3lqOWs1NjNYTTRYWGY0Mmp0?=
 =?utf-8?B?MCtHb1R5REZOZXhhVDcrdW9tblIyZ2dVQStHbzVtaFJhVG1aL3VWdHcrTEFQ?=
 =?utf-8?B?RE5lcTR4UTZXTkV6SWlvcERNT3g3WG80aGZwTTQzVWg3MHdja2pveHZ0c0Mv?=
 =?utf-8?B?UmQzWHczb2xodHJQclBEcmI5dFpUQTJuMHovZUNQeWFWZmFLS09iK1FDR0Ro?=
 =?utf-8?B?UHBLZytPTk1aV2FVcG10NXBlT1NhcHZaQ3M4Q205ZkMvVTVLWTd5bXorM3M5?=
 =?utf-8?B?UHhVdEgydTlpam4rYTg1QXhkcnRyMnIxSUlYTWR3djNPcythV3gwNU9jVDQr?=
 =?utf-8?B?bE5pc0N6UjJyb0g0S3QvN29NNzR3VXB2UThOWFJEcVJ1cmJySnVVZXArQyth?=
 =?utf-8?B?V2NndjZxWVlVengyelpocElpM1VobW5kRU42U1FqOEFrZ0pzbkhvWUZqYkhi?=
 =?utf-8?B?TUZXYUtGVjdtWHFhR2t2YTF5bDZtUEt2cm1EYzdvK05yWlhPaEx6TzRNR1pm?=
 =?utf-8?B?dTB2RVZTQ1dscVQ2RDllSWwrR1FUZzB5OGoxVGZBZUFFdUJtTS8wNWIyRzJv?=
 =?utf-8?B?cmkxK3krRzd3T01FM2liUzRYNW83RzNISTVNVlQweFl0MXU5UjhCN1R1WG5E?=
 =?utf-8?B?aERvRlZIdDN0dUNjcE9xMEc2WE1VWE5RNEVCQ0Z0VWsybzlOd3Fjd0Y1d1Er?=
 =?utf-8?B?THhuamJROUsvOGNTWHZaNjlUWWdScEEvbW14cktudjkyMHV0RzBnaHRhRjIy?=
 =?utf-8?B?ZUFXMnpRaEl2eUZteGUvbDhXNG1jM2lMemQrYy9LMzJBMjZRTzhQNTlXbFZY?=
 =?utf-8?B?U1hVRmd2dkRhL3UvdG5mTllGdmp4SS93SCswUitOQUo5b0x3aWQyM1ZteU8x?=
 =?utf-8?B?MmE2WU8wNnhoeTZoZ1lZOGNGQW9ITkJKQUdhZDVzUUxUaXI5S2lZQXFnenJs?=
 =?utf-8?B?NnZrQU1Hekd4WVhzbUlURTNYTWdibUhEalltVXo0eFNIZXYwajVtUHJUb3FF?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2f6bf6-298e-4c57-6f6b-08dbd190f137
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 17:21:05.6664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfTbUzzxyrkZM4lVVx1hw0UL9/F+/Htq3gQQzxcT9ggldsdghfhl77k/GXv0EWqqr8XFyl0gTCyqYbyxBUa6jZQeysD8z/AjIFq+SMkCpZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6761
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/2023 11:58 AM, Vishvambar Panth S wrote:
> Currently all RX frames are timestamped which results in a performance
> penalty when timestamping is not needed.  The default is now being
> changed to not timestamp any Rx frames (HWTSTAMP_FILTER_NONE), but
> support has been added to allow changing the desired RX timestamping
> mode (HWTSTAMP_FILTER_ALL -  which was the previous setting and
> HWTSTAMP_FILTER_PTP_V2_EVENT are now supported) using
> SIOCSHWTSTAMP. All settings were tested using the hwstamp_ctl application.
> It is also noted that ptp4l, when started, preconfigures the device to
> timestamp using HWTSTAMP_FILTER_PTP_V2_EVENT, so this driver continues
> to work properly "out of the box".
> 
> Test setup:  x64 PC with LAN7430 ---> x64 PC as partner
> 
> iperf3 with - Timestamp all incoming packets:
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-5.05   sec   517 MBytes   859 Mbits/sec    0    sender
> [  5]   0.00-5.00   sec   515 MBytes   864 Mbits/sec         receiver
> 
> iperf Done.
> 
> iperf3 with - Timestamp only PTP packets:
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-5.04   sec   563 MBytes   937 Mbits/sec    0    sender
> [  5]   0.00-5.00   sec   561 MBytes   941 Mbits/sec         receiver
> 
> Signed-off-by: Vishvambar Panth S <vishvambarpanth.s@microchip.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

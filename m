Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91B877D676
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 00:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240516AbjHOWwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 18:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240506AbjHOWwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 18:52:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76082FB;
        Tue, 15 Aug 2023 15:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692139951; x=1723675951;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CxVzQJFzkJwyEBjfCvQW5yHqyVe9/F65y904fsuGgYU=;
  b=PBrdijrmBWENglfz1sGH3z0LycrrU8KToWJ8Viv4x4845wxGhBwn11a5
   Co8n6T80ea4uDp225GUustlC5KhrTAsVNLwR4zjFFqROOlrW4Mwk7Okrn
   3nwyhH391gWs1XqJuijakbVYIKQKdRm2hvDdkNcM6IrjEXw1iamgL4+d5
   vUhvR6ee9K7Hgfeqii39RgYE7cho8N96WP4Fs8ccTWfMDbTgFMSM8aW+W
   FrnfhezCqGavMYj2X0bpXrDku5DnUeCSE+TruqvKoLZ52bN0y/2fczLjP
   uxkef95Yj7k5RPvNOmiJtQa5dBF5XtkH8mVJ7tytxXbhAgvXGvTc1dQqs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="352722607"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="352722607"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 15:52:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="877521784"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 15 Aug 2023 15:52:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 15:52:29 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 15:52:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 15:52:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUMjzzzWQFj7TafUd/OeqCQNSLa/4seD5/5LL3E9gtvlSzPGAVm74yIvEt1Gj4h+KCUvhTRSpjFmhFCJ7VPflpWQMBNnvpqQCYxrZYAhCn2sHLBpRdw3vVmv+5lNzQIUH24D1xf+NjWqsY/TsYwX/y0M6m4v8Z85oBqJdY2Oac7HX3tS/jmC7CvCeqjLA7o/+7cXyutSRilYOcWn2/gbVpmJclnNH5GwvVWTJneAWdg5VT2qe6e4IBNKTZR4gmQqlvTj3zLcd4dolOsHDj59B106TcDIW0POmmvSYuTSdlhBdgZQaOM+i0fahqJ7vnjYaSxXQqjVldkXqBHwMswyWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8Ne69ora8GpMjd8bGfCnT781SEk2OtCHQBQnprzv6k=;
 b=K+U+VkUvzVZpfNPTcDlrfEGSM8xB7ddp5CJTqKdXVLj8d9afmCJSkn70qkxx+rHFpJD1jxNiFTBa4tu8uUAQI1G7CW4k9T8SAy+lR55LwmdErXsq7Uxs/gjGj0gZq1omScXDgJX0Qk/8wMfqkLa0pztW1ucAGBSvfVhjfEfq0hzqOftLTCriVhnDhyEFA14WDWppZF5dkWCTuXm8I9vxKZOW9GOTX6IfOtJjIIz4ZGcciknf4Dvh0MG/Lz/ryv7qLf0qgJZOUtzHQfizOGdQb7U5fgF/L6CE8+nMyhzUEHqN1AJ0K6F5b0o3NIIen38T+oEfKt0UwdgaN6YeIdwOvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6124.namprd11.prod.outlook.com (2603:10b6:208:3ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 22:52:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 22:52:21 +0000
Message-ID: <ec286003-bdd5-590e-1290-2d3268ecdc2c@intel.com>
Date:   Tue, 15 Aug 2023 15:52:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v7 8/8] x86/resctrl: Display hardware ids of resource
 groups
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu>
 <169178465701.1147205.1483883019768336774.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <169178465701.1147205.1483883019768336774.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:303:8e::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: 57ed4b77-f335-4dd4-2cda-08db9de24886
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oDQLhEFwKqH4n9MdFbjCdDhExgyNyecVqzsbdk9LafTRXPO1ZOPi7oXoNSOFUu/usjTAfWg3ZE5FirqoETrO1FtmMagKs0ARdpVOE/dsn/iQDnx02zaGibxDREYII/untKQGewXdvFgU1UrVE81gr6Bh+JPW7LqO/IwGSJ6viMr8Kf3ZKHPHw1z+i7tKhqoMheqyjvriIF0s+4SHn1zAtZ1nH5ff4WVa9ARLA5WaJ5oeX921edNxkS7mtZdNJl6gsqKg+GVDwarqgtqjNVzjlhxHnj2eNfBKI3HmkCshOlPmoIbIUmeLGJZErTID8inZzj57XdXcpg5ik0+Nr7tvW5oq+r73WxK8Hd7GeoVeAq5Vc/yamPujcccSzDZeS4QkGBK+mTWzqdufchH0G4CDl87PzNI48YT15LVZdd4IveAqzFFLTRP+KAinSNokZBk1cT+EvGaX1ym2v9rynBYmGGBStt/Sdd5DOGLb2QSAKsNVGr1Y0Zjt2n4cX3ph5g8UZiSfqRDhuelmKImyUxgkoj6vWpblShiA29pWeOFJvrRAHVJMdbCA0qY0L2SScrB46oY7hiGaHEyuVsAbEG0z7RtNKxtaK6XVty2vzHR4qGN0wFOB496ZaXP2zNMK6SnhDAlBp4eSpH2hNLnlQlUYAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199024)(186009)(1800799009)(26005)(6486002)(31686004)(6666004)(38100700002)(53546011)(7406005)(6506007)(31696002)(86362001)(36756003)(316002)(66946007)(5660300002)(44832011)(478600001)(82960400001)(8936002)(4326008)(8676002)(83380400001)(7416002)(41300700001)(66476007)(2906002)(66556008)(6512007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWlqNGRJa21GWUlmd1E3YTllTGltM1VCck52SGRkdGkzT0Z2bzUzM01YNGE1?=
 =?utf-8?B?ay9mc2xnTFRON0U0eUc1cXdBQVpkWnpMNGN2T0NJQXBjNXloakE3ckVpTHh5?=
 =?utf-8?B?V0FaNmx0Yy9TbVlEL0c5RXJnZlZYR3lHazVaMmZLUitsTy9ERGFoMU1SWTRU?=
 =?utf-8?B?VWVYSUZTelJ2enJlRVhsQlRIcVc1Z2ZkZERHUGxkK0s2Sm9FenZBS0FpRlEy?=
 =?utf-8?B?NWNMUU8zMmVOeDFESHFyZWRSS2JsRlQybDdWbXJFQ3dxKzkrOG8wNkRPaTN0?=
 =?utf-8?B?QkJHTXhwU00xZGhjY1pvM015YjVIdDlDa21zQlpHS0hNaU9wdHdUdGMzb004?=
 =?utf-8?B?L2JKUUdMaXBQQzlrUThGNnhOdWExK2dtSlhUaEpCVTFPRmlLZHJRMjNoWm1s?=
 =?utf-8?B?UVg3em9EdFk5UDdicmdySzEwWENDazNPWHAwMmJSQVlHQ2xEcUhjbGhGaXV5?=
 =?utf-8?B?SUNYUWQra0FHRWV4MHRPNHJyOFRZd0dGdG9PVno2bTd0MFNGV28zeG1HTnNI?=
 =?utf-8?B?M25ocGdsNWYwMGlZa1ZCVHNCa1p6R2ZUV3F1N1VadnFES1VxakZ6djZDd0p5?=
 =?utf-8?B?Z0ZaRkpOMmowTjcrbzJmQkpZZm9kTU5TTkYyYlViSlppUmV6VHRSMVAzVEVz?=
 =?utf-8?B?bzZlQXZXbVh4bG1Ic0ZtMGlMSkRqZjRrUHprZ1pkbmFBcFdlU08xYlN1c2pG?=
 =?utf-8?B?NVVVRzRJRUpVNHdXMDRMQmVnMW9SUmRnWjV2c3ZwZzZaYmlsWC9WZmdpcnZo?=
 =?utf-8?B?eTVPY1NxTjc0a1IvNEs5dGNxejNwd1NEWC9zd2ZnY29lNS9HaHhyVEtKczM1?=
 =?utf-8?B?SzQ2TUluM1d1WG4wMEd3ZUd1dDgzZk40UkRIWkNPZmxJblJFa3FLbnkyWFF1?=
 =?utf-8?B?RE15aVdBV2hZZVJYV3FrTVE0UnRUTUk3SUxMeU12NVFUajNOSkhraSs3bm5O?=
 =?utf-8?B?dkpxbHUvQjh2QWhBME1oalRYS0I2QklML2FDVUhkSGFkUjgwbmc2MFR4STlm?=
 =?utf-8?B?OC9JamFSSGpIVUxvdDQ4UkVOb0FXWlJiblFTbEtDYXptaDJBWmNjR1hBb1V1?=
 =?utf-8?B?VlpOVURyaVVxazdxRzg1VUd6bmhkRXVkNGlrSkxra0o4WlkyOGZBajRiUjh5?=
 =?utf-8?B?ZDl6NmJ0MHJYcGxTa3QrTG1QUjZEZGhpczZ0bVA0eEtFeGlNcVhUQklhaklt?=
 =?utf-8?B?NmlBNnBnaVorK0Rwa1puVEpDNDNTaTV3SFZ3cUZjbzJNaENabmdDQlN0eGU3?=
 =?utf-8?B?UzR3amNNQTY4TEl3czg4TjJQZ2Z6bW1YaHhsK0pKeHpQOWJLcjNmcUVqQ3Ew?=
 =?utf-8?B?ZXZKSkozVWduRkNCaU5xNGVDZHVZSGZxbDl6ME1nYUw4b1ZzUGF5WjBsbzNi?=
 =?utf-8?B?Yy9aWmtmU2w3K2RFTUMwOXpGR1kwd296U2srNUpuWkFaL1JFbnppRE1oZklO?=
 =?utf-8?B?TktDODEydHZ0S3FydjRPMmVMOENNbm5iVSswaGU2b0JHNUV2dG9rNVQ2Qisv?=
 =?utf-8?B?WmdwUVZKK1paRmRHU00ybjFsNDVQR0NGNFYvSGlQbGlzWExhVDk2M2ZTUmhM?=
 =?utf-8?B?bDJIeGtaQkh3Q25tOGxSZW5MTXREcGtZMFFaQ25PcmxmdGJWR2svcnpwckp0?=
 =?utf-8?B?eU1FeEpGcUd0TGZ0a1IyRnZqUjdhT3NqNFQ1ZmF4VmhMbUFOd0N3NnQ2TDRJ?=
 =?utf-8?B?TnpYQUJ5QU9GQVVkYTNCUnJnRWlNWklWdmRENWo1YlI4UXdXdCtmT0I0UlQz?=
 =?utf-8?B?aWdpeHd3SWUxaitKY0p5c1JCV00zaEcvdDc2OXRrTUtuTWk3RGtPRElRTzBk?=
 =?utf-8?B?N0V3anh3dGg0NnRpZXFycHNLUm1mcTV2dUxtRm91Rm9yWnVBTmR0aFhHTzFy?=
 =?utf-8?B?QW5VMFF2MHNOTFhoVDdIbzZCampEanhYREcvbDg3Qk9tVW02YXBFN282dmRn?=
 =?utf-8?B?WW1VN1RkWm1EN2lDcEV1VkRXYUdSZDQ0bmxFMEtRamFZWkxrYWpGTHZkNVEx?=
 =?utf-8?B?SEs5bTIwZlZDbXJNVHBCSXQ0a3Z1NXdYd1hEdVFENkR3ZXNjQlBxeGJydmdw?=
 =?utf-8?B?d2NMdnJldml0czRHd2VzRGp1anRkbjJZQWdaeVFMdW1MWUlzUG1qOVozKzU4?=
 =?utf-8?B?UjJMbGJwbzV6S1NpTWtONGFuYlVUR2syemZrNlF1SHpUWThQREowcGhaY1h3?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ed4b77-f335-4dd4-2cda-08db9de24886
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 22:52:21.0744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOy4FPvsAe2I/uQWBEJu2Xz6EJRLntYtXUtUhP+zkqZ/qa5mRlfhcMfW2eZWbboDMfK+QoAFSL9EdB/slLsBbDWhmeRV6fZJBGDfdZE+3v8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6124
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/11/2023 1:10 PM, Babu Moger wrote:
> In x86, hardware uses CLOSID and an RMID to identify a control group and
> a monitoring group respectively. When a user creates a control or monitor
> group these details are not visible to the user. These details can help
> debugging.
> 
> Add CLOSID(ctrl_hw_id) and RMID(mon_hw_id) to the control/monitor groups
> display in resctrl interface. Users can see these details when resctrl
> is mounted with "-o debug" option.
> 
> Other architectures do not use "CLOSID" and "RMID". Use the names
> ctrl_hw_id and mon_hw_id to refer "CLOSID" and "RMID" respectively in an

"to refer" -> "to refer to"

> effort to keep the naming generic.
> 
> For example:
>  $cat /sys/fs/resctrl/ctrl_grp1/ctrl_hw_id
>  1
>  $cat /sys/fs/resctrl/mon_groups/mon_grp1/mon_hw_id
>  3
> 
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  Documentation/arch/x86/resctrl.rst     |    8 ++++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   46 ++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 5a2346d2c561..41ad9b1f0c6a 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -351,6 +351,10 @@ When control is enabled all CTRL_MON groups will also contain:
>  	file. On successful pseudo-locked region creation the mode will
>  	automatically change to "pseudo-locked".
>  
> +"ctrl_hw_id":
> +	Available only with debug option. The identifier used by hardware
> +	for the control group. On x86 this is the CLOSID.
> +
>  When monitoring is enabled all MON groups will also contain:
>  
>  "mon_data":
> @@ -364,6 +368,10 @@ When monitoring is enabled all MON groups will also contain:
>  	the sum for all tasks in the CTRL_MON group and all tasks in
>  	MON groups. Please see example section for more details on usage.
>  
> +"mon_hw_id":
> +	Available only with debug option. The identifier used by hardware
> +	for the monitor group. On x86 this is the RMID.
> +
>  Resource allocation rules
>  -------------------------
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 6b7e914657fa..94471ad9d905 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -776,6 +776,38 @@ static int rdtgroup_tasks_show(struct kernfs_open_file *of,
>  	return ret;
>  }
>  
> +static int rdtgroup_closid_show(struct kernfs_open_file *of,
> +				struct seq_file *s, void *v)
> +{
> +	struct rdtgroup *rdtgrp;
> +	int ret = 0;
> +
> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> +	if (rdtgrp)
> +		seq_printf(s, "%u\n", rdtgrp->closid);
> +	else
> +		ret = -ENOENT;
> +	rdtgroup_kn_unlock(of->kn);
> +
> +	return ret;
> +}
> +
> +static int rdtgroup_rmid_show(struct kernfs_open_file *of,
> +			      struct seq_file *s, void *v)
> +{
> +	struct rdtgroup *rdtgrp;
> +	int ret = 0;
> +
> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> +	if (rdtgrp)
> +		seq_printf(s, "%u\n", rdtgrp->mon.rmid);
> +	else
> +		ret = -ENOENT;
> +	rdtgroup_kn_unlock(of->kn);
> +
> +	return ret;
> +}
> +
>  #ifdef CONFIG_PROC_CPU_RESCTRL
>  
>  /*
> @@ -1837,6 +1869,13 @@ static struct rftype res_common_files[] = {
>  		.seq_show	= rdtgroup_tasks_show,
>  		.fflags		= RFTYPE_BASE,
>  	},
> +	{
> +		.name		= "mon_hw_id",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdtgroup_rmid_show,
> +		.fflags		= RFTYPE_BASE | RFTYPE_DEBUG,
> +	},
>  	{
>  		.name		= "schemata",
>  		.mode		= 0644,
> @@ -1860,6 +1899,13 @@ static struct rftype res_common_files[] = {
>  		.seq_show	= rdtgroup_size_show,
>  		.fflags		= RFTYPE_CTRL_BASE,
>  	},
> +	{
> +		.name		= "ctrl_hw_id",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdtgroup_closid_show,
> +		.fflags		= RFTYPE_CTRL_BASE | RFTYPE_DEBUG,
> +	},
>  
>  };
>  
> 
> 

I think the comments introduced in patch #4 may need to be updated
in this patch.

Apart from that this patch looks good to me.

Reinette



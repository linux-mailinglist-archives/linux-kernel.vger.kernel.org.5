Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07827E8A0D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 10:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjKKJma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 04:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjKKJm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 04:42:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723C33AB9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 01:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699695746; x=1731231746;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Oixcfd24GkcKQW52YQk6ILU9y2jUTlHR7WgxFMkgutM=;
  b=ifsDg2n2H82QpT68HxVEStEuHRiWK7bKrr4KOC0T/21oJ+bYj5I7yoFX
   ZWnkYjOx4gIvDTZic0trOm6Kbn0pBfFUfDYMxOaf/Lk/yORuWAN+n9c24
   04Xsm0kstncAZo8ccUwR5sgKCVcdL7K3JHUBQc42+tbJVGtNRm+QQBdq5
   +LmhS2x4rsrqrFUXlEEBdc2ATBeFI6bKH0NGbEK6wUYSnRb3vuy5dcoUt
   tdprrCNtHxsiOdZDSjFcz2D8XGTifpzAyt8eEuaWDAYpMLlh5RG0tjo9X
   e5Pax8tL85J+4583QV9OqlKX7XtiNrHLJsj/vZe9aQs9XuxClcmQplyh5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="370469267"
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="370469267"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 01:42:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="11649142"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Nov 2023 01:42:26 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 11 Nov 2023 01:42:25 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sat, 11 Nov 2023 01:42:25 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sat, 11 Nov 2023 01:42:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dv55xliXW71gUl/hvPN31gxTZli7yRLbA/+75HRYUpnsBfgM9XuuyN0pQH2aKG61YMwatXjaRBs+iCMkTeoVxeTeHUiNBzlaapA9ZJi7tdhZMrBy+Y9pryb76PWBMnrZQqdzxvlGZZJiiqebC+LTqJKkGUhleZyZMY3gep6AheShazeMoeelPdAXZF132cjdRDhDU9l1J/24OnM08eWA/nlfyzNR7RcLFvOMhV80FymXtoZViwDeznYMqIZKmMWgtToeDGexE4nTDbaLwA/HtKiz4V2Ghma3VW4zYNftMFHz75T0qrBBKJY7TKA6rB4eLG+wqiILH8e5MX0of9gAzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=769jBY8RfpzIqg6ZW2rh7wSJ7Hu6QDm7om9mZT1yJ6o=;
 b=KyRO4g+a9DKlarkHRvVs6JO1xnR3OAyBaB1Yl5DalauOjxdm9fUcuQ5ciboltgGslNMdbwDzR3XDlL5p+SSfPWd7GF08R08xYOwUU6XJqLDk+y5NP5Q5/qvizkL292K+GDpo/z+VeBBfJmRrLcQXDBJklNY0CB7rTYnm3VLa79sZs/J2oZA9aiT3ZlL97/q01Y06LqN3loU9+vdLwkVxLanEjqAHGxZX6B6NmcDuZGSbW/5AysD8uUBzCKgKh5FxZugX6ir21V96CrAo+fhqsrBl/0tQqGunJf9ne/DuSCOIMgIEeieNwXS6BS58lfMXmsyIcReUgUPHRNKi3XUv0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by LV8PR11MB8462.namprd11.prod.outlook.com (2603:10b6:408:1e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Sat, 11 Nov
 2023 09:42:22 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67%5]) with mapi id 15.20.6977.026; Sat, 11 Nov 2023
 09:42:22 +0000
Date:   Sat, 11 Nov 2023 17:42:13 +0800
From:   Philip Li <philip.li@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bibo Mao <maobibo@loongson.cn>
CC:     kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: lib/flex_proportions.c:73:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <ZU9MdYUBgIhOqevI@rli9-mobl>
References: <202311080840.Vc2kXhfp-lkp@intel.com>
 <20231110154208.5UoC_qsI@linutronix.de>
 <ZU7e2bhGV9NR9THx@rli9-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZU7e2bhGV9NR9THx@rli9-mobl>
X-ClientProxiedBy: SG2PR04CA0162.apcprd04.prod.outlook.com (2603:1096:4::24)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|LV8PR11MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 364926f4-3a55-4790-7923-08dbe29a8096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CvvQzQtRUy4Lu3aujfJjeuiave5XBOsA6OYkOExa1dDXpFXw54Aeokt59Kzbk6svY6jbpJwDk1thhRQGu93V5jDXqMux2Zp9l9GZ7O/+ZhyfoCxKgC9NMtdg49Ws8sMLLXRTMh5fq8bzHfgctiTCStlG6nrv1jcsCSmaOq2haz5kuropiCZroV1x889JOlVrWJJ3vH09A1tNAeWlD+5v90ypHKahPWqhKsY6BSvKHGc7y59SqYp7xtQHuXM9h0u4ksxhNz9ZiE9BiCBAUvyuQRU1zqV7OiGTYzLAjE+l+dCicGs13VN5KVk9I+TIZBtbqmqppbZJ33B+wP3Wzygpzv9Xyt/Jy4kQiPLY9yAPlYH9BFIBfD8WQ4XPYArdF7SdChAD1vOejSnkrhtE59IpjEG/vQflWJ8Bhng1CrfQJRhJlHAVuZ2E/7hG76JYqx2vz161nKDMVx8x8vQzF7Ct9MAk25wABkxHxmzt8asb41vfC7PGkDhYCj24f/ctKXiMEuG/fpgxBwXwahyTXVNT5y1CnB9LRIKXR7DHwtBxlUW8vBi0+u3DPF11Dah6yzuNw/slPotn81WuiCbf9SsVT/UB75H+J7QhKqL35MNldkPxmn/9b954hWVCYqJLx7MhOXi//VGdwR8tdy2Q6AOvRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(136003)(396003)(366004)(39860400002)(230922051799003)(230173577357003)(230273577357003)(186009)(1800799009)(64100799003)(451199024)(6506007)(478600001)(6486002)(66476007)(6666004)(66946007)(26005)(966005)(2906002)(41300700001)(53546011)(9686003)(44832011)(316002)(8676002)(8936002)(4326008)(66556008)(33716001)(5660300002)(54906003)(82960400001)(83380400001)(38100700002)(86362001)(110136005)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXRDWk5SN09uRzR0TXFkMngwUDAvL2t1aEVoUzRzcEx0MVBhSERaWWQxRmo2?=
 =?utf-8?B?U0dsckppOFlYZ1YxMXBIelFVejZYYVhtdE16MWptNWdYclVscVhlNjR6bVRq?=
 =?utf-8?B?QzV3bDdLY2pyVTkrdDAvTm5qWkhibUVUQ0p0bWg0WjMyTWhqZGxSM1Q3Wjdr?=
 =?utf-8?B?MytZMXltSHI0R0o5UzVnQmpuOU5lS1JSMStZcWluYU1xcGducy9QTi8rdDlm?=
 =?utf-8?B?Tk9BZkU1QUhld003RkxyYnJSMVpUSENjRW1mSEl2RXJXbjB0RjI1RnhIQVdp?=
 =?utf-8?B?Z1ljT1kwWjhGdzlUQmJwYWdReXF1QTQ0cFdQa2loQzJkVEJnUU55YkJYM0R3?=
 =?utf-8?B?V3NOeWUwZWpwVHIwdEVuSUhkTkpLMlRicTA0WDM3V0ZBWVF2QnJBMEF5WEx2?=
 =?utf-8?B?a3dTdGswNkRibUFhS2VaOENMRnJVM1dtYXcrVUNxY2dlRlF0OHlYbjZFN1lt?=
 =?utf-8?B?ZndIQWpSUXJGMmJsMUVCUHNBaU1GSUpyaTJXOC9zWElPbE1tSVJRSmQ4SFZ1?=
 =?utf-8?B?MTc4Y204RldSLzlYVWx5WmpvUUl5L05Qa0ZFWWloNDJpVWNMNFE1cmtMMVli?=
 =?utf-8?B?REYyRm1IR0tvQk5pSzJzTC82SUpBYno1TGt6cmM0dzQ0SlVhd0xEdjZyak5C?=
 =?utf-8?B?cm1iZUVoMmFtVlZCbkZNR2xMWlNTaHVLSTNHYUVWUlcvVit6cjVnOXJyZlhM?=
 =?utf-8?B?eDdWTHdLakpETGlRaHIyUWJyOTZxU2tJTjVNdHFNa1Z4MWMydGNXeSswVGxL?=
 =?utf-8?B?NXF3OFZWZTNEQkVMT1ZCOVl1c0ZqQjFVMiszR3VEUWE1UmxUaEErYVdXUkd6?=
 =?utf-8?B?ZWFYcmYyNDdqQVlyZFMyR0ZrQzg1THhkdGlLWTEyRnBwdEhQdVBrcWVBa0VF?=
 =?utf-8?B?QUo0cUptUVlIejlHSzNlbHFmQWM5b2hKbnF5RFFjM1pGcUNnbUFxWlJNemFs?=
 =?utf-8?B?TEJmanN4dEc4ZFdSNEdabW51eS9rUVBmdEtVWjNmcCttazJzMWhZZVRPaWVK?=
 =?utf-8?B?OEZ0ckVIaGQ3bEFqV0Z3d2dBdVQyL0JodndkYXVCR2ZQeHlhM3dZSVlTaDlN?=
 =?utf-8?B?QWlJdDhpY0xGSnZWVHdwUEpPR3c0ZmxROVpPVGw2ZGhhaXRyakI1N2pXK3FX?=
 =?utf-8?B?b2M2RFBZWGxVb1dpRHBkWjlPcVFvNFhTUktZMmxaSzdwWER5SXF1U3RjNHhV?=
 =?utf-8?B?amZ5Y084d2JyNVlRTXhSUXcvbTU4NmlxZW9IVUdGaElIdmxnOGpVV0gzWU9D?=
 =?utf-8?B?anpnYmVPVHlJZENxNndHMGF4MVQrOTB1MlczY0JKRUF5eXMyNGQ2QTVzSFhD?=
 =?utf-8?B?TXU2ZE9rRU1BbmRxS21sandjSytRbk5ER2I5U3k0MU9oS3lEZlpEdG14SjBH?=
 =?utf-8?B?eUlSVGg5QjliYTlwTkpiSlMzWWluSmRVWDFzL1VTOTR5bVpOQ2NvVkYvczBN?=
 =?utf-8?B?cW5jbFhOTnoyVFUxZE8weGlnUU1UUVk4OHNtbGdzUVBuT1pGVEFCanplV3BX?=
 =?utf-8?B?ZUhOYTFGeUpZZ1VLYk5VZTdTSmVHeFBoVzJRazY5eExVSGR0ek1yTEVHSjJr?=
 =?utf-8?B?dG54Tm84VDdZK3grcmxUTTZ3bWFwQkZxeGpDUVJSLzJWY3dWQ0NRSGZudUhP?=
 =?utf-8?B?d3l2djY1b25TL3JIcjVDTFBtVkZwNnF4NWgzNjVSaWhvWDk0U0x3QXNadTlT?=
 =?utf-8?B?QUxWUkNDcGFjZW4xMW5FNStROVYydzFNZ21GckRsN3VjMmgra2ROb0xjYVdX?=
 =?utf-8?B?dGN2MHFyaVg0ZmhLSFdydTN1OVIvZGZ3dllZcldKb2kwMkhFOXkxWFUxUmFa?=
 =?utf-8?B?TmJ1cmJPVDBHcSsvRkRZbTM4TnNSR2h0YzVlYW5KUjFLdnJRSy81Ty9DRXlG?=
 =?utf-8?B?QzRrdW5mSDZINUVETTlncXR1YjM4UG9STHgvVFJwd0toNlozZThWS1Y3bEg3?=
 =?utf-8?B?WjhzVGJwazhGZVBQVHVFV0I0cDA3c3dpNWVXMm9XK3VMblVPLzRpNWN6ZFhy?=
 =?utf-8?B?NXJqRGlyaUpEUmRKRVQ5cjdVanBiaFB1c2F6NzlQMEJLSDIyVDI1MjFjVDc1?=
 =?utf-8?B?U2ZIMFBGamRDdTFVcVF3T29pc1JPRFFwekR1U2VBT0o3UFFDUlpvUU5udW8x?=
 =?utf-8?Q?xtyh40GKXG5sieRocDUCmYPok?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 364926f4-3a55-4790-7923-08dbe29a8096
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2023 09:42:21.6447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKfqhnZMzkAEd2FqSff6xZg2U7oCfvdIiiGUQIdxz0+3BqOD87AKEEyatAMGqCrPR5UuocAHd7r5Y6eySTtbvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8462
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Huacai and Bibo for support.

On Sat, Nov 11, 2023 at 09:54:33AM +0800, Philip Li wrote:
> On Fri, Nov 10, 2023 at 04:42:08PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2023-11-08 09:04:40 [+0800], kernel test robot wrote:
> > …
> > Could you please explain what is wrong here? The code in line 73 has no
> > percpu reference at all. Or expects an argument.
> 
> Apologize for the confusing report, we will investigate this in earliest
> time to understand what goes wrong. Kindly ignore this and sorry for the noise.

Hi Sebastian, I do a further check and realize this is same as [1], that Steven mentioned

	> > 2430		lockdep_assert_preemption_disabled();  

	The above is a generic lockdep utility. Sounds to me that this is a bug in
	the loongarch code that doesn't handle this properly.

So the commit reported is not the actual cause of the issue, which just calls the
preempt_disable_nested and exposes the issue of loongarch.

As for the question "line 73 has nopercpu reference", probably the preempt_disable_nested
is expanded to call lockdep_assert_preemption_disabled, which in turn further calls into
this_cpu_read (because CONFIG_PREEMPT_RT is not set and CONFIG_PROVE_LOCKING=y for this
randconfig).

For now, I will update bot logic to avoid sending similar reports and look for fix
from loongarch side.

Hi Huacai and Bibo, sorry to bother, could you help do a check of [1] and [2], or point
me to the right contact for this sparse warning?

[1] https://lore.kernel.org/oe-kbuild-all/20231108094847.236d04b2@gandalf.local.home/
[2] https://lore.kernel.org/oe-kbuild-all/202311080409.LlOfTR3m-lkp@intel.com/

Thanks

> 
> > 
> > > sparse warnings: (new ones prefixed by >>)
> > > >> lib/flex_proportions.c:73:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
> > >    lib/flex_proportions.c:73:9: sparse:     expected void *ptr
> > >    lib/flex_proportions.c:73:9: sparse:     got unsigned int [noderef] __percpu *
> > > >> lib/flex_proportions.c:73:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
> > >    lib/flex_proportions.c:73:9: sparse:     expected void *ptr
> > >    lib/flex_proportions.c:73:9: sparse:     got unsigned int [noderef] __percpu *
> > > >> lib/flex_proportions.c:73:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
> > >    lib/flex_proportions.c:73:9: sparse:     expected void *ptr
> > >    lib/flex_proportions.c:73:9: sparse:     got unsigned int [noderef] __percpu *
> > > >> lib/flex_proportions.c:73:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
> > >    lib/flex_proportions.c:73:9: sparse:     expected void *ptr
> > >    lib/flex_proportions.c:73:9: sparse:     got unsigned int [noderef] __percpu *
> > > >> lib/flex_proportions.c:73:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
> > >    lib/flex_proportions.c:73:9: sparse:     expected void *ptr
> > >    lib/flex_proportions.c:73:9: sparse:     got int [noderef] __percpu *
> > > >> lib/flex_proportions.c:73:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
> > >    lib/flex_proportions.c:73:9: sparse:     expected void *ptr
> > >    lib/flex_proportions.c:73:9: sparse:     got int [noderef] __percpu *
> > > >> lib/flex_proportions.c:73:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
> > >    lib/flex_proportions.c:73:9: sparse:     expected void *ptr
> > >    lib/flex_proportions.c:73:9: sparse:     got int [noderef] __percpu *
> > > >> lib/flex_proportions.c:73:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
> > >    lib/flex_proportions.c:73:9: sparse:     expected void *ptr
> > >    lib/flex_proportions.c:73:9: sparse:     got int [noderef] __percpu *
> > >    lib/flex_proportions.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/percpu_counter.h, ...):
> > > 
> > > vim +73 lib/flex_proportions.c
> > > 
> > >     55	
> > >     56	/*
> > >     57	 * Declare @periods new periods. It is upto the caller to make sure period
> > >     58	 * transitions cannot happen in parallel.
> > >     59	 *
> > >     60	 * The function returns true if the proportions are still defined and false
> > >     61	 * if aging zeroed out all events. This can be used to detect whether declaring
> > >     62	 * further periods has any effect.
> > >     63	 */
> > >     64	bool fprop_new_period(struct fprop_global *p, int periods)
> > >     65	{
> > >     66		s64 events = percpu_counter_sum(&p->events);
> > >     67	
> > >     68		/*
> > >     69		 * Don't do anything if there are no events.
> > >     70		 */
> > >     71		if (events <= 1)
> > >     72			return false;
> > >   > 73		preempt_disable_nested();
> > >     74		write_seqcount_begin(&p->sequence);
> > >     75		if (periods < 64)
> > >     76			events -= events >> periods;
> > >     77		/* Use addition to avoid losing events happening between sum and set */
> > >     78		percpu_counter_add(&p->events, -events);
> > >     79		p->period += periods;
> > >     80		write_seqcount_end(&p->sequence);
> > >     81		preempt_enable_nested();
> > >     82	
> > >     83		return true;
> > >     84	}
> > >     85	
> > > 
> > Sebastian
> > 

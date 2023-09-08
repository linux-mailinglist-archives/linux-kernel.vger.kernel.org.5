Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10259798A96
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 18:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244981AbjIHQTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 12:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbjIHQTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:19:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF18CFA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 09:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694189984; x=1725725984;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Eza83CeF16uHZ6nGbMx78p3c8Zx+i+fqwv9EWSzeRJs=;
  b=ZwIdBZX7CkoDfzxyQLyAzt1f1CwR350qksnkIrA39K3a0/flvmmBvlyQ
   PgS2Lv5M33viwxEdA2Dq3p4Dvt3yi7Ps9+DNPgOUerkdgIh971RbaLixa
   Fnazvfp/5HeapPeC+2aMWdOgYK1sndORx2FPs0jfyv/lxrAJNhQz+e04T
   T8GCr4u2hZnIN6ar2r00NhaKzs08N+cUDlJlT/rxsfeIg7aqTF83opiKe
   +kC8QxQIODmd/MHweDGNBNJcAYRj00yEWJdlFUpk3afLcw+JOnQUt1YIx
   VAb5ZwOTS2Hj0x/oe0A9nijjzIRXclw3GqUptjzU6gQ6vNeIwBUmK3+G6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="376590634"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="376590634"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 09:19:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="745648788"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="745648788"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Sep 2023 09:19:43 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 09:19:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 09:19:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 8 Sep 2023 09:19:42 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 8 Sep 2023 09:19:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+WYDOaKCFIb0VzYrrBYIAJSSE0tqpuyc9C41yPurBZCNJXXu9CFM343TI0Lzb0/Pgc4bbAfN0HMI6nkl7xzEaBND2o4dfSotRNnAgYDNTwbp36+FgiCNLurZNiRT5ZBoZTJP8WJ06ZJEyWIqZPcN0GSLoNNC2Jx2nadbTyKUSuefQiXIDzGv9W3Fav2zpoUvEIyXPgbM28BKPGuOwEywCv3C1kSzjgE+IsN3nrSE96ahOieRmVn1olZiVwNh/PLQk+tNJjbJRyXx+Ifz+1hkflf9ef7WwswSlmG6b33MIpLiErk5xFzlP3ATkMPlJaPbsrHTwrItUbYJDyXsqPw1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEJAQ2cZ0ENONDrSPSwvolGXcCChB52Va9cqZpBI1jk=;
 b=YcTtD6ReLh59POKoIJ0sW8SX8DhaowIO8W1Sxn7qAIT73GopLp6ej3YB7Ob6wqBLRaJavcFk9QIiA1xd8cnsZMZsxuOpUdPsg+yqnVGZYqCv5WCFXDxbx9QJXHhTrssvg/+zj5D4ItAIOzyMh6c/d7n9ti60W0hvJ5yVs7amnsV5fn6onUUeApIuGbE+SRdW40vr6zOViC+5DVg9R2KxAunYeFIJ/DIHc3RPB6ydOz6osEEWnUXFYbfiveYydc7/9uu2CHmO/+DZeegwN2YzMsQKuwHsCV296NHVCFX5vWcFo1Q7/1eMlxEyGkCaP4/FJx5BfPCoE5JszorHuzg6pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5614.namprd11.prod.outlook.com (2603:10b6:a03:300::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Fri, 8 Sep
 2023 16:19:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 16:19:39 +0000
Date:   Fri, 8 Sep 2023 09:19:36 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "Yu, Guorui" <guorui.yu@linux.alibaba.com>,
        "qinkun@apache.org" <qinkun@apache.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Aktas, Erdem" <erdemaktas@google.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v1] virt: tdx-guest: Add Quote generation support using
 TSM_REPORTS
Message-ID: <64fb499862936_7318294a0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20230907025405.2310931-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <da4a6c3f4cb9118e10866cb1d624ad5ec5c96d7d.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <da4a6c3f4cb9118e10866cb1d624ad5ec5c96d7d.camel@intel.com>
X-ClientProxiedBy: MW2PR16CA0014.namprd16.prod.outlook.com (2603:10b6:907::27)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bcd6263-7521-4d44-adfd-08dbb08766d0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VMmNOKFKQRW9rYga1UzkypbtlzdTIW917IJISwKVOUUd59LoHaNyYxtL3UPEy+1phZHhmbr8nOZF7n6fmk0Qrb5aXZKwz+QJWRBIRROdyHM++LgRAHB8lk9yk0HJZUS8VLCa0XjUePgsC7kXMv3fuY+d4sfz0B9elVubLanudSopYOB39IfAvfQmQg53H6zHMlVO1gik/fB+Tv/TglIm4YoXu6sETI8NkM0FzVaUOa3D/IHC4WUUHpCFIx9mld/w/hqBa80Qol9yp8UF0FC4WtrUU9vxEHBhH47CFin+4RwaZ3eeVNMWbFTiTV+l9uTJJinHn23swJ1CiTDAGSPIde3qXww+rl5/ksMIpqfKCJkoO6r2Mf4mFJcMiFMAQD/NANfGMxN5gXCf8sOPyGHyckXEXibWGv6Bki8wo7BimHhK/1Ru9XVkgWTE7RsOthA4koCPLVi+LWOWOJw03zhCwOTmxXPrzeX0t6yFOGKLj+JChnAcczXB7El7pVlVHsGo/ggB1PagIs59N5IxvpCQDpQ3Ch2sZ0dOxYmaB3GFrxKj3IGIcPdnKLlH841X5GuQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(39860400002)(396003)(186009)(451199024)(1800799009)(9686003)(6512007)(82960400001)(38100700002)(6486002)(86362001)(110136005)(6666004)(478600001)(26005)(6506007)(4326008)(41300700001)(8676002)(8936002)(5660300002)(66946007)(66476007)(316002)(66556008)(7416002)(2906002)(54906003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d+sOfUeyxgacT1rr8XOSEZwtPUGegnsh/drHV2Ph0l/XfIsmaLs3Wo0zmw5q?=
 =?us-ascii?Q?3zrG/HcOxpsI8UzdnoAJPEZOhLDvMvfHJkN71NBkk4hjucAFv9VDmjFLtnmc?=
 =?us-ascii?Q?zQrc50i1ZB+6d3IhR68bO1YGddQD3e7k5jw/jAF88adb+o6lA3D5xKjTEQPt?=
 =?us-ascii?Q?7rJeCrCDxb0ZHiWPOZ/j5ujVa/gf+RqgI3tx3hiHM8KCATP/UVEk6ZB1AfDT?=
 =?us-ascii?Q?Z9tnqTUOZV8aQYSKp3X7itTbLLdc1KmhYumIPvxXcODNLd4AGOj4Y3vpiEXt?=
 =?us-ascii?Q?OlQ7y+LW4BiwTCIu1tcTEOq1GtgdfWddTTyEPXRx/nkihIyE2bfpu31XWNa7?=
 =?us-ascii?Q?nlZzUcInXuHWf5pcUMQwgYk7gpfb/Pok6XVNnWeOhzL2NPglD4gxhKFX8qQ9?=
 =?us-ascii?Q?Q0+SoDeUiZf0mgi8jcOjpKgxDUjNgIsh7sZb5h+7aABUqGt4xA02wJdNFfuH?=
 =?us-ascii?Q?iufBKAdEf+XpPqC+/NoRchjmdt8W/m5HEV9KHfs9YBVC/Ev8sH3X+lZHVs6q?=
 =?us-ascii?Q?QRV1a2+kLMEdOfyX9Ho+1P97Uh5+yjLQiSksj3qjYREDKgM8bTmJXFjCJpLL?=
 =?us-ascii?Q?3W0Q5fNQLRUkxNx5U2LbDyOlDcBtYbKVl890sXLJ3jPzTVXJbX7xP+tH+1wg?=
 =?us-ascii?Q?dm3gTKl/7tfNhwPD6Adn0GO/s7XotN0qDPgqSCeBgCnSPainbryjSIKWaweM?=
 =?us-ascii?Q?SAJnvNbtEikv21sacIQe+41pI7z2jk9CSHzZaGqL+oleR5YtUQXYTzBiTMZ4?=
 =?us-ascii?Q?Oce7WH4tLevndngZL1WJBt032xN/hBSHLRx/Dp/xf6y3Qx6bHgZ1fFifXudW?=
 =?us-ascii?Q?NeGIqY+/dRiFsjEXemF82NXl6ZtRqJzjyhVdPSnBJAt7+mmcSVPjGKejLpzC?=
 =?us-ascii?Q?SpWh4bZ4F+yfJ5koMmbiFhbXGWBECbfJBPLqbLWBao2VHkpbLtCv7JR6dcDH?=
 =?us-ascii?Q?l1AMGHjwia1HJdZchWRryXL6xpyPeQ6gt7i9lIg+dy2no9FDHoX0XWIhtVlU?=
 =?us-ascii?Q?xAuRh9BFJmzjJ1YsmFPdkApfBx5VV2ZNohI5wyAZzaa7KwsKCBsOTG6/ndyg?=
 =?us-ascii?Q?nAEoA4CRWOUx6CAqaCpqJrHxs3UR84e/pkID4ahvmRlzOdwbjIusOLwzd9Im?=
 =?us-ascii?Q?9utPBP4/KkX5GO+6Rwi+wxDP+UuMSG0Y504b1aF1CaAoArVqPmZBM7tXm/PL?=
 =?us-ascii?Q?N4E5ZRoAzAA0OF0fT2FMoiiggBDvRaJw1qWVVRvMpJg9c0wrLqFvxZ8KkccI?=
 =?us-ascii?Q?oCV7A5x5mjJPu24+tjHuznocU10B1lDTMIpwL0GbY2Zc0qAB54BsfIaBgaVN?=
 =?us-ascii?Q?wTpVkUPf1N8kXvMEWmEwVJ0Wt3evTo0P/nkvOf0eQ0xDSHSdCPmWo6AEY1+Y?=
 =?us-ascii?Q?loAPphh+cX1VDEf0vmm0FBWS00akR1wnxYVy+9io64xcMMnfmMU6ZWTgCTCm?=
 =?us-ascii?Q?rcyR0uZM63ra8AWerPECgr0RaPd391Bz4bMuKZ8VbyJi0ZOePaDeqcNxKx5x?=
 =?us-ascii?Q?nFQvUG2uG1DLc7AfnWAv/W/kK/XS0r/rI+9QifYfMYm1C/CUyY4kAhcPIP1b?=
 =?us-ascii?Q?j5cvB4jlaMibP/LqxSzM3IA/Piq8AOqaWQPE8AvUN9fdRVJwhdCpJXVm9Raf?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bcd6263-7521-4d44-adfd-08dbb08766d0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 16:19:39.7010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6cXMuGpHL9TdFlwaFYqt/ocKGvZXCp6J0Jm6ufqD5qfoLNYER6+I9BRJhbd9+HNZhQWJrDkZ2kKryFXt40QRkMb1kbgE4pKMe5gCtA7acEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5614
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huang, Kai wrote:
> 
> > 
> > Changes since previous version:
> > * Used ConfigFS interface instead of IOCTL interface.
> > * Used polling model for Quote generation and dropped the event notification IRQ support.
> 
> Can you elaborate why the notification IRQ is dropped?

Because it was a pile of hacks and non-idiomatic complexity. It can come
back when / if driver code can treat it like a typical interrupt.

[..]
> >  
> > +/*
> > + * Intel's SGX QE implementation generally uses Quote size less
> > + * than 8K (2K Quote data + ~5K of ceritificate blob).
> > + */
> > +#define GET_QUOTE_BUF_SIZE		SZ_8K
> 
> SZ_8K is defined in <linux/sizes.h>.  It seems it's not explicitly included. 
> It's better to explicitly include it.
> 
> Btw, although the size of the certificate blob shouldn't change dramatically,
> the Quote can also include the "QE Authentication Data", which can vary a lot
> depending on different QE implementation (e.g., containing geography
> information, etc).
> 
> I wish eventually there's some /sysfs entry to configure the size of Quote
> buffer, but I guess it can be done in the future.

How would userspace have any idea of how big the quote buffer is to be
able to set it? The output format at least needs to standardized within
a given vendor's implementation, and future variation should be
de-emphasized relative to getting to a common report format across
vendors.

[..]
> > +/*
> > + * wait_for_quote_completion() - Wait for Quote request completion
> > + * @quote_buf: Address of Quote buffer.
> > + * @timeout: Timeout in seconds to wait for the Quote generation.
> > + *
> > + * As per TDX GHCI v1.0 specification, sec titled "TDG.VP.VMCALL<GetQuote>",
> > + * the status field in the Quote buffer will be set to GET_QUOTE_IN_FLIGHT
> > + * while VMM processes the GetQuote request, and will change it to success
> > + * or error code after processing is complete. So wait till the status
> > + * changes from GET_QUOTE_IN_FLIGHT or the request timedout.
> > + */
> > +static int wait_for_quote_completion(struct tdx_quote_buf *quote_buf, u32 timeout)
> > +{
> > +	int i = 0;
> > +
> > +	/*
> > +	 * Quote requests usually take a few seconds to complete, so waking up
> > +	 * once per second to recheck the status is fine for this use case.
> > +	 */
> > +	while (quote_buf->status == GET_QUOTE_IN_FLIGHT && i++ < timeout)
> > +		ssleep(1);
> > +
> > +	return (i == timeout) ? -ETIMEDOUT : 0;
> > +}
> 
> Why can't we use wait_for_completion_timeout() provided by the kernel?
> 
> Btw, can we use _killable() variant?  Supporting timeout brings extra
> complication, and I think supporting timeout isn't mandatory for the first
> version.

It definitely is required even if interrupts were supported. The kernel
needs to give up on stalled operations in a reasonable amount of time.

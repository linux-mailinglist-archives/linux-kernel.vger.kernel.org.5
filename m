Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0732C78F1E1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346939AbjHaR0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346937AbjHaR02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:26:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2E6CED;
        Thu, 31 Aug 2023 10:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693502786; x=1725038786;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uyWQWcmOOt8+QO0rmW3uZAPaA68K/GqevnktZTIplYg=;
  b=YSp9FiDEpspiFbVvbHAm9I8Ik2Fywl4I3i3mCZyEFMNB9Mfn+00zlZBJ
   HX9aZBb6RFgb9SOeq63HMXDhk9CBEgjenpu5jw6s9qhvQhX1Gmbv3wCwz
   qaDoPox6FDFe6reeFQJgkA533UH/Ic7A7qe6ztjf1iE1mvg+8u3jZj1jS
   vVazq4PTgAwfLjSVINfsqAQa+9cfMquZMeqjQwjefW012ioiRo8w7LR2o
   K6dpqhMch/vMw9bfFll8T8Eh1VnEhzHsjMMthY6v72nto0QXYW38Zq9Jl
   3HAH9rOeD0O2YD2u8BldNpb0jJhuzrgZtW2rWEmk6/087r/hgbJv1mq3R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="442407877"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="442407877"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 10:26:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="809726387"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="809726387"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 10:26:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 10:26:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 10:26:24 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 10:26:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7KtVuCXLegBkW1V3kruATXgBw3uGSzst5R8AReSkZDr1VUveu6/6H0Laz6rcznp1aAEfWHk/qaE4763EDCVViL83nJm1IO9D1rmGimq2b4H6m+zwgnSprFFaWFPLfMlxK99HQkz5KmsfMiwuL+A1NdsnAAJmjy44QK8UarVilmSQSmAXwMxoiTpkxz4nIhDPOee5TF4SPhCcLluy57V3xQbMMK7fPixxhiwU7x8HLcN0+H5iU1Tjgg8Cg5Yu3ymH0D2ogMav2uxWAGzUfjFf2+2cLlEraQfKKimQc3VK/7vXYdRcxJY+dbElwVozeXhhxNa8uSG/XMFv+2waxcw0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mS+DNPimFJ9WXmEE7wSK9zzK5zGzNOxRNiYcUaDbdYw=;
 b=oClGs8S62vB8AIBIaSLPVDsmMr0AxqK7/M/qyn1g3aYoCH2z9sTB7ekUr0kNbTlflWQgbTeThKhb4ePfo7gt4pGf+hjIcC9or1654KwKyJui6rltZ0p8OvwIR7dzTgI7/2tRQe7AnZQ1TuLXB+rkTwSHP4n6lubkcLivYc3Wwt1HqJrFrU1q9I01sv/diiIQZZe2DoFRMy8kprkRYW3ydCXE+DB4vSBKCfwKAoKfKramSxYaF7sQHywVVLZitqggrhxwdJmrUMqFyBIDfjI/3ihPSuMi3hOtN8NKr6GElTnG4AJMPExRXgTL+ykyrNiyW3OPPtFX85ShrkGa9Q7Ing==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ2PR11MB8472.namprd11.prod.outlook.com (2603:10b6:a03:574::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Thu, 31 Aug
 2023 17:26:23 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::6534:8c04:b4c8:33d4]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::6534:8c04:b4c8:33d4%4]) with mapi id 15.20.6745.022; Thu, 31 Aug 2023
 17:26:23 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        "Babu Moger" <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 1/8] x86/resctrl: Prepare for new domain scope
Thread-Topic: [PATCH v5 1/8] x86/resctrl: Prepare for new domain scope
Thread-Index: AQHZ2tLJaZzqU2XJm0W9Zs4AKdu/JrACiWEAgABVEdCAAYKjAIAASSPw
Date:   Thu, 31 Aug 2023 17:26:23 +0000
Message-ID: <SJ1PR11MB6083112BEC62D2AB6F432EFFFCE5A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-2-tony.luck@intel.com>
 <bssbtlnjbytqoraiamg7igvawtmlnimzthud5mlacbmjotivhj@hrrabdpmkbjx>
 <SJ1PR11MB6083A9F0B30A6009BF00235EFCE6A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <4vvfwrtbwcxjx35lfogoiekuq77g5hqxcgskjt6dd6pf7ehg2v@edczy6764cyz>
In-Reply-To: <4vvfwrtbwcxjx35lfogoiekuq77g5hqxcgskjt6dd6pf7ehg2v@edczy6764cyz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ2PR11MB8472:EE_
x-ms-office365-filtering-correlation-id: f9999bb2-3a1b-4b61-714e-08dbaa476600
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ThiZ/LRS53ypZBSmXe+AKExusVYlrdwz5ugsSE+3I2RkzCI0ZxVepbM5m6/gWeKqI2uEmSj4Z3wOI2ARvjYE4JUMwTljLYsNVzmLqs2vMX3a3Cib6ivShZy2d/+FreD3J9xbgQnZFca2ODztCDHWyWHJiDUVFNhctcq7gKDlAG23jkZ2ugd3SAw8CdJXYgH18+LUimPikjQD2LPc5FSupMWMFGAM8Jh5kYimrOgXzoVnsV6EEid7zyD8hg5G42xBYADHHNEW940sG6SE/AWdUHj+a+tGlzy6JIFihMPlEVb1i3iUS6wwpVuNMM39SOvTmE02fImmkd+bMv4AO6HI77Kmpc9i2AHwVZVqwDk1Ocy2uEyHmITPya3MGb980DUS7+hDA+DowrsRwETvyc41qUv/1rAgF6vJm7VCn6dEmyWHxnho3/ovR0ofpIAWCxTrQ3k/xBUZcdJ+5rZEJKdx+Qt5EnMJROhoTeUHvGNVHUc6vLUwjefFsQGg9yPvXbMnmAFBaGnKsyXFXzL/G5LPpISaRRZx3sKARD7jfXSh7gsqcC5GUuQu7FlOiwimJyeipPD2S2m0/SjRnycuUD8Z355XtUh/qEj9ktJcqB5lLq7J+joYf0I+X5DsNn0IK87z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199024)(1800799009)(186009)(2906002)(8676002)(8936002)(478600001)(71200400001)(7416002)(9686003)(64756008)(66476007)(66556008)(38100700002)(38070700005)(54906003)(52536014)(316002)(6636002)(66946007)(55016003)(66446008)(82960400001)(122000001)(83380400001)(33656002)(7696005)(6506007)(76116006)(5660300002)(4326008)(41300700001)(6862004)(86362001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uTK1EmHtrrk/aZdidKneszJ6hEu8vCtuetefclc0KGBVTSrwzOy6dr5azcEg?=
 =?us-ascii?Q?o3Ef6xHTwfRPHFWXZmltH+x4f7OvChMA5iF9Kmv6l0U3t4BuA9PuU4P2WeqQ?=
 =?us-ascii?Q?+vgfpbo4dFadxVgEBDHiecgI2/DEFlNmcp6aX3emIHn/zfPzPSuRjfHdW6VM?=
 =?us-ascii?Q?YE1K6yxni/1OSC075iAw73S1HIL1wevRT69Zvf3mo9wgl6ZfPKMmCtzmMP+Q?=
 =?us-ascii?Q?Z6qNJBXYA2q6btZTLO2Xf/wauz44PeLIP3oM3+C7lHvmaKWmHQAGqMDAQy7S?=
 =?us-ascii?Q?N/u/Gjuyh6lmBuVegsdoz9eNpTaL9XeClo21hfdhbOx47/9XUgHoj0oUcnUY?=
 =?us-ascii?Q?+SfNwHYB9AnvLCKrv1AKaa9EglcGKUcPEseWh+QH348XIEWRm3/HcJBJ3TKh?=
 =?us-ascii?Q?jS/OPBz4s3pCu3Mw7qCSqFcMGTCRpoMUTEcZM8a0rRfZW4cQOhoMGUQ1C4EM?=
 =?us-ascii?Q?fPMh1NFJF6IU9q+Uasc1eOUfMBVJX6X8q+YRiIrXHnSKxhzoUvwNDoopHWQY?=
 =?us-ascii?Q?DtqjwjNQ1EqGSccUZ1xWp/Ig3rugQuVngTIIQqCNxh8Zyz+jA42toVMIiyfN?=
 =?us-ascii?Q?7Li9R5qK0zLLM+1dn0M0MXtlHOAx2bXML++Mekrnem+gO4tXYBZW40rbfUfS?=
 =?us-ascii?Q?anN3BU7lSHBjv0fRNLR3ybQdVkLz0jHKJ0LE0dgr2BjBpV48hUi+6ey7IOBy?=
 =?us-ascii?Q?8E4a9F7dAM1PK9RfGvk2pDwnbI/A7cVpuxMCtxnh9zbUVEcj1D4JFR5ERn/r?=
 =?us-ascii?Q?iuv3/LzASmeK+/EPV+rO4Vxksduu+hg5jJiFmks+NIsB7HRtn14cmvfcRjKv?=
 =?us-ascii?Q?qu4QjyADFsAy4b+AH8MhcDJuFJN/Ray16kpdPNaDvv9dF/nRDvcjPy+rcszn?=
 =?us-ascii?Q?nf8/FQONbNt5WdMYWcqo3/fdeSjZywDxPdizuCJkDXgyyIEx04GPGyHpCR9t?=
 =?us-ascii?Q?u8L3UHxY0z3kGJZRfWpObUPBelkUpqeO8YjSDEsP9UToYf0cBoAQsWuln3Bo?=
 =?us-ascii?Q?dzydL9viPbe3VFHVWjgiwIGRUKdoOG387NvT40BumTVeiTDxaZAXFaHpiahx?=
 =?us-ascii?Q?bdTnyxN6dAVeaR9ntZarfXW7ZfTHvHwGQj5hSR5wwNa3TfL8Kq+eS7ZDHPM1?=
 =?us-ascii?Q?bcSFBfYNqi+aLMuYZ7H5YRVg3k1Hx8v70jHvDNZBrbDC1C3UDG+Qt5D6FHNi?=
 =?us-ascii?Q?gljGo+cGCQUETPCtlmKlUiwQb6nAKZZsfDw58vHkoAM8ZJC83lRcwi0kHREx?=
 =?us-ascii?Q?/aVeIhWvZ8Ld2T2IubtSbjy4qjdiQBp8WlrhdtPg7NnYW+y/UGaSkqp40LC9?=
 =?us-ascii?Q?W77j5RI6TkiCsVZ18JreoaCWrUJB2BGFQmB+ayygm6wlbacp/07KjzmO/jYp?=
 =?us-ascii?Q?KVudznK89fUBja1XxXsVAQc2hBegVlUYejCc/H1Yvwgw8aP3vArZlsIuWmQa?=
 =?us-ascii?Q?bzQvrn6Y0/zuNsmfdylz94Y73vqvAAvjWWOzCuPnEhZ/FR+kUu1tsNZH4Jcl?=
 =?us-ascii?Q?KNT488K2aIT9Ywshjel6T3H6XYDLNGJFXVbymhdpobCztBgqS1zScxKHtRbb?=
 =?us-ascii?Q?AXsmxMsmRWx9nGBGA14=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9999bb2-3a1b-4b61-714e-08dbaa476600
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 17:26:23.3552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2yFahKUyYVcg1hSFKHlmVCK9MKb6H5j+9wKIbPw4GG0PGuiwnuDxN+vHWlfOZ+ieDl8TL+/WKsEGsg62hR8pIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8472
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

> >I've sometimes had compilers complain about code written:
> >
> >static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
> >{
> >        switch (scope) {
> >        case RESCTRL_L3_CACHE:
> >                return get_cpu_cacheinfo_id(cpu, 3);
> >        case RESCTRL_L2_CACHE:
> >                return get_cpu_cacheinfo_id(cpu, 2);
> >        default:
> >                WARN_ON_ONCE(1);
> >                return -1;
> >        }
> >}
> >
> >because they failed to notice that every path in the switch does a "retu=
rn and they
> >issue a warning that the function has no return value because they don't=
 realize
> >that the end of the function can't be reached.
> >
> >So it's defensive programming against possible complier issues.
>
> I recall getting that error somewhere while playing around with a
> language server protocol for neovim a while ago but I tried to cause
> it today with gcc and clang and with some different flags and coulnd't.
> Are there some particular compilers or compiler flags that trigger
> that?

I think I saw this from an lkp report using clang. But it's quite possible
that the exact code construct was different in some way.

-Tony

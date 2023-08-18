Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD580780548
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 07:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357946AbjHRFCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 01:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357944AbjHRFBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 01:01:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D971E3C06
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 22:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692334893; x=1723870893;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BpMp5Har4BdJRwZUGDxHhz/cFORuXx/qJTTujkGvbN4=;
  b=hmQ7v5S1CWCz1wggQUhAJAmfN819IbcXhXSUKiGWUKY5wopA9n4R1gsK
   VsYIzAAmTp0OGqpe2TqVEB0mMo5Oh+OiVQS0d5OOYcMmVvH2IliWTb0/f
   93+KMdtElF8QzkxY0cxhyb5CmiThqeCYGeZCcYCaSk+39j5lCtJqiko1L
   zObfCtO8EpJs3k6UL1+769yi/idOTVHI5L/byyROeZKsCTVJ3jifaGf/d
   aLM0mPshJegOzfU+oOu+MDIBKLzX4yDh9w/zasyjrw3MAWUNJFfhlpSzN
   sdqeknzg2pskV84sildzdAjyevTfdmNJLp6aQ+irDH94vJrriYobI1bcK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="371915918"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="371915918"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 22:01:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="805008453"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="805008453"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2023 22:01:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 22:01:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 22:01:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 22:01:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1hGotsDSzi6SaRNgBbG1nXhYGY/lQlkRBUk4IoEPhcDGpOuwjVCpG9HwvGd0KwSOTIx4xl/Zl/5SOFJFaZcWd/+rr9v0LggDomPLm11vocTjRZCTW3PgchPNg4PuDZes3Ut1Q3TttriHwc0Z0oJ+o4TfGhZnl3C4g8aqBO+VGl2M/3KumKeVTKouTpEusJv6Ne34+pfSqvfjJvpTePy1KaKj68z4D0E/EBStYoLKwwfyioBzC+R9gGiPq9HICdtDZtQLH9Hyp1tm338nSxm+9kUzn5MthxdvSn5BJxBTU9HT7ZqdlDfY8en62BvZblwuusVqkvj7NvY82hqtUe+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMt1a45h5p7mZwMIXfYlG4Cu3BlhCWTEs0zQUnqXSwQ=;
 b=mv4zJueU9DAXUD+IiTs9pArZeFUhyUVvV2eQ38sxn789qxOUhCPO0anvciCk+oQUDaoC4iNhrCKd+AX5//PY7nuLcMys2/uZJsb3sBR6AbTw5qQNn/q8vQE8ClwrqNe+iBJ13L81a3mbgZPxUUxRHVr6+M+Dc1ZT30MKS3r/b7Eox8WhY8IbxUY1X3T9+KLhPv1nCbJFnJlNZr8YbHog1DIwONKh6dUEAZ/jTFO9GUXTcv1tg+62QeMjq5Pmjr2kokyZWPTmu3gGWOU215EdyE0BquT7HJuHZwBizF23lIAO0vstL+/a7gV9Vux4GVw1dsf352veWl54DspwTuSX8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB6010.namprd11.prod.outlook.com (2603:10b6:208:371::11)
 by SA2PR11MB4809.namprd11.prod.outlook.com (2603:10b6:806:112::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 05:01:30 +0000
Received: from MN0PR11MB6010.namprd11.prod.outlook.com
 ([fe80::3f6a:413a:ffe4:7b5b]) by MN0PR11MB6010.namprd11.prod.outlook.com
 ([fe80::3f6a:413a:ffe4:7b5b%7]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 05:01:29 +0000
From:   "Brown, Len" <len.brown@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Gross, Jurgen" <jgross@suse.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: RE: [patch V3 27/40] x86/cpu: Provide a sane leaf 0xb/0x1f parser
Thread-Topic: [patch V3 27/40] x86/cpu: Provide a sane leaf 0xb/0x1f parser
Thread-Index: AQHZxSuNHqTVYruCfUiH6AgMgzkGq6/mYcAAgADEZgCAAT52gIABItGAgABDd4CAACAJAIAAH1qAgAGk5gCAApuqAIABPhYQ
Date:   Fri, 18 Aug 2023 05:01:29 +0000
Message-ID: <MN0PR11MB6010D09FF7C20779B70A3B83E01BA@MN0PR11MB6010.namprd11.prod.outlook.com>
References: <20230802101635.459108805@linutronix.de>
 <20230802101934.258937135@linutronix.de>
 <8e5bbbc91ff9f74244efe916a4113999abc52213.camel@intel.com>
 <87350ogh7j.ffs@tglx> <87ttt3f0fu.ffs@tglx>
 <b8637c8c92751f791bf2eae7418977c0fd0c611d.camel@intel.com>
 <87il9hg67i.ffs@tglx>
 <MN0PR11MB6010CB72411BA723BEFC5565E017A@MN0PR11MB6010.namprd11.prod.outlook.com>
 <877cpxioua.ffs@tglx>
 <MN0PR11MB601007E7DAE4C5FC86E58DB0E014A@MN0PR11MB6010.namprd11.prod.outlook.com>
 <87fs4ighln.ffs@tglx>
In-Reply-To: <87fs4ighln.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6010:EE_|SA2PR11MB4809:EE_
x-ms-office365-filtering-correlation-id: be7bf91d-c3b3-4911-7102-08db9fa82edc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wIt8yCSQtgd88GKRoJsVS/11akzfhv2wL4Y9lwg/18uwtLV/zfW7PQlIKOKtWRWrITMiBQeoOQ70N9hQLKfJhAioTQFykfuhs1FpKxaMNylKL2qyAQEVSBhPXsAHMfk1weypp9yfMOwVZFI682R39RA0E6SbcirnHGcfCk2GovdfcmtGfI0wFRXXfYChSKGwaPIOanxZv20Xbo8irZ8JMHK6h129xwtyzn8K2KAZulDH3+e35AqXF9cEk1QwWyvZtQPTBkGcXE0b6EBHGQxEBXhQyeGlgvR8KDgWkTK9CvS5M6FWIB0H4em9Fru7rKDVFYfT9AnQI4dNKf9O5/DIYm5juAw/0+Y1i7Gun2aulWYzhK2cucO4+ZqxZfD6BCNld47guOfXR6QET7elMBmW/pfiaiD99K0PkPyfxwawLAvimC2+lotuBA4qHVg4mJWZNRBE8aO1PNlMMlkTUH3eYEb4nyia1oo8dOt9rmHeusKoUnpGIuctkgf25pJyDPyw97ozMtbCxXZ9gJFKDNr7+PSuwOBg4/Wn17pM9YgHqWlNwvuDmdS9Lib5pJUNycsTlgwVrUEkA7qb0BBHFI6KjVBR0fr0cSIc5EOCfhCKnhUY5PmhGxnpvUIuOmG2qiZz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6010.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199024)(186009)(1800799009)(86362001)(33656002)(82960400001)(122000001)(38070700005)(38100700002)(55016003)(478600001)(5660300002)(110136005)(52536014)(76116006)(6506007)(66446008)(66476007)(66556008)(66946007)(7696005)(71200400001)(26005)(54906003)(316002)(64756008)(4326008)(9686003)(8676002)(8936002)(41300700001)(7416002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MIXj3EfTii0Q4lu+6WiDChl2Fv7EMxsU0diTy7Q226llaq3ikrVfWDcRjFpz?=
 =?us-ascii?Q?dbkZU7Hr3CuGMwaQqJWni0nMySlFMcFo1O87RYsWYBRhSatpYYkdN90HUA+3?=
 =?us-ascii?Q?ao6GNazIngBnV3tiP/dSAAA+2F/O5F899yErtSfnCHCWe1L8xbUSIlvzpMvH?=
 =?us-ascii?Q?3V3gsikFXwq1/GifzOrxb/ldv7kJyStz4fy3cGBhsypwxfUb3k3rXfM8Am0f?=
 =?us-ascii?Q?OugoMgzv6ZeM5zCdwO+xgIO4Ot1xxTP5UdlhvinwNuVA4UTZST/P1NeV6x+r?=
 =?us-ascii?Q?7zGpmd3+ql9T+XFSuKt8HHaj0ZxUyAzkAUK9HrSqipunnXpqC7S1SX69sY2T?=
 =?us-ascii?Q?SjLXVIsWx99keZQdZVaBbCGzsBKQ2IxXSGZe6ey4hYLGIXbLuGfAKpIQADqf?=
 =?us-ascii?Q?NhwC9GHAVSv3lQdyACPytWRBPaKd6BgFUztiEJxCoLNB1BWwz+IE7ZQCy1AS?=
 =?us-ascii?Q?RYvYAIULqFyuU9X6HB9+tIKm9uJ8XwIqoHQMH7WxBa6IR1Iihmhq08sKeNxQ?=
 =?us-ascii?Q?s/1VZaWMnYV+NgFpI1iQc/EzJsd9ny5oAPeQj9g43MB/iEpLUow7BQH/DDlk?=
 =?us-ascii?Q?DZzWk09qexiqJO87tmxfjgOG37q+PCnjKnjMNBzRTr8GiLPwbQifySF+5bRH?=
 =?us-ascii?Q?YobP+j1zj9XyKBu9WJe1hMBv5tskkgU6N76dqJw8bds8RYmOKmOlXw8j3yod?=
 =?us-ascii?Q?Wv0ajSkvnyH6NAbaRu556m/UNFZe8szkuIEiJWiOlAoVmT/clRm/9gVEXAqZ?=
 =?us-ascii?Q?6ZH/IvyjIjTmPktKwGw9yGsMRn7E9Rmc/ROp4uJLvLrdSmEWcjL9BKTQRw/G?=
 =?us-ascii?Q?CT6bwwO2rvNyJ4ZJQOeHZQgJmgYkQNqyklciXzN1utIE1OkZeYJzUvFWwsh1?=
 =?us-ascii?Q?woudDYdToEVtphLyUPrABkG6mZWQduktkvA2kKBYCoynDSbS7YolFKctLTiY?=
 =?us-ascii?Q?uyRGlsD6fPtKzLqPIbJC4K1oupdovWIa+cu4AZCqCrDyRzA4SnTGYYc4aI3W?=
 =?us-ascii?Q?BL9COiNTjF3Yn9ybMx37e6F9oImpFWDTG+c4PHzeFIKZ01jM3Mcox6LcMSJx?=
 =?us-ascii?Q?iQH9my/T1n0CdhCz0It/ylhIZKIIKApcm+yagK6Cl2OPgcTJTUSD8Pkm4Wof?=
 =?us-ascii?Q?M8zlTxziv9d7dcbzgXFhaOEXExZKphkVkviMwm4KqeehTA5v0KmOvywGXNoD?=
 =?us-ascii?Q?8E+H1Yjbrt2uHehUBIw/O1puH0f/wQW+mdK+R+37lOameHoQpLHVLvfEHpBJ?=
 =?us-ascii?Q?OjZh9m8+eDk6Tuw1fp+D7KzZCyxzunGeadOp50WFXIsB/MR5Ay21MkSO9qde?=
 =?us-ascii?Q?0LCVkpQu/lUIpiEsngz+fkXBpv/1sZoc9avLmNo3t9ARf9GQN/8bPZzrLe7z?=
 =?us-ascii?Q?G7YfddaCmT97URRSRdXcZWzikDTkAK31XBSwcF96GgHuG/qB9O9w9bQP6aKx?=
 =?us-ascii?Q?PQ0KH5t/x2Xvvihectx0sMT7uHG5z3YgmLkzWU95LuFflOCrW+8HyelQ5kkm?=
 =?us-ascii?Q?47FJa3qC4NrAlKV8LqAZRXjwhZMInCwreSO0UtZjdCLVg9v3YSEwsmSBUetV?=
 =?us-ascii?Q?w4xI9YUvdXM3LI422oMsiMGEyBYbeQDffSTDJMTQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6010.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be7bf91d-c3b3-4911-7102-08db9fa82edc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 05:01:29.2352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yr5zpZ4KU4P2Es6SWocZFqgpaDYPCdtgodImsKQd6nXF3RnrdaggFneQ2fFrLJvYDOyUntkOty5SfyW5NFp5UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4809
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

Thanks for listening.

Discussing further w/ Rui, we realized that is it not possible to future-pr=
oof the CPUID.1F code against the insertion of a new Domain at an  unknown =
level in the hierarchy.  Further, CPUID.1F explicitly documents that we can=
 not count on any numeric relationship between the Domain Type IDs to tell =
us between what levels of the hierarchy a future Domain may reside.

For this reason, I recommend that we proceed with implementing internal ker=
nel parsing of Domain Type ID 6 (DieGrp).
Even if DieGrp is a temporary name that changes to something else, we can a=
ssert that Domain Type ID 6 contains Die.
Thus, on a system with both DieGrp and Die, we know that multiple DieGrp pr=
oduce multiple Die, rather than the reverse.

If I understand your description correctly, you propose that if a level is =
not enumerated, that we assume its id is always 0.  I agree this is the rig=
ht thing to do with Package, and we should continue doing it, because we al=
ways have a package.

However, I don't think this is the right direction for the intermediate lev=
els -- for their existence should be able to be used to enumerate the exist=
ence of level-specific features, and 0 suggests that those features exist w=
hen they may not.

Take for example, module-scope MSRs and counters that do not exist on syste=
ms that do not have modules.

We should only have a valid module_id if CPUID.1F has a non-zero shift widt=
h for Domain Type ID 3 (module).  Otherwise, we should probably be setting =
module_id to -1, so that code looking for those module features knows that =
they don't exist.  If we don't do this, that code will have to check model =
# (as it historically has) to determine if module-only features exist -- an=
d we've thrown away the value of architectural level enumeration.

The situation for die_id is similar, except that there are no die features =
that don't already exist as package features when there is just 1 die/packa=
ge.  Ie. The die-aware code can simply revert to the package code when die_=
id=3D -1.

This, of course, raises the question of the sysfs interface for die_id, and=
 whether it should return -1 when there is no Die enumerated, or make that =
attribute simply not exist when there is no die_id.  Either would probably =
be an improvement over conjuring up a phony die_id=3D0 when no Die is actua=
lly enumerated.

Thanks,
-Len

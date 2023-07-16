Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A88E754D82
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 08:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjGPG3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 02:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGPG3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 02:29:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A521A1;
        Sat, 15 Jul 2023 23:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689488947; x=1721024947;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KrAdlbCLz/nSLKA4Cpxd/YjTJ6aYknwXx4RZObgFRAI=;
  b=kKoQF3VzeE9PRr6tVcwbpYUD5mKLFH/TDhSr77YdMvgIjlkhIQh87ezi
   sh61EqZeCv+3qtFDMcpSSkIOCYqI6s7q0MBQCUgNzt/E4PW9NZoAhJ/OS
   Smtlfh8EDvEmjvkOLASAPBJTM3LV7PuvRkgPr85WlSVrc9g7JbFapmm9O
   OPoj1iMIeLjPKk+M3nI5Tym8scfcc5Be3c6rtK3JccHEBWWZL41nQkRRZ
   KtYG3GDrM99pDuA3LF/arSpBU9MSbgLUvWjCcatLKLbQbtR1KGA2LL+zu
   CacfDVMgRdP04t7Y+a7XhCYlnHfh4WMgMx/bt8J6P7pWkOc+a+qSr7+vf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="429491252"
X-IronPort-AV: E=Sophos;i="6.01,210,1684825200"; 
   d="scan'208";a="429491252"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2023 23:29:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="836506405"
X-IronPort-AV: E=Sophos;i="6.01,210,1684825200"; 
   d="scan'208";a="836506405"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jul 2023 23:29:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 15 Jul 2023 23:29:05 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 15 Jul 2023 23:29:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sat, 15 Jul 2023 23:29:05 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sat, 15 Jul 2023 23:29:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncDclADZ03UcTU8MjRUkCH4FQmvmf+1kQQfRJgzxDNxIJERQOSm5fyzyVh9pBSA4imzKSyugDxX0PiyNDGwpSakfcRPyAsu/sAMfMEUz9YnTsK4bnIAiedEjkod9uk+Qpok8ZZhT57jTwQq8pkwsrU9XHc0j9edpwyDrHArSZPriopHXh6lDeyACyKcjuOKX5hXvIBVyI3CKLjAp0tFndkp/o/TqkWCH1ALs6Xs2lTHw3HT+w3rHsuSjRnIJ7Wbq/8oR5iciz8oE5in2leLsxBbymAjLsqECU8SU9tJJOsosvXvrdATHPawE3jbSPp62s9mJIRQIoxQTo0x+IZ3oLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrAdlbCLz/nSLKA4Cpxd/YjTJ6aYknwXx4RZObgFRAI=;
 b=oEh4fLl0ECbX5Z0kiwdJ9GHx2ns3LXBAyb8faQkgV5WkCziQ0689YV3tVyvk5HjB+2Zr+s9a32YnYlFgzw35/fzh+4dpg1hgFVnL3KxLgvf+u0SiBc1yb6r+BaFcG7tR8r+5num0UqBZ/rniyGvgWtaUh3aIHcV54lcoNSS28OtX98JPqlm1agdHoZOiy7V/ByNxZLPx6vwhdViIQWn9W/9Bb0536o8FyQNp+IuRqboFsSsRGAnYN5wPyvBtsdY0vV8I6OiffkPiazGv9Rdfc70ZQY/uA65gE/S3WVua5CP+0VERgb1qStY724xD+bKzij+sYP+2L0/IEHvhO7QC6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by IA1PR11MB7870.namprd11.prod.outlook.com (2603:10b6:208:3f8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Sun, 16 Jul
 2023 06:29:03 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::f8a8:855c:2d19:9ac1]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::f8a8:855c:2d19:9ac1%7]) with mapi id 15.20.6588.031; Sun, 16 Jul 2023
 06:29:02 +0000
From:   "Usyskin, Alexander" <alexander.usyskin@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>
Subject: RE: [PATCH 1/2] mtd: use refcount to prevent corruption
Thread-Topic: [PATCH 1/2] mtd: use refcount to prevent corruption
Thread-Index: AQHZo3n2ZB8U6WhTx0+aElx0ckVEpq+5lImAgAGKEwCAAPTUYA==
Date:   Sun, 16 Jul 2023 06:29:02 +0000
Message-ID: <CY5PR11MB63666C8DA33C93E1DC3BCB21ED3AA@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20230620131905.648089-1-alexander.usyskin@intel.com>
        <20230620131905.648089-2-alexander.usyskin@intel.com>
        <TYWPR01MB87756794A30EB389AB017EB1C234A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
 <20230715174112.3909e43f@xps-13>
In-Reply-To: <20230715174112.3909e43f@xps-13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|IA1PR11MB7870:EE_
x-ms-office365-filtering-correlation-id: 67dd9932-d470-4b37-ac35-08db85c5f271
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WmI13oFM9JQJjH4hljzOrDK6D8fZkdgj67FMrHjvkLX1IWiob0RtNCiTEKw9MvGz9h5bXZAHilalaYwqC8oa9okCvcEIy/FxNvF278de9TMr0LS2iy6vc3KkYuuXBm8VxWUpjHLl/UYCzmaBJTld589dhl8EEGCZu5g0Pm0Ei5bj9gb8mONVi5a1WzzojHvN5/WdZaazbKL6d4HtN+OyrK37GzexWwvd4nrlZuEzRZnVaRB2j2yJ7PSGJMHxj3kHW/wW999HhOOthVo0JBN0KZjpHmlqYdwYFpJKcUot7k2XCmHZYZKp69bA7MpkogWHZOkjha6uZbhhEvxQ+OTeiVAYAWS/Hf/VLzSwkxBnz5YPYacpgnS1ERnfrNV9mShpQ+SE1PIzBvPLXNZruGGZOYyzTrjar7IIXfEtxu0SEt6u4uxqhF6ff4j+OAzcs+X1NWEzBbVb2w/tBUJn8jDohDK7dSDP7NGH0Eang+3eRY/P6cO0UQeiQ8kAp5XqZzxh/DUzTzuPqvJyDVKeOzWMai1MA1oslyRTEMDn+aYuVDVO7PpLxOz+iNnFZP6BizFmbB7l7taAbAjw484ANqjRBNIobbl3I6DQ4+0y8KeUsrPgZOx6iprnXqOvzI0XyQgk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(376002)(39860400002)(346002)(451199021)(76116006)(2906002)(4744005)(7416002)(7696005)(71200400001)(5660300002)(83380400001)(6506007)(26005)(9686003)(186003)(52536014)(110136005)(33656002)(54906003)(82960400001)(122000001)(38100700002)(38070700005)(8676002)(86362001)(478600001)(55016003)(8936002)(316002)(66556008)(66476007)(66446008)(66946007)(64756008)(41300700001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEtGSG03bi9xSlFJbjZxREI4Wkk5L255RXBIMk51ZUx2MkE4VDVyZkRoc0Zq?=
 =?utf-8?B?ZDV5KzVEL3VjR1UwU0drWFdDZzZvejNLNjJCSEoxWEtmaGxIc1hOK1BQRnRK?=
 =?utf-8?B?OHlRektLUVJMQlA4K2x0NFkvcWVoYXBCeS9NMTBTUUNqVEUxRjRXMmlOek1S?=
 =?utf-8?B?ait6Mk52bXZ5b0U0ckdkMmo2Ync4dlpHV3ZXbVVXWWgzeHVFL2huOG1yZFc2?=
 =?utf-8?B?emswcWtRL2ZKOFVsSVNEZzdLQk0vWDhrMzRueFlCWVlrQjkyL2NZcmNjWkRO?=
 =?utf-8?B?OUFjYVl0cWpDZW9xT2g5WGEzUjN1dy9FRmlZTTUwTFozdEVSYWplMGNHUTZs?=
 =?utf-8?B?UVErUGNLQ2VkMzd2bG9xSlRFTW5rZU91WTJMaVl0Ym5tSDNwSHAxTzFKSzBj?=
 =?utf-8?B?QTU2bVZKbm5MQlVrK05OelAvQkVJcExOWlZoeXgwdFpEcURZdm5ZUHB2M3VB?=
 =?utf-8?B?RTdrK0hJRTExbVRrYThTek5pVmZzaExrZkxLL3hnQ3NwNXJuQ2E0ZVpxWGxR?=
 =?utf-8?B?OHFtaVNGSUQ0cWpMdWlzOUQvUEVXVG1EN1BKVTM3S1Bnd29zYy9HWXRSQmMx?=
 =?utf-8?B?WDBzbWlJbmVhQ1hBM2RhN1JCNWJiK2tFdVFKc1lNS3dyeXlRSVFUempjZm5S?=
 =?utf-8?B?YVB4dnpLMEZzWTJtS2VKQk82Z3lBejMySldRbHptYVpOZE5hdS9rWncvUDNU?=
 =?utf-8?B?VTZEM1MzVEhhY3BwNUNsTUVHWXd1eEV3Q0xXYkFadk9ucS9EbktlRG9xL3pv?=
 =?utf-8?B?Nm1tcElndHdMRjB1b0srZVIwM2xVWlJ3VzRqSDJJMWNVMHBtQ0I0VGsxNnNj?=
 =?utf-8?B?cVBuWjBlN3dJTUNrZVZ0ZU4vQ094Y0RiZVhiMkJuYzl0cHdlUW1CT3AyMEdW?=
 =?utf-8?B?Y09zeEg0eGJ1WDRZQmRnNDM2TXM0V3kvKzJUR0NJMWlBd2lIK01mem4wdTRm?=
 =?utf-8?B?cjh0SkJ4YThXTUM0VThvZFl6VXkzb2M1QWYyL0taaTB3Q1pTQ01Nc2NUcVBT?=
 =?utf-8?B?OGJ5MVpDRjd6VEQ5dmc3UjI3MzFpODEzR0tJSjdienI4ck5lREtOUDF0M0pX?=
 =?utf-8?B?UUJseDUxZzVEckNSUjE2eEFjdEdiSWFHRTNJWk9qcStSbXFGZmRmY0REWVVh?=
 =?utf-8?B?OElobFZPL005YmtNcW9jc1VidHlvOU1tU2VabXhYMkNZc1EyRkE1M0pTR0lX?=
 =?utf-8?B?a3JPODRzQjUvNGZ4cGMvZ2UxYmV3aVIxcW55bEpiUjVuTEdldW81bzlZZVo3?=
 =?utf-8?B?c0gvbFkybHVvWVVmNHJxbGQyMU5IWjhXMFF1YWlmLzQ1cVJNcFVjT29VeE4r?=
 =?utf-8?B?UU04UmFjZTJ5Y0hyYkQ0bmNoV0NqU1Z5TTFFR0YwRUhCRERUVXZFenN3SDNi?=
 =?utf-8?B?a1RIYUo5QzJKU0NscHRXeXhNa0pKQ1F6U1d5MnVFV1hOMUNOVlZTTTVFUGRo?=
 =?utf-8?B?OGNrMDhWVmhrZE5DR2QySlBuSFluMmRUSVVwaVcrL2JReDZMQU5hTlVRUm1V?=
 =?utf-8?B?QWNGR1ovMFlMdUp2a3Jlb0hjcUFOdXRVeWs2MEVVUjVuMzIxZVJ4cmpZSDYz?=
 =?utf-8?B?LzRBMFVuRlBLckNuYUh1NlVVNEcwZGpSWWJHeG1yblYvRDhFMjcvdk1jcXUx?=
 =?utf-8?B?T2ovMDhkb09GUEFwcjBicFk4SVdnNFVJeUhLWmE2cHZzNkdkZDlqSHFGNjR2?=
 =?utf-8?B?TGZUVHBacGNVbmVBK1M1TE9FaEhSZVA3REdRaEowQ1NDblRMK2o5TkdoeHh6?=
 =?utf-8?B?NjdxSG1jMmt0VHBsMWJvQStyWmN4dVhObmJPb2wrM2hYbXp1NDZtNERCNUgv?=
 =?utf-8?B?bFU0ZDFiQ0xQS2dObmhFSlhaTUNKMUZEd1pueGowWkpuSDREMFBWeDhOcUVo?=
 =?utf-8?B?d2dHWHluSncwaEVwSm42eHdZYlB5QzdmSnhKVnpROTZ1RUlCc2JGbWU5NFlW?=
 =?utf-8?B?b2RiOFN2MTZVWldnTnhKUTBDeU9nQ1IxYkVvZEV1VTQ5SkR3S2VSOXd2d1BG?=
 =?utf-8?B?VW5zeGV0Z1p5SWU1SHU4SG1XVTFNYlZ5M1hNTzNuU0d6L1BpdXBxbXo5d3RP?=
 =?utf-8?B?T1IzcGVYQmlBS3V0R3I3UFlIZVRkTnNmUFpITzliSjBabkpYMmVzYk02Y2NC?=
 =?utf-8?B?eU80R0VjaDQvelc4Q2tFbWM2MHpZVXZyaHFOMURNUm4vU2xyTDJITldodWZI?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67dd9932-d470-4b37-ac35-08db85c5f271
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2023 06:29:02.5602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: joddXIwCo/k6qnGuzJ5Uy49YaC2dAvbidzBtR4Jx/odmugxAOx1JTLlWCnSQJ5CSi3nrcoE4+7CndAmMFT/tfBbc+SbWV0pd9JLqlZuLfTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7870
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IFdpdGggdGhpcyBwYXRjaCBhcHBsaWVkLCB3aGVuIEkgbG9hZCB1cCB0aGUgbW9kdWxlLCBJ
IGdldCB0aGUgc2FtZSAzDQo+ID4gZGV2aWNlczoNCj4gPiAvZGV2L210ZDANCj4gPiAvZGV2L210
ZDBybw0KPiA+IC9kZXYvbXRkYmxvY2swDQo+ID4NCj4gPiBVcG9uIHJlbW92YWwsIHRoZSBiZWxv
dyAyIGRldmljZXMgc3RpbGwgaGFuZyBhcm91bmQ6DQo+ID4gL2Rldi9tdGQwDQo+ID4gL2Rldi9t
dGQwcm8NCj4gDQpPdXIgdXNlLWNhc2UgZG8gbm90IHByb2R1Y2UgbXRkYmxvY2ssIG1heWJlIHRo
ZXJlIGFyZSBzb21lIGltYmFsYW5jZXMgb2YgZ2V0L3B1dD8NCkkgaGF2ZSBzb21ld2hlcmUgdmVy
c2lvbiB3aXRoIHByX2RlYnVnIGFmdGVyIGV2ZXJ5IGtyZWZfZ2V0L3B1dC4gVGhhdCBtYXkgaGVs
cCB0byBjYXRjaCB3aGVyZQ0KaXQgbWlzc2VkLCBJIGhvcGUuDQoNCi0tDQpBbGV4YW5kZXIgKFNh
c2hhKSBVc3lza2luDQoNCkNTRSBGVyBEZXYgLSBIb3N0IFNXDQpJbnRlbCBJc3JhZWwgKDc0KSBM
aW1pdGVkDQoNCg0K

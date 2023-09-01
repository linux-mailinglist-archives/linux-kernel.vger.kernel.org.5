Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A51778F733
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 04:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348117AbjIACgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 22:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjIACg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 22:36:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA6EE6E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 19:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693535787; x=1725071787;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K9qep9gGSzR3ywaYBGeP4101VMxgh/64kK/rfO5hTRs=;
  b=iodjRpfC4deUJ7bGhUwlkUcL+1wg2SZnLD3cwJDQJy6pI1awuPAlJxqt
   g4ywlQYaoiVEwK3TC+Luc4vz2DuLbNfgBuqz6sL5FJZn1ShlP9ac+dJIo
   iEHbVN1GWSngoVIzyKTNmN+32nMt+LPnDmHesYPdleH3fT2wYIfN+c6uV
   ZlgOumboJYNXwJZ1cWUiJXP5kBRn5t3ia5VHxSRxDfpdeuW5r5Wrsz0Ep
   msBlDl1dr5jJFzHd+j+Z/4TmfJSf88BSzMBsnkLNEl4IMqiYqbAPRPnLu
   CtnZ7tlUw1WI/Ct8fJ+lGGC+MEHOCD1/Z67J5lGFiFVC6/SDCtU0/wNHH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="373514685"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="373514685"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 19:36:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="774833664"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="774833664"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 19:36:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 19:36:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 19:36:26 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 19:36:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tpi9u87fChKQ19182/Fc9cbzDvEqtMh4iXoeoHw9MTKz7l3Brmx1WZ9X5ieo4I2h4YQWOZX7+PEyDRSZt1X6d8outUvTcPONmcLot75T162kCssJU2b4V3+cMCS6vg2mB/dMRRwWbfYdyfgKtgiKboHcLaLz+REiq2wRp4dI1DzRbFXSPrrkxi7a6SYWLRIemgQpQFOux5sQuvG2vBQiai/OTSM0lr7JHvpKJirZjxCYslvEMD8mbJ872z1ST12nb+qzYnOK9mpsadSXPjH62tGGCECXeKc7j3VU2sQDixlkhn5FO3zr5nGdGC8RWCK6wIFcqJa7ZxWZ3P9hjHFqAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9qep9gGSzR3ywaYBGeP4101VMxgh/64kK/rfO5hTRs=;
 b=TKOkLMfVjJo6UEj/Y05Mg1AK9lClCU9VawwD+LwpL6HDSHKtwLpfH6ZG8/giUB63C5Q13KQc35VCb5Ij/o0EALvuqLbrHKGeGUGhk1PXoR6GkGnbPYeQ9oqA18mqZfIgCJn6IKJ4GkL1KQcGO+QIF7cbDb+iQsT+8B8zbbZP15YO/mQIhK1zGopusPqq4quReeIkMId4WpAsQOePkmOLBjfwyxqKyQBPVldqRf6kvghmDc7SIxd6JUOSFgWaJozVfQ/XHr5tgJDPljhJHgjDiU0XD8Me92W2Q4prFkFqg5dpeTGFaNE7jy/nXG7+LE75L4D8/7VI1MZlGGqHuDQvLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by SN7PR11MB7067.namprd11.prod.outlook.com (2603:10b6:806:29a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 1 Sep
 2023 02:36:23 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6c46:eead:bf23:5d5c]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6c46:eead:bf23:5d5c%4]) with mapi id 15.20.6699.035; Fri, 1 Sep 2023
 02:36:23 +0000
From:   "Zhang, Tina" <tina.zhang@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Michael Shavit <mshavit@google.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/5] iommu: Add mm_get_enqcmd_pasid() helper function
Thread-Topic: [PATCH v2 1/5] iommu: Add mm_get_enqcmd_pasid() helper function
Thread-Index: AQHZ2MKvsgr9FlyiA0iVe3qEL4yO5LADrg+AgAGadfA=
Date:   Fri, 1 Sep 2023 02:36:23 +0000
Message-ID: <MW5PR11MB5881F20173A34D1E5F7BDB6389E4A@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20230827084401.819852-1-tina.zhang@intel.com>
 <20230827084401.819852-2-tina.zhang@intel.com>
 <e16f2963-9748-7461-ca8e-d0b46a34330c@linux.intel.com>
In-Reply-To: <e16f2963-9748-7461-ca8e-d0b46a34330c@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|SN7PR11MB7067:EE_
x-ms-office365-filtering-correlation-id: 09f80b7d-03c7-4055-09eb-08dbaa943bbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5uidP74XEXPDv+cGHlvHhoaCaQ+xcBQvLQgExi2XnlsO17q/FmN5pquFVRQhlMZVK3sgUhKbVVbgkELUkX5t1fSq2wqU7fF7xsAkg9uTbLpWtz88dhGAGjWoRvmbAwm8hFtz2NGLMK3dISHn2KUGG4oEtXn1iZhxpc5Y8vKlifKZWfqwBRJBoZorLu53Ek231JtdE7+PVxSsvkSGSh8fdmcx/3pFhQ92juc43Uo8/FJDhCnMYZwkbgBwwTTw3Pb/yv1JHAHPW5NxpdskdXg3SFxtCbTmAKq4rU1kcQDZlFLbCE4JMBKZt1Q9z1sdJ4e6OtftRR+2T0l2xeWu/nBGaIFNaXiBTBYMpSa/GSImVcXsRywB4PT7mAwY6nABGQREmnO+4iEkmQ3iSl0paHj9Nov+gnw4y1JemBC7vwO2f+SuHyOtXH01PhldiM7SPb6Dq67kWVYQImPS4kiCVv3aIVvFJFl1h+K8pi9UFc6cFdIAL0fGig8Lfal9savmIX04T1SITrLU9FCjYgZZ+zlDHPVSGekgW0fyAb6rNHfQUCJK3qqgpAZECGY+mLJQDzC2IMCtYuNDjn336XpHkJ2rMRj9UbLiCHfYDQl8pL7pextxrF8q3JhXR/sekc5bUZ3X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(1800799009)(186009)(451199024)(71200400001)(9686003)(7696005)(6506007)(53546011)(478600001)(83380400001)(2906002)(4744005)(26005)(110136005)(66446008)(41300700001)(54906003)(316002)(66556008)(66476007)(64756008)(76116006)(52536014)(5660300002)(66946007)(8676002)(4326008)(82960400001)(122000001)(33656002)(55016003)(86362001)(38070700005)(38100700002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmNmL2FaMlUwdGJNYUZLVTRXR2h4R3VwMkRZdVdEbm9JTndhUnhVTmZMZERj?=
 =?utf-8?B?a1ErN3dseEIydHVnMzJrUURKcHNWWENQVVo0cS93T3YxTnZzL0xyQVdkYTZO?=
 =?utf-8?B?ZmJEb1NwZ0hQREpLL1dNMnh2OXU5NGdrU3RtQ0xuOEdEVDRrQ0pDZFNWWUFr?=
 =?utf-8?B?aS9zZ0tmRFk5cEQ2bXNiaEtRYjYydFloTm81cS9QZ1JNWUh1bHJJMmdkSndq?=
 =?utf-8?B?ak9kZUw1ZDg0Sjc5aWtFcEVlaTYzWGNiTC9idHQ0blNlRm1HRGRIUExheHFQ?=
 =?utf-8?B?NkJRR2hmMVlQN3RUaU8wSFpucU5xZVZHL1JyS2F4SWRsbU5FVWlMVGtyTEZj?=
 =?utf-8?B?OEUwYjFZSFh6SSt0M1JQY1lsWFBJTHNIYTRWS1ZZZ292aGlSbmJud3RxL3NU?=
 =?utf-8?B?emxhVHpkaFgyeU5aajVJS3JDa3ZKcGZKcWY2RmYrOUYxM1dDbDhwOHIyUU9X?=
 =?utf-8?B?cVpMSVRuSzdJS2JZRVZpQzdOY25scVhxUGFqSFUwMEYxOEZFOXR2WDBpUXNQ?=
 =?utf-8?B?K1BIWGtHZTNMZDNqNXJPR3JVdnVPWG0zZEN0dTZYWTRoY1hJNittYVpsLzYx?=
 =?utf-8?B?Q0hEVzd1RzVlYlVSeVRNQ0d1SEdqbG9EYmxvWUJVSzErT25pSm1oZDVjS0Z4?=
 =?utf-8?B?eEZXcmJITHArcEUvMG5aYVk5V0tYZTdrUEpxWXhpSk9lMnRoVW4zQ1pCd0hT?=
 =?utf-8?B?R1RzeVIyMWdQa2crVlEwSUJ5MUJieGN3R2tVVFpzRzAxNjNZRUxPekt6UjMr?=
 =?utf-8?B?NWR4Rkk1THV4eGVKRDRBVTh6dUU0ZzBLanNaV04vN0JCVjZ3d0lEbjRHSGVX?=
 =?utf-8?B?REV6aXkvUWduVmtZQllBNStYRGlKOGlMOTRWR0FZRkhCb1kzSjdoTlhKRlZR?=
 =?utf-8?B?V0w2TlpTSFlLbllCR3FNQ0VPOWsvK1YwQUhvVFlEZVltdW9FL2FROXJIOVlX?=
 =?utf-8?B?enJwZWhkRjlEaWI0NkN6ajFWYmdZMmtnZm9XUTJmeWxrTlJ4MXkzQmlGTWpW?=
 =?utf-8?B?bk8zODd2SHBOOE5Uc2Qrd0pjekIvTllkdGlnTk5CdEdUTFpMY25JZzQ4THl3?=
 =?utf-8?B?WnhvWHdaM2tuWSt2OXh0TUhzTnN6MDlvdjhIWlNMcys2cXZKWjRINkFpWWRV?=
 =?utf-8?B?STlxazdNUWRuOGd3NkxvM092b1VGN05DdmFNaVdZT1VLZnJuc01Pb051UUxB?=
 =?utf-8?B?UE5IbE1MRk9sc0pOcDB3eXkybFFENDI2anIzU0ZEeE8vc1JlaU10L201NWVy?=
 =?utf-8?B?U0VIOTZMSHRtMlRvS1FsSTl1c1lyR05mOWVJTER2TXlRb00wZ3ZBemsyQXBG?=
 =?utf-8?B?b3FRVnZydE83ZkRvY2M4bmRHVnFhQlZPRnBESUFnWTJhaFNrZmhRakdDZFF4?=
 =?utf-8?B?TDBvenBXdCtKUHY0eHpQbmpCQjBLR0duQUFBNlRXVUR0M3BRbVNabkgwYlVQ?=
 =?utf-8?B?a1Bqa09aNjZXOEZLaEVUQWRVNk0zb3p2WlhMYTdMbU8vSWo3NnFtallzR3dJ?=
 =?utf-8?B?cFNWNkl2dGpiK3BMYk95aEUzeWVteXRhT2VjU3Jza3hWVzZ1MDc5ZStCblVO?=
 =?utf-8?B?WEdVcWhqWEx3dzBHTFJwZUx2SkFSUGhQYW8yQ05Xd0kzdjZxRHJpSUFWV0Fl?=
 =?utf-8?B?SjByM0ZoVW5DUWJDWHZuazBibmJIOVRIZDQ0aEQ1b1BuYXBSTFNQbDRRZzIv?=
 =?utf-8?B?K2xNakZ1dE9qekROemRLUnROSmhKRkRQUTczNVdtZnZkWFNmN2dDQ0s0WGEx?=
 =?utf-8?B?WGtCL2xIbEl5MldzdEpuOC9TVDIwM2NnNkVlODYwRkRLWU8rR2JEOHJuNUdQ?=
 =?utf-8?B?ajZsR0JzaUVzUjF5ckl2VkExREtlRjNYWkRTckJ6VUd6ZEljbUlsekFRWHJ6?=
 =?utf-8?B?bFo3SHV0ZlZTL21kVU8rRE02NHpJREMrbU1mQnRnaDgrTEdsbTFUaUFGQ25F?=
 =?utf-8?B?Q0Q2dmpwR1hvRzNOUWM1OTlwVnR4S3B4UTZaTGdpSlZxeGdmc1pGNnRQUmJD?=
 =?utf-8?B?Vm5Qb3A5ay8vQlpyQmpmcEs5cFJyVmVETlVqaDBNbVZ6UkE1UnRwVW1HbXh6?=
 =?utf-8?B?TjFESEcyZytVUGVnYUszcW52QS9IWTdhV3lXaVl3clMxMklZeS9LZHZEVllP?=
 =?utf-8?Q?zkHsmJek1T9zh4qOSa5j77Ic2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f80b7d-03c7-4055-09eb-08dbaa943bbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 02:36:23.6962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vNoqssJDPTyzFOM2Tida5EXdQtH6Io/xApKbkbCitppjnceKdHRDdFZ0eb1rQjzlKb+vG8MdsEIOIVdaMBwftQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7067
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmFvbHUsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFvbHUg
THUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAz
MSwgMjAyMyAxMDowNyBBTQ0KPiBUbzogWmhhbmcsIFRpbmEgPHRpbmEuemhhbmdAaW50ZWwuY29t
PjsgSmFzb24gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+Ow0KPiBUaWFuLCBLZXZpbiA8a2V2aW4u
dGlhbkBpbnRlbC5jb20+OyBNaWNoYWVsIFNoYXZpdCA8bXNoYXZpdEBnb29nbGUuY29tPg0KPiBD
YzogYmFvbHUubHVAbGludXguaW50ZWwuY29tOyBpb21tdUBsaXN0cy5saW51eC5kZXY7IGxpbnV4
LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS81
XSBpb21tdTogQWRkIG1tX2dldF9lbnFjbWRfcGFzaWQoKSBoZWxwZXINCj4gZnVuY3Rpb24NCj4g
DQo+IE9uIDIwMjMvOC8yNyAxNjo0MywgVGluYSBaaGFuZyB3cm90ZToNCj4gPiBtbV9nZXRfZW5x
Y21kX3Bhc2lkKCkgaXMgZm9yIGdldHRpbmcgZW5xY21kIHBhc2lkIHZhbHVlLg0KPiA+DQo+ID4g
VGhlIG1vdGl2YXRpb24gaXMgdG8gcmVwbGFjZSBtbS0+cGFzaWQgd2l0aCBhbiBpb21tdSBwcml2
YXRlIGRhdGENCj4gPiBzdHJ1Y3R1cmUgdGhhdCBpcyBpbnRyb2R1Y2VkIGluIGEgbGF0ZXIgcGF0
Y2guDQo+ID4NCj4gPiB2MjogY2hhbmdlIG1tX2dldF9wYXNpZCgpIHRvIG1tX2dldF9lbnFjbWRf
cGFzaWQoKQ0KPiANCj4gVGhlIGNoYW5nZSBsb2cgc2hvdWxkIGJlIG1vdmVkIHVuZGVyIHRoZSB0
ZWFyIGxpbmUuDQpSaWdodC4gVGhhbmtzLg0KDQpSZWdhcmRzLA0KLVRpbmENCj4gDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBUaW5hIFpoYW5nPHRpbmEuemhhbmdAaW50ZWwuY29tPg0KPiA+IC0t
LQ0KPiA+ICAgYXJjaC94ODYva2VybmVsL3RyYXBzLmMgfCAyICstDQo+ID4gICBpbmNsdWRlL2xp
bnV4L2lvbW11LmggICB8IDggKysrKysrKysNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBSZXZpZXdlZC1ieTogTHUgQmFvbHUgPGJh
b2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gYmFvbHUNCg==

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA3B7EB69A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 19:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbjKNSkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 13:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbjKNSkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 13:40:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76E411D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 10:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699987234; x=1731523234;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Xunx4j+Y25G8+RofwKFWfVxIH7OK1c2sykwA7bQ+W0I=;
  b=Le1nKdy9C3Nev+2mNSU5pGcoo5S5KMKg12lRvEz88bVSonqI0cjxOXC0
   aIveA1M/ChfayT3Q8OLke7M3E5Nj7XUqZGY5UJyi+9XXLKu1lLMK6hkIo
   PKg2IR78eeWuojYEHNlzate5Cc4/zyTwgVM5ETQbjouJ/as8jrIuZ/91T
   CQFCnBlcdmZTzdgq9lpSgbIcsJvSLha8KXooKeqHJRnznRRiiBQH7ZVOG
   587TBfRrc2sDQqWLaTbMxaWUfyemIdhWvkHxH8aRylh10g7jMmIeWPIbD
   Yn//e9s49Pd8V7q6pmyTMpWAUQ0WTqfBa6qAqrPwBv/+L/IlaeUDH0xzG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="476942465"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="476942465"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 10:40:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="714646602"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="714646602"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2023 10:40:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 10:40:33 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 14 Nov 2023 10:40:33 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 14 Nov 2023 10:40:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UC2SunlZXwz3W6E4FmCZaZ/QXhxi5Xn66QE2IXd0bQvW27e4RxzJL2YG83ceLs1FGoqcZTlsH6ZHEK+/IXXkQtzLLwfBN4L8zG7l3K+CwGZfzKrEpjTwV0QtXDkqVD4VW0Hm5Hzx49TO0g09vUCLGvEz2woq8FJXvIyjWDd4ywNVjeWdKen9JDGqptdbREroVqXpJmwk4jR1EEn2uDcDcu+Rlcw0NoECPLiuzN8oJ2cJU8tugo7ddUZyvsYeBFeEZfUkFfijQqNT29AZfr895Az45CMJSN89T31oKbt1GkdWgMEpUp9O6/ZOuz0nKImY3JYqDLSgBabLFZBjvlinvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xunx4j+Y25G8+RofwKFWfVxIH7OK1c2sykwA7bQ+W0I=;
 b=OB1YNCwmzh/XvulDDusvOhZxuBNVfqIHly6tN0obxI7Pk42ZEsp3yA4rRp/8vKzw18a8lRXqDtnmD/PCs8HhrDmmERwgE1NUkxR6oZNHpuuBWdn/tPpgEqjE68e1EdDuU5AWBgXKrYlJPPUT1R1KvFuuQU1O249Qd2YhqsnnadvQKTpKfMvwcFEusVZgaLyZ+5v98NKr4vhjIzLPI/8LKl9/1dID4RORJ3EeqKiarr7DbnUDaTy9PLrkpmEQFb2efAPf2KKE5UGwosiESEGxEJ6Anc53L0Yef7vLFkg1whhPJLJm6WpDK/SU9nHf9LZN8jPBPOsFTzZvvDdFpLZDaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4093.namprd11.prod.outlook.com (2603:10b6:208:13f::21)
 by MN2PR11MB4661.namprd11.prod.outlook.com (2603:10b6:208:26b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 18:40:26 +0000
Received: from MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::bd0:9132:5b54:a118]) by MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::bd0:9132:5b54:a118%6]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 18:40:26 +0000
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>,
        "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>
Subject: RE: [char-misc-next 3/4] mei: pxp: re-enable client on errors
Thread-Topic: [char-misc-next 3/4] mei: pxp: re-enable client on errors
Thread-Index: AQHaFwMGG3+BNYQuU0umvbAfNF+KArB58UYAgAAy3/A=
Date:   Tue, 14 Nov 2023 18:40:26 +0000
Message-ID: <MN2PR11MB4093E7F5490A51DED7672145E5B2A@MN2PR11MB4093.namprd11.prod.outlook.com>
References: <20231011110157.247552-1-tomas.winkler@intel.com>
         <20231011110157.247552-4-tomas.winkler@intel.com>
         <ZVN9e3BczixJy_1H@intel.com>
 <ade96d9edd8bce1bc63dba4e2f1a92517180d774.camel@intel.com>
In-Reply-To: <ade96d9edd8bce1bc63dba4e2f1a92517180d774.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4093:EE_|MN2PR11MB4661:EE_
x-ms-office365-filtering-correlation-id: f9d165bc-792e-4d7a-435c-08dbe5412b13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oYz6LS7ZwZVYA3J8HxGatY2rNlF16H0oHByQGGiJdxA7FamADrlw2kXElGKDyyBFTgZtIITbylkdkr65ZLTWNNDvtuRM9xcaX8oZGmzQy8vWfGeq6OVIM2m4kB9DMn6qLaLYdfGtLSXjIOIw34Qt/02CzAK4UDAVIqX44WyRMDF7x2HBOaDVsWLRXF/hRHKZHij1lNNLkWSlERynb6E+ps2h3cDwm+r4C1751ymTKQ1r1OXUEgC1Br70vglN885LYAOPknA56sAMOI7EsEL/3cbFYIBGW7OPMh89BHQsCVqm27FMR+oQFAPTa+QEdK8uFkITNzuNjnEaEUl+Y+vz6572jTlMQ5rTTdI4bZX76LwL4qB6uMRWNrSU+VHeQtMuny72A804SaV4iWpSjWkLvRLHuFk7GfHcH9wr6OZvtKrwBcY1gjDBRWUv8EOLw6MWzqw+2DICNPqqPO14kJN+/11WhjvV+vOxPxCtHYoK7xmgf98sOURwLO5y3rJ8bfvotNuOTWOgQ2qcgynGwfqixyJHjlfCKvkp7YOrfKmwBYGD/Xm3uqddALJHwfreY0+NO9/Pgk52t7zqoe9/qfeyCFkl6sFFmSd22F3lav3tUdA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4093.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(38070700009)(83380400001)(110136005)(82960400001)(122000001)(26005)(7696005)(6506007)(478600001)(53546011)(71200400001)(66574015)(966005)(9686003)(86362001)(52536014)(5660300002)(55016003)(33656002)(41300700001)(4001150100001)(2906002)(38100700002)(4326008)(8676002)(8936002)(64756008)(316002)(66476007)(54906003)(66446008)(76116006)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFpkaHR0YkE1NEs1WmlZTGwycllHaXM3dDJUek1jNDBlRjR3U0pBNWI4RWI4?=
 =?utf-8?B?VmFwcXRhOHlvNmdSMzRNMFBHZGpSamJzVGpCV2Z4a2tMMVpPbDVHeDRDSTRu?=
 =?utf-8?B?bzh5Mmt3TnIzVENjeFBsc2RjSGhWWldPY3hxcGJLQXNHRkY0UXFvYTdpVzNW?=
 =?utf-8?B?THA2eHhuZ3JNRnl5M0plMzFXVDVCUllXdEtXNG5tZ1plciswRTZUMTVTYStx?=
 =?utf-8?B?LzRYay95cG9qM0hmRTM1Snk0THY3clgxVE5KMnVhVUw4MHV1MDUxaUp3R2FH?=
 =?utf-8?B?Z0hJYXFtMWxuUzFkVnNNVllZWUhuRGxqeDJDR2M4dU9ja0dxck1HR0ZkeW5n?=
 =?utf-8?B?SlQvUVRUUjl3WWo2TllSV1VaenJGWDdvcEFxYTdaeE1HVy9UTEgxYnBacEJQ?=
 =?utf-8?B?NFFEZytBM1c5RnNFRkk5NWVSMWh6cStrZEkrSDZrc3Q3akRKaDBOZ3dlR2tZ?=
 =?utf-8?B?NVdzSEJxdTlFTzM4VjJiUWJDdTdKSmtRSEd3bGc4VXhxaDBYSlJRd2xzVGpa?=
 =?utf-8?B?bmNaODk2WkVRTkVjdXNVQisxT25aN2RSck1vNUxra3RSUmg0a1lsOHlLblFB?=
 =?utf-8?B?c2FkU3ZaNkc4YW0wa1RsT3U2MWlZeHo3ZEVtUWI3QXBEeFpCUDN4WHVJRHA1?=
 =?utf-8?B?QWMwUnpEYlE5Tjc1N3AxaEE5OFVPNjNHUnZhdDBHNjVoVFZZbW52TEJGWXFD?=
 =?utf-8?B?NlRVejJQZDRlUDBtUTV0bHpiNHVKUUZoZjJOMG9RbHNUQ3pKdC9lQjNoSkkr?=
 =?utf-8?B?RytOZGZNTWlYeGJwcFViUFZOOExNaFVhYlBGcVZYK0VQdlVwMEptdjc3MjJm?=
 =?utf-8?B?Lzhnc0hMaFFVS2ZBcHZxV1BLSHZGMXRkam5BNFE5ZTJUbm1xckpqWTNhN2Jh?=
 =?utf-8?B?QmMxVUN4UzQ4anUwVFNpZ05nekdOMkpxTEFDc0F6R05nUEVzZ3lJa3hqQTR0?=
 =?utf-8?B?UmhYSmxyUTVCYnZBcUZCS0JNVUdxdUJKblc0WlNlWUNySEUvY21ZbHo5OUxE?=
 =?utf-8?B?b0htR3dIYkJBNWpYR2wwckorNXBIOG9QTFVTem5hb1V5YVgybEtEbFBiQUk4?=
 =?utf-8?B?S040OE5FUVp6MXNMSHUvQW9ia1JZOUM2NG5wd3FCeTF0YTFmbklLeVNEbTBi?=
 =?utf-8?B?NmEvKzE3cjdwSHJEOW4rRnZodWhoU3ZwZnViWnZmRDZTOUpnbjNwVENWMHZY?=
 =?utf-8?B?RkVoUWQyajdwY080NXJnNjZoazdSaXpGc2hhdEQyVGxhU2dpbmg3bkFQSmps?=
 =?utf-8?B?TW5sQzRPdUpSRHJKUWtJa2VvRWZmdzB4dUtydUpJbUFULzNsSlBUeVlMNVhX?=
 =?utf-8?B?MU8xU2t4cTBrcDlDR3EzVzlKYzgwVk1TR21IQWZQNEtpWjRFK0JQVXlIYmpo?=
 =?utf-8?B?OG5BaEI4NktRQlNYazJ6dVVjbXFPbzRxUktqVURUdFcvVU4rY2tDWGg4L0x2?=
 =?utf-8?B?RjdqeVk4UUxTN3NaNFJKVDl5bk90L3BGVU9kdzFmOGFiZ3pZTHgwaThFaVJL?=
 =?utf-8?B?S2g5aGN5aDM0RjRtODFKeUFJbVl4bDN4TzBLSTg4NkZJbFkzYnAyUjRZNEZC?=
 =?utf-8?B?NElvMmkrd1VWREM4NDBsVlc5THY2WmRuMGk4QzZpeUVWYkJETmFkOFd0MDB5?=
 =?utf-8?B?L1lZSTJzNTg1ZjNxZGVtRkQybWt0eWdKdVN4dTc1WGZUcXFuK0FYTVpnOENX?=
 =?utf-8?B?b2x6Q3MrUmdoL0pLQ2ZmUXlNNHp6akJGY0x5UnErSEMySXJLQlF1OE9Vazlz?=
 =?utf-8?B?UTJ0dW8wZDlreWZUZFRGRmdRNzMxNnlyYzRHNmVtekJ5Mkt5cHFxUW9XUkRu?=
 =?utf-8?B?UWpYcGlXOTZiNTZYOFh0NUswbHRKMU5veUZlMzVxMUdRNDgyckpqZmhzN3pQ?=
 =?utf-8?B?N2MzVEdBS0lpaVZlenBEdnZhQlRlWmRweGFPc0xjQythcmpNeTNhN2VWcUtS?=
 =?utf-8?B?VVhGb04yU096eWdrWVFLZ2lRcE1pOGl0VHU3ZEl0U01LdWhHejRCeEhneUps?=
 =?utf-8?B?U3ZtVk5qTVMxWGthSkJwdkMxVzVjcUpIc01WSXZmZHdGYmdKR3RKOTNseGoy?=
 =?utf-8?B?TXRwRHFFQlNUQmhwZnQrQ2F2ck82cnE1VE02aGo1Tk9VcDdOTzhEZVBxdzFN?=
 =?utf-8?Q?3rMax4ewZIIAYpp14+IDH7T45?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4093.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d165bc-792e-4d7a-435c-08dbe5412b13
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 18:40:26.1245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ULUE5PkjxYgieG6OUBICcBsN27ODzOLgFQhqrofceEVwprQT6GOxoOrOiYRf8GBOjnMVZZ6HO04IaBsUVuDOBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4661
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGVyZXMgQWxleGlzLCBB
bGFuIFByZXZpbiA8YWxhbi5wcmV2aW4udGVyZXMuYWxleGlzQGludGVsLmNvbT4NCj4gU2VudDog
VHVlc2RheSwgTm92ZW1iZXIgMTQsIDIwMjMgNTozMiBQTQ0KPiBUbzogdmlsbGUuc3lyamFsYUBs
aW51eC5pbnRlbC5jb207IFdpbmtsZXIsIFRvbWFzIDx0b21hcy53aW5rbGVyQGludGVsLmNvbT4N
Cj4gQ2M6IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBVc3lza2luLCBBbGV4YW5kZXINCj4g
PGFsZXhhbmRlci51c3lza2luQGludGVsLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IGludGVsLQ0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBMdWJhcnQsIFZpdGFseSA8
dml0YWx5Lmx1YmFydEBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbY2hhci1taXNjLW5leHQg
My80XSBtZWk6IHB4cDogcmUtZW5hYmxlIGNsaWVudCBvbiBlcnJvcnMNCj4gDQo+IE9uIFR1ZSwg
MjAyMy0xMS0xNCBhdCAxNjowMCArMDIwMCwgVmlsbGUgU3lyasOkbMOkIHdyb3RlOg0KPiA+IE9u
IFdlZCwgT2N0IDExLCAyMDIzIGF0IDAyOjAxOjU2UE0gKzAzMDAsIFRvbWFzIFdpbmtsZXIgd3Jv
dGU6DQo+ID4gPiBGcm9tOiBBbGV4YW5kZXIgVXN5c2tpbiA8YWxleGFuZGVyLnVzeXNraW5AaW50
ZWwuY29tPg0KPiA+ID4NCj4gPiA+IERpc2FibGUgYW5kIGVuYWJsZSBtZWktcHhwIGNsaWVudCBv
biBlcnJvcnMgdG8gY2xlYW4gdGhlIGludGVybmFsIHN0YXRlLg0KPiA+DQo+ID4gVGhpcyBicm9r
ZSBpOTE1IG9uIG15IEFsZGVybGFrZS1QIGxhcHRvcC4NCg0KVGhpcyBmaXggd2FzIGFscmVhZHkg
cG9zdGVkLCBqdXN0IG1pc3NlZCB0aGUgbWVyZ2luZyB3aW5kb3cNCmh0dHBzOi8vbGttbC5vcmcv
bGttbC8yMDIzLzEwLzMxLzYzNg0KDQpHcmVnIGNhbiB5b3UgcGxlYXNlIHRha2UgdGhpcyBmaXgg
aW50byB2Ni43LXJjMiBydW4sIG9yIEkgY2FuIHJlcG9zdCBpdCB3aXRoIHRoZSBjb3JyZWN0IHN1
YmplY3QuDQpUaGFua3MNClRvbWFzDQoNCg0KPiA+DQo+IA0KPiANCj4gSGkgQWxleCwgaSBqdXN0
IHJlbG9va2VkIGF0IHRoZSBzZXJpZXMgdGhhdCBnb3QgbWVyZ2VkLCBhbmQgaSBub3RpY2VkIHRo
YXQgaW4gcGF0Y2gNCj4gIzMgb2YgdGhlIHNlcmllcywgeW91IGhhZCBjaGFuZ2VkIG1laV9weHBf
c2VuZF9tZXNzYWdlIHRvIHJldHVybiBieXRlcyBzZW50DQo+IGluc3RlYWQgb2YgemVybyBvbiBz
dWNjZXNzLiBJSVJDLCB3ZSBoYWQgYWdyZWVkIHRvIG5vdCBlZmZlY3QgdGhlIGJlaGF2aW9yIG9m
DQo+IHRoaXMgY29tcG9uZW50IGludGVyZmFjZSAob3RoZXIgdGhhbiBhZGRpbmcgdGhlIHRpbWVv
dXQpIC0gdGhpcyB3YXMgdGhlDQo+IGludGVudGlvbiBvZiBQYXRjaCAjNCB0aGF0IGkgd2FzIHB1
c2hpbmcgZm9yIGluIG9yZGVyIHRvIHNwZWMgdGhlIGludGVyZmFjZQ0KPiAod2hpY2ggY29udGlu
dWVzIHRvIHNheSB6ZXJvIG9uIHN1Y2Nlc3MpLiBXZSBzaG91bGQgZml4IHRoaXMgdG8gc3RheSB3
aXRoIHRoZQ0KPiBvcmlnaW5hbCBiZWhhdmlvciAtIHdoZXJlIG1laS1weHAgc2hvdWxkIE5PVCBz
ZW5kIHBhcnRpYWwgcGFja2V0cyBhbmQgd2lsbA0KPiBvbmx5IHJldHVybiB6ZXJvIGluIHN1Y2Nl
c3MgY2FzZSB3aGVyZSBzdWNjZXNzIGlzIHNlbmRpbmcgb2YgdGhlIGNvbXBsZXRlDQo+IHBhY2tl
dHMgLSBzbyB3ZSBkb24ndCBuZWVkIHRvIGdldCBiYWNrIHRoZSAiYnl0ZXMgc2VudCINCj4gZnJv
bSBtZWlfcHhwX3NlbmRfbWVzc2FnZS4gU28gaSB0aGluayB0aGlzIG1pZ2h0IGJlIGNhdXNpbmcg
dGhlIHByb2JsZW0uDQo+IA0KPiANCj4gU2lkZSBub3RlICB0byBWaWxsZTosIGFyZSB5b3UgZW5h
YmxpbmcgUFhQIGtlcm5lbCBjb25maWcgYnkgZGVmYXVsdCBpbiBhbGwgTUVTQQ0KPiBjb250ZXh0
cz8gSSByZWNhbGwgdGhhdCBNRVNBIGZvbGtzIHdlcmUgcnVubmluZyBzb21lIENJIHRlc3Rpbmcg
d2l0aCBlbmFibGUNCj4gcHhwIGNvbnRleHRzLCBidXQgZGlkbid0IHJlYWxpemUgdGhpcyBpcyBi
ZWluZyBlbmFibGVkIGJ5IGRlZmF1bHQgaW4gYWxsIGNvbnRleHRzLg0KPiBQbGVhc2UgYmUgYXdh
cmUgdGhhdCBlbmFibGluZyBweHAtY29udGV4dHMgd291bGQgdGVtcG9yYXJpbHkgZGlzYWJsZWQN
Cj4gcnVudGltZS1wbSBkdXJpbmcgdGhhdCBjb250ZXh0cyBsaWZldGltZS4NCj4gQWxzbyBweHAg
Y29udGV4dHMgd2lsbCBiZSBmb3JjZWQgdG8gYmUgaXJyZWNvdmVyYWJsZSBpZiBpdCBldmVyIGhh
bmdzLg0KPiBUaGUgZm9ybWVyIGlzIGEgaGFyZHdhcmUgYXJjaGl0ZWN0dXJlIHJlcXVpcmVtZW50
IGJ1dCBkb2Vzbid0IGRvIGFueXRoaW5nIGlmDQo+IHlvdSdyZSBlbmFibGluZyBkaXNwbGF5ICh3
aGljaCBJIGJlbGVpdmUgYWxzbyBibG9ja3MgaW4gQURMKS4gVGhlIGxhdHRlciB3YXMgYQ0KPiBy
ZXF1aXJlbWVudCB0byBjb21wbHkgd2l0aCBWdWxrYW4uDQo+IA0KPiAuLi5hbGFuDQo+IA0KDQo=

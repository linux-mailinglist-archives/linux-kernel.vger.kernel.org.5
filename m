Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5612A75CBBA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjGUPac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjGUPaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:30:30 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DE42D4C;
        Fri, 21 Jul 2023 08:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689953429; x=1721489429;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MtMEMyG6Thc/ee6lfERtyVQ/Sjd7wut0OlzEHes+e4I=;
  b=QwM/lbr0vsxjh4sHhokd4D4qb/ZYIcoxLU+/hzxgEYUpjj/dOiORO5tJ
   ejXYgc0CaQBMHjWUXgTdc/dxOM+uYVgpEBhlGHVtH+jM+Pn/2L4NIAmXd
   UqX/0L0RRmbO0mgzzOo9xVuK6tyymXFWlwr7VU+yBZYjzps/TtX7OoGIS
   WmKvRzl9WXKESsmFAXKBMKjJ+F7+2JJ3cTkdWJ0rPSm+uh6g3FgXsgeEl
   0HrZV3IfQpvQsk2jHqEf/eMIMTakR5IqKp43W/Za4lsbEcCJXrZW0Pa+g
   /CVJvEsZ8FZEJDmukUpkzmCWZ1ta0KoJ80UCd8OeQs6rIlXKpR+m1ZlgF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="346649470"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="346649470"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 08:30:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="724904686"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="724904686"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 21 Jul 2023 08:30:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 08:30:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 08:30:25 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 08:30:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8lCh4dKbyWBvO8yrOnsLMGP1ekEH5DMseH01tXk8j4DYRgvkvZqNPMp2T2WcSX5ULobaqKlDShLmCKIOfzl+eLTs7qyf2JiDUr8cmDL1HpbgcwMILooW3Pq05/hxOG+L0ZQ7nfVk4ArcTqh3N2pqCTu9ZZrIdB/5x84iwW5CmLE0fIU3Lb0+iYcyQb/WJkfxFe+2K9E37UKxwpp5x3sAcAoIpYOtn0tmApNyN3YMy/+Je+fgg20w0vwtS4MP5R/RCoKaeam9KWu4r8jWz89oeXINwPjBSA9psv0lcW6krA339t+bppMHAmOo6EbZu3aqPkXeAeBKoIe9Iw1g3JWEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtMEMyG6Thc/ee6lfERtyVQ/Sjd7wut0OlzEHes+e4I=;
 b=gW9o0ROjPPGUfSqteymCCf4Amp5VelIa9NvgGtl4BDuNog/TROkSVKEWatdqacyuQDQRyRwLy+UPcS0m0IrXy0vSebvA6Lwl91gGlUPN+LZwCvVaaxI6CprjnlgyQA7W2p79QAMo00G0eFUnBEfta0A6zumnRaXYrrvlxWGqesYPEi04atAfzvGuGrVvXJ0BFWUEgiDXeXLYeSzLMDNDnjBrDQYtJFd4ARqnKvj+fVpgSbJWTQJtn8rrLUqN/jqWvR1daHPIrrO6Blq1aSPbCk29H5AVQjm6GUNKKByoFr98biYcX/AOqUzkqCSxODowuqodlPYsS9Fa2btXR9hINQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 CH0PR11MB8167.namprd11.prod.outlook.com (2603:10b6:610:192::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.24; Fri, 21 Jul 2023 15:30:20 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531%3]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 15:30:20 +0000
From:   "Ng, Boon Khai" <boon.khai.ng@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Boon@ecsmtp.png.intel.com" <Boon@ecsmtp.png.intel.com>,
        "Khai@ecsmtp.png.intel.com" <Khai@ecsmtp.png.intel.com>,
        "\"Ng <boon.khai.ng\"@intel.com" <"Ng <boon.khai.ng"@intel.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Tham, Mun Yew" <mun.yew.tham@intel.com>,
        "Swee, Leong Ching" <leong.ching.swee@intel.com>,
        "G Thomas, Rohan" <rohan.g.thomas@intel.com>,
        Shevchenko Andriy <andriy.shevchenko@linux.intel.com>
Subject: RE: [Enable Designware XGMAC VLAN Stripping Feature 2/2] net: stmmac:
 dwxgmac2: Add support for HW-accelerated VLAN Stripping
Thread-Topic: [Enable Designware XGMAC VLAN Stripping Feature 2/2] net:
 stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Thread-Index: AQHZu5xgYrDsoI6/ykSzsldNoVNgSq/EADCAgABYqiA=
Date:   Fri, 21 Jul 2023 15:30:20 +0000
Message-ID: <DM8PR11MB5751E5388AEFCFB80BCB483FC13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20230721062617.9810-1-boon.khai.ng@intel.com>
 <20230721062617.9810-3-boon.khai.ng@intel.com>
 <cfba8fa4-47e5-7553-f40e-9e34b25d1405@kernel.org>
In-Reply-To: <cfba8fa4-47e5-7553-f40e-9e34b25d1405@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|CH0PR11MB8167:EE_
x-ms-office365-filtering-correlation-id: e8e5786d-c9bf-4174-36e8-08db89ff64df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3dnjblAbSA3r/9GZXAm7fr/VVQ3CvdKWDJxSuKG21P+5F5xnwDhfLblzXk7dHmPmBUZafXMG2DJUVTYZv/VLbez6V3tY8spzSkXVtN2HsyEC7R7b3u/RyJDwvI8my+HxLS28ww/edaUAnXBfoptVui/IUExdBVQjHQg3R4yccBQUIO0hzCb+Xsby1QhZrnoR71qU1bk0ez7DJRgzIdyW0lAfV/pMk/6ddnQBywzdBQoxCjZH7ou8WJcazW+yM8OzdizmyoA+HB7SE/ICMidzhvZ1utSTEvVcAeo4qQ8PCX9q/bCp0Qz0hX64RlC3PeyMamp9poNBL1leZuxth6bP4idHFw5vvtKRad41n8VscsBaU3YanFcpJL5PD1RqEL2mOgZ8iF61hSQX1IG6WCjDufk2dYz61lUSoxO7wWH1CZLk4XNXQqWkKWH9w8cil506db19DIUbGnEaU/MOPpWuA+Y7ixZfDXEM/UjwDPty/dW7EXHjm7iR64YKRaKhQ++p6L04jhdbYlCIVCfI/RxLq7aZl04GGM6qqrgSmWu2gnTRNruhW56QCH/lEX+qBbRnVhi5fA6ZxOGLpZUhIlyzB97UXfW6LpoAspnpi6wOrM9ccVUpeLLmbl8j5cYVScncVN1AgZsFKkFOdP0if3Wv9udc2N42IZGfoTlneXD/yjc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(346002)(366004)(39860400002)(451199021)(55016003)(26005)(186003)(6506007)(53546011)(83380400001)(4326008)(64756008)(5660300002)(52536014)(71200400001)(8676002)(8936002)(66946007)(316002)(66476007)(7416002)(66446008)(54906003)(66556008)(76116006)(41300700001)(110136005)(9686003)(2906002)(478600001)(7696005)(122000001)(921005)(33656002)(82960400001)(38070700005)(86362001)(38100700002)(168613001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZytsdGo3amd5WTlTblNrUThMS0VVaUpDRGNCUUxGV3AxcGJLQm1MNWVXVE9U?=
 =?utf-8?B?VTM0MUVVb2VaSUpDTEZWUm5nb1JHUFFvZXY0R0FkTHFKNWh4OUlhVW9JN0NU?=
 =?utf-8?B?MHhyVGFzbzR6c3FtMjY2NkswbHNJblRNT2YyUVBlTjVNaTJVR3NnUU9JZlp6?=
 =?utf-8?B?WVQ5RDY1N2ZINlZ2MndVNU9YR3VMNjUyM05FaFBWWTNPdG5SWUtLSHRCdGtq?=
 =?utf-8?B?bDNUM1YxRmtDYmRna00ra2dKeVdpRXBlSWRqczdMRVRYY0NRczhUa2RETWNU?=
 =?utf-8?B?UXhHUWFnKzhBa05ZV01JQ2hoUVNiUXZCeXZDN080N3JEYmhIK2t4Q2hmcXVm?=
 =?utf-8?B?TXZUNVlsYWJmcXczM0pmZjF4NndKYmRiODMrb3RpNFZwZU9NUy9odkVlcXpm?=
 =?utf-8?B?UUxCQjNjRUh3R2MreGdaVGh1M2NycGJHc0UwaXRQUXEvdC9UQkdabXhUYkdV?=
 =?utf-8?B?R2NRQjZVWVI3Z0l6YXV2Yit6c3laMnd6TEF2RlJuWFQ5MlQrc3N1R2swYUNk?=
 =?utf-8?B?SWFJeFh2eE80Ris1OHpkSDFHZ1pIZEVVbnZuSHp4T24zaTN6dW1KUXFFRy9O?=
 =?utf-8?B?aWtwQzVJZnRaOHZsdkRmZ21yRXord1FXa015ckYrU3EvMVBYQncxbVFVSEVL?=
 =?utf-8?B?dVk3SlBrcmJ6Y2taQitZeUFmQWxyR0JKY0lXajRJaERjVkRqTGNXbVE1NStp?=
 =?utf-8?B?OHc4ZU00YjlnSi9OdlRaaHBxbnJjVFBrbWdNbHVaUWNlM3ZxdjF1SE5rb0lG?=
 =?utf-8?B?aFl6djhnZlFtajhPSHpMdzZWOUR5eFRrUVVjV1dVcElMUTlpVXJGK2EvVno3?=
 =?utf-8?B?dnlXVElUcWdoNFZvbHN4V3MzNURsZWNkTzF0MloyelVVbGJ5SHdaa0pSTEMv?=
 =?utf-8?B?aWxPZ3hCcEdMRVhMMjBMVEZ1S1lUaFppL0RhaFV2Ky91ek1YQVFWZk5MOFlB?=
 =?utf-8?B?a3NKbjRPYTZjYytudHBNaEZxNTdKQjBZQ1R2ODl3TmpGbDh5TnZZZTYxSWxV?=
 =?utf-8?B?TDFRNG5FY3B5MDRNb3FQSWF1clZNeHlKcU9oaVNhQlQwdjlGcUdZMmJ5WkFt?=
 =?utf-8?B?VmQwWC9DTTBOQS8veHdyQTFKV2FYeTg1V1NwRDVXcDhnMzB1RzJzREpZRUdL?=
 =?utf-8?B?TEF4ZDd2MXVxaGsxc0hyd2VEelE2enFnZnRyOWhnaU9oTythRy8xWURheXZM?=
 =?utf-8?B?VnlMd3U5TjhOL2JiRHB5aEM5VXBDSkZsNFhuSUtxQS9kQmMvcHBOMHhIQWxM?=
 =?utf-8?B?V1NJUXJTTEFxT3VGenFhbWY0eHgwN1ZGRFYwVUlmaU5qaE1tVThhcDF6MDds?=
 =?utf-8?B?aXF4RWU3STVZaE4vaHk0bzZDbVkwNUowamE0SHdRMnhuWGdnQjd2UTBjZ08z?=
 =?utf-8?B?R2V0cGVkUHM5SFBrbnNyMFRSaE1XUk5rOFQyK2NTVjRHOGNsblo4ZFVtZ0N5?=
 =?utf-8?B?USt0RTBaVlpyQ2w5VFNLdk9yb2RmenIzV3piUURuMWRqZlpWNDQzeUk5VXpB?=
 =?utf-8?B?a3dNUmJsMEVLL0hJeDlpRnQrNGFjZ25XRjJla0Znb2Y4aTZ2b21oWXJMRXZy?=
 =?utf-8?B?RERvNDJJY2UyN1JTSWJsYkNjNTMvMGlRTDBDWXo2QXJaOUtnS1h0bEhNWG9L?=
 =?utf-8?B?RGl5NjYwa1pWaXJOOFUzQTdKNGN5b0F2L09OUXgzakJOeGc1dXI4TzN0YURh?=
 =?utf-8?B?aXhJc2orcE8ySk5HOUtmQm1Wek5jUDNZVy85akF3SHB4d2VUeXpXZis2a1Vk?=
 =?utf-8?B?MzY3Z3FHRWtMaG9LMWlyaGU1TmxzS3I5QzR4TVBlRXlLVEJKTkFCUVVhNmo5?=
 =?utf-8?B?MWlZNjBTT3AvVVdGeEV3WituOHN2cGRTOUFURzQ3dTBScHYzcVFYUW82MXN5?=
 =?utf-8?B?b3lPQWtwY1hyNzI5d3ZkeXBEU2xFbGRBTFlseE96K2UrcmNxRHBhVzExc0tV?=
 =?utf-8?B?dnc2TW9vVFYxZldicmE2Qi9CdnhsY2VxOE40K2ZuWjJmNVFsb2lYOWlrMVQv?=
 =?utf-8?B?Q2dsMFVNS3RvdnE4T3gwWUpUaGhYRVBRWGhFNmY2aDY1ZWU1TDR3R2s3cEM1?=
 =?utf-8?B?Ri9SWVcwWW5CeE1KSDZLZjZNQzdEdDFhUjd5MG5yUTdXdEkrekxGZDFvVDRn?=
 =?utf-8?Q?euxXNfbHYgqPOwTQEn2SiJDhB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e5786d-c9bf-4174-36e8-08db89ff64df
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 15:30:20.4583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N/SPA0uKGK8sDaGFdpLyxisDj8gfzJoen5xmyntC5gQGjv/E2N4YHnxUkLD2IS3a6cVWG6flHEyVpQKq8tWuuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8167
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgSnVseSAyMSwgMjAyMyA2OjExIFBN
DQo+IFRvOiBCb29uQGVjc210cC5wbmcuaW50ZWwuY29tOyBLaGFpQGVjc210cC5wbmcuaW50ZWwu
Y29tOyAiTmcNCj4gPGJvb24ua2hhaS5uZyJAaW50ZWwuY29tOyBHaXVzZXBwZSBDYXZhbGxhcm8g
PHBlcHBlLmNhdmFsbGFyb0BzdC5jb20+Ow0KPiBBbGV4YW5kcmUgVG9yZ3VlIDxhbGV4YW5kcmUu
dG9yZ3VlQGZvc3Muc3QuY29tPjsgSm9zZSBBYnJldQ0KPiA8am9hYnJldUBzeW5vcHN5cy5jb20+
OyBEYXZpZCBTIC4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYw0KPiBEdW1hemV0
IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47
DQo+IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IE1heGltZSBDb3F1ZWxpbg0KPiA8
bWNvcXVlbGluLnN0bTMyQGdtYWlsLmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LXN0bTMyQHN0LQ0KPiBtZC1tYWlsbWFuLnN0b3JtcmVwbHkuY29tOyBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IENjOiBOZywgQm9vbiBLaGFpIDxib29uLmtoYWkubmdAaW50ZWwuY29tPjsgU2hldmNoZW5rbywg
QW5kcml5DQo+IDxhbmRyaXkuc2hldmNoZW5rb0BpbnRlbC5jb20+OyBUaGFtLCBNdW4gWWV3DQo+
IDxtdW4ueWV3LnRoYW1AaW50ZWwuY29tPjsgU3dlZSwgTGVvbmcgQ2hpbmcNCj4gPGxlb25nLmNo
aW5nLnN3ZWVAaW50ZWwuY29tPjsgRyBUaG9tYXMsIFJvaGFuDQo+IDxyb2hhbi5nLnRob21hc0Bp
bnRlbC5jb20+OyBTaGV2Y2hlbmtvIEFuZHJpeQ0KPiA8YW5kcml5LnNoZXZjaGVua29AbGludXgu
aW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW0VuYWJsZSBEZXNpZ253YXJlIFhHTUFDIFZMQU4g
U3RyaXBwaW5nIEZlYXR1cmUgMi8yXSBuZXQ6DQo+IHN0bW1hYzogZHd4Z21hYzI6IEFkZCBzdXBw
b3J0IGZvciBIVy1hY2NlbGVyYXRlZCBWTEFOIFN0cmlwcGluZw0KPiANCj4gT24gMjEvMDcvMjAy
MyAwODoyNiwgQm9vbkBlY3NtdHAucG5nLmludGVsLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBCb29u
IEtoYWkgTmcgPGJvb24ua2hhaS5uZ0BpbnRlbC5jb20+DQo+ID4NCj4gPiBDdXJyZW50bHksIFZM
QU4gdGFnIHN0cmlwcGluZyBpcyBkb25lIGJ5IHNvZnR3YXJlIGRyaXZlciBpbg0KPiA+IHN0bW1h
Y19yeF92bGFuKCkuIFRoaXMgcGF0Y2ggaXMgdG8gQWRkIHN1cHBvcnQgZm9yIFZMQU4gdGFnIHN0
cmlwcGluZw0KPiA+IGJ5IHRoZSBNQUMgaGFyZHdhcmUgYW5kIE1BQyBkcml2ZXJzIHRvIHN1cHBv
cnQgaXQuDQo+ID4gVGhpcyBpcyBkb25lIGJ5IGFkZGluZyByeF9od192bGFuKCkgYW5kIHNldF9o
d192bGFuX21vZGUoKSBjYWxsYmFja3MNCj4gPiBhdCBzdG1tYWNfb3BzIHN0cnVjdCB3aGljaCBh
cmUgY2FsbGVkIGZyb20gdXBwZXIgc29mdHdhcmUgbGF5ZXIuDQo+IC4uLg0KPiANCj4gPiAgCWlm
IChwcml2LT5kbWFfY2FwLnZsaGFzaCkgew0KPiA+ICAJCW5kZXYtPmZlYXR1cmVzIHw9IE5FVElG
X0ZfSFdfVkxBTl9DVEFHX0ZJTFRFUjsNCj4gPiAgCQluZGV2LT5mZWF0dXJlcyB8PSBORVRJRl9G
X0hXX1ZMQU5fU1RBR19GSUxURVI7IGRpZmYgLS0NCj4gZ2l0DQo+ID4gYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9zdG1tYWNfcGxhdGZvcm0uYw0KPiA+IGIvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvc3RtbWFjX3BsYXRmb3JtLmMNCj4gPiBpbmRleCAy
M2Q1M2VhMDRiMjQuLmJkN2YzMzI2YTQ0YyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9zdG1tYWNfcGxhdGZvcm0uYw0KPiA+ICsrKyBiL2RyaXZl
cnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL3N0bW1hY19wbGF0Zm9ybS5jDQo+ID4gQEAg
LTU0Myw2ICs1NDMsMTIgQEAgc3RtbWFjX3Byb2JlX2NvbmZpZ19kdChzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlDQo+ICpwZGV2LCB1OCAqbWFjKQ0KPiA+ICAJCQlwbGF0LT5mbGFncyB8PSBTVE1NQUNf
RkxBR19UU09fRU47DQo+ID4gIAl9DQo+ID4NCj4gPiArCS8qIFJ4IFZMQU4gSFcgU3RyaXBwaW5n
ICovDQo+ID4gKwlpZiAob2ZfcHJvcGVydHlfcmVhZF9ib29sKG5wLCAic25wcyxyeC12bGFuLW9m
ZmxvYWQiKSkgew0KPiA+ICsJCWRldl9pbmZvKCZwZGV2LT5kZXYsICJSWCBWTEFOIEhXIFN0cmlw
cGluZ1xuIik7DQo+IA0KPiBXaHk/IERyb3AuDQo+IA0KDQpUaGlzIGlzIGFuIGR0cyBvcHRpb24g
ZXhwb3J0IHRvIGR0cyBmb3IgdXNlciB0byBjaG9vc2Ugd2hldGhlciBvciBub3QgdGhleSANCldh
bnQgYSBIYXJkd2FyZSBzdHJpcHBpbmcgb3IgYSBzb2Z0d2FyZSBzdHJpcHBpbmcuIA0KDQpNYXkg
SSBrbm93IHdoYXQgaXMgdGhlIHJlYXNvbiB0byBkcm9wIHRoaXM/DQoNCj4gDQo+IA0KPiBCZXN0
IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

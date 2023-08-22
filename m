Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F218784BF0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjHVVWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjHVVWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:22:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97547187;
        Tue, 22 Aug 2023 14:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692739319; x=1724275319;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UVK9eX6TydKtGymGIWUYkOS/VXO8csoqtkV1iHPdMqQ=;
  b=nSOwJY4Ia1ZDI3S6q0Bcb22SRldPWHJiKik8lpfVHAMyuzCNTLXhKAwU
   xWJMiucJiwdXT+TS2kpvg9rlBlk/9mp81m0Cll4QAe9vGUrWSRcOPFJTD
   /qiNIGFDSZdM4NnBi7cQISQfN/SO9q0wccuGqgd5Kt7ZOn3okt1kxMWbv
   YVmhF9vKuj2Ay3B3QjChGez/wauMke5OCyHTHeWGUMjUd3QjQrbxgSFJ/
   QlbG2/Ahnwkz/DzESj39sVqw1cW/UkMj5dRZdnZ73ef+aRuiH/wBTyvMw
   /oGTe1gkBsSfdeFePCGOjlZITRM/RO80G7vosacGwDu6uhlKfuprLyzAX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="437930620"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="437930620"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 14:21:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="860088246"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="860088246"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 22 Aug 2023 14:21:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 14:21:58 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 14:21:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 22 Aug 2023 14:21:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 22 Aug 2023 14:21:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTXZCe0yXai92/flc9odOTJ/aEfbcq3ETz0OaYpGY43J1dqOeGelqdoi9WSOaMEFDTfyGriJX/ygrDpa1l8JgcDeJCqyzqGeUleJYoMzwfWZ5uWZO12EH9v5C4UoEWIOKXng/d2vBtXnkY6NY1D3vMdXDDDKrAyEpW7FX0UoJGIy9uFPIC5qMzUgUSgB6yn7rRpF6/QLP0WFwSitV1eQaaQu54vFCiyfRJhE7ekb5rf/y7bxxaJ2rl23L/Z9M4/HsSG4MtWFC1C4yFZFAx1osmdHCtOzNk7s4ueW+9a6wg0xURXxYRJ2yZlERWnDOm5aXNqEV6FgoquitVvI6RU9eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVK9eX6TydKtGymGIWUYkOS/VXO8csoqtkV1iHPdMqQ=;
 b=MdpzWcxRrfqwpr54O/GzE9tmy+HllUwGo/4G8NFoQEmEa455PgefZttd/WKIzR9vwNjC91Z/pRfW9nuu3YisdI7EEi8B8POorPM3m1BJV15rRVzvz+3Yqt/pe1R44O0fNFaLi08Amfb8kiRfAxz/y6OrH1kIwav85iQ8J1SAjmhUTjGDQFIzkPAkgYYlA8WsPU72dGTTNeQkEnL7RkUcxuNJT38Zq4vVU6jmVsr6g7f0LZyLDhXPnspY4fTqOpCyXv617hCZzfYbZAb9nupnTFb/YoiqsKxyKV3JvPPBW1HD7pNZHmGJlVS8kHLSs8xZnVUm907LYYlddc0bIXj9Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by SJ2PR11MB8347.namprd11.prod.outlook.com (2603:10b6:a03:544::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 21:21:55 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::da4:d67d:40ed:9786]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::da4:d67d:40ed:9786%4]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 21:21:55 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Prashant Malani <pmalani@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: RE: [PATCH v4 1/2] platform/chrome: cros_ec_typec: Configure Retimer
 cable type
Thread-Topic: [PATCH v4 1/2] platform/chrome: cros_ec_typec: Configure Retimer
 cable type
Thread-Index: AQHZuR/m4IKFgl1ovU6TI3vwoe4fN6/weR2AgAS6PdCAAGlfAIABbScA
Date:   Tue, 22 Aug 2023 21:21:55 +0000
Message-ID: <MWHPR11MB0048018BB93C531401D00EF9A91FA@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20230718024703.1013367-1-utkarsh.h.patel@intel.com>
 <20230718024703.1013367-2-utkarsh.h.patel@intel.com>
 <ZN+j/z97Yy0wv/if@chromium.org>
 <MWHPR11MB0048DAF02954ACC66C026533A91EA@MWHPR11MB0048.namprd11.prod.outlook.com>
 <CACeCKacWhrZE6LFFwF=vDO8362u9feN71pPO8Qr8XoaRgwj5uw@mail.gmail.com>
In-Reply-To: <CACeCKacWhrZE6LFFwF=vDO8362u9feN71pPO8Qr8XoaRgwj5uw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0048:EE_|SJ2PR11MB8347:EE_
x-ms-office365-filtering-correlation-id: 30824dc4-7895-446f-4f04-08dba355cf9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YtqLLE7YQd5tkke6/7PtMa9QNS7ijN5kv9ou5QWnehNS1KUb1VBWZeLgy50gssNy9oW02CIUTSgmV1nd1PqewKgUfKwc8wuqJITCPJQmdyLbJpiZ+NBsFXgk8nI+0aOR1SfAJe4fSX/vz8JTbgX4VpEYtuAwMqJHSxJpMwH+Qqqty7JocTpVO2+NC2p6bhS5W+xs3pelkKGbrHI6upFHvd7hYa1xiYrnW07UnBCvA/yY2JxXPwe4oGoq1aTKT94ZKQpltCjIeQkHQ6q1m3NGkhZwO3bLqQE5q3I+6gS8zWrqYAKWSkyhXemjHp1uzkxvFiWt/elxwjUrncExMpuZQKu3bJAOzMFjPLoENXgfkaIM4pkhgvW8Jpo3oq0nrJjtl++0s/C5a4T0APokuqsAs62SI3G52OZ++JaQDrSavsggkpwexGhr28FlaOM7hznaI5rqzjLkxHDdxN9yigf9pxaChVO/dhJoLs+c5W3Ft7Wn7OKoyL3Sh62Fn42Z28iL1Jz90HjRdNU751oHGlF77rpb9OEmR2840POVcGhjNYrpRkxmGtJPamr/MQMyKtSoQUDj45ncMwvGgwHgjTzwYSpzV2mhognFVCuU7BbrP41GiqshCPC1yR3mV1mwQ6M1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(38070700005)(38100700002)(6506007)(53546011)(83380400001)(5660300002)(26005)(33656002)(52536014)(86362001)(7696005)(8676002)(8936002)(4326008)(316002)(66946007)(9686003)(64756008)(6916009)(54906003)(76116006)(66556008)(66446008)(66476007)(82960400001)(478600001)(122000001)(71200400001)(55016003)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2VLQUJScWdKVTZTM3BITmtQRnd2R2RmVXVqUTVzUGpmUkpJY3N3OFd4TDEx?=
 =?utf-8?B?VEJidzh3NG1WaWxiRVJSWkp1V1NSRHZ1czg3N2pDbEcvOEJ4c0lSVmt3TThZ?=
 =?utf-8?B?T2ZYZlEyRytFeWZCb1B1Y1gyU05ZQmlBc1JnQmw4M3FhczhoNUVHR3J3TFo4?=
 =?utf-8?B?KzlMT1l1a2pFMDlGRnRLM3c1QUFVSFZ2MmxTMXZtdlZDVmlFakVSNGxEaVBj?=
 =?utf-8?B?T0pOYWNsQXpNKy9qTk4zKzJrZCt5VmU1bWlyU3FQakRVY2xLVWdpNStUQmhO?=
 =?utf-8?B?TjVGcWxOWWVCU1J6cVpybm1qOFRUbDh5djlvUWEvOWhuUjhoMUFmZVBHYXdx?=
 =?utf-8?B?dUZDeUNLSitXQjBTVnRBRHVHWDJQa1g1bDlCb1JaYnJvQmpzLzlCTXdBQThT?=
 =?utf-8?B?UC9aaUpOOE5heGwzYlF1S0lhMnNDN0psWitEemdqWGlSYVJ6Uk5yb2NnTlRa?=
 =?utf-8?B?RU11YWxTa0tobzFRS3ZBS1FGS1MvM1JBYWFsUmF3blFyZVl6WkRvYUN0VXdI?=
 =?utf-8?B?eHhMMisvS1REZTRSRTZrZzhFVkFac3JVUzVxcGx5U3BnY0crMmpLSml4Unpn?=
 =?utf-8?B?UlFSNExDdmRzY0VCazh2dUN6ejJEdW9LY1J3djVHSkxpOVU1QTVlbjhOd014?=
 =?utf-8?B?TDRzbElrMmNzWkxDL0ZpeGRPK1FWaTJCbG9oWlVIdDRDK1FYN0ZXMjdkT1pp?=
 =?utf-8?B?NU90aEpzOHpvVXBzVzRwQkdKaEdBU05ialhiZERDQlhLY3E0bmhsSS9QZDlH?=
 =?utf-8?B?Qno0STdyNTlkdDlzT0Z4ZFlsaXhuQklJUGRqL2lPRTZaQzZHU3ExaG1zRVlG?=
 =?utf-8?B?TWx6bjBNUlRmTWFNUXFoOFZZc3l0bDZQanE4MXBkc2tvcVVPMWZwRWt1cExY?=
 =?utf-8?B?S0owaHFObFk0SFpPMTNPTitzMDVoY1d1MnFBRnZrdFVOVGlycHRXTVBLL2dn?=
 =?utf-8?B?VlBoMDM3aStaZml4VGJzdVJVa2xpSWdGUzBmRmxtSFc1eEQyMExJaWI2ajNy?=
 =?utf-8?B?eG55UWtCT3pJUjg2ak1sV3NzUDNCN2pqV1RoQ1c0bWJ0RTNUdVp1ZWl4T0cy?=
 =?utf-8?B?TVdWYTdyNXcrR3hzMDhaSGVad294SW5JUG9vTDFBOTZ3QUdodHBBaUVnd0U0?=
 =?utf-8?B?K3BxVFdBRlMyUTMvWVIxSTNjblF5MzJWaHdRNHpsZVJmUFN3ZUI3REw4WkZY?=
 =?utf-8?B?WGdmT0ZrbUd3dG5rMis3T0Z2VG1pS1pDTFUxVkpNeTNrYkdRQkpwSi9CcVVy?=
 =?utf-8?B?YUlIcDAySzhWWFMvenc2VDFjdTd4K2RrMnp4YjFaRUsvZ2tWMWt5UzVrc0dt?=
 =?utf-8?B?eURlQkFLbis4VkVZUGsyUzF2Zldud3VjeC9NNTZEMjBTWkRBM3U2bUN2RXQr?=
 =?utf-8?B?dTVQWEVPWmMyTHVrRXlKUTl6bTR1bXV0NUhvRmlFaFp3QW9PNXBIaFMrTjl0?=
 =?utf-8?B?alVGY3BROEUyVzV3OXFkT3BLOWQyVTM3T3RKNW91M1l5aHB2SXRtempORzdn?=
 =?utf-8?B?KzBxZlc0UVVmY2h2eVp1enh3QVBWemtsRW9RUDB5NWZYUERZK0VOUGlERFRu?=
 =?utf-8?B?ZU14VzV2bmwwUG1lbUhuYWZzS0czOVhMWjlTbnZFa3BNS1NuRU5UdlEvUDI4?=
 =?utf-8?B?SGFGdzlFME53VnlJQndZRStzcVNrVFhoSnYrb090UzVFSmhETUtNaUFhR1ZU?=
 =?utf-8?B?NkthY3d2MXlybGZZQW5mak14emVRaUk4cWdCMXBLclpEZzJ0d2Zvdlh3T042?=
 =?utf-8?B?YnhJSVBWUEpoZWdreDVIakxxL05LS1Z5U0I4cjJRL2YvT0VUd3drS3k3YkI4?=
 =?utf-8?B?K0djRjJ0SGJTMkNFQjNuaUlTaDFsOWpMMlJwMWdhOXRqS3o5Ymt4bm5YdlBD?=
 =?utf-8?B?MTFINThvWTliQkRvaVIwa3FJWGEyK05wd2M0ZWpERGRNMzhwbkFIbmR4VWVr?=
 =?utf-8?B?RjdBVUNwbXVtMzMyaDBVQzJoRmM3T3RLYzR6Z2dpNVpsMHhUaUo4Vko4SmFU?=
 =?utf-8?B?NVpzbzFSdzdIZy8xU01aVDBKQTZoWG9QbUNEQmtsWjdrYy9OMm0xNUxNZXZs?=
 =?utf-8?B?M1J4TEZOMHJ4UnhwSzQ2RkthYUpYSXo0dWJYeW1FUUd6dy9LaUVlUUo4YTlU?=
 =?utf-8?B?TlhxeFovd2lwNkxzdkpzbzB6cDNRMkJjOTdtRWdqN29nNlBwU09Xby8rTVdq?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30824dc4-7895-446f-4f04-08dba355cf9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 21:21:55.3292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zX3LNoUF7MkiBixQJiyDhA/zwFgf89ieWYNqdNqpt+n9Ftferelb9ju5js1pU03RkWU6IyPkpkc/mEpCvexNCxtLlhMEg2m/DquiY99ZYx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8347
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

SGkgUHJhc2hhbnQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUHJh
c2hhbnQgTWFsYW5pIDxwbWFsYW5pQGNocm9taXVtLm9yZz4NCj4gU2VudDogTW9uZGF5LCBBdWd1
c3QgMjEsIDIwMjMgNDozMSBQTQ0KPiBUbzogUGF0ZWwsIFV0a2Fyc2ggSCA8dXRrYXJzaC5oLnBh
dGVsQGludGVsLmNvbT4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LXVzYkB2Z2VyLmtlcm5lbC5vcmc7DQo+IGhlaWtraS5rcm9nZXJ1c0BsaW51eC5pbnRlbC5jb207
IGJsZXVuZ0BjaHJvbWl1bS5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAxLzJdIHBsYXRm
b3JtL2Nocm9tZTogY3Jvc19lY190eXBlYzogQ29uZmlndXJlDQo+IFJldGltZXIgY2FibGUgdHlw
ZQ0KPiANCj4gT24gTW9uLCBBdWcgMjEsIDIwMjMgYXQgMTA6MTjigK9BTSBQYXRlbCwgVXRrYXJz
aCBIDQo+IDx1dGthcnNoLmgucGF0ZWxAaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+ID4gIC8qDQo+
ID4gPiA+ICAgKiBTcG9vZiB0aGUgVkRPcyB0aGF0IHdlcmUgbGlrZWx5IGNvbW11bmljYXRlZCBi
eSB0aGUgcGFydG5lciBmb3IgVEJUDQo+IGFsdA0KPiA+ID4gPiAgICogbW9kZS4NCj4gPiA+ID4g
QEAgLTQzMiw2ICs0NTMsOSBAQCBzdGF0aWMgaW50IGNyb3NfdHlwZWNfZW5hYmxlX3RidChzdHJ1
Y3QNCj4gPiA+ID4gY3Jvc190eXBlY19kYXRhICp0eXBlYywNCj4gPiA+ID4NCj4gPiA+ID4gICAg
IC8qIENhYmxlIERpc2NvdmVyIE1vZGUgVkRPICovDQo+ID4gPiA+ICAgICBkYXRhLmNhYmxlX21v
ZGUgPSBUQlRfTU9ERTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgZGF0YS5jYWJsZV9tb2RlIHw9
IGNyb3NfdHlwZWNfZ2V0X2NhYmxlX3Zkbyhwb3J0LA0KPiA+ID4gPiArVVNCX1RZUEVDX1RCVF9T
SUQpOw0KPiA+ID4gPiArDQo+IA0KPiBIZXJlIGlzIHRoZSBmaXJzdCBjYWxsIHRvIGNyb3NfdHlw
ZWNfZ2V0X2NhYmxlX3Zkbyhwb3J0LCBUQlQpLi4uLg0KPiANCj4gPiA+ID4gICAgIGRhdGEuY2Fi
bGVfbW9kZSB8PSBUQlRfU0VUX0NBQkxFX1NQRUVEKHBkX2N0cmwtPmNhYmxlX3NwZWVkKTsNCj4g
PiA+ID4NCj4gPiA+ID4gICAgIGlmIChwZF9jdHJsLT5jb250cm9sX2ZsYWdzICYgVVNCX1BEX0NU
UkxfT1BUSUNBTF9DQUJMRSkgQEAgLQ0KPiA+ID4gNTIyLDgNCj4gPiA+ID4gKzU0NiwxMCBAQCBz
dGF0aWMgaW50IGNyb3NfdHlwZWNfZW5hYmxlX3VzYjQoc3RydWN0DQo+ID4gPiA+ICtjcm9zX3R5
cGVjX2RhdGENCj4gPiA+ICp0eXBlYywNCj4gPiA+ID4gICAgIC8qIENhYmxlIFR5cGUgKi8NCj4g
PiA+ID4gICAgIGlmIChwZF9jdHJsLT5jb250cm9sX2ZsYWdzICYgVVNCX1BEX0NUUkxfT1BUSUNB
TF9DQUJMRSkNCj4gPiA+ID4gICAgICAgICAgICAgZGF0YS5ldWRvIHw9IEVVRE9fQ0FCTEVfVFlQ
RV9PUFRJQ0FMIDw8DQo+ID4gPiBFVURPX0NBQkxFX1RZUEVfU0hJRlQ7DQo+ID4gPiA+IC0gICBl
bHNlIGlmIChwZF9jdHJsLT5jb250cm9sX2ZsYWdzICYgVVNCX1BEX0NUUkxfQUNUSVZFX0NBQkxF
KQ0KPiA+ID4gPiArICAgZWxzZSBpZiAoY3Jvc190eXBlY19nZXRfY2FibGVfdmRvKHBvcnQsIFVT
Ql9UWVBFQ19UQlRfU0lEKSAmDQo+ID4gPiA+ICtUQlRfQ0FCTEVfUkVUSU1FUikNCj4gDQo+IEFu
ZCBoZXJlIGlzIHRoZSAybmQuDQo+IA0KPiA+ID4gPiAgICAgICAgICAgICBkYXRhLmV1ZG8gfD0g
RVVET19DQUJMRV9UWVBFX1JFX1RJTUVSIDw8DQo+ID4gPiBFVURPX0NBQkxFX1RZUEVfU0hJRlQ7
DQo+ID4gPiBXZSBzaG91bGRuJ3QgbmVlZCB0byBjYWxsIGNyb3NfdHlwZWNfZ2V0X2NhYmxlX3Zk
byBtb3JlIHRoYW4gb25jZS4NCj4gPiA+IEVpdGhlciBjYWxsIGl0IG9uY2UgZWFybGllciB3aGVu
IHlvdSBhcmUgY3JhZnRpbmcgdGhlDQo+ID4gPiBkYXRhLmNhYmxlX21vZGUgbWVtYmVyIGFuZCB0
aGVuIHJlLXVzZSB0aGF0IHZhcmlhYmxlIGhlcmUuIE9yIGRvbid0IGNhbGwNCj4gaXQgdGhlcmUg
YW5kIGp1c3QgY2FsbCBpdCBoZXJlLg0KPiA+DQo+ID4gV2UgYXJlIG9ubHkgY2FsbGluZyBpdCBv
bmNlIGRlcGVuZGluZyB1cG9uIHdoaWNoIG1vZGUgd2UgZW50ZXIgVEJUIEFsdCBvcg0KPiBVU0I0
Lg0KPiANCj4gVGhlcmUgc2hvdWxkIG9ubHkgYmUgMSAiY2FsbCBzaXRlIiBhbmQgdGhhdCBzaG91
bGQgYmUgc3VmZmljaWVudCB0byBncmFiIHRoZSBWRE8NCj4gZnJvbSB0aGUgZnJhbWV3b3JrIGZv
ciBhbGwgY2lyY3Vtc3RhbmNlcy4gV2hldGhlciB0aGUgb3RoZXIgaW52b2NhdGlvbg0KPiBkb2Vz
bid0IGdldCBjYWxsZWQgdW5kZXIgY2VydGFpbiBjaXJjdW1zdGFuY2VzIGlzbid0IGFzIHJlbGV2
YW50Lg0KDQpBcmUgeW91IHN1Z2dlc3Rpbmcgc29tZXRoaW5nIGxpa2UgdGhpcz8NCg0Kc3RhdGlj
IGludCBjcm9zX3R5cGVjX2NvbmZpZ3VyZV9tdXgoc3RydWN0IGNyb3NfdHlwZWNfZGF0YSAqdHlw
ZWMsIGludCBwb3J0X251bSwpLi4uDQoNCglpZiAocG9ydC0+bXV4X2ZsYWdzICYgVVNCX1BEX01V
WF9VU0I0X0VOQUJMRUQgfHwNCgkJcG9ydC0+bXV4X2ZsYWdzICYgVVNCX1BEX01VWF9UQlRfQ09N
UEFUX0VOQUJMRUQpDQoJCWNhYmxlX3RidF92ZG8gPSBjcm9zX3R5cGVjX2dldF9jYWJsZV92ZG8o
cG9ydCwgVVNCX1RZUEVDX1RCVF9TSUQpOw0KDQpTaW5jZXJlbHksDQpVdGthcnNoIFBhdGVsLg0K

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E547CAF19
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 18:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbjJPQ0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 12:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjJPQ0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 12:26:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDBD273E;
        Mon, 16 Oct 2023 09:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697473107; x=1729009107;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GvJaW7A8xKIHZedAbytplFIFvjRhnqB21PvD71BVrh0=;
  b=cjqgAg1tjd0UlClB1fcOSHRgB7DV+WNVTQZKdiNodp+P8tYWuhwoWLYE
   s3UaIvVsvod0/NJ1O63dlG0xvJlM8YYkDvxWZX9C8Emt5Bz6/Eia/qCKS
   ob9Q3ubMWu9vAVTQEW4fi6RWjHdokSGUFHD+jG4DlArIZo4KHszehN3TK
   Pnf6+pjP2U/oJKsG1mIQbp0GqV0B5key+8NnlgRG3xs44Y0oo6ZvW00rP
   jvBChyoZjwgij2jzsYGnpkn+riL+XrPOBsPzgWLKF+y5/8bwQxM2dKT+O
   qkac8dvzYQ65lJiyxNNMKCJj3GWIRCcKVU6+xon7M7KaElAZyPDkNj3ms
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="384442692"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="384442692"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 09:14:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="790859763"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="790859763"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 09:14:33 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 09:14:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 09:14:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 09:14:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWwCKqosEbCQ9Hnlqr6iwr6KdCcWNf68k5rY38B+HIn9/ZeUyuGUw7XYWZzdg9xZ284gRVbGSGQJIiVu2mscq41zZXs8GYX41Ja1N9YZ9sGBtPU1OvEy484ma5r1KOsd5RPbJ5KwQ3GcurD/pxRP5U7BoH4SjdpkAbZCgW+dFd4jM4vkqCsAUlA0uLPV1bY6tA4CFkXXRDLK8IsboET0yGGr/jIzPL8dSqIA/Jp+y9ZDpt8yedvrBDek+3sHuLb4RvIviw8NbXOBzmR7YUXVgyWUegYtH2emY1zlHjb4KPiUBdMFgZHdM/SMbUqDqZgZI7Ohe0aC5tdnryJls0F1bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvJaW7A8xKIHZedAbytplFIFvjRhnqB21PvD71BVrh0=;
 b=eSj4klX5iLX0Z6RV2//Kijn1SR354nJuWiriIlhwKyK/nbMywnTzqX/MEWaoZoD2x8c3m0g8IBUzrlegh00+BtgO3p6Qyg1EMkHhMBFHlVVwl7KPyhyklOnJmguceHEhryApDTqCvcbA/2F8xfrmtiGC6p1+5mEA2WaPlYe/T2PDQ27puhof5gM2p3L3ALuom9vX5zCE2GmsHtKbTtFNskQOWCh2odzedn6S94eBFMb9idPBfzkZJqn31AqtUtO38bQAbLZ3ntUSMnfGjH1IVh6FHTP6TiP9qv7epdASuQnNTEfKGNGZ2zQezy0ByGxvLKDwDarqFnLMziknBSNxXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SN7PR11MB6873.namprd11.prod.outlook.com (2603:10b6:806:2a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Mon, 16 Oct
 2023 16:14:25 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7316:13b0:88bc:b3c8]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7316:13b0:88bc:b3c8%4]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 16:14:25 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Sironi, Filippo" <sironi@amazon.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH] x86/mce: Increase the size of the MCE pool from 2 to 8
 pages
Thread-Topic: [PATCH] x86/mce: Increase the size of the MCE pool from 2 to 8
 pages
Thread-Index: AQHZ/GC+wrCutl2FxUqQMHq01xRyfbBE2SEAgAExhICAAEQDgIAGLqCAgAAC7gCAAAZSgIAAFYDQ
Date:   Mon, 16 Oct 2023 16:14:25 +0000
Message-ID: <SJ1PR11MB60832922E4D036138FF390FAFCD7A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231011163320.79732-1-sironi@amazon.de>
 <afaef377-25e0-49f6-a99f-3e5bd4b44f87@intel.com>
 <EDD08AA3-C404-4DB6-96BA-2B25519B2496@amazon.de>
 <6591377b-7911-444b-abf9-cfc978472d76@intel.com>
 <1c598798-5b28-4a17-bf86-042781808021@amd.com>
 <dd72296c-def6-4fb3-9984-348641cdb6a4@intel.com>
 <dc57436b-8483-4c50-a7a9-0f895a494ada@amd.com>
In-Reply-To: <dc57436b-8483-4c50-a7a9-0f895a494ada@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SN7PR11MB6873:EE_
x-ms-office365-filtering-correlation-id: a4d147a6-4ab2-4b30-9bec-08dbce62f741
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qe1DSpSSxoWWnT1whoKjBiqUKA/b/WGLIZKkMaI4VqbIFmyTgFYIXF+j+YRt4IFNBAs24EPWfyXg/4gatN4k3Hye/eVKyerxVPPWY85nlUdU6qs4dOBZXNAhGObliJjWzeC+Ddg6B4XTBaF+v3TRgS+L3bG3UUUvqUnrosgiB2eV0Umjj28vzgo9icFYAoexhsJeVo673oktZ0yK7XB4n7Ocg7Mr1A/oZejkdePHMddTC7N3h7FHpCcadzdmOyTf5rn5akMYFvFstO9+VaBfOQ2kvvNsRrBZvp4OZD1J0zCYLb/2EcWON6hTcRPciJkWnDk0zqRu5i4VPuhhPT6C9hxDQUeOKMdi1LzcKbpjL5hNvhlVlNQ3heWGRlCdkGdUDGz6Ok+UX649ZQqCITs51zJkJ7aTg8rqVtLfRWC4Drd2MaZRuF1ECHEaWo4cp2JCI0YpbmYRgoBkxsbDQjrvfJ9PDDkmRPeYm76sJCVuH6eBekuf/qXCtvrUaI+WwGwyjO/fbzo3tu5ISiIU9lvMYZvTljLL6T7pqt1Y4nCKx8wZyotynkvcSi3svtj88cd9yKofA6aQW9giIkAWiEqDbTLaAI7qBPBbk/5IpVbs/B2xYLqxxlNlnMNk3ZUn9WX3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39860400002)(346002)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(9686003)(26005)(7696005)(6506007)(83380400001)(66556008)(38100700002)(71200400001)(55016003)(8936002)(478600001)(66446008)(41300700001)(4326008)(5660300002)(82960400001)(86362001)(4744005)(2906002)(52536014)(33656002)(8676002)(7416002)(64756008)(122000001)(66476007)(54906003)(66946007)(38070700005)(110136005)(316002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmN0aE9GZURUR2xUTjl1L29jbkFNNmVoaGtnbXN6cGZ2cGZHMDBneElyRFRU?=
 =?utf-8?B?VTlSVFNkdFFFSC9iV0pwS2pFaGppNk5oVldFcmNVQlF2VUhRNnNiZ1Z1WmJW?=
 =?utf-8?B?eXVUemgrMm5ZaWwwTjNYYlpvUklOZ2hxSTg3SDdxaWFTRTFkdmRGMm93NDdz?=
 =?utf-8?B?NkVEVDg0VlRja2FIRDZINXBpdFlnWENmWXpLd2dMbzZ0eDZWbnpzMUZYR3Zl?=
 =?utf-8?B?NjkvdEpQbjdTOURrNkMvVjBRNWJXQ3h5RHQvbkx3Q0NieDRTMEtBaEhvZmZ2?=
 =?utf-8?B?VEpVVXVPNVg4ckloWEZaZ1NQYkNQRUFIbUh5RnYwZzlkUDR6NERIT280RUZZ?=
 =?utf-8?B?UlR6ZXljWWFqaGk2bjlDVFBmQmlKd0hEM1VaaHJqZ3QzV2VVWVE4b2JFWE54?=
 =?utf-8?B?R0FZYnM0YVlhdVB3RXR4TDJZUHJQV0lhNnVxVWFvTDVWRERoaGZKeC9QZzFr?=
 =?utf-8?B?VU8veklkdkIzUTcrUWRuUVFUNUhVbXNNS1Bic2pnRnBiaUFIeEJWaldVVkNa?=
 =?utf-8?B?ODBFMDZtdFR4eVlvcVp0RDlmbUJ5ZnBiYnIzMitFNmFuQlk3aGdvVURiNnJv?=
 =?utf-8?B?ZW80YUxmQmpFdDgxOHlSOXNHckxHRWtkY25ROHFXaTc3ejZFSnNZWGRWdFo2?=
 =?utf-8?B?UWsrOWVwdU1wZTJIa2IybHIzYWtibVFGU0lMVTJXdmR3VXh3WHVUUlA4NnM4?=
 =?utf-8?B?SDNQTndubHp1YlVsb2JZNHVjWkJYUnM3K2lyYlp0RFE3U1duZlhobGtuWTk0?=
 =?utf-8?B?N0ZZTnd2YSs2bVBYMXRLVnNiOHNZekV4TE5STUxicmszd0Z4MWJGWkw3WnB3?=
 =?utf-8?B?WVlETTRqQWdRU0hOY0tMa2RQYm94Q2ROdXg2NzhUMXJZNWdrTEhzUldVM29x?=
 =?utf-8?B?RjZtd1FIV0tZa25yejRlQlpTR1hpZU15NEdKenNCR2NoelA4ZHpDZW53dHo4?=
 =?utf-8?B?UVFlTnVvZUtnVHZ3UjFpdTRmaUQySFhackxCeGtVekVKRHVvM2Mrb2pXWU8r?=
 =?utf-8?B?UnN6c2ZkOVpXTWNhT3FmSTJRRldlREIzYTZ3U0FwelRHQkRKWUUrbk1CSjhz?=
 =?utf-8?B?NEFibGJlL0VXWlFNOE5WckgwTjRNZWNmR3U4c2pZVEFVSlQvdWFPYWN1bXV3?=
 =?utf-8?B?NmZqQTFPNkw5RWxGNmFqRTQyalBhdytBdEFGOE9UbkhFblRQUDh5SWp2bmNX?=
 =?utf-8?B?cUF5cTl4WVJGYVdXZVJGRC9uSDVJWVppR1p3Nlp2cDhPeHd0MnpxL2lQM3Fn?=
 =?utf-8?B?NFU3RFYvam5RRVJsdmdLaHVaTVR4MUZnYW1iSHlTT2RBU2t4V0poalJ0VS9u?=
 =?utf-8?B?V1lSOGdsT3VmV0Z0dUNCMk5FWWQwSW5uQSsya1RBa25VTEhJemJ2WEJjR21C?=
 =?utf-8?B?NHA4WnNsSTc0bExvRUZiUWxaWFFyT0tqVG1LenNyMGFzVU55WVV0enNaalFS?=
 =?utf-8?B?QUVBUGRIaEMralBaZDNHQnVzRmtYYXJKNm1jQzhUTGIrdHlqaytkT3hOeDBE?=
 =?utf-8?B?aFlNMWNHNUhocXhQem1yVGFEZnU5WlpmZXJKL1pXSmNXanRNZWtOWG1LMXdl?=
 =?utf-8?B?N0dnRVNiTXhtSGcvRDU3bXNnSW16dWY0NnJBdEwzaDZKUXROck0yZERrWnNO?=
 =?utf-8?B?WG5DaUxlYTMrOXdLN2dCOWVKRERGOGV3Ri83dGN5VmxxSjRScmVYblo3UU9G?=
 =?utf-8?B?OEdDSHVUVXhhYVJwam9PR1g1OFhzcjM4MDRHTWpXRXJqVitBOWZKaXBGWDNh?=
 =?utf-8?B?aEJsL2pXb0RqdHFETGR2LzRsajN1K0pYQVJBMzRUQTRaMzdZQ05DRDNZNy9W?=
 =?utf-8?B?WStxY3gxbUNRallHNzVvckNTbllnd1FSeUVzL0tLUUtYT0tGalM1WE1SMnlv?=
 =?utf-8?B?aHFGT2gwVmpyNHh5ekNaOUtlM1VZcGd6UFhKRkFuZWlYTEVpS1RoVTNuc1hT?=
 =?utf-8?B?bENSS1oyZmFiS0Z5VkhWU1p5NXhpQTJVTDQ1T2hQdkkxK2hJSGdmQlZDMmlS?=
 =?utf-8?B?c205WWlWWTZrQjhMbkM3S2xYRGQ2b0FKVzVSejVqeWxKaVI3Y1BnUjVOT3RS?=
 =?utf-8?B?c1RVNkNUNW5hY3orckkxMUU3R3g4VllBUVIrVlY3SDNKRkhDWXAwcWFsRnVI?=
 =?utf-8?Q?WsVA+CCVTuf0yzzcePumgKYwL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d147a6-4ab2-4b30-9bec-08dbce62f741
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 16:14:25.3146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TS1OArs+ibwEkuwjguwWlovjslw6W83iPG26wJarsLWkXoTTLxyQP1UbDh8+WV/DKMdWL9wfrYmBboGYDMz6bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6873
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IEFuIGF1dG9tYXRpYyByZXNpemluZyBvbmUgZG9lc24ndCBoYXZlIHRvIGJlIGZhbmN5IGFu
ZCBvbmx5IGhhcyB0bw0KPiA+IGV4cGFuZCBvbmNlOg0KPiA+DQo+DQo+IFdoeSBvbmNlPw0KPg0K
PiA+IHN0YXRpYyBib29sIGV4cGFuZGVkID0gZmFsc2U7DQo+ID4NCj4gPiAuLi4NCj4gPg0KPiA+
ICAgICBpZiAoZnVsbCAmJiAhZXhwYW5kZWQpIHsNCj4gPiAgICAgICAgICAgICBleHBhbmQoKTsN
Cj4gPiAgICAgICAgICAgICBleHBhbmRlZCA9IHRydWU7DQo+ID4gICAgIH0NCj4gPg0KPiA+IEl0
IG1pZ2h0IGJlIGEgX3dlZV8gYml0IHdvcnNlIHRoYW4gdGhhdCBiZWNhdXNlIHlvdSBtaWdodCBo
YXZlIHRvIHF1ZXVlDQo+ID4gc29tZSB3b3JrIG91dHNpZGUgb2YgI01DIGNvbnRleHQgYnV0IHNl
cmlvdXNseSB3ZSdyZSB0YWxraW5nIDEwLWlzaA0KPiA+IGxpbmVzIG9mIGNvZGUuICBJdCdkIHBy
b2JhYmx5IGJlIGV2ZW4gc21hbGxlciB0aGFuIGRvaW5nIGl0IHdoZW4gcG9rZWQNCj4gPiBieSB1
c2Vyc3BhY2UgYW5kIHdvdWxkbid0IGludm9sdmUgbmV3IEFCSS4NCj4NCj4gT2theSwgSSdtIHdp
dGggeW91IGhlcmUuDQoNCkknbSBub3QuIFRoZSByZWFzb24gdGhhdCBwb29sIGV4aXN0cyBpcyBz
byB0aGF0IGFuIGVycm9yIHJlY29yZCAoc3RydWN0IG1jZSkNCmNhbiBiZSBjb3BpZWQgaW50byBp
dCBkdXJpbmcgbWFjaGluZSBjaGVjayBjb250ZXh0IGFuZCBhdG9taWNhbGx5IGFkZGVkDQp0byB0
aGUgbWNlX2V2ZW50X2xsaXN0LiBTZWUgbWNlX2dlbl9wb29sX2FkZCgpLg0KDQpJIGRvbid0IHNl
ZSBob3cgeW91ciAiZXhwYW5kKCkiIGZ1bmN0aW9uIGlzIGdvaW5nIHRvIHNhZmVseSBhbGxvY2F0
ZSBhZGRpdGlvbmFsDQpwYWdlcyB0byB0aGUgcG9vbCB3aGlsZSBleGVjdXRpbmcgaW4gdGhlIG1h
Y2hpbmUgY2hlY2sgaGFuZGxlci4NCg0KSnVzdCBtYWtlIGl0IG9uZSBvZjoNCg0KMSkgQ09ORklH
IG9wdGlvbg0KMikgYm9vdCBjb21tYW5kIGxpbmUgb3B0aW9uLg0KMykgRHluYW1pYyBiYXNlZCBv
biBudW1fb25saW5lX2NwdXMoKQ0KDQotVG9ueQ0KDQoNCg==

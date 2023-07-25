Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1ADA7618D1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbjGYMuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjGYMuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:50:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33160C4;
        Tue, 25 Jul 2023 05:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690289409; x=1721825409;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SOYeW2JVfRB7Cl4cPgBbtyfrUw25XLlTO83ENRELNdc=;
  b=HzNAO3nobL/CNBkRjBHkH7opLjfMJT3vKaSalDZgepJhO13eGvsU+m3e
   YfolUkMAPfVhnyrbsFOuGnzkGBkqRblcBR1Doj5N/8S4ZsyvSZh7tQoil
   T4MVLHd1X0erLc5l4OoG6e4AAfYYeUZH6EwWJ7r8Q7ijDKT3iFQ2Rvmjr
   m59A9MEcGPOweTCoVxmofdGl98iPoGBI3a33EbhxXg8Vo4hKi2APJ3CY5
   1cj32b1yas4poksM55K72rlRfwwJ21AU+VG4PbW/8J0lZjUtpes2Ow+hS
   TZ/KuHqT25V2cgtqSW38/A7zNvB5d5rMMNf9Ud7s3DyHLoH/aqdbDyO7T
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="367735528"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="367735528"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 05:50:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="761197706"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="761197706"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 25 Jul 2023 05:50:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 05:50:07 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 05:50:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 25 Jul 2023 05:50:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 25 Jul 2023 05:50:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiZHUTqUP/QnFRJuKW1gIB618MckwWcOeSvgjXUdeFqRw5uxgcWiFJcFTX+pHgyQ3DCl0fGpLnV8ZvYrFh9qwzFmhjZxCyH8cWQMmMlQh2EdYUaHKbwh2dD9uf6UyXiWQ4XPGntz12Cvz3GtPpXi7kLdqMYUJ/CwSwcMIBwx0J2LjKmGmYBPg8Qndyieb/bHmOLaE/+TsAr8IW+pLP2lnxXFvuUr9v7SwErNMN+J6RlsXb29GW3dyQDxpb3nJ3Md1w5S/2JGsqGwXI39CEyze6LuCvdJGOUmaq0TQpqqpZaGCSbEf3+REO107KvF793rPuG/CRuHxzCP4vEGMt9TOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOYeW2JVfRB7Cl4cPgBbtyfrUw25XLlTO83ENRELNdc=;
 b=Oc60jh8oCmgA+hQLhYlB917VuVqfOG323jj65OyqRWuH+iUPyPSoISrDgK+ACQgGCeQc86CMQng/f9S0nrrLEOxngXT/NdCCaUhRpACUH7p1Xo+T3EEFBDXH1TZfyBMHshzpiEkjiNm5/ismXsZysOIYpR5Rsa6snmFpAi56BG68l7ruBEGj2RSkIijXklfQMdZxBB7XS1C2tVv2tul+R3Djo9D3ITk8UC2iX0y5cp7EEFXdPliO22UNFLRYOIbuM1fmkrNzxLSu10khOcU92YGnX1YyJlDnkA8TygRM1AlYFqWHFCD490JOUz3CQMv4fSbTMmOvxnwxuRhp3ZGRmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by DS0PR11MB7969.namprd11.prod.outlook.com (2603:10b6:8:120::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Tue, 25 Jul
 2023 12:50:04 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::f8a8:855c:2d19:9ac1]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::f8a8:855c:2d19:9ac1%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 12:50:04 +0000
From:   "Usyskin, Alexander" <alexander.usyskin@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Richard Weinberger <richard@nod.at>,
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
Thread-Index: AQHZo3n2ZB8U6WhTx0+aElx0ckVEpq+5lImAgAGKEwCAAPTUYIAAe3sAgAxtDQCAAAdkAIAAAWCwgAGewzA=
Date:   Tue, 25 Jul 2023 12:50:04 +0000
Message-ID: <CY5PR11MB636670FCA46F7F68F21AF44BED03A@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20230620131905.648089-1-alexander.usyskin@intel.com>
        <20230620131905.648089-2-alexander.usyskin@intel.com>
        <TYWPR01MB87756794A30EB389AB017EB1C234A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
        <20230715174112.3909e43f@xps-13>
        <CY5PR11MB63666C8DA33C93E1DC3BCB21ED3AA@CY5PR11MB6366.namprd11.prod.outlook.com>
        <20230716153926.5e975231@xps-13>
        <CY5PR11MB6366C254F767B6C432C98A0CED02A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <20230724135118.54e39faf@xps-13>
 <CY5PR11MB6366FB890508D05E1D1C1375ED02A@CY5PR11MB6366.namprd11.prod.outlook.com>
In-Reply-To: <CY5PR11MB6366FB890508D05E1D1C1375ED02A@CY5PR11MB6366.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|DS0PR11MB7969:EE_
x-ms-office365-filtering-correlation-id: 0cc5c36e-5258-424a-e965-08db8d0daaf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H3+LwmQrUllTkgNHK9ty793nrDhT/NAunrmvbDzid6HiQvBdR4UCQgaV1ppw2oQBrORFqmfB+lE0KYIkNYhMqJbEOU62oi8zzycrZ1CjiHDxXgHED05ofHQXAMQ57S8MzboDwrX+4SyXom+PZMSVQSDVWfQvhFWLpYtdk/bDxmsXQvAChtzbvgIVcEaqY/6yLyn4SKl0CmexjkOiDH/eWXhREo9EU2mrSQDtLXl9kYUNxLS+qYSnlV9bWWms735+RGBC/tFjsEIk1rFH0K5+rsC3ck4XQxqAeUTNNaFRzdBvN/sodAprmTz6T2CLi90hiEnmnfil46XGdIk/7GdvtCWDU2QmT/oMwFb8WbO8zvkxrXHtXiiKOtfMme3MsBcl6QpoQb2aII1oQsm56fQMy1W25m5c1ng0V+rfMejMKpUQm3UqAJ/wnpv9juNElLTzBvJJsGbzyYXd8fF4awhsA6mmGdNoAiecZyi35CS+/ALqHxK/UEJ7/vUnzG3Kl1APInMP30rw2kcy4RdfTQd9IOyyxAINUOVLSJWH9PwIiUfKYAY+qDUebvZs6+XDdbpNKyTWDA6UXOZsOodW/aogNkpqA4p0647BarM8JscxJldx6u8uESp8qhKUH6uSHZKUy4n/lScD3kVzhB3ehVsgC3gccUR4eskvKLcScUnumoM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199021)(41300700001)(6506007)(33656002)(478600001)(186003)(83380400001)(66574015)(26005)(71200400001)(38070700005)(55016003)(9686003)(2906002)(7696005)(86362001)(7416002)(5660300002)(52536014)(66946007)(64756008)(66556008)(66476007)(76116006)(4326008)(6916009)(66446008)(122000001)(8936002)(8676002)(316002)(82960400001)(38100700002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWZtSGJzZDZWdGRCTG9wSXN0UVM0S24yVnZUalhSQThneG1ORHQvblJzVDIz?=
 =?utf-8?B?YjBneENiWnVoNG5sL2xwT2NCVXFGaFNnOU1lSE1STnFpSVpsMkduMXFmOWF2?=
 =?utf-8?B?LzRYTFJWUHc3NHVNdCtSRlI4ZGloQlZuR1NHOFpVTUxBNGhlL2EvUVE4WFF3?=
 =?utf-8?B?SUVhYncxZkdLZUx0aThiMjZSSFJZRk52azJTbWR2WGFkSmROQnVnWnFGb29S?=
 =?utf-8?B?Z29xODJ1UlJBbzBoMms0SUJJNXlsMGFkV0RMeHo1OXhZMnlwSjNab1RGa0pz?=
 =?utf-8?B?cUxrTm8vMk1TZ2hVTFFhV2pnMzkxSFEraFJpbldlcFRjM085WXphWGd3VlhN?=
 =?utf-8?B?NjJuaGlDQXMzNms4a0RCWnI2TUNqUnJ0aldCQWtjZTdwNTZsdjVYUEw2MEp4?=
 =?utf-8?B?UFoxeGpZdE5BSHFUc2xveFNIV0RZQlZNQ3NOajhwMUhUanQ3T1BoeWhrSFlm?=
 =?utf-8?B?UEZhaURlRFRFRXA4Zk5RanRDcGhqRklyeGVRUC9ieFY5aGt0Y0J3Wm1jZXBC?=
 =?utf-8?B?WE9yZXpaMDg5bE9wb1RLYlFJLzF0eVdYV2xVQUJFTWVZMGRNK1R1Y3ZMVHlE?=
 =?utf-8?B?bVlPZml1K0djN1c2RXg4a3lPcWhpWDBLN3d3TlV3V0QrVDlvbXRNZ21qd0JO?=
 =?utf-8?B?bmFkb2RuR1ppSXJaRU1ja3BsUEs3SlJPQ3F6Y3NZYm8xY0p2TXBHQVFMT1pP?=
 =?utf-8?B?Ty9vZjg1V3kvZWxSTEdjUmNja0xDQkRlaCttRDBSNmVSZW9ULy9NeHVoanBK?=
 =?utf-8?B?NmlYbVFvenZ3blQwMnZiWlZoU0tiaVRYTjBQRy9xcnpmbFc4bUxKc296Lzd4?=
 =?utf-8?B?YTRvZVRVdFcyTDlvZUFJM0pNWGc3SW5SQUs4b0MrYUppSXdtRnFmM3MxaHhz?=
 =?utf-8?B?dUl1RFFxWkVQQTVScmRpMkg4RG0rSFhTSWNGMGxha0hWUWdPWlIxR01RckFU?=
 =?utf-8?B?UHBkTlVBeHhCWmptWmJvRjc1a1J0anllUDBmc2JUd2dlc0U5RWdlZ2wzQTdU?=
 =?utf-8?B?cm9DZ1loc0UvY1JiT0UwVGpQTmRYVHoxV085RFhTVXRTQkhRTlpkK21QbENy?=
 =?utf-8?B?dTlCNHNrc2NkM0pQdWVLTHB3TisvQ1A4THF1YUptZk1aRlRHQWxPU1FEdjhU?=
 =?utf-8?B?TndiSjhIczJPZVlVemcrK29GRkRLVVJFZ0JyZmlLSHkxbEdJQVJkSEE1czhX?=
 =?utf-8?B?UDRFSEJTYnJpQVlSLzk0L001aFNnREFqOXZFZ29PU0RwQy9pM00xTHJEMTFo?=
 =?utf-8?B?eFlTeElQVmVTT2dEL3RqZW8zekplMys2ZkpiVkdTVlUyekZhZ3R1ckE5VjU1?=
 =?utf-8?B?QmI3TDY2QS9kTDR5MWxlU0EvUytUSWgyVU9Sd0gxUjFvQ3dKWTY2WlY0NmFJ?=
 =?utf-8?B?NjQ3c05zOW5RRlZDc0d2eXJveFpybGFhUUN1b3NnMzZuc3BqN2pCb1piaC9u?=
 =?utf-8?B?NHhzTE5USFVDOFBrblA2bEdVTWJXc2xnOWsxM204Z01XMURrV0JyVmxISEVk?=
 =?utf-8?B?Myt3c1h0UHpnZFlJbkJseVBWL21qbWswODhSbURWMnFzTDlsMEtRdnVKUnRJ?=
 =?utf-8?B?WjM2MUVsaFZkcFBNbmNSY1JhNkdsTk9CdVdIUU1Xbktrcm9jbnNJL2puY2NJ?=
 =?utf-8?B?N1lHNkl2c1gxUnpMMUpYMVl3WnNTTlV0VlZ6ZWtDakxrRFFxQjllekUxaUx0?=
 =?utf-8?B?QWNtaDZwRWJhVXJYSDFWUDBZWUQzc2RDZm5TWktqWXNXMFZQejNrZDdiOXli?=
 =?utf-8?B?ZjlQV0FvUkc3cEc5YndGaHlZVGF1VllGbE83THZZUlZjQlpNNE9aS3M3bmZB?=
 =?utf-8?B?K25EdSttSU1TS0N3YktCRFdXdEhPdFFkU3BuKysyTUh3bzhaV2M4b3JlWm4w?=
 =?utf-8?B?TGdsREdqSlIyOGJveUJDK3R4WjVYK2Y4RkphTnVDSTkwYVpTa2lhMTNRNmMr?=
 =?utf-8?B?S0JoYThjVTVZY0dCRFRZREFDRjhqUlY2VDNOaWlpcUVNS0xaNWM0ZTBpYmhU?=
 =?utf-8?B?UTZxdk1Vc05ld1ZDWkJJT1NpUEtyRklhRUtxVlhMVHF3RG1Ya1V4bnFGUytm?=
 =?utf-8?B?U2lObHRRMTNBbE1iMk5IRllDZ1g2U21UalpsSFRDZjk4UjlhZ3I4VHZIRjN3?=
 =?utf-8?B?TXFXMHBVV0QyeHVxemJyM3NjTkE5c29uTmE0N0o1aHp5WGRpWWxPeXJHYnQy?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc5c36e-5258-424a-e965-08db8d0daaf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 12:50:04.5191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ii5isMQwQCEOT0IWaFuCpk+nOeaXOYGl8Hcs2yOeuj+DYtPoRDsMXY6Gx9swgiPPDL7V9Uj2GOADUV4QatenvWl+wPPzQxtqj0R1m0uRSNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7969
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCj4gDQo+IEhpIE1pcXVlbCwNCj4gPg0KPiA+IEhpIEFsZXhhbmRlciwNCj4gPg0KPiA+IGFs
ZXhhbmRlci51c3lza2luQGludGVsLmNvbSB3cm90ZSBvbiBNb24sIDI0IEp1bCAyMDIzIDExOjQz
OjU5ICswMDAwOg0KPiA+DQo+ID4gPiA+ID4gPiA+IFdpdGggdGhpcyBwYXRjaCBhcHBsaWVkLCB3
aGVuIEkgbG9hZCB1cCB0aGUgbW9kdWxlLCBJIGdldCB0aGUgc2FtZSAzDQo+ID4gPiA+ID4gPiA+
IGRldmljZXM6DQo+ID4gPiA+ID4gPiA+IC9kZXYvbXRkMA0KPiA+ID4gPiA+ID4gPiAvZGV2L210
ZDBybw0KPiA+ID4gPiA+ID4gPiAvZGV2L210ZGJsb2NrMA0KPiA+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gPiBVcG9uIHJlbW92YWwsIHRoZSBiZWxvdyAyIGRldmljZXMgc3RpbGwgaGFuZyBhcm91
bmQ6DQo+ID4gPiA+ID4gPiA+IC9kZXYvbXRkMA0KPiA+ID4gPiA+ID4gPiAvZGV2L210ZDBybw0K
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiBPdXIgdXNlLWNhc2UgZG8gbm90IHByb2R1Y2UgbXRkYmxv
Y2ssIG1heWJlIHRoZXJlIGFyZSBzb21lDQo+ID4gaW1iYWxhbmNlcw0KPiA+ID4gPiBvZiBnZXQv
cHV0Pw0KPiA+ID4gPiA+IEkgaGF2ZSBzb21ld2hlcmUgdmVyc2lvbiB3aXRoIHByX2RlYnVnIGFm
dGVyIGV2ZXJ5IGtyZWZfZ2V0L3B1dC4gVGhhdA0KPiA+IG1heQ0KPiA+ID4gPiBoZWxwIHRvIGNh
dGNoIHdoZXJlDQo+ID4gPiA+ID4gaXQgbWlzc2VkLCBJIGhvcGUuDQo+ID4gPiA+DQo+ID4gPiA+
IEkgYmVsaWV2ZSBtdGRibG9jayBpcyB0aGUgZ29vZCBjaXRpemVuIGhlcmUuIEp1c3QgZGlzYWJs
ZQ0KPiA+ID4gPiBDT05GSUdfTVREX0JMT0NLIGZyb20geW91ciBjb25maWd1cmF0aW9uIGFuZCB5
b3Ugd2lsbCBsaWtlbHkgb2JzZXJ2ZQ0KPiA+ID4gPiB0aGUgc2FtZSBpc3N1ZSwganVzdCBhIGJp
dCBuYXJyb3dlZCwgcGVyaGFwcy4gSW5kZWVkLCBpZiB5b3UgbWFuYWdlIHRvDQo+ID4gPiA+IGZv
bGxvdyBhbGwgdGhlIGdldC9wdXQgY2FsbHMgaXQgY2FuIGhlbHAgdG8gZmluZCBhbiBpbWJhbGFu
Y2UuDQo+ID4gPiA+DQo+ID4gPiA+IFRoYW5rcywNCj4gPiA+ID4gTWlxdcOobA0KPiA+ID4NCj4g
PiA+IE1pcXVlbCwgZG8geW91IGhhdmUgQ09ORklHX01URF9QQVJUSVRJT05FRF9NQVNURVIgc2V0
IGluIHlvdXINCj4gPiBjb25maWc/DQo+ID4NCj4gPiBOb3Qgc3VyZSBJIGdldCB5b3VyIHF1ZXN0
aW9uLiBZb3UgY2FuIGVuYWJsZSBvciBkaXNhYmxlIGl0LCBpdCBzaG91bGQNCj4gPiB3b3JrIGlu
IGJvdGggY2FzZXMgKHlldCwgdGhlIGhhbmRsaW5nIGlzIG9mIGNvdXJzZSBhIGJpdCBkaWZmZXJl
bnQgYXMNCj4gPiB0aGUgdG9wIGxldmVsIGRldmljZSB3aWxsIGJlIHJldGFpbmVkL25vdCByZXRh
aW5lZCkuDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gTWlxdcOobA0KPiANCj4gSSdtIHRyeWluZyB0
byB1bmRlcnN0YW5kIHdoeSBJIGNhbid0IHJlcHJvZHVjZSB0aGUgcHJvYmxlbSBpbiBteSBzY2Vu
YXJpby4NCj4gSSBmb3VuZCBhbiBpbXBvcnRhbnQgZGlmZmVyZW5jZSBpbiB1cHN0cmVhbWVkIHBh
dGNoIGFuZCBpbnRlcm5hbCB2ZXJzaW9uOg0KPiBUaGUgSVNfRU5BQkxFRChDT05GSUdfTVREX1BB
UlRJVElPTkVEX01BU1RFUikgY2hlY2sgYXJvdW5kDQo+IGtyZWZfZ2V0L3B1dCBkb2VzIG5vdCBl
eGlzdHMgaW4gdGhlIGludGVybmFsIHRyZWUuDQo+IFRoZSBjb2RlIGJlZm9yZSBteSBwYXRjaCBk
byBub3QgaGF2ZSBzdWNoIGNoZWNrLCBzbyBJIHRlbmQgdG8gYXNzdW1lIHRoYXQNCj4gdGhpcyBj
aGVjayBzaG91bGQgYmUgcmVtb3ZlZC4NCj4gSWYgeW91IHJlcHJvZHVjZSBoYXBwZW5zIHdpdGgg
Q09ORklHX01URF9QQVJUSVRJT05FRF9NQVNURVINCj4gZGlzYWJsZWQgdGhhdCBtYXkgZXhwbGFp
biBwcm9ibGVtcyB0aGF0IHlvdSBzZWUuDQo+IA0KPiAtLQ0KPiBUaGFua3MsDQo+IFNhc2hhDQo+
IA0KDQpJJ3ZlIHRyaWVkIHRvIHJlcHJvZHVjZSB0aGlzIHdpdGggbGF0ZXN0IExpbnV4IDYuNS1y
YzEgYW5kIG15IHR3byBwYXRjaGVzLg0KVGhlIG1hbnVhbCBtb2Rwcm9iZSBtdGRibG9jayBjcmVh
dGVzIG10ZGJsb2NrMCBvdmVyIG15IHBhcnRpdGlvbnMgdG9vLg0KSSBjYW4ndCByZXByb2R1Y2Ug
cHJvYmxlbSBuZWl0aGVyIHdpdGggTVREX1BBUlRJVElPTkVEX01BU1RFUiBub3Igd2l0aG91dC4N
Cg0KTGV0J3MgdHJ5IHRvIGRlYnVnIG9uIHlvdXIgc3lzdGVtLCBjYW4geW91IGVuYWJsZSBkeW5h
bWljIGRlYnVnIGZvciBtdGQgc3Vic3lzdGVtLA0KcmVwcm9kdWNlIGFuZCBwdWJsaXNoIGRtZXNn
Pw0KDQpUaGUgcHJpbnRzIGZvciBrcmVmIGdldC9wdXQgY2FuIGJlIGFkZGVkIGFzIGJlbG93Og0K
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvbXRkY29yZS5jIGIvZHJpdmVycy9tdGQvbXRkY29y
ZS5jDQppbmRleCAyNDY2ZWE0NjY0NjYuLjM3NDgzNTgzMTQyOCAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvbXRkL210ZGNvcmUuYw0KKysrIGIvZHJpdmVycy9tdGQvbXRkY29yZS5jDQpAQCAtMTI0Miwx
MCArMTI0MiwxMyBAQCBpbnQgX19nZXRfbXRkX2RldmljZShzdHJ1Y3QgbXRkX2luZm8gKm10ZCkN
CiAgICAgICAgfQ0KDQogICAgICAgIGtyZWZfZ2V0KCZtdGQtPnJlZmNudCk7DQorICAgICAgIHBy
X2RlYnVnKCJnZXQgbXRkICVzICVkXG4iLCBtdGQtPm5hbWUsIGtyZWZfcmVhZCgmbXRkLT5yZWZj
bnQpKTsNCg0KICAgICAgICB3aGlsZSAobXRkLT5wYXJlbnQpIHsNCi0gICAgICAgICAgICAgICBp
ZiAoSVNfRU5BQkxFRChDT05GSUdfTVREX1BBUlRJVElPTkVEX01BU1RFUikgfHwgbXRkLT5wYXJl
bnQgIT0gbWFzdGVyKQ0KKyAgICAgICAgICAgICAgIGlmIChJU19FTkFCTEVEKENPTkZJR19NVERf
UEFSVElUSU9ORURfTUFTVEVSKSB8fCBtdGQtPnBhcmVudCAhPSBtYXN0ZXIpIHsNCiAgICAgICAg
ICAgICAgICAgICAgICAgIGtyZWZfZ2V0KCZtdGQtPnBhcmVudC0+cmVmY250KTsNCisgICAgICAg
ICAgICAgICAgICAgICAgIHByX2RlYnVnKCJnZXQgbXRkICVzICVkXG4iLCBtdGQtPnBhcmVudC0+
bmFtZSwga3JlZl9yZWFkKCZtdGQtPnBhcmVudC0+cmVmY250KSk7DQorICAgICAgICAgICAgICAg
fQ0KICAgICAgICAgICAgICAgIG10ZCA9IG10ZC0+cGFyZW50Ow0KICAgICAgICB9DQoNCkBAIC0x
MzM1LDEyICsxMzM4LDE1IEBAIHZvaWQgX19wdXRfbXRkX2RldmljZShzdHJ1Y3QgbXRkX2luZm8g
Km10ZCkNCiAgICAgICAgd2hpbGUgKG10ZCAhPSBtYXN0ZXIpIHsNCiAgICAgICAgICAgICAgICBz
dHJ1Y3QgbXRkX2luZm8gKnBhcmVudCA9IG10ZC0+cGFyZW50Ow0KDQorICAgICAgICAgICAgICAg
cHJfZGVidWcoInB1dCBtdGQgJXMgJWRcbiIsIG10ZC0+bmFtZSwga3JlZl9yZWFkKCZtdGQtPnJl
ZmNudCkpOw0KICAgICAgICAgICAgICAgIGtyZWZfcHV0KCZtdGQtPnJlZmNudCwgbXRkX2Rldmlj
ZV9yZWxlYXNlKTsNCiAgICAgICAgICAgICAgICBtdGQgPSBwYXJlbnQ7DQogICAgICAgIH0NCg0K
LSAgICAgICBpZiAoSVNfRU5BQkxFRChDT05GSUdfTVREX1BBUlRJVElPTkVEX01BU1RFUikpDQor
ICAgICAgIGlmIChJU19FTkFCTEVEKENPTkZJR19NVERfUEFSVElUSU9ORURfTUFTVEVSKSkgew0K
KyAgICAgICAgICAgICAgIHByX2RlYnVnKCJwdXQgbXRkICVzICVkXG4iLCBtYXN0ZXItPm5hbWUs
IGtyZWZfcmVhZCgmbWFzdGVyLT5yZWZjbnQpKTsNCiAgICAgICAgICAgICAgICBrcmVmX3B1dCgm
bWFzdGVyLT5yZWZjbnQsIG10ZF9kZXZpY2VfcmVsZWFzZSk7DQorICAgICAgIH0NCg0KICAgICAg
ICBtb2R1bGVfcHV0KG1hc3Rlci0+b3duZXIpOw0KDQoNCi0tIA0KVGhhbmtzLA0KU2FzaGENCg0K
DQo=

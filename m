Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F1175F5A1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 14:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjGXMEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 08:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjGXMEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:04:42 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346341A1;
        Mon, 24 Jul 2023 05:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690200282; x=1721736282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=REQTdiLTLALApex//VBfTIss6xowNJdellWclGbsc1s=;
  b=k5ecNg1WrPBlFQ6fRfZtp9sRxn7moVwiz5W/mwg2b/K2llCx4t+kMDS6
   ZERfCMaUjnirF07JleZO4VryQcvlKE2+5RKEtcL5iRO6xsW/EC29AxXbW
   Q/chr3jrqvbFx7yA74GNWvyTxAri12ODPX8SVG9NfDZ0lRgiNlt7ftr2n
   j4fqz3H4TfXsNTE8OyK1emA18r/L/DZ4NMc4nwm5JnTt6Vmx0vT+VmXXH
   4h9LBw/8v2RYq5uqNi1lY0sYfuc9UAVfGtIpTsyCq6QldNUryGkuP1AQn
   y4b5vvOl0+zsAkvxWuERp7KylTvkuKCla5FvxzmGHRS6CIXSinUsU9abf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="366313116"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="366313116"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 05:04:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="899470732"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="899470732"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 24 Jul 2023 05:04:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 05:04:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 24 Jul 2023 05:04:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 24 Jul 2023 05:04:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHHYHFZt3FVGvl9OxP6ycJufA05Ohf/14O5L0RbYYFYxOiDZ0ySWIithTxkBD/nnjboRQ56eEUM/uPksmPiiFm+XeZReiOYeu+oqkvm7pFRG3L+o3jaPAFGHMcoJxWPMtZ4XlZkIug7FQvTOWl8mOIistqqfwDexdk244MeiFEadZuKGfUlIzixndXR+MyCKfy3CtieMFCb0tZNk+MVV7kfAYHdq9ju0qKlpNPWEvmMI87M8aBsdcUwXelWF3mZkkxscOQK90qZbqmJ/9gPcZg+t2CM5rqGAEer7EBa2OunaQbCkRUFNWqYdeFFAfFvStB2wbcfJjOwQagd2huPoFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REQTdiLTLALApex//VBfTIss6xowNJdellWclGbsc1s=;
 b=FwcM21duZHXRlN5bOPqUSvoZTUqkTWA6QdGDb46BNUjZEwZUg9ger+QEZqE25pdgG85oKfyvz9jWjdH4HdxYjobkKsRWgPA8lvrhhSfMfhEWrf+S0AVVuwhS2WV5/GHwEgPIjpV3khhkaNAdD8NdSQ71xi5ppNlS3UBqY1lKBG7XvkhTasewKh/Mlvj6GJuaKMEfIxB8SKCsltmpn7NonacAUYInx25c1VuN6hQ0KZfPRu4fw+2LJagOhwj4QLCXfN1KSZKoswOkEPBIga/EOW6J+u+HOS3dtvjuIOkaFtXaliaNNx64a7NJ3W5jpMfDodPsnmiOgOhaLcyM87CbMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by DM4PR11MB7351.namprd11.prod.outlook.com (2603:10b6:8:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Mon, 24 Jul
 2023 12:04:38 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::f8a8:855c:2d19:9ac1]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::f8a8:855c:2d19:9ac1%7]) with mapi id 15.20.6609.025; Mon, 24 Jul 2023
 12:04:38 +0000
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
Thread-Index: AQHZo3n2ZB8U6WhTx0+aElx0ckVEpq+5lImAgAGKEwCAAPTUYIAAe3sAgAxtDQCAAAdkAIAAAWCw
Date:   Mon, 24 Jul 2023 12:04:38 +0000
Message-ID: <CY5PR11MB6366FB890508D05E1D1C1375ED02A@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20230620131905.648089-1-alexander.usyskin@intel.com>
        <20230620131905.648089-2-alexander.usyskin@intel.com>
        <TYWPR01MB87756794A30EB389AB017EB1C234A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
        <20230715174112.3909e43f@xps-13>
        <CY5PR11MB63666C8DA33C93E1DC3BCB21ED3AA@CY5PR11MB6366.namprd11.prod.outlook.com>
        <20230716153926.5e975231@xps-13>
        <CY5PR11MB6366C254F767B6C432C98A0CED02A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <20230724135118.54e39faf@xps-13>
In-Reply-To: <20230724135118.54e39faf@xps-13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|DM4PR11MB7351:EE_
x-ms-office365-filtering-correlation-id: 33aff8cd-4552-4c4b-aefc-08db8c3e2781
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qS0byd07rgmknM/gES54WWNgrfmBAyIT0/DYlVvjxMrwFk9b2YS4tUZdWuTi0XAWtUcMP6JTNMegV5JEoFMNN/9FS5uxrxDExEFcd2msGFHaBQlZhIqGu4a7jrkSoJ9lAFEOb0amiqxrwKvo+9WpR9Ktj/mOa73uLSByII5JSrNbqi8PMd6WpX03jvVDJ1cpAezOTozRvTr9+KK0UNstDyK32MOG4FgGdQ4YNNOu6EFkYHJLjhkg7160nXBp2sk2IY28qcSSk8NFK5bFba+OTRiny//rqDn32oEDqGh9J+p/2wv07GGB/pwyvGJb3Wf55rZjReQa1tE4PsGbzVZGF9j5UbriBnBBjL4/IEvf/+BudIP0vbibUxXqJ5fpCA4Jhj0qMie55C7NMVok1cbwk/NcV1FmpMEIGJyq/TVG5OXmHhXGNpnbn81h8QXVct6x7znl6RlDzKU4e6FQ/8+L2duKnrxzNpF57ddKfKsRT8559BTFbqKgfKxKqAoOx9L4pvA7+H43Sqvevpd+GVpEl8E7B02E+NPdkJ20oXU6KaPS6QJfuj/CFmMTPkSZGSC6LTu1sJR6sfz724cjLbjuJ8KbFtx61BByabNVwBLeh3VnDIqS6o0Ffk5inwM/ULuH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199021)(41300700001)(6506007)(33656002)(186003)(83380400001)(478600001)(66574015)(26005)(71200400001)(38070700005)(55016003)(9686003)(2906002)(7696005)(86362001)(7416002)(5660300002)(52536014)(66556008)(64756008)(66476007)(66946007)(76116006)(122000001)(4326008)(6916009)(66446008)(8936002)(8676002)(316002)(82960400001)(38100700002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmRUUnJBM3JMSm1uTG85emNmOFc5b0VHUTVWQ0d5M1JsdjVhMGxLakhKd01H?=
 =?utf-8?B?bzgrbThXeEZoS0hZbzRuTzNCdnRCRkJMcXNGZDRQazV3bHhmd0JtWGRKbHkz?=
 =?utf-8?B?U0tpazNNZ2xEWEc3NVdwQW93TGZOL2hDZGxIbHBjUHh4Y1ppWmVCaTN5UlMv?=
 =?utf-8?B?OC9ZdlB4RXJjdXRSUVI3MnNxN09pSncyTlpjaHNXRjNLbyt6R09SUHpES3Yz?=
 =?utf-8?B?NGYyVDRkRkUya0JiTzQrUWlxdHNkZ0hCRWpFM2g2UEZsaExnTDRCWDhaRkww?=
 =?utf-8?B?SDJtRG1IQ2dsdVF6cURzN0d4M2F1c0lrK05NTnNFVmkxMTk0b253c2JXTGNz?=
 =?utf-8?B?eVQ3Z2U2U3J6QnN3UldzeEkzU2lWbHg5THBwYUhwaHExZHlpdGo2TkM1dk1v?=
 =?utf-8?B?MW9yVmpTeFg1UDJ2S1JTaVNGa3B2KzhLaDJUMSsvemV0ZlJ4alBiSk12VUNy?=
 =?utf-8?B?S3d6NFpoenJJNEgrM25rYVRvUXlGczh5T1JzTEl4OEJ4NUIvR2dOSGxBMHNu?=
 =?utf-8?B?bnAvTHdYUE5NdUV3R2piMGEwVjVKLzRoSEl4R0RMakNWT1BrUkJMVEl3U0kx?=
 =?utf-8?B?QXJEZUhWM0FGZjE4NnVRTkYvK0x1YWh0YWNEYjU5Vml3U3pJbDk0OUxNZVg1?=
 =?utf-8?B?U0Fad3A0NGw3eGExVHAvUkpwaGJWWG1tNGEzWEJaQzdZbnBsQTFUTDljUDZR?=
 =?utf-8?B?aFBGbWNFTGU0ZnNGVGU0K01XL0RDNlUvbVpOZ1N2RWllRWozeEdtT21pMEJV?=
 =?utf-8?B?djJDVXlqUkpYM1NLakNNSDQ0emtsMHFNM2JybGJocktMVFlzUVBJdzM4ZzN0?=
 =?utf-8?B?RkJzdklEUUsvYndpQ0IvRXJWQXByaXJ0aE5tT1Z0SGZweGZ2TE5NZDZISDB6?=
 =?utf-8?B?cGZ6QXI1bWR6SUlaOVErY29GTER5T0NiaEZlYkV5Rm55dG94SGUrdElRTE81?=
 =?utf-8?B?WDhwbk11djYvTlZDUUpsaWVYdm1tRXhFRU95U2c3eW9ybXRmSVVtTXhjWWw1?=
 =?utf-8?B?MDROQmNaZElsSE1Hb01GTnVvMmgzNm5RaHZBVm1RSktiZVJzMnlueEFvMjVW?=
 =?utf-8?B?aU1mZzlLN21aVjlBRlByaDVDQzcvZVZSUUNMSCtiVGZwNXRYNHgzcDF6MUdH?=
 =?utf-8?B?d2J6R3hCT09zRVFudXlaaUtpVHJudFpYMHZTSmdvQnQrVWdueTJPbFNIRE1J?=
 =?utf-8?B?RWpjdUVJOGdwZGFFZGRxODl6bUppTi80ZVJOTjdFcnZsbDhrTkRUNVRtMTJN?=
 =?utf-8?B?dXY2RVM3NUk0anJSNExVZU04cnE3SWVOdGxYczhBYWx3S3JTNHlNcVJLeHkv?=
 =?utf-8?B?ZW9XZHVhcW5nSWQ0bTBqT204RDRubGRIQmh0aENVTHZMemdUTlF0Q0ZQZG8z?=
 =?utf-8?B?cWhRM2JMTit0MnFVWmhRKy80eXV4L21wb3BCVzYzYzgzRkhpNWRGZEpLSjQ4?=
 =?utf-8?B?K1lxYmtiZkQxZVhjYThDaUZPSkxtZnhXZ1dQS3dmdHY2d292TzB6YlBhUEZM?=
 =?utf-8?B?Wk12RUVvbFBWVTFiV2h0N3lkREc2V2hoVVExZTV1QkxCRnJzTUpodFBMenhj?=
 =?utf-8?B?RUIxS1ZpOXR2T2xyZ2RGbEFwQm4rSU9ZdzRpTW1DdGlxZ05sN1IrY1pjNFpm?=
 =?utf-8?B?NWFUYmJIaEI0cjRvNUxKRDdZSWY1bG5kY1hJOGtDZCsyY1FkYXFVMzQyZ1Jz?=
 =?utf-8?B?NzRmWjdMcTJDNU9YZm1EWXlWczVLSW9QTXlmTnkwTlFsTWZxVFNPZ3hFSjZx?=
 =?utf-8?B?Q3RuQUREQnM5bVNRMFlOQTg5OTd3YkRBY0k3ZGNidm1tZG51QkNHanZKTitJ?=
 =?utf-8?B?YlZJS2pFZW9HWURRR2lzbFRqN3NlZ1JQOGdORmZnVW9PTEY5aFhmOGZRaFF2?=
 =?utf-8?B?N3VVQUhheFJTcG9oNlpsMEtCMlJUYkpJeXBnT1VCTURwdjExMEpHcXpBbStG?=
 =?utf-8?B?WDZOT3RFRWxLT0RtUHpseUhpLzQvLzN1cE5SeC94WDJUOVJ2K1MrelR3akp0?=
 =?utf-8?B?dE52MG92RXA3TVFzS0lEZHVuc1RnUkFBZGtYYVI0UUNjMFdZQURyS1E3citm?=
 =?utf-8?B?M3lOMHRZdWJwelcra3lValRlZUNBTU44K1RXZmk3WnhPWml5YmxHQW4vZTNT?=
 =?utf-8?B?d1ZqN2pGM0VYRTlsSUVuN3hMTC9XRDVqVCtZckRKaml2R1NxRk1YazBCR2pU?=
 =?utf-8?B?R0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33aff8cd-4552-4c4b-aefc-08db8c3e2781
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 12:04:38.1310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kwT+So4V4rzdYK8DLqXuuRgetMuGfJ4VDgQA6cOgMqwzp4Wpt7tZuHADEo6n8X7FAahZ5e6rzN0ZnIjzw5abRmyvynoQ/Z94HYPpIFQHrv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7351
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

SGkgTWlxdWVsLA0KPiANCj4gSGkgQWxleGFuZGVyLA0KPiANCj4gYWxleGFuZGVyLnVzeXNraW5A
aW50ZWwuY29tIHdyb3RlIG9uIE1vbiwgMjQgSnVsIDIwMjMgMTE6NDM6NTkgKzAwMDA6DQo+IA0K
PiA+ID4gPiA+ID4gV2l0aCB0aGlzIHBhdGNoIGFwcGxpZWQsIHdoZW4gSSBsb2FkIHVwIHRoZSBt
b2R1bGUsIEkgZ2V0IHRoZSBzYW1lIDMNCj4gPiA+ID4gPiA+IGRldmljZXM6DQo+ID4gPiA+ID4g
PiAvZGV2L210ZDANCj4gPiA+ID4gPiA+IC9kZXYvbXRkMHJvDQo+ID4gPiA+ID4gPiAvZGV2L210
ZGJsb2NrMA0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFVwb24gcmVtb3ZhbCwgdGhlIGJlbG93
IDIgZGV2aWNlcyBzdGlsbCBoYW5nIGFyb3VuZDoNCj4gPiA+ID4gPiA+IC9kZXYvbXRkMA0KPiA+
ID4gPiA+ID4gL2Rldi9tdGQwcm8NCj4gPiA+ID4gPg0KPiA+ID4gPiBPdXIgdXNlLWNhc2UgZG8g
bm90IHByb2R1Y2UgbXRkYmxvY2ssIG1heWJlIHRoZXJlIGFyZSBzb21lDQo+IGltYmFsYW5jZXMN
Cj4gPiA+IG9mIGdldC9wdXQ/DQo+ID4gPiA+IEkgaGF2ZSBzb21ld2hlcmUgdmVyc2lvbiB3aXRo
IHByX2RlYnVnIGFmdGVyIGV2ZXJ5IGtyZWZfZ2V0L3B1dC4gVGhhdA0KPiBtYXkNCj4gPiA+IGhl
bHAgdG8gY2F0Y2ggd2hlcmUNCj4gPiA+ID4gaXQgbWlzc2VkLCBJIGhvcGUuDQo+ID4gPg0KPiA+
ID4gSSBiZWxpZXZlIG10ZGJsb2NrIGlzIHRoZSBnb29kIGNpdGl6ZW4gaGVyZS4gSnVzdCBkaXNh
YmxlDQo+ID4gPiBDT05GSUdfTVREX0JMT0NLIGZyb20geW91ciBjb25maWd1cmF0aW9uIGFuZCB5
b3Ugd2lsbCBsaWtlbHkgb2JzZXJ2ZQ0KPiA+ID4gdGhlIHNhbWUgaXNzdWUsIGp1c3QgYSBiaXQg
bmFycm93ZWQsIHBlcmhhcHMuIEluZGVlZCwgaWYgeW91IG1hbmFnZSB0bw0KPiA+ID4gZm9sbG93
IGFsbCB0aGUgZ2V0L3B1dCBjYWxscyBpdCBjYW4gaGVscCB0byBmaW5kIGFuIGltYmFsYW5jZS4N
Cj4gPiA+DQo+ID4gPiBUaGFua3MsDQo+ID4gPiBNaXF1w6hsDQo+ID4NCj4gPiBNaXF1ZWwsIGRv
IHlvdSBoYXZlIENPTkZJR19NVERfUEFSVElUSU9ORURfTUFTVEVSIHNldCBpbiB5b3VyDQo+IGNv
bmZpZz8NCj4gDQo+IE5vdCBzdXJlIEkgZ2V0IHlvdXIgcXVlc3Rpb24uIFlvdSBjYW4gZW5hYmxl
IG9yIGRpc2FibGUgaXQsIGl0IHNob3VsZA0KPiB3b3JrIGluIGJvdGggY2FzZXMgKHlldCwgdGhl
IGhhbmRsaW5nIGlzIG9mIGNvdXJzZSBhIGJpdCBkaWZmZXJlbnQgYXMNCj4gdGhlIHRvcCBsZXZl
bCBkZXZpY2Ugd2lsbCBiZSByZXRhaW5lZC9ub3QgcmV0YWluZWQpLg0KPiANCj4gVGhhbmtzLA0K
PiBNaXF1w6hsDQoNCkknbSB0cnlpbmcgdG8gdW5kZXJzdGFuZCB3aHkgSSBjYW4ndCByZXByb2R1
Y2UgdGhlIHByb2JsZW0gaW4gbXkgc2NlbmFyaW8uDQpJIGZvdW5kIGFuIGltcG9ydGFudCBkaWZm
ZXJlbmNlIGluIHVwc3RyZWFtZWQgcGF0Y2ggYW5kIGludGVybmFsIHZlcnNpb246DQpUaGUgSVNf
RU5BQkxFRChDT05GSUdfTVREX1BBUlRJVElPTkVEX01BU1RFUikgY2hlY2sgYXJvdW5kIGtyZWZf
Z2V0L3B1dCBkb2VzIG5vdCBleGlzdHMgaW4gdGhlIGludGVybmFsIHRyZWUuDQpUaGUgY29kZSBi
ZWZvcmUgbXkgcGF0Y2ggZG8gbm90IGhhdmUgc3VjaCBjaGVjaywgc28gSSB0ZW5kIHRvIGFzc3Vt
ZSB0aGF0IHRoaXMgY2hlY2sgc2hvdWxkIGJlIHJlbW92ZWQuDQpJZiB5b3UgcmVwcm9kdWNlIGhh
cHBlbnMgd2l0aCBDT05GSUdfTVREX1BBUlRJVElPTkVEX01BU1RFUiBkaXNhYmxlZCB0aGF0IG1h
eSBleHBsYWluIHByb2JsZW1zIHRoYXQgeW91IHNlZS4NCg0KLS0gDQpUaGFua3MsDQpTYXNoYQ0K
DQoNCg0K

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F343380059A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377822AbjLAIcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjLAIcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:32:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3758B1711;
        Fri,  1 Dec 2023 00:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701419529; x=1732955529;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NIPweBoSV+niOpfQ1yHQkb0CN60LBfQyPvE3FJ/r0w0=;
  b=hpf40YYATGg9fsPW438/4cPvTtxru3fkwxV5pICk+h5mwDxPj8rMTDNX
   f4hRv60WJrjpUEX8NCOmMogSWTtRPRL1Ns8r4vx8tnsBX/TSE2NMrXeRS
   NQK3izOkugRPr0o6FWQ9SITgmq/h5j6mYAptxCWJItyn7bka/LYUmqOMX
   oZ7elHZotHp/jPABTcQky/51XAoWWeuLpSugRV3aQHZe4/fNtlNlByMtM
   aFmBRgcyxj2hCDrr37RceAzSvL7fhqKkL4T80C4Z13mn2XTWpbQoa+Hm6
   MKPhqfToqv/6a/2iqrg5khX40FwY24zIX6rBsVD9a5nVjyxPf/CfDfaJ6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="397353118"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="397353118"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 00:32:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="769606018"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="769606018"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Dec 2023 00:31:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 00:31:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 00:31:50 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 1 Dec 2023 00:31:50 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 1 Dec 2023 00:31:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLqmiaehQV2hC6qgQE/p8JNahl6ERPBed2jlTYMbqT2qd0/IbI4IFm2LLfkgvpOQwgTj/hWhIcxkInW1Vbr5nehfLwipDQAmxTcGpgXbP//9caI9ypjFCcB8vU4Rlq2tc7gVYANpNd/0J1Ly1RhfyYimezrjuENXsKMSeCpqmgofZFienT2d9JXjAYGSX4dTkT8tj0NoUJO8t4wj01cJPYHaejVaft765Ezt+hsifjoVxiaRDh5rh+9xNt+euiIgsPThWe7dLe3vPYR17Pa1Lq0cM1N4PPWDDcuj4pLWt3tNz1DZy/vQn1EqBCGHPxfbc0c5MllDzn7K5XHA3T8WLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIPweBoSV+niOpfQ1yHQkb0CN60LBfQyPvE3FJ/r0w0=;
 b=OHR7IolZhPSp+P65ewnxzcdglrq1zCHs+Q3e7PaJmZmIWNCncqP0xpA/SOTjM8ugKmdvyesT9nFdXBuLLMeLYiF5EYozwx++Wp72Na497F1vm2HxYfMZYDg7/CLvYVQAg6VwhdksefnYGHugv1eVdAZEGdV7QnBKkudlG3iYaeWCmHTHdK1V2CrC2FClsG578KT44qF88+IuBAqOXSF/1R9yK1T3qU7f8h6GJe5GJuWzGLMDoOw1Gs0XE2zexg5WYqPiq/Gbw8/CFyNOz6pPtiyUy1BWEycWSg/qdsKXHZE3HwwLit1VU31g3S1ItQlLcOVVpcTgSU8cwmefOGDG1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SJ2PR11MB8472.namprd11.prod.outlook.com (2603:10b6:a03:574::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Fri, 1 Dec
 2023 08:31:48 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e10c:91d7:d34b:aa1d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e10c:91d7:d34b:aa1d%6]) with mapi id 15.20.7025.022; Fri, 1 Dec 2023
 08:31:48 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "jsperbeck@google.com" <jsperbeck@google.com>,
        "tip-bot2@linutronix.de" <tip-bot2@linutronix.de>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [tip: x86/urgent] x86/acpi: Ignore invalid x2APIC entries
Thread-Topic: [tip: x86/urgent] x86/acpi: Ignore invalid x2APIC entries
Thread-Index: AQHaExJ8HYCIhq0C9kqRsYucn9Sz1LCG/duAgADzWYCADEpKAA==
Date:   Fri, 1 Dec 2023 08:31:48 +0000
Message-ID: <904ce2b870b8a7f34114f93adc7c8170420869d1.camel@intel.com>
References: <169953729188.3135.6804572126118798018.tip-bot2@tip-bot2>
         <20231122221947.781812-1-jsperbeck@google.com>
         <1e565bb08ebdd03897580a5905d1d2de01e15add.camel@intel.com>
In-Reply-To: <1e565bb08ebdd03897580a5905d1d2de01e15add.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SJ2PR11MB8472:EE_
x-ms-office365-filtering-correlation-id: 2051aa7a-0090-4e31-3110-08dbf247f5ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a0ikZAkDxnfBZiBXFf/Vbuvi8kusewLwQDgEUFrRueRfCwlt57WTriU40E+fBZBj0WrZDffHlNlnCV6uPkZxThpT75Q1DAY7JdgDQPo/r+fwXEgpGqUVnhZlNN9I860gcaB7H/R7tpBqe/Usi3oFbB0dWBkjWEW70+E6o9TzZSWrPjST759N5rTzAdNI8MOuJJkipniA79Ua1D2WKIh1dtZUFVa8bTswdnY8cNwpLnzLau8RDAqmaLzYnG0CBfPqVzo5rLytMRjc6j0GA7fCnABXQBab5WextYBTqBBhbaa4CbzZDPdyJi1gcQsc8HyET/PzuhmJlDMAfsu0FNTbYgckUziJL5OOG9+GrCaSKCF7/LGvwvycXVqBZ+zeT1n+uxhBCDpM19kaf4Ws62JfmsWm6lSWFXSfh1jnmJh/ehF3JJ04UHsLaCH0x5MBqic8X5OPemBwcUgseDTDLGWY/DNd1U3nFCWiI7O0Em5WS5tHuTAjEcSCH4VC/J7RyOdGv2jT4WVTqTSjvEQvxMABVxIAH6lZsz9nO4M7GQ0YUW7vSKxfDrEaa+mpS5uNxgXe9kW1vcJ6zQqOrys0QxXTrFUsEfM4EuhTp2hVNxdhab3LwpP67If1T0C/hOzi03zLZji4bIjyk0YcTyGbNGJqjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(83380400001)(26005)(2616005)(53546011)(38070700009)(66556008)(76116006)(66446008)(66476007)(316002)(64756008)(66946007)(54906003)(110136005)(86362001)(91956017)(2906002)(8936002)(4326008)(8676002)(5660300002)(4001150100001)(966005)(41300700001)(71200400001)(6506007)(478600001)(6512007)(6486002)(82960400001)(122000001)(36756003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWNjV3hjN3dmVmJSeXkybHV0VjBSbzRtU3RBY3dPT0dEV0xBSHNCak00L2ZU?=
 =?utf-8?B?QjM2QTF2S2hRWUhtYXVLWHBZY05iV3oxcE9FdVE5aUZpVWhhc1RBaGxydFdm?=
 =?utf-8?B?algzaHBlYW0wdmcyRGlMN2dCYzM5MERqOXkwbU44R3ZoOXBYRTV6amVvbVdt?=
 =?utf-8?B?eVB4V0VzeWlHNms4NkEySE9sR2xzMTY0YUNSY1diYTEwb3NjNUpOeHNib0ZL?=
 =?utf-8?B?UFJVbGhBNk5VVzJUemtVQlpzTmFrNXhBQTJvV3UwZTBBQnBWOXhRVGZSTER6?=
 =?utf-8?B?c2hidUo3ejNuK2VNTWV2TlRBbUhZaDJVQVdIMHFIZEs0RjJucllmTU04eDJK?=
 =?utf-8?B?SzJlOHlObmc2RVdkNWxaSm93QU9hVE0ySTZzRXNpWkpyZEFvOVR3cDJFb2N2?=
 =?utf-8?B?dHFoVGJOa1hwUlRlemhFcXFIUFd0NG5tNFo5aWRCc2JBOU1sMi9oM0cvS3lE?=
 =?utf-8?B?V2hIOXQwUDBYczlpR2MzMFV3SWZjb0ttcUVadU1pcEEybGdRajM1eW5Fa0cx?=
 =?utf-8?B?UytYMVYvSGgrMHpnYWkxc1M0SkpVdnBuRW5Wc2thYzlxMVI3YTdTUXMza2cr?=
 =?utf-8?B?YTluS3d5akpkYitjSGNyZkdBZUJrMzZrYklHR1d4TWpxZjhia3FHRVRjSzF3?=
 =?utf-8?B?NmdjWngrdnhhNU84WElsZWY1RFNqU3ZrUDI3ank1YjMyaTdZb0RYV2dFUzRP?=
 =?utf-8?B?YWllM3kzaWhCMTJHMU1jVzduQ3U4bmtTcTd2UWZaZ0g5OVFaay85VnVBOVB4?=
 =?utf-8?B?cmc5VzJ0eVVuQWZrTnBZYVJnaXpRQitjZXVFcFVwS0VFSC8ybU5OK0dGa1g5?=
 =?utf-8?B?cVNWUUdTcWhUakQ3WnRNVlVwNnF4OE9tNDNQeGlOdlIrTTBEWS9hd1BheTJR?=
 =?utf-8?B?TksxRkZhSXVRTEhqTXRNUjBLaFcva1pLVnMxcTRWK0QrTW5BaVRBamNXbFZ1?=
 =?utf-8?B?SEJyOXkyMHIvWmJBR3Y5dytxd0hNNHJnWnRNaWovNFUwb2dnYmdrODRmdjdZ?=
 =?utf-8?B?b2lCYVdpRWRWbXQ0Skd6YXV3bldnVUh2Q1lnQ1EraFFkTVlySUdNK2UwdWN4?=
 =?utf-8?B?NHNyaHpvTGU0MGdKQXAwcjBBeEtOS29ESVpNcXRqallVM055OVo4WkUxUXky?=
 =?utf-8?B?dkNhU1h3M2czamRMdHhTSVpJdlNZT2tOUG40cHYwaFBLWkc1YkpqNmVkSEh2?=
 =?utf-8?B?QzVmZmlmbXJ0WVE0TzZ3N3ExYVYzRFlKQTMwSWNZSzZJVE5Kdk9GbnF1b2li?=
 =?utf-8?B?TEdxZGZDdUtsRmFQZlR6TmI1emZPVHRBSTVVOEhYdE1IU2xvaGVwSXRUZzFy?=
 =?utf-8?B?RDVQb3ZBeFk3NUMyWVNjTTg5dTYzOXdCMGtZak5Bc1BieEpzb1ZLOWhOekxs?=
 =?utf-8?B?eWhIbGhMSzl1Q01HYXk0SE5tcElaWWdFNWw1Um9BL2YzT3l3RVp5Q0JLSEFw?=
 =?utf-8?B?TkVXUGh5UHd5dDcwdlNseVVjUWhIMG0vODJDY2h0STBiU0FMeHhYVXJ0c3dj?=
 =?utf-8?B?dWZ2ZjI4YU5wTGRqOTVpMWVLY2JLbHJHdEZNM2piRGd2Q1FvL0NhTzJtRkJy?=
 =?utf-8?B?RFFVcDFvVjRlT1lKMUk1a0RFZXlYTkZ1R0pIci94RC9pYVFLQWVYbEFrR28r?=
 =?utf-8?B?THBlRy83TURHcXF4RkczWHJldy8xS0FiWkFTOE82cUNHamhlWWhXci9MSmhV?=
 =?utf-8?B?c1BsVVBCOURyT0trZG1EZTJPQUlrNDV2YXd6UHRLbHpBUEcybnkyZGxYdW43?=
 =?utf-8?B?Q0M2M0NSTUlyejFOK0Z3UlBuM21Sd1NoT0paQUJWU0JUQ2l0Y29hUXlkUFBO?=
 =?utf-8?B?YTM3Y2ljRXdIUkUxaDZ0YXFCdDBjWjRhWEtNUml0djBlQU9UWjh3U1F5bEZL?=
 =?utf-8?B?NFAreDY1VkhFSlhyaXB2bDdRVXgrYjY3N3ZTNk5maW5vY21TdFF2WElPdVVl?=
 =?utf-8?B?cWhLdXh0bVg3MVF5Vkp6dkZSdGpqRlFiaWk3TCtrdmdMcFdKNTlaOWEwRVZB?=
 =?utf-8?B?SUYzV0lERDhBYUQvOTE2ZkxpanhLcTNBcU5qRUpLcDBuejQ5aGlQQUlaT0RU?=
 =?utf-8?B?WTFzNUcxMmxiaDB5SnBhWGE0SndyLzVBdTBXOW04ejBKQW9kQ1AzZ2VlQmk1?=
 =?utf-8?Q?+BvYXTro2opAX5OEmHcmUjn+K?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1E14788B0AA3C45AC001FB5A94BA81B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2051aa7a-0090-4e31-3110-08dbf247f5ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 08:31:48.1368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c/PdDYRj7fhRpb3DQ0RskBnBssSC44nH9cDzgAd8ynkxXPgmdn6njYWmTpyr+DD2J1ctT5hK7etN0yuZ5Db3Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8472
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

T24gVGh1LCAyMDIzLTExLTIzIGF0IDIwOjUwICswODAwLCBFeGNoYW5nZSBPbmxpbmUgd3JvdGU6
DQo+IEhpLCBKb2huLA0KPiANCj4gVGhhbmtzIGZvciBjYXRjaGluZyB0aGlzIGlzc3VlLg0KPiAN
Cj4gT24gV2VkLCAyMDIzLTExLTIyIGF0IDIyOjE5ICswMDAwLCBKb2huIFNwZXJiZWNrIHdyb3Rl
Og0KPiA+IEkgaGF2ZSBhIHBsYXRmb3JtIHdpdGggYm90aCBMT0NBTF9BUElDIGFuZCBMT0NBTF9Y
MkFQSUMgZW50cmllcyBmb3INCj4gPiBlYWNoIENQVS7CoCBIb3dldmVyLCB0aGUgaWRzIGZvciB0
aGUgTE9DQUxfQVBJQyBlbnRyaWVzIGFyZSBhbGwNCj4gPiBpbnZhbGlkIGlkcyBvZiAyNTUsIHNv
IHRoZXkgaGF2ZSBhbHdheXMgYmVlbiBza2lwcGVkIGluDQo+ID4gYWNwaV9wYXJzZV9sYXBpYygp
DQo+ID4gYnkgdGhpcyBjb2RlIGZyb20gZjNiZjFkYmU2NGI2ICgieDg2L2FjcGk6IFByZXZlbnQg
TEFQSUMgaWQgMHhmZg0KPiA+IGZyb20NCj4gPiBiZWluZw0KPiA+IGFjY291bnRlZCIpOg0KPiA+
IA0KPiA+IMKgwqDCoCAvKiBJZ25vcmUgaW52YWxpZCBJRCAqLw0KPiA+IMKgwqDCoCBpZiAocHJv
Y2Vzc29yLT5pZCA9PSAweGZmKQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7
DQo+ID4gDQo+ID4gV2l0aCB0aGUgY2hhbmdlIGluIHRoaXMgdGhyZWFkLCB0aGUgcmV0dXJuIHZh
bHVlIG9mIDAgbWVhbnMgdGhhdA0KPiA+IHRoZQ0KPiA+ICdjb3VudCcgdmFyaWFibGUgaW4gYWNw
aV9wYXJzZV9lbnRyaWVzX2FycmF5KCkgaXMgaW5jcmVtZW50ZWQuwqAgVGhlDQo+ID4gcG9zaXRp
dmUgcmV0dXJuIHZhbHVlIG1lYW5zIHRoYXQgJ2hhc19sYXBpY19jcHVzJyBpcyBzZXQsIGV2ZW4N
Cj4gPiB0aG91Z2gNCj4gPiBubyBlbnRyaWVzIHdlcmUgYWN0dWFsbHkgbWF0Y2hlZC4NCj4gDQo+
IFNvIGluIGFjcGlfcGFyc2VfbWFkdF9sYXBpY19lbnRyaWVzLCB3aXRob3V0IHRoaXMgcGF0Y2gs
DQo+IG1hZHRfcHJvY1swXS5jb3VudCBpcyBhIHBvc2l0aXZlIHZhbHVlIG9uIHRoaXMgcGxhdGZv
cm0sIHJpZ2h0Pw0KPiANCj4gVGhpcyBzb3VuZHMgbGlrZSBhIHBvdGVudGlhbCBpc3N1ZSBiZWNh
dXNlIHRoZSBmb2xsb3dpbmcgY2hlY2tzIHRvDQo+IGZhbGwNCj4gYmFjayB0byBNUFMgbW9kZSBj
YW4gYWxzbyBicmVhay4gKElmIGFsbCBMT0NBTF9BUElDIGVudHJpZXMgaGF2ZQ0KPiBhcGljX2lk
IDB4ZmYgYW5kIGFsbCBMT0NBTF9YMkFQSUMgZW50cmllcyBoYXZlIGFwaWNfaWQgMHhmZmZmZmZm
ZikNCj4gDQo+ID4gwqAgVGhlbiwgd2hlbiB0aGUgTUFEVCBpcyBpdGVyYXRlZA0KPiA+IHdpdGgg
YWNwaV9wYXJzZV94MmFwaWMoKSwgdGhlIHgyYXBpYyBlbnRyaWVzIHdpdGggaWRzIGxlc3MgdGhh
biAyNTUNCj4gPiBhcmUgc2tpcHBlZCBhbmQgbW9zdCBvZiBteSBDUFVzIGFyZW4ndCByZWNvZ25p
emVkLg0KPiA+IA0KPiA+IEkgdGhpbmsgdGhlIG9yaWdpbmFsIHZlcnNpb24gb2YgdGhpcyBjaGFu
Z2Ugd2FzIG9rYXkgZm9yIHRoaXMgY2FzZQ0KPiA+IGluDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGttbC84N3BtNGJwNTR6LmZmc0B0Z2x4L1QvDQo+IA0KPiBZZWFoLg0KPiANCj4gQnV0
IGlmIHdlIHdhbnQgdG8gZml4IHRoZSBwb3RlbnRpYWwgaXNzdWUgYWJvdmUsIHdlIG5lZWQgdG8g
ZG8NCj4gc29tZXRoaW5nIG1vcmUuDQo+IA0KPiBTYXkgd2UgY2FuIHN0aWxsIHVzZSBhY3BpX3Rh
YmxlX3BhcnNlX2VudHJpZXNfYXJyYXkoKSBhbmQgY29udmVydA0KPiBhY3BpX3BhcnNlX2xhcGlj
KCkvYWNwaV9wYXJzZV94MmFwaWMoKSB0bw0KPiBhY3BpX3N1YnRhYmxlX3Byb2MuaGFuZGxlcl9h
cmcgYW5kIHNhdmUgdGhlIHJlYWwgdmFsaWQgZW50cmllcyB2aWENCj4gdGhlDQo+IHBhcmFtZXRl
ci4NCj4gDQo+IG9yIGNhbiB3ZSBqdXN0IHVzZSBudW1fcHJvY2Vzc29ycyAmIGRpc2FibGVkX2Nw
dXMgdG8gY2hlY2sgaWYgdGhlcmUNCj4gaXMNCj4gYW55IENQVSBwcm9iZWQgd2hlbiBwYXJzaW5n
IExPQ0FMX0FQSUMvTE9DQUxfWDJBUElDIGVudGlyZXM/DQo+IA0KDQpIaSwgSm9obiwNCg0KQXMg
YSBxdWljayBmaXgsIEknbSBub3QgZ29pbmcgdG8gZml4IHRoZSAicG90ZW50aWFsIGlzc3VlIiBk
ZXNjcmliZXMNCmFib3ZlIGJlY2F1c2Ugd2UgaGF2ZSBub3Qgc2VlbiBhIHJlYWwgcHJvYmxlbSBj
YXVzZWQgYnkgdGhpcyB5ZXQuDQoNCkNhbiB5b3UgcGxlYXNlIHRyeSB0aGUgYmVsb3cgcGF0Y2gg
dG8gY29uZmlybSBpZiB0aGUgcHJvYmxlbSBpcyBnb25lIG9uDQp5b3VyIHN5c3RlbT8gDQpUaGlz
IHBhdGNoIGZhbGxzIGJhY2sgdG8gdGhlIHByZXZpb3VzIHdheSBhcyBzZW50IGF0DQpodHRwczov
L2xvcmUua2VybmVsLm9yZy9sa21sLzg3cG00YnA1NHouZmZzQHRnbHgvVC8NCg0KdGhhbmtzLA0K
cnVpDQoNCkZyb20gYmRiNDVlMjQxYjRmZWE4YTEyYjk1OGU0OTA5NzllOTZiMDY0ZTQzZCBNb24g
U2VwIDE3IDAwOjAwOjAwIDIwMDENCkZyb206IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNv
bT4NCkRhdGU6IEZyaSwgMSBEZWMgMjAyMyAxNTowNjozNCArMDgwMA0KU3ViamVjdDogW1BBVENI
XSB4ODYvYWNwaTogRG8gc3RyaWN0IFgyQVBJQyBJRCBjaGVjayBvbmx5IHdoZW4gYW4gZW5hYmxl
ZCBDUFUNCiBpcyBlbnVtZXJhdGVkIHZpYSBMQVBJQw0KDQpDb21taXQgOGU5YzQyZDc3NmQ2ICgi
eDg2L2FjcGk6IElnbm9yZSBpbnZhbGlkIHgyQVBJQyBlbnRyaWVzIikgZG9lcw0Kc3RyaWN0IFgy
QVBJQyBJRCBjaGVjayBpZiBMQVBJQyBjb250YWlucyB2YWxpZCBDUFVzIGJ5IGNoZWNraW5nIHRo
ZQ0KYWNwaV90YWJsZV9wYXJzZV9tYWR0KCkgcmV0dXJuIHZhbHVlLg0KDQpUaGlzIGlzIHdyb25n
IGJlY2F1c2UgYWNwaV90YWJsZV9wYXJzZV9tYWR0KCkgcmV0dXJuIHZhbHVlIG9ubHkNCnJlcHJl
c2VudHMgdGhlIG51bWJlciBvZiBsZWdhbCBlbnRyaWVzIHBhcnNlZC4gRm9yIGV4YW1wbGUsIExB
UElDIGVudHJ5DQp3aXRoIExBUElDIElEIDB4ZmYgaXMgY291bnRlZCBhcyBhIGxlZ2FsIGVudHJ5
LCBidXQgaXQgZG9lc24ndCBkZXNjcmliZQ0KYSB2YWxpZCBDUFUuDQoNClRoaXMgY2F1c2VzIGlz
c3VlcyBvbiBhIHN5c3RlbSB3aGljaCBoYXMgMHhmZiBMQVBJQyBJRCBpbiBhbGwgTEFQSUMNCmVu
dHJpZXMuIEJlY2F1c2UgdGhlIGNvZGUgZG9lcyBzdHJpY3QgWDJBUElDIElEcyBjaGVjayBhbmQg
aWdub3JlcyBtb3N0DQpvZiB0aGUgQ1BVcyBpbiBYMkFQSUMgZW50cmllcy4NCg0KRml4IHRoZSBw
cm9ibGVtIGJ5IGRvaW5nIHN0cmljdCBYMkFQSUMgSUQgY2hlY2sgbGVzcyBhZ2dyZXNzaXZlbHks
IHNheQ0Kb25seSB3aGVuIGFuIGVuYWJsZWQgQ1BVIGlzIGVudW1lcmF0ZWQgdmlhIExBUElDLg0K
DQpGaXhlczogOGU5YzQyZDc3NmQ2ICgieDg2L2FjcGk6IElnbm9yZSBpbnZhbGlkIHgyQVBJQyBl
bnRyaWVzIikNCkxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMTEyMjIyMTk0
Ny43ODE4MTItMS1qc3BlcmJlY2tAZ29vZ2xlLmNvbS8NClJlcG9ydGVkLWJ5OiBKb2huIFNwZXJi
ZWNrIDxqc3BlcmJlY2tAZ29vZ2xlLmNvbT4NClNpZ25lZC1vZmYtYnk6IFpoYW5nIFJ1aSA8cnVp
LnpoYW5nQGludGVsLmNvbT4NCi0tLQ0KIGFyY2gveDg2L2tlcm5lbC9hY3BpL2Jvb3QuYyB8IDEy
ICsrKysrKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvYWNwaS9ib290LmMgYi9hcmNo
L3g4Ni9rZXJuZWwvYWNwaS9ib290LmMNCmluZGV4IDFhMGRkODBkODFhYy4uOGNjNTY2Y2U0ODZh
IDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva2VybmVsL2FjcGkvYm9vdC5jDQorKysgYi9hcmNoL3g4
Ni9rZXJuZWwvYWNwaS9ib290LmMNCkBAIC0yNjYsNiArMjY2LDcgQEAgc3RhdGljIGludCBfX2lu
aXQNCiBhY3BpX3BhcnNlX2xhcGljKHVuaW9uIGFjcGlfc3VidGFibGVfaGVhZGVycyAqIGhlYWRl
ciwgY29uc3QgdW5zaWduZWQgbG9uZyBlbmQpDQogew0KIAlzdHJ1Y3QgYWNwaV9tYWR0X2xvY2Fs
X2FwaWMgKnByb2Nlc3NvciA9IE5VTEw7DQorCWludCBjcHU7DQogDQogCXByb2Nlc3NvciA9IChz
dHJ1Y3QgYWNwaV9tYWR0X2xvY2FsX2FwaWMgKiloZWFkZXI7DQogDQpAQCAtMjg5LDkgKzI5MCwx
MyBAQCBhY3BpX3BhcnNlX2xhcGljKHVuaW9uIGFjcGlfc3VidGFibGVfaGVhZGVycyAqIGhlYWRl
ciwgY29uc3QgdW5zaWduZWQgbG9uZyBlbmQpDQogCSAqIHRvIG5vdCBwcmVhbGxvY2F0aW5nIG1l
bW9yeSBmb3IgYWxsIE5SX0NQVVMNCiAJICogd2hlbiB3ZSB1c2UgQ1BVIGhvdHBsdWcuDQogCSAq
Lw0KLQlhY3BpX3JlZ2lzdGVyX2xhcGljKHByb2Nlc3Nvci0+aWQsCS8qIEFQSUMgSUQgKi8NCi0J
CQkgICAgcHJvY2Vzc29yLT5wcm9jZXNzb3JfaWQsIC8qIEFDUEkgSUQgKi8NCi0JCQkgICAgcHJv
Y2Vzc29yLT5sYXBpY19mbGFncyAmIEFDUElfTUFEVF9FTkFCTEVEKTsNCisJY3B1ID0gYWNwaV9y
ZWdpc3Rlcl9sYXBpYyhwcm9jZXNzb3ItPmlkLAkvKiBBUElDIElEICovDQorCQkJCSAgcHJvY2Vz
c29yLT5wcm9jZXNzb3JfaWQsIC8qIEFDUEkgSUQgKi8NCisJCQkJICBwcm9jZXNzb3ItPmxhcGlj
X2ZsYWdzICYgQUNQSV9NQURUX0VOQUJMRUQpOw0KKw0KKwkvKiBEbyBzdHJpY3QgWDJBUElDIElE
IGNoZWNrIG9ubHkgd2hlbiBhbiBlbmFibGVkIENQVSBpcyBlbnVtZXJhdGVkIHZpYSBMQVBJQyAq
Lw0KKwlpZiAoY3B1ID49IDAgKQ0KKwkJaGFzX2xhcGljX2NwdXMgPSB0cnVlOw0KIA0KIAlyZXR1
cm4gMDsNCiB9DQpAQCAtMTEzNCw3ICsxMTM5LDYgQEAgc3RhdGljIGludCBfX2luaXQgYWNwaV9w
YXJzZV9tYWR0X2xhcGljX2VudHJpZXModm9pZCkNCiAJaWYgKCFjb3VudCkgew0KIAkJY291bnQg
PSBhY3BpX3RhYmxlX3BhcnNlX21hZHQoQUNQSV9NQURUX1RZUEVfTE9DQUxfQVBJQywNCiAJCQkJ
CWFjcGlfcGFyc2VfbGFwaWMsIE1BWF9MT0NBTF9BUElDKTsNCi0JCWhhc19sYXBpY19jcHVzID0g
Y291bnQgPiAwOw0KIAkJeDJjb3VudCA9IGFjcGlfdGFibGVfcGFyc2VfbWFkdChBQ1BJX01BRFRf
VFlQRV9MT0NBTF9YMkFQSUMsDQogCQkJCQlhY3BpX3BhcnNlX3gyYXBpYywgTUFYX0xPQ0FMX0FQ
SUMpOw0KIAl9DQotLSANCjIuMzQuMQ0KDQoNCg0KDQoNCg0KDQoNCg==

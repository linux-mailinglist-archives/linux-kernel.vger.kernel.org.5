Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012537D6B51
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343827AbjJYMYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343767AbjJYMYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:24:31 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183A39C;
        Wed, 25 Oct 2023 05:24:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9S+lSzsULH/OL5BQH1zaKw5dc2HWs9dAOEs9PGt6fetXQbS9P+au7kSRjJRtmLqswX/KIDvvw/V6bpuqaRMhhpTh+L8jguX1madDjSKiYmdEmyc6F44tSi6S4qwvaJKXRGvgepx+T6yhLP3rKlk67S0u3FsdYqhHBZE0muTrhR+dRC49VPulqiyiPxd9e9oZAdW+f2hg5HXXEyrXGV00u/F8oSTVENJH0CQpz1dSkp5J2MLAvCQ5O8xHu/UjPrmlYH0Gy5uqtTEvBYieU6HxkOPG9xDTSDwQchuBhbjCVhXR6uDRY83h1LK36KqbR358t2nFzkkOA/yaxCE6ZJFDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHmfJ4mbsS1xGuizlsBANEdJFSzuQyppf4MiRInZ+2k=;
 b=TKsF5KLEBRi1JtNepSCLsfD1hpgAVmNF5NhXPkt1gGt5dI+SKt0mwlFgBz7XrkJEE2zMLEEGdHO1wDnwKSzrNyN5Br+R0er8GmjJ/NDVqmA3+lVGf0sTcJG/HT0Ma6agzAGtMGAHDnuoCGmla/uOv7uSfWRlX1IOde52A3okkOx5618gyAXLgq3SBMsWCJ3iLbttN8R6ehgIuP551knzPSHJ0VKRxCDuQ8o6lRKF6Uf7Pae5beqQe2VYaGR81SkRlEC4OmCB9JBv3iEsCCWyKfZXlw+vxNeq+k5SkLPNNdY9lc8GULQs1vlevHcKicZ2SIzN6uwwBOENT/NKmmdsWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHmfJ4mbsS1xGuizlsBANEdJFSzuQyppf4MiRInZ+2k=;
 b=wa6rwxi5jqtSI/Fs4pm+iBHp6aqePoT7yzXvxSv23l83r+LMNZlNBrr9Ko0VnXp5tTV9MxBpS8BJsIRT5gRtseTnsD+cdPXGEcy5gZzTm2bLo/bRHNkq6s1hyUzjuXW7mXdkgZ2LH0MErOr3NKkQrhV8MSonOoMbzcOv4S+2KK4=
Received: from DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17)
 by CH3PR12MB8284.namprd12.prod.outlook.com (2603:10b6:610:12e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Wed, 25 Oct
 2023 12:24:25 +0000
Received: from DM6PR12MB4465.namprd12.prod.outlook.com
 ([fe80::a5c1:c32c:cffd:84d2]) by DM6PR12MB4465.namprd12.prod.outlook.com
 ([fe80::a5c1:c32c:cffd:84d2%2]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 12:24:25 +0000
From:   "Buddhabhatti, Jay" <jay.buddhabhatti@amd.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RESEND 1/2] drivers: clk: zynqmp: calculate closest mux
 rate
Thread-Topic: [PATCH RESEND 1/2] drivers: clk: zynqmp: calculate closest mux
 rate
Thread-Index: AQHaACQsPQgWHJin50m8/iNPVibuVrBYVucAgAIkf/A=
Date:   Wed, 25 Oct 2023 12:24:25 +0000
Message-ID: <DM6PR12MB4465394908A211BFBA93DA199DDEA@DM6PR12MB4465.namprd12.prod.outlook.com>
References: <20231016113002.15929-1-jay.buddhabhatti@amd.com>
 <20231016113002.15929-2-jay.buddhabhatti@amd.com>
 <47616bcf9f17a2d8665767d9ada49f25.sboyd@kernel.org>
In-Reply-To: <47616bcf9f17a2d8665767d9ada49f25.sboyd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4465:EE_|CH3PR12MB8284:EE_
x-ms-office365-filtering-correlation-id: 5e306cae-ce0b-4a2a-4da6-08dbd5555365
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pHg49GqIOF7fr2SdLQadXX905yasp7qndA3YuPy0XmVCxl+wJupaPj+omeD0moGgkv6M4BTZhNnrONV9K9rZ95PSes647baZfb3Swuc2SSatVpz57Kg2ZvEwUCqL9NZlIWuFBJ5eU3Qi1NKuWmHjzAsmx5blISkvLzeg+TBVhqx1jC4A/Z4LdkZGTZYkDEN4fdAur5FIJ/rjt/E6XXxrXJ2Il1nXWGhZTcuFTcPmpbkpQwJVVJH8WR3J/+zWAALmMWAQb5lFG7zPFSlbUxjwuUDfenCd82SBa+RpE3M0ZUMT1LSTx74gPNHyQx4L2StSM4uxOapaHKU6X4U9fo1I3BplVUPGmAdkGCp6WCjY3qbw+DAJoZen/Dq9wrrlI+owvMex8F2o9hEgKUqUtnZPXhqNxcrY3jTyrNqDnNxPehjL2y9N7e5LNilFrVWQS4aVIbhWWAbyM62C3QGkiA5T+NpjbgsHFp0FTW8QKaGzj33f7qoL/1rj1ApX3lg52Xcf4SbhDukn4WtUjpPGvrHS61zROUVKQf1gbBZQnC7uCvy7BjZOICypMlLfCa+RxNIr31thueqXqhxn2uGthjHxa3FIHzEYp4r387x3nvmMK0pkpq0TvmZnyKAyIQ/OIqOl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4465.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38070700009)(55016003)(83380400001)(8936002)(53546011)(2906002)(4001150100001)(38100700002)(4326008)(26005)(33656002)(8676002)(52536014)(71200400001)(122000001)(7696005)(86362001)(9686003)(6506007)(478600001)(316002)(76116006)(5660300002)(66476007)(41300700001)(54906003)(66556008)(110136005)(66946007)(66446008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MC9ZR3h0T3VyTktQTmcyQ0VWTE8zcVJXalkvTmR2dmN1ek1sd25qNzdDbEdB?=
 =?utf-8?B?SXVpZE5QWHZ2R0JDTUpaOWxyOWRMUSsvQzFqV21VckxpNGxyNEluQmIzV0hP?=
 =?utf-8?B?OXdOMmx5R1BCMityK1JiRWZYd0dSVitIaWFHdE5DZ21MTlJsUWQxbUtNSXNk?=
 =?utf-8?B?ZXVTRE5kT1JGUitHelA5bDBzd2t4MmZ5ditjdXNudlo0cXRXcGxrV2YxQ2V1?=
 =?utf-8?B?SFg2ZHVUY21YaXZnaHpqQVJCNm5NVFRnbnkyaGVNaWRsclYrcDJtM2FZNzl2?=
 =?utf-8?B?UlNpMHZERjJjZFpqNDR5R3Rhd2Vtd0cyWkZCbFR4ajNYdTl2NUVWZmc4czdC?=
 =?utf-8?B?cUJYZWV5dTRKMk5XY1VlaCtva1cxSFlkMTUvT1pBNUk0RkxScEpFTkpkMSs0?=
 =?utf-8?B?b1hsVTdaa3h6ditFeTdmM0hwRTBSZXF2a3p3ZjRuRHJDTGNHWUJjY2pWR3ZI?=
 =?utf-8?B?NVVENnJ2N1JOUWY4Rk1jZVFvZysvMnJ6Y0RhTjF5dlJNVm9vU25TNFpqKzMy?=
 =?utf-8?B?dkZwMlBadGFSTmxKN1FKU2UvcktrVXE4OEsvcW5UOVpDUDJmRGZCdVNyRUti?=
 =?utf-8?B?WkFad1ArOVdaRyttMkpJcHVLZVByeDc2YmE1RnlOdUlrZVpRTlUzVy82bmg5?=
 =?utf-8?B?anVMM04zRXltS2M1NWxFNWxhOHgzbTIwRDJxMk1uMDQ0MWVqSmcxWUF6cXlr?=
 =?utf-8?B?SzMyN3EzNDN6cVdrNVFCUkNQeXhQSXdIbnRwcFF6K1dIKzRuc2tpdlZxWFNI?=
 =?utf-8?B?cVJDQXBwNVlYZVRBWUdoSm9WbG8xbEorZGhRaHNUangvNDZuaGVJa2Y1c3Fv?=
 =?utf-8?B?L2R3aFhDaWdaZUZpeUYrNjFkU0JydjhHSzlpYURFN0NnSmVIVGJwWmUwdjdD?=
 =?utf-8?B?blowaHBzKzdOaHNFbXRmOHd1bXdQcnRMTjBCWVhKVzNYMnR5a0ljd2F6bjJp?=
 =?utf-8?B?cnMxemdnaVJxNldEc2Z6UC85NGFtV2VHZDJsT2dkRzdsMW82SkJCTndmeHFC?=
 =?utf-8?B?SDAzSUdETkpubE5LREhFQlAvQmxhU0JjM3hLUXhlTThBWXhmVzAyalR1ZkhV?=
 =?utf-8?B?NzV4NUtIT0tEcndKVndOTi9UYWpXckNpSHFaVk9aTzRxZlgyTHE0K1VRbkRy?=
 =?utf-8?B?eHQxVlBzQzRpRGE5RzFUZWhmcEs2UVBOc2orbTVPcTdnaWN0V094RDR1VWtv?=
 =?utf-8?B?ckhPSGExd3lUNkIzSWc2b0ZocUtGcEExYTYwaWNHZlcxNnQ4M0hUR2JZbFF2?=
 =?utf-8?B?Y3JySWFMbjRpNnVmcU5ISnd5ZkZSa0pqbmp0Vjh5V2IyQk9WSkV0aU9McWho?=
 =?utf-8?B?QzFCOVJGeWs5dkV5Q0hkcTJadS9CT3QzNXRGMjRLSUIrNDFpZkg0WnZvcVRu?=
 =?utf-8?B?b01LNkFiVTBxVE1aSlE4RzBwSzFlZk9QTERyV2NhK2l2N0NSbHdnVlRpcnNm?=
 =?utf-8?B?bGV2TXVWWjZRejdKZWNadWdHSUpvRXltVEVsN0JtSE5HWHQ0MStkN0NzdXVy?=
 =?utf-8?B?Uml4cmNQWko5cml5Njg0RGVCZVN5M1d6b3ZiRG41WnBHa1dzeURtVU9wb2xx?=
 =?utf-8?B?dFpBV2dhVFloNU5jSFRObUFCbFJmSDlWaVRDQ0Vwb2FwQXJtaGE0aXNvSThP?=
 =?utf-8?B?Yk1aVExKZk9rS2p0UWF1OE9hQzZhMlQ4SVo3dGpEOUZSVnpXeXV5ZXdjaHpJ?=
 =?utf-8?B?K2djaStSRHprcDI4MDJMSFNhOEg0V1ZseVFGM0FiS0ZzYXpGQTdVUHdEWnEv?=
 =?utf-8?B?Qll2aHJGRGVJQTVXTUdNNjBER21KZnRMdXpoWTNPOGpRb3p5N3hudVRSQ1pO?=
 =?utf-8?B?M3k4MmxPV1ExcnV3OElyWWtUNFNsa0hqUSswRlY3TjJGeWpQNndBd09DZXIx?=
 =?utf-8?B?eDhRUjc1aUlCWklxZk9uWnNqeFZMUS9ObTNMYXRtWldRNVJLS3dBL0JERkdo?=
 =?utf-8?B?azRsSGpPbzZMWWNmTXRyc2VtMzhyWnFVZ2NQUjluNnV2eXZqWWVxUzZSTmwv?=
 =?utf-8?B?RlVqcVdBbTlvWnBwRGJxbXdBTzZ5ZHNVZUV3WnByQ1UvTWRML2tSMWJWaURS?=
 =?utf-8?B?czhoaHl0WTFUd0ZoVXQra29xY0s4Um56YWRBbUdPUGd5YjFGbmNqN253SWF5?=
 =?utf-8?Q?YdEw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4465.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e306cae-ce0b-4a2a-4da6-08dbd5555365
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 12:24:25.0618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ujj6wrO1p8TY04E8V8WeyzEcrIIAIYeJyUV4p9RBdq82rnkkOOMxgHLbPfCeeVMFFNMmXd3BvQKRqb1TflznzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8284
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVw
aGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjQs
IDIwMjMgOTowOSBBTQ0KPiBUbzogQnVkZGhhYmhhdHRpLCBKYXkgPGpheS5idWRkaGFiaGF0dGlA
YW1kLmNvbT47IFNpbWVrLCBNaWNoYWwNCj4gPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgbXR1cnF1
ZXR0ZUBiYXlsaWJyZS5jb20NCj4gQ2M6IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IEJ1ZGRoYWJoYXR0aSwgSmF5IDxqYXkuYnVkZGhhYmhhdHRpQGFtZC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkVTRU5EIDEvMl0gZHJpdmVyczogY2xrOiB6eW5xbXA6IGNh
bGN1bGF0ZSBjbG9zZXN0IG11eA0KPiByYXRlDQo+IA0KPiBRdW90aW5nIEpheSBCdWRkaGFiaGF0
dGkgKDIwMjMtMTAtMTYgMDQ6MzA6MDEpDQo+ID4gQ3VycmVudGx5IHp5bnFtcCBjbG9jayBkcml2
ZXIgaXMgbm90IGNhbGN1bGF0aW5nIGNsb3Nlc3QgbXV4IHJhdGUgYW5kDQo+ID4gYmVjYXVzZSBv
ZiB0aGF0IExpbnV4IGlzIG5vdCBzZXR0aW5nIHByb3BlciBmcmVxdWVuY3kgZm9yIENQVSBhbmQg
bm90DQo+ID4gYWJsZSB0byBzZXQgZ2l2ZW4gZnJlcXVlbmN5IGZvciBkeW5hbWljIGZyZXF1ZW5j
eSBzY2FsaW5nLg0KPiA+DQo+ID4gRS5nLiwgSW4gY3VycmVudCBsb2dpYyBpbml0aWFsIGFjcHUg
Y2xvY2sgcGFyZW50IGFuZCBmcmVxdWVuY3kgYXMgYmVsb3cNCj4gPiBhcGxsMSAgICAgICAgICAg
ICAgICAgIDAgICAgMCAgICAwICAyMTk5OTk5OTc4ICAgIDAgICAgIDAgIDUwMDAwICAgICAgWQ0K
PiA+ICAgICBhY3B1MF9tdXggICAgICAgICAgMCAgICAwICAgIDAgIDIxOTk5OTk5NzggICAgMCAg
ICAgMCAgNTAwMDAgICAgICBZDQo+ID4gICAgICAgICBhY3B1MF9pZGl2MSAgICAwICAgIDAgICAg
MCAgMjE5OTk5OTk3OCAgICAwICAgICAwICA1MDAwMCAgICAgIFkNCj4gPiAgICAgICAgICAgICBh
Y3B1MCAgICAgIDAgICAgMCAgICAwICAyMTk5OTk5OTc4ICAgIDAgICAgIDAgIDUwMDAwICAgICAg
WQ0KPiA+DQo+ID4gQWZ0ZXIgY2hhbmdpbmcgYWNwdSBmcmVxdWVuY3kgdG8gNTQ5OTk5OTk0IEh6
IHVzaW5nIENQVSBmcmVxIHNjYWxpbmcNCj4gPiBpdHMgc2VsZWN0aW5nIGluY29ycmVjdCBwYXJl
bnQgd2hpY2ggaXMgbm90IGNsb3Nlc3QgZnJlcXVlbmN5Lg0KPiA+IHJwbGxfdG9feHBkICAgICAg
ICAgICAgMCAgICAwICAgIDAgIDE1OTk5OTk5ODQgICAgMCAgICAgMCAgNTAwMDAgICAgICBZDQo+
ID4gICAgIGFjcHUwX211eCAgICAgICAgICAwICAgIDAgICAgMCAgMTU5OTk5OTk4NCAgICAwICAg
ICAwICA1MDAwMCAgICAgIFkNCj4gPiAgICAgICAgIGFjcHUwX2RpdjEgICAgIDAgICAgMCAgICAw
ICAgNTMzMzMzMzI4ICAgIDAgICAgIDAgIDUwMDAwICAgICAgWQ0KPiA+ICAgICAgICAgICAgIGFj
cHUwICAgICAgMCAgICAwICAgIDAgICA1MzMzMzMzMjggICAgMCAgICAgMCAgNTAwMDAgICAgICBZ
DQo+ID4NCj4gPiBQYXJlbnQgc2hvdWxkIHJlbWFpbiBzYW1lIHNpbmNlIDU0OTk5OTk5NCA9IDIx
OTk5OTk5NzggLyA0Lg0KPiA+DQo+ID4gU28gdXNlIF9fY2xrX211eF9kZXRlcm1pbmVfcmF0ZV9j
bG9zZXN0KCkgZ2VuZXJpYyBmdW5jdGlvbiB0bw0KPiA+IGNhbGN1bGF0ZSBjbG9zZXN0IHJhdGUg
Zm9yIG11eCBjbG9jay4gQWZ0ZXIgdGhpcyBjaGFuZ2UgaXRzIHNlbGVjdGluZw0KPiA+IGNvcnJl
Y3QgcGFyZW50IGFuZCBjb3JyZWN0IGNsb2NrIHJhdGUuDQo+ID4gYXBsbDEgICAgICAgICAgICAg
ICAgICAwICAgIDAgICAgMCAgMjE5OTk5OTk3OCAgICAwICAgICAwICA1MDAwMCAgICAgIFkNCj4g
PiAgICAgYWNwdTBfbXV4ICAgICAgICAgIDAgICAgMCAgICAwICAyMTk5OTk5OTc4ICAgIDAgICAg
IDAgIDUwMDAwICAgICAgWQ0KPiA+ICAgICAgICAgYWNwdTBfZGl2MSAgICAgMCAgICAwICAgIDAg
ICA1NDk5OTk5OTUgICAgMCAgICAgMCAgNTAwMDAgICAgICBZDQo+ID4gICAgICAgICAgICAgYWNw
dTAgICAgICAwICAgIDAgICAgMCAgIDU0OTk5OTk5NSAgICAwICAgICAwICA1MDAwMCAgICAgIFkN
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEpheSBCdWRkaGFiaGF0dGkgPGpheS5idWRkaGFiaGF0
dGlAYW1kLmNvbT4NCj4gPiAtLS0NCj4gDQo+IEFueSBGaXhlcyB0YWcgaGVyZT8NCltKYXldIFN1
cmUgSSB3aWxsIGFkZCBmaXhlcyB0YWcuDQoNClRoYW5rcywNCkpheQ0K

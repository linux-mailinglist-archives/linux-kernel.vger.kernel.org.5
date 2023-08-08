Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1779D774A1D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjHHUTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjHHUTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:19:24 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2108.outbound.protection.outlook.com [40.107.247.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C975E12D956;
        Tue,  8 Aug 2023 12:24:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4h1cQWVKdgTiuXKquN1tkxchp6b6HtHkI48UH+gAaF56M7BtXKK+5j5m9myN+Y/ODx0Z2TNGX+QsJ7gSx2ErJN/Qzus9OmXphguLT6fCDt4WcshDJZafcxqZ7mv1nNAZqda1RXjuJxULpHPMhqMtPc2QZbImd1wfcq3I6tLTD9Wekqt6BJ197A7FoWIGcvCanL0XIKJ121qjEUMKA3ANG2fXU2vieh6+WILgRVbcqQ5LKnj6bfCpxyi08nY2atEBGkdfWtXAZx8lOPTdShGVd8wBBEJbhMGbCYtpLdgWbKcmJmCU/c4OwUK3QGAKCsJftVhkOPL88TdczmYB1LttQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCCeQqcXd9jzqlo6wpVtm+1iB5X7ny0Jisz49gReG9Y=;
 b=Fh01m9vjLaJZIe/XhB8pM4v4P/+5MWjFR2cJ2KdaqnDNntgBAzvr4dU9vNf7e3fswZpJObjYqwim+W0Jq0AgZFX9hZMz5wtUivvnA+Ip7ZUKoJcI+U8YqI9ngpMbgqTF9TfI+IIwrnmXtq31g3ccNDTH1Z/fSV0biJJi1jqWG7qf5IqTVqeBEbFfZ+QOk2pPKe7q5bVC8lWjQ4ISSYneF/CwlQz9H3zHEQkiZCfhiOc72VzfhUN0FfLAbkAkA/BoMvzW0O1pz8f8ytei3mEHd8jNpBOSjmHhU3WM5PJOhCqq/OPHPzqPtFSJrTKmcyFZqlTS4Y3HF5oMV/NdletNcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCCeQqcXd9jzqlo6wpVtm+1iB5X7ny0Jisz49gReG9Y=;
 b=uCWx1Y6kw914UcmJ0B3DZWXowb/wGdnW3vy+zYUIO9PgqDqUaI+bTLcuJP8gqcklDlYK3m5qI3nEJFJGGP1CIw7RislpDBLlTlGfWuywxJ5n3ENY00lxZFt98sztixoUCwolR9FcVLVV7BfUZK4fqBw6Ej9gjld25sMUIwSv2Ns=
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com (2603:10a6:102:2a1::18)
 by DB9PR04MB8169.eurprd04.prod.outlook.com (2603:10a6:10:25d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 19:23:57 +0000
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::d62d:f67e:ba75:b5dc]) by PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::d62d:f67e:ba75:b5dc%4]) with mapi id 15.20.6652.022; Tue, 8 Aug 2023
 19:23:57 +0000
From:   Huibin Shi <henrys@silicom-usa.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Henry Shi <henryshi2018@gmail.com>,
        "hbshi69@hotmail.com" <hbshi69@hotmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC:     "hb_shi2003@yahoo.com" <hb_shi2003@yahoo.com>,
        Wen Wang <wenw@silicom-usa.com>
Subject: RE: [PATCH] Add Silicom Platform Driver
Thread-Topic: [PATCH] Add Silicom Platform Driver
Thread-Index: AQHZwXxe7EV0UfjvlU+pLuHc4u/61K/g17SQ
Date:   Tue, 8 Aug 2023 19:23:56 +0000
Message-ID: <PA4PR04MB9222F109DC08A8BF0A91A2629A0DA@PA4PR04MB9222.eurprd04.prod.outlook.com>
References: <20230718160104.2716-1-henryshi2018@gmail.com>
 <fb62b2e7-7c7c-dc2e-768d-3393f151eb32@wanadoo.fr>
 <PA4PR04MB92225B65A45868A9CBE25B999A06A@PA4PR04MB9222.eurprd04.prod.outlook.com>
 <08469a96-24f2-2099-0a0a-019cb81f976b@wanadoo.fr>
 <f400750d-e53c-65f8-210f-aa127d8f6beb@roeck-us.net>
In-Reply-To: <f400750d-e53c-65f8-210f-aa127d8f6beb@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silicom-usa.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9222:EE_|DB9PR04MB8169:EE_
x-ms-office365-filtering-correlation-id: 52ce8140-86e5-4cc1-79ca-08db984502cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nI3Pr0AGUJZGskHKVOLgQh4g/e8O8oKQbm/5Fn9Nx4Hx21HrJweQ+RCVzjQqBEod5Fw7e+6Hwz1+XIrfMf4AoJJ2bQisoW7Rtdsf1MuHjSFI3tcHEgRw03MhaF3EC9g1reVgjlQBdRl9H6VT5PZGfOK9RU63Tasb13QswTf5OVARnw05Z5uL8d08NqnPsyawOGgG+LcOpyuTBF0/xQKfbF9namdA4EqaibL6fytM92tccouSSDC3Z575/rI627G3rRt7n9Vs+aRMexmFciG/Enqj8MJ2ZtGSQ9JofuRA8IIJfg7NqxpBl+6NtVmYW9wjP0bDI6+HZc8XkmTOWaTL6rLCJZHafHoVBRIJAa9XrE9oVTpJSlqLfSRxcbQ5+isu52sh/Ux1EyalZkzb8r8riCJjSQqlkIBtfBDfPEDoU8gbokhqSAlmx8FnVoclOtSwEQEqJm3NzSqXIVZItWkoL4tpwWtnqzvfmDRMIeJUd2T+63EoeeRo3bHDW7kx8TNB6mP/gDA1D5nCcyC/4s1LcPsJsz1Qn1mBaDM58VJg8Jn2FirgYZl9aziBE1rP9T40Wc3PRhEB/hl54okKE5l6AQYZgtJ4Ub7QNc6vqdfU+pgP5OwbU2pu8lEjYPjwZOK2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(346002)(366004)(376002)(396003)(136003)(1800799003)(186006)(451199021)(53546011)(6506007)(107886003)(9686003)(7696005)(71200400001)(122000001)(478600001)(45080400002)(921005)(33656002)(110136005)(38100700002)(54906003)(66476007)(66946007)(66556008)(76116006)(64756008)(66446008)(4326008)(316002)(41300700001)(52536014)(8676002)(5660300002)(38070700005)(7416002)(8936002)(2906002)(66574015)(83380400001)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TC9lU3NIVnhiS2x4eGFpTjE2RzMzU01hWDBlMGxtczNvYzBEaWgrY3dEMjBC?=
 =?utf-8?B?V1BydERxQUE0VFYxa1BMS2taWW01bUpYb0VpUTZnOHA3UUxXUGY1ajdoc3c0?=
 =?utf-8?B?eHFJaXJHeUdrZ3VKZkhxaDhGbHNnaVE3T3B0MkhmQjNBNVk4TlFnYSt4RzFI?=
 =?utf-8?B?VnhCUzh1QWtjb0tibHkxZ1JIZy92RkFGbzdybzBPWTZHclBkS0VuQzRGYkIx?=
 =?utf-8?B?d2dDQTBYMzYyYVlaNjRvQ0FtUEZORnU2alNoRm1hcmhwNERrSkxWUjdweFhD?=
 =?utf-8?B?QUVRenRoTVJmcW9hRGhCZ3RvUTdneG4xYTEvME41R3NKNXVXc1h4OHdXZHBv?=
 =?utf-8?B?R2hOZCtIQlE0VnBiaW4yZEgyR3Z1U0xCSitkOXdIWVZTQTdibXYyTm9JU205?=
 =?utf-8?B?d2ZScnBZODRydzE2TDFNWitDT0FzSVUrc0ZyT2ttZTI2bzRMUUNCZjVOZnNZ?=
 =?utf-8?B?SWFhUzRNZDlDQ2RXZ21vS1BHRUlSTlJBZXI0Q3pMRFpKZjg0c0QxNzdnQVp4?=
 =?utf-8?B?bkpnZDJUS1FJRnpaWmhkOGlqcWdYdVp5KzF2Snp4aWhoS3hxUEttZGt0SlY4?=
 =?utf-8?B?a29hRFNpR0x2VWNWcnFmZlEwL0lUMGdmb3FWUmRoL1VURlUxUDh6NlJBQmZz?=
 =?utf-8?B?eWMxZUhEV2NLTG9jRG1kbkl4cHJpdGxlWHVRd0xXalNNbmRRMUdTUFpFWTdl?=
 =?utf-8?B?MEZJMXZlaU1VWW1hUCtzTGMyQytTcTlWWUo0bHZmYWx4ZHlFRnBYNDdwYUhT?=
 =?utf-8?B?VzhlTWl3RS8zS2ZhTVlYRVFBbTFHU09qSWp6ZG5Xek9ZcHBiRi81eDlkL0NT?=
 =?utf-8?B?VlpxRnRhUk1jT0k5T0l0WjdvQXo4a2dtLzRFRTJnVUZMWCt6dEtIMTVDeUZX?=
 =?utf-8?B?NTU5ODlES2o4TXVEbjZDRmsrMkc1VlhSSVA2SlZtMS9qR0dhNU91RG5Lc2gr?=
 =?utf-8?B?ai9MQzRualJad2RFc0FJTEI4dlZKZnNXSXo5dU85bUxpZ012WjZTRVZzK0xF?=
 =?utf-8?B?UEUzTStSSER4UDcwREhBZFl2by9JNEVGZGIyRTBYSy9sYkU5MDY0d2hHQUpw?=
 =?utf-8?B?R1JMKzc3UzlsQU1DVkN1eEZrZHdNOTVoUlpGdDUxditGRWFuc2RVSDhyRnZq?=
 =?utf-8?B?cm52Y1RUTGdtMjBTRGRPQVl1UFh0aDJ1Z3dpdEJScUF5citvYzRCWldQRWxu?=
 =?utf-8?B?TzVJTmRiUWtPK1BJSXhhOHJvUkhtTnFzNWRJV0J0Z0ZBeUtKRE1DMTFkT2NS?=
 =?utf-8?B?YmJSRFQzcGxKTnBNUWdFbDZYTk1HNnEzVVpJMFJENTZPd3QyWXVRVVBqbzk5?=
 =?utf-8?B?TjYrZ0R4LzFjbURSekNRRG9JL2tsRXNMakxpbUpNNkpDM3ZyWE1CdE05WjZO?=
 =?utf-8?B?bGk4TEwydCsxWkNtK1VJWEU0TTU4MFJuWFl6VXpIbHpOTGNxY2tkc3FQUFcw?=
 =?utf-8?B?bjlyOHlwdE84NjEvSk9wYUxSdkZBR29aeTlwOXc1Y2NMMFlZQ0pFVlZOcjVT?=
 =?utf-8?B?aWUrUEg2Ym1WcGhQUWROSy9kc1VQTERjcnJJeEZFMGFuMU9nS0RTNWZwSGV2?=
 =?utf-8?B?ZUJnWm1kWFRZY08rdCtXMzhHZ3lHM1N5WHhIVDM1Wkh1L2xFdW5yTWFXaFZq?=
 =?utf-8?B?ZlV0bUo0NEFWSEtsMXEwVTRrKzJmd05sVnFoWnhBdThTOXpOL1ZWN2ZvTCtj?=
 =?utf-8?B?ZzJCUUdEQzhCZnl0aGhYNHRoN1YwQTJsYkEwM0dYKzI4TU9ZejNxckNJWFBP?=
 =?utf-8?B?bmI4cTRuNWJBSnNBeWJyRGxvMjBYT21tSUE5NEdzeUlHbS9FMGNqMkxSdDVz?=
 =?utf-8?B?S2tuWmlMSkxoaDJMMmI5MndrdVJGbkdHcHFyYTdYWG5yempMVEM4SXNkZDI4?=
 =?utf-8?B?bjQ1QWt1c3FJU1B1WXBrR2RTWStRM0xESjBXVGp1VnQ1U2xuZWhWYWlzSGo0?=
 =?utf-8?B?VGt2TWNWSzVFVzJIZUJ3RDNubHlJTkpSU1gwdmVCRkZUNWlUZjlhM2sweE41?=
 =?utf-8?B?VE5md1lzU1IrdlJaM0ZVUDI4VGtQTGhrZjFYZEpKRC84TUZDTFo1Wndmc0VY?=
 =?utf-8?B?d2Q2bm5jR0JsVkdHZ01sWlFiY2JxWTYwVkV6bXVPTDNyTGU3L21EZlV3MjFE?=
 =?utf-8?B?UUs5cmtnd0JDWTdCV2FMTXlOSVRZWkNFbUIycGl1Tmc1WFBDR05CNyt4NlY2?=
 =?utf-8?Q?kCeHdouuK9r4NQHpOU31BoFB0pfuNR1HfY2iN2QH80ae?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ce8140-86e5-4cc1-79ca-08db984502cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 19:23:57.0068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6UB+VNdXP2tIJXZBqvZas2dHNyrr+pvYFIa9wTD805xhHo5fCUpvNvV47wOthjWkBgAP+UmF1H+6KlKspHlV9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8169
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2VlIG15IGNvbW1lbnRzIGJlbG93Og0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJv
bTogR3VlbnRlciBSb2VjayA8Z3JvZWNrN0BnbWFpbC5jb20+IE9uIEJlaGFsZiBPZiBHdWVudGVy
IFJvZWNrDQpTZW50OiBGcmlkYXksIEp1bHkgMjgsIDIwMjMgMTo1MyBQTQ0KVG86IENocmlzdG9w
aGUgSkFJTExFVCA8Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI+OyBIdWliaW4gU2hpIDxo
ZW5yeXNAc2lsaWNvbS11c2EuY29tPjsgSGVucnkgU2hpIDxoZW5yeXNoaTIwMThAZ21haWwuY29t
PjsgaGJzaGk2OUBob3RtYWlsLmNvbTsgdGdseEBsaW51dHJvbml4LmRlOyBtaW5nb0ByZWRoYXQu
Y29tOyBicEBhbGllbjguZGU7IGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbTsgeDg2QGtlcm5l
bC5vcmc7IGhwYUB6eXRvci5jb207IGhkZWdvZWRlQHJlZGhhdC5jb207IG1hcmtncm9zc0BrZXJu
ZWwub3JnOyBqZGVsdmFyZUBzdXNlLmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
cGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWh3bW9uQHZnZXIua2Vy
bmVsLm9yZw0KQ2M6IGhiX3NoaTIwMDNAeWFob28uY29tOyBXZW4gV2FuZyA8d2Vud0BzaWxpY29t
LXVzYS5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBBZGQgU2lsaWNvbSBQbGF0Zm9ybSBEcml2
ZXINCg0KQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2Fy
ZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMuDQoNCg0KT24gNy8y
OC8yMyAwOTo0NywgQ2hyaXN0b3BoZSBKQUlMTEVUIHdyb3RlOg0KPiBMZSAyOC8wNy8yMDIzIMOg
IDE0OjU5LCBIdWliaW4gU2hpIGEgw6ljcml0IDoNCj4+IENocmlzdG9waGUsDQo+Pg0KPj4gVGhh
bmtzIGZvciB0aGUgY29tbWVudHMuIFNlZSBteSBjb21tZW50cyBiZWxvdy4NCj4+DQo+PiBVcGRh
dGVkIHBhdGNoIHdpbGwgYmUgc2VudCBvdXQgbGF0ZXIgYWZ0ZXIgcmV2aWV3IGNvbW1lbnRzIGZy
b20gb3RoZXIgcmV2aWV3ZXJzIGFyZSBhZGRyZXNzZWQuDQo+Pg0KPj4gSGVucnkNCj4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PiBGcm9tOiBDaHJpc3RvcGhlIEpBSUxMRVQgPGNocmlz
dG9waGUuamFpbGxldEB3YW5hZG9vLmZyPg0KPj4gU2VudDogVHVlc2RheSwgSnVseSAyNSwgMjAy
MyA1OjAzIFBNDQo+PiBUbzogSGVucnkgU2hpIDxoZW5yeXNoaTIwMThAZ21haWwuY29tPjsgaGJz
aGk2OUBob3RtYWlsLmNvbTsgDQo+PiB0Z2x4QGxpbnV0cm9uaXguZGU7IG1pbmdvQHJlZGhhdC5j
b207IGJwQGFsaWVuOC5kZTsgDQo+PiBkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb207IHg4NkBr
ZXJuZWwub3JnOyBocGFAenl0b3IuY29tOyANCj4+IGhkZWdvZWRlQHJlZGhhdC5jb207IG1hcmtn
cm9zc0BrZXJuZWwub3JnOyBqZGVsdmFyZUBzdXNlLmNvbTsgDQo+PiBsaW51eEByb2Vjay11cy5u
ZXQ7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IA0KPj4gcGxhdGZvcm0tZHJpdmVyLXg4
NkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWh3bW9uQHZnZXIua2VybmVsLm9yZw0KPj4gQ2M6IGhi
X3NoaTIwMDNAeWFob28uY29tOyBIdWliaW4gU2hpIDxoZW5yeXNAc2lsaWNvbS11c2EuY29tPjsg
V2VuIA0KPj4gV2FuZyA8d2Vud0BzaWxpY29tLXVzYS5jb20+DQo+PiBTdWJqZWN0OiBSZTogW1BB
VENIXSBBZGQgU2lsaWNvbSBQbGF0Zm9ybSBEcml2ZXINCj4+DQo+PiBDYXV0aW9uOiBUaGlzIGlz
IGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mg
b3Igb3BlbmluZyBhdHRhY2htZW50cy4NCj4+DQo+Pg0KPj4gTGUgMTgvMDcvMjAyMyDDoCAxODow
MSwgSGVucnkgU2hpIGEgw6ljcml0IDoNCj4+PiBUaGUgU2lsaWNvbSBwbGF0Zm9ybSAoc2lsaWNv
bS1wbGF0Zm9ybSkgTGludXggZHJpdmVyIGZvciBTd2lzc2NvbSANCj4+PiBCdXNpbmVzcyBCb3gg
KFN3aXNzY29tIEJCKSBhcyB3ZWxsIGFzIENvcmRvYmEgZmFtaWx5IHByb2R1Y3RzIGlzIGEgDQo+
Pj4gc29mdHdhcmUgc29sdXRpb24gZGVzaWduZWQgdG8gZmFjaWxpdGF0ZSB0aGUgZWZmaWNpZW50
IG1hbmFnZW1lbnQgDQo+Pj4gYW5kIGNvbnRyb2wgb2YgZGV2aWNlcyB0aHJvdWdoIHRoZSBpbnRl
Z3JhdGlvbiBvZiB2YXJpb3VzIExpbnV4IA0KPj4+IGZyYW1ld29ya3MuIFRoaXMgcGxhdGZvcm0g
ZHJpdmVyIHByb3ZpZGVzIHNlYW1sZXNzIHN1cHBvcnQgZm9yIA0KPj4+IGRldmljZSBtYW5hZ2Vt
ZW50IHZpYSB0aGUgTGludXggTEVEIGZyYW1ld29yaywgR1BJTyBmcmFtZXdvcmssIA0KPj4+IEhh
cmR3YXJlIE1vbml0b3JpbmcgKEhXTU9OKSwgYW5kIGRldmljZSBhdHRyaWJ1dGVzLiBUaGUgU2ls
aWNvbSANCj4+PiBwbGF0Zm9ybSBkcml2ZXIncyBjb21wYXRpYmlsaXR5IHdpdGggdGhlc2UgTGlu
dXggZnJhbWV3b3JrcyBhbGxvd3MgDQo+Pj4gYXBwbGljYXRpb25zIHRvIGFjY2VzcyBhbmQgY29u
dHJvbCBDb3Jkb2JhIGZhbWlseSBkZXZpY2VzIHVzaW5nIA0KPj4+IGV4aXN0aW5nIHNvZnR3YXJl
IHRoYXQgaXMgY29tcGF0aWJsZSB3aXRoIHRoZXNlIGZyYW1ld29ya3MuIFRoaXMgDQo+Pj4gY29t
cGF0aWJpbGl0eSBzaW1wbGlmaWVzIHRoZSBkZXZlbG9wbWVudCBwcm9jZXNzLCByZWR1Y2VzIA0K
Pj4+IGRlcGVuZGVuY2llcyBvbiBwcm9wcmlldGFyeSBzb2x1dGlvbnMsIGFuZCBwcm9tb3RlcyBp
bnRlcm9wZXJhYmlsaXR5IA0KPj4+IHdpdGggb3RoZXIgTGludXgtYmFzZWQgc3lzdGVtcyBhbmQg
c29mdHdhcmUuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBIZW5yeSBTaGkgPGhlbnJ5c2hpMjAx
OEBnbWFpbC5jb20+DQo+Pj4gLS0tDQo+Pg0KPj4gWy4uLl0NCj4+DQo+Pj4gK3N0YXRpYyBpbnQg
X19pbml0IHNpbGljb21fbWNfbGVkc19yZWdpc3RlcihzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3QgDQo+
Pj4gK2xlZF9jbGFzc2Rldl9tYw0KPj4+ICsqbWNfbGVkcykgew0KPj4+ICsgICAgIHN0cnVjdCBs
ZWRfY2xhc3NkZXZfbWMgKmxlZDsNCj4+PiArICAgICBpbnQgaSwgZXJyOw0KPj4+ICsNCj4+PiAr
ICAgICBmb3IgKGkgPSAwOyBtY19sZWRzW2ldLmxlZF9jZGV2Lm5hbWU7IGkrKykgew0KPj4+ICsg
ICAgICAgICAgICAgLyogYWxsb2NhdGUgYW5kIGNvcHkgZGF0YSBmcm9tIHRoZSBpbml0IGNvbnN0
YW5zdHMgKi8NCj4+PiArICAgICAgICAgICAgIGxlZCA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVv
ZihzdHJ1Y3QgDQo+Pj4gKyBsZWRfY2xhc3NkZXZfbWMpLCBHRlBfS0VSTkVMKTsNCj4+DQo+PiBz
aXplb2YoKmxlZCkgaXMgc2hvcnRlci4NCj4+IE1vc3RseSBhIG1hdHRlciBvZiB0YXN0ZS4NCj4+
DQo+PiBNYXliZSBldmVuIGRldm1fa21lbWR1cCgpPw0KPj4NCj4+IEhlbnJ5OiB0aGFua3MuIERl
dm1fa21lbWR1cCgpIEFQSSByZXF1aXJlcyBhZGRpdGlvbmFsIGFyZ3VtZW50IHRoYXQgaXMgbm90
IG5lY2Vzc2FyeSBvZiB0aGlzIGRyaXZlci4gSSBwcmVmZXIgZGV2bV9remFsbG9jIGZvciBub3cu
DQo+DQo+IENKOiBUaGUgb25seSBhZGRpdGlvbm5hbCBwYXJhbWV0ZXIgSSBjYW4gdGhpbmsgb2Yg
YXJlIHRoZSBvbmUgb2YgbWVtY3B5KCkgLi4uDQo+DQo+Pg0KPj4+ICsgICAgICAgICAgICAgaWYg
KElTX0VSUl9PUl9OVUxMKGxlZCkpIHsNCj4+DQo+PiBpZiAoIWxlZCkNCj4+IGlzIGVub3VnaC4N
Cj4+DQo+PiBIZW5yeTogT0ssIGNoYW5nZWQNCj4+DQo+Pj4gKyAgICAgICAgICAgICAgICAgICAg
IGRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGFsbG9jDQo+Pj4gKyBsZWRfY2xhc3NkZXZfbWNbJWRd
OiAlbGRcbiIsIGksIFBUUl9FUlIobGVkKSk7DQo+Pg0KPj4gVGhpcyBraW5kIG9mIG1lc3NhZ2Ug
aXMgdXNlbGVzcyBhbmQgc2hvdWxkIGJlIHJlbW92ZWQgKGNoZWNrcGF0Y2ggDQo+PiBzaG91bGQg
d2FybiBhYm91dCBpdCkNCj4+DQo+PiBIZW5yeTogT0ssIHJlbW92ZWQuDQo+Pg0KPj4+ICsgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4+PiArICAgICAgICAgICAgIH0NCj4+
PiArICAgICAgICAgICAgIG1lbWNweShsZWQsICZtY19sZWRzW2ldLCBzaXplb2YoKmxlZCkpOw0K
Pg0KPiAuLi4gaGVyZS4NCj4NCj4gZGV2bV9remFsbG9jKCkgKyB0aGlzIG1lbWNweSgpIGNvdWxk
IGJlIGRvbmUgd2l0aCBvbmx5IGRldm1fa21lbWR1cCgpLg0KPg0KPiBUaGlzIGlzIG1vc3RseSBh
IG1hdHRlciBvZiB0YXN0ZS4NCj4NCg0KSSBkb24ndCB0aGluayB0aGF0IHVzaW5nIChvciBub3Qg
dXNpbmcpIGF2YWlsYWJsZSBBUEkgZnVuY3Rpb25zIHNob3VsZCBiZSBhIG1hdHRlciBvZiB0YXN0
ZSwgb3IgdGhlIG5leHQgc3RlcCBtaWdodCBiZSB0byByZS1pbXBsZW1lbnQgbWVtY3B5KCkuDQoN
CkhlbnJ5OiBBZ3JlZS4NCg0KR3VlbnRlcg0KDQo=

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AD27BA18D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239078AbjJEOrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239121AbjJEOoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:44:12 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2091.outbound.protection.outlook.com [40.107.14.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0F4B6D0
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:21:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ta5Ou7XtTQs+sfdjwgMDsYbhkT/CW9BHt03QiYQuSuzmWduFCOFbkad5RlLBAnYE/g/mnwLIXorXZgOyyQJj7lF4F0FbDb4IgXY71cJTUT1m2MZMv+BaAZ4EHn9kvDDITKDA2N7PmTn2z6VdVmkVmfRMP0qvTcgOpdF00tLEL9mTS/pMn38d12GMNpzyc9Y5+qFwu+oOyw6Xj7++M0OO3KBE7f3y1DCqC0K66skdJkK2uB7U/3laqu7c5EUnY0PykiXtwG1UxI85irSooF0tQmaKdbzs7xSueyeE23PyAE1cuwih8QZ/hHJkwi2621Gl5PSQ1nrEFzub5znYwf6bkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiCPwjftzCbxEXDAA4DH3gAA5/e8XpFdyaV8nf41yNo=;
 b=UwzaIbNKvBQRAE6E9Ldw3JZ4ymFVitYv5OyAPKNvauIAGti7MH4qgxNuwOOf0854ad0YieEH82TwppLc/laWN5et8fGP5SwzSEw22eYr0UgUppZekWMTskKHC+L/GkZZuL7jz6fzE8U5plawY+IpROkFXseohZ9ERKqJerO5s5cuQQ1B0v9KKKi+s0UXfgSeuS9aOYusVciXBQmOCm7FgDlQyiErNuFT+KHeRYDy52+YaHLmg6kZiOS2jb5nGZcuTZBDwSvadBQ9c70rOUsuzTmEHPI8v5R/OBnvTJysfhQu9/+yHdQOkPCnHtPN+WFVlutZrlDc3FnG9LvIEC00Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiCPwjftzCbxEXDAA4DH3gAA5/e8XpFdyaV8nf41yNo=;
 b=QPm6B+yG8I1z2LaaTYtkXymOrxfr8FowRpfib+56yAipH0bYa0a7hQ1RofSRVdmnRFrLio57kyTeUDPrMBrgSqwfs9/3Y9eAY6J2ILnrcdyE/YDwpFJShG93cykd1KHUEK9kgI2jqE2aofmBOT1/AA0YF2twfpxNAwBHAaq9iEw=
Received: from AM8PR06MB7137.eurprd06.prod.outlook.com (2603:10a6:20b:1da::16)
 by DB9PR06MB7819.eurprd06.prod.outlook.com (2603:10a6:10:23f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 14:21:41 +0000
Received: from AM8PR06MB7137.eurprd06.prod.outlook.com
 ([fe80::b828:856c:4735:e870]) by AM8PR06MB7137.eurprd06.prod.outlook.com
 ([fe80::b828:856c:4735:e870%7]) with mapi id 15.20.6838.024; Thu, 5 Oct 2023
 14:21:41 +0000
From:   SHUKLA Mamta Ramendra <mamta.shukla@leica-geosystems.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        "pratyush@kernel.org" <pratyush@kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     GEO-CHHER-bsp-development 
        <bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH v2] mtd: micron-st: enable lock/unlock for mt25qu512a
Thread-Topic: [PATCH v2] mtd: micron-st: enable lock/unlock for mt25qu512a
Thread-Index: AQHZr1hWPkDpy3UlU0qGBS67M1mV0q+3GdCAgAHeK4CAPY5YgIAvS6uAgBWqFYCAAEtqAIAACFeA
Date:   Thu, 5 Oct 2023 14:21:41 +0000
Message-ID: <372046cb-9135-9a6c-fdb7-307a42f55b30@leica-geosystems.com>
References: <20230705154942.3936658-1-mamta.shukla@leica-geosystems.com>
 <19800e51-a871-be9f-9eb5-5829237e2613@linaro.org>
 <a8271289-0611-4e37-cf37-0be19a85656b@leica-geosystems.com>
 <084ed945-7674-280f-5866-9238473a294d@leica-geosystems.com>
 <17989610-d069-40e2-9b4d-7ca6bdf2497e@linaro.org>
 <a24d7b3b-4077-9dbe-49ae-96f595b42223@leica-geosystems.com>
 <2d7271b3-dd60-44bb-9700-f6a5295ea873@linaro.org>
In-Reply-To: <2d7271b3-dd60-44bb-9700-f6a5295ea873@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR06MB7137:EE_|DB9PR06MB7819:EE_
x-ms-office365-filtering-correlation-id: d2266b23-3497-4053-8d15-08dbc5ae6535
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6EEa+lIyGmcGZ6Zaf31ePe9oF7aUJ9msLQM/5Cd9VTm1DYrV6bMzzfhpzQva+/n51e88UN0/dc+7WTqFWLcKnTa0ZkAG60DTir2dKOAQWZzesR6Cvx7ysh5D0Jv6XIUFYSKHSpO/vgon3pnXoPIWeKfMw8qMC8QZiSSuvF/sIW4iUAp6VHmxGPhsNpL26IxERbeaoBzhh1Yi6AAeVuw0INK+4Bx88CzZHUeUuDHwZSUNklKmmlh7SmJQL3gAuOfEabBrgZaf8HB1T8dkKMfU4FlfwlPRwq6SlFzVyrovguq8a6G4ISvPvqSAtwPTNuuY/iAA8IsUZJ1STt3gLxY5VfsNOO8SJtsn422kfQj3/eSRqF+Bp86a7TuMiA6cM7SecElt3bONOz3uBd0ghPeWFccROTkYiplGnJ1Es2ItDAAFq1lBscTLIb+VV2y/R+Fo1SVZcnJYCZSh3oEJ/oaOWY/3mEpFeFxlIoCIDxKQSdx7+z2m+2Ted53qe6a2kRzBFflvZk3tvzHNDDBIjMipTOQ0WJWUnpEk5xtldL3Bi3hGsLPAlcJ/FzmI+TXnxzukmg7zuGsxUUVYD3JXkcGwOUmyZFOjg0xLQ+5QloU0BU10P5IkXPRWKoGGsFKhFG+Hq+SPD0RXfVYBZzUmQR5OmmdOUcmkCEUKfLmlhFO9tDE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR06MB7137.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(107886003)(966005)(91956017)(110136005)(6486002)(2616005)(316002)(6506007)(6512007)(41300700001)(76116006)(66946007)(66476007)(66446008)(64756008)(66556008)(8676002)(8936002)(4326008)(5660300002)(26005)(71200400001)(478600001)(45080400002)(31686004)(53546011)(83380400001)(2906002)(36756003)(38070700005)(122000001)(31696002)(86362001)(38100700002)(138113003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHp6N1llMGl6T1BkU2M2Z045M1lVU1lzVXI4eUlUakQ0QzZ0R3VjRElKaDRW?=
 =?utf-8?B?RTFvZlltdHgrKzlJMGNLRWhmTmo3R3cwejR6anVFakNST0pMTS9ER2UyV0NV?=
 =?utf-8?B?dk5rUUE2ZllmSmRuY2dFNEZXeHMyY1MvUEV2T3JidUxYSnR4b1FLdmRDQWM0?=
 =?utf-8?B?MHVEdU5yY2NyWDFJTUxUR1V6TUNxTXlYK01aWnpkK0pYd2dkdjdWckdKeWFQ?=
 =?utf-8?B?Z3JMaVR6dXczbk92Vk1WU3QzRGh2M3JiNU42a2FyVkhsL3JlOURiSUtha1FB?=
 =?utf-8?B?b2V1NGd1TzBIWitmNTNwZFpGRG9Lc0NDS3BmSXZNNGpQaWV5TUY1R2czOGRx?=
 =?utf-8?B?WEdoYWFybjNjd0ZQU1lZUnY5Rm03dW9Qend1OVFCZldNd2Jtd3pINnJPSkt5?=
 =?utf-8?B?ZlgySUxleVNycnoxSlkzOVZqc01ReHM2Y25ZZjEyMGpveGJWSTJTRHAzRU04?=
 =?utf-8?B?c1J6Nmk4cS9LU0tFRHVHaDNEZEFncDVzOXZ2ZXdjMnpmK0ZUc0hlYlA4WlRQ?=
 =?utf-8?B?MzRGSEZjUEhKQVY2NmlZNU1mVGhoTnhmSzlvdzJFSzZ3VFFhTDlwYjIyNEps?=
 =?utf-8?B?cGdvWVAvQ1oxdldEVmJiLzdnZ0FYQmpzUTNRTzlaMUdvRStoUHMxZnl4bXF5?=
 =?utf-8?B?eTdaQWdacXZvZ0pTeTdKSGNneG0zNTd3YWpueTFWUGwySEphSXdCRVdjR0NS?=
 =?utf-8?B?Vk1GQUlWUWZPL1lTVGFPR2ZhY1ZpUS9kRkhvT1U2MFpBeGNmY05CUlo2b1Ny?=
 =?utf-8?B?UVE3VXdJSndma3ZYVTFQKzAvc3c0cE5vMmpFU09pT1ZSa0ZGbjg3NGpYVkNH?=
 =?utf-8?B?S0N6MUI5SytSZGtPKzhnVlRmL1A3MlhxUnhacDErcHRzMUloM29BMXZ6TmI1?=
 =?utf-8?B?enZzbVJreHN0eUZ4RWhNYlQ0eDdMakpFdTZwVG5naityNlZyV0txYTFLUkxL?=
 =?utf-8?B?alZRQlFCWExGRkZtY3FTcFp5NjNnT2R4eFFJUDRvd3NaWXhIL3k3OHRSejVy?=
 =?utf-8?B?VE1ZWlVCSllpeWxxZjh1R0FzMXI5Z24rVEdPNjZQWVQ1U0w4b3oza0xabm5s?=
 =?utf-8?B?cUZOeUlMR2VmYzgzeFYrME5pOXJrUDQ5MnNzQkVtU056c2JjcDVteGx2anpx?=
 =?utf-8?B?TUtkM0o3Ri8yaEdDRy80VzFPcXo1UVpOc0tsVnA1M00wbkpRT3NYODVEU3Vn?=
 =?utf-8?B?OVJjSlVTdyt1RTA2NGxPNUtqZU1mbDZ1U0pBaVRXVCtEVkM4VVlLRE1ucFd3?=
 =?utf-8?B?SDd0NkFwRDRpc0FOYy9PUSsrNFI3MWVrd3NUU3EzNHppcWZCMzZGbnNWNkpS?=
 =?utf-8?B?NEhEODc3RW1FaEFwZE5NRURLK29kRnBKRXFqQ2VPV0NON2ZOV08wbmpmbUsw?=
 =?utf-8?B?VkcrdDQ3cWVtMGt4dUpuaG16MlFHdHFJckl0YUNaY1NyV2NPWkpOU1RxSkd6?=
 =?utf-8?B?SHpPSll6YVZjYkRjSks0QmthMmd0UW1aWVB3T3A4U21INjhIUlZnaGx2TEZQ?=
 =?utf-8?B?WTgxODEyOHpTRFZoeXJIVzhmVkxVRWQydzNSeU9pbEVPYW1ieUZZenp2cGg5?=
 =?utf-8?B?NWJhdGFGMGhOd2pPclFEVFprallYZGFMRU5UVXQxMnVtV0ZyczgycFBVWVo5?=
 =?utf-8?B?dVk3ek0vRE5XZ2dUcm5MYXROcGh2QzNGbkYrM1lJMmdVeCtnMHdkTG81anJF?=
 =?utf-8?B?NDBFTGoxUEtFWllDMnMwcDQrVVorSzVuckE1WlhMT2oraHRqSUJvSllYb2E4?=
 =?utf-8?B?VENYMFJGc0pQWkJyQkFPdUtTUGJUZkQ2VE9rUjh0MlVnWFdIVTZ6ZzkvRDV2?=
 =?utf-8?B?Ylp0amJEVE02Z1F1N2IxMlZRU0w5VURkNTlnb25nTFRJZkM0SjdvZW5nQnRw?=
 =?utf-8?B?dTd3OEt0aE5TUzJSWW5DazVITGNQVkZmZ0tjeDhEekE5eUFSQWNxckx1Y3NQ?=
 =?utf-8?B?Z1cxcnpFZnpyVS9aVWRHQkJnQXdnVkx5SUNBL0EvRWRPS3ltWXlsUGFINlNS?=
 =?utf-8?B?cldGUEN1Zk5iMW9UazJob2lHOU5CcXpYVDNKSnhBZXRoK3U0VGtKL0xJcGFV?=
 =?utf-8?B?emxrWW5MN0VobTBUeUliUGhvSFBxaUtTeEdyRE1mMm0xN0oyQkFXV280OWZE?=
 =?utf-8?B?c2d3NW5mTkhrQ0ZBaldlUWl2akpiRnVpSS9OSVg5SDFzV2VqMTZWUG54enhq?=
 =?utf-8?B?S1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <078CAEE72999EF40B75FB4D2A396F399@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR06MB7137.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2266b23-3497-4053-8d15-08dbc5ae6535
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 14:21:41.5839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0g8fAl3XdJ1ZIT3JnPoDhZG9YPpwTCseIvwo7G4qwRq8J4xk+gEq9A82jYBWQL+wBXR7OeC0bFa0I29QoxjRm27gUxtU3gEdcnbrd7f4s0DWUfktqXpYHyvZwTiIRXh/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7819
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA1LjEwLjIzIDE1OjUxLCBUdWRvciBBbWJhcnVzIHdyb3RlOg0KPiBbU29tZSBwZW9w
bGUgd2hvIHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSB0
dWRvci5hbWJhcnVzQGxpbmFyby5vcmcuIExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdCBo
dHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPiANCj4gVGhp
cyBlbWFpbCBpcyBub3QgZnJvbSBIZXhhZ29u4oCZcyBPZmZpY2UgMzY1IGluc3RhbmNlLiBQbGVh
c2UgYmUgY2FyZWZ1bCB3aGlsZSBjbGlja2luZyBsaW5rcywgb3BlbmluZyBhdHRhY2htZW50cywg
b3IgcmVwbHlpbmcgdG8gdGhpcyBlbWFpbC4NCj4gDQo+IA0KPiBPbiAxMC81LzIzIDEwOjIxLCBT
SFVLTEEgTWFtdGEgUmFtZW5kcmEgd3JvdGU6DQo+IA0KPiBjdXQNCj4gDQo+Pj4NCj4+PiBhbmQg
dGhlIHNlY29uZCBvbmUgd2lsbCBhZGQganVzdCB0aGUgQlAgc3VwcG9ydCwgc29tZXRoaW5nIGxp
a2U6DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvbWljcm9uLXN0LmMNCj4+
PiBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvbWljcm9uLXN0LmMNCj4+PiBpbmRleCBhOGRhMWYxOGUz
MzUuLmZkYWZiZmEwZjkzNiAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL21p
Y3Jvbi1zdC5jDQo+Pj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9taWNyb24tc3QuYw0KPj4+
IEBAIC00MDUsNiArNDA1LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZvIHN0X25v
cl9wYXJ0c1tdID0gew0KPj4+ICAgICAgICAgICB9LCB7DQo+Pj4gICAgICAgICAgICAgICAgICAg
LmlkID0gU05PUl9JRCgweDIwLCAweGJiLCAweDIwLCAweDEwLCAweDQ0LCAweDAwKSwNCj4+PiAg
ICAgICAgICAgICAgICAgICAubmFtZSA9ICJtdDI1cXU1MTJhIiwNCj4+PiArICAgICAgICAgICAg
ICAgLmZsYWdzID0gU1BJX05PUl9IQVNfTE9DSyB8IFNQSV9OT1JfSEFTX1RCIHwNCj4+PiBTUElf
Tk9SXzRCSVRfQlAgfA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICBTUElfTk9SX0JQM19T
Ul9CSVQ2LA0KPj4+ICAgICAgICAgICAgICAgICAgIC5tZnJfZmxhZ3MgPSBVU0VfRlNSLA0KPj4+
ICAgICAgICAgICB9LCB7DQo+Pj4gICAgICAgICAgICAgICAgICAgLmlkID0gU05PUl9JRCgweDIw
LCAweGJiLCAweDIwKSwNCj4+Pg0KPj4+IE9mIGNvdXJzZSwgSSBleHBlY3QgeW91IHRvIHJ1biBh
Z2FpbiB0aGUgbXRkX2RlYnVnIHRlc3RzIGFuZCBhbHNvIHZlcmlmeQ0KPj4+IHRoZSBsb2NraW5n
LiBUaGFua3MhDQo+Pg0KPj4gSSBhcHBsaWVkIGJvdGggY2hhbmdlcyBhcyBtZW50aW9uZWQgYWJv
dmUgaS5lDQo+PiAxXSBTd2l0Y2ggdG8gU0ZEUCBhbmQgMl0gVXNpbmcgQlAgRmxhZ3MuDQo+Pg0K
Pj4gQ2FzZSAxOiBVc2UgQlAgRmxhZ3MgYW5kIFN3aXRjaCB0byBTRkRQDQo+PiBXaXRoIGJvdGgg
dGhlc2UgY2hhbmdlcywgdGhlIGxvY2svdW5sb2NrIGRvZXNuJ3Qgd29yay4NCj4+DQo+PiAjIyB4
ODYtNjQtc21hcmMtZXZrLXV3ZDBqMDAwNyAjIHVuYW1lIC1yDQo+PiA2LjYuMC1yYzINCj4+DQo+
PiAjIGZsYXNoX2xvY2sgLWkgL2Rldi9tdGQwDQo+PiBEZXZpY2U6IC9kZXYvbXRkMA0KPj4gU3Rh
cnQ6IDANCj4+IExlbjogMHg0MDAwMDAwDQo+PiBMb2NrIHN0YXR1czogdW5sb2NrZWQNCj4+IFJl
dHVybiBjb2RlOiAwDQo+PiAjIGZsYXNoX2xvY2sgLWwgL2Rldi9tdGQwDQo+PiBmbGFzaF9sb2Nr
OiBlcnJvciE6IGNvdWxkIG5vdCBsb2NrIGRldmljZTogL2Rldi9tdGQwDQo+Pg0KPj4gICAgICAg
ICAgICAgICBlcnJvciA1IChJbnB1dC9vdXRwdXQgZXJyb3IpDQo+Pg0KPj4NCj4+IEkgc3VzcGVj
dGVkIHRoaXMgaXMgYmVjYXVzZSBvZiBtaXNjYWxjdWxhdGlvbiBvZiBCUCBiaXRzLCBsaWtlIHRo
ZQ0KPj4gcG9zc2liaWxpdHkgbWVudGlvbmVkIGhlcmU6DQo+PiBodHRwczovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9tdGQvbGludXguZ2l0L2NvbW1pdC8/aD1zcGkt
bm9yL25leHQmaWQ9M2VhM2YwYWMyNDJjODZjMDI3NWQzNDdhYjhjOTJiZjFlYjg1NGI0OSANCj4+
DQo+Pg0KPj4gQnV0IGZ1cnRoZXIgY2hlY2tlZCBzaXplLCBpdCBpcyBjb3JyZWN0Og0KPj4NCj4+
ICAgICMgbXRkX2RlYnVnIGluZm8gL2Rldi9tdGQwDQo+PiBtdGQudHlwZSA9IE1URF9OT1JGTEFT
SA0KPj4gbXRkLmZsYWdzID0gTVREX0NBUF9OT1JGTEFTSA0KPj4gbXRkLnNpemUgPSA2NzEwODg2
NCAoNjRNKQ0KPj4gbXRkLmVyYXNlc2l6ZSA9IDQwOTYgKDRLKQ0KPj4gbXRkLndyaXRlc2l6ZSA9
IDENCj4+IG10ZC5vb2JzaXplID0gMA0KPj4gcmVnaW9ucyA9IDANCj4+DQo+PiBBbmQgcmVzdCBv
ZiByZWFkL3dyaXRlIGZ1bmN0aW9ucyB3b3JrIGFzIGV4cGVjdGVkLg0KPj4NCj4+IEFueSBzdWdn
ZXN0aW9ucyBhYm91dCB0aGlzPw0KPj4NCj4+IENhc2UgMjogSnVzdCBhZGRlZCBCUCBmbGFncywg
cmVzdCBvZiB0aGUgc2l6ZSwgbWZyX2ZsYWdzLCBmaXh1cCBmbGFncw0KPj4ga2VwdCBhcyBpdCBp
cy4NCj4gDQo+IHdvdWxkIHlvdSBwbGVhc2UgZGV0YWlsIHdoYXQgZXhhY3QgZGVmaW5pdGlvbnMg
eW91IHVzZWQgaW4gY2FzZSAyPyBTZW5kDQo+IHVzIHRoZSBkaWZmIHBsZWFzZS4NCkNhc2UgMjog
QWRkaW5nIEZsYWdzIGZvciBCUA0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9t
aWNyb24tc3QuYyANCmIvZHJpdmVycy9tdGQvc3BpLW5vci9taWNyb24tc3QuYw0KaW5kZXggNGFm
Y2ZjNTdjODk2Li42YzhjYWJiZWFkMmUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL210ZC9zcGktbm9y
L21pY3Jvbi1zdC5jDQorKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL21pY3Jvbi1zdC5jDQpAQCAt
NDA1LDYgKzQwNSw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmxhc2hfaW5mbyBzdF9ub3JfcGFy
dHNbXSA9IHsNCiAgICAgICAgIH0sIHsNCiAgICAgICAgICAgICAgICAgLmlkID0gU05PUl9JRCgw
eDIwLCAweGJiLCAweDIwLCAweDEwLCAweDQ0LCAweDAwKSwNCiAgICAgICAgICAgICAgICAgLm5h
bWUgPSAibXQyNXF1NTEyYSIsDQorICAgICAgICAgICAgICAgLmZsYWdzID0gU1BJX05PUl9IQVNf
TE9DSyB8IFNQSV9OT1JfSEFTX1RCIHwgDQpTUElfTk9SXzRCSVRfQlAgfA0KKyAgICAgICAgICAg
ICAgICAgICAgICAgU1BJX05PUl9CUDNfU1JfQklUNiwNCiAgICAgICAgICAgICAgICAgLnNpemUg
PSBTWl82NE0sDQogICAgICAgICAgICAgICAgIC5ub19zZmRwX2ZsYWdzID0gU0VDVF80SyB8IFNQ
SV9OT1JfRFVBTF9SRUFEIHwgDQpTUElfTk9SX1FVQURfUkVBRCwNCiAgICAgICAgICAgICAgICAg
LmZpeHVwX2ZsYWdzID0gU1BJX05PUl80Ql9PUENPREVTLA0KDQoNCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpDYXNlIDE6
IEJQIEZsYWdzIGFuZCByZW1vdmVkIHNpemUsIGFuZCBub19zZmRwIHNvIGJ5IGRlZmF1bHQgZXhw
ZWN0aW5nIA0KdG8gcmVhZCBTRkRQDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9y
L21pY3Jvbi1zdC5jIA0KYi9kcml2ZXJzL210ZC9zcGktbm9yL21pY3Jvbi1zdC5jDQppbmRleCA2
YzhjYWJiZWFkMmUuLjRmZWIwM2VlMmQxMyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbXRkL3NwaS1u
b3IvbWljcm9uLXN0LmMNCisrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvbWljcm9uLXN0LmMNCkBA
IC00MDcsOSArNDA3LDYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZvIHN0X25vcl9w
YXJ0c1tdID0gew0KICAgICAgICAgICAgICAgICAubmFtZSA9ICJtdDI1cXU1MTJhIiwNCiAgICAg
ICAgICAgICAgICAgLmZsYWdzID0gU1BJX05PUl9IQVNfTE9DSyB8IFNQSV9OT1JfSEFTX1RCIHwg
DQpTUElfTk9SXzRCSVRfQlAgfA0KICAgICAgICAgICAgICAgICAgICAgICAgIFNQSV9OT1JfQlAz
X1NSX0JJVDYsDQotICAgICAgICAgICAgICAgLnNpemUgPSBTWl82NE0sDQotICAgICAgICAgICAg
ICAgLm5vX3NmZHBfZmxhZ3MgPSBTRUNUXzRLIHwgU1BJX05PUl9EVUFMX1JFQUQgfCANClNQSV9O
T1JfUVVBRF9SRUFELA0KLSAgICAgICAgICAgICAgIC5maXh1cF9mbGFncyA9IFNQSV9OT1JfNEJf
T1BDT0RFUywNCiAgICAgICAgICAgICAgICAgLm1mcl9mbGFncyA9IFVTRV9GU1IsDQogICAgICAg
ICB9LCB7DQoNCg0KDQo+IA0KPiBDaGVlcnMsDQo+IHRhDQo+IA0KPj4gTG9jay91bmxvY2sgd29y
a3MuDQo+Pg0KPj4gIyMgeDg2LTY0LXNtYXJjLWV2ay11d2QwajAwMDcgIyB1bmFtZSAtcg0KPj4g
Ni42LjAtcmMyDQo+Pg0KPj4gIyBmbGFzaF9sb2NrIC1pIC9kZXYvbXRkMA0KPj4gU3RhcnQ6IDAN
Cj4+IExlbjogMHg0MDAwMDAwDQo+PiBMb2NrIHN0YXR1czogdW5sb2NrZWQNCj4+IFJldHVybiBj
b2RlOiAwDQo+Pg0KPj4gIyBmbGFzaF9sb2NrIC1sIC9kZXYvbXRkMA0KPj4gIyBmbGFzaF9sb2Nr
IC1pIC9kZXYvbXRkMA0KPj4gRGV2aWNlOiAvZGV2L210ZDANCj4+IFN0YXJ0OiAwDQo+PiBMZW46
IDB4NDAwMDAwMA0KPj4gTG9jayBzdGF0dXM6IGxvY2tlZA0KPj4gUmV0dXJuIGNvZGU6IDENCj4+
DQo+PiAjIyB4ODYtNjQtc21hcmMtZXZrLXV3ZDBqMDAwNyAjIG10ZF9kZWJ1ZyBlcmFzZSAvZGV2
L210ZDAgMCAxMDQ4NTc2DQo+PiBbICA0MTMuNDcyNDExXSBzcGktbm9yIHNwaS1QUlAwMDAxOjAw
OiBFcmFzZSBvcGVyYXRpb24gZmFpbGVkLg0KPj4gWyAgNDEzLjQ3ODA4NF0gc3BpLW5vciBzcGkt
UFJQMDAwMTowMDogQXR0ZW1wdGVkIHRvIG1vZGlmeSBhIHByb3RlY3RlZA0KPj4gc2VjdG9yLg0K
Pj4gTUVNRVJBU0U6IElucHV0L291dHB1dCBlcnJvcg0KPj4NCj4+ICMgZmxhc2hfbG9jayAtdSAv
ZGV2L210ZDANCj4+ICMgZmxhc2hfbG9jayAtaSAvZGV2L210ZDANCj4+IERldmljZTogL2Rldi9t
dGQwDQo+PiBTdGFydDogMA0KPj4gTGVuOiAweDQwMDAwMDANCj4+IExvY2sgc3RhdHVzOiB1bmxv
Y2tlZA0KPj4gUmV0dXJuIGNvZGU6IDANCj4+DQo+PiAjIyB4ODYtNjQtc21hcmMtZXZrLXV3ZDBq
MDAwNyAjICBtdGRfZGVidWcgZXJhc2UgL2Rldi9tdGQwIDAgMTA0ODU3Ng0KPj4gRXJhc2VkIDEw
NDg1NzYgYnl0ZXMgZnJvbSBhZGRyZXNzIDB4MDAwMDAwMDAgaW4gZmxhc2gNCj4+DQo+Pg0KPj4g
RnVydGhlciBJIHRlc3RlZCBvbiBzdGFibGUgNi41LjUgS2VybmVsIHdpdGggb2xkIHdheSBvZiBG
bGFzaCBJbmZvDQo+PiBGb3JtYXQgYW5kIHdoaWNoIGhhcyBmb3JjZWQgUEFSU0VfU0ZEUCBGbGFn
LCBubyBpc3N1ZXMgd2l0aCBsb2NrL3VubG9jay4NCj4+DQo+Pg0KDQotLS0NCk1hbXRhDQo=

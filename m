Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26447D91EA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345610AbjJ0IjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345579AbjJ0IjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:39:00 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2110.outbound.protection.outlook.com [40.107.22.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E716B111;
        Fri, 27 Oct 2023 01:38:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lf0IbHtsXWMfj+0BDFhwJGfCgfeOGn07HGq8Wh0Otp2O7ugF8t0lwJ6fTkwvtiNHtWUDHlGadfPeGaE05U0J6yBIqiW1+nxmKyBvavgK4VTcr95wkEJ6KJeio2UvJprEQK0j1Y6tksgWroX5t9CbljwJlfHG2SEZv2qbiLWXRcMn6OhA9IFsjKV5hcIaZB5C+JyF6x0UXQASgiBc2MEyiwzG0ZSabJ274N915w02WHpz0MUa6GjohvHidkOpZCsulrI37hxwHrt96JkE4afMlN5zhsfoMCFWz/FCqlm1Die2+0MMjSsF+v2vQ+tagJCnygo0PtWtoWpnD1uHBzyAzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MijymJSAz04o6uT4H4ap6L4Mthp2qPcfmGd4Z84gGk=;
 b=Py5a8E9NhdI/VCkk+KO3nLxxBicQRheu7O09w3vKMjBq34I5R9u7F2TIW8VbcvNbSo8Jbw+v81+f7ioqKb9c4DLBp5SuSbVcgpZDL+/xLkJngSZY2DYTfwAuUPmxg2wkNdVvldmThcEaJZz2KycQwj0CZlDlSQ7PrFr/wfNSDZlNfN5zR0bBRCTYKkePSqTgi0CPl6xB3jSyKGSTQT9Q6DjiohJ2bNNS6sM6p6WlYuSI4bX1IxJIdFfGaWx2ZSf7qUhd0yxMO8Q9mGKXUoqHostblkAUKEM8/ZrNfg+8t5c7J5wNw4xnW/j1DB53X8eq3yw0FuBLmpV59cPeYjY7oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MijymJSAz04o6uT4H4ap6L4Mthp2qPcfmGd4Z84gGk=;
 b=NPPfZ1KfKar8n1gVjntA3ErEKjfdXOtDnWbDiF9QFeaGWLnCQYljuMSvt89CObRgla7PDMkAiJoCU6BmKydNEDFBMlziCiAipFd8mQid7/+GS562eoAnO01Ex749Fgg77ushC65BQjEwA4a3SiIkHMuGvwZCXc2oVJl83Q7+tDw=
Received: from DB9PR10MB8246.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c9::10)
 by GV2PR10MB7462.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 08:38:54 +0000
Received: from DB9PR10MB8246.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b9ed:5aac:1984:3013]) by DB9PR10MB8246.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b9ed:5aac:1984:3013%2]) with mapi id 15.20.6907.025; Fri, 27 Oct 2023
 08:38:54 +0000
From:   "Stoll, Eberhard" <eberhard.stoll@kontron.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Eberhard Stoll <estl@gmx.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Schrempf, Frieder" <frieder.schrempf@kontron.de>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        =?utf-8?B?TGVvbmFyZCBHw7ZocnM=?= <l.goehrs@pengutronix.de>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: AW: [PATCH 1/4] spi: Add parameter for clock to rx delay
Thread-Topic: [PATCH 1/4] spi: Add parameter for clock to rx delay
Thread-Index: AQHaCCByhlFLq4Q3qUiFonGDuLJz8bBcrx+AgACFHbA=
Date:   Fri, 27 Oct 2023 08:38:54 +0000
Message-ID: <DB9PR10MB82468A8BD333B12D3FCB3C43F1DCA@DB9PR10MB8246.EURPRD10.PROD.OUTLOOK.COM>
References: <20231026152316.2729575-1-estl@gmx.net>
        <20231026152316.2729575-2-estl@gmx.net> <20231027005643.4b95f17e@xps-13>
In-Reply-To: <20231027005643.4b95f17e@xps-13>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB8246:EE_|GV2PR10MB7462:EE_
x-ms-office365-filtering-correlation-id: 7400abc4-d8e8-42fc-4c14-08dbd6c8275f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4KB5xqo5fesnCIeHRTbCGj0Yw+CHqvWeoDdv//49/RMcFQkp+rKu6+t8kLndixekBYtK9Q0KEGpV3bIrXxNedhrxp2BWKF3rpQMNYvuBMAcr1OlGP9saGw1yeMoKib81/3LdDNEnyrUiD7ElIDy+YveI5AfMFJZTikybIfUbXIJzDUsfxjouAFnyj9RM/z2mpdQsgw7Mek9MbuwAVzhP/PNNecEVsZ7RlTwJEap6t+jTsAn6hrHOriwQw1P6xM/oUMoJ5yQlmzXvpXmFCYpip+YrFzgLJSSG/SWrchf/tZB/mMNEUlaeczaVWmmgvGOLS8F0WzvQBYnED1jxErGgwXW28ZCJQru99L2KjB3c6fHmcn3y3N+h5Gxh2QqkCOW27TgCpKLlixp3Mzla16a9VahB65bXb0NslqLv9RYAGL/lN3BUHwPCD1r1yWENqqauxxmN/ZaGpMyQrFg2xPBcznBDQ4JLiucW7xw/I4tQgF64J9//Hg75YpHPaMqfYLgr9BNfBlK7DkGvFrrW3n4qWwzD6g8IoGab6txI6fYf/Lk80k0/M4bMqMei/m+LK9c3KZanVmuP61u5v8Ow67Ui6V4m3Wpi8HYl20WPiRNV9mtQ6G6GVAlCfKA8pTfKnW4G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB8246.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(122000001)(55016003)(6506007)(9686003)(7696005)(38100700002)(83380400001)(76116006)(66946007)(110136005)(7416002)(5660300002)(33656002)(41300700001)(66476007)(66446008)(86362001)(316002)(66556008)(64756008)(54906003)(52536014)(4326008)(8676002)(8936002)(38070700009)(478600001)(2906002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S25sQW9ZZWJPcDFBVkVLNnBXS2ZUVk51TzBoUkQrSG83dTI2OWEycXk4YWRP?=
 =?utf-8?B?UTExZUpFQlFmK2VlUU82VjY3U2ZpNTRQOFFQMTJvN0txeFFLN3F3OVZrT2VI?=
 =?utf-8?B?SW9adTJlTUlucktJZ09YbXA0WGhKaDBXaEdWU2poMW9CWmNwMy9wcGVVTEVa?=
 =?utf-8?B?MnhQTC9XL2tFQ1Q2L0JFVUl1dGtUSlk5L1B3U01rWWEwWGxJWHZwNHhZNnJq?=
 =?utf-8?B?STRzQnYxaVc4bGxQTGNlVWUvd21ZR2tlNVF5WEJ5NnplQzVBL2hrUFZJWG5S?=
 =?utf-8?B?eWp6bnEyZ2x5bWp4RVFNZ01BWktPRDdVS3RBbnJkTGJmTTJzYWNuSnA2SzBP?=
 =?utf-8?B?R1ppbnZkZ1RpUVY5b1VaYUdEV0RsRWtOa3FuWWtZaFpGWUh5WUVoMTJLV3Zw?=
 =?utf-8?B?R2Y4dXFsTVYxSnZLVTRmd2N6MGZtR0lSWDBxNFZJOHIrNTRSRTlmeGlvZ2lo?=
 =?utf-8?B?ZTNVeXJZdVN1Wm9UNlUyMitlZGhYU1BwcTZNV1VsdWpjOXZzS2oyckNCYk1T?=
 =?utf-8?B?N3BNV0wxMWRhRElSZERyOHR6cTNYemRJZkhnY1BpRnZSUFpGQjBrbW1aMmU4?=
 =?utf-8?B?bTZNWnhsMytQWDY1aytteTNoSnAyQVUrLytVaUd4SG00RCtNbldlYmV4TnQ3?=
 =?utf-8?B?KzR1N3lKUk1TK0JxQ0pqR2xCY2JTTlVhQ1lTTERPWWY5OHNTUVhrU0FOWXIz?=
 =?utf-8?B?SE9kMmNpMEZQYVhSQTN1VURaMStRczRMS0NjUE8zbk9kQjR4bmd4ZVNQdDAw?=
 =?utf-8?B?R2RYVW9neitoS3h3MDdKci9Uc2Jja1JaZTNxcXJENHJuaU5iWmVvRGRLMTgv?=
 =?utf-8?B?NUJCaXc3ZS8rZEIzUXNvZGMzMEhpQUE1cEFVditLMVFROTBrdVZiZzlxWmdq?=
 =?utf-8?B?Y1dqaUhpQzJIaHhnZ3JmdDdYNmhsT0ljZEY0czBYL0g5L0tOd1AyN3JzT3RD?=
 =?utf-8?B?Y3FPN2xxRTJ3Q2RtRlpoUVNPWGIwYU9oRW9wWmxpZ0lwME5GcDFWdnhmSUk1?=
 =?utf-8?B?TXRGYnVxb3RPYk54bGFYeXUxSDBHMU9xNXkrOGdZcDNHR1gxU0FkRFdYZjZD?=
 =?utf-8?B?SnpRV055VDhVVVdTNUduZXcwWnh5WXBhdFpNdVRFVG1JT2FySENmNUJGK1Iv?=
 =?utf-8?B?ZG9zT1RWODE1UkFSVjhySFI0SmZTM3dQWkVKSWYxT3VidUZDSzU3UHlVTms4?=
 =?utf-8?B?b0h1M0N0UVc2SEhhWjhoV3dJdXpiMDRmZFI4WlNUNTloN3JBOWNpT3RpVW0y?=
 =?utf-8?B?QlVBcUJkRjBKUFJqWk1MTnZaVXM2MllUTUM0YVovSElLVWh3NTZjN2VrMXB2?=
 =?utf-8?B?TWcwK0tQQnlWMHlxajNkOXJ5N0l1SFUyWWRkMzhDYUpwaFZtYVFZZ0RvVGJV?=
 =?utf-8?B?cWtWMUJkOXNzZndGbEptSldEYW1XNEpVbHIvOUFTd3VoUTh4a2s2R0RYQnBI?=
 =?utf-8?B?ZXpKMzB5VXFDZjBQVTFaRHhJNTBBY0Jxc3lhbU5pcmhoQTY5WHo1LysrRS9j?=
 =?utf-8?B?aldhR09EWUZ2U2xEUk1vQWlZeENqcXNFU0V3TGlaTEJSQ2Z2RS9XdTB2Zzh4?=
 =?utf-8?B?UjVlOGNNVmRUYW9zMzN1RmEva2h0SjBXY1doR2NJUXJBdVIvM1orY2lxY2kv?=
 =?utf-8?B?YlhLUDU1Ri9mZDBCdU01NWRFLzVReFdvazBScjFMVFI4NHdSemYrRTJFbjUz?=
 =?utf-8?B?TitkR2d0OUdVTWg3YURvZzJ0QlZBRDFKbldQajRFV2ZqSkd3RGdUR1g5NEJV?=
 =?utf-8?B?dDh2bDlWRWVLd0RNWnpra2JZUW9SSm92TThHWjgzSENzQlpkeFZIcDFMTTN2?=
 =?utf-8?B?dEwzaXJHcUYxdnhObCtqT3BiNnhOVGZzSTF4bWcwOFRrZkIwL0dScDdwbTFu?=
 =?utf-8?B?M3EzNzBHV3JGaXIwdmx3d0l4c25qamNPRVllakJpN0krTllOaklTbDBwZHdI?=
 =?utf-8?B?QjgzVTdxdVQvSGJxVXZrVG9VU0RiZjNRV2c3R1ZsVWJkUlM4OGQ0bHpxRFZm?=
 =?utf-8?B?SllaN1Z0S3RUN3hVYmRvamR4bnVhMVNzODgzN1kwa2xnM0xRWVpKZ2tVOGlV?=
 =?utf-8?B?Zk0wSllFY3I4MFh4dHFyczFyTVZFUmgwaEJCZWpFdTdydTBCcy9POEF3ZFZ5?=
 =?utf-8?B?RUozM2x1Zkw3dFl6MDdrejdReHZNQXB4SEYzQzZoR3RVUUQ5REJMcXYrZHBT?=
 =?utf-8?Q?LuVK0xRVZxBdvt6RKUrVbLsWMgCBasWE8YN+5BIbpRPy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8246.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7400abc4-d8e8-42fc-4c14-08dbd6c8275f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 08:38:54.5306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ou1fuc8CaW1RnFa2GX1/MYgIilQkCChAowMfQq4syGZXJCzTUKGRlRQBF75EMqXhCHjHR4/ioLwMAuVF5ef6ih/g38WmsNQvvNKihNsxDVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7462
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCj4gPiBGb3Igc3BpIGRldmljZXMgdGhlIG1hc3RlciBjbG9jayBvdXRwdXQgZGVm
aW5lcyB0aGUgc2FtcGxpbmcgcG9pbnQNCj4gPiBmb3IgcmVjZWl2ZSBkYXRhIGlucHV0IHN0cmVh
bSAocmlzaW5nIG9yIGZhbGxpbmcgZWRnZSkuIFRoZSByZWNlaXZlDQo+ID4gZGF0YSBzdHJlYW0g
ZnJvbSB0aGUgZGV2aWNlIGlzIGRlbGF5ZWQgaW4gcmVsYXRpb24gdG8gdGhlIG1hc3Rlcg0KPiA+
IGNsb2NrIG91dHB1dC4NCj4gPg0KPiA+IEZvciBzb21lIGRldmljZXMgdGhpcyBkZWxheSBpcyBs
YXJnZXIgdGhhbiBvbmUgaGFsZiBjbG9jayBwZXJpb2QsDQo+IA0KPiBDYW4geW91IGJlIG1vcmUg
c3BlY2lmaWM/IEkgYW0gd29uZGVyaW5nIGhvdyBiaWcgdGhlIG5lZWQgaXMuDQoNCkluIG91ciBj
YXNlIGl0J3MgYSBRU1BJIE5BTkQgY2hpcCAoV2luYm9uZCBXMjVOMDJLVikuIFRoaXMgZGV2aWNl
DQpjYW4gb3BlcmF0ZSBhdCAxMDRNSHogU1BJIGNsb2NrLiBCdXQgaXQgYWxzbyBoYXMgYSB0Q0xR
ViB2YWx1ZSBvZiA3bnMuDQpUaGUgdENMUVYgdmFsdWUgbGltaXRzIHRoZSBTUEkgY2xvY2sgc3Bl
ZWQgZm9yIHRoaXMgZGV2aWNlIHRvIDJ4N25zDQooaWYgaXQgaXMgbm90IGFkanVzdGFibGUgaW4g
dGhlIFNQSSBjb250cm9sbGVyKSB3aGljaCBpcyBhcHByb3hpbWF0ZWx5DQo3ME1Iei4NCg0KV2l0
aG91dCB0aGUgYWJpbGl0eSB0byBzZXQgdGhlIHRDTFFWIHZhbHVlLCB0aGUgU1BJIGNsb2NrIGhh
cyB0byBiZQ0KbGltaXRlZCB0byA3ME1IeiBpbiBkZXZpY2UgdHJlZSBmb3IgdGhpcyBidXMuDQoN
CkluIG91ciBjYXNlIHRoZSBXaW5ib25kIFcyNU4wMktWIGNoaXAgaXMgYSByZXBsYWNlbWVudCBv
ZiBhbg0Kb2xkZXIgY2hpcC4gVGhlIG9sZGVyIGNoaXAgY2FuIG9wZXJhdGUgYXQgMTA0TUh6IGFu
ZCBkb2VzIG5vdA0KaGF2ZSB0aGUgdENMUVYgcmVzdHJpY3Rpb25zIGFzIHRoaXMgbmV3IG9uZS4N
ClRoZSBuZXcgY2hpcCBpcyBtb3N0bHkgaXMgYmV0dGVyIHRoYW4gdGhlIGRhdGEgc2hlZXQgYW5k
IG1lZXQgdGhlDQp0aW1pbmcgcmVxdWlyZW1lbnRzIGZvciAxMDRNSHouIEJ1dCBvbiBoaWdoZXIg
dGVtcGVyYXR1cmVzDQpkZXZpY2VzIGZhaWwuDQoNCkluIGRldmljZSB0cmVlIFFTUEkgTkFORCBj
aGlwcyBhcmUgY29uZmlndXJlZCBieSBhIGNvbXBhdGlibGUNCnByb3BlcnR5IG9mICdzcGktbmFu
ZCcuIFRoZSBtdGQgbGF5ZXIgZGV0ZWN0cyB0aGUgcmVhbCBkZXZpY2UNCmFuZCBmZXRjaGVzIHRo
ZSBwcm9wZXJ0aWVzIG9mIHRoaXMgZGV2aWNlIGZyb20gdGhlIGFwcHJvcHJpYXRlDQpkcml2ZXIu
DQoNClNvIGZvciBvdXIgY2FzZSAoYm9hcmRzIGNvbnRhaW5pbmcgdGhlIG9sZCBhbmQgbmV3IGNo
aXApIHdlIHdlbGwNCmhhdmUgdG8gcmVkdWNlIHRoZSBTUEkgY2xvY2sgZm9yIHRoZSBlbnRpcmUg
UVNQSSBidXMgdG8gNzBNSHosIGV2ZW4NCmZvciB0aGUgZWxkZXIgY2hpcHMgd2hpY2ggY2FuIG9w
ZXJhdGUgd2VsbCBhbHNvIHdpdGggMTA0TUh6LiANCg0KPiANCj4gPiB3aGljaCBpcyBub3JtYWxs
eSB0aGUgc2FtcGxpbmcgcG9pbnQgZm9yIHJlY2VpdmUgZGF0YS4gSW4gdGhpcyBjYXNlDQo+ID4g
cmVjZWl2ZSBkYXRhIGlzIHNhbXBsZWQgdG9vIGVhcmx5IGFuZCB0aGUgZGV2aWNlIGZhaWxzIHRv
IG9wZXJhdGUuDQo+ID4gSW4gY29uc2VxdWVuY2UgdGhlIHNwaSBjbG9jayBoYXMgdG8gYmUgcmVk
dWNlZCB0byBtYXRjaCB0aGUgZGVsYXkNCj4gPiBjaGFyYWN0ZXJpc3RpY3MgYW5kIHRoaXMgcmVk
dWNlcyBwZXJmb3JtYW5jZSBhbmQgaXMgdGhlcmVmb3JlIG5vdA0KPiA+IHJlY29tbWVuZGVkLg0K
PiA+DQo+ID4gU29tZSBzcGkgY29udHJvbGxlcnMgaW1wbGVtZW50IGEgJ2Nsb2NrIHRvIHJlY2Vp
dmUgZGF0YSBkZWxheScNCj4gPiBjb21wZW5zYXRpb24gd2hpY2ggc2hpZnRzIHRoZSByZWNlaXZl
IHNhbXBsaW5nIHBvaW50LiBTbyB3ZSBuZWVkDQo+ID4gYSBwcm9wZXJ0eSB0byBzZXQgdGhpcyB2
YWx1ZSBmb3IgZWFjaCBzcGkgZGV2aWNlLg0KPiANCj4gV2hhdCBpZiB0aGUgc3BpIGNvbnRyb2xs
ZXIgZG9lcyBub3Qgc3VwcG9ydCB0aGlzIGZlYXR1cmU/IFNoYWxsIHdlIGFkZA0KPiBhIGNhcGFi
aWxpdHk/IFNoYWxsIHdlIHJlZnVzZSB0byBwcm9iZSBpZiB0aGUgY29udHJvbGxlciBpcyBub3Qg
Y2FwYWJsZQ0KPiBvZiBzYW1wbGluZyBhdCB0aGUgcmlnaHQgbW9tZW50Pw0KPiANCg0KUmVmdXNl
IHRvIHByb2JlIGlzIG5vdCBuZWNlc3NhcnkgSU1ITy4gVGhlIGRldmljZSBjYW4gb3BlcmF0ZSB3
ZWxsDQpldmVuIHdpdGggY29udHJvbGxlcnMgd2hpY2ggZG8gbm90IGltcGxlbWVudCB0aGUgdENM
UVYgZnVuY3Rpb25hbGl0eS4NClRoZSBTUEkgY2xvY2sgaGFzIHNpbXBseSB0byBiZSByZWR1Y2Vk
IGFuZCBhbGwgd29ya3Mgd2VsbC4gSW4gdGhpcyBjYXNlDQpub3QgdGhlIG1heGltdW0gU1BJIGNs
b2NrIGZyZXF1ZW5jeSBvZiB0aGUgZGV2aWNlIGxpbWl0cyB0aGUgU1BJIGJ1cw0KY2xvY2ssIGJ1
dCB0aGUgdENMUVYgdmFsdWUhDQoNCklNSE8gaXQncyB0aGUgcmVzcG9uc2liaWxpdHkgb2YgdGhl
IHdyaXRlciBvZiB0aGUgZGV2aWNlIHRyZWUgY29uZmlndXJhdGlvbi4NCg0KRm9yIFNQSSBjb250
cm9sbGVycyB3aGljaCBkbyBub3Qgc3VwcG9ydCB0aGlzIHNldHRpbmcsIHRoZSBTUEkgZnJhbWV3
b3JrDQpjb3VsZCBjaGVjayB3aGV0aGVyIHRoZSBtYXggU1BJIGNsb2NrIGZyZXF1ZW5jeSBvZiB0
aGUgZGV2aWNlIG9yIHRoZQ0KdENMUVYgdmFsdWUgbGltaXRzIHRoZSBTUEkgYnVzIHNwZWVkIGFu
ZCBhZGp1c3QgaXQgYXBwcm9wcmlhdGVseS4NCg0KRm9yIG91ciBjYXNlIHRoaXMgc2VlbXMgYSBs
aXR0bGUgYml0IG9mIG92ZXJraWxsLg0KDQpXaXRoICdkaXNjb3ZlcmFibGUnIGRldmljZXMgb24g
dGhlIFNQSSBidXMgbGlrZSBTUEkgTkFORCBjaGlwcywgdGhlDQonbWF4X3NwZWVkX2h6JyBpbiAn
c3RydWN0IHNwaV9kZXZpY2UnIGlzIG5vIG1vcmUgcmVhbGx5IGRldmljZSBzcGVjaWZpYywNCmJ1
dCBtb3JlIGxpa2UgY2hpcCBzZWxlY3Qgc3BlY2lmaWMuIFRoZSByZWFsIGNoaXBzICdtYXhfc3Bl
ZWRfaHonIGRhdGENCnNoZWV0IHZhbHVlIGNvdWxkIHRoZW4gZS5nLiBiZSBwcm9wYWdhdGVkIGZy
b20gdGhlIGRpc2NvdmVyZWQgY2hpcHMgU1BJDQpkZXZpY2UgZHJpdmVyIHRvIHRoZSBmcmFtZXdv
cmtzICAnY2hpcCBzZWxlY3Qgc3BlY2lmaWMnICAnbWF4X3NwZWVkX2h6Jw0KcHJvcGVydHkuIFdl
IGNvdWxkIGludHJvZHVjZSBhICdwcm9iZV9zcGVlZF9oeicgc2V0dGluZyBhbmQgbWF5YmUNCm1h
bnkgb3RoZXIgdGhpbmdzIC4uLg0KDQouLi4gYnV0IElNSE8gdGhpcyB3b3VsZCBiZSBmYXIgdG9v
IG11Y2ggb2Ygb3ZlcmtpbGwgKGF0IGxlYXN0IGN1cnJlbnRseSkgLi4uDQoNClRoYW5rcywNCkVi
ZXJoYXJkDQo=

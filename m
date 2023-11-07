Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312E77E400D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbjKGN1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjKGN1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:27:41 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2100.outbound.protection.outlook.com [40.107.105.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4908F;
        Tue,  7 Nov 2023 05:27:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dbaqzorrk9wrSKNgHFAjFhF8lYE9kQZezWp/0EZOh98Bf0AdXcwS0CeO2xHtHCR6+X49Xa6M1zpnprL67v8Z/WwL+D6FOuVtahV04gS+EogB+rU3os/WKhOMshmY8ZS8/2tJzVnfTlIfbqW8erDrzG+jE5vBEDrbvWicCNWHY3g0Di2nnB6BPXjuGcrf5qOpHW9FgBSOumSk4rHcpMWUwXqjpoy7wC6h+jWycne36Y6hp5s2TZVfpA1YSd59vbLUhLvaz+5YLbaDmnlJtyB8uSusGavE+uhuXpoz+G9OmWW9FO+oVMdg9S7wLu/W0rlFURZrGR8MAZYUqiKNDPa7Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InHEntjLCpfLJV3fYyU/gFiuypDGNS+tl07tSTAt6aA=;
 b=Ub69Ka51tG0PvJ1iLUZRDKwGwhNJPd1Pg7dDI6Kkf7OgGhGhN58Pdrp1byPHlRhvA2q41IlgsVR5rHekNyaXYoaBJLAMLe108dPHyyD1u5bfd47vpTSQpkY4YFsdUMkwIizv8pRVabUfLzV68Ag0F1gJ+gH/8SwzJ7sgZxVqMdPIaFxsHMVklNc/cm2dsqTE+DQg0P5FC+3qE/4wX05JhNgTgVRbTJyANTEzx0vKDSiSU8acJ4Tkusclh4Zq5sQ1kXPVRd5ZXI7n1uqYAzZinN6giPFKGBuFs6suMr1OIVAl9hmSI/vA2sCuqEeRa/BZyLvGbq0PJ8c0IxXLnP0Vsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=esd.eu; dmarc=pass action=none header.from=esd.eu; dkim=pass
 header.d=esd.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InHEntjLCpfLJV3fYyU/gFiuypDGNS+tl07tSTAt6aA=;
 b=DerFBfdZ235kzJOhHO1XhyHuyKR+C1n43DVchsDOmHpVicXjhJAw4v7HsYuqW/IKXf42VhJKX8vsQ+dAyLtUHfh5nR718B1l15bTxJMjHHsDJUNRppyq9sGsiUoGp4Qv7AzWZBSLg85aDQMvEC1WoG8nsXLFmfPC45M566WK7wg=
Received: from AM6PR03MB4296.eurprd03.prod.outlook.com (2603:10a6:20b:3::16)
 by PA4PR03MB7247.eurprd03.prod.outlook.com (2603:10a6:102:10d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 13:27:34 +0000
Received: from AM6PR03MB4296.eurprd03.prod.outlook.com
 ([fe80::e4c5:63b9:dfd2:c12e]) by AM6PR03MB4296.eurprd03.prod.outlook.com
 ([fe80::e4c5:63b9:dfd2:c12e%6]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 13:27:34 +0000
From:   =?utf-8?B?U3RlZmFuIE3DpHRqZQ==?= <Stefan.Maetje@esd.eu>
To:     "horms@kernel.org" <horms@kernel.org>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH v8 2/2] can: esd: add support for esd GmbH PCIe/402 CAN
 interface family
Thread-Topic: [PATCH v8 2/2] can: esd: add support for esd GmbH PCIe/402 CAN
 interface family
Thread-Index: AQHaB03u0nTHW2tv+kGF6Y7CH9C3B7Bo3JSAgAYRJIA=
Date:   Tue, 7 Nov 2023 13:27:34 +0000
Message-ID: <1a1d0f4257cd980c58b6e2f83e2456dde5fe9441.camel@esd.eu>
References: <20231025141635.1459606-1-stefan.maetje@esd.eu>
         <20231025141635.1459606-3-stefan.maetje@esd.eu>
         <20231103164839.GA714036@kernel.org>
In-Reply-To: <20231103164839.GA714036@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=esd.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB4296:EE_|PA4PR03MB7247:EE_
x-ms-office365-filtering-correlation-id: b8f409e3-f6bf-4369-02d7-08dbdf954d2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TXYv/oO2w8CIOd2m4VNz7g3iiEv+apIaK1bOF7ebLVmltwFYAccAyzrTjBbK1cLvgjwMvzMz2widY87pMxOSCPhXRWQDu3xp+1AsZHybFBJpp5p7ALMCuO0GW9meTM4jIbzgwAtatPKOB/I7TGP3d8GhvAxIwTT6m84bpwTDtQ1WNDnwkBu2IwYJPXSIhMN+hWFrpC0ji2gxwMykSH60SzKuS4g8qjAv4DhcDKEjr7Px5QQ9z2dNhYNUdY2ONyDh+PRyR5G9FdPhDQu3FHjw/Zlp5Rlp/fDBGTC00coLRFaxg9ztCaFBIM66EKTuv5XU4zK+CJyXpe+IYJ+XEqBXJcLPX3htKL2dANsO1CZKLkERgtn01NoTWyALPFKLH6jn2WdY22GgVLuNSfEfqbiI7flRkGR0LQYUY7Mnobrj2f2Mev3dSc+unZybj+p+WKQjaswJ/33X8MYnr5K7dqRl5lncYWpuNmCSm8auJvHT8RI0c8RxfMFyTgicVxry/+uFElKNP/yz1cwC9tj9RfL66JeWM7+L0EmuRPUrljfE/g1M/jFKiVYvnULK+WOUhPcjLDMwwRvaYwCO30sZ6VJHPRkce0NXWPmF+zp21Sldfc3FkhlOA0SpjEbXL6F5EJxOl687BWQVVte4VLbVlkvK9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB4296.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(136003)(376002)(396003)(346002)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6486002)(478600001)(966005)(38070700009)(36756003)(85202003)(85182001)(86362001)(122000001)(38100700002)(83380400001)(91956017)(2616005)(41300700001)(6512007)(7416002)(54906003)(76116006)(66556008)(6506007)(66946007)(71200400001)(66476007)(66446008)(66574015)(64756008)(2906002)(5660300002)(8676002)(316002)(6916009)(4326008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1EzblZZcmVKY3Y3ZDVxdTk1bGRIdC9vV3VCR0I3UHVjQTcwdlByVFB2RElu?=
 =?utf-8?B?R0xHNFI5WGFmelcvOUVjSURuNXdFUzNRUzB0Y2F1UzJyYjVyRE15L1lCTGtC?=
 =?utf-8?B?VlpPd0dvd3ltd3pUc3h2ZTJDbm0ySkkzZVk3bDhYbGloK0hwcU1aWUlYS1Qy?=
 =?utf-8?B?WnVRWURtN3dPL0s0SERpRHdaT1ZDUnI3ZHJsa0ZuM09FeVhRUDBjcmFHcjZY?=
 =?utf-8?B?bysrOGd0ZjlLOEN2L0ZVS0FYRVZmSzN3MEFERVpmSDVpalpOZXB0UDI5OHVH?=
 =?utf-8?B?YjJ2Tm5oSHN2L1Nab0ZLbWVVN0hDNzZjYkJyK3A2cXF0dkdjU0JSQ3ZScWpR?=
 =?utf-8?B?TlEyV3l2UTRZTzRnK2o0d1FtdWtIQ2V6OTdRbkZhNWh4Z3d2SW96Y3FsZVNm?=
 =?utf-8?B?QXM4K0RVV3Y0aHB0emFzWVVKVGNSd1BvcWNBd1VDR2xSR0pFZ1ZaU0xoRnlF?=
 =?utf-8?B?QWhWUm9jUjhzMm9QWUxtSE1Yb1FvWUoyYURtdy9SRERkNW5ybzJNSkJVM3pj?=
 =?utf-8?B?bGl3eWxXa016b3h0bDN3MXBXWmtoYk9sTG1xR1p5Wk9xSGt1VlY1MC91Y1RG?=
 =?utf-8?B?YVBYaURuZlIzWHFlb3ptK1djTlRTU0FOMm4zMmJyZFY1UlQ4YnpHeWtzdjBR?=
 =?utf-8?B?dWUxZ0hCT3ZyNEJiaVRKRmJhaUNROUtMQ1VKVElXVmJuSTZjSU9YdDg3dnpE?=
 =?utf-8?B?WXc0SzBNdVlpeUhPcjNHMzh5TGpCazdhMnM1cGMxdGo2WTdYMlhKNXNxNEcv?=
 =?utf-8?B?bC8zOXZMc1poOGJhTGJmTkxsNTJKTVY5N00wZU8yY09mZzRXMDQzUFUvWWZO?=
 =?utf-8?B?cXFHMnZRaGY0dnlKVlJzdEwrT215djJNVGVTTlBDdUhOTHExMDlEc0lJcGFV?=
 =?utf-8?B?cjY2Z2d5TjA0ejlibGZjb3ZxbzVIOGNmYUsyNEtxUGRYdmtGWkp5c1YzMTI1?=
 =?utf-8?B?MFl2aWVqYmcwOHlJRzFsMDkzT1c2N01YcmM0RTBnLzg5R1JCN1BzRnFxZnc5?=
 =?utf-8?B?ZEMzT2xqSnNQbUI1TUlpZStZaXB0NmRveURsejgyeGx1MUU1QVRQLzBYN2Uz?=
 =?utf-8?B?a1ZacFAxNUI0dm4xRi85Zi9rWmpxOGdMSEVuR3Nqc3BHZVZ5S25tQklrMWt5?=
 =?utf-8?B?NndnMGdvT05rUDV2R3p0SC9mem5IR2Q0ZjhuSGc2Yzd5dXprWEdZWnR2Nkd3?=
 =?utf-8?B?b3RiN244RUZtMzc1bTFtTkZwT2ZBVDVFc0JybG9naHQzUUo4NmQ0YjVJcUhk?=
 =?utf-8?B?TEpBaERlUGlIdDBFekZ4UmVWVjU4OUZpVHFsS2l6ejZsVUJDcDVsM0VjR3NM?=
 =?utf-8?B?bGdBL3VMSHdxUkxIc2JBNitOQ3RRZlVMTExvTWI5NFdzQTN6RDBObko5WFQx?=
 =?utf-8?B?V2hBa0VUN2JQckxhMXVyQzJ2dndXNC9IRFdjbnZycHpoQkFoUzRlUUpLZTc0?=
 =?utf-8?B?SllNcWVOdVRPTjl3SVppVFd6SStKcUxpRnlYbE1KMCtsQ1B2Y21KYnFTc2ZQ?=
 =?utf-8?B?MEY5UzZ5ckphWUJUV1BNVEpqZ2RSVTNrNlpwTEtXS0dQY29Cd3AxbVROREM1?=
 =?utf-8?B?TDg1Q2V2Qk9HY2ZMYVUxN2FQVlJwZmhvblg4TURDWmpwVEIydWVhMGRmdGRR?=
 =?utf-8?B?YVdRNzMwNGV3NllMczU4bWFTK2NYZm5HcE5qa2oxSTVkWk9MR08zTXZPZElG?=
 =?utf-8?B?VzdOTnFsaG02bWtPek9QdWpsalhaNXVCQ3Rtalo4bVBXYnpBQWlyVXR6NHVI?=
 =?utf-8?B?RXM0M2J6NkhqWC8xWU90UUVPMGtnWGtQOUZUWjAvQ2dJQzA5cTVFL09DVXVw?=
 =?utf-8?B?Z3FpL2dGU3ozNWQvdmlmVWNQUG5pdmlZSHlNSXNyUEhOZHMyNnlrSXpLUDg3?=
 =?utf-8?B?Y242ZWE4NHQ0Qk95cTdJditXRXVZV0trZXRYbkhUT0ZkZC85OHV5TGU3N05V?=
 =?utf-8?B?ODJwRmNjdGh6WnF5TzYrOVlWWFVnSmtLQlo3M3lvZkF5a0tYOTZuWEJVVFNz?=
 =?utf-8?B?aHZSUS9taC90UUlQMFJub1dyVXYvZ2NraXpCTWsybXZUMlBYMkJoaGRIcDdK?=
 =?utf-8?B?RTUzSTVXd2FHVEw0QkI4YXVYS2FWMXdYMHBwbW1PUTRXcXEvcWVWRkRpQytU?=
 =?utf-8?B?emJrVkZod29IY0NWOGhjSm1ISU9McUFWWXAvVWlQeGpWdXJxekVMeE9DZWxj?=
 =?utf-8?Q?mviVrOV8xeAFkRIGLVSyBtswiLHoL7LmJ+mRa5IjBcVD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD02141F282D5F4DBA9183CE8C393B4D@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB4296.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f409e3-f6bf-4369-02d7-08dbdf954d2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 13:27:34.0489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rOaCgBJNAumRuWyCbz6QmC2sxlKlfong6hOkgdjx7NlEwh222H/l/MxGh/YiDQVPK3XcG99caEtGJUHoxU+FJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7247
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gRnJlaXRhZywgZGVtIDAzLjExLjIwMjMgdW0gMTY6NDggKzAwMDAgc2NocmllYiBTaW1vbiBI
b3JtYW46Cj4gT24gV2VkLCBPY3QgMjUsIDIwMjMgYXQgMDQ6MTY6MzVQTSArMDIwMCwgU3RlZmFu
IE3DpHRqZSB3cm90ZToKPiA+IFRoaXMgcGF0Y2ggYWRkcyBzdXBwb3J0IGZvciB0aGUgUENJIGJh
c2VkIFBDSWUvNDAyIENBTiBpbnRlcmZhY2UgZmFtaWx5Cj4gPiBmcm9tIGVzZCBHbWJIIHRoYXQg
aXMgYXZhaWxhYmxlIHdpdGggdmFyaW91cyBmb3JtIGZhY3RvcnMKPiA+IChodHRwczovL2VzZC5l
dS9lbi9wcm9kdWN0cy80MDItc2VyaWVzLWNhbi1pbnRlcmZhY2VzKS4KPiA+IAo+ID4gQWxsIGJv
YXJkcyB1dGlsaXplIGEgRlBHQSBiYXNlZCBDQU4gY29udHJvbGxlciBzb2x1dGlvbiBkZXZlbG9w
ZWQKPiA+IGJ5IGVzZCAoZXNkQUNDKS4gRm9yIG1vcmUgaW5mb3JtYXRpb24gb24gdGhlIGVzZEFD
QyBzZWUKPiA+IGh0dHBzOi8vZXNkLmV1L2VuL3Byb2R1Y3RzL2VzZGFjYy4KPiA+IAo+ID4gVGhp
cyBkcml2ZXIgZGV0ZWN0cyBhbGwgYXZhaWxhYmxlIENBTiBpbnRlcmZhY2UgYm9hcmQgdmFyaWFu
dHMgb2YKPiA+IHRoZSBmYW1pbHkgYnV0IGF0bS4gb3BlcmF0ZXMgdGhlIENBTi1GRCBjYXBhYmxl
IGRldmljZXMgaW4KPiA+IENsYXNzaWMtQ0FOIG1vZGUgb25seSEgQSBsYXRlciBwYXRjaCB3aWxs
IGludHJvZHVjZSB0aGUgQ0FOLUZECj4gPiBmdW5jdGlvbmFsaXR5IGluIHRoaXMgZHJpdmVyLgo+
ID4gCj4gPiBDby1kZXZlbG9wZWQtYnk6IFRob21hcyBLw7ZycGVyIDx0aG9tYXMua29lcnBlckBl
c2QuZXU+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgS8O2cnBlciA8dGhvbWFzLmtvZXJwZXJA
ZXNkLmV1Pgo+ID4gU2lnbmVkLW9mZi1ieTogU3RlZmFuIE3DpHRqZSA8c3RlZmFuLm1hZXRqZUBl
c2QuZXU+Cj4gCj4gLi4uCj4gCj4gPiArc3RhdGljIGludCBwY2k0MDJfcHJvYmUoc3RydWN0IHBj
aV9kZXYgKnBkZXYsIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkCj4gPiAqZW50KQo+ID4gK3sK
PiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBwY2k0MDJfY2FyZCAqY2FyZCA9IE5VTEw7Cj4gPiAr
wqDCoMKgwqDCoMKgwqBpbnQgZXJyOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgZXJyID0gcGNp
X2VuYWJsZV9kZXZpY2UocGRldik7Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoZXJyKQo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBlcnI7Cj4gPiArCj4gPiArwqDCoMKg
wqDCoMKgwqBjYXJkID0gZGV2bV9remFsbG9jKCZwZGV2LT5kZXYsIHNpemVvZigqY2FyZCksIEdG
UF9LRVJORUwpOwo+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKCFjYXJkKQo+IAo+IEhpIFRob21hcyBh
bmQgU3RlZmFuLAo+IAo+IElmIHRoaXMgY29uZGl0aW9uIGlzIG1ldCB0aGVuIHRoZSBmdW5jdGlv
biB3aWxsIHJldHVybiBlcnIsCj4gYnV0IGVyciBpcyBzZXQgdG8gMC4gUGVyaGFwcyBpdCBzaG91
bGQgYmUgc2V0IHRvIGFuIGVycm9yIHZhbHVlIGhlcmU/Cj4gCj4gRmxhZ2dlZCBieSBTbWF0Y2gu
CgpIaSBTaW1vbiwKCnRoYW5rIHlvdSBmb3IgcmV2aWV3aW5nIHRoaXMuIExvb2tpbmcgYXQgdGhl
IGNvZGUgaXQgaXMgYXBwYXJlbnRseSB3cm9uZy4KCkkgd2FzIG5vdCBhd2FyZSBvZiBzbWF0Y2gu
IEkgZ290IGEgY29weSBhbmQgY291bGQgcmVwcm9kdWNlIHRoZSBlcnJvciByZXBvcnQuClRoaXMg
d2lsbCBhZGQgYW5vdGhlciB0b29sIG9mIHN0YXRpYyBjb2RlIGFuYWx5c2lzIHRvIG15IHJlbGVh
c2Ugcm91dGluZS4KCkFuIHVwZ3JhZGVkIHBhdGNoIHdpdGggYSBmaXggd2lsbCBmb2xsb3cuCgpC
ZXN0IHJlZ2FyZHMsCiAgICBTdGVmYW4KCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgZ290byBmYWlsdXJlX2Rpc2FibGVfcGNpOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgcGNp
X3NldF9kcnZkYXRhKHBkZXYsIGNhcmQpOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgZXJyID0g
cGNpX3JlcXVlc3RfcmVnaW9ucyhwZGV2LCBwY2lfbmFtZShwZGV2KSk7Cj4gPiArwqDCoMKgwqDC
oMKgwqBpZiAoZXJyKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gZmFp
bHVyZV9kaXNhYmxlX3BjaTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoGNhcmQtPmFkZHIgPSBw
Y2lfaW9tYXAocGRldiwgUENJNDAyX0JBUiwgUENJNDAyX0lPX0xFTl9UT1RBTCk7Cj4gPiArwqDC
oMKgwqDCoMKgwqBpZiAoIWNhcmQtPmFkZHIpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBlcnIgPSAtRU5PTUVNOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGdvdG8gZmFpbHVyZV9yZWxlYXNlX3JlZ2lvbnM7Cj4gPiArwqDCoMKgwqDCoMKgwqB9Cj4gPiAr
Cj4gPiArwqDCoMKgwqDCoMKgwqBlcnIgPSBwY2k0MDJfaW5pdF9jYXJkKHBkZXYpOwo+ID4gK8Kg
wqDCoMKgwqDCoMKgaWYgKGVycikKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBn
b3RvIGZhaWx1cmVfdW5tYXA7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBlcnIgPSBwY2k0MDJf
aW5pdF9kbWEocGRldik7Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoZXJyKQo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gZmFpbHVyZV91bm1hcDsKPiA+ICsKPiA+ICvCoMKg
wqDCoMKgwqDCoGVyciA9IHBjaTQwMl9pbml0X2ludGVycnVwdChwZGV2KTsKPiA+ICvCoMKgwqDC
oMKgwqDCoGlmIChlcnIpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBm
YWlsdXJlX2ZpbmlzaF9kbWE7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBlcnIgPSBwY2k0MDJf
aW5pdF9jb3JlcyhwZGV2KTsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChlcnIpCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBmYWlsdXJlX2ZpbmlzaF9pbnRlcnJ1cHQ7Cj4g
PiArCj4gPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiA+ICsKPiA+ICtmYWlsdXJlX2Zpbmlz
aF9pbnRlcnJ1cHQ6Cj4gPiArwqDCoMKgwqDCoMKgwqBwY2k0MDJfZmluaXNoX2ludGVycnVwdChw
ZGV2KTsKPiA+ICsKPiA+ICtmYWlsdXJlX2ZpbmlzaF9kbWE6Cj4gPiArwqDCoMKgwqDCoMKgwqBw
Y2k0MDJfZmluaXNoX2RtYShwZGV2KTsKPiA+ICsKPiA+ICtmYWlsdXJlX3VubWFwOgo+ID4gK8Kg
wqDCoMKgwqDCoMKgcGNpX2lvdW5tYXAocGRldiwgY2FyZC0+YWRkcik7Cj4gPiArCj4gPiArZmFp
bHVyZV9yZWxlYXNlX3JlZ2lvbnM6Cj4gPiArwqDCoMKgwqDCoMKgwqBwY2lfcmVsZWFzZV9yZWdp
b25zKHBkZXYpOwo+ID4gKwo+ID4gK2ZhaWx1cmVfZGlzYWJsZV9wY2k6Cj4gPiArwqDCoMKgwqDC
oMKgwqBwY2lfZGlzYWJsZV9kZXZpY2UocGRldik7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gZXJyOwo+ID4gK30KPiAKPiAuLi4KCg==

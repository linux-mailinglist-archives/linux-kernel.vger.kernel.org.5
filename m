Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBB77AE495
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 06:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbjIZEd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 00:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjIZEdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 00:33:24 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2038.outbound.protection.outlook.com [40.92.53.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A470DBF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:33:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1VpDf5XMWjoEPDsuYOa4aPD01VoWGmcuBrGX/f5t5Cfdo+eJ5HdHStIofV19kNg8nqP5wwO0eFdz1d5Z0frMHCck5kNcHSPdLsv1qeKQgnoq04dm+eFu2J4Bma1CpYUnPGWiC18KeumlRI6t9KebCkC/V89WFqfHfC9Sx/J7wvsGDLfrPLuT5vpVfudoSDo20AVFudufGT3C6k8dS/k+eGCORWoXUdeFRTf0T3CLZpSb93m7ryXtQ693yRoOuqC6HtXFjWmHSanNYehoVB7GFuvHpQcP3hidmYrE84s7EkfLNacR5nj2WtApLRDrAwigZ7Zl6bs5gdwhFcuNgyk3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DFRkZ60XFLgMn8iXAsOEt8a8h1rBS3ispTgUGowq1A=;
 b=OynLS/Kxohm9F3qUfv18+g4OoAGYHs5Tcu9vU7TDDg94lgv+aLtJWQEqlMNxQfo3P8oWr7QBb1CQpZRwcRiHLCLAblcKALEpJqWiuJMygS2kUe7oNJ9eukE236gsg2/oeMZQhtXpS+rNoSSPttTPyTSf3BOHHK7CwH6Bdv3M8r8y+nQdDbeikRSbESbinR6rchLPDFxs/E/xXLzU85kUVqXw9PRbIoRV622MfbjANyT920aKyvHKako+bH8M4HuNE6/5wZzwHyPPXXNWe+5/L3F8pvVqRpeVRAtwMsHAXwgaadbkg9yQtGNuDnnSWAuxboWh5zPrEqGmk2W5gqaHSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DFRkZ60XFLgMn8iXAsOEt8a8h1rBS3ispTgUGowq1A=;
 b=ZJgBNanneWWqguHiVxcaIZZpAV/jdhSv7fbF7j428SCsB6iC5x0xAL88OT0qskQnxMNqBYDwWS+mNlf/DpkmKaUFwqZKYHtjxHI+IM+Ag/Et/dUO/D+3hyC7Hsyp9k6xS0YlbZqv+ZOungPuyBXp+9IjTgw50Ysn3TBbBddLHrhfyQ18Qet0dshWf7X6ZqN3EIi/6CVUPPjuxX+/J6LNxXsRwaJ/CBr6oBaPlfYSAt2wU7ztlfQXVJLTl3UsSxdGX4wtOgy+iWnKrEfpMzey07/faUv/NXqQ8hngF0nTBTW2slmjsvKNpp7hu+6X7GUjwlvW+SA2bhRr6M+JZsTGrg==
Received: from TY2PR0101MB3136.apcprd01.prod.exchangelabs.com
 (2603:1096:404:e5::14) by TYZPR01MB5416.apcprd01.prod.exchangelabs.com
 (2603:1096:400:28a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 04:33:12 +0000
Received: from TY2PR0101MB3136.apcprd01.prod.exchangelabs.com
 ([fe80::61:7bba:9541:ee98]) by TY2PR0101MB3136.apcprd01.prod.exchangelabs.com
 ([fe80::61:7bba:9541:ee98%6]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 04:33:12 +0000
From:   Kelly Devilliv <kelly.devilliv@outlook.com>
To:     =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBkbWFfbWFwX3Jlc291cmNlKCkgaGFzIGEgYmFkIHBlcmZvcm1h?=
 =?utf-8?B?bmNlIGluIHBjaWUgcGVlciB0byBwZWVyIHRyYW5zYWN0aW9ucyB3aGVuIGlv?=
 =?utf-8?Q?mmu_enabled_in_Linux?=
Thread-Topic: dma_map_resource() has a bad performance in pcie peer to peer
 transactions when iommu enabled in Linux
Thread-Index: Adnvsh05WtiJBSKaQFmKOQwTLVDZzAAJ8ZmAABKt7qA=
Date:   Tue, 26 Sep 2023 04:33:12 +0000
Message-ID: <TY2PR0101MB313667D70F284FC28BE4039B84C3A@TY2PR0101MB3136.apcprd01.prod.exchangelabs.com>
References: <TY2PR0101MB31361E2EE3391EBFAB78014B84FCA@TY2PR0101MB3136.apcprd01.prod.exchangelabs.com>
 <39dff6ed-2fc1-0462-0317-9d1e4c1c718e@amd.com>
In-Reply-To: <39dff6ed-2fc1-0462-0317-9d1e4c1c718e@amd.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [yPC2z6IN2lHvwDNRGpQ37vVMAy6D27LJ]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR0101MB3136:EE_|TYZPR01MB5416:EE_
x-ms-office365-filtering-correlation-id: d3d800fa-1386-4add-6d37-08dbbe49b16d
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 90zsKU8HcG/DXnB5iGr25didFKMYzTOafJQENj64/hcB/+u1WZsm3TuPOaMR7nTg2svH9P1AuXFVbPfL55gEpR+IaV7YLKdbppNE4D/0m9E2J6WG3j5kv39ooTB5F40kQc0H5SG6C0lusTzZd2bgArDt+cMBQXoXpA0/BuJMMJw1UE+L2UlLCUY9IPXrUG9lI88RGw/JlwWHjbHtRt01rC4rnk4yilwOhaL9UC9JcgXdLlwEerjTYCiF5Kb05G4Zi404493iOPHW73aG8ad9KK4BwyHI76h3PO1TP8beQR2i+I3KmgqFvRt5xuqs4dZykxf1Kz74P/gFrORCks+fyVdCa2YYbG+BW3+Z4GwJADW+fKPOsvyOf8FqRbYrSXhpVX+y45EzLdqn3GtzkZzaZZNHIv47pMVzsjpGd+X1SmLCLJOKYZ8AXl5Nd7mObIdsC/NBgxDOnUuf53ngCavxsSMrbd5IL40YOx6W1B6OoY8PwNLQjJWOSUrPG7fqU5HG92TxnYDwqP3o6HrN54jRT4GzaC61aJCNU1KO4ep57k4aga9qi621ls2yOVSKj1Mj
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWRURHRjQ3VBYlVta1hhQ2dqeXd6WkF4S0pxdXlTa0lYVGdTeEkrMW52N3BW?=
 =?utf-8?B?M3J1RG9RWjYzMTZRampDaEdzenR4U0RHNTVIOW5va3duVDVGa3YybndJSm1G?=
 =?utf-8?B?a3FKT1haZDJDSERkVGVQd216OUc5NFFMTGwycDZ2dm9kblExR3o4ek16eU51?=
 =?utf-8?B?T3ZoWUwyV25xb1gyQVNnV0gxYkRwOVJka2Z3YlU5cC9SWkhzNkMweUxzS3pm?=
 =?utf-8?B?cDZ6a3JMZGlVeDR6dk1UZVF4UnZYQUYrWFpPMTJDVHBnRThCYTVDUkpjZDVH?=
 =?utf-8?B?R05ldHNvZ08xd1lPWTJkRUV4UnZMMHU1U0FPeFZiSmlINis0aTdyekt6VURi?=
 =?utf-8?B?anczbUVzSDNCQk5YTzRiSHpvV0FMWFc2WkhoTW5Ob3EyWHNZdmpCQUtDaUN3?=
 =?utf-8?B?MzJYUlZ3bUpqTkRobWJweXUvUEQrNVdiRGxuTXBvQUtVaDlDSDU1NlNaaVg0?=
 =?utf-8?B?RWgzdVU2SjVHS1UxSTZYWGp4dGNCMG9Wc1pzb2owaDVBS0NLSHBUZEpZUXFx?=
 =?utf-8?B?VndjbmNXdnFUQjlwOHJzeUU3NmxnMm5jOEVBWXUvTmdxNkJaWFJxR2ZMSmVn?=
 =?utf-8?B?dVNaZDBtR0RyaVdrVXJ2Q0xkQWZuWElTYUp2NkRBVk9UY2xPYlB4T1dKNEVU?=
 =?utf-8?B?aXlSSjJKbVVHR1ZGSUM5U3JGU2xud1NMQlVibTZCUllKVE1zT0FHMGw4eStX?=
 =?utf-8?B?K3N3alkwemFIcEwzYlNrZUV6Nk1IMDJTcTdzbXVSZzlkbGlMNFQwRFdselBz?=
 =?utf-8?B?R084ZGtDcG1CRW1wbU55OVVldnJFVzlxVUJhY05OZm5DVWVhWnpHMXQ1dkgz?=
 =?utf-8?B?akJwTjRIdnJwWURmamo5aTROcFpuWHRhTHdwNTdSby90Y3RFY0RuVGhRSGNj?=
 =?utf-8?B?MEVFQWw1dlp0dGZad0ozMmtJWXVWdVlGM1JaMTlMV2FPVElLdjVCTWRJVjU4?=
 =?utf-8?B?RkNLbWJwNnlBaS9sK0Qwc2E4UzkrcXNvVHNYVTVrWGFFTnFNSGlWbTJPQmsy?=
 =?utf-8?B?cXZvUnNqaXJtczNPekZ6MDYyRjJiVVlZYjFmdUhBU2ZxU1VYaFRSMWdRUkY1?=
 =?utf-8?B?OEpKU0dZWWtqYUxsdmhTRnJPSlhybktzd0ZuWTJoeGpWMUIweEI1dVovMW9O?=
 =?utf-8?B?QlAvSks3ZFRjdEs1K1plUkVkOWVDZG9xVHA0cmMzRlk1SmVUdEtQYnFRaDF3?=
 =?utf-8?B?SnBJVHJJRlNucHExVFdtbTBVaE55ZTlnSFdFQlhBTERRekdtUzRKaTlrS0RY?=
 =?utf-8?B?QlJiNVkxelpUckRmUHBWdUpQUWd3Q3REQmx2cnBuS2dlbnBpN0hkU1Raa1kw?=
 =?utf-8?B?VEI3RE1nZVEyUU01Wmd3bGJBOGZUc1QvZDdNNkFEQytWV0JnL1haV3hYaEx5?=
 =?utf-8?B?MFVFRUlwOEtUd0U1VWdqRGFDd0FtbmxLekR1dVlIZGg1MlpEaDFLWk1iQi9p?=
 =?utf-8?B?ZTRmbHkrOXBWaytLa0lQM3VFcnFaM1ovSFlrVWZzZFhkZWxWRGt6d3NCa3VP?=
 =?utf-8?B?aUtQeUJKMEIwNXZ0UlFYVzQvZ3RrcWQzMHkwL1BnQnVWRHRLR2VYVUl4OG1M?=
 =?utf-8?B?RGxmQnVYbXRyUEJyTDRKNEt5ZHlzK1ZmQjZhejBQSVNRNzVIQzd0OGxSd3FW?=
 =?utf-8?B?SmNtekxrZ2VPS1dFRHNSV1hFSUJ1L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR0101MB3136.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d800fa-1386-4add-6d37-08dbbe49b16d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 04:33:12.1236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB5416
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMy0wOS0yNiAwMTo1OCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToNCj4gQW0gMjUuMDku
MjMgdW0gMTY6MTcgc2NocmllYiBLZWxseSBEZXZpbGxpdjoNCj4+IE9uIDIwMjMtMDktMjUgMTk6
MTYsIFJvYmluIE11cnBoeSB3cm90ZToNCj4+PiBPbiAyMDIzLTA5LTI1IDA0OjU5LCBLZWxseSBE
ZXZpbGxpdiB3cm90ZToNCj4+Pj4gRGVhciBhbGwsDQo+Pj4+DQo+Pj4+IEkgYW0gd29ya2luZyBv
biBhbiBBUk0tVjggc2VydmVyIHdpdGggdHdvIGdwdSBjYXJkcyBvbiBpdC4gUmVjZW50bHksDQo+
Pj4+IEkgbmVlZA0KPj4+PiB0byB0ZXN0IHBjaWUgcGVlciB0byBwZWVyIGNvbW11bmljYXRpb24g
YmV0d2VlbiB0aGUgdHdvIGdwdSBjYXJkcywNCj4+Pj4gYnV0IHRoZSB0aHJvdWdocHV0IGlzIG9u
bHkgNEdCL3MuDQo+Pj4+IEFmdGVyIEkgZXhwbG9yZWQgdGhlIGdwdSdzIGtlcm5lbCBtb2RlIGRy
aXZlciwgSSBmb3VuZCBpdCB3YXMgdXNpbmcNCj4+Pj4gdGhlIGRtYV9tYXBfcmVzb3VyY2UoKSBB
UEkgdG8gbWFwIHRoZSBwZWVyIGRldmljZSdzIE1NSU8gc3BhY2UuIFRoZSBhcm0NCj4+Pj4gaW9t
bXUgZHJpdmVyIHRoZW4gd2lsbCBoYXJkY29kZSBhICdJT01NVV9NTUlPJyBwcm90IGluIHRoZSBs
YXRlciBkbWEgbWFwOg0KPj4+PiAgICAgICAgICBzdGF0aWMgZG1hX2FkZHJfdCBpb21tdV9kbWFf
bWFwX3Jlc291cmNlKHN0cnVjdCBkZXZpY2UNCj4+Pj4gKmRldiwNCj4+Pj4gcGh5c19hZGRyX3Qg
cGh5cywNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVfdCBzaXpl
LCBlbnVtDQo+Pj4+IGRtYV9kYXRhX2RpcmVjdGlvbg0KPj4+PiBkaXIsIHVuc2lnbmVkIGxvbmcg
YXR0cnMpDQo+Pj4+ICAgICAgICAgICB7DQo+Pj4+ICAgICAgICAgICAgICAgICAgIHJldHVybiBf
X2lvbW11X2RtYV9tYXAoZGV2LCBwaHlzLCBzaXplLA0KPj4+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBkbWFfaW5mb190b19wcm90KGRpciwNCj4+Pj4gZmFsc2Us
DQo+Pj4+IGF0dHJzKSB8IElPTU1VX01NSU8sDQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGRtYV9nZXRfbWFzayhkZXYpKTsNCj4+Pj4gICAgICAgICAgIH0N
Cj4+Pj4NCj4+Pj4gQW5kIHRoYXQgd2lsbCBmaW5hbGx5IHNldCB0aGUgJ0FSTV9MUEFFX1BURV9N
RU1BVFRSX0RFVicgYXR0cmlidXRlDQo+Pj4+IGluIFBURSwNCj4+Pj4gd2hpY2ggbWF5IGhhdmUg
YSBuZWdhdGl2ZSBpbXBhY3Qgb24gdGhlIHBlcmZvcm1hbmNlIG9mIHRoZSBwY2llIHBlZXINCj4+
Pj4gdG8gcGVlciB0cmFuc2FjdGlvbnMuDQo+Pj4+ICAgICAgICAgICAvKg0KPj4+PiAgICAgICAg
ICAgICogTm90ZSB0aGF0IHRoaXMgbG9naWMgaXMgc3RydWN0dXJlZCB0byBhY2NvbW1vZGF0ZSBN
YWxpIExQQUUNCj4+Pj4gICAgICAgICAgICAqIGhhdmluZyBzdGFnZS0xLWxpa2UgYXR0cmlidXRl
cyBidXQgc3RhZ2UtMi1saWtlIHBlcm1pc3Npb25zLg0KPj4+PiAgICAgICAgICAgICovDQo+Pj4+
ICAgICAgICAgICBpZiAoZGF0YS0+aW9wLmZtdCA9PSBBUk1fNjRfTFBBRV9TMiB8fA0KPj4+PiAg
ICAgICAgICAgICAgIGRhdGEtPmlvcC5mbXQgPT0gQVJNXzMyX0xQQUVfUzIpIHsNCj4+Pj4gICAg
ICAgICAgICAgICAgICAgaWYgKHByb3QgJiBJT01NVV9NTUlPKQ0KPj4+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHB0ZSB8PSBBUk1fTFBBRV9QVEVfTUVNQVRUUl9ERVY7DQo+Pj4+ICAgICAg
ICAgICAgICAgICAgIGVsc2UgaWYgKHByb3QgJiBJT01NVV9DQUNIRSkNCj4+Pj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICBwdGUgfD0gQVJNX0xQQUVfUFRFX01FTUFUVFJfT0lXQjsNCj4+Pj4g
ICAgICAgICAgICAgICAgICAgZWxzZQ0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIHB0
ZSB8PSBBUk1fTFBBRV9QVEVfTUVNQVRUUl9OQzsNCj4+Pj4gICAgICAgICAgIH0gZWxzZSB7DQo+
Pj4+ICAgICAgICAgICAgICAgICAgIGlmIChwcm90ICYgSU9NTVVfTU1JTykNCj4+Pj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICBwdGUgfD0gKEFSTV9MUEFFX01BSVJfQVRUUl9JRFhfREVWDQo+
Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8PA0KPkFSTV9MUEFFX1BURV9B
VFRSSU5EWF9TSElGVCk7DQo+Pj4+ICAgICAgICAgICAgICAgICAgIGVsc2UgaWYgKHByb3QgJiBJ
T01NVV9DQUNIRSkNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICBwdGUgfD0gKEFSTV9M
UEFFX01BSVJfQVRUUl9JRFhfQ0FDSEUNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDw8DQo+QVJNX0xQQUVfUFRFX0FUVFJJTkRYX1NISUZUKTsNCj4+Pj4gICAgICAgICAg
IH0NCj4+Pj4NCj4+Pj4gSSB0cmllZCB0byByZW1vdmUgdGhlICdJT01NVV9NTUlPJyBwcm90IGlu
IHRoZSBkbWFfbWFwX3Jlc291cmNlKCkNCj4+Pj4gQVBJDQo+Pj4+IGFuZCByZS1jb21waWxlIHRo
ZSBsaW51eCBrZXJuZWwsIHRoZSB0aHJvdWdocHV0IHRoZW4gY2FuIGJlIHVwIHRvIDI4R0Ivcy4N
Cj4+Pj4gSXMgdGhlcmUgYW4gZWxlZ2FudCB3YXkgdG8gc29sdmUgdGhpcyBpc3N1ZSB3aXRob3V0
IG1vZGlmeWluZyB0aGUgbGludXgga2VybmVsPw0KPj4+PiBlLmcuLCBhIHN1YnN0aXR1dGlvbiBv
ZiBkbWFfbWFwX3Jlc291cmNlKCkgQVBJPw0KPj4+DQo+Pj4gTm90IHJlYWxseS4gT3RoZXIgdXNl
LWNhc2VzIGZvciBkbWFfbWFwX3Jlc291cmNlKCkgaW5jbHVkZSBETUENCj4+PiBvZmZsb2FkIGVu
Z2luZXMgYWNjZXNzaW5nIEZJRk8gcmVnaXN0ZXJzLCB3aGVyZSBhbGxvd2luZyByZW9yZGVyaW5n
LA0KPj4+IHdyaXRlLWdhdGhlcmluZywgZXRjLiB3b3VsZCBiZSBhIHRlcnJpYmxlIGlkZWEuIFRo
dXMgaXQgbmVlZHMgdG8NCj4+PiBhc3N1bWUgYSAic2FmZSIgTU1JTyBtZW1vcnkgdHlwZSwgd2hp
Y2ggb24gQXJtIG1lYW5zIERldmljZS1uR25SRS4NCj4+Pg0KPj4+IEhvd2V2ZXIsIHRoZSAicHJv
cGVyIiBQQ0kgcGVlci10by1wZWVyIHN1cHBvcnQgdW5kZXINCj4+PiBDT05GSUdfUENJX1AyUERN
QSBlbmRlZCB1cCBtb3ZpbmcgYXdheSBmcm9tIHRoZQ0KPmRtYV9tYXBfcmVzb3VyY2UoKQ0KPj4+
IGFwcHJvYWNoIGFueXdheSwgYW5kIGFsbG93cyB0aGlzIGtpbmQgb2YgZGV2aWNlIG1lbW9yeSB0
byBiZSB0cmVhdGVkDQo+Pj4gbW9yZSBsaWtlIHJlZ3VsYXIgbWVtb3J5ICh2aWENCj4+PiBaT05F
X0RFVklDRSkgcmF0aGVyIHRoYW4gYXJiaXRyYXJ5IE1NSU8gcmVzb3VyY2VzLCBzbyB5b3VyIGJl
c3QgYmV0DQo+Pj4gd291bGQgYmUgdG8gZ2V0IHRoZSBHUFUgZHJpdmVyIGNvbnZlcnRlZCBvdmVy
IHRvIHVzaW5nIHRoYXQuDQo+Pg0KPj4gVGhhbmtzIFJvYmluLg0KPj4gU28geW91ciBzdWdnZXN0
aW9uIGlzIHdlJ2QgYmV0dGVyIHdvcmsgb3V0IGEgbmV3IGltcGxlbWVudGF0aW9uIGp1c3QNCj4+
IGFzIHdoYXQgaXQgZG9lcyB1bmRlciBDT05GSUdfUENJX1AyUERNQSBpbnN0ZWFkIG9mIGp1c3Qg
dXNpbmcgdGhlDQo+PiBkbWFfbWFwX3Jlc291cmNlKCkgQVBJPw0KPj4NCj4+IEkgaGF2ZSBleHBs
b3JlZCB0aGUgR1BVIGRyaXZlcnMgZnJvbSBBTUQsIE52aWRpYSBhbmQgaGFiYW5hbGFicywgZS5n
LiwNCj4+IGFuZCBmb3VuZCB0aGV5IGFsbCB1c2luZyB0aGUgZG1hX21hcF9yZXNvdXJjZSgpIEFQ
SSB0byBtYXAgdGhlIHBlZXINCj4+IGRldmljZSdzIGJhciBhZGRyZXNzLg0KPj4gSWYgc28sIGlz
IGl0IHBvc3NpYmxlIHRvIGJlIGEgY29tbW9uIHBlcmZvcm1hbmNlIGlzc3VlIGluIFBDSSBwZWVy
LXRvLXBlZXINCj4+IHNjZW5hcmlvPw0KPg0KPiBUaGF0J3Mgbm90IGFuIGlzc3VlLCBidXQgZXhw
ZWN0ZWQgYmVoYXZpb3IuDQo+DQo+IFdoZW4geW91IGVuYWJsZSBJT01NVSBldmVyeSB0cmFuc2Fj
dGlvbiBuZWVkcyB0byBnbyB0aHJvdWdoIHRoZSByb290DQo+IGNvbXBsZXggZm9yIGFkZHJlc3Mg
dHJhbnNsYXRpb24gYW5kIHlvdSBjb21wbGV0ZWx5IGxvc2UgdGhlIHBlcmZvcm1hbmNlDQo+IGJl
bmVmaXQgb2YgUENJZSBQMlAuDQoNClRoYW5rcyBDaHJpc3RpYW4uIFRoYXQncyB0cnVlLg0KDQo+
DQo+IFRoaXMgaXMgYSBoYXJkd2FyZSBsaW1pdGF0aW9uIGFuZCBub3QgcmVhbGx5IHJlbGF0ZWQg
dG8NCj4gZG1hX21hcF9yZXNvdXJjZSgpIGluIGFueSB3YXkuDQo+DQoNCkJ1dCB3aGVuIEkgcmVt
b3ZlZCB0aGUgJ0lPTU1VX01NSU8nIHByb3QgaW4gZG1hX21hcF9yZXNvdXJjZSgpLCB0aGUgcGVy
Zm9ybWFjZSB3YXMgc2lnbmlmaWNhbnRseSBpbXByb3ZlZCAoZnJvbSA0R0IvcyB0byAyOEdCL3Mp
LCB3aGljaCB3YXMgYWxtb3N0IHRoZSBzYW1lIGFzIHdoYXQgaXQgY2FuIGJlIHdoZW4gSU9NTVUg
ZGlzYWJsZWQuIFNvIEkgZ3Vlc3MgaW4gbXkgY29tbW9uIHBjaSB0b3BvbG9neSwgd2hhdCByZWFs
bHkgbWF0dGVycyBtYXkgbm90IGJlIHdoZXRoZXIgSU9NTVUgaXMgZW5hYmxlZCBvciBub3QsIGJ1
dCBpbiBmYWN0IHRoZSBhdHRyaWJ1dGVzIGluIGRtYSBtYXBwaW5nIG9yIEFSTSBQVEUgZG9lcy4N
Cg0KSSBkb24ndCBrbm93IGlmIHRoZXJlIGlzIGEgd2F5IHRvIG1ha2UgdGhlIG1lbW9yeSBhdHRy
aWJ1dGVzIG1vcmUgY29uZmlndXJhYmxlIGluIG9yZGVyIHRvIGJlIGRpc3Rpbmd1aXNoZWQgZnJv
bSB0aGUgInNhZmUiIE1NSU8gbWVtb3J5IHR5cGUsIHdoaWNoIG9uIEFybSBtZWFucyBEZXZpY2Ut
bkduUkUgYXMgUm9iaW4gc2FpZC4NCg0KU2luY2VyZWx5LA0KS2VsbHkNCg0KPiBSZWdhcmRzLA0K
PiBDaHJpc3RpYW4uDQo+DQo+Pg0KPj4+IFRoYW5rcywNCj4+PiBSb2Jpbi4NCj4+Pg0KPj4+PiBU
aGFuayB5b3UhDQo+Pj4+DQo+Pj4+IFBsYXRmb3JtIGluZm86DQo+Pj4+IExpbnV4IGtlcm5lbCB2
ZXJzaW9uOiA1LjEwDQo+Pj4+IFBDSUUgR0VONCB4MTYNCj4+Pj4NCj4+Pj4gU2luY2VyZWx5LA0K
Pj4+PiBLZWxseQ0KPj4+Pg0KDQo=

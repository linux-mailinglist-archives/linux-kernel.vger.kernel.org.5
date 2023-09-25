Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3380F7AD9EB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjIYORd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjIYORb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:17:31 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2040.outbound.protection.outlook.com [40.92.52.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C45BFC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:17:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+4HN5ti1CiZ7jeT4l9DE9rnKHA+NL7cX2khS4j07PBqgFIrk4F69VUYdsczGUJCqcaMOdQV4XBaAdQaSBpxpwPCxFjiHJ/apDrGeabjzxwNYy5jsIW+OluhiOkcGWfW3gWhSQa9FzlfiDLqjjCeUkpHakRbzN7l0y8HkeTbBG4VzjaSjqlhfgBjyVwccUTKxhEZslFgFZR6KTGXr311vxyV3/wTCZYaqRraMU/Z+iarazrXGLNWa3LPbZutvy4Ezwirx3y0NMk6qf70PyW3ZJW0kBddv5bbDk5V9ilQUkFKPxxCReBtgPo3e7g8gTvMadWmzbNRfDvNAleidMdlOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiLCyaHvZHgTcgzw6C9kEy6h5jQ04EN25wWdp0jyFks=;
 b=eqhL79KRnr0M8ZmTTNyCTm9KPhfwa4mA1pGTvOZYxviUBYU84UW1JamHGL8Z3slheRWx6W6h0wBoHFIkZnn/IYjbekIL/2w1xRv68TnkTdWIrv+Snhk/LwmfJag8S3ML9wkeGejjo68F2ue4bmZi0WLNpHrjzhZ5EDljSMSLxbfnb1u29ncRn+zGdNH5R2t+1abCDTmGtWUnWag+J3HHtRdn2R/gihx03TOdvF2QrApwN6hG53K3rCx1Dbmva/BWBQ/L+e6JmHPsiqND3JrgUCUW5EOrAIdp6nFajCamfMQxhlRUN6p2ze0ktS3jrV/KlvEg4vFNK9TuJlBihN2EQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiLCyaHvZHgTcgzw6C9kEy6h5jQ04EN25wWdp0jyFks=;
 b=W7WtnL+YM7//SoNmKDkQx0XMHdb8fq4uBE+X6sgkPNVIZ8sY8VPgksO8uNm2PHiqv5FE4gdzS6MJXgcvTYFF+7EcymbRw1SRRj9PuL1P2FfBJ+R1pa5Ws3iYYZudcTI/PNk8d4pjYcxGb1LWJDJohsrjtknEh9GCI6I0AQ/jnB9jdNF1f/EgZ1Hg0vjNh2ExMbqQdgZVUfoYJuNIw7VqxIsF/t91+1bvaYhzMfnOmbwho8e4s/GhVfKgCVPg/HhNPWRfYJUQ3YnpONQBug6R93oF9zRFUGq4UkVdVEvyimzOMLm2cPawAck17BiyfUIzz4iIWdt53RT9fuw2WtubrQ==
Received: from TY2PR0101MB3136.apcprd01.prod.exchangelabs.com
 (2603:1096:404:e5::14) by SEYPR01MB5535.apcprd01.prod.exchangelabs.com
 (2603:1096:101:13c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 14:17:19 +0000
Received: from TY2PR0101MB3136.apcprd01.prod.exchangelabs.com
 ([fe80::61:7bba:9541:ee98]) by TY2PR0101MB3136.apcprd01.prod.exchangelabs.com
 ([fe80::61:7bba:9541:ee98%6]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 14:17:19 +0000
From:   Kelly Devilliv <kelly.devilliv@outlook.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: dma_map_resource() has a bad performance in pcie peer to peer
 transactions when iommu enabled in Linux
Thread-Topic: dma_map_resource() has a bad performance in pcie peer to peer
 transactions when iommu enabled in Linux
Thread-Index: Adnvsh05WtiJBSKaQFmKOQwTLVDZzA==
Date:   Mon, 25 Sep 2023 14:17:19 +0000
Message-ID: <TY2PR0101MB31361E2EE3391EBFAB78014B84FCA@TY2PR0101MB3136.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [FQhn8SGKHtrWP7z9RoD10hzG+L+k4GHO]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR0101MB3136:EE_|SEYPR01MB5535:EE_
x-ms-office365-filtering-correlation-id: f344dbbf-22d6-4e0e-c93d-08dbbdd220d3
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: taHMEerZqaEapeFEVyMhCv+ozlpyr8NnwMCwm7ABD1ADw0VMJjDdYEZLFG5THiJ5g288L+/1524ro0ADG+9btktB2bR385CqXN8ZXvgKfCgIO3a0fJpqwoGmrK5KF78SQZW2wQmDdyizMVk7cT9+gCO9Hw6bjeSixXvwIG0xup5DGk1t9JeApti9XJ33meKeiOS2yIZpoBIJJK8FMkPiA9cRIcsLxIuWf3dKhMpm9uqLGHwq8cMG8V1EihEElK2uDmo8ciBGRmb0mtee/F5oDJq/vVPyxTphb6YYdehS8VgKctdmiszdTdBqZ7znDa22XRV/IgJFYWAmYhI//94t5G8VZMrt9nCgP/GnhR4teqantOOYyZayAqJ2QGm7FaB8tVjeG4lN5tBJukF5EmNRfvDynMNm5ukwUZmEkFZuvsEDbjrgly9zX0BFSo4qLUkoSndNPUDtzTWWiU8OwOVKa6vKpHNqWyRSE269W7O/4Gg5z5IPA1OIeKDSkYUJ7G2vJeEbNMH6+YfAygWkRo1wwxZkJX50r8ecz3pfx3Vf/+TFxFn7TOtrX82A0vnhehY/
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cW5jWG1FUlU5TGJibjJvKzdJOEFrd2F5dmFFRXczTHM4cnN4YnpQbFRsWHUy?=
 =?utf-8?B?M05YMFBWRUk2NDRpOGtCTkUxeFJKYzRYZkhyZG5tSXNnWGVqRWRhaGVYNW5R?=
 =?utf-8?B?SzNxOHZMcGx0YUtKeE82eG8zZHl6dksvcjlxUkFOeGZjRDVZRHFON0VGUmd4?=
 =?utf-8?B?YnV0dmF0TDc3aWZQOHFQOWZCMHBnN3JPZldoRGNsZVY3QjZPUGhvT3ZwbWFE?=
 =?utf-8?B?cEZwb3JrSk16K2Jia0FjR2N4RkY3YzUvSWIvQ1JVTVp4WndNakhhZ2dia0ZH?=
 =?utf-8?B?ajZCR0xWTkVTWFpnT3Z2eDZ4S2FzaXpBdTBOb1NYblRrc291NGhOVm1VQmFD?=
 =?utf-8?B?aWVvRVRYdlNHcjZVcjFjQmlxdi9EM0M2cWp5YjhTMlR5dU9MOEZoS1lEUW5i?=
 =?utf-8?B?dElHMnRnRWhVYWZaVXBSTUM1dzFrNVE1ZjZOVVZyQjUvRTJadlJ6K1lIbGVt?=
 =?utf-8?B?dVc4clB3OFNKdW9MZk44Y004WHduMlBWelhhNUJOYng4Wm81SzFSMlNsUUFa?=
 =?utf-8?B?MjRnUUc1TEd6TERPVlg2U3FweXBIaVJ1OVF0QjNZTVc4c1JWL0ZuS2t2SmpO?=
 =?utf-8?B?eGpYTE5LbVJacUZKSzJjZUw4eUxyaDdCNnZnRG1QUjNUN25HWnZSOU81U0Z3?=
 =?utf-8?B?M3d4VXRHUy9HY1FORzVhTDhpSGpUN1J1alM3UDhYZ04yY21RZnJRWjQ1WStQ?=
 =?utf-8?B?MUhpQVVVeC9mZ3lFbGpCKzkrVHdCaUNFZmZLaU5hV3dxVWNkd1ZXOEJ0UFd2?=
 =?utf-8?B?U3RlZzVSdmhBTERaVE9GS1NBUW43Y3c3d2EwRE8yTHczdUVrRjlVQVkzK0tB?=
 =?utf-8?B?b2FRTFdDanZjR3Z3ekRUcEpxVVlVSFdkUWVsWGIvaURBR1UveTBadkx6cDBO?=
 =?utf-8?B?RksxMWJYOEJWWGs3ck1tQlZhOVFPNEJ1UXkwc2F6cVFFTUoxSmRBM3I3Z0lP?=
 =?utf-8?B?L245NWtrSExYUDhIVzZkbjFUbUhtc0kvcFIrZUNYVnEyNUgvakZQZ1pNbU52?=
 =?utf-8?B?TVBBSFNjbU9kcGoxMy9iSG9sdjlBRGNYcVhKUkc3YjNoVUpGUEFUZmhqUkcv?=
 =?utf-8?B?UUdUSXd1ejhtV3V5b3h6NTFOWGhJN0g2MG9Oeng5QnBqM2NmcjFJMDB3NWZ6?=
 =?utf-8?B?MEtXYnJIOHNWYlVOK3d0NWpNSFpNWmI0MjBYd3dMZG1WdDA1S1V6aGk3Z0Zw?=
 =?utf-8?B?MWFXd2llZEpuOHgvTnh4RXBXeXJ0UnVWeFcvRnR5bEdyYjZkbDFDTnllVnI2?=
 =?utf-8?B?azFsa1VJcXhhVThWUU9VODlvaStqVXJzajR3TExhR2RubEN5RmxCQ1V5TzFk?=
 =?utf-8?B?TkJkbmVSWURLNVdJUUd1ZFhSWW95YmpXWmZSRVVRalBMWCsvZWVKVVEvU1hL?=
 =?utf-8?B?ZzhTcEVhTm02QlJ2K002VFJWUG5UV0szWmN3a3dtc25MMFJmNkVTcFlTdUJM?=
 =?utf-8?B?SkNMQXV0VFB3dWlhMHA0blJVbWQwaitQWnJnOG1hek9yaEk4OVRtUi83NEN0?=
 =?utf-8?B?eTBCd21aV3FTS1kwdVFEV3pEOVA0UWtGQ0g3d0gwZDlXUjBhc3hZTGhNQk00?=
 =?utf-8?B?WE44Nklld1ZYZXJPbDdpamJ3MnRkUEd5eVo1K3ZtNkhNdHVFbnlaeU5mZUoy?=
 =?utf-8?B?TWJFdkw4LzJRakJoTTdCcHZGeENMcWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR0101MB3136.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f344dbbf-22d6-4e0e-c93d-08dbbdd220d3
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 14:17:19.4391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5535
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAyMDIzLTA5LTI1IDA0OjU5LCBLZWxseSBEZXZpbGxpdiB3cm90ZToNCj4gPiBEZWFyIGFs
bCwNCj4gPg0KPiA+IEkgYW0gd29ya2luZyBvbiBhbiBBUk0tVjggc2VydmVyIHdpdGggdHdvIGdw
dSBjYXJkcyBvbiBpdC4gUmVjZW50bHksIEkgbmVlZA0KPiB0byB0ZXN0IHBjaWUgcGVlciB0byBw
ZWVyIGNvbW11bmljYXRpb24gYmV0d2VlbiB0aGUgdHdvIGdwdSBjYXJkcywgYnV0IHRoZQ0KPiB0
aHJvdWdocHV0IGlzIG9ubHkgNEdCL3MuDQo+ID4NCj4gPiBBZnRlciBJIGV4cGxvcmVkIHRoZSBn
cHUncyBrZXJuZWwgbW9kZSBkcml2ZXIsIEkgZm91bmQgaXQgd2FzIHVzaW5nIHRoZQ0KPiBkbWFf
bWFwX3Jlc291cmNlKCkgQVBJIHRvIG1hcCB0aGUgcGVlciBkZXZpY2UncyBNTUlPIHNwYWNlLiBU
aGUgYXJtDQo+IGlvbW11IGRyaXZlciB0aGVuIHdpbGwgaGFyZGNvZGUgYSAnSU9NTVVfTU1JTycg
cHJvdCBpbiB0aGUgbGF0ZXIgZG1hIG1hcDoNCj4gPg0KPiA+ICAgICAgICAgc3RhdGljIGRtYV9h
ZGRyX3QgaW9tbXVfZG1hX21hcF9yZXNvdXJjZShzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+IHBoeXNf
YWRkcl90IHBoeXMsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZV90
IHNpemUsIGVudW0gZG1hX2RhdGFfZGlyZWN0aW9uDQo+IGRpciwgdW5zaWduZWQgbG9uZyBhdHRy
cykNCj4gPiAgICAgICAgICB7DQo+ID4gICAgICAgICAgICAgICAgICByZXR1cm4gX19pb21tdV9k
bWFfbWFwKGRldiwgcGh5cywgc2l6ZSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGRtYV9pbmZvX3RvX3Byb3QoZGlyLCBmYWxzZSwNCj4gYXR0cnMpIHwgSU9N
TVVfTU1JTywNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRt
YV9nZXRfbWFzayhkZXYpKTsNCj4gPiAgICAgICAgICB9DQo+ID4NCj4gPiBBbmQgdGhhdCB3aWxs
IGZpbmFsbHkgc2V0IHRoZSAnQVJNX0xQQUVfUFRFX01FTUFUVFJfREVWJyBhdHRyaWJ1dGUgaW4g
UFRFLA0KPiB3aGljaCBtYXkgaGF2ZSBhIG5lZ2F0aXZlIGltcGFjdCBvbiB0aGUgcGVyZm9ybWFu
Y2Ugb2YgdGhlIHBjaWUgcGVlciB0byBwZWVyDQo+IHRyYW5zYWN0aW9ucy4NCj4gPg0KPiA+ICAg
ICAgICAgIC8qDQo+ID4gICAgICAgICAgICogTm90ZSB0aGF0IHRoaXMgbG9naWMgaXMgc3RydWN0
dXJlZCB0byBhY2NvbW1vZGF0ZSBNYWxpIExQQUUNCj4gPiAgICAgICAgICAgKiBoYXZpbmcgc3Rh
Z2UtMS1saWtlIGF0dHJpYnV0ZXMgYnV0IHN0YWdlLTItbGlrZSBwZXJtaXNzaW9ucy4NCj4gPiAg
ICAgICAgICAgKi8NCj4gPiAgICAgICAgICBpZiAoZGF0YS0+aW9wLmZtdCA9PSBBUk1fNjRfTFBB
RV9TMiB8fA0KPiA+ICAgICAgICAgICAgICBkYXRhLT5pb3AuZm10ID09IEFSTV8zMl9MUEFFX1My
KSB7DQo+ID4gICAgICAgICAgICAgICAgICBpZiAocHJvdCAmIElPTU1VX01NSU8pDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgIHB0ZSB8PSBBUk1fTFBBRV9QVEVfTUVNQVRUUl9ERVY7DQo+
ID4gICAgICAgICAgICAgICAgICBlbHNlIGlmIChwcm90ICYgSU9NTVVfQ0FDSEUpDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgIHB0ZSB8PSBBUk1fTFBBRV9QVEVfTUVNQVRUUl9PSVdCOw0K
PiA+ICAgICAgICAgICAgICAgICAgZWxzZQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICBw
dGUgfD0gQVJNX0xQQUVfUFRFX01FTUFUVFJfTkM7DQo+ID4gICAgICAgICAgfSBlbHNlIHsNCj4g
PiAgICAgICAgICAgICAgICAgIGlmIChwcm90ICYgSU9NTVVfTU1JTykNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgcHRlIHw9IChBUk1fTFBBRV9NQUlSX0FUVFJfSURYX0RFVg0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDw8IEFSTV9MUEFFX1BURV9BVFRSSU5EWF9T
SElGVCk7DQo+ID4gICAgICAgICAgICAgICAgICBlbHNlIGlmIChwcm90ICYgSU9NTVVfQ0FDSEUp
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgIHB0ZSB8PSAoQVJNX0xQQUVfTUFJUl9BVFRS
X0lEWF9DQUNIRQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDw8IEFSTV9M
UEFFX1BURV9BVFRSSU5EWF9TSElGVCk7DQo+ID4gICAgICAgICAgfQ0KPiA+DQo+ID4gSSB0cmll
ZCB0byByZW1vdmUgdGhlICdJT01NVV9NTUlPJyBwcm90IGluIHRoZSBkbWFfbWFwX3Jlc291cmNl
KCkgQVBJDQo+IGFuZCByZS1jb21waWxlIHRoZSBsaW51eCBrZXJuZWwsIHRoZSB0aHJvdWdocHV0
IHRoZW4gY2FuIGJlIHVwIHRvIDI4R0Ivcy4NCj4gPg0KPiA+IElzIHRoZXJlIGFuIGVsZWdhbnQg
d2F5IHRvIHNvbHZlIHRoaXMgaXNzdWUgd2l0aG91dCBtb2RpZnlpbmcgdGhlIGxpbnV4IGtlcm5l
bD8NCj4gZS5nLiwgYSBzdWJzdGl0dXRpb24gb2YgZG1hX21hcF9yZXNvdXJjZSgpIEFQST8NCj4g
DQo+IE5vdCByZWFsbHkuIE90aGVyIHVzZS1jYXNlcyBmb3IgZG1hX21hcF9yZXNvdXJjZSgpIGlu
Y2x1ZGUgRE1BIG9mZmxvYWQNCj4gZW5naW5lcyBhY2Nlc3NpbmcgRklGTyByZWdpc3RlcnMsIHdo
ZXJlIGFsbG93aW5nIHJlb3JkZXJpbmcsIHdyaXRlLWdhdGhlcmluZywNCj4gZXRjLiB3b3VsZCBi
ZSBhIHRlcnJpYmxlIGlkZWEuIFRodXMgaXQgbmVlZHMgdG8gYXNzdW1lIGEgInNhZmUiIE1NSU8g
bWVtb3J5DQo+IHR5cGUsIHdoaWNoIG9uIEFybSBtZWFucyBEZXZpY2UtbkduUkUuDQo+IA0KPiBI
b3dldmVyLCB0aGUgInByb3BlciIgUENJIHBlZXItdG8tcGVlciBzdXBwb3J0IHVuZGVyIENPTkZJ
R19QQ0lfUDJQRE1BDQo+IGVuZGVkIHVwIG1vdmluZyBhd2F5IGZyb20gdGhlIGRtYV9tYXBfcmVz
b3VyY2UoKSBhcHByb2FjaCBhbnl3YXksIGFuZA0KPiBhbGxvd3MgdGhpcyBraW5kIG9mIGRldmlj
ZSBtZW1vcnkgdG8gYmUgdHJlYXRlZCBtb3JlIGxpa2UgcmVndWxhciBtZW1vcnkgKHZpYQ0KPiBa
T05FX0RFVklDRSkgcmF0aGVyIHRoYW4gYXJiaXRyYXJ5IE1NSU8gcmVzb3VyY2VzLCBzbyB5b3Vy
IGJlc3QgYmV0IHdvdWxkDQo+IGJlIHRvIGdldCB0aGUgR1BVIGRyaXZlciBjb252ZXJ0ZWQgb3Zl
ciB0byB1c2luZyB0aGF0Lg0KDQpUaGFua3MgUm9iaW4uDQpTbyB5b3VyIHN1Z2dlc3Rpb24gaXMg
d2UnZCBiZXR0ZXIgd29yayBvdXQgYSBuZXcgaW1wbGVtZW50YXRpb24ganVzdCBhcyB3aGF0IGl0
DQpkb2VzIHVuZGVyIENPTkZJR19QQ0lfUDJQRE1BIGluc3RlYWQgb2YganVzdCB1c2luZyB0aGUg
ZG1hX21hcF9yZXNvdXJjZSgpDQpBUEk/DQoNCkkgaGF2ZSBleHBsb3JlZCB0aGUgR1BVIGRyaXZl
cnMgZnJvbSBBTUQsIE52aWRpYSBhbmQgaGFiYW5hbGFicywgZS5nLiwgYW5kIGZvdW5kDQp0aGV5
IGFsbCB1c2luZyB0aGUgZG1hX21hcF9yZXNvdXJjZSgpIEFQSSB0byBtYXAgdGhlIHBlZXIgZGV2
aWNlJ3MgYmFyIGFkZHJlc3MuDQpJZiBzbywgaXMgaXQgcG9zc2libGUgdG8gYmUgYSBjb21tb24g
cGVyZm9ybWFuY2UgaXNzdWUgaW4gUENJIHBlZXItdG8tcGVlciBzY2VuYXJpbz8NCg0KPiANCj4g
VGhhbmtzLA0KPiBSb2Jpbi4NCj4gDQo+ID4NCj4gPiBUaGFuayB5b3UhDQo+ID4NCj4gPiBQbGF0
Zm9ybSBpbmZvOg0KPiA+IExpbnV4IGtlcm5lbCB2ZXJzaW9uOiA1LjEwDQo+ID4gUENJRSBHRU40
IHgxNg0KPiA+DQo+ID4gU2luY2VyZWx5LA0KPiA+IEtlbGx5DQo+ID4NCg==

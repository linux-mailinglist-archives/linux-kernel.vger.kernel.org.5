Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9334475623A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjGQMA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjGQMA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:00:56 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F624E4F;
        Mon, 17 Jul 2023 05:00:23 -0700 (PDT)
X-UUID: 7faa1860249911ee9cb5633481061a41-20230717
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=hkz4vDAmHbpwTqFl20zXQaJaYB5OJOnFVIRKhKDEpy0=;
        b=UYxJUEp79pTzeycqRj2eeCgzXyXoaXTRM7Cc8mA/iTJC5be1MKean6NfthUY5s/UY4SWHnWi29KFWQnoZIJMok9k8f8ztzmsc0DHHSAAt8ZD4iW3zWUSoDAqT4aQb2VCHe7ejSYLKB0ZLPVdVi6kfclnfHFKAdJztr+AKdpLx5M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:10b0ebee-e1d0-4641-8a64-cce452577d5a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:176cd25,CLOUDID:8e2ab0dc-dc79-4898-9235-1134b97257a8,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7faa1860249911ee9cb5633481061a41-20230717
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <jason-ch.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 645359492; Mon, 17 Jul 2023 20:00:18 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 17 Jul 2023 20:00:17 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 17 Jul 2023 20:00:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lr8hfEd7R70U2mErLICqMExC1NYnOzdp+9i8uuKWekV5fGVT89GJAh4O0NVANMkWhhRLyx+rFyG8eNAHMhcCg7xGfnkN81hJusw45ps2sw7ZgVa5qv1E+g+zqfdGevWbNG+rkNJlucHo9hffyrGFCK+eS45QbJWwKQ2PmmuVGg4erPpOacKjkvyfKvW4UMjmHz/0MTQ4dg7DHpTY118BED3o0Jj+9iGsqwZ0lwPPy9H1ERIusP1jKPUqbgllzsVljiRq6s4e7bkb9lF3E6c/HATpytCzu86KxxzOYp6s6qVsxPm8vTlmAP35GzD/wlBSI4g28gwwJs6e/V8Ess78iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkz4vDAmHbpwTqFl20zXQaJaYB5OJOnFVIRKhKDEpy0=;
 b=g50DizQbZlpcFrIyEfT7U+NA8RA9rGDb7uaqdQZgkj7Y0LWrXUGKfqZSaSYgHT72hUvsTPH8zCFzP+yPRbdtgrSanRetmFt2qTsfgukKwnHLQtB16Mcs8lSKczOefnU4tk7nUk5fJ4tj3C4m3fDCimHWjyUv8ndAZT8a2YshEmeqEgWop88yEYwAjQbd70hZv5JsA0CZfrNyqa5dHy+fMQx8iXt6tr0B3dBOjRkVxidmvP8WmTcoDCckqgS5rxhhKaUTuqpfQ1bwnQAyMVm/bDVtqnATsZRyEOccdfc2If8C0alzFoJdmxmWk4IEFyglta2Whjz5j2ykSJBD8DVg0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkz4vDAmHbpwTqFl20zXQaJaYB5OJOnFVIRKhKDEpy0=;
 b=dvMTdw8e1ECjMGTdcXEMlJ5tK8dyrYqcHIl8c0A6VpjS5icpzSYL9f2i69d8+mAhcDklbp7V5K2hKEdxVcWCQjDo/CmiAZS/aRgIxcw4Wo4C05o/nhu43Upb1oZjdNc2fk5wkMchwbQmeZIfygWrSlaPMa+rw9SYxsBWBuO7gYM=
Received: from KL1PR03MB5650.apcprd03.prod.outlook.com (2603:1096:820:73::5)
 by SEYPR03MB6604.apcprd03.prod.outlook.com (2603:1096:101:84::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 12:00:14 +0000
Received: from KL1PR03MB5650.apcprd03.prod.outlook.com
 ([fe80::27f3:ca11:2b8a:475b]) by KL1PR03MB5650.apcprd03.prod.outlook.com
 ([fe80::27f3:ca11:2b8a:475b%7]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 12:00:14 +0000
From:   =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: soc: mediatek: pwrap: Add compatible
 for MT8188
Thread-Topic: [PATCH v2 3/4] dt-bindings: soc: mediatek: pwrap: Add compatible
 for MT8188
Thread-Index: AQHZs6EQ673aNnAIFUOqUup/8jHQQq+0FMEAgAnQdQA=
Date:   Mon, 17 Jul 2023 12:00:14 +0000
Message-ID: <62399eb4be7e0f5933e991e017e9df4ded9c5eed.camel@mediatek.com>
References: <20230711023929.14381-1-jason-ch.chen@mediatek.com>
         <20230711023929.14381-4-jason-ch.chen@mediatek.com>
         <84847777-bad0-0aff-5279-9b80fd95c2d5@linaro.org>
In-Reply-To: <84847777-bad0-0aff-5279-9b80fd95c2d5@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5650:EE_|SEYPR03MB6604:EE_
x-ms-office365-filtering-correlation-id: 153e4337-5953-4256-aea4-08db86bd6184
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tfiQ4f7TyyfJ7LRFSy/2l1F+iqEHYAyrP+2hUcEznfLhyL6mOhWuUeanLBb+uEo1qa65+3TQ/Mv1flc669ugqaAGYWevFhSJfsXCNXDPtWkOEVgjbag6ngnoErmBOu09ku866+zhaMfo3hteVN/c4E4LCWvLZc9Lg4IJ+qQvs8Wk4MQDp17RqveSYUREx8FjRNDfh1SDtCnKBXIH2sq0jjDiKRMTrATOHAQPXsGPcAL20RumlarBiZm79Wy1F+1YB5T/Y/34PLbvryosQpM/RWeOXTXGXCT62Ej4cJ9zpCq4/a79vJc3hRSdqL+nO5ozXTbbu8P0g3ej/5RvR28t0pSIcP0czYDYkSFfqSDS8Ka3iKYyXM/bte6UAG7/gDathkTzjLnE1vMcFPXOETIKkh1O8YOiDinoA3Gao4dDXB516WUFJoP063JOxf4vcwxfmaxbCLsxcP0cIeHXEG7uiVaTp4zTF0YP8exUa+wtw0qwN5fHdiGuKMiv2MIx1PuuUOsW4vqTGmRUzYwBgBEDbbUghkzoVnCBwFT27PLq7vKc5Plc3Ndkuz9YQCjcdWiUSgzlutrrxySidyWqeIk1C1mhixYYxLUkQCyhEQy5c/Unmxp32yrIC/oskTSyR98q0uFXLHNkGvPSdwh0TtI09m6P0eM5lUntIvhS4THMqrM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5650.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199021)(2906002)(38100700002)(6512007)(122000001)(83380400001)(2616005)(186003)(26005)(6506007)(5660300002)(86362001)(38070700005)(53546011)(4326008)(36756003)(8676002)(85182001)(7416002)(54906003)(478600001)(110136005)(6486002)(71200400001)(316002)(91956017)(41300700001)(8936002)(66946007)(76116006)(64756008)(66446008)(66556008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXdiZVkxcVpMRDJGaWd5ZU03b056akRpYitYVThKb0xDelBOZDgvOGFBMTZY?=
 =?utf-8?B?OEFVOE9YK1RtcHlsSmR5S1FHZXAwcUMzMGdOL0hnaTk0VCtVaDJuQnR3dWUv?=
 =?utf-8?B?TFdVdjJQRU53SS9TdkFJb0p0T3h6RmlHTERQbmdpbCt6ZEd0T085U3BRZ1pU?=
 =?utf-8?B?dTQ3VWowN3E3YTdINXhFc3FtdkFHNUY1Z29QTHJVUkMvVzNTRGszS2xTbFJM?=
 =?utf-8?B?dXZaK3ZPQnpaRXdxS3VMclFIaW1rQ01wOE9hZmlTYmY5VnBpKzhsNXZVMkYy?=
 =?utf-8?B?QldBQ0JNaitibTZzamg3Z2VaYU51dmprVXdtNkVVSzhLd1YrMWZIRnB2eHA1?=
 =?utf-8?B?ODFDcVllQ1ZkMTFSbFZWQXFiNHM0U0JEdklkVEVQTkZTN21lME5QZDJXTU54?=
 =?utf-8?B?eDlSdVIzYmx4eDBrREZDa28xeE1CZWRaSlNZL25BTEpxWDVEZTBKVkp6WnF6?=
 =?utf-8?B?bUpjdldWT0ZOMFBUTmtpQTE1VlF2ZUxoZ2ZpNnlEaWhpa3EvYVVyK21jSzM5?=
 =?utf-8?B?SkY2ZVBFVmJtczBIZDVDd2dIaTMrT2k1ZGRIQ21UekhQd3N4c1pVcmJGK0ky?=
 =?utf-8?B?SXRZbzhKd3RQR2gzTXNuUzZCMDc0WmF2cW5WRjhxRXZ4bjg2S0N2TmxWeTRY?=
 =?utf-8?B?RkRPb1ZIU3ZOZmRHNWlEU25PUndrTUx1b3BmYlVOOE84bURxTFRhU1pxVzQv?=
 =?utf-8?B?SCswUW5uR0dnR3c2eHhVcEt2dUdvbUVURGJLSDR3MTFBNVlFZmh1N0VXNllH?=
 =?utf-8?B?MDlwL0JZN3B5ZlFWaEx2SzRQejlZYldLcTF4akc2STVsWW1yWjhaMTBLYTFo?=
 =?utf-8?B?OWM3dmV3ejh0c3ZHdUhXZUpDS0xRYTU2Sy8rVU1sbnArcjU3M0lLSy9xYmhw?=
 =?utf-8?B?SUV2dk1IM2pFc2IrMEV6cHBrUlVFSjQ5MVRVSG1oSUY3ekxIUk5hK0Y4YUs2?=
 =?utf-8?B?cnRMS1BjMDNmY0IrclFwWFN0T3QvZUYwYVRyeGpCQUQzMnh1SHVKazdpUG13?=
 =?utf-8?B?WW4wdmdEbFY2algxMVZGQnFRazBMVEdVYjNMZjByNEJsblBybnFLYXdsRExD?=
 =?utf-8?B?K25KRkFUSklYZUN1UDhHWS9yUDVvdTJMRFZPTVdFemk2dHNFa2NlWHphRW82?=
 =?utf-8?B?aEtTOVRvYTlENEp0RFEwN0pobmZQREpmU0pPRXdsRldVY0FaVE9PekM3dmxX?=
 =?utf-8?B?eUo5a0pvcTRFeE9tUFZVeER3cUkxeVpXdWZUNnZMdUJFaTA1YjhBRHRQdlFB?=
 =?utf-8?B?Y1liR1hFNDJzRzJNZHo0bEJoSFY1TEwwbEoyZE52MXNQRFdiVFplTWFOZER0?=
 =?utf-8?B?ckhBblpzZmNQbFRST3FDdXIyeW04WWJqYnpIeHNwMHJEdlI1Umx5UUc1dDRH?=
 =?utf-8?B?V3NweDJjZzBEZTRxaHN1MG5GTDB5Q0tkNnFyZnh6TDRwTDlsT3BpWlFvNnNE?=
 =?utf-8?B?M25EYStJNkNFK21vQlZwQWxEMFdpbTV1RFMrK1JDek9KRnNBSGRHNmplTVdC?=
 =?utf-8?B?ZlpIUldla2dPS08wOVhRdGZMYkUyaW4xSXhXVGF3MExFUDlHa0JOTGk1QmdX?=
 =?utf-8?B?SlRsaGdRWCtGOTJGRFRmUmpOaUV3TjNzN1AzN1Z2clVzeENtQysvdzZVenh4?=
 =?utf-8?B?c2lJWHlockFMek40YkkxOGlFOHliM3FzUkdMRVNaWXNTaEpOejZxbkJMejV1?=
 =?utf-8?B?OWd6a0hOcUFmdjVYRnpid0NaUUlKOG1oSmVLSmhZazMxNWd3dWZWS0Y0VXpv?=
 =?utf-8?B?aXk0WUJqZWRYZWhGNGdVcHR3MCtTNVdPbDNES09DWVM3eWRNeWRiaVlEMmdn?=
 =?utf-8?B?eXBCcWh2Skxtd01obUdlTWJoTGVWTkc4VDhJaURmbnZ3aERTS1A0U1VoYk5l?=
 =?utf-8?B?S3lqUDlwZ3kxR2VmS3psbXd0SzVrM2V6eWRZNmlNeU80aGpLK1BZK2xiQ0JT?=
 =?utf-8?B?dndKcC8reDU5b2xoVWlMUHJ0WTZmT0o0WTcvVVpjV3VBbXBmRmwvVnpVdktY?=
 =?utf-8?B?MWFlYnBVc3ZvdkdWV2tDSWhtTjA4ZHV3Z094bGVZUlR1UGFtWkdRSnJXcUFx?=
 =?utf-8?B?aGhpMlBtWDgweDBnQVNJZ0JOUXcwaVQxbkpJRExZSHpVSld5akVVUzR3dFFI?=
 =?utf-8?B?aHU4blJlK2l0bGhZeUJPQXJwaFhIZGk5cHN3ckxvSkhyQ2I1M0tMUFhCdnUz?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B29F094D6D4DB846B644FDEBD4E9EB77@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5650.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153e4337-5953-4256-aea4-08db86bd6184
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 12:00:14.5623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hbsJEwMwMr70z5uEblCoPQhiQNMemIIvD2b94AFz0j1YHAErXFDZuZQm1Z7HzuVAeuZsqUF9C82ObbVl7FpBFjUBVSVmXj2i+rTHccJSL/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6604
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpPbiBUdWUsIDIwMjMtMDctMTEgYXQgMDg6MDcgKzAyMDAsIEtyenlz
enRvZiBLb3psb3dza2kgd3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBk
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2
ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgT24gMTEvMDcvMjAyMyAwNDoz
OSwgSmFzb24tY2ggQ2hlbiB3cm90ZToNCj4gPiBGcm9tOiBqYXNvbi1jaCBjaGVuIDxKYXNvbi1j
aC5DaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBBZGQgTVQ4MTg4IFBNSUMgV3JhcHBlciBj
b21wYXRpYmxlIHRvIGJpbmRpbmcgZG9jdW1lbnQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTog
amFzb24tY2ggY2hlbiA8SmFzb24tY2guQ2hlbkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4g
IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9tZWRpYXRlayxwd3JhcC55YW1s
ICAgICB8IDUNCj4gKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0K
PiA+IA0KPiA+IGRpZmYgLS1naXQNCj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3Mvc29jL21lZGlhdGVrL21lZGlhdGVrLHB3cmFwLnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVrL21lZGlhdGVrLHB3cmFwLnlhbWwNCj4gPiBp
bmRleCBhMDZhYzIxNzc0NDQuLmMyZjIyZTdkYmNmYiAxMDA2NDQNCj4gPiAtLS0NCj4gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVrL21lZGlhdGVrLHB3cmFw
LnlhbWwNCj4gPiArKysNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29j
L21lZGlhdGVrL21lZGlhdGVrLHB3cmFwLnlhbWwNCj4gPiBAQCAtNTAsNiArNTAsMTEgQEAgcHJv
cGVydGllczoNCj4gPiAgICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4Ni1wd3JhcA0KPiA+
ICAgICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTk1LXB3cmFwDQo+ID4gICAgICAgICAgICAt
IGNvbnN0OiBzeXNjb24NCj4gPiArICAgICAgLSBpdGVtczoNCj4gPiArICAgICAgICAgIC0gZW51
bToNCj4gPiArICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4OC1wd3JhcA0KPiANCj4gV2h5
IGRvIHlvdSBhZGQgZHVwbGljYXRlZCBlbnRyaWVzPyBUZXN0IHlvdXIgRFRTIGJlZm9yZSBzZW5k
aW5nDQo+IHBhdGNoZXMuDQpJbiB0aGUgbmV4dCBwYXRjaCwgSSB3aWxsIHJlbW92ZSB0aGUgZHVw
bGljYXRlZCBwYXJ0LiBUaGFuayB5b3UuDQoNCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEty
enlzenRvZg0KPiANCg==

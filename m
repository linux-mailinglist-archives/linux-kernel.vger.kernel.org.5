Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1107A765E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbjITIvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbjITIv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:51:29 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995FDCA;
        Wed, 20 Sep 2023 01:51:22 -0700 (PDT)
X-UUID: de0840b8579211eea33bb35ae8d461a2-20230920
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=e/aIDMpzBOozDxCAhpnxIOOKp4ATDxuxeEs12/LhxaU=;
        b=Ks6UShNdqgGKxjQNHg9UeYRWSV3a3Fu4gPR5EYjRP48ZqRP+rBOIV1oCTr6rzDET4g57RIZ/mNIZnmmzkj2jdCcAGvrcQljB+5V0dAyf5Kyl0lhcowwptOje64QqFMpFF99fOcaWDdErsW5SQCbvZvmMfntanSGPc6oZLXoFgsM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:10c4b626-1507-4f79-9dc6-b519281b7a85,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:c2310ebf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: de0840b8579211eea33bb35ae8d461a2-20230920
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1659510126; Wed, 20 Sep 2023 16:51:19 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Sep 2023 16:51:19 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Sep 2023 16:51:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/Aai3L1erIVnCFmX0zu6VnyEloBDtYjqZSrVy/O2TUne3lkNET7nvjgu78+yGAeKQnV7zc7jww8d1VMJGjD2N6nPAQuo9CK913Hl1AQBD8xBEG8wQyi5kWKtmRgbV7d/i1MYx9jh+LtJgO8cWAkGGF4c4DZoBFuow6ltMsPN/7JXruVibF2Ewu29dnbRdXBFZifhsrEVhEJLY2wdwsIBzUz8gdjM9dkLqeKb9biKml+SB761NRQNxk82Zf263Lllu5L8sDY07UV+rB75eSUsbdt0UovF3Dx3GDRxTzaNQRs2d6G+BZrAeMl6Kqzvsvz0j4BYioV8ABeFJg8c4YXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/aIDMpzBOozDxCAhpnxIOOKp4ATDxuxeEs12/LhxaU=;
 b=Axub+0ChRnG6j2DRWNJHJYR5k7ZdrcaOWh2P6RjbTOe8DBV4x5/kv/KtXkPOcWFerBYdoHLlBxr1CGJ1B1Ng6XM9fokqc17sVJbJawoUPe8BG306iRez2LjS7EHBE74ijEb3XM7+D65Xm+/XbbcGiXYd1X76lFwFI65ODvmorSl+rxHBxXYyLYxRtVUHxuknMu3sDBDh5T70uiNbmx82iyxYa4gyOT8FMchoQQ9sykmcPl/HFGwI/SPU2Cua5HrwCkJdOS7Qi2t2iKbCe4wu1qbA4nV1bMA2tJAXso5W8345NuIzqoLUtA5Z2OLhfix5rjD0nFallECYWuEyowSnSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/aIDMpzBOozDxCAhpnxIOOKp4ATDxuxeEs12/LhxaU=;
 b=SB/AZmKWUi/0/OT/FlZ6DbAm3B0WX5yf5W9nJeHpQ0iqqHN3jOxKEcjuSgMWdNhQSjsHjwa+URltNbAweZhiOhbG001/C3hx9h3hhdAUoys4zEE9xG2fW3BToyBj33G35bDpZD2HP+CFQxBsyewbkdTbCFEurOyOUNrk0URLmGs=
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com (2603:1096:100:53::15)
 by TY0PR03MB6822.apcprd03.prod.outlook.com (2603:1096:400:217::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 08:51:15 +0000
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::b6ae:482a:3913:2a8b]) by SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::b6ae:482a:3913:2a8b%7]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 08:51:15 +0000
From:   =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>
To:     "wenst@chromium.org" <wenst@chromium.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "laura.nao@collabora.com" <laura.nao@collabora.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v17 00/14] Add support for MT8195 SCP 2nd core
Thread-Topic: [PATCH v17 00/14] Add support for MT8195 SCP 2nd core
Thread-Index: AQHZ3KvDfzrOjTaMLkedeGydMXgQv7AZHEsAgAdg/YCAAAOPgIAA89aAgABAVwCAAdDcgA==
Date:   Wed, 20 Sep 2023 08:51:14 +0000
Message-ID: <89047de8d44838425a4f6f783223364dc05e5834.camel@mediatek.com>
References: <ZQH2dG+l/dONUsyi@p14s>
         <20230918103141.126271-1-laura.nao@collabora.com>
         <CAGXv+5Esi=G0xgkP=+Bhf39Xs3gMN1PBzarxKBKduOjgwDijAA@mail.gmail.com>
         <ZQj2lSl47qZQv8fX@p14s>
         <CAGXv+5Gj5rERcX6uxVUUq8beM4k4ogXnuh_86piyGw1oVrbyvg@mail.gmail.com>
In-Reply-To: <CAGXv+5Gj5rERcX6uxVUUq8beM4k4ogXnuh_86piyGw1oVrbyvg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4204:EE_|TY0PR03MB6822:EE_
x-ms-office365-filtering-correlation-id: 1e329584-8361-4335-08bf-08dbb9b6bf9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cTRdKGjA0narxfr/lLXAXb0IUmt6rkejG5QuntzMdq6XtAoIg2ehZSuyIxBPob9hPKk83vDrXLPSalLcnwhmnQa+GzNzcx4tTFcbTVZOm6hcN1lgKxYNS9k9nIq7oo9SiBuFMlL7YkK4CdZGtq6UM1mIWvKWWTFzKB35eZV4fM0G3dMu/ID4TgHi6cTkiwE84ymckw6XbA6TeidI91OqePIgPkh3IusajWGHuTKv0vWOtsBCaHyaDhkexJCbmSG1gDrHgN6bKOrv0zlnJ0pxd6LVS7V8zJFT/lVNv5Jwv6suxf5JSGh77Zvah2NdZeQJv0MTQecV7MI0pdvgY6xQbtGgB+VswnJA8klGkNwHIZb07hsGLh/jTKZr19Vuva9PTldzU0H1l/ZgmAuZxFSLaoXPM4QiL5f8eA1pwLQjOtmLEv5Vpsf7tQWkCObyswt6ZsMcFXLxIANPNsi6bnO9+1dYQrKz5fYrDbGhCfVAzldOa6MeDFe6rrqu8nJ4756qIIuHoLOCSTbShFLKrt39HqP92ZG9dD/aQAPluUSX3Ux9egaUVF1+oNZ7tCSiZW+ynpUKnhKEuSeWtOmUTZBlHsbNeo8/uAZPGihQ/1cJFivoI1ihq3qNoe75Dygu3M1YgmggSiR5MNvYZ/HxLNme41B+EVedtIPv0vni3PUk1/u81uQezfTsux3mxzHwUo3N
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4204.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199024)(1800799009)(186009)(53546011)(6512007)(6486002)(6506007)(71200400001)(38070700005)(83380400001)(122000001)(38100700002)(86362001)(36756003)(85182001)(2616005)(26005)(110136005)(91956017)(316002)(54906003)(64756008)(66946007)(76116006)(66556008)(66476007)(66446008)(41300700001)(2906002)(7416002)(5660300002)(4326008)(8676002)(8936002)(478600001)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L04yTEUyVFJKaXhUOHUzV2JUZ1BTYzNVL1FuQnNiam0rQTlZQ28valp4WXRS?=
 =?utf-8?B?NkVidHRXL0xMTWhKK2d1QVg2dGU3M29HQVFDMDBackdVZlN2L1drVFJ1a2c3?=
 =?utf-8?B?YWwyNEdrdE15dGxhWjlUeGxhbHlveDdFdnp0cTI2eUwwcUdDNXAvbWZXMVVx?=
 =?utf-8?B?S0Q3SmQvZVN0UWsrRGNxS3FOK1YzQ29tV1NYb2JabWNlN2JrR1plUG9oUURT?=
 =?utf-8?B?MkN6Vk80OGdJNFpxMUx2ZXhEdkJmNGdqZkFsT09NUlQ1aXdDakJSSzZZdys1?=
 =?utf-8?B?Mlh4OEdSaFQ2Snkrblg2RHRQbUJxbXA0dEVoMVFac3h1Q1Ayay9HVnNMdUFp?=
 =?utf-8?B?Z3RxTzdQOS85RUo1Y1c0V0lpU0dvOVRxZjNKc1FteWRvWXllUDBzQXV6eUNm?=
 =?utf-8?B?aGtmT1hFL3hYNlZOUnpFL0VuVjUxOW8yOU9oQU0zUVRSYmtQOG1Ram1BM3lt?=
 =?utf-8?B?dURjcml1SDMxcjNtTjV2ZFM2UXBwOThKMXVaUjlvZjB4V254bmdPelp3UDZI?=
 =?utf-8?B?RXhmbVhRL0EwcVBpNzc2aHBIT2YwMkdYbGJUeVd1Y3p4NGFVZkJzQWtiNlQw?=
 =?utf-8?B?RzBrVTZUcVZaVmVUR1g2OHU2b2hoS2hiWDBOb2RoOEJ4dWxaVnlXL08wVVdU?=
 =?utf-8?B?L2s2RVJkTHphSzl5b05Gc0lhZ3AvSDZEZUZSZ0I5T09SU1JyYjZVRkNEeGFN?=
 =?utf-8?B?SXFPVXlhVGkzMkxEWDJoZjZ2eElmdFY3MXJBc3BraW5zbnZIUERDeHZMeVFB?=
 =?utf-8?B?Z1hiSTFqeE1zRlhsK2tFT1pYSm4yeGFBYnNBZTRQam1jRllVY2o0WXZaT1hC?=
 =?utf-8?B?NWZrWnpMbklScDRCVStrSWIvZ2VZMVAvS0JUOWFBbm1MZXJYNXl0SGs5ZWVS?=
 =?utf-8?B?Y2ZvWE1QUVNZMkdOOUROamU0M0ZDVElYMFk1ZElLV3pjZFNjck5seTBsZGt2?=
 =?utf-8?B?ZTVnS1VWOWVIaVRhUGFiU0dmenBZeVliNE1LdDdXQW96SlVnSEYxemRGZTBG?=
 =?utf-8?B?V1B0TlMzcStZdVJQQktDQWhRUFhEL2pHeGRFTkMwRklpMEl5UUx4T1VBTGVM?=
 =?utf-8?B?bWlsS2oxRDhHdUtkaHFrc3AraXJlRnk4UFdjRFNKVm1wYXEvYVdLdm80OWph?=
 =?utf-8?B?dERreWE2cFFxdzB1eUp4bCtZbjhRM2FXSkNKbW5ZZnRwZlhTU3dPVTV0QjRy?=
 =?utf-8?B?bE5oRWk1TkpDVDU1VmZmMkp6eFhJSSsyS3E2L3IwRXdxNFF5WUpPdVlMTm81?=
 =?utf-8?B?Q2xVdE9GeFRQWC9UUnZ1dTJZdEp3RzFwZzhNdnNHdDMzRXlxNjBnbkdpN3ht?=
 =?utf-8?B?V3JCSEl5Y29XTU94YmR3RytEYy9BWVBmWFdWYUNxdmtXMkNsWXlhWk1pajFP?=
 =?utf-8?B?VDNIS3hVV2VXbmFVUjJta3p5NkpSSWFyQm9jN3AvZTNIQmwyZ0Q0N2QvM0tK?=
 =?utf-8?B?d0o2SzBkTVlqM09BTUFKWVR6ZWR2dlhNd0llNlk1T0lWL1pXemt3czl2city?=
 =?utf-8?B?VWpxME9zWmZGUFB2NXlHTDJlOEM3Wnh5aXJvdVNzZTNGSG1iZ0lYR1ZiRWI3?=
 =?utf-8?B?ZUtGaFZDL2xGQXEya1FnbzFOcExwdzd3SzRoZ09JakNJU3VpYnZVcXJYa1pD?=
 =?utf-8?B?d3ZWdndMRzk1QW5nTmY1V1JDR05BQWV6YS9xSSt4Qk5DTUZ0NmR1cmpoekZR?=
 =?utf-8?B?TitDN20vSG9qZCt6anJKbU40RjdydkVmTU1lV05GL3U2cmNNTG1VTGVRM3pU?=
 =?utf-8?B?V2lkem9iM24ySDJDWWdybnhhWkEwaFBKMWd1T05FbllNdzhZK2N3U2pscTYz?=
 =?utf-8?B?OHZ3WWJvWGV5bHNIREUwN05SWFFra2NmeGJwR2NiQ1gwT3c5S0xiZzkvQzky?=
 =?utf-8?B?cmo5WU5YRmZ0UjBhaDYwNXpPTnFKUTNlaG5saXlHQXFtLzVoN2JReW1idExH?=
 =?utf-8?B?alU4N2ZibGNlWVpHRTRBS3dwaS91NHFjNTNSZGdadGtJWU4rdUROMVR3aG44?=
 =?utf-8?B?VVdLYTdXTWRteHh5czEvRnJ3UElXK1NXRUxReDhwdkpTUjJBTFVmQkxVNk0x?=
 =?utf-8?B?am9hcUpNRjdGUllxcGpSdFhybTZRbUxYaEtNR3l4M1ZvWEN2Mk5mdXFRQzZt?=
 =?utf-8?B?dDFsOVpudEt2Q2k4L040bUg4Y241RkZyOC9vSm1ISEk1ZTV4VXhEZ1ZSSzlK?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38C4AB29F7B59D4D95799CCF2426DF5F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4204.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e329584-8361-4335-08bf-08dbb9b6bf9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 08:51:15.2482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NLD1PdYO9IZfPI9mHUiCZ6Ysgpm58Q2fHctUzmIRiwWWOV/5IBVQ0AuGKkigwW6t4jdgr2E1cbbE22npaVQGHJjG2qNPQHZv1NiSbZ1Sjkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6822
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA5LTE5IGF0IDEzOjA3ICswODAwLCBDaGVuLVl1IFRzYWkgd3JvdGU6DQo+
IE9uIFR1ZSwgU2VwIDE5LCAyMDIzIGF0IDk6MTfigK9BTSBNYXRoaWV1IFBvaXJpZXINCj4gPG1h
dGhpZXUucG9pcmllckBsaW5hcm8ub3JnPiB3cm90ZToNCj4gPiANCj4gPiBPbiBNb24sIFNlcCAx
OCwgMjAyMyBhdCAwNjo0NDoyNVBNICswODAwLCBDaGVuLVl1IFRzYWkgd3JvdGU6DQo+ID4gPiBP
biBNb24sIFNlcCAxOCwgMjAyMyBhdCA2OjMy4oCvUE0gTGF1cmEgTmFvIDxsYXVyYS5uYW9AY29s
bGFib3JhLmNvbT4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiA+IE90aGVyIHRoYW4gcGF0Y2gg
MiBhbmQgMTQsIEkgaGF2ZSBhcHBsaWVkIHRoaXMgc2V0LiAgVGhlIHJlbWFpbmluZyBwYXRjaGVz
IHdpbGwNCj4gPiA+ID4gPiBoYXZlIHRvIGJlIHJlc2VudCB0byBNYXR0aGlhcy4NCj4gPiA+ID4g
PiBUaGFua3MsDQo+ID4gPiA+ID4gTWF0aGlldQ0KPiA+ID4gPiANCj4gPiA+ID4gSGVsbG8sDQo+
ID4gPiA+IA0KPiA+ID4gPiBXaXRoIHBhdGNoIDIgbWlzc2luZywgdGhlIFNDUCBpcyBub3QgcHJv
YmVkIGNvcnJlY3RseSBhbnltb3JlIG9uIGFzdXJhZGEgKE1UODE5MikgYW5kIGt1a3VpIChNVDgx
ODMpLiBUaGUgbXRrLXNjcCBkcml2ZXIgcmVsaWVzIG9uIHRoZSBleGlzdGVuY2Ugb2YgdGhlIGBj
cm9zLWVjLXJwbXNnYCBub2RlIGluIHRoZSBkdCB0byBkZXRlcm1pbmUgaWYgdGhlIFNDUCBpcyBz
aW5nbGUgb3IgbXVsdGljb3JlLiBXaXRob3V0IHBhdGNoIDIgdGhlIGRyaXZlciB3cm9uZ2x5IGFz
c3VtZXMgdGhlIFNDUCBvbiBNVDgxOTIgYW5kIE1UODE4MyBhcmUgbXVsdGljb3JlLCBsZWFkaW5n
IHRvIHRoZSBmb2xsb3dpbmcgZXJyb3JzIGR1cmluZyBpbml0aWFsaXphdGlvbjoNCj4gPiA+ID4g
DQo+ID4gPiA+IDEwNjk2IDA0OjMzOjU5LjEyNjY3MSAgPDM+WyAgIDE1LjQ2NTcxNF0gcGxhdGZv
cm0gMTA1MDAwMDAuc2NwOmNyb3MtZWM6IGludmFsaWQgcmVzb3VyY2UgKG51bGwpDQo+ID4gPiA+
IDEwNjk3IDA0OjMzOjU5LjE0Mjg1NSAgPDM+WyAgIDE1LjQ3ODU2MF0gcGxhdGZvcm0gMTA1MDAw
MDAuc2NwOmNyb3MtZWM6IEZhaWxlZCB0byBwYXJzZSBhbmQgbWFwIHNyYW0gbWVtb3J5DQo+ID4g
PiA+IDEwNjk4IDA0OjMzOjU5LjE0OTY1MCAgPDM+WyAgIDE1LjQ4NjEyMV0gbXRrLXNjcCAxMDUw
MDAwMC5zY3A6IEZhaWxlZCB0byBpbml0aWFsaXplIGNvcmUgMCBycHJvYw0KPiA+ID4gPiANCj4g
PiA+ID4gVGhlIGlzc3VlIHdhcyBjYXVnaHQgYnkgS2VybmVsQ0ksIGNvbXBsZXRlIGxvZ3MgY2Fu
IGJlIGZvdW5kIGhlcmU6DQo+ID4gPiA+IC0gYXN1cmFkYTogaHR0cHM6Ly91cmxkZWZlbnNlLmNv
bS92My9fX2h0dHBzOi8vc3RvcmFnZS5rZXJuZWxjaS5vcmcvbmV4dC9tYXN0ZXIvbmV4dC0yMDIz
MDkxNC9hcm02NC9kZWZjb25maWcqYXJtNjQtY2hyb21lYm9vayp2aWRlb2RlYy9nY2MtMTAvbGFi
LWNvbGxhYm9yYS9iYXNlbGluZS1uZnMtbXQ4MTkyLWFzdXJhZGEtc3BoZXJpb24tcjAuaHRtbF9f
O0t5cyEhQ1RSTktBOXdNZzBBUmJ3IWlFTXJ1SzRiVldmQ21oUm15YXVKdGtUaW9IZFFiWVAzRHdo
bkdVWk54YktZaE16dXNtb0lqWU9ucFZOQUxvTW9iVWRLaG9vVVl3Nk94VW1ycU5FJCANCj4gPiA+
ID4gLSBrdWt1aTogaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vc3RvcmFnZS5r
ZXJuZWxjaS5vcmcvbmV4dC9tYXN0ZXIvbmV4dC0yMDIzMDkxNC9hcm02NC9kZWZjb25maWcqYXJt
NjQtY2hyb21lYm9vayp2aWRlb2RlYy9nY2MtMTAvbGFiLWNvbGxhYm9yYS9iYXNlbGluZS1uZnMt
bXQ4MTgzLWt1a3VpLWphY3V6emktanVuaXBlci1za3UxNi5odG1sX187S3lzISFDVFJOS0E5d01n
MEFSYnchaUVNcnVLNGJWV2ZDbWhSbXlhdUp0a1Rpb0hkUWJZUDNEd2huR1VaTnhiS1loTXp1c21v
SWpZT25wVk5BTG9Nb2JVZEtob29VWXc2T2hSeHo2TlEkIA0KPiA+ID4gPiANCj4gPiA+ID4gUmVw
b3J0aW5nIHRoZSBpc3N1ZSBzbyB0aGF0IHBhdGNoIDIgYW5kIDE0IGNhbiBiZSByZXNlbnQgYW5k
IG1lcmdlZCBzb29uLg0KPiA+ID4gDQo+ID4gPiBUaGlzIGJlaW5nIGEgYmFja3dhcmQgaW5jb21w
YXRpYmxlIERUIGJpbmRpbmcgY2hhbmdlLCBtYXliZSB3ZSBzaG91bGQgcmV2ZXJ0DQo+ID4gPiB0
aGUgbm9kZSBuYW1lIGNoYW5nZS4gT3IsIHRoZSBkcml2ZXIgY291bGQgc2ltcGx5IGNvdW50IHRo
ZSBudW1iZXIgb2YgY2hpbGQNCj4gPiA+IG5vZGVzIHRoYXQgaGF2ZSB0aGUgIm1lZGlhdGVrLHJw
bXNnLW5hbWUiIHByb3BlcnR5LCB3aGljaCBpcyByZXF1aXJlZC4NCj4gPiA+IA0KPiA+IA0KPiA+
IFlvdSBoYXZlIGEgcG9pbnQuICBDYW4gc29tZW9uZSBzZW5kIGEgcGF0Y2ggdGhhdCBtYWtlcyB0
aGlzIHBhdGNoc2V0IGJhY2t3YXJkDQo+ID4gY29tcGF0aWJsZT8gIFBsZWFzZSBkbyBzbyBhcyBx
dWlja2x5IGFzIHBvc3NpYmxlIHRvIHRoYXQgaXQgY2FuIGdvIGluIHRoZSBuZXh0DQo+ID4gbWVy
Z2Ugd2luZG93IHdpdGggdGhlIHJlc3Qgb2YgdGhpcyBmZWF0dXJlLiAgT3RoZXJ3aXplIEknbGwg
aGF2ZSB0byBiYWNrIG91dCB0aGUNCj4gPiB3aG9sZSB0aGluZy4NCj4gDQo+IEkgc2VudCBvdXQg
YSBwYXRjaCBbMV0gaW1wbGVtZW50aW5nIG15IHByb3Bvc2VkIGNoYW5nZS4NCj4gDQo+IENoZW5Z
dQ0KPiANCj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXJlbW90ZXByb2MvMjAy
MzA5MTkwNTAzMDUuMzgxNzM0Ny0xLXdlbnN0QGNocm9taXVtLm9yZy8NCg0KTXkgdmVyc2lvblsx
XSBpcyBpbnNwaXJlZCBieSBBbmdlbG8ncyB3b3JrWzJdLg0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsLzIwMjMwOTIwMDg0NjExLjMwODkwLTEtdGluZ2hhbi5zaGVuQG1lZGlhdGVr
LmNvbS8NClsyXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA5MTkwOTIzMzYuNTEw
MDctMS1hbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20vDQogDQpCZXN0IHJl
Z2FyZHMsDQpUaW5nSGFuDQo=

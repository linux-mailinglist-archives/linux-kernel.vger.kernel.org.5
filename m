Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE5177DAF9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 09:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242325AbjHPHM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 03:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjHPHMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:12:23 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1794210E;
        Wed, 16 Aug 2023 00:12:21 -0700 (PDT)
X-UUID: 3ba08d163c0411ee9cb5633481061a41-20230816
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=TqctsjWRqRYcvLH8Lywnn9seBiwAB3yOj9TKZnZW6dk=;
        b=hSt1iuapWH7AinIK34wkIBvtb6uZjipSGZ01c+bcs6kdWj+ut9u2oGQpzcgFBkXED7Vy1J5Tdmji37fcAH2Xc/ryT1q9usOXeaAgoe58fU6+VLKGFh8LVI+DIPtVyk40SLCrHtDJ5qW7BBLgeZow7OgXUbynvQpTj3YGVj2gMX0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:209ebe10-5aad-4d2b-ba93-5a7ddf6dc11e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:d689e9c1-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3ba08d163c0411ee9cb5633481061a41-20230816
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1734658349; Wed, 16 Aug 2023 15:12:17 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 16 Aug 2023 15:12:16 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 16 Aug 2023 15:12:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAPpYIngM8ENyF/7/B40Ye7KS1iQwsahc5AXI8SyguPdTtAi4mgc6u7TZwfPShbuRovCwCikIt+Xach+J7MQteN9NM3EUoc5VndSnZdf9LMKwYZtcTj3fKybZSn+y2ukqsAz/3veC+UTa4FTzN/mRCfrNfNihdlyEuzh1iLNHTP7mCEZ12WJpKoSIgfBvdv0M1ldCC0Wni9yCP8fFEH+BHfZwsimpTR9HUgaPnVBf2vXlm1rF7mP9FlmDHhyPeY0rCR6iIjPk5nEr6EhbcGSJAIK8LwRru8EPcv/C/eM9NW8SjdGDFnY9HlkL0IxAhUOzWMhuCzZ3Gw5+UEZKtJtUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqctsjWRqRYcvLH8Lywnn9seBiwAB3yOj9TKZnZW6dk=;
 b=l0j52ntOCBDkEB7qJBGWARtMGzXxLOB7oeK/PGvNXiZU8awbIcnUvHc/uOr55b5IG4uaTnp/enKsHuTUiDrI92COR3x59gKY+eeSxfMDu59TUrhpBPWtr+snuPAHzwnqDpQ8duAtlKOVhyhkoJnU6e6UYVPLxxc3Neme536NtDcghdwtXzG5s8nPVWCHMWh+Ukj/USEoBNtgcknIDJBSosRrAVNL8vdCmXSzRdwTNtD1xodImzy8RvUnyFY7Fo2GByFbZXkI2MtLR3qg1cDM1PN0zyDAk5d5ZTlLSAnOt+u+3/ApR6dyEMJ2QhK8oRMu6KGZUTJ1lYEiQIYd6J/jpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqctsjWRqRYcvLH8Lywnn9seBiwAB3yOj9TKZnZW6dk=;
 b=OSEM9dXrgVb2++NQvcYsfF4s1ezhI/IdFofhn1HmjA/iMjjIWciKchEWFBdvNUgby8MRwa4Opq8uZ/lCffUsXRfLFPZqQF/AcbPLJAv9kAhD+t2uQVPcJL/mtP/1Z+PUEowbGH9CVyuXOZkB8NLlOg74aIkDoCssbzpZE9sK1Jw=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB5422.apcprd03.prod.outlook.com (2603:1096:400:38::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 07:12:14 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6678.022; Wed, 16 Aug 2023
 07:12:13 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= 
        <Shuijing.Li@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v4,0/3] Add compatible to increase MT8188 audio control
Thread-Topic: [PATCH v4,0/3] Add compatible to increase MT8188 audio control
Thread-Index: AQHZzoEAo2Ld1GRUWUmF56Jws1l5T6/shPIA
Date:   Wed, 16 Aug 2023 07:12:13 +0000
Message-ID: <c1c84616f3da83a8a2bc245b0d3c7697153cd81a.camel@mediatek.com>
References: <20230814072842.28597-1-shuijing.li@mediatek.com>
In-Reply-To: <20230814072842.28597-1-shuijing.li@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB5422:EE_
x-ms-office365-filtering-correlation-id: 1789f435-75a4-4ad4-957e-08db9e281dd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JSeh08N0Svi7fMYVG1Ovu+aCAmrg92TuvMjjA5Odvp4YEDGqjiY+G2BhUBmqR1A5a619bGIdxIUs/TilxBbiYY9gJdJpdOWwVqG5y5tkoeyC5Lb3SGwoxh7uWuvTia8dM6nS/QTXvoR1/bbWtqEu28DV+tlzRYux2h+hlDvpzRZJL6EZEQrjlRJLdMdSJxU4CX6IaqZs0a7qqbZ5PAnpMwC5dW8YBkcejqchfUZA+BDPj2dwlNbojZCMNpFm3KFnH81ae748Z508T8qGaiU9fFRt//KGyDx/YWhi99vqzCOcEpszLmXZC6VD/tRucZNoaUv1eJJNo8Fq3eOo2FkZnNlkszYbKGh3QznE7hiViVr18XJjwwYnjoTZKuCtZ9mkeAdb204uB9NVEWh291dI5JQlq80rH7etmdNKawRDFA/S8WbKeYp6dePv7SPa3M9WmskmU+JlXiSa7MJFCJwIa2Qcx1KYwLZAwLfiV7OsErPWcTEB079Pkzv30wgIwm64PoBHhu8nxWJdINjUDYremOrHK4cIZ+Bz6Avk6eLD0TZkFH6Xy0AoFmvyVHq2QaH/yc531LIZ3VJymJ2M5gUOe0Zzjzm+4wj+1HOl41pmLoidntDTeyhMOufKYbkbmaHDn5HTAxwsbSfHab4hOHogPLVECNtlr0eR6PyO1r4U7tZCKpf5cyiUjp2dijhKD2jgiV/Ng2NTPMoIg/9i0pOZ5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(1800799009)(451199024)(186009)(7416002)(122000001)(38100700002)(478600001)(6486002)(921005)(71200400001)(12101799020)(4326008)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(41300700001)(316002)(54906003)(110136005)(8936002)(8676002)(5660300002)(38070700005)(2616005)(36756003)(85182001)(6512007)(83380400001)(86362001)(2906002)(107886003)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0I2dVZncFBCTCtKd0NTRk1teEdGN0cxZllwNDJ1L2FxeDhyaDFRMTJZTmtY?=
 =?utf-8?B?UDU0eHZ5dGU3SUFLYnNmMWFNL055ZkwrNTVlMFNJeEZrSWFZU1czUW9QYWtX?=
 =?utf-8?B?cnM5em8yemNwTXRXZ1dneEoyNDJCMCtxeGxOSGpIRFVZc0VtQVArTnJJdHZF?=
 =?utf-8?B?R0Q5TmcrdDNia2ZnbnlweW41N25uU2NmZURmZ0tESXg4THpWNXBydlZWT2hL?=
 =?utf-8?B?MVdtR2ZyOVRGVUhwUkwvc2U5NW1URE9zZkU3UUI1eHdkN0VVeXNJNkhabm5y?=
 =?utf-8?B?UUZsbEVXM3pQeTYzVDZja08vQzEyZGFyeTJITnNHSm1hRW14UStuT3NmWEht?=
 =?utf-8?B?MkpBaGhkSUpPSlhqT1VqeW0waVp4a0w2MHZhTEtRcjh5T2JpVlloSHphdUEv?=
 =?utf-8?B?L0VkZEZwNEdKNnVFUHkrRUlCcFBnS2lETUx6OXFzSWJMMDJneThaSE83bVVI?=
 =?utf-8?B?aGJTUzB3YTN2WjRndWp4RWNrdGttN1krQWVLazlEcWFLU2ljbXF0clBqeDJx?=
 =?utf-8?B?Tm0rNVNxcndkNU44c2czQVZPanpLdFVBV1dBZmw4WWlTK01weDdqc2orYURo?=
 =?utf-8?B?S1NjTE9la2VUZnVQR29EalZURGlQVEJSZXIwcFgxTjBuaG40cE5VTUhJdnNY?=
 =?utf-8?B?V1g1WEVqcGtDajVaSFUxUStCM0NxTmg0TDNEb2lCNFBvV2dXVEhXTFhFM28y?=
 =?utf-8?B?Rm41Q1FMZGVFNmRLRG5JczB6eTVXbGtmVGtYU2pwdUlxbXEzTk0zYnZ3eDJ0?=
 =?utf-8?B?SzBXR2krRDdLTUlrSWRSdVU2N0d6RnorNHordTFlTHJYc1FkaDRCWnRxdnov?=
 =?utf-8?B?a1ZjeWcyK0RIOUJjWHJaZksvRktkVlhROEZYNUJCTVJPVWN0UEFjL2pIcnlL?=
 =?utf-8?B?R3YzWW5NbWQ0d29zMjE0MDZqdzFUNDFsM0YwMFlqL3VzUjR1ZmFVZG96ZUFt?=
 =?utf-8?B?dTZBSFR6MVJvNWNkMC9PNVFXb21nMmNtTGY2NHlMaTJ3SUtUcS91aTVacHdU?=
 =?utf-8?B?VWxYUkNQT00ySVRNSWtjNXdEVHV3ZE1tWVFDYmNPU3d6ZU9pbllCbCtqeEdi?=
 =?utf-8?B?a0o3eTdBWkM1VE1ZQWJzNTdsQzZZQmliOWQ0NTE0N3FYb244S2RlZWR0UDlV?=
 =?utf-8?B?MXJ2WDZYQ0ZydUhFMHlqK2tQVTBJc0ptSlBTNzgwNVM3d29tb2g0b1ZVRHdN?=
 =?utf-8?B?ZGVBSHpCVHJ1bGtNV0hnU3Q3NnY5dU5EdDllcWYyN1dnUTBVZDNYL04yMXQ4?=
 =?utf-8?B?VWxIc3duN3BiU0JyTVduSVJUWlhjSXBJTkRxQkRCR29QTlFqSlpoY3lNTDBp?=
 =?utf-8?B?c0J2UFZrUDJKSURzRE5uRThCcDFQemZYNmRjL2t6TUdOWEFSZFk1SzgrZitJ?=
 =?utf-8?B?eE1zN2x6bXE3NWY2MUwwYTZwdVoxVEJnTi9xWGxOSVVzMzNiSnY2bWZXVlN5?=
 =?utf-8?B?eGhCS1U1TWsyOGRsdFF4RmZWSFhHVFpQampPZFJnL2Q3TjVOSWxOei9GZ0Fh?=
 =?utf-8?B?ZXpuUDUrN3FvbVluMitSWEl3bm9pRjUvSkEzSWVscXVvZXlPSDdrdW9lcitx?=
 =?utf-8?B?ODZpVnpKczRUeFJsMHJiNkdLTFdHZGdueVFSMTlKSU5aaVVrcnh1VkYyVlJL?=
 =?utf-8?B?VEFFZmVLanhna0cwTWJCeGhnMTcvQnpGaGl0SURvYzRYcG1rb08xWG5TL0FM?=
 =?utf-8?B?Tkh4YTJTamJNVmJHdjZFNWtzMmJ4NHYxVjQvZlhLK0xWWkxMcHAxNFdpY1Ra?=
 =?utf-8?B?NTJvaFJqOTJhb0ZMbjBxaVErOWx5YmN5L0RCR3g2M21LZ3NyUkltV0d2Y09H?=
 =?utf-8?B?cmxyT1dndkJVbGUvd09DRkk3Z3BqZzZwUVRHaytkbFF2cndYNGNtZXVVNi9X?=
 =?utf-8?B?N1pFZEQ5aldyNnM0MXN1dHIxUXd0ZExwbStUSmVGcUM5ODVtRDdxbjFPdmh3?=
 =?utf-8?B?WVdxVVZzK01xSEdZaWlmRWV4eVJJL0hBa2VIbXRiQStQcDFFYm5TTlhCQjhB?=
 =?utf-8?B?NXptMjdIRDE5alFDZ0NubmJuVE9NMkx5Zy9KQWZiWVdZNHZXSVZTQ2dscHFO?=
 =?utf-8?B?aFg0Nm5GQzZqSkVPSWVRd3B2dVZ0L1dwdHpQb3hKM0FwS1FxcnJXbWQ1Y05K?=
 =?utf-8?Q?akqIn8dJUOyt4q5sTmHkauGHt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A78178D2F9DC94E9886F87278727A1C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1789f435-75a4-4ad4-957e-08db9e281dd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 07:12:13.9154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nJWfWqmCeYyJiAGdcI79Fxp4OvoAdt8U1z57bkGti5jWfPGKB/7d8+7FroBs17uo3NqX0vbEVFaNOpg11AVYAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5422
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNodWlqaW5nOg0KDQpPbiBNb24sIDIwMjMtMDgtMTQgYXQgMTU6MjggKzA4MDAsIFNodWlq
aW5nIExpIHdyb3RlOg0KPiBBZGQgZHQtYmluZGluZyBkb2N1bWVudGF0aW9uIG9mIGRwLXR4IGZv
ciBNZWRpYVRlayBNVDgxODggU29DLg0KPiBNYWlubHkgYWRkIHRoZSBmb2xsb3dpbmcgdHdvIGZs
YWc6DQo+IA0KPiAxLlRoZSBhdWRpbyBwYWNrZXQgYXJyYW5nZW1lbnQgZnVuY3Rpb24gaXMgdG8g
b25seSBhcnJhbmdlIGF1ZGlvDQo+IHBhY2tldHMgaW50byB0aGUgSGJsYW5raW5nIGFyZWEuIElu
IG9yZGVyIHRvIGFsaWduIHdpdGggdGhlIEhXDQo+IGRlZmF1bHQgc2V0dGluZyBvZiBnMTIwMCwg
dGhpcyBmdW5jdGlvbiBuZWVkcyB0byBiZSB0dXJuZWQgb2ZmLg0KPiANCj4gMi5EdWUgdG8gdGhl
IGRpZmZlcmVuY2Ugb2YgSFcsIGRpZmZlcmVudCBkaXZpZGVycyBuZWVkIHRvIGJlIHNldC4NCj4g
DQo+IEJhc2Ugb24gdGhlIGJyYW5jaCBvZiBsaW51cy9tYXN0ZXIgdjYuNC4NCj4gDQo+IFNodWlq
aW5nIExpICgzKToNCj4gICBkdC1iaW5kaW5nczogZGlzcGxheTogbWVkaWF0ZWs6IGRwOiBBZGQg
Y29tcGF0aWJsZSBmb3IgTWVkaWFUZWsNCj4gTVQ4MTg4DQo+ICAgZHJtL21lZGlhdGVrOiBkcDog
QWRkIHRoZSBhdWRpbyBwYWNrZXQgZmxhZyB0byBtdGtfZHBfZGF0YSBzdHJ1Y3QNCj4gICBkcm0v
bWVkaWF0ZWs6IGRwOiBBZGQgdGhlIGF1ZGlvIGRpdmlkZXIgdG8gbXRrX2RwX2RhdGEgc3RydWN0
DQo+IA0KDQpJIHdvdWxkIGxpa2UgdG8gc2VwYXJhdGUgbXQ4MTg4IHJlbGF0ZWQgY29kZSBmcm9t
IHRoZXNlIHR3byBwYXRjaGVzIHRvDQphIG5ldyBwYXRjaGVzLg0KDQpkcm0vbWVkaWF0ZWs6IGRw
OiBBZGQgdGhlIGF1ZGlvIHBhY2tldCBmbGFnIHRvIG10a19kcF9kYXRhIHN0cnVjdA0KZHJtL21l
ZGlhdGVrOiBkcDogQWRkIHRoZSBhdWRpbyBkaXZpZGVyIHRvIG10a19kcF9kYXRhIHN0cnVjdA0K
ZHJtL21lZGlhdGVrOiBBZGQgc3VwcG9ydCBNVDgxODggZHAvZWRwIGZ1bmN0aW9uDQoNClJlZ2Fy
ZHMsDQpDSw0KDQoNCg0KDQoNCj4gDQoNCj4gLi4uL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWss
ZHAueWFtbCAgICAgICAgIHwgIDIgKysNCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHAuYyAgICAgICAgICAgICB8IDM2DQo+ICsrKysrKysrKysrKysrKysrKy0NCj4gIGRyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHBfcmVnLmggICAgICAgICB8IDIzICsrKysrKysrLS0tLQ0K
PiAgMyBmaWxlcyBjaGFuZ2VkLCA1NCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiAN
Cg==

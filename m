Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9FB7D7E82
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344584AbjJZI3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjJZI3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:29:51 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EE718F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:29:47 -0700 (PDT)
X-UUID: ce87483873d911ee8051498923ad61e6-20231026
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=hR2ekvs0wZXbRyXnINxKPHyzhV4r7S/LabUKDiXRMTs=;
        b=Dos+pk84KSQ6ckGIAGpfcOBWYNAceDNt5j9GAVfPxms6dLtWcVxOwS+6Nh42Q0Y2EoBwyZCTHoDU6P52j0I2cwy9ontmEzkz9CiPeIxTLuJFdqAGF6VJRBmovnBayiVSzqfNBQR4jWFRzEUvjk/GtaxLxYPH54IfKrrDEGUwOJY=;
X-CID-CACHE: Type:Local,Time:202310261627+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:b43a05a2-ede1-411d-852d-3b1d9af467bc,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:342aa994-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ce87483873d911ee8051498923ad61e6-20231026
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 703203001; Thu, 26 Oct 2023 16:29:40 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 26 Oct 2023 16:29:39 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 26 Oct 2023 16:29:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9rgvQ55ZEk/mWo3H4L7AV9I78WHr6B2pHO5XzZYm4sdy9oMpWKO6gclARtcXRVkQQ55f7szbahmWiBwyFfogAoIIipgEtIE+uwqD12/JDoHTmC5yDTpiMrYmATv1h7xr2sejbarT/ycjEqYgnkpSoBMhUAubx62/xgA666GbEhHIoLPeRX6mkF1d0zjZHl7oXc8k4TGRN+uXNbmNoxPi1uPflz0r1r9OoiigLYsNKgMOzPovcYXyY0V0te1NFlat8WDsdyXVMjAa16Ld36Ih5j73U8acG8XYudqbBwID10aRqTh5kKWlwx2Dc7PT+1pcxlrAkQAEvlgKxRlQfdDTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hR2ekvs0wZXbRyXnINxKPHyzhV4r7S/LabUKDiXRMTs=;
 b=eZ8ET1dHpU2QGHG+UALmnPUUFYCSMQJrVLVl4wsYANzYFn58POOngha1lTpdgqcrJER9JvIZpd0PvmS9pbcdQwceY0cz1suZinq3DLtvMdGVMYBS1fHZAu/m32eY/zrsjRqWSmt4dxMtahDRCisbi02cQcsBuo/CBgIQBpUCzoJUd5A9AqbGYdfZJzU7i9OZlnWFHjvLfuhHMxkd2+OpVR+HFh2IlHOl3l03lufsDcbmzIEV8O9V/hXkyspoN9ePfJySw7Wvkn0MOfHow462ROL0FL9MtE6bbvG9if+798tLE82Bb/M2G1kCT5jqK3dTsv1cPeQoBsUVIid+7YgA5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hR2ekvs0wZXbRyXnINxKPHyzhV4r7S/LabUKDiXRMTs=;
 b=OzKmaie9REucvKubvYKzNPfZdE2127hd3XGHLA5NST8HRAIpvovJUuLNXgzQc2TUh2wgtGU7ny/Eq0EFJvKtNpmYX4dRhi1lSCr0Kw6ZBSBt1yYV8GKzal+1MoBYS5hWvA+OV5weoWb3qR0B1JgDK71KnHZTmUUXxQTaus3ptAI=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB7028.apcprd03.prod.outlook.com (2603:1096:400:334::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 26 Oct
 2023 08:29:37 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::fe5a:c0e7:4b72:64f3]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::fe5a:c0e7:4b72:64f3%4]) with mapi id 15.20.6907.025; Thu, 26 Oct 2023
 08:29:37 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH 1/1] drm/mediatek: Fix errors when reporting rotation
 capability
Thread-Topic: [PATCH 1/1] drm/mediatek: Fix errors when reporting rotation
 capability
Thread-Index: AQHZ6f8vHkJnpu39rkK9AaMAy7b/rLBbin0AgABuEACAAACPAA==
Date:   Thu, 26 Oct 2023 08:29:37 +0000
Message-ID: <7c3a6f368c963a53f52ecd9e549a39ec47ebd7df.camel@mediatek.com>
References: <20230918071011.18481-1-shawn.sung@mediatek.com>
         <20230918071011.18481-2-shawn.sung@mediatek.com>
         <10fda9ad9ffc4a16418ccd8b113f8cece461747d.camel@mediatek.com>
         <72db0a70e99374509140dada1363edb33b33b1e5.camel@mediatek.com>
In-Reply-To: <72db0a70e99374509140dada1363edb33b33b1e5.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB7028:EE_
x-ms-office365-filtering-correlation-id: b1220b04-0dda-44ca-a775-08dbd5fdb0e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zkWlEFdE2RtQ7yfAASTr6dlOqm6VNttwZy466m+YaREA2vSWYRZjn9jYt3Mfu+do6Ifs9zlMcs+6d1je1SoPZXSpQHZV03P0lpnyB06qILHzDFVloDOscbtNm2A5ZWBOsstmcY4E4kCMobh/OA/sqntwKRu7sRjeOpfcQ+t37qDloJ9V9g46bMOKTk+Q7qKVBXnzLQhtc+U9c+HgbZrzsjP9BgQL+tWWwoKJZAW/wjtMV2nYv7kIqo1RLjWk4G2aoPKNdHMVYT+DICEC0PJ7MhtMfy/J5HtpMMb5lsmjsUUX/eioUa6G9zuuerWGQUa8J1ZRUG2JwVsHg0M+5NYtsr0dVB7/YYDo8BV/plxTEkwXr9C6Gu6VheAdBwJynkQCDIUYFmvgaM6iKopK73c5gpUl2BqwV84+wvJM+AkoDdM13+Ji6JWYSqdSKZap95dSyWHI4heqshwHGq8BjTdrremeVcD+Jg0jNQytwDyUrZS+4i6G+xFASyEbxTx3on6OGGqDpbw2+AI9cDgQvIDOmnSKU62Dz1VxoS8bnwgBI72e0F1696/E4Raor4AtHDi8PxhE8RBj6NhA8hODRP414bcaS8eFSzfA0tZUaZk0TmEMFieStsAC/0VZpt9TBHEE25aBHwO1KyeTtO171p/wLzUVXFlpaAVH52j+DarwrgM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(136003)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(83380400001)(54906003)(86362001)(5660300002)(4326008)(76116006)(66946007)(6486002)(66476007)(66446008)(41300700001)(64756008)(478600001)(110136005)(6506007)(6512007)(316002)(66556008)(8676002)(122000001)(8936002)(4001150100001)(85182001)(36756003)(2906002)(26005)(2616005)(7416002)(38100700002)(71200400001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjFMTDczbCs5cXhRQ25uL081TEZoaGQrZ0ZISVJGT3lES2gvK24zR3JrL1hQ?=
 =?utf-8?B?NTVFNU9wQXVTK3pFdTNFNXovUFBYNEtpV3YyOCtoOFd1clo5QjQ4MmUxOHd1?=
 =?utf-8?B?L0daZG9NSXV3dUR4d21nRTdZWHN5ZHlRZXkvSHRYZDZ2T0hTVnB5dWNxZ3Nz?=
 =?utf-8?B?UU1lVU9xQ2ZGNDNSL1ZTeCt3d3lMbXFTL2JJSGF0NjRDZzdLMEowRlNPZVp1?=
 =?utf-8?B?NjdrVjVxQVUxMzdZVDhPejVEV1hPVWNIMkZEMVdzNTBjaTZqNlJ0S2hGblRJ?=
 =?utf-8?B?WjBsM1hsZGVLMHdCU2NPRjN6eDdiYnZ5NG5HL1VnSURJa0FGVUs4SFZMc2lz?=
 =?utf-8?B?ZmtxSDlZcjBrSUFwMlRraWdZUFdlbk5LN0U4MzRwelJNSkd3ZEoyVGRydUdS?=
 =?utf-8?B?QlhRdjVLSWRNR1BtVUdpTmw5VTA0ZWZnZ3NlSDRBSWJxSnlQREpxeFdnM3hM?=
 =?utf-8?B?OTVXeUVkaE9aYUlvZ1VndjQyZTJUMDlEeFBBNDZEa0ljd0puSUI2NG1ybjBE?=
 =?utf-8?B?c0NOb3l6WXNWamFRWTVaRU14Z2U4MkVvSzdzZklpRmZiYlVpQVp2c2FMQ2R6?=
 =?utf-8?B?L3A1SnorRlhLTkhrR1phajhuTDBzS0Mrazl2aDNVWVVCSk82TVBGNUd5VGVW?=
 =?utf-8?B?UHNHeXhvR2phTVcyZXU4T1FsYXhzUzhhazBiQ0NDaVdtbnU5bkZteVlrZ1pa?=
 =?utf-8?B?VlNCRkUwNUNYWm0yUUQ5SkdWeFpVVGFrMUUzd3hkRk9JUnlock9vNE9iRWRh?=
 =?utf-8?B?c2lxTUZOU0x5emJkai9rN1J2YzRLV2k4TklGQURkdmIzeFRlbHplM2ptTjB1?=
 =?utf-8?B?NnA3aERHOE8vZzl0ZnMrUjNtZmxTdUFOODRUL0Rnak9iSmFoSk5UQnl4TnNk?=
 =?utf-8?B?encyRUxZL2NvTVZTdldjT1pqRkNGWStaOU93MngzeTAxanljdnhMTkQ4Y0Rh?=
 =?utf-8?B?OGxGOVZFeUZRRXNpRlZVMGJ2RUhNMkdwdkJXR1lzWEVNMjlMdHBhQXp3MER0?=
 =?utf-8?B?SDY1WncyT2RwcGMxSUU4ZTBwSEplWk1Md3B5S1hXb0ZoeTVSM2hPMTRYU1Rt?=
 =?utf-8?B?RTVhYnFtWlJrVERlWVRxMVh2amQyZVpSYUd4SXh6azI3YkRLM0lEZjZya0gy?=
 =?utf-8?B?TmhZTytlSXlSZlhyVENISDJ3dTNCVWN1YVlrUHpSL1NPTW9ZenZFRlM2KzNE?=
 =?utf-8?B?QUR1MnFGY01GVnFnY0k3Z2R2WXlyS2VXbElBdHFEOHBQV0FJTzgwcG9VVkVG?=
 =?utf-8?B?cThwV0haZVVmWHR0SmNFdWkrYm9ieUo3QWIvazF1MlhwMmpFQm93T1ovaWJW?=
 =?utf-8?B?RTJlbk9qcEgxRE5nYzYyWXlWT1drbFY4QmY4ZHcrRVJkS0p6R1l1WXB3MzBW?=
 =?utf-8?B?Q3g0bzd4K2VsSkZEMlBsb1BQV1UzU08vYU9xeXZ1Tit1ZFR2YXAzNFNzbmNQ?=
 =?utf-8?B?WUN4SlB5KzZBT0hvWUgyNjZ6VWN2K1AyOC8wdDl5OXFSYUNzTmpVemRrRUhx?=
 =?utf-8?B?RndQcEVwV0NZWUdDZ3U0aE5GZEVDcUZTR1BZK1ZnL2lKWkhmZTlrYkRYbUVC?=
 =?utf-8?B?blFnalVaMHJYSmVlci9hWHU5bTVwSStBSEVadTdlSFNWNEJhcjc4bVRIQ2VI?=
 =?utf-8?B?RVJubDArMWxsd1JvalNlNmM0d2R5UXlkck5yR0tBeDE3cWZnTEhrMlB4TUdJ?=
 =?utf-8?B?ZEwvVWMrcUlZNW9sMWtZWmhFVXZJRVlmWnZRYlNPNVRsYWdzcFBqeWxsQjZG?=
 =?utf-8?B?dzJOT3R2Zi9VeWlTWGZQWDlCR3pCc1QxSE0xK3hNTFVIV01NdE9ETTZhc0c2?=
 =?utf-8?B?UGZsN05PSnpvYktqcUVOQTV1ektNK2IwYzJheFE2TldHcTd3Q01MYjIxUGFn?=
 =?utf-8?B?M1JtUjJhaVMwWEo3QUdlT0d2WGJyQ2Nocm44eFlGMkdVWkdQVGdKL1I1eDky?=
 =?utf-8?B?MTBscDJCbnk5RkFRRE8rckZLd3FzRERIcWxyK3RUeG1TanM4dytTME1wQUsv?=
 =?utf-8?B?a2RuNUN2Q3NWUUNZVVh1Mi9kcVpQLzhOSU4rcmpsTkJnU3d6anR6aGwxVi81?=
 =?utf-8?B?VEJhaElPbVFzcWVZZURuTzNvR0o0TXQyL1ZkekVpMnlaUFVHUVRnRzdYUFI1?=
 =?utf-8?Q?AUu9JuvwKJf6//CnsGzbhNatX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2D9262B3B8A164B8A7E302543D103DA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1220b04-0dda-44ca-a775-08dbd5fdb0e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 08:29:37.4265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vjngk8fd+3dhcpR36hOQVRgVvpr6/hwpc4rkceKRzJ95Lt7ye2nWxYWw2GCRYXM8RnyM+iAGROPj6ZLOmevVDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7028
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBUaHUsIDIwMjMtMTAtMjYgYXQgMDg6MjcgKzAwMDAsIFNo
YXduIFN1bmcgKOWui+WtneismSkgd3JvdGU6DQo+IEhpIENLLA0KPiANCj4gT24gVGh1LCAyMDIz
LTEwLTI2IGF0IDAxOjUzICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90ZToNCj4gPiBIaSwg
SHNpYW8tY2hpZW46DQo+ID4gDQo+ID4gT24gTW9uLCAyMDIzLTA5LTE4IGF0IDE1OjEwICswODAw
LCBIc2lhbyBDaGllbiBTdW5nIHdyb3RlOg0KPiA+ID4gRm9yIENSVENzIHRoYXQgZG9lc24ndCBz
dXBwb3J0IHJvdGF0aW9uIHNob3VsZCBzdGlsbCByZXR1cm4NCj4gPiA+IERSTV9NT0RFX1JPVEFU
RV8wLiBTaW5jZSBib3RoIE9WTCBhbmQgT1ZMIGFkYXB0b3Igb24gTVRLIGNoaXANCj4gPiA+IGRv
ZXNuJ3Qgc3VwcG9ydCByb3RhdGlvbiwgcmV0dXJuIHRoZSBjYXBhYmlsaXR5IG9mIHRoZQ0KPiA+
ID4gaGFyZHdhcmUgYWNjb3JkaW5nbHkuDQo+ID4gPiANCj4gPiA+IEZpeGVzOiBkZjQ0NDQ1Nzcx
MTggKCJkcm0vbWVkaWF0ZWs6IFN1cHBvcnQgMTgwIGRlZ3JlZSByb3RhdGlvbiIpDQo+ID4gPiBG
aXhlczogODRkODA1NzUzOTgzICgiZHJtL21lZGlhdGVrOiBTdXBwb3J0IHJlZmxlY3QteSBwbGFu
ZQ0KPiA+ID4gcm90YXRpb24iKQ0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBIc2lhbyBD
aGllbiBTdW5nIDxzaGF3bi5zdW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRy
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaCAgICAgICAgIHwgMSArDQo+ID4g
PiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jICAgICAgICAgfCA4ICst
LS0tLS0tDQo+ID4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFw
dG9yLmMgfCA1ICsrKysrDQo+ID4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZGRwX2NvbXAuYyAgICAgfCAxICsNCj4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RybV9wbGFuZS5jICAgICAgICB8IDIgKy0NCj4gPiA+ICA1IGZpbGVzIGNoYW5nZWQsIDkgaW5z
ZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiA+ID4gYi9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gPiA+IGluZGV4IDIyNTQwMzg1MTllMS4u
ZjRjN2RiYThmNzNkIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kaXNwX2Rydi5oDQo+ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2Rpc3BfZHJ2LmgNCj4gPiA+IEBAIC0xMjAsNiArMTIwLDcgQEAgdm9pZA0KPiA+ID4gbXRrX292
bF9hZGFwdG9yX3JlZ2lzdGVyX3ZibGFua19jYihzdHJ1Y3QNCj4gPiA+IGRldmljZSAqZGV2LCB2
b2lkICgqdmJsYW5rX2NiKSh2bw0KPiA+ID4gIHZvaWQgbXRrX292bF9hZGFwdG9yX3VucmVnaXN0
ZXJfdmJsYW5rX2NiKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ID4gPiAgdm9pZCBtdGtfb3ZsX2Fk
YXB0b3JfZW5hYmxlX3ZibGFuayhzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiA+ID4gIHZvaWQgbXRr
X292bF9hZGFwdG9yX2Rpc2FibGVfdmJsYW5rKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ID4gPiAr
dW5zaWduZWQgaW50IG10a19vdmxfYWRhcHRvcl9zdXBwb3J0ZWRfcm90YXRpb25zKHN0cnVjdCBk
ZXZpY2UNCj4gPiA+ICpkZXYpOw0KPiA+ID4gIHZvaWQgbXRrX292bF9hZGFwdG9yX3N0YXJ0KHN0
cnVjdCBkZXZpY2UgKmRldik7DQo+ID4gPiAgdm9pZCBtdGtfb3ZsX2FkYXB0b3Jfc3RvcChzdHJ1
Y3QgZGV2aWNlICpkZXYpOw0KPiA+ID4gIHVuc2lnbmVkIGludCBtdGtfb3ZsX2FkYXB0b3JfbGF5
ZXJfbnIoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kaXNwX292bC5jDQo+ID4gPiBpbmRleCAyYmZmZTQyNDU0NjYuLjVmZDFmNmFl
NDFmMyAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlz
cF9vdmwuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292
bC5jDQo+ID4gPiBAQCAtMjg4LDggKzI4OCw3IEBAIHVuc2lnbmVkIGludCBtdGtfb3ZsX2xheWVy
X25yKHN0cnVjdCBkZXZpY2UNCj4gPiA+ICpkZXYpDQo+ID4gPiANCj4gPiA+ICB1bnNpZ25lZCBp
bnQgbXRrX292bF9zdXBwb3J0ZWRfcm90YXRpb25zKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiA+
ICB7DQo+ID4gPiAtCXJldHVybiBEUk1fTU9ERV9ST1RBVEVfMCB8IERSTV9NT0RFX1JPVEFURV8x
ODAgfA0KPiA+ID4gLQkgICAgICAgRFJNX01PREVfUkVGTEVDVF9YIHwgRFJNX01PREVfUkVGTEVD
VF9ZOw0KPiA+ID4gKwlyZXR1cm4gRFJNX01PREVfUk9UQVRFXzAgfCBEUk1fTU9ERV9SRUZMRUNU
X1ggfA0KPiA+ID4gRFJNX01PREVfUkVGTEVDVF9ZOw0KPiA+IA0KPiA+IElmIG92bCBlbmFibGUg
cmVmbGVjdF94IGFuZCByZWZsZWN0X3kgYXQgdGhlIHNhbWUgdGltZSwgaXQgaXMNCj4gPiByb3Rh
dGUNCj4gPiAxODAsIHJpZ2h0Pw0KPiA+IA0KPiA+IFJlZ2FyZHMsDQo+ID4gQ0sNCj4gDQo+IFll
cywgaWYgdGhlIHVzZXIgZG8gc3VjaCBhbiBvcGVyYXRpb24sIHRoZSByZXN1bHQgaXMgZXF1YWwg
dG8gMTgwDQo+IGRlZ3JlZXMgcm90YXRpb24uDQoNClNvIG92bCBzdXBwb3J0IHJvdGF0ZSAxODAs
IHdoeSBkbyB5b3UgcmVtb3ZlIHRoaXMgY2FwYWJpbGl0eT8NCg0KPiANCj4gUmVnYXJkcywNCj4g
U2hhd24gDQo=

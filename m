Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E68F797A75
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245387AbjIGRkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245138AbjIGRkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:40:08 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9F810CF;
        Thu,  7 Sep 2023 10:39:32 -0700 (PDT)
X-UUID: 0da42df84d4511ee8051498923ad61e6-20230907
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=fWRusZI6/0QDiQUu7GrVk+0Jak+G2ck/NIksTPKeMss=;
        b=Ev5s6+zZj6pVarRM6Td4p/k/gtHigkoncq7sgvu9XwsIQFL07K9oAOLdeZqwJhWDL7GdGTf0SlgRRiMi113BDJ+ZSSV2iB0g8V+30iFiwWRWsmznKK0BdujPa7lhNMDYLuQuZbzUl+OvAGuA5myPpueVGFMz/+cmHnzUkrHfvDY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:4c15fa96-6379-4316-ba05-285ecd6737a7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:2d676aef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 0da42df84d4511ee8051498923ad61e6-20230907
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1318225805; Thu, 07 Sep 2023 14:09:07 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 7 Sep 2023 14:09:05 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 7 Sep 2023 14:09:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1QXaTsSXjfqbEC2mbaBeeP6goHnF9lu0weE0+moRPEw8NT+tJqgjUff+vKSqfB4jrXBPbxw5fJR1OTe0hnWLpSaddJCuK0f34BWMTbiG03sl+ZCm3WT0dQTcE3H2TCCotsN8R+86Pb8yhKDR4wRgc3xcBwsba4gapv6KSzi0o7AFoOo2DSH2sT4qTKQFh6jWH23ZbQRcSWopaorXhndY6rtRoggfs1jBxyaFnHnSH9S3/BqFKo842nahFm4c7n1eQSm4+DYddr2aaFZ86uDr86ZinzteGJ2tc41bF4Ud6Z77mDsdym3q1kzBY9E2qicJn2D7H8s55TMqbPy3JgEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWRusZI6/0QDiQUu7GrVk+0Jak+G2ck/NIksTPKeMss=;
 b=dTieoLM89sHAOj+ykFdARVaQsFDXGrEBzcv/n/+Zgy82pvUZ4GSWxFWweWIPZFObfD+bbhRRscKz62nOZ40iMsUO9RMA+UmH5VITDodBHdry53oQmc1V2q+BRr0gbiAMbMlxLoEHocTDI2nrWtCil4/9KUmvEV4+U8aVNMfTFlPn3x9Tn7XbgFCzH19iKm2fEJNv+4PVgtva9IeE2m4Xo2AnwwiAoP9P/cqJ8zxAJ5X29biHjDP6xk4/4fmlW0Cd/FybGUdlSdmivegRaCdBuyMbBPZ/6FXE1SysKM17056MBRBJAFW3l6squUkx+odF5IUhJmHVehUmjy4rObporA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWRusZI6/0QDiQUu7GrVk+0Jak+G2ck/NIksTPKeMss=;
 b=mTq4AungKiPwhg42ZPQxh8alN7/DoDkf0eOoM5tZntBzybvfPadDUqhmAfq+FowDOradq0NErQQOSQ98/OHEQUJqVSPt9dBNO5nfE5VjrXNKG2a4Uq3J366s6nJ9JDJgftyyiq5HJy4jh1V4yuxqnm2gTYAKjjqL8+sowLli5yY=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB8335.apcprd03.prod.outlook.com (2603:1096:990:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 06:08:46 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 06:08:46 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= 
        <Shuijing.Li@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
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
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>
Subject: Re: [PATCH v2,2/3] drm/mediatek: Add mt8188 dsi compatible to
 mtk_dsi.c
Thread-Topic: [PATCH v2,2/3] drm/mediatek: Add mt8188 dsi compatible to
 mtk_dsi.c
Thread-Index: AQHZoCVaukQPOe/o9U6IjmLMU9LbZbAPYzmA
Date:   Thu, 7 Sep 2023 06:08:46 +0000
Message-ID: <67813ea6e688036d68c10fa979562b6aab80bda9.camel@mediatek.com>
References: <20230616073659.26536-1-shuijing.li@mediatek.com>
         <20230616073659.26536-3-shuijing.li@mediatek.com>
In-Reply-To: <20230616073659.26536-3-shuijing.li@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB8335:EE_
x-ms-office365-filtering-correlation-id: aafa8e7a-60eb-4975-2b97-08dbaf68e54d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tClrSqCcyBleXFn/+7gZ7pLR4OS/HstbS/sqcoD85H3B3K14Nugn8STYxlHCcfH566ciT+2P3nOTZwjuzJ7b4gvZmkML38qGpuJpkEb80fD26XKyjtmJcniUj+7vy+P8P7Y1ryKY38762z1ldBtix72Y/eVE6NqL5zQYK39PTrwHfLB654n2WLtXlLWHnDgKIl2pjSiHr0j22C/naQDXkCNKETusLdQd9ZEV0KvwOx3saXrbqlbOUUCdu23O8Ksp2sgZ9qK5kMYhBZ/xGHdFXLgQXf0lm9K94hywxjRt/mqhgiwykPnCJXuI5/53iBLyf7lLC81So0/wYAMYib1aTnc5sU9qshy6DM/0zOrpjt4kOzGgVsiSBh3X2eh1zjNjomR+mLzj4CexhndUS01ICDRKZYB/nv7rSqbZIzMKt1BbTDKoFyH2VuyUJFAKlEEzda/+34khtDY9qwneUj8CmkvUPt4YZV0VD6+IDBvB059+sDQDzU8USi3MNCRAw7JhhnD8RqEq7oed9iA3yZOcKMcREzEa931FS+d4jkpX5ccJ0Typ/rMKogtKRgF+SZ2wMa847PxYYRKXqmwniZbIKrcTzagyhCmBFHUmBzEsaWLkdoMQDGIFaSVP+GW4JozLIjdDcUIZNN6eThFmnYunSeBePQS1sDVCMHVq5fri4TzTG7bEq9KYXSxINkNoD8Hm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(1800799009)(186009)(451199024)(6512007)(6506007)(6486002)(38100700002)(2616005)(122000001)(38070700005)(107886003)(71200400001)(110136005)(86362001)(478600001)(26005)(921005)(66946007)(76116006)(8676002)(4326008)(8936002)(36756003)(85182001)(54906003)(5660300002)(64756008)(316002)(66556008)(66446008)(66476007)(41300700001)(2906002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SU50SGs5d1FaRURCd2tVaGd4bzR3cmgxMkNoSmZZN3h0WGhMcnRVRjcrU0to?=
 =?utf-8?B?aGRmeUY4R0pEcFdKR2JjWjVoaTRiT3hSVWdKNSsxRkxXKytEaXJ2ZURhekFn?=
 =?utf-8?B?QVVOMUs0T2t3UWg2c3VoR3hERDBrQVBUUUs5OG4rbm5tMExRVDZTSzdjZDJm?=
 =?utf-8?B?UGVHNUtnb3pkbjAyK3FjS3h0UDI5ZjRHanN5aWxRVG1VUEhHNWtNZkpmeFYx?=
 =?utf-8?B?RU5zV0JvRUwvaVFlZnU3YnZxMlowNC90OWFtT1U5K1RwbjJQOWh5UlVBOXhw?=
 =?utf-8?B?ZHZ1blR1MXVuZkFud3FtWUJPajBhV2E5cW92S21IclNBeE5TTXB0TlBEbUtJ?=
 =?utf-8?B?ZlNtc21EYXZEakhDd25jUGtRR0Y3M1MxQkNIdU42RDZ1VU5wekdXR0JPOGJJ?=
 =?utf-8?B?Q09Oelh1OGZueitGU3RUcmNybUQxMjdCYzVHUXFVMmFQZUtzWGlSbGpSOTI1?=
 =?utf-8?B?byt0cTM5ZklJRGtmaW9CZ2tmcUk5UzFqSXM3Y0NwNjJpcTF0T1VSZUpyUEh1?=
 =?utf-8?B?TzQzUGt6THV0UGE5a0Z3S3p5bmJ3RDVRUE9wQ25ZR2l1MDN0ZFJzZDZwcDdu?=
 =?utf-8?B?Zy83REp2a2VDSEFkaUgzL0o3N2NSRGJaTjROYjlpakd1OFhRZUZmeS9LUzlQ?=
 =?utf-8?B?eXZua2E5RnBPd29zdVZCTjVLY2NvRWVhOCtSVDczRFJRTnJJNmhKYUhlKzBN?=
 =?utf-8?B?UEI5THVvK2V3YlVuVzlwS3JOWThQR2o5NU44ZEF0UkhtYWRxVUJIdDlUUkNz?=
 =?utf-8?B?dVBRYkZrWWhGRVROTkFFOUV2VE0zK2ZSVm4rR3VKb29Kd0JTSUwvQnlUa1lU?=
 =?utf-8?B?TUx4WXVNQ2djZXBSazUyR1JRWFMyQjJZYzJzS2I4RGNyQmNzV2JKcHIycmVm?=
 =?utf-8?B?anJ5VU1FSHZkQzhNSjFlL2diSWNwcmRLc0tNS3RWL2NqUmpHRHFTOCtma2Jq?=
 =?utf-8?B?UWIrcHZEU3o0aVF3OE9WdmFNUitXZGl3SmtUcFhkQWlyb05zOVU2L0h3TzdX?=
 =?utf-8?B?bGRNOTBrZjNBOW1JZlhQQXQvN2pzb3JWcnlUeUtLL01wSDNQNTFDemtOZitE?=
 =?utf-8?B?TWVFdDE3dGlaNEJOdVp0THFsMkxYR0N5OUt5SCtIaUhMTU5HMkZYZjhpWjFh?=
 =?utf-8?B?M0poU0R0aWFZMWpFdHBRNi8wQlgzVVVoZWFzS3dQbDRxeURhTU1IT3dhWG80?=
 =?utf-8?B?dXhXME5XQVpkeWZXdDVvbWV0V1BkdVl4ODJxdGE3YTVzQWhKUExWalZqL3U2?=
 =?utf-8?B?SWR1N3FiWHZzdlpYUGRYTlU5RkdLWmtHYU02M2R0NVpyVHFxUlgwN2lGTTdG?=
 =?utf-8?B?MlplNVB2djQ3aHhRYkpLZEE3R1h1ak5hQzdWRndsWnBKZnljc2JxVTBJVytU?=
 =?utf-8?B?WTNaYnB3bjN6SS9uR1BrS2dCWkFMOUlOK1ZPOUF5VytUdzRJNWs2dmRRUmx6?=
 =?utf-8?B?cGpVbGNiYkpJMjR6eS94UXlNdXpScUNaaFJvN0w3L2JpT2FkajhyeWhNUTNC?=
 =?utf-8?B?Zlhtek1lR2dZT1d3ejZKUTVqZUtvTGliUERmelovdWJYS3JxVmpWSUFSYVJV?=
 =?utf-8?B?T25FeU5uc3BpY24rY3A0OHpaV1Y5R21IcExZWlVCTHB3RzBrK3dJbFpCWWpG?=
 =?utf-8?B?M3p4aG1EaytkaWFFbUJZOFFYcGZYcUNZb1BsZHZua0c2UHcyemtqa1VSWVhI?=
 =?utf-8?B?QTNRMDhwV1REai93TS8wYXhqanZmdjhDWUUrTzJZd1Q4UnBSVDNVaFBXcmlR?=
 =?utf-8?B?QUorcFZQWWFnYk1NYktsbGRrbVZzWEFWZGJaTlNJSDdTL0FTcFp6NzhycVph?=
 =?utf-8?B?NW9nSU9UcE5GZFlkL3RONFRPaGRnaXUrQ0ppS3ZqWllobUExZXd4TFJUU3pT?=
 =?utf-8?B?dlB3TkZKTGZCeVRaN3ViRGgvSFkrVkUrWlpieTBoK0EzSk90T3NRUE9VUFpX?=
 =?utf-8?B?MTh6WTJnQVp1VXFmd0ZxMEsyRnd3QzlHelI4aEhJQWY3MmU2TVJvOHAwTStp?=
 =?utf-8?B?TkdCclcyTk1ySEhrUmhTYkROOFlJWmNJMDlHUlBzRHA3b0FOcW51d00rT3Vz?=
 =?utf-8?B?UEN0RmhNOCtIUFIvTVUyb1FDMWxFS0JIdU92bFgxa3lDZDBwcW8wdzRERmNH?=
 =?utf-8?Q?go4l0FQGuTNmWqykSRsA0BBIS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5C2FB3173A8204CBBD458D368F2FC55@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aafa8e7a-60eb-4975-2b97-08dbaf68e54d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 06:08:46.1533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wMMBRSHG1q95k0PVucmVKQM0jarzbG/f8cRa4gh5hDSNfFv751dOtlFdgHvSI7hq8HBck3UiDkW+8jRarLuF7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8335
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNodWlqaW5nOg0KDQpPbiBGcmksIDIwMjMtMDYtMTYgYXQgMTU6MzYgKzA4MDAsIFNodWlq
aW5nIExpIHdyb3RlOg0KPiBBZGQgdGhlIGNvbXBhdGlibGUgYmVjYXVzZSB0aGVyZSBhcmUgZGlm
ZmVyZW50IGRlZmluaXRpb25zIGZvciBjbWRxDQo+IHJlZ2lzdGVyIGJpdCBjb250cm9sIGluIG10
ODE4OC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNodWlqaW5nIExpIDxzaHVpamluZy5saUBtZWRp
YXRlay5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEppdGFvIFNoaSA8aml0YW8uc2hpQG1lZGlhdGVr
LmNvbT4NCj4gUmV2aWV3ZWQtYnk6IE1hdHRoaWFzIEJydWdnZXIgPG1hdHRoaWFzLmJnZ0BnbWFp
bC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMg
fCAyICsrDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jICAgICB8IDggKysr
KysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+IGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gaW5kZXggNmRjYjRiYTI0NjZjLi4w
MDcwODk0ZDAxNDggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2Rydi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5j
DQo+IEBAIC03NjQsNiArNzY0LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQN
Cj4gbXRrX2RkcF9jb21wX2R0X2lkc1tdID0gew0KPiAgCSAgLmRhdGEgPSAodm9pZCAqKU1US19E
U0kgfSwNCj4gIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4Ni1kc2kiLA0KPiAgCSAg
LmRhdGEgPSAodm9pZCAqKU1US19EU0kgfSwNCj4gKwl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVr
LG10ODE4OC1kc2kiLA0KPiArCSAgLmRhdGEgPSAodm9pZCAqKU1US19EU0kgfSwNCj4gIAl7IH0N
Cj4gIH07DQo+ICANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHNpLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+IGluZGV4IDdk
NTI1MDM1MTE5My4uNTAwYTMwNTQyODJkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RzaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHNpLmMNCj4gQEAgLTEyMDgsNiArMTIwOCwxMiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19k
c2lfZHJpdmVyX2RhdGENCj4gbXQ4MTg2X2RzaV9kcml2ZXJfZGF0YSA9IHsNCj4gIAkuaGFzX3Np
emVfY3RsID0gdHJ1ZSwNCj4gIH07DQo+ICANCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Rz
aV9kcml2ZXJfZGF0YSBtdDgxODhfZHNpX2RyaXZlcl9kYXRhID0gew0KPiArCS5yZWdfY21kcV9v
ZmYgPSAweGQwMCwNCj4gKwkuaGFzX3NoYWRvd19jdGwgPSB0cnVlLA0KPiArCS5oYXNfc2l6ZV9j
dGwgPSB0cnVlLA0KPiArfTsNCj4gKw0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2Vf
aWQgbXRrX2RzaV9vZl9tYXRjaFtdID0gew0KPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWss
bXQyNzAxLWRzaSIsDQo+ICAJICAuZGF0YSA9ICZtdDI3MDFfZHNpX2RyaXZlcl9kYXRhIH0sDQo+
IEBAIC0xMjE3LDYgKzEyMjMsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZA0K
PiBtdGtfZHNpX29mX21hdGNoW10gPSB7DQo+ICAJICAuZGF0YSA9ICZtdDgxODNfZHNpX2RyaXZl
cl9kYXRhIH0sDQo+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODYtZHNpIiwNCj4g
IAkgIC5kYXRhID0gJm10ODE4Nl9kc2lfZHJpdmVyX2RhdGEgfSwNCj4gKwl7IC5jb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10ODE4OC1kc2kiLA0KPiArCSAgLmRhdGEgPSAmbXQ4MTg4X2RzaV9kcml2
ZXJfZGF0YSB9LA0KDQptdDgxODhfZHNpX2RyaXZlcl9kYXRhIGlzIGlkZW50aWNhbCB0byBtdDgx
ODZfZHNpX2RyaXZlcl9kYXRhLCBzbyB1c2UNCm10ODE4Nl9kc2lfZHJpdmVyX2RhdGEgYW5kIGRy
b3AgbXQ4MTg4X2RzaV9kcml2ZXJfZGF0YS4NCg0KUmVnYXJkcywNCkNLDQoNCj4gIAl7IH0sDQo+
ICB9Ow0KPiAgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgbXRrX2RzaV9vZl9tYXRjaCk7DQo=

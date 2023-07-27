Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C56076440D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 04:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjG0C4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 22:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjG0C4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 22:56:00 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDCA2717
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:55:55 -0700 (PDT)
X-UUID: 1679360e2c2911ee9cb5633481061a41-20230727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=dsTN0R8SbGzzDUlVCqN6VBNZq+w+yOHb4d6xocKQk4A=;
        b=IDKtxGahju2GIxYQyFjKGutHYBhgCgCkCuqSOm76leZDUHCPi9uRfFbleTSNi3VPAAgw3/VwRfOEIT+wvjVjd4StnHHY3OrzjapBpCAvfAoy+VaPXPe64y65wqOg3p0b8eSKsjagBpCviw2GOTVNWTJtvjbjg8voVKHoxtLbkio=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:7bb4bdd2-1629-42b2-be9b-c3042b205f09,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:e7562a7,CLOUDID:912dd6b3-a467-4aa9-9e04-f584452e3794,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 1679360e2c2911ee9cb5633481061a41-20230727
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1113849364; Thu, 27 Jul 2023 10:55:47 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 27 Jul 2023 10:55:46 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 27 Jul 2023 10:55:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HARNUuofRg0r2ZXHrLWEmZdfXp132zPoNXf+gvpy1YD9kIZycGtafbWTaTcrsl99DyEGiVyJey+laH4mHzVLzrFwAOMt2tS5+M+MOUZhnIA9UUHHYMOjtIvNbvkUAjJjc5KFIuwOZLwhDRo2VZf0L6NUBabb6DnmKOPakrwT3irwZovKcvUkKdGvvIlw4Gp3DsA+0yclDVSy43EBtv/0Dg8beAwgLid304/EpF74pLGgmGyvnuuv2FNOChfOLd7uKlG/oTe4cpSe1JOxDu5ZYkCysO9gG5zgInakBYmpV8z98c+uVEMsJN9hjyO8s3NL4BE7M9uRlvEgN2KJ8wYGBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsTN0R8SbGzzDUlVCqN6VBNZq+w+yOHb4d6xocKQk4A=;
 b=iwtLkZfA/qeRqqLqpB0/ZkSfu27Vb6Zy1OFnkLKdUanJMAQtun9QiFrIGh13OSbukHkTiqMveRHi9hNZQwvWg9sPGidcrTc0SDB1FNxUKMZaN0O7DR9jaBWidAcX7ETj0t7SILj1pBp3KxQM5XXcvfRnbrHc8MUljEnStxb59uqzRjk2ZbLO+Fph3pqzZ3xvEJqu9Szp05BHKh5n9zOl5c5uzNn+IxVkOUICBCynvPFV727o85Y/zgjzOLEN4wcJN76DUHeUQZ+iAsZTpduaYcwso4tCEGJKAvazxftD/pAwLAy3A98LmZg5gl7R7uNjV3A2eUa3evlUvCwYiydTfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsTN0R8SbGzzDUlVCqN6VBNZq+w+yOHb4d6xocKQk4A=;
 b=hYOvyRaIPRi9hzsNDoffCQidllWOQsBxIE9DETDG7+tSWN0E50RXO/vsjkjzDbnM5++7TJSI43w4yVHwRM2NEe7i1vQsQ9qosmvaAIMSb2gbEsTsQkPNQLCo00H+Tnit7mAahf9MBBmKmsjJNdHHTjiXiaQCNQFTztQ/BlhNkXQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYUPR03MB7137.apcprd03.prod.outlook.com (2603:1096:400:344::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 02:55:44 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 02:55:44 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "ehristev@collabora.com" <ehristev@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH v7 11/11] drm/mediatek: dp: Don't register HPD interrupt
 handler for eDP case
Thread-Topic: [PATCH v7 11/11] drm/mediatek: dp: Don't register HPD interrupt
 handler for eDP case
Thread-Index: AQHZvspvQsZUxxhI9EuvUIpaqHF3tK/M7hWA
Date:   Thu, 27 Jul 2023 02:55:44 +0000
Message-ID: <a3c2c09a881055c43b2fb5394fc99b0372bb3746.camel@mediatek.com>
References: <20230725073234.55892-1-angelogioacchino.delregno@collabora.com>
         <20230725073234.55892-12-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230725073234.55892-12-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYUPR03MB7137:EE_
x-ms-office365-filtering-correlation-id: be978c3e-b393-4908-6a3a-08db8e4cf885
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ErP1hSOxHwEDM3J6c1V7tNFt3Tp3IR9MLOJjeGsMU0Bz2Z+wATEy0q83FmsnVTvESpE8jpYU8jEkmIOlvwYngVXnmjNji/nhbXNtyfCWvQVjVBkM6PFDXfEJbXyxINSqqjJWKJLhWSyO4NOelnX382UZ4wUj4y6vaDHieZM/mDBhJoveiipqi5kTicPkP3CSotMUdgi4y0BenoPtPefRUK4H/246WL8pioycXNQDYq2MLgzaAeMbcJAiem7vgcOn7xAMz048iFGuHdFXiouf7mW83OGdsVDEPCxSB7J95eQhC2MTvZjtnPHPnV1BFizeo/XLA+JFTnHrtCir/rM0h2TolOkG1Nk2FX8dYszI6JUU1Ugp4oj+0WeK3os1K2Kw4obX+mthmRzViRx8UB8zgDGC67piwdTccO1LXQl1aWpHhthA8bvA+d9QYUgBYXlfLJhdQNa+B04sCzWu5mDFk+YsaGNFSivTxz+fmRQczDR34KhIae/TEHHUMUnKlEF5Mz7OrN/sT2zbJHiz/vialJ9js7wVbIP2Rzjd6+3jBm9RTjBEw4zfcGBWaYFrzrDhH5l+9O58C+qHB0qpc8rUPZUIelJZtpG0JU1gFcWntXIuKFY183AWkg5Nq30tHurkCQt6NeGuJxaynMtJxAg/Hn0DVo4Az4CtL1Px4/1eToc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199021)(54906003)(110136005)(6512007)(26005)(6506007)(122000001)(2616005)(478600001)(85182001)(38100700002)(36756003)(83380400001)(6486002)(71200400001)(316002)(66446008)(66556008)(86362001)(64756008)(76116006)(4326008)(66946007)(66476007)(186003)(41300700001)(5660300002)(7416002)(8936002)(8676002)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHpiL2FEVWFCYWR6bXJ2NGhLdWxXUk1rQmMyWHROYlZjK0JMdXNWUGtQSEEw?=
 =?utf-8?B?RnJ6ckZ0V3JsV0g5dzRhUjBHaEZnQi95LzRjUlhYVjlaVkVWZmJsM1JRUmdH?=
 =?utf-8?B?Ry9xT2ZuRDlZV3A3dTRpWC84Kzg0bHlxK1RDVEJoQ3hzd3JyT3FZL0JRTTFH?=
 =?utf-8?B?aUlMd0l5L3hwM3NSWlZnU0N4YUVGT3V4K014d1gvbXRGMTZHb1Ria0tsNm8v?=
 =?utf-8?B?TmtybnRwV0pXNWhPckczbHg2azdEdjRLSkVnVTdHYUNKL3dRMDFFUHZHRDZJ?=
 =?utf-8?B?WXBlNFUzMHdvaUp1TDNBK0kyV0o2SGdXR3JWUUpRUXg2MEZoSE9Jb2UwMlRK?=
 =?utf-8?B?SHB5Y0dsNElWYVkwYXUxYThaVmpxQTI1bStPUFh5RFYvc2cyNHU2eW5yQ1FY?=
 =?utf-8?B?RmNTaGQ2NjIzM3Y0dzN5L0tCa2pLZVpxR0RVbW0zRW9oanpwT1NlZWdESmNZ?=
 =?utf-8?B?elJ1K2gvY0dyejRkRGdSYVJTZ3dQeGFVUUVlZjdaZDEvUzVsRFhHa1pvUkcy?=
 =?utf-8?B?eTIwaXZNczJJdWNCOStLdWZwS04yZ1VmdFdCY2laVnlCejhDTVpnV201bUg0?=
 =?utf-8?B?L2dRQktmTEhvTSt0dnd6cDJuNnpDWllwWUo5RVJoZCtxMGpudXA1d0g4MUlU?=
 =?utf-8?B?djBzUEZpNjFuSDJML0R6UC9kend1cEtoZ0JueHR4akY3alhPa1E5RVB0U0ZM?=
 =?utf-8?B?NUZvekJ4SGVwNVBVcGw2YS9ZbzVuMGFBWmtENzJtVVQ0enVEazlyVkg3OTl2?=
 =?utf-8?B?MFUwSkVPQmpjdHcrUDd5MVFKMFVadWU3dyt0N0ZKMlV3UmY3ZE9RSUhoTWlu?=
 =?utf-8?B?SkVIcEJwNTliOVVGejBUMXVOVEt4enBETDVWY2lXN1o4WEFZYXBXRmRwb0No?=
 =?utf-8?B?Z0RUcWFUejN3TVVwWFRXd1RBTUdId0pMMyttQzZiY0t6OEFBbUJTMnR6ZFph?=
 =?utf-8?B?Y2E5QU5rbmdBU2lyRjRPeHVVVGZGalBLVGNtenhLMVp0T1VRazQza3dtYkpu?=
 =?utf-8?B?eEc0L0k0dGZtS1ordDIrckxSejh5RnpINS9xYTZuQTBIQUt2NXdDYkRwN1Nn?=
 =?utf-8?B?OEtmdGcyaUNsVS8yNzQ0YTh6S3RKaGxBcE0zM2owQXl5Y0x0NG15SnJ5MGhN?=
 =?utf-8?B?YlplaVgyZFdnWllTN2NJVW5qNG1iVyt2R1pwNnBnN3AwdTZGRTJpRHlPNjhM?=
 =?utf-8?B?MDNFbXo3WXpGZkgwYlA0TDcxV1o1RVJBQkR3Qzk0TmMrbkJndVNrVHFrMEx3?=
 =?utf-8?B?VDNVQlJDdVZLZGwvSWdaelh4WXRjSFl6Y2t5WjdvUmdLZ25maHpDRTJPY2RT?=
 =?utf-8?B?UGFZdnIvTktKall2VVBWMjE1V2tyRmh1OHhJSTV1bXVUS09vMW82bjFTcTVJ?=
 =?utf-8?B?b0s1d3JCT2xBQm5HTEtWMU9tM2VYVUkrc2d6S0RnNDBKUmdydC9KVERRMzZI?=
 =?utf-8?B?TG5Nbm9NSDFDUGpaTkh4c1VlT01YWTR6ZHI1eXc2RzVGY1pkY1haeElScjh4?=
 =?utf-8?B?YmZQcW9DUzhKSVBCZkhaUnFzVEhxQTlQeUpuSjBiWkxiSzhSWXBNUGRuakZX?=
 =?utf-8?B?L3FBUjliT2E0NUVaMUMzNXRFOFdqQUQ5QXozTEtRK2NOaElUUXF3Wjc4SjI2?=
 =?utf-8?B?cnZTb2NERzdtT3dPamFwQS9PLzc1bnlFQzh2VlZ0TXFxZWduMkNGaGJ0aFl4?=
 =?utf-8?B?RUxUcVJxa0dzcHU0aFpScURRMVJMaGdUaFZ0ZUVDa0VEOUZsb0d4Qm5qYkhs?=
 =?utf-8?B?MHhNMzZhTStoSDZwc05uQzhjZ3RIM1hSWTJobkN2ZURGTXd5ZExKSlR2c08w?=
 =?utf-8?B?Wk5tUEZFSEJlWWdQK1BCZW1kZ2xMbGpOOHRNZVNVK1lhaXhScktQMFJqYUo4?=
 =?utf-8?B?dFFMaWtHTXd1NHV3aEVqMG1qbERvd0t3MVBMNXNNUlZHdTFROGpLZHI3YzRi?=
 =?utf-8?B?OE43a1RSQlBXMGk2bzAxdm81UkJ2NC9EbE40ekpveDk3Qm5nTXUrOHZqUExu?=
 =?utf-8?B?cHh3eHBPeExwR1p1T0RCUkFQNVVnaGVSVFFwaFE0Rjd3N1RxNGxZbU9ZbG9k?=
 =?utf-8?B?M2dTejZ0em1MdFl1cjRPZks3cDZDWW1lTUJEMWZEaWpYQ0hRL3hYaTBDSkpG?=
 =?utf-8?B?K09SaTJDY0ZsUzRyYXRyT0REMXFEQXJuZVZtU3l2RGhBK1BNait5RzZGLzl4?=
 =?utf-8?B?cXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77DD9886A9A84448B3D1B23E87E72F76@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be978c3e-b393-4908-6a3a-08db8e4cf885
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 02:55:44.0769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JENd8RTwlm9P7trx1HpLcrWVKElTFPBaymJUKtRmxtdJ+9x8L7K6jpUL2cvlyr8Bhuk64c6EnEgf1VvjCGLcfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7137
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gVHVlLCAyMDIzLTA3LTI1IGF0IDA5OjMyICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gVGhlIGludGVycnVwdCBoYW5kbGVyIGZvciBI
UEQgaXMgdXNlZnVsIG9ubHkgaWYgYSBkaXNwbGF5IGlzIGFjdHVhbGx5DQo+IHN1cHBvc2VkIHRv
IGJlIGhvdHBsdWdnYWJsZSwgYXMgdGhhdCBtYW5hZ2VzIHRoZSBtYWNoaW5lcnkgdG8gcGVyZm9y
bQ0KPiBjYWJsZSAodW4pcGx1ZyBkZXRlY3Rpb24sIGRlYm91bmNpbmcgYW5kIHNldHVwIGZvciBy
ZS10cmFpbmluZy4NCj4gDQo+IFNpbmNlIGVEUCBwYW5lbHMgYXJlIG5vdCBzdXBwb3NlZCB0byBi
ZSBob3RwbHVnZ2FibGUgd2UgY2FuIGF2b2lkDQo+IHVzaW5nIHRoZSBIUEQgaW50ZXJydXB0cyBh
bHRvZ2V0aGVyIGFuZCByZWx5IG9uIEhQRCBwb2xsaW5nIG9ubHkNCj4gZm9yIHRoZSBzdXNwZW5k
L3Jlc3VtZSBjYXNlLCBzYXZpbmcgdXMgc29tZSBzcGlubG9ja2luZyBhY3Rpb24gYW5kDQo+IHRo
ZSBvdmVyaGVhZCBvZiBpbnRlcnJ1cHRzIGZpcmluZyBhdCBldmVyeSBzdXNwZW5kL3Jlc3VtZSBj
eWNsZSwNCj4gYWNoaWV2aW5nIGEgZmFzdGVyIChldmVuIGlmIGp1c3Qgc2xpZ2h0bHkpIGRpc3Bs
YXkgcmVzdW1lLg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiBhbmdl
bG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IFRlc3RlZC1ieTogQ2hlbi1Z
dSBUc2FpIDx3ZW5zdEBjaHJvbWl1bS5vcmc+DQo+IFJldmlld2VkLWJ5OiBBbGV4YW5kcmUgTWVy
Z25hdCA8YW1lcmduYXRAYmF5bGlicmUuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHAuYyB8IDczICsrKysrKysrKysrKysrKysrKystLS0tLS0tLQ0KPiAtLS0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgNDYgaW5zZXJ0aW9ucygrKSwgMjcgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jDQo+IGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jDQo+IGluZGV4IGJhNzUwZDQ2M2U0MS4u
YzA2ZmNjNzMxOGU3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RwLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jDQo+IEBAIC0y
MTgyLDkgKzIxODIsMTEgQEAgc3RhdGljIGludCBtdGtfZHBfYnJpZGdlX2F0dGFjaChzdHJ1Y3QN
Cj4gZHJtX2JyaWRnZSAqYnJpZGdlLA0KPiAgDQo+ICAJbXRrX2RwLT5kcm1fZGV2ID0gYnJpZGdl
LT5kZXY7DQo+ICANCj4gLQlpcnFfY2xlYXJfc3RhdHVzX2ZsYWdzKG10a19kcC0+aXJxLCBJUlFf
Tk9BVVRPRU4pOw0KPiAtCWVuYWJsZV9pcnEobXRrX2RwLT5pcnEpOw0KPiAtCW10a19kcF9od2ly
cV9lbmFibGUobXRrX2RwLCB0cnVlKTsNCj4gKwlpZiAobXRrX2RwLT5icmlkZ2UudHlwZSAhPSBE
Uk1fTU9ERV9DT05ORUNUT1JfZURQKSB7DQo+ICsJCWlycV9jbGVhcl9zdGF0dXNfZmxhZ3MobXRr
X2RwLT5pcnEsIElSUV9OT0FVVE9FTik7DQo+ICsJCWVuYWJsZV9pcnEobXRrX2RwLT5pcnEpOw0K
PiArCQltdGtfZHBfaHdpcnFfZW5hYmxlKG10a19kcCwgdHJ1ZSk7DQo+ICsJfQ0KPiAgDQo+ICAJ
cmV0dXJuIDA7DQo+ICANCj4gQEAgLTIxOTksOCArMjIwMSwxMCBAQCBzdGF0aWMgdm9pZCBtdGtf
ZHBfYnJpZGdlX2RldGFjaChzdHJ1Y3QNCj4gZHJtX2JyaWRnZSAqYnJpZGdlKQ0KPiAgew0KPiAg
CXN0cnVjdCBtdGtfZHAgKm10a19kcCA9IG10a19kcF9mcm9tX2JyaWRnZShicmlkZ2UpOw0KPiAg
DQo+IC0JbXRrX2RwX2h3aXJxX2VuYWJsZShtdGtfZHAsIGZhbHNlKTsNCj4gLQlkaXNhYmxlX2ly
cShtdGtfZHAtPmlycSk7DQo+ICsJaWYgKG10a19kcC0+YnJpZGdlLnR5cGUgIT0gRFJNX01PREVf
Q09OTkVDVE9SX2VEUCkgew0KPiArCQltdGtfZHBfaHdpcnFfZW5hYmxlKG10a19kcCwgZmFsc2Up
Ow0KPiArCQlkaXNhYmxlX2lycShtdGtfZHAtPmlycSk7DQo+ICsJfQ0KPiAgCW10a19kcC0+ZHJt
X2RldiA9IE5VTEw7DQo+ICAJbXRrX2RwX3Bvd2Vyb2ZmKG10a19kcCk7DQo+ICAJZHJtX2RwX2F1
eF91bnJlZ2lzdGVyKCZtdGtfZHAtPmF1eCk7DQo+IEBAIC0yNTc5LDMyICsyNTgzLDQ0IEBAIHN0
YXRpYyBpbnQgbXRrX2RwX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ICAJbXRrX2RwLT5kZXYgPSBkZXY7DQo+ICAJbXRrX2RwLT5kYXRhID0gKHN0cnVjdCBtdGtfZHBf
ZGF0YQ0KPiAqKW9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YShkZXYpOw0KPiAgDQo+IC0JbXRrX2Rw
LT5pcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDApOw0KPiAtCWlmIChtdGtfZHAtPmlycSA8
IDApDQo+IC0JCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgbXRrX2RwLT5pcnEsDQo+IC0JCQkJ
ICAgICAiZmFpbGVkIHRvIHJlcXVlc3QgZHAgaXJxDQo+IHJlc291cmNlXG4iKTsNCj4gLQ0KPiAg
CXJldCA9IG10a19kcF9kdF9wYXJzZShtdGtfZHAsIHBkZXYpOw0KPiAgCWlmIChyZXQpDQo+ICAJ
CXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiRmFpbGVkIHRvIHBhcnNlIGR0XG4iKTsN
Cj4gIA0KPiArCS8qDQo+ICsJICogUmVxdWVzdCB0aGUgaW50ZXJydXB0IGFuZCBpbnN0YWxsIHNl
cnZpY2Ugcm91dGluZSBvbmx5IGlmIHdlDQo+IGFyZQ0KPiArCSAqIG9uIGZ1bGwgRGlzcGxheVBv
cnQuDQo+ICsJICogRm9yIGVEUCwgcG9sbGluZyB0aGUgSFBEIGluc3RlYWQgaXMgbW9yZSBjb252
ZW5pZW50IGJlY2F1c2UNCj4gd2UNCj4gKwkgKiBkb24ndCBleHBlY3QgYW55ICh1bilwbHVnIGV2
ZW50cyBkdXJpbmcgcnVudGltZSwgaGVuY2Ugd2UNCj4gY2FuDQo+ICsJICogYXZvaWQgc29tZSBs
b2NraW5nLg0KPiArCSAqLw0KPiArCWlmIChtdGtfZHAtPmRhdGEtPmJyaWRnZV90eXBlICE9IERS
TV9NT0RFX0NPTk5FQ1RPUl9lRFApIHsNCj4gKwkJbXRrX2RwLT5pcnEgPSBwbGF0Zm9ybV9nZXRf
aXJxKHBkZXYsIDApOw0KPiArCQlpZiAobXRrX2RwLT5pcnEgPCAwKQ0KPiArCQkJcmV0dXJuIGRl
dl9lcnJfcHJvYmUoZGV2LCBtdGtfZHAtPmlycSwNCj4gKwkJCQkJICAgICAiZmFpbGVkIHRvIHJl
cXVlc3QgZHAgaXJxDQo+IHJlc291cmNlXG4iKTsNCj4gKw0KPiArCQlzcGluX2xvY2tfaW5pdCgm
bXRrX2RwLT5pcnFfdGhyZWFkX2xvY2spOw0KPiArDQo+ICsJCWlycV9zZXRfc3RhdHVzX2ZsYWdz
KG10a19kcC0+aXJxLCBJUlFfTk9BVVRPRU4pOw0KPiArCQlyZXQgPSBkZXZtX3JlcXVlc3RfdGhy
ZWFkZWRfaXJxKGRldiwgbXRrX2RwLT5pcnEsDQo+IG10a19kcF9ocGRfZXZlbnQsDQo+ICsJCQkJ
CQltdGtfZHBfaHBkX2V2ZW50X3RocmVhZA0KPiAsDQo+ICsJCQkJCQlJUlFfVFlQRV9MRVZFTF9I
SUdILA0KPiBkZXZfbmFtZShkZXYpLA0KPiArCQkJCQkJbXRrX2RwKTsNCj4gKwkJaWYgKHJldCkN
Cj4gKwkJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LA0KPiArCQkJCQkgICAgICJmYWls
ZWQgdG8gcmVxdWVzdA0KPiBtZWRpYXRlayBkcHR4IGlycVxuIik7DQo+ICsNCj4gKwkJbXRrX2Rw
LT5uZWVkX2RlYm91bmNlID0gdHJ1ZTsNCj4gKwkJdGltZXJfc2V0dXAoJm10a19kcC0+ZGVib3Vu
Y2VfdGltZXIsDQo+IG10a19kcF9kZWJvdW5jZV90aW1lciwgMCk7DQo+ICsJfQ0KPiArDQo+ICAJ
bXRrX2RwLT5hdXgubmFtZSA9ICJhdXhfbXRrX2RwIjsNCj4gIAltdGtfZHAtPmF1eC5kZXYgPSBk
ZXY7DQo+ICAJbXRrX2RwLT5hdXgudHJhbnNmZXIgPSBtdGtfZHBfYXV4X3RyYW5zZmVyOw0KPiAg
CW10a19kcC0+YXV4LndhaXRfaHBkX2Fzc2VydGVkID0gbXRrX2RwX3dhaXRfaHBkX2Fzc2VydGVk
Ow0KPiAgCWRybV9kcF9hdXhfaW5pdCgmbXRrX2RwLT5hdXgpOw0KPiAgDQo+IC0Jc3Bpbl9sb2Nr
X2luaXQoJm10a19kcC0+aXJxX3RocmVhZF9sb2NrKTsNCj4gLQ0KPiAtCWlycV9zZXRfc3RhdHVz
X2ZsYWdzKG10a19kcC0+aXJxLCBJUlFfTk9BVVRPRU4pOw0KPiAtCXJldCA9IGRldm1fcmVxdWVz
dF90aHJlYWRlZF9pcnEoZGV2LCBtdGtfZHAtPmlycSwNCj4gbXRrX2RwX2hwZF9ldmVudCwNCj4g
LQkJCQkJbXRrX2RwX2hwZF9ldmVudF90aHJlYWQsDQo+IC0JCQkJCUlSUV9UWVBFX0xFVkVMX0hJ
R0gsDQo+IGRldl9uYW1lKGRldiksDQo+IC0JCQkJCW10a19kcCk7DQo+IC0JaWYgKHJldCkNCj4g
LQkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsDQo+IC0JCQkJICAgICAiZmFpbGVkIHRv
IHJlcXVlc3QgbWVkaWF0ZWsgZHB0eA0KPiBpcnFcbiIpOw0KPiAtDQo+ICAJcGxhdGZvcm1fc2V0
X2RydmRhdGEocGRldiwgbXRrX2RwKTsNCj4gIA0KPiAgCWlmIChtdGtfZHAtPmRhdGEtPmF1ZGlv
X3N1cHBvcnRlZCkgew0KPiBAQCAtMjYyNiw5ICsyNjQyLDYgQEAgc3RhdGljIGludCBtdGtfZHBf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gIAltdGtfZHAtPmJyaWRn
ZS5vZl9ub2RlID0gZGV2LT5vZl9ub2RlOw0KPiAgCW10a19kcC0+YnJpZGdlLnR5cGUgPSBtdGtf
ZHAtPmRhdGEtPmJyaWRnZV90eXBlOw0KPiAgDQo+IC0JbXRrX2RwLT5uZWVkX2RlYm91bmNlID0g
dHJ1ZTsNCj4gLQl0aW1lcl9zZXR1cCgmbXRrX2RwLT5kZWJvdW5jZV90aW1lciwgbXRrX2RwX2Rl
Ym91bmNlX3RpbWVyLCAwKTsNCj4gLQ0KPiAgCWlmIChtdGtfZHAtPmJyaWRnZS50eXBlID09IERS
TV9NT0RFX0NPTk5FQ1RPUl9lRFApIHsNCj4gIAkJLyoNCj4gIAkJICogU2V0IHRoZSBkYXRhIGxh
bmVzIHRvIGlkbGUgaW4gY2FzZSB0aGUgYm9vdGxvYWRlcg0KPiBkaWRuJ3QNCj4gQEAgLTI2Mzks
NiArMjY1Miw5IEBAIHN0YXRpYyBpbnQgbXRrX2RwX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UNCj4gKnBkZXYpDQo+ICAJCW10a19kcF9pbml0aWFsaXplX2F1eF9zZXR0aW5ncyhtdGtfZHAp
Ow0KPiAgCQltdGtfZHBfcG93ZXJfZW5hYmxlKG10a19kcCk7DQo+ICANCj4gKwkJLyogRGlzYWJs
ZSBIVyBpbnRlcnJ1cHRzOiB3ZSBkb24ndCBuZWVkIGFueSBmb3IgZURQICovDQo+ICsJCW10a19k
cF9od2lycV9lbmFibGUobXRrX2RwLCBmYWxzZSk7DQo+ICsNCj4gIAkJLyoNCj4gIAkJICogUG93
ZXIgb24gdGhlIEFVWCB0byBhbGxvdyByZWFkaW5nIHRoZSBFRElEIGZyb20gYXV4LQ0KPiBidXM6
DQo+ICAJCSAqIHBsZWFzZSBub3RlIHRoYXQgaXQgaXMgbmVjZXNzYXJ5IHRvIGNhbGwgcG93ZXIg
b2ZmDQo+IGluIHRoZQ0KPiBAQCAtMjY4NCw3ICsyNzAwLDggQEAgc3RhdGljIGludCBtdGtfZHBf
cmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICANCj4gIAlwbV9ydW50
aW1lX3B1dCgmcGRldi0+ZGV2KTsNCj4gIAlwbV9ydW50aW1lX2Rpc2FibGUoJnBkZXYtPmRldik7
DQo+IC0JZGVsX3RpbWVyX3N5bmMoJm10a19kcC0+ZGVib3VuY2VfdGltZXIpOw0KPiArCWlmICht
dGtfZHAtPmRhdGEtPmJyaWRnZV90eXBlICE9IERSTV9NT0RFX0NPTk5FQ1RPUl9lRFApDQo+ICsJ
CWRlbF90aW1lcl9zeW5jKCZtdGtfZHAtPmRlYm91bmNlX3RpbWVyKTsNCj4gIAlwbGF0Zm9ybV9k
ZXZpY2VfdW5yZWdpc3RlcihtdGtfZHAtPnBoeV9kZXYpOw0KPiAgCWlmIChtdGtfZHAtPmF1ZGlv
X3BkZXYpDQo+ICAJCXBsYXRmb3JtX2RldmljZV91bnJlZ2lzdGVyKG10a19kcC0+YXVkaW9fcGRl
dik7DQo+IEBAIC0yNjk4LDcgKzI3MTUsOCBAQCBzdGF0aWMgaW50IG10a19kcF9zdXNwZW5kKHN0
cnVjdCBkZXZpY2UgKmRldikNCj4gIAlzdHJ1Y3QgbXRrX2RwICptdGtfZHAgPSBkZXZfZ2V0X2Ry
dmRhdGEoZGV2KTsNCj4gIA0KPiAgCW10a19kcF9wb3dlcl9kaXNhYmxlKG10a19kcCk7DQo+IC0J
bXRrX2RwX2h3aXJxX2VuYWJsZShtdGtfZHAsIGZhbHNlKTsNCj4gKwlpZiAobXRrX2RwLT5icmlk
Z2UudHlwZSAhPSBEUk1fTU9ERV9DT05ORUNUT1JfZURQKQ0KPiArCQltdGtfZHBfaHdpcnFfZW5h
YmxlKG10a19kcCwgZmFsc2UpOw0KPiAgCXBtX3J1bnRpbWVfcHV0X3N5bmMoZGV2KTsNCj4gIA0K
PiAgCXJldHVybiAwOw0KPiBAQCAtMjcxMCw3ICsyNzI4LDggQEAgc3RhdGljIGludCBtdGtfZHBf
cmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIA0KPiAgCXBtX3J1bnRpbWVfZ2V0X3N5bmMo
ZGV2KTsNCj4gIAltdGtfZHBfaW5pdF9wb3J0KG10a19kcCk7DQo+IC0JbXRrX2RwX2h3aXJxX2Vu
YWJsZShtdGtfZHAsIHRydWUpOw0KPiArCWlmIChtdGtfZHAtPmJyaWRnZS50eXBlICE9IERSTV9N
T0RFX0NPTk5FQ1RPUl9lRFApDQo+ICsJCW10a19kcF9od2lycV9lbmFibGUobXRrX2RwLCB0cnVl
KTsNCj4gIAltdGtfZHBfcG93ZXJfZW5hYmxlKG10a19kcCk7DQo+ICANCj4gIAlyZXR1cm4gMDsN
Cg==

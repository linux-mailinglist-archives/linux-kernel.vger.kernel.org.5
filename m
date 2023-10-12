Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D637C6735
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378026AbjJLHsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343626AbjJLHsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:48:21 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131B9B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:48:19 -0700 (PDT)
X-UUID: b388592068d311ee8051498923ad61e6-20231012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=iZNlBTyq8sMeHiSbLvxYk3MRXzWCc6BdNBaeyJKezq0=;
        b=mSpDBtr0H7G4m+HqA66VU6MQaLVtenTZHqhNvgwSdypgRg+q1ztlLz8xk5CSY1l8XMmrsR/KCNxontxDyJOPwSkO2tRoYGNcNyUAiTw4jP/RkXLVieRCdwX+O9kFJAAoJdW/vFg8By79/qp6w4HQFhR5w5idBOETsY1ursBhzj4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:01873dfd-6b6c-405d-91f5-4fec25e307a9,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:104b09c4-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: b388592068d311ee8051498923ad61e6-20231012
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1049897455; Thu, 12 Oct 2023 15:48:15 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 12 Oct 2023 15:48:15 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 12 Oct 2023 15:48:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZdZe5UMmyOnwO+UIhYwSiNmeAtZizI8a1SJftSH4XCGk/dNGhUowdNesOlP2vXO4yszC03kvtiZ4O6RJzqEBucVe5HjLfOxL6XOdbQApUO7bbHt/sOTlvOBhP31cXIGrGa1lgyfWP43HJW8leQo73n/JtZdB4Mil6dSVs6fLq5QRJ3RBTMrZGttxj1iv0F36ZJ6KLT7b2VyaZivjEPqZKJLUXsKmBYqB+cwLnIWi7Q+l4E7kFaK1OcKyMJ0YMQjVBUFutsY15Cif0MUfxec5nneHuS7LxrEtE4XPszFTv/lmWFdv5yo5tcVHowglsitsaJ6/LolfUC+b8OowSMlxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZNlBTyq8sMeHiSbLvxYk3MRXzWCc6BdNBaeyJKezq0=;
 b=MSSOseU4sbfG6d+N5kHpCDiOjdGwf53rxMXzs2fEGwGhQ5mVrlRgBYqMgw88utp57rTF3AjPEnL3q43si1p+ikE5Q6SUSFNn3Q7dk3rGkW4ON33mkk1queCb1nLky7xzm6fmWJ+u2vskm1BMRLE8nGLkNAtHDilqVTDrI4pSoTuP8kNEHQGPt/v22n9sp0o1bljWrSJbw00YymyqMoWzhe+s/TGLg1ZfEV/1GKGyOr//LQrfWQ7vAenp5feH5tRBl18qtmEGux+s4kpvQpHgoaT/VtwuiuxQ8rUmum/Y/kHzktuTTM/QKCMsbm8z8IedF3GHRhyZLCjqWf4xxgJgTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZNlBTyq8sMeHiSbLvxYk3MRXzWCc6BdNBaeyJKezq0=;
 b=cgLmRMqE8Kz0sQxuV6JN/IB1ALijpouavYmAb9gPpmAtbMZ62tAFJLje7tE+DfbN4Gz1MhUpk3bTCwwKYCqor8WwPBV1vY4+SsWyUTc6gKEu57L7yTY07Kn81jqGCkWe9qehQijDVUjMyDD7zuAJl6vunwR5/eJ79LMl4IFa+HY=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TY0PR03MB6428.apcprd03.prod.outlook.com (2603:1096:400:1ac::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Thu, 12 Oct
 2023 07:48:12 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%7]) with mapi id 15.20.6863.041; Thu, 12 Oct 2023
 07:48:12 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "ehristev@collabora.com" <ehristev@collabora.com>
Subject: Re: [PATCH v10 02/16] drm/mediatek: gamma: Reduce indentation in
 mtk_gamma_set_common()
Thread-Topic: [PATCH v10 02/16] drm/mediatek: gamma: Reduce indentation in
 mtk_gamma_set_common()
Thread-Index: AQHZxqVtRhfpsBkHhkCvZrpiCUrhX7BGM5qA
Date:   Thu, 12 Oct 2023 07:48:11 +0000
Message-ID: <caebb784b33016037ae6ff4fc3d629ddb9922a8a.camel@mediatek.com>
References: <20230804072850.89365-1-angelogioacchino.delregno@collabora.com>
         <20230804072850.89365-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230804072850.89365-3-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TY0PR03MB6428:EE_
x-ms-office365-filtering-correlation-id: 851f2160-78dc-4b91-edef-08dbcaf795b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gWXHlrBvD+HU1mi76MgO7vbZpa5fH1MA6J6P2wCrNLSmBNQZknJS+gxruWAJrmq5PYKihOzBH8TYtpY0PXeYXcjcHrYFnfug8pvLlQF0OHN3ReRWk7z3cK56cKursWXIjND4MXzDuTiSAsrRzJsUt2311WA7Cerx6gLEASGi5ztJRMVRuH7z9sK2wsRcJno0PACxpNdnRZPCHvVKlfCBUtQYnM8pxt8SgyAm2xJxf0fG/2aOVTtEejD9O8xebI6xGbTqCAxdPt2JuH7KTaT/11lEtSorzEMPoVIKjKvBp5fGVYFmEtYdjdxtWz5nHtYpViw52xGuh3XSSe1w1qGKgWn6hiGCl2UHZ5pNYDfjzOQx0ciZH9A0zFD6M0Tb8HVfWmWAo8yHmG0GwvSFjZwdDdU2JQ0nUY9FTmTD/37HRaGEhKW7jw4uFFnNiFK4LfpYAPWvksdCmVMe9BhNSovIgXWx1okXh2ZDKo24xcQ9ypDnr7a7YMTgrSz2lhzZNJ3hvbRXvdaFp4RFyl4NWEFj0gm5Gq/1+eAgD294JlWsAkJ7itAFLEQilrjx02BHzpF8HVGXXaF8tgknlrDgbPwBr7MV7C2JIV6k8hUHG5aPICNMI8GxsTe2bUbZkEJp2hheOzTgvVf8o2qLuoC58viKE3OqRa7Xnn59TPcqiGGSl9s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(71200400001)(6512007)(85182001)(6486002)(26005)(36756003)(54906003)(316002)(6506007)(38100700002)(122000001)(2616005)(8936002)(478600001)(4326008)(8676002)(66556008)(41300700001)(64756008)(66446008)(76116006)(66476007)(110136005)(5660300002)(66946007)(83380400001)(7416002)(2906002)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEhIKyt3Y3VOaUNKeDRzdDQrb2NpMkQ1V1Zkbm9EUGNOVERldlQzQ3NrUkFj?=
 =?utf-8?B?bU1mSEs4eDJoVHhqZnFnR0prYkpwNDhSTHYyRnFUUGlkbzlOelV4ZVRRWjZs?=
 =?utf-8?B?V2xGNjlmU28rcFN2ZnBNTDFzazJXemhmOXpYT016WjRJellKUVVzT09IOEIr?=
 =?utf-8?B?MXM0L0lIUU0yY1BhTW43MFZsM2RwaWNRcnBmM3NLdUM1bmRyZFVvMzN4Qmd6?=
 =?utf-8?B?Mlp5SnZnck52NEhJc2owbkhBVU5HdUg1TS9sYVFkL2FlenB2bGM5R05oUGdU?=
 =?utf-8?B?eVM5OVhFSEVxbWNua0wybzBuL1pwdnlPUDNvd0t4VDg2QXE4YmxlVVM3czRx?=
 =?utf-8?B?bkVRYWd3dmU4Um0xaEJBMUxRWXhnTkVqOWRGM2ltL0xTdTJVN1A0dXg1cStF?=
 =?utf-8?B?R0hIT1ZmZDZqVmkrWUFSTzNCZHgwelhQUGFEL0tGOFhpMHpFWkdkRFZ5Ni94?=
 =?utf-8?B?NFNHZi9uT3J6cElKUU9YcjdtSHo1WE16eTFrUkFEemcxUXlrV3FhdTlSUE5h?=
 =?utf-8?B?T0tIbi9GZW1SclY4cldKY01FUGVPUHVROXU1LzY2QUpkc1JZR0ErcVNKWm9q?=
 =?utf-8?B?dUxhYlh4NHp0N1VtRnVKVkMzT09qY1JhM2wrSzA0bUN1SEVINWtLTld6M3ln?=
 =?utf-8?B?cTdtV2VRZ1ExSDlQMGVnK2FyMG5PdXZKVTVEMDUzZElVOEZGY2ozNVhvM3VW?=
 =?utf-8?B?cERhc3FycHJZYnJtR1BVZzlOQWlRZzNkWU1KK1dpMDlnYWVLWHJPZjhiWkxv?=
 =?utf-8?B?WEJaUkxCVTc0YmRQc3JJNFlmNjZKZjFFVWw4ZndEZVo2SlNNOWVUTUlQNS9S?=
 =?utf-8?B?MWRicCttMjR1cE0yTENLSGNoWjdRZXA3M0x0cjh4SWxac3NZakhjYko0U3ps?=
 =?utf-8?B?M2pTb1JuKzZ3ZG9RcVI1M3BpN1dTNE03aDI5UXJabWs5eWdMUG1FNWEwbkpE?=
 =?utf-8?B?d2V6WXhueHE0d282OEhRTHZSZjhIV1gwdTkwWUhHYVhqOWg2SDFVUEZYQUV6?=
 =?utf-8?B?M2pUOStnek9NaFVtN1dQdTBTZDd2c2FlalFOS1Y0djZIVVZDVVBWanV2c0Vx?=
 =?utf-8?B?b1RIL1J6bXZDRWphdWNSYS9UczMvT3VmaS9UUmtSRUgya3dqQlQ5ZmVkZ1lX?=
 =?utf-8?B?T2xnR3dqVkRYOU5mZ1pRS2RtaUt5b2JEQjllZEpaMmFYN2h2WTR5Y3lnajZY?=
 =?utf-8?B?K05ya2tkWG01dFA2NXJXNElVRysxeldNOXN5cDU4TEZhQmFXYlRKczNGTHFt?=
 =?utf-8?B?WGVPTDFpSHVjcVVjRkpnNTFnWnlNdjgwVEVFcStqT3ZHOE5tVVZlV1VVMWtW?=
 =?utf-8?B?TmNWQ2VTRHAzYllCZVhORFFGQ3NLWXIxVDFwQmVxUDVGTzNka3dUSGYrZENr?=
 =?utf-8?B?NllSeGIxKzFSSTUyUzhyaVF3SkVqWkV3ekpTN3Y3S0l2cE9BSlhuZEV4cGcz?=
 =?utf-8?B?ek9vN1BXcDY5Vy9mYnR3Qm5VTjc1T1ZFeEtWZXRkZGVRazNZRGVXdElWRWIy?=
 =?utf-8?B?TnR2clp5NFRGNitCWmFlWGdlOUVoU0JIMzI1TUlrRDNtdGljUksxMGlneGlk?=
 =?utf-8?B?SU9zbmk2d0t3djJGR2V3Ym9Nak9rbFhCN2NLV1I3L2xGRm5LNThra01nZ3Rp?=
 =?utf-8?B?bUk2TjBIWWVRZEhRUFh2NERDTm5OZ2xCNjJ1WDVndHNjWklzTkxQaXBZOXZv?=
 =?utf-8?B?cDJKMndoeGNSUzZEU0E2REZCbFRTcmIvdXRMMGhmdzhpaFcvN3ZTOEdxUVJZ?=
 =?utf-8?B?anpYTFFpbTNhWFUvZzJ0VUV4TkdIZWYzdEI5M2twUXhiK3hLMGtZZkJMV1Fs?=
 =?utf-8?B?THU1R0ZwaVpSSDdFSkJSNTR3RHhhWTZTbzYrdlNGYXBadjJWV0syb0JGRHR2?=
 =?utf-8?B?NjFsV1Jkejl5U1BtOVJVazkzSTRCY1FjMVJyWkxac2dqWHp2ckI0WmVwUW5n?=
 =?utf-8?B?Uy9EVkYzaTl1MjgxUkNxYzNLVFFMMFNQLzNyY2kyell4MzRTcG5HYjNnbW5H?=
 =?utf-8?B?UFlVaWtEWlVWa3UxV3U5K09BazQrVm5TQTI5NVl6ZGxGd2ZNNkZyVEMzaHVF?=
 =?utf-8?B?NC9Eb3V6ZG5yNnpnYjNiS0FqK1VkMVVVZlZnd0luK0lMdlVYVzl3ODdYeGdu?=
 =?utf-8?B?dDd5Q2VvVjNwZXVCNnlKM3pxUDY0QUUxL2h0aHZFd21FYk90VDkrUGRvWjh0?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49503CF7A27C4644A92D2B1615A0265D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851f2160-78dc-4b91-edef-08dbcaf795b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 07:48:11.9834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LTeIqbkwRwqwDhLnPmp0PLV339TTOZRf9ydtd64yTrnq+DJFAG3/vuiR+IAxQQxYA7Mes8r5nD4+H8YoKbQR9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6428
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gRnJpLCAyMDIzLTA4LTA0IGF0IDA5OjI4ICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gSW52ZXJ0IHRoZSBjaGVjayBmb3Igc3RhdGUt
PmdhbW1hX2x1dCBhbmQgbW92ZSBpdCBhdCB0aGUgYmVnaW5uaW5nDQo+IG9mIHRoZSBmdW5jdGlv
biB0byByZWR1Y2UgaW5kZW50YXRpb246IHRoaXMgcHJlcGFyZXMgdGhlIGNvZGUgZm9yDQo+IGtl
ZXBpbmcgcmVhZGFiaWxpdHkgb24gbGF0ZXIgYWRkaXRpb25zLg0KPiANCj4gVGhpcyBjb21taXQg
YnJpbmdzIG5vIGZ1bmN0aW9uYWwgY2hhbmdlcy4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5o
dUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8g
RGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0K
PiBSZXZpZXdlZC1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0K
PiBSZXZpZXdlZC1ieTogQWxleGFuZHJlIE1lcmduYXQgPGFtZXJnbmF0QGJheWxpYnJlLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZ2FtbWEuYyB8IDQ1
ICsrKysrKysrKysrKy0tLS0tLS0tLQ0KPiAtLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIzIGluc2Vy
dGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kaXNwX2dhbW1hLmMNCj4gaW5kZXggZDQyY2MwNjk4ZDgzLi40Nzc1MTg2NGJkNWMg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5j
DQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jDQo+IEBA
IC02NCw2ICs2NCwxMCBAQCB2b2lkIG10a19nYW1tYV9zZXRfY29tbW9uKHN0cnVjdCBkZXZpY2Ug
KmRldiwgdm9pZA0KPiBfX2lvbWVtICpyZWdzLCBzdHJ1Y3QgZHJtX2NydA0KPiAgCXUzMiB3b3Jk
Ow0KPiAgCXUzMiBkaWZmWzNdID0gezB9Ow0KPiAgDQo+ICsJLyogSWYgdGhlcmUncyBubyBnYW1t
YSBsdXQgdGhlcmUncyBub3RoaW5nIHRvIGRvIGhlcmUuICovDQo+ICsJaWYgKCFzdGF0ZS0+Z2Ft
bWFfbHV0KQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gIAkvKiBJZiB3ZSdyZSBjYWxsZWQgZnJvbSBB
QUwsIGRldiBpcyBOVUxMICovDQo+ICAJZ2FtbWEgPSBkZXYgPyBkZXZfZ2V0X2RydmRhdGEoZGV2
KSA6IE5VTEw7DQo+ICANCj4gQEAgLTcyLDI5ICs3NiwyNiBAQCB2b2lkIG10a19nYW1tYV9zZXRf
Y29tbW9uKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gdm9pZCBfX2lvbWVtICpyZWdzLCBzdHJ1Y3Qg
ZHJtX2NydA0KPiAgCWVsc2UNCj4gIAkJbHV0X2RpZmYgPSBmYWxzZTsNCj4gIA0KPiAtCWlmIChz
dGF0ZS0+Z2FtbWFfbHV0KSB7DQo+IC0JCXJlZyA9IHJlYWRsKHJlZ3MgKyBESVNQX0dBTU1BX0NG
Ryk7DQo+IC0JCXJlZyA9IHJlZyB8IEdBTU1BX0xVVF9FTjsNCj4gLQkJd3JpdGVsKHJlZywgcmVn
cyArIERJU1BfR0FNTUFfQ0ZHKTsNCj4gLQkJbHV0X2Jhc2UgPSByZWdzICsgRElTUF9HQU1NQV9M
VVQ7DQo+IC0JCWx1dCA9IChzdHJ1Y3QgZHJtX2NvbG9yX2x1dCAqKXN0YXRlLT5nYW1tYV9sdXQt
PmRhdGE7DQo+IC0JCWZvciAoaSA9IDA7IGkgPCBNVEtfTFVUX1NJWkU7IGkrKykgew0KPiAtDQo+
IC0JCQlpZiAoIWx1dF9kaWZmIHx8IChpICUgMiA9PSAwKSkgew0KPiAtCQkJCXdvcmQgPSAoKChs
dXRbaV0ucmVkID4+IDYpICYNCj4gTFVUXzEwQklUX01BU0spIDw8IDIwKSArDQo+IC0JCQkJCSgo
KGx1dFtpXS5ncmVlbiA+PiA2KSAmDQo+IExVVF8xMEJJVF9NQVNLKSA8PCAxMCkgKw0KPiAtCQkJ
CQkoKGx1dFtpXS5ibHVlID4+IDYpICYNCj4gTFVUXzEwQklUX01BU0spOw0KPiAtCQkJfSBlbHNl
IHsNCj4gLQkJCQlkaWZmWzBdID0gKGx1dFtpXS5yZWQgPj4gNikgLSAobHV0W2kgLQ0KPiAxXS5y
ZWQgPj4gNik7DQo+IC0JCQkJZGlmZlsxXSA9IChsdXRbaV0uZ3JlZW4gPj4gNikgLSAobHV0W2kN
Cj4gLSAxXS5ncmVlbiA+PiA2KTsNCj4gLQkJCQlkaWZmWzJdID0gKGx1dFtpXS5ibHVlID4+IDYp
IC0gKGx1dFtpIC0NCj4gMV0uYmx1ZSA+PiA2KTsNCj4gLQ0KPiAtCQkJCXdvcmQgPSAoKGRpZmZb
MF0gJiBMVVRfMTBCSVRfTUFTSykgPDwNCj4gMjApICsNCj4gLQkJCQkJKChkaWZmWzFdICYgTFVU
XzEwQklUX01BU0spIDw8DQo+IDEwKSArDQo+IC0JCQkJCShkaWZmWzJdICYgTFVUXzEwQklUX01B
U0spOw0KPiAtCQkJfQ0KPiAtCQkJd3JpdGVsKHdvcmQsIChsdXRfYmFzZSArIGkgKiA0KSk7DQo+
ICsJcmVnID0gcmVhZGwocmVncyArIERJU1BfR0FNTUFfQ0ZHKTsNCj4gKwlyZWcgPSByZWcgfCBH
QU1NQV9MVVRfRU47DQo+ICsJd3JpdGVsKHJlZywgcmVncyArIERJU1BfR0FNTUFfQ0ZHKTsNCj4g
KwlsdXRfYmFzZSA9IHJlZ3MgKyBESVNQX0dBTU1BX0xVVDsNCj4gKwlsdXQgPSAoc3RydWN0IGRy
bV9jb2xvcl9sdXQgKilzdGF0ZS0+Z2FtbWFfbHV0LT5kYXRhOw0KPiArCWZvciAoaSA9IDA7IGkg
PCBNVEtfTFVUX1NJWkU7IGkrKykgew0KPiArCQlpZiAoIWx1dF9kaWZmIHx8IChpICUgMiA9PSAw
KSkgew0KPiArCQkJd29yZCA9ICgoKGx1dFtpXS5yZWQgPj4gNikgJiBMVVRfMTBCSVRfTUFTSykg
PDwNCj4gMjApICsNCj4gKwkJCQkoKChsdXRbaV0uZ3JlZW4gPj4gNikgJiBMVVRfMTBCSVRfTUFT
SykNCj4gPDwgMTApICsNCj4gKwkJCQkoKGx1dFtpXS5ibHVlID4+IDYpICYgTFVUXzEwQklUX01B
U0spOw0KPiArCQl9IGVsc2Ugew0KPiArCQkJZGlmZlswXSA9IChsdXRbaV0ucmVkID4+IDYpIC0g
KGx1dFtpIC0gMV0ucmVkDQo+ID4+IDYpOw0KPiArCQkJZGlmZlsxXSA9IChsdXRbaV0uZ3JlZW4g
Pj4gNikgLSAobHV0W2kgLQ0KPiAxXS5ncmVlbiA+PiA2KTsNCj4gKwkJCWRpZmZbMl0gPSAobHV0
W2ldLmJsdWUgPj4gNikgLSAobHV0W2kgLSAxXS5ibHVlDQo+ID4+IDYpOw0KPiArDQo+ICsJCQl3
b3JkID0gKChkaWZmWzBdICYgTFVUXzEwQklUX01BU0spIDw8IDIwKSArDQo+ICsJCQkJKChkaWZm
WzFdICYgTFVUXzEwQklUX01BU0spIDw8IDEwKSArDQo+ICsJCQkJKGRpZmZbMl0gJiBMVVRfMTBC
SVRfTUFTSyk7DQo+ICAJCX0NCj4gKwkJd3JpdGVsKHdvcmQsIChsdXRfYmFzZSArIGkgKiA0KSk7
DQo+ICAJfQ0KPiAgfQ0KPiAgDQo=

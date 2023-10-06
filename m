Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC247BB362
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 10:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjJFIkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 04:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjJFIkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:40:36 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C46E83;
        Fri,  6 Oct 2023 01:40:34 -0700 (PDT)
X-UUID: 011c6b40642411eea33bb35ae8d461a2-20231006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=kiAXyJ1gUauy3NbT59hv8Qv1DT/oJbqVhFy2nADBoYk=;
        b=i6hnoeH7PxbWTQlRIo3eNAozQp1gCwYi5O7WDpMb6DgV8cgekhchQ6awrsMyJk4qqW/Cc2/NEFto46/hacYatRTIKknA0eh6sTXDQV5RdfLlslBXTo5ZSnnzMAVqV/ZZ/wa38a3thpIzURbNGzhp48cZEJjcZfyVNYd8BbkeJQ0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:c074e434-d364-473f-b13d-0acfd5806a4d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:8a9583f0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 011c6b40642411eea33bb35ae8d461a2-20231006
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1186353399; Fri, 06 Oct 2023 16:40:29 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 6 Oct 2023 16:40:28 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 6 Oct 2023 16:40:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOR7PalkBBwGzQpntltlY4VRJ0WP5mt9JG10Qod39NztbPnbDaV8cCxO6x8GDfx1LZgnIJLwfUDBjcaa98W59hGvQND6MU2FKxCcyc3mooWN6fzKTAehgY+bq9pbwSwHOl8K3vMEBKwvvbbVhwLndB+ZCyb86cjGrrcgj/hQAHTVtYc2XWyv6puIuNnfovVNxw0Y3gHx3SytaIl0pVToy66I89V5oFeI2tsGcauBmO2UaErwSEwgwCujF1ju3mtAdk0Ow/vIvyPHhE4CQ3s2xdGQkwy6zzndY/0Mtqw+ARtniq69DYOuIrCIp7YiOvU25WKXTOOBI+eQeaGSQfVnKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiAXyJ1gUauy3NbT59hv8Qv1DT/oJbqVhFy2nADBoYk=;
 b=icFAzOFxz0/NT2A+ulAlEJjYhVfGC/VMOnmgv76BocYLpGNot08iXTyrbMTN+T0XuaLjq0fStBJso8wrciJwkPWiZho35fQP9XWwYiNGkFQP8GyyZUPsdsxHAcoNz2qi8ECyFaHZ1uyRpx7CrKJ7MmMsWpZ+seL0EFJXpEE/Dkv9Sb6ZQqlY+ZIwz2OMDGq85vZ69gSZ45pfNDnBEy0R1/LCOmLEmXsRHr/6cATlFp1PUuWm5D8QTDC/m2bd0HECT7sH4OUi2T8lcUsY7YVRBxFW0lIngUVsA1MTsd+LbhIdK5FiaPCg+ev/LCCp30jKmFKSynvSQOwlrWM86kS0qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiAXyJ1gUauy3NbT59hv8Qv1DT/oJbqVhFy2nADBoYk=;
 b=aZAJTtveT5TbwW0XZ3Cvcx3nQ0l260vaQr8tibxIvatGkbnI8n9XWXPRN/PJgkwhhDyiLLtTVCyCyAVOCOUlQcgPjF8/K/cNKUxqgI69mjAPJeCzxqIvCcFHHrv/KmoU3txZCSlAR/mkk9JD3NEktx1hBejAPPuHTezIMjzXqOU=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR0302MB5186.apcprd03.prod.outlook.com (2603:1096:820:48::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 08:40:26 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%7]) with mapi id 15.20.6792.026; Fri, 6 Oct 2023
 08:40:25 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 17/23] drm/mediatek: Support MT8188 Padding in display
 driver
Thread-Topic: [PATCH v7 17/23] drm/mediatek: Support MT8188 Padding in display
 driver
Thread-Index: AQHZ+CgtNf1uLNdvOk+IgZkBzawUxLA8cS+A
Date:   Fri, 6 Oct 2023 08:40:25 +0000
Message-ID: <b506a5ab1e02e11e969321eb1f4ca85ec658b354.camel@mediatek.com>
References: <20231006073831.10402-1-shawn.sung@mediatek.com>
         <20231006073831.10402-18-shawn.sung@mediatek.com>
In-Reply-To: <20231006073831.10402-18-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR0302MB5186:EE_
x-ms-office365-filtering-correlation-id: aa39c156-8d0f-4184-3cc5-08dbc647e317
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WCPQcULHuBJTnwzJywBA1KUyqX2d9PporOzIimHr+/O7bewrmFNUpB7Th7mslrNFgxVALqw+zoVkPzXhe4LVL5Te9NwyaE5ybHMa1QZugGG/uNK83sk5OO0S1DIuxYKxzo7fuQFDhQHP2eWN25DKh0hkJYGxzmOydXo+cjNCbAmWiWQXTnDtE3/fmWUNvSjSJ4I9ipNNRwUsoGQB3pGioDZTt7ae2XY4+2EJJtEhuO7RS888nD99oVeX0j59LPa1gVVwZYlqA16kTcYR3rmkEFI51nx+KcpCC/cpEykGXUngbqHS8triICf63lVDN+W4kPG2vNbR9O3W8+ail4ZFeaDHb7cAgEX6a3Py/N+biMY8FvwEYQymvr9leBffn1ovb0MhZrLfkiZYF0DvgZ48b9Zc5i/NV2dR7UMKpTrW7o//BIwrSVBcINiKIYuImcN5pc+yAW7m9Cwso2xQHf+B5kgv9MF6hHoLRpkUPByHgd2eNyz4EZN0wJq+keWc6gCJYyTLTcBV1PVOvyir3WEdUyH85FVX8e8Ug948N3wiHGfVWC8CQ5k2qX/wd78Eai3sGjAoQnqqGGIplMNKd4S4ftdHMIfPDZ5BbV3qxmU6g67tILARD3zGTVxXT7rPT/JnLqJyGyxkXHLhQLIUwbbCYfQqs8jrYtJYwmITr2Oix7c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(396003)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(36756003)(83380400001)(26005)(5660300002)(7416002)(8676002)(8936002)(4326008)(2616005)(85182001)(6512007)(6506007)(71200400001)(122000001)(6486002)(110136005)(38100700002)(478600001)(86362001)(2906002)(66556008)(76116006)(316002)(66899024)(64756008)(54906003)(66476007)(66446008)(38070700005)(66946007)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmxQZWx2V09pajJpVDBUT3RDa1JQa1MzQk9sL1FSRnpOcXBWTFYzSklySXI4?=
 =?utf-8?B?RHBSWkNTclByWXVMeHBVOW1ZM1g2WmpMTTQ4M2J1RkhHb0pheE5QUDQzMERj?=
 =?utf-8?B?NDdVdTRIOVJPTDhMcGltTlRDSy9KeG5xNm10a3F0OEVQTTdaaXdMMUFjcTJQ?=
 =?utf-8?B?aGRFUEdjNmtPOTJzR2hteERXQ213Tk5RTzdXZkVBczJLZ2xoV3EvdGZIRVBH?=
 =?utf-8?B?OU1qcEg3T2ZFRDJmQzZGaGxpUXNEWENEVmcwOHhSYXQvK0pSYVM5d0lYZHA2?=
 =?utf-8?B?dzV5c2RwYU41ckxIVFpkSmZET1l2MUZnV0VJYUdjcmROckduS0R4Z1ZnRGRT?=
 =?utf-8?B?bHRIL1pQQUN0VEJKZEN0RlpRNTFjL043N2VYdDNBTzFiclpuMVpKOTFuR0w1?=
 =?utf-8?B?ajZadkowQ29iM2RDaDdnd2paRUNTeTRXb2dNd2d6bm9ITHpGbWNZV3U1VE5t?=
 =?utf-8?B?dkJqUXdsWE9WUG1SRWczdS9nUENiTWpMS0xweTA4ZG11c2lPSG94NmpnMlo5?=
 =?utf-8?B?Y1VDS0dFd3R0RTNWQ2RKcVZnaFJERlU2c0ZidkRDZEpPdHNGTEw3cjhmWW1a?=
 =?utf-8?B?VXRWbUEyZjlkTE1sVDRjZ0V5NWFRWjh3TzV3M2MvN0lTVThMRzZtQzk2WnJl?=
 =?utf-8?B?Q0ppWnR0Mm8yUS9iZ3NvdG1BdE1aM3ZQWCtyMUdURVdKUGMyWmNXNTNKemtO?=
 =?utf-8?B?Ky9nNTQzVGNhK1F6aDRNSjJEL0c0OFlDV0oxNWJmWW1tMWc0aXZORW9lY2M5?=
 =?utf-8?B?QnhPYW1mY1dOVUR0c25yYXdZU2piR2ZBSGpHUDB6Ni8wWmMxU1Bsb3RCZXUr?=
 =?utf-8?B?aklxdW1OcmVCZzVZcUFyd0RCN0Z3VGlXOFNJdFlna09kQ1NqbTk1MkYveUk1?=
 =?utf-8?B?WnN0Q3BaKzFZWUppRWF4R00wTGtDREMwbUQ2RG9Nb2tJV3llb2o4d3lkVzZ2?=
 =?utf-8?B?NEhlVFBOM1BZbC9mSS8zOTZyRlY2eGhCZEJzOTE4QlYyMjNVR3lNMXJmbkRM?=
 =?utf-8?B?ZmpMNTU2MC84Z2lBTmc0dGVlWVZsMEZOS2lJL1l2bnZ6UjVMZEUzZVYwb1V2?=
 =?utf-8?B?TVg1anYrVnVEZXhiVDZsOTVKMGMxTXpNUXYzZGl6UVNFRFVGYVQrOUlGTlcr?=
 =?utf-8?B?bmF0TVdwQ2tibzJ6YjhFN0s2LzNQaFVtWCtuSTJyQ0MxeUdxWk02NW5hYkFS?=
 =?utf-8?B?ZHhhakxHME5ieUMrbTMyZ0k2VVJqdGZKbllBOUQycTNVYzdFbTRiaG4rYTRU?=
 =?utf-8?B?Nkxnbi9INUs5d0s4ZmZmNjRQTFpzK1R1KzBXMXVmcWR5cWpvVkhWQ1hzVmNS?=
 =?utf-8?B?MUQzdWFuL0FQaElCTCtmdDFNdU1Ba09iWGxBSVlrK0NUVEpYNFZ3TzBkdm5D?=
 =?utf-8?B?UmZhM3RaUS9hb0cweko5cEk5YUFlMWgwdm96RU9xY1J3RTF4WnVIRisxV3dB?=
 =?utf-8?B?elAvVnBJWTVSazBtcFlERGZmZmpVeUZMRmxpRWFSMjZiNGtZN1grNUFJd1Y0?=
 =?utf-8?B?ZzZoNjBCMEpxL3dFNHNFUWc0SWJ5MTBVS2tvdHR5U0ozRWFGS1crV0xTZHFJ?=
 =?utf-8?B?NHdwSXNQbW90YnhXQUZ2T2FXZTNMRUFGODVSMm9ZWjg5L09pSDV4UktSOFJC?=
 =?utf-8?B?ZUtjV0djVkF4ZWZtdWZ6VlhTOEEyNENuT2ZvV2N0NW44aHNiK2N2cXhQejQ5?=
 =?utf-8?B?c3ZiOWZ5WnVsaFRQZVNuN1dZY1I0djB4Q3FPZVdLZllpdGw4WUJoOUVCVGpS?=
 =?utf-8?B?Z2grRWRmZWQya05rWnBsaHNIOHdrblJnUVRYVGkvYVN0eDJxOE95VmljVmNP?=
 =?utf-8?B?YmNQelFnSUNYL0hHbXhUNktTL2VCK1hWVk1CVEdyMEk3RzJDcHlWYlo0TktG?=
 =?utf-8?B?dU5RUTdvK1lJakVFYmoyK2o5MTAwaURMOGVzQTZIZ0dxbWpVVzVLdExLWlFt?=
 =?utf-8?B?V2cvMVlhOXBKVWY3d2FUN2VTbXNXanNHU1JsZ3JqSXkrVnNWZ0FITENGMUtE?=
 =?utf-8?B?WnZiMXpaakQzNis0TW5BYVF1QXVEcmJXbkVXVFFZTlZzdnlTeVlmVzYvZjVF?=
 =?utf-8?B?WE1TUVpsWVJBcVE4NFZ6SDdKekNMS2FTTWl3UVRWN2JMeW5XU0s1T1EzcHE2?=
 =?utf-8?Q?6M6UpQpHhEB7ORvea9m+xrwk+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F36DA1229E88E44881BE3D3589BFCDEF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa39c156-8d0f-4184-3cc5-08dbc647e317
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 08:40:25.7814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oQErZ3besNjn/zJMwF2woC/qLxf/t7rZfQJqDxPHWZcwz2qMaUaCsPrXLvf8AtxtaNjOJV7PHenfYF+U/mHe6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5186
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBGcmksIDIwMjMtMTAtMDYgYXQgMTU6MzggKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IFBhZGRpbmcgaXMgYSBuZXcgZGlzcGxheSBtb2R1bGUg
b24gTVQ4MTg4LCBpdCBwcm92aWRlcyBhYmlsaXR5DQo+IHRvIGFkZCBwaXhlbHMgdG8gd2lkdGgg
YW5kIGhlaWdodCBvZiBhIGxheWVyIHdpdGggc3BlY2lmaWVkIGNvbG9ycy4NCj4gDQo+IER1ZSB0
byBoYXJkd2FyZSBkZXNpZ24sIE1peGVyIGluIFZET1NZUzEgcmVxdWlyZXMgd2lkdGggb2YgYSBs
YXllcg0KPiB0byBiZSAyLXBpeGVsLWFsaWduLCBvciA0LXBpeGVsLWFsaWduIHdoZW4gRVRIRFIg
aXMgZW5hYmxlZCwNCj4gd2UgbmVlZCBQYWRkaW5nIHRvIGRlYWwgd2l0aCBvZGQgd2lkdGguDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBIc2lhbyBDaGllbiBTdW5nIDxzaGF3bi5zdW5nQG1lZGlhdGVr
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvTWFrZWZpbGUgICAgICAg
fCAgIDMgKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaCB8ICAg
MyArDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYyAgfCAgIDEgKw0K
PiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmggIHwgICAyICstDQo+ICBk
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX3BhZGRpbmcuYyAgfCAyMDYNCj4gKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ICA1IGZpbGVzIGNoYW5nZWQsIDIxMyBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfcGFkZGluZy5jDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL01ha2VmaWxlDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL01ha2VmaWxlDQo+
IGluZGV4IGQ0ZDE5M2Y2MDI3MS4uNWU0NDM2NDAzYjhkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvTWFrZWZpbGUNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL01ha2VmaWxlDQo+IEBAIC0xNiw3ICsxNiw4IEBAIG1lZGlhdGVrLWRybS15IDo9IG10a19k
aXNwX2FhbC5vIFwNCj4gIAkJICBtdGtfZHNpLm8gXA0KPiAgCQkgIG10a19kcGkubyBcDQo+ICAJ
CSAgbXRrX2V0aGRyLm8gXA0KPiAtCQkgIG10a19tZHBfcmRtYS5vDQo+ICsJCSAgbXRrX21kcF9y
ZG1hLm8gXA0KPiArCQkgIG10a19wYWRkaW5nLm8NCj4gIA0KPiAgb2JqLSQoQ09ORklHX0RSTV9N
RURJQVRFSykgKz0gbWVkaWF0ZWstZHJtLm8NCj4gIA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kaXNwX2Rydi5oDQo+IGluZGV4IDIyNTQwMzg1MTllMS4uZjlmZGIxMjY4YWE1IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+IEBAIC0xNTcs
NCArMTU3LDcgQEAgdm9pZCBtdGtfbWRwX3JkbWFfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwN
Cj4gc3RydWN0IG10a19tZHBfcmRtYV9jZmcgKmNmZywNCj4gIGNvbnN0IHUzMiAqbXRrX21kcF9y
ZG1hX2dldF9mb3JtYXRzKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICBzaXplX3QgbXRrX21kcF9y
ZG1hX2dldF9udW1fZm9ybWF0cyhzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAgDQo+ICtpbnQgbXRr
X3BhZGRpbmdfY2xrX2VuYWJsZShzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiArdm9pZCBtdGtfcGFk
ZGluZ19jbGtfZGlzYWJsZShzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiArdm9pZCBtdGtfcGFkZGlu
Z19jb25maWcoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgY21kcV9wa3QNCj4gKmNtZHFfcGt0
KTsNCj4gICNlbmRpZg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcm1fZHJ2LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0K
PiBpbmRleCA5MzU1MmQ3NmI2ZTcuLmNkZTY5ZjM5YTA2NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gQEAgLTk3Myw2ICs5NzMsNyBAQCBzdGF0aWMgc3Ry
dWN0IHBsYXRmb3JtX2RyaXZlciAqIGNvbnN0DQo+IG10a19kcm1fZHJpdmVyc1tdID0gew0KPiAg
CSZtdGtfZHNpX2RyaXZlciwNCj4gIAkmbXRrX2V0aGRyX2RyaXZlciwNCj4gIAkmbXRrX21kcF9y
ZG1hX2RyaXZlciwNCj4gKwkmbXRrX3BhZGRpbmdfZHJpdmVyLA0KPiAgfTsNCj4gIA0KPiAgc3Rh
dGljIGludCBfX2luaXQgbXRrX2RybV9pbml0KHZvaWQpDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2Rydi5oDQo+IGluZGV4IGViMmZkNDU5NDFmMC4uNTYyZjJkYjQ3YWRkIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuaA0KPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuaA0KPiBAQCAtNjQsNSAr
NjQsNSBAQCBleHRlcm4gc3RydWN0IHBsYXRmb3JtX2RyaXZlciBtdGtfZHBpX2RyaXZlcjsNCj4g
IGV4dGVybiBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIG10a19kc2lfZHJpdmVyOw0KPiAgZXh0ZXJu
IHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgbXRrX2V0aGRyX2RyaXZlcjsNCj4gIGV4dGVybiBzdHJ1
Y3QgcGxhdGZvcm1fZHJpdmVyIG10a19tZHBfcmRtYV9kcml2ZXI7DQo+IC0NCj4gK2V4dGVybiBz
dHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIG10a19wYWRkaW5nX2RyaXZlcjsNCj4gICNlbmRpZiAvKiBN
VEtfRFJNX0RSVl9IICovDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX3BhZGRpbmcuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfcGFkZGluZy5j
DQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uMmEyOWE1ZmEw
YTY4DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19wYWRkaW5nLmMNCj4gQEAgLTAsMCArMSwyMDYgQEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wLW9ubHkNCj4gKy8qDQo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjMgTWVk
aWFUZWsgSW5jLg0KPiArICovDQo+ICsNCj4gKyNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gKyNp
bmNsdWRlIDxsaW51eC9jb21wb25lbnQuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4N
Cj4gKyNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9wbGF0
Zm9ybV9kZXZpY2UuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+DQo+ICsjaW5j
bHVkZSA8bGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmg+DQo+ICsNCj4gKyNpbmNsdWRlICJt
dGtfZGlzcF9kcnYuaCINCj4gKyNpbmNsdWRlICJtdGtfZHJtX2NydGMuaCINCj4gKyNpbmNsdWRl
ICJtdGtfZHJtX2RkcF9jb21wLmgiDQo+ICsNCj4gKyNkZWZpbmUgUEFERElOR19DT05UUk9MX1JF
RwkweDAwDQo+ICsjZGVmaW5lIFBBRERJTkdfQllQQVNTCQkJQklUKDApDQo+ICsjZGVmaW5lIFBB
RERJTkdfRU5BQkxFCQkJQklUKDEpDQo+ICsjZGVmaW5lIFBBRERJTkdfUElDX1NJWkVfUkVHCTB4
MDQNCj4gKyNkZWZpbmUgUEFERElOR19IX1JFRwkJMHgwOCAvKiBob3Jpem9udGFsICovDQo+ICsj
ZGVmaW5lIFBBRERJTkdfVl9SRUcJCTB4MGMgLyogdmVydGljYWwgKi8NCj4gKyNkZWZpbmUgUEFE
RElOR19DT0xPUl9SRUcJMHgxMA0KPiArDQo+ICsjZGVmaW5lIFBBRERJTkdfUElDX1NJWkUodywg
aCkgKAlcDQo+ICsJKCh3KSAmIEdFTk1BU0soMTUsIDApKSB8CVwNCj4gKwkoKChoKSAmIEdFTk1B
U0soMTUsIDApKSA+PiAxNikJXA0KPiArKQ0KPiArDQo+ICsjZGVmaW5lIFBBRERJTkdfSChyaWdo
dCkgKCgocmlnaHQpICYgR0VOTUFTSygxMiwgMCkpID4+IDE2KQ0KPiArDQo+ICsjZGVmaW5lIFBB
RERJTkdfVihib3R0b20pICgoKGJvdHRvbSkgJiBHRU5NQVNLKDEyLCAwKSkgPj4gMTYpDQo+ICsN
Cj4gKy8qIDEwLWJpdCBSR0Igd2l0aG91dCBhbHBoYSAqLw0KPiArI2RlZmluZSBQQURESU5HX0NP
TE9SKHIsIGcsIGIpICgJXA0KPiArCSgocikgJiBHRU5NQVNLKDksIDApKSA8PCAyMiB8CVwNCj4g
KwkoKGcpICYgR0VOTUFTSyg5LCAwKSkgPDwgMTIgfAlcDQo+ICsJKChiKSAmIEdFTk1BU0soOSwg
MCkpIDw8IDIJXA0KPiArKQ0KPiArDQo+ICsvKioNCj4gKyAqIHN0cnVjdCBtdGtfcGFkZGluZyAt
IGJhc2ljIGluZm9ybWF0aW9uIG9mIFBhZGRpbmcNCj4gKyAqIEBjbGs6IENsb2NrIG9mIHRoZSBt
b2R1bGUNCj4gKyAqIEByZWc6IFZpcnR1YWwgYWRkcmVzcyBvZiB0aGUgUGFkZGluZyBmb3IgQ1BV
IHRvIGFjY2Vzcw0KPiArICogQGNtZHFfcmVnOiBDTURRIHNldHRpbmcgb2YgdGhlIFBhZGRpbmcN
Cj4gKyAqDQo+ICsgKiBFdmVyeSBQYWRkaW5nIHNob3VsZCBoYXZlIGRpZmZlcmVudCBjbG9jayBz
b3VyY2UsIHJlZ2lzdGVyIGJhc2UsDQo+IGFuZA0KPiArICogQ01EUSBzZXR0aW5ncywgd2Ugc3Rv
cmVkIHRoZXNlIGRpZmZlcmVuY2VzIGFsbCB0b2dldGhlci4NCj4gKyAqLw0KPiArc3RydWN0IG10
a19wYWRkaW5nIHsNCj4gKwlzdHJ1Y3QgY2xrCQkqY2xrOw0KPiArCXZvaWQgX19pb21lbQkJKnJl
ZzsNCj4gKwlzdHJ1Y3QgY21kcV9jbGllbnRfcmVnCWNtZHFfcmVnOw0KPiArfTsNCj4gKw0KPiAr
aW50IG10a19wYWRkaW5nX2Nsa19lbmFibGUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiArew0KPiAr
CXN0cnVjdCBtdGtfcGFkZGluZyAqcGFkZGluZyA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiAr
DQo+ICsJcmV0dXJuIGNsa19wcmVwYXJlX2VuYWJsZShwYWRkaW5nLT5jbGspOw0KPiArfQ0KPiAr
DQo+ICt2b2lkIG10a19wYWRkaW5nX2Nsa19kaXNhYmxlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4g
K3sNCj4gKwlzdHJ1Y3QgbXRrX3BhZGRpbmcgKnBhZGRpbmcgPSBkZXZfZ2V0X2RydmRhdGEoZGV2
KTsNCj4gKw0KPiArCWNsa19kaXNhYmxlX3VucHJlcGFyZShwYWRkaW5nLT5jbGspOw0KPiArfQ0K
PiArDQo+ICt2b2lkIG10a19wYWRkaW5nX3N0YXJ0KHN0cnVjdCBkZXZpY2UgKmRldikNCj4gK3sN
Cj4gKwlzdHJ1Y3QgbXRrX3BhZGRpbmcgKnBhZGRpbmcgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsN
Cj4gKw0KPiArCXdyaXRlbChQQURESU5HX0VOQUJMRSB8IFBBRERJTkdfQllQQVNTLA0KPiArCSAg
ICAgICBwYWRkaW5nLT5yZWcgKyBQQURESU5HX0NPTlRST0xfUkVHKTsNCj4gKw0KPiArCS8qDQo+
ICsJICogbm90aWNlIHRoYXQgZXZlbiB0aGUgcGFkZGluZyBpcyBpbiBieXBhc3MgbW9kZSwNCj4g
KwkgKiBhbGwgdGhlIHNldHRpbmdzIG11c3QgYmUgY2xlYXJlZCB0byAwIG9yDQo+ICsJICogdW5k
ZWZpbmVkIGJlaGF2aW9ycyBjb3VsZCBoYXBwZW4NCj4gKwkgKi8NCj4gKwl3cml0ZWwoMCwgcGFk
ZGluZy0+cmVnICsgUEFERElOR19QSUNfU0laRV9SRUcpOw0KPiArCXdyaXRlbCgwLCBwYWRkaW5n
LT5yZWcgKyBQQURESU5HX0hfUkVHKTsNCj4gKwl3cml0ZWwoMCwgcGFkZGluZy0+cmVnICsgUEFE
RElOR19WX1JFRyk7DQo+ICsJd3JpdGVsKDAsIHBhZGRpbmctPnJlZyArIFBBRERJTkdfQ09MT1Jf
UkVHKTsNCj4gK30NCj4gKw0KPiArdm9pZCBtdGtfcGFkZGluZ19zdG9wKHN0cnVjdCBkZXZpY2Ug
KmRldikNCj4gK3sNCj4gKwlzdHJ1Y3QgbXRrX3BhZGRpbmcgKnBhZGRpbmcgPSBkZXZfZ2V0X2Ry
dmRhdGEoZGV2KTsNCj4gKw0KPiArCXdyaXRlbF9yZWxheGVkKDAsIHBhZGRpbmctPnJlZyArIFBB
RERJTkdfQ09OVFJPTF9SRUcpOw0KPiArfQ0KPiArDQo+ICt2b2lkIG10a19wYWRkaW5nX2NvbmZp
ZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBjbWRxX3BrdA0KPiAqY21kcV9wa3QsDQo+ICsJ
CQl1MzIgd2lkdGgsIHUzMiBoZWlnaHQsIHUzMiByaWdodCwgdTMyIGJvdHRvbSwNCj4gdTMyIGNv
bG9yKQ0KDQptdGtfcGFkZGluZ19jb25maWcoKSBpcyB1c2VsZXNzLCBzbyBkcm9wIGl0Lg0KDQpS
ZWdhcmRzLA0KQ0sNCg0KPiArew0KPiArCWJvb2wgYnlwYXNzID0gdHJ1ZTsNCj4gKwlzdHJ1Y3Qg
bXRrX3BhZGRpbmcgKnBhZGRpbmcgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gKw0KPiArCWlm
ICh3aWR0aCB8IGhlaWdodCB8IHJpZ2h0IHwgYm90dG9tIHwgY29sb3IpDQo+ICsJCWJ5cGFzcyA9
IGZhbHNlOw0KPiArDQo+ICsJbXRrX2RkcF93cml0ZV9tYXNrKGNtZHFfcGt0LCBieXBhc3MsDQo+
ICsJCQkgICAmcGFkZGluZy0+Y21kcV9yZWcsIHBhZGRpbmctPnJlZywNCj4gKwkJCSAgIFBBRERJ
TkdfQ09OVFJPTF9SRUcsIFBBRERJTkdfQllQQVNTKTsNCj4gKw0KPiArCW10a19kZHBfd3JpdGVf
bWFzayhjbWRxX3BrdCwgUEFERElOR19QSUNfU0laRSh3aWR0aCwgaGVpZ2h0KSwNCj4gKwkJCSAg
ICZwYWRkaW5nLT5jbWRxX3JlZywgcGFkZGluZy0+cmVnLA0KPiArCQkJICAgUEFERElOR19QSUNf
U0laRV9SRUcsIEdFTk1BU0soMzEsIDApKTsNCj4gKw0KPiArCW10a19kZHBfd3JpdGVfbWFzayhj
bWRxX3BrdCwgUEFERElOR19IKHJpZ2h0KSwNCj4gKwkJCSAgICZwYWRkaW5nLT5jbWRxX3JlZywg
cGFkZGluZy0+cmVnLA0KPiArCQkJICAgUEFERElOR19IX1JFRywgR0VOTUFTSygzMSwgMCkpOw0K
PiArDQo+ICsJbXRrX2RkcF93cml0ZV9tYXNrKGNtZHFfcGt0LCBQQURESU5HX1YoYm90dG9tKSwN
Cj4gKwkJCSAgICZwYWRkaW5nLT5jbWRxX3JlZywgcGFkZGluZy0+cmVnLA0KPiArCQkJICAgUEFE
RElOR19WX1JFRywgR0VOTUFTSygzMSwgMCkpOw0KPiArDQo+ICsJbXRrX2RkcF93cml0ZV9tYXNr
KGNtZHFfcGt0LCBQQURESU5HX1YoYm90dG9tKSwNCj4gKwkJCSAgICZwYWRkaW5nLT5jbWRxX3Jl
ZywgcGFkZGluZy0+cmVnLA0KPiArCQkJICAgUEFERElOR19WX1JFRywgR0VOTUFTSygzMSwgMCkp
Ow0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IG10a19wYWRkaW5nX2JpbmQoc3RydWN0IGRldmlj
ZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlDQo+ICptYXN0ZXIsIHZvaWQgKmRhdGEpDQo+ICt7DQo+ICsJ
cmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIG10a19wYWRkaW5nX3VuYmluZChz
dHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2UNCj4gKm1hc3Rlciwgdm9pZCAqZGF0YSkN
Cj4gK3sNCj4gK30NCj4gKw0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBjb21wb25lbnRfb3BzIG10
a19wYWRkaW5nX2NvbXBvbmVudF9vcHMgPSB7DQo+ICsJLmJpbmQJPSBtdGtfcGFkZGluZ19iaW5k
LA0KPiArCS51bmJpbmQgPSBtdGtfcGFkZGluZ191bmJpbmQsDQo+ICt9Ow0KPiArDQo+ICtzdGF0
aWMgaW50IG10a19wYWRkaW5nX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ICt7DQo+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gKwlzdHJ1Y3QgbXRr
X3BhZGRpbmcgKnByaXY7DQo+ICsJc3RydWN0IHJlc291cmNlICpyZXM7DQo+ICsJaW50IHJldDsN
Cj4gKw0KPiArCXByaXYgPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2YoKnByaXYpLCBHRlBfS0VS
TkVMKTsNCj4gKwlpZiAoIXByaXYpDQo+ICsJCXJldHVybiAtRU5PTUVNOw0KPiArDQo+ICsJcHJp
di0+Y2xrID0gZGV2bV9jbGtfZ2V0KGRldiwgTlVMTCk7DQo+ICsJaWYgKElTX0VSUihwcml2LT5j
bGspKSB7DQo+ICsJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGdldCBjbGtcbiIpOw0KPiArCQly
ZXR1cm4gUFRSX0VSUihwcml2LT5jbGspOw0KPiArCX0NCj4gKw0KPiArCXByaXYtPnJlZyA9IGRl
dm1fcGxhdGZvcm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDAsDQo+ICZyZXMpOw0K
PiArCWlmIChJU19FUlIocHJpdi0+cmVnKSkgew0KPiArCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0
byBkbyBpb3JlbWFwXG4iKTsNCj4gKwkJcmV0dXJuIFBUUl9FUlIocHJpdi0+cmVnKTsNCj4gKwl9
DQo+ICsNCj4gKyNpZiBJU19SRUFDSEFCTEUoQ09ORklHX01US19DTURRKQ0KPiArCXJldCA9IGNt
ZHFfZGV2X2dldF9jbGllbnRfcmVnKGRldiwgJnByaXYtPmNtZHFfcmVnLCAwKTsNCj4gKwlpZiAo
cmV0KSB7DQo+ICsJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGdldCBnY2UgY2xpZW50IHJlZ1xu
Iik7DQo+ICsJCXJldHVybiByZXQ7DQo+ICsJfQ0KPiArI2VuZGlmDQo+ICsNCj4gKwlwbGF0Zm9y
bV9zZXRfZHJ2ZGF0YShwZGV2LCBwcml2KTsNCj4gKw0KPiArCXJldCA9IGRldm1fcG1fcnVudGlt
ZV9lbmFibGUoZGV2KTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICsJ
cmV0ID0gY29tcG9uZW50X2FkZChkZXYsICZtdGtfcGFkZGluZ19jb21wb25lbnRfb3BzKTsNCj4g
KwlpZiAocmV0KSB7DQo+ICsJCXBtX3J1bnRpbWVfZGlzYWJsZShkZXYpOw0KPiArCQlyZXR1cm4g
ZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgImZhaWxlZCB0byBhZGQNCj4gY29tcG9uZW50XG4iKTsN
Cj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBtdGtf
cGFkZGluZ19yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gK3sNCj4gKwlj
b21wb25lbnRfZGVsKCZwZGV2LT5kZXYsICZtdGtfcGFkZGluZ19jb21wb25lbnRfb3BzKTsNCj4g
KwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2Vf
aWQgbXRrX3BhZGRpbmdfZHJpdmVyX2R0X21hdGNoW10gPSB7DQo+ICsJeyAuY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxtdDgxODgtcGFkZGluZyIgfSwNCj4gKwl7IC8qIHNlbnRpbmVsICovIH0NCj4g
K307DQo+ICtNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBtdGtfcGFkZGluZ19kcml2ZXJfZHRfbWF0
Y2gpOw0KPiArDQo+ICtzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIG10a19wYWRkaW5nX2RyaXZlciA9
IHsNCj4gKwkucHJvYmUJCT0gbXRrX3BhZGRpbmdfcHJvYmUsDQo+ICsJLnJlbW92ZQkJPSBtdGtf
cGFkZGluZ19yZW1vdmUsDQo+ICsJLmRyaXZlcgkJPSB7DQo+ICsJCS5uYW1lCT0gIm1lZGlhdGVr
LXBhZGRpbmciLA0KPiArCQkub3duZXIJPSBUSElTX01PRFVMRSwNCj4gKwkJLm9mX21hdGNoX3Rh
YmxlID0gbXRrX3BhZGRpbmdfZHJpdmVyX2R0X21hdGNoLA0KPiArCX0sDQo+ICt9Ow0K

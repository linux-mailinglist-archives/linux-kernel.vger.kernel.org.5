Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF05762957
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 05:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjGZDfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 23:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGZDf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 23:35:26 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B8C2682;
        Tue, 25 Jul 2023 20:35:24 -0700 (PDT)
X-UUID: 72187b062b6511eeb20a276fd37b9834-20230726
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=N8rLge9q+Z5r3CCacFr+6URBJ82VVQkgKYduP6pkWNY=;
        b=W6vdvDhKx9foJwFmPvEuSqeVNAoCWmj/7QVxHifBalckOcQkkFNZJC9s0lKJOZ0nUEJ5N4ajQ1QJreokEfNWpE4nDfmetKmbLT7nDKWAvl4y6gMP5nUEjUo0Hzprmy8TwXOOjS6eUvwMUj7Uqs6PZExheLK40enWWBdXW/6b428=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:02a922c1-057b-4281-875d-7940b760e98d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:e7562a7,CLOUDID:529f54d2-cd77-4e67-bbfd-aa4eaace762f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 72187b062b6511eeb20a276fd37b9834-20230726
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 426774394; Wed, 26 Jul 2023 11:35:20 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 26 Jul 2023 11:35:18 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 26 Jul 2023 11:35:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdyCajy14I20BYsErK6SQpAORuJxF6xBDUk+GPT/t3vxZsi4x6gLdyT8j5vvtE+fB1X4rC69qFBT0fAVXB/KI2G2LiqPzORHAdkjC7MaHSC6h+Jq21VRWDDwl7x0VRY5sDQe7HUjYDPIRD4I3qNuqqkrnD7EJPHGwx9m0ERHbDZ0usj5bJ3jatplCdRRbUvsOO7LnTOwgfc7OOo8fCWYJ1KCrlAXyREx2xgbW8pPB9J5lz1MXdge19wTN8kQWsf7a2NFrjOoahu+KwPFngoyrYSr26+Z8rEGUHKfi2JHXrFsMGlkxZp53A1xmo0YPW3bIyz+p5oQyyfZl4bKRYAVtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8rLge9q+Z5r3CCacFr+6URBJ82VVQkgKYduP6pkWNY=;
 b=oX5dJJ3N1UFc4Ea+j7lbxOHq/TJM0rPuY/mDK/6VjvH9TYG3pKZOLoSduP408dKr38soMw5j8Kptfo6z2RExcyOCkHlfgSVzcmRvBXScsyPvz4oCDBAtYsa8uSbWrV7q2sb2xnuUzBaGydJPEf80LPdUvmcQoYZO/i8Wynusn/XivOGGz76Ci4s6dbmazA8Zhc+CMtu0BTZRtgLJmXo/7PrINFWLyucTpVRqUVT41hz/gGJfkp8gcbUxsAxdBaplPu48hRby6EYR8VS/JlXoAI/agPSwzUJlNPT5sCfQM0EmV/lzZByEsRYUM+6nT0mXOdltLtxKKchUz56FYikxOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8rLge9q+Z5r3CCacFr+6URBJ82VVQkgKYduP6pkWNY=;
 b=GYveXvTGNBkZkTL+u5Iq6FfTzxG/3SClIEEscK7J5RvA7TcAR12rVUshNyxMeMtDA1ZSHoMOz7SmS0Kbxq6f35gF4NFIE7MIIZ13/T8Ro6/Un4qwtuLlk3TqhlCYCVTd5P5BMZd1g4txiXtU70bFt2ZLHQvoxntfcJGeAZcMzqU=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB6696.apcprd03.prod.outlook.com (2603:1096:400:1f0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 03:35:16 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6609.026; Wed, 26 Jul 2023
 03:35:16 +0000
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
Subject: Re: [PATCH v3, 3/3] drm/mediatek: dp: Add the audio divider to
 mtk_dp_data struct
Thread-Topic: [PATCH v3, 3/3] drm/mediatek: dp: Add the audio divider to
 mtk_dp_data struct
Thread-Index: AQHZuuPqyAzlk0hbbUG9GpBzJMAaqK/LbpmA
Date:   Wed, 26 Jul 2023 03:35:16 +0000
Message-ID: <a9d1b9b7ef4780f51574d0bbbe28f6dd109a6ab8.camel@mediatek.com>
References: <20230720082604.18618-1-shuijing.li@mediatek.com>
         <20230720082604.18618-4-shuijing.li@mediatek.com>
In-Reply-To: <20230720082604.18618-4-shuijing.li@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB6696:EE_
x-ms-office365-filtering-correlation-id: a09e2126-0f73-4c84-d18f-08db8d895435
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mBDImGPP5C8sQoPtplr2gDJCll47LWdfAWD4ougzW3Bf1PAWBjaBgG94+IdqWqSSyikfWDQomunJJ++7OCl7ki1N07K6brfPkXYsQ3BA/AW8UzUVq6ff84RC2hb+uXFhXOJNwFFhm6GkodT/4Xp1ymGMozm1KxXrbSb3YHog1aI+BFvNlVcXfGdS2iJxs2RrZbBc6pLmU0Buu7TYpe5rjipBwE0cxEEFs3piSrDty8lCK6IMyLhgGQigatliY5qGAiRF0t5XdYDIwZCVOWaqEHclR65m/poUG6mRsBuLepmFuCnyhqoMiVSRp+Qs/OqU5vg+lFstpaYKZUepS23ZYw9Ho4dFuBR7/ZwrDC7tBiGGAVsXqkyHIYjo4flLlTpSa+3e7ooklwFE3ml/R/XPCdUjRS5ozmnSepPMSLupYhHOfJAJ/cb8w6wHLojKsKUUivackEzkRWOrbS2uFHX10bSkXOt0MMcxpswKP4fCBuRDyuGtDejZ6Mvj/jr+6pSb1u68rE1hB9tHRKHTeJcLw2uZIovxmQwWskqFdAdRhIBkwdAUF57MsPCJDeIGICgeJmNIzsW0fPTFTfZ1K/MqQp8VLSbVmZcCGAdS8yCKetlie9EEwAA03LXme/L0Gfnu3F68zFzTx9cBU97juv54pyo3WtsXfApER1qigOxAwqGWX5Oh3g16ixUuHbIayYopnEZ/1v8lWzndfgIT9356ig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199021)(54906003)(110136005)(966005)(6512007)(107886003)(26005)(6506007)(85182001)(921005)(71200400001)(38100700002)(122000001)(478600001)(36756003)(6486002)(2616005)(83380400001)(186003)(316002)(66556008)(66946007)(76116006)(41300700001)(66476007)(66446008)(64756008)(4326008)(86362001)(7416002)(5660300002)(8676002)(8936002)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2Y4Tkp2QlpWN3Y2bFlZWkpRdGtYQU95QkFUL2kyT1ZIalAyQVhabG1ub3NQ?=
 =?utf-8?B?a296bXRPOGxGQlZ5MFJDR1NCQkRlUzZId3lWdjhzMnBWc01IQi9oM3VvbmFP?=
 =?utf-8?B?aE80SGNJVytDcURaUkhBZzd3dVVESzlPZDBTbnRVVEJCbXg3OGN1VmZKbG43?=
 =?utf-8?B?SzgvYnJCa04waStzU2s3R0JpcFBXT0NpeTRQMEEwY3BvT0Uwa0FYL3pCMWJH?=
 =?utf-8?B?b0ZYY01RSTBDUjVuR3d4NUxiTTlwdS9KZmNCcnRzbnFJYS9KcHJEWHRyNTRL?=
 =?utf-8?B?TVdFUDM1ME5vWStJaVZMQU0yaTFxemJuQWN4MTB5a1psVGhWbDR2WDl4TTBL?=
 =?utf-8?B?TTBWY3JlRHBYYWE5ZGU0L1Z4ZWpmUVhVRHoycUMvN0VNRmFQV1JXekQ1NHV6?=
 =?utf-8?B?NDNxR1lUeUg5UkIzTFcycHVZTVZNZE9SSktKUmlZb09EcC8raUdUS3dmM1Fq?=
 =?utf-8?B?THlqOTVjeklrZU1iK29DR3B4S1RabUNsYXFEK0Rta2ZLeUxSMGo5eWtWYTdG?=
 =?utf-8?B?YmtvUHZONFF0VkgwVDREZVRvd2FwcTV0TU1reXBtMVdubTFsZjNoWndVdnFH?=
 =?utf-8?B?YkxDcFB3RyszbXpTa0hmRDZHNnA4M2xvOUpPNjk5dGc4NmlIMjdTY1ZtZ0Uz?=
 =?utf-8?B?N0J5cSsxcFNmOGxLcWQrTnNUR1BBR3BFaWY0WHU2WVZ0OVNzbGhEQ2x2NXoz?=
 =?utf-8?B?SWY4TllxT01NNG94Yk9LczJ0ejBkVkk0YWFDcEo2STE1bG1XdUpMK0U0RFRL?=
 =?utf-8?B?MjZYRExpejBlU1o3emJERXhaM2hpcXBmc2ZEMHNGLy96cnRmQkNMYmI4bG5j?=
 =?utf-8?B?TVpnM1QrVVdDYkozSEVuNXp6dUEySnZ2K2FXcE12cmphbGp6TXViTW1OY3dt?=
 =?utf-8?B?TFBJUENDdGFtU1pLQmxLQnpERjU4OEV2QjBSNjErN01nSnZyc2phUmJ2dEVC?=
 =?utf-8?B?c2twcjBpN1dReGVuSGUvdCt2Rm5YTy82Y0ZCalJFTzI0OGxlRXZ2QUpEYmJL?=
 =?utf-8?B?dFVRdnpmVWFmblNwb3E5UTJYa1YrL2cxR2xacDRoYWRxeHZUQjN5NzZnZVI1?=
 =?utf-8?B?dUk4bEJDNVNwYXZoYTA4R2o5SkNNMW14bjNSZFlRQ1ZmYk5JWWdrbGQ0blNL?=
 =?utf-8?B?czFPb1NKZTZFdndIci9ENEo2NW9EK0k1UEpCUi9SbG1iOExWQTd3Y0N3Rmox?=
 =?utf-8?B?YXQrQ01pTUVLa0NpV0d6MFM4bUpMekErQUxJOGRUdlVvek9rWVpFbW14dm9X?=
 =?utf-8?B?ejlUZnJZdmtQWHRkUUVpSGIrbFFTUHJDVk9kQUcyQ2hzZCtTN0JYM0s2STdn?=
 =?utf-8?B?d1FSaTI0T1lsUTg4WUJGTEd3d2pESDB0MWdDWWZBVElHeWJoOXhFZ1c2N3Mv?=
 =?utf-8?B?Y0NmdnRNNTNJTGV4SzRQWlZZZEFDcGlmSTB0OVZET05XTlNGY2k2d29oSXM3?=
 =?utf-8?B?Smdwamd1WDhVNG5VNWl4Z2x6eS9JNlc0dWR4NFJYalRwcDhWVmcrRDAwMDZw?=
 =?utf-8?B?VGdLMGJWbThWcEVjYjNlSDQxaCtKMUs5K2FaNUN4bXpBa2VFcEJrYTZ1eFU2?=
 =?utf-8?B?K29WZjRkK1F0UTREcUx0UjBDbmxRaTZkOU5Fam1TRlRFQTNDM2xTYnIrU1Ux?=
 =?utf-8?B?dDZ4R3VIU1YrOFdmei90YzRkL2kwT1pXVzBhTE5MNll6Nyt2NHNFRnZwOVBj?=
 =?utf-8?B?Y2Y2bDVFN05CWWNmRk9hazBxZXhCa0J1Z2s0dUxrOExWTDZCZmRUMnNCZjRW?=
 =?utf-8?B?RjBjTVFmTTFEcUVaV0ZBZEN1M2NnUE1XT1dobTFmM3BwdDFoSHk5K3RkTDQr?=
 =?utf-8?B?VXlDaEVhb2VuRXZ5cFBSN3VrT0tRYjcyd1NJTHBwUkI4dHlOQ3I5Mnk4MHEz?=
 =?utf-8?B?cmNMS0IxL00ybG5uYXRjczFrd1B2cHhTbjU0cXpJa1NvbmRPNnZHR0h6VkY3?=
 =?utf-8?B?djFJa1FKd2x3WmwwWVQ1cEYzdS84ZEV6Z294TUc4azVLNThzTVVIMVI5K3VS?=
 =?utf-8?B?YjJRQURIMm1GZkFhV1FIWFo1M0Z4aDRLdC9vbGVyckhDaUZJWGpySW9kV3dV?=
 =?utf-8?B?d1VUMGxmb3MyTnR2R0h0ZWlLMVdMOG9iQnQrVkFjZUZHTlpXVDNoNkVTOVZx?=
 =?utf-8?Q?zJZco6mons6DR53LSgj7s3Hp7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8081A0F0C6144042A1292F5590C26AE1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a09e2126-0f73-4c84-d18f-08db8d895435
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 03:35:16.5728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cDp/mhp+kte78KFbrvjiGQRwUP3nQivHd3Vn6dgp6Uy04yGD9MkZXFwhLQe33P1eeACxSuIbrcEcf9CWSt+n+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6696
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNodWlqaW5nOg0KDQpPbiBUaHUsIDIwMjMtMDctMjAgYXQgMTY6MjYgKzA4MDAsIFNodWlq
aW5nIExpIHdyb3RlOg0KPiBEdWUgdG8gdGhlIGRpZmZlcmVuY2Ugb2YgSFcsIGRpZmZlcmVudCBk
aXZpZGVycyBuZWVkIHRvIGJlIHNldC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNodWlqaW5nIExp
IDxzaHVpamluZy5saUBtZWRpYXRlay5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEppdGFvIFNoaSA8
aml0YW8uc2hpQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjM6DQo+IFNlcGFy
YXRlIHRoZXNlIHR3byB0aGluZ3MgaW50byB0d28gZGlmZmVyZW50IHBhdGNoZXMuDQo+IHBlciBz
dWdnZXN0aW9uIGZyb20gdGhlIHByZXZpb3VzIHRocmVhZDoNCj4gDQpodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9sa21sL2UyYWQyMmJjYmEzMTc5N2YzOGExMmE0ODhkNDI0NmEwMWJmMGNiMmUuY2Ft
ZWxAbWVkaWF0ZWsuY29tLw0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIGNoYW5nZSB0aGUgdmFyaWFi
bGVzJyBuYW1lIHRvIGJlIG1vcmUgZGVzY3JpcHRpdmUNCj4gLSBhZGQgYSBjb21tZW50IHRoYXQg
ZGVzY3JpYmVzIHRoZSBmdW5jdGlvbiBvZg0KPiBtdGtfZHBfYXVkaW9fc2FtcGxlX2FycmFuZ2UN
Cj4gLSByZWR1Y2UgaW5kZW50YXRpb24gYnkgZG9pbmcgdGhlIGludmVyc2UgY2hlY2sNCj4gLSBh
ZGQgYSBkZWZpbml0aW9uIG9mIHNvbWUgYml0cw0KPiAtIGFkZCBzdXBwb3J0IGZvciBtZWRpYXRl
aywgbXQ4MTg4LWVkcC10eA0KPiBwZXIgc3VnZ2VzdGlvbiBmcm9tIHRoZSBwcmV2aW91cyB0aHJl
YWQ6DQo+IA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9hYzBmY2VjOS1hMmZlLTA2Y2Mt
YzcyNy0xODllZjdiYWJlOWNAY29sbGFib3JhLmNvbS8NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RwLmMgICAgIHwgNyArKysrKystDQo+ICBkcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RwX3JlZy5oIHwgMSArDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHAuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAu
Yw0KPiBpbmRleCBkOGNkYTgzZDZmZWYuLjhlMWExM2FiMmJhMiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHAuYw0KPiBAQCAtMTQwLDYgKzE0MCw3IEBAIHN0cnVjdCBtdGtfZHBfZGF0
YSB7DQo+ICAJY29uc3Qgc3RydWN0IG10a19kcF9lZnVzZV9mbXQgKmVmdXNlX2ZtdDsNCj4gIAli
b29sIGF1ZGlvX3N1cHBvcnRlZDsNCj4gIAlib29sIGF1ZGlvX3BrdF9pbl9oYmxhbmtfYXJlYTsN
Cj4gKwl1MTYgYXVkaW9fbV9kaXYyX2JpdDsNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgbXRrX2RwX2VmdXNlX2ZtdA0KPiBtdDgxOTVfZWRwX2VmdXNlX2ZtdFtNVEtfRFBfQ0FM
X01BWF0gPSB7DQo+IEBAIC02NDgsNyArNjQ5LDcgQEAgc3RhdGljIHZvaWQNCj4gbXRrX2RwX2F1
ZGlvX3NkcF9hc3Bfc2V0X2NoYW5uZWxzKHN0cnVjdCBtdGtfZHAgKm10a19kcCwNCj4gIHN0YXRp
YyB2b2lkIG10a19kcF9hdWRpb19zZXRfZGl2aWRlcihzdHJ1Y3QgbXRrX2RwICptdGtfZHApDQo+
ICB7DQo+ICAJbXRrX2RwX3VwZGF0ZV9iaXRzKG10a19kcCwgTVRLX0RQX0VOQzBfUDBfMzBCQywN
Cj4gLQkJCSAgIEFVRElPX01fQ09ERV9NVUxUX0RJVl9TRUxfRFBfRU5DMF9QMF9ESVZfMiwNCj4g
KwkJCSAgIG10a19kcC0+ZGF0YS0+YXVkaW9fbV9kaXYyX2JpdCwNCj4gIAkJCSAgIEFVRElPX01f
Q09ERV9NVUxUX0RJVl9TRUxfRFBfRU5DMF9QMF9NQVNLKTsNCj4gIH0NCj4gIA0KPiBAQCAtMjYz
Niw2ICsyNjM3LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZHBfZGF0YSBtdDgxODhfZWRw
X2RhdGENCj4gPSB7DQo+ICAJLmVmdXNlX2ZtdCA9IG10ODE5NV9lZHBfZWZ1c2VfZm10LA0KPiAg
CS5hdWRpb19zdXBwb3J0ZWQgPSBmYWxzZSwNCj4gIAkuYXVkaW9fcGt0X2luX2hibGFua19hcmVh
ID0gZmFsc2UsDQo+ICsJLmF1ZGlvX21fZGl2Ml9iaXQgPQ0KPiBNVDgxODhfQVVESU9fTV9DT0RF
X01VTFRfRElWX1NFTF9EUF9FTkMwX1AwX0RJVl8yLA0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGNv
bnN0IHN0cnVjdCBtdGtfZHBfZGF0YSBtdDgxODhfZHBfZGF0YSA9IHsNCj4gQEAgLTI2NDQsNiAr
MjY0Niw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RwX2RhdGEgbXQ4MTg4X2RwX2RhdGEN
Cj4gPSB7DQo+ICAJLmVmdXNlX2ZtdCA9IG10ODE5NV9kcF9lZnVzZV9mbXQsDQo+ICAJLmF1ZGlv
X3N1cHBvcnRlZCA9IHRydWUsDQo+ICAJLmF1ZGlvX3BrdF9pbl9oYmxhbmtfYXJlYSA9IHRydWUs
DQo+ICsJLmF1ZGlvX21fZGl2Ml9iaXQgPQ0KPiBNVDgxODhfQVVESU9fTV9DT0RFX01VTFRfRElW
X1NFTF9EUF9FTkMwX1AwX0RJVl8yLA0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVj
dCBtdGtfZHBfZGF0YSBtdDgxOTVfZWRwX2RhdGEgPSB7DQo+IEBAIC0yNjUyLDYgKzI2NTUsNyBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kcF9kYXRhIG10ODE5NV9lZHBfZGF0YQ0KPiA9IHsN
Cj4gIAkuZWZ1c2VfZm10ID0gbXQ4MTk1X2VkcF9lZnVzZV9mbXQsDQo+ICAJLmF1ZGlvX3N1cHBv
cnRlZCA9IGZhbHNlLA0KPiAgCS5hdWRpb19wa3RfaW5faGJsYW5rX2FyZWEgPSBmYWxzZSwNCj4g
KwkuYXVkaW9fbV9kaXYyX2JpdCA9IEFVRElPX01fQ09ERV9NVUxUX0RJVl9TRUxfRFBfRU5DMF9Q
MF9ESVZfMiwNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RwX2RhdGEg
bXQ4MTk1X2RwX2RhdGEgPSB7DQo+IEBAIC0yNjYwLDYgKzI2NjQsNyBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IG10a19kcF9kYXRhIG10ODE5NV9kcF9kYXRhDQo+ID0gew0KPiAgCS5lZnVzZV9mbXQg
PSBtdDgxOTVfZHBfZWZ1c2VfZm10LA0KPiAgCS5hdWRpb19zdXBwb3J0ZWQgPSB0cnVlLA0KPiAg
CS5hdWRpb19wa3RfaW5faGJsYW5rX2FyZWEgPSBmYWxzZSwNCj4gKwkuYXVkaW9fbV9kaXYyX2Jp
dCA9IEFVRElPX01fQ09ERV9NVUxUX0RJVl9TRUxfRFBfRU5DMF9QMF9ESVZfMiwNCj4gIH07DQo+
ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19kcF9vZl9tYXRjaFtd
ID0gew0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcF9yZWcu
aA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBfcmVnLmgNCj4gaW5kZXggZjM4
ZDZmZjEyYWZlLi42ZDdmMDQwNTg2N2UgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHBfcmVnLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcF9yZWcuaA0KPiBAQCAtMTYyLDYgKzE2Miw3IEBADQo+ICAjZGVmaW5lIEFVRElPX01fQ09E
RV9NVUxUX0RJVl9TRUxfRFBfRU5DMF9QMF9NVUxfMgkoMSA8PCA4KQ0KPiAgI2RlZmluZSBBVURJ
T19NX0NPREVfTVVMVF9ESVZfU0VMX0RQX0VOQzBfUDBfTVVMXzQJKDIgPDwgOCkNCj4gICNkZWZp
bmUgQVVESU9fTV9DT0RFX01VTFRfRElWX1NFTF9EUF9FTkMwX1AwX01VTF84CSgzIDw8IDgpDQo+
ICsjZGVmaW5lIE1UODE4OF9BVURJT19NX0NPREVfTVVMVF9ESVZfU0VMX0RQX0VOQzBfUDBfRElW
XzIJKDQgPDwNCj4gOCkNCg0KRm9yIEFVRElPX01fQ09ERV9NVUxUX0RJVl9TRUxfRFBfRU5DMF9Q
MF8qLCBhZGQgcHJlZml4ICdNVDgxOTVfJy4NCkFuZCBsaXN0IGFsbCBjb25maWd1cmF0aW9uIGZv
ciBNVDgxODguDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICAjZGVmaW5lIEFVRElPX01fQ09ERV9NVUxU
X0RJVl9TRUxfRFBfRU5DMF9QMF9ESVZfMgkoNSA8PCA4KQ0KPiAgI2RlZmluZSBBVURJT19NX0NP
REVfTVVMVF9ESVZfU0VMX0RQX0VOQzBfUDBfRElWXzQJKDYgPDwgOCkNCj4gICNkZWZpbmUgQVVE
SU9fTV9DT0RFX01VTFRfRElWX1NFTF9EUF9FTkMwX1AwX0RJVl84CSg3IDw8IDgpDQo=

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6840C7D6406
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjJYHuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjJYHuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:50:50 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30341BE;
        Wed, 25 Oct 2023 00:50:46 -0700 (PDT)
X-UUID: 3211df6e730b11eea33bb35ae8d461a2-20231025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=xXHmzDsdgXKXsLcoQtsjJMndzgChQ5ZkMPwrPxrcneU=;
        b=fhoLZJuG46ayphgKQRCXUSvZ5Er9/Gv8boA7vsNPy27JwAlJEn+SqhcJKM+IHoayfHqBpp08xP0El8zCfD0pFr8+tTV+BBL8UkdOQXv6oIEC6Fh1ipSZqn4huC0Ad6YcunCYnVAZOpVZyd5yMWpa/lVzKTJxcexdjt3LANj+DAo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:2515060e-1ca3-4492-a674-50a2845ee340,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:fd03c0fb-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3211df6e730b11eea33bb35ae8d461a2-20231025
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1995975017; Wed, 25 Oct 2023 15:50:41 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Oct 2023 15:50:40 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 25 Oct 2023 15:50:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkgGmFPpyulTd12T1fVjtqm1JyQVT+NfCOdo07KgRPijgFZMymTOU/cMRQBQL4lzjM7auRj9LT+3O4jTIQmU9pMq226Bh1evx8Xo9GDqsyrIjKoexxUuXVyR3ljFu0iF5Q0FVfHiYbuEpbkq4qLxuQEVJt7NY9WXso8Fa54Yq5umeqlX2NZiBdiqUi7l5fEGfJltZ8U2gfqNbcjTNISTTMfuaWm4d+5OJg1+/EyJmWE8uCilai7HxsaADaXv6LO2pUSN1m/H04qaR3vBfc52vLFNDHKxHSTc6plgF+6M60mGLaTYiNN8TfOSdpBv4hx+gKIQGni1q3RZQ4aQNjSP8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXHmzDsdgXKXsLcoQtsjJMndzgChQ5ZkMPwrPxrcneU=;
 b=VbAv7U8Jn/6cF+WjxmVvnkWbjotPEfM1lFNHb2BGYkggQXCN4xL4lzCb6rqY/yCnZc12cuC+HYqby1nNqZtRY7z/NFIE5rBPydcUgRmtCSLIS/4qfShQu2bgExHx69iAPOHAORRw2oAB2n5Uf6024RrLuU2SpN4ndtUJ4aYncJTonALKdkNCzJZcHRzJj/QHN3rHsrnt1XBybRJ1INu0iliG6niHTsob2c2kz9Y5cH1E6nHoXxgTczJ/DEiCvzTtbQq8XYpVRYXBr3oDszLoq0kmma3XlWOgc4jbaUjY9GoX1UkZrOD6cDNALPfV7CXKImk304zbCmSafTtPHuQueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXHmzDsdgXKXsLcoQtsjJMndzgChQ5ZkMPwrPxrcneU=;
 b=jzMCQsefGveu5/bqSGxvbzUrn2cx0UZqHzg7A2pUrhmq/41TBL1UUDD8PrDYgsbWdIgvA2DYpHEz//PfFQy7zjpJtr3ZNRLafbIBS24hHFiiredxLRGrK2Bj8RIRe4blMgqhyrkHX51Ebo5j5oHYld4xLVNffcW8UeOuMbtqxe0=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by PUZPR03MB7091.apcprd03.prod.outlook.com (2603:1096:301:111::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 07:50:38 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d%7]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 07:50:38 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "jkardatzke@google.com" <jkardatzke@google.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 03/11] drm/mediatek: Add secure buffer control flow to
 mtk_drm_gem
Thread-Topic: [PATCH v2 03/11] drm/mediatek: Add secure buffer control flow to
 mtk_drm_gem
Thread-Index: AQHaBWvpejqAFLfwaESh+dNRl/NLl7BYn98AgAGFK4A=
Date:   Wed, 25 Oct 2023 07:50:38 +0000
Message-ID: <b30c0e4bd64237e60b6e101eb7cbd99ff224dcb1.camel@mediatek.com>
References: <20231023044549.21412-1-jason-jh.lin@mediatek.com>
         <20231023044549.21412-4-jason-jh.lin@mediatek.com>
         <fa495623-1b63-4b94-84b8-c5cf0b9ba0ae@collabora.com>
In-Reply-To: <fa495623-1b63-4b94-84b8-c5cf0b9ba0ae@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|PUZPR03MB7091:EE_
x-ms-office365-filtering-correlation-id: f19313df-74d7-4d14-8a57-08dbd52f1433
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9MxhhVcL3neAzhqYRZHPQTRKLeuvvm1Ft+nIkAL52+D1bjwuoRYx7/0rJ0kGrIFxz00osrpmLZdKL6FTxzcobpVy4osBcpC1oRp2OFqtBaL0Vo0rHLhe0cQHJTrCQQkhOMJlP+HLbu1Vt649PoAXb6J3M2ZpyrBL2mH1nWmeOKQqN7iIP6S0G40pk71V0vN4iZzRDwM8ynPuKIicCQ9260kyPQx2W08/jzWS3SSIiWMHGHgZMvRhLOw+LGkGf2YsdVKIfh2o32QYgybOfukFlvJQMwzgv4fdH0LpMesnJ6d3zbP6HSUI5PUN+K5il8gGynM4bnofAQ3He3VF9lKttQSQlEXsvjVWD4xTg7+cMCXBSq9zSmeK3GkOKTS6JJOWduj4YX5WYhwyntJQ5NmuYPLM/1eXysHnpIXQyUdTpjdb32su003DBeQVVWDrkwkJb+KlULDGZTEa3CKMW2VxUdDsVx6J4EsVYZXPaODXgF7KsnEvtFBoaHTc5RjoSb7ZhiX1r2ZYahl7Y4zFTZEgpXrv4W8wiksEMaoSwALaBaMa5cjPwNHBgVtS+Q8dGb8hc/KK7I3B87KpXnLhtK+OL0WJ5Tg3ZY04K3OHjny7z0pUfnDU3FPl9kEW7fBLfRgzNmIHjLjZg5FyY+fhaxQogKePrhjq8cOfAsvd4cYtta8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(136003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(54906003)(64756008)(66556008)(66476007)(66446008)(83380400001)(26005)(316002)(478600001)(76116006)(91956017)(110136005)(66946007)(2616005)(2906002)(4326008)(8936002)(8676002)(71200400001)(41300700001)(7416002)(38070700009)(5660300002)(4001150100001)(6506007)(6512007)(38100700002)(122000001)(6486002)(86362001)(36756003)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emVMZFRYVzM4SkVYZm52SDFkWUU3NzE2bXpIMGVrT2NPWm4vS1BDekpXVjdT?=
 =?utf-8?B?UnlXT2pCTzJ5bXpIaWNVaEZmY3FSZjF1bW04eERRZ0doQkNRV2kyQTVlVk5S?=
 =?utf-8?B?Z2J2em9EVUFlc2puSnlPaGN6T20yQnNVWEtvRkwvOVBWV21hMjJPcnkxeTd3?=
 =?utf-8?B?MEFmOUM3M3N3dG5tQUtUY1dwRzRTc2RxZTRXUHc5ejJQWjhIWlNBdkt2WkEy?=
 =?utf-8?B?WDNJbEhBbnZxOFJEQXE1cDZLYW1IaEttOWdSazZQSUR0OFNZWk8vdkJ2Z2ps?=
 =?utf-8?B?T2pjSkhLcTJ5STkzSnV5K3NHUlovVUdQRnNuOWRxMUhCcTRneUtGa3gxWkRX?=
 =?utf-8?B?RnJCNnlMayt5R05Vcmt0cUdBaC8yTEtCQTFwaXZ2NGxlR2tHN2kvOFhYYUcw?=
 =?utf-8?B?d3RrTmlZellWZStoRUs5ZCtLdmFCWi90MzNvSmE3Qitic2xzZzZ5QTFncEYx?=
 =?utf-8?B?QitZS09lTnIxbkQ4c3RjRkZEL1M5SVU0dlFNb2E1TUhnVGwwWklCYlZ0SUpw?=
 =?utf-8?B?Mm1PTklicHUzbUI5MGNmZDR2SmVLSm9sOTk1YmtSaVU1TGE1dWJ5WXlOMXc0?=
 =?utf-8?B?bDAyM0IzcGs4OWR3ZzFsbi9kR0lLSW12U0Mvb0lrNmMyTHdsZ2NrY1RvVjRE?=
 =?utf-8?B?NTYxbGdwOWlBSEdtcHFZN3FoWWtpckZydG5QbjdrR3g3QTBLRXhKWHdVbVRr?=
 =?utf-8?B?bXJWaUorQlN2RDFucjVrOUsvVys5UGtMN3cxSitETW5KZHVuWGZmQmxXZXUv?=
 =?utf-8?B?Lzg0YTZXWHBVVEo0cDB4emlLeEh5cG53RGJGTHViajhaQnppUFVNUElVVDdP?=
 =?utf-8?B?WnpvN01KSmM2UjFvR0phU2t5eTJaMmZKSzNSWkI1a2dkWmdEZ0t2Ujc4L2dE?=
 =?utf-8?B?QytwcEJhdmFTcUQ5S0VRdWF5OWZwa1VxQVV2bGJSWXNzZGN3bzFPNDNVOXNj?=
 =?utf-8?B?ZklGVitiQkdMdzJDaUJIK0VVSTdSaC9MYS9STVdSejRTUkFTUFdLd2tidWxL?=
 =?utf-8?B?OEpFRzVZWE0yL2FiV1hiU1NDajFVeTRVbU5NdkZ6SWlLYUpTTVorWUVUOElP?=
 =?utf-8?B?TGd0L1hFbVUyMjBPQnNVT3JzZTM1eG1Vb2dEeFg3blAyMForZEdOdmFtMXlz?=
 =?utf-8?B?R3RmZWI4WWUvQjRhWmRpdXRNTlB4dVp3M0VxdTZHWGR6QUxTRmxWYmlSeUhC?=
 =?utf-8?B?anA3RlJRNlhNTEVzUUgrUGRBb2pjWW5PdXphc2syTU9oTDJSM1Q5eTFwSy9z?=
 =?utf-8?B?VWxOT2VFN3FYcVpPN3QzbG8yYUVpSUthWEM0TEhNMk80Z0Ztek5Qb0FoMW5x?=
 =?utf-8?B?Z0l4dmhFamQydFVpbXhreVByYS9IZ2VnK3Q1aDdmeTFSakxKYkY3Q1hZekpp?=
 =?utf-8?B?V0tVRXRwOXBwTW5Rd1hiN1Q0ZGlVV1EwMVdyVmxIaS9OM2Yxb3QwSWZRWjBG?=
 =?utf-8?B?VzNlQW0zNFNWVmxnV2tyTWlrTzVaNHR2MFZMNWtodG9oRm9OdFVLUkZTSnFq?=
 =?utf-8?B?bGdHYmdYWktiK2dDZE83dGN2bW1XOXpyQmhEYkpTNTVEaEFKb1IyME1VdXlG?=
 =?utf-8?B?ZVB4dFM5TEJsQVRHenIzbmE3anJObzRoaHg0WmJTU1BOVEFiSytTL2pmd3hw?=
 =?utf-8?B?QzVHclUyZUsrTTMxRFFSZ3pPeTlkMXVBUDdlZkovVWhqMURQYlJUMTc1VXJQ?=
 =?utf-8?B?UzQ0QXVZZk0rOXdZRnBvUnE4ODNVVTNqL2djVTFxUjVtaGY5N3pVaDdGeUpi?=
 =?utf-8?B?RTl2Q3BVVG5NVWdTRFRWUEExTVJQTGl6L1Q1eEVNclBUQ2lKVXhBWTJIVHVj?=
 =?utf-8?B?dTNMa2FSK0NnQnE3L2g4dTVJZDllaVFkMGN2RjFNZGFmQ0xSVFpiSTk1Wk5p?=
 =?utf-8?B?TVZsRWR1ci9NWkFQN1drbStqTG9EVy94d21xQjYySHo2MUlSME9QeGt6ZlIv?=
 =?utf-8?B?bjRhSlIyeFdDZ2RRd0prYWtiT0QwVlJJcTJ0N2pIbHNNY3RxTFhVYTZJeEVn?=
 =?utf-8?B?elJWOFpXZ1llaEptaTQyUi9DL2ozdVlJK0FPMDh0VlJpOGZLVDUrSEQ2bEQz?=
 =?utf-8?B?cmhTVmFPY29xbGNDaGxtZDE5bEozNDdEYllpMjZ3bFRXbk81RFltc3NWUk05?=
 =?utf-8?B?MDQ3WGNCYVJLVFVoc2pFOUxGOVk1SHlCdUkzd2pkYlByUHJGVGpidURHSDJU?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <795A1DE1F317434393BA0C7BABF1DC77@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f19313df-74d7-4d14-8a57-08dbd52f1433
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 07:50:38.2144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /hrf5AVnGGwrLRT+3MeH2SahQENtJqVGkJQIjG5ccB5eBCs3A2gOOp9QH/AJd0nCXmuVXP4DhjE60e1HwcV2cJ09RatsaZJVw3fsw5yL1iM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpPbiBUdWUsIDIwMjMtMTAt
MjQgYXQgMTA6MzcgKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJ
bCAyMy8xMC8yMyAwNjo0NSwgSmFzb24tSkguTGluIGhhIHNjcml0dG86DQo+ID4gQWRkIHNlY3Vy
ZSBidWZmZXIgY29udHJvbCBmbG93IHRvIG10a19kcm1fZ2VtLg0KPiA+IA0KPiA+IFdoZW4gdXNl
ciBzcGFjZSB0YWtlcyBEUk1fTVRLX0dFTV9DUkVBVEVfRU5DUllQVEVEIGZsYWcgYW5kIHNpemUN
Cj4gPiB0byBjcmVhdGUgYSBtdGtfZHJtX2dlbSBvYmplY3QsIG10a19kcm1fZ2VtIHdpbGwgZmlu
ZCBhIG1hdGNoZWQNCj4gPiBzaXplDQo+ID4gZG1hIGJ1ZmZlciBmcm9tIHNlY3VyZSBkbWEtaGVh
cCBhbmQgYmluZCBpdCB0byBtdGtfZHJtX2dlbSBvYmplY3QuDQo+ID4gDQo+ID4gU2lnbmVkLW9m
Zi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0K
PiA+ICAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZ2VtLmMgfCA4NA0KPiA+ICsr
KysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RybV9nZW0uaCB8ICA0ICsrDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDg3IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fZ2VtLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX2dlbS5jDQo+ID4gaW5kZXggYmNjZTcyM2YyNTdkLi4yMDY0Y2NkN2RkZTAgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZ2VtLmMNCj4g
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9nZW0uYw0KPiA+IEBAIC00
LDYgKzQsOCBAQA0KPiA+ICAgICovDQo+ID4gICANCj4gPiAgICNpbmNsdWRlIDxsaW51eC9kbWEt
YnVmLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9kbWEtaGVhcC5oPg0KPiA+ICsjaW5jbHVkZSA8
dWFwaS9saW51eC9kbWEtaGVhcC5oPg0KPiA+ICAgI2luY2x1ZGUgPGRybS9tZWRpYXRla19kcm0u
aD4NCj4gPiAgIA0KPiA+ICAgI2luY2x1ZGUgPGRybS9kcm0uaD4NCj4gPiBAQCAtNTUsNiArNTcs
ODAgQEAgc3RhdGljIHN0cnVjdCBtdGtfZHJtX2dlbV9vYmoNCj4gPiAqbXRrX2RybV9nZW1faW5p
dChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LA0KPiA+ICAgCXJldHVybiBtdGtfZ2VtX29iajsNCj4g
PiAgIH0NCj4gPiAgIA0KPiA+ICtzdHJ1Y3QgbXRrX2RybV9nZW1fb2JqICptdGtfZHJtX2dlbV9j
cmVhdGVfZnJvbV9oZWFwKHN0cnVjdA0KPiA+IGRybV9kZXZpY2UgKmRldiwNCj4gPiArCQkJCQkJ
ICAgICBjb25zdCBjaGFyICpoZWFwLA0KPiA+IHNpemVfdCBzaXplKQ0KPiA+ICt7DQo+ID4gKwlz
dHJ1Y3QgbXRrX2RybV9wcml2YXRlICpwcml2ID0gZGV2LT5kZXZfcHJpdmF0ZTsNCj4gPiArCXN0
cnVjdCBtdGtfZHJtX2dlbV9vYmogKm10a19nZW07DQo+ID4gKwlzdHJ1Y3QgZHJtX2dlbV9vYmpl
Y3QgKm9iajsNCj4gPiArCXN0cnVjdCBkbWFfaGVhcCAqZG1hX2hlYXA7DQo+ID4gKwlzdHJ1Y3Qg
ZG1hX2J1ZiAqZG1hX2J1ZjsNCj4gPiArCXN0cnVjdCBkbWFfYnVmX2F0dGFjaG1lbnQgKmF0dGFj
aDsNCj4gPiArCXN0cnVjdCBzZ190YWJsZSAqc2d0Ow0KPiA+ICsJc3RydWN0IGlvc3lzX21hcCBt
YXAgPSB7fTsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJbXRrX2dlbSA9IG10a19kcm1f
Z2VtX2luaXQoZGV2LCBzaXplKTsNCj4gPiArCWlmIChJU19FUlIobXRrX2dlbSkpDQo+ID4gKwkJ
cmV0dXJuIEVSUl9DQVNUKG10a19nZW0pOw0KPiA+ICsNCj4gPiArCW9iaiA9ICZtdGtfZ2VtLT5i
YXNlOw0KPiA+ICsNCj4gPiArCWRtYV9oZWFwID0gZG1hX2hlYXBfZmluZChoZWFwKTsNCj4gPiAr
CWlmICghZG1hX2hlYXApIHsNCj4gPiArCQlEUk1fRVJST1IoImhlYXAgZmluZCBmYWlsXG4iKTsN
Cj4gPiArCQlnb3RvIGVycl9nZW1fZnJlZTsNCj4gPiArCX0NCj4gPiArCWRtYV9idWYgPSBkbWFf
aGVhcF9idWZmZXJfYWxsb2MoZG1hX2hlYXAsIHNpemUsDQo+ID4gKwkJCQkJT19SRFdSIHwgT19D
TE9FWEVDLA0KPiA+IERNQV9IRUFQX1ZBTElEX0hFQVBfRkxBR1MpOw0KPiA+ICsJaWYgKElTX0VS
UihkbWFfYnVmKSkgew0KPiA+ICsJCURSTV9FUlJPUigiYnVmZmVyIGFsbG9jIGZhaWxcbiIpOw0K
PiA+ICsJCWRtYV9oZWFwX3B1dChkbWFfaGVhcCk7DQo+ID4gKwkJZ290byBlcnJfZ2VtX2ZyZWU7
DQo+ID4gKwl9DQo+ID4gKwlkbWFfaGVhcF9wdXQoZG1hX2hlYXApOw0KPiA+ICsNCj4gPiArCWF0
dGFjaCA9IGRtYV9idWZfYXR0YWNoKGRtYV9idWYsIHByaXYtPmRtYV9kZXYpOw0KPiA+ICsJaWYg
KElTX0VSUihhdHRhY2gpKSB7DQo+ID4gKwkJRFJNX0VSUk9SKCJhdHRhY2ggZmFpbCwgcmV0dXJu
XG4iKTsNCj4gPiArCQlkbWFfYnVmX3B1dChkbWFfYnVmKTsNCj4gPiArCQlnb3RvIGVycl9nZW1f
ZnJlZTsNCj4gPiArCX0NCj4gDQo+IGJsYW5rIGxpbmUgaGVyZSBwbGVhc2UNCg0KT0ssIEknbGwg
YWRkIG9uZSBibGFuay4NCg0KPiANCj4gPiArCXNndCA9IGRtYV9idWZfbWFwX2F0dGFjaG1lbnQo
YXR0YWNoLCBETUFfQklESVJFQ1RJT05BTCk7DQo+ID4gKwlpZiAoSVNfRVJSKHNndCkpIHsNCj4g
PiArCQlEUk1fRVJST1IoIm1hcCBmYWlsZWQsIGRldGFjaCBhbmQgcmV0dXJuXG4iKTsNCj4gPiAr
CQlkbWFfYnVmX2RldGFjaChkbWFfYnVmLCBhdHRhY2gpOw0KPiA+ICsJCWRtYV9idWZfcHV0KGRt
YV9idWYpOw0KPiA+ICsJCWdvdG8gZXJyX2dlbV9mcmVlOw0KPiA+ICsJfQ0KPiA+ICsJb2JqLT5p
bXBvcnRfYXR0YWNoID0gYXR0YWNoOw0KPiA+ICsJbXRrX2dlbS0+ZG1hX2FkZHIgPSBzZ19kbWFf
YWRkcmVzcyhzZ3QtPnNnbCk7DQo+ID4gKwltdGtfZ2VtLT5zZyA9IHNndDsNCj4gPiArCW10a19n
ZW0tPnNpemUgPSBkbWFfYnVmLT5zaXplOw0KPiA+ICsNCj4gPiArCWlmICghc3RyY21wKGhlYXAs
ICJtdGtfc3ZwIikgfHwgIXN0cmNtcChoZWFwLCAibXRrX3N2cF9jbWEiKSkgew0KPiA+ICsJCS8q
IHNlY3VyZSBidWZmZXIgY2FuIG5vdCBiZSBtYXBwZWQgKi8NCj4gPiArCQltdGtfZ2VtLT5zZWMg
PSB0cnVlOw0KPiA+ICsJfSBlbHNlIHsNCj4gPiArCQlyZXQgPSBkbWFfYnVmX3ZtYXAoZG1hX2J1
ZiwgJm1hcCk7DQo+ID4gKwkJbXRrX2dlbS0+a3ZhZGRyID0gbWFwLnZhZGRyOw0KPiA+ICsJCWlm
IChyZXQpIHsNCj4gPiArCQkJRFJNX0VSUk9SKCJtYXAgZmFpbGVkLCByZXQ9JWRcbiIsIHJldCk7
DQo+ID4gKwkJCWRtYV9idWZfdW5tYXBfYXR0YWNobWVudChhdHRhY2gsIHNndCwNCj4gPiBETUFf
QklESVJFQ1RJT05BTCk7DQo+ID4gKwkJCWRtYV9idWZfZGV0YWNoKGRtYV9idWYsIGF0dGFjaCk7
DQo+ID4gKwkJCWRtYV9idWZfcHV0KGRtYV9idWYpOw0KPiA+ICsJCQltdGtfZ2VtLT5rdmFkZHIg
PSBOVUxMOw0KPiA+ICsJCX0NCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gbXRrX2dlbTsN
Cj4gPiArDQo+ID4gK2Vycl9nZW1fZnJlZToNCj4gPiArCWRybV9nZW1fb2JqZWN0X3JlbGVhc2Uo
b2JqKTsNCj4gPiArCWtmcmVlKG10a19nZW0pOw0KPiA+ICsJcmV0dXJuIEVSUl9QVFIoLUVOT01F
TSk7DQo+ID4gK30NCj4gPiArDQo+ID4gICBzdHJ1Y3QgbXRrX2RybV9nZW1fb2JqICptdGtfZHJt
X2dlbV9jcmVhdGUoc3RydWN0IGRybV9kZXZpY2UNCj4gPiAqZGV2LA0KPiA+ICAgCQkJCQkgICBz
aXplX3Qgc2l6ZSwgYm9vbA0KPiA+IGFsbG9jX2ttYXApDQo+ID4gICB7DQo+ID4gQEAgLTIxOCw3
ICsyOTQsOSBAQCBzdHJ1Y3QgZHJtX2dlbV9vYmplY3QNCj4gPiAqbXRrX2dlbV9wcmltZV9pbXBv
cnRfc2dfdGFibGUoc3RydWN0IGRybV9kZXZpY2UgKmRldiwNCj4gPiAgIAlpZiAoSVNfRVJSKG10
a19nZW0pKQ0KPiA+ICAgCQlyZXR1cm4gRVJSX0NBU1QobXRrX2dlbSk7DQo+ID4gICANCj4gPiAr
CW10a19nZW0tPnNlYyA9ICFzZ19wYWdlKHNnLT5zZ2wpOw0KPiA+ICAgCW10a19nZW0tPmRtYV9h
ZGRyID0gc2dfZG1hX2FkZHJlc3Moc2ctPnNnbCk7DQo+ID4gKwltdGtfZ2VtLT5zaXplID0gYXR0
YWNoLT5kbWFidWYtPnNpemU7DQo+ID4gICAJbXRrX2dlbS0+c2cgPSBzZzsNCj4gPiAgIA0KPiA+
ICAgCXJldHVybiAmbXRrX2dlbS0+YmFzZTsNCj4gPiBAQCAtMjkwLDcgKzM2OCwxMSBAQCBpbnQg
bXRrX2dlbV9jcmVhdGVfaW9jdGwoc3RydWN0IGRybV9kZXZpY2UNCj4gPiAqZGV2LCB2b2lkICpk
YXRhLA0KPiA+ICAgCXN0cnVjdCBkcm1fbXRrX2dlbV9jcmVhdGUgKmFyZ3MgPSBkYXRhOw0KPiA+
ICAgCWludCByZXQ7DQo+ID4gICANCj4gPiAtCW10a19nZW0gPSBtdGtfZHJtX2dlbV9jcmVhdGUo
ZGV2LCBhcmdzLT5zaXplLCBmYWxzZSk7DQo+ID4gKwlpZiAoYXJncy0+ZmxhZ3MgJiBEUk1fTVRL
X0dFTV9DUkVBVEVfRU5DUllQVEVEKQ0KPiA+ICsJCW10a19nZW0gPSBtdGtfZHJtX2dlbV9jcmVh
dGVfZnJvbV9oZWFwKGRldiwNCj4gPiAibXRrX3N2cF9jbWEiLCBhcmdzLT5zaXplKTsNCj4gPiAr
CWVsc2UNCj4gPiArCQltdGtfZ2VtID0gbXRrX2RybV9nZW1fY3JlYXRlKGRldiwgYXJncy0+c2l6
ZSwgZmFsc2UpOw0KPiA+ICsNCj4gPiAgIAlpZiAoSVNfRVJSKG10a19nZW0pKQ0KPiA+ICAgCQly
ZXR1cm4gUFRSX0VSUihtdGtfZ2VtKTsNCj4gPiAgIA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9nZW0uaA0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fZ2VtLmgNCj4gPiBpbmRleCA5MGYzZDI5MTZlYzUuLmVkNGQyM2UyNTJl
OSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9nZW0u
aA0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2dlbS5oDQo+ID4g
QEAgLTI3LDkgKzI3LDExIEBAIHN0cnVjdCBtdGtfZHJtX2dlbV9vYmogew0KPiA+ICAgCXZvaWQJ
CQkqY29va2llOw0KPiA+ICAgCXZvaWQJCQkqa3ZhZGRyOw0KPiA+ICAgCWRtYV9hZGRyX3QJCWRt
YV9hZGRyOw0KPiA+ICsJc2l6ZV90CQkJc2l6ZTsNCj4gPiAgIAl1bnNpZ25lZCBsb25nCQlkbWFf
YXR0cnM7DQo+ID4gICAJc3RydWN0IHNnX3RhYmxlCQkqc2c7DQo+ID4gICAJc3RydWN0IHBhZ2UJ
CSoqcGFnZXM7DQo+ID4gKwlib29sCQkJc2VjOw0KPiANCj4gYHNlY2AgbWF5IGJlIGFtYmlndW91
cy4gWW91IGNhbiBjYWxsIHRoYXQgYHNlY3VyZWAgb3INCj4gYGlzX3NlY3VyZV9idWZgLg0KPiAN
Ck9LLCBJJ2xsIGNoYW5nZSBpdCB0byBgc2VjdXJlYC4NCg0KUmVnYXJkcywNCkphc29uLUpILkxp
bg0KDQo+ID4gICB9Ow0KPiA+ICAgDQo+ID4gICAjZGVmaW5lIHRvX210a19nZW1fb2JqKHgpCWNv
bnRhaW5lcl9vZih4LCBzdHJ1Y3QgbXRrX2RybV9nZW1fb2JqLA0KPiA+IGJhc2UpDQo+ID4gQEAg
LTM3LDYgKzM5LDggQEAgc3RydWN0IG10a19kcm1fZ2VtX29iaiB7DQo+ID4gICB2b2lkIG10a19k
cm1fZ2VtX2ZyZWVfb2JqZWN0KHN0cnVjdCBkcm1fZ2VtX29iamVjdCAqZ2VtKTsNCj4gPiAgIHN0
cnVjdCBtdGtfZHJtX2dlbV9vYmogKm10a19kcm1fZ2VtX2NyZWF0ZShzdHJ1Y3QgZHJtX2Rldmlj
ZQ0KPiA+ICpkZXYsIHNpemVfdCBzaXplLA0KPiA+ICAgCQkJCQkgICBib29sIGFsbG9jX2ttYXAp
Ow0KPiA+ICtzdHJ1Y3QgbXRrX2RybV9nZW1fb2JqICptdGtfZHJtX2dlbV9jcmVhdGVfZnJvbV9o
ZWFwKHN0cnVjdA0KPiA+IGRybV9kZXZpY2UgKmRldiwNCj4gPiArCQkJCQkJICAgICBjb25zdCBj
aGFyICpoZWFwLA0KPiA+IHNpemVfdCBzaXplKTsNCj4gPiAgIGludCBtdGtfZHJtX2dlbV9kdW1i
X2NyZWF0ZShzdHJ1Y3QgZHJtX2ZpbGUgKmZpbGVfcHJpdiwgc3RydWN0DQo+ID4gZHJtX2Rldmlj
ZSAqZGV2LA0KPiA+ICAgCQkJICAgIHN0cnVjdCBkcm1fbW9kZV9jcmVhdGVfZHVtYiAqYXJncyk7
DQo+ID4gICBzdHJ1Y3Qgc2dfdGFibGUgKm10a19nZW1fcHJpbWVfZ2V0X3NnX3RhYmxlKHN0cnVj
dCBkcm1fZ2VtX29iamVjdA0KPiA+ICpvYmopOw0KPiANCj4gDQo+IA0KPiANCg==

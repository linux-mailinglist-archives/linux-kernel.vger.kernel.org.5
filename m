Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F1E78BF05
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbjH2HOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbjH2HOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:14:03 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6940119F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:14:00 -0700 (PDT)
X-UUID: 9c981602463b11ee9cb5633481061a41-20230829
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=bED7R2HrsVAVuF00rwWLbwQL+PraIvSHeg8ojGua9+o=;
        b=HcHLVya+pb7AQtfDoZo1/ZSWWX2Q+w7BUB0FTYsD4gzdlhtJ4IU/zlyEfYwJ6qyYKnqAvyYDhs1sNULvwsMGyhds7z9+/5+tvSeeAx93INOXlUwuaTzNssPtfffohuGlWf/4dLlBO1H/DhBSPS9aAQoYvX5YksA7m35TynlXfP4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:58bc22b9-cfb1-4a82-a43a-5a810b91f4f7,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:40
X-CID-INFO: VERSION:1.1.31,REQID:58bc22b9-cfb1-4a82-a43a-5a810b91f4f7,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:40
X-CID-META: VersionHash:0ad78a4,CLOUDID:078910ef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:230829151355N4VRSPPO,BulkQuantity:0,Recheck:0,SF:17|19|48|64|38|29|2
        8|102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:ni
        l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-UUID: 9c981602463b11ee9cb5633481061a41-20230829
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1226220850; Tue, 29 Aug 2023 15:13:53 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 29 Aug 2023 15:13:52 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 29 Aug 2023 15:13:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akiAP2K8soTYk4Xj/8y7YNcTRbkWTA82kz21BVK5kMqVlb57hdY+5GITZXrABcWZEvy+42K0gfn/joBtsCbit5uEiq6hM3HjgIsqgEZgiT0gmn0TwQvkFFwdOaFJlTJCLagSpF5H7A4dBzJObrCCg8KBc2ImQLOXEKEaq3Ww8FDaO/0DOCgH8gk84wud6oSgP5mTibo6tQor24pNbCjsQanhdWsmaibIWZq8Qr2y29XEBFtXPTabYmT59FWKmcIbZDdtywoR9ue8OAfD1FtkKVJ0bJ95f5uEn65dXusfUu8zO7AUMcOJmIEQKZsMkitMQMxCAQk9Fon7jwBkPstx7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bED7R2HrsVAVuF00rwWLbwQL+PraIvSHeg8ojGua9+o=;
 b=EwRWXmYqIznTgbBZK+cGJwT3SoWxb1bDAe4LAXpeGX8qbcAJWvT/NWO4Asyr1cv+4oDv8kX97NoD/Vj+1g2rWcoNxIJ7KURb2u/aUbIG3h4OM1HW5SiEjw4HnkaiRjAZ52jDCn4adooAGH325//dgotIr5smjtdfQvXf1brRLVGxZxwbGQT31B5l1Sf/g2oLpota4vicJ7KHgQX/Tk7fHE6OirAJyhIie35cHKlCafja45v6tqBOOtk8P/+2VfGcrLaDacH8xGqbtwHrk/FEr51qfg7h3kSMi+w51NTLI8KT3aPem+GWBgFBFb2SXBI0fiqHnTGBaQwtQIqTjNaO9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bED7R2HrsVAVuF00rwWLbwQL+PraIvSHeg8ojGua9+o=;
 b=buzlnC4yIsphX3XWuoE2l1HYgg5Yerta8Q5QWH+UdRDtODIM/LMVfmNqlsiyapeIqHqVwElTCBypOnS/ol+S0JewKAiTtTZ037bdODYBO3oHywXB4Nck5tbR4zw6usLVMamI0QtINJ6HQzbvMqh2cvNe93JPJtrn6X3HcSlqQnY=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYUPR03MB7085.apcprd03.prod.outlook.com (2603:1096:400:358::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 07:13:50 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 07:13:50 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH 04/15] mailbox: mtk-cmdq: Support GCE thread loop
Thread-Topic: [PATCH 04/15] mailbox: mtk-cmdq: Support GCE thread loop
Thread-Index: AQHZ1dSLZYYztKizsUS24p8sSyPqELAA5Q2A
Date:   Tue, 29 Aug 2023 07:13:50 +0000
Message-ID: <7bbe55387e15f4e1646552a2255cc8cb45732d4d.camel@mediatek.com>
References: <20230823151332.28811-1-shawn.sung@mediatek.com>
         <20230823151332.28811-5-shawn.sung@mediatek.com>
In-Reply-To: <20230823151332.28811-5-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYUPR03MB7085:EE_
x-ms-office365-filtering-correlation-id: eeef1a07-32f4-496d-cca2-08dba85f7e90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bp5VXzaZrMh1sTvmeRTrfA/YVxU4OGgJpwrszjWTuRpy9byi3+oDmZuyN3fqvXzQAQgVFgdv2Do56H4rQl/M8vCA2icuZnePDbm8Z6nYoDFi+dARn+N72d5uzJtpS6pQqSfOKCsLVKOSKwi8PWNqz4q86p+tmrCote4JEKCOKj4Bzesh7aOphA/2kDkmbz0XB2sqBuJpeZgvok/cEj4PMwZzGN/fgvX229BE2P1W0icEOE24cULeFEk7ByWbLhQA0caZrOVeg0c6ymssmXmk17BnfhNB25YlledGKDzaByAJcjAwhgodn+RPDvjLjv0lBbwCnYVtHKBw5gU8QLfuQOsC/V1UGP4AYfEREFSvtTfVQNHEhWCbClw8gdSYTiMI6dR7h1ZynLptgXiEODRnJfA6ck9Ir0yGazz08FKVWfF5LaKxad73FzSr0xpo1dkH6sKlQ8VTefzmf+zsBmZGAYsDN35FjzTqZ9QwOF+EfxbroIBepKAH6hasfRPtTdFVVhnS856RlCUe4ULgqUnpwqH1atMp3rNfg8M46yLBjZOYt4GZbjIeoR6Zzrviskf3xBJpHY7Vj/TUeO+QnU9UGudQC/BW0VMistJvTInDm4+zri2h7TA2IxFSs7cnfNtL1ltTvPi2EWsSZkTBgVhlyBnlEQH4XlvniwGXRtwWkvwj55skBsjoj2sUganiADtXM0Rg8oYCZnxSX1STQA3nLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199024)(1800799009)(186009)(107886003)(8676002)(4326008)(5660300002)(8936002)(6506007)(6486002)(12101799020)(71200400001)(6512007)(26005)(2616005)(83380400001)(122000001)(478600001)(38100700002)(316002)(85182001)(66476007)(54906003)(38070700005)(66946007)(110136005)(76116006)(66446008)(66556008)(64756008)(36756003)(86362001)(15650500001)(2906002)(7416002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWJsM0w1Yzc1RVZBcGJ1UFJ2MG41aGxaa3FGaW9KYkF5U2lySUtpWmxzTHA4?=
 =?utf-8?B?K2Zpa2doK1ArVjdOaXo2eDVHVTU4VlVRa2tYZFNIVXlrdFhzRktySHBmbmxH?=
 =?utf-8?B?U3N4eUtLcjFOTWtKNmZHRVRJTWRIc1FlbE1LRXp5czFqSllrZVJnOWxjNFdm?=
 =?utf-8?B?aE00d0xxcDBNdGQwZVZBQWJLZ2lxV0tYRW0yN0xtL2IvdlF4RmV4bVRIUXNj?=
 =?utf-8?B?L3ltR2hjbU5Kcmx0eERCRW5DTHVoaGJMc0Z5bjc5T1FwWlpGM0duOEh2OVFC?=
 =?utf-8?B?azlHYndVVk5HSFJJYnBPc3hhSG5xZ1ZLNFNvY0dOOTBsOERCOHY4cC9iQWtx?=
 =?utf-8?B?SFQ2ZGRVcEN6Lzc5aVBjWVVlM09OcjZwL1BSdUhzTUZZVml3OWkrcE5za0Fk?=
 =?utf-8?B?TjV0Q25LeDlqVC9GUFowcVZoYUhjcEU0eGlyL1pqOCs3SFZDdkx1YzdIN29i?=
 =?utf-8?B?NjlWOVkvcW4vTU9IbHRPQW1WU3RTWFZkWE96bEkvc2tTYVBrcEx0ZlR0NFRu?=
 =?utf-8?B?QWxCOGZKRFdiWDQxcXBERndndkdQTVNVbFgzbTFRVVZpUVVBaVIyOGdTcG5E?=
 =?utf-8?B?bFpBMzVIL2RUaSs4VGxEZFZqbzUzUGVCaHdYbFpKdHJ6VVVGcUhPdlNLT0tY?=
 =?utf-8?B?SkV5MEpyRlRUMEJneWlmbTRPQ2ZaOWZkNlN0elFZZ0V4Umsvd25ZSnFrWCtE?=
 =?utf-8?B?MjEyNG9TcVM5OXNvWEZhaVBIbU9JWDFUNCsyaGFxQU5lWTA3Zlo3NVErdXNp?=
 =?utf-8?B?ZGsvaVBaSGpxaVBQL1NlcklUQTA4YVo2bk1EYjlZbGw5YnJEamp1T1g5ZjZr?=
 =?utf-8?B?d1ExeExtVU10cGtMVzFuRnBBdXFqc1U0R3hQMUJPMUNmclgvN2twUVM3RndQ?=
 =?utf-8?B?cnBod0VXN1lXVUdlckwwV003QXpTOE9maEd3NUJIRFlCbXp5Qm4ydGtuRk5y?=
 =?utf-8?B?OGlON1lsbVA5NlZOL0xST2Zoa3kvRXMveG1MRFluN1ZTSGpGRE9sVi94Yzl4?=
 =?utf-8?B?MWczYU5sN0tObFhEbk9aTlhZQkgxaXFpUDV4Y0xDTkNvcVFZVVA3R1Fmc0N0?=
 =?utf-8?B?WVlZUnBWNEJ5bDVWdWp0cVJwM2Rsemg0eitZRUR2eklXUDQ1ZnBnZEdxRk1z?=
 =?utf-8?B?ZGpPbHVWendpMnExUmVxbk9PRUk1eHlXdllscXBnMnIxcU5meTF1ZWRzckk4?=
 =?utf-8?B?dW5yU0M5azl2NWlOMjhxTGMva1Y5Tk9sYlF5SjQ1aDk4QlFLdTEvU3BoV3dm?=
 =?utf-8?B?ZFo1N2t4TWM2QmNpZlQrRFF1eitsTjkyR2tXZkNtOXpwZWFvMjZyb1NHL1RU?=
 =?utf-8?B?VEljQjgyTWdOYmh2ako1dTliakd3T3FBMkNsakhRbmxuaW9ML2tzSENRV05T?=
 =?utf-8?B?Qm1JUzdYczFDQ2hNbFB5RWY0Q0NWODl4VUNyRExuRlZBMjFzRUlRaU1acXkv?=
 =?utf-8?B?aVJRSTJpdzkrOXdhRmJnQVFTRVowci8zbVdJaVFjTDMrNEJ5OHpKa1VtMmky?=
 =?utf-8?B?bTZRR1JPN1VwV2ZleDRXdVg2dmtuOFFpOXdEOE1jNE1ueThMQTRrL3ZPMVcx?=
 =?utf-8?B?UGZvai9QLzVteTlxMVFpY1ZhMVNpYVAwS2lscS9GUTFvdkQ3S1VmUnduY1py?=
 =?utf-8?B?bnJNZ3RKcmdMMC81SUU3dFZGOVQ4QkI2L2FFZFhHUEJPSks1c3hZWFlLVjVX?=
 =?utf-8?B?K2tyWHNnYUtGTFJYeXFEUXMvVVM2VWZhMVIzdml1elppTXdyUHBpNUdncUpw?=
 =?utf-8?B?dzJLZjdhUnRFTlJLdnZiRUJhZHdld3d0Zld6YjBPRC8yRktNOStSL29oK09r?=
 =?utf-8?B?TzhFOTR5cTBqaC9TMjFFNnE4UjNqUTdFSjZRRTZZWGxCTm91cU83S1lEa1VJ?=
 =?utf-8?B?bDU4eUR2dEhCTzVjWjRLNFhTNXBtUkF5MG1uT0dhNFpKMC9CeDdXQ2FOQW00?=
 =?utf-8?B?V3U1NkxVZWw1dHZXQXJybWFWQVFlWWhGT3lyZ3Z2UUhNTnlLS1hnWE5TajNI?=
 =?utf-8?B?ZWxZaWNsQW0xdUdINWJnaW9uY005c0d2eUR6d1VlVHp1dDJ6dFRyc3VadkY3?=
 =?utf-8?B?MXBuSXk0OUMxdGs4czJRbnBwNktXVmZGZEtyOEhIejJGaVBOZWJCcXIyeXZv?=
 =?utf-8?Q?LY7zQXAwTN05KCSkJIMpPjUxL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FAC0ADEA1A48045933DBB5F343B7CF0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeef1a07-32f4-496d-cca2-08dba85f7e90
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 07:13:50.1347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IgB2oMpiE/SaNSVzKiQsv2ZLt+oDG9FslnyJrix/vWgv+oQDpYLu7VxpjwfzaXpyt06VHwjC3kMMwEjvRohUjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7085
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaWFvLWNoaWVuOg0KDQoNCk9uIFdlZCwgMjAyMy0wOC0yMyBhdCAyMzoxMyArMDgwMCwg
SHNpYW8gQ2hpZW4gU3VuZyB3cm90ZToNCj4gRG8gbm90IGRpc2FibGUgQ01EUSB0aHJlYWQgaWYg
aXQgaXMgYSBsb29wLg0KDQpPbmNlIGxvb3AgdGhyZWFkIGRvZXMgbm90IGluc2VydCBDTURRX0NP
REVfRU9DIGNvbW1hbmQsIHRoaXMgcGF0Y2gNCmNvdWxkIGJlIGRyb3BwZWQuDQoNClJlZ2FyZHMs
DQpDSw0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIc2lhbyBDaGllbiBTdW5nIDxzaGF3bi5zdW5n
QG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJv
eC5jICAgICAgIHwgNSArKysrKw0KPiAgaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1h
aWxib3guaCB8IDEgKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+IGIvZHJp
dmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiBpbmRleCBiMThkNDdlYTEzYTAuLjg4
ZmYzOWEyODQxNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxi
b3guYw0KPiArKysgYi9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+IEBAIC0y
NjQsNiArMjY0LDExIEBAIHN0YXRpYyB2b2lkIGNtZHFfdGhyZWFkX2lycV9oYW5kbGVyKHN0cnVj
dCBjbWRxDQo+ICpjbWRxLA0KPiAgDQo+ICAJY3Vycl9wYSA9IHJlYWRsKHRocmVhZC0+YmFzZSAr
IENNRFFfVEhSX0NVUlJfQUREUikgPDwgY21kcS0NCj4gPnBkYXRhLT5zaGlmdDsNCj4gIA0KPiAr
CXRhc2sgPSBsaXN0X2ZpcnN0X2VudHJ5X29yX251bGwoJnRocmVhZC0+dGFza19idXN5X2xpc3Qs
DQo+ICsJCQkJCXN0cnVjdCBjbWRxX3Rhc2ssIGxpc3RfZW50cnkpOw0KPiArCWlmICh0YXNrICYm
IHRhc2stPnBrdC0+bG9vcCkNCj4gKwkJcmV0dXJuOw0KPiArDQo+ICAJbGlzdF9mb3JfZWFjaF9l
bnRyeV9zYWZlKHRhc2ssIHRtcCwgJnRocmVhZC0+dGFza19idXN5X2xpc3QsDQo+ICAJCQkJIGxp
c3RfZW50cnkpIHsNCj4gIAkJdGFza19lbmRfcGEgPSB0YXNrLT5wYV9iYXNlICsgdGFzay0+cGt0
LT5jbWRfYnVmX3NpemU7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRr
LWNtZHEtbWFpbGJveC5oDQo+IGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxi
b3guaA0KPiBpbmRleCBhOGYwMDcwYzdhYTkuLmY3OGEwOGU3YzZlZCAxMDA2NDQNCj4gLS0tIGEv
aW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KPiArKysgYi9pbmNsdWRl
L2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQo+IEBAIC03Niw2ICs3Niw3IEBAIHN0
cnVjdCBjbWRxX3BrdCB7DQo+ICAJc2l6ZV90CQkJY21kX2J1Zl9zaXplOyAvKiBjb21tYW5kIG9j
Y3VwaWVkDQo+IHNpemUgKi8NCj4gIAlzaXplX3QJCQlidWZfc2l6ZTsgLyogcmVhbCBidWZmZXIg
c2l6ZSAqLw0KPiAgCXZvaWQJCQkqY2w7DQo+ICsJYm9vbAkJCWxvb3A7DQo+ICB9Ow0KPiAgDQo+
ICB1OCBjbWRxX2dldF9zaGlmdF9wYShzdHJ1Y3QgbWJveF9jaGFuICpjaGFuKTsNCg==

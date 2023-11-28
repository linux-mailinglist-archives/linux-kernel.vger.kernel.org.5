Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D497FB250
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343697AbjK1HHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjK1HHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:07:23 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA123C2;
        Mon, 27 Nov 2023 23:07:28 -0800 (PST)
X-UUID: c6e5772e8dbc11eea33bb35ae8d461a2-20231128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=nlSafwqJchuusKe64SBrx8di2wqkLfd1sGW67ZZMiUE=;
        b=j9ESMc4SIZTlTY0Msm8W9Q2EWwbtKX/kMZ1y2v3y0bLz/GvkmfJWSx9IhFJ96HWlgPFA6zb46l51rIWD9lHgucXQxdzli5iq/bWMCZ9nocIpfgrKUU4Ugzc1b8vHyKQ7APL+xA2IPD2DeTCXVeE93Lx6cnkMjALQCCZ8viZR6Tc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.34,REQID:f926d4db-08ec-4922-a14f-3ffbe9837b11,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:abefa75,CLOUDID:299908fd-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c6e5772e8dbc11eea33bb35ae8d461a2-20231128
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 897194333; Tue, 28 Nov 2023 15:07:22 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 28 Nov 2023 15:07:21 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 28 Nov 2023 15:07:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Go1v55qAYXWHGQUBoTLP1D+YsnBwoNVFlyAwonjyusDb9uoc3+lp6KfNhzKCIEJm95OmzHUxRf7x2Up6awjBD7+a24qQfME0koa5mgjqloMUPEMAzj7di0xf4BZOqC339iqye0O+Qd4p/qyfPcFeePb/FQhXfxSwx1C69zRoNvW+sL+Q44X3v29dzPZhLmOZ56YWUEOcKOgmrrjdR8PabInggWlXCBctWRhbp91zGgl/vQxZtWC5ecGyV53oSyZZ6nWd6Xunt0J1Y8Kmu+1W5mJQQEt5BmERu3hgrYDMxLTt7CouyLPlYZMuJT5XkJdbfvsVA9CEfXIT6KCEBhAj0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlSafwqJchuusKe64SBrx8di2wqkLfd1sGW67ZZMiUE=;
 b=Hnpxl+5dg74wwMDcIg2u8FszyXwvfp4B4l8cnqG+zWpNkfA8IDJhbwQ/Dg97LuLk6y8v1dlt1E9EZ7CIIi7Frknu2CPq3zZPn39gxIgRJXhcilcN58b+AOmiI9DTviJP+z49pJJBEcaRbHsj2BLQlsH5pGXEAzIop2Zlxf4ck45KTDh2S2WReIVpgPln7LIiRjRBwzFzpxnUEoG5yzxwy2F9FtYS9HKazWLZsbrO2IQEdCKE2Q0ZFPAiwW0ey8pT0T01Ad1THpVCeizBnUdK+tr02zDfZ2JgesZLSYc5ru1GBL6O5ifwCSoAK8dY0VL7IRyaFJK9zEf5XwzOlCKSFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlSafwqJchuusKe64SBrx8di2wqkLfd1sGW67ZZMiUE=;
 b=Xe0A0Q5TnMzM0Y8om0doUHBf80Bx6UxGO2oMRptlTXV/r0K+qb9a9RJpsaANSlhwNMQAsjL4iJcogUHdTLGpo3STWrP6RojBtwicEm3D+yO64AhHeSJkOHSAkS0ItlPgWsq1DIByTCjXAjP8SHFQJdnC6xkYiCtuODTrLHM4v04=
Received: from SL2PR03MB4537.apcprd03.prod.outlook.com (2603:1096:100:59::17)
 by KL1PR03MB7550.apcprd03.prod.outlook.com (2603:1096:820:e6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 07:07:16 +0000
Received: from SL2PR03MB4537.apcprd03.prod.outlook.com
 ([fe80::b25:3f66:cd6f:39d]) by SL2PR03MB4537.apcprd03.prod.outlook.com
 ([fe80::b25:3f66:cd6f:39d%7]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 07:07:16 +0000
From:   =?utf-8?B?QXhlIFlhbmcgKOadqOejiik=?= <Axe.Yang@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v1 2/2] dt-bindings: mmc: mtk-sd: add 64-steps tuning
 related property
Thread-Topic: [PATCH v1 2/2] dt-bindings: mmc: mtk-sd: add 64-steps tuning
 related property
Thread-Index: AQHaHqUvYnG+2b4j+0iirW6YMZAI5rCJIe8AgAYzzoA=
Date:   Tue, 28 Nov 2023 07:07:16 +0000
Message-ID: <736a6dc342ff0c5452687b7588cc194e22bb209c.camel@mediatek.com>
References: <20231124070839.12484-1-axe.yang@mediatek.com>
         <20231124070839.12484-3-axe.yang@mediatek.com>
         <8dd46bcd-c1fa-4876-b4d9-e4bb91ce5de9@linaro.org>
In-Reply-To: <8dd46bcd-c1fa-4876-b4d9-e4bb91ce5de9@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4537:EE_|KL1PR03MB7550:EE_
x-ms-office365-filtering-correlation-id: c3821424-9207-46b7-ddba-08dbefe0a755
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: guolkOdKjoRvET79JWVujxa3wiQy6X4V65VegInfGjqmjB6LDWQPhosOw7KWCAL56FtubDuFPD5Kh2dYu4f5VWJpjMDc9nhP3AIHuTGp6L4se+JYuk1LenbUPPQXJWqZkB38BYm8rCBU98SMoTikUBJjAfiayJPgYgKQ7XmIq7QuYdgIiMUiXMju3lA9pvTibnVTX13k2x1K3//6gN2FznfWhr188H7A0KLelxkj8C8HNGA7gUb40FeUJfDGJSQiL3a/SqVKj18plU7nMmtqsFUuxtPogSdEJViFQPBAqIPJq1n0vdkPezZstcOSMlZilPv8xiEX7lixNtuTvB9drDuQTgn12EcSIssp9SpdVHb3+FIKE2X8pqkYLiwEAKsDklw0Nmt3BIoDnRN7JLQuYn+GyVX2XYV4XGq0sGnMSnr/wZox4UDQPMDr1fvlZXIdq2a1ywkYgsgT3moXMxRTm+eiiUjVy5/R+anDXEOaT97N53vQijoyL2mj4bCWAccztcCvqHgmTGbD1FQ3M6VNmtWNPS0T5rIkfxqYvkt2lsRY8l1weOn26r3Z0e9EDx49BQSk+e91F1E3LCVouoMZZBslIHjWrcpUpLok6Z05dVfTIWyLi7oOD/4PA9E9UbflvqSDUAjVfZRk8BXecV0g8terq7XR/2WuX+uZRnWUizjHRlI43zM24OP/3K4UEXP2Pu/fX6DTXbu+/ok/nxpbjlY168k1Cb8EvKmrV+JRlNg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4537.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(39860400002)(136003)(230273577357003)(230173577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2616005)(107886003)(8936002)(6506007)(6512007)(66946007)(4326008)(86362001)(8676002)(478600001)(5660300002)(7416002)(6486002)(110136005)(66556008)(76116006)(316002)(91956017)(66446008)(64756008)(66476007)(54906003)(53546011)(38100700002)(26005)(83380400001)(122000001)(71200400001)(38070700009)(41300700001)(2906002)(85182001)(4001150100001)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEZjSE1nUk8zMCt6QXFIR1hEclVXTWRZdUM4OEdVSHpocmgxWG9odVgySXl4?=
 =?utf-8?B?cHN4WFdGR0lTb0FEQTdaN0RIVTc1RnNocE5PVWFTWmdQMFJhZi94NWFJUWND?=
 =?utf-8?B?QTN4ejBUb0F0YnpJOHFmOXU2cFJNc1FVQkV2eGFjYVlibzkydWlvWWdwc3Ns?=
 =?utf-8?B?OFFzOUNxbDB5d0RkQXpIcGlkRlo3cHY1Vm0rYjFFenlLMkp0eXNETW45WkZ1?=
 =?utf-8?B?eWwvM091bnFlUTlLVVBiaUc2dWs3NlJvMzBGTVFmc0ViREVyVXJmdVJsWlVa?=
 =?utf-8?B?MXp4Z0g1aXdJWE1td1BoTXRXN2pTWjJjUnNmOXM4L21aa3B1dERYc2JHOHRm?=
 =?utf-8?B?RWZPamlBS1lXb0ZlQUkxOXhsaVQ3TU9LZE9FWkZxMERyTzFFSC84b2p6Qy9y?=
 =?utf-8?B?OFk5NjRJY2hyWWNGemZYVURLMXJGUzBrZDQ3Mk1zYW0zZmdXbHlhZlcyZ21Y?=
 =?utf-8?B?UlpyYWgyNTQ0SDk1QWJMWWtHZGt3RHFiZUZ6cXcxdG4vdkVMSVFHTUZaVnda?=
 =?utf-8?B?OUs4Q01FeWhkNGI1bEJyaWFxWldsWmFIVUNzL2RPcUVUVGFZZXQ4QkZEY201?=
 =?utf-8?B?UHVtZ2tNNElQT0h0TmxMejl6MVBTbys1NUdmQWRHWHZsK2RwcU9aSVNxd0pa?=
 =?utf-8?B?bG5ZTHhHdUxtMnFyY1RNazV1ckRCR0NOVHVab2l2aHEvL05uWlNuaDI0YTZU?=
 =?utf-8?B?VXpRSkpING1KNUp4V2lVZy9nd2xwSHlHang2ZkMzMnFNc2tYUTZBWFZ5Wm50?=
 =?utf-8?B?NHVVYU9CMnFwc2luLzZ0cW1iemN0RSs3bm9QbnhTQVhRdzgrRWVxYjdVU1hk?=
 =?utf-8?B?NE5rSlhNNlpsWDhpRjVwdWU5UDNFblp2NUlDejRUSFpoRlQ4TEdzeFIzK21E?=
 =?utf-8?B?MzhGNHhkalNBNUcrcmY1MUtRdHJlcHBHbFJvS3dWcG1KWFJuNnFYdm43bDJj?=
 =?utf-8?B?RVgrYTNKT2hCdVh1cVB5NGp6bDc5TjZOVGZTOERCNWdSL0s2QVR4aUp5aGpx?=
 =?utf-8?B?alFCSFBqa0Y1RnlYUGVDNzU0Wkg3ZmordWd0SGVibzBYNHhpakhwczR5d2N6?=
 =?utf-8?B?cXNlaDhmbFVjeTUrUGJ5S0c1V2Q4Rnl2bXdCSTlrSnNGQW9kSHJHQlpocy84?=
 =?utf-8?B?ZlZ0ZTRZb0YvUVpJU1ZRZ0cyWXQxUDkwcUlmQkFFUmJVMnFkOTNReVliTk1Z?=
 =?utf-8?B?T0F5WFV5eVAyeDVIRmV0bmFQY0VDOCtjOUJpYlA1VG5Tdk84MVd2MTJVMTE1?=
 =?utf-8?B?ZEVyU3k3byszYk9ERGJJMXlIWWtlVXBNQ1pwMytKMUdqQjBOMkdIUThreDJ6?=
 =?utf-8?B?WTRlcHFhdDhZakY3Sk8rVlh3NDdTY2RxZ3dVK2pESlgyQ0VzOFJFU1FjQ0Rn?=
 =?utf-8?B?QnlTTjVKcmJ4YXFIRjFyQmVFT2lsb2xlNnVyMzE5VmFOTWwzeDNRbndZZVZW?=
 =?utf-8?B?Nnd4NTRRYWc0RkNpM0FXQ1VhQk1xaVRtRHhQT1ViL016a2M1blUvREtqN0hC?=
 =?utf-8?B?SFo2OXVEWXgySCtEcWRwVVJMdXVqbzArclJmSEloQUN5U0VjMHRPQzZsNFhh?=
 =?utf-8?B?MGw2ZW9UVEtwSHVLU3BoVEZrNmJKMy9nRjdnM3hlUVUwSEpTUml5V2hXUGtB?=
 =?utf-8?B?S0hyS1VUNzRZKzBpOSt2ZEx2QzJQMVljT29saGt2MEdsRDBURm5uejNkUUQ1?=
 =?utf-8?B?SkJZNW1qMWdmczlxZDZqSU5wNEN6dGRTU0VFazdPVlY5eXF2ZWs2RGd0SlZR?=
 =?utf-8?B?WUhZWFgxQWUvUnlVVXBZQ3dhTE81QmdqaGVXZWZVa3FoWnBOVEJsMmMyM0hw?=
 =?utf-8?B?TitvRHIrRXVBV2VQVmt4ejVSWDFNVXhKaWlPUHJzWWJoeUNqMkJwZU1hQ2sr?=
 =?utf-8?B?alJSaDU2MG4xclBjVTFucGcrRU9adVNzRmRQMjhTMS9EVG4wR0xUMEVCanBm?=
 =?utf-8?B?M1lNMWVldGppZGV0SXlEVFFlVG1weGc1RkZIZjBjNEhnOGcyejZnN0t3VVFO?=
 =?utf-8?B?WjI3MVR4dTAwZmtwZUJWRksyckRLcllFenl5N3lhT2xmdkJlWW53L1hYWXhi?=
 =?utf-8?B?TGRYVlkveGlCSzBvcWtTMG5xVzBiMTBuNkdQL2xwaGlkUXZ6Wkg1ZG9MZEZF?=
 =?utf-8?B?dWlsTm83d1dMUzdiRmNTUC8wZWZRaWtyRXp4eDVoS1hpTUtuWWtaRDNnamQw?=
 =?utf-8?B?V1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84D4B35622F4E44EA170DD65183A1C84@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4537.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3821424-9207-46b7-ddba-08dbefe0a755
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 07:07:16.1807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eUQXSfvoWRdi9Nir+i6aKha912ALN8UZwMrfQPTfGlJJWW+CYpjnx42dDiaTxUI/WjtBh5pZAbYV5YH8NgIjqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7550
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpUaGFuayB5b3UgZm9yIHRoZSBjb21tZW50cy4gSSB1cGxvYWRlZCBw
YXRjaHNldCB2MiBqdXN0IG5vdywgcGxlYXNlDQpoYXZlIGEgbG9vay4NCg0KUmVnYXJkcywNCkF4
ZQ0KDQpPbiBGcmksIDIwMjMtMTEtMjQgYXQgMDk6MjQgKzAxMDAsIEtyenlzenRvZiBLb3psb3dz
a2kgd3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sg
bGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUg
c2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgT24gMjQvMTEvMjAyMyAwODowOCwgQXhlIFlhbmcg
d3JvdGU6DQo+ID4gQWRkICdtZWRpYXRlayx0dW5lLTY0LXN0ZXBzJyBvcHRpb24uIFRoaXMgcHJv
cGVydHkgd2lsbCBnaXZlIE1TREMNCj4gPiBhIGNoYW5jZSB0byBhY2hpZXZlIGEgbW9yZSBvcHRp
bWFsIGNhbGlicmF0aW9uIHJlc3VsdCwgdGh1cw0KPiBhdm9pZGluZw0KPiA+IHBvdGVudGlhbCBD
UkMgaXNzdWVzLg0KPiANCj4gRG9jdW1lbnRhdGlvbiBnb2VzIGJlZm9yZSB1c2Vycy4NCg0KRml4
ZWQgaW4gdjIuDQoNCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBBeGUgWWFuZyA8YXhlLnlhbmdA
bWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbW1jL210ay1zZC55YW1sIHwgOCArKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
OCBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9tbWMvbXRrLXNkLnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbW1jL210ay1zZC55YW1sDQo+ID4gaW5kZXggM2ZmZmE0NjdlNGUxLi5j
MzMzMDFlMmVhMzMgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21tYy9tdGstc2QueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tbWMvbXRrLXNkLnlhbWwNCj4gPiBAQCAtMTQ1LDYgKzE0NSwxNCBAQCBwcm9w
ZXJ0aWVzOg0KPiA+ICAgICAgbWluaW11bTogMA0KPiA+ICAgICAgbWF4aW11bTogNw0KPiA+ICAN
Cj4gPiArICBtZWRpYXRlayx0dW5lLTY0LXN0ZXBzOg0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMv
dHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvZmxhZw0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4g
KyAgICAgIFNvbWUgU29jIG5lZWQgZW5hYmxlIDY0LXN0ZXBzIHR1bmluZyBmb3IgYmV0dGVyIGRl
bGF5IHZhbHVlDQo+IHRvIGF2b2lkIENSQyBpc3N1ZS4NCj4gDQo+IFRoaXMgc2NhbGVzIHBvb3Js
eS4gSW5zdGVhZCBzaG91bGQgYmUgZW51bSB3aXRoIG51bWJlciBvZiB0dW5pbmcNCj4gc3RlcHMu
DQoNCkZpeGVkIGluIHYyLg0KDQo+IA0KPiA+ICsgICAgICBJZiBwcmVzZW50LCB0dW5lIDY0IHN0
ZXBzIHRvIGNvdmVyIGEgY29tcGxldGUgY2xvY2sgY3ljbGUuDQo+ID4gKyAgICAgIElmIG5vdCBw
cmVzZW50LCB0dW5lIG9ubHkgMzIgc3RlcHMuIEZvciBlTU1DIGFuZCBTRCwgdGhpcw0KPiBjYW4g
YWxzbyB5aWVsZA0KPiA+ICsgICAgICBzYXRpc2ZhY3RvcnkgY2FsaWJyYXRpb24gcmVzdWx0cyBp
biBtb3N0IGNhc2VzLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQo=

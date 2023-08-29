Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2A278BEF4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjH2HIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjH2HIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:08:04 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6812FF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:08:00 -0700 (PDT)
X-UUID: c52a392a463a11eeb20a276fd37b9834-20230829
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=POR7BR4gHFEjJw8sjHXB9iDx0846Ozie3TPBdwFPP5A=;
        b=sJbLfNO/eScNMoVrP+fcFBOBznkehxsk/NwNdkoPoeqDn/M0nh8zkplG0t3ssuqJKyrtC4RJQvvx1lpAf9YwkhyXuGLrmryyGgbao9Y44c4jgrlOZBYAKt/Xsk14tNr5B8tqDMLNJvaEbgtTTmlJ8Np4UEbinfF9wX2jwywbKLg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:1b94d519-7c1f-4ee2-85c4-43d73f8a5001,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.31,REQID:1b94d519-7c1f-4ee2-85c4-43d73f8a5001,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:0ad78a4,CLOUDID:b27710ef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:230829150754Q5UB04WE,BulkQuantity:0,Recheck:0,SF:64|38|29|28|17|19|4
        8|102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:ni
        l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: c52a392a463a11eeb20a276fd37b9834-20230829
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1684165052; Tue, 29 Aug 2023 15:07:52 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 29 Aug 2023 15:07:51 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 29 Aug 2023 15:07:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGztyl0lb5cG8eCY0BYk0cHkriqjsP331/E5LS+qKEB+UqpKofBEtx6Rew+kilJMWSQcDdWwEuXHhJjMYa2Vv+S436/qPoq25SU1Q9uFWrLwKNYgNmZ/098xtE/97wPgHJFtG7HJW2oogo4EvOp7cC6u5YPW5fj319Hh62STsMbkhHPAzzLc+uA2BFn7KdyQ0AWZBcZ379EOT0xYnrgNsEmHkmzP549lw8DdG2MTEIWHX4uEXm59Kw0nRIomrG0ItnbVAa5Ucbkm2WjTs28A//EHC0Hj+Arg/bLFoyE/LPdiYh00+D5q3m3mAw3My3rPD4mGqWzfx/DhDzMGmlqorQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POR7BR4gHFEjJw8sjHXB9iDx0846Ozie3TPBdwFPP5A=;
 b=eCmSh0KXbfcMa7GQylYZ0hP7PjhYVpJ3VzRdVGqnRlHoFOCZJWOwACAA9jp0LDtwEtqjWmbxzOJlrnnc5NtTLg1jG1vanhmN94P77kVvegbN3RuFSSY8nRHK54R3DhrMMIQ1rwEvTUI2KTouF51ECt59DvIG7i0cOq+DE6JMwzGCZxd+q5KzRBquG7k9eIq+bZb8d538wI3KgF7bTB1s5ehIsmAgns7tz3H13H0PXi6ebdLJMtumoxF6E2rjmc9Xka3muuO+52pk2pUn09TIXczuspQuwq9+swtPh1vEPR5Tdz0VkKC+ecFHqm0QQARxvUPZzqf+0pOgR8r6GruWdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POR7BR4gHFEjJw8sjHXB9iDx0846Ozie3TPBdwFPP5A=;
 b=IduQtTvBovMa/U6UpL31o2Ri29X6AeVcT5HWHY95/SQ6ZE5qdKoA/aOQOv126TFI70HHte6kal8xewlee3yeFGQEUfr5ZZKlEumdNcj+y6OOdKL2PVsh9cymmDxMnr8NZ17hhx1hQxKkNjsYcEy8bxtTae2Q2grqiV5rI66VNYI=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI2PR03MB6195.apcprd03.prod.outlook.com (2603:1096:4:14f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 07:07:48 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 07:07:48 +0000
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
Subject: Re: [PATCH 03/15] soc: mediatek: Support GCE thread loop
Thread-Topic: [PATCH 03/15] soc: mediatek: Support GCE thread loop
Thread-Index: AQHZ1dTJ7ZnGVh2PU0mkRDVN13twfbAA412A
Date:   Tue, 29 Aug 2023 07:07:48 +0000
Message-ID: <b63ee7a1158855abc5a4ffa815f62d7f249b2bdf.camel@mediatek.com>
References: <20230823151332.28811-1-shawn.sung@mediatek.com>
         <20230823151332.28811-4-shawn.sung@mediatek.com>
In-Reply-To: <20230823151332.28811-4-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI2PR03MB6195:EE_
x-ms-office365-filtering-correlation-id: cd6c7d10-ed12-486d-62ff-08dba85ea71b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xkCyui9zQPwMXKpLngFgAsuLjBKv3kwT4jKchRO/S6L9AV52S2fy7ZLBNg3QI41am8b0WWgt7TirA3q/7ZZX5KhCrYr+lIs9jbY2NDKjUdGWP/G+92gN/PJhC+5W0a90WwhLINUxKBasZjVm9YNuirZsG5VLZok/u2xR/Soja0fcARGySx2SzF6rDImHjfdmVBz2rfYu/8INAACyLYm+WN8a5D4qcXlItAS9zuL04QE7T3cL0DD0yNrAh1s52BNhNdy7sF46+xpmHtdwoSlDoGqIlGb3lLRAwAU139QwFwEcD5VAYMsCs2N4uv3pRP+0iI493VGiQHlv6sKgigAgrgNrUJSbtiSiP364VJYoHezjsvQxuSlkW7qjvwsSMYc4Vi98QjVwpOGIjPZkJZHis5nekQT0IOsmstKi+qYsem+FWZOhrYiOWu4I13XRENKkDG+UtO2Jt3T3JshiLLKPkYKFIXgq0y3adBGaLOxmXe99H2pXbPBUFQTLx4QchvKqrpQA88pQmj810xmapTczXP9SnjBVKlb9Di9uf8jLKMFfPDLYUvVFDw5sbhQsm3gbEqBiEpKcnG4t9g5UQIC9sYCyAYCRxBboldWDErubP0yvHquFnJIiYa3kGrczBoA+nlfP5ZKr+nXSFRKSNdFObu0wDoHVqpXHTjy28bb9frbCiH8U3ODScXzpPc8XZxcf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199024)(1800799009)(186009)(6486002)(6512007)(6506007)(71200400001)(478600001)(76116006)(83380400001)(107886003)(26005)(2906002)(7416002)(2616005)(54906003)(64756008)(316002)(66446008)(66476007)(66946007)(66556008)(110136005)(41300700001)(5660300002)(8936002)(8676002)(4326008)(85182001)(36756003)(38070700005)(38100700002)(86362001)(122000001)(12101799020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djdnYkZBdkhNRzR1YStGdEprQkwzWjFBWjdiRno3YkI4UGNHdURnNGNlZklR?=
 =?utf-8?B?NlRKSDc1c2Y0UWpmZFJac1UraHBJbW9kNDBsb0RTNWthK0MxSWhVeG92bHVL?=
 =?utf-8?B?QnM4VE0xaGk4U2d2UmlsQzMySFdsOWhNRzA1UU1rRTZWV3ZWWVhLZVFsNUoz?=
 =?utf-8?B?VWNxNEYyZHlnWUEzeHB0dzY3QTVPbmY2QjZKSzZERWpkcWcxNDVNdnJtUURj?=
 =?utf-8?B?eGFJcDc5YVhjaGFpKy82bW9JZk1LQTJsOWJKS0dOVnExWlVxUFNuOVB0Qy9T?=
 =?utf-8?B?ekdQYTBjM0ZIczY4NlJLNzhwQ05UYm96L2JtMFg1TlhGazJ4M3VWbVFvdXU1?=
 =?utf-8?B?UzFFK1FydVRzOGRoVFJ4d2pSWllrOWtNcnpQMTFPREtaY0hpWXFhZVBWWjVu?=
 =?utf-8?B?Tk1nMTFYNUw4WFAyalZ2SVlIZ1Zja3l5QkE5TmFBM05IMnowaWxBMGpISy8z?=
 =?utf-8?B?QjBWMSt1VUZFREhPalp4OFBPTXlFdThoUjMzYm12N0M1eXpIY3M3eXRwRXNz?=
 =?utf-8?B?MERYY3JOT05TalhveEZ1ZVVYeHUwb0xNM0ZSNkFlN2ZPdVV3YlFWV1BTU1U2?=
 =?utf-8?B?QTN0Y1pCVnVZT2YyKzB0ZUtCc3MxME9tRitKUk1WemhkSnB0akZXY29HNTh3?=
 =?utf-8?B?R0E2Y2pyeVRQNUQ0Nm5VbFJoK3d3WnFETkQrZnRyMDBCZkFFUmdRKzFXaE1o?=
 =?utf-8?B?NVJKeE1VcEtzcUhnSFRsOWJxRTJGdHBzd0g1STVNRit3ZEt2T2VQM3NoZmFT?=
 =?utf-8?B?UDNjVERJcXp3aWZleUsvNVBQTlluWTVSaEVUd1JNWUkwcFIyWGFFeE05Mk1u?=
 =?utf-8?B?c3l6RE95cGd3c0xQWGJITDQzTUlWZlNReDFTc3U3MlkyN3RVTENqUkNGQ3BP?=
 =?utf-8?B?VnVwSHdGR0ZkaytySjdpN1RDU1hNTTBsTmI3V0JIbHdhUlNjSGNhaFZiZm5v?=
 =?utf-8?B?bms2U2xFS3lQaHRadXAwSEUyQlJjZWplTGdwWSt5cEtJTUIza0REMnk4MFFw?=
 =?utf-8?B?bnlrRzVlcHpYTFJDQXhQaDBSRElIcVg2czlmMVAzTlVEV0YwWjFPRHVLeUF3?=
 =?utf-8?B?TnM3ZEphTUZkTDJZaHR5NzJ0Ylg3VlFON2R3WkgxUVJ4VUphM0xBNEE5RW5u?=
 =?utf-8?B?aTdjby9zOUp6YkRSYldWc2kvendCdjFEZDd0R1JtYldDTXIwZ205Wmpxak1M?=
 =?utf-8?B?bnUxUVdudUVKdTNHZjNHZ3ZMbFJldEREK1FSL0d2WmYxd2dMcEE3OXR6SzZk?=
 =?utf-8?B?eS94SWtlTWRqaHJ1ektIU2duajNKRGI0eitFUDdLVHpCRXFSNjVkMzErcW9B?=
 =?utf-8?B?ZjJjeTIxeVBxTzZvU0ZiNUR5SlNzdkFDVkhlVU5uUjJUUC81OTluekRjYXZ4?=
 =?utf-8?B?RUgrNWFJRmJaRkVud1ZPWjYyQ2NzMlZDN3dMYVRuSktvbFFabVNPUWl5Y0FF?=
 =?utf-8?B?TCtXd0R1cmZGWDc2Z1Q1RkZXZXhSL3R4SUc3VVVTNGovR251QU44ZUQ2SnJG?=
 =?utf-8?B?UnZYb1JkdGpLKzh3MUVoUENPM1pyQlM3U3hyUGpqaWhrRGFVSStsa29mdzZm?=
 =?utf-8?B?RytpZ2lsbzQ1NmxuQmgvb3ZzNnByMDgrSnNQait4ajQ1WTJ5MHhLdnNzM2JN?=
 =?utf-8?B?NVFnKzVuZzdXRnFkRXNyV1F3WnZzZGlOUkFxVGtKaWw3aGl0RHNWZFRuZk1T?=
 =?utf-8?B?bEljYzIyT1FRSU9zNEpZRHlHbWJUNzZmMHRRNDVVSVZuTThrajZMSEg0MzNQ?=
 =?utf-8?B?bnRNRGcySlpIeDJ6V2hGTTZubEJsSC8zSGlCYU04SnhVMXBRUXZwSVVJd1hE?=
 =?utf-8?B?bnd5OXVnWEJnUVVvSGlSOTlTZ215TXlHbmZtZ1RlV1NmMGZXSjFkYUY3dWIx?=
 =?utf-8?B?WVI1ejZyMm5QVWk1akppVVZTTllPV29LZVFQeXpQL3poQ0w4ZUk4QktLWGJU?=
 =?utf-8?B?Zi9uSWJtS3pJb3pGRk1sV3JlY1UxOWhkWjBBenVvRFczbys0R0dDdGUyUDhC?=
 =?utf-8?B?TnROYm0wSUMvS3NhaTB4TUpPOEloYUp5QVhLb2dXcmRzajN6L0taTEtqVGwx?=
 =?utf-8?B?L25QUGhmNzU0UnBMcFUrS3d6dzZHcys1N1FXbmc0cnQzdWRVcWt1U2c5SFVC?=
 =?utf-8?Q?4ShbMdB7KJnSaO00cIrU+Ywcb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <264DFC28B197B1468D2099927C500621@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6c7d10-ed12-486d-62ff-08dba85ea71b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 07:07:48.6853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3xM85JavpPq9KMMb6pysoIvMcyoA1k3Kqm+iOs+tRlMMs5ixXggkvGiTtq0Mtc6AuziDAOAE+nDUrmPgqfKU1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6195
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBXZWQsIDIwMjMtMDgtMjMgYXQgMjM6MTMgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IEFkZCBhIG5ldyBBUEkgdG8gY3JlYXRlIEdDRSB0aHJl
YWQgbG9vcCBieQ0KPiBhcHBlbmRpbmcgYSBjb21tYW5kIGF0IHRoZSBlbmQgb2YgQ01EUSBwYWNr
ZXQNCj4gdG8ganVtcCB0byB0aGUgaGVhZCBvZiBpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhz
aWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIHwgMzANCj4gKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggIHwg
IDIgKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+IGIvZHJpdmVy
cy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gaW5kZXggYzE4MzdhNDY4MjY3Li43
ZDUwM2Q0OTFjMGQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRx
LWhlbHBlci5jDQo+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5j
DQo+IEBAIC00MzAsNiArNDMwLDkgQEAgaW50IGNtZHFfcGt0X2ZsdXNoX2FzeW5jKHN0cnVjdCBj
bWRxX3BrdCAqcGt0KQ0KPiAgCWludCBlcnI7DQo+ICAJc3RydWN0IGNtZHFfY2xpZW50ICpjbGll
bnQgPSAoc3RydWN0IGNtZHFfY2xpZW50ICopcGt0LT5jbDsNCj4gIA0KPiArCWRtYV9zeW5jX3Np
bmdsZV9mb3JfZGV2aWNlKGNsaWVudC0+Y2hhbi0+bWJveC0+ZGV2LCBwa3QtDQo+ID5wYV9iYXNl
LA0KPiArCQkJCSAgIHBrdC0+Y21kX2J1Zl9zaXplLCBETUFfVE9fREVWSUNFKTsNCj4gKw0KPiAg
CWVyciA9IG1ib3hfc2VuZF9tZXNzYWdlKGNsaWVudC0+Y2hhbiwgcGt0KTsNCj4gIAlpZiAoZXJy
IDwgMCkNCj4gIAkJcmV0dXJuIGVycjsNCj4gQEAgLTQ0MCw0ICs0NDMsMzEgQEAgaW50IGNtZHFf
cGt0X2ZsdXNoX2FzeW5jKHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0KPiAgfQ0KPiAgRVhQT1JUX1NZ
TUJPTChjbWRxX3BrdF9mbHVzaF9hc3luYyk7DQo+ICANCj4gK2ludCBjbWRxX3BrdF9maW5hbGl6
ZV9sb29wKHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0KPiArew0KPiArCXN0cnVjdCBjbWRxX2luc3Ry
dWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KPiArCWludCBlcnI7DQo+ICsJdTggc2hpZnRfcGEgPSAw
Ow0KPiArDQo+ICsJc2hpZnRfcGEgPSBjbWRxX2dldF9zaGlmdF9wYSgoKHN0cnVjdCBjbWRxX2Ns
aWVudCAqKXBrdC0+Y2wpLQ0KPiA+Y2hhbik7DQo+ICsNCj4gKwkvKiBpbnNlcnQgRU9DIGFuZCBn
ZW5lcmF0ZSBJUlEgZm9yIGNvbW1hbmQgaXRlcmF0aW9uICovDQo+ICsJaW5zdC5vcCA9IENNRFFf
Q09ERV9FT0M7DQo+ICsJaW5zdC52YWx1ZSA9IENNRFFfRU9DX0lSUV9FTjsNCg0KSXQncyBub3Qg
bmVjZXNzYXJ5IHRvIHRyaWdnZXIgSVJRLCBzbyBkcm9wIHRoaXMuDQoNCj4gKwllcnIgPSBjbWRx
X3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KPiArCWlmIChlcnIgPCAwKQ0KPiArCQly
ZXR1cm4gZXJyOw0KPiArDQo+ICsJLyoganVtcCB0byBoZWFkIG9mIHRoZSBwYWNrZXQgKi8NCj4g
KwlpbnN0Lm9wID0gQ01EUV9DT0RFX0pVTVA7DQo+ICsJaW5zdC5vZmZzZXQgPSBDTURRX0pVTVBf
UkVMQVRJVkU7DQo+ICsJaW5zdC52YWx1ZSA9IHBrdC0+cGFfYmFzZSA+PiBzaGlmdF9wYTsNCj4g
KwllcnIgPSBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KDQpUaGlzIGZ1bmN0
aW9uIGhhcyBvbmx5IGR1bXAgZnVuY3Rpb24sIHNvIHJlbmFtZSB0aGlzIGZ1bmN0aW9uIHRvDQpy
ZWxhdGl2ZSBkdW1wIGFuZCBwYXNzIHBrdC0+cGFfYmFzZSBieSBjbGllbnQgZHJpdmVyLg0KDQpS
ZWdhcmRzLA0KQ0sNCg0KPiArDQo+ICsJcGt0LT5sb29wID0gdHJ1ZTsNCj4gKw0KPiArCXJldHVy
biBlcnI7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X2ZpbmFsaXplX2xvb3ApOw0K
PiArDQo+ICBNT0RVTEVfTElDRU5TRSgiR1BMIHYyIik7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+IGIvaW5jbHVkZS9saW51eC9zb2MvbWVk
aWF0ZWsvbXRrLWNtZHEuaA0KPiBpbmRleCAzZWI5NWVmMzRjNmMuLjRjMzBmODkxZDkyNCAxMDA2
NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiArKysg
Yi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+IEBAIC0yNzMsNiArMjcz
LDggQEAgaW50IGNtZHFfcGt0X2p1bXAoc3RydWN0IGNtZHFfcGt0ICpwa3QsDQo+IGRtYV9hZGRy
X3QgYWRkcik7DQo+ICAgKi8NCj4gIGludCBjbWRxX3BrdF9maW5hbGl6ZShzdHJ1Y3QgY21kcV9w
a3QgKnBrdCk7DQo+ICANCj4gK2ludCBjbWRxX3BrdF9maW5hbGl6ZV9sb29wKHN0cnVjdCBjbWRx
X3BrdCAqcGt0KTsNCj4gKw0KPiAgLyoqDQo+ICAgKiBjbWRxX3BrdF9mbHVzaF9hc3luYygpIC0g
dHJpZ2dlciBDTURRIHRvIGFzeW5jaHJvbm91c2x5IGV4ZWN1dGUNCj4gdGhlIENNRFENCj4gICAq
ICAgICAgICAgICAgICAgICAgICAgICAgICBwYWNrZXQgYW5kIGNhbGwgYmFjayBhdCB0aGUgZW5k
IG9mIGRvbmUNCj4gcGFja2V0DQo=

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3687E22FA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjKFNHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjKFNHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:07:25 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11368BF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 05:07:15 -0800 (PST)
X-UUID: 63ab47e27ca511eea33bb35ae8d461a2-20231106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=NL7A6LksHt1GemF9VOiGNHNSybnGNWm/iaGjkTFETFs=;
        b=a8MROi53UCgLqLhxtyJAXJzxwug14N/0fIsybiFjo55OpOLC31g4gxlZDEiZOay3UoYL98GHAzcHz7ogZmdx374MlmlXcf92Yz+FtYk8X2Hs6WKWYQPHbcvCqdcnVCimj6EHS78qycFLhzAmGL3kD996tyXSmniXFkt3cKBZ/d4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:2c16bbe6-817a-427a-b86b-63191eac074d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:67441295-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 63ab47e27ca511eea33bb35ae8d461a2-20231106
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 999297672; Mon, 06 Nov 2023 21:07:07 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 6 Nov 2023 21:07:07 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 6 Nov 2023 21:07:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEgGtqGrvm4yzqXRuT70L4neiJlAaUegEdzi1B0m8TllmYFvHS9L9iL8IARsOQQ68+w0IurbuSAAJdK6Fn6KLxz43KsP5vYFUp5+6fyGusLCM87LW3CEOQ8no6kYbqvkRbqZTb3zQEswRki5dyNRacqNulV7GF0f4iilo13+gTNYfPAFracCZwpW8wtOgoFeFvyrK1UhUyyveOqOyuxmtIkSwY54vE24GdO+2sRxj16WsYkYRZSa2FeXUeF+Gs9VQ910s5B6j2nEOGMSgzGtaxmhOxBq9XGA+r2Q1kOqBXDyt1BnMw0YCmPpdxtMH+JZJsUd59GEm5anEaVNBv0tJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NL7A6LksHt1GemF9VOiGNHNSybnGNWm/iaGjkTFETFs=;
 b=h5s38v6GN0ti9BH6fgw4PVfnUbfWPSVelG4VJNk3DdQy9eaLn6xolnscv0CpKuQrd28xJ0C09dv9YZlpVOBOIq0aoY2JSBFSfxXqSfuV2FHL4yrATrDZmyhP+erZe5Ib9KPjy78K1yVOoRLX1BO9dP7u8obR54k0N8VX0+i6CsvdyK0Ofoo8N+CC5YEp7fUeZLamYzbmZNN3YyquBWBFYYeQMVbtsjuw+YuEjlCTkTPSMhim/dnfN9fi43x0Bc0jrYa7pkQSPk5XJ3zSlcJzDw8wEF3EQvftvz3SksCay20WE8PJ1Qm2+vUQCOXxZOhSk+EBB9EX4ljp8lX8aCxuYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NL7A6LksHt1GemF9VOiGNHNSybnGNWm/iaGjkTFETFs=;
 b=IV2f+jL5zKaj1N2eprWGUsqJrp67VHeSa+G+i/EhM/HYfwSt6mTiCzUgftpo6DKfQSLat5pBFXMJfUDisNT1xAb75jcZ09lncfu8VYsI5w8sMAS8j9PYP2pGSHUgcelhwRsDnuSkzZNI60Kp/GgoRKVg7znkxYsaOlB9iKs/2tc=
Received: from KL1PR03MB7669.apcprd03.prod.outlook.com (2603:1096:820:e2::6)
 by TY0PR03MB6404.apcprd03.prod.outlook.com (2603:1096:400:14d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Mon, 6 Nov
 2023 13:07:03 +0000
Received: from KL1PR03MB7669.apcprd03.prod.outlook.com
 ([fe80::d87:c9fe:184:973f]) by KL1PR03MB7669.apcprd03.prod.outlook.com
 ([fe80::d87:c9fe:184:973f%5]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 13:07:03 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
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
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "jkardatzke@google.com" <jkardatzke@google.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 8/9] mailbox: mediatek: Add CMDQ secure mailbox driver
Thread-Topic: [PATCH v2 8/9] mailbox: mediatek: Add CMDQ secure mailbox driver
Thread-Index: AQHaBWrMQVxOcYxSTEao6mkcmGuQhbBs8O8AgABofoA=
Date:   Mon, 6 Nov 2023 13:07:03 +0000
Message-ID: <d905bc920e8a0375bed6a1e2e3fa20dbcb71417c.camel@mediatek.com>
References: <20231023043751.17114-1-jason-jh.lin@mediatek.com>
         <20231023043751.17114-9-jason-jh.lin@mediatek.com>
         <710408f06752201686f4b3587af1656d36e3654d.camel@mediatek.com>
In-Reply-To: <710408f06752201686f4b3587af1656d36e3654d.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7669:EE_|TY0PR03MB6404:EE_
x-ms-office365-filtering-correlation-id: 9030a78c-38b6-48fc-d23a-08dbdec9452c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jy0mTNzJ0s2uBW6u1/cttvVH+JORfgeJvoP6/+RTELyjeLEGZxmCakoOW3+O8OlQ2NVUJnKCXyZ4h5ieQ4iiSUfYDrh+gFzSewN9sNfQeMgLeWxqzI2WRGx2ZA3OzTOv3Ejfc0lAcC0OkruPDIhRR8LAv7TPv+PsU/va7qrEK1i4rjwKOWBzNUjURmwz4gItvRIcL8w5rCCzPp4qfVNCEQiEfbPou7KNz4AgCaJFb0wm9EDsp/YO3KGG3cLu0YFxuR8fy+uddO0QIowoNVadOYVIgmZGEu3gMKadvRv9Vpjd+cWRBANkILVMn+7jzQxz/4N0d73/xnO7v5qe0PchmkdRaeEhqgGaMzB7fvKZOuQnueyZddvc+n2uvh0vULyDWCX7YRxFGDyhK+9UAJcUaAcqcjnXk8hgWJFPJIQRINbS3fQn5RErA7EF0jx6D9L6InkGOAR979pgWZvOivqBnoCS1T2BJq5f3mXD2cU7gqdXvpYcijiGSwg0Yfl8EW022xSuF7yGaFSI7ndnN3X5uobeLrPB2QTLdDp4JfSgkW8MNhwneZyif0vX1hJ5bbYVWWSfxbbS0CdGCE4l12/zWmCCWYD1dpJkOOoi7qxPg6dUXlSPztRoDTWucdfM5SeeRC3QGfOJaiFWNnDwQR3j+qGlc+fi2YuB0rz0QUIy3PM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7669.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(396003)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(91956017)(4001150100001)(2906002)(15650500001)(41300700001)(64756008)(54906003)(66476007)(66446008)(86362001)(110136005)(38100700002)(6506007)(66556008)(76116006)(6512007)(478600001)(71200400001)(2616005)(83380400001)(6486002)(26005)(316002)(7416002)(5660300002)(36756003)(85182001)(38070700009)(4326008)(66946007)(122000001)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlhIQVhGMFppaXpzMW16dGgrVTdNSFhWUVNad0R4ZWl2SzZaL0hIVmo4REtV?=
 =?utf-8?B?Nm8yUUc4UGR3YW42THYwUnREWUJWV09mSGU4ZitSY0ZHK243ajROQndkZmhx?=
 =?utf-8?B?bVMrRHRuQTlsUnpXWUZNd0hoVDFqYnY5amplOGlvR3BvKytiT1JldDhObm82?=
 =?utf-8?B?QWpnOCs1MWVBcndkbHc1V1VQZnMzbE1JeEliSmIwVlljNnhUMXc4U1hUWU9i?=
 =?utf-8?B?WDVmeCs5L0l5L21sUVhiZEs1LzVyeFFtSVd2NjFIN2ptcHI1cit5ME83Z3F1?=
 =?utf-8?B?eTMxY1NabERud2w0V04rbjZDbTYreTZhSjlYdE10bFBxUFdpU0k1TjRnWUpq?=
 =?utf-8?B?NkVEcjhoa25qTlNlYnNiRS9EOU4rV3c3TUlYVkJMd2FKTmVRQnRFZyt1bi9V?=
 =?utf-8?B?WHFiREJyMkZZQ2x2OUt5Z2V2MDJ2WkxvcnhpalFQRGRCQlVic1QrbnU4M3JO?=
 =?utf-8?B?dktzMHdrb2FRR3JWUkw3eEI0cVVmSFBwU2REQW9BQXVsOWY4OXZUaVZHdDJv?=
 =?utf-8?B?cmxXT2h6dk1jR1hQUWVUOEFUZHdyVHZpTERMSi9Oa0JMNGM2Skl3SnU3THhJ?=
 =?utf-8?B?RjgvMU9FQzNiU2o0dGhvazZpY0IxODFjNHkzWHhBMXNiNGVvVDFqdzBSYjhX?=
 =?utf-8?B?TFZtV1gyV2dJL3FteGVsWGpXL2ZYMlVEYUR6YThDM3RkVTFpQmw1ZEw5dmt6?=
 =?utf-8?B?T1BJUmFpUzJsK3pBSkZrc2I2YXU3bE85a0ZrZk9OekxYb1p1TUNWZldReXRC?=
 =?utf-8?B?MElBREFxVmJHR3JENXNHaDNUc1ZRT3NRUURyNFFCWGR3VHErV2V0WHJNb251?=
 =?utf-8?B?Rm44K2tKaWVzTHdadmROWlgzQ1lYTDdXS3gzQmJkeDNoeVlhRjl1a2dGR0sr?=
 =?utf-8?B?UUFRZlA4Q3JhOTV5V3RFRU5qY0pLOVd5aExOSlBHNUxJYm9qeTU2T2x0c2xB?=
 =?utf-8?B?cE5KTzBaTDlSQTZRNU4wTlo4M0FlTWttZm5VajlTa1FRV2NraEJmN0cwQVUz?=
 =?utf-8?B?TDZMZ3lmRGlDOUFzWUJMOFloRS9qazhXYVNqRjh5ZU1QZ2RHYUN6bW9pd3pv?=
 =?utf-8?B?cmdiS3JzUWNyVVFLQXNXZE5QRDZFUzNZRDhYaVBrU2tybkp0OTluanh2L0l2?=
 =?utf-8?B?eVhoamhXOU4rTitQNzEvWFhjRTIyRnRwUzk4bWswbG8zNVVldTlTRTBYZzFI?=
 =?utf-8?B?a3FadlJmZVRIK1Q1bEY2QTJKS0NqR05DK0EweXY3cTNOUU9lT2Nrem8rakY1?=
 =?utf-8?B?Qm1kSCtBK1hNTnhXMHBRdzVLbTBnYTFrUjdoeXB4VDlFVjF5SU5oYlNaeTY1?=
 =?utf-8?B?N1lleHllSWpkTXh2OHN4YUR6RXRTSEJLaXNWUnJSaWNnNm1kK1BLMFVhMTZB?=
 =?utf-8?B?QmZsK2FuMkFBcGc4YXVkcFF2R0pNZVRQd2FCd2NhVytNNU1hOFNzZFVtcGRw?=
 =?utf-8?B?NlBwWWhGNWpSNkxBcnBVMU9pTElQQmRaMVU3di8rdk1oeDB1WTJqclRmMjh5?=
 =?utf-8?B?VHNyWFlZRnp0SjNwNm9DelZMQXRwSGxHRVpsMDJqeWlXNlpyMmtwYzQ4L1Er?=
 =?utf-8?B?TE15TDUxenY0Ny9hU0dFLzBpME9BTU1FMC93L2lBbDRzdHd2aG1zVENKczVU?=
 =?utf-8?B?YWMyK1pMZitsTEhxT0J0dmI5L1c5RE9ZWHRWSjZuWloySDZiOW4yTUs4YWhi?=
 =?utf-8?B?ejluK0dWMTBuSlZRbERPRTlicHE0QktYNVp3aDkzT20zcUpaVTRLelVnMFgx?=
 =?utf-8?B?U2s0ZzYxRkRvUzR6YWJDRzZBTThCZHdQTTVCNmhnS3RYQ2NzdllOTzhKZEEx?=
 =?utf-8?B?Zzltc1IwVllzbWtVdFVYZmIrNXdCTlhDc0xRb2I4WmFzTVdWSHRRbGpkc1c4?=
 =?utf-8?B?eFkwTUFQcHNjcG9RRmhCT2dyN3ppaVR6UHRXemdDSi8rb0I2Q3h4SDltQ09H?=
 =?utf-8?B?bEllRUtrVURtc1BIeitTTGpDT0FWVDlrd2pMZm9VN3pZWUhGYlhTdDFoMFJ0?=
 =?utf-8?B?OG16U2x2NFR2eFBvZWgwRmJDV3Q1UzdTeSs5N1N6dnRBU2dUcnZSLzJNVkNS?=
 =?utf-8?B?MVV6cnZxeDd3TEQ0Zk82d05UekgvZHczR0JQZHRNdFpsd2hFWTAxUk1ONk5L?=
 =?utf-8?B?cU5IUDFoVzFmamNIYmV0ZGdjRXhQa040OEdjNTZ6ZmN4S1lFMmRUMVVYR011?=
 =?utf-8?B?alE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EECC60E0E6AAAE41A0EB24F19A4B502B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7669.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9030a78c-38b6-48fc-d23a-08dbdec9452c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 13:07:03.3406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MIht2xsxB5N6mS32J8bpU/40xJxbkdvTiRI9bPZOSfxftPevNezgLgjpVgfsrm5eQBJp1qduqcnRYMJ6+fX1CI6zF0Cmo5qpEW5WCTg7thg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6404
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNCk9uIE1vbiwgMjAyMy0xMS0wNiBhdCAwNjo1MyArMDAwMCwgQ0sgSHUgKOiDoeS/
iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4gDQo+IE9uIE1vbiwgMjAyMy0xMC0yMyBhdCAx
MjozNyArMDgwMCwgSmFzb24tSkguTGluIHdyb3RlOg0KPiA+IFRvIHN1cHBvcnQgc2VjdXJlIHZp
ZGVvIHBhdGggZmVhdHVyZSwgR0NFIGhhdmUgdG8gcmVhZC93cml0ZQ0KPiA+IHJlZ2lzdGdlcnMN
Cj4gPiBpbiB0aGUgc2VjdXJlIHdvcmxkLiBHQ0Ugd2lsbCBlbmFibGUgdGhlIHNlY3VyZSBhY2Nl
c3MgcGVybWlzc2lvbg0KPiA+IHRvDQo+ID4gdGhlDQo+ID4gSFcgd2hvIHdhbnRzIHRvIGFjY2Vz
cyB0aGUgc2VjdXJlIGNvbnRlbnQgYnVmZmVyLg0KPiA+IA0KPiA+IEFkZCBDTURRIHNlY3VyZSBt
YWlsYm94IGRyaXZlciB0byBtYWtlIENNRFEgY2xpZW50IHVzZXIgaXMgYWJsZSB0bw0KPiA+IHNl
bmRpbmcgdGhlaXIgSFcgc2V0dGluZ3MgdG8gdGhlIHNlY3VyZSB3b3JsZC4gU28gdGhhdCBHQ0Ug
Y2FuDQo+ID4gZXhlY3V0ZQ0KPiA+IGFsbCBpbnN0cnVjdGlvbnMgdG8gY29uZmlndXJlIEhXIGlu
IHRoZSBzZWN1cmUgd29ybGQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGlu
IDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21haWxi
b3gvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgfCAgICAyICstDQo+ID4gIGRyaXZlcnMv
bWFpbGJveC9tdGstY21kcS1zZWMtbWFpbGJveC5jICAgICAgICB8IDExMDINCj4gPiArKysrKysr
KysrKysrKysrKw0KPiA+ICBkcml2ZXJzL21haWxib3gvbXRrLWNtZHEtc2VjLXRlZS5jICAgICAg
ICAgICAgfCAgMjAyICsrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFp
bGJveC5oICAgICAgfCAgICAyICsNCj4gPiAgLi4uL2xpbnV4L21haWxib3gvbXRrLWNtZHEtc2Vj
LWl3Yy1jb21tb24uaCAgIHwgIDI5MyArKysrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L21haWxib3gv
bXRrLWNtZHEtc2VjLW1haWxib3guaCAgfCAgIDgzICsrDQo+ID4gIGluY2x1ZGUvbGludXgvbWFp
bGJveC9tdGstY21kcS1zZWMtdGVlLmggICAgICB8ICAgMzEgKw0KPiA+ICA3IGZpbGVzIGNoYW5n
ZWQsIDE3MTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ICBjcmVhdGUgbW9kZSAx
MDA2NDQgZHJpdmVycy9tYWlsYm94L210ay1jbWRxLXNlYy1tYWlsYm94LmMNCj4gPiAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvbWFpbGJveC9tdGstY21kcS1zZWMtdGVlLmMNCj4gPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1zZWMtaXdjLWNv
bW1vbi5oDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRr
LWNtZHEtc2VjLW1haWxib3guaA0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51
eC9tYWlsYm94L210ay1jbWRxLXNlYy10ZWUuaA0KPiA+IA0KPiA+IA0KPiANCj4gW3NuaXBdDQo+
IA0KPiA+ICsNCj4gPiAraW50IGNtZHFfc2VjX2luc2VydF9iYWNrdXBfY29va2llKHN0cnVjdCBj
bWRxX3BrdCAqcGt0KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgY21kcV9jbGllbnQgKmNsID0gKHN0
cnVjdCBjbWRxX2NsaWVudCAqKXBrdC0+Y2w7DQo+ID4gKwlzdHJ1Y3QgY21kcV9zZWNfdGhyZWFk
ICp0aHJlYWQgPSAoKHN0cnVjdCBtYm94X2NoYW4gKikoY2wtDQo+ID4gPiBjaGFuKSktPmNvbl9w
cml2Ow0KPiA+IA0KPiA+ICsJc3RydWN0IGNtZHFfc2VjICpjbWRxID0gY29udGFpbmVyX29mKHRo
cmVhZC0+Y2hhbi0+bWJveCwgc3RydWN0DQo+ID4gY21kcV9zZWMsIG1ib3gpOw0KPiA+ICsJc3Ry
dWN0IGNtZHFfb3BlcmFuZCBsZWZ0LCByaWdodDsNCj4gPiArCWRtYV9hZGRyX3QgYWRkcjsNCj4g
PiArDQo+ID4gKwlpZiAoIXRocmVhZC0+b2NjdXBpZWQgfHwgIWNtZHEtPnNoYXJlZF9tZW0pDQo+
ID4gKwkJcmV0dXJuIC1FRkFVTFQ7DQo+ID4gKw0KPiA+ICsJcHJfZGVidWcoIiVzICVkOiBwa3Q6
JXAgdGhyZWFkOiV1IGdjZTolI2x4IiwNCj4gPiArCQkgX19mdW5jX18sIF9fTElORV9fLCBwa3Qs
IHRocmVhZC0+aWR4LCAodW5zaWduZWQNCj4gPiBsb25nKWNtZHEtPmJhc2VfcGEpOw0KPiA+ICsN
Cj4gPiArCWFkZHIgPSAodTMyKShjbWRxLT5iYXNlX3BhICsgQ01EUV9USFJfQkFTRSArDQo+ID4g
KwkJQ01EUV9USFJfU0laRSAqIHRocmVhZC0+aWR4ICsgQ01EUV9USFJfRVhFQ19DTlRfUEEpOw0K
PiA+ICsNCj4gPiArCWNtZHFfcGt0X2Fzc2lnbihwa3QsIENNRFFfVEhSX1NQUl9JRFgxLCBDTURR
X0FERFJfSElHSChhZGRyKSk7DQo+ID4gKwljbWRxX3BrdF9yZWFkX3MocGt0LCBDTURRX1RIUl9T
UFJfSURYMSwgQ01EUV9BRERSX0xPVyhhZGRyKSwNCj4gPiBDTURRX1RIUl9TUFJfSURYMSk7DQo+
ID4gKw0KPiA+ICsJbGVmdC5yZWcgPSB0cnVlOw0KPiA+ICsJbGVmdC5pZHggPSBDTURRX1RIUl9T
UFJfSURYMTsNCj4gPiArCXJpZ2h0LnJlZyA9IGZhbHNlOw0KPiA+ICsJcmlnaHQudmFsdWUgPSAx
Ow0KPiA+ICsJY21kcV9wa3RfbG9naWNfY29tbWFuZChwa3QsIENNRFFfTE9HSUNfQURELCBDTURR
X1RIUl9TUFJfSURYMSwNCj4gPiAmbGVmdCwgJnJpZ2h0KTsNCj4gPiArDQo+ID4gKwlhZGRyID0g
Y21kcS0+c2hhcmVkX21lbS0+cGEgKyBDTURRX1NFQ19TSEFSRURfVEhSX0NOVF9PRkZTRVQgKw0K
PiA+ICsJCXRocmVhZC0+aWR4ICogc2l6ZW9mKHUzMik7DQo+ID4gKw0KPiA+ICsJY21kcV9wa3Rf
YXNzaWduKHBrdCwgQ01EUV9USFJfU1BSX0lEWDIsIENNRFFfQUREUl9ISUdIKGFkZHIpKTsNCj4g
PiArCWNtZHFfcGt0X3dyaXRlX3MocGt0LCBDTURRX1RIUl9TUFJfSURYMiwgQ01EUV9BRERSX0xP
VyhhZGRyKSwNCj4gPiBDTURRX1RIUl9TUFJfSURYMSk7DQo+IA0KPiBUaGlzIGlzIGEgc2FtcGxl
IGNvZGUgb2YgcmVhZGluZyBzZWN1cmUgZGF0YSBhbmQgd3JpdGluZyB0byBub3JtYWwNCj4gd29y
bGQuIEkgdGhpbmsgeW91IGhhdmUgYWxyZWFkeSBjaGVjayBhZGRyZXNzIG9mIGNtZHFfcGt0X3Jl
YWRfcygpIGluDQo+IFRFRS4gVGhpcyBpcyBhIHNhbXBsZSBjb2RlIHRoYXQgaGFja2VyIG1heSB0
cnkgdG8gcmVhZCBhbnkgc2VjdXJlDQo+IGFkZHJlc3M6DQo+IA0KPiAJY21kcV9wa3RfYXNzaWdu
KHBrdCwgQ01EUV9USFJfU1BSX0lEWDEsDQo+IENNRFFfQUREUl9ISUdIKGhhY2tfYWRkcmVzcykp
Ow0KPiAJY21kcV9wa3RfanVtcChwa3QsIHJlYWQpOw0KPiAJY21kcV9wa3RfYXNzaWduKHBrdCwg
Q01EUV9USFJfU1BSX0lEWDEsIENNRFFfQUREUl9ISUdIKGFkZHIpKTsNCj4gcmVhZDoNCj4gCWNt
ZHFfcGt0X3JlYWRfcyhwa3QsIENNRFFfVEhSX1NQUl9JRFgxLCBDTURRX0FERFJfTE9XKGFkZHIp
LA0KPiAJCUNNRFFfVEhSX1NQUl9JRFgxKTsNCj4gDQo+IFBsZWFzZSBleHBsYWluIGhvdyB5b3Ug
cHJvdGVjdCB0aGlzIGhhY2tlciBhdHRhY2suDQo+IA0KDQpZZXMsIGhhY2tlcnMgY2FuIHVzZSB0
aGlzIHNhbXBsZSBjb2RlIHRvIHJlYWQgdGhlIEhXIHJlZ2lzdGVyIHRvIHRoZQ0Kc2hhcmVkIG1l
bW9yeSwgYnV0IHRoZXkgc3RpbGwgY2FuJ3QgZ2V0IHRoZSBzZWN1cmUgY29udGVudCBvciBvdGhl
cg0KdXNlZnVsIGluZm9ybWF0aW9uIHRvIGdldCB0aGUgc2VjdXJlIGNvbnRlbnQuDQoNClRoZXJl
IGFyZSBzb21lIHByb3RlY3Rpb25zIHdlIG1hZGUgZm9yIHRoaXMgYWN0aW9uOg0KMS4gQWxsIHRo
ZSBwaHlzaWNhbCBhZGRyZXNzIG9mIEhXIHJlZ2lzdGVyIGluIHRoZSByZWFkL3dyaXRlDQppbnN0
cnVjdGlvbiBpbiBzZWN1cmUgY29tbWFuZCBidWZmZXIgbmVlZCB0byBiZSBkZWZpbmVkIGF0IHdo
aXRlbGlzdC4NCjIuIFJlYWRpbmcgRFJBTSBhZGRyZXNzIGluc3RydWN0aW9uIGluIHNlY3VyZSBj
b21tYW5kIGJ1ZmZlciBhcmUNCmZvcmJpZGRlbi4NCjMuIFRoZSBzaGFyZWQgbWVtb3J5IGlzIHVz
ZWQgdG8gc3RvcmUgdGhlIHZhbHVlIG9mIGNvb2tpZSB3aGljaCBpcyB1c2VkDQpmb3Igc2VjdXJl
IGNtZHEgcGFja2V0IHNjaGVkdWxpbmcuIFNvIHNlY3VyZSBHQ0UgdGhyZWFkIGV4ZWN1dGluZyBz
dGF0ZQ0Kd2lsbCBjcmFzaCBieSBtb2RpZnlpbmcgaXQgdW5leHBlY3RlZGx5Lg0KDQpBbHRob3Vn
aCBoYWNrZXJzIGNvdWxkIGdldCB0aGUgdmFsdWUgc3RvcmUgaW4gdGhlIEhXIHJlZ2lzdGVyIGJ5
IHRoaXMNCnNhbXBsZSBjb2RlLCB0aGV5IHN0aWxsIGRvbid0IGtub3cgd2hhdCB0aGUgSFcgcmVn
aXN0ZXIgc3RhbmQgZm9yIGFuZCANCndoYXQgaXMgdGhlIG1lYW5pbmcgb2YgdGhlIHZhbHVlIHRo
ZXkgcmVhZC4gQWRkaXRpb25hbGx5LCBpZiB0aGV5IHJlYWQNCnVuZXhwZWN0ZWRseSB2YWx1ZXMg
aW50byBzaGFyZWQgbWVtb3J5LCB0aGV5IHdpbGwgY29ycnVwdCB0aGUgc2VjdXJlDQpHQ0UgdGhy
ZWFkIHN0YXRlLg0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCj4gUmVnYXJkcywNCj4gQ0sN
Cj4gDQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJPTChj
bWRxX3NlY19pbnNlcnRfYmFja3VwX2Nvb2tpZSk7DQo+ID4gKw0K

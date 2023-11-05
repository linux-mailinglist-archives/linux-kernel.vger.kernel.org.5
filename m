Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FFA7E139A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 14:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjKENTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 08:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjKENTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 08:19:14 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A2D95;
        Sun,  5 Nov 2023 05:19:09 -0800 (PST)
X-UUID: e306806a7bdd11ee8051498923ad61e6-20231105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=5VivCBlFboUnR0kiQMJCDbj/sDh2DdDrrFBfoSoFIqo=;
        b=kww9nfYFAFJ+hKizZWKb3w4d3mIYMkyBiKeleuFgaspesiiwimaNrTBPUzzvoKe5QorB3JXRAnb3y65QAFeThZEMM3fhmL5D4oBZ9KcLeu1aCGnVR3mqPnJJSfDd0pAkn9Q3V6Cqn2kear10wSjNKTWSVMso9lhxXbaz1FGHys0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:56df2f57-feb9-4e4c-b799-6a9106de993c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:8d660795-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e306806a7bdd11ee8051498923ad61e6-20231105
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2126383954; Sun, 05 Nov 2023 21:19:02 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 5 Nov 2023 21:19:01 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 5 Nov 2023 21:19:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvCQU/U3V5zP975dNn8+umc/YTwHbwZ82Y48EbzIDe+3wRCwKVJFMwcpt8y7perpXC2I+krlqhKOqMLPN0dqEtWvm+6XTeztViArgCGqVCsnG90WjZ5sIMF9Gilnzj+a3cfJdC4X55/c9A1eKK99XfWBvTgwLVPeUdpSVJC8Y20vUFt1IUA09CaMpjD16HybB7rmt3wx1Ud9wEW+8O6Mr1nq40U32Yb/uo8wH2ToKVFe0/wmyP9fsJejp3A+NN841QHfxNmgUBPGOJ56qsVGRrCUbnb3AVDpjVxZRoO3DUfApTnV2tRLw+19q1RVSUVaW8+LQjKfScESY3eiNm7ogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VivCBlFboUnR0kiQMJCDbj/sDh2DdDrrFBfoSoFIqo=;
 b=dbuE9HJQLRFcTumLWYUvgHrWxvr3MKOGvTesWQ7f9+anrPfrnkBJsBOGzKR2jCBUsufg19sAzWNO/DcRI4Cpq/4VLsa7spGqvy2o3h8VL+3Z1sKXB0clIEVdLu5eROnBJgIr/lJLysVux8MRzm348oMn09YONP6gkO8zEtq4SFhtQEBfQ1PEsJuTNccfppH5JHeLkv6ChhD5Pbqd5n1LMUdNp58IRHnwWG5/CPUU6bUbx1MQ3f+qV4/Bt4nHeVomrhvGh6doPkr4q06hX2jnhqo3EchAym0PMhg22K8unsEyNNQATCQ85fWfOfoNeNVJ81MACa+GMbCch4/wURc6pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VivCBlFboUnR0kiQMJCDbj/sDh2DdDrrFBfoSoFIqo=;
 b=bXyNIB0JhhqWdt3fK1i9q+A4Pi6Mx9O6E17rMXJ/mMiFxyAoRaY9nn5u9u7mAhPOSB1JVin/H/hqKCHZ0OyKOx6qbTsWMqRfoobR0UiCTbSAZPjB86QYBrdG9Jf8HmfKEgr+zaHjouU+8FfYVr8Mi+8qeDcMj+/71D4prAbLeoA=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by OSQPR03MB8460.apcprd03.prod.outlook.com (2603:1096:604:277::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Sun, 5 Nov
 2023 13:18:57 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88%5]) with mapi id 15.20.6954.025; Sun, 5 Nov 2023
 13:18:56 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
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
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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
Subject: Re: [PATCH v2 07/11] drm/mediatek: Add secure layer config support
 for ovl
Thread-Topic: [PATCH v2 07/11] drm/mediatek: Add secure layer config support
 for ovl
Thread-Index: AQHaBWvoijbhEc/R00mY51hFdbW5LrBb3XkAgA/s8IA=
Date:   Sun, 5 Nov 2023 13:18:56 +0000
Message-ID: <966e530d745c128f299e67b5bcd2437f5f313ec8.camel@mediatek.com>
References: <20231023044549.21412-1-jason-jh.lin@mediatek.com>
         <20231023044549.21412-8-jason-jh.lin@mediatek.com>
         <3af3f0919045e806b7cc2c36fb99bff8918f874e.camel@mediatek.com>
In-Reply-To: <3af3f0919045e806b7cc2c36fb99bff8918f874e.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|OSQPR03MB8460:EE_
x-ms-office365-filtering-correlation-id: 5e7ddc91-d16b-475b-1724-08dbde01c3ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YJhjDVcFV7VYLYajJD7U6EBVUpZ8lphedomPQKNMKToqEDtXwOjYXj8VhJZt5rSfrh7D8Pv+RQeMesCAVqOBFY4fATqENr9w1zg/sZQyYBrtPS7Le7JeD6O0e6efr+sIGrAlk2y5fTI3MQjwKqIusrz80ioqRLbgegzYcvdizbeLI9teEItfy1uKw6wra7ozjLahcZ/x+3UyWjk80qscGJN+p8exd/idkVh3iGzaSLjjo5PVtJnMO24SaQX8IZLu65fLgj5JQBzkCAPLZOzkoEhsxyoDCYbaDat3k3wbCiD1iHbm5E2e+hWDx0f7jhuMt0s/9FWHD6xumyPrKAW93pHrmEdcjCLrl9azdFgk2LVUW6P3HkM1jlqhrvyMUBQfreNEvLWLbLeRV+CO/9Zakurl1LriatNhzsf0YHxIlzrIDmSpcb+OY9q/KsQ1Yc+vErirARwSb8k5HJFMS2wLgqHSex4GVYHHlmEtETRlbjMz1y+Vejcj3ESyE30HTHPhL/bIkVQ3jZMoAOKN1TJxSYaWU3+d8Xp375MOmRYMZ6gNnRKQX5URsP2A3DqfAg6mavaXnhcr2Sm6MP2kPeyIsrq1s280w+zZloOoCdW7al4cpJ57Npx+HoflkIwqvD8uxDWf0jML4p3sygVlBCgfKJ04y4g2hhCcviKbeOvkJFI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2616005)(122000001)(6512007)(26005)(38070700009)(478600001)(6486002)(8936002)(5660300002)(36756003)(85182001)(4326008)(8676002)(4001150100001)(41300700001)(86362001)(7416002)(2906002)(66556008)(66476007)(66446008)(54906003)(64756008)(66946007)(76116006)(316002)(110136005)(91956017)(71200400001)(6506007)(38100700002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekVzNDBOZXgvUmtEVnRRRVphWS82UWZKcDhSdmhlRndlNnpONCtiV2FnQmpo?=
 =?utf-8?B?R2pkcW9GU2lSc2FKQnE1N3BWcWdRQjZ0MElxaExGdHk5MkRpR0hXMDlFOVlq?=
 =?utf-8?B?UlM2amZmYlpyZXkvbFVRRXk5T3hXTFppRnRVeW1tdUxuZWdrN1M1eEQzZ0wx?=
 =?utf-8?B?Wm12Uk1uVkVlZTBLWWI1ZVhGUkg2bnRwODdDSFdEWGhUVkZxRE1ua2JDSGsx?=
 =?utf-8?B?cU9yNC9KeWRYb0pmZm5EeFlUUytiR2lNYU8rUSs3REhTMzVvRHRCaUo1K2E3?=
 =?utf-8?B?K0NKaVArTW5EUXpDcjdCY2tTQ1BtdGhFY01id2pmZTZxTnM3UUQ3NjNtWEZN?=
 =?utf-8?B?alNTSkdrN1IvZVlZZjVQU2JZOXU4UHRqWXdyT3J3TU5EMVRTclkrOTAyMzZJ?=
 =?utf-8?B?YURXZTlFZmIwQlhqN2FUU3lxeWpoVzFWSEo5WFdYRlg0bFVhVWp2a1JiV2xv?=
 =?utf-8?B?WkJHaG1YbnNWVEZjbkxCRGN1VG5pNU9MMm1scHVUd1ZrWkRhQ01Id0JMdTFj?=
 =?utf-8?B?L3hWSCswaGlQUjRvaHFCdzI3M0Z1UE5BMUYydkVpaXVhRm1mYXUwbC9QTEdP?=
 =?utf-8?B?Uyt6em9hWjhRWkxrWkVMOEo2NEdvMTFZOUUxMUl4R1YwTU5iUkNpU3F2bm1n?=
 =?utf-8?B?ckhURjZXOXZsM3NtMG1TMGJYN2oyWjFxNXh4RnV3OCtvV3Y5bVB0ZVlEdVN5?=
 =?utf-8?B?QjNRZWRwQmZTcllIRmhNZFUwNUNGcHB0cStsUGhVRDV0TjdKWjE5VVVGWW85?=
 =?utf-8?B?cFZjSUJ5dXB2eG5LTklZdkY3ZTI2Q1dIdlAybldUdnZWVkE0WE91ZzNMQ0ht?=
 =?utf-8?B?T2lxT1hUTjB5MmdaRjM1Z3VuWkltNUVnbVR2Ym40NlY4b0dTS1ZySEY0dy9I?=
 =?utf-8?B?U21TY29ERHh1K2tUUHdUU3VZUGIwZlhacXFLbFZIakd4TitEbHBXTWxXOGtm?=
 =?utf-8?B?S09OKzMzblZyby9OWi9UZkhsK2JsbXgxNnZkOUs2cGhrNlVIMGRWWHk4eDZE?=
 =?utf-8?B?eGxkWStSdFlkMkt6cURYMWJNMGhJdG41aUo4c1hPNy8wdGQvZk8rMW94WjFV?=
 =?utf-8?B?RkdhMFNBaUpuRW4zaUdwYnh2QVlob05GT1U2dmdyNWw2TThzenZxVHc2SmRy?=
 =?utf-8?B?SExpcVBjeWluRWEwU01aQUNUVmdNL1hjaFBQK3ZyNjhNZUdYcFZyTzc0dDRu?=
 =?utf-8?B?RzRHc2lxVlM1RVVCNlkzQ1hkTGUrenJxRHRaaUJSdGpFemEvTHJINDk3aFpR?=
 =?utf-8?B?ZXlpU0twYlZlcnROMWYrL0hRdTJTVEsyZDZFWHdpSldDYnhsTVZ3YmIxWGxP?=
 =?utf-8?B?dGpQZEhobUlSbTd2NEs5TkRvQXBIenBFMG5lckN4QlpJN1FxQXcwNlRlTVpy?=
 =?utf-8?B?Z3NBdHVJSVVXTXgrVDZ3dUQwMnlqK3hweUlaU3N0MUgvZGNBYUFDRU5aOC9u?=
 =?utf-8?B?Smw2YUxadjIvQi9ZMHVYY3RYNUp1NVpIOW9PcDljSFY0eEV1Sjd1U0dOSnMw?=
 =?utf-8?B?c2VqN1loV1JLS2Q1N0VCdFlUOFpuMTkrQmZONU1yZEs3YjRqUWRUTFNibHk4?=
 =?utf-8?B?UlFNVlB1dU0zRXVFUnl4b3RQK0ZvK2xLWXdpK05TcFJIMTMwRUpPaUlObFRB?=
 =?utf-8?B?bzB3cFVOR0Y4WjFtdWxlZ2VzUy9xMkhrZTVVOVlneUZ0NGthSFU0NjRadmJt?=
 =?utf-8?B?QnQ1RmdCRjBVeU4zYWFUVkk0Y3Nnd2ZGWXBGb05xRnpKUitPU3V3Sit1d2lC?=
 =?utf-8?B?VERPTy9xckEwOW9kSTYvVCt1aXJENGVmdXBlNVhmWGlQWkV4ZzFabUNSK2FD?=
 =?utf-8?B?eFNvT3VYdm81WTE0V0lqZlNSNmV6VnBleGtkVlllZFVZY2REdXBiMXVBQ0pD?=
 =?utf-8?B?QTl5eVluMVhuMTQ0a1lwWDJVYit1WFA4b2dMRHdOdzVTUVJOYTdUNnNRN1Ji?=
 =?utf-8?B?dXBOSFg3WGoxWlVsaTQvNTJ1ZFBudlFMd204VHYxLzYyOVFFU1BlSjVuVGxE?=
 =?utf-8?B?a1RjMjk2aEdwMjJIa3JQZVlYUnJkS05IYkI3RnkxNFVDRTVpQTMySDJtU0RJ?=
 =?utf-8?B?Y25Eb1lsUkRKaTQ0bmJhUGEwUWdMNHp3Zm9oTHRGRmVndUwwUzc3ZkMvWFZV?=
 =?utf-8?B?elBUdXdrZUdtcGNWU2kva0tuaGhqT2xmalRoeXBOZyt1eG9sY0J4cjlPUTNC?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E48B5F55146C945A8354B9B50C02289@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7ddc91-d16b-475b-1724-08dbde01c3ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2023 13:18:56.5835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hZOBgT+Jfh7djHHh2BjoSljSzJM9CJNS+S+4c7DjWFvz4xmnTynJv9d8trRZG6zxrLtB7msG8M1VGB1sKPBpH5oR1qi6HKeJs0Rv93EEemM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8460
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNCk9uIFRodSwgMjAyMy0xMC0yNiBhdCAxMDowNyArMDAwMCwgQ0sgSHUgKOiDoeS/
iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4gDQo+IE9uIE1vbiwgMjAyMy0xMC0yMyBhdCAx
Mjo0NSArMDgwMCwgSmFzb24tSkguTGluIHdyb3RlOg0KPiA+IEFkZCBzZWN1cmUgbGF5ZXIgY29u
ZmlnIHN1cHBvcnQgZm9yIG92bC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5M
aW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaCAgICAgICB8ICAzICsrDQo+ID4gIGRyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYyAgICAgICB8IDMxDQo+ID4gKysrKysrKysr
KysrKysrKystLQ0KPiA+ICAuLi4vZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRv
ci5jICAgfCAxMiArKysrKysrDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2RkcF9jb21wLmMgICB8ICAyICsrDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgNDYgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gPiBpbmRleCAyMjU0MDM4NTE5ZTEuLmRlYzkzN2IxODNhOCAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgN
Cj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gPiBA
QCAtOSw2ICs5LDcgQEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3NvYy9tZWRpYXRlay9tdGstY21k
cS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvc29jL21lZGlhdGVrL210ay1tbXN5cy5oPg0KPiA+
ICAjaW5jbHVkZSA8bGludXgvc29jL21lZGlhdGVrL210ay1tdXRleC5oPg0KPiA+ICsjaW5jbHVk
ZSAibXRrX2RybV9kZHBfY29tcC5oIg0KPiA+ICAjaW5jbHVkZSAibXRrX2RybV9wbGFuZS5oIg0K
PiA+ICAjaW5jbHVkZSAibXRrX21kcF9yZG1hLmgiDQo+ID4gIA0KPiA+IEBAIC03OSw2ICs4MCw3
IEBAIHZvaWQgbXRrX292bF9jbGtfZGlzYWJsZShzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiA+ICB2
b2lkIG10a19vdmxfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IHcsDQo+
ID4gIAkJICAgIHVuc2lnbmVkIGludCBoLCB1bnNpZ25lZCBpbnQgdnJlZnJlc2gsDQo+ID4gIAkJ
ICAgIHVuc2lnbmVkIGludCBicGMsIHN0cnVjdCBjbWRxX3BrdCAqY21kcV9wa3QpOw0KPiA+ICt1
NjQgbXRrX292bF9nZXRfc2VjX3BvcnQoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCwgdW5zaWdu
ZWQgaW50DQo+ID4gaWR4KTsNCj4gPiAgaW50IG10a19vdmxfbGF5ZXJfY2hlY2soc3RydWN0IGRl
dmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgaWR4LA0KPiA+ICAJCQlzdHJ1Y3QgbXRrX3BsYW5lX3N0
YXRlICptdGtfc3RhdGUpOw0KPiA+ICB2b2lkIG10a19vdmxfbGF5ZXJfY29uZmlnKHN0cnVjdCBk
ZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IGlkeCwNCj4gPiBAQCAtMTEyLDYgKzExNCw3IEBAIHZv
aWQgbXRrX292bF9hZGFwdG9yX2Nsa19kaXNhYmxlKHN0cnVjdCBkZXZpY2UNCj4gPiAqZGV2KTsN
Cj4gPiAgdm9pZCBtdGtfb3ZsX2FkYXB0b3JfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5z
aWduZWQgaW50IHcsDQo+ID4gIAkJCSAgICB1bnNpZ25lZCBpbnQgaCwgdW5zaWduZWQgaW50IHZy
ZWZyZXNoLA0KPiA+ICAJCQkgICAgdW5zaWduZWQgaW50IGJwYywgc3RydWN0IGNtZHFfcGt0DQo+
ID4gKmNtZHFfcGt0KTsNCj4gPiArdTY0IG10a19vdmxfYWRhcHRvcl9nZXRfc2VjX3BvcnQoc3Ry
dWN0IG10a19kZHBfY29tcCAqY29tcCwNCj4gPiB1bnNpZ25lZA0KPiA+IGludCBpZHgpOw0KPiA+
ICB2b2lkIG10a19vdmxfYWRhcHRvcl9sYXllcl9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LCB1
bnNpZ25lZCBpbnQNCj4gPiBpZHgsDQo+ID4gIAkJCQkgIHN0cnVjdCBtdGtfcGxhbmVfc3RhdGUg
KnN0YXRlLA0KPiA+ICAJCQkJICBzdHJ1Y3QgY21kcV9wa3QgKmNtZHFfcGt0KTsNCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+ID4gYi9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gPiBpbmRleCAyYmZmZTQy
NDU0NjYuLjc2ZTgzMmU0ODc1YSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2Rpc3Bfb3ZsLmMNCj4gPiBAQCAtNDYsNiArNDYsNyBAQA0KPiA+ICAjZGVmaW5lIERJU1Bf
UkVHX09WTF9BRERSKG92bCwgbikJCSgob3ZsKS0+ZGF0YS0+YWRkciArDQo+ID4gMHgyMCAqIChu
KSkNCj4gPiAgI2RlZmluZSBESVNQX1JFR19PVkxfSERSX0FERFIob3ZsLCBuKQkJKChvdmwpLT5k
YXRhLQ0KPiA+ID4gYWRkciArIDB4MjAgKiAobikgKyAweDA0KQ0KPiA+IA0KPiA+ICAjZGVmaW5l
IERJU1BfUkVHX09WTF9IRFJfUElUQ0gob3ZsLCBuKQkJKChvdmwpLT5kYXRhLQ0KPiA+ID4gYWRk
ciArIDB4MjAgKiAobikgKyAweDA4KQ0KPiA+IA0KPiA+ICsjZGVmaW5lIERJU1BfUkVHX09WTF9T
RUNVUkUJCQkweDBmYzANCj4gPiAgDQo+ID4gICNkZWZpbmUgR01DX1RIUkVTSE9MRF9CSVRTCTE2
DQo+ID4gICNkZWZpbmUgR01DX1RIUkVTSE9MRF9ISUdICSgoMSA8PCBHTUNfVEhSRVNIT0xEX0JJ
VFMpIC8gNCkNCj4gPiBAQCAtMTI2LDggKzEyNywxOSBAQCBzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsIHsN
Cj4gPiAgCWNvbnN0IHN0cnVjdCBtdGtfZGlzcF9vdmxfZGF0YQkqZGF0YTsNCj4gPiAgCXZvaWQJ
CQkJKCp2YmxhbmtfY2IpKHZvaWQgKmRhdGEpOw0KPiA+ICAJdm9pZAkJCQkqdmJsYW5rX2NiX2Rh
dGE7DQo+ID4gKwlyZXNvdXJjZV9zaXplX3QJCQlyZWdzX3BhOw0KPiA+ICB9Ow0KPiA+ICANCj4g
PiArdTY0IG10a19vdmxfZ2V0X3NlY19wb3J0KHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAsIHVu
c2lnbmVkIGludA0KPiA+IGlkeCkNCj4gPiArew0KPiA+ICsJaWYgKGNvbXAtPmlkID09IEREUF9D
T01QT05FTlRfT1ZMMCkNCj4gPiArCQlyZXR1cm4gMVVMTCA8PCBDTURRX1NFQ19ESVNQX09WTDA7
DQo+ID4gKwllbHNlIGlmIChjb21wLT5pZCA9PSBERFBfQ09NUE9ORU5UX09WTDEpDQo+ID4gKwkJ
cmV0dXJuIDFVTEwgPDwgQ01EUV9TRUNfRElTUF9PVkwxOw0KPiA+ICsNCj4gPiArCXJldHVybiAw
Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMgaXJxcmV0dXJuX3QgbXRrX2Rpc3Bfb3ZsX2ly
cV9oYW5kbGVyKGludCBpcnEsIHZvaWQgKmRldl9pZCkNCj4gPiAgew0KPiA+ICAJc3RydWN0IG10
a19kaXNwX292bCAqcHJpdiA9IGRldl9pZDsNCj4gPiBAQCAtNDQ5LDggKzQ2MSwyMiBAQCB2b2lk
IG10a19vdmxfbGF5ZXJfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiB1bnNpZ25lZCBp
bnQgaWR4LA0KPiA+ICAJCQkgICAgICBESVNQX1JFR19PVkxfU1JDX1NJWkUoaWR4KSk7DQo+ID4g
IAltdGtfZGRwX3dyaXRlX3JlbGF4ZWQoY21kcV9wa3QsIG9mZnNldCwgJm92bC0+Y21kcV9yZWcs
IG92bC0NCj4gPiA+IHJlZ3MsDQo+ID4gDQo+ID4gIAkJCSAgICAgIERJU1BfUkVHX09WTF9PRkZT
RVQoaWR4KSk7DQo+ID4gLQltdGtfZGRwX3dyaXRlX3JlbGF4ZWQoY21kcV9wa3QsIGFkZHIsICZv
dmwtPmNtZHFfcmVnLCBvdmwtDQo+ID4gPiByZWdzLA0KPiA+IA0KPiA+IC0JCQkgICAgICBESVNQ
X1JFR19PVkxfQUREUihvdmwsIGlkeCkpOw0KPiA+ICsNCj4gPiArCWlmIChzdGF0ZS0+cGVuZGlu
Zy5pc19zZWMpIHsNCj4gPiArCQljb25zdCBzdHJ1Y3QgZHJtX2Zvcm1hdF9pbmZvICpmbXRfaW5m
byA9DQo+ID4gZHJtX2Zvcm1hdF9pbmZvKGZtdCk7DQo+ID4gKwkJdW5zaWduZWQgaW50IGJ1Zl9z
aXplID0gKHBlbmRpbmctPmhlaWdodCAtIDEpICoNCj4gPiBwZW5kaW5nLT5waXRjaCArDQo+ID4g
KwkJCQkJcGVuZGluZy0+d2lkdGggKiBmbXRfaW5mby0NCj4gPiA+IGNwcFswXTsNCj4gPiANCj4g
PiArDQo+ID4gKwkJbXRrX2RkcF93cml0ZV9tYXNrKGNtZHFfcGt0LCBCSVQoaWR4KSwgJm92bC0+
Y21kcV9yZWcsDQo+ID4gb3ZsLT5yZWdzLA0KPiA+ICsJCQkJICAgRElTUF9SRUdfT1ZMX1NFQ1VS
RSwgQklUKGlkeCkpOw0KPiA+ICsJCW10a19kZHBfc2VjX3dyaXRlKGNtZHFfcGt0LCBvdmwtPnJl
Z3NfcGEgKw0KPiA+IERJU1BfUkVHX09WTF9BRERSKG92bCwgaWR4KSwNCj4gPiArCQkJCSAgcGVu
ZGluZy0+YWRkciwgQ01EUV9JV0NfSF8yX01WQSwgMCwNCj4gPiBidWZfc2l6ZSwgMCk7DQo+IA0K
PiBXaHkgcGFzcyBvdmwtPnJlZ3NfcGEgaW50byBjbWRxIGRyaXZlcj8gY21kcSBqdXN0IG5lZWQg
c3Vic3lzIGFuZA0KPiBvZmZzZXQuDQoNClllcywgdGhhdCdzIG5vdCBuZWNlc3NhcnkgYW5kIEkg
Y2FuIHJlZmluZSB0aGF0IGluIHRoZSBmdXR1cmUuIEJlY2F1c2UNCnRoaXMgY2hhbmdlIHdpbGwg
YWxzbyBuZWVkIHRvIG1vZGlmeSB0aGUgY29kZSBpbiBDTURRIFBUQSwgc28gSSdsbCBmaXgNCm90
aGVyIGlzc3VlcyBpbiBub3JtYWwgd29ybGQgZmlyc3QuIFRoZW4gSSdsbCByZWZpbmUgdGhpcyBw
bGFjZSBhZnRlciBhDQpmZXcgdmVyc2lvbi4NCg0KPiBJbiBhZGRpdGlvbiwgd2h5IHBhc3MgYnVm
X3NpemU/DQo+IA0KVGhpcyBidWZfc2l6ZSBpcyB0aGUgcGFyYW1ldGVyIGZvciBNNFUgUFRBIHRv
IHZlcmlmeSB0aGUgcmFuZ2Ugb2YNCnNlY3VyZSBhZGRyZXNzIGluIHRoZSBzZWN1cmUgd29ybGQu
DQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCg0KPiBSZWdhcmRzLA0KPiBDSw0KPiANCg==

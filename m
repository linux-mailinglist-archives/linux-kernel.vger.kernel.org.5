Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBB67C4814
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 05:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344916AbjJKDDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 23:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344902AbjJKDDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 23:03:16 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1590E94
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 20:03:13 -0700 (PDT)
X-UUID: b5d233c867e211eea33bb35ae8d461a2-20231011
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=lL0cC+ILHL8OG5dx0yArUAljn2DGXTyYuBSTSjWyQU0=;
        b=WLJzyf77CYpSZwAk9TQ6uuIfD3+/VXlKlShYkox8dijHtsdg8e3v6d1zmJHM8vnCYfzBg8Uchih+wVClV8V3KC9FFV1XEX8gLVAt91Z/Q8J6z1L0fCjcj0yYikPcYxtEtbRmepU7Hf4shzJdojn7MjAKBz2xovv9q6bdbUpTpKQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:4158672f-29ed-4d85-8a01-670b838dd51b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:c342fac3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b5d233c867e211eea33bb35ae8d461a2-20231011
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1773369556; Wed, 11 Oct 2023 11:03:10 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 11 Oct 2023 11:03:09 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 11 Oct 2023 11:03:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciNdu/1Xiw68+Z/SYbqgnc4ct0fqzwpZ7JVdjcdPkNaqFYzcEr1PAw56fQSIZKYz/FPHwdGk3uRFO4ZCaE8pbT2QW1nL2seEA6Hs5BpeEwrZGfy5wPZDT0oITHBoypdkur5UvdTIHCdNGegpSaO0g2DDy3YM6NCgdNvB9ReGCryoVOPaQBDoTibOz7L/BaalaUymoXP1T705i2PFJQdH4J+RLoiQwLKlmjGwTIWZhI9eUYAkvHjvFJuw1x72/lYbKTGaZA2v5YHSVfCtNAYUqn4vm48c6YsmnrYLBOHuLLx9hrlXJuxhyZ6gJJKI8I89fcL1vsjfpJAS+Ihqm6f7WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lL0cC+ILHL8OG5dx0yArUAljn2DGXTyYuBSTSjWyQU0=;
 b=CZFZQPkAkm4y36V0olqB9sBiXZJAmw80FerdpsWZgPJtHHgBPNPa6B90IyzlU1aJC9s0r3UMeB7g6OPXaTV3VdjhmPSIAwO6P03eusLNUimdsxDVAGJ9kT8KSpWfcFmFBPPz0XZJzP2FBYLiormqWhNYDCI1THl+YtjOj0OIbI2Oyw42BY6TldMK0oH0HzEom8daMvvliH1zQU1Eq0KCX57TbPwHDQ9VuDJtqTKlYy1QU1+9uxGl5bLeb2BsqpPRzMR/VUlXUNbJOQrbk+iN9TUP8a7adpWR7ZuFQPu0EPJvtDsqSVp9l2tauZaEhRJdDvxudMqt3jVdu/vxmWpcBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lL0cC+ILHL8OG5dx0yArUAljn2DGXTyYuBSTSjWyQU0=;
 b=MfDgEWboI8n1ZaEC3zreq58nToixswaJv/4UEwEWBi88W3Gv+K1GxOJyXAvSLhS81RByVyOPvVeA2Ec4Ua1sRJY5xvQHSQlGN3gMxPeMbqqhmVFdttlMr9bodyPObrjP2NQCW+t25T6Wh+1IAVusIVdMGPesteaPUXrdAcX/UAM=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB6647.apcprd03.prod.outlook.com (2603:1096:400:1f4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Wed, 11 Oct
 2023 03:03:06 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 03:03:06 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
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
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2] mailbox: remove runtime GCE clk control
Thread-Topic: [PATCH v2] mailbox: remove runtime GCE clk control
Thread-Index: AQHZ9qBuCYSBVpc1a0+03zvp2lR9C7A5WrSAgAMjeICABnTxgIAA/oqA
Date:   Wed, 11 Oct 2023 03:03:06 +0000
Message-ID: <95a79189bedfb551016537eccbc2ddbaf20a04cc.camel@mediatek.com>
References: <20231004085430.19538-1-jason-jh.lin@mediatek.com>
         <baa122da-4ae3-9023-3529-3ad38204b989@collabora.com>
         <672d86a9e9bb08c770a6884860e9d13a0aaf0eb7.camel@mediatek.com>
         <bb9ae8ac-b12e-8f4f-1c21-7cde61d796c3@collabora.com>
In-Reply-To: <bb9ae8ac-b12e-8f4f-1c21-7cde61d796c3@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB6647:EE_
x-ms-office365-filtering-correlation-id: 7af13b14-8ae3-496d-08aa-08dbca069774
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 820+nmyP/dIhA0DbCBtvD/K7SmG/xWgX+Mjp31hkWvvbRy0uQr0K8ttLKvnKNEr6W7xnjKxc3jn1IB6IrKvFAKJNXLdhTdaGbfixxw4G74PMuIAnXpFfS4LLKvQdGwOxB+/vtSyh57rZaAM8nILt5mGIv1uop17T+Ihz2UCcmNzqnuHqhWI3JBelUspi3zrzwUwkuziKXGOS93aS3ueIzYHBovWn8IFTSrA3MUxah0xqK9NwjHItbLGiBSkK70B6tbnDoCl3WLk+EbjQiJtOaby9eZO7+0DhF2taP0SBzNMYfJ6xGG71dJB9xbGeTonP9vDZmZNjvZiCf6Hx1WE9qZ8qAtr4DRuaue2DvWLoY30tK3frrDc6yznRExcKmkgT9QwjrMPRd//Iwvrrj9fA9WpaSmK06S1NUmUyF/g/TLDc4SoiEyWTA4dMZVNgkx+1QOAwsUHz9q+02jdcGzA1ZRoaIm8xK/vsXmN9VeuYcnhs3XR7QS8Qp89cjJcGoBS3wMu4J0TJYXN2+kus4G+V5LwjgShoCk8ydxoUiDLw5Efbl7hO7y+Sfx+UwmONPMj0yTuS3MTC8aJjDn5MGYeIYtoCrDmUBNWXfav/DOf5lS84/GHa6eaHf+O3d3BW7MIPpKDQxnn26/7h4RkJAM6svbbXyBJ439zNz/QyDo4jidc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(26005)(6512007)(86362001)(122000001)(83380400001)(38070700005)(36756003)(85182001)(38100700002)(66446008)(76116006)(478600001)(66476007)(66556008)(5660300002)(54906003)(66946007)(6486002)(15650500001)(316002)(41300700001)(91956017)(6506007)(8936002)(110136005)(4001150100001)(4326008)(2616005)(8676002)(2906002)(71200400001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rzc5eW9aWi9kazBUclJEb0dTbG5xcVUvWTlZa0JaZzdXUmgvd1VPYTEyYXp0?=
 =?utf-8?B?K1ZSQStvMTI5SkRiRHVRa0FBcnN3RGpZOFZtWjZjbitUQm1NL0RsZ1JyeUJJ?=
 =?utf-8?B?Z1o4SW5zY0prUW1NSjRZU24rMGFTd0JaTk5lNjBqRk1OaHBKOE4vME1CMHNF?=
 =?utf-8?B?TkhVSXlZQ0tXUjl4WDNJaFNoYjNMRE1mYnhnVDdQMVV0Mm1WUnUyQUZ3b2FT?=
 =?utf-8?B?UE9DdU94aTAweFNYZCs2WFplZ3hNTUM5emtLS2M3ZXI1aVYzSWVyMWw0QkJ5?=
 =?utf-8?B?QXNJTEJXdXIvK2ZHVG1vTzl1cFovdlVHd1ZhQXVaWVlZRUQ3cUM4RHlIcjZ2?=
 =?utf-8?B?NXJNRGxxSmwraUtpUWk5TnlTTFRoeGNvUjRaZEZiUldwTDIzODViR2JWT09z?=
 =?utf-8?B?YTlNYkdwT28ycXIzckpmWFl2cGVjSU56YWZ3ZW95QWlFQWlVTXJNSVFZSDNT?=
 =?utf-8?B?OGt5cTltT2tlSTVqMXVpNnpNdFB5NUxSUDBkMnVsV2Y1OS9CSEQvMzA3YlhH?=
 =?utf-8?B?ZWd2dnRkaG1oMHJPemszS080S1RHd2Z1UktpMzZUVXRxak5JM21IWlR3YW9S?=
 =?utf-8?B?eVUraE4waFpUN0hISWxQbHJ4UTVCS0NYdTlXd2tjM3NvQTFlLzJFdGJvM2hs?=
 =?utf-8?B?Sml6RVRRbk1GZFhQTitmR1RvbEJzYzdBc2FlZUpNcnN2V2J3UDhzODQvSFoz?=
 =?utf-8?B?NE9sU1FMa0VlbEx4U2I2eTVWaC9lajdmc0pGZDJlRW9EemxOZnc3OURzSWtv?=
 =?utf-8?B?R1ZqcDg3VTNuT0NNczlRejQ5emRIeDNJQVJRbUNxMUo5cnNvU1RFeHZzVy9B?=
 =?utf-8?B?MTh3TXV6ZCtxWHlWMHlqNm1IWWhZTmhEK3Jld0NxQ1RMY0tTcVphY1lJSjRN?=
 =?utf-8?B?NEpka29xRTN0QThKeTcwdktLVmxPc0s1cExhSGRBS0dvdGlJcmpWT2tVUlZB?=
 =?utf-8?B?N3FqbWsrYVNlSWhyYW4zRDZ5NGx6cHNWZm9xQXZacTZvQk1waVd0bFY4blhr?=
 =?utf-8?B?Y0NKU3JkNHlYVElYcCtSdENlNHJLang0RVZKT3Judkx2aGt3aUtQRGg0TzVR?=
 =?utf-8?B?dm1XeXF0dm84RGlrc1I1RmNLME9YdmxTNzVoNldQTGdBSm1KOFVsSXdibitL?=
 =?utf-8?B?eXNPNTF0bGV4czF4NmtCQm5DSWo4d3RJWkdYVmVZcTJlTVBRbDNnVW5sOWw2?=
 =?utf-8?B?SllZOEh0L1MvVmorbUZDVkgwaUZWKzRZb3FsVC9oNjZ3M08xdjhSQktqZllj?=
 =?utf-8?B?UDFReFBXMytiZ2NOUW5jbGdKUk9vM1FCc0hYUjA0YU1ZRC9XVllWR1U4YVlO?=
 =?utf-8?B?SmZKOWdDQ0ZlSURnOFozbmc5ajdiMzE0cHdCNS9jZDJjS3kvK09EMFNLaFFj?=
 =?utf-8?B?b1NyL01RcEdkTFcxYXd5MjloMmcwRGhncGdGY3lhaUk4RmJkTzlmdkhYdnda?=
 =?utf-8?B?a28xd0VrR3lDODJkTi9TalluTTBacXUwV2wrMzR0bHpRU2pOREtIWCtsVTdt?=
 =?utf-8?B?ZFk3Q1NvOXRoZFpWVk1LUmNaZFJtSURhQVRLUkpCODJ0YmNMOXErcVk3Vnpz?=
 =?utf-8?B?U1MvODkzK1g0eDRNeTFSRjkwUUVsMjdKMldPL2ZxNXNyNExoeU1QNld5MVBq?=
 =?utf-8?B?V3ZOTzdTSUZYRXJiVDNwbFpSMzJnQng3WXEwN21KMGYvYzhndDZERzBYc2pQ?=
 =?utf-8?B?ZnpLbGNXZlZxNnJhZERrenZ4UHRiUXQvbFJmT3Jka1pka1BDaWJhNUxQMndY?=
 =?utf-8?B?b3kxUG9zYWpFcXIxVzU0aXlHYzNselBMcGQ3NVdVN0ZzeFZ2YlNqazIzc3d3?=
 =?utf-8?B?ejFoVHpFb1NMeUYzbTJPbFJ5eHJvSU1jcXIvMkd1NEtaTk41UEdRVjVSU2h4?=
 =?utf-8?B?bEdGYmJTTzBybDVqOWRDQjB0bGdma1JtR0xGblhzWWpMM2xUT2RFUzlyZ0xQ?=
 =?utf-8?B?L2xvbVI3dVdZdjBtTmNpRVMwRTBJZldBN3IzWVhZYVdzQ3VUMkROaUtMSHN5?=
 =?utf-8?B?WW9JSUJLUzJ6YjNaMEd5VXYwUktVYkxPUDFYZVNNWTVLWVMzZCtySnFwVXFh?=
 =?utf-8?B?MmpUam1vNG1BMnQwdFFNTUpmVld4N0xzcGFYNHNKSjlUdjJsUGZ0YVhhWVBZ?=
 =?utf-8?B?ejZFZzBqUUtKVzlYa0tXKytVRkk4ZHBlTld3OHBCZEdnSlZNSG13STljMDZY?=
 =?utf-8?B?Y1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24D00503EEF7C14484294BF025EF024A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af13b14-8ae3-496d-08aa-08dbca069774
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 03:03:06.2139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhnyOxTwpNahZ7qmSb/eVIjyqQV3YaDkAWIJJ4MSSsYaZ4e2xtVOCI86jMYV9StDs4qxTE44fJrnIG2Tqb5dan3+I5nqnCAv7yh3S/0reX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6647
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTEwLTEwIGF0IDEzOjUyICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMDYvMTAvMjMgMTE6MTUsIEphc29uLUpIIExpbiAo5p6X552/56Wl
KSBoYSBzY3JpdHRvOg0KPiA+IEhpIEFuZ2VsbywNCj4gPiANCj4gPiBUaGFua3MgZm9yIHRoZSBy
ZXZpZXdzLg0KPiA+IA0KPiA+IE9uIFdlZCwgMjAyMy0xMC0wNCBhdCAxMToyMCArMDIwMCwgQW5n
ZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8NCj4gPiB3cm90ZToNCj4gPiA+IElsIDA0LzEwLzIzIDEw
OjU0LCBKYXNvbi1KSC5MaW4gaGEgc2NyaXR0bzoNCj4gPiA+ID4gMS4gR0NFIGlzIGEgZnJlcXVl
bnRseSB1c2VkIG1vZHVsZSwgc28gcnVudGltZSBjb250cm9sbGluZw0KPiA+ID4gPiBHQ0UgY2xv
Y2sgd29uJ3Qgc2F2ZSB0b28gbXVjaCBwb3dlciBhbmQgaXRzIG9yaWdpbmFsIGRlc2lnbg0KPiA+
ID4gPiBkb2Vzbid0IGV4cGVjdCBpdCB0byBiZSBlbmFibGVkIGFuZCBkaXNhYmxlZCB0b28gZnJl
cXVlbnRseS4NCj4gPiA+ID4gDQo+ID4gPiA+IDIuIFJ1bnRpbWUgY29udHJvbGxpbmcgR0NFIGNs
b2NrIHdpbGwgY2F1c2UgZGlzcGxheSBIVyByZWdpc3Rlcg0KPiA+ID4gPiBjb25maWd1cmVkIGlu
IHdvcm5nIHN0cmVhbSBkb25lIGV2ZW50IGlzc3VlIGJlbG93Og0KPiA+ID4gPiAgICAgR0NFIHNo
b3VsZCBjb25maWcgSFcgaW4gZXZlcnkgdmJsYW5raW5nIGR1cmF0aW9uLg0KPiA+ID4gPiAgICAg
VGhlIHN0cmVhbSBkb25lIGV2ZW50IGlzIHRoZSBzdGFydCBzaWduYWwgb2YgdmJsYW5raW5nLg0K
PiA+ID4gPiANCj4gPiA+ID4gICAgIElmIHN0cmVhbSBkb25lIGV2ZW50IGlzIHNlbnQgYmV0d2Vl
biBHQ0UgY2xrX2Rpc2FibGUNCj4gPiA+ID4gICAgIGFuZCBjbGtfZW5hYmxlLiBBZnRlciBHQ0Ug
Y2xrX2VuYWJsZSB0aGUgc3RyZWFtIGRvbmUgZXZlbnQNCj4gPiA+ID4gICAgIG1heSBub3QgYXBw
ZWFyIGltbWVkaWF0ZWx5IGFuZCBoYXZlIGFib3V0IDN1cyBkZWxheS4NCj4gPiA+ID4gDQo+ID4g
PiA+ICAgICBOb3JtYWwgY2FzZToNCj4gPiA+ID4gICAgIGNsa19kaXNhYmxlIC0+IGdldCBFdmVu
dEEgLT4gY2xrX2VuYWJsZSAtPiBjbGVhciBFdmVudEENCj4gPiA+ID4gICAgIC0+IHdhaXQgRXZl
bnRCIC0+IGdldCBFdmVudEIgLT4gY29uZmlnIEhXDQo+ID4gPiA+IA0KPiA+ID4gPiAgICAgQWJu
b3JtYWwgY2FzZToNCj4gPiA+ID4gICAgIGNsa19kaXNhYmxlIC0+IGdldCBFdmVudEEgLT4gY2xr
X2VuYWJsZSAtPiBFdmVudEEgZGVsYXkNCj4gPiA+ID4gYXBwZWFyDQo+ID4gPiA+ICAgICAtPiBj
bGVhciBFdmVudEEgZmFpbCAtPiB3YWl0IEV2ZW50QiBidXQgZ2V0IEV2ZW50QSAtPg0KPiA+ID4g
PiBjb25maWcgSFcNCj4gPiA+ID4gDQo+ID4gPiA+IFNvIGp1c3QgcmVtb3ZlIHRoZSBydW50aW1l
IEdDRSBjbG9jayBjb250b3JsLg0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSmFz
b24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+ID4gDQo+ID4gPiBJbnN0
ZWFkIG9mIGVudGlyZWx5IHJlbW92aW5nIHRoZSBsb2dpYyB0aGF0IGNvbnRyb2xzIHRoZSBjbG9j
a3MNCj4gPiA+IGFuZA0KPiA+ID4gYWx3YXlzDQo+ID4gPiByZWZ1c2UgdG8gc2F2ZSBwb3dlciwg
d2hhdCBhYm91dCB1c2luZyBhdXRvc3VzcGVuZD8NCj4gPiA+IA0KPiA+ID4gSWYgdGhlIHR3byBj
YXNlcyB0aGF0IHlvdSdyZSBkZXNjcmliaW5nIGFyZSBoYXBwZW5pbmcgYWx3YXlzIGluIGENCj4g
PiA+IHJhbmdlIG9mDQo+ID4gPiB0aW1lLCB3ZSBjb3VsZCAqeWVzKiByZW1vdmUgdGhlICJtYW51
YWwiIGJ1bGsgZGlzYWJsZS9lbmFibGUNCj4gPiA+IGNhbGxzLA0KPiA+ID4gYnV0IHRoZW4NCj4g
PiA+IHdlIGNvdWxkIHVzZSBydW50aW1lX3N1c3BlbmQvcnVudGltZV9yZXN1bWUgY2FsbGJhY2tz
IGZvciB0aGF0Lg0KPiA+ID4gDQo+ID4gPiBIaW50OiBwbV9ydW50aW1lX3NldF9hdXRvc3VzcGVu
ZF9kZWxheShkZXYsIDEwMDApOw0KPiA+ID4gDQo+ID4gPiBSZWdhcmRzLA0KPiA+ID4gQW5nZWxv
DQo+ID4gPiANCj4gPiANCj4gPiBUaGVzZSAyIGlzc3VlcyBhcmUgY2F1c2VkIGJ5IEdDRSBidWxr
X2NsayBlbmFibGUvZGlzYWJsZSB0b28NCj4gPiBmcmVxdWVudGx5Lg0KPiA+IA0KPiA+IEFzIEkg
bm93LCBwbV9ydW50aW1lX3NldF9hdXRvc3VzcGVuZF9kZWxheSgpIGlzIGZvciBjb250cm9sbGlu
ZyB0aGUNCj4gPiBwb3dlciBkb21haW4uIFRoZSBwb3dlciBkb21haW4gb2YgR0NFIGlzIGluZnJh
c3lzIHdoaWNoIGNhbiBvbmx5IGJlDQo+ID4gZW5hYmxlZC9kaXNhYmxlZCBieSBzcG0gZHVyaW5n
IHRoZSB3aG9sZSBzeXN0ZW0gcmVzdW1lL3N1c3BlbmQuDQo+ID4gU28gSSdtIG5vdCBzdXJlIGFi
b3V0IGhvdyBjYW4gcG1fcnVudGltZV9zZXRfYXV0b3N1c3BlbmRfZGVsYXkoKQ0KPiA+IHNhdmUN
Cj4gPiBwb3dlciBmb3IgR0NFIGJ1bGtfY2xrIGluIHRoaXMgY2FzZS4NCj4gPiANCj4gPiBDb3Vs
ZCB5b3UgZ2l2ZSBtb3JlIGhpbnQgZm9yIG1lIHBsZWFzZT8NCj4gPiANCj4gDQo+IEkgdGhpbmsg
aXQncyBmYXN0ZXIgaWYgSSBzZW5kIG15IG93biB2ZXJzaW9uIG9mIHRoYXQsIEknbSB0ZXN0aW5n
DQo+IHRoYXQgcmlnaHQgbm93DQo+IG9uIG11bHRpcGxlIENocm9tZWJvb2tzIHRvIGNoZWNrIGlm
IHRoaXMgc29sdmVzIHRoZSBpc3N1ZSB0aGF0IHlvdSdyZQ0KPiBkZXNjcmliaW5nLA0KPiB3aGlj
aCBJIGJlbGlldmUgaXQgdG8gYmUgdGhlICJhcHBhcmVudCByYW5kb20gbG9ja3VwcyIgb3IgZGlz
cGxheQ0KPiBzdHV0dGVyaW5nIHdoZW4NCj4gaW4gYSBoaWdoIGxvYWQgc2l0dWF0aW9uLg0KDQpU
aGFua3MgZm9yIHlvdXIgaGVscCwgSSBjYW4gcmVwcm9kdWNlIGl0IHdpdGggeW91ciB2ZXJzaW9u
Lg0KDQo+IA0KPiBJIGRvbid0IHNlZW0gdG8gZ2V0IGFueSBtb3JlIHN0dXR0ZXJpbmcgbm9yIGFw
cGFyZW50IHJhbmRvbSBsb2NrdXBzDQo+IG9uIGEgTVQ4MTk1DQo+IENocm9tZWJvb2ssIGFuZCB0
aGF0J3Mgd2l0aCBteSBwbV9ydW50aW1lIGF1dG9zdXNwZW5kIHNvbHV0aW9uLCB3aXRoDQo+IGEg
cnVudGltZQ0KPiBzdXNwZW5kIGRlbGF5IG9mIDEwMG1zLCB3aGljaCBJJ20gdHJ5aW5nIHRvIGRl
Y3JlYXNlIGFzIG11Y2ggYXMNCj4gcG9zc2libGUgaW4gb3JkZXINCj4gdG8ga2VlcCBzYXZpbmcg
YXMgbXVjaCBwb3dlciBhcyBwb3NzaWJsZS4NCj4gDQo+IEZvciB0aGlzLCBpZiB5b3UgY291bGQg
YmV0dGVyIGRlc2NyaWJlIGhvdyB0byByZWxpYWJseSByZXByb2R1Y2UgdGhlDQo+IGlzc3VlIHRo
YXQNCj4geW91IGhhdmUgZGVzY3JpYmVkLCBpdCB3b3VsZCBoZWxwIG1lIGEgYml0IGluIG1ha2lu
ZyB0aGlzIGFzIGdvb2QgYXMNCj4gcG9zc2libGUuDQoNCkFmdGVyIHJldmVydGluZyB0aGlzIG1v
ZGlmaWNhdGlvbiwgeW91J2xsIHNlZSAyIGlzc3VlcyBvbiBNVDgxODggYW5kDQpNVDgxOTUgcHJv
YmFiaWxpdHk6DQoxLiBBIGZsaWNrZXIgc2hpZnQgbWF5IG9jY3VyIHJhbmRvbWx5IHdoZW4gbW92
aW5nIHRoZSBjdXJzb3Igb24gdGhlDQplZGdlIG9mIGV4dGVybmFsIERQIG1vbml0b3IgcmFwaWRs
eS4NCjIuIEEgcHJlbWF0dXJlIHdha2UgY2F1c2VkIGJ5IENNRFEgZHVyaW5nIHRoZSBTdXNwZW5k
L1Jlc3VtZSB0ZXN0DQpyYW5kb21seS4NCg0KSSdsbCBzZW5kIHlvdSB0aGUgZGV0YWlsIHJlcHJv
ZHVjZSBzdGVwcyBwcml2YXRlbHkuDQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCg0KPiANCj4g
VGhhbmtzLA0KPiBBbmdlbG8NCj4gDQo=

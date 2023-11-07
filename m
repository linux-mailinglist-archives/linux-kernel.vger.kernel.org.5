Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB61F7E348C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 05:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbjKGEfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 23:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjKGEfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 23:35:34 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E58C113;
        Mon,  6 Nov 2023 20:35:26 -0800 (PST)
X-UUID: 0c7102fa7d2711ee8051498923ad61e6-20231107
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=VTi6weK89+gIHRFFjLW+YLbTCHi8pJAUP4iWnh/JcCk=;
        b=boPhlqkTmPBhvDnJlPUohcp7zdR1wFc2bvXwf98zgZBVinvrL+XXOE8TGeqJIOh/zmAQjMTjkN4BuPzU4OS1k9+yIlYdz66zjs9z6sCV37N7+CsffMQD/EvHg4nTPu0ds/NoFYfX/gUJCJcwS8LVws35zGpxJU9klyM8QsGV5Nk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:6b3a28b9-fba6-4326-a3c1-4c474769dfd2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:10a2c35f-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0c7102fa7d2711ee8051498923ad61e6-20231107
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ed.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 506699020; Tue, 07 Nov 2023 12:35:16 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 7 Nov 2023 12:35:14 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 7 Nov 2023 12:35:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UK3HU7D+b05ppLqFpzMOYbYMiZJer6eaC/0+62n5T7AHjRDFkGfocjvYqkQr7wPbpQ/fMp/egjNgOGkKe/UaisOQM8c6nsDgFlzgtb10uxdY1SLdlbE4seNyqaWtNt0qpkT2+wCZmurmSVpefiVgHuBUqJ+5CZO4E0S4WJ/hiQGTRL7klUCftv5EXTaC5XS2WvZvJIPzykiRqn6rowhH+M1Gt8x8vehc1NfKLzFXhdeKeM5MSw3lFsdrAF00pH0cfapQ9v9ZSxb0UzExXK1U0CXCPUUcfvfsETQ/T31ezrauOF+45ZEunUL0Zsxzix31XFfwZQn5fo0lMeBRn+IxsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTi6weK89+gIHRFFjLW+YLbTCHi8pJAUP4iWnh/JcCk=;
 b=RhWhXl3LVvq1SJtmIWcD0n1W5DmqwoQbsECQRtePn5RhlMRu98hqfqxKxpwu1L4gPeyD1lyu5/1urlPGf6eKmUAcpJLanizCRG+f5E5+SRfXVQYnY06cpjS8Oyr57DSWouaI9OtilVZQfCaPIyWCDqbJq0nlacVzt0GiFrMBVayjI/tLzo4+u6bN9oDkkEpzP/nE8Q6o3LkfoM+vXspn0RFcoTLz2hH0MKhckwabLOHnnjT0yJWkl2idfJhAS99/2W1126tbjBfAWfOeQTkrOl5R9u4bXc6n6HRCahs1wZmgTw5pDPXouwBnpZvIyD0tPC1/A8UlbUaM2gt8R+KF/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTi6weK89+gIHRFFjLW+YLbTCHi8pJAUP4iWnh/JcCk=;
 b=iNyGJZ9hQfupTT7FuuLr5F+8KRKLGFv0I2TO78wrfbH0BzwWzck8EKT132t5SeiOy4F5RBgzeWnSo/825rbTN8HU92T7ahB72VTlHCfhDVrWiUA8F2c59I+VLOTemDGBWkyu8xaXdbbIsLJz00zFNnXc/5tT2iHObVvQGitMSmA=
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com (2603:1096:4:131::9) by
 JH0PR03MB7611.apcprd03.prod.outlook.com (2603:1096:990:b::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.27; Tue, 7 Nov 2023 04:35:12 +0000
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::d398:103e:796d:76b9]) by SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::d398:103e:796d:76b9%5]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 04:35:11 +0000
From:   =?utf-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>
To:     "ming.lei@redhat.com" <ming.lei@redhat.com>
CC:     =?utf-8?B?V2lsbCBTaGl1ICjoqLHmga3nkZwp?= <Will.Shiu@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= 
        <peter.wang@mediatek.com>,
        =?utf-8?B?QWxpY2UgQ2hhbyAo6LaZ54+u5Z2HKQ==?= 
        <Alice.Chao@mediatek.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        =?utf-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>,
        =?utf-8?B?UG93ZW4gS2FvICjpq5jkvK/mlocp?= <Powen.Kao@mediatek.com>,
        =?utf-8?B?TmFvbWkgQ2h1ICjmnLHoqaDnlLAp?= <Naomi.Chu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/1] block: Check the queue limit before bio submitting
Thread-Topic: [PATCH 1/1] block: Check the queue limit before bio submitting
Thread-Index: AQHaByTnzFC4rhYmWUKg+y7lOe9n1bBkxn0AgAQOpYCAAJQggIAAKqIAgAMAagCAAAHEgIAANgSAgAB1oACAAPsggIAAD3wAgAAM+QA=
Date:   Tue, 7 Nov 2023 04:35:11 +0000
Message-ID: <ec36dfd24bac079b128baa0251914d4c055a0c88.camel@mediatek.com>
References: <20231025092255.27930-1-ed.tsai@mediatek.com>
         <64db8f5406571c2f89b70f852eb411320201abe6.camel@mediatek.com>
         <ZUUd48QF/TEGFzPy@fedora>
         <cf09a768d0e116bfaf01a1592a7ae95a10b4c2cf.camel@mediatek.com>
         <ZUW96Ha5GoJePD8Y@fedora>
         <2bc847a83849973b7658145f2efdda86cc47e3d5.camel@mediatek.com>
         <5ecedad658bf28abf9bbeeb70dcac09b4b404cf5.camel@mediatek.com>
         <ZUhxS9JMyPK+v6Ec@fedora> <ZUjT11xUNM7u/UjV@fedora>
         <fb568e7a1020ef6d2d22f3f0771034b1dc699fb9.camel@mediatek.com>
         <ZUmznGeKhJKnE7wx@fedora>
In-Reply-To: <ZUmznGeKhJKnE7wx@fedora>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5545:EE_|JH0PR03MB7611:EE_
x-ms-office365-filtering-correlation-id: 9a462967-71e4-49a8-14f3-08dbdf4aee0c
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CPfoBLSgvyh3kkt62Uk4/L95RE1xmmm+pf9kEqnKx+rPS/3HRVXhO8K2UtfQTjtNcVBra33Lqne9QicJkQXOTgtkBvDbuss64JKaWRFvwV2e2C47vQRcoA9wMbKYBUONO1TfaguTBtQRQXOHHSo7vWz+sQ5UoKfZ+M2W7AcFTR7+Fip8WjQolVLPjLIwQJnyQWa+i8J0yXyc/PPLSIZ7mTZmah439eBroAPhCz+jq+7hY+3pDSgJyeBcgoc8lImC3lqQOiz+O7qNqekvz+hVZEnJac/4crZs8/vZSu0ayplgy7dcHOsv/UMH44CJmB0g2hPNrBwieE6XpHwGKs4Y0Obleud1m04A7g4NcMLRMCM512OHXXUCQ+GX8eoS06Dd9n9ne131Pxor3UvJ2PKa/+01TifebYYMc6yi/a/ozXtHoOTvTdtArhgnSrOjlRQ0KtCEaQ+d5YNxrscYZFAnDxgDOYWVEDbYrkcfuwgGNxJvC3Q+eLXoJleNdwe8BN5ChiEjfGg42ED2umN41f/TnEwdfTAr2G+KP0lx7jBphh4rcRK9k3xRB96duXI33afTG5cZer6QXUQUnLvV1WcZFjKPC5Gxqb1Ti5qvTp3XDnQWIEF+iP+212fuyUUYEwuxBPiHM5GwX+Y3mAkG6nmXQ9Q0OB3/Wj1VzChqyPtxoLs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5545.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6506007)(71200400001)(6512007)(2616005)(6486002)(478600001)(5660300002)(83380400001)(2906002)(26005)(76116006)(38070700009)(41300700001)(66556008)(6916009)(64756008)(66446008)(66476007)(66946007)(4326008)(54906003)(91956017)(316002)(8936002)(8676002)(38100700002)(85182001)(36756003)(86362001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0RvTDJmemwyZnZtZk5QSnRVajQ4MzFxTW5oQXE3elBFd3BlYmtOaDduT1VZ?=
 =?utf-8?B?ZFpSZ3hOdzlGcWJXSk95SFcxL3hnazk3NXFtSkZhcHFSR05DZFdZSC9Sa3dk?=
 =?utf-8?B?WHhMakJKYUlVck9Td2JvY3BBZmhHODcrTktDL1daM3U0Smw1M0JzS0QxRyth?=
 =?utf-8?B?QlEzb0xUbm82TzVwR2VHbU40N05rNnZQaDUvYll3QVFyMlppOWRCRDEzd29t?=
 =?utf-8?B?dUVkT0FLVmNyR21ZNmVpSEkrZTB2Wmw5MG9lUXVpUCtGczhXZnozOG4rQTNP?=
 =?utf-8?B?R0l5NDZSUytVQm5QVUFJcmUyN0Y3YTR6bVdwR0dlUVRzdXZFSk1RWnFONEU3?=
 =?utf-8?B?VEhna25DR01OZEd1b2JWbjY2K2QyTXh0VkN4Z2FuRU5HQjkrbG1WaEs0S2hR?=
 =?utf-8?B?UzFuamN4c1JyZWNMTWhuaFJrRHF5bFV4aXVyblVGNnV0SUdsQjBXVUorMzZu?=
 =?utf-8?B?UWUrd2NTRWROY2F3V3gwWlgyV2VGQys3cHErWEhUOEw2aHV5NjJ4amxENW5h?=
 =?utf-8?B?NmEwVTBha05zek0wa040Y3VPNmNSMWRiSXNUKzdsTDVMa0xvL0w5V3VKc29P?=
 =?utf-8?B?eTl4dm5selgrSmYzY1dyYWZiS25KdjMzUjNIMFU0MHJNVm0rVWN6WlRKL05F?=
 =?utf-8?B?REVmL05OZ3NUeDBMbmtNZmhNRjFWR2FBYVhyUURRelBnaTBQT2tObkExTmRG?=
 =?utf-8?B?NSthNTJqTWswNDhNVDQ4OFJCRThzcDZJeW5vVnJMUVVmQU9JNlovL1RFSVcr?=
 =?utf-8?B?bXBCV1cvY1JDcFFCZXo4alNRQWFsVW16U3RPT3pPUWoyVnk3dmU3OE16WnJO?=
 =?utf-8?B?cDhCQnRtc2diOXd6c083NlNNeG5odmtnN2FQRStickF2cEhsSFpSYjFlQ3ZT?=
 =?utf-8?B?M2NldCs0cGtocXFLR3ZLaGNETEFxbDRyY0NFUG1aT0JzTko1MTJUVjFtRSsy?=
 =?utf-8?B?SmpLSTArYkNkYlZUZWUrZ204cHRBS1lCSG9PdUNCUHFVcjkzV3NYTWFRUERQ?=
 =?utf-8?B?ZzhJaktxSnRGWlBKaHIzRHp6RGNMcGxZdkdGdDh4bGc1TVZOOVNWNFArbmNm?=
 =?utf-8?B?SVBJTFFMSVpIZVQ2L3dKdUZXVkY5UjJVZDhQeGdwT2VuVUsxa2ExVS9xWnRt?=
 =?utf-8?B?L0pVa2xGME1UanRHYmxjeXhuSVBOQ1FlOTA1eUpSYkFmVC91TlBCT0hiN3ls?=
 =?utf-8?B?eDh4ejNSVjVocjNYRVJNdGFWV05oNk9HSDY4NjhRR0pxN0ExRjhoZEpxQ1A3?=
 =?utf-8?B?WGZxVmdkbmRBSlR1ZkFQcTZRdHh0ZmhpM0VySC9XeDY5Q3g0RVd0NFp5aWFk?=
 =?utf-8?B?YS94aFpJTnRPTEZNZ0RpUkVXVU5FUG00alM0OUlUZUJIVUtpSlpyRHJIckxO?=
 =?utf-8?B?NEplVysxTFUyVWpSVjR0RkZYQ29aVExLVC9oK05PQXBVQmttY0xmSXRNTDc3?=
 =?utf-8?B?cHdJVDJsK2QyNy9YclF2cThvM2xSeFdhN3hBRjZqVnRSS1pWZXN1TVMxM2Fx?=
 =?utf-8?B?STBrTmNHeEJLc0Z6MGVXNkhlWnhvMjl1MGtYYnBBbUFBUThWWEVhb3J5VFhC?=
 =?utf-8?B?TUdtVHVMYkIzNEd6RUI5TUxBMk9zR0RqaSswb0J4WGRST1NTUFMzOFhLVmw5?=
 =?utf-8?B?QUZRTXpRK1hya1BZY3Zza2lqdzFLc2YyWE5SZ1VqZ1pQb1ZrdFpOMGZUU1Zz?=
 =?utf-8?B?ekJkSHVFRyt0MTNrcXBZcm1NVzFhYmEwTEZDODd4aDdpVmg3V0dZekJnOWpu?=
 =?utf-8?B?WFRVb3l4ZDIxVEVMV1pCek1Fb2lVUFd2M3hPbUhYQU1ZZWJZLzlxMGlrWlpw?=
 =?utf-8?B?ZUZwczRPRnJrcUhYcTlZNUFpWk1tUGJBN3E4enZOazJONWFxWHlZZnR0am1Q?=
 =?utf-8?B?SVlhcDRHYlJ2ZlNuL0Urd2pYVzZaMEk4UDZzRUVqejBLZWhLQ0VVSmR3WVdT?=
 =?utf-8?B?bjRFMi9DMGJKVklJNWhmbVVyM2FmUjVHWTlGanlRbmR1dVVvdUFrakhhTVdF?=
 =?utf-8?B?OFFyV2RidDhrK1E2VkVKRDNtTUg3cHZYTE5ITEpsNWYwTlhoQllKdW8xYVg3?=
 =?utf-8?B?OUlRREkxdFYvd3lscTR6UWx5N3Y5ZUQ3dDAyVkliMTNtOW95cDBYb1Njc0VE?=
 =?utf-8?B?N0dNM1hsWnFISTQrdndHc2pNVFFNdTN2Qkt1enVXRndXQVRtYXhjTzJiWmQ5?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A0E3817442ABA4BA2C7AC8E8A860DE1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5545.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a462967-71e4-49a8-14f3-08dbdf4aee0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 04:35:11.6968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JP9YfcOb2gXGcf4r8dje0oEJ6WNDKkoStw0wEQSWcIyKEXPaWBFV72JZqCI7nitdhCOCdCr7nI6VRMMseKpEcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7611
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--30.241500-8.000000
X-TMASE-MatchedRID: CML2QBp/u5TUL3YCMmnG4oSO7UPzxVPTjLOy13Cgb4+qvcIF1TcLYECI
        5/RruPKpWGbH9rlTsRx1jWNtcrUYEsRBLZ5x+SkXW3dczJ1Roxd4l6XHn8eFllc/CedjlcvkYCE
        nAolpChBqchArE98tgF8MopUsDFKFQpfQxLB50m2M29hkek7XdwRryDXHx6oXIWeecaNkJBOlQ7
        arRzcA8Sp9WwLNV4Xfaw0V38PIKU3Qf/Mt4GBfb5mug812qIbzOalD+KH6NqjYo1infoN+5F0QK
        bpSqljq9XTev9NfEaV4M5fv5APuyxnsS71Oo/Hwo65WJt1k1O8oUVkB7ifJnsj0Eew4TN42iZpB
        +yrHVcBb6md0AIbGEgMZu8NB5Chk3szvVnpBZzjf8GJjBXCUiMjdPY9FUBho4aROJEypr9xVJ0A
        DqZV4hlRlZzdF9jQfmAssWXde8Y5r8MjU82OTwUhEDfw/93BuncKJki+ooR12rITv+4Qp4fMTuI
        rC6WWher726rLgecGQnT2Pup6fMC8DdD6aqeL3MN+B8zdlz9HOl4wnBhV3q3+xQ2Bqcl6tn+qk6
        BZy3KsKN/CjiKwc/Z0K9Xn3Ln5CXHEPHmpuRH3SBVVc2BozSlkMvWAuahr8+gD2vYtOFhgqtq5d
        3cxkNQP90fJP9eHt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--30.241500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 560BBD8D1A02242E94BC8A8D16004C43013685CA3EF52D0D53D58EE6525626222000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTExLTA3IGF0IDExOjQ4ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gIE9u
IFR1ZSwgTm92IDA3LCAyMDIzIGF0IDAyOjUzOjIwQU0gKzAwMDAsIEVkIFRzYWkgKOiUoeWul+i7
kikgd3JvdGU6DQo+ID4gT24gTW9uLCAyMDIzLTExLTA2IGF0IDE5OjU0ICswODAwLCBNaW5nIExl
aSB3cm90ZToNCj4gPiA+ICBPbiBNb24sIE5vdiAwNiwgMjAyMyBhdCAxMjo1MzozMVBNICswODAw
LCBNaW5nIExlaSB3cm90ZToNCj4gPiA+ID4gT24gTW9uLCBOb3YgMDYsIDIwMjMgYXQgMDE6NDA6
MTJBTSArMDAwMCwgRWQgVHNhaSAo6JSh5a6X6LuSKSB3cm90ZToNCj4gPiA+ID4gPiBPbiBNb24s
IDIwMjMtMTEtMDYgYXQgMDk6MzMgKzA4MDAsIEVkIFRzYWkgd3JvdGU6DQo+ID4gPiA+ID4gPiBP
biBTYXQsIDIwMjMtMTEtMDQgYXQgMTE6NDMgKzA4MDAsIE1pbmcgTGVpIHdyb3RlOg0KPiA+ID4g
PiANCj4gPiA+ID4gLi4uDQo+ID4gPiA+IA0KPiA+ID4gPiA+IFNvcnJ5IGZvciBtaXNzaW5nIG91
dCBvbiBteSBkZCBjb21tYW5kLiBIZXJlIGl0IGlzOg0KPiA+ID4gPiA+IGRkIGlmPS9kYXRhL3Rl
c3RfZmlsZSBvZj0vZGV2L251bGwgYnM9NjRtIGNvdW50PTENCj4gaWZsYWc9ZGlyZWN0DQo+ID4g
PiA+IA0KPiA+ID4gPiBPSywgdGhhbmtzIGZvciB0aGUgc2hhcmluZy4NCj4gPiA+ID4gDQo+ID4g
PiA+IEkgdW5kZXJzdGFuZCB0aGUgaXNzdWUgbm93LCBidXQgbm90IHN1cmUgaWYgaXQgaXMgb25l
IGdvb2QgaWRlYQ0KPiB0bw0KPiA+ID4gY2hlY2sNCj4gPiA+ID4gcXVldWUgbGltaXQgaW4gX19i
aW9faW92X2l0ZXJfZ2V0X3BhZ2VzKCk6DQo+ID4gPiA+IA0KPiA+ID4gPiAxKSBiaW8tPmJpX2Jk
ZXYgbWF5IG5vdCBiZSBzZXQNCj4gPiA+ID4gDQo+ID4gPiA+IDIpIHdoYXQgbWF0dGVycyBpcyBh
Y3R1YWxseSBiaW8ncyBhbGlnbm1lbnQsIGFuZCBiaW8gc2l6ZSBzdGlsbA0KPiBjYW4NCj4gPiA+
ID4gYmUgYmlnIGVub3VnaA0KPiA+ID4gPiANCj4gPiA+ID4gU28gSSBjb29rZWQgb25lIHBhdGNo
LCBhbmQgaXQgc2hvdWxkIGFkZHJlc3MgeW91ciBpc3N1ZToNCj4gPiA+IA0KPiA+ID4gVGhlIGZv
bGxvd2luZyBvbmUgZml4ZXMgc2V2ZXJhbCBidWdzLCBhbmQgaXMgdmVyaWZpZWQgdG8gYmUNCj4g
Y2FwYWJsZQ0KPiA+ID4gb2YNCj4gPiA+IG1ha2luZyBiaWcgJiBhbGlnbmVkIGJpb3MsIGZlZWwg
ZnJlZSB0byBydW4geW91ciB0ZXN0IGFnYWluc3QNCj4gdGhpcw0KPiA+ID4gb25lOg0KPiA+ID4g
DQo+ID4gPiAgYmxvY2svYmlvLmMgfCAyOCArKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+
ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
PiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2Jsb2NrL2Jpby5jIGIvYmxvY2svYmlvLmMNCj4gPiA+
IGluZGV4IDgxNmQ0MTJjMDZlOS4uODBiMzZjZTU3NTEwIDEwMDY0NA0KPiA+ID4gLS0tIGEvYmxv
Y2svYmlvLmMNCj4gPiA+ICsrKyBiL2Jsb2NrL2Jpby5jDQo+ID4gPiBAQCAtMTIxMSw2ICsxMjEx
LDcgQEAgc3RhdGljIGludA0KPiBiaW9faW92X2FkZF96b25lX2FwcGVuZF9wYWdlKHN0cnVjdA0K
PiA+ID4gYmlvICpiaW8sIHN0cnVjdCBwYWdlICpwYWdlLA0KPiA+ID4gIH0NCj4gPiA+ICANCj4g
PiA+ICAjZGVmaW5lIFBBR0VfUFRSU19QRVJfQlZFQyAgICAgKHNpemVvZihzdHJ1Y3QgYmlvX3Zl
YykgLw0KPiA+ID4gc2l6ZW9mKHN0cnVjdCBwYWdlICopKQ0KPiA+ID4gKyNkZWZpbmUgQklPX0NI
VU5LX1NJWkUoMjU2VSA8PCAxMCkNCj4gPiA+ICANCj4gPiA+ICAvKioNCj4gPiA+ICAgKiBfX2Jp
b19pb3ZfaXRlcl9nZXRfcGFnZXMgLSBwaW4gdXNlciBvciBrZXJuZWwgcGFnZXMgYW5kIGFkZA0K
PiB0aGVtDQo+ID4gPiB0byBhIGJpbw0KPiA+ID4gQEAgLTEyNjYsNiArMTI2NywzMSBAQCBzdGF0
aWMgaW50IF9fYmlvX2lvdl9pdGVyX2dldF9wYWdlcyhzdHJ1Y3QNCj4gYmlvDQo+ID4gPiAqYmlv
LCBzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIpDQo+ID4gPiAgc2l6ZSAtPSB0cmltOw0KPiA+ID4gIH0N
Cj4gPiA+ICANCj4gPiA+ICsvKg0KPiA+ID4gKyAqIFRyeSB0byBtYWtlIGJpbyBhbGlnbmVkIHdp
dGggMTI4S0IgaWYgaXQgaXNuJ3QgdGhlIGxhc3Qgb25lLA0KPiBzbw0KPiA+ID4gKyAqIHdlIGNh
biBhdm9pZCBzbWFsbCBiaW8gaW4gY2FzZSBvZiBiaWcgY2h1bmsgc2VxdWVudGlhbCBJTw0KPiBi
ZWNhdXNlDQo+ID4gPiArICogb2YgYmlvIHNwbGl0IGFuZCBtdWx0aXBhZ2UgYnZlYy4NCj4gPiA+
ICsgKg0KPiA+ID4gKyAqIElmIG5vdGhpbmcgaXMgYWRkZWQgdG8gdGhpcyBiaW8sIHNpbXBseSBh
bGxvdyB1bmFsaWduZWQgc2luY2UNCj4gd2UNCj4gPiA+ICsgKiBoYXZlIGNoYW5jZSB0byBhZGQg
bW9yZSBieXRlcw0KPiA+ID4gKyAqLw0KPiA+ID4gK2lmIChpb3ZfaXRlcl9jb3VudChpdGVyKSAm
JiBiaW8tPmJpX2l0ZXIuYmlfc2l6ZSkgew0KPiA+ID4gK3Vuc2lnbmVkIGludCBhbGlnbmVkX3Np
emUgPSAoYmlvLT5iaV9pdGVyLmJpX3NpemUgKyBzaXplKSAmDQo+ID4gPiArfihCSU9fQ0hVTktf
U0laRSAtIDEpOw0KPiA+ID4gKw0KPiA+ID4gK2lmIChhbGlnbmVkX3NpemUgPD0gYmlvLT5iaV9p
dGVyLmJpX3NpemUpIHsNCj4gPiA+ICsvKiBzdG9wIHRvIGFkZCBwYWdlIGlmIHRoaXMgYmlvIGNh
bid0IGtlZXAgYWxpZ25lZCAqLw0KPiA+ID4gK2lmICghKGJpby0+YmlfaXRlci5iaV9zaXplICYg
KEJJT19DSFVOS19TSVpFIC0gMSkpKSB7DQo+ID4gPiArcmV0ID0gbGVmdCA9IHNpemU7DQo+ID4g
PiArZ290byByZXZlcnQ7DQo+ID4gPiArfQ0KPiA+ID4gK30gZWxzZSB7DQo+ID4gPiArYWxpZ25l
ZF9zaXplIC09IGJpby0+YmlfaXRlci5iaV9zaXplOw0KPiA+ID4gK2lvdl9pdGVyX3JldmVydChp
dGVyLCBzaXplIC0gYWxpZ25lZF9zaXplKTsNCj4gPiA+ICtzaXplID0gYWxpZ25lZF9zaXplOw0K
PiA+ID4gK30NCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiAgaWYgKHVubGlrZWx5KCFzaXplKSkg
ew0KPiA+ID4gIHJldCA9IC1FRkFVTFQ7DQo+ID4gPiAgZ290byBvdXQ7DQo+ID4gPiBAQCAtMTI4
NSw3ICsxMzExLDcgQEAgc3RhdGljIGludCBfX2Jpb19pb3ZfaXRlcl9nZXRfcGFnZXMoc3RydWN0
DQo+IGJpbw0KPiA+ID4gKmJpbywgc3RydWN0IGlvdl9pdGVyICppdGVyKQ0KPiA+ID4gIA0KPiA+
ID4gIG9mZnNldCA9IDA7DQo+ID4gPiAgfQ0KPiA+ID4gLQ0KPiA+ID4gK3JldmVydDoNCj4gPiA+
ICBpb3ZfaXRlcl9yZXZlcnQoaXRlciwgbGVmdCk7DQo+ID4gPiAgb3V0Og0KPiA+ID4gIHdoaWxl
IChpIDwgbnJfcGFnZXMpDQo+ID4gPiAtLSANCj4gPiA+IDIuNDEuMA0KPiA+ID4gDQo+ID4gPiAN
Cj4gPiA+IA0KPiA+ID4gVGhhbmtzLCANCj4gPiA+IE1pbmcNCj4gPiA+IA0KPiA+IA0KPiA+IFRo
ZSBsYXRlc3QgcGF0Y2ggeW91IHByb3ZpZGVkIHdpdGggMjU2IGFsaWdubWVudCBkb2VzIGhlbHAN
Cj4gYWxsZXZpYXRlDQo+ID4gdGhlIHNldmVyaXR5IG9mIGZyYWdtZW50YXRpb24uIEhvd2V2ZXIs
IHRoZSBhY3R1YWwgYWxpZ25lZCBzaXplIG1heQ0KPiA+IHZhcnkgZGVwZW5kaW5nIG9uIHRoZSBk
ZXZpY2UuIFVzaW5nIGEgZml4ZWQgYW5kIHVuaXZlcnNhbCBzaXplIG9mDQo+IDEyOA0KPiA+IG9y
IDI1NktCIG9ubHkgcHJvdmlkZXMgcGFydGlhbCByZWxpZWYgZnJvbSBmcmFnbWVudGF0aW9uLg0K
PiA+IA0KPiA+IEkgcGVyZm9ybWVkIGEgZGQgZGlyZWN0IEkvTyByZWFkIG9mIDY0TUIgd2l0aCB5
b3VyIHBhdGNoLCBhbmQNCj4gYWx0aG91Z2gNCj4gPiBtb3N0IG9mIHRoZSBiaW9zIHdlcmUgYWxp
Z25lZCwgdGhlcmUgd2VyZSBzdGlsbCBjYXNlcyBvZg0KPiBtaXNzYWxpZ25tZW50DQo+ID4gdG8g
dGhlIGRldmljZSBsaW1pdCAoZS5nLiwgNTEyTUIgZm9yIG15IGRldmljZSksIGFzIHNob3duIGJl
bG93Og0KPiANCj4gNTEyTUIgaXMgcmVhbGx5IGJpZywgYW5kIGFjdHVhbGx5IHlvdSBoYXZlIHJl
YWNoZWQgMzUyME1CIGluIFJFQUQgYnkNCj4gbGltaXRpbmcgbWF4IGJpbyBzaXplIHRvIDFNQiBp
biB5b3VyIG9yaWdpbmFsIHBhdGNoLg0KPiANCj4gSnVzdCBiZSBjdXJpb3VzIHdoYXQgaXMgdGhl
IGRhdGEgaWYgeW91IGNoYW5nZSB0byBhbGlnbiB3aXRoIG1heA0KPiBzZWN0b3JzDQo+IGFnYWlu
c3QgbXkgbGFzdCBwYXRjaD8gd2hpY2ggY2FuIHRyeSB0byBtYXhpbWl6ZSAmIGFsaWduIGJpby4N
Cg0KU29ycnksIGl0IGlzIGEgdHlwby4gUGxlYXNlIGRpc3JlZ2FyZCBpdC4gSXQgc2hvdWxkIGJl
IDUxMktCIGluc3RlYWQuDQoNCj4gDQo+ID4gDQo+ID4gZGQgWzAwMF0gLi4uLi4gMzkyLjk3Njgz
MDogYmxvY2tfYmlvX3F1ZXVlOiAyNTQsNTIgUiAyOTk3NzYwICsgMzU4NA0KPiA+IGRkIFswMDBd
IC4uLi4uIDM5Mi45Nzk5NDA6IGJsb2NrX2Jpb19xdWV1ZTogMjU0LDUyIFIgMzAwMTM0NCArIDM1
ODQNCj4gPiBkZCBbMDAwXSAuLi4uLiAzOTIuOTgzMjM1OiBibG9ja19iaW9fcXVldWU6IDI1NCw1
MiBSIDMwMDQ5MjggKyAzNTg0DQo+ID4gZGQgWzAwMF0gLi4uLi4gMzkyLjk4NjQ2ODogYmxvY2tf
YmlvX3F1ZXVlOiAyNTQsNTIgUiAzMDA4NTEyICsgMzU4NA0KPiANCj4gWWVhaCwgSSB0aG91Z2h0
IHRoYXQgMTI4S0Igc2hvdWxkIGJlIGZpbmUgZm9yIHVzdWFsIGhhcmR3YXJlLCBidXQNCj4gbG9v
a3Mgbm90IGdvb2QgZW5vdWdoLg0KPiANCj4gPiANCj4gPiBDb21wYXJpbmcgdGhlIHJlc3VsdHMg
b2YgdGhlIEFudHV0dSBTZXF1ZW50aWFsIHRlc3QgdG8gdGhlIHByZXZpb3VzDQo+ID4gZGF0YSwg
aXQgaXMgaW5kZWVkIGFuIGltcHJvdmVtZW50LCBidXQgc3RpbGwgYSBzbGlnaHQgZGlmZmVyZW5j
ZQ0KPiB3aXRoDQo+ID4gbGltaXRpbmcgdGhlIGJpbyBzaXplIHRvIG1heF9zZWN0b3JzOg0KPiA+
IA0KPiA+IFNlcXVlbnRpYWwgUmVhZCAoYXZlcmFnZSBvZiA1IHJvdW5kcyk6DQo+ID4gT3JpZ2lu
YWw6IDMwMzMuNyBNQi9zZWMNCj4gPiBMaW1pdGVkIHRvIG1heF9zZWN0b3JzOiAzNTIwLjkgTUIv
c2VjDQo+ID4gQWxpZ25lZCAyNTZLQjogMzQ3MS41IE1CL3NlYw0KPiA+IA0KPiA+IFNlcXVlbnRp
YWwgV3JpdGUgKGF2ZXJhZ2Ugb2YgNSByb3VuZHMpOg0KPiA+IE9yaWdpbmFsOiAyMjI1LjQgTUIv
c2VjDQo+ID4gTGltaXRlZCB0byBtYXhfc2VjdG9yczogMjgwMC4zIE1CL3NlYw0KPiA+IEFsaWdu
ZWQgMjU2S0I6IDI2MTguMSBNQi9zZWMNCj4gDQo+IFRoYW5rcyBmb3Igc2hhcmluZyB0aGUgZGF0
YS4NCj4gDQo+ID4gDQo+ID4gV2hhdCBpZiB3ZSBsaW1pdCB0aGUgYmlvIHNpemUgb25seSBmb3Ig
dGhvc2Ugd2hvIGhhdmUgc2V0IHRoZQ0KPiA+IG1heF9zZWN0b3JzPw0KPiANCj4gSSB0aGluayBp
dCBtYXkgYmUgZG9hYmxlLCBidXQgbmVlZCBtb3JlIHNtYXJ0IGFwcHJvYWNoIGZvciBhdm9pZGlu
Zw0KPiBleHRyYSBjb3N0IG9mIGlvdl9pdGVyX3JldmVydCgpLCBhbmQgb25lIHdheSBpcyB0byBh
ZGQgYmlvX3NocmluaygpDQo+IChvciBiaW9fcmV2ZXJ0KCkpIHRvIHJ1biB0aGUgYWxpZ25tZW50
IGp1c3Qgb25jZS4NCj4gDQo+IEkgd2lsbCB0aGluayBmdXJ0aGVyIGFuZCB3cml0ZSBhIG5ldyBw
YXRjaCBpZiBpdCBpcyBkb2FibGUuDQo+IA0KPiANCj4gDQo+IFRoYW5rcywNCj4gTWluZw0KPiAN
Cg0KVGhhbmsgeW91IHZlcnkgbXVjaC4gSSB3aWxsIGNvbnRpbnVlIHRvIHN0YXkgdXBkYXRlZCBv
biB0aGlzIGlzc3VlIHRvDQpzZWUgaWYgdGhlcmUgYXJlIGFueSBkaWZmaWN1bHRpZXMgb3IgYWx0
ZXJuYXRpdmUgZGlyZWN0aW9ucyB0aGF0IG1heQ0KYXJpc2UuDQoNCkJlc3QsDQpFZA0K

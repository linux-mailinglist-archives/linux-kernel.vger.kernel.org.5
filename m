Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EE37C7C32
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 05:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjJMDeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 23:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjJMDeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 23:34:17 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19443BC;
        Thu, 12 Oct 2023 20:34:08 -0700 (PDT)
X-UUID: 59dfbdae697911eea33bb35ae8d461a2-20231013
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=O3426FwCkkgVC5KG2SUkC9ltt4JYk5b6SyNyurcJ7Gg=;
        b=XfmOPBJBkmUq4KHCYcQadQfTa1wlHSQAfyHq+LgX92DaknLMY8J3VjrlNxpA8g2i8QrsO6BW05dG0PpRXwCamoUIqcNN4ddXoS7Sr+TvFOruLqvFWMOdy32m8XJvvvDWqZQfUupK3WqxRk5s/r9otwXLpb+ZkJ6cdAw5pMq7pME=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:230003ff-d942-4c8c-9c44-cc07358b53b7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:0771bdf0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 59dfbdae697911eea33bb35ae8d461a2-20231013
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 223424924; Fri, 13 Oct 2023 11:34:01 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 13 Oct 2023 11:33:58 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 13 Oct 2023 11:33:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idjVzw+62f5VSSw5W09NS4+hgGu3waV4Z6t52IAoFDNzadInITivYNYfSFI7k6RPoMaXK+1o3LeWf2GpekRQ3DHAjKgCWTr2h/98XAYBIdcHy7OHDX5u60wsUMs3LRvBb6NP9dDRwLY3p1+pG7/SJGqQ9XIspKwr1+WowvyuoAaCLh/lfMZTUT9DQKiwG21Oam+vYHBhR944ZyctSrAB+/OXPmdxil7Fg9YNOd0ZYMc++G5sM8mKHMy5hz+rBbWm2NkKCskaQy7tmB741a9MNx21WydPNt45PhfGQbb2zysr0RC+HrwJG4Xw5zTywrFiZ2BZRh2fvmpiPQgafnqKqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3426FwCkkgVC5KG2SUkC9ltt4JYk5b6SyNyurcJ7Gg=;
 b=QPhGbEV7MBtGlXC1cyuuzFk6pcx3lWWhnS9wFkkxN77yCnrTcb7zFD9iv8Ob/ixCOIbZB1lYumM5Jy5esJ0zf1sJvWiminTiFsI2oLyYBWqLd3GRplmJ216OVYjA+VQ5doPlFDHDiwiwdiWm4DHQgi5IgGQw/sYpOZ+5aFjkCxc3x3479Q6FGJSNwoVyY8T7ql4tq74bNJkpa4OxEhb12Ya8asBYGgHmReA2iKANvnkV5c58U2DIZP6GIr+6ik5hxfvChcKsSECc+TkGAAgtqj1IqUxfD3YY1LbJ8Dqxu0gf3j3QROQk6G6cgRiIpDxRr2XG37BqM/vPwwx2JTn8RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3426FwCkkgVC5KG2SUkC9ltt4JYk5b6SyNyurcJ7Gg=;
 b=cxufcM4ZvYfpzcP0s+jT80IivyjlaHbchUSiFRYFAkqdtfMGA2S7hE6TfW8SDnoCBiDzLsmLPK6EeWzotXt2KUHSfG1LmCJnIIP6xId2DRwarZIW93fAnBZ2Z/VOWfMdjtmedOxndCDFNLq5OdYK6YYSI6soNhca8j5kHbBGF48=
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com (2603:1096:400:14c::9)
 by TYSPR03MB7980.apcprd03.prod.outlook.com (2603:1096:400:472::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 03:33:56 +0000
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::3375:b210:ae9a:20af]) by TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::3375:b210:ae9a:20af%6]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 03:33:56 +0000
From:   =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        =?utf-8?B?UGluZy1Ic3VuIFd1ICjlkLPnp4nli7Mp?= 
        <Ping-hsun.Wu@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        =?utf-8?B?RGFveXVhbiBIdWFuZyAo6buD6YGT5Y6fKQ==?= 
        <Daoyuan.Huang@mediatek.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v7 00/12] add support MDP3 on MT8195 platform
Thread-Topic: [PATCH v7 00/12] add support MDP3 on MT8195 platform
Thread-Index: AQHZ/OwvKGJ5XKgcvUaiZTzXQF8wMrBGIUAAgADxF4A=
Date:   Fri, 13 Oct 2023 03:33:56 +0000
Message-ID: <b84cb0104f846cf6f5f0dfcb95b40d1b18c2f6b1.camel@mediatek.com>
References: <20231012091206.20165-1-moudy.ho@mediatek.com>
         <592a17cf-b612-bfba-8bac-ff4322448409@collabora.com>
In-Reply-To: <592a17cf-b612-bfba-8bac-ff4322448409@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6356:EE_|TYSPR03MB7980:EE_
x-ms-office365-filtering-correlation-id: 2a694d1d-f0ab-454c-c110-08dbcb9d3afc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6+HKP9JETf02aOIKBr3pj9pUDQm646IdeXkE0btDA90cUXSEiLTna2bxKnukF/ON7Oi77J86CnSrC3mY1gE6yH4T/+HCTG3dWDdwpviYUDbxiKpePPRjh/90l6d0zZF/jrUQ/2HkkvsOfQ49TPH+0wqBtV8sR0bcpGUHb5gcxq02Rp4sidDYzmmtHSBRCkaV1+iz4DcgJfNAgn5T+iIy8fwEm3S61G8TNzGZ2ZGkRuYimKW7rRZwQ2yVypcwlCQISMJNTPlIrb6aHP5gd+Yf2AnrUdgvNLVXWCyjNM2CzMx1JGaRAOG7mDjwGtW3PRZPfYNfEDlz/B/lusapqtz2IS/g/La7IDM8kL353dZY1slO0Gs5XJwSmEghoq7dmcA6ZYiatiqvvfLzaBTNtNuoVnfWIaNPH051QaTVRKqbOUbxcarlv40ykKstLIU1BtBhBpSNyE7JGtFLFqyqgSZ1gDkxmnnH76IJnqHyTGckVceW28lbnBUfUfITedLKof9OCanQYo6tDfsufOUWFvbN6tJRIhhOstnxzuc7D1v50s2Ed1T+KxQlvmapPJJOqfik1iJZnFuOpx/3MDzsLn5fPMfnTmzs2MOGCIuhPMNRMcWPV7ebnYTwmWLHgTP+4VZHFQaQUWzsLrN7H10yY9afte20WMjJeGv7pMVuPnfzF2ouamgZO027BRxzu9vGA/cvA/jB2reNBG67yMNP/ogb8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6356.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(376002)(136003)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6512007)(2616005)(6506007)(478600001)(966005)(6486002)(71200400001)(26005)(83380400001)(2906002)(66446008)(8676002)(54906003)(66946007)(5660300002)(66476007)(66556008)(64756008)(110136005)(76116006)(4326008)(6636002)(8936002)(41300700001)(316002)(4001150100001)(85182001)(38100700002)(36756003)(86362001)(122000001)(38070700005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qkd0K2JMSThsQjVxVVlaS2NTWWF0TnZiY2UydU9aNGhrS2ZIbEw0T3A3MEcr?=
 =?utf-8?B?c2w3QmxJYitqMUNSelNNOHNqUGpnY2xFdlpFeG4wcHk3QVMzU1NTUjMyNjVD?=
 =?utf-8?B?aWN2Z3RmSGVtUmRDdElDSmY3b0I4czlESzhFVE9iejVLNkc3aHF1Z1NDODEx?=
 =?utf-8?B?VkFIWmxGMGwrRDVwSkRvcTJJLzNzUDJPd1VVc2VScUZ1Q1dBVGp2QUkydnVQ?=
 =?utf-8?B?dXRBZ0hSZGJScTV4KzFyVCtSaXdvRFdrRGpjNVRwL0tVaG9CUGMrcUcwTVZx?=
 =?utf-8?B?d2s3SWlyMENTb0orUFYzazdnWTJFZzl5NUM5NU5rSHpsZldJNG9kRkNUT0or?=
 =?utf-8?B?VkhycytobzFLenZUNFVmYUU0NVhXUm1Jc1JlNDFkNEF3Z2drU2FRaHZyU054?=
 =?utf-8?B?ODIrb05VYUU3T0dmM3hTWnhIUzVsQ2F0VWJ2cEVVVXEvQW1QYVU0T2J3Y2wv?=
 =?utf-8?B?V3JkTVowdkRDd3BOQ08vdUNpVHJVZ2ZNdTdvdnRIMmFOZU03MjY5WUVaeW50?=
 =?utf-8?B?TC93eEloVU83Rk5icEVWNVZIN0ptRzdKSHkzSFpibWRpb05yMHQxa0UrL0Zt?=
 =?utf-8?B?dUZ2Z0VkQ3JKRmZFSXVCbndLTkJxa3ZKM0lPbFd6WHErUFdyM3NpUGZ5Mlk3?=
 =?utf-8?B?LytzNEozQ0VYc00wNkxrUnlhWWtLaWdpTkNuclAyOHZVRmJCeUZPQ2lzbmhC?=
 =?utf-8?B?Q1U1NVc3Yk1FR3V6byszYzZ5UXZoOE9hUkhNREFFOWhjMUFtQzN2OHBjdjl6?=
 =?utf-8?B?NWx3UWo3ZjlleGFuNEJZKzZ1WitDdlNtZjNrUXBYd2kwVmpUM3VFN2JWckI3?=
 =?utf-8?B?TkE3T0xSdzVPSzFOc29QM21JQ2orcXcwUHJmcExrM0FLQld6MEUwcE9qM00x?=
 =?utf-8?B?ZGhwMmtXMFVFdHl1Tm9Lc0ZjL2ovcXpyTE93OGJQamhvV0NHVXhKbTgzMkVO?=
 =?utf-8?B?Y0FHcXZFYlBKSEpUaTd4SGNPdnJlZVNZbEkrYStNN0hUUHQ4bFBZc3EwSlVI?=
 =?utf-8?B?UkpRemZzUWwrMWZhNmlTcEZZUXhJMjB2dU1XRWFoSjIwdGhvZ0tzQ2tEck9x?=
 =?utf-8?B?d1UyYXVpckRQZDFFV21RdFlIZzNtZmVRazVCdnduVXM4cWNHeVFPRFhISk9i?=
 =?utf-8?B?SUxicXhlaTFRa045K0JxSDBseXo5LzhEVjdGRE9XcGlhZ2NTeFJaeUo1ODY4?=
 =?utf-8?B?dzU1UnBweVlndnNoY0lLRmloeDRjTjAxYVM0enFnWXFMaWRPQ0lrMHA5d0VK?=
 =?utf-8?B?cjJybGhhWHJ2VjNoMnZteVN0RmlWWUJKenFnL0lkMHEreUpGUWRzUkpPU3dE?=
 =?utf-8?B?VXhtRFN5Tk1TU2d2T09Qckl6d0ZReGlBYytvRGVLaXBNb3hJMW5UMHhNdy9j?=
 =?utf-8?B?ZmY5TGFpdExPdDQ0bUdpZmg4K2xQOG5FSXlXS3lMQmhCL3J0TDE1VjFzMjht?=
 =?utf-8?B?NEtHOGlxZ2h2bTRJckVZdWkxSWc5cUlYVkJkUC9OeG9tV1ZITlFyWnJjeTIz?=
 =?utf-8?B?c2xvUGp0a1QxaTZNakpCZzBQT0wrbGltTDFyOEY0MDR2aWdHdHdwY29KQWFO?=
 =?utf-8?B?dllHUGZraWJrQk9oWHowRk16NEtHRzlsa3ZVSGxMVThPWDJ6eUROdjNmZ05K?=
 =?utf-8?B?UXo4aTI0YkdQWTRvMlBNczRGR2trZExvS1lQWXhaQVdYT3VIbXcvb1o4b1NY?=
 =?utf-8?B?dUtHejZlNzlYL0pYMHRSdXBVdEJONDd1UWJQSTZuSnBFazVaQmFIeU9lSkRk?=
 =?utf-8?B?dms4Y2wyRnc0ZmNJQnBMdng1cHBMNW5Vb1Z6c2I1UEpwcGNmQ25yS013RVVt?=
 =?utf-8?B?RmVKVFZNTVpPV3pZVzNCM2ttd1c1OXFMcHZEN0pvVGlrSExuQXd3YzB5Tyty?=
 =?utf-8?B?WHRjN2RXTlB5UFhpK0tFaDBYWS84eDdmRzRubDZGcFJ4aWppSXVGS1FDZUZl?=
 =?utf-8?B?eDhWa1BsZ0d0Z3d5djZpeTVMNnVsaURId3d0OVoweG1sU2cxQ0lTOE5GaUZ3?=
 =?utf-8?B?MnZSNXdOckszUEhMVjlxV1ZoWXhyY0VUc0FSVGlTVTFIN0RmTHRQZDJwZ0Ra?=
 =?utf-8?B?UE5wMVV6TVNJclIxVDdPMGt4T1FGb2M4TG9mMDJCTk10Rkh4Tkhpdk5jWWZk?=
 =?utf-8?B?RGkrUStGRGtoWkJQM2pQa1ZvNnNGWHBmVFlPdnp0MzVDZlYrSFdhdjN0QVVh?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <995EE883E8D2764CAB4721C9833F11CC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6356.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a694d1d-f0ab-454c-c110-08dbcb9d3afc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 03:33:56.2631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TmSikBLt9X0ojwg/g06xfK9Ffa/w8PEcFIzbPW5Y4T/Hv7FP7b4R5OHIWgEbBqYFl7M2R/rsclSEPp2YhvJREA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7980
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--14.769000-8.000000
X-TMASE-MatchedRID: qEAy/z09Hq3UL3YCMmnG4kD6z8N1m1ALjLOy13Cgb49qSjxROy+AU2yd
        bY7xfgXYuTy74kQkEILPokSuQ+4ltx9J5bZqJbIJe8FaKRfM2oOy4iyjvVWTok+u3rM3lFPn0Vz
        rGplW0Y/T01A2vEikVrUCdLWuvD/FJnHF87MdWeXmAId+2bAQwtAoxr/abSN0RC8FOrq2WvajxY
        yRBa/qJRVHsNBZf9aRPcCXjNqUmkUgBwKKRHe+r24jV+0DEXad7SzpZwqovnn4EvdVeGKaHQzk1
        OQN4d/rORu0iIgMpmo=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.769000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 024305B3F414A8F6676F35665ABFC878894BF8EA4BE2343A3AE768B8BE47417C2000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTEwLTEyIGF0IDE1OjExICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTIvMTAvMjMgMTE6MTEsIE1vdWR5IEhvIGhhIHNjcml0dG86DQo+
ID4gQ2hhbmdlcyBzaW5jZSB2NjoNCj4gPiAtIFJlYmFzZSBvbiB2Ni42LXJjNS4NCj4gPiAtIERl
cGVuZGVudCBkdHNpIGZpbGVzOg0KPiA+ICAgIA0KPiA+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20v
djMvX19odHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsv
bGlzdC8/c2VyaWVzPTc5MjA3OV9fOyEhQ1RSTktBOXdNZzBBUmJ3IWdMY0ZhS295dExIRXZfTjBk
T281enliRmdDbFR1bm11bGtBUlBEWHZnVHkzNUVYcnlnUFg2cC1uRXFpdmVNejlyb0Q0aHlKU3ky
Z0ROSFllNWxSTU9VNHE2UU9aSmJzJA0KPiA+ICANCj4gPiAtIERlcGVuZGVudCBiaW5kaW5nczoN
Cj4gPiAgICANCj4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nlcmllcz03OTI0Nzdf
XzshIUNUUk5LQTl3TWcwQVJidyFnTGNGYUtveXRMSEV2X04wZE9vNXp5YkZnQ2xUdW5tdWxrQVJQ
RFh2Z1R5MzVFWHJ5Z1BYNnAtbkVxaXZlTXo5cm9ENGh5SlN5MmdETkhZZTVsUk1PVTRxNmo3MlBw
RSQNCj4gPiAgDQo+ID4gLSBNb3ZlIHRoZSBwYXRjaCB0aGF0IGZpeGVzIGNvbXBpbGUgd2Fybmlu
Z3MgZnJvbSB0aGlzIHNlcmllcyBhbmQNCj4gPiAgICBjcmVhdGUgYSBzZXBhcmF0ZSBzdGFuZGFs
b25lIHBhdGNoLg0KPiANCj4gWW91IGZvcmdvdCB0byBtZW50aW9uIHRoYXQgbW92aW5nIHRoYXQg
cGF0Y2ggYWRkZWQgYSBkZXBlbmRlbmN5IG9mDQo+IHRoaXMgc2VyaWVzDQo+IG9uIC4uIHRoYXQg
cGF0Y2gsIGF0IFsxXS4NCj4gDQo+IFsxXTogDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3Iv
MjAyMzEwMTIwOTEyMDYuMjAxNjUtMS1tb3VkeS5ob0BtZWRpYXRlay5jb20NCj4gDQo+IENoZWVy
cywNCj4gQW5nZWxvDQo+IA0KDQpIaSBBbmdlbG8sDQoNCkluZGVlZCwgeW91IGFyZSBjb3JyZWN0
ISBUaGFua3MgZm9yIHRoZSBjb3JyZWN0aW9uLiBJJ2xsIG1ha2Ugc3VyZSB0bw0KYmUgbW9yZSBh
dHRlbnRpdmUgdG8gdGhpcyBkZXBlbmRlbmN5IGluIHRoaXMgc2VyaWVzLg0KDQpTaW5jZXJlbHks
DQpNb3VkeQ0K

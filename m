Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B8A7D61AC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 08:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjJYG2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 02:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjJYG2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 02:28:40 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C326011F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 23:28:37 -0700 (PDT)
X-UUID: b6c79d5e72ff11eea33bb35ae8d461a2-20231025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=7KUWdwiInVLWgneq/2lc3kx0BL3a1XshC4QAUJO4m3s=;
        b=dwIylKjmKl1jMmolMTblSHLCZYFweSgEzHQ+HQa0jHqwq+y1Ex51hDjATHlidxkQHQeot3kgm8MI2DTRD8az8zLbPEnqB/6hPispFd23bspQRGVhSatWsqju9j9DRdx0O7kPD07N+Ay5x7KUHOalRUvI+qXoO11hVAmu1PIQFfc=;
X-CID-CACHE: Type:Local,Time:202310251426+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:897dc1e5-ff2d-48a2-913f-da7488e26eb1,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:a2e7e228-cb22-4fa7-8134-287af20ad1fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b6c79d5e72ff11eea33bb35ae8d461a2-20231025
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2046775261; Wed, 25 Oct 2023 14:28:30 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Oct 2023 14:28:29 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 25 Oct 2023 14:28:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3yJSWvPAlaMzIPAPuvrN2PkpX/PZvbwum7OhtWEnUzVwEs0QOjkR/wDGwHekI1T+XaKryBq/u8/I+4oCHTlspvON/pz4VstVdQfKHQvcbXPJqBf4e2d+kMaOrT2CB+bNvkqIkcMoWJvfvyRsIfAYNqZmzwjpjGzP4gMAahH9oUByA2gNYtNEKOb72rtNUTJ9kZMJmHuBH5FsGYMR48JwZ5kfhcHY/NmhaaJfMCDU9bVMCNZIeoPQfALTE1HIcD/X/virLIO7M6vHNGY49OL5/012XlFBZQuy4mAK3WVbMutKEr/jLI9d7DlbTOeWT5Iu+lxJQBn3mKFdUVc4uxiaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KUWdwiInVLWgneq/2lc3kx0BL3a1XshC4QAUJO4m3s=;
 b=LPcf9LrjhCS4JK3LjfIZFda8UA7HTiOFhyM4b0lcvgBK5nKyvn3pkCkRXJHD8fPRd4qbKiM9R6YI0U6nbMKNrwIVIXoB4JSggQ6JQUeyMReSmVhjLsGpKHOgPUbAtwYuspISSNLyu8tyBSmk7TFOmww1YMKRZPoXNWZsCqgKLzMkzwTvgLt/PeT1/jt/faxyM1EzBlUKQQJNBAIp3WrNYACrx/+t9o7jNBZtETvSKYkmQUfPI/njDOzUaGz4ScY87NWCdrvuhtSjKDmSRaA/5azO+CjDBqCHK2YyPQsxXf8zTMznhztJv1L5swo2MjfAaUz3Te89oCRy+ByvPjZqHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KUWdwiInVLWgneq/2lc3kx0BL3a1XshC4QAUJO4m3s=;
 b=ohWRWL1sEnwi+rhvKUgvNudSVjunTFVTPFvNtkNuczFs4SIHYXW9wLmcWxn5MFLsV+M9e0Rs0C72M+P8wvXWR9rd3z39jkwEK58s0LHWkryu568bTwElW2Rgu3kxh0KSdv0ZM0PzsHGaDrsgVdWv84GgEzyrIcn0GStPrXdTqFs=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYSPR03MB7885.apcprd03.prod.outlook.com (2603:1096:400:482::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 06:28:27 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d%7]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 06:28:27 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
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
Subject: Re: [PATCH v2 1/9] dt-bindings: gce: mt8195: Add
 CMDQ_SYNC_TOKEN_SECURE_THR_EOF event id
Thread-Topic: [PATCH v2 1/9] dt-bindings: gce: mt8195: Add
 CMDQ_SYNC_TOKEN_SECURE_THR_EOF event id
Thread-Index: AQHaBYguy8czRkgMj0q5Ru3a5c1MHLBaDdsA
Date:   Wed, 25 Oct 2023 06:28:27 +0000
Message-ID: <749ab5403e3f1e30098a0a8f00e2de431a312c81.camel@mediatek.com>
References: <20231023043751.17114-1-jason-jh.lin@mediatek.com>
         <20231023043751.17114-2-jason-jh.lin@mediatek.com>
         <2c148c48-278d-4b80-b689-971980dddd53@kernel.org>
In-Reply-To: <2c148c48-278d-4b80-b689-971980dddd53@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYSPR03MB7885:EE_
x-ms-office365-filtering-correlation-id: 710a49e9-9f1d-458e-a027-08dbd523991f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ll7nctBZf/cdeGdpTfQ/DZ75OJWfrVee4lvQXiZduF4gHxijWd60rFA0DYQZvDFrIw6l7gO5lZKCohGqBclsKW2zFE5zCaGUibk1+Hj/yDR9YVPCMKr1mE/fLeQ30/75EYs6wGRX2ZDQ02t3UhLvNctOX7nLS56zElikFWOPUoZMrrUiz1MN4n8WAGItwsxd7gictKXsUUv9ChQZsAZ+s9ZsWQfJ5D1+CCe29ywg4UTZxLmjna5JZURvsLtlA5LlTzx05aQ+znux987YIrqz28ek4fBk6x1whPX7jEFIIaVGADaRSZDU/HYX9HRvOC4Aj2Ua+IANMiQVMVf7Sa4Fmi2CiYfMHsEV4ZBZ4xl/R5UvyTFB4lvg0QYlWEVaeCWfFQHlhQFYKCdg7/Gtr1Fhe5viTIZqug5rFdpSr5XaJstKucOKYVTmC1fwi2xp4VLQpo/zCZJgyw61P0Y6tei8oeQaimqiDdEmx2Z0WIqS4TWzHcD5O9qV2Sbqjnh3YOc4vwHVOcN9ABHinW6QgyiyaEKpc5pNmL0rU3dtPgxtamQxt+U5eOxykMiRuoAT90Bpa+tf1S5z8CQIFbWIkGPLTFuknqS0rCQH98OV/SXBSonVaNtAIy53hk2QX4Uxmk/GkX+6vixfJEahvovQWM0NEJLOpNTYDpr0bCDc99oVtGU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(7416002)(83380400001)(71200400001)(5660300002)(64756008)(66556008)(76116006)(41300700001)(86362001)(110136005)(66946007)(66476007)(478600001)(91956017)(6506007)(54906003)(6512007)(6486002)(66446008)(316002)(85182001)(2906002)(4326008)(36756003)(122000001)(38100700002)(8936002)(8676002)(53546011)(2616005)(4001150100001)(26005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGw5aENhdHRTZXdpaGRjWkpQRVQ4ZmhqRE9MdEVIbDdUaW9PWFFFdTV3allw?=
 =?utf-8?B?QnBZTVNsWEpkejltQU9MQW1FMDFtZzlVekdJYTJZeElsSnkyZ2tNcERqcnZq?=
 =?utf-8?B?NUxiQ3JBRndBMUxDTUkxeSt3bEdNTUZMbVRMeDIrS216SE1KTXYyMXlwSWtq?=
 =?utf-8?B?dkZRcGQrVlByZUJJeU1HdVF5bWZmSG02cStWWjVhV0FpUS9WZ05YWkJNa2RS?=
 =?utf-8?B?RUpRaHVaSDMvVzh3b3hxd2lIWDBzWjR6K0tCbUFRNFJKa3NhQ091SE56TjFE?=
 =?utf-8?B?NmdFWUNrY0JMY25vK08zc2RyWktZU2tCS2ZYa0t3dmZZaEd5aU5lY05uZnNJ?=
 =?utf-8?B?L2I2SUltNGRwNEdjTGZ4TUlQY3FnV3lsTkYrbExBUHhrQTRzUlJ6US90ZXZB?=
 =?utf-8?B?aUN5TWl6aVYrYnpBTU42V1dQTXo3NVg1dWZma25MeU41Q2FGbFIvOGJsQ3J6?=
 =?utf-8?B?bEt0Ni83Rk9ka1c1Y3RTNkRXemYzRFJLN1F5Mk00a05JL0taeFoxZmJNUitD?=
 =?utf-8?B?eGJuUmc5MVp4ZkcxQTIzcXRlTE1jQjFCdmg0THZyQ1RMUnVmWmVpVzgzM0Fp?=
 =?utf-8?B?OXlTTkxuV2RyN1A1OEJkVVMrR1pqTTNXMmFqSzFrSG5KMlo0RDUrcmRnVE1P?=
 =?utf-8?B?YThFODA2WEdPWk5Ldklwb3Ixdkg1dWZQaEpUT0tSSE1pTnJyaGl0SnRKZDdx?=
 =?utf-8?B?N1pQZlo2STJFV2MvZWNSeVBHYzVuRjlQcHRVV2x2aXZtMVZENjg0cFU1ZC8r?=
 =?utf-8?B?OHk1elg0YUszMmh2aS8zVEdDT0xGUzJpYnN2Rm5DNDhlVHc2dE9EY0JXOUFv?=
 =?utf-8?B?dGJndnphNlRQOStEY3IxOUtDQ0YxU1BaT0w0djR6S2dWSHJPSHVEa0NISERR?=
 =?utf-8?B?RzU0L2JYL3IyV0JsTThqWE5jUVZhczJ3WEZKNFZTRlNWMEhVRWR3WjlYREE3?=
 =?utf-8?B?MWJtcEh5N3VkV2hLcnpWczdUemlMOWpQWXpKNTBoRXRRSk5mSzh0YnNrNXBW?=
 =?utf-8?B?MGRucVE5WjdneVcxSTVaTWdEdWtnbVY0OFIzbTcvYmFmbzMyaHpGRyszR2Fw?=
 =?utf-8?B?T3dkZzFPR3lGTDE3c1lnRFl0eXJlS2IvMEV4ZDJ3L3orby81UzEzb3hOYkhx?=
 =?utf-8?B?aGNxQ042Y01VQTlxSXEzbWpYVllmVm5Ba2VoQ0daeVArZmwvVjQvNmhuL3dQ?=
 =?utf-8?B?ak5acllKSkVrRE51TFZOdlBrT0tnWVZZV1dueUh4QjMwdFdtcmNURk1IM1ZV?=
 =?utf-8?B?SFh6amVRUmdXUXVOeDJPRk9CemNpQmNzOE9OZno2bHFTSFdGMDBFMFpqWkNy?=
 =?utf-8?B?RUxzUmcyVW9ZSGJ2MTgyQ0pLMmptdHRURzU3Q0VEMzQ5ZlVCR0NyaDlxb1Vv?=
 =?utf-8?B?OTA2ZEVab0RrQ0dOd2NDUXNhMEc4KzBaNHlRWUJZdVZqQ3Exa25sN3cyNTlm?=
 =?utf-8?B?ZlprYzVlWi8xZVpUbjlVNFowaGEzOWlaQ0RwekdoMk5NdGVJZnhJcDNvYU54?=
 =?utf-8?B?WUUwRFR5TWdMMldmdVpnZGgvUytud24wejh4SHM0eWloeHdmS29VTjZvcEN0?=
 =?utf-8?B?QkhnU0NMTjRuL3lHUEwvRUJiRzB6b1JnamsrZ1hBMGloUFc3M0dOZ0dOZnhD?=
 =?utf-8?B?SUZoRWZoOUxDbkpJditJTElNK1BUN2FTZURyVjduUlV2c0NCdmliT0p4LzJE?=
 =?utf-8?B?cUpQQ2VGUml1V3YzTldZYTlqd1lrRGFOWUVTMVBXd3pwZzFrMFAxaWtXZ00z?=
 =?utf-8?B?MnFTUlNhUlkwa25CNXE2M3ZrbDVBNlZ4QVQxd3pBeng0UURmc09hMzdLQ2Y1?=
 =?utf-8?B?cVhpQzEyNDNiQVljNkNGckpGczZxcnNaakRNVE1XMVZvbG01dGo5Q1hqWGV5?=
 =?utf-8?B?TVpDSmxSTHBnRE1nZlU5TjhvaXhzQ290VmpkQ3R0dk1QSnpYSDZ0M0w4Ykhr?=
 =?utf-8?B?d3NlVExCTWtzM1o3dXlMdU9STGVNZnNpRFZkUDBoZndQbmFNSSsxOHE1RkFC?=
 =?utf-8?B?WVdQbDc2bjNJWjZ4aFVvVTN2cWNUYStUdnN6dHBQWkhXYmhRRHYrWlBnTE1m?=
 =?utf-8?B?YlFDNTNBdTV3cUZHWXB3dXlFa2x5R3piVFdsRTg2bEVXLzFBNEh1c2o4Qysr?=
 =?utf-8?B?clV3YkFsdTZpMGtLWjA2ZlRMRTNuVGozdWxuVWYydnloZnAxQU1OVkJVQnl3?=
 =?utf-8?B?SUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1890DF7D3D494F4D9F51582AFEEF601F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 710a49e9-9f1d-458e-a027-08dbd523991f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 06:28:27.2235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mZBX5RL3YuOgL/G/oPeeTt23ptjjiBbGxFri1f++Oy8aLIsLGoQDvZX/CoHZGFigXxkcUAWeTyXynmVp//8bsxmhDMWUpIX998PVPXYk2gU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7885
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--20.576100-8.000000
X-TMASE-MatchedRID: 6otD/cJAac34OiVTWoD8RCa1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
        CsGHURLuwpcJm2NYlPAF6GY0Fb6yCifZYRtbOr2tI0cHLI6lhgKpD1R7N5OROKn5EKVhpwLGAFQ
        yFtt36WwyC+8wmIHbmlFXQFr992Q8X45573JlOaBCnGIuUMP0VUjBz1BQcebWYdn5x3tXIpcrn9
        Wz1CYUsNJKRyQnwzba3na8r6fT2VIO2PAnc5iumAPRhGX0wT3lc3ewuwbSaG5UvqB5o/Lqc+/ug
        SxM1FfQWpFkUq4qHB/tMWwoRLCuauv/j3sV8W9mSHCU59h5KrF9LQinZ4QefKU8D0b0qFy9suf7
        RWbvUtyrusVRy4an8bxAi7jPoeEQftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.576100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 71489B168BF0E37B6DF5B4B09712EEE5F2C70086617118CE45C0F19E199FD2432000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpPbiBNb24sIDIwMjMtMTAtMjMgYXQgMTA6MDggKzAyMDAsIEtyenlz
enRvZiBLb3psb3dza2kgd3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBk
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2
ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgT24gMjMvMTAvMjAyMyAwNjoz
NywgSmFzb24tSkguTGluIHdyb3RlOg0KPiA+IENNRFFfU1lOQ19UT0tFTl9TRUNVUkVfVEhSX0VP
RiBpcyB1c2VkIGFzIHNlY3VyZSBpcnEgdG8gbm90aWZ5IENNRFENCj4gPiBkcml2ZXIgaW4gdGhl
IG5vcm1hbCB3b3JsZCB0aGF0IEdDRSBzZWN1cmUgdGhyZWFkIGhhcyBjb21wbGV0ZWQgYQ0KPiB0
YXNrDQo+ID4gaW4gdGhlZSBzZWN1cmUgd29ybGQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTog
SmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiANCj4gUGxlYXNlIHVz
ZSBzY3JpcHRzL2dldF9tYWludGFpbmVycy5wbCB0byBnZXQgYSBsaXN0IG9mIG5lY2Vzc2FyeQ0K
PiBwZW9wbGUNCj4gYW5kIGxpc3RzIHRvIENDLiBJdCBtaWdodCBoYXBwZW4sIHRoYXQgY29tbWFu
ZCB3aGVuIHJ1biBvbiBhbiBvbGRlcg0KPiBrZXJuZWwsIGdpdmVzIHlvdSBvdXRkYXRlZCBlbnRy
aWVzLiBUaGVyZWZvcmUgcGxlYXNlIGJlIHN1cmUgeW91IGJhc2UNCj4geW91ciBwYXRjaGVzIG9u
IHJlY2VudCBMaW51eCBrZXJuZWwuDQo+IA0KPiBZb3UgbWlzc2VkIGF0IGxlYXN0IGRldmljZXRy
ZWUgbGlzdCAobWF5YmUgbW9yZSksIHNvIHRoaXMgd29uJ3QgYmUNCj4gdGVzdGVkIGJ5IGF1dG9t
YXRlZCB0b29saW5nLiBQZXJmb3JtaW5nIHJldmlldyBvbiB1bnRlc3RlZCBjb2RlIG1pZ2h0DQo+
IGJlDQo+IGEgd2FzdGUgb2YgdGltZSwgdGh1cyBJIHdpbGwgc2tpcCB0aGlzIHBhdGNoIGVudGly
ZWx5IHRpbGwgeW91IGZvbGxvdw0KPiB0aGUgcHJvY2VzcyBhbGxvd2luZyB0aGUgcGF0Y2ggdG8g
YmUgdGVzdGVkLg0KPiANCj4gUGxlYXNlIGtpbmRseSByZXNlbmQgYW5kIGluY2x1ZGUgYWxsIG5l
Y2Vzc2FyeSBUby9DYyBlbnRyaWVzLg0KPiANClRoYW5rcyBmb3IgdGhlIHJlbWluZGVyLCBJJ2xs
IHVzZSBzY3JpcHRzIHRvIGNoZWNrIHRoZSBDQyBsaXN0IGFnYWluDQpuZXh0IHRpbWUhDQoNCj4g
QmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQo=

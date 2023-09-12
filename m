Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C091879C3B4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241875AbjILDHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241085AbjILDHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:07:24 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA93E8B0D;
        Mon, 11 Sep 2023 18:48:42 -0700 (PDT)
X-UUID: 7c541016510e11ee8051498923ad61e6-20230912
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=3l7FbfkmDXcHxLFXGh4Ik34fkAAZzjAC7O1ztPKKYb4=;
        b=sVtAirbFkMqhwsGHI2xK59devxatnkjH91Rz3CuzpmIXFmBBYcY+N7fN7aI2ht5UtxFggeqwTu/kc8peIzMCHuKi9VeCDj3fwF/AA+VKXMowjMoOoasas5caqwr/Tz1wYfZ8vE8zvUzgpvmOoBLHAEFjrTNpPBz6IEk1O/0sI6A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:5427165a-1a07-4c93-ba80-b06dcbac289f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:a444e9c2-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7c541016510e11ee8051498923ad61e6-20230912
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 897574976; Tue, 12 Sep 2023 09:48:35 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 12 Sep 2023 09:48:34 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 12 Sep 2023 09:48:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hnzu3mG8xxDF/0qHUNuFpJM1f9UaXTUkbJ41BraM14rdo+wfK9n7AQBJ1XyFckXi0gHfigLJZc+wLuOde38AB85gsnxVpRVCu6hyCWU8mjQz8cepNsYeA2Mfz6Mo1GjHlif6vHuj5WZm/etMl7d7yomxg/a8/F3bK7mmbjdO+zH4zevq4iEwX4sgF5INOXXqfpPrsU5UXrJaApEYphPytozV4C3xYglOvTmAsC2IyKVhM9gjbJ0R0NC+DomyRMuMr+tOPUQU5vZcJCrCZbDQtP2ioX1XvVruhshwpPNlP5z/tN5qohAl3t8M1tyIfe1wOIoqurV/j6aw/GK0O+BfjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3l7FbfkmDXcHxLFXGh4Ik34fkAAZzjAC7O1ztPKKYb4=;
 b=KTSi3LUBuc/etNSF1i3jsNzLkgNZh3sOmeJ73Ra9iNIeQxe1e4mrL/2ZBBSJPwTpt1L9z1ipapADobcFM/uqFSXVHPjw9Yjp3O5CCHYN3ioghYmPZGTWbUqcEOudZ6gMtJ98Rp0XIL91xYTl9wCjazA4jpHxlpsghGwazohUrs7W+hlqnn0EKKq2+Z+vE1iIo39BvorcNcTYu6RiC+HKdrA2nC2k3Tcn1mrrjpbGr/VhdF+XhkNRDLSXtU9dQuxzLZf+3b1TgFay1suRpDMOP3QWqcstp+L+E5TtET+aIGEg9nDIyt3S4DJAUQsnz343BhBfoqjBgA6aiAFPlNRn1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3l7FbfkmDXcHxLFXGh4Ik34fkAAZzjAC7O1ztPKKYb4=;
 b=XqygO48aWqA854mMaSgZCbxfLlmfQr3NcMt8kYLm8S2qT/Orh5yA7NzVW47laErh2jtSxAMyM3Sl5D6B4qzWbWrq+sIp+YzgwZP/zxhFOArbf7BnRf1H3pcjZF1FuN+QiR8GYPTlVTeyht9Xcjy2jBfwg7dc83vx+QnIvuY8QI0=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by TYZPR03MB7243.apcprd03.prod.outlook.com (2603:1096:400:28f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Tue, 12 Sep
 2023 01:48:30 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::9a3c:4c0b:e835:1004]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::9a3c:4c0b:e835:1004%3]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 01:48:29 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "nhebert@chromium.org" <nhebert@chromium.org>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 12/14] media: medkatek: vcodec: set secure mode to decoder
 driver
Thread-Topic: [PATCH 12/14] media: medkatek: vcodec: set secure mode to
 decoder driver
Thread-Index: AQHZ5K/xmXjsPSANs0u2pLMArEpvXrAVxwwAgACmBwA=
Date:   Tue, 12 Sep 2023 01:48:29 +0000
Message-ID: <5c2ec70c8c346e27b7ddfef56df50bed06d26a5e.camel@mediatek.com>
References: <20230911125936.10648-1-yunfei.dong@mediatek.com>
         <20230911125936.10648-13-yunfei.dong@mediatek.com>
         <1df3e79b84933dda0313d0d9719220dbc06c9022.camel@collabora.com>
In-Reply-To: <1df3e79b84933dda0313d0d9719220dbc06c9022.camel@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|TYZPR03MB7243:EE_
x-ms-office365-filtering-correlation-id: 1d0dd74f-7cde-4c55-aea5-08dbb3325d56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UrM9BOs33lMyl+NhXlWwwbfrPNOhbKpkAX1NLVN57PTO78J8juty4+2UwYVA9ro53X0dr30x3cgUTRR6FOS90uHNXO3I3Nvrn9P6hbY6y4RDH40LDujOnXeai7qmlncj34kMkIZqCdz6P9Jszj8LIlnpuy0M+hl/uyA0hfV7yoCayZn1BvgIXX9INiIM6iTIueGH37hBBxsEU6Z/RIjM5qJYLnGGHtacU0EY4zvTe4FPp+mFeNlqRr0haJXx1FJrX9KSAccxHzxNkniRu8t5PBZBwPsUZjMvt8iX4zQ6yNKB1wQWfovrH6zI/2CE1ylZV4P/oS0w55799kiG1UJ1OxoaVY1EZOx3Mp+3nGoRuZAqidPfjObJeXHuJLmF8tjrjSRbb0k0227NnfxM5Fj0ntucSF3QjJ+1XaAPD8evJtGzCwkDaSGea/87U6O715CE5JevQiRdUPyfDOAwLo3jb1gaVukWW7gt2oSwCBNwX/F1ICTqiMlcwzzH0rbVBVxFxV1y0tHYkWN0o9OYQEM7oyO6B3zWiWeSj4P1jrCVeUyEzetba0VSK27QcTuJc/GU0v7t3gytlBHimmv3tA/QDx5ljqxUeO4cugBxxg3Cf7oV+qlZt5Fl9v4kJJnYIsQnKQmKxgAxoCNbVQW1ba/upfck42c0+Ne/hdj6pcyCdqzXt59oa4LAFRM7VEK9w7F5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(366004)(376002)(346002)(1800799009)(186009)(451199024)(41300700001)(122000001)(6506007)(6486002)(71200400001)(83380400001)(6512007)(66574015)(478600001)(2906002)(2616005)(7416002)(66476007)(66556008)(76116006)(66946007)(54906003)(64756008)(66446008)(26005)(91956017)(8936002)(110136005)(4326008)(8676002)(36756003)(85182001)(38100700002)(38070700005)(86362001)(316002)(5660300002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2xBeXByV29LYXFVK3hvb2NLd3Q4b2VXSUYwYnRqMUZUNjJONVV2dndRaS9D?=
 =?utf-8?B?QUwwdGNNOExkZjNQT2VzYUJWZEpvZk93VlBPclBKVld0Yy9SR0QyREowL2dr?=
 =?utf-8?B?aExSc0l5YStWWThOcjBPajI3V2hqUEJqV3Bua1hiMVQ0NUNYeVRWTDlGYXBw?=
 =?utf-8?B?K0paanlNdGVxUnp6RmNLZkpCQ1UrV2lIaHpqS0N4Qk8wOXl0N2lyQmliQ1hC?=
 =?utf-8?B?YkF6akwrOFVzekU1RFNsTHphbEt6L1JnS2FkdUlRWDJYU2JUMzdYbWpnZGVN?=
 =?utf-8?B?TE5WUnUza2ZYbTJtejFRSTBQNVI5dnM0Uzc5VEtJOEc5NjNHeHZxWHZXdmhB?=
 =?utf-8?B?eTZhRWlEVXc0ejRBU2NhZ2dERkFiOWV1ZC82UnFXTTh1S0hXQWw4WXpuVTYx?=
 =?utf-8?B?ZkY3V0VHVjNiMSs1TXpMV3NxWlYrMExJb1cwZWsrNmlRNml2cmZ2ZktWZUNn?=
 =?utf-8?B?NXZOTFZXSHd5OGdHZHhNdDNxa1RyMWJVV2xGbXJ6VzFkTGhndWVVeDFPQUxt?=
 =?utf-8?B?K0pFZnNtS2tJcmFTZ1BOanh5Sk9MQXJkR3FVQ1h2YnVDdVdEZkkvZXZnamV3?=
 =?utf-8?B?b0tNR2NiUmpwMitUNlpCY2Y4WTVwd1czY0RzN2dNOHdNaThWdW56aFBXWko5?=
 =?utf-8?B?SFlPdm9yMkF0c0M4YStraVhlTWpuazczQzh2dmh2Ky9OWHF4TWVwV1BKZExL?=
 =?utf-8?B?Wk51NlduNE9LSFI4L0VFbTVIcllEOUFpMjRZZ3dwNVA1MXE4bGtLTWtSdHBP?=
 =?utf-8?B?UER0end0di9vZS9GSG0yWEtxTDYzb1dvVndKOWVsOGxTS0dxYnV6N1NvMmNM?=
 =?utf-8?B?TmUrYVdIdE1ET0Q1NmxzcXM3bnNiQkptaFlXQTFCR3BHYnhyVVJ6TFA1VWN6?=
 =?utf-8?B?WE9IcmYxZk5Ca1JkOWpxa3RjVFRCZU5HRGZQVUJiUEpacjJJcUNaZkFLOHBv?=
 =?utf-8?B?VVpzcE95aXVEc3ROdlYrU3l4L1J3UEdialM4SlE5WVBwVk10KzEyUWFkS1dT?=
 =?utf-8?B?T3B1S1BpTG9XM3hYUTZwaUFIaHhrQ3hwSXNESUtTYjRkK2twMVJQU1RYSEJ5?=
 =?utf-8?B?WWJGUStUaVFNVUo5c0VvUmhzMXZUaXdRYkZ4QUd3ZWFOWnV0dTIvZjd4YnFU?=
 =?utf-8?B?VksrTkt5THRiN1lQUEhSeXRaWkVHNUs5c05xbis0b1d3bDBXcmdWOThlQmFT?=
 =?utf-8?B?eVhyTzRRT0k3UU5KT1ozN1R0UnBzaVdNMDE0SlZyMHppNlNOems1N1ZnRW81?=
 =?utf-8?B?TUhCSHVuK1ZKd0JUb1Rwa3U2Qk9hWEU3RWhYRUlka0s2UGZXN09HemRyYy9L?=
 =?utf-8?B?aE9kVjJiM3h2TDAzSXB2Z29QVHZrR01YYjRwSURLRVZkK3lPV1VsOS81N2Jl?=
 =?utf-8?B?dXBqOEltRkFXbEQyZW1lZzBKbmRadWFHd0lnNnloU1N1Ry9NM2xsN1BXU3lH?=
 =?utf-8?B?VlNWTEhYckt3dC9zMTlXcVhFaWZuRHdIZXhPcEpxSzFTcTFoUGEza2xrYk5H?=
 =?utf-8?B?NmhSRFA4aCtnNWgyTjlFMW1RS0Rhbkl4OEtEU2lhWmZqaW1wWlBaLzI2czlx?=
 =?utf-8?B?L0dDc3VZWU1NMTlKWVlaVi8rOUlKcXJ0Rk9JenNncXNpT3dQVGF3a0I1US9i?=
 =?utf-8?B?K3gvUlVHUHMzNEhGMHBpRk52UFk1bDNjZmxzWjZRV0hucnhjQ3A5a3IzWXFZ?=
 =?utf-8?B?TG5TQlR4NENKWUM2M0ZZTms5cld6cTBZR0pXQVlaYnJ1WGNUNmQvU0p6ZUJM?=
 =?utf-8?B?YmNEeXVTYUJnb0pXVmpUT1NWVHZ0YTlNb2tGYjFRaUw3RTRoOXRKTTZHUERN?=
 =?utf-8?B?Z0tualp4eTZHRkd0bHRCcWxnY0huTTFvMDZIb01NNFpobDZ3aWtlSHFqLytJ?=
 =?utf-8?B?MjZQZXZqRlpVVm0wdHhlMGFxNlltaE8zMHVZYzdHQ0dhdnoxZGJCYjRPcmNy?=
 =?utf-8?B?cHQ3b0ZTMllNY3dWRklhZFhsbzhSdTdaY0F5TFhxYUF2SVFxRlRHMWYwdGJm?=
 =?utf-8?B?c0owY0RlMWdyNzZlMi80S0ZRa05jNENzcFd1cXlkaHB0eFlFM2VUVGxjN1BP?=
 =?utf-8?B?QjRSNWNYVTVEMlhVby80T1EwNHNpMUFKaVNZQktGZEE4ZW9rWmM1eG9zem5s?=
 =?utf-8?B?YXA1STM0WE1kWmx6LzJvMjF5Wkt1SndTSDJoOG5JbEpGZlFSYTdzVUdNMmlM?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B64A6F134613CF4DAD6C8ED8163B0BDF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0dd74f-7cde-4c55-aea5-08dbb3325d56
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 01:48:29.8138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s/PLIP9SFul5OXUqXaR33mVogFEH+1SRT2/4zGFkhybDLHwNNX4nJZ01vd7PAxuclH+6Y9KzcPexeQQ37JlvqNbPe9j7GxcL3GcVteIZuhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7243
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--25.976000-8.000000
X-TMASE-MatchedRID: oHOSwQSJZWinykMun0J1wpmug812qIbz+WzVGPiSY8gNcckEPxfz2D6h
        VXnKDh9XIKnWpFLTpyGiqe/ZVVcKs2F9INTZ2jjMQpxiLlDD9FVMjQ19j30wyejzwWp0x0yJXvb
        V/VnUv0qJn8yr08NWYZbiTEZvM55sX2XQkFZkGg9c/msUC5wFQXJrB0Cu3DDn31GU/N5W5BARcU
        eSUAEujkRy0RXCimV3eDOX7+QD7stnPzp+oCPs8x3EEAbn+GRbqhvPxC4gDvONWJChKDEmn7l+7
        5cRptKmrsEj0gQumkMOCnJy1V4q9xflU176JR5Fj5hLPCX3ZdNrsYqCSA+vUbrfxlRjqBJ3SGGK
        QPXm3qZxkJLkHTt3pMQ3qkC9R1prg+QbvWfvu8iimtMQe97AACBALBZgCNJadow/ybqqTpKt0vJ
        crVX4uKqbkKstqvITDuW2jCd4GlpZT98H9cWYnJ4CIKY/Hg3AwWulRtvvYxTUHQeTVDUrItRnEQ
        CUU+jzjoczmuoPCq2UTGVAhB5EbQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--25.976000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 8EB2091C95E888DC492AAA9065689E619C2CC3061D4DA3DEA5426E17DE9C22012000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmljb2xhcywNCg0KVGhhbmtzIGZvciB5b3VyIGFkdmljZS4NCg0KT24gTW9uLCAyMDIzLTA5
LTExIGF0IDExOjU0IC0wNDAwLCBOaWNvbGFzIER1ZnJlc25lIHdyb3RlOg0KPiBIaSwNCj4gDQo+
IExlIGx1bmRpIDExIHNlcHRlbWJyZSAyMDIzIMOgIDIwOjU5ICswODAwLCBZdW5mZWkgRG9uZyBh
IMOpY3JpdCA6DQo+ID4gU2V0dGluZyBzZWN1cmUgbW9kZSBmbGFnIHRvIGtlcm5lbCB3aGVuIHRy
eWluZyB0byBwbGF5IHNlY3VyZQ0KPiA+IHZpZGVvLA0KPiA+IHRoZW4gZGVjb2RlciBkcml2ZXIg
d2lsbCBpbml0aWFsaXplIHRlZSByZWxhdGVkIGludGVyZmFjZSB0bw0KPiA+IHN1cHBvcnQNCj4g
PiBzdnAuDQo+IA0KPiANCj4gVGhpcyBpcyBub3Qgd2hhdCB0aGUgcGF0Y2ggaXMgZG9pbmcsIHBs
ZWFzZSByZXdvcmsuIFRoaXMgcGF0Y2ggaXMgYW4NCj4gdmVuZG9yIEFQSQ0KPiBhZGRpdGlvbiBp
bnRyb2R1Y2luZyBWNEwyX0NJRF9NUEVHX01US19TRVRfU0VDVVJFX01PREUuIEkgc2hvdWxkIG5v
dA0KPiBoYXZlIHRvDQo+IHJlYWQgeW91ciBwYXRjaCB0byB1bmRlcnN0YW5kIHRoaXMuDQo+IA0K
SSBkb24ndCBrbm93IHlvdXIgbWVhbmluZyBjbGVhcmx5LiBXaGV0aGVyIEkgbmVlZCB0byBhZGQg
b25lIG5ldyBwYXRjaA0KdG8gYWRkIHRoZSBkZWZpbml0aW9uIG9mIFY0TDJfQ0lEX01QRUdfTVRL
X1NFVF9TRUNVUkVfTU9ERT8gVGhhbiB0aGUNCmRyaXZlciBjYWxsaW5nIGl0IHRvIHNldCBzZWN1
cmUgbW9kZT8NCg0KQmVzdCBSZWdhcmRzLA0KWXVuZmVpIERvbmcNCg0KPiA+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFl1bmZlaSBEb25nIDx5dW5mZWkuZG9uZ0BtZWRpYXRlay5jb20+DQo+ID4gLS0t
DQo+ID4gIC4uLi92Y29kZWMvZGVjb2Rlci9tdGtfdmNvZGVjX2RlY19zdGF0ZWxlc3MuYyAgICAg
fCAxNQ0KPiA+ICsrKysrKysrKysrKysrLQ0KPiA+ICBkcml2ZXJzL21lZGlhL3Y0bDItY29yZS92
NGwyLWN0cmxzLWRlZnMuYyAgICAgICAgIHwgIDUgKysrKysNCj4gPiAgaW5jbHVkZS91YXBpL2xp
bnV4L3Y0bDItY29udHJvbHMuaCAgICAgICAgICAgICAgICB8ICAxICsNCj4gPiAgMyBmaWxlcyBj
aGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdA0KPiA+IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvZGVjb2Rl
ci9tdGtfdmNvZGVjX2RlY19zdGENCj4gPiB0ZWxlc3MuYw0KPiA+IGIvZHJpdmVycy9tZWRpYS9w
bGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvZGVjb2Rlci9tdGtfdmNvZGVjX2RlY19zdGENCj4gPiB0
ZWxlc3MuYw0KPiA+IGluZGV4IGQyYjA5Y2U5ZjFjZi4uYTk4MTE3OGMyNWQ5IDEwMDY0NA0KPiA+
IC0tLQ0KPiA+IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvZGVjb2Rl
ci9tdGtfdmNvZGVjX2RlY19zdGENCj4gPiB0ZWxlc3MuYw0KPiA+ICsrKw0KPiA+IGIvZHJpdmVy
cy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvZGVjb2Rlci9tdGtfdmNvZGVjX2RlY19z
dGENCj4gPiB0ZWxlc3MuYw0KPiA+IEBAIC01MzUsNiArNTM1LDE3IEBAIHN0YXRpYyBpbnQgbXRr
X3ZkZWNfc19jdHJsKHN0cnVjdCB2NGwyX2N0cmwNCj4gPiAqY3RybCkNCj4gPiAgCQljdHJsLT52
YWwgPSBtdGtfZG1hX2NvbnRpZ19nZXRfc2VjdXJlX2hhbmRsZShjdHgsIGN0cmwtDQo+ID4gPnZh
bCk7DQo+ID4gIAkJbXRrX3Y0bDJfdmRlY19kYmcoMywgY3R4LCAiZ2V0IHNlY3VyZSBoYW5kbGU6
ICVkID0+DQo+ID4gMHgleCIsIHNlY19mZCwgY3RybC0+dmFsKTsNCj4gPiAgCQlicmVhazsNCj4g
PiArCWNhc2UgVjRMMl9DSURfTVBFR19NVEtfU0VUX1NFQ1VSRV9NT0RFOg0KPiANCj4gU3RlcHBp
bmcgYmFjayBhIGxpdHRsZSBhbmQgZm9jdXNpbmcgb24gdGhlIEFQSSwgd2hhdCBtYWtlcyB5b3Vy
DQo+IGRyaXZlciBzbw0KPiBzcGVjaWFsIHRoYXQgaXQgc2hvdWxkIGJlIHRoZSBvbmx5IG9uZSBo
YXZpbmcgYSAic2VjdXJlIG1vZGUiID8gV2UNCj4gYXJlIHRvdWNoaW5nDQo+IGluIGdhcCBpbiB0
aGUgbWVkaWEgcGlwZWxpbmUgaW4gTGludXgsIGFuZCB0aGlzIHNob3VsZCBjb21lIHdpdGgNCj4g
Y29uc2lkZXJhdGlvbg0KPiBvZiB0aGUgZ2xvYmFsIEFQSS4NCj4gDQo+IFdoeSBpcyB0aGlzIEFQ
SSBiZXR0ZXIgdGhlbiBsZXQncyBzYXkgR29vZ2xlIEFuZHJvaWQgb25lLCB3ZXJlIHRoZXkNCj4g
ZXhwb3NlIDINCj4gZGV2aWNlIG5vZGVzIGluIHRoZWlyIGZvcmsgb2YgdGhlIE1GQyBkcml2ZXIg
KGEgc2VjdXJlIGFuZCBhIG5vbg0KPiBzZWN1cmUgb25lKSA/DQo+IA0KPiByZWdhcmRzLA0KPiBO
aWNvbGFzDQo+IA0KPiBwLnMuIHlvdSBmb3Jnb3QgdG8gZG9jdW1lbnQgeW91ciBjb250cm9sIGlu
IHRoZSBSU1QgZG9jLCBwbGVhc2UgZG8gaW4NCj4gZm9sbG93aW5nDQo+IHJlbGVhc2UuDQo+IA0K
PiA+ICsJCWN0eC0+aXNfc3ZwX21vZGUgPSBjdHJsLT52YWw7DQo+ID4gKw0KPiA+ICsJCWlmIChj
dHgtPmlzX3N2cF9tb2RlKSB7DQo+ID4gKwkJCXJldCA9IG10a192Y29kZWNfZGVjX29wdGVlX29w
ZW4oY3R4LT5kZXYtDQo+ID4gPm9wdGVlX3ByaXZhdGUpOw0KPiA+ICsJCQlpZiAocmV0KQ0KPiA+
ICsJCQkJbXRrX3Y0bDJfdmRlY19lcnIoY3R4LCAib3BlbiBzZWN1cmUNCj4gPiBtb2RlIGZhaWxl
ZC4iKTsNCj4gPiArCQkJZWxzZQ0KPiA+ICsJCQkJbXRrX3Y0bDJfdmRlY19kYmcoMywgY3R4LCAi
ZGVjb2RlciBpbg0KPiA+IHNlY3VyZSBtb2RlOiAlZCIsIGN0cmwtPnZhbCk7DQo+ID4gKwkJfQ0K
PiA+ICsJCWJyZWFrOw0KPiA+ICAJZGVmYXVsdDoNCj4gPiAgCQltdGtfdjRsMl92ZGVjX2RiZygz
LCBjdHgsICJOb3Qgc3VwcG9ydGVkIHRvIHNldCBjdHJsDQo+ID4gaWQ6IDB4JXhcbiIsIGhkcl9j
dHJsLT5pZCk7DQo+ID4gIAkJcmV0dXJuIHJldDsNCj4gPiBAQCAtNTczLDcgKzU4NCw3IEBAIHN0
YXRpYyBpbnQgbXRrX3Zjb2RlY19kZWNfY3RybHNfc2V0dXAoc3RydWN0DQo+ID4gbXRrX3Zjb2Rl
Y19kZWNfY3R4ICpjdHgpDQo+ID4gIAl1bnNpZ25lZCBpbnQgaTsNCj4gPiAgCXN0cnVjdCB2NGwy
X2N0cmwgKmN0cmw7DQo+ID4gIA0KPiA+IC0JdjRsMl9jdHJsX2hhbmRsZXJfaW5pdCgmY3R4LT5j
dHJsX2hkbCwgTlVNX0NUUkxTICsgMSk7DQo+ID4gKwl2NGwyX2N0cmxfaGFuZGxlcl9pbml0KCZj
dHgtPmN0cmxfaGRsLCBOVU1fQ1RSTFMgKyAyKTsNCj4gPiAgCWlmIChjdHgtPmN0cmxfaGRsLmVy
cm9yKSB7DQo+ID4gIAkJbXRrX3Y0bDJfdmRlY19lcnIoY3R4LCAidjRsMl9jdHJsX2hhbmRsZXJf
aW5pdA0KPiA+IGZhaWxlZFxuIik7DQo+ID4gIAkJcmV0dXJuIGN0eC0+Y3RybF9oZGwuZXJyb3I7
DQo+ID4gQEAgLTU5Miw2ICs2MDMsOCBAQCBzdGF0aWMgaW50IG10a192Y29kZWNfZGVjX2N0cmxz
X3NldHVwKHN0cnVjdA0KPiA+IG10a192Y29kZWNfZGVjX2N0eCAqY3R4KQ0KPiA+ICANCj4gPiAg
CWN0cmwgPSB2NGwyX2N0cmxfbmV3X3N0ZCgmY3R4LT5jdHJsX2hkbCwNCj4gPiAmbXRrX3Zjb2Rl
Y19kZWNfY3RybF9vcHMsDQo+ID4gIAkJCQkgVjRMMl9DSURfTVBFR19NVEtfR0VUX1NFQ1VSRV9I
QU5ETEUsDQo+ID4gMCwgNjU1MzUsIDEsIDApOw0KPiA+ICsJY3RybCA9IHY0bDJfY3RybF9uZXdf
c3RkKCZjdHgtPmN0cmxfaGRsLA0KPiA+ICZtdGtfdmNvZGVjX2RlY19jdHJsX29wcywNCj4gPiAr
CQkJCSBWNEwyX0NJRF9NUEVHX01US19TRVRfU0VDVVJFX01PREUsIDAsDQo+ID4gNjU1MzUsIDEs
IDApOw0KPiA+ICANCj4gPiAgCXY0bDJfY3RybF9oYW5kbGVyX3NldHVwKCZjdHgtPmN0cmxfaGRs
KTsNCj4gPiAgDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvdjRsMi1jb3JlL3Y0bDIt
Y3RybHMtZGVmcy5jDQo+ID4gYi9kcml2ZXJzL21lZGlhL3Y0bDItY29yZS92NGwyLWN0cmxzLWRl
ZnMuYw0KPiA+IGluZGV4IGQ4Y2YwMWY3NmFhYi4uYTUwNzA0NWEzZjMwIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvbWVkaWEvdjRsMi1jb3JlL3Y0bDItY3RybHMtZGVmcy5jDQo+ID4gKysrIGIv
ZHJpdmVycy9tZWRpYS92NGwyLWNvcmUvdjRsMi1jdHJscy1kZWZzLmMNCj4gPiBAQCAtMTA0Miw2
ICsxMDQyLDcgQEAgY29uc3QgY2hhciAqdjRsMl9jdHJsX2dldF9uYW1lKHUzMiBpZCkNCj4gPiAg
CWNhc2UgVjRMMl9DSURfTVBFR19WSURFT19SRUZfTlVNQkVSX0ZPUl9QRlJBTUVTOglyZXR1cm4N
Cj4gPiAiUmVmZXJlbmNlIEZyYW1lcyBmb3IgYSBQLUZyYW1lIjsNCj4gPiAgCWNhc2UgVjRMMl9D
SURfTVBFR19WSURFT19QUkVQRU5EX1NQU1BQU19UT19JRFI6CQlyZXQNCj4gPiB1cm4gIlByZXBl
bmQgU1BTIGFuZCBQUFMgdG8gSURSIjsNCj4gPiAgCWNhc2UgVjRMMl9DSURfTVBFR19NVEtfR0VU
X1NFQ1VSRV9IQU5ETEU6CQlyZXR1cm4NCj4gPiAiTWVkaWFUZWsgRGVjb2RlciBnZXQgc2VjdXJl
IGhhbmRsZSI7DQo+ID4gKwljYXNlIFY0TDJfQ0lEX01QRUdfTVRLX1NFVF9TRUNVUkVfTU9ERToJ
CQlyZXQNCj4gPiB1cm4gIk1lZGlhVGVrIERlY29kZXIgc2V0IHNlY3VyZSBtb2RlIjsNCj4gPiAg
DQo+ID4gIAkvKiBBVjEgY29udHJvbHMgKi8NCj4gPiAgCWNhc2UgVjRMMl9DSURfTVBFR19WSURF
T19BVjFfUFJPRklMRToJCQlyZXQNCj4gPiB1cm4gIkFWMSBQcm9maWxlIjsNCj4gPiBAQCAtMTQ0
Miw2ICsxNDQzLDEwIEBAIHZvaWQgdjRsMl9jdHJsX2ZpbGwodTMyIGlkLCBjb25zdCBjaGFyDQo+
ID4gKipuYW1lLCBlbnVtIHY0bDJfY3RybF90eXBlICp0eXBlLA0KPiA+ICAJCSp0eXBlID0gVjRM
Ml9DVFJMX1RZUEVfSU5URUdFUjsNCj4gPiAgCQkqZmxhZ3MgfD0gVjRMMl9DVFJMX0ZMQUdfV1JJ
VEVfT05MWTsNCj4gPiAgCQlicmVhazsNCj4gPiArCWNhc2UgVjRMMl9DSURfTVBFR19NVEtfU0VU
X1NFQ1VSRV9NT0RFOg0KPiA+ICsJCSp0eXBlID0gVjRMMl9DVFJMX1RZUEVfSU5URUdFUjsNCj4g
PiArCQkqZmxhZ3MgfD0gVjRMMl9DVFJMX0ZMQUdfV1JJVEVfT05MWTsNCj4gPiArCQlicmVhazsN
Cj4gPiAgCWNhc2UgVjRMMl9DSURfVVNFUl9DTEFTUzoNCj4gPiAgCWNhc2UgVjRMMl9DSURfQ0FN
RVJBX0NMQVNTOg0KPiA+ICAJY2FzZSBWNEwyX0NJRF9DT0RFQ19DTEFTUzoNCj4gPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L3Y0bDItY29udHJvbHMuaA0KPiA+IGIvaW5jbHVkZS91
YXBpL2xpbnV4L3Y0bDItY29udHJvbHMuaA0KPiA+IGluZGV4IDdiMzY5NDk4NTM2Ni4uODhlOTBk
OTQzZTM4IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC92NGwyLWNvbnRyb2xz
LmgNCj4gPiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvdjRsMi1jb250cm9scy5oDQo+ID4gQEAg
LTk1Nyw2ICs5NTcsNyBAQCBlbnVtIHY0bDJfbXBlZ19tZmM1MV92aWRlb19mb3JjZV9mcmFtZV90
eXBlIHsNCj4gPiAgLyogIE1QRUctY2xhc3MgY29udHJvbCBJRHMgc3BlY2lmaWMgdG8gdGhlIE1l
ZGlhVGVrIERlY29kZXIgZHJpdmVyDQo+ID4gYXMgZGVmaW5lZCBieSBWNEwyICovDQo+ID4gICNk
ZWZpbmUgVjRMMl9DSURfTVBFR19NVEtfQkFTRQkJCShWNEwyX0NUUkxfQ0xBUw0KPiA+IFNfQ09E
RUMgfCAweDIwMDApDQo+ID4gICNkZWZpbmUgVjRMMl9DSURfTVBFR19NVEtfR0VUX1NFQ1VSRV9I
QU5ETEUJKFY0TDJfQ0lEX01QRUdfDQo+ID4gTVRLX0JBU0UrOCkNCj4gPiArI2RlZmluZSBWNEwy
X0NJRF9NUEVHX01US19TRVRfU0VDVVJFX01PREUJKFY0TDJfQ0lEX01QRUdfTVRLX0JBU0UNCj4g
PiArOSkNCj4gPiAgDQo+ID4gIC8qICBDYW1lcmEgY2xhc3MgY29udHJvbCBJRHMgKi8NCj4gPiAg
DQo+IA0KPiANCg==

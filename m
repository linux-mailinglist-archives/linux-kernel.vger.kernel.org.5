Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225BC7B5F68
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 05:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjJCDeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 23:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjJCDeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 23:34:21 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70C8C6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 20:34:17 -0700 (PDT)
X-UUID: b923e012619d11eea33bb35ae8d461a2-20231003
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=LmLkHd+dFWPBf2oVsktVlvtoDaeeW1s56Uyvi6mBVqg=;
        b=ZRumVga64jQ2G0rXOPkm312DHYx/D+jBAVAOnkLq3R1CNE0dw18WgRnG3rCnd0Z5fFuL7b1bkjNnCqc2nTdqxdN3luCfW0HT6seaR1jS7mcRD6jrih4I9YZeBfdxmbuN4fser5o4AirwT5EIqmm/X5kBBWg9mu1P+dklbP9ifOU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:12f0a96f-bc9f-496d-b3d2-1326f35f9ce8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:a33884bf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b923e012619d11eea33bb35ae8d461a2-20231003
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 546306510; Tue, 03 Oct 2023 11:34:13 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 3 Oct 2023 11:34:12 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 3 Oct 2023 11:34:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlIKAhJxkYFaSp2tSzbw377m/WY0XmJSheIZZRkqX4z7DAjt04BV5WLih1YwVN8XAtb82y7BhFHXp/65DoY8wdddIrCX2eDqRKhLhxVZIfvnse0q8nZrzQxXVkFnplFQ1hFpuFi7vak1ZblMzTr39iy0zi0uFNi2MpiVuGqyF6fWjYJt0Tal8lskKDLkgfLtj43p7BMT6b4rHtyZgOQ6NG41wRO6zVg7GBMU1TkobRQEgAjLQB6ffFVwyF+eH6kffhaNeP7JlZadYweM2D/vv1CUWWpUfPiqFV5PVx8Xj/r1/6LgFc1GaEcqx1hGZ7p+OM4URLBegyaSmQaBScSo5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmLkHd+dFWPBf2oVsktVlvtoDaeeW1s56Uyvi6mBVqg=;
 b=FsBgFuM2sRldOYVQYU5LUc+tvXLLhq4dglviGR3cVw3csh6gylzSlZd+2SC83XRrvQ6gYgOVdGI4FmmpDfSql6gImI54dFVH/2CxoraBlC5tv1FMxySmz5xZJ3zBvIeDUfFPbt0WTli6TeT4tsqQt8bG5JpIz5/OlapYBuCxdDrkxigQklMIt8WCpC2c/iuijeP+PU2HaVOv0egrpnRi3EAFOzmRmMGp8pfsOROkPclWY5MN158z/mJrv9LyZ1fRIB7cctWuLakGQfpaO9sq8OFZ3lfcKFwJiVPXjshBBs/H7BNb3mTz27iYX6KRHWp8lzq7dcrR0G1BB1mFipQJrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmLkHd+dFWPBf2oVsktVlvtoDaeeW1s56Uyvi6mBVqg=;
 b=INJyRnWCgZiqz9NPfwQ7+O8vYg6jxiMFm+wkHi3SpkG0kkYEj9uT4H/WvHObGBUAAdbqLR3/AxGOU5Xdm9Y2z1MdKhIe1qfmiW0Z7H+/lzeiH3yhsLwVLdSTye8MuJRBhqO+6XMy4UDHsjODxe51blmro8apOZOswzQ2ptfzZKM=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SI2PR03MB6081.apcprd03.prod.outlook.com (2603:1096:4:14b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 3 Oct
 2023 03:34:10 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ceab:94f0:6e70:b85e]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ceab:94f0:6e70:b85e%5]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 03:34:10 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        =?utf-8?B?TmF0aGFuIEx1ICjlkYLmnbHpnJYp?= <Nathan.Lu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v10 5/9] drm/mediatek: Add connector dynamic selection
 capability
Thread-Topic: [PATCH v10 5/9] drm/mediatek: Add connector dynamic selection
 capability
Thread-Index: AQHZ8VjJVfyYkTFEQ0W4IzryNLbmKrAwAogAgAYbAYCAADTAgIABH/WA
Date:   Tue, 3 Oct 2023 03:34:10 +0000
Message-ID: <7855953c52961f3d1d9992f0b4303eadee3fe724.camel@mediatek.com>
References: <20230927153833.23583-1-jason-jh.lin@mediatek.com>
         <20230927153833.23583-6-jason-jh.lin@mediatek.com>
         <891fe60a-cee9-29ab-3214-848b1161a0a7@collabora.com>
         <1780d283425dea81e894fc75eeb893ab7a1faff2.camel@mediatek.com>
         <4303dcfd-4dc1-18da-8884-1cb9b0bfa0a9@collabora.com>
In-Reply-To: <4303dcfd-4dc1-18da-8884-1cb9b0bfa0a9@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SI2PR03MB6081:EE_
x-ms-office365-filtering-correlation-id: de29d80e-e3a7-4c80-6622-08dbc3c19b45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LfkIL4TPZhSehL+gACN62N5cm+VumP+cBkgJK0i2Uspl+SDGiXJKR5e+v9v6avF85Zya5ckiRz/iURnP94x8YquDkB8Z+TxGbrZLhlUgRW1s+Uzi9qrRbEVEeQ4cE5KaWPxRdFjG9uq++XJuTUZ4HuhSChMafD3BZl9fmS5pMSJBuX8vRykmH92BY8BWXKJVY2yQPy+TsPGz+DqI1kCklS11y0tMBf9ghC2ZzqkHzc7dT7EhBda+X/sYJGq++NOpQ95I7XyvhHYqTi4AxivndQ+z+Y6eRrldQGoa35SX/nCjtgvnq0dojmPnpe3/8wHSD8uSjLeeQeHvt5vpxShT12gkXPOO9pcwLe+OCzv4RaCwR8BQ0DaH19W3uB2RGsLiFMkW92Y6qsfUb/uCu0BfoTXqsWKHNbrFCBMya/A7N2OC8lZ1unO14aejBX6a/c2pN8AbmQoOGwBMZGpkoONooQnSd8G4ouWa6uZwpwGqACxU2uX6IBYObMcZ4+/ZJp3toiyeBrXcoCO4ypNOIxgDagYVJ6hS4kQX++TSPEeeGwSHzpp9LXmBSzwOAVjIxCJ27NHJ9QLFPapbt5QRVHZnk7xpxbrBJ46AXL6Qb7ZN30uC+xYaFm9+lVPwTvccDQex6kLCpEUNC593ocLVGFeVSiLxVNP1l+D9AJUes72xJZY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(86362001)(4744005)(2906002)(8676002)(8936002)(4326008)(316002)(36756003)(85182001)(76116006)(54906003)(64756008)(66946007)(66556008)(91956017)(110136005)(41300700001)(66476007)(66446008)(478600001)(5660300002)(26005)(71200400001)(38070700005)(38100700002)(2616005)(6486002)(6506007)(122000001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akRJZGdFRmpSSnQrc090c2ExOUhBWWRWRGF2ZEJsb2YyZWN0dnZYVnZ1cmNT?=
 =?utf-8?B?ZkdBWnJPZS8zWERRYjRoUEhkWk9HYXhCTVF3Mnhya1pzTi9qVnBtV08zeXE0?=
 =?utf-8?B?WFozM2pCa3NsZTU4ZnBvYlRTMEV4cUlSc2JuUHJiUzFFQUN0Q0hvOU1Mdmto?=
 =?utf-8?B?Q0xyVGc0NXNvbDdyamF3b0N1RU8zK1NGdVcwdnFkZHJockdkWXF0a3I4SGZC?=
 =?utf-8?B?VjVQRHhISG01WDBtbTlUbW9Gd3c5VmNPdzQxL2xhczBtbEhlL3hqSEhsU09J?=
 =?utf-8?B?MDdJTGxDeU1VMnZ2YkZoZWp0dXdROHdERW1zQjdOZmxtN3JpRm9SRE5saUMz?=
 =?utf-8?B?RUhGaDBPQWM5c2Z2cEo0SGZHMUpONlJhQzZITkNZeVpNQmlRVnRWc3kyR0hG?=
 =?utf-8?B?THphMGhwSjRYMVhINFFwTStYZnM5dTBSY3pZM0U2ZlpnbjJlbmJTdlZVMnRP?=
 =?utf-8?B?b0JIcTZ6N2NJdlB1MFBoSi94TjYrSjIwSUdRR2tYTG5mNTE1K05MTGJBdjNF?=
 =?utf-8?B?MFExMkozQ08yZXlTNEJSTmhYanI5Y0lDOW1oY2l2VENwbjdHdkZqQVhNSmlS?=
 =?utf-8?B?eUtJdDh2Y0QzZ1V5U1RGQU45S24xZmxGNzFsam1ySVNvL3dnRGw3TDRuZXM2?=
 =?utf-8?B?eE8xN0x4OUU3WEpxSDlkMHBSeGVTak9UZlBFSXRnU1hqV0tucDJWNTdIbjc5?=
 =?utf-8?B?ZjF3WWtPTER6cFN4QkU0RkdRYnF6UElpaDdXQldveFZBbGhhRWN3N21oNnlh?=
 =?utf-8?B?clFJa3hJd0gzK0hvNUZxRitxemZPZHVvUXVtV29YUEhKWU9JNUVldEJ4SjZi?=
 =?utf-8?B?T3FnOFlwNWkvd3E3a3drMEU4c3FUZjN5b0lUZVVjMDlLQlE4STVPVzU3SFJ1?=
 =?utf-8?B?WG1Cb016TXJsYUxBclFKSkR2L3BXNFFucGdUR2NpcEc0emdLcnRZMFladUhM?=
 =?utf-8?B?bUhMYlpEelhzcGVpenA4WHowU045N2xOa253OWswcmJTNkJ0eFFaTHRIVEp0?=
 =?utf-8?B?VVAxVUtWRE5LS2F0NXp2NkdTTmpjd3N1Sjcyb1dlQ2IvWXhENGdscnNDWmNv?=
 =?utf-8?B?RnQ3dk5vY21BRDBKRHExenc3Q2tyR1Y4eWgydDZUS2xybjN0MmJiOU1iMC9t?=
 =?utf-8?B?bUZtN09iUERLQU9VV1VZTk91QmxxVHc5d2N1SHNXM2N4NEw4N2REcU5HOUhj?=
 =?utf-8?B?MFhTT1JYRlRKNGNoeXVYTDd3eUc0VmZENm0wTmI3OXZoK1o1MHBGTVFZR1lq?=
 =?utf-8?B?cVR0TDZSamlRa2M0TU0xUmt2Q3c3Z3VsMkVkYXRXWmRhQ0h4Yitja0tzN3Bs?=
 =?utf-8?B?ZWJOMU5QRkJWQlczNWh4RHNka1Q3c25CQ0pqMXppQS9LMzZlZmtqTVFmYzVk?=
 =?utf-8?B?R0tPWDJ6NGsySzlRRjVpdFdRR2F3ZlN2OUV3T2RnUnVFUEMzY3crWlUzbFlp?=
 =?utf-8?B?bkFvdmthcGwzZ2luemVqNlNNTlNRK0VwNXloU0NDSW9YYUxRdkJlYmR3VVBS?=
 =?utf-8?B?Ym1tVkJsR0FoejIrOWpIWHN5aWwzS2N0TVhuMWR2UC9qZEtxblcyY1F3RC9s?=
 =?utf-8?B?bVRjaVlDa2RhZS81R1E0Um0vK2hBNUFMeTh5WVkrSzRac05GRFlKSE5wa3pj?=
 =?utf-8?B?R1hEVTlFRGtwTHlJUThLVGt3T2ozeStKT2paVFRJeXB2Y2pFenB3bmp5b0x0?=
 =?utf-8?B?Z2VmNFowbVQvdmJoMXEra0R1SGlWbTJ1TTdWN20yV3RteWlzdkdlRmxwMTAv?=
 =?utf-8?B?NzVwbndVVWxxZU9tRlEyVStRbndBSS9MNStXemtjUklKN2F4bERkWUNyTDlx?=
 =?utf-8?B?b2ZLd3ZPQlVkc0pLcXNGaVdWR0VkQVZqTzc3QnNWTExjMHdzeWRFT3FiNmU0?=
 =?utf-8?B?R0NjcFVCNDl6MWtJQ3BvZXRnMjI3aUkrYUdZRUR2cnR0RFFoeXBROWFuNUhk?=
 =?utf-8?B?UXlUZWhHTmUwc2IwZDhHS3Fvc2RRbEtlK3ptNUc2K0Z1NHhrMkc1MWpOaW52?=
 =?utf-8?B?SFpMTjJ2MWpSZjJRNE5wM1FXanJORElhRUp0VnM2aTAvdUZ4MkJoZWxCUDZs?=
 =?utf-8?B?ZEpIOEtlaUFhNk5WeTEwcU5CWGFMNHdCVzJMZkFnSWR4UHAxcWVWZ2NZN1lu?=
 =?utf-8?B?NVJCVFlnQUxpVTRLcmNNUzFxb3d6WWFLeXVUeUtScEVFcUZYb1ZKOWc5WGEx?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2A7AE3037C9B34CAAAEA1EACAA17072@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de29d80e-e3a7-4c80-6622-08dbc3c19b45
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 03:34:10.4105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cllS8IWITpqR5heVNqb4Hio1iIwuNTf2L5W0y9ojwr20zxphMeinqlSbcfI/L0f9cSYUpXPOvKY28I4ybXnzr+aOZKvCaCbj1HGnsQlbn4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpbc25pcF0NCg0KPiA+ID4g
PiANCj4gPiA+ID4gKw0KPiA+ID4gPiArCWlmIChyZXQgPD0gMCkgew0KPiA+ID4gPiArCQlEUk1f
SU5GTygiRmFpbGVkIHRvIGZpbmQgY29tcCBpbiBkZHAgdGFibGUsIHJldA0KPiA+ID4gPiA9JWRc
biIsDQo+ID4gPiA+IHJldCk7DQo+ID4gPiA+ICsJCXJldCA9IDA7DQo+ID4gPiANCj4gPiA+IFdo
eSBhcmUgeW91IHJldHVybmluZyAwIGZvciBlcnJvciBoZXJlPyENCj4gPiANCj4gPiBCZWNhdXNl
IHRoaXMgZnVuY3Rpb24gcmV0dXJuIDAgbWVhbnMgbm90IGZvdW5kIGFueSB2YWxpZCBjcnRjIGJp
dHMuDQo+ID4gU2hvdWxkIEkgY2hhbmdlIHRoaXM/DQo+ID4gDQo+IA0KPiBZZXMsIHBsZWFzZSwg
cmV0dXJuIGEgcmVsZXZhbnQgZXJyb3IgY29kZSBpbnN0ZWFkLg0KPiANCg0KSSBmb3VuZCB0aGF0
IHRoZSByZXR1cm4gdHlwZSBvZiB0aGlzIGZ1bmN0aW9uIGlzICd1bnNpZ25lZCBpbnQnLCBJDQp0
aGluayByZXR1cm5pbmcgZXJyb3IgY29kZSBpbnN0ZWFkIHdpbGwgY2hhbmdlIHRoZSBvcmlnaW5h
bCBiZWhhdmlvciBvZg0KcmV0dXJuaW5nIDAgYXMgbm90IGZpbmRpbmcgYW55IHBvc3NpYmxlIGNy
dGMuDQoNCmUuZy4gZHJtX2VuY29kZXJfb2soKSBpbiBkcm1fZW5jb2Rlci5oIHdpbGwgY2hlY2s6
DQohIShlbmNvZGVyLT5wb3NzaWJsZV9jcnRjcyAmIGRybV9jcnRjX21hc2soY3J0YykpDQoNClRo
ZSBuZWdhdGl2ZSBlcnJvciBjb2RlIGNvbnZlcnQgdG8gdW5zaWduZWQgaW50IHdpbGwgYmUgYSBo
dWdlIG51bWJlcg0KYW5kIHRoYXQgbWF5IGNhdXNlIHRoZSB1bmV4cGVjdGVkIHJlc3VsdCBoZXJl
Lg0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCj4gVGhhbmtzLA0KPiBBbmdlbG8NCj4gDQo+
ID4gUmVnYXJkcywNCj4gPiBKYXNvbi1KSC5MaW4NCj4gPiANCj4gPiA+IA0KPiA+ID4gPiArCX0N
Cj4gPiA+ID4gICAgDQo+ID4gPiA+ICAgIAlyZXR1cm4gcmV0Ow0KPiA+ID4gPiAgICB9DQo+ID4g
PiANCj4gPiA+IFJlZ2FyZHMsDQo+ID4gPiBBbmdlbG8NCj4gPiA+IA0KPiANCj4gDQo+IA0K

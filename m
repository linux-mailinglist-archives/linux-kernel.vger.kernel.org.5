Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9117B4C70
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbjJBHPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbjJBHPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:15:02 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACDFBC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:14:56 -0700 (PDT)
X-UUID: 5f27062a60f311ee8051498923ad61e6-20231002
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+MjUayKYrJNeUVD2dyZKDs197noy7iOaAXi1PsvVCH8=;
        b=Sd5uyTMez6cJi9Qz3Ukw5Cjw3IVqs8cCd2qU8VeuwXy+AN56kDIqiZWK2dlTLXAdQOuXD8ktyau6kbQuS3NBpFlhqbLzZ9J/eMIggRh9bR+fEh95dXV3Mo4q6FVMGRHy0fYfA0rfkPhGOGmyFfEBfSxCviBuOie6fIIrcN1rrzg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:3c586322-bf88-4466-bca5-2b9c1bacc4bf,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:7dd49514-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 5f27062a60f311ee8051498923ad61e6-20231002
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1489365523; Mon, 02 Oct 2023 15:14:48 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 2 Oct 2023 15:14:47 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 2 Oct 2023 15:14:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNI+Q3E/iw70P4IcisVk2e9C2EEG9HaZGcMej2Sk/IsFHt5HJQQt2eFNe1NCrZkiu6vRYx95I6PsGg2GA5HDFjEkxz+R8Rb355YjaDawzvFA86mz6Z5p8Soophvnvo4Zi92lkPKOkM4sS3Byuc6/yrILGPvUerl8nl+Q4+FYxExRGO0uAPn/57A5nC5JIPu7sPligpKmnmCNbwW1XQuIX9TKOh4UW7QmgVQAftXT9rRZRTomrlFPrt6RKze1vzhGWCKm4/iX2s+EB3L8bQUUzFi6G85os0pWjPyz0jwaYeym4hLIO0NU5Lone4Ms72dPVQly0e1iGamCWCfiMLsDdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MjUayKYrJNeUVD2dyZKDs197noy7iOaAXi1PsvVCH8=;
 b=GOxow2GwFzp1cDf2vxHxRFz2HHUpPsi4kiwyniMJdoUYro4o1DnTcaGc7cdzNfP92+ndAWaXKt80bVZsa/mosLZnovgWOMVmxr+h6GaNrSptJkCt1Omo2H6VZ2tOL6ZmI6DYF+8psOtjYLMItmFFPHMmox9vMlKOUUSumVK0J14/FGLGtDHscCVdbS2RwJ0i5QfAB/6uTwTKCjsLx7DcVEJQM3/omy9YSeV/dMdXEIBp/vBa4eaQYbGz6PawexLZcNpvyt2zuj8IUnxVTiQVjmHtcrlQDcOwG9YoDEQLk7fKRcWZLo+0Q/1hpOMpC43T7SJCCZDDHbB/OQuBHdmeqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MjUayKYrJNeUVD2dyZKDs197noy7iOaAXi1PsvVCH8=;
 b=mwq5b8CcBhgn296YM7DERw64o+urGRB7XhIpReIfNGSuaISdvnnCXHIrE64p35OGhvkXdQaKmG2sfWkpjXWRR9TgW6iCILGwrvC3iC0DmGiJNSHgb2a3x7Ry7eNRF4ag2XsHljmjWqRoCVMUxUpHmSZalrGyOWvKZ6Anq2gNoEM=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by PSAPR03MB5733.apcprd03.prod.outlook.com (2603:1096:301:88::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Mon, 2 Oct
 2023 07:14:45 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ceab:94f0:6e70:b85e]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ceab:94f0:6e70:b85e%5]) with mapi id 15.20.6838.024; Mon, 2 Oct 2023
 07:14:44 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Thread-Index: AQHZ8VjJVfyYkTFEQ0W4IzryNLbmKrAwAogAgAYbAYA=
Date:   Mon, 2 Oct 2023 07:14:44 +0000
Message-ID: <1780d283425dea81e894fc75eeb893ab7a1faff2.camel@mediatek.com>
References: <20230927153833.23583-1-jason-jh.lin@mediatek.com>
         <20230927153833.23583-6-jason-jh.lin@mediatek.com>
         <891fe60a-cee9-29ab-3214-848b1161a0a7@collabora.com>
In-Reply-To: <891fe60a-cee9-29ab-3214-848b1161a0a7@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|PSAPR03MB5733:EE_
x-ms-office365-filtering-correlation-id: b6f33e12-2dd0-48da-6979-08dbc3174116
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: juWKnGsVG/T3pV2wVhRXqNLxwwDS3mQ0Z4mYMUWJmbA3Q83Cgf7lsPp7KCs5TeV9ICYDrkSIKU33mUbX6vlIul4yNEoBAfvgwHK8CX90kZOr5KrXx5uqgAXjiJ5MaW8aHb9Xxr2Zh9G9ZksPBqkD/FGtegkW0mE3QESkpNRsYf0z7nH7VvhgBjfoVEFty0QvpuTLydtriuBQ2UJSv4t+WogXNPh7TEcmB7vdzN53JLwWwo0VwhewmNFV+4zXDngAdnhRr5ulECkK5X0ADnAlvnP0GgWCfwPTR5P+Br2quZudJW27VdzmZeDIdfh/b9XVPBscsPnXC4OCQ6U2Id69uYQJsLYwqhFwLNgR2105n9M99Q/+YXq8+E0qAy8/QTB+fpdHcjM6bW4EtH3v1rnYSbTj6tAJ4aAbhjF/wHK3pexUOWb0XwB/g+/UsaHxSj/YmPBF4h+jCO4UcrqjenwDDWzOUAKH/BnyGRg3CPh4qERLPhIZZejGHE5ocZsR5cJasaTkPmcPaFSRhG/gEA64seHhZKRX1Pwqhyr3sTJTigOkD9twEdKnPTXIERje8mjT7EAiIwD12uocVCFzUz2Rga+41pBV5kXhU8hz1m+z0Onch0iTQu4NF27oDXWFRAJ1Q/p5EM/hmPlHOHMGhYmn6m0IXgaH7rgp/Fn/FiS7VLs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(8676002)(4326008)(8936002)(91956017)(66476007)(66556008)(66946007)(316002)(76116006)(66446008)(5660300002)(110136005)(41300700001)(64756008)(38100700002)(38070700005)(54906003)(122000001)(2906002)(83380400001)(71200400001)(6512007)(6506007)(26005)(2616005)(6486002)(478600001)(36756003)(85182001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHVDMHpBb1dYcmlBeGdtc1YrZnNpU3NqK3RGeS9USHBGalQxWVk2Q2ZuSU01?=
 =?utf-8?B?N2tBek5tWG5LNFN3eFpTWk9jYk03dVR1S1ljZ2NtU1MxRmJjQ3RxcDdQWmh3?=
 =?utf-8?B?OVFDMHRNYXFuYzlZdXU4RTRBdFJDZnRFY1VucE9waUJURkpyWERjNVdLcGZB?=
 =?utf-8?B?eHBaWG5wYnZCUTN5YjVmT3pFcjN1eE10QitxcGtYTmpmZWc0OStNb3A5R0Uz?=
 =?utf-8?B?Nm9jczcwZHhkYkNhNDFUeVhBY1JxTjFoam03VWg0aGVhQ0ZuMDBLdVVhNzkw?=
 =?utf-8?B?aWFZcTJ2cHM1dUhycE1EemhNb2xxRjlHekxKQUIvZ1d1NmhiL3pyMlRoVlQ3?=
 =?utf-8?B?c2hDeXQ0clNXNTNLaVlOemM5amRORjc1NnJ4bmZsKzlpMzFodjhmMTFQUzJy?=
 =?utf-8?B?c251aURSOE8yS05NbUM3amZ0aHF5V3kzYkliYVIrT3oxWi84TVBjb3JQcTZ3?=
 =?utf-8?B?MGluR1FKalFWbUhFUWhYK3hMaUJXM0l6cUxXbUI2V3I4VUVIcUJZSmppSjN4?=
 =?utf-8?B?QlpWWHhSNkhDdzR2WTlUZHRway9FR3laWkZ2YUg0Zm5ITTRWclFiZ2pDdmN6?=
 =?utf-8?B?V1BnaTZOcGdxcVlyRE1zTXdWWk1uRHU3Ylg4SXpsZ2dkRWNmbE9lODRpS1Mz?=
 =?utf-8?B?aEVkT25xNXF4UUN0OW9zejFlUk96cGtjbnVxT3FkUXZDNE9GTjliUlFWMXAz?=
 =?utf-8?B?UWYwL0tkcE9GRUJ4V2tKQTFnSWdSVFZsSFpwbEtBR1U2dzMzc0NCZ1lWTGl1?=
 =?utf-8?B?NlBPODZQaVV5RTJaUnh4eFcyb2tTb1NvSHJFYWNiM3E5Z2ltQ1h6dGZzd0J6?=
 =?utf-8?B?a2FOTlhYWVZ6cGZRVDZ1c3dGVGh3Nkt1VWU0M2tzVW9pbEFvRzV0bkN1Und5?=
 =?utf-8?B?U0o4Vk9kVDRCMlV2dks2VzFKY1lWWnBvdGo5d2oySGVZU3c5VjRWY2gwa2Nu?=
 =?utf-8?B?NDEwRWh4K2pWS3hvU1FyWTFnQ2lIUWpJV0lRakx2SkNxRWFIUGZDVXJORTZ0?=
 =?utf-8?B?ZVJ1WlZ0V1JZTXFmdldFZHdVcDN1a3cxaXI3Ulc1dmNqaU56TUlvN3I5bmo2?=
 =?utf-8?B?WTZYSzZHWG0rZHo3dURLL3ZkTHFYdkkxc3hsZWtNWmRjUDhQMzIwRjNQTGxU?=
 =?utf-8?B?QWNPUUFvbWNZTnl4eG9Tbm1zWUdSV1RxNzV6dnpsZ0p1Z0pUSW1DQW5wOERr?=
 =?utf-8?B?VUwzcGNySE5uazc1OFRuT0pRUDNxQ3NyMk9FekYvc2E3bEhlVVFPeXJId3dG?=
 =?utf-8?B?dnNmaXp5Q1RqZkNtUDd4ZklEdDZxVGQ0cjdpNjZSWTRKYVg4TEFDdDIvWWRn?=
 =?utf-8?B?cHRwZkcvMUdUZ1dWR3AzdUVVUVdYb3RGWHdmSkEwTHNMSU1mWG5tVjY1Q3Fv?=
 =?utf-8?B?alJUWElndHRkZGZNWm9LNzh4eHBSRW5aanhSSzBXM3ZyajlXajBheWl1T1pM?=
 =?utf-8?B?UU9BNEJBMWtHM29wVko1ZUs2Tm1VZG84NGNianY2a1VCWksvdjlhM2dxT1VL?=
 =?utf-8?B?VndpNmw4ZjhqWVI3TkFNY3d6TU42VGtZNy9uUENsNkV1RjhFbVBVaWVHdlZp?=
 =?utf-8?B?NG91ZE5VcHQ5M2taVEczMzZPdDRIL3FPZFliN3IzcVkwUzJHaGRpdktDQlNL?=
 =?utf-8?B?NXd4VHQyNTgwbXRFeEU4UjR3WDNiNVF1aU8vSjdqTjV3ZjRnTnpBeHByNzlh?=
 =?utf-8?B?MDJmT0szT2c3dHBkMThzd3JYTlBRQm1BWkFiRjBUYjJuZFRzTkliK3E4enJ6?=
 =?utf-8?B?NWNwTEQ1VVh2Zk04NHZ1K2hhRHZhYTRoQWNwaEREUFNyb2lXSndXeDAwVVhL?=
 =?utf-8?B?bzhCQnE2SVpheGREd0U0NWErQjJqSGhacGQxbWs4VUdacGVuZ0NlWXFta0xB?=
 =?utf-8?B?V3FpMDNOMGVoN2Y5bVpxeG1NKzRJS2ZLKzhKL1RFbTBkVDBjaWJ3VmZUVlc4?=
 =?utf-8?B?TmVXTkpXMEdHY0lqNDdENWZjYjdoWHljZUFTUHJRZGFETGl3QURVZ3BsT0F0?=
 =?utf-8?B?QTIva1lKY2VUalNWcUlPVmNZUDU4citQQStaeVpjcnIraUZPTHJaRWk4OFV3?=
 =?utf-8?B?ejZ6dklLSytWOHk2UGNSYjZlWVZJN1pKTW54VlAxamtBWE8zcWN5UENVUXpY?=
 =?utf-8?B?SmIyM1U2dnNKY3hWVDdSTGtyc0IrdjlzODZBNkJQNmVGK1FrS2hNNm9aclRj?=
 =?utf-8?B?TlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A8E382FD2FC414BAC7D44B698C1CA04@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f33e12-2dd0-48da-6979-08dbc3174116
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 07:14:44.6189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ai/h9y37rqQRxoozx39dHamOwSHK4y5/1P7ptLQLhE5qZTLxsCj9c4nzshCriMl46pbJxQQwwIslxYdduFxjCEQoOfOCkAxNDy+cr0jeBZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5733
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--28.414900-8.000000
X-TMASE-MatchedRID: Jm7Yxmmj9OmnykMun0J1wmjZ8q/Oc1nAYefZ7F9kLgsNcckEPxfz2OLB
        DcjMHcx7UmsNbSHn8eBWz2eiIuWGmrcH4/RZ7lQnQsSgfTKe5lWZ2scyRQcer1pbYq2f4jz+QEg
        JGt6fvEK5u9/qS1btcETPGwUzV65mb3gilrWi3GiQOktEo73GFG3eqxoVjgMECqIJhrrDy2/v0n
        IDaa/NCKKOBkrA9t5ktiRXYRqWr+tT4Q98GKrcb00jzafXv7tT/8CuA+b/YYQ+zqOf/RM2rrJnP
        h8w+R5oMe5AB1YHHx1tkLdMmnpDYsLk3xw1Sf9edXu122+iJtpRv3hO9k9DQmMABgDZbpbqOY4Q
        8GDy7ZRgJHW0v6veR/Fr8n9F4YmT3+ELr2W2A67g0Al6r0gNLJWr6iSXWtgPxN4K0DXKS1hOGro
        TCYZw1vVeIc3IIEyaic4WtNSsexwiRWw1gHaWSzvfsoCuAcP+h+w9Wz/xXDq/wPtA9baOj1/EJX
        TO9cFzsMG5fTpt9bGRk6XtYogiatLvsKjhs0ldRjjVhf+j/wpKdDgyPBo71yq2rl3dzGQ1A/3R8
        k/14e0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--28.414900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 97B185E0A6E5862F211FFF46197AE5138AA599BB966461E4402BDED4D37A10452000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpPbiBUaHUsIDIwMjMtMDkt
MjggYXQgMTI6MDAgKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJ
bCAyNy8wOS8yMyAxNzozOCwgSmFzb24tSkguTGluIGhhIHNjcml0dG86DQo+ID4gQWRkIGR5bmFt
aWMgc2VsZWN0IGF2YWlsYWJsZSBjb25uZWN0b3IgZmxvdyBpbg0KPiA+IG10a19kcm1fY3J0Y19j
cmVhdGUoKQ0KPiA+IGFuZCBtdGtfZHJtX2NydGNfYXRvbWljX2VuYWJsZSgpLg0KPiA+IA0KPiA+
IEluIG10a19kcm1fY3J0Y19jcmVhdGUoKSwgaWYgdGhlcmUgaXMgYSBjb25uZWN0b3Igcm91dGVz
IGFycmF5IGluDQo+ID4gZHJtDQo+ID4gZHJpdmVyIGRhdGEsIGFsbCBjb21wb25lbnRzIGRlZmlu
ZGVkIGluIHRoZSBjb25uZWN0b3Igcm91dGVzIGFycmF5DQo+ID4gd2lsbA0KPiA+IGJlIGNoZWNr
ZWQgYW5kIHRoZWlyIGVuY29kZXJfaW5kZXggd2lsbCBiZSBzZXQuDQo+ID4gDQo+ID4gSW4gbXRr
X2RybV9jcnRjX2F0b21pY19lbmFibGUoKSwgY3J0YyB3aWxsIGNoZWNrIGl0cyBlbmNvZGVyX2lu
ZGV4DQo+ID4gdG8NCj4gPiBpZGVudGlmeSB3aGljaCBjb21wb25ldCBpbiB0aGUgY29ubmVjdG9y
IHJvdXRlcyBhcnJheSBzaG91bGQNCj4gPiBhcHBlbmQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogTmFuY3kgTGluIDxuYW5jeS5saW5AbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IE5hdGhhbiBMdSA8bmF0aGFuLmx1QG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBK
YXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gVGVzdGVkLWJ5OiBG
ZWkgU2hhbyA8ZnNoYW9AY2hyb21pdW0ub3JnPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jICAgICB8IDc4DQo+ID4gKysrKysrKysrKysrKysr
KysrKystDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmggICAg
IHwgIDUgKy0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21w
LmMgfCAyNyArKysrKystDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9k
cnYuYyAgICAgIHwgMTMgKysrLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fZHJ2LmggICAgICB8ICA3ICsrDQo+ID4gICA1IGZpbGVzIGNoYW5nZWQsIDEyMyBpbnNlcnRp
b25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2NydGMuYw0KPiA+IGluZGV4IGI2ZmE0YWQyZjk0ZC4uOGViNGQyNjQ2YTc2
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiA+
IEBAIC02Myw2ICs2Myw4IEBAIHN0cnVjdCBtdGtfZHJtX2NydGMgew0KPiA+ICAgCXN0cnVjdCBt
dGtfbXV0ZXgJCSptdXRleDsNCj4gPiAgIAl1bnNpZ25lZCBpbnQJCQlkZHBfY29tcF9ucjsNCj4g
PiAgIAlzdHJ1Y3QgbXRrX2RkcF9jb21wCQkqKmRkcF9jb21wOw0KPiA+ICsJdW5zaWduZWQgaW50
CQkJbnVtX2Nvbm5fcm91dGVzOw0KPiA+ICsJY29uc3Qgc3RydWN0IG10a19kcm1fcm91dGUJKmNv
bm5fcm91dGVzOw0KPiA+ICAgDQo+ID4gICAJLyogbG9jayBmb3IgZGlzcGxheSBoYXJkd2FyZSBh
Y2Nlc3MgKi8NCj4gPiAgIAlzdHJ1Y3QgbXV0ZXgJCQlod19sb2NrOw0KPiA+IEBAIC02NDcsNiAr
NjQ5LDQ1IEBAIHN0YXRpYyB2b2lkIG10a19kcm1fY3J0Y19kaXNhYmxlX3ZibGFuayhzdHJ1Y3QN
Cj4gPiBkcm1fY3J0YyAqY3J0YykNCj4gPiAgIAltdGtfZGRwX2NvbXBfZGlzYWJsZV92Ymxhbmso
Y29tcCk7DQo+ID4gICB9DQo+ID4gICANCj4gPiArc3RhdGljIHZvaWQgbXRrX2RybV9jcnRjX3Vw
ZGF0ZV9vdXRwdXQoc3RydWN0IGRybV9jcnRjICpjcnRjLA0KPiA+ICsJCQkJICAgICAgIHN0cnVj
dCBkcm1fYXRvbWljX3N0YXRlICpzdGF0ZSkNCj4gPiArew0KPiA+ICsJaW50IGNydGNfaW5kZXgg
PSBkcm1fY3J0Y19pbmRleChjcnRjKTsNCj4gPiArCWludCBpOw0KPiA+ICsJc3RydWN0IGRldmlj
ZSAqZGV2Ow0KPiA+ICsJc3RydWN0IGRybV9jcnRjX3N0YXRlICpjcnRjX3N0YXRlID0gc3RhdGUt
DQo+ID4gPmNydGNzW2NydGNfaW5kZXhdLm5ld19zdGF0ZTsNCj4gPiArCXN0cnVjdCBtdGtfZHJt
X2NydGMgKm10a19jcnRjID0gdG9fbXRrX2NydGMoY3J0Yyk7DQo+ID4gKwlzdHJ1Y3QgbXRrX2Ry
bV9wcml2YXRlICpwcml2ID0gY3J0Yy0+ZGV2LT5kZXZfcHJpdmF0ZTsNCj4gPiArCXVuc2lnbmVk
IGludCBjb21wX2lkOw0KPiANCj4gWW91J3JlIG5vdCB1c2luZyBjb21wX2lkIGdsb2JhbGx5IGlu
IHRoaXMgZnVuY3Rpb24uLi4uDQoNCk9LLCBJJ2xsIG1vdmUgaXQgdG8gdGhlIGZvciBsb29wIGJl
bG93Lg0KDQo+IA0KPiA+ICsJdW5zaWduZWQgaW50IGVuY29kZXJfbWFzayA9IGNydGNfc3RhdGUt
PmVuY29kZXJfbWFzazsNCj4gPiArDQo+ID4gKwlpZiAoIWNydGNfc3RhdGUtPmNvbm5lY3RvcnNf
Y2hhbmdlZCkNCj4gPiArCQlyZXR1cm47DQo+ID4gKw0KPiA+ICsJaWYgKCFtdGtfY3J0Yy0+bnVt
X2Nvbm5fcm91dGVzKQ0KPiA+ICsJCXJldHVybjsNCj4gPiArDQo+ID4gKwlwcml2ID0gcHJpdi0+
YWxsX2RybV9wcml2YXRlW2NydGNfaW5kZXhdOw0KPiANCj4gVGhpcyBpcyBhIGJpdCBjb25mdXNp
bmcuIFlvdSdyZSByZWFzc2lnbmluZyBwcml2OiBwbGVhc2UgYXZvaWQgdGhhdC4NCj4gSSB3b3Vs
ZCBwcmVmZXIgZGlyZWN0bHkgc2VlaW5nIHRoZSBmaW5hbCBhc3NpZ25tZW50LCBvciBvdGhlcndp
c2UgdHdvDQo+IHBvaW50ZXJzLg0KPiANCj4gCXN0cnVjdCBtdGtfZHJtX3ByaXZhdGUgKnByaXY7
DQo+IA0KPiAJaWYgLi4uLg0KPiAJLi4uLi4uLi4uLi4NCj4gDQo+IAlwcml2ID0gY3J0Yy0+ZGV2
LT5kZXZfcHJpdmF0ZS0+YWxsX2RybV9wcml2YXRlW2NydGNfaW5kZXhdOw0KPiANCg0KT0ssIGJl
Y2F1c2UgdGhlIHR5cGUgb2YgZGV2X3ByaXZhdGUgaXMgdm9pZCouIEknbGwgY2hhbmdlIHRoZQ0K
YXNzaWdubWVudCB0bzoNCg0KcHJpdiA9ICgoc3RydWN0IG10a19kcm1fcHJpdmF0ZSAqKWNydGMt
PmRldi0+ZGV2X3ByaXZhdGUpLQ0KPmFsbF9kcm1fcHJpdmF0ZVtjcnRjX2luZGV4XTsNCg0KPiA+
ICsJZGV2ID0gcHJpdi0+ZGV2Ow0KPiA+ICsNCj4gPiArCWRldl9kYmcoZGV2LCAiY29ubmVjdG9y
IGNoYW5nZTolZCwgZW5jb2RlciBtYXNrOjB4JXggZm9yDQo+ID4gY3J0YzolZFxuIiwNCj4gPiAr
CQljcnRjX3N0YXRlLT5jb25uZWN0b3JzX2NoYW5nZWQsIGVuY29kZXJfbWFzaywNCj4gPiBjcnRj
X2luZGV4KTsNCj4gPiArDQo+ID4gKwlmb3IgKGkgPSAwOyBpIDwgbXRrX2NydGMtPm51bV9jb25u
X3JvdXRlczsgaSsrKSB7DQo+ID4gKwkJc3RydWN0IG10a19kZHBfY29tcCAqY29tcDsNCj4gDQo+
IC4uLnNvIHlvdSBjYW4gbW92ZSBpdCBoZXJlLi4uDQoNCk9LLCBJJ2xsIG1vdmUgaXQgaGVyZS4N
Cg0KPiAJCXVuc2lnbmVkIGludCBjb21wX2lkID0gbXRrX2NydGMtDQo+ID5jb25uX3JvdXRlc1tp
XS5yb3V0ZV9kZHA7DQo+IAkJc3RydWN0IG10a19kZHBfY29tcCAqY29tcCA9ICZwcml2LT5kZHBf
Y29tcFtjb21wX2lkXTsNCj4gDQo+ID4gKw0KPiA+ICsJCWNvbXBfaWQgPSBtdGtfY3J0Yy0+Y29u
bl9yb3V0ZXNbaV0ucm91dGVfZGRwOw0KPiA+ICsJCWNvbXAgPSAmcHJpdi0+ZGRwX2NvbXBbY29t
cF9pZF07DQo+ID4gKwkJaWYgKGNvbXAtPmVuY29kZXJfaW5kZXggPj0gMCAmJg0KPiA+ICsJCSAg
ICBlbmNvZGVyX21hc2sgJiBCSVQoY29tcC0+ZW5jb2Rlcl9pbmRleCkpIHsNCj4gDQo+IEZvciBy
ZWFkYWJpbGl0eSwgSSB3b3VsZCBwcmVmZXIgdG8gc2VlDQo+IA0KPiAJCWlmIChjb21wLT5lbmNv
ZGVyX2luZGV4ID49IDAgJiYNCj4gCQkgICAgKGVuY29kZXJfbWFzayAmIEJJVChjb21wLT5lbmNv
ZGVyX2luZGV4KSkpIHsNCj4gDQo+IC4uLmJ1dCBJIGRvbid0IGhhdmUgc3Ryb25nIG9waW5pb25z
IG9uIHRoYXQuDQo+IA0KDQpPSywgSSdsbCBtb2RpZnkgaXQuDQoNCj4gPiArCQkJbXRrX2NydGMt
PmRkcF9jb21wW210a19jcnRjLT5kZHBfY29tcF9uciAtIDFdID0NCj4gPiBjb21wOw0KPiA+ICsJ
CQlkZXZfZGJnKGRldiwgIkFkZCBjb21wX2lkOiAlZCBhdCBwYXRoIGluZGV4DQo+ID4gJWRcbiIs
DQo+ID4gKwkJCQljb21wLT5pZCwgbXRrX2NydGMtPmRkcF9jb21wX25yIC0gMSk7DQo+ID4gKwkJ
CWJyZWFrOw0KPiA+ICsJCX0NCj4gPiArCX0NCj4gPiArfQ0KPiA+ICsNCj4gPiAgIGludCBtdGtf
ZHJtX2NydGNfcGxhbmVfY2hlY2soc3RydWN0IGRybV9jcnRjICpjcnRjLCBzdHJ1Y3QNCj4gPiBk
cm1fcGxhbmUgKnBsYW5lLA0KPiA+ICAgCQkJICAgICBzdHJ1Y3QgbXRrX3BsYW5lX3N0YXRlICpz
dGF0ZSkNCj4gPiAgIHsNCj4gPiBAQCAtNjc5LDYgKzcyMCw4IEBAIHN0YXRpYyB2b2lkIG10a19k
cm1fY3J0Y19hdG9taWNfZW5hYmxlKHN0cnVjdA0KPiA+IGRybV9jcnRjICpjcnRjLA0KPiA+ICAg
DQo+ID4gICAJRFJNX0RFQlVHX0RSSVZFUigiJXMgJWRcbiIsIF9fZnVuY19fLCBjcnRjLT5iYXNl
LmlkKTsNCj4gPiAgIA0KPiA+ICsJbXRrX2RybV9jcnRjX3VwZGF0ZV9vdXRwdXQoY3J0Yywgc3Rh
dGUpOw0KPiA+ICsNCj4gDQo+IFdoYXQncyB0aGUgcG9pbnQgb2YgdXBkYXRpbmcgdGhlIG91dHB1
dCBiZWZvcmUNCj4gcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldCgpPw0KPiBJZiBQTSByZXN1bWUg
ZmFpbHMgd2UncmUgbm90IGVuYWJsaW5nIHRoZSBDUlRDIHNvIHRoZSB1cGRhdGUgaXMNCj4gYWN0
dWFsbHkgdXNlbGVzcy4NCj4gDQo+IFBsZWFzZSBtb3ZlIHRoaXMgYWZ0ZXIgUE0gcmVzdW1lOiB0
aGF0IHdpbGwgYWxzbyBwb3NzaWJseSBjb21lIGhhbmR5DQo+IGluIHRoZSBmdXR1cmUuDQoNCk9L
LCBJJ2xsIG1vdmUgdGhpcyBhZnRlciBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KCkuDQoNCj4g
DQo+IA0KPiA+ICAgCXJldCA9IHBtX3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQoY29tcC0+ZGV2KTsN
Cj4gPiAgIAlpZiAocmV0IDwgMCkgew0KPiA+ICAgCQlEUk1fREVWX0VSUk9SKGNvbXAtPmRldiwg
IkZhaWxlZCB0byBlbmFibGUgcG93ZXINCj4gPiBkb21haW46ICVkXG4iLCByZXQpOw0KPiA+IEBA
IC04ODQsNyArOTI3LDggQEAgc3RydWN0IGRldmljZSAqbXRrX2RybV9jcnRjX2RtYV9kZXZfZ2V0
KHN0cnVjdA0KPiA+IGRybV9jcnRjICpjcnRjKQ0KPiA+ICAgDQo+ID4gICBpbnQgbXRrX2RybV9j
cnRjX2NyZWF0ZShzdHJ1Y3QgZHJtX2RldmljZSAqZHJtX2RldiwNCj4gPiAgIAkJCWNvbnN0IHVu
c2lnbmVkIGludCAqcGF0aCwgdW5zaWduZWQgaW50DQo+ID4gcGF0aF9sZW4sDQo+ID4gLQkJCWlu
dCBwcml2X2RhdGFfaW5kZXgpDQo+ID4gKwkJCWludCBwcml2X2RhdGFfaW5kZXgsIGNvbnN0IHN0
cnVjdCBtdGtfZHJtX3JvdXRlDQo+ID4gKmNvbm5fcm91dGVzLA0KPiA+ICsJCQl1bnNpZ25lZCBp
bnQgbnVtX2Nvbm5fcm91dGVzKQ0KPiA+ICAgew0KPiA+ICAgCXN0cnVjdCBtdGtfZHJtX3ByaXZh
dGUgKnByaXYgPSBkcm1fZGV2LT5kZXZfcHJpdmF0ZTsNCj4gPiAgIAlzdHJ1Y3QgZGV2aWNlICpk
ZXYgPSBkcm1fZGV2LT5kZXY7DQo+ID4gQEAgLTkzNSw3ICs5NzksOCBAQCBpbnQgbXRrX2RybV9j
cnRjX2NyZWF0ZShzdHJ1Y3QgZHJtX2RldmljZQ0KPiA+ICpkcm1fZGV2LA0KPiA+ICAgDQo+ID4g
ICAJbXRrX2NydGMtPm1tc3lzX2RldiA9IHByaXYtPm1tc3lzX2RldjsNCj4gPiAgIAltdGtfY3J0
Yy0+ZGRwX2NvbXBfbnIgPSBwYXRoX2xlbjsNCj4gPiAtCW10a19jcnRjLT5kZHBfY29tcCA9IGRl
dm1fa21hbGxvY19hcnJheShkZXYsIG10a19jcnRjLQ0KPiA+ID5kZHBfY29tcF9uciwNCj4gPiAr
CW10a19jcnRjLT5kZHBfY29tcCA9IGRldm1fa21hbGxvY19hcnJheShkZXYsDQo+ID4gKwkJCQkJ
CW10a19jcnRjLT5kZHBfY29tcF9uciArDQo+ID4gKGNvbm5fcm91dGVzID8gMSA6IDApLA0KPiA+
ICAgCQkJCQkJc2l6ZW9mKCptdGtfY3J0Yy0NCj4gPiA+ZGRwX2NvbXApLA0KPiA+ICAgCQkJCQkJ
R0ZQX0tFUk5FTCk7DQo+ID4gICAJaWYgKCFtdGtfY3J0Yy0+ZGRwX2NvbXApDQo+ID4gQEAgLTEw
MzgsNSArMTA4MywzNCBAQCBpbnQgbXRrX2RybV9jcnRjX2NyZWF0ZShzdHJ1Y3QgZHJtX2Rldmlj
ZQ0KPiA+ICpkcm1fZGV2LA0KPiA+ICAgCQlpbml0X3dhaXRxdWV1ZV9oZWFkKCZtdGtfY3J0Yy0+
Y2JfYmxvY2tpbmdfcXVldWUpOw0KPiA+ICAgCX0NCj4gPiAgICNlbmRpZg0KPiA+ICsNCj4gPiAr
CWlmIChjb25uX3JvdXRlcykgew0KPiA+ICsJCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZTsNCj4g
PiArCQlzdHJ1Y3QgbXRrX2RkcF9jb21wICpjb21wOw0KPiA+ICsJCXVuc2lnbmVkIGludCBjb21w
X2lkOw0KPiA+ICsNCj4gPiArCQlmb3IgKGkgPSAwOyBpIDwgbnVtX2Nvbm5fcm91dGVzOyBpKysp
IHsNCj4gDQo+IFNhbWUgaGVyZSwgeW91J3JlIGxvY2FsbHkgdXNpbmcgY29tcF9pZCwgbm9kZSBh
bmQgY29tcCAqb25seSogaW4gdGhlDQo+IGZvciBsb29wLi4uLg0KPiANCg0KT0sgSSdsbCBtb3Zl
IGl0IGhlcmUuDQoNCj4gCQkJdW5zaWduZWQgaW50IGNvbXBfaWQgPQ0KPiBjb25uX3JvdXRlc1tp
XS5yb3V0ZV9kZHA7DQo+IAkJCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSA9IHByaXYtDQo+ID5j
b21wX25vZGVbY29tcF9pZF07DQo+IAkJCXN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAgPSAmcHJp
di0NCj4gPmRkcF9jb21wW2NvbXBfaWRdOw0KPiANCj4gPiArCQkJY29tcF9pZCA9IGNvbm5fcm91
dGVzW2ldLnJvdXRlX2RkcDsNCj4gPiArCQkJbm9kZSA9IHByaXYtPmNvbXBfbm9kZVtjb21wX2lk
XTsNCj4gPiArCQkJY29tcCA9ICZwcml2LT5kZHBfY29tcFtjb21wX2lkXTsNCj4gPiArDQo+ID4g
KwkJCWlmICghY29tcC0+ZGV2KSB7DQo+ID4gKwkJCQlkZXZfZGJnKGRldiwgImNvbXBfaWQ6JWQs
IENvbXBvbmVudA0KPiA+ICVwT0Ygbm90IGluaXRpYWxpemVkXG4iLA0KPiA+ICsJCQkJCWNvbXBf
aWQsIG5vZGUpOw0KPiA+ICsJCQkJLyogbWFyayBlbmNvZGVyX2luZGV4IHRvIC0xLCBpZiByb3V0
ZQ0KPiA+IGNvbXAgZGV2aWNlIGlzIG5vdCBlbmFibGVkICovDQo+ID4gKwkJCQljb21wLT5lbmNv
ZGVyX2luZGV4ID0gLTE7DQo+ID4gKwkJCQljb250aW51ZTsNCj4gPiArCQkJfQ0KPiA+ICsNCj4g
PiArCQkJbXRrX2RkcF9jb21wX2VuY29kZXJfaW5kZXhfc2V0KCZwcml2LQ0KPiA+ID5kZHBfY29t
cFtjb21wX2lkXSk7DQo+ID4gKwkJfQ0KPiA+ICsNCj4gPiArCQltdGtfY3J0Yy0+bnVtX2Nvbm5f
cm91dGVzID0gbnVtX2Nvbm5fcm91dGVzOw0KPiA+ICsJCW10a19jcnRjLT5jb25uX3JvdXRlcyA9
IGNvbm5fcm91dGVzOw0KPiA+ICsNCj4gPiArCQkvKiBpbmNyZWFzZSBkZHBfY29tcF9uciBhdCB0
aGUgZW5kIG9mDQo+ID4gbXRrX2RybV9jcnRjX2NyZWF0ZSAqLw0KPiA+ICsJCW10a19jcnRjLT5k
ZHBfY29tcF9ucisrOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAgIAlyZXR1cm4gMDsNCj4gPiAgIH0N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5o
DQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmgNCj4gPiBpbmRl
eCAzZTkwNDY5OTNkMDkuLjNjMjI0NTk1ZmE3MSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmgNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RybV9jcnRjLmgNCj4gPiBAQCAtOCw2ICs4LDcgQEANCj4gPiAgIA0KPiA+
ICAgI2luY2x1ZGUgPGRybS9kcm1fY3J0Yy5oPg0KPiA+ICAgI2luY2x1ZGUgIm10a19kcm1fZGRw
X2NvbXAuaCINCj4gPiArI2luY2x1ZGUgIm10a19kcm1fZHJ2LmgiDQo+ID4gICAjaW5jbHVkZSAi
bXRrX2RybV9wbGFuZS5oIg0KPiA+ICAgDQo+ID4gICAjZGVmaW5lIE1US19MVVRfU0laRQk1MTIN
Cj4gPiBAQCAtMTgsNyArMTksOSBAQCB2b2lkIG10a19kcm1fY3J0Y19jb21taXQoc3RydWN0IGRy
bV9jcnRjICpjcnRjKTsNCj4gPiAgIGludCBtdGtfZHJtX2NydGNfY3JlYXRlKHN0cnVjdCBkcm1f
ZGV2aWNlICpkcm1fZGV2LA0KPiA+ICAgCQkJY29uc3QgdW5zaWduZWQgaW50ICpwYXRoLA0KPiA+
ICAgCQkJdW5zaWduZWQgaW50IHBhdGhfbGVuLA0KPiA+IC0JCQlpbnQgcHJpdl9kYXRhX2luZGV4
KTsNCj4gPiArCQkJaW50IHByaXZfZGF0YV9pbmRleCwNCj4gPiArCQkJY29uc3Qgc3RydWN0IG10
a19kcm1fcm91dGUgKmNvbm5fcm91dGVzLA0KPiA+ICsJCQl1bnNpZ25lZCBpbnQgbnVtX2Nvbm5f
cm91dGVzKTsNCj4gPiAgIGludCBtdGtfZHJtX2NydGNfcGxhbmVfY2hlY2soc3RydWN0IGRybV9j
cnRjICpjcnRjLCBzdHJ1Y3QNCj4gPiBkcm1fcGxhbmUgKnBsYW5lLA0KPiA+ICAgCQkJICAgICBz
dHJ1Y3QgbXRrX3BsYW5lX3N0YXRlICpzdGF0ZSk7DQo+ID4gICB2b2lkIG10a19kcm1fY3J0Y19h
c3luY191cGRhdGUoc3RydWN0IGRybV9jcnRjICpjcnRjLCBzdHJ1Y3QNCj4gPiBkcm1fcGxhbmUg
KnBsYW5lLA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Ry
bV9kZHBfY29tcC5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBf
Y29tcC5jDQo+ID4gaW5kZXggNzcxZjRlMTczMzUzLi40ZGRiNWU1NjExMTYgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gPiBAQCAt
NTA3LDYgKzUwNywyMyBAQCBzdGF0aWMgYm9vbCBtdGtfZHJtX2ZpbmRfY29tcF9pbl9kZHAoc3Ry
dWN0DQo+ID4gZGV2aWNlICpkZXYsDQo+ID4gICAJcmV0dXJuIGZhbHNlOw0KPiA+ICAgfQ0KPiA+
ICAgDQo+ID4gK3N0YXRpYyBpbnQgbXRrX2RybV9maW5kX2NvbXBfaW5fZGRwX2Nvbm5fcGF0aChz
dHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gKwkJCQkJICAgICAgY29uc3Qgc3RydWN0DQo+ID4gbXRr
X2RybV9yb3V0ZSAqcm91dGVzLA0KPiA+ICsJCQkJCSAgICAgIHVuc2lnbmVkIGludCBudW1fcm91
dGVzLA0KPiA+ICsJCQkJCSAgICAgIHN0cnVjdCBtdGtfZGRwX2NvbXANCj4gPiAqZGRwX2NvbXAp
DQo+ID4gK3sNCj4gPiArCXVuc2lnbmVkIGludCBpOw0KPiA+ICsNCj4gPiArCWlmICghcm91dGVz
KQ0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsNCj4gPiArCWZvciAoaSA9IDA7IGkgPCBu
dW1fcm91dGVzOyBpKyspDQo+ID4gKwkJaWYgKGRldiA9PSBkZHBfY29tcFtyb3V0ZXNbaV0ucm91
dGVfZGRwXS5kZXYpDQo+ID4gKwkJCXJldHVybiBCSVQocm91dGVzW2ldLmNydGNfaWQpOw0KPiA+
ICsNCj4gPiArCXJldHVybiAtRU5PREVWOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICAgaW50IG10a19k
ZHBfY29tcF9nZXRfaWQoc3RydWN0IGRldmljZV9ub2RlICpub2RlLA0KPiA+ICAgCQkJZW51bSBt
dGtfZGRwX2NvbXBfdHlwZSBjb21wX3R5cGUpDQo+ID4gICB7DQo+ID4gQEAgLTUzOCw3ICs1NTUs
MTUgQEAgdW5zaWduZWQgaW50DQo+ID4gbXRrX2RybV9maW5kX3Bvc3NpYmxlX2NydGNfYnlfY29t
cChzdHJ1Y3QgZHJtX2RldmljZSAqZHJtLA0KPiA+ICAgCQkJCQkgIHByaXZhdGUtPmRhdGEtPnRo
aXJkX2xlbiwNCj4gPiBwcml2YXRlLT5kZHBfY29tcCkpDQo+ID4gICAJCXJldCA9IEJJVCgyKTsN
Cj4gPiAgIAllbHNlDQo+ID4gLQkJRFJNX0lORk8oIkZhaWxlZCB0byBmaW5kIGNvbXAgaW4gZGRw
IHRhYmxlXG4iKTsNCj4gPiArCQlyZXQgPSBtdGtfZHJtX2ZpbmRfY29tcF9pbl9kZHBfY29ubl9w
YXRoKGRldiwNCj4gPiArCQkJCQkJCSBwcml2YXRlLT5kYXRhLQ0KPiA+ID5jb25uX3JvdXRlcywN
Cj4gPiArCQkJCQkJCSBwcml2YXRlLT5kYXRhLQ0KPiA+ID5udW1fY29ubl9yb3V0ZXMsDQo+ID4g
KwkJCQkJCQkgcHJpdmF0ZS0NCj4gPiA+ZGRwX2NvbXApOw0KPiA+ICsNCj4gPiArCWlmIChyZXQg
PD0gMCkgew0KPiA+ICsJCURSTV9JTkZPKCJGYWlsZWQgdG8gZmluZCBjb21wIGluIGRkcCB0YWJs
ZSwgcmV0ID0lZFxuIiwNCj4gPiByZXQpOw0KPiA+ICsJCXJldCA9IDA7DQo+IA0KPiBXaHkgYXJl
IHlvdSByZXR1cm5pbmcgMCBmb3IgZXJyb3IgaGVyZT8hDQoNCkJlY2F1c2UgdGhpcyBmdW5jdGlv
biByZXR1cm4gMCBtZWFucyBub3QgZm91bmQgYW55IHZhbGlkIGNydGMgYml0cy4NClNob3VsZCBJ
IGNoYW5nZSB0aGlzPw0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCj4gDQo+ID4gKwl9DQo+
ID4gICANCj4gPiAgIAlyZXR1cm4gcmV0Ow0KPiA+ICAgfQ0KPiANCj4gUmVnYXJkcywNCj4gQW5n
ZWxvDQo+IA0K

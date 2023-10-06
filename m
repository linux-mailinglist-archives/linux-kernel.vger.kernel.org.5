Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359027BB395
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 10:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjJFIyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 04:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjJFIyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:54:41 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAA795;
        Fri,  6 Oct 2023 01:54:34 -0700 (PDT)
X-UUID: f43913d6642511ee8051498923ad61e6-20231006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0EQLu3SdSfB6/wpxh9iF9iZpFp5/2eY8xNl0vydRYuU=;
        b=Fmu3NSH5L84/Vb+F9gGgvrDA5jFnb3iC1lIuvA/vaTDju2ZM4OW4ObmzhEbOeZ0tJRuvu5Ywlk0bbXsicAo7BE4RECn5HoM9y3/vguFT35WwL9Jxi8hmErW06JfUt2UpyPxDiQuWUb09LfQ0yePBx9B2ETdVRXmnpNQPWil9uuA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:9a461177-df61-4491-bbc8-1ef0b8b25759,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:fd51d8c3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: f43913d6642511ee8051498923ad61e6-20231006
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 412103661; Fri, 06 Oct 2023 16:54:26 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 6 Oct 2023 16:54:25 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 6 Oct 2023 16:54:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbOPewh5lB4z1EbsyyWYmruMkNwKwe9BGDxQOQtiXjHPdjyfBlUwk2jEOi2qJEkeZ7hVQYg/uhT+bnXtNQpzhLzIpyFF0F6ACXY/2Bg/YFl3johIvybQMMQv9s8kkJnDet/lCSZp/iJMCibOA6NT0q0jWQtSI8Q4MWreIEvrbsP50kzNARo2EAQpwSzx8KkKcpPEbn0rClRbQEGLbopmx4jcdIft+ejbb7r5fbIXsmAbWmXMVmytO4HOnxBLop19w0ueCwySGcSdKtHY/YxId1FL/Qd1tPUNpdOzTIElo1EOx6mzI27zHEvfaNFd2tasR2j0q1NyJhBYkaZZHwYLng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EQLu3SdSfB6/wpxh9iF9iZpFp5/2eY8xNl0vydRYuU=;
 b=IOKCNdnJqztHpodiqg+a8KIM8RszMrqWjTOPdw9yIMQA9NnVDTsJaqud8DgH3sLXAxWQyTv1gvrQWL1+OqBjfz38+7M+ddqeIwQUg4Q/bF9+pt9Q449qnyxLjlC4SzJXWdQUtZMamOXkEx3eiigihgqbvuAQbe6hqISjZmqfTiHJq6JbNf0kFiPpxswCFDsxBAgsDg87cP9toFIpbkg26k7afG90i4TYHTmolYqGyKm2lhp7GCMFQ4Wp4/tNa7Q6NzLXtg3XqjtKYhZARJ9hz+bIGdS5kx52S8OqTlexE/PmLzJqN4NNg/cApAcezz1Ly13iPPOpcTqBXzbioL9VOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EQLu3SdSfB6/wpxh9iF9iZpFp5/2eY8xNl0vydRYuU=;
 b=KDZ4S0BPuIOz26tqaomMfkIc43lDfe2kbR9f+/C7ARm3pCRWQ6b1OoEFPXondv8GXHECXnpu7dx7GGAEWT9of2dAmWNYrpa1gZ7F+WuEAHUG//W/W4g6LgjAXy3D5FwaY3JLFuDCpsBi9cxfLgP1Ov9qOfpFs5KY71VGEc+CxyI=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB7787.apcprd03.prod.outlook.com (2603:1096:990:d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 08:54:23 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%7]) with mapi id 15.20.6792.026; Fri, 6 Oct 2023
 08:54:23 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
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
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 18/23] drm/mediatek: Add Padding to OVL adaptor
Thread-Topic: [PATCH v7 18/23] drm/mediatek: Add Padding to OVL adaptor
Thread-Index: AQHZ+CgsElvTDta5OEWE08GyyZjCvLA8dRUA
Date:   Fri, 6 Oct 2023 08:54:23 +0000
Message-ID: <7ddd22081cfa7dabb512dde66519c3ea8908c37b.camel@mediatek.com>
References: <20231006073831.10402-1-shawn.sung@mediatek.com>
         <20231006073831.10402-19-shawn.sung@mediatek.com>
In-Reply-To: <20231006073831.10402-19-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB7787:EE_
x-ms-office365-filtering-correlation-id: 5af78345-c263-4053-e8ad-08dbc649d654
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7pJ0fQRWXNPYP2P4rXZB3P1DIHGHsuE11SQvAO7RFYe7au7iTAlMpmxFGMVAQn8J/3dpph0b+vg08N21ANaGVvtzrIubYqsptg2eNKF/EBBQY2XCk5nHJSwfyD+sh75FLzUcDQH2OxFZzOTYR5ws8u9MgD2THB3eWnalOjvgSZNTuZ4QPLDtaItcrYFTpjkRAjDCobDFYMFSihglyaemvh8T/EQrhripa1WXYQ13NkK+xVKTXdow5GQGr17UxtRTqHokeOJiGwCnN+lNTf5W64NbzTUNv7autSpBrcQau2HzqaMq57KpuFYicUff9MFJDJhMe95vUebLvWTi6OsjKdfxseybLhzEPkzSA5TIfXSagB6QvnabcmK7MDl/TBA/tKU20Aq0MRZLBN0FIL5CU7I2RbcazKjggnLD9s2pER5HxEz+SaOZntk+4PGfWYbNNxqyldwUhDZEigJnMmsfGewRRSkiKl2sAFU9JVpNH3cffXIxx3MZydDOpPzmjNZ1QmEIfRFe97TufMgrsUX8xJoJCZAUZEnOQ9SoXSCbZdcfq2/695X3e8n/wVd4G10eCppWSKj/v7+eDN8R8gmHZrnOoBjhodGR3b7KGnepiS8EbxSGDlF6Dh8VMV6LQQ6Qr52d3+0qnx2jbq5Hl2iWlW0SxoGLhAnqBCHH863gghQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(376002)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6486002)(6506007)(71200400001)(38100700002)(6512007)(2616005)(26005)(38070700005)(83380400001)(85182001)(41300700001)(110136005)(122000001)(478600001)(54906003)(66476007)(66556008)(66446008)(64756008)(66946007)(316002)(76116006)(8936002)(8676002)(5660300002)(7416002)(4326008)(86362001)(36756003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHRHYWcxZjBqUlBFVVJRbjFPRGdSOVIzczdxZjRGcjVHblU5MWN1dkxjSDBD?=
 =?utf-8?B?SjBYeWxLUDdmSWFUWHBTWUgxVUNPRUFGczNGOHk0WGZCMXJ3cE5oQS9TQkR6?=
 =?utf-8?B?WS9LTjBNQTNFZmhwQno3aXJObGZwWUdrdUJ1Vy9hdGJTUVYvQWxLZ3NTdE1Q?=
 =?utf-8?B?RkRFOEhoVEx6Q0pIdmJveHNMRGtEaFRyV1VtVE50bWp1Nlc3MWdXSkNMWEhv?=
 =?utf-8?B?SzZKSG5QT0ZpUHFTTkp5eEVjVzVMcGhNMkRadGFDaXA3Y0J6VmJZcXBPSy80?=
 =?utf-8?B?cVhjTFZWVitPRlVIVUFJQWJqVkExWXJ6U3hBZTVRVktYL2NQRjlxdlFWQjBz?=
 =?utf-8?B?NlM0SDNLUGFNdXc1NENmZUxRSDZ5dndJTllTeFY1VkVHQUQwWFZ2VG5DT1F3?=
 =?utf-8?B?cUpXaUdaT1FnMVJOZm8wbDRBMjBlbnNWdDJVUmNkOXRXUkl6MGtyZldPUks3?=
 =?utf-8?B?QWw5eURqSUJucjZNMEJROUtGN3ZYMWpxMWFEUllKTUVmU3lPRzdTR2tBdHUy?=
 =?utf-8?B?OUF6SkdMQ0Ivd29oNE9Dblh6RWh2LzVSUGtNZzBUWEN0dFBuaFRuWU00SE9Y?=
 =?utf-8?B?b29SbDFBaldia3N0djVuUlA1dnRzU3NSTnhlS1FuNkw2bXRnSVNLZkt2aW1L?=
 =?utf-8?B?YzJtZ2RmSm9yTFJQenQ4OFpvUmxTWE5ZQTZpVkFiZElTVHpkZ0xUcFpSU1N6?=
 =?utf-8?B?NW9TZU5nMFdHbThmbnJWai9JdUJ0TXZXQ213V3EvRW00TmRvZzhyK0tsSU5H?=
 =?utf-8?B?MW55TmxVdFY5NnIwSUpVVENMdER0SEkveE9zVXBxL1d1ZjNzWHROUjg5SzVR?=
 =?utf-8?B?OWdkeWhrTlhsaW5ReTVQQUZ6WTROam1HMThQeTZ3QmNwUVZLbW1wbjhGMEdN?=
 =?utf-8?B?WWRWTGUxWmJzZnhJT3p0bzkzaUNGR1F2cFlkV1ZuUThybjBCdHhnSHdSUkNW?=
 =?utf-8?B?aG5BSGdadS9IVlZWRDJZTnRGQWhHeGVjakREK0FuZHQvZndwL0RSdlR6bEc2?=
 =?utf-8?B?dXpzR05ZRWZ1WWF2SzRqMFBleTc1N0RvR2VCQlg3Z09heTBPN0lSbFQyOUh2?=
 =?utf-8?B?dlRQOUZ3LzBSQWJ6c0p1RU1uMG5kK0E1VVJNaWpDaEtoNjhQdE9EOGhsUWlN?=
 =?utf-8?B?WkFhQnRoeVR3MXR1M1hSYTNlc1VuQ0tTTmFyVENQOGp5Zjd0VytsMEhmQlI4?=
 =?utf-8?B?NmhEU0FXUG81VjNpaWNyUVBzZUZENDIrR1ovQnVwek1IQTFFa2ZObWgyOGtJ?=
 =?utf-8?B?UjNIOFBSRzY2bmROaEdsazdGU3l5ckdVeDN4Z3JxSFQ3eFNEdi9pK0VXWE9E?=
 =?utf-8?B?cjRPRzMrOGhQT25SVVNPV3NYR0FXUFhESGVJYTlhWXQ2WE5tYlM0U1IxaTM3?=
 =?utf-8?B?c1Vsb2ZiTU9sdHdJdmNaZ3VmazBMT2FuTzA5UUI5akEzRWI0ZExrQS9vaG1D?=
 =?utf-8?B?RFNPdDZPRitneVRnci9wUkVrOFZDNngxZFJXM0VBaFVCeEhBb0RvRmc4aGxu?=
 =?utf-8?B?NkVDZFBRSzdFbENxQ3R3Si9ZeUVkakFNclQxTC9kM2NpMGVZbEJFOGZaZUVK?=
 =?utf-8?B?KzBGS1lYWkladWNhSEdrb25oVnl6TjZ1dy8xcmFPbjhvdFdNekltQzFNc2tw?=
 =?utf-8?B?djdFZWxtUzdjSUNzYjJ0Q0ZUc09HQUxBVDhIOHlRbWVJZDNuOWdIOGdoU3Fw?=
 =?utf-8?B?cFJzeEEydHd2WWxGamI4NjdVRTlVTEZiMzhqSWVlN0J5N1lWRjR5bTJJVnYv?=
 =?utf-8?B?dVhXYm9HQ1ZTWFJBaWhzZ2svSlkwZHY1c1VFbVBwV1pkb0lRV1dtZkp0cVpR?=
 =?utf-8?B?QlR6Wkt1c1hOTjlQbnUzNUlLWnJlWkgyaStiSXlONFVHOFRSSUNQTU1JbWky?=
 =?utf-8?B?c05vRStEY2grZTZnZWtySlQ2ZWE3bWZmN3dGcG5TdkMraFlCUEd1TzJYZk9C?=
 =?utf-8?B?Z3BXcTVrd21VZlovcXVyZHV2RG1tV3BmNCtCZ2ZXdTV3TzRKTFpsU1lVMWRq?=
 =?utf-8?B?VW1FTWFNeXJzOXZFSWR0eks3ejN6MVNaNis5NWpRZklQMkRKZTdoQWFNcnFV?=
 =?utf-8?B?dVFTTElSOWZsLzRWandMSmRKQXNtc05zdDROQ2ViWjFlN09EVzBERjUxbVRL?=
 =?utf-8?Q?VY6zx7zHyMThgvJpcwTb+Yqhg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DEE3862F6B77548ACC4E9B528B38878@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af78345-c263-4053-e8ad-08dbc649d654
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 08:54:23.3333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thToyMud16gUB0ULuL6EGxjt0dk56Snxum+ZdUs6xCm2DeRKzl0bvwL16fkZJQshKZB394/Ea+6oRw2GD18CAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7787
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.806200-8.000000
X-TMASE-MatchedRID: zGP2F0O7j/s/XHdICuW5rya1MaKuob8PC/ExpXrHizxcKZwALwMGsyQ5
        BpELg58DR9n/TJYJbfBHhaf6BNcbOwDNPxu11HXjH5YQyOg71ZbDx2NobQWtmxS11FlOYRohQyY
        np0aZIjLhUsEhpSy17HTv9Bst6w/PD7+f/jfUYxIc9jA4mLo8udvhKQZ2RM31j2iyfwmt0k+PdB
        sWkfHN7TLejDs2jpLl4QeSIpZv9OlC/bXMk2XQLIMbH85DUZXyseWplitmp0j6C0ePs7A07YExX
        SSpzaFkDHBrJUcxLCtKw/4zXauPcWOiLhggnDzZKqQq5rrTbkFWXGvUUmKP2w==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.806200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 5F90AEA0A9F20C52F105808136243E66AABD65B8CC38C4B6788724972DB7978E2000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBGcmksIDIwMjMtMTAtMDYgYXQgMTU6MzggKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IEFkZCBNVDgxODggUGFkZGluZyB0byBPVkwgYWRhcHRv
ciB0byBwcm9iZSB0aGUgZHJpdmVyLg0KPiANCj4gUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBt
ZWRpYXRlay5jb20+DQoNClJlbW92ZSBteSByZXZpZXdlZC1ieSB0YWcuDQoNCj4gU2lnbmVkLW9m
Zi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRlay5jb20+DQo+IC0tLQ0K
PiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oICAgICAgIHwgIDUgKysr
LQ0KPiAgLi4uL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYyAgIHwgMjYN
Cj4gKysrKysrKysrKysrKysrKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kaXNwX2Rydi5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
aXNwX2Rydi5oDQo+IGluZGV4IGY5ZmRiMTI2OGFhNS4uNDViMzBhMmZlMTFhIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+IEBAIC0xNTksNSArMTU5LDgg
QEAgc2l6ZV90IG10a19tZHBfcmRtYV9nZXRfbnVtX2Zvcm1hdHMoc3RydWN0IGRldmljZQ0KPiAq
ZGV2KTsNCj4gIA0KPiAgaW50IG10a19wYWRkaW5nX2Nsa19lbmFibGUoc3RydWN0IGRldmljZSAq
ZGV2KTsNCj4gIHZvaWQgbXRrX3BhZGRpbmdfY2xrX2Rpc2FibGUoc3RydWN0IGRldmljZSAqZGV2
KTsNCj4gLXZvaWQgbXRrX3BhZGRpbmdfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0
IGNtZHFfcGt0DQo+ICpjbWRxX3BrdCk7DQo+ICt2b2lkIG10a19wYWRkaW5nX3N0YXJ0KHN0cnVj
dCBkZXZpY2UgKmRldik7DQo+ICt2b2lkIG10a19wYWRkaW5nX3N0b3Aoc3RydWN0IGRldmljZSAq
ZGV2KTsNCg0KTW92ZSB0aGlzIHRvIHBhdGNoIFsxNy8yM10NCg0KUmVnYXJkcywNCkNLDQoNCj4g
K3ZvaWQgbXRrX3BhZGRpbmdfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGNtZHFf
cGt0DQo+ICpjbWRxX3BrdCwNCj4gKwkJCXUzMiB3aWR0aCwgdTMyIGhlaWdodCwgdTMyIHJpZ2h0
LCB1MzIgYm90dG9tLA0KPiB1MzIgY29sb3IpOw0KPiAgI2VuZGlmDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYw0KPiBiL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jDQo+IGluZGV4IDgxMmEx
ZGY5NzMyZi4uYzMyNmE2NThkYzYzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYw0KPiBAQCAtMzAsNiArMzAsNyBAQCBlbnVtIG10
a19vdmxfYWRhcHRvcl9jb21wX3R5cGUgew0KPiAgCU9WTF9BREFQVE9SX1RZUEVfRVRIRFIsDQo+
ICAJT1ZMX0FEQVBUT1JfVFlQRV9NRFBfUkRNQSwNCj4gIAlPVkxfQURBUFRPUl9UWVBFX01FUkdF
LA0KPiArCU9WTF9BREFQVE9SX1RZUEVfUEFERElORywNCj4gIAlPVkxfQURBUFRPUl9UWVBFX05V
TSwNCj4gIH07DQo+ICANCj4gQEAgLTQ3LDYgKzQ4LDE0IEBAIGVudW0gbXRrX292bF9hZGFwdG9y
X2NvbXBfaWQgew0KPiAgCU9WTF9BREFQVE9SX01FUkdFMSwNCj4gIAlPVkxfQURBUFRPUl9NRVJH
RTIsDQo+ICAJT1ZMX0FEQVBUT1JfTUVSR0UzLA0KPiArCU9WTF9BREFQVE9SX1BBRERJTkcwLA0K
PiArCU9WTF9BREFQVE9SX1BBRERJTkcxLA0KPiArCU9WTF9BREFQVE9SX1BBRERJTkcyLA0KPiAr
CU9WTF9BREFQVE9SX1BBRERJTkczLA0KPiArCU9WTF9BREFQVE9SX1BBRERJTkc0LA0KPiArCU9W
TF9BREFQVE9SX1BBRERJTkc1LA0KPiArCU9WTF9BREFQVE9SX1BBRERJTkc2LA0KPiArCU9WTF9B
REFQVE9SX1BBRERJTkc3LA0KPiAgCU9WTF9BREFQVE9SX0lEX01BWA0KPiAgfTsNCj4gIA0KPiBA
QCAtNjcsNiArNzYsNyBAQCBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0DQo+IHByaXZhdGVfY29t
cF9zdGVtW09WTF9BREFQVE9SX1RZUEVfTlVNXSA9IHsNCj4gIAlbT1ZMX0FEQVBUT1JfVFlQRV9F
VEhEUl0JPSAiZXRoZHIiLA0KPiAgCVtPVkxfQURBUFRPUl9UWVBFX01EUF9SRE1BXQk9ICJ2ZG8x
LXJkbWEiLA0KPiAgCVtPVkxfQURBUFRPUl9UWVBFX01FUkdFXQk9ICJtZXJnZSIsDQo+ICsJW09W
TF9BREFQVE9SX1RZUEVfUEFERElOR10JPSAicGFkZGluZyIsDQo+ICB9Ow0KPiAgDQo+ICBzdGF0
aWMgY29uc3Qgc3RydWN0IG10a19kZHBfY29tcF9mdW5jcyBfZXRoZHIgPSB7DQo+IEBAIC04MSw2
ICs5MSwxMyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kZHBfY29tcF9mdW5jcyBfbWVyZ2Ug
PSB7DQo+ICAJLmNsa19kaXNhYmxlID0gbXRrX21lcmdlX2Nsa19kaXNhYmxlLA0KPiAgfTsNCj4g
IA0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGRwX2NvbXBfZnVuY3MgX3BhZGRpbmcgPSB7
DQo+ICsJLmNsa19lbmFibGUgPSBtdGtfcGFkZGluZ19jbGtfZW5hYmxlLA0KPiArCS5jbGtfZGlz
YWJsZSA9IG10a19wYWRkaW5nX2Nsa19kaXNhYmxlLA0KPiArCS5zdGFydCA9IG10a19wYWRkaW5n
X3N0YXJ0LA0KPiArCS5zdG9wID0gbXRrX3BhZGRpbmdfc3RvcCwNCj4gK307DQo+ICsNCj4gIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RkcF9jb21wX2Z1bmNzIF9yZG1hID0gew0KPiAgCS5jbGtf
ZW5hYmxlID0gbXRrX21kcF9yZG1hX2Nsa19lbmFibGUsDQo+ICAJLmNsa19kaXNhYmxlID0gbXRr
X21kcF9yZG1hX2Nsa19kaXNhYmxlLA0KPiBAQCAtMTAwLDYgKzExNywxNCBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IG92bF9hZGFwdG9yX2NvbXBfbWF0Y2gNCj4gY29tcF9tYXRjaGVzW09WTF9BREFQ
VE9SX0lEX01BWF0gPSB7DQo+ICAJW09WTF9BREFQVE9SX01FUkdFMV0gPSB7IE9WTF9BREFQVE9S
X1RZUEVfTUVSR0UsDQo+IEREUF9DT01QT05FTlRfTUVSR0UyLCAyLCAmX21lcmdlIH0sDQo+ICAJ
W09WTF9BREFQVE9SX01FUkdFMl0gPSB7IE9WTF9BREFQVE9SX1RZUEVfTUVSR0UsDQo+IEREUF9D
T01QT05FTlRfTUVSR0UzLCAzLCAmX21lcmdlIH0sDQo+ICAJW09WTF9BREFQVE9SX01FUkdFM10g
PSB7IE9WTF9BREFQVE9SX1RZUEVfTUVSR0UsDQo+IEREUF9DT01QT05FTlRfTUVSR0U0LCA0LCAm
X21lcmdlIH0sDQo+ICsJW09WTF9BREFQVE9SX1BBRERJTkcwXSA9IHsgT1ZMX0FEQVBUT1JfVFlQ
RV9QQURESU5HLA0KPiBERFBfQ09NUE9ORU5UX1BBRERJTkcwLCAwLCAmX3BhZGRpbmcgfSwNCj4g
KwlbT1ZMX0FEQVBUT1JfUEFERElORzFdID0geyBPVkxfQURBUFRPUl9UWVBFX1BBRERJTkcsDQo+
IEREUF9DT01QT05FTlRfUEFERElORzEsIDEsICZfcGFkZGluZyB9LA0KPiArCVtPVkxfQURBUFRP
Ul9QQURESU5HMl0gPSB7IE9WTF9BREFQVE9SX1RZUEVfUEFERElORywNCj4gRERQX0NPTVBPTkVO
VF9QQURESU5HMiwgMiwgJl9wYWRkaW5nIH0sDQo+ICsJW09WTF9BREFQVE9SX1BBRERJTkczXSA9
IHsgT1ZMX0FEQVBUT1JfVFlQRV9QQURESU5HLA0KPiBERFBfQ09NUE9ORU5UX1BBRERJTkczLCAz
LCAmX3BhZGRpbmcgfSwNCj4gKwlbT1ZMX0FEQVBUT1JfUEFERElORzRdID0geyBPVkxfQURBUFRP
Ul9UWVBFX1BBRERJTkcsDQo+IEREUF9DT01QT05FTlRfUEFERElORzQsIDQsICZfcGFkZGluZyB9
LA0KPiArCVtPVkxfQURBUFRPUl9QQURESU5HNV0gPSB7IE9WTF9BREFQVE9SX1RZUEVfUEFERElO
RywNCj4gRERQX0NPTVBPTkVOVF9QQURESU5HNSwgNSwgJl9wYWRkaW5nIH0sDQo+ICsJW09WTF9B
REFQVE9SX1BBRERJTkc2XSA9IHsgT1ZMX0FEQVBUT1JfVFlQRV9QQURESU5HLA0KPiBERFBfQ09N
UE9ORU5UX1BBRERJTkc2LCA2LCAmX3BhZGRpbmcgfSwNCj4gKwlbT1ZMX0FEQVBUT1JfUEFERElO
RzddID0geyBPVkxfQURBUFRPUl9UWVBFX1BBRERJTkcsDQo+IEREUF9DT01QT05FTlRfUEFERElO
RzcsIDcsICZfcGFkZGluZyB9LA0KPiAgfTsNCj4gIA0KPiAgdm9pZCBtdGtfb3ZsX2FkYXB0b3Jf
bGF5ZXJfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50DQo+IGlkeCwNCj4g
QEAgLTM3MCw2ICszOTUsNyBAQCBzdGF0aWMgaW50IG92bF9hZGFwdG9yX2NvbXBfZ2V0X2lkKHN0
cnVjdCBkZXZpY2UNCj4gKmRldiwgc3RydWN0IGRldmljZV9ub2RlICpub2RlLA0KPiAgfQ0KPiAg
DQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtfb3ZsX2FkYXB0b3JfY29t
cF9kdF9pZHNbXSA9IHsNCj4gKwl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4OC1wYWRk
aW5nIiwgLmRhdGEgPSAodm9pZA0KPiAqKU9WTF9BREFQVE9SX1RZUEVfUEFERElORyB9LA0KPiAg
CXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LWRpc3AtZXRoZHIiLCAuZGF0YSA9ICh2
b2lkDQo+ICopT1ZMX0FEQVBUT1JfVFlQRV9FVEhEUiB9LA0KPiAgCXsgLmNvbXBhdGlibGUgPSAi
bWVkaWF0ZWssbXQ4MTk1LWRpc3AtbWVyZ2UiLCAuZGF0YSA9ICh2b2lkDQo+ICopT1ZMX0FEQVBU
T1JfVFlQRV9NRVJHRSB9LA0KPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LXZk
bzEtcmRtYSIsIC5kYXRhID0gKHZvaWQNCj4gKilPVkxfQURBUFRPUl9UWVBFX01EUF9SRE1BIH0s
DQo=

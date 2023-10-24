Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D3A7D589F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbjJXQhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbjJXQhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:37:17 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E76D7F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 09:37:13 -0700 (PDT)
X-UUID: 93805f12728b11eea33bb35ae8d461a2-20231025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=OahQy5oWXEv3u3JvVnC1aJakTvcJt7J6LlE9YHkfBwI=;
        b=u/R+jdHdcQr6fIxdccxpOdUzpFUF3hys+2hq2m8QAxSotcm5wald/jKic1bVTINprZqsU8Bhx3Wd6w3s2wZCD53G2vv1nxDFlnrSDQf8aSFa+j6SCZstqYfGXNJDjA7XwYQ5Q8EGMFidZUnUITPQl9LB9Ls4jPvd8HVTBkX253k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:80442431-b073-4c49-9b95-27c1b4ec4c3b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:41e09494-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: 93805f12728b11eea33bb35ae8d461a2-20231025
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1501762014; Wed, 25 Oct 2023 00:37:09 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Oct 2023 00:37:08 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 25 Oct 2023 00:37:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtTDWbWHpYpnXR7qVtnXPUhbzDCPOaBOU0TPltkJCyoOVrbXkn8kWr9apTPR43mBimfzVVtoczao5Xx+FE0XZOvmQt4SyuxGcZ3ZREhL1sw+G+5lOsG3XNZnyFd/MzlaKZrULpG+/2U6vlfLXazvRVsRh5kZXvesC6itTpMLMz//hBxTsOP+DODjF3pTGCZZFXS7yxvfyXJMviA3e3sTI2+62Lz7mUVLxJIprxR0IbyvM4s+QV6Xo4n2OosVpR4BxPLSP3ioUenYfwwPAYz0yF1F5+VHLjOUZp243Hn55v33//i2oJEbs7kdyQIBGFy8YqIVqzLNO4ULZuhmsgIrKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OahQy5oWXEv3u3JvVnC1aJakTvcJt7J6LlE9YHkfBwI=;
 b=cZkvJkjXlbK2Gm6m4Qwi8HPKcYdZ5H/u2K8F4PH1tlsNScp7Vg5ZGkBfVv1NNUaagkzaw1aaYHTP2lBC/NQBt4qNU8hj6SXPZBtd9FEgPZQ6wCktDsXZlTKnEOYriQKpb1s6NMclMiN7aHHhcwY/DIrMvkd01gOVHUd6R+D+BZydNZ9bLofn8abeNSzM1R/0Y6zitl02h65id3r7ewfg5aL0kfM5e4ovUIQD86ZEsHjGq03KLHnqOJ8L/7JbZVHeakGQgfQgIVPE/9KLRo/OGkHTYDQfbDs/MpvUPwR92jdfXZoaA/4JgvF41O+JcgfsjyK3Z/LC+r5LkIBfwcE6RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OahQy5oWXEv3u3JvVnC1aJakTvcJt7J6LlE9YHkfBwI=;
 b=K6gjJXLWvJuQtPUx+J4Jatsd+qcmqRXiGl+SeOQM5bNOmz/4u+sCbVntYfynLKk6Uydb9mDiFx8cbgHRgfAWB1Lnbk6K/lwWZFPPKHYDQ5r6ETNn4aQiTP372Jw0gG3P1HO8EH4hzPjHcvP4bR847TwTRelcvbHB5ZsF5WtKw2Q=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB7027.apcprd03.prod.outlook.com (2603:1096:400:331::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 16:37:05 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d%7]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 16:37:05 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
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
Subject: Re: [PATCH v2 2/9] dt-bindings: mailbox: Add property for CMDQ secure
 driver
Thread-Topic: [PATCH v2 2/9] dt-bindings: mailbox: Add property for CMDQ
 secure driver
Thread-Index: AQHaBWq/vadWk4BIjEWoaSV6NJKP+bBXACgAgAIlpYA=
Date:   Tue, 24 Oct 2023 16:37:05 +0000
Message-ID: <c04109bb54d6d4cf728488a8ed697df0b71f4e46.camel@mediatek.com>
References: <20231023043751.17114-1-jason-jh.lin@mediatek.com>
         <20231023043751.17114-3-jason-jh.lin@mediatek.com>
         <374a6fe3-23f5-4450-8ef6-8e0478c7ade5@linaro.org>
In-Reply-To: <374a6fe3-23f5-4450-8ef6-8e0478c7ade5@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB7027:EE_
x-ms-office365-filtering-correlation-id: f540e3f1-a337-45a4-d9dc-08dbd4af7525
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LFMERkUMHDkW+wPIrG6PdWvLMLcLjFRlbucmIylhmLDXgGh2a/BvbSw+1OoZt1ZTKkPhh5ZpwMF+zbtDbaVSJcKkXZ6ZCjThnyEITz+EzTRUAHoWVX/DvR6YgAW0lInvaezWEfUUjduFPZGx9r007pYOAEmq9I8ZrnJwL4yW6eyQbyXqbVOQMd/OftvuRNwpFSDEMLvtEF+b5Ah6TY3N3tfsOm8MV2l75mfbdDAoG3XcmPukoMwizO83PZ8bC2sASY6K39ETZnzRPtYNM9Z7TmBmiFkWHX4lpKfVfxVlIZxit0CwXb0UZM8lwVOdryCD2NXhtPBmh0kPjQq/776T1YNKlMLUK9JXO9fv3L3Km+wN1GoYsx5n3kY11IN22Hx011z+vN5b5klnpiw9LTEyXGc/IbU8x/s9/Lx3cldNiRBi9i0VxmdmxIhXlOm9XcqqITz7IuugJItHIaYzLLnOlF16TULM4JIB3mEwGh/K7Zxqw7vYHlpe4eyPBPvdY2wbQ/MEfNV977OOhjhJ9HW/6AT19XXKAATu3ArPMV1un/MNWmB8V58Gwoti9JQTMkHCE/PTGOrkVnHfQLw7z+rKy5QDi/jJ+z5qHpD62DNBKRwvl7Ns4eVp+voyGvo4BYngDaCugbCpikx8JOdF13rtWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(53546011)(6506007)(2906002)(7416002)(478600001)(71200400001)(15650500001)(6486002)(8676002)(4326008)(966005)(8936002)(66446008)(5660300002)(41300700001)(66476007)(66946007)(316002)(66556008)(76116006)(110136005)(91956017)(64756008)(54906003)(85182001)(83380400001)(38100700002)(36756003)(26005)(38070700009)(2616005)(86362001)(122000001)(6512007)(4001150100001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3UwM0g0T0g3V21ubnJrZUg4VTM4WU9nWFpnYWpXQ0o4eUE3eExTMXVQdDN1?=
 =?utf-8?B?N3VhcmJuaWN1MExIUFhlMGJxS0dtU0NvRVZTd2htdVdKdEZLd1BHMVpJVmpk?=
 =?utf-8?B?MlE5M1dGT2dUWmVnd1NTYVQ1M204TTJxeitlZFl2RWR1ZGkweHBiWHk2NU53?=
 =?utf-8?B?TmU5cEpLRGJocmlFZk5iSkdEUXduWXZvWlIrWkcrWjR2SUw3MGY5N3hyTTda?=
 =?utf-8?B?RVoyR2NaUStHWFpPSUxvUXhuK3lHZUVWbFJxUjk0cTNuLzhnMnFpWDRoZWdY?=
 =?utf-8?B?NmdjVWU3bkFERmlSUzBIREdhVTBra1BKR0FwOU1aamhQUWNnaGxCSkowdjlS?=
 =?utf-8?B?LzMyOHRQVHJEYWRVZ25XRk9YRWl4WFkvQzgyOHVsSy9KTitCakZaUTFiQXBn?=
 =?utf-8?B?dnhxQ1l1bjluR2tNYTBJS0hqb1RTVU4xUVJJQkg4Wnc0dkVTU3RRZzRPQjg1?=
 =?utf-8?B?SmYwRHNZKzhKZHlvSjFvRmJmNVNnT0lMUGNnSTBkSU8rSHNxcFFRekdNNlRK?=
 =?utf-8?B?TVQvaG9uUGcxeVZabnhVQUdvd0JiWEIwWStRUTlVWnpnUmVud3NQTFNkY0JZ?=
 =?utf-8?B?L3dLSDFNaTRST2hSL1hoQnkxZ3VOajMxZkxXSUF2RWpTVnpsZTZNOEVOZWVF?=
 =?utf-8?B?OStpdTU2dm9xSEZtTXdmVXFNTXYyVjJ2UUtGL3dvNENQbUhrNllIdUFJbFlT?=
 =?utf-8?B?dmovWjhvbHFXM3ZoN2xQbytKZm5CeWtpTFhQU2RrYWZvTTdlUUtQaGVRVjhx?=
 =?utf-8?B?ZkNoelk0akxiL3JjNVQzQXcyWTB5RWZNL3RrZUlFc0hnbUZncWVJSVBUUnBs?=
 =?utf-8?B?RHVtU3l1WU5KdUNkc2FLcWVtL2lSQWtrTzdlL2FxVWMyWEhXWWkraFAxdUZ4?=
 =?utf-8?B?VFVOMXYvc004OE41Sk5GMlRvODZ3THJlZ2NpVUpKRXJsejIwREdRcWkyaHo5?=
 =?utf-8?B?ZXZZSDVpL1h4VEVzVnRYSVh4UzU0dVJzSSthQ0RiVXQ5eW5FNE5SclpiTHZp?=
 =?utf-8?B?RkwwNXhjTlVuODlWRWxPMGdyWDZkRHY4Y3RmMzVMWC9FQ0Rva0p2UjFrYm9D?=
 =?utf-8?B?YnAvMXRHempzblpOZ1BLR2Z1VkM1RGxkODFKbk5KakxjOHF2cEdIUlJQSlEw?=
 =?utf-8?B?OWsxQUNiTW5PTTUxTldIWkJtdUVnMlJnR1NmUFNLSjhZR1ljN2ZIZ3RORFQ1?=
 =?utf-8?B?RllaMURiYks5cU82S21TdFFZTDhibE9sNUI5cU1RWXF2b2JEaEdwV3BQdUZr?=
 =?utf-8?B?a2JWYy9rM01iNmRXM2FTU3o1c3ZmRjgzNFByM2hhbWg4dzZJaGViQklvR2dI?=
 =?utf-8?B?UXp4YkpUU2ZTUWF1djkwMng2dEVsb0VSZml4aUFkQ2dhWWhVK01JdDBuc0ov?=
 =?utf-8?B?aTFYZlcrTDZmQUZJZ0FoQ3BJZU1uQTNSNDc2V3JtdHFoaVpaYnRnVXByZHVD?=
 =?utf-8?B?QW1rZjdXOHhKditpY2dSOEZxSVJkLzVreHFiVVF6VWE3Y3Q2SVJtUkR3ZEZW?=
 =?utf-8?B?UzlmNDFVMHEwVzNkZHpVRlJ2Yk04empkNUx1cDcwQ0l0dVV0dTNLZTU0dW1R?=
 =?utf-8?B?dXJvcW9yWngxZUJpaDNwNDVvbEtwbDdSNXp0UGlsUDlZWVVvclk1TDdrLzI4?=
 =?utf-8?B?dFhmME1ybDZJamlhellmNmtua1ZrT2VadHBiWVQ3Mkt6dTdhWFE5NlVZYllR?=
 =?utf-8?B?Z3NDUWkxMnR3YWliR1JwMlZ2NDMwMUdsOW9MOVFkV3ZVTjNQMEdobmRYWThi?=
 =?utf-8?B?S280NmVxbndzSVczS0MzWmtuYUMzc3FYckt6QlM1RURCeVRPTHlIS05RRFFX?=
 =?utf-8?B?YlhtV1Y4T2JtaDVsbGtOWEJiZnFST0wzdkVuY0FZbVliRUlrdjFCSjRVOG1q?=
 =?utf-8?B?TENYb0Y4VHZ3cm9sZm5DdmJwNkEvNFNBYTdkaXlncDdvWXhiOWU5NVRzVmZo?=
 =?utf-8?B?Z1cyUUlkak14NDE1eW5hNlNZZWIvLzlVc0RsL0FoS2E0Q0VxdCs5bFZZZDND?=
 =?utf-8?B?anJPUUxXZ0s2Qzl5eVk5b2diZ2ZIaU0wQ0h0bTUvNXJWc09SYisyam1OWG9Z?=
 =?utf-8?B?Q21VQWdldkdKclprYnVLN1h1dTZWSVJUazhsS1NMdFhROTBiT05vNnY1a29w?=
 =?utf-8?B?WVVqZUxPUHdNQjBsVlhYYTJrejIzQWhjd243U3pscWFxc2k5emg1K201SXVZ?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4669F131A548143A84336B9F4F3987C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f540e3f1-a337-45a4-d9dc-08dbd4af7525
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 16:37:05.2723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1WA1P2Gk3F/bCNmj+5ZZn3Vzrp6WxW7F/nc1hurNgaHMWYRjPsBfttFQPybCAR/eMwvqYPIB4tppFreOBB8kcHQHeul8MVO4TlvjAz18RAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpPbiBNb24sIDIwMjMt
MTAtMjMgYXQgMDk6NDkgKzAyMDAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ICAJIA0K
PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lg0KPiAgT24gMjMvMTAvMjAyMyAwNjozNywgSmFzb24tSkguTGluIHdyb3RlOg0KPiA+IEFk
ZCBtYm94ZXMgdG8gZGVmaW5lIGEgR0NFIGxvb3BwaW5nIHRocmVhZCBhcyBhIHNlY3VyZSBpcnEg
aGFuZGxlci4NCj4gPiBBZGQgbWVkaWF0ZWssZ2NlLWV2ZW50cyB0byBkZWZpbmUgYSBHQ0UgZXZl
bnQgc2lnYW5sIHNlbnQgZnJvbSBDTURRDQo+ID4gVEEgZHJpdmVyIGluIHNlY3VyZSB3b3JsZCBh
cyBhIHNlY3VyZSBpcnEuDQo+ID4gDQo+ID4gVGhlc2UgMiBwcm9wZXJ0aWVzIGFyZSByZXF1aXJl
ZCBmb3IgQ01EUSBzZWN1cmUgZHJpdmVyLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEphc29u
LUpILkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2Jp
bmRpbmdzL21haWxib3gvbWVkaWF0ZWssZ2NlLW1haWxib3gueWFtbCAgICAgICAgIHwgMTANCj4g
KysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPiA+IA0K
PiA+IGRpZmYgLS1naXQNCj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFp
bGJveC9tZWRpYXRlayxnY2UtbWFpbGJveC55YW1sIA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tYWlsYm94L21lZGlhdGVrLGdjZS1tYWlsYm94LnlhbWwNCj4gPiBpbmRl
eCBjZWY5ZDc2MDEzOTguLjY1ZmI5M2JiNTNiNiAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9tZWRpYXRlayxnY2UtDQo+IG1haWxib3gu
eWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94
L21lZGlhdGVrLGdjZS0NCj4gbWFpbGJveC55YW1sDQo+ID4gQEAgLTQ5LDYgKzQ5LDE2IEBAIHBy
b3BlcnRpZXM6DQo+ID4gICAgICBpdGVtczoNCj4gPiAgICAgICAgLSBjb25zdDogZ2NlDQo+ID4g
IA0KPiA+ICsgIG1ib3hlczoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIG1l
ZGlhdGVrLGdjZS1ldmVudHM6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgVGhl
IGV2ZW50IGlkIHdoaWNoIGlzIG1hcHBpbmcgdG8gdGhlIHNwZWNpZmljIGhhcmR3YXJlIGV2ZW50
DQo+IHNpZ25hbA0KPiA+ICsgICAgICB0byBnY2UuIFRoZSBldmVudCBpZCBpcyBkZWZpbmVkIGlu
IHRoZSBnY2UgaGVhZGVyDQo+ID4gKyAgICAgIGluY2x1ZGUvZHQtYmluZGluZ3MvZ2NlLzxjaGlw
Pi1nY2UuaCBvZiBlYWNoIGNoaXBzLg0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFt
bCMvZGVmaW5pdGlvbnMvdWludDMyLWFycmF5DQo+IA0KPiBOb3RoaW5nIGltcHJvdmVkLg0KPiAN
Cj4gVGhpcyBpcyBhIGZyaWVuZGx5IHJlbWluZGVyIGR1cmluZyB0aGUgcmV2aWV3IHByb2Nlc3Mu
DQo+IA0KPiBJdCBzZWVtcyBteSBwcmV2aW91cyBjb21tZW50cyB3ZXJlIG5vdCBmdWxseSBhZGRy
ZXNzZWQuIE1heWJlIG15DQoNClNvcnJ5LCBJIGRpZG4ndCBmaW5kIHlvdXIgY29tbWVudHMgaW4g
dGhlIHByZXZpb3VzIHBhdGNoIGhlcmU6DQoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcv
cHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8yMDIzMDkxODE5MjIwNC4zMjI2My0yLWphc29u
LWpoLmxpbkBtZWRpYXRlay5jb20vDQoNCkNvdWxkIHlvdSBwbGVhc2UgY29tbWVudCBhZ2Fpbj8N
ClRoYW5rIHlvdSB2ZXJ5IG11Y2guDQoNCg0KQW5kIEkgZG8gc2VlIFJvYidzIGNvbW1lbnQsIHNv
IEkgc3luYyB0aGUgbWVkaWF0ZWssZ2NlLWV2ZW50cyBwcm9wZXJ0eQ0KZGVmaW5pdGlvbiBmcm9t
IG90aGVyIHlhbWwgd2hlcmUgdXNlZCB0aGlzIHByb3BlcnR5Lg0KDQpTaG91bGQgSSBhbHNvIG1v
ZGlmeSB0aGUgZGVmaW5pdGlvbiBvZiBtZWRpYXRlayxnY2UtZXZlbnRzIHByb3BlcnR5IHRvDQpy
ZWZlcmVuY2UgdG8gbWVkaWF0ZWssZ2NlLW1haWxib3gueWFtbCBmb3Igb3RoZXIgeWFtbD8NCg0K
UmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+IGZlZWRiYWNrIGdvdCBsb3N0IGJldHdlZW4gdGhl
IHF1b3RlcywgbWF5YmUgeW91IGp1c3QgZm9yZ290IHRvIGFwcGx5DQo+IGl0Lg0KPiBQbGVhc2Ug
Z28gYmFjayB0byB0aGUgcHJldmlvdXMgZGlzY3Vzc2lvbiBhbmQgZWl0aGVyIGltcGxlbWVudCBh
bGwNCj4gcmVxdWVzdGVkIGNoYW5nZXMgb3Iga2VlcCBkaXNjdXNzaW5nIHRoZW0uDQo+IA0KPiBU
aGFuayB5b3UuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiANCj4gDQo=

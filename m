Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF737E1918
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 04:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjKFDLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 22:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjKFDLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 22:11:39 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81EFFF;
        Sun,  5 Nov 2023 19:11:34 -0800 (PST)
X-UUID: 2f00bf0c7c5211eea33bb35ae8d461a2-20231106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=W5H43Z+GHMB6UaN8k0CX8f6GKikxqJsfwVJzfcMtYzA=;
        b=RBLIppPiV0Pt7pkH/fcfY8IOZrWQhTu41hQAIvFrQX5BfEs0NMRACEr//iF8eyenU+qPr7SzZRyTp8meGT4vaP1PbCzH6FS3Ji0CJEQ+28prEtNym5xqI6fCKJ6YeTMviplMFk4xONI9/0OfhWrIspIEaZdF3a/PCUnN9Puk9YU=;
X-CID-CACHE: Type:Local,Time:202311061059+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:f0a19888-007c-49e9-ba8b-69acaab5356f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:0fd9b65f-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2f00bf0c7c5211eea33bb35ae8d461a2-20231106
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 568849475; Mon, 06 Nov 2023 11:11:31 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 6 Nov 2023 11:11:30 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 6 Nov 2023 11:11:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXMSuOdFiT4Yd01YJY5ANqkBGzQD2RLxJQNdw4cT8uBCOZaO0IVr2xM0NsVSHLNEMhBMb1V2ehHm+XXLWaDkFOcz49ZA+vnI0sc6VH0KzmKGJcyyRAa4Gy5DHSjyZdiYRDCJU0RmBB0JHft2rScM63+TpX3n19pnzMi6ZGZsTnEczJ05jMhwPmMYTP0kbcD8US6rHujZ7NfpDdHBIMnNOmbarI7TvkH3FsomYYqFC0xey0JeUUG0pSHJLWn7Lttlzz5KByB4lDcWBLTpD2x0c632z2g36Ry8u5ywvaJJ0uqE0j/HzNRFAHKgZ0Hb0DC9O8ZiIykwCplMYkP1R41paQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5H43Z+GHMB6UaN8k0CX8f6GKikxqJsfwVJzfcMtYzA=;
 b=RVghgHxZxaMZK9CeuW39zaujKNp5WdM0gnXJAr3tEesZqj0RfCurJBVi5rIErcD4tLdV6ayBeQstiZccsR3fiGOr/eeDZ50LIAWlz+Y6qdputVsokUIbIcMqyE0fmLEKRgiV50hAVBUubpHIAN0LvLWs21TbNNs+/stpgnXbk01w/2KuWup+ea6r+vPy4AFYkEfX/54L8KRE7dExeH0Ne03aH1vXs8v1DvAvu+J7fIEwI4ZK6dfZh0Ydky70552jiaSel9abpJmXwBFWjSuVYpOc3uILLuh/dXzEmgtrmcU7Czc7hDJgBuVJYwAFJRt9+6hGpJ4nMfQa7U11DDtnFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5H43Z+GHMB6UaN8k0CX8f6GKikxqJsfwVJzfcMtYzA=;
 b=j9dUkM9ZxcjH4Q0dX/FfST5AtqRCiap0kH9BxDEtt9CS0qg0Vto2ZVf/Utngv2yefdfjyPCppeAVBaxqosP+q6XawvHI4eVmfdHomOWvG33nBcUAnO5b/gXtdMtIfUlaSahcRtuV7O0JXxQ4fvdtpgEYR1EaXYQjTaLkls4G8uk=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB7218.apcprd03.prod.outlook.com (2603:1096:101:e7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Mon, 6 Nov
 2023 03:11:27 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a4e1:1557:a3fe:c252]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a4e1:1557:a3fe:c252%4]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 03:11:27 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
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
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
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
Subject: Re: [PATCH v2 09/11] drm/mediatek: Add secure flow support to
 mediatek-drm
Thread-Topic: [PATCH v2 09/11] drm/mediatek: Add secure flow support to
 mediatek-drm
Thread-Index: AQHaBWv9A+i72gD9wE2ClQpB4tiv3bBjdJYAgAhR5ICAAM+RgIAAGakAgAADTwA=
Date:   Mon, 6 Nov 2023 03:11:27 +0000
Message-ID: <a2ddf5604052e88b9b2790f23ef89d5e16fdb172.camel@mediatek.com>
References: <20231023044549.21412-1-jason-jh.lin@mediatek.com>
         <20231023044549.21412-10-jason-jh.lin@mediatek.com>
         <02187af1e98093d20a170d0ce4b2b428c7eee37d.camel@mediatek.com>
         <c0b47da99e0a43e867a3fb27efc36786d4315aea.camel@mediatek.com>
         <137cd99b6749e7a2e3b7fa091fd9a20d3c798c53.camel@mediatek.com>
         <310f3588d65d18ead5e07c85ae656a8d94507a04.camel@mediatek.com>
In-Reply-To: <310f3588d65d18ead5e07c85ae656a8d94507a04.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB7218:EE_
x-ms-office365-filtering-correlation-id: aa667184-c717-42be-3e96-08dbde7610f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 09EwoMM8j7pNaMEUPtMVkjs6/BOqT9+B6lLpvjhfKD4p1mcuPKoe2+E7hpfz6RrOyUlhVePOCYNqOtCcBi/S0UXx+ODuzeGoRwmc3HqQDiST7qJMVQyZIxM3XoaaiJq06bONW4mqXm+ok59ChllPdpTKeMD1rAaDDasc9Wyj+MCmizpHeAnexrxaWLu25nTMn9zz4GE0of4CO1fDsxhLt/peYDY5JZyBcBwSSKejWQ/M67Kb3YFOFNZgvsxGybOS0UhC9xCI3M5unwp5ZD0v4k2VIQIvMdOWKhOtD5mzMA5jfm7nHy/XfTE6jychOMfNt98fPevpD6YBueAVgJSv762YJdUG3PZ64C+uSQFHg84WxpsDqvU2vVWzQanh9EVbxpGIe+ZJA3XpqBUQ3snVM8TIZbl/z/FjStYng+fEc9BfnyiY9I9ZPsdV35L7LXoRWA0gYEOH09fZDS0sl49mSBm5OxdqiVWLuCdIoj/aaZL6aUaXIKDchQpE/Fus9U2CRzeEQF9p7CPWnm+bosh88I9b1c6Ur+DAIzaJ58+C8TDEt7QlP/Nndm8wgJMEu8MvjAXXUjnQdBbx9UbiN0JQ1d2sgC+P6hTRUjDyBS+swP4S7uq3BYGOZjHPArV3aU3o7vq08zJ3usGNryhy9IitIcXumCJhop8I8RYOzPyoK/0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(122000001)(2616005)(6506007)(478600001)(71200400001)(26005)(6486002)(316002)(66556008)(76116006)(110136005)(64756008)(54906003)(66446008)(66476007)(66946007)(5660300002)(8936002)(8676002)(6512007)(4326008)(4001150100001)(7416002)(86362001)(83380400001)(85182001)(36756003)(2906002)(41300700001)(38070700009)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THpGWkIraDlwRnRxcndXK0ZvaHk3ZXdzanZpTm1BVnUvdHFkY3dic1NCL01J?=
 =?utf-8?B?TThNc0xIQThRR0JVNE00TG1maGNNRUZ4NGNUREI3K2JxUUlnZ3BoaDBjSHRU?=
 =?utf-8?B?SDZENVRKcFRuOE1WWHczakZZUlBSUnlSdDNoMlhrQkxDT0RETllQV25WSzdh?=
 =?utf-8?B?QjlkRHl0Y3R0Z1M1b09iUUN1b0NWWnFodUJldCtmSHdWZHAwM0YyZkR2TTRZ?=
 =?utf-8?B?WCs3SkxYTmJGZW8xQmkwbklBSDdwY3VTU0U2V2R5cExHRGhFaGFESnI1dkZz?=
 =?utf-8?B?V09uWXREUGo5M1VZSWRQTWJhVk9EZjdqVkpPeURNeHgzcmxCak4zRTVSUGdP?=
 =?utf-8?B?T29wOGkvdHkxWnM2eWNoUitiU2VkRS9IK0JsSEw2eEhLdUU3QnBiVnlXWjJX?=
 =?utf-8?B?bGthTWNhTjlxZUlmYjlXeTJ5RXZCN2hQTVBVMC8rWHhCUHoxbkF5ZCtFUk9i?=
 =?utf-8?B?UGxUdG5kYWtHNDdBSFEyZ1d4c1ZXWmN3OHFTakczdDYvMTdhbE1uZWVIM000?=
 =?utf-8?B?N214a3ErbXArcXlqZHZGcU15bmh4aVVwNEpaRFBqYnc3dTB2U3dQN1ZWN1NT?=
 =?utf-8?B?clMzVWtiTHV0U0VvTmFFc1RlZjk1bWZXdlQ3bEwremVYeEhZckx4eUI1YXlU?=
 =?utf-8?B?T3lPU2hMZ2dUYi9mRUdobmYxTWZzWEVYb3N5aFg1S0FyS29TSGVRMlNZUFBy?=
 =?utf-8?B?anAyNkVQaU16TVVrWDNnS2YxQ2thT3l1OCtJSlE2dVJJRTNncjNGMlhxOXF6?=
 =?utf-8?B?VFNPbC85bFVPSjFkVDgrYzVZRXNjMUNhRUQ2Nm5XVVZKSzhyTHJpLzdiMjJm?=
 =?utf-8?B?dzNzOVhZaDhxN3A3RXlqZVpRK09adFRzK1pJVGxDc2VINmZYYjlTamYwbFQ5?=
 =?utf-8?B?TzI2MTlwWjVlSFQwNmtZZ2V0ZzI3YjNaWHQzMWJ6MHNSb2Vwa29adTFmeGI0?=
 =?utf-8?B?T3N3Tm1Qbmt3STBVcEYxajNOMmdNTmZvQ0Z4SlRWM2o2aXBPYWkyTVhrM3R6?=
 =?utf-8?B?UjJUNDUyZlQ1VjlFeC9mdW9ObkMvbVloV0hBdXVESjhkRFJJcUVraS9WUXdZ?=
 =?utf-8?B?dS9ZYm8rdml3aWRTWGhONkg3NTBLcjlRMjc1N1h3dnRmNHI2Z0ZPMVIxazMy?=
 =?utf-8?B?N1F0Y2hkRFNUUUQ5SGJTYVhqRFFQSWw0N0tnczkxN3o1amh5Z2xTSWZmTEhx?=
 =?utf-8?B?dnJxMk9QOHFxR0QxeEFyTXVPNDQxUW1EVDBBckFUYnJHVEpaVStXS2pqaTlH?=
 =?utf-8?B?ZnR3clY3RnFja2hyZlMxNERXOWlaNGZqaDZvejNzMlcxOG9kVzAyQ2JuOVF4?=
 =?utf-8?B?L3FwekRQaExLRzMrRFdHOHBoWmU4M3VrdTYxTDRhS2xoZjNKQlNQaUg2ZGp6?=
 =?utf-8?B?MTJxM2lxais2QWV0QUF6RkszSW15bllsa1RiTVdWcXVIY3FCRXN3R2Zqbjda?=
 =?utf-8?B?dWUxVThFQjBpUlZSaGx1bHpGWmpndWd1c3FkcUN0M3AvaGVhZ3lIL1FxN0Q4?=
 =?utf-8?B?bytCOWlsQTdiZ3hRc0E3RXFFSlpQdDFsc0E3LzJPMTArNjFTMFRFZXpVVzlj?=
 =?utf-8?B?S3N0NDVJRHJGMmZTZ3ZRTDZiWldkQmRGSW1qSkt6YjdRUHhraEpJV2FFSVVr?=
 =?utf-8?B?UU51NEdqaENqTVlPandZZDloVkRrbk1aMjdFNEhoS3dpdGo5YVp2aFhGalIy?=
 =?utf-8?B?L1VHbnVvWUI0aldEUkNBL0xDQU5lVUF2UDduSDZXWTQ2WWpXaTBFTm5YcS9I?=
 =?utf-8?B?VmMvOU1VMXVZZ1FqZHhvQjdnNFBJcVp1d0sxd2N2cng2T3h6NnVtR3RVWEVI?=
 =?utf-8?B?cGJOK3FYVWNUbGJ2Qm9ybnp3My96T0VKNUNraG11M1BFZlJOU1cyVXdObEth?=
 =?utf-8?B?SnFmNWRudEM1eUNsZktlYzNCb2R3TlM5b3ZsUVlIR0ZzeDNDNy9sM3J6dUIz?=
 =?utf-8?B?OWpOWDR1ZWJDTDFLQ2wzM0J3MTVFRExHVDN2L2JPVExrUDBzempqYlVkTXFB?=
 =?utf-8?B?cy9EZ0NjQnROOXNjRXZ4RUsrcjdGalpSWlhienBROFF5dkp4NGozRjhCZGJN?=
 =?utf-8?B?QkdJc2laU1JwWmlJeTQwTGVONVZtRFF1OFFxN1FDekIzQUxaeGdjVWNvTGFK?=
 =?utf-8?Q?XK4p+bwyoceOu6e9Ytok6dbqt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <794D7BB0088874499DABED6BA2FA9633@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa667184-c717-42be-3e96-08dbde7610f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 03:11:27.4397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OJmQSBIQRRZEo8Gn9QphTB6/dU8SfCNuNL70wc4b3XQlskPuC/OPTXD4h9lxdDqLKWTJkJwtYEYxgMnBdi0qAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7218
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTExLTA2IGF0IDAyOjU5ICswMDAwLCBKYXNvbi1KSCBMaW4gKOael+edv+el
pSkgd3JvdGU6DQo+IE9uIE1vbiwgMjAyMy0xMS0wNiBhdCAwMToyNyArMDAwMCwgQ0sgSHUgKOiD
oeS/iuWFiSkgd3JvdGU6DQo+ID4gT24gU3VuLCAyMDIzLTExLTA1IGF0IDEzOjA0ICswMDAwLCBK
YXNvbi1KSCBMaW4gKOael+edv+elpSkgd3JvdGU6DQo+ID4gPiBPbiBUdWUsIDIwMjMtMTAtMzEg
YXQgMDY6MDEgKzAwMDAsIENLIEh1ICjog6Hkv4rlhYkpIHdyb3RlOg0KPiA+ID4gPiBIaSwgSmFz
b246DQo+ID4gPiA+IA0KPiA+ID4gPiBPbiBNb24sIDIwMjMtMTAtMjMgYXQgMTI6NDUgKzA4MDAs
IEphc29uLUpILkxpbiB3cm90ZToNCj4gPiA+ID4gPiBUbyBhZGQgc2VjdXJlIGZsb3cgc3VwcG9y
dCBmb3IgbWVkaWF0ZWstZHJtLCBlYWNoIGNydGMgaGF2ZQ0KPiA+ID4gPiA+IHRvDQo+ID4gPiA+
ID4gY3JlYXRlIGEgc2VjdXJlIGNtZHEgbWFpbGJveCBjaGFubmVsLiBUaGVuIGNtZHEgcGFja2V0
cyB3aXRoDQo+ID4gPiA+ID4gZGlzcGxheSBIVyBjb25maWd1cmF0aW9uIHdpbGwgYmUgc2VudCB0
byBzZWN1cmUgY21kcSBtYWlsYm94DQo+ID4gPiA+ID4gY2hhbm5lbA0KPiA+ID4gPiA+IGFuZCBj
b25maWd1cmVkIGluIHRoZSBzZWN1cmUgd29ybGQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gRWFj
aCBjcnRjIGhhdmUgdG8gdXNlIHNlY3VyZSBjbWRxIGludGVyZmFjZSB0byBjb25maWd1cmUgc29t
ZQ0KPiA+ID4gPiA+IHNlY3VyZQ0KPiA+ID4gPiA+IHNldHRpbmdzIGZvciBkaXNwbGF5IEhXIGJl
Zm9yZSBzZW5kaW5nIGNtZHEgcGFja2V0cyB0byBzZWN1cmUNCj4gPiA+ID4gPiBjbWRxDQo+ID4g
PiA+ID4gbWFpbGJveCBjaGFubmVsLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IElmIGFueSBvZiBm
YiBnZXQgZnJvbSBjdXJyZW50IGRybV9hdG9taWNfc3RhdGUgaXMgc2VjdXJlLA0KPiA+ID4gPiA+
IHRoZW4NCj4gPiA+ID4gPiBjcnRjDQo+ID4gPiA+ID4gd2lsbCBzd2l0Y2ggdG8gdGhlIHNlY3Vy
ZSBmbG93IHRvIGNvbmZpZ3VyZSBkaXNwbGF5IEhXLg0KPiA+ID4gPiA+IElmIGFsbCBmYnMgYXJl
IG5vdCBzZWN1cmUgaW4gY3VycmVudCBkcm1fYXRvbWljX3N0YXRlLCB0aGVuDQo+ID4gPiA+ID4g
Y3J0Yw0KPiA+ID4gPiA+IHdpbGwNCj4gPiA+ID4gPiBzd2l0Y2ggdG8gdGhlIG5vcm1hbCBmbG93
Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFz
b24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiAgZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jICB8IDI3Mg0KPiA+ID4gPiA+ICsrKysr
KysrKysrKysrKysrKysrKystDQo+ID4gPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX2NydGMuaCAgfCAgIDEgKw0KPiA+ID4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RybV9wbGFuZS5jIHwgICA3ICsNCj4gPiA+ID4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAy
NjkgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+ID4gPiA+ID4gDQo+ID4gDQo+ID4g
W3NuaXBdDQo+ID4gDQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsjaWYgSVNfUkVBQ0hBQkxFKENP
TkZJR19NVEtfQ01EUSkNCj4gPiA+ID4gPiArc3RhdGljIHZvaWQgbXRrX2NydGNfZW5hYmxlX3Nl
Y3VyZV9zdGF0ZShzdHJ1Y3QgZHJtX2NydGMNCj4gPiA+ID4gPiAqY3J0YykNCj4gPiA+ID4gPiAr
ew0KPiA+ID4gPiA+ICsJZW51bSBjbWRxX3NlY19zY2VuYXJpbyBzZWNfc2NuID0gQ01EUV9NQVhf
U0VDX0NPVU5UOw0KPiA+ID4gPiA+ICsJaW50IGk7DQo+ID4gPiA+ID4gKwlzdHJ1Y3QgbXRrX2Rk
cF9jb21wICpkZHBfZmlyc3RfY29tcDsNCj4gPiA+ID4gPiArCXN0cnVjdCBtdGtfZHJtX2NydGMg
Km10a19jcnRjID0gdG9fbXRrX2NydGMoY3J0Yyk7DQo+ID4gPiA+ID4gKwl1NjQgc2VjX2VuZ2lu
ZSA9IDA7IC8qIGZvciBodyBlbmdpbmUgd3JpdGUgb3V0cHV0DQo+ID4gPiA+ID4gc2VjdXJlIGZi
ICovDQo+ID4gPiA+ID4gKwl1NjQgc2VjX3BvcnQgPSAwOyAvKiBmb3IgbGFyYiBwb3J0IHJlYWQg
aW5wdXQgc2VjdXJlIGZiDQo+ID4gPiA+ID4gKi8NCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKwlj
bWRxX3BrdF93ZmUoJm10a19jcnRjLT5zZWNfY21kcV9oYW5kbGUsIG10a19jcnRjLQ0KPiA+ID4g
PiA+ID4gY21kcV9ldmVudCwNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBmYWxzZSk7DQo+ID4gPiA+
ID4gKw0KPiA+ID4gPiA+ICsJZGRwX2ZpcnN0X2NvbXAgPSBtdGtfY3J0Yy0+ZGRwX2NvbXBbMF07
DQo+ID4gPiA+ID4gKwlmb3IgKGkgPSAwOyBpIDwgbXRrX2NydGMtPmxheWVyX25yOyBpKyspDQo+
ID4gPiA+ID4gKwkJaWYgKG10a19jcnRjLT5wbGFuZXNbaV0udHlwZSA9PQ0KPiA+ID4gPiA+IERS
TV9QTEFORV9UWVBFX0NVUlNPUikNCj4gPiA+ID4gPiArCQkJc2VjX3BvcnQgfD0NCj4gPiA+ID4g
PiBtdGtfZGRwX2NvbXBfbGF5ZXJfZ2V0X3NlY19wb3J0KGRkcF9maXJzdF9jb21wLCBpKTsNCj4g
PiA+ID4gPiArDQo+ID4gPiA+ID4gKwlpZiAoZHJtX2NydGNfaW5kZXgoY3J0YykgPT0gMCkNCj4g
PiA+ID4gPiArCQlzZWNfc2NuID0gQ01EUV9TRUNfUFJJTUFSWV9ESVNQOw0KPiA+ID4gPiA+ICsJ
ZWxzZSBpZiAoZHJtX2NydGNfaW5kZXgoY3J0YykgPT0gMSkNCj4gPiA+ID4gPiArCQlzZWNfc2Nu
ID0gQ01EUV9TRUNfU1VCX0RJU1A7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsJY21kcV9zZWNf
cGt0X3NldF9kYXRhKCZtdGtfY3J0Yy0+c2VjX2NtZHFfaGFuZGxlLA0KPiA+ID4gPiA+IHNlY19l
bmdpbmUsDQo+ID4gPiA+ID4gc2VjX3BvcnQsIHNlY19zY24pOw0KPiA+ID4gPiANCj4gPiA+ID4g
SW4gY21kcSBkcml2ZXIsIHNlY19lbmdpbmUgbWVhbnMgZW5naW5lIHdoaWNoIG5lZWQgZGFwYy4g
WW91DQo+ID4gPiA+IHNldA0KPiA+ID4gPiAwDQo+ID4gPiA+IHRvDQo+ID4gPiA+IHNlY19lbmdp
bmUsIGRvZXMgaXQgbWVhbiB0aGF0IG5vIGVuZ2luZSBpcyBwcm90ZWN0ZWQgYnkgZGFwYz8NCj4g
PiA+ID4gSWYNCj4gPiA+ID4gT1ZMDQo+ID4gPiA+IGlzDQo+ID4gPiA+IG5vdCBwcm90ZWN0ZWQg
YnkgZGFwYywgSSB0aGluayB3ZSBjb3VsZCB1c2UgY21kcSBub3JtYWwgdGhyZWFkDQo+ID4gPiA+
IHRvDQo+ID4gPiA+IHdyaXRlDQo+ID4gPiA+IE9WTCByZWdpc3RlciBpbnN0ZWFkIG9mIGNtZHEg
c2VjdXJlIHRocmVhZC4NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IFdlIGVuYWJsZSBEUEFDIHBy
b3RlY3Rpb24gZm9yIHRoZSBlbmdpbmUgdGhhdCBpcyBhYmxlIHRvIHdyaXRlDQo+ID4gPiBkYXRh
DQo+ID4gPiB0bw0KPiA+ID4gdGhlIERSQU0gYWRkcmVzcyBzZXQgb24gdGhlaXIgcmVnaXN0ZXIs
IHN1Y2ggYXMgV0RNQSBhbmQgV1JPVCwgdG8NCj4gPiA+IGF2b2lkDQo+ID4gPiB0aGVpciByZWdp
c3RlciBiZWluZyBzZXQgdG8gdGhlIG5vcm1hbCBEUkFNIGFkZHJlc3MuDQo+ID4gPiANCj4gPiA+
IFdlIGVuYWJsZSBsYXJiIHBvcnQgcHJvdGVjdGlvbiBmb3IgdGhlIGVuZ2luZSB0aGF0IGlzIGFi
bGUgdG8NCj4gPiA+IHJlYWQNCj4gPiA+IGRhdGENCj4gPiA+IGZyb20gdGhlIERSQU0gYWRkcmVz
cywgc3VjaCBhcyBPVkwsIFJETUEgYW5kIE1EUF9SRE1BLCB0byBhdm9pZA0KPiA+ID4gc2VjdXJl
DQo+ID4gPiBEUkFNIGJlaW5nIHJlYWQgYnkgdGhlIG5vbi1zZWN1cmUgbGFyYiBwb3J0LiBTbyB3
ZSBkb24ndCBuZWVkDQo+ID4gPiB0b2VuYWJsZQ0KPiA+ID4gREFQQyBmb3IgdGhlc2UgZW5naW5l
cy4NCj4gPiA+IA0KPiA+ID4gTm8gbWF0ZXIgREFQQyBwcm90ZWN0aW9uIG9yIGxhcmIgcG9ydCBw
cm90ZWN0aW9uLCB0aGV5IGJvdGggbmVlZA0KPiA+ID4gdG8NCj4gPiA+IHVzZQ0KPiA+ID4gc2Vj
X2VuZ2luZSB0byB0ZWxsIFRFRSB3aGljaCBlbmdpbmVzIG5lZWQgdG8gYmUgcHJvdGVjdGVkLg0K
PiA+ID4gDQo+ID4gPiBCdXQgT1ZMIGlzIGEgc3BlY2lhbCBIVyBlbmdpbmUsIGl0IGNhbiBvbmx5
IHNldCBpdHMNCj4gPiA+IERJU1BfUkVHX09WTF9TRUNVUkUNCj4gPiA+IHJlZ2lzdGVyIGluIFtQ
QVRDSCB2MiAwNy8xMV0gdG8gZW5hYmxlIGl0cyBsYXJiIHBvcnQgcHJvdGVjdGlvbiwNCj4gPiA+
IHNvDQo+ID4gPiBPVkwNCj4gPiA+IG5vIG5lZWQgdG8gc2V0IHRoZSBzZWNfZW5naW5lLiBCdXQg
d2UnbGwgbW92ZSB0aGF0IHBhcnQgdG8gdGhlDQo+ID4gPiBURUUNCj4gPiA+IHNlY3VyZSB3b3Js
ZCwgc28gdGhhdCBtZWFucyBPVkwgc2VjX2VuZ2luZSB3aWxsIGJlIHNldCBoZXJlIGluDQo+ID4g
PiB0aGUNCj4gPiA+IG5leHQNCj4gPiA+IHZlcnNpb24uDQo+ID4gPiANCj4gPiA+ID4gSXQncyB3
ZWlyZCB0aGF0IG5vcm1hbCB3b3JsZCBjb3VsZCBkZWNpZGUgd2hpY2ggZW5naW5lIGlzDQo+ID4g
PiA+IHByb3RlY3RlZA0KPiA+ID4gPiBieQ0KPiA+ID4gPiBkYXBjLiBJZiBoYWNrZXIgc2V0IDAg
Zm9yIG91dHB1dCBlbmdpbmUsIHRoZW4gb3V0b3V0IGVuZ2luZQ0KPiA+ID4gPiB3b3VsZA0KPiA+
ID4gPiBub3QNCj4gPiA+ID4gYmUgcHJvdGVjdGVkPw0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4g
SWYgaGFja2VyIHNldCAwIGZvciBvdXRwdXQgZW5naW5lLCBURUUgd29ybGQgd2lsbCBjaGVjayB0
aGF0DQo+ID4gPiBvdXRwdXQNCj4gPiA+IGVuZ2luZSBkaWRuJ3Qgc2V0IHNlY19lbmdpbmUgZnJv
bSBub3JtYWwgd29ybGQgYnkgdmVyaWZ5aW5nDQo+ID4gPiBpbnN0cnVjdGlvbg0KPiA+ID4gd2hl
cmUgdGhlIG91dHB1dCBlbmdpbmUgaW5zdHJ1Y3Rpb24gc2V0IHRoZSBzZWN1cmUgaGFuZGxlLg0K
PiA+ID4gDQo+ID4gPiBXZSBzdGlsbCBuZWVkIHRvIHNldCBzZWNfZW5naW5lIHRvIGNoZWNrIHRo
YXQgYWxsIHRoZSBzZWNfZW5naW5lDQo+ID4gPiBmYWdzDQo+ID4gPiBhcmUgbWF0Y2hlZCB0byB0
aGUgc2NlbmFyaW8gYW5kIGluc3RydWN0aW9uIHZlcmlmaWNhdGlvbiBpbiB0aGUNCj4gPiA+IHNl
Y3VyZQ0KPiA+ID4gd29ybGQuDQo+ID4gDQo+ID4gU28gYWZ0ZXIgc2VjdXJlIHNjZW5hcmlvIGlz
IHNldCwgVEVFIGFscmVhZHkgaGF2ZSBhIHNlY19lbmdpbmUNCj4gPiBsaXN0Lg0KPiA+IExldCdz
IGNhbGwgaXQgVEVFIHNlY19lbmdpbmUgbGlzdC4gQW5kIG5vcm1hbCB3b3JsZCBoYXMgYW5vdGhl
cg0KPiA+IHNlY19lbmdpbmUgbGlzdCwgbGV0J3MgY2FsbCBpdCBub3JtYWwgc2VjX2VuZ2luZSBs
aXN0LiBOb3JtYWwgd29ybGQNCj4gPiBwYXNzIG5vcm1hbCBzZWNfZW5naW5lIGxpc3QgdG8gVEVF
IGJ5IGNtZHFfc2VjX3BrdF9zZXRfZGF0YSgpIGFuZA0KPiA+IFRFRQ0KPiA+IHdvdWxkIGNoZWNr
IG5vcm1hbCBzZWNfZW5naW5lIGxpc3QgaXMgaWRlbnRpY2FsIHRvIFRFRSBzZWNfZW5naW5lDQo+
ID4gbGlzdA0KPiA+IG9yIG5vdC4gSWYgVEVFIGFscmVhZHkgaGF2ZSBhIFRFRSBzZWNfZW5naW5l
IGxpc3QsIEkgdGhpbmsgaXQncyBub3QNCj4gPiBuZWNlc3NhcnkgdGhhdCBub3JtYWwgd29ybGQg
aGF2ZSBhbm90aGVyIG5vcm1hbCBzZWNfZW5naW5lIGxpc3QuIFNvDQo+ID4gZHJvcCB0aGlzIG5v
cm1hbCBzZWNfZW5naW5lIGxpc3QgcGFyYW1ldGVyLg0KPiA+IA0KPiANCj4gVGhlIFRFRSBzZWNf
ZW5naW5lIGxpc3QgaXMgYWxpZ24gdG8gdGhlIHNlY19lbmdpbmUgbGlzdCBpbiBub3JtYWwNCj4g
d29ybGQuIEkgdGhpbmsgdGhlIHNlY19lbmdpbmUgZm9yIERBUEMgY2FuIGJlIGRyb3BwZWQgYW5k
IGl0IGNhbiBiZQ0KPiBlbmFibGVkL2Rpc2FibGVkIGJ5IHRoZSBURUUgc2VjX2VuZ2luZSwgYnV0
IHRoZSBzZWNfZW5naW5lIGZvciBsYXJiDQo+IHBvcnQgd29uJ3QgZG8gdGhhdCB2ZXJpZmljYXRp
b24gaW4gdGhlIHNlY3VyZSB3b3JsZC4gSWYgc2VjX2VuZ2luZQ0KPiBmb3INCj4gbGFyYiBwb3J0
IGlzIG5vdCBzZXQgaW4gbm9ybWFsIHdvcmxkLCBpdCdsbCBjYXVzZSBpb3ZhIHRyYW5zbGF0aW9u
DQo+IGZhdWx0LiBTbyB3ZSBzdGlsbCBuZWVkIHRoaXMgc2VjX2VuZ2luZSBmb3IgbGFyYiBwb3J0
Lg0KDQpJbiBURUUsIHRoZXJlIGlzIGFscmVhZHkgYSBURUUgc2VjX2VuZ2luZSBsaXN0LCBzbyBj
aGVja2luZyBsYXJiIHBvcnQNCmNvdWxkIHVzZSBURUUgc2VjX2VuZ2luZSBsaXN0IGJlY2F1c2Ug
VEVFIHNlY19lbmdpbmUgbGlzdCB3b3VsZCBiZQ0KaWRlbnRpY2FsIHRvIG5vcm1hbCBzZWNfZW5n
aW5lIGxpc3QuIFdoeSBub3QgdXNlIFRFRSBzZWNfZW5naW5lIGxpc3QgdG8NCmNoZWNrIGxhcmIg
cG9ydD8gV2hhdCBpcyB0aGUgZGV0YWlsIG9mIGNoZWNraW5nIGxhcmIgcG9ydD8gRGVzY3JpYmUg
aXQNCmlmIG5lY2Vzc2FyeS4NCg0KUmVnYXJkcywNCkNLDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IEph
c29uLUpILkxpbg0KPiANCj4gPiBSZWdhcmRzLA0KPiA+IENLDQo+ID4gDQo+ID4gPiANCj4gPiA+
IFJlZ2FyZHMsDQo+ID4gPiBKYXNvbi1KSC5MaW4NCj4gPiA+IA0KPiA+ID4gPiBSZWdhcmRzLA0K
PiA+ID4gPiBDSw0KPiA+ID4gPiANCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKwlwcl9kZWJ1Zygi
Y3J0Yy0lZCBlbmFibGUgc2VjdXJlIHBsYW5lIVxuIiwNCj4gPiA+ID4gPiBkcm1fY3J0Y19pbmRl
eChjcnRjKSk7DQo+ID4gPiA+ID4gK30NCj4gPiA+ID4gPiArI2VuZGlmDQo+ID4gPiA+ID4gDQo=

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582DE7B4B3C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 07:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbjJBFxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 01:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJBFxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 01:53:40 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C63A9B;
        Sun,  1 Oct 2023 22:53:30 -0700 (PDT)
X-UUID: ff3d11d860e711ee8051498923ad61e6-20231002
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=+D6Gfan+4Fnk/u3318vc/uImr7UXdUn6chUvNne6OhU=;
        b=ppawn8gcjPnUfUQWgB8jMiH4M2zQCwoYf8k0iVTK88BcC0CqNf19Q7fTwUfi7sR57Gk56sh4rYzG6aZRwZ9forGjYGhy33OuU/acPnrm9UFA0KxlqPUG7GARRiTMjpFx50pHI+WCenjACOrdmPDotbXajTPa8b+LVL1jyKrKLzA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:f26faf93-2540-4381-adb6-6ded7c25a21b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:da1a57f0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ff3d11d860e711ee8051498923ad61e6-20231002
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1724392402; Mon, 02 Oct 2023 13:53:23 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 2 Oct 2023 13:53:21 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 2 Oct 2023 13:53:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngpiWpR+MS0zmTfEbmYbKqNGKeQpr5vYTaziYuIbUzFkQpOXz17unoZR+LqgfS168Zp3mvB6eg6UfyYI+8pLle9y1Vq6b0GRqHf1IL5JD3jMbpaMKUq7qr/S67dNDLS5nSFTL2H6qbQ/UDNHa463eZG+A1LD4ybGi7mvh69LQz8mi8GgTyMYr7WhKOMI03D1BW+AT7ZnT6+8HUwVG0P+U/zOcKzqJYl/Yi0xnH2TPAt9TVjegVJJYjIS9heoi7ZtGz9+Ym5uPio1dvP4kyxP+2/+CcxPZjC5m8UHNbBY6P6L1Y3raCpOQVyzq4XSnOASfLbLYc5J8CTi1LqQTtWDJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+D6Gfan+4Fnk/u3318vc/uImr7UXdUn6chUvNne6OhU=;
 b=XUnzFRpd5xv55bX6Ez06UeDi0mc5MLHHY2EYSk20B921RCjHWEthzS1NbMELsAlyOZx40OZWI8BJ0AisNLt689f03xyb7bAePJsxqO5toE7lPbASocI9JlCfP4lxqyx2QQF+diw4pWD7V0j+vpFvz6HffBfy+i6kbDI/NavgikmErASvdeklvpJC9kk2VL66QqRHX7uwWNqAGoj6UMSzvcoxhRgNM4W1bUCGCZGDGI2Keo3au0JHblntYOwr35pIGzrTSlblg8HSmoffMU5u7G8I/fVis0Vzi18X4y+8mVUeYo/uZDbk+Tv1Z9FsOv/M0LQ9196/TFoLYqDlxEh3ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+D6Gfan+4Fnk/u3318vc/uImr7UXdUn6chUvNne6OhU=;
 b=Oaq9fDJFqsCM1P/U+W68HMD091yRsV2xymrQJ51SVjL8pp5VHM7KxdSI4c1pcyorwBq04kfv98NAI7QVOKgZ0OujmEa5gNaZPcunZWi3/WjW1WaAu3I1IvSVK+cA7zhf9nKtV6RW6zBPcJsQAJeJBP8Fvddm/8GxbqENDrDRuU0=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by SEZPR03MB7196.apcprd03.prod.outlook.com (2603:1096:101:e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 2 Oct
 2023 05:53:18 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::96c:e99d:e17d:7188]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::96c:e99d:e17d:7188%5]) with mapi id 15.20.6838.024; Mon, 2 Oct 2023
 05:53:18 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "xiazhengqiao@huaqin.corp-partner.google.com" 
        <xiazhengqiao@huaqin.corp-partner.google.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "patchwork-bot@kernel.org" <patchwork-bot@kernel.org>
Subject: Re: [v3 2/2] ASoC: mediatek: mt8188-mt6359: add rt5682s support
Thread-Topic: [v3 2/2] ASoC: mediatek: mt8188-mt6359: add rt5682s support
Thread-Index: AQHZ8PPaRXb5MI3RFkK4BOxcB44uybA2B5KA
Date:   Mon, 2 Oct 2023 05:53:18 +0000
Message-ID: <0b785e9b4202f036a22871732be97d491e52e78f.camel@mediatek.com>
References: <20230927033608.16920-1-xiazhengqiao@huaqin.corp-partner.google.com>
         <20230927033608.16920-3-xiazhengqiao@huaqin.corp-partner.google.com>
In-Reply-To: <20230927033608.16920-3-xiazhengqiao@huaqin.corp-partner.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|SEZPR03MB7196:EE_
x-ms-office365-filtering-correlation-id: c3fa013a-b17d-4ebc-2e8b-08dbc30be0e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PK1nbPSmFyMjxQdZI8F1puuiZaxP3BJXop149r2ZfOKjeUkcOoajN8x38m/WlMQCtpuBKkXqfzWNnngRL233K7h9ADqyHKs3fIipkFApTIKw3mW8U+5NShgIHiJvMb+QlXWv0NzUmGrWah0q1oUts8cXUSzrYEbgVgSR9I4vDkOsCLreMIKr9RRSpY0hWN/Zka2jWL2Ngpbfwo7RXmglLHUx1tQbbZ8mRvuobQIz08lx26XZtekwlf0Ar6zNAm3IzpRIAQkUqNCf81Ax6nke7sFYsuZ5ad4wHWZ8KN5UYbRcJNvYl4z1e/v1dJfIhXcDSUV9BhH2FUKxnCWCHrxu4UrpRk2AtyFgu0/CMBBRSelhn2+TYaxG5g2z0oazt2uZf4Sw4Gmn0lv9OmggVipO8k6XiecX7x3e70kR/xZQMxb0RFpC7Y4S+ZE5psY2EZH/ED9gzwK93DEvdb+cHH9qj6jWQe6mMd9v6q75UQMRb5lKA3pWg7j0sC8wJhi67yknyRNJW/TWqpiHCh4jxe49ELoco2Y2B1tieQ4iZ2u1S3KVwuYAMthW2PzzqSa1Rh3/U4CbZc8s0CVbcEjlP8JgosIG0G6fD+4gSOzuhP8ZJX7XrEVkShj0so9JTLOfs+Tp8O98No74gV0Bh8+3UEZZeDpeya1+e9zwWSXdHaoUYhFpwg2iIcFNTnf7AHzANEOq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(136003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(6506007)(6486002)(6512007)(36756003)(86362001)(8936002)(5660300002)(41300700001)(85182001)(76116006)(71200400001)(8676002)(478600001)(122000001)(38100700002)(38070700005)(66946007)(316002)(26005)(83380400001)(66446008)(64756008)(66556008)(2616005)(4744005)(66476007)(110136005)(2906002)(91956017)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dk1pQnVrREhib2c3bWUzVjJqVVorSEdEUU5pV2NZT1NTNWJwa2FnYUNRSVBa?=
 =?utf-8?B?eTBzVGdEMzhJTzVtSWluOGpQOE5FZ21xbjAxQXBpVTcyQnlpMFVLZ1FlRjVK?=
 =?utf-8?B?RVR5K1hMKzdtUkhRMldTZEQvdURqQnA4QUpCaTl6Ulp3end6Q0dZU25EaG41?=
 =?utf-8?B?UnNHNkl1aGt2Tjk1TC9uYzkxT00yYkJmWm0zbmxQa1hlZ3R5UUlSYnJ2Mzl1?=
 =?utf-8?B?R3liajh4OTI3bWpmbnlrSkp5Z2dwaXV4NCtZUy95TEtlaTZEWUNBSFpLVVZ6?=
 =?utf-8?B?b3VWVVFRV2pucDQ3eGtvQy9GTWpaYzd4cyt4TmRlN3hzL2RQamp3MzVkRUNu?=
 =?utf-8?B?UldQVlJTTGFZTysraXhUY1lnbG40ZWdkNG9VallYK0dESnJEQks5RGJVQlJy?=
 =?utf-8?B?Ni8yemw0a2JUT29aNXdqVFdJbkJYeUdpZ0lpdlBtdlRqMGhGN2VISzB6RTQ3?=
 =?utf-8?B?R0hIaHRWMmJzSldhdU90QUFCdStvdVp3YkpWaGVaRWFvalBHRTlrQVBUU1hF?=
 =?utf-8?B?bnp4eVo0emFDVWdGRjhhM2l2RTJ2d0xlSmJtclJwQmpJZXlyUW1MWEZlNWow?=
 =?utf-8?B?WkE1TGFPbDF1QkxuZGpNdG1sUjJjc2lLYlBUVngyM3pGRUMydGh2VnJQRU9o?=
 =?utf-8?B?VG9YQjhyV3F5d0tRRFoxRUY1WkxVTnkwM0pnUUxjQjVHMkFabDc3OXk4a09Z?=
 =?utf-8?B?R2QzZ3phU0RWL2dsTlRTVjhMVDZKMWpaN3J3ZVdNSk8yQTJMeGtmZlNjNndG?=
 =?utf-8?B?V0lPQTJpSmE3T2dod1lkU3Bya05HamJ5VmxDRDYvT1o4THFkaVllTDczSGxC?=
 =?utf-8?B?QlhuTDR4VEpGeHRPWXZ3cTVha3JpUEhVQjNlQ2YyWFpYUTZFKzZGY1NlTmx5?=
 =?utf-8?B?UHRxUUtPdjArSGdKa2I4Rm45MEdPM3BUbE5iWjkyK25wV2s5VzZBdmlMcnhJ?=
 =?utf-8?B?dDVlRFRQcGJHeU5zeFRqWUNUOXg4ZTIrV1d2T3dOUlZKK1lWdDlGTmtwUTZw?=
 =?utf-8?B?b05Dd2JTNURhQ2RybjlTNGFmUVNReFREZ1ZyYlFISndOdmdLWGJTVEU2UHFG?=
 =?utf-8?B?MG9NTm1DOWsxdTJwS1piU2NuNUpmTzhQMStkMCtuTDBYYkZ6UEQxd2k3cC80?=
 =?utf-8?B?eFlvMzdJMTNCcUlmSVJTYVVpZmxyRHlpdlEwWTVxa2dsOVBlWmZ5T1VJSWwz?=
 =?utf-8?B?cGJ6bDdwNUlhOTZxNjF1c0pobEYvb09qK3Z6MFBYdStMb3UzNGo2Rm9pN2hD?=
 =?utf-8?B?Q084Ui9EY3pMakQ4TEpYREFNcmlIRzA5b2wrNGt6UFl6M2RobVJCbnorMlZ3?=
 =?utf-8?B?YTNPb3d0S1VBbWl3bUxjeS9YT0lxMDFZRk5kNExDR1FYanY4SE5QNm5pcTVS?=
 =?utf-8?B?M0pubmFQY3M2RmFkVUFZN293M3A5UkorNkJ1M3p2MUZvdkxQY2Q4NUpNS0Fm?=
 =?utf-8?B?VGlxaEFxdUdtL3JNMm04V1B2RDRHU21RSEsxYm1QRHVnemNtYkFOL0Y1MHFI?=
 =?utf-8?B?ZXdlMmFtbUZtTHJ5eUI4U2duTjE0Y1FtcjFoMVdQMmQvcHZKSSs4MHpyL0Rj?=
 =?utf-8?B?cEJsSVV4eVNYZWhZUzBpbGFuV0NFeTRtaUNBQmNodjg1OTlDR3hCZjg1UU5X?=
 =?utf-8?B?d1RHbTZSc2I3N3hqWVZ6RzB3YWRXU3h3eTlJWkxiUjJDRWdYb0w2OHZkeENh?=
 =?utf-8?B?UkU0Qm5MODNMbjFyeUtUWkd2YTJybjN1UzlTYi84bklsTU9pazFRaFpwdXhH?=
 =?utf-8?B?a25iaGJST2NUQitpdC9NdXBRU0c4YTFaNjVBUldndC90UlhFVlJ3UzVlTGpj?=
 =?utf-8?B?OEN0RTVUNTF5UXZWLzhIYVgvYVExbHdrYTN4YlU2QXNzL29WN0NQRXN3SVkz?=
 =?utf-8?B?djd2RHUzRlNQVDg1cE1rR0h5dUIzNFNPeGlhQlRNVUpqY1l4eGtCUU9NSTg1?=
 =?utf-8?B?bFZMR2U4c0ExR2pFbm1iNlJxRG1hOHZDalNlY0cwSUFyb0ZuMG9XMGk0bzJj?=
 =?utf-8?B?UmxvWEZYU2RiaGxqTVk0SGtDMW53ZzJiQ0Myekhxa2drNFBVUEhqZWRCRWNi?=
 =?utf-8?B?YXN2bXZ2SVNobWZuWHp1ZXFtRk9DL0VpSDJGR1A0ODZxNytSV00remt2R0RH?=
 =?utf-8?B?a3Q0WEcweXVwbkgvTGNKZlE4UXVzK2kzbllEd2tyT1hZQlVIc0xSR3BCMDFW?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30673BF0E48EC54A9DDA499C0376A588@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3fa013a-b17d-4ebc-2e8b-08dbc30be0e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 05:53:18.8096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JnwSHn9G7LdwQ5UUujrB/v1BszdJB+PDKTB9HR6vlI9qXcX0Rt7OgD7+ZG0a6Sz2uKyjDEvNIKTUEnGWX4AsZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7196
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.595300-8.000000
X-TMASE-MatchedRID: w2TFuZOvAtfUL3YCMmnG4ia1MaKuob8PC/ExpXrHizz4JyR+b5tvoMgl
        TPF0eWzKX3E2fHKxS5LMFlY9U6tWdV/ag3kgZsCOY1bQMCMvmn4g0L4Xy2OHlZtqp/Uv362UvC5
        eXolum5l0DMGA1irP0JVtcs28Aji2QgUInkqQBs+eAiCmPx4NwMFrpUbb72MUO5QxsrU10s/6C0
        ePs7A07Y6HM5rqDwqtAT4ISh+OyjnoG9hUV38tXJa4bVk4MgUwRWSiUgMkU8nfeOd3UW4LRekM7
        TlEtLVGdNhG4ajlFfqyB6NKrKCb6YR06/gMc/vD6zisC/T8PqpoAj/I71a0LPe/cZ4cIg+4gCxB
        xmEywZ1cO/Qwydjk3g==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.595300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 19FF9E4F64866B966545FD0E85BC94F01A6662BE9EB1C58303756DEAADD472612000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA5LTI3IGF0IDExOjM2ICswODAwLCB4aWF6aGVuZ3FpYW8gd3JvdGU6DQo+
ICBUbyB1c2UgUlQ1NjgyUyBhcyB0aGUgY29kZWMgYW5kIE1BWDk4MzkwIGFzIHRoZSBhbXAsIGFk
ZCBhIG5ldw0KPiBzb3VuZCBjYXJkIG5hbWVkIG10ODE4OF9ydDU2ODJzLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogeGlhemhlbmdxaWFvIDwNCj4geGlhemhlbmdxaWFvQGh1YXFpbi5jb3JwLXBhcnRu
ZXIuZ29vZ2xlLmNvbT4NCj4gLS0tDQo+ICBzb3VuZC9zb2MvbWVkaWF0ZWsvS2NvbmZpZyAgICAg
ICAgICAgICAgICB8ICAgMSArDQo+ICBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTg4L210ODE4OC1t
dDYzNTkuYyB8IDE0MQ0KPiArKysrKysrKysrKysrKysrKysrKystDQo+ICAyIGZpbGVzIGNoYW5n
ZWQsIDE0MCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gDQoNCg0KUmV2aWV3
ZWQtYnk6IFRyZXZvciBXdSA8dHJldm9yLnd1QG1lZGlhdGVrLmNvbT4NCg0KDQpIb3dldmVyLCBJ
IG5vdGljZWQgdGhhdCB5b3UgZGlkbid0IGluY2x1ZGUgTWVkaWFUZWsgbWFpbnRhaW5lciBhbmQN
CnJldmlld2VyIGluIHlvdXIgc2VyaWVzLiBIZXJlIGlzIGEgc25pcHBldCBvZiBpbmZvcm1hdGlv
biBnZW5lcmF0ZWQgYnkNCnRoZSBnZXRfbWFpbnRhaW5lciBzY3JpcHQuDQoNCk1hdHRoaWFzIEJy
dWdnZXIgPG1hdHRoaWFzLmJnZ0BnbWFpbC5jb20+IChtYWludGFpbmVyOkFSTS9NZWRpYXRlayBT
b0MNCnN1cHBvcnQpDQpBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGlu
by5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KKHJldmlld2VyOkFSTS9NZWRpYXRlayBTb0MNCnN1
cHBvcnQsY29tbWl0X3NpZ25lcjo0LzEwPTQwJSxhdXRob3JlZDoxLzEwPTEwJSxyZW1vdmVkX2xp
bmVzOjM1LzY1PTU0DQolKQ0KDQoNClRoYW5rcywNClRyZXZvcg0K

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937DA7E18FC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 03:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjKFCyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 21:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjKFCy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 21:54:29 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3269AEE;
        Sun,  5 Nov 2023 18:54:19 -0800 (PST)
X-UUID: c2b07d807c4f11ee8051498923ad61e6-20231106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=7gK+3gjehQs6hHx5vQXrktA4D0H/ypSjy9XOBezE8pk=;
        b=MatBKvK1dsrzXzsWE6H0XQmjllstl62+LwE2897IrV//7Zlmk4Zos9DdwviIXKJi9tzrM0opFhAX7mVyPid0eFyCdjNmqzy52xUAomSZxqLknVhpRGM5Z4hMBJA+8u3bFQAlsLOlmVm7eF9lZ97xDGCE08mFkhI6+rWGNXB2ttM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:d42167d6-e9ff-40e3-8d8d-0685a3f55db5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:87f00b95-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c2b07d807c4f11ee8051498923ad61e6-20231106
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1453399885; Mon, 06 Nov 2023 10:54:10 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 6 Nov 2023 10:54:09 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 6 Nov 2023 10:54:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4Nw2ZK6Yzy2NTjMh589Y2KghUtafsXO94Okakt3HJgeSexxCP7u9xqHjtYjTttIRRbKqQIL4iN9psvGdCcJ+KAsPMm+X0EiVbUbB82lxZFtjQOUeXAvPbXL6+xRmEtgRNZ0dnQRoMdauVRPPw3BQ9tKc8JTjIKMpQLKE/E0rXy/bkNmx7hkKJPIlOoXUKg/xNDqHrlho7fQR8PM6GXTN7KEK3BeyjeuOOUajSH4OntcgPdpRU7MD/zHDmutcni+qYevX4Ol8lV4s+j3I4S6R1kXWVnEP1bvIhIuXSoORGZvocR2txMwSTPo3cXVENAj1wfl5FIdN0G4H3Qmuqc+kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gK+3gjehQs6hHx5vQXrktA4D0H/ypSjy9XOBezE8pk=;
 b=e8PV2Bf6ETdG2HdNl1P87e1uJgUvgiRn8gjaJIgV5vuoZAstwYILv2IaKJBWYUOh9rLAfq2Fq4YhFNTFmpN6M6GcIqwOYx3FoNdrami1lK5Puvht7YRiJ2NyXX4p0+PFVeABfg16zIzUhw4fiGsXTwBN//wEvjdg4r3raogrA7ON+32HYe1GfgFroygC7EsvpcsmlYgO2tc0kQxHABkx4yZfq/gZ1agHzCI/r9vGVGJ/+IW/aTp8z6r6ehjXejgTkWjD53oPRolG1EWk2NtkhhwFdv/iQwImcczvx2CT+3e30OuM6w+JPFKK6gcoqUFlPQme1WcBqRr+dRum7cK1hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gK+3gjehQs6hHx5vQXrktA4D0H/ypSjy9XOBezE8pk=;
 b=GsYkSGl3tj2edlzJUDWy62MDCJY8hTqf6TzCbAQUq4m+r2JHmaQ+sokg8ygkjvnckmEXd3pnZCjQkAfaD27rN58HpFEZACGkLMCNTDmcUIgzCq9csGqHfGgtWYjztKjGrb7TDdHgCZ/NEqW3Zv6HsB7AD9OVoxu3UNbjHzMecCg=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by KL1PR03MB5890.apcprd03.prod.outlook.com (2603:1096:820:80::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 02:51:04 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88%5]) with mapi id 15.20.6954.025; Mon, 6 Nov 2023
 02:51:04 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
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
Subject: Re: [PATCH v2 07/11] drm/mediatek: Add secure layer config support
 for ovl
Thread-Topic: [PATCH v2 07/11] drm/mediatek: Add secure layer config support
 for ovl
Thread-Index: AQHaBWvoijbhEc/R00mY51hFdbW5LrBb3XkAgA/s8ICAAM1cAIAAFYyA
Date:   Mon, 6 Nov 2023 02:51:04 +0000
Message-ID: <8551feb3d3e9dc7fa79b48a772655663125c1b74.camel@mediatek.com>
References: <20231023044549.21412-1-jason-jh.lin@mediatek.com>
         <20231023044549.21412-8-jason-jh.lin@mediatek.com>
         <3af3f0919045e806b7cc2c36fb99bff8918f874e.camel@mediatek.com>
         <966e530d745c128f299e67b5bcd2437f5f313ec8.camel@mediatek.com>
         <a33a28a785aa207cdbf301f2b0666bbef3783fa5.camel@mediatek.com>
In-Reply-To: <a33a28a785aa207cdbf301f2b0666bbef3783fa5.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|KL1PR03MB5890:EE_
x-ms-office365-filtering-correlation-id: eca08009-f6d4-484b-8884-08dbde7337fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zRBB59fraXrR4ZLFc8zr7DlG6cSPgg49n9DTWYQKN+2xFaxGyn67RPe97UGejaFWtypY8DI+flYloSEaELtWLAcAsbRn32oXuGTrHUiUnZUzERLRrAv6f38YgM8Hs08q9DQ8J+0iQtlU3l+/rL+wt+kDHGaoYQb5Q6kjyFNE3sRzev59I4PyfzDZ3FzEpIRuZAICJb0UJ3ssVMLdECUsPqS/uJKuIsNfnt45q4+Og6k5QT44BUdWvaIpZUB/nHSEUfqVy4agx2JXdVQXN1KeOH2U1KeNtBnlXgnCjj5wxFCDKLiPrI8J4rMNiBWw9voY8Z+fX4nRt6MLs7r6UlX59WSoERPIjhrneiOkb/vqNDNM1U0NdsNtTjbUCunCxXcKtgh3lvf/c6bkB8udAlaIFXfYPNSs0l/0eTtFvtmsfrntbn8fgEixV5F8OHB2hN8XF9q165Jwm1NRCdmfcYuHxI0cU5WIzffgc2vLnnvrJfn8290oQNJRUNK8v/oDW2lKcaHEh9Vcn280/WdUxtZLgHvH9cUM3+pkoJSRcCuIbPtUwt+wiQu0NhbITxiDJHgI6RqpcRj1cDtzM+oawSbMFbbCeQiOPfaxZKDZFmWy7golnoo7pS2X8NX9c9ob2t8zTA3sy6+AJPh96srVJh2Hu9WEEYcXnxEuljtwEKZb8Xk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(346002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2616005)(6512007)(6506007)(71200400001)(478600001)(6486002)(38100700002)(36756003)(85182001)(86362001)(122000001)(7416002)(5660300002)(41300700001)(4001150100001)(66446008)(66476007)(66946007)(64756008)(66556008)(83380400001)(76116006)(2906002)(26005)(110136005)(91956017)(316002)(54906003)(8936002)(8676002)(38070700009)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEVZNXM5T2RZNVZKNjhmY1poZmI3VHZobmdZNHZzd2orSXpxSHBrOW5nOW5V?=
 =?utf-8?B?Y29paUhTWXZxR2I1RXFiampEd0p1RUxaV0JNb1JJaEoxVW5ndVh5elhVYk5J?=
 =?utf-8?B?ckpNNTZZNURiR29IMUdoclJjd0pnc0c0bFgxMzErbFQ2MThrWXFoNjlndG5o?=
 =?utf-8?B?R0x4dktPQ2IrUmpxcDNSVlhXellBUVowNUdYN1FDOVBpY2s2NHpBVTF5Ykw4?=
 =?utf-8?B?VzlvWEJJVHYzNU5NRUcxcjN5VjVEajMrRkdqMFRsdDJuUUVSWXFxUFRNM0Q0?=
 =?utf-8?B?MUNPRVZrT1VpTDRHL01oay90eDdOVUNmb3ZhNEhibXJyaVZTdElmdmVvcitM?=
 =?utf-8?B?RmRQNW53VkUxcHZSSUo1UGpWM1FMLzRTdjVYSzlEUkR6YSt5TEQrTUdIbFZQ?=
 =?utf-8?B?NXhDblgrd09uNU12b2FjOE1BSXBwalp4Z0QyTVhWMmxiOU5FRVhUeUgxUUxN?=
 =?utf-8?B?dWh3SzRJOSttaUdzQ2pOdlBRYlBBbEp0dWFhQ0R3V0QweVdoVGxrcXZ4Vzl4?=
 =?utf-8?B?ZHF6OE1QUVo3NWhBSTJBUFBtZXFBMiszM2twazFadDRFd2Qwa0VuWnQ4VUZZ?=
 =?utf-8?B?VmdpWndpS3dsQktlNHNzZVNLdTl5SndMR3NDY1k3Qi9ZVU5hVnRDUWtmazlZ?=
 =?utf-8?B?dW9FbDFSZkF4VW9tZjN4ejQ5VFVaemFWZlE5U0laMm5ka3VJNG1XakJTYXFk?=
 =?utf-8?B?TlU4S1FwTVNxVGZqYkIxbzFEb1JuUDNHR0Fpeng2MGd1UWdOV3RTc2UvOVND?=
 =?utf-8?B?dlFIcWRMOFVEVkZ1dm9ndllNMkZWUnZIZjltcDVKTm0reVQzYzRJMVQ0MUJF?=
 =?utf-8?B?Z200TG1uWGZqWmcrQzRodWNtZHd4R2Y2Vi9CK2lHOWgwZk4yc1J1OVVwQ0Fq?=
 =?utf-8?B?TzYzcFBIWWVTSlFCZEhEekh0OHdYNnVGckNYN3cyWjArVmJqWWVWTDRxak5m?=
 =?utf-8?B?WjN4dXlFdXd1cHFTK1MvQnBXbkptR0NuNUdxWWUxNnYyODVSWDlIWXN5Njls?=
 =?utf-8?B?MlVuRE1LZTIxVzBVMGJrNlVCc2p0STMyK3JqYWRyZFhVREJFdGhNSTBhdXVz?=
 =?utf-8?B?M3BRczA0bUhLZ3RQeTFPQ0kvNER6Y056TWVEOHBlTXV6ZFpvbktndU5Da29R?=
 =?utf-8?B?WkVNajZCWHpkVGkzR2RLL0ZDTXB6YjByelc4L3ptQ0dLbThvb2M0M1p5UG1i?=
 =?utf-8?B?cnlKSG5uSmN1YkJic3BTL1pHWnRBMTNqNVRzaTlBVll1aDRHRGRyQ2UxZy9u?=
 =?utf-8?B?ekMyQ1ArS2VFSkdGSGtCQ3hCbnQybnM0QlFrSVVJRm5lSHFhOGRQcHJwRC8r?=
 =?utf-8?B?Skl4SHlUdWFpU0YvSUI1MW42QzllRHZBNTNNTncxZGVBRkc3Yy9vbHdJbTM5?=
 =?utf-8?B?alRkUmFnM3JRRVVaZFhMZGR3dXZ6cGs0aWNsT3N0VkNiR1VtUVZHTGo5elhV?=
 =?utf-8?B?YW9vZnR6ZkhNZDdUSm1uMWlRaVF1MzliSk9qK3VqQitVTUgydzNrV0NDQ2VT?=
 =?utf-8?B?RWR1ekxIZExNd0RvU0owckk1QXJZYnJJbmNVZytqNDBpV1Rkd2NmOFl4K1R5?=
 =?utf-8?B?UVdxUzM4cDlvOHEwWitVZmVnay9VYTJoeWxzQi8xakhyeVJJUlQvSGxWemVL?=
 =?utf-8?B?MVZwRHVuRTlORzlhSkF6bUpQYUdiSkhFRU9oWmwvbGU5KzdnUWExMFphY0FZ?=
 =?utf-8?B?aEQrbHNJeThnR1dsSXFOVFJnWEtGYVlMZVlOVjh1b0srTnRxQlJUUzlOK3M3?=
 =?utf-8?B?L2hXMGNtVTFsanMxM0IxVlAwVHMrMXN5RzlBeFdGT3BCd0tWYldzQjJKNEVa?=
 =?utf-8?B?dytmTCt4TllXNUdhMExBM3BaZWplWjhwU1dHOGNoTGhPckFFS0VROHZwWlZ4?=
 =?utf-8?B?bGYyK3FjL003VGR4VGhFeDF6blQ3LzNFdjZoZjRpbU1QNUpsUjFMcDN0VUdC?=
 =?utf-8?B?cjJYeS8rTm1SNTR1UFFkUE1BK1VvQjU5NjJFY1VQZGdsOXJjbTJDRFFGQ2Js?=
 =?utf-8?B?UTNEcDFEc1VjcmFmb0trUlRTZkJEc0E3MXRDc0JmUXZiUHMyTmNDNno5ZVVP?=
 =?utf-8?B?LzlaV1p4dFdWNFAxM2lQeTl6dnlNblZQOXlxTndhRndXMHBKL21Ib05UeXBM?=
 =?utf-8?B?ME5ZVWpNelJjVGRQMGQwSi9zeXBVcFJ4VDRJMjdvNndIRC9kd091aW9ZMnJW?=
 =?utf-8?B?K1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC6C85F770773142849EF5F213FD64E0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca08009-f6d4-484b-8884-08dbde7337fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 02:51:04.4899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ntdvODkKmHCY/f+sF1CANHaLqx6Z7jLI2TeAZ9Jpx0kJZ3V9woI8ap5/1nEc70bKgcCI6D49uimSAsCdPTjLQD00BP4n6Dw5gHG2bT8RmKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5890
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTExLTA2IGF0IDAxOjMzICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90
ZToNCj4gT24gU3VuLCAyMDIzLTExLTA1IGF0IDEzOjE4ICswMDAwLCBKYXNvbi1KSCBMaW4gKOae
l+edv+elpSkgd3JvdGU6DQo+ID4gSGkgQ0ssDQo+ID4gDQo+ID4gT24gVGh1LCAyMDIzLTEwLTI2
IGF0IDEwOjA3ICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90ZToNCj4gPiA+IEhpLCBKYXNv
bjoNCj4gPiA+IA0KPiA+ID4gT24gTW9uLCAyMDIzLTEwLTIzIGF0IDEyOjQ1ICswODAwLCBKYXNv
bi1KSC5MaW4gd3JvdGU6DQo+ID4gPiA+IEFkZCBzZWN1cmUgbGF5ZXIgY29uZmlnIHN1cHBvcnQg
Zm9yIG92bC4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8
amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmggICAgICAgfCAgMyArKw0KPiA+ID4gPiAg
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jICAgICAgIHwgMzENCj4gPiA+
ID4gKysrKysrKysrKysrKysrKystLQ0KPiA+ID4gPiAgLi4uL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2Rpc3Bfb3ZsX2FkYXB0b3IuYyAgIHwgMTIgKysrKysrKw0KPiA+ID4gPiAgZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYyAgIHwgIDIgKysNCj4gPiA+ID4gIDQgZmls
ZXMgY2hhbmdlZCwgNDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+ID4gDQo+
ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2
LmgNCj4gPiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4g
PiA+ID4gaW5kZXggMjI1NDAzODUxOWUxLi5kZWM5MzdiMTgzYTggMTAwNjQ0DQo+ID4gPiA+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiA+ID4gPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gPiA+ID4gQEAgLTks
NiArOSw3IEBADQo+ID4gPiA+ICAjaW5jbHVkZSA8bGludXgvc29jL21lZGlhdGVrL210ay1jbWRx
Lmg+DQo+ID4gPiA+ICAjaW5jbHVkZSA8bGludXgvc29jL21lZGlhdGVrL210ay1tbXN5cy5oPg0K
PiA+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L3NvYy9tZWRpYXRlay9tdGstbXV0ZXguaD4NCj4gPiA+
ID4gKyNpbmNsdWRlICJtdGtfZHJtX2RkcF9jb21wLmgiDQo+ID4gPiA+ICAjaW5jbHVkZSAibXRr
X2RybV9wbGFuZS5oIg0KPiA+ID4gPiAgI2luY2x1ZGUgIm10a19tZHBfcmRtYS5oIg0KPiA+ID4g
PiAgDQo+ID4gPiA+IEBAIC03OSw2ICs4MCw3IEBAIHZvaWQgbXRrX292bF9jbGtfZGlzYWJsZShz
dHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiA+ID4gPiAgdm9pZCBtdGtfb3ZsX2NvbmZpZyhzdHJ1Y3Qg
ZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCB3LA0KPiA+ID4gPiAgCQkgICAgdW5zaWduZWQgaW50
IGgsIHVuc2lnbmVkIGludCB2cmVmcmVzaCwNCj4gPiA+ID4gIAkJICAgIHVuc2lnbmVkIGludCBi
cGMsIHN0cnVjdCBjbWRxX3BrdA0KPiA+ID4gPiAqY21kcV9wa3QpOw0KPiA+ID4gPiArdTY0IG10
a19vdmxfZ2V0X3NlY19wb3J0KHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAsIHVuc2lnbmVkDQo+
ID4gPiA+IGludA0KPiA+ID4gPiBpZHgpOw0KPiA+ID4gPiAgaW50IG10a19vdmxfbGF5ZXJfY2hl
Y2soc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgaWR4LA0KPiA+ID4gPiAgCQkJc3Ry
dWN0IG10a19wbGFuZV9zdGF0ZSAqbXRrX3N0YXRlKTsNCj4gPiA+ID4gIHZvaWQgbXRrX292bF9s
YXllcl9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQNCj4gPiA+ID4gaWR4
LA0KPiA+ID4gPiBAQCAtMTEyLDYgKzExNCw3IEBAIHZvaWQgbXRrX292bF9hZGFwdG9yX2Nsa19k
aXNhYmxlKHN0cnVjdA0KPiA+ID4gPiBkZXZpY2UNCj4gPiA+ID4gKmRldik7DQo+ID4gPiA+ICB2
b2lkIG10a19vdmxfYWRhcHRvcl9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBp
bnQNCj4gPiA+ID4gdywNCj4gPiA+ID4gIAkJCSAgICB1bnNpZ25lZCBpbnQgaCwgdW5zaWduZWQg
aW50DQo+ID4gPiA+IHZyZWZyZXNoLA0KPiA+ID4gPiAgCQkJICAgIHVuc2lnbmVkIGludCBicGMs
IHN0cnVjdCBjbWRxX3BrdA0KPiA+ID4gPiAqY21kcV9wa3QpOw0KPiA+ID4gPiArdTY0IG10a19v
dmxfYWRhcHRvcl9nZXRfc2VjX3BvcnQoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCwNCj4gPiA+
ID4gdW5zaWduZWQNCj4gPiA+ID4gaW50IGlkeCk7DQo+ID4gPiA+ICB2b2lkIG10a19vdmxfYWRh
cHRvcl9sYXllcl9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZA0KPiA+ID4gPiBp
bnQNCj4gPiA+ID4gaWR4LA0KPiA+ID4gPiAgCQkJCSAgc3RydWN0IG10a19wbGFuZV9zdGF0ZQ0K
PiA+ID4gPiAqc3RhdGUsDQo+ID4gPiA+ICAJCQkJICBzdHJ1Y3QgY21kcV9wa3QgKmNtZHFfcGt0
KTsNCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlz
cF9vdmwuYw0KPiA+ID4gPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwu
Yw0KPiA+ID4gPiBpbmRleCAyYmZmZTQyNDU0NjYuLjc2ZTgzMmU0ODc1YSAxMDA2NDQNCj4gPiA+
ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+ID4gPiA+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiA+ID4gPiBA
QCAtNDYsNiArNDYsNyBAQA0KPiA+ID4gPiAgI2RlZmluZSBESVNQX1JFR19PVkxfQUREUihvdmws
IG4pCQkoKG92bCktPmRhdGEtDQo+ID4gPiA+ID4gYWRkciArDQo+ID4gPiA+IA0KPiA+ID4gPiAw
eDIwICogKG4pKQ0KPiA+ID4gPiAgI2RlZmluZSBESVNQX1JFR19PVkxfSERSX0FERFIob3ZsLCBu
KQkJKChvdmwpLT5kYXRhLQ0KPiA+ID4gPiA+IGFkZHIgKyAweDIwICogKG4pICsgMHgwNCkNCj4g
PiA+ID4gDQo+ID4gPiA+ICAjZGVmaW5lIERJU1BfUkVHX09WTF9IRFJfUElUQ0gob3ZsLCBuKQkJ
KChvdmwpLT5kYXRhLQ0KPiA+ID4gPiA+IGFkZHIgKyAweDIwICogKG4pICsgMHgwOCkNCj4gPiA+
ID4gDQo+ID4gPiA+ICsjZGVmaW5lIERJU1BfUkVHX09WTF9TRUNVUkUJCQkweDBmYzANCj4gPiA+
ID4gIA0KPiA+ID4gPiAgI2RlZmluZSBHTUNfVEhSRVNIT0xEX0JJVFMJMTYNCj4gPiA+ID4gICNk
ZWZpbmUgR01DX1RIUkVTSE9MRF9ISUdICSgoMSA8PCBHTUNfVEhSRVNIT0xEX0JJVFMpIC8gNCkN
Cj4gPiA+ID4gQEAgLTEyNiw4ICsxMjcsMTkgQEAgc3RydWN0IG10a19kaXNwX292bCB7DQo+ID4g
PiA+ICAJY29uc3Qgc3RydWN0IG10a19kaXNwX292bF9kYXRhCSpkYXRhOw0KPiA+ID4gPiAgCXZv
aWQJCQkJKCp2YmxhbmtfY2IpKHZvaWQNCj4gPiA+ID4gKmRhdGEpOw0KPiA+ID4gPiAgCXZvaWQJ
CQkJKnZibGFua19jYl9kYXRhOw0KPiA+ID4gPiArCXJlc291cmNlX3NpemVfdAkJCXJlZ3NfcGE7
DQo+ID4gPiA+ICB9Ow0KPiA+ID4gPiAgDQo+ID4gPiA+ICt1NjQgbXRrX292bF9nZXRfc2VjX3Bv
cnQoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCwgdW5zaWduZWQNCj4gPiA+ID4gaW50DQo+ID4g
PiA+IGlkeCkNCj4gPiA+ID4gK3sNCj4gPiA+ID4gKwlpZiAoY29tcC0+aWQgPT0gRERQX0NPTVBP
TkVOVF9PVkwwKQ0KPiA+ID4gPiArCQlyZXR1cm4gMVVMTCA8PCBDTURRX1NFQ19ESVNQX09WTDA7
DQo+ID4gPiA+ICsJZWxzZSBpZiAoY29tcC0+aWQgPT0gRERQX0NPTVBPTkVOVF9PVkwxKQ0KPiA+
ID4gPiArCQlyZXR1cm4gMVVMTCA8PCBDTURRX1NFQ19ESVNQX09WTDE7DQo+ID4gPiA+ICsNCj4g
PiA+ID4gKwlyZXR1cm4gMDsNCj4gPiA+ID4gK30NCj4gPiA+ID4gKw0KPiA+ID4gPiAgc3RhdGlj
IGlycXJldHVybl90IG10a19kaXNwX292bF9pcnFfaGFuZGxlcihpbnQgaXJxLCB2b2lkDQo+ID4g
PiA+ICpkZXZfaWQpDQo+ID4gPiA+ICB7DQo+ID4gPiA+ICAJc3RydWN0IG10a19kaXNwX292bCAq
cHJpdiA9IGRldl9pZDsNCj4gPiA+ID4gQEAgLTQ0OSw4ICs0NjEsMjIgQEAgdm9pZCBtdGtfb3Zs
X2xheWVyX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlDQo+ID4gPiA+ICpkZXYsDQo+ID4gPiA+IHVuc2ln
bmVkIGludCBpZHgsDQo+ID4gPiA+ICAJCQkgICAgICBESVNQX1JFR19PVkxfU1JDX1NJWkUoaWR4
KSk7DQo+ID4gPiA+ICAJbXRrX2RkcF93cml0ZV9yZWxheGVkKGNtZHFfcGt0LCBvZmZzZXQsICZv
dmwtPmNtZHFfcmVnLCANCj4gPiA+ID4gb3ZsLQ0KPiA+ID4gPiA+IHJlZ3MsDQo+ID4gPiA+IA0K
PiA+ID4gPiAgCQkJICAgICAgRElTUF9SRUdfT1ZMX09GRlNFVChpZHgpKTsNCj4gPiA+ID4gLQlt
dGtfZGRwX3dyaXRlX3JlbGF4ZWQoY21kcV9wa3QsIGFkZHIsICZvdmwtPmNtZHFfcmVnLA0KPiA+
ID4gPiBvdmwtDQo+ID4gPiA+ID4gcmVncywNCj4gPiA+ID4gDQo+ID4gPiA+IC0JCQkgICAgICBE
SVNQX1JFR19PVkxfQUREUihvdmwsIGlkeCkpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJaWYgKHN0
YXRlLT5wZW5kaW5nLmlzX3NlYykgew0KPiA+ID4gPiArCQljb25zdCBzdHJ1Y3QgZHJtX2Zvcm1h
dF9pbmZvICpmbXRfaW5mbyA9DQo+ID4gPiA+IGRybV9mb3JtYXRfaW5mbyhmbXQpOw0KPiA+ID4g
PiArCQl1bnNpZ25lZCBpbnQgYnVmX3NpemUgPSAocGVuZGluZy0+aGVpZ2h0IC0gMSkgKg0KPiA+
ID4gPiBwZW5kaW5nLT5waXRjaCArDQo+ID4gPiA+ICsJCQkJCXBlbmRpbmctPndpZHRoICoNCj4g
PiA+ID4gZm10X2luZm8tDQo+ID4gPiA+ID4gY3BwWzBdOw0KPiA+ID4gPiANCj4gPiA+ID4gKw0K
PiA+ID4gPiArCQltdGtfZGRwX3dyaXRlX21hc2soY21kcV9wa3QsIEJJVChpZHgpLCAmb3ZsLQ0K
PiA+ID4gPiA+Y21kcV9yZWcsDQo+ID4gPiA+IG92bC0+cmVncywNCj4gPiA+ID4gKwkJCQkgICBE
SVNQX1JFR19PVkxfU0VDVVJFLA0KPiA+ID4gPiBCSVQoaWR4KSk7DQo+ID4gPiA+ICsJCW10a19k
ZHBfc2VjX3dyaXRlKGNtZHFfcGt0LCBvdmwtPnJlZ3NfcGEgKw0KPiA+ID4gPiBESVNQX1JFR19P
VkxfQUREUihvdmwsIGlkeCksDQo+ID4gPiA+ICsJCQkJICBwZW5kaW5nLT5hZGRyLA0KPiA+ID4g
PiBDTURRX0lXQ19IXzJfTVZBLCAwLA0KPiA+ID4gPiBidWZfc2l6ZSwgMCk7DQo+ID4gPiANCj4g
PiA+IFdoeSBwYXNzIG92bC0+cmVnc19wYSBpbnRvIGNtZHEgZHJpdmVyPyBjbWRxIGp1c3QgbmVl
ZCBzdWJzeXMgYW5kDQo+ID4gPiBvZmZzZXQuDQo+ID4gDQo+ID4gWWVzLCB0aGF0J3Mgbm90IG5l
Y2Vzc2FyeSBhbmQgSSBjYW4gcmVmaW5lIHRoYXQgaW4gdGhlIGZ1dHVyZS4NCj4gPiBCZWNhdXNl
DQo+ID4gdGhpcyBjaGFuZ2Ugd2lsbCBhbHNvIG5lZWQgdG8gbW9kaWZ5IHRoZSBjb2RlIGluIENN
RFEgUFRBLCBzbyBJJ2xsDQo+ID4gZml4DQo+ID4gb3RoZXIgaXNzdWVzIGluIG5vcm1hbCB3b3Js
ZCBmaXJzdC4gVGhlbiBJJ2xsIHJlZmluZSB0aGlzIHBsYWNlDQo+ID4gYWZ0ZXINCj4gPiBhDQo+
ID4gZmV3IHZlcnNpb24uDQo+IA0KPiBBZGQgVE9ETyBpbmZvcm1hdGlvbiBzbyB0aGF0IHdlIHdv
dWxkIG5vdCBmb3JnZXQgdGhpcy4NCj4gDQpPSywgSSdsbCBhZGQgVE9ETyB0byB0aGUgY29tbWl0
IG1lc3NhZ2UuDQoNCj4gPiANCj4gPiA+IEluIGFkZGl0aW9uLCB3aHkgcGFzcyBidWZfc2l6ZT8N
Cj4gPiA+IA0KPiA+IA0KPiA+IFRoaXMgYnVmX3NpemUgaXMgdGhlIHBhcmFtZXRlciBmb3IgTTRV
IFBUQSB0byB2ZXJpZnkgdGhlIHJhbmdlIG9mDQo+ID4gc2VjdXJlIGFkZHJlc3MgaW4gdGhlIHNl
Y3VyZSB3b3JsZC4NCj4gDQo+IFdoeSBuZWVkIHRoaXMgdmVyaWZpY2F0aW9uPyBJbiBub3JtYWwg
dmlkZW8gcGxheWJhY2ssIE00VSBkb2VzIG5vdA0KPiB2ZXJpZnkgdGhlIHNpemUuIElmIGhhcmR3
YXJlIGFjY2VzcyBvdXQgcmFuZ2Ugb2YgYWxsb2NhdGVkIGJ1ZmZlciwgaXQNCj4gd291bGQgY2F1
c2UgTTRVIHRvIGhhdmUgdHJhbnNsYXRpb24gZmF1bHQuIEkgdGhpbmsgc2VjdXJlIHZpZGVvIGNv
dWxkDQo+IGFsc28gaGF2ZSB0cmFuc2xhdGlvbiBmYXVsdCBzbyB0aGUgc2l6ZSB2ZXJpZmljYXRp
b24gaXMgbm90DQo+IG5lY2Vzc2FyeS4NCj4gDQpJJ3ZlIGNoZWNrZWQgdGhpcyB3aXRoIE00VSBv
d25lci4gSXQncyBub3Qgb25seSB1c2VkIHRvIHZlcmlmaWNhdGlvbiwNCmJ1dCBhbHNvIHVzZWQg
dG8gdGVsbCBtNFUgVEEgaG93IG11Y2ggYnVmZmVyIHNpemUgaXQgbmVlZHMgdG8gbWFwIHRvDQpp
b3ZhIGluIHNlY3VyZSB3b3JsZC4gU28gaXQncyBhIG5lY2Vzc2FyeSBpbmZvcm1hdGlvbi4NCg0K
UmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+IFJlZ2FyZHMsDQo+IENLDQo+IA0KPiANCj4gPiAN
Cj4gPiBSZWdhcmRzLA0KPiA+IEphc29uLUpILkxpbg0KPiA+IA0KPiA+ID4gUmVnYXJkcywNCj4g
PiA+IENLDQo+ID4gPiANCg==

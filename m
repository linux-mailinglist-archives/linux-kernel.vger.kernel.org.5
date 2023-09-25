Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C3B7AD447
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjIYJMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjIYJMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:12:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1D3103;
        Mon, 25 Sep 2023 02:12:00 -0700 (PDT)
X-UUID: 91d535ee5b8311eea33bb35ae8d461a2-20230925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=kXhaTG51GqX5wdHn8rXsR4qZ+ZzKdSTAjmWQrwGHvKA=;
        b=FgaHVcDhdOj7hlNlFq8YN4Md0L3N9J1DuBqgxKkYqaPtrwhDrgRfpQ80dNFetIzUL4PAA2SgdTyNyIKjorypkD7fFMUKIGWbs24VJvbiwpKrdZ/JDYiVg+epng/CecqRGkvrkzTHfQs+Sved1e/QQi7k9rUhNfmtPvQHCoSMupI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:c339121a-d799-4112-99f7-e47289e19dc4,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:b30d5814-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 91d535ee5b8311eea33bb35ae8d461a2-20230925
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 764904044; Mon, 25 Sep 2023 17:11:54 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 25 Sep 2023 17:11:52 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 25 Sep 2023 17:11:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLVCC9SMlhtHdT6Oi0++9vUXiS4Ga4af9IGTOUlvoP3qTRRZlEX46CjBO1d6jl8iAeak249Uu2x3ELxd1LhWnoAhokIY58BjrrEhBIDHDkxg6PQJkgdYjk+seqO2QgfcsT2ugvPS65kzAwLbCbyu3t+7LEPbGVi5ie0qr5NLGa0gYx6C2FQTU2AIK3d8aHZrdXsqG47RmWm8b5ro+GpuTZnNvYAtzXgn0QcL92cJOogFzphz8U5FraTP4QNJNx3+ZUNVQT8BM/G/VsZmPhUAQt2toM0N5WZUVant3ve5dh8u+NVqX/BAUmj+aTbsHY/7szjtKq3z8X+YveyFoLZzlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXhaTG51GqX5wdHn8rXsR4qZ+ZzKdSTAjmWQrwGHvKA=;
 b=mkZTQ2YP7odH6w26B7f1BRWbmGFvI7trIiMi8cTQBGGW9rFrPzFwd6k4lcrfNiBHVvDGC/xGgCN7KzszVStw/2Dn+mcOcpKNLPwUYSS43Ema7HyJc8uvg2LehNsrBi7JrVSjge+Jfxq+Jcg3dfLuCv4af++v99NeOqaqmmzLEH9KrQddkwnSUN3GxxYqG66CjXNq5dmQwCS9ZNEsHH7p9fsB/JNUyMtlln+ICTUCLBrzs1rFsrADnnkwhEgcnJAkhRw1nrzDFg8mIV1ouO7qEv5xx+2BuBg8UGE+wBFlnH4yvFE/bPegcZcVtyQiWwVyTXWgjKVB2JFoy+BwEgML0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXhaTG51GqX5wdHn8rXsR4qZ+ZzKdSTAjmWQrwGHvKA=;
 b=bW5cqKV7X8ItIw5MVmlNqfDpxcIdCncJ9bm/X9N24XlJ2Oe6yb3pT2K3mqTX7LyCQ7YWz8b5MUxGs+SRfmr7XvDRtwmiz9vIuk2tjWs7Sfs59vnlr7+RU2c0Eocu+sBzGoQnfYw204GIc+LgLUdLy4J8rJ/qwPQIAIyiVUIOWbs=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI2PR03MB6222.apcprd03.prod.outlook.com (2603:1096:4:16c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 25 Sep
 2023 09:11:50 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%6]) with mapi id 15.20.6792.026; Mon, 25 Sep 2023
 09:11:50 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "jkardatzke@google.com" <jkardatzke@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 00/10] Add mediate-drm secure flow for SVP
Thread-Topic: [PATCH 00/10] Add mediate-drm secure flow for SVP
Thread-Index: AQHZ6qYCRTH7YrTpyk6QXsEzLaAxhrAjMCUAgADaFgCAAHckgIAA4IwAgAXpaAA=
Date:   Mon, 25 Sep 2023 09:11:49 +0000
Message-ID: <e40245bbca67e3ca538d70d0ae9bb6eba3a7e1c6.camel@mediatek.com>
References: <20230919030345.8629-1-jason-jh.lin@mediatek.com>
         <a0b32a1d93bc9d991f77ad3408fe7b177bb32889.camel@mediatek.com>
         <CA+ddPcNPeo=z42fG24uoSMJ8M0uWB-huzXVKBm-seG=7b+50JA@mail.gmail.com>
         <0f828842524f1518ccb6f75e6b34efd849466016.camel@mediatek.com>
         <9d6e628e1a420edf1106895eddeced7b9847ce8c.camel@mediatek.com>
In-Reply-To: <9d6e628e1a420edf1106895eddeced7b9847ce8c.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI2PR03MB6222:EE_
x-ms-office365-filtering-correlation-id: c0d0f594-6972-4253-f23e-08dbbda77393
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0lZOpXXJNdRCgUpXn2YxvHWYcLUjBrzdMUyRcQ/cW30+oDqrNR2GlX1pMlob9jw/TuEgK53TLFALkRE9EXK9AoiaSr9Ao1+GN9PnRtCuAKl5fSdJAVj8vCGF2rol+9HrjtUrLEk5xs4w2Rrd74FVNHegCMVVyT4dD+WYtITzxBx9ioWi7vs9YOaPPnqTisyLCrgGWTif6sejp/OoftMnaueqBtoe6skO6WLXKq+8mQMNNu2mP4a7K0cGhl3xun73BI2GyOYOcsDr+tfplQH9+362/x4CyAqq1i1hERGa587CkIw2UuHEz9J/yg3dgP17rHGmTNgiET0vu94eDoghxovfdS5T/7UnWxhtzgFaPU+nk9uhoufn9vRRcvtYlHmvads/hWXWFmkDANu9Mmhhi4ScdlV9k1YjR6swF5gA8rbh+o7mDVsuLUUqAxhU407BEosTOHSSqw8uNSXdfpTwq6tr1eifdKn2hLV/9CVqFmGu1y0Vf7zPm1vUuFtdGav75OLVerQGyCaINmWIbo/ztokJPkxfxHS6OnQavl8wZRqtmeEPRGCORy+SocSVOA1BvZG/8hMzEN+NrhQyrT2MuIqBYh9th5wwbtTCv/UV8Jt6YS2kKp5O/HYwqJbcR/DrFqvZtXy5MaUz6KKcYEPzjiEf7elQoHMAYoM10TCs4mOf/pnWx52Gra0iP4Iyvk61
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(71200400001)(83380400001)(7416002)(2906002)(6512007)(36756003)(6486002)(53546011)(6506007)(122000001)(2616005)(26005)(86362001)(38100700002)(38070700005)(478600001)(85182001)(966005)(5660300002)(110136005)(316002)(66446008)(66946007)(64756008)(54906003)(66476007)(66556008)(8936002)(8676002)(4326008)(76116006)(91956017)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3o3dTIzOEd3Z24yS3d6Yk5TNDI3ajhWWGJ2SnBVS0xKeis1YURjT3NCNWRE?=
 =?utf-8?B?MjZFZC90MU1rck5uZDV2SUZUU0YvYWVic1hEYzdLV3pxcFBFbzM3dWpsY3lJ?=
 =?utf-8?B?L0kxZ2M1VXUvWWxlWkNhWitIbUdhTjJMMDIrV3Y0ZnNqRFdYdldsU0g5aEtC?=
 =?utf-8?B?U2N1amJmeWJZUmJhTjM0bm9WY1NMVmd6MWFDSU1jTnN0N0pJM094V2p3aTRn?=
 =?utf-8?B?TWphanBjbHhEVlZ3TmFkT1JhcEZvY1NudUgwem1yNlc2WFRPRGpTaGkrVWNE?=
 =?utf-8?B?WjJXMkV5TU92Qk9tZC8vMkRJTWMwdTFxa1U2bVF4cWRabTdSOXVBTDU1ZG8x?=
 =?utf-8?B?bGFZc1hlWE9Ja2IyNEZNdVFNSUdhb2VDSkVqZDNxZlNaY05NeWxqelpXdXIr?=
 =?utf-8?B?YVhUbkVTVEREMjE5N2ExcDJONURpR1M1VzN5eFNjd013MEw0bmpqYlIzdC9E?=
 =?utf-8?B?bWhZOTBVTCt2NE8zcE9nN0xDMFRiN1JEQ0NQSDBMdkdtdHdnUVNsR3Nud0xQ?=
 =?utf-8?B?RTV4VDN0bjB5RlVhUUg1Sk16Q3dQZHJtQ1MyZEVqQUZCeC9nK2xaQjFBcU4v?=
 =?utf-8?B?SjV5WVI2a3pLejFWWmZrRFhWV0ptdmtPNm5zQXhjeEVFSWpYcHFTTjFBSytU?=
 =?utf-8?B?Ky90U3hXK2dhVnk1N1VudDFDQTdTWGVKanBZL25GQmR2L3BUbXhLSHdzMXhT?=
 =?utf-8?B?Y1NhY01vQmdTU2NPSXJKMkxTR2hVSlQvSkYxUExiQ1lBU0R3NDdYUzdrUUpW?=
 =?utf-8?B?RnF4WFMzenVWc3htV0p5OXFNZXA5ZzBIWWRpNHNWaXo3ZDNZbVlHTWg4ckVo?=
 =?utf-8?B?cFRrZlJ2OW9ORHdGYko1VmdtVnR2a3hRWXI0bmMzMjhnTVRaVFE5SHd5VWhO?=
 =?utf-8?B?bGlwL1NpaEo0THlobG5wV24xbnhLK3BGbENUUVpEbEc0VjVDZ0t6WGU4Yi96?=
 =?utf-8?B?VzAxNHBVU1Fybk00MTlDUjdTd1Bwb0xFUVZCK01IRXdqTXNCSkhEYXpZV2to?=
 =?utf-8?B?MjJtYVdrbkRRQkFlWDQ0c0RmM0JCWTU4MnB3d1ZqV0J6Q05kNk9XNElDOEVR?=
 =?utf-8?B?dXpKYnk1NExESzdocXZCbVhuVEJhN3k2amFHMDFpbWJSMlBvTXB4bnhabG5j?=
 =?utf-8?B?eWlNbmFYRnZHcmpLQmI0WWJKcFlrSlhjZ1Y0ZUk1UWhzejlyaDk0QjYvc3hF?=
 =?utf-8?B?Z21sb08yKzFVd2RhYWNlVkhUN05zNHRBa2RuamUyVmdSSnhLL1NrRTRveVlu?=
 =?utf-8?B?ai9ZL1VjTHZhamZJZ2lWQ3E4ZHFrSEM0MVJVUWFMMS9CUzNWZXlBTU9IS2Ny?=
 =?utf-8?B?MGdDQ3NFZzJLWUdCdUVQRU80ZXVONnU2Q3ZPa2R4Yk9SOW5TRmJtWHBibVg4?=
 =?utf-8?B?UGM0UXB6dTZNdVpsYXpkaWs1SWlELzE0eFppQ29XUjhwZUFWOCtxS0dQTTdD?=
 =?utf-8?B?OFBuQmxWNmttSkRybGxYV0QvcWJuT3h4TnZmZlN0QkJUaVdWTjRyckdyRUh6?=
 =?utf-8?B?aHdULytKMnFoRWxxRU1wYkV5bGduNEtoYTRCa1IvUGpCRkNaci9VamdIR2J6?=
 =?utf-8?B?LzEwejl2WXFxN1hEb2dPd3BxMk1aeWxiSUVuSG5vYms1dm5qdS9vNGlMV214?=
 =?utf-8?B?UDhhaXhYS01WdWpnV2x2Rkw4Vk5aUXkzelBjZFFObkVITlZOZGpTbFBLZk80?=
 =?utf-8?B?dXBwL1ZBWGk2bFhBdS9OOXpGTzJtMUNZdmw2aUVIRlZzWS9lQytwcVpsQ1JM?=
 =?utf-8?B?QnhrVTFBL3ZjV1VDem44dkdEWEFaaFM3LzJOa2hpRkJKcnV0VnZmSEhLRTFK?=
 =?utf-8?B?SnNwa0crMGVSeEFjditMY2FiaFlhQ3E2TjJjOEVrSk4vVVRTeFUxcEdXcVZT?=
 =?utf-8?B?c0syVStOWW5XaHRoY0dIWGxOZXpIdVdXODQySXczV2F3bmZTRjJjZWhqSDNz?=
 =?utf-8?B?MVRvZU8yb21tWFRTUnk5N0EvOTQ0djRtYnoyZlVFWWVCQlBWbnZnQ0NLZUt4?=
 =?utf-8?B?c1FKaUcvZ2F1aE5jS3ZPaDlBSGpGUE0vMU5OMmNLMG5icXVHUENtRG5ENUwy?=
 =?utf-8?B?ek9tZ3pybEFvRVBKa3BRcWVlZnZldkswRTBxUlRQZHYrWUF6ZzBTTGFNRVow?=
 =?utf-8?Q?tK1tZ7cgY/8JM6UIwwAj5DJso?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DE6326B5B7F694B995DAFF0456C78EC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d0f594-6972-4253-f23e-08dbbda77393
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 09:11:49.8918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vvkvQi1jZ6Zvs+9N1v+9K8Qqvd0j0cmXm1vw1oVFaFfMIEBPC83TvFVjlto+zTNFfW9wH3M36etsbgn29Cguuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6222
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--24.842400-8.000000
X-TMASE-MatchedRID: nI1cAR4k0HYOwH4pD14DsPHkpkyUphL9pkmFaIvGNrDBnyal/eRn3gzR
        CsGHURLuwpcJm2NYlPAF6GY0Fb6yCkttpN+KVVd9AjTI/+6gf4MeCfIkk0Bf+EYvSDWdWaRhOOF
        xXXPqKHkLwDojgA6ZUhFAywVArAyvqBLPkt9bqAS2AZ59hFA161Q1L7GnqIxdazG2pCTfDnnYXG
        dJQr6bvw3xqruMD6u7YC4HWUr/A1+XKs94NAOH8vSG/+sPtZVkc3ewuwbSaG5aW2Ktn+I8/jVLQ
        hDwg/CXj9Seo3OSvpJS+CiP5tF3zcy+OuBPEc+k84dsinZ5e1iVq+okl1rYD9r4gfya+A9U7fKx
        aM2xqkDibU5wqzXg/3jWyV+i7NP4QRHl12CcQN6EJ5wBUYI5/c6YYW8CaluS33Nl3elSfspjgQ0
        L9Qu95KIdWKF9xMvmiDOO0jPTO1o/TqR73SoO80KcYi5Qw/RVq6/EYzBxkJjxSV7YBeBhS4rrVD
        rdF6YE+Thf+5HiUc9eb2xJS17QLzPfG+JZNtQp3fn7n/ZHGqZWOQQSa4vbHefL+zKjW08PvFfPy
        tWHA2krIhHNwiG1WXATsg8MODVIQv21zJNl0CyDGx/OQ1GV8rHlqZYrZqdI+gtHj7OwNO0CpgET
        eT0ynA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--24.842400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: E75624D64E141BB775145411143729A9DD10AE600558671FD89510B7D20C13F82000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEphc29uOg0KDQpPbiBUaHUsIDIwMjMtMDktMjEgYXQgMTQ6NTUgKzAwMDAsIEphc29uLUpI
IExpbiAo5p6X552/56WlKSB3cm90ZToNCj4gSGkgQ0ssDQo+IA0KPiANCj4gT24gVGh1LCAyMDIz
LTA5LTIxIGF0IDAxOjMxICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90ZToNCj4gPiBPbiBX
ZWQsIDIwMjMtMDktMjAgYXQgMTE6MjUgLTA3MDAsIEplZmZyZXkgS2FyZGF0emtlIHdyb3RlOg0K
PiA+ID4gIAkgDQo+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiA+ID4gdW50aWwNCj4gPiA+IHlvdSBoYXZlIHZlcmlm
aWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ID4gPiAgT24gVHVlLCBTZXAgMTksIDIw
MjMgYXQgMTA6MjbigK9QTSBDSyBIdSAo6IOh5L+K5YWJKSA8Y2suaHVAbWVkaWF0ZWsuY29tDQo+
ID4gPiA+DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IEhpLCBKYXNvbjoNCj4gPiA+
ID4gDQo+ID4gPiA+IE9uIFR1ZSwgMjAyMy0wOS0xOSBhdCAxMTowMyArMDgwMCwgSmFzb24tSkgu
TGluIHdyb3RlOg0KPiA+ID4gPiA+IFRoZSBwYXRjaCBzZXJpZXMgcHJvdmlkZXMgZHJtIGRyaXZl
ciBzdXBwb3J0IGZvciBlbmFibGluZw0KPiA+ID4gPiA+IHNlY3VyZQ0KPiA+ID4gPiA+IHZpZGVv
DQo+ID4gPiA+ID4gcGF0aCAoU1ZQKSBwbGF5YmFjayBvbiBNZWRpYWlUZWsgaGFyZHdhcmUgaW4g
dGhlIExpbnV4DQo+ID4gPiA+ID4ga2VybmVsLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IE1lbW9y
eSBEZWZpbml0aW9uczoNCj4gPiA+ID4gPiBzZWN1cmUgbWVtb3J5IC0gTWVtb3J5IGFsbG9jYXRl
ZCBpbiB0aGUgVEVFIChUcnVzdGVkDQo+ID4gPiA+ID4gRXhlY3V0aW9uDQo+ID4gPiA+ID4gRW52
aXJvbm1lbnQpIHdoaWNoIGlzIGluYWNjZXNzaWJsZSBpbiB0aGUgUkVFIChSaWNoIEV4ZWN1dGlv
bg0KPiA+ID4gPiA+IEVudmlyb25tZW50LCBpLmUuIGxpbnV4IGtlcm5lbC91c2Vyc3BhY2UpLg0K
PiA+ID4gPiA+IHNlY3VyZSBoYW5kbGUgLSBJbnRlZ2VyIHZhbHVlIHdoaWNoIGFjdHMgYXMgcmVm
ZXJlbmNlIHRvDQo+ID4gPiA+ID4gJ3NlY3VyZQ0KPiA+ID4gPiA+IG1lbW9yeScuIFVzZWQgaW4g
Y29tbXVuaWNhdGlvbiBiZXR3ZWVuIFRFRSBhbmQgUkVFIHRvDQo+ID4gPiA+ID4gcmVmZXJlbmNl
DQo+ID4gPiA+ID4gJ3NlY3VyZSBtZW1vcnknLg0KPiA+ID4gPiA+IHNlY3VyZSBidWZmZXIgLSAn
c2VjdXJlIG1lbW9yeScgdGhhdCBpcyB1c2VkIHRvIHN0b3JlDQo+ID4gPiA+ID4gZGVjcnlwdGVk
LA0KPiA+ID4gPiA+IGNvbXByZXNzZWQgdmlkZW8gb3IgZm9yIG90aGVyIGdlbmVyYWwgcHVycG9z
ZXMgaW4gdGhlIFRFRS4NCj4gPiA+ID4gPiBzZWN1cmUgc3VyZmFjZSAtICdzZWN1cmUgbWVtb3J5
JyB0aGF0IGlzIHVzZWQgdG8gc3RvcmUNCj4gPiA+ID4gPiBncmFwaGljDQo+ID4gPiA+ID4gYnVm
ZmVycy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBNZW1vcnkgVXNhZ2UgaW4gU1ZQOg0KPiA+ID4g
PiA+IFRoZSBvdmVyYWxsIGZsb3cgb2YgU1ZQIHN0YXJ0cyB3aXRoIGVuY3J5cHRlZCB2aWRlbyBj
b21pbmcgaW4NCj4gPiA+IA0KPiA+ID4gZnJvbSBhbg0KPiA+ID4gPiA+IG91dHNpZGUgc291cmNl
IGludG8gdGhlIFJFRS4gVGhlIFJFRSB3aWxsIHRoZW4gYWxsb2NhdGUgYQ0KPiA+ID4gPiA+ICdz
ZWN1cmUNCj4gPiA+ID4gPiBidWZmZXInIGFuZCBzZW5kIHRoZSBjb3JyZXNwb25kaW5nICdzZWN1
cmUgaGFuZGxlJyBhbG9uZyB3aXRoDQo+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gZW5jcnlwdGVk
LCBjb21wcmVzc2VkIHZpZGVvIGRhdGEgdG8gdGhlIFRFRS4gVGhlIFRFRSB3aWxsDQo+ID4gPiA+
ID4gdGhlbg0KPiA+ID4gPiA+IGRlY3J5cHQNCj4gPiA+ID4gPiB0aGUgdmlkZW8gYW5kIHN0b3Jl
IHRoZSByZXN1bHQgaW4gdGhlICdzZWN1cmUgYnVmZmVyJy4gVGhlDQo+ID4gPiA+ID4gUkVFDQo+
ID4gPiANCj4gPiA+IHdpbGwNCj4gPiA+ID4gPiB0aGVuIGFsbG9jYXRlIGEgJ3NlY3VyZSBzdXJm
YWNlJy4gVGhlIFJFRSB3aWxsIHBhc3MgdGhlDQo+ID4gPiA+ID4gJ3NlY3VyZQ0KPiA+ID4gPiA+
IGhhbmRsZXMnIGZvciBib3RoIHRoZSAnc2VjdXJlIGJ1ZmZlcicgYW5kICdzZWN1cmUgc3VyZmFj
ZScNCj4gPiA+ID4gPiBpbnRvDQo+ID4gPiANCj4gPiA+IHRoZQ0KPiA+ID4gPiA+IFRFRSBmb3Ig
dmlkZW8gZGVjb2RpbmcuIFRoZSB2aWRlbyBkZWNvZGVyIEhXIHdpbGwgdGhlbiBkZWNvZGUNCj4g
PiA+ID4gPiB0aGUNCj4gPiA+ID4gPiBjb250ZW50cyBvZiB0aGUgJ3NlY3VyZSBidWZmZXInIGFu
ZCBwbGFjZSB0aGUgcmVzdWx0IGluIHRoZQ0KPiA+ID4gDQo+ID4gPiAnc2VjdXJlDQo+ID4gPiA+
ID4gc3VyZmFjZScuIFRoZSBSRUUgd2lsbCB0aGVuIGF0dGFjaCB0aGUgJ3NlY3VyZSBzdXJmYWNl
JyB0bw0KPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+IG92ZXJsYXkNCj4gPiA+ID4gPiBwbGFuZSBm
b3IgcmVuZGVyaW5nIG9mIHRoZSB2aWRlby4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBFdmVyeXRo
aW5nIHJlbGF0aW5nIHRvIGVuc3VyaW5nIHNlY3VyaXR5IG9mIHRoZSBhY3R1YWwNCj4gPiA+ID4g
PiBjb250ZW50cw0KPiA+ID4gDQo+ID4gPiBvZg0KPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ICdz
ZWN1cmUgYnVmZmVyJyBhbmQgJ3NlY3VyZSBzdXJmYWNlJyBpcyBvdXQgb2Ygc2NvcGUgZm9yIHRo
ZQ0KPiA+ID4gPiA+IFJFRQ0KPiA+ID4gDQo+ID4gPiBhbmQNCj4gPiA+ID4gPiBpcyB0aGUgcmVz
cG9uc2liaWxpdHkgb2YgdGhlIFRFRS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBEUk0gZHJpdmVy
IGhhbmRsZXMgYWxsb2NhdGlvbiBvZiBnZW0gb2JqZWN0cyB0aGF0IGFyZSBiYWNrZWQNCj4gPiA+
ID4gPiBieQ0KPiA+ID4gPiA+IGENCj4gPiA+ID4gPiAnc2VjdXJlDQo+ID4gPiA+ID4gc3VyZmFj
ZScgYW5kIGZvciBkaXNwbGF5aW5nIGEgJ3NlY3VyZSBzdXJmYWNlJyBvbiB0aGUgb3ZlcmxheQ0K
PiA+ID4gDQo+ID4gPiBwbGFuZS4NCj4gPiA+ID4gPiBUaGlzIGludHJvZHVjZXMgYSBuZXcgZmxh
ZyBmb3Igb2JqZWN0IGNyZWF0aW9uIGNhbGxlZA0KPiA+ID4gPiA+IERSTV9NVEtfR0VNX0NSRUFU
RV9FTkNSWVBURUQgd2hpY2ggaW5kaWNhdGVzIGl0IHNob3VsZCBiZSBhDQo+ID4gPiANCj4gPiA+
ICdzZWN1cmUNCj4gPiA+ID4gPiBzdXJmYWNlJy4gQWxsIGNoYW5nZXMgaGVyZSBhcmUgaW4gTWVk
aWFUZWsgc3BlY2lmaWMgY29kZS4NCj4gPiA+ID4gDQo+ID4gPiA+IEhvdyBkbyB5b3UgZGVmaW5l
IFNWUD8gSXMgdGhlcmUgc3RhbmRhcmQgcmVxdWlyZW1lbnQgd2UgY291bGQNCj4gPiA+ID4gcmVm
ZXINCj4gPiA+IA0KPiA+ID4gdG8/DQo+ID4gPiA+IElmIHRoZSBzZWN1cmUgdmlkZW8gYnVmZmVy
IGlzIHJlYWQgYnkgZGlzcGxheSBoYXJkd2FyZSBhbmQNCj4gPiA+ID4gb3V0cHV0DQo+ID4gPiAN
Cj4gPiA+IHRvDQo+ID4gPiA+IEhETUkgd2l0aG91dCBhbnkgcHJvdGVjdGlvbiBhbmQgdXNlciBj
b3VsZCBjYXB0dXJlIEhETUkgc2lnbmFsLA0KPiA+ID4gPiBpcw0KPiA+ID4gDQo+ID4gPiB0aGlz
DQo+ID4gPiA+IHNlY3VyZT8NCj4gPiA+IA0KPiA+ID4gU1ZQIChTZWN1cmUgVmlkZW8gUGF0aCkg
aXMgZXNzZW50aWFsbHkgdGhlIHZpZGVvIGJlaW5nIGNvbXBsZXRlZA0KPiA+ID4gaXNvbGF0ZWQg
ZnJvbSB0aGUga2VybmVsL3VzZXJzcGFjZS4gVGhlIHNwZWNpZmljIHJlcXVpcmVtZW50cyBmb3IN
Cj4gPiA+IGl0DQo+ID4gPiB2YXJ5IGJldHdlZW4gaW1wbGVtZW50YXRpb25zLg0KPiA+ID4gDQo+
ID4gPiBSZWdhcmRpbmcgSERNSS9IRENQIG91dHB1dDsgaXQncyB0aGUgcmVzcG9uc2liaWxpdHkg
b2YgdGhlIFRFRSB0bw0KPiA+ID4gZW5mb3JjZSB0aGF0LiBOb3RoaW5nIG9uIHRoZSBrZXJuZWwv
dXNlcnNwYWNlIHNpZGUgbmVlZHMgdG8gYmUNCj4gPiA+IGNvbmNlcm5lZCBhYm91dCBlbmZvcmNp
bmcgSERDUC4gVGhlIG9ubHkgdGhpbmcgdXNlcnNwYWNlIGlzDQo+ID4gPiBpbnZvbHZlZA0KPiA+
ID4gaW4gdGhlcmUgaXMgYWN0dWFsbHkgdHVybmluZyBvbiBIRENQIHZpYSB0aGUga2VybmVsIGRy
aXZlcnM7IGFuZA0KPiA+ID4gdGhlbg0KPiA+ID4gdGhlIFRFRSBlbnN1cmVzIHRoYXQgaXQgaXMg
YWN0aXZlIGlmIHRoZSBwb2xpY3kgZm9yIHRoZSBlbmNyeXB0ZWQNCj4gPiA+IGNvbnRlbnQgcmVx
dWlyZXMgaXQuDQo+ID4gDQo+ID4gQnV0IGluIFtQYXRjaCAwNy8xMF0sDQo+ID4gDQo+ID4gaW4g
bXRrX292bF9sYXllcl9jb25maWcoKSwgdGhlIHNlY3VyZSBpbnB1dCB3b3VsZCBlbmFibGUvZGlz
YWJsZQ0KPiA+IGR5bmFtaWNhbCBpbiBrZXJuZWwsIE1lZGlhVGVrIFNWUCBkb2VzIG5vdCBoaWRl
IGFsbCBjb250cm9sIGluIFRFRSwNCj4gPiBzbw0KPiA+IEkgd29ycnkgdGhhdCBzb21ldGhpbmcg
bG9zdC4gVG8gYWNoaWV2ZSBTVlAsIGRpc3BsYXkgaGFyZHdhcmUNCj4gPiBzaG91bGQNCj4gPiBo
YXZlIHNlY3VyZSBpbnB1dCwgc2VjdXJlIHBpcGVsaW5lLCBzZWN1cmUgb3V0cHV0LCBidXQgaW4g
dGhpcw0KPiA+IHNlcmllcywNCj4gPiBJIGp1c3Qgc2VlIHNlY3VyZSBpbnB1dC4gTWF5YmUgb3Ro
ZXJzIGlzIGRvbmUgaW4gVEVFLCB0ZWxsIG1lIHdoaWNoDQo+ID4gcGFydCBpcyBkb25lIGJ5IHdo
aWNoIHN0ZXAuDQo+ID4gDQo+IA0KPiBXZSdsbCB1c2UgY21kcV9zZWNfcGt0X3NldF9kYXRhKCkg
dG8gYnJpbmcgdGhlIHNlY3VyZSBzY2VuYXJpbywNCj4gc2VjdXJlDQo+IGVuZ2luZSBmbGFncyBh
bmQgc29tZSBzZWN1cmUgbWV0YWRhdGEgdG8gVEVFIHdvcmxkLiBUaGVuIHdpbGwgdXNlZA0KPiB0
aGVzZSBpbmZvcm1hdGlvbiB0byBtYWtlIHN1cmUgdGhlIHBpcGVsaW5lIGlzIHNlY3VyZS4NCj4g
DQo+IFdlIGRvbid0IGhhdmUgdGhlIHNlY3VyZSBvdXRwdXQgZmVhdHVyZSBjdXJyZW50bHksIHN1
Y2ggYXMgV2lGaQ0KPiBkaXNwbGF5LCBzbyB3ZSdsbCBkbyBpdCBhZnRlciB3ZSBoYXZlIHRvIHN1
cHBvcnQgdGhlIGZlYXR1cmUuDQo+IA0KPiBBbHNvIHRoZXJlIGFyZSBIRE1JVFhfSERDUCBhbmQg
RFBUWF9IRENQIFRBIHdpbGwgY2hlY2sgdGhlIEhEQ1ANCj4gc3RhdHVlDQo+IGluIHNlY3VyZSB3
b3JsZCBhbmQgdGhlbiBDTURRIFRBIHdpbGwgZ2V0IHRoYXQgc3RhdHVzIGJ5IGNhbGxpbmcNCj4g
dGhlaXINCj4gQVBJIGluIFRFRS4NCj4gSWYgQ01EUSBUQSBnZXQgYSBIRENQIGNoZWNraW5nIGZh
aWxlZCBzc3RhdHVzLCBpdCB3aWxsIGluc2VydCBzb21lDQo+IGluc3RydWN0aW9ucyBpbiB0aGUg
c2VjdXJlIGNtZCBidWZmZXIgdG8gbXV0ZSB0aGUgRElTUCBIVyBmb3IgZWFjaA0KPiBmcmFtZXMu
DQoNCllvdSBlbmFibGUgc2VjdXJlIHBhdGggYnkgY3J0YyBwaXBlbGluZS4gVGhhdCBtZWFucyBp
dCBtYXkgYmUgcHJpbWFyeQ0KZGlzcGxheSBpcyBzZWN1cmUgYW5kIHNlY29uZGFyeSBkaXNwbGF5
IGlzIG5vbi1zZWN1cmUuIEluDQpkcml2ZXJzL3NvYy9tZWRpYXRlay9tdDgxOTUtbW1zeXMuaCwg
dGhlIHByaW1hcnkgZGlzcGxheSBpbnB1dCBjb3VsZCBiZQ0Kcm91dGVkIHRvIHNlY29uZGFyeSBk
aXNwbGF5IG91dHB1dC4gSXMgbW1zeXMgcHJvdGVjdGVkIHdoZW4gZGlzcGxheSBpcw0Kc2VjdXJl
PyBUaGUgd2hvbGUgbW1zeXMgaXMgcHJvdGVjdGVkIG9yIHBhcnRpYWwgbW1zeXMgaXMgcHJvdGVj
dGVkPyBJZg0KdGhlIHdob2xlIG1tc3lzIGlzIHByb3RlY3RlZCwgdGhlIG5vbi1zZWN1cmUgZGlz
cGxheSBwaXBlbGluZSB3b3VsZCBiZQ0KbWFsZnVuY3Rpb25lZCBiZWNhdXNlIHRoZSBjb250cm9s
IG9mIG5vbi1zZWN1cmUgZGlzcGxheSBpcyBpbiBub3JtYWwNCndvcmxkIGFuZCBpdCBtYXkgYWNj
ZXNzIG1tc3lzLiBQbGVhc2UgZGVzY3JpYmUgaG93IHRoaXMgd29yaz8NCg0KUmVnYXJkcywNCkNL
DQoNCj4gDQo+IFJlZ2FyZHMsDQo+IEphc29uLUpILkxpbg0KPiANCj4gPiBSZWdhcmRzLA0KPiA+
IENLDQo+ID4gDQo+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBSZWdhcmRzLA0KPiA+ID4gPiBDSw0K
PiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiBCYXNlZCBvbiAy
IHNlcmllczoNCj4gPiA+ID4gPiBbMV0gQWRkIENNRFEgc2VjdXJlIGRyaXZlciBmb3IgU1ZQDQo+
ID4gPiA+ID4gLQ0KPiA+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiANCj4gDQo+IA0KaHR0cHM6Ly91
cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9s
aW51eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9Nzg1MzMyX187ISFDVFJOS0E5d01nMEFSYnchbVBv
Y2JRd1o0LTI1RG1pZHZBZ2Q5SzVlWGpORWhTeUlLcHZ2WUhQcGRycTJQZ1MtaGtZeUhvaHpEdm9K
eWRENDVVWnA1SnZZOUR1RFZGajFsdFZuaEdZJA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IFsyXSBkbWEtYnVmOiBoZWFwczogQWRkIE1lZGlhVGVrIHNlY3VyZSBoZWFwDQo+ID4g
PiA+ID4gLQ0KPiA+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiANCj4gDQo+IA0KaHR0cHM6Ly91cmxk
ZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51
eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9NzgyNzc2X187ISFDVFJOS0E5d01nMEFSYnchbVBvY2JR
d1o0LTI1RG1pZHZBZ2Q5SzVlWGpORWhTeUlLcHZ2WUhQcGRycTJQZ1MtaGtZeUhvaHpEdm9KeWRE
NDVVWnA1SnZZOUR1RFZGajEwc0Q0a0hFJA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IC0tLQ0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+IENLIEh1ICgxKToNCj4gPiA+ID4gPiAgIGRybS9tZWRpYXRlazog
QWRkIGludGVyZmFjZSB0byBhbGxvY2F0ZSBNZWRpYVRlayBHRU0NCj4gPiA+ID4gPiBidWZmZXIu
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSmFzb24tSkguTGluICg5KToNCj4gPiA+ID4gPiAgIGRy
bS9tZWRpYXRlay91YXBpOiBBZGQgRFJNX01US19HRU1fQ1JFQVRFRF9FTkNSWVBUVEVEIGZsYWcN
Cj4gPiA+ID4gPiAgIGRybS9tZWRpYXRlazogQWRkIHNlY3VyZSBidWZmZXIgY29udHJvbCBmbG93
IHRvIG10a19kcm1fZ2VtDQo+ID4gPiA+ID4gICBkcm0vbWVkaWF0ZWs6IEFkZCBzZWN1cmUgaWRl
bnRpZnkgZmxhZyBhbmQgZnVuY3V0aW9uIHRvDQo+ID4gPiA+ID4gbXRrX2RybV9wbGFuZQ0KPiA+
ID4gPiA+ICAgZHJtL21lZGlhdGVrOiBBZGQgbXRrX2RkcF9zZWNfd3JpdGUgdG8gY29uZmlnIHNl
Y3VyZSBidWZmZXINCj4gPiA+IA0KPiA+ID4gaW5mbw0KPiA+ID4gPiA+ICAgZHJtL21lZGlhdGVr
OiBBZGQgZ2V0X3NlY19wb3J0IGludGVyZmFjZSB0byBtdGtfZGRwX2NvbXANCj4gPiA+ID4gPiAg
IGRybS9tZWRpYXRlazogQWRkIHNlY3VyZSBsYXllciBjb25maWcgc3VwcG9ydCBmb3Igb3ZsDQo+
ID4gPiA+ID4gICBkcm0vbWVkaWF0ZWs6IEFkZCBzZWN1cmUgbGF5ZXIgY29uZmlnIHN1cHBvcnQg
Zm9yDQo+ID4gPiA+ID4gb3ZsX2FkYXB0b3INCj4gPiA+ID4gPiAgIGRybS9tZWRpYXRlazogQWRk
IHNlY3VyZSBmbG93IHN1cHBvcnQgdG8gbWVkaWF0ZWstZHJtDQo+ID4gPiA+ID4gICBhcm02NDog
ZHRzOiBtdDgxOTUtY2hlcnJ5OiBBZGQgc2VjdXJlIG1ib3ggc2V0dGluZ3MgZm9yDQo+ID4gPiA+
ID4gdmRvc3lzDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gIC4uLi9ib290L2R0cy9tZWRpYXRlay9t
dDgxOTUtY2hlcnJ5LmR0c2kgICAgICB8ICAxMCArDQo+ID4gPiA+ID4gIGRyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaCAgICAgICB8ICAgMyArDQo+ID4gPiA+ID4gIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYyAgICAgICB8ICAzMSArLQ0KPiA+ID4g
PiA+ICAuLi4vZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jICAgfCAgMTUg
Kw0KPiA+ID4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgICAg
ICAgfCAyNzENCj4gPiA+ID4gPiArKysrKysrKysrKysrKysrKy0NCj4gPiA+ID4gPiAgZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5oICAgICAgIHwgICAxICsNCj4gPiA+ID4g
PiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYyAgIHwgIDE0ICsN
Cj4gPiA+ID4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuaCAg
IHwgIDEzICsNCj4gPiA+ID4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2
LmMgICAgICAgIHwgIDE2ICstDQo+ID4gPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX2dlbS5jICAgICAgICB8IDEyMSArKysrKysrKw0KPiA+ID4gPiA+ICBkcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9nZW0uaCAgICAgICAgfCAgMTYgKysNCj4gPiA+ID4gPiAg
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYyAgICAgIHwgICA3ICsNCj4g
PiA+ID4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuaCAgICAgIHwg
ICAyICsNCj4gPiA+ID4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19tZHBfcmRtYS5j
ICAgICAgIHwgIDExICstDQo+ID4gPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
bWRwX3JkbWEuaCAgICAgICB8ICAgMiArDQo+ID4gPiA+ID4gIGluY2x1ZGUvdWFwaS9kcm0vbWVk
aWF0ZWtfZHJtLmggICAgICAgICAgICAgICB8ICA1OSArKysrDQo+ID4gPiA+ID4gIDE2IGZpbGVz
IGNoYW5nZWQsIDU3NSBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvdWFwaS9kcm0vbWVkaWF0ZWtfZHJtLmgNCj4gPiA+
ID4gPiANCg==

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6404F770EAA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 10:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjHEIGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 04:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjHEIGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 04:06:11 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C25E6A
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 01:06:03 -0700 (PDT)
X-UUID: e773c640336611eeb20a276fd37b9834-20230805
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=fTgi/H9p0mxFepVUf3/Iy6y6dAc0mNRWwoNtQvvaXlM=;
        b=lJhFdraK2bkjdNC4X7N4+5dm1g774mjdyQ9ZDl5t4miXpmH0ok7zem0lVJ9EGBlDCI2GsigQbnc57Gij6i57tgGcodafA2GZQfdDnaWewaXzcHo2guh+ggKDTz/yozZeR+ajZ32ogQwKYIVviAKinVArhpkGAoJ1sEF+Awu+DX0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:430dff30-72c9-424e-a9bc-234c91bc6783,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.30,REQID:430dff30-72c9-424e-a9bc-234c91bc6783,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:1fcc6f8,CLOUDID:f3c9b5d2-cd77-4e67-bbfd-aa4eaace762f,B
        ulkID:230805160555HWOXU4UW,BulkQuantity:1,Recheck:0,SF:19|48|38|29|28|17|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil
        ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,
        TF_CID_SPAM_FAS
X-UUID: e773c640336611eeb20a276fd37b9834-20230805
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 681701601; Sat, 05 Aug 2023 16:05:55 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 5 Aug 2023 16:05:54 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 5 Aug 2023 16:05:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4OtzJN2iemounMAlJYInufx+/+bIJU2ooFvBKVkT+aiQTl3QEdJXTRQvJgrDT2Yav30Ym/35n4F7hCYOxQzGwuN0GrR3J2OkVTuxy+fY6VFHUfCiWJAOOt5AnRF9BhA0Uif9Z0cDb+ar8FuJTcXtkWokipre1NrDeaSs5gLWoTC70s2JlLu7OWWC9eW/Q81tf4f0dTRui36VA2gsx8CP2vy8Qn0+FuF1GQXbWr20gOayYbq0Mpy0ydsQh7I6nmppuEQBhrR9HxksUA0raGFfSmMFXopow9C9iksgj6MsyA8lv3476wA63rtDSpeqFbf9qcOCDjzhRkH3wG25tVvqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTgi/H9p0mxFepVUf3/Iy6y6dAc0mNRWwoNtQvvaXlM=;
 b=jSFiZEd+8w0HmVwEgToGoAQKS9FQiDeFuMvxM0o5rX9kIv+2mM0+d8LsTGcmad3Cu+B4+ZJkXkf0MxcwI1La0ufEg7lwYVTD7hUCBemb/iRwecDnktSOiZKZ+a58rdJlAZrwc/AQzTaoM5DeSdPCFwe4PPmWKW+zbx+PGQFb0r6RRpvXBLn9cTOk3neiWi8T+U3uoREME6poPScHH3itTZkKNi3xElBHsNVrQWTDBP+hkkbVW5kddM9OmGdMu4urteQm5ImbUs8zIib9WBZzg8CaCDNP8edEehMxvMJ5IYAxsoVZZWhHQ3gOzfFbrkF8hDeKEd723W14+r8T26Pfww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTgi/H9p0mxFepVUf3/Iy6y6dAc0mNRWwoNtQvvaXlM=;
 b=qRD94reBEt34NGH5lTUNi3Z+9gCsauv/njHF/Ghnev6d9QjLLdfGyKnwjqXWnY7vGRO6WS4lvol7lCNumSxruVJhlGesLW0EzSEUHohJtVtxBUPlmU0294GlhCWsIXtv8gSRzkbXyBP2CdbkEtESXPfiFPNUVZ24RGPKtyWWBeY=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by KL1PR0302MB5265.apcprd03.prod.outlook.com (2603:1096:820:4d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.22; Sat, 5 Aug
 2023 08:05:52 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8%4]) with mapi id 15.20.6652.020; Sat, 5 Aug 2023
 08:05:51 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "eugen.hristev@collabora.com" <eugen.hristev@collabora.com>
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
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v8 3/8] drm/mediatek: Fix using wrong drm private data to
 bind mediatek-drm
Thread-Topic: [PATCH v8 3/8] drm/mediatek: Fix using wrong drm private data to
 bind mediatek-drm
Thread-Index: AQHZxVB0H+2V0QhwBEOU0aN+WJNnm6/YkIyAgALMHgA=
Date:   Sat, 5 Aug 2023 08:05:51 +0000
Message-ID: <9bbd9342654d5ce2036ff20043ec2e56e07ea848.camel@mediatek.com>
References: <20230802144802.751-1-jason-jh.lin@mediatek.com>
         <20230802144802.751-4-jason-jh.lin@mediatek.com>
         <3d5de892-8311-86e8-b962-0e564903b0e6@collabora.com>
In-Reply-To: <3d5de892-8311-86e8-b962-0e564903b0e6@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|KL1PR0302MB5265:EE_
x-ms-office365-filtering-correlation-id: 3daf91ce-c80b-4f1e-ce51-08db958ac914
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w4+0rm7/Z9lAMInBHS3twf8Wb2iFYmm8cFLHSD6TuzcU8TEuwukTjTj7pj/OYudy2iukP8tyZtmnWoOUFkDWCC7sfyUEEvEw/F3nMfPrlV4Mdqh/oCjbNtcyfnJfEvBw7ikIBDuE/mQN/txHCx0hoHgbXO1ZPutmmJxdlv1LttHtoB6StWPt6CPrCGUOOFBCWP3FsU8TNP/68rg+ZmD+7vAwdvd41UTdtPn2VdiaxFATojzZozJoy6h5cmpMysFpm2ClVlS2MaE7xB0pZvdCkFZhFDdjKS6jB67/nR1Hj3IOi7+P8YgL823UQODcsIiUd4Tx96nfXgguIUxQeZXrcfod9VfRNRYc5dk0SRKANyIhAjzhTGvtRQmP75uUe68c2BwajCZ/rlJBmWv9PURwcrEowe7qL5R6Uz8zPpiC3Bml4Si+nz7346ss+9d155509tjyxrMBSnALp4d/CH6ph1tPjyXXL41xUeopZxmyqEcXVr59vcgO5kumLpP8nbDdHLV3XBg5B/5CtY8wA8zJjfWm2hHbjBp7UpoqznwK3sVI2gJne4PoD3vociE9fH72VMhN/uVvICPCSs/8RmQZ707S+msL6VNO9UxaUZuuljCzOFQZn2u6D9RfQtEdFqynU+GTdpwEiGPdlcs4tynifUq2Ltan+o+9lBJD97sJAbI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(1800799003)(186006)(41300700001)(6486002)(6512007)(38100700002)(71200400001)(122000001)(2616005)(26005)(83380400001)(6506007)(53546011)(316002)(110136005)(54906003)(86362001)(38070700005)(478600001)(2906002)(66446008)(64756008)(66476007)(4326008)(85182001)(91956017)(66946007)(36756003)(76116006)(66556008)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUdyc0wydjJDWjk5K3I1cmhyZDU0REhQNWs3bmdHczN5WDIrSlBNSVBZT0JR?=
 =?utf-8?B?RmljTXBtZEJaMXdlcCtMQzc4UlpkMDZuN2ZydUJOcDdoUTZ0OGpvRVQ2dXJD?=
 =?utf-8?B?SWVNZ0NlTVVXT3ZjZHh0V1VBN09PMjFwblc4emcyS3BTNC9mZXdLT1lzU1FO?=
 =?utf-8?B?SnBPMGY3QytISElRb2M0RXZRMzJJUXo5MnR6RVhEUmFjVU9yT0R6MjgrNHJR?=
 =?utf-8?B?ZXVwSFBUNlNXVFZGemQyWTVsMGk0eWplVUFlZ3g1TEpNako2NXlnemlKRGxo?=
 =?utf-8?B?MTAvWGM4QkN3ek5qYXhPeitKYTAxMUg2VGdUQi9uSm1zRGdPdGEwOEh3UUxX?=
 =?utf-8?B?Vmo0Q3JvZUJXYTB1MitiQXhPUWY4UXk4OURobHNRd2h1NGZZaEU5OVZXMnlL?=
 =?utf-8?B?U1YwUzFJNi9uYS9vYk92TGlQandoMWN0OGlTdGFEcWJ1bEhTWFRwZll5M01s?=
 =?utf-8?B?RjAwU3g0Q2NZMTJsMXFUb1hlb3g1ZjI1c2s0OVZFSVYzcDJIRUZObFROTnRW?=
 =?utf-8?B?bnZoL2VSOTJ3Um92VU9wSUg5RlppYzNBNm85VkFLcS9aa2t1QlBTSGczWVpM?=
 =?utf-8?B?UnZXVlhsaFJZRWc0OVRUcWF3ZmlHSVN3aEtqVnNZekZYVm1TYjE5cHJhOVF6?=
 =?utf-8?B?TGJ1ZUkzNHhpNnY1YXNHdXdIbHhGcjdCS1hFQVA3aCtKS3VJUFNnKzZndGli?=
 =?utf-8?B?L0NDSXNJS3l4UnVOMjdwVmFqdVlvTUNYc2J4OWtEb25XYmVHNy9NSmN2ZkRU?=
 =?utf-8?B?Y1ZkeW94dWdrMlBjNzFZbXZISDJDcjRxSUw2dnp2RVFYVi9OVVR0OGZrVFJy?=
 =?utf-8?B?R2I5VVFoWStIZ01VWXdvQ3l4dlprR0Zxc2l4WjNPOWlDbVhQTXJHMlNldCs4?=
 =?utf-8?B?ZWZjNVN3WVlJZ2NXdW00VFIwQWZucXppdGhjVDI3NjZiTzUxT1RzUE5IVUVF?=
 =?utf-8?B?Y2hXNHVyQ2tPLzBKREx5aHFFWWg0c1E0M2RTaWdBV3BQN1JTaSticGpDZ1pC?=
 =?utf-8?B?d2ZVU1ZTSmJobjJlVzh4TStsd2xsOThYMGJVSUlFbVd2ZVpxQXhMVzZlbkJw?=
 =?utf-8?B?ZFJrRDlhbDJuaGNpbHJ6QnNFdGRlS1BLRHR5MTBFTnVWZGRZNERvcXRlQ25T?=
 =?utf-8?B?WTArVWNmbnhkalVDL3hvUjBRemlvV1JaYWt6Y0V6QUV0ajBlOW5CdklYdk1i?=
 =?utf-8?B?ZU1VRmdId1Qwd2YrVWFpQWhzclY3Yk1DSVFDU0FpUG9HeWYxd3grVHV4b1JQ?=
 =?utf-8?B?VU1QTlhuVVd3azlVNUVyNzl2MDFSY2FxZmN6MzNQK3lsWFFMc0oyY2RLTXhz?=
 =?utf-8?B?ODl3Qi9RcUpPR0cxR1pseHJKNTNZbWJUVHVkcnlOS1F1dmwwYzNvVDV4emV6?=
 =?utf-8?B?ckZ4V1VMU3R5MHZRbmYvSk1LWm1CSWM4Y1NCM2FyNDY0UGtmNGZNODIrR3ZN?=
 =?utf-8?B?a1RMK21mQzVWREU3MEgxRzJQaGlkVG1tMms0VEY2ZlRLRElmeHZKNUozUnIx?=
 =?utf-8?B?V3pUQ1hkWTkrbVY3a3FyQjk2eXpaNkNFZ2kwTGd4Y1M5ZFBTdmlGUU9RTm56?=
 =?utf-8?B?ZWVFaVdsWDF4c2ZtU0ZIUFFiR3Y4NGgvOVF0L1lUM3I0YWg2ZTRVV21SZGp1?=
 =?utf-8?B?QWFTdnRmRFZYQnkwR3pjMjFYTHNpUFgzc3JHTkFudkptNGx3MjlpcmUrL1g0?=
 =?utf-8?B?bmFZVUV3MzZHWkx4UERrNzZPaXNJeHo4bk9DNXo4Y3ZQaG9yTE1LMEFMT09R?=
 =?utf-8?B?VkZid2lETGxCS0Fqc0wrZEdORmtkcnFFLzZKLy9SYkhPbDVCQUYrZGRFcDQx?=
 =?utf-8?B?M3M0RDg0YmVTdjREb1FFUE54TjVybEU1M2VtODUwWXVManZ3WXArbWp2YmY5?=
 =?utf-8?B?b3g5bm9IWjY1VlVjaXB0WC8wdndrblo2dmJNWFQrYUNQZStrbzJQak45bmMz?=
 =?utf-8?B?MnpsNkhMd0VlR2dOWkEwNjZkOXFQcUl3TnZjRHZqbmY1am9QUjhESjhRUUxl?=
 =?utf-8?B?S2Q1Q0hUWktKSVJNM3pEd1NPM1hmUmxoY0NmWk5VNFJrQTBEbEtoNGdzWmNN?=
 =?utf-8?B?VkxCTlUxbW93WDQwUjNUalZlZjc4MldNbzNlN0YyVmtBc2J5eTRLM1QwMDZO?=
 =?utf-8?B?YUdrU2Q0QlduOFdHbGN1R244WjVURVk1TlE0NDJWWW5GaFN5RDRmZ2ViVVlz?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0135C74CAC57D409831E423A753945F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3daf91ce-c80b-4f1e-ce51-08db958ac914
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2023 08:05:51.4047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OzXjJ1doUHTFDLeAN8H+3SCZsYZMrmVj60V1lPcBtm+Pp0c7UD7UW4IWV8qt6Fz68L/G5iI9S1Hdm9IGbxDZ/fgdJpHFFQQsuKFYHmRjv08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5265
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRXVnZW4sDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIFRodSwgMjAyMy0wOC0w
MyBhdCAxNjoyMiArMDMwMCwgRXVnZW4gSHJpc3RldiB3cm90ZToNCj4gT24gOC8yLzIzIDE3OjQ3
LCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+ID4gSW4gbXRrX2RybV9rbXNfaW5pdCgpLCBlYWNoIGVs
ZW1lbnQgaW4gYWxsX2RybV9wcml2IHNob3VsZCBoYXMgb25lDQo+ID4gZGlzcGxheSBwYXRoIHBy
aXZhdGUgZGF0YSBvbmx5LCBzdWNoIGFzOg0KPiA+IGFsbF9kcm1fcHJpdltDUlRDX01BSU5dIHNo
b3VsZCBoYXMgbWFpbl9wYXRoIGRhdGEgb25seQ0KPiA+IGFsbF9kcm1fcHJpdltDUlRDX0VYVF0g
c2hvdWxkIGhhcyBleHRfcGF0aCBkYXRhIG9ubHkNCj4gPiBhbGxfZHJtX3ByaXZbQ1JUQ19USElS
RF0gc2hvdWxkIGhhcyB0aGlyZF9wYXRoIGRhdGEgb25seQ0KPiANCj4gcy9zaG91bGQgaGFzL3No
b3VsZCBoYXZlLyA/DQo+IA0KDQpBbHRob3VnaCBlYWNoIGVsZW1lbnQgaXMgc2luZ3VsYXIsIGBz
aG91bGQgaGF2ZWAgaXMgY29ycmVjdC4NCg0KYHNob3VsZGAgaXMgYW4gYXV4aWxpYXJ5IHZlcmIs
IHNvIHdlIGNhbiBvbmx5IHVzZSBpbmZpbml0aXZlIHZlcmJzDQphZnRlciB0aGF0LiANCg0KU28g
dGhpcyBwYXJ0IG9mIGNvbW1lbnQgc2hvdWxkIGJlIGxpa2UgdGhpczoNCkluIG10a19kcm1fa21z
X2luaXQoKSwgZWFjaCBlbGVtZW50IGluIGFsbF9kcm1fcHJpdiBzaG91bGQgaGF2ZSBvbmUNCmRp
c3BsYXkgcGF0aCBwcml2YXRlIGRhdGEsIHN1Y2ggYXM6DQphbGxfZHJtX3ByaXZbQ1JUQ19NQUlO
XSBzaG91bGQgb25seSBoYXZlIG1haW5fcGF0aCBkYXRhDQphbGxfZHJtX3ByaXZbQ1JUQ19FWFRd
IHNob3VsZCBvbmx5IGhhdmUgZXh0X3BhdGggZGF0YQ0KYWxsX2RybV9wcml2W0NSVENfVEhJUkRd
IHNob3VsZCBvbmx5IGhhdmUgdGhpcmRfcGF0aCBkYXRhDQoNClJpZ2h0Pw0KDQo+ID4gDQo+ID4g
U28gd2UgbmVlZCB0byBhZGQgdGhlIGxlbmd0aCBjaGVja2luZyBmb3IgZWFjaCBkaXNwbGF5IHBh
dGggYmVmb3JlDQo+ID4gYXNzaWduaW5nIHRoZWlyIGRybSBwcml2YXRlIGRhdGEgaW50byBhbGxf
ZHJtX3ByaXYgYXJyYXkuDQo+ID4gDQo+ID4gRml4ZXM6IDFlZjdlZDQ4MzU2YyAoImRybS9tZWRp
YXRlazogTW9kaWZ5IG1lZGlhdGVrLWRybSBmb3IgbXQ4MTk1DQo+ID4gbXVsdGkgbW1zeXMgc3Vw
cG9ydCIpDQo+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVk
aWF0ZWsuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8
DQo+ID4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiA+IFJldmll
d2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMgfCAxNiArKysrKysrKysrKysrLS0tDQo+
ID4gICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2
LmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+ID4gaW5k
ZXggODlhMzg1NjFiYTI3Li5jMTI4ODZmMzFlNTQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiA+IEBAIC0zNTEsNiArMzUxLDcgQEAgc3RhdGljIGJv
b2wgbXRrX2RybV9nZXRfYWxsX2RybV9wcml2KHN0cnVjdA0KPiA+IGRldmljZSAqZGV2KQ0KPiA+
ICAgew0KPiA+ICAgCXN0cnVjdCBtdGtfZHJtX3ByaXZhdGUgKmRybV9wcml2ID0gZGV2X2dldF9k
cnZkYXRhKGRldik7DQo+ID4gICAJc3RydWN0IG10a19kcm1fcHJpdmF0ZSAqYWxsX2RybV9wcml2
W01BWF9DUlRDXTsNCj4gPiArCXN0cnVjdCBtdGtfZHJtX3ByaXZhdGUgKnRlbXBfZHJtX3ByaXY7
DQo+ID4gICAJc3RydWN0IGRldmljZV9ub2RlICpwaGFuZGxlID0gZGV2LT5wYXJlbnQtPm9mX25v
ZGU7DQo+ID4gICAJY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCAqb2ZfaWQ7DQo+ID4gICAJc3Ry
dWN0IGRldmljZV9ub2RlICpub2RlOw0KPiA+IEBAIC0zNzMsOSArMzc0LDE4IEBAIHN0YXRpYyBi
b29sIG10a19kcm1fZ2V0X2FsbF9kcm1fcHJpdihzdHJ1Y3QNCj4gPiBkZXZpY2UgKmRldikNCj4g
PiAgIAkJaWYgKCFkcm1fZGV2IHx8ICFkZXZfZ2V0X2RydmRhdGEoZHJtX2RldikpDQo+ID4gICAJ
CQljb250aW51ZTsNCj4gPiAgIA0KPiA+IC0JCWFsbF9kcm1fcHJpdltjbnRdID0gZGV2X2dldF9k
cnZkYXRhKGRybV9kZXYpOw0KPiA+IC0JCWlmIChhbGxfZHJtX3ByaXZbY250XSAmJiBhbGxfZHJt
X3ByaXZbY250XS0NCj4gPiA+bXRrX2RybV9ib3VuZCkNCj4gPiAtCQkJY250Kys7DQo+ID4gKwkJ
dGVtcF9kcm1fcHJpdiA9IGRldl9nZXRfZHJ2ZGF0YShkcm1fZGV2KTsNCj4gPiArCQlpZiAodGVt
cF9kcm1fcHJpdikgew0KPiANCj4gVGhpcyBpcyBpbnNpZGUgYSAnZm9yJyBsb29wIHJpZ2h0ID8N
Cj4gV2h5IGRvbid0IHlvdSBqdXN0ICdjb250aW51ZScgaWYgdGVtcF9kcm1fcHJpdiBpcyBudWxs
ID8NCj4gDQoNClllcywgeW91IGFyZSByaWdodC4NCkknbGwgdXNlIGBpZiAoIXRlbXBfZHJtX3By
aXYpIGNvbnRpbnVlO2AgdG8gbWFrZSB0aGlzIHN0YXRlbWVudA0Kc2ltcGxlci4gVGhhbmtzLg0K
DQpSZWdhcmRzLA0KSmFzb24tSkguTGluLg0KDQo+IA0KPiA+ICsJCQlpZiAodGVtcF9kcm1fcHJp
di0+bXRrX2RybV9ib3VuZCkNCj4gPiArCQkJCWNudCsrOw0KPiA+ICsNCj4gPiArCQkJaWYgKHRl
bXBfZHJtX3ByaXYtPmRhdGEtPm1haW5fbGVuKQ0KPiA+ICsJCQkJYWxsX2RybV9wcml2W0NSVENf
TUFJTl0gPQ0KPiA+IHRlbXBfZHJtX3ByaXY7DQo+ID4gKwkJCWVsc2UgaWYgKHRlbXBfZHJtX3By
aXYtPmRhdGEtPmV4dF9sZW4pDQo+ID4gKwkJCQlhbGxfZHJtX3ByaXZbQ1JUQ19FWFRdID0gdGVt
cF9kcm1fcHJpdjsNCj4gPiArCQkJZWxzZSBpZiAodGVtcF9kcm1fcHJpdi0+ZGF0YS0+dGhpcmRf
bGVuKQ0KPiA+ICsJCQkJYWxsX2RybV9wcml2W0NSVENfVEhJUkRdID0NCj4gPiB0ZW1wX2RybV9w
cml2Ow0KPiA+ICsJCX0NCj4gPiAgIAl9DQo+ID4gICANCj4gPiAgIAlpZiAoZHJtX3ByaXYtPmRh
dGEtPm1tc3lzX2Rldl9udW0gPT0gY250KSB7DQo+IA0KPiANCg==

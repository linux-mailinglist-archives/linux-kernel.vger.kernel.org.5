Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F3775744D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjGRGgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjGRGgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:36:32 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FFE134;
        Mon, 17 Jul 2023 23:36:30 -0700 (PDT)
X-UUID: 6ac856b8253511eeb20a276fd37b9834-20230718
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=MgAIyP/EeL3QviPAwe54LqojY+ukTMtEEOuIrQ2mQsU=;
        b=XbKzsDhrP/hhnzQvd2hKMUcDSCy9iNo300V589zjGRSjAA/k9pddMQWkxhRjrFIRlk/criGa/WR2LeO038FdHSNq+vCBrWlE4ydwxWG9sj7ADHIU2OO/3YQ2tt+CILO0XHXzqHE9I/XVuZeJemY5kOnjN2g/4sqyUqcWjHcCve0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:89d3fd4d-6dce-4eda-be32-55107c03eb63,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:176cd25,CLOUDID:7257b8dc-dc79-4898-9235-1134b97257a8,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 6ac856b8253511eeb20a276fd37b9834-20230718
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <jason-ch.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 300630653; Tue, 18 Jul 2023 14:36:25 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 18 Jul 2023 14:36:24 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 18 Jul 2023 14:36:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhxXpCGKSxQRRY8jJllH+ETOrGHhOmpRf2flK29S5Osy12skUL95gz81p2Dm1bh+eFxhoVqy6q3ODNpuP5xhlyyUvIE4J+ZawZ8z0dvvxJjaVYYNBMAz5nOh3f/McuaF5/mcxS+6TUiGw8bWsQcZhcN6NTagZiTJuSFFi75qFfAitQVJv6q+oFhuOz1K+pJV+u6dlMxmlfVM2Gwwe93u+XXfHCCikM3BaF2TBfUtOY6r41DHYDRGldmswGw5VBbDtDsTGo/o+3fMKBIcSBYJ9uiLy3/FS1Pkfm/9w8HDm1p0DJKOHOHHkTuNKzOVrrvD6iEwnkTr6k1skEf1dSEc5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgAIyP/EeL3QviPAwe54LqojY+ukTMtEEOuIrQ2mQsU=;
 b=l7fMBnAGkXZSqFPCkuNUO2l4FbVJZx4LMMSRWZYlhtZHy8abCEZeIkdrxKufCSm+BfYtdOf7UcnQD8yQOGr2/P/fyCKpqG/u0x/6VNKbpwe4ptgKeaQ/A2Cd+A3TGtAdywcIhpJLzzLJfM9kX4Ac5+lawsp7cnIEr0Xche3IPi/rZr/wnTjywisyHYw1SeoTCktt7+MkXoCJwiRRE9rwCk4D7AM4mj81H0roNJSr2DNu/iD1FiGR/oGwQtXOYqsStFfjnIVEHA87tZDUCfXqO8DWnPdGfH6For2/QOmw9kHHS7QymoIJn+WvunrnYqJIT5z5AKXu6UHKE1cX7/wv6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgAIyP/EeL3QviPAwe54LqojY+ukTMtEEOuIrQ2mQsU=;
 b=KwK2dhoZHGw0S6JbgrHYiSxIsX+qIlnV9+exjE32bNJCMOKG8C7r6cDvu5v/7383tFTmytxVmP21qGkn36nGUnSE2nz/lEEc8GhvQtXKkCPUhwh4KA4hwqkE4+yjPeU2q/lnvcAqgGPc683HCJEjz1KhllKjap9CEVA0Jz92sD0=
Received: from KL1PR03MB5650.apcprd03.prod.outlook.com (2603:1096:820:73::5)
 by TYSPR03MB7823.apcprd03.prod.outlook.com (2603:1096:400:480::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 06:36:20 +0000
Received: from KL1PR03MB5650.apcprd03.prod.outlook.com
 ([fe80::27f3:ca11:2b8a:475b]) by KL1PR03MB5650.apcprd03.prod.outlook.com
 ([fe80::27f3:ca11:2b8a:475b%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 06:36:20 +0000
From:   =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] arm64: dts: Add MediaTek MT8188 dts and evaluation
 board and Makefile
Thread-Topic: [PATCH v3 4/4] arm64: dts: Add MediaTek MT8188 dts and
 evaluation board and Makefile
Thread-Index: AQHZuKbL6i9A+qQZX0CZYfm+vuSMCq++YLMAgACyUYA=
Date:   Tue, 18 Jul 2023 06:36:20 +0000
Message-ID: <f0055b0f42388ff0da395bd9de7b86ce40bf77c1.camel@mediatek.com>
References: <20230717120300.21388-1-jason-ch.chen@mediatek.com>
         <20230717120300.21388-5-jason-ch.chen@mediatek.com>
         <43ecf0b0-4b55-ab11-3b80-b9243b971c2c@linaro.org>
In-Reply-To: <43ecf0b0-4b55-ab11-3b80-b9243b971c2c@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5650:EE_|TYSPR03MB7823:EE_
x-ms-office365-filtering-correlation-id: 8654bc46-dce7-4300-1615-08db87594c86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: syAa67lJA5G0l1xQW9MC8vVo7TTJmvC55YCV9WMIka0JZ12bzz9kIj6/p/1fUbSizq510mFToL4enyDY+Twi9MWFxMRRx+pSgEJo6vPdnQScXo9fseVf/yNknx+Mma7TZXRZ7KokRehyCrL5qwV55qrIGL/DIWvOYiBa9Oiyc8ReuiG5GTNuViRe+TMvKxTBIYX9WvrdLv62kiYICd9JLyEtT53pxv9sRTVZy8oM0eA+z9ePcLDKEw/v9Od0i0w/gJWBT0z56tr+hZn1d5qBhgkC2UVg7d003Io97xAySMCZaiQ76j5ElxeZOKBI7M+Tv7Zv0X84HyXrEylDy42ZfCv5WCIGuhhiTRqraWyPh1bv70caBfBXmFWwXnwLHUBU/drw3i0zZr8irV+jqakQdtIYr7mmTfYiZB3cUL3K2UCugskwxAs9q584x9Z20kPl3E8p/ARBpmFsHD2wtIShrXnW8rSdGTLqapJOTDIFTEcRdIDiDua66otI5Rue07g4en1V7Ap6bE+UYCmGezFIXyxUeBr6IzF1y4kBx5828lrPJoOvpX61Td3ADnTuZjxoCIxH501eZz1C1wLRboMxemaa0CeB/k2F7p6Ld1ceaT+k0ZTeaLC9xo+zQ7wdkXI4/Yh6lVXinthM0yesgOb14bhsMsOtD1rur6DkZq7ze5E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5650.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199021)(316002)(41300700001)(83380400001)(53546011)(6512007)(186003)(2616005)(26005)(6506007)(966005)(6486002)(478600001)(110136005)(54906003)(122000001)(71200400001)(4326008)(76116006)(91956017)(66446008)(66946007)(66556008)(66476007)(64756008)(38100700002)(7416002)(86362001)(5660300002)(8676002)(2906002)(85182001)(38070700005)(8936002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWJQWnlmRXBSZlMzM0ZTOTZJU0Myc25hRXJMRWJjNU1uai96K1hmK3BkZWNv?=
 =?utf-8?B?VXdjWUN1L0JsR1FpaXJDa1VFRHFwLzQ5VjdQbFl6MEFtYkZ0WjU4R284Q2dN?=
 =?utf-8?B?MU1EODA1NWhSOTIvVXNxcUpkODUvT0N2dkFkajY5dVZhMmNBKzB1NFF5VkhC?=
 =?utf-8?B?T1ptSmNyK1FpcThXeTFCekxvYTlidWdNY0VmcVgwZDRwaGs0ajVROUdySnlt?=
 =?utf-8?B?R1FyTEVyMElpeDcvMEFnOHNJZ3BrenBOSnl6eWRWeW9BaXhGQm5YNFBqbUgr?=
 =?utf-8?B?Z2MxM1hPai9wRURuN0FScmVyaTMyVXVuZTRSMTB4cGk4NFYzb1RaTjRXd2Qw?=
 =?utf-8?B?RFNRQk5lNGlKSDBLY282NU5rNWRTSFJYWjF6RGdtRzcwVmNybDRKVk5GUjVL?=
 =?utf-8?B?L2xWK3Z6L0IwZUZ5R1N1M2RsQXk5N1g4eUw1WFZBbEZuTlNuUUxoNHBRb05U?=
 =?utf-8?B?V2lFaFhVU2hzQXRIQlVUZlJuakN1bmdrRlM3RnUxMGsxeXZ5V0l6a0FKZVFa?=
 =?utf-8?B?YXFFT083UUFqL28wWUJ5VVNiNnFKcjBXZGtKbUxlcnM4YlZtRjFvTUI3eGtM?=
 =?utf-8?B?Q0h6bVpCcWpOQXVxOG8vWXFid1NDK1BHOCtMaDhnMHhIb3JtakFIM0NSVHZZ?=
 =?utf-8?B?RGJWSlBxeVRKYW5vV3N2bU85Y2xpOTRQVFRWbEc2YVRiL3ZkQWhFSTliTVJ4?=
 =?utf-8?B?a25TMytEaEw1dGtqc3hpWEQwak9sc2pjcmc5ZndiV2FLa2NxRmdCQmhMUEt6?=
 =?utf-8?B?alo3NVg4K2xJUEIvU01RWFJwdzBRZ3ZyT0FKZ3dHOXozTzNIZUJSVHNOQlVl?=
 =?utf-8?B?SXhBYUhFTmFSeGhOckpBNm9pQzgvdFY4WXpwUTJJRUljVUl2MXdlWWRsOUFV?=
 =?utf-8?B?NGl0L3UrWFNrY2dVaFFUVnFhYStMMmgySjBIdFRaaDFId0YrY01selg0RXJQ?=
 =?utf-8?B?UlNRMHJnMGRrOFhjRm5haDZtWldSd2l6ZG56VERQOTRFRlBJaWMvVVdwZVBN?=
 =?utf-8?B?UWtPMkJHSytCanRaZWl3ZXJBWDRyNncrWGFxRXlCZFNsSTllUitidFNKNGs4?=
 =?utf-8?B?MzhyRzVoUDYxcXFuMkZxcXRMdmkxMnZFaERlNWx1TmJDRUROOTd3YUdCZFVL?=
 =?utf-8?B?WUh0WVh0bjJzTXd1bEhTU0ZKdFlXWU9xeGE3SFFxSlFNTWl3SDduTC9LMXJt?=
 =?utf-8?B?NW1BbXNpL0w0bmE1TXR3akFEbEhLNUFDdVZWcWxSS0kzS0NrdmE5U1VaZGdY?=
 =?utf-8?B?Qm5ITWYvWXZKclM4M1I5YTArN051dTFHdW92cEptY2xmenpqemJHMitseEMx?=
 =?utf-8?B?RWJRR3N2ZnNhQnQyQVM0UDMyYVhCblVlVnJMQ01CRXdOUEFtWTZYZVdJWHVS?=
 =?utf-8?B?bHphMTllZFNCYUhmNFJnc3U2ZnVBZDBxVld0a05wblpKekJsc1ZIWUlrcTc0?=
 =?utf-8?B?bFZsMytGaEJMeHMrVHFaa3hrSUlSOHhERnhITUg0NXUvZTFOYmNDdFFScUpT?=
 =?utf-8?B?YlRmbWZFODRLQUdZTEYwNTJwREF4MXdPRklxY2Q3djdrNFFRQndIN3lQMzlH?=
 =?utf-8?B?Tm1sWXJtY2wvdFNWWmNWRktSZmJ6QUpoZmxScFFxNVMxc0wvc0tiUlZZdkN5?=
 =?utf-8?B?c1M3ZTRvcXZhTkpiY1BUa2tnS0o3M3orUndSUVV3UHJnTnhPYllUdW96ZktG?=
 =?utf-8?B?d1BmYUdNREx2NlR5ZEsySnhDYUsxMDhTejhhQjI5ZEg2K003cThvUWtkYTk5?=
 =?utf-8?B?M3hjOHAvcHVST0FjZ0xMeTQ5T0RXcmpyZEFteXNOSEFhNjRBOUNvVHdxMlpL?=
 =?utf-8?B?WmEwWGlnN3hJVDNVQ0JORUVNd0J1eWoyMW1mL1FQV0kyRlFOOE1Gd3l0RkFB?=
 =?utf-8?B?eVR0ckFaSk5UUjZpU3lhUFpNdDZuMzhPbmQ2TWY5c1BCOTdYWk9QLzgrb2Fu?=
 =?utf-8?B?dDZTYVNkRzFROElzL1BrMDdvaGgvbmllbFlDSWNaODd3eElGUlg4L1pvelR3?=
 =?utf-8?B?d0NKOXFJL1VOU1RIblhiTFl2ZjdpbE9ZOTFpMTVxOUR3SnRrWkZwV3lTQ2l0?=
 =?utf-8?B?L2lKcXVielBQWUdvdkNQa3QzVWFoZGhDYUl5V0IwMzN1UEVRTUNBaDJKajRC?=
 =?utf-8?B?VmFXUGpXeHVPU3N0MWdUVDhBZXN6MlRuVEU0SmhiWTN1V1RuWlcwMGFyaW9Y?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <026D692BA8A5BE4D84CFCF7BD040DA85@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5650.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8654bc46-dce7-4300-1615-08db87594c86
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 06:36:20.8179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yy9d1OsfsYUyv9fnRU0Nql17f/mE/a8Xm5yaGWME1mU7xEkvEYT0p5flvUXYHdsgh3+gI6E97ggPYOpcC08QjrYIjBLvlasdEADKgMe47gM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7823
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpPbiBNb24sIDIwMjMtMDctMTcgYXQgMjE6NTggKzAyMDAsIEtyenlz
enRvZiBLb3psb3dza2kgd3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBk
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2
ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgT24gMTcvMDcvMjAyMyAxNDow
MywgSmFzb24tY2ggQ2hlbiB3cm90ZToNCj4gPiBGcm9tOiBqYXNvbi1jaCBjaGVuIDxKYXNvbi1j
aC5DaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBNVDgxODggaXMgYSBTb0MgYmFzZWQgb24g
NjRiaXQgQVJNdjggYXJjaGl0ZWN0dXJlLiBJdCBjb250YWlucyA2DQo+IENBNTUNCj4gPiBhbmQg
MiBDQTc4IGNvcmVzLiBNVDgxODggc2hhcmUgbWFueSBIVyBJUCB3aXRoIE1UNjV4eCBzZXJpZXMu
DQo+ID4gDQo+ID4gV2UgYWRkIGJhc2ljIGNoaXAgc3VwcG9ydCBmb3IgTWVkaWFUZWsgTVQ4MTg4
IG9uIGV2YWx1YXRpb24gYm9hcmQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogamFzb24tY2gg
Y2hlbiA8SmFzb24tY2guQ2hlbkBtZWRpYXRlay5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEFuZ2Vs
b0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xs
YWJvcmEuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL01h
a2VmaWxlICAgICAgIHwgICAxICsNCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9t
dDgxODgtZXZiLmR0cyB8IDQwMSArKysrKysrKysNCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9t
ZWRpYXRlay9tdDgxODguZHRzaSAgICB8IDk1MQ0KPiArKysrKysrKysrKysrKysrKysrKw0KPiA+
ICAzIGZpbGVzIGNoYW5nZWQsIDEzNTMgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAx
MDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODgtZXZiLmR0cw0KPiA+ICBj
cmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODguZHRz
aQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL01h
a2VmaWxlDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9NYWtlZmlsZQ0KPiA+IGlu
ZGV4IGM5OWMzMzcyYTRiNS4uOWJkMjMyNDI1OWEzIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvbWVkaWF0ZWsvTWFrZWZpbGUNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL21lZGlhdGVrL01ha2VmaWxlDQo+ID4gQEAgLTQ0LDYgKzQ0LDcgQEAgZHRiLSQoQ09ORklH
X0FSQ0hfTUVESUFURUspICs9IG10ODE4My1rdWt1aS0NCj4ga3JhbmUtc2t1MC5kdGINCj4gPiAg
ZHRiLSQoQ09ORklHX0FSQ0hfTUVESUFURUspICs9IG10ODE4My1rdWt1aS1rcmFuZS1za3UxNzYu
ZHRiDQo+ID4gIGR0Yi0kKENPTkZJR19BUkNIX01FRElBVEVLKSArPSBtdDgxODMtcHVtcGtpbi5k
dGINCj4gPiAgZHRiLSQoQ09ORklHX0FSQ0hfTUVESUFURUspICs9IG10ODE4Ni1ldmIuZHRiDQo+
ID4gK2R0Yi0kKENPTkZJR19BUkNIX01FRElBVEVLKSArPSBtdDgxODgtZXZiLmR0Yg0KPiA+ICBk
dGItJChDT05GSUdfQVJDSF9NRURJQVRFSykgKz0gbXQ4MTkyLWFzdXJhZGEtaGF5YXRvLXIxLmR0
Yg0KPiA+ICBkdGItJChDT05GSUdfQVJDSF9NRURJQVRFSykgKz0gbXQ4MTkyLWFzdXJhZGEtc3Bo
ZXJpb24tcjAuZHRiDQo+ID4gIGR0Yi0kKENPTkZJR19BUkNIX01FRElBVEVLKSArPSBtdDgxOTIt
ZXZiLmR0Yg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210
ODE4OC1ldmIuZHRzDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODgtZXZi
LmR0cw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5k
ODkwNjE3MjM5MGUNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290
L2R0cy9tZWRpYXRlay9tdDgxODgtZXZiLmR0cw0KPiA+IEBAIC0wLDAgKzEsNDAxIEBADQo+ID4g
Ky8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBNSVQpDQo+ID4gKy8qDQo+
ID4gKyAqIENvcHlyaWdodCAoQykgMjAyMyBNZWRpYVRlayBJbmMuDQo+ID4gKyAqLw0KPiA+ICsv
ZHRzLXYxLzsNCj4gPiArI2luY2x1ZGUgIm10ODE4OC5kdHNpIg0KPiA+ICsjaW5jbHVkZSAibXQ2
MzU5LmR0c2kiDQo+ID4gKw0KPiA+ICsvIHsNCj4gPiArbW9kZWwgPSAiTWVkaWFUZWsgTVQ4MTg4
IGV2YWx1YXRpb24gYm9hcmQiOw0KPiA+ICtjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4OC1l
dmIiLCAibWVkaWF0ZWssbXQ4MTg4IjsNCj4gPiArDQo+ID4gK2FsaWFzZXMgew0KPiA+ICtzZXJp
YWwwID0gJnVhcnQwOw0KPiA+ICtpMmMwID0gJmkyYzA7DQo+ID4gK2kyYzEgPSAmaTJjMTsNCj4g
PiAraTJjMiA9ICZpMmMyOw0KPiA+ICtpMmMzID0gJmkyYzM7DQo+ID4gK2kyYzQgPSAmaTJjNDsN
Cj4gPiAraTJjNSA9ICZpMmM1Ow0KPiA+ICtpMmM2ID0gJmkyYzY7DQo+ID4gK21tYzAgPSAmbW1j
MDsNCj4gPiArfTsNCj4gPiArDQo+ID4gK2Nob3NlbjogY2hvc2VuIHsNCj4gPiArc3Rkb3V0LXBh
dGggPSAic2VyaWFsMDoxMTUyMDBuOCI7DQo+ID4gK2thc2xyLXNlZWQgPSA8MCAwPjsNCj4gDQo+
IEl0IGRvZXMgbm90IGxvb2sgbGlrZSB5b3UgdGVzdGVkIHRoZSBEVFMgYWdhaW5zdCBiaW5kaW5n
cy4gUGxlYXNlIHJ1bg0KPiBgbWFrZSBkdGJzX2NoZWNrYCAoc2VlDQo+IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy93cml0aW5nLXNjaGVtYS5yc3Qgb3INCj4gDQpodHRwczovL3d3
dy5saW5hcm8ub3JnL2Jsb2cvdGlwcy1hbmQtdHJpY2tzLWZvci12YWxpZGF0aW5nLWRldmljZXRy
ZWUtc291cmNlcy13aXRoLXRoZS1kZXZpY2V0cmVlLXNjaGVtYS8NCj4gZm9yIGluc3RydWN0aW9u
cykuDQo+IA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3Lg0KSSBhY3R1YWxseSByYW4gZHRi
c19jaGVjaywgYnV0IGl0IGRpZG4ndCBkaXNwbGF5IGFueSBwcm9ibGVtcyBoZXJlLiBJDQp3aWxs
IHJlbW92ZSBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQo+ID4gK307DQo+ID4gKw0KPiA+ICtt
ZW1vcnlANDAwMDAwMDAgew0KPiA+ICtkZXZpY2VfdHlwZSA9ICJtZW1vcnkiOw0KPiA+ICtyZWcg
PSA8MCAweDQwMDAwMDAwIDAgMHg4MDAwMDAwMD47DQo+ID4gK307DQo+ID4gKw0KPiA+ICtyZXNl
cnZlZF9tZW1vcnk6IHJlc2VydmVkLW1lbW9yeSB7DQo+ID4gKyNhZGRyZXNzLWNlbGxzID0gPDI+
Ow0KPiA+ICsjc2l6ZS1jZWxscyA9IDwyPjsNCj4gPiArcmFuZ2VzOw0KPiA+ICsNCj4gPiArc2Nw
X21lbV9yZXNlcnZlZDogc2NwX21lbV9yZWdpb24gew0KPiANCj4gTm8gdW5kZXJzY29yZXMgaW4g
bm9kZSBuYW1lcy4NCg0KSSB3aWxsIGZpeCBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQo+IA0K
PiA+ICtjb21wYXRpYmxlID0gInNoYXJlZC1kbWEtcG9vbCI7DQo+ID4gK3JlZyA9IDwwIDB4NTAw
MDAwMDAgMCAweDI5MDAwMDA+Ow0KPiA+ICtuby1tYXA7DQo+ID4gK307DQo+ID4gK307DQo+IA0K
PiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0KVGhhbmtzLA0KSmFzb24NCj4gDQo=

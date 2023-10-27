Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54897D8CCD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 03:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345085AbjJ0BbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 21:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0BbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 21:31:11 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8C81B4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 18:31:04 -0700 (PDT)
X-UUID: 7b84432c746811eea33bb35ae8d461a2-20231027
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=p8LYwftMb8g+8sNFsmQ0p7+JIir8qsllun3tirNX28M=;
        b=fwBOPjUqRlAEdPl6AXbvujtbu4DJGHIhY0ZRGM9+tMEGotJonVaGFE8A9Z91k0/KcvJGZi6X9oKpW65RdRL8SdxceDkLd3EZK6dfv6crRr2vacpGFZmGJTiYZRDKRebegsg/dsEXgvKY6UM1Wwcsv3CuD98rnS2Llkk1E37T2TA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:e1f51565-82e8-4746-b7e6-ed0d04ac248a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:302cd3fb-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7b84432c746811eea33bb35ae8d461a2-20231027
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1300729872; Fri, 27 Oct 2023 09:30:59 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 27 Oct 2023 09:30:56 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 27 Oct 2023 09:30:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJo5Y3BOmxL7+ATuiBUxaGdMkNMV/rrzeVZohpEfb6ims1uAs0REbTyRZ0xf1+SZZ/gWKDcXY+C19q/QB0oeHSDMWtscF/76ZTkUYx8mxsIS2XNkAeVAyGoXUVmjs+D153HAnz7nJ96LB2uPyFm9gRPfREsfz+CJA//9Eily0tAWHhlclSLdUkK6sL66iBAXFisNV1Nzk+s1Baueh4+0PDV67hjRMAcaB15+Z9kqUHgW22mA6OKqH23kiY6KlZdDV9MPYw8WjEyZ889Y0gPbmHWvBjJTz6/VM5qddnL+pwuSyQMQd6MMt88bNu/fb/oRRHD/FjPRGA+S3++Wqzrrag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8LYwftMb8g+8sNFsmQ0p7+JIir8qsllun3tirNX28M=;
 b=NyH1wqA8hFZa8eXprwaXgqrdEiPosvtkhcqh6eyqfwAL3UTl4KIaVrSQGStB9L5nXkPZORES61MccBHmB3Rq18nTimZn+Xhvya6p/QusVDOVCjVpgo2LtqmT2VYLDzRl6JCbO8+kEvTXPLvSpKcMPvvVgK9fOodCVK3GofS8KHTj7GptB7YfQaoVQAW9Fc+xYd3b+DrxMWSl7bM3Bd4ABKpdaVVqjYlmFXjFSELCie///JifZTdr8g0nVc0JubQvNnMi1mjNs1wcJQvC2GQs/5/itsal0tNOlX/Ca7upD2It3wxb3NzunIQOtQugyOwFOKa+za+MVtbiXrMzTFlrhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8LYwftMb8g+8sNFsmQ0p7+JIir8qsllun3tirNX28M=;
 b=on4DRoTZkQHP2+OE8o/2SqoB6osKZGpexWxBY07sUTRMjKk0JUMgqrQeMy77hElXyQ6gDsYvOLI216P1VnQBXd4gNEaEMNkYOygK3iOeHTWMt/NmDDd6V/pnTadAklO68NIK2Dpk4sU37LjloR6K7wQN76xqNiTX91cyZwfnvuw=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by SEYPR03MB8006.apcprd03.prod.outlook.com (2603:1096:101:176::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Fri, 27 Oct
 2023 01:30:52 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::7a6f:69a8:742c:af8f]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::7a6f:69a8:742c:af8f%4]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 01:30:52 +0000
From:   =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH 1/1] drm/mediatek: Fix errors when reporting rotation
 capability
Thread-Topic: [PATCH 1/1] drm/mediatek: Fix errors when reporting rotation
 capability
Thread-Index: AQHZ6f8vrgZaHzRCV0+BVRY7kyABsLBbin6AgABuDoCAAACRgIABHVWA
Date:   Fri, 27 Oct 2023 01:30:52 +0000
Message-ID: <8eac70610516432007393b874e26a6fb31b31a37.camel@mediatek.com>
References: <20230918071011.18481-1-shawn.sung@mediatek.com>
         <20230918071011.18481-2-shawn.sung@mediatek.com>
         <10fda9ad9ffc4a16418ccd8b113f8cece461747d.camel@mediatek.com>
         <72db0a70e99374509140dada1363edb33b33b1e5.camel@mediatek.com>
         <7c3a6f368c963a53f52ecd9e549a39ec47ebd7df.camel@mediatek.com>
In-Reply-To: <7c3a6f368c963a53f52ecd9e549a39ec47ebd7df.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|SEYPR03MB8006:EE_
x-ms-office365-filtering-correlation-id: 7bd8463f-a7ae-4b29-2b1e-08dbd68c5b8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bMJdkvola2ktyN3clMRRm26OBNh5iohMYD2KwYKL7wI6kIS06rlAGLksgd3fOU6E8rya50ww14li8ih6cAl9e4G3CsBl3PE+v07q8XlaDzuNmDA4WWCJinU4S1Y0gXSioBp0EpfjHRT089GMznm56wb/5Gzjsc0pGh0SIRuKzpRmxJjfd89rUiWB0zeVr1j4hpRWi37e26sicgtpjdAsEZ0Ixx3iKhLo2yQAs3yLfUQguMYKDZJ/4ucZEdIRiwsTv7LEqLQjiLeSKsrj5ZOwMuH7Zuc9/72MG7CV45hKfG2WvLzFtN2JexpQewypOFcI4VSI+2p0d4CqMVfTW2Vn5sbm07MYMx9DThJ/b8D1Qq6iE2wFMjoKx//Gg8r698rMQvvc5mJnhmldcz2tXKk3Gn3q+BAcmu4qyMhV07wF8AEJOOmA1sTyNCnq3KSr/rxnlYJ8wQDIsN4+erMKYQO2owjbEPu+gCd/GJuatr72ikBwrK6vMR9bpE1zEBgRDWmwdBMLqbCXfhcbUxTSm9bKSE/PIc01fE+i6lklSz55Ds8GRTJKdGV95ZwQtjeDZaOAKs5hkyNt35UmeiBko1iRoNTEGm015ozlyHmxF4+sQSKyZxEPfXYRP/U+wDcmg/QKkM2jpsdmdrejClPJDYWr3WgKSk4nfIOB/5d2XSbWxNw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(4001150100001)(478600001)(83380400001)(71200400001)(86362001)(8936002)(8676002)(5660300002)(38100700002)(6512007)(7416002)(4326008)(2616005)(26005)(41300700001)(85182001)(36756003)(66476007)(6506007)(66446008)(316002)(122000001)(6486002)(2906002)(64756008)(110136005)(54906003)(66946007)(76116006)(66556008)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N29VMEw1dys3ZyszREF5L1BYWVdhOUhtRE5ZUlJGMEFva2YreGJqd0RxV2RI?=
 =?utf-8?B?VzQ1S0lYT1Y4NzJVbFpMNXdkc2dXczdNK2xCTXUwbE1ZUkNQWEo3R0dHd0Mx?=
 =?utf-8?B?UVY2Ynp6V1lCTEYyWTdzQW5uUGJwM1VaT0dLeGIwYWNCSExUTTFZbDJHdEd4?=
 =?utf-8?B?OWlSYTZDK3hCWjArM3RFaE9ENmpnYnBEM29yY2l4aE5xQ3BHcnFmRkNtZFdZ?=
 =?utf-8?B?ckUzVUVUZGQzZnF2T3VpQXlNS3ErdDE2d252WlFHd2E1engxM3FvbytBS08v?=
 =?utf-8?B?S2ZQeFBqQXBaNE5nVnJZSm04MWpLTTl0WGJBQzdDaE1reVh4OW5SZnNsQSs0?=
 =?utf-8?B?Sm82dWkybUg0aXRrUTVWdk1uUHNNcVg2YW13SVFySTN2OTBUZERzL21PbjFv?=
 =?utf-8?B?RFdWZUN6bHQ1WUVGV3ZuRk5pZlp5WTJIYjcwT21nWloyUi9pOTFIcXJaQnlG?=
 =?utf-8?B?ZkRMWktJUEkzaEcrYXEwYjFlRVlQcm0raGlEbzVTS0NEOVMwTVhWd0J5YVQ1?=
 =?utf-8?B?M0ZjKzVFS3hoS0l1cFM1N3pVcUVVT29NeXNvaUNFSjNiM0RkbVhHc0dUczRH?=
 =?utf-8?B?RURJZTgzWDczOTdiRnFpczVhOE9aalp0aHV6eWtDTXRPdEVsVkVUNTV3UlBr?=
 =?utf-8?B?Z09qL1NZelpWT2xiVXBTRGh2YmZOUndWV3VqWVo3NGhVZjgzUXFvNmJodEVC?=
 =?utf-8?B?R3lkRGxiR2lMK1p6RGtFRGlDSnBtNytPQkk1d0NxdFRIVkdmWFZpQkpoTU15?=
 =?utf-8?B?MGtpL1hGaTBXNXZrTlh5QzQ5bWZpT3AzaDVjOGpnVmM0MWRic05NMWMzYnNr?=
 =?utf-8?B?L3pTWFRzZU1objNKTTM4QUx4djVtbEhEeVJtT1ZGYzMvU1ozLys2cnI0YVZH?=
 =?utf-8?B?NVM3YzQ2aEZqYURnd3UxUWJkTlQ0NVYweDlEaC9RbEtNQ3NkMFhHRkFvNVg2?=
 =?utf-8?B?b29yZm5pcEUydklZSjNwcFBaMkxmMEk1VTZZQVBLSmp3ZDQ2aFpqdFp5MHZE?=
 =?utf-8?B?aWtsMk90MzJpa1RLK2VuSUpyQlZMTEtuRmlwMW9aYUd1Tm85ajZsWnFmaTI3?=
 =?utf-8?B?eUNkOER0c3I0ekNRTkVVT28xa25qN0JEUUVpZzBNRExYdUVxS3BDN1JvOURC?=
 =?utf-8?B?OVlOUElFakM1YmFpODN2cy9LT2Y5UXdpM0U4VGQxMytrNlFqQWppN3duOTdj?=
 =?utf-8?B?c2xDMzl6ellqdUtXcksxU1VhUmMxVGFqQW4zMDhpNFY1QnVqbDJjaVc2T1I0?=
 =?utf-8?B?NjNWN0prWTNqQmpvSlhhaHlrTDhHb1hvdjhVQjB0VmFibDlIS2hFMElIbEsx?=
 =?utf-8?B?THYwT3AvTVEyRHdaSWZtYXo0S3B1RDVQQ0dNbEhUc0JGTDhmZEwrVEE5RVVL?=
 =?utf-8?B?enBjZks5bmpVZThhN1BxakxzeWdTM2J4M1dST1V1YitTYXdid0tTNmdxTUda?=
 =?utf-8?B?a2htNTJKT0UwNFVIWVV6ZGZvaWRiUjBpRUl3Vi9DSSs2M3UrK1RJYnpVQWtv?=
 =?utf-8?B?b2R0S0dKZVZ6ZzgxY1UwcWZGN3V0dWF2U284SFlWSEExWThqWVJyUG9pZ1ZL?=
 =?utf-8?B?RmhqVk93SEllY2RSVDJRK1ovY0RDQzR6TDBlRGJNVW80MGdTYzQrQkFDOVVi?=
 =?utf-8?B?RUhkNmJ3UmttMU1BdVNQUXJZY2dRNi9CTHJTVENDd1c0elFVYkpOMVBpZjJl?=
 =?utf-8?B?alRXTzR4UmI1NmhFVE5KeFk1RXRWSXBXTy90OFNQYkdyWVhla2hyMmJsejRG?=
 =?utf-8?B?NS9Id2tpTnM0ODE0SUJoQ0QwZzNXdDM0b2tLeWFydnNmSitwTTFYUDJCV2RY?=
 =?utf-8?B?eUdrdXlpSTNZRWp0OSsxQTJENVZ5ODNQcjNPWVZSWGdpSUZCSnVMenBDWUow?=
 =?utf-8?B?TjF0czY4TERDQm1RdjJESkVqTXdvK1V5cHBWbkQ5NTJzNlVUZlBpTmNrZnpL?=
 =?utf-8?B?akYzbFBnanJ0SHBsQUpPQzJjMTc5elVqbHdHN25iUU9ORFpqNGJVSnc1MERm?=
 =?utf-8?B?dHhjbjl3QUQvMUlLSUtjcHBJdXV4YUg1YVYwbmY1eWtINko1cWpzYS90dVRu?=
 =?utf-8?B?QXhvL3UyVUxQUWJyY2ltVmVqWjRkY0liaEdqYjJGS3dFTkM3Y1RlQ3Y5WXN5?=
 =?utf-8?B?UUNOaTIzZUtLNXhwNmIwa2lzUmdQWTlydUl4OTU4THBwVlhWVlo0dEZwYWIz?=
 =?utf-8?B?TlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69EBBBD4FFF3DC4EB220AAF3504B8F12@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd8463f-a7ae-4b29-2b1e-08dbd68c5b8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 01:30:52.2169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GY88FO2Hwk5BmW4I2oWx8R+O8W65HFZRfDf36JfZFCew1RJSKsPehosn5pedHAUCAE1OK/YetBkkYLmuNL4nng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8006
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--18.640100-8.000000
X-TMASE-MatchedRID: Y6GLOewO+JjUL3YCMmnG4ia1MaKuob8PofZV/2Xa0cK8k69NWNRZfLmn
        rGB/kwGMPLa1JP0J/BmxK9ETst1t5M9tfSEZlKTRh3ZN+5lFR7eeEP0DdJruliz+5QCTrE/saUX
        s6FguVy13IL9RTZjcZXTv9Bst6w/PD7+f/jfUYxIc9jA4mLo8uWLu7N0EkjfkVI7KaIl9NhdBss
        gga2T01iZY51YhxDVtnbIwBXJYItgEvj9ETcXfB1WeeIqHthMLfS0Ip2eEHnylPA9G9KhcvZkw8
        KdMzN86KrauXd3MZDUD/dHyT/Xh7Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.640100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: CA07092BBB810A03A0BA250E30939D82C052C8AD86D408B9FFB541612637D6CD2000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNCk9uIFRodSwgMjAyMy0xMC0yNiBhdCAwODoyOSArMDAwMCwgQ0sgSHUgKOiDoeS/
iuWFiSkgd3JvdGU6DQo+IEhpLCBIc2lhby1jaGllbjoNCj4gDQo+IE9uIFRodSwgMjAyMy0xMC0y
NiBhdCAwODoyNyArMDAwMCwgU2hhd24gU3VuZyAo5a6L5a2d6KyZKSB3cm90ZToNCj4gPiBIaSBD
SywNCj4gPiANCj4gPiBPbiBUaHUsIDIwMjMtMTAtMjYgYXQgMDE6NTMgKzAwMDAsIENLIEh1ICjo
g6Hkv4rlhYkpIHdyb3RlOg0KPiA+ID4gSGksIEhzaWFvLWNoaWVuOg0KPiA+ID4gDQo+ID4gPiBP
biBNb24sIDIwMjMtMDktMTggYXQgMTU6MTAgKzA4MDAsIEhzaWFvIENoaWVuIFN1bmcgd3JvdGU6
DQo+ID4gPiA+IEZvciBDUlRDcyB0aGF0IGRvZXNuJ3Qgc3VwcG9ydCByb3RhdGlvbiBzaG91bGQg
c3RpbGwgcmV0dXJuDQo+ID4gPiA+IERSTV9NT0RFX1JPVEFURV8wLiBTaW5jZSBib3RoIE9WTCBh
bmQgT1ZMIGFkYXB0b3Igb24gTVRLIGNoaXANCj4gPiA+ID4gZG9lc24ndCBzdXBwb3J0IHJvdGF0
aW9uLCByZXR1cm4gdGhlIGNhcGFiaWxpdHkgb2YgdGhlDQo+ID4gPiA+IGhhcmR3YXJlIGFjY29y
ZGluZ2x5Lg0KPiA+ID4gPiANCj4gPiA+ID4gRml4ZXM6IGRmNDQ0NDU3NzExOCAoImRybS9tZWRp
YXRlazogU3VwcG9ydCAxODAgZGVncmVlDQo+ID4gPiA+IHJvdGF0aW9uIikNCj4gPiA+ID4gRml4
ZXM6IDg0ZDgwNTc1Mzk4MyAoImRybS9tZWRpYXRlazogU3VwcG9ydCByZWZsZWN0LXkgcGxhbmUN
Cj4gPiA+ID4gcm90YXRpb24iKQ0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSHNp
YW8gQ2hpZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRlay5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+
ID4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oICAgICAgICAgfCAx
ICsNCj4gPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYyAgICAg
ICAgIHwgOCArLS0tLS0tLQ0KPiA+ID4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
aXNwX292bF9hZGFwdG9yLmMgfCA1ICsrKysrDQo+ID4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jICAgICB8IDEgKw0KPiA+ID4gPiAgZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYyAgICAgICAgfCAyICstDQo+ID4gPiA+ICA1IGZp
bGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gPiA+ID4gDQo+
ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2
LmgNCj4gPiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4g
PiA+ID4gaW5kZXggMjI1NDAzODUxOWUxLi5mNGM3ZGJhOGY3M2QgMTAwNjQ0DQo+ID4gPiA+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiA+ID4gPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gPiA+ID4gQEAgLTEy
MCw2ICsxMjAsNyBAQCB2b2lkDQo+ID4gPiA+IG10a19vdmxfYWRhcHRvcl9yZWdpc3Rlcl92Ymxh
bmtfY2Ioc3RydWN0DQo+ID4gPiA+IGRldmljZSAqZGV2LCB2b2lkICgqdmJsYW5rX2NiKSh2bw0K
PiA+ID4gPiAgdm9pZCBtdGtfb3ZsX2FkYXB0b3JfdW5yZWdpc3Rlcl92YmxhbmtfY2Ioc3RydWN0
IGRldmljZSAqZGV2KTsNCj4gPiA+ID4gIHZvaWQgbXRrX292bF9hZGFwdG9yX2VuYWJsZV92Ymxh
bmsoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gPiA+ID4gIHZvaWQgbXRrX292bF9hZGFwdG9yX2Rp
c2FibGVfdmJsYW5rKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ID4gPiA+ICt1bnNpZ25lZCBpbnQg
bXRrX292bF9hZGFwdG9yX3N1cHBvcnRlZF9yb3RhdGlvbnMoc3RydWN0IGRldmljZQ0KPiA+ID4g
PiAqZGV2KTsNCj4gPiA+ID4gIHZvaWQgbXRrX292bF9hZGFwdG9yX3N0YXJ0KHN0cnVjdCBkZXZp
Y2UgKmRldik7DQo+ID4gPiA+ICB2b2lkIG10a19vdmxfYWRhcHRvcl9zdG9wKHN0cnVjdCBkZXZp
Y2UgKmRldik7DQo+ID4gPiA+ICB1bnNpZ25lZCBpbnQgbXRrX292bF9hZGFwdG9yX2xheWVyX25y
KHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gPiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gPiA+ID4gaW5kZXggMmJmZmU0MjQ1NDY2Li41ZmQxZjZh
ZTQxZjMgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZGlzcF9vdmwuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rp
c3Bfb3ZsLmMNCj4gPiA+ID4gQEAgLTI4OCw4ICsyODgsNyBAQCB1bnNpZ25lZCBpbnQgbXRrX292
bF9sYXllcl9ucihzdHJ1Y3QgZGV2aWNlDQo+ID4gPiA+ICpkZXYpDQo+ID4gPiA+IA0KPiA+ID4g
PiAgdW5zaWduZWQgaW50IG10a19vdmxfc3VwcG9ydGVkX3JvdGF0aW9ucyhzdHJ1Y3QgZGV2aWNl
ICpkZXYpDQo+ID4gPiA+ICB7DQo+ID4gPiA+IC0JcmV0dXJuIERSTV9NT0RFX1JPVEFURV8wIHwg
RFJNX01PREVfUk9UQVRFXzE4MCB8DQo+ID4gPiA+IC0JICAgICAgIERSTV9NT0RFX1JFRkxFQ1Rf
WCB8IERSTV9NT0RFX1JFRkxFQ1RfWTsNCj4gPiA+ID4gKwlyZXR1cm4gRFJNX01PREVfUk9UQVRF
XzAgfCBEUk1fTU9ERV9SRUZMRUNUX1ggfA0KPiA+ID4gPiBEUk1fTU9ERV9SRUZMRUNUX1k7DQo+
ID4gPiANCj4gPiA+IElmIG92bCBlbmFibGUgcmVmbGVjdF94IGFuZCByZWZsZWN0X3kgYXQgdGhl
IHNhbWUgdGltZSwgaXQgaXMNCj4gPiA+IHJvdGF0ZQ0KPiA+ID4gMTgwLCByaWdodD8NCj4gPiA+
IA0KPiA+ID4gUmVnYXJkcywNCj4gPiA+IENLDQo+ID4gDQo+ID4gWWVzLCBpZiB0aGUgdXNlciBk
byBzdWNoIGFuIG9wZXJhdGlvbiwgdGhlIHJlc3VsdCBpcyBlcXVhbCB0byAxODANCj4gPiBkZWdy
ZWVzIHJvdGF0aW9uLg0KPiANCj4gU28gb3ZsIHN1cHBvcnQgcm90YXRlIDE4MCwgd2h5IGRvIHlv
dSByZW1vdmUgdGhpcyBjYXBhYmlsaXR5Pw0KPiANCg0KVGhhbmsgeW91IGZvciBjaGVja2luZy4N
CldpbGwgcnVuIElHVCB0ZXN0IHRvIHZlcmlmeSBhZ2Fpbi4NCg0KQmVzdCwNClNoYXduDQoNCg0K
DQo=

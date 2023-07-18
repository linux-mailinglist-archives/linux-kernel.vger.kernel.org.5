Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABA6758149
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbjGRPtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjGRPs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:48:58 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107909E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:48:56 -0700 (PDT)
X-UUID: 97cd90c2258211eeb20a276fd37b9834-20230718
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=7WWTeXDOzx7T5ePFqqdnYp/PhLyg3q8oa0QqTqcTYis=;
        b=kvtju1UjmiR3EaxGkbyB+WB8Yv24CQOP1wOvfinxzBjJ5P35A7rEe9CoNytXwnw2XbRnTqPX5mLEH+6DO4YUtvS/0HH2MUVqQIAvKrAcgo3f/Cy1OMXTK3UsRGjNAj1WdSHsjOQmljSxfZHO/fxU7ow7Bx7q8paM6ToMGkuZWik=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:dc3e6379-4958-4dcc-909e-9a72dc523f2c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.28,REQID:dc3e6379-4958-4dcc-909e-9a72dc523f2c,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:176cd25,CLOUDID:f018bddc-dc79-4898-9235-1134b97257a8,B
        ulkID:230718234852WKCJ0JI0,BulkQuantity:0,Recheck:0,SF:28|17|19|48|38|29|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,C
        OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM
X-UUID: 97cd90c2258211eeb20a276fd37b9834-20230718
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 539574939; Tue, 18 Jul 2023 23:48:51 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 18 Jul 2023 23:48:50 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 18 Jul 2023 23:48:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Of9lcmAjEbH6OD96vmPZUCx++fsgFNIAfvrGcYNxq/b/U8UnrdVwxjRCIYPuPHyI1XemcbNJ9xqU9bd38FZDe7Q96LII8br2UA1IxKtZUvNXmZ9z774s1b3j55Ltl3F8rFmDefVeQtohdYzu5G9T61AJIRQb4+9Vn+5M0xzXAi8tzNvXkIo4WxSoJsl8xNVZbplFy6Gv0mgAL3DIdCwSNhdh5pM/qdl4h1gZ0X0sbL5fKKOxyM+hDrRRVWTXvw6Q44MMkQsugknvM3WDKsD96OytjWCYJR2ppY4TnjXX1jC7JbqeMYyaU4Kar9BBIwqVnmc9lPZpNrHyjepl9SxEvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WWTeXDOzx7T5ePFqqdnYp/PhLyg3q8oa0QqTqcTYis=;
 b=PP/wHJiDeAfz9H4xCv3FQL9VU6S1SjDQJcymDODb1wrtVdxWcNBZ3sOC1wKsa/keqmwpGIKdKM2LO7en4A+bRBOvdXd3ZV0mOmaSxYG6zRsyHLWtyNE+qiJ7vabMXGmaOowtJs4nMNjt77GLAh1UbgtM5cAU+QkypxnDXzHi4gJ4I2XiK2gAiokq8GtrpmGB8Hhn0mOq3WLu2huUf/Iipgv7oPbtjuxQf9ZZbsIjgPsDHvY0BweC38sDgbb7Is9nF2Zl7iyfoCAALrYF2HGMJivSMAEWuzw5gdZzxv8bkLbv1o0ZUh7BRmiI7kJrdEIcbZf+WMF3rE0y1SbhlG6xlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WWTeXDOzx7T5ePFqqdnYp/PhLyg3q8oa0QqTqcTYis=;
 b=C0BZ9RfdXsJslZKJ0dN3nJMYPykUzqWiq/s8FThoJYdRL5ta2s6qQHSJIR9C4y13B13V05ouPm3JOTiv5mVpWxH9qQ46Gsyo1+2Kqn4OoDvfnCo/4I1jHhhhIwkj0FdX9QGV+Wt6Xt4GeVzTJx2boti9g8tUi4RvKDnsqUtORDY=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYSPR03MB7883.apcprd03.prod.outlook.com (2603:1096:400:480::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 15:48:47 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::92f1:9485:1aa9:af0f]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::92f1:9485:1aa9:af0f%5]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 15:48:47 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 2/2] drm/mediatek: Fix iommu fault during crtc enabling
Thread-Topic: [PATCH v3 2/2] drm/mediatek: Fix iommu fault during crtc
 enabling
Thread-Index: AQHZsxGYm13+FK938kCE0SepgE5u3K+42reAgAbd0QA=
Date:   Tue, 18 Jul 2023 15:48:47 +0000
Message-ID: <7adca80c59d5c3cb8d97c24995f824cd7bf5fea2.camel@mediatek.com>
References: <20230710093253.32224-1-jason-jh.lin@mediatek.com>
         <20230710093253.32224-3-jason-jh.lin@mediatek.com>
         <9ba9347d4e5e05299fef80707bd1b3c5db61d657.camel@mediatek.com>
In-Reply-To: <9ba9347d4e5e05299fef80707bd1b3c5db61d657.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYSPR03MB7883:EE_
x-ms-office365-filtering-correlation-id: 4cda473b-4679-4f20-1e08-08db87a67962
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8PDuFuCEfBlh0lNOBnx+OlI3K3IweYxDG81FJFI73bL2zF9d3pmkiXptXoGe8Ay5SeZIfa1Bgz6B1Lz51zYkZu12fgrqOOnqgH6CPf/iaILooX4Ua8FeRlPegJjIyJ4wGZZuAyr+m27vxOyqUkxnp4yIUeeLYy4ItI22zqt8INyPP0cEy5a+1edI2VQdYE6B6F6hM1DLtO0DeMtr0POsBbIFbhcBUHNODZLGpOuYRe7xQuGNqbJIMk1WCkQB83lJsQglt7EOXbdw002dDiSu4G011MZSxtGRpr99rJ3yEpZxzkZybsuG8NI0vswBOtRqF+d/w25huRSJRRw0oqdeBa0G7x7EOFXeIp0pk6JRyLUsEnnIfLXizRAsCmGGZB7nLYNZoYRGGUdNTEwVlnSF7t0LvnYBZUd6gm4H1IXbbF8GEkHPQh6PSPBvnlmE4ubc4QMJ4ZkVCcCF+R/PdLfUkdlTlkxSCUXZj0XvdMNDIYTZt+Zgrq+7PdJWXURsd01QVUpyBA+Txg3mSNWlAEkkbxA0GJ7KpLDldKxLDzGxGSfgE6Us2Rw+061UukAZfle6ic7nHi9lAtreICcvQQegTNVrS+5xQ9vmbzkPBlYmqCPDYm0fnJPr2CzXCG7Rj6hBd0wIOQIyp4UtQ3qSwOO6TkYmJuf/47O5Bw2hmtDRkGc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199021)(316002)(41300700001)(83380400001)(186003)(6512007)(2616005)(6506007)(26005)(6486002)(478600001)(54906003)(110136005)(122000001)(71200400001)(4326008)(76116006)(66476007)(66946007)(66446008)(91956017)(64756008)(66556008)(38100700002)(86362001)(38070700005)(8676002)(8936002)(5660300002)(2906002)(36756003)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGlIRFdkN0RYcmhUMEVxcjNWK0lCdXZBS2FObFZRclVacHhvcllmdDcwekdY?=
 =?utf-8?B?R0NiM054WXlaUm95bTQ3dzRrZ0dDY2VYaG82OERxOW1pMkYwVlJLRjZxemNU?=
 =?utf-8?B?TUlORUJtZmc3UkJscGdoc3g1bWFLYnM4cUtOWm8zQWp4UnQ0Z2dYMGpEYXlP?=
 =?utf-8?B?M21WMGMyenhZa0VtMEVXTWtaNWZ2WXZpQWxJbGtxWCtrNExaRlQwbjBhVHN2?=
 =?utf-8?B?Q0hJNXljamNmTXFma3ZianY1MVFETXVlV1pyZ01lWEovUElXNytjY2JCTDAw?=
 =?utf-8?B?VllVclZ4Z3loa284L1QzOXBqVDRaOGZWN28zZXVlMnlCdmF6VFRMOFlLUjBs?=
 =?utf-8?B?OWZwTUJlTjdsdW1JQU42dVk2ZGs3OVJnMVJIS0lBcUttODF4dnhKd0lEZ2lv?=
 =?utf-8?B?L1B0R3BTcWx0QU1ZcmpTVURrME9nL3h3aHF6MDVkN1F2Zk0yNHl5S3FJYjFD?=
 =?utf-8?B?RlQxQVd5bDV6d0ovc1h4d0wxSTdMMVpWN1VvN25MZFNPUWJ3TGZZbHd4OHoz?=
 =?utf-8?B?cHBGeFljcXVuaWM3UEdqcTFXekdUZnJvNDJlVVJWTVYyR3RKNnBiSlJYVXFh?=
 =?utf-8?B?Z2ljRnJjcm1oUVV0NWYyS1Blb1M0a1N4UFpEVXJoZnRzQmw0RzBzMjkwa0do?=
 =?utf-8?B?bWFoUXgvUVVRZWM5eGdvcDRrWjRpdjltTVpIVGEvSDJNSE9oem5vcmJnY08r?=
 =?utf-8?B?U29sTWZrZXplNWNBWDhaaWFVRlV1T1RnMGJkWitJeWYzZmhzV1dvTm9qdWFR?=
 =?utf-8?B?SUFuOTRUcU1ndlVVWlBMcXVmR3ZHL284WWw4RGN6TGlNN2YzOVhQakc4MDAw?=
 =?utf-8?B?VDhqeWJGcUNIWXdXY25hVlowbjhLUUgreDZMWHl1OEZCQkVlcFAwRXo0cnli?=
 =?utf-8?B?SnJtQXhkMWNGRUJocExzS0FuUEZnN1JuWVV0VGIwZkcvSXl5azNwM1RtRjVn?=
 =?utf-8?B?TXhtcUVJeXpqd2VtNzBWWm9USk9jTlJKSldINi94UnZrWEo5eDJ2RXRqdk5V?=
 =?utf-8?B?RnVwZ2cxRlprVVZoUDFzTStIbkRzY0MzRFNqTXBWaitiOXQ1bnJ1K204MGF0?=
 =?utf-8?B?RzdOR2RuUWxuVis2bTV6K25IcTMwR1RwaEhMU2xNZzBLbnRYajJpZkJCazM3?=
 =?utf-8?B?S0hhcCsvUTdKcjBwcXFMM0g3TVQzV1FtNzgyNTNwa0NZZVZXWVI4dVBrMFhk?=
 =?utf-8?B?SFkzeHZRQnVCSFArd2pPb1hGNFgyYnE1R2pwS09JalJqNmU3NkF2UThLZk54?=
 =?utf-8?B?UWlrME1zbmdxaGFVWjgvZ2RSQlRyL1JuOTcxNHIxNElickh1emNVY1psOEJJ?=
 =?utf-8?B?cmEzeFFsTWV2KzFtSEdReXJoSXFqQXBvSkFrRm1xc2M3MTZaMFY3U3BQWVVr?=
 =?utf-8?B?VGI3OVJhK004OExFcjBTVm9BVkI2WTM3RlA0WkRDUlZxYlNhWjA0U2NuVGdX?=
 =?utf-8?B?UENJQU5oU0d5Nkl0bkQ1MXBQYXBvYTVmNmF4UUpqaHcrZXpXcjFtUGpXMnhl?=
 =?utf-8?B?MmRqUkIrVEJuYmtpbStmN1dCczlpU2dBdlVmQjZWZ1J6cXR0di9QenBiNFFI?=
 =?utf-8?B?S1lXNm1HMGFXQXp1WFNONWdydWNMN1JGU0ZHUzVPQVpqaW9ydGp3S1kyWUhB?=
 =?utf-8?B?YjlLWFBIUFN0cGx4aEIzV21COTVEZ0RDUVZOOUk4SEl3ZytzTitBME5kWllG?=
 =?utf-8?B?VjR1bW9FZXE2NmVXSnNmN3paL01DQU9OZUJraTZiTFNEakZrOEdqeFhZeGUy?=
 =?utf-8?B?YXpLb1k0dU9pOWpZcEdUUTFFWnVURURqOXE1c0tuUzZWOWs0WWFNU05ucWsz?=
 =?utf-8?B?WlBoTlptNm5CeE13YXJ6ZjBoQk43TXR2WXlvazFEeCtzR0YwS1ZvQnByeUVa?=
 =?utf-8?B?RGZLNzZ4cDloSmlLZ3Z6Slc4V3BNNlRKRDNJTWJaOWRIU054T1VyRnJ4NGEw?=
 =?utf-8?B?cktHSlk2MERtWWkvWnNZWTU1WmZVK0VlV1QyL21VMEZkVFZkZ3RmOURXTWpk?=
 =?utf-8?B?UkJOVjBVcmZmdGs0RmtscnYxMlZiaDJUT2ZjSit2M1EwN1NTa0NWQURsN3Bx?=
 =?utf-8?B?ajVlSlVLMHluald1dDRRYmp2aTBJTDJEMVlDN2tPZXA3emxOL2s2M29KZGg0?=
 =?utf-8?B?ZXl1dmV3Y2daRzVsUGZmRTA5KzRQMDBINlBBSzhRRzJIYUh4RnA3SThDTUZz?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53EFD6E7210E6E4D806254FDF990728D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cda473b-4679-4f20-1e08-08db87a67962
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 15:48:47.3648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s3Y1MKW5NGrVMBha3K8/ZpvT2jI9+HjZw3CQAQD0VPD1pAh03jvKhSUE/YI4ewgHSJNQP/byhxrSxYveZi/snVysyU0fjVBqlz9S4jNgMHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7883
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

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIEZyaSwgMjAyMy0wNy0xNCBh
dCAwNjo1NyArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4g
DQo+IE9uIE1vbiwgMjAyMy0wNy0xMCBhdCAxNzozMiArMDgwMCwgSmFzb24tSkguTGluIHdyb3Rl
Og0KPiA+IE9WTCBsYXllciBzaG91bGQgbm90IGJlIGVuYWJsZWQgYmVmb3JlIGNydGMgaXMgZW5h
YmxlZC4NCj4gPiBUaGUgcGxhbmVfc3RhdGUgb2YgZHJtX2F0b21pY19zdGF0ZSBpcyBub3Qgc3lu
YyB0bw0KPiA+IHRoZSBwbGFuZV9zdGF0ZSBzdG9yZWQgaW4gbXRrX2NydGMgZHVyaW5nIGNydGMg
ZW5hYmxpbmcsDQo+ID4gc28ganVzdCBzZXQgYWxsIHBsYW5lcyB0byBkaXNhYmxlZC4NCj4gPiAN
Cj4gPiBGaXhlczogMTE5ZjUxNzM2MjhhICgiZHJtL21lZGlhdGVrOiBBZGQgRFJNIERyaXZlciBm
b3IgTWVkaWF0ZWsgU29DDQo+ID4gTVQ4MTczLiIpDQo+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24t
SkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgfCAzICsrKw0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fY3J0Yy5jDQo+ID4gaW5kZXggZDQwMTQyODQyZjg1Li41MWQxMGU2NTAwNGUg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5j
DQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4g
QEAgLTQxMCw2ICs0MTAsOSBAQCBzdGF0aWMgaW50IG10a19jcnRjX2RkcF9od19pbml0KHN0cnVj
dA0KPiA+IG10a19kcm1fY3J0YyAqbXRrX2NydGMpDQo+ID4gIAkJdW5zaWduZWQgaW50IGxvY2Fs
X2xheWVyOw0KPiA+ICANCj4gPiAgCQlwbGFuZV9zdGF0ZSA9IHRvX210a19wbGFuZV9zdGF0ZShw
bGFuZS0+c3RhdGUpOw0KPiA+ICsNCj4gPiArCQkvKiBzaG91bGQgbm90IGVuYWJsZSBsYXllciBi
ZWZvcmUgY3J0YyBlbmFibGVkICovDQo+ID4gKwkJcGxhbmVfc3RhdGUtPnBlbmRpbmcuZW5hYmxl
ID0gZmFsc2U7DQo+IA0KPiBBbGwgcGxhbmUgaGFzIGJlZW4gZGlzYWJsZSBpbiBtdGtfZHJtX2Ny
dGNfYXRvbWljX2Rpc2FibGUoKSwgZG9lc24ndA0KPiBpdD8NCj4gDQpZZXMsIGl0IGRvZXMuDQoN
CkJ1dCBzb21laG93IHRoZSBwbGFuZV9zdGF0ZSBnZXQgZnJvbSB0b19tdGtfcGxhbmVfc3RhdGUo
bXRrX2NydGMtDQo+cGxhbmVzW2ldKSBpcyBub3Qgc3luY2VkIHRvIHRoZSBwbGFuZV9zdGF0ZSBp
biBhdG9taWNfc3RhdGUuDQoNClNvIEkgdGhpbmsgd2Ugc2hvdWxkIGRpc2FibGUgb3ZsIGxheWVy
IHRvIGF2b2lkIGluY29ycmVjdCBwbGFuZV9zdGF0ZQ0KYXBwbHlpbmcgdG8gT1ZMIEhXIGF0IHRo
ZSBIVyBpbml0IHN0YWdlLg0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCg0KPiBSZWdhcmRz
LA0KPiBDSw0KPiANCj4gPiAgCQljb21wID0gbXRrX2RybV9kZHBfY29tcF9mb3JfcGxhbmUoY3J0
YywgcGxhbmUsDQo+ID4gJmxvY2FsX2xheWVyKTsNCj4gPiAgCQlpZiAoY29tcCkNCj4gPiAgCQkJ
bXRrX2RkcF9jb21wX2xheWVyX2NvbmZpZyhjb21wLCBsb2NhbF9sYXllciwNCg==

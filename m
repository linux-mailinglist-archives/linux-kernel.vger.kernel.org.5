Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB14A7D5F4C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 02:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjJYA6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 20:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjJYA62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 20:58:28 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8D0128
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 17:58:26 -0700 (PDT)
X-UUID: 979cae9872d111eea33bb35ae8d461a2-20231025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=yykRrEAoefTNB+d9jokuqfIl1B3zR4O5kRUYlWA1o08=;
        b=feIgjLohE7NELGr6CbFrHSA99W4NeeybjQMgrB6LZXvnaHiS9jUTBPiUCZGah6CTXgLsSBg6tT2kwpR/ilv/ZqwfnIaWrXQxQ94l+sFOnTjG5NpZrkG4Hzwg2IgdwFN91/Jz3E+Rw1g7wgSQzW2YTwXr812zH2urwNHLsKwe6OQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:09fa16c5-72a2-475f-ba54-76ebf6ac289c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:100847d7-04a0-4e50-8742-3543eab8cb8e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 979cae9872d111eea33bb35ae8d461a2-20231025
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2097042179; Wed, 25 Oct 2023 08:58:21 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Oct 2023 08:58:20 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 25 Oct 2023 08:58:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFxDawxAWJiGbxApK1nrVCTbP5fzUZT5GZsPQ2ILVDUhCMvViLSmXM43YmNoiJuA9CXtDyD8D1d0/gKOI/EAjNAP4QyK5EzBwRdtOuGx3QsLKgPjzJpzxxgRY2FKxP3QAcLSRxs+7G4BvYrVMvZ/xj63pZl6Y3g59X/s3N/jwS543K5merM+iyhp6Nj5pHZHTD7Kdp7nRzHnYa6DogxsdRgQ9nK9O0BGF986ZCTaOPa+Ku/EgfGDoXkcaiyVqw45fSxF4Q0FsOq/4KrYc/qj7jTu0Msm8+ly3dxmwt0PVoAM2OmxR71jlz7sSBvwO3h+uWUJTWYsv47kJFy2HlA3hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yykRrEAoefTNB+d9jokuqfIl1B3zR4O5kRUYlWA1o08=;
 b=TGtsOqKsUa3bX7YhBs+Mu0o+bHY4uyC5knnyGdF0NpUwSKVS83xcHAFLRKaleKppgdWYJf9zK+KoYdHkz376M+eOopZCjB3CddXNLLLXl3KIgA6is40AX3nMB08+1VNdvyi1iI0k0oYdOYPr6Wznn3x3wrj9vKrNphgo+IzWm1ShRZqXtdAYLoCkE9a+J3E0uMNKADI1wwtSNwvo8IzavN90IJiTOkL0vT51SGiMuQJNj8OqbJtLG+AxBkeeIttKjJVlHftgyp1SD/aNZXXXdcDKgxMqtVBSpJoHQrnlV85i0wt3weXTLI5D9LhMf9gTmWF43+dd8Jn96lqgoKgawQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yykRrEAoefTNB+d9jokuqfIl1B3zR4O5kRUYlWA1o08=;
 b=cfJqWMQCKLVPyBmKb5n847MmXDZMx+ULEfXnFi7QaGNLHn3jdHN3Cyf5/R/wSWG0iwipxWIiz8QwlMsxwFWBQpdP3OaBQSxDiuN2fKyx7L9tnjqDDrddxG0c+ZVUUngAYE/k+TxiHTE59WupdCv5zcP/CkyX49hlgXlCh9QKOuw=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEYPR03MB6724.apcprd03.prod.outlook.com (2603:1096:101:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 00:58:15 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d%7]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 00:58:15 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
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
Subject: Re: [PATCH v2 6/9] mailbox: mediatek: Add CMDQ driver support for
 mt8188
Thread-Topic: [PATCH v2 6/9] mailbox: mediatek: Add CMDQ driver support for
 mt8188
Thread-Index: AQHaBWq/XPFSvwiV4EiHOg1D0weMn7BXIdUAgAAGygCAAok1AA==
Date:   Wed, 25 Oct 2023 00:58:14 +0000
Message-ID: <dad1be3765fe36dbd6019f0f0f51e2af2f25b654.camel@mediatek.com>
References: <20231023043751.17114-1-jason-jh.lin@mediatek.com>
         <20231023043751.17114-7-jason-jh.lin@mediatek.com>
         <72277a7e-83a6-4947-8f2a-4881aa8ac766@collabora.com>
         <64a04871-7671-40c8-9b70-f2d9c7d5be32@collabora.com>
In-Reply-To: <64a04871-7671-40c8-9b70-f2d9c7d5be32@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEYPR03MB6724:EE_
x-ms-office365-filtering-correlation-id: 31f8119a-540f-43c5-69f6-08dbd4f5781d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +DYO/pjPgDPh4Cq+M7bBHBewncQRK812bI9fAdKCA8ARpqOJ2/hA/MyZ9BlT/IvtkztLbzFGvX5R8dJQvQc0G1oOHCTba41A/i+l8vxvaytDwdy1AKkqfrtpSnc9IMS3cj0BNLQqLigpOQ+W9ANmR/exrGJFmwHjVlyWsR85+sUpgWYb0PD0dFh2/WQZ/mJtAFNHNdCHGvIxpFCdtYhqoJvB1Gpc8a+dNLbbXwwdJqQoaRUOlIsnazrKq0kc1tIxvTmCXOk7edbXB3n51z1OgjKIiHDSuQfI4jIuUAbyz/popuUnL26Dkd3iN/2cA+oXUP6DhtWdddbar8eIFdsGOfwalFXomVCUdS+qgVRHoNw+MS5jKQGBmEzRnt6dEfTN5ZQweYVw6Cdvk8tzt5xwbgoMJse0w/Oq8rjGTaPpkim29YLUknnBHqh+/M6Zt/pQtSTWybI6cZzaVKb4qmPGadWJl3t3wxs3mVtPwlCXMaYsDiRR73owMU93oeNUpc+BIxvB0dFKHtUaorkHBxpMdbwIqjZCTdml6n6OZDUpeKwk7ECBLq+RvccDmOp1KUQltFC8ubUvePWOpxOmNZyPOEHqpTA6cCLMrY0yy1IpP5WHQ6oJKVFqXPJmQsYz/rhiVi8AMEcv6iL7RtmRBYZji5zSqTBNxKB0XEtCAivMJZg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6506007)(71200400001)(5660300002)(41300700001)(2906002)(26005)(4001150100001)(83380400001)(85182001)(4744005)(7416002)(36756003)(2616005)(15650500001)(122000001)(38100700002)(6512007)(86362001)(6486002)(66946007)(91956017)(478600001)(76116006)(66556008)(64756008)(54906003)(66446008)(110136005)(66476007)(316002)(8936002)(38070700009)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVhFbUFoWGlHZ0lDZVRVam9mVzVCak8wcEZKdjRXUW1nNkVUSm1qUTRRZjI1?=
 =?utf-8?B?RGdEQlQwK0FiVHM5bzZ2WDdOZ09VdHBMdVk1VWdoK2tXa1BMQ0Fmb3hXakk3?=
 =?utf-8?B?WVJLOURDR2tOWmgxQzYrckN2cW1tQi9JN05keVd3bFV5Tm5FdG13cXVOakFF?=
 =?utf-8?B?cDgxd3VlL3FZYmFXYXEzU1ZIZzI0d043aXc4blpzZFVmT2E0d2ZBNE9kNmJ0?=
 =?utf-8?B?RDV3dU0xNkVxdXpvNmNueVB4VXhhVzBUUC9MSkxHMjB2YTNtZFhOTk1NbEwr?=
 =?utf-8?B?MXlQV01PeThmRHpURnZyU05paFBwSzAvWFVHdlJXaFVaK1Nxa1NyT1FyLzdV?=
 =?utf-8?B?V04vNER5dzdBY1JDY0xIa0tZdy9vcnNHdjFRSUFmOGdYcmZsVnZIazBLU2dv?=
 =?utf-8?B?ZFBkSzFvNkplcitGYkw3bzBxSmhPYXhDNUJYNFNrQXJYZXNhTngySE1kKzJR?=
 =?utf-8?B?UElXUkovN3BlZ21hOU90QnVqYldTeXVXYmxvZDMvRWxmeVhzZ2RlRXhyUTRZ?=
 =?utf-8?B?WDJLUnUxU1RRaEZkR2haV2p2a2NReHkyTlVhS2M2VlNPK1hWdHlBb0lEMHY3?=
 =?utf-8?B?dXNhd2o0ckQyTWcwa2ZDSWx3N0U5WEpTRlJJcHUxbmRMUTNNTHZka1Y0QVNW?=
 =?utf-8?B?STlMdnhRYkE5d1dhZWlQR0xHdXM2dWZJc1Noek1wNTJraUNWTnc3bDE4bitu?=
 =?utf-8?B?azJDUHNyaFFoUCs5cS9EYmpuOXVaTmN1d3F6MUZJazFWRXhXQUpNbHE5RHla?=
 =?utf-8?B?Q0pDZ0N5bjlpZmVYbmREV3A5SXFhUGR6M2JWT1RBZGFleERTaXdGMmY1UWow?=
 =?utf-8?B?VTlaTjBUUXRpMERKNWwwRjZRMUtsVVBZVHJSN0dSMUpFM3g4WU9jTnREMVUx?=
 =?utf-8?B?Y25hZTZsd3NZNEswTnZrblZFTVlWMUw1dkdUcFhSeUJhNHhUakVScG0xWmlh?=
 =?utf-8?B?Tk9HSzlEUU95T2RrUjVoWDVneTk0WWI4bHYwZEE2ZFlWZXFiMkFXUWFveUYz?=
 =?utf-8?B?eS9yTnZ6bmZYZDMwOXo3Sk53NCtLU3JuZUlWNlFGL1BUSkRZanZ3WE84cmxr?=
 =?utf-8?B?cDlRczNwK3NzYkRJMkgyUUVuRUx0UUFjSGJnNUFPeFpSVmZmREZ5ZW0vTFI3?=
 =?utf-8?B?QjhPNTgvaDNVNDlra2M5Q0JLUjNuZWplT2JQYmtNcGRCck9Kb1ZmZFI3K290?=
 =?utf-8?B?a3N6ZHRINUpvZ3g2N21hNVQ5bXd6K1AvZm1NeklPMDVDaGNJRExTb3JWLzhh?=
 =?utf-8?B?ZmRYM05VdWpaeTdHb1NpNUZJRjh4UjYxYlp1M0d2YkdmUkJ0UmdxeEpLZElE?=
 =?utf-8?B?cjhxZk9CYXR0QVhlSTJHWDdpVW11MSsweGdNeVNoeno5NWNmcGUzclErby92?=
 =?utf-8?B?MUR4dHk4NFZPUHgzYUV1K0d1cFRtdHpaNStxd1BqblNqelYvVnYyYVBTVVRj?=
 =?utf-8?B?RGFSRHhtbkF4TUpaOGtyeXRkVm1UU1ZGd1VWV1EyV1RmZndFR09kRHI0SGR5?=
 =?utf-8?B?L1g5VHhBY3NUYk9yV085bUZ6OGpCQ2dIVmpQeXBVVkYwbk9HNFBmSFUyQm0r?=
 =?utf-8?B?UEtwVEgrbzlEeUM5TmYzNTJvSTNETVFnMGRac0lwaHllZW5TTGR6ZlVlbStv?=
 =?utf-8?B?eC9IU3FEQ21TZU92UmN5emUrdGdrVnNMclRXUnZyelJXQ09NU2VMOHZHVXVI?=
 =?utf-8?B?ZXVsRDU2ejVYY1d1d1BUTkxucnoybGRSQWlibEk0NTlyMUFaZWlpdkR0ZS9i?=
 =?utf-8?B?TTNqOFV3WVJZQWlUeW9MZy84VW5USWF4bUkrVG5KNVdnTThwVHB3WWMzYU1w?=
 =?utf-8?B?ZzlSUndGbHVObDZmazVsem5yTnZTeEIzK0hsY3lCZWpvTzRYUHhLcUs0R3Bi?=
 =?utf-8?B?M3VKV3FIcXo0RjJKa0ZBenc1ZW1WNlpjM0srNS9NMWtlQ2ZxUmxON0xxVDRq?=
 =?utf-8?B?bkdJOUhzeXoxdXpSbm1HVHUzTUxMdEJDNjBBM0xQYjVxc1ZnVldRd043b3pZ?=
 =?utf-8?B?QXhydHQvYUh1K2lacnROdHlEdGZKWVIxV1hSUWhKb2FuMEY2ak5SQm5aVG9s?=
 =?utf-8?B?MW1JM01JanZIbkR4VHFSbTRyc1BYU2FCNGYvYzFsQUt2cG52aDZhR0RWQVQx?=
 =?utf-8?B?aTJQV3p3d0pxN1ppOFN1QWhNOHJxNG42NDdvOUgrY2RIa0owdS83Z0pyY0Z1?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8B34FA54468624D9453CF3BA69BB54F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f8119a-540f-43c5-69f6-08dbd4f5781d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 00:58:14.9907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ehgZJdem+5elrJopJwPs4osmXPIxBPZRfLOBPHN/3QpkxALOb9yMm7LcJaoqeVAl9ixNXgkzfR8Gtdk4SUQ4votRPTI7Vw3t2oUJRgDf79U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6724
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpPbiBNb24sIDIwMjMtMTAt
MjMgYXQgMTI6MTQgKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJ
bCAyMy8xMC8yMyAxMTo1MCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gaGEgc2NyaXR0bzoN
Cj4gPiBJbCAyMy8xMC8yMyAwNjozNywgSmFzb24tSkguTGluIGhhIHNjcml0dG86DQo+ID4gPiBB
ZGQgQ01EUSBkcml2ZXIgc3VwcG9ydCBmb3IgbXQ4MTg4IGJ5IGFkZGluZyBpdHMgY29tcGF0aWJs
ZSBhbmQNCj4gPiA+IGRyaXZlciBkYXRhIGluIENNRFEgZHJpdmVyLg0KPiA+ID4gDQo+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+
ID4gDQo+ID4gUGxlYXNlIGZpeCB0aGUgY29tbWl0IHRpdGxlLi4uDQo+ID4gDQo+ID4gbWFpbGJv
eDogbXRrLWNtZHE6IEFkZCBzdXBwb3J0IGZvciBNVDgxODggbWFpbGJveA0KPiA+IA0KPiA+IFJl
Z2FyZHMsDQo+ID4gQW5nZWxvDQo+ID4gDQo+IA0KPiBJIGp1c3Qgbm90aWNlZCB0aGF0IHRoZSBz
ZWN1cmUgbWFpbGJveCBkcml2ZXIgd2lsbCBuZWVkIHF1aXRlIGEgZmV3DQo+IHZlcnNpb25zDQo+
IGJlZm9yZSByZWFjaGluZyBhIHNvbWV3aGF0IGFjY2VwdGFibGUgc3RhdGUsIHNvIEknZCBhbHNv
IGNvbnNpZGVyDQo+IHNlbmRpbmcgdGhpcw0KPiBjb21taXQgc2VwYXJhdGVseSBmcm9tIHRoZSBz
ZWN1cmUgY21kcSBzZXJpZXMsIGFzIHRoaXMgaXMgc2ltcGx5DQo+IGFkZGluZyB0aGUNCj4gc3Vw
cG9ydCBmb3IgbXQ4MTg4Lg0KPiANCj4gDQpPSywgSSdsbCBzZW5kIHRoaXMgc2VwYXJhdGVseSBm
cm9tIHRoZSBzZWN1cmUgY21kcSBzZXJpZXMuDQpUaGFua3MuDQoNClJlZ2FyZHMsDQpKYXNvbi1K
SC5MaW4NCg==

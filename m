Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFCE7AD4AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjIYJkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIYJkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:40:39 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11BE9C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:40:31 -0700 (PDT)
X-UUID: 8ec6d91c5b8711eea33bb35ae8d461a2-20230925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=RX45siTa660glXQkRiIHhgm8XWVb2gceybpT6u1N26Q=;
        b=O7Bjdp3bYOkck4SjEh4Ri+V4hKH81cwEn3Yh+WUIhPL6/ghilQiU8ubyxTge5MK4IRJrY5n4ZLv76MmnCsiICDMjl86iNpSs/38y0VmMoRAuSks5mSdivNp/kb69/eyHRV3DNv9M6C9NARWOMZ4GOQ3cERus7TGRvwxljmdkf7s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:3d1eb179-8d0c-4ae9-b61b-3f4758a3e9e5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:86901af0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8ec6d91c5b8711eea33bb35ae8d461a2-20230925
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1932204815; Mon, 25 Sep 2023 17:40:26 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 25 Sep 2023 17:40:25 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 25 Sep 2023 17:40:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8tkgB5z3WPfqkh3faWFwOLElVn77JOPORXScv+y4XktaCKoqlqxcZbf0ahq+dO/7ujwyoLB+XxiB2Qh1Hiy81JmVNF2E59oiUjxipDNwMtcv8/Sop17wkm7Ibx6UiewI9PvzUZvLW7VLBHdWYaM2DIxq4+R0DGXNGvmMC8g02IY1sjg68qXIZLHvJL08aTV5wEjkvqqMTzlxAElCSj8ctz5E7KeQljlXI0fn126RPSAja2Oo7cASSoTGS75XtLLfV2Dvl5o/qPKpn59Jz93uPhUDrHlmZ5E6A1Oeozf9s6qC8SpDCO5NhKnTQO3AVvTMBi4Q81bx/6hDWcxawCP0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RX45siTa660glXQkRiIHhgm8XWVb2gceybpT6u1N26Q=;
 b=eMR6v8WDyLxO1hD6CoDzyaOrWUr7kho9M6l2VVgI4mQp1kBCFGNwDDs+fqWJ1KzGUzW1t3Q4p85563qNUjXE2Vp4KIBBamr7bxmNWdkKCLiQl/M5SL90aYk6DUUUGJMs0DRhIY38GSX5YmOc2vX9GHPzP0Vx0XdjnjG1sCO1I7ArUiXh4Jbu/T7WUi8w1W/rkVxGEuV/dGciLY8GwubkjbAAsjwz57YnErxPacBiYT3/1RTAoykmQvajOGappeTe62nn2Ca8rfkfxsMzgYhC98bIbujpLmqy+BzNei2H46pmURFZqgGgeibDCklbxVieL6j7PQdfqlo5cTLOEeBFig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RX45siTa660glXQkRiIHhgm8XWVb2gceybpT6u1N26Q=;
 b=QJh7aXsON1bW3tgVovn7Os7jHftCmhrkzqFlXKqKd0AmhQDdI0AMxBLk03G0wOuecGOybcxjstQcFQr47pxo1t801IwSD8rJKQi+gk3J8jdvwihDjjvixCMcmpUZfao9SUZlBnpTYZKeKmu75BkPmzDZRM9gdspqLxUIE0CirP4=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 09:40:23 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%6]) with mapi id 15.20.6792.026; Mon, 25 Sep 2023
 09:40:23 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "hmazur@chromium.org" <hmazur@chromium.org>
CC:     "mikrawczyk@google.com" <mikrawczyk@google.com>,
        =?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= 
        <Bibby.Hsieh@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "upstream@semihalf.com" <upstream@semihalf.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "airlied@gmail.com" <airlied@gmail.com>,
        =?utf-8?B?WVQgU2hlbiAo5rKI5bKz6ZyGKQ==?= <Yt.Shen@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] drm/mediatek: Check GEM buffer size
Thread-Topic: [PATCH] drm/mediatek: Check GEM buffer size
Thread-Index: AQHZ75HvpSpLSCxz9EKlNFTlhEDAQLArSXcA
Date:   Mon, 25 Sep 2023 09:40:23 +0000
Message-ID: <298927114c054dfaca41e94520470a4c9430e6e8.camel@mediatek.com>
References: <20230925092249.2228743-1-hmazur@chromium.org>
In-Reply-To: <20230925092249.2228743-1-hmazur@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB7468:EE_
x-ms-office365-filtering-correlation-id: 91f3f6a8-e8d5-42fd-88bc-08dbbdab70b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jzB6hPlACzaJnd8OLy63CX1j97kLF1owvmzFi/x/PRwEzlrHPe3hP+x/0G6PaKUWNGZ+pCMG//MGEr/HKN1ki/4rfmvPlbwTtauKxQbu9a0OSlGaJ2OaHMGrllCtLq9TLU6A88iKpunCPuKNFiu3d3CD+FIEFFBNYIyIlIorEhjlyEITsUQ5rvr9S8tkgHm40Ain0zgsLpsGX+n6xAiV0beg8fbvjbN7CgAxK9Wqn0UP9OSXQ4PsEwYVpHuGfNACrHg4C/3cg/O4EftO2djz3Fnpk4lKgjT2D3kSK1Tt0myPowyJjn2xoMuFSBgx5B170feKY6m5DJcSg7ELJ9/yK6er+jjbO+wjB4DnaC3cVcdMYD57lrWxLf0FSZ/GqgK+E0ZFBeOwIbWcLnQUoFPZvybyZ90Mpq6luNIc5bC6Rx4yol8obUV6jIyWRvC/DC9T8sgotgTlZqh+kHYKpdMquUOKmFtBWORxIm097iuH/Bv82s0s3nqX3g4EZoVbMxHA9w9YWxmb1rH4Q4cJF8QGlFPir/ULeI151yUjscLdnGOuL35pJIjih53TIx3uZfm7nNHbQo22B5lF0zzUpLcM/twJPhzc2q0eZa1IyXplmdjPnIXg7M8yZSMCDI2G8jQrJ75tefwKs/zS18Wp9RN9yCB1UjdRV/kLdW3m/DCihL8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(346002)(136003)(230922051799003)(451199024)(186009)(1800799009)(7416002)(54906003)(83380400001)(2906002)(5660300002)(316002)(41300700001)(8676002)(8936002)(36756003)(4326008)(85182001)(64756008)(2616005)(66446008)(66476007)(66556008)(66946007)(76116006)(86362001)(91956017)(110136005)(6486002)(6512007)(6506007)(26005)(71200400001)(38070700005)(122000001)(38100700002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0JZNjFrZG96aXFFc3ZuZFd6dFgxc3lIbVJLdzAxQmtnNmRrUW8wdCs2L2k2?=
 =?utf-8?B?ZkV4ZGRtTVA2RkxMSTM2YXlkbW5TNzVDUmtDTmFFcHFXWjZIaFhiMGt0cWZo?=
 =?utf-8?B?ZnlyM2hDelhxb29CN1pXKzZCRkZLUUFNaHd1VGROeCszellMS1piRS9McHJR?=
 =?utf-8?B?cUc1VDAwZElURHdSSTMrY2xJc1Qyb0dYZ0pPcEZUa3B1UXdPazF5MTJzeWV3?=
 =?utf-8?B?d3VLR1YwWHo2UTFET0MxSW5rRnMzZVM4T3FlWnQ2b292STk3T2lHazkzVVQ2?=
 =?utf-8?B?am50Lzc0dEttY0JMb3lDdzhJWmtMQUVvMFhvZ3NHV2d4Z3dNSlhZVkZ2RmFQ?=
 =?utf-8?B?TkkvblduUFJoMnhkOVgyVC9FaHdGTzB6R0tJRndrVVVwbUlGb0dLb1RMRDZV?=
 =?utf-8?B?ZU1FazF0aS9BMUp6SmEyTnllbi85S25qRk03OWJWVXlKK0paZjJMek5BRFdB?=
 =?utf-8?B?amdEb0tuSEhTWS9QYmwveXhYVXlWN280TDR5QjZGNlNkM1R5RXZpdW1mSFV6?=
 =?utf-8?B?OTNTK1AvRkF0MnRFRXZERFFVUHU4c0h0VCtNY1dQNGZKdEQ5N2pCYzNqbkRJ?=
 =?utf-8?B?WUlSVHhaNW9xSmtVTk1SdEZWOUYwMEFYS2FMK2p6ZDNHZGRJNFN4WUNLdWxp?=
 =?utf-8?B?YUVLYjRCNEg4TG1HSEFzcmdBQTRnaUE0dXM3cm1VRjlaRTEzTWRiMzJBNGxD?=
 =?utf-8?B?Rm9abEQ1ZUNaNzVMRC9GYWRhblI5eW1aSll5NDVmUkxzMjBpTVZwVVFGOU9B?=
 =?utf-8?B?VHd1M3hkSWxtdUpGTGlNV29VWkJvbE9jN01TM3ZNcldidVl4amJXMk5Jb1dX?=
 =?utf-8?B?em12SXN6WEx3QlFYUmlzZEFpSHJXMUpsMDBwLzRiNmppcjZsaE9LemNOTUlq?=
 =?utf-8?B?ckFEZS96UDd1VHpHaTlCeXJlR0E3S3VDSjhKYnNEemNSSWRtdXNHV3g3cVFh?=
 =?utf-8?B?Mmx5S1JqcUg0MXpOVDVEblhlMHBUN0dNV0t0UWFPUXBadkNRZG55UVVPT2Nw?=
 =?utf-8?B?S2R2aW1CUDlIVFU0SFg4Vm9mVm5EYzBEb3plQnZLWjUyTHVMd1k4ZmpLcStk?=
 =?utf-8?B?eU13eXhpSG5ocjVldjUxUUtnWVBUR3lGWFhLYmtQaXRBd0ViNUhDOC9oT3h6?=
 =?utf-8?B?eDJaaFhTWjEyNWhQNS80dHhLNFl0QmdpSUNnbWJwc3ZMVThDWXIvUXdBY0l6?=
 =?utf-8?B?T1QzOU91TEJ6aUFjUktOcXZER3FaZjBjUnZUOTl1dU5yY3REWld4eHhHL1py?=
 =?utf-8?B?VllVbURqTys4a2hxQ2RJSmZ1L0tpcHpCMXMrdjB1Vk5INUVFWDdscmM3RVRT?=
 =?utf-8?B?S0ZnLzlSQ2NFZUMzdnB3MkZlM2hrWFF2Z1BMelAvTlp1a3JpTEVHa3hUZjB4?=
 =?utf-8?B?V0hqQm53SkpJV0F2RVhxL25QNVIxNGNVcTA2UTdPYyt2eDA5VW52eDBWalI2?=
 =?utf-8?B?R0pNTGQ1YSs5R2RmWHgybHBDaVFObDM1NG9YZFBTaXBhc2xHV2lmZUhyb2k5?=
 =?utf-8?B?N3pwb1I4ZGZZNE9uSjcrR2h3R2xNM202bzMxNy82OFA4MzdmRU5PSWtrTnFr?=
 =?utf-8?B?UStUaTkybXNxMGdhRlpWREErdUxNSG5ieFNINll4QWhCZlV0cnNIQSs1dXpL?=
 =?utf-8?B?bUJLV09yamk0c0EvaktheWsxS25HMFFaODBsd3Rycy94OWRDWi9NQkJIbjlO?=
 =?utf-8?B?RG9kM1JaaVpKMEZ6dGJEeTZ2dnJZdVJodjFWaHBhazA5Wk1tRUN2em1rUmli?=
 =?utf-8?B?bEdrL2xlREoreW9zTUw4eWdDVzRuM2lmL0V0NCtuTjdFMjdNN2ZqY240eEt0?=
 =?utf-8?B?UTBCYi84aWJJUTd3WTBYdUFBUXFqckoxaTdCYk91WUFTSTRXYkJZUWI5STFq?=
 =?utf-8?B?R0Z3Q3ljSVVnYlVGa2dHU0l3bCt4LzRIaUlQSE9QZkViL1pYSXl5QUYwZmxW?=
 =?utf-8?B?QjZETENmZEFDakRDRzc4SmVxRGxIVXBCTWkxOGpaOCtDRC9iTGdWRWtzaDJq?=
 =?utf-8?B?SVBtNEkwWWpabjdpbXRmWWJkY3N2TlNUUyt1QVlxcWt1c1BXZi9LNDd2OE8z?=
 =?utf-8?B?REJkL2dyT3A0c3JTM0l4bzRJakp4Nkp4OHZ3VGM0VTY3cGJQaHpUK2UvSWNZ?=
 =?utf-8?Q?jBYddTXlwgbEULMqD2qsfm71a?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A52DA417F031FB4EB43832821A80484B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f3f6a8-e8d5-42fd-88bc-08dbbdab70b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 09:40:23.0993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k3c6N9HjoIHpVX0mQcLy1Qpc7EbqSlS98Xjo7D6FbNoBbdILAqxdQPaS2bu4Fpwajagnq7qDitWfqTh9hP/ETA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7468
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--20.752300-8.000000
X-TMASE-MatchedRID: scwq2vQP8OH4OiVTWoD8RCa1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
        CsGHURLuwpcJm2NYlPAF6GY0Fb6yCkjlo2JU8qCxUWDKbJeCAy0+0OxGJE/R31iPAfsxl1xUKWU
        zl5UcyBaB0+7MfaaXm4cGya+XvujybJ4YXFuuruVsIyeExXlNbjGZtPrBBPZrOZLXi4h9F1eVj7
        dCVYq8LTNDXY/Gsvqt86y/Y5TghwGPaFHMfVTC4NIFVVzYGjNKWQy9YC5qGvz6APa9i04WGCq2r
        l3dzGQ1A/3R8k/14e0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.752300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 6548DB6F724EA8299028054192562A1C539E425E061D036C0B0DCFA9827CB1E32000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEh1YmVydDoNCg0KT24gTW9uLCAyMDIzLTA5LTI1IGF0IDA5OjIyICswMDAwLCBIdWJlcnQg
TWF6dXIgd3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xp
Y2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0
aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgVGhlIGJ1ZmZlciBzaXplIGlzIGRlcml2ZWQg
ZnJvbSBwYXJhbWV0ZXJzIHN1cHBsaWVkIGJ5IHRoZQ0KPiB1c2Vyc3BhY2UuDQo+IEhhdmluZyB0
aGUgc2l6ZSBlcXVhbCAwIGNhdXNlcyBhbGxvY2F0aW9uIGZhaWx1cmUgbGVhZGluZyB0byBrZXJu
ZWwNCj4gcGFuaWMuDQoNClRoZSBzaXplIGlzIGNhbGN1bGF0ZWQgYnkgd2lkdGggYW5kIGhlaWdo
dCwgYW5kIGRybV9tb2RlX2NyZWF0ZV9kdW1iKCkNCmhhcyBjaGVja2VkIHRoZSB3aWR0aCBhbmQg
aGVpZ2h0LCBzbyB0aGUgc2l6ZSB3b3VsZCBub3QgYmUgMC4gU28gdGhpcw0KcGF0Y2ggaXMgcmVk
dW5kYW50Lg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiANCj4gRml4IHRoaXMgYnkgY2hlY2tpbmcgaWYg
c2l6ZSBlcXVhbHMgMC4NCj4gDQo+IEZpeGVzOiAxMTlmNTE3MzYyOGEgKCJkcm0vbWVkaWF0ZWs6
IEFkZCBEUk0gRHJpdmVyIGZvciBNZWRpYXRlayBTb0MNCj4gTVQ4MTczLiIpDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBIdWJlcnQgTWF6dXIgPGhtYXp1ckBjaHJvbWl1bS5vcmc+DQo+IC0tLQ0KPiAg
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZ2VtLmMgfCA1ICsrKysrDQo+ICAxIGZp
bGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fZ2VtLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RybV9nZW0uYw0KPiBpbmRleCA5ZjM2NGRmNTI0NzguLjNiOTg1Yjk5ZDVjNiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZ2VtLmMNCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZ2VtLmMNCj4gQEAgLTYyLDYgKzYy
LDExIEBAIHN0cnVjdCBtdGtfZHJtX2dlbV9vYmogKm10a19kcm1fZ2VtX2NyZWF0ZShzdHJ1Y3QN
Cj4gZHJtX2RldmljZSAqZGV2LA0KPiAgCXN0cnVjdCBkcm1fZ2VtX29iamVjdCAqb2JqOw0KPiAg
CWludCByZXQ7DQo+ICANCj4gKwlpZiAoc2l6ZSA9PSAwKSB7DQo+ICsJCURSTV9FUlJPUigiSW52
YWxpZCBhbGxvY2F0aW9uIHNpemU6ICV6dSIsIHNpemUpOw0KPiArCQlyZXR1cm4gRVJSX1BUUigt
RUlOVkFMKTsNCj4gKwl9DQo+ICsNCj4gIAltdGtfZ2VtID0gbXRrX2RybV9nZW1faW5pdChkZXYs
IHNpemUpOw0KPiAgCWlmIChJU19FUlIobXRrX2dlbSkpDQo+ICAJCXJldHVybiBFUlJfQ0FTVCht
dGtfZ2VtKTsNCj4gLS0gDQo+IDIuNDIuMC41MTUuZzM4MGZjN2NjZDEtZ29vZw0K

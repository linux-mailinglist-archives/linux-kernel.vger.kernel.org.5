Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02517D4573
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjJXC16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjJXC1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:27:55 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2800FEA
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 19:27:47 -0700 (PDT)
X-UUID: e5b69e44721411ee8051498923ad61e6-20231024
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=WuKx0iGNzIFklFUkJCMEcoI/bnNtDc5DlZwC0tF+T3g=;
        b=EWuw9lr4PinumxOb9p+aUH0eHepRaTAe64gtNuT6Rbs0QrCJ+gBbxVoJY906C8Sqj+8ekZgBfUrBj7lXXcok60fp/+IfFvG1621jMuZNN8mgsOA0XC4/oqryfqFMdhSagMS3NnwxvaCoaC2cNlJTm6hTwBMhLsukmvVGGBGrx5c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:9245ec47-23b2-406a-9b1f-c7d78bdf677c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:24eaaffb-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e5b69e44721411ee8051498923ad61e6-20231024
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1245767738; Tue, 24 Oct 2023 10:27:37 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 24 Oct 2023 10:27:35 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 24 Oct 2023 10:27:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KavM/LkaPAErHw8YN5VDSC0TxR07k+0aViEPOwGYpPQnFe2y+Hvx73yBRlmXVwyfzmAyTe9F05OM9saDPzy9udOn/1t3IZYSn5zDzgi4O8NLt9WOP5kMCKWey77JtRkZ2E/xqMp1/kNayg8mBwdir/0fpLlmApYx52muYz5Y+xM3qJie4JM3WoiZwh9osfcUKHMoImc51NElQRLk4tbOspbB4Lla8kxxma5gx/dSwCvNdljatYnCgxxyr1IWrNyO2nmXe26wNKf/EWcKvZAmwq2qtLiTXh7ccu88dcTzjES4yOnmtA99nCEtTFaC+7DYbqfH2cJFOJf2dLTndGnvzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuKx0iGNzIFklFUkJCMEcoI/bnNtDc5DlZwC0tF+T3g=;
 b=flEZS/LEEZChDHVlaYrnwi9NRgcdxp5+QrTxire14ztYk5nPgPWdMG7N9nsVQW4GKdr0jzGqoxo9dl/o+SH3RGKUCxZvvNzYlncFxI5U6cQRtj7um2Wb4GzCu2BCGke65mrvnUKvgSBn7w02VDRnRJjS2qviMf9ZUxHiuZUX7Cv1SGlpGXPBLwvixpuFYdWP6s0nBgRmzRukMeRi1hTb4rKktXxAKZgB9E5DyGwfrHctSQFFStXUd7DUOPwLQyHX+oo5HcR1LwyR7QzGpqOlMSvrcu3mGAPUbHkGFgV21ruebsSp6Byda49pZOujOf/shkI0IR+ueE6zhn0qce68PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuKx0iGNzIFklFUkJCMEcoI/bnNtDc5DlZwC0tF+T3g=;
 b=QtaHOU2lixttb/3ahKLKGQm+/vcefdRSLZuvBvnv3ejlvlz5axrkuy3cNxPUqTVqLAC+XxbRk0YAQeUFW3UjlgXMHzK+Ha7Ny4jOqHvpv3QStO0H/aLyI5pCNEzR1bjSGvriIGGCcp4HcW9AuHcTxrkaJUiQc5dvFGDtxi5zAhs=
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com (2603:1096:820:94::13)
 by TYZPR03MB5472.apcprd03.prod.outlook.com (2603:1096:400:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 02:27:33 +0000
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::3b6f:e1e1:39de:3920]) by KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::3b6f:e1e1:39de:3920%6]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 02:27:33 +0000
From:   =?utf-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 2/2] ASoC: mediatek: mt7986: add sample rate checker
Thread-Topic: [PATCH 2/2] ASoC: mediatek: mt7986: add sample rate checker
Thread-Index: AQHaBZcHdN6IDYvlPEK2UEiwH0iu+7BXNugAgAEBMYA=
Date:   Tue, 24 Oct 2023 02:27:32 +0000
Message-ID: <c5a19ddaa458cbd48b8040d1b6e81f6cfe017906.camel@mediatek.com>
References: <20231023095453.4860-1-maso.huang@mediatek.com>
         <20231023095453.4860-3-maso.huang@mediatek.com>
         <d1c7833a-10d6-4188-a0e7-fab31a6bad43@collabora.com>
In-Reply-To: <d1c7833a-10d6-4188-a0e7-fab31a6bad43@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6389:EE_|TYZPR03MB5472:EE_
x-ms-office365-filtering-correlation-id: e42fd119-24b0-4e89-804c-08dbd438c75a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hBvTeDJE/jSlvVW1Z11aCvkQkiuurIGsBfd+Lo8QyXn/fCguOl8TtH6oyDCBGXje6Tpq4WPQgKDVPc5WumXJTEKwKRWi8p+ODf+xEGwM8VCYJOsDMmYCao9MAxbD/rgrkqPi4ZMe0Q2i9TzOncR4kN1lINsUZs7FcJsrCxm9cQoJQFq6JlH9JTYjOC4iSjl/DxGGfC4I+CpKDFtSJHTbgqqAhJloTS6drm0x9UTazVGwayTr8QtgL0pCnvK1T3WoFH+BZi/ewvLfaMZ7YiQ0zpco9jhAxBNv19T58FFi2IvxkqAte4Dkp7GNsvw/SbC3i/GAQmzw/8wP38Ryvw+1fGrKbsemAZCuKdimWh6tjyVfZeRjvx4/MANn8SEoD+T71b480ENLEDIETXtFzZoRjnVtL8vMMGkEytWYzldQi7NLK1e7LRzSNdVuy5hLy699IoLI1OfzIzRZW9lyMT8TIw74cwVVRcyKOe8bWM2kWvXiNZWO5+jmWCnxODREaSt1Xg7pAT4X5KZbbGvkLi5zSGGPgYd+dxCXbn53EADy1vsd2BnFjzMo8c1jg8Y/FSEjN3rcsQqyfC93cErXJXauD+WnzprOVLmfmRMl45QKsnB7y/jw11rls9PjDb0gD0jMXkh3DqSEQfdGmg4nfMkqBjKVHgBmPQpY1TJVPNMwnZ0epr7NvzlAeJw9AC6K1aAP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6389.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(39860400002)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38070700009)(921008)(2616005)(6506007)(6512007)(38100700002)(122000001)(86362001)(85182001)(36756003)(26005)(41300700001)(2906002)(7416002)(71200400001)(8936002)(4001150100001)(6486002)(83380400001)(478600001)(8676002)(66556008)(5660300002)(64756008)(66476007)(66446008)(316002)(66946007)(91956017)(76116006)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDVSR0tBeTNmcWdScDYxWkozMFdldjdNQU5NTm9MQlpSMFA4UVVmdlNRVTRI?=
 =?utf-8?B?dmhHVG9nU1RPN0oxNyszSWNORld0OHR4cys4T0pTN3RaS3Nnd2w1UDlTTG85?=
 =?utf-8?B?eCt2SlVsdTRtK0RROWU0LzFmUm9lYUVUbHMyRVNzckZSY0pUN1RoaGo4UHBK?=
 =?utf-8?B?THB3bjZLcHJLRDU1aHkvclpSTldPaUlvRVgrcFFxRHVDRHlGWitrTGdjSTBK?=
 =?utf-8?B?Z09SdEtMNXl3aFFxQUd1UTJjd0t2NkFRWlFTbWNiaGVndzhieWJkenlXQlVn?=
 =?utf-8?B?TWlmeGw2WkJCYmJ0a1Q4VDY3T1o5Mk1sdEtYcTIyWTVHRDlUNDYvbVhiQWRM?=
 =?utf-8?B?WXdydWgwVDF6eE9CdEFOQVh0RVpJdklJSnluVmJvNXhzYlg2bzVWcjVLeVBF?=
 =?utf-8?B?dWNneml2Q0Z3bG5QbC80Qi9IRHhSZlhFVEZuQ3YrK2FWY2g0Q1RNQ1dFN2h2?=
 =?utf-8?B?c3dtbXFLdngwVC92NHl1M3RsYURRL0ZwRzM1dVdLT282QkN2YUd6bDhqZHBN?=
 =?utf-8?B?bEZVdElQMWd1NlNRaENxdmZSY282MU1WanFPWGh6cUhZU091YXRhYmdOcndS?=
 =?utf-8?B?dXZyRnd0TkFKcTFIblVIQS9YcWlIRURGSVJrY2dtZjR5MjdZSU1BbjRrMk56?=
 =?utf-8?B?clpWRmJWTXVENWxqRkwxRFRDQWZleWlYWk91QTB6QjZKRDFvS3BTU09McFdk?=
 =?utf-8?B?K2pQQlNXWk0wSU9DSVRYS0VnNThmSzNuRVlTTW8yVDJVZUtyVWY3Vmh3VFM2?=
 =?utf-8?B?bXV4TTlIYTBqbFJ3SmhLR0N1U1NKVFdydDdGSTBZYnliU0pGMkpqK0ZZY0gx?=
 =?utf-8?B?bWV1VStZZDVxcytlVVhIOHV4Mm0veFI0cXMxc2xyNnlLQjhsSWZ1bUpweXR6?=
 =?utf-8?B?ZDBxYnhmVitUUFg4bHBTaDY3K0hWbGhMeHpYZE1TeDNUUTFGb1pyRUMxT2J2?=
 =?utf-8?B?cVUxQWJWa2lhcWFLRlpYNjJJZ3RtbzFtcVllTmtXWGhLVm1UK3hHaHI3Y2Vl?=
 =?utf-8?B?SHJ0MDF5RDViY3FnNkdkdlJrOWx2R0tJekR3N0lLY3FWZHQzTWJKd3hEcVdG?=
 =?utf-8?B?SGtlTExwVHJCTUVTbDBrdFJiU0wwR2V6d1VGVE5IVDFZUGlRSThjVG9DUUpZ?=
 =?utf-8?B?Yk1ON1BnUk1jVEJST3p1L3VBSTZlUEY3WGk5aHBmcVFBUXYzT1lqUWhmLzNs?=
 =?utf-8?B?Y2k3Z0pPejdXTy9ML2J3MWRpVlZ0TmZvc25OQkVIanNNdkFBS2t2MHZRWVht?=
 =?utf-8?B?SGw3WXk5dUQ3dmxUSXRDZGdQaDZGM1J1ejBwdlNvcEdwcGpuczFZT1YrT3V2?=
 =?utf-8?B?RHZVRTV4T213OEJYZEVud251YjdPZWsyZWNxZEFGUTc0b3k4eGgraVl4WERR?=
 =?utf-8?B?U2JObzVyZ0xYQU5RaTdnTm41dS92TUdCREQ3bGhtK0R1V0pueHNsN1pSOC9B?=
 =?utf-8?B?Nzg0aTNKWnlpQ0xhWUtiVmlITFgxWkc3WDJOWFI3NFp2MjlhYndqVUZsOU53?=
 =?utf-8?B?UURha3NpcjJIWEgvM2NOYThmUU5qOFdiZEhvalYwYUF4RElQZWFwNXJXOVhP?=
 =?utf-8?B?WGhNS3dyWWU5RlVJa2tCWjVWYjlYTzhnbVJJTFJYaHpTRDRQTjk5OVNWNHBq?=
 =?utf-8?B?cVNiVisxR0R0cDhXMTBvM1B1dDVzaGhEWk5qY3RDTVhsdFd3eGEvM1hFZlF4?=
 =?utf-8?B?OVE3R3QzY0VmczlzZmNVZlVYSDhmWm9nU1NpMVhIUlIxaWNqTnZjSHN6a3Vu?=
 =?utf-8?B?RVNabFlxakdId2p6eHl3VWtheHhRY0lXSkxlZHdMOXFxTzQ4U3VqSzJvWngw?=
 =?utf-8?B?Mlk4L2twSzNiRVdQMlNRT25tMkFGSmprV1hnTk5zVStsM3NtRzllckNDQmZx?=
 =?utf-8?B?U2U4SkQ4b2x0aWZaUlVuSDZvNUJiZkpSRnVOOElGN3dUWVRmQ2tuT1J3ZVVO?=
 =?utf-8?B?b2RwY0dQdG9BektRaDlmT3E1WXpieVJ5ZzdlRmJ1clZnaUdiY2lYTys3SU1I?=
 =?utf-8?B?dzVqVVY2bzlyM2N4M1hSSkcvTnA1dTFXT25ySy95ODBYRU14bm9Tdkd5QmZL?=
 =?utf-8?B?Q2xvREEwazFoWUNQRGpUMTkyUExrSXNWcnkzdTY3YnBKMkdOQk5zaGRVaVBI?=
 =?utf-8?B?TGZiMlJTVWdQWlV3WnRVcXlCOGVERFozR0tudklqRy84L25kU2M2elBCRC9X?=
 =?utf-8?B?Vmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4793EC5EA328F34D90A133A420DCF5E0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6389.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e42fd119-24b0-4e89-804c-08dbd438c75a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 02:27:33.0299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QQeh/SZySoDJXufYkndoNesha/+Uc5JTJkbOoKYz3ojEAiikod/5bAT7dZduo9m66k0AQ7vJvXrZjSOrg9eTcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5472
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--12.818900-8.000000
X-TMASE-MatchedRID: ge9e+QLSeazUL3YCMmnG4t7SWiiWSV/1YefZ7F9kLgsNcckEPxfz2Iqe
        hz/PsL8GrvuhYKtRRDX89WDKQGB2Ll5BIUo7M3+zA9lly13c/gH0O7M3lSnTWw5SzgJNSArLMMp
        wBab+8fc58CIn96icLWYlLqTvfoxMSh0iPjWqVYDmAId+2bAQwtZKsq3DGpalmr3uSkzoPhH6sR
        z1g/tlo+LzNWBegCW2PZex/kxUIHWNo+PRbWqfRMprJP8FBOIa1VrbCslo1IP4V5Ib92n+1SElS
        ioNgu77tJCA9A9vonVEDsxmx4hzbw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.818900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: B1D2D3E5AAD09CADD0A7C420690954EBD99BF8F955463C82B34C120DC3D231022000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTEwLTIzIGF0IDEzOjA3ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjMvMTAvMjMgMTE6NTQsIE1hc28gSHVhbmcgaGEgc2NyaXR0bzoN
Cj4gPiBtdDc5ODYgb25seSBzdXBwb3J0cyA4LzEyLzE2LzI0LzMyLzQ4Lzk2LzE5MiBrSHoNCj4g
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXNvIEh1YW5nIDxtYXNvLmh1YW5nQG1lZGlhdGVrLmNv
bT4NCj4gPiAtLS0NCj4gPiAgIHNvdW5kL3NvYy9tZWRpYXRlay9tdDc5ODYvbXQ3OTg2LWRhaS1l
dGRtLmMgfCAyMg0KPiA+ICsrKysrKysrKysrKysrKysrLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5n
ZWQsIDE4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdp
dCBhL3NvdW5kL3NvYy9tZWRpYXRlay9tdDc5ODYvbXQ3OTg2LWRhaS1ldGRtLmMNCj4gPiBiL3Nv
dW5kL3NvYy9tZWRpYXRlay9tdDc5ODYvbXQ3OTg2LWRhaS1ldGRtLmMNCj4gPiBpbmRleCBlNTIz
ZDMzODQ2ZmUuLjI3MDg1MmNlM2RkOSAxMDA2NDQNCj4gPiAtLS0gYS9zb3VuZC9zb2MvbWVkaWF0
ZWsvbXQ3OTg2L210Nzk4Ni1kYWktZXRkbS5jDQo+ID4gKysrIGIvc291bmQvc29jL21lZGlhdGVr
L210Nzk4Ni9tdDc5ODYtZGFpLWV0ZG0uYw0KPiA+IEBAIC0yMzcsMTIgKzIzNywyNiBAQCBzdGF0
aWMgaW50IG10a19kYWlfZXRkbV9od19wYXJhbXMoc3RydWN0DQo+ID4gc25kX3BjbV9zdWJzdHJl
YW0gKnN1YnN0cmVhbSwNCj4gPiAgIAkJCQkgIHN0cnVjdCBzbmRfcGNtX2h3X3BhcmFtcyAqcGFy
YW1zLA0KPiA+ICAgCQkJCSAgc3RydWN0IHNuZF9zb2NfZGFpICpkYWkpDQo+ID4gICB7DQo+ID4g
Kwl1bnNpZ25lZCBpbnQgcmF0ZSA9IHBhcmFtc19yYXRlKHBhcmFtcyk7DQo+ID4gICAJc3RydWN0
IG10a19iYXNlX2FmZSAqYWZlID0gc25kX3NvY19kYWlfZ2V0X2RydmRhdGEoZGFpKTsNCj4gPiAg
IA0KPiA+IC0JbXRrX2RhaV9ldGRtX2NvbmZpZyhhZmUsIHBhcmFtcywgZGFpLA0KPiA+IFNORFJW
X1BDTV9TVFJFQU1fUExBWUJBQ0spOw0KPiA+IC0JbXRrX2RhaV9ldGRtX2NvbmZpZyhhZmUsIHBh
cmFtcywgZGFpLA0KPiA+IFNORFJWX1BDTV9TVFJFQU1fQ0FQVFVSRSk7DQo+ID4gLQ0KPiA+IC0J
cmV0dXJuIDA7DQo+ID4gKwlzd2l0Y2ggKHJhdGUpIHsNCj4gPiArCWNhc2UgODAwMDoNCj4gPiAr
CWNhc2UgMTIwMDA6DQo+ID4gKwljYXNlIDE2MDAwOg0KPiA+ICsJY2FzZSAyNDAwMDoNCj4gPiAr
CWNhc2UgMzIwMDA6DQo+ID4gKwljYXNlIDQ4MDAwOg0KPiA+ICsJY2FzZSA5NjAwMDoNCj4gPiAr
CWNhc2UgMTkyMDAwOg0KPiA+ICsJCW10a19kYWlfZXRkbV9jb25maWcoYWZlLCBwYXJhbXMsIGRh
aSwNCj4gPiBTTkRSVl9QQ01fU1RSRUFNX1BMQVlCQUNLKTsNCj4gPiArCQltdGtfZGFpX2V0ZG1f
Y29uZmlnKGFmZSwgcGFyYW1zLCBkYWksDQo+ID4gU05EUlZfUENNX1NUUkVBTV9DQVBUVVJFKTsN
Cj4gPiArCQlyZXR1cm4gMDsNCj4gPiArCWRlZmF1bHQ6DQo+ID4gKwkJZGV2X3dhcm4oYWZlLT5k
ZXYsICIlcygpLCBzYW1wbGUgcmF0ZTogJWQgaXMgbm90DQo+ID4gc3VwcG9ydGVkXG4iLCBfX2Z1
bmNfXywgcmF0ZSk7DQo+ID4gKwkJZGV2X3dhcm4oYWZlLT5kZXYsICIlcygpLCBvbmx5IHN1cHBv
cnQNCj4gPiA4LzEyLzE2LzI0LzMyLzQ4Lzk2LzE5MiBrSHpcbiIsIF9fZnVuY19fKTsNCj4gDQo+
IFRoYXQncyBiZXR0ZXI6DQo+IA0KPiBkZXZfZXJyKGFmZS0+ZGV2LA0KPiAJIlNhbXBsZSByYXRl
ICVkIGludmFsaWQuIFN1cHBvcnRlZCByYXRlczoNCj4gOC8xMi8xNi8yNC8zMi80OC85Ni8xOTIg
a0h6XG4iLA0KPiAJcmF0ZSwgX19mdW5jX18pOw0KPiANCj4gYWZ0ZXIgd2hpY2gsDQo+IA0KPiBS
ZXZpZXdlZC1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiBhbmdlbG9naW9hY2No
aW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCj4g
DQo+IA0KDQpIaSBBbmdlbG8sDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXchDQpJJ2xsIHJlZmlu
ZSBpdCBpbiB2Mi4NCg0KQmVzdCByZWdhcmRzLA0KTWFzbw0KDQo=

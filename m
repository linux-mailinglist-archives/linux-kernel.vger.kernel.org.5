Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04227FB999
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344602AbjK1Lpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbjK1Lpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:45:35 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D082E10E4;
        Tue, 28 Nov 2023 03:45:33 -0800 (PST)
X-UUID: 9f041a2c8de311ee8051498923ad61e6-20231128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=jxEzhVidEAUL7kwrczHxUuLRyLe3XdoDapHRDjpGUf0=;
        b=e+qXIlsMseIjl11kYU9RRcOA0/PdoGvADpH7nvaUlorD+d5o7+fOora/xslIV1RuP16bqQAha706SK97mlI6CRVB8VaKmjKlH62de7CHGlJuUvq654OscOVA6/AV6uLoLZUy8fEdWiiHYE3QzcduxRRbH6KOMNvAYAKh6OGADBA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.34,REQID:b9ed5233-c16c-4a10-9aac-7446c2c30a77,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:abefa75,CLOUDID:528c2a73-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9f041a2c8de311ee8051498923ad61e6-20231128
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 559647206; Tue, 28 Nov 2023 19:45:26 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 28 Nov 2023 19:45:24 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 28 Nov 2023 19:45:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAC8RJVyfgQ6EP/6pwMU03ivzWVlAIPDU2VAZYfhD+gYhp31tyl7gwUR3rWtOo0YQyLbufX3UuedjiGg7diD3c2P1iJm8m8TSy/9muuMLPqkrUBe+Vg0NAHPW/461jVYsX77DNd8/j7cnFt/unRJrLZN2jMIWUsYVI7/cFmfkWGdBrmVo27/sw4vVXKh6+ACndIoaX0CLG+PsziuPkJuRCbW9BAATL3dMQU3M2KIgyezWq8wQoOWFKATmlL/NIs4apd6eebk7b2jg3MIfTKHAWi/67e8rfZkjahCicvWrdEaHZ88xpBdlgudzzD5Mfe/CvxWzY/XMiF9J+qesRMTrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxEzhVidEAUL7kwrczHxUuLRyLe3XdoDapHRDjpGUf0=;
 b=FizkyJwRsg2acLLlmbGbk6H0SOXZi8fz28Trxg5eVlCRoGHFPR677dzgtPDQAWhojwCY9QqLUUWbMVS+jkApS4hQ3INCPJVCUbB5sNJsIDVEoLqWyUl/vyB7UrsbLR+8jPHyPyTHwHdIsvBbvbNjwg5Km4r/Gq2F7ESp1QlNxyM9L/eNBVU2K/wrPZzZr/oSnLwIs+MKXIVH548f9+AZA0D2/d3HbSzkdmZT5zIKiuE2kOJ0/aYEecWDU+UOOFDn9scmVUYJmmG73jU8oFLsApsE2gK0TdvDP2pkznQjvc1hhJxonLNQCM4EyCqwf7zoPoC8tRN5p7FXJpMgve7ngg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxEzhVidEAUL7kwrczHxUuLRyLe3XdoDapHRDjpGUf0=;
 b=UJAQdP8riu1sG8lz4COKfKRTBWD1UNxErCa6HzMD2l4kDA28TcsEIg3LkdPa+0qfsj+hph5m3pJVz+XLRStQIoOk9WLpCVuxxKB3up/T3Y9MCJ2QLT4DYMzf1VTAVO5y0LgJKLB4ug3bhFF6cb/Nx3OShGtkvHSVoyQ6oN5Uv44=
Received: from PUZPR03MB5964.apcprd03.prod.outlook.com (2603:1096:301:b4::11)
 by KL1PR03MB8009.apcprd03.prod.outlook.com (2603:1096:820:100::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.26; Tue, 28 Nov
 2023 11:45:21 +0000
Received: from PUZPR03MB5964.apcprd03.prod.outlook.com
 ([fe80::a0a0:dd1e:a259:ca93]) by PUZPR03MB5964.apcprd03.prod.outlook.com
 ([fe80::a0a0:dd1e:a259:ca93%7]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 11:45:20 +0000
From:   =?utf-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>
To:     "oleg@redhat.com" <oleg@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        =?utf-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        =?utf-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "kbingham@kernel.org" <kbingham@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
Subject: Re: [PATCH 1/3] scripts/gdb/tasks: Fix lx-ps command error
Thread-Topic: [PATCH 1/3] scripts/gdb/tasks: Fix lx-ps command error
Thread-Index: AQHaIQAYmqqntI/yx0SWyXhmdFZA9bCOEWUAgAGNU4A=
Date:   Tue, 28 Nov 2023 11:45:20 +0000
Message-ID: <783d1e6d26c16fd846bb600d00c99a3ca074ccc6.camel@mediatek.com>
References: <20231127070404.4192-1-Kuan-Ying.Lee@mediatek.com>
         <20231127070404.4192-2-Kuan-Ying.Lee@mediatek.com>
         <20231127120314.GA19669@redhat.com>
In-Reply-To: <20231127120314.GA19669@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB5964:EE_|KL1PR03MB8009:EE_
x-ms-office365-filtering-correlation-id: 208f70e5-3be2-45b2-361c-08dbf0077fc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ch5uhBLbQ/Lg/FjIp5TJKHdvSEaYOtCSUeYccIVRvAS13jEReKBnV+XI/RPupeLN6r40meV/kq64UuSi0YucRejj7YdbGzqtp9LDuVGE01nImdhYKO6vqtyupkl1hd8QM+yG2rv2Ri7DQvcARCup5foG6v6xmCFpzRctKGasRaQvEoyq3v6gi1WKfNibU6ZTFtb4fYa0jeZEiM0UgNvOkuH123WT4GTK09/7Fn/JN1rQHouyG6zrg+MaNQkpapsYUJ3GZFXMYmZXFg3sn5Wf+1K0gBVZCPrfgOLsR2DrByG92RKTXncbTHOoSqQDlc1pckJovcm/aI7rp1yAH7vSTXltggpEPP7dwFOSdi+AFuJBFWWRcgzSPSSVxayLhG9DRB/uARgfwqBpDL32RzqDvXJ8qtUAldraw2YVH8P8sUPVq3hz41NR2VsgytcI07WPEHYAakEJEouLLLU/YX6dDKypDDKXAWV9SG+M2glP3rL4KuAdCnXfCDlXnUynnRoP6hGMrtuDusaAB37Et/0ydYsSMrmm6N0dFnp66q+/U0HBA2URIPbcGL1DBQvZqdsEQkf1FS1N+2gFs/HsyKQfKhCxgG9wQb3EnPYqhAjlsb5KVxFpAxSd4ga9dunVlqV4FWlICQKvQMcx8oRNcJFbuva8UaubY3XeVK0wBKqfglLPnZZ8Oh1LNEqqlwtzrMIgiOW9a4r6Twh75JfCMaQDgJF4ws9EqVc/kYHaK2ACH04=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB5964.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(230173577357003)(230273577357003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(41300700001)(26005)(38100700002)(122000001)(83380400001)(6512007)(2616005)(38070700009)(36756003)(4001150100001)(85182001)(71200400001)(2906002)(6506007)(7416002)(91956017)(64756008)(66946007)(66556008)(6916009)(66476007)(316002)(66446008)(76116006)(54906003)(5660300002)(478600001)(6486002)(8936002)(8676002)(4326008)(86362001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjBBajdndmYxOG42L1NVN0tVVVdyRkxJb29wb0d2QkJPdEJjYlowNGp3YkNB?=
 =?utf-8?B?WEhVTnJZc1JSdEI0Q2Y5Vk5YM1lRbnFmNFdQUHJuOGMyeXVOd2NTTWZKNDBT?=
 =?utf-8?B?QWx4YTBEV011cWtXaTdqL3ZLWEwvd09lZTZmUzI5RTYzVGFuaFgybmZzVnBK?=
 =?utf-8?B?MzVnazl5TnU0d1hrRVNLSUdCUndCQXZFTkNXT1JMeUlkODhTUFlNQnFaVmlw?=
 =?utf-8?B?bVpGSDBBbCszTVQ4cFkzT3FnSTJwR3p4VjVpeHlZQ3M2STJhK1FaOFdvaEJm?=
 =?utf-8?B?cDlyUS8wMUllQWNVVWtLbFNUY3Q0RjlyQWRrSTkyMWtzbmJxQ1gzZnVhZU9F?=
 =?utf-8?B?RGxsQlQrN1h0aEYxVkN5Nk00VGo2NGozekhTYW9iZkN2NUxNR0NkejJTRm8r?=
 =?utf-8?B?VURnWGR3K1lTQjVlYTNxL2FFU2VIL29xRkNpYXI2bllsb0k1WThHTFdiK0t2?=
 =?utf-8?B?RUQ2VlhjWldXcWpEakg2M3l0TWljdUNrcUFrUjd4ZlNHT0xzOU1oVk1lMVdl?=
 =?utf-8?B?dmdvTUFpN2UyRm92Nm9kcGREdDdOM1RzNHJsdjVaaHkxS0lOa0gxalhWbmRx?=
 =?utf-8?B?M0gvZks0NHFIOXppTUZrMjJxaStQVkt3cnhlbmZsU3dkMjBYUnJwb21yYjVZ?=
 =?utf-8?B?dUtReGtya3p4SDJVOTJnNUp1U0lQQnBkT3VZUEtlbUM4QXZ0dGNielBHQml3?=
 =?utf-8?B?QnVxc2RBamNLMmttNlhhMmJhT0RpTjNpSGhscDdPNXcvWkpTYVgyTTV6R1pj?=
 =?utf-8?B?MVJPR3JUZEpiUW80MGp5UDF0VjVtU0ZleUoyVDVraGllMDdkMk9iUXlHTmt2?=
 =?utf-8?B?WHJkSTdjdmJwWmFQZXNtWGdJUlpJc0RFcTMwaVhUanpZY3prRU5vU3h3Yy9R?=
 =?utf-8?B?Mnh0NFJXM21JRDBCQ2dLb1JTR3lMdFBua1huZ3JQa3VobS9walp1eEdZcFRs?=
 =?utf-8?B?N2YxWG13ckxDcXB1dDQxaFBJMEYyYTBRUlpIQVlYTmtVRERVOThsVEFVSXhp?=
 =?utf-8?B?RXcwS3MrZ2RGNlNiWG5SaGRmUnowakJjdm9QNXg2cjFRam1WV2MyV0FOaGFD?=
 =?utf-8?B?dXBzMmVOaTZIYTlXSWM1bVZ4MVpQQnVsRFNmc3lJOEx3dkxKUDQyQVNld2ZU?=
 =?utf-8?B?NGcydmtrOUNoNkZ6V1JRZUZQMVFEZkpKRytaN1NSN3JDUUljSzdMYVh6VzRM?=
 =?utf-8?B?em5Zd1VCeTFVNjQ4ZFhvaXBGT0hIOWgwTTRkMmwzc2xja1Z1ZWx6M3NkbExN?=
 =?utf-8?B?K2g5UUNMT2RqVXg1K2Era2lNd3ViaVNEZGViT01lYlV5cUlvN2ZjaTNaK0Vr?=
 =?utf-8?B?bUozR1J6UDF6MTJwRjI1NzRzbndlb1Y3Wi9IUjAzUDR3azdVK3dSZnkwTkxD?=
 =?utf-8?B?dGNWZytGZ0FJM3JIeDNiSHBzYzhXeTZ1UFYvLzhxQjU3V25HSElsQ2lJSDRa?=
 =?utf-8?B?dFRpOGthTHRhT2NSZWRBMzcxcDRiOXVqUGJwVWwvZGQwM0VFMXU0M2FYNzhr?=
 =?utf-8?B?ekJ0elJBSVFmUzlwV0hHQUJVZGMwdnMySzJmQUU0RnVkUzJkbmE2eHphQ3NT?=
 =?utf-8?B?QkdkNWg0V1FUUkVHYVZ5V28yRFdNa1JVbnYxMWVYMEpkTkFSSXZVY1FDQ1JG?=
 =?utf-8?B?enpUL1FpYjlGZFpBMkNkY2hqa2NpQStDOVhVeVJlVGMyaHNTbGJNd2NmOUlE?=
 =?utf-8?B?czdkckQ3d0h2bDNDSHUwbVF0eXhKWktLK3FMUnRKbExkWFNsZDNmRWJsNy9h?=
 =?utf-8?B?U3dLM3lYTWtsKzVNdDc1Z25lN2NhQzFzMzBEakFRc3BhT1VqWEg5Y2tFSWlu?=
 =?utf-8?B?Tjc5K0VwWXZCS1Q0SmlPTGZWbE1HYkRMdUFVQ1Irc2drQ3dQSEt0VWwrd24w?=
 =?utf-8?B?MjM4LzkwS1hCRnJDc2pTeGk3ZzlSZFhEZVhrWDVnK0t0UEVNaHc5NXQ3R2Zu?=
 =?utf-8?B?TmVpRHpSVjZlai94Y1dUcml4Qkx6bTcxb3hWZzYxSHltZDl1MEs0elZxWU56?=
 =?utf-8?B?MFQydEN2R0EyTzJPNEFyRE1OeVN1QjUwNGxxVE1VRkwwendDWWV1MjB4Qng2?=
 =?utf-8?B?QXpHU2xNdDBhdnhpNm9zVnVocEU4eTJIeGc1dU9Nd3VjQURhelBvcEhXNXlW?=
 =?utf-8?B?VHB6Zzc2RnpMalNVcHlEUnR1bzVYODBna1NBZGhvTndoYXBMbnpZbU85Vmsy?=
 =?utf-8?B?aWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EB7B40F72D2874BB71C6748E39F39E2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB5964.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 208f70e5-3be2-45b2-361c-08dbf0077fc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 11:45:20.1735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l8035yqvQ9+xCuBhh7+bVQzfgChuTGK0BwMVtdIZB1sHrGyMZ7x6EmdBlBv8A+ShGxki5u7qIV8kllXhgQkLd3dBsZb0GRR5LMHDB8KFcGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8009
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RDNS_NONE,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTExLTI3IGF0IDEzOjAzICswMTAwLCBPbGVnIE5lc3Rlcm92IHdyb3RlOg0K
PiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0
aGUgY29udGVudC4NCj4gIE9uIDExLzI3LCBLdWFuLVlpbmcgTGVlIHdyb3RlOg0KPiA+DQo+ID4g
QEAgLTI1LDEzICsyNSw5IEBAIGRlZiB0YXNrX2xpc3RzKCk6DQo+ID4gICAgICB0ID0gZyA9IGlu
aXRfdGFzaw0KPiA+ICANCj4gPiAgICAgIHdoaWxlIFRydWU6DQo+ID4gLSAgICAgICAgd2hpbGUg
VHJ1ZToNCj4gPiAtICAgICAgICAgICAgeWllbGQgdA0KPiA+IC0NCj4gPiAtICAgICAgICAgICAg
dCA9IHV0aWxzLmNvbnRhaW5lcl9vZih0Wyd0aHJlYWRfZ3JvdXAnXVsnbmV4dCddLA0KPiA+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRhc2tfcHRyX3R5cGUsICJ0aHJlYWRf
Z3JvdXAiKQ0KPiA+IC0gICAgICAgICAgICBpZiB0ID09IGc6DQo+ID4gLSAgICAgICAgICAgICAg
ICBicmVhaw0KPiA+ICsgICAgICAgIHRocmVhZF9oZWFkID0gdFsnc2lnbmFsJ11bJ3RocmVhZF9o
ZWFkJ10NCj4gPiArICAgICAgICBmb3IgdGhyZWFkIGluIGxpc3RzLmxpc3RfZm9yX2VhY2hfZW50
cnkodGhyZWFkX2hlYWQsDQo+IHRhc2tfcHRyX3R5cGUsICd0aHJlYWRfbm9kZScpOg0KPiA+ICsg
ICAgICAgICAgICB5aWVsZCB0aHJlYWQNCj4gPiAgDQo+ID4gICAgICAgICAgdCA9IGcgPSB1dGls
cy5jb250YWluZXJfb2YoZ1sndGFza3MnXVsnbmV4dCddLA0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHRhc2tfcHRyX3R5cGUsICJ0YXNrcyIpDQo+IA0KPiBUaGFua3Mh
DQo+IA0KPiBJIGRvIG5vdCBrbm93IHB5dGhvbiwgYnV0IGl0IHNlZW1zIHRoYXQgd2l0aCB0aGlz
IHBhdGNoIHdlIGNhbiBraWxsIGcNCj4gb3IgdD8NCj4gQ2FuJ3QNCj4gDQo+IGRlZiB0YXNrX2xp
c3RzKCk6DQo+ICAgICB0YXNrX3B0cl90eXBlID0gdGFza190eXBlLmdldF90eXBlKCkucG9pbnRl
cigpDQo+ICAgICBpbml0X3Rhc2sgPSBnZGIucGFyc2VfYW5kX2V2YWwoImluaXRfdGFzayIpLmFk
ZHJlc3MNCj4gICAgIHQgPSBpbml0X3Rhc2sNCj4gDQo+ICAgICB3aGlsZSBUcnVlOg0KPiB0aHJl
YWRfaGVhZCA9IHRbJ3NpZ25hbCddWyd0aHJlYWRfaGVhZCddDQo+IGZvciB0aHJlYWQgaW4gbGlz
dHMubGlzdF9mb3JfZWFjaF9lbnRyeSh0aHJlYWRfaGVhZCwgdGFza19wdHJfdHlwZSwNCj4gJ3Ro
cmVhZF9ub2RlJyk6DQo+ICAgICB5aWVsZCB0aHJlYWQNCj4gDQo+IHQgPSB1dGlscy5jb250YWlu
ZXJfb2YodFsndGFza3MnXVsnbmV4dCddLA0KPiAgICAgICAgdGFza19wdHJfdHlwZSwgInRhc2tz
IikNCj4gaWYgdCA9PSBpbml0X3Rhc2s6DQo+ICAgICByZXR1cm4NCj4gDQo+IHdvcms/DQoNClll
cywgeW91IGFyZSByaWdodC4NCkkgd2lsbCBmaXggaXQgaW4gdjIuDQoNClRoYW5rcywNCkt1YW4t
WWluZyBMZWUNCj4gDQo+IE9sZWcuDQo+IA0K

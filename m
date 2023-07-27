Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E7D764402
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 04:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjG0Cxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 22:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjG0Cxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 22:53:41 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1071BC6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:53:32 -0700 (PDT)
X-UUID: c250599a2c2811eeb20a276fd37b9834-20230727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=m3wwXZoYfcOCNIYfxXK0yDABVDtoUlZqyyxvW4WmlCM=;
        b=Q24iPYk9rPnlXd43ZHTplq+7n14VefUyhrLDz/ELUlr0T2RFptzPgRKD8dmNbu6CmOkaEhlKayUI1kxvuihhDo11OFQOH0DaQj/0BxfYalC2s/tH7WFZ1iDlLBhTsE4riiPwSSlSHx5xiA6rfsriTxb/F5qF12XdjOhJjAivofA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:d849b77b-e166-4d72-ab44-6b1349b1dc71,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.29,REQID:d849b77b-e166-4d72-ab44-6b1349b1dc71,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:e7562a7,CLOUDID:e6825fd2-cd77-4e67-bbfd-aa4eaace762f,B
        ulkID:23072710532737Z6Q7OY,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48|38|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:ni
        l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD
X-UUID: c250599a2c2811eeb20a276fd37b9834-20230727
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 148461698; Thu, 27 Jul 2023 10:53:26 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 27 Jul 2023 10:53:25 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 27 Jul 2023 10:53:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEd5NKUhWVWextxLsT6SkbYKKlwi3/lVe8tQvicapYKXJw+tOoNN6rGvjWhcICeoTRDB9xXhWKJyUz8H8npQTA1zJdGW2beVskUpWIHTF06FzYcdABRlX697Hx0+I87BPDqrSO+8hnHiw2VsUlloiozzKOZ1k+G8SoM5QeDND0GNMWfCoMsUEW1ouVubdEw3s2D8mdUViCBAm8MbArcDWhwCvLfUEz59QbpAkDwOkfWKYM33HYe8tvVYgDSYW7Hgq+GWOa4oxoxrp19bnOUsr7sAzKQOnS9Jy1/MG85C69UZ+9+vVT8sEAp0F9g8wrZ8eQUu7uJOLvHyBXm/LuNDOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3wwXZoYfcOCNIYfxXK0yDABVDtoUlZqyyxvW4WmlCM=;
 b=mQyH8XIU40EyURUI+qrf/D/IkfIsLbs5q5KKi15XY/zNqbR2Yh5QFnm3aYxwlBJpHv8b3XEHm0J2htbE4FKk/LnVS0hTmaWmQQMtplzNY4nJVZjAshh/Cue2w7LrRi2JWHEJDHvfEVzShlZMVdQJSBB+S+GNomsd3wO1wvtTFrQNHL6TELFkIBNqNHFIeOMdY14cbjAXxdb/xV9TUlzEVnagYNEQoqcKy11PAxEHPNv1pbILNMHWT7HFKNpFcZdhxoqXHw/i0h9pQ13MmIEVNojge1SRByd2OQkiHXPm3SEYH5U3J3h2ZWHCNv1gWEjyz0U9eowEQRsts0iJ9wKSxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3wwXZoYfcOCNIYfxXK0yDABVDtoUlZqyyxvW4WmlCM=;
 b=kL1n7E616rz5eLgTkeUds2wGNA2yrB71/jsgBKxehv0h8XqVk5dzma1SDP0JEH2jN3LR/OPcTcV1YCYUYtoo2bkqNSv4WlUCeY6eS+Xzl1thKxXOjc+uU5sUdPnJ56JH0v5xN9glIJVEFvpLFVF8jvLSgnB84yrQolhyl6OWRrk=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB7881.apcprd03.prod.outlook.com (2603:1096:400:482::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 02:53:23 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 02:53:23 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "ehristev@collabora.com" <ehristev@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH v7 06/11] drm/mediatek: dp: Enable event interrupt only
 when bridge attached
Thread-Topic: [PATCH v7 06/11] drm/mediatek: dp: Enable event interrupt only
 when bridge attached
Thread-Index: AQHZvspJ81yCYSBINkSerIu5mLnEya/M7W4A
Date:   Thu, 27 Jul 2023 02:53:23 +0000
Message-ID: <72e40be84af796a36b51deecca2bd142f1f5cfd4.camel@mediatek.com>
References: <20230725073234.55892-1-angelogioacchino.delregno@collabora.com>
         <20230725073234.55892-7-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230725073234.55892-7-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB7881:EE_
x-ms-office365-filtering-correlation-id: 155685e0-427f-4d78-32c7-08db8e4ca4a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6uWUq4KytYDEWAFtifvo7ETJcj42QZhSUSBg6PsRUl/2kmlNHfP2KzOvAdf3rBqntdgo2LRvGcNt7SdZakSn+Tvx/8qM1kIE8r49EDKIw6DABHfSSs2VHH4PD6RLg1sJNsajstolBTiQKWDZOdgk1Bhd/spiRazPKylBud7Y1Hl92s9OCgl9GimCbe/nmDJExSgGzxVdSsrCH6LZmNbtlogNzv1dWzG3/yMQfwsrrHgfWqLnG5x4WwZY343E5imDengUjwa+1Xdw+nuF9FCCh076hSlJsJoEZzJ9dikYodsxF+mN169I/WbEOsKr/C/uB7F37mTvusmncOFCKgWFUtMjRWqmKAk61IkfD2zorZYK46QKyq0zAZxgvuKXkpl+Gq/WCOyyjqQCgR4ZwMT5vc3iBWMaWNLYaR4LRhuW1MZc5sQ2OB3wom80H6LQDXRu6Lo0Hr1ulU5WsqiPB0JuvNdDiKSAAUc0TRbGLOqdOOJrE6QumyoX3+S7dV5TQWv2u+zMy6aB0emWqs8wTG6+BMVuIyyjYyXKBY3GgcX8nS4W3NwYuDuqvGZJ9e5LRXxFFidPQqqFEDchVPijnY6rFTlziCPs0OKM/XZotVuIB/NG6fB4EDrsyHXH/YidvhWjF4aH6R2khjP7sYSMfLIaPqEFf95ec9yCmikdnzay4N4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(5660300002)(7416002)(4326008)(66476007)(2906002)(66946007)(76116006)(66556008)(66446008)(64756008)(316002)(54906003)(8676002)(8936002)(41300700001)(478600001)(110136005)(71200400001)(6486002)(6512007)(38100700002)(6506007)(26005)(186003)(2616005)(36756003)(85182001)(83380400001)(38070700005)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTEyUDQyUzQydWpFOTlZdVNZSEtKSHJLUDRVSy9iYzBjZnQvOXdXZEg5cWNX?=
 =?utf-8?B?eVozYXhlREk5VEtkanVOSkU1bFNlYisvUFBrQ01JTm1FaXpEamlKV2JDdWN1?=
 =?utf-8?B?RkhwQkJNK0VnNlZtbXBFZ0RCUEVlVll4aTZ2cDkrMklJa2pla21zaTAzTEpU?=
 =?utf-8?B?WUUvTUZDTXh4SktIcEFLWDVQT0NQMmRONFJETEZHYkFTTThwV3F2WmJSQ2Jt?=
 =?utf-8?B?VmJSY215ekNhcDFZRklDNXVrQzVua1lTWUZCeTFTNmNBV0kzNnVPb1gvd3Uv?=
 =?utf-8?B?T241ZWdZa280OXA1Wk5WYVdhUy9xQWVYWlJIOWVsQkRNeTAzZUVHdno1Nldq?=
 =?utf-8?B?YXk1WExIeklDQVovRENra1htMy9yTmRvUE93QXVpa3RDM3VXa2hBcVdkMDUy?=
 =?utf-8?B?RnlDY29ZZ2txbHBPbFpWbXdycktmTjd2dmttVGNZdGJHN05Yb0ptNTEwUW1R?=
 =?utf-8?B?V2piZEtzbkxYM3E5cStxTWFQVEhWVDAwcmNyanlXNmFNNEdHYzRxRDVHT2hC?=
 =?utf-8?B?aG5JakxsU1dvRWhaRlEvem83U0N6TjlZcDVaY0FSYm1SSysvK0R5eWZMU245?=
 =?utf-8?B?SFlSWXhIRlVLOHJHSHlYTjR3YlNqVHMwbnJrR0VJK0Z0dm13T0dDRFE2bDJ4?=
 =?utf-8?B?bjdQbHp2U0IvOHA2UWNrUnhFNG1aQ3pXQmZzdmZIYXBMSzFWdFprN0QyU1dr?=
 =?utf-8?B?NjdoQ2x3djd2SkN6cXlqTGsyTFZNWFZMNGdXYWY3UXVwaTBmWm5vazhmU0Rl?=
 =?utf-8?B?MU5uTlpYVXN1ZnY5elEzWlI1d3RpYzI0MzFjVHBGZlRzUGpEWlpOdHRTVklC?=
 =?utf-8?B?czhkaDUyNzFHYWRoYTR3cG92a2JHM1lnUnF4QTVrd1RRemF4MEJUeHRYUDNC?=
 =?utf-8?B?eUdpYmQxMEtFZXlsVk8xdmpRZFBBb0hHK2JqM1k4TkNKbU1aVDlqQXdpaWlG?=
 =?utf-8?B?YXVLcUVkUkdUQ24yQllMQUczdVIzdkxJbHlpTXNZVzlJR2pFL09pajBYUmNV?=
 =?utf-8?B?Z1ljczR0Sy80QWxoRTBwZnI3QWVSY2J1QjhlczJXN1RQQ3pXditaa1U4TmZz?=
 =?utf-8?B?d2o4YzJaMjdPQ2t4VUE0OW1zaTYzeFlTWkEvM1RRVUhSUGFidThEQUo5ZUN6?=
 =?utf-8?B?U00yRkowenJ6dkNVZktndytkYjl6a1pCeExZdm9WcHVGWmo4ekM5dkx6MTFh?=
 =?utf-8?B?SWNsR01ISTJteVUybjR4cE95SG5FU2VPUFRYNXJuaVBtWHdCMmd0REtSMG0r?=
 =?utf-8?B?cXdxb1lYTm04UzN2bTZpWFp6ek9BcE9hUVg2djFleWg2dWZ4eUJ3NXpvV05F?=
 =?utf-8?B?YXNLTzcwOE5oc25JTytDQWJjelNOVzl3TXhZZ3ZwQkpQZ0pMMEU4aDE2b0RT?=
 =?utf-8?B?SGFYQ1hNcjhvN2FSNEhzYzVnN1pic2dncGRiNkt2RVlqV3lDZjJiMHBRSFZp?=
 =?utf-8?B?dThNYTFPRTNWU2ViK1VxaXVkWXdSWnZCYXRPUGtnZmVnWkdCSGVUZlo4Z1F4?=
 =?utf-8?B?M1JNV1hmSzErcmYrNWFuanZUZFQyd0xway9sRHlHaGVPRFZ1Ri9XVUV1NTVj?=
 =?utf-8?B?Z2JJZGIyU1NDNmcyMm5mdC9mekRzdHU0QXZ3UGRSaEdlM1dQZkRHNmNIVWlm?=
 =?utf-8?B?Y2xBdjNoaVhKMzdkR3Zlc1R0S0NnQnEzQ00vdUNKMlNEdWhJbzF6V0Fkc0hR?=
 =?utf-8?B?ZFk5ZlQzV2plV0RLcjZJQjRzY3ZkckM3bDdkbERlbm1yK25ZYmNjUnJ5VmtZ?=
 =?utf-8?B?eTRLRkE1bGh2d0k0ODYyVXVFNW04YjNqTk54NDhTc29tQ2FFQWxTSUZUa1BP?=
 =?utf-8?B?NmNTODRpVWkvTVRLNVNuSHhKR2didmhjWGRoTW93NnNrYU5jMkIvOGVvaFR4?=
 =?utf-8?B?Q0dDNWpVVk1pOERJcVVnQ2YxRXRVWUJ0ZlZ6WlJhRjRtd0JMcVVPcGxVWFpS?=
 =?utf-8?B?c2FTTndYbC9rK1JzMHJiZlZyUkFMUy9TNU5GczJDODkzSHZpMXFNQ3VzSUtD?=
 =?utf-8?B?WEsrODAvdkJnaERJWHNEcmhBYlE5MjA1aEVQa3pFWi8rT0MvL20vR2pBd0F0?=
 =?utf-8?B?Z2x1Sm9XaGROdEsvVFhCcmtNeUp4NFFrY2toaDJwRFMwZk12Zlk2YnZmRFFX?=
 =?utf-8?B?TEJ1N0FENXE4RlJsWlViL2ZpTHNReUpGT3FUQWppVW5wUlorTHpWY3pCUUNY?=
 =?utf-8?B?cVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55353DD892D9BB489E855E37A45C061C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 155685e0-427f-4d78-32c7-08db8e4ca4a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 02:53:23.4056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tdA+P8ncb+7QNMgYWNKZBK+5KDkkOEHoYvNfvxPzfABZPS3Bqt5LyaxUjyUuQx1uybJ3zFrxwBNYFr/NAErE0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7881
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gVHVlLCAyMDIzLTA3LTI1IGF0IDA5OjMyICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gSXQgaXMgdXNlbGVzcyBhbmQgZXJyb3ItcHJv
bmUgdG8gZW5hYmxlIHRoZSBEaXNwbGF5UG9ydCBldmVudA0KPiBpbnRlcnJ1cHQNCj4gYmVmb3Jl
IGZpbmlzaGluZyB0byBwcm9iZSBhbmQgaW5zdGFsbCB0aGUgZHJpdmVyLCBhcyB0aGUgRFAgdHJh
aW5pbmcNCj4gY2Fubm90IGhhcHBlbiBiZWZvcmUgdGhlIGVudGlyZSBwaXBlbGluZSBpcyBjb3Jy
ZWN0bHkgc2V0IHVwLCBhcyB0aGUNCj4gaW50ZXJydXB0IGhhbmRsZXIgYWxzbyByZXF1aXJlcyB0
aGUgZnVsbCBoYXJkd2FyZSB0byBiZSBpbml0aWFsaXplZA0KPiBieQ0KPiBtdGtfZHBfYnJpZGdl
X2F0dGFjaCgpLg0KPiANCj4gQW55d2F5LCBkZXBlbmRpbmcgaW4gd2hpY2ggc3RhdGUgdGhlIGNv
bnRyb2xsZXIgaXMgbGVmdCBmcm9tIHRoZQ0KPiBib290bG9hZGVyLCB0aGlzIG1heSBjYXVzZSBh
biBpbnRlcnJ1cHQgc3Rvcm0gYW5kIGNvbnNlcXVlbnRseSBoYW5nDQo+IHRoZSBrZXJuZWwgZHVy
aW5nIGJvb3QsIHNvLCBhdm9pZCBlbmFibGluZyB0aGUgaW50ZXJydXB0IHVudGlsIHdlDQo+IHJl
YWNoIGEgY2xlYW4gc3RhdGUgYnkgYWRkaW5nIHRoZSBJUlFfTk9BVVRPRU4gZmxhZyBiZWZvcmUg
cmVxdWVzdGluZw0KPiBpdCBhdCBwcm9iZSB0aW1lIGFuZCBtYW5hZ2UgdGhlIGVuYWJsZW1lbnQg
b2YgdGhlIElTUiBpbiB0aGUNCj4gLmF0dGFjaCgpDQo+IGFuZCAuZGV0YWNoKCkgaGFuZGxlcnMg
Zm9yIHRoZSBEUCBicmlkZ2UuDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsu
Y29tPg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8
DQo+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gVGVzdGVkLWJ5
OiBDaGVuLVl1IFRzYWkgPHdlbnN0QGNocm9taXVtLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IEFsZXhh
bmRyZSBNZXJnbmF0IDxhbWVyZ25hdEBiYXlsaWJyZS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcC5jIHwgMTUgKysrKysrKysrKy0tLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gaW5kZXggZThkM2JmMzEwNjA4Li44M2U1NWY4ZGM4NGEg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gQEAgLTEwMCw2ICsxMDAsNyBA
QCBzdHJ1Y3QgbXRrX2RwX2VmdXNlX2ZtdCB7DQo+ICBzdHJ1Y3QgbXRrX2RwIHsNCj4gIAlib29s
IGVuYWJsZWQ7DQo+ICAJYm9vbCBuZWVkX2RlYm91bmNlOw0KPiArCWludCBpcnE7DQo+ICAJdTgg
bWF4X2xhbmVzOw0KPiAgCXU4IG1heF9saW5rcmF0ZTsNCj4gIAl1OCByeF9jYXBbRFBfUkVDRUlW
RVJfQ0FQX1NJWkVdOw0KPiBAQCAtMjE0MSw2ICsyMTQyLDggQEAgc3RhdGljIGludCBtdGtfZHBf
YnJpZGdlX2F0dGFjaChzdHJ1Y3QNCj4gZHJtX2JyaWRnZSAqYnJpZGdlLA0KPiAgDQo+ICAJbXRr
X2RwLT5kcm1fZGV2ID0gYnJpZGdlLT5kZXY7DQo+ICANCj4gKwlpcnFfY2xlYXJfc3RhdHVzX2Zs
YWdzKG10a19kcC0+aXJxLCBJUlFfTk9BVVRPRU4pOw0KPiArCWVuYWJsZV9pcnEobXRrX2RwLT5p
cnEpOw0KPiAgCW10a19kcF9od2lycV9lbmFibGUobXRrX2RwLCB0cnVlKTsNCj4gIA0KPiAgCXJl
dHVybiAwOw0KPiBAQCAtMjE1Nyw2ICsyMTYwLDcgQEAgc3RhdGljIHZvaWQgbXRrX2RwX2JyaWRn
ZV9kZXRhY2goc3RydWN0DQo+IGRybV9icmlkZ2UgKmJyaWRnZSkNCj4gIAlzdHJ1Y3QgbXRrX2Rw
ICptdGtfZHAgPSBtdGtfZHBfZnJvbV9icmlkZ2UoYnJpZGdlKTsNCj4gIA0KPiAgCW10a19kcF9o
d2lycV9lbmFibGUobXRrX2RwLCBmYWxzZSk7DQo+ICsJZGlzYWJsZV9pcnEobXRrX2RwLT5pcnEp
Ow0KPiAgCW10a19kcC0+ZHJtX2RldiA9IE5VTEw7DQo+ICAJbXRrX2RwX3Bvd2Vyb2ZmKG10a19k
cCk7DQo+ICAJZHJtX2RwX2F1eF91bnJlZ2lzdGVyKCZtdGtfZHAtPmF1eCk7DQo+IEBAIC0yNDc1
LDcgKzI0NzksNyBAQCBzdGF0aWMgaW50IG10a19kcF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlDQo+ICpwZGV2KQ0KPiAgew0KPiAgCXN0cnVjdCBtdGtfZHAgKm10a19kcDsNCj4gIAlzdHJ1
Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiAtCWludCByZXQsIGlycV9udW07DQo+ICsJ
aW50IHJldDsNCj4gIA0KPiAgCW10a19kcCA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqbXRr
X2RwKSwgR0ZQX0tFUk5FTCk7DQo+ICAJaWYgKCFtdGtfZHApDQo+IEBAIC0yNDg0LDkgKzI0ODgs
OSBAQCBzdGF0aWMgaW50IG10a19kcF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpw
ZGV2KQ0KPiAgCW10a19kcC0+ZGV2ID0gZGV2Ow0KPiAgCW10a19kcC0+ZGF0YSA9IChzdHJ1Y3Qg
bXRrX2RwX2RhdGENCj4gKilvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2KTsNCj4gIA0KPiAt
CWlycV9udW0gPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDApOw0KPiAtCWlmIChpcnFfbnVtIDwg
MCkNCj4gLQkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBpcnFfbnVtLA0KPiArCW10a19kcC0+
aXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAwKTsNCj4gKwlpZiAobXRrX2RwLT5pcnEgPCAw
KQ0KPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIG10a19kcC0+aXJxLA0KPiAgCQkJCSAg
ICAgImZhaWxlZCB0byByZXF1ZXN0IGRwIGlycQ0KPiByZXNvdXJjZVxuIik7DQo+ICANCj4gIAlt
dGtfZHAtPm5leHRfYnJpZGdlID0gZGV2bV9kcm1fb2ZfZ2V0X2JyaWRnZShkZXYsIGRldi0+b2Zf
bm9kZSwgDQo+IDEsIDApOw0KPiBAQCAtMjUwNyw3ICsyNTExLDggQEAgc3RhdGljIGludCBtdGtf
ZHBfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gIA0KPiAgCXNwaW5f
bG9ja19pbml0KCZtdGtfZHAtPmlycV90aHJlYWRfbG9jayk7DQo+ICANCj4gLQlyZXQgPSBkZXZt
X3JlcXVlc3RfdGhyZWFkZWRfaXJxKGRldiwgaXJxX251bSwgbXRrX2RwX2hwZF9ldmVudCwNCj4g
KwlpcnFfc2V0X3N0YXR1c19mbGFncyhtdGtfZHAtPmlycSwgSVJRX05PQVVUT0VOKTsNCj4gKwly
ZXQgPSBkZXZtX3JlcXVlc3RfdGhyZWFkZWRfaXJxKGRldiwgbXRrX2RwLT5pcnEsDQo+IG10a19k
cF9ocGRfZXZlbnQsDQo+ICAJCQkJCW10a19kcF9ocGRfZXZlbnRfdGhyZWFkLA0KPiAgCQkJCQlJ
UlFfVFlQRV9MRVZFTF9ISUdILA0KPiBkZXZfbmFtZShkZXYpLA0KPiAgCQkJCQltdGtfZHApOw0K

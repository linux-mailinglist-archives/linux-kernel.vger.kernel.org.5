Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E8F7A452F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbjIRIxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235893AbjIRIxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:53:11 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54098C5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 01:53:05 -0700 (PDT)
X-UUID: c5e10dbe560011eea33bb35ae8d461a2-20230918
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=e3cXOdM2/Ba/W/opiBat0CAlHXRnc0ZIR5mxjAuwScc=;
        b=AV1FAm4BnBf9O03jS90AVQFte1Yv8AC6o41I/SYLtgAJ6hg1koVQ/D6ohEl6LwePmr0W6fYo27WJrgM5j8JyaOAZnhAaEzWBOh7b8fYYJajC2ZD+wH6GV1Z5igJOPOVeXO1zOcGmGt4VADn43g5r6PUDMqCwPqLCt9wVyLbThwU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:425c94bf-cd4b-410a-a683-aab80a4067f1,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:b411d3ef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c5e10dbe560011eea33bb35ae8d461a2-20230918
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1578666746; Mon, 18 Sep 2023 16:53:01 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Sep 2023 16:53:00 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Sep 2023 16:53:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2dZ48Jo39eqTMzdTyoLNHhd5VnERYgwq2nK42e5cOBJrZM+Qvj/PEwtOEV6HgK5S/3hI+/a7ac094EKDrrcVbCKf3WNVUd+7nWaeBwE4vCo8hgI8Dk7BhyCmYExyxxA5MiG2maLc8uT5qNZVrGdtxuDdEIZz3IT9hM0Lrl6bfAN8pENU6vKO/ChmVzhLC8LdBa2gAk2tOlqEzBIXoavsFmDw1x090O/pRYR9e/SZ1TWP5uPfQG9ya2Xjy7Lyk/mBFwuMRbmdr/BuIIpQ6dRnd5BA1CesVZ1yZMupztJaPAxUplqtSw7KPKyBeItL6YGIyF9sPepZpbwEJUZt3wd/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3cXOdM2/Ba/W/opiBat0CAlHXRnc0ZIR5mxjAuwScc=;
 b=EKW1qegcfPg6hZ+1LA49xTFhi/OxzJcEZ+zwjxhLVoh3IgX/c3w+7I/aDSuI8K22qfL9rFB//ayGrx1j+puHkkJUM00fj0B0xT3prmoVez7P/oaRhvr+adTaaT+mqjmmo08Ut99Y3fNdP2mY+tSSM251orN+EOOTRMxH1L+JVpzYKg06e9TBxp365PDSbdkDx+Veb4vKlGL5m+DAcpXVrx+drkkIdBHh3POY6LXtF94Xm+cpi5vc4bglX+f4DMI5cymO9w9i7SoQqhG+f2cy7+VpKMCcQI2HpqWy+c2bBSwgTlamwJRI8RJyWzoqRJNAAsOrxEXL+vFVjK/7PGwIXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3cXOdM2/Ba/W/opiBat0CAlHXRnc0ZIR5mxjAuwScc=;
 b=qETL9Rw9XEnWIzX3RxzHzpk0cSwM6eNh8ipa793ksU0x91O/sO9kWrWT+95qPpKRJ2IcGBCNd+By/JRrUCGlwsBnp/T9kidmRV8fiWLFQuPLxTMdHVNkIQ01Vm8RkhWPp/4n0lj6z2HAsxL/qi3PHKnTGektaD1QavMG7FcDygo=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB7793.apcprd03.prod.outlook.com (2603:1096:101:16a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 08:51:27 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%6]) with mapi id 15.20.6792.022; Mon, 18 Sep 2023
 08:51:27 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 02/11] soc: mediatek: Support GCE jump to absolute
Thread-Topic: [PATCH v2 02/11] soc: mediatek: Support GCE jump to absolute
Thread-Index: AQHZ6gwiisdoITke2EGSqJsfiabWzbAgRoUA
Date:   Mon, 18 Sep 2023 08:51:27 +0000
Message-ID: <c618e1af098554e4befec787b3bbc073081577e7.camel@mediatek.com>
References: <20230918084207.23604-1-shawn.sung@mediatek.com>
         <20230918084207.23604-3-shawn.sung@mediatek.com>
In-Reply-To: <20230918084207.23604-3-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB7793:EE_
x-ms-office365-filtering-correlation-id: 7c70ce12-d7ee-413e-36dc-08dbb82471c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pScqHi3dSZEak6w8+4NUslYRaDNt6Zko/aoYnxHdTdaKQcSBTebmLov1V4IdDwqGA8sPkb6xatcJqzLseXB6v0OkuopmELkvUY5WH8tUYO3caGBto3cqeelnqPRgJHFYImYukFu0BMs/AFMeJ6j0Mtv4Hi7vLpknTlc54dYCxdQnK92Vdys6zRcqYXMuYHa5LxlNb5kIvbPr5/T8kl/9xkQGOzfUnttMA1uMiPDVeOnbpBrx4GlNU3WkeW7Up1ZeAXzTnvoTOrwsXVCrnp+kT8fqpvNAV0GBFo8urFcuBsxMnTndWQFqMt1jka4hudMUdD6qWgTGEWvl3izNlA/DO+PoVW5Ya/ljvoOOGy2ykC0nPEMdyPWrxHQhvAn0DPf/8UnM/n6N0ATYFGsW4T9fe0h/7qvTJ9Qg8I99uMdY2g2BBhlBo5YY8sHgFAiak0nXuFeI1mko6ZfEtGhTHP1uPzspWjrXMjlAqkEW9xoS0XOWEpX8QSjVqpv60xoUFmcIWadaxFO6UAanzdlYuM9cn0J9GZYL5a4J7trzeNteOXf40nbMDpgwLKp68ZYB/3r+0V9lMN+blUe794UCB3ps0HLwsHXPXuFi90yJqHAq80xpU3QwXcWb7mWNYXyreaKdhPK3MJFMfdOixqJ4p+oN3Fv0G0IsLs1YiaRTEfrCTVo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199024)(186009)(1800799009)(122000001)(85182001)(36756003)(38070700005)(38100700002)(86362001)(6506007)(478600001)(2906002)(66946007)(5660300002)(64756008)(54906003)(66476007)(66446008)(76116006)(8676002)(4326008)(66556008)(6486002)(6512007)(83380400001)(71200400001)(41300700001)(7416002)(110136005)(316002)(8936002)(26005)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDN5T0prOW52MkdxcktUTXM0cXdnWHBYZ2l6T3BnNEpFTmNqRGpMTVVqdFNV?=
 =?utf-8?B?Zi80YnJ1c2Z5WHFqOGNoWUxZSzVrRk95dmltVmF6VVFRMW8rZTU0Uy9iSHdi?=
 =?utf-8?B?WENuZkVsbnFYaENBNjNwTndFU2I1TzM5OGNlaFNXdy9DT1dGcXVpRXFVQk5N?=
 =?utf-8?B?ZWdXNCs2WmczeUdOazFqNW5sdWM3Mm1QTkxMVExGc1lnNGxnMUd5TC82d2R2?=
 =?utf-8?B?VmV5TUlrMkw1Y2Y0RXQ1V0tFMTZpWTRwNnlYTy9VbTBPNzF4MDMzSEVWVnZz?=
 =?utf-8?B?NjBmSktwNzljVjVMajBuRjJUVEtUSEZOOXRLT2Q0QnV0c3JhUFdkUmM2d2pP?=
 =?utf-8?B?Vi8wbFMyZnNZOWNoWGNLNTVKMG1hS1ZBdGpzR3lySjVoMkhlMzNSK0NsV0hD?=
 =?utf-8?B?K254RWpuNW9QRGsyMkRiVjFxdHNseWRhUFdtb3pndlV6ckw0SUVzSGtKaUJH?=
 =?utf-8?B?NXBkMWJqRENVcUlGS0t5bDc4WWtvTTNwM0Fxcm9RL1ZJRHozbDJqZmpVK3dz?=
 =?utf-8?B?SlJ5WWdYTmRQc0NMVmlneTNmRTZwbmt3T3FnUUREblBHSDNyYnlRN0tNT3gx?=
 =?utf-8?B?Y0twT3ZaQkMzQ0hZUUFGM1JQYUhnbWJCSCt4Sko1UHlvc0xqTnB3K2poajQx?=
 =?utf-8?B?eUJKVE1nZlJwMlY5MUljODN2M0ZPSlZjelQxWmMzTldzTCtjamJmQ25oZ1RE?=
 =?utf-8?B?QklzY1orZU5Sa0xEVVl4YjkvVzczclRKYVprenhYa1pwQnVwLzlHT3dzUzdY?=
 =?utf-8?B?UHZ6b2FOeGc4SFI4NUkvY0ZMSE5PellVbWNncmtUdktNMEk3QmdsWGRXWk9a?=
 =?utf-8?B?QXo2U0F4TEt2Wm9iTXhBbG9rdUxhQ3RIK1VheEd0WkZhN29tQWlPb0lQYjBp?=
 =?utf-8?B?MHl5RkYyVVRTSjZUaTNXZXdZUmpFRWR1THp5aWd6a1pGQ0RIUzhhdFh5KzJa?=
 =?utf-8?B?a29rTmFUOGRKQVQzOGduMFVPTU5Gdm94bEhSQTdzdUlSQnF3YnFWQUdxSnZ1?=
 =?utf-8?B?ZDFkK3A5UTdLZXNlZFQrNDAvOUc0UVoyV3p1cHRQVCtuMVk3TGpMQWNRUW1j?=
 =?utf-8?B?Tnd6TkJxZHh4MDdLZFZFdDJMcXVxNFArSVhaTi9CbGRrRVloS25CSVc3Mzdv?=
 =?utf-8?B?QzJJSXoxb01TbUIwRjUvbEZnSTljV2tKU0FnWUNSdXYyOUw3cytiZXB5eUVU?=
 =?utf-8?B?L1Y0MmJZRm9UQnBHSFdTR3kxWStCdnZBRDYvd2xKRzFSbUNwU0dUSitJMk1z?=
 =?utf-8?B?cTV0a3VGTUg5Wnc2SVRJVGJhZHpuZ3dwOFBpVm9nK2ZEVy8zZFc2cXhVMno3?=
 =?utf-8?B?eFZZOTVaQXRrbnNGTm1ncGpBZy9DdS9BT2hkUDVYMTdVbEVXckdUejczQ2Rr?=
 =?utf-8?B?dlUwMGZ2WmVSSmpWL1lnWnVMc0R3YVcwQjFTODJGdVVwWGJpZmFYcWFpdFJu?=
 =?utf-8?B?VkJnWk43TTdrUENxMnovWnZSZnVxM3UrdXZLZ09yblBtNTdYaG5ORjVTQkZC?=
 =?utf-8?B?WFB3MzA4Y1NrbStRVi9pQ3lmZXNOY1NFYUxVRGg0UG9xaUlLVHhsTUtuMVhS?=
 =?utf-8?B?bVcwQnBGeTFQSkp3Yk1hd2l0MnE2bSs0eDVCR1FwVUdWa0RqeWd5d1d0STRj?=
 =?utf-8?B?TVJmVEw0bnFjTllaUFJ2dFpYbEl1S1JXVkd5WEl6c3ozL0FoT1kvR01TVnhC?=
 =?utf-8?B?ODluSm5JK3F1c0N6OXd2dVp4S0ZOY2cyMXR2NDVvQkVMZzR6Tm43Wk54bHZ1?=
 =?utf-8?B?OVIrZ0haQitzdVVtNzNEN1dJY3UvQjF5MFZJVjdpSFo1ZkEwT0JObVpZdTBO?=
 =?utf-8?B?cE9INGl6K2YvNHRmQndEQ0tPOXBKL1owZ09sbERrcFpORzBUWTh1ZHliQnBC?=
 =?utf-8?B?S0FSbk5uSXlZZ0RuRkIySGpUZ3VpK2M0eGJJUllMOGhHYkJVWU45V2V3M2pw?=
 =?utf-8?B?NlRRei9NOHdYUjZwUDlnRHFqbVl6QUE3YXE4dTN4OG9ib1NmRG9RVTh4RGRX?=
 =?utf-8?B?dk9MQXRrMlFzYVlLVWpHMWE2aW9GZTd5ZXlGVlRlWndQTjZZRXBCTysrWERF?=
 =?utf-8?B?ZHdoNnViUHV2ZXlSWWptS1lLcTc4NFJqUTl1YWRzL2ltbzYyVkV6VjBzUHJj?=
 =?utf-8?Q?pdL75TCDmjKqc7hfCPW5R/G9v?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1B2E9DA8424D942867CE17A8258B4EC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c70ce12-d7ee-413e-36dc-08dbb82471c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 08:51:27.0211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sDO8Q0mJWh71kHbUT41uB8Bq5vr6D+mWk/pf5XFFoggOU67awudHWluV8uKKw99sMXdmPXHPShuhFUj+5xQW4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7793
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBNb24sIDIwMjMtMDktMTggYXQgMTY6NDEgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IEFkZCBhIG5ldyBBUEkgdG8ganVtcCB0byB0aGUgaGVh
ZCBvZiBjbWRxIHBhY2tldCBieQ0KPiBhcHBlbmRpbmcgYSBqdW1wIGNvbW1hbmQgYXQgdGhlIGVu
ZCBvZiBpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1
bmdAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRx
LWhlbHBlci5jIHwgMTYgKysrKysrKysrKysrKysrKw0KPiAgaW5jbHVkZS9saW51eC9zb2MvbWVk
aWF0ZWsvbXRrLWNtZHEuaCAgfCAgMiArKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEt
aGVscGVyLmMNCj4gYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiBp
bmRleCBiMGNkMDcxYzQ3MTkuLmUwMjljZTIzMWRmMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gQEAgLTQ0MSw0ICs0NDEsMjAgQEAgaW50IGNtZHFfcGt0
X2ZsdXNoX2FzeW5jKHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0KPiAgfQ0KPiAgRVhQT1JUX1NZTUJP
TChjbWRxX3BrdF9mbHVzaF9hc3luYyk7DQo+ICANCj4gK2ludCBjbWRxX3BrdF9qdW1wX2Fic29s
dXRlKHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0KDQpDTURRIHByb3ZpZGUgYWJpbGl0eSB0byBqdW1w
IHRvIGFueSBwaHlzaWNhbCBhZGRyZXNzLCBidXQgdGhpcw0KaW50ZXJmYWNlIGxpbWl0IHRoZSBq
dW1wIHRvIGhlYWQgb2YgcGFja2V0LiBTbyBJIHdvdWxkIGxpa2UgdGhlDQppbnRlcmZhY2UgdG8g
YmUNCg0KaW50IGNtZHFfcGt0X2p1bXBfYWJzb2x1dGUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIGRt
YV9hZGRyX3QgcGEpOw0KDQpGb3IgY2xpZW50IGRyaXZlciwgaXQgY291bGQganVtcCB0byBhbnl3
aGVyZSBpdCB3YW50Lg0KDQpSZWdhcmRzLA0KQ0sNCg0KDQo+ICt7DQo+ICsJc3RydWN0IGNtZHFf
aW5zdHJ1Y3Rpb24gaW5zdCA9IHsgMCB9Ow0KPiArCXU4IHNoaWZ0X3BhOw0KPiArDQo+ICsJc2hp
ZnRfcGEgPSBjbWRxX2dldF9zaGlmdF9wYSgoKHN0cnVjdCBjbWRxX2NsaWVudCAqKXBrdC0+Y2wp
LQ0KPiA+Y2hhbik7DQo+ICsNCj4gKwkvKiBqdW1wIHRvIGhlYWQgb2YgdGhlIHBhY2tldCAqLw0K
PiArCWluc3Qub3AgPSBDTURRX0NPREVfSlVNUDsNCj4gKwlpbnN0Lm9mZnNldCA9IENNRFFfSlVN
UF9SRUxBVElWRTsNCj4gKwlpbnN0LnZhbHVlID0gcGt0LT5wYV9iYXNlID4+IHNoaWZ0X3BhOw0K
PiArDQo+ICsJcmV0dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQo+ICt9
DQo+ICtFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X2p1bXBfYWJzb2x1dGUpOw0KPiArDQo+ICBNT0RV
TEVfTElDRU5TRSgiR1BMIHYyIik7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9t
ZWRpYXRlay9tdGstY21kcS5oDQo+IGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNt
ZHEuaA0KPiBpbmRleCBhMjUzYzAwMWM4NjEuLjEwNjk4OGNjNWYwMSAxMDA2NDQNCj4gLS0tIGEv
aW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiArKysgYi9pbmNsdWRlL2xp
bnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+IEBAIC0yNzYsNiArMjc2LDggQEAgaW50IGNt
ZHFfcGt0X2p1bXAoc3RydWN0IGNtZHFfcGt0ICpwa3QsDQo+IGRtYV9hZGRyX3QgYWRkcik7DQo+
ICAgKi8NCj4gIGludCBjbWRxX3BrdF9maW5hbGl6ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCk7DQo+
ICANCj4gK2ludCBjbWRxX3BrdF9qdW1wX2Fic29sdXRlKHN0cnVjdCBjbWRxX3BrdCAqcGt0KTsN
Cj4gKw0KPiAgLyoqDQo+ICAgKiBjbWRxX3BrdF9mbHVzaF9hc3luYygpIC0gdHJpZ2dlciBDTURR
IHRvIGFzeW5jaHJvbm91c2x5IGV4ZWN1dGUNCj4gdGhlIENNRFENCj4gICAqICAgICAgICAgICAg
ICAgICAgICAgICAgICBwYWNrZXQgYW5kIGNhbGwgYmFjayBhdCB0aGUgZW5kIG9mIGRvbmUNCj4g
cGFja2V0DQo=

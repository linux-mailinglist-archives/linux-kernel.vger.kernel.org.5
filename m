Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F6E75EE20
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjGXIpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjGXIpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:45:01 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC3D10F7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:44:36 -0700 (PDT)
X-UUID: 3d5a956a29fe11eeb20a276fd37b9834-20230724
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=BYzMH7PGaaknlrzDdbdYvw3fnoE05nTK9Nk5wXMWKqg=;
        b=Q8x49m7Uw+ppMAmqRSinHRBvk4ou3E2E8WoO5v3KSQoyGnHeAKVP6+B/F0YPGfc+1mUmhJhh5bDnk+xwfO1IgKwC0WxltIm6+nudi3Q4MbzTJLUjax8V0lrgpwNv63t01vdXzBsBLgi08za5d3aTP4upsHzzo38Ak/0l4+uQeL0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:857d81db-b03f-4c3a-a7ce-586d1b41c4ea,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.29,REQID:857d81db-b03f-4c3a-a7ce-586d1b41c4ea,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:e7562a7,CLOUDID:0651f887-44fb-401c-8de7-6a5572f1f5d5,B
        ulkID:230724104134JUTCJ669,BulkQuantity:12,Recheck:0,SF:38|29|28|17|19|48|
        102,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:41,QS:nil,BEC:ni
        l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
        TF_CID_SPAM_OBB,TF_CID_SPAM_ULN
X-UUID: 3d5a956a29fe11eeb20a276fd37b9834-20230724
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1852193705; Mon, 24 Jul 2023 16:44:02 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 24 Jul 2023 16:44:01 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 24 Jul 2023 16:44:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwFWn5QzH7kTLbb7vi7NC44P0D4tXx94Iq4d2OhDMSZ9Gr7XIoK8jXSYtaTV4gZotuPiN7yfKwrK0FFgK/B5V15d/vveQT6i9YHRv3iHWt57OcwCynNhrIWJ6Mbc5f09EhUdEXwO2iBlPUfPWAnnSwq2cJqerUPYcftAzs6oxE79mNQG/O87GYgI9UZubFsDJzkExnsXAHhwZX4/Uc60WpGrV9JPaERgQwTZaMRLPP0aU/V722FEs2U5qo++zhKQZZLdyTWryy0VbvoYeQ1ho3P4/IeW6Zvp9sVbH2YlT7B7f+svY6RFuE2VIC61PwlOkW2H3CP01+SKQgqkOvSxng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYzMH7PGaaknlrzDdbdYvw3fnoE05nTK9Nk5wXMWKqg=;
 b=FhiB8d507EmXjhv17KGyyAVilRaoypy/x33ekMNcL7lvQAcB8L+l/wh5EXAdkKpaYOh7IdDF0iv1pAgwcB+rUfKnsDfVM6TTbU2THkcvJPfR3v7Cufa+PUs8F+wBSwHi6XQ3OO9GpLQAboYDzcOOKPLslA7JR8EJe+E/xL6sZzah6HLDfdBAsw1uDEn9Yix1Jpd9VtFDuj3LxXu6/nQrJHteWlAcrjflZKlVDuR3iOjmvWcZK1ZPnyZAaUQqjq4bBzIjqcmfCpyrN3JxpzcD/jg/TBCMW/Aydm9rUGPa+ujWpC+hUH/7Vp1ekx+3PJNineU19/V+ItsU4UAdJ0j9mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYzMH7PGaaknlrzDdbdYvw3fnoE05nTK9Nk5wXMWKqg=;
 b=Xv5Q9UuHVw8nAp/Jj+gFsZPi2wQKbLdEsNUgbOPNPjzO7vO1lUV3jIZNXuGa4UeKJf3lKcH00A+BrlM1JV2M9L7upk23LOdk2k3K2DpY4GjD3f3m7LEaGAbBcGcl/YQJUw04C1TdmNWgLA65dag7Wn3vqelooy9OJh5twZzMaqY=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB5533.apcprd03.prod.outlook.com (2603:1096:400:56::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 08:43:57 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6609.026; Mon, 24 Jul 2023
 08:43:57 +0000
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
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH v6 10/11] drm/mediatek: dp: Add .wait_hpd_asserted() for
 AUX bus
Thread-Topic: [PATCH v6 10/11] drm/mediatek: dp: Add .wait_hpd_asserted() for
 AUX bus
Thread-Index: AQHZuLk5eusVmouwhk+P2TWfxjWTUa/IpIQA
Date:   Mon, 24 Jul 2023 08:43:57 +0000
Message-ID: <a1240e5d0f8c9f06b571b11c62e917fe033076c7.camel@mediatek.com>
References: <20230717141438.274419-1-angelogioacchino.delregno@collabora.com>
         <20230717141438.274419-11-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230717141438.274419-11-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB5533:EE_
x-ms-office365-filtering-correlation-id: 2d8515bb-0acc-4231-beef-08db8c221eb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bVkBGMuXAgA8gMYCER9CRPm8FhIlcnT7kJ5x2FSy74Guni+BIabl+welxtKlKlnr8ZPBcPL2NwxWCjHM30x72O+8UCmMaQzwII4u9mvSpTCc/dGUt+02j/EX/zLofx2HsMzUUYRXOqmDHltMJaql0LQ3eNLCwi8xTOdfpXR2E2/SB+2hulHf5XkRyFYYn1IFUpAk70f7t2JvmeWO1JDQHhl7GehNSCgq9O/rqAVAQQ4oJS/ywkzCaDX+T+WfLmHdqhxYw6TMFQ9IARdMX5hVDyCmNuc/cDMHKquXq7oWLqPrMv7JDtE5C0SJpIcMww5eNQy6hLc7MmbMRjc4843V7WTVe/pkrstjCuPHnLnQmQ8IKZ0bI2Gj+sqBbIZVhdfTUZJ/coI/dGp7XBkC6s0yYIJaHX0IelaCmNOMLOdB0cZklkGkTIYkkATD0H9TkQNzDrkwJXBliaPNONn3vmcHmbh0UWXYLASmTQi9P3UgzFRYbuzJSh4y3iEThqHeGySAGMzjLXsGS9q1pX9j75IIy/blcGdpzALTrM76tfviAtzRG836OT5GVNmVSPGe0unNt2KzMg76w0S4ycZDAcApLZNDqvoJiBC+ZHTR8PVqZMb1Frc+zomcclyidLLT1PHJNXmtzLa5arN/vGrLP4i3bMYsKCc8AiBew+JzrVdwOnKlZeNW/aWXcRGOlua0qKZl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199021)(6512007)(6486002)(71200400001)(54906003)(110136005)(478600001)(83380400001)(38070700005)(86362001)(2906002)(2616005)(186003)(26005)(6506007)(38100700002)(122000001)(36756003)(85182001)(64756008)(66446008)(66556008)(4326008)(316002)(76116006)(41300700001)(66476007)(8936002)(66946007)(8676002)(7416002)(5660300002)(142923001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFdBR0xFNlFOTGIwWTdWaFcrSWRTZGFMeG9nQ2sweFNvZWtINmQxUEl0YUly?=
 =?utf-8?B?WEI1TytITVJQN3M2WmkxaHp4bDBWdFQyZ0pMUGNhRjZrWDRtR1VzR0I3cE9H?=
 =?utf-8?B?U09qSjNGWXVuYVhKUGFyQWphb2JrZjF6RWxJVkYvOU5rMFhtYkNzakMxclF6?=
 =?utf-8?B?Vmh0Vi81K2ZqUkRMTlIrY1hFdExZb3VCWnBEbkRsSGNNN1NsS0pVVzRkaEJM?=
 =?utf-8?B?SEVRNjlTWXczZ2V2elE5WXMvL0NnUGdSM3FSNjZ4MlNZMEE5MGJyRW1nSDY4?=
 =?utf-8?B?SnhNb1k3L3B6U2hKWUVCaDRPUXRHaTFpMWtjd1FUSjFsRHJFcVN6VVpWdGJE?=
 =?utf-8?B?TUgvMzJkK0JsTVJvNzM4cWcvUUEzWWNhMHc5TE1ZK2N5a04zMlJSaTB4R3VM?=
 =?utf-8?B?VDVaOU5tS2tESzE1YWovWU54YWJSbVhLdlFUZ2pqWXRwTGo0RXkrSTFoU1Ru?=
 =?utf-8?B?SksyUHhUSGg3dVBLclMrQ0I5WkpjUnh5US9SUXNkd3BtTTA2VklHZWJ1Zm1u?=
 =?utf-8?B?K3NNcHJmRmp6Z2ZiLzVPRmY3YXRyOXd2eUpCY0hXK1pyRHZJMC9CN3p6T3ZC?=
 =?utf-8?B?bUNCbGJoMXphWDlFT1VjQXJBY2V4eFNWeThmaDB6Y25tN0ZvenpoaExYaGNr?=
 =?utf-8?B?OC93aGpVVmlOUjdnd2FHaHBpcjhJaU1ZbC96Z1hjNkV0bUwxRWVpelA2YXVQ?=
 =?utf-8?B?VEtmTDZVRm1FWHFkN1MwMmxsazVsajlKVUlla1RVbVRVZE9mNXJJNUpHRitz?=
 =?utf-8?B?eFVnTFJqOVBaNkd2THhpb0wydDVKOEJJc0V3OW93K0FsanlEeGFMRWlMaENU?=
 =?utf-8?B?UWZQc1pjSktJY0x3c09DSFd3TzRzOGljbnN6amlwckgzN1V3QWUwMDhVTjRi?=
 =?utf-8?B?SlhwL2U2QjF1cmVqWHlkSm9PQmx1bENwWkdxUHVGTE5lcDhkZlpCRTFreGdu?=
 =?utf-8?B?b3RlUUZJVVJKcDhLeGE1SnVzblpkMHgvS0ZXVmY0aGlFNmdIbGQxbEpKVWIv?=
 =?utf-8?B?ZDAwd1ZmbDh2R1J5V2RZLzFUZk03OWx6UUo4RG0zV2R1SC9lTm5oZ2MxNkFP?=
 =?utf-8?B?Ym1Udm84bHR3QUg3SzE5SjFZM28ycWNua2JGczVjSXJNMit4NWUvV3d2Z2dQ?=
 =?utf-8?B?ZVE2anlOREQ4RFE1STdYUzBhWDQ4cTMvZ1Y1STRHZEFraWxlMUYxRzBSUHZG?=
 =?utf-8?B?WEprRG5nd05PdEQxbExIRHhnTXR0OWhWcTV0MXhYZmVDVU1JVzZqZnl3KzZv?=
 =?utf-8?B?NHZhQWpsKzduejJ2V05jTUxOVFh5NnF4Wk56WTJyU1dibXl5YWpudEdYcGxl?=
 =?utf-8?B?OGZTTGVmYVNpWEtTRHlyVGU4QktXK0prVUFyd3M3QXBPN1F4eGpJQTZmR1JG?=
 =?utf-8?B?OFUyQkYrVXVCSW5VNkRGWk9yN3c2RDh4QWoxU0lkSG9JZHFjQzlwU1FhQWpl?=
 =?utf-8?B?eVlobC9wL2ViSFJoM0tUUUdHNGVWUTFzeXJuUWpUd1RQTmtPaHcybjh6cVkv?=
 =?utf-8?B?amc5MlA3NTFxUExNdEI2YmFEdTd6d0tGY2trRXFCT0hzVFNZQUVYVml5N0xL?=
 =?utf-8?B?RG84ZnBJaHVtazBJZkFSNVdGcW50dWoxRVBoZkJSSEFKZ2g3bEl2U0NzQUNp?=
 =?utf-8?B?V1JYWG9ERCtFbVBjRFZQNHNWQ0lMRzhzZGdGMWIvbUpUSEpkamdoeFdzMkJW?=
 =?utf-8?B?VmhhYi9udDZqcFdZZjFiOHRBTnU3WFBQQldqaDBhd2sva3ZhTTd1Mm54NXVP?=
 =?utf-8?B?c01mM1RrUkY3R0ozSmVPOFFseWRpRUczSS9ieUZWMENmMkY0cG5YSzNLUXVC?=
 =?utf-8?B?dDR1TTJQdXNBUXFmbkQ3SmFhS1RuTmc1MWQzN3dhUm5lM2JHeWNXdDlUeG5C?=
 =?utf-8?B?K3VEdTRKRUJyL1h5MHhWRDc4TGo2ZGNNRUxyaTVWY1NtbFR4VjFyVG55SzRK?=
 =?utf-8?B?ZXlXTFYweGtjVGZmRHJuUy9qamJKRHVqK3hzbnZjS25SMkpEOTNuOUdZZ3B3?=
 =?utf-8?B?RWZ6d1VMc0F4ZDNjVThMdTJCY1ZTRzNuelI0cnNWYng3QnlIZXo2aE51eENB?=
 =?utf-8?B?R1pJRzZVbW9NcndCR2xWbzRSbENtbytqTVR2cVFDZTZEN3BmellSdlVoNkNL?=
 =?utf-8?Q?VCGELu/Y0L1U/VTI59IHOAOL4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA1D7CA4CC288A43929632949111877A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8515bb-0acc-4231-beef-08db8c221eb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 08:43:57.4321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bwLeiaXmIB0m6rYuM7C7coiI9uWs8ivYV4vD8ezqB2bFTv16Wy43Ne0XQZAbnoBAopxF9gbXNKQvm9/Z0XyZgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5533
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gTW9uLCAyMDIzLTA3LTE3IGF0IDE2OjE0ICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxl
YXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBo
YXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBJbiBvcmRlciB0byBz
dXBwb3J0IHVzZWNhc2VzIGluIHdoaWNoIHRoZSBwYW5lbCByZWd1bGF0b3IgY2FuIGJlDQo+IHN3
aXRjaGVkIG9uIGFuZCBvZmYgdG8gc2F2ZSBwb3dlciwgYW5kIHVzZWNhc2VzIGluIHdoaWNoIHRo
ZSBwYW5lbA0KPiByZWd1bGF0b3IgaXMgb2ZmIGF0IGJvb3QsIGFkZCBhIC53YWl0X2hwZF9hc3Nl
cnRlZCgpIGNhbGxiYWNrIGZvcg0KPiB0aGUgQVVYIGJ1czogdGhpcyB3aWxsIG1ha2Ugc3VyZSB0
byB3YWl0IHVudGlsIHRoZSBwYW5lbCBpcyBmdWxseQ0KPiByZWFkeSBhZnRlciBwb3dlci1vbiBi
ZWZvcmUgdHJ5aW5nIHRvIGNvbW11bmljYXRlIHdpdGggaXQuDQo+IA0KPiBBbHNvLCBwYXJzZSB0
aGUgZURQIGRpc3BsYXkgY2FwYWJpbGl0aWVzIGluIHRoYXQgY2FsbGJhY2ssIHNvIHRoYXQNCj4g
d2UgY2FuIGFsc28gYXZvaWQgdXNpbmcgdGhlIC5nZXRfZWRpZCgpIGNhbGxiYWNrIGZyb20gdGhp
cyBicmlkZ2UuDQo+IA0KPiBTaW5jZSBhdCB0aGlzIHBvaW50IHRoZSBocGQgbWFjaGluZXJ5IGlz
IHBlcmZvcm1lZCBpbiB0aGUgbmV3IGhwZA0KPiBjYWxsYmFjayBhbmQgdGhlIGRldGVjdGlvbiBh
bmQgZWRpZCByZWFkaW5nIGFyZSBkb25lIG91dHNpZGUgb2YNCj4gdGhpcyBkcml2ZXIsIGFzc2ln
biB0aGUgRFJNX0JSSURHRV9PUF97REVURUNULCBFRElELCBIUER9IG9wcyBhbmQNCj4gcmVnaXN0
ZXIgdGhlIGJyaWRnZSB1bmNvbmRpdGlvbmFsbHkgYXQgcHJvYmUgdGltZSBvbmx5IGlmIHdlIGFy
ZQ0KPiBwcm9iaW5nIGZ1bGwgRGlzcGxheVBvcnQgYW5kIG5vdCBlRFAgd2hpbGUsIGZvciB0aGUg
bGF0dGVyLCB3ZQ0KPiByZWdpc3RlciB0aGUgYnJpZGdlIGluIHRoZSAuZG9uZV9wcm9iaW5nKCkg
Y2FsbGJhY2sgYW5kIG9ubHkgaWYNCj4gdGhlIHBhbmVsIHdhcyBmb3VuZCBhbmQgdHJpZ2dlcmVk
IEhQRC4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lv
YWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHAuYyB8IDQ1ICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+
IC0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4g
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gaW5kZXggYWNkZDQ1N2I1NDQ5
Li5lNzQyOTViYTk3MDcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gQEAg
LTE5MjAsNiArMTkyMCwzMSBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgbXRrX2RwX2hwZF9ldmVudChp
bnQgaHBkLA0KPiB2b2lkICpkZXYpDQo+ICAJcmV0dXJuIElSUV9XQUtFX1RIUkVBRDsNCj4gIH0N
Cj4gIA0KPiArc3RhdGljIGludCBtdGtfZHBfd2FpdF9ocGRfYXNzZXJ0ZWQoc3RydWN0IGRybV9k
cF9hdXggKm10a19hdXgsDQo+IHVuc2lnbmVkIGxvbmcgd2FpdF91cykNCj4gK3sNCj4gKwlzdHJ1
Y3QgbXRrX2RwICptdGtfZHAgPSBjb250YWluZXJfb2YobXRrX2F1eCwgc3RydWN0IG10a19kcCwN
Cj4gYXV4KTsNCj4gKwl1MzIgdmFsOw0KPiArCWludCByZXQ7DQo+ICsNCj4gKwlyZXQgPSByZWdt
YXBfcmVhZF9wb2xsX3RpbWVvdXQobXRrX2RwLT5yZWdzLA0KPiBNVEtfRFBfVFJBTlNfUDBfMzQx
NCwNCj4gKwkJCQkgICAgICAgdmFsLCAhISh2YWwgJg0KPiBIUERfREJfRFBfVFJBTlNfUDBfTUFT
SyksDQo+ICsJCQkJICAgICAgIHdhaXRfdXMgLyAxMDAsIHdhaXRfdXMpOw0KPiArCWlmIChyZXQp
IHsNCj4gKwkJbXRrX2RwLT50cmFpbl9pbmZvLmNhYmxlX3BsdWdnZWRfaW4gPSBmYWxzZTsNCj4g
KwkJcmV0dXJuIHJldDsNCj4gKwl9DQo+ICsNCj4gKwltdGtfZHAtPnRyYWluX2luZm8uY2FibGVf
cGx1Z2dlZF9pbiA9IHRydWU7DQo+ICsNCj4gKwlyZXQgPSBtdGtfZHBfcGFyc2VfY2FwYWJpbGl0
aWVzKG10a19kcCk7DQo+ICsJaWYgKHJldCkgew0KPiArCQlkcm1fZXJyKG10a19kcC0+ZHJtX2Rl
diwgIkNhbid0IHBhcnNlIGNhcGFiaWxpdGllc1xuIik7DQo+ICsJCXJldHVybiByZXQ7DQo+ICsJ
fQ0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQgbXRrX2RwX2R0
X3BhcnNlKHN0cnVjdCBtdGtfZHAgKm10a19kcCwNCj4gIAkJCSAgIHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+ICB7DQo+IEBAIC0yNTMyLDYgKzI1NTcsMTIgQEAgc3RhdGljIGludCBt
dGtfZHBfZWRwX2xpbmtfcGFuZWwoc3RydWN0DQo+IGRybV9kcF9hdXggKm10a19hdXgpDQo+ICAJ
CW10a19kcC0+bmV4dF9icmlkZ2UgPSBOVUxMOw0KPiAgCQlyZXR1cm4gcmV0Ow0KPiAgCX0NCj4g
Kw0KPiArCS8qIEZvciBlRFAsIHdlIGFkZCB0aGUgYnJpZGdlIG9ubHkgaWYgdGhlIHBhbmVsIHdh
cyBmb3VuZCAqLw0KPiArCXJldCA9IGRldm1fZHJtX2JyaWRnZV9hZGQoZGV2LCAmbXRrX2RwLT5i
cmlkZ2UpOw0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVybiByZXQ7DQo+ICsNCj4gIAlyZXR1cm4g
MDsNCj4gIH0NCj4gIA0KPiBAQCAtMjU2OCw2ICsyNTk5LDcgQEAgc3RhdGljIGludCBtdGtfZHBf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gIAltdGtfZHAtPmF1eC5u
YW1lID0gImF1eF9tdGtfZHAiOw0KPiAgCW10a19kcC0+YXV4LmRldiA9IGRldjsNCj4gIAltdGtf
ZHAtPmF1eC50cmFuc2ZlciA9IG10a19kcF9hdXhfdHJhbnNmZXI7DQo+ICsJbXRrX2RwLT5hdXgu
d2FpdF9ocGRfYXNzZXJ0ZWQgPSBtdGtfZHBfd2FpdF9ocGRfYXNzZXJ0ZWQ7DQo+ICAJZHJtX2Rw
X2F1eF9pbml0KCZtdGtfZHAtPmF1eCk7DQo+ICANCj4gIAlzcGluX2xvY2tfaW5pdCgmbXRrX2Rw
LT5pcnFfdGhyZWFkX2xvY2spOw0KPiBAQCAtMjYwMCwxNSArMjYzMiw4IEBAIHN0YXRpYyBpbnQg
bXRrX2RwX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICANCj4gIAlt
dGtfZHAtPmJyaWRnZS5mdW5jcyA9ICZtdGtfZHBfYnJpZGdlX2Z1bmNzOw0KPiAgCW10a19kcC0+
YnJpZGdlLm9mX25vZGUgPSBkZXYtPm9mX25vZGU7DQo+IC0NCj4gLQltdGtfZHAtPmJyaWRnZS5v
cHMgPQ0KPiAtCQlEUk1fQlJJREdFX09QX0RFVEVDVCB8IERSTV9CUklER0VfT1BfRURJRCB8DQo+
IERSTV9CUklER0VfT1BfSFBEOw0KPiAgCW10a19kcC0+YnJpZGdlLnR5cGUgPSBtdGtfZHAtPmRh
dGEtPmJyaWRnZV90eXBlOw0KPiAgDQo+IC0JcmV0ID0gZGV2bV9kcm1fYnJpZGdlX2FkZChkZXYs
ICZtdGtfZHAtPmJyaWRnZSk7DQo+IC0JaWYgKHJldCkNCj4gLQkJcmV0dXJuIGRldl9lcnJfcHJv
YmUoZGV2LCByZXQsICJGYWlsZWQgdG8gYWRkDQo+IGJyaWRnZVxuIik7DQo+IC0NCj4gIAltdGtf
ZHAtPm5lZWRfZGVib3VuY2UgPSB0cnVlOw0KPiAgCXRpbWVyX3NldHVwKCZtdGtfZHAtPmRlYm91
bmNlX3RpbWVyLCBtdGtfZHBfZGVib3VuY2VfdGltZXIsIDApOw0KPiAgDQo+IEBAIC0yNjQ3LDYg
KzI2NzIsMTIgQEAgc3RhdGljIGludCBtdGtfZHBfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZQ0KPiAqcGRldikNCj4gIAkJCQlyZXR1cm4gcmV0Ow0KPiAgCQkJfQ0KPiAgCQl9DQo+ICsJfSBl
bHNlIHsNCj4gKwkJbXRrX2RwLT5icmlkZ2Uub3BzID0gRFJNX0JSSURHRV9PUF9ERVRFQ1QgfA0K
PiArCQkJCSAgICAgRFJNX0JSSURHRV9PUF9FRElEIHwNCj4gRFJNX0JSSURHRV9PUF9IUEQ7DQo+
ICsJCXJldCA9IGRldm1fZHJtX2JyaWRnZV9hZGQoZGV2LCAmbXRrX2RwLT5icmlkZ2UpOw0KPiAr
CQlpZiAocmV0KQ0KPiArCQkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJGYWlsZWQg
dG8gYWRkDQo+IGJyaWRnZVxuIik7DQo+ICAJfQ0KPiAgDQo+ICAJcG1fcnVudGltZV9lbmFibGUo
ZGV2KTsNCj4gLS0gDQo+IDIuNDAuMQ0K

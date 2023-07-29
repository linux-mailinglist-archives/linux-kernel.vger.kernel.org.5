Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D05C767BA2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 04:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbjG2Cy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 22:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjG2Cy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 22:54:27 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704B0EB;
        Fri, 28 Jul 2023 19:54:18 -0700 (PDT)
X-UUID: 3383bbbe2dbb11ee9cb5633481061a41-20230729
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=R1j8sBk73oX5QHTRGQh2/R6lKFtLAQwm6sBNI+6P0pg=;
        b=FHNbbejuUJ6P9Qjx/WzDV+R4WhTVmNK8qMNeA5QPWBiDT63SI4EMMnRZk002JsMXg3xzrB39pgL4SvWuJ229XYRYdLvZ8A/iRQ7L9pno3YZwCmRnF+K5LeUferKjmbm2qs1GwORjhjU9X5tz9Bw2TdKaAkuCSw1lcE1Kdn85wSU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:9bc258c9-d13b-42af-8604-f8e04f246984,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.30,REQID:9bc258c9-d13b-42af-8604-f8e04f246984,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:1fcc6f8,CLOUDID:1faee9b3-a467-4aa9-9e04-f584452e3794,B
        ulkID:230728172600KU21SN27,BulkQuantity:7,Recheck:0,SF:38|29|28|17|19|48|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:40,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,
        TF_CID_SPAM_FAS
X-UUID: 3383bbbe2dbb11ee9cb5633481061a41-20230729
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 349599497; Sat, 29 Jul 2023 10:54:14 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 29 Jul 2023 10:54:12 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 29 Jul 2023 10:54:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3m2oVKZQT+akPLM74aYq4vKzetWV8BCWNQB5xp4y7iHzoqlj/2V4/YYprr80sCyOIgjdIdaLQF74OSHh9Ndc5pHfFIIwyE7xEXoDqBM7zYtX/dIy8UHd3nBbPvHWCULY5GLG8Eu/6Aq1fXz+s4NT7RPXskQKIqRa4f7GipxGhRlyOsVc8zHDlAav+rEKbgW1+68i4tVA/Tqh6phNkKyRlzUBLGM7aAa3PisGj4axqQoWgPlOvGwgkI9fd0pf4Es9x2PVLXawbsO2zeEeU7SAHhBKZZd6BbTGWK4XQ+I8ZDoysWvonxVwoGyiIIRYmWVINRLw2JoRfyTZXGUmSsG0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1j8sBk73oX5QHTRGQh2/R6lKFtLAQwm6sBNI+6P0pg=;
 b=jZHZjLAC7LmHC0G7ynlntxmt3C2RGXSF+n96T5spKVn63V9N2Yb6U8XgJdUnHiFPdnw3VDj2rhL8C6SRyfxBG1HlNGflPVODFrfdEX863jSEYUe8phpZrAVm6rmtWAj1BbDZ6QyhGMUjq5Hv96MYTU5ZUK+iJ1VfHaNl5R5/L5g5+zPpNXLdpKvEhCZ9IlURZSLJPxnZynE7bCFpLFD34v9P4BnQmitYBZ2GLPHKPJA3U6p62g94YPtOqBQ0QpEq71lar60ELtlZXbC8VBOM6w1y2mcegDIlozfloAicMjB3mKtYvuN3b4p9nxniJYzHNZh8YcCHGY53xZD6IaIviQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1j8sBk73oX5QHTRGQh2/R6lKFtLAQwm6sBNI+6P0pg=;
 b=vHwFLKcdH3jInX5867yD9Vb0d3W2OYRRNm9G8Hu8JuyTfalapdHCp8V9MdIAtQuYxsLs0BNBxzzvIv0HuJKuTsQfubCTffrMQ87k4TrDUFmkL7hVFCnDgOE93Cq01x7q49w5xZghGd9YPNxHgZ+iTf9KS2d4WbqfInqjEho3w3M=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by PSAPR03MB5542.apcprd03.prod.outlook.com (2603:1096:301:4e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.34; Sat, 29 Jul
 2023 02:54:09 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::b637:cc4e:c9bd:64d]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::b637:cc4e:c9bd:64d%3]) with mapi id 15.20.6631.026; Sat, 29 Jul 2023
 02:54:08 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "nhebert@chromium.org" <nhebert@chromium.org>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7,0/11] media: mediatek: vcodec: separate encoder and
 decoder
Thread-Topic: [PATCH v7,0/11] media: mediatek: vcodec: separate encoder and
 decoder
Thread-Index: AQHZvHAYvJOvd9IgRkKaXq4ywXAFwq/KREcAgASt1ICAASTmgA==
Date:   Sat, 29 Jul 2023 02:54:08 +0000
Message-ID: <881a8f1860bab64ca9f03e90e3595c451f6dab31.camel@mediatek.com>
References: <20230722074230.30558-1-yunfei.dong@mediatek.com>
         <231e9976-93fe-b8b1-29d9-6c799a8e6a3a@xs4all.nl>
         <2d9eeb0e-71b3-157c-b947-6dd5485f46e3@xs4all.nl>
In-Reply-To: <2d9eeb0e-71b3-157c-b947-6dd5485f46e3@xs4all.nl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|PSAPR03MB5542:EE_
x-ms-office365-filtering-correlation-id: c43115e0-ca9d-4a5c-91b8-08db8fdf1427
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DLWSciKVkmxhCGv0lMdSVM43YWM2Igagov/qYTFB7Ox0kyRashRtvDq0ZSux7HABc1nNRAb3yDycMliIYFYTcd8M+Tf82sDsrgGNeH4v9e0NeCxPGr3b3e91WK39dFRKVQsmExPzLGeOq9A+lfn8QitX6neQUsebF0sMGifMIBoRSokP/OrrhEeNcM0NvPF9QdO2qVJ6ahScsHXkj/WT7IjCBQdpf8NZjwzrBM8ADyxhWd5Jso0yvY9Wy9BaAgYIjN5+O5g/01bs1YHeuLwQ0HWNx62LOCxGWtENel+16DrKFStzHdPgRwfNcvOadZp/Jm94Bpvq063hPudrRsPMp8i4t42toKP1CS7x7d4JgnckaHH6zFbvgtgo/iy0ElHtAK30be9R0saA5LvETGaptXTaKM/9J/RHJCSX8JY8hWlpAsmPr0c+T1ASr/AXyx0tbc8vgjmtTyesvTP28hw6NLuN+r/eX2H59PEdeRevkWF6nlt29YO/pQtoeiADK+y6ix8hup8E8wN7lxU4gMCPqBntyCTy9YRk7euzhHX9zamOx84dthV8vzhyjlkhA+ohstydeNw8CNYqPix8eaNRu8xRMTt2+yPxzNz4gICj6KqIPpOqNha5BhVd3LUgHEE99uQc4cZwW15VNRurr+5OsL46TxWrc6kpOwMZ+SE+BqiBZXO8togGCTTC6lGRf7Vx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199021)(85182001)(66946007)(2616005)(64756008)(66556008)(83380400001)(66476007)(66446008)(41300700001)(122000001)(5660300002)(36756003)(86362001)(8676002)(8936002)(6512007)(966005)(6486002)(110136005)(54906003)(71200400001)(478600001)(316002)(4326008)(38100700002)(38070700005)(2906002)(7416002)(76116006)(91956017)(53546011)(6506007)(186003)(26005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEpmck5uVDlzNVVrQmt2RnY1cERESkU0ZENzUU9rZGVZODJrbG1OZ1JOeUtW?=
 =?utf-8?B?TlkzakUvTFdTSUpCYWgyOE5jZkJmOEdQMElkTWVPR2NoandycWVPTnVPQ2R2?=
 =?utf-8?B?WVpzbHo4Uk51OGs3QXM2VGl5SmMvMTBnbkVpUGtlaEFmc1RhTnJoK3FrUWFp?=
 =?utf-8?B?MDZrQlZSVTYzUnFLbFBFS000am1WaEIveU5MUHdaZHp6UVZDMGpPWXoxdjcz?=
 =?utf-8?B?N1VXcUpZQmVtbmxpeGdSalRjMmdkUG9WUFVmeGFYVDdRNkRzSlk1OFYxZXdl?=
 =?utf-8?B?SWJJbXcwSDRvS3pOaG52bWFKcEx0a1RueEpGWG0zeWV2WWloUFF0cHpMdDZn?=
 =?utf-8?B?UjhYQWdqVDJvUC9CQ05mRzFEMm1ESzRvU2RqTVN4Y29ybWpKRnVtNHpiU3hm?=
 =?utf-8?B?RUt4anRiN2hIUUY0S3JZcWZ6QklPbnArczQ1TlU1LzZLLytBQkh6VUNOM1FF?=
 =?utf-8?B?aCtpZ1FTZWdZc0w1a3hGWlhhT3ArTUR5MXBEa0I3REVSaWVEVGNYdlhEZXBT?=
 =?utf-8?B?bWd2dGtubm56NEw4bWFicmxtaFhrRHBTVDQvUnByVWkrYkxHaVdkU0s1TXhV?=
 =?utf-8?B?OEVTbElHOXFUWEtlNnpDbVBwTXVDbFViUGlidG1SN0d1emlDTFQxWGIwT0kr?=
 =?utf-8?B?OS90bHBzOWNpYWE3clZkcUhxS3lyM2krTERTVWtBWmo5OTZJZzNYOHFVVk9l?=
 =?utf-8?B?d2FPUVVlQjlBOXZrdGUvRllRUDdiKzE0VUYzanphd0JqblBDQ1lKNnVhbUNO?=
 =?utf-8?B?RXZucks2aXNCUXFGOTVKK0VkY3pjZnBwcDc3K2NaMUl3U3g1R09xNWovRCsv?=
 =?utf-8?B?TjVjRU1keG5mYm1Rc3pLeFVTK0QwckFhc0tpNjN1cG9Sd3NzV1NwL3hZN1pT?=
 =?utf-8?B?VVB4WWFWVk1GTjAxWGZvaHVmSnVwZnRFV1E4NGQyTi9WKzAxaWEwcnZ1MXZU?=
 =?utf-8?B?NkNPWTZlSHlMZTdXQ3BJcnBVUjdnRjdlQTNSTFd2amNwRWxmKzVOSkE1ejlr?=
 =?utf-8?B?bUdLSHdPMTc1VlVkSkJ6V3BoMWhSZXAwbGdoQW43RHRzQVN0V3RwSkdMZ1JE?=
 =?utf-8?B?anlHL0Z5T0gxUW05VU5ENzNqcjVvOElCdzV3aHltWmZRZ3NXcDhybHNrUXhT?=
 =?utf-8?B?T1RiMEpFZG1kWitwaGFCL1pnWk5WVk1VdFBYYjZvRjdPbFk5Yzc0M2N3QmNt?=
 =?utf-8?B?Y3hlN0hESlNhZWlkakxGZTZlbStZQWZmdko2d0RVU2ZkQTVDYUphOEwyN0pJ?=
 =?utf-8?B?b3ZncnJ4TStVcG83M25SY1QrT3JEeTVacnlsQTF4cjBzSStDZXdJeW5pVzdo?=
 =?utf-8?B?dExGZHFtMW51VTNzb1kzVjRWc3BmcU9GY3BCUXlHem9uM2J1dUpTSDB2QUxk?=
 =?utf-8?B?NjV5aTB0eFYzTXVrUjVkOTZpNEFHdW5kOXczb3hlKyt0cUtkbFBoWXRHVjgw?=
 =?utf-8?B?OC93WW1WUGJSMC9xdjBzV1NhdG9MK0VWWndwbmNCWEszakVlNnoxSy9Qd0dl?=
 =?utf-8?B?OTVMWHdqcXQzeHgxWmsxb0dBczlCbzVFZHdVYmRNN2lqVEFLWVR2Y1NMOEFr?=
 =?utf-8?B?L0FvcTVHcTJWNEFDVTRMUXgvRTY5UFJzVytMMnBTQjl0cEhYbG0xV2tMM0JB?=
 =?utf-8?B?aUJYaXhUK2hTZVZuNThnUlgxODJDdWJDSjZSMEpEbFlyY2ZwM1Jja0NOOFR6?=
 =?utf-8?B?VExjd0lRN0NiZFZ0VTZxM0NxVzIzOXBEOGtWZVhmYmNoMnZMV0h2MEdWeUJE?=
 =?utf-8?B?NGh2cWZpUTBaUmYwVzE1OTlMYWlKZ28xa2VlWC94UklkMVg0R1ZhcmVXYVRU?=
 =?utf-8?B?TmlyVEQ5dVVHQ0lwOHFVVUMzMlFxWS9DY3FKdUNCOWg3WVRTSEF1cjE4ZFpZ?=
 =?utf-8?B?alNySG02bFUybE95ampDWGZPZ1ZuZFlMdHVqUlZIVXJ4ajIyU2ZtOUsyRFAy?=
 =?utf-8?B?WGUzZEdWR2cwSklnYm4vaDUreW1HYjhqcWFXWlVickU2ME82ZDVLb0tGZlZt?=
 =?utf-8?B?RHp0c2cwV3Q4NUt4ZlNGMU1zc0Z4TUs3bTVlYU55NzhST0ovcGhMWldQUGt4?=
 =?utf-8?B?K3ZjK1MwdzZyRUUwUzJQZXpTRldLQ1FIU2JqSlNoSlJNb1lmWVlQalFWRUFw?=
 =?utf-8?B?Y0IwdHNwNVVjWTJ1bElYbnh0aE9MUEorcGV5Z3hBaUdhcnR3RmNzUENod1Jt?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <604ABB9BAA24814E8D47CE5C68414AF4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c43115e0-ca9d-4a5c-91b8-08db8fdf1427
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2023 02:54:08.1669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KV4VPbI+5GpO3vovJ0u7Bhof6kCfMN4O9zeTTtZYqux6d0E426aC11BsfXskB6YQN51pFw7JIp12cnbYQNzjheCSksNbzju0KPsaF5Yielw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5542
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGFucywNCg0KVGhhbmtzIGZvciB5b3VyIGhlbHAgYW5kIHN1Z2dlc3Rpb24uDQoNCk9uIEZy
aSwgMjAyMy0wNy0yOCBhdCAxMToyNSArMDIwMCwgSGFucyBWZXJrdWlsIHdyb3RlOg0KPiAgCSAN
Cj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29u
dGVudC4NCj4gIE9uIDI1LzA3LzIwMjMgMTE6NTgsIEhhbnMgVmVya3VpbCB3cm90ZToNCj4gPiBP
biAyMi8wNy8yMDIzIDA5OjQyLCBZdW5mZWkgRG9uZyB3cm90ZToNCj4gPj4gRnJvbTogWXVuZmVp
IERvbmcgPHl1bmZlaS5kb25nQG1lZGlhdGVrLmNvcnAtcGFydG5lci5nb29nbGUuY29tPg0KPiA+
Pg0KPiA+PiBXaXRoIHRoZSBkcml2ZXIgbW9yZSBhbmQgbW9yZSBjb21wbGV4LCBlbmNvZGVyIGFu
ZCBkZWNvZGVyIG5lZWQgdG8NCj4gYWRkIG1vcmUgcGFyYW1ldGVyDQo+ID4+IGluIHNoYXJlZCBz
dHJ1Y3QgJ210a192Y29kZWNfY3R4JyBhbmQgJ210a192Y29kZWNfZGV2Jy4gRW5jb2Rlcg0KPiB1
c2UgYWJvdXQgNDAlIGFuZA0KPiA+PiBkZWNvZGVyIHVzZSA2MCUgcGFyYW1ldGVyLiBOZWVkIHRv
IGFsbG9jYXRlIGV4dHJhIHVudXNlZCBtZW1vcnkNCj4gd2hlbiBlbmNvZGVyIGFuZCBkZWNvZGVy
DQo+ID4+IHdvcmtpbmcuDQo+ID4+DQo+ID4+IFNlcGFyYXRlIGVuY29kZXIgYW5kIGRlY29kZXIg
aW4gZGlmZmVyZW50IGZvbGRlciBhbmQgdXNlDQo+IGluZGVwZW5kZW50IGRhdGEgc3RydWN0Lg0K
PiA+Pg0KPiA+PiBwYXRjaCAxIHJlbW92ZSB1bnVzZWQgcGFyYW1ldGVyLg0KPiA+PiBwYXRjaCAy
fjMgYWxpZ24gZncgYW5kIGludGVycnVwdCByZWxhdGVkIGludGVyZmFjZS4NCj4gPj4gcGF0Y2gg
NH42IHJlbW92ZSB0aGUgZGVwZW5kZW5jeSBvZiBkZWJ1ZyBsb2cNCj4gPj4gcGF0Y2ggN344IHNl
cGFyYXRlIG10a192Y29kZWNfY3R4IGFuZCBtdGtfdmNvZGVjX2Rldg0KPiA+PiBwYXRjaCA5IGZp
eCB1bnJlYXNvbmFibGUgcGFyYW1ldGVyDQo+ID4+IHBhdGNoIDEwIHJlbW92ZWQgdW51c2VkIGhl
YWRlciBmaWxlcw0KPiA+PiBwYXRjaCAxMSBzZXBhcmF0ZSBlbmNvZGVyIGFuZCBkZWNvZGVyIGlu
IGRpZmZlcmVudCBmb2xkZXINCj4gPj4gLS0tDQo+ID4+IENoYW5nZWQgZnJvbSB2NjoNCj4gPj4g
LSByZWJhc2UgdG86IA0KPiBodHRwczovL2dpdC5saW51eHR2Lm9yZy9odmVya3VpbC9tZWRpYV90
cmVlLmdpdC9sb2cvP2g9Zm8tdjYuNmcuDQo+ID4+IENoYW5nZWQgZnJvbSB2NToNCj4gPj4gLSBm
aXggc29tZSB3b3JkcyBlcnJvciBmb3IgcGF0Y2ggMy82LzExLg0KPiA+PiAtIHJlbmFtZSBtdGtf
dmNvZGVjX2NvbW1fZHJ2LmggdG8gbXRrX3Zjb2RlY19jbW5fZHJ2LmggZm9yIHBhdGNoDQo+IDcu
DQo+ID4+IENoYW5nZWQgZnJvbSB2NDoNCj4gPj4gLSBhZGQgb25lIHBhcmFtZXRlciB0byByZWNv
cmQgcmVnaXN0ZXIgYmFzZSBmb3IgcmVnX2Jhc2UgZm9yIHBhdGNoDQo+IDMuDQo+ID4+IC0gYWRk
IGRlYnVnIHN0cmluZyBmb3Igbm9uIGN0eCBsb2cgZm9yIHBhdGNoIDYuDQo+ID4+IC0gY2hhbmdl
IHRoZSBjb21tZW50IG9mIHN0cnVjdCBtdGtfdmNvZGVjX2RlY19jdHggYW5kIHN0cnVjdA0KPiBt
dGtfdmNvZGVjX2VuY19jdHggZm9yIHBhdGNoIDcuDQo+ID4+IC0gcHJlZmVyIHRvIHVzZSBzdHJ1
Y3QgbXRrX3Zjb2RlY19kZWNfZGV2IGFuIGN1cnJlbnQgcGVyaW9kLCB3aWxsDQo+IHJlLWNvbnN0
cnVjdCBpbiB0aGUgZnV0dXJlIGZvciBwYXRjaCA4Lg0KPiA+PiBDaGFuZ2VkIGZyb20gdjM6DQo+
ID4+IC0gcmUtd3JpdGUgY29tbWl0IG1lc3NhZ2UgZm9yIHBhdGNoIDMuDQo+ID4+IENoYW5nZWQg
ZnJvbSB2MjoNCj4gPj4gLSBUaGlzIHBhdGNoIG1haW4gY2hhbmdlZDoNCj4gPj4gICAxOiBhZGQg
ZGlmZmVyZW50IG1hY3JvIG10a19kZWNfZGVidWcgYW5kIG10a19lbmNfZGVidWcgY2FsbGluZw0K
PiBjb21tb24NCj4gPj4gICAgICBtYWNybyBtdGtfdmNvZGVjX2RlYnVnIGluIG9yZGVyIHRvIHVz
ZSBkZXZfZGJnIGluc3RlYWQgb2YNCj4gcHJfZGVidWcuDQo+ID4+ICAgMjogYWRkIGRpZmZlcmVu
dCBtYWNybyBtdGtfdjRsMl92ZW5jX2RiZyBhbmQgbXRrX3Y0bDJfdmRlY19kYmcNCj4gY2FsbGlu
ZyBjb21tb24NCj4gPj4gICAgICBtYWNybyAgaW4gb3JkZXIgdG8gdXNlIGRldl9kYmcgaW5zdGVh
ZCBvZiBwcl9kZWJ1Zy4NCj4gPj4gQ2hhbmdlZCBmcm9tIHYxOg0KPiA+PiAtIENoYW5nZSBwcl9k
YmcgdG8gZGV2X2RiZyBmb3IgbXRrX3Y0bDJfbGV2ZWwgYW5kIG10a192Y29kZWNfZGJnDQo+IGZv
ciBwYXRjaCA0Lg0KPiA+PiAtIENoYW5nZSBwcl9lcnIgdG8gZGV2X2VyciBmb3IgbXRrX3Y0bDJf
ZXJyIGFuZCBtdGtfdmNvZGVjX2VyciBmb3INCj4gcGF0Y2ggNS4NCj4gPj4gLSBGaXggdW5yZWFz
b25hYmxlIHBhcmFtZXRlciBmb3IgcGF0Y2ggOC4NCj4gPj4gLS0tDQo+ID4+IFl1bmZlaSBEb25n
ICgxMSk6DQo+ID4+ICAgbWVkaWE6IG1lZGlhdGVrOiB2Y29kZWM6IHJlbW92ZSB1bnVzZWQgcGFy
YW1ldGVyDQo+ID4+ICAgbWVkaWE6IG1lZGlhdGVrOiB2Y29kZWM6IGFsaWduIGZ3IGludGVyZmFj
ZQ0KPiA+PiAgIG1lZGlhOiBtZWRpYXRlazogdmNvZGVjOiBSZW1vdmluZyBzdHJ1Y3QgJ210a192
Y29kZWNfY3R4L2RldicNCj4gZm9yDQo+ID4+ICAgICBzaGFyZWQgaW50ZXJmYWNlDQo+ID4+ICAg
bWVkaWE6IG1lZGlhdGVrOiB2Y29kZWM6IFJlbW92aW5nIHVzZWxlc3MgZGVidWcgbG9nDQo+ID4+
ICAgbWVkaWE6IG1lZGlhdGVrOiB2Y29kZWM6IHJlbW92ZSB0aGUgZGVwZW5kZW5jeSBvZiB2Y29k
ZWMgZGVidWcNCj4gbG9nDQo+ID4+ICAgbWVkaWE6IG1lZGlhdGVrOiB2Y29kZWM6IHJlcGxhY2Ug
cHJfKiB3aXRoIGRldl8qIGZvciB2NGwyIGRlYnVnDQo+ID4+ICAgICBtZXNzYWdlDQo+ID4+ICAg
bWVkaWE6IG1lZGlhdGVrOiB2Y29kZWM6IHNlcGFyYXRlIHN0cnVjdCAnbXRrX3Zjb2RlY19jdHgn
DQo+ID4+ICAgbWVkaWE6IG1lZGlhdGVrOiB2Y29kZWM6IHNlcGFyYXRlIHN0cnVjdCBtdGtfdmNv
ZGVjX2Rldg0KPiA+PiAgIG1lZGlhOiBtZWRpYXRlazogdmNvZGVjOiBmaXggdW5yZWFzb25hYmxl
IHBhcmFtZXRlciBkZWZpbml0aW9uDQo+IGFuZA0KPiA+PiAgICAgc3R5bGUNCj4gPj4gICBtZWRp
YTogbWVkaWF0ZWs6IHZjb2RlYzogcmVtb3ZlIHVudXNlZCBpbmNsdWRlIGhlYWRlcg0KPiA+PiAg
IG1lZGlhOiBtZWRpYXRlazogdmNvZGVjOiBzZXBhcmF0ZSBkZWNvZGVyIGFuZCBlbmNvZGVyDQo+
ID4gDQo+ID4gQmVzaWRlcyB0aGUgbWlzc2luZyBhcmd1bWVudCBpbiBwYXRjaCA2LzExIEkgYWxz
byBnZXQgdGhpcyBjb21waWxlcg0KPiB3YXJuaW5nOg0KPiA+IA0KPiA+IGRyaXZlcnMvbWVkaWEv
cGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2VuY29kZXIvdmVuY192cHVfaWYuYzogSW4NCj4gZnVu
Y3Rpb24gJ3ZwdV9lbmNfaXBpX2hhbmRsZXInOg0KPiA+IGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0v
bWVkaWF0ZWsvdmNvZGVjL2VuY29kZXIvdmVuY192cHVfaWYuYzo2NDozMToNCj4gd2FybmluZzog
J3ZwdScgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBbLVdtYXliZS11bmluaXRpYWxpemVkXQ0K
PiA+ICAgIDY0IHwgICAgICAgICBzdHJ1Y3QgdmVuY192cHVfaW5zdCAqdnB1Ow0KPiA+ICAgICAg
IHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+DQo+ID4gDQo+ID4gYW5kIHRoaXMg
c21hdGNoIGVycm9yOg0KPiA+IA0KPiA+DQo+IGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0
ZWsvdmNvZGVjL2RlY29kZXIvbXRrX3Zjb2RlY19kZWNfZHJ2LmM6MQ0KPiAzOCBtdGtfdmNvZGVj
X2dldF9yZWdfYmFzZXMoKSBlcnJvcjogYnVmZmVyIG92ZXJmbG93DQo+ICdtdGtfZGVjX3JlZ19u
YW1lcycgMTEgPD0gMTENCj4gPiANCj4gPiBIb3dldmVyLCBJIGJlbGlldmUgdGhhdCB3YXMgaW50
cm9kdWNlZCBieSBOaWNvbGFzJyBwYXRjaCBzZXJpZXMuDQo+ID4gDQo+ID4gSSdsbCB0cnkgdG8g
cGlucG9pbnQgdGhlIHByZWNpc2UgcGF0Y2guDQo+IA0KPiBUaGF0IHNtYXRjaCBlcnJvciBpcyBu
b3cgZm91bmQgYW5kIGZpeGVkIGluIHRoZSBzdGFnaW5nIHRyZWUuDQo+IA0KPiBDYW4geW91IHBv
c3QgYSB2OCBmaXhpbmcgdGhlIG90aGVyIGlzc3Vlcz8NCj4gDQo+IFRoYW5rcyENCg0KVGhlIGJ1
aWxkIGZhaWwgZm9yIHBhdGNoIDA2IGFuZCBzbWF0Y2ggZmFpbCB3aWxsIGJlIGZpeGVkIGluIG5l
eHQNCnBhdGNoLg0KDQpCZXN0IFJlZ2FyZHMsDQpZdW5mZWkgRG9uZw0KDQo+IA0KPiBSZWdhcmRz
LA0KPiANCj4gSGFucw0KPiANCj4gPiANCj4gPiBSZWdhcmRzLA0KPiA+IA0KPiA+IEhhbnMNCj4g
DQo=

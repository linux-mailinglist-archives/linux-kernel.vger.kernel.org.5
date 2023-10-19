Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3667CF474
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345129AbjJSJw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345043AbjJSJwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:52:25 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2267E115;
        Thu, 19 Oct 2023 02:52:16 -0700 (PDT)
X-UUID: 2c4a17866e6511eea33bb35ae8d461a2-20231019
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=w0Fu7oE8TgeWvbgjXO+OC6Ig3zgCZ2bXu2n+6sbJ/6U=;
        b=Uw081TjiKEBDi3uUkvXwx+JMnXmd6AwnvRganpKNO3R8VfEPJgl1Sk7gkCE6b/bs4h6zMrojRHlITKhgMK85YM+5cEgA66Jc0DiQThf4/aEHCXMy1feYT7olBeHfUMXfEDile6Yimu829St46dENvf3qvaYezQ4xH7Bgylu3JP4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:759c53bb-090c-43c8-ba1b-67914e45cff2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:e9381fc0-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 2c4a17866e6511eea33bb35ae8d461a2-20231019
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 923967830; Thu, 19 Oct 2023 17:52:10 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 19 Oct 2023 17:52:09 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 19 Oct 2023 17:52:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3V4HdbXDWCV3mKLBq/Ma3NooZJQLn4EnKy5UMJGzjCbpiWlBrsitEs+MweqpdYhq/lEOJqQwFOf7VcuSUTRDG+RddVQBiLhbkp/qRBDBN1s5LcnZd1h/EIkKCCf1lsZU23w3OnE+Gt3u7J0XiHeMZsaq9aaqrSs0w94OusHv33BzkHRPQo0UElKj0XT1+GZ3/GYHofjuiltI2ZXoGyme0/YBZWxEM8wcdVnKaS0F7LTUi7Nbaf5QxI6v7YppgytEr8l5SbzDkaLlZeZ7eETejfOY583Z32ceK+tfPIgfV0H72xYa5t1byl5CJA10G7SivuuecplSAd/+tK8ZcwBvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0Fu7oE8TgeWvbgjXO+OC6Ig3zgCZ2bXu2n+6sbJ/6U=;
 b=MRlxNj3FN5nDrg4pI0esOvGIfuFbh58j18j2mJZxN5yZ/PZa2q0mR0TFCXErqkj4rpQVknHIL3fG2qVtlD0UWMqOFNIaUWq92gS/GIHeGdeb5GZFyMFOcikLbTna1XNTW5fR9EnHzNTjHHL2iSAKyioJ6sSPEahk/j8lHH5gBSXPhxXlgNGZm0SMHyT8B3ym9JM6cTPUBKPnt0vn7WEI35y4gxfBtctfraa4QyPR18zYbsKt6d+vcIDsON0EFT2g/nI+CIN2cVXgmGZm+g8dq490SMtILCvt+XQTQ2EP6Hj5NeW++1YxYfy1rGnVUSyayc2RcR0L/ZaZrxWFlQ8lOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0Fu7oE8TgeWvbgjXO+OC6Ig3zgCZ2bXu2n+6sbJ/6U=;
 b=uQpUUj0QvFxoGVTWIB9lCOCzP5LYjYUQTLJ8A4ueQLK2GGu0gSmM4SF0djwOGmtcRdBJxdgXyhPg8RjrVdcQfYO1VLotWmQHbqrYeDVJnYLCUlLkid2uUAqHH07OrJzEsCzJ3iyGW0jxK4YMwm1e7G6tHPKl3R5nJB8YtmrolxU=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by TYZPR03MB7347.apcprd03.prod.outlook.com (2603:1096:400:423::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 09:52:07 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::faa3:6316:28ab:206b]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::faa3:6316:28ab:206b%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 09:52:07 +0000
From:   =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?utf-8?B?TmF0aGFuIEx1ICjlkYLmnbHpnJYp?= <Nathan.Lu@mediatek.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "fshao@chromium.org" <fshao@chromium.org>,
        "johnson.wang@mediatek.corp-partner.google.com" 
        <johnson.wang@mediatek.corp-partner.google.com>
Subject: Re: [PATCH v10 15/24] drm/mediatek: Remove ineffectual power
 management codes
Thread-Topic: [PATCH v10 15/24] drm/mediatek: Remove ineffectual power
 management codes
Thread-Index: AQHaAlEpjCqpdSIYNkmXJD+uq8dQA7BQ0swAgAAMZwA=
Date:   Thu, 19 Oct 2023 09:52:07 +0000
Message-ID: <2313a4b08f57ab24b48a13a31845eed7e0ab042d.camel@mediatek.com>
References: <20231019055619.19358-1-shawn.sung@mediatek.com>
         <20231019055619.19358-16-shawn.sung@mediatek.com>
         <5a059ca0-fcb7-4730-a0d8-29103fb71d54@collabora.com>
In-Reply-To: <5a059ca0-fcb7-4730-a0d8-29103fb71d54@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|TYZPR03MB7347:EE_
x-ms-office365-filtering-correlation-id: 895d9846-9b87-40ce-d83e-08dbd0890e54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wI5x0giA+/XlQh9XBAJadTk1t7hShsJSwYVh4ULUcLcUdLmPvDF/cQKYsH0phOV9p+vALSJmplb4whBLqeez/DzT8IHvC37ZPbSYKAK1Pt5EW4o9gWpt0hKyb+snt7gWY/opXaTcmu6D7ZR9B/+LZkDdf0xddDh1cqG5NJ5xn4mB/OQ8/tvg+aA9sPZxYk7fFrXTs+cokIotWLEBI3d3dA1Nfb3ZlX+dF76dssC+dpPe5YvIWzjekoX10uc9FV5sSys9KfCdwKtoaDHeayOgdseslWfklfBnoNENeMyuC0CdgPW7W+y2wpFmUGMZg79MthbBdJnu/mi0QayM5yLhECGmgmf8gGxEpWD9+kJOXZnuuqgqDduCN7Pl7pBGvMvIX1wjl1wma5bNbYfGJw1aWLf5EW1rg/8dLjwtWvxajLeBcVkNOxEIKg0mAc6OZ3wndbDB32SZQBNYdVtXsowThu0jJAXC8xsWNlJl4lgaWhfNr7Vuj3kFegXdhlkF4bSjDEhkgu1iiVIxHego18hdF5ptYmbohnlcLtUofLM2+Pd26n/i5FuB8YuPjfXrBlIe/CvgCXylCCl1NIizoO53VopFdBK+DjgLyBJaqcsnW2TglxyJ7WZkhN2HAGl42n1Xq4jrZ8Bp7kZ202tm3DxWdHaCCdouJYJcperR+TwbtOJVm7IcxEgy/Oxo12oxFmmG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(366004)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(478600001)(7416002)(4001150100001)(2906002)(6512007)(86362001)(2616005)(6506007)(110136005)(64756008)(76116006)(66556008)(71200400001)(91956017)(66446008)(6486002)(54906003)(66476007)(83380400001)(122000001)(66946007)(26005)(38070700005)(316002)(38100700002)(41300700001)(8936002)(36756003)(4326008)(5660300002)(85182001)(8676002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnRnemVIRkxZSlhwR05OVzNQbDlXc2dQTUxEOXJIWGkyLzBiUjZGcjc0cmNZ?=
 =?utf-8?B?REYvZ0lka05iTW5HZ3VpQTZJUUtqR1ltVS9pWWJnQ0JPZXJVcVhlUEdZQ3RU?=
 =?utf-8?B?dVFoSmJ3bTFBeUwwZkhtVGRiRnREb0F0NGFsbEsyY2MxTnRweVhiTFI2aWov?=
 =?utf-8?B?eVM5aXpZVWEwb1RuelBsNTlEazNEaUU5UUNBRXdOUW8wNDRSdkxDWUJwK01u?=
 =?utf-8?B?YVoyK01JdWJGV2owV09leFhNUVBJeWJXeVB4OTM3d0cwZzNKbjR4SzR4WDA2?=
 =?utf-8?B?ejkyMEs3aXJlNncxSGgzKzRhOTgrSzRqakUvOTE4b2kwMG5DdjA1QmxqQ2Vu?=
 =?utf-8?B?aFJEZzJwNDFpek12QzdqMmJkUmlkS25GUlRuWjhFS0UrTkd3VUVydUErK0dE?=
 =?utf-8?B?aHVzTmdud0VyMmtncDZBZW8xNnJzWFhaQkVURHBnc3daRnhHWjEwTWJaU0hl?=
 =?utf-8?B?ZTM4M1B2RzN0bUhUN0Q3SVNoSTdHUlJzT3NoNm5QTGg3K0ZzTUhubkM0Wk9x?=
 =?utf-8?B?TFFUQUtCZ3M4ZmoyUjVmb3VhV05QYlhJNitCTWtCVlpvYmFJKzVGaEZUNytR?=
 =?utf-8?B?WTRDRmtvcUJWL2lUa3JFQTNIb0t1RHIzbmNNV1EwUFZIeDRZaTNCYmh1WUVx?=
 =?utf-8?B?UzhaUm13bUhhNE9heTZoQzU4cUpZTjB6TVdjcm0xR1lYTEt5K1RWYStpOTlG?=
 =?utf-8?B?S3puM1FtS042bVNmb1dheVNhdkQ4MUZybUZtdy9kSzRnNjRiWUcweWpLNlBK?=
 =?utf-8?B?VmdTSVZNR0JhdTJaSHQyRTYxKzVsSVNHWDBtQjg4NzRJMHI5cUFKWkdRS2tp?=
 =?utf-8?B?MmtlcTZ2VzVuT1lHQVdreU5pd08zZ1QxQm1mc0FVTlJraWhNOFIvcVRQUEE0?=
 =?utf-8?B?R3JMVldlOVMyd084dzVCbE56SjU3cnpMMkpxeHRUM2k1b3U2bGtISHVZWGti?=
 =?utf-8?B?SFcvUVcyRFFKQ29TVlRmVmQzMmdiQTlkeWs2OGNZM1h0SnEvblFZYTFQZlBS?=
 =?utf-8?B?ejAzbk5PS04wbTNTbEs4b0NwUGJGRDlEYkUwQkVScGlRNE1UTjRUWmJBYnVo?=
 =?utf-8?B?MWlwTHRieG1pYmJqeFR4Um1lRlNZTzlUanBwbkVKaW1CcFR1OXVzSHhKOHBq?=
 =?utf-8?B?NEhxRHhxZnovY3U2S2p0czlYai92ZmRWSThxeGxFUDVFaTd0RFRTRFA3bk84?=
 =?utf-8?B?Qy82aGl1aEcrekwxK1BZVXp2TC8vNi9Mc1hwUWVMRVhXZENBWTh3QVVtYkt2?=
 =?utf-8?B?UlUrdWFKR0dkM2t1K2FRV3owRmc1dGxYYy9GTHhDcFlMRjZFbDYweUNaYTdC?=
 =?utf-8?B?SDYvei9GcnlhQitVdUZyNENKc0t2eWYvaXQ3VkV3UkFoZHdhZ1UrcHhnaDFV?=
 =?utf-8?B?ZzVsTjJOTUdhTXlHRlZTZnNPcVQ4RXNKNVZPZElIUHJjVEljcHBxNWhYMW5G?=
 =?utf-8?B?T1lYVzkyalh6RjgreEpLSTZkUFhvbWZjUDFUcWRnVDgwWTdXUW9nOHpFbVhF?=
 =?utf-8?B?dTVNVEY1bG9YMGdVdmc3eXAybUNVR1dacmpIN0dpT1FGbnRacnZFd2NuTlhQ?=
 =?utf-8?B?US9pblJwZDVSTjN0Q2N2NWdkSER6b285Q3lvMTdRYzhOeVYxcEZWN0tsM0kz?=
 =?utf-8?B?anQ5OC9sVEM5aHRRTVpHZ3kyT0pIaG9oMi80MDZNb1R0b3kzS0tPNnlMbWF5?=
 =?utf-8?B?VW91VlRRRHd3S3Mzdi92VytGVXJISFNlUUYrOE0zbVNPWGNSdVlPRjlrS09I?=
 =?utf-8?B?WXlMbWZ6bUl5cDNyQ3ZNQzZSWmJuc0lKTERRWThNZU8za3E2cU1VT0toeEhM?=
 =?utf-8?B?SGxYbkdBK3ozdTk1am1zSFJKQ0RMNE1mZ1Y0eXFENnFjV0dMTHdqVXNKclJS?=
 =?utf-8?B?TTZjQ1p3RlY5d1RaS1FFbHIvbEVycUFSRkgyQ0lqZkMrRWU2MzRlSko1c2Zu?=
 =?utf-8?B?TGdjcHIzdUtJeWVxT1lmYjlueW1aQjBwdkNmbEQ1YlZMTU5MTXpXcDJPTEhD?=
 =?utf-8?B?dENRV05mcndKaWxQTUticzAxSms5a2pJcmZ4RWRzME9IcktnZ2VKRWx2bmhJ?=
 =?utf-8?B?Q2V5VXRhZkxvVjZMUWgwZGZDb1RUVFRFNGtsS0h1V2tlWjlCbGZpV1BwSXF0?=
 =?utf-8?B?MkxpdFRWSGYxdmpFSlRCcGFxTEdGOVJvTFdDRU4wOXJWR241aFJxZVNrRjE0?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <222B7A64405E0E438C229103152B8DDB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 895d9846-9b87-40ce-d83e-08dbd0890e54
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 09:52:07.2536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j86Xlhg6/55a2ecfsbuZ9FOP3B6IX5lLWKM/kQQ9gQadL3BzmnNPeOgtcYDbd6xAXKZQakS/4n65Ghik7BlX0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7347
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,TVD_SUBJ_WIPE_DEBT,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpPbiBUaHUsIDIwMjMtMTAtMTkgYXQgMTE6MDcgKzAyMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAxOS8xMC8yMyAwNzo1NiwgSHNpYW8gQ2hp
ZW4gU3VuZyBoYSBzY3JpdHRvOg0KPiA+IERpc3BsYXkgbW9kdWxlcyB3aWxsIGJlIHBvd2VyZWQg
b24gd2hlbiAuYXRvbWljX2VuYWJsZSgpLA0KPiA+IHRoZXJlIGlzIG5vIG5lZWQgdG8gZG8gaXQg
YWdhaW4gaW4gbXRrX2NydGNfZGRwX2h3X2luaXQoKS4NCj4gPiBCZXNpZGVzLCB0aGUgRFJNIGRl
dmljZXMgYXJlIGNyZWF0ZWQgbWFudWFsbHkgd2hlbiBtdGstbW1zeXMNCj4gPiBpcyBwcm9iZWQg
YW5kIHRoZXJlIGlzIG5vIHBvd2VyIGRvbWFpbiBsaW5rZWQgdG8gaXQuDQo+ID4gDQo+ID4gRml4
ZXM6IDExOWY1MTczNjI4YSAoImRybS9tZWRpYXRlazogQWRkIERSTSBEcml2ZXIgZm9yIE1lZGlh
dGVrIFNvQw0KPiA+IE1UODE3My4iKQ0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEhzaWFvIENo
aWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jIHwgMTggKysrLS0tLS0tLS0tLS0tLS0t
DQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkN
Cj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
Y3J0Yy5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4g
PiBpbmRleCBiYzRjYzc1Y2NhMTguLmM3ZWRkODBiZTQyOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gPiBAQCAtNiw3ICs2LDYgQEANCj4gPiAg
ICNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gPiAgICNpbmNsdWRlIDxsaW51eC9kbWEtbWFwcGlu
Zy5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L21haWxib3hfY29udHJvbGxlci5oPg0KPiA+IC0j
aW5jbHVkZSA8bGludXgvcG1fcnVudGltZS5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L3NvYy9t
ZWRpYXRlay9tdGstY21kcS5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L3NvYy9tZWRpYXRlay9t
dGstbW1zeXMuaD4NCj4gPiAgICNpbmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsvbXRrLW11dGV4
Lmg+DQo+ID4gQEAgLTM2MiwyMiArMzYxLDE2IEBAIHN0YXRpYyBpbnQgbXRrX2NydGNfZGRwX2h3
X2luaXQoc3RydWN0DQo+ID4gbXRrX2RybV9jcnRjICptdGtfY3J0Yywgc3RydWN0IGRybV9hdG9t
aWMNCj4gPiAgIAkJZHJtX2Nvbm5lY3Rvcl9saXN0X2l0ZXJfZW5kKCZjb25uX2l0ZXIpOw0KPiA+
ICAgCX0NCj4gPiAgIA0KPiA+IC0JcmV0ID0gcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldChjcnRj
LT5kZXYtPmRldik7DQo+ID4gLQlpZiAocmV0IDwgMCkgew0KPiA+IC0JCURSTV9FUlJPUigiRmFp
bGVkIHRvIGVuYWJsZSBwb3dlciBkb21haW46ICVkXG4iLCByZXQpOw0KPiA+IC0JCXJldHVybiBy
ZXQ7DQo+ID4gLQl9DQo+ID4gLQ0KPiANCj4gQXJlIHlvdSByZWFsbHkgc3VyZSB0aGF0IHdyaXRl
cyB0byBESVNQX1JFR19PVkxfeHh4IGFuZCBvdGhlcnMgaW4NCj4gb3RoZXIgbW9kdWxlcywNCj4g
Y2FsbGVkIGJ5IHRoZSAubGF5ZXJfY29uZmlnKCkgY2FsbGJhY2ssIGNhbiBiZSBzdWNjZXNzZnVs
bHkgZG9uZSBvbg0KPiBhbiB1bnBvd2VyZWQNCj4gYW5kL29yIHVuY2xvY2tlZCBtb2R1bGUsIG9u
IGFsbCBNZWRpYVRlayBTb0NzPw0KPiBUaGlzIGxvb2tzIGEgYml0IG9kZC4NCg0KTm90IHN1cmUg
aWYgSSBnZXQgeW91ciBwb2ludCBjb3JyZWN0bHkuIFdlIHJlbW92ZWQgdGhpcyBQTSBBUEkgYmVj
YXVzZToNCg0KMS4gbXRrX2NydGNfZGRwX2h3X2luaXQoKSBpcyBjYWxsZWQgYnkgbXRrX2RybV9j
cnRjX2F0b21pY19lbmFibGUoKSwNCmFuZCB0aGUgbmV3IGlubGluZSBmdW5jdGlvbiBtdGtfZGRw
X2NvbXBfcG93ZXJfb24oKSBpcyBjYWxsZWQgYmVmb3JlIGh3DQppbml0LCB3ZSBjYW4gbWFrZSBz
dXJlIHRoZSBwb3dlciBpcyBvbiBiZWZvcmUgY29uZmlndXJpbmcgdGhlIGhhcmR3YXJlLg0KDQoy
LiBUaGUgZGV2aWNlICJjcnRjLT5kZXYtPmRldiIgaGVyZSBpcyBhc3NpZ25lZCBieSB0aGUgcHJv
YmUgZnVuY3Rpb24NCm9mIG10ay1tbXN5cywgd2hpY2ggd2lsbCBiZSBsb29rIGxpa2UgIm1lZGlh
dGVrLWRybS5hdXRvLjEzIiwgYW5kIHRoaXMNCmRldmljZSBpcyBub3QgbGlua2VkIHRvIGFueSBw
b3dlciBkb21haW4uDQoNCj4gDQo+ID4gICAJcmV0ID0gbXRrX211dGV4X3ByZXBhcmUobXRrX2Ny
dGMtPm11dGV4KTsNCj4gPiAgIAlpZiAocmV0IDwgMCkgew0KPiA+ICAgCQlEUk1fRVJST1IoIkZh
aWxlZCB0byBlbmFibGUgbXV0ZXggY2xvY2s6ICVkXG4iLCByZXQpOw0KPiA+IC0JCWdvdG8gZXJy
X3BtX3J1bnRpbWVfcHV0Ow0KPiA+ICsJCWdvdG8gZXJyb3I7DQo+ID4gICAJfQ0KPiA+ICAgDQo+
ID4gICAJcmV0ID0gbXRrX2NydGNfZGRwX2Nsa19lbmFibGUobXRrX2NydGMpOw0KPiA+ICAgCWlm
IChyZXQgPCAwKSB7DQo+ID4gICAJCURSTV9FUlJPUigiRmFpbGVkIHRvIGVuYWJsZSBjb21wb25l
bnQgY2xvY2tzOiAlZFxuIiwNCj4gPiByZXQpOw0KPiA+IC0JCWdvdG8gZXJyX211dGV4X3VucHJl
cGFyZTsNCj4gPiArCQlnb3RvIGVycm9yOw0KPiA+ICAgCX0NCj4gPiAgIA0KPiA+ICAgCWZvciAo
aSA9IDA7IGkgPCBtdGtfY3J0Yy0+ZGRwX2NvbXBfbnIgLSAxOyBpKyspIHsNCj4gPiBAQCAtNDI2
LDE2ICs0MTksMTMgQEAgc3RhdGljIGludCBtdGtfY3J0Y19kZHBfaHdfaW5pdChzdHJ1Y3QNCj4g
PiBtdGtfZHJtX2NydGMgKm10a19jcnRjLCBzdHJ1Y3QgZHJtX2F0b21pYw0KPiA+ICAgDQo+IA0K
PiAuLi5iZWNhdXNlIHlvdSBjb3VsZCBvdGhlcndpc2UganVzdCBjYWxsIHBtX3J1bnRpbWVfcHV0
KCkgaGVyZSwNCj4gaW5zdGVhZCBvZiByZW1vdmluZw0KPiB0aGUgcG1fcnVudGltZV9yZXN1bWVf
YW5kX2dldCgpIGNhbGwsIHdoaWNoIGlzIHNvbWV0aGluZyBJIHdvdWxkDQo+IGFkdmlzZSB0byBk
by4NCj4gDQo+IFJlZ2FyZHMsDQo+IEFuZ2Vsbw0KPiANCg0KVGhhbmtzLA0KU2hhd24NCg==

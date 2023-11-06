Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CCB7E19C4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 06:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjKFFzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 00:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFFzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 00:55:18 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362B7FA
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 21:55:14 -0800 (PST)
X-UUID: 09cfb3fc7c6911eea33bb35ae8d461a2-20231106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=C661ymO+LrleHWRhwXEpIXVbYDM7UubP8ldNED+4/bQ=;
        b=QAbCR9cv8GyEZb+OBKh6o9Vc2AhXk15V4W9QDSYA+GrmLJ3k+9v7iYR+r4QOWM9cSrDxWPgKbYnrm2+M8rHU7Oriu6DB/jqGT8GlCyzQ4ZhZARUNDNv9oxJUbNsSh7EN3cLsa/WJzJEuxbDW52JfDfmOkknmIbasS8kQTARsI98=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:efc629da-87a0-403d-bc00-99a2b92fe055,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:c31331fc-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 09cfb3fc7c6911eea33bb35ae8d461a2-20231106
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1534477595; Mon, 06 Nov 2023 13:55:07 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 6 Nov 2023 13:55:05 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 6 Nov 2023 13:55:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fuy4r13OB+QOmhQZbTkTtn84betcmbHVtDVfox0rd1gAc/NXMyMqlZG6w4Dhi5XPCyWqbc00LZ/S24GseaLBk6PJbvIDNLT0uFhtGkNdyezwJjJI7M8JEH4kxjB/A9vn09F+AAHnn3Vk/c860/pUgZu8W94FlLFr85XJ9r9XpBelVaOILJ5jy5WZy+qrOwyOpibwhZ3YPolcG4K+bToifHplJeOcvW/lwqUHqkb1VAfr8JGCSNppCY+euhObZULC19Ph04e+Nj4Kz7TrWeJF3qs/AgDh2bI3rKbriNLGKCbs0k1ikDFP4CnOCFyNlzHSsozTksfVcYAwmrGy5xTI6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C661ymO+LrleHWRhwXEpIXVbYDM7UubP8ldNED+4/bQ=;
 b=Fgn7nAq1y6FMe8xAATi1m/lKnPkYzdswS8fp+30WDG9O6a9af7zq6AuM1vB8smChCj2wrCvses2EtnNop4AetCQnMnzO0TchYha2fOgbRBE0nhHUthlwx16AcNXCs+q6BPHASnhm7N0zeKFq0Osc54WbMxcUN/OCDnUdUEp6Zs5FFahJmGFGjfURB5tM8DSAt/Zt7erTXvhcPEpNWMYriLV628uOz8fKiS7cY2QLthtcg+yY4FfVLto9CxV+SFaf0jj8HTJebpbipDbOykiFn3UrqXA0bK8Pm5jkLW2944syvETB4KW2+SkbQTC7WDlsV3MXjzhfJ5AQWToxzwnVgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C661ymO+LrleHWRhwXEpIXVbYDM7UubP8ldNED+4/bQ=;
 b=uBsPGtjJsGvr2Oi8OxVuRC+X61P13xRLry3R4fvSnqHgr0aCZTdtPgE0I9qWWBBt50RDgFH88VhSfIxgnrDfQXnk7gPANJUITrBEIvqIPQT41DdMK/FqX+EEsFNnxttu4mTIRhK4twOuUp7l7PZ4fAt01covUH4fhlVeZ59UfXE=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PUZPR03MB5795.apcprd03.prod.outlook.com (2603:1096:301:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 05:55:03 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a4e1:1557:a3fe:c252]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a4e1:1557:a3fe:c252%4]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 05:55:02 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "seanpaul@chromium.org" <seanpaul@chromium.org>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 1/1] drm/mediatek: Fix errors when reporting rotation
 capability
Thread-Topic: [PATCH v2 1/1] drm/mediatek: Fix errors when reporting rotation
 capability
Thread-Index: AQHaCxACOCOGLMbHOkeXdljk6ddPUbBs1XAA
Date:   Mon, 6 Nov 2023 05:55:02 +0000
Message-ID: <b84d3f321bd329dc862cb03cb35a922dbc4793a3.camel@mediatek.com>
References: <20231030090312.7758-1-shawn.sung@mediatek.com>
         <20231030090312.7758-2-shawn.sung@mediatek.com>
In-Reply-To: <20231030090312.7758-2-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PUZPR03MB5795:EE_
x-ms-office365-filtering-correlation-id: 409b3d12-f10e-4729-a7bb-08dbde8ceb57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pljT8IUO8GTcBfFpgQYOXacEfSlkDyZD6ynFD9YYesf5cFyHw2e4OEWFHWEd0ErTvCXqXK9UXYDaOEdarKLEp95nMRxzb6M720hmcdAl72Iev1eQf/Xi65oCGy7+1tO62zV0Z+4c5rQtZ1vy+0aXOmzkIoOOxAUxM+vmR2tfbNe0STYHMRgTmm/VlsRyBtGhGtSVqQAFebsgD8ZPMTYt3gu6ogbTP/SXGuJWPz8RtC9ZFq66rFqXW1Uy3lgANlwygx9aZasAcscQm+XGRE6XjvgeJJEgF6arBGL1x2Ho53XZn69pmLwDiIl/KH0PV9rVxRfSnyqfTy64C4hRO8ftGNDhD2SAjaz1klJixY/Pg7/ZpPHNmzgsw9uIWBJ6O744S0x/Ma3P7wvNDtW76p6hzMAqoUcYJEx0BckxzTaauHmb/7LkotaZlO7LpBofTqXz4XIOa3RB+Xw7FiB4rvFntqFAYtngjWRkHzejuVHV2ycZF2r+JIxzE2af++JLmVQPXhGBaAy8q72aH1yrhTZBhOI2XiULy5PRt0B+Ihk/AMyYbmPVEtnyLez1SDiZCRnie5uN5UKW3KVnreAkqGThujs03wg8wwXlev+MF+T80yALbHYlvTOBBXDomcOhR/QbFioECtgQdOo6yqYGIQPiPTyoOIItmkTrhhb1IVC1iXc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39860400002)(136003)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(2616005)(6512007)(6506007)(71200400001)(478600001)(6486002)(4001150100001)(38100700002)(36756003)(85182001)(122000001)(86362001)(66476007)(66946007)(76116006)(66556008)(7416002)(66446008)(41300700001)(83380400001)(2906002)(5660300002)(26005)(64756008)(38070700009)(4326008)(110136005)(316002)(8936002)(54906003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGNCQjUwY2EzS2szYXk5RUZLRm9OeHR2ditmRTZLRjNXdXNPemNuRkFUTStT?=
 =?utf-8?B?Z2VjdXRjVUFIazQybkN3Z2NpMjNNZWZ0Q1NGeVZ6ekIvaVoycUExVWpqN0ZX?=
 =?utf-8?B?bCtQdldiMTBzSllDUzBRN294Nld2R0xEYkltOTBLL3dXbURRWlZtSnIwbzQv?=
 =?utf-8?B?dWdZRUF6YlhUQ25zYmNweFIzNndvQ1l5V1pPc2hvaWFXOEdGemJ2RUhuL2d0?=
 =?utf-8?B?N2ZFb2U5R2VWUllrNkhhT1hLeEJKWlV2ZzkzeDcvN0JWRE1sckFJbFlodW1C?=
 =?utf-8?B?ejNCUS9uVVJiUU5GbGIrUHczUkpLS1h6N2FJazZuWWpyaHRuZkhNZ0tOZzZV?=
 =?utf-8?B?QVcyMWoyWEltSUdtVVRndlFXc3VhRytTSk1BVldvU0djcS9sWjdRRHlFS0Jn?=
 =?utf-8?B?dXdmNU54b2RXemZ2ZklEZXBzd05mQU9sd2pzb1crL05ZTmtxODQyMi9BYVRx?=
 =?utf-8?B?c1hybmJyc1dMSFovNGx2N0VjL2kxd2JWRHRoclhTdENNRGp3SUN0aUtXK1Qz?=
 =?utf-8?B?ZXN6bTVxZ2pLdGxVMDg5Mi9XOTVWMFZyNzM4UzVkaUpOMmZ3YU1iZkF5Y2FE?=
 =?utf-8?B?WjRsVkl2d21NbmxrZlZCc2JJdkhWbWUwVTBJU00rZ2E5dWY1amdzeGlGUHJ0?=
 =?utf-8?B?Ty9mS0p2cFVLb3VYR1pVNTNrbUxNb1VKT1FuRHIwOWJlN3hNN09Cd0JHenFH?=
 =?utf-8?B?b3ptaXRldXZUV2hpSEwwTkZ0RFFObnRNMUllUDNLTzNDakJZQWF4bU8yajlR?=
 =?utf-8?B?enVieDNnK3hDVEdzbXBnaThxTVUzL3Fab0ZLSDMwbXR5UkUwTUFZeVYwSDJw?=
 =?utf-8?B?YURUeG5XMGZYeWZPc2YySTVQSyt4REhmZ3YvYXltVzFabDBYV0oxTTB3Y2lB?=
 =?utf-8?B?NmxRbkx2NE9MOG9MRDd2aW80bzl6STNnLy9aandqeTNHU1pLWUNvdUFhL21h?=
 =?utf-8?B?Y3VpSFFCYU92bjROSzZCZnAzb29UYzJleEZWa2U0ZHdCWlRYZnhuaWtEblRP?=
 =?utf-8?B?LzRweDNiRE1QY0k3RW9oZU1BSWg5ODNqY0ZnQlRqNTFWdVkyQ2hncHQzMk11?=
 =?utf-8?B?NHRvTjkxRmY2V0M5S3BKUjVHTjVLVHhYMXVRVUs0QnI4OEZzUGhEVmJaYVlr?=
 =?utf-8?B?dUNWS3lucWxmbW9ZUGhCVlh1aFVyaDluZEo2RkdNM2VBZnFlbXg3cjdVQzQy?=
 =?utf-8?B?aGhxQVR3TUJ1bzhIektsRFdwM2VoWmpwWHJ0QS9HWU02ZFViQnZGaDB3c05P?=
 =?utf-8?B?d1NNdXNKV3A0VDBFdEUyRWpLUDBZblNYTlRRWkJYQlUxeDVaZmpwaU9DNDNN?=
 =?utf-8?B?OGR1bnJRbUtNbDZ4NldMZ0ZjWERFalhLWW1EWndtNTFJWXFVQThmR0dlT0p2?=
 =?utf-8?B?dUdNY1JrdytDUXVCMm5hdTVFTjcrdXdBTGZLRVpRU0tmSHgxdDh2WDBOeDdI?=
 =?utf-8?B?ZmlvY0hic0hCTDRKcXhScGZzSkx1ZDJJNWNRa0RuUk1RRDhYWVJiQ29YaXNV?=
 =?utf-8?B?TnFVYlJhUU0vWEpFLytwaEVzakNXZ29HZzQzMnZ0ejR4YkVEeXFaVjlwMTJ2?=
 =?utf-8?B?NGRVdUgwcXkycHpta1ZycjNEcERBUUtBNlk1N0tubE1XYkVhYWFJTHlXYjl1?=
 =?utf-8?B?NGZDRWRIZWZDYTJIM1FSb2tyRUcrUUpXeXlNQnNQUGwxM3FqVG1Sd0tJcDBQ?=
 =?utf-8?B?MW9hLzh4aWRJaXhNaDNrTVhhYUxhcGg2VlNtQVBDZHpWUTRIRDZ4d2VIRU9r?=
 =?utf-8?B?Y3lyU09jdjM2bkprQmF0aVdCa3RCdGlRTkQ2WVNkWDRxb2JVR1JIeWlCaytE?=
 =?utf-8?B?ZlNDQm9sYU9mSERuWmRQWXkzMFNjdDRYOGdmYmNNbWpiWkUveDYxb1E1c0ZW?=
 =?utf-8?B?eHNBdWdGaXFiZHlMUk1PVC9URmV5N0VXWHFZRThuQlJ0djdLQlhaZDhwVGJX?=
 =?utf-8?B?M24xRk45OG1IaVZxZ1FSeUJZTTZBU3VDOGwzaFFtUEU1by9sSWhxRXBHbW1T?=
 =?utf-8?B?WENRLzBab3JpZEwwcDViZHkxdFZ3OFVZYVN6UnE2TEtaOU8zRVQ2ZlowRDRF?=
 =?utf-8?B?SDF2ZlZxcDVqbEtYTHdtVGJldkpraEpaQVhCWnlZWTZsMW5FZkMyWDZtMEFW?=
 =?utf-8?Q?Zs83Kl8Tc1bZVpUbHX2sbhr4n?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45F46A83F22E3E4C9628958F99166E36@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 409b3d12-f10e-4729-a7bb-08dbde8ceb57
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 05:55:02.8122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 54Hj1J9c5uEhW0nJV5Nj9BWiQL4ffc2/jKhprzNpdYoUVJWSRXR3qvJvGmPBeCLaXfS8X6S1JpVfeO8nJYDX3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB5795
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.081600-8.000000
X-TMASE-MatchedRID: +f/wAVSGjug/XHdICuW5r97SWiiWSV/1jLOy13Cgb4+qvcIF1TcLYIc7
        DaU6vSPuNqe1jtjlcxuI3RIJncZL26BW2ZrFVYNRw2taljzThMa4vBuE2X0HlQZbeEWcL03Vv9+
        RvGSUdYAth7GMj8XazirBAKDt/mqTAM0/G7XUdeMflhDI6DvVlvngX/aL8PCNfmHrLgoJIlzt8r
        FozbGqQHeH2KM+kAtW+1tZnc7Ku7cS3pAGY8tVrcu00lnG8+PWMZpQS7dE0dZH8NYKoXhEyztCa
        zcALtq7VDipNlcc0iekJpAbNH+cOwqW6Ww5ww4PkDpLRKO9xhRqHor8BcyxBpsoi2XrUn/J+ZL5
        o+vRV7yhMIDkR/KfwI2j49Ftap9EOwBXM346/+wJpQD9r2bCjBradwfY01G5cNT9dJpC2rQxD5X
        Ly2i3OB+LRyETT/BN
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.081600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 2B7ADC3DC7E19112AC11A5D2E450D7CA173B076CBD58C63E0CE934734B24AA992000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBNb24sIDIwMjMtMTAtMzAgYXQgMTc6MDMgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IEZvciBDUlRDcyB0aGF0IGRvZXNuJ3Qgc3VwcG9ydCBy
b3RhdGlvbiBzaG91bGQgc3RpbGwgcmV0dXJuDQo+IERSTV9NT0RFX1JPVEFURV8wLiBSZXR1cm5z
IGhhcmR3YXJlIGNhcGFiaWxpdGllcyBhY2NvcmRpbmdseS4NCg0KVGhlIG9yaWdpbmFsIGNvZGUg
d291bGQgbm90IGNhbGwgZHJtX3BsYW5lX2NyZWF0ZV9yb3RhdGlvbl9wcm9wZXJ0eSgpDQp0byBj
cmVhdGUgcm90YXRpb24gcHJvcGVydHkgaWYgQ1JUQyBkb2VzIG5vdCBzdXBwb3J0IHJvdGF0aW9u
LiBJIHRoaW5rDQp0aGlzIGJlaGF2aW9yIGlzIE9LIGJlY2F1c2Ugbm90IGFsbCBkcm0gZHJpdmVy
IGNhbGwNCmRybV9wbGFuZV9jcmVhdGVfcm90YXRpb25fcHJvcGVydHkoKSBhbmQgaXQgd29ya3Mu
IFNvIG92bCBhZGFwdG9yIGlzDQpub3QgbmVjZXNzYXJ5IHRvIGltcGxlbWVudCBzdXBwb3J0ZWRf
cm90YXRpb25zKCkgY2FsbGJhY2sgZnVuY3Rpb24uIElmDQpzb21lIE9WTCBkb2VzIG5vdCBzdXBw
b3J0IHJvdGF0aW9uLCB5b3UgY291bGQgcmV0dXJuIDAgZGlyZWN0bHkuDQoNClJlZ2FyZHMsDQpD
Sw0KDQo+IA0KPiBGaXhlczogODRkODA1NzUzOTgzICgiZHJtL21lZGlhdGVrOiBTdXBwb3J0IHJl
ZmxlY3QteSBwbGFuZQ0KPiByb3RhdGlvbiIpDQo+IA0KPiBSZXZpZXdlZC1ieTogQW5nZWxvR2lv
YWNjaGlubyBEZWwgUmVnbm8gPA0KPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9y
YS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVk
aWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9k
cnYuaCAgICAgICB8ICAxICsNCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9v
dmwuYyAgICAgICB8IDMwICsrKysrKysrKystLS0tLS0tDQo+IC0tDQo+ICAuLi4vZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jICAgfCAgNSArKysrDQo+ICBkcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jICAgfCAgMSArDQo+ICBkcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jICAgICAgfCAgMiArLQ0KPiAgNSBmaWxlcyBj
aGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gaW5kZXggNGQ2ZThiNjY3YmMzLi5j
NWFmZWI3YzU1MjcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZGlzcF9kcnYuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2
LmgNCj4gQEAgLTEyNyw2ICsxMjcsNyBAQCB2b2lkIG10a19vdmxfYWRhcHRvcl9yZWdpc3Rlcl92
YmxhbmtfY2Ioc3RydWN0DQo+IGRldmljZSAqZGV2LCB2b2lkICgqdmJsYW5rX2NiKSh2bw0KPiAg
dm9pZCBtdGtfb3ZsX2FkYXB0b3JfdW5yZWdpc3Rlcl92YmxhbmtfY2Ioc3RydWN0IGRldmljZSAq
ZGV2KTsNCj4gIHZvaWQgbXRrX292bF9hZGFwdG9yX2VuYWJsZV92Ymxhbmsoc3RydWN0IGRldmlj
ZSAqZGV2KTsNCj4gIHZvaWQgbXRrX292bF9hZGFwdG9yX2Rpc2FibGVfdmJsYW5rKHN0cnVjdCBk
ZXZpY2UgKmRldik7DQo+ICt1bnNpZ25lZCBpbnQgbXRrX292bF9hZGFwdG9yX3N1cHBvcnRlZF9y
b3RhdGlvbnMoc3RydWN0IGRldmljZQ0KPiAqZGV2KTsNCj4gIHZvaWQgbXRrX292bF9hZGFwdG9y
X3N0YXJ0KHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICB2b2lkIG10a19vdmxfYWRhcHRvcl9zdG9w
KHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICB1bnNpZ25lZCBpbnQgbXRrX292bF9hZGFwdG9yX2xh
eWVyX25yKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2Rpc3Bfb3ZsLmMNCj4gaW5kZXggZWNjMzg5MzJmZDQ0Li5iY2E3YjJmNGIxZDkgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gQEAgLTE3Nyw2ICsx
NzcsNyBAQCBzdGF0aWMgY29uc3QgdTMyIG10ODE5NV9vdmxfY3JjX29mc1tdID0gew0KPiAgICog
QHN1cHBvcnRzX2NscmZtdF9leHQ6IHdoZXRoZXIgdGhlIG92bCBzdXBwb3J0cyBjbGVhciBmb3Jt
YXQgKGZvcg0KPiBhbHBoYSBibGVuZCkNCj4gICAqIEBjcmNfb2ZzOiBjcmMgb2Zmc2V0IHRhYmxl
DQo+ICAgKiBAY3JjX2NudDogY291bnQgb2YgY3JjIHJlZ2lzdGVycyAoY291bGQgYmUgbW9yZSB0
aGFuIG9uZSBiYW5rKQ0KPiArICogQHJvdGF0aW9uczogc3VwcG9ydGVkIHJvdGF0aW9ucw0KPiAg
ICovDQo+ICBzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsX2RhdGEgew0KPiAgCXVuc2lnbmVkIGludCBhZGRy
Ow0KPiBAQCAtMTkwLDYgKzE5MSw3IEBAIHN0cnVjdCBtdGtfZGlzcF9vdmxfZGF0YSB7DQo+ICAJ
Ym9vbCBzdXBwb3J0c19jbHJmbXRfZXh0Ow0KPiAgCWNvbnN0IHUzMiAqY3JjX29mczsNCj4gIAlz
aXplX3QgY3JjX2NudDsNCj4gKwl1bnNpZ25lZCBpbnQgcm90YXRpb25zOw0KPiAgfTsNCj4gIA0K
PiAgLyoqDQo+IEBAIC00MTUsMzUgKzQxNywyNiBAQCB1bnNpZ25lZCBpbnQgbXRrX292bF9sYXll
cl9ucihzdHJ1Y3QgZGV2aWNlDQo+ICpkZXYpDQo+ICANCj4gIHVuc2lnbmVkIGludCBtdGtfb3Zs
X3N1cHBvcnRlZF9yb3RhdGlvbnMoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgew0KPiAtCXJldHVy
biBEUk1fTU9ERV9ST1RBVEVfMCB8IERSTV9NT0RFX1JPVEFURV8xODAgfA0KPiAtCSAgICAgICBE
Uk1fTU9ERV9SRUZMRUNUX1ggfCBEUk1fTU9ERV9SRUZMRUNUX1k7DQo+ICsJc3RydWN0IG10a19k
aXNwX292bCAqb3ZsID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICsNCj4gKwlyZXR1cm4gb3Zs
LT5kYXRhLT5yb3RhdGlvbnMgPzogRFJNX01PREVfUk9UQVRFXzA7DQo+ICB9DQo+ICANCj4gIGlu
dCBtdGtfb3ZsX2xheWVyX2NoZWNrKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IGlk
eCwNCj4gIAkJCXN0cnVjdCBtdGtfcGxhbmVfc3RhdGUgKm10a19zdGF0ZSkNCj4gIHsNCj4gIAlz
dHJ1Y3QgZHJtX3BsYW5lX3N0YXRlICpzdGF0ZSA9ICZtdGtfc3RhdGUtPmJhc2U7DQo+IC0JdW5z
aWduZWQgaW50IHJvdGF0aW9uID0gMDsNCj4gIA0KPiAtCXJvdGF0aW9uID0gZHJtX3JvdGF0aW9u
X3NpbXBsaWZ5KHN0YXRlLT5yb3RhdGlvbiwNCj4gLQkJCQkJIERSTV9NT0RFX1JPVEFURV8wIHwN
Cj4gLQkJCQkJIERSTV9NT0RFX1JFRkxFQ1RfWCB8DQo+IC0JCQkJCSBEUk1fTU9ERV9SRUZMRUNU
X1kpOw0KPiAtCXJvdGF0aW9uICY9IH5EUk1fTU9ERV9ST1RBVEVfMDsNCj4gLQ0KPiAtCS8qIFdl
IGNhbiBvbmx5IGRvIHJlZmxlY3Rpb24sIG5vdCByb3RhdGlvbiAqLw0KPiAtCWlmICgocm90YXRp
b24gJiBEUk1fTU9ERV9ST1RBVEVfTUFTSykgIT0gMCkNCj4gKwlpZiAoc3RhdGUtPnJvdGF0aW9u
ICYgfm10a19vdmxfc3VwcG9ydGVkX3JvdGF0aW9ucyhkZXYpKQ0KPiAgCQlyZXR1cm4gLUVJTlZB
TDsNCj4gIA0KPiAgCS8qDQo+ICAJICogVE9ETzogUm90YXRpbmcvcmVmbGVjdGluZyBZVVYgYnVm
ZmVycyBpcyBub3Qgc3VwcG9ydGVkIGF0DQo+IHRoaXMgdGltZS4NCj4gIAkgKgkgT25seSBSR0Jb
QVhdIHZhcmlhbnRzIGFyZSBzdXBwb3J0ZWQuDQo+ICAJICovDQo+IC0JaWYgKHN0YXRlLT5mYi0+
Zm9ybWF0LT5pc195dXYgJiYgcm90YXRpb24gIT0gMCkNCj4gKwlpZiAoc3RhdGUtPmZiLT5mb3Jt
YXQtPmlzX3l1diAmJiAoc3RhdGUtPnJvdGF0aW9uICYNCj4gfkRSTV9NT0RFX1JPVEFURV8wKSkN
Cj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+ICANCj4gLQlzdGF0ZS0+cm90YXRpb24gPSByb3RhdGlv
bjsNCj4gLQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+IEBAIC04ODMsNiArODc2LDE1IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsX2RhdGENCj4gbXQ4MTk1X292bF9kcml2
ZXJfZGF0YSA9IHsNCj4gIAkuc3VwcG9ydHNfY2xyZm10X2V4dCA9IHRydWUsDQo+ICAJLmNyY19v
ZnMgPSBtdDgxOTVfb3ZsX2NyY19vZnMsDQo+ICAJLmNyY19jbnQgPSBBUlJBWV9TSVpFKG10ODE5
NV9vdmxfY3JjX29mcyksDQo+ICsNCj4gKwkvKg0KPiArCSAqIGFsdGhvdWdoIE9WTCBvbmx5IHN1
cHBvcnRzIHJlZmxlY3Rpb25zIG9uIE1UODE5NSwNCj4gKwkgKiByZWZsZWN0IHggKyByZWZsZWN0
IHkgPSByb3RhdGUgMTgwDQo+ICsJICovDQo+ICsJLnJvdGF0aW9ucyA9IERSTV9NT0RFX1JPVEFU
RV8wICAgfA0KPiArCQkgICAgIERSTV9NT0RFX1JPVEFURV8xODAgfA0KPiArCQkgICAgIERSTV9N
T0RFX1JFRkxFQ1RfWCAgfA0KPiArCQkgICAgIERSTV9NT0RFX1JFRkxFQ1RfWSwNCj4gIH07DQo+
ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19kaXNwX292bF9kcml2
ZXJfZHRfbWF0Y2hbXSA9IHsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kaXNwX292bF9hZGFwdG9yLmMNCj4gaW5kZXggNDM5OGRiOWE2Mjc2Li5iMGQzZWJkYmE5M2Eg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRh
cHRvci5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRh
cHRvci5jDQo+IEBAIC0zODMsNiArMzgzLDExIEBAIHZvaWQgbXRrX292bF9hZGFwdG9yX3JlZ2lz
dGVyX3ZibGFua19jYihzdHJ1Y3QNCj4gZGV2aWNlICpkZXYsIHZvaWQgKCp2YmxhbmtfY2IpKHZv
DQo+ICAJCQkJICAgICB2YmxhbmtfY2IsIHZibGFua19jYl9kYXRhKTsNCj4gIH0NCj4gIA0KPiAr
dW5zaWduZWQgaW50IG10a19vdmxfYWRhcHRvcl9zdXBwb3J0ZWRfcm90YXRpb25zKHN0cnVjdCBk
ZXZpY2UgKmRldikNCj4gK3sNCj4gKwlyZXR1cm4gRFJNX01PREVfUk9UQVRFXzA7DQo+ICt9DQo+
ICsNCj4gIHZvaWQgbXRrX292bF9hZGFwdG9yX3VucmVnaXN0ZXJfdmJsYW5rX2NiKHN0cnVjdCBk
ZXZpY2UgKmRldikNCj4gIHsNCj4gIAlzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IgKm92bF9h
ZGFwdG9yID0NCj4gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+IGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiBpbmRleCBmZmE0ODY4YjEyMjIuLjIwNmRk
NmY2Zjk5ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZGRwX2NvbXAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBf
Y29tcC5jDQo+IEBAIC00MjIsNiArNDIyLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGRw
X2NvbXBfZnVuY3MNCj4gZGRwX292bF9hZGFwdG9yID0gew0KPiAgCS5yZW1vdmUgPSBtdGtfb3Zs
X2FkYXB0b3JfcmVtb3ZlX2NvbXAsDQo+ICAJLmdldF9mb3JtYXRzID0gbXRrX292bF9hZGFwdG9y
X2dldF9mb3JtYXRzLA0KPiAgCS5nZXRfbnVtX2Zvcm1hdHMgPSBtdGtfb3ZsX2FkYXB0b3JfZ2V0
X251bV9mb3JtYXRzLA0KPiArCS5zdXBwb3J0ZWRfcm90YXRpb25zID0gbXRrX292bF9hZGFwdG9y
X3N1cHBvcnRlZF9yb3RhdGlvbnMsDQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgY29uc3QgY2hhciAq
IGNvbnN0IG10a19kZHBfY29tcF9zdGVtW01US19ERFBfQ09NUF9UWVBFX01BWF0gPQ0KPiB7DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jDQo+
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYw0KPiBpbmRleCBlMmVj
NjFiNjk2MTguLjg5NGMzOWEzOGE1OCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fcGxhbmUuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RybV9wbGFuZS5jDQo+IEBAIC0zNDQsNyArMzQ0LDcgQEAgaW50IG10a19wbGFuZV9pbml0
KHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHN0cnVjdA0KPiBkcm1fcGxhbmUgKnBsYW5lLA0KPiAg
CQlyZXR1cm4gZXJyOw0KPiAgCX0NCj4gIA0KPiAtCWlmIChzdXBwb3J0ZWRfcm90YXRpb25zICYg
fkRSTV9NT0RFX1JPVEFURV8wKSB7DQo+ICsJaWYgKHN1cHBvcnRlZF9yb3RhdGlvbnMpIHsNCj4g
IAkJZXJyID0gZHJtX3BsYW5lX2NyZWF0ZV9yb3RhdGlvbl9wcm9wZXJ0eShwbGFuZSwNCj4gIAkJ
CQkJCQkgRFJNX01PREVfUk9UQVQNCj4gRV8wLA0KPiAgCQkJCQkJCSBzdXBwb3J0ZWRfcm90YQ0K
PiB0aW9ucyk7DQo=

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239CF7F2862
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjKUJJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjKUJJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:09:22 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF60BFA;
        Tue, 21 Nov 2023 01:09:14 -0800 (PST)
X-UUID: 9fa7db9e884d11ee8051498923ad61e6-20231121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=qAgKusaIYCo85y/8Zm0rVQiZNgXWRjpKvFDbAGkOKbQ=;
        b=CUWFg1nAF9XrRjVEo3skg3Yu/B46XFlRrRNbL8gEuy47mtGUZtpSG0YZ174W/qYP/mb1OE8kyf+cLfQxVNSLrtqtkq68nj4Mz9gwQbwplMawjPQZMcGUZZDZZCcnDr4F0+fyNj+Uwv9/AzDD/umEFBdGBzM4gzx8Id9/eND2tew=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:f44989b3-c919-445f-8d92-a4124a38c9b8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:63d3c6fc-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9fa7db9e884d11ee8051498923ad61e6-20231121
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1283983388; Tue, 21 Nov 2023 17:09:06 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 21 Nov 2023 17:09:05 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 21 Nov 2023 17:09:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMUDvtN2TPx0j42aPNR93EY5zYyCaOzUhK08zFa9JeKZ2+tH4kuE2859hDnDUD1fhhHgzMdEVsnjlNJ5DM1mzzIYVoLBKOZZfQCjYl0N8ZEEYKN2TIiXJAb1vKlrWm+Xq3GtyUPJcwxIkDSrsBBZ4VghOQ36v6Xqo3GnBP0orRu+vOiQnkj+AGDA8iSYLfN6VB4fgvx6f0QL6FBLCZs6/msfb7nJw1m/04bJvfxZtXEm/HtWbvN9MYutaQ+Xl7NGyXpX2JdaP/o9ZdVhM57jh+SaMOOclo8G+kUBSoNWsex6x/4WIv1WwHtcRIWWmxwl2+BnYZXpDZlPsC5BhMXoQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAgKusaIYCo85y/8Zm0rVQiZNgXWRjpKvFDbAGkOKbQ=;
 b=jv0XbUjqO64cTjML357JtNRV2E4iuA+1XpFI8a59J/7uFDIHc6/6EyejE/j33gAr849prAMrBWz2OwbhKaYSnGX5o3d0SqAzceS9A64+oeO29AsfrCiOrb4gX9oRX+CsTp3YoxpAQUAx50vvIWCZYsLqVQfbZqTpUnXEchHXxWpgG6rgpzUId+zijLS4ElBkYYjxJEeLzveAH8SinC9nfNLLEvxUFXk5ONgsERUp02EoC9oOEO+ORuwzYaLmXzFcRb8bOyulPv5WVSdkVKxTJi7tYau2Bz0wYasjlXHgwk2ByZDrxTcNSnJdRktvG4YNCFu7LUHDc/uGLhb7eJ4a2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAgKusaIYCo85y/8Zm0rVQiZNgXWRjpKvFDbAGkOKbQ=;
 b=k6Zb9WsNA4KwBthwq9P9yZB1nV0Z6wfM95e8olLAWiKSZGdUDiq7gbC0FWEpExkoDk4T0pLsxSV+HbXj/P/SdD7voGf5PGu6yPcnEA8PivzJoiOkM2Mq1XFfG7M9nUw45OHohrwUS5HpB3+MbX4VJtpDF1hpskkZSFfszHPRuB8=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB5646.apcprd03.prod.outlook.com (2603:1096:400:59::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 09:09:03 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a4e1:1557:a3fe:c252]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a4e1:1557:a3fe:c252%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 09:09:03 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "maxime@cerno.tech" <maxime@cerno.tech>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v6] drm/mediatek: add dma buffer control for drm plane
 disable
Thread-Topic: [PATCH v6] drm/mediatek: add dma buffer control for drm plane
 disable
Thread-Index: AQHaHEcqUNKpW/82TE25BWBmqNpIprCEfC4A
Date:   Tue, 21 Nov 2023 09:09:03 +0000
Message-ID: <46a9ff23add4db680cda8e66fe7280bc03003756.camel@mediatek.com>
References: <20231121065006.1536-1-yongqiang.niu@mediatek.com>
In-Reply-To: <20231121065006.1536-1-yongqiang.niu@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB5646:EE_
x-ms-office365-filtering-correlation-id: 85ff4c57-76ad-4ca7-c11b-08dbea7181d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EPoc8HOvuG74WLxABWT7D1WGJ5O/xaglwkyUI1/zhywCmCvJoRzEgs1i3kYgGm/9maEY/O2+D86TenK0qSHKnKOd/CYTF4jow/1hPd75kwvd1pvRRLBtI3heNIdqaPpXggX4n7RxMTJXHGpUxwcJoqtdeC8/Sgaiu5DM2TgcaIzxj+TJP8gTQltpsYC6UVWI25dTQxNg7W6qQTMsh0nfr5OkJhlShQ/gdRiMenTVBR1yP4fRvYw4wJQDUbP8VxVwsu6mjuPSPMn3iL/GGyjHMblaaw7P8C6JFMgNA+1gDLPcRAhX7mGWrAf8TCw+mLNDGE2UAIb175g+yjLrVC+gchh+l7HX27n4H/xMktWgCdNhqMYU3NRSZvz0YiBL7bN/LY3QgWzA/IVz2l5dDj3KTlA1nAllIaRsmCnuM5jGu3EoFBp0+438q2BeXx9GRH3S/Xjs28ypG7Is5fQv3aToNW711gHVohrGxihGvcQTIRCCSc7ZJXilW9QbrEOhJm1xD6RED/7C8Xu1v6aJekmusmIRiEqrsj4TwJm+5csdyCNF8t9enlrXW45yscTlf0lhzTQMf2gt/+24DGZqwtRJalLCfeXDkQY1qwUnUHLE9BrtcDW3d+ubFcSGfR4yFdVr3Nuv4EicPauaS7yzqPwkbezdWciXjymAw7NE4vty2UMHUblNS9fJsD72i1sMN7t/Dy9kQeNxxBk/NlH7HcaWVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230173577357003)(230922051799003)(230273577357003)(451199024)(64100799003)(186009)(1800799012)(41300700001)(36756003)(86362001)(85182001)(5660300002)(7416002)(4001150100001)(2906002)(38070700009)(6512007)(26005)(2616005)(478600001)(71200400001)(83380400001)(122000001)(6506007)(6486002)(38100700002)(316002)(110136005)(76116006)(8676002)(8936002)(4326008)(66946007)(66476007)(66446008)(64756008)(54906003)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWdPcm1HNExSb2ZmQnk4YkZHQmttSWF5WGF5c3hWNXdQVE0xSXJJTFRxeG9G?=
 =?utf-8?B?QW1TNU5SRzlvNk4xUkJ4by9KVmZpb1htcnBTSEovWVhmNjdYUUJhbUp5MWcv?=
 =?utf-8?B?NjVKbldpNjRBWndQenNlK0JHZlBzeGw5djREeGhUWmJYOFdmNGEvRHFGZTN4?=
 =?utf-8?B?UU5vcEs4blhHb1ltSjdYdTkremxvSkZSSjM4S3Uyd0hFNTJ6UDlMZlcvUFk0?=
 =?utf-8?B?czB5VEFaOWsrbllwTFFsOFM0WEYvY2V1NFlRK3ZwWmUwcnhGMFJGVUNHTmFH?=
 =?utf-8?B?d3FLV1ZmbmhPVkxEMXRnN29VZXlpMVc5aUFTcm40dWhwT0wweEhxcXNJN3Ji?=
 =?utf-8?B?S2t2OUc2cXZFQ0o0Mm5qdzlxeGg4VmVOQ2luaFJzNDVDd2pBcVp6cm1xd05s?=
 =?utf-8?B?YkhoeWxSY1dMdEpMTDI2R1FQTDNPM2E0cGVIRXRCeHJTRE1zczIzQWRmbFd3?=
 =?utf-8?B?TDdxTlVOaDRGckN3eU1pdXZLNHQzN2JVT2VvWGFxSmNlanVvbDlJaXkvVE82?=
 =?utf-8?B?ajNrMkNoUWRLUVpVR1lzc3NrZW1jdkp1SzQxMEVUVjMyY1JuZjZHd2hWNTlz?=
 =?utf-8?B?YjhBV0VEendQMXpib1BiQjRrYVlGY1VTSlRsQVRXYmNmaUgvWjM2c1BxTlQz?=
 =?utf-8?B?YmZZM0FiZVphUHhuSytaN0M0U00xNGErbjVHK1k4R1lJRnR6NXl4eDRUMDlM?=
 =?utf-8?B?cFB3NVdDVXlaWE5wSWdyL0lKZ0pCRzR3WHJWQkVjMWZYNVJUYnJkN1pqNVVS?=
 =?utf-8?B?ZzQrTW1Od0NJMjAySUNMcXMzQjc2L0svODFIQ1lQbmlEcjNhdk5JNUEra3Ex?=
 =?utf-8?B?aEIyZDJMWEZNOUMzNFFUWlp3RXlicjdOK3dBT2U3bjdEWFJ4bDlEVU5DM2ts?=
 =?utf-8?B?N3BRcHFIRXlxRnRTWUFRMVg5MmRQMzN6WHZLdmJaOWo3UG9tWXVSUzZ3OXhs?=
 =?utf-8?B?dGNLZ2FxRmN1Z2R5WFIrY2hyRVErOUY0RmYyY0RDY0Yrd284MzZvbDVMclF5?=
 =?utf-8?B?cWtUSTlpekFsakJmR253QmI4bEN1NzI1QUNwYjlOTXo2Tit2WFVsYUhySUhk?=
 =?utf-8?B?M2UzcHJPZmxIMUZoT2R5NzlGVjc5S1c0eVlCaUVEUGRaL0JPb1Jya1pTbDNF?=
 =?utf-8?B?TmZ6aXY5RGtNNHRWT013a1NpZCt4c3NuNTR1cFJzM2xXazFsUUw5Y1N6VDNX?=
 =?utf-8?B?bk1GSVNlZFQxekV0bFhPR2UrR1dmQmxHZEo4UkVXY21DSHJsRjhpRjQ2dHFl?=
 =?utf-8?B?ZE9zN3p3VXlwZGczY29TRDhCanlvR1ZBTFIzNENJb2w1OG9sSUV1Y3VlamtK?=
 =?utf-8?B?Q3JqTC9qSG9LN2lWNnBRZjdPVUg1ZU50cTk1eDhLVVBVU0hTWTJUOU85ZmxQ?=
 =?utf-8?B?TTNNU3JwUWY5bUg4YXBJTnpPL3VpbFFCVkVaWkdzMmdRY3FVUXh4YjUwRHho?=
 =?utf-8?B?NDNIMmhTMWJQS241aHZlam9WU1BWaDNySHErSTFOS1hreDRlRlFGcHgwNDhj?=
 =?utf-8?B?RUU0Y04yaVlxZDl3L2RCdGpuZWlUbEZhaG9SR1RuVk0rNUt4OGhtcnVzYThi?=
 =?utf-8?B?dUpQOUFGTXRpRkpQazQ3K1RELzRRdUhPbWRPdHp0ay9oNE9LcmFmMHd5Q1JY?=
 =?utf-8?B?SHkxa01IcDlIWU9weExLbUp2SVdHL2pTU3N4M3ViVEpHWHFIaWo0SUY5RC82?=
 =?utf-8?B?SWRzdGN0YjAyUmswbGdHK29GcFQreEo3cWhGaENvUUtzU3Uvc3h3YWlXRDVZ?=
 =?utf-8?B?Q3ZmYklhNGZiQlh6VU5ocFcvSzJsMy9nUEtGOXk0eXZYOEJCK3ZvWTEvUk51?=
 =?utf-8?B?YnVtdGdYQ1VzWE5CdHcxTjFmSzVKMjlHd1ZwNzlLVkMwcWdFVEVzOGpuSE14?=
 =?utf-8?B?NE9WazRoQk1PMU9lbUpyWVFmRy9tR0tXU1lvUTllb2xjMVNFUkgxaVEvMWUy?=
 =?utf-8?B?VTVLS1ZOZnhtNE5ZZ2dGckVUeWdXYkNpbkxxUUJCK2FZQ0xPNmpXWTlIK2NB?=
 =?utf-8?B?STBuRmlnN2IzNERZd3R0ZkdFQ1h5MmE2b0FtY3BIWi9raDkrRGNHb0JFYmsx?=
 =?utf-8?B?OTE3TVEzVjFGNlFCTFREbGZHMTZNZU9YdGI1L0R1cFBCVzRSUmx3eEd6ZjNw?=
 =?utf-8?Q?sqeCeXi+pZuzA2/GLb2p7K4cL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A0A70090951E647B92AFA7669B5A031@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ff4c57-76ad-4ca7-c11b-08dbea7181d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 09:09:03.3249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 49wPjz9WtkPb8TCJtWEijCY8b9FsoPXOCVED9qMGfzBYyKT3LjcrXXoRBuuJ8ZPgSDMdlFr54s7EGQYVsaLbgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5646
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KT24gVHVlLCAyMDIzLTExLTIxIGF0IDE0OjUwICswODAwLCBZb25n
cWlhbmcgTml1IHdyb3RlOg0KPiB0aGUgRE1BIGJ1ZmZlciBpcyByZWxlYXNlZCB3aGVuIHN0aWxs
IGFjY2Vzc2VkIGJ5IE1lZGlhdGVrIGRpc3BsYXkNCj4gaGFyZHdhcmUsDQo+IHRoaXMgZmxvdyBj
YW4gbGVhZCB0byBNNFUgcmVwb3J0aW5nIGEgdHJhbnNsYXRpb24gZmF1bHQgd2FybmluZw0KPiAN
Cj4gYWRkIGRtYSBidWZmZXIgY29udHJvbCBmbG93IGluIG1lZGlhdGVrIGRyaXZlcjoNCj4gZ2V0
IGRtYSBidWZmZXIgd2hlbiBkcm0gcGxhbmUgZGlzYWJsZQ0KPiBwdXQgZG1hIGJ1ZmZlciB3aGVu
IG92ZXJsYXkgcmVhbGx5IGRpc2FibGUNCg0KSW4gZHJtX2F0b21pY19oZWxwZXJfY29tbWl0KCks
IGl0IGNhbGwNCmRybV9hdG9taWNfaGVscGVyX3dhaXRfZm9yX3ZibGFua3MoKS4gQW5kIEkgdGhp
bmsgdGhpcyB3b3VsZCBtYWtlIHN1cmUNCnRoYXQgc2V0dGluZyBoYXMgYmVlbiBhcHBsaWVkIHRv
IGhhcmR3YXJlLiBTbyB5b3UgZG9uJ3QgbmVlZCB0byBtb2RpZnkNCm10a19wbGFuZV9hdG9taWNf
ZGlzYWJsZSgpLiBJZiB0aGVyZSBpcyBidWcgaW4NCmRybV9hdG9taWNfaGVscGVyX3dhaXRfZm9y
X3ZibGFua3MoKSwgZml4DQpkcm1fYXRvbWljX2hlbHBlcl93YWl0X2Zvcl92YmxhbmtzKCkuDQoN
ClJlZ2FyZHMsDQpDSw0KDQo+IA0KPiBGaXhlczogNDEwMTZmZTEwMjhlICgiZHJtOiBSZW5hbWUg
cGxhbmUtPnN0YXRlIHZhcmlhYmxlcyBpbiBhdG9taWMNCj4gdXBkYXRlIGFuZCBkaXNhYmxlIikN
Cj4gU2lnbmVkLW9mZi1ieTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRlay5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jICB8
IDI1DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fZHJ2LmMgICB8ICAxICsNCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX3BsYW5lLmMgfCAxMiArKysrKysrKysrKysNCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX3BsYW5lLmggfCAgMSArDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDM5IGluc2Vy
dGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RybV9jcnRjLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMN
Cj4gaW5kZXggYzI3N2I5ZmFlOTUwLi4xODhhYWE5N2U1ZTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gQEAgLTQsNiArNCw3IEBADQo+ICAgKi8NCj4g
IA0KPiAgI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L2RtYS1idWYu
aD4NCj4gICNpbmNsdWRlIDxsaW51eC9kbWEtbWFwcGluZy5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4
L21haWxib3hfY29udHJvbGxlci5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+IEBAIC0y
ODMsNiArMjg0LDIzIEBAIHN0cnVjdCBtdGtfZGRwX2NvbXANCj4gKm10a19kcm1fZGRwX2NvbXBf
Zm9yX3BsYW5lKHN0cnVjdCBkcm1fY3J0YyAqY3J0YywNCj4gIAlyZXR1cm4gTlVMTDsNCj4gIH0N
Cj4gIA0KPiArc3RhdGljIHZvaWQgbXRrX2RybV9kbWFfYnVmX3B1dChzdHJ1Y3QgbXRrX2RybV9j
cnRjICptdGtfY3J0YykNCj4gK3sNCj4gKwl1bnNpZ25lZCBpbnQgaTsNCj4gKw0KPiArCWZvciAo
aSA9IDA7IGkgPCBtdGtfY3J0Yy0+bGF5ZXJfbnI7IGkrKykgew0KPiArCQlzdHJ1Y3QgZHJtX3Bs
YW5lICpwbGFuZSA9ICZtdGtfY3J0Yy0+cGxhbmVzW2ldOw0KPiArCQlzdHJ1Y3QgbXRrX3BsYW5l
X3N0YXRlICpwbGFuZV9zdGF0ZTsNCj4gKw0KPiArCQlwbGFuZV9zdGF0ZSA9IHRvX210a19wbGFu
ZV9zdGF0ZShwbGFuZS0+c3RhdGUpOw0KPiArDQo+ICsJCWlmIChwbGFuZV9zdGF0ZSAmJiBwbGFu
ZV9zdGF0ZS0+cGVuZGluZy5kbWFfYnVmKSB7DQo+ICsJCQlkbWFfYnVmX3B1dChwbGFuZV9zdGF0
ZS0+cGVuZGluZy5kbWFfYnVmKTsNCj4gKwkJCXBsYW5lX3N0YXRlLT5wZW5kaW5nLmRtYV9idWYg
PSBOVUxMOw0KPiArCQl9DQo+ICsJfQ0KPiArfQ0KPiArDQo+ICAjaWYgSVNfUkVBQ0hBQkxFKENP
TkZJR19NVEtfQ01EUSkNCj4gIHN0YXRpYyB2b2lkIGRkcF9jbWRxX2NiKHN0cnVjdCBtYm94X2Ns
aWVudCAqY2wsIHZvaWQgKm1zc2cpDQo+ICB7DQo+IEBAIC0zMjMsNiArMzQxLDggQEAgc3RhdGlj
IHZvaWQgZGRwX2NtZHFfY2Ioc3RydWN0IG1ib3hfY2xpZW50ICpjbCwNCj4gdm9pZCAqbXNzZykN
Cj4gIAkJbXRrX2NydGMtPnBlbmRpbmdfYXN5bmNfcGxhbmVzID0gZmFsc2U7DQo+ICAJfQ0KPiAg
DQo+ICsJbXRrX2RybV9kbWFfYnVmX3B1dChtdGtfY3J0Yyk7DQo+ICsNCj4gIAltdGtfY3J0Yy0+
Y21kcV92YmxhbmtfY250ID0gMDsNCj4gIAl3YWtlX3VwKCZtdGtfY3J0Yy0+Y2JfYmxvY2tpbmdf
cXVldWUpOw0KPiAgfQ0KPiBAQCAtNjI3LDkgKzY0NywxNCBAQCBzdGF0aWMgdm9pZCBtdGtfY3J0
Y19kZHBfaXJxKHZvaWQgKmRhdGEpDQo+ICAJZWxzZSBpZiAobXRrX2NydGMtPmNtZHFfdmJsYW5r
X2NudCA+IDAgJiYgLS1tdGtfY3J0Yy0NCj4gPmNtZHFfdmJsYW5rX2NudCA9PSAwKQ0KPiAgCQlE
Uk1fRVJST1IoIm10a19jcnRjICVkIENNRFEgZXhlY3V0ZSBjb21tYW5kDQo+IHRpbWVvdXQhXG4i
LA0KPiAgCQkJICBkcm1fY3J0Y19pbmRleCgmbXRrX2NydGMtPmJhc2UpKTsNCj4gKw0KPiArCWlm
ICghbXRrX2NydGMtPmNtZHFfY2xpZW50LmNoYW4pDQo+ICsJCW10a19kcm1fZG1hX2J1Zl9wdXQo
bXRrX2NydGMpOw0KPiAgI2Vsc2UNCj4gIAlpZiAoIXByaXYtPmRhdGEtPnNoYWRvd19yZWdpc3Rl
cikNCj4gIAkJbXRrX2NydGNfZGRwX2NvbmZpZyhjcnRjLCBOVUxMKTsNCj4gKw0KPiArCW10a19k
cm1fZG1hX2J1Zl9wdXQobXRrX2NydGMpOw0KPiAgI2VuZGlmDQo+ICAJbXRrX2RybV9maW5pc2hf
cGFnZV9mbGlwKG10a19jcnRjKTsNCj4gIH0NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcm1fZHJ2LmMNCj4gaW5kZXggMmRmYWE2MTMyNzZhLi40ZmQyMzI2NDQzODMgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+IEBAIC0xMDE5LDQgKzEwMTks
NSBAQCBtb2R1bGVfZXhpdChtdGtfZHJtX2V4aXQpOw0KPiAgDQo+ICBNT0RVTEVfQVVUSE9SKCJZ
VCBTSEVOIDx5dC5zaGVuQG1lZGlhdGVrLmNvbT4iKTsNCj4gIE1PRFVMRV9ERVNDUklQVElPTigi
TWVkaWF0ZWsgU29DIERSTSBkcml2ZXIiKTsNCj4gK01PRFVMRV9JTVBPUlRfTlMoRE1BX0JVRik7
DQo+ICBNT0RVTEVfTElDRU5TRSgiR1BMIHYyIik7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fcGxhbmUuYw0KPiBpbmRleCBkZGM5MzU1YjA2ZDUuLmZiZmNkMGQxYTU2YyAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYw0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jDQo+IEBAIC0x
Miw2ICsxMiw3IEBADQo+ICAjaW5jbHVkZSA8ZHJtL2RybV9mcmFtZWJ1ZmZlci5oPg0KPiAgI2lu
Y2x1ZGUgPGRybS9kcm1fZ2VtX2F0b21pY19oZWxwZXIuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9h
bGlnbi5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L2RtYS1idWYuaD4NCj4gIA0KPiAgI2luY2x1ZGUg
Im10a19kcm1fY3J0Yy5oIg0KPiAgI2luY2x1ZGUgIm10a19kcm1fZGRwX2NvbXAuaCINCj4gQEAg
LTI4Myw2ICsyODQsMTcgQEAgc3RhdGljIHZvaWQgbXRrX3BsYW5lX2F0b21pY19kaXNhYmxlKHN0
cnVjdA0KPiBkcm1fcGxhbmUgKnBsYW5lLA0KPiAgCXN0cnVjdCBkcm1fcGxhbmVfc3RhdGUgKm5l
d19zdGF0ZSA9DQo+IGRybV9hdG9taWNfZ2V0X25ld19wbGFuZV9zdGF0ZShzdGF0ZSwNCj4gIAkJ
CQkJCQkJCQ0KPiAgICBwbGFuZSk7DQo+ICAJc3RydWN0IG10a19wbGFuZV9zdGF0ZSAqbXRrX3Bs
YW5lX3N0YXRlID0NCj4gdG9fbXRrX3BsYW5lX3N0YXRlKG5ld19zdGF0ZSk7DQo+ICsJc3RydWN0
IGRybV9wbGFuZV9zdGF0ZSAqb2xkX3N0YXRlID0NCj4gZHJtX2F0b21pY19nZXRfb2xkX3BsYW5l
X3N0YXRlKHN0YXRlLA0KPiArCQkJCQkJCQkJDQo+ICAgIHBsYW5lKTsNCj4gKw0KPiArCWlmIChv
bGRfc3RhdGUgJiYgb2xkX3N0YXRlLT5mYikgew0KPiArCQlzdHJ1Y3QgZHJtX2dlbV9vYmplY3Qg
KmdlbSA9IG9sZF9zdGF0ZS0+ZmItPm9ialswXTsNCj4gKw0KPiArCQlpZiAoZ2VtICYmIGdlbS0+
ZG1hX2J1Zikgew0KPiArCQkJZ2V0X2RtYV9idWYoZ2VtLT5kbWFfYnVmKTsNCj4gKwkJCW10a19w
bGFuZV9zdGF0ZS0+cGVuZGluZy5kbWFfYnVmID0gZ2VtLQ0KPiA+ZG1hX2J1ZjsNCj4gKwkJfQ0K
PiArCX0NCj4gIAltdGtfcGxhbmVfc3RhdGUtPnBlbmRpbmcuZW5hYmxlID0gZmFsc2U7DQo+ICAJ
d21iKCk7IC8qIE1ha2Ugc3VyZSB0aGUgYWJvdmUgcGFyYW1ldGVyIGlzIHNldCBiZWZvcmUgdXBk
YXRlICovDQo+ICAJbXRrX3BsYW5lX3N0YXRlLT5wZW5kaW5nLmRpcnR5ID0gdHJ1ZTsNCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmgNCj4gYi9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5oDQo+IGluZGV4IDk5YWZmN2Rh
MDgzMS4uM2FiYTBiNThlZjNjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RybV9wbGFuZS5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX3BsYW5lLmgNCj4gQEAgLTMzLDYgKzMzLDcgQEAgc3RydWN0IG10a19wbGFuZV9wZW5kaW5n
X3N0YXRlIHsNCj4gIAlib29sCQkJCWFzeW5jX2RpcnR5Ow0KPiAgCWJvb2wJCQkJYXN5bmNfY29u
ZmlnOw0KPiAgCWVudW0gZHJtX2NvbG9yX2VuY29kaW5nCQljb2xvcl9lbmNvZGluZzsNCj4gKwlz
dHJ1Y3QgZG1hX2J1ZgkJCSpkbWFfYnVmOw0KPiAgfTsNCj4gIA0KPiAgc3RydWN0IG10a19wbGFu
ZV9zdGF0ZSB7DQo=

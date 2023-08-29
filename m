Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE0678CF80
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 00:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238253AbjH2WYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 18:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjH2WXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 18:23:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7894AC2;
        Tue, 29 Aug 2023 15:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1693347811; x=1724883811;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xaTWdpSe63l4IRwV74tt2M9rg0IhIroRBNDsSdY7YGw=;
  b=js5losqfJ+hUczVfYv9vTKV+EvivmW+OE2GNkfiO1sBt/wSzLd0uu6ag
   Q14piYeASFtrpvVx1+1tarsPpzMv/pnKmK9+zPfNlA1v1yYQyJFDGCy/y
   Ojki4m+/kVHLHbkeVg882hFxiHBsx8zM5r6cSXsocGv5mmSC73+GlonOQ
   0hIy3/YjonGQJo0cXUE0ammQuAcqvTCzeiv3GgP3ifLnc7yeNiwNSu9OA
   YpD6ThKg3LW67sqkbS1XkfaWMPO7HadRS5NrO8nn9xTxe510MTeDLHC31
   XonX3xobw3LjdQ4WTBc27qSJO66k4ZTRGUmJPnMa9mYCaJ6ZJAE61y1t1
   Q==;
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="168949051"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Aug 2023 15:23:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 29 Aug 2023 15:23:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 29 Aug 2023 15:23:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzoM/UMX+16yS4fLYMLEk2s1oFX8vC0jZsDp3+cBUkvYxRd+yMST8cl7Pu1nAFfBW2tQm++28x3uFYlVDKNUR8RzP/ViuDqh/n6XifoVE4ykO7ISNYka5JEuK2B6/LxBGKyjIgHYhP0i8JfZ67wmarGAwnIwKV8zLuNnc1s3DTahQkheZFkl1y8IvuRtvGDqeaEfvHlD3RDUQZVf6LQC/OVCBdFmbxyctuB00Cpr51YEtPU5kuzXrKon5Cq3zxVdIbOHmsgBvonsuVR2e2iTA36De2cV0H7Wjv73FuHZs2Oa6B0j0edQTNxvbXJXu7IkHf1dxxz+8dK2bIdHUo+5yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaTWdpSe63l4IRwV74tt2M9rg0IhIroRBNDsSdY7YGw=;
 b=ODloxW9A6o7HgWL6ORAEOHG2XK1X5hfc3ORVBZueYWMQtdOMrikQHFzn7qXccH9SYETCK5P9syjj+FbkqSKcGqQAayp0aKgQYgf7fMCqffz7IF0ImXwGn06b2trPaCUg5lkhmlNKHJTd+rgPtBHQdVrHY87/4G7in7wH+RIpGMmcDwP7kCOmw7mBUl1BdhaPqrrruhSXam/gaNlVJ2L3jAxcJBAq1Fw4eI5Z+3CexZqCq+GufTeRRKxkbQtad+JB9Lzzy5R1NMdIzVBYHkONSt/sTDKbcMBc7WAG0CnGK8O1ThkKmkSpdVr+lZ1rHNs9F0uIM2wdckK0L9yX34/PDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaTWdpSe63l4IRwV74tt2M9rg0IhIroRBNDsSdY7YGw=;
 b=ILDs9P7qOOONQ3CwTxRPRB1PmgErV6WpgD4Yg/IX95fYG5E8z16R/TsttLm9K02UaiW0Ck/BFzgPwzaqoWH6w+B7nVkqj/XVrFiGKZ5tR1T1fpE7UmpQOc0E7JgZnrazedyBqztLI0VPGr3tzuffCcKkAtN6J5YKzfpNfvC0cIM=
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by CH0PR11MB5363.namprd11.prod.outlook.com (2603:10b6:610:ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 22:23:27 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::ceda:7787:e08b:7a19]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::ceda:7787:e08b:7a19%7]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 22:23:27 +0000
From:   <Tristram.Ha@microchip.com>
To:     <o.rempel@pengutronix.de>, <lukma@denx.de>
CC:     <olteanv@gmail.com>, <linux@rempel-privat.de>,
        <Arun.Ramadoss@microchip.com>, <f.fainelli@gmail.com>,
        <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <Woojung.Huh@microchip.com>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH 2/2] net: dsa: microchip: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Thread-Topic: [PATCH 2/2] net: dsa: microchip: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Thread-Index: AQHZ1qKWLyunbFo9dUGlg3dtAL+k26/6NENwgAB9tYCAAHHrgIAANckAgAEO8gCABJGpgIAAHN2AgAASVoCAAAZ5gIAADjSAgAAijYCAAA0ngIAAHL2AgABWAGA=
Date:   Tue, 29 Aug 2023 22:23:26 +0000
Message-ID: <BYAPR11MB3558DDEACCFE005DA1D41CDCECE7A@BYAPR11MB3558.namprd11.prod.outlook.com>
References: <862e5225-2d8e-8b8f-fc6d-c9b48ac74bfc@gmail.com>
 <BYAPR11MB3558A24A05D30BA93408851EECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
 <20230826104910.voaw3ndvs52yoy2v@skbuf> <20230829103533.7966f332@wsk>
 <20230829101851.435pxwwse2mo5fwi@skbuf> <20230829132429.529283be@wsk>
 <20230829114739.GC31399@pengutronix.de> <20230829143829.68410966@wsk>
 <20230829144209.GD31399@pengutronix.de> <20230829172913.518210b0@wsk>
 <20230829171205.GE31399@pengutronix.de>
In-Reply-To: <20230829171205.GE31399@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|CH0PR11MB5363:EE_
x-ms-office365-filtering-correlation-id: 843a4bd6-51ee-4350-a5d7-08dba8de90e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yl5ZXlTrnvnkAWkUk1FkFSmzNtd7CR7l4m3xqftvkqYoG8yUUedCXmSOvQC3do3Y46NaSX/eqGqdUelSMUB017SDeorQMH86PV6o9AD4EZETied3bD0sHsRxKuVz7rtAbayyhvPkEXwT2yNRBkK0kazyjOwYRGhAgWSp+W8tzE47aOkXkIcf0gMCMjlJ6RXZg82w2jH0x+UJEEQQbpY3maqRAjWwSEf++DrfgPL8VmcB2jj5Kc5u0Rthp+sCULq1L8wm1id0ZoGkIKWStsY7gsdqPSpczVqp78S27I4z7CTEvwVq8s1SgDFkRg4EcSfjGwGiRM+ty9WYxG5CMiRA12W7Ut4JrcUdVV6Ra/fR6ehxxMhn27uwPjLg6pDpQ+rP0IBSw4uGdHnMzq0uZUS2WbEDH44XKu9J+bDd07XVFfV/kc7D50wDREhcYGQ9sa8dYYJCo7hm+1pVvRFX95DqJilis2Qrcx8N/6w8hPypSZPHXOLwsk5hRl1qLJMW1Y6HHAKaVFSQaHJC9uDVaaQ3QgGX60tQUD39DjuFCzXHl222GmZ3QzWKdL7UOmYs0SMioTXJxv/aSjkbIAtx5JWWFwxVXZ/34LiLyGU8+ZrSv03FVMXFKG/NeAsY/9KaoJQy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(346002)(396003)(186009)(1800799009)(451199024)(7416002)(2906002)(66946007)(76116006)(33656002)(54906003)(66556008)(66476007)(55016003)(64756008)(66446008)(5660300002)(316002)(41300700001)(4326008)(8676002)(8936002)(52536014)(110136005)(38100700002)(6506007)(71200400001)(7696005)(9686003)(122000001)(107886003)(86362001)(38070700005)(26005)(478600001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVZ4d1VLYVVoS1dnS1NPT0hXMVV3eXZsblVtdlFNL2JGYXdwS0lIYzl3Uk8v?=
 =?utf-8?B?RkpYQ0NaLzJoZU9PU0dRZG1WRzdZMG1nT2lJL2sybExBTzhYUW1iTVVnZWZH?=
 =?utf-8?B?eExFbU8yUGlqYjVMT0RmM25ZSlkvMTZzcC9FSzhrZnVOQ1E4R3F2MUZpNU8v?=
 =?utf-8?B?MGNlZGk0em5TaFB3Z1Y0VzcyR2dFZCtXSTI3U3REZm91ZzNpZ1NySFlpWlIr?=
 =?utf-8?B?cXVxOEJmYnZ4ZzFGdEQyNjFuUHVGUVhWVER5M2hWZ2ZDbE1uZXVHbjFGRFVp?=
 =?utf-8?B?bWlJV0VwVGp6Z1dtTUxqcHNrQUtmRVBVWGJPTURtekhNZXJVR1dNOGdGbEdN?=
 =?utf-8?B?WUw5RmJXSXN4OG1ocjZzVXVaRFVERDRuaEQvZlUvM2hleXJGbnlqRklwc0Nx?=
 =?utf-8?B?cDhUVGVPbSszbXZuWEtIc0hrcmtpanhtbUtoM3J3NE9CRlFsT3Z6NTBRSVVl?=
 =?utf-8?B?eXhkeU1IY0NnNkNVMHQ4SGYyT3g2cU5YNk1GVlQ0T05hcHg3N1ZMUEYvZVhU?=
 =?utf-8?B?bTdRaEVIQ3M4UTdrQ09TVCtJTEhIaEw1WUZRR2h3VnY5bG1tU3B4QXhHbEFt?=
 =?utf-8?B?VmxUNUNRM1BoZDVSNmp1QkF4UmpKcjdaYlR1aEFvZFNTRkdqQWlUWkI5VmNW?=
 =?utf-8?B?THFscG1hUjN6MmZ2Z2JjRDkreGx0S3ZwaVVBdGRwTDlHazM1VHA3MStuVWRt?=
 =?utf-8?B?TXBwemR5b1pkdjNCRFF0TVJzU0NzYldpY2wzMGVXYjd4eXF5enpycTBKcWxu?=
 =?utf-8?B?L0JUZjErVDVTMmVqSm94QUM4ZE9TTm1ZNHBtaE0yelA5U0VjYmgzRzdDVTlC?=
 =?utf-8?B?K2dIQysyVFFaRmxGNkRwc3B5SzVHbjZMTG4rc0UvaG9SZ3J5cGU4RW82c0Qv?=
 =?utf-8?B?aFR2aHdnYU5Fb2xDZ3hQQjh1SjQzV2I0VDhidzB3MmIxZDVVS2FZVWExYXZ4?=
 =?utf-8?B?ZnJUZlc0M2VINzVvdk9BazhLZjE2WXduVnpON1JkckVPYW5oKzNmeTg0Q2Z0?=
 =?utf-8?B?MWhlanB3S2VaZURwZmY5TWVSN2cvdTB2dVM2MktIYm4yNEhZOFMvbmxMVWhC?=
 =?utf-8?B?Y1lEVWMwRlBQckprQmdCZGZMdklQRzJXREg1TTlsTzBPbDNlbWdweFBacFg3?=
 =?utf-8?B?c1g0S2tCSTQ4Uy9XS1RtMDA5WVROWlkyVXBxbVVmazRva29VeDlkYlRnZXJk?=
 =?utf-8?B?YjZjTHJOc2twMzRURVEvbmZaNEdZbFBuaGZmdGNGdjErbTR3LzJKWW1PL3pV?=
 =?utf-8?B?dUMrRkt0MkVtQmR4dktsdVQ4akdNczJPQVYySm11Z2EwUVk5MzlmREZDRzhN?=
 =?utf-8?B?TlFiSTQ0YUtCeHorTmZkSWRCVURZNk15MFN1Umd0M3p1UEc2QmVlTWdCOUxr?=
 =?utf-8?B?YytXRXZhK3lqbzcvTXVpL3c1ZDFFS1J3enN6SGxDejhzT1hXWEx4ZHFHSXlh?=
 =?utf-8?B?YXBtUmVZaklLNDB0QWoxUWdSeStDQUFHTzh1b3RLbTU3eUVxcHJVaVFiRGI4?=
 =?utf-8?B?YTM5ZWcxMlBvUitHUCswSXNyMHJVeE8yTGR3RnpHbEoyZmNZRkdMWHdLYnNS?=
 =?utf-8?B?cFBBSVFjbFdZTE5JbTBmVW90NFVzWkJuUDhhMEtKUmFCdThNUXl4bkkreUU2?=
 =?utf-8?B?NjI4elJLWURKNHN5RENxWjQ2ajkrL3Q2M2JqR3JCNGF3RFFmQngyVmlBVHRX?=
 =?utf-8?B?bHlEU1RjZW8wdnBwb3dxT2pyVkJzY3FiMVNySk1ISVpGZU1oNGhQSXhESi9n?=
 =?utf-8?B?MWphUWNoRjBhT2krM1gwOUZKRGl3cENRSzE2WlBjV0Y3YTloZENvT3Q4dlpX?=
 =?utf-8?B?VjdBYXh1SjJvNmNocXNsZFN2UTY5NDFiNm45MDNoNXAxQTFINW1iMGtIN1hE?=
 =?utf-8?B?V1JrZlVHaVBxT0ZzU1pjSmI4bTJEeWFRMFBxSTVRNUJSdWdFeldkYjUya1dI?=
 =?utf-8?B?dVllbkdBYUordzlrVFVKdTBBSzdyNjBHVUp4TEdTQkxIai9KQWZDNHFjWXBr?=
 =?utf-8?B?NXNEYzF3ZzhlZmIvZ21makVaTDRjb3lmMVpsZXNHRUtwR1JkSlFINFRncHlL?=
 =?utf-8?B?UXZPR3lXeXk0QUlzNzMwY29KRFdJNjBBVE1ReTFBWWF1U3Y3ekZTMHI3WUVL?=
 =?utf-8?Q?/oVUy8Zucd4icbs2VxPvSRLNI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3558.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843a4bd6-51ee-4350-a5d7-08dba8de90e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 22:23:26.9797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UTz/C7aT4sdEmRw67l872DjzBQwkN3xvQD6IRPnF+48BNHe7XmJYX9xw8jHFa2LkLRNie4DSePuwNW/GYiy1k9NBAarQnDNV3GcAPmfgRZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5363
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBZZXMsIHJlbW92aW5nIGxpbmttb2RfYW5kKCkgd2lsbCBub3Qgc2hvdWxkIG5vdCBoZWxwLiBJ
IHNhaWQsICJUaGUNCj4gcGh5ZGV2LT5zdXBwb3J0ZWRfZWVlIHNob3VsZCBiZSBjbGVhcmVkLiIN
Cj4gDQo+IEZvciBleGFtcGxlIGxpa2UgdGhpczoNCj4gLS0tIGEvZHJpdmVycy9uZXQvcGh5L21p
Y3JlbC5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3BoeS9taWNyZWwuYw0KPiBAQCAtMTQwMCw2ICsx
NDAwLDcgQEAgc3RhdGljIGludCBrc3o5MTMxX2NvbmZpZ19hbmVnKHN0cnVjdCBwaHlfZGV2aWNl
ICpwaHlkZXYpDQo+IA0KPiAgc3RhdGljIGludCBrc3o5NDc3X2dldF9mZWF0dXJlcyhzdHJ1Y3Qg
cGh5X2RldmljZSAqcGh5ZGV2KQ0KPiAgew0KPiArICAgICAgIF9fRVRIVE9PTF9ERUNMQVJFX0xJ
TktfTU9ERV9NQVNLKHplcm8pID0geyAwLCB9Ow0KPiAgICAgICAgIGludCByZXQ7DQo+IA0KPiAg
ICAgICAgIHJldCA9IGdlbnBoeV9yZWFkX2FiaWxpdGllcyhwaHlkZXYpOw0KPiBAQCAtMTQxMyw3
ICsxNDE0LDcgQEAgc3RhdGljIGludCBrc3o5NDc3X2dldF9mZWF0dXJlcyhzdHJ1Y3QgcGh5X2Rl
dmljZQ0KPiAqcGh5ZGV2KQ0KPiAgICAgICAgICAqIEtTWjg1NjNSIHNob3VsZCBoYXZlIDEwMEJh
c2VUWC9GdWxsIG9ubHkuDQo+ICAgICAgICAgICovDQo+ICAgICAgICAgbGlua21vZGVfYW5kKHBo
eWRldi0+c3VwcG9ydGVkX2VlZSwgcGh5ZGV2LT5zdXBwb3J0ZWQsDQo+IC0gICAgICAgICAgICAg
ICAgICAgIFBIWV9FRUVfQ0FQMV9GRUFUVVJFUyk7DQo+ICsgICAgICAgICAgICAgICAgICAgIHpl
cm8pOw0KPiANCj4gICAgICAgICByZXR1cm4gMDsNCj4gIH0NCj4gDQo+IFlvdSB3aWxsIG5lZWQg
dG8gY2xlYXIgaXQgb25seSBvbiBLU1o5NDc3IHZhcmlhbnRzIHdpdGggdGhpcyBidWcuDQo+IFRo
aXMgY2hhbmdlIGlzIHRlc3RlZCBhbmQgaXQgd29ya3Mgb24gbXkgS1NaOTQ3Ny1FVkIuDQogDQpJ
IHRoaW5rIHRoaXMgaXMgYmVzdCBmb3IgZGlzYWJsaW5nIEVFRSBzdXBwb3J0Lg0KSSB0aGluayBi
ZWZvcmUgc29tZSBjdXN0b21lcnMgYXNrZWQgZm9yIEV0aHRvb2wgRUVFIHN1cHBvcnQgbm90IGJl
Y2F1c2UNCnRoZXkgd2FudCB0byB1c2UgaXQgYnV0IHRvIGRpc2FibGUgaXQgYmVjYXVzZSBvZiBs
aW5rIGluc3RhYmlsaXR5Lg0KS1NaOTg5My9LU1o5NTYzIHN3aXRjaGVzIHNob3VsZCBoYXZlIHRo
ZSBzYW1lIHByb2JsZW0uICBUaGUgRUVFIHByb2JsZW0NCmRlcGVuZHMgb24gdGhlIGxpbmsgcGFy
dG5lci4gIEZvciBleGFtcGxlIG15IGxhcHRvcCBkb2VzIG5vdCBoYXZlIHByb2JsZW0NCmV2ZW4g
dGhvdWdoIEVFRSBpcyBlbmFibGVkLCBhbHRob3VnaCBJIGFtIG5vdCBzdXJlIGlmIEVFRSBpcyBy
ZWFsbHkNCmFjdGl2ZS4gIFRoZSBwcm9ibGVtIGhlcmUgaXMganVzdCB1c2luZyB0d28gS1NaOTQ3
NyBzd2l0Y2hlcyBhbmQNCnByb2dyYW1taW5nIHRob3NlIFBIWSBzZXR1cCB2YWx1ZXMgYW5kIGVu
YWJsaW5nIEVFRSB3aWxsIG1ha2UgdGhlIGxpbmsNCnVuc3RhYmxlLiAgTWFuYWdlbWVudCBkZWNp
ZGVkIHRvIGRpc2FibGUgRUVFIGZlYXR1cmUgdG8gYXZvaWQgY3VzdG9tZXINCnN1cHBvcnQgaXNz
dWVzLg0KQW5vdGhlciBpc3N1ZSBpcyBFRUUgc2hvdWxkIGJlIGRpc2FibGVkIHdoZW4gdXNpbmcg
MTU4OCBQVFAuDQoNCg==

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0580E757002
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 00:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjGQWtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 18:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjGQWt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 18:49:26 -0400
X-Greylist: delayed 397 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Jul 2023 15:49:24 PDT
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1114.securemx.jp [210.130.202.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA2E113;
        Mon, 17 Jul 2023 15:49:24 -0700 (PDT)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1114) id 36HMglW2021295; Tue, 18 Jul 2023 07:42:48 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 36HMdLjs3368785; Tue, 18 Jul 2023 07:39:22 +0900
X-Iguazu-Qid: 2rWhJyZQYTbdVtsDZo
X-Iguazu-QSIG: v=2; s=0; t=1689633561; q=2rWhJyZQYTbdVtsDZo; m=hbg/GokJOW88gVJsa48UiVYt95EJoEMnNIJ24aPs+4k=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
        by relay.securemx.jp (mx-mr1122) id 36HMdAqU2024109
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 18 Jul 2023 07:39:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ix3S2ymLBsPL5aB/WX//vzwvTkn38vxAQp4wuwTPqe/D1i8z/hBO+dS+cs0s/i/RlZqp6ZTwIuxKtm0d2RYAhNLJdRxvDgzvWCjS5FVtoFBdpnuQvhxu3GI6ZK1HNJEVy7pKWDPtCfnbkl4rJv+CIdtrS/8UHRcvhnNEMDQJf2MLQFfx9gsEZqxVYUiXiAPEI780H7VqHyV6gPXraeyc3RohiL19+syM7HVhI4GGpPK+GED0Zod02qx4a2R/XdcxQdIGw5wlWD1hZ1k6uID6Hfi5s5b0/5ZsINy5xTomUb46xkcBgjQXEU+xmBbfcRktQJvYbeGKuKEghvnSQkOjbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVykzySwJpYcPUmkwHiVkpkYGIAvueolxxj/pfXEZEY=;
 b=nF5znQd0hWeJILbUylGAMrJxhh9971/b5yQuoZUmyt6xRBDwJib9hQOKhjXsCFEG/IXgeGhWmRLVIsFPBLYQE4nuuHN/ZgzZQNyou+Wz+7bvcig598+NNiaTqaRiQI/Zr3RcN2ANRuxUJVcdT3atop8SaD+ceaxfTJu19tN4HvO+sZj75URJDC6vvc5ELkKgZHdA0pzahPV7+eKYxpsaDwET7P9i+vG8YkADjKtEXlNGpH5QTfhWlBrMTmYSMZ0Eu8SIV9nsiX6pliJVKuiBxCxnxuu5ifyRbyX9ghQJBnEwZOb38RV0jumn+bN3cEZOSZts8zc3ygr8nd4TmZdRFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     <robh@kernel.org>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <marcan@marcan.st>,
        <sven@svenpeter.dev>, <alyssa@rosenzweig.io>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <bleung@chromium.org>,
        <groeck@chromium.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>, <paul@crapouillou.net>,
        <vz@mleia.com>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <conor.dooley@microchip.com>,
        <daire.mcnamara@microchip.com>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <michael@walle.cc>,
        <orsonzhai@gmail.com>, <baolin.wang@linux.alibaba.com>,
        <zhang.lyra@gmail.com>, <wens@csie.org>,
        <jernej.skrabec@gmail.com>, <samuel@sholland.org>,
        <hammerh0314@gmail.com>, <jonathanh@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <asahi@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>,
        <chrome-platform@lists.linux.dev>, <linux-mips@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-tegra@vger.kernel.org>
Subject: RE: [PATCH] pwm: Explicitly include correct DT includes
Thread-Topic: [PATCH] pwm: Explicitly include correct DT includes
Thread-Index: AQHZtnuOZnDWlkRtFkevk2lzTg3PG6++kY5w
Date:   Mon, 17 Jul 2023 22:39:05 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB9420C0C22F51CA8DAF482B81923BA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230714174852.4062251-1-robh@kernel.org>
In-Reply-To: <20230714174852.4062251-1-robh@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TY3PR01MB9683:EE_
x-ms-office365-filtering-correlation-id: 3e65e535-dc8b-43a8-50a3-08db8716a089
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kcEKIZH9a4Mgw1ka3mFFZNrACZQ8RKiqJ8lU/BbVUjKKOkyBlxuimcIFEGrNJyc/ZVPB1dc0ZPnj1hY+5ZUd1xYRHUudoyb4XxRORVjBj6zKEjtyOnR43KAiZihISKYWoLAhiUEmMN4XH+/EJdEjwH1iY+TUa3/pvMZdpmmQ36k0wHIGfkXPxF+0SNIH9gbkU+6jNWJMGmdcAJ+tBEEgPWsJrL7zbTMyVuI2HZLrqsMN3J1SGgHPE5KtmAES01HpgGRcxSd97KDst0rmodelvr0AwfPf3yQs6cDAhgYbE9j9CZcmUC916MwkEQLvxcM+WpJ0eK3xwRFbzg9HK5BArQeakdKFuNy2SYuRFjjMFQQn2/Q9ellgSjAUxjpC1PUDE9ri/cACsWZvRHZ6DoO1pgmmQjKUIHtZ8XK20t0Abb37FmKR9xQq6BQYqYLrSW3QNUTIzsbxaRRqgLwIYdSLdmTqo88k12N2cdds3xaJUhEx5XkyzZ8PlEbSUadgqZaSGQpJ8pVubCgRNLA8pHJWkt1wuq/MUwY5vFU0XqWWdpBCXPjK7UtvrcwSEX0nHc50gXEMVnJPYaiyYDHEaz14kYqfRdEFfjnkOHSADm4iFjuJPMyrgEwtaari07XM4ybVsPJaxjIUuj7gK8W5YVWbAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199021)(38070700005)(38100700002)(8936002)(8676002)(33656002)(2906002)(83380400001)(66574015)(52536014)(6506007)(26005)(5660300002)(53546011)(55016003)(921005)(122000001)(186003)(7406005)(7416002)(86362001)(316002)(7696005)(71200400001)(4326008)(110136005)(66946007)(54906003)(66556008)(66476007)(64756008)(66446008)(76116006)(478600001)(41300700001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkN5N2htNlEwZkN6d3FQd2I3UHJZRWNEODc4dzZkd1JFTUcyL045TitLZWxU?=
 =?utf-8?B?bGJKRkJ6NFdhcnEvZzZXWE0vUUFRaTVwQUpSQm9tMThLTVB5NU5Hajg1ODJ3?=
 =?utf-8?B?WU5zMTdtZ0Iwc2tRVTc4MUdPNnRXUWtyZGJIT0VPMHA4ZzF5c20wZk1XVW82?=
 =?utf-8?B?a01nb3ZvS1luRHBaSEtMNHdSTWhUdnNXVnhNRkk1K1ErLzlMdll0QWpteTdh?=
 =?utf-8?B?YmR1VnNNQzlpeitlNFp6UHhFaVd0NHpuSFJmc01QMmtCaHEwQ1NrOFdjcWV0?=
 =?utf-8?B?L1BzUlZEQ2tORmw0bWtvZEpFTDJMZ3U1UWY1RHlwY3Q5OWFkNnRJQmdCL281?=
 =?utf-8?B?aDJHNmQ5VnBJamV2Qmp5Ly9GeWRyMUFQb211NGd6ZGFxZVNDcHQrNWh1cG9r?=
 =?utf-8?B?ZmtzcERLMGIxQyt5MUo2Sk0ydFBrOHV0TFRoNU5MUHgwZWZ3c3JPQWx0VXdL?=
 =?utf-8?B?Nnc1bzVDZ3AvcE1OazltZkZwK2hQTU9HWWpXZzl1Z0FQaWNwOExjZTJOZlNr?=
 =?utf-8?B?SytFRkNPMXBjdlRROHd4ZEt4MmRuNHZXaVJUNVVEcUN0S1J1MCtPMXoxNzBG?=
 =?utf-8?B?ZEthaHkxRjZhZk1iKzM3QzVINkwzWjR1UzJQTFZoRHFTcEdma3Y1bTFxczd0?=
 =?utf-8?B?ME1LNHl5bjNvRW94eG5KR1JUSGhsM1JJdmRCT09KL2E0TndHMWgzWlFRWHpE?=
 =?utf-8?B?QlJqZTdFN3JUN1VvRlhOMWEzNDdmTFRWYWN6dXF4aUVQZG1IanI2cFB2V1Rj?=
 =?utf-8?B?WmhoUTVubkRNYXc5RkdubFdzYUtCQkt3Q2tqTVdmeHNRYVgrclMyNVFSdG85?=
 =?utf-8?B?azdFYXRON1RrczJWUGFKYXBPRDJaUmdMTUpxV01tNGJUWEQ2djE3VHIzM09s?=
 =?utf-8?B?ZThON3A0TlkzVGJNUW1zajJEcWQwVWFBWTlQb0U0QXMyMnJLd2N3ZHVWUW1S?=
 =?utf-8?B?YmdqbndyaDBORkxKWVNTSDZvYm4xMTVWbTNyZnJVRi8xemFzSnpYQVNNK2FJ?=
 =?utf-8?B?MjhRRlMya2lGVG5lSldNM1M1bHFTZ2RTVGlOSVQyNG9wa2swdGpsa3lnQzNh?=
 =?utf-8?B?ci95SWpjOTh5ZVFVck9QVnBGbTZPS1Y2TWNxQ2RvVGVscGhLTlF5RktuVzhk?=
 =?utf-8?B?ckNVYTFIMFJVYVQvU2tjS3lWYWpPVWtrcFNhY2p2MDRsM2dVcDZsUkVRdEpS?=
 =?utf-8?B?emVpNzczVTF6R3pSMEZQU1M1YVhwbjdXQVJXd2hkY085WmMxQUh5U1NqaEhl?=
 =?utf-8?B?enVLbXgxbXJndWdYeC9XL0JkWXkyQnlBaitPa3puZ0hnMm9lZVlGNEVoUFBG?=
 =?utf-8?B?ZS96ZElMU0k4cCtNOUtINVY0NTNrUFlxMFR6eXZLTTFEai9taG1BbUliSFBI?=
 =?utf-8?B?WFhpbjVtRTdib2N3U2JvZmx6VGNVVU9qMjd5c1pJOEZJTXYzMEdsNHBDQTc2?=
 =?utf-8?B?d3FHRkVWYUl2cGM0bDVldnhEMHBvYi9wUHBkeGtJSnU4MDdQVG9hWm9hdGpI?=
 =?utf-8?B?cU9DT0ZoSWhBMXUyNW9UNzlRTHgya2g5Z1RQbHBocjVBcGhsN1AzL3lvbi81?=
 =?utf-8?B?MGdJUjdFZEJ4Qy96V1FvSXYrY3c2Y0Z6UG1iYTNCZjNRMGtUOHpCeEw2aCtk?=
 =?utf-8?B?eXloWStpSy9kckNVZ1JWcU9pZEp5SUtnRExsN2QzMHk5QkR2UmtlakQ3d2R3?=
 =?utf-8?B?QzgzbzFYVytmc0YxNG1zQ3dxQkdaY0dpWmFxaUhlem9EUE5ZcU5GbmlFaW9S?=
 =?utf-8?B?UHpIUnBmd2toVmFSak5MaVgvOUxhSEoyQW0vSElia0REWjRiVytrRkdaMUJw?=
 =?utf-8?B?UHVoT21ZcGlMYTBWMXhHTlppT2kwYkJIUk9mcEl4SDlHRTlhZjdaZmRjTFox?=
 =?utf-8?B?OHJOZ1BZOHFjUXczaHF1OGZWNlk0aTdoUWI0T2F6QVFXUVNBdkMxL2tGV2Ry?=
 =?utf-8?B?dWY5cWRBdmxRNWp1eCt4clNSdlhHMUJsQ1B0STFDcWpWc0JtbCtURjdOK0Z1?=
 =?utf-8?B?K2h4ME04SlRMNWU2bGJncEhBZmhUdU45SFdCRWRrWlFucUl2Y3RUZjM4MUJJ?=
 =?utf-8?B?UDhNUElOM01ZSVl2U3A4THR6Sm01NnBFQ1VmTi8yMGNVQ0lSWjZpSUR1VEQx?=
 =?utf-8?B?VzF2aHREMGMxS0JaRDdnck5tZ1pubUl6elpCOXpIdXlWK0JueEMrSmZRNkF0?=
 =?utf-8?B?N1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dXdrOFJlYkk2ODVPTnZyREplUEdpYVF1eHRaeFovOFNtb0c0Z1dnV2tMRGZZ?=
 =?utf-8?B?RnMrR1pwWUF5S3NZRW9ZUzhjTGFpK1NtUHRpTHdsMVhlNEN3dVZDNk5vNThP?=
 =?utf-8?B?VWJOekJ2elZuaHdtZCtlQjh2bERjaDcxekh4aVA0Y1NoVUxVckNmR2RHa3Nv?=
 =?utf-8?B?R2l3TWN4Z2ViTEtWSzlheDJ1eTFWU21HZVllQ0s2a2RwZ29NSEJhWGhib1ZB?=
 =?utf-8?B?QUFTdlptS2hPMXpKb3NGNVF1QmVvVWlJYWpUeWtHZ01Ya2xCamRLc09vZStr?=
 =?utf-8?B?RGZUYWVTQ1hqTHlVdFg1a0J0aVluWklKTlZLOVV1UHVhWXB1TFBvckRpWEpT?=
 =?utf-8?B?UXVOMEZGaXdqS1duSHRBU3dXdGRXSFd3Z0t0cDFTMkh1SzQ3Zm1rVnhnbmR0?=
 =?utf-8?B?LzNCdm41alZrSFdUK0RXQ05ZWFY3d3lKd0U4VC9WSDkwMkwxNWVQVWtWZGJU?=
 =?utf-8?B?ZGJtK3prNUNkUzlGOFB4Mk1HWlNPRXYxVGRoYW1nbzRVaytyWXFSc05SZ2do?=
 =?utf-8?B?d1pXKys2WHU4S05RU1lkSzFzRVUzNXVHLzRmTGVLdDY4TWNmVkxuTVEzNEFF?=
 =?utf-8?B?alZGenlGTlFZeFdGL3R3QkpORHFMcXoxVFN4bmlLZzVaTExRWkpsSnBEQkFI?=
 =?utf-8?B?c01SeDl0ckRPYXRqakJNM1hmNi9ndUFjTTVjZG1RZ1Fqb1R4dXZVeUp6ajJK?=
 =?utf-8?B?ZXpqNE1QTjVzUTFUUkVpMXJwbmVndHBFN2VTREFWcXRWbTF3bHdSeC9FYmow?=
 =?utf-8?B?NGkwcktTN09TUEp3bzREN3B6aThyR0Ezb2FTQ09OS3krUWU4d0w2QThuSDRW?=
 =?utf-8?B?RlB0bXhTUE42VGVDK3U3NkJGTWN2dkRkUWhodGhpbWlqdWVlWCtUS2NwdkFI?=
 =?utf-8?B?eEJ1UTRBdDBMMmp6aGVxNGVUdTNveTBUa0NvdkthVUFSb3kwQmV4SzRicmNp?=
 =?utf-8?B?blFTdHBWQ3UzNVNyQkQzQTdDVFFVL1d4OUpSMzdsaXFZKzA1TWRvaDFKUmJL?=
 =?utf-8?B?MjBZcjJ5cmQ0bE50a29Zc0t1L1JDZk9ZSytvRHhZSkQ1Qk5DWkU2S01oTm9M?=
 =?utf-8?B?bVdsb2J6QU9hRUFKQjZxc3VOclQvOHRuNGoyMVd1TDZtYkRrNmJTMStpRjNK?=
 =?utf-8?B?UXg3WjUvYmgxaG14QWhGZmUrYmVSMEhlQnI2YzNQMVEzbnU4dG1DNHZsSHpI?=
 =?utf-8?B?YXRsc2JPZVgzQlZKTktldGdYV3NjY21VelF1elE5bnZYOTdIcHIxNWtjV2xZ?=
 =?utf-8?B?ajR0bFVHRWxpYklDVCtVRFNHVklyNWpYeWtFSWMvRE5WdEU4bnd3elBLWXlr?=
 =?utf-8?B?STd4cFoyYzlia1FybzNPYVc5a3habU1HSHFHQ3psZE15ZmJkY1FHditUcEY1?=
 =?utf-8?B?Zk9IMUt5NG1UT2prY3JPU2dPSmRkRVRVSjFtQVJsRlI5NGM4NEN1aERJRWl3?=
 =?utf-8?B?YjBhZ0lEbzFZUFU3QUdKQmNDZDdjWG8yamcwRHdZL2tSYzNWZTFLbjN6RWVX?=
 =?utf-8?B?SWxOMlI5bHNJenZrYWlxdVRjM0xoNWZQY3VtZ1NZbmpKMjVTZU8rcTZnQzlh?=
 =?utf-8?B?TEtNTmdDVktZeGE3VytwZ3dsaTBkZTd5eXZ5eE5jWGZ5WDNwaW1xYkpLUDc2?=
 =?utf-8?B?UGVCWFRtVXlhTSsxNldBZUszbXplMkRuWUdKZUphOE51c0ZSK0ZBczNkTUts?=
 =?utf-8?B?a3dHNE1kK1ZCL2JneEZDVE4wWmtUOENQZUlobmx1OGlRQnNkMkZUbEk4WkxB?=
 =?utf-8?B?Vk1zQXJPNFFOYjRoSk1qM0xQVFR3dTl2QW94L1MyRVZpR2xUcW05ekgwdUdI?=
 =?utf-8?B?L3A0alVIb1RxWVFQRDlVdzN2OTUxUnpPRVg0ZjdRVmhCVGxsd2pFcnVuQlBx?=
 =?utf-8?B?b0VWVm5POWR3ajcvWFQ3U251Z0VsWksyaXdKVWVtSFFqbHhTSEswUjZKSDNG?=
 =?utf-8?B?aS91VFJVT21Vc1gzekJYNFJXTkk0c3QxblN2b0FObXFlbTNybGxXYVF1a29n?=
 =?utf-8?B?aElsajczcXhKS0svcjRHUTNxTGtBem1zaU14eWFjVjd2UXdONVhTY2lwQ2d1?=
 =?utf-8?B?c3ozbEo3STRvRFFNSENDazMxN0VrUUcxMnIzRlMxQ2F2RjEyd1ptMU03Z0Zq?=
 =?utf-8?B?cGRqRDhoK1R1QUFEc1h5OXdPeVNKb2xzcXVIVC9sTXV4Z0Jmb1crRVQxRWFC?=
 =?utf-8?Q?kF3SCwT7QzYbCnI0yj+3ogThTUhlnS3opycmHE0vsiPx?=
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e65e535-dc8b-43a8-50a3-08db8716a089
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 22:39:05.5061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B4jTJ7i6NDZsLa7/ld7qvU5wbP3/d5IzCd20kvxQhYG0xwCGHcaQZTqyzgyTqvln1BEsJuYavuYFJXy/vaBy0l+Al7ToplXnAUUVVQZmBzdnJfhm7zB6EWx+6M+6cXl2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9683
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcg
PHJvYmhAa2VybmVsLm9yZz4NCj4gU2VudDogU2F0dXJkYXksIEp1bHkgMTUsIDIwMjMgMjo0OSBB
TQ0KPiBUbzogVGhpZXJyeSBSZWRpbmcgPHRoaWVycnkucmVkaW5nQGdtYWlsLmNvbT47IFV3ZSBL
bGVpbmUtS8O2bmlnDQo+IDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+OyBIZWN0b3Ig
TWFydGluIDxtYXJjYW5AbWFyY2FuLnN0PjsNCj4gU3ZlbiBQZXRlciA8c3ZlbkBzdmVucGV0ZXIu
ZGV2PjsgQWx5c3NhIFJvc2VuendlaWcNCj4gPGFseXNzYUByb3Nlbnp3ZWlnLmlvPjsgTmljb2xh
cyBGZXJyZSA8bmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tPjsNCj4gQWxleGFuZHJlIEJlbGxv
bmkgPGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29tPjsgQ2xhdWRpdSBCZXpuZWENCj4gPGNs
YXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+OyBCZW5zb24gTGV1bmcgPGJsZXVuZ0BjaHJvbWl1
bS5vcmc+Ow0KPiBHdWVudGVyIFJvZWNrIDxncm9lY2tAY2hyb21pdW0ub3JnPjsgU2hhd24gR3Vv
DQo+IDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJv
bml4LmRlPjsNCj4gUGVuZ3V0cm9uaXggS2VybmVsIFRlYW0gPGtlcm5lbEBwZW5ndXRyb25peC5k
ZT47IEZhYmlvIEVzdGV2YW0NCj4gPGZlc3RldmFtQGdtYWlsLmNvbT47IE5YUCBMaW51eCBUZWFt
IDxsaW51eC1pbXhAbnhwLmNvbT47IFBhdWwNCj4gQ2VyY3VlaWwgPHBhdWxAY3JhcG91aWxsb3Uu
bmV0PjsgVmxhZGltaXIgWmFwb2xza2l5IDx2ekBtbGVpYS5jb20+OyBOZWlsDQo+IEFybXN0cm9u
ZyA8bmVpbC5hcm1zdHJvbmdAbGluYXJvLm9yZz47IEtldmluIEhpbG1hbg0KPiA8a2hpbG1hbkBi
YXlsaWJyZS5jb20+OyBKZXJvbWUgQnJ1bmV0IDxqYnJ1bmV0QGJheWxpYnJlLmNvbT47IE1hcnRp
bg0KPiBCbHVtZW5zdGluZ2wgPG1hcnRpbi5ibHVtZW5zdGluZ2xAZ29vZ2xlbWFpbC5jb20+OyBD
b25vciBEb29sZXkNCj4gPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPjsgRGFpcmUgTWNOYW1h
cmENCj4gPGRhaXJlLm1jbmFtYXJhQG1pY3JvY2hpcC5jb20+OyBNYXR0aGlhcyBCcnVnZ2VyDQo+
IDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPjsgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8NCj4g
PGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT47IFBhbG1lciBEYWJiZWx0
DQo+IDxwYWxtZXJAZGFiYmVsdC5jb20+OyBQYXVsIFdhbG1zbGV5IDxwYXVsLndhbG1zbGV5QHNp
Zml2ZS5jb20+Ow0KPiBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNjPjsgT3Jzb24gWmhh
aSA8b3Jzb256aGFpQGdtYWlsLmNvbT47DQo+IEJhb2xpbiBXYW5nIDxiYW9saW4ud2FuZ0BsaW51
eC5hbGliYWJhLmNvbT47IENodW55YW4gWmhhbmcNCj4gPHpoYW5nLmx5cmFAZ21haWwuY29tPjsg
Q2hlbi1ZdSBUc2FpIDx3ZW5zQGNzaWUub3JnPjsgSmVybmVqIFNrcmFiZWMNCj4gPGplcm5lai5z
a3JhYmVjQGdtYWlsLmNvbT47IFNhbXVlbCBIb2xsYW5kIDxzYW11ZWxAc2hvbGxhbmQub3JnPjsN
Cj4gSGFtbWVyIEhzaWVoIDxoYW1tZXJoMDMxNEBnbWFpbC5jb20+OyBKb25hdGhhbiBIdW50ZXIN
Cj4gPGpvbmF0aGFuaEBudmlkaWEuY29tPjsgaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0
iyDil4vvvKTvvKnvvLTvvKPilqHvvKTvvKnvvLQNCj4g4peL77yv77yz77y0KSA8bm9idWhpcm8x
Lml3YW1hdHN1QHRvc2hpYmEuY28uanA+DQo+IENjOiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtcHdtQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgYXNhaGlAbGlzdHMubGludXguZGV2Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IGNocm9tZS1wbGF0Zm9ybUBsaXN0cy5saW51eC5kZXY7DQo+IGxpbnV4LW1p
cHNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hbWxvZ2ljQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+
IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LW1lZGlhdGVrQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7DQo+IGxpbnV4LXN1bnhpQGxpc3RzLmxpbnV4LmRldjsgbGludXgtdGVncmFA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSF0gcHdtOiBFeHBsaWNpdGx5IGluY2x1
ZGUgY29ycmVjdCBEVCBpbmNsdWRlcw0KPiANCj4gVGhlIERUIG9mX2RldmljZS5oIGFuZCBvZl9w
bGF0Zm9ybS5oIGRhdGUgYmFjayB0byB0aGUgc2VwYXJhdGUNCj4gb2ZfcGxhdGZvcm1fYnVzX3R5
cGUgYmVmb3JlIGl0IGFzIG1lcmdlZCBpbnRvIHRoZSByZWd1bGFyIHBsYXRmb3JtIGJ1cy4NCj4g
QXMgcGFydCBvZiB0aGF0IG1lcmdlIHByZXBwaW5nIEFybSBEVCBzdXBwb3J0IDEzIHllYXJzIGFn
bywgdGhleSAidGVtcG9yYXJpbHkiDQo+IGluY2x1ZGUgZWFjaCBvdGhlci4gVGhleSBhbHNvIGlu
Y2x1ZGUgcGxhdGZvcm1fZGV2aWNlLmggYW5kIG9mLmguIEFzIGEgcmVzdWx0LA0KPiB0aGVyZSdz
IGEgcHJldHR5IG11Y2ggcmFuZG9tIG1peCBvZiB0aG9zZSBpbmNsdWRlIGZpbGVzIHVzZWQgdGhy
b3VnaG91dCB0aGUNCj4gdHJlZS4gSW4gb3JkZXIgdG8gZGV0YW5nbGUgdGhlc2UgaGVhZGVycyBh
bmQgcmVwbGFjZSB0aGUgaW1wbGljaXQgaW5jbHVkZXMgd2l0aA0KPiBzdHJ1Y3QgZGVjbGFyYXRp
b25zLCB1c2VycyBuZWVkIHRvIGV4cGxpY2l0bHkgaW5jbHVkZSB0aGUgY29ycmVjdCBpbmNsdWRl
cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQoN
CkZvciBkcml2ZXJzL3B3bS9wd20tdmlzY29udGkuYzoNClJldmlld2VkLWJ5OiBOb2J1aGlybyBJ
d2FtYXRzdSA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+DQoNCkJlc3QgcmVnYXJk
cywNCiAgTm9idWhpcm8NCg==


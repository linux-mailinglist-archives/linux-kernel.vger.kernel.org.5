Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11723787E39
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 05:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjHYDEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 23:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjHYDEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 23:04:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478C8198E;
        Thu, 24 Aug 2023 20:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692932652; x=1724468652;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=e3veAXDLoNx2S3JlL6+cREwvahciTsoQlf8Ogn3oX78=;
  b=RbweErKHK9ELMp3eOlf1OmLdbGN3/f5afmVt6aE0SElkoxfyY8cmSLjo
   lz6A0qWw/UnyyKSb4zsR59osQTG2suJmErNl1Zj3MYvvU6OVkScsaaiYx
   ao6wcq7/r3kEYldwO9jO1zrTfEXtcyF2V1N/eP2Lf+0phPZV05cdUEyZy
   1fjroAN9pCSR7rdSgMGpqbKRSp/Tde4qi3lEQibXsVbNQL5h6wln5yFOJ
   LN7IZzN/wcHQ7wK5tIlTeZJS/vYbwm5oaDa7n2AxdLPS24iEbQao2MQq8
   Ic07744cbCDlAfdXheaFa/8seY+lxrMfqp+vTJf12QDnW6aMuWevSKeAp
   A==;
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="1205325"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2023 20:04:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 24 Aug 2023 20:04:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 24 Aug 2023 20:04:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cG9EmM4mbccve7c2jTQ5Bhuhs0wF3zaKgzmPn0eXP3qdOpAbpqCvTG83HJVgsqzmhATogneLTHBATgfbFW1oHBeHabrLdJZN0F34s5WLmZF3hQaQMeHH4u3ZghJURkvVct+vQ1fMAkevgvI1hSCW37qCxuM1AbR8JZNzmP9f63Ac2KXO1bKHBoUK/4aqH56mSbuLV0x38QrtehqcAlghD3dd9XAX3NFMAF0P9zblkLDy49viOrEKDRJAjnUxhUYMGSgT3f3uZh5fGG3ZbcrN5pg/7uTrSkhzJwqXrqKz4lPSkUa0kkvuOGuFtjoOWW5IqdnReLq0eomq1X1k/9kzPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3veAXDLoNx2S3JlL6+cREwvahciTsoQlf8Ogn3oX78=;
 b=i350zMktgLmgg3NnGKZR+9pJiFP+cuOU6ndMMxyksVMxcrjeqUMIA0xSRqmSm2LhrDPi0F98z27QwfLBZHT/IsRC3Lgm/yimN0HeodiHcO1/TBgqFIwiwmLxY607Ss3y/z1Gy9Tk7p9rT/fYGgdSb91onL2kd3WcSH2hKSHFt44J5YSHwLFfOLWv6v3F4ZbfP5bJgQ0IJ2CwbCajZqEkcSPyHJoYMn80nhnCVFB6LyuPfDr728pdvXkSIQJjh9YR1gtSLfAfDwEKzzmUAJS9KmJmykx3opchDVw8picokyHRTGA5xY61Y+BAgCMRG8vHwvcVt9Fy+x2ELFp9UshK1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3veAXDLoNx2S3JlL6+cREwvahciTsoQlf8Ogn3oX78=;
 b=Wt+r1RI9jrMBER/JALwhz7o8fS8DQi2zX1662BydM5Blnu6xfc1NZR0CHfRG39IuKL34abskGXuCmDmv1RfAGpCGKHTSsmWu4jQ0f65AZ2hUtq7vtzqzcSHFEpV1KKaWgLHUHiIWjXg4cnyLHBFnReNXMd+NIgqxbmO+Sw0Vl3s=
Received: from DM6PR11MB4185.namprd11.prod.outlook.com (2603:10b6:5:195::29)
 by SN7PR11MB7537.namprd11.prod.outlook.com (2603:10b6:806:348::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 03:04:07 +0000
Received: from DM6PR11MB4185.namprd11.prod.outlook.com
 ([fe80::591f:32f4:3319:e1f8]) by DM6PR11MB4185.namprd11.prod.outlook.com
 ([fe80::591f:32f4:3319:e1f8%7]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 03:04:07 +0000
From:   <Hari.PrasathGE@microchip.com>
To:     <claudiu.beznea@tuxon.dev>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pwm: atmel: add missing clk_disable_unprepare()
Thread-Topic: [PATCH] pwm: atmel: add missing clk_disable_unprepare()
Thread-Index: AQHZ1McFXqoL6VNackGp0/iqpU7uIa/3U4oAgAMEh4A=
Date:   Fri, 25 Aug 2023 03:04:07 +0000
Message-ID: <2aab2c4f-cff5-f13d-e879-a5b1b00ef9c7@microchip.com>
References: <20230822070441.22170-1-Hari.PrasathGE@microchip.com>
 <5663e3e6-de16-e9ba-0745-b9a40676b109@tuxon.dev>
In-Reply-To: <5663e3e6-de16-e9ba-0745-b9a40676b109@tuxon.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4185:EE_|SN7PR11MB7537:EE_
x-ms-office365-filtering-correlation-id: 55c6917c-1946-4b4f-aa01-08dba517f28e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AO0nNYUiPig55xZIpUNkW07fvBXhOIAClATBMHkDhTUwj4larW8xGb2kg9Kj2O/sTnMW6y+GU1TJ+kDpnf3BC5p/qWWaFGSkK07rYs1472/uiJTqXoiHsjusHsKTFFz7Rwc+73ksxe+Z6RMeOKgGXguVq6INfDajAWnOATaow1CVfdyrA+/HDLiaJdqPf1W8bjRoURmgPK4HcH5wPYQrKWX6gv6MmDv450t7+K0XXQrqqD1LAtLLszfif1pTOCXFE/9WCRGp6pc5YmrBhM+ZUgR6YM9iRhIo5A2s3yhvMGozvtv2qyfKqd4G7HZimZwQpwxVrZQ2uaQfviepV8UBjYXhcSAguw4e4nsin5EBLeP32wjJnK9QM7UBR1TObN5XOajv05dOt4JB0F4/EzefTnzefEbm0VXl+tkcgLubJCD1E8tRulwRhIQk8nTM27X4UjP79v64IWw8V8hQK/UA8R/32XiJNfv/00jLdlpjPz8d5tGhjoawHJ9f9i/RjPWXf3HN2q6MaIyj8hCbLlTWk4GWL6U6E+CJA6oUnqgECBoveOPSvpF1dNgycwxXgwGqItkqRJ24h9gHgzesfPvAocjfwPYT8CbqUGwkvMrwZoonSHaBVJSb0AsyKxgg5MU0d+ZTLSl9TnsWYi+g8m/tnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4185.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(186009)(1800799009)(451199024)(2616005)(5660300002)(8936002)(4326008)(8676002)(36756003)(83380400001)(26005)(71200400001)(38100700002)(38070700005)(122000001)(66556008)(66946007)(66476007)(6506007)(54906003)(64756008)(66446008)(76116006)(316002)(91956017)(110136005)(478600001)(31686004)(53546011)(41300700001)(2906002)(6512007)(86362001)(6486002)(31696002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGt2VnJrTzNkNDg3VVhHY2xwRkhENzMxY1czZTNpYUE0SUxUVUZLYXI1cUp5?=
 =?utf-8?B?Rm1HTWZDWExKdjE0NmdUYWxKSUNkYldLcXVuckVMdkJpZHA1MUp4bDVTa1ZF?=
 =?utf-8?B?N0hDSldtYXBaalhza1M2OW5ZbURjWS9PUDJFMjVySnVTZHAxOWdKdGVOb2kz?=
 =?utf-8?B?NzlodlFURG93Rm5JbURHRWp2SkdTdGlERHhpcjl4c1VGYVJVQVJYRktDTlk1?=
 =?utf-8?B?TjJoZC91RkhoMEcwUUp5SjlyTmcvVVZDSS8vbUZNU3BUVURUUE1ubXdRc25s?=
 =?utf-8?B?YW53bWJlaEttdHR1RjlYbjkvZW9Oc2g0TDJiUjZmVkNmWEY3Y3NsZ1ovc0Ex?=
 =?utf-8?B?UGo0dWFIV3lCL00rNndkSFk2N2lUR1FHWjhYQjFiU21nLyszZS9HSHR3dmdh?=
 =?utf-8?B?ZDNxcUlkMWY4ckNQQmNleEYzTlVRT25rcE1MRGQzS1BNSDU2Z0VuZzZrWGYz?=
 =?utf-8?B?MUxGYVNISEI4alNDUnMvRWN1UHZUdWJReFhJMXJOL2xnWFdRbVcxSzF2U21v?=
 =?utf-8?B?a1NWZ2JLZHg2bjNDT0JRSjZmZ3BDSm4vdkN5Z0ZSVjU3eFhjcUZaeFk1c0Zs?=
 =?utf-8?B?c0JEZzRtL1puUDZpZ0pIQTZDQVFvWFk5MXNzd09sUkhEWnBFTm5YWng5aUlD?=
 =?utf-8?B?eUpaVXYyNFR6U0piWXNmdXVYSjZNeGpyYjlpN2NBUHA1bVdJcXZWSDc3WXVz?=
 =?utf-8?B?N0FtMEkrSDg5N1hBUHpOWG4xZ1NhT2FxOTdCRU1HRG1rNjdpMEMvQkVNVk5Q?=
 =?utf-8?B?YUM3WUVIUDhKTmpIQ0U5Y2tnUTI1b3pPRGIyQ1RBZWcweHJQQTJJdDZKcE45?=
 =?utf-8?B?UDkrdFF0c2Y0Rk5KbmVpL0tBdWdEc3RxTGQ1MzJLNWs2dU03MksxR0t4SDl1?=
 =?utf-8?B?VWk1YTdZaVMrMndiaTR2WmU3SzNvY0RMZ3V3VVM3ayswendUSlZuWjd6VVk5?=
 =?utf-8?B?QWlJdlVvc0pmSTR1Vzd1TXhxeTV0d1pCZUpnb0t0TkYyWTF2VUpySVdLK0dO?=
 =?utf-8?B?SFZpcHpXeC9MemhQcjcwWmpBOXZCd0prZ2d2ZkR1ZjlrWFkybzVoNVpKQTQv?=
 =?utf-8?B?ZGxsQ3BZcng5MHhmRDhzVTN0blBzY28zbWZYZk5aTmRBcXo0OFEzY3l5b2RC?=
 =?utf-8?B?UjZNRzNhQnlWV0ZoSVJ2NmNPdURjeSs5enZCcGU5RzRaMzRVam5VWUc2eFJv?=
 =?utf-8?B?RGdBeHlla3VKdk9TTmljY0ZDL3R6bzFaZU5lUElHNlAzZm1IdUtLUklUQWtM?=
 =?utf-8?B?VENtV1hBUy91M1lreWJIZnVlNTdNQVBkdE9Tcm0xOStUVWZtenZLTzU2YUJM?=
 =?utf-8?B?M2RBdldRWUNrZVBhTFZMY3hMVTJsUUNrM1BlcWVCSDg4WXFkRXRXSDljWWlz?=
 =?utf-8?B?R3ZSbWcrRkYwRG50UEF6RVRjLytkWEprWm1GY0ZPNTNCWlBJT1IwZE1CVWJU?=
 =?utf-8?B?V1ZiWUNnaTM2YThMYzRXdEc5S0RCS0NzekY1d1hGcUlRcVUraUp1SVc1cWxF?=
 =?utf-8?B?MGdDcytaQU5qK2ZlQ3FtMWs3c2d1TWNEM0s2WndVbFN0NGhwaHdwcnRsTk8w?=
 =?utf-8?B?U1ZqKzRtNnVGN0diQVU3VEhENUxQYWNDRlJJSi9Jak5yNFFETHpZZVpBOWNm?=
 =?utf-8?B?MUM1S0tNM0RicmRzWWZOdTh3cGY3UnRDY1JoRDlrVjBiT1VXRVNUTGttY0tj?=
 =?utf-8?B?YkNTY2IyNEJBL0xZVzh2UGZSTzJhSDFxL2hGQ1czUVdCRDB1OWlJTGpvWmla?=
 =?utf-8?B?bEIzNXREemNqcGdHYm9VZExiUEZjbVNMeFhqTTBMbWlzVEQxQlVSNUNxYmFN?=
 =?utf-8?B?V0F6Q1hnTVFPRVBsUld0TGxPN0FuMDlrUjlHRkhmSjNvV0Njc1BSbW5JV2tI?=
 =?utf-8?B?cFNwM3NCNzQrOXA2OUFVeXdjdXlzREhxb2taVFVtamVDNngvdDVPWngvVzYx?=
 =?utf-8?B?RnJSWjQ0bXNhZjBFbVEvZXhGS0NUcUNOMnJvaVA5c3VHM0kzd01IN3RxNGJC?=
 =?utf-8?B?YjNRbVpOL0Y3QnhETXJHR2hnemg3Zkp2bWRreXJjbVhQVDJucWhDMXJ3Q1hC?=
 =?utf-8?B?YzdNMGlERldSTExMNTVZSklQeHowVUJGZDN6Y2psVmxza2dnK1hGZWFBZWtv?=
 =?utf-8?B?dzZVdlNNWWkxaVdaQ3FucGNKQUI4MUdEMHBzQVRJeW1FSW1ReVhub1hxN2Ra?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5849D4B162DEED4A91DB011E4922A9F2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c6917c-1946-4b4f-aa01-08dba517f28e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 03:04:07.4845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BfcTpX+gfphf1ZxWWOjIpqOhJ3Q7u36mu954x7AAvFqdSm1+tKC+ju4HAZRw7cSo0EfjcAxiCkLHcDcXLrfITKUtRF8MhftvIH7bL/R52zo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7537
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gQ2xhdWRpdSwNCg0KT24gMjMvMDgvMjMgMTA6MjkgYW0sIGNsYXVkaXUgYmV6bmVhIHdy
b3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDgvMjIv
MjMgMTA6MDQsIEhhcmkgUHJhc2F0aCBHdWp1bGFuIEVsYW5nbyB3cm90ZToNCj4+IEZpeCB0aGUg
YmVsb3cgc21hdGNoIHdhcm5pbmc6DQo+Pg0KPj4gZHJpdmVycy9wd20vcHdtLWF0bWVsLWhsY2Rj
LmM6MTY3IGF0bWVsX2hsY2RjX3B3bV9hcHBseSgpIHdhcm46ICduZXdfY2xrJyBmcm9tIGNsa19w
cmVwYXJlX2VuYWJsZSgpIG5vdCByZWxlYXNlZCBvbiBsaW5lczogMTEyLDEzNywxNDIsMTQ5Lg0K
Pj4NCj4gDQo+IENhbiB5b3UgYWRkIGEgZml4ZXMgdGFnPw0KPiANCg0KeWVzIEkgd2lsbCBhZGQg
aXQuDQoNCj4+IFNpZ25lZC1vZmYtYnk6IEhhcmkgUHJhc2F0aCBHdWp1bGFuIEVsYW5nbyA8SGFy
aS5QcmFzYXRoR0VAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL3B3bS9wd20t
YXRtZWwtaGxjZGMuYyB8IDE3ICsrKysrKysrKysrKystLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxMyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3B3bS9wd20tYXRtZWwtaGxjZGMuYyBiL2RyaXZlcnMvcHdtL3B3bS1hdG1lbC1obGNk
Yy5jDQo+PiBpbmRleCA5NmE3MDlhOWQ0OWEuLmNlNDZmNmM3NGExNCAxMDA2NDQNCj4+IC0tLSBh
L2RyaXZlcnMvcHdtL3B3bS1hdG1lbC1obGNkYy5jDQo+PiArKysgYi9kcml2ZXJzL3B3bS9wd20t
YXRtZWwtaGxjZGMuYw0KPj4gQEAgLTEwOCw4ICsxMDgsMTAgQEAgc3RhdGljIGludCBhdG1lbF9o
bGNkY19wd21fYXBwbHkoc3RydWN0IHB3bV9jaGlwICpjLCBzdHJ1Y3QgcHdtX2RldmljZSAqcHdt
LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQVRN
RUxfSExDRENfQ0ZHKDApLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgQVRNRUxfSExDRENfQ0xLUFdNU0VMLA0KPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ2VuY2ZnKTsNCj4+IC0gICAgICAgICAgICAg
ICAgICAgICBpZiAocmV0KQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgIGlmIChyZXQpIHsNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShuZXdf
Y2xrKTsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4g
KyAgICAgICAgICAgICAgICAgICAgIH0NCj4+ICAgICAgICAgICAgICAgIH0NCj4+DQo+PiAgICAg
ICAgICAgICAgICBkb19kaXYocHdtY3ZhbCwgc3RhdGUtPnBlcmlvZCk7DQo+PiBAQCAtMTMzLDIw
ICsxMzUsMjcgQEAgc3RhdGljIGludCBhdG1lbF9obGNkY19wd21fYXBwbHkoc3RydWN0IHB3bV9j
aGlwICpjLCBzdHJ1Y3QgcHdtX2RldmljZSAqcHdtLA0KPj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIEFUTUVMX0hMQ0RDX1BXTVBTX01BU0sgfA0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFUTUVMX0hMQ0RDX1BXTVBPTCwNCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwd21jZmcpOw0KPj4gLSAgICAg
ICAgICAgICBpZiAocmV0KQ0KPj4gKyAgICAgICAgICAgICBpZiAocmV0KSB7DQo+PiArICAgICAg
ICAgICAgICAgICAgICAgY2xrX2Rpc2FibGVfdW5wcmVwYXJlKG5ld19jbGspOw0KPj4gICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gKyAgICAgICAgICAgICB9DQo+Pg0KPj4g
ICAgICAgICAgICAgICAgcmV0ID0gcmVnbWFwX3dyaXRlKGhsY2RjLT5yZWdtYXAsIEFUTUVMX0hM
Q0RDX0VOLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFUTUVMX0hMQ0RD
X1BXTSk7DQo+PiAtICAgICAgICAgICAgIGlmIChyZXQpDQo+PiArICAgICAgICAgICAgIGlmIChy
ZXQpIHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICBjbGtfZGlzYWJsZV91bnByZXBhcmUobmV3
X2Nsayk7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+PiArICAgICAg
ICAgICAgIH0NCj4+DQo+PiAgICAgICAgICAgICAgICByZXQgPSByZWdtYXBfcmVhZF9wb2xsX3Rp
bWVvdXQoaGxjZGMtPnJlZ21hcCwgQVRNRUxfSExDRENfU1IsDQo+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RhdHVzLA0KPj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0YXR1cyAmIEFUTUVMX0hMQ0RDX1BXTSwN
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxMCwgMCk7
DQo+PiAtICAgICAgICAgICAgIGlmIChyZXQpDQo+PiArICAgICAgICAgICAgIGlmIChyZXQpIHsN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICBjbGtfZGlzYWJsZV91bnByZXBhcmUobmV3X2Nsayk7
DQo+IA0KPiBDYW4geW91IGtlZXAgYSBzaW5nbGUgZmFpbHVyZSBwb2ludCBmb3IgYWxsIHRoZXNl
Pw0KPiANCj4gQWxzbywgeW91IGhhdmUgdG8gc2V0IGNoaXAtPmN1cl9jbGsgPSBOVUxMIG90aGVy
d2lzZSBuZXh0IHRpbWUgeW91ciBhcHBseQ0KPiB3aWxsIGdldCBleGVjdXRlZCB0aGUgbmV3X2Ns
ayB3aWxsIG5vdCBiZSBlbmFibGVkLg0KPiANCg0KSSBzZWUgdGhhdCBuZXdfY2xrIGlzIGFzc2ln
bmVkIHRvIGN1cl9jbGsgaW4gdGhlIGlmIChzdGF0ZS0+ZW5hYmxlZCkgDQpibG9jayBhbmQgY2xr
X2Rpc2FibGVfdW5wcmVwYXJlKCkgaXMgaW52b2tlZCBvbmx5IGluIHRoZSBlbHNlIGJsb2NrIGZv
ciANCmN1cl9jbGsgYW5kIGl0cyBtYWRlIE5VTEwuIEkgd2lsbCBjbGVhbnVwIGFsbCBvZiB0aGlz
IGF0IGEgc2luZ2xlIHBvaW50IA0KYW5kIHJlc2VuZCB2Mi4NCg0KVGhhbmtzLA0KSGFyaQ0KDQoN
Cj4gVGhhbmsgeW91LA0KPiBDbGF1ZGl1IEJlem5lYQ0KPiANCj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgcmV0dXJuIHJldDsNCj4+ICsgICAgICAgICAgICAgfQ0KPj4gKw0KPj4gICAgICAgIH0g
ZWxzZSB7DQo+PiAgICAgICAgICAgICAgICByZXQgPSByZWdtYXBfd3JpdGUoaGxjZGMtPnJlZ21h
cCwgQVRNRUxfSExDRENfRElTLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IEFUTUVMX0hMQ0RDX1BXTSk7DQo=

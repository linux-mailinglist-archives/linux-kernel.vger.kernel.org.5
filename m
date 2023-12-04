Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1C1802E87
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjLDJ2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjLDJ2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:28:11 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B52AD7;
        Mon,  4 Dec 2023 01:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701682099; x=1733218099;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eJU3n1k+61uLtPXzv0DG820HVlEs82grQGpt80qF2uU=;
  b=wMsIgk34fz8PhMMv8ukobxP9SeTkIG/u5Cn1zMEumH5x1ib9OyLmMpSX
   IgXdHs+rsLIrq3pqABUitzAMYFfhknKW6Jf/COHXjibq4VRlK1q3c0KFK
   Z9epxpm+3MwlmYB2+vzjBqbjYBiE1NkrTwI1jJVsd9X6ovIpG1PQ3UTEn
   1SUWd8rG8Xrxe9OTUybhAHy7mx690P8pAIU1B8EZn/9CEhVtCevKmVONK
   LLkSo+ekzajxrJvqYpaTXd6iT2QzMmRWtOATlbh2rG3zHWBVQIQeNDl1Z
   UJJYnGtgAc/lLFkQXsJcVXciNH4E17K3RCsvPGE6cL/QMC/s26dCeMJmD
   g==;
X-CSE-ConnectionGUID: Trm6evrXQIOhzbRqgzhnJg==
X-CSE-MsgGUID: /dHGOCSdTUaQ6MJwtHP9Cg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="243386952"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2023 02:28:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 02:28:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Dec 2023 02:28:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0+UBTjXD8diqANxVZJP0SO5Vn3KSM63d/NBriaQX7Y07geOGhOAjbj3UhR7v/TwyOXxrr5Q1+4vy2Ynq5vyFQm90v6TOHLEWaThE0vJQ6MwOTJuieb9K59zvwQ0b/3iQCeHSAis0IvbvmGBcaerfYPIHdPAvz1x0wbqp+TZo5WNM7cOZ340rOXMjxU9soQDYFRSiKNZ7GepMW/G6IFGZjX+Q2WtMDsT9FNHRWFj7TCubSFCpcngmy1nfeoB1tgKzNN8psIRG1woffVjQCUcwig+X/rbwrBkDvlTGv3VMpMrPUD46KXPvFNhKLlfx0/PeQeoGk7iovWc52irZbnKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJU3n1k+61uLtPXzv0DG820HVlEs82grQGpt80qF2uU=;
 b=fg+8j1VIUQCbC855c1DkKClRUkLgef1yV4Ze9UbeV506SRDrocbH9WNCRlLI8hZp3L1sFqQ9tNyZ5QGTrT5DidDxFnlx+EI9YZw8ImET8LdvEMsflq9uAcBzsh7Tl6MJ51o4ldk495PBR/K5WKYJ+NUE3I4xeAEZ9CKkVyhZiwp5uDAcRA0bM4I75gaTw549WHxLAV1Obx90lBv/bZ0+a6TXKy/4OxbAtk6AIDEv0FinjF1wG7whIgvPCmpotL9Dcj4pUDb/mlpSv9tRogYUT55ensmA/YcPknVX8nkma6eZayED5nPA+ecYj2TlixFRVio3Klk8uA+c3bhMs3/GGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJU3n1k+61uLtPXzv0DG820HVlEs82grQGpt80qF2uU=;
 b=im/Liko7zNG5+ARmOXr5FnYgONEqxuDQewxVvTJnvIccAOMteeuyOurMEtOaLO5mNhrRTI5VfMZSNVbEwBeuUkegie45ZpTNcel7aB5zrmyC/1tFDT2GPhVDcj+Kh4UFcpHO8dehYFDs0hitHP+ayC0mzzrcE2IWovaOJQNCpMHLozLcXat67Smfe1/14D9N0Q9Qdprdopo3SAqdk1PhooD1ciFB1/Dv1VEvbM3vQp9a/4/CgISMSKdpGsbui9G9Id9B0OID6UUbHXpPr9PtS6DNevE7L7EP1yxjbj28m9nzPzf88Vg2ZikIO3frdqlUJXhbEvyVGta7U9kXukXutw==
Received: from IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14)
 by CH0PR11MB5490.namprd11.prod.outlook.com (2603:10b6:610:d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 09:28:03 +0000
Received: from IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::1268:3f:8109:622b]) by IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::1268:3f:8109:622b%5]) with mapi id 15.20.7025.022; Mon, 4 Dec 2023
 09:28:03 +0000
From:   <Marius.Cristea@microchip.com>
To:     <jic23@kernel.org>, <javier.carrasco.cruz@gmail.com>,
        <lars@metafoo.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: MCP3564: fix calib_bias and calib_scale range
 checks
Thread-Topic: [PATCH] iio: adc: MCP3564: fix calib_bias and calib_scale range
 checks
Thread-Index: AQHaJDuUqW+ATdubKEy/SG3qDMI1xLCY3+KA
Date:   Mon, 4 Dec 2023 09:28:02 +0000
Message-ID: <527409f3932fce519bd0e1d881d8bf5970641bf4.camel@microchip.com>
References: <20231201-mcp3564_range_checks-v1-1-68f4436e22b0@gmail.com>
In-Reply-To: <20231201-mcp3564_range_checks-v1-1-68f4436e22b0@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6395:EE_|CH0PR11MB5490:EE_
x-ms-office365-filtering-correlation-id: 50395b86-b210-41b0-f5c3-08dbf4ab507b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 80kBaLVlKCtLzWtPFi1nKjhoNI8HcNgnaWNvzzFZRvQfIq5OtAT0HhaJfbP4e1oqNbfTEiS9nvE2y13OhkbLj7tiqwcqec/Ees+kunbp8mXFxkmtJOTgDx5DPwXbPETaKQFH2gLpaQtL6xRie8bJKzf7ad2ZQ5dtBsJuXdoWND9TSU6L4ew0aIy/Yq9Kdf7gdBQSpqTETldb0KAMKK4rKBpzr7BfLTXG+2GROC1Bsxv/ewI9pi6YT/VaqNIDcdW+HycCWvDVYVoFOEEFd9oK7zpNweotxJLBMGIuAa3xyDzD0GvbTed8ZA/uQBEkof5arMcSwPhYDGJE5X+93cwbCf66awpFrjNMKgcQ53/md8iaU+FYZkV7Le37jMjAvmPJuocrT7/2zruehkGaXoiI0tPq8iOEb5nMrd6QvQLSfw4tQ6H0s6fM3Fdj2HIB1MxgUE21/I94TpoC6Sq0HVhsiwZ3CwSw3gsfJNML3bNo+JfVdEoWmjJ4plQhvJAJ8dTWuR3fptbjfvVIY82Epo/zpKqa41VL6beX21r1k3Gxa0bxpobv2Dr8azrWgdk52oynIwG5LM/+lMl9+YCqTJciSFacOLd3X4NJ/WsIDQADFyxc+1cFHzee6+MZFh4slsx/JjZhLhSnrtjXCvyxqJUYc8W0iRTOa9dGS0qA5MBCD3M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6395.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(136003)(376002)(230922051799003)(230173577357003)(230273577357003)(64100799003)(186009)(451199024)(1800799012)(66899024)(83380400001)(38100700002)(122000001)(41300700001)(26005)(66556008)(66476007)(66946007)(76116006)(91956017)(64756008)(5660300002)(66446008)(8936002)(8676002)(4326008)(316002)(54906003)(110136005)(6512007)(6506007)(2616005)(6486002)(71200400001)(478600001)(2906002)(86362001)(38070700009)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmdNc1h1YVBLc0FmaDNKOXVkelkvZlYzV0hLWWtVSVh6cFkyZG5lM1RMYTVP?=
 =?utf-8?B?TmFqalRlU3dGT3J1R1RqdUU3WWMzNHNNQ2UxUk90VVVpT0FvTzZJLzlTZitW?=
 =?utf-8?B?ZXVxZVVwVURBWnNiUUJyQWt2NTVabkJ0MXdIOGtFZXZjcmpaOFVzaERHcEZP?=
 =?utf-8?B?VkhsNlVXaVU0VlB0SUp0Rzl3NEQ5WmVrWE01Sk5LYVVYcW5ndGgwQWRERnZC?=
 =?utf-8?B?UkhBZThZN0lNdEFJdWtPMTBWM295M1JpR1lweFJmREZKL3hyemdkWUdCSHAz?=
 =?utf-8?B?QVZsU0dBSzJpdmFraHZtaDNKYzlocDEzUzd4bk1WZzNwTTU4NmZGZmw1WXBT?=
 =?utf-8?B?WkEvZm9tQzl0TG5mOXZDSmNkU1ArNlN5RGdBZTVjVHo1SHZ1alNlQit5OGpB?=
 =?utf-8?B?d0lEWFRlTmRZcUFrV2Z4YkdIRndvWVYyWEw1dVY2cDBDaU90YVpEaGJUdTly?=
 =?utf-8?B?NTJ4RTZCZy85c2w3djUrQ0Yvb1lxM2IyMGhvWk5TbkhSZEtYakdSK0J3R2Jw?=
 =?utf-8?B?bjNaMmFEUGxETG1IS08rR09GZ1pqWUdzY1NxMmdpY1VLKzBjaEEwZ0xMTUJU?=
 =?utf-8?B?c08zOFFNcHdrVzVkZCtBQzRlOW0rNjhtRlY4NTJPZE5oczVXSzA3Q1haTmxN?=
 =?utf-8?B?QVBEa252bWxwTTBoM0x5L0hqVjY3SFpPOWNKOFJhREdaV0FrSkttaTNtVEp6?=
 =?utf-8?B?RCtlZ3dRTkFtYmtCMHh0TGtrdkc1Q1pyNlRlV1l4dU1rSnpDVzlJQlBaUVJZ?=
 =?utf-8?B?WU5aRzFwV3Y5QlBQWFJJTUt4S1R6cmltU2JKS21lZUxJMkpvWkxzVHRac1Mz?=
 =?utf-8?B?ZWlDNEx5TnZWb3pJZDB2d1F1RXJ3REtmRUVlNW9ka0luWG83Z2ZVZFlSS1ds?=
 =?utf-8?B?Ukw1elJtWjZnM1lPdjB0Z0JFem9ZU0NTcTk4VkExUUZuN1VDUWZMU01HKzcz?=
 =?utf-8?B?bXJUbUJiVGRnUTB6ZVBJQTFHeS9Nc2ltM2R4QTBsS0x3WXNWWUJLZ3FMd1ZQ?=
 =?utf-8?B?cjZOVXp3T2d1eXhuRElYaEtCR1QyaEh6WS9LcFpOcXNUQ0JYT1NiWTNRYWE3?=
 =?utf-8?B?aGdUSHJ0eXRwL0NWbkgzVE1FNnovM2JlT0JybzZDUkhsVTFWd01oZGZOQmd1?=
 =?utf-8?B?Q0pwL0dIaVhhaW90bkFhQjhMVEwyMDhPL3A2MzJveGluWTd4ck1TN2lySFRZ?=
 =?utf-8?B?RFlSdFAyYnVvOG9sVTBYaGZrSE5DY0ZSMy9EWHE1bmJoWkQrL0VzZ0FrOHA1?=
 =?utf-8?B?blhkbFVWZGZIWWViUE5IdFBnRHd2MXlYVHIvb2VQMjZCd202TEpXMXJMb1Yz?=
 =?utf-8?B?Tk5ob21pUjVmVkU1T3RhMk0rejRaVzlsclhxNm1rVGNXV3llajZxK0hGVE1u?=
 =?utf-8?B?NmFLdjQ2VEhDdDU5VnlMWE1yYWtubXNqdlFBYy8vTEtMQ1MrMjNocGNac1R1?=
 =?utf-8?B?ZGZaRmNreDZGeDYvZW5NVHdNbXNkUjJrckJUUEZwTTlHYnlsbTBTWU00a0NV?=
 =?utf-8?B?dnpxc3h1QTVnczFaY2Y5eDVvZGY3OWtFK0NzS1AzM1ZrK3VNRUlFamhkU2JD?=
 =?utf-8?B?S1lVT0ZLMWRkY2RuL25NY25YeEVoYzZIU2xKYzg3MjJ4VWx4UEpHTjVkcGp2?=
 =?utf-8?B?cUZ4WFV1TEFlb25TWjhmVnluUEh0QzROOHBnYitNeDhDQUZreDJSd2J3R0Vj?=
 =?utf-8?B?UW1YcEtQdWZSVS9vekhRSFRKbDBYSE0xbzg5VXNqbXRYQkY0bERRYVlwcytU?=
 =?utf-8?B?MWpuTTRDeSt6MVpzUlpuN0ozajNidlhxeU9TclhSc29Pc1FOWVBGWjFYUFRI?=
 =?utf-8?B?L2p6OTh0S0xIbGsvcUhsOWNsTVRhRitUZGxyZEMwQmk1QTNhcEMvMVRSeWho?=
 =?utf-8?B?WitTbTdNSjBNQ0MyZnB1SDRxaDJtUTY5amNQaWhwOFQzVDJoN3ptLzU3Y3cv?=
 =?utf-8?B?TjZaS2FENkFpd1Vpd0d3UFA4Zk04ckgxRW1McVFwejhWZjYrbDFYdVdRbEVW?=
 =?utf-8?B?d1V5UVJVd21vV25BZk1FbG5rZUU5YjlLbW1IVS8zaTZ0UDNjckJOQkt4cWpM?=
 =?utf-8?B?eWtlTGt5SmdwcDNVWVczVXk4WW9YOWt1Vit6RXkxRmd6RFpmYjNFeFlYVGNM?=
 =?utf-8?B?S1pTWVpKYU9uNlE4UmZ1a1cyRUxndXZBczd3d1QyVGZJQ0ZxdjUwRGpMQkJW?=
 =?utf-8?B?OHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D77FC50C8B2A64C91737851F7CE2C73@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6395.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50395b86-b210-41b0-f5c3-08dbf4ab507b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 09:28:02.9894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bUlwcPDlXL6Pgf6QTNmgZcYB3DvGhI7uZ4dUeoTbpajwk1G3Oe7yLKlEUhOSFuMRoMhwUL21eyLPxGEFMJQDQty2RPIR9rU4+KxrTgjshWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5490
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmF2aWVyIENhcnJhc2NvLA0KDQogICBUaGFuayB5b3UgZm9yIGxvb2tpbmcgb3ZlciB0aGUg
ZHJpdmVyLCBmb3Igc3BvdHRpbmcgYW5kIHJlcG9ydGluZw0KdGhlIGJ1Zy4gWW91ciBmaXggaXMg
T0suDQoNClJldmlld2VkLWJ5OiBNYXJpdXMgQ3Jpc3RlYSA8bWFyaXVzLmNyaXN0ZWFAbWljcm9j
aGlwLmNvbT4NCg0KVGhhbmtzLA0KTWFyaXVzDQoNCk9uIEZyaSwgMjAyMy0xMi0wMSBhdCAxMDo0
OCArMDEwMCwgSmF2aWVyIENhcnJhc2NvIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90
IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBj
b250ZW50IGlzIHNhZmUNCj4gDQo+IFRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIHVzZXMgdGhl
IEFORCAoJiYpIG9wZXJhdG9yIHRvIGNoZWNrIGlmIHRoZQ0KPiB2YWx1ZSB0byB3cml0ZSBmb3Ig
SUlPX0NIQU5fSU5GT19DQUxJQkJJQVMgYW5kDQo+IElJT19DSEFOX0lORk9fQ0FMSUJTQ0FMRQ0K
PiBpcyB3aXRoaW4gdGhlIHZhbGlkIHJhbmdlcy4NCj4gVGhlIGV2YWx1YXRlZCB2YWx1ZXMgYXJl
IHRoZSBsb3dlciBhbmQgdXBwZXIgbGltaXRzIG9mIHRoZSByYW5nZXMsDQo+IHNvIHRoaXMgb3Bl
cmF0aW9uIGFsd2F5cyBldmFsdWF0ZXMgdG8gZmFsc2UuDQo+IA0KPiBUaGUgT1IgKHx8KSBvcGVy
YXRvciBtdXN0IGJlIHVzZWQgaW5zdGVhZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEphdmllciBD
YXJyYXNjbyA8amF2aWVyLmNhcnJhc2NvLmNydXpAZ21haWwuY29tPg0KPiAtLS0NCj4gVGhpcyBi
dWcgaGFzIGJlZW4gZm91bmQgd2hlbiBsb29raW5nIGZvciB1c2UgY2FzZXMgb2YgSUlPX0FWQUlM
X1JBTkdFDQo+IGFuZCB0aGUgZml4IGNvdWxkIG5vdCBiZSB0ZXN0ZWQgd2l0aCByZWFsIGhhcmR3
YXJlLiBUaGUgaXNzdWUgYW5kIGl0cw0KPiBzb3VsdXRpb24gYXJlIHJhdGhlciBzaW1wbGUsIGJ1
dCBzdGlsbCBzb21lIHRlc3RpbmcgYW5kIGNvbmZpcm1hdGlvbg0KPiB3b3VsZCBiZSB3ZWxjb21l
Lg0KPiAtLS0NCj4gwqBkcml2ZXJzL2lpby9hZGMvbWNwMzU2NC5jIHwgNCArKy0tDQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2lpby9hZGMvbWNwMzU2NC5jIGIvZHJpdmVycy9paW8vYWRjL21jcDM1
NjQuYw0KPiBpbmRleCBlM2YxZGU1ZmNjNWEuLmQ1ZmIxY2FlOGFlYiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9paW8vYWRjL21jcDM1NjQuYw0KPiArKysgYi9kcml2ZXJzL2lpby9hZGMvbWNwMzU2
NC5jDQo+IEBAIC05MTgsNyArOTE4LDcgQEAgc3RhdGljIGludCBtY3AzNTY0X3dyaXRlX3Jhdyhz
dHJ1Y3QgaWlvX2Rldg0KPiAqaW5kaW9fZGV2LA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgbXV0ZXhfdW5sb2NrKCZhZGMtPmxvY2spOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIHJldDsNCj4gwqDCoMKgwqDCoMKgwqAgY2FzZSBJSU9fQ0hBTl9JTkZP
X0NBTElCQklBUzoNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHZhbCA8IG1j
cDM1NjRfY2FsaWJfYmlhc1swXSAmJiB2YWwgPg0KPiBtY3AzNTY0X2NhbGliX2JpYXNbMl0pDQo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICh2YWwgPCBtY3AzNTY0X2NhbGliX2Jp
YXNbMF0gfHwgdmFsID4NCj4gbWNwMzU2NF9jYWxpYl9iaWFzWzJdKQ0KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOw0KPiANCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG11dGV4X2xvY2soJmFkYy0+bG9jayk7DQo+
IEBAIC05MjgsNyArOTI4LDcgQEAgc3RhdGljIGludCBtY3AzNTY0X3dyaXRlX3JhdyhzdHJ1Y3Qg
aWlvX2Rldg0KPiAqaW5kaW9fZGV2LA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
bXV0ZXhfdW5sb2NrKCZhZGMtPmxvY2spOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIHJldDsNCj4gwqDCoMKgwqDCoMKgwqAgY2FzZSBJSU9fQ0hBTl9JTkZPX0NBTElC
U0NBTEU6DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICh2YWwgPCBtY3AzNTY0
X2NhbGliX3NjYWxlWzBdICYmIHZhbCA+DQo+IG1jcDM1NjRfY2FsaWJfc2NhbGVbMl0pDQo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICh2YWwgPCBtY3AzNTY0X2NhbGliX3NjYWxl
WzBdIHx8IHZhbCA+DQo+IG1jcDM1NjRfY2FsaWJfc2NhbGVbMl0pDQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7DQo+IA0KPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGFkYy0+Y2FsaWJfc2NhbGUgPT0gdmFs
KQ0KPiANCj4gLS0tDQo+IGJhc2UtY29tbWl0OiA5OTRkNWM1OGU1MGU5MWJiMDJjN2JlNGE5MWQ1
MTg2MjkyYTg5NWM4DQo+IGNoYW5nZS1pZDogMjAyMzEyMDEtbWNwMzU2NF9yYW5nZV9jaGVja3Mt
MjIxNzA4ODM4MTMwDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IC0tDQo+IEphdmllciBDYXJyYXNj
byA8amF2aWVyLmNhcnJhc2NvLmNydXpAZ21haWwuY29tPg0KPiANCg0K

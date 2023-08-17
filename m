Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A293F77FD04
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354007AbjHQR3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354010AbjHQR3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:29:20 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5075130D1;
        Thu, 17 Aug 2023 10:29:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGPQ/Vb2Fc8DSIZCd8ELhSEpgIgtaj+FNeIP03WCC1Wz0Jz+wuhiwy6KgwSnaZ0z3lusncndvR6z0jkjSiPVMEyl18xBFzBHJd7bca+5hkm2+CAkXjWlzWtNBuPlHIJ7g6usYnybtzvwAqRGg3Jp2d7fI7S2RjeZcz5WGH9WW/7vl8OYetZKJPrIL4NMSDWnPs1NfFCLVKfPey8Rt4DxKiZR1koOK5rgTwMjQXesI1//8RaSRWbyD246Oa+zReS+3QMcF9xKPKwTA//vrGgeqiab/negQgKllGgE5lxGtjgkH0S00EY2+Lf7DFYpZ9eozR7fzH2RYlCCfiQStGTGAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4j/vqBJBo8Lxl+CiKbp0OBfpWl4w4gFytA88QpYR1oU=;
 b=YYSyFeYec3M71ynzfSicr6aS+toUR4qiPR+5XPMe9bPGYp0R3TEln9iqd+RpUJxhs8/xgaalF/ZVRdEwC6bcfNN3iip6unofqfpoj+FNrkOD+hDaVEZBLDTMvT7yiojeC95lJDzGSaADXK0KJTLsLBn3Zhd68PKjIsNYUTPfVcMbMdCtLZWa1wTLASvzCv3iKdZr7IgEuv0ELnFhren2gdonBS/Ske4xiT7hoBVw7QktEU0xe3s/tBKlhpXaa4hRfr+iOAq1w9hGdGThDrfKB556hb0Zdt+8SaaCiIDK8GzP/eonh6XwwOx/F5GLzhn5eaJHzbYRsNpq7fI2z5j4+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4j/vqBJBo8Lxl+CiKbp0OBfpWl4w4gFytA88QpYR1oU=;
 b=z+U+viF6+n9oIhO+iaRMYmLaflQ78CQDHLj7x2/cVadfuS8gOZrE6HFg7k1JbmdLGzMty0oj9KNNjGayfT2phvydptNOsxlDLzww5Iv6+CfYrZ5cNiyXMrgGvF3BLlDUUOhAu/NkPM+Hu37F7ESPTy6fm71nqI4l+YWPSrF3cTM7cqqvYPYBNBHo0jOtiumWSJLA7in9Da9bpMMenrLSbErDIpF4h1zw+EycIHdQ1/bGJjPy39vs6t8TO0ymSkS2B80PTi3H8JlQqta6S5qLKg02RY4lHkif1JyxZ35yupzrSXUBhV3Iw4jgUswSpE3MXGdjo/bG9h1Eh9JEemeDOA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PAVPR10MB7257.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:310::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 17:29:15 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1422:2669:47c5:d7bc]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1422:2669:47c5:d7bc%2]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 17:29:15 +0000
From:   "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>
CC:     "andrew@lunn.ch" <andrew@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "rmk@armlinux.org.uk" <rmk@armlinux.org.uk>,
        "cphealy@gmail.com" <cphealy@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nikita.yoush@cogentembedded.com" <nikita.yoush@cogentembedded.com>,
        "vivien.didelot@savoirfairelinux.com" 
        <vivien.didelot@savoirfairelinux.com>,
        "Nisar.Sayed@microchip.com" <Nisar.Sayed@microchip.com>,
        "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH ethtool 2/2] ethtool: Add support for PHY test modes
Thread-Topic: [PATCH ethtool 2/2] ethtool: Add support for PHY test modes
Thread-Index: AQHZ0S/u9hlbglAuHEeJ9ZwYy0Crb6/uvk8A
Date:   Thu, 17 Aug 2023 17:29:15 +0000
Message-ID: <f390207c5c4fd17398b84ce8ae829a49a2c0768b.camel@siemens.com>
References: <20180428003237.1536-1-f.fainelli@gmail.com>
         <20180428003237.1536-8-f.fainelli@gmail.com>
In-Reply-To: <20180428003237.1536-8-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PAVPR10MB7257:EE_
x-ms-office365-filtering-correlation-id: 3a9825b5-1f87-4a9a-21bd-08db9f477acd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A8z1oxxHuiUBJEiyEF/gC6a+ZNGuIDw8wX1eo2jo2Uq/xxlb5iIKG65Hulrx8Sc0uq32xNR+d+FOVJd3RHFB1uNmVSDwa7ThNsv2pmMaZ0Oa5vJdf+JNxOYee/f6+Vqv/gJJKkOKVheJ9caAKO7iQLKLh+A4I1xMFDtc+S2wtt+FuJIcbM/4e8vTpojqGK6XKvMGBLL2bY5Hat5UCWS4IeNTo5paxmIWwLmmu2DlKZj7RXLMGRenu46O2of4+qFyjD56UbXuJBZAu7/WJs/kfT4IkeJhRsJRvZfSTkRhxPqPoLmUCaAIUff+uNx8qx+11aULq4WyM9LQGZxk9fl2aF+ealc8XIa21boLITt5/JiL5aZ2DeGgEB7QXcTB+TnKYPlaVwVQzFFVD7Rl6vdsFzY/pmsgMwHqYpUw65CdxU6M/3lkqlTm5VD8GbjxrAN8XZzi9eO974oF3FmSnlyhrLGajLFcdQJ2q3IJP3tvNxz4WpHY7BvKDuzXHy2HeRG8ZhJw7otQp2EA2rFI+bIXRhWET7ZcJ0Na49ctJP7wDc/6dv4nxvyOnUbpX+ZVHleHYPjTCbDsuuUqM1kgYHZQrPLIcfB5cbzbZAIE3ctD1EdxUV+DC+ZGLwUBl909VFaq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(396003)(346002)(376002)(186009)(451199024)(1800799009)(2906002)(86362001)(7416002)(478600001)(36756003)(6506007)(2616005)(71200400001)(6486002)(6512007)(15974865002)(5660300002)(41300700001)(66446008)(122000001)(316002)(54906003)(91956017)(66476007)(76116006)(64756008)(66556008)(66946007)(110136005)(4326008)(8676002)(8936002)(82960400001)(38070700005)(38100700002)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akZUb09CMkl5MUZCRDZwVEkzU2pTdEo4YTFjd2hFSnQ5VStNNUdkVGRYdndk?=
 =?utf-8?B?Y1JWN0EwcXZ3MDRieDE0KzlNTW5JN1JkbERxaTlVZUJZQU4ySnNVZTE0Y201?=
 =?utf-8?B?NHpFVjlxaW51b2tmV2lYRVBJTk1GTnVQVVVJN09NN1owbTFNWjh0WWV0UFpv?=
 =?utf-8?B?L083TWhLQmd3RXRNK1AxSkhSc2N0RzRIeW93Z2N4d1YwcDd0V3JucHY4enYr?=
 =?utf-8?B?TEJLYUhjS1VpRXljMm9vZVhRL09aNXBLUWNFNkdKcGZIanArY2lHc3BOMmZm?=
 =?utf-8?B?QjliQnBWREVZYXZnNXpJTDBpT3hpd3k5WExZWG8vUXJUVEVXWlZiNkhid21R?=
 =?utf-8?B?eUpSTUY5dzBaTVVaRUo0RU9WWWtvT0NQMERwb2Uya0phSXZZZGd1TzNUZis5?=
 =?utf-8?B?cGVqa29hNWdiQXJjcnc2NDBQSytnay8wRndVK3R2cGlPR012SGdoY0kyeFFy?=
 =?utf-8?B?aVhKdDlDSDdiWk9vSXYzbm85aDdtaUxHeGhvbkw1YnhpVHpKazZMWktycTdZ?=
 =?utf-8?B?T2xRMFl5cE9TYnJYMElrMnZaemx2c2s5RTBhS1R1VzloMkc0ODRianU4cmVK?=
 =?utf-8?B?UGpFVkYraHBYMFo3RG1nSm1lZ0xlOTByQVNocWFzTG9DbFBGaVlhcFp1czYw?=
 =?utf-8?B?Qy9aZGN0WkYvSXVIcS9DWUVCd1RNTkJBL0tuQ3BSeEdQVTBkT1ZqNC9kR1Ri?=
 =?utf-8?B?dDNlQVQwOFVuT0FjaFRoN3MxYWZBYk94VWplR1grQlROaUtzR05kNFJxT0la?=
 =?utf-8?B?R0ZnbnA1MVpLcmxnc0k2UXl0c250ZS8yKzl5bzBOUTVZaUR0UEErNW1aUW9Y?=
 =?utf-8?B?OXZNWGt1TGdUdUc1OXp5OFdJUS9CaDJhMmMyU256OUxZZ1NEUUxxUE5teTNr?=
 =?utf-8?B?MnVUYkdsS3hHazNhQjF5aGdUaTRTQkNjMUNjcGxNa3hCb25xb20zOTF3dVZv?=
 =?utf-8?B?VGdOZS9RQXlvbWFucCt3amZweTh5eHQ4TW40bnhqWTdhT2FLa2VLSC9nVWZP?=
 =?utf-8?B?RUk1Um56Vjd0VDB6NlJRZ09kSGFjQjNoQlZvQ3hQNW9lMHRxc09RNEd0Kyts?=
 =?utf-8?B?eCsrZzdEMWZJOXJ1WHBnMjZHTU1rdGs2TUpuV3RaNU9HdWxLckp1ZmxnSm5N?=
 =?utf-8?B?RXNST2pWblNTQjlLdVNDRDZ3UDNsSjUrdlFncDhUQWp5QnhhaFBNNU9hN1d4?=
 =?utf-8?B?aDl6TkVCd1p0SGJ1dER3K2V4Z3N3cUZLbXl4Q1UrZ3dpRytSLzBXNzE2bHhn?=
 =?utf-8?B?SFYrMXdNNDdMNy95ZENvRjZuTFE0d21YSTdoU0JzNG5wcnZIWms3MWlPV0JJ?=
 =?utf-8?B?UHBuTWtrVDRGUUY0Q0IzeXJKRUM2Z05iQzk3b29wbHhScVhWek03Mm5mZW1X?=
 =?utf-8?B?M1lvb0JKUll3WHlOVGNLQ2t3VmNuNVduT0RDc2R1WmlCUHVOcklPWWVTRHVF?=
 =?utf-8?B?alczbVlrdDkwd0JpYVNCaTdTUi9EQWMzdFI5WmN5eGxXVEcvbWs2VmFJeUJx?=
 =?utf-8?B?S09uRUhoN0FrME8zNWJqMTFUa2JFRlN1eTlMMHNaNTdiVVRKYU42a3FuTmJz?=
 =?utf-8?B?RmV2dVZva0p2enhPWDA1Y1M2TXF5U0hYMGVXckVTUHppR1VJaWFkcGJqeW1F?=
 =?utf-8?B?dlpGWXcvbGtSL3JORE54VFRzQzZ1U3M0a1JYU3gzbWtXUGI4ZlFHWWZYa0pG?=
 =?utf-8?B?bDZHVnAzem9NaFJFY2xiYVNBRjhaU1VGZmpDYmt6UmRRQ05JNk5GWDJ6SHlS?=
 =?utf-8?B?Z2FKUGZacGlwSVdibmlZU2MwZHlOSW9EeEw1UTkxZkpOVlJFalVzbEh1NGVh?=
 =?utf-8?B?MVVwcEVnaWliMFRtZWJlbVAwQS9udk41eFY5ZkxmbjNNN0d0c3BmazNDeE9l?=
 =?utf-8?B?NzBrdTRhd3BtNitRbUkrTndqWnp0alN3MWdVZS95UStxN1grSGJ3VHlrbG10?=
 =?utf-8?B?VWRpRlk5WnE1MzhuRFV2YXhJdHAwVjdWS1dqOCsxM0cyS1RnU0VjamFESWp6?=
 =?utf-8?B?MForUm91WGxjZ1NPdGZ4cmNScmJ1NjNWZStqSE1QZjVPVFBadGJwZGJzRjZs?=
 =?utf-8?B?VldteWU3YnRYajFSR2xsRDBoUU1ZdU0reWozbmp2ekh6c3FQOVVqeWtKcHhP?=
 =?utf-8?B?WE5QQXg4b0JDM3ZteUxURkJ0c0srZVN3bW5rMjNYMi9ha0tlcGxwV1czV05i?=
 =?utf-8?B?ZEd0WDVwUWRwUzJ4M0p4QnBWYlVnM0ZnVmxTMWhWbUVQNUdSMlJLSEdhQmFD?=
 =?utf-8?Q?DPjBDYnXDL44Kq7V/ammaHdZIjd0Q8iqw0fSy6xaAU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DD58F063045C846A86D244EA2315E0F@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9825b5-1f87-4a9a-21bd-08db9f477acd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 17:29:15.4203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkgftHYtJzasJC3d8mlCsaP9cKXkUOPv5Bbn9Ci+oQXFdue3n3jdpe/QGhFrnuWqSKZFYFq0cACwQvIYBQeZtXf0VAqoligyZm1KtmFjiOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7257
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gRmxvcmlhbiwKCk9uIEZyaSwgMjAxOC0wNC0yNyBhdCAxNzozMiAtMDcwMCwgRmxvcmlh
biBGYWluZWxsaSB3cm90ZToKPiBBZGQgdHdvIG5ldyBjb21tYW5kczoKPiAKPiAtLWdldC1waHkt
dGVzdHMgd2hpY2ggYWxsb3dzIGZldGNoaW5nIHN1cHBvcnRlZCB0ZXN0IG1vZGVzIGJ5IGEgZ2l2
ZW4KPiDCoCBuZXR3b3JrIGRldmljZSdzIFBIWSBpbnRlcmZhY2UKPiAtLXNldC1waHktdGVzdCB3
aGljaCBhbGxvd3MgZW50ZXJpbmcgb25lIG9mIHRoZSBtb2RlcyBsaXN0ZWQgYmVmb3JlIGFuZAo+
IMKgIHBhc3MgYW4gZXZlbnR1YWwgc2V0IG9mIHRlc3Qgc3BlY2lmaWMgZGF0YQo+IAo+IFNpZ25l
ZC1vZmYtYnk6IEZsb3JpYW4gRmFpbmVsbGkgPGYuZmFpbmVsbGlAZ21haWwuY29tPgoKaGFzIHRo
aXMgc2VyaWVzIGV2ZXIgYmVlbiBwb3N0ZWQgZm9yIG1lcmdpbmcsIGkuZS4gbm90IGFzIFJGQz8K
SXQgbG9va3MgcXVpdGUgdXNlZnVsIHRvIG1lIGFuZCBJIHByb2JhYmx5IHdpbGwgYmUgYWJsZSB0
byB0ZXN0CnRoZSBzZXJpZXMgaWYgeW91IHN0aWxsIHdpbGwgYmUgcG9zdGluZyBpdC4KCj4gLS0t
Cj4gwqBldGh0b29sLmMgfCAxMTUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysKPiDCoDEgZmlsZSBjaGFuZ2VkLCAxMTUgaW5zZXJ0
aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9ldGh0b29sLmMgYi9ldGh0b29sLmMKPiBpbmRleCAz
Mjg5ZTBmNmU4ZWMuLmYwMmNkMzU2MDE5NyAxMDA2NDQKPiAtLS0gYS9ldGh0b29sLmMKPiArKysg
Yi9ldGh0b29sLmMKPiBAQCAtNDg1NCw2ICs0ODU0LDExOCBAQCBzdGF0aWMgaW50IGRvX3Jlc2V0
KHN0cnVjdCBjbWRfY29udGV4dCAqY3R4KQo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiDC
oH0KPiDCoAo+ICtzdGF0aWMgaW50IGRvX2dwaHl0ZXN0KHN0cnVjdCBjbWRfY29udGV4dCAqY3R4
KQo+ICt7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGV0aHRvb2xfZ3N0cmluZ3MgKnN0cmluZ3M7
Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGV0aHRvb2xfcGh5X3Rlc3QgdGVzdDsKPiArwqDCoMKg
wqDCoMKgwqB1bnNpZ25lZCBpbnQgaTsKPiArwqDCoMKgwqDCoMKgwqBpbnQgbWF4X2xlbiA9IDAs
IGN1cl9sZW4sIHJjOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBpZiAoY3R4LT5hcmdjICE9IDApCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGV4aXRfYmFkX2FyZ3MoKTsKPiArCj4gK8Kg
wqDCoMKgwqDCoMKgc3RyaW5ncyA9IGdldF9zdHJpbmdzZXQoY3R4LCBFVEhfU1NfUEhZX1RFU1RT
LCAwLCAxKTsKPiArwqDCoMKgwqDCoMKgwqBpZiAoIXN0cmluZ3MpIHsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcGVycm9yKCJDYW5ub3QgZ2V0IFBIWSB0ZXN0cyBzdHJpbmdzIik7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAxOwo+ICvCoMKgwqDCoMKg
wqDCoH0KPiArwqDCoMKgwqDCoMKgwqBpZiAoc3RyaW5ncy0+bGVuID09IDApIHsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZnByaW50ZihzdGRlcnIsICJObyBQSFkgdGVzdHMgZGVm
aW5lZFxuIik7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJjID0gMTsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBlcnI7Cj4gK8KgwqDCoMKgwqDCoMKgfQo+
ICsKPiArwqDCoMKgwqDCoMKgwqAvKiBGaW5kIGxvbmdlc3Qgc3RyaW5nIGFuZCBhbGlnbiBhbGwg
c3RyaW5ncyBhY2NvcmRpbmdseSAqLwo+ICvCoMKgwqDCoMKgwqDCoGZvciAoaSA9IDA7IGkgPCBz
dHJpbmdzLT5sZW47IGkrKykgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjdXJf
bGVuID0gc3RybGVuKChjb25zdCBjaGFyKilzdHJpbmdzLT5kYXRhICsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaSAqIEVU
SF9HU1RSSU5HX0xFTik7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChjdXJf
bGVuID4gbWF4X2xlbikKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoG1heF9sZW4gPSBjdXJfbGVuOwo+ICvCoMKgwqDCoMKgwqDCoH0KPiArCj4gK8KgwqDC
oMKgwqDCoMKgcHJpbnRmKCJQSFkgdGVzdHMgJXM6XG4iLCBjdHgtPmRldm5hbWUpOwo+ICvCoMKg
wqDCoMKgwqDCoGZvciAoaSA9IDA7IGkgPCBzdHJpbmdzLT5sZW47IGkrKykgewo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBtZW1zZXQoJnRlc3QsIDAsIHNpemVvZih0ZXN0KSk7Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRlc3QuY21kID0gRVRIVE9PTF9HUEhZVEVT
VDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdGVzdC5tb2RlID0gaTsKPiArCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJjID0gc2VuZF9pb2N0bChjdHgsICZ0ZXN0
KTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHJjIDwgMCkKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbnRpbnVlOwo+ICsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZnByaW50ZihzdGRvdXQsICLCoMKgwqDCoCAl
LipzIChUZXN0IGRhdGE6ICVzKVxuIiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIG1heF9sZW4sCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAoY29uc3QgY2hhciAqKXN0cmluZ3MtPmRhdGEgKyBpICogRVRIX0dTVFJJTkdf
TEVOLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGVzdC5s
ZW4gPyAiWWVzIiA6ICJObyIpOwo+ICvCoMKgwqDCoMKgwqDCoH0KPiArCj4gK8KgwqDCoMKgwqDC
oMKgcmMgPSAwOwo+ICsKPiArZXJyOgo+ICvCoMKgwqDCoMKgwqDCoGZyZWUoc3RyaW5ncyk7Cj4g
K8KgwqDCoMKgwqDCoMKgcmV0dXJuIHJjOwo+ICt9Cj4gKwo+ICtzdGF0aWMgaW50IGRvX3NwaHl0
ZXN0KHN0cnVjdCBjbWRfY29udGV4dCAqY3R4KQo+ICt7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0
IGV0aHRvb2xfZ3N0cmluZ3MgKnN0cmluZ3M7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGV0aHRv
b2xfcGh5X3Rlc3QgZ3Rlc3Q7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGV0aHRvb2xfcGh5X3Rl
c3QgKnN0ZXN0Owo+ICvCoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGludCBpOwo+ICvCoMKgwqDCoMKg
wqDCoGludCByYzsKPiArCj4gK8KgwqDCoMKgwqDCoMKgaWYgKGN0eC0+YXJnYyA8IDEpCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGV4aXRfYmFkX2FyZ3MoKTsKPiArCj4gK8KgwqDC
oMKgwqDCoMKgc3RyaW5ncyA9IGdldF9zdHJpbmdzZXQoY3R4LCBFVEhfU1NfUEhZX1RFU1RTLCAw
LCAxKTsKPiArwqDCoMKgwqDCoMKgwqBpZiAoIXN0cmluZ3MpIHsKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgcGVycm9yKCJDYW5ub3QgZ2V0IFBIWSB0ZXN0IG1vZGVzIik7Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAxOwo+ICvCoMKgwqDCoMKgwqDCoH0K
PiArCj4gK8KgwqDCoMKgwqDCoMKgaWYgKHN0cmluZ3MtPmxlbiA9PSAwKSB7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZwcmludGYoc3RkZXJyLCAiTm8gUEhZIHRlc3RzIGRlZmlu
ZWRcbiIpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByYyA9IDE7Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gZXJyOwo+ICvCoMKgwqDCoMKgwqDCoH0KPiAr
Cj4gK8KgwqDCoMKgwqDCoMKgZm9yIChpID0gMDsgaSA8IHN0cmluZ3MtPmxlbjsgaSsrKSB7Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghc3RyY21wKGN0eC0+YXJncFswXSwK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAo
Y29uc3QgY2hhciAqKXN0cmluZ3MtPmRhdGEgKyBpICogRVRIX0dTVFJJTkdfTEVOKSkKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOwo+ICvCoMKg
wqDCoMKgwqDCoH0KPiArCj4gK8KgwqDCoMKgwqDCoMKgaWYgKGkgPT0gc3RyaW5ncy0+bGVuKQo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBleGl0X2JhZF9hcmdzKCk7Cj4gKwo+ICvC
oMKgwqDCoMKgwqDCoG1lbXNldCgmZ3Rlc3QsIDAsIHNpemVvZihndGVzdCkpOwo+ICvCoMKgwqDC
oMKgwqDCoGd0ZXN0LmNtZCA9IEVUSFRPT0xfR1BIWVRFU1Q7Cj4gK8KgwqDCoMKgwqDCoMKgZ3Rl
c3QubW9kZSA9IGk7Cj4gK8KgwqDCoMKgwqDCoMKgcmMgPSBzZW5kX2lvY3RsKGN0eCwgJmd0ZXN0
KTsKPiArwqDCoMKgwqDCoMKgwqBpZiAocmMgPCAwKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJjID0gMTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBl
cnI7Cj4gK8KgwqDCoMKgwqDCoMKgfQo+ICsKPiArwqDCoMKgwqDCoMKgwqBzdGVzdCA9IGNhbGxv
YygxLCBzaXplb2YoKnN0ZXN0KSArIGd0ZXN0Lmxlbik7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKCFz
dGVzdCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwZXJyb3IoIlVuYWJsZSB0
byBhbGxvY2F0ZSBtZW1vcnkiKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmMg
PSAxOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIGVycjsKPiArwqDCoMKg
wqDCoMKgwqB9Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoHN0ZXN0LT5jbWQgPSBFVEhUT09MX1NQSFlU
RVNUOwo+ICvCoMKgwqDCoMKgwqDCoHN0ZXN0LT5sZW4gPSBndGVzdC5sZW47Cj4gK8KgwqDCoMKg
wqDCoMKgc3Rlc3QtPm1vZGUgPSBpOwo+ICsKPiArwqDCoMKgwqDCoMKgwqByYyA9IHNlbmRfaW9j
dGwoY3R4LCBzdGVzdCk7Cj4gK8KgwqDCoMKgwqDCoMKgZnJlZShzdGVzdCk7Cj4gK2VycjoKPiAr
wqDCoMKgwqDCoMKgwqBmcmVlKHN0cmluZ3MpOwo+ICvCoMKgwqDCoMKgwqDCoHJldHVybiByYzsK
PiArfQo+ICsKPiArCj4gwqBzdGF0aWMgaW50IHBhcnNlX25hbWVkX2Jvb2woc3RydWN0IGNtZF9j
b250ZXh0ICpjdHgsIGNvbnN0IGNoYXIgKm5hbWUsIHU4ICpvbikKPiDCoHsKPiDCoMKgwqDCoMKg
wqDCoMKgaWYgKGN0eC0+YXJnYyA8IDIpCj4gQEAgLTUyMjMsNiArNTMzNSw5IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3Qgb3B0aW9uIHsKPiDCoMKgwqDCoMKgwqDCoMKgeyAiLS1zaG93LWZlYyIsIDEs
IGRvX2dmZWMsICJTaG93IEZFQyBzZXR0aW5ncyJ9LAo+IMKgwqDCoMKgwqDCoMKgwqB7ICItLXNl
dC1mZWMiLCAxLCBkb19zZmVjLCAiU2V0IEZFQyBzZXR0aW5ncyIsCj4gwqDCoMKgwqDCoMKgwqDC
oMKgICLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFsgZW5jb2RpbmcgYXV0b3xvZmZ8cnN8YmFz
ZXIgXVxuIn0sCj4gK8KgwqDCoMKgwqDCoMKgeyAiLS1nZXQtcGh5LXRlc3RzIiwgMSwgZG9fZ3Bo
eXRlc3QsIkdldCBQSFkgdGVzdCBtb2RlKHMpIiB9LAo+ICvCoMKgwqDCoMKgwqDCoHsgIi0tc2V0
LXBoeS10ZXN0IiwgMSwgZG9fc3BoeXRlc3QsICJTZXQgUEhZIHRlc3QgbW9kZSIsCj4gK8KgwqDC
oMKgwqDCoMKgwqAgIsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgWyB0ZXN0IG9wdGlvbnMgXVxu
IiB9LAo+IMKgwqDCoMKgwqDCoMKgwqB7ICItaHwtLWhlbHAiLCAwLCBzaG93X3VzYWdlLCAiU2hv
dyB0aGlzIGhlbHAiIH0sCj4gwqDCoMKgwqDCoMKgwqDCoHsgIi0tdmVyc2lvbiIsIDAsIGRvX3Zl
cnNpb24sICJTaG93IHZlcnNpb24gbnVtYmVyIiB9LAo+IMKgwqDCoMKgwqDCoMKgwqB7fQoKLS0g
CkFsZXhhbmRlciBTdmVyZGxpbgpTaWVtZW5zIEFHCnd3dy5zaWVtZW5zLmNvbQo=

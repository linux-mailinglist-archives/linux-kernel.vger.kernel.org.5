Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7317A5AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjISHdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjISHdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:33:12 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1C3FC;
        Tue, 19 Sep 2023 00:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1695108786;
  x=1726644786;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ay2BqF9oQCA1Knd7wY9g7GM/bQ1I6HdycnchQDXpSQ8=;
  b=nFSo3fkdMEb4REKKvLXuHl4vFJ+eMjoawkVngLDOvLtDqNWz9wt8JC5i
   P5y9w61XHcIb/lP/al5CspAHSHxc88JoxaU9qMoAf0V8E8DBVAZ7yekT7
   Btl5i2jBhCp+/f1lQyblsLbJf/DktCXOIXoqfBAdNGFwtZWxSZFt6K4y2
   GsGGzxNA9VMeiW76Y4oHX5H+ohYaMfLa7dDsDriXKwk5Bt79iS9PdRq0o
   hfLleEkQtPm/CQiesYcIhykLxSSB+InUZa95BieIyl0R0duTBDlwVL2Ny
   to0H+yjnMjQfSl5zOgVJcS4kqa094gfifDx8/vm1p1HAZD1ATdgz5a8h0
   w==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPl/zy91nJ9roYTe4pQXxGqEH+UG/PwgPCvdTwMssrQ6sBD/1Dac/hmK1P9nmkVxrDbce7kz7MAJInbk1tfh4N00TrKogZX7Yo/YcLVy3+0Su98rNTG8kLq8TG+RsnrVtSnGHtFQdzvfBjnzOv3xguiYDD0FODV2BKUBp1Eo2d7tHq+hCDNnML7xwwIuIlVpZC1j3akBs8+uyMciFd+GI+YgIcYL4Skzj4+JXz1ZWjTgKLi2huoEORtIH2XCLxf9dSFem/G29jc0/nC9DtD/VAanKJ2AfowgN0niSy2KUitPIN1ezdIaV0eKYl/MptL2faGXi6iTQdpVyvE0890CfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ay2BqF9oQCA1Knd7wY9g7GM/bQ1I6HdycnchQDXpSQ8=;
 b=aylNyOBGTh3lZfBhXYWePKsNLmLGLUPoIfnrx8aUd55SXtrVczotCWV7P8u6Z5KQNw9EhMEcq8ZrFXAnMhDVYyEXngdEGGhVjY6RarNC0kV6oC70RgVgsaJ9KZJSFFCGdfjW38g1+4XSpw1y/vI7edmOCbB6AxW7T11MjvuXMEP9+jYJq7woImhM8M4+s4hbBOvgFvXZksAUdZig1ALyGNZmlTCsl/me6EuTIoWHfye8o+G8AZLrA//UtS0PdMf/wC89SNnQpTCepLnuHcgoZUvXsv+BXQ5q0aulI7y9OPpDmRobw9efO6VDhcZexSVEl4iqUotXMRU3FXXKBkimNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ay2BqF9oQCA1Knd7wY9g7GM/bQ1I6HdycnchQDXpSQ8=;
 b=mCPsQJxu29ZRyB61f3tFOO2uHfYf4DL+nztbegMmhyzM35SW7lOwxWh9zo3rJlEoedaqgC3PZ5zhm6sFgYHQYn5JqajOgQv2fxT17NxeX6GJOOMq+d+wduYCM8Dp3RiC4l0p+Izmpj+N0cJob0iyc0SA+Q/IYbbnSrfTlSd7CEw=
From:   Vincent Whitchurch <Vincent.Whitchurch@axis.com>
To:     "sre@kernel.org" <sre@kernel.org>,
        Vincent Whitchurch <Vincent.Whitchurch@axis.com>
CC:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Subject: Re: [PATCH] power: supply: Fix info use-after-free
Thread-Topic: [PATCH] power: supply: Fix info use-after-free
Thread-Index: AQHZ6gJqawKWfKn1O0C2XMVaZytlsbAgrt0AgAEUJ4A=
Date:   Tue, 19 Sep 2023 07:33:01 +0000
Message-ID: <11d30081b64935c2c3d45e5197cabbc25082a3fe.camel@axis.com>
References: <20230918-power-uaf-v1-1-73c397178c42@axis.com>
         <20230918150438.4pliix4fhbpjld3l@mercury.elektranox.org>
In-Reply-To: <20230918150438.4pliix4fhbpjld3l@mercury.elektranox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR02MB10280:EE_|DB8PR02MB5868:EE_
x-ms-office365-filtering-correlation-id: 82456a1c-f671-48bf-4109-08dbb8e2a7aa
x-ld-processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oBq1V+s3RgijzVjUFqCB5V2v4YYMxrHXgFWt0F7jUG5dj4WakdF/jxCJXoBFd79/fwh+gLuVWP07m2f3MhhyRcXRTNhJybM224jaBgk6vlTAKy703PWiBdlklryu7IQONaR+rrtnRrOzgFiNQJdtSOQbUYSOVfPpboAESoifYJ6MvzgftOZdnbfu419Nx3YVjRCCUX2brj+NZ5GT7XubtngTU1DjDsRo9LKn2rIaBPdVLyCKtaRcX+NSnI1IEobmE+v1tIzZ/E1ft9rpzy4LsLjZrc3NULJ8fG687vaRGx2OWL1k1JDGOBzGM75elcR9N3/xvWQvyOqF9cJc7WbElzEaqOfi0xv3JAq6/4ur/O5daG6MtP4b5Z+QAYCyh0NrA30qfTA5EKh0yUbMvws4mKm5zJyb4LzE9P92WzW8dN5QyQ43L7iCQ8NuQBFS8B69FY3EYzMzue1DCmqCr/WQoNDjbJyv2x7+V4N3d7dlkkxn71JLD88/epoDtl6jXIwKUzJl/NvvR6iy9dPaDHWdQwrgpPlouEUV0scZcviUdrr9pXip5CBTddiaQpirk1trvUfd34uZEyVRaoeIeEk9qFKNiZjhct69CqhBOjSh3PiqnHdN+iWpYzphsS21t3+6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR02MB10280.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(136003)(346002)(1800799009)(451199024)(186009)(316002)(54906003)(4326008)(8936002)(8676002)(41300700001)(2616005)(26005)(6512007)(478600001)(6486002)(6506007)(71200400001)(38100700002)(122000001)(86362001)(38070700005)(110136005)(91956017)(76116006)(64756008)(66476007)(66446008)(66946007)(66556008)(36756003)(4744005)(2906002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVNGRUxwdmlSaGtid1NNZnV5d3EwTlk3clFLcWFjZVpLeWlmZUtsWjlkNWRo?=
 =?utf-8?B?MThxMFE2Z3loUDVkcWpNY2tOSGlsUENsRWZTV29TVStXYnRFVXFjbjJQSnMr?=
 =?utf-8?B?K202djlIWGVFQTdqSmZ1WFBtOVBEb0piUGc5WjlCeUlXZWRydHloT2RxeWc0?=
 =?utf-8?B?SlRSaHZlVi9sV0RlSmhtZ2ozTS80QjBkR0xyUGg1ZjRiaWM5L2FOZ0g3TXBr?=
 =?utf-8?B?dnN3dkNUckRMZzdLL3hRa1hhc3FhcUtmRTVkMitMblk2MDl2ZmRUNjRzNmR5?=
 =?utf-8?B?Z1pKM1BBQ3lZOEwwQU8zNnh6cmxsMjJJRHdYVW9IL3haNjhFWEhYSWRVVnJO?=
 =?utf-8?B?bGJtKzhncTROMkN4QU5LcU9vdlZmdHF3K0lPRE9TekNldnNVa3JSM3pnUmd6?=
 =?utf-8?B?QU9tNmJNdyt0bDdWRHBjazVJNy9NbG02aHBicHNQbURVNkxndHRsU05qQlZy?=
 =?utf-8?B?YnJrQUlTQkdXT2Vobko3dXhTNVM4TXA4dXR4MG0wNFlIdGdFQ25KZER5M0NC?=
 =?utf-8?B?alk2YVZjZXRZcGFIc1l3LzZ5dWlaNXdPZ0ZlSWFENTFFeS85WGNEZ1gvTjlN?=
 =?utf-8?B?U3BlSGhaZTJ1Qmp4YVFuZVlCWTJBbzBYVFZlOWVtUmttdHNvNktmM0tBK1FL?=
 =?utf-8?B?VnJjZ0pvS0tKak5PYmlueWZ3S1FsZVB0T01WUEtvV2ZtNmpWNEpXMk5oTHpl?=
 =?utf-8?B?ZkNQMkhnVU5zQ2d6UFpybzJWekRuaUhBSERHUlVaakloWS9Wd2duNmQrWXFm?=
 =?utf-8?B?TytrY0MrM0lELzhqeFF3TWxSaU1XWHRCZ3pJUWlLV1IrdGlQZlhnS1c3Y1h5?=
 =?utf-8?B?cC9xZHV5ZG1RK1djLzRyTSs0dUw2a1VOa1FpYmExRnlpVG9LZndPODFNOCtj?=
 =?utf-8?B?S3ZpSkoxeHovN1JONkp5RUE5NlZSUkhVaFRvQTcycDdxbVprUEl6ZEgvMnY1?=
 =?utf-8?B?RlNtZU5GMXhoYlFTS3Yrc2ZCaXV0cUZQWlViMWdMS2RmYmc5RlRPTmdSU0g3?=
 =?utf-8?B?T3BwRDNMekFXTnRrVFlmSzU3aXdMT0UzWFVyc3NPRmN2VHFoWkVnTVNhNGs0?=
 =?utf-8?B?Q3FDR1UxWGVFT09MeFZseUdLYUhNZ1RQdzZqWUtIRG44d2NMdzlHdjg1bXBC?=
 =?utf-8?B?Q3I0MEkrQjhqM2p6MFNEbStOWHljQzY1KzRPNWpEd1JlWmk4a1E5Q2NxY3Ix?=
 =?utf-8?B?emhJak1MNDhuYmJQNDRtdkp6RFVHcnN2aElRNFFNRXY0ckdCVHptTmRGTjVH?=
 =?utf-8?B?YlMwalVyaDJpTjlxQ3FlZWNhdzhoNERtclNWcElYZ2lUV0pxczlhZ3ZJekpw?=
 =?utf-8?B?UkM5NDNQaytrWDJhYU5WNmtDQ1hxT04rREI4ZVh6bHB2M3M5U0liN0xBdExr?=
 =?utf-8?B?Y044QlRBdUdTU2dSSTZKOTlGNXUwWVUvZ1JyQlRIQ3o1SEFxL1dIRFVhYlZM?=
 =?utf-8?B?QVlYNFJsSnFGWFNBbkRFVHo3aHA2TTY1Tmp4d2V6dldZMVJrTGowSzRWMFpG?=
 =?utf-8?B?TUVsOEVQTklxcVRqUGp0M1I4NXo0Rkl5OUFDNTBFZG4reG1OajFIMmRHbHlY?=
 =?utf-8?B?MTB1ZEgwMGZyWjVheVZZbmdyMEI1SzNJUjMzRG1zQXlKZU5ISUYzbS94NUFX?=
 =?utf-8?B?eHhyZjBVcVRnaG9DeURkbDJVQWlnVmVBMXlpbnk2enpja0pjcWZpczVBRlRY?=
 =?utf-8?B?TG0rWW5ZTnhXMjBRT3RMdDB6OERkczJGYW0vb1crRXVtd1g5M3ZWQjVHWTRD?=
 =?utf-8?B?UythQnAvQTRKbmlOZjc2Mkt0ekw0VnorSXJjenp1UjByMnVwU3pjRzJZQ2hv?=
 =?utf-8?B?OCtoa1c4VnBycTU5TUhVejhZRnd4QW94aWZxbDk5WXJ5WXNleFR1ZFd5UHB2?=
 =?utf-8?B?YWtSV1hHajJCWWpUUEpvbGppVkd3T0VjcmVwdVNwbU4wRkhRZ21VWHkvT094?=
 =?utf-8?B?NDdaN3BzZWFjMDhnM0lWQmYweWY4QURlL2paT2NvckJpMWJlWkM5RXoyWmlV?=
 =?utf-8?B?ZHBBNnh6MEJsV0FBUGpieHc4ZE1xY2NEblRNZWtRL3RYYkt5ZWNIcjJHYTh2?=
 =?utf-8?B?Q0hFYm56a0lwKzA1WjRWeHVtelhpQS9iQmxHeE1WTGd1QVZzR2hTTVJqVEtD?=
 =?utf-8?Q?69Ibd2VEW50wNnQC01spmCSpf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57A6B727D538194A9ADB8B384A26364E@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR02MB10280.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82456a1c-f671-48bf-4109-08dbb8e2a7aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 07:33:01.7986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: syzTyVPa9BQdxVKdFDPalh9gDh/2Jv/GN26xy4kAKYWP6ByiP6W7RpH/qOPM1Xqt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5868
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,TO_EQ_FM_DIRECT_MX autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA5LTE4IGF0IDE3OjA0ICswMjAwLCBTZWJhc3RpYW4gUmVpY2hlbCB3cm90
ZToNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcG93ZXIvc3VwcGx5L3Bvd2VyX3N1cHBseV9zeXNm
cy5jIGIvZHJpdmVycy9wb3dlci9zdXBwbHkvcG93ZXJfc3VwcGx5X3N5c2ZzLmMNCj4gaW5kZXgg
MDZlNWI2YjBlMjU1Li5kNDgzYTgxNTYwYWIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcG93ZXIv
c3VwcGx5L3Bvd2VyX3N1cHBseV9zeXNmcy5jDQo+ICsrKyBiL2RyaXZlcnMvcG93ZXIvc3VwcGx5
L3Bvd2VyX3N1cHBseV9zeXNmcy5jDQo+IEBAIC00ODIsNiArNDgyLDEzIEBAIGludCBwb3dlcl9z
dXBwbHlfdWV2ZW50KGNvbnN0IHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGtvYmpfdWV2ZW50
X2VudiAqZW52KQ0KPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCkNCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Ow0KPiDCoA0KPiANCj4gKyAgICAgICAvKg0KPiAr
ICAgICAgICAqIEtlcm5lbCBnZW5lcmF0ZXMgS09CSl9SRU1PVkUgdWV2ZW50IGluIGRldmljZSBy
ZW1vdmFsIHBhdGgsIGFmdGVyDQo+ICsgICAgICAgICogcmVzb3VyY2VzIGhhdmUgYmVlbiBmcmVl
ZC4gRXhpdCBlYXJseSB0byBhdm9pZCB1c2UtYWZ0ZXItZnJlZS4NCj4gKyAgICAgICAgKi8NCj4g
KyAgICAgICBpZiAocHN5LT5yZW1vdmluZykNCj4gKyAgICAgICAgICAgICAgIHJldHVybiAwOw0K
PiArDQo+IMKgwqDCoMKgwqDCoMKgwqBwcm9wX2J1ZiA9IChjaGFyICopZ2V0X3plcm9lZF9wYWdl
KEdGUF9LRVJORUwpOw0KPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCFwcm9wX2J1ZikNCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVOT01FTTsNCj4gDQo+IFRoYXQgd291
bGQgYWxzbyBjb3ZlciB0aGUgbm8tcGFyZW50LWRldmljZSBwYXJ0IGFuZCBhdm9pZCB0aGUNCj4g
ZGV2aWNlKHMpIGJlaW5nIHF1ZXJpZWQgZm9yIGRhdGEgYXQgZGV2aWNlIHJlbW92YWwgdGltZSwg
d2hpY2gNCj4gd291bGRuJ3Qgd29yayBpZiB0aGUgZGV2aWNlIHJlbW92YWwgaGFwcGVucyBkdWUg
dG8gYSBob3QtdW5wbHVnLg0KDQpXb3JrcyBmb3IgbWUuDQoNClRlc3RlZC1ieTogVmluY2VudCBX
aGl0Y2h1cmNoIDx2aW5jZW50LndoaXRjaHVyY2hAYXhpcy5jb20+DQo=

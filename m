Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDF47880C7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242999AbjHYHSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241794AbjHYHRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:17:49 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D301E6B;
        Fri, 25 Aug 2023 00:17:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDD6Icnata43282knHJvv0D4IIvTnazxosoWdvzeUO6tquxWHkILtzl62KdLfGpGTOMDBq6AysYU7iiJgGjYP6mumSeYb27knLbnSOKa/qI23Ty0ZX2pIUmgkcGIywJWSY77z38pqjtkrscwTUev48Xmf9/E+x4ULLR1BI4vmeCNiu2k114ivEPJj6pRM9Kl8+A2pbc8uKEnVQWVJEWZVPt2kxOwoQAMDi6DxLMthHfDNczbdmCWERDj64IdSqcHOq7bixgwWLN874bXRJekG6ddhEiKb1KKs1ffH4XY+VYyxGrHf9XTNbuBFUf3kffCLfO+YknAlkCJKltON2Cc7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NCFSN6Cu+a7m/3UZM2J4wHjw1Al7hEH9wf+1C8zZMo=;
 b=aHqzF5jrZlKRxzBmVhajvZHFbzd1WfIfeKd2dlbIbmcQ2SQd49T9GQaZrrDyVdbMj4wgxQjNQn/T/BJJzd08lMgzOZZ+6I/UvLIQLa8NqyPUp1dtDXEojX4v2gQZrtFY6zuJxkeoIivpFRd6FGWqv/H7b6vaZ2K59T6ZOSF9qmKUscU6qaz06Nr+CZEKrfOM56HBOV6SPBgAV61KsYZ1QKrdK7QeBn9wx7DbchRyV/8coedumMU3Ih207orGTaDRSLUXMu8ODoFYTDmOtsB7P3Ujs6L7HsqHTFo6RsL2P7ElvxW71rVfJ5Id449T0vIpnnOeXYTSiYeYN3hG1N1Wjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NCFSN6Cu+a7m/3UZM2J4wHjw1Al7hEH9wf+1C8zZMo=;
 b=FpbeStm+NcuvfbibKJXjJdSS0XPbtLohUFOar88TJAt+WtfZYr46u2JmmLwN+rCLjwTfVkV0ObMtDVEiUkCxD4J/vrBv/zt/1TecUctxzSDiovRHrEnrWnV4NLgyYW1o9rC4uIaZNJedhollJNx00wGfPCEKX3J+FLPo0cF1HpKP8haMZiCWRF1+C3DIUiAoHl96vBp4oDz2qiAeFgLpPt/S8ZL3mBW45ooT8Nh3oF9VwWv+fv/Sc+xsHXC4QmWTJLczJaT1UvTT4cJ16QTbh9MEtMPYepAGoWA0N85UHXI+GXdZP2H8lBEWZF5ZfmcWGevQYYyCKlNsv667nDBiRg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PAVPR10MB7060.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 07:17:42 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1422:2669:47c5:d7bc]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1422:2669:47c5:d7bc%2]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 07:17:42 +0000
From:   "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "lukas@wunner.de" <lukas@wunner.de>
Subject: Re: [PATCH v1 3/3] spidev: Simplify SPI_IOC_RD_MODE* cases in
 spidev_ioctl()
Thread-Topic: [PATCH v1 3/3] spidev: Simplify SPI_IOC_RD_MODE* cases in
 spidev_ioctl()
Thread-Index: AQHZ1qdJ6bgKs9m22EqxNH1Od3ICfq/6mymA
Date:   Fri, 25 Aug 2023 07:17:42 +0000
Message-ID: <fd0b4e1736a46a427d980a703fb99b9205bc4f84.camel@siemens.com>
References: <20230824162209.2890440-1-andriy.shevchenko@linux.intel.com>
         <20230824162209.2890440-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230824162209.2890440-4-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PAVPR10MB7060:EE_
x-ms-office365-filtering-correlation-id: 71998894-b22b-44f9-a0ed-08dba53b5f88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Nmmr7ATMcMy7XYBJj5fWNNAEZ6AlLQ7GM2SVZ1m0rwOlzP148myE/N+Uewc22y66F008SbVd2wihvXhxJzGIfWXNGokID8lQV7AaNF9I7bYbxB2WPH2nWM1B9f4hWWosYxAPUFWNzvkymkcZZxy7qxboIMRudL4Yq4XWxrELxb2Sg2knznN8ctcIVF4JhV10lrHulqBsuGisZDTe3opQgsqHxmK8Hr2Ofg21QnkiqUw4f1GiVHSRFiJCke/5iYywDg5ONuhvFKTUoYhNg65u725IU+ssbEuChClxwBQtdG8ZRkNnZtIPCxPBzTsieSh8AuTgUfLDBggP1JgcwnqjjYNr2QIJ9ivCggc37whw3pS0SlQqsi/vbYxCos7P6e9qqIyfPwTLnJDJ6XW2xWPGwSLbgIHpyT1wnwzpuRlut9yhJNtStDS44z3m2P/lrwm3sZ7C1Ru1GWNN5NE34qUkgHWLod4RnjIxj4lL0hSoB8QhWpQm6xfjsqSqQVYVMClrxnhYHoY348ZxFTgW+JnoGWhSeCENcvocaj/S2miNoatk0u0e/NKmC/GZjQVBGLGYV0HsUtjnmuZQ2rp+0gEd9q5Sc4d9vOeq/FcMti254kTkEbh7hXgFlxbB77zaLW3h9qY6RSXasJ4I5MwFxmGFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199024)(1800799009)(186009)(82960400001)(122000001)(38100700002)(38070700005)(8676002)(4326008)(8936002)(91956017)(64756008)(41300700001)(6486002)(6506007)(316002)(15974865002)(36756003)(66446008)(66476007)(66556008)(110136005)(66946007)(76116006)(86362001)(71200400001)(6512007)(478600001)(83380400001)(2906002)(2616005)(5660300002)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVZKUmJwSGNFZHFQYk16NjViQUhleWs3emRxV3lpYXp4ZmZ4RVdaM0hzZXFO?=
 =?utf-8?B?N2o1Si9PQW5wU0xYSHpyMlBZSW82NEpTZmFJZ2QxSTBaRHU2N1Raa2k1WWxN?=
 =?utf-8?B?eks0NjVqbDIrL2dEVFlyeDcvYlp2elZ0Ukw4dzRMdUR6Y1FnWEttdy9uYXl4?=
 =?utf-8?B?U0Q3QUxJcmNydVhjZmIwWDh6aXV1QmtpM1hOekdlVGx0bEFXdXd1VGtDb2Vl?=
 =?utf-8?B?MjVYOUJLRExqRHl1NUpRbm1hZDBwbjhiMmhBeFUvODg1eldFWllCTnZ3eVlK?=
 =?utf-8?B?K3RvUnJta0dCZjJhQ1l3QytrNEFtZ0l1TFF3MDlkSTZWaE9WblhKVGN1cGFS?=
 =?utf-8?B?YnhvZS9oY05sSWNxcWlWb0dKVGlkcGYxWTZJbnF2NjBmcDljcE1GWjIwaHhF?=
 =?utf-8?B?ZHlGcHliQk40d1FIOUVTcTlod2x5RE1BSWxBajVLWWg2VzFmR2hSNEdOWjhD?=
 =?utf-8?B?U1JwWW9iWnJZWWtrQ1c5T3dQQzFVZlVKYXZ3cUdGT05wM3hGY1Q0QnlCQ3or?=
 =?utf-8?B?MmRFSDlOVXh5U3dCalBaSHNDb1J1MG5pd1VOaWxMSzA5Q29OdjlTRFQvNDNs?=
 =?utf-8?B?bWpIb0FkMmkzd2xIWFhrWWFuSlp0cGZxMS93UDFQNjRaSEIzMXA2bDdqaFkw?=
 =?utf-8?B?bDd5bkZYVHZzMy9welgySW9xTmgxSWk3dWhTckN6eGxLMTJscnQyL1JJckVx?=
 =?utf-8?B?QmhWS1ArZ2U0MGZVUHpubGtlQjY3V01Bc2pmS3hJeHFERE5tR1M0Mlp3LzBY?=
 =?utf-8?B?dTl3RWZrUTA4NFJxeVRScjRhbVhQRHQ1YUU3WDkyaDhzb3V1Nmhaa2oyd2kz?=
 =?utf-8?B?dXcrVldWZW9jWi9ob1FsM01ONXNyWDBDV1BZSGZiczZnMng4OFVVTjJCVkla?=
 =?utf-8?B?UjlVa3dJSDNPYXdpTVBMOHYvcG5peHBEREZiRFN5ZDVlWnVSV3VPalFhazZT?=
 =?utf-8?B?UXhGZnIxWjFVdFZUYzdNRy80S2N3akNGLzFZZUl4S1VZY3htNjc4SnZXYXdD?=
 =?utf-8?B?RTRUWEhWZS94TUw1WWgxR2krT29iN1B0R0FBU2I3Y21WeFp1bDNoclNzOHl1?=
 =?utf-8?B?VlplbGxpUXQ2eGM0eHpZeXNRYlJvYmtOcktUdVdsUEZvT05EeEFDVE0xLzhh?=
 =?utf-8?B?VE8ydEZDM1g2RjVvb2ZmenJXb3VLc3pTWFdLTUhERUZMcnFFbXRBc1FESnNl?=
 =?utf-8?B?NjgwUDFqV2VOS29Bc3pTSldCTjA3MFl1Z2ZBUVZuaDV5M1hMTTVHd1ZLZFFx?=
 =?utf-8?B?Mytqc0xMQWRkWlE2cG5ZVUQwc05SOVBFb3dPY1pjMG5mWFpzdEFEMzA4S1Vz?=
 =?utf-8?B?UkVURjF5YkVYQ3psVVlUTEVINUdzUlVJR2Y5R3AxQy9jNjZ1NUpUclA2QXFv?=
 =?utf-8?B?K2RNRHVsd2FzZkxJdklqS1FCRUY2WUlBV1BOS0ZFUGo4UU1JMDFhYjhDY0ZF?=
 =?utf-8?B?UWgwaEZacTUxbno2VFVoRjdDZFpSWkFWWUllSkt3V1d0M0lET0VHQWJWYmls?=
 =?utf-8?B?Zkk3Vkt6LzhiQ2ZocmN6MEtaWXdaZUFEUnl4QjlPNncwMXp0S1VDaXNGY0hh?=
 =?utf-8?B?WmI2MjQ2eXM1UWp5N0ZNK0VFQXhKOEphOUI2SnA3bUNSdy84VXpmdmxSZ0tD?=
 =?utf-8?B?QVdDOHNLSjgySGVwdTNadzhuTjJEeUIyTzd6K2ZTZ09Qdy9LajYxeHlLUzB6?=
 =?utf-8?B?QjZPdHdQa0dlR2F5dmo0TUY0ejFsUHJxb2gvYi8yeVVUTmdwU2RibWlDK3JH?=
 =?utf-8?B?VWF6OWVjMUI4eTEyTDNURUxQRWovSXFVYnNldG9aOURwNC9IVE9remZ2Y0ZG?=
 =?utf-8?B?SzJnTWZPY1prbWpDa3ZxV1V4aTlaOHhnM2xJTlV2M2xkeXVHUXZBYkM2cmVZ?=
 =?utf-8?B?Nzlzekc5Tk1mTFBGclVhVFNPaUVRSmFIZ0ZxMkxkRERiT3RoQmpITUlTZlBF?=
 =?utf-8?B?eGNKZ3ZsWnRnajkzSEw1VEhhOGpqOGRubE4rVEVoTU16L1dRZ3ZDTGd2cEZ1?=
 =?utf-8?B?SzFxU3hrS3JTcFVJd1NjYzI0em1XOEY2dFo1WEhVNUExQk42OG5PcHJSR1Vm?=
 =?utf-8?B?bDd4SmdHdEpaWHdrMWZPMkR0RklCQm9uaWVMeEJnbmorSGZrbFNUQ1Jtc2V5?=
 =?utf-8?B?eUNxRWI4anczVTVhKzFWRTlqNzhGMlBZK2FlMmVuSk4wR2NhQllSc0dKQWRB?=
 =?utf-8?B?Mm50enlyelhna0luSUlnOTROK3hEK3d0ZVk2MkVOZzR5RzB4NGU1c2hLNXRo?=
 =?utf-8?Q?vLKbJYXX6mA2/UPWOanKESnOwnKqzuzG8vBVncMml0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12A23318050BC940A07B300528436390@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 71998894-b22b-44f9-a0ed-08dba53b5f88
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 07:17:42.7314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jxM6PHBkngsGcl/Mru64xJYFFLec9tjoVvrkEPm1GRs8Z2HVwphcwEw8ut6x5IBWbl0YcILB5Zg8EZw6xyzFcGth4HY2h/XFKJjXVAK9yss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7060
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkhCgpPbiBUaHUsIDIwMjMtMDgtMjQgYXQgMTk6MjIgKzAzMDAsIEFuZHkgU2hldmNoZW5rbyB3
cm90ZToKPiBUaGUgdGVtcG9yYXJ5IHZhcmlhYmxlIHRtcCBpcyBub3QgdXNlZCBvdXRzaWRlIG9m
IHRoZQo+IFNQSV9JT0NfUkRfTU9ERSogY2FzZXMsIGhlbmNlIHdlIGNhbiBvcHRpbWl6ZSBpdHMg
dXNlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVu
a29AbGludXguaW50ZWwuY29tPgo+IFJldmlld2VkLWJ5OiBMdWthcyBXdW5uZXIgPGx1a2FzQHd1
bm5lci5kZT4KClJldmlld2VkLWJ5OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVy
ZGxpbkBzaWVtZW5zLmNvbT4KCj4gLS0tCj4gwqBkcml2ZXJzL3NwaS9zcGlkZXYuYyB8IDggKysr
LS0tLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0p
Cj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL3NwaWRldi5jIGIvZHJpdmVycy9zcGkvc3Bp
ZGV2LmMKPiBpbmRleCBlMzI0YjQyYzY1OGMuLmM1NDUwMjE3NTI4YiAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL3NwaS9zcGlkZXYuYwo+ICsrKyBiL2RyaXZlcnMvc3BpL3NwaWRldi5jCj4gQEAgLTM5
MSwxNyArMzkxLDE1IEBAIHNwaWRldl9pb2N0bChzdHJ1Y3QgZmlsZSAqZmlscCwgdW5zaWduZWQg
aW50IGNtZCwgdW5zaWduZWQgbG9uZyBhcmcpCj4gwqDCoMKgwqDCoMKgwqDCoC8qIHJlYWQgcmVx
dWVzdHMgKi8KPiDCoMKgwqDCoMKgwqDCoMKgY2FzZSBTUElfSU9DX1JEX01PREU6Cj4gwqDCoMKg
wqDCoMKgwqDCoGNhc2UgU1BJX0lPQ19SRF9NT0RFMzI6Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHRtcCA9IHNwaS0+bW9kZTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgdG1wID0gc3BpLT5tb2RlICYgU1BJX01PREVfTUFTSzsKPiDCoAo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgaWYgKGN0bHItPnVzZV9ncGlvX2Rlc2NyaXB0b3JzICYmIHNwaV9n
ZXRfY3NncGlvZChzcGksIDApKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHRtcCAmPSB+U1BJX0NTX0hJR0g7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGlmIChjbWQgPT0gU1BJX0lPQ19SRF9NT0RFKQo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dmFsID0gcHV0X3VzZXIodG1w
ICYgU1BJX01PREVfTUFTSywKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKF9fdTggX191c2Vy
ICopYXJnKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHJldHZhbCA9IHB1dF91c2VyKHRtcCwgKF9fdTggX191c2VyICopYXJnKTsKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVsc2UKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHJldHZhbCA9IHB1dF91c2VyKHRtcCAmIFNQSV9NT0RFX01BU0ss
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChfX3UzMiBfX3VzZXIgKilhcmcpOwo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dmFsID0gcHV0X3Vz
ZXIodG1wLCAoX191MzIgX191c2VyICopYXJnKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGJyZWFrOwo+IMKgwqDCoMKgwqDCoMKgwqBjYXNlIFNQSV9JT0NfUkRfTFNCX0ZJUlNU
Ogo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dmFsID0gcHV0X3VzZXIoKHNw
aS0+bW9kZSAmIFNQSV9MU0JfRklSU1QpID/CoCAxIDogMCwKCi0tIApBbGV4YW5kZXIgU3ZlcmRs
aW4KU2llbWVucyBBRwp3d3cuc2llbWVucy5jb20K

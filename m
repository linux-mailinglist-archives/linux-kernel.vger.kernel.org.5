Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3681E7880C3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242913AbjHYHRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243248AbjHYHRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:17:40 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2063.outbound.protection.outlook.com [40.107.6.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5E7E6B;
        Fri, 25 Aug 2023 00:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TR/QqU++IpEkLWRyetvTxiQ1fU7rekPSLs5MzNDGl8kZnZCcsQbdrC+DiEdfnk2IakhQjTyDM/Gv3uCSyYHPNNxN6JVeXhSuCf8VwkRH2yu7nYT7dbMotOIaJINC44R8AjDczX4K3Ap/1W4nk3W1XEQ/pvQz94LoVpDfTACuW0/8CyC2AOobsdzuZw+PPA0Rk2Kf160Dqa0LeVhSBmLIJP80v8omRSG0eZbYbNP8ou6WV1Q/dmKx8jSqZgZWsvAP95lqywUYarX+0EjM54mtG20Xw0c8skYwpTesq4rXoBcaIzIrHMU/xhEgJMzy5Gq11H4cunYxLEEjs9E22cKbjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pnk3sq7eC0AM00RXRvhJqYWfBHTxiegzpMWwPfiFLXM=;
 b=ce+ZURDjY9gRWudmnM5qSTm81mObO1Z/9b268PdSx7mSyDRsEO/i9gVQh5LmFANXbZQtmP1fGFneUB+D0EQHEfSw5m/mRbFOlR2EBY84yNG1/V+VjkJYvsW7MYWcrjPRQT+Lp7ATs6DLf2bBUz7SL3iT1Cq7CIxPELdI5FD2gsbJ+MFXy4IV1OlDXvNggNB5WV4H4bqhFeodPLk6ThhilrIg6vdUahdIAgsvcJaAqNuflCiSD6se14XwydKNDZ+Ue1lH4Kb9FtnMlAFfea3zguFr3+TE6I3BbQ5l2cX7Ca6EupgJ4nYpiC+Cp3er2bUV6oANR5/9QFKGXdWhyMkhkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pnk3sq7eC0AM00RXRvhJqYWfBHTxiegzpMWwPfiFLXM=;
 b=bynIJA4w4FMEKpYSQgmtvK59onI+qnZrpQneEzbDmHT2rg4SWu7YFMgD4a6dnFgBT4bTNtG1cgVM+r1haS+taLvmLUWXBjPqU5z9po2S5D6iydJYguX5OrO9EIXHinVStPjV9IXoNQFQD0M0I8Bl/jFnPeh9RbmJMxgYxZvXIaYBNiDR0HwUV4I820dXAMs1brVuuHVku0Tpo1dzG63nzDS0nwA6RS8OftH4hCyOepRGCcGi54zWk4qyzEbXfx4VMW78XD7T0dBHu6nXDf7XtJ9y7UqMXWcXUEt7Q2Hngss6NvWzu4cuuxYGDzpvEcW7OwW8G0mvY0/vHM3OZAdYIg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB4PR10MB6094.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:38e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 07:17:34 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1422:2669:47c5:d7bc]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1422:2669:47c5:d7bc%2]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 07:17:34 +0000
From:   "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] spidev: Decrease indentation level in
 spidev_ioctl() SPI_IOC_RD_MODE*
Thread-Topic: [PATCH v1 1/3] spidev: Decrease indentation level in
 spidev_ioctl() SPI_IOC_RD_MODE*
Thread-Index: AQHZ1qdcR59ZNVMhJkSUmUCXw/8hXK/6mx+A
Date:   Fri, 25 Aug 2023 07:17:34 +0000
Message-ID: <f68cdc846df640b7423e91dd59fef4297de10059.camel@siemens.com>
References: <20230824162209.2890440-1-andriy.shevchenko@linux.intel.com>
         <20230824162209.2890440-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230824162209.2890440-2-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB4PR10MB6094:EE_
x-ms-office365-filtering-correlation-id: 1af82fdc-5f26-4865-836e-08dba53b5aa7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mja5WwbsfTTCw2rNcT7XmyhDquu5EumSBvj9c9cP6Ni6soC6swY/rJLAkgu2y0g9V3xzeiBKlkf+KDgqLgcgel12QszOutbvUH8fdpXT4f2lqikMpZs1YBkojLhVr/WhvbcSgFevuGrcGmo7kZSFKVNquKmW+BhMEQ62+5GWviz8/ND1Uopaau09Ni1lH/HfArUC+akUoKQN31veWPPzmkVausD2yAHc3H7aoAUPYw9w+ciFanUm7PY6mYNSgjq9Ir3QYgvqKjnche1RUWWa9jvXmLo0RNfhFj12h79odg7fxH3RyHak9XGAa+vRZlEWoRMzHWB5VVWMn39mNQCRrwqdl7+IAmQe7B1mk+nk0FqAfq+cQeSDDvZ05HSFe41fKH3jTb09pZUnfjF5nx/yxz0X6Z97HHEO5mRoXWdm8yw06aBXKRE9PoCh9QtN4NNchC/sMBtuWcNc8wKCRffTNcPd0mQedO00hgS3hs+7aMNzff6F+4jXlvM1M4X0JL9zn8NJWCp9idgP2BpuFBZb0NEym45uAz7hzN47aHn3vGjUWmSEc06rt4byTDLSmVaEGGDYpNRNbHeN78qxg5L09Gkb89E7oyYnyZN2ryj72vPG2HRmT/xaPagJ80ylSq6Ch/G8i9k/4F9VtLF9glgLYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(136003)(346002)(396003)(186009)(1800799009)(451199024)(2616005)(5660300002)(8676002)(8936002)(36756003)(83380400001)(71200400001)(38070700005)(38100700002)(82960400001)(122000001)(66556008)(66946007)(76116006)(66446008)(64756008)(66476007)(316002)(110136005)(91956017)(478600001)(15974865002)(41300700001)(6512007)(2906002)(6506007)(86362001)(6486002)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0V2REIrT2RkVEJLWW1adW04TGtIeGxiRi96UXFJN1ZBQlNhb1V0cUQrSlZ2?=
 =?utf-8?B?UkpvMFVkYVJhM3p0cWZvOUptTWZwQndhMnd3QTUvRitJV2dUbURQcVhKa1lY?=
 =?utf-8?B?M3NYK0NDVHErSXRmRmI2Tk1rSkI1TTZpR3orOHkzOEZQc3JFVVh1UGVXbksx?=
 =?utf-8?B?ek9YOXdmVTJmNUVWeW0rVGpUWmVUaVlyTURLTFVWMEN0QUhsQXpaRTQ4QUY0?=
 =?utf-8?B?dnVONVNiRHdpdnFDbU9XM1hGcE5DQ2s5eFZnY1lFckY3SkI2a2JlZkxDVytH?=
 =?utf-8?B?ajJ2VTFML05EZnNHY3RzWE8xMWFmNlc3cEpGYXAwU285Njh6a24yenNydjRX?=
 =?utf-8?B?TmQ5YVJidmFJTW05Zm1BZjdaKzB4RVNCSkJtbW0wR3A3UTVXcWtSSEgrWTB0?=
 =?utf-8?B?NFFnK2NUV2xvTlVoQ1NGVGsraXd5czM5Z0hXUWkxRnQ2TmxDTGVWZ2dacXdD?=
 =?utf-8?B?ZVl6OCsvMnhaOTFmSkI3NGVKQ1R2NXVkYWdSRGlLZzBxZGo0c0NKTytGQXJq?=
 =?utf-8?B?RlFwL3BWNEloall5cGJuZlBteVVBaTV3aEJnUWdSbzg3S3VUNmdBcGNXNHJO?=
 =?utf-8?B?ODVDMEdRYlhXbHBtVjdLQWZEcXQwWWRSMWdFelBSQnlYcTdMTjlsYWpBamNX?=
 =?utf-8?B?ZHY5TTA1aG0vemcyaGNESzBtK3JKeWF0VVlNUGpJUTZXS1EwN3BUSDdzUitJ?=
 =?utf-8?B?WVBINjJaakZtRVV2Rm81TDc3VW93bDMxQmh4NCtnTXppL3REenJvZXJNKzFy?=
 =?utf-8?B?WjltNnkzZDNsTE5tcWhpVlVXMDlucEs0L1g2S2JVMkdMUU1FM3BleHkxbWFo?=
 =?utf-8?B?UXFzUDRXOUlmODI0a3BOL2sxWHlIYXkwT2wvZ1hZNkxYbVptcGNFdkxBQXhl?=
 =?utf-8?B?TjVvVkNFMFBxT3ZUVXF5Z2hvZ0l2ZWFpRVRYc2lGYW5pdW9ZSnpFTzgwTUJL?=
 =?utf-8?B?Y2hSaERzZkU5ZXRoUXk2ZDdrSHN2VWQ4SlBVYWhXdlRwMFR3dC9WZnBtbGJH?=
 =?utf-8?B?L3kwY2RqZWpNTFN6UXRKMmk1YUZ1WmVoODM4MzV3YTAxeHFoWVBrNXdjbnlH?=
 =?utf-8?B?N1JkcnBCeHF2WWZjT3FwNnVTZ05tTlBPN2M5SlZXUFlNalR1NDh2bWJrYTlx?=
 =?utf-8?B?Z01IclBiMXNBMjQzQXA3YWg3eStnRzhkU2EzQWRiRk1SSDZucy9TUmpYdnhJ?=
 =?utf-8?B?alEyQkh2ODBKWW0xUzhOUWRuenhBUU9LckNweGx0M3YxcDhrOTR2V3BlOFFV?=
 =?utf-8?B?VUxXYXpRcTFHbTdPK1dwelZkczBLY3IxaVhmVERFK2JkeklYVllxZXBKd1Zy?=
 =?utf-8?B?K0E5UElZd3EzVW5XeDd0QTVnY0h5L24xR2dmTDVsWkFkQkZTZWJ0KzBKbHBQ?=
 =?utf-8?B?cExqMFNuT1hnYUlYMEFYWWNJMVJVYnoyaS9OdmJ3TGJVQzRRdlZWRTJzWWFo?=
 =?utf-8?B?UjBQc296NnhUUWdTMWR0U3lsMDFaZmovZHRrcDdsS2NEQW00em9Fbllmd1ZG?=
 =?utf-8?B?OFJ1SmREalFvSXozcDhCOFcwYUFYSzFyQ0lkQlZrU1dJWW9EUVNwL1F1ZlVP?=
 =?utf-8?B?WFA1Tm9qZmpDYWQvempGYSs2eVFJYlJYNXVUTjVISXkweDVVSXhOS1BaK1NW?=
 =?utf-8?B?Mk9IaHhTWUdqbzIzOXEraVc5WnpoSE13anJFc1k1Vm9vM2pSWEloelZjSlNl?=
 =?utf-8?B?SGNnbDMwaFZ3TUxYeEVIVCtTcFF1VHNOOHJzejhZazhyV0tWSG5BMSt2cVc1?=
 =?utf-8?B?VzhUZ2VHSElBMTV3bTdBLzZ0bmxFVDQyeC9HOUsydEhFUzlabU84Q0ZIeFdw?=
 =?utf-8?B?M1V0ZktPbkZ0aWNsZ0tSWkF4WWV1WXFaVS8xRjRSTG14bGErZDFwQWxuUUx1?=
 =?utf-8?B?VUtOZlgzUXZvbXc4dVlsVUdPeGE5UmRITG84aUZCa2FSZlM2V015V1VUZnBS?=
 =?utf-8?B?MnNjOS9VN1lMT01CK01zK0ZtalpQSmQ2QnZna0VJWWo1MzJSWENiVTgwU21i?=
 =?utf-8?B?OXQ0aHRmcVlDN0laQWVrMDNIQWxFeEZYbCtsS3FZUlA1R21zeU9JVjZHLy9Q?=
 =?utf-8?B?RWNJM0NBKzU0cUF3S2RpMDNIQWYyQlhySkF3QXp1YWFDWVhFSzZpOFQ0b2xK?=
 =?utf-8?B?SlJsY3E1R3c4NXZYWStoTVB4Y3Bsd2tmeEZiSWJ4YWlxVGVkMUZTK0s1RHJ0?=
 =?utf-8?B?Y3VlR3ArejB4Z2FJVUNsc2Y5ZVdXZmFmaXQzbTRNTlR1U01sazdlWVhNbE0r?=
 =?utf-8?Q?Iw8B0p/COLjn/rmcgFtCof1shFtPr2dB9HiRPDUmQc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDA95C39A48EB3499BD878A60B6DFCA5@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af82fdc-5f26-4865-836e-08dba53b5aa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 07:17:34.5483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4TvRcFukIQ+wfnfHLIc3+9W4CZzfJRc7Lm0OT1/TzqVL9qLYbE4j6ehvKgsGIu5ocArj0nZxQPMnKrA5FNbigwJbzOD+yMayhnnGhufGGww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6094
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
cm90ZToKPiBJbnN0ZWFkIG9mIGRlZmluaW5nIGEgbG9jYWwgY29udHJvbGxlciB2YXJpYWJsZSBp
bnNpZGUgYW4gaW5kZW50ZWQKPiBibG9jaywgbW92ZSB0aGUgZGVmaW5pdGlvbiB0byB0aGUgdG9w
IG9mIHNwaWRldl9pb2N0bCgpIGFuZCByZXVzZQo+IGl0IGluIHRoZSBTUElfSU9DX1JEX01PREUq
IGFuZCBTUElfSU9DX1dSX01PREUqIGNhc2VzLgo+IAo+IFRoaXMgZHJvcHMgdW5uZWVkZWQgaW5k
ZW50YXRpb24gYW5kIHJlZHVjZXMgYW1vdW50IG9mIExvQ3MuCj4gCj4gU2lnbmVkLW9mZi1ieTog
QW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+CgpSZXZp
ZXdlZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5j
b20+Cgo+IC0tLQo+IMKgZHJpdmVycy9zcGkvc3BpZGV2LmMgfCAxNCArKysrKystLS0tLS0tLQo+
IMKgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKPiAKPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvc3BpZGV2LmMgYi9kcml2ZXJzL3NwaS9zcGlkZXYuYwo+
IGluZGV4IGQxM2RjMTVjYzE5MS4uZGM1MTZmMGNhNzFmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
c3BpL3NwaWRldi5jCj4gKysrIGIvZHJpdmVycy9zcGkvc3BpZGV2LmMKPiBAQCAtMzU3LDYgKzM1
Nyw3IEBAIHNwaWRldl9pb2N0bChzdHJ1Y3QgZmlsZSAqZmlscCwgdW5zaWduZWQgaW50IGNtZCwg
dW5zaWduZWQgbG9uZyBhcmcpCj4gwqDCoMKgwqDCoMKgwqDCoGludMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHZhbCA9IDA7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0
cnVjdCBzcGlkZXZfZGF0YcKgwqDCoMKgwqDCoCpzcGlkZXY7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0
cnVjdCBzcGlfZGV2aWNlwqDCoMKgwqDCoMKgwqAqc3BpOwo+ICvCoMKgwqDCoMKgwqDCoHN0cnVj
dCBzcGlfY29udHJvbGxlcsKgwqDCoCpjdGxyOwo+IMKgwqDCoMKgwqDCoMKgwqB1MzLCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0bXA7Cj4gwqDCoMKgwqDCoMKgwqDC
oHVuc2lnbmVkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBuX2lvYzsKPiDCoMKgwqDC
oMKgwqDCoMKgc3RydWN0IHNwaV9pb2NfdHJhbnNmZXLCoCppb2M7Cj4gQEAgLTM3Niw2ICszNzcs
OCBAQCBzcGlkZXZfaW9jdGwoc3RydWN0IGZpbGUgKmZpbHAsIHVuc2lnbmVkIGludCBjbWQsIHVu
c2lnbmVkIGxvbmcgYXJnKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJu
IC1FU0hVVERPV047Cj4gwqDCoMKgwqDCoMKgwqDCoH0KPiDCoAo+ICvCoMKgwqDCoMKgwqDCoGN0
bHIgPSBzcGktPmNvbnRyb2xsZXI7Cj4gKwo+IMKgwqDCoMKgwqDCoMKgwqAvKiB1c2UgdGhlIGJ1
ZmZlciBsb2NrIGhlcmUgZm9yIHRyaXBsZSBkdXR5Ogo+IMKgwqDCoMKgwqDCoMKgwqAgKsKgIC0g
cHJldmVudCBJL08gKGZyb20gdXMpIHNvIGNhbGxpbmcgc3BpX3NldHVwKCkgaXMgc2FmZTsKPiDC
oMKgwqDCoMKgwqDCoMKgICrCoCAtIHByZXZlbnQgY29uY3VycmVudCBTUElfSU9DX1dSXyogZnJv
bSBtb3JwaGluZwo+IEBAIC0zOTAsMTMgKzM5Myw5IEBAIHNwaWRldl9pb2N0bChzdHJ1Y3QgZmls
ZSAqZmlscCwgdW5zaWduZWQgaW50IGNtZCwgdW5zaWduZWQgbG9uZyBhcmcpCj4gwqDCoMKgwqDC
oMKgwqDCoGNhc2UgU1BJX0lPQ19SRF9NT0RFMzI6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqB0bXAgPSBzcGktPm1vZGU7Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
c3RydWN0IHNwaV9jb250cm9sbGVyICpjdGxyID0gc3BpLT5jb250cm9sbGVyOwo+IC0KPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChjdGxyLT51c2Vf
Z3Bpb19kZXNjcmlwdG9ycyAmJiBjdGxyLT5jc19ncGlvZHMgJiYKPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjdGxyLT5jc19ncGlvZHNbc3Bp
X2dldF9jaGlwc2VsZWN0KHNwaSwgMCldKQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRtcCAmPSB+U1BJX0NTX0hJR0g7Cj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgaWYgKGN0bHItPnVzZV9ncGlvX2Rlc2NyaXB0b3JzICYmIGN0bHItPmNzX2dwaW9k
cyAmJgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3Rsci0+Y3NfZ3Bp
b2RzW3NwaV9nZXRfY2hpcHNlbGVjdChzcGksIDApXSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRtcCAmPSB+U1BJX0NTX0hJR0g7Cj4gwqAKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChjbWQgPT0gU1BJX0lPQ19SRF9NT0RFKQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHZhbCA9
IHB1dF91c2VyKHRtcCAmIFNQSV9NT0RFX01BU0ssCj4gQEAgLTQyNCw3ICs0MjMsNiBAQCBzcGlk
ZXZfaW9jdGwoc3RydWN0IGZpbGUgKmZpbHAsIHVuc2lnbmVkIGludCBjbWQsIHVuc2lnbmVkIGxv
bmcgYXJnKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZWxzZQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHZhbCA9IGdldF91c2Vy
KHRtcCwgKHUzMiBfX3VzZXIgKilhcmcpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgaWYgKHJldHZhbCA9PSAwKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBzdHJ1Y3Qgc3BpX2NvbnRyb2xsZXIgKmN0bHIgPSBzcGktPmNvbnRyb2xs
ZXI7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdTMy
wqDCoMKgwqDCoHNhdmUgPSBzcGktPm1vZGU7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAodG1wICYgflNQSV9NT0RFX01BU0spIHsKCi0t
IApBbGV4YW5kZXIgU3ZlcmRsaW4KU2llbWVucyBBRwp3d3cuc2llbWVucy5jb20K

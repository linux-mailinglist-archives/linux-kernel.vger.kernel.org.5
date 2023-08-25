Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153F97880C6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242953AbjHYHSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237728AbjHYHRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:17:41 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2085.outbound.protection.outlook.com [40.107.6.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B27E6B;
        Fri, 25 Aug 2023 00:17:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSfdsAr2ybGwp3SgHPC/uBmKaM5228IepUTUpEfS5DB5tdcAaeqrku6jpLB7MwRQ9kOioDUMUBrrduiEYDNoQrSS9cSHvtycZMKELDoWQm9VrjQZcqlrfCV21oHhFNzzl3rgTrYs+Yxd+TyNhCLOCDz9aQY1LFV5QAtTrKC2n6EqD583QeSY+txBPjtckztx0+INlE5T8NVQStL5eeaNhCEulvbCugim0xSA93dY0rO4abLFmttdEsIXbq7nr7BPP0BdvWtVC90QoM8UjxSFw78TDwezW5nPUCOXGDWdAmv1J2OgVyFlf0irvrEfGLCuVTmqIPjs7eUXX4L3a0XUyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1hbIoTLr6lS9JHZZ5loE6AC7dFdWUPi6eQSw5uUrz4=;
 b=BwcDIeICtmhj9/T2xWIfhTNS2NNJZsPNG5imI5eFC4w+HOWoB0cJsIF6UjKyliyGEAo068u5QKd/ASL6xqQF+UiKEq+a8qMge2kqQdKPo1oBwuIlem90i8N3/pzN+Dd5IZt55lo91t+LhsvqaWJpLKF2kEKz0UCswpbE8TBL2qZ3sy1rXRSpXlDibcjed3E9Q6/YGyptuOAzDGBrrJTvLzbE/Rqis2I3VWce8omwqC6cKQJaPuHd5/t9IVNaznke/yWiIrMZd7v6N40Jm9db0lLwopXWAcdDhoktVADgtVbfx7xTjuBRD2fc2cBgVCcseVjhPvXM3QN/rMAHPHVDHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1hbIoTLr6lS9JHZZ5loE6AC7dFdWUPi6eQSw5uUrz4=;
 b=kC6RKQey72rw/H3i4EvJiJm7qKLa6f7+9cUI0Nxl3EYWo3hA5qkMJm3NpguQaKl8JL70UUC2k5PFcRYlI6dwMlZK+OfNB1jQaEwswWX6q5mQYTnLb4rUwZIE6WTaJhF3du9oa21VmEbF9q9Luwm/dZCEYkN1Iru7THHjuOIio/b/l20NL04v7MgKx+W9sIKqzxR9MPOXE0ox/RbgEcLEPbN7kSJjiQ4F54WoY6WSqCCrSqOyNyZc242FBOOtKoosxMDOLvoo+s/2seWeH72DSknM9Y4U9t5/BjehT7AutVrjTNin91cDbwjbUBMlp78BL4uIlOgDGLy/qy17j+3pug==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB4PR10MB6094.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:38e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 07:17:37 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1422:2669:47c5:d7bc]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1422:2669:47c5:d7bc%2]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 07:17:37 +0000
From:   "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] spidev: Switch to use spi_get_csgpiod()
Thread-Topic: [PATCH v1 2/3] spidev: Switch to use spi_get_csgpiod()
Thread-Index: AQHZ1qdal8s/lvYa0k+Qop484iMt0q/6myMA
Date:   Fri, 25 Aug 2023 07:17:37 +0000
Message-ID: <dbbaf3b7ece33061d4aeebd48b49a721132d3e0b.camel@siemens.com>
References: <20230824162209.2890440-1-andriy.shevchenko@linux.intel.com>
         <20230824162209.2890440-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230824162209.2890440-3-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB4PR10MB6094:EE_
x-ms-office365-filtering-correlation-id: 2f50d7e3-6276-4458-9748-08dba53b5c54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X6b/KaIckB6I71OL78W03IL9zdmXCbwrwdEYFCtWYzTGhHEZ/cNRetW3emYSclyrnw2YS1y6XKycCJzZXt0Pu6ykJVHoBOl0KhiYU+oJP/fVz/NnOBI8do1w1rvWi19nktip3aaC9DDlZ5hAhmzCJLkRrRJ6RWWZ36yjsck9D+BvhNoevrkJExZJNT6IM2xmdmo85caVlEKmE+2wnscfPIiNA3rFgoOG5fV79Rqab7DXrSFk5WMie5J83MAURKAEFO6pxWuf4yZBzXZRrc7zUimNPqZWyAN5NBHtNoaHv/d32O4zy0FWOdonDT507B/cEDrVT7DGm5SK2Y2rg1ykHlNG/4/1rlyf1yObkW1xf5O0hsbg6UX27RXzzbpf68v0pgpWMcS7/VCpUm0hf0zjyg7wgvzDVxdG1Tbxkom/yPEIK5PkZ9VvXxdiqv/KftpybyuZg4/NQFAgYta+FjE6RtFOPbaXnltKtfbbiRzM0L8jhi/um2oYhh0wV5DRq1qojnMt5IEzPUzK5kNsAjYHQzJTnpEBvEf63AhfvOu9i6TB0BlqYLlqRZn32CSqPUE5ikdOHEXypaBYncJKhyGALtkWY+ZBz6tkIv2g05WklICKXPNKnUfVaqg9rMBFD0Js+HEWPidajYY+bNNn4TXSFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(136003)(346002)(396003)(186009)(1800799009)(451199024)(2616005)(5660300002)(8676002)(8936002)(36756003)(83380400001)(71200400001)(38070700005)(38100700002)(82960400001)(122000001)(66556008)(66946007)(76116006)(66446008)(64756008)(66476007)(316002)(110136005)(91956017)(478600001)(15974865002)(41300700001)(6512007)(2906002)(6506007)(86362001)(6486002)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmVNb1kya2g1YVlhRmsrajZ1TjlKWWduWTZVaGhhZk00YlM3ZzF0UU1nSlJU?=
 =?utf-8?B?NzREY0ZTY29lV09lZkxmamd0Yy80Qm9sVFdiU2k4VVg2U3Vncm9OdHo1OHRQ?=
 =?utf-8?B?UEZSTi9IOERoWjRiaUpXMnNpbllHeGNGVVlXVGFpTFZCUksyU05DVU45K0tB?=
 =?utf-8?B?c2xQK0h5TG1JZHNNWmlGMDBSVHplLzhmYmVPT2N3V2g3azFqUTNsR3h2RERO?=
 =?utf-8?B?WVhhNTJZaGFHOGF2WVJtRERXMDY0bDRYTk9RaWpJaENtK3ovc0I1Zkh2NG51?=
 =?utf-8?B?VHNkRHZPTGEyYmZMbmk0bzZlOHNCUXdQMDNXMFV1c1BqL3dtTENCOFRVb2dD?=
 =?utf-8?B?ZTBGTEtEVzkrWEdqOVVscEs4bHY0c2RWMHZRS3U5ZmRKalBmYlY3ZkZrRmhC?=
 =?utf-8?B?Nm96RENFOHNXakdTM0E5dE5ENGNnOVBVSGVWU2RBZnBWSUg4UXJPaVFkWjZG?=
 =?utf-8?B?WjlzR1RQaUpESkFnV2s5STdCcVQrMlBvc0JFZE1XYU95UnpVMmNiN095R21w?=
 =?utf-8?B?R1MxVmh4ZzFkOXFTdzZ4aFpsNWhjOEJUYnRHMEJCMGtqL3ExazFtOWRiS2xI?=
 =?utf-8?B?WkFEaFpkbUZ3UzNrSUhYT2hYNVlrMHlBaW9KN1lSUnhnTzNKOE9CUW9XUDE5?=
 =?utf-8?B?dnFkMU9JY2FvTjZXM0djRjRjNjBFWFdkbk5VRVU2Sjh0b3Y0N1hXMkhXV1Jv?=
 =?utf-8?B?N2FoMVY3R0dBdG9KWUJROUVKUEFVR0ZjbzhwUk9YaDZTNVVoSVlBSFRJd3lZ?=
 =?utf-8?B?VDhPODhPVGZyT3V5ckxZK01Nc2lHOFpsVlovaFFINTVkenZVYkpSZ1A4cnF5?=
 =?utf-8?B?WExDR2NTS3FpYXZnRks3eXZwQnNCZXl5N1UzUVdjeDdQaFdWc1hVSitQUk9O?=
 =?utf-8?B?UmVNcmdDelEvRm5aU3loSGVnMnBNUG9KYXdvOEcycGcyQmN5TG02Q1NpRWJs?=
 =?utf-8?B?QjFxNzFYWENaQmUyUmc1OTUrR081UjRXSmpwWENjUkxDTWlYUit0Zk9sV1ZV?=
 =?utf-8?B?YWRyU0hMSVpMRzJWbGdCRkhZeFZuVkJsU1JuOXROS0pjWFI4STd6cUg0RHdB?=
 =?utf-8?B?SlVwbGJHemZiNWZyLzlCSWRiNzVRYjFpd1J6bU12ckRSb2VFRlJpK3pXb3RS?=
 =?utf-8?B?S2hrbSs2ZnM2aElkUG4rT3VKYmsrT0JpaVl1TmlBMkhjM2JpcmpETTVWUFc3?=
 =?utf-8?B?YnFZU2F2cjZQNHJsK3FzaEd1QmVaa2ZFS1M0dnBoeTUrdEJjMmg4Q01weUcv?=
 =?utf-8?B?RkEwTHpGaVV0ckZBcnpaWHl5SmovUzJnWHJoNWRrWUFCdjB6ZGJJZGVNSWNP?=
 =?utf-8?B?aGZ2V1IyWWw0Mk5pRmxRSkZaY3hseWFhcnlpK25TM0graGh6SVV0Qm5VSmRr?=
 =?utf-8?B?K3EwdTNRaGhGVzZtMGdyT2RqaXB5em1kQTFMa3lEaHJxMWpEK1ZFMWkwcm8w?=
 =?utf-8?B?dXFwbFRzVlpmdjZBaTVUTjhGMlFJVUswenN4U05VQmRhM1BqdFA5cllRM1JY?=
 =?utf-8?B?Z1FtL3BYcFlsVUIvdlg3aW5Fenp3VWI1YTVrejFzb1djYXp2Yy84Z1B6Zm4v?=
 =?utf-8?B?YWtVT0VjSG92MFNhQ0hiYTRqQUpTR1JMaFE5QUVsdVhGTllWSUEvZ00wSVp6?=
 =?utf-8?B?T1pHWDVGRklNTzNhZnp0eEZ2emVvbXZOZ1lzOGxzdlU1Y3AycU9wdVZkUnBQ?=
 =?utf-8?B?Q29wTlFlejlTMEIwSWJRS3EzWEwxYk8zc0J6UGRQYi95Y3gyU1JaUG52NERY?=
 =?utf-8?B?QXhjSGp4QkVyTnhmMEZINngrcllFeFcwL3hDUWw1emRCSUhDZkthR2Jmcmtr?=
 =?utf-8?B?eXBJeEVkY1hjczI0S055cFBHRnhaRjZrWEVOVkwrQ1hmQzR3a3NVNmV4K1lQ?=
 =?utf-8?B?eW9jcjRRUFl2ZmQzYWdOYjdnamo5OVQzU2ZvbEtVK0QrTFFUYkIwVFljWFJD?=
 =?utf-8?B?TkF1d3hsVVhpU1prWlFMa21ISXRsR0JGaDNwbXJBYkttZCtqL3p1eG1ITTRw?=
 =?utf-8?B?ZWRRa0FWOWFadTErTlVDWEVPTUVDL042MnZXSyt6TzFEQmlrcEw4aFRiZkwr?=
 =?utf-8?B?Q1l0RXVya3lJWkdxZytBMGZzeTBtM0ZLa0VtRTY3ekZCcU5wOGdJUmJpcE5E?=
 =?utf-8?B?RUFFYjkwbk1rNHpJZC9Ya1kwSFY0RHgzUFlrTVlWOGphNGtQMXMvZDlyL292?=
 =?utf-8?B?SnZHbnZCcEs0dVdWZlFad3lEUnFJREM4TUZpSzljd2pieVZJKzJCK2Fwbmd6?=
 =?utf-8?Q?RGfrlaPxweMx3TkJgaHRrwyes8cCACGUcWJR2M/qXI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBE1C4A91C3C4746985D01AD70BC0F4C@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f50d7e3-6276-4458-9748-08dba53b5c54
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 07:17:37.3361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7mm15LgA7QSnZPqW0K1TNqDBcZllHskhICmP3wsW/1l+JZc134RcpUXvH4421HNW67xsw8zCBtn/hFAKtg5aLrfEX6TAmbJM2gnoU45HlfE=
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
cm90ZToKPiBzcGlkZXZfaW9jdGwoKSBjaGVja3MgaWYgdGhlcmUgaXMgYW4gU1BJIGNoaXAgc2Vs
ZWN0IGlzIGRyaXZlbiBieSBHUElPLgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIF5eXiA/Cgo+IEluc3RlYWQgb2YgY3VycmVudCBjb2RlLCB3ZSBj
YW4gY2FsbCBzcGlfZ2V0X2NzZ3Bpb2QoKS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBBbmR5IFNoZXZj
aGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4KClJldmlld2VkLWJ5OiBB
bGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbT4KCj4gLS0t
Cj4gwqBkcml2ZXJzL3NwaS9zcGlkZXYuYyB8IDYgKystLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3NwaS9zcGlkZXYuYyBiL2RyaXZlcnMvc3BpL3NwaWRldi5jCj4gaW5kZXggZGM1MTZmMGNhNzFm
Li5lMzI0YjQyYzY1OGMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9zcGkvc3BpZGV2LmMKPiArKysg
Yi9kcml2ZXJzL3NwaS9zcGlkZXYuYwo+IEBAIC0zOTMsOCArMzkzLDcgQEAgc3BpZGV2X2lvY3Rs
KHN0cnVjdCBmaWxlICpmaWxwLCB1bnNpZ25lZCBpbnQgY21kLCB1bnNpZ25lZCBsb25nIGFyZykK
PiDCoMKgwqDCoMKgwqDCoMKgY2FzZSBTUElfSU9DX1JEX01PREUzMjoKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHRtcCA9IHNwaS0+bW9kZTsKPiDCoAo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBpZiAoY3Rsci0+dXNlX2dwaW9fZGVzY3JpcHRvcnMgJiYgY3Rsci0+
Y3NfZ3Bpb2RzICYmCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjdGxy
LT5jc19ncGlvZHNbc3BpX2dldF9jaGlwc2VsZWN0KHNwaSwgMCldKQo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBpZiAoY3Rsci0+dXNlX2dwaW9fZGVzY3JpcHRvcnMgJiYgc3BpX2dl
dF9jc2dwaW9kKHNwaSwgMCkpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgdG1wICY9IH5TUElfQ1NfSElHSDsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgaWYgKGNtZCA9PSBTUElfSU9DX1JEX01PREUpCj4gQEAgLTQzMCw4ICs0
MjksNyBAQCBzcGlkZXZfaW9jdGwoc3RydWN0IGZpbGUgKmZpbHAsIHVuc2lnbmVkIGludCBjbWQs
IHVuc2lnbmVkIGxvbmcgYXJnKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBicmVhazsKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChjdGxyLT51c2VfZ3Bpb19kZXNjcmlwdG9y
cyAmJiBjdGxyLT5jc19ncGlvZHMgJiYKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjdGxyLT5jc19ncGlvZHNbc3BpX2dldF9jaGlwc2VsZWN0
KHNwaSwgMCldKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgaWYgKGN0bHItPnVzZV9ncGlvX2Rlc2NyaXB0b3JzICYmIHNwaV9nZXRfY3NncGlvZChzcGks
IDApKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqB0bXAgfD0gU1BJX0NTX0hJR0g7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0bXAgfD0gc3BpLT5tb2RlICYgflNQSV9N
T0RFX01BU0s7CgotLSAKQWxleGFuZGVyIFN2ZXJkbGluClNpZW1lbnMgQUcKd3d3LnNpZW1lbnMu
Y29tCg==

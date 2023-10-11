Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5927C598E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346937AbjJKQmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbjJKQmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:42:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0725EC9;
        Wed, 11 Oct 2023 09:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1697042517; x=1728578517;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CN4+Fah8+9PUQ/+dkedXMsvUDpuHHL297eUGys63ddc=;
  b=uhBErpKxRZV24yoQBWa/eHIa/GY/kDwBcDxl5lZVT5hd/9S50eJhN9R9
   IzIuOT4wTk/YDdqC+7JEVkOvQ/2afUrOfnEfFbnZRS4aweqFic+wBYDQe
   s+b8CxMoMbSGbmxMml3hzjYrQfzX9HtBUEjszt/5PJrx+OeK38QVxr4VK
   8ANKu9ZMYeaR9UtP/pwvHbEWbN0vs/jcSMwYvgextx45YFGsJjhknKIjy
   Ohq5ZOFtBgUN+UVPHpFtQqfRYuI0J3YkGZuKDu6Q7mAYbaw0sHQ/NuX0f
   L/OB9Ggw7ArqkFrEJ7aBuqvEflV684M9abZRUOLnxEZoiAL2X91F1xQ4S
   A==;
X-CSE-ConnectionGUID: bSv1RI0TRwuQPuiVr32OwQ==
X-CSE-MsgGUID: xuvucK0CRA6opaxPbSEFyA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="176974501"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Oct 2023 09:41:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 11 Oct 2023 09:41:43 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 11 Oct 2023 09:41:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXltUgpuBbvENY1Xm0I4jhetR24QJwBMvDBvxvnLEYYFj+VuWNXBZbK8wRNt/wHdC0z7dB7Lqkout3R1CE0Q5kBYKEms9Gp4W73FKmR9I3AwtZqZGWnEjY3F/+lB/JxBs2h0/iw5acdWPT8jNBIY3umpjFBMQX+wy8SqPBLcZyyWyJN63w3o5XSW556fbQXJgakedxwlOePYz1a5FFF3Dbv27q2MCmZ+Ly7wSLyyY8WJWr5whSS9ydbUQluVCwesegwJEx0qh2e0O0m/jx2+FhSeEy9AUxa6kdzEWCNsVHuqYXri6TXcoc60VFvOQWUeKMA2Ml9Ub1wsnJ9darQ/6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CN4+Fah8+9PUQ/+dkedXMsvUDpuHHL297eUGys63ddc=;
 b=PUYAxaILcpT2jf1FMbeIJDdAk92hZHM3ynTTaA70aN7gwIkioVcesNvcHxpfKCC4KYZ84tZDGAOar//wDG8YobmD2ZqPwKbbOuVKk3i4deNliWCRRhENYKyDKH9JduMj7z9zFw498a7hnynuHJ7R6TBqOkQgu1zPw12rCe5wFJJ4wkAkD9cy6Sr9rmU05VChYJTWT5QqNsrz1wEYu7Pa/W7A2Sc2QGkdnNSpY2mBiidE+d0uyyB2L4Lkg1RBb9lvSoif8gpUF4one/YIyotC46jbkt9XzFChrwJUABDlf0tWaGPHTPVvcpZ4ch33dChY0z+K7RQPBbydWRKM5WlGFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CN4+Fah8+9PUQ/+dkedXMsvUDpuHHL297eUGys63ddc=;
 b=HZRtOn7KTu9rniGC2EaaS40rz3s/+zCpoj2SPVYoJyI8x1XrHASQevQI+oOWngGwJaCPHJQSTxBhJ7cN/CiayKWxRVwkFLnDccryqWq9+Kc8Q7pV4AaopYmIUiqtpxeV1Laj0rDVX26OK8EVACgIEMA2dwIXOiq5WxvtsW+Rnj0=
Received: from IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14)
 by SJ0PR11MB6717.namprd11.prod.outlook.com (2603:10b6:a03:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 16:41:38 +0000
Received: from IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::5546:4fdb:1bb6:6e18]) by IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::5546:4fdb:1bb6:6e18%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 16:41:38 +0000
From:   <Marius.Cristea@microchip.com>
To:     <jic23@kernel.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] iio: adc: MCP3564: fix warn: unsigned '__x' is never
 less than zero.
Thread-Topic: [PATCH v1] iio: adc: MCP3564: fix warn: unsigned '__x' is never
 less than zero.
Thread-Index: AQHZ9UvUaXQDahrOQESwz+X5ChZ6f7BC0jQAgAIGzoA=
Date:   Wed, 11 Oct 2023 16:41:38 +0000
Message-ID: <bcc76066305e1c191ca02566132527b4c7520588.camel@microchip.com>
References: <20231002161618.36373-1-marius.cristea@microchip.com>
         <20231010104444.12e61984@jic23-huawei>
In-Reply-To: <20231010104444.12e61984@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6395:EE_|SJ0PR11MB6717:EE_
x-ms-office365-filtering-correlation-id: 34da40de-cec3-4009-3d78-08dbca78f094
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2/CCGV1nCUJkj5BrTaH2KQt/VveAoJYdcdifIMl5BMSMHuCzK9Bigg0AUTTssggQ6vRQbirNBZqtSzPElVbbZv4tcxyiRtRDTow5gyzcM12bUEEkk3/UTkketNY8+Djxzb2om9s7gKE0GNTH4Hu3e2O+vikKKTWPzH5hdyk5hqM/HzrPVoTQ8pyeIP7iBKhhX/ThY+W91tZNfrtLQ7gCi7f9FjO/eSsOQgkU32ibMAmbcXRBuBm3kihBV15neLorCxxjIFoRXUA+LDlXaQRqVoR/E8qyjx1LwRSGxqk67KJmDX1Kce4Lmcgz2Xm/tbG0NO77Fvk2gtneay+T4i5TZk9NilT0mL5DvIRb4oRnbcdLMiyV05/eM2QQGUS0DezIP/qFIVIEXGzHPGU0GiZAvXxxzxrQq6oLxTq+Ct/ypNY1wYC7s2JUDO2vgykdavVIp7knFr5VQh7SjtzyRcuqeX7loiTOxf5RQSwZSnPeTPKvATwFXdcQJUZdsrfGvm7mVhxcZG6/89NYbV/+AYTmbDZxZMGa4diV7/3K0NPY+1hX1DHJWOPpMjINV2oBjv8onRmBKS7LDHax6clIlx8DTlHDmYNWAC0/VBfGXJkBLw8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6395.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(366004)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2616005)(83380400001)(26005)(6512007)(316002)(6916009)(66556008)(66476007)(66446008)(5660300002)(64756008)(54906003)(8676002)(4326008)(71200400001)(38070700005)(122000001)(8936002)(38100700002)(2906002)(91956017)(4001150100001)(66946007)(76116006)(41300700001)(478600001)(36756003)(6506007)(966005)(6486002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGltU001K1N3aEtQU201d3QwaG41MmptcVliYVhnQjF3QkpQZkk2NU0wV0dp?=
 =?utf-8?B?K1JLTFdUdTFxMDNPWTNiWDBkOEEzWGdUWHQydFRvd2p3NkJEUkczWEx1dDc4?=
 =?utf-8?B?Zk1kSHI1bCtrZE4wQlhXTmQvT3FWVHp4TlQwVVUzaGtkQWVuWi9aZkJITzgy?=
 =?utf-8?B?NGl2TVZFR0UvcGI3MkZqN0VwcGYyb2pqN3d2UHAyc3Z2c0RkNDlodmJ6YjBQ?=
 =?utf-8?B?eno4Z2JHL0xZbXV4NnFzeEN3TmQvejR1VzBtQjAvY2FNNU8xQVU3Q2svS3Yr?=
 =?utf-8?B?TjhBeWxNUkFhbU8rVGRiSStSUDZ6ajhobm42VGYrZEh4MTk0RTczSHNITWlm?=
 =?utf-8?B?M0prRzhFeUZ2aWw3cTlZT0pZd2FZSTFpT2FzMzJ4OG1CWHNXdlpYbm9lZm54?=
 =?utf-8?B?OXZLZ25wY3k1d1dpcloxMWdkempvekx2ZjIrakFqYzl0dE1rZENQQ3BGQ0RB?=
 =?utf-8?B?WmFuQVpJdHJtSjNsUllXdjhPS1pxQ0xrQkl5MURodCtKejUraFRXVVFnOTFo?=
 =?utf-8?B?ck5HZVM2SUdWRGR6c3VjUDFoYUVhU2ZoN2xhM2MvMEdaL2p1QkFxU3c3ZGZt?=
 =?utf-8?B?L21MY2NZS1ZTd3JMR2RNQVF5MTlDR1NJZG90ZERCSlU0b09JcDVzYkYybXhj?=
 =?utf-8?B?V0VmeHRkM1F4bCtwYjBFRkx2ZXl3NlJ6SnZGQS96OThnY2QrUGV4d0lVRFhZ?=
 =?utf-8?B?NzM2MkF6UVRjWCtHVWtKT0VzU1RVK0p2UENCTnE0YzNZMGxSVkphVjBnZlZX?=
 =?utf-8?B?WjdkNkdHaVZ0NlB6QjdST2RrTTNlemF2b0pqYnhKbGgxYUU5K3lnTnN3Lytq?=
 =?utf-8?B?UEtSYVQ0alRwMGRKVGJWbkpubWNqb25LWDVHR2xaMkVLZW05OFpoVGhoY0V1?=
 =?utf-8?B?emR2MFZiSzN5UUlKampuc2tKN2wybnpzSmtmY0JmQTFPd3V0ZWt5KzRPUTcv?=
 =?utf-8?B?bml5eEpDZ0dXV2VVK04yK0NlbGZwSUdqcDlJRno1VjBwdjJmRTNaV1FISkNY?=
 =?utf-8?B?RWdPQmg1eUZsLzVndVJINlBscmpvdEl0SkN2cUxON3JvOEJWRXJqMml5bnZL?=
 =?utf-8?B?VENxQUNJZytpN3lOcUwrR0pvc0Nob1dTMVJCem5qUTEvVWgxVlV0aGlueDNV?=
 =?utf-8?B?clljVTZsUVdocEl5cFR4YXRGRjdIdWV4OXpXeDhKeVkzRFE2YmJPemhnUUpF?=
 =?utf-8?B?N2d0TktCcGRVSzVGbzRlSEtSTW1mYlBSQzE4THJFbEJ1bkI0bnN4MjFXdFBm?=
 =?utf-8?B?UG1pWlA1MEJmS3BBNGRwRmVENTFyc2FpY282MU90U0U2SXlqZjVDdzBMWEMv?=
 =?utf-8?B?ZTY0LzJDblA5UW5xeUVETGN0RVlGV3VIUUxwU1B2dzdkRlQ5Sk9tVnRSQ0xj?=
 =?utf-8?B?WjhQKzVNb3pHNitRVXBJS2dvbE1HQ0RJZGFidDZRbmI3Mk1CTXJ6bUlTbTh5?=
 =?utf-8?B?a1lHajJ5ZStIemJTb1NRcnVrbkcvVlhCb1hDTlhSNkR2SFZIYVRzM0pYV2Q5?=
 =?utf-8?B?Tjg0MUpNMW9IbzFSeUpwdEJueWhQU1o2K3N1b3ZTSkpqaS9Ec3VMaHZMMjRl?=
 =?utf-8?B?RVNzSnJNQndsVkQxeWxPeHFUSWREM0ZQNU9SWWxaUHpxaXRjalA2dFVvSWk0?=
 =?utf-8?B?R2Y2NXZjL3FVMzJRSGF1TnZDTDltbTRqS0ZDVjB3Q3gxQXhkS2FNTnJwWXdZ?=
 =?utf-8?B?Q0JRNnAyU0t4MklpUmRiV3UxWnlNZGpjQmkzd2trT0I2SmYvbCt0SFdzWmlM?=
 =?utf-8?B?NWZQeWxXTHEvSDNRN3h5THhHQjhYcERXdVVXUFpFRHh4YVNHRklxWUlsR0JL?=
 =?utf-8?B?QnR1UFljSlhSUS9KNDJjZHJ4NXpWNFFmMm1tSHVGeHRIWWM2ZU00YmplSk9k?=
 =?utf-8?B?VndtaTJOZGtpVDlNanNvaXk1dGhxYWkwTzNkcGphZWtIN2NnZkluL3IycS9X?=
 =?utf-8?B?aHI1Si94MlZ3dVQ2MHpORlFBRXVaSzNodzFUTEVQV2szQVV5cHFNZnp4N0JU?=
 =?utf-8?B?WGIvZ0NvNnlEc3dseXZkUGRGZlEyU2JpRlBvaXdOZmZ1N2wwS2dpdi9HbzJS?=
 =?utf-8?B?eTNPVHAvVTU3azBNYmErZ09rU2RlUS95YndGSFpMcEFlZmNXdUJrcWQzek5Y?=
 =?utf-8?B?VTVYM0tyZ0lQekFKK283Yk5XKzFYUmpOdk83VlIvT0pWWXJnUTR3MlhmNnN6?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90DB5D303F18B348A56C7F998D9C8421@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6395.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34da40de-cec3-4009-3d78-08dbca78f094
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 16:41:38.3748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oQNETKY6Oxa4GUjmdghXy5BNcLWIsfJaUxZektfExEb/ZBZ+fap6BR+cj6YpkBDTsOw1C87OAUa2JbeBzymkVXlEuKx7773y2zQyw62q+24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6717
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQogIEhpIEpvbmF0aGFuLA0KDQogU29ycnksIEkgdGhpbmsgSSd2ZSBtYWRlIGEgIm1pc3Rha2Ui
IHJlbGF0ZWQgdG8gbmFtaW5nIHRoZSBwYXRjaGVzIGFuZA0KYWxzbyBub3QgcnVubmluZyB0aGUg
U21hdGNoIGNoZWNrZXIgYXQgYSBwb2ludCBpbiB0aW1lLg0KDQoNCg0KT24gVHVlLCAyMDIzLTEw
LTEwIGF0IDEwOjQ0ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQ0K
PiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIE1vbiwgMiBPY3QgMjAyMyAxOTox
NjoxOCArMDMwMA0KPiA8bWFyaXVzLmNyaXN0ZWFAbWljcm9jaGlwLmNvbT4gd3JvdGU6DQo+IA0K
PiA+IEZyb206IE1hcml1cyBDcmlzdGVhIDxtYXJpdXMuY3Jpc3RlYUBtaWNyb2NoaXAuY29tPg0K
PiA+IA0KPiA+IFRoZSBwYXRjaCBlZmVhMTVlM2M2NWQ6ICJpaW86IGFkYzogTUNQMzU2NDogZml4
IHRoZSBzdGF0aWMgY2hlY2tlcg0KPiA+IHdhcm5pbmciDQo+ID4gbGVhZHMgdG8gdGhlIGZvbGxv
d2luZyBTbWF0Y2ggc3RhdGljIGNoZWNrZXIgd2FybmluZzoNCj4gPiANCj4gPiDCoMKgIHNtYXRj
aCB3YXJuaW5nczoNCj4gPiDCoMKgIGRyaXZlcnMvaWlvL2FkYy9tY3AzNTY0LmM6MTEwNSBtY3Az
NTY0X2ZpbGxfc2NhbGVfdGJscygpIHdhcm46DQo+ID4gdW5zaWduZWQgJ19feCcgaXMgbmV2ZXIg
bGVzcyB0aGFuIHplcm8uDQo+ID4gDQo+ID4gdmltICsvX194ICsxMTA1IGRyaXZlcnMvaWlvL2Fk
Yy9tY3AzNTY0LmMNCj4gPiANCj4gPiDCoMKgIDEwOTQNCj4gPiDCoMKgIDEwOTXCoCBzdGF0aWMg
dm9pZCBtY3AzNTY0X2ZpbGxfc2NhbGVfdGJscyhzdHJ1Y3QgbWNwMzU2NF9zdGF0ZQ0KPiA+ICph
ZGMpDQo+ID4gwqDCoCAxMDk2wqAgew0KPiA+IMKgwqAgLi4uLi4NCj4gPiDCoMKgIDExMDPCoMKg
wqDCoMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IE1DUDM1NjRfTUFYX1BHQTsgaSsrKSB7DQo+
ID4gwqDCoCAxMTA0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWYgPSBhZGMt
PnZyZWZfbXY7DQo+ID4gwqA+IDExMDXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHRtcDEgPSBzaGlmdF9yaWdodCgodTY0KXJlZiAqIE5BTk8sIHBvdyk7DQo+ID4gwqDCoCAxMTA2
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkaXZfdTY0X3JlbSh0bXAxLCBOQU5P
LCAmdG1wMCk7DQo+ID4gwqDCoCAxMTA3DQo+ID4gwqDCoCAuLi4uLg0KPiA+IMKgwqAgMTExM8Kg
IH0NCj4gPiANCj4gPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5j
b20+DQo+ID4gQ2xvc2VzOg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29lLWtidWlsZC1h
bGwvMjAyMzA5MjgwNzM4Lk5XalZmVnQ0LWxrcEBpbnRlbC5jb20vDQo+ID4gRml4ZXM6IGVmZWEx
NWUzYzY1ZCAoaWlvOiBhZGM6IE1DUDM1NjQ6IGZpeCB0aGUgc3RhdGljIGNoZWNrZXINCj4gPiB3
YXJuaW5nKQ0KPiANCj4gVGhpcyBmaXggaXMgZmluZSBidXQgY2FuIHlvdSB0YWxrIG1lIHRocm91
Z2ggaG93IHRoZSBzdGF0aWMgY2hlY2tlcg0KPiB3YXJuaW5nIGZpeA0KPiBpbiBxdWVzdGlvbiBo
YXMgYW55dGhpbmcgdG8gZG8gd2l0aCB0aGlzIG9uZT8NCj4gDQo+IFdhcyBpdCBqdXN0IGEgY2Fz
ZSBvZiBmaXhpbmcgdGhhdCBpc3N1ZSBhbGxvd2luZyB0aGUgc3RhdGljIGNoZWNrZXINCj4gdG8N
Cj4gZ2V0IGZ1cnRoZXIgYmVmb3JlIGdpdmluZyB1cD/CoCBJbiB3aGljaCBjYXNlIHRoZSBkZXNj
cmlwdGlvbiBuZWVkcw0KPiBtb2RpZnlpbmcuDQo+IA0KPiBPciBhbSBJIG1pc3Npbmcgc29tZXRo
aW5nIGluIHRoZSBmb2xsb3dpbmcgZml4Pw0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlv
L2FkYy9tY3AzNTY0LmMgYi9kcml2ZXJzL2lpby9hZGMvbWNwMzU2NC5jDQo+IGluZGV4IDY0MTQ1
ZjRhZTU1Yy4uOWVkZTFhNWQ1ZDdiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvbWNw
MzU2NC5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9tY3AzNTY0LmMNCj4gQEAgLTE0MjIsMTEg
KzE0MjIsOCBAQCBzdGF0aWMgaW50IG1jcDM1NjRfcHJvYmUoc3RydWN0IHNwaV9kZXZpY2UNCj4g
KnNwaSkNCj4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IG1jcDM1NjRfc3RhdGUgKmFkYzsNCj4gDQo+
IMKgwqDCoMKgwqDCoMKgIGluZGlvX2RldiA9IGRldm1faWlvX2RldmljZV9hbGxvYygmc3BpLT5k
ZXYsIHNpemVvZigqYWRjKSk7DQo+IC3CoMKgwqDCoMKgwqAgaWYgKCFpbmRpb19kZXYpIHsNCj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X2Vycl9wcm9iZSgmaW5kaW9fZGV2LT5k
ZXYsIFBUUl9FUlIoaW5kaW9fZGV2KSwNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJDYW4ndCBhbGxvY2F0ZSBpaW8gZGV2aWNlXG4i
KTsNCj4gK8KgwqDCoMKgwqDCoCBpZiAoIWluZGlvX2RldikNCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiAtRU5PTUVNOw0KPiAtwqDCoMKgwqDCoMKgIH0NCj4gDQo+IA0K
DQogIEkndmUgZ290IHR3byBidWdzIHJlcG9ydGVkOg0KDQotIFRoZSBmaXJzdCBvbmUgd2FzIHJl
cG9ydGVkIGJ5IERhbiBDYXJwZW50ZXIgIlJlOiBbYnVnIHJlcG9ydF0gaWlvOg0KYWRjOiBhZGRp
bmcgc3VwcG9ydCBmb3IgTUNQMzU2NCBBREMiLiBUaGlzIGJ1ZyB3YXMgZm91bmQgdXNpbmcgdGhl
DQoiU21hdGNoIHN0YXRpYyBjaGVja2VyIHdhcm5pbmciIGFuZCBpdCB3YXMgcmVsYXRlZCB0bzoN
Cj4gLS0+IDE0MjYgICAgICAgICAgICAgICAgIGRldl9lcnJfcHJvYmUoJmluZGlvX2Rldi0+ZGV2
LA0KUFRSX0VSUihpbmRpb19kZXYpLA0KDQpUaGlzIGJ1ZyB3YXMgZml4ZWQgYnkgdGhlIGFib3Zl
ICJbUEFUQ0ggdjFdIGlpbzogYWRjOiBNQ1AzNTY0OiBmaXggdGhlDQpzdGF0aWMgY2hlY2tlciB3
YXJuaW5nIiBhbmQgaXQgd2FzIGFwcGxpZWQgb24gIkFwcGxpZWQgdG8gdGhlIHRvZ3JlZw0KYnJh
bmNoIG9mIGlpby5naXQgYXMgdGhhdCdzIHdoZXJlIHRoaXMgZHJpdmVyIGlzIGF0IHRoZSBtb21l
bnQuIg0KDQpBbHNvIG15IG1pc3Rha2UgYXQgdGhpcyBwb2ludCB3YXMgdGhhdCBJIGRpZG4ndCBz
ZXR1cCBhbmQgcnVuIHRoZQ0KIlNtYXRjaCBzdGF0aWMgY2hlY2tlciB3YXJuaW5nIg0KDQoNCj4g
YXMgdGhhdCdzIGFsbCBJJ20gc2VlaW5nIGluIHRoYXQgY29tbWl0Lg0KPiANClllcywgdGhhdCBj
b21taXQgb25seSBoYW5kbGVkIHBhcnQgb2YgdGhlIGZpeC4NCg0KDQoNCj4gPiBTaWduZWQtb2Zm
LWJ5OiBNYXJpdXMgQ3Jpc3RlYSA8bWFyaXVzLmNyaXN0ZWFAbWljcm9jaGlwLmNvbT4NCj4gPiAt
LS0NCj4gPiDCoGRyaXZlcnMvaWlvL2FkYy9tY3AzNTY0LmMgfCAyICstDQo+ID4gwqAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9paW8vYWRjL21jcDM1NjQuYyBiL2RyaXZlcnMvaWlvL2FkYy9tY3AzNTY0
LmMNCj4gPiBpbmRleCA5ZWRlMWE1ZDVkN2IuLmUzZjFkZTVmY2M1YSAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2lpby9hZGMvbWNwMzU2NC5jDQo+ID4gKysrIGIvZHJpdmVycy9paW8vYWRjL21j
cDM1NjQuYw0KPiA+IEBAIC0xMTAyLDcgKzExMDIsNyBAQCBzdGF0aWMgdm9pZCBtY3AzNTY0X2Zp
bGxfc2NhbGVfdGJscyhzdHJ1Y3QNCj4gPiBtY3AzNTY0X3N0YXRlICphZGMpDQo+ID4gDQo+ID4g
wqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgTUNQMzU2NF9NQVhfUEdBOyBpKyspIHsNCj4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWYgPSBhZGMtPnZyZWZfbXY7DQo+ID4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB0bXAxID0gc2hpZnRfcmlnaHQoKHU2NClyZWYgKiBOQU5PLCBw
b3cpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdG1wMSA9ICgodTY0KXJlZiAqIE5B
Tk8pID4+IHBvdzsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkaXZfdTY0X3JlbSh0
bXAxLCBOQU5PLCAmdG1wMCk7DQo+ID4gDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dG1wMSA9IHRtcDEgKiBtY3AzNTY0X2h3Z2Fpbl9mcmFjWygyICogaSkgKyAxXTsNCj4gPiANCj4g
PiBiYXNlLWNvbW1pdDogNWU5OWY2OTJkNGUzMmUzMjUwYWIxOGQ1MTE4OTRjYTc5NzQwN2FlYw0K
PiANCg0KLSBUaGUgc2Vjb25kIGJ1ZyB3YXMgcmVwb3J0ZWQgYnkgImtlcm5lbCB0ZXN0IHJvYm90
IDxsa3BAaW50ZWwuY29tPiINCmFsc28gYnkgcnVubmluZyBTbWF0Y2ggYW5kIGl0IHdhcyBydW4g
b24gdGhlIGluaXRpYWwgZHJpdmVyICh3aXRob3V0DQpoYXZpbmcgdGhlIGZpcnN0IHBhdGNoIGFw
cGxpZWQpDQoNCnNtYXRjaCB3YXJuaW5nczoNCmRyaXZlcnMvaWlvL2FkYy9tY3AzNTY0LmM6MTEw
NSBtY3AzNTY0X2ZpbGxfc2NhbGVfdGJscygpIHdhcm46IHVuc2lnbmVkDQonX194JyBpcyBuZXZl
ciBsZXNzIHRoYW4gemVyby4NCmRyaXZlcnMvaWlvL2FkYy9tY3AzNTY0LmM6MTQyNiBtY3AzNTY0
X3Byb2JlKCkgd2FybjogcGFzc2luZyB6ZXJvIHRvDQonUFRSX0VSUicNCmRyaXZlcnMvaWlvL2Fk
Yy9tY3AzNTY0LmM6MTQyNiBtY3AzNTY0X3Byb2JlKCkgd2FybjogYWRkcmVzcyBvZiBOVUxMDQpw
b2ludGVyICdpbmRpb19kZXYnDQoNCg0KVGhlOiJkcml2ZXJzL2lpby9hZGMvbWNwMzU2NC5jOjE0
MjYgbWNwMzU2NF9wcm9iZSgpIHdhcm46IHBhc3NpbmcgemVybw0KdG8gJ1BUUl9FUlInIiBhbmQg
ImRyaXZlcnMvaWlvL2FkYy9tY3AzNTY0LmM6MTQyNiBtY3AzNTY0X3Byb2JlKCkgd2FybjoNCmFk
ZHJlc3Mgb2YgTlVMTCBwb2ludGVyICdpbmRpb19kZXYnIiB3ZXJlIGZpeGVkIGJ5IHRoZSBmaXJz
dCBwYXRjaC4NCg0KVGhlICJkcml2ZXJzL2lpby9hZGMvbWNwMzU2NC5jOjExMDUgbWNwMzU2NF9m
aWxsX3NjYWxlX3RibHMoKSB3YXJuOg0KdW5zaWduZWQgJ19feCcgaXMgbmV2ZXIgbGVzcyB0aGFu
IHplcm8uIiBpcyBmaXhlZCBieSB0aGUgbGFzdCBwYXRjaA0KIltQQVRDSCB2MV0gaWlvOiBhZGM6
IE1DUDM1NjQ6IGZpeCB3YXJuOiB1bnNpZ25lZCAnX194JyBpcyBuZXZlciBsZXNzDQp0aGFuIHpl
cm8uIg0KIGJ5IGNoYW5nZWluZzoNCg0KLQkJdG1wMSA9IHNoaWZ0X3JpZ2h0KCh1NjQpcmVmICog
TkFOTywgcG93KTsNCisJCXRtcDEgPSAoKHU2NClyZWYgKiBOQU5PKSA+PiBwb3c7DQoNCnNoaWZ0
X3JpZ2h0IGZ1bmN0aW9uIGlzICJSZXF1aXJlZCB0byBzYWZlbHkgc2hpZnQgbmVnYXRpdmUgdmFs
dWVzIiBidXQNCm15IHZhbHVlIGlzIGFsd2F5cyB1bnNpZ25lZCBzbyBpdCBkb2Vzbid0IG1ha2Ug
c2Vuc2UgdG8gdXNlZCBpdC4gVGhpcw0KZXJyb3Igd2FzIHJlcG9ydGVkIHdoZW4gSSBoYXZlIHJ1
biB0aGUgU21hdGNoIG92ZXIgdGhlIGRyaXZlciArIGZpcnN0DQpwYXRjaCAod2hhdCB3YXMgdGhl
IGxhdGVzdCBmcm9tIHRvZ3JlZykuDQoNCkkgaGF2ZSBhcHBsaWVkIHRoZSBwYXRjaCBvbiB0b3Ag
b2Ygd2hhdCB3YXMgdGhlICJsYXRlc3QiIGZyb20gdG9ncmVnDQpicmFuY2ggYW5kIG5vdCBvbiB0
aGUgaW5pdGlhbCBkcml2ZXIuDQoNCg0KSSBjb3VsZCBjaGFuZ2UgdGhlIGRlc2NyaXB0aW9uIG9y
IEkgY291bGQgcHJvdmlkZSBhIHBhdGNoIHRvIGhhbmRsZQ0KYm90aCB3YXJuaW5nIHJlcG9ydGlu
ZyBhdCBvbmNlLg0KDQpUaGFua3MsDQpNYXJpdXMNCg==

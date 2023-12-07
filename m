Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FCB80863D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378781AbjLGJxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378770AbjLGJxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:53:30 -0500
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EB2D4A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 01:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701942816; x=1733478816;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JuGa7uef6V322ojQeAcofrb8pxdJPf31P+TkQE7/ADM=;
  b=v/7Hw3AiAdIJgxAY7WR7CQ0Kz3ixJFkvPo2ESnVE8ZA4iVeFgiMjiBsf
   D73/4f5AS1tKO8PlKcQFc93igkTd37YakDXHLApTjD1KKVexPNL9zbhAv
   +eFRuHy1cETkYmCrsRnvwOAp+WxTV8Rv/tm7ntufX1Vbz67xt06eR9yDh
   U=;
X-IronPort-AV: E=Sophos;i="6.04,256,1695686400"; 
   d="scan'208";a="620331873"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 09:53:34 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
        by email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com (Postfix) with ESMTPS id BAA5C8095B;
        Thu,  7 Dec 2023 09:53:33 +0000 (UTC)
Received: from EX19MTAEUA001.ant.amazon.com [10.0.10.100:38219]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.22.106:2525] with esmtp (Farcaster)
 id f385c537-0438-4f00-8e3e-26d90182dda5; Thu, 7 Dec 2023 09:53:31 +0000 (UTC)
X-Farcaster-Flow-ID: f385c537-0438-4f00-8e3e-26d90182dda5
Received: from EX19D012EUC003.ant.amazon.com (10.252.51.208) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Dec 2023 09:53:31 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D012EUC003.ant.amazon.com (10.252.51.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Dec 2023 09:53:31 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.040; Thu, 7 Dec 2023 09:53:31 +0000
From:   "Gowans, James" <jgowans@amazon.com>
To:     "Graf (AWS), Alexander" <graf@amazon.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        =?utf-8?B?U2Now7ZuaGVyciwgSmFuIEgu?= <jschoenh@amazon.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] initramfs: Expose retained initrd as sysfs file
Thread-Topic: [PATCH v2] initramfs: Expose retained initrd as sysfs file
Thread-Index: AQHaKIvZ7N5F6qeIVke2cRQDMeyyCbCdlV8A
Date:   Thu, 7 Dec 2023 09:53:31 +0000
Message-ID: <2dfa868ddd416f20faf5144746bf14c7a8d75cf6.camel@amazon.com>
References: <20231206213323.78233-1-graf@amazon.com>
In-Reply-To: <20231206213323.78233-1-graf@amazon.com>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.146.13.108]
Content-Type: text/plain; charset="utf-8"
Content-ID: <16B14665ABD9444E8B0A8F838A4282C8@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTEyLTA2IGF0IDIxOjMzICswMDAwLCBBbGV4YW5kZXIgR3JhZiB3cm90ZToN
Cj4gLS0tIGEvaW5pdC9pbml0cmFtZnMuYw0KPiArKysgYi9pbml0L2luaXRyYW1mcy5jDQo+IEBA
IC01NzQsNiArNTc0LDE2IEBAIGV4dGVybiB1bnNpZ25lZCBsb25nIF9faW5pdHJhbWZzX3NpemU7
DQo+IMKgI2luY2x1ZGUgPGxpbnV4L2luaXRyZC5oPg0KPiDCoCNpbmNsdWRlIDxsaW51eC9rZXhl
Yy5oPg0KPiDCoA0KPiArc3RhdGljIHNzaXplX3QgcmF3X3JlYWQoc3RydWN0IGZpbGUgKmZpbGUs
IHN0cnVjdCBrb2JqZWN0ICprb2JqLA0KPiArCQkJc3RydWN0IGJpbl9hdHRyaWJ1dGUgKmF0dHIs
IGNoYXIgKmJ1ZiwNCj4gKwkJCWxvZmZfdCBwb3MsIHNpemVfdCBjb3VudCkNCj4gK3sNCj4gKwlt
ZW1jcHkoYnVmLCBhdHRyLT5wcml2YXRlICsgcG9zLCBjb3VudCk7DQo+ICsJcmV0dXJuIGNvdW50
Ow0KPiArfQ0KPiArDQo+ICtzdGF0aWMgQklOX0FUVFIoaW5pdHJkLCAwNDQwLCByYXdfcmVhZCwg
TlVMTCwgMCk7DQo+ICsNCj4gwqB2b2lkIF9faW5pdCByZXNlcnZlX2luaXRyZF9tZW0odm9pZCkN
Cj4gwqB7DQo+IMKgCXBoeXNfYWRkcl90IHN0YXJ0Ow0KPiBAQCAtNzE1LDggKzcyNSwxNCBAQCBz
dGF0aWMgdm9pZCBfX2luaXQgZG9fcG9wdWxhdGVfcm9vdGZzKHZvaWQgKnVudXNlZCwgYXN5bmNf
Y29va2llX3QgY29va2llKQ0KPiDCoAkgKiBJZiB0aGUgaW5pdHJkIHJlZ2lvbiBpcyBvdmVybGFw
cGVkIHdpdGggY3Jhc2hrZXJuZWwgcmVzZXJ2ZWQgcmVnaW9uLA0KPiDCoAkgKiBmcmVlIG9ubHkg
bWVtb3J5IHRoYXQgaXMgbm90IHBhcnQgb2YgY3Jhc2hrZXJuZWwgcmVnaW9uLg0KPiDCoAkgKi8N
Cj4gLQlpZiAoIWRvX3JldGFpbl9pbml0cmQgJiYgaW5pdHJkX3N0YXJ0ICYmICFrZXhlY19mcmVl
X2luaXRyZCgpKQ0KPiArCWlmICghZG9fcmV0YWluX2luaXRyZCAmJiBpbml0cmRfc3RhcnQgJiYg
IWtleGVjX2ZyZWVfaW5pdHJkKCkpIHsNCj4gwqAJCWZyZWVfaW5pdHJkX21lbShpbml0cmRfc3Rh
cnQsIGluaXRyZF9lbmQpOw0KPiArCX0gZWxzZSBpZiAoZG9fcmV0YWluX2luaXRyZCkgew0KPiAr
CQliaW5fYXR0cl9pbml0cmQuc2l6ZSA9IGluaXRyZF9lbmQgLSBpbml0cmRfc3RhcnQ7DQo+ICsJ
CWJpbl9hdHRyX2luaXRyZC5wcml2YXRlID0gKHZvaWQgKilpbml0cmRfc3RhcnQ7DQo+ICsJCWlm
IChzeXNmc19jcmVhdGVfYmluX2ZpbGUoZmlybXdhcmVfa29iaiwgJmJpbl9hdHRyX2luaXRyZCkp
DQo+ICsJCQlwcl9lcnIoIkZhaWxlZCB0byBjcmVhdGUgaW5pdHJkIHN5c2ZzIGZpbGUiKTsNCj4g
Kwl9DQo+IMKgCWluaXRyZF9zdGFydCA9IDA7DQo+IMKgCWluaXRyZF9lbmQgPSAwOw0KDQpXaGVu
IGFkZGluZyB0aGlzIHRvIG15IGRldiBlbnZpcm9ubWVudCBhbmQgZm9yZ290IHRvIGFjdHVhbGx5
IGdpdmUgUUVNVQ0KYW4gaW5pdHJhbWZzIGZpbGUsIGJ1dCBkaWQgYWRkIHRoZSByZXRhaW5faW5p
dHJkIGNtZGxpbmUgcGFyYW0uIFRoaXMNCmNhdXNlZCBhIHplcm8tc2l6ZWQgL3N5cy9maXJtd2Fy
ZS9pbml0cmQuIA0KV2hlbiB0cnlpbmcgdG8gcmVhZCB0aGF0IHplcm8gc2l6ZWQgZmlsZSBpdCBn
ZW5lcmF0ZXMgYSBOUEUgYmVjYXVzZQ0KYXR0ci0+cHJpdmF0ZSBpcyBOVUxMLg0KDQpEbyB5b3Ug
d2FudCB0byBkbyBzb21lIGJvdW5kcyBjaGVja2luZyBvciBwZXJoYXBzIG5vdCBleHBvc2UgdGhl
IGZpbGUgaWYNCnRoZXJlJ3Mgbm90IGFjdHVhbGx5IGFuIGluaXRyYW1mcz8NCg0KSSB3YXMgYWxz
byB3b25kZXJpbmcgaWYgd2UgbmVlZCB0byBkbyBib3VuZHMgY2hlY2tpbmcgb24gcG9zICsgY291
bnQgdG8NCnByZXZlbnQgcmVhZGluZyBvdXRzaWRlIHRoZSBpbml0cmQgZGF0YSBpbiBnZW5lcmFs
LCBidXQgaXQgc2VlbXMgbGlrZQ0KdGhlIGdlbmVyaWMgY29kZSBkb2VzIHRoYXQuDQoNCkpHDQoN
ClsgICAxNy45NDI2NDBdIEJVRzoga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSwgYWRk
cmVzczogMDAwMDAwMDAwMDAwMDAwMA0KWyAgIDE3Ljk0NDQ2NV0gI1BGOiBzdXBlcnZpc29yIHJl
YWQgYWNjZXNzIGluIGtlcm5lbCBtb2RlDQpbICAgMTcuOTQ1NzUzXSAjUEY6IGVycm9yX2NvZGUo
MHgwMDAwKSAtIG5vdC1wcmVzZW50IHBhZ2UNClsgICAxNy45NDY5MDFdIFBHRCAwIFA0RCAwIA0K
WyAgIDE3Ljk0NzM5N10gT29wczogMDAwMCBbIzFdIFBSRUVNUFQgU01QIE5PUFRJDQpbICAgMTcu
OTQ4Mzg0XSBDUFU6IDAgUElEOiAzMjUgQ29tbTogY2F0IE5vdCB0YWludGVkIDYuNC4wLXJjNy0w
MDIzMi1nNjI5MDI2NGFlMjQ3LWRpcnR5ICM0MTUNClsgICAxNy45NDg2NzZdIEhhcmR3YXJlIG5h
bWU6IFFFTVUgU3RhbmRhcmQgUEMgKFEzNSArIElDSDksIDIwMDkpLCBCSU9TIDEuMTUuMC0xIDA0
LzAxLzIwMTQNClsgICAxNy45NDg5ODhdIFJJUDogMDAxMDptZW1jcHlfb3JpZysweDFlLzB4MTQw
DQpbICAgMTcuOTQ5MTQyXSBDb2RlOiA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5
MCA2NiAwZiAxZiAwMCA0OCA4OSBmOCA0OCA4MyBmYSAyMCAwZiA4MiA4NiAwMCAwMCAwMCA0MCAz
OCBmZSA3YyAzNSA0OCA4MyBlYSAyMCA0OCA4MyBlYSAyMCA8NGM+IDhiIDA2IDRjIDhiIDRlIDA4
IDRjIDhiIDU2Nw0KWyAgIDE3Ljk0OTkxNF0gUlNQOiAwMDE4OmZmZmZjOTAwMDAzNDdlMTggRUZM
QUdTOiAwMDAxMDIwNg0KWyAgIDE3Ljk1MDEwM10gUkFYOiBmZmZmODg4MTA0ZmMwMDAwIFJCWDog
ZmZmZjg4ODEwMTk5MWYwMCBSQ1g6IGZmZmY4ODgxMDRmYzAwMDANClsgICAxNy45NTAzODFdIFJE
WDogMDAwMDAwMDAwMDAwMGZjMCBSU0k6IDAwMDAwMDAwMDAwMDAwMDAgUkRJOiBmZmZmODg4MTA0
ZmMwMDAwDQpbICAgMTcuOTUwNjgwXSBSQlA6IGZmZmZjOTAwMDAzNDdlOTggUjA4OiAwMDAwMDAw
MDAwMDAwMDAwIFIwOTogMDAwMDAwMDAwMDAwMTAwMA0KWyAgIDE3Ljk1MDk2M10gUjEwOiBmZmZm
ODg4MTAzNDQ4OTAwIFIxMTogZmZmZjg4ODEwMDE0MDA0MCBSMTI6IDAwMDAwMDAwMDAwMDEwMDAN
ClsgICAxNy45NTEyMjNdIFIxMzogZmZmZmM5MDAwMDM0N2U3MCBSMTQ6IDAwMDAwMDAwMDAwMDEw
MDAgUjE1OiBmZmZmODg4MTAxOTkxZjIwDQpbICAgMTcuOTUxNTUyXSBGUzogIDAwMDA3ZjRjZTE4
ZDc1ODAoMDAwMCkgR1M6ZmZmZjg4ODEzZGMwMDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAw
MDAwDQpbICAgMTcuOTUyMDIxXSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAw
MDAwMDgwMDUwMDMzDQpbICAgMTcuOTUyMzQ1XSBDUjI6IDAwMDAwMDAwMDAwMDAwMDAgQ1IzOiAw
MDAwMDAwMTAzNjhjMDAxIENSNDogMDAwMDAwMDAwMDc3MGVmMA0KWyAgIDE3Ljk1MjgzM10gUEtS
VTogNTU1NTU1NTQNClsgICAxNy45NTMwODZdIENhbGwgVHJhY2U6DQpbICAgMTcuOTUzMjM0XSAg
PFRBU0s+DQpbICAgMTcuOTUzMzQ1XSAgPyBfX2RpZSsweDFmLzB4NzANClsgICAxNy45NTM1MThd
ICA/IHBhZ2VfZmF1bHRfb29wcysweDE1Ni8weDQyMA0KWyAgIDE3Ljk1MzY5M10gID8gZXhjX3Bh
Z2VfZmF1bHQrMHg2OS8weDE1MA0KWyAgIDE3Ljk1Mzg3Nl0gID8gYXNtX2V4Y19wYWdlX2ZhdWx0
KzB4MjYvMHgzMA0KWyAgIDE3Ljk1NDA1OV0gID8gbWVtY3B5X29yaWcrMHgxZS8weDE0MA0KWyAg
IDE3Ljk1NDIyMF0gIHJhd19yZWFkKzB4MWIvMHgzMA0KWyAgIDE3Ljk1NDQzOF0gIGtlcm5mc19m
b3BfcmVhZF9pdGVyKzB4YTIvMHgxYTANClsgICAxNy45NTQ2OTZdICB2ZnNfcmVhZCsweDFiNC8w
eDJkMA0KWyAgIDE3Ljk1NDg0NF0gIGtzeXNfcmVhZCsweDVlLzB4ZTANClsgICAxNy45NTQ5ODVd
ICBkb19zeXNjYWxsXzY0KzB4M2MvMHg5MA0KWyAgIDE3Ljk1NTE1OF0gIGVudHJ5X1NZU0NBTExf
NjRfYWZ0ZXJfaHdmcmFtZSsweDcyLzB4ZGMNClsgICAxNy45NTUzODBdIFJJUDogMDAzMzoweDdm
NGNlMTdmMWZkMg0KDQo=

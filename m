Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D115475BA87
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 00:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjGTWWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 18:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjGTWWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 18:22:43 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C7630C8;
        Thu, 20 Jul 2023 15:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1689891733; x=1721427733;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=hfdQGIsHPiSQmCXDTfRO/5MVXiYRyT+9p4R1RbR27kw=;
  b=VH99/a6yH6SV6pLeQv0VGS9p4Q7VPb79tHVtXVcXiND7SKVd3Qciva99
   kdzEWq1xj2vvCSPziwVQgoRIP9RpVUqj6HjFdlEeOWP5DA2pCtO7RpYB8
   fm6TlJNxplXlxOsjtT3tw8+Pr5koRkzOYsgFLkIJCK6HCAjjsbXVWcAcF
   s=;
X-IronPort-AV: E=Sophos;i="6.01,219,1684800000"; 
   d="scan'208";a="228078880"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 22:21:05 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com (Postfix) with ESMTPS id A05DCA0BED;
        Thu, 20 Jul 2023 22:21:04 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 22:21:04 +0000
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Thu, 20 Jul 2023 22:21:03 +0000
Received: from EX19D004ANA001.ant.amazon.com ([fe80::f099:cbca:cc6b:91ec]) by
 EX19D004ANA001.ant.amazon.com ([fe80::f099:cbca:cc6b:91ec%5]) with mapi id
 15.02.1118.030; Thu, 20 Jul 2023 22:21:02 +0000
From:   "Iwashima, Kuniyuki" <kuniyu@amazon.co.jp>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jakub Kicinski <kuba@kernel.org>
CC:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Networking <netdev@vger.kernel.org>,
        "Alexander Mikhalitsyn" <alexander@mihalicyn.com>,
        "Iwashima, Kuniyuki" <kuniyu@amazon.co.jp>,
        "Iwashima, Kuniyuki" <kuniyu@amazon.co.jp>
Subject: Re: linux-next: build failure after merge of the bluetooth tree
Thread-Topic: linux-next: build failure after merge of the bluetooth tree
Thread-Index: AQHZu1h3eGn2lfLtVEiF5x1iaOX/zA==
Date:   Thu, 20 Jul 2023 22:21:02 +0000
Message-ID: <D8591926-7C73-4D2A-A4C9-6706432171A3@amazon.co.jp>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.106.101.12]
Content-Type: text/plain; charset="utf-8"
Content-ID: <628F1A2A1220534B8BA73F7078945E27@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU3RlcGhlbiBSb3Rod2VsbCA8c2ZyQGNhbmIuYXV1Zy5vcmcuYXU+DQpEYXRlOiBGcmks
IDIxIEp1bCAyMDIzIDA4OjEyOjU4ICsxMDAwDQo+IEhpIEpha3ViLA0KPiANCj4gT24gVGh1LCAy
MCBKdWwgMjAyMyAwODoxNDozMCAtMDcwMCBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3Jn
PiB3cm90ZToNCj4gPg0KPiA+IE9uIFdlZCwgMTkgSnVsIDIwMjMgMjA6MjQ6MzUgLTA3MDAgSmFr
dWIgS2ljaW5za2kgd3JvdGU6DQo+ID4gPiBPbiBUaHUsIDIwIEp1bCAyMDIzIDAzOjE3OjM3ICsw
MDAwIFZvbiBEZW50eiwgTHVpeiB3cm90ZTogIA0KPiA+ID4gPiBTb3JyeSBmb3Igbm90IHJlcGx5
aW5nIGlubGluZSwgb3V0bG9vayBvbiBhbmRyb2lkLCB3ZSB1c2Ugc2NtX3JlY3YNCj4gPiA+ID4g
bm90IHNjbV9yZWN2X3VuaXgsIHNvIElkIGFzc3VtZSB0aGF0IGNoYW5nZSB3b3VsZCByZXR1cm4g
dGhlIGluaXRpYWwNCj4gPiA+ID4gYmVoYXZpb3IsIGlmIGl0IGRpZCBub3QgdGhlbiBpdCBpcyBu
b3QgZml4aW5nIGFueXRoaW5nLiAgICANCj4gPiA+DQo+ID4gPiBBY2ssIHRoYXQncyB3aGF0IGl0
IHNlZW1zIGxpa2UgdG8gbWUgYXMgd2VsbC4NCj4gPiA+DQo+ID4gPiBJIGZpcmVkIHVwIGFuIGFs
bG1vZGNvbmZpZyBidWlsZCBvZiBsaW51eC1uZXh0LiBJIHNob3VsZCBiZSBhYmxlDQo+ID4gPiB0
byBnZXQgdG8gdGhlIGJvdHRvbSBvZiB0aGlzIGluIH4yMG1pbiA6KSAgDQo+ID4NCj4gPiBJIGtp
Y2tlZCBpdCBvZmYgYW5kIGZvcmdvdCBhYm91dCBpdC4NCj4gPiBhbGxtb2Rjb25maWcgb24gMzUy
Y2UzOWE4YmJhZWMwNCAobmV4dC0yMDIzMDcxOSkgYnVpbGRzIGp1c3QgZmluZSA6Uw0KPiANCj4g
T2YgY291cnNlIGl0IGRvZXMsIGFzIGNvbW1pdA0KPiANCj4gODE3ZWZkM2NhZDc0ICgiQmx1ZXRv
b3RoOiBoY2lfc29jazogRm9yd2FyZCBjcmVkZW50aWFscyB0byBtb25pdG9yIikNCj4gDQo+IGlz
IHJldmVydGVkIGluIGxpbnV4LW5leHQuICBUaGUgcXVlc3Rpb24gaXMgIkRvZXMgdGhlIGJsdWV0
b290aCB0cmVlDQo+IGJ1aWxkPyIgb3IgIkRvZXMgdGhlIG5ldC1uZXh0IHRyZWUgYnVpbGQgKmlm
KiB5b3UgbWVyZ2UgdGhlIGJsdWV0b290aA0KPiB0cmVlIGludG8gaXQ/Ig0KDQpGV0lXLCBJIHdh
cyBhYmxlIHRvIGJ1aWx0IG5ldC1uZXh0IHdpdGggdGhlIGNvbW1pdCB5ZXN0ZXJkYXkuDQoNCi0t
LTg8LS0tDQokIGdyZXAgQ09ORklHX0JUIC5jb25maWcNCkNPTkZJR19CVD1tDQpDT05GSUdfQlRf
QlJFRFI9eQ0KQ09ORklHX0JUX1JGQ09NTT1tDQpDT05GSUdfQlRfUkZDT01NX1RUWT15DQpDT05G
SUdfQlRfQk5FUD1tDQpDT05GSUdfQlRfQk5FUF9NQ19GSUxURVI9eQ0KQ09ORklHX0JUX0JORVBf
UFJPVE9fRklMVEVSPXkNCkNPTkZJR19CVF9ISURQPW0NCkNPTkZJR19CVF9IUz15DQpDT05GSUdf
QlRfTEU9eQ0KQ09ORklHX0JUX0xFX0wyQ0FQX0VDUkVEPXkNCkNPTkZJR19CVF9MRURTPXkNCkNP
TkZJR19CVF9NU0ZURVhUPXkNCkNPTkZJR19CVF9BT1NQRVhUPXkNCkNPTkZJR19CVF9ERUJVR0ZT
PXkNCkNPTkZJR19CVF9TRUxGVEVTVD15DQpDT05GSUdfQlRfU0VMRlRFU1RfRUNESD15DQpDT05G
SUdfQlRfU0VMRlRFU1RfU01QPXkNCkNPTkZJR19CVF9GRUFUVVJFX0RFQlVHPXkNCkNPTkZJR19C
VF9JTlRFTD1tDQpDT05GSUdfQlRfQkNNPW0NCkNPTkZJR19CVF9SVEw9bQ0KQ09ORklHX0JUX01U
Sz1tDQpDT05GSUdfQlRfSENJQlRVU0I9bQ0KQ09ORklHX0JUX0hDSUJUVVNCX0FVVE9TVVNQRU5E
PXkNCkNPTkZJR19CVF9IQ0lCVFVTQl9QT0xMX1NZTkM9eQ0KQ09ORklHX0JUX0hDSUJUVVNCX0JD
TT15DQpDT05GSUdfQlRfSENJQlRVU0JfTVRLPXkNCkNPTkZJR19CVF9IQ0lCVFVTQl9SVEw9eQ0K
Q09ORklHX0JUX0hDSVVBUlQ9bQ0KQ09ORklHX0JUX0hDSVVBUlRfSDQ9eQ0KQ09ORklHX0JUX0hD
SVVBUlRfQkNTUD15DQpDT05GSUdfQlRfSENJVUFSVF9BVEgzSz15DQpDT05GSUdfQlRfSENJVUFS
VF9BRzZYWD15DQpDT05GSUdfQlRfSENJQkNNMjAzWD1tDQpDT05GSUdfQlRfSENJQkNNNDM3Nz1t
DQpDT05GSUdfQlRfSENJQlBBMTBYPW0NCkNPTkZJR19CVF9IQ0lCRlVTQj1tDQpDT05GSUdfQlRf
SENJRFRMMT1tDQpDT05GSUdfQlRfSENJQlQzQz1tDQpDT05GSUdfQlRfSENJQkxVRUNBUkQ9bQ0K
Q09ORklHX0JUX0hDSVZIQ0k9bQ0KQ09ORklHX0JUX01SVkw9bQ0KQ09ORklHX0JUX0FUSDNLPW0N
CkNPTkZJR19CVF9WSVJUSU89bQ0KLS0tODwtLS0NCg0K

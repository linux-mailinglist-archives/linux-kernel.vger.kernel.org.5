Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260E278940E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 08:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjHZGct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 02:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjHZGcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 02:32:39 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2073.outbound.protection.outlook.com [40.107.12.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC76B0;
        Fri, 25 Aug 2023 23:32:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJYQkv50D+84u0HrRW7miA8R1d6xh3z5GqCMscog4nKDoWw/VU9yqoBZTif6/pP0wBzk5SYgOSaNfNu3AqV5cnQuCm3zIRldRkxcc4Bd9+102RqxjxHOFSn7XS8SV6PtH6a7040pteGHOV/gbIIVw7OhSxQ4uoPkiaoONoJV/JoKhZOGVdSxU3tEDrJunWOLVqfywj6ZvrniZjk9O7GBLDFxNahs6XSMBVggjo/VFmccyoEoOpHPJNTKJK5sH8rg1qQL+N8EcA2CEYjWGDNSzEHomk+5VA0DqO3dxVMp/uD8+EZjczi92SadQiSv1jqHH4UEcNMCBNe7i9JJkY0NZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEDU6kWQdjzbA9kuNVXdVKb2u6PFPbC6EDdXbNQEzHs=;
 b=SIA2fKNCtMEh+fEV/KkXbUaaMInLMAubrzxzsuSUiGxotABUIrnWRM2PSrSEeXBzyYbqAgnDMygPR94paeNyGJX64GcDkdIX1Vje88zSsQb0yQn3bwLYX2mZDKHOtXDsItQpui45iOS1GujTTEfUgE845ApexyWNM0ZTxv7BHwin3Cbpkt9vw+0l+i/KUUWPabBzLDie8ga1zK6E0qyNPrRyaixzuW8AP+ut0ycpzEBlmG1Nnq8pjETziwxkOPXyIlH/DRgAwXPiY/pCWsWkO1zblVah0T9g8B//nQUDAscsv94Ue2JBrT5M8bNQX0qUTW2Nwp+YVCfQps6LbV93Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEDU6kWQdjzbA9kuNVXdVKb2u6PFPbC6EDdXbNQEzHs=;
 b=AdOSfIk4GGUIVK5Y8/0Bs+MQ9i+LJ35K1bVrz5jE1SYhDCKqEwK+5zoOVsnmSrMpkgN75TLUXsGu8RUkyKTdAKb2Lqy1WzasfuP6xzaMpvj/m2ZyHBBc68iEjJnFSD+92pMaQkEU5HuU7xnyTDZxoWmgSPftKH9LHsx3kUVWxILKjiFWp6QB9g1HlFoY9pZSfnN2P+XM6U1v4XZLuA/2C+7ghrjTRD64mmX1duuC2UF41QvUP0MzUyq+PlB8WHjGwYTSA5rlYOmsQm7YOBrHSdhKvd8tXLAgkD/3yLaYian3CRGRSnq6WFL9fgW6MpokdrzPM2nydt+fjw5xOUDVcw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2902.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sat, 26 Aug
 2023 06:32:32 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e%7]) with mapi id 15.20.6699.034; Sat, 26 Aug 2023
 06:32:32 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Alexandra Diupina <adiupina@astralinux.ru>,
        Zhao Qiang <qiang.zhao@nxp.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH] fsl_ucc_hdlc: add a check of the return value from
 hdlc_open
Thread-Topic: [PATCH] fsl_ucc_hdlc: add a check of the return value from
 hdlc_open
Thread-Index: AQHZ19EYTx7UPAltIEutluod5GEH86/8HooA
Date:   Sat, 26 Aug 2023 06:32:32 +0000
Message-ID: <bd4a41b6-339e-67aa-a725-9d833efa6c79@csgroup.eu>
References: <20230825143112.16184-1-adiupina@astralinux.ru>
In-Reply-To: <20230825143112.16184-1-adiupina@astralinux.ru>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB2902:EE_
x-ms-office365-filtering-correlation-id: 00f895eb-6c06-4b7a-f546-08dba5fe3a80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xjGgrMGmu1bScl1e/D9HeuDwSxe38p2x3SWgrrQZdOYG6iR6VEZ70nbvT5yCe4OnIMxcfpxKuBEfaRYzJ8AAkhXl7DnBW0s3tFIxxQCcJpeF71eq9muVyDKSflvTHyhIhAZacU5QSMhBF4vsStx631dh45ZZhcQHAxq65BSj8Deo56eRKAEIVnKLh+30xrNzAJIhzFRa5TzomwPz3CRfQ/g05ubsH1fcCYqifFx98l7cDlM4rfNtvyAQNKlA+BkU84cDHUBsjIlB2mrnVyHCMICBrhxl2OXZwA2S47YD37xZMTwsMLNAntMBTXNlg7RXktmkD7uMIntjUjD4AGeMHGpPxdYEjPkkkdyUS1/oTwOP2uE30G39Eca87Akeb5HpNA7IupiHlEmVkZ2VC9VEjdmHeSw+a6O9mM6zRX/LkiiS0Ykzg0LUl9awmrH2wzLFr/NoP+6RyvoNIdJD3Gyf+/yGaM6PXGPKKpLi7ZRl02AjeF+zQl4KBqQ+rXVim0aPYoGhU/1OWd6/pjA+eMItPLJG7Dy5QYwX/AXJSmBNnnvFzCWFaCvYnweknmK8ecW+ftrATL3o6jMRjqaKUFFLyMb/0+fVkrDPNFvuhLEDZXxmDoaTgte+r4lNT8/4BFeFwsxsqLo6o4sMk/pb995wGPLq7JaDGwgCU93aJ1ikuPj4b+7NPQ6QJF5u6c1fsU1J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(346002)(376002)(136003)(396003)(366004)(1800799009)(451199024)(186009)(31686004)(6506007)(6486002)(71200400001)(86362001)(36756003)(31696002)(38100700002)(38070700005)(122000001)(66574015)(2616005)(2906002)(83380400001)(478600001)(966005)(76116006)(91956017)(110136005)(66476007)(66946007)(8676002)(64756008)(8936002)(44832011)(5660300002)(4326008)(7416002)(66446008)(41300700001)(6512007)(316002)(54906003)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVhUQmhJRitZdHd1ZXpnS2c0MnJyOFNMUkYzRjU1NkxFcE9ubEI0S2g4Qk1C?=
 =?utf-8?B?V2szSlMxaTdoc2Uxb0t2RHJnY3c5Qng5WW5kL0VXamFZR3hkcVlwYkJsa0xS?=
 =?utf-8?B?WDUxdWNoaXB4QmpyVmdGUldaT0lWaXR2dW9RUzJvNjdtUVFtWlFVUlJWaDE3?=
 =?utf-8?B?aVVMU3RnYmhYZW1uZXYwOEdVSGhsZ05KOGZKbURjR1lDVFdBNGlxbFdYS0lR?=
 =?utf-8?B?VUpQcHZCVVVtYTQ5Z1prQmgrdWxnY2xBL0czSUlFbjNoSjJuTk9VeDhZRTdP?=
 =?utf-8?B?cm5Ob0pLTmI4bGl4Qk5Xdjl3aE5ORkIxOGx4aWJ2bVhRL1ZuQWdLa1NmWHVx?=
 =?utf-8?B?UGZvakxHNzdNUTNWVGFhU0laRHNVMXNVZ3dUdWE2c2UvSGh0d2UwOEZ3Q1k1?=
 =?utf-8?B?VFpjWHIyYVBDTklYbmpOZWQyZVIzZjFxbk9BTHprVll1bHlCUU5LQVgrM3Br?=
 =?utf-8?B?VkFvcDJ3dm5ORlk4U00wTlNyRDlXREwwbHJyNGNwQlZYc1c5OE12Qis3am96?=
 =?utf-8?B?WUpZalNXZGpQMzlGWTFwNUFNaDY3V3F3OWFZRXhOK3RpQUl2QjMwRU8xd0Fh?=
 =?utf-8?B?a3JkcjQvQm53NjVOb0YzSlM3MVhWcyswV01tTmN1WWc5SnJFOHh4eWVRUzJv?=
 =?utf-8?B?VURIdFdlVVJNSjNpbUM3ZkphcmtLTU1ZdDFhT1h3QitSS3BETjlVM1ptSitW?=
 =?utf-8?B?SnU5QzgyNG1JNFYralFZNmlPZmhMeHUxVkNnNnl5T1FxZ2NMN3h6QURiWFRI?=
 =?utf-8?B?bi9CM1JPR3ZWU1JQSHducm5uc0ExeVFlNm95ZW44UXJBb29TVzlkbzJRUmdR?=
 =?utf-8?B?TXFVQ1Q3em41dlFXT3FaanZZL1VqL2hkcER6N01OaGpWdU8xNGJhVm9zbDh5?=
 =?utf-8?B?T1o1elI0ZUd0QW5LajdiTjE4YTN1VHNVUHVTL3BXMlFnWXlNSXhHdHlzSG1F?=
 =?utf-8?B?Q3VOYnZuZXQrRWlZaDhiK3ZQWXF5aU03RWR5cktLWGJ5cmRlcWtBUW01ait3?=
 =?utf-8?B?SWdPMXJhRWVGeFI5Z0dXTWtHNGZ3Q2czZ3pjTVNBY2FMVHMyMGk0dDhxYWtp?=
 =?utf-8?B?SGVtY0pMNlkzS0IwWHBDNHRnWFJsUVk2azg0WmlpUlBOZGZnU2Rsd0NJNUVh?=
 =?utf-8?B?NmRXeXM4eUIzay93bDE5RXE1NzErYlNzUVJIZXlqQWRRTlRWaDd1bGhGYzc5?=
 =?utf-8?B?c2FSVThXelNBalRxdWU4QXJ1UXJkMTdiR0c1ZkxYNUNzQWR4ZExXYXZWdDlD?=
 =?utf-8?B?d3VqVzJGeHJETGhmMVQ4SUQ3QTRkZ2dlbGNDY0tQVTVzSVdhY1JPaHg5S0JT?=
 =?utf-8?B?T0g2VFNSRzdRMFp0TDh5NE1jUnFXOXdMdThvSnB3Z2ZsQi9Ndlo5a3JsNHQw?=
 =?utf-8?B?alRFbGVwVTU5eUlNS3hqRFI2QW8yYVo3ZURJbHBTZ1NsWU54cVh4eFBXVU9X?=
 =?utf-8?B?bVNzVm9pWW4xQjg5aFp3KzFvb1hxekN1anV0b2s5bTRNTDFULzlFTm5ZSHZq?=
 =?utf-8?B?OHo4VG9CTWhrelJ1QlE0VFNNc1Blb2EzMDlFNnZoWFE1QW1xNFR0RXlxNzV1?=
 =?utf-8?B?VElwOU0zY1hwcURWRVlkMFNGaG1VVWc4UUpabjB3dEVkTGl0ZE83dTk2bXo1?=
 =?utf-8?B?ZUI4YklYcjlyRi96ZHRBT3l1WXVzaXlRaXZURjl6V2tsL090MnNTaVZYZkxm?=
 =?utf-8?B?SjJ5aWh3WkR0eWRKRVlsajV0MVVBOHY3WXpMaVZ6UlliN2NVNDdCbGp0VG9p?=
 =?utf-8?B?ZU0xU1RzVkxlVHVjYjBKSHYveG5OQk15ZjF6cGhVQldEejdhbGRiQklMbHZ1?=
 =?utf-8?B?eWVGR09IRkUrbTV1bWtLL3JTeFkxYjhWOUVRWkoyeERodVZ4MDlWUEkvSzhk?=
 =?utf-8?B?UVM2bGRacXN2Q1NVcGk5NVh2cEVmQ2kwQWNYbHZ6WVFwTHpERFB2dDA0YWRC?=
 =?utf-8?B?T2JuWDAzS1ZZa3RvWHpub0gyTFBnc1BsRE52UlMzbWViNjF6SG83UDVLZlpm?=
 =?utf-8?B?K0h6RCtTQklFNjRqSEx1QXBvRDJLQ0tuNmVjRlQ2azlzb2Z6QVNLVDhDZlFQ?=
 =?utf-8?B?ZGRtcVlIdU1aUFA4WFVsR0lzcnNVYjduQzNqbE5OZ0kzNDYrK1V4dldCYjFy?=
 =?utf-8?B?dFd6ZmE0dEtDS0ltY3VtSTNBZWVna0swby9rVGlRUm15NlZINWdxcityT09D?=
 =?utf-8?B?a25pUXpJUms0bGdmS2prTnRJUUYzTkJKbHRpcG52Mk9OandyT3ZPVENza295?=
 =?utf-8?B?ckxiVjJpUFRDRWNoaC9lWDYwRm53PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9C47A39815E32478AD4D53A198E9F0B@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f895eb-6c06-4b7a-f546-08dba5fe3a80
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2023 06:32:32.4548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PZq3tUU9WDpyw8sjH+NdcVXluYGpBWi+GLQYolZc5vjnOhd3hc6mb59Ecc8lcehbMge7Hk32CcCB3Shl2FbvGgStdzmkdAsTrNwC7unCamE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2902
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDI1LzA4LzIwMjMgw6AgMTY6MzEsIEFsZXhhbmRyYSBEaXVwaW5hIGEgw6ljcml0wqA6
DQo+IFtWb3VzIG5lIHJlY2V2ZXogcGFzIHNvdXZlbnQgZGUgY291cnJpZXJzIGRlIGFkaXVwaW5h
QGFzdHJhbGludXgucnUuIETDqWNvdXZyZXogcG91cnF1b2kgY2VjaSBlc3QgaW1wb3J0YW50IMOg
IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+IA0KPiBQ
cm9jZXNzIHRoZSByZXN1bHQgb2YgaG9sZF9vcGVuKCkgYW5kIHJldHVybiBpdCBmcm9tDQo+IHVo
ZGxjX29wZW4oKSBpbiBjYXNlIG9mIGFuIGVycm9yDQo+IEl0IGlzIG5lY2Vzc2FyeSB0byBwYXNz
IHRoZSBlcnJvciBjb2RlIHVwIHRoZSBjb250cm9sIGZsb3csDQo+IHNpbWlsYXIgdG8gYSBwb3Nz
aWJsZSBlcnJvciBpbiByZXF1ZXN0X2lycSgpDQo+IA0KPiBGb3VuZCBieSBMaW51eCBWZXJpZmlj
YXRpb24gQ2VudGVyIChsaW51eHRlc3Rpbmcub3JnKSB3aXRoIFNWQUNFLg0KPiANCj4gRml4ZXM6
IGMxOWI2ZDI0NmEzNSAoImRyaXZlcnMvbmV0OiBzdXBwb3J0IGhkbGMgZnVuY3Rpb24gZm9yIFFF
LVVDQyIpDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRyYSBEaXVwaW5hIDxhZGl1cGluYUBhc3Ry
YWxpbnV4LnJ1Pg0KPiAtLS0NCj4gICBkcml2ZXJzL25ldC93YW4vZnNsX3VjY19oZGxjLmMgfCA3
ICsrKysrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dhbi9mc2xfdWNjX2hkbGMuYyBi
L2RyaXZlcnMvbmV0L3dhbi9mc2xfdWNjX2hkbGMuYw0KPiBpbmRleCA0N2MyYWQ3YTNlNDIuLmNk
ZDk0ODljNzEyZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2FuL2ZzbF91Y2NfaGRsYy5j
DQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dhbi9mc2xfdWNjX2hkbGMuYw0KPiBAQCAtNzA4LDYgKzcw
OCw3IEBAIHN0YXRpYyBpbnQgdWhkbGNfb3BlbihzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQ0KPiAg
ICAgICAgICBoZGxjX2RldmljZSAqaGRsYyA9IGRldl90b19oZGxjKGRldik7DQo+ICAgICAgICAg
IHN0cnVjdCB1Y2NfaGRsY19wcml2YXRlICpwcml2ID0gaGRsYy0+cHJpdjsNCj4gICAgICAgICAg
c3RydWN0IHVjY190ZG0gKnV0ZG0gPSBwcml2LT51dGRtOw0KPiArICAgICAgIGludCByYyA9IDA7
DQoNCnJjIG5vdCB1c2VmdWxsIG91dHNpZGUgdGhlIGJsb2NrIGJlbG93LCBubyBwb2ludCBpbiBo
YXZpbmcgaXQgYXQgYWxsLg0KDQo+IA0KPiAgICAgICAgICBpZiAocHJpdi0+aGRsY19idXN5ICE9
IDEpIHsNCj4gICAgICAgICAgICAgICAgICBpZiAocmVxdWVzdF9pcnEocHJpdi0+dXRfaW5mby0+
dWZfaW5mby5pcnEsDQo+IEBAIC03MzEsMTAgKzczMiwxMiBAQCBzdGF0aWMgaW50IHVoZGxjX29w
ZW4oc3RydWN0IG5ldF9kZXZpY2UgKmRldikNCj4gICAgICAgICAgICAgICAgICBuYXBpX2VuYWJs
ZSgmcHJpdi0+bmFwaSk7DQo+ICAgICAgICAgICAgICAgICAgbmV0ZGV2X3Jlc2V0X3F1ZXVlKGRl
dik7DQo+ICAgICAgICAgICAgICAgICAgbmV0aWZfc3RhcnRfcXVldWUoZGV2KTsNCj4gLSAgICAg
ICAgICAgICAgIGhkbGNfb3BlbihkZXYpOw0KPiArICAgICAgICAgICAgICAgcmMgPSBoZGxjX29w
ZW4oZGV2KTsNCj4gKyAgICAgICAgICAgICAgIGlmIChyYykNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgcmV0dXJuIHJjOw0KDQpEb24ndCBuZWVkIHRoYXQgcmMgdmFyaWFibGUuIEp1c3QgZG86
DQoNCglyZXR1cm4gaGRsY19vcGVuKGRldik7DQoNCj4gICAgICAgICAgfQ0KPiANCj4gLSAgICAg
ICByZXR1cm4gMDsNCj4gKyAgICAgICByZXR1cm4gcmM7DQoNCkNoYW5nZSBub3QgbmVlZGVkLCBs
ZWF2ZSByZXR1cm4gMCBoZXJlLg0KDQo+ICAgfQ0KPiANCj4gICBzdGF0aWMgdm9pZCB1aGRsY19t
ZW1jbGVhbihzdHJ1Y3QgdWNjX2hkbGNfcHJpdmF0ZSAqcHJpdikNCj4gLS0NCj4gMi4zMC4yDQo+
IA0K

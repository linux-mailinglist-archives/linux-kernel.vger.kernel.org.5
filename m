Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927C47E00F7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjKCGcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 02:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKCGc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 02:32:29 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2154.outbound.protection.outlook.com [40.92.62.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D3E1AB;
        Thu,  2 Nov 2023 23:32:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evOc4A8V/fFYvsUXC4AhUDH1KLr9jUarLT+DZ1kyOzVay3AVNNUN75hgOAOe4gijtRiNBlOT12NAG7aj552lGdIDAARSz4C3cWM53zPrA8xoaWVsZzQzdGiKti0AcjbafhpiUoXU7AoyFgsctf4NDV78tkVXOwupsSy/pte+SIaEXB0dVVBmf6PHQqB90RcCnGv8Ug5vvWY6A+Kpea/bHRKbhZNeIm4gXLAQ227mI2nDUeZNCo92gfiA9dcCh4n1tKsmEmFcWiq+omqlzEVsEsn6pwn4DTxfoNS8/E0wtNKOXXA0A5uKU2DKX2WZSLiUtvMB5u6SlskBZtrESuhtwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Of1cKjjupN5ZCPf3oLCzUv3oqNpskYOP/ElASY7TVo=;
 b=TPZ2CIQoYUap95Gn4UR2DUGjF72HNXHzvD/wLtqNxyQ6OyAgwXqw56Twj5E8Ot4KeFwlYP5RNkSNG0EIslZtOtibC9M+D6NUXLtIz/gX/BBTuu0vgiWkzKnoxPhRPUFPf02AhGK6AkasesUHJAmrSOXl0GporvaoJNe9fLrYBS93Fa8soZveFvd+1lr2ZsP3z0s9E6faZVSJVjhUaYf2mZXBokvMREup0KduTDWWb1uFghEgYyRoTxx/JKLFwpgt2+jCuVi25BVemwxMVv4qGNuEf3qiCGe4JcjWOxq/8WyUh/SQ+8R2ay9IHKA/dwyx60rIZnT00DSpocyh/l4zGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Of1cKjjupN5ZCPf3oLCzUv3oqNpskYOP/ElASY7TVo=;
 b=gDXm07CutTl0ZGs29Sishvs+xehBsIN696w+H51Pbwf+NtJQpTXnjNBV2cpOTIZxeGM50Tx4itECQUFrw0o5DwsOSJF44h5BhPOVCqKkhJF/a2mliz6UEqm+VcqrSG4ESMeG/GPKfKuHNuMkig2gvgYL3qyr6OFQ4JYjkYpHtALiauqGcBK6lzLuz5rUuj3AZm0KE/k5oD91a7kj8dIznr+kwmAhXLi53sPqnLn0OnXTnecnozUHKNRXTZXWi7IuEsW1eEAvR9zgoRnrytPC3ytmyoMO30DFFzxw7oNUp2RlTe3w6SA+so2Q2K8rYfg6x0vZ01g80tRl7fuOr5UTlw==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY7P282MB4830.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:27c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 06:32:14 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::5821:18dc:a558:e382]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::5821:18dc:a558:e382%6]) with mapi id 15.20.6954.019; Fri, 3 Nov 2023
 06:32:14 +0000
From:   Jinjian Song <SongJinJian@hotmail.com>
To:     Loic Poulain <loic.poulain@linaro.org>,
        Jiri Pirko <jiri@resnulli.us>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "ryazanov.s.a@gmail.com" <ryazanov.s.a@gmail.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "chandrashekar.devegowda@intel.com" 
        <chandrashekar.devegowda@intel.com>,
        "linuxwwan@intel.com" <linuxwwan@intel.com>,
        "chiranjeevi.rapolu@linux.intel.com" 
        <chiranjeevi.rapolu@linux.intel.com>,
        "haijun.liu@mediatek.com" <haijun.liu@mediatek.com>,
        "m.chetan.kumar@linux.intel.com" <m.chetan.kumar@linux.intel.com>,
        "ricardo.martinez@linux.intel.com" <ricardo.martinez@linux.intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nmarupaka@google.com" <nmarupaka@google.com>,
        "vsankar@lenovo.com" <vsankar@lenovo.com>,
        "danielwinkler@google.com" <danielwinkler@google.com>,
        "Lei Zhang(Terence)" <zhangl@fibocom.com>,
        "Qifeng Liu(Qifeng)" <liuqf@fibocom.com>,
        "Fuqiang Yan(Felix)" <felix.yan@fibocom.com>
Subject: RE: [net-next v4 0/5] net: wwan: t7xx: fw flashing & coredump support
Thread-Topic: [net-next v4 0/5] net: wwan: t7xx: fw flashing & coredump
 support
Thread-Index: AdoE9d51qkeKSsY1RaiHiunKsAwJYwJKDSBA
Date:   Fri, 3 Nov 2023 06:32:14 +0000
Message-ID: <MEYP282MB2697C5005B872DB5277E531ABBA5A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [nnBXZGFmO8GKiZSwzkQz3xjS/syqEtyJ]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MEYP282MB2697:EE_|SY7P282MB4830:EE_
x-ms-office365-filtering-correlation-id: 622e583f-7f87-4d6d-370c-08dbdc369e7f
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OW/VW1MZey2hHOzGt4JbAcrxTTLjilRBTJ5H7zCc2vgLPOiHZOLtOKuoEN6RdISrrtT04jkleRo+K7ZlbaDg3wBdM0BHrSAr3ld4vBM53BhUQn/FKeOoELDT0/yk1JEgNkH80QAfrOanv98WP/8zwczMZ/f+1xKXkpmdpsGO0NpWA0se9SIrBQYoe1p/LJ9fNGedsdi7LYcjUyJUFpGzG7XwYg4PNk6o6D0P4qTXRK21yb6u3Wv74b5XQ8o+fKqphVqy97y+xpQP6fxiKZtHPBBXSz2h3SWHKtUVhLpQ3crl9sCNQ2TrUCfN9mZosLZJlTYUxEHhd/f3IqmZ60QnFtEsGR1qB5eQ9y1uIB0KPVNuitpqGZm2Mw4JWkTpk52yk41sACUgbeYW+vrR59YERFlLNhfW5GzUczneGgWrOppz3euXOhIy7KGQWyHti9VddIK07MrrVpM5f3XCQAeI3jwNr+cHyudgW3+jsrCJTebKW5pbh4aZ2FVsBmWtORjaoRb+44sbNhs+jXsmoV0WR9ry/8SOkfyhFthsKQ/2CKmrl0J4/QTuV/+/7bOHYdkL
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0IzWHY1UHlzYUdGZkJSbjRtZE1mV2JtSWExa3hwTUZTL29sZnR4YlloVmw5?=
 =?utf-8?B?QzI4UjlOYUV3WDNNanZKOWJqS3VQNk12ZlRJdWVmZkFsODdXeXAvcWhHMDJI?=
 =?utf-8?B?S0xOQnlSM0lqd3VpUlNQN3lnaUcrV1NUK1AwRTYrVHdtcE9iL3M1UjRkamF2?=
 =?utf-8?B?dTZ1ajY2WnhjclpQS1pQTU12RUs3UzFBdzdia005OUtlQmRBcFRnTzRUTngr?=
 =?utf-8?B?V2Y2bEdvOXRpNDV1QnR3bDNiWktnajFyUnI5V3RuZVF1K1h3Z0h6NEVzbk9X?=
 =?utf-8?B?eHlFTVhMRUtsek14NXBla2wrTU9vM2R4UXBzS0IyRlJRK25Bb3VXb3lEbnVU?=
 =?utf-8?B?ZmIrNVdKSERUaFhPYk4yZDJJNXRGOW5yUG9BS3dWTVMxeGxuZW9HMGNpY1Nz?=
 =?utf-8?B?ZmNaOGJ2bFVveTFmaVJqMEtqcXZ6ZlZpL3VuaG9oMVVINkNGTDVSbXhWUXpx?=
 =?utf-8?B?TlpDYzUyRkhxelhjbmxRSndubU1FQkxlRVI1U1llbFZ6L0dEYXgrOXl3NE51?=
 =?utf-8?B?S1Nmd2RQTnU3eWU3RFRHQXJ2c1dEaUJhcTZJaWJTQXpKRjN5b3VPcU44SENs?=
 =?utf-8?B?Uy9lZGxOT1pveCs0UzgzSTN1RnpzUjBWc2YxcW9iTFcrcURBdXg2Zmo0eW1k?=
 =?utf-8?B?TFpaWnp4elVUM1p2YjhtblR2Tk5qM0l2TnIxb2d4MEJDVXppUExrejlRSmg4?=
 =?utf-8?B?NGo4MCtnZzkwUHhnM1Fna2lkcG5NcC9FWENyc1pudURlaW1kKzk4Ym5JRlR6?=
 =?utf-8?B?MDZMSVlKVSsrbTVkZ0p0elhNSERGaWtvRnBtd2p6RlIrVXlreGtFQXZRQXVv?=
 =?utf-8?B?QW91RmZSK0g4TE0ybm54ejBqck1qdVZwZkw4T2picHhxeForN1BzSFJ1Y2M3?=
 =?utf-8?B?cDBaVUM3TUMvYnA0N29Ld1RUREloYVIxaWphR2RTTkV0QUNmSzE3TDVXV0xk?=
 =?utf-8?B?QmZNdkVuMkZiMitKN1JkMmpxMy9ya00xL2VrTjhtbmw4cjlZSnFHQTJZYVV1?=
 =?utf-8?B?ekd1YmVzaytWWjRaM1NjSDhISWo3VzFFY0ZUNkUwUXBSbVZhNHk4RVVBZ2Nu?=
 =?utf-8?B?VnBOaUYzQzVFY25EdXlMK0VuSVNTOUN1aEdYK0oxcEJBbzJLaWIyMGFVaVhq?=
 =?utf-8?B?WDg5aVBSOWNjNHd6aFcxYlBmejMxekMyOStpNG01b3ZkZ1NwUTJITE93bVY0?=
 =?utf-8?B?RWxmUUZwcHU5VGdmbjdjd3NaV2FxV2wzQ2FtTHlpRjFpNFdzOTltMkFoOTRi?=
 =?utf-8?B?VExXVnYrN2k0T0xUbW92MzcxellQK3VOMjJIWTEyZnlzOXhINmJOVGdYQmpJ?=
 =?utf-8?B?RThHWDAycjRFNm9nTDVvZFRndWFucEVRMmo0ZWlyLzQ1bi92d1gzYXBkUjNl?=
 =?utf-8?B?dE5ndHI2WG1ra3NKVVlrbDd0bHVKWHVaRllsZlkvbjlLS0pRMGVGUnVXdVRS?=
 =?utf-8?B?TDROK1BtYkdjZzlZN3VralF4V05lNSttZzZ5REhvWHBHRUQzcDlieFk2a3pQ?=
 =?utf-8?B?Q0NSMmtzaFBhUEN5MFRxd1U3bkNNMGgvY2pZUjljY3F3c0I1ZGlFN0xad0hG?=
 =?utf-8?B?UmZCNmt3UU9vQXJmTWQ2Mm5RSU9TYnYvMmQzUVNqTVdidm5hejNLWjB1dHlW?=
 =?utf-8?B?cFVQZkl2YlJXMTRWNjNkSk56eWhMbEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 622e583f-7f87-4d6d-370c-08dbdc369e7f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 06:32:14.7952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB4830
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj5PbiBXZWQsIDEzIFNlcHQgMjAyMyBhdCAxMToxNywgSmlyaSBQaXJrbyA8amlyaUByZXNudWxs
aS51cz4gd3JvdGU6DQo+Pj4NCj4+PiBUdWUsIFNlcCAxMiwgMjAyMyBhdCAxMTo0ODo0MEFNIENF
U1QsIHNvbmdqaW5qaWFuQGhvdG1haWwuY29tIHdyb3RlOg0KPj4+ID5BZGRzIHN1cHBvcnQgZm9y
IHQ3eHggd3dhbiBkZXZpY2UgZmlybXdhcmUgZmxhc2hpbmcgJiBjb3JlZHVtcCANCj4+PiA+Y29s
bGVjdGlvbiB1c2luZyBkZXZsaW5rLg0KPj4+DQo+Pj4gSSBkb24ndCBiZWxpZXZlIHRoYXQgdXNl
IG9mIGRldmxpbmsgaXMgY29ycmVjdCBoZXJlLiBJdCBzZWVtcyBsaWtlIGEgDQo+Pj4gbWlzZml0
LiBJSVVDLCB3aGF0IHlvdSBuZWVkIGlzIHRvIGNvbW11bmljYXRlIHdpdGggdGhlIG1vZGVtLg0K
Pj4+IEJhc2ljYWxseSBhIGNvbW11bmljYXRpb24gY2hhbm5lbCB0byBtb2RlbS4gVGhlIG90aGVy
IHd3YW4gZHJpdmVycyANCj4+PiBpbXBsZW1lbnQgdGhlc2UgY2hhbm5lbHMgaW4gX2N0cmwuYyBm
aWxlcywgdXNpbmcgbXVsdGlwbGUgcHJvdG9jb2xzLg0KPj4+IFdoeSBjYW4ndCB5b3UgZG8gc29t
ZXRoaW5nIHNpbWlsYXIgYW5kIGxldCBkZXZsaW5rIG91dCBvZiB0aGlzIHBsZWFzZT8NCj4+Pg0K
Pj4+IFVudGlsIHlvdSBwdXQgaW4gYXJndW1lbnRzIHdoeSB5b3UgcmVhbGx5IG5lZWQgZGV2bGlu
ayBhbmQgd2h5IGlzIGl0IA0KPj4+IGEgZ29vZCBmaXQsIEknbSBhZ2FpbnN0IHRoaXMuIFBsZWFz
ZSBkb24ndCBzZW5kIGFueSBvdGhlciB2ZXJzaW9ucyBvZiANCj4+PiB0aGlzIHBhdGNoc2V0IHRo
YXQgdXNlIGRldmxpbmsuDQoNCj5UaGUgdDd4eCBkcml2ZXIgYWxyZWFkeSBoYXMgcmVndWxhciB3
d2FuIGRhdGEgYW5kIGNvbnRyb2wgaW50ZXJmYWNlcyByZWdpc3RlcmVkIHdpdGggdGhlIHd3YW4g
ZnJhbWV3b3JrLCBtYWtpbmcgaXQgZnVuY3Rpb25hbC4gSGVyZSB0aGUgZXhwb3NlZCBsb3cgbGV2
ZWwgcmVzb3VyY2VzIGFyZSBub3QgcmVhbGx5IHd3YW4vY2xhc3Mgc3BlY2lmaWMgYXMgaXQgaXMg
Zm9yIGZpcm13YXJlIHVwZ3JhZGUgPmFuZCBjb3JlZHVtcCwgc28gSSB0aGluayB0aGF0IGlzIHdo
eSBKaW5qaWFuIGNob3NlIHRoZSAnZmVhdHVyZSBhZ25vc3RpYycgZGV2bGluayBmcmFtZXdvcmsu
IElNSE8gSSB0aGluayBpdCBtYWtlcyBzZW5zZSB0byByZWx5IG9uIHN1Y2ggYSBmcmFtZXdvcmss
IG9yIG1heWJlIG9uIHRoZSBkZXZjb3JlZHVtcCBjbGFzcy4NCg0KPlRoYXQgc2FpZCwgSSBzZWUg
dGhlIHByb3RvY29sIGZvciBmbGFzaGluZyBhbmQgZG9pbmcgdGhlIGNvcmVib290IGlzIGZhc3Ri
b290LCB3aGljaCBpcyBhbHJlYWR5IHN1cHBvcnRlZCBvbiB0aGUgdXNlciBzaWRlIHdpdGggdGhl
IGZhc3Rib290IHRvb2wsIHNvIEknbSBub3Qgc3VyZSBhYnN0cmFjdGluZyBpdCBoZXJlIG1ha2Vz
IHNlbnNlLiBJZiB0aGUgcHJvdG9jb2wgaXMgcmVhbGx5IGZhc2Jvb3QgY29tcGxpYW50LCBXb3Vs
ZG4ndCBpdCBiZSBzaW1wbGVyIHRvIGRpcmVjdGx5IGV4cG9zZSBpdCBhcyBhIG5ldyBkZXZpY2Uv
Y2hhbm5lbD8gYW5kIHJlbHkgb24gYSB1c2Vyc3BhY2UgdG9vbCBmb3IgcmVndWxhciBmYXN0Ym9v
dCBvcGVyYXRpb25zIChmbGFzaCwgYm9vdCwgZHVtcCkuIFRoaXMgbWF5IHJlcXVpcmUgc2xpZ2h0
bHkgbW9kaWZ5aW5nIHRoZSBmYXN0Ym9vdCB0b29sIHRvIGRldGVjdCBhbmQgc3VwcG9ydCB0aGF0
IG5ldyB0cmFuc3BvcnQgKGluIGFkZGl0aW9uIHRvIHRoZSBleGlzdGluZyB1c2IgYW5kIGV0aGVy
bmV0IHN1cHBvcnQpLg0KDQo+SSB0aGluayB0aGlzIGlzIHRoZSBhZHZhbnRhZ2VzIG9mIHVzaW5n
IGRldmxpbmsgdG8gaW1wbGVtZW50IGZsYXNoIGFuZCBkdW1wIGNvbGxlY3Q6DQo+MS5EZXZsaW5r
IGZyYW1ld29yayBwcm92aWRlIHRoZSBpbnRlcmZhY2Ugb2YgZmxhc2ggYW5kIGR1bXAsIGFuZCBu
byBuZWVkIHRvIGRldmVsb3AgY29ycmVzcG9uZGluZyB0b29scyBhbnltb3JlLiBGcm9tIGFub3Ro
ZXIgcGVyc3BlY3RpdmUsIHVzaW5nIGRldmxuaWsgY2FuIGRpcmVjdGx5IHJlZHVjZSB0aGUgY29t
cGxleGl0eSBvZiBQQyBtYW51ZmFjdHVyZXIncyBjdXN0b21lciBwcm9kdWN0aW9uIGxpbmVzLCBo
ZWxwaW5nIHRvIHJlZHVjZSB0aGVpciBjb3N0cyh0aW1lL3Byb2R1Y3Rpb24pLg0KPjIuQ3VycmVu
dGx5LCB0aGUgcGxhdGZvcm0gYXJjaGl0ZWN0dXJlIG9mIGVhY2ggV1dBTiBtb2R1bGUgbWFudWZh
Y3R1cmVyIGlzIG5vdCBjb21wYXRpYmxlLCBRdWFsY29tbSBpbXBsZW1lbnQgY29tbXVuaWNhdGUg
Y2hhbm5lbHMgaW4gaG9zdCBkcml2ZXIgYW5kIHVzaW5nIGZhc3Rib290IHRvb2wgdG8gZmxhc2gs
IHVzaW5nIHRoZWlyIGNvcmVkdW1wIHRvb2wgdG8gY29sbGVjdCBkdW1wLiBJbnRlbCBpbXBsZW1l
bnQgdGhlaXIgaG9zdCBkcml2ZXIgaW4gZGV2bGluayBmcmFtZXdvcmssIHVzaW5nIGRldmxpbmsg
dG9vbCB0byBmbGFzaCBhbmQgY29sbGVjdCBkdW1wLiBNVEsgZGVzaWduIHRvIHVzZSBkZXZsaW5r
IGRvaW5nIGZsYXNoIGFuZCBkdW1wIGNvbGxlY3Rpb24uIERldmxpbmsgY2FuIGlnbm9yZSBkaWZm
ZXJlbmNlIGluIHBsYXRmb3JtIGFyY2hpdGVjdHVyZSwgYWJzdHJhY3RpbmcgdGhlc2UgY29tbW9u
bHkgdXNlZCBpbnRlcmZhY2VzLCBJIHVuZGVyc3RhbmQgdGhhdCBJbnRlbCBhbmQgTVRLIGFyZSBw
cmVwYXJpbmcgdG8gdXNlIHRoaXMgcGxhbiBpbiB0aGUgZnV0dXJlLg0KPjMuRmFzdGJvb3QgdG9v
bCByZWxpZXMgb24gbWFudWFsIGluc3RhbGxhdGlvbiBieSB1c2VyIGFuZCBpdCBkb2VzIG5vdCBo
YXZlIHRoZSBhZHZhbnRhZ2VzIG9mIHRoZSBhYm92ZSB0d28gZmVhdHVyZXMoY3VycmVudGx5LCBz
ZWVtZWQgY2FuJ3Qgc3VwcG9ydCBjb2xsZWN0IGNvcmUgZHVtcCBkaXJlY3RseSkuIEl0IHNlZW1z
IHRoYXQgZGV2bGluayBkb2VzIG5vdCBuZWVkIHRvIGJlIGluc3RhbGxlZCBzZXBhcmF0ZWx5LCBf
Y3RybC5jIGZpbGVzIHVzZWQgZm9yIFF1YWxDb21tLCBidXQgSW50ZWwgYW5kIE1USyBkb24ndCB1
c2UgdGhlIHNhbWUgZGVzaWduIGluIG1vZHVsZSwgc28gY2Fubm90IGRpcmVjdGx5IHJlZmVyZW5j
ZS4NCj40Lkl0IHNlZW1lZCB0aGF0IEludGVsIFdXQU4gcHJvZHVjdCB1c2luZyBpb3NtIGRyaXZl
ciB3aXRoaW5nIGRldmxpbmsgZnJhbWV3b3JrIGhhcyBiZSBhbGxvd25lZCBpbiB1cHN0cmVhbSwg
aXQgcHJvdmlkZXMgc29tZSBndWlkYW5jZSBhbmQgZGlyZWN0aW9uLg0KDQo+U28gaG9wZSB0byBn
ZXQgeW91ciBoZWxwIGFib3V0IHRoZSBzdWdnZXN0aW9ucyBmb3IgdGhlIG5leHQgc3RlcHMsIHRo
YW5rcy4NCg0KDQpIb3BlIHRvIGdldCB5b3VyIGhlbHAgYWJvdXQgdGhlIHN1Z2dlc3Rpb24sIGlm
IGRldmxpbmsgZnJhbWV3b3JrIGhlcmUgaXMgbm90IHN1aXRhYmxlLCBJIGhvcGUgdG8gZGlzY3Vz
cyBvdGhlciBhbHRlcm5hdGl2ZSBzb2x1dGlvbnMuDQoNCg0KVGhhbmtzLg0KUmVnYXJkcywNCkpp
bmppYW4NCg==

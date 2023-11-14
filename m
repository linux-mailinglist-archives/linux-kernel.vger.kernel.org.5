Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F637EAA7D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 07:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjKNGXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 01:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNGXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 01:23:41 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2011.outbound.protection.outlook.com [40.92.102.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648321BF;
        Mon, 13 Nov 2023 22:23:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h13caaxWL9fVsz7BVtImElMBhJiQroRTm3KsAJbnlH3YEHmq/k9w1g2sm71bo54d0Yjcpn7lFRtjl11RRCiutQQ/1kVkyAybIaZK/szQrN0r9JUPFAzsdOPQvZ38mu1bsP4BNRrBK8T9ky2xn8krR9c0s/2GtS45R4qtNgw02Bwe5bne3nStLFolZUTZORQpLR3HfmMBJSrAgdUrM5AS4wNBGfg3QxUg8nkkvv4d92G6SxU5/BN5U2q2ET2mLmBAu/UUnwEhr/U/2IX74AR8kRD10sSoqDePUdrMqH+xFWvzViLKohIHW//gyINmyzkMm71iO/zXsrWKXl9Fj71tWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbzkXzVsFtcM3iXheria0GhiSeb0Ae1yapzk4CxO6qY=;
 b=EvFbOqcv5X9gVJQCfGFFHnWqr+vdQDmHf2KWMNiPOlR5KWUwXPzvEqjP7eOnTM/nBUPbsVANpGHhPeLLId7k3pc1otO1iueeR8La69QW7Y37QhCPSuSiyYHwAfwgqIsWFYSvcGYTA7RUDP9klyBvlzf1u3jaIcCq70wk8S0+dVjhQls9duFeEr9Y6aeZmyKV4N9iYgOjLDqKbhSL//jmWLY2lGaUfNeoRkTbf6n575PDb5TR4laNmE1rDcQd+bnBafqOB4DXuFzouiFu96WrxtAyj4Wge9upzTpO/eNPhlP05GVK06owoAYeWLsQLOGuA8G8hKZG+USmz419C7UP2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbzkXzVsFtcM3iXheria0GhiSeb0Ae1yapzk4CxO6qY=;
 b=Ds8K+TySKC/lIx5cIBLgUA20Gkb027L+8la8li7eSvxtNx+fntvokZFs9LsWavbOcdFQUa1sTTnxGU18JRkkywfM45elsGsox4ZPuWaxPAuaaqSwNMjnKZVgE8PLyUE/47uWZOjeLEiMROWU1z3JEptZmUn1fs70q9fghEriNXSYiTxBXULbiUQGwX9o+EJqWPdrCz6e9DUboDwsd+XBuRpwJzcfcouvzCXePddVvPL/kXwTDbmvA1pj0jbDGem+u9izELzek3QaIU6SXHm1lmfqo8amwhE3PomFPpEpILnqtKBVsjPhbop15C/kGgoKM6YYnJqkObWZKc5snq56aw==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 PN2P287MB0776.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:136::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.31; Tue, 14 Nov 2023 06:23:31 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::6037:db64:7000:119f]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::6037:db64:7000:119f%6]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 06:23:30 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
CC:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>,
        Kerem Karabay <kekrby@gmail.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Asahi Linux Mailing List <asahi@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [REGRESSION] Bluetooth is not working on Macs with BCM4377 chip
 starting from kernel 6.5
Thread-Topic: [REGRESSION] Bluetooth is not working on Macs with BCM4377 chip
 starting from kernel 6.5
Thread-Index: AQHaFnQHPuYl63BuYUeFaxX8dCI6lbB45gMAgABzQcc=
Date:   Tue, 14 Nov 2023 06:23:30 +0000
Message-ID: <MA0P287MB021794BCCCFB5EA57C1C3B69B8B2A@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <22582194-DE99-45E5-ABEE-C1C7900DA523@live.com>
 <ZVKxtD2Mt_eVyttJ@archie.me>
In-Reply-To: <ZVKxtD2Mt_eVyttJ@archie.me>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [FBP5oihz24auSv4QRjlTZFWGnPGs/WC8T914uBzIUxUs5JkQosRV3vI8x0ghisNw]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|PN2P287MB0776:EE_
x-ms-office365-filtering-correlation-id: d6f88b50-c9ad-4aaa-49aa-08dbe4da38c0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SFbk7OZkp5G7hBO4hfX3vKKZpYAn82Hpq4HyeutMaTNIbKWyzavdk9Nzkb7bpsWbCHYaBaqLnqORHEq8BrSaIgR/k9gOly/vM2b3PZ2Y6NI5e7c4sBOQrdF13AZNK2SR9ykzNMh98w2HCZ3Zyl8tgtu/iF++PwIW7XTAhXzEdmhcj1R3APmDIX6Kp6wLO4v5mb0e0vDwB4uDPZW/vgOVYkp3YMmcEQ7BJPoiJ5aYRBg8/9+vLNvrUBMsbT7g9zrV4P7XtA8KaR3DZhpjcE6Kih0vUjFKxb5vIaUuB4IShlcT+CqrhtMVixGPNaJ+0qBzc2Z0UKUbZOFnp2ERmTPQoJ5E0Hy42aTjZ+X4RRjy0cU1XwfirvYk/Y0X/2ZbidHy5BnuFD/WNyMnFdSf6A+80mFGG7qDvdUkpYo51biCDTuA6l+wkLzSsgkY0vc4LT1bx3umLj5EHQHAfj0nu4V/xwhC0hfOveRqTyfz30HkTfdAm7WRC05TLH3jeohVvsUEOwYqVdjroLk95bzOaaO3A6vAW4vIvFcX2YTv9t5gMNBU3vR9IxcPyMX9juTar+FbPchWgzJHsuBNsTm24q1pdPeLg2Y6PRXE/rzUpca0rzA=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXlueWRsNG5NWEhtQlYrRERLcHBJU1Z2Yko0NHJWMHVLSVpQcVZocWFnNWRi?=
 =?utf-8?B?UWRHN29HSXV5RkV4QjhocUIxNEVUTE5ZL3dRbmcvYzRXMHg4K09KRFZ5a3pX?=
 =?utf-8?B?WGxjcTRwMUd5eGRyYWgxenlKYStyVDYvMXB5Mzl0RW40ajl5bmNndVZ6d1Vs?=
 =?utf-8?B?eDhITExtMmNTU1ljVTVwS1V0RXo5TkVzYy9CZE1ZN01LRDFVaTFkem9HSG1a?=
 =?utf-8?B?UW9YcmxEelp0dHoxN21yR2p6eHBqRWhXMWUwQno5eUtxcWxXY3lKTmtGaUN3?=
 =?utf-8?B?aXgzdmR6WlRUOTNIRG9QMVpGL1RZa25wQjI5aEpWUzRubnFaTEMxTTJ3STJY?=
 =?utf-8?B?cDFWV2Q4ejhnajVJcmMwekorcFpYTCs1dG5NQ2FjQ25XWXViZVpjNjA4bVY2?=
 =?utf-8?B?T2dET2lpYitiV1lHdUJrMnVGNTZtbVljWFVoQWcwVVZCMDhEc3p1cmtHS3do?=
 =?utf-8?B?dHBmR1NibnZsaEJabjdUR21oazk2NHdQT0NGTFVYT09sVmhBZnFlT3JQWEJl?=
 =?utf-8?B?VkNJVHdxa2trdmJSekhpcjc5ZEcyOHlIdFluVFRkd1d1N3UydzRtMnYwMldz?=
 =?utf-8?B?dEcxVi8rOUZlZFFMcFk4MXZmRDFyeGh6b0F6OGtoYitLTUlIZFkvZ0p6ZDVp?=
 =?utf-8?B?S1dTR1Q5NlczTElQSnV1czdnNWVaM1ZDNlpqVUpJNjBmZGdvcmtLV2E4MXBP?=
 =?utf-8?B?UUVoUGdVckFpODQvcGh5T2F1NE5kYStZTWx2NG5QUS93cENBbWpRaC9xckVa?=
 =?utf-8?B?ZHFPODlHTnRvck1yRndjZmNxYlBJMURHcWIycDY5c2RNejJoK0twY1NCWnFP?=
 =?utf-8?B?WmhqMmcrdTgvdE43ZE96VmkrZ0thYTJMWmJRMTE2ZFc1azcrb2J5bjdaVmhC?=
 =?utf-8?B?R0tSakRuWCs5blg0SUFLQ2hoa1c1ZTA5WCs1ZUZpK2JOK3FwTW9yU0prYVhL?=
 =?utf-8?B?SWtpYnFWRFVSRmg5QzY1dlZaSkN0QUxsMWNJbTBwVHBvQVd5VXd1dXFnOSsy?=
 =?utf-8?B?YmpzUHRSYllnUGlsbzNESjFDTTRlaHdxb0ZQZXRLYXY1VUswZUd1MXQ0YUdt?=
 =?utf-8?B?Ni9NeWlzNnpQTS8ydW82aUJLWDdnTnV5Wk5ZUmM2eTJyMzJwcmpmcTZZZlYv?=
 =?utf-8?B?d2tCM2NPbzFoQ0JZSUxLNFZncE1hOTNoblRIdnRUK3ZQdndnbjlHcmRTTlMx?=
 =?utf-8?B?YW1QbEZxc0xtbUgrQktYM3IrSHpBbStNMnM1aGxKMjFmMkFmZjVCSG5GRFJ6?=
 =?utf-8?B?L1VlS0s0alRHTmxVMVRYQUtQakozM3ROZGFDZGFZRURpdmlNYmlXbXg3bEFY?=
 =?utf-8?B?MkVVZjJPYmFDOXJ3YTM3NnNZSGZaQ3pwU3c1d1ZkU1ErclZEOElBWHRpTHhG?=
 =?utf-8?B?VlYxMEZMSjk1bENSMXY3R2NlYjdkZXk2V3FzbXN4czBITnVrNTd0NWwxS3ht?=
 =?utf-8?B?VHNwbUw1RXNlQzU1dFdBcEZOWUp2ZWdHZDhwMVBOeWZvWEZvcTcyeEFBWFBD?=
 =?utf-8?B?bDJ5UXZMSFBPR2w1VFNFbm5VUlNyWDVVSHNSYzhzSS96LzFjL0djZ20vM3NS?=
 =?utf-8?B?RmRjMXllNXAvdFBuQXJGMlJCTlIvS3NCR3daZmZhTS8wbnVtaHZycE4zbm1h?=
 =?utf-8?B?QlQ3VmZKbGQ5eldVYnFkYW5iQi9iVUp0RUgvY244THhxSnpMREpMSzZuSXZa?=
 =?utf-8?B?WEEvNnFJb0hQU1RlNjRicHFVTmpoQTFJSlRRNENvZnVQZkEvWTZZZGNRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f88b50-c9ad-4aaa-49aa-08dbe4da38c0
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 06:23:30.9090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0776
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gMTQtTm92LTIwMjMsIGF0IDU6MDHigK9BTSwgQmFnYXMgU2FuamF5YSA8YmFnYXNk
b3RtZUBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g77u/T24gTW9uLCBOb3YgMTMsIDIwMjMgYXQg
MDg6NTc6MzVQTSArMDAwMCwgQWRpdHlhIEdhcmcgd3JvdGU6DQo+PiBTdGFydGluZyBmcm9tIGtl
cm5lbCA2LjUsIGEgcmVncmVzc2lvbiBpbiB0aGUga2VybmVsIGlzIGNhdXNpbmcgQmx1ZXRvb3Ro
IHRvIG5vdCB3b3JrIG9uIFQyIE1hY3Mgd2l0aCBCQ000Mzc3IGNoaXAuDQo+PiANCj4+IEpvdXJu
YWxjdGwgb2Yga2VybmVsIDYuNC44IHdoaWNoIGhhcyBCbHVldG9vdGggd29ya2luZyBpcyBnaXZl
biBoZXJlOiBodHRwczovL3Bhc3RlYmluLmNvbS91OVUza2JGSg0KPj4gDQo+PiBKb3VybmFsY3Rs
IG9mIGtlcm5lbCA2LjUuMiwgd2hpY2ggaGFzIEJsdWV0b290aCBicm9rZW4gaXMgZ2l2ZW4gaGVy
ZTogaHR0cHM6Ly9wYXN0ZWJpbi5jb20vYVZITkZNUnMNCj4+IA0KPj4gQWxzbywgdGhlIGJ1ZyBo
YXNu4oCZdCBiZWVuIGZpeGVkIGV2ZW4gaW4gNi42LjEsIGFzIHJlcG9ydGVkIGJ5IHVzZXJzLg0K
PiANCj4gQ2FuIHlvdSBiaXNlY3QgdGhpcyByZWdyZXNzaW9uIHBsZWFzZT8NCg0KU2luY2UgSSBk
b24ndCBoYXZlIGFjY2VzcyB0byB0aGlzIGhhcmR3YXJlLCBpdCdzIG5vdCBwb3NzaWJsZSBmb3Ig
bWUgdG8gYmlzZWN0IHRoaXMgcmVncmVzc2lvbi4gTGV0J3MgaG9wZSBzb21lb25lIGlzIGFibGUg
dG8gZG8gc28gdGhvdWdoLg0K

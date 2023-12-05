Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6DD8051D2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442037AbjLELPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345052AbjLELPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:15:50 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2054.outbound.protection.outlook.com [40.107.241.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F44D116;
        Tue,  5 Dec 2023 03:15:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9tKIuiy0FP+jkAtN9wWly8MJdrOIx6Ejvl63nZAD0adh22nTnV1zFc2kNQzjPcCmWFlJNv76W72D2CBGWzsFz0C2Z3G3uuTywWq0Fh5zyYywVNoIoH59A0rJEiWslRHm/S1hzjgzf+LmwE9cAjv+AKjE1dYZreleoBoaIpxMJScppAC4ZIP/Tje51mNQnWunV7cc1WEBy86iTXzrQRpGJiGWXQoTuFac4BFyzvBS5gqtQgGudVldMGtllQ+iXQ8B/R04aISkh3xO/S5VJJv5Xdj54m81dK6Li0JMEAXpLNQ1knfPxkCvqd0o3V3Nm5JFoYsZNb8u+tZfVN12DqKTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qXaI8l6xCZbIjtv0GG5fCDTC+AbyQB3FIYZrG67NVc=;
 b=d/9FUNleTo9obNs0THYVJZhKgsuXwsiJcz6TzrYByJ7cHmKVwzinj9TgnBM5cNv7lIrArtkymnGxC0sof/L2Q7dYElF6+VORdNO03T+8aYgRTAYHUhKwA1kPOFhpkjB8aiZSHRuP2hvcwSjLsm6aPNjThy2949GWxm0Hv1FWa8cMQnOwPzKeAc/udt7x/o5FgSb4IvVCIIilvkVzp9Wq7+OVlScjeUCLy1WuPcAgN4fMHciOknTcTAnQCU+rYOJcVkp2GYZvACv7wJWXxFAfZCfmwOU7b29IkOSaPMpfrwePK0A/cmNcW+GcR0Arqqt0ocN/ddrKzeG4whXLZJ9QUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qXaI8l6xCZbIjtv0GG5fCDTC+AbyQB3FIYZrG67NVc=;
 b=RfVfi8qpfXkvZcRr2tPAngtkt13ZugD6wz4Lcmn+YLm/sGaB0pVnxBYC9qcz7JZ+p3GBt1MQbQ9utsgWCr54lvkz0lFnnhIXqCKUTNQPn3uJ+wmLcfGGDIdl85QIDInVk9nFX9avn+rw+cbeyY7sLMqlJTfgRCugUVW4NE00/YwbqlAaafTJ/VP+5J8ppNs6dstTvmOeiRpp5EfYdcATQKyirtJ1Dnb8HQfP7H57QFPDHN/JFR7zwMnW9Z6r4w46/F4SNUUTsm9vpVRid+fG+/Nd2gPSGmODYtoXWw9tHis+5lkWdgOiEn8atVuy+4JDhaxv7v+pTKVi9nryTOvOvQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AM0PR10MB3124.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 11:15:51 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f1e6:2701:4840:b64f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f1e6:2701:4840:b64f%5]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 11:15:51 +0000
From:   "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "donald.robson@imgtec.com" <donald.robson@imgtec.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "sarah.walker@imgtec.com" <sarah.walker@imgtec.com>,
        "kristo@kernel.org" <kristo@kernel.org>, "nm@ti.com" <nm@ti.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62-main: Add GPU device node
Thread-Topic: [PATCH] arm64: dts: ti: k3-am62-main: Add GPU device node
Thread-Index: AQHaJ09veZnwcgNaAE6OVXFA3XpTmbCaii8A
Date:   Tue, 5 Dec 2023 11:15:51 +0000
Message-ID: <c20b213534667337f08b75a6c325fafec6526135.camel@siemens.com>
References: <20231204121522.47862-1-donald.robson@imgtec.com>
In-Reply-To: <20231204121522.47862-1-donald.robson@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AM0PR10MB3124:EE_
x-ms-office365-filtering-correlation-id: 2fe2d393-8ef6-4dec-3c9b-08dbf5838a7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k/xrV+Oog2+m2oGWHw+TMqiUGRtb58Z3jXmIfXFIlwLarqP6vCuNIwdMvoQB4hL71srocKVwpPRXC7plH0SH2EyojH+/GSlUl9m2YF7xmgxOCH96I1L079EAtl1wL59IG2FvHm46Ljij90toEfT0gDn0wgRanQDfusdFzwTFpcbN6rMSanBjJ6yl5DesfI+LNNli14Fsq8KHpaStN5rFup7/4gE2mR/cVqGoslvn0R9NvmZBPuoZc/2vJoXRknQmVyBCDdAqVwky43yGvYbmVNGA3LDXo01ukBmN95qDnTJeGtQ03P0r3YEotbr8MuzcgLlRN22aLngj1CGj9Z0D3dLciVD0YY+4jSnn9j8+YPegOckV/UknMulPasRmml6Gf5KD8WzTmOpZj/j4/mccNWZjoHHkOpGGo1ixEKaZXD5SsQywntQlmTfj6gTsva425uot+HkChnE2pCLUR38HWwy0DhFQJ5Gf4n/0XdY7k2f4b2iyg5NMK0JgiGKF9RvjT3siBBJdiHpLNSTa/c9jbLKaW+YE4RozZDDzstM4GYxaKiKrR0WL/ArdIegAhd3kZtDAIaj0CJ99nMCNGV4E8tZTwZiwY6iyue6WpF3MIsCb+bwoVasFTFNq9PqmjENlOrTQYLjfKDRPWAmfxya9gg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(366004)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(7416002)(15974865002)(2906002)(110136005)(316002)(91956017)(66556008)(54906003)(64756008)(66446008)(66476007)(38070700009)(76116006)(86362001)(66946007)(8676002)(4326008)(41300700001)(36756003)(8936002)(5660300002)(38100700002)(122000001)(82960400001)(6486002)(83380400001)(478600001)(26005)(71200400001)(2616005)(6512007)(55236004)(6506007)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nm9xd25xOTJvQW1tWDNWM09kRW1wZldXVFdTNGxGSURUNUl0M2ZKNkNOZ0I4?=
 =?utf-8?B?Z3R4eUZCQjBOdDcyWkdLeGE1K1NTeHFkaTE4OWljUURJZ3hmY3ZqbU1zaklR?=
 =?utf-8?B?am9YOW1VM3AzbVM4emRFNkRXMEc2bkxNN2E3b29jYTczNnJ4WDJWS2tPb0FE?=
 =?utf-8?B?QzJhKzREODhpL0xqQmY5RG1seFFUSlZPNTYwK0w2cHVJUUhqMjBHM3kwOVQ3?=
 =?utf-8?B?dXZ6SEpNeFoyTTlXc0ppd2dBYmhRQ0hxa2tRQlV5WUtRVGd2RW1KU3ltNWhw?=
 =?utf-8?B?c2pKVXdiK0ExNWE0T3VFOWZrOTZMYWlPd0FNQ0E0ckdlWFMvd3R1aUFwVmwx?=
 =?utf-8?B?TWtLZGYyQnB0NWpNOVpRWmVXSWRJd2h4US9EM1hFTEN0WTg2ZkxGVjlwbGQ1?=
 =?utf-8?B?R3RhZ2oyVUR1bkxvMkQ4M3AwVGtSd0NPNTgwNnVxK3Q4ZXZ4VHNRb0o1VHly?=
 =?utf-8?B?K2RLZTM3dTREaU1JMHBnZ1FkazQyc3l5QWg0bGczZGhMMXBYOWc3SmVMcE4v?=
 =?utf-8?B?U0VRczdqZ0xjaDlwMTlESEFqOVlGWFV2Z2ZWZFFmTDl3cEhpWUZPTGhyc1dh?=
 =?utf-8?B?Q3J0Vlg2eVkwM3dCNVBCRTd1VDlLWnc0dkpsdFZCYlRQT3B6SGcwb3M1d05I?=
 =?utf-8?B?N3BaZzkvYnpJcTlOU0h5OGtnQnNROTJwYVV1YUJhb3puMFp6bHJab0JMUWR6?=
 =?utf-8?B?ZHdOd0dFWXJBeWhKbFZ0RHlwQVg5eDlSZDg5dmJPZFllTThsY2NlbW1zMGU4?=
 =?utf-8?B?S0UxdnkwY05lZDl1cXNlVDNxVzVVMGJWS0VhdUZ3RWExdmZoZ2dmWmppcHAv?=
 =?utf-8?B?WmpqMm1XMVF4TVp5SzRuVDh4QXA5VENUcGRiTmhHS29CNkkvbk9QWGdjM2ox?=
 =?utf-8?B?L2w1MmFUU2FQbDFuVDg1bURPYjZ4WjVYWUpyZFlZL0U1eHl3Y2REbVZMR2RJ?=
 =?utf-8?B?VnVlMXpZaXlMTkFKMGw0SHdta2lNWjdza0lEUHVEUmJxdHVlKzhJVmtPdXpC?=
 =?utf-8?B?d2FmV3ZYTXJGQWl5UVBqMDNEL0YwSGpPSnRHd0RGVW9FelcvN2xCNTdMNnIr?=
 =?utf-8?B?bHcvQmhlRlhMWDJxNi90a2pMcUV0VTFld3o4K3VRZmY5czE4NHhUM1JOMjZI?=
 =?utf-8?B?UnFtM3d2dDBzTTh0QUJCemsyQ21rVlBXMWF6MzZnUFJuMDR3aVB5OFpoWW9u?=
 =?utf-8?B?LzFoc3E4N3ljZFIvZnU1d0g0WGZTcy9IdHdiM0kvVnZrWGFTVlExTXNDaS9y?=
 =?utf-8?B?VE1jckM4cUtjZDRLb1NlK09vQ0pBYWdTUmFVRDhiNTlOL2hGQ2hUemhzRCtp?=
 =?utf-8?B?S21GSDNiNXBBMktEN1hVQjZvbGpmbE1IL1pjTndEWDhTVjFvZ2ZZb0RIMkRM?=
 =?utf-8?B?RElpd0o2RUtKekl3bXhQbVpZdmtCZU1CdlNaQ08wOVJmTS9VQ2d5Tzdza2dV?=
 =?utf-8?B?WU5laGRqbE5KYjlkUjhzMnFHSzFucGNGOGdycUNBOUNObk9BS1NaYTJMd204?=
 =?utf-8?B?a1BhY042Q0d6Z1JYL052djBOTDBVN01zMUNPNmlEQ0dCNkMySG9GQUpoWnh2?=
 =?utf-8?B?TStZeEQ5Zjd4RVl4czRHbWxJS0ozYUMwVWZOWndvSkFQZnN4VStxQXVJbzRK?=
 =?utf-8?B?Qk12aGNiVWNFUGhtOFFBc3huSUthaWtxeVdBblRadVJiRmNLRTZWOXBZaVJY?=
 =?utf-8?B?dDlvTE5UTFZXMHlJQ083c0tSOXRyMkJ0S21IakthRXB6UE1xamNtc2dIMEVn?=
 =?utf-8?B?Qnp3TEd2WlEwQU9hZSsyazlRMi9wZk4yNnhrd1VxZDlqZzkxdU1NaWtPelIr?=
 =?utf-8?B?NVpIU3JIZStNQnp4L2h2empHQjJVMC9XNlQ3NStZekkvUi84RGoyWVBuNDBz?=
 =?utf-8?B?aVdvdXgzK2Z6UFNrVjJRUjc3dVBEcm1YZVZOaHQwZXdIMTBPN003L084TUpy?=
 =?utf-8?B?WnFSd0w2TjY5TTRSVlJtWlo2Wk01UEFsWERxZGJTU3Q5VWRJT0hmM3Y4bEdI?=
 =?utf-8?B?amk1OU56M0NzQStVWnovbVRmUGlLcncvNjFzOFptekQvcTl2Z0hBajdrYkpt?=
 =?utf-8?B?WWlZc09VTURFbm95MGcyOTVldFV2K0JlN2c0UUgyOXA1ZjdUc0NvMDlHbzhJ?=
 =?utf-8?B?ZDgzWlE1R3hHaUZHRTd6L0pFRVFLVnUyT0JmcExmNnIzMU8xU25uN3lKcVo2?=
 =?utf-8?Q?O+NSfUmJpClguVin4WOr54o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <50FFA9251770424F8D0B84BB0E7923A9@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe2d393-8ef6-4dec-3c9b-08dbf5838a7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 11:15:51.5614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9+M6QUw5nnQvtk5jENTRHF0EpkBpqWaK0Y+O10P6bMndaxsYnN9HME0bL50Z7R7QtxZplhOkV9bfl1zcOhwwe0YGoPFNSuDX+4lLsqKsfSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3124
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG9uYWxkLCBTYXJhaCBldCBhbCwNCg0KdGhhbmtzIGZvciB0aGUgcGF0Y2ghDQoNCk9uIE1v
biwgMjAyMy0xMi0wNCBhdCAxMjoxNSArMDAwMCwgRG9uYWxkIFJvYnNvbiB3cm90ZToNCj4gRnJv
bTogU2FyYWggV2Fsa2VyIDxzYXJhaC53YWxrZXJAaW1ndGVjLmNvbT4NCj4gDQo+IEFkZCB0aGUg
U2VyaWVzIEFYRSBHUFUgbm9kZSB0byB0aGUgQU02MiBkZXZpY2UgdHJlZS4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IFNhcmFoIFdhbGtlciA8c2FyYWgud2Fsa2VyQGltZ3RlYy5jb20+DQo+IFNpZ25l
ZC1vZmYtYnk6IERvbmFsZCBSb2Jzb24gPGRvbmFsZC5yb2Jzb25AaW1ndGVjLmNvbT4NCg0KcG93
ZXJ2ciBmZDAwMDAwLmdwdTogW2RybV0gbG9hZGVkIGZpcm13YXJlIHBvd2VydnIvcm9ndWVfMzMu
MTUuMTEuM192MS5mdw0KcG93ZXJ2ciBmZDAwMDAwLmdwdTogW2RybV0gRlcgdmVyc2lvbiB2MS4w
IChidWlsZCA2NTAzNzI1IE9TKQ0KW2RybV0gSW5pdGlhbGl6ZWQgcG93ZXJ2ciAxLjAuMCAyMDIz
MDkwNCBmb3IgZmQwMDAwMC5ncHUgb24gbWlub3IgMA0KDQpJbiBnZW5lcmFsIGl0IGFsbG93cyB0
aGUgZHJpdmVyIHRvIGJlIHByb2JlZCBvbiBUSSBBTTYyNSBFSywgc28NClRlc3RlZC1ieTogQWxl
eGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQoNCkJ1dCBJ
J20gbm90IHN1cmUgaWYgeW91IG1heWJlIHdhbnQgdG8gZGlzYWJsZSBpdCBieSBkZWZhdWx0IGxp
a2UNCm90aGVyIEhXIGJsb2NrcyBmb3IgdGhlIChwb3RlbnRpYWwpIGJvYXJkcyB3aGljaCBkb24n
dCBoYXZlIHZpZGVvIGF0IGFsbC4NCg0KPiAtLS0NCj4gwqBhcmNoL2FybTY0L2Jvb3QvZHRzL3Rp
L2szLWFtNjItbWFpbi5kdHNpIHwgOSArKysrKysrKysNCj4gwqAxIGZpbGUgY2hhbmdlZCwgOSBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy90aS9r
My1hbTYyLW1haW4uZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02Mi1tYWluLmR0
c2kNCj4gaW5kZXggZTVjNjRjODZkMWQ1Li40MzM4ZmQ4YWIyZDcgMTAwNjQ0DQo+IC0tLSBhL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02Mi1tYWluLmR0c2kNCj4gKysrIGIvYXJjaC9hcm02
NC9ib290L2R0cy90aS9rMy1hbTYyLW1haW4uZHRzaQ0KPiBAQCAtOTY1LDQgKzk2NSwxMyBAQCBt
Y2FzcDI6IGF1ZGlvLWNvbnRyb2xsZXJAMmIyMDAwMCB7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcG93ZXItZG9tYWlucyA9IDwmazNfcGRzIDE5MiBUSV9TQ0lfUERfRVhDTFVT
SVZFPjsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdGF0dXMgPSAiZGlzYWJs
ZWQiOw0KPiDCoMKgwqDCoMKgwqDCoMKgfTsNCj4gKw0KPiArwqDCoMKgwqDCoMKgwqBncHU6IGdw
dUBmZDAwMDAwIHsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBhdGlibGUg
PSAidGksYW02Mi1ncHUiLCAiaW1nLGltZy1heGUiOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmVnID0gPDB4MDAgMHgwZmQwMDAwMCAweDAwIDB4MjAwMDA+Ow0KPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY2xvY2tzID0gPCZrM19jbGtzIDE4NyAwPjsNCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNsb2NrLW5hbWVzID0gImNvcmUiOw0KPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDg2IElSUV9U
WVBFX0xFVkVMX0hJR0g+Ow0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcG93ZXIt
ZG9tYWlucyA9IDwmazNfcGRzIDE4NyBUSV9TQ0lfUERfRVhDTFVTSVZFPjsNCj4gK8KgwqDCoMKg
wqDCoMKgfTsNCj4gwqB9Ow0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0K
d3d3LnNpZW1lbnMuY29tDQo=

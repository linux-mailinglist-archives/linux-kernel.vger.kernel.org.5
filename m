Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE1C79A35C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbjIKGNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjIKGNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:13:19 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816F2109;
        Sun, 10 Sep 2023 23:13:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlmQ2qaslK3bDC39zONkYQR56IiKSH8Iq/VzVSOgeEvgY84oBHV7bGHfurafpc6zYuBmIFFzqDdd6+PGCNTQUhP1+O0WX09z69HKwWnpKldJ2rzMOZyVU2sARNA6Fi2y/hGYDQWN2oaDl0c9yvM4XZHpHOjwyaG2OraxNskP4dJGM/rY9V8DZAJu4iW1HEaUCF7G7p7ilO8METEQs00RQGC+cGQ3h1mzTYPTyqolM3nk6vCxcGiqu+nlNihoJ4zUIhatfWMteBCzykGpfUR0dHmIZzQx9xGLSNa1tdGE9qVn7AJ0tbCE260Ma3rmQ6SmGjSRbGYgsnZ6zmWIzhZ0zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJn4TUkzxncq4pztfFZ/E9OC/mpuNSanmmxwfU+Y/9s=;
 b=hncf+XoHZj/PYA0jMzJFwQ42lpmkW/i61/hueSt0UoPgNHilPSqCVtiFDorXXWJdJ7csuPCsWOa4NtOdCVQVOKt2azkTHOi3iAcN1H5KsO7EmlwFPYGcfe5NgUsBzUaZLJ/NB+5hufPVc9FG61SGoXS6+akp3Z+LhKn1PhGmeNhdaaKjXqehTc7xIXA+hGbTid8yZc3OmGRWHnom5Azpv6BFX9dSKSCplrvM4UJbYHM5ugsHhZoSueOzPKPyoeM0YpVY3+3P0TNpmf6OVxDBPglOV1vZp5oNs8rkMJd/M39npOAaWU3MGbdLrsQCMp1ThBrp3vgo7XdPqyRpbWQQ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJn4TUkzxncq4pztfFZ/E9OC/mpuNSanmmxwfU+Y/9s=;
 b=RA8rKcBrLfE53/LOQbQlVX/7urQ/AoPfE8UjXfYzRc+UwMNi077KpcajoQrYDsVeTfxXXvKK9jz2rN24xLwJ4GCY6CNiyeku213ObzPhmd8THwyHFjgCywftYDLBBTIoYAMvHLtMUUdcSqk/IqvitCi+ax271XYap/xHMcC5Lv8=
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8)
 by PA4PR04MB8016.eurprd04.prod.outlook.com (2603:10a6:102:cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 06:13:10 +0000
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d]) by DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d%7]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 06:13:09 +0000
From:   Hui Fang <hui.fang@nxp.com>
To:     Tomasz Figa <tfiga@chromium.org>
CC:     Anle Pan <anle.pan@nxp.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jindong Yue <jindong.yue@nxp.com>,
        Xuegang Liu <xuegang.liu@nxp.com>
Subject: RE: [EXT] Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment
 size
Thread-Topic: [EXT] Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment
 size
Thread-Index: AQHZ2UI/RGKEIcG6sEyAOrT4GOix9LACiU/wgAAMzoCAB7BFoIABXXYAgAHcP6CAABZdgIAHn6dg
Date:   Mon, 11 Sep 2023 06:13:09 +0000
Message-ID: <DB9PR04MB9284A45033B3E24F44C5AA3987F2A@DB9PR04MB9284.eurprd04.prod.outlook.com>
References: <20230828075420.2009568-1-anle.pan@nxp.com>
 <DB9PR04MB9284AA58AA71655C9C0C7C9A87E6A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5DYxwX+JdXQ_-ba5B9y+gyWPjvUpCBnKM1zz1W2EkO_vA@mail.gmail.com>
 <DB9PR04MB928460023FB3CCCBC3EACE1487E9A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5BGJX7=Z1ukFRq_ktaQ0d7FbvV-ob5gs8hfGaNHUXPTww@mail.gmail.com>
 <DB9PR04MB9284A0CDB1FC7CAADE0A394F87EFA@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5AugUGh7Z=9Qh7SS4=-0ddGBmRAOOyCGDfPdT-=eurtUg@mail.gmail.com>
In-Reply-To: <CAAFQd5AugUGh7Z=9Qh7SS4=-0ddGBmRAOOyCGDfPdT-=eurtUg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9284:EE_|PA4PR04MB8016:EE_
x-ms-office365-filtering-correlation-id: ac7599f3-887d-495a-57cf-08dbb28e2c24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H+aSHOmhEtYH+9E48FwOkqN9wwvWRG4QeDbwhDQQeh6QT8EBAb5kfqlfEdk2rHHqZfGEDguy0XcBo/8ZGYhEnpBpTPUTi1Yq4yTzteh7EJfox18IgkXDeqCcBcts6W+l2B0eAhtbhlrXhnbP39GdgBHCfZA/Ha4avlgh5zCG5A2LkBy+QQY3K95DcXVOW0cO4Oa9QCRxW4Wr/MXQPMWHfMZU3jbNB5s9CG9rNf4ecTgLAH9kdFdXHbAwXzcBdmBBOCuG6Pl2q9S1RhfHgdItpKmxrQaKY0ot+QXVtxbbGsVqIJVW7dFuTZM+7bqD10EfYh2DkWkRMo4BTFPRisJNfUd/nZKO088FRukuAgQBwRkDBMveEHpPIi3GcTa6S03h9r4DgbrATRAF/AgAjySGV2GP7iYuUb5b7bpVr4AH52kvuisS13Sh/4dWHR50qcxEBZxGQ0UKIJkMFzDxJFZGBTM9mOf7AvagfXWpSQi0ftMADXY3Ifd2Y2GyMK9P3Kgxdr3cOFtpLh9vW0W+Xk0nDxe2ta1XpFBMXle5cVgZEQX3D/5/c5IjruOlP0YxAjQgTA8smM1dUdC8EciRwU9bhnzr2CxIF+xUmgZaWHpV7J8BiP41CgI2qRmODRBxzwFo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199024)(186009)(1800799009)(2906002)(44832011)(52536014)(26005)(55016003)(6916009)(41300700001)(316002)(66446008)(66556008)(54906003)(64756008)(66476007)(66946007)(76116006)(478600001)(4326008)(8936002)(8676002)(5660300002)(53546011)(7696005)(6506007)(9686003)(71200400001)(83380400001)(38070700005)(33656002)(38100700002)(86362001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGlGMUdSTHVlR1B0M0lDMWJiY05UbmlURmRvcHBKTWQ1bytoUHp6K0R3bzA2?=
 =?utf-8?B?VVoyditJbGtBc2N6ckVzYXhBaFpad0lHc0c3SjBoQWQ1MGtSMERFU1Q1aFpr?=
 =?utf-8?B?NkNrK0VTcDY5UW5BZ3hyRWRsS2VrcU5rV2tnQWJ6OURiK1BIcjhRZUxPbFVI?=
 =?utf-8?B?NGtHMnJDOTBFZ1FPdlFSOU5KdDdzS0R2SDRRallZTkhmdWl1Y3RGNmcxR2l0?=
 =?utf-8?B?MkZiVTIvV0JEdUFkTyt4M1ZhY1E4ZkdKa01BZ2N2Y291aWFPNWFMalNxWHVp?=
 =?utf-8?B?RGxOV2I2SklyVWxlT3VQSVkrVWhHUkRnMEdCOG1nRE9zNzJycmFkWWswKzFF?=
 =?utf-8?B?SkRPZFkvblJnYzFJa1ZORWJrbWM4VE9GYXFwMmV5OTlOcFZGMUxzSjI3TlJH?=
 =?utf-8?B?dnJaNzRFMC82TFNFWlV2Wk0vQjgwNUhReTVMN2NhN3A0UkhMVThuN3orUDMr?=
 =?utf-8?B?U0ZuZ2RVVVVGSldCbGRPeUVuSiszZ2RmQ2MvT3Y4aEpMY2lJRUU1OGVrYmxV?=
 =?utf-8?B?WEZNUXFWL3BRc0l0bkl1OGVoN3lvZGdkcnNOVk52OENhUE9hcWp4TUZlK3Bs?=
 =?utf-8?B?eW9wRUZUTFpRZFVDaHJoZEl4MjI5RXpSQlFybURETzhqQThSNmo3TzlobllN?=
 =?utf-8?B?bDNzN0Q1SkdoSnptZHVranhoVmxlTHlHNHEwVHFTcG1sSGxxNDJmTGsxMkFa?=
 =?utf-8?B?Y0k5Njc3UklCT2R3YTdCYm1mN01tTFdJL0hpcDJZZm1lR1RSUUF0dE50WERX?=
 =?utf-8?B?Nys4MGQyV2dwQ0tCQm1IVEdKdFFuam80dWpvRURVVGFSVVhqUjI4ME4yaG5C?=
 =?utf-8?B?bEpDNkdoV3d2TTlua3lQWXFDZzFkVHhucWpaQ2hLbUdoaUJVd0ZVTjBDRkUy?=
 =?utf-8?B?TmZzR0h6T09ucXVOMEZ3bE12dHFRNTQxdi93Tzd6SnV3VCs5MVFDdFlJZWZL?=
 =?utf-8?B?dEJTMGRZY0FuZFFHdnlMM0ppdlowTHFFSnFaWnowblpLRzJYQXNOa3pQdzQ2?=
 =?utf-8?B?b3ZJOUZIUFN1M29xUzZiRGRzT254aFhVaUJ6VzJuU1pQQmhXRE55Z3AzUVR1?=
 =?utf-8?B?VXhkcUd2ekRLak9lZHg4d1ZCYjlGNXN2b1pHV3Q2bk02a25hWU9vbDNyOEJq?=
 =?utf-8?B?a2hQcTc2SURxNHRtMFNLSEROZGpwV0xKN1NKR3V0dHVrQmhGWTlTUWFEbG5l?=
 =?utf-8?B?VDcrL3R3cDJ2WmpMZ3ZvWEN5dXZEK1dnZ0lzQXd2Z2VacVRvQzNMRkl5UjhP?=
 =?utf-8?B?bGJSQ0xlTTdwWVh2cTFraEVhdDMra0orYnY2ZGhnY05OYWs1QUVZNVBXMVhK?=
 =?utf-8?B?cWZLUGR1c0ZVaVRSVkhNakkxVUV0NWloZGZhOG5EeGFyd2NJT1RJWEpzY0NS?=
 =?utf-8?B?Sm1IOGdmTXY0TmRYVHlpbS9YVGxjNTZORW9sZVN6YUYrWFRabnk1QmlRQnow?=
 =?utf-8?B?UUdRWE1VNmR2SkVOWkh6ZmtqYXJMUVNyTW5WVyt4WmlDWUZyWmdmcCtDaEhL?=
 =?utf-8?B?WStCMDNZUllCMHFMeFp1TzFvQmNaOHBYbUxtWW14V3hvZ09xa0dFUllPeStY?=
 =?utf-8?B?QjYrSEN0WUxnYWFMcElxYlBWOWVWM1BoYkpTZDdCRWwvZzJKY3V6blc4QjQx?=
 =?utf-8?B?MVpqSC9lYVJpY1FQRDNZZ1ZmNHduMmwydDEvMTE4L2lvM2N1Z2pWaU52TnRp?=
 =?utf-8?B?UmpMUUVqZldhMGU5czV3MkNtaTFtT3JvWjZsWWpRV2dhQW1JdS9pZzJIY1h0?=
 =?utf-8?B?eHBocU81N1pLMys4YUFET0JwRDdkNTN3SzNvRUZiRC9lNTBwcXlCY0g1OEZS?=
 =?utf-8?B?eXNUUkc3d0s0eklsa0J2QTVhTWl2SEtlaDhXVVZXdTRhNjZ1aWhpbm9JdkxZ?=
 =?utf-8?B?RlhPVlcySDdBMUxZYm8zS0tKWXNjMngrSld4MW81TGcvRSsxVElwTi9XUlRC?=
 =?utf-8?B?UktXMFFxVUZkRDVBR29FYm02Z0EvaHBFd3F0RUQ1dU1VRnc0bmV4TTl6dllR?=
 =?utf-8?B?VmlwRmRCV2hWOCt3TFM2L3V4QlJQSktFK284ZmpscnNoNGZMZzFTUlYvaS9I?=
 =?utf-8?B?Qk5iSWhJb3luSmV0VG5jV0xzT3k2aVZ4MnRGQVBHUTBPU1JEUVJibjBmYXhB?=
 =?utf-8?Q?V1/M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7599f3-887d-495a-57cf-08dbb28e2c24
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 06:13:09.8481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hgF9D+7zVuZY1yDDHgydRKhJjR5X10tEb1lcf3b/Bw7LsAYAePD2wTOwQUAj/O5+1aiPvVBS7ng0eguyhmuC+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8016
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBTZXAgNiwgMjAyMyBhdCAxODoyOOKAr1BNIFRvbWFzeiBGaWdhIDx0ZmlnYUBjaHJv
bWl1bS5vcmc+IHdyb3RlOg0KPiBUaGF0IGFsbCBtYWtlcyBzZW5zZSwgYnV0IGl0IHN0aWxsIGRv
ZXNuJ3QgYW5zd2VyIHRoZSByZWFsIHF1ZXN0aW9uIG9uIHdoeQ0KPiBzd2lvdGxiIGVuZHMgdXAg
YmVpbmcgdXNlZC4gSSB0aGluayB5b3UgbWF5IHdhbnQgdG8gdHJhY2Ugd2hhdCBoYXBwZW5zIGlu
DQo+IHRoZSBETUEgbWFwcGluZyBvcHMgaW1wbGVtZW50YXRpb24gb24geW91ciBzeXN0ZW0gY2F1
c2luZyBpdCB0byB1c2UNCj4gc3dpb3RsYi4NCg0KQWRkIGxvZyBhbmQgZmVlZCBpbnZhbGlkIGRh
dGEgdG8gbG93IGJ1ZmZlciBvbiBwdXJwb3NlLA0KaXQncyBjb25maXJtZWQgdGhhdCBzd2lvdGxi
IGlzIGFjdHVhbGx5IHVzZWQuDQoNCkdvdCBsb2cgYXMNCiJbICA4NDYuNTcwMjcxXVsgIFQxMzhd
IHNvZnR3YXJlIElPIFRMQjogPT09PSBzd2lvdGxiX2JvdW5jZTogRE1BX1RPX0RFVklDRSwNCiBk
c3QgMDAwMDAwMDA0NTg5ZmEzOCwgc3JjIDAwMDAwMDAwYzZkN2U4ZDgsIHNyY1BoeSA1NTA0MTM5
MjY0LCBzaXplIDQwOTYiLg0KDQoiIHNyY1BoeSA1NTA0MTM5MjY0IiBpcyBsYXJnZXIgdGhhbiA0
RyAoOG1wIGhhcyBEUkFNIG92ZXIgNUcpLg0KQW5kICJDT05GSUdfWk9ORV9ETUEzMj15IiBpbiBr
ZXJuZWwgY29uZmlnLCBzbyBzd2lvdGxiIHN0YXRpYyBpcyB1c2VkLg0KQWxzbywgdGhlIGhvc3Qg
KHdpbjEwKSBzaWRlIGNhbid0IGdldCB2YWxpZCBpbWFnZS4NCg0KQ29kZSBhcyBiZWxvdy4NCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL2NvbW1vbi92aWRlb2J1ZjIvdmlkZW9idWYyLWRtYS1z
Zy5jIGIvZHJpdmVycy9tZWRpYS9jb21tb24vdmlkZW9idWYyL3ZpZGVvYnVmMi1kbWEtc2cuYw0K
aW5kZXggN2Y4M2E4NmU2ODEwLi5kZTAzNzA0Y2U2OTUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL21l
ZGlhL2NvbW1vbi92aWRlb2J1ZjIvdmlkZW9idWYyLWRtYS1zZy5jDQorKysgYi9kcml2ZXJzL21l
ZGlhL2NvbW1vbi92aWRlb2J1ZjIvdmlkZW9idWYyLWRtYS1zZy5jDQpAQCAtOTgsNiArOTgsNyBA
QCBzdGF0aWMgaW50IHZiMl9kbWFfc2dfYWxsb2NfY29tcGFjdGVkKHN0cnVjdCB2YjJfZG1hX3Nn
X2J1ZiAqYnVmLA0KICAgICAgICByZXR1cm4gMDsNCiB9DQogDQorYm9vbCBnX3Y0bDIgPSBmYWxz
ZTsNCiBzdGF0aWMgdm9pZCAqdmIyX2RtYV9zZ19hbGxvYyhzdHJ1Y3QgdmIyX2J1ZmZlciAqdmIs
IHN0cnVjdCBkZXZpY2UgKmRldiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2ln
bmVkIGxvbmcgc2l6ZSkNCiB7DQpAQCAtMTQ0LDYgKzE0NSw3IEBAIHN0YXRpYyB2b2lkICp2YjJf
ZG1hX3NnX2FsbG9jKHN0cnVjdCB2YjJfYnVmZmVyICp2Yiwgc3RydWN0IGRldmljZSAqZGV2LA0K
ICAgICAgICBpZiAocmV0KQ0KICAgICAgICAgICAgICAgIGdvdG8gZmFpbF90YWJsZV9hbGxvYzsN
CiANCisgICAgICAgZ192NGwyID0gdHJ1ZTsNCiAgICAgICAgcHJfaW5mbygiPT09PSB2YjJfZG1h
X3NnX2FsbG9jLCBjYWxsIHNnX2FsbG9jX3RhYmxlX2Zyb21fcGFnZXNfc2VnbWVudCwNCgkJCXNp
emUgJWQsIG1heF9zZWdtZW50ICVkXG4iLCAoaW50KXNpemUsIChpbnQpbWF4X3NlZ21lbnQpOw0K
ZGlmZiAtLWdpdCBhL2tlcm5lbC9kbWEvc3dpb3RsYi5jIGIva2VybmVsL2RtYS9zd2lvdGxiLmMN
CmluZGV4IGRhYzAxYWNlMDNhMC4uYTJjZGE2NDZhMDJmIDEwMDY0NA0KLS0tIGEva2VybmVsL2Rt
YS9zd2lvdGxiLmMNCisrKyBiL2tlcm5lbC9kbWEvc3dpb3RsYi5jDQpAQCAtNTIzLDYgKzUyMyw3
IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgc3dpb3RsYl9hbGlnbl9vZmZzZXQoc3RydWN0IGRldmlj
ZSAqZGV2LCB1NjQgYWRkcikNCiAgICAgICAgcmV0dXJuIGFkZHIgJiBkbWFfZ2V0X21pbl9hbGln
bl9tYXNrKGRldikgJiAoSU9fVExCX1NJWkUgLSAxKTsNCiB9DQogDQorZXh0ZXJuIGJvb2wgZ192
NGwyOw0KIC8qDQogICogQm91bmNlOiBjb3B5IHRoZSBzd2lvdGxiIGJ1ZmZlciBmcm9tIG9yIGJh
Y2sgdG8gdGhlIG9yaWdpbmFsIGRtYSBsb2NhdGlvbg0KICAqLw0KQEAgLTU5MSw4ICs1OTIsMTkg
QEAgc3RhdGljIHZvaWQgc3dpb3RsYl9ib3VuY2Uoc3RydWN0IGRldmljZSAqZGV2LCBwaHlzX2Fk
ZHJfdCB0bGJfYWRkciwgc2l6ZV90IHNpemUNCiAgICAgICAgICAgICAgICB9DQogICAgICAgIH0g
ZWxzZSBpZiAoZGlyID09IERNQV9UT19ERVZJQ0UpIHsNCiAgICAgICAgICAgICAgICBtZW1jcHko
dmFkZHIsIHBoeXNfdG9fdmlydChvcmlnX2FkZHIpLCBzaXplKTsNCisgICAgICAgICAgICAgICBp
ZiAoZ192NGwyKSB7DQorICAgICAgICAgICAgICAgICAgICAgICBzdGF0aWMgdW5zaWduZWQgY2hh
ciB2YWw7DQorICAgICAgICAgICAgICAgICAgICAgICB2YWwrKzsNCisgICAgICAgICAgICAgICAg
ICAgICAgIG1lbXNldCh2YWRkciwgdmFsLCBzaXplKTsNCisNCisgICAgICAgICAgICAgICAgICAg
ICAgIHByX2luZm8oIj09PT14eCAlczogRE1BX1RPX0RFVklDRSwgZHN0ICVwLCBzcmMgJXAsIHNy
Y1BoeSAlbGx1LCBzaXplICV6dVxuIiwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
X19mdW5jX18sIHZhZGRyLCBwaHlzX3RvX3ZpcnQob3JpZ19hZGRyKSwgb3JpZ19hZGRyLCBzaXpl
KTsNCisgICAgICAgICAgICAgICB9DQogICAgICAgIH0gZWxzZSB7DQogICAgICAgICAgICAgICAg
bWVtY3B5KHBoeXNfdG9fdmlydChvcmlnX2FkZHIpLCB2YWRkciwgc2l6ZSk7DQogICAgICAgIH0N
CiB9DQoNCg0KQlJzLA0KRmFuZyBIdWkNCg0K

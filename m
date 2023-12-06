Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E038074ED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378170AbjLFQ3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378184AbjLFQ3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:29:10 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2097.outbound.protection.outlook.com [40.107.114.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15B6D4F;
        Wed,  6 Dec 2023 08:29:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RP5gC9wug/ACyrBugSIKzUYERY/6IibfGVWzxAutprVYkDUpNcqm8T3OaigBBrpi7llbqDfdCyVs35XQZSVq1Db5iD+GtDbcGxr79DXu6+3FIk+9Z5lENReGMiKphjJJtaY075uPHHfQ6lhNU7VTt2zalKLtBqy07Mav0cm4omeO6RTseqCp3kLXJm2BRNQkuX+8unelIcCBjSs5S8Kk/HYD+rPxBbuM3SQKfwqzbPsEvHFNxe5Wy+V1xNf8ZZ+z+XLVYQluzO8K4V2K8dxMYJ6c+2S5M67lZ2PQvAPEQvEPogIgpro3iMduiSj04cZ+a/Rw823jXUZFD0aGGPlEvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9Hin2/BnpaJ46u9T7WBEJK+aaQ75UmL9c2X9/GBuSA=;
 b=f1c/PCX7CiFv7GEQ7vDfyC2qmATVvom4AYiLoztCIAlYX41I/vux39fbcflSiaQ8vwVaVy5emjVLnfmsTSSUI0kQK1FsxT0TOT2if/SDUkLqBwtT3rdYUkraaeJRmohjpl7+MXIPbFVRw6Od5Ai4Vq03KIXAOx+zGJpE+FFT5b73vvA2az0sfF5AMYfCAFI5ZmL1GEyQ5tU9PeW+xY0TWVME/HPkmCOmyNaKGLeRh+IIRlU4+VgJSczhoMmWgoO5qxy/G+amul278Tm0tcTkM+pRgJu5D6m/b9SoOe3TUPFrSl5rvXDjcAbmDAiD9WO6037QWwHkAaTxmLwvmelfnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9Hin2/BnpaJ46u9T7WBEJK+aaQ75UmL9c2X9/GBuSA=;
 b=gCiWLvokN7oniqnZOaYRrV2sUdaiQR7LCsI4IRGKXVZC3pEn/o6wQfEGwyD37m554rqe6OejeyuDlVgqPkzJZ87LcKONkgFx0cAuL6c9rQAddDpydFYX7CDGt0ASlWBlFvY4+cM/SOpqoyQpYwjhFawgHbfcpuGSeu0ZluGETVo=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by OS3PR01MB9771.jpnprd01.prod.outlook.com (2603:1096:604:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 16:29:11 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::74da:640b:b793:14df]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::74da:640b:b793:14df%4]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 16:29:09 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Min Li <lnimi@hotmail.com>
CC:     "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "lee@kernel.org" <lee@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v6 1/6] ptp: clockmatrix: support 32-bit address
 space
Thread-Topic: [PATCH net-next v6 1/6] ptp: clockmatrix: support 32-bit address
 space
Thread-Index: AQHaI72WxBSXocJ/XESZT6513Vz+TbCacjaAgAABPgCAAgSWEA==
Date:   Wed, 6 Dec 2023 16:29:09 +0000
Message-ID: <OS3PR01MB6593B50F4C5BF3687EE3FA97BA84A@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <PH7PR03MB70644CE21E835B48799F3EB3A082A@PH7PR03MB7064.namprd03.prod.outlook.com>
         <20231205092429.GS50400@kernel.org>
 <d657f059d384419fe4df02580a4af9cf69e0e9c2.camel@redhat.com>
In-Reply-To: <d657f059d384419fe4df02580a4af9cf69e0e9c2.camel@redhat.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6593:EE_|OS3PR01MB9771:EE_
x-ms-office365-filtering-correlation-id: 737cf463-35c3-4452-ae7b-08dbf6787948
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IFQItaAvbTZV1SOK+hVou+viWXO88XzPmXT5tNAU3UqcHOyYlw2CgA1fv2pc7U87kItBPCJOkA9cXuTnBAdBJsRW/JCHhO1y7G+01XXAMUZHfJfqYdBnRn+cORa+cPczQEOC9I3oLsCzOVXeKrQKTXpLEhK9dygKd4jLvuitiaXRo6IadEKfH6M3XKlsGERAmKAX432V1byd8IIuX3kRzWxXV5ihvK+aZceYjhGE7gmf8rvB71m4E5Jr/YQKtoTF6lEqYiwUYXp0P/qGyDTLYJ5bxJ2d0F8o7o3BLMcdLyi378Bit7yEnhhwe55tDDNQ1Cs57qWTNRGAPCuA5d8QhgPhY6AnQezr5LiYa4vnWLS7m46sL0cC3vsZvl5dql8TXpla0wWyledqwbTm7o6g9Ri1RJEsDyp7DGcfwY+OtTz/T79QAQF1Nk7eQZcNPZtNKcB1Ex+Jy4AbQWorbVnOLzxaw76vfRiqQ406sQYmcPV1j5BATtOIqQVJNRzVrYwECJ/gsj0iZ5UziaMN+1d/GhscxPu+TgrNidgz0uBxWR8m1LDyyK7BaurfQlciGWAcRH2aAPIbquMDx5KN4LA/nL73Pbd4VpNYVMGZ2fezC6muVH4f92L9yUsqA9oCJ88Z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(366004)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(478600001)(9686003)(86362001)(71200400001)(7696005)(8936002)(66476007)(76116006)(66556008)(110136005)(66899024)(316002)(54906003)(8676002)(66446008)(4326008)(64756008)(6506007)(66946007)(52536014)(38070700009)(55016003)(122000001)(83380400001)(41300700001)(38100700002)(33656002)(2906002)(5660300002)(26005)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmVHaVRpUS9PQVZoNWpZRW9MSG5HcVB5MEM0TXRtM2x3dU9HN1ljeDBqa0tC?=
 =?utf-8?B?b0JJdFhXNDluUzA0c3JydUhSL3hGYVBLcDVadjY1N2pJOWlRSUpTNHlHSCtM?=
 =?utf-8?B?K2c2bDRycldCOExJZGJ3cStjZmpqTS9vQklYUlo0bDgySjYzaW0xK2cyYVFR?=
 =?utf-8?B?VmpnNVp2Y2JqZnhBM3NTZjJNbVJyeERLYmZDdkloTU4xdW1ySThPMmxsL2tR?=
 =?utf-8?B?ZWxzeE56ajFNcWhORjhsSzVhUXNWTFIycUpHNjdrakx1VDYwZm5OQ0tCR1Yx?=
 =?utf-8?B?S043Q3gyNVJpcHdLZUlPSVMzYXoyTGV4RzZEczdjejdmYVJHTWNzV1JaQkpX?=
 =?utf-8?B?R1dzd1hOSXUyaGpPMXJRSENBR2dBcWgvUWI2WmFHYW1EQWswaUJYeGFRWmdD?=
 =?utf-8?B?YW9GdXRQMDNNNnZMWG1Rc2ViWHNpZzdTZW5tS2o4UmF6UU44K1FkNGJjNEVr?=
 =?utf-8?B?TDcrZ1BuL205Z3FHZUYzV0VFd1c3dFJia2VKbXY5MFhPQ050cDF2RUNpbDl1?=
 =?utf-8?B?emJKUVVqY3AzT0Noem51ZFdGZkVqOGdndDUvUDFwRjZaT0FGRWZ4d1lOLy9L?=
 =?utf-8?B?RVJaMW9hVjNWbjU3NldQbHhZaGJoNXdmNnI5aEp3WVJ0N2hBVFdvdmZMZEFa?=
 =?utf-8?B?a0RydTZyQ3NENFpxaVl1Zk9Rb256VFl4OC9oa3dHYm5xanhBZHJnT2lLYnpI?=
 =?utf-8?B?S0hFUWpucXNIcHNJQzcwWk5GZVpHYWRrckFOTkZJY1RicDlLemtjeFZLeXRV?=
 =?utf-8?B?UWM3TjdGbFlKZkdyNEtrblFuSVEvNWRuTlZSYmNZbmMvZnZNaEE4QTg1S2Rv?=
 =?utf-8?B?TkpkdnNNaHNPVThZcmV4Nm5Zak5haTJEd0QveXZ6V2lFTS9uSUV4WXhHSmxi?=
 =?utf-8?B?ZTVyWTV3cU5WU1VQYk0xajVPZG9HNnlVZEdVczE5NjJ1aWdLVFdkdXo3Vktq?=
 =?utf-8?B?bERIZ2pOTE1UK0VCY3R6eXBhRkpZaGxPRHUxRW1IY3lXNUNMam50cWNpU3Zs?=
 =?utf-8?B?dS8xZXhHRVg2MVlFQTlBRGtHZlU5MTdrbXcvQk9wRjZpblZtT3ptZFhSaUdn?=
 =?utf-8?B?TWRpRHpPeWZLMi9RTEZGem01dDF4M3lUcTFZSWxnbG82R2Mrd3grNkl2SUNI?=
 =?utf-8?B?dGdMRXhDNHNhWUR3ZmRUTXZ3S3hDTU9jWmVXKy9UN0JwTDBEVXpSb0oxOTc0?=
 =?utf-8?B?L0sxOW1UdHVMY2ZodWNvdk1sMkZqVTRlNndQbk84eTRQWnZyRURIdkNHSTVk?=
 =?utf-8?B?bjVLdEJYUVRzaTVCaTBvTGthZHg2WVFMMVRlcU1xbGhZVnRzSGhtWnA3OGF1?=
 =?utf-8?B?dDNiYWtCRXRkYXAvTU5OWWR0RUFWR2RKL0JTN3MvU1dwaE5hczNHWXBlalVi?=
 =?utf-8?B?QnZWSGVHSUNSdDFnRUdQUGZsVG5QaE9KZVFtWldJUElHek5ZWm42VDZuRzFC?=
 =?utf-8?B?elJzMTNwVk8rNk9FazdjeUp0OFptU3JRSkthbEF6VTdXTjFmbjhOa0VEQ3RL?=
 =?utf-8?B?OEwyVmppc0MrZzZhSkUySUlGWGJqMGVKMHAzOWRxd3lVaSsyRndsS1RmYXF0?=
 =?utf-8?B?TTJZMXluajF1ZnZKYWVCSzJRN0NQVS84YkFTTE0raDgvZ3VVUmVqTjdxbjd4?=
 =?utf-8?B?R0RQVjNPQ1NoY3Z5NnhLdW9vM1JPaWRnM3hyUTF3aFg1Zi9lNXQwWHlYcUk4?=
 =?utf-8?B?RTJaM09qeDNaK1JTdTBUdFNiQWVJVUFrSkVlMVZGWjlZcjIyQnJWZlZxd0w5?=
 =?utf-8?B?dGhjdWdMdnVQWWx1dHU2ZUw3Mmk0emFpRWdkMGQyeEdiTk5aQTR6RVV1U05V?=
 =?utf-8?B?dHVOOEtJWXlQcmFKU1RKZHo1cG45VVV6QzZueGxBT2Z6TVhUMnVFd25QU1Vz?=
 =?utf-8?B?bTdnclBpRFF5OHRMZlhNUWlxb05GSVJodjFuUmt4NGs2alB3YmpqWlZkT042?=
 =?utf-8?B?UXl4RGU0ZjNPNzQxbjMxQkN0WXhJT2ZZckh1eTB6OHRZamNIWllvcHBRMTJY?=
 =?utf-8?B?anFHWjA2V2g0RE9nWVN3MHY1T3R0Ulc5ckFJQ2sxZmVYWFoxWXFjTGJBZEUw?=
 =?utf-8?B?RnB6bGRCVCtBYTQyNWRib2hTZ2UzR29xMm9XNkRDZ3BKWXltRy9mYUpiL2RP?=
 =?utf-8?Q?eFvjZEF2lb2bkKfREAZhWv3aJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 737cf463-35c3-4452-ae7b-08dbf6787948
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 16:29:09.3969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ocT1Jqruuz8HiXeDv0VCaGFUCkBosok0NEM3X4cyOucAaXJBaJWmO3FslRMV6N25ALQw3WBV12GR95um3EDHGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9771
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+DQo+ID4gSGkgTWluIExpLA0KPiA+DQo+ID4gTXkgdW5kZXJzdGFuZGluZyBvZiBQYW9sbydz
IHJldmlldyBvZiB2NSB3YXMgdGhhdCBpdCB3b3VsZCBiZSBjbGVhbmVyIHRvOg0KPiA+DQo+ID4g
MS4gTGVhdmUgdGhlIHR5cGUgb2YgdGhlIG1vZHVsZSBwYXJhbWV0ZXIgYXMgdTE2IDIuIFVwZGF0
ZSB0aGUgdHlwZSBvZg0KPiA+IHRoZSByZWdhZGRyIHBhcmFtZXRlciB0byB1MzINCj4gDQo+IFth
bG1vc3Qgb3ZlciB0aGUgYWlyIGNvbmZsaWN0IGhlcmUgOykgXQ0KPiANCj4gSSB0aGluayB0aGUg
bW9kdWxlIHBhcmFtZXRlciBhcyB1MzIgaXMgbmVlZGVkLCBhcyBsYXRlciBtYWNybyBkZWZpbml0
aW9ucw0KPiB3aWxsIGxldmVyYWdlIHRoYXQuDQo+IA0KPiA+DQo+ID4gQW5kLi4uDQo+ID4NCj4g
PiAuLi4gYXZvaWQgdGhlIG5lZWQgZm9yIGNoYW5nZXMgbGlrZSB0aGUgdHdvIGFib3ZlLg0KPiAN
Cj4gVGhpcyBwYXJ0IGlzIGNvcnJlY3Qvd2hhdCBJIG1lYW50IDspDQo+IA0KDQpIaSBQYW9sby9T
aW1vbg0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3cy4gSWRlYWxseSwgSSB3b3VsZCB3YW50IHRv
IG1haW50YWluIHJlZ2FkZHIgYXMgdTE2IHNpbmNlIGZvciBjbG9ja21hdHJpeCBhZGRyZXNzaW5n
LCBpdCBpcyBvbmx5IHRoZSBsb3dlciA4Yml0IG9mIHRoZSB3aG9sZSAzMmJpdCBhZGRyZXNzIHdo
aWxlIG1vZHVsZSBpcyB1cHBlciAyNGJpdC4gT24gdGhlIG90aGVyIGhhbmQsIGZvciBzb21lIHNp
bXBsZSBjYXNlcywgd2hlcmUgb25seSBvbmUgcmVnaXN0ZXIgaW4gYSBtb2R1bGUsIHRoZWlyIGFk
ZHJlc3NlcyBhcmUgZGVmaW5lZCBieSBtb2R1bGUgb25seSB3aXRob3V0IHJlZ2FkZHIgc3VjaCBh
cyBzeW5jX2N0cmwwLzENCg0KT3ZlcmFsbCwgSSBzdGlsbCB3YW50IHRvIGRpZmZlcmVudGlhdGUg
YmV0d2VlbiBtb2R1bGUgYW5kIHJlZ2FkZHIgYW5kIGRvbid0IHdhbm5hIG1peCB0aGVtIHVwLg0K
DQpNaW4NCg==

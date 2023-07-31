Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695D9768B62
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 07:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjGaFvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 01:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjGaFuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 01:50:55 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BEEE7C;
        Sun, 30 Jul 2023 22:50:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4LBPvdYKhV0t98f8uFc10+BXm1DN792ENMn13N+iawXQgNVgji+EIBgqtWQUD3DCOYQEQ2GgPuUI8Zd//7LVQAcGQeiVa0qf6F8DBlJYnuD+Gok7XiV5rbRdJIf2sgLn+45aWqGcAb5ALGa4d/v96Gqzgh2fy2a5DuLq8yEdUCUMjHIPqlnmMeuwtlVK0L86kxNnG9UyBtetGs0ctCo/c1BgpmjamJtJr3/ouQ+FOAme1wt+R1l26bMzpOjReFwVX3GYpVdhSJukpgl7b1T1tp+vjezCobRjYs0zEHN/hvGtdzfn1rSAM38+whKGYam/E6DlX7N3IsSCeyGMvifiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAN5QI9O7XYXaByJ4R21/leJyzPh52jRVlgXCJ4egM8=;
 b=PVXDIEWOM/tBj3oobUi/B64CR6Bg1LHhlTfbUYa8hiiIfqaHXfke2xDD6xk2zEPGnArmd9ZriSldsJdKCFir1xqxfsCFJyyXIs6ib4NFZb9DQly0YtmkiNCh7zjk5Ryb3OxdGppqk81fg1jlc5sf1davZFW9HIL6lZx+EXqFd/RV1RvCMKuG4W0BqFLazD2HLNWjy444wUqrtJiJZYEsBYB/mvotkkz7ylyGfkzxMb66cImgZ60/iFdS6KGQ/LPq687Jme3n75g5Tur2QTEgHzJLCa3JRVZ1Y+GBF7Sk+H00XH6CitojZvqxtcDU2XskZeh7bbYm3x+HcNemywNOQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAN5QI9O7XYXaByJ4R21/leJyzPh52jRVlgXCJ4egM8=;
 b=Mn8lw2Nd2MkLHWLVDMKZ1VlUUYMyJ0Rmtse2nzGb8cJj17bTSI9O3ZlZzVNLMdqiO4TRgPMh/7TyaKx8Kz/TcKKFQEqOZzh9q13aqlZUz/vS0U0Pi1i7WpobwOQTXyWolj9nY8W8PBiIsZq8zhb3i2AZm4fzuaCUwfKhtLn9IFQ=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM8PR04MB8020.eurprd04.prod.outlook.com (2603:10a6:20b:244::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 05:50:46 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::c5e2:98f8:b03:2189]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::c5e2:98f8:b03:2189%3]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 05:50:46 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tomonori.sakita@sord.co.jp" <tomonori.sakita@sord.co.jp>,
        "atsushi.nemoto@sord.co.jp" <atsushi.nemoto@sord.co.jp>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: Clear the error flags by writing
 1 for lpuart32 platforms
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: Clear the error flags by
 writing 1 for lpuart32 platforms
Thread-Index: AQHZw1Jd2ZWdEhKvq0OchWsIluekl6/TV8AAgAAFhLA=
Date:   Mon, 31 Jul 2023 05:50:46 +0000
Message-ID: <AS8PR04MB8404AA5CD478CD6AEEFC42A29205A@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20230731015053.15150-1-sherry.sun@nxp.com>
 <51a7f260-59f9-2cd4-9d49-484df00fb3b2@kernel.org>
In-Reply-To: <51a7f260-59f9-2cd4-9d49-484df00fb3b2@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|AM8PR04MB8020:EE_
x-ms-office365-filtering-correlation-id: 52c3b263-3eec-4972-3f98-08db918a1627
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GM4yVPTSL7A/u0eUSDMReK8ATYWttK5zung9QzNfXIDHDnfZjLSKgO6Y1Ckv5VgB4s0aAaYyIH40Wk9SyeJXJm6EGd8l9ZId4E7xFlNAuOg34I7sqMCHr8zgGUziemR5RXg7Kl3INGEaGZN9tGKBMlGW+h4BEgdtI/kNpcCcQzMDxTSG7bkjxyFnf0en5B+zvgCBnndleXKHCvALjaOCiG5AYHQ8NeIfiEKJSaBpLkAlB5GNGjExLxIsjhhdFKLh1e1WK1+spjkoSCFVNtm0VrG8MXHASGN1xRD9CSCe5F7pbJEZDHfmnYnI66dkOvwMTG6x6XRg3uTj2SngL1Ede1gZkD3WUGX5O5JpvfMB+GymxsHgK/Fhe9YG241Ax8C3zT10glqToSnBsKzPzHmAMKqafDEdlZfyxnykD408pNP/P6RXEXDJsGMh1mVUzKiSzNLqBmY6I0v5Sh7DVpZChSr5dr8z4cPpyZ2ahdNDnLyjwKcT0ldMwZRgY/eNS8r5OXA1FUuJGPX8obC/Nb6cK2GzucmNza4DJ/pB/rTki4e57QCEY5h/UFu/eJCAY/4VwQeLiy2F28Ual+SjZOWD6VY4PP11GfIy3CYN/1F8DeC/ERqFW4GU8/f1g+cYBqBZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199021)(66476007)(86362001)(41300700001)(8676002)(8936002)(316002)(4326008)(5660300002)(66446008)(64756008)(122000001)(38070700005)(33656002)(66946007)(52536014)(66556008)(76116006)(54906003)(110136005)(478600001)(2906002)(38100700002)(71200400001)(44832011)(9686003)(7696005)(6506007)(26005)(83380400001)(186003)(53546011)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1dScFpZZXMzaFM1cTNhYUNweTA0bFBSNDNGeWxmSklaMFgrMDZnR2Q1UEM5?=
 =?utf-8?B?UUg1ZjFqMzFDaVM1aEVIaEdUdEZrb0c4b2I5RnZRMlh2WlMxS3hMSW82Rjcy?=
 =?utf-8?B?YU03UlptdkhpK2w2V2hxOTlFZVpRQkJKVlJGL3R3SFVNRXRMVWtOVnB3VTAv?=
 =?utf-8?B?ODNVZW42SDVrQy9qYVAwT3JzR29MSTRYd1F2dHZ1d0RNYkpaMkVOYUpMUFpE?=
 =?utf-8?B?SXhDT3hsSjlBNkNCTmhCckFUOVBhZkE4dDEwbGFBZ1pzZjlsK3o1UkV0cGs1?=
 =?utf-8?B?REt5dzE0c04vZEh6bHFNaUJ0YkNpa1hiL0NvemQwWkFQNXhBYWZqUmdLZzM5?=
 =?utf-8?B?YUQrelBmbHloRlhyRlA2ZUg3MENjbXJXdHFFMXdpZG1TcXBHNldRMjc1MXp6?=
 =?utf-8?B?MFg1UWRDeUkxdml4aVA4c2Y5WnpBSUVBaVRneXFPdVlxQXhhSVRZcXBEd3VQ?=
 =?utf-8?B?dU16WUJPSitIS3hUM1BrRzVGMzlyUXNvNlBJTjFSRXB3czlqZTJZcExqQWw2?=
 =?utf-8?B?amJ3Wnd0T3RYS3ppNGI0NkRGclhRa2JqTzVCYm1oK2h3aG8xQ3VnT0xsSk9R?=
 =?utf-8?B?SEQwTmVQdkJIbkwwNTJtRVI2bTdvYWVVVmE0ZGxoaXRLcFVFN1ZRT2hRbnU0?=
 =?utf-8?B?UjRqUWxpcmlOZGlnT3BwMURhZ3h4dTd2UFBLb3gwN2wyVGZ3bnVhTmNpL3BF?=
 =?utf-8?B?MUt6QlFlUEpoZjJlL0V5SklxWG5DQ1hVajkvZTh3T0t5b0hObGIwRWxGQmdI?=
 =?utf-8?B?S01EU0ZqeGt4bG8wcnc2b25NNjdxNGpuWmdDLzlBYTVCQTVhbE03eW90aS9S?=
 =?utf-8?B?ZGFsQlE3NnMrQ3hPS2k1RjU5d3hwODJMeXg5RTlBTy9WMktaQlZlb1N3TXVo?=
 =?utf-8?B?WlM1V25nZnNrWDJEV1FZbi9NSFQvMFNiK1kvUzhnckdZZE5pZ1h5dVRVU1h4?=
 =?utf-8?B?ZlBVZFFhWlFzMzFSN1B0U01GVGJSMElNN0YvU3NaZmVlN2pLclFad0YzN1Vx?=
 =?utf-8?B?T3hJeWhMTG8ySnZaUktMTFdFWVhMQ3hQYU13dFV5NFVKRVRvZllCbUZmRzR5?=
 =?utf-8?B?UlFFdUNQY3NkMk1UT09zaWFhaUY2TlAwL0ozbm1ZLzNDcGZvS09JYXg2UnIz?=
 =?utf-8?B?Q3Z4M0Y1eE1PUHllVWJJZmRZbnlyY3RwZi9XOTdudVVEM2NwbVk1WlVRcDdy?=
 =?utf-8?B?OEZ6dXpWQ3lFL3dNeDRSUUYwMUdXYXVXWTFINlpnSFhvUkZsc0ZtYWQyNWFR?=
 =?utf-8?B?WkpaTnhNVUFFWHM4THlrT3Q0VUJrZmtpbDd4dGRrcjF1WGRLU3JBZHdXMFhE?=
 =?utf-8?B?TG10aFRtWGhwSnJtMThCY0VNUllWbVNPSFE0QVExazl4c1ZnVjhybUFBaWtT?=
 =?utf-8?B?ZzdqZThheXdWaGg4amxhNjE4K2lEYjUvWW1qcVY4eVU0azBHd29EMG1GeEFn?=
 =?utf-8?B?dzdERGtXSC9WeVY4USt2OVUrNHdYK28vcFc4V3ltQzZDTnpjNFQ5TUcvNXV5?=
 =?utf-8?B?S0wwcEpPdkVqKzB6VDJwbmNvNnpNWVczZkJXNEZoenpkK3B0aHlYbHBoSXRx?=
 =?utf-8?B?VThubjM4Tmh6ME5zaG4yS095RE5CRjd4dzkzdXVSdWhFUnZxaVR0SS9Ycm53?=
 =?utf-8?B?akxvcnlMNUExMkFtYTRlTE5OSGovc00rczBhdHJIcW5KUlBVc3BOREYrWFE4?=
 =?utf-8?B?MDhZODFtWFBjcHJsSThna0hhejdNeVNZYVNsUVBDWGt6d01ZRGpvWUxtWkRG?=
 =?utf-8?B?VHBKSW0vRU5oYmlkWUpSWWt4SFpVS3ZVTHEweXc0SHlmcXI5a3M5d0xORUly?=
 =?utf-8?B?cXFUQ2NzbGdiQnBvcFJyWkE4ZTRxWCtINkVvWHdxSW9OejZibTF4ekw0bWNj?=
 =?utf-8?B?SFFaM2hYdGtsNVFJMllSbzdaOUJTWEFqYy9KTHpMdmhNUmtSdWhSdkhZMXZY?=
 =?utf-8?B?VVIyVWtXZ3M4RjVUbkg4aUlFQ25VQnhkL1pQa2dHN2dkS0xEQ2FGWXl3UFJ0?=
 =?utf-8?B?YjFyTTFQakpsd3VpcGZ3RGxzQWxIekhDdVBFLysyMnhEcXY3a1VsN0FjWDBM?=
 =?utf-8?B?bTlBeVVzWXVjNkdIVTljb0pKUHMvYkxxWis4c2FkY1FvU0pvRjRhQ0FBVnFO?=
 =?utf-8?Q?TF2E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c3b263-3eec-4972-3f98-08db918a1627
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 05:50:46.6218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0JHeN9setirTXxzv329Omr32xovM50/HQYJlbnxATlHTG1R2yeWHoRQmq3LPFAE935QxVE5HUNDfuVEKifgEnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8020
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmlyaSBTbGFieSA8amly
aXNsYWJ5QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjPlubQ35pyIMzHml6UgMTM6MjQNCj4gVG86
IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT47IGdyZWdraEBsaW51eGZvdW5kYXRpb24u
b3JnOw0KPiB0b21vbm9yaS5zYWtpdGFAc29yZC5jby5qcDsgYXRzdXNoaS5uZW1vdG9Ac29yZC5j
by5qcA0KPiBDYzogbGludXgtc2VyaWFsQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSF0gdHR5OiBzZXJpYWw6IGZzbF9scHVhcnQ6IENsZWFyIHRoZSBlcnJv
ciBmbGFncyBieSB3cml0aW5nIDENCj4gZm9yIGxwdWFydDMyIHBsYXRmb3Jtcw0KPiANCj4gT24g
MzEuIDA3LiAyMywgMzo1MCwgU2hlcnJ5IFN1biB3cm90ZToNCj4gPiBEbyBub3QgcmVhZCB0aGUg
ZGF0YSByZWdpc3RlciB0byBjbGVhciB0aGUgZXJyb3IgZmxhZ3MgZm9yIGxwdWFydDMyDQo+ID4g
cGxhdGZvcm1zLCB0aGUgYWRkaXRpb25hbCByZWFkIG1heSBjYXVzZSB0aGUgcmVjZWl2ZSBGSUZP
IHVuZGVyZmxvdw0KPiA+IHNpbmNlIHRoZSBETUEgaGFzIGFscmVhZHkgcmVhZCB0aGUgZGF0YSBy
ZWdpc3Rlci4NCj4gPiBOb3cgYWxsIGxwdWFydDMyIHBsYXRmb3JtcyBzdXBwb3J0IHdyaXRlIDEg
dG8gY2xlYXIgdGhvc2UgZXJyb3IgYml0cywNCj4gDQo+IFdoYXQgZG9lcyB0aGlzICJOb3ciIG1l
YW4/IFdpbGwgdGhpcyBjaGFuZ2UgYnJlYWsgc29tZSBvbGRlciBwbGF0Zm9ybXM/DQoNCkhpIEpp
cmksDQoNClNvcnJ5IGZvciB0aGUgY29uZnVzaW9uLCBtYXliZSB0aGUgIk5vdyIgc2hvdWxkIGJl
IHJlbW92ZWQgaGVyZS4gSSBjYW4gc2VuZCBhIFYyIHRvIGltcHJvdmUgdGhlIGNvbW1pdCBtZXNz
YWdlIGlmIG5lZWRlZC4NCkkgY2hlY2tlZCB0aGUgUmVmZXJlbmNlIE1hbnVhbHMgY29ycmVzcG9u
ZGluZyB0byB0aGUgZm9sbG93aW5nIGNvbXBhdGlibGUgcGxhdGZvcm1zLCBhbGwgY2FuIHN1cHBv
cnQgVzFDIGZvciB0aG9zZSBlcnJvciBiaXRzLiBTbyBJIGRvbid0IHRoaW5rIGl0IHdpbGwgYnJl
YWsgdGhlIHN1cHBvcnRlZCBwbGF0Zm9ybXMuDQoNCiAgICB7IC5jb21wYXRpYmxlID0gImZzbCxs
czEwMjFhLWxwdWFydCIsICAgLmRhdGEgPSAmbHMxMDIxYV9kYXRhLCB9LA0KICAgIHsgLmNvbXBh
dGlibGUgPSAiZnNsLGxzMTAyOGEtbHB1YXJ0IiwgICAuZGF0YSA9ICZsczEwMjhhX2RhdGEsIH0s
DQogICAgeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14N3VscC1scHVhcnQiLCAgIC5kYXRhID0gJmlt
eDd1bHBfZGF0YSwgfSwNCiAgICB7IC5jb21wYXRpYmxlID0gImZzbCxpbXg4dWxwLWxwdWFydCIs
ICAgLmRhdGEgPSAmaW14OHVscF9kYXRhLCB9LA0KICAgIHsgLmNvbXBhdGlibGUgPSAiZnNsLGlt
eDhxeHAtbHB1YXJ0IiwgICAuZGF0YSA9ICZpbXg4cXhwX2RhdGEsIH0sDQogICAgeyAuY29tcGF0
aWJsZSA9ICJmc2wsaW14cnQxMDUwLWxwdWFydCIsIC5kYXRhID0gJmlteHJ0MTA1MF9kYXRhfSwN
Cg0KQmVzdCBSZWdhcmRzDQpTaGVycnkNCg0KPiANCj4gPiBsZXQncyB1c2UgdGhpcyBtZXRob2Qg
dG8gYmV0dGVyIGNsZWFyIHRoZSBlcnJvciBmbGFncy4NCj4gPg0KPiA+IEZpeGVzOiA0MmI2ODc2
OGU1MWIgKCJzZXJpYWw6IGZzbF9scHVhcnQ6IERNQSBzdXBwb3J0IGZvciAzMi1iaXQNCj4gPiB2
YXJpYW50IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5j
b20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jIHwgNCAr
Ky0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMN
Cj4gPiBiL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMgaW5kZXggZjY2NDRjNTk4OWQz
Li5mNzJlMTM0MGI0N2QNCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwv
ZnNsX2xwdWFydC5jDQo+ID4gKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYw0K
PiA+IEBAIC0xMTIwLDggKzExMjAsOCBAQCBzdGF0aWMgdm9pZCBscHVhcnRfY29weV9yeF90b190
dHkoc3RydWN0DQo+IGxwdWFydF9wb3J0ICpzcG9ydCkNCj4gPiAgIAkJdW5zaWduZWQgbG9uZyBz
ciA9IGxwdWFydDMyX3JlYWQoJnNwb3J0LT5wb3J0LCBVQVJUU1RBVCk7DQo+ID4NCj4gPiAgIAkJ
aWYgKHNyICYgKFVBUlRTVEFUX1BFIHwgVUFSVFNUQVRfRkUpKSB7DQo+ID4gLQkJCS8qIFJlYWQg
RFIgdG8gY2xlYXIgdGhlIGVycm9yIGZsYWdzICovDQo+ID4gLQkJCWxwdWFydDMyX3JlYWQoJnNw
b3J0LT5wb3J0LCBVQVJUREFUQSk7DQo+ID4gKwkJCS8qIENsZWFyIHRoZSBlcnJvciBmbGFncyAq
Lw0KPiA+ICsJCQlscHVhcnQzMl93cml0ZSgmc3BvcnQtPnBvcnQsIHNyLCBVQVJUU1RBVCk7DQo+
ID4NCj4gPiAgIAkJCWlmIChzciAmIFVBUlRTVEFUX1BFKQ0KPiA+ICAgCQkJCXNwb3J0LT5wb3J0
Lmljb3VudC5wYXJpdHkrKzsNCj4gDQo+IHRoYW5rcywNCj4gLS0NCj4ganMNCj4gc3VzZSBsYWJz
DQoNCg==

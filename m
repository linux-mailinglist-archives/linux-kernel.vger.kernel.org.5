Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D37757181
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 03:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjGRBvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 21:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjGRBvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 21:51:18 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2048.outbound.protection.outlook.com [40.107.7.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173D8E47;
        Mon, 17 Jul 2023 18:51:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyNUJIZE61LeJplVb6ZobK8D0Zpqks+vIT+y6WTrF1RaFBX8VeBfs/0EYEwBTbO0yg6GkEQk0jHf7f0Wq34r2NVvS9EAjY2AwKbBOgFtUJSBm5cM22YPt28/tztz9X4Ewgy0Bv+4Xicnpzk6WDI8LoZ7KRQ8ZjL67P6MONcPV127gn2y1/hrKuNp8g6v9iqIJmee0YYVrMKkwuEAX6zZshyMv9YudB+Wf3DsNqKrk5vTQDAnNJSeiao8t07vWQKhW00ELen5yz8OWmNgYhaD7p085yGBAP3ntA/sD1D9FTQR3SHS+o7IGYnhpm6SmRy+0Wq7j3DEgOoUR03jMInvFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wlOdN6VY7ByNTRsRB0uUbHhE2kMLLo27V9Uym25vz0=;
 b=bbi13/4iCB3Ui0wejbIlFPxK+y3eyD1NLfyJzWkJ0jgGzvzZeX1oYRtWSZxsVrHQ1futOv8JKqCb7uyGm7F66y7t/xofLbr9QW72Iujw5RuH8JRcFfu3EfvWAHH3Y+ocOI7byQ3ccs3pClu0qnsychocxfmx9cyeavX+RtzAJdVr0Vz2jG/aBtik00PG6L3IRZPyMMQJdDs7u/i/RsOq7iYYK1K7iA8ZlUlFeY0rlusVIA9n/tAhBh7SC1YhS+7H/3ykvu1e9+oLs/hubc+Cw5rF+TmS8fC4NXgermwKmR8DnP+3o5eKQPIRm3qb5zDpctE7VvNY6kq10w6laYcvXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wlOdN6VY7ByNTRsRB0uUbHhE2kMLLo27V9Uym25vz0=;
 b=oEVJ8Iuk7TFA1bYlf+6N0XY+y6XeBlm+MWamEfgHJTDupbxWLLkzSRMHL8bWqwPrvr172F7V1bLjyPAxQDps4aToTz44/h1L31Kl/jIbddv3JSVfSwH8BZBiLG8DS5ZeM1eik6qZGCqKLuykYYuZ5PgpezL/QTcu71XuUfLZm2c=
Received: from DB8PR04MB6346.eurprd04.prod.outlook.com (2603:10a6:10:10c::14)
 by VI1PR04MB9764.eurprd04.prod.outlook.com (2603:10a6:800:1d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 01:51:14 +0000
Received: from DB8PR04MB6346.eurprd04.prod.outlook.com
 ([fe80::f92f:1f0e:fb7b:6a5e]) by DB8PR04MB6346.eurprd04.prod.outlook.com
 ([fe80::f92f:1f0e:fb7b:6a5e%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 01:51:14 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tao Jiang <tao.jiang_2@nxp.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>, Eagle Zhou <eagle.zhou@nxp.com>
CC:     LKML <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] media: amphion: fix some issues reported by
 coverity
Thread-Topic: [EXT] Re: [PATCH] media: amphion: fix some issues reported by
 coverity
Thread-Index: AQHZuIHycr4tM8AdPUGN0LAv/PjAn6++Nl8AgACNC+A=
Date:   Tue, 18 Jul 2023 01:51:14 +0000
Message-ID: <DB8PR04MB6346B34F92B51D9BCABCBFCEE738A@DB8PR04MB6346.eurprd04.prod.outlook.com>
References: <20230717074006.22372-1-ming.qian@nxp.com>
 <de66de20-8ad2-836c-2014-54db3daba3b3@web.de>
In-Reply-To: <de66de20-8ad2-836c-2014-54db3daba3b3@web.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR04MB6346:EE_|VI1PR04MB9764:EE_
x-ms-office365-filtering-correlation-id: eff144e9-c3db-4059-1e58-08db87317826
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4PNcxcAcy3SzgVOMliEeZ4KWKq2D4QPhpQBbAigmAqwYTCWBu+AZTBoMWAxBPdgEA730tVmn75GyLHGf1NXjhvoZehWlRASBNi18I/G5toYFjO2In0aEo/ZqtS7bX1dlWpaFGkDKzqz1tXC/6BmgCAeSEavetqkHeHfGtI00M8FcGaPmdqhQi0dg2zY1BZnteRlz82fsjlQcczi5kDxsrbFtmrwAkatwDlUMU+GidnUt+YtSpkrSCaz800VDr8wL7aSJj3pxr8Q6NyYYAYpJP4miSLB4GL3QzG5GsD6aLF0SoK8p3+y7VhkiYm8LNj6UBC+k+BgK5NljctBGWfOiz/Z17AOh5ls9dlLkDbf845tB/Or/Rxzep/Gq34w4glb+Tw0neK0OOMmnZjHRFRQhcWJ3BE0RxDL3LfGMUNC9tOHOKg2C0mVuHHP+JYNEi4x+xT68Db9GvnxHDO4gkShUL1jo9647JvaVwbdMEawuwL2WetYz5UkXlrkjNATO1XzEkb0wEOJ/oHC5o0c4nXEYXZN0jZu5UOJjnXWDI2Yz4tAIey+rS+Jf+9Y1CRMDi+KzhEK6bQbd7Chh/SYfvsK1hbMO90BN7c2EBDa758dC676reBJa67lFYKOuVh9TG8RcYDECwpQjkPhvCFRxNxPmW+flu9GL+EQGIL9PrDZ+BGM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6346.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199021)(2906002)(55016003)(38100700002)(921005)(9686003)(122000001)(83380400001)(186003)(6506007)(5660300002)(52536014)(33656002)(86362001)(38070700005)(8676002)(44832011)(7416002)(4326008)(478600001)(7696005)(110136005)(45080400002)(71200400001)(316002)(41300700001)(8936002)(6636002)(76116006)(66446008)(66946007)(66556008)(66476007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?QXoweEpHN3JLZlQ4WEhmVmZGY0RYRlRnNW40Z2hCZ004NlVUYkc1QmU0VEZV?=
 =?gb2312?B?Q0NWWGhmV252dEc5UktzSEtDNVFOVG1zVmQ2cktRYTVRWTdvMDZSZVZHR0k0?=
 =?gb2312?B?UWlmczcxWm0wckFzMlUwU0JIZ1JWOExLOERUdUpSTm1NTG9uL05nckF6MjU5?=
 =?gb2312?B?aVJ3V1ZRb2hidGpNZXhxVUhmWFhZb1FVaVpnYysvSWF4ZGFwdUVITE5rc2Fj?=
 =?gb2312?B?VjVnRzBmK0pWL0w3dU5nQ0JIYmhPOFkyUWY3Y1JySjc0ZzJJS09sbmxxbEZq?=
 =?gb2312?B?OHhjYTZ5ZGJYcnl1d0xBVS94SlRYK09XY2hUQ0tDcDFMNXFPMDZzS2hsU0Q0?=
 =?gb2312?B?OWdBZkhmdUhnbk9HWjd6Y1BrWDQzblF6VnZYTStzbC9la3pHT2d5a014cEZh?=
 =?gb2312?B?NnRBVTlLQWhLY3o5czI5QkI2Y0NWcjZXejRMYjZxenNFSUx1UDcxWE52VFBF?=
 =?gb2312?B?b0t0M2NFWXB6eDg1OWgrWUhQUktZbDRNd2JCQjZoMVBnUGpDSFJHV0tuZjBu?=
 =?gb2312?B?UEE3ZHB4eFc1d0hFay9TTjMrOUgwbWxkODFnS0xOYnVmWWt1ZHk4NUkyMDNN?=
 =?gb2312?B?SWJKeEEyUlEyM0V1ZWVpdm0zTnc2T01GdkVQOXFsZ2hBNlNFVTd3dGRaNjFq?=
 =?gb2312?B?YnA5UnlYZlJFM3B3N0VpYmdiU1dCVFVCWlZUQUMyNHluSW5pOEhvTDVGaWxk?=
 =?gb2312?B?cGlqWDhLdVJVekxrd1RydmpTMkZyRnlTQXJqL3ByamJHenJIVEFIM3VkUG5k?=
 =?gb2312?B?K3lrS2dwaXp3dmVzNXZSNlVDd0tCL3BpandSVnpleE9XZ2ljVGI0bmJta1hF?=
 =?gb2312?B?di90a1NWVFFsVGxrS0c5eDYvTGlsdk1GemJoekJBYVE1TkIyUlJxaGVxc2g0?=
 =?gb2312?B?Y2xTUjY0VzZ6SU95eU1rMFBST21vL3dRYXhLUXJreXhPc0RoVlBteFVrNTJU?=
 =?gb2312?B?OHVGVlN3cVVMTzBMc01TZHVqKzVSV1V2d014WktjTGlmL2lxTk8xUjNteFdn?=
 =?gb2312?B?VGlMV0ZIMzBCNjFuWWVEcWd4MjZYRENacWZMTkpid3EvdTJpakd1NDlrK3pk?=
 =?gb2312?B?SFFiRDBhNVNNNUFtNHBjd21xc0tMVHh4TkRHNE9BQkNHcm52eWs5Y3l4ejR2?=
 =?gb2312?B?d3BVdWE5Y3lOWEk3VXVSeGVRc2ZUVWoveVVnTmk4eVlyaWhNc0pzOXdUcE5p?=
 =?gb2312?B?bXNjYmJyNFhGb3JHOHJxZHBobmxTaGpycTBDK2VoSG9CWDlPS1RVeXViV3Nt?=
 =?gb2312?B?bmtTRkpsWVdzU1lIY3NkWGNvK2ZrdVNTaGRCcXlFeHJJckR3cHBnT09JRzFo?=
 =?gb2312?B?cEY4VHhSamU5UnlpVjBwUDhMYjVMWjVjWjR3SGN5dTdWWkpNYjlwYm9GYjJP?=
 =?gb2312?B?MTRqSXZ2ZDhNT1J5TldVb3UvS0poRURyd3lZMWpvRDZ1MFVPenlMZ2JVMGlO?=
 =?gb2312?B?WE5lVGFZQVpKR3NqUkpWdWwrOUJrUjhScjNtZ3Q1VS9Fa1VmU1hYbmdtNDVs?=
 =?gb2312?B?VkU5bHBjMy8xVW1qZjd1MkxnYVYza3QyTTZXYXNnbFhCVnFObGpxcFF6aGZR?=
 =?gb2312?B?RU1BVVJnNG9vT0FpYnhCMUc3ZmtiSGJDWGJXaU8wcE1ieUcyVDFpL3pBckE0?=
 =?gb2312?B?MytDQ1BqUkM2U2xKbC9vSzdsZzRySnczSWJNQjUwbVhJbTZ5SHZORER1bkZk?=
 =?gb2312?B?Z09MaXk0cjN1TkVsdUkxOEo5YmFVUy9sSUIvck1tM0hwVmtSeURJeWxpdGNj?=
 =?gb2312?B?KzJwMldHWERmZlhNc3NQdjZlUFV2OTB2YmlWMXFOVVZINTRHb0FDaGE1NVhR?=
 =?gb2312?B?NXc1N1lrRlJ6bjN6V0hHbHJocVdWVjcyQlBIUkl1YTZkeGcxd3hJTEpWS2Uy?=
 =?gb2312?B?ODBHRXRsbkJZVzJjaXhzKzRvMDFrckhmR0F3aUMvTVR5eit2ak5TaldHR3dW?=
 =?gb2312?B?K2MrU2s5blY4SHdOZWl4MVljZnpWcEVHUy9HeGhhTDRWUzNNQUtIamtvOUln?=
 =?gb2312?B?cG5DYjZ2NmZCbi9YYXdrNmxKckptZTc5MFFjZjRCNU50cU5WdmNXMXNNN0g3?=
 =?gb2312?B?SWtvTGRETHRHN3ZxQ3NmVTNVK2xaa2pPWmFadz09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6346.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff144e9-c3db-4059-1e58-08db87317826
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 01:51:14.1689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H6tR3b/KNpn8H2HqMyAbiF+vApWrTmuJiU08TxQA+VvnjB7PsQAv1YejjzPAf6pqJmOgG25CICRV0dafD5lR/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9764
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkZyb206IE1hcmt1cyBFbGZyaW5nIDxNYXJrdXMuRWxmcmluZ0B3ZWIuZGU+DQo+U2VudDogMjAy
M8TqN9TCMTjI1SAxOjI2DQo+VG86IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+OyBsaW51
eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbC0NCj5qYW5pdG9yc0B2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGwtbGludXgtaW14DQo+
PGxpbnV4LWlteEBueHAuY29tPjsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBGYWJpbyBFc3RldmFt
DQo+PGZlc3RldmFtQGdtYWlsLmNvbT47IEhhbnMgVmVya3VpbCA8aHZlcmt1aWwtY2lzY29AeHM0
YWxsLm5sPjsgTWF1cm8NCj5DYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWJAa2VybmVsLm9yZz47IE5p
Y29sYXMgRHVmcmVzbmUNCj48bmljb2xhc0BuZHVmcmVzbmUuY2E+OyBSb2IgSGVycmluZyA8cm9i
aCtkdEBrZXJuZWwub3JnPjsgU2FzY2hhIEhhdWVyDQo+PHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+
OyBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBUYW8gSmlhbmcNCj48dGFvLmppYW5n
XzJAbnhwLmNvbT47IFguSC4gQmFvIDx4aWFob25nLmJhb0BueHAuY29tPjsgRWFnbGUgWmhvdQ0K
PjxlYWdsZS56aG91QG54cC5jb20+DQo+Q2M6IExLTUwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc+DQo+U3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSF0gbWVkaWE6IGFtcGhpb246IGZpeCBz
b21lIGlzc3VlcyByZXBvcnRlZCBieQ0KPmNvdmVyaXR5DQo+DQo+Q2F1dGlvbjogVGhpcyBpcyBh
biBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9y
DQo+b3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdl
IHVzaW5nIHRoZSAnUmVwb3J0DQo+dGhpcyBlbWFpbCcgYnV0dG9uDQo+DQo+DQo+PiBDSEVDS0VE
X1JFVFVSTjogNCBjYXNlDQo+PiBSRVZFUlNFX0lOVUxMOiAyIGNhc2UNCj4+IFVOSU5JVDogNiBj
YXNlDQo+PiBVTlVTRURfVkFMVUU6IDEgY2FzZQ0KPg0KPkhvdyBkb2VzIHN1Y2ggYSBjaGFuZ2Ug
Y29tYmluYXRpb24gZml0IHRvIHRoZSBkZXZlbG9wbWVudCByZXF1aXJlbWVudA0KPqGwU29sdmUg
b25seSBvbmUgcHJvYmxlbSBwZXIgcGF0Y2guobE/DQo+DQo+U2VlIGFsc286DQo+aHR0cHM6Ly9n
aXQua2VyLw0KPm5lbC5vcmclMkZwdWIlMkZzY20lMkZsaW51eCUyRmtlcm5lbCUyRmdpdCUyRnRv
cnZhbGRzJTJGbGludXguZ2l0JTJGdA0KPnJlZSUyRkRvY3VtZW50YXRpb24lMkZwcm9jZXNzJTJG
c3VibWl0dGluZy1wYXRjaGVzLnJzdCUzRmglM0R2Ni41LQ0KPnJjMiUyM244MSZkYXRhPTA1JTdD
MDElN0NtaW5nLnFpYW4lNDBueHAuY29tJTdDOTQ1NzVmNDk5ZGY3NGM3MDINCj5kODMwOGRiODZl
YWQ2NzglN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjMNCj44
MjUyMTE1NDA2MzA0NDI0JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdN
REFpDQo+TENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMw
MDAlN0MlN0MlN0Mmc2QNCj5hdGE9bnI3YnFaTVBOdnJFQ1NPTUpzQ3puM2FVOFVXZGluQkc0c0hS
UkdSSkoxRSUzRCZyZXNlcnZlZD0wDQo+DQo+DQo+V2lsbCBmdXJ0aGVyIGltcGVyYXRpdmUgY2hh
bmdlIGRlc2NyaXB0aW9ucyBiZWNvbWUgbW9yZSBoZWxwZnVsPw0KPg0KPlJlZ2FyZHMsDQo+TWFy
a3VzDQoNCkhpIE1hcmt1cywNCiAgICBUaGFua3MgZm9yIHlvdXIgY29tbWVudHMsIEknbGwgc3Bs
aXQgdGhpcyBwYXRjaCBpbnRvIDQgcGF0Y2hlcywgb25lIHRvcGljIG9uZSBwYXRjaC4NCg0KTWlu
Zw0KDQo=

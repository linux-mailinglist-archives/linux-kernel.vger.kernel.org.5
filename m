Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F92B75EBC0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjGXGjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjGXGi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:38:56 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83E410E9;
        Sun, 23 Jul 2023 23:38:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMPS2mea1ewKus3xvctmGLcrZq7W88mBjkjDhbcLT37IeBvwAN3qCQMrtOuk6q+r2kowT6wTHoLN9z3S4WsBskR044FZP9SGwXWO347eBn+E3lVoCfFyOYfiKkG+qlZJU1x0PkvbEvP7UPhbGFeHQOp/WUIPbd4DymDFKzUneIMMbccBm1dwV6OMjRaawrjQsL31t8DH68gc1kCRNxyQqSJBFV2gMR0pf4oURE7lN0yfkNB5lf7rj3uocFnqBkUCE5KHUEWh252+MrRi9GxbNUnM9YRBCfuWAmpBSTB0mOoMNdD1PJHay0KCz7DUodyb1QKfnkH0HwPxAPZxL/6y8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcQcVldBO5J3rAz3hVbU+s7NVXUaiogziOmE8mdv4h4=;
 b=Y2CvwpwsCT2hEfIGWAbffEWXM2CSQDvqqH5QjI9/OGG8PbTnYlxRu5a9T8zdC/ADOf9MQXFE2yYVHJoszEiIP2wMq0v/Ox5N8bfMhQnxiGOxZBK5JFy2FOHgGKBxoz/y3aHCmsDwYOMGp8Z5yZwIRjHBn9+usJByw9SY3AUnvNqw8Oaus0BXxGDB5AUwqJe+dcJKi7du71anWNCZD8xqOBLhhMdY3fmylQU1RzbY8YotuFY+baWZ6ilR2SJzL+vVoBoMqjMDftPLqPclVUw8u95l34+3Fu7YEgCrRI/m/13x1L/80jWIB/93M8ve9x/JCkx1OY4xr5OYr+AxTv9kyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcQcVldBO5J3rAz3hVbU+s7NVXUaiogziOmE8mdv4h4=;
 b=sMVD7YW30YT7IEbsKyz73IK/i0OH8fUTwrbybU9Tsrz/0fcunHPAr7vGRqk7KHnEbeHm4FP6QHYTBTFbS0vv3va4CJK4fuNjRFVm9qED8MWdKji8v8q3FWVep6r/GO0HyM58jLVdhYyJGzHNY3ilGHmNCeodRrqeOYeQcME3SF0=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS1PR04MB9333.eurprd04.prod.outlook.com (2603:10a6:20b:4df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 06:37:33 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 06:37:33 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: RE: [EXT] Re: [PATCH v3 1/7] dt-bindings: arm: fsl: add mu binding
 doc
Thread-Topic: [EXT] Re: [PATCH v3 1/7] dt-bindings: arm: fsl: add mu binding
 doc
Thread-Index: AQHZoFASKHuzjH0W/kSFBShO5sZzaK+NajCAgBWOmxCAE6eqAIASC/cQ
Date:   Mon, 24 Jul 2023 06:37:33 +0000
Message-ID: <DU2PR04MB86309B90B0849AFB23F6462F9502A@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20230616181144.646500-1-pankaj.gupta@nxp.com>
 <20230616181144.646500-2-pankaj.gupta@nxp.com>
 <a06dbb80-c9b2-3a57-cbc5-b18432b4029a@linaro.org>
 <PAXPR04MB8638D1504946559095E1CAB69530A@PAXPR04MB8638.eurprd04.prod.outlook.com>
 <9dd411e0-6cc5-44c1-be56-ecb2ad809a9b@linaro.org>
In-Reply-To: <9dd411e0-6cc5-44c1-be56-ecb2ad809a9b@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|AS1PR04MB9333:EE_
x-ms-office365-filtering-correlation-id: d06da50a-5d68-46d9-e8ae-08db8c10762b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3pr5/o7IKpuRfjl38+3A+gKDYzG/qqtdHb7mQ256ZoUr0bEmg8oH3+avx6xmhEaGQAX7g36uE92pinIXQNPRIW9xhfuKIMw29zUrhioBI5XfWG5Tsrrw/NCBQBPC2AWy4UcljapGRSHx6C26C3VXCdqAul2EdLKA7MDvxE2Iy29/1aM0D7HnPNjRvoxzF8kinJn7Me6YCiH89j8uoCWVl73xX8t8HMKdka2v2hU3p+VmCRWM1H/wIv85nZv9H0j0efdJClHBAYxj79Y2fPtJwmLFYqDlDByf01hVAgvalqjY3l3LQzLrjXCCFI7AXGGNFpCDEb4zoR//0M92n2drM7Qg61+svwizxbfCl7TzLThravlTJ3MMHZHpGROHPJk3NYdGHuxCXMviynndFsCG6WcBI6a3fdVkdv+7GJQyw7bX0ASKLBRcM/x7XUHEWijGOFHs/dfVxoKX/sjpBl/sVxqf4+v6jGjwnc+T/vIVJphQQggyJpkktN41RzDykOwBT9quVZHJutAVDNAFJWPXT0UfAX214yka83Lu0rZexcpyb2CH8VVERRohLPFJTSmqe3SGrZJ3vnXjqoqH65w5tLynxEfrfrKiwdlSiOwYvxAbCIHOdQVTinyShhFJFgQ/t2HbdApWMzrZt1XZ+X1y8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(33656002)(86362001)(38100700002)(921005)(55016003)(122000001)(71200400001)(2906002)(7696005)(9686003)(53546011)(186003)(6506007)(26005)(38070700005)(5660300002)(41300700001)(66476007)(76116006)(66946007)(66556008)(66446008)(64756008)(316002)(6636002)(478600001)(7416002)(8676002)(8936002)(52536014)(44832011)(110136005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWtpNWUzWXFVelZ6UjQ2Rlo5RU5uUjJ3WUQ4Si80M1k1STJDcERxVENlK01U?=
 =?utf-8?B?SGlDVFI4MTBSY0MwK3lLcFV5RjMrTDhSYTY4djBsSHM1NjhtS0p5UDV3MkZw?=
 =?utf-8?B?cnB5ci9CY2lsOEFxaGZDd2pNQ3JaTzdVdFBGNGdkQm8yNGNyL3EzZUJnaXMx?=
 =?utf-8?B?dG5Scnl1MkFzRm9lSHUxOVRTM0FjQWhndDFjYnNCdzdzR3k1ZFlxVW0yTk5i?=
 =?utf-8?B?MHh5aTJiMFRQTWE3ZU83RlVUdm40KzdCSzkwYThUVlZKcFVaUW5YYlVIWUs1?=
 =?utf-8?B?ZE5jNHZZU2xQZERDYi9JTWo3b3NrZWxNbVcweDhkUG0ralJkZlAzS2JXWGlV?=
 =?utf-8?B?aG1KalFjQTRTRHRwKy9Ed3N6OWJsbjBPWkRLam80YTdjNzBiNU1PdStlb3Fm?=
 =?utf-8?B?em9rRUs4MlhhalpCZ0lTc3NhdUd4a0YxOTNXVmFqYi9IendFTmQvVGd5bjZx?=
 =?utf-8?B?aGJkRXdoT1dqVlhyNS93OFZ3UjRBMmVWNjZFaVNpa1ZrZDNRYnZkbGYyMXZD?=
 =?utf-8?B?UGFEYTJlY0NFYVh2V0NMZllUcWpHbTR2N2d3aXNmU1NmMGp4MmpLRTNMVnZ0?=
 =?utf-8?B?cmRHcSs5c2oyREdFbXBhUHdtcU8yMEx3T0NXWWN4L29xOG5YTEQreXM2eHAy?=
 =?utf-8?B?RCt2d0Z6Q1EwMnNWc3hoRE9qQkJWTDZ5MlRlVGpsYlhFQXJoRzJ3MjlCZGR0?=
 =?utf-8?B?Uk9RTnZKdG8reUtXQmZxZnZCWXAxbFFiNzVXOXhSOXVkYkdJazFCaUZ0R3VC?=
 =?utf-8?B?Q3hOSFdsSVY3V2hPRUttTjZxY3hBYlV1ZXJ1bjMySktwalE3em1oOTRhbC82?=
 =?utf-8?B?dGRGSnF0WTJkTlJZREJZU2pIdG00UUxrTlArNDQ3aFJkNFNaYk5aZ3BIdmVr?=
 =?utf-8?B?azRaZjhvZTNSSys2M3RQY0hacFduUytKckNpSlpIcllUTDR6TmVNYUlvbUZK?=
 =?utf-8?B?S1dubUx4OGQvdzlYbk9uMVM3UHpGNko2dUFweWlFTFZhS3lENmtqSXo2MVJM?=
 =?utf-8?B?N1VuRjFIcG1ha1VTY0ljeGVlK2kvcDRMbTIwMUcwdHUwNDBseVpVNm1aZzVM?=
 =?utf-8?B?Mm15czFNZ2t4K2FRREkzV3RuSUp1TUFxR3BCM2NxREZjQm5YSmE2U04yVmZl?=
 =?utf-8?B?NVM3cCt6VSsxRUFIR2t1T2laUHFFZEFMMzdQSHhEZjk2Z3RxTzFLUzg0NGow?=
 =?utf-8?B?Tjk3ZGMzYyt3NkRhZWhaVWZLRjh4dEs3d24zVFNYRENSNWkxdTEyTjE5Ymk3?=
 =?utf-8?B?cnphNzB6eUZWOXU1TEFIUUZvK0x0MDByQ1NMVWx6blVQdG11aVlCb3dxR2M5?=
 =?utf-8?B?SmdwdmJhV1Bvck9ubnNSYlMxS0ljSk03Uy9UY1hXaDl0TlJYam9yanI3eTRQ?=
 =?utf-8?B?cnA1VnBCRG51S0RqSDdOMFRKZERPQjYyczFDaEdPZTgrQVhkODNBTFc0c2x0?=
 =?utf-8?B?cGIwNmE5NjlxaGc2YkVNSDdGOGVXcWhqSmwxNWc2OFEyMVc1c3c5WWF4MmJk?=
 =?utf-8?B?RUpsY01Bb255aGlCVGJzSEJOWEo5dTZ3d2ljZjNlSzZJcHU1dE9GS29HZ0RZ?=
 =?utf-8?B?Rnl6TWFCbmJQbnZ4cUNhWTlhRmJQV1A3bUF0OVI0aWtJdk1QcWZFY3VvdW51?=
 =?utf-8?B?Z0ZxVm9GcXdvR1g5WU4vblI0NExnK2tRYWg2NkJrUGs3Y0ZKUUNXV0xnOUNy?=
 =?utf-8?B?U2d0WnVlamI4OEp1cVIvaVFkbXpXUlg2cXlocUxTcXBTUnk1NjF2elkwbmVj?=
 =?utf-8?B?cEVsQnZjNUZHUk9jQ05zQ3dxVG5QTnJIY3ppaUtwU0NYQ0xuWDk3UHlid0tU?=
 =?utf-8?B?dXVyQXlxSWkvaktabi8rRlZFdHNsNStLVkRaZ1BnRjhvM3ZrSXd5RzZ6cGlE?=
 =?utf-8?B?d2JYekdDemtrVzc1c2NMRlFqYUlONFVzdy8yTWJVNmhnaWw4RW9WbHNuUWl4?=
 =?utf-8?B?VTI3L2lUYklQTGQwRGJ2VUJmSzdoNGIvRWIvNFpVWDNndENKaEVjSk5MTGdD?=
 =?utf-8?B?TmVxUU5yRjdHOGJIandYYnAwQmV0Z2Qrb2UxQWxxYzBSY2pUSmpOZUkwTHBm?=
 =?utf-8?B?MTM0WjZGYzlPSk9rSnJkWUlCM0hURXhuTVVnUG1DRzRHVDEvOFAvVkZVc1Nz?=
 =?utf-8?Q?YcV0FKZMEmfzxjEepO9jMP8SX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06da50a-5d68-46d9-e8ae-08db8c10762b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 06:37:33.2998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s4FJd/1huMwyCrmeuzZmaoHprF600lBA+VqiX+ltlvjdIaB1wP5Qsp5XgtfDW1uePlkGzhxlPXe/y0UWbKWIow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9333
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwg
SnVseSAxMywgMjAyMyAxMjoxMiBBTQ0KPiBUbzogUGFua2FqIEd1cHRhIDxwYW5rYWouZ3VwdGFA
bnhwLmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4ga3J6eXN6dG9mLmtvemxvd3NraStkdEBs
aW5hcm8ub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBz
LmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGZlc3RldmFt
QGdtYWlsLmNvbTsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IEdhdXJhdg0KPiBKYWluIDxnYXVyYXYuamFpbkBueHAuY29tPjsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgRGFuaWVsIEJhbHV0YQ0KPiA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPg0KPiBT
dWJqZWN0OiBSZTogW0VYVF0gUmU6IFtQQVRDSCB2MyAxLzddIGR0LWJpbmRpbmdzOiBhcm06IGZz
bDogYWRkIG11IGJpbmRpbmcNCj4gZG9jDQo+IA0KPiBDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVy
bmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3INCj4gb3Bl
bmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5n
IHRoZSAnUmVwb3J0DQo+IHRoaXMgZW1haWwnIGJ1dHRvbg0KPiANCj4gDQo+IE9uIDEwLzA3LzIw
MjMgMTk6NTIsIFBhbmthaiBHdXB0YSB3cm90ZToNCj4gPg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRv
Zi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gPj4gU2VudDogRnJpZGF5LCBKdW5lIDE2LCAyMDIz
IDY6NTEgUE0NCj4gPj4gVG86IFBhbmthaiBHdXB0YSA8cGFua2FqLmd1cHRhQG54cC5jb20+OyBy
b2JoK2R0QGtlcm5lbC5vcmc7DQo+ID4+IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9y
ZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gPj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVl
ckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiA+PiBmZXN0ZXZhbUBn
bWFpbC5jb207IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+Ow0KPiA+PiBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Ow0KPiA+PiBHYXVyYXYgSmFpbiA8Z2F1cmF2LmphaW5AbnhwLmNvbT47IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7DQo+ID4+IERhbmllbCBCYWx1dGEgPGRhbmllbC5iYWx1dGFAbnhwLmNv
bT4NCj4gPj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCB2MyAxLzddIGR0LWJpbmRpbmdzOiBh
cm06IGZzbDogYWRkIG11DQo+ID4+IGJpbmRpbmcgZG9jDQo+ID4+DQo+ID4+IENhdXRpb246IFRo
aXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZw0K
PiA+PiBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQg
dGhlIG1lc3NhZ2UgdXNpbmcNCj4gPj4gdGhlICdSZXBvcnQgdGhpcyBlbWFpbCcgYnV0dG9uDQo+
ID4+DQo+ID4+DQo+ID4+IE9uIDE2LzA2LzIwMjMgMjA6MTEsIFBhbmthaiBHdXB0YSB3cm90ZToN
Cj4gPj4+IFRoZSBOWFAgaS5NWCBNZXNzYWdlIFVuaXQgZW5hYmxlcyB0d28gcHJvY2Vzc2luZyBl
bGVtZW50cyB0bw0KPiA+Pj4gY29tbXVuaWNhdGUgJiBjby1vcmRpbmF0ZSB3aXRoIGVhY2ggb3Ro
ZXIuIFRoaXMgZHJpdmVyIGlzIHVzZWQgdG8NCj4gPj4+IGNvbW11bmljYXRlIGJldHdlZW4gQXBw
bGljYXRpb24gQ29yZSBhbmQgTlhQIEhTTSBJUHMgbGlrZSBOWFANCj4gPj4gRWRnZUxvY2sNCj4g
Pj4+IEVuY2xhdmUgZXRjLg0KPiA+Pj4gSXQgZXhpc3RzIG9uIHNvbWUgaS5NWCBwcm9jZXNzb3Jz
LiBlLmcuIGkuTVg4VUxQLCBpLk1YOTMgZXRjLg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6
IFBhbmthaiBHdXB0YSA8cGFua2FqLmd1cHRhQG54cC5jb20+DQo+ID4+DQo+ID4+IEkgZG9uJ3Qg
c2VlIHJlcGx5IHRvIERhbmllbCdzIGNvbmNlcm5zLg0KPiA+Pg0KPiA+PiBJIGRvbid0IHNlZSBp
bXByb3ZlbWVudHMgaGVyZSBiYXNlZCBvbiB0aGUgcHJldmlvdXMgcmV2aWV3IHlvdSByZWNlaXZl
ZC4NCj4gPj4gSXQgc2VlbXMgeW91IGp1c3QgaWdub3JlZCBldmVyeXRoaW5nLCByaWdodD8NCj4g
PiBSZXBsaWVkIHRvIERhbmllbCdzIGNvbmNlcm4uDQo+ID4NCj4gPj4NCj4gPj4gTGltaXRlZCBy
ZXZpZXcgZm9sbG93cyB1cCBiZWNhdXNlIGJpbmRpbmcgaXMgbm90IGluIHRoZSBzaGFwZSBmb3Ig
dXBzdHJlYW0uDQo+ID4+IERvIHNvbWUgaW50ZXJuYWwgcmV2aWV3cyBwcmlvciBzZW5kaW5nIGl0
Lg0KPiA+IERvbmUgdGhlIGludGVybmFsIHJldmlldy4NCj4gDQo+IEkgZG91YnQuIFlvdXIgdjQg
YmluZGluZ3MgYW5kIERUUyB3ZXJlIG5vdCB0ZXN0ZWQuIHY0IERyaXZlciBoYXMgdHJpdmlhbCBp
c3N1ZXMuDQo+IA0KSXQgaXMgdGVzdGVkIGFuZCBteSBkcml2ZXIgZ2V0IHByb2JlZC4gQW5kIGFs
bCBteSBmdW5jdGlvbmFsIHRlc3RzIGFyZSBwYXNzaW5nLg0KTm8gUGF0Y2gtc2V0IGlzIHNlbnQg
d2l0aG91dCB0ZXN0aW5nLg0KDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC3275EEBC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjGXJJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 05:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjGXJI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:08:57 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2052.outbound.protection.outlook.com [40.107.13.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39F71A4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:08:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lx19FkQQ637bOH8PBlGZQLe4KkdLehVSzWfAR8UQzg8pGq23DyrWMsb1ti2xCl1O3O7bMOFm+tVkU+XX5J/AQdYJP3q1Dt+I0UV2vm+syozpc4lW1ME8NtwK8EcZ1p8ArZpz8I22oH70VURfJXZrwXdF1m85v5JXPqv46+0i0WW/UzJyXUcze0pHwtyMRy/9WlR7yu7ZGr10uZn1PDFLqI/qgwO0I7AeiKPqf1ddW+jkZX7pr6jZ75pvr7Tn1jkL2jBPcwI0h4M7sgmALCSrY/PPk9bmR9RSIs5AX/3uEpRVNpRrZ2f8MGaNl9aXb1BWHL6Ux9xszKK20UTWuydXGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yY+FJGrSFsxg0NXqE/Rlrubdsiqo+u6eXc4YU6ag83c=;
 b=S6ydygIPIJ65IvhcgEBzulm2Da6TTiWS0/8Q77ire5pIpDKiUyat+18yFZk4lH3tzjlf7SCaMgMEWhSszGsFaFuM40UAxo0EdS73m64ddvBxvaKGoG4doQ3tyKVphoCJmrJVB1SCg3HEPwHEwGzAxrVmu0e29+O7+gawW+l6oy5/Ff1QHRuCLb9Sx99kW9pXafgeElcV9lBLXlfjggbxZirBri8WhHfOp2uov4UNiMGpJD9UgCshS3ANTle5hiYaqDhYvYu3O6kgCEWIoX92sAjfFOvWbMWYkV+oB2u6z/w/8RdG81nUQacj5/7nhRSLnyALWdcKh3yqeR0CePvo7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yY+FJGrSFsxg0NXqE/Rlrubdsiqo+u6eXc4YU6ag83c=;
 b=fsEQCNKq29nrFa572nW9+w+AScy2HK08yKPgtBFw368pKpin/ubnBXVADwlwRGhPOp6Dquj35y+wX0KH9XqcDo3G6Qbx4V1eTSxmura8g2dfXrmuiTBBQPYrPjA9payI2zinoDXBdtgX41zNU1LBnyxOWdrqueqzJCEr23q5u7M=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB9812.eurprd04.prod.outlook.com (2603:10a6:800:1d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 09:08:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 09:08:50 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 09/10] dt-bindings: power: fsl,scu-pd: support i.MX8DXL
Thread-Topic: [PATCH 09/10] dt-bindings: power: fsl,scu-pd: support i.MX8DXL
Thread-Index: AQHZvdAs/7CwOSzkt06CaKcQ+30RGa/InFWAgAAEtYA=
Date:   Mon, 24 Jul 2023 09:08:50 +0000
Message-ID: <DU0PR04MB9417363341C8A7EDF6BD737E8802A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230724014711.2048958-1-peng.fan@oss.nxp.com>
 <20230724014711.2048958-10-peng.fan@oss.nxp.com>
 <505c355e-a658-93bb-c981-8a6722b02522@kernel.org>
In-Reply-To: <505c355e-a658-93bb-c981-8a6722b02522@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VI1PR04MB9812:EE_
x-ms-office365-filtering-correlation-id: 2810ca64-baf3-47c4-06ad-08db8c2598c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pdKTYywLbE1p+njuRD6niteDgQtMnZi/4dcxy4hvThICBJgu3Mi2umPhKV3WZDPA0GUhSNkr6tfKebdXHqyIcRcl8nCe6jJUJfXcY9F/dhFSjU9vWKHVgqr3LNez3jGGi98iPYymIljgiPL0+CwKrdpjNijDQlsXCfkyiLO+p9HB3cItkyQXqRbmlxi88rZ4A0wJ9xJgxQOo9txEyokqsaCGqrS0apV193IVSL7W4zbx+VCZOEV+vh7zOs9Va8SQqbZn9QlyDeDpFqXlN+6t9cGf7OW74/3NiB4KjvgVCbog9tg3hzEbTiN5CaQeDLDSfn/VNFRzg8/yyQd9e2aT3eRGkcr852f0SEeuMchpb6/LeLhcWI/1U7yomcpSTZVJK1rHPT+H0GD3Ty6KsvjPFzi2Y+oxPD9++bra7GNnXZj1yIM8IVCoXbfTZ31FatVBHyvKyy8CFHQLFtYdT2U3P4vx4TresWi6zFOR7htJ8lT1daisVj9ew86trZM6yV/aY7CPPG1qQD7wJyIphfIvB8hmtpbgasymj9YXTQrZtkoN4guqK1nuMBtSQLAVmfk2rsjvhRfIqi3RFKYtLz1DuFVSM2IfgFrz4mr9HCVCMk+/637zgRuXKQgPfj2q/hkW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199021)(5660300002)(186003)(53546011)(26005)(38070700005)(6506007)(76116006)(4326008)(316002)(66476007)(66946007)(66556008)(66446008)(41300700001)(64756008)(71200400001)(9686003)(4744005)(2906002)(7696005)(54906003)(110136005)(478600001)(8676002)(44832011)(8936002)(52536014)(86362001)(38100700002)(33656002)(55016003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUtwb2NWUHZXc3RRY1JOM1h1ZjhJTGhPTjZDaXdUWHRtRlRSN21wU1drKzlj?=
 =?utf-8?B?Y2ZGYXFYWWFlbE9hcUpab0RmYnMxQ2xoV2hocmtQWXlvMmY4NHNxNlJvdHc4?=
 =?utf-8?B?eFVUZ0ZRWEhzZmdDWkF1SGhxbUdxNDBzZjhLWXJ2NTc2c29aODYrVDJjNlFM?=
 =?utf-8?B?b29IQ2h5czkvdmdqcFVFWFhEWERQV1RyYWlreDlOb3pTUUpzc3AvN3JyNkJp?=
 =?utf-8?B?cEVYQ0JCZWNRcDJ2NnY2S1MyUVhOelNSQ0FTMEhXZ01JeS9mcmdWYmxVVkY2?=
 =?utf-8?B?MC95aWhTUFVyZzcyQjFCZW5lbHRRcTc3M1UrZTMyQjlTK1RUU3FqQTFLNEg1?=
 =?utf-8?B?NVU4QkNIZ25zVzIzSDBlcjZuOHVCOWcvWktZSU5iSHB5RHlQWVAreG45dzlu?=
 =?utf-8?B?Mk44Um1HS1lYTVF6akFEVlZ4Y1VEU29VU3FzOFg2RHV3djA0bGpOT3pQVVJh?=
 =?utf-8?B?bnMyb2FJTzhZbW4vRFlwK1JLSkdtYXZUUmQyOGVvM00zY0k0NnY3UWpWU0FD?=
 =?utf-8?B?L0p5MG5jbm9aUHh4T1d0dDgvOWc0Zncra1FXVTRBQXlxWHZiN0w2S2xaZldS?=
 =?utf-8?B?MkhyZ3pCbllxY2lYSmVkUzZrYUNPQ2xBRUZYMy9POFlqZDkzWTAzRUpwZ0ls?=
 =?utf-8?B?YWdSWW9TWUdTUk9BcUZNdTYvN0xrdzZndUowZ1l6MVI2ZHpNaE9wckJNZzVi?=
 =?utf-8?B?TmIrZ21peERsTStvTHFOU3NEb01rN2dLL1J5dHQ3ZTJyOHZSUGlydTdjdjhj?=
 =?utf-8?B?WUoySkxMRlh6aGFYVmI3WmFYOWhJeTV2b0ZKU0t3T0FqODI0WFpLMXJtT1VQ?=
 =?utf-8?B?ek1WOS8rKzBCakFkN3ZKb3luQ1A1QUVRNXlmZXpjTWRFeXoyQnpLVm1wemFq?=
 =?utf-8?B?WTU2WFZBTS95ak5iSFV4Y0tSSS9pcitNU1k3VEtaN2xxampCdFlpcUNnSVIy?=
 =?utf-8?B?NmpMdEkvcHR5alNYTDRGbzJmdkVyMHRTUkVmQ0FjSFJaUkFqY2h3UzB3ZVBS?=
 =?utf-8?B?a2Zla3dUUTVJdTlqczRvT2lOdllRTEtBandmb1FzQWhod2E1dSt0WndNUDY1?=
 =?utf-8?B?dlUyQ0tER21LakJsRUpQTXJhblF1NU91RGZ2V2ppeGF3QWQwRlBoNFBnK0E1?=
 =?utf-8?B?WDRVRnhkUGt3VzFBU3RTaEl5bU1JK2RQczNkNEpqcVpoMWhBUmhnWUQ5ZEhy?=
 =?utf-8?B?bWYvSDhocEdLWlhhSlNzeGZJaURvb2tmWTZHTG52SlNoMDZ6RkpoNFg2Tytw?=
 =?utf-8?B?WHUwWTlzTlJ1cllUbFFXOEo2WnVYb2hRTGFoMThlWDJ6VndTWVFaTjMxcUVv?=
 =?utf-8?B?NTJyY0tEbE1IcnJLYTdrNnFyN3EvOVFXV0Jnb0V1Nk1wbU5VMlZVdmxieFND?=
 =?utf-8?B?SlU1WFRXOTBHVjBZVmdHSytoZkIzS1JBSk1MM1FhRGVxL1RKa0pFN3BwT3NJ?=
 =?utf-8?B?bTJqdnJxVXBsemErT2ZtWk5zeG5IRGUxRDFlM1o3cU1Dc2JZUjRnWDNmdmlE?=
 =?utf-8?B?bkU3azh2eGQ1dDZMcUxjcTFCTVpZd1lWbVkzTU9sd0dCT2Flc25KeGs3N3RS?=
 =?utf-8?B?dEFTOWV2UnVIcnN3RGVJL0RHL05KNE1WeGZ1eFBETjRidFpmb0g0cDZYMktH?=
 =?utf-8?B?dEhWaEpwQmExdFQ0bDdJV1krREh5b0c2Z1dPUGIzUG1jM2szaVFnS2ZCYVZK?=
 =?utf-8?B?MGxyNXZneW0yTCtOL2lYM3Q2eFBjd29ZZWNoaUJiRHQwQWpad2FGS2hsa1c5?=
 =?utf-8?B?Z2RzSFcyVVZLK0p2ZWVOYlBKUUFYTHoyVkJJMGp0YUI1NG90MDhrZHpRejhs?=
 =?utf-8?B?RXBvWnYrc015M3A1Sm5aZVlxSXM2cjU4WVBLSmNWWW5DVmZXWHJ0WDlwTjBS?=
 =?utf-8?B?dDVMdUpmV0ZDQm5mbWpXYWU0dnRvamRtclZ4b1ErRHMvVGlOYWVGS0JhSFBV?=
 =?utf-8?B?NE1GMVI4NWNxSzEyV3A2RlVXeXY1eEcvSGRTdVFFb0YrWWVIRFlHcWtHOGRw?=
 =?utf-8?B?MHI1Y1ZXQURNRGxkbTIxSzBvTEp4YTJQdUVvUlBkWlEwanhXSHU0alJxK0Vq?=
 =?utf-8?B?dVRDUW5NZ0U3eUlUTEVUUUZ5NVBENHBMeFlJWTM4Ynd1VndKRFEvSGhORCtp?=
 =?utf-8?Q?lkow=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2810ca64-baf3-47c4-06ad-08db8c2598c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 09:08:50.7203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RpKIMlJqvnl1nCQqOR647++kh5+0/lrSSaIS5chsQujWpZRf48m2xPcVMgi/k65/tPTQlgEiUjWcsz6Wyu+XMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9812
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDA5LzEwXSBkdC1iaW5kaW5nczogcG93ZXI6IGZzbCxzY3Ut
cGQ6IHN1cHBvcnQgaS5NWDhEWEwNCj4gDQo+IE9uIDI0LzA3LzIwMjMgMDM6NDcsIFBlbmcgRmFu
IChPU1MpIHdyb3RlOg0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+
DQo+ID4gQWRkIGNvbXBhdGlibGUgc3RyaW5nIGZvciBpLk1YOERYTA0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IA0KPiBQbGVhc2UgdXNlIHNj
cmlwdHMvZ2V0X21haW50YWluZXJzLnBsIHRvIGdldCBhIGxpc3Qgb2YgbmVjZXNzYXJ5IHBlb3Bs
ZSBhbmQNCj4gbGlzdHMgdG8gQ0MuIEl0IG1pZ2h0IGhhcHBlbiwgdGhhdCBjb21tYW5kIHdoZW4g
cnVuIG9uIGFuIG9sZGVyIGtlcm5lbCwNCj4gZ2l2ZXMgeW91IG91dGRhdGVkIGVudHJpZXMuIFRo
ZXJlZm9yZSBwbGVhc2UgYmUgc3VyZSB5b3UgYmFzZSB5b3VyIHBhdGNoZXMNCj4gb24gcmVjZW50
IExpbnV4IGtlcm5lbC4NCj4gDQo+IFlvdSBtaXNzZWQgYXQgbGVhc3QgRFQgbGlzdCAobWF5YmUg
bW9yZSksIHNvIHRoaXMgd29uJ3QgYmUgdGVzdGVkIGJ5DQo+IGF1dG9tYXRlZCB0b29saW5nLiBQ
ZXJmb3JtaW5nIHJldmlldyBvbiB1bnRlc3RlZCBjb2RlIG1pZ2h0IGJlIGEgd2FzdGUgb2YNCj4g
dGltZSwgdGh1cyBJIHdpbGwgc2tpcCB0aGlzIHBhdGNoIGVudGlyZWx5IHRpbGwgeW91IGZvbGxv
dyB0aGUgcHJvY2VzcyBhbGxvd2luZw0KPiB0aGUgcGF0Y2ggdG8gYmUgdGVzdGVkLg0KPiANCj4g
UGxlYXNlIGtpbmRseSByZXNlbmQgYW5kIGluY2x1ZGUgYWxsIG5lY2Vzc2FyeSBUby9DYyBlbnRy
aWVzLg0KDQpUaGlzIHBhdGNoIHdhcyBzZW50IG91dCBpbiBhIHdyb25nIHBhdGNoc2V0LiBTb3Jy
eSBmb3IgdGhlIG5vaXNlLg0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMs
DQo+IEtyenlzenRvZg0KDQo=

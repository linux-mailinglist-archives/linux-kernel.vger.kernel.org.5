Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE247846AD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237540AbjHVQOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbjHVQOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:14:33 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2086.outbound.protection.outlook.com [40.107.105.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0B6187;
        Tue, 22 Aug 2023 09:14:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KM5RzhESSBtYsRlz9H9/150bukdwpbOb4cjtvIJ+HztSzQV4Z0hfrTk9KYMYKOpLZNXdJ3d5XlI6cFb1vTg6wKAZfAvAyN146mVZeUILrQ/BOXuKX7RIpHNtqaNduKiM0ziEHzmpMSy4j1Osex7kMNKNx1dkNDECxio0Wyr4yuUsTs3BK56fuSrXAlWfsKlPwkvL6ssFJefm9NjPDhuL+PFRKIVXmn0NJ9SvGRfWWxrItTKZIMVwGohmBRMbpeWs5mne0FtfwcDKXeiuXB7WksB7b+WeozI8tH486ripJdFYs61QnMN6AfEgMAdeSA/dcyGASfW+g48Q5j0dwK4DQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/d6cZUVfOg1yUNDZkJyVTJ8oZxwlkPOiRfMA9K7LoA=;
 b=INTNMnuXmTJXLXwiTAem1hZRNCGejh4qbXJO1tmjit8HCPrTLNJP7mPrqKhdKNeHiMZc/Tw1rjx1qBIEEqOFV1fapkX6rwymjG6vxxdIC75FLat9NBCaG0+WrYJhNg4f6+GSjB4aRKYckh4svLg4MAHzBYMMTaXMuRi8IiVxkXEebNLneRXnBl7gThhJAAtYrc54xDjaDkmNlk576iqRe8AOyNrr0tzKAng5YtGqb9q/qa7kAJLxmmVkvGUKZKycWEcz9SaPKfqVVKZcLJYDpuhr6QShKhCluz++yEqAn7CE6+WyQsqYb/NjhY8S0DjA0326MUylAenf6tZ30hyRlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/d6cZUVfOg1yUNDZkJyVTJ8oZxwlkPOiRfMA9K7LoA=;
 b=OsE+1XdlqRgxoD5HaDS1jxsdw0O0PC9uN8At1EumS2lzkWcE9BBJTn/Cirn5UYV3t3NdmVaQUsJNCBNX6JyeRKhxv4kOiuLEyj2PHxdlZVC1YiM7mwbNAtbquU9RUYgCHjUYOLBEwlWdNddXVqucOka32j89sRFE9fw/gPBapGc=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DB8PR04MB6891.eurprd04.prod.outlook.com (2603:10a6:10:112::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 16:14:28 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 16:14:26 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
Thread-Topic: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
Thread-Index: AQHZ1RO40eWaaiBRyke8khzjoQfBiw==
Date:   Tue, 22 Aug 2023 16:14:26 +0000
Message-ID: <PAXPR04MB91854737165338C33DBC57A7891FA@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230818153446.1076027-1-shenwei.wang@nxp.com>
 <CAL_Jsq+XA_P-aRK9_WuGPmJ0_xJgsSr9smZy4BRbKZbmVsMQBQ@mail.gmail.com>
 <PAXPR04MB918539A19B8F817F623BBD1F891BA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <9927403d-6dd9-3e5e-8f9d-f38e6640f95f@linaro.org>
 <PAXPR04MB91850D8807CE374BD7C30CC5891EA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <CAL_JsqJ3dr7gxq+D5DYG8oQ=igzjARz=beQoYL7rrydV4SwDTw@mail.gmail.com>
 <PAXPR04MB918567C378D420DB4830B869891FA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <51bc0ccf-425b-5f16-b8f2-94d7cc979fae@linaro.org>
 <PAXPR04MB9185F7B520E8BE94B97C4908891FA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <e146782f-a93c-e694-1b08-7c2dba597bcf@linaro.org>
In-Reply-To: <e146782f-a93c-e694-1b08-7c2dba597bcf@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|DB8PR04MB6891:EE_
x-ms-office365-filtering-correlation-id: df644c80-71da-431b-18cd-08dba32adb73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JY8UsFoaXH2bUn6KxjESz5wcN9ZboTwM23H8xUlDQ2h9TO9NolY23UR7VoX3pEhbN21XGQX7TTnb23NBWbgkToPspy1uQABrKSODi+U6VOaqsY2M4TfhOp2jZAPKoyMDSwYMd4F53UguhMy7+K1X9h6nvNxZqZO3jCf+VCrhAjHqkdPJYY8cVPGgPERitTj/S/zMAHyTXfd41LisJD3++1AbzpIo0F5PZAFSbGBXVTIoR7EhhU1nCTdqfKh7OD7WbZmYQ8g+LfhUN8VydzQMqzmxtr/+JHl3ThOpCbb8w+VK0L5fLkEPXUQg+qG467tN6BIwh3jxcO5WSfGMihA2X1WLIdpEu1/9NjurskaTH4Sun8wkl+73SBcjWFORVifU1VvNEh7Vr+vcCOhrhOhU2mmwsz4id5bBY2B/Ko94N9hAcXFyj6OUKJZ+98ucSTjTz+kXGBbXCU+Pc8RMIj9GsOB1VncUV9+OTd5nVYAs4Rc9NyJbAMznOov2TwYWuQzaMgJl2m1lpGYXBnzlzOryWf8pk02Vc0zNxiSCnYr1hJqKOBPtPnSRHLnZTZGpeZsdiqzIOF7t0OCoGP8QdTFVmrQU2up5wBKqYcma5E2P5qNd5tPV00kSK4PuHdYSlxLj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(1800799009)(186009)(451199024)(54906003)(76116006)(66476007)(66446008)(66556008)(64756008)(316002)(66946007)(9686003)(110136005)(8676002)(8936002)(4326008)(41300700001)(478600001)(122000001)(55016003)(71200400001)(38100700002)(38070700005)(53546011)(6506007)(55236004)(83380400001)(2906002)(7416002)(7696005)(86362001)(44832011)(5660300002)(26005)(33656002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmNtMU82MFZHYTRrMjJ3Y3VabXNsMFpZNWd0TU5PQ0pZeER4UnY0eERtS1lj?=
 =?utf-8?B?Ri9tUTE4U29IY1dGcVMrTmtsZ0h1dk5mMnp3TXU3d09nUjdWY3lvSVN3eUs4?=
 =?utf-8?B?ck11YzZuMitjVTZmWGUrK0V1eFh3RGUzNXdBeDlTUmp2M3Z6Qm1GOENOdVAx?=
 =?utf-8?B?aXA5eXBpY3I5Z3FtYjV1QjRZSVAzWTFBRjhITDA0a3MrRE91YStZMFFIZDFO?=
 =?utf-8?B?SjMzbnBTakZocWRwdjhIVExvQXhrZ2hvdDFVRDc5NDViMGRXa3NnRXdBbjda?=
 =?utf-8?B?S000NFh4a2tCYUthTVA5bFUzSCtTbGFVbGUwZXhzRElSUnpzQTAyTDU0NmMw?=
 =?utf-8?B?M0gxS2FJRi9mNTdKSzIrTHFKczBjRFdDb2YyVkU4eC9mOWM1YXFzSzVEeXpF?=
 =?utf-8?B?YWhhQkdoV1ZEOU5vOW13STZUUFR1cTFUdU5PLzJKeFBjc3lwOHJ4MFFWY01P?=
 =?utf-8?B?Nk9FYlFiSzJiNGVaVUk0SDVmdTBpS2FFUkFVRkdPOERoL2NQd21ORVRURHZX?=
 =?utf-8?B?bjZtaGJCdXJwMmZ6OUNWdUtTbldOSndaYmsvanRWRW1Xeml6QTU3TzAwTWhh?=
 =?utf-8?B?WDZxcXlmVXNIRkRBMFVpQXNndW50SDFOdEE0K0crUjJMc0l3MXNkNXNvNHJu?=
 =?utf-8?B?dkFURUxhTHhNeGZmanFldk5HaFo3ak95ejBDQUpIQXNzMGg1VUNkTDhVVjh5?=
 =?utf-8?B?Y3E2dGVhN0twNTI0bDFlOUdsK2Y0S1JXdDNnVE5Ia013U3NWL1hZbkFrYUd2?=
 =?utf-8?B?eVpibEpUZkZjSmY0bEhza1FibEo1MU1xWUdaSlB2ay9haHozOHgrVUExTGFt?=
 =?utf-8?B?SGxNV2FkSUgwVjJyeGJ3N0F1eFBTb29FbmhRRDRBN3FtK2lHYUlXZ1ZCa3do?=
 =?utf-8?B?alJMNmtiK1NxQ2YyNDIzWkZSUUdraGpBZjU1eE56a1YzRzdLVFpjSWM4aE5p?=
 =?utf-8?B?VzRTcE53c0phQVF4SDlyd1VmZWpXS3pQZVB3ekdCUmxpMlJtd3hWcXNCb3RI?=
 =?utf-8?B?Nk5zWlgyUXR3T3dKUGUyUUVGeWRhK0dKWElrcnRXSEMyMkQ0SEN4UDdMRVc0?=
 =?utf-8?B?cG16M0RrZUVIZUxDUFF3ZGU5Q3NHRDVnUW9JemtwRC9kZkc3YUlUR3lPcjZx?=
 =?utf-8?B?eTcyQzF2UjVBK2VDV1dVSlh1cTR2Wm5wYUtHSVZ0akx2LzRKZEN5SlkrZjU0?=
 =?utf-8?B?R282MU5aWkNzOEdINHYrYTBZSFA1bjBOQjJYcXJvK0xzdWNvK2pMRUdSaE94?=
 =?utf-8?B?eDU5VTJMNGsraEtpdjBLQ1VBWDZqSVFzcGx2bWxUdm4rdXhSMnNjZWFCVzBI?=
 =?utf-8?B?MHJLSnIxUDcyRVdZVHZkWDg4ZUJDck92YkNKd2pLUU1Fak9HS09uYzFwR2Ux?=
 =?utf-8?B?czlNT2dQRDFreC82MXhwcmNGQjU3bUlCbUI5SVgxSGprWTFOSytneDJqeW52?=
 =?utf-8?B?ZUZGcTNYNDM5L2I3OU8xdFAzWU5sZVNXeS9nMVRwTUV0Y0pqVWRFcEZDUkx4?=
 =?utf-8?B?VHhHQlVzNnFxSk4rTEJWZHJmM3lmN2xGaHNCMkdTdEJTMlptTjdEOHkwS3lR?=
 =?utf-8?B?K0FEYWZDVzZTaEtnVUJSVXg2cHdwZnRGbkpxU2VyTE5lWDF6dzNhNkVSMGF2?=
 =?utf-8?B?RHQzYis3dWw3cTlHd1lncmxSV2h5eEFTUnVnL1FORHFudC9vSmxUT0pXWGFz?=
 =?utf-8?B?SGhPVEE2ZFJ0cnZOVE1uVnpCL3lMTTNqVkF2b2FHNGkxWVY0UjNOVEJtQk81?=
 =?utf-8?B?VVcxM1J1a2o3c0hSc1NQQ0gzRUlib3dzOTNPYnloZVJONmFVQnlwQ0NjZDVv?=
 =?utf-8?B?MDc1TXFqK2VjVXNhckNqYVdNM3JXelNhZFI5Smt6Y3dWc3dzK0VJaHpEV2Rl?=
 =?utf-8?B?T01mTVRTaEdFbzZ2bUdoVm1qRmNKSW1KT3BQZVRzSEQ1UjRMdTJXT0F1aTRs?=
 =?utf-8?B?Z0FFNUcxeGg3cGw0aHBVeHlXSWRDZ1pxY0N2dnRGSXJ0dXg5L1AySGJjYnRJ?=
 =?utf-8?B?VDQ2Sk9kUGZJdGM5YlU4RkphZ3QySjZIMWhQeVJabnZJdmVneklKVnJXa3BY?=
 =?utf-8?B?ZWlBNEpxZlBqK0taaVk1aTVITTlydEdraXZJUWNhZzY5Z1FjRU83SHV4WGtR?=
 =?utf-8?Q?BXhToQjoIWBfQeSLUY5ZmZJST?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df644c80-71da-431b-18cd-08dba32adb73
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 16:14:26.8239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nW3OqpiUid8YaQDPOGrJkHfsMcLtspPEIQmEK8m+fqfQ8TjCniy8LKav+xuwvCCQK6ZPljX5nX1orfP/edQUog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6891
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBB
dWd1c3QgMjIsIDIwMjMgMTA6NTggQU0NCj4gVG86IFNoZW53ZWkgV2FuZyA8c2hlbndlaS53YW5n
QG54cC5jb20+OyBSb2IgSGVycmluZw0KPiA8cm9iaCtkdEBrZXJuZWwub3JnPg0KPiBDYzogS3J6
eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsgQ29u
b3IgRG9vbGV5DQo+IDxjb25vcitkdEBrZXJuZWwub3JnPjsgVWxmIEhhbnNzb24gPHVsZi5oYW5z
c29uQGxpbmFyby5vcmc+OyBMaWFtIEdpcmR3b29kDQo+IDxsZ2lyZHdvb2RAZ21haWwuY29tPjsg
TWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPjsNCj4gaW14QGxpc3RzLmxpbnV4LmRldjsg
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
DQo+IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbRVhU
XSBSZTogW1BBVENIIDEvMl0gZHQtYmluZGluZ3M6IHBvd2VyOiBBZGQgcmVndWxhdG9yLXBkIHlh
bWwNCj4gZmlsZQ0KPiANCj4gPg0KPiA+IFRoYXQgaXMgYXJndWFibGUgdG9vLiBUaGUgZHJpdmVy
IG1heSBhc3N1bWUgaXRzIHBvd2VyIGlzIG9uIHdoZW4NCj4gPiBwcm9iZWQsIHdoaWNoIGFsaWdu
cyB3aXRoIGhvdyB0aGUgUEQgYmVoYXZlcy4NCj4gDQo+IFNvIGV2ZXJ5dGhpbmcgaW4gZHJpdmVy
Li4uIG5vIGRpc2N1c3Npb24gYWJvdXQgYmluZGluZ3MuDQo+IA0KDQpUaGF0J3MgdHJ1ZSBvbmx5
IHdoZW4geW91IGhhdmUgYSBQRCBkcml2ZXIgZm9yIGl0LiANCg0KPiA+DQo+ID4+PiBJdCBhbHNv
IGxhY2tzIHBvd2VyIG1hbmFnZW1lbnQgc3VwcG9ydC4NCj4gPj4NCj4gPj4gV2hpY2ggaXMgbm90
IHJlbGF0ZWQgdG8gYmluZGluZ3MgYnV0IGltcGxlbWVudGF0aW9uIGluIGdpdmVuIGRyaXZlci4N
Cj4gPj4NCj4gPg0KPiA+IEZvciB0aG9zZSBzaW1wbGUgZHJpdmVycywgdGhlIGRlZmF1bHQgcG93
ZXIgbWFuYWdlbWVudCBsb2dpYyBjYW4NCj4gPiBoYW5kbGUgcG93ZXIgY29ycmVjdGx5IHdpdGhv
dXQgcmVxdWlyaW5nIGFueSBzcGVjaWFsaXplZA0KPiA+IGltcGxlbWVudGF0aW9uIGluIHRoZSBk
cml2ZXIgY29kZS4NCj4gDQo+IFlvdSBjYW4gY3JlYXRlIGFueSBkcml2ZXJzIHlvdSB3aXNoIG9y
IGNoYW5nZSBleGlzdGluZyBvbmVzLiBJIGRvbid0IHNlZSBhDQo+IHByb2JsZW0gaGVyZS4NCj4g
DQoNClRoYXQncyB3aGF0IHRoaXMgcGF0Y2ggc2V0IGRvZXMuDQoNCj4gPg0KPiA+Pj4NCj4gPg0K
PiA+IEFzIGEgbmV3IGRyaXZlciwgaXQgaGFzIHRvIGludm9sdmUgc29tZSBuZXcgYmluZGluZ3Mg
ZXNwZWNpYWxseSB0aGUNCj4gPiBjb21wYXRpYmxlIHN0cmluZy4NCj4gDQo+IEkgYW0gbm90IHRh
bGtpbmcgYWJvdXQgdGhpcy4gSSBkbyBub3Qgc3BlYWsgYWJvdXQgY3JlYXRpbmcgbmV3IGJpbmRp
bmdzLCBidXQNCj4gY2hhbmdpbmcgdGhlbS4NCg0KSSdtIGEgYml0IGNvbmZ1c2VkIGJ5IHlvdXIg
c3RhdGVtZW50LiBUaGUgcGF0Y2ggb25seSBjcmVhdGVzIHNvbWUgbmVjZXNzYXJ5IA0KbmV3IGJp
bmRpbmdzIGZvciB0aGUgbmV3IGRyaXZlci4gSXQgZG9lc24ndCBjaGFuZ2UgYW55IGV4aXN0aW5n
IGJpbmRpbmdzLg0KDQo+ID4NCj4gPj4+DQo+ID4gVGhhbmsgeW91IGZvciB0aGUgY2xhcmlmaWNh
dGlvbi4gVGhlIGlzc3VlIGlzIHRoYXQgdGhpcyBkcml2ZXIgaXMNCj4gPiBwdXJlbHkgYSBzb2Z0
d2FyZSBsYXllciB0aGF0IHdyYXBzIHRoZSByZWd1bGF0b3JzIGFzIGEgcG93ZXIgZG9tYWluLg0K
PiA+IFRoZSBiaW5kaW5ncyBtYWtlIHRoZSBpbXBsZW1lbnRhdGlvbiBjbGVhbiBhbmQgZWFzeSB0
byB1bmRlcnN0YW5kLiAgSQ0KPiA+IGRvbid0IHRoaW5rIHdlIHNob3VsZCBhZGQgZXh0cmEgY29t
cGxleCBsb2dpYyBpbnNpZGUgdGhlIGRyaXZlciBzb2xlbHkgdG8gYXZvaWQNCj4gaW50cm9kdWNp
bmcgbmV3IGJpbmRpbmdzLg0KPiANCj4gU2luY2UgYmluZGluZ3MgYXJlIG5vdCBmb3Igc29mdHdh
cmUgbGF5ZXJzLCBJIGRvbid0IHRoaW5rIHdlIHNob3VsZCBiZSB0YWxraW5nDQo+IGFib3V0IHRo
ZW0ganVzdCB0byBhdm9pZCBpbnRyb2R1Y2luZyBkcml2ZXIgY2hhbmdlcy4NCj4gDQoNCldoaWxl
IGl0IGlzIGEgc29mdHdhcmUgbGF5ZXIsIGl0IGlzIGEgZHJpdmVyIHRoYXQgcmVxdWlyZXMgYmlu
ZGluZ3MuIEkgZG9uJ3QgdGhpbmsgDQp5b3Ugd291bGQgcmVjb21tZW5kIGhhcmRjb2RpbmcgdGhv
c2UgcHJvcGVydGllcyBpbnNpZGUgdGhlIGRyaXZlciBpdHNlbGYuDQoNClRoYW5rcywNClNoZW53
ZWkNCg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

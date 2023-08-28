Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D66778B832
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjH1TYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbjH1TXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:23:52 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2074.outbound.protection.outlook.com [40.107.105.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE8011A;
        Mon, 28 Aug 2023 12:23:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULeym6T9MgREfkyGf1jKGso4eiWk/toM415wb/T4jgE6mRDUL4afjCRQObUnmgau1ACfP079tOyfVCTG2OWuXBvlYQSnQ4xkJ/oRma516mOIBgu5mX+EIRBY4mH2OuhgKEAqUnxk7cacBYEq5PnIS5qSWvlWgJb17IAG/1Cd4VvM++tTVAf8dT7kB+B68R5xgheb2vBkJRxSLATcSgAf8um1YArM90RWuWHRcA5J3T9Kft/EFvTyxIvbPkEwIBuZj+YWL180Rh72K2SVKr4qsoQfO5LcDNPwuwEX890a8pVKvqmfJkM25rs4bNJXf/33By7niH+GwlLk78f4PskJvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PphI9fPwhtLP8tppE2ZdvzFSXSWK9tu8tyCJbVOkUi8=;
 b=FDVAulTVmQiK29xWIObFaUidwO3TpNE5DCW2txguyjT+nT20RZLpk8F+f267tdey4ijCJYk3gnRbMDKs2hKM0iyonEbpbKJaL1r0OPim7DAZ6T0QHTlbqo3NPN/Iju1CmGy+5pBs26F1vl+raZJtyxzkcyzBVXqVHHw4eoo1rt/YrsKwiKMm7wY5Qq+Q8/4nyADv0uWRAjcE4RFhzWd0eWJBOERgV/11K64vvLLhc0W5Z9lnVep8Cn2RFEEVfCDLnG6vG0lBUd4GISnrTuf2w44IySjoC3wAW6ZwsZmO+GxpCir2RiKEmZ7/szca9NrIrLAnA/lV1rrx/equOkey4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PphI9fPwhtLP8tppE2ZdvzFSXSWK9tu8tyCJbVOkUi8=;
 b=JS4Yk8QFKYUgh413UBI5boB63ikp5ZRgfoqCASsSba46Evf6v/zhIhn4CHQyKyGXwyBMWksC0TWx11Fp3czsmdW018k4ndsQ4mmGyrLfxMcLYZkrvBgNALcDpjHrQNGgLi83FSbpROUy8MZ/2k3w7jman9GT/6gYt5Gjeo8vD0I=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 19:23:47 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 19:23:47 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [EXT] Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml
 file
Thread-Topic: [EXT] Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml
 file
Thread-Index: AQHZ2eMvcFa+iifit0Wlgxkc5z6VlLAAEyaAgAAAdoA=
Date:   Mon, 28 Aug 2023 19:23:46 +0000
Message-ID: <PAXPR04MB91851302EAB989EC8261AEFD89E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230818153446.1076027-1-shenwei.wang@nxp.com>
 <CAPDyKFqsn6kVjPFUdVyRxNDiOaHO9hq=9c+6eAK4N-v-LVWUPw@mail.gmail.com>
 <PAXPR04MB91858254554272C90822FED1891DA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <CAPDyKFoV2Z=-WUiF3SgXqhF+K+r5QqsLgz8_hau0WKfZxTzYpg@mail.gmail.com>
 <PAXPR04MB9185F6AA20B0440B8FAB847789E3A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <4e2c18e3-b1ed-6361-3998-5de060d2bcf0@linaro.org>
 <PAXPR04MB9185957B729588D3E7CA3A5089E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <51fe3126-16ba-ade6-b106-e3683f96ad26@linaro.org>
 <PAXPR04MB9185DC79721E78E631F9889589E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <154b36de-652b-3931-96e6-04e99253a09f@linaro.org>
 <PAXPR04MB91852AD4E5242306B57A910B89E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <f3e89479-14ab-d1d0-ad87-6f457f313c39@linaro.org>
 <PAXPR04MB9185D87525AA88A8C3543EEA89E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <465e61a0-895d-54b9-d1b9-424265c82855@linaro.org>
In-Reply-To: <465e61a0-895d-54b9-d1b9-424265c82855@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|PAXPR04MB8749:EE_
x-ms-office365-filtering-correlation-id: b2b0bbe4-105b-4b4c-fed1-08dba7fc4d12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kr5RxRahdjKTCiZwDNbK5ODqy12EU8siFHsfATH4KyJMgdTFXgmdzLzMnCsotaiMhaRC68eQSvMu22nswBjUAeFpJytTsWQCbvIekXxR6r6FnUINUh397MYCcBqyjLtSDctnnQUVo9l4UvDXyy3BQXTUh38BhOOtiMhg/S7NmC0Q6hc6jgDO/7fhedYrdOKn9lQiFdAxLE8GE5AIolelm387OIU+aS3doAiPjQavEApuebkgiURPdrYgxu8baLVrpYWOc73ON/Bgu/usDwjRMshSNSTwyNUYXMrjADiY9aI8W1kV2SLkj5bcrv8ByKRQngHNXxgBIpfom2ajSfs7JA2yZQoJ9BTdiwX8Umvd89OLg6RywM5qbzUGuyCc+Q7e1+1ovGGeutSJoHdl/XNFz83UxfrdoPeJJhIgVeQ2Zc0UsGklJ6vmga6U4CvnLwErOLDZquOkAllAi2JvKrKMt/pE9h3OG6ont0tL5DlcXrEeFGd+qpyAhOXO2yYHMIVtFDxkFveUZ2zY4D8bTd0Oz+TzUd5JDbWgKG+saQpwD1Rj/rN44hZbjB5E53NQwmCbZId9qOQ+Uwq1FsqRP1Ve2Ji7oqZhHeOdKIPBQDcQsDGYzZkXuRAFdhM5EZDm51zO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199024)(186009)(1800799009)(7696005)(71200400001)(55236004)(53546011)(6506007)(9686003)(55016003)(76116006)(5660300002)(86362001)(33656002)(7416002)(44832011)(2906002)(41300700001)(8936002)(8676002)(66556008)(110136005)(4326008)(64756008)(66476007)(54906003)(66446008)(38100700002)(52536014)(316002)(66946007)(38070700005)(122000001)(478600001)(83380400001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alNqZFdxSS81UkdqUytnY3ZLeFNOMzdkbDhINXJWWW9ER3pJNnJucjF4eTNT?=
 =?utf-8?B?MWVSbVpHVU1VRDc5Z0Jpc29TZEkvT29LdlAyVjZudjBIOG9xaldhM291aEMy?=
 =?utf-8?B?eHR1ZndteTk0VnJaR1lHZmtUa2k1K0tuYmsySWlHcXBrU2NZZVJHK25nRTlQ?=
 =?utf-8?B?dWt3ZjIzVVp0RGVnUXJRMlNiSXVSOHpSaTRFSi9HaDd4Z3MyK01UME9xS0dR?=
 =?utf-8?B?eU1OckVDSHJ5aTlSbTB4aFcxdE1tQ2JWSG5Qa0YvNFlja25Bb0VTVnhtRU41?=
 =?utf-8?B?NmpIWmprK29peGZOMzVHSTJPNlI2MFpySWcwbXJvcFd3UExJWlFZc1ZTK0FN?=
 =?utf-8?B?YktLTGdRSjJ3dytpTVpVNDZNUjV5dW00YXBiRDlTck5xYWJqd3lSZUcza2FL?=
 =?utf-8?B?SnRDVXY4K0tHN3k1NVRPK1Z2M292VHZIWnpyQ1NUb0ZNTWVxUHZvQjJncS9G?=
 =?utf-8?B?dUdhL2pPeE5rTG1VTjhHam5DUkpwZlRzQ0tzc1Z4dGZySnVGV2JzV0xCbXR4?=
 =?utf-8?B?MHdVZ1VLTFREdVY3ZmJQVjlJMXVmemRmVWVXYythTnA5UHdLUitvd1UyckR6?=
 =?utf-8?B?L2w0SGVjRzRtNUlVTVBzZ0RtTkdJTDJVSTRiKzB2NVFNenpTNFRnK1BhdFd3?=
 =?utf-8?B?eUdVMlRVZHBPME13UEY2bWM5ZkFWaGZ2TEpYNkF3NzNZZTNweFFpTERZWEsw?=
 =?utf-8?B?ck1JamNhZklCeUI4d2pCbDdTR1JqeC9Fdm42dHdBSFFhMHd5K29JNWJEdkwy?=
 =?utf-8?B?VkNJemU4NmU3U1dEdXZQMm5vNFZwS2VHM0NzM0JJQ0NKU3lYOEM0ZkFvMXVD?=
 =?utf-8?B?aE1PRVpBcTlkSkNJaVpieDlUdldITVVBQXU3djVveStGZjlHd0xXQ3R2RG5Y?=
 =?utf-8?B?ZGZKM0ZNTXQwQWxDZTdqSENVbDllOTFIZDBydFFkNkZGRDBvSjRqTVcvVWEz?=
 =?utf-8?B?Q1BwVHNSOStzOE5sMFBoa01HZEoxSjd5L0Y3Q2pRU3lhMEZjYk85SnNXdDAw?=
 =?utf-8?B?WkVLcDdvc0NjWDdrRExFbGREamQwdzBBazBWSUhtRTMrcTdDVHUvTm5MRTFn?=
 =?utf-8?B?ZDdzVzY4Mit0dW5UV2xpQXI0V3dxejUveUgvaGx3VStzVzczVWFOajU0bDMy?=
 =?utf-8?B?VlFaZ0c5UTJhdW16WGp2R2pIdUo0VkhMOXZiMWkvMTJyT2xCcDVuMmRjSzFp?=
 =?utf-8?B?U0NvdXJwSTFya2lvSG9FT05MUlR5WWR4aWxyZlBTL0NWT01iT1VWeGlFbHJQ?=
 =?utf-8?B?dlMrYzl6QTJNRHF0SUMrVXk4KzE0RFdyYk1BM2RqK3U2dFdIbHd5eTIrY2VQ?=
 =?utf-8?B?RzFMdk9BWEFqZ0dseVJSZTE4cjVHeTF4cnpJa0pzMFFjeGpTOUVUTDA5dTRj?=
 =?utf-8?B?Ukh2b2NPby9nU0czZzdKejRMNE1jYklFamNJeXBNQnBXRVlhVFhrd3p1QW95?=
 =?utf-8?B?TEV4VGxsWEwwdWhwejUySitmR3BMK2VYK2daMkdKYlYvc054VFEyTEV0WDNM?=
 =?utf-8?B?UDdsS21xdTlhRVg1RmF6ZEg2UHJkcTNodDNMUnh5b3A3RUtNbWRXTGZ0UTY2?=
 =?utf-8?B?T093Y3dlRGg0REtISTFCeXB5dUlnQ0tZbm1rd2F3LzNFUnd4ZGRIaTlNRXd5?=
 =?utf-8?B?NkZBRVFBYmdGeGsxaE9yVlFxaXdYT3oxa1VHNFlkUVMwbDdCc1p2OUR2L3lW?=
 =?utf-8?B?Mm1EZGtZM0xMZWlOd3lOcENYcDZwVFBneEJxZ2JEK2h2aFBDQ1RUeTgyY05q?=
 =?utf-8?B?a2JjZXFZdmZGZG9rVjRiZXRWZFhnM2pzQ01SSmFqcm5FY0FqNURQQ2FGMEpD?=
 =?utf-8?B?WEhyQ05CVGpBY1hzR2IvWlorNVdkTkNhRmJUUVppdHhqeDMxbDlhd1NwSU5W?=
 =?utf-8?B?NlRCL0UwZnpXNExCRllLYWREK3ZqVDBIbHdZaUFCYUZKNVlIQk1ocHBSS0w5?=
 =?utf-8?B?eVFrbWpZNlc1OWR0UWUxRGxqaHJGM2c3NXBHTm45MHFza0wxYnpzOTBwRE5r?=
 =?utf-8?B?VnZOazZsakxwdDVXSE54dzIxd3dLVnkzbmdHV1VIN1dDVUJCaUpkaFgwaTR1?=
 =?utf-8?B?NWRvaGloazZicFBFaXMyaGVDa0lFZ3dHdmR3LzFXREx1Y2hhY01BMklUaGxV?=
 =?utf-8?Q?3GGolC+fiHFV+gx4hd/Ypf7zl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b0bbe4-105b-4b4c-fed1-08dba7fc4d12
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 19:23:46.9734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IotbbMhRaJc8uNpYxGZDvjIz2wyj8NB1BRqFUgt5Y/H3szQislozAERpsFGFj2QNJUc2O6bYaxB/itD6tKGanQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8749
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBNb25kYXksIEF1
Z3VzdCAyOCwgMjAyMyAyOjEyIFBNDQo+IFRvOiBTaGVud2VpIFdhbmcgPHNoZW53ZWkud2FuZ0Bu
eHAuY29tPjsgVWxmIEhhbnNzb24NCj4gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IENjOiBS
b2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPiA8
a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitk
dEBrZXJuZWwub3JnPjsNCj4gTGlhbSBHaXJkd29vZCA8bGdpcmR3b29kQGdtYWlsLmNvbT47IE1h
cmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz47DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0K
PiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBbRVhUXSBSZTog
W1BBVENIIDEvMl0gZHQtYmluZGluZ3M6IHBvd2VyOiBBZGQgcmVndWxhdG9yLXBkIHlhbWwgZmls
ZQ0KPiA+Pj4+Pj4+Pj4gQXJlIHlvdSBzdWdnZXN0aW5nIHRvIG1vdmUgdGhlIHJlZ3VsYXRvci1w
ZCB0byB0aGUgaW14DQo+ID4+Pj4+Pj4+PiBkaXJlY3RvcnkgYW5kIGFkZCBhIGNvbXBhbnkgcHJl
Zml4IHRvIHRoZSBjb21wYXRpYmxlIHN0cmluZz8NCj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4gVGhl
cmUgaXMgbm8gc3VjaCBwYXJ0IG9mIGlNWCBwcm9jZXNzb3IgYXMgc3VjaA0KPiA+Pj4+Pj4+PiBy
ZWd1bGF0b3ItcG93ZXItZG9tYWluLCBzbyBJIGRvbid0IHJlY29tbWVuZCB0aGF0IGFwcHJvYWNo
LiBEVFMNCj4gPj4+Pj4+Pj4gbm9kZXMgcmVwcmVzZW50IGhhcmR3YXJlLCBub3QgeW91ciBTVyBs
YXllcnMuDQo+ID4+Pj4+Pj4+DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBUaGF0J3Mgbm90IGFsd2F5
cyB0aGUgY2FzZSwgYXMgd2UgZG8gc29tZXRpbWVzIG5lZWQgYSB2aXJ0dWFsIGRldmljZS4NCj4g
Pj4+Pj4+PiBBcyBhbiBleGFtcGxlLCB0aGUgInJlZ3VsYXRvci1maXhlZCIgYWN0cyBhcyBhIHNv
ZnR3YXJlDQo+ID4+Pj4+Pj4gYWJzdHJhY3Rpb24gbGF5ZXIgdG8gY3JlYXRlIHZpcnR1YWwgcmVn
dWxhdG9yIGRldmljZXMgYnkNCj4gPj4+Pj4+PiBpbnRlcmZhY2luZyB3aXRoIHRoZSB1bmRlcmx5
aW5nDQo+ID4+Pj4+PiBHUElPIGRyaXZlcnMuDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gTm90IHRydWUu
IFRoaXMgaXMgYSByZWFsIHJlZ3VsYXRvciBkZXZpY2UuIFJlYWwgaGFyZHdhcmUgb24gdGhlIGJv
YXJkLg0KPiA+Pj4+Pj4gWW91IGNhbiBldmVuIHNlZSBhbmQgdG91Y2ggaXQuDQo+ID4+Pj4+Pg0K
PiA+Pj4+Pg0KPiA+Pj4+PiBUaGUgcGh5c2ljYWwgaGFyZHdhcmUgY29tcG9uZW50IGlzIHRoZSBH
UElPIHBpbiwgd2hpY2ggaXMgd2hhdCB5b3UNCj4gPj4+Pj4gY2FuIG9ubHkNCj4gPj4+PiB0b3Vj
aC4NCj4gPj4+Pg0KPiA+Pj4+IE5vLiBUaGUgcmVndWxhdG9yIGlzIHRoZSBjaGlwLg0KPiA+Pj4+
DQo+ID4+Pg0KPiA+Pj4gSW4gdGhlIGRlZmluaXRpb24gb2YgZHRzIG5vZGUgYmVsb3csIHdoZXJl
IGlzIHRoZSBjaGlwPyBUaGUgcmVhbA0KPiA+Pj4gaGFyZHdhcmUgaXMganVzdA0KPiA+PiBhIEdQ
SU8gUGluLg0KPiA+Pj4gICAgIHJlZzE6IHJlZ3VsYXRvci0xIHsNCj4gPj4+ICAgICAgIGNvbXBh
dGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsNCj4gPj4+ICAgICAgIHJlZ3VsYXRvci1uYW1lID0g
IlJFRzEiOw0KPiA+Pj4gICAgICAgcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MzAwMDAwMD47
DQo+ID4+PiAgICAgICByZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwzMDAwMDAwPjsNCj4gPj4+
ICAgICAgIGdwaW8gPSA8JmxzaW9fZ3BpbzQgMTkgR1BJT19BQ1RJVkVfSElHSD47DQo+ID4+PiAg
ICAgICBlbmFibGUtYWN0aXZlLWhpZ2g7DQo+ID4+PiAgICAgfTsNCj4gPj4NCj4gPj4gVGhlcmUg
aXMgYSBjaGlwLiBUaGlzIGlzIHRoZSBjaGlwLiBJZiB5b3UgaGF2ZSB0aGVyZSBvbmx5IEdQSU8g
cGluLA0KPiA+PiB0aGVuIHlvdXIgRFRTIGlzIGp1c3Qgd3JvbmcuIERyb3AgaXQuIElmIHlvdSBs
ZWFybiBmcm9tIHdyb25nIERUUywNCj4gPj4gdGhlbiBzdXJlLCBwb3dlci1kb21haW4tIHJlZ3Vs
YXRvciBzZWVtcyBsaWtlIGdyZWF0IGlkZWEuLi4NCj4gPj4NCj4gPg0KPiA+IFdoZW4geW91IHRh
bGsgYWJvdXQgdGhlIGNoaXAsIGNhbiB5b3UgcGxlYXNlIGJlIG1vcmUgc3BlY2lmaWM/DQo+IA0K
PiBXaGF0IHRvIHNheSBtb3JlPyBUaGUgZGV2aWNlIG5vZGUgeW91IHF1b3RlZCBhYm92ZSBpcyB0
aGUgcmVndWxhdG9yLiBZb3UNCj4gYnJvdWdodCBzcGVjaWZpYyBleGFtcGxlIGFuZCBub3cgY2xh
aW0gdGhpcyBpcyBub3QgYSByZWd1bGF0b3IsIGJ1dCBqdXN0IEdQSU8uDQo+IFBsZWFzZSBmaXgg
eW91ciBEVFMuDQo+IA0KDQpUaGUgZml4ZWQtcmVndWxhdG9yIGlzIGEgdmlydHVhbCByZWd1bGF0
b3IgZHJpdmVyIHRoYXQgdXNlcyB0aGUgR1BJTyBwaW4uIFlvdSBjbGFpbWVkIHRoaXMgDQphcyBh
IGhhcmR3YXJlIGNoaXAuDQoNClRoZSByZWd1bGF0b3ItcGQgZHJpdmVyIGFsc28gdXNlcyB0aGUg
c2FtZSBHUElPIHBpbi4gWW91IG5vdyBjbGFpbWVkIHRoaXMgYXMgYSBzb2Z0d2FyZSBsYXllci4N
Cg0KV2hhdCdzIHlvdXIgc3RhbmRhcmQ/DQoNClRoYW5rcywNClNoZW53ZWkNCg0KPiA+DQo+ID4g
UmVnYXJkaW5nIHRoZSBkdHMgbm9kZSwgaG93IGFib3V0IHRoZSBleGFtcGxlIGluIHRoZSBmaXhl
ZC1yZWd1bGF0b3IueWFtbA0KPiB1bmRlciB0aGUgYmluZGluZ3MgZGlyZWN0b3J5Lg0KPiANCj4g
VGhhdCdzIGFuIGV4YW1wbGUsIGhvdyBpcyBpdCByZWxhdGVkIHRvIGFueXRoaW5nPw0KPiANCj4g
Pg0KPiA+ICAgICByZWdfMXY4OiByZWd1bGF0b3ItMXY4IHsNCj4gPiAgICAgICBjb21wYXRpYmxl
ID0gInJlZ3VsYXRvci1maXhlZCI7DQo+ID4gICAgICAgcmVndWxhdG9yLW5hbWUgPSAiMXY4IjsN
Cj4gPiAgICAgICByZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwxODAwMDAwPjsNCj4gPiAgICAg
ICByZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwxODAwMDAwPjsNCj4gPiAgICAgICBncGlvID0g
PCZncGlvMSAxNiAwPjsNCj4gPiAgICAgICBzdGFydHVwLWRlbGF5LXVzID0gPDcwMDAwPjsNCj4g
PiAgICAgICBlbmFibGUtYWN0aXZlLWhpZ2g7DQo+ID4gICAgICAgcmVndWxhdG9yLWJvb3Qtb247
DQo+ID4gICAgICAgZ3Bpby1vcGVuLWRyYWluOw0KPiA+ICAgICAgIHZpbi1zdXBwbHkgPSA8JnBh
cmVudF9yZWc+Ow0KPiA+ICAgICB9Ow0KPiA+DQo+ID4gSWYgeW91IHRha2UgYSBsb29rIGF0IHRo
ZSBmaXhlZCByZWd1bGF0b3IgZHJpdmVyIChmaXhlZC5jKSwgSSBkb24ndA0KPiA+IHRoaW5rIHlv
dSdsbCBmaW5kIGFueXRoaW5nIHJlbGF0ZWQgdG8gYSBoYXJkd2FyZSBjb21wb25lbnQgKGNoaXAp
IG90aGVyIHRoYW4NCj4gdGhlIEdQSU8gUGluLg0KPiANCj4gVGhhdCdzIGEgZHJpdmVyLiBIb3cg
aXMgaXQgcmVsYXRlZCB0byB0aGlzIGRpc2N1c3Npb24/IEJpbmRpbmdzIGFyZSBub3QgYWJvdXQN
Cj4gZHJpdmVycy4NCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

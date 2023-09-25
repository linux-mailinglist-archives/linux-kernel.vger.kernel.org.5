Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB017AD343
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjIYIYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbjIYIX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:23:56 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BAF124;
        Mon, 25 Sep 2023 01:13:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHOaZPw6I2SD38WfsCMx3gHBTJCyNgG8Mf6WlATHmyqV46Jm4JJ7THnNu5W0lKeb72rIfmnN6Re43VGrupin390pGNdMf6ok4x8Asp7FSLNylvDRTTA8QmBwlpP92d6FelN836zuMVncBLLxQXcv4EhAKN58GwkwqRhOsFBktbnFzPEFeritUDcmcBrE1YZocHIYzRD4GI2ch1+cnQ5liPms8AqdLuWg7TdCj9FMTstHAxSskWFAhIae8Vv4CGtTWOfEvzSziMCiLhfGNl4JGSX4nTMHFfPdm/xqEgvKeE2Cz914MwhQkwl238uIaKlOtB1SR3OpBisRv+CNxVSz+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/TVVpqXhA3JAz+pAZCTUeyHOQkZ48uhdKNvIsFWWRI=;
 b=QZmyWTJWKm9UlvhYY/AP1B8v7lXkAz2eAMiz2HOe6Uv3B7RYtpVdg5/liHOBcwqfOt7Fl95qau6oYuhU4u7YmaIujQS4cFqLRR4v/uMnK9XRTGaRe/r6JD2mFf0cswfVPfPgzTmKyZX409ubnoW1Z+obMhPa+oOjJOFCmMXQVfHFWdqyD0xZx3LJlv+iJuAUcRMpMCYhnYDyRffU07uXSzHUqtx4S5YoiBAGCfgwZkDeMxIVBWN7WNJ8BYo6V/S928H0tHbRnaXR+uO1w/iWTIftizvZWolxHXt/qKuPOy86EETpCZY5Ofn/MYcBs0LG8d6gJkTtvZy3Df5yTEbdrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/TVVpqXhA3JAz+pAZCTUeyHOQkZ48uhdKNvIsFWWRI=;
 b=M8YG89s7MnGpj7LpkcM+aIjPsdlL5Z+6dzPtUEx+GuHZAiQTAb0ianOwqKwELPJP0T8slzNNX0ulN54nvbZ1Gnj9GNKYxXB6fB0WhHstFsaE5/PQpxWkdmaCENfBaEf1BwddYe5KMc+A6ReOu1iX0cj9iWkIv3oFcCNK9Lz/EpU=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS1PR04MB9477.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:13:02 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:13:02 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>, Eagle Zhou <eagle.zhou@nxp.com>,
        Tao Jiang <tao.jiang_2@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v3 2/2] dt-bindings: media: imx-jpeg: Assign
 slot for imx jpeg encoder/decoder
Thread-Topic: [EXT] Re: [PATCH v3 2/2] dt-bindings: media: imx-jpeg: Assign
 slot for imx jpeg encoder/decoder
Thread-Index: AQHZ74PEbqAT2ziWZ0ufS4Z9Kh2CJrArLgAAgAAA7LCAAAFigIAAAItA
Date:   Mon, 25 Sep 2023 08:13:02 +0000
Message-ID: <AM6PR04MB63410BEA725DDBF1D1B7814FE7FCA@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20230925074131.10133-1-ming.qian@nxp.com>
 <20230925074131.10133-2-ming.qian@nxp.com>
 <bbc8dd05-8589-44ec-87dd-f2d7b4368245@linaro.org>
 <AM6PR04MB63418AE18D3D0ED98CCC1A0FE7FCA@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <751a552e-5209-4d5e-9292-23339a06f8a9@linaro.org>
In-Reply-To: <751a552e-5209-4d5e-9292-23339a06f8a9@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|AS1PR04MB9477:EE_
x-ms-office365-filtering-correlation-id: f7b3aeea-e720-4fca-4e04-08dbbd9f3cd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: POzgwI/rsHMuwkuiXbArYbXMHQ4i67fk5Cuk86HJwE8xO0o/7s5ELzEupf7Y6vaoCBADVnMHMmXMUGYsI7yn+MPoGKExWb5XLgEqdZJV5g15cn+lCDGNJHPhvNxaHQrPG1aoVHzW5r2oLewwTU84lrtxa269OtEbar8E2Po0UJiWAaRoGdcN8OZlH1MYrkcsZRDLPfb1rvZvv1zWJlJ+JJ7kmdEJxBMvW5rtpiOt0HmBEZSgFvwJB95OlAwEZhN2Tzhh6J9DbPna343v6z0MQdcErlMRPxLCn65H0EFVQYRbxMEySjFEFwcHeLIsdDVNaLFJM52j206L4ZEoycsP4k5zcDmflsrcWp5vt+nP5E17ZW7uUUVKFw85GPIwECO3o1dHP3ZvYYbkdqHydNgZLEASdr/VdTfhF1kK1LI6Kir1cwPfxsLVyosucAcdvg1A1znKktNb2bT4CkdMKbCiYWsLn7fp8gR8fb67HrXkLuXUB/TcJfhAce+/Q7xGOUv+6BuLJUhuG/vYMAsvWQ29qIQKYeXlwmXFOsd/NnEOJBSljngIRz4Bt/pEDY3k9VnxfDvFZRr0SesFE6o011lrdf1Dakq4dIARoCSppcphLS/wPdkpx10U50+7CMiWtSKo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(451199024)(1800799009)(186009)(54906003)(2906002)(7416002)(83380400001)(55016003)(64756008)(5660300002)(316002)(52536014)(44832011)(41300700001)(8676002)(8936002)(4326008)(66946007)(66446008)(66476007)(66556008)(33656002)(86362001)(110136005)(478600001)(26005)(7696005)(71200400001)(9686003)(6506007)(53546011)(122000001)(38100700002)(38070700005)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkdSb2dXN2VnamFSMWtJaHJXUTBTV3VNWlVrQUliUDhnbDNlTnM1dWdpdUFx?=
 =?utf-8?B?RnZnYW1ONHl5NlFSQ2h0OFRrNEt6c2N6NUNCdHVBQ2c3WElLWWJCMHREQlov?=
 =?utf-8?B?TitnK0NjM0xIZFZ5aEthVmdKZ1NJSDF4bjM4dUszVTh1ZmxrS0ZhYjNBczdh?=
 =?utf-8?B?VVY0UUtHVmFmd2g2UjRaNXNCOUFVb0JBWXd0VFZtVm9HUEhsRGdNQ1pYbE9O?=
 =?utf-8?B?NnI0NmlNRFRUYUphRUpyci9pc1c3OUl6Y253b2pHZWJnNHR0VmpCeVJTWWpB?=
 =?utf-8?B?YXcrb3c2UjVDRzE2UFBiVEc2OGh0b3BOcTkrdGF4Q05rVWU1R3NOOUJDUi9a?=
 =?utf-8?B?MUdmWWNSTm95bk85UzN3b3c2MUdUK0VqMFJCUks4RmlQdFZLWUg1Zk4vN1Bu?=
 =?utf-8?B?UFFZa1o3Zkh4Q1R5OFRUZGthLzU5QjNhMUF5RWl0d0xmOHRqU2dpeW5YWDY1?=
 =?utf-8?B?L0VFR0xSRlhVVU5NVVNsWEduQXcrbm9rVXlTYlpUZHBZZTlsbC9HdWNsY09i?=
 =?utf-8?B?ZWxCSjhSM04vN2QrMjl1ZkdPYUJOYkFCNU9hOU5RdWFXVE5jQ2ZkTy9Idk50?=
 =?utf-8?B?c05WeTBqS01mVWd1dG5HN2tURzRsczVrSG1mQmtja1FYUWd5MUFpcFdaREl6?=
 =?utf-8?B?NHVENDd6d1ZYRDhmODM4ajV2OHdsMS9SY1QwQ1UzbXN0cmpsRkM5RTJzRVUw?=
 =?utf-8?B?NHRqM21FcmZTZTlIR2VvQXVuSW1QSFVTQmRKQUU0ZVFwSlV4RzR4OWl5TUI1?=
 =?utf-8?B?c3B4Q2VxZDRjUXFwVzBlTUs5SlV2SHdXNThrOG9Vano1UFlHaTdTYkU0M1lT?=
 =?utf-8?B?aWp2TTcva2U5dTN5dDlITUM0cWdOa1VNZmJJSHBKcG9obnpYdnJxV1BKWWww?=
 =?utf-8?B?dmdpOVk0UzlCd0JMZEk3QTRaSzAzMGdnYzJGc21lNHVYT3VDdFpNVHp0bk5k?=
 =?utf-8?B?RzVjWEYwYlRxeGNMSmR6MDUxcjZEUmJBNVRNUlI2Q0VqLzVpcjMweUFHTDJI?=
 =?utf-8?B?UENzVDlzL2I3dEFRWVQrVEcwVW1STnNSdzVmRXZHU1hKcTFBSWtldGVWVG9B?=
 =?utf-8?B?TmFkd1lQSkthYmJoWE5BaTUxUmhPSWxKdzF0K3RZeDg4K1AzSDVnbi9EUlQ3?=
 =?utf-8?B?ckU2TDdxRGx6RGhHMS9ETUF2UjN2Q09Ka1llZHAzMjlUZXhPUXBWMG0rbG5C?=
 =?utf-8?B?aUZXWDRBaFNIUFoxUVFDcWsxUWxYZGxWbXQraW9VNnFMZ2c2L2xmdW1kYThX?=
 =?utf-8?B?VE1vTmwyKzMweWtiMnRxRU9Hai9jdHZtNXFTUzF5dXo2bFlYanFUbzlPSnl4?=
 =?utf-8?B?ak5QNml1Vkd2SlpjL2hEelRyYk1IUGw4c05zQVoxTERVWThXNG9keFd5S0sv?=
 =?utf-8?B?dkVEQTNVVG1oWklzUDhYWlNQZTg2cXg0SjQrSGdoMXB1M2ZSMVh0bUpKeTQw?=
 =?utf-8?B?TElrUzN3TGxxamhHWHRua2FEMjNFTzRJbHVDQjIvOWhOMG11M09DNFlBczlS?=
 =?utf-8?B?NW5vUm5kNHVvcE8vaEdZK3V3RCtlWk9oeENNbDBRU1J6V0FiMFltc2JRaHVV?=
 =?utf-8?B?S2s1dE01cGExY0ZURkRHYldMVVJVZkNNVU5HK1VLMzVXMXY2VTBUUFdFWmJy?=
 =?utf-8?B?NUZ3WCtBenpEbTk2NkNYWVN5TjVGUm4waW5PQlEwUzhqNGRuUzRxaGZFZWly?=
 =?utf-8?B?R3BrZERRN3UvcGFrMlNJL2pROHlkWk56clJ4dzQ0bGtrd1ZhK3JKRFk4Wmo0?=
 =?utf-8?B?Z3VFRktTR1o5VmJZeHNJOWYyUFliMlg0TkhGL250bmV2clNoQWc2eVd5dmtR?=
 =?utf-8?B?TndYcEJxK3JRaEYyRVV6ckZzemFZSHc3V3dlK21hSzlUN0s2SG45R3NnK0J0?=
 =?utf-8?B?aEZPYlUybHNZMW11akpnd3IzS205OUtCTlpkeGpxd3RnQlBYZHJ4REl6d2tV?=
 =?utf-8?B?NSt1Mlg1ODBQcEx3YXRxY0hxMGM1bm02clhlWkZXZ09LMGg2TTZ3TUY1d1JF?=
 =?utf-8?B?OUZMbTNYZ3lja1ZIU3IreFlRc3NMckY3MnplUFNtRTlqV0hINWI3T0tPaWRM?=
 =?utf-8?B?UjZ2QnBjd3lSL1p1U05uWXhhSWJpVElqVTAvWnJrYmtXNnB1T1dTWGJxYy82?=
 =?utf-8?Q?HWpY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b3aeea-e720-4fca-4e04-08dbbd9f3cd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 08:13:02.0990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: McZZTv6lJ3moYaTWGQedNP9f+wYlVXodIhDtF78CWrEq4tJcjllpGPruWM1TD4v3SvjVLtFivPnbaNDE75pgSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9477
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9y
Zz4NCj5TZW50OiAyMDIz5bm0OeaciDI15pelIDE2OjEwDQo+VG86IE1pbmcgUWlhbiA8bWluZy5x
aWFuQG54cC5jb20+OyBNaXJlbGEgUmFidWxlYSAoT1NTKQ0KPjxtaXJlbGEucmFidWxlYUBvc3Mu
bnhwLmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsgc2hhd25ndW9Aa2VybmVsLm9yZw0KPkNjOiBr
cnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+
bWNoZWhhYkBrZXJuZWwub3JnOyBodmVya3VpbC1jaXNjb0B4czRhbGwubmw7IHMuaGF1ZXJAcGVu
Z3V0cm9uaXguZGU7DQo+a2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207
IFguSC4gQmFvDQo+PHhpYWhvbmcuYmFvQG54cC5jb20+OyBFYWdsZSBaaG91IDxlYWdsZS56aG91
QG54cC5jb20+OyBUYW8gSmlhbmcNCj48dGFvLmppYW5nXzJAbnhwLmNvbT47IGRsLWxpbnV4LWlt
eCA8bGludXgtaW14QG54cC5jb20+Ow0KPmRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPmtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPlN1YmplY3Q6IFJlOiBbRVhU
XSBSZTogW1BBVENIIHYzIDIvMl0gZHQtYmluZGluZ3M6IG1lZGlhOiBpbXgtanBlZzogQXNzaWdu
IHNsb3QNCj5mb3IgaW14IGpwZWcgZW5jb2Rlci9kZWNvZGVyDQo+DQo+Q2F1dGlvbjogVGhpcyBp
cyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nIGxpbmtz
IG9yDQo+b3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNz
YWdlIHVzaW5nIHRoZSAnUmVwb3J0DQo+dGhpcyBlbWFpbCcgYnV0dG9uDQo+DQo+DQo+T24gMjUv
MDkvMjAyMyAxMDowNywgTWluZyBRaWFuIHdyb3RlOg0KPj4+IEZyb206IEtyenlzenRvZiBLb3ps
b3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4+PiBTZW50OiAyMDIz5bm0
OeaciDI15pelIDE2OjAyDQo+Pj4gVG86IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+OyBN
aXJlbGEgUmFidWxlYSAoT1NTKQ0KPj4+IDxtaXJlbGEucmFidWxlYUBvc3MubnhwLmNvbT47IHJv
YmgrZHRAa2VybmVsLm9yZzsNCj5zaGF3bmd1b0BrZXJuZWwub3JnDQo+Pj4gQ2M6IGtyenlzenRv
Zi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4+PiBtY2hl
aGFiQGtlcm5lbC5vcmc7IGh2ZXJrdWlsLWNpc2NvQHhzNGFsbC5ubDsgcy5oYXVlckBwZW5ndXRy
b25peC5kZTsNCj4+PiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsg
WC5ILiBCYW8NCj4+PiA8eGlhaG9uZy5iYW9AbnhwLmNvbT47IEVhZ2xlIFpob3UgPGVhZ2xlLnpo
b3VAbnhwLmNvbT47IFRhbyBKaWFuZw0KPj4+IDx0YW8uamlhbmdfMkBueHAuY29tPjsgZGwtbGlu
dXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+Pj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+Pj4ga2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+Pj4gU3Vi
amVjdDogW0VYVF0gUmU6IFtQQVRDSCB2MyAyLzJdIGR0LWJpbmRpbmdzOiBtZWRpYTogaW14LWpw
ZWc6DQo+Pj4gQXNzaWduIHNsb3QgZm9yIGlteCBqcGVnIGVuY29kZXIvZGVjb2Rlcg0KPj4+DQo+
Pj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3
aGVuIGNsaWNraW5nDQo+Pj4gbGlua3Mgb3Igb3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBk
b3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nDQo+Pj4gdGhlICdSZXBvcnQgdGhpcyBlbWFp
bCcgYnV0dG9uDQo+Pj4NCj4+Pg0KPj4+IE9uIDI1LzA5LzIwMjMgMDk6NDEsIE1pbmcgUWlhbiB3
cm90ZToNCj4+Pj4gVGhlcmUgYXJlIHRvdGFsIDQgc2xvdHMgYXZhaWxhYmxlIGluIHRoZSBJUCwg
YW5kIHdlIG9ubHkgbmVlZCB0byB1c2UNCj4+Pj4gb25lIHNsb3QgaW4gb25lIG9zLCBhc3NpZ24g
YSBzaW5nbGUgc2xvdCwgY29uZmlndXJlIGludGVycnVwdCBhbmQNCj4+Pj4gcG93ZXIgZG9tYWlu
IG9ubHkgZm9yIDEgc2xvdCwgbm90IGZvciB0aGUgYWxsIDQgc2xvdHMuDQo+Pj4NCj4+PiBObyBj
aGFuZ2Vsb2cgYW5kIEkgZG8gbm90IHNlZSBtdWNoIG9mIGltcHJvdmVtZW50cy4gRG8gbm90IGln
bm9yZSB0aGUNCj4+PiBmZWVkYmFjayBidXQgcmVzcG9uZCB0byBpdCBvciBmaXggdGhlIHBhdGNo
LiBSZWFsbHksIHdoYXQgaGFwcGVuZWQgaGVyZT8NCj4+Pg0KPj4NCj4+IEhpIEtyenlzenRvZiwN
Cj4+ICAgIFdoYXQgZG8geW91IG1lYW4gd3JhcCBjb21taXQgbWVzc2FnZT8gRG8geW91IG1lYW4g
bGluZSB3cmFwcGVkIGF0DQo+NzUgY29sdW1ucz8NCj4+DQo+PiAgIC0gVGhlIGJvZHkgb2YgdGhl
IGV4cGxhbmF0aW9uLCBsaW5lIHdyYXBwZWQgYXQgNzUgY29sdW1ucywgd2hpY2ggd2lsbA0KPj4g
ICAgIGJlIGNvcGllZCB0byB0aGUgcGVybWFuZW50IGNoYW5nZWxvZyB0byBkZXNjcmliZSB0aGlz
IHBhdGNoLg0KPg0KPkkgZ2F2ZSB5b3UgY2xlYXIgbGluayB0byB0aGUgZG9jIGV4cGxhaW5pbmcg
dGhpcy4gV2hhdCBpcyB1bmNsZWFyIHRoZXJlPw0KPg0KPkFuZCB5b3UgZGVjaWRlIHRvIGlnbm9y
ZSBhbGwgdGhlIHJlc3Qgb2YgdGhlIGNvbW1lbnRzIGhlcmUgYXMgd2VsbD8NCj4NCj5CZXN0IHJl
Z2FyZHMsDQo+S3J6eXN6dG9mDQoNClRoZSBsaW5rIGNvbnRlbnQgaXMgYXMgYmVsb3c6DQoNCiAg
LSBUaGUgYm9keSBvZiB0aGUgZXhwbGFuYXRpb24sIGxpbmUgd3JhcHBlZCBhdCA3NSBjb2x1bW5z
LCB3aGljaCB3aWxsDQogICAgYmUgY29waWVkIHRvIHRoZSBwZXJtYW5lbnQgY2hhbmdlbG9nIHRv
IGRlc2NyaWJlIHRoaXMgcGF0Y2guDQoNCkknbSBzb3JyeSB0aGF0IEkgZGlkbuKAmXQgZ2V0IHlv
dXIgcG9pbnQuDQoNCg0K

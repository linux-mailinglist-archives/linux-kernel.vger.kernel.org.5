Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A99878148A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 23:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239312AbjHRVGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 17:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238040AbjHRVGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 17:06:21 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B824214;
        Fri, 18 Aug 2023 14:06:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXB28KBV7C66YLc5OyulcJee1zrFWWsi1GltvhSUXRWuZbDFspMN7+/yXnYGD9YI5YuRwTdn24xG7BqpHumbVqIlwt1mKbMuAOiR/jueDsv6EWwTLOduM2Jloj8I4D+IMO8T1VkLTCx0HgWSz4k1o3IwKHCRsVS1Cu+jLlltXINv95uHMQs5bYPm26y11Db26fbThd36FG9qIMIG+SRYgxvW637EBzkYFKqQ9FHfguSQ6TQHkexn8YSAk6XcramC8ZV8dmtLWn8LO/M165+bM0jbF38TnN+pzmgCQMdKQEATJT9qOqhCrbKT2TDBoz6IH54Df8CxnWC/0jsuMZ9aNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHmFjfrQWP0QKeFSWaGCio+oxtd5J6YLknuTA3EAe2A=;
 b=g2EBrhSFpaSvy8Ycb0Xfsh3hsYmru941X8CTIJ9tFHU8THP507HEGMHLBXeOSOj61bJezIH1ky5f98j75YUvC9FS0ovOSPOBF0MeYfcOw/B1YKu+ipMvuambvLchKKHqVx0gTgQ6eqTY8K75iDY5fkH5DTq/5+Yg13eVbBw3yliZs94OuBXf8JHRXGLf1s+x4gKiO/rPTFKJyVrYQPkszlX22rOTRSjES4BRuAzCPkVpOCC1V6GLXsI3En4BNnHP+avac7PkogloW1tIY3N5YoCiQZxXce6w4WeLVc84byv3kLkTovHadxYk3ZXPb7duiejLKmTbIPcmOOkj3rZB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHmFjfrQWP0QKeFSWaGCio+oxtd5J6YLknuTA3EAe2A=;
 b=c0fIIFCbSRyvVt3hXMSqV7xkBSEdmetoeiYzKgGgh95wdZSZMreLcy3SuTCAeep/SaUYa6VPquh0JRcYbNfQPSR5UHNigvP4W9bFubaVzzHzusqdVymEIc1ZfD7f2W/taI9j8/ypGBSdlMOsnjwVae+lmPd031mSNe3RgmVrhVA=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DU2PR04MB8823.eurprd04.prod.outlook.com (2603:10a6:10:2e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 21:06:17 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 21:06:17 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
Thread-Topic: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
Thread-Index: AQHZ0hfUNv3/WngHPEy9dYjCGDguEw==
Date:   Fri, 18 Aug 2023 21:06:16 +0000
Message-ID: <PAXPR04MB918539A19B8F817F623BBD1F891BA@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230818153446.1076027-1-shenwei.wang@nxp.com>
 <CAL_Jsq+XA_P-aRK9_WuGPmJ0_xJgsSr9smZy4BRbKZbmVsMQBQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+XA_P-aRK9_WuGPmJ0_xJgsSr9smZy4BRbKZbmVsMQBQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|DU2PR04MB8823:EE_
x-ms-office365-filtering-correlation-id: 9a03e3cf-de6b-4031-b74e-08dba02ef699
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c7bfgxy3OQzPeN+KMhPBIiy6nw8sR/eJOnBLtE7lTm/Cq3MIDPaSS3P0qWDXb8UEpzmxIsoUdMpfvEvz1ip74nN/msnuMrUpZUg1CghFMovlx8cVQndpXBzIfLwId/V6+Ag9lkw9Rehz+MAkhOMVGZfKHQ/ppX3RnCPJrYPVujq1EgVHqsPm82VtgK/oBU8KrkeDRX7wdwIhWbpfqAV+fZSi5JLDV3OG2mef0/KnEsn0j25/of3KT9CC7wW6QjfrcOBL8Go6PNePDOuL37FQIboNyPH50HnQQSd9fs8JmI8Ss4RVKM8Hke9oqGGlLZoR5osLzTr1gZv9O2kXst78xXNeZl0LW+1bFspeCpgW5lcnfb/9yh7pl8r7vO7WxA3V02M2R7KLH6TVAgaOAj4cTHkZLH9+5yal6u31AiE3Pp9TGDrQEk+V7Hy33zPzRqOFjyXg6f5e92AxmtKnY7HNAqIAHJ4CwPPn5/Aowogs0Fg8peagrQSQacdBVzaoofN3x/YZBn4p2hTfIFwGIEzPVI+8EVtZvfFiLa/glGS0PuLrG4BvSJF7mdo2YiZEguIO4q1Cz60RpbXMQrigkuFwwToqTPZYbJWkfFygiGHE/xU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(1800799009)(186009)(451199024)(71200400001)(6506007)(53546011)(9686003)(7696005)(83380400001)(38070700005)(38100700002)(122000001)(33656002)(86362001)(55016003)(41300700001)(2906002)(316002)(66946007)(76116006)(66446008)(54906003)(64756008)(66556008)(66476007)(5660300002)(44832011)(8936002)(4326008)(8676002)(52536014)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFU2QmN0Z1ltb3E3UkViMC9ITjM1b3NBbVBXUkgraGRxNHN2aWpVQUQ2dWQx?=
 =?utf-8?B?ZEJVUVJVNHI2QlNCMXBUaDJzVmZHRXdCdEYzNG12Mmp4R3N4ZnFaajhEUzVN?=
 =?utf-8?B?SWZNdDg5NEpsV0gxQzFFSXRKVFVacDR3NTdjdU5pTXYwM1l6YUloSnAyV2Yz?=
 =?utf-8?B?VVh3UG82SkdnUVZ2Znc4N0ZqRkcyZ2IxTDNXNFIwV0ZkdEpZZXR2ditxMzdm?=
 =?utf-8?B?U1I3QXdFWEtadERTOG14NEdjdVJGMVpUMU1JRHE3QXZ6eWZaSzFveEFlQ2RD?=
 =?utf-8?B?MGpYMmdYa2t0M0lvNWQ3WGF2bE9sRnZYL2gxa3AzTFJRenpvZWpSRXE4M2lU?=
 =?utf-8?B?N1IzQTlmSklWRGpEWGUzU2RSYzBNTnBZQUs3VzVmS25BWWNGVnpkMGhhRDRv?=
 =?utf-8?B?ZC8vZi9wOUZYU2E3QlJFVGkzTGdGbjhkTklFMmowd3htT2gzSmtWdWJOa0tI?=
 =?utf-8?B?TnlBaHpWbmNtM1d2YkNjL1U1UysySzMwaVdobnpTSTRQTE1KNWMzR0s5cldO?=
 =?utf-8?B?MW5VU2hmNFUydmtVTkpLbmR6Vm5ETXBqSXlqbUFHZ1RPakNYc0F5WW5RQU9K?=
 =?utf-8?B?YU14NUNyNGZqR25EaVVHR3pMVDFMdWkyR3lWZDRzd011dkdTWkIxOEZ1VFVr?=
 =?utf-8?B?amdLaVZtR0NETXdVTFBrRTB0VTdzN3pBTDhkQkZEc1Z4VCtuN2tsaFdpUzMz?=
 =?utf-8?B?Qm15T0pHSC9VWU4veDR6Q2RUYWhSZFhSclRBSmZvMGhBaEpZYXB1UlcraVBX?=
 =?utf-8?B?b3pmTnR6Q3NJMFk0eXFSM1RESjZpTUNYY1lyc0t3ekJEekk5N2NBeXpyVU9z?=
 =?utf-8?B?a2dEMmtRUnNCcHdqRlRiNmNhdmZjQWVsbEV2eERxRDhPOWQyMy9tbTBmQkdJ?=
 =?utf-8?B?VFE2Ly9GTFFnU29PY21FVkpRV0lyRTB1SStCSnREaXZzOWhvdTFhS1F4YUxy?=
 =?utf-8?B?NkkraUFVSno1dFVxWkJteG5KWWVTZythREVILzcxOEszRFgvbDd5M0JWNHY3?=
 =?utf-8?B?S3F4YXZ6eFA2STIvUFZNM3EyS2daOG9mSjArNEZWM2xiVU0wNmFUOHcwSHpF?=
 =?utf-8?B?a2ZJZy9VQnFJQVBDTG5xVFYvYlg3SUpudmxpTm45OTRKVkV2enRYVTBwM2lH?=
 =?utf-8?B?R1R2NFhkN0Y3SDJKZzdTRjZNcTdwYU5rUkFMREU0K2RpRzVwNFRTSWZvNzVU?=
 =?utf-8?B?YnpnaThGdUlDT3dNYnl1L3QydGt5Zkg5MFhrcVVhSS9CT0pqbGprV0x2U2lJ?=
 =?utf-8?B?OVJiSjZsNmV1b0FmYlBTcU1iSE1aK2xkMUl6TXVXTVkrRzhLaXJ0OUpDTmxw?=
 =?utf-8?B?UFRpVmRXQlF2L21SaGtlcTBlRlFLdjZSL3p1QnkvSjVWVWhBdDMxR3ZoMVdo?=
 =?utf-8?B?U1VRcmxQQzRpTWtLUjVUbHBrZ0lWa0NaNUhyWHFSdnc2VW5kVkFOclhTZTBD?=
 =?utf-8?B?THZjYTdRd3hXSmZTZW5XazAyRmNidERYY0JYdUJaalUyMnhiN3RkYnBwUVVQ?=
 =?utf-8?B?bENWU1NwK3g0SythanlCNlN1QUY1ajRmTEFsdUpad21BS01xNVhSdFJwNWEv?=
 =?utf-8?B?QXo4aU1ERDFvVE5MYlhUK2hqM0ZHUHM0akRFSjB0bTFUYmc4UzRJU2JqSk1S?=
 =?utf-8?B?SGU3c3JJUy91QjJZdm1DYnRpQS9TSW9nYWRmZmRHbzEzWlRmODRrTnBRcE1U?=
 =?utf-8?B?ZWhkYTlzUHhsZ3VTblFPRmVUaUwvK0k0RHUzZVRQWnE1Z0xibktkcXBzSzBG?=
 =?utf-8?B?N0cyL2cvWW8wem16Z0NzVXE3bWtaSlBIUFFtME8xK0MrRWZJK1pnNE1xQU9p?=
 =?utf-8?B?ak01L0ZxWHBoV20zYUdFZnZmU3JpR1l1a1dqNlhDbWZZMDJ3RFFjOFpqK2lt?=
 =?utf-8?B?OWk1UWVqbUgyL0FCTEhESUhvTUhQS0lnR2ZndFlSdkY0eFQ5VkhPOUs3OUI1?=
 =?utf-8?B?NnRCYjl3cURib2FXUHRKa04xOGNLQkZybXpNUDR5akxGQXFDeW01b2JENGdp?=
 =?utf-8?B?NnlsYlVmYUJScW5odFd1TllzMVFFWlhPbTdwaGF6RnlIS2hIeUJuMDFLTnZX?=
 =?utf-8?B?eGFXVnlBeGt3SU9lSEtvUjI1VWtaY1QwSFNXUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a03e3cf-de6b-4031-b74e-08dba02ef699
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 21:06:16.9002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pzcvBATyTnhR6+yfFimIfPrD1+ceZGwHqD563Yu7syB2iU4Zn5k3JP+iRwERvu5C/75ZQvc4aWBmBXoPds6kQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8823
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgPHJv
YmgrZHRAa2VybmVsLm9yZz4NCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMTgsIDIwMjMgMzo1MiBQ
TQ0KPiBUbzogU2hlbndlaSBXYW5nIDxzaGVud2VpLndhbmdAbnhwLmNvbT4NCj4gQ2M6IEtyenlz
enRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZz47IENvbm9y
IERvb2xleQ0KPiA8Y29ub3IrZHRAa2VybmVsLm9yZz47IFVsZiBIYW5zc29uIDx1bGYuaGFuc3Nv
bkBsaW5hcm8ub3JnPjsgTGlhbSBHaXJkd29vZA0KPiA8bGdpcmR3b29kQGdtYWlsLmNvbT47IE1h
cmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz47DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0K
PiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBbRVhUXSBSZTog
W1BBVENIIDEvMl0gZHQtYmluZGluZ3M6IHBvd2VyOiBBZGQgcmVndWxhdG9yLXBkIHlhbWwgZmls
ZQ0KPiA+DQo+ID4gRG9jdW1lbnRpbmcgdGhlIHJlZ3VsYXRvciBwb3dlciBkb21haW4gcHJvcGVy
dGllcyBhbmQgdXNhZ2UgZXhhbXBsZXMuDQo+IA0KPiBUaGlzIG5lZWRzIHRvIGFuc3dlciB3aHkg
d2UgbmVlZCB0aGlzLg0KPiANCj4gSXQgbG9va3MgbGlrZSBqdXN0IGFuIGFic3RyYWN0aW9uIGxh
eWVyIHRvIG1ha2UgcmVndWxhdG9ycyBsb29rIGxpa2UgYSBwb3dlcg0KPiBkb21haW4uDQo+IA0K
DQpZZXMsIGl0IGlzIGEgd3JhcHBlciB0aGF0IGFsbG93cyB1c2luZyByZWd1bGF0b3JzIGFzIGEg
cG93ZXIgZG9tYWluLiBUaGlzIHJlbW92ZXMgDQp0aGUgbmVlZCB0byBhZGQgcmVndWxhdG9yIG9w
ZXJhdGluZyBjb2RlIGluIGVhY2ggY29uc3VtZXIgZGV2aWNlIGRyaXZlci4gQXMgYSBwb3dlciAN
CmRvbWFpbiwgdGhlIHJlZ3VsYXRvciB3aWxsIGJlIG1hbmFnZWQgYXV0b21hdGljYWxseSBieSB0
aGUgZGV2aWNlIGRyaXZlciBmcmFtZXdvcmsgDQphbmQgUE0gc3Vic3lzdGVtLg0KDQpUaGlzIGlz
IHZlcnkgdXNlZnVsIHdoZW4gYSBkZXZpY2UncyBwb3dlciBpcyBjb250cm9sbGVkIGJ5IGEgR1BJ
TyBwaW4sIHdoaWNoIGN1cnJlbnRseSANCnJlcXVpcmVzIHVzaW5nIHRoZSBmaXhlZC1yZWd1bGF0
b3IgdG8gYWNoaWV2ZSB0aGUgc2FtZSBwdXJwb3NlLiBIb3dldmVyLCB0aGUgDQpmaXhlZC1yZWd1
bGF0b3IgYXBwcm9hY2ggbWF5IGhhdmUgdG8gYWRkIGNvZGUgaW4gdGhlIGRyaXZlciBpbiBvcmRl
ciB0byB1c2UgaXQuDQoNClRoYW5rcywNClNoZW53ZWkNCg0KPiBSb2INCg==

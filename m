Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DB07B17C5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjI1JmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjI1JmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:42:14 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2444719E;
        Thu, 28 Sep 2023 02:42:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaDSW6knZodXa79d+VAso/VtxRavZyYFpLIF8MpD5yaOQrREQkDxT6fY9HXWgevmdHv2crjqZmLYg0r2g25PW7ClYX8jWrEQKegHeVJtyr7Dgr+qKtRZ2ljGwGeMSazi6ZAAoBj9WMFbm+3N1r6y5I05ldqIrJmsUYoB7y/eYo03hy+f9hFn58Cof+IMzzuVeYHFbG6oXGnz/WItezj8W4XjhkCtYC7YsNtP2a6paF7jYHqxkGEHPhKc+7vEN3HX5aDemrKQwFHi0EKW7RLYTusirBHkz0FMaH3XY5AshYkT0SMIxLGLsEE/vUmgVND9iVh5pJkZ8+K3qAbUQqmMIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvxlaZR/bpEzvW6nuYvQvk6kR6hmXihWC9AmpvmX4OU=;
 b=oCYpQCQwknpPIH2zj7ULbLqoCfVzQjslq6b52y6v6QMrPJDLWAdFGoW5XTHz4oA0EIdpPQhLQfCNDuVp6Ejui5yLocmSd8JBXIsX5zEszl2DOFUf1S6gAxdeMLTvcNZTua9OO9Ed1y6LOHa0ldTHKlXg8yCukV/CKbJ/+CZ1qn3q/vcfOyE4vjSoxZC0MJY0u2HF72qRsTve9fhfDLHiYhMW9ifGWHJkSGDM2DB7Odm2By/89GZVRllcUoWr3MAo4TbfH20DWYyB4lWiZKj+hFSOr+0twspVbvbf5xT+nZcnwxZeuEJPD4BtA8BOnjn2z1ly/AzgavYOsWWzEgGOkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvxlaZR/bpEzvW6nuYvQvk6kR6hmXihWC9AmpvmX4OU=;
 b=QEzuPOnBwokcUSXMVIvnQteFTOlbsTqwJT+GowIO7454sJDXyMY9ReqsCc3AjFvcdJBvipW//jzujNblgTygOLddVBSWdf0Ui4k3OBIpC+fm22XvR1P04ogBv+Ws9prCnvHmt/jWhWS10hN7SoWCqvgx5CjLWfmLOpK82PqVhaM=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DBBPR04MB7850.eurprd04.prod.outlook.com (2603:10a6:10:1e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 09:42:08 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f%4]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 09:42:07 +0000
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
Subject: RE: [EXT] Re: [PATCH v4 2/2] dt-bindings: media: imx-jpeg: Assign
 slot for imx jpeg encoder/decoder
Thread-Topic: [EXT] Re: [PATCH v4 2/2] dt-bindings: media: imx-jpeg: Assign
 slot for imx jpeg encoder/decoder
Thread-Index: AQHZ8GGrmZBLZQgREEat4sCPmu/sQrAuUiWAgAANvVCAAVJ5AIAAR0kg
Date:   Thu, 28 Sep 2023 09:42:07 +0000
Message-ID: <AM6PR04MB63412A27FDC244D1A8FB7CA0E7C1A@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20230926101000.13392-1-ming.qian@nxp.com>
 <20230926101000.13392-2-ming.qian@nxp.com>
 <2c351ca0-cee4-4c1b-956b-6134ad101a9a@linaro.org>
 <AM6PR04MB63415CF2EDCF0AF33F778774E7C2A@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <45abc9ec-1f7a-469c-bc0f-2a065499b0b4@linaro.org>
In-Reply-To: <45abc9ec-1f7a-469c-bc0f-2a065499b0b4@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|DBBPR04MB7850:EE_
x-ms-office365-filtering-correlation-id: 88f7bdcc-9d4f-456d-bdc1-08dbc0072e63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fP/MC/jx9z9AB/QfdCiIncnRP2+mZrHdWzjnBYijsxQEggis6GvPvMubFiYOyfnSeGTymsiBaNGtm/5PpuQr4irqwc7fhGwRi+o0KXPjPwYBig/heqOhK/ykwX6k//JHhDzSomeUrvLlXKjm5gFi3kA7aQKvIjI+a3MAQeoYr9gU1gR+JBtlds29j6qML+e9QxBkH/KcOVDC02IRleAQyuPDbNFBsSXKJ223Fmhq9X9zNf5vtJa+f5L4ZgtXUzKnfUKHEQkvd8LJzdEJVYCLQiDslRXMIg4qQ47aHfT+gKggBnzTq2J4LjKAiJNrjLsemdPKYAGh2cDfEGcTkqXlFMD5VSE3yiY2BtjSe52hHEqnjpOplMcbNnORgyATgPtxZxitYSff50zAvzYByYBLYoxJcgehgbpWMSz+f9vhJY8BSKICa26SiRF7OJ732BzhnCD9O3x5snfP/yu5jEXtbVMZBzbWZlHfH51l/YuWyqkohHF7ybqX0pAxtXC90olQwHSlLvCv/j7DvuBKKUuK5YvfKKnb5SwRBcW46l8ynH1cxLLPue16qp/ZvNF+RVGVgtcDYrXWsT/8ocDJgOd/bgN+WuF0fBSqKBFwEyazIa8lieX7ODArOMEvOrR+ab2u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(66946007)(76116006)(55016003)(8936002)(4326008)(52536014)(83380400001)(26005)(8676002)(110136005)(54906003)(316002)(64756008)(66556008)(41300700001)(9686003)(2906002)(71200400001)(44832011)(66476007)(66446008)(122000001)(5660300002)(478600001)(6506007)(53546011)(7696005)(7416002)(33656002)(38070700005)(38100700002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzk2TExUYmplRXRWR3prQzltZkVxUVI1RThWMlRlQ3ovSEtGVXRmYm5qazd5?=
 =?utf-8?B?SjRnaGdqL01SYmlQSHR1WGNLTXZRampYTGVJbFM0cWFhd0U2bEJXNmtjeE11?=
 =?utf-8?B?bXNJcWVGbVFnNVEyODg5bEFXcnAzNm5YK3dRakhRVDF2akkzQmJzZlZ2cUVs?=
 =?utf-8?B?QW1QeTNSeXZLd0xLZnNHbG5qenpFNGpXUVEySEFGTXNOOXJwQ3VmQW5wRGxP?=
 =?utf-8?B?U2ZvTDNXYXBxU2pGSXREMUZtZVRJUWJVM1RRcUVBc09uanZuY1Y5K0dmYXlZ?=
 =?utf-8?B?Zk8yejVhUVp0eTlISGlsWk5VdjBVenY5aWY3R1FWZEp3WXJZbUI4aWhaUzlB?=
 =?utf-8?B?R1FhQldETkZUb1VHQ2FJejhxUkRvTktUZGpBMElSbmR3Z3JqaFArc3BMRWdt?=
 =?utf-8?B?L2lQU3RIUDhrWGY3YjFCVUFBcitLM1F4Mzk5bko3TXp2VkwyV2dlY21EVnJ3?=
 =?utf-8?B?TUd1TXNyYU5NaUxJa3VVcjZvNjd4YVhsNHpMbEhqYisyZm1wUXBVR01RQ1pt?=
 =?utf-8?B?akNwbU9jcFQyaDFqeHhxTDIrWGxNNTF6THVEVGxhdndxbTQwSks2Tm96WjhF?=
 =?utf-8?B?d0F1VytxNTZrTnZsMXVjanlHUU5SYTE2MTlKRENQREpkWmdrc0pHZ09tdGJU?=
 =?utf-8?B?MDcyUW5wbldybkdOajd4Q1RMYWNnRDFGSnVMTW9ENmJ1MWc0bkpsT0VPaXd4?=
 =?utf-8?B?YkVCcFV0aUZnbHgyTU8wZjBOMXFEaUw0ZVFjbmkyR3RYeXdjbWZiYitzeEl5?=
 =?utf-8?B?YVdEZDdnRDFXVko3Tm1zU3lQN1BTQ2xoY1BCY2NHYlpmNERBMHhrM3dJYzEv?=
 =?utf-8?B?TE1jZVNZb01aRVF5MXBOY0NyQVdOZlBTS2htclJFeDdHSHFrWjZ1UXFRN290?=
 =?utf-8?B?ckhIbWRKbVAxaWZvc1VVemRjcUlQSSs4b2h5ZytQY0U0aHB6QnpQZVJFcm0z?=
 =?utf-8?B?WEM2elhDck1Mc25lSExtSGJYQ3ZLV2JFY2RyV2ZONTJKMzRjUHFxVUV2dUs0?=
 =?utf-8?B?cExrUDNDMTVTWHhaUVZGSXhDaXk0bzdTWm4zc3Z2enFlRTRTa3NZOGxDUWh0?=
 =?utf-8?B?NEt6dEJsSm5YMFRYSGF1ZGlrNElpRHppdSsxNjQxWitOVU95Y3FVOG1qMFQx?=
 =?utf-8?B?VFAybTVyY3Nqa21xQVVSRis5dFhlN2MxTzducGI1V0ZwZ3c4ZUZvQzMyanVS?=
 =?utf-8?B?SDBUNWh4ekhiTi9zb0ZEb1plMWtoZzNxS1JqL0xrSGpMNWlJc09qQXQrMFRa?=
 =?utf-8?B?bjFCbVVZV041bWJMYmRtNHZRRW1rOVJIWWF0UDN4Y0dnTko3WHNLQnNITXZL?=
 =?utf-8?B?L2xIYVR6eHZuZFJJSURNK3FCYk1YMFQ3Mkh4akZnWGJXbHNsTll3TDN4Rm8w?=
 =?utf-8?B?NmhUNkNieW5mbkE0LzE0SGlPSVprSDY4bGk5TjVsaGt0bExGd09WZmNlRWN0?=
 =?utf-8?B?enZ2cXFadnQ5RkhxNjFJa0RJVVNVV1cyTENYOUVTQmMvbU9NbHI3UURKWnZU?=
 =?utf-8?B?U2d4bjY1OVpiR1d3NlVPT00rWjVJNDg2TmdML1p6ZlN3TFlCTEVXUWZMV3hq?=
 =?utf-8?B?YVo0bThEWnIyWGxJK1ZvQjFLdlhCZ01aZ3Mvc2laeER5bkYybUJwUSsvS0Nn?=
 =?utf-8?B?TlB2RjBPLzFKb1IrUnhPSHpiUTdLWHc1NFZMQUU5N2J6ZDhueklYMGxaUmtH?=
 =?utf-8?B?dTZoTW5jTXROb2F1SjVIMjlPcE5MK3RSMHR5cUIrR0lpOTQvZDd6VVM0S2U3?=
 =?utf-8?B?cWRwclJ5UnBQSmkveHMwSHQ2V3hKRklOWEVxZmR0aTRnL25GRnNqUld4YkE0?=
 =?utf-8?B?aVloWDFQM05Xa09lNWpVby8vcFNwdXJtc3llMEJmRS9RekhLK0pPd21RNUpv?=
 =?utf-8?B?STR6dkZ2c2lsVTk3NlQ4VXlUcGFNaUVQR0J0SkZwenc1SU5oby9meTh1Z1ZQ?=
 =?utf-8?B?dVgvL3JIZXh2Nis3aEQxcUZYM290RnVRb1pWMFZVbzhESUFjdjB6NkMza2Qy?=
 =?utf-8?B?ZjhROUpYQnZ2bjk1SjhjcHI1cWs0MXFobGovSjlIa0pSRERjY2xKVXhaTnJw?=
 =?utf-8?B?TWhHQjhncnZ4eDZuNUs5TzJOWStZTVVSeDIrQUhCSGFVbTU5cXFwbGo1bG1O?=
 =?utf-8?Q?1fCs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f7bdcc-9d4f-456d-bdc1-08dbc0072e63
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 09:42:07.8187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gneD1hhQCT71pw34rxJcumcixzk4oQiEgXToGTgPcRWZZuVEIsq6whiVQ/3NQDsKKVoADH1PFn78hEDqdALsrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7850
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
Zz4NCj5TZW50OiAyMDIz5bm0OeaciDI45pelIDEzOjA3DQo+VG86IE1pbmcgUWlhbiA8bWluZy5x
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
XSBSZTogW1BBVENIIHY0IDIvMl0gZHQtYmluZGluZ3M6IG1lZGlhOiBpbXgtanBlZzogQXNzaWdu
IHNsb3QNCj5mb3IgaW14IGpwZWcgZW5jb2Rlci9kZWNvZGVyDQo+DQo+Q2F1dGlvbjogVGhpcyBp
cyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nIGxpbmtz
IG9yDQo+b3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNz
YWdlIHVzaW5nIHRoZSAnUmVwb3J0DQo+dGhpcyBlbWFpbCcgYnV0dG9uDQo+DQo+DQo+T24gMjcv
MDkvMjAyMyAxMToxMCwgTWluZyBRaWFuIHdyb3RlOg0KPj4+IEZyb206IEtyenlzenRvZiBLb3ps
b3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4+PiBTZW50OiAyMDIz5bm0
OeaciDI35pelIDE2OjA2DQo+Pj4gVG86IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+OyBN
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
amVjdDogW0VYVF0gUmU6IFtQQVRDSCB2NCAyLzJdIGR0LWJpbmRpbmdzOiBtZWRpYTogaW14LWpw
ZWc6DQo+Pj4gQXNzaWduIHNsb3QgZm9yIGlteCBqcGVnIGVuY29kZXIvZGVjb2Rlcg0KPj4+DQo+
Pj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3
aGVuIGNsaWNraW5nDQo+Pj4gbGlua3Mgb3Igb3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBk
b3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nDQo+Pj4gdGhlICdSZXBvcnQgdGhpcyBlbWFp
bCcgYnV0dG9uDQo+Pj4NCj4+Pg0KPj4+IE9uIDI2LzA5LzIwMjMgMTI6MTAsIE1pbmcgUWlhbiB3
cm90ZToNCj4+Pj4gVGhlcmUgYXJlIHRvdGFsIDQgc2xvdHMgYXZhaWxhYmxlIGluIHRoZSBJUCwg
YW5kIHdlIG9ubHkgbmVlZCB0byB1c2UNCj4+Pj4gb25lIHNsb3QgaW4gb25lIG9zLCBhc3NpZ24g
YSBzaW5nbGUgc2xvdCwgY29uZmlndXJlIGludGVycnVwdCBhbmQNCj4+Pj4gcG93ZXIgZG9tYWlu
IG9ubHkgZm9yIDEgc2xvdCwgbm90IGZvciB0aGUgYWxsIDQgc2xvdHMuDQo+Pj4+DQo+Pj4+IFNp
Z25lZC1vZmYtYnk6IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+DQo+Pj4+IC0tLQ0KPj4+
PiB2NA0KPj4+PiAtIGltcHJvdmUgY29tbWl0IG1lc3NhZ2UNCj4+Pj4gLSBkb24ndCBtYWtlIGFu
IEFCSSBicmVhaw0KPj4+PiB2Mw0KPj4+PiAtIGFkZCB2ZW5kZXIgcHJlZml4LCBjaGFuZ2UgcHJv
cGVydHkgc2xvdCB0byBueHAsc2xvdA0KPj4+PiAtIGFkZCB0eXBlIGZvciBwcm9wZXJ0eSBzbG90
DQo+Pj4+DQo+Pj4+ICAuLi4vYmluZGluZ3MvbWVkaWEvbnhwLGlteDgtanBlZy55YW1sICAgICAg
ICAgfCA0NSArKysrKysrKystLS0tLS0tLS0tDQo+Pj4+ICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5z
ZXJ0aW9ucygrKSwgMjQgZGVsZXRpb25zKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQNCj4+Pj4g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvbnhwLGlteDgtanBlZy55
YW1sDQo+Pj4+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL254cCxp
bXg4LWpwZWcueWFtbA0KPj4+PiBpbmRleCAzZDlkMWRiMzcwNDAuLjRiY2ZjODE1Yzg5NCAxMDA2
NDQNCj4+Pj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL254
cCxpbXg4LWpwZWcueWFtbA0KPj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbWVkaWEvbnhwLGlteDgtanBlZy55YW1sDQo+Pj4+IEBAIC0zMiwxOSArMzIsMjYgQEAg
cHJvcGVydGllczoNCj4+Pj4gICAgICBtYXhJdGVtczogMQ0KPj4+Pg0KPj4+PiAgICBpbnRlcnJ1
cHRzOg0KPj4+PiAtICAgIGRlc2NyaXB0aW9uOiB8DQo+Pj4+IC0gICAgICBUaGVyZSBhcmUgNCBz
bG90cyBhdmFpbGFibGUgaW4gdGhlIElQLCB3aGljaCB0aGUgZHJpdmVyIG1heSB1c2UNCj4+Pj4g
LSAgICAgIElmIGEgY2VydGFpbiBzbG90IGlzIHVzZWQsIGl0IHNob3VsZCBoYXZlIGFuIGFzc29j
aWF0ZWQgaW50ZXJydXB0DQo+Pj4+IC0gICAgICBUaGUgaW50ZXJydXB0IHdpdGggaW5kZXggaSBp
cyBhc3N1bWVkIHRvIGJlIGZvciBzbG90IGkNCj4+Pj4gLSAgICBtaW5JdGVtczogMSAgICAgICAg
ICAgICAgICMgQXQgbGVhc3Qgb25lIHNsb3QgaXMgbmVlZGVkIGJ5IHRoZSBkcml2ZXINCj4+Pj4g
LSAgICBtYXhJdGVtczogNCAgICAgICAgICAgICAgICMgVGhlIElQIGhhcyA0IHNsb3RzIGF2YWls
YWJsZSBmb3IgdXNlDQo+Pj4+ICsgICAgZGVzY3JpcHRpb246DQo+Pj4+ICsgICAgICBJbnRlcnJ1
cHQgbnVtYmVyIGZvciBzbG90DQo+Pj4+ICsgICAgbWF4SXRlbXM6IDENCj4+Pj4NCj4+Pj4gICAg
cG93ZXItZG9tYWluczoNCj4+Pj4gICAgICBkZXNjcmlwdGlvbjoNCj4+Pj4gICAgICAgIExpc3Qg
b2YgcGhhbmRsZSBhbmQgUE0gZG9tYWluIHNwZWNpZmllciBhcyBkb2N1bWVudGVkIGluDQo+Pj4+
ICAgICAgICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIvcG93ZXJfZG9t
YWluLnR4dA0KPj4+PiAtICAgIG1pbkl0ZW1zOiAyICAgICAgICAgICAgICAgIyBXcmFwcGVyIGFu
ZCAxIHNsb3QNCj4+Pj4gLSAgICBtYXhJdGVtczogNSAgICAgICAgICAgICAgICMgV3JhcHBlciBh
bmQgNCBzbG90cw0KPj4+PiArICAgIG1pbkl0ZW1zOiAxICAgICAgICAgICAgICAgIyBWUFVNSVgN
Cj4+Pj4gKyAgICBtYXhJdGVtczogMiAgICAgICAgICAgICAgICMgV3JhcHBlciBhbmQgMSBzbG90
DQo+Pj4+ICsNCj4+Pj4gKyAgbnhwLHNsb3Q6DQo+Pj4+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlw
ZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+Pj4+ICsgICAgZGVzY3JpcHRpb246DQo+Pj4+
ICsgICAgICBJbnRlZ2VyIG51bWJlciBvZiBzbG90IGluZGV4IHVzZWQuIFRoZXJlIGFyZSA0IHNs
b3RzIGF2YWlsYWJsZSBpbiB0aGUgSVAsDQo+Pj4+ICsgICAgICBhbmQgZHJpdmVyIGNhbiB1c2Ug
YSBjZXJ0YWluIHNsb3QsIGl0IHNob3VsZCBoYXZlIGFuIGFzc29jaWF0ZWQNCj5pbnRlcnJ1cHQN
Cj4+Pj4gKyAgICAgIGFuZCBwb3dlci1kb21haW4uIEluIHRoZW9yeSwgaXQgc3VwcG9ydHMgNCBv
cyBvciB2bS4gSWYgbm90IHNwZWNpZmllZCwNCj4wDQo+Pj4+ICsgICAgICBpcyB1c2VkIGJ5IGRl
ZmF1bHQuDQo+Pj4+ICsgICAgbWluaW11bTogMA0KPj4+PiArICAgIG1heGltdW06IDMNCj4+Pg0K
Pj4+IE5BSywgeW91IHN0aWxsIGRpZCBub3QgYW5zd2VyIGNvbmNlcm5zIHdoeSB0aGlzIGlzIG5l
ZWRlZCBhbmQganVzdGlmaWVkLg0KPj4+IEkga2VlcCBhc2tpbmcgYW5kIHlvdSBrZWVwIGlnbm9y
aW5nLi4uDQo+Pj4NCj4+PiBCZXN0IHJlZ2FyZHMsDQo+Pj4gS3J6eXN6dG9mDQo+Pg0KPj4gSGkg
S3J6eXN6dG9mLA0KPj4NCj4+PiBOb3RoaW5nIGV4cGxhaW5zIHdoYXQgaXMgYSBzbG90IGFuZCBu
b3RoaW5nIGV4cGxhaW5zIHdoeSBkbyB5b3UgbmVlZCB0aGlzDQo+cHJvcGVydHkuDQo+Pg0KPj4g
SSB0aG91Z2h0IEkgaGFkIGFuc3dlcmVkIHRoYXQgcXVlc3Rpb24sIGJ1dCBzZWVtcyB5b3UgZG9u
J3QgYWdyZWUgd2l0aCB0aGF0DQo+ZXhwbGFuYXRpb24uDQo+PiBXb3VsZCB0aGUgZm9sbG93aW5n
IGRlc2NyaXB0aW9uIGJlIGFueSBiZXR0ZXI/DQo+DQo+Tm8sIHlvdSBkaWRuJ3QuIEkgZG9uJ3Qg
c2VlIGFueSBleHBsYW5hdGlvbiBpbiB0aGUgY29tbWl0IG1zZy4gWW91IGp1c3Qgc2F5DQo+eW91
IGhhdmUgIjQgc2xvdHMiLg0KPg0KPkJlc3QgcmVnYXJkcywNCj5Lcnp5c3p0b2YNCg0KSGkgS3J6
eXN6dG9mLA0KDQpJIGNoZWNrIHRoZSBvdXIgZG9jdW1lbnQgYWdhaW4sIGl0IGRvZXMgbm90IGdp
dmUgYSBzdGFuZGFyZCBkZWZpbml0aW9uIHRvby4gSSdsbCBleHBsYWluIGl0IGFzIEkgdW5kZXJz
dGFuZCBpdC4gVGhpcyBJUCBpbmNsdWRlcyBhIGpwZWcgd3JhcHBlciwgdGhlIHdyYXBwZXIgaXMg
d29ya2luZyBvbiBkZXNjcmlwdG9yIGJhc2VkIG1hbm5lci4gSXQgc3VwcG9ydCB1cCB0byA0IHNs
b3RzLCBlYWNoIHNsb3RzIGNhbiBoYXZlIGl0cyBvd24gY2hhaW5lZCBkZXNjcmlwdG9ycy4gVGhl
IHB1cnBvc2UgaXMgdG8gc2hhcmUgdGhlIGpwZWcgZW5naW5lIGFjcm9zcyBtdWx0aXBsZSBWTVMg
YW5kIG9zLCBJdCdzIGEgYml0IGxpa2Ugdm0gcGFydGl0aW9uaW5nLiBXZSBqdXN0IHdhbnQgdG8g
YXNzaWduIDEgc2xvdCB0byBsaW51eCwgVGhlbiwgdGhlb3JldGljYWxseSwgaXQgY2FuIHN1cHBv
cnQgdXAgdG8gMyBWTVMuDQpUaGUgc2xvdCBpbmRleCBpbmRpY2F0ZXMgd2hpY2ggc2xvdCB3ZSBj
aG9vc2UsIGRyaXZlciB3aWxsIHVzZSB0aGUgc2xvdCBpbmRleCB0byBjb25maWd1cmUuIElmIG5v
dCBzcGVjaWZpZWQsIDAgaXMgdXNlZCBieSBkZWZhdWx0Lg0KQ3VycmVudGx5IGRyaXZlciBvbmx5
IHVzZSB0aGUgc2xvdCAwIGJ5IGRlZmF1bHQsIGJ1dCBpdCBlbmFibGUgdGhlIHBvd2VyLWRvbWFp
biBhbmQgcmVxdWVzdCBpcnEgdG8gYWxsIHRoZSA0IHNsb3RzLiAgdGhlcmUgaGFzIGJlZW4gbm8g
cmVhbCBuZWdhdGl2ZSBpbXBhY3QsIGFzIHdlIGhhdmUgbm8gcHJhY3RpY2FsIGFwcGxpY2F0aW9u
IHRvIHVzZSBvdGhlciBzbG90cyB5ZXQuIEJ1dCBpdCBkb2VzIGNhdXNlIHRyb3VibGUgd2hlbiB3
ZSB3YW50IHRvIHVzZSBhbm90aGVyIHNsb3QgaW4gYSB2bS4NCg0KQmVzdCByZWdhcmRzLA0KTWlu
Zw0K

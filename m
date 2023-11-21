Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC677F25D4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 07:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjKUGhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 01:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjKUGhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 01:37:34 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2089.outbound.protection.outlook.com [40.107.14.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B504D90;
        Mon, 20 Nov 2023 22:37:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGaohcLuTVt/WqPkpHh3eHvCM2GFpxB9WZXMdllWEO+lOvSibENIIgEHyltZW1S3/J2Y6CQDOtIAGwJy/0PIzyrDf17iQGHP+V1ldMvLbvZDEy05oURFUlxwk6Y7CbsltzKOlvKyFLS7mm50kqDMdj12Z8AZqPHUS6C6jDfxkY65cCub66UKKhIyvLSt9KHoBtnp79aOgombtTmzNCz1UCebEoO2EJvjMjbmpq8T78ps+MyQGtTyEVeuydZGaLAz//+GUFLigWwZr9enfEfpBgSsL5s4BpUHSRkiVWZ3tuukuv0IED71Mwj1xJ7BM/Q0pZR4gozkN/TrYlHr7kL4cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIOM3J9S6qlOxaY+IoDnx8WHXTf6rCsKwucVDL6ZlDs=;
 b=YiVGHgjl6QAvszAB2S8ucAQ9hFvoTklmT2V2P8eqdZefpzCZoE3lESiNWDXeoxn7TZLPSuiVgp/xdyKxs+NAJFU79MuI1C8TBikIHjbQeiqevQikeN5Te3zZI3Uay+XQL/x6Nv4zI9ECoglu8xLN5eu2Ddl90H/UPv+dvMBBDzVqJZiJXSYIFharEY09j0nyc6vFLIQb12t1jfMnWls0ZvxeOUv1AIff1Y2/rQ2TylKTtI0HT9mLvYqifdwHZNx6KCag+ir1CQpee8N0OaYSHU6b8LVbexSfm+bxLNfjw1om87U2muC/XTKY1OA23cJ2FMbTCIsUOMouYfp9v2Pr9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIOM3J9S6qlOxaY+IoDnx8WHXTf6rCsKwucVDL6ZlDs=;
 b=ZBREU7ShOrtoaiUjNf2++DFvBw+///uTrael99RuHP3RkBtfCZoQME/hkE+u6pCfXBO/35bB75Etxi2af4g/1JfXSiXidXPN2anRZAC98TZrnXOxhYOF4BjOJDnPxEsWRXlvDIuN4SaaIUG+gjBZUv7Ed0lfob2SWk6WIfSLVzc=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM8PR04MB7409.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Tue, 21 Nov
 2023 06:37:28 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ebf4:e8bc:d3a7:a51a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ebf4:e8bc:d3a7:a51a%4]) with mapi id 15.20.7025.017; Tue, 21 Nov 2023
 06:37:28 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] serial: imx: also enable Transmit Complete interrupt in
 rs232 mode
Thread-Topic: [PATCH] serial: imx: also enable Transmit Complete interrupt in
 rs232 mode
Thread-Index: AQHaG7S1fEEL5y4CnEW9ieW91W6zVLCEULEQ
Date:   Tue, 21 Nov 2023 06:37:27 +0000
Message-ID: <AS8PR04MB8404D066C247F5B2979CBD1F92BBA@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20231120132256.136625-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20231120132256.136625-1-rasmus.villemoes@prevas.dk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|AM8PR04MB7409:EE_
x-ms-office365-filtering-correlation-id: 1750b270-6893-4342-cc45-08dbea5c549c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gIvPIOHU37Dew1URBZBVOhQs7f6MN5eiIUAuGNOnmyVF83kI3GT1wAsug0jQbOETkwHyL431kd0GG8GmX8Marm0Mu5DSmCHYYfPZAP5b9FSNzsF+8pDACBLK/WrZOPXF1G/oDypp5ORXCoiqswDNSzDfggM1QvI3Kb7mXFn7DT7ELB4L5JSRCpb3VOTt8qKrnx4fhoUzKbTrTYqX2PA33kxuoGlhuFu5aQjZZLX37izAVl+QANZozS7tjnp5J6J/fY3oVXkxwjEgjqI3q5z75o2Kx3Jji7w9icFyPWUSarCJKThmoxHyvIQ+ierp6amrR2Xo15fRXu9wiaHb+MuTOGj3aOc9q+pLlr4hGvZ73Uz+ylxFNbrig4RLNMQ2ap151RldvH2misfO6D7nNCID8k20Wq9XWLtECV9UmK6zc90l8mQIqw+NG9XP7i32z4tBcqRRYFKsrvSyPnKXNhXFitTMw0fnZDTUxfBLUTptbBG/rS91L6u+brtNLIzMPHB5yftp8+O0Aul5R3VDkijR/6r2VTOCzh+40ZoDSXgznvFf1609ch4j9zmxfpp0aGZY2lAWpUeTL3HdMBA+CiP+k+9LlQLSHCGATtmv7snpnC3/Pa8tH4G4CREDExJ7tefE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66946007)(54906003)(66476007)(66446008)(66556008)(64756008)(110136005)(76116006)(316002)(6636002)(6506007)(7696005)(53546011)(9686003)(71200400001)(26005)(38070700009)(478600001)(38100700002)(122000001)(83380400001)(33656002)(86362001)(2906002)(44832011)(52536014)(5660300002)(7416002)(55016003)(4326008)(8936002)(41300700001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WXhOQzRPWmVvbjQ2ek1IVlNwU0dUQkpoY0lOVXFpdjVhTGk3SnpRR09hVE0r?=
 =?gb2312?B?OHM2czYxMnMzQWpxRW4yeWpwQ0FUU3VlWVpRb2l0WTNCdUdlb2h1Smo5aDNi?=
 =?gb2312?B?UDVGSEl0aWdWUEtGL1pPRUhQQ2s0U0VLa1NmM08vdHJ3VXV0Rnk2Uk1WOWhP?=
 =?gb2312?B?K3FFTFhYb3AwNTAwQ0ozdUF6TjA3TXJjbTQ0ZzFYUitPNlpTbXBZYm1GWGxR?=
 =?gb2312?B?K0VhdzVnb29MbmR0aDNMUnZWZ3BlcUJsMHpjdnNkTlhGdHdWZ09PN2s3Z0VG?=
 =?gb2312?B?dEIxbmxFZ1g1WFVGZ1gzOTRrbmMrRWVQL0FYc2VkTmh3ZWdYbWZYWWhIU1Jm?=
 =?gb2312?B?THZmeXpGRE1TWGVUcUMrRUJxR3ZwQzhVZEJlN2xUY1dzZlhWdGc2d3d0N3Zq?=
 =?gb2312?B?OTlvbUUvZFY1K09rT0pvOXZvcDJaVmxJbUc1RmFBT0NXNGYzOVRTZDZXd0pD?=
 =?gb2312?B?cEs4bVYvWlUySXhPUGM1WEpoTk8zVjdURks4c0ZLc3hoR3hLZWRCT3ZBa281?=
 =?gb2312?B?NEUzbllhY3NCbFpoQ0p6SEFzampKWXYwa2RpcnM4T21DTmFMUlpZQ1R3bDBB?=
 =?gb2312?B?L2MvZi81d1BRekdZZmhJRzcyZjk4SnpjLzhuaTJXZzNhU2JOQUZFa0x3N2Nq?=
 =?gb2312?B?MzhLVjFFaEtVQStBTGhMVWNpWTAvNWEwQ0x4c0dJSFp3VyttMTFva09WcHZp?=
 =?gb2312?B?WnJQeHNwSU9VdXM0aFJuczhNa2p0U3JPZE9FbHBNbjc0VmgwMGhhUW9seFp5?=
 =?gb2312?B?eklIbzJzTTRJdlR2ZHFvd1Z1eE1mSGdVMHVIYW1PWTlDVHNvQUxvdkprcFJF?=
 =?gb2312?B?OWRPWExtSkh6cHI5MmY5UU5tUnpuL1dqcFJyRTE4cjY1OUNWVEVBUDZiWjF6?=
 =?gb2312?B?L09rZWxndndIYlZQYjYrWTUvRkIyay9abWJkbkNmQnl5M3MyYysvNzJTSkVQ?=
 =?gb2312?B?WjVwS1dHQjhXb1FpOURrcDQ3U0lJZmZ1NllQeFFwUmRnT3pJdVRHbm1YQzRK?=
 =?gb2312?B?Q0VWSFVWZ09PVkV6SVZ1cDdLUXRTQVBWNmcxckptencrMW9tU1dQRUxBRG5B?=
 =?gb2312?B?SFlsOHJITlNwcmk0Qjh2V2FhVnBWOFVaTllMaXNHdzZrU1dzOC9aRmhtL3c5?=
 =?gb2312?B?N09MekVtVTc4c1pKbmlpVDFReGFZcDRTdm5ncVFjZU0rYldwRjBmNzAyTDl6?=
 =?gb2312?B?L3A2dTVxMHd3SWwzNUR0YjNEb202VnlBZlkvekpUVXJ3OHR2SE9TelZQVnFr?=
 =?gb2312?B?UlhUb1c2SGY3VGFXVGk0YjJ1RkcrU2dPaGxEb3M4aEZyT2FEbTBGUDhLaFkz?=
 =?gb2312?B?d2pjZ08vbFFJUE5nVEd5TzhVbTB1S2x1SndZM0dKMUFZNHUxYlNsNXB3WXdl?=
 =?gb2312?B?cHpnWjZkeC9Dam1XU0dsN1NXZGY2V1FlMkcvTTN5bFN1VnJiL25DUmdYWmI5?=
 =?gb2312?B?N2VRMEhtcDdUaW1OKzBoc0E2Z3pCVThiUUJDdG8zSHUrMFJBOEdVOGlLQWRr?=
 =?gb2312?B?TElPN2ZyTlJYaWt3U2Q4WTBBQ1NvRU1kZVJlUnVSeStXZHZhbHhKall3N1JS?=
 =?gb2312?B?UGJBMHNNQ1ZONmVicVF1UVF5dU5OcGUzam10Q1ZGVm9LQ01ub0cwWE1JTEY0?=
 =?gb2312?B?dUJ1YWluYXdiZm51ZVhrNm81RHVOenBiVTg5anRZZWh3Zm5yVE5yMmZwdzha?=
 =?gb2312?B?WUNPOHc1cE05WTBHRy91M2pLVldiVUxXMkl6aTR2SjNFV0tERXVpNVI2LzJP?=
 =?gb2312?B?YTBvZCtUaW1naHdTL09va05tRVBsUm5KWmZaN0prTWVVcmNDQjl1anFHOTFs?=
 =?gb2312?B?d3NoNGlxSU5XYW02a2s4bndlL1lpYm9WUlZKY2NlOEt5L1cxWGRldXp2ZXQ4?=
 =?gb2312?B?cVZ1NkF2RXo3OEpaRHphUXJsdFlqdFVtb3VYa3RmUXhzRjZRckJhN252bDFK?=
 =?gb2312?B?eENMS2VNQ24wUGtZcE1uMVplTzdYankvQVZDYms2U1EranlKa09yZFN2eSs5?=
 =?gb2312?B?a1JRNlMrMStMQS9LbkN0SndjNm9vQWpGVnEvd2F4MWRRV2VjNk43aUt6Nzhu?=
 =?gb2312?B?dlBiYnRXVEpvaHAweC9BYjhNR2VJVkRLODQ4Z0VIcHplUFBieFdjdTZZZ1lC?=
 =?gb2312?Q?Fo+g=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1750b270-6893-4342-cc45-08dbea5c549c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 06:37:28.0435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sMR3jTxVWmVElBiSc+x2mcBbFtH+753G6E6+WHGlY/vPFGtYaqomc1936QI/hZN9pDKinuZnLMsC05hH7k4f1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7409
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFzbXVzIFZpbGxlbW9l
cyA8cmFzbXVzLnZpbGxlbW9lc0BwcmV2YXMuZGs+DQo+IFNlbnQ6IDIwMjPE6jEx1MIyMMjVIDIx
OjIzDQo+IFRvOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3Jn
PjsgSmlyaSBTbGFieQ0KPiA8amlyaXNsYWJ5QGtlcm5lbC5vcmc+OyBTaGF3biBHdW8gPHNoYXdu
Z3VvQGtlcm5lbC5vcmc+OyBTYXNjaGEgSGF1ZXINCj4gPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+
OyBQZW5ndXRyb25peCBLZXJuZWwgVGVhbQ0KPiA8a2VybmVsQHBlbmd1dHJvbml4LmRlPjsgRmFi
aW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPjsgZGwtbGludXgtDQo+IGlteCA8bGludXgt
aW14QG54cC5jb20+DQo+IENjOiBSYXNtdXMgVmlsbGVtb2VzIDxyYXNtdXMudmlsbGVtb2VzQHBy
ZXZhcy5kaz47IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1zZXJpYWxA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
DQo+IFN1YmplY3Q6IFtQQVRDSF0gc2VyaWFsOiBpbXg6IGFsc28gZW5hYmxlIFRyYW5zbWl0IENv
bXBsZXRlIGludGVycnVwdCBpbg0KPiByczIzMiBtb2RlDQo+IA0KPiBDdXJyZW50bHksIGlmIG9u
ZSBzd2l0Y2hlcyB0byByczIzMiBtb2RlLCB3cml0ZXMgc29tZXRoaW5nIHRvIHRoZSBkZXZpY2Us
IGFuZA0KPiB0aGVuIHN3aXRjaGVzIHRvIHJzNDg1IG1vZGUsIHRoZSBpbXhfcG9ydCdzIC0+dHhf
c3RhdGUgaXMgbGVmdCBhcyBTRU5ELiBUaGlzDQo+IHRoZW4gcHJldmVudHMgYSBzdWJzZXF1ZW50
IHdyaXRlIGluIHJzNDg1IG1vZGUgZnJvbSBwcm9wZXJseSBhc3NlcnRpbmcgdGhlDQo+IHJ0cyBw
aW4gKGkuZS4gZW5hYmxpbmcgdGhlIHRyYW5zY2VpdmVyKSwgYmVjYXVzZSBpbXhfdWFydF9zdGFy
dF9yeCgpIGRvZXMgbm90DQo+IGVudGVyIHRoZSAiaWYgKHNwb3J0LT50eF9zdGF0ZSA9PSBPRkYp
IiBicmFuY2guIEhlbmNlIG5vdGhpbmcgaXMgYWN0dWFsbHkNCj4gdHJhbnNtaXR0ZWQuDQo+IA0K
PiBUaGUgcHJvYmxlbSBpcyB0aGF0IGluIHJzMjMyIG1vZGUsIC0+dHhfc3RhdGUgbmV2ZXIgZ2V0
cyBzZXQgdG8gT0ZGLCBkdWUgdG8NCj4gDQo+IAl1c3IyID0gaW14X3VhcnRfcmVhZGwoc3BvcnQs
IFVTUjIpOw0KPiAJaWYgKCEodXNyMiAmIFVTUjJfVFhEQykpIHsNCj4gCQkvKiBUaGUgc2hpZnRl
ciBpcyBzdGlsbCBidXN5LCBzbyByZXRyeSBvbmNlIFRDIHRyaWdnZXJzICovDQo+IAkJcmV0dXJu
Ow0KPiAJfQ0KPiANCj4gaW4gaW14X3VhcnRfc3RvcF90eCgpLCBhbmQgVEMgbmV2ZXIgdHJpZ2dl
cnMgYmVjYXVzZSB0aGUgVHJhbnNtaXQgQ29tcGxldGUNCj4gaW50ZXJydXB0IGlzIG5vdCBlbmFi
bGVkIGZvciByczIzMi4NCg0KSGkgUmFzbXVzLA0KSSBhbSBhZnJhaWQgdGhpcyBpcyBub3Qgcmln
aHQsIFVTUjJfVFhEQyBpcyBqdXN0IGEgZmxhZywgaXQgaXMgbm90IGFmZmVjdGVkIGJ5IHdoZXRo
ZXIgVUNSNF9UQ0VOIGlzIHNldCBvciBub3QsIFVDUjRfVENFTiBvbmx5IGRldGVybWluZXMgaWYg
VVNSMl9UWERDIGZsYWcgY2FuIGdlbmVyYXRlIGEgaW50ZXJydXB0IG9yIG5vdC4NCkkgdHJpZWQg
b24gaW14OG1wLWV2ayBib2FyZCwgZm9yIHJzMjMyLCBzcG9ydC0+dHhfc3RhdGUgY2FuIGdldCBz
ZXQgdG8gT0ZGIGV2ZW4gd2UgZG9uoa90IHNldCBVQ1I0X1RDRU4uDQoNCkJlc3QgUmVnYXJkcw0K
U2hlcnJ5DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJhc211cyBWaWxsZW1vZXMgPHJhc211cy52
aWxsZW1vZXNAcHJldmFzLmRrPg0KPiAtLS0NCj4gSSdtIG5vdCBzdXJlIHRoaXMgaXMgdGhlIGJl
c3QgZml4Lg0KPiANCj4gQXQgZmlyc3QgSSBjb25zaWRlcmVkIGRvaW5nIHNvbWV0aGluZyBtdWNo
IG1vcmUgdGFyZ2V0ZWQsIGJ1dCBkZWZpbml0ZWx5IGFsc28NCj4gbW9yZSBoYWNreTogSW4gaW14
X3VhcnRfcnM0ODVfY29uZmlnKCksIGlmIHN3aXRjaGluZyBvbiByczQ4NSBtb2RlLCBzaW1wbHkN
Cj4gYWRkICJzcG9ydC0+dHhfc3RhdGUgPSBPRkY7Ii4NCj4gDQo+IElmIHNvbWVvbmUgaGFzIGEg
YmV0dGVyIHN1Z2dlc3Rpb24sIEknbSBhbGwgZWFycy4NCj4gDQo+ICBkcml2ZXJzL3R0eS9zZXJp
YWwvaW14LmMgfCAyNCArKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA5IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdHR5L3NlcmlhbC9pbXguYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYyBpbmRleA0K
PiA3MzQxZDA2MGY4NWMuLmZmZWUxNTdlMTNjZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy90dHkv
c2VyaWFsL2lteC5jDQo+ICsrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYw0KPiBAQCAtNzA4
LDI1ICs3MDgsMTkgQEAgc3RhdGljIHZvaWQgaW14X3VhcnRfc3RhcnRfdHgoc3RydWN0IHVhcnRf
cG9ydA0KPiAqcG9ydCkNCj4gIAkJICAgIHx8IHNwb3J0LT50eF9zdGF0ZSA9PSBXQUlUX0FGVEVS
X1JUUykgew0KPiANCj4gIAkJCWhydGltZXJfdHJ5X3RvX2NhbmNlbCgmc3BvcnQtPnRyaWdnZXJf
c3RvcF90eCk7DQo+IC0NCj4gLQkJCS8qDQo+IC0JCQkgKiBFbmFibGUgdHJhbnNtaXR0ZXIgYW5k
IHNoaWZ0ZXIgZW1wdHkgaXJxIG9ubHkgaWYNCj4gRE1BDQo+IC0JCQkgKiBpcyBvZmYuICBJbiB0
aGUgRE1BIGNhc2UgdGhpcyBpcyBkb25lIGluIHRoZQ0KPiAtCQkJICogdHgtY2FsbGJhY2suDQo+
IC0JCQkgKi8NCj4gLQkJCWlmICghc3BvcnQtPmRtYV9pc19lbmFibGVkKSB7DQo+IC0JCQkJdTMy
IHVjcjQgPSBpbXhfdWFydF9yZWFkbChzcG9ydCwgVUNSNCk7DQo+IC0JCQkJdWNyNCB8PSBVQ1I0
X1RDRU47DQo+IC0JCQkJaW14X3VhcnRfd3JpdGVsKHNwb3J0LCB1Y3I0LCBVQ1I0KTsNCj4gLQkJ
CX0NCj4gLQ0KPiAtCQkJc3BvcnQtPnR4X3N0YXRlID0gU0VORDsNCj4gIAkJfQ0KPiAtCX0gZWxz
ZSB7DQo+IC0JCXNwb3J0LT50eF9zdGF0ZSA9IFNFTkQ7DQo+ICAJfQ0KPiANCj4gKwlzcG9ydC0+
dHhfc3RhdGUgPSBTRU5EOw0KPiArDQo+ICsJLyoNCj4gKwkgKiBFbmFibGUgdHJhbnNtaXR0ZXIg
YW5kIHNoaWZ0ZXIgZW1wdHkgaXJxIG9ubHkgaWYgRE1BIGlzDQo+ICsJICogb2ZmLiAgSW4gdGhl
IERNQSBjYXNlIHRoaXMgaXMgZG9uZSBpbiB0aGUgdHgtY2FsbGJhY2suDQo+ICsJICovDQo+ICAJ
aWYgKCFzcG9ydC0+ZG1hX2lzX2VuYWJsZWQpIHsNCj4gKwkJdTMyIHVjcjQgPSBpbXhfdWFydF9y
ZWFkbChzcG9ydCwgVUNSNCk7DQo+ICsJCXVjcjQgfD0gVUNSNF9UQ0VOOw0KPiArCQlpbXhfdWFy
dF93cml0ZWwoc3BvcnQsIHVjcjQsIFVDUjQpOw0KPiAgCQl1Y3IxID0gaW14X3VhcnRfcmVhZGwo
c3BvcnQsIFVDUjEpOw0KPiAgCQlpbXhfdWFydF93cml0ZWwoc3BvcnQsIHVjcjEgfCBVQ1IxX1RS
RFlFTiwgVUNSMSk7DQo+ICAJfQ0KPiAtLQ0KPiAyLjQwLjEuMS5nMWM2MGI5MzM1ZA0KDQo=

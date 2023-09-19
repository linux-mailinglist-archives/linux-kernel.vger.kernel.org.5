Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24A67A5A17
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 08:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjISGne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 02:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjISGnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:43:32 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2045.outbound.protection.outlook.com [40.107.7.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E865A115;
        Mon, 18 Sep 2023 23:43:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MB6eU8SDizW/deQRcWqI3c0k4rAfEcpA4zKmzzcVitM5ytSuuTotqKkSzofvSoYjUVJusHDf2Jo7FmjttlxVkjxwqoaNm4+m2/VWsEBG5Uft5WNnlL7voM0P4ewV5yeE9E9VwBo3l92NmzREVuFN80EaktaMyQSgeQKmndCwUzfkJysfzvL5yFCsX9c25P5BI6smC0qRKw9yZwPSOxVRX4fZNRrtCdrBF36meXtJXn0Nabum4d1H+dJMxh4nycTU3mp82NNAMnKRBW+NKi180PkMv4z7j+io2VH5THdohOXoYZAWFs9+WxvIQper3lx3d9YAqpWvkBCBMViLS0nOUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0g+QjJwrDsX1ZRI15R0lof4RmSP6/cdFZeWeLHeHJ0=;
 b=HC5WaoWJgGTCdD08eHjm8Gd4NVktArcWE/Nz5kb8R/uFHttXFVigcxPrPRprM6wxvi3kAYr1M3G9+IAgPyN5+R++oK3RVawVdH4HXgx1P4A5jYb/PIGbLU7qkJ8eRouhAwZsEw2BvWp1I/uJZWtE7euH4sFEN0EbkhoMeYDtLE4zcGZL6o60e0jU1i9HH0nleyUBOJFgIdbbeJJfojztGsiox+D9VvqakQ61+a7z7FJ+IFhvtZAnbApCioqlmoSZXMckd25cofgNrYxd8QGEU71TacJDJk4+Sm52G0ogqyZb6q3GrHCSaU1DEd9rslvKJM+MpFKIFusQ3rIFyX8R6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0g+QjJwrDsX1ZRI15R0lof4RmSP6/cdFZeWeLHeHJ0=;
 b=pPQyKTZvf5Io7W6T/bR4smzvOGSneW3qfqV7JYlMKl4l3DHQCcyYYYCYtkeeuNbio0EB3ysy2bXQy5in2GrmScyH7vMS8CizkrkZkkkGK3zwHO0WoYkayHzHxijZ3TJj3BoTa32X57an1U+3md8/MPQy0RdzqwUiWTjEo+c1tRE=
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8)
 by AM8PR04MB7764.eurprd04.prod.outlook.com (2603:10a6:20b:244::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 06:43:21 +0000
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d]) by DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d%7]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 06:43:21 +0000
From:   Hui Fang <hui.fang@nxp.com>
To:     kernel test robot <lkp@intel.com>,
        "tfiga@chromium.org" <tfiga@chromium.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>
CC:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anle Pan <anle.pan@nxp.com>, Xuegang Liu <xuegang.liu@nxp.com>
Subject: RE: [EXT] Re: [PATCH] MA-21654 Use dma_alloc_pages in
 vb2_dma_sg_alloc_compacted
Thread-Topic: [EXT] Re: [PATCH] MA-21654 Use dma_alloc_pages in
 vb2_dma_sg_alloc_compacted
Thread-Index: AQHZ5t7nwJrRJ7WJYEaDKJh4zDlG3LAhRheAgABz49A=
Date:   Tue, 19 Sep 2023 06:43:21 +0000
Message-ID: <DB9PR04MB9284F8565C0A5A3F1E70603D87FAA@DB9PR04MB9284.eurprd04.prod.outlook.com>
References: <20230914145812.12851-1-hui.fang@nxp.com>
 <202309190740.sIUYQTIq-lkp@intel.com>
In-Reply-To: <202309190740.sIUYQTIq-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9284:EE_|AM8PR04MB7764:EE_
x-ms-office365-filtering-correlation-id: 9b631269-814f-4e2a-1fdc-08dbb8dbb76d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QBLeQw1M5mObSOM4JufBlUCiPfIVjk5GBl18G3AMSRiZZCTG0l2/QAE5DEG0o9ixZOXTP/iCBJjCtLeM7yQTnGB4F0YtGxwQYKzCboZ2WJCmVpy2GY6IGqRMrBHKpdOxo20lN9pFsm9p+RgDyNCPONVVcLn/8X52E1abxnFoOoWbFI7YLQmS3Uv6vSY69/BTQp85Vmmz46etPoSrEWY9LnYvlnxa1r3sf27s6DDHg1PJj4WM14DzctrhAHiit7J5UCCiibKiP6i9M+vAt/Xglgqx7v1lhlMxgpeby21T2b0CzYVht7303NovuK7IWLGxSLT44I5hA6563oNJkxFNwD879m6nY+oK//L+5xzN/aEsn7nZ6IjrHxrfraaeLgnmAKNF6arccTwvrxy9Dd4E3HeMxlHkRSgEEH/vYYaev1KA7557659Xuk6Uk/3pVdZ+kYjcqBjRNEkX6gOODWAc7qXYKXYA+fvO2pnKGBG3+vFhijENBfzbt4xmbSKmc+sPpYPM4YksOZBR+4lywa03UCTFVzbS+0FZsDfq7XtmhJwrr8CFWj/X4DbOiogTHGUOHaO5Sl7f46cLkp/Q17kn4wHqBCbBhiv27pAEf8qTnLo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(376002)(346002)(186009)(1800799009)(451199024)(53546011)(6506007)(7696005)(9686003)(71200400001)(83380400001)(86362001)(33656002)(122000001)(38100700002)(38070700005)(55016003)(26005)(41300700001)(316002)(4326008)(8936002)(8676002)(2906002)(64756008)(66476007)(66556008)(76116006)(54906003)(66946007)(110136005)(966005)(478600001)(5660300002)(44832011)(45080400002)(52536014)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVF0ajRlRlhYUUhKc1RwdXZadG0yZDBRVmt5cVZZY2p5YlJsMitBcE84VEth?=
 =?utf-8?B?d0xQY21URy9MRjlHUGFOaFZtYUdYcEtZRnNseGdUcUNWV3kzekRpeXFtZDdm?=
 =?utf-8?B?NnBVTHhKNWdGckVOTHRvcDdnREVCOFIyT3E0NUVJZzNTMnp3ZVBrbWpXOVpi?=
 =?utf-8?B?YS9ST2xncGxEUElLcVI0R2hqNzhVR1oyVjJHUkY4TkRuWk1VRkRsb2h5MGR3?=
 =?utf-8?B?OVd5c0EvaFpUeW1uN040b3JoT2hRUFN4Z1ZnZE5uL2R4SVVKd1djbmZxMklG?=
 =?utf-8?B?b1MzTzlqZHR4QTVjTkNzQitENE55TThMQjJnUGc2YmxQV0djZU9WYjlVbXlv?=
 =?utf-8?B?cjk2QlRid2lYeUZGbXhZSS90WXF5NFVSNWFuZjJTdTN2cEdEM0V3TlZ3WWNs?=
 =?utf-8?B?RjJOZlIwdE9aWERma1JjWDhuZXJCSGF2NmRVMlVNbDcxQ0JPUGhqblhycjB1?=
 =?utf-8?B?dUM0N3NLL0ZJclpaMWQvL3YxdG5qOUJsRjFKaEl4blRZZDZ4QXNCdjQ0UVpM?=
 =?utf-8?B?Nnc2K0M3enZtNW9vRFM0MERSajNkd3JJanFxelV4Zy93akgzd2hFUTZMQ0ht?=
 =?utf-8?B?NEIzdWlyQWdRVDdtVm5hczVuMDU2d1duejlkaHZhNGpib0l6OERuOHliRm1I?=
 =?utf-8?B?dUd4NFRGYWdmbXpuOFZ0cUdtbXIzM0JnZjBSSTYvNFlQRy8za09ERXlqVmo0?=
 =?utf-8?B?UTBLei9hNkk0Yy9xUlNQZnliSGhrWTM2bUFWSFRWamdOVUpzOFZpdVhDUEdK?=
 =?utf-8?B?Rkd2U2ovcFl1VlVycVpFRXRkOERhVjFmRlVjd0MyVzF3aFdRWUJIME5VeGpu?=
 =?utf-8?B?VGlsVlNhV3ptclVaV1Q5K2JIUTZxQUxDWGFpdEFxZjFTaGxZbnNxUG9SMjFO?=
 =?utf-8?B?Q3lJbUIzZU9qbkVDN29tYlNHNFFpa0xCZHhHZDBCOVUxR1ZaM2EyTC9vZnRL?=
 =?utf-8?B?Tk9XVXJBR1FLOVYzNnV0WHc0WnRpYUl6WU42QVA5NjMxbVNrMm45Qy9uaWQ2?=
 =?utf-8?B?VndjVGZQMWlHZG9KdEhCVHlTblhOL3NFOWo3L1orMktpUWVEa0ZNLzczQlcy?=
 =?utf-8?B?dzZEMzAyT0pZeUhGVjIwYW4wamw4S3ZibmtlY3pxRXFVUkFxVE1LWkFaeEM3?=
 =?utf-8?B?WGJ4RUZLY2M4VFU5Q3BYVHpCWXBaaFdyeUFwOXR4MjVVcUdwMlFiMjk2Yzk0?=
 =?utf-8?B?ejJmblBIczhydjVSMllBUmlKbW1RZ1VJd1REalVkbjFPbWdIaGhMRGFXeG9w?=
 =?utf-8?B?akZkTk5ranhjUGgzRkRoVjJ0SU9kYTZPUWp3V2lhcEVuOFhueEF0UVdZOTZa?=
 =?utf-8?B?WEw3cFk3b3IrYnlWOW9GeXFEZHh5bGs3NUYzMjdFZmJsL1JxU3BudnRnOVlG?=
 =?utf-8?B?WjMydnVkZm52REdRdFYxRGJhVHFkdUtMajFjWmFTYys1SWh0T01NcWpQVHFF?=
 =?utf-8?B?MGlVQkVnOEZvTjBMMGlyQjdMTThSS0FoTFpMbzg3WC9GOFJkekhFdWdEckhJ?=
 =?utf-8?B?U2lyY0VueWhORExRUmlhU0RON3JoZjM0ZVpaK3EzMTlqbTRVQ09XZDU2VmZI?=
 =?utf-8?B?cVVNOXp4aENUTlFCWWtYdEdjWGh1QjFFdkwyL0E5VkZPeDJTbzc1eEdPNmxk?=
 =?utf-8?B?azRNK0JpN1QzdEN0aEdJMGRzOUs3ek1qZUdOQmd0L1J1L2ZWUGJwb09lV1Iz?=
 =?utf-8?B?K1dkeXRqbGo2THRYZGhTbURaQ2VtZ2JBTzhoZXZSeXhxRjBQOE5TTHliSlo4?=
 =?utf-8?B?eDI5WFMzN04rT0o1U21FcXJlYVUxTlNFZ2hDWE9XNHJ6UU13ak5LcVM3TnBn?=
 =?utf-8?B?cFZtT0NkMWJGSTA5N3ZqdW0xZHJaaGk2WGxMMFNtY0FTWi9kM0tiZVdOc1VF?=
 =?utf-8?B?UUs5MTlMZHRQcUZybWdEcnNpeWxtOERSbzJCY3BNakYrajFOeWp0YkFSdm9M?=
 =?utf-8?B?K3luaHhZaVNMTk5adGQwOFBMRyt4VGJaT21FQ2VockllMTlJQjBsZ29Nbkho?=
 =?utf-8?B?NGVOSDBFdkUrSU83TFI1K1BoZHR3V3ZEVCtBVTIzQzBuNHpHMjZWVFhHUnJo?=
 =?utf-8?B?MTRZWXZwbk1MYy9vdjNuYkVYOW1wckY3V3QrV0ptZEIzN2lheFJCbHZnNFlu?=
 =?utf-8?Q?435g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b631269-814f-4e2a-1fdc-08dbb8dbb76d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 06:43:21.7460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qvVKg3ceoZ7XpiRGnYFKiPj6jO+8x2zZeMW1ve/MprSwmFF3FJsKmxMUq88BcwaT2vvvjRkZUN8N1hJCa4WQSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7764
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBTZXAgMTksIDIwMjMgYXQgMDc6NDTigK9BTSBrZXJuZWwgdGVzdCByb2JvdCA8bGtw
QGludGVsLmNvbT4gd3JvdGU6DQo+IEhpIEZhbmcsDQo+DQo+IGtlcm5lbCB0ZXN0IHJvYm90IG5v
dGljZWQgdGhlIGZvbGxvd2luZyBidWlsZCBlcnJvcnM6DQo+DQo+IFthdXRvIGJ1aWxkIHRlc3Qg
RVJST1Igb24gbWVkaWEtdHJlZS9tYXN0ZXJdIFthbHNvIGJ1aWxkIHRlc3QgRVJST1Igb24NCj4g
bGludXMvbWFzdGVyIHY2LjYtcmMyIG5leHQtMjAyMzA5MThdIFtJZiB5b3VyIHBhdGNoIGlzIGFw
cGxpZWQgdG8gdGhlIHdyb25nIGdpdA0KPiB0cmVlLCBraW5kbHkgZHJvcCB1cyBhIG5vdGUuDQo+
IEFuZCB3aGVuIHN1Ym1pdHRpbmcgcGF0Y2gsIHdlIHN1Z2dlc3QgdG8gdXNlICctLWJhc2UnIGFz
IGRvY3VtZW50ZWQgaW4NCj4gaHR0cHM6Ly9naXQtc2NtLmMvDQo+IG9tJTJGZG9jcyUyRmdpdC1m
b3JtYXQtcGF0Y2glMjNfYmFzZV90cmVlX2luZm9ybWF0aW9uJmRhdGE9MDUlN0MwMSUNCj4gN0No
dWkuZmFuZyU0MG54cC5jb20lN0MzYzZmMTQ5NjJlYmM0NDgzMjM1MzA4ZGJiOGExMjc4MiU3QzY4
NmVhMWQNCj4gM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM4MzA2Nzc0NTMz
NzYyODg3JTdDVW5rbm93DQo+IG4lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxD
SlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhVw0KPiB3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3
QyU3QyU3QyZzZGF0YT00WGYyeThkQTdKR1pGNGhsRU1kbkxJSUsNCj4gYiUyRklIMk5TNjEyWk5G
dmJscXFvJTNEJnJlc2VydmVkPTBdDQo+DQo+IHVybDoNCj4gaHR0cHM6Ly9naXRodWIuY28vDQo+
IG0lMkZpbnRlbC1sYWItbGtwJTJGbGludXglMkZjb21taXRzJTJGRmFuZy1IdWklMkZNQS0yMTY1
NC1Vc2UtZG1hX2FsbA0KPiBvY19wYWdlcy1pbi12YjJfZG1hX3NnX2FsbG9jX2NvbXBhY3RlZCUy
RjIwMjMwOTE0LTE1NDMzMyZkYXRhPTA1JTcNCj4gQzAxJTdDaHVpLmZhbmclNDBueHAuY29tJTdD
M2M2ZjE0OTYyZWJjNDQ4MzIzNTMwOGRiYjhhMTI3ODIlN0M2OA0KPiA2ZWExZDNiYzJiNGM2ZmE5
MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzODMwNjc3NDUzMzc2Mjg4NyU3Q1UNCj4gbmtub3du
JTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRp
STZJaw0KPiAxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAlN0MlN0MlN0Mmc2RhdGE9dVBQYm5N
cXFPMVg1NUg3dEMNCj4gYk9sc2Z1TzQ2ZGNFcnZKTHhOU0c1QnNsclUlM0QmcmVzZXJ2ZWQ9MA0K
PiBiYXNlOiAgIGdpdDovL2xpbnV4dHYub3JnL21lZGlhX3RyZWUuZ2l0IG1hc3Rlcg0KPiBwYXRj
aCBsaW5rOg0KPiBodHRwczovL2xvcmUua2Vybi8NCj4gZWwub3JnJTJGciUyRjIwMjMwOTE0MTQ1
ODEyLjEyODUxLTEtaHVpLmZhbmclMjU0MG54cC5jb20mZGF0YT0wNSU3Qw0KPiAwMSU3Q2h1aS5m
YW5nJTQwbnhwLmNvbSU3QzNjNmYxNDk2MmViYzQ0ODMyMzUzMDhkYmI4YTEyNzgyJTdDNjg2DQo+
IGVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzgzMDY3NzQ1MzM3NjI4
ODclN0NVbg0KPiBrbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlq
b2lWMmx1TXpJaUxDSkJUaUk2SWsxDQo+IGhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJTdDJTdD
JTdDJnNkYXRhPTZkWUYya2s1YmEwVEUwQjJqWk0NCj4gaE5XUFJUa2RuMnpoV2dRWjdMSFRFMWNF
JTNEJnJlc2VydmVkPTANCj4gcGF0Y2ggc3ViamVjdDogW1BBVENIXSBNQS0yMTY1NCBVc2UgZG1h
X2FsbG9jX3BhZ2VzIGluDQo+IHZiMl9kbWFfc2dfYWxsb2NfY29tcGFjdGVkDQo+IGNvbmZpZzog
c2gtcmFuZGNvbmZpZy0wMDItMjAyMzA5MTkNCj4gKGh0dHBzOi8vZG93bmxvYS8NCj4gZC4wMS5v
cmclMkYwZGF5LWNpJTJGYXJjaGl2ZSUyRjIwMjMwOTE5JTJGMjAyMzA5MTkwNzQwLnNJVVlRVElx
LWxrcCUNCj4gNDBpbnRlbC5jb20lMkZjb25maWcmZGF0YT0wNSU3QzAxJTdDaHVpLmZhbmclNDBu
eHAuY29tJTdDM2M2ZjE0OTYyDQo+IGViYzQ0ODMyMzUzMDhkYmI4YTEyNzgyJTdDNjg2ZWExZDNi
YzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTcNCj4gQzAlN0M2MzgzMDY3NzQ1MzM3NjI4ODcl
N0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGoNCj4gQXdNREFpTENKUUlqb2lW
Mmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAlN0MlN0MNCj4gJTdD
JnNkYXRhPVBNWlglMkY5Z01QT0d4UG5DNWNWU0FCSHFhNFhmZCUyRmE2c2d5amNnaFJxZm9JJTNE
JnINCj4gZXNlcnZlZD0wKQ0KPiBjb21waWxlcjogc2g0LWxpbnV4LWdjYyAoR0NDKSAxMy4yLjAN
Cj4gcmVwcm9kdWNlICh0aGlzIGlzIGEgVz0xIGJ1aWxkKToNCj4gKGh0dHBzOi8vZG93bmxvYS8N
Cj4gZC4wMS5vcmclMkYwZGF5LWNpJTJGYXJjaGl2ZSUyRjIwMjMwOTE5JTJGMjAyMzA5MTkwNzQw
LnNJVVlRVElxLWxrcCUNCj4gNDBpbnRlbC5jb20lMkZyZXByb2R1Y2UmZGF0YT0wNSU3QzAxJTdD
aHVpLmZhbmclNDBueHAuY29tJTdDM2M2ZjE0DQo+IDk2MmViYzQ0ODMyMzUzMDhkYmI4YTEyNzgy
JTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MNCj4gMCU3QzAlN0M2MzgzMDY3
NzQ1MzM3NjI4ODclN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQw0KPiA0d0xqQXdN
REFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAl
Nw0KPiBDJTdDJTdDJnNkYXRhPTZwemNLTUklMkJ5MlcxYnBBam50SjdlaXpnaU5tdGNDRzd0aTRv
RUYzUjAxZyUzRCZyDQo+IGVzZXJ2ZWQ9MCkNCj4NCj4gSWYgeW91IGZpeCB0aGUgaXNzdWUgaW4g
YSBzZXBhcmF0ZSBwYXRjaC9jb21taXQgKGkuZS4gbm90IGp1c3QgYSBuZXcgdmVyc2lvbiBvZiB0
aGUNCj4gc2FtZSBwYXRjaC9jb21taXQpLCBraW5kbHkgYWRkIGZvbGxvd2luZyB0YWdzDQo+IHwg
UmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiB8IENsb3Nl
czoNCj4gfCBodHRwczovL2xvcmUvDQo+IHwgLmtlcm5lbC5vcmclMkZvZS1rYnVpbGQtYWxsJTJG
MjAyMzA5MTkwNzQwLnNJVVlRVElxLWxrcCU0MGludGVsLmNvbSUyRg0KPiB8DQo+ICZkYXRhPTA1
JTdDMDElN0NodWkuZmFuZyU0MG54cC5jb20lN0MzYzZmMTQ5NjJlYmM0NDgzMjM1MzA4ZGJiOGEN
Cj4gMTI3ODIlDQo+IHwNCj4gN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAl
N0MwJTdDNjM4MzA2Nzc0NTMzNzYyODg3DQo+ICU3Q1Vua24NCj4gfA0KPiBvd24lN0NUV0ZwYkda
c2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhDQo+
IFd3aQ0KPiB8DQo+IExDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3QyU3QyU3QyZzZGF0YT00NWElMkZW
WSUyRnU4YXhJS2lnUENFM2UNCj4gV0VYaW5EMUVHDQo+IHwgZFFRdTlUQ25CWiUyQk1JMCUzRCZy
ZXNlcnZlZD0wDQo+DQo+IEFsbCBlcnJvcnMgKG5ldyBvbmVzIHByZWZpeGVkIGJ5ID4+KToNCj4N
Cj4gICAgc2g0LWxpbnV4LWxkOiBkcml2ZXJzL21lZGlhL2kyYy90YzM1ODc0Ni5vOiBpbiBmdW5j
dGlvbiBgdGMzNTg3NDZfcHJvYmUnOg0KPiAgICB0YzM1ODc0Ni5jOigudGV4dCsweDFiOGMpOiB1
bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBkZXZtX2Nsa19od19yZWdpc3RlcicNCj4gICAgc2g0LWxp
bnV4LWxkOiB0YzM1ODc0Ni5jOigudGV4dCsweDFiOTApOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRv
DQo+IGBkZXZtX29mX2Nsa19hZGRfaHdfcHJvdmlkZXInDQo+ICAgIHNoNC1saW51eC1sZDogdGMz
NTg3NDYuYzooLnRleHQrMHgxYjk0KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiBgb2ZfY2xr
X2h3X3NpbXBsZV9nZXQnDQo+ICAgIHNoNC1saW51eC1sZDogZHJpdmVycy9tZWRpYS9jb21tb24v
dmlkZW9idWYyL3ZpZGVvYnVmMi1kbWEtc2cubzogaW4NCj4gZnVuY3Rpb24gYHZiMl9kbWFfc2df
YWxsb2NfY29tcGFjdGVkJzoNCj4gPj4gdmlkZW9idWYyLWRtYS1zZy5jOigudGV4dCsweDU3Yyk6
IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGRtYV9hbGxvY19wYWdlcycNCj4NCj4gLS0NCj4gMC1E
QVkgQ0kgS2VybmVsIFRlc3QgU2VydmljZQ0KPiBodHRwczovL2dpdGh1Yi5jby8NCj4gbSUyRmlu
dGVsJTJGbGtwLXRlc3RzJTJGd2lraSZkYXRhPTA1JTdDMDElN0NodWkuZmFuZyU0MG54cC5jb20l
N0MzYw0KPiA2ZjE0OTYyZWJjNDQ4MzIzNTMwOGRiYjhhMTI3ODIlN0M2ODZlYTFkM2JjMmI0YzZm
YTkyY2Q5OWM1YzMwMTYzNQ0KPiAlN0MwJTdDMCU3QzYzODMwNjc3NDUzMzc2Mjg4NyU3Q1Vua25v
d24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaQ0KPiBNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklp
TENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMA0KPiAlN0MlN0MlN0Mmc2RhdGE9
dkE5aCUyRkdGZkllbDVoYmNZVkIwTGdKR2pIdERxMW9GNFNyZkl2UWNSbTkwJTNEDQo+ICZyZXNl
cnZlZD0wDQoNCg0KSSB3b25kZXIgaWYgaXQncyBzdWl0YWJsZSB0byB1cyB0aGUgY29uZmlnIChD
T05GSUdfTk9fRE1BPXkpIHRvIGJ1aWxkPw0KQWxzbywgdGhlcmUgYXJlIG90aGVyIHVuZGVmaW5l
ZCByZWZlcmVuY2VzIG5vIHJlbGF0ZWQgdG8gdGhlIHBhdGNoLg0KDQpCUnMsDQpGYW5nIEh1aQ0K

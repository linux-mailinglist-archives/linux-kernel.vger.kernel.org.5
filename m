Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94547CF435
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345035AbjJSJln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJSJll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:41:41 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E65106;
        Thu, 19 Oct 2023 02:41:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCuiO/nXd8nnuJjDVDSbzAVKoA/XqPaUbBBd7i+72uSY/Hie078S6e6YVxCYzlYmAGWZRqZ0wXOijiuHOvW38p8iQl47VSu9hSC8xmfoum0CVnSTMK6/R8ekuGxP0pWroJ+GTXWw2k5TZ1R5vdt0f4ggl9okTRchOegzm5otumiTuSoidXNz0vNI96W2V0tn+8uPiotIayzYDJflPqxeJavCzDPCT9kfhMmom1mw0itnsuYL16gXE9Knk5OK5G8CVrZ67pvF5VmzbwcG+vsEfqnCYcnfMjcCF5zTxZBSSPA6plfS36wgO2FFg7sFH3+/DvGy6FGtGNF2MwBalcsH6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJRvML7JmnNXNJ9Z48l4iuQbVipZB2q62RbusHB3bNs=;
 b=TvEd5eoBKSZf7TGSjlHU9H0hYI9rHOn8/yHMCmjOF29rAyZJSf0gDXAMDUwrBHRvtdVGg68w7fCcPUzCD1bQdH8z13pEJau2iLJVp3iKbm0K3wyrKfHU7WA9rmm7EINk6nMBa0wRE2nmHnYMyFKIaDvYuE03bBu82JAxGOc+2wTrTq+Md1HvAthiVssofnqAGnC68vYzuKVOnEi/MvJwppfWz5FIX58To8MrODOpxi6NX5DcpiAoonWYwAl/mDt7ldgvm97y/iSr5XL3XVL69Nx11l8529LxxjIvzbIt93sFwYOOCjTZor/3ToVkA/6rIdAumQUgenyxy8M2jsBL8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJRvML7JmnNXNJ9Z48l4iuQbVipZB2q62RbusHB3bNs=;
 b=B8VUN96CPQwpk61C0mnLHUvdslTOHHKjtC2hLnf8BDc3rBbH8+cuDromnue3KuyxQfCIeZ9Lu0QcqOVa++hjne6FqAyIeeIoC498vhA5XHo8+lobgIPNKU1E+EuVWvWhJSjv8wNq+gMgP8y782+WwYGd/tcMo6ufhQD959Chyg0=
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by AS8PR04MB8628.eurprd04.prod.outlook.com (2603:10a6:20b:42b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 09:41:35 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::527a:fa6f:ffe2:5326]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::527a:fa6f:ffe2:5326%3]) with mapi id 15.20.6933.008; Thu, 19 Oct 2023
 09:41:35 +0000
From:   Neeraj sanjay kale <neeraj.sanjaykale@nxp.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v1 1/2] Bluetooth: btnxpuart: Fix btnxpuart_close
Thread-Topic: [PATCH v1 1/2] Bluetooth: btnxpuart: Fix btnxpuart_close
Thread-Index: AQHaAnBzu6S+dfRrJUq5wrzBLpe5kg==
Date:   Thu, 19 Oct 2023 09:41:35 +0000
Message-ID: <AM9PR04MB860329622408ED0DC4D1CCC6E7D4A@AM9PR04MB8603.eurprd04.prod.outlook.com>
References: <20231018145540.34014-1-marcel@ziswiler.com>
         <20231018145540.34014-2-marcel@ziswiler.com>
         <AM9PR04MB8603471C0C4BF61CC3AA3BF5E7D5A@AM9PR04MB8603.eurprd04.prod.outlook.com>
 <872a2317c504c011c5022b21e35d3d490639525b.camel@toradex.com>
In-Reply-To: <872a2317c504c011c5022b21e35d3d490639525b.camel@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8603:EE_|AS8PR04MB8628:EE_
x-ms-office365-filtering-correlation-id: b565738c-ad89-46c0-d72c-08dbd08795f0
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UlWUd0HKhTJnYKC8uZS+DqVyxOhrhYqz942A9JnhKW3nbmI/fM72xc2UwWB+ccMqZtdpZ7PS6YvqPAGkVj2h/O3mErdH6nxjwDcXdgGOyz2+mizh/LaiTXCFTMhJ4f5JyA7Qtd+wmkP5fDWkv55PDz3XrqqXSje77klkATUbg5kdSMdMpXi1Ulfko73rQKN5mUcRW3Ba7nYsKCRxxf6dIj9CGySQGgvcKGaK8YmJutmm+Htd+Fj7/uskthhzNGYm607/QDk5X+xmNWwdDVt4mFkKorSj5n9qYd/0iEefax+5onZtWJMLn7Xs2tNikgxDlr0vwoGCF5frzxrS+3KSpI40G9AmIZKa/PUPfDsBZDIxl7opwRx+tf0s/BTLPJZ3j3XHXXvutEE9SrQqQRJyCw7HjvFc21id0bCJaDWgeGTE4CeMPPGRJFVRDo+rpGhd5zDB72XuAiCiMno3IOykFLDheG+VuLB1bQRmTm9ZxfMXsy3woPYe0O1tteHGi67Ot4hfBOqKbKHYcRHs9nRTK0Ma+9c0SmkNEikk6FZgvXOI/EHlDmQXNFDta4286dPLh+HAARhUE19VhOTU2nq4Q+FJ1fqPGCYq3/5Qr/H1C82GbiDd/gJtthPR1/OWqYzS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(55016003)(5660300002)(6506007)(64756008)(41300700001)(76116006)(66946007)(66556008)(110136005)(66446008)(66476007)(54906003)(478600001)(316002)(7696005)(9686003)(8936002)(86362001)(4326008)(33656002)(52536014)(122000001)(2906002)(38100700002)(26005)(71200400001)(83380400001)(8676002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUQyOW81MEs3NHp5UjkzRWhZQW5pMWFseXRpUFNQTlZzeEx4S2xKNjYvOWtS?=
 =?utf-8?B?STNtWllrZkVuRnF2UHpNYjZtanRLRjh0VGZZQ09CamFvUmhLbnZVR2pzdVox?=
 =?utf-8?B?NWFkOUxQVTNJK21Ud2YyODdBd3R1YkVIbnlpSFpna01CSnpwd1lBcmdMYWhq?=
 =?utf-8?B?N29KVi8wUzU3UVhiWUVlU21PZ0k5U08wc1JqUVlXd0pHdHVBMVVQaDg1UXZQ?=
 =?utf-8?B?MVVjUGhBUVBzN0ZZaWo1OVN2a1E3dGtzbUEweU0zRW40S29xS1k2aTh2cHZN?=
 =?utf-8?B?L0daQkxnTUMrTkFBVVJqeTV2MDBWQzNqY0pEcWg4ZWhORGpCRG1yRVlJd1Fq?=
 =?utf-8?B?NzU0ZXRTV1lqZTg5amhkZ0U5ZHdsM2tzcjdNTFNyRHdsTEhkUkJ5WnZtUWNL?=
 =?utf-8?B?N21zNlh0RW1RSUJvclM2ZmllMlloWVEvRTJ6c2FFV0VueWh4Skw0Y0pnNE1T?=
 =?utf-8?B?Z243YnFMN0l3OThUTFNVRExIcGZKVWVrMEJORW8yd0FJL2xPa0UrSXdydWU5?=
 =?utf-8?B?a3g1WlpLc1RjUk1RVVpLc0EwajFEZG1LREFmbFlPRXE2dm5lT21UMkJOaWU0?=
 =?utf-8?B?VThaenF1cXM1L1AvRUZFNzUyOG9oZjBZWVgvS1lVVytBSWt5RDh5Q1FPa1VZ?=
 =?utf-8?B?YWZFZUw0NGR3UHdkQlFyNTB3UG9xeTh0Vlk5Vktic2J5MW4vbnhCUGNOZVhK?=
 =?utf-8?B?cjlGOWZkeFdIK3pwMXBjUEFVQ0o4TFp4NnNkWFFqTmlpT0svK00zUkMxcExm?=
 =?utf-8?B?elZmQnJveml5SmpZQnYxckVsWG9MNGlDMU9aUnpVbkdKV3BZbDQvTFUxdHNn?=
 =?utf-8?B?QThHOVdnOGl1b0RudVJLb2VoQ1F0eUlQWkRZTHhnYmtmRFFQV3huUENCVDlE?=
 =?utf-8?B?SDRDVk11Um8waGZNUHoyOHpJSHplMG43Zm13QUh2R1cvZEkyUE1IcWJmMjRq?=
 =?utf-8?B?cXRtenNXaE1tUXFLRnJSZkhBRmExdmRZVkcwS1JDNHBNanpVN2doVjRJdWpZ?=
 =?utf-8?B?UDNRSE5vSVdWOXhkN3FrcmgzdFBIOU1xNmtYSUIxeElhSnFIeStGc1J3VytL?=
 =?utf-8?B?RFZDcHpTRFBkanpIWi9WLzVRdkVyUXVzakpaUmRRTDZVRDFtS2NzVU1EZEFh?=
 =?utf-8?B?Mm5rTE9WTkpobXRSNis4MnZyL3ZBa08zQ2hqZWVRdEt5NjVzTjNNRWJLbnRU?=
 =?utf-8?B?Q1p0V0xPbHdOR0t3Q3NBcjkzRTdsT0RKYzJQSGw3WGVEN1V0RWRubGVFVDRZ?=
 =?utf-8?B?WE5aQ3JhMnRCdnlWaW44a0FhVHZpOWd6bi9USmc4ZkZCRmxDWkFSeThEaGxO?=
 =?utf-8?B?SDA4YVFZMVhDN1dZcnpTMTk1TE53Y0tyRG1aTzM0R01qcFYxd01MSnhhUW5W?=
 =?utf-8?B?UkJBVUExdFZ6VEwvUVplcjNoQlluakZWdytQSWlkUEQ0U2Z3Y2hxbkcvUk1s?=
 =?utf-8?B?ZHdHS25tanZsVUt2UDA3OTBMMUk2cHlqYlQ4L2laSFJLaTZyakRTTXNBOTFH?=
 =?utf-8?B?NnBvUDdGRkVVd2hqM3ZHT3ZQMGFoazhPcExaK1dRR3BmRXNUcFphOFdLbWJi?=
 =?utf-8?B?aHhkV0Iybkx4aVozV1RocU5Bdi9OU3IrZWwzZmtsWWV4M3NKNWpGZXcrcEF6?=
 =?utf-8?B?WmlpQ0htdVZjbnpTV3VVZURCTUpmQzNEQWFQdmhwaUZMc0tURzVyZ3pBeEY0?=
 =?utf-8?B?OEM5SlpBUjF3TTY5NHFldFFsZ0NidXBKUVRuWEtlcnJ4Z2VXLzRzeHFoYlpv?=
 =?utf-8?B?aGw3QWtGa2xOTVB1TUprQXBRSjd2N2VnQUhjckNqZThicDh4cGdPd0ZFWjNH?=
 =?utf-8?B?bkh1bnpUWVhOSHRLYmdGSUpLNVFjU1lZd2hlNkNZR1hqWk95ODI0Rko2cU9o?=
 =?utf-8?B?VWhubDBOTjA3TG40MVhUOXE5YTBiRVNJSHlBUkkzMkhuZ3Mxa1ZDQ3ltV0hI?=
 =?utf-8?B?N3lhSndiSmxUUDZBNGFldmt1OUJHTEdkcDJmSzVFSTRxRFozb2RKZ0JlUlFi?=
 =?utf-8?B?TnNNWHJDc1VWTXBQVCtlb296TDJpVzE5UGRhR1dhYWkzVExoK0N4N244UEM0?=
 =?utf-8?B?YzRiZGJ1YmY1NHJ2RVpGb0xDbWc0cTR5Q1BkMHhqK3lJZFdsUHZhZ0tka3Fm?=
 =?utf-8?B?VVI5Y0FvRllRUUdvR041L1YyRGFUak1BTmhzS05XNDVNbVdqbnJUVTNzdUdv?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b565738c-ad89-46c0-d72c-08dbd08795f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 09:41:35.7695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lGK3xD8Lc+CMSlHrI9HNW7A+CwiLfAsdI1wqfEJN+hwCDyUGPJRbDXMklEDtIzIWeXhZsg6IH0886lj2c+glX4tQpTfRChvMyO1ABNd7EPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8628
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyY2VsDQoNCj4gPiA+IEZyb206IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVy
QHRvcmFkZXguY29tPg0KPiA+ID4NCj4gPiA+IFVuZm9ydHVuYXRlbHksIGJ0bnhwdWFydF9jbG9z
ZSgpIG1heSB0cmlnZ2VyIGEgQlVHOiBzY2hlZHVsaW5nIHdoaWxlDQo+IGF0b21pYy4NCj4gPiA+
IEZpeCB0aGlzIGJ5IHByb3Blcmx5IHB1cmdpbmcgdGhlIHRyYW5zbWl0IHF1ZXVlIGFuZCBmcmVl
aW5nIHRoZSByZWNlaXZlDQo+IHNrYi4NCj4gPiA+DQo+ID4gPiBGaXhlczogNjg5Y2ExNmU1MjMy
ICgiQmx1ZXRvb3RoOiBOWFA6IEFkZCBwcm90b2NvbCBzdXBwb3J0IGZvciBOWFANCj4gPiA+IEJs
dWV0b290aCBjaGlwc2V0cyIpDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogTWFyY2VsIFpp
c3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+DQo+
ID4gPiAgZHJpdmVycy9ibHVldG9vdGgvYnRueHB1YXJ0LmMgfCAzICsrKw0KPiA+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ibHVldG9vdGgvYnRueHB1YXJ0LmMNCj4gPiA+IGIvZHJpdmVycy9ibHVldG9vdGgvYnRu
eHB1YXJ0LmMgaW5kZXggYjdlNjZiN2FjNTcwLi45Y2I3NTI5ZWVmMDkNCj4gPiA+IDEwMDY0NA0K
PiA+ID4gLS0tIGEvZHJpdmVycy9ibHVldG9vdGgvYnRueHB1YXJ0LmMNCj4gPiA+ICsrKyBiL2Ry
aXZlcnMvYmx1ZXRvb3RoL2J0bnhwdWFydC5jDQo+ID4gPiBAQCAtMTIzNCw2ICsxMjM0LDkgQEAg
c3RhdGljIGludCBidG54cHVhcnRfY2xvc2Uoc3RydWN0IGhjaV9kZXYNCj4gPiA+ICpoZGV2KQ0K
PiA+ID4NCj4gPiA+ICAgICAgICAgcHNfd2FrZXVwKG54cGRldik7DQo+ID4gPiAgICAgICAgIHNl
cmRldl9kZXZpY2VfY2xvc2UobnhwZGV2LT5zZXJkZXYpOw0KPiA+ID4gKyAgICAgICBza2JfcXVl
dWVfcHVyZ2UoJm54cGRldi0+dHhxKTsNCj4gPiA+ICsgICAgICAga2ZyZWVfc2tiKG54cGRldi0+
cnhfc2tiKTsNCj4gPiA+ICsgICAgICAgbnhwZGV2LT5yeF9za2IgPSBOVUxMOw0KPiA+ID4gICAg
ICAgICBjbGVhcl9iaXQoQlROWFBVQVJUX1NFUkRFVl9PUEVOLCAmbnhwZGV2LT50eF9zdGF0ZSk7
DQo+ID4gPiAgICAgICAgIHJldHVybiAwOw0KPiA+ID4gIH0NCj4gPiBUaGlzIGlzIGFscmVhZHkg
ZG9uZSBpbiBidG54cHVhcnRfZmx1c2goKSwgd2hpY2ggaXMgY2FsbGVkIGJ5DQo+ID4gaGNpX2Rl
dl9jbG9zZV9zeW5jKCksIGJlZm9yZSBpdCBjYWxscyBidG54cHVhcnRfY2xvc2UoKS4NCj4gDQo+
IFllcywgSSB3YXMgYWxzbyB3b25kZXJpbmcgYWJvdXQgdGhhdC4NCj4gDQo+ID4gSXMgYnRueHB1
YXJ0X2ZsdXNoKCkgbm90IGNhbGxlZCBkdXJpbmcgeW91ciB0ZXN0aW5nPw0KPiANCj4gWWVzLCBJ
IGV2ZW4gYWRkZWQgc29tZSBtb3JlIHRyYWNpbmcgdG8gY29uZmlybSB0aGlzLiBIb3dldmVyLCB3
aXRob3V0IG15DQo+IGZpeCAod2hpY2ggQlRXIHdhcyBpbnNwaXJlZCBieSBsb29raW5nIGF0IHRo
ZSBmb3JtZXIgaGNpX21ydmwuYyBkcml2ZXIpIHRoaXMNCj4gYnVnIGlzIHJlYWxseSBvY2N1cmlu
Zy4gSnVzdCBrZWVwIGxvYWRpbmcvdW4tbG9hZGluZyB0aGUga2VybmVsIG1vZHVsZSBhIGZldw0K
PiB0aW1lcyBhbnkgeW91IG1heSBoaXQgaXQuDQo+IA0KT3VyIFFBIHRlYW0gaGFzIGJlZW4gcnVu
bmluZyBsb2FkL3VubG9hZCB0ZXN0cyBmb3IgcXVpdGUgc29tZSB0aW1lIG5vdywgYW5kDQpzdWNo
IGFuIGlzc3VlIHdhcyBuZXZlciByZXBvcnRlZC4NCkkgYW0gbm90IHN1cmUgd2h5IHlvdSBkbyBu
b3Qgc2VlIHRoZSBidG54cHVhcnRfZmx1c2ggKCkgYmVlbiBjYWxsZWQsIGJ1dCBJIHRlc3RlZCB0
aGlzIHBhdGNoDQpvbiBteSBzZXR1cCwgd2hlcmUgYm90aCwgYnRueHB1YXJ0X2ZsdXNoKCkgYW5k
IGJ0bnhwdWFydF9jbG9zZSgpIGFyZSBjYWxsZWQsIGFuZCBJDQpkb27igJl0IHNlZSBhbnkgaXNz
dWUgZHVlIHRvIGtmcmVlX3NrYiBhbmQgdHhxIHB1cmdlIGJlZW4gZG9uZSB0d2ljZS4NCg0KVGhp
cyBsb29rcyBvayB0byBtZS4NCg0KUmV2aWV3ZWQtYnk6IE5lZXJhaiBTYW5qYXkgS2FsZSA8bmVl
cmFqLnNhbmpheWthbGVAbnhwLmNvbT4NCg==

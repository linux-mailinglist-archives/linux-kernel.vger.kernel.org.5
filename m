Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFB477B6A6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbjHNK1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbjHNK0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:26:30 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B96494;
        Mon, 14 Aug 2023 03:26:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDGHH9Z7NtiIUG4ynTGYz3LSVqC00bAP5RXLbFP5EAPyz+6XUtQkSCLQmHCYTops4xz+V7trtz4VTVZRbV7ejoUdSmVaBXlanQ5rvHxy7RNqbrnNHZPkS10xrFLAogfx50Q+FzOua4iCMSh+ESzT52Q5BTORBTq8HIDqGn0kJBTKX/vskcw8l01OTi8UQgWYot+VflwktmXQY9ybeamUR+reQe7drvwFhPAykMRgkGldFkf1rrCZ4caLS976fuUuFR4BR9yfBJTWsexFRCBSk+nGtft551XJTjtlY11s4dH+ULRbKGNu6Uba8wOSe/DBPkIif9uIaXsZfN4fWd4hCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9L4nEK2X+TmVlBo4VUMhthoxbj0DrGjXq3ZqY7PjwI=;
 b=Q4NVGrjmmSLiSy85vgtDn2lbuYv7kYM+kvlpTEi/sEK04H9sHphq2IULdI6obdYg84ajjJmQ4qSVING7Yl01AD/4U45fyMXVS0pamL9bbNUulC4pd1zG4Xa14Xl0upI1hv1sg7HlOwqKsBgoKLQtpGsOm73J0HFrgxS4oVz+tEY4vnA+3JrfnFTLeh1gs70yVy/0dxky4ftPieaNfV8lhgxylmXaHx9PkD0FseJYzmi6tw1swg5AgV0HjUJ5ltPbtZZFkVfLmKtH4jhxJJHmesuZddX3HR14sLx4KGQpKDxHrrjcjNKLqbGNCtZVQOTlV8Em1/GmJKSbsh5VzkLRbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9L4nEK2X+TmVlBo4VUMhthoxbj0DrGjXq3ZqY7PjwI=;
 b=b5kwpbSfwSopeGm4O3Tp30F+rYsPc5aYfyK6CjAQLe0B12MVobiaF2TRRJjZXcTZl+wmgd6TEV1sULK5OWH8zrn0Z+fI8raJtt8HpymBRRIDiJP8pAIsKjc1oiqqg8HLymwp4/j59doiL6s7NnbF+ZtCJQ45L21lOfRnZiRIQx0=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9820.eurprd04.prod.outlook.com (2603:10a6:10:4c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.22; Mon, 14 Aug
 2023 10:26:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 10:26:26 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH V3 4/8] genpd: imx: scu-pd: do not power off console if
 no_console_suspend
Thread-Topic: [PATCH V3 4/8] genpd: imx: scu-pd: do not power off console if
 no_console_suspend
Thread-Index: AQHZw3pJ6ssQjKFOOU2oUU3GW3+LiK/joHAAgAYKwKA=
Date:   Mon, 14 Aug 2023 10:26:26 +0000
Message-ID: <DU0PR04MB94179E6BAA53A996DA3596F78817A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230731064746.2717684-1-peng.fan@oss.nxp.com>
 <20230731064746.2717684-5-peng.fan@oss.nxp.com>
 <CAPDyKFqC2=4iv-NfdY1A0oB-1eORJaG9F=T+Q6xCdQX7RH6j+g@mail.gmail.com>
In-Reply-To: <CAPDyKFqC2=4iv-NfdY1A0oB-1eORJaG9F=T+Q6xCdQX7RH6j+g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB9PR04MB9820:EE_
x-ms-office365-filtering-correlation-id: 5b0d7faa-a350-46e8-8b55-08db9cb0ea39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: heD0SYZtJNBD5mx9WlE07YuapYlnh9RHplr4z+g9p6hgiAw4Ria5UetjZZ3j23Nn9eSyxfeLYk/S9uOuYBpdVAGLHuV1LFlH/X45HxaNfPm/viUFgkq4ejT5fXxqyKxt4/t+DkhAw/DvYyIO42F2mLkpjqucu3K0wEc2XRNFVeeUx76lVKFWEnLY2/u7z1sVy4J5SeeVyHfPGUvXsuG59whjw/GkR1OGz+vk9oY2EeaFh+H9ys/mwwTTJBjFUd718NYLwmi3JbelnKOdOgqu+yoknr2b53xcVrasaOUUM8N6lGzqQODx+MyyFd3sWH61NKOK+8DGDT0Z3CZKrA/wMdgwgh6q8z1tRmKQprYMCAJ1DxJO9iIUKXf/t9RY0K4hUzOGbBH83nArz8X3FON+HRcYHCpgpJQVnPpHQTbcduVWqMxVc2n4QeXuTd6/uS3uEIHQzKHemwe+UO908lksK5hpRU+dtXX7iAd+8L7KF2+NuMPuNKjX7yATacCGdjj/WHosmaA+9yP0q1fbzf0DExcSQLLbQWYbNyYua8Q94y6kMG5JeSiTnm3SSJoa241kQUfaNicynte05COH91GiBgCFFY2G6RVBPtWmaUGoam10kFW8Lg1zdN7qU2MVbIDl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(376002)(346002)(136003)(186006)(1800799006)(451199021)(66556008)(66446008)(66946007)(54906003)(41300700001)(76116006)(26005)(7696005)(316002)(6506007)(66476007)(64756008)(478600001)(5660300002)(44832011)(8676002)(52536014)(4326008)(8936002)(83380400001)(9686003)(2906002)(71200400001)(110136005)(38070700005)(38100700002)(66899021)(122000001)(33656002)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFo1WVB6Y2J1SlFPZ2poay9rZ1dsVVVQdFNqUHhmTjdZenVtZlhiZWV1dWJn?=
 =?utf-8?B?R0lTSk5mTmFrRlc4SERLVlZIYmVVaXlDRmhla0lnNlFqZnFyVUpEQ2hKSmVi?=
 =?utf-8?B?TmxYeURqQjhwbE1udGFjYnpGRHZpVFdnL2VSbWk5ZmxYZGxYQXEzSm1wTjNE?=
 =?utf-8?B?MFBvRkZxT3QxUnFGWWtUcHdCUXdTTG1PNThrWFhYVUFWRk1MMWt4Kyt0b1dl?=
 =?utf-8?B?ZFJ2dGEzeTNQQUgvUkc5OU9SVmhQaEVMdEVmVGVUUCtaS3d2elpVN0V4STRo?=
 =?utf-8?B?enltUnlkbStHWnpiTENQbnJjOFlHV0d2ejlQcUdTeVp2UnJ2U2gwVUJqK2hV?=
 =?utf-8?B?NEJiN0xNL0F6dWVrT1lBYVZzVWY3VzNHNVNOTVE4QTFLSUdoMk5TL2lTa2xz?=
 =?utf-8?B?dWJKREl6bW91Nm1CRTl1ZlNTdnh4UkFCMkdRbll2OERmdjNSQ2FQNko1SVh5?=
 =?utf-8?B?M2loa0FiNlpMeS9BQVMrR1EzUU1GL1UyMFV3WGhyOG9RaFZYcVJ6TEZSTzFK?=
 =?utf-8?B?cnZZM3lkZGFxTmZjYUZyeDBFZkxxY21KcVBwVU9Qb3UwZXQrbFVKanByUHp6?=
 =?utf-8?B?Z3dhbjR2c2JkdS83eGhWQ0RZbDdOWk81b0ZPNEN6UldTeUo1SG9kOGpxbCty?=
 =?utf-8?B?QmEzR1Q1Yi9lUkEzb3pvc3pGK1dTM0RRTjFqTFlaM3RsME5LVWcvWDF5RWVl?=
 =?utf-8?B?OGJKTDZUOU1iamhmaDFGQnBhNHRBZS9Zb0MwaWEyeElJVDB1aW1WV0ZiaEtw?=
 =?utf-8?B?MmIxMlhtdXlXRnZ5QlFRTVp0SHpEVmh5MERPc0dmUllJcytHckJxS0JiYmQx?=
 =?utf-8?B?Sm1KQmFraU9EVUREWDlDUEEzTUlLeUJhU21BdkdtMkNrZHM1anI3WW15RkY0?=
 =?utf-8?B?RU4wcGliSUxNaXgrUExVcWRLTmF3eXlrSGFlTnRoaXBxL1hYeWlXSU9GYjhs?=
 =?utf-8?B?YmJqT0NZWklYWUErbTZyOFpWUE40bWxOMExieWN1TFhsb29qRWpIWDJWWXRK?=
 =?utf-8?B?M2tVeXFjSGRnaXVLekE4aDJiOGlnWGVpUTUwZGJBU2FhY1lyUUFiakR5bWZT?=
 =?utf-8?B?RlRhQ0xkK3BNeU91L29XZ2R3SVgzbjlwT2c0bUpvdFhGR3JhSU9WOHdVTHMv?=
 =?utf-8?B?ckg2ZUxQRlFmUW8zdUZBclZrWmpsL0krVmRiT0dRZS9WUVc0cHI2V3JzUHRq?=
 =?utf-8?B?VFZuM3I2aGtQaGt5cUo1MWZ3MjFHblJhRGlpbElWTUxxbjNieXFvZ2tEWkRn?=
 =?utf-8?B?YzMrTEtDT1U1VDZWanF6a2JsUERza0tGeklkREFxOTJYMlFpUjQvbnNmWjZV?=
 =?utf-8?B?Y0tHdnZtODJhNGsxMytTcm1HTFIrNzh0QkVDUEk4SEgyeXA3UnF5MzlNaTBn?=
 =?utf-8?B?OVZBWXJHdkZQZUNEc2doYTdhOVNZb0pvaHdKMk1yekUxc0d4bGtDTGdDU2gx?=
 =?utf-8?B?Z2gyaWdESTNoM045bmhKL0IzY21HcElpRFBlVDFEK2gzdXg1U3Z3eTd3ZUo0?=
 =?utf-8?B?SjdISUVLMXBDNDBuV2xOTmZpQi94SjBPUXBqekFFVUFMWldwOUdzNUpIcEpC?=
 =?utf-8?B?VUJya1RmU25maWE2dklCVGpnR2c0Y1RETjdoc0pFeTMyVFplRkZ1elliTlJN?=
 =?utf-8?B?a1I2Y0ZFYWF4enZaYTlySUNDVi8yY0VzN2Y4WFNJcTNGV1JYazM4cFBvZnBp?=
 =?utf-8?B?eTE2ZFllM2RvM0l3Q1NSbHdrdktZMnZJU1I3N01sLzkrSmdjUlRvTnRvZk9B?=
 =?utf-8?B?OC8wS2JZVTBlMjR5V29uSXdZRDVXUCs2YjRVMmxobTNUQThRWGNtMERKekdV?=
 =?utf-8?B?YWVnSzBOeHVHbHllQ1BFS3ZVSXgrYjd5U3NWbnIxL0FkYkdFS1Z6dGhEd21H?=
 =?utf-8?B?VDVjU3pUZC8wVWllSVVUVlU4M1B4SDF4MjN0d2FqamxYU2ZQV3hWT0s0ZjlW?=
 =?utf-8?B?WFlsRlVneDI0WUJWZ0h6TW5QVnN2M1lUbUx2S21GT29RKzRoU2phZjdqZlY0?=
 =?utf-8?B?QlhDRHB4U0FiODRrb3BJaVIvQ1ZVT0FhdVE4YTVXWndXcHdhMkg2TlQ5dEdz?=
 =?utf-8?B?eVdyMUozdjlDdktmNWdSL29VYk5BS2FLckl6TWdST3NQUm05L09FVFFkRmpS?=
 =?utf-8?Q?xoUM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0d7faa-a350-46e8-8b55-08db9cb0ea39
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 10:26:26.0403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KV16LTnnVc30wx+9tN9enusGrG/zv/uWZT8cpXFGWQHkoLooOp9HtMURykCh2XbFekmUwuZJKKJciEjwKbmJHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9820
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDQvOF0gZ2VucGQ6IGlteDogc2N1LXBkOiBkbyBub3Qg
cG93ZXIgb2ZmIGNvbnNvbGUgaWYNCj4gbm9fY29uc29sZV9zdXNwZW5kDQo+IA0KPiBPbiBNb24s
IDMxIEp1bCAyMDIzIGF0IDA4OjQzLCBQZW5nIEZhbiAoT1NTKSA8cGVuZy5mYW5Ab3NzLm54cC5j
b20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+
DQo+ID4NCj4gPiBEbyBub3QgcG93ZXIgb2ZmIGNvbnNvbGUgaWYgbm9fY29uc29sZV9zdXNwZW5k
DQo+IA0KPiBQZXJoYXBzIGV4dGVuZCB0aGlzIGEgYml0IHRvIGxldCB0aGUgcmVhZGVyIHVuZGVy
c3RhbmQgdGhpcyBpcyBhYm91dCBsZWF2aW5nDQo+IHRoZSBzZXJpYWwgZGV2aWNlJ3MgY29ycmVz
cG9uZGluZyBQTSBkb21haW4gb24uDQoNCm9rDQoNCj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gDQo+IEEgY29tbWVudCBiZWxvdyAtIHRo
YXQgZG9lc24ndCBuZWVkIHRvIHN0b3AgdGhpcyBmcm9tIGJlaW5nIGFwcGxpZWQNCj4gdGhvdWdo
Lg0KPiANCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9nZW5wZC9pbXgvc2N1LXBkLmMgfCA1ICsrKysr
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dlbnBkL2lteC9zY3UtcGQuYyBiL2RyaXZlcnMvZ2VucGQvaW14L3NjdS1w
ZC5jDQo+ID4gaW5kZXggMDg1ODNhMTBhYzYyLi5kNjlkYTc5ZDMxMzAgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9nZW5wZC9pbXgvc2N1LXBkLmMNCj4gPiArKysgYi9kcml2ZXJzL2dlbnBkL2lt
eC9zY3UtcGQuYw0KPiA+IEBAIC01Miw2ICs1Miw3IEBADQo+ID4gICAqLw0KPiA+DQo+ID4gICNp
bmNsdWRlIDxkdC1iaW5kaW5ncy9maXJtd2FyZS9pbXgvcnNyYy5oPg0KPiA+ICsjaW5jbHVkZSA8
bGludXgvY29uc29sZS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvZmlybXdhcmUvaW14L3NjaS5o
Pg0KPiA+ICAjaW5jbHVkZSA8bGludXgvZmlybXdhcmUvaW14L3N2Yy9ybS5oPiAgI2luY2x1ZGUg
PGxpbnV4L2lvLmg+IEBADQo+ID4gLTMyNCw2ICszMjUsMTAgQEAgc3RhdGljIGludCBpbXhfc2Nf
cGRfcG93ZXIoc3RydWN0DQo+IGdlbmVyaWNfcG1fZG9tYWluICpkb21haW4sIGJvb2wgcG93ZXJf
b24pDQo+ID4gICAgICAgICBtc2cucmVzb3VyY2UgPSBwZC0+cnNyYzsNCj4gPiAgICAgICAgIG1z
Zy5tb2RlID0gcG93ZXJfb24gPyBJTVhfU0NfUE1fUFdfTU9ERV9PTiA6DQo+ID4gSU1YX1NDX1BN
X1BXX01PREVfTFA7DQo+ID4NCj4gPiArICAgICAgIC8qIGtlZXAgdWFydCBjb25zb2xlIHBvd2Vy
IG9uIGZvciBub19jb25zb2xlX3N1c3BlbmQgKi8NCj4gPiArICAgICAgIGlmIChpbXhfY29uX3Jz
cmMgPT0gcGQtPnJzcmMgJiYgIWNvbnNvbGVfc3VzcGVuZF9lbmFibGVkICYmDQo+ID4gKyAhcG93
ZXJfb24pDQo+IA0KPiBBcyBJIGluZGljYXRlZCBhYm92ZSwgSSBkb24ndCBtaW5kIHRoaXMsIGJ1
dCBJIGFsc28gdGhpbmsgdGhpcyBpcyBhIHJhdGhlciBnZW5lcmljDQo+IHByb2JsZW0gdGhhdCB5
b3UgYXJlIHRyeWluZyB0byBzb2x2ZSBoZXJlLg0KPiANCj4gSW4gcHJpbmNpcGxlLCBJIHRoaW5r
IGl0IHNob3VsZCBiZSB0aGUgc2VyaWFsIGRyaXZlcidzIHJlc3BvbnNpYmlsaXR5IHRvIGNoZWNr
IHRoZQ0KPiBjb25zb2xlX3N1c3BlbmRfZW5hYmxlZCBmbGFnLiBCYXNlZCB1cG9uIHRoYXQsIGl0
IHNob3VsZCBpbmZvcm0gdXBwZXINCj4gbGF5ZXJzIChnZW5wZCkgdGhhdCBpdHMgZGV2aWNlIG1h
eSBuZWVkIHRvIHN0YXkgcG93ZXJlZCBvbiBkdXJpbmcgc3lzdGVtDQo+IHN1c3BlbmQuIFF1aXRl
IHNpbWlsYXIgdG8gaG93IHdlIGRlYWwgd2l0aCBzeXN0ZW0gd2FrZXVwcy4gVG8gbWFrZSB0aGlz
DQo+IHdvcmsgd2UgY291bGQgZG8gdGhlIGZvbGxvd2luZyBpbnN0ZWFkIG9mICRzdWJqZWN0IHBh
dGNoLg0KPiANCj4gMS4gVGhlIHNlcmlhbCBkcml2ZXIgc2hvdWxkIGNhbGwgZGV2aWNlX3NldF93
YWtldXBfcGF0aCgpICh0aGUgbmFtZSBvZiB0aGF0DQo+IGZ1bmN0aW9uIGlzIGEgYml0IGNvbmZ1
c2luZyBpbiB0aGlzIHJlZ2FyZCwgYnV0IGxldCdzIGRpc2N1c3MgdGhhdCBzZXBhcmF0ZWx5KSBp
bg0KPiBpdHMgLT5zdXNwZW5kKCkgY2FsbGJhY2suDQo+IDIuIFNldCB0aGUgR0VOUERfRkxBR19B
Q1RJVkVfV0FLRVVQIChhZ2FpbiB0aGUgbmFtZSBpcyBhIGJpdCBjb25mdXNpbmcNCj4gaW4gdGhp
cyByZWdhcmQpIGZvciB0aGUgY29ycmVzcG9uZGluZyBnZW5wZCBwcm92aWRlci4NCg0KVGhhbmtz
IGZvciB5b3VyIHN1Z2dlc3Rpb24sIEkgd2lsbCB0cnkgaXQuIEZvciB0aGUgY3VycmVudCB2MyA0
LzgsIEkgd2lsbCBrZWVwIGl0IGluDQpWNC4gRm9yIHlvdXIgc3VnZ2VzdGVkIG1ldGhvZCwgSSB3
aWxsIHBvc3QgaW4gYSBzZXBhcmF0ZSBwYXRjaCBhZnRlciBJIGZpbmlzaA0KYW5kIHZlcmlmaWVk
Lg0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiBJbiB0aGlzIHdheSwgZ2VucGQgd2lsbCBrZWVw
IHRoZSBQTSBkb21haW4gcG93ZXJlZCBvbiBkdXJpbmcgc3lzdGVtDQo+IHN1c3BlbmQuDQo+IA0K
PiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVCVVNZOw0KPiA+ICsNCj4gPiAgICAgICAgIHJl
dCA9IGlteF9zY3VfY2FsbF9ycGMocG1faXBjX2hhbmRsZSwgJm1zZywgdHJ1ZSk7DQo+ID4gICAg
ICAgICBpZiAocmV0KQ0KPiA+ICAgICAgICAgICAgICAgICBkZXZfZXJyKCZkb21haW4tPmRldiwg
ImZhaWxlZCB0byBwb3dlciAlcyByZXNvdXJjZSAlZA0KPiA+IHJldCAlZFxuIiwNCj4gPiAtLQ0K
PiA+IDIuMzcuMQ0KPiA+DQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0K

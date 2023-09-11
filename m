Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2150479A464
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbjIKH0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbjIKH0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:26:11 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFF5109
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1694417164;
  x=1725953164;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SRzgu3whToxQprH/a+lTsuIbz30UkQmXZTNxXmYZvVs=;
  b=IF7fYUaSSJjOcY3gehjHznJ/9Y8vXuYV4giJdLpBnjU3E4dlsGoQOm8L
   uh2kmN6YpvtfLC/QoOd/HR9VTv1dTqFU+N3ZkfSnKk8Wxu8URFpOlEffU
   fVkPo+d4nr8TuVPPwCciC/rEMmPFfQ6iB5opvIdsnjC+w3FmwQRpz/lSu
   /RuFVTD7CwEtBPgjNusaW9GlYRtGRGqiRh1rsncHFFLdL3SrvXcuxQkSQ
   rEzerrh8hXcW32RY2nFMFF4e/c3PslrG6wucliTcvwj9e3vbt1+q6gH6G
   wnJNvymm3OlVE16gkRtSfyPYtf3unQfMm/T02XT2KNBmisHkDqzdUQfmO
   A==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnoaSvjRyeKvacG4VRoaGx18DA7PH4rPnICobChmYN3mj1UCGef88l1oePMsZp9VvGFRazqsDHsnEkXFsppWaDrY6SGLNItSYINjT+NsrJrXbT5StjGXn2Z0bCA1u7Rudvxn4YxdwmXDP1M97nxe+OrDpMJiNfy0hCT3m58PxQkTFrAkR+QarbTw1QvR4gDwNeV9T7iplqniyrbXbrQ2KDfMXz8nNzodseMU2iCaY0IW+YkQgmvQfvNdgijbvwnKpcs+EO1kEcI9637t0bARc6BjhYN8S9J/foqEv//0qZeiLm9DhGHAEV+SC5etwZNF0kCsPTxtK8PQWpdmg0XTVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRzgu3whToxQprH/a+lTsuIbz30UkQmXZTNxXmYZvVs=;
 b=YmqzomdOdNcxQWuepWN3wCjQ8Q6iaxuxJaPXPvhMMmW02PPnMTq4f9e7Yyy5GvvLkX3O4SwctDRpzjEJF/my8SEjpKjYXDoMeJQDqDukLzlNN6/UviDqpoZLD+FfMYOgL1g09Sb5oPeJEShhdavMaBSro7EDylrZJKYR1Mhp1l27nMFydAOXESu+umivW2sQ9nArI+KpXmkTgxLl70RyeagfksGVV9zNRRoRmSF0wwIqbwPo6uXmmP8/WG9oElxyCuF+lrTBJABUz91JoEckOQm8Q+tMTgr5keDbegRl8dPhZ6Jz45ySD1AxYSct7hoQstZhD+8Wh4/N8oZZXaKIkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRzgu3whToxQprH/a+lTsuIbz30UkQmXZTNxXmYZvVs=;
 b=fP+UeHy36h/0bYSCEzDWLKAlLhCptRj35ztiPxePUJfRXsB4+T37fEOGrm2KffCyGsttDkpufMNtERw9vSdEqQ9HMj5g+OqVfGmTHgIpDimgtEt2pYdawvJy6PUOEztJRqV0URaKbgGy0z86C4V468RprY+Jpse39oJ//KGQP7o=
From:   Vincent Whitchurch <Vincent.Whitchurch@axis.com>
To:     Vincent Whitchurch <Vincent.Whitchurch@axis.com>,
        "davidgow@google.com" <davidgow@google.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        kernel <kernel@axis.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "richard@nod.at" <richard@nod.at>, "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "glider@google.com" <glider@google.com>,
        "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
Subject: Re: [PATCH] x86: Fix build of UML with KASAN
Thread-Topic: [PATCH] x86: Fix build of UML with KASAN
Thread-Index: AQHZmsQx3HM02RYVik+aPUiiZcEw2q+Dtz2AgJIVpwA=
Date:   Mon, 11 Sep 2023 07:26:00 +0000
Message-ID: <f11475f922994b88f5adb14d23240716e16d5303.camel@axis.com>
References: <20230609-uml-kasan-v1-1-5fac8d409d4f@axis.com>
         <CABVgOS=X1=NC9ad+WV4spFFh4MBHLodhcyQ=Ks=6-FpXrbRTdA@mail.gmail.com>
In-Reply-To: <CABVgOS=X1=NC9ad+WV4spFFh4MBHLodhcyQ=Ks=6-FpXrbRTdA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR02MB10280:EE_|AM9PR02MB7025:EE_
x-ms-office365-filtering-correlation-id: 61b264f8-e9cc-43c1-9cdd-08dbb2985982
x-ld-processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tyQAgTc/SJWWnEdiM6MxNgWcSn26rIicqz1SSz9xYWyimt94Pt3US0vk8+nfCLFupmXeOL1C5E3cp4lPVg4uipeguvZs8WxEb31aiH85K3rHDe/5VppS/8CFnlurEKzYkkgIV1VQP/9hl0ZjYg+xfJfccnC5OkAj2Q4Cw+urxiJ7NDtTdrumRqkTKjOWx5wEGS4HCRrg/BoBIXwWxPfAwCEAkz1GYzjGj9hXGV3PT0oLaeRNY1LPfHpzoEJkxM/q9l/9Wm7UvvXOIwlJRJMoT5Rs3/CwYQkuveCDv2OQ0kFK6aoHruhBerjbOregT6dNde74iAWzdKeaK7CRgqF2W+V0uy6UKRwCdSXAwcmk+Vv2RfIVr2mkY3qcc/LlLNnlZ6bKY0miC+NsXLz6RwnU41yf5Ms3e5Bnsr9Oet2a1x5XPP1uUrq6kaSeXFYU/gEZ4ZlLh3bwBthNy4TGTZ8V/NDbZBWUEv1PEasxU3fTuuoBL+eLDsAuRkjBTZh2uSKIkke07A7phpYRW1sPIqeq9C9b1f9CM7ople/OgiMjy7FpGVFiTcLLfLOUPTPy6O9fctIA3mtL+67glWWBKy/qJzeu3sc7bwhY9qKL5rUsH6VScHzXQgzxjMHNiFkoeihu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR02MB10280.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39850400004)(451199024)(1800799009)(186009)(6512007)(36756003)(2906002)(7416002)(5660300002)(316002)(4326008)(8936002)(54906003)(8676002)(41300700001)(64756008)(66946007)(66446008)(76116006)(66476007)(66556008)(6506007)(478600001)(71200400001)(2616005)(38070700005)(122000001)(86362001)(38100700002)(110136005)(91956017)(26005)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3JqMjZsZkVhZ1F2cGE1OTRzVkk2cXQ1Q2VEV0pwd2p2TGdZU0lFRzBXVnhp?=
 =?utf-8?B?RTZ1SjV5UkdLd2tSbUw0akZ1RWFXNlMwd21La2Z3cktZc3R6SStmZFUxekNh?=
 =?utf-8?B?YnpPbi9PTTF6VGNPN0VmeGg0K0diQTB3T2dpK3VJZEFEZFh5dUNaRzlzamdD?=
 =?utf-8?B?ZVJHc2tWd2RSWUhhOEQrVGlkdTRNTnE5NkpYTmROdThDVElxRUdXNnN1eEt0?=
 =?utf-8?B?UkhLbFV5d2VMclB5bHNaM25xWU0zTDJMajE4WFBMQXNVbEZkV3V4R1g4eFo5?=
 =?utf-8?B?dVBaeGN5WnpGbXd1QzJnVWNvMjJ4Q2MwMFlUTkhpVE9kaG4yeXMyUGdyY2tm?=
 =?utf-8?B?Nmt2dlluT2YrcE9jS2xrMHZ3RFB4dHY2VkVONXBxZFJtTXl0WWZIOGFGNTlW?=
 =?utf-8?B?UC9HdndXeTBINjdHajQyT0RaWFRHbU1JeXFTL01hc1FtVCtGZXRkamVlc1NM?=
 =?utf-8?B?Ukt6N2ZhdVZTdnpFUjVYRjNYa0dScVhkUjVmTGZiZEdTdnBFbDJxUGZnU3R0?=
 =?utf-8?B?OExreENhY2x3M25acWE2WWZxMFZ6U29CZWx2eStLbWFwMHI0SnpUTlBnSWcr?=
 =?utf-8?B?ZmtjY2h6OWViMm1yK1JZNldCdjZneEhnTmdtZEhYaGZZa3FwV09wenkvVGdX?=
 =?utf-8?B?YU85QW96WGlvdUV4UEErcHZvTXN1eWRSeGgwRjFvUGVSdUkyWitLTmFKd1hL?=
 =?utf-8?B?czV6Nm1KU2IvUUlITm5KQWROVDhtclFrcXlvUFBtQkVObEt5eHhSV08rMG96?=
 =?utf-8?B?WjltY0FCOHRGSmVJai8va1NoOFgyelhiV0lrTnVnL1Btb1NlSkUrU3llTHBx?=
 =?utf-8?B?bDNENUpKK25NT1lma2hBL0Q3MGVoOHBEU3FuMnVQL3haU1MzemJ2V3h4STZR?=
 =?utf-8?B?a3B4MFJaOVNwMzExaEJhU1lqc0pOWlhoZTNzUnpOWmdJbEtrNW1rUHZVTW9s?=
 =?utf-8?B?ZEhqSzBCaGZYNjA4K1AxRFFYZUxsL1NGTFQ2c3lsOFNkdHFsQlBxcVZCZTNS?=
 =?utf-8?B?T2hJNDRUbEVJaE84RU1HR2JCdldZWnEzT1FtRUZPM0RrZCtrYXdEMlhhZ3U2?=
 =?utf-8?B?bjZFVGVpMk9jNEpRM0tXa2U5MDdnTVRIYTltbjMzd21aWG9SSXc4QWQ0aG1n?=
 =?utf-8?B?cXVJbUw2bDBSenY2czNReFo5WTBGZVg3ZzA3ZVR2QzNuZjZzYW1qSWZESTRP?=
 =?utf-8?B?R2ZGcHRIem9ObHA1empnYTRDMHdqNHFMRjhRSy91OUxaVU9OK2JTN2ZRZXEy?=
 =?utf-8?B?a1gyUU1WeTk2WERYY01pVzRXeGM5YzhkamY4QnZUOVY0a0lQU3ZROVB6eTlO?=
 =?utf-8?B?aXRpREJlbzJHbXdaWXR2endjY25YLzc0dEQyUDF0YlBlSXlBbHJGM2FOSmg5?=
 =?utf-8?B?UEhOMGlnMW0xQkwzd3dqYTdrVVRRSzM1V0hDdk0wTXJINm4rOWNrTmhPM1Bq?=
 =?utf-8?B?em1QMG1lVitycS9YcHppVk9UQVg4bVZPRk5xZFdIZFMrZ1U2TTZQZzlzamVp?=
 =?utf-8?B?eDNVbGFUMUNjckIrU3d3VUxidVg1VmcvV1U1aGFCNzFXTnVnR2lCRFpEZkdC?=
 =?utf-8?B?dGluUVplOHJRNk1FS1lUSGJManBXVEs5eG50cWRRcE9VeTRORTJ5ZlZaU0pF?=
 =?utf-8?B?Y3hITDBDKzVXdTgyNmJPeWZONFpLQ21xZ3JhNmJUbW1keS9WSFVqZ3lUNW0r?=
 =?utf-8?B?WUpVTXBWUHplR2E4VC8vb0loYjlVYWpqZlFsd1hjek9JVzd6dWNhbHpZVU91?=
 =?utf-8?B?SzFxM2FoUFhvQUt2SW12NlNzcEtqTmNwcklvK1pOSk5aeUJFN29ac3ZyZHdo?=
 =?utf-8?B?dStGaFRZUTZ1c2p4WFRpdGp0T1NSbkZxcjNOUnhVZ0R5NWlhSDlLNCtCalRi?=
 =?utf-8?B?Y3lMZ2JrcVptTml4NG9tVWFTSGdERitDTytCSmM5dWQ3L1RRa2hKWnpzNGdV?=
 =?utf-8?B?RUpPU1RPMzFZUml6MWsxektCcWhITURqOEQyZHJQUjVZbytxQUN6aklBRmNW?=
 =?utf-8?B?TEk2eFpCYzBpYW5lenJlb2lpcXY5TkFpM2ptWlZZQjZGV1RRbkF5V3lRMWJV?=
 =?utf-8?B?bjhhN1lqMTBkTkFRZklOc1hvcSt3Z0FsSmlyV0Nnb01LcVJDUnYxZ2NtNWl0?=
 =?utf-8?Q?IaYY0EkAbJsqQAXQk9ioyi+oa?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BCC8F6AFFCD484EBD9947AC06F8E329@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR02MB10280.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b264f8-e9cc-43c1-9cdd-08dbb2985982
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 07:26:00.9245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nk5dOdAUwE3/0v3eSZfZkE4BOvIGu949nbgvPrlgP3LAcKFNLQ1Re3CyskuBXV1H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB7025
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,TO_EQ_FM_DIRECT_MX autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIzLTA2LTEwIGF0IDE2OjM0ICswODAwLCBEYXZpZCBHb3cgd3JvdGU6DQo+IE9u
IEZyaSwgOSBKdW4gMjAyMyBhdCAxOToxOSwgVmluY2VudCBXaGl0Y2h1cmNoDQo+IDx2aW5jZW50
LndoaXRjaHVyY2hAYXhpcy5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IEJ1aWxkaW5nIFVNTCB3aXRo
IEtBU0FOIGZhaWxzIHNpbmNlIGNvbW1pdCA2OWQ0YzBkMzIxODYgKCJlbnRyeSwga2FzYW4sDQo+
ID4geDg2OiBEaXNhbGxvdyBvdmVycmlkaW5nIG1lbSooKSBmdW5jdGlvbnMiKSB3aXRoIHRoZSBm
b2xsb3dpbmcgZXJyb3JzOg0KPiA+IA0KPiA+IMKgJCB0b29scy90ZXN0aW5nL2t1bml0L2t1bml0
LnB5IHJ1biAtLWtjb25maWdfYWRkIENPTkZJR19LQVNBTj15DQo+ID4gwqAuLi4NCj4gPiDCoGxk
OiBtbS9rYXNhbi9zaGFkb3cubzogaW4gZnVuY3Rpb24gYG1lbXNldCc6DQo+ID4gwqBzaGFkb3cu
YzooLnRleHQrMHg0MCk6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYG1lbXNldCc7DQo+ID4gwqBh
cmNoL3g4Ni9saWIvbWVtc2V0XzY0Lm86KC5ub2luc3RyLnRleHQrMHgwKTogZmlyc3QgZGVmaW5l
ZCBoZXJlDQo+ID4gwqBsZDogbW0va2FzYW4vc2hhZG93Lm86IGluIGZ1bmN0aW9uIGBtZW1tb3Zl
JzoNCj4gPiDCoHNoYWRvdy5jOigudGV4dCsweDkwKTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBg
bWVtbW92ZSc7DQo+ID4gwqBhcmNoL3g4Ni9saWIvbWVtbW92ZV82NC5vOigubm9pbnN0ci50ZXh0
KzB4MCk6IGZpcnN0IGRlZmluZWQgaGVyZQ0KPiA+IMKgbGQ6IG1tL2thc2FuL3NoYWRvdy5vOiBp
biBmdW5jdGlvbiBgbWVtY3B5JzoNCj4gPiDCoHNoYWRvdy5jOigudGV4dCsweDExMCk6IG11bHRp
cGxlIGRlZmluaXRpb24gb2YgYG1lbWNweSc7DQo+ID4gwqBhcmNoL3g4Ni9saWIvbWVtY3B5XzY0
Lm86KC5ub2luc3RyLnRleHQrMHgwKTogZmlyc3QgZGVmaW5lZCBoZXJlDQo+ID4gDQo+ID4gSWYg
SSdtIHJlYWRpbmcgdGhhdCBjb21taXQgcmlnaHQsIHRoZSAhR0VORVJJQ19FTlRSWSBjYXNlIGlz
IHN0aWxsDQo+ID4gc3VwcG9zZWQgdG8gYmUgYWxsb3dlZCB0byBvdmVycmlkZSB0aGUgbWVtKigp
IGZ1bmN0aW9ucywgc28gdXNlIHdlYWsNCj4gPiBhbGlhc2VzIGluIHRoYXQgY2FzZS4NCj4gPiAN
Cj4gPiBGaXhlczogNjlkNGMwZDMyMTg2ICgiZW50cnksIGthc2FuLCB4ODY6IERpc2FsbG93IG92
ZXJyaWRpbmcgbWVtKigpIGZ1bmN0aW9ucyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogVmluY2VudCBX
aGl0Y2h1cmNoIDx2aW5jZW50LndoaXRjaHVyY2hAYXhpcy5jb20+DQo+ID4gLS0tDQo+IA0KPiBU
aGFua3M6IEkgc3R1bWJsZWQgaW50byB0aGlzIHRoZSBvdGhlciBkYXkgYW5kIHJhbiBvdXQgb2Yg
dGltZSB0byBkZWJ1ZyBpdC4NCj4gDQo+IEkndmUgdGVzdGVkIHRoYXQgaXQgd29ya3MgaGVyZS4N
Cj4gDQo+IFRlc3RlZC1ieTogRGF2aWQgR293IDxkYXZpZGdvd0Bnb29nbGUuY29tPg0KDQpUaGFu
a3MuICBQZXJoYXBzIHNvbWVvbmUgY291bGQgcGljayB0aGlzIHVwPyAgSXQncyBiZWVuIGEgZmV3
IG1vbnRocywNCmFuZCB0aGUgYnVpbGQgcHJvYmxlbSBpcyBzdGlsbCBwcmVzZW50IG9uIHY2LjYt
cmMxLg0K

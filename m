Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF767CE318
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjJRQl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjJRQlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:41:52 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27615111
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com; s=toradex-com;
        t=1697647307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ERWz5SP4eqMFwMHo7ODFtxcLp5O+Kdjg7PwAKuSTQg=;
        b=dU3+/480wXspvlK+Qd6LddoXuE6k4yrJJgNnZgT7Lm9qVdPpq4zOHt9sPuZHE70BXbT9yw
        Zwd3Vt1gyJ9a02y2gxmrYychVVyHyJlyyh+Gncz8NnT2ExM3JxpfsjESUThbv8GniihJYq
        S3Stgq1JxRl22oMMu5cQWFeuuoAKT1E=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2040.outbound.protection.outlook.com [104.47.22.40]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-19-0TB9_7i8MFuPhW0qksiVRA-2; Wed, 18 Oct 2023 18:41:43 +0200
X-MC-Unique: 0TB9_7i8MFuPhW0qksiVRA-2
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GVAP278MB0119.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:21::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.21; Wed, 18 Oct 2023 16:41:41 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccb1:8f1e:69ef:d622]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccb1:8f1e:69ef:d622%5]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 16:41:41 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "neeraj.sanjaykale@nxp.com" <neeraj.sanjaykale@nxp.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "sherry.sun@nxp.com" <sherry.sun@nxp.com>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "amitkumar.karwar@nxp.com" <amitkumar.karwar@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v1 2/2] Bluetooth: btnxpuart: Fix nxp_setup
Thread-Topic: [PATCH v1 2/2] Bluetooth: btnxpuart: Fix nxp_setup
Thread-Index: AQHaAdM3VYxdJRU0oUK11G0+P2hl0rBPq/iAgAAUUIA=
Date:   Wed, 18 Oct 2023 16:41:41 +0000
Message-ID: <dca8bc7fec5f527cac2e280cd8ed4edae1f473ea.camel@toradex.com>
References: <20231018145540.34014-1-marcel@ziswiler.com>
         <20231018145540.34014-3-marcel@ziswiler.com>
         <AM9PR04MB860351E818A6DD715A7F88FDE7D5A@AM9PR04MB8603.eurprd04.prod.outlook.com>
In-Reply-To: <AM9PR04MB860351E818A6DD715A7F88FDE7D5A@AM9PR04MB8603.eurprd04.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GVAP278MB0119:EE_
x-ms-office365-filtering-correlation-id: 258a27d4-5d37-4e3f-20a4-08dbcff91b13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: tnb+ReMUhpbBgFtLaIWHw12bklpapt5yZvCvVCzG/AJF/52hvNm5u+4AjuDl0X7Hkf6AcJRqhh9BHbCo+4zdFPBUCnm544Yh9spkdKXZZxDZ69nt/S/0BX4FiRT7TBMbdg8L5/s22C9l+/1qt/XIgfnFymOfpyM0IyEaAU/ivgOq/UyuJwTIvD/mtdRogkg9dMik0TDR66oOUAOdHVv0MZ/Wu4UILtqRGos5VqhNgLJg7One63dyg80Wb/2PIHEJUztFSW1Fw4i4IO7JRyEU2KNLmpulrT61KpF1BleYa5yZl+uu7SWHf8lQctywIJF0vbHShFkB6qfqK39svLx/RrzQhz+wwzpHK49FcfKSFjv9yrP8lgY0mI+hcBct5B/b5llklZ8H/zWRm3p3VFOe2//U7J4j3mAS6t2PzRAxfXNB68wTlK97+bgppw4C9jLvQhac5qCLQJuHwksYnYgxFC3+RLLySTjQDZ1g+cUhp4r8bPAkYO/egD1rfs+X3cetwr+aFdYLznATwI1DChJ4WHoDqoyFbl5sFZ+XiL5Iaui2f2MuVi/85v15nXQJZbHSGC5H//xYtBZUtaNpXrnnn0HkdSrfP82k0B0tw/jrChtMiVHsPtQWEkYRU3HM2+Jw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(366004)(396003)(346002)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(36756003)(66446008)(91956017)(54906003)(64756008)(110136005)(76116006)(66946007)(66476007)(316002)(38100700002)(86362001)(66556008)(38070700005)(122000001)(83380400001)(53546011)(6512007)(26005)(66574015)(2616005)(71200400001)(6506007)(8936002)(4001150100001)(2906002)(6486002)(478600001)(44832011)(5660300002)(8676002)(4326008)(41300700001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjZKT2hYMU9PTGdHTjJzOGJXeHk5S0xMNTR5SWxpcms1SGZaNGdVbDE2eCtV?=
 =?utf-8?B?dyt2N25Fenczb3hoVW1pRmJaR3RGdEVOYk9GblQ5SUxEdHYxaWNndEd2bVkv?=
 =?utf-8?B?SEt2UzNyckcrNmozOEZrVHE4VDJYQlFrTG9FMW5IaDN6UXNyeWhFdEpqdFY4?=
 =?utf-8?B?N1dvbWRkOVFOdnBJdWxTSnUvZkxKR1g5WENrQkFSRGxlVm9ZMTFlYTFnNUNi?=
 =?utf-8?B?SThLbTh1aTJRTFpxVUsraDVtMVh5TDlRVzZ1Smt1SUthQTRnQ0RlYis3TzFO?=
 =?utf-8?B?b1BJMjRaTXRtcGdJVTZjL2o5RDIwVk41OHFlTG5CTHUxUE5zNk04M1ZRRWtK?=
 =?utf-8?B?dmo5dGI0ZVpMRTB4cXd2MTJRZ0w0aEgxQTdvV3NPQVppTGw0S0ZIRnVLM0JG?=
 =?utf-8?B?SFY4WEhnTHJ0eEZTdHZxQWhDTHQxSGJRWTQ4dEVqNzA3VHlBYWZYcDdVMEti?=
 =?utf-8?B?Z21wQnYrRERxRHBOVnBtYkRFYnZQb3JRWWRjSG5la0V1QWZvbTJ1WG9sUUl2?=
 =?utf-8?B?R3NjR1AxSmtid1dXaEZoSmI5ZTZTU2VrTGNJMTg1UzRKaDl0NDh2ZVlmUEM2?=
 =?utf-8?B?bUk1anNRMWhBZTBHcDBTK2xpSURTSk0wSkVNTjF6LzdSYzJWNk1wY2RjeDJG?=
 =?utf-8?B?THdyOGttNUQ3ek9pb2t6ajdSR0N1MXlsc0kwaHNKS1lXdzRTYk1GYTU3Ni91?=
 =?utf-8?B?NStrK0hLeWltUTcrVGxLRHRiOHVUcDQxTDltUnZRKzNObkN3anVkUUhyQ3NY?=
 =?utf-8?B?UVU2RHpjUGk3S2FTUllpUFlNUkZ3Y0dtMVhzNVZoSTBYeDJiRUt3b050Z29m?=
 =?utf-8?B?SEtiKzVtbEwrekNHaXdPaXRtT2JkSS8rYlpqN2hqQlFCK3BkTWdNWm8rVlZD?=
 =?utf-8?B?TzQ0WW1Pb1VtdXVidSs0SUR2V0E5RGM4K09IbGV3V3pIczVMb1Bxd1U4YUlG?=
 =?utf-8?B?clViWTBuY3BnS1QzandpTHgzc3pqY0xPNnFlUzQ4UDVNZHl3UllsVFZjS3hR?=
 =?utf-8?B?VGh4V1ZsTWsrYWo3VWRXTitrK0FPa2ZhdU1nSDVaQTIwUkM3MWhGYWVrSWIr?=
 =?utf-8?B?N3ErRXZmUmtwNlcydE9sRmFnekJIWTZQZXpnVzh2R05qWXVwU0dvVFlHNEYv?=
 =?utf-8?B?OUp5dXkrSlVsNWNkT2NJWXo0dGh6YlFlMHFvYVc0S0ZKYWEvOENrOEZuTnNa?=
 =?utf-8?B?aVh0d3pKZ2psOHhjL2QzVnQzT05HanhpTzZBcDV4aUorZXpUZ0xydnpjYU5J?=
 =?utf-8?B?YXh0Wk1ab2R1bE1Od1JlTFFhQXltK2RzYlU4OW5WZnBGSTdsQk1YRUZZMExn?=
 =?utf-8?B?amlPNy9YQllKQmhkckRkOWhVNkQ3OG9HTjdXRWVFcUZGS2M3S200QkJ1eXBX?=
 =?utf-8?B?UlEvcXp3eThOTzF0UFkyVDVZZWRYOGg1RDFRckhuOVZueVZqTEJXZkJnVlBF?=
 =?utf-8?B?cG1aV2dpNkxOVkxKbFVhL1BCU1pIMWl2K2ZiSzN0VlFDM2NNbm1xdkRIaDlp?=
 =?utf-8?B?VGU3aWRMd05uVXVmK2xaRGw4M0duMkEvZjQ3b0hVSGdpUWk2WFBoQ2pqZ1FW?=
 =?utf-8?B?SnVBdEw3dkIxTkYweEh2SEswWm1oS0xMbkpRSHFLb3o1dzJvOGc2NDcrUWRh?=
 =?utf-8?B?c1pCZ1M1cEp2alJPaFdWSmgzK1hHdDFGNm9JR1JGUWRLdWYzaGdCZExNVyt0?=
 =?utf-8?B?OEZjeExiM01nd2pSa3pFbTRYaUJMSWRPbUpzZWtlalBJWXN5Nk1uU1ZENHV4?=
 =?utf-8?B?UE44UEJiQU1uR0NvNG9Ib1hXWDdGL1U5TDMrYnJocE53NllRZFJCSHJjWWlt?=
 =?utf-8?B?ZGdZdStEaEowbzZmUmJyNGhMN3p6Wjk2ajNSaWdGUlpXSDY0dXZoM2p3TFpt?=
 =?utf-8?B?a1A1UHh0UW9qeGVWdVgvVW8yUVI4OG1UVnhHcmNBa25sS1RKbHRpK09ObzlG?=
 =?utf-8?B?WFQ0TllvenZtSHdvbENwVHFzZEYzemV4a2M3aWNaL2FXMVV0ZzZwZTZQWVJT?=
 =?utf-8?B?dVdsazdEZlpOWHZBdURXamdlWDRBQ3NWYWFUWHhYSTJsUEg0bkFMbUVNcmlS?=
 =?utf-8?B?WHE1ajdoRHJtdHE2WTB2clhtSE96S01PT291SFBRUzJmazl2UnFheTQ5VEZ2?=
 =?utf-8?B?bkhZenFMREpHU3kweWRzMkpvdDdrTzlWcGFyVCs1N2RwcjlvRktrY3JPTkJD?=
 =?utf-8?B?WHc9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 258a27d4-5d37-4e3f-20a4-08dbcff91b13
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 16:41:41.0599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uVOEKgXGrcEjD2xVUa75f3TdSRxcw9b2xaNuOkA8nHVt21oAMS34EBQvhh5q2SLBI4aQX7BohogtdF7vXdwr91abytNnZPtMD1Xmrbds9EE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0119
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <DC22C3790F926C4ABDD12C3C1C4580B4@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmVlcmFqDQoNCk9uIFdlZCwgMjAyMy0xMC0xOCBhdCAxNToyOCArMDAwMCwgTmVlcmFqIHNh
bmpheSBrYWxlIHdyb3RlOg0KPiBIaSBNYXJjZWwsDQo+IA0KPiBUaGFuayB5b3UgZm9yIHlvdXIg
cGF0Y2guIFRoaXMgY2hhbmdlIGxvb2tzIGdvb2QgdG8gbWUuDQo+IA0KPiBJIHRoaW5rIHRoZSBz
Y2VuYXJpbyB5b3UgYXJlIHRlc3RpbmcvcmVzb2x2aW5nIGlzOg0KPiAxKSBMb2FkIGJ0bnhwdWFy
dC5rbyBmaXJzdCAod2hpY2ggIm1heSIgbG9hZCBCVC1vbmx5IEZXIGlmIGNoaXAgaXMgcG93ZXJl
ZCBvbikNCj4gMikgUG93ZXIgY3ljbGUgb3IgcG93ZXIgb24gY2hpcA0KPiAzKSBMb2FkIFdMQU4g
ZHJpdmVyIHdpdGggY29tYm8gRlcNCj4gUmlnaHQ/DQoNClllcywga2luZGEsIGJ1dCB0aGVyZSBh
cmUgcmVhbGx5IGEgc2xldyBvZiBpc3N1ZXMgd2l0aCB0aGlzIGRyaXZlciBvciB0aGUgY29tYmlu
YXRpb24gb2YgaXQgd2l0aCBtd2lmaWV4X3NkaW86DQoNCjEuIFNoYXJlZCBwb3dlci1kb3duIHBp
biAoUEQjKSBiZXR3ZWVuIEJsdWV0b290aCBhbmQgV2ktRmkNCklzc3VlOiBUaGVyZSBpcyBjdXJy
ZW50bHkgbm8gY29uY2VwdCBpbiB0aGUgTGludXgga2VybmVsIHRvIGFjaGlldmUgdGhpcy4gTGFz
dCBmYWlsZWQgYXR0ZW1wdCBbMV0uDQpXb3JrYXJvdW5kOiBJbnN0ZWFkIG9mIHVzaW5nIG1tYy1w
d3JzZXEgdGllZCB0byB0aGUgV2ktRmkgZHJpdmVyIChtd2lmaWV4X3NkaW8pIHRoaXMgY291bGQg
YmUgaG9nZ2VkIGF0IGJvb3QuDQpIb3dldmVyLCB0aGVuIGl0IG1heSBubyBsb25nZXIgZWFzaWx5
IGJlIGNvbnRyb2xsZWQgZS5nLiBmb3IgYSAobWFudWFsKSBwb3dlci1jeWNsZS4NCkEgbm92ZWwg
YXBwcm9hY2ggbWlnaHQgYmUgdXNpbmcgYSByZWd1bGF0b3Igd2hpY2ggY291bGQgYmUgc2hhcmVk
LCBob3dldmVyLCB0aGlzIHdvdWxkIHJlcXVpcmUgdXMgaW1wbGVtZW50aW5nDQpyZWd1bGF0b3Ig
c3VwcG9ydCBpbiBidG54cHVhcnQuIE5vdCBzdXJlIHdoZXRoZXIgeW91IHdvdWxkIGFjdHVhbGx5
IGFwcHJvdmUgdXMgZG9pbmcgc28uDQoNCjIuIEJsdWV0b290aCBkcml2ZXIgKGJ0bnhwdWFydCkg
dnMuIFdpLUZpIGRyaXZlciAobXdpZmlleCkgbG9hZCBvcmRlcg0KSXNzdWU6IEJ5IGRlZmF1bHQs
IHRoZSBCbHVldG9vdGggZHJpdmVyIChidG54cHVhcnQpIGxvYWRzIGJlZm9yZSB0aGUgV2ktRmkg
ZHJpdmVyIChtd2lmaWV4KSBhbmQgdXNpbmcgcmVndWxhcg0KbW1jLXB3cnNlcSBmb3IgbXdpZmll
eF9zZGlvIHdpbGwgb25seSBwb3dlci1vbiB0aGUgbW9kdWxlIGxhdGUuDQpXb3JrYXJvdW5kOiBU
aGUgaW5zdGFsbCBkaXJlY3RpdmUgaW4gbW9kcHJvYmUuY29uZiBjb3VsZCBiZSAoYWItKXVzZWQg
dG8gZW5mb3JjZSBtd2lmaWV4L213aWZpZXhfc2RpbyB0byBiZQ0KbG9hZGVkIGZpcnN0LiBIb3dl
dmVyLCBkb2luZyBzbyBhZGRzIGFuIHVubmVjZXNzYXJ5IGRlcGVuZGVuY3kgd2l0aCB1c2VyIHNw
YWNlIGFuZCBpcyBpbiBnZW5lcmFsIGRpc2NvdXJhZ2VkLg0KDQozLiBEaXN0aW5ndWlzaCBwb3dl
cmVkLW9uIHZzLiBwb3dlcmVkLW9mZiBzdGF0ZQ0KSXNzdWU6IFdpdGhvdXQgdGhhdCBrbm93bGVk
Z2UgdGhlIGRyaXZlciBoYXMgYSBoYXJkIHRpbWUgZmlndXJpbmcgb3V0IHdoZXRoZXIgb3Igbm90
IGl0IG5lZWRzIHRvIGxvYWQgdGhlDQpmaXJtd2FyZSBhcyBvbmx5IGlmIGl0IGlzIHBvd2VyZWQt
b24gKGFuZC9vciB3aXRob3V0IGZpcm13YXJlKSB3aWxsIHRoZSBCbHVldG9vdGggcGFydCBvZiB0
aGUgbW9kdWxlIHNlbmQgaXRzDQpib290IHNpZ25hdHVyZS4gU28gdGhlIGFic2VuY2Ugb2Ygc3Vj
aCBib290IHNpZ25hdHVyZSBtYXkgbWVhbiBlaXRoZXIgZmlybXdhcmUgaXMgYWxyZWFkeSBsb2Fk
ZWQgb3IgbW9kdWxlDQpwb3dlcmVkLW9mZi4NCldvcmthcm91bmQ6IFRoZSBCbHVldG9vdGggVUFS
VCBSVFMgcGluIHNlZW1zIHRvIGFjdGl2YXRlIGFuIGludGVybmFsIHB1bGwtdXAgdXBvbiB0aGUg
bW9kdWxlIGJlaW5nIHBvd2VyZWQgb24uDQpIb3dldmVyLCBwcm9ncmFtbWF0aWNhbGx5IGl0IGlz
IHJhdGhlciBoYXJkIHRvIGRldGVybWluZSB0aGlzIGFzIHRoZSByZWd1bGFyIFVBUlQgZHJpdmVy
IChub3cgZHJpdmluZyBSVFMpDQp1c3VhbGx5IGdldHMgbG9hZGVkLg0KDQo0LiBEZXRlcm1pbmUg
d2hldGhlciBvciBub3QgdG8gbG9hZCB0aGUgZmlybXdhcmUNCklzc3VlOiBJZiBpdCBpcyB3aXRo
b3V0IGZpcm13YXJlIChhbmQgcG93ZXJlZC1vbikgdGhlIGJvb3QgbG9hZGVyIHdpbGwgc2VuZCBp
dHMgYm9vdCBzaWduYXR1cmUuIElmIHRoZXJlIGlzIG5vDQpib290IHNpZ25hdHVyZSBpdCBjb3Vs
ZCBhcyB3ZWxsIGFsc28gc3RpbGwgYmUgcG93ZXJlZC1vZmYuDQpXb3JrYXJvdW5kOiBBbHNvIGNo
ZWNrIENUUyBhcyBpdCBnb2VzIHVwIGlmIHRoZSBmaXJtd2FyZSBpcyBsb2FkZWQuIFVuZm9ydHVu
YXRlbHksIGludGVncmF0aW5nIHRoaXMgaW4NCmJ0bnhwdWFydCBpcyBub3Qgc28gdHJpdmlhbCBh
cyBzZXJkZXYgaW50cm9kdWNlcyBpdHMgb3duIGFzeW5jaHJvbm91cyBjb25jdXJyZW5jeSB3aGlj
aCBpcyBhbHJlYWR5IHVzZWQgaW4NCmV4aXN0aW5nIGNoZWNrcy4NCg0KNS4gRGVwbG95IHNlcGFy
YXRlIGZpcm13YXJlDQpJc3N1ZTogRG9lcyBub3QgcmVhbGx5IHNvbHZlIGFueXRoaW5nIHJlc3Au
IGFzIHRoZSBwb3dlci1kb3duIHBpbiBpcyBzaGFyZWQgdGhpcyBzZWVtcyBraW5kYSBwb2ludGxl
c3MuDQoNCllvdXIgaW5wdXQgb24gYW55IG9mIHRob3NlIHRvcGljcyBpcyBtdWNoIGFwcHJlY2lh
dGVkLg0KDQpUaGFua3MhDQoNCj4gVGhhbmtzLA0KPiBOZWVyYWoNCg0KQ2hlZXJzDQoNCk1hcmNl
bA0KDQo+ID4gRnJvbTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWxAemlzd2lsZXIuY29tPg0KPiA+
IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAxOCwgMjAyMyA4OjI2IFBNDQo+ID4gVG86IGxpbnV4
LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBDYzogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1
bkBueHAuY29tPjsgSm9oYW4gSGVkYmVyZw0KPiA+IDxqb2hhbi5oZWRiZXJnQGdtYWlsLmNvbT47
IEx1aXogQXVndXN0byB2b24gRGVudHoNCj4gPiA8bHVpei5kZW50ekBnbWFpbC5jb20+OyBOZWVy
YWogc2FuamF5IGthbGUgPG5lZXJhai5zYW5qYXlrYWxlQG54cC5jb20+Ow0KPiA+IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IE1hcmNlbCBIb2x0bWFubiA8bWFyY2VsQGhvbHRtYW5uLm9y
Zz47DQo+ID4gTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+OyBB
bWl0a3VtYXIgS2Fyd2FyDQo+ID4gPGFtaXRrdW1hci5rYXJ3YXJAbnhwLmNvbT47IElscG8gSsOk
cnZpbmVuIDxpbHBvLmphcnZpbmVuQGxpbnV4LmludGVsLmNvbT4NCj4gPiBTdWJqZWN0OiBbUEFU
Q0ggdjEgMi8yXSBCbHVldG9vdGg6IGJ0bnhwdWFydDogRml4IG54cF9zZXR1cA0KPiA+IA0KPiA+
IEZyb206IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0KPiA+
IA0KPiA+IFVuZm9ydHVuYXRlbHksIG54cF9zZXR1cCgpIG1heSBpbmFkdmVydGVudGx5IGFzc3Vt
ZSB0aGF0IHRoZSBmaXJtd2FyZSBpcw0KPiA+IGFscmVhZHkgcnVubmluZyB3aGlsZSB0aGUgbW9k
dWxlIGlzIG5vdCBldmVuIHBvd2VyZWQgeWV0Lg0KPiA+IEZpeCB0aGlzIGJ5IHdhaXRpbmcgdXAg
dG8gMTAgc2Vjb25kcyBmb3IgdGhlIENUUyB0byBnbyB1cCBhcyB0aGUgY29tYm8NCj4gPiBmaXJt
d2FyZSBtaWdodCBiZSBsb2FkZWQgYnkgdGhlIFdpLUZpIGRyaXZlciBvdmVyIFNESU8gKG13aWZp
ZXhfc2RpbykuDQo+ID4gDQo+ID4gRml4ZXM6IDY4OWNhMTZlNTIzMiAoIkJsdWV0b290aDogTlhQ
OiBBZGQgcHJvdG9jb2wgc3VwcG9ydCBmb3IgTlhQDQo+ID4gQmx1ZXRvb3RoIGNoaXBzZXRzIikN
Cj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxl
ckB0b3JhZGV4LmNvbT4NCj4gPiANCj4gPiAtLS0NCj4gPiBUaGlzIGlzIHdoYXQgbWF5IGhhcHBl
biB3aXRob3V0IHRoaXMgZml4Og0KPiA+IFvCoCAyODQuNTg4MTc3XSBCbHVldG9vdGg6IGhjaTA6
IE9wY29kZSAweDBjMDMgZmFpbGVkOiAtMTEwIFvCoCAyODYuNjM2MTY3XQ0KPiA+IEJsdWV0b290
aDogaGNpMDogU2V0dGluZyB3YWtlLXVwIG1ldGhvZCBmYWlsZWQgKC0xMTApIFVuZm9ydHVuYXRl
bHksIGV2ZW4NCj4gPiByZS1sb2FkaW5nIHRoZSBidG54cHVhcnQga2VybmVsIG1vZHVsZSB3b3Vs
ZCBub3QgcmVjb3ZlciBmcm9tIHRoaXMNCj4gPiBjb25kaXRpb24uDQo+ID4gDQo+ID4gwqBkcml2
ZXJzL2JsdWV0b290aC9idG54cHVhcnQuYyB8IDEwICsrKysrKysrKysNCj4gPiDCoDEgZmlsZSBj
aGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Ymx1ZXRvb3RoL2J0bnhwdWFydC5jIGIvZHJpdmVycy9ibHVldG9vdGgvYnRueHB1YXJ0LmMNCj4g
PiBpbmRleCA5Y2I3NTI5ZWVmMDkuLjRiODNhMGFhMzQ1OSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL2JsdWV0b290aC9idG54cHVhcnQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0
bnhwdWFydC5jDQo+ID4gQEAgLTEwMjEsNiArMTAyMSwxNiBAQCBzdGF0aWMgaW50IG54cF9zZXR1
cChzdHJ1Y3QgaGNpX2RldiAqaGRldikNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaWYgKGVyciA8IDApDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gZXJyOw0KPiA+IMKgwqDCoMKgwqDCoMKgIH0gZWxzZSB7DQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogVGhlIGNvbWJvIGZpcm13YXJlIG1pZ2h0
IGJlIGxvYWRlZCBieSB0aGUgV2ktRmkgZHJpdmVyIG92ZXINCj4gPiBTRElPIChtd2lmaWV4X3Nk
aW8pLg0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBXZSB3YWl0IHVwIHRv
IDEwcyBmb3IgdGhlIENUUyB0byBnbyB1cC4gQWZ0ZXJ3YXJkcywgd2Uga25vdyB0aGF0DQo+ID4g
dGhlIGZpcm13YXJlIGlzDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIHJl
YWxseSByZWFkeS4NCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovDQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXJyID0gc2VyZGV2X2RldmljZV93YWl0X2Zv
cl9jdHMobnhwZGV2LT5zZXJkZXYsIHRydWUsIDEwMDAwKTsNCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBpZiAoZXJyKSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGJ0X2Rldl9lcnIobnhwZGV2LT5oZGV2LCAiV2FpdCBmb3IgQ1RT
IGZhaWxlZCB3aXRoICVkIiwgZXJyKTsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGVycjsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB9DQo+ID4gKw0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBidF9k
ZXZfZGJnKGhkZXYsICJGVyBhbHJlYWR5IHJ1bm5pbmcuIik7DQo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNsZWFyX2JpdChCVE5YUFVBUlRfRldfRE9XTkxPQURJTkcsICZueHBk
ZXYtPnR4X3N0YXRlKTsNCj4gPiDCoMKgwqDCoMKgwqDCoCB9DQo+ID4gLS0NCj4gPiAyLjM2LjEN
Cg==


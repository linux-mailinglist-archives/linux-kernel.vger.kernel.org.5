Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214527936FE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbjIFIQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjIFIQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:16:43 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on061d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::61d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6443CE47;
        Wed,  6 Sep 2023 01:16:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLkgaGxBSpA3BnJOPpSqUCuKX3e5JHKDOet/5rKTvxlaOApNF7vnuOLXrR4il2yTMxAxJvgqS9HY+b/PsD3Ys9GWzuiH5dfbPnRM6PfP4s7Vu2NJjbCgjVtyG3ysQKUq0FQp6o9OHgq2JqMmKUGH8roOr79mbldoNiqeleZmMGZk8/qnwYXgLjyuMhze9Jzh7OoZ9pbHRzFLLx/zuuhCgcDBOPVrqrWnmEYpxW46Dx0NfgrFIA8QesetXOW7eTmlcS+MvXjaYN2KPTr1sNl/PrQKZ+OnTj2B2CLNj5drLWnXv14DZw2/Ne+2OL5TPmmczQTtftqKxOd2m0/LwW155w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XAIVRzPSPFr8rj0dg5pPV/i/ZUY5nCdxwWGQ/DNlCk=;
 b=Zh/88/TrpmA+Ry9gfLhocasVgbN2B9Ms95PrM+9cT1plE6TowtylzdlU69k3k5ygfya4U1fydYfWbBMI1YB4bI2MFL1HHY3FZMrg3YIhErQCtY0eAfEs/Q/WWR6At1vA13l9fK5uWlhYQL04KX9antFAnf7nJvpqlRHZudSzdqdwhWBOvX/VaFMGdS4/CvZp4FCTqbyYzgcvkI9scTNfFz9PFc0ClaKXL6I9/YOiyRScC1ujS1CAbB/39JpNHotaQBOPiGtbcZpRQfd2vRIqwqlvRdf9PsCEKecnFL06uk3BP9wu7kpJg6rr3Iog/Ts8uo0RZxHUT8vSfkL0stZZWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XAIVRzPSPFr8rj0dg5pPV/i/ZUY5nCdxwWGQ/DNlCk=;
 b=QxehuIFrQX6D2uUfnoEKIumQ3SD+kR4fTyXciwPVLlSKxyApnRK2mHtgdh1RflR9+2VQOd5CeTXQ+sJti/EdqGkeE/xseJ1MfYkJoMuyVRr5uWL+LiQjlZaSzE4GYzc2/Z/IqlvrW+qjYQdfOdbaABhBxuEjNu+J4RtNy7D2EiQ=
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8)
 by AS8PR04MB8771.eurprd04.prod.outlook.com (2603:10a6:20b:42c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 08:16:29 +0000
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d]) by DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d%7]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 08:16:29 +0000
From:   Hui Fang <hui.fang@nxp.com>
To:     Tomasz Figa <tfiga@chromium.org>
CC:     Anle Pan <anle.pan@nxp.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jindong Yue <jindong.yue@nxp.com>,
        Xuegang Liu <xuegang.liu@nxp.com>
Subject: RE: [EXT] Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment
 size
Thread-Topic: [EXT] Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment
 size
Thread-Index: AQHZ2UI/RGKEIcG6sEyAOrT4GOix9LACiU/wgAAMzoCAB7BFoIABXXYAgAHcP6A=
Date:   Wed, 6 Sep 2023 08:16:29 +0000
Message-ID: <DB9PR04MB9284A0CDB1FC7CAADE0A394F87EFA@DB9PR04MB9284.eurprd04.prod.outlook.com>
References: <20230828075420.2009568-1-anle.pan@nxp.com>
 <DB9PR04MB9284AA58AA71655C9C0C7C9A87E6A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5DYxwX+JdXQ_-ba5B9y+gyWPjvUpCBnKM1zz1W2EkO_vA@mail.gmail.com>
 <DB9PR04MB928460023FB3CCCBC3EACE1487E9A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5BGJX7=Z1ukFRq_ktaQ0d7FbvV-ob5gs8hfGaNHUXPTww@mail.gmail.com>
In-Reply-To: <CAAFQd5BGJX7=Z1ukFRq_ktaQ0d7FbvV-ob5gs8hfGaNHUXPTww@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9284:EE_|AS8PR04MB8771:EE_
x-ms-office365-filtering-correlation-id: dbd1342b-6b79-4ef0-c5ac-08dbaeb192a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R2GvxzRZIM2PyBCohE2xFyLhlfPSknN3Be5cii0UBAy8fD5t1y3A9GhzmPCgs+ucNO9QZOmnb7PFenCxiQhpB3cuf1UZZcHFeOUijF0vneTrbb13sIyVFXtWuVdcdWqtmN6a7QLiSjHOP8gXOO9Zh/cJTMakw58aXHoygaC3ArSdXAil4Vj3di+zfXhA1rngtiVIbO7BAOfh7Zwlt/39ioQ/0bJVvcimdCSUj3GOuJLneMCX3HYGrwyICaUatbXN++WlOUmK3JlVXq2uVgmA9ELin5xmiTh4reWzG8k2KDwoNEYVTua2v7OQGqQPpnw1rbqORH9oxEbWC07dZ+9fqYoezdI9/R1mNJNzkEAjF+WNwVoBTfWNSZ8bav44471YuELHlTV3nOd33KlDDX0VlLCdLEyJabec3fKhxZxvDL6CtQ/78YiiWFV434IvuLA3b76X6JlqYKfWG5er7TD6+a2xcAZYZ3nOdOmJ4ZMVOHehETQ76yJ0Os0Oqmw/tO0p930VuLCQP76lpErUR0WFcLwFhDydWGdXJNIPKrGZFIr3H1hIO4yLMJ0hDl206SMrL/g2P0VNJiOHK6OBgxACspsCstdra3yOPAMAOXeLaDEYqS+48uJjVFOOQZHNL82O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(136003)(376002)(1800799009)(451199024)(186009)(122000001)(7696005)(71200400001)(53546011)(6506007)(9686003)(2906002)(478600001)(26005)(76116006)(66446008)(44832011)(64756008)(41300700001)(66476007)(6916009)(66556008)(66946007)(4326008)(52536014)(316002)(54906003)(5660300002)(8676002)(8936002)(33656002)(38070700005)(86362001)(38100700002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGV5dkNhSHMvTHAvRmNyZGI1SDhZSlJSWWJ2MWlmTTBxVTFXNVI4MFNCMXRV?=
 =?utf-8?B?UFZkYmx0NFV6OCtkeHFtY3dEWjE0NmgrbE9lVTVHRHBqYmdvditxUndHZktI?=
 =?utf-8?B?R1RhVnIwcGZmNlpYSjR3YjY1RFEyOXEzOGhyZ1pLL1NLcWdHMjdGeTkxbWZs?=
 =?utf-8?B?VncyV0dSWnJUS2dwSVFOZURQUWJxRisvZ0dETGZYOU5keFFGS1FmOXhkeTFq?=
 =?utf-8?B?YlVKMmdMOFhHU29JaDl4THNSN2EydnJaZUJBWXhXTWxZY001YVltZTRnRFZa?=
 =?utf-8?B?bmgvTmpZdEdJUVgzc0tlbWtNU082WmlIaXNtQ1BMcGhWQVFRSjlNd2JmaHdU?=
 =?utf-8?B?VDNRazlrMXFOQlVEeVJFam1PaWNJVGFEdkd2ZTRONmZYVThmTTBvSERuT2ln?=
 =?utf-8?B?amhPbHpmeVdtNHVrZW45bFRLMFVjS1NUZE12UnpUeFluNTNlMDVYRkdBWnJO?=
 =?utf-8?B?S3NVejBUSTc4QkVDc0lxL0dMTHM0NTUyWmpZMkxvZ1RLb0toS1ZMSGpiS2oz?=
 =?utf-8?B?WmxybEZCNFFkM29CQmV6WXgwK0NjZ0hMMkVYWWwzcDd0S0ViTytFRFNRUmdu?=
 =?utf-8?B?d2NBUFNlcGV4OGM1Uk5PcUk0VjNBZmpHandYOW9NUnUzV0pRNVN1S3dqVHdD?=
 =?utf-8?B?VFZQYXdRQ3dhNm9VSFhEQTQ5M0lIcEVnZ096NnFYVEgzMUs2enUza0lCbHF3?=
 =?utf-8?B?V3ZXUmhjdVRtbU8vOS9ZckRkQ2NMZVlWeEpyMzBoM3I1TnNrWmc1KzBUOUl4?=
 =?utf-8?B?L09vYnRDN3NBeDlzZGJtQ01NT2drS2crbm5IQzRlbkFTTThGRkhLTjhHemMv?=
 =?utf-8?B?bGRGdEsrRm5DeTUvWHI2cVRucXlIUVdacG81Tm1SQlFwYU1BZUM0ZGdFVFVH?=
 =?utf-8?B?YUVtVUtPVk9NcTJwNkN6eTFvRTZhT0VYR0Nmc3dFZlhYMkNTMXN0UzdKS2hK?=
 =?utf-8?B?MDBrZ25QT1BNd2Q5eUlHVjlrYjVsczNsM0xTVGw1MWsraGFDYThWSWcvK1Bq?=
 =?utf-8?B?UTVKRjBpSEU0TklPck4zQlRDeGp2YWZQL1JHWVJ1M3JmTnQ2d0lWeGJYUVhq?=
 =?utf-8?B?SVlBV2hvbjhTdE9HekY0dVFod2NPNFlFZnl1ekpSSkFHaExDRTRaZER6aTZF?=
 =?utf-8?B?aS9wQjB4eFR4TVp5S1pNdzMxcjJMVTRXMWFXNnJvMnFvczVJMVpVVXlJaEQ5?=
 =?utf-8?B?TnVsWnE4eTFiNHZWdjhrQmRNYmc0bVd4ampHby8wbFVhNU1HYkV2a2d5WVV1?=
 =?utf-8?B?ak1wTldOWm55bkc2dFUvcHk5U0U3NDY1QzhDd3ZIbDgyV1ZJeGlnQmtibi9h?=
 =?utf-8?B?WDNZSFo5eWlSeEhBSmhjUnBaN1FtbHhWbzVEMmFpSCtSU0JIWm5hU3hTMXFT?=
 =?utf-8?B?TDV2Tms1U1FkWVhLWDd4ZlVkcFRVc0NvazBtSjBpZ3I3a0p5UHZVZzByaWZW?=
 =?utf-8?B?L29IUHlsdHRQNHp4ZjUwVDlsOXZMaGQ0dW10S2M5L0FoTkU4QitmQTVZMHJN?=
 =?utf-8?B?dUxIc0pCbitOSHVXVEZZNFI0N1hyZXBMOGdpd3l2TEpQMGNucHVyaHZxOFcw?=
 =?utf-8?B?NHM2VTgvbVBhTmtsR3Q0Ky9odllwdC9udTAyMmJRTFNXZGE1Z2dyR0pycC94?=
 =?utf-8?B?Y1ozVXdQWkFZenRJeERHR1ZFTkNkK29rTFpmV3NaS0wwQVBJNzE4d2RJSUJs?=
 =?utf-8?B?a2IzVWZlWFVoWWNqaWtkMmp3MXVNUjBZYXVMb3d6ZVhZRlNEVHlhMGlKS3I1?=
 =?utf-8?B?WS9NWHBzLy9vM09yb2YzbUtGYXAxQm1pMjRxZCttY1VPSFJPNjVGWUt0NEEz?=
 =?utf-8?B?OGp3MUMxemw4NE1GOTFLVzcydUVmNjNoMTBleVBEUWtBM1I2REg0eEpTeXB0?=
 =?utf-8?B?TzZSMGgzSzZ3ZnJ0dTJ5d2lSSXVoZFdPQzFvd215Y2w1TWs2ZlRKeHpCMEZy?=
 =?utf-8?B?WjF1cG1Ta0VYd2VXSnJvaG1sYjVuTkp2bGFhU0xOSEZxVFZaNkZYbnRFV0Nu?=
 =?utf-8?B?UGxBN1VIL1QxRHpnZnRRdHBTdnJOZE5iSGkxZW1FUUdFUm4wSmpPTlZsQXpn?=
 =?utf-8?B?TTZmQzcwT0s5Sk94REZVOUtRZjMvOFkwUEwrd1EwcU54c3A0aTJTRXBnN0NF?=
 =?utf-8?Q?t3C8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd1342b-6b79-4ef0-c5ac-08dbaeb192a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 08:16:29.5838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u00eJtRuUYvHsWRu2VwDk7qNHQzFo1Sjg4PxVlBNbgrn34s0UvfxcvHgv+qF2MMBZxxOJEH5VXGkO9+zxJq82w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8771
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBTZXAgNSwgMjAyMyBhdCAxMjo0NOKAr0FNIFRvbWFzeiBGaWdhIDx0ZmlnYUBjaHJv
bWl1bS5vcmc+IHdyb3RlOg0KPiANCj4gSSBzZWUuIEkgZ3Vlc3MgdGhlIG1hcHBpbmcgaXMgZG9u
ZSBieSB0aGUgVVNCIGdhZGdldCBjb250cm9sbGVyIGRyaXZlcj8gQ291bGQNCj4geW91IHBvaW50
IHVzIHRvIHRoZSBleGFjdCBkcml2ZXIgdGhhdCdzIHVzZWQ/DQo+IA0KPiBKdXN0IHRvIGNsYXJp
ZnksIHN3aW90bGIgc2hvdWxkIG9ubHkgYmUgbmVlZGVkIGluIHRoZSB2ZXJ5IGV4dHJlbWUgZmFs
bGJhY2sgY2FzZSwNCj4gYmVjYXVzZSBvZiB0aGUgcGVyZm9ybWFuY2UgaW1wYWN0IG9mIHRoZSBt
ZW1vcnkgY29weSBiYWNrIGFuZCBmb3J0aC4gVGhlDQo+IHJpZ2h0IGFwcHJvYWNoIHdvdWxkIGRl
cGVuZCBvbiB0aGUgRE1BIGNhcGFiaWxpdGllcyBvZiB5b3VyIGRldmljZSwgdGhvdWdoLg0KDQoN
ClsgIDEzOC40OTM5NDNdWyBUMjEwNF0gQ2FsbCB0cmFjZToNClsgIDEzOC40OTcwOTBdWyBUMjEw
NF0gIHZiMl9kbWFfc2dfYWxsb2MrMHgyZWMvMHgyZmMNClsgIDEzOC41MDE4MDhdWyBUMjEwNF0g
IF9fdmIyX3F1ZXVlX2FsbG9jKzB4MjI0LzB4NzI0DQpbICAxMzguNTA2NjA4XVsgVDIxMDRdICB2
YjJfY29yZV9yZXFidWZzKzB4Mzc0LzB4NTI4DQpbICAxMzguNTExMzIwXVsgVDIxMDRdICB2YjJf
cmVxYnVmcysweGUwLzB4ZjQNClsgIDEzOC41MTU0MjhdWyBUMjEwNF0gIHV2Y2dfYWxsb2NfYnVm
ZmVycysweDE4LzB4MzQNClsgIDEzOC41MjAxNTldWyBUMjEwNF0gIHV2Y192NGwyX3JlcWJ1ZnMr
MHgzOC8weDU0DQpbICAxMzguNTI0NzAzXVsgVDIxMDRdICB2NGxfcmVxYnVmcysweDY4LzB4ODAN
ClsgIDEzOC41Mjg4MjBdWyBUMjEwNF0gIF9fdmlkZW9fZG9faW9jdGwrMHgzNzAvMHg0ZGMNClsg
IDEzOC41MzM1MzVdWyBUMjEwNF0gIHZpZGVvX3VzZXJjb3B5KzB4NDNjLzB4YjM4DQpbICAxMzgu
NTM4MDc2XVsgVDIxMDRdICB2aWRlb19pb2N0bDIrMHgxOC8weDI4DQpbICAxMzguNTQyMjcyXVsg
VDIxMDRdICB2NGwyX2lvY3RsKzB4NmMvMHg4NA0KWyAgMTM4LjU0NjI5MV1bIFQyMTA0XSAgX19h
cm02NF9zeXNfaW9jdGwrMHhhOC8weGU0DQpbICAxMzguNTUwOTI4XVsgVDIxMDRdICBpbnZva2Vf
c3lzY2FsbCsweDU4LzB4MTE0DQpbICAxMzguNTU1Mzg5XVsgVDIxMDRdICBlbDBfc3ZjX2NvbW1v
bisweDg4LzB4ZmMNClsgIDEzOC41NTk3NTVdWyBUMjEwNF0gIGRvX2VsMF9zdmMrMHgyYy8weGI4
DQpbICAxMzguNTYzNzc2XVsgVDIxMDRdICBlbDBfc3ZjKzB4MmMvMHhhNA0KWyAgMTM4LjU2NzU0
NF1bIFQyMTA0XSAgZWwwdF82NF9zeW5jX2hhbmRsZXIrMHg2OC8weGI0DQpbICAxMzguNTcyNDM0
XVsgVDIxMDRdICBlbDB0XzY0X3N5bmMrMHgxYTQvMHgxYTgNClsgIDEzOC41NzY4MDNdWyBUMjEw
NF0gQ29kZTogMTdmZmZmY2IgOTI4MDAyYjMgZDQyMTAwMDAgMTdmZmZmYzggKGQ0MjEwMDAwKSAN
ClsgIDEzOC41ODM1OThdWyBUMjEwNF0gLS0tWyBlbmQgdHJhY2UgMDAwMDAwMDAwMDAwMDAwMCBd
LS0tDQoNCkFsc28sIGJlbG93IHNob3VsZCBleHBsYWluIHdoeSB2YjJfZG1hX3NnX2FsbG9jIGlz
IHVzZWQuDQpXZSB0ZXN0ZWQgb24gOG1wIHdpdGggdXNlIGR3YzMgY29udHJvbGxlci4NCg0KSW4g
ZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYzoNCmR3Yy0+Z2FkZ2V0LT5zZ19zdXBwb3J0ZWQgICAg
ICAgPSB0cnVlOw0KDQpJbiBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdXZjX3F1ZXVlLmMN
CmlmIChjZGV2LT5nYWRnZXQtPnNnX3N1cHBvcnRlZCkgew0KCXF1ZXVlLT5xdWV1ZS5tZW1fb3Bz
ID0gJnZiMl9kbWFfc2dfbWVtb3BzOw0KCXF1ZXVlLT51c2Vfc2cgPSAxOw0KfSBlbHNlIHsNCglx
dWV1ZS0+cXVldWUubWVtX29wcyA9ICZ2YjJfdm1hbGxvY19tZW1vcHM7DQp9DQoNCg0KQlJzLA0K
RmFuZyBIdWkNCg0KDQo=

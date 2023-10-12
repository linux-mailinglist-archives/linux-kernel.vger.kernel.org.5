Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65367C79B2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 00:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442450AbjJLWdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 18:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379690AbjJLWdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 18:33:31 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8449AD9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 15:33:29 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CLu0EJ020170
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 15:33:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=sFGHAorR06kRcobRfKAHo7Gp7UPDzYIKrhKYN5pG4Z8=;
 b=N8rTXjB2AIVDBwrVDPjW6rGWa4p2KyxhzbOqVKuMr9H1BWuWRvhc7WXpzTXALepXmiZF
 Am4knx+tPSRM512XuIeGAWP2IzjUY/5JGbJZh+undQB/coWbeTWFBpC1o2z1SJymeV4A
 zv/a/yvqz5Ngl/i6JbSoRvvzW7e32CoO6uzZAvpsyvsRdrO8kScDhhTns59olOOMqZQ2
 qy/ONDDSNCnmzZ+UKfxIPFt6VCjL8wu1HdR2JZu1FF3GCUI9Gs2ORvlJAPa5q2qkf4rz
 kz0U9QczLve04QfF8c89I4F2bmfvEwql4W3WtjVLuk7bNTDIlDunJ0X74oSfKoLjzmmI 0A== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tp16ck6kg-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 15:33:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ht2nvd0WlVuhXO7234l3uElCrdeallfwbCjraa496uRMDfxnctqnYpxfYdSSrgOuCr8s+Iz5gBL7T80ag6//xVaRo7kUrtMTrOjDZMc89as+pG4p73WYVN+JtHXqafKqGK8tFkIWXzm6HuGMya6uqO5izCRSPQwewSaxuwzJC+rpL1wlLXpkEpg1OJqp9ACLofYz4YOkhsQCRlTG1QheLGknv+JgqccHktheNsw1mglTEbgN9zpFjYatrX93uKrL7u2assU/I4cppHf6jPZTfmRUMCtEAZlucjlqi2H2Y5D8KhRxqwXmVz6CO318S337uA9wouEyAWsWueVRZSNWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFGHAorR06kRcobRfKAHo7Gp7UPDzYIKrhKYN5pG4Z8=;
 b=a/QjlpLGT3HPhMipy0LmcSOqiRom4v9Hj5fNqRV8yhvvRUcgwn44jNHo0Rb1lx7EXrZITJZWdCV3EjJ7HysvKAolq6LKjqQzn4g0bKnV/x4YyRGj4VXtQr2sBOdXd29TIHA8HrVAMwlrCk7goj4UfrA0ZlnCr88l8tsM1buwgbzeooFCJCbtE4qxiuSbmHU5Xm9MZ8d97xJweljUpNzNGZVrQEa39Utn5G3+cbcJWFpiO2bnPfSb2932VxwkyTLGB2OejYWiazltyLh5kV/aZv34sjN9Egl+1hXwvS+X6IrFz28zPAu1tQ8rulWBG6mgqxd7c6P33r6LpIN/sP0ckw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by SA1PR15MB5233.namprd15.prod.outlook.com (2603:10b6:806:228::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 22:33:24 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::60e6:62d8:ca42:402f]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::60e6:62d8:ca42:402f%3]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 22:33:23 +0000
From:   Nick Terrell <terrelln@meta.com>
To:     =?utf-8?B?Sm9uYXRoYW4gTmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
CC:     Nick Terrell <terrelln@meta.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Nick Terrell <terrelln@meta.com>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Xin Li <xin3.li@intel.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Paul Bolle <pebolle@tiscali.nl>,
        Bart Van Assche <bvanassche@acm.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] ARM ZSTD boot compression
Thread-Topic: [PATCH 0/3] ARM ZSTD boot compression
Thread-Index: AQHZbYTYGLeaNVaJ80yectyBOWkrKa8oMb2AgADlIoCAAoo3gIEcPAoA
Date:   Thu, 12 Oct 2023 22:33:23 +0000
Message-ID: <1C6CE84E-557D-4436-BF13-E7275DE390A8@meta.com>
References: <20230412212126.3966502-1-j.neuschaefer@gmx.net>
 <9ae523ae-aad4-40b1-8b6b-d5e18bf8b92a@app.fastmail.com>
 <ecf9f34c-1f1f-47af-a470-0a6ae7773724@app.fastmail.com>
 <ZDoFQUYMZykLdTbX@probook>
In-Reply-To: <ZDoFQUYMZykLdTbX@probook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3667:EE_|SA1PR15MB5233:EE_
x-ms-office365-filtering-correlation-id: c6f1f541-9c69-43c1-7628-08dbcb733e75
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J+oc/DSx+qB/s5+VTgdQ0NWypS8bALyxZmVyVB+oz46sHatCaii9bHA+rHQGJYBqxf5vUCONRsj+Yi+gbunwHU5z8f410I1ma7Zn8tLUZpCPKz87kM8CHrkm6+rY27TTSAqWvw8RU0kMewHjMqWUlhFc88rYsCI53SgJnx4ofDE4RcOMQqskbckTZKYT4sXo5DqL1xaqfJVD2KA1ecuToaLTRuOudXjow023TB4R7998y3vfjRy3brvhZM9+yaKIPwDtmSgXz9fBlFtgQ8Cdxnf549atQHJUAJeHRmF3CAQFI8zTfzB7HhC99DrpKrgBhcL0keRCWamNuUFy9p/ZcUFgiMRTi9NCqW/z4ztrF1sTAYh4YCoW4MDPGKiO5N/d2dyEkVeCAMqypLmGheCZAVVzGt3Jpy6y21Oo4jAvMTybgbDlClpZv/KRkj1evU+XCbiOA7DAp1/DnHvjgdFaqSckbVdjHTBquHm0z2hPydf++OYnaW9OVGa2Au9lMKLorBCX3QNRK8NtWwTaWt7JQ4v5oWpYSYqnvkKf7StF+LVXO3yP1YfzLiIr+yjLV3zDmhqQlresM50SABuWnj/8p5NTULrbeHtVI8fyZhsTSXrDu8wmn3S6ZzPbK0DAmQj2DDlXHu20xmq6mBzXAx15nw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(122000001)(5660300002)(38070700005)(41300700001)(4326008)(8676002)(8936002)(86362001)(33656002)(2906002)(7416002)(6506007)(6512007)(53546011)(71200400001)(64756008)(36756003)(83380400001)(478600001)(2616005)(66574015)(66946007)(66446008)(76116006)(91956017)(38100700002)(54906003)(66476007)(66556008)(316002)(6916009)(6486002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SStEbS9NY1VoU0J5V3V4UmNqaXZIZXB2a0YzbWF6MnI5aGJraDN5Q2F0Qm9p?=
 =?utf-8?B?Yk9rUFo4ZnljZGd5NHA2OTB0Y0VzcnlsYVZvbXc1cWwyYkYyZkFnQTF6TGZI?=
 =?utf-8?B?VFVQT3NRNG9ESXlVbXFBczlPd3FQZzRYYmRzcUhVcGtDMk52VTVid0lWRHZm?=
 =?utf-8?B?eUxZcFd0NkM0N3NqRGlQcUJMaGMvTFJqQ2dtSUZJVTUrL3poTWN4SEIrRGVl?=
 =?utf-8?B?Q01LVXZXL0ZvSEpFcyswdWJPVmg3K1Rxb3BMUFpDVm9pZE1KK3E1THoxaitz?=
 =?utf-8?B?WlY1c1BrTGIvdCs2VlBKUE9WbWZaT0NYWDVEYzUvZ20wR2VKUWZUa1UwWXhr?=
 =?utf-8?B?ekdYQUo2L0t4Q0ZvWTh3RmdsTkd1dy9nUXVaZEJ4UkN1MTFxT0owTzIyYUhY?=
 =?utf-8?B?TXFyYzJDM3JsQkcwQlg4S2JDcGNObXFkcFBPUWxZdEZiKzNnK2QwRER2V1pv?=
 =?utf-8?B?MndxUmdUNGhTbWRjSW5GYXRhbFZzRFRWdDhGQ3JibjRPVlFxOTd1YTQyN0l6?=
 =?utf-8?B?ZHJkN2lNMmZKYkxUTXRvcCtPUnNBeXlMNDdON3VrdzIzb0IrNXloNnZmUm9u?=
 =?utf-8?B?TW9nNXJudTd4OGFQcEgzZ2NJazFBRS9kTFg5NEZiZm91clNCNnQ2NTlITXU0?=
 =?utf-8?B?ZTcrbzBxVW9rUXBkcWk1WStocG4wTDV4UmpFaUx4Y2pTcmRlOFRPMHlXVzZD?=
 =?utf-8?B?dDN5bGpGd2dzd055MWV4V1o3bTF2MEhHbklXbkNoUmMxOE11c1hhelVGMURn?=
 =?utf-8?B?TmJTV0JVTlQ1eXZ2R05tcXdxYXBqdWJCSnVLNXFJVVFFREZidWJ1MW9iTU9i?=
 =?utf-8?B?VkUvdE1xQmtCK3pDVkhHcFhKT3hwMkpUTk1aaVBxcU5JTm5LSWZoenNQNjdq?=
 =?utf-8?B?RFZqbkJFMWUyQlFyN3hPS0FrZjBLMmxyby9VWHNEMm9CbnVKWExYN0RmTlJi?=
 =?utf-8?B?TmtyckZKVHNBQUhUQVlZZTBKVWdoKzVIRmw2UVRHZ0x0ZmVvZG5iRlgvRXhH?=
 =?utf-8?B?bll3ZlQ2OWt3SUpkUDRsM3BGOWNxdlo1eWJZM29IYkZyZWcxbWxoQW9CVFFO?=
 =?utf-8?B?dSthT3NnVjFSbUdiT1VWOXFrV0hjaUxHL08vUk9rMG1ONUxOU2FnSW0zUzNL?=
 =?utf-8?B?cUV5ejRQTy9BZGFnSjVFYjh4SEcwbUp2NDhheEYxazdBSlpRSkxweXRpMU41?=
 =?utf-8?B?M3JrL1FPWGZtRGVMZTZvOFM1V3RmbkhRZXJnZGRFRURaYXoyVjE2VnBuWVg2?=
 =?utf-8?B?MGhIRHJpTHVrcXp6TWpJS2w0UkJ3K0E1aFp1TUdrL3gzTjZyTjNRYmFLZlRL?=
 =?utf-8?B?a09yeGwvdFZWeURDTHpUUHNtd3I1eU1lUEN6ZVE1cVJuUHA3bmd4aUVQZUVp?=
 =?utf-8?B?ZTFpK1dINllTZkI3bDVCVytvb2VJWUk0NmpxaGFnMXR5KzBMWTJ4TTdEQ09P?=
 =?utf-8?B?Q3lDL1NjTk55cy9iY3dwRHFPYmNxRnJxS1VacExpaGg1NW9hQzdrMHJlU3Zo?=
 =?utf-8?B?MnVGN1oxRHM4ZlQ5VFhlb0JGbmdqMUpRRnRiUCtmWjZXTGNOTGp6MHVzN2Ju?=
 =?utf-8?B?a2tnZDV4TUdtV1BaUTFkKzg3T2kzZWplblY0YW0rd0MwQytGVHdBcFF6UHVh?=
 =?utf-8?B?VzNZZ0FZM0JxMHU3L1RuWXlNV3RHY0JPVkMxUVI0V1Y3VGU3Qnc5Y3BIbUhQ?=
 =?utf-8?B?dlJUMlhOQ0dpcEgzZi9hZEU4b0pGYk10U0w4SVNMVEFSRThCTHJEWExEUlAr?=
 =?utf-8?B?SDJXd2dIYUhCRGJER2NBU3JlRHJFT2x3UWxxcW01NmhCUGQ4S00vdmVpU2Fz?=
 =?utf-8?B?bDdwaHQ5TnZ2emVBbjJUOER6K0ZLMG5ZS2daRUR4WUJyNExPU1o5S0RXYzdy?=
 =?utf-8?B?RVVFRk52dlZBMk05NmFvcjNUa3JaNUhncTVkTGh3cVorNHRuWWYvVjZ5TGtU?=
 =?utf-8?B?ZFF2bWpKNTVoUVRWRFNidUx4RmozV0pzcXBQY2pUc0V1OGtkajF4dTFBKzVu?=
 =?utf-8?B?TmtrVVRsellDcUVGM2xGU0tnamRWcDltRlpXMXk1alcrcWpvY0ZnaUdna3lp?=
 =?utf-8?B?eE1sNWllcWRaNkU2TzJ3N0kxeXRXS0U2NnFYdEdXV0tsUmwxUS85dzFKQUlT?=
 =?utf-8?B?SWtTYzhsMDZwYTUrNzVnNXA3eWZxMTBtZGFoSVJwak42aEU1aUg2c29MWlls?=
 =?utf-8?Q?8oPw577Wwpyn80kMio6n4hQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADE3709F272F6B4E822B80D26FB71952@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f1f541-9c69-43c1-7628-08dbcb733e75
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 22:33:23.2030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cSDs8x6TGRg7rqJV+hCCfE7YPJLftx3PAQivvI73ArE9Xf215SOawn5UPAR4jl8L0CRDSkW4P5XK0+RxEb8BLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5233
X-Proofpoint-GUID: dFiw3ZOGBYcRxnR-zU7yjwkkbD5mcrgo
X-Proofpoint-ORIG-GUID: dFiw3ZOGBYcRxnR-zU7yjwkkbD5mcrgo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_14,2023-10-12_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXByIDE0LCAyMDIzLCBhdCAxMDowMCBQTSwgSm9uYXRoYW4gTmV1c2Now6RmZXIg
PGoubmV1c2NoYWVmZXJAZ214Lm5ldD4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIEFwciAxMywgMjAy
MyBhdCAwMToxMzoyMVBNICswMjAwLCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0KPj4gT24gV2VkLCBB
cHIgMTIsIDIwMjMsIGF0IDIzOjMzLCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0KPj4+IE9uIFdlZCwg
QXByIDEyLCAyMDIzLCBhdCAyMzoyMSwgSm9uYXRoYW4gTmV1c2Now6RmZXIgd3JvdGU6DQo+Pj4+
IFRoaXMgcGF0Y2hzZXQgZW5hYmxlcyBaU1REIGtlcm5lbCAoZGUpY29tcHJlc3Npb24gb24gMzIt
Yml0IEFSTS4NCj4+Pj4gVW5mb3J0dW5hdGVseSwgaXQgaXMgbXVjaCBzbG93ZXIgdGhhbiBJIGhv
cGVkICh0ZXN0ZWQgb24gQVJNOTI2RUotUyk6DQo+Pj4+IA0KPj4+PiAtIExaTzogIDcuMiBNaUIs
ICA2IHNlY29uZHMNCj4+Pj4gLSBaU1REOiA1LjYgTWlCLCA2MCBzZWNvbmRzDQo+Pj4gDQo+Pj4g
VGhhdCBzZWVtcyB1bmV4cGVjdGVkLCBhcyB0aGUgdXN1YWwgbnVtYmVycyBzYXkgaXQncyBhYm91
dCAyNSUNCj4+PiBzbG93ZXIgdGhhbiBMWk8uIERvICB5b3UgaGF2ZSBhbiBpZGVhIHdoeSBpdCBp
cyBzbyBtdWNoIHNsb3dlcg0KPj4+IGhlcmU/IEhvdyBsb25nIGRvZXMgaXQgdGFrZSB0byBkZWNv
bXByZXNzIHRoZQ0KPj4+IGdlbmVyYXRlZCBhcmNoL2FybS9ib290L0ltYWdlIGZpbGUgaW4gdXNl
ciBzcGFjZSBvbiB0aGUgc2FtZQ0KPj4+IGhhcmR3YXJlIHVzaW5nIGx6b3AgYW5kIHpzdGQ/DQo+
PiANCj4+IEkgbG9va2VkIHRocm91Z2ggdGhpcyBhIGJpdCBtb3JlIGFuZCBmb3VuZCB0d28gaW50
ZXJlc3RpbmcgcG9pbnRzOg0KPj4gDQo+PiAtIHpzdGQgdXNlcyBhIGxvdCBtb3JlIHVuYWxpZ25l
ZCBsb2FkcyBhbmQgc3RvcmVzIHdoaWxlDQo+PiAgZGVjb21wcmVzc2luZy4gT24gYXJtdjUgdGhv
c2UgdHVybiBpbnRvIGluZGl2aWR1YWwgYnl0ZQ0KPj4gIGFjY2Vzc2VzLCB3aGlsZSB0aGUgb3Ro
ZXJzIGNhbiBsaWtlbHkgdXNlIHdvcmQtYWxpZ25lZA0KPj4gIGFjY2Vzc2VzLiBUaGlzIGNvdWxk
IG1ha2UgYSBodWdlIGRpZmZlcmVuY2UgaWYgY2FjaGVzIGFyZQ0KPj4gIGRpc2FibGVkIGR1cmlu
ZyB0aGUgZGVjb21wcmVzc2lvbi4NCj4+IA0KPj4gLSBUaGUgc2xpZGluZyB3aW5kb3cgb24genN0
ZCBpcyBtdWNoIGxhcmdlciwgd2l0aCB0aGUga2VybmVsDQo+PiAgdXNpbmcgYW4gOE1CIHdpbmRv
dyAoenN0ZD0yMyksIGNvbXBhcmVkIHRvIHRoZSBub3JtYWwgMzJrYg0KPj4gIGZvciBkZWZsYXRl
IChjb3VsZG4ndCBmaW5kIHRoZSBkZWZhdWx0IGZvciBsem8pLCBzbyBvbg0KPj4gIG1hY2hpbmVz
IHdpdGggbm8gTDIgY2FjaGUsIGl0IGlzIG11Y2ggbGlrZWx5IHRvIHRocmFzaCBhDQo+PiAgc21h
bGwgTDEgZGNhY2hlIHRoYXQgYXJlIHVzZWQgb24gbW9zdCBhcm05Lg0KPj4gDQo+PiAgICAgIEFy
bmQNCj4gDQo+IE1ha2Ugc2Vuc2UuDQo+IA0KPiBGb3IgWlNURCBhcyB1c2VkIGluIGtlcm5lbCBk
ZWNvbXByZXNzaW9uICh0aGUgenN0ZDIyIGNvbmZpZ3VyYXRpb24pLCB0aGUNCj4gd2luZG93IGlz
IGV2ZW4gYmlnZ2VyLCAxMjggTWlCLiAoQUZBSVUpDQoNClNvcnJ5LCBJ4oCZbSBhIGJpdCBsYXRl
IHRvIHRoZSBwYXJ0eSwgSSB3YXNu4oCZdCBnZXR0aW5nIExLTUwgZW1haWwgZm9yIHNvbWUgdGlt
ZS4uLg0KDQpCdXQgdGhpcyBpcyB0b3RhbGx5IGNvbmZpZ3VyYWJsZS4gWW91IGNhbiBzd2l0Y2gg
Y29tcHJlc3Npb24gY29uZmlndXJhdGlvbnMNCmF0IGFueSB0aW1lLiBJZiB5b3UgYmVsaWV2ZSB0
aGF0IHRoZSB3aW5kb3cgc2l6ZSBpcyB0aGUgaXNzdWUgY2F1c2luZyBzcGVlZA0KcmVncmVzc2lv
bnMsIHlvdSBjb3VsZCB1c2UgYSB6c3RkIGNvbXByZXNzaW9uIHRvIHVzZSBhIGUuZy4gMjU2S0Ig
d2luZG93DQpzaXplIGxpa2UgdGhpczoNCg0KICB6c3RkIC0xOSAtLXpzdGQ9d2xvZz0xOA0KDQpU
aGlzIHdpbGwga2VlcCB0aGUgc2FtZSBhbGdvcml0aG0gc2VhcmNoIHN0cmVuZ3RoLCBidXQgbGlt
aXQgdGhlIGRlY29kZXIgbWVtb3J5DQp1c2FnZS4NCg0KSSB3aWxsIGFsc28gdHJ5IHRvIGdldCB0
aGlzIHBhdGNoc2V0IHdvcmtpbmcgb24gbXkgbWFjaGluZSwgYW5kIHRyeSB0byBkZWJ1Zy4NClRo
ZSAxMHggc2xvd2VyIHNwZWVkIGRpZmZlcmVuY2UgaXMgbm90IGV4cGVjdGVkLCBhbmQgd2Ugc2Vl
IG11Y2ggYmV0dGVyIHNwZWVkDQppbiB1c2Vyc3BhY2UgQVJNLiBJIHN1c3BlY3QgaXQgaGFzIHNv
bWV0aGluZyB0byBkbyB3aXRoIHRoZSBwcmVib290IGVudmlyb25tZW50Lg0KRS5nLiB3aGVuIGlt
cGxlbWVudGluZyB4ODYtNjQgenN0ZCBrZXJuZWwgZGVjb21wcmVzc2lvbiwgSSBub3RpY2VkIHRo
YXQNCm1lbWNweShkc3QsIHNyYywgMTYpIHdhc27igJl0IGdldHRpbmcgaW5saW5lZCBwcm9wZXJs
eSwgY2F1c2luZyBhIG1hc3NpdmUgcGVyZm9ybWFuY2UNCnBlbmFsdHkuDQoNCkJlc3QsDQpOaWNr
IFRlcnJlbGwNCg0KPiBUaGFua3MNCj4gDQo+IEpvbmF0aGFuDQoNCg0K

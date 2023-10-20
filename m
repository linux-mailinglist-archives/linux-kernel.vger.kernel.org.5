Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E0F7D15FE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 20:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjJTSxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 14:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjJTSxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 14:53:46 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2471A8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 11:53:43 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39KEYHqx014141
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 11:53:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=90MbMDmqKD13+5HoYytD/t7srtkTg9U0fLv/gEGov4c=;
 b=BhF4qeNzs9GBqWPfSx0n+hTGckGEW9/8e4JI04/OlgEEvmG0PjJ+GsbYrNe0EqqozPAV
 xoJwUYlFCPlm7Vdhys91vFiuVmJSJ8G+SC7JOSnRGqR6Suhgi5zO8EHMAl/r2lJ/TWZe
 CgzwPgTpf+hQVXk7qPhHXmrKbq2OF5CBlBSCnZmMCd+ijBGVElfVDY445+xqa/rj/HzJ
 ZyH7zbEXwZ6runxSegVSLzqOjfF1HHV7P2Qg0PgIQ1Kv0wtyqtrC89NJFWNfWtroPEEh
 tJC0tRih5PPfmcU8guLgUMN7wrPaTQyhmj2p9zmm6Q19mzc6GWEzG/+qTXMIGxK1cV2P wg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tubxaejv8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 11:53:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/kS1KeIIuyd4K4mdnnqfrub1DqZD+09WZX3Nmnjhnj2v1H0EKhKEM38JbsU7glE9MqmmVU9Ic0rPMQekqbPabRgFsqj66etnJ0twt4i3o55X7DFYx27ZT8sDL/1vEcQhFx4L634CKfiPYyBI7m+hS/b035vx9WSP5uyyDI1NlJ0HwMmeHjR0IRiqtAIjYqJsupkiqGnKXTvPM6IkRYvzVECKxqeR6jeZJgFg5GripuNrzDFF8dOkfBWAjCW1etrz9vkdjKzTiV6frhDPLYI2qPVwjSRZlxE9W+TpWLKfmLgXkKtJN7lWOvVBCRQxZTk9NYvMMYDVKJgUb9ojzq2+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90MbMDmqKD13+5HoYytD/t7srtkTg9U0fLv/gEGov4c=;
 b=n2eBD89rVo/jbM4XSehkfaBVyLLgQfP9ki7vFTdTLmb8Pzv3CZgRq7KvVc1p2OROkvnpxIg82oddbd/t+EbLylFoQfUtlL8iVTBvFYA2opM7zKgN31M7oU5Qsrx7O1zJFQKHjPXYIGChx4csFXZN1BZdK9HkU5AUeaLZzUb359o16p08x6IhOBfwRy9NlqopOzRdxnLGEv9nk0f1uF9Ctes+3D9rIWuVsDrAUKZ8EA0IZBsyqFKldfPMntwYPKlqyty/eoaLXkVCc16siB/rOnjIRqJn1k3Pj988Ea9CQ3H9vG/dFAzDPjGjPIH/O5cVhVyHPMKFZ75sf49htO+2MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by DM4PR15MB6256.namprd15.prod.outlook.com (2603:10b6:8:189::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8; Fri, 20 Oct
 2023 18:53:40 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::60e6:62d8:ca42:402f]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::60e6:62d8:ca42:402f%3]) with mapi id 15.20.6933.009; Fri, 20 Oct 2023
 18:53:40 +0000
From:   Nick Terrell <terrelln@meta.com>
To:     =?utf-8?B?Si4gTmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
CC:     Nick Terrell <terrelln@meta.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
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
Thread-Index: AQHZbYTYGLeaNVaJ80yectyBOWkrKa8oMb2AgADlIoCAAoo3gIEcPAoAgAAwngCADCSmgA==
Date:   Fri, 20 Oct 2023 18:53:40 +0000
Message-ID: <35D39F92-FED3-479D-86FF-1B504C025831@meta.com>
References: <20230412212126.3966502-1-j.neuschaefer@gmx.net>
 <9ae523ae-aad4-40b1-8b6b-d5e18bf8b92a@app.fastmail.com>
 <ecf9f34c-1f1f-47af-a470-0a6ae7773724@app.fastmail.com>
 <ZDoFQUYMZykLdTbX@probook> <1C6CE84E-557D-4436-BF13-E7275DE390A8@meta.com>
 <ZSic8JsHGIlfuwhp@probook>
In-Reply-To: <ZSic8JsHGIlfuwhp@probook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3667:EE_|DM4PR15MB6256:EE_
x-ms-office365-filtering-correlation-id: c311579a-2ea7-467d-abc4-08dbd19de017
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iTJ2QxFuqRNcsPek8M9rv2AW1NpwERl3GVqF0bBYJyGTM8r7ZBTAJNnH/pSySNZwP4x6hHUZcyau/iLHlW3k3c2P4Yf0rynr6qjn5i6RyPkNZ8ztQyTNzoP57lcdVpsZbJsd3hbVeSxBFizLIPiSfkykhTHH4Be/c8AbHIga6UCQsF/BrPPnjd7EmZLGB6+qiVpc0qVmH/y6fbJPWV2Ef5nqvU3/CDMPX1EH2KIM76FqRWCvpdYJMrKyf0PvbM9lBgKLIpoKqdj3JKEn2rcSJszZku9eJChJpmjP+IFuYJWaIiSiUW9GMssUAJIoqbLEJK8K2vZA0s6bfZMh9PolGtCjTwDIgz1GEraoygx5V6sMA1fJWJ/U+9rj70yLx1VMxRTc5JXtTTe79Xcpjk6pDXnLew6PAmQeI7ET1ONTmsyh4psXH5Dyno4GjjKIaABozMmW07RDMupAs8rHJDbWyEsio+hZbbsZ7CHuL8fgoppM9XzQY7Inr7da69M/r78ZnlnB0XBDMf27lJUXlUVOya8bOX1cClGIiqFaXg4WfBAu+flWlPkIgo8MGTqZI7aKRF/A08Gebpzuq+GOOigWrk2cx5wJmuYuelwXFqVCNU7No1NvyCJDkKzKUljGmoJScqBz82wscyNIKH2PJT8i1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(366004)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(33656002)(38070700009)(6916009)(2906002)(66946007)(6512007)(2616005)(76116006)(53546011)(71200400001)(6506007)(478600001)(66556008)(5660300002)(6486002)(316002)(83380400001)(122000001)(38100700002)(66574015)(66476007)(66446008)(54906003)(7416002)(86362001)(64756008)(4326008)(8676002)(41300700001)(8936002)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFd0REVPWlI4ZlpVSTA2QUFScjJhYm5CeVd5K0lDalJlZGtodzI0UmxWUDdX?=
 =?utf-8?B?Y3YxTno3UkFENjV0cm1yeWlsY0wzdnE0SDJFZTZGWGxTR1Y4MGJSMEpHNjJ4?=
 =?utf-8?B?d1ljZ3N2QVJDd214T2FzUHNQOFlFVzkxanlvUHVqWFR2aTNQZG1VUjlBUlR0?=
 =?utf-8?B?TmxJTjU3VG1Ba0t2N25pQVBWS25MMjFlSEdIK0RkMEI3QndXSm0vYnU1bHlm?=
 =?utf-8?B?SjBxQkk4MDhiNm80V1J4UC9lT1pBQ0J6dFhFbGJWRGd2KzdWdC9XbGs5cEc2?=
 =?utf-8?B?RzlWbERTV2NhN1dLV3NEKzB6YmtxdDFxRmV4NFhjRk1hODhXbHVwL3hyVlRH?=
 =?utf-8?B?dUs4dC9Wc1NHdnBUSjA2WWxHYW1pb2dleEYyczEvdUpWNTBTakZDTkc0VXlm?=
 =?utf-8?B?c3dhaktRRmo4RmZJUmpqZEhuTGZHbU9VUzZ4bnViVCtoZ1RkN09MSDRwMzI0?=
 =?utf-8?B?YjZzeTk0QTR2ek5jTThyTEdVMk83Z2NiNDJtd21OdkEveFdNaTMrWHg3VkVX?=
 =?utf-8?B?STdzRDVTN0RpMndaSVpGYWx5SFZJNVRaK2VCVzB0dENGZDBzQ1AxdVhicUcz?=
 =?utf-8?B?S05nWFdWSzVhZlRaUW90SE9CTk9HeHFCWENHcTV0dG5YWlhnZ1JFdWkwNERH?=
 =?utf-8?B?cnlDNHd5c3hnWVcycWFUN1EvVXl6aURnc2xwZnR6RXJPSFRGVi9OazgzQ3Fv?=
 =?utf-8?B?aGZtNmhPRjNkRU5aUkQ3aFNxUkt3RExNKzBCZi9WNzBncS81Ti8vcGxIKzlm?=
 =?utf-8?B?MU51REpoU0FOSk81K3g3V3F2YStGOFBUOHVUWnZhRkhmSlcvbkErWnhCMVN1?=
 =?utf-8?B?RTZPeS94RFJmamlEZkdxZlZDZ0o5SVY5Umtrckh2c29EckdoZSsrMGNqc09v?=
 =?utf-8?B?NGljR1BEa2VDM3VJMGN0UnBBeENZUXUzd2hCMmVwQ1pkM3JjK1RrWk9KTm12?=
 =?utf-8?B?N3dHeE44SzhkVGlGOHVnNE5ISE1QR2xUam9rWkFBSGdWMVNlN1ZKUlNjVXJ3?=
 =?utf-8?B?a2dDSDI4MTVSS09iaStYdWxhNkZEV0QyRFlpbGQ1QitrcU1SRjQzTG9ZKzJ3?=
 =?utf-8?B?Z1FKSkhobU5hNXNWMERiSFlSWTVEdWtwQ3k0YTJSOUJQOHp4SDNkblJBWThk?=
 =?utf-8?B?SlZVeDNDbHZldVBpMmpoektnS1k5Z2FxWlJydm5JS3JQS2kwR1RMMEpNTGw3?=
 =?utf-8?B?Z2RrbGpNYUxRK1M4TWFDcWN3NUZGYnN4a0RFSnNaQktjZ0hENSsrN1RGMGJw?=
 =?utf-8?B?VGczK1JvZkJQU0l1VGw4WENDdDU2TFM0NTJvWm94L1ZvOUtIejlha2FMRmdY?=
 =?utf-8?B?dEk1M0wvTTVvK2ZBbUcybjRGVmtvRlcwVm1sSG1CQTA5aXdaZVFpUHpPd2R0?=
 =?utf-8?B?VHFlT1ZlTCt2NW90RFZHVFlrZnlqQ05UR3lOdmlQaS82RDJHTGFCZGZwcmUr?=
 =?utf-8?B?TkZxUTFKcDMrRHBsWEVQZmMySUJWM1ZJV2NyL2NLdHNYUWZJZDBZUitFTnZR?=
 =?utf-8?B?d054RzJvK2xrNzgzWXJGRVpmeG82RTdidlhCaysvRkJDelk0ZnRXdDJENGlq?=
 =?utf-8?B?RkN6YkFFaHZGdEdSSzlvRjVNcW9rUG5YMWROY0o2U3RiVUkyR0ozQS8xM2U2?=
 =?utf-8?B?aG5zUHpBOHFFb2dWVjZlN1hPSUJJM08wS3duSXFaNnVNajZzV3hEOGZjK0NH?=
 =?utf-8?B?aWUySTUzUGlXbExzdDQrczIvL1l3cS9acjVheVdzWERxWWlyT1VYNC9BNm1J?=
 =?utf-8?B?Wit5TTJSdUc2cnYyVnR3enFHZTlqOVpaejFNcG9kcmNmdDNwdUkvdUo3VGhi?=
 =?utf-8?B?Ym1SQWNlQTNGMkduS3hPTmJ3VE94UmJWRXdmTFFqQ2p1eEl5cGdXQ2VyUlpr?=
 =?utf-8?B?OXA1ZTVPZkRzM2dDd1ZXY3lxZ0dOcDhlUjQwRXpzUGxuN05LbDJoQi9SWVph?=
 =?utf-8?B?amlhNWxJZEdIZjhHY25IR1k0R1VvR1BELzBNUVFHaTAzKzE3THplV1ZGcWY0?=
 =?utf-8?B?K2Fka25UUFRwNW0rOExINUNHMzBkZWRwUjV3dm1FZHk3a3VrUHpRVHVpQUtE?=
 =?utf-8?B?TGtnSkJvUTFFK2NQbVZBZUtRUmwzbFNIdnhta3NnZy9FV2pRWWF5blVDWmd5?=
 =?utf-8?B?UzFIay9Xb0ZyanRDemt5MGc4UDVTcFh5cGtpc3JBUGttWnV5cU1rMEtZdk41?=
 =?utf-8?Q?gtGx+ByKCfNEH5x5iAzIPvQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C2383C143B0DF4B92195EB2E0A30583@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c311579a-2ea7-467d-abc4-08dbd19de017
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 18:53:40.2551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 26tppwz3KhT/5A+LwfRweKG7VWLoWeet6WlWZUYAfTkWZNZev9d8J6EOMzclLM3OnUShonEvbyo3/ql/xOP7pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB6256
X-Proofpoint-GUID: asiV-hvOemWx62thw1FlTqmmpexQCUor
X-Proofpoint-ORIG-GUID: asiV-hvOemWx62thw1FlTqmmpexQCUor
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gT2N0IDEyLCAyMDIzLCBhdCA2OjI3IFBNLCBKLiBOZXVzY2jDpGZlciA8ai5uZXVz
Y2hhZWZlckBnbXgubmV0PiB3cm90ZToNCj4gDQo+IE9uIFRodSwgT2N0IDEyLCAyMDIzIGF0IDEw
OjMzOjIzUE0gKzAwMDAsIE5pY2sgVGVycmVsbCB3cm90ZToNCj4+PiBPbiBBcHIgMTQsIDIwMjMs
IGF0IDEwOjAwIFBNLCBKb25hdGhhbiBOZXVzY2jDpGZlciA8ai5uZXVzY2hhZWZlckBnbXgubmV0
PiB3cm90ZToNCj4+PiBPbiBUaHUsIEFwciAxMywgMjAyMyBhdCAwMToxMzoyMVBNICswMjAwLCBB
cm5kIEJlcmdtYW5uIHdyb3RlOg0KPj4+PiBPbiBXZWQsIEFwciAxMiwgMjAyMywgYXQgMjM6MzMs
IEFybmQgQmVyZ21hbm4gd3JvdGU6DQo+Pj4+PiBPbiBXZWQsIEFwciAxMiwgMjAyMywgYXQgMjM6
MjEsIEpvbmF0aGFuIE5ldXNjaMOkZmVyIHdyb3RlOg0KPj4+Pj4+IFRoaXMgcGF0Y2hzZXQgZW5h
YmxlcyBaU1REIGtlcm5lbCAoZGUpY29tcHJlc3Npb24gb24gMzItYml0IEFSTS4NCj4+Pj4+PiBV
bmZvcnR1bmF0ZWx5LCBpdCBpcyBtdWNoIHNsb3dlciB0aGFuIEkgaG9wZWQgKHRlc3RlZCBvbiBB
Uk05MjZFSi1TKToNCj4+Pj4+PiANCj4+Pj4+PiAtIExaTzogIDcuMiBNaUIsICA2IHNlY29uZHMN
Cj4+Pj4+PiAtIFpTVEQ6IDUuNiBNaUIsIDYwIHNlY29uZHMNCj4gWy4uLl0NCj4+PiBGb3IgWlNU
RCBhcyB1c2VkIGluIGtlcm5lbCBkZWNvbXByZXNzaW9uICh0aGUgenN0ZDIyIGNvbmZpZ3VyYXRp
b24pLCB0aGUNCj4+PiB3aW5kb3cgaXMgZXZlbiBiaWdnZXIsIDEyOCBNaUIuIChBRkFJVSkNCj4+
IA0KPj4gU29ycnksIEnigJltIGEgYml0IGxhdGUgdG8gdGhlIHBhcnR5LCBJIHdhc27igJl0IGdl
dHRpbmcgTEtNTCBlbWFpbCBmb3Igc29tZSB0aW1lLi4uDQo+PiANCj4+IEJ1dCB0aGlzIGlzIHRv
dGFsbHkgY29uZmlndXJhYmxlLiBZb3UgY2FuIHN3aXRjaCBjb21wcmVzc2lvbiBjb25maWd1cmF0
aW9ucw0KPj4gYXQgYW55IHRpbWUuIElmIHlvdSBiZWxpZXZlIHRoYXQgdGhlIHdpbmRvdyBzaXpl
IGlzIHRoZSBpc3N1ZSBjYXVzaW5nIHNwZWVkDQo+PiByZWdyZXNzaW9ucywgeW91IGNvdWxkIHVz
ZSBhIHpzdGQgY29tcHJlc3Npb24gdG8gdXNlIGEgZS5nLiAyNTZLQiB3aW5kb3cNCj4+IHNpemUg
bGlrZSB0aGlzOg0KPj4gDQo+PiAgenN0ZCAtMTkgLS16c3RkPXdsb2c9MTgNCj4+IA0KPj4gVGhp
cyB3aWxsIGtlZXAgdGhlIHNhbWUgYWxnb3JpdGhtIHNlYXJjaCBzdHJlbmd0aCwgYnV0IGxpbWl0
IHRoZSBkZWNvZGVyIG1lbW9yeQ0KPj4gdXNhZ2UuDQo+IA0KPiBOb3RlZC4NCj4gDQo+PiBJIHdp
bGwgYWxzbyB0cnkgdG8gZ2V0IHRoaXMgcGF0Y2hzZXQgd29ya2luZyBvbiBteSBtYWNoaW5lLCBh
bmQgdHJ5IHRvIGRlYnVnLg0KPj4gVGhlIDEweCBzbG93ZXIgc3BlZWQgZGlmZmVyZW5jZSBpcyBu
b3QgZXhwZWN0ZWQsIGFuZCB3ZSBzZWUgbXVjaCBiZXR0ZXIgc3BlZWQNCj4+IGluIHVzZXJzcGFj
ZSBBUk0uIEkgc3VzcGVjdCBpdCBoYXMgc29tZXRoaW5nIHRvIGRvIHdpdGggdGhlIHByZWJvb3Qg
ZW52aXJvbm1lbnQuDQo+PiBFLmcuIHdoZW4gaW1wbGVtZW50aW5nIHg4Ni02NCB6c3RkIGtlcm5l
bCBkZWNvbXByZXNzaW9uLCBJIG5vdGljZWQgdGhhdA0KPj4gbWVtY3B5KGRzdCwgc3JjLCAxNikg
d2FzbuKAmXQgZ2V0dGluZyBpbmxpbmVkIHByb3Blcmx5LCBjYXVzaW5nIGEgbWFzc2l2ZSBwZXJm
b3JtYW5jZQ0KPj4gcGVuYWx0eS4NCj4gDQo+IEluIHRoZSBtZWFudGltZSBJJ3ZlIHNlZW4gOHMg
Zm9yIFpTVEQgdnMuIDJzIGZvciBvdGhlciBhbGdvcml0aG1zLCBvbg0KPiBvbmx5IG1pbGRseSBs
ZXNzIGFuY2llbnQgaGFyZHdhcmUgKEhpMzUxOEEsIGFub3RoZXIgQVJNOSBTb0MpLCBzbyBJDQo+
IHRoaW5rIHRoZSBtYWluIGN1bHByaXQgaGVyZSB3YXMgcGFydGljdWxhcmx5IGJhZCBsdWNrIGlu
IG15IGNob2ljZSBvZg0KPiB0ZXN0IGhhcmR3YXJlLg0KPiANCj4gVGhlIGlubGluaW5nIGlzc3Vl
cyBhcmUgYSBnb29kIHBvaW50LCBub3RlZCBmb3IgdGhlIG5leHQgdGltZSBJIHdvcmsgb24gdGhp
cy4NCg0KSSB3ZW50IG91dCBhbmQgYm91Z2h0IGEgUmFzcGJlcnJ5IFBpIDQgdG8gdGVzdCBvbi4g
SeKAmXZlIGRvbmUgc29tZSBjcnVkZSBtZWFzdXJlbWVudHMNCmFuZCBzZWUgdGhhdCB6c3RkIGtl
cm5lbCBkZWNvbXByZXNzaW9uIGlzIGp1c3Qgc2xpZ2h0bHkgc2xvd2VyIHRoYW4gZ3ppcCBrZXJu
ZWwNCmRlY29tcHJlc3Npb24sIGFuZCBhYm91dCAyeCBzbG93ZXIgdGhhbiBsem8uIEluIHVzZXJz
cGFjZSBkZWNvbXByZXNzaW9uIG9mIHRoZSBzYW1lDQpmaWxlIChhIG1hbnVhbGx5IGNvbXByZXNz
ZWQga2VybmVsIGltYWdlKSBJIHNlZSB0aGF0IHpzdGQgZGVjb21wcmVzc2lvbiBpcyBzaWduaWZp
Y2FudGx5DQpmYXN0ZXIgdGhhbiBnemlwLiBTbyBpdCBpcyBkZWZpbml0ZWx5IHNvbWV0aGluZyBh
Ym91dCB0aGUgcHJlYm9vdCBib290IGVudmlyb25tZW50LCBvciBob3cNCnRoZSBjb2RlIGlzIGNv
bXBpbGVkIGZvciB0aGUgcHJlYm9vdCBlbnZpcm9ubWVudCB0aGF0IGlzIGNhdXNpbmcgdGhlIGlz
c3VlLg0KDQpNeSBuZXh0IHN0ZXAgaXMgdG8gc2V0IHVwIHFlbXUgb24gbXkgUGkgdG8gdHJ5IHRv
IGdldCBzb21lIHBlcmYgbWVhc3VyZW1lbnRzIG9mIHRoZQ0KZGVjb21wcmVzc2lvbi4gT25lIHRo
aW5nIEnigJl2ZSByZWFsbHkgYmVlbiBzdHJ1Z2dsaW5nIHdpdGgsIGFuZCB3aGF0IHRod2FydGVk
IG15IGxhc3QNCmF0dGVtcHRzIGF0IGFkZGluZyBBUk0genN0ZCBrZXJuZWwgZGVjb21wcmVzc2lv
biwgd2FzIGdldHRpbmcgcHJlYm9vdCBsb2dzIHByaW50ZWQuDQoNCknigJl2ZSBmaWd1cmVkIG91
dCBJIG5lZWQgQ09ORklHX0RFQlVHX0xMPXksIGJ1dCBJ4oCZdmUgeWV0IHRvIGFjdHVhbGx5IGdl
dCBhbnkgbG9ncy4NCkFuZCBJIGNhbuKAmXQgZmlndXJlIG91dCBob3cgdG8gZ2V0IGl0IHdvcmtp
bmcgaW4gcWVtdS4gSSBoYXZlbuKAmXQgdHJpZWQgcWVtdSBvbiBhbiBBUk0NCmhvc3Qgd2l0aCBr
dm0sIGJ1dCB0aGF04oCZcyB0aGUgbmV4dCB0aGluZyBJIHdpbGwgdHJ5Lg0KDQpEbyB5b3UgaGFw
cGVuIHRvIGhhdmUgYW55IGFkdmljZSBhYm91dCBob3cgdG8gZ2V0IHByZWJvb3QgbG9ncyBpbiBx
ZW11PyBJcyBpdA0KcG9zc2libGUgb25seSBvbiBhbiBBUk0gaG9zdCwgb3Igd291bGQgaXQgYWxz
byBiZSBwb3NzaWJsZSBvbiBhbiB4ODYtNjQgaG9zdD8NCg0KVGhhbmtzLA0KTmljayBUZXJyZWxs
DQoNCj4gVGhhbmtzLA0KPiBKb25hdGhhbg0KDQo=

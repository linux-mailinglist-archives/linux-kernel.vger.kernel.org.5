Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFC07D6B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343935AbjJYM3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343906AbjJYM3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:29:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B03CC;
        Wed, 25 Oct 2023 05:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698236942; x=1729772942;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zSYRmk2/kdPDaCPVZgloWHHnl38X0aehNT1VlkKsGvM=;
  b=YteN4iFIsQSVVuXqxJf8uJ0JkW/32mbWckNPkWy2xJxAF3DDeqkucHPd
   Xo+iWk5m5oN5OTJvqmfD3Xzd92b679yhPe/4vllDBLLKkMAwQB2pYWAwa
   XQxaxx62uplskTS+TtjT3hC4umbA4o8obLuLTBU6TW4ciG9pZVtkWVXUv
   wVXL9dcJALFdJfPjGXtl5hXplv6svKsRV+nyN2WFDGQzfPtEqhqGIW/CE
   QHgMrl167YggqYRAtd3YPbQui547kfy5gLDYIyokf4E9L23086Ys2hnWk
   LCgPNUZM4RxeaQ1zZiAzO4D6qwhwHJtOszrQSrZ+YaXquIERARWPKRySv
   g==;
X-CSE-ConnectionGUID: 67V7WCPBRB6zObce0vxo+w==
X-CSE-MsgGUID: M+WnrwaISLS2a56cS+Lj8w==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="10665120"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Oct 2023 05:29:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 25 Oct 2023 05:28:17 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 25 Oct 2023 05:28:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hi9xOVfrjdv4U5XNKwGE+X5nODs9HiWa1BoQHmESvTfXmTqzN5F6M8SzoJ+oZ5iF+NoJsRpZ1u3Se094oQBwUZnOptJksw6UAni9wbzhNFheHTqie6chuBQuav0x2X3jGrSHS+Z3j3/NgQh7ljsefaP2x3b+j75mTXfQ1o/8/kUYbPaWuBoKrE3dM7oxjtUmCmBo5JMJhXUrD1cAp68a0oGGsUwJLwWdjyELv75sMRghP+fDAj+Ob813AVUWNUhXGlGrNLJNJOkvsnu9gZ+0K5zxYRAg4kYoCOKvFZ69UlhVG+PwelLWiMGRGAWMUJ7TqpV7wm3j2QyCOrv5+WdS0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSYRmk2/kdPDaCPVZgloWHHnl38X0aehNT1VlkKsGvM=;
 b=nGX5DPNP+J8s9kda2haIlm64diNyASRsenvMSiI+dMq9LKwDNIKG6otP7Qp098PPlTUyj6fBw2qmpXRTWo48Dn619pTNmi0t8epyOSIyehhsGrbufLwrwLpP5MNTPDzrbltBZgDbQbYRRxfO/l6lU38ttFRUod3dG1yokUzi5FEhe+2E6AKafIbfW0uea+UsF+4e9SPh1MejYKIQK6tRafr729O9PPRE4L7XsaXxoyZCzjxoTHtiPhV81JylJVQRlag+R57ZRe9JRKr/oPtarZnZOKwWKMPvlIYR2qbwjwyFQFlmwOweQz0MAPl5nl1zlWvEDRLtlWOu+LEd38RTZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSYRmk2/kdPDaCPVZgloWHHnl38X0aehNT1VlkKsGvM=;
 b=RwxJaKVBTpvW6pypy6t2f1BpCaPl9RFvNeZOLe0/bEnbATEuMst3jBMOvntnDz6vH18uBDJ4OsKbsbCP+oue9uPR7nvY321p+7CpLzAQsODi9vyEKKlfHCdEc2D+R+Y8QDslcRfLvc8SNfBkNzINTogRNplTK9dmCVg0B8OUqBM=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 SJ0PR11MB4927.namprd11.prod.outlook.com (2603:10b6:a03:2d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 12:28:12 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef%7]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 12:28:12 +0000
From:   <Parthiban.Veerasooran@microchip.com>
To:     <robh@kernel.org>
CC:     <linux-doc@vger.kernel.org>, <horms@kernel.org>,
        <devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <robh+dt@kernel.org>, <UNGLinuxDriver@microchip.com>,
        <netdev@vger.kernel.org>, <rdunlap@infradead.org>,
        <andrew@lunn.ch>, <edumazet@google.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <Steen.Hegelund@microchip.com>,
        <davem@davemloft.net>, <Thorsten.Kummermehr@microchip.com>,
        <Woojung.Huh@microchip.com>, <casper.casan@gmail.com>,
        <conor+dt@kernel.org>
Subject: Re: [PATCH net-next v2 4/9] dt-bindings: net: add OPEN Alliance
 10BASE-T1x MAC-PHY Serial Interface
Thread-Topic: [PATCH net-next v2 4/9] dt-bindings: net: add OPEN Alliance
 10BASE-T1x MAC-PHY Serial Interface
Thread-Index: AQHaBchdwqp9J78AZUCeswF+FBl/obBXpI6AgALNUIA=
Date:   Wed, 25 Oct 2023 12:28:11 +0000
Message-ID: <1e0f9c84-d78e-4ea6-91c2-4c645a3ec05c@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-5-Parthiban.Veerasooran@microchip.com>
 <169808266165.861277.6927507882203709016.robh@kernel.org>
In-Reply-To: <169808266165.861277.6927507882203709016.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|SJ0PR11MB4927:EE_
x-ms-office365-filtering-correlation-id: 9884f4d1-ea6a-4a20-6c12-08dbd555da9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: leOP9rmEvFO0HKvUnrulRRRgNlfjntFYDSaS52Cbvw95vB1HDblC+tisKo9oc739AI5nHyTJQUdxBd1Fa4lbkN3ZxRLO69lePaxUoal1BEJnmBOmAtoQdm1DpjHbdyPVMxKxHDECu+UGzpnvdYbZTlAa/w6O6qxBDWo8FkjtZnxA23YsgST2N5mDvUdDwIySNA4Bqqvzi2BbvxCPpONsXmGqTjDPNlxCXfXQAzDac3XiL+mA+EFRot+jpJZzV/Kk3TcdpsNh+fw65Qjiet73pYOTIeuNKoJ4ESFe9uJ0es/TNiIr9KML+fDGNeZLA8S9BFkDrY82Thc8CFSjYM/M1/7UtgHY//paOV/EDGSprcnNXO050vsu9uONySTIsw71XEi6vdW6FhznvAui5KGg/mDw4thUe5U2IbNihIIjWMsX88AdMIJWEFKL49xPoDsexQX84PsLz1Pk1vQY8NFYg8J2wq/4KHs9yCZB6amWEiHj3FF7CzmK8s3XHgK8MObPxc/IAPkrWCNb/v7kDM4x/XC+gDGUWasQz8SaYWddQ+Lt2ioZpigumx9ifa+90QsBhpooZZ0b6sS6YjODe5oP4lecLzYSVrevY/Q5x6CijbOxNdmJU19muELwnaLGMtr/CNwUvGcqiuIzOLCSyJY3YgSf0i9+FBvodW9hP6ZTcGs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(396003)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(41300700001)(53546011)(6506007)(71200400001)(478600001)(122000001)(2616005)(6512007)(76116006)(66556008)(66476007)(66446008)(66946007)(91956017)(64756008)(36756003)(54906003)(316002)(6916009)(31696002)(6486002)(966005)(86362001)(83380400001)(38100700002)(8676002)(8936002)(38070700009)(4326008)(7416002)(5660300002)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUxoSnFaZzhYMG1FcnZJSTh1K0M4VUd6MFJDRTdtczR4S0kwYWJaMm1HMlN3?=
 =?utf-8?B?dmNRNWVsZ1VWMWxHTXNoR2xkV2JzSEFVdkpHTnY2QzZlWHBKYXBwKzFmWjZK?=
 =?utf-8?B?eVhRcmJSdW5Hc0d6bmtURyt6UXNsV1EwbG1KNk5wTUFodVVjbDhlcVMrZzdY?=
 =?utf-8?B?dkcyQ0FGQ2h1cHdUTDYwMi9nMFBoc2Q1S0lsZVF1dHdwVHZPdjVXVXIyT1hD?=
 =?utf-8?B?d094TldsT0x4bVNXbXN3TGw5M1IxeW1LY2xjRkEzWUdrSjVPZ3RUTE5RYkJM?=
 =?utf-8?B?TEt3NlFsSFZrays1b2NnVzZ6VEE1WmhTekVUeFBoVk1qK3c4bG5WRGxLd1dV?=
 =?utf-8?B?MGZFWVBEV0tDQXQrb05EaktabEFCR2FBRmtDUzcvOEJQa3FJNzVNcUZqbWlW?=
 =?utf-8?B?ZE5QQlEvaDFzSWxYek1RbE9mWEVRS2RNMkJrZHVPNTJFSis4Z3lXaVI5dHNx?=
 =?utf-8?B?SE1IcjVNbjFSNTA2SVliOGdqc0VNd2h4R2Jjc2Zpc1V2N3N2MTRLVXdNUkNt?=
 =?utf-8?B?RWlpMGo3aDgxdjFKK05QeWRNc0N4R1JBQkhRODR3NlZtNFp1elZZOTFUTXBL?=
 =?utf-8?B?M1llS1hweEtITU15S3FmemRRTlg1L1BabWs3NDRsenpRaEQvZGVqc3o0c3Bs?=
 =?utf-8?B?Y0Z5SmRUcEhUVWQreEVESmllYmNhRVFZb0NhVkZDSnJSaGZ5WEM5VUNoSTJk?=
 =?utf-8?B?a2U4YUN3dWpUWG9SOGl5Q1NYenBVcGcvbFp4K1NTenNaZHdrWndPTmhVejNX?=
 =?utf-8?B?cjUxRnErcFdhYUE0b3NHV0dLUTREOWVOYlJMY2Y0K1puekZMNVkzM1JBdCts?=
 =?utf-8?B?ZTlmMHhtSUdtOEd1NzFTYUVkbnQyUEcxWUFsTUZzS1VWbDN5bzluVWdCNVh0?=
 =?utf-8?B?eXhFZlJ5eFpncGV2MHJNR2ZQNmdpNWtsKzYyYnF1ZWFmRjdMNTQvTmYxTjdQ?=
 =?utf-8?B?b25lZVNFWUkwQlM1b1N5Q1Q3aEhEV1JIZlhmSmJWVDZHeHR3clNwOUZNSGlJ?=
 =?utf-8?B?S3RReUNWOHlScCtBRno1NWFkaUtBM0FkMU15ZW8vcjR5U2J0TTdxejlabGRU?=
 =?utf-8?B?L3YxMStKbU1Sb1U2eThiSXVZN3ZqZkIyUUhRQU56d3Z1OEl2OUZWN2QrV3c0?=
 =?utf-8?B?VGY4TFN2K1pxVjRuTkQ3bVdrN1R5anZkNGF1alFiKzM1VnpEQUJMNXdXV1Nz?=
 =?utf-8?B?Q1FBVjl3S2hobllpc3MxZ2JlTDZZZTZ3bjk4dUhjM2dwU2h6bzJ1VFdjRFJY?=
 =?utf-8?B?ZU9HT2RmeEkxVkVUWjZsU1d2VVJiOUVic2JuZTlIeGJlelZxejZnYlpFc2R0?=
 =?utf-8?B?ODVtYnY4Mi84ejU3VDNuYytMcEx1c1JDS1dpMTlnMWtTVGJpQmhlN1NLTWwr?=
 =?utf-8?B?aDdRczNpVVZnR3VHQUFmRUdNMlFoZjAvL1Q3ajZFUU1sREJZSTZobU1QNklM?=
 =?utf-8?B?ZFUwdlVKZWZxWTBvcHlQNjIrVWgyWHNkalVydWdsL1kzemVISkV2dnFtSkx0?=
 =?utf-8?B?d0NWM2VvOFYzbnV1dUh5R1NNVjJmSnUyVzd0bE5xTlNiQVdicUx3VitJeFhk?=
 =?utf-8?B?OFVsbHVIY3RHbEZjRWVTSFo1aEZCODIvdmZNSzIreE90K0RJbG1ON3IwNy9r?=
 =?utf-8?B?Q3B0UW14YUlsRzJhcmNKQkxjOTRwK1dlMnUwU1pxU0hoalpsVGs4ZllrdlMy?=
 =?utf-8?B?MXBUb1lJbWU1OXM3dHhmbloyNU1SR2JFNVRqMjNjdERJVTRnRVp6U1BVSHpn?=
 =?utf-8?B?WGNZR09pTFVlSVF4MksrUWpQaDA0elNmTWo2RkNDeldiRUtqc3Y5WGQvT2g0?=
 =?utf-8?B?eGpNWWVCZERxMHFkaVBlK1dYZzJpc2lNRnF4K2NLRVpDYWtkbmFkSUFEV3ZP?=
 =?utf-8?B?VWcwNWY0TCt6SDNJWGdLdUNRSlI0QlNwUTBLMWpweWhvTVRPUy9sMC9EME1D?=
 =?utf-8?B?djA3a3NSR2FoK3JBeDVQVXgrM21qMFZ3UFB3UmQxZWxZbnQ5MkhaV1MweHpY?=
 =?utf-8?B?TjN6akY5eWU1RENPUzJCMFA4ZGRiWFkwanhPcFB0dkpBd2Z4QlJjU2llakZs?=
 =?utf-8?B?Vlg5TEU5NnVVMXdhM3k5dVFnNjBYWWtTbytKNjUzZWY1VjdnQW1ab1ZaU1Vp?=
 =?utf-8?B?YTl3eWU1M0pvdTFGZHpsNUpubFRYTjBLREVlTSs0L2tQenlDNEpSYUZzTnpu?=
 =?utf-8?B?N25aUFVRWEFBaEp5Y05PK1hQbnZkYlhaNFpOakxQN0JmVyt4NGNnNlNSNm1X?=
 =?utf-8?Q?kBmS1e7li/yfBs70AZRnR41TXgs4W5v1Du49RXhORM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D4E0A3FB9A41146B157E60F3D40F562@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9884f4d1-ea6a-4a20-6c12-08dbd555da9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 12:28:11.8929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Po0lqN7lW47uaQ1FKMCEffNEGQ7aAFkzZ+lxWp0hqdEdLXJ6tDw78TDr4vhuQzzK7uM3490eDlkqc4/f4gzU6593UPgDkYjdLyxJEbLE/ifh0DbBuqoqi34+FOMdZe8c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4927
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjMvMTAvMjMgMTE6MTAgcG0sIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIE1vbiwgMjMgT2N0IDIwMjMgMjE6MTY6NDQg
KzA1MzAsIFBhcnRoaWJhbiBWZWVyYXNvb3JhbiB3cm90ZToNCj4+IEFkZCBEVCBiaW5kaW5ncyBP
UEVOIEFsbGlhbmNlIDEwQkFTRS1UMXggTUFDUEhZIFNlcmlhbCBJbnRlcmZhY2UNCj4+IHBhcmFt
ZXRlcnMuIFRoZXNlIGFyZSBnZW5lcmljIHByb3BlcnRpZXMgdGhhdCBjYW4gYXBwbHkgdG8gYW55
IDEwQkFTRS1UMXgNCj4+IE1BQy1QSFkgd2hpY2ggdXNlcyBPUEVOIEFsbGlhbmNlIFRDNiBzcGVj
aWZpY2F0aW9uLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFBhcnRoaWJhbiBWZWVyYXNvb3JhbiA8
UGFydGhpYmFuLlZlZXJhc29vcmFuQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICAgLi4uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbmV0L29hLXRjNi55YW1sICAgICAgIHwgNzIgKysrKysrKysrKysr
KysrKysrKw0KPj4gICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgMSArDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgNzMgaW5zZXJ0aW9ucygrKQ0KPj4gICBj
cmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9v
YS10YzYueWFtbA0KPj4NCj4gDQo+IE15IGJvdCBmb3VuZCBlcnJvcnMgcnVubmluZyAnbWFrZSBE
VF9DSEVDS0VSX0ZMQUdTPS1tIGR0X2JpbmRpbmdfY2hlY2snDQo+IG9uIHlvdXIgcGF0Y2ggKERU
X0NIRUNLRVJfRkxBR1MgaXMgbmV3IGluIHY1LjEzKToNCj4gDQo+IHlhbWxsaW50IHdhcm5pbmdz
L2Vycm9yczoNCj4gLi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L29hLXRj
Ni55YW1sOjE2OjY4OiBbZXJyb3JdIHN5bnRheCBlcnJvcjogbWFwcGluZyB2YWx1ZXMgYXJlIG5v
dCBhbGxvd2VkIGhlcmUgKHN5bnRheCkNCj4gDQo+IGR0c2NoZW1hL2R0YyB3YXJuaW5ncy9lcnJv
cnM6DQo+IG1ha2VbMl06ICoqKiBEZWxldGluZyBmaWxlICdEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbmV0L29hLXRjNi5leGFtcGxlLmR0cycNCj4gRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL25ldC9vYS10YzYueWFtbDoxNjo2ODogbWFwcGluZyB2YWx1ZXMgYXJl
IG5vdCBhbGxvd2VkIGluIHRoaXMgY29udGV4dA0KPiBtYWtlWzJdOiAqKiogW0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9NYWtlZmlsZToyNjogRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL25ldC9vYS10YzYuZXhhbXBsZS5kdHNdIEVycm9yIDENCj4gbWFrZVsyXTog
KioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4NCj4gLi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbmV0L29hLXRjNi55YW1sOjE2OjY4OiBtYXBwaW5nIHZhbHVlcyBh
cmUgbm90IGFsbG93ZWQgaW4gdGhpcyBjb250ZXh0DQo+IC9idWlsZHMvcm9iaGVycmluZy9kdC1y
ZXZpZXctY2kvbGludXgvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9vYS10
YzYueWFtbDogaWdub3JpbmcsIGVycm9yIHBhcnNpbmcgZmlsZQ0KPiBtYWtlWzFdOiAqKiogWy9i
dWlsZHMvcm9iaGVycmluZy9kdC1yZXZpZXctY2kvbGludXgvTWFrZWZpbGU6MTQyNzogZHRfYmlu
ZGluZ19jaGVja10gRXJyb3IgMg0KPiBtYWtlOiAqKiogW01ha2VmaWxlOjIzNDogX19zdWItbWFr
ZV0gRXJyb3IgMg0KPiANCj4gZG9jIHJlZmVyZW5jZSBlcnJvcnMgKG1ha2UgcmVmY2hlY2tkb2Nz
KToNCj4gDQo+IFNlZSBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvZGV2aWNl
dHJlZS1iaW5kaW5ncy9wYXRjaC8yMDIzMTAyMzE1NDY0OS40NTkzMS01LVBhcnRoaWJhbi5WZWVy
YXNvb3JhbkBtaWNyb2NoaXAuY29tDQo+IA0KPiBUaGUgYmFzZSBmb3IgdGhlIHNlcmllcyBpcyBn
ZW5lcmFsbHkgdGhlIGxhdGVzdCByYzEuIEEgZGlmZmVyZW50IGRlcGVuZGVuY3kNCj4gc2hvdWxk
IGJlIG5vdGVkIGluICp0aGlzKiBwYXRjaC4NCj4gDQo+IElmIHlvdSBhbHJlYWR5IHJhbiAnbWFr
ZSBkdF9iaW5kaW5nX2NoZWNrJyBhbmQgZGlkbid0IHNlZSB0aGUgYWJvdmUNCj4gZXJyb3Iocyks
IHRoZW4gbWFrZSBzdXJlICd5YW1sbGludCcgaXMgaW5zdGFsbGVkIGFuZCBkdC1zY2hlbWEgaXMg
dXAgdG8NCj4gZGF0ZToNCj4gDQo+IHBpcDMgaW5zdGFsbCBkdHNjaGVtYSAtLXVwZ3JhZGUNCj4g
DQo+IFBsZWFzZSBjaGVjayBhbmQgcmUtc3VibWl0IGFmdGVyIHJ1bm5pbmcgdGhlIGFib3ZlIGNv
bW1hbmQgeW91cnNlbGYuIE5vdGUNCj4gdGhhdCBEVF9TQ0hFTUFfRklMRVMgY2FuIGJlIHNldCB0
byB5b3VyIHNjaGVtYSBmaWxlIHRvIHNwZWVkIHVwIGNoZWNraW5nDQo+IHlvdXIgc2NoZW1hLiBI
b3dldmVyLCBpdCBtdXN0IGJlIHVuc2V0IHRvIHRlc3QgYWxsIGV4YW1wbGVzIHdpdGggeW91ciBz
Y2hlbWEuDQo+IA0KU29ycnksIHNvbWVob3cgSSBtaXNzZWQgZG9pbmcgdGhpcyBjaGVjay4gV2ls
bCBmaXggdGhpcyBpbiB0aGUgbmV4dCANCnJldmlzaW9uLg0KDQpCZXN0IFJlZ2FyZHMsDQpQYXJ0
aGliYW4gVg0K

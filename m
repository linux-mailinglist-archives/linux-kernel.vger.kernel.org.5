Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31887A5FD9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjISKlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjISKk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:40:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CD4F1;
        Tue, 19 Sep 2023 03:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695120050; x=1726656050;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IuzJ3dzqBkF/cX6Jv2sY55P1WiNZppmpR/ZeBys/+OA=;
  b=WhkWlP9gkMDdkJC7YC06nj3K2yVBGy8og5X4Fb3nBwaSjrh+vwZOVjpn
   3epi0L8IWP1QjSOO0IVcveQ9oBzF+ct5YAUm0nwX3zduYC0rAytsF0uoL
   6iH1vHH3q4uMHJdBTnW7s705xbApG8CaV3KjNiaEdiVkUhKJzWhbdc1JT
   Myt4Tfa/eGxdqm332+mrKkWMSJLVIqrBy4GKVs8DJS7ZEdJqSuhSP2rUz
   BKr6WCenpUfJLzf1RBXFjNAyijD93gTo6boF4+/PyS/IiUdCjd0SKHkt/
   L0D8xCvySJzWyJwHEBkn9LwH51KHDkf0dTrnxtKl2bThSubjCONBwU9C8
   Q==;
X-CSE-ConnectionGUID: tSiqpPf2RgqyJav8aPHQuA==
X-CSE-MsgGUID: 7iJG/98mSYWasM506l01vA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="235942377"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Sep 2023 03:40:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 19 Sep 2023 03:40:49 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 19 Sep 2023 03:40:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYef9RieXnQqCUeHH6+6asMs+IQkKWElNJdz8sE7X8GkbugEMLX4a60vWuMofkPk7OVxHKCoazYpdtgK9oTQ9Lcjf3Sfpuu6QLYL/xqh/wID5M58f3VUO4SclC5vfVYhHgpbINb8n/VNf3PZ+rS19GjXX7Q2kgVp0nVgZOGeWwB+ftTWfwoTlMx/cALd4cgKpF47JxDTlqeItQ21oBzNP0MgzbF0ALrPvK0ttxunhQUtjgUPuZD5H9FbvfhvTcwI5NbS4ExYduSCgWigNYZImNqDDyDW8GHw/CzacNTmXFpveDqUbyZVivglx79rnXk6qTotzVU9+TPtiinlsfx5fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuzJ3dzqBkF/cX6Jv2sY55P1WiNZppmpR/ZeBys/+OA=;
 b=cP+rmzY0nxluaLvMDop8TWrBXxZs39cMAikIyaopezYsdkbeoLDkMAOpQYDOhEJNpJ6QpYLx/lkxjDRypnhCh9n88n8PuQ3eseNl+hG2+BB3rIT3TGjWhjEFdJzE0f7A24kF9q+Z5Dtj84KEacrSVeAdD91bxrwkXeXA3xU83JZPhfj8rNuc3DLv/4GYXkRm5EVtoU2/AEgqSKjvvB9wd5xqE1ON+hCX3NKG4Yu2O2h7/il7NMSSvX9UZud2JkV2ZqgCj8S6YEbtvPJ46UVLqzaNdt6KxLLsuoX3NwZOejtJW8mtcBn6jmHTlDQyA9qse6T+/HjedAWpuzh028570A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuzJ3dzqBkF/cX6Jv2sY55P1WiNZppmpR/ZeBys/+OA=;
 b=VmHkG916RJt5dQnCK+CTG8KSLUGedqKC+3/XTKqzLaKEje1vpvrNoDNjyb40FDTW4dpepoCEzO159Y6u+jiphDfyhqkjjgq6jBx2XFUeUuwzf3ypUzRTtz7M4hGpz8DTcG7nhpeD1nAiz73Qf+HHGcuOrRPKvk2ZxAtE9qXDcQA=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 PH7PR11MB7100.namprd11.prod.outlook.com (2603:10b6:510:20f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.28; Tue, 19 Sep 2023 10:40:46 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 10:40:46 +0000
From:   <Parthiban.Veerasooran@microchip.com>
To:     <andrew@lunn.ch>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <Steen.Hegelund@microchip.com>,
        <rdunlap@infradead.org>, <horms@kernel.org>,
        <casper.casan@gmail.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
        <Woojung.Huh@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>
Subject: Re: [RFC PATCH net-next 6/6] microchip: lan865x: add device-tree
 support for Microchip's LAN865X MACPHY
Thread-Topic: [RFC PATCH net-next 6/6] microchip: lan865x: add device-tree
 support for Microchip's LAN865X MACPHY
Thread-Index: AQHZ4mE4qGiJRc4rzEqgohxfx8uHBLAZm7UAgAhrBYA=
Date:   Tue, 19 Sep 2023 10:40:45 +0000
Message-ID: <e7a5cc9c-1ee1-053d-1372-9ba2300565d1@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-7-Parthiban.Veerasooran@microchip.com>
 <961a1aa5-a07e-4d0f-b3f7-9e168ad6492f@lunn.ch>
In-Reply-To: <961a1aa5-a07e-4d0f-b3f7-9e168ad6492f@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|PH7PR11MB7100:EE_
x-ms-office365-filtering-correlation-id: 3df38a8b-7d4c-4b1b-4b9f-08dbb8fce144
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BppvjbiEq9YAj7eXm8MDLoH5hedArWjfzxZ2Tj4O8/nAbQ0pPzcX+wFkMWN5m5N7wpJ2zPSJ3gr+Vzq5lt75XHUdTk/2whlHlaKktf72ik8ro+jlcl7SyeVYfs/JloAjMwRl2hy5j7zvHYgFrMfvkTh8+du9t0CcCZh4bXLF9gkjBu4rPCv7pbWamF/oHN9pkG6KNy/VVNoUHkJP2UlJX5mKwgxyhABZZ+To+NW2JhUc2HFvTP4XJCNnyw1gNTFnuIzmIFzI+UKGY4j21QzxJ92ssWDcZ6LjSWMzMK20qoJBakIUw3LZ6P/TTcbt7cByfkd4siaS3J/3QYXgVeo6ulph5db9cah6sI12o/qH39BI3ASobTtEzg6TdcxNrT1v2Pf893WzAwDA0uM58HPdlQl+KoIrB98NRs5QQuNv7IQpyC57fn8Tgql12stFfDgkaYx+KvAqegp9fycZwHnUTv/zw3BUHPip9i3clxWA2U9Xk4fuZ+6d9v/QGpH50gOBEMMXZ0O3iHzW56u1IKrBRfcC712+jHIL9JPMIE4cRmyTLiuixtoZ1SaWHNtGSreOEKeaFiBCsDNWTPF2EopaCoYP0cgF/2W33Ck2tsfAssRk9IxD6xVQIMNEL9IAAFJbOJEuCBUGvQW8NkSm48vbVXuv5ZJ/lQemujNdJzEoRhHWY1lZvmJhBNzq03AXspav
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199024)(1800799009)(186009)(31686004)(36756003)(5660300002)(86362001)(31696002)(4744005)(4326008)(8936002)(8676002)(41300700001)(7416002)(6506007)(6486002)(71200400001)(53546011)(107886003)(26005)(2616005)(6512007)(122000001)(66946007)(478600001)(2906002)(76116006)(38100700002)(38070700005)(6916009)(316002)(66476007)(91956017)(66556008)(66446008)(54906003)(64756008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTgxUkN4aVJrTXFMcUlvL0V0NDFtQU5QUHhxWUhGNzBEYnUxNjVqL1FGcHVo?=
 =?utf-8?B?YnB3QjJPQkpwYit2QnVBVHE0WHNDUXhySkxTb3o3ajZkWS9ubmNuSGsrMU4z?=
 =?utf-8?B?S3gxYUpOZTFmQ2duSXRtK3k0VXE3YVpycHdoT0k5d3JRWndIYjE5ZThCeEcz?=
 =?utf-8?B?eDVKYzNBWmdmeWVyYWM1ZkhFMHFFaUtNUUx5eTBsTVhqYU5DZldjaGZtZ3No?=
 =?utf-8?B?Q3NIK2RWZWY0a21YdXAxS0hURjhZcTVsS3EweTNJSk96NjFmMi9scm9RM3VD?=
 =?utf-8?B?UUI5a2gyeVptSE5Pa0dRZTRyWmwrUnpLWjI4VnFqbGd4dHdiY2JCaFZucUJa?=
 =?utf-8?B?SUl1cUNrQmNTZWJ3aE5PLzdXUDFhN3NTcndSUW96dVhKaWNTdWdvaStGNDV1?=
 =?utf-8?B?YVFxUE5LemVzblB3ZFFuS2FMK2ZSYlpOVDdLZDAvY09FWDBwMlZuY2NNRWxS?=
 =?utf-8?B?dEhaNFlPRHYyaTFuREZlcC96cExnSStETElCd1ZpU3B0ZzA4dEh5eFUreTEr?=
 =?utf-8?B?cFVwZ3N3eTJCQ1RkckNMM0x0VDVKbklaSHBnbEVXTXRTUVhtSExLSFVuS0tY?=
 =?utf-8?B?UGI1dlRsNGVPVVpkY2E5VUI3ZGg1OFExb3pqS3ZubFZ0R0FvSkFQaUJ2cUpK?=
 =?utf-8?B?aU40VXE4d1ZQOW5mRlB4MjBQNVYvUFZMd0cwM0R3L0VnN2F2SGNyenBWSFhW?=
 =?utf-8?B?TU8vVkF4b0k1ZFNtYVNjVUtzSUZTSTFnTmNqQVNCQ2hiYWRNK0x5alZ2NzUy?=
 =?utf-8?B?Qzg1T2RnUjdUYWY5UXNTL1NCT0JDajBmS09qMlNjMDJxWHpMelVzMUZHVFVG?=
 =?utf-8?B?bVNVZk9BeklpODBZdlNTVWtJRzVFU0JNaVgwOE85aTFvdExGKzA2dElabDlL?=
 =?utf-8?B?MTRHc1UyckZkdXNZZTUrdlNEek5GUTQ3MHd4cVdRYTBVeUtGcU56bW44MGpt?=
 =?utf-8?B?R0liYW5ad3dSQmpyclhQcG14SW1sREl1ajFjYm56RytmL2xJY3NHWnZuUTd5?=
 =?utf-8?B?T3dEd2JTWjJFOHlWNGZyMmh5VlpWUm0xVGIzOHZEM2NITkxFTkdSazl1Szlz?=
 =?utf-8?B?SW1hZUg2SDVuVCtNSFZHejVFbURRVEoxUFVxNStYRjdXY1kzQkdBZ2ozSmVO?=
 =?utf-8?B?T202QWFUNW16SW0rakZ1Ymx0ZC9aYkY4YTdTUmJYZkxIaHJWMnlJbnhLRUZw?=
 =?utf-8?B?R25KS3FFa0xPQXpJVWpLbzBPY3c0Ujg5T3JEV2Rsd3hvaHdJZyszbzNKV1U0?=
 =?utf-8?B?R0dGVHR5UXo5WER1M1Y0bEVuU3E1UFNCa2lZRnBMVFdDTjVUei9XYUxRYjJt?=
 =?utf-8?B?ZkNjYnI3Vm8rZHZ5b2drSzB1MThtcExQUllrdy8vakJUUWJwWXlzczVjWUxC?=
 =?utf-8?B?L1JCQWwrL1Q2anhDZ0pqenFnZmswUFY2Z0EzYjVuNGplWnZwbjA3ZFpHU1dp?=
 =?utf-8?B?MTZVRnpWcUhIcXc2clRHNVB6U29SbU1yeHk2VmVoeVQxYVF4bVNCN2cvU1hB?=
 =?utf-8?B?WEpLRlJNcC91Ym1URWF4ZCtSWWp1dDN2M1RBb0VUR3p2NDlOcFF0RjVDUnpn?=
 =?utf-8?B?OGhUOERJZ2hVQy8wWmlTYnpHNHJXM1haa01YS0ZEdUpSSWNmWStPamUwRW90?=
 =?utf-8?B?NS9YVmlxbW1Tc21WdTgvVkgvRVkwT0JuZWh6UEFpWS80MnJXR242V3VHMmVM?=
 =?utf-8?B?ZjAxVkFJanYxT2dLN2NQeWRxQjBHRk00eEplc09BL0Jja3BSaFlXNm92S1Zm?=
 =?utf-8?B?VXFyRjhHYzcvM3pJQ3BpRDNIbi9ZcWZ4WUhLUjl1MWh1bTRIUDJnTjJSbFZZ?=
 =?utf-8?B?U1dRUkNBOWtPWHQxVElldnFhaEpLZjR6N0hzdTd6RGM3Z2RlRmFVQ3lqYjk4?=
 =?utf-8?B?eTA0elJ1WHVPTW1tbXBPdnI4NDFxVG9qZ0JZZ1NBQnNWcGVpNTFVMXlYMTRQ?=
 =?utf-8?B?VW1JaEhIMGRFSGVKd0d1WUVXOGhxWVV6ekw5VndyN3JKZ1BNaG1vOWhYNjVo?=
 =?utf-8?B?TFFEcFVlYW1sNitmNTVFdElReEFNT1hGNHFac3JpUHRkMW0vVWZwa0dsUDVO?=
 =?utf-8?B?cklmZ2Q5a3VQNnlJeTg3QjZKZnJEaHRpMW81TzU3RHdUc0RRMnRQYVBhSDRR?=
 =?utf-8?B?MlJkTEJaQnBrUFlzcGZ0bFFHUG1hVXlHUUtTeWgwcU5GcTNiTU1JTEo3MG0y?=
 =?utf-8?B?cnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DEC3148F26ECB46A55C6C310DCB8032@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df38a8b-7d4c-4b1b-4b9f-08dbb8fce144
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 10:40:45.3530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gqbG8Av4Ua0uQBonOfAOMiB4AqNip7hePNwy6PJw893JeW8Lb9Ep+VhUlwoiCP+KJjHrNL/2Gdx9ObTHhHa4k+MoY921jTJ12RwviYMRy1V7keNAFd7Ta/JIlxznlhuJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7100
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpPbiAxNC8wOS8yMyA3OjM3IGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gKyAgb2EtY2h1bmstc2l6
ZTogdHJ1ZQ0KPj4gKyAgb2EtdHgtY3V0LXRocm91Z2g6IHRydWUNCj4+ICsgIG9hLXJ4LWN1dC10
aHJvdWdoOiB0cnVlDQo+PiArICBvYS1wcm90ZWN0ZWQ6IHRydWUNCj4gDQo+IFBsZWFzZSBzcGxp
dCB0aGlzIHVwIGludG8gcHJvcGVydGllcyBhbGwgT0EgVEM2IGRldmljZXMgYXJlIGV4cGVjdGVk
DQo+IHRvIHVzZSwgYW5kIHRob3NlIHNwZWNpZmljIHRvIHRoZSBMQU44NjV4LiBQdXQgdGhlIGdl
bmVyaWMgcHJvcGVydGllcw0KPiBpbnRvIGEgLnlhbWwgZmlsZSwgd2hpY2ggeW91IHRoZW4gaW5o
ZXJpdCBpbnRvIHRoZSBkZXZpY2Ugc3BlY2lmaWMNCj4geWFtbCBmaWxlLg0KPiANCj4gQWxzbywg
TEFOODY1eCBzcGVjaWZpYyBwcm9wZXJ0aWVzIHNob3VsZCBoYXZlIGEgdmVuZG9yIHByZWZpeC4N
ClN1cmUsIHdpbGwgZG8gYm90aC4NCg0KQmVzdCBSZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gDQo+
ICAgICAgICAgIEFuZHJldw0KDQo=

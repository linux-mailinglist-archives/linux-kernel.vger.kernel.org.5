Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BC77DB777
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjJ3KKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjJ3KKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:10:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFFF8A68;
        Mon, 30 Oct 2023 03:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698660597; x=1730196597;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iar9gNx3KaAoDAQSFWw/N2TeHhniYWUDcAE0i/5qVNc=;
  b=QsrY/pbNTy18DlKTcbR4O+Ku7OAYVxUQQ4AYr6/AuWvaUEIzYehJN2F1
   9GYsKZ9herV4iFnk8PClJW/k6TT+tDQoAn/Xm7nSZNGmSuFeSTwg1xujS
   WypWnd860mDqBFO+5mSlGBUNTR7mDwKDyePyJk3NEgTwj/p8N6kjN/OUQ
   iJ1lTvh4A854y/JLKNWFpGbczx+ht0dFri1s/Z/XtW3d4hnwL+tMo92dB
   noXyHaPgTGmW5UJT7m2o567DSEcrr2Y621rTQmg0loTXhtWqfBz5HCkT0
   umuCn3SC+uuJHqNBV1GGPoK7HBMFF0ulOltz+pqIPXSTGOBiwbFw9rZU6
   g==;
X-CSE-ConnectionGUID: PF5oDu2mSDShlHiH3I25Cw==
X-CSE-MsgGUID: jNh6Tx98QlKaqeB9jCmQjw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="11416011"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2023 03:09:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 30 Oct 2023 03:09:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 30 Oct 2023 03:09:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXNZJ3p14MDwPZc7Bc4GyKFo07b9PJGIqjy1vbMl910JG10MiPKFS6FmuCFP++lDSKCV10arxChxmukBwOmsPghmZ1jdGXKbXXTSClGSPJgF/6u6WhMQ6Lj/TLDp2pKqWPz/BQr6Ebm8DfiNqNWSWb8unTQvv6WCd3X0Jqtwkzdtc+5bs5HfvLAXCfIF3S5zEyFyaL3cZZvTJ6r7/2Hsle65qS6JJIIdtgoySWI/nD0rBbNootwYvjAS8R7Fbnw2OmHh3AN6qKKJXIYNCa86uwQq9Enk4BhIVGdKgl929weCrKqWu8hWwUbVP8ZDfe6GSMO5sKlF5EZkT8YlUsdSFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iar9gNx3KaAoDAQSFWw/N2TeHhniYWUDcAE0i/5qVNc=;
 b=OiUeCt+50KMfvdml+os300FkhWAoQBAeqQXwyVfAvVgO9rltPeamdvmNb5KirVlUa1d3ONJPqKFdMElX1pSMGGHcKEyLV9s+GTGtfQ1/1cEAadh9LFUK8qltVoFNRdSL3lX89q9H3XEnS/ZqUuPLUQwgkxHkixCsvbjHcYoSImuNeE/GiTBhpYrqbvMy+rw7ql1od3df2qdWLkAlPMY2c1SixvuKMYs/4oVMOgUhOGJD46Q8Y6qJ+EP2215oiwV54P5O+QoAwZTKNujrZ4gyFWJ3mldz/w1IJ8JJVS2H0lsG/lASnguwpeaDCcLp/M21/f3K0Gfh/f+1jM0dfKFV7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iar9gNx3KaAoDAQSFWw/N2TeHhniYWUDcAE0i/5qVNc=;
 b=LtDmepc2orpn9ipH2oMMr9z2Ljywam/qHw2oRcVP/nXspl1lPm7DNdIzdjW9TiyjPZgTOpH8ADV+oT3jytwDyooq0WLsjgC1h12GUJdlq+BypbWFEjjwph0/dB5ohM9ja1fiOOk1soqTz14uyXBiGGpT02xR71vMhl2YB5M3OHI=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 SN7PR11MB6653.namprd11.prod.outlook.com (2603:10b6:806:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 10:09:22 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::595f:f69d:149d:510]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::595f:f69d:149d:510%4]) with mapi id 15.20.6933.022; Mon, 30 Oct 2023
 10:09:22 +0000
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
Subject: Re: [PATCH net-next v2 4/9] dt-bindings: net: add OPEN Alliance
 10BASE-T1x MAC-PHY Serial Interface
Thread-Topic: [PATCH net-next v2 4/9] dt-bindings: net: add OPEN Alliance
 10BASE-T1x MAC-PHY Serial Interface
Thread-Index: AQHaBchdwqp9J78AZUCeswF+FBl/obBYGPIAgAVG1gCAADfRAIAEjyYA
Date:   Mon, 30 Oct 2023 10:09:21 +0000
Message-ID: <b3c483cb-f770-4ac4-9950-dd36e0579bc6@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-5-Parthiban.Veerasooran@microchip.com>
 <fd7f7d62-7921-4aac-9359-ff09449fd20c@lunn.ch>
 <acfb97fa-54f8-4381-bb82-db8f85fa86db@microchip.com>
 <d6377de8-603f-4ac1-a691-b79c46a5057b@lunn.ch>
In-Reply-To: <d6377de8-603f-4ac1-a691-b79c46a5057b@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|SN7PR11MB6653:EE_
x-ms-office365-filtering-correlation-id: 47458e69-ead2-45cb-16c8-08dbd93049aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: smmbIwgeJ2m0Qwjidr7mAZH2dKAtEYr/rr40CCV74va4lKzozXXyuCd+cqOGtriWHIVz4RuTU9xZhePsXZFZbIIwmdSI+KvdeGlyv7MyXfcYHgQKrBL9DpPHZw9smhWNrWwCMwsj1/+GYMsxbaourNQxvbQT6l9mUv7kKbRg/K8UFMkD2l/PZ/ZoO/ZRLGPZcsTtTbYQlH0rPnMJwABMRmVopoNEioUuan0L8ZV8Br8XnyDeH4j6EylZXrJmlfv550tIQJkjIhm7z75wmRNSTG4/ycRbiwHuasio8H3SYrk+8VZXZK5PNMf84C3rIOsrs4CKooIDkHfD0osbQWxkeOU/W6bDvhr1obkFt4vp+KQ6XmSwIXI2FnBivvA5UV2snYE1htRWkjcQNqjhjobCdnz5zV+WHYVivRwiGFe8+gJkLlnP2pNafkjRnVN3cv7nAVO9oWzsjLgCrRGdW8VLDO/1/iwl7e8s++7tLYwbxB6K1bZ+KyPmFCZTW5U/mTmbLDwf43nopp+ZaOS44DInqa5r0ivO82NW+sBgCt6NOirtDaMQSLlUwsTc4yDdUpIExlgBtClbRsrXLLrR1JgAMO4rcstLc/YKc3oSxz39FprWvtwy3iRL1GQJvA3Rsg17c6NG6eFLZVZMMhlo9uLcgpuFGkWyb10BVM7TVfaGqIw/jSzh6s6AotUjktUPF5YQ82MmRbgnv/8WM1HVUeptNiUb4pMLNY0OVUx/qjyVF8A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(136003)(366004)(346002)(230922051799003)(230173577357003)(230273577357003)(1800799009)(186009)(64100799003)(451199024)(2906002)(316002)(66446008)(66476007)(6916009)(66556008)(54906003)(64756008)(122000001)(38100700002)(71200400001)(91956017)(53546011)(6506007)(2616005)(478600001)(6486002)(66574015)(66946007)(76116006)(83380400001)(5660300002)(6512007)(26005)(107886003)(41300700001)(7416002)(4326008)(8936002)(8676002)(31696002)(86362001)(36756003)(38070700009)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anhxZjR4bFlHZ05wNnZNMzlYYkc0dG5pNXlDY2p5TUFrWG54SnJNalc3TTNO?=
 =?utf-8?B?UnpiWFRjUGRHd1hicDdIT1UzVUxmQTJ6VjcvTER1cG9UaGtDV1JvdjNLYytp?=
 =?utf-8?B?Tk84R2lJQlNtdjZTZ1BIYkhGZEtHT1FZVU1oY0l6TUhTMEwxSEl3SG9adnJx?=
 =?utf-8?B?VHladTIyTDdLWE4yYUtLR2MrUlVFRTU5T3RxSFczVWVJUXh6c0E3MWpiVkwy?=
 =?utf-8?B?TE4rUUNGWmxGV2ZtSEtrS2FXdjdzMkdQUUZFeEhtb0pOZlBTanMrL0hoaE9m?=
 =?utf-8?B?V2VtV1F3RWhNWUJ3VzhaTWpNTHlOYWVUZU5yZzlpNHA5dktXYTh5R3lBbWha?=
 =?utf-8?B?ZTd1MnhYRmJrYUM0c200cTkzbytYOTV3VTkxS1o0TG80RWt5UWRodFpIUWY2?=
 =?utf-8?B?Wm9LcWpEd0c1ZmNYdTU0eTRVaTFvV3ZCcjdOZDF1aEluQnhIcER2Q0dXR3VO?=
 =?utf-8?B?WFRLMWhQMkdxVXlMMEg5a2pVRyt0RjB3Wjg5Nm91dkErOGRrMTZJN3RxNTgx?=
 =?utf-8?B?NmlSVTlmckNmMEh0amZvUlRaa241Vzh4YzBGbHYwK3FEZGY5SFFaN2Qzb1Ex?=
 =?utf-8?B?TTNJTzBIZ1czTHBrUUlDS1JBa3FGbGFkWkUxL3ppVDcwRW5QRFVzMWpuaS9r?=
 =?utf-8?B?REcvMS9aTzZndmd0TE5ZblVpRXFBdURtTjJGSmpNY1Q0YWxxZks2SVAxSmQ1?=
 =?utf-8?B?cWVBc0ZNMHhMQ0VlVEZDekMrMVRGVjMwL043R3JvdndYM3NubEpJMjdOTUcy?=
 =?utf-8?B?R3dZUzVyWW40b3JIUVBueEdIK3BtMTdGa2JiQ2xUZFRvNXpHN1I5dmlINnEx?=
 =?utf-8?B?dFQ0Y1gwa1VST2kvM2dPU0RIYThKc3JuaUtJaGxCUEpOQ1F6b3hjcGMyajZG?=
 =?utf-8?B?U2Y0YXRTWDJOQU1QQjBOWHR1Y2U5S3ZjeDRSV3AwaXlBc3ZiRXpGbm1JMWhk?=
 =?utf-8?B?QWJFWktoTk9CejZTdFlzYW9SaDdIcXFkSUlVSHc1OUN4b2ZuTmUxUHQ0RU9t?=
 =?utf-8?B?NUYwVHY3TUNsU05HazJCa0EyTDJvci85VjdEUHFiK3BrTkVNSDh2Y2Fsb0ho?=
 =?utf-8?B?TGpxOTJsZHRBUHpXRThuWFN0c21nSFlhZitkTGZDLzlUaUlKSldyZGJPRmx3?=
 =?utf-8?B?ZnFFMFpvWW5selZRd1N3NUI0bFZtR3AzRDhaQkRIWUpMRXNsT1ZmZzlpZWJ1?=
 =?utf-8?B?YitMRlhibXJEN2tSWnF0NmVtbkdLZWZaVjBBd0FlK2VCQ3BsaEhEUWRDMi9m?=
 =?utf-8?B?Mk90bmw0MWUzZXRCYmMwVlZ4d1dNUENCdktoQ1kwQ3E2a3BaYmNmQzQvb3hD?=
 =?utf-8?B?WFpjNjcvVWw3N0VxYjQ3UGJqK1FpNC9kZjJGSEpma092S0tycVpBQm9XVGZD?=
 =?utf-8?B?eGttYlR3WVhESFZzZUxCc0xjNzdJaUpUM3g0YjhoWko2N1Y4K0hBSVNSTzV6?=
 =?utf-8?B?K3ErMUxzbEg2V1dFVDd1VUQxdTdkZEN0TEJNcUt6aDdCODYzdlJEdldMY21B?=
 =?utf-8?B?RmhMNyt0SVkrU3BEYmR3Tk02cmNCQWhLb3dOdzErcHpVdXRJZjhEWHlnNkE3?=
 =?utf-8?B?WnBiTmRaRzE2cmVMWFVKc1d5VTh6aWlqRU5MZ2tGazBjNjdOWVkzT3FZNEVi?=
 =?utf-8?B?VjM3RmRPME9saWF3c0ZtM1p4eWNvbDZsa2l2T240alRBM1FQUUs4ZUFHMjBM?=
 =?utf-8?B?WldDSUxxektsVUlXWGZhNEVvZEZYVTNwQWRReitrK2lGSm9DTEFGa1F0SDRR?=
 =?utf-8?B?bXR0Yi9RNlpJSkNNVUlhWFM4UzJ2dzRXNEpvamh5UkJaQ2c4dVRlSG9ncmpZ?=
 =?utf-8?B?bzRVakx4dm5ybitvOTRDc2o2WDR5OTh3SEkvQjB3cHBoeldDb1lpS295YjVZ?=
 =?utf-8?B?VFIyRFd4VVA0cnhaRGpmUVJMWjZQT095bmk5OUFzdm11endaQ3BSbnlUcDBB?=
 =?utf-8?B?ZnpOcS9rLzd1UWZVQjRBRGFlNC9senI2WjdWdXdxVWYrcVNLOWxOUlFMYi9r?=
 =?utf-8?B?dlZvc0VvcjUxbmpjaENoUGp0SHU4Zm5vVkxmYStpZXhrRVBRcWxOelF4TWU2?=
 =?utf-8?B?UHkzaFFUZW8vV0pOUmVxN1pveGZNUEE5OGlleHQxMWhQbnJQUlllZ2lXa3Yw?=
 =?utf-8?B?NGdmTE5XRXFPRXVUUVZ2K0tPb0hGUHNUSzhaMUNCUFZOK2JlVUlOSDJXdlY0?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7D11707194E8446A69979DF8373A4FC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47458e69-ead2-45cb-16c8-08dbd93049aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 10:09:22.0173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WB+ZHziEeUcYAvH60RA+oDnaOoHjrQf+lBTrnHjUmzvdxbZPdc+xaz1N4ToqGY4Gn43MSDO5Qv7oIcWxOlVAXD1EsmboWeAcN8Fu3G8nDHmAV24zx06MMzXfQkKIKsMN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6653
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpPbiAyNy8xMC8yMyA2OjAyIHBtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4+IERldmljZSB0cmVlIGRl
c2NyaWJlZCBoYXJkd2FyZS4gSXRzIG5vdCBzdXBwb3NlZCB0byBiZSB1c2VkIHRvDQo+Pj4gZGVz
Y3JpYmUgY29uZmlndXJhdGlvbi4gU28gaXQgaXMgbm90IGNsZWFyIHRvIG1lIGlmIGFueSBvZiB0
aGVzZSBhcmUNCj4+PiB2YWxpZCBpbiBEVC4NCj4+Pg0KPj4+IEl0IHNlZW1zIHRvIG1lLCB0aGUg
YW1vdW50IG9mIGNvbnRyb2wgdHJhbnNmZXJzIHNob3VsZCBiZSB2ZXJ5IHNtYWxsDQo+Pj4gY29t
cGFyZWQgdG8gZGF0YSB0cmFuc2ZlcnMuIFNvIHdoeSBub3QganVzdCBzZXQgcHJvdGVjdGlvbiBl
bmFibGUgdG8NCj4+PiBiZSB0cnVlPw0KPj4gWWVzIGhhdmluZyBwcm90ZWN0aW9uIGVuYWJsZWQg
Zm9yIGNvbnRyb2wgdHJhbnNmZXIgZG9lc24ndCBodXJ0DQo+PiBhbnl0aGluZy4gVGhlIG9ubHkg
aW50ZW50aW9uIGZvciBrZWVwaW5nIHRoaXMgYXMgY29uZmlndXJhYmxlIGlzLCBpdCBpcw0KPj4g
ZGVmaW5lZCBpbiB0aGUgT1BFTiBBbGxpYW5jZSBzcGVjaWZpY2F0aW9uIHRvIGVuYWJsZS9kaXNh
YmxlLg0KPiANCj4gU3RhbmRhcmRzIG9mdGVuIGhhdmUgb3B0aW9ucyB3aGljaCBub2JvZHkgZXZl
ciB1c2UsIG9yIGFyZSBvbmx5IHVzZWZ1bA0KPiBpbiBwYXJ0aWN1bGFyIG5pY2hlcy4gSXRzIG9m
dGVuIGJlc3QgdG8ga2VlcCBpdCBzaW1wbGUsIGdldCB0aGUgYmFzaWMNCj4gZmVhdHVyZSB3b3Jr
aW5nLCBhbmQgdGhlbiBhZGQgdGhlc2Ugb3B0aW9uYWwgZmVhdHVyZXMgaWYgYW55Ym9keQ0KPiBh
Y3R1YWxseSBuZWVkcyB0aGVtLg0KPiANCj4+PiBXaGF0IGlzIHRoZSBlZmZlY3Qgb2YgY2h1bmsg
cGF5bG9hZCBzaXplID8gSXMgdGhlcmUgYSByZWFzb24gdG8gdXNlIGENCj4+PiBsb3dlciB2YWx1
ZSB0aGFuIHRoZSBkZWZhdWx0IDY0PyBJIGFzc3VtZSBzbWFsbGVyIHNpemVzIG1ha2UgZGF0YQ0K
Pj4+IHRyYW5zZmVyIG1vcmUgZXhwZW5zaXZlLCBzaW5jZSB5b3UgbmVlZCBtb3JlIERNQSBzZXR1
cCBhbmQgY29tcGxldGlvbg0KPj4+IGhhbmRpbmcgZXRjLg0KPj4gQWdhaW4gdGhlIGludGVudGlv
biBmb3Iga2VlcGluZyB0aGlzIGFzIGNvbmZpZ3VyYWJsZSBpcywgaXQgaXMgZGVmaW5lZA0KPj4g
aW4gdGhlIE9QRU4gQWxsaWFuY2Ugc3BlY2lmaWNhdGlvbiBhcyB1c2VyIGNvbmZpZ3VyYWJsZS4g
VGhleSBjYW4gYmUgOCwNCj4+IDE2LCAzMiBhbmQgNjQuIEFuZCB0aGUgZGVmYXVsdCBpcyA2NC4g
QWxzbyBNaWNyb2NoaXAncyBMQU44NjUwIHN1cHBvcnRzDQo+PiBmb3IgMzIgYW5kIDY0Lg0KPiAN
Cj4gRG8geW91IGhhdmUgYW55IGlkZWEgd2h5IHRoZSBzdGFuZGFyZCBoYXMgZGlmZmVyZW50IHNp
emVzPyBXaHkgd291bGQNCj4geW91IHdhbnQgdG8gdXNlIDMyPyBJZiB5b3UgY2FuIGFuc3dlciB0
aGlzLCBpdCBoZWxwcyBkZWNpZGUgaG93DQo+IGltcG9ydGFudCBpdCBpcyB0byBzdXBwb3J0IG11
bHRpcGxlIHNpemVzLCBvciBqdXN0IGhhcmQgY29kZSBpdCB0byA2NC4NCj4gDQo+IFRoZXJlIGFy
ZSBwbGVudHkgb2Ygb2xkIHJlc2VhcmNoIG9uIEV0aGVybmV0IGZyYW1lIHNpemVzLCBidXQgdGhl
eSBhcmUNCj4gZm9yIExBTi9JbnRlcm5ldCB1c2FnZS4gWW91IHR5cGljYWxseSBzZWUgdHdvIHBl
ZWtzLCBvbmUgYXJvdW5kIDY0LTgwDQo+IGJ5dGVzLCBhbmQgb3RoZXIgYXJvdW5kIHRoZSBmdWxs
IGZyYW1lIHNpemUuIFRoZSBzbWFsbCBwYWNrZXRzIGFyZSBUQ1ANCj4gQUNLUywgYW5kIHRoZSBy
ZXN0IGlzIFRDUCBkYXRhLiBIb3dldmVyLCB0aGlzIGlzIGEgVDFTIGRldmljZSBmb3INCj4gYXV0
b21vdGl2ZS4gSSBwZXJzb25hbGx5IGhhdmUgbm8gaWRlYSBpZiB0aGUgc2FtZSB0cmFmZmljIGRp
c3RyaWJ1dGlvbg0KPiBpcyBzZWVuIGluIHRoYXQgYXBwbGljYXRpb24/DQo+IA0KPiBBcmUgdGhl
cmUgcHJvdG9jb2xzIHJ1bm5pbmcgd2hpY2ggdXNlIGEgbG90IG9mIGZyYW1lcyBzbWFsbGVyIHRo
YW4gNjQNCj4gYnl0ZXM/IElmIHNvLCA2NCBieXRlIGNodW5rIHNpemUgaSBhc3N1bWUgY291bGQg
YmUgd2FzdGVmdWwsIGlmIHRoZXJlDQo+IGFyZSBsb3RzIG9mIDMyIGJ5dGUgZnJhbWVzLg0KPiAN
Cj4gVGhlIG90aGVyIHBvdGVudGlhbCBpc3N1ZSBpcyBsYXRlbmN5IGFuZCB0aGUgd2F5IHRoZSBT
UEkgYnVzDQo+IHdvcmtzLiBJdHMgYSBzeW5jaHJvbmlzZWQgYmktZGlyZWN0aW9uYWwgYnVzLiBZ
b3UgY2FuIHJlY2VpdmUgYW5kDQo+IHRyYW5zbWl0IGF0IHRoZSBzYW1lIHRpbWUsIGJ1dCB5b3Ug
aGF2ZSB0byBzZXR1cCB0aGUgdHJhbnNmZXIgdG8gZG8NCj4gdGhhdC4gSWYgeW91IGFyZSBidXN5
IGRvaW5nIGEgcmVjZWl2ZSBvbmx5LCBhbmQgdGhlcmUgaXMgYSBuZXcgcGFja2V0DQo+IHRvIHNl
bmQsIHlvdSBoYXZlIHRvIHdhaXQgZm9yIHRoZSBjaHVuayB0cmFuc2ZlciB0byBjb21wbGV0ZSBi
ZWZvcmUNCj4geW91IGNhbiBzdGFydCBhIGJpLWRpcmVjdGlvbmFsIGNodW5rIHRyYW5zZmVyLiBT
byBhIDMyIGJ5dGUgY2h1bmsNCj4gbWlnaHQgbWFrZSB5b3VyIGxpbmsgbW9yZSBlZmZpY2llbnQg
aWYgeW91IGhhdmUgaGVhdnkgYnV0IGJ1cnN0eQ0KPiB0cmFmZmljLiBIb3dldmVyLCB5b3UgaGF2
ZSB0byBjb25zaWRlciB0aGUgb3ZlcmhlYWRzIG9mIHNldHRpbmcgdXAgdGhlDQo+IHRyYW5zZmVy
IGFuZCBydW5uaW5nIHRoZSBjb21wbGV0aW9uIGhhbmRsZXIgYWZ0ZXJ3YXJkcy4gVGhpcyBjYW4g
YmUNCj4gY29zdGx5Lg0KPiANCj4gRG8geW91IGhhdmUgcmVhbCB1c2UgY2FzZXMgZm9yIHVzaW5n
IGRpZmZlcmVudCBjaHVua3Mgc2l6ZXM/IElmIG5vdCwgaQ0KPiBwcm9iYWJseSB3b3VsZCBqdXN0
IGhhcmQgY29kZSBpdCB0byA2NCwgdW50aWwgc29tZWJvZHkgY29tZXMgYWxvbmcNCj4gbmVlZGlu
ZyBzb21ldGhpbmcgZWxzZS4NCj4gDQo+Pj4gQW4gRXRoZXJuZXQgZHJpdmVyIGlzIGFsbG93ZWQg
dG8gaGF2ZSBkcml2ZXIgc3BlY2lmaWMgcHJpdmF0ZQ0KPj4+IGZsYWdzLiBTZWUgZXRodG9vbCgx
KSAtLXNob3ctcHJpdi1mbGFncyBhbmQgLS1zZXQtcHJpdi1mbGFncyBZb3UgY291bGQNCj4+PiBt
YXliZSB1c2UgdGhlc2UgdG8gY29uZmlndXJlIGN1dCB0aHJvdWdoPw0KPj4gU28geW91IG1lYW4s
IHdlIGhhdmUgdG8gaW1wbGVtZW50IHRoZSBzdXBwb3J0IGluIHRoZSBldGh0b29sIGludGVyZmFj
ZQ0KPj4gdG8gZW5hYmxlL2Rpc2FibGUgdHgvcnggY3V0IHRocm91Z2ggZmVhdHVyZSwgaXNuJ3Qg
aXQ/DQo+Pg0KPj4gSWYgeW91IGZlZWwgbGlrZSB0aGUgYWJvdmUgY29uZmlndXJhdGlvbnMgYXJl
IG5vdCBuZWVkZWQsIHNvIGJ5IGtlZXBpbmcNCj4+IHByb3RlY3Rpb24gdHJ1ZSBhbHdheXMsIGNo
dW5rIHBheWxvYWQgc2l6ZSAoY3BzKSA2NCBhbHdheXMgYW5kIG1vdmluZw0KPj4gdHgvcnggY3V0
IHRocm91Z2ggdG8gZXRodG9vbCwgd2UgY2FuIGdldCByaWQgb2YgdGhpcyBEVCBiaW5kaW5ncz8N
Cj4gDQo+IEFnYWluLCBkbyB5b3UgaGF2ZSBhIHJlYWwgdXNlIGNhc2UgZm9yIGN1dCB0aHJvdWdo
PyBPciBtYXliZSBmbGlwIGl0DQo+IGFyb3VuZCwgV2h5IHdvdWxkIHlvdSBub3QgdXNlIGN1dCB0
aHJvdWdoPw0KVGhhbmtzIGEgbG90IGZvciB5b3VyIGRldGFpbGVkIGV4cGxhbmF0aW9uLiBGcm9t
IHRoaXMgd2hhdCBJIHVuZGVyc3RhbmQgaXMsDQoNCjEuIFdpbGwgbWFrZSBwcm90ZWN0aW9uIGVu
YWJsZWQgYWx3YXlzIGZvciBjb250cm9sIHRyYW5zZmVyLg0KMi4gS2VlcCB0aGUgZGVmYXVsdCBj
aHVuayBwYXlsb2FkIHNpemUgKDY0KSBhcyBpdCBpcy4NCjMuIERlZmF1bHQgdHgvcnggY3V0IHRo
cm91Z2ggbW9kZXMgYXJlIGRpc2FibGVkLiBTbyB3aWxsIG5vdCB0b3VjaCB0aGVtLg0KDQpTbyB0
aGF0IHdlIGRvbid0IG5lZWQgRFQgYmluZGluZ3MuDQoNCkJlc3QgUmVnYXJkcywNClBhcnRoaWJh
biBWDQo+IA0KPiAgICAgICAgICBBbmRyZXcNCg0K

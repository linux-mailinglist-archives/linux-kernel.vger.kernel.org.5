Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5306B7DF3D6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376551AbjKBNbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347433AbjKBNbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:31:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C6CA6;
        Thu,  2 Nov 2023 06:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698931907; x=1730467907;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LGoslfON1wMgHbdr3i1hfeZM/v6lRNS/GGQMmOZSgNA=;
  b=iZIcWQwndz0Z13Rb6AkqVtyT7rkmqITxDE2BmuCDZT0LaeP5kzkVlqLk
   OoNsphSd345hJunTfYlqLc0VNXgMkoJYYl80lELoZX10/Kpk4PmWtU12J
   zPZf6TT3KCyIEzXLqwljToN+brxE4P/Bp0u/zU/rZfYa1F+5YgpBhB/OR
   nSrnOflHo5L4ZzzweUyvOqdZAHsONKaotJHmGWQKIc9cJeZyZo0nXVWji
   UcQzzVwLAXhYVksp/VLYW4jf6TLpnEwW4D38Mf1MW1HOkPhg4BIkfe4Qh
   WZuqOsfE0/uNfE/GJGYfIDgvsNSn5LdUvLIoqoFyqDhjW50+qV6DpAjLB
   w==;
X-CSE-ConnectionGUID: Mpek6TZfTiCtb+XzT+6ZIA==
X-CSE-MsgGUID: KDWYxmwfQDae6fjo9CUHRw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="241764384"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Nov 2023 06:31:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Nov 2023 06:31:43 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Nov 2023 06:31:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCq6PyGG1yK+MjPPwiObpyW19i58JIvfqO8CpIKZmbxgngPMgY+WjJPayGxO+3w6KKiPSmf2VBne0D5Y6MbvIKEld+YxvtI/k1v7pCeihNtTYb16mTs36J0gslcv06CkpksYi4LjvuYNsmFY0SNNx9PJGtp9O7JlP8fiHAJnwFABe00lIkXhh1oMSvNoazqq3ldg6o9aQcSpXGhdFL5S906lRW4AzGRTVKp1i4lx6HdbJjRa5vgGM34EmMBb2PgNp8ufACrgSSpRXWeXhDFYDysu+mjw+VCPxnGXJgd3wwOqovMz0mNfCf8QnY/lPZbxBhoKElvfMX1TE59AkhxDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGoslfON1wMgHbdr3i1hfeZM/v6lRNS/GGQMmOZSgNA=;
 b=FWDCtsS7gyugzv4LrAeaSY0fL0d/oIaWZcJG5UbkGO0SqyX5YYePh5aMiSeu1/T6v5mht0t6W+qbesx+MxW3N+j2ce6TtqH7fwrcWUVKiuwPz6kmRd4g+0MVrjDKjlFOmMJvRcrMc/EDuWld0RGImebAXCdVUaH6GJGITBvYdDGXg9/MtBW02x9W3TEqZyni1MQC10ZUZLIrrELY+zh0NM5/2Hyz2DGRXwM5dYom70p+icrquSZt3xnzZ1a5jsC2VQI5hxh9OcCU43Nf08T7k+ZQOtTE0qgK3gTiPEHqG4oa6HLGIbVjDzf9GCxmPFR6EbnR6YD67fy5BGnYmYUZ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGoslfON1wMgHbdr3i1hfeZM/v6lRNS/GGQMmOZSgNA=;
 b=kVDF5eySxyLeVOTK5rAmDVLSs0nijKQbyYgxZZwzMouRC+X2YlchXTb/YCsa92AZNhVwOdnvPWNrrgPDNA9R1CKN9P/4+2rCqJ5p40+iFWye00ItGpnaT1/NYRlyYgodO+oUBv/P7Es+lYVSyGjq064nGYCsNjahUjxGuH/gqak=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 PH7PR11MB6955.namprd11.prod.outlook.com (2603:10b6:510:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 13:31:39 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::595f:f69d:149d:510]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::595f:f69d:149d:510%5]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 13:31:39 +0000
From:   <Parthiban.Veerasooran@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <Horatiu.Vultur@microchip.com>, <Woojung.Huh@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <Thorsten.Kummermehr@microchip.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <corbet@lwn.net>,
        <Steen.Hegelund@microchip.com>, <rdunlap@infradead.org>,
        <horms@kernel.org>, <casper.casan@gmail.com>, <andrew@lunn.ch>
Subject: Re: [PATCH net-next v2 9/9] dt-bindings: net: add Microchip's LAN865X
 10BASE-T1S MACPHY
Thread-Topic: [PATCH net-next v2 9/9] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Thread-Index: AQHaBciQjBoWnY4j9k2nUOrnZEADaLBYlZuAgAnFeoCAABjSgIAEol2A
Date:   Thu, 2 Nov 2023 13:31:38 +0000
Message-ID: <4e71bdff-0a77-4039-aa29-4038091a1ad7@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-10-Parthiban.Veerasooran@microchip.com>
 <91764d23-eed2-48f9-97c5-ac6a44f48f2b@linaro.org>
 <3ee02690-8912-47b4-a97e-6d364969c956@microchip.com>
 <08ad71a0-daf1-4588-a97c-95f3ee5df84e@linaro.org>
In-Reply-To: <08ad71a0-daf1-4588-a97c-95f3ee5df84e@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|PH7PR11MB6955:EE_
x-ms-office365-filtering-correlation-id: f391acd6-71bc-4029-fde8-08dbdba80b01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s0UKQt32J55D1m6+GL1gQtMF+OTX8RYWI7nWuiDwEeNAkyhhi/RjZfi9E4zl2mlefJYHl7I07XAo8Onh+7v5bwhbEuRY+PvB8imWTUu1YKAcuGsSTzvo+TtI9Uq/fupldU1zsT8G4vmLcsoGkGmQSrw/a9rsJbPKMFFp2S0kxUH6j//ric3x7Cbw+sqDvLmdsPDN6c5Y5HV4wPFUASgdteQ6lr8FVHW6SH4EuIeT82vWIiPznoISANwknmUtzPq1y1Y6ALmnGSFBOYTDbt3hvTyty10A62pxDOMLrQUtEgGYhhzgcKBeD9aldZWPsw9U0JU7HO548HQ9ku58nn6nHVJ+VtuOLSSgdOA7S5QVqmEwUEotIm4ZNAaxze/0y9MgSJyduGLWErIWPIkR7PojojKOs4oqbyk2hZNijcb+R/Q6MOQzEcFqsYJfc1daXT3XNzMv4QJUQHiW06QEyrBrPN8vC2fUHUvcejcgXJokyLxs1i86DXx6dcqEseAkzG+fFkYj4oRx8XDqjuemD6H73J19ZepsXdQyYF6FfqS+6njExp0KhnwPxopUlS/avXjur+oukMRfHzGv7D1AAV1pAKwYbswcFilGL7qIxWBIWS2nifq3i6W3NYEUzhgl4AfRMLe/r3NXU2K7LYt6UlCy9O2Z0JCbUPrkALfIf8Is2upCr0O2kHZ0ySxnIrGAgnzlUpoTT4XlTl3JyZVug8wyxJ2SOrzav7z0BVFa8xPOIaJ6UaGYsCsL//ixkqPiNjXu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(230273577357003)(230173577357003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(6512007)(2616005)(478600001)(71200400001)(6506007)(8676002)(53546011)(83380400001)(5660300002)(2906002)(7416002)(41300700001)(966005)(76116006)(91956017)(66946007)(66556008)(4326008)(316002)(8936002)(66476007)(6916009)(6486002)(54906003)(64756008)(31696002)(36756003)(38070700009)(38100700002)(122000001)(66446008)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0tGaVJ6aDc3OHRPWitZMVkyNFArWHZSakNPNURxS3pZQlBQVnBjMmE2WFMy?=
 =?utf-8?B?SXBoMmN3dlo1L3hMRUxlMXFuTS9GN0RWeTYveVpxcSt5VWFoOXpGRTM5a3gv?=
 =?utf-8?B?MGVJUUtaZ1E0S05LZENYTzdrRzMrVlVyWHU3MXM0WmxUajNTdTgzVWVWMEV4?=
 =?utf-8?B?WEV1RVdSaVpaU2VMb3Q4R05LaFRwRWp1RHZLenR4U0JnQXE0d2E0SlhJamkv?=
 =?utf-8?B?TG1XdUlKWHBOU2NGc3h1UXhpbThlWjlpYUZSUWEvSHpNQjRxSkZlc3dSMmNU?=
 =?utf-8?B?YWdkamNKdjdRS045TGdnK3NCS1N4WkFNREF0YWhCc1ZMU2RlbXlzK2VKRkl6?=
 =?utf-8?B?ZnN0R09oZUtmZGR3U2t0VjVKdkpIeTRHa2Y1c2dEa3F5TDdZSURkcno4aS93?=
 =?utf-8?B?ZVN5bTFvZFd2d29RcDJZYldUNFYwbTVwT25zeWJtV2lkNDlUbDhrSDZ0YXlW?=
 =?utf-8?B?Wm5sekJ0cVZQcDlJbVR6Q0dSVHM0V3hheGljZXZtMXdtVFprbHlidGNjWFZY?=
 =?utf-8?B?azQyV0I0NU5xczZyQkd0eGJqZ0d0TEVLZ2R6cUkxYmlGTko2RW85Y0VOZlFR?=
 =?utf-8?B?aGdETFNBOFZzeThWRDlhU0N4akZkOEJsS1NPekxOaktEVWFsQmxQR2FkalQz?=
 =?utf-8?B?S29tT2NqclB2SWt0UlQrelJqeVFVMW1XY05VQmVJOXpzaUtmaSs4b1JoTC9L?=
 =?utf-8?B?TTNYRDE0UTZKMHUwSHNRQ29YVXdKZDNLQmw4eEhwekp1d2lMQVZMQmMrY0tk?=
 =?utf-8?B?cURhWEYycUU3KytMUTd3SDk1UEhNV3JwMm1NYUFZekFCZlBMWERKQzNkMHll?=
 =?utf-8?B?MEdBcUJxMyt2UUs3b21JeE9rbC9JRThJQ0hLL1N5a2ZGUUFXWTlacitqOU1X?=
 =?utf-8?B?UXFWbGJCQmhwSWVKOUFHcHpZUlB6R0pjRGdGZElFSkgxOXJWVlpUTDlxdWlK?=
 =?utf-8?B?N0tMaUtDUkZ2cHUrcHo2VFdXam1jQVRTNlNnem9WNjdhcUlNZDdnL3VBZFF2?=
 =?utf-8?B?NkhPZ24wTC9LdERLSXdRU056MUwzbDk0REd5djFyWXJONkxLMUtRd3pxMmFL?=
 =?utf-8?B?Yy9rbUNVb2wwOGFKUFRvSXc2c2RFbW04d3orak00MGRLUDFtOHQrM2hLaDFH?=
 =?utf-8?B?L1I1ZE15K0NpOXdkVmNPaXJRUlUzZGFYbmV3c0M1S3RqZU81d1dGNWtMb0p5?=
 =?utf-8?B?dUFWR1dGTnhjbGFPbUZnSWl5ZGxHeDQxaGtSTjlWemw2ZEx4SW96OEVvWHZy?=
 =?utf-8?B?L243bzc5NHp2emxoMW03a0N4d1dJRUtYa2l5bE1XRi9wVm1IZlRQVmRWMDVQ?=
 =?utf-8?B?S1J0T2wvaGdJcmVsQ3F5ZExVbnppRE5ITTdibmtCM08zdXN6aVNIVmJKdHlY?=
 =?utf-8?B?NU56QW14V25xNHpaekhOaHk2TU93OWFnT0RJbFhlZVA2RWxXaDRJQlBrTUk1?=
 =?utf-8?B?LzZWb09CbzdGRld3aml3N2F4R0o0ckd4cXVzOVFJVFp1N1YvaGRKNnJObmh3?=
 =?utf-8?B?ZWpJdlFRME5rWGtBTkJEN1VoOE5jVG1MbGxZZmFneGtSd3RHL1ZZRnJIb0ZZ?=
 =?utf-8?B?bk43dHNQSUVpUHFQY29DOVFWUTgrL0pEZlFxVTdtT0Uza2JtQTVlMWRaQWZC?=
 =?utf-8?B?OVZLM3AvbDJQbGFUcnZzbDd0K1d0VFF1TWYvRzRvOXN3RmpQUE9RT01UZ0pE?=
 =?utf-8?B?YnFXMm5kYXp1THdxTHowOHJsYU9NRWd4bldoRVNZTFRCNms1d1dHSGxsOHZy?=
 =?utf-8?B?UGJ5THZ3U29BM3RyY0t4QUJBVmlCRGs1M2trdHQ0Mm5hZUpybkV5YUdYUmVp?=
 =?utf-8?B?Z1A2VExvbFJLMlVPeTlSWVQwVjVMcW1vMkFwWmlSMVFrYUovU0pMTFFOb3V0?=
 =?utf-8?B?eHBkSTFBTUpqTUxITTJXNnJyV0xXeEZiR2Izb3dqcytiS0tMS2VvN0FVWHhI?=
 =?utf-8?B?RHl0aGMwZlVRVFM1MUEwcEJia3VQS2pQQ1E0RFhlNnBHNVcrQzNnT2N0cEpF?=
 =?utf-8?B?ZGpRS0J5ZExnbmFkem9JZ1RVOWoySmsyWW1lTDJxaVVMSXRjUTlJVkh3RWxR?=
 =?utf-8?B?eGZtTjZwd3I4ZEJQRkxlYy85S0pRZTdZdjh2anRBZ1RrdmdTVVlQcklGdzNF?=
 =?utf-8?B?bWtTaXVpOUQ0M21LRHJmRmFKNWdjUU1kMWRVMGVDbVlCR2FUNFVBR0FrMFVx?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FA9B7B33553174E8D501AD3C660ECC3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f391acd6-71bc-4029-fde8-08dbdba80b01
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 13:31:38.8131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tKe5U1jkUuAf8hZVgFeACqklqiYroOdrDFafYvo3lDcAghUhXiYzE6MQZaXqB8vnlnqV1hqk0yPCVj/HZc7PwcpVbGaSla4tIJKs1qy6pEhK0eWaHc5yCl18bCjDgG9r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6955
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mDQoNCk9uIDMwLzEwLzIzIDg6MTUgcG0sIEtyenlzenRvZiBLb3psb3dza2kg
d3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMzAv
MTAvMjAyMyAxNDoxNiwgUGFydGhpYmFuLlZlZXJhc29vcmFuQG1pY3JvY2hpcC5jb20gd3JvdGU6
DQo+PiBIaSBLcnp5c3p0b2YsDQo+Pg0KPj4gT24gMjQvMTAvMjMgMTozMyBwbSwgS3J6eXN6dG9m
IEtvemxvd3NraSB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUN
Cj4+Pg0KPj4+IE9uIDIzLzEwLzIwMjMgMTc6NDYsIFBhcnRoaWJhbiBWZWVyYXNvb3JhbiB3cm90
ZToNCj4+Pj4gQWRkIERUIGJpbmRpbmdzIGZvciBNaWNyb2NoaXAncyBMQU44NjVYIDEwQkFTRS1U
MVMgTUFDUEhZLiBUaGUgTEFOODY1MC8xDQo+Pj4+IGNvbWJpbmVzIGEgTWVkaWEgQWNjZXNzIENv
bnRyb2xsZXIgKE1BQykgYW5kIGFuIEV0aGVybmV0IFBIWSB0byBlbmFibGUNCj4+Pj4gMTBCQVNF
4oCRVDFTIG5ldHdvcmtzLiBUaGUgRXRoZXJuZXQgTWVkaWEgQWNjZXNzIENvbnRyb2xsZXIgKE1B
QykgbW9kdWxlDQo+Pj4+IGltcGxlbWVudHMgYSAxMCBNYnBzIGhhbGYgZHVwbGV4IEV0aGVybmV0
IE1BQywgY29tcGF0aWJsZSB3aXRoIHRoZSBJRUVFDQo+Pj4+IDgwMi4zIHN0YW5kYXJkIGFuZCBh
IDEwQkFTRS1UMVMgcGh5c2ljYWwgbGF5ZXIgdHJhbnNjZWl2ZXIgaW50ZWdyYXRlZA0KPj4+PiBp
bnRvIHRoZSBMQU44NjUwLzEuIFRoZSBjb21tdW5pY2F0aW9uIGJldHdlZW4gdGhlIEhvc3QgYW5k
IHRoZSBNQUMtUEhZIGlzDQo+Pj4+IHNwZWNpZmllZCBpbiB0aGUgT1BFTiBBbGxpYW5jZSAxMEJB
U0UtVDF4IE1BQ1BIWSBTZXJpYWwgSW50ZXJmYWNlIChUQzYpLg0KPj4+DQo+Pj4gSXQgZG9lcyBu
b3QgbG9vayBsaWtlIHlvdSB0ZXN0ZWQgdGhlIGJpbmRpbmdzLCBhdCBsZWFzdCBhZnRlciBxdWlj
aw0KPj4+IGxvb2suIFBsZWFzZSBydW4gYG1ha2UgZHRfYmluZGluZ19jaGVja2AgKHNlZQ0KPj4+
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy93cml0aW5nLXNjaGVtYS5yc3QgZm9y
IGluc3RydWN0aW9ucykuDQo+Pj4gTWF5YmUgeW91IG5lZWQgdG8gdXBkYXRlIHlvdXIgZHRzY2hl
bWEgYW5kIHlhbWxsaW50Lg0KPj4gU29ycnksIHNvbWVob3cgSSBtaXNzZWQgZG9pbmcgdGhpcyBj
aGVjay4gV2lsbCBmaXggdGhpcyBpbiB0aGUgbmV4dA0KPj4gcmV2aXNpb24uDQo+IA0KPiBQbGVh
c2UgYWxzbyBidWlsZCB5b3VyIGRyaXZlci4NCkRpZG4ndCBzZWUgYW55IGVycm9yIGluIHRoZSBk
cml2ZXIgY29tcGlsYXRpb24uDQo+IA0KPj4+DQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFBh
cnRoaWJhbiBWZWVyYXNvb3JhbiA8UGFydGhpYmFuLlZlZXJhc29vcmFuQG1pY3JvY2hpcC5jb20+
DQo+Pj4+IC0tLQ0KPj4+PiAgICAuLi4vYmluZGluZ3MvbmV0L21pY3JvY2hpcCxsYW44NjV4Lnlh
bWwgICAgICAgfCAxMDEgKysrKysrKysrKysrKysrKysrDQo+Pj4+ICAgIE1BSU5UQUlORVJTICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+Pj4+ICAgIDIgZmlsZXMg
Y2hhbmdlZCwgMTAyIGluc2VydGlvbnMoKykNCj4+Pj4gICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvbWljcm9jaGlwLGxhbjg2NXgueWFt
bA0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL25ldC9taWNyb2NoaXAsbGFuODY1eC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL25ldC9taWNyb2NoaXAsbGFuODY1eC55YW1sDQo+Pj4+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQo+Pj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uOTc0NjIyZGQ2ODQ2DQo+Pj4+IC0tLSAv
ZGV2L251bGwNCj4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25l
dC9taWNyb2NoaXAsbGFuODY1eC55YW1sDQo+Pj4+IEBAIC0wLDAgKzEsMTAxIEBADQo+Pj4+ICsj
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkN
Cj4+Pj4gKyVZQU1MIDEuMg0KPj4+PiArLS0tDQo+Pj4+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVl
Lm9yZy9zY2hlbWFzL25ldC9taWNyb2NoaXAsbGFuODY1eC55YW1sIw0KPj4+PiArJHNjaGVtYTog
aHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+Pj4+ICsNCj4+
Pj4gK3RpdGxlOiBNaWNyb2NoaXAgTEFOODY1MC8xIDEwQkFTRS1UMVMgTUFDUEhZIEV0aGVybmV0
IENvbnRyb2xsZXJzDQo+Pj4+ICsNCj4+Pj4gK21haW50YWluZXJzOg0KPj4+PiArICAtIFBhcnRo
aWJhbiBWZWVyYXNvb3JhbiA8cGFydGhpYmFuLnZlZXJhc29vcmFuQG1pY3JvY2hpcC5jb20+DQo+
Pj4+ICsNCj4+Pj4gK2Rlc2NyaXB0aW9uOg0KPj4+PiArICBUaGUgTEFOODY1MC8xIGNvbWJpbmVz
IGEgTWVkaWEgQWNjZXNzIENvbnRyb2xsZXIgKE1BQykgYW5kIGFuIEV0aGVybmV0DQo+Pj4+ICsg
IFBIWSB0byBlbmFibGUgMTBCQVNF4oCRVDFTIG5ldHdvcmtzLiBUaGUgRXRoZXJuZXQgTWVkaWEg
QWNjZXNzIENvbnRyb2xsZXINCj4+Pj4gKyAgKE1BQykgbW9kdWxlIGltcGxlbWVudHMgYSAxMCBN
YnBzIGhhbGYgZHVwbGV4IEV0aGVybmV0IE1BQywgY29tcGF0aWJsZQ0KPj4+PiArICB3aXRoIHRo
ZSBJRUVFIDgwMi4zIHN0YW5kYXJkIGFuZCBhIDEwQkFTRS1UMVMgcGh5c2ljYWwgbGF5ZXIgdHJh
bnNjZWl2ZXINCj4+Pj4gKyAgaW50ZWdyYXRlZCBpbnRvIHRoZSBMQU44NjUwLzEuIFRoZSBjb21t
dW5pY2F0aW9uIGJldHdlZW4gdGhlIEhvc3QgYW5kDQo+Pj4+ICsgIHRoZSBNQUMtUEhZIGlzIHNw
ZWNpZmllZCBpbiB0aGUgT1BFTiBBbGxpYW5jZSAxMEJBU0UtVDF4IE1BQ1BIWSBTZXJpYWwNCj4+
Pj4gKyAgSW50ZXJmYWNlIChUQzYpLg0KPj4+PiArDQo+Pj4+ICsgIFNwZWNpZmljYXRpb25zIGFi
b3V0IHRoZSBMQU44NjUwLzEgY2FuIGJlIGZvdW5kIGF0Og0KPj4+PiArICAgIGh0dHBzOi8vd3d3
Lm1pY3JvY2hpcC5jb20vZW4tdXMvcHJvZHVjdC9sYW44NjUwDQo+Pj4+ICsNCj4+Pj4gK2FsbE9m
Og0KPj4+PiArICAtICRyZWY6IGV0aGVybmV0LWNvbnRyb2xsZXIueWFtbCMNCj4+Pj4gKw0KPj4+
PiArcHJvcGVydGllczoNCj4+Pj4gKyAgY29tcGF0aWJsZToNCj4+Pj4gKyAgICBjb25zdDogbWlj
cm9jaGlwLGxhbjg2NXgNCj4+Pg0KPj4+IE5vIHdpbGRjYXJkcyBpbiBjb21wYXRpYmxlcy4NCj4+
IEFoIG9rIG1pc3NlZCBpdC4gU28gaXQgd2lsbCBiZWNvbWUgbGlrZSBiZWxvdyBpc24ndCBpdD8N
Cj4+DQo+PiBwcm9wZXJ0aWVzOg0KPj4gICAgIGNvbXBhdGlibGU6DQo+PiAgICAgICBlbnVtOg0K
Pj4gICAgICAgICAtIG1pY3JvY2hpcCxsYW44NjUwDQo+PiAgICAgICAgIC0gbWljcm9jaGlwLGxh
bjg2NTENCj4gDQo+IFJhdGhlciBlbnVtIGZvciBsYW44NjUwIGFuZCBpdGVtcyBmb3IgbGFuODY1
MSB3aXRoIGZhbGxiYWNrLiBBcmVuJ3QgdGhleQ0KPiBjb21wYXRpYmxlLCBzaW5jZSB5b3Ugd2Fu
dGVkIHRvIHVzZSB3aWxkY2FyZD8NClNvIGRvIHlvdSBtZWFuIGxpa2UgYmVsb3c/DQoNCnByb3Bl
cnRpZXM6DQogICBjb21wYXRpYmxlOg0KICAgICBvbmVPZjoNCiAgICAgICAtIGl0ZW1zOg0KICAg
ICAgICAgICAtIGNvbnN0OiBtaWNyb2NoaXAsbGFuODY1MA0KICAgICAgICAgICAtIGNvbnN0OiBt
aWNyb2NoaXAsbGFuODY1MQ0KICAgICAgIC0gZW51bToNCiAgICAgICAgICAgLSBtaWNyb2NoaXAs
bGFuODY1MA0KDQpCZXN0IFJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4gDQo+IEJlc3QgcmVn
YXJkcywNCj4gS3J6eXN6dG9mDQo+IA0KDQo=

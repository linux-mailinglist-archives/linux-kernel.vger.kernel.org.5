Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AEC7E0526
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjKCO7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKCO7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:59:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BDAD47;
        Fri,  3 Nov 2023 07:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1699023572; x=1730559572;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=T0xCBejfemeeN9KhWaHyf6BibVO3J+RBtl3cWQ176Os=;
  b=WDKkxRHwD+loZenVCgM/AoveSg8ri5vB8YclWCKqDs27z0RT9qsv82/6
   ue+vVpCfU1HHUZxaeRg5nmYkIqq3+Cqkf9WK3DKLE63BZz5kodHJG+I8q
   Ar6JKwlCzu1i/4q6B8CHK3uQ9bDdMx43ojnB8533tLICwd6LtggwMz2Ni
   dXGTenGbL8eRYHQ82B5HuNXrU6l2q8yCfJiD26D+o5tlPBmm7Z41H6iUq
   Ezc+wSF+nP82V2PuxmDZHKf0uwhotjC5Ad4O9+2y8mPFf2E+/fDgo3J/4
   9qw/yWH//3EbWeUXneS50At8rAhkuu8eyjFE9Y1N5dUjp80JlSWaqAGTy
   w==;
X-CSE-ConnectionGUID: jYyfhgmDQReMm3B1mKEEng==
X-CSE-MsgGUID: a7TYWsLYTRu1ojlfG0PYOg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="11092637"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Nov 2023 07:59:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Nov 2023 07:59:04 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 3 Nov 2023 07:59:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkNP3zA7mp0g+PrmaRAFaedaF54ai+DxC6UmuaUKzeMdumpfUkcYekF9p4nSZFRS2yfcx5BgLcf0jaBX+mxGUtYJbT7jDaP0j5WcWbwvDKG8weANFYkUCsc9QbNw30a4/lIc/WXKftiQZg6luiO4+t3N7dc2o4m20QYj8jwwkd5Oioht9ihrNtEIT5oHJw4YvZsC7EYzQdVvHmsuYIi1g16ouy3/vNfZCXsZwSbf2NAMXTGlw74jNpFAVbLyTYEyAEjroWLhEQBvkMlk7RYdJS3vWnKEYNhAmglR5SgPV/jkzFxWDLLu1fiEfh9UZ7WljnWPkuixU9aEnfF1yFNwPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0xCBejfemeeN9KhWaHyf6BibVO3J+RBtl3cWQ176Os=;
 b=iwEtr07n0FdC4zoRdK8tdrw6hgONrTgbyqXZrEj8tEMiYi3SRGn3PKAk9hOI7hLON1Xt7daRbOIGwuyWsTYCjyKP8X9bI8j/cYeMglbZvxgYTqgBdym7EApfo/g8QHvzK8/pJnKS+ADrxn0GElAlh5J6mtbjBnsipDJoWqxHOZlHc6SdVxTvXPqczrCDVFs3JKyyQ3NkFbfb+hN+y9xXB1CDxisNNswPDa6uxslxFtmN365xCrwXBcaNU4Q2uG8pKDFfWtaEF7G+atvv5wwoQ/uP2H8/ALLDcRcUQuRcfOzW580ENZIhqhPR3n7HP9XknOnrMekmeRizZ0tmR8qADQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0xCBejfemeeN9KhWaHyf6BibVO3J+RBtl3cWQ176Os=;
 b=G46GkxEobdj0C0u3+HBCsBkMNG5q72XYvh6aG/pS63gc98NFdtiVQgVXkAOI2OM1tYjmySjlK5an07Atnvbo7iNKxjaA6EKxS1q5fmO6vTOonxGR/Szq7oSzkIpMv4nt9YmAbvB1DpsQ5opQqoII3/E97NCtlDWzfYhRZtxSiSY=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.21; Fri, 3 Nov 2023 14:59:02 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::595f:f69d:149d:510]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::595f:f69d:149d:510%5]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 14:59:02 +0000
From:   <Parthiban.Veerasooran@microchip.com>
To:     <ramon.nordin.rodriguez@ferroamp.se>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <Steen.Hegelund@microchip.com>,
        <rdunlap@infradead.org>, <horms@kernel.org>,
        <casper.casan@gmail.com>, <andrew@lunn.ch>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <Horatiu.Vultur@microchip.com>, <Woojung.Huh@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <Thorsten.Kummermehr@microchip.com>
Subject: Re: [PATCH net-next v2 8/9] microchip: lan865x: add driver support
 for Microchip's LAN865X MACPHY
Thread-Topic: [PATCH net-next v2 8/9] microchip: lan865x: add driver support
 for Microchip's LAN865X MACPHY
Thread-Index: AQHaBciCW59pjIMQmUKn/gKExYJHR7BnAmyAgAG+mYA=
Date:   Fri, 3 Nov 2023 14:59:01 +0000
Message-ID: <aa175902-560c-4fad-9e0b-aa4efa0482c2@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-9-Parthiban.Veerasooran@microchip.com>
 <ZUOUGf-PMGo8z1s-@debian>
In-Reply-To: <ZUOUGf-PMGo8z1s-@debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|DM8PR11MB5573:EE_
x-ms-office365-filtering-correlation-id: d9fba55a-f0df-4070-4e0e-08dbdc7d6a99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D0QAMDCsy/hT/FcjA2O/IHs6+N1G50bTGrJpwta/I7cd33+jEhcZTKq9hw8oJJdoQFeuM9ZceQXf4+zMdhsNfEMC3R2l1UEPHajUp1lZfr2WGX2galhPlPiRk6s3/Gaf5a61FnL5xnLih9xMysLzd1g/nCXWslOr/+Rcoy1PQbuUBwhcx+gLUYWuedn9ti+TSt7k1taKKYQOoM79MBT079aOtCfAv8qHjGFcZ/B5PiBR0ydasQbrbL0pSwnZLqtDYn9fBkWaalcYXjjnumXk5U4+WX2+m29zPXeZYRelKrB/SrMUn+CP1gyWQAXCQLzl8OdlWRqUlrKqY8vnvg73cSxn7CNFgfWcpXHFoZiXY4lwdSnbETgM9lH0zS/Lk9JgUG6L9ojaWvVFDK5v8tDTpkbuxsJowNOZ+ZWyCOSq72PM0eufs7Op9Eiew0Ygic5QjHGwAtyVtw52hvC4MuD18M2OgVhxv9K14PtpcmV2UQhWfeVT9jR/1112Q65E16BNsOoc0Hf3ZZBRFafeijtIJp2d5tRdnCfU+9Gf2Qze6MteAC7pGRILJSItzanEVSsxbIUhwZu8GFZfAh8NG29BXSTQwftakO7MYD6jPBxZsGqXVwZNMT4rYwWVntGh8UcAAS3jp4O2dN/yQcpgP3w6j/twq2ToT8NVAE5lM1J5vuAOaqXxgXzxl6zsdlSD6qsm4dP4DbAgTUZO402Vxk2Xw87LJu7funPj6MDvrG7ZkF4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(136003)(396003)(346002)(230273577357003)(230922051799003)(230173577357003)(64100799003)(186009)(451199024)(1800799009)(53546011)(8676002)(4326008)(64756008)(91956017)(54906003)(6916009)(66446008)(66556008)(66946007)(316002)(66476007)(76116006)(45080400002)(31686004)(7416002)(5660300002)(8936002)(2906002)(122000001)(478600001)(66574015)(83380400001)(6486002)(107886003)(26005)(86362001)(31696002)(2616005)(36756003)(71200400001)(6506007)(6512007)(41300700001)(38100700002)(38070700009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmpHQ1doZmROYXRZZWdBL0QwM3JJSUZnWSs4QlhGWDZyY05IdG5YQ3l0N2xq?=
 =?utf-8?B?Uk1IemJ2VDV4M3VsbnJpTFdyZWZJRjVJcmRJQ0hMRTJHbXIxbk02UVM1cWRX?=
 =?utf-8?B?eHVmL0lPdVg3RXVnTmlSV1pDWEFRK3NDbXgwaWFWeERvejJSbFhncTdJSEN5?=
 =?utf-8?B?RDJCZXlSQVc3ekhFcndEWU11SVlVbm9UdVZ6NHVYTDdwZ0RkQ0NwNTJMMHZw?=
 =?utf-8?B?K0RUYUc2U1h4MkZpdGl1VFJaS2NXS2h1TlB6TDlkcnlnL3NZV1hpelV0QWN3?=
 =?utf-8?B?eGVaZjNyaU02b3FQK2RVZEFoTDdDNmpnMS9XNmUxYWF3cmJPTHJDU2thaWJk?=
 =?utf-8?B?U1grUmZ6RHJqTVNqc3JHTWovMFgwSGVWV0JoamlxeTFwTllDYUhvUW9iTUlI?=
 =?utf-8?B?KzVKQXl4YjR2S0JnTUY4Yzh3R0V6Ni9lWno2VDV3Q1BwSU5ZSFJ4YnQ5dHZX?=
 =?utf-8?B?eTN4SHlOYmFySmN0TnRKTnF0RXlJbFUreVlJQzVHcC9iK0dXSDNGeFRMNlU0?=
 =?utf-8?B?a3RrNEw2U2lJTE8vaEV0c2V2ZFA0U3JvUXlXL2JnbmdvbWwweG5IU1Z4a1lJ?=
 =?utf-8?B?dkpwNUIxME92ekF1MWd6YVM5RjVOZWtCYXFPK0V5bGFxSlo4K1FYZEpQS3B6?=
 =?utf-8?B?VHFMMG8xMTQvVFVDeHVmdk0rc0lSZ1FrdGhVMXlBdUZKMS9NQnl4bXlqdG5u?=
 =?utf-8?B?NzZDL21VWDdsbm1IY3hib3pvRnpGYnR4V0NONFBsRXJHVkt3eVZlYmpDNXdy?=
 =?utf-8?B?TjBEcjlrNnhTcitlb2xzWmhhdGN0V1NPMERGdnltNTRVcHdxZWJwQ0Y2bVF0?=
 =?utf-8?B?RDVRMmwvZmRrSjV6QUpwbmtLNzRkQmtmS2lneGQ4UFlKd2pjWG4ySTlpM0V1?=
 =?utf-8?B?UDVhQUhuUklTaDMyV2I5YldLNVJkcGNVL2hUZzlJVldycDRQUENCWVBvYzhv?=
 =?utf-8?B?amZBMmMzSlRZSWVqVXIvZnpCcmdCSnRMT2NhNzQ1Um1BVXNpTkZvREFwWExx?=
 =?utf-8?B?QXZnbDduRCtoaitsdit3U0RqbER3NWFJNElEWnRFRnkydytSbG1VeXBzUDVX?=
 =?utf-8?B?YWc0TVJQamZLVTVqcW5LUW12dUpkc2xxV2Rnd0VXMlhhbVhVZjFUSXdNLzRC?=
 =?utf-8?B?enZPM2VHb1o4Mk5PTFNlaHlDYzZBZHpxYnI1OTgxbHRqUmhsOGVyVzlLbW5P?=
 =?utf-8?B?QjJQR0JMdy9lQW1IbTd6MEh5cndwaERvVGozbllmOHdxR2R3VFFhTjhzTlEr?=
 =?utf-8?B?VDQ0QVRkVFFlMGpBSmVsekp3R0QzVjhVM2MrWEREMmhNdDdIbm1wYkx3Y3M3?=
 =?utf-8?B?cEpxa1lHUmJ2YXhtMHhaUnVpOGlIUDFZQzNIQnp5eGdPMW1aL0pnbjhqc3Rh?=
 =?utf-8?B?SnRkMk5UcVhXekNyc0N1Vk1QSzQ1d3ZDSzFKc3hWZWlrOGZ0bExaaXA1NUFR?=
 =?utf-8?B?WTJWRExXUlRUajdYd3hSb01jTTRiRm1mWXd6UnBhMXBnaFNiYVAxOHdZRC9m?=
 =?utf-8?B?RytlcTJxM1M0TEVValVrMGhEaEtSU3VJRHdpWmFYcjhWZHkxVVkyQlR2ZjBI?=
 =?utf-8?B?b1NtY1U1bXNIcEd1TWFhaS9Db0JHbmhDZGZ0TmdHREZPZmIwOWMyUG1OVXRu?=
 =?utf-8?B?WGZpTzMxYXZuZ0ZpU3V3c2g5bXFwVkRHMWJhNWd3bFh4b1lOTll6Q1JCRnFT?=
 =?utf-8?B?bGNRNEprSUJhQVREU0JTWUdFS1laOFFDd2tpM3Jqb2JEamluZVNpQlNHVTRh?=
 =?utf-8?B?TERPbTZYbnVQQi9adVNEaS9jcW45OTI3RERSTjVCa0xsdGlkTzJiZ0wxRDhy?=
 =?utf-8?B?eW4vaC95YUxadnhoTWZGamFCY0E2WG9rUUpkNWZmTkQ4cE95VHoxQWRRS1Fo?=
 =?utf-8?B?UHNKa2RBZFNlWGdtSGxqQitjVHpQUHJwMi90RHJ3aG5jQm1WdXFmZWt5QlZI?=
 =?utf-8?B?RzZXaXNIN3VXeXVHeGNCVXJLREsyTHp3eEJOeEJvUU5STm51VDF5YlZFMlFD?=
 =?utf-8?B?b3RPWDdjMWs1S1VFaHBiOExBbG03RW1aSEJvdGlPTDdBYmZjSThEUzU5bmVW?=
 =?utf-8?B?NjdyOFpodlpmSGxoY3JIMFZycTVWT0lBcEE5czUxaGloMXo1RUdZM2ZMWVd5?=
 =?utf-8?B?ZGZxY2lrb3ZqVWxhREZvd0JFNS9IUE5uMjNFb09EdzhWOE5kdzA2V25NL0Rj?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D52991B5AD27EC4EBC1214DF8416B9F0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fba55a-f0df-4070-4e0e-08dbdc7d6a99
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 14:59:01.9984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UmfVRgEs6eCijOeCbT9Uk941gbHDpRnre/K+S3hDlTH08Tm7QjmX4zkIKchuaHMGBCTHL0PC2Fgzs/0xl3yt4o4VIg750WzxfT7qA9saAs3cM66LAuOGhl6Qi9uiWgKO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5573
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmFtb24sDQoNCk9uIDAyLzExLzIzIDU6NTAgcG0sIFJhbcOzbiBOb3JkaW4gUm9kcmlndWV6
IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIE1v
biwgT2N0IDIzLCAyMDIzIGF0IDA5OjE2OjQ4UE0gKzA1MzAsIFBhcnRoaWJhbiBWZWVyYXNvb3Jh
biB3cm90ZToNCj4+IFRoZSBMQU44NjUwLzEgaXMgZGVzaWduZWQgdG8gY29uZm9ybSB0byB0aGUg
T1BFTiBBbGxpYW5jZSAxMEJBU0XigJFUMXgNCj4+IE1BQ+KAkVBIWSBTZXJpYWwgSW50ZXJmYWNl
IHNwZWNpZmljYXRpb24sIFZlcnNpb24gMS4xLiBUaGUgSUVFRSBDbGF1c2UgNA0KPj4gTUFDIGlu
dGVncmF0aW9uIHByb3ZpZGVzIHRoZSBsb3cgcGluIGNvdW50IHN0YW5kYXJkIFNQSSBpbnRlcmZh
Y2UgdG8gYW55DQo+PiBtaWNyb2NvbnRyb2xsZXIgdGhlcmVmb3JlIHByb3ZpZGluZyBFdGhlcm5l
dCBmdW5jdGlvbmFsaXR5IHdpdGhvdXQNCj4+IHJlcXVpcmluZyBNQUMgaW50ZWdyYXRpb24gd2l0
aGluIHRoZSBtaWNyb2NvbnRyb2xsZXIuIFRoZSBMQU44NjUwLzENCj4+IG9wZXJhdGVzIGFzIGFu
IFNQSSBjbGllbnQgc3VwcG9ydGluZyBTQ0xLIGNsb2NrIHJhdGVzIHVwIHRvIGEgbWF4aW11bSBv
Zg0KPj4gMjUgTUh6LiBUaGlzIFNQSSBpbnRlcmZhY2Ugc3VwcG9ydHMgdGhlIHRyYW5zZmVyIG9m
IGJvdGggZGF0YSAoRXRoZXJuZXQNCj4+IGZyYW1lcykgYW5kIGNvbnRyb2wgKHJlZ2lzdGVyIGFj
Y2VzcykuDQo+Pg0KPj4gQnkgZGVmYXVsdCwgdGhlIGNodW5rIGRhdGEgcGF5bG9hZCBpcyA2NCBi
eXRlcyBpbiBzaXplLiBBIHNtYWxsZXIgcGF5bG9hZA0KPj4gZGF0YSBzaXplIG9mIDMyIGJ5dGVz
IGlzIGFsc28gc3VwcG9ydGVkIGFuZCBtYXkgYmUgY29uZmlndXJlZCBpbiB0aGUNCj4+IENodW5r
IFBheWxvYWQgU2l6ZSAoQ1BTKSBmaWVsZCBvZiB0aGUgQ29uZmlndXJhdGlvbiAwIChPQV9DT05G
SUcwKQ0KPj4gcmVnaXN0ZXIuIENoYW5naW5nIHRoZSBjaHVuayBwYXlsb2FkIHNpemUgcmVxdWly
ZXMgdGhlIExBTjg2NTAvMSBiZSByZXNldA0KPj4gYW5kIHNoYWxsIG5vdCBiZSBkb25lIGR1cmlu
ZyBub3JtYWwgb3BlcmF0aW9uLg0KPj4NCj4+IFRoZSBFdGhlcm5ldCBNZWRpYSBBY2Nlc3MgQ29u
dHJvbGxlciAoTUFDKSBtb2R1bGUgaW1wbGVtZW50cyBhIDEwIE1icHMNCj4+IGhhbGYgZHVwbGV4
IEV0aGVybmV0IE1BQywgY29tcGF0aWJsZSB3aXRoIHRoZSBJRUVFIDgwMi4zIHN0YW5kYXJkLg0K
Pj4gMTBCQVNFLVQxUyBwaHlzaWNhbCBsYXllciB0cmFuc2NlaXZlciBpbnRlZ3JhdGVkIGludG8g
dGhlIExBTjg2NTAvMS4gVGhlDQo+PiBQSFkgYW5kIE1BQyBhcmUgY29ubmVjdGVkIHZpYSBhbiBp
bnRlcm5hbCBNZWRpYSBJbmRlcGVuZGVudCBJbnRlcmZhY2UNCj4+IChNSUkpLg0KPj4NCj4+IFNp
Z25lZC1vZmYtYnk6IFBhcnRoaWJhbiBWZWVyYXNvb3JhbiA8UGFydGhpYmFuLlZlZXJhc29vcmFu
QG1pY3JvY2hpcC5jb20+DQo+IA0KPiBIaSBQYXJ0aGliYW4NCj4gDQo+IEkndmUgYmVlbiB0ZXN0
aW5nIHRoZSB2MiBwYXRjaGVzIG91dCBhIGJpdCwgYXQgRmVycm9hbXAgd2UncmUgcGxhbm5pbmcN
Cj4gb24gdXNpbmcgYSBkdWFsIExBTjg2NTAgc2V0dXAgaW4gYSBwcm9kdWN0Lg0KSSB1bmRlcnN0
YW5kIHRoYXQgeW91IGFyZSB1c2luZyB0d28gTEFOODY1MCwgaXNuJ3QgaXQ/IGlmIHNvIGFyZSB0
aGV5IA0KYm90aCBydW5uaW5nIHNpbXVsdGFuZW91c2x5PyBvciB5b3UgYXJlIGRvaW5nIHRoZSB0
ZXN0aW5nIHdpdGggb25lIGFsb25lPw0KPiANCj4gRmlyc3QgbGV0IG1lIHNheSB0aGF0IHdlJ2Qg
YmUgaGFwcHkgdG8gYXNzaXN0IHdpdGggdGVzdGluZyBhbmQNCj4gZGV2ZWxvcG1lbnQuDQpUaGFu
ayB5b3UgZm9yIHlvdXIgc3VwcG9ydCBvbiB0aGlzLg0KPiANCj4gSSBnb3Qgc29tZSBvYnNlcnZh
dGlvbnMgdGhhdCBJIHRoaW5rIHRoaXMgcGF0Y2ggaXMgdGhlIHJlc29uYWJsZSBwbGFjZQ0KPiB0
byBkaXNjdXNzIGl0LCBzaW5jZSB0aGV5IHNlZW0gdG8gYmUgTUFDL1BIWSByZWxhdGVkLg0KPiAN
Cj4gSW4gb3JkZXIgdG8gZ2V0IGEgcmVsaWFibGUgbGluayBJJ20gdXNpbmcgdGhlIGR0cyBzbmlw
cGV0IGJlbG93IChmb3IgYW4NCj4gaW14OCBjcHUpDQo+IA0KPiAmZWNzcGkxIHsNCj4gICAgICAg
ICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gICAgICAgICAgcGluY3RybC0wID0gPCZw
aW5jdHJsX2Vjc3BpMT47DQo+ICAgICAgICAgIGNzLWdwaW9zID0gPDA+ICwgPCZncGlvNSA5IEdQ
SU9fQUNUSVZFX0xPVz47DQo+ICAgICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4gDQo+ICAgICAg
ICAgIHNwZTE6IGV0aGVybmV0QDF7DQo+ICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJt
aWNyb2NoaXAsbGFuODY1eCI7DQo+ICAgICAgICAgICAgICAgICAgcmVnID0gPDE+Ow0KPiAgICAg
ICAgICAgICAgICAgIGludGVycnVwdC1wYXJlbnQgPSA8JmdwaW81PjsNCj4gICAgICAgICAgICAg
ICAgICBpbnRlcnJ1cHRzID0gPDAgSVJRX1RZUEVfRURHRV9GQUxMSU5HPjsNCj4gICAgICAgICAg
ICAgICAgICBzcGktbWF4LWZyZXF1ZW5jeSA9IDw1MDAwMDAwMD47DQo+ICAgICAgICAgICAgICAg
ICAgb2EtdGM2ew0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8
MT47DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgIG9hLWNwcyA9IDwzMj47DQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICBvYS1wcm90ZTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIG9hLWRwcmFjOw0K
PiAgICAgICAgICAgICAgICAgIH07DQo+ICAgICAgICAgIH07DQo+IH07DQo+IA0KPiBXaXRoIHRo
aXMgc2V0dXAgSSdtIGdldHRpbmcgYSBtYXhpbXVtIHRocm91Z2hwdXQgb2YgYWJvdXQgOTBrQi9z
Lg0KPiBJZiBJIGluY3JlYXNlIHRoZSBjaHVuayBzaXplIC8gb2EtY3BzIHRvIDY0IEkgZ2V0IGEg
bWlnaHQgaGlnaGVyDQo+IHRocm91Z2hwdXQgfjkwMGtCL3MsIGJ1dCBhZnRlciAwLTJzIEkgZ2V0
IGR1bXAgYmVsb3cgKG9yIHNpbWlsYXIpLg0KRGlkIHlvdSBvciBwb3NzaWJsZSB0byB0cnkgYSB0
ZXN0IGNhc2Ugd2l0aCBiZWxvdyBjb25maWd1cmF0aW9uPw0KDQotIFNpbmdsZSBMQU44NjUwIGVu
YWJsZWQNCi0gVURQDQotIG9hX2NwcyA9IDY0DQotIHNwaS1tYXgtZnJlcXVlbmN5ID0gMTUwMDAw
MDAsDQoNCkRpZCB5b3UgcnVuIGlwZXJmMyB0ZXN0PyBvciBhbnkgb3RoZXIgdG9vbD8NCklmIGlw
ZXJmMyB0aGVuIGNhbiB5b3Ugc2hhcmUgdGhlIGNvbmZpZ3VyYXRpb24geW91IHVzZWQ/DQoNCkkg
ZG9uJ3Qga25vdyB3aGV0aGVyIHRoZXNlIG1heSBhdWRpZW5jZXMgYXJlIG5lZWRlZCBpbiB0aGUg
Q0MgZm9yIHRoaXMgDQp0aHJlYWQuIExldCdzIHNlZSB3aGF0J3MgQW5kcmV3IEx1bm4gdGhpbmtz
IGFib3V0IGl0Pw0KDQpCZXN0IFJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4gWyAgMzYzLjQ0
NDQ2MF0gZXRoMDogVHJhbnNtaXQgcHJvdG9jb2wgZXJyb3INCj4gWyAgMzYzLjQ0ODUyN10gZXRo
MDogVHJhbnNtaXQgYnVmZmVyIHVuZGVyZmxvdw0KPiBbICAzNjMuNDUyNzQwXSBldGgwOiBSZWNl
aXZlIGJ1ZmZlciBvdmVyZmxvdw0KPiBbICAzNjMuNDU2NzgwXSBldGgwOiBIZWFkZXIgZXJyb3IN
Cj4gWyAgMzYzLjQ1OTg2OV0gZXRoMDogRm9vdGVyIGZyYW1lIGRyb3ANCj4gWyAgMzYzLjQ2MzM3
OV0gZXRoMDogU1BJIHRyYW5zZmVyIGZhaWxlZA0KPiBbICAzNjMuNDcwNTkwXSBldGgwOiBSZWNl
aXZlIGJ1ZmZlciBvdmVyZmxvdw0KPiBbICAzNjMuNDc0NjMxXSBldGgwOiBIZWFkZXIgZXJyb3IN
Cj4gWyAgMzYzLjQ3Nzc3Nl0gZXRoMDogU1BJIHRyYW5zZmVyIGZhaWxlZA0KPiBbICAzNjMuNDgy
NTk2XSBldGgwOiBGb290ZXIgZnJhbWUgZHJvcA0KPiBbICAzNjkuODg0NjgwXSAtLS0tLS0tLS0t
LS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0NCj4gWyAgMzY5Ljg4OTMzNl0gTkVUREVWIFdBVENI
RE9HOiBldGgwIChsYW44NjV4KTogdHJhbnNtaXQgcXVldWUgMCB0aW1lZCBvdXQgNjQ0OCBtcw0K
PiBbICAzNjkuODk2NzI2XSBXQVJOSU5HOiBDUFU6IDEgUElEOiAwIGF0IG5ldC9zY2hlZC9zY2hf
Z2VuZXJpYy5jOjUyNSBkZXZfd2F0Y2hkb2crMHgyMmMvMHgyMzQNCj4gWyAgMzY5LjkwNTAyM10g
TW9kdWxlcyBsaW5rZWQgaW46DQo+IFsgIDM2OS45MDgwOTFdIENQVTogMSBQSUQ6IDAgQ29tbTog
c3dhcHBlci8xIE5vdCB0YWludGVkIDYuNC4xNi1nYzVlOGFhOTU4NmQ2ICMzDQo+IFsgIDM2OS45
MTUyNDFdIEhhcmR3YXJlIG5hbWU6IDxGZXJyb2FtcCBkZXYga2l0Pg0KPiBbICAzNjkuOTIxMTY5
XSBwc3RhdGU6IDYwMDAwMDA1IChuWkN2IGRhaWYgLVBBTiAtVUFPIC1UQ08gLURJVCAtU1NCUyBC
VFlQRT0tLSkNCj4gWyAgMzY5LjkyODE0Nl0gcGMgOiBkZXZfd2F0Y2hkb2crMHgyMmMvMHgyMzQN
Cj4gWyAgMzY5LjkzMjE2OF0gbHIgOiBkZXZfd2F0Y2hkb2crMHgyMmMvMHgyMzQNCj4gWyAgMzY5
LjkzNjE5MF0gc3AgOiBmZmZmODAwMDA4MDBiZTIwDQo+IFsgIDM2OS45Mzk1MTBdIHgyOTogZmZm
ZjgwMDAwODAwYmUyMCB4Mjg6IDAwMDAwMDAwMDAwMDAxMDEgeDI3OiBmZmZmODAwMDA4MDBiZjAw
DQo+IFsgIDM2OS45NDY2NjVdIHgyNjogZmZmZjgwMDAwOTI0NjljMCB4MjU6IDAwMDAwMDAwMDAw
MDE5MzAgeDI0OiBmZmZmODAwMDA5MjQ2MDAwDQo+IFsgIDM2OS45NTM4MTddIHgyMzogMDAwMDAw
MDAwMDAwMDAwMCB4MjI6IGZmZmYwMDAwMDBlODgzZGMgeDIxOiBmZmZmMDAwMDAwZTg4MDAwDQo+
IFsgIDM2OS45NjA5NzFdIHgyMDogZmZmZjAwMDAwMTBkYzAwMCB4MTk6IGZmZmYwMDAwMDBlODg0
ODggeDE4OiBmZmZmZmZmZmZmZmZmZmZmDQo+IFsgIDM2OS45NjgxMjRdIHgxNzogMzgzNDM0MzYy
MDc0NzU2ZiB4MTY6IDIwNjQ2NTZkNjk3NDIwMzAgeDE1OiAwNzIwMDcyMDA3MjAwNzIwDQo+IFsg
IDM2OS45NzUyNzZdIHgxNDogMDcyMDA3MjAwNzIwMDcyMCB4MTM6IGZmZmY4MDAwMDkyNWZlODgg
eDEyOiAwMDAwMDAwMDAwMDAwNDQ0DQo+IFsgIDM2OS45ODI0MzFdIHgxMTogMDAwMDAwMDAwMDAw
MDE2YyB4MTA6IGZmZmY4MDAwMDkyYjdlODggeDkgOiBmZmZmODAwMDA5MjVmZTg4DQo+IFsgIDM2
OS45ODk1ODRdIHg4IDogMDAwMDAwMDBmZmZmZWZmZiB4NyA6IGZmZmY4MDAwMDkyYjdlODggeDYg
OiA4MDAwMDAwMGZmZmZmMDAwDQo+IFsgIDM2OS45OTY3MzhdIHg1IDogMDAwMDAwMDAwMDAwMDAw
MCB4NCA6IDAwMDAwMDAwMDAwMDAwMDAgeDMgOiAwMDAwMDAwMDAwMDAwMDAwDQo+IFsgIDM3MC4w
MDM4OTBdIHgyIDogMDAwMDAwMDAwMDAwMDAwMCB4MSA6IDAwMDAwMDAwMDAwMDAwMDAgeDAgOiBm
ZmZmMDAwMDAwMGRkNDAwDQo+IFsgIDM3MC4wMTEwNDRdIENhbGwgdHJhY2U6DQo+IFsgIDM3MC4w
MTM0OTZdICBkZXZfd2F0Y2hkb2crMHgyMmMvMHgyMzQNCj4gWyAgMzcwLjAxNzE3M10gIGNhbGxf
dGltZXJfZm4uY29uc3Rwcm9wLjArMHgyNC8weDgwDQo+IFsgIDM3MC4wMjE4MDJdICBfX3J1bl90
aW1lcnMucGFydC4wKzB4MWY4LzB4MjQ0DQo+IFsgIDM3MC4wMjYwODBdICBydW5fdGltZXJfc29m
dGlycSsweDNjLzB4NzQNCj4gWyAgMzcwLjAzMDAxMl0gIF9fZG9fc29mdGlycSsweDEwYy8weDI4
MA0KPiBbICAzNzAuMDMzNjgzXSAgX19fX2RvX3NvZnRpcnErMHgxMC8weDFjDQo+IFsgIDM3MC4w
MzczNTddICBjYWxsX29uX2lycV9zdGFjaysweDI0LzB4NGMNCj4gWyAgMzcwLjA0MTI5Ml0gIGRv
X3NvZnRpcnFfb3duX3N0YWNrKzB4MWMvMHgyOA0KPiBbICAzNzAuMDQ1NDg0XSAgX19pcnFfZXhp
dF9yY3UrMHhlNC8weDEwMA0KPiBbICAzNzAuMDQ5MjQ0XSAgaXJxX2V4aXRfcmN1KzB4MTAvMHgx
Yw0KPiBbICAzNzAuMDUyNzQ0XSAgZWwxX2ludGVycnVwdCsweDM4LzB4NjgNCj4gWyAgMzcwLjA1
NjMzMV0gIGVsMWhfNjRfaXJxX2hhbmRsZXIrMHgxOC8weDI0DQo+IFsgIDM3MC4wNjA0MzldICBl
bDFoXzY0X2lycSsweDY0LzB4NjgNCj4gWyAgMzcwLjA2Mzg1MV0gIGNwdWlkbGVfZW50ZXJfc3Rh
dGUrMHgxMzQvMHgyZTANCj4gWyAgMzcwLjA2ODEzM10gIGNwdWlkbGVfZW50ZXIrMHgzOC8weDUw
DQo+IFsgIDM3MC4wNzE3MTldICBkb19pZGxlKzB4MWY0LzB4MjY0DQo+IFsgIDM3MC4wNzQ5NjBd
ICBjcHVfc3RhcnR1cF9lbnRyeSsweDI0LzB4MmMNCj4gWyAgMzcwLjA3ODg5NV0gIHNlY29uZGFy
eV9zdGFydF9rZXJuZWwrMHgxMzAvMHgxNTANCj4gWyAgMzcwLjA4MzQ0MF0gIF9fc2Vjb25kYXJ5
X3N3aXRjaGVkKzB4YjgvMHhiYw0KPiBbICAzNzAuMDg3NjM0XSAtLS1bIGVuZCB0cmFjZSAwMDAw
MDAwMDAwMDAwMDAwIF0tLS0NCj4gDQo+IA0KPiBBZGRpdGlvbmFsbHkgd2hlbiBob3RwbHVnZ2lu
ZyBjYWJsZXMsIHdoaWNoIG1pZ2h0IG5vdCBiZSBhIHJlYWx3b3JsZA0KPiBzY2VuYXJpbyBJJ20g
YWxzbyBzZWVpbmcgaW50ZXJtaXR0ZW50IHdhdGNoZG9nIHRpbWVvdXRzLg0KPiANCj4gSW4gYm90
aCBzY2VuYXJpb3MgdGhlIGRyaXZlciBkb2VzIG5vdCByZWNvdmVyLg0KPiANCg0K

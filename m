Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2427D9338
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 11:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345420AbjJ0JMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 05:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjJ0JMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 05:12:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E022C0;
        Fri, 27 Oct 2023 02:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698397958; x=1729933958;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s892s9ZMEqoivmIAbDIOcZw4R9OerGNRB/JMIgYILKg=;
  b=DUVYN3GdwZ4iyR0D0Cx/AI4no4WLhP/nYmk9EaAWF4AxmdlgN8VNgAyV
   iBCwGbhApCnClo6h27IuxmnxUomQvGkqiwBJfM+fZFJehkySjL7WteYPa
   5sAW1O1eiBeD5gYhSeWKcWemoRK28jTy8WlefAHxU2LyF1lke5zXIJ2TW
   PPvhYrJgyP5t6eYqSkqgcJZWYicsIuxC33cmA1lTZGAqTmkld3j4c6tUa
   HYPtGQ+hfvULUZ2VntlWCsGWcTdEYgfh0lH94hmLiJfmnop8mvE4+NaPk
   QwCRcMztLEogfzo5cee2QDJABCZmdYNU/yAaKJXvBsN98xYdWB92vp22y
   w==;
X-CSE-ConnectionGUID: SdJSpQjFRe+Okz9nciKhZQ==
X-CSE-MsgGUID: kdWwM087QTS6N61s1CEqSQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="11303710"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2023 02:12:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 27 Oct 2023 02:12:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 27 Oct 2023 02:12:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKasVvfmexZZnzpcGta+QwqJwNEorlpjw2UZm8KT4vGKrX8YKhUhw2pxRpNShWdIIZfkC+VSeVQUAtlN9CmatdQwBVO2ypE7VnK9BUWL3W9EH5ezsvK3oUZe3pjXFf8BjSYZpN41YJnSlSRR8lbYpkZUFXFOvQ1r8xiDa4pK+uwa6Id7Bnx3kh0Rpo2F/JykpwXzr5yZ7YQhd+T+YDPu1mnQkALv6CcgrpPdYop/9oUis2zwCfgZr6caokhEAoGWLgGWgsdYQ6EWbA4HmGxev1oq0YVSyyJcWzgzbt80F4u6kL02Q0DT8O+EB2KiZ9ZlAJSRMPQFtGEPmXnA2hv0aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s892s9ZMEqoivmIAbDIOcZw4R9OerGNRB/JMIgYILKg=;
 b=DOe4ofgKYI0NYPs26ntdYIy3KZ3TQa3771+zFlJg7O7cSliQqVlEsmZ0bF2EnB9PvwPgEtGljFSs0mxGDuanE24XAhg+iCJqg96lMa0Hj3ocUYUYEl3gsWQzRV3sTaLUeDxW0fREzbgF7uqQ9dfxzHnylAUbmLLBsFRtLf/8khj1//AKgf9Ec0A3BWGi8Bmh+et1fOgNAYjshUfRTN2KgtBCoTqgv6o1JnXGtesgpihQo5dfsY1DcO479z6jhKDs258J0y1AXFg3zaIMhMtAIN//B7pzDV7e1dUcjmS4HO19Bb7Ahf6+sfSUcWaT0jDxYbUB8ZnqOnbIeRO8/bn9Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s892s9ZMEqoivmIAbDIOcZw4R9OerGNRB/JMIgYILKg=;
 b=gSzUK4xpRA47C7/pWqy7myjLIqL6TCDT9qKXX5YFqBpZ/xwYvCNf+qTcGaA62fha3QhOIWkkc1lREE48eUUeR+KL9jh0SwPvubYVC5foulaEJIpKS1iMwhrtI9AcmyRylOOa1LFY3UlV0VQOaNNv4BW+2CAY/C7N54L7/PCoCnM=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 PH0PR11MB4984.namprd11.prod.outlook.com (2603:10b6:510:34::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.23; Fri, 27 Oct 2023 09:12:15 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::595f:f69d:149d:510]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::595f:f69d:149d:510%4]) with mapi id 15.20.6933.022; Fri, 27 Oct 2023
 09:12:14 +0000
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
Thread-Index: AQHaBchdwqp9J78AZUCeswF+FBl/obBYGPIAgAVG1gA=
Date:   Fri, 27 Oct 2023 09:12:14 +0000
Message-ID: <acfb97fa-54f8-4381-bb82-db8f85fa86db@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-5-Parthiban.Veerasooran@microchip.com>
 <fd7f7d62-7921-4aac-9359-ff09449fd20c@lunn.ch>
In-Reply-To: <fd7f7d62-7921-4aac-9359-ff09449fd20c@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|PH0PR11MB4984:EE_
x-ms-office365-filtering-correlation-id: 60428682-91eb-4694-f31e-08dbd6cccf9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TdBhDcAFwS5nf2jT4+8vAAgn0Q43DEB3RlEPaG/UyvC9FGidwFjSU6cjOn2Uykmj3Nza1fwmWHf5Pl7llS++WVn9YnWC+nNBgAq/46THn7xdYywk0jgoaq/EDSj5UsG1yKWriAQuDrXB062adEEXO4JZhkegkK+YW05WVJSh014YhUlKjjXYXFd4FsNA3HEpn/BQczt4GZ1Hmc6mWKjqLKroCOEHPsYmyRf6gmBZiPk8CMG8w3oXQeBkUfEClgJw0FYR0CU9joamw6wlxMVpyXgRH1i9mI0eDo6agfDYEOlb7d7/rsuanx565RMuCYs0/1p9IAooXvpJZ1tlxH+pENGa/NHVjfnDaMc9y6KeK3noDMEMBwzeKviY3JU7Pc/tRIwwQGWoydY8d7sJo/yLHc5HY44Ts0ZBWaZuif3oIYKCGk1sJ1oXusX9E3Tw9wBvHC54zLJnP8Iz42kF6JRCDLKKq8Y0wYom00Jxf6XdGnXrsO3VyA7P0+vvY3f/sJz/qGlgIDUAtLAwZV0rNdPWMBxBfghMFAACdq4GAkfjDTh7IhQUtBb9Op1PmMl5pL/5orkBQ0zIImQ9igLfoG3t7T5QpxwuAkHQwgYTmo6firf2zrQ8T2qeLesVpNq+U2pV669WDt8+MCTMVagnbFneA9a12+RZACsvhuyu2N4K+4fwITxChEmT36V4sYzJmcKHXSXkUyyynuCvX6c2+9cd7sv6O0Ow77f4669GtyRUhw8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230922051799003)(230273577357003)(230173577357003)(1800799009)(64100799003)(451199024)(186009)(6486002)(8936002)(8676002)(4326008)(2616005)(53546011)(76116006)(66556008)(66446008)(66946007)(107886003)(54906003)(64756008)(66476007)(91956017)(6506007)(31686004)(478600001)(83380400001)(316002)(6512007)(6916009)(71200400001)(41300700001)(5660300002)(7416002)(2906002)(38100700002)(122000001)(86362001)(31696002)(38070700009)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VG9lUmw2KzRCdnQ4OGprQTBmUHdwanhNQmVGaVpObm9MeW92RXYvVHlOR3lH?=
 =?utf-8?B?TGdaZ0NUR1dPTmFvOCszMTUrMXZBdTRuOHdNb3k4TmFSTTdvWW9yV0RFbTJp?=
 =?utf-8?B?aFRXZTMxQTROaUNFYXpwaFZOWEpkVThmN2xOOUt0MFJNSTNPazJyVkVVN3Vw?=
 =?utf-8?B?UW56R2hxQTY5dkRxRmJaNFVXcVBoU1N0TTRmanVpYmZNYnAxMHlpbDBRYWhT?=
 =?utf-8?B?eVdGM0pPVFFveUJMNDdQZlJLb2NzNnNIOFg4NDYxYXRWNzE5ekZsQVQzY2hL?=
 =?utf-8?B?ckhzYnphcFo5NTYvMTVSaXRxcjd2QW9SdDFJNktDV3ZnRFNuOHFDaFlsSnFV?=
 =?utf-8?B?cUlCNkhZeXdlVE9OOTRNeGx5bENndWRGcHdGcHBZUk14VGh6Q282NmpCblEy?=
 =?utf-8?B?RmY3cWtHa2dIU0pqaGRqTDlSTnB4SDdHelNKeUMvZnVFMHloeHhyWk9GSVZz?=
 =?utf-8?B?SXNmVmxkT3RSWnhJbXZOeWJMWmFVaXowSTltQTdkVG90cExvU3Q1RUJHTldT?=
 =?utf-8?B?ak55blM1QXBiRG15YUo3NFJoQ0NOYVU2VG5wN1hTb0hzZnJnRCtZVEJVeVJ0?=
 =?utf-8?B?WHE2M2pBbGJ2aU9vdEJza25IL3J6L0tMSUZMQVd5dXNFcEFjSHdJdEgzVm9x?=
 =?utf-8?B?WUlCZVZUM0Rxek1kenNSZWg3bXE4QzNkRy92OU9OODhHbzFqTG9WdGowalMx?=
 =?utf-8?B?WHVYWWV5QW9DallOZ0tSNDFmNWNFc2JNdGYwM0x4Zm1ZVUhGTCtBODR5cFhB?=
 =?utf-8?B?TytESytqeWFuTUF1eTM4ZUhwWDBvZnZqZzMrTlhtaDYvK0xSNG9jem5jOVRl?=
 =?utf-8?B?TXpXeEpZZ2tsWGhJSytoU3IzSDNjbVZoZUU0SHJFbTdkblVyb2FrYm1kNlls?=
 =?utf-8?B?Q1ljT2FVRDJKMExSdE9rL0lRYVpmY3V1VTBjOG1GeDJSVWpjZHNiYTdrNlIx?=
 =?utf-8?B?WDhqY3orKzNRK2lnd3h0dHExanV4SzFWNGRlNnJ0RHdLd0J2MmRiU2d0cWIv?=
 =?utf-8?B?YkE1RVRwUkM3NllVVXFCVVR6Q0VXV1hTWi9lNy9uSjJnOXZUN1NFdEgwYXIz?=
 =?utf-8?B?U3didU56bVJET0ZpME4wcTNtNU9QVGVtQmZmTHBMMFQxdzdyZGNtYXVlK2Mw?=
 =?utf-8?B?bjhYU2prRWoxbjAxYXV1Y3Back8xM1Q0QlpHNFd6UzU3Qnp1WGtFeWc5MWU2?=
 =?utf-8?B?akhhdHFZSUZ2YVNJcnFxSFlRajVLSWdiUFlsVWw4S1kwMkVFODgwMEZrUVp2?=
 =?utf-8?B?Z3g0S0hOdDV0a0RuUER4SEN0THBQS0YzSWdtT0J1cFJHckxpblNHbm1Nb3Yr?=
 =?utf-8?B?UlVPUG9MT1RpcUNkUjBKbitmc0VFK3JZTnhHOEZ3WCtFUEFyUGQ0MTNsTzcz?=
 =?utf-8?B?L1NvUCswNUhTNUF2VzhXcmYvSmc4UGhJMHFqUjQxTXZ5Y1hSOXZSSmV5RUMr?=
 =?utf-8?B?T3V2VEcxc0FLdmZHRGdvNVdjYk9FZWZEajlvRkVtM3ZIdW5kVWlrTmFxeWRN?=
 =?utf-8?B?cUR4TFN2N25HSDdXWDJwcmVjOTJoSGp4Skt3MjFIaDNNZG4yUUh5ZkQ5T09x?=
 =?utf-8?B?UStJZUpzREp5MnJhT0xDTEdvL2xFVW00Y3VqbHN1Zk9McXNoS0dQdGY4SnQv?=
 =?utf-8?B?ZUN1WTYxUk5YS2JZNjZFNitydmtJdldYUm5FYjFIQVl1Vmk5T1MrVTRSUUVl?=
 =?utf-8?B?L1QzbmZPMER3U3liTW4vaTY2U3Nwa1FTOFNidk4rYnlvdk13T2tqekc5NVVz?=
 =?utf-8?B?ZHMwRUVLRDRrV1RqQlU0L2RUbnNOZkl3QnM5Wmd0d0J3OGxQYzROdjk4dFg1?=
 =?utf-8?B?dG4wY1lBRWhsWlpFVHI2M3h4TDhiTVk0WU9kd3p1MWZJY1JsY1B6YU1xSjFH?=
 =?utf-8?B?YzliakwrblM5d2dRQVlVazhCTUswMEhZdFlRendMZ2hNYmpkc1psVFFYcVRD?=
 =?utf-8?B?RGpFTFNORENLcVNydDJaSjVWNWNMOVFObitNVzFmZndaTXphaVBUNTBvWlQy?=
 =?utf-8?B?MjNSMDRqblBIa3BQcnlDTVE0SVdkTlFjNXFsTmxsb2poNEVMVEVJelVPR2Ev?=
 =?utf-8?B?MUQ1ZThmNWNjUEZPNjh0M0Vrb1pzYldEdW96dnQ0ZWpEc29HWVh0R0N0WTRX?=
 =?utf-8?B?anl6enBocGxCM3dpRnFCZlNmMEUwT0xId2xEM29KWXhEU3BQR1BFcVgvdmVz?=
 =?utf-8?B?Z2l6a1d1UjZ5NnZGUCt6amxGazEvWEdoanZBQllRVi9wUDNSbGpldkJxV0J4?=
 =?utf-8?Q?mtTXqNM0uu9DOFRImHCukTfbKabHlTpNxXaEnxFFdQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5E550F47813444CB53FFD710363932A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60428682-91eb-4694-f31e-08dbd6cccf9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 09:12:14.7419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y6yXLW9vMA6nQKHEn46UHueu2xLTq5wpCGntfk7s/d/GXAg8pg3tdlC3vOxPIJMxhc3LsMHU18tvB2p2YOW4Gf8mhU39sLNbndRJh6WDo5Hfc8e2av785UwlwEDy6BxZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4984
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpPbiAyNC8xMC8yMyA2OjA3IGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gKyAgb2EtY3BzOg0KPj4g
KyAgICBtYXhJdGVtczogMQ0KPj4gKyAgICBkZXNjcmlwdGlvbjoNCj4+ICsgICAgICBDaHVuayBQ
YXlsb2FkIFNpemUuIENvbmZpZ3VyZXMgdGhlIGRhdGEgY2h1bmsgcGF5bG9hZCBzaXplIHRvIDJe
TiwNCj4+ICsgICAgICB3aGVyZSBOIGlzIHRoZSB2YWx1ZSBvZiB0aGlzIGJpdGZpZWxkLiBUaGUg
bWluaW11bSBwb3NzaWJsZSBkYXRhDQo+PiArICAgICAgY2h1bmsgcGF5bG9hZCBzaXplIGlzIDgg
Ynl0ZXMgb3IgTiA9IDMuIFRoZSBkZWZhdWx0IGRhdGEgY2h1bmsNCj4+ICsgICAgICBwYXlsb2Fk
IHNpemUgaXMgNjQgYnl0ZXMsIG9yIE4gPSA2LiBUaGUgbWluaW11bSBzdXBwb3J0ZWQgZGF0YSBj
aHVuaw0KPj4gKyAgICAgIHBheWxvYWQgc2l6ZSBmb3IgdGhpcyBNQUMtUEhZIGRldmljZSBpcyBp
bmRpY2F0ZWQgaW4gdGhlIENQU01JTg0KPj4gKyAgICAgIGZpZWxkIG9mIHRoZSBDQVBBQklMSVRZ
IHJlZ2lzdGVyLiBWYWxpZCB2YWx1ZXMgZm9yIHRoaXMgcGFyYW1ldGVyDQo+PiArICAgICAgYXJl
IDgsIDE2LCAzMiBhbmQgNjQuIEFsbCBvdGhlciB2YWx1ZXMgYXJlIHJlc2VydmVkLg0KPj4gKw0K
Pj4gKyAgb2EtdHhjdGU6DQo+PiArICAgIG1heEl0ZW1zOiAxDQo+PiArICAgIGRlc2NyaXB0aW9u
Og0KPj4gKyAgICAgIFRyYW5zbWl0IEN1dC1UaHJvdWdoIEVuYWJsZS4gV2hlbiBzdXBwb3J0ZWQg
YnkgdGhpcyBNQUMtUEhZIGRldmljZSwNCj4+ICsgICAgICB0aGlzIGJpdCBlbmFibGVzIHRoZSBj
dXQtdGhyb3VnaCBtb2RlIG9mIGZyYW1lIHRyYW5zZmVyIHRocm91Z2ggdGhlDQo+PiArICAgICAg
TUFDLVBIWSBkZXZpY2UgZnJvbSB0aGUgU1BJIGhvc3QgdG8gdGhlIG5ldHdvcmsuDQo+PiArDQo+
PiArICBvYS1yeGN0ZToNCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsgICAgZGVzY3JpcHRpb246
DQo+PiArICAgICAgUmVjZWl2ZSBDdXQtVGhyb3VnaCBFbmFibGUuIFdoZW4gc3VwcG9ydGVkIGJ5
IHRoaXMgTUFDLVBIWSBkZXZpY2UsDQo+PiArICAgICAgdGhpcyBiaXQgZW5hYmxlcyB0aGUgY3V0
LXRocm91Z2ggbW9kZSBvZiBmcmFtZSB0cmFuc2ZlciB0aHJvdWdoIHRoZQ0KPj4gKyAgICAgIE1B
Qy1QSFkgZGV2aWNlIGZyb20gdGhlIG5ldHdvcmsgdG8gdGhlIFNQSSBob3N0Lg0KPj4gKw0KPj4g
KyAgb2EtcHJvdGU6DQo+PiArICAgIG1heEl0ZW1zOiAxDQo+PiArICAgIGRlc2NyaXB0aW9uOg0K
Pj4gKyAgICAgIENvbnRyb2wgZGF0YSByZWFkL3dyaXRlIFByb3RlY3Rpb24gRW5hYmxlLiBXaGVu
IHNldCwgYWxsIGNvbnRyb2wNCj4+ICsgICAgICBkYXRhIHdyaXR0ZW4gdG8gYW5kIHJlYWQgZnJv
bSB0aGUgTUFDLVBIWSB3aWxsIGJlIHRyYW5zZmVycmVkIHdpdGgNCj4+ICsgICAgICBpdHMgY29t
cGxlbWVudCBmb3IgZGV0ZWN0aW9uIG9mIGJpdCBlcnJvcnMuDQo+IA0KPiBEZXZpY2UgdHJlZSBk
ZXNjcmliZWQgaGFyZHdhcmUuIEl0cyBub3Qgc3VwcG9zZWQgdG8gYmUgdXNlZCB0bw0KPiBkZXNj
cmliZSBjb25maWd1cmF0aW9uLiBTbyBpdCBpcyBub3QgY2xlYXIgdG8gbWUgaWYgYW55IG9mIHRo
ZXNlIGFyZQ0KPiB2YWxpZCBpbiBEVC4NCj4gDQo+IEl0IHNlZW1zIHRvIG1lLCB0aGUgYW1vdW50
IG9mIGNvbnRyb2wgdHJhbnNmZXJzIHNob3VsZCBiZSB2ZXJ5IHNtYWxsDQo+IGNvbXBhcmVkIHRv
IGRhdGEgdHJhbnNmZXJzLiBTbyB3aHkgbm90IGp1c3Qgc2V0IHByb3RlY3Rpb24gZW5hYmxlIHRv
DQo+IGJlIHRydWU/DQpZZXMgaGF2aW5nIHByb3RlY3Rpb24gZW5hYmxlZCBmb3IgY29udHJvbCB0
cmFuc2ZlciBkb2Vzbid0IGh1cnQgDQphbnl0aGluZy4gVGhlIG9ubHkgaW50ZW50aW9uIGZvciBr
ZWVwaW5nIHRoaXMgYXMgY29uZmlndXJhYmxlIGlzLCBpdCBpcyANCmRlZmluZWQgaW4gdGhlIE9Q
RU4gQWxsaWFuY2Ugc3BlY2lmaWNhdGlvbiB0byBlbmFibGUvZGlzYWJsZS4NCj4gDQo+IFdoYXQg
aXMgdGhlIGVmZmVjdCBvZiBjaHVuayBwYXlsb2FkIHNpemUgPyBJcyB0aGVyZSBhIHJlYXNvbiB0
byB1c2UgYQ0KPiBsb3dlciB2YWx1ZSB0aGFuIHRoZSBkZWZhdWx0IDY0PyBJIGFzc3VtZSBzbWFs
bGVyIHNpemVzIG1ha2UgZGF0YQ0KPiB0cmFuc2ZlciBtb3JlIGV4cGVuc2l2ZSwgc2luY2UgeW91
IG5lZWQgbW9yZSBETUEgc2V0dXAgYW5kIGNvbXBsZXRpb24NCj4gaGFuZGluZyBldGMuDQpBZ2Fp
biB0aGUgaW50ZW50aW9uIGZvciBrZWVwaW5nIHRoaXMgYXMgY29uZmlndXJhYmxlIGlzLCBpdCBp
cyBkZWZpbmVkIA0KaW4gdGhlIE9QRU4gQWxsaWFuY2Ugc3BlY2lmaWNhdGlvbiBhcyB1c2VyIGNv
bmZpZ3VyYWJsZS4gVGhleSBjYW4gYmUgOCwgDQoxNiwgMzIgYW5kIDY0LiBBbmQgdGhlIGRlZmF1
bHQgaXMgNjQuIEFsc28gTWljcm9jaGlwJ3MgTEFOODY1MCBzdXBwb3J0cyANCmZvciAzMiBhbmQg
NjQuDQo+IA0KPiBBbiBFdGhlcm5ldCBkcml2ZXIgaXMgYWxsb3dlZCB0byBoYXZlIGRyaXZlciBz
cGVjaWZpYyBwcml2YXRlDQo+IGZsYWdzLiBTZWUgZXRodG9vbCgxKSAtLXNob3ctcHJpdi1mbGFn
cyBhbmQgLS1zZXQtcHJpdi1mbGFncyBZb3UgY291bGQNCj4gbWF5YmUgdXNlIHRoZXNlIHRvIGNv
bmZpZ3VyZSBjdXQgdGhyb3VnaD8NClNvIHlvdSBtZWFuLCB3ZSBoYXZlIHRvIGltcGxlbWVudCB0
aGUgc3VwcG9ydCBpbiB0aGUgZXRodG9vbCBpbnRlcmZhY2UgDQp0byBlbmFibGUvZGlzYWJsZSB0
eC9yeCBjdXQgdGhyb3VnaCBmZWF0dXJlLCBpc24ndCBpdD8NCg0KSWYgeW91IGZlZWwgbGlrZSB0
aGUgYWJvdmUgY29uZmlndXJhdGlvbnMgYXJlIG5vdCBuZWVkZWQsIHNvIGJ5IGtlZXBpbmcgDQpw
cm90ZWN0aW9uIHRydWUgYWx3YXlzLCBjaHVuayBwYXlsb2FkIHNpemUgKGNwcykgNjQgYWx3YXlz
IGFuZCBtb3ZpbmcgDQp0eC9yeCBjdXQgdGhyb3VnaCB0byBldGh0b29sLCB3ZSBjYW4gZ2V0IHJp
ZCBvZiB0aGlzIERUIGJpbmRpbmdzPw0KDQpCZXN0IFJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KDQo+
IA0KPiAgICAgICAgQW5kcmV3DQo+IA0KPiANCj4gDQoNCg==

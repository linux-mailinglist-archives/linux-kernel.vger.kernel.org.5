Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5817AA7D3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 06:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjIVEcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 00:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjIVEcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 00:32:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6DAF1;
        Thu, 21 Sep 2023 21:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695357125; x=1726893125;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=N6UIUtAZlPOfLhu+cuN6+GRfG+yXSt9C58FhPNG6xaM=;
  b=k855zk33YS+znXck0QVUyOtF0TcutdQJbNy06XaQbP5H8j6kB575q3X5
   LhTGvQTRmBzhV1zBlNtTM45K9vW6cwHGNTpIma0K/0F+ul0UbL8eDkw3K
   3IXn2l9hjfBxVR1fgSGu1YRY8RJ4kU3D9urAkcZxfsONwgPF9dfL0M0Yk
   vl/904wiT2uWHeYH879U5PDQyDgX0LwMPkNizYr+GmR9XSlXJs4aK1xxE
   KB3iOjo/ArM1j5dsMBmhpBeQ0fcELVzQvZWyWuRr3fdbMddMOFAp0TadC
   piI3VXu7FqeyMyDcVSxjjYfRlxG+Yz4mwH9Y9rP0u+yvcYEnEVnF/cNYJ
   g==;
X-CSE-ConnectionGUID: AL8gsmwjSgSu+wSBMv3tcQ==
X-CSE-MsgGUID: rnDDCXvlTuibMMSv8KMX3g==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="6004899"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Sep 2023 21:32:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 21 Sep 2023 21:32:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 21 Sep 2023 21:32:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzPc2asQrBrNXQNfkIq0D+UAsGrk3BNSfFL57OnY/2L/BiTw7ySaKQ8locq8tnQmv8hax4O777D5DdqO6cKLemgKQuLEeGFe27Js5Z1sycH02D115/BbMcnznpgg6lvn9paY4ZRbeyPrgqGUpcR+GPeNm2bwkpgDsbRt1FDG2EfkMDQKJz+tNiRWtJ1ug8/dVfzonOcMzxAWggFonrpSVhL2wLKGTkMvfIx68oKQOc2ItYtIvy/fpAuVyAk+KAKKvyS+WQQWtE/7YJMWg1O3dMnDLrabraRkUG8po/czGy7WNL1lTA9veRVlfHjrhVWmXtJQk/oM40aG/1fzBpE0ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6UIUtAZlPOfLhu+cuN6+GRfG+yXSt9C58FhPNG6xaM=;
 b=QkFzUlBKHr5/ZhYGGv/1eyv7fnPt84wOO2JccN7ylkO1fYDO2mbhRZjqvU1Ps+D8cwZUoiiQSs8o90bT0sCa269QisfWtnmq3Bsv+8u4cuW8qMdzpvsHfulDCVtzx1l+k358JjmRFdKYhtULrJyVoj2loQAxjs7Csd5tXTxD1sCU1W92IssRG+0gYGpnvHyewyv6AiySWNwmwpsnc3y+ZlvDy1Uh5bwfwC8X+MB/rDun6yGAIXtgqvBq+eEFle+WKoNEmyiFEccb4lLMffGI6obzqcTFZQZhIjmk30JXA67c9ADuqVkW57YrAWVPkutgTDB9KXs0xoTrFgPHn2UZZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6UIUtAZlPOfLhu+cuN6+GRfG+yXSt9C58FhPNG6xaM=;
 b=plBCaePbFQcp3t8jPMr93VWnRp29CWVZ43hJiNvSmryuO4bdVWY60b4aS1U/um/W42B+gJPafSi5WuJGyjgAFFGeyP8sFok1LxyTv2xpfW8ePHhoC+GC/2eNt2jT8JlxpV5o30M8RJVwWdlUT5qA9w4cRFVobU0POcTYeUjOdDA=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 BL3PR11MB5681.namprd11.prod.outlook.com (2603:10b6:208:33c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 04:31:58 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef%7]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 04:31:58 +0000
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
Subject: Re: [RFC PATCH net-next 1/6] net: ethernet: implement OPEN Alliance
 control transaction interface
Thread-Topic: [RFC PATCH net-next 1/6] net: ethernet: implement OPEN Alliance
 control transaction interface
Thread-Index: AQHZ4mEB+nwP90vbvEyYqcmk7ntkibASf7oAgASuf4CAANFsAIANSZwAgAByWICAAJsWgA==
Date:   Fri, 22 Sep 2023 04:31:58 +0000
Message-ID: <d90e8a46-2b4a-91e5-3a65-7f162172f3c9@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-2-Parthiban.Veerasooran@microchip.com>
 <74a6cd9c-fb30-46eb-a50f-861d9ff5bf37@lunn.ch>
 <6ecc8364-2bd7-a134-f334-2aff31f44498@microchip.com>
 <2021acc6-bcf6-4dba-b7ce-ca1b3ca86088@lunn.ch>
 <94e4a08b-005d-adc0-5852-85568ba5db72@microchip.com>
 <42031ac6-7f3d-4bc9-8cfa-d7eb61ed10d5@lunn.ch>
In-Reply-To: <42031ac6-7f3d-4bc9-8cfa-d7eb61ed10d5@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|BL3PR11MB5681:EE_
x-ms-office365-filtering-correlation-id: d8e0fbce-a41f-41fe-b791-08dbbb24dbad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9b5buCpTodIiXY44YQXFe70yRYZ1+MAvBP/4+C8iCh7smp/WqhT9kfz3IK+qZLHte35U0IJJB1jWGJq5g03n7sPipD6dxYAq240rde2vM2Xm55sxgj8RKoE89uZUOXQY4CII1Un0GHyiqIxY4HDbIhKZw1HH+UUeBPWtxLI3vEHE+2WRadr5T1yTeNsIbNvWd5Rf6vd6h6lnGyUlwsXAomuL/gl2FasNTDi9aGJSkK/167BxuL3ln0TqiHvo6vxZzXaGPMl7f/xgOzrzoCzKlxktSwVXQklFXtoAoJJndSwwNmwPdk5Kwtae2fKZj2w8MeqKlSDSJ1IIXYhWzhgQRcp8X54R+qcHJEYw6/S4jWpHmNNn7jKfi+Ava0UWGhIkaBiwyZSflhcU4Yu3BLHyudY5geiozGCTF87uay3SUn4KXpbMlyTCsyeTdRklDU5XATaDS/M50yVJVo0MCLsaTsqam5MJ6oOS2JF2KAAEIGXXtuGsBRftaCB6kIPdaXm2P9jrhAuaxKBtxcDlB5B5xRI/yj3FJueTTn22ab1upAe4IyCg+sGuoQaXS4thfMciUCLY5uust1nX5hkbskBub7R0KK8XW75yEWak4w6yMYUyEkh0rdmitjydBG7KjAMRf9WG0oTTGSl0vUbhkYiXaWL4sfJCSbiYK/7ld6aAjylpHN7vXXz2cc8dkZOqZSvG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(186009)(1800799009)(451199024)(31686004)(8936002)(8676002)(4326008)(91956017)(5660300002)(7416002)(26005)(53546011)(6506007)(6512007)(316002)(66946007)(66556008)(6916009)(66446008)(64756008)(54906003)(66476007)(76116006)(38070700005)(38100700002)(122000001)(71200400001)(41300700001)(2616005)(86362001)(31696002)(6486002)(107886003)(4744005)(2906002)(36756003)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmJYSDRwaFQvcmdxajdSZjVNRGtGd1hMbUVOY1VDWkhRTFRhU01jdlJKUTYw?=
 =?utf-8?B?US82NUpCZlZ4WXZINHV1VXFiNXBobFZmQ2ZQZWthWmsvRTdsZVFqOUxWOUl5?=
 =?utf-8?B?eEkrMVJaVU9KYjB6M0FlbkxOZjlwOW5NQkRWVnd1OTArM0RXMlhtUHJEQWlk?=
 =?utf-8?B?VUk0b1I2MVRyMm51NjgvRkFScFVVTGgwTGx1cmkyVzhYdEljRFJRZUdNZVJD?=
 =?utf-8?B?QzNteGNmMlpUdFRHeGprMTVrUWtoQm5PUWhHa3hGYzRPTkIySXd6ZmU3eE90?=
 =?utf-8?B?MzdQOVdKTDEybmE0cElYTkQ1Y2VmUktjdjNpSXVZWXZWVUhmT1g0cTlPMEpH?=
 =?utf-8?B?RnRFRytLa3kyMUMzMnc0SmJuNnd2alBRak5jRXZmOEo1elM2aFk4Y3RGcWtj?=
 =?utf-8?B?RFJ6MDJJYTdiSjF3MTQ2WHNramJtMWJzdTlDbFlJZFBxc3lCOTVQTkM0Q09j?=
 =?utf-8?B?VTZ1TlEwU3BzeFNiby92VS96TEFodFFubXpodlFyQy9yelF0WHB6bXZLcGp5?=
 =?utf-8?B?ZlNpMWJUOVpzRW5BL1VoWXFxaFh6bkNHaUxKQjlSSldzSG5yRjlmeDl3ZWsw?=
 =?utf-8?B?ZmxkNmpSbzZLS3Q0NUoyODFDZVZMNC93R1ZKcU13WUhZalFzUTVqV0RvVUlP?=
 =?utf-8?B?cE81bnNSN3pLQUx0cXpMV0VCMnQwS3UvaHZFRFUzOUhjZmdsZVJpcFVnRGFI?=
 =?utf-8?B?SktncjZ5ck1UQi9ybHJGT2R0bGxWdE5ZbDI3eUxRS0NjdldBZ2pEN0dMTndB?=
 =?utf-8?B?azlpdmRvVmhvK1U4d1VzS0c5Q2g3cWc0ZSs5Mjl4RjR2dTBXMDh5UjFnSmlk?=
 =?utf-8?B?aU5LRzJ3R01UdU1TeTdDZURsQldncjcwQTRPM1ozSk5JM2NBby9relFYSVpM?=
 =?utf-8?B?UUFjMDBaL29WVEROWE5pempuQmpOVnhSMlY2OEJjMmJxVzBMS1FROTVEdm9w?=
 =?utf-8?B?NmJhbUNlbGNDUWo4VmJtcTlCWU44WWxxZk0vbDF3YlMrekZialc3ZjRXQkpG?=
 =?utf-8?B?Mnp2MUhIMlFJQ1BJUW51MEdIa2taSEJ1UUJPKzF4d1d6cDlJeUd6b242OWtV?=
 =?utf-8?B?QVBndHgySlhxSWNnRmxOZDVKd09TTTRBbGZLVnptK2kxY1d0UDhxRVplUEJs?=
 =?utf-8?B?bXpCV2JtTnRpZThXenZjMWVyVFU4VER0ZGZzRWpJYWZHZFltNFMvZkdiSkpX?=
 =?utf-8?B?NmtLaDJZcGJTQTNQWWc5WFdOczB5U3VObXlJL2Z3dFZFa0NpaTR1SDFjL1dN?=
 =?utf-8?B?UkJORGhYd0NKKzAvZnc5eml6MlFlc3JzbmhKZnFEbUZHU3prQUNSOTdrRys5?=
 =?utf-8?B?cU1XU29MSmJXUnJSWnc0Zi9VbVN1R3ZUaWRybmFDbEI5QlQ2ZktpUG9WMHpM?=
 =?utf-8?B?UU9vNndkdGZ1eE1BdHd1VlZpa2d6OFdXR0Ztc1pKRFhqdzB4dWJsQmRXM2Y3?=
 =?utf-8?B?K0pKR0F5eVA2dFBpaXNBbEFtYWQrdUY3V0ROdXMyYW43ZmxqNzNUMUxsWklG?=
 =?utf-8?B?Mzc3TlM0TG56dExvSlNTMkVpek13K3owVXRtaTZGU0tDUC9sTU9GMXk1UHVE?=
 =?utf-8?B?Q20rOUFlRUwzd0VUWWh5Q2lyWVMxUEViMG9SeVpyaEZFajB6THF5OStyWkZz?=
 =?utf-8?B?enlneGl6cEkvOENNenhJNVN3ZjBEcnVNUE0vTk11QWVuTVNBL0lEWUxWNEVR?=
 =?utf-8?B?TFd6Q3V4WFZxeElYdktxaXZUdHVCRjdHZnZONFI2UHlJeHVya1NSK3BLdkRU?=
 =?utf-8?B?Qy8rUUhLVTNvRkNQZEprbTFhbnB2dUhsWXAwMGI5NENtUVFMMVJlRmhiT1pR?=
 =?utf-8?B?cjNlYkhITTc4RldaVWU1NTYrZTkydHkraEp3cFVuMktGcm56U21rV0x3Sk9n?=
 =?utf-8?B?TitHR0hGRFEvWkh1a2F5TTB3dkc0TFF6US9FWmZ5TnJJMVVQR25VOEUwWHZT?=
 =?utf-8?B?WW5FZDB6bDgvVERWUFBmcmE4OXl2NVV1VEJ2MWRNa3V0bDhrU2dUZ0J4TXNP?=
 =?utf-8?B?QTRyd2pNRHc2QndpdUtlVW1BWXVVS2hpZHozK3pnMzc1Yk9WNGJoUnk4WHl6?=
 =?utf-8?B?VzZrdXQ2cnhnZWZlY29HNTFWR0NoZjVHWUpJMnMxeUR3TzZFZEtsQmlHM01N?=
 =?utf-8?B?WEV3enJQRTU0WUFlZVRBWURiRHBhakt0TUN0WWo2RzViNHUvUFNJaXZoSkFk?=
 =?utf-8?B?Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7421D969D97A95459EF4C1464B4B3D76@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e0fbce-a41f-41fe-b791-08dbbb24dbad
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 04:31:58.1417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GzxdWSfPHrDLVusLsyXY0bN1LESn68VImF4yI6N4iudNpSKFj1XTLsbULRcKnRuEDQzcbfIQyJn5twM0wmFCpbBg3aXf+3JFztgbMLFQfNeQPBKKkVeOKyqKyJw9nQGc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB5681
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpPbiAyMi8wOS8yMyAxMjo0NiBhbSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4+IFNvIGRyaXZlcnMvbmV0
L2V0aGVybmV0L0tjb25maWcgZmlsZSBzaG91bGQgY29udGFpbiB0aGUgYmVsb3csDQo+Pg0KPj4g
Y29uZmlnIE9BX1RDNg0KPj4gICAgICAgICAgICB0cmlzdGF0ZSAiT1BFTiBBbGxpYW5jZSBUQzYg
MTBCQVNFLVQxeCBNQUMtUEhZIHN1cHBvcnQiDQo+PiAgICAgICAgICAgIGRlcGVuZHMgb24gU1BJ
DQo+PiAgICAgICAgICAgIHNlbGVjdCBQSFlMSUINCj4+DQo+PiAgICAgICAgICAgIGhlbHANCj4+
ICAgICAgICAgICAgICBUaGlzIGxpYnJhcnkgaW1wbGVtZW50cyBPUEVOIEFsbGlhbmNlIFRDNiAx
MEJBU0UtVDF4IE1BQy1QSFkNCj4+ICAgICAgICAgICAgICBTZXJpYWwgSW50ZXJmYWNlIHByb3Rv
Y29sIGZvciBzdXBwb3J0aW5nIDEwQkFTRS1UMXggTUFDLVBIWXMuDQo+Pg0KPj4gVGhlIGRyaXZl
cnMvbmV0L2V0aGVybmV0L01ha2VmaWxlIGZpbGUgc2hvdWxkIGNvbnRhaW4gdGhlIGJlbG93LA0K
Pj4NCj4+IG9iai0kKENPTkZJR19PQV9UQzYpICs9IG9hX3RjNi5vDQo+IA0KPiBUaGF0IGxvb2tz
IGFib3V0IHJpZ2h0LCBidXQgaSdtIG5vdCBhIGtjb25maWcgZXhwZXJ0Lg0KPiANCj4gSSB3b3Vs
ZCBleHBlY3QgZHJpdmVycyB1c2luZyB0aGlzIHRvIHRoZW4gaGF2ZSBhDQo+IA0KPiAgICAgICAg
ICBkZXBlbmRzIG9uIE9BX1RDNg0KWWVzLCB0aGF0J3MgZm9yIHN1cmUuIFRoZSBNQUMgZHJpdmVy
IChFeDogbGFuODY1eC5jKSBLY29uZmlnIGZpbGUgd2lsbCANCmNvbnRhaW4gdGhlIGFib3ZlICJk
ZXBlbmRzIG9uIE9BX1RDNiIgaWYgaXQgc3VwcG9ydHMgT1BFTiBBbGxpYW5jZSBUQzYuDQoNCkJl
c3QgUmVnYXJkcywNClBhcnRoaWJhbiBWDQo+IA0KPiAgICAgICAgICBBbmRyZXcNCg0K

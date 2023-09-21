Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE24E7A9FB2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjIUU0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjIUU0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:26:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B462489DA5;
        Thu, 21 Sep 2023 10:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695318026; x=1726854026;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XhCxtzAXQ29znjqyJVXnzAjR5QLGTZgcTUoZr0JuBto=;
  b=Mih6tAf5yI8N0Pr6WXm7x6snhdAIYxEqyaa0ZHYk16eMgyPa/PnoyZIL
   CuxWGpEygG5Zpc8ojFML053RXosjyr8TAi8R54SKTw8ID+YE/e6FtcVPV
   n9XjznAJjrHBi5rHEhgtib1iDZNQKogN+zQnPydy0w3EE49UNtOr13izq
   LWnRfHAZziJs8ru0a4lDqUVaNwDWLyfVkXc4A2+p7o2ixU0kEd5eM9Vf5
   6QAYXE/hU3YJftGnD65l1tcULpzwUgx5OI+tnRe/WtJ067epnk3e2VDAw
   Krvi5KqHI3RxWjpxDaWLGvaE2/LfcP38YBts5HxJTTsiM8MGdZR75oD2d
   Q==;
X-CSE-ConnectionGUID: C7xTKqpuSnG9eXaTMOf87A==
X-CSE-MsgGUID: xPTffJzHT0icvFxAYB/I5A==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="5846956"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Sep 2023 05:36:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 21 Sep 2023 05:36:21 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 21 Sep 2023 05:36:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apaUaGOTAlODPaQbf54ae8XIPHutIx8M6t28S9QgqN96Pq3rue8TKdfrUjsy49kZkGV+NP+YDTdPKt1hMH5USmlCJCFldyaRdeFIglH1ji3aW782sOE2zz4o14cAmRuzc8eUPL/HDcFBxrKxnV88ZuO27u4j4IJslXF4OYpG9lASQu+2ogKqgruj0+btzfOtknOVndR0je+hWgUJfsZBmmtsBXMJ/PA6kuEteCRi1UeZrYiwypwEXa9jswuoSieTRTNYAvLJtX8rHOs9k6v46v+FgcqBu7W0gtU0hTnYazmv8beKlMjaJeH0o7jGjxI7V+odVgsuLHB8XMagb4XTFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhCxtzAXQ29znjqyJVXnzAjR5QLGTZgcTUoZr0JuBto=;
 b=hrmCv+4Nj7lQsJE1GIJ2Rz79Yzd1A5L5E2pofbNR+otgYdB2OTGm4Zoln/zPiN4ku8ZNFbODto0fepyQReQKuXUTpRH38XxS+1zvRlZc3qyGqqVszjCvw8QpCPaX3mozv8AV7YNGd4MRufixo/gS8kcNJQiO/ALdp4n5NRt2qaxyv0NOqYY/slXt3Y2R0c+Adkf67FoAVcDEWUvZPPeh0HtyYtfW+AAGco4wtI754jsOFK4rC9tC2jMuYWPc4TruErRJNfaDAOD7Vx6PgjZQeX3KVMPsnd2SSpkRQEGw4oOP4hi+2vrE1i3WZZi6MczwDXcBMnLprazn1qSnc3ADLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhCxtzAXQ29znjqyJVXnzAjR5QLGTZgcTUoZr0JuBto=;
 b=fzzGjF1dYfgqe3/ALQJk6ldj62F7j3w2lY2j471RJTkSzOB/f9xNGdM+QcorR+lRoINWOWHnorFn6+SOvfM+5q7iOpDAo1nrWOTbdVHLyFWouU1R9nc6V8E7Y9DPqpLsseAa16yBgo5+U97bovU7GnIwXmCxGy686nWp9WL+gKI=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 DS7PR11MB7690.namprd11.prod.outlook.com (2603:10b6:8:e6::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.23; Thu, 21 Sep 2023 12:36:19 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef%7]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 12:36:19 +0000
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
Thread-Index: AQHZ4mEB+nwP90vbvEyYqcmk7ntkibAYC/aAgAoD1gCAAB1qgIADHmQA
Date:   Thu, 21 Sep 2023 12:36:19 +0000
Message-ID: <e037b12b-e592-f451-102e-61401c7ea5d0@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-2-Parthiban.Veerasooran@microchip.com>
 <8d53ca8d-bcf6-4673-a8ff-b621d700576e@lunn.ch>
 <9615b403-52c1-f24f-382f-8eea3ddfcf04@microchip.com>
 <4c1d0d38-c459-4722-bead-7660d85f4925@lunn.ch>
In-Reply-To: <4c1d0d38-c459-4722-bead-7660d85f4925@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|DS7PR11MB7690:EE_
x-ms-office365-filtering-correlation-id: 4217587a-5298-4ec8-7d6e-08dbba9f5af2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ikVQ8mI/8zc69g/umsPqO8LVAaK+H8+6NUhCSf6UiY6zIjyFMai0qNclGGxccXB5Od+R4UFvKqcE2JVZXFUVBb1qaxz3oWwGI2ZXha5MZvsnG5OaniGk/9UVOPzs9LSrA20jRdUrL3NnA98oGJIs7VHSLiL+Ln3kPH0HMapJiJEvmVxJCyY7gy0Y9Y7YsLQ2O0axzkG8QUyFbT4AcW4SBHf9sqiU7h/AhX+Mdb5bokhE72TPJ3Na+BD0ImZPvLAo4JMirNeUbF8vBse5374XuXTePiNz/VR8j/Y4CxeZ8lADy9pCzyG/ygzEEIdiOVFc4+ZgvHiGFEhyqDaK2ZktiAHSIjKtl7GCmWkE/rQnL32qNRPMMqDbhI6GzjuT6GsKKrq7xTdjTI5WCM6YJdO8ynrXSdmpgI0a+6zR3sWqP33k1MZ9kv2u79m8Y0gePGxmQKyfAuJ0Tzo6VprAMTblB6x3nsr3QlXth2aVwVYj1w7F6sk1AjSBzdJri95y3uQINVvXg1uf86eixMGJyfaLxWO0i2XO7L0tvW0QctdFu0uVjnpgejE+V58CXSvODP9QGklcvpG0saWOvqw2tHSJCBqK17bdnzG8vlyKML1v67ff3Vt6168Fsx0jUCoB2J+RFbds3BNmlCcfljloYqZTh95z0R/bAUzX0R2vzJlbzezCJTidSYcrGqfJqZSALUoE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199024)(1800799009)(186009)(6486002)(6506007)(53546011)(86362001)(66476007)(54906003)(66946007)(6512007)(66446008)(38100700002)(316002)(66556008)(38070700005)(91956017)(76116006)(41300700001)(71200400001)(31686004)(64756008)(6916009)(478600001)(2616005)(8676002)(8936002)(5660300002)(26005)(31696002)(2906002)(36756003)(107886003)(122000001)(4326008)(83380400001)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEpXclVPaGdWTVV6T25aNTlwbC9XaHZXTXQwV01CZEx4K3RGMWVkZ2FieDNV?=
 =?utf-8?B?K3lyTTBVRHJVa3VjaURSKzFFUGtrbSt6TlQ5UUEwN1crbVQyRDVQblFmTE5E?=
 =?utf-8?B?dXduY2NiNkdnV25WNlg2Z0NCaC9yYVd6b3VRd2cydHdza2taUmZtWlFuNW1K?=
 =?utf-8?B?Q25kU01QNkdXRGwyTHRCNTF1cGhYbUp4eGRGTk9xTFI2aEVXcyszSFVhTDI1?=
 =?utf-8?B?VDJ3eWx3NldRLy9lL3QzTWp1bUN1clV4OVVTbTlOVTlnWmx5SklQSUxrK3dM?=
 =?utf-8?B?K0E0MUs3b0tlakhIOUNCYU00M1Q4Rk80VER0QVdEOFdrSUsyR2YwMDBzQUJY?=
 =?utf-8?B?T3hZWUQyODc3K2NtRHRMc1AyMjZsSnd1WDk2L1RnaUlUaGh6K0VDdEpNbFFv?=
 =?utf-8?B?UnhCbUtLQm9CTG9BY0Vzc0pqRUM2V1lXK092UlBkKzZ4K1pUT2grMFU2Yjgx?=
 =?utf-8?B?Wm1McWZuRGtzTnNDZmo3RWdrSjE5RlEwZ2kzcHZQU1JyaXg4UmRsdGdEdWlz?=
 =?utf-8?B?MlhzWkw3SjIwV3V1UUN3VmJsUlp6d3YySWJwb085SWZlY21JaVRoUUhjOHVs?=
 =?utf-8?B?dUw2c2dTQ0tGUnpZQklLdzdLYi8vcEVJTVNyeXRoYVM4U1g4SUVlSldlYUtk?=
 =?utf-8?B?cjEvSE5WOTNQYVhOTUM2RWI5WTEvUG9nOUp6UTN6d1dlb25PaDdtbWh2Q3NK?=
 =?utf-8?B?ZWlKZmErQi9xUEVRc24rTVZSNGlzakEyM3hENXYva3E4WHRzYTh5TGppSWhl?=
 =?utf-8?B?V09aaG1oeTZpL2NldEdIdUM5cTNrcnUzL0xIMlBiRUxaVWhFazdkMHU1OVFp?=
 =?utf-8?B?RGtuZkJWMGJEcEtLcGdPaW5kREIyZ3FMUEpzUXFEQnJld0NKeGJ2ejFkeGNI?=
 =?utf-8?B?a08xQ2xWSXQyWnlEV0w4aGpORnB3dEJRRTVLSUQrMTlwcldqNTVENlBVVmRV?=
 =?utf-8?B?S0QwTld6U0laYzEyMzFkUWt3dmZDTDNqTE1FNm5xZzFyUlFOYjN0OHdETlBh?=
 =?utf-8?B?SUdRQnRQU3BlZ2RkN2FiWHBJQ3N1cStNSmlqczg1ZHVqZVg0cXltdTV0YjQ0?=
 =?utf-8?B?eE5iY3V5bU95SS9HWTROd0owVkZBZSs3YVRZbmU3dDhJWU1aZEx3MVFGdTBS?=
 =?utf-8?B?d0ZpQy9JejBBODV1dmZ5blRQaGZPYUJrdkhBYktxZ3h1a2dZdjlMaEI3Y2li?=
 =?utf-8?B?MDhjNUYrUkFKRjBiZTh2N2ZLN0NiMnIzRmEyUlhQQzdsNjZYSmFlUzBYeEdN?=
 =?utf-8?B?UFN3Z09rWkN4dkRScUloSzMra1hoRC96cm1VK0lWZW5iaWlaSXUzQlpabTRQ?=
 =?utf-8?B?VVpWUU02ajdMVVNWQmdtRWw2cDl5eURnU3cyV001TzltRmFYUjBaNkdlbzhi?=
 =?utf-8?B?ZlF5Vmd4Zy9RSmpOSVQ3bmY4RXBNaS9oYXBLTjdkOU51TXQ5elRLKzl2VWls?=
 =?utf-8?B?cGU3ZmxmZDQwNkt6a1Bzc0lsbjJHT040cDh3RWN2ZCtsNlIxZXpHZ242L2RZ?=
 =?utf-8?B?a3EvcXJmL0pUc1RiY080RjBrdExuMGNRYmxYcUFCdFFTb1gwY3JoQU42SURY?=
 =?utf-8?B?U0creWVpN1kzWHpLdEFFT1oxdjVwSTBoSUZxRWdLR25UeVVDMEI4dXBpZ241?=
 =?utf-8?B?VnhXK2g5SnU1UGpXVE1TcGRlZ1l2bzBPd0xiaU5XcUJJY1BaVWpQTmtsS2hs?=
 =?utf-8?B?V0FpRk5uT1cyMXlYbTdVUm8xaWFBeTkvNzVSZ0pMbDJINXU3WmNiL2N5Rkdw?=
 =?utf-8?B?RHBSZXNUdVN4WnhQZkl1NzExMTh5cGQyOXFGK2VCL1pTZHZaZWQyVi80TUUx?=
 =?utf-8?B?WlozYVk5ME5BOXk4TmFzTjZyRTUzMzBxMTJocnZZNUVDUkxTcXFQdEtycDNZ?=
 =?utf-8?B?di83ZVFFUDR5R2JVUEtoaHpSeExqWTQxdWpTNnMwMmw3RmNVUGh3dFJrRzgr?=
 =?utf-8?B?YW5PVTYwV044ckxaZmRidVl2bTBZR1V1aUUycEdFcDJuYmVmNHFxa1VaRjRM?=
 =?utf-8?B?cTNSS0k0eUl0Wnc5YzlvR29TNHFUaHZ4bkhPVGp1K3VsOEw4NUt4dlY5bGtF?=
 =?utf-8?B?c1ZZQm43K29LMlpTNEpOUy96M1g5eE5GMyttOEw1ZHRoNUQzWVVFaFVrY1g0?=
 =?utf-8?B?V3pQRzdqelJYdS9yTytQSFkwelEvYTVZUzRlaWl4UmdkWTFYa1dkVStiSEZY?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F88344A9E7A40243A41C575626822E80@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4217587a-5298-4ec8-7d6e-08dbba9f5af2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 12:36:19.1015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4xg9p4u8u9VMaC2in7eUsVAnfxzRa5evszESIgf3KHxD0/V4Gd2UYDLi01JSYs3epOAMkBIrq/luX8e0rNjh5GWx696rINZ+W7TpqD3cpG2g6l8yZZ81dyEsfNgcwT0M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7690
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpPbiAxOS8wOS8yMyA2OjI4IHBtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUdWUsIFNlcCAxOSwg
MjAyMyBhdCAxMToxMzoxM0FNICswMDAwLCBQYXJ0aGliYW4uVmVlcmFzb29yYW5AbWljcm9jaGlw
LmNvbSB3cm90ZToNCj4+IEhpIEFuZHJldywNCj4+DQo+PiBPbiAxMy8wOS8yMyA3OjQ2IGFtLCBB
bmRyZXcgTHVubiB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUN
Cj4+Pg0KPj4+PiArc3RydWN0IG9hX3RjNiB7DQo+Pj4+ICsgICAgIHN0cnVjdCBzcGlfZGV2aWNl
ICpzcGk7DQo+Pj4+ICsgICAgIGJvb2wgY3RybF9wcm90Ow0KPj4+PiArfTsNCj4+Pg0KPj4+IFNo
b3VsZCB0aGlzIGJlIGNvbnNpZGVyZWQgYW4gb3BhcXVlIHN0cnVjdHVyZSB3aGljaCB0aGUgTUFD
IGRyaXZlcg0KPj4+IHNob3VsZCBub3QgYWNjZXNzIHRoZSBtZW1iZXJzPw0KPiANCj4gT3BhcXVl
IHZzIG5vdCBvcGFxdWUgaXMgYW4gaW1wb3J0YW50IGRlc2lnbiBkZWNpc2lvbi4gSWYgdGhlIE1B
Qw0KPiBkcml2ZXIgaXMgYWxsb3dlZCB0byBkaXJlY3RseSBhY2Nlc3MgdGhpcyBzdHJ1Y3R1cmUs
IHlvdSBzaG91bGQNCj4gZG9jdW1lbnQgdGhlIGxvY2tpbmcgY29uY2VwdC4gSWYgdGhlIE1BQyBp
cyBub3Qgc3VwcG9zZWQgdG8gYWNjZXNzIGl0DQo+IGRpcmVjdGx5LCBvbmx5IHVzZXMgZ2V0dGVy
cy9zZXR0ZXJzLCB0aGF0IGFsc28gbmVlZHMgZG9jdW1lbnRpbmcsIGFuZA0KPiBtYXliZSBldmVu
IG1ha2UgaXQgYSB2b2lkICogaW4gdGhlIE1BQyBkcml2ZXIuDQpTb3JyeSB0aGF0IEkgbWlzc2Vk
IHRvIHJlcGx5IGluIHRoZSBwcmV2aW91cyBlbWFpbC4gVGhhbmtzIGZvciB0aGUgDQpkZXRhaWxz
IG9uIHRoaXMgdG9waWMuDQoNClllcywgYXMgInN0cnVjdCBvYV90YzYiIGFuZCBpdHMgbWVtYmVy
cyBhcmUgbm90IG9yIGdvaW5nIHRvIGJlIGFjY2Vzc2VkIA0KaW4gdGhlIE1BQyBkcml2ZXIsIEkg
d2lsbCBjb25zaWRlciB0aGlzIGFzIGFuIG9wYXF1ZSBzdHJ1Y3R1cmUgYW5kIA0KZGVjbGFyZSBp
dCBhcyB2b2lkICpvcGFxdWVfb2FfdGM2IGluIHRoZSBNQUMgZHJpdmVyIHByaXZhdGUgc3RydWN0
dXJlIA0KInN0cnVjdCBsYW44NjV4X3ByaXYiIGFuZCB3aWxsIHBhc3MgdG8gdGhlIEFQSXMgZXhw
b3J0ZWQgZnJvbSBvYV90YzYuYyBsaWIuDQoNCklzIG15IHVuZGVyc3RhbmRpbmcgY29ycmVjdD8N
Cg0KQmVzdCBSZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gDQo+ICAgICAgICBBbmRyZXcNCg0K

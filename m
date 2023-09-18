Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8A17A40F3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 08:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239712AbjIRGRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 02:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239790AbjIRGRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 02:17:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BE7123;
        Sun, 17 Sep 2023 23:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695017831; x=1726553831;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kC+X0+ZXsHxtFj4MusfqPuHKE3T855LH4ODtg/QdnQE=;
  b=2nclOy1VKpngWf53Maa2Tr/b1ruYDcJjcZLSAwrITdmnDhZKhYyxgPPc
   6xGRGcJ2D5/ksFo0craBNecOLa5B3u7uKGx8Grdd04ZL7/t99KX6GVflF
   qPvxT6Q/gxO6Elh2E5fzSpIJLx2YfNjeh4f3XBn6O06qt8f9tZ0PH9jOj
   mY3GqJWAaloQ044rQxJYPH1tj7A8z1tAQlm8Am96MQlnysWMM1lkOdYXU
   kowFLq4WAzPvbJ/UwVZ44G9BiMYTfGIfV3qQ+BO+CGnI1bp4JhHLl9uOt
   7wT1hF3kz4f9Q3Txd+B6BBysuGxzIwFQ3B7639sx41jmRA1vkUtlBeGtI
   Q==;
X-CSE-ConnectionGUID: cxfojURSSnmnrTAtlQ6ftg==
X-CSE-MsgGUID: bI2aQl6EQhenreZSyW1JIg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="235701851"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2023 23:17:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 17 Sep 2023 23:17:00 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Sun, 17 Sep 2023 23:17:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDbXDO+86SkJUa0v6ZNJhGn1mjGXERLv5EB3aiHLoKuU1mjSYSRJbSmurWZdwIwCZUDOQ97QA26jB3BBkURJzCwhQun50nh2MY0lqO9ACTbSRoyYUbufM9g49SGEWmBcdHzQHAEpi/qRNpx1hfDXJUZ/8mEu5txW1pO6HeBukjQcKMD+68XK/Y2+1SZ/P3/dr1H5YGxxu4Xn4M1BwmLM+gstR36wH6z6znJhtOjsVtz8gYxZ8QkaXAUcb5ivV1/k7KUdZwmtpWg/6FkNoKeYKZZDRWI5seU9fbeOz98USp2Bbd8JjobI3OqrmT27L5rR+jZefbjmSv9S4ZDETfFp9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kC+X0+ZXsHxtFj4MusfqPuHKE3T855LH4ODtg/QdnQE=;
 b=frJXrI/0czQYyjPs7xpppEoJ2ln3rxOAV9Yz4MgUj5NiX70xy/YC/Cm671gLMg0eFJ8VvuipmT6sBAloVliYK8HLJjU6idtzz6ENkLEAX9bLrDLxpE4ll8+0TOElUoHBiMuUcblIiLaqhnAUIAyzvWalz80WclRQtoaODxFhlPV+6vV/yqT/olU+e5UVtm56jpBPeZd0qhR9xaX4P4K6B7N4f/7e9EQBkKKxqc5BIb7tfJpN4r8Gxx0qELYcA6/WvavgxQ/Gj6zNLotLuKJNsXPy5vyJdTPWpurO6I+l91CmaJ4yQRRSuwxqhyrIMyHwqVRlcBJWhQ0f3A/srxmRQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kC+X0+ZXsHxtFj4MusfqPuHKE3T855LH4ODtg/QdnQE=;
 b=RSHZ4LLW8cw78LFAjW1PZnqA7tWRhqHVm0M2wqwRDrapkh+UCGo44icp0YGhZWoy/KTCiYIsyWT9SZbnrNTNlW5LNVUZ/RS356VLOxkTVTZSRXWX5d3ErYlT+QugpHcgurHEsXSofAEBzl4GiMObSyCffxSofOLhwDGd3gi3kLU=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 SA3PR11MB8073.namprd11.prod.outlook.com (2603:10b6:806:301::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 06:16:58 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 06:16:58 +0000
From:   <Parthiban.Veerasooran@microchip.com>
To:     <andrew@lunn.ch>, <alexandru.tachici@analog.com>, <ada@thorsis.com>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <Steen.Hegelund@microchip.com>,
        <rdunlap@infradead.org>, <horms@kernel.org>,
        <casper.casan@gmail.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
        <Woojung.Huh@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <UNGLinuxDriver@microchip.com>,
        <Thorsten.Kummermehr@microchip.com>, <alexandru.tachici@analog.com>
Subject: Re: [RFC PATCH net-next 0/6] Add support for OPEN Alliance 10BASE-T1x
 MACPHY Serial Interface
Thread-Topic: [RFC PATCH net-next 0/6] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Index: AQHZ4mDzB/QUuCJz5U6/cDo3W2/tF7Ab9DuAgAAHKoCABC8ygA==
Date:   Mon, 18 Sep 2023 06:16:58 +0000
Message-ID: <2196be46-b63e-e51c-cf1a-b15b60c4a5f7@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230915-wizard-junction-b58f2aad64c5@ifak-system.com>
 <ac528d48-44f9-4717-a61d-35365a11de78@lunn.ch>
In-Reply-To: <ac528d48-44f9-4717-a61d-35365a11de78@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|SA3PR11MB8073:EE_
x-ms-office365-filtering-correlation-id: da476b18-7b3c-426c-aa71-08dbb80edd6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gXvGdlxTieouZqCFmNy9WpE84ruKo1v3BQGUDZuL6qlgOTnlOlJzgyKvfmlFwmzVpIx/bR8+ZFXJTDoVo5wpBHGd+9DHF68lLZ9Z67ig9X1155/PCJyIK5Ug7k5+B0o2pBrUwLHtmfPvgPaGMuDqVWEmBGDmQVK2XEZPCmnz6gIb0yB+aEARUDpzZtUVJaIxF5vUWmXn/q1bLX3rO4se7O7n9o/6f1g8/EiIBcr1RzssOuarxsH6E83lW51/0WnaY1U8Ap3M0EGn1YaO2KLPY4PkwgO4XsgWMHSl8q4aat4M7Ax1d67EtVgWTzL36tc1xAFY67E1Auj1TwR1l2D2snE0XEPnV2tQqDTrreTtPWGhRyu4Hu0PD4BKpHMOxAEkCw+uFxJbeLrP+zcfGTmAV6jPfLjB51yBBgMeuLVl8NXQ2j+3lKP/AhY0hU2SbZjcW4pVj909gLJ1fibVcZZtEJd+OpVOAZVFeJictKpCmaFlYBpN4Qs7FWgTPLFxnuDDAYtciJNr8NSMaoySxi4UCooPXFjvFggGY1FebOtCYQUZf1AJ5iWQsXHgdkIS2ERNtR+IJU4fS0KrTPJuTvVAhEMtvIsf9A/qxFG4doEsyDw7wzbAsfYUJijHtRN3ym5lKtNHsFqUNvKMcoIYz1pW0X5uqAjUwgog6CVFyQRbdvqjlMkq3DRIW3AY1pZcZXCx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199024)(186009)(1800799009)(2906002)(5660300002)(26005)(7416002)(41300700001)(316002)(66446008)(54906003)(66476007)(91956017)(64756008)(66946007)(66556008)(110136005)(76116006)(478600001)(8936002)(4326008)(8676002)(31686004)(66899024)(6506007)(6486002)(71200400001)(53546011)(6512007)(2616005)(36756003)(122000001)(38070700005)(38100700002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFkwVVp3WXRPWjM4M3NNMVAxbUtWSVpWci9qOXRGSXZFajdJb1JoMWZ3bUgw?=
 =?utf-8?B?dGM3L3E3dzNQMkM1QVlHZW96bW5VTkRwcGx5RWRERWFHczRZMDlrYkZzQjlW?=
 =?utf-8?B?Q01RWW96RVlnSFFvc3F3K05hVnliTHNFZStvejlGR0o1dTI2WFNLMzJNTXpr?=
 =?utf-8?B?VWFQaEVFUXhEQ1J2QXlwTjhyc3pVZGk1U3hXTmkvR21SMEhrSThGbW9kRG4x?=
 =?utf-8?B?YmJiUHVZSW5sY284WFluR0ROU0xHZFZaeStHZEV0V0J5a05KOTJsSXNUc3NV?=
 =?utf-8?B?NjhJYkc0dGJXWFRhcDRUU2VDajZCTElJTUYxWTlGVllSUzAwUm5yeGt4aUVR?=
 =?utf-8?B?WDVLVThqaXdUb2tuOStlRHY0M3FGVWZpL204cndVWVViQldxSXFmUWZtZ21D?=
 =?utf-8?B?TjA0R3A1S1lnamQ0aTJaOFJjbWtMSkFzbVdyUWRETlN5Rnlqa0pRbWFOMGVw?=
 =?utf-8?B?M05FM25pL2dKRGl3c2VIbEc3ZUYzTHV3QnlZdGc1bDV0RkRiOFVDb1pDRUhE?=
 =?utf-8?B?ZGIxWUllRnJPcWtxb09PMzFwV2RROEJoYTdocVUzYUJHMnp6cDkxNWVDK0lE?=
 =?utf-8?B?WWMxMEJKNzZTdmV2T3dXTklJU0VrVXlNc3B2NW1EaEJSL3JFT09UdWxZTEpa?=
 =?utf-8?B?eXpQck5ibmROVzVOUmo2UFFCMWdDU2FTdm5QN2h4QjhLbzdqMG5sN2IrVjZU?=
 =?utf-8?B?Sm90N3N2UlZkcDRybjhmTis0QW9MSUU1YmVnZjFFbXFWSzBKVDhwY21DRVRy?=
 =?utf-8?B?emk4aE5tOWtsTmt4R3c4YXhIRE1ZYzZ1dEtOL1ptQ2hjYmdQNWZWK3ErZmJ5?=
 =?utf-8?B?SENQSXZCQ3c3K0IyVWtzRXR5YnRxbU5jYzRZRjRtZnlUMnpVQmE0ZFBaL0Ey?=
 =?utf-8?B?VUpWT3FoT3NZeGp1YXg1TEhERFFsYkkxdHBVUGdTYzQ1L2FUMWFZZ1dIbHRL?=
 =?utf-8?B?R0srSUdDOUlCM2MyQ1pRa2svajdTUTkwbDN3WmZTRGJVNXY2S1RQdzR4aXVl?=
 =?utf-8?B?S2tkTVA5ZGtyckFJV0dybHQ3TEw3aWk5TWtHa1BKaThkOTBKY1JkUnpOdlht?=
 =?utf-8?B?cnhLUnRZZHgxa3lJcGE3cGlMU3NFbUEyb3I0RDBtMTVSdTZSTUZlbVU4dGZj?=
 =?utf-8?B?SG0vUEo2NGhvZ041aTczUy9QdkxQUVIvTi9JYmw1UEFBY2k4MkRzRWRZanFz?=
 =?utf-8?B?L20zK0FwQ3krRThMNWF1dzZoSHNhaUQ5UHRQVU1FV3gxbEZ0QnptZ0lRTzFY?=
 =?utf-8?B?K2VVNGhnNVJjekVuYzcyMHBxeGRTRGZ6NGUyNWxyeUxYZ1NISi9ybHFkQ3J5?=
 =?utf-8?B?RENaRjRpZWZFMGpLd3NTYWpERFpvcHdiejlmamc2emk4Y3dwMUN2ck0zdUZy?=
 =?utf-8?B?NExtNVYvZTh2Rjd2clRiVXJkL0hUSTNMbUNyU3ZORkJxRUxhckprb3lGdStr?=
 =?utf-8?B?MU50QUxnTzVmWEpJd09jd0tHZEM5NTRzRWdhODQyeVgyMFEvdUxHblVCQjdn?=
 =?utf-8?B?K25LQnVFQXpqWEFwTW1qdG41Z2xjUS9ZZHdVbWtnNG1SbnhSNGZXYWJKY2ll?=
 =?utf-8?B?QzVja2R2OXV2d2RrdmNhOVJuU3FORHVsTVc1OXhqZGx3SkdIbHJZd2c1RGto?=
 =?utf-8?B?RHRqdHdHbXRzdDVZN0xOMkVYczZyMjFaWkh3bFNNR29HOVM2cGZRS2thL0Rt?=
 =?utf-8?B?VHZxWUZVMG9lL2U5MTFiMkYzakIxRkVkOXlkK2ZPNnVIZXdGWnBoa0tXYnNM?=
 =?utf-8?B?blZsRThlcVVPekpTaHZHYVltOUhxckM0UzE3RWFYczcxUGVTVlZxRXl0QmNi?=
 =?utf-8?B?OUQrZ3JScERickJRNnY1Tkt1K0pFSUtGeFdrN1kweVV0NXFMLy9UbDNETW0z?=
 =?utf-8?B?cnJHL1E4RWxibVlHaUVIK0tvUFlIbEJYVnAvUW80Q1F5ZHVpYkVNQWVqWXlH?=
 =?utf-8?B?K1YwbjAzQy8rWGR2OEJCMU5UZUV2RzI3R0tCSHg3Q0Z6SENwZEFJQ1ZSdXRF?=
 =?utf-8?B?QzNoQm5kTHcyT0FuOTlFRjROQXpBNExNUUpaUjNSU09jSzBYV3FwT20xQklr?=
 =?utf-8?B?cE9CbGE1MWl3L1FuSW83Zlh6L09ndEU4Z05ySjloTHQyWDRSWlRvVmYvQiti?=
 =?utf-8?B?OS9nUmN6NE1BQS9rRXEvK3MxalVDZURpWHNmVnVkamJjWENiN1BuLzM0YzhD?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3215D5D2196B104B9C9E534AE421B02C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da476b18-7b3c-426c-aa71-08dbb80edd6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 06:16:58.6293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6drI6GiZ5ba9cikuBGgZqtkE0y8UVD+01f4/e0fL5OE9DlGuBCKx8k3vJjXbsfUS4QRVEISwW4uko5XJO5abrA48s4Uc8QxPrC7CD3UeHaEP9VaKlIJ9aUxZnCmC3AHR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8073
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpTdXJlLiBUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uLiBJIGhvcGUgbXkg
cHJldmlvdXMgcmVwbHkgZm9yIA0KQWxleGFuZGVyJ3MgZW1haWwgY2xhcmlmaWVzIHRoZSBiZWxv
dyBjb21tZW50IGFzIHdlbGwuDQoNCkl0IHdvdWxkIGJlIG5pY2UgaWYgQWxleGFuZHJ1IFRhY2hp
Y2kgZ2l2ZXMgdXMgbW9yZSBjbGFyaXR5IG9uIHRoZWlyIA0KZGV2aWNlIGFuZCBkcml2ZXIuDQoN
CkJlc3QgUmVnYXJkcywNClBhcnRoaWJhbiBWDQoNCk9uIDE1LzA5LzIzIDc6NTIgcG0sIEFuZHJl
dyBMdW5uIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+
IE9uIEZyaSwgU2VwIDE1LCAyMDIzIGF0IDAzOjU2OjU5UE0gKzAyMDAsIEFsZXhhbmRlciBEYWhs
IHdyb3RlOg0KPj4gSGVsbG8sDQo+Pg0KPj4gdGhpcyBpcyBpbnRlcmVzdGluZywgYnkgY2hhbmNl
IEkganVzdCBsb29rZWQgYXQgYSBjaGlwIGNsYWltaW5nDQo+PiBzaW1pbGFyIGZlYXR1cmVzIHRv
ZGF5LCB3aGljaCBhbHJlYWR5IGhhcyBhIGRyaXZlciBpbiBrZXJuZWw6IEFuYWxvZw0KPj4gRGV2
aWNlcyBBRElOMTExMC4NCj4gDQo+IEFoLCBpbnRlcmVzdGluZy4gSSBoYWQgbm8gaWRlYSB0aGlz
IGRyaXZlci9kZXZpY2UgaXMgYW4gT0EgVEM2IGRldmljZS4NCj4gDQo+IFNvIGlkZWFsbHksIHdl
IHdhbnQgdGhlIGFkaW4xMTEwLmMgdG8gYWxzbyB1c2UgdGhlIG5ldyBmcmFtZXdvcmssIGFuZA0K
PiByZW1vdmUgdGhlIGR1cGxpY2F0ZSBjb2RlLiBQYXJ0aGliYW4sIHBsZWFzZSBsb29rIGF0IHRo
ZSBkcml2ZXIgYW5kDQo+IG1ha2Ugc3VyZSB0aGUgQVBJcyBhcmUgc3VjaCB0aGF0IEFsZXhhbmRy
dSBUYWNoaWNpIGNhbiBzd2FwIGhpcyBkcml2ZXINCj4gdG8gdXNpbmcgaXQuIEhhdmluZyB0d28g
aW1wbGVtZW50YXRpb25zIHNob3VsZCBoZWxwIG1ha2UgaXQgY2xlYXIgd2hhdA0KPiBpcyB0aGUg
c2FtZSBhbmQgd2hhdCBpcyBkaWZmZXJlbnQuDQo+IA0KPiAgICAgQW5kcmV3DQo+IA0KDQo=

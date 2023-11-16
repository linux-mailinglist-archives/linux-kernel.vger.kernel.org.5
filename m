Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79677EDB4F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 06:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjKPFtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 00:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjKPFtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 00:49:36 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B163A9B;
        Wed, 15 Nov 2023 21:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1700113774; x=1731649774;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=l+fgKfVj+VCmHO1cOQw/QldRhwjUCbsyKRRiO4cPedo=;
  b=RgFgaWBGDVeTiW4FeasfgTJLYWb6iXxHFib5ykFl8yWu44uZ0gjVd2fO
   4czNGHp/Vc6Mq3Mk8AHMR5d0ISuvRak2L/f4httWgRLh6bo0kPGnhvA2F
   HMmZLwT1BtZdE1vfSPcKgqVyDymnfYejIWWBUNn9fNsfnhVvblPbIae1j
   IaSWKij5HX6AHDrm2zV/zqQEJjT6zGy0oP3ymVXj/JA3BBbon9XTGaPza
   bsH0WpkV/anQvk3jiZZ7cDOEm7nE18w7lbuS5dTtrTjvc96qr4GpFMw0B
   wKU1Gzx1saaOGzZCqicuzDjRYT+0kXxQfViZr/0Ez1jUdwblzdfevHock
   g==;
X-CSE-ConnectionGUID: luCUOa3nQIeqGDr6Rr4omw==
X-CSE-MsgGUID: TGCujIpHRp2OrB1IZFMb1w==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="11805287"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Nov 2023 22:49:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Nov 2023 22:49:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Nov 2023 22:49:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKruLTg5T/yXGuTmUvO7OpJ0rb8cDmRndCAamxijskpknAuSsPz+xHNuN4PTl6BDM9B/LptfeEQahUt3Qc1m/JgQ5qCZihvLWcaG7BIJy2YBOcWSrczyqRK/5iYher08C+c6UeTzTl2PMtDd2uWcsjMNBEoizjPahNB1fhx+rv4G0c5epnJwfl+hYNw2HlPcCcIqsQHstdqp8DcwhJm0O9U7IQ3Pof03x+YNGGl1bN8SiYdgS46HGDgk1r1tZmvq0Er/u+82it2LlUBSfl8BTL7hFqlsvhq9m8TzujGHNYBnEI99tMrW0fJF0uh3VvPlaIdAiE6RgnaU0g+uVAZYxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+fgKfVj+VCmHO1cOQw/QldRhwjUCbsyKRRiO4cPedo=;
 b=NEwnp2mBpZZ+HlDpmMYWuqsgslKC/CMgcrdenbAVuHPDKKvxGxUysKP2LvmYpHtTusStvm+k7cH2SBBD1iVLfZhgwCpKMbZyYHl7uKwzR3SIEI8JW9Nzlg1sqU8ZkHibNYGqgi3tMlWIKI9Kw0Gak8hRCve2AnBafIDhuTKdtXPZQPtLop6QvBnJDWJxII0NfHeM2QVZ15vEO8AeY2Fa39q4hhq9qxrswl9i3fAjrwVSr8lc9hR+gQ+dtUcxjz2OYyKm+zgdkZJtr5OXjBj6I7k3sNE31vKiR0D3RU62KEYEM/WLWqs544wCZbzfxcEc4oQA7ZtZqybYuIiZKhCEJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+fgKfVj+VCmHO1cOQw/QldRhwjUCbsyKRRiO4cPedo=;
 b=tmiKYvwxYcr7B4Pe09wYYjiOg8OIsX1deuvQVF+7Jovmn2lYD/arBe3NFMeKgpm9F0Zcbhddgquq20IbrL3IVKLR+fPVX7eUbgw5n6OHPTyIesPMKjjDAX/sZTphgwTUfYjCsgQ78k2BtfxYZZ2IlfsLn2D7v35TbJk22iDqnuVFco4uPVtqkw6PAeeR1idMuizmoPoYacsinLFhXdj73z1SHu10lP9v6fFkwsyyMtsaEDUwPkK7x97YJvSP+Mx2U60tJrNgC8wP1M/PmYG5pjy/OH91L3dWTcug2xDyzC2laDgBqNP/HeNXX69YPYrShwrp0EsMgy48tKnkMpKNow==
Received: from CY8PR11MB7688.namprd11.prod.outlook.com (2603:10b6:930:75::20)
 by DS0PR11MB7681.namprd11.prod.outlook.com (2603:10b6:8:f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 05:49:08 +0000
Received: from CY8PR11MB7688.namprd11.prod.outlook.com
 ([fe80::311a:249d:c84a:1c51]) by CY8PR11MB7688.namprd11.prod.outlook.com
 ([fe80::311a:249d:c84a:1c51%4]) with mapi id 15.20.7002.019; Thu, 16 Nov 2023
 05:49:07 +0000
From:   <VishvambarPanth.S@microchip.com>
To:     <kuba@kernel.org>
CC:     <Bryan.Whitehead@microchip.com>, <andrew@lunn.ch>,
        <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <f.fainelli@gmail.com>,
        <edumazet@google.com>
Subject: Re: [PATCH net] net: microchip: lan743x : bidirectional throughuput
 improvement
Thread-Topic: [PATCH net] net: microchip: lan743x : bidirectional throughuput
 improvement
Thread-Index: AQHZ8QY1ceTQbXJwb0+3Qg4gMnoFrbA6DY8AgAALvoCAAAIkgIArKtQAgAzOQQCAAMt8AIAJ30IA
Date:   Thu, 16 Nov 2023 05:49:07 +0000
Message-ID: <dcd4e307326ac70a54f8a82bce0d8c10ce2b141a.camel@microchip.com>
References: <20230927111623.9966-1-vishvambarpanth.s@microchip.com>
         <20231004122016.76b403f0@kernel.org>
         <b1f64c44-0d1c-480e-a272-fb017e7d8673@gmail.com>
         <20231004130957.2d633d03@kernel.org>
         <ee81b2128f5178df95a1678d2cf94ad4edf2c9e9.camel@microchip.com>
         <0d0627cbd32afb813b75b485ea8e979ac027482d.camel@microchip.com>
         <20231109150402.12fda9cf@kernel.org>
In-Reply-To: <20231109150402.12fda9cf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7688:EE_|DS0PR11MB7681:EE_
x-ms-office365-filtering-correlation-id: 83fe03af-d233-4fd9-648d-08dbe667bfe4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y1NSf4AHvEZX3MLkZHh10hNE/Mv8wY5pbnhP/bMlqhU9kxQUwDAMJZVyZbtMSFGN15/l7HO+ke/1P0WtTD2I/06yo5KY8z7nTcOtwAqHuz99PWPq3i61NddcoX6lADbffGOEFc/LufAkRM37qRieqPyOK2oQOhtWbt0PkyfFi1AyPJrMMxEHMKRB0EqKGl5S9O1aWlpk0i1QcB8VDj8Wwj+RyK/U7wkOHW0JTJSBuPZ5ki4nQncRy3Ev5KVrRC8wEAYAXWw3vkKaTc26ZbHT7gG6mS8BL1pa8rZdsxORoBLHi9Nqm7B998yHlTo2JQHTxcR8NYs3ExmzJRVSztnXAnnDk+YGvKwCFrTkjyzsSQ1tMv3nLJAPgh9SVTCPrOVcWA5qVSpKixZY9JIyKcKgk7GRLnzE/XliJfEgaLut6kF9DSuMeUkK1iZgUN9frk/f0V5qCYgkr+3c8VWX5LrrQq7sU4/eB3T1M5Ay+YUs95aSkJnZDtXaPyU+XD3zWoac5LuftMkgCKu6Qb9lcyFr8YnfcAd2uizCHWFpbDDc4VNNgxIwZFta4PdRRfwSDhVteXemmcXhA3Us6vlyNKrvck74N6Ep2yLI8fa2/7TirndZFLKoRHvGntg2j5u8so+sVsF8Ve2JBJxg4pppzxl48G+wtIrASbpunDWmOqeO5zU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7688.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(230273577357003)(230173577357003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(26005)(6506007)(71200400001)(2616005)(6512007)(83380400001)(5660300002)(4326008)(8676002)(8936002)(41300700001)(2906002)(6486002)(478600001)(316002)(6916009)(91956017)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(36756003)(86362001)(38100700002)(122000001)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGhkTjAyRDkwK3I2MXJPVzdTNjFMTVpMTVVVMXFjaWV5QXg2dDcxM1kxTEdo?=
 =?utf-8?B?NWlpK3FyM1hZNU5qamtwSmpMZS9KblZTeCs3Q1RWZVM2c2w4ZmN1SFVwb2VJ?=
 =?utf-8?B?MEs3dUxGYjk4RkVZaUhiM0laeVVGVzczYVVqbWsybFVaNENMNXphbEYyYzN6?=
 =?utf-8?B?eTE0SndJN1VrRmpXOWpBREMvLzdpT1lROW5ZYkRGMmljVHNWRU1HSlhHUGp2?=
 =?utf-8?B?elVtQUZSSW9pdUdRNWNxWkprbXhxZ29PVi9GMldyQnR6bGg0MVJJV2JBd1Y5?=
 =?utf-8?B?ODgyTXFyVmtoNm10d2FjMmlmM1hYZ2hHamhpZkVmM3BTKzlDekpqUU1naUNW?=
 =?utf-8?B?TUZOQXdTeTZtMXd0MU9YSWFjeEh4YnVTQXh2MW5xenYza1IzVmp2MVB5RFlG?=
 =?utf-8?B?R3dtK1E5SFMvcEM5VFRxZXhrdisyY0tZQVJINTRQV2prbDltRXM5L3pQelha?=
 =?utf-8?B?STBnUmlFMS9FRTZnY3FXT2FtWHBwU1RzMHVyNHhmdnA4Y1dCaXpjV000Zmsw?=
 =?utf-8?B?QjgzL1NzUWxLZ21KMU9WaElLWTBpalF1Z2VhMkRVcEJmbnpqZlgweGFKUmFB?=
 =?utf-8?B?Z05wVlFBSDc0bnFZTWpyL0tvYTlQeEIzS3ZKTlBMU3YwZ1pUYTE1cHhKcStW?=
 =?utf-8?B?Ym5QVHhFWjRlZnkzYnoyS1ROVzRuMmVPbUJLZWo4ZDgyeEt2OWRpZlFpdS8w?=
 =?utf-8?B?bDBsM3k0bS9oaHNLZlIrVGowYnIxVlFHcG5KL0hicHNVL1hBNFUvN3dESFQw?=
 =?utf-8?B?MmZubVZPVkV4ZUVhY2FGYWc5WmZsaDNhaEhaUlpmc2R2blUvL3I2K25rbmpv?=
 =?utf-8?B?SkY4dzZRRExBRy9xUU9qOVlaeXNsaUNacTRuMHJqU3MzSERIMFRkQW5SUDY5?=
 =?utf-8?B?dHp3SmhmL3ppWE16TGEwT1cvQ0VzY0FzZzFWUUNnMDRmSkpablRjS2pHTFpo?=
 =?utf-8?B?K2RXbHRiVUY2eDFQWG1rRDZQUWFidVRMUGNocWZxZVFmbU5jWm5LS1dDb21Y?=
 =?utf-8?B?U1JnNlJkZ25UQ053b3BWRHZHTFVFK3VadDBBeHgzVEtsOS9BejZ1Wmp2czBX?=
 =?utf-8?B?cmdJdEpMUE5SY1pxTE5NQWpYdkdqcERuQ1BCekFBVXlMdFQ2b29FQllHNjZ3?=
 =?utf-8?B?bEdaZ1lSMWkrbnN3a2lrRkNMUGpQalRHbnJ4Ry9TaVdRMjE2eUdGVm5mQjFE?=
 =?utf-8?B?cW9SaEYzeFptRGVHbWxocDVDdFZTU2JmRlhJaC84UFloZW5uWm1sZ3JxMm5q?=
 =?utf-8?B?RnpES0xBaHdWVkVBSHNRbzVPc0xkclErWENacW9TdWpGYlpyT0xndDZJZ2dm?=
 =?utf-8?B?eElFckQ1ZDU0dmdxTFFBMThPVTJWeEVXTEJtb0xTdTB1QVNpMXBZNGtOQ2FS?=
 =?utf-8?B?SmVTcWQ3aVlsL1IxZmJLRHZ1UTVMQ2lqb1JlN01Fd3ZMUWJFazhKREYvU3Fr?=
 =?utf-8?B?U1BiWVVaOEkzSTB6NjJ4VGx0QU5pdXNhU3dDOE50WS9nUUJOTDhldElBeEVL?=
 =?utf-8?B?bHBZNit3ZmNJY3BJMWVnclhNTDVnWFRiMjlOQWdXVVhSeW95Y3Nva0VmZEph?=
 =?utf-8?B?V2J2bE9JZDVqUWs5RmdxR3A4M25HcFkvTlZUVkRieGtiMUNvc3VLVlZLMnpL?=
 =?utf-8?B?cVhIRlNxNVJieWxqOExvL0FrVm1rVkhnMGRHNDVJT3pLNUMyd3R5UFhveDFq?=
 =?utf-8?B?WDBSNFFBcWNmK2xqTkx1bUltT2dKVmZyc3RtY0VlNTVpL3RocDF3Q1NFK2Zs?=
 =?utf-8?B?SS9hcE5ZVGFDWWtyUXpka1VWdWR0aDhnYjZNZzR1enlIYjB2NjRpTXo0ay9I?=
 =?utf-8?B?aldMZmlWcEJFNVQ5S0dwMzAzVEVJNDFIVWhZUU5Md05ZTFNsQTFnZGk3NEdj?=
 =?utf-8?B?NHN3anRPZHloMkxoZkIwUmd4U2JjUWVWR1h3ZldnRFpobFJhbDNaREhhK0Yy?=
 =?utf-8?B?eUN4WFJ2UUpka3lkWjhxV1E1dXptYWpWU2psRjdISDV4RHora04yYU11ZUZl?=
 =?utf-8?B?RjN1T3ZVTVZqaDV1SCt0NENrdTFlWDg4S3BqdVBsVFBFMFlKd3ZVR3dPclRP?=
 =?utf-8?B?RFk2RUY3YURwSXNhVDVKditNSXlneDVoUHQ5STZUeW1kZGpSNkNXa25NL3F6?=
 =?utf-8?B?Q0pIUS9uS2dNK1M0cDNJOFA3SnMvdW0yVk53TjlBY3MrNU5OMml3anZrNmtY?=
 =?utf-8?Q?+2p5wC+lrvdpplpnnCmVIkM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E49FFF93503D8E43AEC1B177318BF194@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7688.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83fe03af-d233-4fd9-648d-08dbe667bfe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 05:49:07.8413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 04gI42clCkqPHY3mdE3SBiIqqb0CqXdpXINTo195FF9V6BKZ2h95WyKwDp4fiVT8QQAEi4+c2Y92Eg0doNLFildJK51ORT7bDvHC/c4s8Og=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7681
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTExLTA5IGF0IDE1OjA0IC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUaHUsIDkg
Tm92IDIwMjMgMTA6NTM6MjYgKzAwMDAgVmlzaHZhbWJhclBhbnRoLlNAbWljcm9jaGlwLmNvbQ0K
PiB3cm90ZToNCj4gPiBUaGFua3MgZm9yIHlvdXIgZmVlZGJhY2suIEkgYXBvbG9naXplIGZvciB0
aGUgZGVsYXllZCByZXNwb25zZS4NCj4gPiANCj4gPiBUaGUgZGF0YSBwcmVzZW50ZWQgaW4gdGhl
IHBhdGNoIGRlc2NyaXB0aW9uIHdhcyBhaW1lZCB0byBjb252aW5jZSBhDQo+ID4gcmV2aWV3ZXIg
d2l0aCB0aGUgdmlzaWJsZSBpbXBhY3Qgb2YgdGhlIHBlcmZvcm1hbmNlIGJvb3N0cyBpbiBib3Ro
DQo+ID4geDY0DQo+ID4gYW5kIEFSTSBwbGF0Zm9ybXMuIEhvd2V2ZXIsIHRoZSBtYWluIG1vdGl2
YXRpb24gYmVoaW5kIHRoZSBwYXRjaA0KPiA+IHdhcw0KPiA+IG5vdCBtZXJlbHkgYSAiZ29vZC10
by1oYXZlIiBpbXByb3ZlbWVudCBidXQgYSBzb2x1dGlvbiB0byB0aGUNCj4gPiB0aHJvdWdocHV0
IGlzc3VlcyByZXBvcnRlZCBieSBtdWx0aXBsZSBjdXN0b21lcnMgaW4gc2V2ZXJhbA0KPiA+IHBs
YXRmb3Jtcy4NCj4gPiBXZSByZWNlaXZlZCBsb3RzIG9mIGN1c3RvbWVyIHJlcXVlc3RzIHRocm91
Z2ggb3VyIHRpY2tldCBzaXRlDQo+ID4gc3lzdGVtDQo+ID4gdXJnaW5nIHVzIHRvIGFkZHJlc3Mg
dGhlIHBlcmZvcm1hbmNlIGlzc3VlcyBvbiBtdWx0aXBsZSBrZXJuZWwNCj4gPiB2ZXJzaW9ucw0K
PiA+IGluY2x1ZGluZyBMVFMuIFdoaWxlIGl0J3MgYWNrbm93bGVkZ2VkIHRoYXQgc3RhYmxlIGJy
YW5jaCBydWxlcw0KPiA+IHR5cGljYWxseSBkbyBub3QgY29uc2lkZXIgcGVyZm9ybWFuY2UgZml4
ZXMgdGhhdCBhcmUgbm90IGRvY3VtZW50ZWQNCj4gPiBpbg0KPiA+IHB1YmxpYyBCdWd6aWxsYSwg
dGhpcyBwZXJmb3JtYW5jZSBlbmhhbmNlbWVudCBpcyBlc3NlbnRpYWwgdG8gbWFueQ0KPiA+IG9m
DQo+ID4gb3VyIGN1c3RvbWVycyBhbmQgdGhlaXIgZW5kIHVzZXJzIGFuZCB3ZSBiZWxpZXZlIHNo
b3VsZCB0aGVyZWZvcmUNCj4gPiBiZQ0KPiA+IGNvbnNpZGVyZWQgZm9yIHN0YWJsZSBicmFuY2gg
b24gdGhlIGJhc2lzIG9mIGl04oCZcyB2aXNpYmxlIHVzZXINCj4gPiBpbXBhY3QuDQo+ID4gRmV3
IGlzc3VlcyByZXBvcnRlZCBieSBvdXIgY3VzdG9tZXJzIGFyZSBtZW50aW9uZWQgYmVsb3csIGV2
ZW4NCj4gPiB0aG91Z2gNCj4gPiB0aGVzZSBpc3N1ZXMgaGF2ZSBleGlzdGVkIGZvciBhIGxvbmcg
dGltZSwgdGhlIGRhdGEgcHJlc2VudGVkIGJlbG93DQo+ID4gaXMNCj4gPiBjb2xsZWN0ZWQgZnJv
bSB0aGUgY3VzdG9tZXIgd2l0aGluIGxhc3QgMyBtb250aHMuDQo+ID4gDQo+ID4gQ3VzdG9tZXIt
QSB1c2luZyBsYW43NDN4IHdpdGggSGlzaWxpY29uLSBLaXJpbiA5OTAgcHJvY2Vzc29yIGluDQo+
ID4gNS4xMA0KPiA+IGtlcm5lbCwgcmVwb3J0ZWQgYSBtZXJlIH4zMDBNYnBzIGluIFJ4IFVEUC4g
VGhlIGZpeCBzaWduaWZpY2FudGx5DQo+ID4gaW1wcm92ZWQgdGhlIHBlcmZvcm1hbmNlIHRvIH45
MDBNYnBzIFJ4ICBpbiB0aGVpciBwbGF0Zm9ybS4NCj4gPiANCj4gPiBDdXN0b21lci1CIHVzaW5n
IGxhbjc0M3ggd2l0aCB2NS4xMCBoYXMgYW4gaXNzdWUgd2l0aCBUeCBVRFAgYmVpbmcNCj4gPiBv
bmx5DQo+ID4gMTU3TWJwcyBpbiB0aGVpciBwbGF0Zm9ybS4gSW5jbHVkaW5nIHRoZSBmaXggaW4g
dGhlIHBhdGNoIGJvb3N0cw0KPiA+IHRoZQ0KPiA+IHBlcmZvcm1hbmNlIHRvIH42MDBNYnBzIGlu
IFR4IFVEUC4NCj4gPiANCj4gPiBDdXN0b21lci1DIHVzaW5nIGxhbjc0M3ggd2l0aCBBREFTIFJl
ZiBEZXNpZ24gaW4gdjUuMTAgcmVwb3J0ZWQgVURQDQo+ID4gVHgvUnggdG8gYmUgMTI2LzcyMyBN
YnBzIGFuZCB0aGUgZml4IGltcHJvdmVkIHRoZSBwZXJmb3JtYW5jZSB0bw0KPiA+IDgyOC85NTYg
TWJwcy4NCj4gPiANCj4gPiBDdXN0b21lci1EIHVzaW5nIGxhbjc0M3ggd2l0aCBRY29tIDY0OTAg
d2l0aCB2NS40IHdhbnRlZA0KPiA+IGltcHJvdmVtZW50cw0KPiA+IGZvciB0aGVpciBwbGF0Zm9y
bSBmcm9tIFVEUCBSeCAyMDBNYnBzLiBUaGUgZml4IGFsb25nIHdpdGggZmV3DQo+ID4gb3RoZXIN
Cj4gPiBjaGFuZ2VzIGhlbHBlZCB1cyB0byBicmluZyBSeCBwZXJmIHRvIDgwME1icHMgaW4gY3Vz
dG9tZXLigJlzDQo+ID4gcGxhdGZvcm0NCj4gPiANCj4gPiBUaGlzIGlzIGEga2luZCByZXF1ZXN0
IGZvciBjb25zaWRlcmluZyB0aGUgYWNjZXB0YW5jZSBvZiB0aGlzIHBhdGNoDQo+ID4gaW50byB0
aGUgbmV0IGJyYW5jaCwgYXMgaXQgaGFzIGEgc2lnbmlmaWNhbnQgcG9zaXRpdmUgaW1wYWN0IG9u
DQo+ID4gdXNlcnMNCj4gPiBhbmQgZG9lcyBub3QgaGF2ZSBhbnkgYWR2ZXJzZSBlZmZlY3RzLg0K
PiANCj4gVGhhbmtzIGEgbG90IGZvciB0aGUgZGV0YWlscy4gVW5mb3J0dW5hdGVseSBhZnRlciBm
dXJ0aGVyDQo+IGNvbnNpZGVyYXRpb24NCj4gSSBjYW4ndCBhY2NlcHQgdGhpcyBwYXRjaCBhcyBh
IGZpeCB3aXRoIGNsZWFyIGNvbnNjaWVuY2UuIFRoZSBjb2RlDQo+IGhhcw0KPiBiZWVuIHRoaXMg
d2F5IGZvciBhIGxvbmcgdGltZSwgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnRzIHNob3VsZCBlbmQg
dXANCj4gaW4gbmV3IGtlcm5lbHMgYW5kIHBlb3BsZSB3aG8gd2FudCB0byBiZW5lZml0IGZyb20g
ZmFzdGVyIGtlcm5lbHMNCj4gc2hvdWxkDQo+IG5vdCBiZSBzdGlja2luZyB0byBvbGQgTFRTIHJl
bGVhc2VzLg0KPiANCj4gU28gcGxlYXNlIHJlcG9zdCBmb3IgbmV0LW5leHQgbmV4dCB3ZWVrLCB3
aGVuIGl0J3Mgb3BlbiBhZ2Fpbi4NCg0KSGkgSmFrdWIsDQpUaGFua3MgZm9yIHlvdXIgaW5wdXRz
LiBIYXZlIHN1Ym1pdHRlZCB0aGlzIHBhdGNoIHRvIHRoZSBuZXQtbmV4dA0KYnJhbmNoLiANCg0K

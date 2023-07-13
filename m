Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2968751ED9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbjGMK2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbjGMK2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:28:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F8C170E;
        Thu, 13 Jul 2023 03:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689244121; x=1720780121;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=nQTkV6WW0LGtWBlkYUSrs+tkIJYzDNsuF0SSSmLUNig=;
  b=RXWOFTbAZ01FZYW5vlE7C+rbjrYvpGNCr6yMLjwG8bGlVoGJLSfibaJk
   4IkPP4aMJl/r21oSkhx8b7fiEX3XuiDnIlnQfnXP7inQMxWU8x0XLbbU5
   9NM0YkYyDmXxA7fjrMiaN1Hwuxpvfgt8CKh+A3GAvXit0JFy/z+TPD03e
   +rctyPXdJhXYr2HCG1gF6p75RpJFgi4x/izQsXdvRSGW7GO3L4Dao+a+a
   tcM53UyQkyr5j2hxbti+st5O7srl0u6FowBjwnrXCheSlASj7psTjzxda
   4SHV5nJqckZTUZQPxboC9YE6ZEjqvMzkymVnQm4dGtcdCXCIdbzeWJjpj
   w==;
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="223564732"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2023 03:28:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 13 Jul 2023 03:28:32 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 13 Jul 2023 03:28:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lR2ApVE+CDETAUlLwF2RP/Ad0uQvT4MsQ8YpwJizuq36D+WAYhikXgqtvSrOtivsPY8EggqSy1yo7Kx/D9/j68WS2eU+hpZiTotxEmcXD0unHnBVTDPhEncNczvO8O0Z/xUMkFhKrHRF09wf+eVo783+dN/hiz9okAtum0Go80eHgSnWfBH4tDDz7xEGZEC0Z6WFBGtWCvRS8105TXYlsykYW9FGSAdbsBhxPkKRtPlgN4LjTgb8HcTG9ETrTFWPzGgRxmetpvOJ/73BLUFnbkX6TVkH2lF0Bh1UdCNr9H/v38EW/DLApJDDYrMEOORh1PHwq9/EfHeYxVFcxMohEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQTkV6WW0LGtWBlkYUSrs+tkIJYzDNsuF0SSSmLUNig=;
 b=mn8cYUfhHK+fZYclO1ak+RCuTw/hxo1atMlLXPfKDV1IBdnHAlv+peWDq0VoGe3a54YJtj63Xl/iibJYs3mfo8xUuNDTlCXUXhk7ueqtZWD00M1B6AsQ/J6NBuznzI+WK2ZbKk8L0SxLKfsfSyw1getAFXtQjGfJOcPtemke52nig5dgTKkx9glamkOaQ6LJfHr4Yf3XlsfhNixyAQYOYnKQA547gtlO/zbrgoEBe+6qtTM3syPXlknn+/INtBCyhvMfeG2/48uK1Gd87h9QquJL5tk0n3NF1O84lFP7GSusTMp6a6n4MEWdWkE8qN1bkUl/UAjFPqKWZOQhu+J4MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQTkV6WW0LGtWBlkYUSrs+tkIJYzDNsuF0SSSmLUNig=;
 b=HDnhvsUuyYsPbEK307VDLO5Ib5Sc/vBNH3kiTVKYQPUIrnSExAVAulU1FDDfc9Yg5FucGmcUX6XYAdbPOjZLJgcBGBd08Zv1Jq4BQ3T6gOtwRO6z+Bqyuck8J3fXTRKJNu8tAH+vO+CjQLwOktmSwiNM74yUG4TNJIiZsonatJY=
Received: from DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14) by
 SJ0PR11MB5868.namprd11.prod.outlook.com (2603:10b6:a03:42b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.22; Thu, 13 Jul 2023 10:28:30 +0000
Received: from DS0PR11MB6541.namprd11.prod.outlook.com
 ([fe80::decf:e31:9c2a:f242]) by DS0PR11MB6541.namprd11.prod.outlook.com
 ([fe80::decf:e31:9c2a:f242%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 10:28:30 +0000
From:   <Durai.ManickamKR@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <Hari.PrasathGE@microchip.com>,
        <Balamanikandan.Gunasundar@microchip.com>,
        <Manikandan.M@microchip.com>, <Varshini.Rajendran@microchip.com>,
        <Dharma.B@microchip.com>, <Nayabbasha.Sayed@microchip.com>,
        <Balakrishnan.S@microchip.com>, <Cristian.Birsan@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <davem@davemloft.net>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <Horatiu.Vultur@microchip.com>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <michael@walle.cc>, <Jerry.Ray@microchip.com>,
        <conor+dt@kernel.org>, <jesper.nilsson@axis.com>,
        <andre.przywara@arm.com>, <ada@thorsis.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <gregkh@linuxfoundation.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>
Subject: Re: [PATCHv2 2/2] ARM: dts: at91: sam9x60: fix the SOC detection
Thread-Topic: [PATCHv2 2/2] ARM: dts: at91: sam9x60: fix the SOC detection
Thread-Index: AQHZtW+64N0CM5hH10a5WiEhSRpsxq+3d66AgAAG+wA=
Date:   Thu, 13 Jul 2023 10:28:30 +0000
Message-ID: <9a29d928-d1e6-ea55-c5dc-0a884978b8df@microchip.com>
References: <20230713095111.335346-1-durai.manickamkr@microchip.com>
 <20230713095111.335346-3-durai.manickamkr@microchip.com>
 <204ad135-5358-35d0-2df2-9495acf0432d@linaro.org>
In-Reply-To: <204ad135-5358-35d0-2df2-9495acf0432d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6541:EE_|SJ0PR11MB5868:EE_
x-ms-office365-filtering-correlation-id: 4decdfe7-4081-4501-7a1b-08db838be6f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Mf2DT6SvVmmzJZswc29qBoTmvc85+uGxnxw7C0NcATjH/KMfY1YJAtqJOaOBAgWZfOJwOtw/1zw+Uiecp5yEkQb63NKU8fVHrrGAaZv+O/Desy5mPVB2HBs92lVG3odWdC0OSyhdM69tzlnfLxmgNuDJ5V9LHdvCfuhKWkcg28z+bnnWiB+H1r5FiXSGVQN2GncupmLCxeLCP9HOEPqx3dGxnzjXbCOdqAEaf9Neo/Jr0rd7Ru1AEnsT8pAjv/gakMJGkMcRmKSZuRb7/R6wgE85FhxwaZtK6OCFAeKY6fERmGFJ+KEskmTrcfNBT/Ow/kn91tvdVFzf1y087Hj0hZdh37zF/37VqRNRbXWgCdsClGseZspEEQTC8VibzKribCns6ILHsRwQ+IHRmh2J5w8riUzYiJZqFh5NiBjKzuUDceLmly7JRUwTt5gpYakzWzUGtH5oYts9qRzPOc+otNcR1XDnk97PLZRML/g3Az4Ngz9SsRhyQLfTqcdyca9EqE/+CyLH1Demu8AlvkvHhQQDUPnhUsrkYSdByHbphyfcf4E+cIlmV9dWR2l+yQSgclXVsVG2a1yRxN367phiDRVn9Gpm66qu0WT3xynWeETTIozk39b7kdL+vuaLDEiN0wjXLTIJ8Sf0migN1dN06SUmjZcC0n0kuGjjyTD3NM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6541.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199021)(478600001)(110136005)(71200400001)(6486002)(91956017)(66556008)(64756008)(66446008)(66946007)(66476007)(76116006)(31686004)(6512007)(316002)(41300700001)(921005)(2616005)(2906002)(186003)(4744005)(122000001)(7416002)(8676002)(38100700002)(8936002)(6506007)(53546011)(26005)(5660300002)(36756003)(83380400001)(86362001)(38070700005)(31696002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RllydGRRZ2hpL1BaclE5cEs5bWE5amNMMVN4akNwUEFqYy9nNHcySTcwclBz?=
 =?utf-8?B?a01iSEphTmgxVE1peTR4R0k4RXl5RkNKajVvSkdPUmIya2hOazNnbGJyWE1D?=
 =?utf-8?B?eTNwaG1XRG5uaVRqcDZSTW1mbkpZRks4aHI1anE4Z05FY1BYc1FIYXFjengy?=
 =?utf-8?B?SHI4WDRRYjB6NkZITTd6Q0VGM0hnZzNpazk2WG0yeHlzS3BrRmRsT091UzNn?=
 =?utf-8?B?VUJjYllwNUczQnk1aEFETTFNMlJGbFJBUzBVYkplQzlMR1ZoUzhIVTB2ai9u?=
 =?utf-8?B?dXp4OHd0RFlpSFhRZVdvWEdWNDdtVm5RcVVxa0NlZ2lwWnM0T01ZU0JYZFRh?=
 =?utf-8?B?SXlzd1o0YjNMcmJQa1EvTitWajN1T1l1N1NreVFzbHkzMmdvZTlqVHJpOUZt?=
 =?utf-8?B?akxHZW5zSWRIblJZYThiTXVFdzVpTStpdUNpV0h0QnJqSXRWM1V1MnJkaWky?=
 =?utf-8?B?dXA0VVMvSHpnUEVtY0hZRDEyZTVRMkt0ZDNKbE5pZEMrZm8vUjJuMWRQSG0r?=
 =?utf-8?B?TWtSZDBtYklFRlFpL3hneU84Q05HVmFDaVRjVXA1RWR5andZWkgzWW9uT0NQ?=
 =?utf-8?B?UmM2dEVSOUFOMXMwaU9ZK1Vna0NiWnZXMkVMZURNVkxyeTJsVU1jaXI5NlAx?=
 =?utf-8?B?Vm15VFdsbzgwVEdDRzZGOXJQWUM0RGFkUlJUNDlaSDJlQTdsNS93RTZmdlNm?=
 =?utf-8?B?a2xVMlNOeEM5dVZyUXZCVmpGcld0c1J5a1FsYXdKaGwxK2tPcnVpWThwRmV2?=
 =?utf-8?B?cExxYmN2SnhneHh3UzljZDR1Zk10ZU9HVEV6aWVudXdpOVBGMFZZYjdseGsy?=
 =?utf-8?B?Ti9RNHFBWmVlUHhYakp6bElBVmFGd1V0bGR5enVHS0FHWUYvZmZKUkUydXRD?=
 =?utf-8?B?RWlqQVhrOThnSnllVDFvVG84T1drZXpVZE1Qb0FWazF2WU1ocTBsb0tvNUNT?=
 =?utf-8?B?NXZmSjkzWE5jTWNpNDRPSTBMRm9DOUVxeExmTjdjWVk0NC80elhPMnozcUpy?=
 =?utf-8?B?SGYrV0IrVWNlcmx5ZGx2WFRKbEVMdHBGVUh5NXptbmp5VkpiSms1TitQZS9T?=
 =?utf-8?B?K3RHS1Z6S3ZKNTVQc3h2ajlZcEZiNFZmU2RHbDY0WHdIbmlKOHRaUVBmbHFN?=
 =?utf-8?B?VXVWYnI5bUxITVZDcTZ6WGZ5SzBwS3dJc1JVV1FvMmJDd1AxcWRJVU5RWjcx?=
 =?utf-8?B?QVY5OThDZU56NnBudXg3dHovRFg4MEpFbGNhaStjL2VlRHpVM3h2K1hoV2xM?=
 =?utf-8?B?RFJqbTdOQ3V6czJ5VndlVE8rd3ZQbU5QbklHbjNFK1NmcXV6QTJlSFp6dXlX?=
 =?utf-8?B?ZjlmbW10Zm1scHNOcXY1NEVwaFh0VjE2OEJXbkFTaVgxUmhGU2crajNENnNv?=
 =?utf-8?B?ZGk5eWZnV2xzTXZyQVRsWG0vamhWdG04Z0ROUmIyQkwzYnFXYXFWN0RhdmJ5?=
 =?utf-8?B?MTVUWG1jMjkyMGdHVm5VRXhNVjE3aHJXSVpwQks5QXNHdmx2L0NaM3NmU1dG?=
 =?utf-8?B?V25WblBWUU9aL29TUG5wQVVmbk1qaXk5VGszYmRVMlJ6U2RvZVNQZ2lDTVE0?=
 =?utf-8?B?RE1ZSzZsWXBrNDdTVmhZNW5KUHl2emR0OWlDZEp5Z2NWelA3c29sMVRqVksy?=
 =?utf-8?B?dHAzZUVGa0Y2SnRtczYwSU01SlRZbmNxWnh0S2h5RVNiNjZiUVZOUHhzOTZB?=
 =?utf-8?B?ek1KQStITDJmcko1YzczUTI1bjlNekZZV2RTYjJvUnZSTG9PVjZpTmlaYXhD?=
 =?utf-8?B?QmhSYTZPQllrL2VpSTRzZWFaZHpQV1dYTjIxVGFZcHFyOHd1TWYxQXFwNFFp?=
 =?utf-8?B?Z3hCOHMvdVh3ZFpOeU50UEU1UUtBSjhmVlRIcXRxVm5wQWpBRFRMWlNjR01H?=
 =?utf-8?B?Zy90K2FGZ2hWUjJvOTRQak5MNzJUNzVLRkFUdjZxb1paTUloL2NwNTZyTFJY?=
 =?utf-8?B?NHNWbXZmOUJubDFFblEySGdWcmZLRWt5ZlErOGZIejNHV0tham5NOUFmUHFV?=
 =?utf-8?B?S0greDl6TkZzak1hMG9PdCtSTWlReno0OEhKVUtYZVJqL0VwbEdaTmtOYzAw?=
 =?utf-8?B?V2VBL1lvVFlHVnNraHp6SFd3ZlBrWFJ1L0xzc0Y4Y25lWHpZTGw5YkRBMGFS?=
 =?utf-8?B?eW85a1BIZ2ZPOHpiNGw1NGo5VnJjdnBZcDVWNENRa1NpOTU1WTMwTUZQaWtJ?=
 =?utf-8?B?cnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71690CBC689CB642AEAACF3FEBA19186@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6541.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4decdfe7-4081-4501-7a1b-08db838be6f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 10:28:30.0998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7X/l3s5/ZMlStJMshpiwdL+63UZV4SswdDqtXKYormXT66PpvDdXz2hwAaEyHJvCZpH0dslP8IBm+b9mqpp/tdImtGChTDuCRwbqmielSyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5868
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMy8wNy8yMyAxNTozMywgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+DQo+IE9uIDEzLzA3LzIwMjMgMTE6NTEsIER1
cmFpIE1hbmlja2FtIEtSIHdyb3RlOg0KPj4gUmVtb3ZlIHRoZSBkYmd1IGNvbXBhdGlibGUgc3Ry
aW5ncyBpbiB0aGUgVUFSVCBzdWJtb2R1bGUgb2YgdGhlDQo+PiBmbGV4Y29tIGZvciB0aGUgcHJv
cGVyIFNPQyBkZXRlY3Rpb24uDQo+IFdoeT8NCj4NCj4+IEZpeGVzOiA5OWM4MDgzMzU4NzcgKEFS
TTogZHRzOiBhdDkxOiBzYW05eDYwOiBBZGQgbWlzc2luZyBmbGV4Y29tIGRlZmluaXRpb25zKQ0K
PiBJZiB0aGlzIGlzIGEgYnVnZml4LCB0aGVuIHBsZWFzZSBjbGVhcmx5IGRlc2NyaWJlIHRoZSBi
dWcgYW5kIGl0cyBpbXBhY3QuDQpQbGVhc2UgY2hlY2sgdGhlIGNvdmVybGV0dGVyIChQQVRDSHYy
IDAvMikgZm9yIHRoZSByZWFsIHByb2JsZW0uIEJ1dCANCndpbGwgdHJ5IHRvIGV4cGxhaW4gdGhl
IGJ1ZyBhIGJpdCBtb3JlIGluIHRoZSBuZXh0IHNldCBvZiBwYXRjaGVzLg0KPg0KPiBCZXN0IHJl
Z2FyZHMsDQo+IEtyenlzenRvZg0KPg0K

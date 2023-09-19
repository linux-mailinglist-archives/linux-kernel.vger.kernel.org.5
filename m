Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A327A6464
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 15:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjISNH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 09:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjISNHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:07:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B53EC;
        Tue, 19 Sep 2023 06:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695128870; x=1726664870;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=R0Eqt6Sunjb0T0bEj+OzVd3eGZ2kvSSy015k8c2vIbg=;
  b=zZAvQU7ZTx1sIDAJp6XDx5RCUQQI7Rwlb0sh2RN/3PAjT75XksTNcRlU
   yHw1f0Zh5FJ0KCqna3XqQk5FvZNeA0lbek2oW3BlFW8RgQBKmFNIMShaG
   bTTLgB4/P62b5aQVnQRMH/7NuliWuA7vcp+edkPQrCkpU/8BRuvpj+DYT
   h/vnnerCRBU1Ar2G8q3ImtEHoXT++N/s7ruzrx2tuMlUGH3wRG5fWzqzS
   HaT1a1+stbW55wWJ1KVQoxJeOrf6EQRFg3Xl5EfQMRdshCyRVNVbRYX4n
   a+7eOwMErV2Y5AKxk0y1o8vHzX50+UgSFEaIkEaMVETmY64CvEtUYXYO1
   A==;
X-CSE-ConnectionGUID: rUXVP29/RyaOK7j9jKEvpg==
X-CSE-MsgGUID: 5f2Y1L1eTGKXpDRlp4WN2A==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="5431435"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Sep 2023 06:07:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 19 Sep 2023 06:07:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 19 Sep 2023 06:07:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwNv0AkkoPNZtpLbKYpfPiWBaMPZGHz/T089sCR+fScqqR1D2MGzcnPbPCBGj8gL/fRmLnzpVbbBsvuHhgzjtYlCYdlIGwcdX2MrDG16E2ntRY97VQFdUczkHya3etVPCXNzPbimqUwGwM+sgGX1v+tnOAiKB7lqjZisLnCJA5l+gF2jodMzFdleLXBD/g0LDD3a4kg1/rUB4+UsIPuMVUR7wjCpyo5vBWRwBPIENOb76amdJldxGMoqQhCnQD+Gazt6u3nO/7w3pxP+G9XlsfNrAfJLvoO4mUbPi5DJy451g0EQHrBwA3dz5rBr2lHXK/prRnnKiZGsbYBhlHXDSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0Eqt6Sunjb0T0bEj+OzVd3eGZ2kvSSy015k8c2vIbg=;
 b=RfvM+ipOG/ODiMele2AtegodQedfYhWL7kS4K+xmEu2249Xs7TKCfvhy50z3iNoYLlXvmSRcSP+I364wMq/XgnYcQ/CKtMpe/+QnOZyobOo3Wd/+w4yIz6iC0m5CGPb6QxMZxQBWfOTQeZgcmieclTlot0J82GrRRJZiL9Ef5IgVM1cKmmgHOHcoNNhR7wBXcBS4cctM295M7A+xULtR0VXnX+7x5qXJ5xjBE8DqBZpwYQyRU7XYhx7ybOZGH1AzuJeX6x95QefG85p0hgpxyW1OcJaVgeOY/LD31hm1LZu2yOSDQ9Ghfd6j6ElQo79n9OpEao+0zhqMQRvsyo7iAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0Eqt6Sunjb0T0bEj+OzVd3eGZ2kvSSy015k8c2vIbg=;
 b=QvFKJ6iQ5KrClLijuUt9XE76F/B5buNrueu1r4C9RfoWXxysMAHOUFVHP4YH22bGfa0MFLkZr9SGKQfzmQ7xZ95ISealjhCDnkSyf4VaAQkgXQ83GKI/hFjc8Op8YzLc+xlLbh34OhLXg0KK6kooqCfeZGITvtMByXtNYZ10RtY=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 SA2PR11MB4777.namprd11.prod.outlook.com (2603:10b6:806:115::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 13:07:45 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 13:07:44 +0000
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
Subject: Re: [RFC PATCH net-next 2/6] net: ethernet: add mac-phy interrupt
 support with reset complete handling
Thread-Topic: [RFC PATCH net-next 2/6] net: ethernet: add mac-phy interrupt
 support with reset complete handling
Thread-Index: AQHZ4mEM4q/YL0tg8UaR0849XBWWbrAYElWAgAoddwA=
Date:   Tue, 19 Sep 2023 13:07:44 +0000
Message-ID: <852a61a5-8c15-1b5a-bea0-2f0d936722df@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-3-Parthiban.Veerasooran@microchip.com>
 <027d8f7b-6932-4d9d-b2f9-5369806a79a3@lunn.ch>
In-Reply-To: <027d8f7b-6932-4d9d-b2f9-5369806a79a3@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|SA2PR11MB4777:EE_
x-ms-office365-filtering-correlation-id: fc234d39-db4d-4d9d-1516-08dbb9116a03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AO1WpvBkNjFsrB7/5toGF7jVOxHPi0z0eqHK6I6E/mRGhOdS+zNPYBVDsnJasmZw+7v98tfHZohqjyWec0hURanPG/MnMggv183O/Aq+3NJNeYxbyGFl1SUENnX2NsfbQRPWTq+YX0HJ/uJAOCxW9zwQYON7uRivSXqUnGjY6WWj50hoG9t2hSPbmQI1BpyJ1IfYGeYC8oRRbPCTc/gp6evQJMoS2MideurJdxbN9YgVFdMCJonAlo9KNVON0BXbq1/E6sA092R8nYLbpRVuorYZKDEhxSkx61zg1rnetm5HWhv43NstpW1h7zKaFQ+3HTXzL5Wk6np7gfDCvtZu1VgoC2M07BtiNQYVi6g5BnpUpcR4OhHKnT+TzZAjG4MNw64Z3YA4D47cB4BVFl6QSosBsWLT3ZwMhOicQLzMjax7txVpS+K/4aBlXvoaHtiWLoJphygBPvVoHNq6x6CjAOUdbU/S45Y3C1R8UgXxwbbH2Yb0whXJFJC1EdcKIAIIGKRwin+UjeA5/gdjwJV+xRuapyzJNssdacLbVovAJFd7e/xps9UiUbaCseGqaqOEmWdcev3Lx+1FjjNG7ssWXH+miAPj2jdCg3D5QySD6gFFIcIMFt5ogG/Pkj0yDAOumJ32QauPcC4pnik04vuZn1TXs4aXB5O/W71adc4hZhLosc6cPx4bVg4tDoxurJzo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(186009)(1800799009)(451199024)(316002)(54906003)(6916009)(8936002)(4326008)(8676002)(41300700001)(107886003)(26005)(2616005)(83380400001)(6512007)(478600001)(6506007)(6486002)(53546011)(36756003)(71200400001)(86362001)(31696002)(122000001)(38100700002)(38070700005)(91956017)(76116006)(64756008)(66556008)(66476007)(66446008)(66946007)(2906002)(31686004)(5660300002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1pNRytPOWJ2UjdkUmRqM0hFT21SU2xkcmloR3FGOVdXeFlIR2FDb2lseHRK?=
 =?utf-8?B?d1hRcEl3SkhYMHpwdUtBQnV1RDI4S3grQ0VFcHpuMUpWNTVhcHFyOHhaRjhq?=
 =?utf-8?B?VEtBMUg4TjIvYkFaaTQ4VVRBR0h2dWFYS1k0VE01ZW1rSUo0VkEwOXpEYXkw?=
 =?utf-8?B?MXdrdkJGS3BFTkxCcmpvejNlODRQZ2JIWU5QUUhHbmFOa1MwVUNSNk5MQklT?=
 =?utf-8?B?OVc5dkZEbEF5bnZBRUowUjdBVFovWE1UNWFGYncrakFML29Ma1ArdC90c3dY?=
 =?utf-8?B?KzhITElCMEV6MStGYllIR1FwYmRrbVp3R3dhYlZOZk5DQlE2eW1hQW5GVmZS?=
 =?utf-8?B?ZmZsUWNQUXNkSC92ZEx4WmtoMzVTK1RxOHNCRE12dUlGV0NLVVlJNEEwcHJE?=
 =?utf-8?B?Y0xKTWM1ZEpBNm9zVWcyZGljeGgveEQ0dFd0cXNxQStGOFg5M0pYUWdncjgz?=
 =?utf-8?B?bkRuWEgyWXZITWxlM2ZvdmZYakRrYWQxajg0c1MvYzBlVzlxMkZzc3VMMHdJ?=
 =?utf-8?B?RzV1NE1jaWM3SWVBWGVEbEllbmZPUERkY3RzREZuamJQYkpqd05lajJ2Y25D?=
 =?utf-8?B?RXdKakd0YW40c3NOeVUxYzk4WDJ1UDlxd2x5OC8rYVA1QmpsSTZ1RkNCUW1i?=
 =?utf-8?B?OTlKaXJPUGZJNSs1eWhwdWhGbkxaRXVUZGlMSmtPT0k0QXlFTHE4NVdSTVV2?=
 =?utf-8?B?VXdHSDB3UTFzS2hhWjgzU0JZNXV3a3ZCM1ZUYnJwOTRuMlI1a01pY241Q1A1?=
 =?utf-8?B?ekhBd2VaSzJDV216YTJvdVg3VjloNlBnWUExRFZXTUJzR1JsM3IybGI0Smla?=
 =?utf-8?B?UkdXUU81c3YrUVJHeHRaL0RVcTBsNlN3RHdoalJFazdkTDY4RnpDTWJ0RkxO?=
 =?utf-8?B?eW1LcDhISGZPbDVtMlhJZ244V3NacnNaUExpYTR3UHNzNlFnNjFpbjFFZU0w?=
 =?utf-8?B?Uzh1SUs4NW82bTFORE9aMzVlcWZtTFA5cWE2ZUkvUHNKcW40OTZtVldEb2hC?=
 =?utf-8?B?NjVadk9GenA3U25YRUZXWW1NTHBpOHVCQU8yMGRON2FTM0c4YVZQYmlkOGcz?=
 =?utf-8?B?QnByMFJ4c3VMS1ZaOHRsRWlBWnV3bWUvQUdUbDVFTGViSEZWbSsvM2gyajl4?=
 =?utf-8?B?YzhFTTFKNnIvRDdxa3JEeGt6WUxydDZMSTNQUWtyRUFpVmtwUFBHSndzM042?=
 =?utf-8?B?UVRsOU9WUVh6OXhKTTQ5eGdzOTEzR0JDalhjZXZSeWJEbUJ1NjVJemUwb2tx?=
 =?utf-8?B?Y0JibkRCYklxMWN2aStDTkQ2andIclVZOFl4MU1MV0tuN3RJTTZpZnk4STlw?=
 =?utf-8?B?T0cvSmxLaDRrbnBaVzE0MDhDeHlyWm1uOEJVY0szSFVCQnFZOHR5MG9aRDYz?=
 =?utf-8?B?UWM2d2x2ZWFXelRDc0pBeFUzUi9lM2hKemdUSzBCb1pwMm9HeG9raUNLcGt1?=
 =?utf-8?B?cTVhY2t0WUdHZEdCeWkzUVRqQzJQSVA1TUMyaS9GWDdGUnpVdHF0aC8rSWc3?=
 =?utf-8?B?SkgxMldIZlFqWWxIR3NsRmtHQXMyeXdORnFuWmZsWFgyekYwTEZkeU5qYkcx?=
 =?utf-8?B?RUV5b3FSd0ZhbWhEd3lyOVE5eE01Q05SOExpdUk2UHV6MGlRZEtKMDRNRWpx?=
 =?utf-8?B?aVdNVVM2QWhNNWJ3amx0MkkxL2xWRUhRUzB4eEVKUlZwVzhLZVdYeUszLzJI?=
 =?utf-8?B?aVowU1dzeTNqdGNZR0dGU0paSndZb2VReG4vaWtQVzZCTUtFRzRsQVFEZDNM?=
 =?utf-8?B?TEZHei9UbE1PTTJhK3lqLytRM2pvMGVDRHJTUjg2UXg0TXpOZVRKbjIxdllX?=
 =?utf-8?B?VXdzdE9Mcnh3QnpDRW8wZG5xRFdMa05LVDVuVWdQWW1qa1poSEZTY0F0SlRx?=
 =?utf-8?B?VTJZMm5zblFuWTFVVHNsSTJ2TXBqckpqMXJwL1V2TXlVN1JCOUFqbUY1SUxn?=
 =?utf-8?B?WFZIcFNjc3pJZDBsWGg5L1Z3Nk9LR0dZSEZHVW9hQzc4TWVUODRETURlKzFK?=
 =?utf-8?B?YmNBZVFHWU5vc0V4cmgyK0dXc0JiR2hNRE00TDVWZlJUUFRYZ1hZRjkrNDBI?=
 =?utf-8?B?SzFFWFlCc0dkWnA3TDJCWHRFMTA4M3l6cTFDKy9tRVJwWEx2VEgzSVVWMFNF?=
 =?utf-8?B?YjVEYVZoUWtFa2MxOGhvWTRTVGJ6cmlhWTZCTGRYWjYxblNVTHFNQSs1RnV3?=
 =?utf-8?Q?rjP/eeVgunIJsyxgHoAGMAg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF5AA83D8DCDB447ABBC6D0DD199E1EF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc234d39-db4d-4d9d-1516-08dbb9116a03
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 13:07:44.6777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nworRuT+uSsfxlB9CKB1l2MaT801sUc5b1ipdPal11hSrfG0yDphKnOMV7vG66ATl4zni0+upKLSBGy/RxhpvnxVPPiSPjlI3xEM8Gt4DqJHygALv9DeojIk/S5EORkd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4777
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMvMDkvMjMgODowOSBhbSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4+ICtzdGF0aWMgaW50IG9hX3RjNl9zd19yZXNldChz
dHJ1Y3Qgb2FfdGM2ICp0YzYpDQo+PiArew0KPj4gKyAgICAgbG9uZyB0aW1lbGVmdDsNCj4+ICsg
ICAgIHUzMiByZWd2YWw7DQo+PiArICAgICBpbnQgcmV0Ow0KPj4gKw0KPj4gKyAgICAgLyogUGVy
Zm9ybSBzb2Z0d2FyZSByZXNldCB3aXRoIGJvdGggcHJvdGVjdGVkIGFuZCB1bnByb3RlY3RlZCBj
b250cm9sDQo+PiArICAgICAgKiBjb21tYW5kcyBiZWNhdXNlIHRoZSBkcml2ZXIgZG9lc24ndCBr
bm93IHRoZSBjdXJyZW50IHN0YXR1cyBvZiB0aGUNCj4+ICsgICAgICAqIE1BQy1QSFkuDQo+PiAr
ICAgICAgKi8NCj4+ICsgICAgIHJlZ3ZhbCA9IFNXX1JFU0VUOw0KPj4gKyAgICAgcmVpbml0X2Nv
bXBsZXRpb24oJnRjNi0+cnN0X2NvbXBsZXRlKTsNCj4+ICsgICAgIHJldCA9IG9hX3RjNl9wZXJm
b3JtX2N0cmwodGM2LCBPQV9UQzZfUkVTRVQsICZyZWd2YWwsIDEsIHRydWUsIGZhbHNlKTsNCj4+
ICsgICAgIGlmIChyZXQpIHsNCj4+ICsgICAgICAgICAgICAgZGV2X2VycigmdGM2LT5zcGktPmRl
diwgIlJFU0VUIHJlZ2lzdGVyIHdyaXRlIGZhaWxlZFxuIik7DQo+PiArICAgICAgICAgICAgIHJl
dHVybiByZXQ7DQo+PiArICAgICB9DQo+PiArDQo+PiArICAgICByZXQgPSBvYV90YzZfcGVyZm9y
bV9jdHJsKHRjNiwgT0FfVEM2X1JFU0VULCAmcmVndmFsLCAxLCB0cnVlLCB0cnVlKTsNCj4+ICsg
ICAgIGlmIChyZXQpIHsNCj4+ICsgICAgICAgICAgICAgZGV2X2VycigmdGM2LT5zcGktPmRldiwg
IlJFU0VUIHJlZ2lzdGVyIHdyaXRlIGZhaWxlZFxuIik7DQo+PiArICAgICAgICAgICAgIHJldHVy
biByZXQ7DQo+PiArICAgICB9DQo+PiArICAgICB0aW1lbGVmdCA9IHdhaXRfZm9yX2NvbXBsZXRp
b25faW50ZXJydXB0aWJsZV90aW1lb3V0KCZ0YzYtPnJzdF9jb21wbGV0ZSwNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXNlY3Nf
dG9famlmZmllcygxKSk7DQo+PiArICAgICBpZiAodGltZWxlZnQgPD0gMCkgew0KPj4gKyAgICAg
ICAgICAgICBkZXZfZXJyKCZ0YzYtPnNwaS0+ZGV2LCAiTUFDLVBIWSByZXNldCBmYWlsZWRcbiIp
Ow0KPj4gKyAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsNCj4+ICsgICAgIH0NCj4gDQo+IFRo
aXMgc2VlbXMgYSBiaXQgbWVzc3kgYW5kIGNvbXBsZXguIEkgYXNzdW1lIHJlc2V0IGlzIHBlcmZv
cm1lZCBvbmNlDQo+IGR1cmluZyBwcm9iZSwgYW5kIG5ldmVyIGFnYWluPyBTbyBpIHdvbmRlciBp
ZiBpdCB3b3VsZCBiZSBjbGVhbmVyIHRvDQo+IGFjdHVhbGx5IGp1c3QgcG9sbCBmb3IgdGhlIHJl
c2V0IHRvIGNvbXBsZXRlPyBZb3UgY2FuIHRoZW4gcmVtb3ZlIGFsbA0KPiB0aGlzIGNvbXBsZXRp
b24gY29kZSwgYW5kIHRoZSBpbnRlcnJ1cHQgaGFuZGxlciBnZXRzIHNpbXBsZXI/DQpPayB0aGUg
c3BlYyBzYXlzIHRoZSBiZWxvdywgdGhhdCdzIHdoeSBJIGltcGxlbWVudGVkIGxpa2UgdGhpcy4N
Cg0KOS4yLjguOCBSRVNFVEMNClJlc2V0IENvbXBsZXRlLiBUaGlzIGJpdCBpcyBzZXQgd2hlbiB0
aGUgTUFDLVBIWSByZXNldCBpcyBjb21wbGV0ZSBhbmQgDQpyZWFkeSBmb3IgY29uZmlndXJhdGlv
bi4gV2hlbiBpdCBpcyBzZXQsIGl0IHdpbGwgZ2VuZXJhdGUgYSBub24tbWFza2FibGUgDQppbnRl
cnJ1cHQgYXNzZXJ0aW9uIG9uIElSUW4gdG8gYWxlcnQgdGhlIFNQSSBob3N0LiBBZGRpdGlvbmFs
bHksIHNldHRpbmcgDQpvZiB0aGUgUkVTRVRDIGJpdCBzaGFsbCBhbHNvIHNldCBFWFNUID0gMSBp
biB0aGUgcmVjZWl2ZSBkYXRhIGZvb3RlciANCnVudGlsIHRoaXMgYml0IGlzIGNsZWFyZWQgYnkg
YWN0aW9uIG9mIHRoZSBTUEkgaG9zdCB3cml0aW5nIGEg4oCYMeKAmS4NCg0KWWVzLCBJIGFncmVl
IHRoYXQgdGhlIHJlc2V0IGlzIHBlcmZvcm1lZCBvbmNlIGluIHRoZSBiZWdpbm5pbmcuIFNvIEkg
DQp3aWxsIHBvbGwgZm9yIHRoZSBjb21wbGV0aW9uIGFuZCByZW1vdmUgdGhpcyBibG9jayBpbiB0
aGUgbmV4dCByZXZpc2lvbi4NCj4gDQo+PiArICAgICAvKiBSZWdpc3RlciBNQUMtUEhZIGludGVy
cnVwdCBzZXJ2aWNlIHJvdXRpbmUgKi8NCj4+ICsgICAgIHJldCA9IGRldm1fcmVxdWVzdF9pcnEo
JnNwaS0+ZGV2LCBzcGktPmlycSwgbWFjcGh5X2lycSwgMCwgIm1hY3BoeSBpbnQiLA0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB0YzYpOw0KPj4gKyAgICAgaWYgKChyZXQgIT0gLUVO
T1RDT05OKSAmJiByZXQgPCAwKSB7DQo+PiArICAgICAgICAgICAgIGRldl9lcnIoJnNwaS0+ZGV2
LCAiRXJyb3IgYXR0YWNoaW5nIG1hY3BoeSBpcnEgJWRcbiIsIHJldCk7DQo+PiArICAgICAgICAg
ICAgIGdvdG8gZXJyX21hY3BoeV9pcnE7DQo+PiArICAgICB9DQo+IA0KPiBXaHkgaXMgLUVOT1RD
T05OIHNwZWNpYWw/IEEgY29tbWVudCB3b3VsZCBiZSBnb29kIGhlcmUuDQpBaCwgaXQgaXMgYSBt
aXN0YWtlLiBJIHN1cHBvc2VkIHRvIHVzZSwNCg0KaWYgKHJldCkNCg0KSSB3aWxsIGNvcnJlY3Qg
aXQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCj4gDQo+PiAtdm9pZCBvYV90YzZfZGVpbml0KHN0cnVj
dCBvYV90YzYgKnRjNikNCj4+ICtpbnQgb2FfdGM2X2RlaW5pdChzdHJ1Y3Qgb2FfdGM2ICp0YzYp
DQo+PiAgIHsNCj4+IC0gICAgIGtmcmVlKHRjNik7DQo+PiArICAgICBpbnQgcmV0Ow0KPj4gKw0K
Pj4gKyAgICAgZGV2bV9mcmVlX2lycSgmdGM2LT5zcGktPmRldiwgdGM2LT5zcGktPmlycSwgdGM2
KTsNCj4+ICsgICAgIHJldCA9IGt0aHJlYWRfc3RvcCh0YzYtPnRjNl90YXNrKTsNCj4+ICsgICAg
IGlmICghcmV0KQ0KPj4gKyAgICAgICAgICAgICBrZnJlZSh0YzYpOw0KPj4gKyAgICAgcmV0dXJu
IHJldDsNCj4+ICAgfQ0KPiANCj4gV2hhdCBpcyB0aGUgTUFDIGRyaXZlciBzdXBwb3NlZCB0byBk
byBpZiB0aGlzIGZhaWxzPw0KPiANCj4gQnV0IHRoaXMgcHJvYmxlbSBwcm9iYWJseSBnb2VzIGF3
YXkgb25jZSB5b3UgdXNlIGEgdGhyZWFkZWQgaW50ZXJydXB0DQo+IGhhbmRsZXIuDQpZZXMsIEkg
YWdyZWUuIFdpbGwgZG8gdGhhdC4NCj4gDQo+IHc+ICsvKiBPcGVuIEFsbGlhbmNlIFRDNiBTdGFu
ZGFyZCBDb250cm9sIGFuZCBTdGF0dXMgUmVnaXN0ZXJzICovDQo+PiArI2RlZmluZSBPQV9UQzZf
UkVTRVQgMHgwMDAzICAgICAgICAgIC8qIFJlc2V0IENvbnRyb2wgYW5kIFN0YXR1cyBSZWdpc3Rl
ciAqLw0KPj4gKyNkZWZpbmUgT0FfVEM2X1NUUzAgIDB4MDAwOCAgICAgICAgICAvKiBTdGF0dXMg
UmVnaXN0ZXIgIzAgKi8NCj4gDQo+IFBsZWFzZSB1c2UgdGhlIHNhbWUgbmFtZSBhcyB0aGUgc3Rh
bmRhcmQuIEl0IHVzZSBTVEFUVVMwLCBzbw0KPiBPQV9UQzZfU1RBVFVTMC4gUGxlYXNlIG1ha2Ug
c3VyZSBhbGwgeW91ciBkZWZpbmVzIGZvbGxvdyB0aGUgc3RhbmRhcmQuDQpZZXMgc3VyZS4NCj4g
DQo+PiArDQo+PiArLyogUkVTRVQgcmVnaXN0ZXIgZmllbGQgKi8NCj4+ICsjZGVmaW5lIFNXX1JF
U0VUICAgICBCSVQoMCkgICAgICAgICAgLyogU29mdHdhcmUgUmVzZXQgKi8NCj4gDQo+IEl0IGlz
IHByZXR0eSBub3JtYWwgdG8gcHV0ICNkZWZpbmVzIGZvciBhIHJlZ2lzdGVyIG1lbWJlcnMgYWZ0
ZXIgdGhlDQo+ICNkZWZpbmUgZm9yIHRoZSByZWdpc3RlciBpdHNlbGY6DQo+IA0KPiAjZGVmaW5l
IE9BX1RDNl9SRVNFVCAgICAweDAwMDMgICAgICAgICAgLyogUmVzZXQgQ29udHJvbCBhbmQgU3Rh
dHVzIFJlZ2lzdGVyICovDQo+ICNkZWZpbmUgT0FfVEM2X1JFU0VUX1NXUkVTRVQgICAgQklUKDAp
DQo+IA0KPiAjZGVmaW5lIE9BX1RDNl9TVEFUVVMwICAweDAwMDggICAgICAgICAgLyogU3RhdHVz
IFJlZ2lzdGVyICMwICovDQo+ICNkZWZpbmUgT0FfVEM2X1NUQVRVUzBfUkVTRVRDICAgICAgICAg
ICBCSVQoNikgICAgICAgICAgLyogUmVzZXQgQ29tcGxldGUgKi8NCj4gDQo+IFRoZSBuYW1pbmcg
bGlrZSB0aGlzIGFsc28gaGVscHMgYXZvaWQgbWl4dXBzLg0KT2ssIEkgd2lsbCBmb2xsb3cgdGhp
cyBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpCZXN0IFJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiAN
Cj4gICAgICBBbmRyZXcNCj4gDQoNCg==

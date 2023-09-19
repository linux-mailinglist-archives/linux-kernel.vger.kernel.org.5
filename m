Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C237A6090
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjISLEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjISLEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:04:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BBDF1;
        Tue, 19 Sep 2023 04:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695121457; x=1726657457;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=arkAckDr8mJsbg0QIqMsRpUXUTv6QgMYmV/MndpEw3U=;
  b=Rpw/CyzZ1q3iNv2OQ7NaWTCpjKWDnKltvVuWZ7F/Cx9bbrsW9LxDLda7
   6zZ+npBJdm2BqPW7srWOMc9Log28Pm1K0Y0LQAiONVVLnZOcwhtG2PNnP
   6VVWW7zoUI9rjyor7ykSctg1KYiiBEh+32UwNgcoL+B1VJ1CgsQ5JAcCz
   5RdZy762fRHW458sxj+EXzVEA+3en/9YsSetynOPpWqy6PEKLfb59HJxR
   BFQ9fX+/v0umVzTa8bsOmlTcs0Tq/ketRgtP/xZfJc+0pHrSXPEeEh+gY
   taWlkPH5jFLyaqAbeqJhPAbwHrqYcBdWWIpvmsQsQCeMREN/L8p9XMC6p
   Q==;
X-CSE-ConnectionGUID: vtOFWOyzTPyiBV2RmBldog==
X-CSE-MsgGUID: g44qaf36QCOuCQXNxsxlLg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="5291359"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Sep 2023 04:04:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 19 Sep 2023 04:04:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 19 Sep 2023 04:04:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCCqpKNIeZB6omTKNhO1V0Tl22h4HtIFjSIMZO1VC+t3EPGfxUGnq+p8rimf48aZPIXJTcDl5bLqiWLveldB0a2Kp/gIoTvguZTtxFSOXnbzPZa++cWaMF++DLY5uxPwx6HmG957UyGeD91/hQ3uxfZeX8Pv77G4tt4D42HPVCXklncWyTIxK9Qdxx3LQNtHTVeGFDC3TfYT+CrVRGNYN+M4Nv/O48kgyb0N4ebUQHHxjuJjEL/b3vEdQmWgtLg8bE2+FE++0hoRUaCEQq1NbYInPlkG63BuXAqpbAM/KIKRy7iq7/tFDEHPLRBkO9MiF7Bl0DI+Qy5xiHi8j212AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arkAckDr8mJsbg0QIqMsRpUXUTv6QgMYmV/MndpEw3U=;
 b=QlQbMozwRjVyZoQ9W+vnkfqG+kcVRF7a1lp2asgiByixWG3APYQuxBmTyYlt2Q76EVn65AHHA65l6ut+rmMqu/bBzOmdriEYqZcROfanBp0a8hLQbyPZ1Oka2GeErGNf+OMLQohWUp/DSS7lzYiz4HweQV8mRCFiJCI6avIgR5Ywt6v6Tva8rSakaeSaK3ZNtaqX/xu/ut9oFcCL3PqbT56LoWnKdG2M3a1r9zqLpslhJXwooxwLltvZJWJ2hHsL8dNNyunOpu/lvXXMQa1Sa9Ic8UDwcCn9jfFicTY0UJCTDG0DMFmF4h8LWShzgn/Zj3nY2qxSLF1u53dOhBP9sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arkAckDr8mJsbg0QIqMsRpUXUTv6QgMYmV/MndpEw3U=;
 b=X9Jz6qqVj3gX5x3PTFS2H/19czzscpq0xWcj0ndIbQmCHgdPL6FbAZMw2GauA4Gmm0gNlKalPY9koPPIPRujyZvdopD1MI86A7/OwMRDl6y65JKRvxtKoGZtPOofRVB9KQFYdRbZuTdoniNk7XDH5VXSc91oX4dFASzDAb34msE=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 PH8PR11MB6778.namprd11.prod.outlook.com (2603:10b6:510:1c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 11:04:14 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 11:04:14 +0000
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
Thread-Index: AQHZ4mEM4q/YL0tg8UaR0849XBWWbrASgTgAgASnrwCAAOOqgIAKALiA
Date:   Tue, 19 Sep 2023 11:04:14 +0000
Message-ID: <f725ba58-e94b-5df7-2efe-70b18382ba2d@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-3-Parthiban.Veerasooran@microchip.com>
 <28dce908-3a87-48c8-b181-d859697c0152@lunn.ch>
 <2db21ee1-17ba-b7ca-bcfb-110c0f66ef93@microchip.com>
 <489f7f63-a542-45cf-80ec-f8d3cb7aa686@lunn.ch>
In-Reply-To: <489f7f63-a542-45cf-80ec-f8d3cb7aa686@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|PH8PR11MB6778:EE_
x-ms-office365-filtering-correlation-id: 07b1ba2c-f398-478b-4291-08dbb90028fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zpWykulbx3yqU1mn9aZ/8pNOvmcqqye7f4SvjHhXOZwk1rmfyhGm3gJwuhKnewEemAxkagoAZmpinf5IncUJWiCs48wFK2YiXIMOtNdMPUFxv087cp9h8U5Q4K2Gs80HAOfafYvR5m7pqpjUyjKNUpzfA2BgKv92+QFrBJRAfVC7DyrpIAa8F5M5fSzEvDf2p5ybdgiXr9TDHMlw9fxwaJgFNut6uZCZ94qidQrrHwSRAo5C8l7pA0rPpVvNW3Z+1Vjuk+qboblEtTOv2hDtsm2sM2J1tAQg6BVf9Gk5hP/0iH5nfLvfKAGTtjVoXCzU+oO7PKR75esvxCcEv02isgnrjHcsIg0+mmWmxYsZzT2jbLQkgxTuq4VijEKgmfsfZzN+xHrrNRpzjeuVjpZqZxMPA9LTKvvZ/3kcgfqbG32+gcVbuRFGTWBtd01rHsu+ngbT9Md0b5nuZ1whw5AGZ7XzxvcIGJTbQjLpkuZjwI5v/GtRFXSBYYSDBgNdv0N8AR9AAyUmVEL+MESCwlKO7F7lMnduRjkh8gIAHAp1V524Rh81VO7EgXKtwGy9WQLLgnRtl9pne1NDB1qQm70to2ST4wH6L/Olb+YM/aV+Hr9jEYFOYCmmY7yihBJwOYRX3b3YOS2N81ET48O9lcyHs5qAyhlNMGczDGqWadC9Xnr3AU6fmtTYG5h1ABy7+xji
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(451199024)(1800799009)(186009)(31686004)(36756003)(5660300002)(83380400001)(86362001)(31696002)(4744005)(4326008)(8936002)(8676002)(41300700001)(6506007)(6486002)(71200400001)(53546011)(107886003)(26005)(2616005)(6512007)(7416002)(122000001)(66946007)(478600001)(2906002)(76116006)(38100700002)(38070700005)(6916009)(316002)(66476007)(91956017)(66556008)(66446008)(54906003)(64756008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGhZSk5BZjJPNDZtRDBCdXhsemxncENUeEZYMlJMamEzRHppVEk4K3l1eklF?=
 =?utf-8?B?WFNTQ05URU9aVXdIVjdETHBRTnFxUGIySmg1NjFMYWVhK0dGa2RmV0VUa3VI?=
 =?utf-8?B?OXAyYlN1Zmo4V0VESG8xQi9YczEwNmVVbkh1ODk0Z3A4NVZKQzVjTmMxUjJX?=
 =?utf-8?B?NkN5VGlPQjVqMHV6UGI1aEg2bmJBdUlFUTl0ZHB4RTkxLzhVb3lqTHArRnpK?=
 =?utf-8?B?ZE0yUERWeXBHWkkvcWs1OURaVElFUG82a254M3VSdVBSdk5qVmR2ekx6TGtK?=
 =?utf-8?B?WTl3bmlBaUxiTXdmbXErSWFkRng0bWVMdHAveWF5cFhndlhQcFdqVHZpZ2Vr?=
 =?utf-8?B?M0o0RWE2ZWFmREl0MVNsa2xqaithcUwvS0tTdStqckI1ZU1pZEEvVHB1amh0?=
 =?utf-8?B?N0oyQ1ZMZHFNRUhybXZZUUk3ZXRyNjlzRkNmelg2V3k4am9GdmM5dVlCMWZO?=
 =?utf-8?B?WTdXS0lUTjRYd2ljMUR3MEsxTGhmaGN2QWRQYnhhM0dqRitkaGxpWDJvcFRP?=
 =?utf-8?B?Vjd0QWlYMXluTlNGNmRHZUdZMURNbDZPK3E3ZjByM0lidUdoWmpTbU1WZjRS?=
 =?utf-8?B?OHRvVlVRMjdIMDVUVWdZVG52c1N6SE1JK0QzSmZIMHJCcmlqZCs3UW16UjVY?=
 =?utf-8?B?REtGa2xiaExOR29uYmNPclhoK09oemp3emNTK3E2NGI2RnJzUW1IdTdQS1dt?=
 =?utf-8?B?M0c2c1AwdU1KOFdDa1E0VEN3N09tMlVlbTZwc25XV05TQ3JGSlA2YVFPRmdE?=
 =?utf-8?B?cXJ1dU5EMFVnYmxlM3F2ajFXYkVZMWZlckRLQVBYd0M3cXJ1MWhQcHhYVWN6?=
 =?utf-8?B?ckY0bGhPaU1VM1MvcHNnYzM5WEhEVjdYcXZ3cGo2WEdEV3Rocnhsc1hEajFI?=
 =?utf-8?B?VVZDYW4rS1BvZkllU1VPNTh2S002WTQrbCt2aHZTV3JkdFUzQWZubTFrc0Nr?=
 =?utf-8?B?TUN6Y3o3STNFSTllZFJsbVoyU2dMOWdCOS8xWFc3RU5WZ1Qxby93UnA5WUFr?=
 =?utf-8?B?dVRGL05sQ3NuYm5ydXUzWDFrNGZodDBLMzdQQ3lmdDhDaFdPY0d4ZDVmSHZl?=
 =?utf-8?B?WFZySTI0eW9ldXhzbjFkREx6OHJpOWNBVU9WVmdEaHdoTkdmSGF2a3B0N0dv?=
 =?utf-8?B?VnlyNkRKd3dRRXc2cHFiakFtc3RscUROTnkvUlNKOWFJWVVpNUZmaUppc1Nr?=
 =?utf-8?B?UnBPdllMWUtabmZrRXl2MVVhU0hkWDlmQTdqeU01OVJHZE9udnlPblNpQWxP?=
 =?utf-8?B?NGhrV3M2N1Q0WFJRR0dsRE91b2QrcS9VRytnZ29HaUtSMXkzY3lKd05aVTNz?=
 =?utf-8?B?Q1NqZlNxeWx3R0wrS0plWkR0RXRnL0dzTFJPMS9WOW9VcTNGSUE3akRPbGFZ?=
 =?utf-8?B?eGJKell1ZVdoMmdBTUptNGE3OUV1aWIrdGJ0RTgydWtuM3l1Y20xUWdkbXRE?=
 =?utf-8?B?bFVZRWVRV0pyMkNUdUFiOUk2NjRiRndqUjJUT2JYc1NRa1RpYk5NQ3E1VWpk?=
 =?utf-8?B?em82UnFDckI0RkVyN0NlamlTbnVaeTRTRmZzZTlVK1dEcG9idWE1M1RjbVZr?=
 =?utf-8?B?MUZJOSt4TFRGT2pVQWkwZGRKaHVZN2xKSGdiSW1nM3F5OHgraGFZbkF0STlH?=
 =?utf-8?B?MVR1VHlldjI2dzBvSXJRb2sxSjBWT0tZQlNSL1hocm1JUWlsTmNGU2VERUJO?=
 =?utf-8?B?VVlKRHpGUEdPQlp6TXlnS0pMd2xSQUpZT0tIQUp3V3BtVVZPVjhvTEZxeVRs?=
 =?utf-8?B?OXZXNE9McHlJVlpuWGtvSEI3OXY1Z05waGJwNDRRa0hGb0VyU01KeXdrZGlR?=
 =?utf-8?B?Qjl1YW1vZGl0T2xDVFA4cmFQN2x1eFhRdjdES2dVc2VQdzFFK2RDTlo0amhL?=
 =?utf-8?B?OWh3eVVZZmp5L3NadUlPWWNCZXNTZUJibWUwb2RySWRZZ211Q2RHeEhudVZK?=
 =?utf-8?B?NWtHL0NFd2Y2TjJybnlWS0FxZitQc1F3dUJTc3BCUWluREMvQnJSem05VXVL?=
 =?utf-8?B?QVpGNEVsZkZhUUxYUytrZVBmeG9GVkI2M2ZLMHY1MXVBOTJxTWEzWWMzZ0pD?=
 =?utf-8?B?Wndya1VWSTZqekQxSThteFhrbE1CWW1NKzJVaUlqRmFpQjduU2UvMEJ2RUdn?=
 =?utf-8?B?YStmRFRiaW16MExqRzFnbWl1MWdVQURjdkc1bTd4WkN6MC9VclRaK2t2QjQz?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74EBA55D8BDBD647B25B346D5E4DA69C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b1ba2c-f398-478b-4291-08dbb90028fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 11:04:14.1678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tqt8PvtiPZAuXZMZZzS8FlwWpB7/uxtO2n/3eRUBK0hqy8mDT08PITrexp00/LDRImnk/5f7zmayv3JVjVcBsX3hXahx3GTq1N145X9Bj8Zj2jdqf7EPjwEnQQ7ZEzms
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6778
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpPbiAxMy8wOS8yMyA3OjQ5IGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gT2suIElmIEkgdW5kZXJz
dGFuZCBjb3JyZWN0bHksIEkgaGF2ZSB0byB1c2UgZGV2bV9yZXF1ZXN0X3RocmVhZGVkX2lycSgp
DQo+PiBpbnN0ZWFkIG9mIGRldm1fcmVxdWVzdF9pcnEoKSBhbmQgbGV0IHRoZSB0aHJlYWQgaGFu
ZGxlciByZWdpc3RlcmVkIHdpdGgNCj4+IHRoZSBkZXZtX3JlcXVlc3RfdGhyZWFkZWRfaXJxKCkg
ZnVuY3Rpb24gdG8gcGVyZm9ybSBpbnRlcnJ1cHQgYWN0aXZpdHkNCj4+IGRpcmVjdGx5Pw0KPiAN
Cj4gWWVzLiBJJ3ZlIG5vdCBsb29rZWQgYXQgYWxsIHRoZSBwYXRjaGVzIHlldCwgYnV0IGlmIHRo
ZSB3b3JrIHF1ZXVlIGlzDQo+IG5vdCB1c2VkIGZvciBhbnl0aGluZyBlbHNlLCB5b3Ugc2hvdWxk
IGJlIGFibGUgdG8gcmVtb3ZlIGl0LCBhbmQgbGV0DQo+IHRoZSBJUlEgY29yZSBoYW5kbGUgYWxs
IHRoZSB0aHJlYWRpbmcgZm9yIHlvdS4NClN1cmUsIHdpbGwgaW1wbGVtZW50IGl0LiBUaGFua3Mu
DQoNCkJlc3QgUmVnYXJkcywNClBhcnRoaWJhbiBWDQo+IA0KPiAgICAgIEFuZHJldw0KPiANCg0K

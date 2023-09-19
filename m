Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADAF7A656C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 15:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjISNk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 09:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjISNk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:40:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9710F1;
        Tue, 19 Sep 2023 06:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695130850; x=1726666850;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XKryZkXzWAeOy2TPIR8ZtiL4AYKHZhT3U/GxRMCiybw=;
  b=NNUTrm/RkCrSTR0gd60QfNBkLUOC7qmWl3T1Ru+4/Z5/gxogMDYTDBuD
   VOudAmiHwi5Syrl9NO3/olP/lWo70uZUiHO8JA3Xnq9y37UVG9vavMa8A
   Z0zMgyAeBNO8gjVj/n07qubtoRzi2Z5jJFXxoCEwYWrSbKgfOyRYoTlnW
   5H5U1m/C7sBAqGzvMkYVK5rnjw31wKUd5SeqLREcTEo7LdSp2O4nXXOP/
   TmTyTpJh+5rFk3ELoeuq+R5TNLmGEtETVU5fV87NWrPvMMxJGUcVDi+oZ
   Pb83zD6Hs4XZxTjTiX+xd+rp0GoAMeTNbGi9u7ZVDEVoPpNKcPuaJ2xIe
   Q==;
X-CSE-ConnectionGUID: RljtmPixRHqA7WNKW8KcKA==
X-CSE-MsgGUID: VGFGejIuRWKZseD/bIiEog==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="5444747"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Sep 2023 06:40:47 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 19 Sep 2023 06:40:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 19 Sep 2023 06:40:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pe7c6+ieTGsONiRJRT0jd2s6rNWnrb3WP3/P2LkIf6R1pZCy+FabZP0OzaT3jszDVS121Ua/nvgXdQBatl/Gdv4mNfvAQvOVXK2xNg6ryZWLzf5VsX390p2TJVZxu8iYotQ3aPn4z+4/uarkPRNbhSK+5BSh/4DY+oirvrVEld/sJBc2qxFpTOrQYnm89sc21SzItM38+UNNp62asUH4PQn4TN73ZVsDbQ71J+x9JlIpZKbpX5YwdOhhHkN1AQz81/C8z1A7pYAXM/lxXZQ3ihuxxZ9XvtClJ6qRauzT6N7c6eDPgDZ+HxB92snDWTKttzxV5PDkJXJmA33juXOTFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKryZkXzWAeOy2TPIR8ZtiL4AYKHZhT3U/GxRMCiybw=;
 b=oZ9HQUMNzrfhuOgkLnJIzr7DDxbI0hNtQTyF+Jb8I/nFgBWm3RrtAWMEDSEgzUWfQaanFFcOMo3At7QP+AdAuKKMkRvPBAjFa0LPH4H3NwqLztazCcQQCjouJrrA8Ib/r2AL7pH0dKgVm/yQ0ihUp+O9ODzW6s/1GP5zN4RhPo2kWel0u7osBZq1IZ+q3L/yer98RPaPIoXYxJp+QZtndyilM1nkVrXZ4s7P2ZrtQHFSv14FV3ZLgMu4hpkF0sYfTk7DQFSB98nA60YpBJAT5apD4bM3XbvD12ic3Q0tVeQbmz3yGiyERyw3j3ShpJ7Q6a8PTMHA+4/73ZKGG9iJwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKryZkXzWAeOy2TPIR8ZtiL4AYKHZhT3U/GxRMCiybw=;
 b=nhkUt6U6x56NLohqKLAbCsRyBh1rpTLdjf5DeeHBp4L+zz2YgZjI/r9Y90Hh+RczSV2PYt/TqZVGTm0GeP0y2hI4qpn/j1jndJ8DI7mYNC+0UiNl54DYFLvnJiYFP14ZzvjQ2WBzRNGyWJbo7M4jEFy1z9xnBKYmigKL3xKt+ko=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 13:40:29 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 13:40:29 +0000
From:   <Parthiban.Veerasooran@microchip.com>
To:     <lukma@denx.de>
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
        <Thorsten.Kummermehr@microchip.com>, <andrew@lunn.ch>
Subject: Re: [RFC PATCH net-next 2/6] net: ethernet: add mac-phy interrupt
 support with reset complete handling
Thread-Topic: [RFC PATCH net-next 2/6] net: ethernet: add mac-phy interrupt
 support with reset complete handling
Thread-Index: AQHZ4mEM4q/YL0tg8UaR0849XBWWbrAYeGQAgABArACAAA33gIAJceoA
Date:   Tue, 19 Sep 2023 13:40:29 +0000
Message-ID: <da16882b-aea8-486b-5541-2919ff227458@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-3-Parthiban.Veerasooran@microchip.com>
 <20230913104458.1d4cdd51@wsk> <61a58960-f2f3-4772-8f12-0d1f9cfec2c5@lunn.ch>
 <20230913152625.73e32789@wsk>
In-Reply-To: <20230913152625.73e32789@wsk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|PH7PR11MB7643:EE_
x-ms-office365-filtering-correlation-id: 12c98c17-b1ae-4687-aae8-08dbb915fcf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZRHXQ9sv5kdC8eklti1lKmQJlfOwXgtV+zGezRiu5Zxf9O/P1nx6RwIybhKNwaI06p6KrmJW3MbdOl2CQ9izRfEkpFCgKTGsCGvswiCuUhe/8QElXnUTxu45G3G/iuY6BQMwswi+XjznpKWSMrchCV4O1HcAW1h8CVR3h+QMuYQK0zUclI9+n0o5Gt7TuxXBuVNdo9H4zjgm85bhBEh8xQYOYY2CzottNzl0GVzU5CXniRIb9fnzhAYXE0TWryRFGdFkZYQBMNPlb+PkyWHV3i3eYyWWh83ItoD9u3j94xBYc4/xzX2tOOD5sR6EtLUCNSooiEpp8BZbfBgH2CT4xXhvrlhOSEcIPKKI5Mf/F49U9ijU/kO/Zpt42REDQbpl3vtfAY+OVlzf1WGiFrKqsaykM3yfQBf/YQjeVAYpYkDsMancMKz3lk8DxTRiBYVeer0JAUC7eFlwKcT3Pscl/GDSqJAw0wAkJiS02ywWDO4zjlt260RpxqlOYxH6M31kcdbWacNgoku2YMnl2v2oHsx546ZGiqKHwB8TUWq2+ULTNlq7XHDLZvNaV8lsQ6tB1gpq4uM9rNsKUsoJr+QWy6QvHfk9AdghBsHlx64oF7hn3vQvoH1CmRg5jfK7oWYW8CiXk+zVexiPN7DP1vwN2CN5QPqX8Fjr+WJfn8Bt0rU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(1800799009)(186009)(451199024)(31686004)(66899024)(6506007)(6486002)(53546011)(36756003)(38070700005)(38100700002)(122000001)(86362001)(31696002)(2616005)(26005)(2906002)(6512007)(71200400001)(966005)(478600001)(83380400001)(8676002)(5660300002)(91956017)(4326008)(41300700001)(8936002)(7416002)(76116006)(66946007)(66476007)(66446008)(64756008)(54906003)(66556008)(6916009)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nkt3UE9PbmlHOXpzakhzcVFtZlVDVEdVeTdzWFdGeEdIWDN3VDFMTUxrd0h3?=
 =?utf-8?B?ZFVjWFBzcUVYK3JZT0lLQ0t0aEhXbm9yUDBPOWkydnBBZnIxYS9VMUZaQ1la?=
 =?utf-8?B?RzVxMmtkR1BMNTRzMVJXRXBoQ1MvQlZoNDRYcU9DNTk1QjVqMnFXNm1xWk9X?=
 =?utf-8?B?OW1WRXY1Yi9lc2xqcW1CTXNXNE9uTTlMNzVUL0JaUzNtTDZmRmdBL3RZakoy?=
 =?utf-8?B?NWhMV0ZDQ2VJWHlsSmZrMFlVOW10Mm1peHRKUldHZVdqQ3RFeXI5czQzd2ln?=
 =?utf-8?B?cmIyK01tQzhUdlFXVjIrTUs1QXhJdDBDZXZaZ0pWMjUxZ1NvUDNRWXFZTVgy?=
 =?utf-8?B?U1I0aUVMdXNjMUtRaEs5dENQMDhUL24yT29RbjFUVjJsQldubjZmeFBqd3FK?=
 =?utf-8?B?K1R2WjN1WHVmdkJ1VFdNN1RpSUFqMFd2Z000WmhUanJaMDZSNjRqc2huTEFJ?=
 =?utf-8?B?MzlKZm11WlZNdGljbWk2bGd6RWFveDFJMy9VY0JURVNLWEFBZ0QxTW1KSkhr?=
 =?utf-8?B?Y3VaU3pOU21SUFB3RFp3Q0d0aUliR1pnT3RjOUVXU1ljdldvcS9KM1N3eVhI?=
 =?utf-8?B?M042Z1ZJbmgyWUNrYU9MaHFndlkyUlAvV0ZIY3JIaDM3cHhNbmxSTEpSYmJm?=
 =?utf-8?B?RWQyVldyaXFSVDI3M0dYTXc1b0hVTlgrNWZHb2E2RXd3V3ZyVlN6NHdQMlcy?=
 =?utf-8?B?NCttZUU5Q1VqYjJpOVNOVmVEZXcrMDg4ZHIxYlRMbjN2Q1JGMFp1VnUxYlRQ?=
 =?utf-8?B?dmlTaHR4eG5rNzZndHQ4MVF5R2k2YzVkWHkyLzdnd1ErOXE5MEcxMW9uKy9Z?=
 =?utf-8?B?dDNVZThiT0RDQ2xYdFpjaGllZnEycC8xUmFESUlGR3VEaW9uM1lyZkw5UDlZ?=
 =?utf-8?B?SGRmZUk4RTFVUDcwOHJvV0I5N2xXY2xMZjRBSnZYWjNuV0RXaWROaUlZOFhl?=
 =?utf-8?B?ZUUwcW9xSzZyanM4TGtQeFJwd0V4K0FTa0lOL1poM2IzUEdSZXZQaFA5Ump5?=
 =?utf-8?B?NXVmUlo2NlIyQng1RUcrM3d6UDNuT2x3SEYvR252TUJKUmZSMEZoVXRobXQ4?=
 =?utf-8?B?RlpiRVFQZkp1QTFndnF3cWUvcnJGNzVDZnRYQkVYb2xkNituQm9RMVZlcml1?=
 =?utf-8?B?QnFnb1FSZk4wQ0RwQkNwb2JTOUJxQjVVelFiSEx0NGxGeGFZeUljczk4YVY4?=
 =?utf-8?B?bFpxZS8wdnRlQUZVTTdJdFd2OVVoL0JkazNEN2xLaUNUeW5PTUt1NzVDOUF4?=
 =?utf-8?B?ZWVwWWhaM0NaaU1vQ0JERllobUNiSzg3WVAzYkI3TWk5RndlUmlaRmcvWXVx?=
 =?utf-8?B?RU5MZ2pXZVRMZW16ZzB1UjRRSG16TWRWOHpjblN5U2M3ZkRzbElxMXZCUDd0?=
 =?utf-8?B?c1U5OVJ2MmVKazMxejRENGFIb2Q4eXhHbTRiZEZPejhWVFZjWHZNVEc1bEVU?=
 =?utf-8?B?U1d4ekhKbm5DcjNhWG0rRFNvdGJjV3c2cm9XMWN5RE5zWnhxQzg5eDB2Qk9q?=
 =?utf-8?B?RHZjWnozQ2VvNU9XZWhJWWl1THJsYzZ6TWFObWw5SmlqbGlPOGkwR3pETTIz?=
 =?utf-8?B?alIxK0wzcjk4Y3d5WGVTNXYwT1VNZ0JVcWQ1dXBTaDB2OGh4VFc1SUJ1VzFv?=
 =?utf-8?B?elZOSjNSenBXR0E5eFR2M29STFpJMmtCc0hwQStjZVBTS0tIckJtYnF3L1My?=
 =?utf-8?B?bVdCR2RvQjRYTERpdmZ4YXVBVE1yOWV3SlBBcWNsYzlyb3g5MTFKK0c3eWp3?=
 =?utf-8?B?ZnN5TXYzN2Q3dko3NFhkY2JHYlo3N0xRelRUREVTNFIza1VKL1FYNjlkUGY2?=
 =?utf-8?B?Zm5ySUhRUE1nOUMxS0w4QllLNHRwK2lFdHBsaWNiMlNYL0dvd0lMcEtaM1JC?=
 =?utf-8?B?Q1FsTWJ1VGphU1g1SC8wK3NiUmNZdVJuREprQTQ4MWtIQ2FmVDNxb1pGVEN5?=
 =?utf-8?B?YzN0T1psWlVIbU1iSFRqN3Q4djFiN1cvSEZ2VithRXBGaVJoZUFyUi9GQjBy?=
 =?utf-8?B?K1VyS2d0Y1hlcFlwa0JrWWhFem5ObG9HcWE2ZkY0cS93Z08rdVdrRzJ6Y2J5?=
 =?utf-8?B?a1JQT29CMnZ1cnJPdzJUV1VHWU1SZk1rS3dFMGg4RHNVM1R6Y05Nbk8xSExE?=
 =?utf-8?B?RTB1bEpEM21Cb0IwcjhneU5IMTdmNmZicW1Pdm9JM2k4VmQ1UlYzR2VlaU00?=
 =?utf-8?Q?+n2/ZJMJnFRy9xSiesI20pI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B4F8EA974D3DE4CBD93EC5BCC6F7684@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c98c17-b1ae-4687-aae8-08dbb915fcf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 13:40:29.2403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EZBJSoK21SrjMOOWD3OrScI8KbcX5xpxNmYPqXPwoft1ZNDhVElxuQL7y5cjxxiywtku3rAZxTtxIAS3/2Sip7P1m88R/B5hvDgkm3JlaG/P3M3aJ4LMQDG4xWs6zAtm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7643
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTHVrYXN6LA0KDQpTb3JyeSBmb3IgdGhlIGRlbGF5ZWQgcmVzcG9uc2UuIFJlZ2FyZGluZyB5
b3VyIGlzc3VlLCB3ZSBqdXN0IG5vdGljZWQgDQp0aGF0IHlvdSBoYXZlIGFsc28gZmlsZWQgYW4g
aXNzdWUgaW4gb3VyIG9hIHRjNiBsaWIgZ2l0aHViIHBhZ2UuIE91ciBvYSANCnRjNiBsaWIgZm9y
IGNvbnRyb2xsZXJzIGRldmVsb3BlciBUaG9yc3RlbiB3aWxsIGdldCBiYWNrIHRvIHlvdSBvbiB0
aGlzLiANCllvdSBjYW4gZ2V0IHRoZSBzb2x1dGlvbiBmcm9tIHRoZXJlLg0KDQpodHRwczovL2dp
dGh1Yi5jb20vTWljcm9jaGlwVGVjaC9vYS10YzYtbGliL2lzc3Vlcy8xNA0KDQpCZXN0IFJlZ2Fy
ZHMsDQpQYXJ0aGliYW4gVg0KDQpPbiAxMy8wOS8yMyA2OjU2IHBtLCBMdWthc3ogTWFqZXdza2kg
d3JvdGU6DQo+IEhpIEFuZHJldywNCj4gDQo+Pj4gSnVzdCBtYXliZSBtaW5lIHNtYWxsIHJlbWFy
ay4gSU1ITyB0aGUgcmVzZXQgc2hhbGwgbm90IHBvbGx1dGUgdGhlDQo+Pj4gSVJRIGhhbmRlci4g
VGhlIFJFU0VUQyBpcyBqdXN0IHNldCBvbiB0aGUgaW5pdGlhbGl6YXRpb24gcGhhc2UgYW5kDQo+
Pj4gb25seSB0aGVuIHNoYWxsIGJlIHNlcnZlZC4gUGxlYXNlIGNvcnJlY3QgbWUgaWYgSSdtIHdy
b25nLCBidXQgaXQNCj4+PiB3aWxsIG5vdCBiZSBoYW5kbGVkIGR1cmluZyAibm9ybWFsIiBvcGVy
YXRpb24uDQo+Pg0KPj4gVGhpcyBpcyBzb21ldGhpbmcgaSBhbHNvIHdvbmRlcmVkLiBNYXliZSBp
ZiB0aGUgZmlybXdhcmUgaW4gdGhlDQo+PiBNQUMtUEhZIGNyYXNoZXMsIGJ1cm5zLCBhbmQgYSB3
YXRjaGRvZyByZXNldCBpdCwgY291bGQgaXQgYXNzZXJ0DQo+PiBSRVNFVEM/IEkgdGhpbmsgbWF5
YmUgYSBXQVJOX09OX09OQ0UoKSBmb3IgUkVTRVRDIGluIHRoZSBpbnRlcnJ1cHQNCj4+IGhhbmRs
ZXIgd291bGQgYmUgdXNlZnVsLCBidXQgb3RoZXJ3aXNlIGlnbm9yZSBpdC4gUHJvYmUgY2FuIHRo
ZW4gcG9sbA0KPj4gZHVyaW5nIGl0cyByZXNldC4NCj4+DQo+Pj4+ICsJCQkJcmVndmFsID0gUkVT
RVRDOw0KPj4+PiArCQkJCS8qIFNQSSBob3N0IHNob3VsZCB3cml0ZSBSRVNFVEMNCj4+Pj4gYml0
IHdpdGggb25lIHRvDQo+Pj4+ICsJCQkJICogY2xlYXIgdGhlIHJlc2V0IGludGVycnVwdA0KPj4+
PiBzdGF0dXMuDQo+Pj4+ICsJCQkJICovDQo+Pj4+ICsJCQkJcmV0ID0gb2FfdGM2X3BlcmZvcm1f
Y3RybCh0YzYsDQo+Pj4+IE9BX1RDNl9TVFMwLA0KPj4+PiArDQo+Pj4+ICZyZWd2YWwsIDEsIHRy
dWUsDQo+Pj4+ICsNCj4+Pj4gZmFsc2UpOw0KPj4+DQo+Pj4gSXMgdGhpcyBlbm91Z2ggdG8gaGF2
ZSB0aGUgSVJRX04gZGVhc3NlcnRlZCAoaS5lLiBwdWxsZWQgSElHSCk/DQo+Pj4NCj4+PiBUaGUg
ZG9jdW1lbnRhdGlvbiBzdGF0ZXMgaXQgY2xlYXJseSB0aGF0IG9uZSBhbHNvIG5lZWRzIHRvIHNl
dCBTWU5DDQo+Pj4gYml0IChCSVQoMTUpKSBpbiB0aGUgT0FfQ09ORklHMCByZWdpc3RlciAod2hp
Y2ggd291bGQgaGF2ZSB0aGUNCj4+PiAweDgwMDYgdmFsdWUpLg0KPj4+DQo+Pj4gTWluZSBwcm9i
bGVtIGlzIHRoYXQgZXZlbiBhZnRlciB3cml0aW5nIDB4NDAgdG8gT0FfU1RBVFVTMCBhbmQNCj4+
PiAweDgwMDYgdG8gT0FfQ09ORklHMCB0aGUgSVJRX04gaXMgc3RpbGwgTE9XIChpdCBpcyBwdWxs
ZWQgdXAgdmlhDQo+Pj4gMTBLIHJlc2lzdG9yKS4NCj4+Pg0KPj4+IChJJ20gYWJsZSB0byByZWFk
IHRob3NlIHJlZ2lzdGVycyBhbmQgdGhvc2Ugc2hvdyBleHBlY3RlZCB2YWx1ZXMpDQo+Pg0KPj4g
V2hhdCBkb2VzIFNUQVRVUzAgYW5kIFNUQVRVUzEgY29udGFpbj8NCj4gDQo+IFNUQVRVUzAgPT4g
MHg0MCwgd2hpY2ggaXMgZXhwZWN0ZWQuDQo+IA0KPiBUaGVuIEkgZG8gd3JpdGUgMHg0MCB0byBT
VEFUVVMwIC0+IGJpdDYgKFJFU0VUQykgaXMgUi9XMUMNCj4gDQo+IEFmdGVyIHJlYWRpbmcgdGhl
IHNhbWUgcmVnaXN0ZXIgLSBJIGRvIHJlY2VpdmUgMHgwMCAoaXQgaGFzIGJlZW4NCj4gY2xlYXJl
ZCkuDQo+IA0KPiBUaGVuIEkgd3JpdGUgMHg4MDA2IHRvIE9BX0NPTkZJRzAuDQo+IA0KPiAoVGhv
c2UgdHdvIHN0ZXBzIGFyZSByZWdhcmRlZCBhcyAiY29uZmlndXJhdGlvbiIgb2YgTEFOODY1eCBk
ZXZpY2UgaW4NCj4gdGhlIGRvY3VtZW50YXRpb24pDQo+IA0KPiBJbiB0aGlzIHBhdGNoIHNldCAt
PiB0aGUgT0FfQ09GSUcwIGFsc28gaGFzIHRoZSAweDYgYWRkZWQgdG8gaW5kaWNhdGUNCj4gdGhl
IFNQSSB0cmFuc2ZlciBjaHVuay4NCj4gDQo+IER1bXAgb2YgT0EgcmVnaXN0ZXJzOg0KPiB7MHgx
MSwgMHg3YzFiMywgMHg1ZTUsIDB4MCwgMHg4MDA2LCAweDAsIDB4MCwgMHgwLCAweDAsIDB4MCwg
MHgwLA0KPiAweDMwMDAsIDB4MWZiZiwgMHgzZmZlMDAwMywgMHgwLCAweDB9DQo+IA0KPiBTdGF0
dXMgMCAoMHg4KSAtPiAweDANCj4gU3RhdHVzIDEgKDB4OSkgLT4gMHgwDQo+IA0KPj4gVGhhdCBt
aWdodCBiZSBhIGR1bWIgcXVlc3Rpb24sDQo+PiBpJ3ZlIG5vdCByZWFkIHRoZSBkZXRhaWxzIGZv
ciBpbnRlcnJ1cHQgaGFuZGxpbmcgeWV0LCBidXQgbWF5YmUgdGhlcmUNCj4+IGlzIGFub3RoZXIg
aW50ZXJydXB0IHBlbmRpbmc/IE9yIHRoZSBpbnRlcnJ1cHQgbWFzayBuZWVkcyB3cml0aW5nPw0K
PiANCj4gQWxsIHRoZSBpbnRlcnJ1cHRzIG9uIE1BU0t7MDF9IGFyZSBtYXNrZWQuDQo+IA0KPiBD
aGFuZ2luZyBpdCB0bzoNCj4gc3RzICY9IH4oT0FfSU1BU0swX1RYUEVNIHwgT0FfSU1BU0swX1RY
Qk9FTSB8IE9BX0lNQVNLMF9UWEJVRU0gfA0KPiBPQV9JTUFTSzBfUlhCT0VNIHwgT0FfSU1BU0sw
X0xPRkVNIHwgT0FfSU1BU0swX0hEUkVNDQo+IA0KPiBkb2Vzbid0IGZpeCB0aGlzIHByb2JsZW0u
DQo+IA0KPj4NCj4+PiBXYXMgaXQgb24gcHVycG9zZSB0byBub3QgdXNlIHRoZSBSU1RfTiBwaW4g
dG8gcGVyZm9ybSBHUElPIGJhc2VkDQo+Pj4gcmVzZXQ/DQo+Pj4NCj4+PiBXaGVuIEkgZ2VuZXJh
dGUgcmVzZXQgcHVsc2UgKGFuZCBrZWVwIGl0IGZvciBsb3cgZm9yID4gNXVzKSB0aGUNCj4+PiBJ
UlFfTiBnZXRzIGhpZ2guIEFmdGVyIHNvbWUgdGltZSBpdCBnZXRzIGxvdyAoYXMgZXhwZWN0ZWQp
LiBCdXQNCj4+PiB0aGVuIGl0IGRvZXNuJ3QgZ2V0IGhpZ2ggYW55IG1vcmUuDQo+Pg0KPj4gRG9l
cyB0aGUgc3RhbmRhcmQgc2F5IFJTVF9OIGlzIG1hbmRhdG9yeSB0byBiZSBjb250cm9sbGVkIGJ5
IHNvZnR3YXJlPw0KPj4gSSBjb3VsZCBpbWFnaW5lIFJTVF9OIGlzIHRpZWQgdG8gdGhlIGJvYXJk
IGdsb2JhbCByZXNldCB3aGVuIHRoZSBwb3dlcg0KPj4gc3VwcGx5IGlzIHN0YWJsZS4NCj4gDQo+
IEl0IGNhbiBiZSBHUElPIGNvbnRyb2xsZWQuIEhvd2V2ZXIsIGl0IGlzIG5vdCByZXF1aXJlZC4g
SSd2ZSB0aWVkIGl0IHRvDQo+IDNWMyBhbmQgYWxzbyBsZWZ0IE5DLCBidXQgbm8gY2hhbmdlLg0K
PiANCj4+IFNvZnR3YXJlIHJlc2V0IGlzIHRoZW4gdXNlZCBhdCBwcm9iZSB0aW1lLg0KPiANCj4g
SSd2ZSByZWNvbmZpZ3VyZWQgdGhlIGJvYXJkIHRvIHVzZSBvbmx5IFNXIGJhc2VkIHJlc2V0IChp
LmUuIHNldCBiaXQwDQo+IGluIE9BX1JFU0VUIC0gMHgzKS4NCj4gDQo+Pg0KPj4gU28gdGhpcyBj
b3VsZCBiZSBhIGJvYXJkIGRlc2lnbiBkZWNpc2lvbi4gSSBjYW4gc2VlIHRoaXMgY29kZSBnZXR0
aW5nDQo+PiBleHRlbmRlZCBpbiB0aGUgZnV0dXJlLCBhbiBvcHRpb25hbCBncGlvZCBwYXNzZWQg
dG8gdGhlIGNvcmUgZm9yIGl0IHRvDQo+PiB1c2UuDQo+IA0KPiBJIGNhbiBvbWl0IHRoZSBSU1Rf
TiBjb250cm9sLiBJJ2QganVzdCBleHBlY3QgdGhlIElSUV9OIHRvIGJlIGhpZ2gNCj4gYWZ0ZXIg
cmVzZXQuDQo+IA0KPj4NCj4+Pj4gbXNlY3NfdG9famlmZmllcygxKSk7DQo+Pj4NCj4+PiBQbGVh
c2UgYWxzbyBjbGFyaWZ5IC0gZG9lcyB0aGUgTEFOODY1MSByZXF1aXJlIHVwIHRvIDFtcyAic2V0
dGxlDQo+Pj4gZG93biIgKGFmdGVyIHJlc2V0KSB0aW1lIGJlZm9yZSBpdCBnZXRzIG9wZXJhdGlv
bmFsIGFnYWluPw0KPj4NCj4+IElmIHRoaXMgaXMgbm90IHBhcnQgb2YgdGhlIHN0YW5kYXJkLCBp
dCByZWFsbHkgc2hvdWxkIGJlIGluIHRoZSBNQUMNCj4+IGRyaXZlciwgb3IgY29uZmlndXJhYmxl
LCBzaW5jZSBkaWZmZXJlbnQgZGV2aWNlcyBtaWdodCBuZWVkIGRpZmZlcmVudA0KPj4gZGVsYXlz
LiBCdXQgaWRlYWxseSwgaWYgdGhlIHN0YXR1cyBiaXQgc2F5cyBpdCBpcyBnb29kIHRvIGdvLCBp
IHdvdWxkDQo+PiByZWFsbHkgZXhwZWN0IGl0IHRvIGJlIGdvb2QgdG8gZ28uIFNvIHRoaXMgcHJv
YmFibHkgc2hvdWxkIGJlIGENCj4+IExBTjg2NTEgcXVpcmsuDQo+IA0KPiBUaGUgZG9jdW1lbnRh
dGlvbiBpcyBzaWxlbnQgYWJvdXQgdGhlICJzZXR0bGUgZG93biB0aW1lIi4gVGhlIG9ubHkNCj4g
cmVxdWlyZW1lbnRzIGlzIGZvciBSU1RfTiBhc3NlcnRpb24gPiA1dXMuIEhvd2V2ZXIsIHdoZW4g
dGhlIElSUV9OIGdvZXMNCj4gbG93LCBhbmQgdGhlIGludGVycnVwdCBpcyBzZXJ2ZWQgLSBpdCBo
YXBwZW5zIHRoYXQgSSBjYW5ub3QgcmVhZCBJRA0KPiBmcm9tIHRoZSBjaGlwIHZpYSBTUEkuDQo+
IA0KPj4NCj4+IAlBbmRyZXcNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gDQo+IEx1a2FzeiBNYWpl
d3NraQ0KPiANCj4gLS0NCj4gDQo+IERFTlggU29mdHdhcmUgRW5naW5lZXJpbmcgR21iSCwgICAg
ICBNYW5hZ2luZyBEaXJlY3RvcjogRXJpa2EgVW50ZXINCj4gSFJCIDE2NTIzNSBNdW5pY2gsIE9m
ZmljZTogS2lyY2hlbnN0ci41LCBELTgyMTk0IEdyb2ViZW56ZWxsLCBHZXJtYW55DQo+IFBob25l
OiAoKzQ5KS04MTQyLTY2OTg5LTU5IEZheDogKCs0OSktODE0Mi02Njk4OS04MCBFbWFpbDogbHVr
bWFAZGVueC5kZQ0KDQo=

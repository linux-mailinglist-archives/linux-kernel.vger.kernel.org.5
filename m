Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B167DDD12
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 08:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjKAHUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 03:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjKAHUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 03:20:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA47E4;
        Wed,  1 Nov 2023 00:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698823242; x=1730359242;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1vaGgeB5jTnzAM0zmsVezi2e7DPpLWGOi+C0beaLVl4=;
  b=1VGJVxRPq6nE+ZK1agCn85/49jYr3dqKZC9XsdUSduduIkoXX97IFqsH
   HlhJqdTG5pDaeQN971WnGdPs/tcE2G/zwEFMwd42YPn5olEpIJRNNd0VB
   WbDjYb0asVcCDtWsLDkdzB1yx+cK++T+Bzj/ezo1TzfHH1kPiCoBO3yrG
   QIRGO6auy7yKRQ+h7l4848I8rQwbnTpdiDW9Wk3y2H3odJkP/ZQKDIEEy
   zjrQOh0y8pzNFio+op61XgPukIQ2hxDjIYbBYvhCdpeHTdcfE7oBMmaba
   ulc0aqO+QYD8VHHB1cmRI9e1RDjteL+APDnF6dcbcJnh7oz7TCE8KpxGS
   A==;
X-CSE-ConnectionGUID: 1Zc2DyPJQNGssY9sB0Z4Dw==
X-CSE-MsgGUID: 9P7+L4n1Q7ugw+VNgjU9nw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="178120073"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Nov 2023 00:20:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Nov 2023 00:20:12 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 1 Nov 2023 00:20:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niQQ0ocFZacGPaNL4pr/xJFCSeEb6N/qoTE5n1a/eEzHeBoLV7yBSuHo5QcNKDxzETCia7Ikeq751EQMqgC0Q2nlXmOq6Vkd3N/9WHCjLQpiI26Zj/CXapdo89XcXeyY3DmXcj11MA3UXZEXkbLlKJFJ85EwsOpYeINbWYPORKEhp6huK4LBp6TyeOmBY2G1wYhR9yMHyL9/m5e2Tuhc3xrT8zvs284v+aAzMFgTp+uI6BI7mqkBOuX7GRddUKd2MPQIzS5gvq2uKK8uft4GOmiuFTEGIJkoEAYC+9i0Y4GRO1mOFaFKi2aXlJELeakhCdnaKvhdez5v21ibO7N2HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vaGgeB5jTnzAM0zmsVezi2e7DPpLWGOi+C0beaLVl4=;
 b=Bj1NrqVCKBzhaoO4zjaAM/z7wZ8O2tb48ay3LQEE5RqfMYf4o2b/66DK/A4Mu8Ne32TcfU3iAINTnlIlzuXH+fa3EcLfS+vu46mI1IIap+LAKAOr13j9xRvjYwsWXb+FjWzzbrqbNJfyijQ/T7YNAyOn+I8iS/RVMu4AZjS2mHIRWJBpsIF8KQm93O0N9RJdZZ/MxI+7eeUcWSzL1PuMDJSv+fO5YHrztIecXXkE8MaKmqlYarwljEoJrhvMuMSZffkTLy404OAVRTkO8yGRb44NdmrsKxw/OlqfU3hcnXWA7dJjhRwHwVKE8Ipi0fmM7GhZuy8k2yTYA4tMesYOmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vaGgeB5jTnzAM0zmsVezi2e7DPpLWGOi+C0beaLVl4=;
 b=fNQx8etM15wfOP+uzKEWzVSHl3K6CCHNo7/N9wTIP+chcbErXDddxC+Uqa4cbHP9oMXt4+7hG7K71WKIHTOk6aysUMNYcqEC00NDO9q0Tz6ZhKCEbZye4YvulOyy4JwIFwFpgC9p6VVKIuc558/Lho3dhxoFq7owmYLSnsFenfo=
Received: from CY8PR11MB7688.namprd11.prod.outlook.com (2603:10b6:930:75::20)
 by DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 07:20:09 +0000
Received: from CY8PR11MB7688.namprd11.prod.outlook.com
 ([fe80::311a:249d:c84a:1c51]) by CY8PR11MB7688.namprd11.prod.outlook.com
 ([fe80::311a:249d:c84a:1c51%4]) with mapi id 15.20.6954.019; Wed, 1 Nov 2023
 07:20:09 +0000
From:   <VishvambarPanth.S@microchip.com>
To:     <kuba@kernel.org>, <f.fainelli@gmail.com>
CC:     <Bryan.Whitehead@microchip.com>, <andrew@lunn.ch>,
        <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <edumazet@google.com>
Subject: Re: [PATCH net] net: microchip: lan743x : bidirectional throughuput
 improvement
Thread-Topic: [PATCH net] net: microchip: lan743x : bidirectional throughuput
 improvement
Thread-Index: AQHZ8QY1ceTQbXJwb0+3Qg4gMnoFrbA6DY8AgAALvoCAAAIkgIArKtQA
Date:   Wed, 1 Nov 2023 07:20:09 +0000
Message-ID: <ee81b2128f5178df95a1678d2cf94ad4edf2c9e9.camel@microchip.com>
References: <20230927111623.9966-1-vishvambarpanth.s@microchip.com>
         <20231004122016.76b403f0@kernel.org>
         <b1f64c44-0d1c-480e-a272-fb017e7d8673@gmail.com>
         <20231004130957.2d633d03@kernel.org>
In-Reply-To: <20231004130957.2d633d03@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7688:EE_|DS0PR11MB7925:EE_
x-ms-office365-filtering-correlation-id: a5587531-80ac-4d9c-6332-08dbdaaafb1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /r3QD8tskOJ66x112IPn6oFaCTHWPq7ohylo1vSajaDW77AcpX/43ejnYXfTSDM5IB15/O9EDMeFiWZ420KmCiLjPglvJt2Js00jdyZSaeLT0rSWSV2ik4x0g9j0FxNfi0uEYWWz+joAsQlN2NBiZ0alnmdZQrmAgnRMni58Bz95e/ZOZuQBKtGy9wqvn9yUvZ1wJ8defAXwUezMvkaSZ6xrT83eG44AcxFmssxtZJFJyniteHg0Piextyaq84WHv3Ek/ay3QzwQPLbYux42c3wU3BKiTyoXGOt3FUudo/ZpKRw8Ja4rZHbKyMHY5SIU9dTZHiyCt0x1K8hTzR/u0BC2B+GC5QcVDVFIoAQLtUqwWxGjaI31aKv9qPFWJmxk8b5WmbzcwUcrAyw3q4cxRXon911v5e22ORHR+F9L6occJ8W3l1oQCTr23iYoWTchutBW/mRcuRIiwF/Xd9vtL3v08om+jvzhSSt6wZ48mLpUNp2Nko4u5C/4HZBIenJO7UPsvYUB6RaByqqhEtY8ZaElM+VPKiYgMsfdbDsasQM6G/40CiteYyxljNQY9rgaw2u8enWYQkhu9FFvZxKI7sEoWbRhJPzauIC6XlgGOBawJ5RgXZhCz44QCXTrfKaa3+IQin79TKRQ4MZ+CpaQcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7688.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(230922051799003)(230173577357003)(230273577357003)(451199024)(64100799003)(1800799009)(186009)(64756008)(54906003)(66556008)(66946007)(66476007)(66446008)(91956017)(76116006)(110136005)(316002)(478600001)(6506007)(122000001)(2616005)(26005)(71200400001)(83380400001)(8936002)(8676002)(4326008)(6486002)(966005)(6512007)(5660300002)(36756003)(2906002)(38100700002)(38070700009)(41300700001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0dYbnpKMDZFRFBkTjZ3TkxxSjI3VW1DTWNiYm1XaThJZkhpV0RYZy9malU3?=
 =?utf-8?B?M2tlZGp0Z3J1ajZaT3Y5dHFtUVQyTTBERFZvYTFXVGVqckJlVUQrZ3FlSHY3?=
 =?utf-8?B?Q0lDSFEyeWtNbncwaWJSRWdFYzFxRHRUQ2dsRE1IV3F1eWR6dmc0a3FPamxr?=
 =?utf-8?B?VE5PQzFQNkM1c1BhNjJ6b0pZNzVmWnMzNnVSbjJUbUppNVV4UzkvamFEYjFH?=
 =?utf-8?B?RjZoVWc3eGNncTV3R2dad09PbDFScW9ZUWhmbEJFQjBmL25qV2FmNFRyU0dW?=
 =?utf-8?B?RmZ2QzNmQ0NpdXBLaVZGQm9XcnVxalpjUjlWc2F6b3FXdzdwRVdiQ2NBVytn?=
 =?utf-8?B?dHBmc01aQmhVYVJxMUU0eUh3SWMzZ3hSMDYzdkdYbGtpUUpnWVRJTkpSUUp2?=
 =?utf-8?B?WS9DaVh0eEdNeDFOcjdNNUNsU2V4Y1BEbjF0OWVvdzd0dTJhSEM1UGsyUmwr?=
 =?utf-8?B?THZUdFdSOXU5N1FWWVE1Y3VJRkFic3RZSEVuckMyMmN4bFVxMEJhNTVzNzRq?=
 =?utf-8?B?aHU3VkFPV3JEM1F2V0M2R2pRaGQ1K1A2bmlNSVhyNHNMeElDYkg2MTNIOUN6?=
 =?utf-8?B?bEEvdXRvT01vczk0MWJraTVXMnpIOStJK0xBSUN6TW03Y2RubmExSk1US2hm?=
 =?utf-8?B?L3NRWlYySHdTQkpXK1ZjQ2MraW1aUGU3eWQ5N0VFYU41aklyZGdmL1A3c2xK?=
 =?utf-8?B?R1Bkb1IzN1NJMGlLdVlKWko0KytQS25vKzd1R2l6Y05tZzQ0ZnNCQTl3RzBG?=
 =?utf-8?B?MThvVjlxUG5BeEFLLzNWaWlwWUx2WXF0WW1iWXZ5MHNJTlJxd3NsRU0yNDBr?=
 =?utf-8?B?b3dVRDJvYnhiVytwVGFOMExmZDRCUkhlRlBRUHJmbEFZbGhUSmZ4WEZPSjZq?=
 =?utf-8?B?R1N5aDlGSnl2NUZMaURyWlBCVi85Z1A2N2JWYWpvWUNabCtqQ3VBT2lmNWVT?=
 =?utf-8?B?Y1NwcStxSHhLQ05BbkR0VSsxYTVLSTYyVnd5YThDR1Q4Zjl6N0pKd3ByNXVC?=
 =?utf-8?B?Y0tiZkZxSGpyRVU5OHBUWmFuTnR5VU5Ma21oQnZjRnZWWHJmR1ZhL09CZjZm?=
 =?utf-8?B?YXR0czNTZ3N1dVFnenBrSnBsOFVsMmkrWkxReEZUTUZLZFkwTDlUUDFuYUlV?=
 =?utf-8?B?L1UrVGVBSVhwU1JWTEY2UkJWL2FIY2xXSHZKSktSbU9rdzlnK0VqU0ZTcFlp?=
 =?utf-8?B?cWVwRkREV3NqMUpodVNoR09BR0VIMklWTXRaVG9Gak1mdGoyZUFBWC8xVEJS?=
 =?utf-8?B?SEpIVTNFYWd0MEdOWXhhR0ZXQmQ3RW1qU0hLZk1kckVMQXNxek51MkNrT3By?=
 =?utf-8?B?WlZhUWJCb3ZEeFJDTU5UYnNYMlN6Q0tjRnltekhyS1kwWGtieit3QW9MTnEy?=
 =?utf-8?B?UmJBamZvcm85TnBzZVNqTkNZVEs1ZU5EclhSdUh0ZFo0UklFeGNCUmlHTDdX?=
 =?utf-8?B?RFgvREJiTFRuUzlKWnk0L2R0dVVFckpTQ1poZ2VQTkRocnN6aTVKNW5NYTB5?=
 =?utf-8?B?c0QyWkRPV2drSlF3QjNZdGFpcCtOMlY5cFF5VjJGeFhDRUthcTQzSUxKQWxq?=
 =?utf-8?B?dnFIYVhGVTJhK2pjME1XTmJKcEp4OTl6ZkhieUpZWVRiNkp4UnFHdVJQUWRU?=
 =?utf-8?B?UVovMUc0SjFjSGRrM0ZKV0ZaTDJRZ0wyS0FRK2hWSThNQXZETThKMFhlVVEy?=
 =?utf-8?B?cUhvZERrY2s4clZuOFZnVWJnMkZXS1dnN3FFckpnc2ZsZWdXb2JGVVBZTjlm?=
 =?utf-8?B?eFMvd3FnVWVrUGlrVDRLWmZ3TTBhY3FDcnpSZkhhRlJSeDlUcEJVU2Vudkw3?=
 =?utf-8?B?RDNLQU1KVW51OWorRjU3OWFEVjhwZXUzL21FYkU1amwyckN6MVJSc2VtWGRu?=
 =?utf-8?B?VVJZNXNxWXp2SVQzSmM0L1JmMXY5NXVaeUNYV1c3Z0Zhdk1HTzZ5eTVUSVcr?=
 =?utf-8?B?WHBVdndnOFF3bXdBK0c2U09BMmNiTEZBYlNUR0NFY2JSMnd3aVFqT0xHYnRS?=
 =?utf-8?B?TXVUN0habk5BTlVnT081REN5STNNV3h0STlLUXE5eTNiTkZlQStLaDh2bm5V?=
 =?utf-8?B?ZzVmNXp3NjhwM3NuaEl0ZU9mVVkvQXhqMTllYTZsM2VPcW0yaC9JQy9meERN?=
 =?utf-8?B?T1BmRzBCRXBwOVg2WVluTi9HRVNjSHU1YWtncXVpY1NNYkJBajlxTUxRaHJR?=
 =?utf-8?Q?wD7nk0NCE6u8mCMdp6A0zXU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1FC387891AC36044980FECEB44221851@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7688.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5587531-80ac-4d9c-6332-08dbdaaafb1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 07:20:09.5196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EcKMx4opkbradi24q3e98kKJhbztChttkX9+hPMeJqVjde5XZIgZetR8AgmN+zUSyuycYt0vaG+CaXepOS0gmkoOt1SlRe+MbTwhNJGFpn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7925
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTEwLTA0IGF0IDEzOjA5IC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBXZWQsIDQg
T2N0IDIwMjMgMTM6MDI6MTcgLTA3MDAgRmxvcmlhbiBGYWluZWxsaSB3cm90ZToNCj4gPiA+IE5v
Ym9keSBjb21wbGFpbmVkIGZvciA1IHllYXJzLCBhbmQgaXQncyBub3QgYSByZWdyZXNzaW9uLg0K
PiA+ID4gTGV0J3Mgbm90IHRyZWF0IHRoaXMgYXMgYSBmaXgsIHBsZWFzZSByZXBvc3Qgd2l0aG91
dCB0aGUgRml4ZXMNCj4gPiA+IHRhZyBmb3INCj4gPiA+IG5ldC1uZXh0Lg0KPiA+IA0KPiA+IEFz
IGEgZHJpdmVyIG1haW50YWluZXIsIHlvdSBtYXkgd2FudCB0byBwcm92aWRlIHNvbWUgZ3VhcmFu
dGVlcyB0bw0KPiA+IHlvdXINCj4gPiBlbmQgdXNlcnMvY3VzdG9tZXJzIHRoYXQgZnJvbSBzdGFi
bGUgdmVyc2lvbiBYLlkuWiB0aGUgcGVyZm9ybWFuY2UNCj4gPiBpc3N1ZXMgaGF2ZSBiZWVuIGZp
eGVkLiBQZXJmb3JtYW5jZSBpbXByb3ZlbWVudHMgYXJlIGRlZmluaXRpdmVseQ0KPiA+IGJvcmRl
cg0KPiA+IGxpbmUgaW4gdGVybXMgb2YgYmVpbmcgY29uc2lkZXJlZCBhcyBidWcgZml4ZXMgdGhv
dWdoLg0KPiANCj4gSSB1bmRlcnN0YW5kIHRoYXQsIGJ1dCB0b28gb2Z0ZW4gcGVvcGxlIGp1c3Qg
ImZlZWwgbGlrZSBhIGRldmljZQ0KPiB3aGljaA0KPiBhZHZlcnRpc2VzIFggTWJwcyAvIEdicHMg
c2hvdWxkIHJlYWNoIGxpbmUgcmF0ZSIgd2hpbGUgbm8gZW5kIHVzZXINCj4gY2FyZXMuDQo+IA0K
PiBMdWNraWx5IHN0YWJsZSBydWxlcyBhcmUgcHJldHR5IGNsZWFyIGFib3V0IHRoaXMgKHNlYXJj
aCBmb3INCj4gInBlcmZvcm1hbmNlIik6DQo+IGh0dHBzOi8vZG9jcy5rZXJuZWwub3JnL3Byb2Nl
c3Mvc3RhYmxlLWtlcm5lbC1ydWxlcy5odG1sDQo+IA0KPiBBcyBwb3N0ZWQgaXQgZG9lc24ndCBm
dWxmaWxsIHRoZSByZXF1aXJlbWVudHMg8J+kt++4jw0KDQpUaGFua3MgZm9yIHlvdXIgZmVlZGJh
Y2suIEkgYXBvbG9naXplIGZvciB0aGUgZGVsYXllZCByZXNwb25zZS4NCiANClRoZSBkYXRhIHBy
ZXNlbnRlZCBpbiB0aGUgcGF0Y2ggZGVzY3JpcHRpb24gd2FzIGFpbWVkIHRvIGNvbnZpbmNlIGEN
CnJldmlld2VyIHdpdGggdGhlIHZpc2libGUgaW1wYWN0IG9mIHRoZSBwZXJmb3JtYW5jZSBib29z
dHMgaW4gYm90aCB4NjQNCmFuZCBBUk0gcGxhdGZvcm1zLiBIb3dldmVyLCB0aGUgbWFpbiBtb3Rp
dmF0aW9uIGJlaGluZCB0aGUgcGF0Y2ggd2FzDQpub3QgbWVyZWx5IGEgImdvb2QtdG8taGF2ZSIg
aW1wcm92ZW1lbnQgYnV0IGEgc29sdXRpb24gdG8gdGhlDQp0aHJvdWdocHV0IGlzc3VlcyByZXBv
cnRlZCBieSBtdWx0aXBsZSBjdXN0b21lcnMgaW4gc2V2ZXJhbCBwbGF0Zm9ybXMuDQpXZSByZWNl
aXZlZCBsb3RzIG9mIGN1c3RvbWVyIHJlcXVlc3RzIHRocm91Z2ggb3VyIHRpY2tldCBzaXRlIHN5
c3RlbQ0KdXJnaW5nIHVzIHRvIGFkZHJlc3MgdGhlIHBlcmZvcm1hbmNlIGlzc3VlcyBvbiBtdWx0
aXBsZSBrZXJuZWwgdmVyc2lvbnMNCmluY2x1ZGluZyBMVFMuIFdoaWxlIGl0J3MgYWNrbm93bGVk
Z2VkIHRoYXQgc3RhYmxlIGJyYW5jaCBydWxlcw0KdHlwaWNhbGx5IGRvIG5vdCBjb25zaWRlciBw
ZXJmb3JtYW5jZSBmaXhlcyB0aGF0IGFyZSBub3QgZG9jdW1lbnRlZCBpbg0KcHVibGljIEJ1Z3pp
bGxhLCB0aGlzIHBlcmZvcm1hbmNlIGVuaGFuY2VtZW50IGlzIGVzc2VudGlhbCB0byBtYW55IG9m
DQpvdXIgY3VzdG9tZXJzIGFuZCB0aGVpciBlbmQgdXNlcnMgYW5kIHdlIGJlbGlldmUgc2hvdWxk
IHRoZXJlZm9yZSBiZQ0KY29uc2lkZXJlZCBmb3Igc3RhYmxlIGJyYW5jaCBvbiB0aGUgYmFzaXMg
b2YgaXTigJlzIHZpc2libGUgdXNlciBpbXBhY3QuDQogDQpGZXcgaXNzdWVzIHJlcG9ydGVkIGJ5
IG91ciBjdXN0b21lcnMgYXJlIG1lbnRpb25lZCBiZWxvdywgZXZlbiB0aG91Z2gNCnRoZXNlIGlz
c3VlcyBoYXZlIGV4aXN0ZWQgZm9yIGEgbG9uZyB0aW1lLCB0aGUgZGF0YSBwcmVzZW50ZWQgYmVs
b3cgaXMNCmNvbGxlY3RlZCBmcm9tIHRoZSBjdXN0b21lciB3aXRoaW4gbGFzdCAzIG1vbnRocy4g
DQoNCkN1c3RvbWVyLUEgdXNpbmcgbGFuNzQzeCB3aXRoIEhpc2lsaWNvbi0gS2lyaW4gOTkwIHBy
b2Nlc3NvciBpbiA1LjEwDQprZXJuZWwsIHJlcG9ydGVkIGEgbWVyZSB+MzAwTWJwcyBpbiBSeCBV
RFAuIFRoZSBmaXggc2lnbmlmaWNhbnRseQ0KaW1wcm92ZWQgdGhlIHBlcmZvcm1hbmNlIHRvIH45
MDBNYnBzIFJ4ICBpbiB0aGVpciBwbGF0Zm9ybS4NCg0KQ3VzdG9tZXItQiB1c2luZyBsYW43NDN4
IHdpdGggdjUuMTAgaGFzIGFuIGlzc3VlIHdpdGggVHggVURQIGJlaW5nIG9ubHkNCjE1N01icHMg
aW4gdGhlaXIgcGxhdGZvcm0uIEluY2x1ZGluZyB0aGUgZml4IGluIHRoZSBwYXRjaCBib29zdHMg
dGhlDQpwZXJmb3JtYW5jZSB0byB+NjAwTWJwcyBpbiBUeCBVRFAuDQoNCkN1c3RvbWVyLUMgdXNp
bmcgbGFuNzQzeCB3aXRoIEFEQVMgUmVmIERlc2lnbiBpbiB2NS4xMCByZXBvcnRlZCBVRFANClR4
L1J4IHRvIGJlIDEyNi83MjMgTWJwcyBhbmQgdGhlIGZpeCBpbXByb3ZlZCB0aGUgcGVyZm9ybWFu
Y2UgdG8NCjgyOC85NTYgTWJwcy4NCg0KQ3VzdG9tZXItRCB1c2luZyBsYW43NDN4IHdpdGggUWNv
bSA2NDkwIHdpdGggdjUuNCB3YW50ZWQgaW1wcm92ZW1lbnRzDQpmb3IgdGhlaXIgcGxhdGZvcm0g
ZnJvbSBVRFAgUnggMjAwTWJwcy4gVGhlIGZpeCBhbG9uZyB3aXRoIGZldyBvdGhlcg0KY2hhbmdl
cyBoZWxwZWQgdXMgdG8gYnJpbmcgUnggcGVyZiB0byA4MDBNYnBzIGluIGN1c3RvbWVy4oCZcyBw
bGF0Zm9ybQ0KIA0KVGhpcyBpcyBhIGtpbmQgcmVxdWVzdCBmb3IgY29uc2lkZXJpbmcgdGhlIGFj
Y2VwdGFuY2Ugb2YgdGhpcyBwYXRjaA0KaW50byB0aGUgbmV0IGJyYW5jaCwgYXMgaXQgaGFzIGEg
c2lnbmlmaWNhbnQgcG9zaXRpdmUgaW1wYWN0IG9uIHVzZXJzDQphbmQgZG9lcyBub3QgaGF2ZSBh
bnkgYWR2ZXJzZSBlZmZlY3RzLg0KIA0KVGhhbmtzLA0KVmlzaHZhbWJhciBQYW50aCBTDQogDQoN
Cg==

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3C4806A3B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377102AbjLFI7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjLFI7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:59:09 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B496A5F;
        Wed,  6 Dec 2023 00:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701853144; x=1733389144;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4HRoOuhjWw7IggTjfkwzPpA+IYn7Dk+Z+6IQwNTnk1M=;
  b=rVwnsNOy3iWzb3HRkJvuX30T16+UjbyI54cL2jNRNeeLu/FGPyPlQrPs
   VCF5NTy5nFGELp9CX5oVZL0V6AA3CyYobvgkB1J+z5rhH1oM6kcHwJJwa
   E/O6hfOECnVXaUxSylF6xxzzoxv5jKL5zxLT+qCAXW4Zwvs7nHzymKMwJ
   VGLHKdNYcTIa1pLdEZzX499TlYbSXrgtTQqGlBfBbCEYnSCLFG8pSyNkP
   glhiWtP5RgOjVztpOsH8XnxThbnHemu1QsJktFfWTKvU2QHF4UXacG7o5
   EwoQti2PN1PYCMd7t5fnxNp1JoJd/9BAn2NDxHupfSza4HjFlxCOq+8XD
   w==;
X-CSE-ConnectionGUID: mwl3ALmjRUG4BSEHmq/a9g==
X-CSE-MsgGUID: vvlTyd7ESa+si7UR4y3MtA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="12782170"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2023 01:59:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 01:58:50 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 01:58:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNN1edub6Tbwd03l9zamWdgCBca0rlQCWhY3v8xz7dRrw+ayvsaC+pbHgwp7b28A3OSVbHL8KUrkgpewSTcHq0JRDZD9Q6h+Q0d1zxrmzjJTepCrFguZzVi1aLdhZmEtWMq4qOo3NRxHbdujHUKXw38P30sBpFn0dAqwKifC6IX0KuGrbavcI4ODpumWvOFDO0AaTQsFFa4wrN8SLfu+q2HJ20OCFlWI0aQPcO4uTEhXUOlgc0Kc683LYNS7U78/ChBp9nFAMcXDzY8vhax+ydO0s0YxxUZo7AA42xNu3fXcMl57YtIDCCFidANN8sztGgGDS0lsn/N/F1QCHuTtiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HRoOuhjWw7IggTjfkwzPpA+IYn7Dk+Z+6IQwNTnk1M=;
 b=loVl9XEVLXW7MU1klJdNhyrjQwsrb/qWz0SEZ3OG6Zj635r8ViH4cA5Yq/VnzTDVwbahqdseaiF/b3kYDEFdxMzuGmLsaA2RYTsX4sBRZKAZfLI2Slsh6kJw7RrTL7s1pfcfsNwd2HU9TxfpIV2yU3cKuiUPDaLLNqVXdr76ZoZATmNgWYLDkcBAX2XIe7G5P1aiaJJ32RddEIJkbuvX34JRL0DRbShDHga5xobSZ2s/+QByaBBfMsQdNZ0NRgrLpW02ST6YWtODe59/DpXg0o4LSpuPeJDNZ1C6tnvDCpRjFfw8aUhxOPrDbBwZZO5l6W5De1elJcy3Dc2xf2bYdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HRoOuhjWw7IggTjfkwzPpA+IYn7Dk+Z+6IQwNTnk1M=;
 b=1EPuHxRAkGWoSVgqlo5AHqKh0KwDHxmSq2xR/fjxgam0yMNurhxV55b5oX6T8oZKygJrUgA5dUvgi9M19vXfMP/ygUQ7lmiPDdkb4Kw8ZvPmyACEUrwk9ZSfcvloI8R0wu2EtU70ptxMOVHBWX7fmn+tEJohvH5qy38pzYfkCvQmvye6cvMONgdbxu5AtNq2KiUvA5jU2h7gpNLsX7Si41rbYitMMs+NitwhT/2jLuhkNP5y8AvdpNJjJtSbNJ4FFYFcZLGe0b9i4kXODJmKUZb4VFc4SPD1NTkJS72oKT7kPtVxnDZa9W/gClTMTgj98I4i+bpuNlzVrJ+59/lmXg==
Received: from DM5PR11MB0076.namprd11.prod.outlook.com (2603:10b6:4:6b::28) by
 PH7PR11MB6795.namprd11.prod.outlook.com (2603:10b6:510:1b9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 08:58:48 +0000
Received: from DM5PR11MB0076.namprd11.prod.outlook.com
 ([fe80::4f7c:a191:fa1e:6fcb]) by DM5PR11MB0076.namprd11.prod.outlook.com
 ([fe80::4f7c:a191:fa1e:6fcb%6]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 08:58:48 +0000
From:   <Arun.Ramadoss@microchip.com>
To:     <sean@geanix.com>, <Woojung.Huh@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>,
        <f.fainelli@gmail.com>, <olteanv@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: dsa: microchip: use DSA_TAG_PROTO without _VALUE
 define
Thread-Topic: [PATCH net] net: dsa: microchip: use DSA_TAG_PROTO without
 _VALUE define
Thread-Index: AQHaKBVyB8tsOud97Uq3Loq+X47SFbCb89jQ
Date:   Wed, 6 Dec 2023 08:58:48 +0000
Message-ID: <DM5PR11MB0076D755B7492A38337A6A7DEF84A@DM5PR11MB0076.namprd11.prod.outlook.com>
References: <20231206072442.1628505-1-sean@geanix.com>
In-Reply-To: <20231206072442.1628505-1-sean@geanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR11MB0076:EE_|PH7PR11MB6795:EE_
x-ms-office365-filtering-correlation-id: f49a0de5-4f31-454f-bd9a-08dbf6398f74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l6Y57rFMT/SbajEN7nGDYBg8cHCPIdGLZHWqmFO7INJd6x8r/AYv6G7ObTZ/oI41jzkrruALtRq+dk/qUzAE0dOaNPOcjcjoY16KkuYTUmDtCBhhzaN0lDBVRLZRBY2i5BKxlktlmgYsEzvXiuWIzP/NRX+d0HkxGM0pnu1fG9SYtkE8urbE/FxoWu2ROHJnoS3rhgJjHRz2cW3ucmW+M1LPpXBcZxgtnQCnre0r57InW3fRn3Z6tlmvZXsqA4Wtt7ytoWo7J7NAqnOZq6nP3XLEJkGnxIN9ao38KWvm3URon3ynjzkFNpCNK9SH7C6WQTwaDFBnrINaFan/rhRewpvOLePXlztmvcx/8jm+8BhtjA9R3bqjfptY1OwA8lEBnPctDV5O/rSZGfqgFYFy7Ujx7nQQE6kODp2FHW5mnM14XpqzNVBWAMoRHva9C/E28DWR05EhFErEZCbIg+ZuXD04UeafyKLgrbfUfUdASKLsasTFb2SJjJPxHgTcMs7IjlQ4k0vNv6T/AYhtU+1SVrBGAGuOoky7QEgP44D5Rg0fV1GNJUGHJQ1osdueCCFqOJuhwS0g1se1/UrfwM/VyczY0JaVnjRGIdd209mppeTyYbGyNIEsSbfZF/D7HqiRzW3pkttXA1VVtrJACSYKH+FsQwbWe8uKFMwGznP6EEL6nyR3Z+nbyrh4xaEqMgB2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB0076.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(346002)(136003)(230922051799003)(230273577357003)(230173577357003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(478600001)(9686003)(6506007)(53546011)(26005)(966005)(71200400001)(7696005)(110136005)(316002)(66476007)(64756008)(54906003)(66446008)(66556008)(52536014)(86362001)(55016003)(41300700001)(8936002)(66946007)(76116006)(38070700009)(8676002)(4326008)(921008)(7416002)(33656002)(2906002)(122000001)(5660300002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L0CIa4XsTjgDCBhtcFw7DVwVz3ZBJUU9PQHymEk471m3oHbwegOUwf0OUV2w?=
 =?us-ascii?Q?gifxm79ea+dk/JPGv7OnHEP0fTYW8SXBsa9vCtJkFPi8pm60A9JYZlXBJHOQ?=
 =?us-ascii?Q?Y4PLW+eMpHa4uOA2galAyovxuZEpjd9RWNXNYkdCWCqXTrASF3veDuVQGZEn?=
 =?us-ascii?Q?9JMSb+c/JkVoI2u2CY3ZZycIgoUl8htM+gyiDF5JnC0rBaI+t4Y0Xir2lYcK?=
 =?us-ascii?Q?Rb6uvKxpKDilO90C18noeLlkM5ewy7kh62++2TLXdtQsfZuljU2wmys8NHY5?=
 =?us-ascii?Q?JOXwWUmkRJuj2qzGUbvE+N2EenvLyZ35U+Lf1xXi/ADbDgdRF69Gp+iOXQEU?=
 =?us-ascii?Q?hogp/pq0FiJhr172xcb1wAGBs2acRSiS6hEWvSruPytMkoIV8H66FiN/ym4y?=
 =?us-ascii?Q?9bQXjUaMbnVDaQM623HwikxgZnbQgV33X0QFLEPL4u89cKphtY7aQ8FnHdq/?=
 =?us-ascii?Q?OH1veiA1sq2IdU4AfJdGT5GCp3OydCQF7nWrGw+1MHVkpJCjddepYDwWHqbv?=
 =?us-ascii?Q?avexfIB13FMF7B1yJJLGV/ERwos6rYZ66li70w47a96sAdmdU+hstVf3wMIV?=
 =?us-ascii?Q?IUP19c/GJ472jkr4uNal4ARrzyqUZD+O+b94mZOFYOdyhKvmwGYK+rPEPykh?=
 =?us-ascii?Q?lsVfiqMrN9hn0huCSsEMey84uJsr4agdwhSh3iZNKEKHfj85KwnWJQOhi+Nl?=
 =?us-ascii?Q?J/5P4bQPPkxMWDALzp3vTFfFS4g0QTVCwcZha4fmYI/+8FO+MklxTfwZjaSd?=
 =?us-ascii?Q?zrN+BRqemqAFeRaD1N0/QNNZldffNm90jbSdS6g1F1CyyU3cqgINb4uq8UOn?=
 =?us-ascii?Q?8GHQopigP3Lfj6uolwuI9/+5roL3C0F0dovOEtOs6Gyga0RllgzZj06vLJD2?=
 =?us-ascii?Q?xnNr9+P1lEXnyWMZkCVhJvhuROEVSBjs4vltKpieQXdfcbD5yy0/ga5BnKZv?=
 =?us-ascii?Q?dzls8uzbeq3QbeOc+Os6EIh69T2QlgAKVrEloQPYNprBJybVudNBr1BotGvL?=
 =?us-ascii?Q?qFwXnky4ntK/Plzu6uKVA/gsnLahNfU++vnxWSshqy/rcVlqxDDER4Nx0GB8?=
 =?us-ascii?Q?1eKtS/l+uSztNjdJgSUikFob+2XHSu39pMFnkzUu6/TaxvJRcYF+wmZaO1J8?=
 =?us-ascii?Q?q1BLlbznUk0pMNyAMJmmk2BFVeTMlpyR1h51qC0n2B+qcyjV4EdV3lcbPVMI?=
 =?us-ascii?Q?B4asptMv8nBVHnpXpN62mQXpBMbCijXXJsHfGkdoDBxqwbh9Z9FSAb1sNzTr?=
 =?us-ascii?Q?ZUAIA3QFRK54wVFYV9n9epfgAX0l/o9EAprpo4VkIBakHudYVmp2DxKCTtfo?=
 =?us-ascii?Q?QvWFiEMY+S6LuIrv/6Mz5MPo2Mx3P2VWmF2TOJ4vOn3tY0jQlBmone5y+uSZ?=
 =?us-ascii?Q?lgx2Dr0qJYi6eUUzP/L4RddeKwPeva0rvwkuXf1kLqJo94U85PjuG49cVCh3?=
 =?us-ascii?Q?K1+Lormf0nVxbQ9Wpg8sdgsRuSQu++cP/Gi9MtN0qHxXMiIRTytM4f7vOBAi?=
 =?us-ascii?Q?mT8Ii7NsdIsIlLpjOSc/csv1t+7G5XTUTSgJZgdFWQ2xWdj20vQi+iAaHXpC?=
 =?us-ascii?Q?V27ChI1Wt2fGnxrhM7HeYWzub+wRCVCYVk4fN1UW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB0076.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f49a0de5-4f31-454f-bd9a-08dbf6398f74
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 08:58:48.2925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tS2yZAnY86yUta4ZaZirSjTW9hu/kBcHk9GarLn8LErCNXyKsavEVX0vFN/SZOg3ElV6Rz9WwODaDxPGvmSmnybdpACyOs9cq5XjS8myl3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6795
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> -----Original Message-----
> From: Sean Nyekjaer <sean@geanix.com>
> Sent: Wednesday, December 6, 2023 12:55 PM
> To: Woojung Huh - C21699 <Woojung.Huh@microchip.com>;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>; Andrew Lunn
> <andrew@lunn.ch>; Florian Fainelli <f.fainelli@gmail.com>; Vladimir Oltea=
n
> <olteanv@gmail.com>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
> Paolo Abeni <pabeni@redhat.com>; Arun Ramadoss - I17769
> <Arun.Ramadoss@microchip.com>
> Cc: Sean Nyekjaer <sean@geanix.com>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH net] net: dsa: microchip: use DSA_TAG_PROTO without
> _VALUE define
>=20
> [Some people who received this message don't often get email from
> sean@geanix.com. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Correct the use of define DSA_TAG_PROTO_LAN937X_VALUE to
> DSA_TAG_PROTO_LAN937X to improve readability.
>=20
> Fixes: 99b16df0cd52 ("net: dsa: microchip: lan937x: add dsa_tag_protocol"=
)
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

Not sure, whether it is a bug fix or not. Since it only improves readabilit=
y.
I believe it should point to net-next.=20


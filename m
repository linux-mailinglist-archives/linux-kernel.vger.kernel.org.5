Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D777578B4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjGRKAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjGRKAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:00:07 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2111.outbound.protection.outlook.com [40.107.114.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875E6173A;
        Tue, 18 Jul 2023 03:00:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vn5MgU5ViPjmO3bGz7rUKcmcAeuI1/aO3D3mN2C9WDbNdhMDIh+fOOdaucd+3Ry0ftYiCGSrZmDbQZ7tyvcq70XFZFi1cFNAb0RLSjC5Rpud8Uess1pjIr/RoA/ioTo0ZQPo2edmYfos2NBC3iVMd7z/eKd30+FWrWc6q4gn9tSSoNBh1N3/18USs0Eh7WUJh7h2oDy3qQllKGvIQdVZrHDKmz7vy1Lha0sbj1QWYQA8wQnXixxaqFmHaJLM1ACwEsYJ0HmNfjkwRVloFiOjgI0SvrHS/z7Qp0GrQP8DDOGRgcQLe1C4Pg3LxM0/yC8tMmTAoDEFDtjLIbRtONKeJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tLSQkV6/MfipeFalS3Rwl0ZWlJQXQjJ88VytbTTv+E=;
 b=SHoE0XEO7fGJi/udUdFG2I2Mt8XOYQ9QVcHEFZ9yAzajrdUkbiiDg4V1nM+vccOA9qOpXo6AvCiM6TtGkJ2XcTKfwwSrsrTwXoStiRfEtznMVcNXeEpPMg0OvN/72bSmDpyz+WS8gFIX1t2sIVfUotCTvD10Uq7p2gtnM6POjR8NoOJUl5pzEc57Wu4ZVpW0dgYb/d1e5AJOvBnFSK1uIiyxsD3mQRtrF5Ht6zz/t0qnXKjEzz/YXvN0R6wDfjY5fI9nYARInsZb5YjZNvbMNnND2JIXPeEAgkk1LCwq2mdwVA0r9i2cHoqVmY3Cfrao/WUvui39VTEFLJFGDwExGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tLSQkV6/MfipeFalS3Rwl0ZWlJQXQjJ88VytbTTv+E=;
 b=YMJezIebOJCLvqiDT8HZQ9M+AbdAJ7jS6Kp4lopL5bvRvdc6CG+vj1UG5JzBGsSvNWVm1V4ioafqCJG40Ye9Tw0QkmU1anhcuJYNcrFuKizl+y+YEvIKalcD8MdbwjWz6qmPSWIgnsdE+jNe6U7Y37W534/+G+Dh0+lDQPRhQpM=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OSZPR01MB6200.jpnprd01.prod.outlook.com (2603:1096:604:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 10:00:00 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::5cff:5d90:9b08:6a7d]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::5cff:5d90:9b08:6a7d%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 10:00:00 +0000
From:   Chris Paterson <Chris.Paterson2@renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "patches@kernelci.org" <patches@kernelci.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "pavel@denx.de" <pavel@denx.de>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
        "srw@sladewatkins.net" <srw@sladewatkins.net>,
        "rwarsow@gmx.de" <rwarsow@gmx.de>,
        "conor@kernel.org" <conor@kernel.org>
Subject: RE: [PATCH 6.1 000/589] 6.1.39-rc3 review
Thread-Topic: [PATCH 6.1 000/589] 6.1.39-rc3 review
Thread-Index: AQHZuO5JzAfyGjEqakCAZOizC89qha+/Sx9w
Date:   Tue, 18 Jul 2023 10:00:00 +0000
Message-ID: <TY2PR01MB3788DB0982243F01F37AB34FB738A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230717201547.359923764@linuxfoundation.org>
In-Reply-To: <20230717201547.359923764@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OSZPR01MB6200:EE_
x-ms-office365-filtering-correlation-id: 1ea6a725-810f-4a0c-1abf-08db8775c027
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pZ/12bw5EIGyXOP3kN3lanc92q/Bk35iGIPyafK0MuT+T36Gyl0Wgo0XlPzv+KnJqG50D2kx6scyVYHp7j4V+80Vw3RhdSMNSg3EnSxCeFREgzFkzk7C2szmb4YQtArEL0J9SA1kkD7uZY77FhKIntqWL+bty18WcmA/PbERcD6MKXdvZXW7jSp/F9KCnjcOqk8M+I6bUeg2d4LWMANH7uEFCRrLmFrLFflhjthiWNqhoh6cDh9x303D9T8ll3n7gMKlGKmCCYSj6wWWCgf8QZlEp5w0yr8Euw7+dhUINs5sH77BxT+COxzn/cBflDdOLNjBomSkxFzJIQreHZyUwyAn5PQAu6SSJ1U7PVe/slv41JcYRdQbGsVttAIedkggXo4yT8KsHMAq0bfFmOsLtglwD9xbMNZXE1Nh58ou5i5ztCAd6rEtte4GuwXBdCjoC4d5FqflAcNBH2ajS6mZd/AMJYEh3bt+4t3MndBWz0yHBKN/cCrreMnWqYLyExwVNcizLUUT1B/NzR8RlcMi9y/olGFbJTYAzY6hSJMUAsMCtezSZ39QzX2tICAR1ZaJgDaS1uiyE66JaiwaaXm8+pAT2exyDSs5WREOr1vOZjqtYmXRZlw4/Pu7CDWdi/WM0VmFnAKjxgCTRqHQ6HLGPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199021)(7416002)(86362001)(4744005)(2906002)(33656002)(38070700005)(55016003)(966005)(186003)(9686003)(26005)(6506007)(38100700002)(7696005)(110136005)(54906003)(122000001)(71200400001)(66446008)(316002)(64756008)(5660300002)(76116006)(478600001)(66556008)(66476007)(66946007)(4326008)(41300700001)(8936002)(52536014)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?XP6ziEKdu6idawS/OdEQu8p2uIjJf9KaOrP/tqesXBBOKFIokGKdg5O/?=
 =?Windows-1252?Q?cGzsypKiRut01FCWgSG4DvtdZkL+ZNeJpduecFPC6eK1CcgKxoZBPRfR?=
 =?Windows-1252?Q?3yjnP9J9aCihfoTM94fSyjGyHhu7KyNEuM/2Q7GjFVpDw+qn15nUjiB+?=
 =?Windows-1252?Q?IVRyv7PlF2VXpsyIobXsv1v7sh3YQg5gQMvrsjfq3X0gO0PZU2S0El2t?=
 =?Windows-1252?Q?iw6Onm1B6zuNeHcOVHykBCcnQhY7czyyfw79FuGsV0dIFQE0OK9lAI6M?=
 =?Windows-1252?Q?aqx9Py5e2Lgd1Ir31aS4ddoZiiXJeHN/UzDHYWQ4oYikTUzBxpQk4f+p?=
 =?Windows-1252?Q?h2SRdnnYB8h/pI1xAQWbXhUCdkAB6n7R+TMgvEzTiAJnBc3YvUzE0WeZ?=
 =?Windows-1252?Q?N7/FTiXUcOio9qyIT4Q4ErVY5T8Z4gFj/3zLj16O140JbRZqKVNfzU/d?=
 =?Windows-1252?Q?Ndxe54o6cXkwi8PaZZXOQsZGQWxY2+eFnZg6r2LvhiTFRjhHgRWqAv2k?=
 =?Windows-1252?Q?c9pXESFDdTBaCKrQDVeR7xXXolF35mEM9qZezxl5VZ7vsCC57sskfZ6J?=
 =?Windows-1252?Q?nrgmZr5TmTrzwmCjWAPtKDiCga88mkTOl6ZdkL6MHzaTzWmraJySn3Gd?=
 =?Windows-1252?Q?Jpg7S+tJP8d/k6c987B20/oQD+wYt6fSPcQUhT36m7EttA71TY445bT/?=
 =?Windows-1252?Q?ACnFcjNpjU6dvhGVZL4BT9DUj5tMGM69sPo/Y5YBkFtbfsqQ8qfUN9DL?=
 =?Windows-1252?Q?0RaAZm0eKhE/91p2KweN3AtL/mCR9NFg1URmlxgc/SnAkMVy+VtV36oQ?=
 =?Windows-1252?Q?ypLVGPBYipkZv+aNEFicIdIf2pFhgc6UOQ//s7lTU/tEsIW1K5/jSuSh?=
 =?Windows-1252?Q?4JqmHYvj2Iq8WBlRLbO3rhvV8T74f3pTgF/IuPyJMyg9n3iB6WGQ4IoN?=
 =?Windows-1252?Q?5PLpieaERdSu899hK+CzYASLgO50WM3xDmnut2KKucZD6JA0mPtlrjz7?=
 =?Windows-1252?Q?mc34KhKQCif/foezqd3/vnQYyc7WvjsGGOWZuMPAUzpVyniBVNJRefir?=
 =?Windows-1252?Q?A7PnWXGktGwJbAEXXXIT3dSrWBbd+OYaINA0bFLxmfVEdrOLL0RXVSWy?=
 =?Windows-1252?Q?WljdGIs78yy9F24/JkgylxEq6kma70fNJ6KZPiWYcQ/w4sbxpp7iTT5Y?=
 =?Windows-1252?Q?u5d+/7EwWY4Z/G12KWhf5bJWgnwmUmMZVp935hlQfKarDZJP/ugI28x9?=
 =?Windows-1252?Q?BxUWuRVpnnrzaLS8lEhlY3HD0Kbe+L19pA2IFZMD3M1sEYw6040MmMka?=
 =?Windows-1252?Q?xQqQI1KwNsi0p0Zc3NZwi5nHgZcq5tTn5SpGigg8t6j51R7eW11cK8k/?=
 =?Windows-1252?Q?g5NsofY47vnrhBeO9JzGWl59cN4nJhXEXSMorfHhH23IK2ClCx+qTxv5?=
 =?Windows-1252?Q?vQBwLJ7KkbJJ068qE6xhR5+WfajM/8NQie3KXGCVkOGuKFPMZT794Vy0?=
 =?Windows-1252?Q?j58Kx7S8Bo8sC0OSrjoAkuG1Pi12vDWZVUsghNt325hM9Q3PYtb3yxe1?=
 =?Windows-1252?Q?D3PdU2CrLr9Xdf1BLd25JsljTC0BjjiOpAeSC6xX7vz8vBDlhXv2II0h?=
 =?Windows-1252?Q?AHc0ZHGiIALPGF9fOtpyKqDy1zYDlLsDlRHgVNkk4Xn37KpwQ27yPUeZ?=
 =?Windows-1252?Q?nroemktSQXPDYvLYXVI2/Nbg3kIt6wIaealQckNJW4mRe9L7ojRN0Q?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea6a725-810f-4a0c-1abf-08db8775c027
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 10:00:00.7655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2KwAcKxPmpq9D8OoC4w72wxn3Osevl0CSflzD8XIn7mEYR2ZqrtUFVoN7D4uZoH2XeGluXmi9D7XeYxNZlTWEEX7TV9vK1dng3IXzlMHVWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6200
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Monday, July 17, 2023 9:34 PM
>=20
> This is the start of the stable review cycle for the 6.1.39 release.
> There are 589 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 19 Jul 2023 20:14:46 +0000.
> Anything received after that time might be too late.

Thank you for the release!

CIP configurations built and booted okay with Linux 6.1.39-rc3 (ce7ec101118=
7):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/9=
34494457
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-6.1.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9E076D117
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbjHBPI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbjHBPIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:08:39 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2123.outbound.protection.outlook.com [40.107.113.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1451330CF;
        Wed,  2 Aug 2023 08:08:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coybeytcACRWD2Iw9/ywKZokcLZEbdJE1GhP4Aq1S5eecP9ypScEPDgnwNJmhOLXlpco2H9+mpVHHY/5raBCCB7jTCjApzB0u/VUZU8PK0AS/6wm7AtArfHo2sW24oLHD1FM+zrnc/IzmgOkFlvRal9DHSoDaf1JPLjtzRGhhWRtCfC3J+eadFtdQpWlMJEeXjWSnW1jlbXAMIayclrquHybdbwmd/Jamf2ATCxC1xfWHK1LW78tJHnZqoz4a2qoCb63WN+2AxJ6a1TvfG5zgy5VhsKN/L4lhB/vPsWqast9yq9QE/67MqjRQhXY1cL2E47oHYEVZxWhj83zo+Zt/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YfgyswgAa3w8QGlpbchY2J3A9hwYe7z2Gk9kr9PJY8=;
 b=n/1bokrardo6L+lGYUpvzkEAspLa8FpewijJ+EaSlQb8lmcRnyXpLiDPnzxQFnLx+QTfGZcn1yU4tTfb1/zPlmOoaY4xnDudUKAsm4Sh8cFIyjsOriUbtsQHS3sizS16e4zgQW7JrzKg/z3nBvIfpquLOXtsfy/DCIEjASuqSeP25RAqz2NZPWsHGG9ZIwdvXsLALwiJfaSBRzAVRcMYcKHDJoQzft8YQaWGjXG2jVzA+cg+s+3+fAJgkQKGwm8UE4Mt4woCGWXkXTHUzMOSQ7lTfy3HMD950MzllzovnvhMZlfqiT6xKoiZ9bE2DHgmZXrCK1OS5U2YgcuVPB+NVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YfgyswgAa3w8QGlpbchY2J3A9hwYe7z2Gk9kr9PJY8=;
 b=p7pXRDG6dvXN0fUQDAwE8o7ZBuK7H+7BZb7J4dea+vRdKKZz9o9IySNvczu3No1OoU9Ln9q11lqv3khTtsI+fBWlhdfqr2P+xTYC9EAx18PJOwrbBKtYStxMoKOW+SxFG236L1CYVv9mpSyOd4Pt2ydxGoYrWChieCGd0pCyZVw=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYWPR01MB11909.jpnprd01.prod.outlook.com (2603:1096:400:3fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Wed, 2 Aug
 2023 15:08:22 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::5cff:5d90:9b08:6a7d]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::5cff:5d90:9b08:6a7d%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 15:08:22 +0000
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
Subject: RE: [PATCH 6.4 000/235] 6.4.8-rc2 review
Thread-Topic: [PATCH 6.4 000/235] 6.4.8-rc2 review
Thread-Index: AQHZxRVPHCiNrzRz606w3U1I+fAm3q/XGhqQ
Date:   Wed, 2 Aug 2023 15:08:22 +0000
Message-ID: <TY2PR01MB3788C4188411C8C2D9E5D603B70BA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230802065501.780725463@linuxfoundation.org>
In-Reply-To: <20230802065501.780725463@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYWPR01MB11909:EE_
x-ms-office365-filtering-correlation-id: 19ed0d42-e152-44bf-58b4-08db936a505c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 61GzuSDT2S/ALTfaOLu+6oODtE2H3LrosR8vUQCB+VXO+yKjpGvQ1k8tOgZ8z29UQZ2HavFHwB6M+Dy1Fx4ibjX1UOh4rW5BYmMaGvzS4JM1KzlpaNsRlXNEbhsDm5FNS8DU+ohdkrfI7t+uD2dL8SmEoX/e6Coh6OrXmr8mSclBVICvT5Z+BluI8e8SUC0nxCFtvMZ7lwwHqF+R8Lw9mw7Zqxh26k3QKS8UOjhtdOafC/Amy2iIv8ls4VzLpr0l7I/YmX7xLhPfYY816ffuQktYVG+mWASpSO4/Pa/QtrJChBa9RTOvhHzWsRpaLir8lDmq9dwcP7jbpVyG0MDlWreo6HCpSf05Al87EDikG/TDGt1DhlnJcW8+PyBLAUAzs1Q2IF1mHjkkugT8savwE+isObvlZqgRU4qy7LCEe45/leGXCb+mSRuHdyCZPnwMZBqcht/C9QVdMq+ElncDoY/UvFI/Xiq1hwDgCk7sUkxvAEPZmgsGggb9VP9GvfncZeq0xMOEbcCJzxLkiLmHuk2ogFKzSYOiPmi4gUmndajk0ya4tDISaUBFwp6SIQAX9oNti38DgWXnpIItNGl18JaPYfGzUDgttllmnqugxNfuFgypyYxua5LWAkKahAm+jM1oiqsUWqDzFCwDFxtSBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(33656002)(86362001)(38070700005)(38100700002)(122000001)(4326008)(316002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8936002)(8676002)(7416002)(41300700001)(5660300002)(52536014)(478600001)(110136005)(54906003)(4744005)(2906002)(6506007)(966005)(7696005)(9686003)(71200400001)(186003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?KRzfMx/3nEcmspA+xJ1cO0DrEYIUxrg+9WvjiX2C6iixLynrdm8SkWl9pZ?=
 =?iso-8859-2?Q?nNh6Be++p/usxDcV6MgQe6rq1rGpGFI3xnZTmfDZdpBEDKYwO+NvVeTOgM?=
 =?iso-8859-2?Q?8TK3GSyUdBjrlprpYyNr/9J9oBEZDvGXLMFj8MBwM18jF6Etgr0C3ThJ8H?=
 =?iso-8859-2?Q?Fccfl1QNkipmNWUXI34p6eEsfEZ+YP6DhM58hUqPAEmfK/doQGvxh/qff3?=
 =?iso-8859-2?Q?zomhBIYD0C0rzHKzEWvEXN/kUb81oktDEfGP9geCCAP7WxGVHG51VCmgsL?=
 =?iso-8859-2?Q?TDURRpg6Jr526fkjAcfgewX/IOAZ0lnBeE8eHRBvgKtT14J9QwX7MTUEN8?=
 =?iso-8859-2?Q?IMaPbtYmg8o083XbnTmRH0fczfWewBF6EWq2pUGxggPxAQEGD9plLCylMp?=
 =?iso-8859-2?Q?qy2HEvJc95m+YGArRe7PgU/aM0yEftisJNE1mHSWO0IkapNC4Zz/0TSu9P?=
 =?iso-8859-2?Q?h+CIYBivZxiFHJ+VovH9QIB1Q0t6XjQidVKFA/qVdp9TzGj/E1+Bi7qK+/?=
 =?iso-8859-2?Q?1km0eE1mwE9Rwua2O9IZ8IDXDUrHP96HxsH/ZMefu+rAwcodnOUtubR2qQ?=
 =?iso-8859-2?Q?sCNIROwtCK5lXWqzIPVB/ejsRJtcPYKwIeo1/tvSJCzWbsrYXceFC/qlsU?=
 =?iso-8859-2?Q?5enxykOAc3d8BmDT0FTOwkC4fL/BSh5GXCQTkLwauPq0HWr3XKHqsKpqaN?=
 =?iso-8859-2?Q?TL4UuvKqDXDzICXoOBJJFbwtCvuZB/VL+5N41kzmK8On/uX9OE1LZJynCr?=
 =?iso-8859-2?Q?Wj0Fyua0liFroxMET4rY7leV7hOka08u7bjbXdwdSX4iMOiS0kOCl/2ZiS?=
 =?iso-8859-2?Q?9CQQimaAUhMD2bKW3bir0xgHZISNHQi/5VIxuCyaEQHcHJefbCa0Iw3fa2?=
 =?iso-8859-2?Q?RN66/pJPwtZudqNl8f0XlTHWzsK6f4YFxbn5t6bCS//WBX2f0HwAVkQmiH?=
 =?iso-8859-2?Q?I9GDEK5kV9nVra/bGPzfFfcE3qJflpSvAq4HkLEURUsLf+NQUxNVRXRnWR?=
 =?iso-8859-2?Q?Rl8RwoD2zVU4XFDq+d30MEhsd1uTb/rVNngU1OgooFkALvt+zoWOO6sKkp?=
 =?iso-8859-2?Q?RN0TKc6Bh+JDTdKzEQRNs/uS4o6wWYzMlqObQ4al0+UNSCxrKu5dCWikqx?=
 =?iso-8859-2?Q?CW1MpFsZzjnNDoLuHKhGQQREgOTfd1+WoT/gBP1L+l14sQea1aEa+5MFEp?=
 =?iso-8859-2?Q?WDUvaw8Ae5qdoFRtP4hzJHa1E+dKVtQ1c6B1aEAFBRLXtaJ1L1nXpNEKYQ?=
 =?iso-8859-2?Q?+ST76VEVOCIrcaiIUkGBsLqI/UtpFK9I1BzKJGSQPZFBUKxqQFUrekq0Mm?=
 =?iso-8859-2?Q?YKbr3a6DbN7vL3St52smkSorDqtpnA9H/daRY+tDKnyUEfG4OqDFZwEuLV?=
 =?iso-8859-2?Q?CkIJxjvQMFtmybgLiTUaKM4wnMpVNLRrAb5gQihWT/LjWUsDR+YIbooedS?=
 =?iso-8859-2?Q?MC15tPm3U3a0sPuIiMIlZNLUPoT4LKLV905YxljSYlYLAR9/6yGIbTRxEF?=
 =?iso-8859-2?Q?3Azp1ysXKp2Uv03P5EVJWyegzv8ERoSXPvaQbcmPoCU/YRu8RRdQbAd+tD?=
 =?iso-8859-2?Q?LGWVEB1R7MVJHDJKvLEVUTsJEkZ5h08gvUBV2sOc1GPWfZ4zw0/VvsknNd?=
 =?iso-8859-2?Q?hKi0MAWiWyCko=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ed0d42-e152-44bf-58b4-08db936a505c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 15:08:22.6972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TapfTAKaVaBfDjGwYUZmLQfexUWeI2SYdM+cBzejMQjY4+9QBmc5iUyG6ndsqlUKdZKLYNEBvFXDB7Skq+PkY4QLyFPYK9JVvQa1Vxw4Foo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11909
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
> Sent: Wednesday, August 2, 2023 8:42 AM
>=20
> This is the start of the stable review cycle for the 6.4.8 release.
> There are 235 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Fri, 04 Aug 2023 06:54:15 +0000.
> Anything received after that time might be too late.

Thank you for the release!

CIP configurations built and booted okay with Linux 6.4.8-rc2 (6a44ac630b76=
):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/9=
52990388
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-6.4.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris

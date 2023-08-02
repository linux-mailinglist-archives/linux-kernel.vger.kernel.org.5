Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24F676D121
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbjHBPKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjHBPKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:10:11 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2139.outbound.protection.outlook.com [40.107.113.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E77030FF;
        Wed,  2 Aug 2023 08:09:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAVTMMxgOZ6clYH5RlvZLmAFjn5DDNRAbuAHVFTCrKT+UkqDy7H+mTJ6tgl0YbQPd6PaL/Qs4/+cPqbPlENUVnGfU/ck4WfXg7c4BpL4CSziqYMINyn4esofRIiOD0ybmavLmn6GyJwZTee8mLIsrBKcI5hCGanpVwu0G8faS/NzM0ag413yRbIt79qGK8CYPN+uqyboGBh5f8Dvv99Ctxg+YpjEPfAExlplETvPFwbDW6OqCas3WuR+iBz0QPVS9s9u5akp7WHoPkvtSeaqEqta1NZIzSQV3+kvdxTCukbIYEpGo56hhR61t0D4zNIXkNE2gb+0k+ygToRDgZbjKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OPj+yyx+gI1r73H7Aq57jnAbnExMFKTMGp2ux8kBA4=;
 b=B2+XyfrVaQObwFga8wld8FX9k2qOj3reA6KD0dVP7e010EGUpk0xGqwcqxA/bIJz/CzLQVB70q7XSmH7kJQWDlnMpMRVcE0NlYzhy2hCytRwVi6s+xSBhvYTGg2VhJ15nBDnaMcxUfHu5aeYnS1YfyrcUcH4jWYG52709IRMNeSnCGPkS4SE6J5iq0tYDwTb8WLJegizAE29ShTfagt/Fe3wTd7xzR54GsQENRK/q5nOIJXlVlX2BszBe56+bb6GsxBqqKrVkbq9Ak2ovGP1fgFB2VrSWYRtXmftEzqXBF3KewwKx84n9lfqbq6CB7A661BweattemsalzDRQFHHhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OPj+yyx+gI1r73H7Aq57jnAbnExMFKTMGp2ux8kBA4=;
 b=FqVV3rnei+S4cwIni/aqBwcoQnrh0K1jzjWHxAkU6BsDSL0QabmSlh3dGse4DJv3IdkSgCDTxvQRfdYUqYJIod91PzU5jREktlm11x/Xec80ghvCwTyJ6e3b+acNhNQY25AonfU5txFcOETLUl6zXBF0JYJcdMpmfKwwDztWxjQ=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYWPR01MB11909.jpnprd01.prod.outlook.com (2603:1096:400:3fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Wed, 2 Aug
 2023 15:09:38 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::5cff:5d90:9b08:6a7d]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::5cff:5d90:9b08:6a7d%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 15:09:38 +0000
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
Subject: RE: [PATCH 5.15 000/153] 5.15.124-rc2 review
Thread-Topic: [PATCH 5.15 000/153] 5.15.124-rc2 review
Thread-Index: AQHZxRUskexH9V4r70WENx3lSQmuRa/XGjRA
Date:   Wed, 2 Aug 2023 15:09:38 +0000
Message-ID: <TY2PR01MB3788870B013549AAE2E0146CB70BA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230802065452.161574662@linuxfoundation.org>
In-Reply-To: <20230802065452.161574662@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYWPR01MB11909:EE_
x-ms-office365-filtering-correlation-id: 120e7f67-5419-4d06-948a-08db936a7da3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8/yOv1dPG+ZKl1it0QcjI15MPbfHD2ZDHpr+Gn69eei88vrsLOEH76E8oYefxh7tBoGD9wi9s8gvKH2WLtvjbb9/5Sav/EyK568d+P+aan5ZcMPrisl9BN/by4s9ZiEahezETisFyQ92C7YF5a/Z0cbvjt55AJ08xx00w673LPKgYDQu0QNWSz2oElY+oM7167ynFVzJ/tBJuLJ5Hh6Skd6+fj74KkIRnv68nHBmwjJ+suZ741AxlC1SCWm3Ek2ksEKz+UlRR9c201vzcH5TKoWJ0WYCHS5lWt5axYIKWUEyE4KQLJUglWvPHemlJZqkMLRXrNK0Jjl++MDR10KwV0BLMDFMzMvZkj71Lllb/55f9/+8dpYDKBF5wLiVYIUg0jbmpILBx8dyJJhOtjyJj06lryQoLfnC3gnYR5gpDkVDmVBBmee8ET1AzqeLFkBJgESyTnrnKriDxxGVDpflZkuGq+M73rbWbtd7eck0+HjhTbXmxjX5a+aBFB22fTnx5oKyIGQQt94YPNNj6ZQRLcVVmHUeSq9fyhuT8mBMt4QbgSkpTO+XKlABQ10eoC9p/q2mkcMqX9O6Qrj1dU92x5zKhkyRse7sW2LUvNLFIIlIvZtKWy4pY5P39yAWXyp9mDw7ndang0G/jr91ez5rqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(33656002)(86362001)(38070700005)(38100700002)(122000001)(4326008)(316002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8936002)(8676002)(7416002)(41300700001)(5660300002)(52536014)(478600001)(110136005)(54906003)(4744005)(2906002)(6506007)(966005)(7696005)(9686003)(71200400001)(186003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?pFQapVznskK3vMPn0SrGDs0ZtgVR/ZLTU2KbMBG9u6lIaPigE7hmRLyqK/?=
 =?iso-8859-2?Q?zRUPXnGlyfjzkIM2O3Qft+ApJSmo+P/D7He4kOV+/LwIDnGGvj+0IL/UNX?=
 =?iso-8859-2?Q?Gj+yno4iCZfWFayL8BzznPszqvBPJRFXu5V+rGoJMzm/D9TQMWd495HJTB?=
 =?iso-8859-2?Q?6VD435NWeoN8r7B6ywNvPTVq6WgeBKIf/lEK06L6v8Kq72TnYIsnVZSpUE?=
 =?iso-8859-2?Q?dcyG+MF1XlVpsPzfK3jGMy/zfIe38UrATE0gAhY4AWM6KDFNrxp6lqo+tU?=
 =?iso-8859-2?Q?iJnr9Jz5qURzqLJ9JyUGuesfJ7PuLW7Zk7hX1ZBFvcVe9J8qiLO3Ej+U0F?=
 =?iso-8859-2?Q?WXfjZ/zc+mEJYF3yE0Poo9pee/qddX7KssjudBS+JgJaAKkq0pQHWlLFRI?=
 =?iso-8859-2?Q?nfc6SP+NcllJDKShLu5VPnoFEl7Uqtoe0ugMPqExCKZEFTPPw96D5osDMJ?=
 =?iso-8859-2?Q?T9jNGFr7buXFSRzQyj/38R6CtHgxGmd/B4xsfGDXni6OHSnrEmPoSQ4L5g?=
 =?iso-8859-2?Q?I60zdBqVBNKFIla57zJc2V7jGnMeepoCapH37gSFI3YEr4hqFbCZPk4e/C?=
 =?iso-8859-2?Q?Wa5e8KJgulV7GdDBF7mN+ySD4UPuQO1cVH5fl5PGbYe+YdEnizAjKTz7sV?=
 =?iso-8859-2?Q?664TBFDs25B83+qQCsLx2mUffsnfNSFuu/EA5q7OutBTfS4dY13GXYgarX?=
 =?iso-8859-2?Q?ERJYXc0eYXenZa+hKwm6+cbolUPsG/hIWvR2HKTwMeQU9HmBDo047IFQ+p?=
 =?iso-8859-2?Q?9KNY2ek12qxKx8c03QxQ3sm90bPs6fDsl+6Bs3s7xn5FTFBcG6+dwUzThh?=
 =?iso-8859-2?Q?DEL6mRmbAYGHvk65F+9H+6XRrTmrMVTk5rwcVtrj8QLchVdIj5qJ5uTVN2?=
 =?iso-8859-2?Q?GFZubovLZkjN2c2J907X5JnRIi0llfcTFyayzY0MlsosIQBPOqWw7jndAQ?=
 =?iso-8859-2?Q?mhYJOqkjl6wXIg10NTn3ogthpzQ4URri4cmX+ESgBI350H0XcxfjG4DvTT?=
 =?iso-8859-2?Q?wniHYc+FAnqI/LOI+Ljf7eF26kma5kpOrFj+EfjqKfh635fb0jCkz7wlWF?=
 =?iso-8859-2?Q?IAeJ0IIintS2XlOcUtEppQcwx5ZnWXmF5MuvjKMONtKt6WLugwCOADtQ9F?=
 =?iso-8859-2?Q?XGhn7MDaBtdZbjJ9x60ysQwPEWPk0/jU9PVweic0qQnaZOk6yp3Oa8GO+7?=
 =?iso-8859-2?Q?DLivWHSJ8uDQ4GEtNBoCuw7MKAV1jFzYZ1YbYcmnckQ3wREsByqbSFGLmh?=
 =?iso-8859-2?Q?hawLg08HlceNDUP1vmt3qtU5CcQbGwsyM6fVPS45WX9H6bDIDvVbvgM5Ho?=
 =?iso-8859-2?Q?8NJ2jfdho6n3F+iIhlYh+CdGNi7XggxCo9lFjr5YrBFksRNvzqIBsnCJvC?=
 =?iso-8859-2?Q?cUSHHAH3Mu/hlhFoe3/9aSPSBy8F662ER3gAfRWfo1YI0I2CGmAPqk+bgt?=
 =?iso-8859-2?Q?5AB1+0LxKj02P7cwlmw4Kmuf2bBnCPXiRUOqcxid7W9NbuUNOE+RcxHKBV?=
 =?iso-8859-2?Q?sNYoIvuqS2RWm9g2a+v9cwILlxLP7k5WBgbe2NlG7BU+cgxfMo9mTI4jxx?=
 =?iso-8859-2?Q?2Cy8v9ltUXpGl+DwJufzAhiUOgbmKbuF6mEp1t6zFQyA9b6ql7CfkHVLvH?=
 =?iso-8859-2?Q?ctkCIooYec8DI=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 120e7f67-5419-4d06-948a-08db936a7da3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 15:09:38.6307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GoYqSWpwMBrMOG5X3r4UMHogoDX4Oer4kvhdSLy+eGkP06TSI0iBbu7sPMJm5AX5uTfCO+JDj3/fflwEOK3hEOU7cuYwcK4avkLMzinamZQ=
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
> This is the start of the stable review cycle for the 5.15.124 release.
> There are 153 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Fri, 04 Aug 2023 06:54:22 +0000.
> Anything received after that time might be too late.

Thank you for the release!

CIP configurations built and booted okay with Linux 5.15.124-rc2 (b261bd72e=
eda):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/9=
52990959
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-5.15.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris

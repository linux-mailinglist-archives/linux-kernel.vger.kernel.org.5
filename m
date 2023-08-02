Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC9076D107
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjHBPHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbjHBPHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:07:00 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2130.outbound.protection.outlook.com [40.107.113.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B1F2D7D;
        Wed,  2 Aug 2023 08:06:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENksNgi40YwRv7AL80ZuV45sIV1/q2vakWN30dZrxHhPqPoftAHUwvH0vDV1n60dybsdsLgGfXUp9jbYdnWhJaevTCn5ssoCdvIJKHR9n10qvuX/Yz4/5ncT56V7pTJYQ00dieHil32OfHKsuN2P1Dr0Q5KQ/TYDQYS1Y0SYEhTGnJaQNjOvl3EKQpnj/8ZwqkRQ7hL8urW1YYeRCCj/ISI9v3+0xMrJMZedSucAi9Lmv8d5vFyoCAfiqYW/VQxpq2Z0AYE8R853/VlBcSB4N8SRzWwBU67VHStdCw768wrxPMTWal01uOTXbVlKgVPzlJFTFo2V4J7ZHHcxwMYVYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMvllFJ3CJglRFldJ3zQrbvlON8fOxR76CmPCbdYFNg=;
 b=SMfVk4ulK6Yu2SBI8/AcSBIlLPc0wQgtJhujHaweR40DydkrcMBKwLt+uBpl/eim7jjifLcof+Zxf/wzSWVLpMgPuKJolKSpVq8PQcQ36AHe8td/6xbPejiDbuxGmQsCT3GoqDYT0LwN6FW4xxnF5bA6TN9E+IJudwPs7tDWScjL5ROVNUcE9kjNkqR0Fz1DCAhtS0HPYXpr1BltuF8PMQ9DWAPCLyUqN8sGglczAeaBl1zN2tEukHUdhHnPbksqbLmDhFrjTku7h1BRvAWgDt3nDWIqnr2MuIjuL9HAlkTBTrEt8L2F/AQ5XXFfMUGcslcdF5xLGsIVVK6pi6nFkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMvllFJ3CJglRFldJ3zQrbvlON8fOxR76CmPCbdYFNg=;
 b=dtbWlcMzg4/7B0HYor/7QBnSOm4FYtA/ahSu8zvbdYCnNPoWx0xCZlr+MZFVWq0P4soH9KHviqIjqPr2gIQwN14BePf8nzuFZpC71aomfvIQ9jH/BlCB+tsYYafEpeycVBM7kQ3NiEa8155HGAdj14pDqtLdGSL26LslbM6l3Bg=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYWPR01MB11909.jpnprd01.prod.outlook.com (2603:1096:400:3fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Wed, 2 Aug
 2023 15:06:18 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::5cff:5d90:9b08:6a7d]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::5cff:5d90:9b08:6a7d%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 15:06:18 +0000
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
Subject: RE: [PATCH 6.1 000/225] 6.1.43-rc2 review
Thread-Topic: [PATCH 6.1 000/225] 6.1.43-rc2 review
Thread-Index: AQHZxRUt6f5nblshPEyhYw85CjqIS6/XGfJA
Date:   Wed, 2 Aug 2023 15:06:18 +0000
Message-ID: <TY2PR01MB378850FE6D032ACEB09F44CCB70BA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230802065510.869511253@linuxfoundation.org>
In-Reply-To: <20230802065510.869511253@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYWPR01MB11909:EE_
x-ms-office365-filtering-correlation-id: 7f3043a8-21e1-4302-1e7f-08db936a0621
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KgEqZkEcpGJ0c9v8sDmr4oYURiU3yxxYzD+3HRiExoBKTeaEDMI9MV6ORPzx4fZW3bHlhhSO82z04D/SvqgcCYsDol2JWrmet6cTl6GXH1JlwW3R1FGZxdptcIerS5yq1BhSJ9n2NFhRI3rgKVdg4m6j6RF6q3Rhasx1bVkReobGisvn1VYod8nGqDFcVbiJnLYp4gYi5HNbz+Jh8/DqyCsdmQe3iDQx0u/7JqQDDBG5ZDk7cn+Vh/kS7DWmJiP7UTAELVlQXLmdetJ1iaGSVmSrjQbUdlA4w3ByWhzVI1RU76rJ2ivtrEOrRyeljujDih/xuSZ5eJsMsNWWgNZB1Ia1mFDK3zYRrHzuSdLD/XywLK1oU1Y13ot4fjmJy3Ms2V4BmQ3Le/rxXNv//hvdhfjyI6gnJWeoweSIrqUavyXk92vnAgKuWp/bDmuqmL/WybuyaFrrTWIBIplSDOzaGo29ZNoSnQZiegs0LMLG9fn+D81UqrGYnwwyiE5Og296xKZ+rGjP0Ahqbbi/ofnPrLWg78Klju/RoGvl1vpoHnPA7W22cYgpxQ4WwBm9pk/fENQnyWMVj/o4Hh24JBw/Ix1M0QkJqzex6dx/xivmeJEP07Mr9x2Jk12ccs7daCzrMwisTPoTGPT9WytEzFbWOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(33656002)(86362001)(38070700005)(38100700002)(122000001)(4326008)(316002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8936002)(8676002)(7416002)(41300700001)(5660300002)(52536014)(478600001)(110136005)(54906003)(4744005)(2906002)(6506007)(966005)(7696005)(9686003)(71200400001)(186003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?lzq7oT8Bq8NDOe/UU4aLdXwQlFhLF2QJ42WKZck2UvMPb6fcB9sw5n5ujy?=
 =?iso-8859-2?Q?Y5pNHUuEBYkRZqhoLmE7yz8ql/xLk7tBAXdz97R2pwttFRjX3ZrXX6SMqM?=
 =?iso-8859-2?Q?DgNoSHOCQHiXefBXBYPXW/iJDVThzIPaFOzsHFVGfUFFTU4uYvNxeLB2bg?=
 =?iso-8859-2?Q?3BlHyvzEJojcaBLPz21eyTGcIEWUj0kHjJ6dTlcn+x0vXs9XvwC8V5CXc7?=
 =?iso-8859-2?Q?3oWbBE2chZoI6sibiwh9/KR6z75QH8Il0+5dpYHFXEczd6840PiVQqif1j?=
 =?iso-8859-2?Q?0Hpj8+AsM+iPxg/tNLGv7V884NYFJP2gRh+FYNoOfElXE+fj7YlBs1GCm8?=
 =?iso-8859-2?Q?S/XMcKckkDLnAxiUGDorQN4i7Iv/veh0CxICDPZlwRASs/pQMVkwif3Uxf?=
 =?iso-8859-2?Q?Zxmttotzl09E/19trP/mhQYAqPiLZEa7/O0w9cErMHu2pmi6pPvRw9mpDq?=
 =?iso-8859-2?Q?1f0WyKqXNTAHVeeSSweujKiD7YheSgPuAxRPYrBVTA68TVmqpUFZbzJh7F?=
 =?iso-8859-2?Q?dA3otVLqz20Ly3rWvemZr5IF2mw8OVhRxeU+1YKAyM76Vw4yZ4ga3VVf5q?=
 =?iso-8859-2?Q?pgT6Cd+U6fAipk/JQvda4THALEQ7JX311IOZIEQ10aSd3TKjEI+yS6Gf6X?=
 =?iso-8859-2?Q?wRflKvCB5pgEAudLxRhM3Cy8HD8DnbthbdWb+57xCvDlBlshnKNM+DOW8X?=
 =?iso-8859-2?Q?vEQYE2pjCERj82h9vPZIHSebOzgTKYPhDyP2RkcruFe6++sy+qxZCXJ4Cb?=
 =?iso-8859-2?Q?0/+22pqGOloSfyl9AC9WlKmgoZyH562kBmg/aSJP0nYdcc1Gp47K+7OctK?=
 =?iso-8859-2?Q?u7cgm6cSA+HEjuTpUwLG0vozuG+LXU9ProCP7g2z8jaRT4NKfslwoKArrG?=
 =?iso-8859-2?Q?CsGD0ArxdV1r6/VyUzzWJU7qXN85cWGmAOU0dPX7xmxVv3u4GKe0PWfj1E?=
 =?iso-8859-2?Q?YJ3XjtNxGVI23O6jnFWA2f4niqa8ZVsNm4YIol8YgvzIzAwt7KLako4cHB?=
 =?iso-8859-2?Q?reXmEhIUl2BnA6JrQlQ0WR7krIQlPdE4RV0jec8yy2X+62UaZKX3/f5FwV?=
 =?iso-8859-2?Q?5jILy8fq1uOT7NPijnEXeayCaMpjzC7hWfyOoneMiTqqAWiuYnaMA2H6Hu?=
 =?iso-8859-2?Q?DQSC7YPABwgHNCCsZwt9y5j+PuurUnGo71tyQzFWGVqcQqor6076c+V9bg?=
 =?iso-8859-2?Q?+vzCYpxe0/d+WLhqs59x1lg2XHLSDfuq/mKjledqyBQvP/pFqf6X7ViZ/0?=
 =?iso-8859-2?Q?RIBWqqp2BeZ8znKSKTGK6/jAYarjM2mY41d4WG18go/ty7sdlvWsnGvHo6?=
 =?iso-8859-2?Q?ioqhpWPPqjKdMEkEfZWX9uYWNQlcBfw9kbrH5nTOjM44Vg7qXk3lwdYDVT?=
 =?iso-8859-2?Q?nrLaTl73lDAV+dTZc0jGYFv12Jf9OuyIh30rWsRKS7bh8ea5x15N+BqoE1?=
 =?iso-8859-2?Q?tNgnwqQ/zb3dlCgHatX04r7YLR/MgNoF1vwnqVH0WVzKma3MlHN4fIcz+N?=
 =?iso-8859-2?Q?NCOba2cEioKfgCds0sMW1rb/7m2ogGEm8N6EF6OuXbkDYo0w+RE04TDwIa?=
 =?iso-8859-2?Q?GUpH0nvXdRkRj6KRLpNLodG79abrPLH3OZK1kubN7bUXeMQ4gUcmDElULW?=
 =?iso-8859-2?Q?6T8Cbzy/etypY=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3043a8-21e1-4302-1e7f-08db936a0621
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 15:06:18.1619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /jqgkgoX0T9A0nDo5DNYdXqfacxKZ95mrpO7bGfEFExdxjzynmM5sqI10vS0StZhxXdb4wFX1k9grsOsuPGdISkmFPcyECI7awg5pbJ9fpA=
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
> This is the start of the stable review cycle for the 6.1.43 release.
> There are 225 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Fri, 04 Aug 2023 06:54:28 +0000.
> Anything received after that time might be too late.

Thank you for the release!

CIP configurations built and booted okay with Linux 6.1.43-rc2 (bdcf4e82a08=
8):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/9=
52990993/
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-6.1.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris

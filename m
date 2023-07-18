Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B32F7578AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjGRJ7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbjGRJ7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:59:19 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2112.outbound.protection.outlook.com [40.107.114.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83B41704;
        Tue, 18 Jul 2023 02:58:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMejD3Xci1lPag4vdobSRbvqjeAHUudGQvL+BU6SUdedRyuehY6MSqUqS/hao68tDLtPPmrtbKnzaQE5YyLOcYX7eCxbZ+SVWhD+bmBBG6y2e+Y3kXBdh/BTKtcCX7mI9LjNuu4DP6d68QwvNXoR5BPpbQb18b0cEwZr5p7l9XF5Ij2EHZiByYDYv5SeUptBnvUEfUa1aXDh3AP2MzjNy/vPMYk8Wt02W+8RJk7qbawl6NjTUC9+OVMuH28JHpdujt0sBfLm3IjT3CO6PZJE3BxKUxPd7oD+kPjFVSlv2ti9ianfhirAMc7Mfj79THOCC9Bj6rUZNi/zVBtIPTbT1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcAyATpb2FpUAR+PCNob/MnoaWGB2kjOwijBqjpaA08=;
 b=Y1R+OsxoTF47EN1diXG4OwcfkP5RtE0GnNcYVjpxj736fbO2J2Rfiksnh7fyNkdCWW/qDHlArRkrTdZhr1z8Fyfiw1pMKEnQfAfnZMWWQDVyn68a2IC/942s589eQwBmtdiIc2P9vJp37/J+KBGgSelL4Got2fJFn19vQjfqmRcIzSKpxQM2DAoQ6EMdV3jqLSy0zWe+bKw2oXWwcH71iWmCFyR72z2gWFXm9J8yxgiCZPi/P6/bWdcui22pIOfpoEiOeNpMTF0e/7GvooTgd0TrhMQrYVcuMKauCRWWxSr8eZHfiOBTcbzsry2rQXEAPTzpupKlnO3v6kmBA8oOeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcAyATpb2FpUAR+PCNob/MnoaWGB2kjOwijBqjpaA08=;
 b=OWwEj7iId4Lf8SrBEY0MB5DD9kEv7xnZ7RijdckN/NB18QW5dq3H5GR0qIT8T9uKbDXLP5pNySY7B60X38KS0nVKTnpOBbx/vX8F3XaDga4HtDMBU3qCYFl8iFXd710RNZ9PgS+OSkPXayX/zGejtPFpLAcxhlWu9sMr8wzx82o=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OSZPR01MB6200.jpnprd01.prod.outlook.com (2603:1096:604:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 09:58:55 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::5cff:5d90:9b08:6a7d]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::5cff:5d90:9b08:6a7d%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 09:58:55 +0000
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
Subject: RE: [PATCH 6.4 000/801] 6.4.4-rc3 review
Thread-Topic: [PATCH 6.4 000/801] 6.4.4-rc3 review
Thread-Index: AQHZuO5iWw7wG4nQq06acI3mSv7hZq+/SrTg
Date:   Tue, 18 Jul 2023 09:58:54 +0000
Message-ID: <TY2PR01MB37881A2C5C522E509A919EB8B738A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230717201608.814406187@linuxfoundation.org>
In-Reply-To: <20230717201608.814406187@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OSZPR01MB6200:EE_
x-ms-office365-filtering-correlation-id: fad05735-4e2f-4128-aa6f-08db877598f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uC/+nOMcqh6XVXSXEf/92X+kMVmthf6wLpXescl+sSAcJm+JiurZ2T7vWq2dqsicciRyyZRT/ZvSK+uTlkKwFkaoLoyzUFPV/isLyfac8yriBxjF/2BPTUCWhfQT/jPNrY0jw8J/ExALxRHjyQ2YP/o4CRBr/YJD7Q00nHbkc0J3oBwVsyZqNQV8m6JZiymVxFalYDMFme8oEMKOax2ZCUSt7JZSfhjXS5nujHpuZRbnPy+UtTb9Zh4iEFWnKjOwxDzSsxtzhaQs7AwBxnfgMV9+DYWP+Qp6Y7koMYvLevM2jMkntpcjOhcvszl0oUl0Ik2ngRJ6njS+tTXcnRCeZwOwDyvL0PUVlQgaY2Zx9+JFD3ApelAboxF8StQQhesLNrlm+a4BwP7TBJONNHiUruBDdItiQ/I1jXvY+67iQV/ZytLk4PeWrjDVtOuartDrt1/UF3lCkcxno5S5ZBKjuWA8DXDK51KVlWEVl/jHQouGHie6EMj0PlGEFCGm4tJKkQWNZGi+2Og9kUWsnE7oy/9v2KHYJnEhmRgOM76VUIpPNw8P0fajtjDhjf8oDhlDYoDTht3mT91yxIs+cY46elfZaWcOTBbrEnoJciZREK8GnZlErxnY1ObXzPBehCR46o4MjPZVSQiQODwyfZdAew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199021)(7416002)(86362001)(4744005)(2906002)(33656002)(38070700005)(55016003)(966005)(186003)(9686003)(26005)(6506007)(38100700002)(7696005)(110136005)(54906003)(122000001)(71200400001)(66446008)(316002)(64756008)(5660300002)(76116006)(478600001)(66556008)(66476007)(66946007)(4326008)(41300700001)(8936002)(52536014)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?+ffBKZGUtjRzt9Rsqeq/twORU0xyFipQz61YsxZJAWGAePx0I4LEfi7D?=
 =?Windows-1252?Q?AX8m2qHJL0GBLmYr4InrItHaAbV541ZSVLrI5eHk1iu8mf5j2YysGLJY?=
 =?Windows-1252?Q?Vh1z4w7ZyStD9WK8vKrQx6sWF2OwFJn4gPvpcFmsjHKzRF+2D/jVKcxB?=
 =?Windows-1252?Q?/KhBHGw1DnA+koeQeptpjsTdnW2ZUWSppqB5jnrdp2AYlyw6NFv97Xc2?=
 =?Windows-1252?Q?NUiEYdL6WmiTV5Pb7lGP1ZSo7bcUTN/zjf4DbNz/pkhuBoinUdGKT/aC?=
 =?Windows-1252?Q?KwYfJKyeIkkAL2Mu8p7/NLE/M8AIf7cPocCOCNH7jxjaxV2xxNRxPIIs?=
 =?Windows-1252?Q?z1WTYTuOPfF0+V5SshMckPCxkVw70YRuGcYIBriUtQ46LJqdKLk9ELwe?=
 =?Windows-1252?Q?Bz1K/sGR6NVyaLI/HgYVLsjsSv0x3MudFcbWeZaAgzO7j2F29gVLfxWX?=
 =?Windows-1252?Q?+gra0sf5w0xeVY8pvXRv+U0K6ENzMeCcPGVzdvp//LTie37N+t8S41On?=
 =?Windows-1252?Q?Ml9lWNF3svski35FiS3AhXIpvsXeqKBjjAp1NaXa9MSJ5pwZ6s2vVkTC?=
 =?Windows-1252?Q?LXWsn7DI65oDoGberWAzMEA4lCT6nXQm6eRBWvdG3/r/48409KQwuuL2?=
 =?Windows-1252?Q?4efoADDXEdbTN9CrYXWjqm+XekI7Grq2obaWFcL3OH/i+syJR6mJk3Rc?=
 =?Windows-1252?Q?dvYQiYZyKao2PD1m1b0itZlBtBjDwR869D8kUFExaVgmlXqIq+gP7FRb?=
 =?Windows-1252?Q?xnVHggFFa+NQTmmjqBpIUyUqRKsI/vaOcg4PC50i2e7d3T3jhCuTfCLr?=
 =?Windows-1252?Q?EdQCKErRJHVDpMnQ+1UYKViDlxL4gcOTWKR5EQRFJfWa5e2oVQ+fhC+6?=
 =?Windows-1252?Q?ZnPgnROfSpY4PV/RiF4SPp2Ca/GQIm0xBVdNTVcyCoPQE+aPXY55N23Q?=
 =?Windows-1252?Q?9n1OLCs7RQo25hFybpyyLqjW7iwH7IKsNMHjWjPomOr4PSwUDQ/VVjDj?=
 =?Windows-1252?Q?Ne5GGmqWEFu9fzmjYSJqkkb4BnZm158vu8oK+oxgGF/5Pe7EFkQnsdVD?=
 =?Windows-1252?Q?tzicQs64LST23diAi76e5P4QQDHPBW+39g95nChk/BgtbF9TXOZ2uMlI?=
 =?Windows-1252?Q?VtZHPBj8dZ9cWNAzV6tVWGVNGlssedBA2vnmHb9fbW5WiLDyWrKeJcik?=
 =?Windows-1252?Q?TZT4PsRug6kLJhJeMSfPGs3knuBnISZNc0cxojxdqTZje4+wkSdzWBhN?=
 =?Windows-1252?Q?NNHYZdZXrhIhvcfPFbUNHk3wVCTXWzCdWhTcKaRL1VrnRK4bQYboYANl?=
 =?Windows-1252?Q?OmGMdECrSxz/7TkODl3Ig6FjT3xrfAuV6ulJkEiB+SUxTuTXaWTyJQLS?=
 =?Windows-1252?Q?XuHspKZ/4icxjBGk9TFbKT1lg9r49DcQBAMD6N1Kn4G4m/nDsbG0CIzc?=
 =?Windows-1252?Q?PBBDgwee5RaqSHTPuggfhi5KRRa/oYuehHTQyYGPC/NZWjqmb2tr/mcn?=
 =?Windows-1252?Q?+UMeGKqgFhX5DvXilWd6i8bvbaa5JKKMbD0czNB0bdq9Ve6XLcjMAUj1?=
 =?Windows-1252?Q?W+PvgWZ5ILz03XKHNJXUrpSr6WYOwwNeQnkjcPNux01bXUeGUzfaZTCm?=
 =?Windows-1252?Q?LX6EseY8JpS+pJ7JI+sewDq0BeIVLDTpDtLKEBVIyPNfYBXCzW6VxKso?=
 =?Windows-1252?Q?iVmZZWy+JkhDvko2vxSck0xrDxuvhDttuKBuznq9K7BfA7rHmqxf9g?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad05735-4e2f-4128-aa6f-08db877598f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 09:58:54.9865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: in236ChJ2HIRnpT6uvrxt5GR7swpveOW32SyeWKjy4dsBAVcOrkw1n2wqcs15KSUt/zfjkO+clsRWA2SCZlvbDAusmyTqN1fxTDNNpmSNuc=
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
> Sent: Monday, July 17, 2023 9:35 PM
>=20
> This is the start of the stable review cycle for the 6.4.4 release.
> There are 801 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 19 Jul 2023 20:14:44 +0000.
> Anything received after that time might be too late.

Thank you for the release!

CIP configurations built and booted okay with Linux 6.4.4-rc3 (0e8d2fdfb188=
):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/9=
34493703
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-6.4.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris

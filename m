Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2CD75D730
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 00:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjGUWKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 18:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGUWKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 18:10:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC6C2733;
        Fri, 21 Jul 2023 15:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689977400; x=1721513400;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xCaatXyYTu+mgi4yNim5DPgeEZs2qz94ewRXGMC3ocU=;
  b=jG/+MLRIrxYzxc39RqvN1OmFVJ0xFy573b0//h4sWDkzbvL6oh+2GZR6
   X3tf98plvGupux9C6JxjdmdTrURpfyNeQsetQ3rSx4kSZWg878eaoixR5
   9JQJhrz34p2KgTN4rY7j/CNFvhiS7qpBcKlwIC7VeWZVNJntAy1sll4mf
   REYAvEesfoiahJmBt/r7h18C2q4UYMp+LXKO+Ti1ugCAo3vT57DL5q0Pj
   l/gbcCvbPvhXwljJOvlgvbSyHmXQ04qXq2FDu7n/ZN5VRtbHMhRFo9fFj
   BP4noFkVhDpqF22K1YEKzBpiu5L5B10GWJgElNt4jMpnVeA2nQY6ERMCk
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="224478554"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jul 2023 15:09:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 21 Jul 2023 15:10:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 21 Jul 2023 15:09:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzkS3dzidU71gaB5dGxLlZ+UwIdeIs/Wwbna/uHy7wbwvLWgeRrgrlktb6ujEPK74JRNtfQBnnew+NKuVji0grvCF92ua9z1KX25Xi/Hg/cG4A0V2t27I6USRfqcJd0xQksygEP/B5hC4EPanpWsbdr0tgeQ1l16IcVVmdii3zAfb2M0cZ/7NwCSBy8OcNiE9AYi5kLfUkEmjfczdPxyuTIuTlDiNB6PiYKl6tqCIf5c9bRJrO6tOZFfNR5lckDqNvBzt11ixRIt/YW0FMfAcLAK04Ziy/K3+rUiXfT13lGc3X+j3yL3BStybFkkDPWT2dNE2Gu6TtwobSi02UwJ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRREMhVZIkOsTxTeiVOlXqhLyvXghKDGYzAnM0TfQ5o=;
 b=ms6sSgozO0JECW2wTpH/DeNvYuOhjN6yJQShfq9iIWkme4A9XkF1V6kh1ws7zbcA55fmDHxEoD5/TvObElUQXwfp33QBJwj1Dco7qcOLRMcaDZkhbl3LvOyfCE+tsNscUb/mfD95o7AvZKaUV2dJCLwoJmPFb4ki+lkDabEXJPpDdVEQ/lhA3R/2jNDNEVCZOYdYC7yrcLAKzqpxe17lhiQZauTCCAk9isKe97k0yvQvYDvKt1EM+N93H4DODvxx/83qdkdwgHYDYOt7QpBIDRgte4zoZIw1aeG9yfz9MRBL4mnrrvlACANKCNDrGYB+Kyvg9bNlXgL2pnRuSLAAUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRREMhVZIkOsTxTeiVOlXqhLyvXghKDGYzAnM0TfQ5o=;
 b=UTGeTBpGwzuT5SWrjsnFP9G9t7n+KHXAlUIAiHqDuOrLemMkiW+14ODXmMbNJs1cILRsy0SW/aUIqayqRF9gaa4DzYipHyEmGkoTpMsSpy/LiHJrIrcyTmHbhNeJxxMIKcMjqbxnu+ZVQN8MaT6jBLnTXxGDYQ34jxlEMMPGvrI=
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by CO6PR11MB5585.namprd11.prod.outlook.com (2603:10b6:5:356::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Fri, 21 Jul
 2023 22:09:58 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::4d01:8ebd:2fc2:b27e]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::4d01:8ebd:2fc2:b27e%5]) with mapi id 15.20.6609.024; Fri, 21 Jul 2023
 22:09:57 +0000
From:   <Tristram.Ha@microchip.com>
To:     <o.rempel@pengutronix.de>
CC:     <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Woojung.Huh@microchip.com>, <andrew@lunn.ch>,
        <linux@armlinux.org.uk>, <devicetree@vger.kernel.org>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <davem@davemloft.net>,
        <Arun.Ramadoss@microchip.com>, <edumazet@google.com>,
        <f.fainelli@gmail.com>, <conor+dt@kernel.org>, <olteanv@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>
Subject: RE: [PATCH net-next v2 6/6] net: dsa: microchip: ksz9477: make switch
 MAC address configurable
Thread-Topic: [PATCH net-next v2 6/6] net: dsa: microchip: ksz9477: make
 switch MAC address configurable
Thread-Index: AQHZu9sdBwmlpMS6ZUOBzMfaJAqtQK/Exicg
Date:   Fri, 21 Jul 2023 22:09:57 +0000
Message-ID: <BYAPR11MB3558A296C1D1830F15AC6BEFEC3FA@BYAPR11MB3558.namprd11.prod.outlook.com>
References: <20230721135501.1464455-1-o.rempel@pengutronix.de>
 <20230721135501.1464455-7-o.rempel@pengutronix.de>
In-Reply-To: <20230721135501.1464455-7-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|CO6PR11MB5585:EE_
x-ms-office365-filtering-correlation-id: 072b2707-a371-4bb6-b2dd-08db8a37384b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3B4HNoNMfQqeH8WsNniQNGywErP1MtoL4AiyDc7Oq0SZv4szLU45UdHgCqell2g7GSakApvRKsrq/k/J8Q5C9VvWvvmDdiqBRhq2WniRn88lGKipP4028aUZwLwnmqlBHDFN9eeqE61s3PeF1XlAV+IiYzGcmx9+mwJwc1p10TsbY+GQnizOxaWELy9dH90PL5EuWxQUoDHVtdpzooihQJKjPeArvwFB2W3X7cl8vDOGnCFcoYroFUXz0L4EusD3v82DJNp676mbDlSm843zVmvhA1ZTYQ6mrFjwsYrIcV1MU34RngD6J7I8JxjDG0a5gZ/3s9JHLO1+gUYyOlbWN5y53vcm+trSp7OPwqcfxT7u/zOggwnORPf8dK/CEkJaxZ5wjVcfNvCoVZDRgK0EEGDQBF37gbms6xQCwuCHC92HfR4REUmOAmVG1/HzynmqgDI0yJEUC4bpQ/bNKk+4KXzmIPmNb3bUkuknsqbtlhVBOVsMZgLk3WKsE7TPNuWoyMmsPSAkIPdiHtaRcUfIz6mnpVfC5FGgyJ5oE56pEae7bimzn6AMQjTwWMXpnylHVXtH4x7VfqnH2o6d9PHdlw5VXfm7Ci8cITAUTFCxZ2aAPfOpCaHXSuC0Ih7cpifZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199021)(38070700005)(2906002)(4744005)(122000001)(38100700002)(55016003)(6916009)(26005)(66446008)(66556008)(66946007)(66476007)(4326008)(64756008)(76116006)(186003)(316002)(5660300002)(6506007)(7696005)(52536014)(41300700001)(9686003)(54906003)(33656002)(478600001)(86362001)(8936002)(71200400001)(8676002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RvysyXj87K9NRcXVcG+YK9lnJ/ALzQiNMfV6aKTyR91Q4RfdPOM9XUZR6RFU?=
 =?us-ascii?Q?qLpIgTYwQPGuNFgpdPx2/cqqy8JhC2RtNgfg30OiVvat3ra8LdcY0NhEYATS?=
 =?us-ascii?Q?TnBGTidcaahEt4BiiyQwo4XKQwenr2Yfg0iK1vpk/t5DUTKAzqCtb/wzhvGA?=
 =?us-ascii?Q?G7Meq9CI6yOagc4vyD7ShmKYZnGASMFhf3kLLtJ2N8HaDoDY3VcBBxuZlDJl?=
 =?us-ascii?Q?4mCiDkY6AHxG/DOjm3mzJWtzzghYG+qn1MwN0LhVZUrqDdYBwv/27IV+Akst?=
 =?us-ascii?Q?bxlMIj0jz7GvA/yOStKC9BTvIIGfj83qgtIFx/EZ5oHAYDpGA2MTET4q7gI5?=
 =?us-ascii?Q?nCOjEPD3ul24j5ja9EF1KwgisKqSqBtA18WARJl9n8NpR/rFc3znBLJ0pkKv?=
 =?us-ascii?Q?51oSPBrBzsXbvexa11ZHIvXzZ2sbo5rmAW5SO0QKwopeGyzDOYCfhjZveo0N?=
 =?us-ascii?Q?JG+FBG6NWHwsvY4ih6A+v0kIiAcDbu6+b9oO0TN8REQ6CLB+AkurCfBqL7KP?=
 =?us-ascii?Q?w98wt2oqkeEdXx9HYBizGICAo4Qsa2mBfCj0K5l4uLUvR7eN+m4DQyKQtJBA?=
 =?us-ascii?Q?g0LLdz+tQGcB79pYmB9eYEsCV3lv2MrZkZUX0J+QGJ1Bf2y6XNyNtlAvSZ9+?=
 =?us-ascii?Q?IlvgDdT2Q/9usTanwyPxk09Dm+u7Pb6pWAgl6ZFkg/2PsOEADpKzdudQB/0a?=
 =?us-ascii?Q?jEluhXKJmQCLKJnHNMniSk7YG57z2uj0T+SsmiQgAdODG/Mk6lssgfZ5YR6b?=
 =?us-ascii?Q?fQPkYDzaRtvIvszE1d3t6tAJ274vyxXVluoeKj1hwhNgtuJTwvISl3/78Mdh?=
 =?us-ascii?Q?uW5p7GS98jk9qMomt7yUOnUKGcp22IKYibtG3x3/fIR278bv53SRMllHH/1r?=
 =?us-ascii?Q?/ATj1Kvrl5/y1ll3W31vikxY/ee6aLHgpQphaJ03tgJhIHouUBxg7bqb2IWP?=
 =?us-ascii?Q?Ej0AFE3e5vEQzMK/ktZXn+bZ00Ti/xkwXKDjLR7+A3RnrjoFWIoCIDTHfNIf?=
 =?us-ascii?Q?SPrGBba43n593YPvy4OG6K8ZJeIlfovqxWFt+ZyPHaevs6kQKy90pu2Z7Wx9?=
 =?us-ascii?Q?YwoNFNOiJ4djXgfiXytPsgijVnVBsY0MARxFyJbqMPi4doj4dgvp4yqVPTJd?=
 =?us-ascii?Q?2R7XQaqcAh8W8ILGWoqHips1myRxB2baX8/H6rzpoG/8oFVZd+tKCMzqM870?=
 =?us-ascii?Q?BW8jNCdEpGQK8oeiCp3jE9sKuVl4+/B21iLATkblJTsTJlV2BBhEFZfTYwkb?=
 =?us-ascii?Q?q6TWn1YpmeKHbW2hBBiObHUBBTYklwG5URq1CDwlNAOd1OFChl4RZFzeBjwe?=
 =?us-ascii?Q?DhxBiSSvH2dktfJThje5sFlZSkskShQkkCHXlIyAIZt2T9al4fDiPFJPU6bA?=
 =?us-ascii?Q?ybusbQ/QDr60Ewenpr8/O1pNS3DSb8d1kWGGWV+Uz/AH3vJvB9Xl9EMwfNbr?=
 =?us-ascii?Q?ROjNGadO+edAWk6tTYDvVHPbscLLxYdqXXFHpBc37i0KBI0d2pjOcdS+1EpG?=
 =?us-ascii?Q?cDGLbbA9Or9LX4CzZ3rR3zzRYXHKiC0xuB0MbNbfxONx7tKsqP7bRSXLa/47?=
 =?us-ascii?Q?BSo3+9bxctbSj6NUvn1cCoINpqWcHXzruqVGiqlq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3558.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 072b2707-a371-4bb6-b2dd-08db8a37384b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 22:09:57.5028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jJrToid+kold4yyA4XpHyFrZRSkXqingxoLbqb5STKPuHE3W/yYmdbiTANVm0ROP2bBRMIgquS+zmciZULQ3Ylj1bd24ogw4/KJILF2Kyrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5585
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

> The switch MAC address is used for sending pause frames and for Wake on M=
agic
> Packet. So, make use of local-mac-address property in the switch node
> root and configure it in the HW.
>

> @@ -1211,6 +1211,14 @@ int ksz9477_setup(struct dsa_switch *ds)
>         if (dev->wakeup_source)
>                 ksz_write8(dev, REG_SW_PME_CTRL, PME_ENABLE);
>=20
> +       if (is_valid_ether_addr(dev->mac_addr)) {
> +               int i;
> +
> +               for (i =3D 0; i < ETH_ALEN; i++)
> +                       ksz_write8(dev, REG_SW_MAC_ADDR_0 + i,
> +                                  dev->mac_addr[i]);
> +       }
> +

> +
> +               mac =3D of_get_property(dev->dev->of_node, "local-mac-add=
ress",
> +                                     NULL);
> +               if (mac)
> +                       memcpy(dev->mac_addr, mac, ETH_ALEN);
=20
So the Magic Packet uses the same MAC address for all KSZ9477 switches
if local-mac-address is not defined.  Is that practical in real operating
environment?
The DSA driver used to have an API to set the MAC address to the switch,
but it was removed because nobody used it.


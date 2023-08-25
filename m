Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E25C787CE1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 03:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238789AbjHYBOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 21:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjHYBNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:13:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF0019BB;
        Thu, 24 Aug 2023 18:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692926019; x=1724462019;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tWWHB+vYgeT9zW2Z/Ie7Y25lWk4OUCj8m9SvuxIMmRQ=;
  b=yPIMfO1l4XbBjzmiXuYbUsqc7MgyhkJ0UXsJo0oOwfZnlpzOyeMh+XMw
   fLqZqEk4S8IE6Kg/i8xifKDPjund/bKJIpSVPUzORe7799PC0cZb5yI4Z
   fS1SI0bilqstsXHp6yIq87QLnStOQs8jCotuo/XPBj633yts8MRN6KmxR
   2rw/U08W/ir5ein1qhGrkA+M4fkgoJeR+ggorg/OY5KWHj/jV0/vIt+uw
   uzF4qIh+XZYkk4pvBgRPrQaCqfaxpn5n0dBcY0o+B+7Wy2FAN/i5M4Lx8
   FPIKYjRohlrfgYIYtLdnYrfrV7nWCmTHtolKVaTHKqNK/locbIiqCc3iU
   Q==;
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="1157184"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2023 18:13:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 24 Aug 2023 18:12:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 24 Aug 2023 18:12:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njDEKIh/kRcu5rHOj0SkTfg9I3RI8v1+/4MZPT/I9gyZwLAbexXevM0HwSRrtQfd/mC6NegyNAd811kEwEdtwkcpTXvlYCcAdGIZw8NLARf3qY3HdrH+VY5jIBzftnDXdEf2pe1k1L+pRo/bumej9/M2WeAXs4Pad7AyPekut09hj3MwbEdkKoR5t3r2XskYHYlykJfYV/3wFWLlbqgGplW1rWSAk2Gi6HoFDsagALD7UmG3CbRLhbBMrEfGLBexPfAk2hKQ/oXeWElVKESLS+VVtFXo0QtxbnsRDYnm7IDUpO7iO47DhfmH+29zE70J/lL04OQ+FxN3G0jf4dqQOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B51jCvj2ZzKptz0Bg9gOsIcRMeKsJq+NDY6U7hKxJEs=;
 b=O7KOgWVhnLEmhjekXDA4fwAkKmf0XMiDL/S6GmNu0xbJ2wvPM+OckuI2lX5VMRwMpPFGiBZUHyZlBZoGZpAGwDtpkquFFnqKqSuhfVKwUjrVXVY14lys/HfxSabLAyITDZLkgUJKP9BndUp4wAVDZuLzkabLmMjFgEon2O+/pTnwCEXiw+MhCixYuMAjATJPAIXGXiEWWcjtoxDKFgI6Dkuj7TCSFGarnxS1XR0u1laqZk1nzGbTOH0ylOtSo/pjorsETddA9UKBjisX2zJfAKs/Hut+ETZJ85Jh2f+VNHWKebtnAq8gmWoTe+Qge3Fb14F/UfcoFd1Y/MusyFCQ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B51jCvj2ZzKptz0Bg9gOsIcRMeKsJq+NDY6U7hKxJEs=;
 b=ampB/n+bv4BssalcnUQQdWUMck7e5qn3y73xKPlrMv9poUIeMnBuY7eeRRWlNV8BWKGt6vGl2NZzQRBqL7bq0IVhDKJrvyHSG3yfr190dwd5jeq0YVEBh+tU0f82e5ZmeW6RyE/LN4cxcieO68JXQFvnWJCpj7g+YeYYTeF4HJg=
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by SA1PR11MB5900.namprd11.prod.outlook.com (2603:10b6:806:238::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 01:12:49 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::ceda:7787:e08b:7a19]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::ceda:7787:e08b:7a19%7]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 01:12:49 +0000
From:   <Tristram.Ha@microchip.com>
To:     <lukma@denx.de>
CC:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <Woojung.Huh@microchip.com>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH 2/2] net: dsa: microchip: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Thread-Topic: [PATCH 2/2] net: dsa: microchip: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Thread-Index: AQHZ1qKWLyunbFo9dUGlg3dtAL+k26/6NENw
Date:   Fri, 25 Aug 2023 01:12:48 +0000
Message-ID: <BYAPR11MB35583A648E4E44944A0172A0ECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
References: <20230824154827.166274-1-lukma@denx.de>
 <20230824154827.166274-2-lukma@denx.de>
In-Reply-To: <20230824154827.166274-2-lukma@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|SA1PR11MB5900:EE_
x-ms-office365-filtering-correlation-id: b246c40a-a530-4d78-ee65-08dba50865e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /ZCiZVR0h4sEHiDT33BgEKYLmEvbZxAhPpa/PEyII7Exr+VxJUKSOXpTOe7LfId040D/HApeSqARJSqXnW+E/WW4B45OTU76JiPUQedfRgGD3ZTN7sQ4OfhtTgTLpSCcTO0qt0/8NbD0DShWI6Zatd0u5NWKe9LzwNyrTF+Fcbz0iG6p9GHvD0dhSJqi5kqkAv+rtnm35yCEClvyuAR14u57Xoxo9cJ6bIw6AYrIN7dIM+D2TKs7x91Kk4rLoKV+xcwz1owZTNrAor+ft/Z/G6Jp10NiC92xT0D8uyMt+LOBBN1snjPg/EWuU4AhK+zM7WmsFUa/7IIn1aTvfLHmIYII1/B0JQLhVakbDM4x+7XrUd29h6qt9t/XcUPrpb/olWC0KmzDxoMD5xwqvu4vE/vjWO1bAa8Db/4HZ561bFhUHyrDLXgmhA+dgHJ/W+0Jtalt0XVzz7E9a9ln5r4IJR58g7bAnUZ2r6ePy1zqrjAa6xjymHnhG88QIXx+R4ez7E+WXxKGuE57SVlErziCxR35HnY7BzEZpNI0zsD3chagKJndOQrZ2iUaAwjZtakKTqXA36pN+dvSvLv8ex1g5/vA96C2FPcbKSbOjCq6ZtWhi/Wlkv8Y7W5vfBhJh+WW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199024)(1800799009)(186009)(33656002)(86362001)(122000001)(38070700005)(38100700002)(6506007)(7696005)(71200400001)(478600001)(5660300002)(52536014)(54906003)(316002)(6916009)(76116006)(2906002)(4326008)(8676002)(8936002)(64756008)(55016003)(26005)(9686003)(83380400001)(66946007)(7416002)(66476007)(66446008)(66556008)(41300700001)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qm5Kffh+T9Vvv+eW563+2l+zBLSWr9EH7x/EXlp0lZwQslIdcDhOroNtdfEB?=
 =?us-ascii?Q?4gV2Rd7OC+1DLdI7J5klaRjnUVGZ/n5lBmzW2LbaX4wSRq31WncumrBLWO/4?=
 =?us-ascii?Q?tHGougGPdeHMdKORLYi6nZBcob3361YHh/JCWMpdINlMfeqbVaguZzjXh035?=
 =?us-ascii?Q?yoeurqq3otxrK5J78vsLCKWidFcW+V6u/wp+MHPH5SvzMxhvbrYBWFSwJSjN?=
 =?us-ascii?Q?57ScZVjAzCshRhsovBn5FhEkAp5iP/zcMrn4pZUkDGKX8cEQs5lAcatsXzWv?=
 =?us-ascii?Q?VINOL3s8xwkY4LFFp6YDxfw3RactrfDOTXHIaTP4MPTCPhzwUDVWno124VUf?=
 =?us-ascii?Q?knBciZJ6gU8cLKuef95piFjys8DiUlOtdG5IwSBkedStLxr/eMiBdk/c8qOG?=
 =?us-ascii?Q?b417R9cHnuDIWJSIUL+DHNyHLjXHu/oss9zgF/7g3nqMtOSTPHsGcbld2QWy?=
 =?us-ascii?Q?6IQaOBUjK4kOreDQYy4U3suI1//Lgyy+HdKLHgv3/9xaXWV0um8sl4gd05nP?=
 =?us-ascii?Q?QEJ8hHv9soJ5xWLRCPWydAH60YtbssXOCsMpbUngHxZo68y8ZTo6Zrtii8QU?=
 =?us-ascii?Q?KbocThz4G1dhuCC5XyCiGLtO2H5V7A6iH8c++SiNkqs2c9wdlcZAlVzt8VSS?=
 =?us-ascii?Q?syUKS35Jpd+74ETjvWkoE/RsaPe6wGkpTWDjfMT2ZXaRqlSAlJcAveMCBZuz?=
 =?us-ascii?Q?NVAdg9zzOu95jpMuByrlhAaTzcrpoOuNOydC4q+sdFLBtWMcSbu6bBoayHFI?=
 =?us-ascii?Q?6T2bSwSLWpTYZAt66/VRAbB3miGiXATn3dhJcO0bO5deiTP+gziyOVfdNxWJ?=
 =?us-ascii?Q?bmDfpWJwGfQvijMEcaEbl0iyMNzHGjOfHnh8yMQNQmybtcc2J7+NTrZdsjKo?=
 =?us-ascii?Q?G4l6P8UEFrhVuM7GvEhMJfE8Uj/UjkxgIfSwoS07fEan7lomFJo8Tgdpy4+v?=
 =?us-ascii?Q?IX+ZknuDJEvnbXBJ/ZAyLedEwbi0q74vRzks3V2nWwucowxDS8rxEGOYEjc3?=
 =?us-ascii?Q?fR2jqXK0Q1+jxueidsCSPscSSDHIJ5+vyY81GhxcFJ3frow1tRJc3LKjMMKu?=
 =?us-ascii?Q?cCr62LLg8mbtv8sRPPb1BG01cv1oBbWMtgy8FnzaniikZGjIUFkikEzVTBaI?=
 =?us-ascii?Q?Xy4kzUkxoofzPHssMyjE405y/L+uySExRE0j8AzrRm3uJ9iP3O4sV0encSj3?=
 =?us-ascii?Q?jiXT25opYWfzzZD8gOZaxNt4tdhMqWZmUNkEIe/BGJQoHBEVtjFUMp7NcAM7?=
 =?us-ascii?Q?r8VeSXsbwTVVOVG3xHB49yEXVQaupcHdzR/WVYSZ8dHvemh845bmcWiaA/Ux?=
 =?us-ascii?Q?qTJYm6S8qvUPw3S6ceGqaelaT8X3d7Z2f+BxYiLGRz3pDGIIEfg69gEUTdGn?=
 =?us-ascii?Q?WMp5tTxerRPsjMfE1RfT94YTM+oy36wtZQFqBamS75xXFhtNnIxkFFZyKLsi?=
 =?us-ascii?Q?C+lMzWxZHMIMJatB5enahCWe0F9iAIuKMUMnbb8/1/XlJ9HoUz1iVfkgDw/r?=
 =?us-ascii?Q?pAaEAONMfvJNc2RrBppSogXDOnx3HGuTBMq8JYcaqkEviaemXzHp4/nDIRJJ?=
 =?us-ascii?Q?e3MkXbLPpnOjR5ah04/Nj8cabXj3Ie/j0GqM/uzs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3558.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b246c40a-a530-4d78-ee65-08dba50865e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 01:12:49.0470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G1PljipRpQtWPKXfl+u3F+w1M+q2LlpYguF2itTzh73UOe2az4estkH/GTQGP900J/vcadZzXYSSkauBBmAjcN5BLvcCA0e1iPaf6AxjEzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5900
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int ksz9477_errata(struct dsa_switch *ds)
> +{
> +       struct ksz_device *dev =3D ds->priv;
> +       u16 val;
> +       int p;
> +
> +       /* KSZ9477 Errata DS80000754C
> +        *
> +        * Module 4: Energy Efficient Ethernet (EEE) feature select must =
be
> +        * manually disabled
> +        *   The EEE feature is enabled by default, but it is not fully
> +        *   operational. It must be manually disabled through register
> +        *   controls. If not disabled, the PHY ports can auto-negotiate
> +        *   to enable EEE, and this feature can cause link drops when li=
nked
> +        *   to another device supporting EEE.
> +        *
> +        *   Only PHY ports (dsa user) [0-4] need to have the EEE adverti=
sement
> +        *   bits cleared.
> +        */
> +
> +       for (p =3D 0; p < ds->num_ports; p++) {
> +               if (!dsa_is_user_port(ds, p))
> +                       continue;
> +
> +               ksz9477_port_mmd_read(dev, p, MMD_DEVICE_ID_EEE_ADV,
> +                                     MMD_EEE_ADV, &val, 1);
> +
> +               pr_err("%s: PORT: %d val: 0x%x pc: %d\n", __func__, p, va=
l,
> +                      ds->num_ports);
> +
> +               val &=3D ~(EEE_ADV_100MBIT | EEE_ADV_1GBIT);
> +               ksz9477_port_mmd_write(dev, p, MMD_DEVICE_ID_EEE_ADV,
> +                                      MMD_EEE_ADV, &val, 1);
> +       }
> +
> +       return 0;
> +}
> +
>  int ksz9477_setup(struct dsa_switch *ds)
>  {
>         struct ksz_device *dev =3D ds->priv;
> @@ -1157,7 +1195,7 @@ int ksz9477_setup(struct dsa_switch *ds)
>         /* enable global MIB counter freeze function */
>         ksz_cfg(dev, REG_SW_MAC_CTRL_6, SW_MIB_COUNTER_FREEZE, true);
>=20
> -       return 0;
> +       return ksz9477_errata(ds);
>  }

I would prefer to execute the code in ksz9477_config_cpu_port(), as at
the end there is already a loop to do something to each port.  The check
to disable EEE or not should be dev->info->internal_phy[port], as one of
the user ports can be RGMII or SGMII, which does not have a PHY that can
be accessed inside the switch.

As the EEE register value is simply 6 it should be enough to just set
the register to zero.  If so we do not need to add back those
ksz9477_port_mmd_setup functions and just use ksz_pwrite16() to write to
the MMD register.


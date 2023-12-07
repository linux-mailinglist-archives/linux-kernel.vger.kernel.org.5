Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2638085FB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbjLGKEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjLGKEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:04:43 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D49E126;
        Thu,  7 Dec 2023 02:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701943488; x=1733479488;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wGEwesqiD+1cweMK4FQ3boq85o4DuyZIBjf7GCzwqmU=;
  b=w6PXKF3bLtlat9ThTyl6QbXRwtNkpLmyMz1PBPNgkeqitFHcP4wANEb4
   dxqpd4V/pJloM/eDb1r2rtSmIyE63Lnr0iXLAH3FUBUvgPDrOLE83xL+T
   El3YWQq/DANdb+6hWOa4YS0/u+QAzEsy/vt00eapgxHBGD6yGDlVGZjBn
   hCNoTI+2zKAafaE/nuYmI1w7YfXP0tKDFgOKKZmeY5LvGJ+//XldvsF2Z
   cypoBdwAJv4YtSr8Yw/3McqbrR9DwbGJ8VnazG1BE77Kgp6uo9q8pnPCB
   URnoIuVniN9m3OOgz0Jm87WKZjZXG6VkajZKE2e2GLYofIj6LYGwABbG7
   g==;
X-CSE-ConnectionGUID: WvXTT0UBRauwg1ZTHOCVIA==
X-CSE-MsgGUID: VZe3+UkORWilmR8a9fuVOA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="180077309"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2023 03:04:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 03:04:17 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 03:04:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELuNRCdzVYCAbOWa2Ao2UyGc6AxFHooNhwpqr17a7gHUfuntRCm+JgzReAcF2ftqQpKjG62NaoHpJEyCIV+gPSI4DPdzhDOT8bDlGBdAO24Xocrmh9RzyLi483vZXwSEp/A3xDsPpD6EoQqoB9iUvkUTDzLnVz0tNZZBbEIe5k6nE6DTbWZ1jtTRJTjDIs90KlFkE36GdCrh9OCpcwDh+wjr62ss26J0WrsEFxhTevJctqGLg6NNZS7wUTQftQa/rKuqDPJj78jT1Wcv8S20jvDz+8Ng43+fdYMhz8XRC6gvapHQ3aHw8qUqcm1lWrycYQHJOANB8jgH2zdP+DYfqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGEwesqiD+1cweMK4FQ3boq85o4DuyZIBjf7GCzwqmU=;
 b=g7G89niLLkaj6hpNGNjBh4VItgAKLhw9Zzf9gcWU807fq1OKC6eGhV2OStnFO9kT3kBP2iByefYCdY36olzkjq2Qv22hVK7vEwmIyAWm7q0uH+RV/HXwweG0hwlEte8wqlFQG51+Q/E69ZqJ5u0PKvR+vvwVqvJfhTL0GqLL1K4DHPQ+i737d8/BRD/z8Z4MTV/TQ5ih1gAbp0x4FLcUKsIGAys2F+AIGm2m0rkUdYrVjzHejblbBquP6J0iYh3S0HDUfJyuYmbXoZyUzmlxiN5OxyMkJMg+chrG2Aa/QSUo2lZi17GihCl/AmTTSo+T8AGWEwMekvPsDmJRczk1EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGEwesqiD+1cweMK4FQ3boq85o4DuyZIBjf7GCzwqmU=;
 b=X+lvkW0dDW2WAPJgSzL7IQi5owdwKhyZftgdj2BW5xB7QEz48MVy7CqF7qlHPZxP6CoICnzPLHzO7wyAiE3rmZq/7EjxqrMnkYMTwK/EfgKviQ2KK3E/7qvgwUv950LDu7zRoLLJTZD1zNuItgwbNFylzXVscftrvGSPNj/u4BgnX1bL5VCTl0n4lF6zAjO2WHvzHCkEJhjEEYSGDk5qAHdbwQnJQE4PBe3dXL6XT9H/7SNE+nWzMoNFZLY7yfVSP8hF05jY5+8ctUPV/CFi/Yf1HROXrM4DmG+uHB5Hcqig2Osni6r+ZXBQMrNo7J7b9sJ95X/WvvUciXES+4a0bg==
Received: from DM6PR11MB4124.namprd11.prod.outlook.com (2603:10b6:5:4::13) by
 IA1PR11MB7677.namprd11.prod.outlook.com (2603:10b6:208:3fd::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.27; Thu, 7 Dec 2023 10:04:13 +0000
Received: from DM6PR11MB4124.namprd11.prod.outlook.com
 ([fe80::af51:1aed:6d1c:6d64]) by DM6PR11MB4124.namprd11.prod.outlook.com
 ([fe80::af51:1aed:6d1c:6d64%7]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 10:04:13 +0000
From:   <Madhuri.Sripada@microchip.com>
To:     <olteanv@gmail.com>, <sean@geanix.com>
CC:     <Woojung.Huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <andrew@lunn.ch>, <f.fainelli@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <Arun.Ramadoss@microchip.com>, <ceggers@arri.de>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 net] net: dsa: microchip: provide a list of valid
 protocols for xmit handler
Thread-Topic: [PATCH v2 net] net: dsa: microchip: provide a list of valid
 protocols for xmit handler
Thread-Index: AQHaKBRhZLeoCpYepkqcVAzm+JG6R7CcgKEggAAEfICAAAKmAIAABI+AgAEL6iA=
Date:   Thu, 7 Dec 2023 10:04:13 +0000
Message-ID: <DM6PR11MB41245D212313D53CFB793BE8E18BA@DM6PR11MB4124.namprd11.prod.outlook.com>
References: <20231206071655.1626479-1-sean@geanix.com>
 <DM6PR11MB4124D98726836442169C2C55E184A@DM6PR11MB4124.namprd11.prod.outlook.com>
 <20231206173543.ag7xb4vhcjknyiyv@skbuf>
 <2244A511-6F6F-4711-9BE0-30786B021AE5@geanix.com>
 <20231206180131.6uy3c3nazjaok2yl@skbuf>
In-Reply-To: <20231206180131.6uy3c3nazjaok2yl@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4124:EE_|IA1PR11MB7677:EE_
x-ms-office365-filtering-correlation-id: 46fa4dd5-a18c-4919-7b8e-08dbf70bdd54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mmz9CUsG2cQ9EMSI4vY+HB6DPpzfKAPH+oORhpVvsyCsCReVU+2vr4cGk2L+SzMOLJbaHJt7+wa6YhL6rIL2jUT1Xh/sGZ4iT9HJX4Yo2H+r0XBwuosVsWpOR8o1JL7N74L4nk+dLn5rCo22QycxKEPEQgVoNW2AqdLc463syyV37ImTs5T6R3rxRfuRrTF0m8BLTTss214oWvukJSkbaTJDCY8PbgGPkf0DjMq7OU1G37Fv5gp32oJ1wOd4fYM+0dxkzHPOkbzAFdzUWzI4G4AQOECj5HF09gAy6wPn4QLRaYBym6uC7q+YjqbtH968Lan7PJtzCgqZiW87QxSs8vl8vl5pgOCh4CBE7/PlD4upu/W9z/iTBmmFqF9eLOqbYNLCMreOkRGu3YsDveE9ZqXX3+WbHBbTY4+6QTEJ+R+Eyw/DKH4fACRTzYb54IzXhj17kv4mTnpf5KC8G8oDDOpBkrLWSr4aWBV15Md36bIr22NI6nH+H2ObCI0zQ4hWeT1HKgezPW01tV9FHZw1AVvbWKOx/Lzmv0O5SN+Ictu2H8xtDvLv6iCfEaZiklGYYwtDxrBLgRu+jqKnvsdG+9qooEHT9JMu1cLc+pwU29IwB+4y7k0tHBCrv5JMBJZTSd32VxJh+WOEuAs0ERyIAVcilYOXrKA0QFsmBOuyYpI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4124.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(230273577357003)(230173577357003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(7416002)(5660300002)(2906002)(41300700001)(122000001)(38100700002)(66556008)(76116006)(86362001)(66476007)(66446008)(64756008)(54906003)(66946007)(110136005)(71200400001)(478600001)(26005)(53546011)(6506007)(7696005)(9686003)(83380400001)(8936002)(52536014)(8676002)(4326008)(316002)(33656002)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vm60Cliv6R4bPMyJS10jPiJWqVyvI7O7ndq/8QtsL71FFvSrS/rVLkQkNjk0?=
 =?us-ascii?Q?/ZT+UoGUsoCs4hzTem6o51AgZpDXvo8H+a2LVdZ1jpjdgJyQ7UXnPyD87LOf?=
 =?us-ascii?Q?ytBynV2I5JkgjuCUkjrny+fyUYIrRbiR1aXjyYJbAlAiA5N68SvzCDwTsdmh?=
 =?us-ascii?Q?GBQ2nHA58W62qs5CXUuNScJwmgsN6vdTrPAkoOrdIdab8wGilVVMxRoDFEvT?=
 =?us-ascii?Q?NtJAx0xJjGAY2R4BJ/gFPDCox5VJnN1PMe0L0YGp1qaOCOwxT4OJWFhfTqga?=
 =?us-ascii?Q?Yb5auNFry/8+rPxb8a3sW1yzUlLLY/9LFNT/KS95fUysUVH4aJ3evjesrVCL?=
 =?us-ascii?Q?HURXiuV520qOCzpjBEOaT0oc+JYdW70Gsy5xGdEb/WRfNEEHTw+rWLc0PbRt?=
 =?us-ascii?Q?i+by6B0gL+tLZASLhKG9uJjPPdxJCEpxjFSWcoXrHlmD3fFVEVVU57bLuNkx?=
 =?us-ascii?Q?7HLwxWH/+jukUQbx3QcyjppiX3sbDktmU0PjPS0XKf2drRD4OHUmZwf3lPHy?=
 =?us-ascii?Q?Yzw4Zc8byD2dI/PTGsk3ieqmy8TUGBy9I62zzcX5lc74fSEq2jK0e8MIcC+q?=
 =?us-ascii?Q?fQJItAE3WENB6JmekYjnh/FOWPFsPwhOqDJua2OgRa0JQ+rjt9H/MKvJscLF?=
 =?us-ascii?Q?pKyBDILHK2Z8QABmqkSjLKGDBnCb6UIe3cU8odeCOHS0D4KGOZnV6KDxM1gb?=
 =?us-ascii?Q?xkpEx7TQW5QpEqxAhHsySpTXXNjudIvDlcrM+d/yuLjh/1Gl1kU2nk91fUdX?=
 =?us-ascii?Q?EC52Ykiol0TCnGlbJd8E1NFR83OoLIf/GsBy26eMOtl8GXqi3I9RHkX3+rIg?=
 =?us-ascii?Q?P9CDvHhRhl/Mq/AT9VGCVulDH1IYNpd/JSUXYGe29QvKD50NaxXIIEn9a7ts?=
 =?us-ascii?Q?LdAwtKr/jflJGnFboAdUBUTKqDzpgwj7H4KS0WzzWap1450gOBP7kKb4q8DN?=
 =?us-ascii?Q?A9il7NZBOVxFGG6e2b4Up0eC9OLiX95/NPx6wPYs2s8spG2As3bH0HfDy4jy?=
 =?us-ascii?Q?Jfbf22BuTe2aJF5Ia65JOoBE1tSDiHn/w2vq6JAleYmR5lHAuditcctyoodr?=
 =?us-ascii?Q?JRuYHmUBDZTXpbdDuq3vuWlTySyHlUU/V92blvt20xn4JRis/jqrkqznccgl?=
 =?us-ascii?Q?0Fabj/5EXwagkBAoSpsqgvNaOl6V718DllZhTEB2M0jEF5jVftAAtvOFcRhL?=
 =?us-ascii?Q?b0lz4GvTJXBWQbXvcaUVO2dfLFKeINdATxPSysqmqBxyRSbE469OWQYQk/MC?=
 =?us-ascii?Q?ZTK+//JKhnHXNWsx72lBlOi1sdq4ONLjd5h9HXO3ObWEosOcJN0tmc2F/by5?=
 =?us-ascii?Q?iyvSqq24bDu20R4C8FFqNoJDtE7wbBSqBixkSYOHH6WbssjVnuny2rYsISnk?=
 =?us-ascii?Q?QJYf3bWX+YgWW+A9eJucpow2xSR03lb/6/NgOD3e4AhV1n2z48VMTqL+5x8A?=
 =?us-ascii?Q?dMqbffHB0z3pTQTyR3GlDD044rXXcDan2Ejdltq2lMKjqKN+Ad/Z6647tERD?=
 =?us-ascii?Q?ddghkgKEN4THSLrB8xZvv+XxovRYzT8E2OX3qmOSZBpR2r6zxMW31FD9Yt9X?=
 =?us-ascii?Q?e6h9uc775/UDJL2BOLFtFjOBamENxjIcJnwNm2lmTjUQZevPtJtZ0gFbPv8A?=
 =?us-ascii?Q?AQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4124.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fa4dd5-a18c-4919-7b8e-08dbf70bdd54
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 10:04:13.2651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3G6qdv82Z/XDIUm6lstbd1T8BOgUwxln5r41mOtUfo+vc9imEx1koqXuZX2kPQi+qp2i2tbU/52JccOzN16GqsdDs+Zpb6AZTmgIFIAmrVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7677
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

Vlad,

> -----Original Message-----
> From: Vladimir Oltean <olteanv@gmail.com>
> Sent: Wednesday, December 6, 2023 11:32 PM
> To: Sean Nyekjaer <sean@geanix.com>
> Cc: Madhuri Sripada - I34878 <Madhuri.Sripada@microchip.com>; Woojung
> Huh - C21699 <Woojung.Huh@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; andrew@lunn.ch; f.fainelli@gmail.com;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Arun Ramadoss - I17769
> <Arun.Ramadoss@microchip.com>; ceggers@arri.de;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 net] net: dsa: microchip: provide a list of valid
> protocols for xmit handler
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Wed, Dec 06, 2023 at 06:45:12PM +0100, Sean Nyekjaer wrote:
> > > Don't just leave it there, also explain why.
> >
> > Message to me?
> >
> > /Sean
>=20
> No, to Madhuri (as the To: field suggests).
>=20
> In the Linux kernel it's not a good practice to put defensive checks whic=
h don't
> have a logical justification, because other people end up not knowing why
> they're there, and when they can be removed. Checking for the tagging
> protocol gives a very clear indication and traceability of why it is bein=
g done,
> on the other hand.
>=20
> If the ds->tagger_data is NULL for a tagging protocol for which it was ex=
pected
> it shouldn't be, and the DSA core still decides to call
> ds->ops->connect_tag_protocol() anyway, this is a violation of the API
> contract established with all drivers that use this mechanism. Papering o=
ver a
> bug in the DSA core results in silent failures, which means that any furt=
her
> behavior is unpredictable. So I'd very much prefer the system to fail fas=
t in case
> of a bug in the framework, so that it can be reported and fixed. With rig=
orous
> testing, it will fail earlier than in the production stage.
>=20
> I only said "don't leave it there, also explain why" because I really don=
't
> appreciate review comments spreading FUD, for which I'd have to spend 20-
> 30 minutes to explain why leaving out the NULL pointer checking is, in fa=
ct,
> safe.
>=20
> Of course, I am not excluding a not-yet-found bug either, but I am strong=
ly
> encouraging Madhuri to walk through the code path and point it to us, and
> strongly discouraging lazy review comments. It's not fair for me to reply=
 to a 5
> word sentence with a wall of text. So I replied with a phrase of comparab=
le
> length to the suggestion.

I am new in this community and reviews. And was reviewing from code point o=
f view where NULL check is a primary requirement and a general practice.
I understand the justification and will make a note of it in my further rev=
iews and my kernel development as well.
Thanks for your inputs.

-Madhuri

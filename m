Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4F87DDC72
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 07:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345150AbjKAFmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 01:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345104AbjKAFmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 01:42:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EDCDF;
        Tue, 31 Oct 2023 22:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698817320; x=1730353320;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dRvom4WpwC/HM1i8y8nd2R0ynCLU97LC2OFuts3m4MM=;
  b=KDS3aT/RVoyFs8iXVIVW0NNLdUzT+0PvF1l8xTS2HI3i4n1KhzcbKO3w
   k/Wf04CIEkMPStWL0+ufbGCkdbSCQx0a7yDuPN1xjCg/4UsiK7o60kr8J
   NvyWPiLBSHbYz6iwTG9qmGCSETP8mtf1JqBvprl7g/JJArlB+qjgWT3Sh
   gc8HiGsvND0t+KWYnyjt6asypAJeT/hpjXgq8Zi/NojHB6leY+SyXSMAH
   pQEn44hipY0cuiMHgcId3VM7xjZcYPbBP2aqThoNt7yBMeR5oNOiDDsS1
   oclfBCXuU/5KMq2/ABiuKlnSmiBNMWcuIWcwQgdBAbJlRo3+Y8AcxGvr1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="454910240"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="454910240"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 22:41:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="1987283"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2023 22:42:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 22:41:58 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 22:41:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 22:41:57 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 22:41:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6osAhfxq7Vc8jJV/lrlmbTy8DX+Krz7tUpqo8u79qdCyQQm0WiHVzy+1SWPiA+EWnu1cVFQClD4pvuWhNprHza8SAbrDxhEsDSCo9GXLOQpp4WcohhcBLuPXpjWaN5l9xW7GQKPJf7hQxg8vwNDdpBBuYWHMQR6zabO/Lgn8Rp3IJGsNIZtDu1zPkn52FuVspf7DddfE2ErNS+NW9paKLDleWPAX98V43ImHmCGBxYTHho6aadKnxu2C5FKPXbAp6ZntSwhu3GnY6ZyMx8U7Ze/jJqZca/Kty+VdN39CT5rtrk5ECIKEbC2kX+fMvsaXiMrxAvzPRP+OgdsABHhIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tDU9u+VeYNO2sYrdWAuXrSRTes1EbzPzgaB0MCt1P4=;
 b=oF9AmIJ6fQhMzXlYAJszviY237FJWW5kgRYPKEoWHo28Au88nZrbUSFPJTdlCRI3axDrBRa2mqaqBKwiNWAwkXdspnlDDhudH68ogsoT+JpSLx1LjE9BekMqDeeA4CWxT3Qa5OXrUfJwE0+LlC3n/9KdtIb5atDu7kyruqwdyf9N0SHjv7UCV0MvZzy2w7euynoC9pnXFT37S4Rpp2LldrfqKlK+1x2SJaXJSWR2a5wrgoPl09VGv71KktLbERVK8YsaFcN88DItYse4Nhx4w5y+94/IyK3iFgwwwvkowueNeYrx+svpnOgjNXT0eyJqbbR5E22oaP5DBuEqUhPLNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3306.namprd11.prod.outlook.com (2603:10b6:5:5c::18) by
 SN7PR11MB6603.namprd11.prod.outlook.com (2603:10b6:806:271::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 05:41:49 +0000
Received: from DM6PR11MB3306.namprd11.prod.outlook.com
 ([fe80::2126:3b64:585d:7da9]) by DM6PR11MB3306.namprd11.prod.outlook.com
 ([fe80::2126:3b64:585d:7da9%7]) with mapi id 15.20.6933.029; Wed, 1 Nov 2023
 05:41:49 +0000
From:   "Gan, Yi Fang" <yi.fang.gan@intel.com>
To:     Russell King <linux@armlinux.org.uk>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Looi, Hong Aun" <hong.aun.looi@intel.com>,
        "Voon, Weifeng" <weifeng.voon@intel.com>,
        "Song, Yoong Siang" <yoong.siang.song@intel.com>,
        "Ahmad Tarmizi, Noor Azura" <noor.azura.ahmad.tarmizi@intel.com>
Subject: RE: [PATCH net-next 1/1] net: stmmac: add check for advertising
 linkmode request for set-eee
Thread-Topic: [PATCH net-next 1/1] net: stmmac: add check for advertising
 linkmode request for set-eee
Thread-Index: AQHaCKJwVwif6aPTx0uyiZuY8b+qrrBdP/QAgAZSMzCAABBMgIABUPlA
Date:   Wed, 1 Nov 2023 05:41:48 +0000
Message-ID: <DM6PR11MB330605F0FDCE81F8379ACFEBB9A7A@DM6PR11MB3306.namprd11.prod.outlook.com>
References: <20231027065054.3808352-1-yi.fang.gan@intel.com>
 <ZTtpBCZuB+bjVt9D@shell.armlinux.org.uk>
 <DM6PR11MB3306A3162F6A6086A4CBA049B9A0A@DM6PR11MB3306.namprd11.prod.outlook.com>
 <ZUDEIZwKMl88hGcX@shell.armlinux.org.uk>
In-Reply-To: <ZUDEIZwKMl88hGcX@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3306:EE_|SN7PR11MB6603:EE_
x-ms-office365-filtering-correlation-id: 50a6fdc6-c216-4d35-8548-08dbda9d3dca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KP2x8923kX+hq3gXji0W9LJPl9jfmMSpMaAtwrbySQBaGix+bMU3ElujeociOFU0BNsAV3EmQqJ3CJFsZKqhi3zu5v9N0ZOLAstq6ipJ8vZkxXD/mFskPFZE1XkBbUESKFeh6+v8E4dxTzWTu8Wae5e5kl/KYXXLlacEAwuQX4cjswy7Pp94tNqL118rEuaFld3HOiphQ5JoxY33S8NLMl2v2fhh02Ie8cvQx+4JDdPilAGh0ySbvnqSmxqhvgJ9ZUvAEguNj+rvfcRu4s1BdW2NEvV1aPs3huZb5cSY+76k46DUVUmu03obW7Oknf6v+HCeEqXFiRRoJXB4Zwbi2k0h0Zp9X4rcrb88epS42HQlUMiFK+KhlTBJe22J/OGVkcJuQ92YWAfjeD+QLuSJTuzSj13wiwU/rgDwFjiIaHl7I2vdeIDxeIRbt8IJ6hbUVU/RuuTSjJuOZ99MhKi6cIqlNCCI7BjeXahUUpa7YBDKkQrgorXE96cwP0cbxBtafBZGI372xDA0SSz8WCkTt830FGMFt4rBuElFuKGFl+38YwTWQYjujxYHWXGxvazt+MIm2+c6RW1SRdty87J+Td5wBouSEiTYIxlofwaHp/0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3306.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(396003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(41300700001)(478600001)(53546011)(6506007)(7696005)(122000001)(9686003)(38100700002)(66556008)(66946007)(52536014)(66446008)(82960400001)(5660300002)(7416002)(966005)(8676002)(71200400001)(8936002)(4326008)(55016003)(33656002)(76116006)(86362001)(107886003)(6916009)(316002)(64756008)(54906003)(26005)(83380400001)(38070700009)(2906002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Gy86kkRzuYym9LDP0Jv7dZ4vUWrfj0t+WzDMGyzLUCsCZMvBSPxChUkEL6Xu?=
 =?us-ascii?Q?Xbhe3bg0lKplxrlS4CqDXrMU8/suh2zh2IqVGE7vq/m3gvT5KIRjNXKfrgf6?=
 =?us-ascii?Q?LocFTVbhLaZu575kWJHM7WbretjA2p/S6GYeqhQAV0PSYi3eO9SlgH5dN2rI?=
 =?us-ascii?Q?B6PKUMvC3g7gBOC7IZzg08DV5wObrWturFTlIp2ad8dxNetrtbxPa9SjATjy?=
 =?us-ascii?Q?CNR1DrKsv6IfKPSXxws0ulaho4dvHj2wHClvrVsRwdjgv+lnAO8KTi5tUUI2?=
 =?us-ascii?Q?9StWmzi0oOoTDrlKOLhP5Fwl/7ii0eu0P2hYmw1Fr7FGpM4GjET3x0aXrDmS?=
 =?us-ascii?Q?r+qguIsuhtvTbQcaoZsvyE5wvnthSiIUl0v15wvQlGJ7KmxYmjh1vTuceMWf?=
 =?us-ascii?Q?sLb0rQR+CJwA+FPg/kcAh7HYiUhgWmxkn56E5oRFf02DFm6nqV5ZUDpH8You?=
 =?us-ascii?Q?BfliVczHvH4rDEIjHlXMX5TqfSELJ6etZLMFgohxLwJjmYsyFJCm9XvFD6+g?=
 =?us-ascii?Q?ZAaGrh0IM/NH1XT6E8ZuhPaSAWYLsc+MN5+EqT/pY5huA4SR0uXNEXnYXBmh?=
 =?us-ascii?Q?qrKprgoSOujVNCO6hS/R2HzSLasV4qH63SG9Flza0fbnssQXYGCYTCO5vicE?=
 =?us-ascii?Q?VoLcyJ6vOwd0nCfdSN14HMj2u+DRV+OLlFB3cj9vCqwoly3GMwZTsqAYwp+M?=
 =?us-ascii?Q?j1KPiuch5VMTr3KfqgYNZ9Kk8p3SNfYJPoNyuP8Wz4dwynRIb5BCrp/4ai+6?=
 =?us-ascii?Q?qzlDU+Ytlvb3jHpLBOrGI1EPvZf6gVcqOCBmvrHkOaN4kF2Pdi922D3bzAI0?=
 =?us-ascii?Q?jdxxND1KObOFkVpWDQckMF+tf0TUXSldy1k0fhfCfJxtJBM6+JI3c9Dcvexh?=
 =?us-ascii?Q?LJvg889lrtkJ/l03bc0WWtJpsNTn7zOdv0xmRZYh3Bb2z08hAZYMaz03+ASC?=
 =?us-ascii?Q?sQuyEqtJ5seOjevci3F4pYMP0dK8KnL2ZeKEkDmve0lwx0Od6LeSJK9sQrW4?=
 =?us-ascii?Q?gGUzPqAAvgC0keBOLQu1b6t7F6CMcMN5ozM3RqUbOn+wKxUtDjfoM4s4UJoP?=
 =?us-ascii?Q?z2hfkNvHUA6lplWkHXAmR35OGck6ChJVyZKuuwtGwQPTyFtpZlGR9POAJAIq?=
 =?us-ascii?Q?QLXeQXGSIkjVxvA2dTrTO/zUxyh05EuYThiGtafyljS59+ukB2fQVZgMNJiX?=
 =?us-ascii?Q?L8Q8Y63wQYpLDuVOWpGkbHcMZuHtUtrMCzCGaCSwUm6HoFQ6pzARHPJS73va?=
 =?us-ascii?Q?5lqS1TZOLkyVOOeqSF4M17raRvv+gv3aNyHc3qg0ONRqKTULsg4jB3/KOPnW?=
 =?us-ascii?Q?1nq8LVemlAizKpi3T//22BFCcqcYpos2KsJA8uAPFdQFOzlmJCHztlhmrD7L?=
 =?us-ascii?Q?mJDDiZ91zi3p2z0JrUH2sO9fJAc0ZWpQVlEilJEyh+FmG9ZoQm/PDIPfBYgG?=
 =?us-ascii?Q?lxTAEmzEA/hdYUeU2QIWITaRjrSyubvGVkdGEaN0nG4QbHw/ewUIrpIybxJg?=
 =?us-ascii?Q?pxy/nOHnCXtZD6a37rBwSNrsi1/ub8q3FGnA9F7WqdD4KDf+gH6KO5yRoUZR?=
 =?us-ascii?Q?VDBl2qRs4h7hpkhNUfmPtMpkrPmXieNdhu81F7zu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3306.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a6fdc6-c216-4d35-8548-08dbda9d3dca
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 05:41:48.4189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /SrLds/E9M5yZCP+/kWWAGiDu37dRv7BlLG/HKXQ6IY8dnqpOVF+G8RzibM+qr+x8UDeOK6hodLMA34scT1Iqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6603
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Russell King <linux@armlinux.org.uk>
> Sent: Tuesday, October 31, 2023 5:09 PM
> To: Gan, Yi Fang <yi.fang.gan@intel.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>; Jose Abreu
> <joabreu@synopsys.com>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Maxime Coquelin
> <mcoquelin.stm32@gmail.com>; netdev@vger.kernel.org; linux-stm32@st-md-
> mailman.stormreply.com; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Looi, Hong Aun <hong.aun.looi@intel.com>; Voon,
> Weifeng <weifeng.voon@intel.com>; Song, Yoong Siang
> <yoong.siang.song@intel.com>; Ahmad Tarmizi, Noor Azura
> <noor.azura.ahmad.tarmizi@intel.com>
> Subject: Re: [PATCH net-next 1/1] net: stmmac: add check for advertising
> linkmode request for set-eee
>=20
> On Tue, Oct 31, 2023 at 08:44:23AM +0000, Gan, Yi Fang wrote:
> > Hi Russell King,
> >
> > > Why should this functionality be specific to stmmac?
> > This functionality is not specific to stmmac but other drivers can
> > have their  own implementation.
> > (e.g.
> > https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/ql
> > ogic/qede/qede_ethtool.c#L1855)
>=20
> This is probably wrong (see below.)
>=20
> >
> > > Why do we need this?
> > Current implementation will not take any effect if user enters
> > unsupported value but user might not aware. With this, an error will be
> prompted if unsupported value is given.
>=20
> Why can't the user read back what settings were actually set like the oth=
er
> ethtool APIs? This is how ETHTOOL_GLINKSETTINGS works.
>=20
For current implementation, the behaviour of "fail to set" and
"set successfully" are the same from user's perspective.=20
But yes, user have responsibility to read back and check the setting.

> > > What is wrong with the checking and masking that phylib is doing?
> > Nothing wrong with the phylib but there is no error return back to
> > ethtool commands if unsupported value is given.
>=20
> Maybe because that is the correct implementation?
>=20
Yes, I agree with this.

> > > Why should we trust the value in edata->supported provided by the use=
r?
> > The edata->supported is getting from the current setting and the value =
is set
> upon bootup.
> > Users are not allowed to change it.
>=20
> "not allowed" but there is nothing that prevents it. So an easy way to by=
pass
> your check is:
>=20
> 	struct ethtool_eee eeecmd;
>=20
> 	eeecmd.cmd =3D ETHTOOL_GEEE;
> 	send_ioctl(..., &eeecmd);
>=20
> 	eeecmd.cmd =3D ETHTOOL_SEEE;
> 	eeecmd.supported =3D ~0;
> 	eeecmd.advertised =3D ~0;
> 	error =3D send_ioctl(..., &eeecmd);
>=20
> and that won't return any error. So your check is weak at best, and relie=
s upon
> the user doing the right thing.
>=20
Thank you for the example.

> > > Sorry, but no. I see no reason that this should be done, especially n=
ot in the
> stmmac driver.
> > I understand your reasoning. From your point of view, is this kind of
> > error message/ error handling not needed?
>=20
> It is not - ethtool APIs don't return errors if the advertise mask is lar=
ger than the
> supported mask - they merely limit to what is supported and set that. Whe=
n
> subsequently querying the settings, they return what is actually set (so =
the
> advertise mask will always be a subset of the supported mask at that poin=
t.)
>=20
> So, if in userspace you really want to know if some modes were dropped, t=
hen
> you have to do a set-get-check sequence.
>
Thank you for all the feedbacks and explanations. It was a great discussion=
.
I understand your concerns and reasonings. Let's close the review for this =
patch.=20

Thanks.
Best Regards,
Fang

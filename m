Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8247476C638
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjHBHOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjHBHOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:14:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9889198B;
        Wed,  2 Aug 2023 00:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690960477; x=1722496477;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LEIipqkW6RRKs6dpJpj25NcSenb1nz04BVFnrxLtM8Y=;
  b=MDeAKgdIwDLEaOk6FbGRBDAmYinTL2D09Zrw7gIqPHh4VneTVQ2dqiwn
   yZkNYpbkt9GixOJLhuH4uI8rdHE79n4Hsx0rtCUkAtc09TcKjRf0PFWpD
   vBgtz7HUE/9GGscAnh9b0pUgDYIT310hQ0FnXx/q7UPdunQ73JvOFhubN
   qSiBVdSNbrrDOLVvCMgEZLrq3xLY62KEzhQSUB5IYrw1VrPkX8UHCmiGs
   mZmmt4v5Nv1VDfJ1BYjCNiezcLpcGnOKbKhXZ66FMcTJT4bv3QDFOJJHO
   30F8zqUsC7Ic7jDI8/oMbML7ZFPjNFIf1yRPRxeYm08jaDLXDKMRNPLW7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="349103287"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="349103287"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 00:14:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="728993488"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="728993488"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 02 Aug 2023 00:14:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 00:14:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 00:14:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 00:14:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvK2/mcEylXXnr58OUj5qDY16tIBzawDM1/zrDyuD8DqbXnGKvVUdD0RH8rHOp7UwdwxSMXRB4nD1ht0HD7C3XiF6aEynl2+K5dfOtMI0PAMEhvKH1KbhO3vkVeqrGMztoa0xBKwv5KoFCM0HvFQrTjXNkoU8K7AHmNiXUg67PtaZ81mD5ZLvUsQKvIH9O/ocJgXcVuOy35zar8oMsFrfTGi4xH67geLeHV/m7pZ85q7yXMlys6h/alxth4k7GbvnWQ2/2800Kn0fge8d6DNuB17t3gLnXhJG+HrlXcMoBaENsqxY+DI52O92Xxzt1pczGisJL6qAJ5CYgV+il0ZxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88PT8ZlVqFJ1X+kWM86XfKsnDXq0lK6D1m+HvDO5WZo=;
 b=GbIv3PXOwiSlUachTvwbvF7Ga2InUm9IrNCPkryj53kzwkcllzE2uOt3qRqZSwKGr6gUoEAKyIizRnhoft8dpQyndiXfTVUPDevIoPeHTX3CN+LoLs8w8O2MmJqVIjapQLWBoMX/8yonN48lbhcdmJivaFcHZAUimFcQJ9cK3py9VAMpbcPMnQIzAF3cFmgu2xs96cQWUbpranIBG26REmVDcv8oIEI0WaPyTu0w8y5/fVQ3i6RO3cuKWwZkb0IzoOj5OAeomvQWAkwMe6y/AhCT2Fi0eRMFk8P7jBwwgDRTvjbuwNe2/3O/EqlG7iZoq/7Bu90VNJRsAozI3Uo9DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3291.namprd11.prod.outlook.com (2603:10b6:5:d::10) by
 DS7PR11MB7691.namprd11.prod.outlook.com (2603:10b6:8:e4::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.45; Wed, 2 Aug 2023 07:14:33 +0000
Received: from DM6PR11MB3291.namprd11.prod.outlook.com
 ([fe80::cf83:5843:b3c9:10af]) by DM6PR11MB3291.namprd11.prod.outlook.com
 ([fe80::cf83:5843:b3c9:10af%6]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 07:14:32 +0000
From:   "Rabara, Niravkumar L" <niravkumar.l.rabara@intel.com>
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     "Ng, Adrian Ho Yin" <adrian.ho.yin.ng@intel.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Turquette, Mike" <mturquette@baylibre.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "wen.ping.teh@intel.com" <wen.ping.teh@intel.com>
Subject: RE: [PATCH v3 3/5] dt-bindings: clock: add Intel Agilex5 clock
 manager
Thread-Topic: [PATCH v3 3/5] dt-bindings: clock: add Intel Agilex5 clock
 manager
Thread-Index: AQHZxO2EG7JC9WACGEGbHiM1L/cLLK/WlK6AgAAB8WA=
Date:   Wed, 2 Aug 2023 07:14:32 +0000
Message-ID: <DM6PR11MB3291627AB955685C345F7B71A20BA@DM6PR11MB3291.namprd11.prod.outlook.com>
References: <20230801010234.792557-4-niravkumar.l.rabara@intel.com>
 <20230802025842.1260345-1-niravkumar.l.rabara@intel.com>
 <20230802-reuse-diffusion-d41ed8175390@wendy>
In-Reply-To: <20230802-reuse-diffusion-d41ed8175390@wendy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3291:EE_|DS7PR11MB7691:EE_
x-ms-office365-filtering-correlation-id: 0cac37c6-ec53-4025-fbcf-08db93281ee2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y8+MpUoZteN87hLn8T4trVWnVc/PJt+uoDw0RSdJpWcrwxqQD8qJRrifd0L9jaSmds/Z9mF1X0SP98290/d/K/6f45pqRvHtt9GcjwGyPCc1t63MoNwiUPFAp498JxkUykFRGMKChQnbgwKl2NnRUywgmh4/Nw9uY7sp5A1kF2QC31czJRy8rsXqXAoNEaxAbb4T4NafHS5jiQMJrPGhVe3NKm4m1Qy19dvqizWKMjpnd5sTr/aUlJV3AyJwgc7oJs/VTngU+qFXBYEwyuNqQ4uloyrhleqmTCurDSNk1OZcjq/tqz4HVaY/zsbDK4KNy8+wd+tXQvBTA0WjTWTST4xvseG+XYTptl62ubNbxzRSDZKt43BQXPFJq92DDNT2y3zD8tGLTXmbrT+x9FgiyuEfspFthYE44tVIutzOUIC2i09J5IoSl2eTAsyAYAE9minvjLlPOgxtaN9RJIyr/45vN/BtgUEG5+E23OZzxocQ7PnTPbe8CrjobsJ5+W87oBxxn5Ikv9+WCePSE1yx3SJNd2Yb93Ndhi67cqpC9tq6ac57PvzehBmDchKyI0ySxbJT1Xprdv4foxKKMCRmK4A48n0LfKaphb2+KItloMg6u52BRbIcdS53SZ+KD/+5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3291.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(55016003)(186003)(9686003)(316002)(86362001)(478600001)(122000001)(54906003)(38100700002)(76116006)(71200400001)(66946007)(66556008)(66476007)(66446008)(33656002)(64756008)(7696005)(6916009)(4326008)(82960400001)(6506007)(53546011)(41300700001)(26005)(107886003)(52536014)(8676002)(5660300002)(8936002)(2906002)(38070700005)(7416002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b88DEIsSuFKJWOCH/kh+FT/4lXkCemk6/yQwkb00KmE1Au2pizEOugHye/Nj?=
 =?us-ascii?Q?9nDApMiINLQ5esZLR9du6u1b+XNNi5mYaIeJ0k0CMtKkNmlSG1gdWf1DkuEh?=
 =?us-ascii?Q?ehxF41onbe2JQAdqIKalmTxZ34BU+Fnav2J++5uSQaeZaxL67KgTeCYWQcFq?=
 =?us-ascii?Q?c538zcneSYUJmxw0Mx2Mk+JooVa5eJgKI+cxSfrrVqv8OR84eR3AmhD2sS2d?=
 =?us-ascii?Q?zwhAeD0zofLeteZxJ+l+YBhtgQWLyFioe5mgkC7EhMUv7G6C3TWkAa6xRAVm?=
 =?us-ascii?Q?/ZkQaL7G1GfN0rmdYkWa+0ceuJySvPepcpCKQog7Tp9jaf5APmbr7PVWuNOc?=
 =?us-ascii?Q?bv6uVMuKw5u42GO9TThlqtLhitWLFX/kodXgu3gPAKAXVXHcYmEu2Y86U9Z/?=
 =?us-ascii?Q?JTVe43P0vsgYvjO2Gl6aPVHww0VxQHit66ovjceQXbEBgMGnxPuSXCh47kRB?=
 =?us-ascii?Q?hWrigI0o7CUXzifGzEXw7f7g5Mkim73sW5k+X5431DuZCvYYYYVJZP2z3vD8?=
 =?us-ascii?Q?7ZPFs06ecB2qhLqQSrV6KhWu7zPZ91vVUdS8De/n/KqlJOY71Z3mAX9ZIHet?=
 =?us-ascii?Q?PBKH6MsoyMBwR6zQ7014mdk5TLK6wz1aQ8B3bhxpKOpz9DrLBl5pFcaZOuAa?=
 =?us-ascii?Q?3cp41Zlg2sK+NVp1SvykIuf0SC6WFprHEwZv0j0ynCoifue4MVTZ9M2Tzu55?=
 =?us-ascii?Q?5dV4hjpSSB/t6LHexJ9823sA8kHmB3dM0/Cb/shqcaWh3nSq9yJyCRwr9NfE?=
 =?us-ascii?Q?9LzlVNjuZGSXJPGfhhI61/jE8l6JvwpOtbtiakF4RbWRMoNjPRBo9bIr4WJp?=
 =?us-ascii?Q?x2df3wFYqB7LqHefV5EcSP1PJFlaItSBq8x0ZT2I/fymJeYVpb7hIZd29Ehd?=
 =?us-ascii?Q?sizLBTP3FWbMnDBxLSHf/VHMvVhsGx6/UChNi79zlH4ltO1foCzzSsavsCs9?=
 =?us-ascii?Q?E4+ZH3IGAybbr1Xnm/04nAqrfVMtyDLKMQCvpWM4eeWdhhI8pdwE2Wb8L0UU?=
 =?us-ascii?Q?vYBMdfRSLXJG/Ni/Wyx1KNBUHg7f8hMtfw2ZmaXAkXKzuAcRKNklVL69r3tv?=
 =?us-ascii?Q?lnv1z2ByEWIyAJzeJVX5dsufzrOWEibW7wXNpMQjXh+MVjyQJQfsur4y/aMB?=
 =?us-ascii?Q?7qm6WrBVeixH/tuzi1ts6QamJGiYoLE0+EgspTyES7WnoSadv3yq5EZ7xHHV?=
 =?us-ascii?Q?+2MyFMD3sKCYEs+AVoTGoqcxDZsBGIXlg7Z8MrIVYP7ttzeClJa3WrD7a1Fd?=
 =?us-ascii?Q?atDpr0POs/apqofgKzXN35idVNqsAwWQN3BBpaeFzc8ACiZi+++YArZhXP2Y?=
 =?us-ascii?Q?IAH5RLFC5dfANVUIwb/klvr145cVTC58Z6TFDW3208m4m3KoqU0F5JYntB6N?=
 =?us-ascii?Q?BkLEbGmt5rIu84whGnfFBc5j3rATehsG46+5Tf4HlAr1mYD8tvpziuTApKoN?=
 =?us-ascii?Q?k81GplTVKm586RXdvNuz+JXdYsjt3g2lyRausqd2X8WbCl9e+TVCxDXLm+AX?=
 =?us-ascii?Q?8H7vwqx/xB4sLztFEieDpkrCDgXYKMvn1XcZB2DJSJsNtXIQ+19VG1m1a8yR?=
 =?us-ascii?Q?NQyIU//oLjWp+N99n4Gnh3xTk7TRtaz38GqWB3zkVwDJqZGJCmGUraP5/WpL?=
 =?us-ascii?Q?Xw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3291.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cac37c6-ec53-4025-fbcf-08db93281ee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 07:14:32.9188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I275LfQg9TzGwxSwaVwkGJkdkQP01dDYyKSYMe8XsS8NxlfCCLLkgg8FD1OKpGmB5nFERvl8F7XOTNL3Zj2rb5egoJELRTB6GZ2J/7pC7Vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7691
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Conor Dooley <conor.dooley@microchip.com>
> Sent: Wednesday, 2 August, 2023 3:02 PM
> To: Rabara, Niravkumar L <niravkumar.l.rabara@intel.com>
> Cc: Ng, Adrian Ho Yin <adrian.ho.yin.ng@intel.com>; andrew@lunn.ch;
> conor+dt@kernel.org; devicetree@vger.kernel.org; dinguyen@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; linux-clk@vger.kernel.org; linux-
> kernel@vger.kernel.org; Turquette, Mike <mturquette@baylibre.com>;
> netdev@vger.kernel.org; p.zabel@pengutronix.de;
> richardcochran@gmail.com; robh+dt@kernel.org; sboyd@kernel.org;
> wen.ping.teh@intel.com
> Subject: Re: [PATCH v3 3/5] dt-bindings: clock: add Intel Agilex5 clock
> manager
>=20
> On Wed, Aug 02, 2023 at 10:58:42AM +0800, niravkumar.l.rabara@intel.com
> wrote:
> > From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> >
> > Add clock ID definitions for Intel Agilex5 SoCFPGA.
> > The registers in Agilex5 handling the clock is named as clock manager.
> >
> > Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
> > Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
>=20
> Damn, I was too late - you already sent a v3 :/
>=20
> However, there only seems to be a v3 of this one patch and it was sent in
> reply to the v2 series? The normal thing to do is resend the entire serie=
s, not
> just one patch, as a new thread. Not using a new thread may make it harde=
r
> to apply & will also bury the email in people's mailboxes that use things=
 like
> mutt. A single patch as a reply is also confusing, as the rest of the v3 =
looks like
> it is missing!
>=20
> Thanks,
> Conor.

Sorry I made a mistake.=20
Should I send out entire series with PATCH v3 subject? Or should I wait for=
 review comment on remaining patches and then send entire series with rewor=
k and  subject prefix PATCH v3?=20

Thanks,
Nirav

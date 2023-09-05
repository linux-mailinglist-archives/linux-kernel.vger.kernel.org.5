Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5317932AE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 01:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238805AbjIEXrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 19:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjIEXrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 19:47:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED3E1B4;
        Tue,  5 Sep 2023 16:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693957648; x=1725493648;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hUd8sNGF/C/RPQnApA8yYCgFpYEMb3ZN33wk2AGU2QM=;
  b=MwVUwjk77Lr49JmgkX7YPCey6JGdOx0Lp08f9jV4pyng3VtFEybvQiO2
   hEwVWS6xp9KgQ6oDCKbv3vA7J7UozS9+4l/nTx6Dhkpx8yi6dzhputwCY
   FyXQDexiFtxxR4NqmhfPRzr2igqq7jBLHjP3bYJFcvGU3/LOVvopRk+KU
   j76e0ZN9/oTvVl0L2APHt1SPVvh7np2uVozCh4Lt1bFl7YB845W6Lmhay
   8Qi9N7cgEgAmKYkEqLjsV7rNrv7g3SHLYMbnQNs8AvY9hHYTRhxUbc6iM
   OX7LBfunGXlBbyynffwelHTA24O+Wr8zpQKIPGd/E0M60ALYQ40QrUvxY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="375828384"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="375828384"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 16:47:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="734836053"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="734836053"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 16:47:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 16:47:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 16:47:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 16:47:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSOtfqiL/XbSUYbXE0BT4WwJigK8NT1ghd/CgJsQhLmUj8e2di34gkgh7IgPH2mQlFuWKEdSA8rrM6ZjEWOEmSf8qXMXxs+GeXyBmHklYYj3NajGRtgMP2P6EXBgFmWvOeamSjUiuJ5hts9GLGTJAiTkiLNgmIzVpTwRfouLWkSBBIO/59LqCWva5L3N2ooVkW7OG2g8GPoMMjv9f0EGnBVdAKs6bmc61HQfUG/7vN2WEjkpFiBlVixSjahjadb1bvuppptovsFkWIMaVHbLbbruNgMABJjjiUffHjnJQvw8XrAx6+P8rcQujVGvFvijPsZp4iMYIDkmS4J2lClUmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUFU2hGu7Rxf+sE9mpIEFzlzAcZKuCLZyc3UIfCOyXw=;
 b=k1Ns1/KYpMmaNufLyt/ofhM0dFz9w5OzTcCTqmJapluNTh2dOZFpzQpg1t846iGVxDE25bHo8ULyl3yIUTxe8Kp17UQrjr5C1Rcb7xPq8hL3y1PyBBLSjF5TVz1POrlRLazebIgKRx/NgS2MmDVY38jDlLavJOB71SYyTwpFkbmhbk+LVszDGQGn1cHTFVGY5I5rtYaXx7hYKxAxP1lQuMSH8xalEaK5fpxsZnxG7tPz9wJtjkL5dKVw1jDWh4WvOFOnT9LNyVk+YPCfaFCyyrtJwsySFTCB9nANaq2dz1eUQCJPPKguB2bNQ0eeebJ5dA+XZhU7gldIjfKOxWdS9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by DM4PR11MB6043.namprd11.prod.outlook.com (2603:10b6:8:62::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.33; Tue, 5 Sep 2023 23:47:24 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::da4:d67d:40ed:9786]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::da4:d67d:40ed:9786%4]) with mapi id 15.20.6699.035; Tue, 5 Sep 2023
 23:47:24 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "pmalani@chromium.org" <pmalani@chromium.org>,
        "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: RE: [PATCH v2 3/5] usb: pd: Add helper macro to get Type C cable
 speed
Thread-Topic: [PATCH v2 3/5] usb: pd: Add helper macro to get Type C cable
 speed
Thread-Index: AQHZ25LkcToieundFEaWWNQn/m56F7AKRhsAgAAA4gCAAqhFAA==
Date:   Tue, 5 Sep 2023 23:47:24 +0000
Message-ID: <MWHPR11MB0048D7DE0329B6EDD2222E80A9E8A@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20230830223950.1360865-1-utkarsh.h.patel@intel.com>
 <20230830223950.1360865-4-utkarsh.h.patel@intel.com>
 <ZPWCdiSkeRA+CJ+i@kuha.fi.intel.com> <ZPWDNLoxq22bL9gM@kuha.fi.intel.com>
In-Reply-To: <ZPWDNLoxq22bL9gM@kuha.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0048:EE_|DM4PR11MB6043:EE_
x-ms-office365-filtering-correlation-id: 0441810c-f1aa-4091-2f19-08dbae6a7450
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: exGuEBtug4hwghtmc/cBx9dKrwvtCTjE9hJHN1Q+AFCIOaA1RyAhpybKssNYQ9OArTQ8iWrOXavlsNxgyMesI5TPMEgnNhy8txxfMj9A30MtcpZCAi591VT3rBGU8nt/Ldf+45dPWwXRqtAy6hOg05rtpKbjkp+jwCHNZhgfbUd7ezZ6lYPQWWzL3oE9wqcOkwzUzRLHQHQ4D2PxZIk+uMqCsHFnq5q0MSj24k9Ej7WeNtQosYjzVB8AVH6i3SBPQJ93O2jloblx3LstYMr4hhmd5RFo0wIoTxwMkDJMuKSDa7oJOLkiHnGwVtOSvRnAvnnfCTVz1OHORG7OxJewuliY/+x8AVZEPYWHilPyifgllslALoyL5arCS5sB1CFYYeDESje91wGRbefnbB8MSd75hkiPIparNIM5Vw0WjESDNgoweuR4m2Z+PNkxHP4TdlnevroYI7fbZzKEZSzQjNy4JKLzmZP8BFQd0yFVKN5rQHwhHMblxzj9pEa/YS5s5TSHMamtUPKtURcSsboYnQX7Lp8FXHTe/wXkAG3HkuEN9LsBcdUrYfH4Oq2wp0/rkTDY75ew5WxtKHjT6194kpj9A27fLj5Nhhj6KI0xemu6m8ph0GxE41cfXkKlvT4e
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(186009)(451199024)(1800799009)(76116006)(53546011)(71200400001)(66556008)(54906003)(64756008)(66946007)(66446008)(6916009)(66476007)(55016003)(7696005)(6506007)(316002)(9686003)(41300700001)(478600001)(4326008)(8676002)(52536014)(26005)(5660300002)(33656002)(122000001)(82960400001)(38070700005)(38100700002)(2906002)(8936002)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+kGXHx3cwJEtkwzfqTrUvRjvTJwXArjUW1fl2msJKv35zUQAQmvg4VNdcKng?=
 =?us-ascii?Q?vfZOXwnH1M1dAIbMK0l9YdFZOZsxCzYYOhFk9pKxUcnN/Kavy0F375SeFvcO?=
 =?us-ascii?Q?w0k+uK2Muxc/OU3c7wezACckstR9L2aIAkRF0kRTexVhUvI7y5yU28JYvIRM?=
 =?us-ascii?Q?HSMhpOfonOn6LKI34Mmvydadp67JzpwwmjweVYekZ66cbXBtFBif08x4Dzz2?=
 =?us-ascii?Q?sy9u1vm3SSl7QJHnFVXJgDDFDcuSHKlX6NS1Gr7vpK3EaM1wJVA8dAUnU4aj?=
 =?us-ascii?Q?WdsNqo6gUoHSYrMWrw646BLlQGuDapd3FLgzlnYWqOvWtbj4Eb9iTLoEwNzH?=
 =?us-ascii?Q?xM6LWmh69bwk+wXb+6y0vs/aK6Figr3t+MOzs+A5qT+O4aJXe70JUs3IhaKF?=
 =?us-ascii?Q?DeUaQhT1OAe6BIcqH2Fhb8yKuHzZvVmMdutewOVAYl5G8snSzBa9LFCdLnmM?=
 =?us-ascii?Q?+JCEfSsk2rTm6XGPJ4uka7pYa5ldGLW++zZrcm3ziFpRHfgt+szvJ0OEacXq?=
 =?us-ascii?Q?51MAg5WQAXPMlPiAtf1AHpyiC9YzcJz6EZUWYUFtTD3YxZHvfs0NSPLxPNel?=
 =?us-ascii?Q?DSqO4ZPcZA1a7Ba1rUMbs+4zxzuAwzTJwFkrPMpa78yeZUNXkrWnlbxeaxrj?=
 =?us-ascii?Q?S0VwVBddkv9wWlmmFLxpGMRLdUbkU82DkZnIvIZgG+vivXQM9+Bzp4ceFu5R?=
 =?us-ascii?Q?hXCuTcjiPT7TMezA/ojiqRmc14OhvjF4lY9ISF9bBMLVgs9N8+LJwCKjWC73?=
 =?us-ascii?Q?XdckUKxC5E1CUmrJ8xwLSmtcgbJcaXeYy0hiWJLrj2jBjBH6/qwV7o0GHXp4?=
 =?us-ascii?Q?CstRanyxMyaNuZtzUj7a9MUzH9UOeQgk2oJCw8crAOTC3vYLGNUdPocfxz3r?=
 =?us-ascii?Q?Sj6kb8qqRLZPtfVa7sVljD+fGWRGhaSbqsiucRKe6rss9exNN/Vg83B2baKC?=
 =?us-ascii?Q?ZoCbkVtUDKvTw8nJ+2c/gfNI8qDVKzs4OZdrEqpqth6TX9hkfy6aie5usH6w?=
 =?us-ascii?Q?rO4ldv7MXiq2I+ilsXHNItn4vNhJUq7MTfW1cZbTuleGXicSvT0zCjQJa7r6?=
 =?us-ascii?Q?lIaRkA7MP8FL61n49VH0iQzBp99fDozkQMqkveRDBZeQWH7LoeVb65sqtZ+Z?=
 =?us-ascii?Q?kbQMR1IDh3j1/jtiD75UqFec+zY6kutbJsfty0rv2dVs7VfP5+pFuDG8OQql?=
 =?us-ascii?Q?NXYt0kI1ulajE+d5eWgZvA9z5krvcClh9ywuWiH07VcBSaEBkHZE6YXXU5Cc?=
 =?us-ascii?Q?0cz83tdphomkjZNKRkLfLlry5aoqaGoGnKj4fMVQDsWQX539fNKOAnH4Zcvi?=
 =?us-ascii?Q?gfrIjscnO384umCrOQok2U864ssNX1umzTepsXkA1v7sLF1QZrbpmx7G4fLx?=
 =?us-ascii?Q?dr8z9t1z/iSGjycREozKPlaPCamWKiGHZp/8C3BrU8x66NgvL9vN2T9hxliY?=
 =?us-ascii?Q?GET7khz7+8DTk3BFiDVB7llTdqRPK/Pr2u1eYxxyBvFYECYYS0enShZVnF7/?=
 =?us-ascii?Q?65RbexwIM02Igm5bqBJue52ortft3iFyzqZj1ttWkz9qsatepPObTF2ycUhb?=
 =?us-ascii?Q?HQlVXQeXVwRhmHtB8l59KN2HGyjoe/mex5uX0Kq2s05DPZ4NWCwqNKP8MAoR?=
 =?us-ascii?Q?MQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0441810c-f1aa-4091-2f19-08dbae6a7450
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2023 23:47:24.4136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wkQ6JdxubAOBbcbH7ZUvCXvfk7JPHBy+tR83/OmB500bFnrRbRR3IMtnhl36kxYwNJ5JdaHM/9/r0Yp86P9O0s2on3GJFSGJbIYnD2fK1nQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6043
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

Thank you for the review.

> -----Original Message-----
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Sent: Monday, September 4, 2023 12:12 AM
> To: Patel, Utkarsh H <utkarsh.h.patel@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> pmalani@chromium.org; chrome-platform@lists.linux.dev;
> andriy.shevchenko@linux.intel.com; bleung@chromium.org
> Subject: Re: [PATCH v2 3/5] usb: pd: Add helper macro to get Type C cable
> speed
>=20
> On Mon, Sep 04, 2023 at 10:08:42AM +0300, Heikki Krogerus wrote:
> > On Wed, Aug 30, 2023 at 03:39:48PM -0700, Utkarsh Patel wrote:
> > > Added a helper macro to get the Type C cable speed when provided the
> > > cable VDO.
> > >
> > > Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> >
> > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >
> > > ---
> > > Changes in v2:
> > > - This change is being added as new patch in this series.
> > >
> > >  include/linux/usb/pd_vdo.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/include/linux/usb/pd_vdo.h b/include/linux/usb/pd_vdo.h
> > > index b057250704e8..3a747938cdab 100644
> > > --- a/include/linux/usb/pd_vdo.h
> > > +++ b/include/linux/usb/pd_vdo.h
> > > @@ -376,6 +376,7 @@
> > >  	 | ((vbm) & 0x3) << 9 | (sbu) << 8 | (sbut) << 7 | ((cur) & 0x3) <<=
 5
> 	\
> > >  	 | (vbt) << 4 | (sopp) << 3 | ((spd) & 0x7))
> > >
> > > +#define VDO_TYPEC_CABLE_SPEED(vdo)	((vdo) & 0x7)
> > >  #define VDO_TYPEC_CABLE_TYPE(vdo)	(((vdo) >> 18) & 0x3)
>=20
> Hold on! You are not using this anywhere in the patch set?
>=20
> Since this is just a helper, I think it would be appropriate to introduce=
 it
> together with a user for it.
>=20

Ack.=20

Sincerely,
Utkarsh Patel.

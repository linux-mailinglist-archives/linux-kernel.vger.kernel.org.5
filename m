Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871D17F4099
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjKVIxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjKVIxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:53:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E38A198;
        Wed, 22 Nov 2023 00:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700643207; x=1732179207;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yh2FjMoSEfmJLFtprwtSG3OzMSN6M6SLV+hDBhNHCgw=;
  b=Vyosg+aniBwE7klE/ranKVJ8np1zOwRWg2mqlRThU5sHirFVKSYNjlrc
   XjmvdfsLF3q7lVk6syW7MrVOYOX6OQaNrAy6Vb3ka/ZCL4fK8OdDsiKN3
   rP3oXod3RyVeBG4fMbTzdQV193LOi8GhDpiquQMmCpkrdzsVHO/qr7SAQ
   OQnLRe17eR3315M4H3EojjaSFc7fRZaapum5SE4wIAtrjYwxlRRmTWnIc
   PmM0SatQJlo5dp2YLRJyuGgmjnpAH1CCUYFz/XoHuYJvttSKW9u/08Xdw
   MLroZd0g9ut5FU1NCXe1gQ0AKtw6xdioqI4yeyAW7/jMoVta/w604XzmG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="5152869"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="5152869"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 00:53:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="884500556"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="884500556"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 00:53:22 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 00:53:21 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 00:53:21 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 00:53:21 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 00:53:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVLCMbPDl6/f12u5Ghe0EKVyvDU4oRI7mfmDQMkOaexdN61pwElowp1rF7swMQSs3d47Sg+Wfxwl5W0NW8qE8NHPfFh3N9YBySUua0+UFuinFoLOH0ml0q08mFuNwdYYwrr7WGfD7xwxagHi3iW1iE7H7cv/GpzqyAXlZMGNdl+FOnxFrPDjWXIQKf1fSD7m6yweyOouyl/Cy4VW57eX37XG1xBS1+5v927zilpdgqCfPKRKCPmYaMT/l/a3YGGVPGLJvAScWLqKdQ2KgrGGBooX8u1ERJ7ihf9zfeMShZgLd+SOaMUGH4q/UK3L8VCvTYjlsQ0PNSkgdQQP5imSFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98aukNnzFzUDFT3n9Tw/b+JeqR2LIWtJdrAkjKlz+MU=;
 b=PqBg0HxCtIwddpCSWnadllq5WwbBFgV89YqHl00/ktqXCWyt6moOAIdCljQtrIWbXvGmHe+N0MD9/tcapQazc9xbVp6p4Z6LLTpoTX5rCoyAa5y7TXGk/XsKDDVaLwPdfnXHI1SJGyl0weUP7mGQTeL2VMfoHR0s5F+rGEXLZC9ZBH7ZQn2hEvL2TwGKCaaIcgsOHGhDKkmxJ75rRBkqXcYACqzE/fvlQRLcSCdm/SGsedbbXhBH+ckzJ5RWipCCbiNsNkbPvLAGDqtgLLAxqPKlCoXZmP1XQaSRhkoFqVciLhyk3KS9n4Iz+jkCm6/pbosVRcvpQYpKa9TmEAkVkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by DM4PR11MB6359.namprd11.prod.outlook.com (2603:10b6:8:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Wed, 22 Nov
 2023 08:53:11 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::aa4a:f2aa:f6cf:367b]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::aa4a:f2aa:f6cf:367b%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 08:53:11 +0000
From:   "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "jstultz@google.com" <jstultz@google.com>,
        "giometti@enneenne.com" <giometti@enneenne.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Dong, Eddie" <eddie.dong@intel.com>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>,
        "N, Pandith" <pandith.n@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>,
        Peter Hilber <peter.hilber@opensynergy.com>
Subject: RE: [PATCH v1 4/6] pps: generators: Add PPS Generator TIO Driver
Thread-Topic: [PATCH v1 4/6] pps: generators: Add PPS Generator TIO Driver
Thread-Index: AQHaALpZxHZAaaClkkqnOx5cHxnWO7BOLEYAgDgPjSA=
Date:   Wed, 22 Nov 2023 08:53:11 +0000
Message-ID: <CY8PR11MB73645B10AB9002593D74B48BC4BAA@CY8PR11MB7364.namprd11.prod.outlook.com>
References: <20231017052457.25287-5-lakshmi.sowjanya.d@intel.com>
 <87lec15i4b.ffs@tglx>
In-Reply-To: <87lec15i4b.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7364:EE_|DM4PR11MB6359:EE_
x-ms-office365-filtering-correlation-id: 90eff395-1132-4670-7aca-08dbeb3874dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JrrlkDPZH2wbCZNxR2rg+PvsHsRAq/Red3QQJCUfzQjMvuLF0NUrojDARtsnvKktaQDzWgN89r2E6SkbuG/U6gW98e/eEcxzMksGq6KzRLv6oZIcX9tAJNTDFu3jUbQ0eCvGhG6vVXy7vG4EMW1gGh4OMsk8ACQCq4rGM9u65z/OyAONU4pL5EQT/2Q/d586gMNVePv26yiroNwXxNOplJ3KLwjZllR4Nz53fl0eWVwFx17LHPwPt8xg8+2XG3utuMACOJCbsz3ZZtRWE/qshTcTu+/G0pjM+K3hyZLUtNOrhGqX2NsSrHtBE2jlTV3R6jJadApVtcjCbx9VJ7agLz1nLA53IIt/KfMmS8AQ01pOkzZm4ZTY9FQ/Y4VdVjJY+3SE0q1cwDwyMG0X3NX7ps89c5KM9Vqg/2965pFQVgpbvbzhxMQscTDkygEu90YWfG3+og3p51IxargV3YirQdBc+GIEXMU4mu67jj2uu7TkhSWXoL57ZMkNi8FR2o79WAg8nqS5zO98QGKWntRGJ12EzXR3j+kF5xcMScbDBv/3YjBH0X39mWYyRv+VEMpUF5Xtz0C+RUy2Sh4ZdVbwZ66tjbPvGbzS2hO3yVHY6Y4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(38100700002)(41300700001)(86362001)(5660300002)(33656002)(30864003)(2906002)(52536014)(38070700009)(9686003)(6506007)(478600001)(82960400001)(7696005)(71200400001)(83380400001)(53546011)(55016003)(26005)(66556008)(66946007)(110136005)(66446008)(64756008)(54906003)(122000001)(316002)(66476007)(966005)(76116006)(8936002)(8676002)(4326008)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ROKRwkgHoqhX/c4naeY+j48BMUKNi0sjBWnxGH6yHz+Up8ejyf9LZvbFeFav?=
 =?us-ascii?Q?Lh746ikviXZu5nal3uydIrwshm1VQgTdb8D/YIkQ7xZlkzCKVHd8WBtQC+1m?=
 =?us-ascii?Q?IH6tTaBI0Ibqe+V55+OpSJG5pRaFrPk/Ss+eRgE6gHJdiJV1hI05Tkyees6h?=
 =?us-ascii?Q?z1ok5Jkz5n/HefOZlqh2pXeEIdFAaZ77OaGNs8bNAU5AMcrGkHZAWpx11RY3?=
 =?us-ascii?Q?J2qF1RZQLJonWC77jbs935Tnbm5rNsPHSQ/siYojxaQu40W6o2SXCzOLb4Ub?=
 =?us-ascii?Q?b/KWEmdcK9soOHiLac6Jzs57a7Qi+mNKcGuy0EGq2Q/1bMsowpiEM6KjTrny?=
 =?us-ascii?Q?0iiyGMBvdwefjoXsBk8UrX1EcqmdAPTRZ1sOOBaoh8TZHFnxev4kUa4y22F7?=
 =?us-ascii?Q?+yRsQROOf/MMTfLSnno/jjaPqPNOfKTPJ9/3xDVccccCbny1eDZucBCDMamA?=
 =?us-ascii?Q?d/mz5fqnerV5OL5WYKyYJV+vjP9PO5AVlOcN6wFG49QS/tI9tTw4BOmlOfrk?=
 =?us-ascii?Q?Tw5y76GYXZ/id13FlmbCOUnsGQBCfbre39OhY33XW9hRr4Gktu+NDBlzOE+L?=
 =?us-ascii?Q?SYcecSp+TemQvM1AYEsfd7ZAwn3dcNGqCqoKf20jz/TW60fcgScfP8Udlejx?=
 =?us-ascii?Q?aBjA5TtYqoVsPhPiQKAP1is3l6To698i2R2VIHPaQpPLtqkkmExKplxYEiQx?=
 =?us-ascii?Q?kCePWeNwVIcunmAZ8a53eC0MNQE+RaBvuBm+avhldOMilescdBT5m6wCtUcR?=
 =?us-ascii?Q?VXRTnNe+i8+KrFC96clL0aqGRaJnW0bXoLe/0p7FtouVzMB7Lm7Yes/xKE83?=
 =?us-ascii?Q?n60Mip9ecsqAKvqe85hH5/MnLMbalurU1aUbh2KpQLibxTLU8uXEKX6t0ba+?=
 =?us-ascii?Q?q9bYKrLWn5oPtoQPCnH6HG/Th+ccuOdjiuhz565xFju8HKWU0kqoKlLKseyC?=
 =?us-ascii?Q?ulWlTv9v5T4Cn/g99ca6dolj4Y0GwvmI7zz/Ap8RVVuxXWfg1pjvmW9o7yfn?=
 =?us-ascii?Q?aVcye1SrebNDW2OSwdfX7tyizwRtbV4ZrL3AIPGS4UMLc/s0Qus4Rl6lQAda?=
 =?us-ascii?Q?pHnDNI4VfJaSedd5b5n8l4/bCY4Moj3NRO7TLfWAZQdxBGDhb6jVQZsB6NNv?=
 =?us-ascii?Q?KZolXQJNy7tK2RPivgVP43HAJZDDBkLYuktyajYgHJjbJMBu5cYzdEdy5VMl?=
 =?us-ascii?Q?RS7CG44cOWfaD0Xw7jdHuCgzIPgKJtl7Ojeb9JbnQo1IaRjPbtX74cD3V7oO?=
 =?us-ascii?Q?IOel0cl//01rlu2EISVX4bUOryaTekDWblcn0YBL3Ke/V26tDJbiZdKMSAo/?=
 =?us-ascii?Q?0q/tuR1lpOf3E517sP+rJIDWBp9HpC2LnaR7skBs8wFUjoez13PI7KML0duw?=
 =?us-ascii?Q?ricR9hkTyeXhlmadJEF/uc4WTo/7uQL6+ZbluvR04gmp+zOXmKMnWO6oekKP?=
 =?us-ascii?Q?JV2sCcLIcRhD/4jK4nmf0vDssw07kdVLljjsgdssQSzrgjvMYMT8R8SxyCrg?=
 =?us-ascii?Q?NSlZW/EdIvD9NTTdF2Me1neLjNY8sqfHhz6PBAhRcYmuomMeB5AgOxfnOcse?=
 =?us-ascii?Q?lf7pkNNieGPf5auSgA5wpydDqDMk9s7mq/y2mIcYCDpKcDFfgRQe+yTe8vFx?=
 =?us-ascii?Q?Mw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7364.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90eff395-1132-4670-7aca-08dbeb3874dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 08:53:11.4324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MCmVmY2xsNApOrXMg2Wo8PmTWxJj2PYSvHGQyQElAQ4/K8Y3tgTisHJBbETVc5CEDJZAWMJG6R+nCruID7NW0JPA6ndgEYCQiZgIDHn3+gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6359
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Tuesday, October 17, 2023 9:58 PM
> To: D, Lakshmi Sowjanya <lakshmi.sowjanya.d@intel.com>;
> jstultz@google.com; giometti@enneenne.com; corbet@lwn.net; linux-
> kernel@vger.kernel.org
> Cc: x86@kernel.org; linux-doc@vger.kernel.org;
> andriy.shevchenko@linux.intel.com; Dong, Eddie <eddie.dong@intel.com>; Ha=
ll,
> Christopher S <christopher.s.hall@intel.com>; N, Pandith
> <pandith.n@intel.com>; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>; T R, Thejesh Reddy
> <thejesh.reddy.t.r@intel.com>; D, Lakshmi Sowjanya
> <lakshmi.sowjanya.d@intel.com>; Peter Hilber
> <peter.hilber@opensynergy.com>
> Subject: Re: [PATCH v1 4/6] pps: generators: Add PPS Generator TIO Driver
>=20
> On Tue, Oct 17 2023 at 10:54, lakshmi.sowjanya.d@intel.com wrote:
> > +
> > +static inline ktime_t first_event(struct pps_tio *tio) {
> > +	struct timespec64 ts;
> > +
> > +	ktime_get_real_ts64(&ts);
> > +
> > +	return ktime_set(ts.tv_sec + 1, NSEC_PER_SEC - PREP_INTERVAL_NS);
>=20
>         return ktime_set(ktime_get_real_seconds() + 1, MAGIC_CONSTANT);
>=20
> Perhaps?
>=20
> PREP_INTERVAL_NS is a misnomer as it has nothing to do with an interval. =
It's
> the time substracted from the actual pulse target time to allow the hrtim=
er
> callback to setup the hardware for the pulse.
>=20
> Naming matters really.

#define SAFE_TIME_NS  (10*NSEC_PER_MSEC) #define FIRST_EVENT_NS  (NSEC_PER_=
SEC -  SAFE_TIME_NS )

return ktime_set(ktime_get_real_seconds() + 1, FIRST_EVENT_NS);

>=20
> > +static int translate_system_time_to_art_cycles(struct timespec64 ts, u=
64
> *art_timestamp,
> > +					       bool *real_to_tsc_result) {
> > +	struct system_counterval_t sys_counter;
> > +	ktime_t sys_realtime;
> > +	int err;
> > +
> > +	sys_realtime =3D timespec64_to_ktime(ts);
>=20
> Why are you handing timespecs around? Because timespec math is so awesome=
,
> right?
>=20
> > +	err =3D ktime_convert_real_to_system_counter(sys_realtime,
> &sys_counter);
> > +	if (err) {
> > +		*real_to_tsc_result =3D true;
>=20
> This makes my bad taste sensors reach saturation.
>=20
> > +		return err;
> > +	}
> > +
> > +	return convert_tsc_to_art(&sys_counter, art_timestamp); }
>=20
> > +static int pps_tio_generate_output(struct pps_tio *tio, struct
> > +timespec64 time) {
> > +	bool real_to_tsc_result;
> > +	u64 art_timestamp;
> > +	int err;
> > +
> > +	real_to_tsc_result =3D false;
> > +	err =3D translate_system_time_to_art_cycles(time, &art_timestamp,
> &real_to_tsc_result);
> > +	if (err) {
> > +		pps_tio_disable(tio);
> > +		dev_err(tio->dev, "Disabling PPS due to failure in conversion of
> %s",
> > +			real_to_tsc_result ? "realtime to system_counter" : "tsc
> to art");
> > +		return err;
>=20
> Clearly nothing in the call chain cares about the actual error code, righ=
t? So
> instead of having all these undocumented -E* all over the place, just mak=
e the
> inner functions bool and then only for
> translate_system_time_to_art_cycles() use
>=20
> enum {
> 	SUCCESS,
>         FAIL_SC,
>         FAIL_ART,
> };
>=20
> or something like that to make this error printout happy.
>=20
> pps_tio_generate_output() itself can return bool too.
>=20
> > +	}
> > +	/* The timed IO hardware adds a two cycle delay on output */
> > +	art_timestamp -=3D 2;
> > +	pps_compv_write(tio, art_timestamp);
> > +
> > +	return 0;
> > +}
> > +
> > +static int schedule_event(struct hrtimer *timer, struct timespec64
> > +*next_event) {
> > +	struct pps_tio *tio =3D container_of(timer, struct pps_tio, timer);
> > +	struct timespec64 expire_time, cur_time, roundoff;
> > +	long half_sec_ns =3D NSEC_PER_SEC / 2;
> > +
> > +	/* get the current time */
> > +	ktime_get_real_ts64(&cur_time);
> > +	expire_time =3D ktime_to_timespec64(hrtimer_get_softexpires(timer));
> > +
> > +	/*
> > +	 * Figure out if it is in "top half" or "bottom half" of the second
> > +	 * and round-off to the nearest 500ms
> > +	 */
> > +	if (cur_time.tv_nsec > half_sec_ns) {
> > +		roundoff.tv_sec =3D cur_time.tv_sec + 1;
> > +		roundoff.tv_nsec =3D 0;
> > +		next_event->tv_sec =3D roundoff.tv_sec;
> > +		next_event->tv_nsec =3D half_sec_ns;
> > +	} else {
> > +		roundoff.tv_sec =3D cur_time.tv_sec;
> > +		roundoff.tv_nsec =3D half_sec_ns;
> > +		next_event->tv_sec =3D roundoff.tv_sec;
> > +		next_event->tv_nsec =3D roundoff.tv_nsec + half_sec_ns;
> > +	}
> > +	next_event->tv_nsec -=3D PREP_INTERVAL_NS;
> > +	/* Check for elapsed time */
> > +	if (expire_time.tv_sec !=3D cur_time.tv_sec ||
> > +	    (cur_time.tv_nsec - PREP_INTERVAL_NS) > expire_time.tv_nsec) {
>=20
> The timer is considered on time when cur_time <=3D T_pulse?
>=20
> How do you ensure that there is enough time to actually convert and arm t=
he
> timer? Not at all. If cur_time is close to T_pulse then you end up arming=
 it late.

We have a 10 msec of SAFE_TIME away from T_Pulse here.

>=20
> > +		dev_warn(tio->dev, "Time expired, edge not scheduled at time:
> %lld.%09ld\n",
> > +			 cur_time.tv_sec, cur_time.tv_nsec);
> > +		return 0;
> > +	}
> > +
> > +	return pps_tio_generate_output(tio, roundoff); }
> > +
> > +static enum hrtimer_restart hrtimer_callback(struct hrtimer *timer) {
> > +	struct pps_tio *tio =3D container_of(timer, struct pps_tio, timer);
> > +	struct timespec64 next_event;
> > +	int err =3D 0;
> > +
> > +	scoped_guard(spinlock_irqsave, &tio->lock) {
> > +		if (tio->enabled)
> > +			err =3D schedule_event(timer, &next_event);
> > +	}
> > +	if (err)
> > +		return HRTIMER_NORESTART;
> > +
> > +	hrtimer_set_expires(timer, ktime_set(next_event.tv_sec,
> next_event.tv_nsec));
> > +	return HRTIMER_RESTART;
>=20
> All of this is overengineered complexity. Initially you start the hrtimer=
 with
>=20
> 	hrtimer_start(&tio->timer, first_event(tio), HRTIMER_MODE_ABS);
>=20
> and that sets the first event to expire TPREP_NS before the full second. =
After
> that you want to schedule the timer periodically every 0.5s, right?
>=20
> hrtimers provide periodic schedule already. So all of the gunk above can =
be
> replaced with:
>=20
> static enum hrtimer_restart hrtimer_callback(struct hrtimer *timer) {
> 	struct pps_tio *tio =3D container_of(timer, struct pps_tio, timer);
>         ktime_t expires, now;
>=20
>         guard(spinlock)(&tio->lock);
>=20
> 	expires =3D hrtimer_get_expires(timer);
> 	now =3D ktime_get_real();
>=20
> 	if (now - expires < TOO_LATE) {
>         	if (!pps_arm_next_pulse(tio, expires + TPREP_NS))
>                 	return HRTIMER_NORESTART;
> 	}
>=20
> 	hrtimer_forward(timer, now, NSEC_PER_SEC / 2);
>        	return HRTIMER_RESTART;
> }
>=20
> and
>=20
> static bool pps_arm_next_pulse(struct pps_tio *tio, ktime_t expires) {
> 	u64 art;
>=20
> 	if (!ktime_real_to_base_clock(expires, CSID_X86_ART, &art))
>         	return false;
>=20
> 	pps_compv_write(tio, art - ART_HW_DELAY_CYCLES);
>         return true;
> }
>=20
> ktime_real_to_base_clock() does not exist, but that's the function you re=
ally
> want to have.
>=20
> Not this convoluted construct of indirections and therefore we need to re=
think
> the whole related clock mechanism from ground up.
>=20
> As I said vs. patch 3/6 already this smells badly of the wrong abstractio=
ns and
> data representations. So this needs to be fixed first instead of adding s=
everal
> layers of duct tape.
>=20
> > +static ssize_t enable_store(struct device *dev, struct device_attribut=
e *attr,
> const char *buf,
> > +			    size_t count)
> > +{
> > +	struct pps_tio *tio =3D dev_get_drvdata(dev);
> > +	bool enable;
> > +	int err;
> > +
> > +	err =3D kstrtobool(buf, &enable);
> > +	if (err)
> > +		return err;
> > +
> > +	guard(spinlock_irqsave)(&tio->lock);
> > +	if (enable && !tio->enabled) {
> > +		if (!is_current_clocksource_art_related()) {
> > +			dev_err(tio->dev, "PPS cannot be started as clock is not
> related to ART");
> > +			return -EPERM;
> > +		}
>=20
> Ah. Here is the usecase for this magic patch 3/6 hackery. Again, it's the=
 wrong
> abstraction. You want something like:
>=20
>     timekeeping_clocksource_has_base(CSID_X86_ART);
>=20
> or something like this, which can be handled completely in the core code.
>=20
> All of this needs some serious rework. See the below disfunctional mockup=
 patch
> for illustration.
>=20
> There is also a patch series, which tried to replace the clocksource poin=
ter in
> system_counterval_t with a clocksource ID:
>=20
>   https://lore.kernel.org/all/20230818011256.211078-1-
> peter.hilber@opensynergy.com
>=20
> That went nowhere, but has some valid points. I took some of Peter's (cc'=
ed)
> ideas into the mockup, but did it slightly different to make all of this =
indirection
> mess go away.
>=20
> There are certainly bugs and thinkos in that mockup. If you find them, yo=
u can
> keep and fix them :)
>=20

Thanks for the mock-up patch !
We are planning to include ktime_real_to_base_clock() in the next version o=
f this patch series.

The fixes done in the mock-up patch are shared below

> Thanks,
>=20
>         tglx
> ---
>  arch/x86/include/asm/tsc.h                        |    3
>  arch/x86/kernel/kvmclock.c                        |    1
>  arch/x86/kernel/tsc.c                             |   78 ++-------------=
-
>  drivers/clocksource/arm_arch_timer.c              |    7 -
>  drivers/net/ethernet/intel/e1000e/ptp.c           |    3
>  drivers/net/ethernet/intel/ice/ice_ptp.c          |    4
>  drivers/net/ethernet/intel/igc/igc_ptp.c          |    8 +
>  drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c |    3
>  drivers/ptp/ptp_kvm_common.c                      |    9 -
>  drivers/ptp/ptp_kvm_x86.c                         |    5 -
>  include/linux/clocksource.h                       |   24 +++++
>  include/linux/clocksource_ids.h                   |    3
>  include/linux/ptp_kvm.h                           |    3
>  include/linux/timekeeping.h                       |    8 +
>  kernel/time/timekeeping.c                         |  103 +++++++++++++++=
+++++--
>  sound/pci/hda/hda_controller.c                    |    3
>  16 files changed, 169 insertions(+), 96 deletions(-)
>=20
> --- a/arch/x86/include/asm/tsc.h
> +++ b/arch/x86/include/asm/tsc.h
> @@ -27,9 +27,6 @@ static inline cycles_t get_cycles(void)  }  #define get=
_cycles
> get_cycles
>=20
> -extern struct system_counterval_t convert_art_to_tsc(u64 art); -extern s=
truct
> system_counterval_t convert_art_ns_to_tsc(u64 art_ns);
> -
>  extern void tsc_early_init(void);
>  extern void tsc_init(void);
>  extern void mark_tsc_unstable(char *reason);
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -157,6 +157,7 @@ static int kvm_cs_enable(struct clocksou  struct
> clocksource kvm_clock =3D {
>  	.name	=3D "kvm-clock",
>  	.read	=3D kvm_clock_get_cycles,
> +	.cs_id	=3D CSID_X86_KVM_CLK,
>  	.rating	=3D 400,
>  	.mask	=3D CLOCKSOURCE_MASK(64),
>  	.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS,
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -50,9 +50,13 @@ int tsc_clocksource_reliable;
>=20
>  static int __read_mostly tsc_force_recalibrate;
>=20
> +static struct clocksource_base art_base_clk =3D {
> +	.id	=3D CSID_X86_ART,
> +};
> +
>  static u32 art_to_tsc_numerator;
>  static u32 art_to_tsc_denominator;
> -static u64 art_to_tsc_offset;
> +static u64 art_base_clk.offset;
>  static struct clocksource *art_related_clocksource;
>=20
>  struct cyc2ns {
> @@ -1089,13 +1093,13 @@ static void __init detect_art(void)
>  	    tsc_async_resets)
>  		return;
>=20
> -	cpuid(ART_CPUID_LEAF, &art_to_tsc_denominator,
> -	      &art_to_tsc_numerator, unused, unused+1);
> +	cpuid(ART_CPUID_LEAF, &art_base_clk.denominator,
> +	      &art_base_clk.numerator, &art_base_clk.freq_khz, unused+1);
>=20
=20
+    base->freq_khz /=3D KHZ;

> -	if (art_to_tsc_denominator < ART_MIN_DENOMINATOR)
> +	if (art_base_clk.denominator < ART_MIN_DENOMINATOR)
>  		return;
>=20
> -	rdmsrl(MSR_IA32_TSC_ADJUST, art_to_tsc_offset);
> +	rdmsrl(MSR_IA32_TSC_ADJUST, art_base_clk.offset);
>=20
>  	/* Make this sticky over multiple CPU init calls */
>  	setup_force_cpu_cap(X86_FEATURE_ART);
> @@ -1190,6 +1194,7 @@ static struct clocksource clocksource_ts
>  				  CLOCK_SOURCE_VALID_FOR_HRES |
>  				  CLOCK_SOURCE_MUST_VERIFY |
>  				  CLOCK_SOURCE_VERIFY_PERCPU,
> +	.id			=3D CSID_X86_TSC,
>  	.vdso_clock_mode	=3D VDSO_CLOCKMODE_TSC,
>  	.enable			=3D tsc_cs_enable,
>  	.resume			=3D tsc_resume,
> @@ -1294,65 +1299,6 @@ int unsynchronized_tsc(void)
>  	return 0;
>  }
>=20
> -/*
> - * Convert ART to TSC given numerator/denominator found in detect_art()
> - */
> -struct system_counterval_t convert_art_to_tsc(u64 art) -{
> -	u64 tmp, res, rem;
> -
> -	rem =3D do_div(art, art_to_tsc_denominator);
> -
> -	res =3D art * art_to_tsc_numerator;
> -	tmp =3D rem * art_to_tsc_numerator;
> -
> -	do_div(tmp, art_to_tsc_denominator);
> -	res +=3D tmp + art_to_tsc_offset;
> -
> -	return (struct system_counterval_t) {.cs =3D art_related_clocksource,
> -			.cycles =3D res};
> -}
> -EXPORT_SYMBOL(convert_art_to_tsc);
> -
> -/**
> - * convert_art_ns_to_tsc() - Convert ART in nanoseconds to TSC.
> - * @art_ns: ART (Always Running Timer) in unit of nanoseconds
> - *
> - * PTM requires all timestamps to be in units of nanoseconds. When user
> - * software requests a cross-timestamp, this function converts system
> timestamp
> - * to TSC.
> - *
> - * This is valid when CPU feature flag X86_FEATURE_TSC_KNOWN_FREQ is set
> - * indicating the tsc_khz is derived from CPUID[15H]. Drivers should che=
ck
> - * that this flag is set before conversion to TSC is attempted.
> - *
> - * Return:
> - * struct system_counterval_t - system counter value with the pointer to=
 the
> - *	corresponding clocksource
> - *	@cycles:	System counter value
> - *	@cs:		Clocksource corresponding to system counter value.
> Used
> - *			by timekeeping code to verify comparability of two
> cycle
> - *			values.
> - */
> -
> -struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns) -{
> -	u64 tmp, res, rem;
> -
> -	rem =3D do_div(art_ns, USEC_PER_SEC);
> -
> -	res =3D art_ns * tsc_khz;
> -	tmp =3D rem * tsc_khz;
> -
> -	do_div(tmp, USEC_PER_SEC);
> -	res +=3D tmp;
> -
> -	return (struct system_counterval_t) { .cs =3D art_related_clocksource,
> -					      .cycles =3D res};
> -}
> -EXPORT_SYMBOL(convert_art_ns_to_tsc);
> -
> -
>  static void tsc_refine_calibration_work(struct work_struct *work);  stat=
ic
> DECLARE_DELAYED_WORK(tsc_irqwork, tsc_refine_calibration_work);
>  /**
> @@ -1454,8 +1400,10 @@ static void tsc_refine_calibration_work(
>  	if (tsc_unstable)
>  		goto unreg;
>=20
> -	if (boot_cpu_has(X86_FEATURE_ART))
> +	if (boot_cpu_has(X86_FEATURE_ART)) {
>  		art_related_clocksource =3D &clocksource_tsc;
> +		clocksource_tsc.base_clk =3D &art_base_clk;
> +	}
>  	clocksource_register_khz(&clocksource_tsc, tsc_khz);
>  unreg:
>  	clocksource_unregister(&clocksource_tsc_early);
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -1784,8 +1784,7 @@ static int __init arch_timer_acpi_init(s
> TIMER_ACPI_DECLARE(arch_timer, ACPI_SIG_GTDT, arch_timer_acpi_init);
> #endif
>=20
> -int kvm_arch_ptp_get_crosststamp(u64 *cycle, struct timespec64 *ts,
> -				 struct clocksource **cs)
> +int kvm_arch_ptp_get_crosststamp(u64 *cycle, struct timespec64 *ts, int
> +cs_id)
>  {
>  	struct arm_smccc_res hvc_res;
>  	u32 ptp_counter;
> @@ -1809,8 +1808,8 @@ int kvm_arch_ptp_get_crosststamp(u64 *cy
>  	*ts =3D ktime_to_timespec64(ktime);
>  	if (cycle)
>  		*cycle =3D (u64)hvc_res.a2 << 32 | hvc_res.a3;
> -	if (cs)
> -		*cs =3D &clocksource_counter;
> +	if (cs_id)
> +		*cs_id =3D clocksource_counter.id;
>=20
>  	return 0;
>  }
> --- a/drivers/net/ethernet/intel/e1000e/ptp.c
> +++ b/drivers/net/ethernet/intel/e1000e/ptp.c
> @@ -124,7 +124,8 @@ static int e1000e_phc_get_syncdevicetime
>  	sys_cycles =3D er32(PLTSTMPH);
>  	sys_cycles <<=3D 32;
>  	sys_cycles |=3D er32(PLTSTMPL);
> -	*system =3D convert_art_to_tsc(sys_cycles);
> +	system->cycles =3D sys_cycles;
> +	system->cs_id =3D CSID_X86_ART;
>=20
>  	return 0;
>  }
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -1989,6 +1989,8 @@ ice_ptp_get_syncdevicetime(ktime_t *devi
>  	wr32(hw, GLHH_ART_CTL, hh_art_ctl);
>=20
>  #define MAX_HH_LOCK_TRIES 100
> +	system->cs_id =3D CSID_X86_ART;
> +	system->nsecs =3D true;
>=20
>  	for (i =3D 0; i < MAX_HH_LOCK_TRIES; i++) {
>  		/* Wait for sync to complete */
> @@ -2005,7 +2007,7 @@ ice_ptp_get_syncdevicetime(ktime_t *devi
>  			hh_ts_lo =3D rd32(hw, GLHH_ART_TIME_L);
>  			hh_ts_hi =3D rd32(hw, GLHH_ART_TIME_H);
>  			hh_ts =3D ((u64)hh_ts_hi << 32) | hh_ts_lo;
> -			*system =3D convert_art_ns_to_tsc(hh_ts);
> +			system->cycles =3D hh_ts;
>  			/* Read Device source clock time */
>  			hh_ts_lo =3D rd32(hw, GLTSYN_HHTIME_L(tmr_idx));
>  			hh_ts_hi =3D rd32(hw, GLTSYN_HHTIME_H(tmr_idx));
> --- a/drivers/net/ethernet/intel/igc/igc_ptp.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
> @@ -911,7 +911,13 @@ static bool igc_is_crosststamp_supported  static str=
uct
> system_counterval_t igc_device_tstamp_to_system(u64 tstamp)  {  #if
> IS_ENABLED(CONFIG_X86_TSC) && !defined(CONFIG_UML)
> -	return convert_art_ns_to_tsc(tstamp);
> +	// FIXME: How has this ensured that ART exists?
> +	return (struct system_counterval_t) {
> +		.cs_id	=3D CSID_X86_ART,
> +		.cycles	=3D tstamp,
> +		.nsecs	=3D true,
> +	};
> +
>  #else
>  	return (struct system_counterval_t) { };  #endif
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> @@ -390,10 +390,11 @@ static int intel_crosststamp(ktime_t *de
>  		*device =3D ns_to_ktime(ptp_time);
>  		read_unlock_irqrestore(&priv->ptp_lock, flags);
>  		get_arttime(priv->mii, intel_priv->mdio_adhoc_addr,
> &art_time);
> -		*system =3D convert_art_to_tsc(art_time);
> +		system->cycles =3D art_time;
>  	}
>=20
>  	system->cycles *=3D intel_priv->crossts_adj;
> +	system->cs_id =3D CSID_X86_ART;
>  	priv->plat->flags &=3D ~STMMAC_FLAG_INT_SNAPSHOT_EN;
>=20
>  	return 0;
> --- a/drivers/ptp/ptp_kvm_common.c
> +++ b/drivers/ptp/ptp_kvm_common.c
> @@ -28,15 +28,14 @@ static int ptp_kvm_get_time_fn(ktime_t *
>  			       struct system_counterval_t *system_counter,
>  			       void *ctx)
>  {
> -	long ret;
> -	u64 cycle;
>  	struct timespec64 tspec;
> -	struct clocksource *cs;
> +	int ret, cs_id;
> +	u64 cycle;
>=20
>  	spin_lock(&kvm_ptp_lock);
>=20
>  	preempt_disable_notrace();
> -	ret =3D kvm_arch_ptp_get_crosststamp(&cycle, &tspec, &cs);
> +	ret =3D kvm_arch_ptp_get_crosststamp(&cycle, &tspec, &cs_id);
>  	if (ret) {
>  		spin_unlock(&kvm_ptp_lock);
>  		preempt_enable_notrace();
> @@ -46,7 +45,7 @@ static int ptp_kvm_get_time_fn(ktime_t *
>  	preempt_enable_notrace();
>=20
>  	system_counter->cycles =3D cycle;
> -	system_counter->cs =3D cs;
> +	system_counter->cs_id =3D cs_id;
>=20
>  	*device_time =3D timespec64_to_ktime(tspec);
>=20
> --- a/drivers/ptp/ptp_kvm_x86.c
> +++ b/drivers/ptp/ptp_kvm_x86.c
> @@ -92,8 +92,7 @@ int kvm_arch_ptp_get_clock(struct timesp
>  	return 0;
>  }
>=20
> -int kvm_arch_ptp_get_crosststamp(u64 *cycle, struct timespec64 *tspec,
> -			      struct clocksource **cs)
> +int kvm_arch_ptp_get_crosststamp(u64 *cycle, struct timespec64 *tspec,
> +int *cs_id)
>  {
>  	struct pvclock_vcpu_time_info *src;
>  	unsigned int version;
> @@ -123,7 +122,7 @@ int kvm_arch_ptp_get_crosststamp(u64 *cy
>  		*cycle =3D __pvclock_read_cycles(src, clock_pair->tsc);
>  	} while (pvclock_read_retry(src, version));
>=20
> -	*cs =3D &kvm_clock;
> +	*cs_id =3D kvm_clock.id;
>=20
>  	return 0;
>  }
> --- a/include/linux/clocksource.h
> +++ b/include/linux/clocksource.h
> @@ -21,6 +21,7 @@
>  #include <asm/div64.h>
>  #include <asm/io.h>
>=20
> +struct clocksource_base;
>  struct clocksource;
>  struct module;
>=20
> @@ -70,6 +71,7 @@ struct module;
>   *			validate the clocksource from which the snapshot was
>   *			taken.
>   * @flags:		Flags describing special properties
> + * @base_clk:		Optional pointer to an underlying base clock

+  *freq_khz:		Clock source frequency in KHz=09

>   * @enable:		Optional function to enable the clocksource
>   * @disable:		Optional function to disable the clocksource
>   * @suspend:		Optional suspend function for the clocksource
> @@ -111,6 +113,7 @@ struct clocksource {
>  	enum clocksource_ids	id;
>  	enum vdso_clock_mode	vdso_clock_mode;
>  	unsigned long		flags;
> +	struct clocksource_base	*base_clk;

+  u32     freq_khz;

>=20
>  	int			(*enable)(struct clocksource *cs);
>  	void			(*disable)(struct clocksource *cs);
> @@ -294,4 +297,25 @@ static inline void timer_probe(void) {}  extern ulon=
g
> max_cswd_read_retries;  void clocksource_verify_percpu(struct clocksource
> *cs);
>=20
> +/**
> + * struct clocksource_base - hardware abstraction for clock on which a
> clocksource is based
> + * @id:			Defaults to CSID_GENERIC. The id value is used
> for conversion
> + *			functions which require that the current clocksource is
> based
> + *			on a clocksource_base with a particular ID
> + *			in certain snapshot functions to allow callers to
> + *			validate the clocksource from which the snapshot was
> + *			taken.
> + * @freq_khz:		Nominal frequency of the base clock in kHz
> + * @offset:		Offset between the base clock and the clocksource
> + * @numerator:		Numerator of the clock ratio between base
> clock and the clocksource
> + * @denominator:	Denominator of the clock ratio between base clock and
> the clocksource
> + */
> +struct clocksource_base {
> +	enum clocksource_ids	id;
> +	u32			freq_khz;
> +	u64			offset;
> +	u32			numerator;
> +	u32			denominator;
> +};
> +
>  #endif /* _LINUX_CLOCKSOURCE_H */
> --- a/include/linux/clocksource_ids.h
> +++ b/include/linux/clocksource_ids.h
> @@ -6,6 +6,9 @@
>  enum clocksource_ids {
>  	CSID_GENERIC		=3D 0,
>  	CSID_ARM_ARCH_COUNTER,
> +	CSID_X86_TSC,
> +	CSID_X86_TSC_ART,
> +	CSID_X86_KVM_CLK,
>  	CSID_MAX,
>  };
>=20
> --- a/include/linux/ptp_kvm.h
> +++ b/include/linux/ptp_kvm.h
> @@ -16,7 +16,6 @@ struct clocksource;
>  int kvm_arch_ptp_init(void);
>  void kvm_arch_ptp_exit(void);
>  int kvm_arch_ptp_get_clock(struct timespec64 *ts); -int
> kvm_arch_ptp_get_crosststamp(u64 *cycle,
> -		struct timespec64 *tspec, struct clocksource **cs);
> +int kvm_arch_ptp_get_crosststamp(u64 *cycle, struct timespec64 *tspec,
> +int csid);
>=20
>  #endif /* _PTP_KVM_H_ */
> --- a/include/linux/timekeeping.h
> +++ b/include/linux/timekeeping.h
> @@ -270,12 +270,14 @@ struct system_device_crosststamp {
>   * struct system_counterval_t - system counter value with the pointer to=
 the
>   *				corresponding clocksource
>   * @cycles:	System counter value
> - * @cs:		Clocksource corresponding to system counter value.
> Used by
> - *		timekeeping code to verify comparibility of two cycle values
> + * @cs_id:	Clocksource ID. Either the ID of the current clocksource
> + *		or the ID of a clocksource base.
> + * @nsecs:	@cycles is in nanoseconds
>   */
>  struct system_counterval_t {
>  	u64			cycles;
> -	struct clocksource	*cs;
> +	enum clocksource_ids	cs_id;
> +	bool			nsecs;
>  };
>=20
>  /*
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1191,6 +1191,78 @@ static bool cycle_between(u64 before, u6
>  	return false;
>  }
>=20
> +static u64 convert_clock(u64 val, u32 numerator, u32 denominator) {
> +	u64 rem, res;
> +
> +	res =3D div_u64_rem(val, denominator, &rem) * numerator;
> +	return res + div_u64(rem * numerator, denominator); }

static bool convert_clock(u64 *val, u32 numerator, u32 denominator) {
    u64 res,rem;

        if (numerator =3D=3D 0 || denominator =3D=3D 0)
           return false;

    res =3D div64_u64_rem(*val, denominator, &rem) * numerator;
    *val =3D res + div_u64(rem * numerator, denominator);
   return true;
}

> +
> +static bool convert_base_to_cs(struct system_counterval_t *scv) {
> +	struct clocksource *cs =3D tk_core.timekeeper.tkr_mono.clock;
> +	struct clocksource_base *csb =3D clock->base;
> +
> +	/* The timestamp was taken from the time keeper clock source */
> +	if (cs->id =3D=3D scv->cs_id)
> +		return true;
> +
> +	/* Check whether cs_id matches the base clock */
> +	if (!base || base->id !=3D scv->cs_id)
> +		return false;
> +
> +	if (scv->nsecs)
> +		scv->cycles =3D convert_clock(scv->cycles, base->freq_khz,
> +USEC_PER_SEC);
> +
> +	scv->cycles =3D convert_clock(scv->cycles, base->numerator, base-
> >denominator);

/* Avoid conversion to a less precise clock */
if (scv->nsecs && && cs->freq_khz !=3D 0 && base->freq_khz < cs->freq_khz) =
{
           if (!convert_clock(&(scv->cycles), cs->freq_khz, USEC_PER_SEC))
	    return false;
    } else {
           if (scv->nsecs)
                   if (!convert_clock(&(scv->cycles), base->freq_khz, USEC_=
PER_SEC))
                           return false;
           if (!convert_clock(&(scv->cycles), base->numerator, base->denomi=
nator))
                   return false;
    }

> +	scv->cycles +=3D base->offset;
> +	return true;
> +}
> +
> +static bool convert_cs_to_base(u64 *cycles, enum clocksource_ids
> +base_id) {
> +	struct clocksource *cs =3D tk_core.timekeeper.tkr_mono.clock;
> +	struct clocksource_base *csb =3D clock->base;
> +
> +	/* Check whether base_id matches the base clock */
> +	if (!base || base->id !=3D base_id)
> +		return false;
> +
> +	*cycles =3D convert_clock(cycles - base->offset, base->denominator,
> base->numerator);
> +	return true;
> +}
> +
> +static u64 convert_ns_to_cs(u64 delta)
> +{
> +	struct tk_read *tkr =3D &tk_core.timekeeper.tkr_mono;
> +
> +	return div_u64(delta << tkr->shift, tkr->mult); }

return div_u64( (delta << tkr->shift) - tkr->xtime_nsec, tkr->mult);

> +
> +bool ktime_real_to_base_clock(ktime_t treal, enum clocksource_ids
> +base_id, u64 *cycles) {
> +	struct timekeeper *tk =3D &tk_core.timekeeper;
> +	struct clocksource_base *csb;
> +	unsigned int seq;
> +	u64 delta;
> +
> +	do {
> +		seq =3D read_seqcount_begin(&tk_core.seq);
> +
> +		delta =3D (u64)treal - tk->tkr_mono.base_real;
> +		if (delta > tk->tkr_mono.clock->max_idle_ns)
> +			return false;
> +
> +		*cycles =3D tk->tkr_mono.cycle_last + convert_ns_to_cs(delta);
> +		if (!convert_cs_to_base(cycles, base_id))
> +			return false;
> +
> +	} while (read_seqcount_retry(&tk_core.seq, seq));
> +
> +	return true;
> +}
> +
>  /**
>   * get_device_system_crosststamp - Synchronously capture system/device
> timestamp
>   * @get_time_fn:	Callback to get simultaneous device time and
> @@ -1231,13 +1303,9 @@ int get_device_system_crosststamp(int (*
>  		if (ret)
>  			return ret;
>=20
> -		/*
> -		 * Verify that the clocksource associated with the captured
> -		 * system counter value is the same as the currently installed
> -		 * timekeeper clocksource
> -		 */
> -		if (tk->tkr_mono.clock !=3D system_counterval.cs)
> +		if (!convert_base_to_cs(&system_counterval))
>  			return -ENODEV;
> +
>  		cycles =3D system_counterval.cycles;
>=20
>  		/*
> @@ -1304,6 +1372,29 @@ int get_device_system_crosststamp(int (*
> EXPORT_SYMBOL_GPL(get_device_system_crosststamp);
>=20
>  /**
> + * timekeeping_clocksource_has_base - Check whether the current clocksou=
rce
> has a base clock
> + * @id:	The clocksource ID to check for
> + *
> + * Note: The return value is a snapshot which can become invalid right
> + *	 after the function returns.
> + *
> + * Returns: True if the timekeeper clocksource has a base clock with
> +@id, false otherwise  */ bool timekeeping_clocksource_has_base(enum
> +clocksource_ids id) {
> +	unsigned int seq;
> +	bool ret;
> +
> +	do {
> +		seq =3D read_seqcount_begin(&tk_core.seq);
> +		ret =3D tk_core.timekeeper.tkr_mono.clock->base ?
> +			tk_core.timekeeper.tkr_mono.clock->base.id =3D=3D id :
> false;
> +	} (read_seqcount_retry(&tk_core.seq, seq));
> +
> +	return ret;
> +}
> +
> +/**
>   * do_settimeofday64 - Sets the time of day.
>   * @ts:     pointer to the timespec64 variable containing the new time
>   *
> --- a/sound/pci/hda/hda_controller.c
> +++ b/sound/pci/hda/hda_controller.c
> @@ -457,7 +457,8 @@ static int azx_get_sync_time(ktime_t *de
>  	*device =3D ktime_add_ns(*device, (wallclk_cycles * NSEC_PER_SEC) /
>  			       ((HDA_MAX_CYCLE_VALUE + 1) * runtime->rate));
>=20
> -	*system =3D convert_art_to_tsc(tsc_counter);
> +	system->cycles =3D tsc_counter;
> +	system->cs_id =3D CSID_X86_ART;
>=20
>  	return 0;
>  }

Regards
Lakshmi Sowjanya D



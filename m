Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905AF782F4B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbjHURSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 13:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbjHURSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:18:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0720EE;
        Mon, 21 Aug 2023 10:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692638293; x=1724174293;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DJYsBxdVO/b3PezeLUFz/x4LkyWrvLiSlVA3e5lHUtg=;
  b=hW52DlJ/mpFMkYiQOjCAyFQfWbZdnMr4oOdZI/Vlq0A1d6LBheU/Hl45
   JMwUrmDp0y70W4KABE82jW6dc24d/amDH+M3e24LIV+hozTyiAoAGGUbX
   kUKWylX1fvYhGDxDFITQBOavmYFfpX1+6ponstWr0JRqMx5HFD1wy0GXA
   Ne7foeDldnHy7rix3dOOCp39do1pilLMx6gGiYeH3/RWD4Nd1deDDaTRM
   WX/Yn1T8KYpT72WugFgLsYFmAmzWCgyvC34Z024pt11aDHRxWOqiVVLY5
   rLP2HAJEX7MmuI54tVL0kBUjnPDkKZw6b44gk/QIpW3QGgjJFCiB5LMfz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="377397368"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="377397368"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 10:18:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="685728545"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="685728545"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 21 Aug 2023 10:18:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 21 Aug 2023 10:18:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 21 Aug 2023 10:18:11 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 21 Aug 2023 10:18:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BH9VOYzVU5Zp2xqfBfZc1v5f5B7gOP4NB37gUOF+4fAkBN7AWAibq9euLXW1x9lMq8wuvxrAlYb4h0hsZn6Wzu5KQPVN0wfi/BtgbHPDMus6b2uoH+Crqw7yIWwYuntSGuZ6TTJJgGgROJ7zwmaD1GOPEQaKrmzp9j7PAsVtEOZNUL15ttcTuYsCPJ+7GmVyPVPdHFyDeOVRs6vpIUIRyAT6PUEmE0WnqFgapZY3+CDKtEdpnilhD4viOTPY4Jr2Cx9FaDaQG7GPiEFvKGRsGl5nWDVW1G35FD0C90AN55MTxOP2FITHHRxfZNIlF3aIFnJCstl7Ly6yDLcA6HtN9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpjIwJ76ReaGGKa+mvy5s0KIP13ydbbJSL8Uhdaq+oU=;
 b=ZCzWUCl0YQ+q8J3UVWGmhPgGJOVUDGJDv+fLbmnyOesFeJ/bj02DuS1gTvj322K6cYDqfxu92Y8maF8y+3950Tuljae7DUEU8i8gsDDRLpxw8URzhAIu3r2WWlMpD2tKTbYH70k/EC5z4T10fhu2H73E3M1qJ64qpZWtxesHLgeRJ2RxNghFVmJBCIyYKZaShIbFmu71hHFHBvvRhAZVH3FxtXDtvJgZt6qj6WQd8oRB+fJgx48G40z16hIHZMv2H4soNbg+rx4v2sBQKqk9wZL1Mfn+2pHdELUc0IkBp4yNpdMdrVMeKhaBDYmTVKLvZm7Fws4bEC0A/GSzaU9NQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by DS0PR11MB7334.namprd11.prod.outlook.com (2603:10b6:8:11d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 17:18:01 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::da4:d67d:40ed:9786]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::da4:d67d:40ed:9786%4]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 17:18:01 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Prashant Malani <pmalani@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: RE: [PATCH v4 1/2] platform/chrome: cros_ec_typec: Configure Retimer
 cable type
Thread-Topic: [PATCH v4 1/2] platform/chrome: cros_ec_typec: Configure Retimer
 cable type
Thread-Index: AQHZuR/m4IKFgl1ovU6TI3vwoe4fN6/weR2AgAS6PdA=
Date:   Mon, 21 Aug 2023 17:18:01 +0000
Message-ID: <MWHPR11MB0048DAF02954ACC66C026533A91EA@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20230718024703.1013367-1-utkarsh.h.patel@intel.com>
 <20230718024703.1013367-2-utkarsh.h.patel@intel.com>
 <ZN+j/z97Yy0wv/if@chromium.org>
In-Reply-To: <ZN+j/z97Yy0wv/if@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0048:EE_|DS0PR11MB7334:EE_
x-ms-office365-filtering-correlation-id: 11386785-e0ba-4034-030d-08dba26a92a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: StizaFtxryajOZw3DbfOsQDnZvVCCrM74Lh2pL1xww5oVGi9zCB52c2xHIfN3QogEysktG/G7xnxZYzBaUr+UgqLhOHiEAqxZELVxZH1cgKsFnLQNI7DfQ2KWyv/3EAo0GzKWCHFynprB2I/CIZvq9WLH77VooRJujlpB08vHNMZ3gu9SnoIN6ZVajPQVPPUZgqyRRYflxko2Vteg5zABEdWDpui/Ui5aXUfEo3vmsxumCMUdMazkz0CgbNyqHk8DtwzOBmq0hTu3go/fZwuvWF3qGNAdo9xuTv/wXsPcpIy3DnX50xj9byn7TLR3Y+FSbRXZv4V1iXVG26eBJrx/Vc57aUtG0V5bQ6Zn1bBWbQgzH+f5FzRqLeKFQIZJks/gQRh8H6c7h3yET3b5nMTLMHbZovcltDqHlbqR7l8PEAsnGAdJUkFk1J4J4vOBn1XI85Cu2fV0pT9fVK0DRNGovOI4b2cPgQK7rUGWoBn3G9X4fOW12YjUShtjRRfLmo6l+LTkvkYjf02q/VNpGIGj9hx9dSI3cycBdgxQXJHvzqCDsvZL9dHutcMeu8uenEBYuNMqK4kiNzIt/oJ/Rm8EX5a/C+/0nsbjFjvSrZ/k0uKmzy52LTcviTMj79jA/5d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199024)(1800799009)(186009)(2906002)(83380400001)(53546011)(38100700002)(6506007)(5660300002)(52536014)(33656002)(26005)(38070700005)(86362001)(7696005)(8676002)(8936002)(4326008)(66946007)(316002)(9686003)(6916009)(54906003)(66446008)(66556008)(76116006)(64756008)(66476007)(82960400001)(478600001)(122000001)(71200400001)(55016003)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xgY+NyodpgcT32852n9VF0EjGBZUOukq9+9X/pcEyRavZoC6jRF9RXUq6x4R?=
 =?us-ascii?Q?n5fJvA3AjOe21inToRIYBF73oDu5MGeBNQlIqNKi3hbSq25nMw/t0JHrVpjq?=
 =?us-ascii?Q?jmq69WJeq1DV61brBqaUbxo0BZ097YiCdOG7HSucw5VaKQoYA8ezlnuKo238?=
 =?us-ascii?Q?CE+gkGXKFUPtbHXZKgqQviPyMQYsKT4oDzNtHd8QXUquAM/BgOi3Be01+ef6?=
 =?us-ascii?Q?Xnm67g6gYbQxurlI4EGVPOEeddIwFx361FkDMxqHXQqG3gjhvKAO9//TGxdU?=
 =?us-ascii?Q?lHvqXRV/sSfXz6V+TL7srGshMDDu0apkDan+VS0thaABh8fv+0EB75ptimua?=
 =?us-ascii?Q?XNy++hQAy/SF+MGqExeJeXotfDGoPzVJsuty9yvjLrQCg1xfYqmLYTxGy+Ai?=
 =?us-ascii?Q?K4feQidYxs0sm+qUVZOPtyvtKcm+vVxN4JU5kPwjXcoZqjZMpiH1DEpNlVpN?=
 =?us-ascii?Q?So9zz6HD9+TFT6SUmvpXyZxrlMlwphc6Z+2vdHzWCzwVyPgn1Choo+vCFQb9?=
 =?us-ascii?Q?BPIGS11tghCsr2KgLlP3wujegNaxD4H60WcuEWaKu6wAyxAk2yzAjjzjLyM6?=
 =?us-ascii?Q?mUdiJNXXSbllirSLa9rG8QnuvkJMMD/0C8Vjkk0d73tnMAxIqJGveAyYb57m?=
 =?us-ascii?Q?NSKigTucXkHj1pJs7+tOXq8PR9/ZmQOTvJJxr4tdY1MX2XQbOruFiWGAaXuP?=
 =?us-ascii?Q?S1u4rjGsCoraWMaWyWQLrTEM2eoOQF3AW8Jx3Q2iep+fZNML0i2C068yo+yj?=
 =?us-ascii?Q?qSSTRxO8LQ+b3BIW5JGyXX1t+o1ZOyTdRq8Rgs5sBawGdtL0kghVyKqUnGI8?=
 =?us-ascii?Q?F/JtV6K0aYXEEo/125UZ8hyp137AXoNXaiwRr7wgcN8KbWna6kKc1WakooKU?=
 =?us-ascii?Q?62zNt/mBQg6lI/PLryrGjdyPNHnlXU1mXY+vDDgxC3w+GfAIg6uniEO+60hg?=
 =?us-ascii?Q?7PwQVRPI+kS/1Ej1JpFk6DxW+rvo3SaMa218QLM/7790BVhR8W0e8UvP69vp?=
 =?us-ascii?Q?FCBlsICMCeiNUWtfFAVGohr/XFgTv/L+obeg1WBuDHDniG6KGVitAjUxnBw2?=
 =?us-ascii?Q?PjVyjcj50LGfFZfFVMtrlV4f+BsfhDHXvbUG6RFOJ0W+9rk/d/sPJXidbljA?=
 =?us-ascii?Q?j3A2O+EdSNTaByA1++vb1xCYIHlfic0HJ+zPmD8HvigpDm8MVqCNxcAqOwuv?=
 =?us-ascii?Q?tdJbNwbgeZ1usm2zDSEJfswP+pwvvMRWy08RzNjJDHuB1r+CuZMpc5o8HiFj?=
 =?us-ascii?Q?8avsAUB79XNvlwydqQXI6bpKfDbsp3/4tmOsEdgSNO5ER+4SC+JmLPdPjFtJ?=
 =?us-ascii?Q?gt51Tt3R1Y4z6etIXuF25JP8ptmE9sflX8CHKJOWZtLkXsU/pmC8isH5qRiq?=
 =?us-ascii?Q?n20Cpk1A5FDb0VLwvXShLzwkKS1irxS1zyLGbiGhqIaHMfzCjQrErk0NX8vQ?=
 =?us-ascii?Q?Jb1EbM/0brN+P3tyyJ0nT5WWw81Ue82hxheXfu04meRtqhtkd9SkT+eIxYDp?=
 =?us-ascii?Q?1embwUJ3K+Qy8TgUqJDNE3pk5wvKTFS2RN9tCgu5FwkNKBtkP873m+tYyhcJ?=
 =?us-ascii?Q?yci3sQJXKLxl0xFHiAwjMREfpVkZ58F4oX8v4CZL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11386785-e0ba-4034-030d-08dba26a92a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 17:18:01.3217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wgzgJ/1HoudEOINra+lTeZJUHKmwxtyHrvrEFr3vdx8rQ/W/roB4Yh1ZfJQWXG679ujcmKqC6OXwZ9Sl8nRdaDAFw4WR2mR+WgCRBaFwRBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7334
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

Hi Prashant,

Thank you for the review.=20

> -----Original Message-----
> From: Prashant Malani <pmalani@chromium.org>
> Sent: Friday, August 18, 2023 10:02 AM
> To: Patel, Utkarsh H <utkarsh.h.patel@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> heikki.krogerus@linux.intel.com; bleung@chromium.org
> Subject: Re: [PATCH v4 1/2] platform/chrome: cros_ec_typec: Configure
> Retimer cable type
>=20
> >  /*
> >   * Spoof the VDOs that were likely communicated by the partner for TBT=
 alt
> >   * mode.
> > @@ -432,6 +453,9 @@ static int cros_typec_enable_tbt(struct
> > cros_typec_data *typec,
> >
> >  	/* Cable Discover Mode VDO */
> >  	data.cable_mode =3D TBT_MODE;
> > +
> > +	data.cable_mode |=3D cros_typec_get_cable_vdo(port,
> > +USB_TYPEC_TBT_SID);
> > +
> >  	data.cable_mode |=3D TBT_SET_CABLE_SPEED(pd_ctrl->cable_speed);
> >
> >  	if (pd_ctrl->control_flags & USB_PD_CTRL_OPTICAL_CABLE) @@ -
> 522,8
> > +546,10 @@ static int cros_typec_enable_usb4(struct cros_typec_data
> *typec,
> >  	/* Cable Type */
> >  	if (pd_ctrl->control_flags & USB_PD_CTRL_OPTICAL_CABLE)
> >  		data.eudo |=3D EUDO_CABLE_TYPE_OPTICAL <<
> EUDO_CABLE_TYPE_SHIFT;
> > -	else if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
> > +	else if (cros_typec_get_cable_vdo(port, USB_TYPEC_TBT_SID) &
> > +TBT_CABLE_RETIMER)
> >  		data.eudo |=3D EUDO_CABLE_TYPE_RE_TIMER <<
> EUDO_CABLE_TYPE_SHIFT;
> We shouldn't need to call cros_typec_get_cable_vdo more than once. Either
> call it once earlier when you are crafting the data.cable_mode member and
> then re-use that variable here. Or don't call it there and just call it h=
ere.

We are only calling it once depending upon which mode we enter TBT Alt or U=
SB4.

Sincerely,
Utkarsh Patel.

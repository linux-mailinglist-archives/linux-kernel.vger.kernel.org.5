Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B24798B23
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 19:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245279AbjIHRDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 13:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjIHRDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 13:03:17 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9501FCF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 10:03:13 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c0db66af1bso17197265ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 10:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694192592; x=1694797392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R5jao51/Y0l1+96mjFOat1xOO+2+m4Y2di/OCWSkew4=;
        b=Tm28zd3gZNV9M0g3vagYSokyQMdujbLeluqxHsVAQX5PEbJpv3qbjz/e5qk6l/a2E2
         7EhTvxWUDGt9RzO+JZNbbAzhoiQ9VBxDNYeCMp2+FKgXotdzj//cOAvS4M4uCdZqiKb5
         veQJz45Oxmz708LcLLRmH5XKrJKkOd1q+1s0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694192592; x=1694797392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5jao51/Y0l1+96mjFOat1xOO+2+m4Y2di/OCWSkew4=;
        b=IWFTuGsMbSX0FSQbsbtd0QxjIdbpOfHdBZxM8lltBkVFIzEqZDKXDUjygj22j/Ahws
         R5rUzxvdx8+7PQ3PKVs7uBBlzYYC4SzVOuMfSIWBfF4ydexETHlho2MoBucKAWG4c0Et
         fPvCk/zKDilW7RFIwaKbQnoHdEliqeHGHlzn/TJFuz7Bnh5j2fvVrIHoj93k06kBmKaA
         RNN+ZYNEIpzRpmQIkiWX5je8j2n0196VBPEYBuaiR4b3U/eXyG5cYVa/hmD1DLwOxGCe
         oIzUsJPCxyD8aMQIWV+H1EJLelbAHSVsLbs7mHgXENOrWPHHO2gp2OoII4MzUIsGRRYg
         ACGw==
X-Gm-Message-State: AOJu0Yyz1fEc5dceJD8SBe0hnK94VeZJHG3jWCDInElL/H2uGP8a87CM
        k+Mm7E9iJG5HusFx5XDXphDVOfNUOFvbblYvzJdCDw==
X-Google-Smtp-Source: AGHT+IHs0K/2VG7TwS32NJgQ8vtkJ6LomrMNB5EEzacZHpSrUlBge4RKMp+7hHeVt/tJl2YloYnPsA==
X-Received: by 2002:a17:903:258b:b0:1bd:b79:3068 with SMTP id jb11-20020a170903258b00b001bd0b793068mr3235977plb.48.1694192592448;
        Fri, 08 Sep 2023 10:03:12 -0700 (PDT)
Received: from chromium.org (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id jf20-20020a170903269400b001b80760fd04sm1806896plb.112.2023.09.08.10.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 10:03:11 -0700 (PDT)
Date:   Fri, 8 Sep 2023 17:03:10 +0000
From:   Prashant Malani <pmalani@chromium.org>
To:     "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: Re: [PATCH v2 4/5] platform/chrome: cros_ec_typec: Add Displayport
 Alternatemode 2.1 Support
Message-ID: <ZPtTzovOMJ2gmPdy@chromium.org>
References: <20230830223950.1360865-1-utkarsh.h.patel@intel.com>
 <20230830223950.1360865-5-utkarsh.h.patel@intel.com>
 <MWHPR11MB0048D87555CACAC4DC7DF1DFA9E5A@MWHPR11MB0048.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB0048D87555CACAC4DC7DF1DFA9E5A@MWHPR11MB0048.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Utkarsh,

Just a minor thing you can fix for the next version (since it looks
like there will be one).

On Aug 31 15:24, Patel, Utkarsh H wrote:
> Hello,
> 
> >  drivers/platform/chrome/cros_ec_typec.c | 31
> > +++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> > 
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c
> > b/drivers/platform/chrome/cros_ec_typec.c
> > index d0b4d3fc40ed..8372f13052a8 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.c
> > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > @@ -492,6 +492,8 @@ static int cros_typec_enable_dp(struct
> > cros_typec_data *typec,  {
> >  	struct cros_typec_port *port = typec->ports[port_num];
> >  	struct typec_displayport_data dp_data;
> > +	u32 cable_tbt_vdo;
> > +	u32 cable_dp_vdo;
> >  	int ret;
> > 
> >  	if (typec->pd_ctrl_ver < 2) {
> > @@ -524,6 +526,35 @@ static int cros_typec_enable_dp(struct
> > cros_typec_data *typec,
> >  	port->state.data = &dp_data;
> >  	port->state.mode = TYPEC_MODAL_STATE(ffs(pd_ctrl->dp_mode));
> > 
> > +	/* Get cable VDO for cables with DPSID to check DPAM2.1 is
> > supported */
> > +	cable_dp_vdo = cros_typec_get_cable_vdo(port,
> > USB_TYPEC_DP_SID);
> > +
> > +	/**
> > +	 * Get cable VDO for thunderbolt cables and cables with DPSID but
> > does not
> > +	 * support DPAM2.1.
> > +	 */
> > +	cable_tbt_vdo = cros_typec_get_cable_vdo(port,
> > USB_TYPEC_TBT_SID);
> > +
> > +	if (cable_dp_vdo & DP_CAP_DPAM_VERSION) {
> > +		dp_data.conf |= cable_dp_vdo;
> > +	} else if (cable_tbt_vdo) {
> > +		u8 cable_speed = TBT_CABLE_SPEED(cable_tbt_vdo);
Can we declare this variable at the top? That is the style in this
file and quite commonly seen elsewhere.

Or better yet, just inline this and get rid of the extra variable altogether:

	dp_data.conf |= TBT_CABLE_SPEED(...) << DP_CONF_SIGNALLING_SHIFT;

> > +
> > +		dp_data.conf |= cable_speed <<
> > DP_CONF_SIGNALLING_SHIFT;
> > +
> > +		/* Cable Type */
> > +		if (cable_tbt_vdo & TBT_CABLE_OPTICAL)
> > +			dp_data.conf |= DP_CONF_CABLE_TYPE_OPTICAL <<
> > DP_CONF_CABLE_TYPE_SHIFT;
> > +		else if (cable_tbt_vdo & TBT_CABLE_RETIMER)
> > +			dp_data.conf |= DP_CONF_CABLE_TYPE_RE_TIMER <<
> > DP_CONF_CABLE_TYPE_SHIFT;
> > +		else if (cable_tbt_vdo & TBT_CABLE_ACTIVE_PASSIVE)
> > +			dp_data.conf |= DP_CONF_CABLE_TYPE_RE_DRIVER
> > << DP_CONF_CABLE_TYPE_SHIFT;
> > +	} else if (PD_IDH_PTYPE(port->c_identity.id_header) ==
> > IDH_PTYPE_PCABLE) {
> > +		u8 cable_speed = VDO_CABLE_SPEED(port-
> > >c_identity.vdo[0]);
Same here, you can inline this without affecting readability too much.


BR,

-Prashant

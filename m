Return-Path: <linux-kernel+bounces-59603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C8984F99A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5273D1F249D8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3D27B3D0;
	Fri,  9 Feb 2024 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OgLiL6t/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9457AE50;
	Fri,  9 Feb 2024 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496067; cv=none; b=ibUazD6fmwwuW8DSnzL5GUM3ncA/0r380aom4JCkH+XiM6ouejsoz7cF98FDJGegGs5oVKbHDDrdsnA3RDB/fSEfyu5hdyZBP8MfYOmzwrzr/+1+wuCuTKO9up/kzD6CVrjgrSSO+kkhFLA+p8OOaYDhqVIfjX2SHyLWNglxUKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496067; c=relaxed/simple;
	bh=4DH6uSiz75VZ5wu8uWaWlKg6/VzeFejpqv+LEayXYbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQtTQBUFD+o2lIScuwEdoE6z37YuHtrIEiUshFpJeaMPsFmh8sz4k9X+Qy4ctvgbp+hBo+8oNXIzoDWIc3CYCGe+YgEGQ7zMA8L/peaZuDK2gvFr+VOyk/uV2MBWPRowDEtY74fBfK2r67Wne1JKJbXi7b8i2EzE7bGyAsr7MEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OgLiL6t/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707496065; x=1739032065;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4DH6uSiz75VZ5wu8uWaWlKg6/VzeFejpqv+LEayXYbQ=;
  b=OgLiL6t/H2gFoHq3PfA4AWaOs2CfJdNFCl+eChhIv6H27ZynJgATZorL
   Xa8WLR1QoAwkiTyX4SsS7A94ftRPhM6sWJx9ppRNSfB4rfSFX4aGWghHw
   UqulWKCEuNgset/FrXIQwXErSYIWvO81ub5DtM1qehUXWVQ1GqUYFP+lD
   HQQ4am44KGQsTenY0eZCzDXipWkPXit/go7XgSUiTzC5KJqxE0WGONTUg
   7SrGz3XipsQFQdq0fu3ZukTyjJBHXPF6Sb0hwmxiT4FW0l5mYgfk8V9nR
   O1l1/8OPOelg8XXQ+I5FvLItImRM+LWRiDGfCnFKVSEZbWTZvbmObj9Ub
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1355034"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1355034"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 08:27:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="825178698"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="825178698"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.43.96])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 08:27:40 -0800
Date: Fri, 9 Feb 2024 17:27:37 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM <linux-pm@vger.kernel.org>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>, netdev@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	linux-wireless@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Subject: Re: [PATCH v1 6/9] iwlwifi: mvm: Set THERMAL_TRIP_WRITABLE_TEMP
 directly
Message-ID: <ZcZSeVjuYuL4mGCT@linux.intel.com>
References: <3232442.5fSG56mABF@kreacher>
 <3757041.MHq7AAxBmi@kreacher>
 <ZcY7jyyFJq1yfOCj@linux.intel.com>
 <CAJZ5v0gZ1tpNmdkvRLA6-ydnhKPKgsM_FCwrW+q1=5ZiD=vbWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gZ1tpNmdkvRLA6-ydnhKPKgsM_FCwrW+q1=5ZiD=vbWA@mail.gmail.com>

On Fri, Feb 09, 2024 at 05:15:41PM +0100, Rafael J. Wysocki wrote:
> On Fri, Feb 9, 2024 at 3:50 PM Stanislaw Gruszka
> <stanislaw.gruszka@linux.intel.com> wrote:
> >
> > On Fri, Feb 09, 2024 at 03:10:24PM +0100, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > It is now possible to flag trip points with THERMAL_TRIP_WRITABLE_TEMP
> > > to allow their temperature to be set from user space via sysfs instead
> > > of using a nonzero writable trips mask during thermal zone registration,
> > > so make the iwlwifi code do that.
> > >
> > > No intentional functional impact.
> > >
> > > Note that this change is requisite for dropping the mask argument from
> > > thermal_zone_device_register_with_trips() going forward.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >
> > > This patch obviously depends on
> > >
> > > https://patchwork.kernel.org/project/linux-pm/patch/8346768.T7Z3S40VBb@kreacher/
> > >
> > > which has been queued up for 6.9 already.
> > >
> > > ---
> > >  drivers/net/wireless/intel/iwlwifi/mvm/tt.c |    6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > Index: linux-pm/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > > +++ linux-pm/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > > @@ -667,9 +667,6 @@ static  struct thermal_zone_device_ops t
> > >       .set_trip_temp = iwl_mvm_tzone_set_trip_temp,
> > >  };
> > >
> > > -/* make all trips writable */
> > > -#define IWL_WRITABLE_TRIPS_MSK (BIT(IWL_MAX_DTS_TRIPS) - 1)
> > > -
> > >  static void iwl_mvm_thermal_zone_register(struct iwl_mvm *mvm)
> > >  {
> > >       int i, ret;
> > > @@ -692,11 +689,12 @@ static void iwl_mvm_thermal_zone_registe
> > >       for (i = 0 ; i < IWL_MAX_DTS_TRIPS; i++) {
> > >               mvm->tz_device.trips[i].temperature = THERMAL_TEMP_INVALID;
> > >               mvm->tz_device.trips[i].type = THERMAL_TRIP_PASSIVE;
> > > +             mvm->tz_device.trips[i].type = THERMAL_TRIP_WRITABLE_TEMP;
> >
> >                 mvm->tz_device.trips[i].flags = THERMAL_TRIP_WRITABLE_TEMP;
> >
> > Consider using diffrent prefix for constants to diffrenciate flags and types.
> 
> Well, I can use THERMAL_TRIP_FLAG_RW_TEMP or similar, but is it really
> so confusing?

It's not, it was just suggestion, if you don't want to, don't do it.

Regards
Stanislaw

> I'm wondering what others think.
> 
> > >       }
> > >       mvm->tz_device.tzone = thermal_zone_device_register_with_trips(name,
> > >                                                       mvm->tz_device.trips,
> > >                                                       IWL_MAX_DTS_TRIPS,
> > > -                                                     IWL_WRITABLE_TRIPS_MSK,
> > > +                                                     0,
> > >                                                       mvm, &tzone_ops,
> > >                                                       NULL, 0, 0);
> > >       if (IS_ERR(mvm->tz_device.tzone)) {
> > >
> > >
> > >
> >
> 


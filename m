Return-Path: <linux-kernel+bounces-138192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FD289EDEE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218411F21EC6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FD4157E9D;
	Wed, 10 Apr 2024 08:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jhQttSN+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1669156C78;
	Wed, 10 Apr 2024 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738662; cv=none; b=fnif9628rL466dgqhWWSQqikxVK0UlVcSVZ9FgErq0v99QVT3Cp8iND6LoWeLVnB4UX5AYgjBZ9FHhL3aM7peQPlEylgBjEczUU17sUGaL1hGknbF9wyhZC//2MDwcsQkDDzbIeXjdiXr0vsF+Boi4c9lUJdTZqnds2/CziypXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738662; c=relaxed/simple;
	bh=22j8uEO0liUSIyAblZj5xYhfKJtbo1A0yPEkeRp6MxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Swl1K7D4DIVDA0mUx3IpZVQuUEglrulPJxFx+6uOz0tvjpPBNpxhqpXfJRslOhQn8cYsDJizVC3F74v3vFE49U/ht7i19xMz2EPQHDWD3+ok0klGUDdz68ACsnZaHa+te3K7Ey1HIIiahBPrrotboT7BdMdCBHAIQfT7kQaZD7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jhQttSN+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712738661; x=1744274661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=22j8uEO0liUSIyAblZj5xYhfKJtbo1A0yPEkeRp6MxQ=;
  b=jhQttSN+qicqKS+HkmFN7qwua8QD9IwonMgJuZs4HMB2Ej8ap+U28IvU
   yg6nTkgsv76ldOaeCwvty8xs0Wptgh5EZNuuhisJFRasHGvEvEBBVfkAq
   Oc4nvLXYzR4d7Cchr5FICbmLbotqhuOpNPi04hF6G8wBzkwxREgJdxo6p
   ocqrbSeO1ljJkKzC6dE5+GAprToL9teRNG2STEa9jzF94OaJxnkhi/xyy
   d2fabcCd4dFjbhxJqwhOTfnCcGI4/3BkR0q+1fLnyPOtfsQjT5IFz5unI
   X2k1rjeuhv5Nxlxg4TQL58C1vDShEw/fBDZTb5H0Tm/2CopIHnZj1NtIW
   A==;
X-CSE-ConnectionGUID: N8PKfO9xQ1KyWPgiMXnbmg==
X-CSE-MsgGUID: v8lD+EJSQt+Xrdwe6JeeBg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8312387"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="8312387"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 01:44:20 -0700
X-CSE-ConnectionGUID: ZCEpQddvRGO1fCBVA3e7SA==
X-CSE-MsgGUID: +JF+LgLfSBCF7PIBaR62nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20442869"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 01:44:16 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 3DE6711FC46;
	Wed, 10 Apr 2024 11:44:13 +0300 (EEST)
Date: Wed, 10 Apr 2024 08:44:13 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Luigi311 <git@luigi311.com>, linux-media@vger.kernel.org,
	jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	pavel@ucw.cz, phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 19/25] media: i2c: imx258: Change register settings
 for variants of the sensor
Message-ID: <ZhZRXbkovF7XpsSr@kekkonen.localdomain>
References: <20240403150355.189229-1-git@luigi311.com>
 <20240403150355.189229-20-git@luigi311.com>
 <Zg2BZXQpzsm7jMnc@kekkonen.localdomain>
 <998efafa-699b-4226-91d4-2ebba85d63ec@luigi311.com>
 <Zg_Zl0Q2kEDJoQoe@kekkonen.localdomain>
 <CAPY8ntDP-EPQK_d=5NeVM-ZTjfhtpYRq_y6PVSn9dRzxD5b1_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPY8ntDP-EPQK_d=5NeVM-ZTjfhtpYRq_y6PVSn9dRzxD5b1_A@mail.gmail.com>

Hi Dave,

On Fri, Apr 05, 2024 at 02:16:31PM +0100, Dave Stevenson wrote:
> Hi Sakari
> 
> On Fri, 5 Apr 2024 at 11:59, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Luis, Dave,
> >
> > On Thu, Apr 04, 2024 at 04:44:05PM -0600, Luigi311 wrote:
> > > On 4/3/24 10:18, Sakari Ailus wrote:
> > > > Hi Luis, Dave,
> > > >
> > > > On Wed, Apr 03, 2024 at 09:03:48AM -0600, git@luigi311.com wrote:
> > > >> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > > >>
> > > >> Sony have advised that there are variants of the IMX258 sensor which
> > > >> require slightly different register configuration to the mainline
> > > >> imx258 driver defaults.
> > > >>
> > > >> There is no available run-time detection for the variant, so add
> > > >> configuration via the DT compatible string.
> > > >>
> > > >> The Vision Components imx258 module supports PDAF, so add the
> > > >> register differences for that variant
> > > >>
> > > >> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > > >> Signed-off-by: Luis Garcia <git@luigi311.com>
> > > >> ---
> > > >>  drivers/media/i2c/imx258.c | 48 ++++++++++++++++++++++++++++++++++----
> > > >>  1 file changed, 44 insertions(+), 4 deletions(-)
> > > >>
> > > >> diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
> > > >> index 775d957c9b87..fa48da212037 100644
> > > >> --- a/drivers/media/i2c/imx258.c
> > > >> +++ b/drivers/media/i2c/imx258.c
> > > >> @@ -6,6 +6,7 @@
> > > >>  #include <linux/delay.h>
> > > >>  #include <linux/i2c.h>
> > > >>  #include <linux/module.h>
> > > >> +#include <linux/of_device.h>
> > > >>  #include <linux/pm_runtime.h>
> > > >>  #include <linux/regulator/consumer.h>
> > > >>  #include <media/v4l2-ctrls.h>
> > > >> @@ -321,8 +322,6 @@ static const struct imx258_reg mipi_642mbps_24mhz_4l[] = {
> > > >>
> > > >>  static const struct imx258_reg mode_common_regs[] = {
> > > >>    { 0x3051, 0x00 },
> > > >> -  { 0x3052, 0x00 },
> > > >> -  { 0x4E21, 0x14 },
> > > >>    { 0x6B11, 0xCF },
> > > >>    { 0x7FF0, 0x08 },
> > > >>    { 0x7FF1, 0x0F },
> > > >> @@ -345,7 +344,6 @@ static const struct imx258_reg mode_common_regs[] = {
> > > >>    { 0x7FA8, 0x03 },
> > > >>    { 0x7FA9, 0xFE },
> > > >>    { 0x7B24, 0x81 },
> > > >> -  { 0x7B25, 0x00 },
> > > >>    { 0x6564, 0x07 },
> > > >>    { 0x6B0D, 0x41 },
> > > >>    { 0x653D, 0x04 },
> > > >> @@ -460,6 +458,33 @@ static const struct imx258_reg mode_1048_780_regs[] = {
> > > >>    { 0x034F, 0x0C },
> > > >>  };
> > > >>
> > > >> +struct imx258_variant_cfg {
> > > >> +  const struct imx258_reg *regs;
> > > >> +  unsigned int num_regs;
> > > >> +};
> > > >> +
> > > >> +static const struct imx258_reg imx258_cfg_regs[] = {
> > > >> +  { 0x3052, 0x00 },
> > > >> +  { 0x4E21, 0x14 },
> > > >> +  { 0x7B25, 0x00 },
> > > >> +};
> > > >> +
> > > >> +static const struct imx258_variant_cfg imx258_cfg = {
> > > >> +  .regs = imx258_cfg_regs,
> > > >> +  .num_regs = ARRAY_SIZE(imx258_cfg_regs),
> > > >> +};
> > > >> +
> > > >> +static const struct imx258_reg imx258_pdaf_cfg_regs[] = {
> > > >> +  { 0x3052, 0x01 },
> > > >> +  { 0x4E21, 0x10 },
> > > >> +  { 0x7B25, 0x01 },
> > > >> +};
> > > >> +
> > > >> +static const struct imx258_variant_cfg imx258_pdaf_cfg = {
> > > >> +  .regs = imx258_pdaf_cfg_regs,
> > > >> +  .num_regs = ARRAY_SIZE(imx258_pdaf_cfg_regs),
> > > >> +};
> > > >> +
> > > >>  static const char * const imx258_test_pattern_menu[] = {
> > > >>    "Disabled",
> > > >>    "Solid Colour",
> > > >> @@ -637,6 +662,8 @@ struct imx258 {
> > > >>    struct v4l2_subdev sd;
> > > >>    struct media_pad pad;
> > > >>
> > > >> +  const struct imx258_variant_cfg *variant_cfg;
> > > >> +
> > > >>    struct v4l2_ctrl_handler ctrl_handler;
> > > >>    /* V4L2 Controls */
> > > >>    struct v4l2_ctrl *link_freq;
> > > >> @@ -1104,6 +1131,14 @@ static int imx258_start_streaming(struct imx258 *imx258)
> > > >>            return ret;
> > > >>    }
> > > >>
> > > >> +  ret = imx258_write_regs(imx258, imx258->variant_cfg->regs,
> > > >> +                          imx258->variant_cfg->num_regs);
> > > >> +  if (ret) {
> > > >> +          dev_err(&client->dev, "%s failed to set variant config\n",
> > > >> +                  __func__);
> > > >> +          return ret;
> > > >> +  }
> > > >> +
> > > >>    ret = imx258_write_reg(imx258, IMX258_CLK_BLANK_STOP,
> > > >>                           IMX258_REG_VALUE_08BIT,
> > > >>                           imx258->csi2_flags & V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK ?
> > > >> @@ -1492,6 +1527,10 @@ static int imx258_probe(struct i2c_client *client)
> > > >>
> > > >>    imx258->csi2_flags = ep.bus.mipi_csi2.flags;
> > > >>
> > > >> +  imx258->variant_cfg = of_device_get_match_data(&client->dev);
> > > >
> > > > You'll also need to keep this working for ACPI based systems. I.e. in
> > > > practice remove "of_" prefix here and add the non-PDAF variant data to the
> > > > relevant ACPI ID list.
> > > >
> > >
> > > Removing of_ is easy enough and looking at all the other commits that make
> > > this change in other drivers I dont see anything else being done besides
> > > adding in the .data section that is down below for both imx258 and pdaf
> > > versions. Is that what you are referencing or is there some other place
> > > to add variant data to ACPI ID list?
> >
> > Speaking of which---are you absolutely certain there are two variants of
> > this sensor? Many sensors that have a different pixel pattern (PDAF pixels
> > or a non-Bayer pattern) can produce Bayer data when condigured so. The fact
> > that you have differing register configuration for the PDAF and non-PDAF
> > cases suggests this may well be the case.
> 
> I had a discussion with our contact at Sony over the configuration,
> and Soho Enterprises who made the module I have also consulted with
> Sony (their main person is ex Sony himself).
> 
> There is a spec version field in the OTP which reflects the pixel
> pattern. It has defined options of:
> - HDR pattern
> - Binning pattern
> - mono
> - non-PDAF
> - HDR HDD
> 
> Sony can't release information on how to read that information from
> the sensor OTP as it is contractually locked by contracts with Intel.
> Whilst information obtained via other routes means I have checked it
> on my module as HDR pattern whilst the Nautilus platform has the
> non-PDAF variant, I'm not going to spoil our relationship with Sony by
> releasing that.
> 
> It's possible that the Nautilus sensor will work happily with the
> settings required for the PDAF variant, but I have no way of testing
> that, and the registers in question are undocumented. Changing them
> blindly isn't going to make any friends, and I doubt existing platform
> users wish to rerun all their image quality tests on the sensor to
> validate the change.
> 
> Unless Intel wish to release the information on reading the OTP, we
> have no way of telling the variants apart but need different register
> configurations. If there is a better way of handling that situation
> than compatible strings, then I'm open to suggestions.
> 
> There's a short thread on libcamera-devel from back in 2022 where I
> was looking into this [1]

Oops! I guess we'll need these two for now at least.

We don't really have support for PDAF anyway (I'd expect this to be
documented for a driver, for instance) so I presume currently for
PDAF-variants the configuration is about "correcting" the PDAF pixels?

The problem seems to be worse on ACPI systems as there's a single HID only.

> 
>   Dave
> 
> [1] https://lists.libcamera.org/pipermail/libcamera-devel/2022-June/031449.html
> 
> > >
> > > >> +  if (!imx258->variant_cfg)
> > > >> +          imx258->variant_cfg = &imx258_cfg;
> > > >> +
> > > >>    /* Initialize subdev */
> > > >>    v4l2_i2c_subdev_init(&imx258->sd, client, &imx258_subdev_ops);
> > > >>
> > > >> @@ -1579,7 +1618,8 @@ MODULE_DEVICE_TABLE(acpi, imx258_acpi_ids);
> > > >>  #endif
> > > >>
> > > >>  static const struct of_device_id imx258_dt_ids[] = {
> > > >> -  { .compatible = "sony,imx258" },
> > > >> +  { .compatible = "sony,imx258", .data = &imx258_cfg },
> > > >> +  { .compatible = "sony,imx258-pdaf", .data = &imx258_pdaf_cfg },
> > > >>    { /* sentinel */ }
> > > >>  };
> > > >>  MODULE_DEVICE_TABLE(of, imx258_dt_ids);
> > > >
> > >

-- 
Kind regards,

Sakari Ailus


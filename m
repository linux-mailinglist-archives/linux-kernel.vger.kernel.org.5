Return-Path: <linux-kernel+bounces-130985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A92BD898197
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0FB1F24B19
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05EA4C634;
	Thu,  4 Apr 2024 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OL/XYWWT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4817634CD8;
	Thu,  4 Apr 2024 06:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712213210; cv=none; b=Hp+NoJeyIQ3RDwdRV3Eff6o5TxKFTvE7HSAumTWVvuTI7VmH/EZ8tYTaEVeXmqeJVo0l28VTi+kAr5TGnkt419GSiEUPIPEiviYj+JfjAGVncTiixH2KkiqjiwcwN98kbS8vMzzn0K61zbvJ+ILHfNsHRaGvH4FycAdcEFPMFvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712213210; c=relaxed/simple;
	bh=bMDLNBhBvkhLFpcvsy0yCqj4AI0a6AiW29CLCySMGFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cza/Iyu1bYGeBv034TB6wh/9VfbrQU5wyowdlBPbi7GQijaq478Rw9B15CDqkHkPwAeGOQDGYw1Zsz7XwZgw5+0pPGTnUjD95dtDJQGQlGt5dY1TlqL6RF7CazCVLZrmQyD2g0/ec1EWu94552tSARAwV/TSi9URAlkWwpCWDIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OL/XYWWT; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712213208; x=1743749208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bMDLNBhBvkhLFpcvsy0yCqj4AI0a6AiW29CLCySMGFE=;
  b=OL/XYWWTKz4CzHFjNlOgxSQzTAn7SxKbDpqwTut3JCHRx0xxqfL3nkH1
   C00MwkU09kkEZ/DSwwu5EkEtX9tXq9zTDG2wpoylAJ8CMOYRxB7w1ZKhT
   SH89gCpZIbO7lcJarzvJC03iaV/zpGM4NnyZIJSndmaEHlFVWZw+1LyYL
   /kkCYvmS8YetvfvdpFRRh+14IrRxXQzLjXF58RasB1S7gZuciMy88r3ZI
   kWrXWa7qqz2GUyUHTpkOIbtnPyBgmBSStDCzXK610qPO2tiszaFd5k1vN
   2SxZD3JZXLjUiQR1R54sfH/dFwFTqyU2uxGLloVwgCEK2nalsVLDpCTkg
   A==;
X-CSE-ConnectionGUID: GiunqB3hSoeVRSfS4kHMBQ==
X-CSE-MsgGUID: sW1oCmmGQt6JpM0ylrgh+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7379357"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="7379357"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 23:46:47 -0700
X-CSE-ConnectionGUID: VdGosPykQImF++czo0WKFw==
X-CSE-MsgGUID: 5Z/d2OWiTuSW0zkKSBOjTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="18525005"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 23:46:42 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 3D31211F855;
	Thu,  4 Apr 2024 09:46:39 +0300 (EEST)
Date: Thu, 4 Apr 2024 06:46:39 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Luigi311 <git@luigi311.com>
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	pavel@ucw.cz, phone-devel@vger.kernel.org,
	Ondrej Jirman <megi@xff.cz>
Subject: Re: [PATCH v3 21/25] drivers: media: i2c: imx258: Use macros
Message-ID: <Zg5Mz0QSqNDXzY4o@kekkonen.localdomain>
References: <20240403150355.189229-1-git@luigi311.com>
 <20240403150355.189229-22-git@luigi311.com>
 <Zg2CirmwL3JfjA8s@kekkonen.localdomain>
 <df8c245a-40e9-4bf5-b870-7efe321d820a@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df8c245a-40e9-4bf5-b870-7efe321d820a@luigi311.com>

On Wed, Apr 03, 2024 at 01:17:26PM -0600, Luigi311 wrote:
> On 4/3/24 10:23, Sakari Ailus wrote:
> > Hi Luis,
> > 
> > On Wed, Apr 03, 2024 at 09:03:50AM -0600, git@luigi311.com wrote:
> >> From: Luis Garcia <git@luigi311.com>
> >>
> >> Use understandable macros instead of raw values.
> >>
> >> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> >> Signed-off-by: Luis Garcia <git@luigi311.com>
> >> ---
> >>  drivers/media/i2c/imx258.c | 434 ++++++++++++++++++-------------------
> >>  1 file changed, 207 insertions(+), 227 deletions(-)
> >>
> >> diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
> >> index e2ecf6109516..30352c33f63c 100644
> >> --- a/drivers/media/i2c/imx258.c
> >> +++ b/drivers/media/i2c/imx258.c
> >> @@ -33,8 +33,6 @@
> >>  #define IMX258_VTS_30FPS_VGA		0x034c
> >>  #define IMX258_VTS_MAX			65525
> >>  
> >> -#define IMX258_REG_VTS			0x0340
> >> -
> >>  /* HBLANK control - read only */
> >>  #define IMX258_PPL_DEFAULT		5352
> >>  
> >> @@ -90,6 +88,53 @@
> >>  #define IMX258_PIXEL_ARRAY_WIDTH	4208U
> >>  #define IMX258_PIXEL_ARRAY_HEIGHT	3120U
> >>  
> >> +/* regs */
> >> +#define IMX258_REG_PLL_MULT_DRIV                  0x0310
> >> +#define IMX258_REG_IVTPXCK_DIV                    0x0301
> >> +#define IMX258_REG_IVTSYCK_DIV                    0x0303
> >> +#define IMX258_REG_PREPLLCK_VT_DIV                0x0305
> >> +#define IMX258_REG_IOPPXCK_DIV                    0x0309
> >> +#define IMX258_REG_IOPSYCK_DIV                    0x030b
> >> +#define IMX258_REG_PREPLLCK_OP_DIV                0x030d
> >> +#define IMX258_REG_PHASE_PIX_OUTEN                0x3030
> >> +#define IMX258_REG_PDPIX_DATA_RATE                0x3032
> >> +#define IMX258_REG_SCALE_MODE                     0x0401
> >> +#define IMX258_REG_SCALE_MODE_EXT                 0x3038
> >> +#define IMX258_REG_AF_WINDOW_MODE                 0x7bcd
> >> +#define IMX258_REG_FRM_LENGTH_CTL                 0x0350
> >> +#define IMX258_REG_CSI_LANE_MODE                  0x0114
> >> +#define IMX258_REG_X_EVN_INC                      0x0381
> >> +#define IMX258_REG_X_ODD_INC                      0x0383
> >> +#define IMX258_REG_Y_EVN_INC                      0x0385
> >> +#define IMX258_REG_Y_ODD_INC                      0x0387
> >> +#define IMX258_REG_BINNING_MODE                   0x0900
> >> +#define IMX258_REG_BINNING_TYPE_V                 0x0901
> >> +#define IMX258_REG_FORCE_FD_SUM                   0x300d
> >> +#define IMX258_REG_DIG_CROP_X_OFFSET              0x0408
> >> +#define IMX258_REG_DIG_CROP_Y_OFFSET              0x040a
> >> +#define IMX258_REG_DIG_CROP_IMAGE_WIDTH           0x040c
> >> +#define IMX258_REG_DIG_CROP_IMAGE_HEIGHT          0x040e
> >> +#define IMX258_REG_SCALE_M                        0x0404
> >> +#define IMX258_REG_X_OUT_SIZE                     0x034c
> >> +#define IMX258_REG_Y_OUT_SIZE                     0x034e
> >> +#define IMX258_REG_X_ADD_STA                      0x0344
> >> +#define IMX258_REG_Y_ADD_STA                      0x0346
> >> +#define IMX258_REG_X_ADD_END                      0x0348
> >> +#define IMX258_REG_Y_ADD_END                      0x034a
> >> +#define IMX258_REG_EXCK_FREQ                      0x0136
> >> +#define IMX258_REG_CSI_DT_FMT                     0x0112
> >> +#define IMX258_REG_LINE_LENGTH_PCK                0x0342
> >> +#define IMX258_REG_SCALE_M_EXT                    0x303a
> >> +#define IMX258_REG_FRM_LENGTH_LINES               0x0340
> >> +#define IMX258_REG_FINE_INTEG_TIME                0x0200
> >> +#define IMX258_REG_PLL_IVT_MPY                    0x0306
> >> +#define IMX258_REG_PLL_IOP_MPY                    0x030e
> >> +#define IMX258_REG_REQ_LINK_BIT_RATE_MBPS_H       0x0820
> >> +#define IMX258_REG_REQ_LINK_BIT_RATE_MBPS_L       0x0822
> >> +
> >> +#define REG8(a, v) { a, v }
> >> +#define REG16(a, v) { a, ((v) >> 8) & 0xff }, { (a) + 1, (v) & 0xff }
> > 
> > The patch is nice but these macros are better replaced by the V4L2 CCI
> > helper that also offers register access functions. Could you add a patch to
> > convert the driver to use it (maybe after this one)?
> > 
> 
> Ohh perfect, using something else would be great. Ill go ahead and see
> if I can get that working.

Thanks. It may be easier to just do it in this one actually. Up to you.

-- 
Sakari Ailus


Return-Path: <linux-kernel+bounces-122086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4B488F1BD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADAD91C2C80A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1573E153574;
	Wed, 27 Mar 2024 22:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="giWOTOrb"
Received: from mail-108-mta69.mxroute.com (mail-108-mta69.mxroute.com [136.175.108.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B74152DEF
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 22:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711578054; cv=none; b=aa5rs/ouFOSIPGynFf8ZkvASw2XZHK/zdifYrNH/RXbDrj0Xh1HoF4h+bV74c11Zw0YqOOR80Nn78L5REnLmREUxibAE98Muc28jZV/uRCmND6Th1AEPDL/hvtwoaoZSSXfDacdCXcSMeWjfN5pxsqHbBA1PvshDugrLW2jG5GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711578054; c=relaxed/simple;
	bh=DdmBqYdJ2ZdOL0LNBiHRRkPHyYDDhUrtzy6gt6A/4OU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eKlr2LpJHjrYa8CNR1Khzz2H5Z6WDP5h3zpZ40xi3+xpUw8rzlwFmKdghqHvcC4ztqtIJs4oyFjUc85J4XxlfFjcQhotHkacOxx03AWg20DNlTjmT3gsdXAkYpUt7daqnejjZCxMarmmBdCaX5H2bLZ6NsGATeLmDKq151N+n70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=giWOTOrb; arc=none smtp.client-ip=136.175.108.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta69.mxroute.com (ZoneMTA) with ESMTPSA id 18e82004f9c0003bea.00f
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 27 Mar 2024 22:20:42 +0000
X-Zone-Loop: fc444fc3d74fb796e23e66405a9c31c3d0e03952dc84
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uXtBpiZ7rKqehqsVlWENlhvtk/TPCXFbKRLouJ5rAkM=; b=giWOTOrbdCQ7+LyXAZZoVyhOpO
	1bcihatHrGsO8CsEicgUCUqtWC0otp5s2MBXFNWFrRQYEuJEFEFlICqt2O+l1ENMDTsxdh3d4w/QD
	cE1ornZblbbuzl9qGq3M8yxYCPra791GlbINqiUVmO9kykQyir69oZUUq7Jeaw6Q1sEYyQm+2UqFt
	atJ0zsxO/NFXuMYNEAKm+9YTq0uM7AkqED1cDlrTUj3N7r8SIfAfMKFxLkbO3eMDa8pdSzY4hfge8
	QENCQERkpJPhxI2J8OKLKWg6/rXmUnZ37FcZB0eYEEqB9XQGXzzMT2q5y2ywRBMFcWxGTl1M/WIg0
	NKbYQcGw==;
From: git@luigi311.com
To: linux-media@vger.kernel.org
Cc: dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com,
	mchehab@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	x@xnux.eu,
	Luigi311 <git@luigi311.com>
Subject: [PATCH 00/23] v2: imx258 improvement series
Date: Wed, 27 Mar 2024 16:20:12 -0600
Message-ID: <20240327222035.47208-1-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: personal@luigi311.com

From: Luigi311 <git@luigi311.com>

v2 changes:
- Add use macros patch 
- Add support for powerdown gpio patch
- Add support for reset gpio patch
- Dropped Add support for long exposure modes patch
- Implemented feedback from Jacopo Mondi
  - media: i2c: imx258: Add regulator control
  - media: i2c: imx258: Add support for 24MHz clock
  - media: i2c: imx258: Add support for running on 2 CSI data lanes
  - media: i2c: imx258: Add get_selection for pixel array information
  - media: i2c: imx258: Issue reset before starting streaming
  - media: i2c: imx258: Set pixel_rate range to the same as the value
  - dt-bindings: media: imx258: Add alternate compatible strings
  - media: i2c: imx258: Change register settings for variants of the sensor
  - media: i2c: imx258: Make HFLIP and VFLIP controls writable

This adds a few more patches and drops one. The long exposure mode patch was
dropped due to the bug that Jacopo found. The powerdown and reset gpio patches
were added as that fixes support for the Pinephone Pro, without them the sensor
doesnt initialize correctly.

Tested on a Pinephone Pro by forcing 24 mhz clock and was able to access all 3
resolutions. The two lower resolutions had some artifacts but that is expected
as more changes are required to fix them for the Pinephone Pro specifically,
kept all registers the same as Dave's original patch since that works on
dedicated imx258 hardware and the artifacts are PPP specific so it shouldnt be
a regression.


v1

This is a set of patches for imx258 that allow it to work with alternate clock
frequencies, over either 2 or 4 lanes, and generally adding flexibility to the
driver.

Tested with an IMX258 module from Soho Enterprises that has a 24MHz oscillator.
Both 2 and 4 lane configurations work with correct link frequencies and pixel
rates.

Jacopo has tested on a PinePhone Pro which has an ~19.2MHz clock fed from the SoC,
He confirms that the two lower resolution modes work, but not the full res mode.
Comparing to the BSP it looks like they have some weird clock configuration in
the 4208x3120 mode (nominally 1224Mb/s/lane instead of 1267).
As it has never previously worked directly with the mainline driver this isn't a
regression but may indicate that there is a need for support of additional link
frequencies in the future.

The last patch that makes HFLIP and VFLIP configurable may be contentious as I've
retained the default configuration of inverted from the original driver. I know
this was discussed recently, but I can't recall the final outcome.

I am relying on someone from Intel testing this out, as correcting the cropping
and supporting flips has changed the Bayer order. Seeing as this is all above
board in V4L2 terms I really hope that the layers above it behave themselves.

Cheers
  Dave


Dave Stevenson (20):
  media: i2c: imx258: Remove unused defines
  media: i2c: imx258: Make image geometry meet sensor requirements
  media: i2c: imx258: Disable digital cropping on binned modes
  media: i2c: imx258: Remove redundant I2C writes.
  media: i2c: imx258: Add regulator control
  media: i2c: imx258: Make V4L2_CID_VBLANK configurable.
  media: i2c: imx258: Split out common registers from the mode based
    ones
  media: i2c: imx258: Add support for 24MHz clock
  media: i2c: imx258: Add support for running on 2 CSI data lanes
  media: i2c: imx258: Follow normal V4L2 behaviours for clipping
    exposure
  media: i2c: imx258: Add get_selection for pixel array information
  media: i2c: imx258: Allow configuration of clock lane behaviour
  media: i2c: imx258: Correct max FRM_LENGTH_LINES value
  media: i2c: imx258: Issue reset before starting streaming
  media: i2c: imx258: Set pixel_rate range to the same as the value
  media: i2c: imx258: Support faster pixel rate on binned modes
  dt-bindings: media: imx258: Rename to include vendor prefix
  dt-bindings: media: imx258: Add alternate compatible strings
  media: i2c: imx258: Change register settings for variants of the
    sensor
  media: i2c: imx258: Make HFLIP and VFLIP controls writable

Luigi311 (3):
  drivers: media: i2c: imx258: Use macros
  drivers: media: i2c: imx258: Add support for powerdown gpio
  drivers: media: i2c: imx258: Add support for reset gpio

 .../i2c/{imx258.yaml => sony,imx258.yaml}     |   12 +-
 MAINTAINERS                                   |    2 +-
 drivers/media/i2c/imx258.c                    | 1147 +++++++++++------
 3 files changed, 744 insertions(+), 417 deletions(-)
 rename Documentation/devicetree/bindings/media/i2c/{imx258.yaml => sony,imx258.yaml} (88%)

-- 
2.42.0



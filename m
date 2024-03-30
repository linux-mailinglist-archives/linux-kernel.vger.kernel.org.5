Return-Path: <linux-kernel+bounces-125761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D780892BCD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 16:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54DBB1F21AD6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 15:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C673BB4F;
	Sat, 30 Mar 2024 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=paroga.com header.i=@paroga.com header.b="nOC60pI5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=paroga.com header.i=@paroga.com header.b="nOC60pI5"
Received: from mx208.easyname.com (mx208.easyname.com [212.232.28.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B5539AF9;
	Sat, 30 Mar 2024 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.232.28.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711811986; cv=none; b=RM99+04GqKVUWVHvbi3x2yxz50ABSy4AAtpSc6zWfwEHzm2ge0AVnSJkOknI8H3PGWxobptESAWVQ3UMmMsE5v1sO7+oo1aJYt1nGrCm6W4YZ3DvT6XH5Wvq6hi0dQGz5uRZOb9K381KkCgi0q1JKAVh5ywDOqkGFfaMW0CzzS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711811986; c=relaxed/simple;
	bh=oiKb/WgdTiDAoisYVc4IhzWJOKWvIzrcS4Hd8s2oeQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kW6ZPJFQntc85KnyxP3CWc+F91FByxWnlzZE/r4huKldxIX7G8gaXqasdj2XJqBvtIUgARlxkmjx4WtAWS4nAEU/BXhRg7mnkSNgoqobPmMCTxvVzBB7pa2cW4j00t+vb4h4443ogUSonbJ9sJ3Bgdb9AMWn53dKcIsXSLbrxe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paroga.com; spf=pass smtp.mailfrom=paroga.com; dkim=pass (2048-bit key) header.d=paroga.com header.i=@paroga.com header.b=nOC60pI5; dkim=pass (2048-bit key) header.d=paroga.com header.i=@paroga.com header.b=nOC60pI5; arc=none smtp.client-ip=212.232.28.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paroga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paroga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=paroga.com;
	 s=easyname; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7WBh3tTpWzmwiZVjvRLHfAhzBGmiAs9iajNkG57wSgw=; b=nOC60pI5iAYu2Ji1JyfJOd+Vqa
	Sjuuewo6IujElqVmhPfmZPx0acNyn0EHP3/0j6zujCcTshJJY81CfnNuP/Jy5EYX4VDkU/04+wNsw
	yd/Mj5gceiPKQNGn3Se/29Kz7Mr873EMAO5cOlIhqJjo0LvepSQ3Csm7CJ0oRTg1WfIAxID7xuMMb
	HhZ7wpgTHMsqruyc0fKB4iFccSlWCrTnq6pdmQ9vQe+YHNJCvcDz3iyKQnmK5loJvTHju6emAf4bu
	yi0NTFAEadvEzPFZuH6GVdBnOLbSjNwoB9fSdf1sSFeJnLT8hBv+5GFT9ZAUImy0MVgPcUWGz9BPG
	jp1SMjgw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=paroga.com;
	 s=easyname; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7WBh3tTpWzmwiZVjvRLHfAhzBGmiAs9iajNkG57wSgw=; b=nOC60pI5iAYu2Ji1JyfJOd+Vqa
	Sjuuewo6IujElqVmhPfmZPx0acNyn0EHP3/0j6zujCcTshJJY81CfnNuP/Jy5EYX4VDkU/04+wNsw
	yd/Mj5gceiPKQNGn3Se/29Kz7Mr873EMAO5cOlIhqJjo0LvepSQ3Csm7CJ0oRTg1WfIAxID7xuMMb
	HhZ7wpgTHMsqruyc0fKB4iFccSlWCrTnq6pdmQ9vQe+YHNJCvcDz3iyKQnmK5loJvTHju6emAf4bu
	yi0NTFAEadvEzPFZuH6GVdBnOLbSjNwoB9fSdf1sSFeJnLT8hBv+5GFT9ZAUImy0MVgPcUWGz9BPG
	jp1SMjgw==;
Received: from 84-115-225-203.cable.dynamic.surfer.at ([84.115.225.203] helo=localhost.localdomain)
	by mx.easyname.com with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paroga@paroga.com>)
	id 1rqaBl-0002RN-8H; Sat, 30 Mar 2024 15:00:13 +0000
From: Patrick Gansterer <paroga@paroga.com>
To: dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Cc: Patrick Gansterer <paroga@paroga.com>,
	Lee Jones <lee@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@ucw.cz>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v5 0/2] backlight: Add new lm3509 backlight driver
Date: Sat, 30 Mar 2024 15:59:23 +0100
Message-ID: <20240330145931.729116-1-paroga@paroga.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Easy-Autoreply: EN

This is a general driver for LM3509 backlight chip of TI.
LM3509 is High Efficiency Boost for White LEDs and/or OLED Displays with
Dual Current Sinks. This driver supports OLED/White LED select, brightness
control and sub/main control.
The datasheet can be found at http://www.ti.com/product/lm3509.
---
Changes in v5:
  Renamed lm3509_bl_led_pdata to lm3509_bl_led_data
  Set backlight_properties.scale to BACKLIGHT_SCALE_NON_LINEAR
  Add dev_err_probe() for first write to a register
  Use dev_err_probe() instead of dev_err()

v4: https://lore.kernel.org/all/20240310135344.3455294-1-paroga@paroga.com/

Changes in v4:
  Use backlight_*() to access backlight_device
  Do not set backlight_properties.power

v3: https://lore.kernel.org/all/20240309132521.1290173-1-paroga@paroga.com/

Changes in v3:
  Improved device tree bindings documentation

v2: https://lore.kernel.org/all/20240308215617.1729664-1-paroga@paroga.com/

Changes in v2:
  Add device tree nodes for each output
  Addressed multiple smaller review comments

v1: https://lore.kernel.org/all/20240302212757.1871164-1-paroga@paroga.com/

Patrick Gansterer (2):
  dt-bindings: backlight: Add Texas Instruments LM3509
  backlight: Add new lm3509 backlight driver

 .../bindings/leds/backlight/ti,lm3509.yaml    | 139 +++++++
 drivers/video/backlight/Kconfig               |   7 +
 drivers/video/backlight/Makefile              |   1 +
 drivers/video/backlight/lm3509_bl.c           | 340 ++++++++++++++++++
 4 files changed, 487 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,lm3509.yaml
 create mode 100644 drivers/video/backlight/lm3509_bl.c

-- 
2.44.0



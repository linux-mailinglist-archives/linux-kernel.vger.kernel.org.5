Return-Path: <linux-kernel+bounces-12221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5CA81F183
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 20:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A517283C57
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 19:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292CE47F45;
	Wed, 27 Dec 2023 19:06:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mxout017.mail.hostpoint.ch (mxout017.mail.hostpoint.ch [217.26.49.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0188447A63;
	Wed, 27 Dec 2023 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stefan-gloor.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stefan-gloor.ch
Received: from [10.0.2.44] (helo=asmtp014.mail.hostpoint.ch)
	by mxout017.mail.hostpoint.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2 (FreeBSD))
	(envelope-from <code@stefan-gloor.ch>)
	id 1rIZBW-000BDR-1t;
	Wed, 27 Dec 2023 20:03:18 +0100
Received: from 157.20.79.83.dynamic.wline.res.cust.swisscom.ch ([83.79.20.157] helo=thinkpad.localdomain)
	by asmtp014.mail.hostpoint.ch with esmtpa (Exim 4.96.2 (FreeBSD))
	(envelope-from <code@stefan-gloor.ch>)
	id 1rIZBW-0000IA-1H;
	Wed, 27 Dec 2023 20:03:18 +0100
X-Authenticated-Sender-Id: code@stefan-gloor.ch
From: Stefan Gloor <code@stefan-gloor.ch>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	corbet@lwn.net,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stefan Gloor <code@stefan-gloor.ch>
Subject: [PATCH v3 0/1] hwmon: (sht3x) read out sensor serial number
Date: Wed, 27 Dec 2023 20:00:35 +0100
Message-ID: <20231227190036.20725-1-code@stefan-gloor.ch>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Vs-State: 0

The temperature/humidity sensors of the STS3x/SHT3x family are
calibrated and factory-programmed with a unique serial number.
For some sensors, this serial number can be used to obtain a calibration
certificate via an API provided by the manufacturer (Sensirion).
Expose the serial number via debugfs.

Changelog
=========

v2 -> v3:
	- Remove #ifdef for debugfs
	- Add debugfs cleanup
	- Do not expose serial number if read fails

v1 -> v2:
	- Change from sysfs to debugfs
	- Add documentation improvements

Stefan Gloor (1):
  hwmon: (sht3x) read out sensor serial number

 Documentation/hwmon/sht3x.rst | 11 +++++++
 drivers/hwmon/sht3x.c         | 56 ++++++++++++++++++++++++++++++++++-
 2 files changed, 66 insertions(+), 1 deletion(-)

-- 
2.41.0



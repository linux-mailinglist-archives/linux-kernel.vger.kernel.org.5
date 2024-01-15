Return-Path: <linux-kernel+bounces-26149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE52682DBF7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3EEE1C21C86
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E4217980;
	Mon, 15 Jan 2024 14:58:13 +0000 (UTC)
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF31417752;
	Mon, 15 Jan 2024 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 0924BFFBE2;
	Mon, 15 Jan 2024 14:48:41 +0000 (UTC)
From: Max Staudt <max@enpas.org>
To: Roderick Colenbrander <roderick.colenbrander@sony.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	max@enpas.org
Subject: [PATCH v1 0/7] HID: playstation: DS4: LED bugfix, third-party gamepad support
Date: Mon, 15 Jan 2024 23:45:31 +0900
Message-Id: <20240115144538.12018-1-max@enpas.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear hid-playstation maintainers,

Could you please have a look at the enclosed patches for the DualShock 4
driver in hid-playstation, and upstream them if possible?


There is one bugfix, and a few small patches to enable third-party
controllers. They sometimes don't implement features that they
semantically "don't need", but which currently trip the driver.

For example, for the DualShock 4, we don't actually need to know the
firmware version in order to work with the gamepad - unlike with the
DualSense, which has different driver logic depending on the version.


Finally, there are two patches to add a DS4 compatible controller with
an unassigned VID/PID - I'd appreciate your thoughts on that.


If I can make it easier to upstream these patches, please let me know.

Thanks!

Max


Patches in this series:
  [PATCH v1 1/7] HID: playstation: DS4: Fix LED blinking
  [PATCH v1 2/7] HID: playstation: DS4: Don't fail on MAC address
  [PATCH v1 3/7] HID: playstation: DS4: Don't fail on FW/HW version
  [PATCH v1 4/7] HID: playstation: DS4: Don't fail on calibration data
  [PATCH v1 5/7] HID: playstation: DS4: Parse minimal report 0x01
  [PATCH v1 6/7] HID: playstation: Simplify device type ID
  [PATCH v1 7/7] HID: playstation: DS4: Add VID/PID for SZ-MYPOWER



Return-Path: <linux-kernel+bounces-56776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F9884CF03
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4C9284402
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DFF1E527;
	Wed,  7 Feb 2024 16:37:39 +0000 (UTC)
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A42446C8;
	Wed,  7 Feb 2024 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.239.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323859; cv=none; b=Ir3V5S7BtxV5cEBfxOnCqvtNPGpAHtxQlNaJkNHVCzd7I6+WiZiL084ybBJbKrOwGWs3S34ji8hzFA6A9E/E4fGct3g+IaSDMjSilqtnv8176bguJpqb8IsP8kJkP5bYBGQTp4CrCT3Va6wEI7GHFPpWj6zKppq6AC4rsDNWnoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323859; c=relaxed/simple;
	bh=XTPLse/pxfLkpk4yC3Bfz0Q5NTTh2ZLPQ8tOGCr2Onc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LwsarsAUpkFMuF8uvR/dLCPFJDq1FVonJFNt4I+0JFPBDUbuJAgTzqeFYUEmf6/piIaWphB6plF+VNnY8D/ykC/OSrRLe03BiPdOfxqJ1FLDe2wQ27i0swODfXUxjkt6U6+MumHwOu+W6Jrjt90K5LR6TuOh8KBDBKmKnzYCoAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.239.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 86550100072;
	Wed,  7 Feb 2024 16:37:26 +0000 (UTC)
From: Max Staudt <max@enpas.org>
To: Roderick Colenbrander <roderick.colenbrander@sony.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	max@enpas.org
Subject: [PATCH v2 0/5] HID: playstation: DS4: LED bugfix, third-party gamepad support
Date: Thu,  8 Feb 2024 01:36:42 +0900
Message-Id: <20240207163647.15792-1-max@enpas.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear hid-playstation maintainers,

Here is v2 of my patch series, with the discussed changes.


Differences since v1:
 - Dropped patch for 7545:0104 (SZ-MYPOWER controllers)
 - Dropped patch for DS4 clones without a MAC address on USB
 - Changed hid_err() to hid_warn() where things are no longer fatal
 - Simplified goto as return in minimal report parsing


I've included the patch to simplify the PID/VID mapping to controller
types, since the previous discussion made it sound useful for future
support of second-party controllers. Please feel free to drop it if you
don't think it's relevant now.


Thanks for your feedback!

Max


Patches in this series:
  [PATCH v2 1/5] HID: playstation: DS4: Fix LED blinking
  [PATCH v2 2/5] HID: playstation: DS4: Don't fail on FW/HW version
  [PATCH v2 3/5] HID: playstation: DS4: Don't fail on calibration data
  [PATCH v2 4/5] HID: playstation: DS4: Parse minimal report 0x01
  [PATCH v2 5/5] HID: playstation: Simplify device type ID



Return-Path: <linux-kernel+bounces-158189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFAA8B1CB9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE302834C1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A937318A;
	Thu, 25 Apr 2024 08:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbgcNhtO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3E24205D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714033350; cv=none; b=pfN2oyCb0P9/0DHofwOzFK/BSYPzxMvGbLq6fQkklKwpHzpxFC/0U2T+9raAqMErSPNJ1UsQG0Nshl5l/Bp/tHj7LRmhDy7i/U2W9wzf6g2vqJ8lgP+9GNwtHirEoEL3cZbIUZTkRuqLaDEZ9e8sjZF8ZVP5AkD3aaL/ySuPry8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714033350; c=relaxed/simple;
	bh=Yg0RcDhpW4vOtGjDRTy+z9fU3XMxEFXXN1NVXx/8bwE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oki91vcfwP/QeFAVj2Cg2tI5YmrYMCsUC0552E2Nn0/BvtkIG0OZyolZ/QKejOtHnQej9bD/2+OBJOdtdM7CVZBcLj1lBZS4ZoYR9iwk2fpuQdzeAZkS5lPh4T+OlFSo8v8WMUrTJOdlszV46ScWP3j4wNZ6+hMizHOMtriR9LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbgcNhtO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB03C113CC;
	Thu, 25 Apr 2024 08:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714033350;
	bh=Yg0RcDhpW4vOtGjDRTy+z9fU3XMxEFXXN1NVXx/8bwE=;
	h=Date:From:To:Cc:Subject:From;
	b=mbgcNhtOr3KvB6HDgnKHYitpvxBKg3qieEDs5p7OBUarAfzRBNKKTFD9sdELOJvL7
	 lJSqrQpF2nwoLbyHhLA4JXvgNF6yIveIlGNW+23G2gvoBkKvQrChjy4XrcszkOA9v4
	 FVdkvPxC8xQj15q+JTQVEI0T9v4ljXe7PqjLSOoxHq4jnhIKZUATnc1emeLqbMgeYB
	 4+TyrhxZaKUJjdAia2+2vXxDpWe2ZCNmZ6AvyTH685SVYxTcOIK4VY0T7tk8qb0wMS
	 uv4hCVMmaGlT3vnLsNJf6PMJEnSoeCU9n0yTwSOrIOXzVqZ/ntIn1swaxacHEz4CuY
	 Q0cHTcvW3kxPA==
Date: Thu, 25 Apr 2024 10:22:26 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes for 6.9
Message-ID: <gj7iqr5pqrdolfrq7zwbj4uybipp64kj7nqphqovq4ixraefbx@rfda346sojjw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2024042501

to receive HID subsystem fixes, namely:

=====

- A couple of i2c-hid fixes (one of them being the one Thorsten told you
  about - sorry for the delay) (Kenny Levinsen & Nam Cao)

- A config issue with mcp-2221 when CONFIG_IIO is not enabled (Abdelrahman Morsy)

- A dev_err fix in intel-ish-hid (Zhang Lixu)

- A couple of mouse fixes for both nintendo and Logitech-dj (Nuno
  Pereira and Yaraslau Furman)

- I'm changing my main kernel email address as it's way simpler for me
  than the Red Hat one (Benjamin Tissoires)

=====

Thanks.

----------------------------------------------------------------
Abdelrahman Morsy (1):
      HID: mcp-2221: cancel delayed_work only when CONFIG_IIO is enabled

Benjamin Tissoires (1):
      MAINTAINERS: update Benjamin's email address

Kenny Levinsen (1):
      HID: i2c-hid: Revert to await reset ACK before reading report descriptor

Nam Cao (1):
      HID: i2c-hid: remove I2C_HID_READ_PENDING flag to prevent lock-up

Nuno Pereira (1):
      HID: nintendo: Fix N64 controller being identified as mouse

Yaraslau Furman (1):
      HID: logitech-dj: allow mice to use all types of reports

Zhang Lixu (1):
      HID: intel-ish-hid: ipc: Fix dev_err usage with uninitialized dev->devc

 .mailmap                            |  2 ++
 MAINTAINERS                         |  4 ++--
 drivers/hid/hid-logitech-dj.c       |  4 +---
 drivers/hid/hid-mcp2221.c           |  2 ++
 drivers/hid/hid-nintendo.c          |  8 ++++----
 drivers/hid/i2c-hid/i2c-hid-core.c  | 38 ++++++++------------------------------
 drivers/hid/intel-ish-hid/ipc/ipc.c |  2 +-
 7 files changed, 20 insertions(+), 40 deletions(-)



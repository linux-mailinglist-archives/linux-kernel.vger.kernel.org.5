Return-Path: <linux-kernel+bounces-32862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA24E83610A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0561C23426
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840C0495C5;
	Mon, 22 Jan 2024 11:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEVDK4S3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67FE48CED;
	Mon, 22 Jan 2024 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921542; cv=none; b=NXhbMbv3+drrQXcO8okgPRNYnQa1vMzPLPY98XCIrl/Xqg2gTImwbmd2Qs/SWtuf7ROjnCdVWJayhJI7WhfPq0UngHAhUg7HZ+WDmTwH3pDf23KgolrVJv/Sh/afhWY6xAqWSPijuY9zzlIDYjmQP3kIGIkZoxB79nur9fNJo00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921542; c=relaxed/simple;
	bh=PNbtJZXcgSDfB9xk9l5CL+n1+oj48eBhvhkVHBH+k0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPsLMcPaywCsi2xXo3hUhmJTpCCkSGYDClib3jRgvmPv/KEMP6Ong2QizBUA61InMwkaann6PUo8stCuWofuxcTkmI95aWJhwwyVER8TOUxw/9NxncsX7JwMXY1aTzZKo+g472Z607uhDL3KiL9tFPn2W5HcHbhuUAA1HC1RK08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEVDK4S3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F34C43394;
	Mon, 22 Jan 2024 11:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921542;
	bh=PNbtJZXcgSDfB9xk9l5CL+n1+oj48eBhvhkVHBH+k0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TEVDK4S3pi9aHh2qIUZ8YthAxfDTy1qpxHhBe04Mu9HGxtpePJsIRZ71LlgJraCdb
	 PPi55hzg59GxoAhBAvQ7mfIv4w2ML59x2/ZLpM8bnS1L/ur/FI3v8KlkIpSaScRrVg
	 N8CvndJ3hxW7VGPRivNSHiNUj9ITCULL8uZQ4kBL5mox2uNkBo6tbw13L2Bsj6S2oE
	 YejjWEJ+vZXvc6EU+wmpIDl1VOvkEjYJpk2U/nbbUSj7wYysCXLLzeGMB10RcubNK6
	 J9GCryGA01Q6m2iGNjoZ2OfsCM5B0uwzMj657ick0Sd4CqE+f8QCotcLXhaaF7k5lw
	 4Yeg2733bQCeA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 47/47] Documentation: add console.rst
Date: Mon, 22 Jan 2024 12:04:01 +0100
Message-ID: <20240122110401.7289-48-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122110401.7289-1-jirislaby@kernel.org>
References: <20240122110401.7289-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, that the console kernel-doc is in better shape, include it in the
tty/ docs.

It's not supernice, but it is what it is. At least for the beginning.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/driver-api/tty/console.rst | 45 ++++++++++++++++++++++++
 Documentation/driver-api/tty/index.rst   |  1 +
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/driver-api/tty/console.rst

diff --git a/Documentation/driver-api/tty/console.rst b/Documentation/driver-api/tty/console.rst
new file mode 100644
index 000000000000..4348e36cd33b
--- /dev/null
+++ b/Documentation/driver-api/tty/console.rst
@@ -0,0 +1,45 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======
+Console
+=======
+
+.. contents:: :local:
+
+Struct Console
+==============
+
+.. kernel-doc:: include/linux/console.h
+   :identifiers: console cons_flags
+
+Internals
+---------
+
+.. kernel-doc:: include/linux/console.h
+   :identifiers: nbcon_state nbcon_prio nbcon_context nbcon_write_context
+
+Struct Consw
+============
+
+.. kernel-doc:: include/linux/console.h
+   :identifiers: consw
+
+Console functions
+=================
+
+.. kernel-doc:: include/linux/console.h
+   :identifiers: console_srcu_read_flags console_srcu_write_flags
+        console_is_registered for_each_console_srcu for_each_console
+
+.. kernel-doc:: drivers/tty/vt/selection.c
+   :export:
+.. kernel-doc:: drivers/tty/vt/vt.c
+   :export:
+
+Internals
+---------
+
+.. kernel-doc:: drivers/tty/vt/selection.c
+   :internal:
+.. kernel-doc:: drivers/tty/vt/vt.c
+   :internal:
diff --git a/Documentation/driver-api/tty/index.rst b/Documentation/driver-api/tty/index.rst
index b490da11f257..c1ffe3d1ec46 100644
--- a/Documentation/driver-api/tty/index.rst
+++ b/Documentation/driver-api/tty/index.rst
@@ -38,6 +38,7 @@ In-detail description of the named TTY structures is in separate documents:
    tty_buffer
    tty_ioctl
    tty_internals
+   console
 
 Writing TTY Driver
 ==================
-- 
2.43.0



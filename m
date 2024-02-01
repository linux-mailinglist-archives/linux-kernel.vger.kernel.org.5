Return-Path: <linux-kernel+bounces-48045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3D7845698
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E54BB24BBA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5925F15F32A;
	Thu,  1 Feb 2024 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hyig5QNm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978D115F313;
	Thu,  1 Feb 2024 11:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788412; cv=none; b=Lm5Pivo5Dc4Y5mY8ZfEQvcRPRUSbWkcTyentAWnr/YHmL8it8D3/P7u5QXoNYdweh2nbW5Y+bm2KmXdZR2KBVreWGxfJ+ZDvL1JPRLC/m3qErO2/X5Cgc0kgaB/05F1MlQAtwFrVQUKSKIYcFq1mVqRPQbrVzZ4yVlgxwopYTwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788412; c=relaxed/simple;
	bh=+uVdvJGsc8lGb6YyNtoRve9i5Z0FqJFy9u1zLI/NIAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvO1xjtSomZHHi3CHiCzG+mvpPFx43d1xohbFWSRkwy1WaeL3tVqzWSCM5xzPf0PfCKUjy1mtuuZOhM9N/sdxE+ut+DGpcTtuckXQtkQN8tlhvb98T6L/tjHqoywGv+evimDbgddidZ1I6Fn0uRzz5LxqZ9LjS+MCcD7eyN2As8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hyig5QNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A441CC43399;
	Thu,  1 Feb 2024 11:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706788412;
	bh=+uVdvJGsc8lGb6YyNtoRve9i5Z0FqJFy9u1zLI/NIAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hyig5QNmLrPTECu94ugQSjEwP01vifZIkEi9RiqpwxC+MlWfnD6EqvT00Qr5Gnw1G
	 ReR+GN9u3Kr0tZj+OQ8t8cY+92ctBglpPzJRxqMBOJzwrxAjvcSkfTTH6vUv6P5c21
	 E3cspd+wUUQy70nTvdCwQVykgBJFHkb7oW5dcE7aCjdnp481BwYGuAfUewvNNqdH9M
	 dGMuy/IhWsgJwRMuGkk6zwF8XF45b2Rnf8+jm9ZYAgYpsE8wNCM95vMTDNobKjC6Hv
	 UZcOhYzw+fjA9UvwvPFmNBKdhwuofXPrcc3KhXCG7CiuoE6zX6b+qGMxMsvTQ2+Reu
	 d2VtJ59ZJx9ow==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Gary Stein <LordCnidarian@gmail.com>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 4/7] HID: hid-lg3ff: remove unused struct lg3ff_device
Date: Thu,  1 Feb 2024 12:53:17 +0100
Message-ID: <20240201115320.684-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201115320.684-1-jirislaby@kernel.org>
References: <20240201115320.684-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct lg3ff_device is present in the driver since its addition by
commit 74f292ca8c7a (HID: add driver for the Logitech Flight System
G940).

But it was never used, remove it.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Gary Stein <LordCnidarian@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-lg3ff.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/hid/hid-lg3ff.c b/drivers/hid/hid-lg3ff.c
index b7e1949f3cf7..109735b89b7a 100644
--- a/drivers/hid/hid-lg3ff.c
+++ b/drivers/hid/hid-lg3ff.c
@@ -41,10 +41,6 @@
  * I'm sure these are effects that I don't know enough about them
  */
 
-struct lg3ff_device {
-	struct hid_report *report;
-};
-
 static int hid_lg3ff_play(struct input_dev *dev, void *data,
 			 struct ff_effect *effect)
 {
-- 
2.43.0



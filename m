Return-Path: <linux-kernel+bounces-151602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A0B8AB0FE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BB461C22D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06FF12F58E;
	Fri, 19 Apr 2024 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCYZbVvR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB4612F38C;
	Fri, 19 Apr 2024 14:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538081; cv=none; b=h5dIQerB48b6+CnrSsCw+BRnJncsdby9+0Velvs/tuVx0WGVjmetComzKGqbaDAoU3uuNPZ5vlhlBl7EkyOSjt9a/33/bGag2WCDP+ATZgnzgzG3OPgNbs21Xj8S3bo5TBqCAjG0bLjPmRl5IbYJTIcQg/m8SHSBVHCNVx7OVj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538081; c=relaxed/simple;
	bh=04Zb97cdbjMlae6r4F3dTKaH5KftkuQ84e3WYGNsYLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EFjLoHnw+xqzcXognQS/6ohtAHMq8slCOnyilHmGxPOaSJLPcM4JZGqxIes4D+wS1YIx9msqF3j0Z1wqs7LCnwD31mbKmAna/jsdaMAWTymUZ6/R2P5IIkWgpaxCo7ELC1Uzew5jikLDiXnWg+v1Vi680mIho9yntVTXPX19Q88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCYZbVvR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57788C3277B;
	Fri, 19 Apr 2024 14:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713538080;
	bh=04Zb97cdbjMlae6r4F3dTKaH5KftkuQ84e3WYGNsYLs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GCYZbVvR+1L//Icu5z8sFMdYKIR1ejBxfDJ1NZBGkulj230FA8h4+EPI8l+sRgcfo
	 uXnel7+7nPOK8D3PPxAdFvSVwF3EhB9BqILKGtm0bORqAli2/+fRGXa3bza0ypI5gz
	 ZAPCzJShrHit4gRUSYkocUZPhbsR9FuozJKge/7WekX7fpqtfuGIlwK9GWgUkDnJvO
	 QXvS6XDrBOB/OUhE3d/J9Adfdm57q7dr8CKAed4Q3e6rlZyZ096ebQEAZ73UChRV4J
	 33+lV36Xt6Gx3mNu0V0G/rmr7SrFHENrqX/Fpl6OIRZj5BldTAzK+X869Aa7c2RIz+
	 /07EJW/fSFsjA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 19 Apr 2024 16:47:51 +0200
Subject: [PATCH 1/3] HID: bpf: fix a comment in a define
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-hid_bpf_lazy_skel-v1-1-9210bcd4b61c@kernel.org>
References: <20240419-hid_bpf_lazy_skel-v1-0-9210bcd4b61c@kernel.org>
In-Reply-To: <20240419-hid_bpf_lazy_skel-v1-0-9210bcd4b61c@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713538077; l=1167;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=04Zb97cdbjMlae6r4F3dTKaH5KftkuQ84e3WYGNsYLs=;
 b=yLZ6mBpSWzokrza1a7v3QlUhFGuN9C1xEmWUI8JWBzWdcwBt3E4fKUw1/HRIw4va9+O7OzF8T
 fwt0eP57nY0CaR4JVgUmn/6lMaog/3V6Bck7G0WQCXtd3pPuuT3NxoB
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

It compiles fine, but my editor is troubled by this.
Makes things clearer by putting the comment above the #define, this
way we are sure it all goes well.

Cc: stable@vger.kernel.org
Fixes: f5c27da4e3c8 ("HID: initial BPF implementation")
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/hid_bpf_jmp_table.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_jmp_table.c b/drivers/hid/bpf/hid_bpf_jmp_table.c
index aa8e1c79cdf5..89496aabbe15 100644
--- a/drivers/hid/bpf/hid_bpf_jmp_table.c
+++ b/drivers/hid/bpf/hid_bpf_jmp_table.c
@@ -19,10 +19,10 @@
 #include "hid_bpf_dispatch.h"
 #include "entrypoints/entrypoints.lskel.h"
 
-#define HID_BPF_MAX_PROGS 1024 /* keep this in sync with preloaded bpf,
-				* needs to be a power of 2 as we use it as
-				* a circular buffer
-				*/
+/* keep this in sync with preloaded bpf,
+ * needs to be a power of 2 as we use it as a circular buffer
+ */
+#define HID_BPF_MAX_PROGS 1024
 
 #define NEXT(idx) (((idx) + 1) & (HID_BPF_MAX_PROGS - 1))
 #define PREV(idx) (((idx) - 1) & (HID_BPF_MAX_PROGS - 1))

-- 
2.44.0



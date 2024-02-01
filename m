Return-Path: <linux-kernel+bounces-48047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B2784569C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54971F2876B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A443B16088A;
	Thu,  1 Feb 2024 11:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYzKW59E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78B316087C;
	Thu,  1 Feb 2024 11:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788416; cv=none; b=pooCKNWg5F9e2PAaqqZ+/Tcta+OP5aCsJBUW6hYn585KovafUsYbfSy+o3IzYiWH0ZI5BWPANuaj9kEMHcil+SUVtoWIiBJc89zVXXGFCMzuYUZhiVyuv6LDtn5Evgj/7uZWbaa7O8vRmLaxRh8d/rQTPdSEufKDGI8RhJO1bkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788416; c=relaxed/simple;
	bh=KC8IA2sZ4Q6/pjsCkvWOZBM/6wtRJa6iv38OQYpmdNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PaXTkGC1lthaYK2mOaJJF1gOpNDqcbFZJ9TUTymniMmD4PjYU0siPak95ZbrdQTWhvgxCXgZB23VTmhnnLq0DHQADvo8ndpTNaQ5OzcRAQVs2PV5Gdn5Dc+tyxVS5UtJUxjF8wahbntki99OrpJHUc8lmHJq9CO1yvURmQiYV24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYzKW59E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301B6C43390;
	Thu,  1 Feb 2024 11:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706788415;
	bh=KC8IA2sZ4Q6/pjsCkvWOZBM/6wtRJa6iv38OQYpmdNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RYzKW59Ev2DvITPm48/8Wp5sZkRd6+6PW6VCkoM7Sa6PnY/ZZobqgjdAEVhzCVQEI
	 RNxV9LhRc2A2CQe5uN7cFi2+JXIc4JbbjIdkaKHd7Xo8XvEjWMmTSCuJ+XTWjJYJ3c
	 WQVPlwe9IhMCxR7zqcGQ8QXpqRtXHmIym0G1KiuvoFmtvmuNXgCX79LIcdoiA4IZfI
	 olN8dy/MpA6COL3FS/7XzR9K+IM/bCoMrfJgdVo7BoU/zdPQGDZ4K36DETn8NCs/tN
	 mNiGx5DdxwBqWMVi3Pcf5rLfhS64bEKJhSobWhJzHge+lK9Lp7ix+m7mQc+l57Pr62
	 bVIH4IlGV2ZYQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 6/7] HID: hid-prodikeys: remove unused struct pcmidi_snd members
Date: Thu,  1 Feb 2024 12:53:19 +0100
Message-ID: <20240201115320.684-7-jirislaby@kernel.org>
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

struct pcmidi_snd contains two unused members: out_substream and
out_active. They were added along the driver in commit 3a370ca1dcf8
(HID: Prodikeys PC-MIDI HID Driver), but not used.

Drop them.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-prodikeys.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index c16d2ba6ea16..439f4320f1d2 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -66,9 +66,7 @@ struct pcmidi_snd {
 	struct snd_card			*card;
 	struct snd_rawmidi		*rwmidi;
 	struct snd_rawmidi_substream	*in_substream;
-	struct snd_rawmidi_substream	*out_substream;
 	unsigned long			in_triggered;
-	unsigned long			out_active;
 };
 
 #define PK_QUIRK_NOGET	0x00010000
-- 
2.43.0



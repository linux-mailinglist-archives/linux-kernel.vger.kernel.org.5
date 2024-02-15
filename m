Return-Path: <linux-kernel+bounces-66958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D73856415
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C55E31C221E0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7092412FF69;
	Thu, 15 Feb 2024 13:12:34 +0000 (UTC)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF6212F387
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708002754; cv=none; b=KfFO6r/v+LyZyfH7Xs4iitKEt8WFRz93pq1DtaD1ElyPfycO/Wh4F220ewobZ8ABClinOliggrAUVbZRon9Ykr2ZDT4x18tbL87L3u22JRmI4Nbd8vjKvqInwI9/ro9grzZwIK95e3cGTUTFRrP0vGPPLMeerApbJ60LK+7M4Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708002754; c=relaxed/simple;
	bh=U/PG3zQXQ/kc1NLVZllKDbhYLsIvPRKZE8dAnhNuW/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nPZcKkCnIhHa6Qy4O23t3AsmHHlAV1MhjAIv76m7A2FxWSEH7T6rmamPsUERaq/Zk8FkcJawcMOvw7OrXHk2cBMVcaWh2cT6ATsxhtCM8QwVFVEGb7nn2dnAbmPnxkDfPnQj1Oa8pa4u1ZXEzmqbHx0lOmL+wowucCfWAfbYmJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:ac52:3a54:2a84:d65a])
	by albert.telenet-ops.be with bizsmtp
	id nRCP2B0040LVNSS06RCPAP; Thu, 15 Feb 2024 14:12:23 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rabXD-000gyC-NR;
	Thu, 15 Feb 2024 14:12:23 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rabXL-00HZSw-2k;
	Thu, 15 Feb 2024 14:12:23 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH RESEND2 net-next] tcp: Spelling s/curcuit/circuit/
Date: Thu, 15 Feb 2024 14:12:21 +0100
Message-Id: <edf02e55949ac00329a6df72940cc2f5e8bec55e.1708002686.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a misspelling of "circuit".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 net/ipv4/tcp_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 2d20edf652e6cb5e..dd2656b63c3942f9 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1164,7 +1164,7 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
  * L|R	1		- orig is lost, retransmit is in flight.
  * S|R  1		- orig reached receiver, retrans is still in flight.
  * (L|S|R is logically valid, it could occur when L|R is sacked,
- *  but it is equivalent to plain S and code short-curcuits it to S.
+ *  but it is equivalent to plain S and code short-circuits it to S.
  *  L|S is logically invalid, it would mean -1 packet in flight 8))
  *
  * These 6 states form finite state machine, controlled by the following events:
-- 
2.34.1



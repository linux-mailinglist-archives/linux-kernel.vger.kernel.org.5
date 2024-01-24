Return-Path: <linux-kernel+bounces-37463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BACBF83B064
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6CB1F224E5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C148312C537;
	Wed, 24 Jan 2024 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFLgSbjF"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861DC12BF1C;
	Wed, 24 Jan 2024 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118451; cv=none; b=eTWWb/w1oD8WTxZPvt0L14wgMVGjvPcll3zaNugRzHWmW8ZOd3Nc0+IArcJHCp/Mk69aeEnq/5qWTO7985oT00mW/itIlPLrAvDpvm61Nb/V1iEf2NEw05o0YHIfUuXyfECE0m3/ivveRGg+YM+Ffw1O8byOC/1VdpfL/jATZyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118451; c=relaxed/simple;
	bh=lbjcvJlqREfcesgrRYGDA24BL5PppwaqOFgHWCceX3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6nee3ySPvwEu4+JdqdyqpE10vqbGsemuoWeoTTm1dTJ429DocqsBdepyG623hSgXGVR3/yk9PVqWy2vW1EYqCLXzDScFrzFUX4w13VUCG6xwBMSeOoGhEVizHNwuIFtGpAckLk+PGSg0KnHPngDcUVWBErajGm8jISpbZhTM6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFLgSbjF; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-59612e4a21eso2317880eaf.3;
        Wed, 24 Jan 2024 09:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706118448; x=1706723248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjKj9EzdAuWyK4cN+spXyTYM3d7/eJ9KCYgY9YiMv00=;
        b=HFLgSbjFUqCtWfBfxpQzrrPVNmc6+r3ZgTrqiPk3+dHQkdx23Y6HL8COkFD8o5aL+0
         iUwkU35UjiWCkRn+vHwgFBy6SVyhwmgQsxAziHNSyqrVSREoiutdzlBjkE+fod87woNM
         7d2XxwOLuuNzgjZHy1045m2gDsTn50jTa+Yhz/cWNt3c1rrqS/yv5AQkV6acqVyMXMXZ
         FN9tqY+RWs7fHuutgbNgpIOKXjb2zQjGGup9fUyEJbWg7hFSgUaDYIoUUIhVobukabze
         yO8gJ9O5xerPPzkXRCN+FKt5m34vdosCkXbDcS+cbTI39UCbZM30/Tz860n2R/kraPQj
         aSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706118448; x=1706723248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjKj9EzdAuWyK4cN+spXyTYM3d7/eJ9KCYgY9YiMv00=;
        b=Km+3oBXCDF8+H5qTUvFOE+3BffV/hZUoo6oLXUegdU18x8YT7QjkH2GLAdwEJcrLbU
         ybHNdqPmgyfXCq4qEiMgzzJoVi1FsocW8rjZ8N8lvwWDM6NUQ2OH8PRuZ/MQAz9yMcfD
         ne+ESvZbJg27ofVdOC9fYqFvab4OlHajmt3n+P1MNqzgM5BZGkPLRT2z2ffkfirgM3ZJ
         PS2c2hMZsBk374NXFOE0PI1NnYqqq6Egu+u6JZD6uIPw0zAUkDW3QkaeI5a9GDVxde7A
         mmSh/MC+yWEkWOcTWzM+i1kLBmvA80rhLBsqFiHjmbOqYJxqOjtgaPJPU76OgFEK3Caf
         ynuA==
X-Gm-Message-State: AOJu0YzDSpgKXGu5tOfm5QKEirc2qOFvWAl3BsNzvkI3B03uP19L12y0
	5FOlDGc3KwPQxMeZOSk2EpA5jcX1zLKG7ieLycjnym75QR4vWeVa
X-Google-Smtp-Source: AGHT+IGkRC5yDjunMYDK5Hc1NLJvSXtwh/QkmR8qEyZ6fdiMMd6Y9AgVt8qJiEKKYW3B41dQAlKX2Q==
X-Received: by 2002:a05:6358:ee46:b0:176:277d:3487 with SMTP id ik6-20020a056358ee4600b00176277d3487mr3703332rwb.24.1706118448348;
        Wed, 24 Jan 2024 09:47:28 -0800 (PST)
Received: from localhost ([2601:644:9380:8cd0::7fb4])
        by smtp.gmail.com with ESMTPSA id z17-20020a63c051000000b005cfbe445a85sm8446564pgi.70.2024.01.24.09.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:47:28 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: leitao@debian.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1 7/8] net: netconsole: append userdata to netconsole messages
Date: Wed, 24 Jan 2024 09:47:05 -0800
Message-ID: <20240124174711.1906102-8-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124174711.1906102-1-thepacketgeek@gmail.com>
References: <20240124174711.1906102-1-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Append userdata to outgoing unfragmented (<1000 bytes) netconsole messages.
When sending messages the userdata string is already formatted and stored
in netconsole_target->userdata_complete.

Always write the outgoing message to buf, so userdata can be appended in
a standard fashion. This is a change from only using buf when the
release needs to be prepended to the message.

Co-developed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
---
 drivers/net/netconsole.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 7de693d0773f..8df3932ef4fc 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1032,19 +1032,34 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 	const char *msg_ready = msg;
 	const char *release;
 	int release_len = 0;
+	int userdata_len = 0;
+	char *userdata = NULL;
+
+#ifdef CONFIG_NETCONSOLE_DYNAMIC
+	userdata = nt->userdata_complete;
+	userdata_len = nt->userdata_length;
+#endif
 
 	if (nt->release) {
 		release = init_utsname()->release;
 		release_len = strlen(release) + 1;
 	}
 
-	if (msg_len + release_len <= MAX_PRINT_CHUNK) {
+	if (msg_len + release_len + userdata_len <= MAX_PRINT_CHUNK) {
 		/* No fragmentation needed */
 		if (nt->release) {
 			scnprintf(buf, MAX_PRINT_CHUNK, "%s,%s", release, msg);
 			msg_len += release_len;
-			msg_ready = buf;
+		} else {
+			memcpy(buf, msg, msg_len);
 		}
+
+		if (userdata)
+			msg_len += scnprintf(&buf[msg_len],
+					     MAX_PRINT_CHUNK - msg_len,
+					     "%s", userdata);
+
+		msg_ready = buf;
 		netpoll_send_udp(&nt->np, msg_ready, msg_len);
 		return;
 	}
-- 
2.43.0



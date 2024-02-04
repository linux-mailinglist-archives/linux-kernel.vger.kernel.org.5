Return-Path: <linux-kernel+bounces-51940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE778491A4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 00:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC186B222EB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 23:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B811DA4E;
	Sun,  4 Feb 2024 23:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="al7FGddi"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DE014013;
	Sun,  4 Feb 2024 23:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707089283; cv=none; b=nmLYVGnwCKMer0RqZSt38J05P1VVxK2qMC0e2pqUUvYabXGIni+bmYde+UAVYuYDn+GZKL4A15VF48umOaoaRJL5c+TCyWcwaSTx9iMYTbLCAUI7rLCJ5JWFTxUmVAp3TwhrJTmd4889t3Viiyx3IQIN09f2c8+7M23oNAhYAGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707089283; c=relaxed/simple;
	bh=aB8zRROFhVWYDcYHzNZj+S0JB99XcbF6R0qYvHS67kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukjCrfmFwzNNTiWgSxcIPVzlFBys/Mb3f2OmWiDlOa1LGcP5Tk5aiWS7hUf5j8osxlGQY29+LdB7EKllG1rJsUTw1rcy3D3ZU5sFttI/aHpWQX8NyllJ8hqvtk57ieQoofny3Pu0TjMC6Hr8m3C9Rd+2vtaSfXpZOD6aHU/XDQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=al7FGddi; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d91397bd22so29101395ad.0;
        Sun, 04 Feb 2024 15:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707089281; x=1707694081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0HZ0i+aKOW3O7O1Lv3dQCatPUXng62ahBaIh3AoxzA=;
        b=al7FGddi9Qedf7EDw/7Oyts4kIAnoH+B80VVyfrjR3zwonEYJO4Z7rl7yycA4wYV4M
         k8OOX5upS20kONHxPWB2bn9WAegBqZpvByyoXDgePyJpdEN83+4GjJRSmUtK+z8D1IoL
         pYqaKQ1OnJ7cMhg4Yzy5FH8XAYxN+Cm+7STNSplsbzgbzVJU4OSCwFxSTkBRC8Dex8Ln
         FOw9T7k/227ai1p4SvZO4G5gT39JW4kgNS++WTY/XWVpYGHhC46+6ltH7FDBJBfj6vlD
         lu9lW4f5AxNuaENC0EyPXyin+HQ+XfMyuqPsHCVlmKN0iaOoCrBfRYD6Vhpg3ApDSURw
         dTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707089281; x=1707694081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0HZ0i+aKOW3O7O1Lv3dQCatPUXng62ahBaIh3AoxzA=;
        b=KOxiTV1h8iI8S9pwispzSw1a9jEGywvTfm/drDl39OWcw42pRvsGei+Hqhvuw1YiMV
         nChqVsWBQ6t0LZrnQontj1TQEPPVyAQybnRU1YPm40ES2w4p6HHtAmKebrvutRRzHZoc
         yyqAOaeVX2+49XTN4bmDEkWWS5PQzzjWRs/GFx/BBc47o/L7jd85MyOo0dLIgvqtIUum
         iD1A/d/DMRss+OXCHr3QcNUKxJUammpxsSm3KK5eczbDjlM0k7cBN+P3vR7tftmTE100
         pm+2E3nwH1G8rzy438gxn/dIReAgMyk9RygxV0QxMYH1kuH1TFJuyLvO6krtFPyhmvz9
         KPWA==
X-Gm-Message-State: AOJu0YyNezy3/RlYHUzIkk6pQqqmDTMtE+UAb7g0Y/DLULr0nJ8lxSNM
	JGiWcrwcDafzRb1aZy3izY9P62uM7A2qkiguxLtSGxDSqpgxVDmVGCUd+2On
X-Google-Smtp-Source: AGHT+IHfn46ZdjGEo/Iov8/bZFybBTEgn2+EPTqCUkzmjBKKL48my5XyizxM16X7B4QHkThB2B4/8A==
X-Received: by 2002:a17:902:d548:b0:1d9:3f27:42ed with SMTP id z8-20020a170902d54800b001d93f2742edmr18030547plf.1.1707089281433;
        Sun, 04 Feb 2024 15:28:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVLiIrIdj6Zlh3BPbV/OmVPoWBcbXAQ0PHsotFXEABJ2t6bSKQE1IhsGI2Dp6I8ytOKCqbZJgBljWss/+jUmssEbil5qcmR+3MoufPJAeht3+dfeEBcATBIMP8txOt/MwYz3j/KA9eGbo8DPI0ec/vzEWwE8FmC3C2ruEVeOg+RkxQ4D2TYAMPs6Lcm9c86DetWx/C0s+Jf3YI8nLTS
Received: from localhost ([2601:644:9380:8cd0::7fb4])
        by smtp.gmail.com with ESMTPSA id r17-20020a170903015100b001d705b43724sm5046081plc.169.2024.02.04.15.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 15:28:01 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Breno Leitao <leitao@debian.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 7/8] net: netconsole: append userdata to netconsole messages
Date: Sun,  4 Feb 2024 15:27:38 -0800
Message-ID: <20240204232744.91315-8-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240204232744.91315-1-thepacketgeek@gmail.com>
References: <20240204232744.91315-1-thepacketgeek@gmail.com>
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
index e4d6ba0b50ef..d53bb1172336 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1034,19 +1034,34 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
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



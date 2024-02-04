Return-Path: <linux-kernel+bounces-51941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF36C8491A6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 00:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75891281729
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 23:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F41C25745;
	Sun,  4 Feb 2024 23:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVXDo6PX"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189F51DA32;
	Sun,  4 Feb 2024 23:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707089285; cv=none; b=G/2IdFA7tl1n0CHfXfDCc0raJ4tU4RPUfKZHF30Dg9JXxzA/XVoPLU1b4WtPYsDVC7PQa425At6yWocSkTy0EQ2tAhpGFbbKICqoIhrIkS4fOV1oTZMh7wok7RQ4njD+HGc2k+Z3MA+bF8g01htSzpyAYo3rH3EvbHP/4+wwnT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707089285; c=relaxed/simple;
	bh=SSARsMhAO/CnotTOTu32poP3ZTXfjxsFKPzvMvSGpmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJNhKyrXjNUOUeeQETPBGxHMUklPwac4NuG1vdLqVqG+L15QEJP9MLE3HcXoYn7qIPo7Vl+Nj/4eh2LnFthfnst41JA2rNo5U9OIHms2mdpi9BVPunZq0323D7LEhXk+iYjS1FnuxPNdp5LqOU1RnYeGqqoOFayevwd7V3jRvYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVXDo6PX; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d7431e702dso31522935ad.1;
        Sun, 04 Feb 2024 15:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707089283; x=1707694083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXl72+2pLCBU+d11ILW3XEAr8eYnZKYv5qLeQI8w0AM=;
        b=kVXDo6PX3WisPT4+K/SpZCPksqBhx4MK0IsaSMiXQLNaRulQ+FED6xree4iNCPgsH7
         Xl5CnydzmApkTWS+dg1hOuZuVqTTga8qNRBkMjBF+ogdAfhfyFTgeyry3qwYyIhGAUmV
         41RILtRK9Srk9BdESftS9hc2FK4aQSD709LcwhLRp8kdDyweYpXC/9YaZRxbF9p8oI8P
         3ujl0A0euVBrzFWBQ+VIT8Vvcy17AOL8bU6RJe4wRtUP8ojSGc+tksBU2uKN3bZpwkxH
         wjl4ww9BAqUEa5dy+uxtu7Ru09jqmvHDJM854L4ooYRtJebZnNKOwlR5aTeSr683DFYr
         Pi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707089283; x=1707694083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXl72+2pLCBU+d11ILW3XEAr8eYnZKYv5qLeQI8w0AM=;
        b=aMj4ve4r6DhKtvjZQqfb4C5f6R0NVzGR3KtcyECAsTiSthBfpbyhBO9+/oWMhdFT7z
         YHGQmBeQMp0XdOtM3aM4bf2uMIGqDF97aGSuqFiTyTKJ/GoREV7CETiKTQa//1ka3doZ
         ShAhPPqapoC0rA5e/veMLW8WINBsO8Z2Pfx+DhDbplWa2/XK/Em6dJ5osc9cn9oFpmFI
         4c8mn3wub4KobRc9KU9c9RtHBe0JTllyfo8grRiz3rk5kttceymi0boCfrnKRCW2A6Tv
         veNPm81uia2HBbYElHRQe/feQDk9SKZw5RSjk3xWqIrhp6qwxpL4mjpGgiJKjGYmcdO2
         QHeg==
X-Gm-Message-State: AOJu0YwjUeC19aXULl6w+quYH0v7ZVTisbLHex2lV10/po66VRFhbYA8
	wiyFgoryZOc9DyHkRDZACCzzLA55/B9IG/46aIeCVUyfPEkvPGUt
X-Google-Smtp-Source: AGHT+IGRWhVYpticpjUq8/TnFBtMPXvUm7p4z6cd6YHVl4k6dh/N4pR0SUpXPcnHC98Er9N5myLxdA==
X-Received: by 2002:a17:902:f811:b0:1d9:5038:f116 with SMTP id ix17-20020a170902f81100b001d95038f116mr10955622plb.34.1707089283351;
        Sun, 04 Feb 2024 15:28:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVllZG6ovWYFRpf45jxUip1i/3By1OUOv+jD20x5+U2NbHMT4IZgLz4CKn5a5q6vF6+HHINBn2Yl1IEd9jGdG/4/GlOUytxdyjeSTNmJp6pIisorjcCnX9ejrxjLPfKSZ1/4b7pueyHmVxghcmdca+atdvevcaBPX9ufXStpEfNl+ezaLvvmVvziLR6UdIyxuTVERuoZ8dKJGBINd1O
Received: from localhost ([2601:644:9380:8cd0::7fb4])
        by smtp.gmail.com with ESMTPSA id x10-20020a170902ec8a00b001d9a40f50c4sm1494063plg.301.2024.02.04.15.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 15:28:03 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Breno Leitao <leitao@debian.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 8/8] net: netconsole: append userdata to fragmented netconsole messages
Date: Sun,  4 Feb 2024 15:27:39 -0800
Message-ID: <20240204232744.91315-9-thepacketgeek@gmail.com>
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

Regardless of whether the original message body or formatted userdata
exceeds the MAX_PRINT_CHUNK, append userdata to the netconsole message
starting with the first chunk that has available space after writing the
body.

Co-developed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
---
 drivers/net/netconsole.c | 50 +++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index d53bb1172336..0de108a1c0c8 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1085,24 +1085,48 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 	memcpy(buf + release_len, header, header_len);
 	header_len += release_len;
 
-	while (offset < body_len) {
+	while (offset < body_len + userdata_len) {
 		int this_header = header_len;
-		int this_chunk;
+		int this_offset = 0;
+		int this_chunk = 0;
 
 		this_header += scnprintf(buf + this_header,
 					 sizeof(buf) - this_header,
-					 ",ncfrag=%d/%d;", offset, body_len);
-
-		this_chunk = min(body_len - offset,
-				 MAX_PRINT_CHUNK - this_header);
-		if (WARN_ON_ONCE(this_chunk <= 0))
-			return;
-
-		memcpy(buf + this_header, body + offset, this_chunk);
-
-		netpoll_send_udp(&nt->np, buf, this_header + this_chunk);
+					 ",ncfrag=%d/%d;", offset,
+					 body_len + userdata_len);
+
+		/* Not all body data has been written yet */
+		if (offset < body_len) {
+			this_chunk = min(body_len - offset,
+					 MAX_PRINT_CHUNK - this_header);
+			if (WARN_ON_ONCE(this_chunk <= 0))
+				return;
+			memcpy(buf + this_header, body + offset, this_chunk);
+			this_offset += this_chunk;
+		}
+		/* Body is fully written and there is pending userdata to write,
+		 * append userdata in this chunk
+		 */
+		if (offset + this_offset >= body_len &&
+		    offset + this_offset < userdata_len + body_len) {
+			int sent_userdata = (offset + this_offset) - body_len;
+			int preceding_bytes = this_chunk + this_header;
+
+			if (WARN_ON_ONCE(sent_userdata < 0))
+				return;
+
+			this_chunk = min(userdata_len - sent_userdata,
+					 MAX_PRINT_CHUNK - preceding_bytes);
+			if (WARN_ON_ONCE(this_chunk <= 0))
+				return;
+			memcpy(buf + this_header + this_offset,
+			       userdata + sent_userdata,
+			       this_chunk);
+			this_offset += this_chunk;
+		}
 
-		offset += this_chunk;
+		netpoll_send_udp(&nt->np, buf, this_header + this_offset);
+		offset += this_offset;
 	}
 }
 
-- 
2.43.0



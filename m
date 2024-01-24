Return-Path: <linux-kernel+bounces-37464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2EA83B067
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B07B1F219B2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6454F12CD86;
	Wed, 24 Jan 2024 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhiUpWfX"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380C412C523;
	Wed, 24 Jan 2024 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118452; cv=none; b=JuSQwneRS3h0H3IwhMHSL7LdFARrraz3JvqrWpE8OIvtADXHc+m4IMABMptFLjS4ETvTSlC+p9Isra66YQ2LbrgHqR8C3cS6ZSefJaktCJ88vW84e5x2YFny6tiyei2YCiSVLTpwrwM2Owj4+w0fkzdHCsBXMopEBHVu69thWbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118452; c=relaxed/simple;
	bh=1guLW5LaVQcL2JOWOYaToB2yKWIxIxlvgTjPbw8dAoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/5QJEnW3RcWOcX/9ssbgUTarolyKCz9jr3tTm5tQVe5n7wwakvPCaPsLwe/d8g4M2ZtB0BCbP6LK9eKI5AB3Z6lYQ7LVOgY8caaylT1WLLcrCHCYxgd7zeMGkabAVK20Ikw0X8UjI/+j3EW/o2diz6oAhtRZuJYP2TVd0+a6Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhiUpWfX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d7431e702dso27044695ad.1;
        Wed, 24 Jan 2024 09:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706118450; x=1706723250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vzf+RsvLyT/r4LQQ0hA+PIZWqxzvX6yBhcSuFj8O/bI=;
        b=PhiUpWfXkft2sJMCaID8IER2iup0P4tfa1wGwH9G/gB5NSI//l2HavJjHduKx4qKb2
         ARVAlIJnEswJ64KszivPJfIrE8N/hl6ZPGeCpZbDbqHP0LZ2KhwlbfAG07vxYxq35j+k
         GaJh0f5J6JE1oL7wcyFeWo12FuvGR5yV5avKVlhnh1nuE7OI5cVMhZ6AnQa3NXtajL6k
         XfS/iiPQUNTRhbgbMUEYpW7Cz3EcXjmHXUjL0NySijSasr61Px6mAuo0+V/Fcq3C6r1j
         ysM4MqxXiLTS2buKiZcEGqhSwH4tMdGhWeyevn6lgfa08VkrXwXhEwTkilBkRROCiUJO
         e5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706118450; x=1706723250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vzf+RsvLyT/r4LQQ0hA+PIZWqxzvX6yBhcSuFj8O/bI=;
        b=k+LZb48NmmkyDNFuH05qGLfINODw8VyysAVvJ454d2siK/zftA8oVcgUHA8rwLo5P0
         s1+41CIr/ctl8EYrryJdLhC/xBgBzZdnirnLVnr3yG+HfSvE5t/5ZkP9dhRDMOXREB7p
         4Zm93ZkPDSfygES01aOSwI3AbrXoHPqsyY1KXAkME/7niS7jujqP6aCgkvzrX3uA9cjc
         /aPAzCtJZl3ZRZTMCDcHzGw/ZIufL0ZqG24EARC8esaaAL4C4SEpZ6IMLCeYZ9LXEG+w
         FqmUF8w6eaNBs1/9UqzmV2cVgZSR9YADShzVvuOSYAo/VbAKN00FR2PoQ6hNn8n3BkPp
         UREg==
X-Gm-Message-State: AOJu0YzJ87Zlr8pvpwgevNr0DpBhwNr88/zqbShGfEZAaOvPsI2xXZam
	gq8W/ajVGNB7tgWZ4MEfKf9JRvTpVoolmtAi0ccl84uOCpghHXKM
X-Google-Smtp-Source: AGHT+IG3PMisEeC2I4aZUGDTWqSd6n3BuwHOurjfi3k3HVXYBJlQlwiSRrlO+0qbakWfO37bjEQHww==
X-Received: by 2002:a17:902:cec2:b0:1d7:72b9:b114 with SMTP id d2-20020a170902cec200b001d772b9b114mr1268561plg.60.1706118450630;
        Wed, 24 Jan 2024 09:47:30 -0800 (PST)
Received: from localhost ([2601:644:9380:8cd0::7fb4])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902b70500b001d74c285b55sm5565938pls.67.2024.01.24.09.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:47:30 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: leitao@debian.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1 8/8] net: netconsole: append userdata to fragmented netconsole messages
Date: Wed, 24 Jan 2024 09:47:06 -0800
Message-ID: <20240124174711.1906102-9-thepacketgeek@gmail.com>
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
index 8df3932ef4fc..95e563e474af 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1083,24 +1083,48 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
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



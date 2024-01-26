Return-Path: <linux-kernel+bounces-40814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0508783E664
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5299289D94
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BB15D8EC;
	Fri, 26 Jan 2024 23:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5tZxgUi"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4571D5BAE5;
	Fri, 26 Jan 2024 23:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310849; cv=none; b=WJa7yp6/Xt2fl3gCIih8QijgeUE/Rmi0JJsXAe10PWyOQKXZFAAgcRGIqJR34ncUXS3vDTgz1vZk8VwBH9Zooth3xZeHjaWcRFE/jSH5KRt7o0he4C4WZwPuijw/AnwjKrSweTBpGypfvO4n7si0pJ2KsVMWsUKVOB7E9wWWZok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310849; c=relaxed/simple;
	bh=aKiWzgmFK3XS1BsGpO2cXonb0cWCM59n3esPDJ++t1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AIFnnaF44X4ARCLGbHVLlfFrBc5h9fnMg5DxKXs9OjQxolzAOqh1lSNF2muKrQ6DRhGZqHGkII+OKfWB1Yz1/qY/UbSDjdeTZmaXP1PluKD5G/YGd2JR+HlL/sB2/iIL559Rga7fTBQeiG5PRlMbpyKKRIsvdWGhu6ZbFU4K0Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5tZxgUi; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6db0fdd2b8fso552024b3a.2;
        Fri, 26 Jan 2024 15:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706310847; x=1706915647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=je2dXIpj4nMvLmLfnHTiHfBkXHkQg5LdUrpAF1wy3tM=;
        b=P5tZxgUid81mNNLCbZ/QlNMPUoQ4itwQzaOKdrTe7ytzhsGJoh2w3L/eMDn+D/N3T7
         2KBdZHqcLHtX0HL4DHQ+H931hYyxXUeTYkzN1ba69kImBDIDBxe4VdX23toDYqH3ncdt
         fShm6u1YhmgtA9z89mM3QxiC28PTeHJWWyaZ1PDV8o9W0Y/ChIjqOYW8A/gigjnWvjdQ
         8REiq4yHF+C7B2lwbqwrSoqmGcXiHtQXjhhuTA/nsU/LzChJBYUxsrMi4MLo0D+0BLmN
         n1/qazU9fTbCFjg3F6AQavRvOz9PaXH7dg/IlDokqmVF6zeP/VWITGur7X4feIjfROY/
         4ZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706310847; x=1706915647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=je2dXIpj4nMvLmLfnHTiHfBkXHkQg5LdUrpAF1wy3tM=;
        b=NGx9RIia+XztDKEoC3fx13Qm4B56zfuZSvGEnabHmSP5siOKzypQbuUT3pnrR/EpWn
         7hdSR+HKXSh/TLFv/ZQL5XAdvk2Wpqo5hL6DU038V85H0UShlPDK7I4iP3IVuWlMvUTl
         Rur0bKnQSfJTfnQspSaxvwPKeAbF5PCFiNbAII47ay0yfek1euYlUqM8612/TDoU9Wel
         nrcrmK9C9ZqOXdkRCWZmUp5S8zFVxXLHg1rFEydKFBvjPP1kG8V5tPbNWRIu+3/EYsZ7
         ZU/ashLdmYEw5LMZMjjF6ua0mIfiqW8T+v77jUuSjlTggGmM0DMCalv4uS87L2/3sOT+
         ZgGQ==
X-Gm-Message-State: AOJu0YzTBHRBaLMFifBW7jj8aJRt7y2vT+qCW1vZ294gM6Q/vZwsjBar
	ngZaJ656XASpz0RJdHcC8+FL0XKy6e2ed1SO5tAeKKliiJH6tzRI
X-Google-Smtp-Source: AGHT+IHVjDaF9+Isu1Qz4FPT8T2ObxNSuUgI2SQ8aEAdELBOpl+pvpVAbgBQ/4zev5FpivRpEIYaFQ==
X-Received: by 2002:a17:902:c70c:b0:1d7:38fc:1272 with SMTP id p12-20020a170902c70c00b001d738fc1272mr587369plp.75.1706310847695;
        Fri, 26 Jan 2024 15:14:07 -0800 (PST)
Received: from localhost ([2601:644:9380:8cd0::7fb4])
        by smtp.gmail.com with ESMTPSA id o2-20020a170902e00200b001d748fac506sm1446405plo.82.2024.01.26.15.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 15:14:07 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: leitao@debian.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 7/8] net: netconsole: append userdata to netconsole messages
Date: Fri, 26 Jan 2024 15:13:42 -0800
Message-ID: <20240126231348.281600-8-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126231348.281600-1-thepacketgeek@gmail.com>
References: <20240126231348.281600-1-thepacketgeek@gmail.com>
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
index 73feba0b3c93..de668a0794b1 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1035,19 +1035,34 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
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



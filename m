Return-Path: <linux-kernel+bounces-40810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A0483E65A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29C751F20F5B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383435A79C;
	Fri, 26 Jan 2024 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGyWAaVv"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E6E5A0FD;
	Fri, 26 Jan 2024 23:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310840; cv=none; b=EEd/Rsvf2G62HOdeKWSp8oYbmQuB3uOr8OgXu41n/ua3xD/qRlvffUrQztwNpS6GDMFUUvtd9mQgsnZzzQNCg1xa0uQbrOqPxHW/41XaE3KDRfqejEb3AmpgbN3YNt5TA9yks532aAqALrtbEM7wuoeBvbc2c6EUQE9/TMU1rxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310840; c=relaxed/simple;
	bh=mPmolvHAcBMTIShhgLdXXMOUD8GBeSY8wUZZNyXtmXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9wcMqFKVJGC5sn4v06DuZirv0LFh0feHyZZxn9ZONRXcKa3ISnnXVqiyVZEK/6xZ2fF51N7/aP1HvNsLJBH4NgCwRN1PP8EYk4tj/FU9meEdklyjn/RMhv35T0YR/JfgtfAAARa+UFn14TEL5y/y4FA5NgLfxx4Um5UFYuxou4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGyWAaVv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d89518d3b1so5883815ad.0;
        Fri, 26 Jan 2024 15:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706310838; x=1706915638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZZIgE9h2jQLSmHO3bzM7GbmlOxYLfQCD/fuB/DQM9s=;
        b=hGyWAaVvZQNrrxP7Un4wFXI8kbYJUSEBvlY0oQg+18okqMTikxGrl2uVcgyhnljyz0
         Ol+zVxwsqtirwthPvkoDrgMzv1sfotWsON3rqRLQUJl8FNgmzdDZe5rcC0SjIAhx7shp
         2BbB6b5+D9E6wMAQIUhfPNTXt33kpx3dMV834Ofg3VUQ8biR0h7U/c30RJSB+gqqELVb
         mx2hLR+VrH+s5MTnD+yFaThi9GK0gbdTx7pm43jknVPOTIRwu5yQ0hnnKLLJgUSgJHir
         /owYo9DUpM2jM+k75Qht8vzlX60EUTsytRmlkIJtG1zkuAGjjxJePgKqFKUwxUTGIv0o
         Fg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706310838; x=1706915638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZZIgE9h2jQLSmHO3bzM7GbmlOxYLfQCD/fuB/DQM9s=;
        b=OAh1EvnhEbemyLxY/+OS93NslwVxZF4Un+31WpAGRw1ytEV0SApB0KjaScnNtziCeC
         r22LTiA5KK3L7pqftU16z4sRJ6PYamYxxHTG8yApnXe1F47pFE/yPiOfXq3qETQiawOX
         3Gum26AaCcA++PZsQjB9+FATpNUCQmpuKlH/0yrsDuq7kgQ/UgU6Jf5w8BETg/DOr2ds
         XSOLabA4Xr1rBl+gd6F/1dbzDmtDOZ7ASCYzQf4fDJD1PzXRzz65AY/75GXz0D019LFW
         5+vBAeWouG4S3VJt9lJtRd58ETf6eJBhSyqcZ4jQXktdlN1h5Urcyjanp2xHtg2SWysY
         LDGA==
X-Gm-Message-State: AOJu0YwBfgW6m5wHOvq6YnNbXSW3osr21C+5O/DQjJUnjzDNjIEJbK05
	2ZWDVbxRTw6vQbNSrjy7En5+upG5Pm+xSMcUZGUSk/HMZ4BWXtF5
X-Google-Smtp-Source: AGHT+IH3C1Qnf0/6+4NmaQmZ/uEZDQRfzVSUp/eHC9XhRuIpUhozHkj66BmMY4loCbOv+N4q1N37sw==
X-Received: by 2002:a17:903:28e:b0:1d0:4802:3b6c with SMTP id j14-20020a170903028e00b001d048023b6cmr733262plr.4.1706310838445;
        Fri, 26 Jan 2024 15:13:58 -0800 (PST)
Received: from localhost ([2601:644:9380:8cd0::7fb4])
        by smtp.gmail.com with ESMTPSA id l6-20020a170903244600b001d78813c8a5sm1423159pls.49.2024.01.26.15.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 15:13:58 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: leitao@debian.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/8] net: netconsole: move newline trimming to function
Date: Fri, 26 Jan 2024 15:13:38 -0800
Message-ID: <20240126231348.281600-4-thepacketgeek@gmail.com>
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

Move newline trimming logic from `dev_name_store()` to a new function
(trim_newline()) for shared use in netconsole.c

Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
---
 drivers/net/netconsole.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 085350beca87..b280d06bf152 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -230,6 +230,16 @@ static struct netconsole_target *to_target(struct config_item *item)
 			    struct netconsole_target, group);
 }

+/* Get rid of possible trailing newline, returning the new length */
+static void trim_newline(char *s, size_t maxlen)
+{
+	size_t len;
+
+	len = strnlen(s, maxlen);
+	if (s[len - 1] == '\n')
+		s[len - 1] = '\0';
+}
+
 /*
  * Attribute operations for netconsole_target.
  */
@@ -424,7 +434,6 @@ static ssize_t dev_name_store(struct config_item *item, const char *buf,
 		size_t count)
 {
 	struct netconsole_target *nt = to_target(item);
-	size_t len;

 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
@@ -435,11 +444,7 @@ static ssize_t dev_name_store(struct config_item *item, const char *buf,
 	}

 	strscpy(nt->np.dev_name, buf, IFNAMSIZ);
-
-	/* Get rid of possible trailing newline from echo(1) */
-	len = strnlen(nt->np.dev_name, IFNAMSIZ);
-	if (nt->np.dev_name[len - 1] == '\n')
-		nt->np.dev_name[len - 1] = '\0';
+	trim_newline(nt->np.dev_name, IFNAMSIZ);

 	mutex_unlock(&dynamic_netconsole_mutex);
 	return strnlen(buf, count);
--
2.43.0



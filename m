Return-Path: <linux-kernel+bounces-59056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0904084F09D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70881F22278
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482EC657BD;
	Fri,  9 Feb 2024 07:06:20 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F9B57308;
	Fri,  9 Feb 2024 07:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707462379; cv=none; b=tNz9IHojFL+9dCyqJadKR5cnTwn/QUl9jH76NjqCJtm5d+Qqi04uBi3KKFJaEjqWrwUhFMoyJQtCN40sc99ulVPnpdsqBq4nf1829ejRrmgrmP2HDdHfFIp1UrWRNRbCRRhJB0deLLrASta0pJb4z9fA3+I3dKtoHQesSWg5RBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707462379; c=relaxed/simple;
	bh=xdfzDXGsrnjsjgrVDLKFZyComOe6tbA2kOubScLODRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p57Am/8XDE1jOhCJ86DyXDOlAqyNCZIESmnP5H2uFSfAwuT719qx9qWCJgVwFo8qPlOMfYDmu9xBqN9G8VwOpwyUMVGQFBGz2K7R1mNEH6/fLveOiuj9mmvzha28ig6TivPFdm4Q5I+x/TNweC0matMj4PiXRqjj1nrYwVmP+Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-783d84ecb13so43172285a.0;
        Thu, 08 Feb 2024 23:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707462377; x=1708067177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oADkvQHAij8FCM4vmi8qRxP7ztqbgDTFL1If0dxUooo=;
        b=aW71Bhd7+sF5QHi0HDrYHhkNIDlkGjeL68IFPsKNlmQ4yjMUvJxp86FD4bPOgA4xC2
         gz34x2z+/JeorlSAHad6yK2vzdNwo5d/on47T+uNxiphnz3gk1SaJ6VHJv8Xuv9kpx+I
         9SUZF6hgs0wavRCNLj7YmFPUwxGacCXUccKYI1+FPvt7DXXsQoeYCzgIZc7spH+u+pC9
         hzfP3Wk400UahqFULXz+Yy0qT4XJb/mdRTtFmq5u6QlrAk8GcL5Y7qsMIQc2f/Eu0VFm
         wcXZOIw48Vu2nwCTUU7uJehlgSlWDix7p5MmlIGTZpGoku5HUTmivmgSQ0KXaBtjsahd
         FAiw==
X-Gm-Message-State: AOJu0YwzCxDuaOJfSOg/0okjSX/feznjkBrnPaiYj/IJbJl0Dj+SaAI5
	yrTV7UnWP/7LO6+WFtxxfutGu5AS0ClZpKTD0zeLWu/8s4d4msiP
X-Google-Smtp-Source: AGHT+IHzkNveMwi7bMoRQ9zqGY6hEu7DkmXBCjt5L01jg2IKMEclrEvcB31X9A7vRpwNGgki0YZlsA==
X-Received: by 2002:a0c:aada:0:b0:68c:bdc0:1bd2 with SMTP id g26-20020a0caada000000b0068cbdc01bd2mr607755qvb.9.1707462376842;
        Thu, 08 Feb 2024 23:06:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXm1EzV9GLndmBzBAWO2JUZL47ACppeNoLaIsJhQa44I7jkyxsWe5w071H3ZMCMUA7fO7bqo39hJ5o/Zyw1ijs+kUbiRwa1CdX7SQoLEmv9AnV4uo9qUnxR1lMLFFeolbxMFGhhQVmv1vSEkCJX5cg3NqMwDNumeL/2pHAcA2sbesAs35XkB/A9ddRBkt6h/XP7bVpKcmTJ9O5ytSHAJg+hhqKeF0Z3qesEdNbtsCjO4RO7jJD65sa8ZqWiy/d3ONMAQHY=
Received: from noodle.cs.purdue.edu (switch-lwsn2133-z1r11.cs.purdue.edu. [128.10.127.250])
        by smtp.googlemail.com with ESMTPSA id b25-20020a0c9b19000000b00681785c95e0sm576315qve.46.2024.02.08.23.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 23:06:16 -0800 (PST)
From: Sungwoo Kim <iam@sung-woo.kim>
To: 
Cc: daveti@purdue.edu,
	Sungwoo Kim <iam@sung-woo.kim>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: add missing checks in state transitions
Date: Fri,  9 Feb 2024 02:04:44 -0500
Message-Id: <20240209070443.3617790-1-iam@sung-woo.kim>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an l2cap channel receives L2CAP_CONN_RSP, it revives from BT_DISCONN
to BT_CONFIG or BT_CONNECTED.
It is very weird, violates the specification, and I cannot see any real
usecase for this.
Similar to this, the L2cap channel has six illegal state transitions:

1. BT_CONNECT2 -> BT_CONFIG by L2CAP_CONN_RSP
2. BT_CONNECT2 -> BT_CONNECTED by L2CAP_CONF_RSP
3. BT_CONNECT2 -> BT_DISCONN by L2CAP_CONF_RSP
4. BT_CONNECTED -> BT_CONFIG by L2CAP_CONN_RSP
5. BT_DISCONN -> BT_CONFIG by L2CAP_CONN_RSP
6. BT_DISCONN -> BT_CONNECTED by L2CAP_CONN_RSP

This patch fixes 2, 3, 5, and 6 by adding checks.
For 1 and 4, I will make an RFC for as it requires some refactoring.

The detaild logs are described in here:
https://lore.kernel.org/lkml/CAJNyHpKpDdps4=QHZ77zu4jfY-NNBcGUrw6UwjuBKfpuSuE__g@mail.gmail.com/

Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
 net/bluetooth/l2cap_core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 60298975d..c5fa2b683 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4339,6 +4339,14 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
+	switch (chan->state) {
+	case BT_CLOSED:
+	case BT_DISCONN:
+		l2cap_chan_unlock(chan);
+		l2cap_chan_put(chan);
+		goto unlock;
+	}
+
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
 		if (__l2cap_get_chan_by_dcid(conn, dcid)) {
@@ -4552,6 +4560,14 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 	if (!chan)
 		return 0;
 
+	switch (chan->state) {
+	case BT_CLOSED:
+	case BT_CONNECT:
+	case BT_CONNECT2:
+	case BT_DISCONN:
+		goto done;
+	}
+
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
 		l2cap_conf_rfc_get(chan, rsp->data, len);
-- 
2.25.1



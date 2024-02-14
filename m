Return-Path: <linux-kernel+bounces-66028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C9285558F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841FE1C21825
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4A4141988;
	Wed, 14 Feb 2024 22:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="bgN0ehq7"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C14313F009
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 22:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707948544; cv=none; b=M/lH9PSgonBqtPH5cD6wEN0XMerbqTd7nfqP8clJnOhjFn2QxBjvDD2xgzt3eAHcd98sfCnEZpwE3ZJABhzDyI1zFMFS46Q/1UBlX5jCpQlakjDUsyyEUT3/b74Cx8J3aw72efiUzyOSFPbPRQD7gjThWkBqJU5hGyklxY4HvJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707948544; c=relaxed/simple;
	bh=/ZEw3nT9BRApIhNWO23YhMJtkmTMIFXh3nph9Rnl9wo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E+urGxfGbogoJip71PbWSQrzNhWYPS5V5ym9aMTeanfKdzPTJIehLKJsKOA6dumELfzDMuSdT8weqDEaMm3nANCU36YN7NuoPNPObEFsJtv8C0pt7KlsSWwLvmwO/gz9Jeghr17thasfOjz9XFCr6n9kqp9hDwdxz3/wTmo/V6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=bgN0ehq7; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-337d05b8942so101042f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 14:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1707948540; x=1708553340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rvOh55NDnukoUmm76Hh+HuEqWYW2cORpSho5SBfrrxU=;
        b=bgN0ehq7JoTSv1yYLzYkPMAKBGaTAvqFYZY5+E9+vnAwdowf4lzPjb7PDVIAlhJusU
         ixHWkeXjZVEpH/a3of/+AVWDPjY5rUGz5R5WkFvVI5OrME+fPGaot65sxWp/RgNwNGZr
         2JoipNw0doaPUqOxVzjBXbL9vS6i0m54Hp/W7ja/A+jFIiAyK/tfFt6uLL7ji1hmoljJ
         OvYYlXiGDRCuusmVqCGrp3HK+ax0RWJ1tLKJziZR5sRXjlqCklqR/U6vO/9+3CefV/ZO
         ID5RTqeHDOWUtBBbmz3EI3ftB+B94E8UT8Gy5EBdwJY5iAPRaBgQvkhkztPtMtNuLL6c
         pnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707948540; x=1708553340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rvOh55NDnukoUmm76Hh+HuEqWYW2cORpSho5SBfrrxU=;
        b=NCAOk6NUvraCVgkte5scAouFydEknJBlumFjRqYg4ZdWlwpqjrNXYaTweZAeIzotiY
         YS+uORLvi738Ut/Ospyx/i/mq33H5DFmECNB0hcTf97+wNXoSB9gNDKy4CKOSBsDNfAG
         NWGGx1Vxg0AuBInuIRRiYV/OcpvLBQI43eBSFsu9ma538D0bX4V3XHR5rIOLqfSln6sG
         oP08k7rndzGqBHxjaTaRpnQKNfclbCItT9urXy+qLbrpxLX68o1WaeNrSDXyyjg/HkEm
         hGnGnnJriBUzft8DvVAHtP13v7K25UJZyYq3Oi9nOpqLWMWrrkYDeX4ANdKze1dsc6ry
         4wcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB5xDEgUp9ufyxwZEewDfTADJCYGypj7pey8dF3TT5SA3EC2TYL0AWOZ+AOL+R5hfVDI0tnHhIiaC7NPwNLwQyhiQacslJxWe9NqzW
X-Gm-Message-State: AOJu0Yx8L/WzjlB6TbSI5YwiPOfpmb1wm/wSRpUt4jJFynhydiWdQzAk
	NjfDRODWQrbwIy2BUawc29UE0LtXRyT9zRGYR+UQ/8CYiMuEeaNTutUYSBuveQf4qyoH0G+NMYZ
	T+jrDRQ==
X-Google-Smtp-Source: AGHT+IFBCkJjgKAte43OlvsT2p+edcXWf4TZt62EkxtkPmvLum/pNRCYcatU+QYBB+Bht0KOnjEiwg==
X-Received: by 2002:a5d:50d1:0:b0:33b:433d:e1d7 with SMTP id f17-20020a5d50d1000000b0033b433de1d7mr2763880wrt.1.1707948540572;
        Wed, 14 Feb 2024 14:09:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVC7/90BQ67mnQ5Q3GKq/x5TXhESOtq3i18WD7DLjPm9sgke4J2YcHHiXquH904v5OmDR/AGUOq2L/D7RxyTlAraU+WMJNt/ut66x8xRv5LnRg5uG8T+8t+6qYNH1MVXnGnc+Xx5FW0akLa7kd1ks1x0c6FRca/jOdtybWQ9ytFSPfB+Bbivvf2LpRhOUffBM/Eh5s23duXO6cvi0PWTgU=
Received: from debian.fritz.box (aftr-82-135-80-242.dynamic.mnet-online.de. [82.135.80.242])
        by smtp.gmail.com with ESMTPSA id e30-20020adf9bde000000b0033cf5769ab2sm1002122wrc.101.2024.02.14.14.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 14:09:00 -0800 (PST)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] synthetic tracing: Fix trace_string() return value
Date: Wed, 14 Feb 2024 23:05:56 +0100
Message-Id: <20240214220555.711598-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix trace_string() by assigning the string length to the return variable
which got lost in commit ddeea494a16f ("tracing/synthetic: Use union
instead of casts") and caused trace_string() to always return 0.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/trace/trace_events_synth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index e7af286af4f1..c82b401a294d 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -441,8 +441,9 @@ static unsigned int trace_string(struct synth_trace_event *entry,
 	if (is_dynamic) {
 		union trace_synth_field *data = &entry->fields[*n_u64];
 
+		len = fetch_store_strlen((unsigned long)str_val);
 		data->as_dynamic.offset = struct_size(entry, fields, event->n_u64) + data_size;
-		data->as_dynamic.len = fetch_store_strlen((unsigned long)str_val);
+		data->as_dynamic.len = len;
 
 		ret = fetch_store_string((unsigned long)str_val, &entry->fields[*n_u64], entry);
 
-- 
2.39.2



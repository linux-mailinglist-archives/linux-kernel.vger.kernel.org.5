Return-Path: <linux-kernel+bounces-37458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C8483B058
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB43328A0F1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AB812A168;
	Wed, 24 Jan 2024 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMbozi4L"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE6312A143;
	Wed, 24 Jan 2024 17:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118441; cv=none; b=Eafep/BjPLLrno/4r96roFaKUTikmN49bGeXAJfSzIS+LxN0tq6/dXmgmUcg9NKLS1zDmQmpe2Dwy655Bx9thaOn2pamF+cwtj8bHF1tWJghb7E/eG5mIw/3ZgHFNQaC1yPrlMUrkrPpxnbQ/LUknsgjrNkIq3vWIOyHYcXYhoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118441; c=relaxed/simple;
	bh=/YjWyaqPnZDamee11YunAkZPyfaZp6y28fWxTHZ2aeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFlonY8OSZJV7yMCNrEhgClVknfhV4FQbU5pgdJjQu/TMlKuTBHzUeDE21dhBGxNtwDTo9ijyeHlEp0wygsOZNfgDAsH4rQRp/I81etgQwttrTSKLMBfQrd6SkmdN+PGK9F3P4zXyFkQ6iDhhfezRUOhQUZGUt1UDvL+01K5R9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMbozi4L; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d75c97ea6aso23789975ad.1;
        Wed, 24 Jan 2024 09:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706118440; x=1706723240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v77jF51yTqnOl3/nOY82fJC7PIH7X2Y2RU7dU3D2hPY=;
        b=fMbozi4LrRQ6tGLocq9T/NXkTCc5QXqmI8C8PHgG0d9Qb9jls+tiFh88jXxepwNE90
         83bb0Z6JjiB8x5TrfmKrB+YAYvXlHU8LNFECKZWd5AZ3B+Ipr+I8juKWy6W01t9TPLZK
         jyETS7AJhoenN+FpcKNy5N1iZnIosqu/uSO1b72PzwAwSJHXTaWD7qIzpmFZ7UdVWG+W
         KC+o2mtEFM4aM6//UUYjculak0m4sZZOS3gvE5qZAGV8WWcCWVv4gUFZ6a+6d6tVNA2G
         d78P7ZhH8giQNkQnKtFLaH6rNJgYGdi1JPAmuqmf+uklShc4UwgdUw92gx/og7dOJUOY
         7bGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706118440; x=1706723240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v77jF51yTqnOl3/nOY82fJC7PIH7X2Y2RU7dU3D2hPY=;
        b=uhc9ldi7F5BPMYseWvHBurfKwQd/udmCZ9sI23MDbAYc8wsslk73rHl39hr8Fa7L/D
         j6jOu29cUOe7JZSmvF3g5CHBYP6nPoRllwlJnWxuwBpEo8Jhfj97qi565VAmhja1DPhy
         KcahE2p9eq0eL0/XfZX7czr8qH/AIzufKu60wdom9BpGIKtASQ4JVJcjVUwNW2zon8mi
         HWtuLsIA0aJMO3W7YoElwjIdc1xjuwQmDrK2KLNiXTZL8kflf0VbfjCf42mEBdM60/BD
         woefvJPIhZ5n+cLDrj7XQU5vZf/HuQbrt5CIbEs+jfNlSsnaxjdeh+9YfLsMAgYA2buO
         0maA==
X-Gm-Message-State: AOJu0Yz8T6Q61VE+XBc3fotVElZB/8Hfyq6i8ZpHzw6rU8AaSDJJ/ybR
	w8N3MJVAWNTFQV5SGyV+kBGpdG6E4Rf/QxMlnUahkgMQ2AGoq+hz
X-Google-Smtp-Source: AGHT+IHwFK8lZLxAYBatkNDzZ4Q93793g3sZJmZiJJC9Et983fMiom9Ns8uSgVmg0aEKN5JI+Opkfg==
X-Received: by 2002:a17:903:2452:b0:1d7:8570:e53 with SMTP id l18-20020a170903245200b001d785700e53mr8332pls.38.1706118439847;
        Wed, 24 Jan 2024 09:47:19 -0800 (PST)
Received: from localhost ([2601:644:9380:8cd0::7fb4])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902c18400b001d71649bf9asm9415460pld.252.2024.01.24.09.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:47:19 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Brauner <brauner@kernel.org>
Cc: leitao@debian.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1 3/8] net: netconsole: move newline trimming to function
Date: Wed, 24 Jan 2024 09:47:01 -0800
Message-ID: <20240124174711.1906102-4-thepacketgeek@gmail.com>
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

Move newline trimming logic from `dev_name_store()` to a new function
(trim_newline()) for shared use in netconsole.c

I was unable to find another useable version of this functionality that
wasn't private to another driver (E.g.
tools/testing/selftests/pidfd/pidfd_fdinfo_test.c)

Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
---
 drivers/net/netconsole.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 5e720bcf7102..586945e62210 100644
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



Return-Path: <linux-kernel+bounces-88984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7AF86E8FB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BBA91C23E47
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F6F3C08A;
	Fri,  1 Mar 2024 18:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFKlQ6x+"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7358739AE3;
	Fri,  1 Mar 2024 18:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319540; cv=none; b=rxbYIitpL+WFTJ/vxnP773XO9UbIQH4xIXpe1uwaUBAqC3TcTn11hvrEr9RJwdTxdbqhEjuthEHpiOeECLKajUf8hJQXYZia9/30vsl9IE5TwYho/7qaV3lqKoQY72e+B64BdkDBh/3GKAyNfV3A2xN2bU3+93KKkeHaOoXQ3fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319540; c=relaxed/simple;
	bh=buWFUe4YWDSCsR8StyoXer3cJc0fBXExI7TFdzhPNA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=afySSsYd6RXK9KITQ9P3CWtQOeY+7jDSoOtkVUSTuxDtS89cqmRR0OW9KmMw/Ll7Cqdz8lxua694iGTHZgR1pxEJJ/hTy6oKMxtl2rxKkUAv8z17k/F0U48tNDaVb6GlTK0bpGp/Qw5XWLOaUAJtDnktAk8mMdzW2uNVSDG2F8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFKlQ6x+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dcad814986so21710545ad.0;
        Fri, 01 Mar 2024 10:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709319537; x=1709924337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dwIU+TX5sfzNFmSIzaxmqHRc2NiC8aIzNqUoGoYfbzc=;
        b=VFKlQ6x+npLZTPP/UzO0GXnS8YZ02zkREMZfTOd7QcsxDquTqjgnoteikjcTKMRFXj
         fxAbdH1m+hhOnA8+A8i0flnzAyF1BoJxPxI7S5xjK8EY180D4yvM2UoiuBDCecIwOuXk
         4CWG+uNqX1MLUX1ykXPsaj5GpZUmYm77/vSAJqx6Li5dYsKAguy/rZhjYlQgt16I3fls
         PmRDMjImoB/k9x81xX8XofYvCTS8tGkHb55t7UVJRShMe1qvMEAb5XUGm4yNPdPslmdE
         gBgmVcz9xEn8GXYB57W+93dWvIZSMJjswar9/l6ze1JOQhDnOvikZNBYrhS64vBpYyad
         /D1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319537; x=1709924337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dwIU+TX5sfzNFmSIzaxmqHRc2NiC8aIzNqUoGoYfbzc=;
        b=XkD3jb+NM5KWUOd5VlYXap5ckwZqImoptO0rpoZH0I0wdpPgd3UEVuFhFoV5DJKBiX
         xJHmz6av+8zESrC8IqlyVccmLxITnUgsVJnJ67LNU4mSxmBkfXr6K+JemwIP0BRqK15X
         B3JeFebDlbqDAeU+hl0KPiMSxu+vjpw7ccYNyxALvFrCLuqLqIQxBHekik0IV+Iz2oLq
         F31yaZtiNfF+aH6p8O+09fTRa5Hbv0IwgUsZWsHul8J/dHuGZ3YpDzQ/OCZDk0iJaPUN
         wFQdnwV+jeM48oBhupaxe3+WFe93ZMt6SN+i/3zks7E1AHfHfJg0WfR7ZmP1gtlT7oOJ
         TfKw==
X-Forwarded-Encrypted: i=1; AJvYcCW8KMLH6n8yTU80HHLfx4jV7Cu9BqZ6Gr37jvDhNjxPOisnfxoCYL9Wzv2UBqxY3L6YfmsfLCuSL7B/5zPsW9IeWQOxgJC9TGplzMrasV7VyoiybMWsl9tI3FzMZiYcCXwfwq8+DB5g
X-Gm-Message-State: AOJu0YzDfKBiTULIXSrSXNjCyLfI1iC8lMB6Ow+B9bcV6FKSbHE3YnU6
	mZoulOjJrZMBAjJBLuQ/cmvkvjqRk7lJAq4mMgU2H0KcHThTK5VZ
X-Google-Smtp-Source: AGHT+IG8FZCJctuC+yYgD71G7sck4baDCS8K7h0als3Isy6Xd+jNaBgOQG7p3zwi+9e4nW9AnA2MSA==
X-Received: by 2002:a17:903:50c:b0:1dc:92a7:f2f0 with SMTP id jn12-20020a170903050c00b001dc92a7f2f0mr2229057plb.23.1709319536663;
        Fri, 01 Mar 2024 10:58:56 -0800 (PST)
Received: from localhost ([2601:644:9381:2f20::97e])
        by smtp.gmail.com with ESMTPSA id u12-20020a170902b28c00b001dc94fde843sm3792551plr.177.2024.03.01.10.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 10:58:56 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Breno Leitao <leitao@debian.org>
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] net: netconsole: Add continuation line prefix to userdata messages
Date: Fri,  1 Mar 2024 10:58:54 -0800
Message-ID: <20240301185855.944405-1-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a space (' ') prefix to every userdata line to match docs for
dev-kmsg. To account for this extra character in each userdata entry,
reduce userdata entry names (directory name) from 54 characters to 53.

According to the dev-kmsg docs, a space is used for subsequent lines to
mark them as continuation lines.

> A line starting with ' ', is a continuation line, adding
> key/value pairs to the log message, which provide the machine
> readable context of the message, for reliable processing in
> userspace.

Testing for this patch::

 cd /sys/kernel/config/netconsole && mkdir cmdline0
 cd cmdline0
 mkdir userdata/test && echo "hello" > userdata/test/value
 mkdir userdata/test2 && echo "hello2" > userdata/test2/value
 echo "message" > /dev/kmsg

Outputs::

 6.8.0-rc5-virtme,12,493,231373579,-;message
  test=hello
  test2=hello2

And I confirmed all testing works as expected from the original patchset

Fixes: df03f830d099 ("net: netconsole: cache userdata formatted string in netconsole_target")
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
---

v1 -> v2:
- Calculate 53 byte user data name from: entry length - formatting chars - value length
- Update docs to reflect 53 byte limit for user data name (director)
v2 -> v3:
- Added #define for userdata formatting character length (3)
- Matched all #defines indent level

 Documentation/networking/netconsole.rst |  8 ++++----
 drivers/net/netconsole.c                | 14 +++++++++-----
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index b28c525e5d1e..d55c2a22ec7a 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -180,7 +180,7 @@ Custom user data can be appended to the end of messages with netconsole
 dynamic configuration enabled. User data entries can be modified without
 changing the "enabled" attribute of a target.
 
-Directories (keys) under `userdata` are limited to 54 character length, and
+Directories (keys) under `userdata` are limited to 53 character length, and
 data in `userdata/<key>/value` are limited to 200 bytes::
 
  cd /sys/kernel/config/netconsole && mkdir cmdline0
@@ -197,8 +197,8 @@ Messages will now include this additional user data::
 Sends::
 
  12,607,22085407756,-;This is a message
- foo=bar
- qux=baz
+  foo=bar
+  qux=baz
 
 Preview the userdata that will be appended with::
 
@@ -218,7 +218,7 @@ The `qux` key is omitted since it has no value::
 
  echo "This is a message" > /dev/kmsg
  12,607,22085407756,-;This is a message
- foo=bar
+  foo=bar
 
 Delete `userdata` entries with `rmdir`::
 
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 0de108a1c0c8..8cc28aec59c8 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -42,12 +42,16 @@ MODULE_AUTHOR("Maintainer: Matt Mackall <mpm@selenic.com>");
 MODULE_DESCRIPTION("Console driver for network interfaces");
 MODULE_LICENSE("GPL");
 
-#define MAX_PARAM_LENGTH	256
-#define MAX_USERDATA_NAME_LENGTH	54
-#define MAX_USERDATA_VALUE_LENGTH	200
+#define MAX_PARAM_LENGTH		256
+/* characters used for formatting each userdata entry line (' ', '=', '\n') */
+#define USERDATA_FORMAT_CHARS		3
 #define MAX_USERDATA_ENTRY_LENGTH	256
+#define MAX_USERDATA_VALUE_LENGTH	200
+#define MAX_USERDATA_NAME_LENGTH	MAX_USERDATA_ENTRY_LENGTH - \
+					MAX_USERDATA_VALUE_LENGTH - \
+					USERDATA_FORMAT_CHARS
 #define MAX_USERDATA_ITEMS		16
-#define MAX_PRINT_CHUNK		1000
+#define MAX_PRINT_CHUNK			1000
 
 static char config[MAX_PARAM_LENGTH];
 module_param_string(netconsole, config, MAX_PARAM_LENGTH, 0);
@@ -671,7 +675,7 @@ static void update_userdata(struct netconsole_target *nt)
 		 * checked to not exceed MAX items with child_count above
 		 */
 		complete_idx += scnprintf(&nt->userdata_complete[complete_idx],
-					  MAX_USERDATA_ENTRY_LENGTH, "%s=%s\n",
+					  MAX_USERDATA_ENTRY_LENGTH, " %s=%s\n",
 					  item->ci_name, udm_item->value);
 	}
 	nt->userdata_length = strnlen(nt->userdata_complete,
-- 
2.44.0



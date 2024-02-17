Return-Path: <linux-kernel+bounces-69873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE81B858FB2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7DD1F21BC3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22E17AE54;
	Sat, 17 Feb 2024 13:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzDXgvhj"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8AB3DBBB;
	Sat, 17 Feb 2024 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708176954; cv=none; b=MlSZrFC9njHlswEQkAFy9msuB/TyBpz+67dio/TEM/uQ+42cs91maW9dDirKPFMNeCKWBYwIGcj4Bnk0WQxgtFSgEClakckfVK2iBPxq70n3JOevu3Pjgw9tJ9ZoKyYzrFo+SHSVtx/2NawR+BRosqao1TNxMsPzT+zalhFAUzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708176954; c=relaxed/simple;
	bh=tMZnD9BAREbxBr4MCZ1qYFNYWYWzjxmzqnVxHd8u8/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VTV8bKf/vM3nLIwJZBddwRE0f0VHzjDxcONBJAy6wrixXHGo5hQxyN7O8cO3lvmV7TbRZFTGm1vMogbHkKJc74hDtqKIW3cMTCpnBKVKegRJr0LiDl8J5tO0fLkGZG7dKUTotipCg6DD3j22TDInP6RuN9bEEKWExZfqC7vnFOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzDXgvhj; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-364f8246c8cso7294115ab.2;
        Sat, 17 Feb 2024 05:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708176952; x=1708781752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E/J9bJiu5lsGMJF4n5pm6X5Bisri8OV7G/jXa46CjfA=;
        b=IzDXgvhj7EVlND7HMzpiWdIt8xinzQb9YYoPL4+7NZKdX2x74IN4sHVuwAx5NB2h6s
         yYb0vH9QnODd3Nk/GRnMctoVOFxpbPOjfnH/pMy3wMgY1Qpq8TYwQo8S0pD5JZPafkWy
         gwQcn6k6AHECaOhZlRoGT1QHrkuy4ZMTMUe2/vesfI56g8vb8bmJXr4JtuEu90K5V4f6
         lgvpMjwxn+cwMoK6m9L6DO73ZA9mMHtIhYC6Gwo/P1Jo6IClabhcreyB0OQVvNPCKVKu
         e5HQWrEMfWPyA0OCws/FxCfr3mBF9wtSLVd5/ArbuJZkgbOthDJZkCOaurEuGl6EKfTP
         UFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708176952; x=1708781752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E/J9bJiu5lsGMJF4n5pm6X5Bisri8OV7G/jXa46CjfA=;
        b=CB9VlG3LO+Sz6C0gp/mdIzBi8tPhycFWgZsAKVIulMB76ie1Q+DR6J8XGgwHDqaGbK
         EvBe7h8y3SWLSkU2oaNHeQNeBHTmcfS+fEQ/5a1LRED0ESI3XOCWGSiU/gVk8C1HOQGa
         rTwyGXs0Er83VtpQrJQtIjpGPw/32NdWrdbFFgQ55TwmfMdwHwFI6T+sCBMfBOzBgsSH
         L/+1KwkxJJMzwOiA+W3UxnsoWlW9ZIBWfBTJHWFsKB2XgmnJJLqv7/LN2uVC07rqVcrj
         J2NqDzQ1GP3rInJ+WS1G4PyTpxGV//TA+eOzm3Bk+v/0qJWS6YXnjkaW5MycirlSAAcm
         8YXg==
X-Forwarded-Encrypted: i=1; AJvYcCW3LsMSItfY1Aj5PReJUhTc368AMHEYVOSo5KnkdPEOxk5yFcMg7nS6T1ObW8HosmRFsA8tjrOQvpS/6ikaP/61ZLMsR0yNC6f0Q0YpAYQ6T19hPN3XdFkt/aeCJ0oLEq3zaYzIZSnasn6xVje+iEISPrGz
X-Gm-Message-State: AOJu0YyOhikqJvNT6k/CEyoZ/dwc7txQnAUYbrIZ07Ko8o3O9+PhJU6y
	vAbkgF3cSGKFD6aljKBoR6RvKbThR+LedeFnYfykdruG6rgnTkoA
X-Google-Smtp-Source: AGHT+IHZXTphS6lUO3v3Cxz6zH3LI4Uyifv9yT0TaokhpM0X+PsXxz1RS8lb2OiQOsyGwEOer3Rsfw==
X-Received: by 2002:a05:6e02:184e:b0:365:1dc5:9cae with SMTP id b14-20020a056e02184e00b003651dc59caemr1450043ilv.9.1708176951614;
        Sat, 17 Feb 2024 05:35:51 -0800 (PST)
Received: from pairface.. ([111.18.146.226])
        by smtp.gmail.com with ESMTPSA id 32-20020a631260000000b005d3bae243bbsm1583617pgs.4.2024.02.17.05.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 05:35:51 -0800 (PST)
From: Pairman Guo <pairmanxlr@gmail.com>
To: paul@paul-moore.com
Cc: jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pairman Guo <pairmanxlr@gmail.com>
Subject: [PATCH] LSM: Fix typos in security/security.c comment headers
Date: Sat, 17 Feb 2024 21:35:04 +0800
Message-ID: <20240217133504.4534-1-pairmanxlr@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit fixes several typos in comment headers in security/security.c
where "Check is" should be "Check if".

Signed-off-by: Pairman Guo <pairmanxlr@gmail.com>
---
 security/security.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/security.c b/security/security.c
index 7035ee35a..0bd3e9df4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2904,7 +2904,7 @@ int security_file_send_sigiotask(struct task_struct *tsk,
 }
 
 /**
- * security_file_receive() - Check is receiving a file via IPC is allowed
+ * security_file_receive() - Check if receiving a file via IPC is allowed
  * @file: file being received
  *
  * This hook allows security modules to control the ability of a process to
@@ -3114,7 +3114,7 @@ int security_kernel_create_files_as(struct cred *new, struct inode *inode)
 }
 
 /**
- * security_kernel_module_request() - Check is loading a module is allowed
+ * security_kernel_module_request() - Check if loading a module is allowed
  * @kmod_name: module name
  *
  * Ability to trigger the kernel to automatically upcall to userspace for
@@ -4114,7 +4114,7 @@ int security_netlink_send(struct sock *sk, struct sk_buff *skb)
 }
 
 /**
- * security_ismaclabel() - Check is the named attribute is a MAC label
+ * security_ismaclabel() - Check if the named attribute is a MAC label
  * @name: full extended attribute name
  *
  * Check if the extended attribute specified by @name represents a MAC label.
@@ -4487,7 +4487,7 @@ int security_socket_accept(struct socket *sock, struct socket *newsock)
 }
 
 /**
- * security_socket_sendmsg() - Check is sending a message is allowed
+ * security_socket_sendmsg() - Check if sending a message is allowed
  * @sock: sending socket
  * @msg: message to send
  * @size: size of message
-- 
2.43.2



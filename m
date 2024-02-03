Return-Path: <linux-kernel+bounces-51317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BEE84895C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 23:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 221A7B23715
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 22:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EDE171A8;
	Sat,  3 Feb 2024 22:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Shahi+uV"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F2F168CD
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707000129; cv=none; b=da3UX4nU0s/oNIF83sseAegpAkWqKZQvQuzQq6ppSaksQlpaPLr+1Yg9zv4hcArfPgfM7VqSPVYSXabfWWnLjZttTzaNe3lDsylQ/eQ1s5szC+5m/HhIlPSUS62r9GFLatWTCkx14Ae3wPw9/xMotm/iM9O7YjUtYj2XPcme8cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707000129; c=relaxed/simple;
	bh=VRgg9tPPV9ch9xVJUoSdcCPIv9S0ZNXn78YmVch3TGI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sSQ3TozsO3pLyqCymjcYvqll7stQQwURs1w7sz1q/5tQpYlSTHQckohXDYoaSDyxVUCbnDC+BygDqf0mKcRJ2kEy3S4cwoI+GK+d8pS7VeYJGHyVO2hviKY6CJm2KrG2yyJTupTL3RC5j2o2Nq//zfbwSJsREwB9D9KZZMcH6lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Shahi+uV; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51032058f17so3816498e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 14:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1707000126; x=1707604926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9pUvdF72w2iDqX6eJFryQDKrSqvsabYyjqNTlDp/2Ts=;
        b=Shahi+uVv5Jcqs2zxX02dgEREOkT5swaIMXdkJcSNGrNI7FTfmf4IEXsVNlimWeeA2
         VFVSa0YVt0bHV83gILEsKWHrwEtJHDG6t/ErR3q9/bWOvHlxvLek21vJiDQHmB1UiSYu
         nqEvmxkwEsXh6HH1PEKQKTi2mS8YY9HfYuJk3t66xI2XlJofpqcC+mdSjALtrSxcCntj
         2mGK/7k4UJmiREwpmLeJYBdhJ/j7JWrlr0rrfn+ofaUBk2EQ3sZNsmJprpqHmAM3Ju/4
         42uXtg5qYt2+/MCNNlyHiQY7btCR9WtWrbJ3jsyLupyp7YCQt5g7zdTld502fZ3C8qwp
         zZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707000126; x=1707604926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9pUvdF72w2iDqX6eJFryQDKrSqvsabYyjqNTlDp/2Ts=;
        b=Zo2+cOp8D34VgyWUD0DlJntG0cuX0x9F9LTV39f/xuzZS4x6AcxDYe2d4WLFrEG7Yy
         KjEHXbn24I/KzzsK1jYmoiBybFsTjxs3zRoxw4H5OeE4wtwpgVlP5oAd4lOF6M3j0bBD
         NPTQg3iLeg1RkiZl+HOzwdlVdFjppLygZc4GZl3TKPNJiP/HQROYACxpHubmIZCKQ0be
         jDLOGnh+3mp9/v1P2JQMZ77Iqe6JWnAvDzzKQ0dq9dp7hywmMDGO3we41sUwjLBx3R3e
         PEM7/sbOPtUXVAaC3/sj2y8bwaM6N4eqDFRskKRD0GHwb3o18ejF5zQKrt8lf6famCCU
         8VFQ==
X-Gm-Message-State: AOJu0Yx5bQ5Z/b7xq0erbE9/EggxNTHTxQ4tPjzxRLNvsvKHFrTWROEC
	r42PF0h9j4lmWHYoFEHBydOKlxkz3xxy/vzhuezdxbTiMFcB/nIRcuQmVcQkOSs=
X-Google-Smtp-Source: AGHT+IE9qPqtc1+PfvjJ+mQSHAJeywN/9Ky3PPuW1h7Jw1sd53SYl7XPn1yGC0KN/q7qrQ/T88KkMg==
X-Received: by 2002:a05:6512:3b82:b0:511:2fdf:ce3b with SMTP id g2-20020a0565123b8200b005112fdfce3bmr7522710lfv.15.1707000126012;
        Sat, 03 Feb 2024 14:42:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVzSbN8YU69aED7LPdo/0CeRE01XONXwbdpqTN5X3IY9EWWvwmIUdvY3i/l/EjV7MjgFFWvNkwMcxXPm7pCgLyF7kyGICK9piXkMfGPWCCyCg5g557tC17mp8kaqSnrWnkKczoJqarViosz/tm471+fV/hAlCK6ac0eoyNkIQqXT1U=
Received: from debian.fritz.box (aftr-82-135-80-223.dynamic.mnet-online.de. [82.135.80.223])
        by smtp.gmail.com with ESMTPSA id wb6-20020a170907d50600b00a37026ef8e8sm2271055ejc.18.2024.02.03.14.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 14:42:05 -0800 (PST)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] Documentation: coding-style: Update syntax highlighting for code-blocks
Date: Sat,  3 Feb 2024 23:39:26 +0100
Message-Id: <20240203223926.5077-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use c and elisp instead of none in code-blocks

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 Documentation/process/coding-style.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index c48382c6b477..a75c7044d8b7 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -203,7 +203,7 @@ Do not unnecessarily use braces where a single statement will do.
 
 and
 
-.. code-block:: none
+.. code-block:: c
 
 	if (condition)
 		do_this();
@@ -660,7 +660,7 @@ make a good program).
 So, you can either get rid of GNU emacs, or change it to use saner
 values.  To do the latter, you can stick the following in your .emacs file:
 
-.. code-block:: none
+.. code-block:: elisp
 
   (defun c-lineup-arglist-tabs-only (ignored)
     "Line up argument lists by tabs, not spaces"
-- 
2.39.2



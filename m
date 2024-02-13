Return-Path: <linux-kernel+bounces-62857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294A48526EA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BDB61C25579
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837B18C1B;
	Tue, 13 Feb 2024 01:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJHokumy"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD338BED;
	Tue, 13 Feb 2024 01:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707787273; cv=none; b=owIeFViH621ROxJpUwH4Q8epMBPk2VhZMeMX3hAQidcGKm61KpfZzEHLH+KHSVdyJmbxOpdkNkw4exXbm56T+ON3qMONHqDbmSxLHqrINgkxxe69sF3yOJSgBxzkddVkrFVfL/XfR3tEH0j9OqrjZ6j34CEv46nT4PlSZyaVtbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707787273; c=relaxed/simple;
	bh=MLa4lf5uOURASMI9xTK+nE7rsYG01Lm5JO7kjMN3Hug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FifO9poytpScWhhC4rYEM3oZFuv6hRspcP9QjhkAiY8m3V3t3JBxuHfck6I4Q1jxACkDm+Oy036Zfn1wQLpOMa1LZvc/hKhhQ5XF34h05kP9NWbN0XWXmuYhpBZKJLCZGbVKlwelcWGdgc/Xkl8iYNh+wf9H+9WmC585fTpQG88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJHokumy; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bbbc6e51d0so2781862b6e.3;
        Mon, 12 Feb 2024 17:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707787271; x=1708392071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OIo9+CGA3o+sMvcBIMz3KkHVBSc3Wr6nRUoyuv+/nR8=;
        b=gJHokumyhpWG3YmpviFp5WJgnc9WvW9f3fX28VrYZATK5WHZ5oy/DzrsTXXOuj3Ulm
         upj3oLH1o6H6zoveYlTL/yME7wOoUsPmRJUABgEr1SEEkbF5ZUlqQapG+hAE420atv6J
         vZSJ8flrq6BCPoZ9/dSHT9yZYLRX851Fk9Fo0/3VQB3B6S/ydXE1Ld/lu5OK5icnbBl1
         Zt/LHreWpJeEzLD55WglGeusMp67lG4NXKbSD0D8PqXrkWr6godGJVUFMhSAq61fpSGI
         6jGzcHREZASjl2Etvu5634OvBkdyezVqEEND5qyaPXMJzwKtCiURu5Vb4AbPLrd6fJNS
         Yzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707787271; x=1708392071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OIo9+CGA3o+sMvcBIMz3KkHVBSc3Wr6nRUoyuv+/nR8=;
        b=jar5fnmYBaP4BYOX5dqncmbDejEISheiKE5vyBevS67RsEEEn4Dhk/HXvKSl5cIDsJ
         Xa6whsaZtIVrl8W/uFNxZv0v9GZVD+RNp9+DbElW05c/6tVNVI96CismNIsQc8hHguVw
         tj3FQgMLDsEfDpddWB2V3QMqXo76vB1oKkuGMOMBTjondncW4gXSJYiZsrW0rVMsUUfZ
         sQN+zn/EX0n2+Q1M14YfcPQfzN6043n3wGvCBR7bccRhecvA9fHnxw2/NhhLyWi0ctI0
         H8ReDKnimQLBz2IsRw9cxvKMksjnJgLGyaAl/nSm2GjRZouX4qtbu6SZujCUNWgFRjJQ
         ZtHA==
X-Forwarded-Encrypted: i=1; AJvYcCX9MFpf8i+dWvCWdXHColzdjKZpWw9TTvTIN/8E/7mlLwf68KbMdVyLPg/raJh+tjQT65f1Oxxrnc2j+BurG8DvK3VAbMO5o2b3KFZO
X-Gm-Message-State: AOJu0YxmrB3IPyKtl8aF24R1qZGSVnHp6d03Xo+os6yrlIh89ox0G8P8
	YZs5sgoNa4NDGGmeHxDLeMGUT7jrrL+KyZL2qylTIBYGo7lHE15dryKw0EZQdhE=
X-Google-Smtp-Source: AGHT+IGjp+ccfroJZ3LNYqvyf6Zlsgxk1ZaLug+4zFgnhDGKHley2D321KNOkNQyZiRxP83AMZcHrg==
X-Received: by 2002:a05:6808:10c4:b0:3c0:34d9:4d7a with SMTP id s4-20020a05680810c400b003c034d94d7amr6265831ois.18.1707787271258;
        Mon, 12 Feb 2024 17:21:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVnosEBHMfhXLylxB4Sd2Ldd2A9Q8ewSUvpAgHc62FKI/C23e856L052Hw6hUbM3KAgZE6n9p1UWawNKbVUE3sQfRjeGKBGiXBCkGbohcOsXDQp6T1hAQ0PdbOGLG1pvF1dC9JkCbe6JjZaWbXeaQqcLti2l6Ofthy7oTKVIrUGbpQhGCvr+oaB1BcF2jP+IxyzJmc44YIYcVULUtimTKQXO3KLR1roFU+/cVxPl+689lIndzRTtZqW/Q7agREhmuDKCbVYMGrbdsiq4p1hEguZAis1OTJunv/+20VabCeCDHv5dQWaGJqHuHtMamai6zlKmpYNoj0f5X1o82JGVrP0hIroCIfaJoILcz8TFFQ0S1axztVuD222/fARm8P5OfAoXW8PKDb3YS6tk45Vq2vA6g==
Received: from my-computer.uh.edu ([129.7.0.170])
        by smtp.googlemail.com with ESMTPSA id k18-20020a0568080e9200b003bfe05691f3sm277684oil.9.2024.02.12.17.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 17:21:11 -0800 (PST)
From: Andrew Ballance <andrewjballance@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: masahiroy@kernel.org,
	nathan@kernel.org,
	nicolas@fjasle.eu,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	linux-kbuild@vger.kernel.org,
	llvm@lists.linux.dev,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Andrew Ballance <andrewjballance@gmail.com>
Subject: [PATCH] gen_compile_commands: fix invalid escape sequence
Date: Mon, 12 Feb 2024 19:20:33 -0600
Message-ID: <20240213012035.750928-1-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

this fixes the error, "SyntaxWarning: invalid escape sequence '\#'"

the error can be recreated by running
    make CC=clang compile_commands.json

Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---
 scripts/clang-tools/gen_compile_commands.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
index 5dea4479240b..93f64095fda9 100755
--- a/scripts/clang-tools/gen_compile_commands.py
+++ b/scripts/clang-tools/gen_compile_commands.py
@@ -170,7 +170,7 @@ def process_line(root_directory, command_prefix, file_path):
     # escape the pound sign '#', either as '\#' or '$(pound)' (depending on the
     # kernel version). The compile_commands.json file is not interepreted
     # by Make, so this code replaces the escaped version with '#'.
-    prefix = command_prefix.replace('\#', '#').replace('$(pound)', '#')
+    prefix = command_prefix.replace('\\#', '#').replace('$(pound)', '#')
 
     # Return the canonical path, eliminating any symbolic links encountered in the path.
     abs_path = os.path.realpath(os.path.join(root_directory, file_path))
-- 
2.43.0



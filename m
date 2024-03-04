Return-Path: <linux-kernel+bounces-89962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CAB86F82C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 02:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD85128110E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 01:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27C110F2;
	Mon,  4 Mar 2024 01:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HprEuGx4"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A34F4409
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 01:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709515563; cv=none; b=QT+JL2X3Kj1q4FJ+eGE9/7BopFeigYCp5M32V5id69hVck2XyD6qz2ku4regMi0f/3zIXRKZbC1noD4ztKIQylZZ5eUYUwxf2GCRymKdzwxkaMTY4ZhnKsQ7qGJgaCv394I13S3LpTI2ysNVSZ1UpLiEkztJAjNv1cEjOnVP6hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709515563; c=relaxed/simple;
	bh=PKFdH2Ew/2KszJ2KLQdX6BpPURrzDiGAHTBUa4+sX2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UHPwEfOYa5vLpex3Nl2YAdZzx9ItvXZCHfB6syLNuH7TA0cWQ8/btegAFl2SLZo4b4pxAQYiFWxC+9/r9ibQBqeHZV7Z6EvlfvfYhFAB6oBqoYrPBAOqckUhcEygCqk7Yt5y2bnOw/LQ7XvM3M10oD8QmPg4YsCGrW3Kl+30Eec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HprEuGx4; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e4ea4ffafbso95684a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 17:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709515560; x=1710120360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5CrDoOfeKlQa5JlMUiuCz6fCgu6xAbvGI8jkfEQdCl4=;
        b=HprEuGx4/7/Y3ZKJJtw3TYSxV7hEeLdkvZ4ZRESErYPzQtveP+u44j83NIAhSHu3YX
         FoJ47i30F19a4bSsRmN5KfgMmCLBDoy9DMXfbif8OKoaEechlsIBMz4cgjnQgOWsleUn
         AxpJkun7eFwRT326c8YBa/8fGWsbsyDfm3yjAxm1UgVy5OjOQ4A35VNlIdGimLceO5G2
         m8v263LZJzXWdS2JFhPvPlLIvcXIBpTedB84vX/QsLr5cOQ2lYbLhsPjcn9K3+dunznz
         S21ZGioawmY30RyqrwgR007FP1VWFIdab4QW2nXzZQdTwL0XVe9uHeWD2VqCorHUSPUL
         jCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709515560; x=1710120360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5CrDoOfeKlQa5JlMUiuCz6fCgu6xAbvGI8jkfEQdCl4=;
        b=nCOEQaZXVn5UZxjS8F++UIwBP/OqrGKwzsnj5PICQc83+urdUR7ifeNatLtD4WG1SD
         N/IfEBJkARaOBcYQ7knBbDlOJJ9YkxKTG4CdnrV4t8fUN1WVYhy6xpZ1ZifgfWynAs+P
         IfD0HgT6jxIYgcg4Ymm4JsfvorH42ACVRM/Q17i17j6dZNvLCPv5xofeQt0EZg6loEnh
         qRa49+3uAueT0H3qEq0rTlUWqTtIi2X2Q7BG4yqI44yVy6pKNA7Btoncf81v9arX65uy
         91u5xQxxDwTM8ZqbhsQMwNCDTYLZbpRwCAKj5/FAYuC4qOFvhJha9nQ6XX3ThenBpPpi
         Q1IA==
X-Gm-Message-State: AOJu0Ywnyus9T9PhpnUJVOkmfPm/83H1NueoP6TcZ/fHVWPsENcHfwq7
	cnhKceRkqHo+Ol7kmqEj+OMGgjWveQ8srhEl2LzCbQoJD1yfMvpooh+n1W54Mkg=
X-Google-Smtp-Source: AGHT+IFZAhY+aHDoE4UmJ4YAzthSlrYX3qSCpjstZvsoP2lK4CgQ4aPMAZyXOMranELQKmYY9IwDFA==
X-Received: by 2002:a4a:2b42:0:b0:5a1:2947:c4bd with SMTP id y2-20020a4a2b42000000b005a12947c4bdmr1367268ooe.0.1709515560427;
        Sun, 03 Mar 2024 17:26:00 -0800 (PST)
Received: from my-computer.uh.edu ([129.7.0.68])
        by smtp.googlemail.com with ESMTPSA id c18-20020a4a9c52000000b005a056b5e37asm1815345ook.48.2024.03.03.17.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 17:26:00 -0800 (PST)
From: Andrew Ballance <andrewjballance@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: mcgrof@kernel.org,
	Kuan-Ying.Lee@mediatek.com,
	koudai@google.com,
	p.raghav@samsung.com,
	akpm@linux-foundation.org,
	kbingham@kernel.org,
	jan.kiszka@siemens.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Andrew Ballance <andrewjballance@gmail.com>
Subject: [PATCH] scripts/gdb/symbols: fix invalid escape sequence warning
Date: Sun,  3 Mar 2024 19:25:07 -0600
Message-ID: <20240304012507.240380-1-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With python 3.12, '\.' results in this warning
    SyntaxWarning: invalid escape sequence '\.'

Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---
 scripts/gdb/linux/symbols.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index c8047f4441e6..e8316beb17a7 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -82,7 +82,7 @@ lx-symbols command."""
         self.module_files_updated = True
 
     def _get_module_file(self, module_name):
-        module_pattern = ".*/{0}\.ko(?:.debug)?$".format(
+        module_pattern = r".*/{0}\.ko(?:.debug)?$".format(
             module_name.replace("_", r"[_\-]"))
         for name in self.module_files:
             if re.match(module_pattern, name) and os.path.exists(name):
-- 
2.44.0



Return-Path: <linux-kernel+bounces-168050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 650EC8BB30D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969F81C21F8C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16439158860;
	Fri,  3 May 2024 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQLo/8Ym"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1466C15821F;
	Fri,  3 May 2024 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714760828; cv=none; b=h94BbhPW5d0cvJQI1o0DnrA3cFyHmIRsJ/mSeFLz7TgX0LsTlhGm5o/Oi3StiLqPPK32GbqgO/9iGu21XeT2G5XiSm69xBkpMz1vCC+KM/pgPLNq8zRoT1raAGDfKBdF9dxmi/FMb10iqPA9Xp89fa+G2MSSowKSqe+Fh4exK3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714760828; c=relaxed/simple;
	bh=WvFiEgSn5tehEIbWr+zhin/2jQzVVpQ3np0oFT3uzlw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YQ2dLRqJSHABHcskh9cwVCXpeOE/tnB78JjSbEoyv6Ldbug9cRpZ51KwrmMkx4IwgQTGNoZaI6m4BtSeaOMXqUIriqs0hGWcYS0BzXmywpQcyZKjiPkF0+TfaLmGTWWE01TxtQzDm0pwQCwUZfurZ/pvnaFj7tMaHy6yw+xUwLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQLo/8Ym; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso7102879a12.3;
        Fri, 03 May 2024 11:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714760826; x=1715365626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nUAg0BUuViiOSxOWE5HryQfapyhwir/j1sSAHZ5ssT0=;
        b=XQLo/8YmYEGhNZ7eOSs9915KxBKjNfQXus5/sdV6yQEhbNUaIEh++ILRIMWVeo6ZzX
         k1MOZM1FC4nSult6wJqcrJ8J5DXMPzrI2Iam+u18c8++xsTjuB5ikr8fX2K9qHiLIRVV
         cr5Zakz+Fv9JYvLgqEwNkuCLr9FH37+/iiPVZAJqhMzNtuEyDsDH+JKBGyIcc618k9cZ
         X+C+ZBgAOepJMdJ2ONPqnxS+bTkV0kOhhb/VBNm+i/3/16Q52opmybAOuKT953kY4yCw
         JrHtLZLBi601WoRNzSUVL8PzFOuITXxQ3UXg8GvX/DTuBWbDt91uCKRd4vMfkRg7wuTu
         pyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714760826; x=1715365626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUAg0BUuViiOSxOWE5HryQfapyhwir/j1sSAHZ5ssT0=;
        b=OgIxZ5uxkGuw7iY6d1/crK6XU41kH55qm+y6exbxIaV6ObEyswLGTgx77ZM6kzeQat
         f0KruBAC+Rj8ybR9Ot1WGvplbtWUFglZC37rtkHUzFOiciaKAgV41AZVuUEpTZikdWb4
         /2NFKrl4jP8AQwwAIYh7ggWsv7R5/u0kgWsljTGsXUuF5gCv3ifNzzKdiWPkyStg5Du5
         2VkZR92mhnPaiOpu89kXSDcUaP2C8wcvioyLOL0NNJSH5bq09f/KkStzAAqCcttjnzIN
         g7TMgc8qijpidzGQaAMl2c36miUBdeZhaGqu2HRJwWCcXjOlUKP3XtqmW4Z7qvc6B7JR
         Cd6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkJZRSdL4ZSawhhXwVtTKdQFiF2PxX77rFJ1/1UCRYRfhOlIqFjFxnoK3j2v5WWyLV7r5rlYSKfyvM1+dk5R/O6Hmve3kkytB2Wea3y6raZEwv4YI2JvEbdulWG0N0wRmG8y5jWHNK
X-Gm-Message-State: AOJu0YxhZTk6pco81ANUKT57TSz70zdvLw9knnj24fGT2SCeRjArIq1A
	gOLy7zM7mjMYLCEVNCLU+5s7MjDdWCLqA5r4Ytxv/7L06XDLkjg=
X-Google-Smtp-Source: AGHT+IHiNrNGmhkW8ShVHf9mwUaDtVgLfy7j4uBv+iYDxtWyIYCzifz25q4kdnSA/BwWkbtwihWXMw==
X-Received: by 2002:a05:6a20:8429:b0:1a7:3b4a:3e8 with SMTP id c41-20020a056a20842900b001a73b4a03e8mr4346044pzd.7.1714760826221;
        Fri, 03 May 2024 11:27:06 -0700 (PDT)
Received: from utkarsh-ROG-Zephyrus-G14-GA401II-GA401II.. ([112.196.126.3])
        by smtp.gmail.com with ESMTPSA id gx8-20020a056a001e0800b006edec30bbc2sm3359796pfb.49.2024.05.03.11.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 11:27:05 -0700 (PDT)
From: Utkarsh Tripathi <utripathi2002@gmail.com>
To: corbet@lwn.net,
	akiyks@gmail.com
Cc: Utkarsh Tripathi <utripathi2002@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v3] kernel-doc: Added "*" in $type_constants2 to fix 'make htmldocs' warning.
Date: Fri,  3 May 2024 23:56:50 +0530
Message-Id: <20240503182650.7761-1-utripathi2002@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed: WARNING: Inline literal start-string without end-string in 
Documentation/core-api/workqueue.rst

Added "*" in $type_constants2 in kernel-doc script to include "*" in the
conversion to hightlights.
Previously: %WQ_* -->  ``WQ_``*
After Changes: %WQ_* -->  ``WQ_*``
Need for the fix: ``* is not recognized as a valid end-string for inline literal.

> The kernel-doc script uses the $type_constant2 variable to match
> expressions used to find embedded type information.

v1 and v2 discussions: https://lore.kernel.org/linux-doc/640114d2-5780-48c3-a294-c0eba230f984@gmail.com
Signed-off-by: Utkarsh Tripathi <utripathi2002@gmail.com>
Suggested-by: Akira Yokosawa <akiyks@gmail.com>
Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
---
v2->v3:  Updated the changelog of patch.

 scripts/kernel-doc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index cb1be22afc65..58129b1cf3f4 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -62,7 +62,7 @@ my $anon_struct_union = 0;
 
 # match expressions used to find embedded type information
 my $type_constant = '\b``([^\`]+)``\b';
-my $type_constant2 = '\%([-_\w]+)';
+my $type_constant2 = '\%([-_*\w]+)';
 my $type_func = '(\w+)\(\)';
 my $type_param = '\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
 my $type_param_ref = '([\!~\*]?)\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';

base-commit: 4d2008430ce87061c9cefd4f83daf2d5bb323a96
-- 
2.34.1



Return-Path: <linux-kernel+bounces-58250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA5784E37C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 569F7B233D4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93C87A713;
	Thu,  8 Feb 2024 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="JeGk+hdY"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E111E89A
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707403933; cv=none; b=Yxod16wEuoyij0YGcNhkibSYUaOFacs8zfIkgHOE/VKKLeoQ5mdTBW5ZTd3oAiyWndA+EaG6WlRX9Aq5/X8ambSjMynAR0EBKB03826+0WIuO1e+MX+y3DSax/A/tKhJJYLfDn/b4gC3zLtawRju7ySfPUCGMhBFI8G8VDjlzsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707403933; c=relaxed/simple;
	bh=8aXxMqKjuGYAZbxGk8K/JAdM76UCaTFG5zJidRIuLWg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YNgPfa4RhQweeROR7yM0GX5uKde6KMiIvX4vohoD/KsncPKo/YLFI6P+G31xB3wCmPQK0dzybna4Bgw/vD11o+PAvefInL182akihWVic+6pCuhyVMF5uQiK4pOcEiHRpnwHYtZlrzdKM1eqWo8tDI9lKnM0lwZi1rGMjq58thk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=JeGk+hdY; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a381df83113so194069466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 06:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1707403930; x=1708008730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2d3bjISixj6XxfcjFNFffsbfi1JCl6LveKlFSzCZnjI=;
        b=JeGk+hdYZTj0eVsDhqIns7VzmdjERt3De3j4me5wo1de0FdOu+ARuNdaaz8P6oFpsG
         o/87pOazLEIsZb+aPf95b4j7zs844l96MEmWA+LU1Md1MJp2liV0osNdNotV/MNkbmpu
         yiBgo685IjNltGB6jMghmehJ2G+OhFpTd7lDAMAzcy+GYAWJutwwbfG4FUSmO/kPTVWR
         1Fwy0jTyHSldT1noJN8kseJx2rBHvElYA4t4x1wUK6nEoIE8Q71oVD73JPGQj8vqlQyV
         npb0G6Iz3lzqE2M98zrUcen6SKiAv/lIMN5EbTweONEDY1Xf5r3nXpBrg9grOek4OjkD
         v8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707403930; x=1708008730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2d3bjISixj6XxfcjFNFffsbfi1JCl6LveKlFSzCZnjI=;
        b=NAqU6SzFhQ9ZA+4DIKeHmlNHK3Hje1rg5Er/0nS4ekAYXMAbJsAm8nRAQM8bWU/GWl
         nThhEC6w1YgNb8zfeOAHjbg3Y2c6vBcIByV5N82vYjEdc2j0aPDuV6ygS168U9iR2poV
         oOsfCMpqQqzhT8f1/rN4US+o0jw3BVzAi8MyIJjCEfHPWoMI326H9m/ky5qW7FjAZ5Pm
         e5dt2G19fkOVLo3n4vBFJ1U939z4hsaJKv4YKYaoDXI1/hQHsKpblEQQVHu8Ky+6pXrx
         TKKdEJNyI1PCTjuYRx10MRYz+w5DkjnlhpYEO3gT5uz7RaqsT62dYE4TgivI44cyAH1J
         06+w==
X-Forwarded-Encrypted: i=1; AJvYcCUEHwtB/DAiKk/ofdT43p8/VaiprYQbmVVDS9uw4lvpN/P68s+0TW7POFZWbSjxrAezvX6Si7rMp/UuZB3YWKWezjrpbaRYyvc1STJq
X-Gm-Message-State: AOJu0YzFlKgnrYekS8YOKhNN1xfbrA0i0f7b5oxUKr+ukX+33v/kMbpV
	tTu6QjY6A5Hb9rGIg5EK2fysb+xl2N/OabNjdryqxxadVacb+IhfWzO6rVVxIQM=
X-Google-Smtp-Source: AGHT+IHHw955E7ZE/Q0T8Z6irZg1N/aCs3IbXoNVqw0WOLKE3K9HUNR49ZCRYJjEmj5ZfhzbTjvQVg==
X-Received: by 2002:a17:906:5d:b0:a36:3c59:3449 with SMTP id 29-20020a170906005d00b00a363c593449mr7096417ejg.56.1707403930393;
        Thu, 08 Feb 2024 06:52:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWX+VIhhLkDx/C51uQV+PvNpVgeYss76QEu3Fd+6M96VTCfqgZ/Q+Tt1egxnwQUla/veuyA3FhPG8GcgYW65/Y30mMrw3dnuMS5exJUn75yWgK+xU/uSffTtPMI4fs0Edymc4Tb4Fw=
Received: from debian.fritz.box (aftr-82-135-80-180.dynamic.mnet-online.de. [82.135.80.180])
        by smtp.gmail.com with ESMTPSA id v8-20020a1709067d8800b00a3bb6de59ddsm122994ejo.100.2024.02.08.06.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 06:52:09 -0800 (PST)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] docs: Makefile: Fix make cleandocs by deleting generated .rst files
Date: Thu,  8 Feb 2024 15:50:01 +0100
Message-Id: <20240208145001.61769-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The script tools/net/ynl/ynl-gen-rst.py (YNL_TOOL) generates several .rst
files (YNL_INDEX, YNL_RST_FILES) in Documentation/networking/netlink_spec
(YNL_RST_DIR) which are not deleted by make cleandocs.

Fix make cleandocs by deleting the generated .rst files.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 Documentation/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3885bbe260eb..4479910166fc 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -176,6 +176,7 @@ refcheckdocs:
 	$(Q)cd $(srctree);scripts/documentation-file-ref-check
 
 cleandocs:
+	$(Q)rm -f $(YNL_INDEX) $(YNL_RST_FILES)
 	$(Q)rm -rf $(BUILDDIR)
 	$(Q)$(MAKE) BUILDDIR=$(abspath $(BUILDDIR)) $(build)=Documentation/userspace-api/media clean
 
-- 
2.39.2



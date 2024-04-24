Return-Path: <linux-kernel+bounces-157037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C868B0BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F451F28692
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B461F15E1F3;
	Wed, 24 Apr 2024 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qAOA2Lir"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C8115DBA3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967555; cv=none; b=hH+gWJJc85WGUVaDScABawZEdGqkmCz7H0J/bNJAxMOBBxYQXqHKDPxanhb5qo2g0DCXXkVctB+zexp0IT+P0hBMKdGgcNlwCX3ffMI+7JzYc+fnWYYmYNDCpxQTvXqIW0LBRGAa/7H4ZCazYYGsYPJLTsqKEnmb7/FiYXQe9wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967555; c=relaxed/simple;
	bh=VQpU3J8REVi32pKGrBL39GnkkEpNRc/YcEXuNzhQ7S8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u+X3HWSjeX4d2EnOAyljvMDDxLKNms51xbA895mw6X4h+Wl8LhSxlQQGp4tqjtzW5HniKMPT4NZVJv9Fjl2Ekw3KsgpF2Sfz8a9YXsvFBJHRAPS+bKQJxN7nYe39k6OhbEC9eNDpSvhGB2b784O7TrIBXHIIghqCA1SiNqy1lSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qAOA2Lir; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34b1e35155aso3586300f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713967549; x=1714572349; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jOW6A3oiYgpr232UrDpTzT4iOIowEWVRq6fTiYcPrAY=;
        b=qAOA2LirM+IP0oWchIYFD5yXHCXD84qYXWxEvNuaf8z4/X6d6oUSbOVFjuZbboOle+
         yA4hV4OowFqxAiPKD5tQkrXYs3JAX1VO28dEDqfSRbcU9D/fI9N2sWuedUz5cZnF4UTV
         ErO6C9Ud5WBsO9MEpVZpDmxLKVFP4avDTRHqXQTD3Upe1hXh26XbIxOTqa4M6+9roLph
         1JEHjgUIpDy7hnrCCbBcq6uDdGf7OmvKZvKb2PQrYqa2ompKOpYDmZ2IgQkq9ikKfO3X
         NVgEee9JEUFJD9TYSH/YI0Z62+8Asfq++46HtPy9MjWe3+7Gt5/GDrbe/ATEulC8oUTj
         B9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713967549; x=1714572349;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOW6A3oiYgpr232UrDpTzT4iOIowEWVRq6fTiYcPrAY=;
        b=CrSqnYlxFTnNw4I+M3WsrzzfNUZu0OPjPMyAMg/oufgnOtOBC/zA30HNlyYEpLMkKC
         P3sxk3Nj9auSciE6PfQQ19221PMOjaTomEMSgrluZc32II8D31LAppNrQOxUcm2kMMVb
         1sMSbpFp02qnQ8j6xyNBerZNtKjdYBR66nzcthXFDcCFhPqXcVX8TQeR4CmYw5NKhuUK
         ThB2asO6DUMpt82MlphKe26vsYltlrjqABnejAVkOxgObo0cAVThhZdxsYF+xMMofGCs
         19WzixNFl8C170n3RcfWHHSTIHNLLbFLm2YJtMKd+eU3djrX30xvAVI9vT5J+5TuF6v+
         ubWA==
X-Forwarded-Encrypted: i=1; AJvYcCUrfi2BJ1p8YLRTCuh4S93XsMIe3bk3fW+iwwDHnMGC3MNVA7O1E4JUkKUXLHGVDxZDf8iUcT2w8ejdGxhuCg2uNSJ1EvFoYFPMgWMM
X-Gm-Message-State: AOJu0YyRSXqQ+QL+frc0yvulsA/BKuKMgVAV5ShFOaER8yQGnmbSY+Cg
	9jFloX7IRrrlsPOectF58HVb65+MvkphglPGpz/pDRbd4EIOwJAZU5G+8ZSdv4lMdVx1H3whQzs
	QEco=
X-Google-Smtp-Source: AGHT+IH5ZR/K91tZ5wMMCx9SFvn1/tZovp+japncGiIcosbRMA1+HnVP0IkzAAq/JNjIKwqR1fh5Jg==
X-Received: by 2002:adf:f852:0:b0:349:92b7:c248 with SMTP id d18-20020adff852000000b0034992b7c248mr2527970wrq.29.1713967549288;
        Wed, 24 Apr 2024 07:05:49 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d48c8000000b0034af40b2efdsm9105325wrs.108.2024.04.24.07.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:05:48 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH v3 0/7] kdb: Refactor and fix bugs in kdb_read()
Date: Wed, 24 Apr 2024 15:03:33 +0100
Message-Id: <20240424-kgdb_read_refactor-v3-0-f236dbe9828d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADURKWYC/23N2wrCMAwG4FeRXltp4rqJV76HiLRNthVllVaKM
 vbudgNBYTeBP4cvo0gcPSdx3IwicvbJh6GE/XYjXG+GjqWnkgUqrFQFWt46stfIhkppjXuGKJE
 NUutAk7WiHD7KxL8W9HwpufeprL2XHxnm7per17gMUkkLB4ekQDU1ne5+MDHsQuzE7GX8MRBXD
 SwGk4a2Iah0y3/GNE0fFOAO1fkAAAA=
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Justin Stitt <justinstitt@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2027;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=VQpU3J8REVi32pKGrBL39GnkkEpNRc/YcEXuNzhQ7S8=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmKRFQ+4om7JFZ5/EK9HqNC93TVLDNHWXLVlKqI
 N6SlLkUuAaJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZikRUAAKCRB84yVdOfeI
 obpUD/4/S76jZAwd8OokxxtwLhkWuqSLZOblWBwwa1YS/Vr8EogcBxq07lkcO5Qj+XDF6/vrxC+
 H5MjHqmyhShW9raMeZTi6VwYNKh6eFtMa0du4MyTbt9LfDY2EPuePdiZfULwEwhUD14ux1tJlQB
 YIPeK7Vwd10vnJ6bpS8VeONRmHWcrYax864C187IHI4TfoNyFjIi8HttyDIj4oOK43vsYvB5gXG
 ExYEvtVpwCzJRlbV/GaPhSS9wPg2Pthdp/6UhXjGssTv6GWbQbZzCzs0GyMxb/4wHPFyAcAa0Um
 RiMowggoPHC80GsBXfZV6lQchI5l8FtmgC4KFiiZfDSkK6i8slwxYf6ZOdk98pIgHFMaGU1nwM3
 176+voUW/Z4E7vZZJiRbQZlZFeuq3UXQ3PPURa/aJfY+MoYSaQ6KQ0hKDRvUaDxnVJIY9jfM9Bv
 oqHAPtTOPfE1p7ceVWc+MuFgEKPXe9r2HvEhYp9i20HgbImXX0RlmV56ojnfrgzdFpCSmuJmkx4
 +bnti2LiMNhug0bJROEF4iFFRtfIvE95E7qsfNN5lE2h8m994rXZAN7OFrj9A5T14jdzQDwUOTw
 IGf1EPbVO+IFCboN5BHeGnjvL+4vtyWUEkcsFs5r5RywpTOegCKUEtfX7KChIy5fJcfiLsZ0ejN
 gsgmyNOPEKh5zLQ==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

Inspired by a patch from [Justin][1] I took a closer look at kdb_read().

Despite Justin's patch being a (correct) one-line manipulation it was a
tough patch to review because the surrounding code was hard to read and
it looked like there were unfixed problems.

This series isn't enough to make kdb_read() beautiful but it does make
it shorter, easier to reason about and fixes two buffer overflows and a
screen redraw problem!

[1]: https://lore.kernel.org/all/20240403-strncpy-kernel-debug-kdb-kdb_io-c-v1-1-7f78a08e9ff4@google.com/

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
Changes in v3:
- Collected tags from v2
- Added comment to describe the hidden depths of kdb_position_cursor()
  (thanks Doug)
- Fixed a couple of typos in the patch descriptions (thanks Doug)
- Link to v2: https://lore.kernel.org/r/20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org

Changes in v2:
- No code changes!
- I belatedly realized that one of the cleanups actually fixed a buffer
  overflow so there are changes to Cc: (to add stable@...) and to one
  of the patch descriptions.
- Link to v1: https://lore.kernel.org/r/20240416-kgdb_read_refactor-v1-0-b18c2d01076d@linaro.org

---
Daniel Thompson (7):
      kdb: Fix buffer overflow during tab-complete
      kdb: Use format-strings rather than '\0' injection in kdb_read()
      kdb: Fix console handling when editing and tab-completing commands
      kdb: Merge identical case statements in kdb_read()
      kdb: Use format-specifiers rather than memset() for padding in kdb_read()
      kdb: Replace double memcpy() with memmove() in kdb_read()
      kdb: Simplify management of tmpbuffer in kdb_read()

 kernel/debug/kdb/kdb_io.c | 153 +++++++++++++++++++++++-----------------------
 1 file changed, 78 insertions(+), 75 deletions(-)
---
base-commit: dccce9b8780618986962ba37c373668bcf426866
change-id: 20240415-kgdb_read_refactor-2ea2dfc15dbb

Best regards,
-- 
Daniel Thompson <daniel.thompson@linaro.org>



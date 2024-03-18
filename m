Return-Path: <linux-kernel+bounces-106148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5431287E9DB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DEE52822E7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF2338DDC;
	Mon, 18 Mar 2024 13:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gI4W76Fd"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF92C383B2;
	Mon, 18 Mar 2024 13:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710767337; cv=none; b=r+wr73QzhyRxLOXNnNzrVtlATFxbfDWYxMR3R5h2kzjkNKw6eUO6iWEygy6Z3izP+lBtfIjRNnrnYIsBwcQYsI3GCLXrWfxINOjebx74VuPOigQr+tExJ9S1WZqmeBWtVR5dEgkKF+orCK/v6mufUkQrCQpSuL5feUCoEtj7f/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710767337; c=relaxed/simple;
	bh=tWPkRR6HFcuKpjkZ82VVuu6HbeGvuiB4aXSvt84YX24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oxyM48zEAy1Tql4mIetIt38gL3HVXp8vITJQdSWlr1d+QfzVy2iBnN8cATNtJ+laqR57CzN8ZJFuCFsyQ8zLNe8LFvfzKgpuKGE1+cFguHQW5UQobhftUWbDYACisWMuBT7FufhpZneYqsGYIkCQ26r8q84GFvCkc5z9gb2kXes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gI4W76Fd; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e6ee9e3cffso2525983b3a.1;
        Mon, 18 Mar 2024 06:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710767335; x=1711372135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1U28bb7gbM4m0sLestvOG+gnqR02WUXbA0L+LnulGYA=;
        b=gI4W76FdWVFZS5k+j3bAc8HCV+UrXIsz0pPfDX89FxC8jE9zzKGof5OEo+r/nfqlbC
         BeS7da6pMEY4e9bEXlS+D/aUOH9/UQ1+Kx0Csl8ja679XYvXRHgMAM6snvCMt1QqJsiP
         8TY2p+reRXTkQcNbiiVXfol/aWpEjdQYG72Wf/W2kDPxFOka0DW/feeIHOW1Xa+mu70T
         ol0LDJ6fzwlg/lWX6er2okgTJuHsD+SXgFWrbiViQLPvPttDjlmBfhnFfQfmwbVjCetu
         INP9i0/i5FWFmWhcY/1p+F6Qy8rG60zJc3s+v06CZwxILydBPLfW4e0NRK8yVxbXtJAa
         +r0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710767335; x=1711372135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1U28bb7gbM4m0sLestvOG+gnqR02WUXbA0L+LnulGYA=;
        b=Kjh/E20oigAHYrF6cQN63ICRVz7PmUp3Rs7B5csMxW9/pEjE7x7v8XXLeBENWaLICj
         KXvktqJLK0TuXMzZq2IBPTcpiYQaqjq9bUXYyaTg/gG61N7D2+meTtWNRjDexmkJuxzo
         wulAHZmNd0SuKD9K2+1z+DMVPmQ5GS+Qd9zLhr+OUQ0LbIaoAu2YCoOiTXhog0oshrqU
         V9yq+dhL8Fa+nxsbV+dMT8SfhqeKN/U3X3i09oNw3fLVsBjolTBqwbB7wFRhsR+Hz8Pr
         glf7yemltz94QTeieXgo5vpDQGMBXrfHuw4wz2HoO4S9aTDaIBjO1frKSisxthygWAts
         mUUg==
X-Gm-Message-State: AOJu0YxikId2tZxRs6cC5I3lewtNyPKm8G6wEqkreXtwb666pzwaozPC
	xqICVfTsolwlUU6fz3zP+55utf8G4A6NCVdeLFRPUXWsOgQFKbUr2IP1EIWx
X-Google-Smtp-Source: AGHT+IG+TUImjy/h+WKY5SWloTE3yLjy58p6P2kH2X3BIS3V4u11kFxUkJRzIAVT+9uLButYUk/WjQ==
X-Received: by 2002:a05:6a00:928f:b0:6e6:c256:9d49 with SMTP id jw15-20020a056a00928f00b006e6c2569d49mr19782479pfb.0.1710767334603;
        Mon, 18 Mar 2024 06:08:54 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:31f8:807c:8911:659b:1495])
        by smtp.gmail.com with ESMTPSA id f31-20020a056a000b1f00b006e6bcda8481sm7932304pfu.164.2024.03.18.06.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 06:08:54 -0700 (PDT)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH] spi: lm70llp: fix links in doc
Date: Mon, 18 Mar 2024 18:34:21 +0530
Message-ID: <20240318130840.74589-1-five231003@gmail.com>
X-Mailer: git-send-email 2.44.0.273.g4bc5b65358.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update links in the documentation which point to the datasheet and
schematic.

The current links don't work because National Semiconductor (which is
the manufacturer of this board and lm70) has been a part of Texas
Instruments since 2011 and hence http://www.national.com/ doesn't work
anymore.

Fixes: 78961a574037 ("spi_lm70llp parport adapter driver")
Fixes: 2b7300513b98 ("hwmon: (lm70) Code streamlining and cleanup")
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
I didn't find the schematic link's TI website equivalent anywhere.  The
board (not lm70) also doesn't seem to be manufactured anymore.  So just
in case someone is still using it...

 Documentation/spi/spi-lm70llp.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/spi/spi-lm70llp.rst b/Documentation/spi/spi-lm70llp.rst
index 2f20e5b405e6..ff98ddc76a74 100644
--- a/Documentation/spi/spi-lm70llp.rst
+++ b/Documentation/spi/spi-lm70llp.rst
@@ -6,7 +6,7 @@ Supported board/chip:
 
   * National Semiconductor LM70 LLP evaluation board
 
-    Datasheet: http://www.national.com/pf/LM/LM70.html
+    Datasheet: https://www.ti.com/lit/gpn/lm70
 
 Author:
         Kaiwan N Billimoria <kaiwan@designergraphix.com>
@@ -28,7 +28,7 @@ Hardware Interfacing
 The schematic for this particular board (the LM70EVAL-LLP) is
 available (on page 4) here:
 
-  http://www.national.com/appinfo/tempsensors/files/LM70LLPEVALmanual.pdf
+  https://download.datasheets.com/pdfs/documentation/nat/kit&board/lm70llpevalmanual.pdf
 
 The hardware interfacing on the LM70 LLP eval board is as follows:
 
-- 
2.44.0.273.g4bc5b65358.dirty



Return-Path: <linux-kernel+bounces-160632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 692AF8B4074
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB898288328
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC881D54A;
	Fri, 26 Apr 2024 19:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QkN2T8u7"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EB0D2F5
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 19:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161121; cv=none; b=Z/IcMxV5uzz2MWgtyuyejscVsFHoS0UO4zcNZAEzI7EfyjhrtqBoxkir/JpdZjTaQ9mN+zVkHAzFAmpszNVB1DiS0umi9WR2Nmt+Wt9oZCfXRObKp6l55wmQ1JLJVGEer7rh+PlEPOdDoyuVn6qw+DZg8TdKCSpvrBdZsplx5T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161121; c=relaxed/simple;
	bh=R1W6vHYcw8AnROOuBMRG9FJduKafc3tpGbFw0zf/lPk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sxEcZD1ph10DViSgZ3gfZ5J3dlFYh6hIM2NGWWS48rqaDKvPy0JaYTMPRnJf6hzoJ5QIAsUrpa62/kHiGK2ErlIwzIqJBYuLEyHQIGvzLY0e1euTqGSCyEpkdbs7QwrBn8aOOtDnYg214pBJrOLBu3cNNPR6C4vJHmVseF1QAmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QkN2T8u7; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d8a24f8a3cso30867311fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 12:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714161118; x=1714765918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fvLmWeeghzdrID2duG0aa4KVt++e5bGrGNtFmwik+SA=;
        b=QkN2T8u73rAq6bJeO3/x7We8+sLDfBkkbNTsvJQ8L11mt+oWR0CnDYN+xFDIx05kpq
         xxEyDU9pW99O3gBNDgaUMHev2IFFNr+UDQrHyH2a4wM6kGFY6Tcnaz0g7d8WzEUc+wgt
         BxgfdTTx326PCgYVS+KKV7fiFgxF4ruciYPTHjkeu33hTwiDRe2ojldN9ux2jOez6BZX
         EKQepIQZMO2BTI8MpXG8iDLDxDRkzFRXRhsj9oNl3u3670qpKcXjWG7RhjOPpjYEsDiB
         //VG1iV20xTIqTIkZMMSNJPJwlQznr/vHX1a3nyJ8UY/isWcevH7sBxBOhF2FiGkTR7w
         r3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714161118; x=1714765918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fvLmWeeghzdrID2duG0aa4KVt++e5bGrGNtFmwik+SA=;
        b=Q7byntVV9DWbaYxqOmRVxb/zlzbHFGDC435y1rAdk3cO22snbfiXIJySm56gLkTCqq
         5gtE0DkcIJ7oMjNDJX22HfJKVodmwTENlPoHIWY5H6WRFQZGMHgKfvY48tNQYSskOsa4
         rqteuRpQ9ebHxQsLVRldj0V4WsN6H1n6M3FdHKik9HNOhAIoGxKAV2cDCEYR5frDNU9L
         v46q5NxRBDWwyA6aD17RhGVq/q6FvRPYTSV7zJbpbniGijedASDwoCx0JcSxoIiSIZDQ
         ChW8ZeXvAO+JcFbukiWMkIlelX5CNX/FBkiP+WaAX7JN9HXx0QK16wgsKpYTJv9W6Ocb
         N2Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWTI0ttiqBwp0bIuOo1JsyV4VdTYB2fHraJgjreXgXrutK2CvWTutJRyf7QPZ2jw1xUJNsSRYVU3wD6bo6csul5uy6LmavCaNlNY9Sp
X-Gm-Message-State: AOJu0YzDm5Qs2gfmm0LZWgKfZLqaDg+FFwJmSaKP8TWSGyiQ9OlxTsk/
	YKGPevvXX5Y9ZK6wZRP8m1wXeLN7SRq/lgnfaCr1Lh96L46C0U/CmgKssoGGOHw=
X-Google-Smtp-Source: AGHT+IG8o/Hca/6+Sfk2XWWkH50RA8dFZjuc7k98uFzCyTjq+qPj/pacT6A8aBxS1soklNoaLZBCPg==
X-Received: by 2002:a2e:7811:0:b0:2dd:c9fc:c472 with SMTP id t17-20020a2e7811000000b002ddc9fcc472mr2088265ljc.26.1714161117808;
        Fri, 26 Apr 2024 12:51:57 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id g15-20020a2e9e4f000000b002d8c66e401esm2739049ljk.58.2024.04.26.12.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 12:51:57 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.9-rc6
Date: Fri, 26 Apr 2024 21:51:55 +0200
Message-Id: <20240426195155.160462-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.9-rc6. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.9-rc2

for you to fetch changes up to e027e72ecc1683e04f33aedf0196ad6c3278d309:

  mmc: moxart: fix handling of sgm->consumed, otherwise WARN_ON triggers (2024-04-25 17:48:46 +0200)

----------------------------------------------------------------
MMC host:
 - moxart: Fix regression for sg_miter for PIO mode
 - sdhci-msm: Avoid hang by preventing access to suspended controller
 - sdhci-of-dwcmshc: Fix SD card tuning error for th1520

----------------------------------------------------------------
Maksim Kiselev (1):
      mmc: sdhci-of-dwcmshc: th1520: Increase tuning loop count to 128

Mantas Pucka (1):
      mmc: sdhci-msm: pervent access to suspended controller

Sergei Antonov (1):
      mmc: moxart: fix handling of sgm->consumed, otherwise WARN_ON triggers

 drivers/mmc/host/moxart-mmc.c       |  1 +
 drivers/mmc/host/sdhci-msm.c        | 16 +++++++++++++++-
 drivers/mmc/host/sdhci-of-dwcmshc.c |  1 +
 3 files changed, 17 insertions(+), 1 deletion(-)


Return-Path: <linux-kernel+bounces-37962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39EC83B8DA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020311C23349
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7517710A05;
	Thu, 25 Jan 2024 05:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kthh0rOS"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7BB1079D;
	Thu, 25 Jan 2024 05:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706158837; cv=none; b=QzkHpG/gryJ858rlwbzAv9QO8SqDsqpc8kt1LHPwYHZUcZUHuhQDoqIjBKMvJ7EUykJm6fOmGj9UWUXVrWftk4cl5ByyUwd6SWWsdzBJvHGwUcCuJ8UQelKA1o6XRCrK6Al+c/wI0bCm5l60fGRKR7+BSLzrqKIcn+zrcen/lig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706158837; c=relaxed/simple;
	bh=nzYKlUKWsbCuEcHH86W2xJifvKAS1jxnxnES3Fo7LXQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Aq6Y1dCmcvOAuP9tSob3izvFmQd9S4yUFHg1BwVsmJeDP1v1pYY0DtPiuaXFzOTe2PjTlp1MFqqOksosqn3LSei9C44idK7AvLEd0rVxHMA9IK4D3zfLeGWdBUNaAj/XXCGOUArj+PY6howvOGXtPt8NlBrRBZlD6JEuaRhmrVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kthh0rOS; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5989d8decbfso3864158eaf.2;
        Wed, 24 Jan 2024 21:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706158835; x=1706763635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4a9Blzx9l4OEzkWFPQx1BBFsuuq8n7ycY+8Z5uXBb/U=;
        b=kthh0rOSbU7R6TFRbd62g+oaexcoCHZpCzni9A0uEiA95zVLMnQ94s12zUVsTSuW+z
         i19RBKAPzkWQXxtdRyL82fYUT6AUlrbL489OwHruoeGH9lXpZpiI4DdaWUUypKwg6vSJ
         zHW47itU20cpRVtIaJJGVu7QprPj7CVy+hxocjNnPP9LbT2GkiARDrBS64saOKXp0vmq
         CpdgOtOljhTfXMQ+W4+KpiEM9IRTTCSAcn0sS5012oxwiRJ6pakbQNg34J6h2e1yQxxh
         Gy0Sde3paGF78Bn4Xcxr19Ea0ENrfQItyqoLgwuTL7rIaOzk4prUl06sOuvfQgGgo744
         1U4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706158835; x=1706763635;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4a9Blzx9l4OEzkWFPQx1BBFsuuq8n7ycY+8Z5uXBb/U=;
        b=d2W31lc9LsRJkkgP5scLPtYW1Cehm9rZ5EdLnRW0+e4yWYLA0mA/DCSuPVF/C5hdyZ
         qo6FgXb6KuLn/2jpC7Ybul5o7dLiBotgXKykQ6A1KoYnMqypAY9zgaALrJZSdJTN2BaO
         YClrJ8OW1OW8ScaJCCVWuahS5FDbyV7YSD6sK78wJXguM1KEIzyOFCvrSa4x0OXO6Tqg
         owHhMXVjaiqapgE67J48TMQBSVzyVWw3EdX8GNvxIc4gK0MqGh0fip8ZBD1qkRlqSwqu
         EeQWlLwf3nBBKy5F0Mv57a6i7OQmf6pewB6NqoOaHeZtcaDGIMK3qhDsnGvkpSzH/eQK
         93vQ==
X-Gm-Message-State: AOJu0Yz/V5d4DifcEsu/MtvmW8R32w1U3Z05XBzrX9MLibfLlFuC1V9u
	iK0wlpg9ass1aG9Fe+CRvlF6Tjeu256B2m/IgslmiXAd/7u9wwfw
X-Google-Smtp-Source: AGHT+IH66vrYRLBN87F0CNqyeUf0N2eJiUyq++LaFIERol/QPBGMcfpDQxvMnh56DaViSVL3hoP3fQ==
X-Received: by 2002:a05:6358:91c:b0:174:f48c:3871 with SMTP id r28-20020a056358091c00b00174f48c3871mr551554rwi.43.1706158835340;
        Wed, 24 Jan 2024 21:00:35 -0800 (PST)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id j38-20020a635526000000b005cf7c4bb938sm12549382pgb.94.2024.01.24.21.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 21:00:35 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: corbet@lwn.net,
	costa.shul@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 1/1] docs: Fix subsystem APIs page so ungrouped entries have their own header
Date: Wed, 24 Jan 2024 20:59:41 -0800
Message-Id: <20240125045941.123297-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

The kernel subsystem APIs front page currently has four top-level
groupings with headers, and then everything else that isn't grouped.
But in the table-of-contents, ungrouped subsystems are indented as
if they were part of the preceding grouping (currently "Storage
interfaces"), which is confusing.

Fix this by adding an "Other subsystems" header for the ungrouped
subsystems.

Fixes: 3c591cc954d5 ("docs: consolidate human interface subsystems")
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 Documentation/subsystem-apis.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
index 2d353fb8ea26..74af50d2ef7f 100644
--- a/Documentation/subsystem-apis.rst
+++ b/Documentation/subsystem-apis.rst
@@ -61,6 +61,8 @@ Storage interfaces
    scsi/index
    target/index
 
+Other subsystems
+----------------
 **Fixme**: much more organizational work is needed here.
 
 .. toctree::
-- 
2.25.1



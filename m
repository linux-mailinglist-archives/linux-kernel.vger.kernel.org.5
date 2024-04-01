Return-Path: <linux-kernel+bounces-127050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC46894631
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2431F221E3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564EE5645E;
	Mon,  1 Apr 2024 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EC540SP4"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BAA54FBB;
	Mon,  1 Apr 2024 20:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712004342; cv=none; b=KzyWcWH/m3IbmAbVBaQSshasMErOC0QrDeQnca3KLV18vr8UJ0nFBBiSEduV7Y/Ga4/PRW2bMCEtkcHKol4yIwTpdEdAzhhyhO2YsL32pklBFFyDxIVpveqirgPzVVAVarGWmg8Dqz9t7tdPgdcvf/QNLre6SmEuuVObwMUMmDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712004342; c=relaxed/simple;
	bh=sua5VLA6KkFsQ6NzCcOvzTLprrreYLIRA3mEbWhHLQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SKzqmcWXKWXkPlQvDk0WlJXohWW6Pce1ajKJHlMkHSv0v8WXpd7VZ3R6TglxsFSH1sNeJT1JqJTX2q6/TlKumgSr58vakdQoOqWwA7Cp0ygokZsqssoSN/Ne3hxS22MNpLDqZu1bfWD1MzHnvJz2oz5ZLRcYjc9dZW6PVbsHaqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EC540SP4; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516a97b3139so1345138e87.2;
        Mon, 01 Apr 2024 13:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712004339; x=1712609139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEuR9ElxhRqiM1XIhL4AsfoADbljcyobBZXJVqn5wzI=;
        b=EC540SP4Ckol5oEv1Od0wrI1yMQN/YDJtGKMjbAqM+0knc35m5utzMq8kBVMjAaOud
         eieyAweF8uA7S/Tkjz2cG92/jKk4nwt8aDl7nF4zKDcx7JveOU1qxw55GAD4t8IXh7zF
         TXowf59fOBrucwJdRgSdt6Wn3V8JptDqTHEAQqywuvm9BD+WKIFLu4e/rxBtpOQ0LuCm
         hmdrJFQshrj23hrXDJjXqhJqWRc6IuUThKTciRKu3r+nSlKUxslAWB3NvD8MYAH/F8yW
         /KbicmYUoAAKbLcoQu08efC/nkmRoQ5EzTr9PXCpAux6q+FO2VIZ1xAw2n0j2sq3bJf/
         byrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712004339; x=1712609139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEuR9ElxhRqiM1XIhL4AsfoADbljcyobBZXJVqn5wzI=;
        b=ZPSavsoafVFRV/qNPj6Zaipyipr1tCHoM9WyQmshPzhVnalzWNajcjT5zBAqFuZIhZ
         QQm4NOBD6MIqCs0bFb4IQmdjEl7AIJ/UeuXkpGRf5B3rO376+jEzWDZT28s64NJhiwnQ
         t0UlVIpLskQB1Xm6vJDdq4OPupGynjObAfBV4wLSEZWvX41ugnabsOdqqtnAZrsktfRk
         9bDpQog0RjD29KQ4WyDUEpIwKw5/dIXhMleEfWyHrVtVwxi6QtoynVDNM0VA+Lydx2dt
         UjWC9/0PIZVEKa/wp7q4epZhG1DCowK4DJv2vewR7CmzGSatFXa/Sk7nOavR5ymiHGDJ
         yRDw==
X-Forwarded-Encrypted: i=1; AJvYcCWUsvVtf6AZfSm5ii8ydT1bYPq6Q6XuP4Nm5xxJiUgiqonfelwOmPb+k2HpPIM2X0wN2VIUnIr8EHWhLmGTHtyugB0gPIvU//6tm9fY
X-Gm-Message-State: AOJu0YwfLrJG5pJ7Cr7E7UrrzQTplqjS3Y33ejQy39JLPAH7mPmDsPfW
	Ke6LB19DfqCNWLXqSLi0HxYNMCFQ86GFOSE7rMDpjkOGxFWwOfuc
X-Google-Smtp-Source: AGHT+IH1tcceJW6c5fZZzahWnIiGK1Rr8MhBSj69W/lZaDaRW9MoQTwvrsLSGeRVj9nYHuT+pH5q6Q==
X-Received: by 2002:a05:6512:220c:b0:516:ae56:4cd7 with SMTP id h12-20020a056512220c00b00516ae564cd7mr2145033lfu.35.1712004338098;
        Mon, 01 Apr 2024 13:45:38 -0700 (PDT)
Received: from localhost.localdomain (2a02-8389-41cf-e200-5145-c12f-55fb-574a.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:5145:c12f:55fb:574a])
        by smtp.gmail.com with ESMTPSA id l3-20020a1709067d4300b00a466af74ef2sm5646751ejp.2.2024.04.01.13.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 13:45:37 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
To: dan.carpenter@linaro.org,
	javier.carrasco.cruz@gmail.com
Cc: smatch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Documentation/smatch: fix typo in submitting-patches.md
Date: Mon,  1 Apr 2024 22:45:12 +0200
Message-Id: <20240401204512.538453-4-javier.carrasco.cruz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240401204512.538453-1-javier.carrasco.cruz@gmail.com>
References: <20240401204512.538453-1-javier.carrasco.cruz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a small typo in the smatch documentation about the patch submission
process.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/submitting-patches.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/submitting-patches.md b/Documentation/submitting-patches.md
index 5c4191bd..3f4c548f 100644
--- a/Documentation/submitting-patches.md
+++ b/Documentation/submitting-patches.md
@@ -20,7 +20,7 @@ Kernel submitting process.
    Notice that sparse uses the MIT License.

 4. Smatch is built on top of Sparse but it is licensed under the GPLv2+ the
-   git repostories are:
+   git repositories are:

 	https://github.com/error27/smatch
 	https://repo.or.cz/w/smatch.git
--
2.40.1



Return-Path: <linux-kernel+bounces-72941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAB185BAEB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51CAB283AB2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E1F67C51;
	Tue, 20 Feb 2024 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ulcMRjcU"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3636773B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429820; cv=none; b=bmeRG6Gffdegf4bVrcAzbdnR5mXIXTxdrNnPoNgikw94sGQdTIPszRnuS5p48jDWXa+RpgeGKxFSS3Rybupi+twQB9kmZiI0/Ug9j6ClFpRYX7/76lj3KbYHN329+8RkRqGWrO9Ek2GwMDzkaksvIPhDrMAfeiqiBqE5IvbC1qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429820; c=relaxed/simple;
	bh=cYDoCiKTRi+gPhjiLH2ZPtZdUHcsgOWojEx7bGvUiok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYarOOU778uH9rkqqw9lS9SscdWT92AV/iSx8b3AV5Dzh46DHtqxzfjVFNO08+x4bOKAN76RDtmFjOZunWv05VvyWgJ8anDGU77XyxNchZWtvpjo5/b75lBthz5w2RbsZ+3Igb98b+8qO5ym+3mBB6q8knICcRm32xwMWEIJX+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ulcMRjcU; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-564d332bd73so535209a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708429817; x=1709034617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NC5xe2uxCxCjh2/t9Ad3AWpCcmsygcw6ycwZ3qcHHbA=;
        b=ulcMRjcU61jrEuhPPhEdH5Y0kmkSXroKFHsYxtK4GgDJoEpgogWcItl7YpUPUYsfdf
         9nIaMzubXM3NQUXHtZ0q5X/RFbskJt/tBZEPhUpUFL8MxOS+1p4OWs8dVc1o3oDlpyRC
         IpoJalaQtFJVzr82MFKqnDL+JIlEKiECPn+RyFPKm816zQM/OpQbgKmlRDS/5hSViytN
         71ZztEqcYzE9ZQ4MTSQN/zMXu+3717qBigiFfn8nEzhr6lrptxbBZxaIqfoBQe/CT1c4
         IMWBZqHjoHL4e3v8bZxBRPCN1ELFKF6oR3r6Okp1BHnD7jNT7bxXaIo5tAH1ZBYC4jGb
         gF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708429817; x=1709034617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NC5xe2uxCxCjh2/t9Ad3AWpCcmsygcw6ycwZ3qcHHbA=;
        b=JmNiTTfOqYfDUIDWQN9pgoNE5o827tY+3l7zG6325XDTeX+QwprrQNsVm+dfTen/Zr
         5jmB2p9r7+Fn8BZxU/qdPDxFnbYCEGVUKT5P0BpVTErGKXToyZc2z6GJDtAsAh2Dl+AS
         wlG6ndGZOgkaqUzhGpj1Pq6f7jz2SMSQOHl34umVLOqE07JcIEzW/L5qsPpU2ou2j0On
         nH8n2kDUMygEO6F5hMqZ6NExm1s/hKUOPJFq4FbuyCCE45E6lAGxJ9Ocd787G4Y+ck9Y
         6KjJt1e9NDetL2PMTNDSbUzCDGVmck6aTXeNgHJwMBY8wMTx00JEtpYSW473KMyul6O8
         GDaA==
X-Forwarded-Encrypted: i=1; AJvYcCXg62TBBNi7zlfremoY+75YLHf1gOff8fbWuu7HrbgVDSRHHvyecprJXaktYsrpjyz+r2bvsmnYgyz8fgM3MoGm9R32/Ivy40JMzLET
X-Gm-Message-State: AOJu0YyD8gx/yxU9IcFEQlASPyOTKC1H1/cOZAh1PO9tgUC4LQt7NikQ
	d5xCrN4T1j8BxLxTneuP35G7nLvBCuaaHZkOwsJzqUDHxLHY4fxCSGZMCmD7sTw=
X-Google-Smtp-Source: AGHT+IHWonUk0gf2gS9NP3Mffmo3xRF5rOyDEcgBiEuKiQquO9Tz7OelEZHlUqVEo8Ytw6LZzC6lJA==
X-Received: by 2002:a05:6402:693:b0:564:56e0:5643 with SMTP id f19-20020a056402069300b0056456e05643mr3817369edy.27.1708429817344;
        Tue, 20 Feb 2024 03:50:17 -0800 (PST)
Received: from gpeter-l.lan (host-92-18-74-232.as13285.net. [92.18.74.232])
        by smtp.gmail.com with ESMTPSA id u16-20020aa7db90000000b005645c4af6c7sm2317832edt.13.2024.02.20.03.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 03:50:16 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
To: arnd@arndb.de,
	lee@kernel.org,
	thor.thayer@linux.intel.com
Cc: kernel-team@android.com,
	krzysztof.kozlowski@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	pankaj.dubey@samsung.com,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 1/3] mfd: syscon: call of_node_put() only when of_parse_phandle() takes a ref
Date: Tue, 20 Feb 2024 11:50:10 +0000
Message-ID: <20240220115012.471689-2-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240220115012.471689-1-peter.griffin@linaro.org>
References: <20240220115012.471689-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_parse_phandle() returns a device_node with refcount incremented, which
the callee needs to call of_node_put() on when done. We should only call
of_node_put() when the property argument is provided though as otherwise
nothing has taken a reference on the node.

Fixes: 45330bb43421 ("mfd: syscon: Allow property as NULL in syscon_regmap_lookup_by_phandle")
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/mfd/syscon.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index c9550368d9ea..7d0e91164cba 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -238,7 +238,9 @@ struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
 		return ERR_PTR(-ENODEV);
 
 	regmap = syscon_node_to_regmap(syscon_np);
-	of_node_put(syscon_np);
+
+	if (property)
+		of_node_put(syscon_np);
 
 	return regmap;
 }
-- 
2.44.0.rc0.258.g7320e95886-goog



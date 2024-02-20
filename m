Return-Path: <linux-kernel+bounces-72940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C2B85BAEA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E751C24938
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2790467A19;
	Tue, 20 Feb 2024 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F83UHyPF"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A734667A0F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429819; cv=none; b=hkDsDoYf7GALRJosBXTm9wU2qm6a20J5MeGdSfOOeiHaUj9wDn3KMmIFUhQp4VbKf7DkpI1kCXMI7KG2pJjaLkO3xgt34PL3R0Arz9L0GKCQocGQEwdXH1DNjZE2oYKxgj3DLW7TCnUAsjY6NCc/ECI4j+XtBD77n+pPX+R22YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429819; c=relaxed/simple;
	bh=ZPJxtFrZyxgBNUAQe6H2xk0BZZEMxsLG6V/Dz7Hto44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KejxxODlobE1Hf2HnuJ38TWHnj7pvh+XWb7AKplWhCTFYR30yFIdHGhu3jnaQjunTFiuaPnxD9ocpVgNxMnGVWIgrKJ9l3UDXIUU1mkc3w94r32hyNvVak0Fhr0rEsZPTnxJfqLxaSgnxudFM/9zGUCHGkJRJfM6XfIG9tHLxxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F83UHyPF; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so5576059a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708429816; x=1709034616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OyeFWWK1ZILZ0GtHtp44q7Pr25xJ4Cjvt/OcbzpZ34E=;
        b=F83UHyPFqARWoYpjDgp0g/cRegsLHC/qRtasLuMp/kUGevDhz1T4JQMSSrnyX+AcLx
         PIHbFhdbfvd5A/xoETyXqigRtjoojKzMQg75ZKdKBnc7aHzjDiNE2Pma/6z7pJ0ZRjZN
         Qmam9EmftkjShBqy+oBjueN3x7PITMOf8VXl2rUIqtRdzDR73WsUNDbbBI61bSW+Z/Zl
         3MyulL1wKRYW1c2cdLfkRJuEKBWI1X7tGTGLS9flJjQs3ccyFIf3TxKHp87bmHag82PH
         P++w8sQJCSrM2HWx/k1KWx57TjR7KJF8am8hgXNyLtcDt5S2ibJCQjXj2F6kfWJbVPtC
         1uxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708429816; x=1709034616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyeFWWK1ZILZ0GtHtp44q7Pr25xJ4Cjvt/OcbzpZ34E=;
        b=BWpMb1+IefKm2lQ2FbQD5tJJHmNIzm9ORzyGQ1XnYzHIGswmI4cmmn5IK+qTKzsJ1q
         Y2XiCKpHnq9BQJEkr63KZTXj2ockF5NXzkpXDlhbJETDc7TKpinUmZTvWJtBseFsxcU9
         FTiMNciVqDxRoKz0XuQHimZoD0/TEL4aYhGL5+/CXBtf8EnqGW3jyUhpppyJB4CSoUo+
         zQIAB49mWQm/wanpQlpgijqHlKL4V1OK9hRKXCI0vdkI4B0oS7tP3xGubokbeu0ftNEE
         1rxDNUwHul33e+iJ0Qax+3tJefW0bImDSXVI8hknsmlsY6UlRjFdt1dKU2Xu+JWCDaqn
         mUnA==
X-Forwarded-Encrypted: i=1; AJvYcCUPfEbj/ieT3i5W+yM/BHYyIgWE2c5XZAiX3VQFkqlFAst15Ksg/Oi5z2sGWqE2SS6T+25l6fbtINanA7eYuCbit1PHTVYpPhzQkrun
X-Gm-Message-State: AOJu0Yx0sVeomIeht6mdWBY8ttuJdkSWpJ4XS0sN9tSbG5P93bwVMVyp
	5aMX6BNnksXH211t9cyb2lK42GAXcffYj7ygqMXO12yZ2oaMg83aiduyuYs4MtM=
X-Google-Smtp-Source: AGHT+IFJuBgksK0SpNNFlKJElMFgznNpr8TFGp6t1MRsl30npmJWa1jCYy8HvulAuGdzwvE4tAbprg==
X-Received: by 2002:a05:6402:5162:b0:564:7921:37c7 with SMTP id d2-20020a056402516200b00564792137c7mr3904110ede.1.1708429815948;
        Tue, 20 Feb 2024 03:50:15 -0800 (PST)
Received: from gpeter-l.lan (host-92-18-74-232.as13285.net. [92.18.74.232])
        by smtp.gmail.com with ESMTPSA id u16-20020aa7db90000000b005645c4af6c7sm2317832edt.13.2024.02.20.03.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 03:50:15 -0800 (PST)
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
Subject: [PATCH 0/3] mfd syscon and altera-sysmgr cleanup
Date: Tue, 20 Feb 2024 11:50:09 +0000
Message-ID: <20240220115012.471689-1-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Whilst implementing a driver similar to altera-sysmgr for exynos
it was noticed during the review feedback that we should only call
of_node_put() if the property is provided otherwise nothing has
taken a reference on the node. Both syscon and altera-sysmgr also
have the same issue which this series fixes.

Another piece of review feedback was not to use extern keyword in
the header file, so I also cleaned that up whilst being here.

regards,

Peter.

Peter Griffin (3):
  mfd: syscon: call of_node_put() only when of_parse_phandle() takes a
    ref
  mfd: syscon: remove extern from function prototypes
  mfd: altera-sysmgr: call of_node_put() only when of_parse_phandle()
    takes a ref

 drivers/mfd/altera-sysmgr.c |  4 +++-
 drivers/mfd/syscon.c        |  4 +++-
 include/linux/mfd/syscon.h  | 25 +++++++++++--------------
 3 files changed, 17 insertions(+), 16 deletions(-)

-- 
2.44.0.rc0.258.g7320e95886-goog



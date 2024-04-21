Return-Path: <linux-kernel+bounces-152606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 420FE8AC11A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 21:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1ADA2813BF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 19:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C164317E;
	Sun, 21 Apr 2024 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gzEiVPLI"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8226F41C79
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713728706; cv=none; b=Xe7wudfSN4D2KUzUT+1wNvB2ZFoAup6lN8bXqUJwUI3JUAsHiwemoUi8d6GrLf46UPGmur6f60EDJqvdOwOfuUcqd9IdnfO5xNAv/7BwWlhjuyn0AYK1QMlTkCLHvWnoPFgU9VQwHRbNaLJJkeHjrIh193F5q98jGLM2GatNcnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713728706; c=relaxed/simple;
	bh=WhM1lt196ZuyzGyrMGeZpHCQgesVgWk0mZDx/ZyriD0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TECnAizob/8U+dghRT6SK8wgCtMoOjmc0Qr8OaUtTcxLCgSbIKuTlIayx72BrgLfM0p1fbBZqENgE1FUUxWQjfpJsCXJUGk42AbdW0vEp2HaqS8vN++m6lbANGmskzMILLyeNvao2eXdxB6kdRp+jwJfb0vGWsakRnsjYzQKQQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gzEiVPLI; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d9480d96bdso198201139f.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 12:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713728702; x=1714333502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hmwLPymoZsGTsCGnCkn4W1GBf4uY6ZtEmc4PE5gzS1Q=;
        b=gzEiVPLIsBDLfHdSUHw//wPEA9kECf6BZSY+FxRIAyTV0FRPY98uNdAbC/nAwVL3ZE
         hD6D3a2n7hBAOi2JlQSXKXNnyidBUSPhHbr9IoJr0Ojw8nZ2kZUWolnZ4lbyHrgJLO3R
         qHWCzTF4CyHDNBOEguLBlVAs8ljSS2OYlPkxV9/Le8Mw4nGq+4g8U+LcON+A3aK0x9xi
         O46Cl+Oj4J3Ym1to6MYJHTDOrq09kkE8wmCevjLp5Mc2nOQpQQwuB0s33jrsB5NztIDN
         7ogAM2vhLRGKXqM3kaVXbd3j0BwC8uvPO+E7GrIqgu7qfqngPM87FranjxHGp0nAGe2E
         pzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713728702; x=1714333502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmwLPymoZsGTsCGnCkn4W1GBf4uY6ZtEmc4PE5gzS1Q=;
        b=BCTt+XG+RnT5IQBCdY9XDMUW+nVuS56BPth22PEM42mJl4p+Gh4NPKRW4lUVKh/8h8
         qWMVV6GTkP9MxfNp8YIzR3AFuv0FSVoCJfZYejQvlOaVasNHHatsJAeWZbe+XXmXhPpp
         FAT88aJsimw0xboQqIJ/3hptt7nAj7/2osb3BYo8XPGjlYTKnjlt57A/ZY1qzf4YEeiv
         vg62ucduSiJ/BYltzudP0kvqG+7UXN4becek/ZvQuaUMeTfSd6GjY1B1aE9p8vj8Fay/
         VlfhEpSYbRKpzJPE11rQded72u+9rb9Cpk2mPnqtS1G3uQIz89vMAjzNV1e3seSu4Rsv
         rnQA==
X-Forwarded-Encrypted: i=1; AJvYcCX4KBDHs64P0/xK6zlKz6lqIPqbeHCt8nMsLQtpqVMzIiwjTmG58AQu/yxSgU8yXgxrN87F6h8QSGwq1PyUhEX5/2lz66Ft96sESgqa
X-Gm-Message-State: AOJu0Yw0rOyS2ba8OAzvj86fNpka6wQf2M5vu1XajjFbeSdbMr1mfAt0
	Em+xs5/NXWVDMIJPCTV4ZB3f8Kq8tUQL2DyyhdxRn9Li1GDi2QcJCXo5+RSmuwk=
X-Google-Smtp-Source: AGHT+IF7DiPJL/yIlJYiXPfNcpL2tc/oHWI9TirxRMVUc+S1ri40BymfZ1eUghsMJ8O7i3dM46HxhQ==
X-Received: by 2002:a05:6e02:1a65:b0:36a:1104:2d6e with SMTP id w5-20020a056e021a6500b0036a11042d6emr10507360ilv.1.1713728702576;
        Sun, 21 Apr 2024 12:45:02 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id t11-20020a92dc0b000000b0036c1134a492sm35926iln.51.2024.04.21.12.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 12:45:01 -0700 (PDT)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: akpm@linux-foundation.org,
	andersson@kernel.org,
	cdleonard@gmail.com,
	elder@kernel.org,
	geliang@kernel.org,
	heiko@sntech.de,
	matt@ranostay.sg,
	matttbe@kernel.org,
	mka@chromium.org,
	o.rempel@pengutronix.de,
	quic_avuyyuru@quicinc.com,
	quic_bjorande@quicinc.com,
	quic_cpratapa@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mailmap: add entries for Alex Elder
Date: Sun, 21 Apr 2024 14:44:58 -0500
Message-Id: <20240421194458.2205779-1-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define my kernel.org address to be the canonical one, and add mailmap
entries for the various addresses (including typos) that have been
used over the years.

Signed-off-by: Alex Elder <elder@linaro.org>
---
v2: Deleted two unnecessary lines, after prompting by Bjorn.
    Also copied those suggested by get_maintainer.pl.

 .mailmap | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/.mailmap b/.mailmap
index 8284692f96107..f932ce611898e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -38,6 +38,16 @@ Alexei Starovoitov <ast@kernel.org> <alexei.starovoitov@gmail.com>
 Alexei Starovoitov <ast@kernel.org> <ast@fb.com>
 Alexei Starovoitov <ast@kernel.org> <ast@plumgrid.com>
 Alexey Makhalov <alexey.amakhalov@broadcom.com> <amakhalov@vmware.com>
+Alex Elder <elder@kernel.org>
+Alex Elder <elder@kernel.org> <aelder@sgi.com>
+Alex Elder <elder@kernel.org> <alex.elder@linaro.org>
+Alex Elder <elder@kernel.org> <alex.elder@linary.org>
+Alex Elder <elder@kernel.org> <elder@dreamhost.com>
+Alex Elder <elder@kernel.org> <elder@dreawmhost.com>
+Alex Elder <elder@kernel.org> <elder@ieee.org>
+Alex Elder <elder@kernel.org> <elder@inktank.com>
+Alex Elder <elder@kernel.org> <elder@linaro.org>
+Alex Elder <elder@kernel.org> <elder@newdream.net>
 Alex Hung <alexhung@gmail.com> <alex.hung@canonical.com>
 Alex Shi <alexs@kernel.org> <alex.shi@intel.com>
 Alex Shi <alexs@kernel.org> <alex.shi@linaro.org>
-- 
2.40.1



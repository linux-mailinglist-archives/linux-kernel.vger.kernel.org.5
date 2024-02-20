Return-Path: <linux-kernel+bounces-72942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FD985BAED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BE02B23738
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F3167C77;
	Tue, 20 Feb 2024 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y51Zl8h2"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF9367A1B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429822; cv=none; b=ia44C+zrx1eQNNMriuiv25LSwcIM79+rPDoPxFzMp4NVhXPpqXcLzV96sRzb1A2fhlCR1FEZtctRS3tOvZR96zOVtPFuR0fNPbPBjhdiB0uffH7bLuhg3eno7+GMHHb/iRJSqGQ7gANUmVPhqzPjST9c9H8+aaAv/Gh/se1EVmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429822; c=relaxed/simple;
	bh=0IfLHgBVTD7LiVd984EuRr7LjiiQeTvGFFpyHCXVJ0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=meZakw8J9Go5nBc4v18uBeb8C8LPBeQQezhwK8iOxM5Lxm5JJBZI/YRHpThizlhPSp/y0JvmTrZTMFNn/HWR2B/HJJ80Bd0LGXbtsQD+OyeF7zWSHI9zw9ZHnC2MQKDf+7RHK6+legV1bIpMQjOz5poUKt2fVX7kPdSEKAzglWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y51Zl8h2; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-564a05ab3efso2262001a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708429819; x=1709034619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIz2a8ZPV5qqMCqIcgKN9srCLfbQdXRH6UOg+1LhDuc=;
        b=Y51Zl8h290zAoc+AJKCum6zgmMT46ecvYz27Xo2O8wFkPZiKsdGIe9ZPxtCqpxgZc1
         tep0JRoQm2xPzymcEQrKGR+fJAjrAj/g+5ketj1deNRa01XbA1GDM1aQZLwTtjKke6kM
         ldXl2Dl8wYtq8VdmmmCpnl9csHBPS7INc5BrxvXWCt1aQP/20uWZqz3Lcx9B/gffPe0b
         BgIlDYBM6sRvhS1RamaerLyFlSsJvI39IsRiIpv6qe5iyt6hz933HfRce0kHO/7UOquI
         NX9vGX6Dxv77scJw3JHvIj97f0hv5epqxK8if8JtO2TZC4UZRKphLEVJPoXm5PPQ71pT
         UNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708429819; x=1709034619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIz2a8ZPV5qqMCqIcgKN9srCLfbQdXRH6UOg+1LhDuc=;
        b=ohma4jmFFCwPbGpNZ1Pq/cbO8qdTRhVU4y6r/XMlR07x3LD9v9qMnIi4XjN7ywHyLj
         N7Zsa5+QD8PY57V2lnqOGVh3Wp2TjuAwN7lhJeJAeyFaado51/P4fKhGKAHQl+CRx+og
         3ayr7cbxt+HNVAlZYm3RBwL+11CYQlSmNWi31GVAPbNI1nRQA6oxh6QCryNgJHhZ4tdP
         ZOGQUjyftgRscW5+s5jlErF/a1EK89sWOAmAZRWCVsK1Yj0VXxauuNA0XOzP9FgPinDz
         KjQFWIHv3Rhl1+c8VeGtuzzlsZT0J04wuAwcSSsiwIBUveFekVKunAuiiErOtSuGB5ap
         0K5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVuwREri1k0LeDMdOJ8m8Ga0yEfaIqntiPpMqSsFpWLYI7ttD8gOAx7IUelrJgs7nU7IiocsMFHPPFDsamfh93DrhWydMx0aST5wby
X-Gm-Message-State: AOJu0YwlD/jCxMB1ne5Xfv5iWdYItgaTW+OAeH+/+x24V+NlV3B6YHr3
	eYL0S9j/JDirkcBXgmEsuyx/uscHHlc43cTcXEbSo3zZaT6aa8s7iMD6cTwN6PQ=
X-Google-Smtp-Source: AGHT+IHW4GEpTJv1ZnaGPtiU1q+9ICdDV892ZtDa1+jkryGHrkMoTGFQm/ZjleeVFtcfumHH9c72YQ==
X-Received: by 2002:aa7:d4d9:0:b0:564:4f6f:a7ff with SMTP id t25-20020aa7d4d9000000b005644f6fa7ffmr4449767edr.20.1708429818757;
        Tue, 20 Feb 2024 03:50:18 -0800 (PST)
Received: from gpeter-l.lan (host-92-18-74-232.as13285.net. [92.18.74.232])
        by smtp.gmail.com with ESMTPSA id u16-20020aa7db90000000b005645c4af6c7sm2317832edt.13.2024.02.20.03.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 03:50:17 -0800 (PST)
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
Subject: [PATCH 2/3] mfd: syscon: remove extern from function prototypes
Date: Tue, 20 Feb 2024 11:50:11 +0000
Message-ID: <20240220115012.471689-3-peter.griffin@linaro.org>
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

The kernel coding style does not require 'extern' in function prototypes
in .h files, so remove them as they are not needed.

To avoid checkpatch warnings such as
CHECK: Lines should not end with a '('
+struct regmap *syscon_regmap_lookup_by_phandle(

The indentation is also updated. No functional changes in this patch.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 include/linux/mfd/syscon.h | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
index fecc2fa2a364..c315903f6dab 100644
--- a/include/linux/mfd/syscon.h
+++ b/include/linux/mfd/syscon.h
@@ -17,20 +17,17 @@
 struct device_node;
 
 #ifdef CONFIG_MFD_SYSCON
-extern struct regmap *device_node_to_regmap(struct device_node *np);
-extern struct regmap *syscon_node_to_regmap(struct device_node *np);
-extern struct regmap *syscon_regmap_lookup_by_compatible(const char *s);
-extern struct regmap *syscon_regmap_lookup_by_phandle(
-					struct device_node *np,
-					const char *property);
-extern struct regmap *syscon_regmap_lookup_by_phandle_args(
-					struct device_node *np,
-					const char *property,
-					int arg_count,
-					unsigned int *out_args);
-extern struct regmap *syscon_regmap_lookup_by_phandle_optional(
-					struct device_node *np,
-					const char *property);
+struct regmap *device_node_to_regmap(struct device_node *np);
+struct regmap *syscon_node_to_regmap(struct device_node *np);
+struct regmap *syscon_regmap_lookup_by_compatible(const char *s);
+struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
+					       const char *property);
+struct regmap *syscon_regmap_lookup_by_phandle_args(struct device_node *np,
+						    const char *property,
+						    int arg_count,
+						    unsigned int *out_args);
+struct regmap *syscon_regmap_lookup_by_phandle_optional(struct device_node *np,
+							const char *property);
 #else
 static inline struct regmap *device_node_to_regmap(struct device_node *np)
 {
-- 
2.44.0.rc0.258.g7320e95886-goog



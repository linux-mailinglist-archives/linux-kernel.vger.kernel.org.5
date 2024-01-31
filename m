Return-Path: <linux-kernel+bounces-45799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5719843657
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BA8E1F280E5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A062E3E46B;
	Wed, 31 Jan 2024 05:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ewh1VKAJ"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1653DB97;
	Wed, 31 Jan 2024 05:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706680730; cv=none; b=asc3FJ5H+wlUofieqTegQ3nHUYAVhZ+jpOJ6FDUeutwJ3bwunZSs+kKZ38FxnYctb7HMYCX9ukQEmvCAr5yiTxbqrHz4UVB6akBP6cShpdmh7howDBH43o5wS/5z9WO9AHCsbJjAZimnLzFxXB7QKAGsgP7hqAxRS5EHpkmBC/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706680730; c=relaxed/simple;
	bh=0tOTsazWTcs9QYzc3VNchWmVv4Rg9HgIxUYj/cpbTtY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iO2rJUAlR/rTmzAyjRkb3RKh0/qMKFvQV+8YfkU/i1tLWdgnr08gUmh4g9iCqt+TlKP0bN7zlJbF+YwI4U4+VTeATi90OMH/bZDt5SQlod+uXjb82mT5lUo63Be/1Agv8/Olabse4wy0pJ2XRPbW1HcO56fRd6CzwliJgQJM2Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ewh1VKAJ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ddfb0dac4dso3414182b3a.1;
        Tue, 30 Jan 2024 21:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706680728; x=1707285528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dHEweAsyBseNZ/atWmXcoaWQ2MjiSsil4Mz+T/iMO0=;
        b=Ewh1VKAJS2lNUkD5rXKZlDBoflb0g8XxswMjDDltlAXIXklz1wtpJAr1d+luUUIncK
         K3ryJY1XT9CMC4X90PphvEosYfvqlXS5gbwy2RKkcfqh+n+VQa3LqtD4kGjJ9xtTVgfb
         1/qMmVRUlgYiAz8QA1ycTjm2up4G0ThMlu4KR70F9zX8xSrhSkf/rXgdwBkgAidhfyC6
         YF20jHdjLS4xqldfDTl5vCqLgq1k1PJsbRjfpytseemU/pTD9pXIiHcZHXRkL91jxWPt
         JaYzK35Y49fs8uxpo2+vRwjrcdcBMy2dIHk64VDu8XQxvvT9J3UyyYTOf8wav+kCI4ul
         sWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706680728; x=1707285528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dHEweAsyBseNZ/atWmXcoaWQ2MjiSsil4Mz+T/iMO0=;
        b=aE2pQabwS2cP7aDcg+9VlSdHrilGC4SvyMBMvUjO3tTp8SHaoVZU2ZmxmByKHXZ3Ur
         b7+bLxC+PlFtxaMYWtxqhKL0brc2fvuUe4izOpVRyDZ6dhF7cziryxzt+ocWLCFYWhsc
         BWgMd/mjCg9nB3DxHzGJA+6isHRr2uUEqpW5bUo9jZz/xoaPs5+bZVBUK3Selqa+45sE
         Yisvr/G7w98JbFmmi/JCYiHKv4mWw1RkfXohCyxoHsEGGB9CWcJMwFRViydcm8gNiRs7
         giN3+Xg/whVScbHT4lAlX4U6XMzC0QIcTbNkRbyqgcflEKrYfwBM/E3sp5KbszbErdaE
         EAJw==
X-Gm-Message-State: AOJu0YxcUMlAA9YpRx4DYCkXCqZlDWt/A39Tb1WsU61yFtUIv9sRRlZa
	WYoBfTS2yaVI8f8S5vZsQI4sSiifnXR2lDSRnpl6xM29xG/57zh8
X-Google-Smtp-Source: AGHT+IGLy3CTr6dtmBN0i4y86QW6ckGmvweQVBKl1e4gw9U3t2G3fLuXuIAGKGZoZWESux3lwXbCwQ==
X-Received: by 2002:aa7:87c3:0:b0:6de:2f30:9aa4 with SMTP id i3-20020aa787c3000000b006de2f309aa4mr778100pfo.33.1706680727878;
        Tue, 30 Jan 2024 21:58:47 -0800 (PST)
Received: from charles-System-Product-Name.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id r20-20020aa78b94000000b006ddddc7701fsm8904385pfd.4.2024.01.30.21.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 21:58:47 -0800 (PST)
From: Charles Hsu <ythsu0511@gmail.com>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	corbet@lwn.net,
	Delphine_CC_Chiu@Wiwynn.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Charles Hsu <ythsu0511@gmail.com>
Subject: [PATCH v3 2/2] dt-bindings: Add MPQ8785 voltage regulator device
Date: Wed, 31 Jan 2024 13:55:26 +0800
Message-Id: <20240131055526.2700452-2-ythsu0511@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131055526.2700452-1-ythsu0511@gmail.com>
References: <20240131055526.2700452-1-ythsu0511@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Monolithic Power Systems, Inc. (MPS) synchronous step-down converter.

Signed-off-by: Charles Hsu <ythsu0511@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 79dcd92c4a43..088b23ed2ae6 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -129,6 +129,8 @@ properties:
           - mps,mp2975
             # Monolithic Power Systems Inc. multi-phase hot-swap controller mp5990
           - mps,mp5990
+            # Monolithic Power Systems Inc. synchronous step-down converter mpq8785
+          - mps,mpq8785
             # Honeywell Humidicon HIH-6130 humidity/temperature sensor
           - honeywell,hi6130
             # IBM Common Form Factor Power Supply Versions (all versions)
-- 
2.34.1



Return-Path: <linux-kernel+bounces-79513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0683862378
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 09:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D051C21C3F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 08:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8F917731;
	Sat, 24 Feb 2024 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TOODgUTa"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F5C10971
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708764259; cv=none; b=HKKAuEkZMSieEC7sFWhOQqUkDE9hwHcTnmRiV81FbG5KL2eq1H3aSSDUkRlzg18eSsPxLQv/bJhEqAdHd5jBo45hEjkGNngs0CpoEM98v8CHXXMVOHmup64ycl5hLn/ZeCE8WFYgeKaXjQQlxSYV61tCmpPRTRZg9epY9Pvwa9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708764259; c=relaxed/simple;
	bh=FIpyBXgJjvANVtOR/x6yvGkcACpAI5HneHy/vhLWMJo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lF+hUBTgYR9duCodYXYhauWRzEjmbW06yJPm7LjvWhMyiRyh2V3i5ja/ObrWV/KtsyZfW8BwSW4YrZt4pE+Own8PMcFVH0RBpnkcQf7uzecmFV1EyYHqF1j7Rn7vYHtZ2MbEISbX0wwEUSy+PhqNMU0/eT/4BK+C4bzwCHEXGg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TOODgUTa; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso1812770a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 00:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708764257; x=1709369057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5LGO6mbGw66Vq7mqhjwVfT/QzpHFqhbr0XALIz5zVo=;
        b=TOODgUTanBQ+QiuXCqdUhxjfybrUALgfZk7+mMmls5Z7f4DitAqh5+1vVnKf5i+8fs
         7AsJ5neWkqSqIjjlA2JoWUkoyh17ROdEkJRVR0ZCZHhzabXVL1lGKWxDY0zrcfDaMLVT
         QZ+/E3lSBMs4I3AHJjZIwpN3yGYoxib8XrVGRYTIHaj7WPT95xNGJ9L2ZtiNw77xeCtX
         SEMfZg2Z5xtPgzfxaJtOrUylunY+dqJun8YoV/a61iVnw3+BKUo3d8wm3qfbewCdnDX4
         UTqWH8pJaKNQz2ROzBGmQ1+3vvhEdUh3hc43aa62RhoT99QyouD9yut9kqBI4lMcuv1z
         QJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708764257; x=1709369057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5LGO6mbGw66Vq7mqhjwVfT/QzpHFqhbr0XALIz5zVo=;
        b=kYHOHaE7SEB09ozCb9PN1lpS1GbhwprJnHgtD6VNl2hqkoMVIlK2CjPvoPkC6aboKh
         EiUXVHbx0CjrMOiwoyPQFDfgfxBzQEIBSZMidBMA1AEaLlKN4OJ4r/td2SIzrNLd/Vuy
         xKMczojx/o+Em+3jJMXSWzoVMzK6e+Xv5tQj75XDWdxkYAN8XBthsRNfnIEwCHr6AMqd
         OoB/lu7Aaq617IK1tbAYaUe0H4cX4unhgOnchgcHSpix/mGF8F8aJMpXzz2Fc6P1pGj/
         EYk280dPUhFgXqajW5i5bU+DQfh2BOQMd8QOMT85et0OdCbBf9r977s6HRk6Bcp3nR3U
         v5/g==
X-Forwarded-Encrypted: i=1; AJvYcCUNf5uT7420H32kjvQ/HUhK1c2FAyPIJ5O48Em2OQHkBvku4fqDstCzlW08Kiu0YLRzoIlnhWtqXzoQrJnfFSi69eeL7Y4IuCZYEkpw
X-Gm-Message-State: AOJu0YwieJIglyLlgzgnO6H3VHDlApzO9cySRebVm+G/rMBZDSf0x6cp
	SXBEoQfg7RDJG6uicD5qXCkhmSgPdVShK/46pOkO9uLMLlsWU4prl7IPbuyIDKU=
X-Google-Smtp-Source: AGHT+IGy1s0ucjpyByrSHOHHyA1pEzL10c6+gVegGr5T3PUO2UsBwI+uY3a3LLOsvUPqIQlmjy9ePA==
X-Received: by 2002:a05:6402:363:b0:565:a54e:6c8f with SMTP id s3-20020a056402036300b00565a54e6c8fmr646776edw.38.1708764256774;
        Sat, 24 Feb 2024 00:44:16 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id ij13-20020a056402158d00b005617a858f21sm335906edb.93.2024.02.24.00.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 00:44:16 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: arm: syna: remove unstable remark
Date: Sat, 24 Feb 2024 09:44:14 +0100
Message-Id: <20240224084414.6264-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Marvell Berlin SoCs (later Syna) bindings were marked as
work-in-progress / unstable in 2015 in commit f07b4e49d27e ("Documentation:
bindings: berlin: consider our dt bindings as unstable").  Almost nine
years is enough, so drop the "unstable" remark and expect usual ABI
rules.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/syna.txt | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/syna.txt b/Documentation/devicetree/bindings/arm/syna.txt
index 851f48ead927..f53c430f648c 100644
--- a/Documentation/devicetree/bindings/arm/syna.txt
+++ b/Documentation/devicetree/bindings/arm/syna.txt
@@ -6,18 +6,6 @@ berlin SoCs are now Synaptics' SoCs now.
 
 ---------------------------------------------------------------
 
-Work in progress statement:
-
-Device tree files and bindings applying to Marvell Berlin SoCs and boards are
-considered "unstable". Any Marvell Berlin device tree binding may change at any
-time. Be sure to use a device tree binary and a kernel image generated from the
-same source tree.
-
-Please refer to Documentation/devicetree/bindings/ABI.rst for a definition of a
-stable binding/ABI.
-
----------------------------------------------------------------
-
 Boards with a SoC of the Marvell Berlin family, e.g. Armada 1500
 shall have the following properties:
 
-- 
2.34.1



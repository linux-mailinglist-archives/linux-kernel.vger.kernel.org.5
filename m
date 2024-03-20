Return-Path: <linux-kernel+bounces-109200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AF0881610
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF302845B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91BE69E0D;
	Wed, 20 Mar 2024 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVTRH6Rs"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B494320B;
	Wed, 20 Mar 2024 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954314; cv=none; b=Ofs6dwaCJir8pF05QJhSK4++OimFYvHldXKH1wE9WcnlCfhig1kHFOBT74JhMFZi44fG5Lma8wV8jsR9sux0Dc8iUOGoEn4RdLZrJR7JAnfj3u2mNs8mxmiVy5btNN0ViCITSjC06ft0rTvB6TOwUb+z3lL6oAfJ8mL91tfMJ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954314; c=relaxed/simple;
	bh=9eZvN2bEItXZ+IJpwOHBroGfTy95G+7wvzY/WOa+0g4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M/OvjaGlN/ZueCbgx8bTNT6OMDmI+eM79UPCGaQWghvd8RqgZw91PQ8bl/IXd240gP9bbSwne0F9vSFe2e03/mRudDsc9cNK9UI5/tLEcl1lWbGhp7orlongZf5StCygCn/R8YkWyAXgGLbDmChBrW93a+PJ9uJAJ+x+DjawnJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVTRH6Rs; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a46cc947929so7661366b.1;
        Wed, 20 Mar 2024 10:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710954310; x=1711559110; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dOwSR7c0Xavoru+NZvRNaLt8TtjaIKHdclHH3nj/aro=;
        b=EVTRH6RsE+DpKxLv+K5MmdmxW5r2/wzs8I0sUn+su0072xXFpQ+aCxMTN90JLv5qpK
         POk7qlxvM1rA168zrExsndQSiEuyL+cchQiKVG56JvJVoBdycMEAGID3DgKTj+ztKnRR
         3dOsIBdj+kIDlw1fIyz6Bg0+rB0WLKShydfYMnnsC1kJxiDAjcKXpFN4b7LRfWwoiqwb
         bFlPbMRshnPaO+Gd04T7DcIablstqqotkkUOEa7bqJyJt30t68ZOXlgDjvNL8P90qofx
         2PHHqV41Oh1v1IgqoETJUnBMQ/xEXGSmrqk4cOOEAIbFTatKvcTAEIbfSQSksiyZrVUa
         YJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710954310; x=1711559110;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOwSR7c0Xavoru+NZvRNaLt8TtjaIKHdclHH3nj/aro=;
        b=dZFQtmt1zfURfW5y4/SGlY5nM0kq/smNDR9eCQUQUk7DbfyqOlPqgHgrxG1lBZLHJM
         RQH+/LaNcm+HOnaD+EuW90o1gAO7gdbk4B8vjjIyxw9265jQ8M9HZHnXCrZpvnWgq9mu
         7f4Uhpe0T5SawlBgPxxbsdq1kG8L9aYMQ6yN/Hbg5orygrCCKBiUkZlPqf2Va5cTte+h
         wA0pZNLIkpaPaoQItwFsFQW0jk866fwK+q85ia3G7purfXVGXFsfUeYHx7twPRuvsQdK
         hXSAX5Zdh1dJMlihAcueyaCTt87bpZ5LceHZS3IAD9sbpFHKBBkHuL/IEoSQyDXVSGn9
         MTBw==
X-Forwarded-Encrypted: i=1; AJvYcCVwlpMybwPJycSfVMsSpsp/CnMqHC6DCI3cZbFYDFLOqQ6yqEUGnq6uH7gCwQ2hXV0udW1+bfVdPUtXqIOoeiLUPZW46phOMQlO3jnTa9bB+LcU5oCKTOqjbeK8z2UIXtRigI8s2K2PMw==
X-Gm-Message-State: AOJu0YxnZHc7BmvCaGBhVhbP2C0Dz8doeZ4MZG2UKnhBzDcGr/TsyHYw
	fbT/LBl3d2m5cr5rOYuShvJTAMgtTqG+arZ1gcnCpQnvs4Gf0l8sU/86CeMccvrRRA==
X-Google-Smtp-Source: AGHT+IGf3NABJBrUVvzeAzB9c4NtrSjX55A8NhYVZ1lkutEyid6v1JIrt6QbD2Sjc0Q/1Jy9wKCG3w==
X-Received: by 2002:a17:906:6d2:b0:a46:ee3c:3574 with SMTP id v18-20020a17090606d200b00a46ee3c3574mr1656724ejb.47.1710954309924;
        Wed, 20 Mar 2024 10:05:09 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3c5a-7cb4-e12c-8223.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3c5a:7cb4:e12c:8223])
        by smtp.gmail.com with ESMTPSA id af3-20020a170906998300b00a469604c464sm5999019ejc.160.2024.03.20.10.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 10:05:09 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/2] dt-bindings: hwmon: convert lm87 and max6650 to
 dtschema
Date: Wed, 20 Mar 2024 18:04:56 +0100
Message-Id: <20240320-hwmon_yaml-v1-0-a349ca21ccab@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADgX+2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyMD3Yzy3Py8+MrE3BxdkxRzY4tU4ySjZAsjJaCGgqLUtMwKsGHRsbW
 1ABdmdJRcAAAA
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, peiyu li <579lpy@gmail.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710954308; l=1173;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=9eZvN2bEItXZ+IJpwOHBroGfTy95G+7wvzY/WOa+0g4=;
 b=4edR6meyZYOANket+M/7sy7MJtAwMPv+F5wKo6KV3O+OawPpQE11KEMBCGgjJCEVUoOFLzLjz
 h+ZnswLBqBMC2C8tB009cWQT0GKOBaNQRtpkVd99UPwIToOqEeBccQs
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series converts the existing lm87.txt and max6650.txt bindings to
dtschema. Both are direct conversions with no additional properties.

There has been an attempt to convert the bindings of the lm87 before
[1], but the author (added to recipients) has confirmed that no further
versions will be submitted, and no acknowledgment is desired.

Link: https://lore.kernel.org/linux-hwmon/20231030125221.12974-1-579lpy@gmail.com [1]

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (2):
      dt-bindings: hwmon: lm87: convert to dtschema
      dt-bindings: hwmon: max6650: convert to dtschema

 Documentation/devicetree/bindings/hwmon/lm87.txt   | 30 ----------
 .../devicetree/bindings/hwmon/max6650.txt          | 28 ---------
 .../devicetree/bindings/hwmon/maxim,max6650.yaml   | 68 +++++++++++++++++++++
 .../devicetree/bindings/hwmon/ti,lm87.yaml         | 69 ++++++++++++++++++++++
 4 files changed, 137 insertions(+), 58 deletions(-)
---
base-commit: a4145ce1e7bc247fd6f2846e8699473448717b37
change-id: 20240320-hwmon_yaml-4d738e3b2c82

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>



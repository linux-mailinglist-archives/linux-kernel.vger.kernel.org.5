Return-Path: <linux-kernel+bounces-78342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB1E86122B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969901C22C95
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9E57E777;
	Fri, 23 Feb 2024 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIZGbKX6"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C641097D;
	Fri, 23 Feb 2024 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693306; cv=none; b=igYiSHV4vTgonX8F4Hm8OHNqGl8nkPMfOaWMQzEuOJ7jnHuyjianN+dPIu0exiV5q7hR4yCF58xCTXVjyu9mHtjBawxV0DZKjfmBMAWVJ+cyVuhL35Se4apKA3ueAZXCpSvyJJhE2BJ441m9FZJPCe3cnZoDHrebMSKIi6evkPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693306; c=relaxed/simple;
	bh=KQF9YPtUSkRZ+JpmVKYQ9PTQCWFyX1w6lHWuY9DzDgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=k+kjKn5pQR5aBWDatbC1v4UuZkyf4PvYjtb3jS8gru+EYXmj1p0OjWtOOpE2Eb8PJsrIw8SASq+F+6iXrAo32uhw7U9KuaeZ1JAEFZHZlMxr54A/Z5lzWBg1L8D4LxVO9lwi2qAeN6kTWNotq9GhixFpYXvSrA+VAhDbdTkKSnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIZGbKX6; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so1232689a12.2;
        Fri, 23 Feb 2024 05:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708693303; x=1709298103; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xwVLrP5e0GKj/Gr/YOGNMocGh8+7OdL1LctFVaC5kRE=;
        b=XIZGbKX6V6uEg5Y+Lbbk7BBTes+VSiBo1ZgMcXfC2kjArSB/VYl3qJ98dvmQKgnjws
         DHFRNvl5r8sYKak4F2M5/akcsDWxqeKqBcHAIqGDrMuyk7KUR5NSNjzZcIYcs4nJOarp
         ZDV/qPr8Z3t7vJbc1YTziCSRSxy4BMRqOIbUOXkGeqE0L0QJQqyqi/csxTGTDDmfPkl8
         QLibFPOMbxxNVq/3QJDPxF7xMKe3VeIMlCI9Nl33C+ZdB4w/7gy/5a2YPDJiDK9e3pbi
         KlUSEOnhD5HSJkvq2GePaXRWKFAyHtLd0ZyMKdrTATTdo0iODd2M2NitzlRq3dABG9QJ
         QAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708693303; x=1709298103;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwVLrP5e0GKj/Gr/YOGNMocGh8+7OdL1LctFVaC5kRE=;
        b=QYoDu2JUg7a5YWCd0aisITqSTvHbOEofPbUtTMSH0AXfnGjrNKm9G+z89lgU7ZvtE1
         eIlcZatNzeYDniKOXDFn5crEU/EHP/rK5F6E6uUBuuJqEH/hiKPfpbhO+5sMF42ZKEl1
         XoJ70LCo8CKPS1CGLF1Z3jBifqs+6Pr12GE1SABrIEgKPB40XqAOF0m5XEjr77OrNuKu
         uhslgHHQb+jLgido+DWr1IUxQM4HlAnjMBBK1eZ9mx7penzUivixq805WlwjQpIWGiQp
         wOHTi+Mu74WHC/u+W/CaJRbgSLvYjMGyD+AZYaVGIqZFrZP112rJC2xxw/rCv8QlU+R6
         3WOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZemhcId/265iVuvv/fl2c5q8T9VEEes3yQMdSI2adQ97NBgnCz3jLW628erjEt9t753b02QzFjn7cTPBdnBwpDPfrcNj9+EBj4GqiVsQPOhgHBIVEgp00yOWhrlHCoAKLK7DSZrTcEg==
X-Gm-Message-State: AOJu0YyaYruESvEjUIPpugE71H6v351eJo6F+jTXnNM5q6RHVGDaS/pz
	V89JciQx3xXfinEgO8IOWv7oyT2y8JZCYweq3eJxGGNf+ne7R+Kn
X-Google-Smtp-Source: AGHT+IFCQ/Ih92c2I54+6GuGrhk/vwz0fRL3tiy0H59PHeDEy+El5xAW3oSpdtZT10Gsmpk6GvNc6w==
X-Received: by 2002:aa7:d69a:0:b0:564:26d9:b4ac with SMTP id d26-20020aa7d69a000000b0056426d9b4acmr910512edr.41.1708693302729;
        Fri, 23 Feb 2024 05:01:42 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-a1fd-07e8-2475-107f.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:a1fd:7e8:2475:107f])
        by smtp.gmail.com with ESMTPSA id g14-20020a056402428e00b005642bcfed99sm5954561edc.23.2024.02.23.05.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 05:01:42 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 23 Feb 2024 14:01:33 +0100
Subject: [PATCH] dt-bindings: iio: light: vishay,veml6075: make vdd-supply
 required
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-veml6075_vdd-v1-1-ac76509b1998@gmail.com>
X-B4-Tracking: v=1; b=H4sIACyX2GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIyNj3bLU3BwzA3PT+LKUFN1UIyMjA0NTi7S0lEQloJaCotS0zAqwcdG
 xtbUABUzEbV4AAAA=
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708693301; l=1623;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=KQF9YPtUSkRZ+JpmVKYQ9PTQCWFyX1w6lHWuY9DzDgA=;
 b=15qwh5h1OZ9vnbKVGCStogGtXAfMFwg53a3w02a65gKd0dwPQP8NwAgtuX2ljrmHo8HEuOXig
 4Y/l9iXdGC4Cxb0a6oywIw6RWlZmhafKlKHZxS6at+esk8Mj9c/poZE
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The VEML6075 requires a single supply to operate. The property already
exists in the bindings and it is used in the example, but it is still
not on the list of required properties.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
The driver and bindings for the VEML6075 UV sensor were merged in the
merge window for v6.8 i.e. they have not been released yet beyond rc.

Applying this patch as a fix now would avoid an ABI break like the
recently discussed here:

https://lore.kernel.org/linux-iio/8409a5bc71b995e3b738b817a074cfb131c3b2b5.camel@gmail.com/

On the other hand, from the same discussion it can be concluded that the
major risk would be a potential warning with dtbs_check, in case this
patch is applied during the next merge window.

The VEML6075 driver already handles the power supply with
devm_regulator_get_enable().
---
 Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
index abee04cd126e..91c318746bf3 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
@@ -21,6 +21,7 @@ properties:
 required:
   - compatible
   - reg
+  - vdd-supply
 
 additionalProperties: false
 

---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240223-veml6075_vdd-e2220158ffda

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>



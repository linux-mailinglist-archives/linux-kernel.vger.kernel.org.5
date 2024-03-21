Return-Path: <linux-kernel+bounces-110558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE82E886093
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 461CCB21AB3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F2D13340E;
	Thu, 21 Mar 2024 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjHi87A9"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A162A8BE7;
	Thu, 21 Mar 2024 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711046040; cv=none; b=cFdg2722nswRbZ/K5PXQjc4t1DDGnJpyMO0WwUsglbWvQH8lSAVWvjqmnHUc8d/I8fkzUfmHE0N8UKqz5UCA2rmSBBL3XbNkoZxMyXibA4oU93rangZJivc2hAwyTsIG4JpmOJiGARsuL3uF/EWDmBWoCx2Q2YTSBdeXA5he6Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711046040; c=relaxed/simple;
	bh=MHUsF0ZKVLnzFmCGMZqccyR1UoMJMh5ccZxGxTuquBI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YAixor5OmCR+xzhSEY9bt55qS4/vAYOz/67QxqPgdFRGtrZ3tw8EQMf7MISIPiW8Efa27loWckcMyQk8HAos65UTL4NTCI5U1AUc58W/9ZTm36co3njRshGfgaVCR/jt4D1PRid5YhqDmFFwDaoWJxAsxmKFbfCxHdF35afglaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjHi87A9; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d28051376eso27110331fa.0;
        Thu, 21 Mar 2024 11:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711046037; x=1711650837; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bVfOGEA+RApKepYpAKa+5/4nX+aQTqN+tciKHufCDCk=;
        b=hjHi87A9X1BC/2NAVfZxpLj1DFQEpcn4SROQyFajo4nu5fEPGHqz3Sfd67df1ddUp3
         DkAkmNYwz8mJsztc6lyPRNIXzsREQ/Jn5W70KYMUR/PgniKkrs3x6YpG57FU0OsLSqov
         zWX72hWAm3HcGAV8/aQ4K1pJCyQVDHJ9Q9+kRnS9gtJwRlXOSIHgxnZQc0jkhy8o4EHg
         OiZg+qt+/G5geB/47pkk3QCc6NDIes+9A77MrM/yi3b+t8UGjo4GkeS+mJZ8bTnNI4cX
         4IBTFxkxBGhFbi9L/4wKwqhZOIkm0GILgvUnCs4PTg+cujSnnRM1RWDRUa59kGkG3XX8
         gl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711046037; x=1711650837;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bVfOGEA+RApKepYpAKa+5/4nX+aQTqN+tciKHufCDCk=;
        b=VSeUXoNPo8iZ4Q5f+p819WJvFm4r2z41/qSA2saVD+SMzTwNiUZScC4A0cvWsRH8js
         /d8I3ARejEG+gtbdbr2k/gCbjVRX+k+0jr9t8xoR2um5dN/ocv+34RKcziBY7TswhIWz
         C0KTvi3StWwcv/TGoybN5dcNGpq+wOlhlDBJnMrMfLRcy4GdCugocvugbFrLclO+mWxy
         1o0sVdLtiB3OfO646Ytj3HUvsNjEAqYGysiwQpowb769ah4crxF2ZFljdgSywVcGoG6B
         iIYfMQE6iOIAR0bRReMVYvnUa/vHCiobIgJG8CXYWNXLuIskJghV71NLpHw9tHoJmpo2
         YCIA==
X-Forwarded-Encrypted: i=1; AJvYcCXrswLBS8/UK1FVdZCuh/mcOUuVS0ghCJ/GVBIT+qaBMVa9HyxO/89mAvu6BZZM3w7j2+itVWqbrhjVmRlll1RgHfMLZsqaYKaC4H/+qFwVKbQBJ7paRM8p+KvapL9bb4abFz1u+DNpdQ==
X-Gm-Message-State: AOJu0YwKcbkBvoFQxzUQMiL1ztSfE15iFK2D2X7UqwZtHGJG1F4+WBWz
	mylxdafqpcjWQ/ZJ5e+E9jtARr1YZnlG3xKvVS0SNJ8CAvRjaNiDxAse1RmPRdoHDA==
X-Google-Smtp-Source: AGHT+IHN5lmPfqqqsRFWTswZDZDtxZlUJsXrDi3w+38qfrL2vMfShkVJs/ekHHk0JmKBf8Hp2pvAMw==
X-Received: by 2002:a2e:a374:0:b0:2d3:5ddc:b949 with SMTP id i20-20020a2ea374000000b002d35ddcb949mr275854ljn.2.1711046036525;
        Thu, 21 Mar 2024 11:33:56 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-7db2-5855-2c59-b89b.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:7db2:5855:2c59:b89b])
        by smtp.gmail.com with ESMTPSA id hg18-20020a1709072cd200b00a4661caeed7sm191511ejc.48.2024.03.21.11.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 11:33:55 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/2] iio: health: max30102: add support for max30101
Date: Thu, 21 Mar 2024 19:33:47 +0100
Message-Id: <20240321-max30101-v1-0-00b83e966824@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIt9/GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY0Nz3dzECmMDQwND3dSUpFQzU4skMzNjYyWg8oKi1LTMCrBR0bG1tQD
 5kwVZWgAAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Matt Ranostay <matt@ranostay.sg>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711046035; l=1214;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=MHUsF0ZKVLnzFmCGMZqccyR1UoMJMh5ccZxGxTuquBI=;
 b=+dmG+162RbLrlLYBaqEBW5NHK0woMSPQ9gQWK26yueDQ3Zh3nuQSiRqrbINqptKlTNSx1ffxQ
 bdzANgQg9Q6CF5vrKZ7HYJZAyp+iPGKAenCQL4c50StNPPaZgNY0NLk
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The Maxim max30101 is the replacement for the max30105, which is no
longer recommended for new designs [1].

The max30101 is described as a pulse oximeter and heart-rate sensor,
as opposed to the max30105, which is described as an optical sensor for
smoke detection applications. In the end, the internal structure is
identical, as well as the register map, voltages and sensitivity. Only
the pinout has changed, which is not relevant for the driver.

A new compatible has been added, but the logic used for the max30105 can
be re-used for the new part.

Link: https://www.analog.com/en/products/max30105.html [1]

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (2):
      dt-bindings: iio: health: maxim,max30102: add max30101
      iio: health: max30102: add support for max30101

 Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml | 3 ++-
 drivers/iio/health/max30102.c                                    | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)
---
base-commit: ebc9bee8814d12ec247de117aa2f7fd39ff11127
change-id: 20240317-max30101-edbe658b6633

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>



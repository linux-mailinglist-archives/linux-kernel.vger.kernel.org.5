Return-Path: <linux-kernel+bounces-19293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C959826AFB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF7E7282926
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916FB13AF8;
	Mon,  8 Jan 2024 09:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ezccs1x5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6860512E7D;
	Mon,  8 Jan 2024 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d5336986cso21378695e9.1;
        Mon, 08 Jan 2024 01:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704707009; x=1705311809; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbFI7jxlJ1MdU2XBnFJ5+RWPjFjcCiysa6RfPs3Aywo=;
        b=Ezccs1x5P4ZK9c/Cr6COJrV/0yzau8gnK9dufv4C6+C0lF26WRNz7+cx8VbNz/TdeG
         OpI1Ko6mCoZWEARK4oLd/aVZ0hhzck9Yh0rqsB55mjW60ZRHbnIbj5JhKGA3ZV0oIFDf
         YsqNKQyBfL7yq5pkx397/HIQIauq/n1A1NKTBwQ4fqbVU7Sc4GlszjeF5voaDdSMX6BO
         gciPMIGy7mqalrfWeQLbeG/sd2j96vYyPX2giVy6HCIVUfU9UiL2wb2q1ZGZpocdhH3b
         /6Y4a2Pq7ndwk4D9XGUw4kjWUpHaNjZglf2XyZmr9WX828ftSOuy6a97jpmSazbSbxcs
         YFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704707009; x=1705311809;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbFI7jxlJ1MdU2XBnFJ5+RWPjFjcCiysa6RfPs3Aywo=;
        b=w3k8/jcDgROfz/tN1JjpeAhOqPeY4UIr15DmaMY1tiemutyOnWw+VaJtD9MiqzheAc
         UpL23SDD4bwFOQt+C2xwxa2r6thFBQWHeUmk7Lsfw/99UTvAV2IQmu9VZ4zWhB4aYMnC
         z/PEUfUXyaOHvPccUgoaYugIGBZsWYI6gMU4dTt811xkb+wcqPXbs1B5LQ2ef5lJib/X
         z4c5qWWUwHj+Y8+xWIJggUF/fxnsBPKMaMu4oDTn3TU04eocgx0cmjaKSMmXGES3kQ84
         noDM0RYh074mm7gCCsTwqC+kCqtRhtn2wEO6ps5xy1z+kRprcvGH9WxVuNOLXlNOh1lp
         JONg==
X-Gm-Message-State: AOJu0YzD3+bWvriZWQFi4H+NtrMZcZbF3oT3c3Jh/+pRg+b74YxapX7S
	AK9o9X9AFutBkYm+ei4AZAA=
X-Google-Smtp-Source: AGHT+IGVk7KEe8auVO5RVtV3bO1kdtTiDMGOcAZggaNg9TAksKEDh2UQH3pZIpWuQXFCy5a1hlR+Wg==
X-Received: by 2002:a7b:cd8a:0:b0:40e:4789:7842 with SMTP id y10-20020a7bcd8a000000b0040e47897842mr492225wmj.236.1704707009344;
        Mon, 08 Jan 2024 01:43:29 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:a060:7056:782e:5e26])
        by smtp.gmail.com with ESMTPSA id y10-20020a5d620a000000b003372befd19bsm7322344wru.104.2024.01.08.01.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:43:28 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: correct file entry in ANALOG DEVICES INC AD7091R DRIVER
Date: Mon,  8 Jan 2024 10:43:20 +0100
Message-Id: <20240108094320.31296-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit de35d4092681 ("MAINTAINERS: Add MAINTAINERS entry for AD7091R") adds
the section ANALOG DEVICES INC AD7091R DRIVER in MAINTAINERS, but gets the
file entry for its driver wrong by duplicating the intended path.

Correct the file entry to the actual path for this driver.

Fixes: de35d4092681 ("MAINTAINERS: Add MAINTAINERS entry for AD7091R")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1bf5637bd1f9..23d19b2a7ae3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1137,7 +1137,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r*
-F:	drivers/iio/adc/drivers/iio/adc/ad7091r*
+F:	drivers/iio/adc/ad7091r*
 
 ANALOG DEVICES INC AD7192 DRIVER
 M:	Alexandru Tachici <alexandru.tachici@analog.com>
-- 
2.17.1



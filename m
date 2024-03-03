Return-Path: <linux-kernel+bounces-89934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE6E86F775
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 23:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6FE21C20BF4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 22:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A594D7BB05;
	Sun,  3 Mar 2024 22:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6AKprn4"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A8D7B3C3;
	Sun,  3 Mar 2024 22:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709505307; cv=none; b=IxVP8jyaERk4iZ9pVKA2R/usBl4J6P3ZYqQVHR6owN5/uqNzE90JRTJudCR4fcjidgxw6KThrCZhgqM35Ecuw3Q8IXMcG1FI/sTeHI+IiwFYRPJfcY6SgdVrJmQdRN32qkTeJHkmk8V4UF0Gwluz0NO5L3nERl2Fwi4ojtNvYHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709505307; c=relaxed/simple;
	bh=79mbb2+TIDQaUEgPgjGzGyWmQ6IE/7EFKvBoMMEXxSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D8pbB0to6gCYyAOIdcL8bkGXr6jlr8iDq/bjW8UgmJFSTPFnZBicQDBgeopwtKHPUsxZu2ek06eJAWXWa7Dl7CVSr3GVDVv5X5PkFOgQu4H1kkX5hEaiF0HE4e/y97j7fHHfavyBYxiJx5NrW6WhvaJgfOQVL5IHkhEhe8swNl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6AKprn4; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso507378066b.2;
        Sun, 03 Mar 2024 14:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709505304; x=1710110104; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWKjl3tAqIGbINoDjlumk8vST9xvqacgLbIKFANq1XM=;
        b=E6AKprn4TxEb2kfCzcHoQon68zL/taSY+8NSHBFo67F7vsx208lic5LzW6AemcIqXM
         pGVIyDLKoYxx+8e8OcsNvYyXenOBnXRJQN8cf3aINvmzOaeiZtxcYwR7R3INF5nsfILW
         BFQH4n2SE3Xq6EpwV4ryRyejWm5tpzmmjrdb2w/n30cKhALq/UOb4OSMhFyguTetomo2
         hA9KBwe00chKvrMzGl/A8rLhEkpfWKG/BiNXa4L5FgyY5XQv6p82GpgBTG4peznKLSJo
         SS3jjAUyCNgwjPGR05jPAZNkWRyoF7QwMLy9VC/phDVuI+Vetww5Xdqgw9P5c/8/Q66E
         3c4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709505304; x=1710110104;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWKjl3tAqIGbINoDjlumk8vST9xvqacgLbIKFANq1XM=;
        b=IzbgIqCOvNIVUf0TSEDmY5AhKrjD3BmujYDpsywl2wAgKiS8h1F+xz0+xcEqbYVSd3
         Wn7xmvSiNN5WmJXG2wI9I7mf2vQ206dXIqgKRh/os98sMfCOLdVT9g4metecYXL6iU99
         IxGrOQktUcmB/hDfWgTZCgK/xDwRWcOcU69dHod6rAb1zn1oKbsR2YcObGqUfAX/Ca6u
         5QG4jlqGrFr66IunCW1wmm+TM1DPTukptKmbU9HTvv+HY+kLebrY5BbLJCplCofWIfgP
         bRxL6QjYzNx6WLCjl0cK6EyCHZv3HupvWqicojCItgDSlPLqB/xj/9qlsgWZVHfYq/1r
         oP/g==
X-Forwarded-Encrypted: i=1; AJvYcCVZhlY+rmdZL/IIyVeSydy9/If2YaztSfzT+WDxf+HyRMTxmUXnjhq9hG7+A2EUlc8jKnVTVGIQwmrtkLHHeiaPaQD0Yt7BKMCiwwRbDz4DVgv1ylXA0ctR+KgtRGeFw+CSYtMbEuBQ
X-Gm-Message-State: AOJu0YwUV+LiebN1enCthoqc9p7gG41dRw11ByF+Qiy2q1GFcGQwrfMb
	noMRCqQQRIkadpBZWqajub/CrYN749PbD6afiMuHGYOEfiBXwa/g7aNdKAqyddbMCg==
X-Google-Smtp-Source: AGHT+IEJFBzlnEnxBp/PHypSF/HfNr25oWw8mUZWDBmD36eOtQusVnD+aAwubxhnoYyz1WZf7WAYLg==
X-Received: by 2002:a17:906:e211:b0:a3e:b407:65ab with SMTP id gf17-20020a170906e21100b00a3eb40765abmr5531102ejb.50.1709505304065;
        Sun, 03 Mar 2024 14:35:04 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b3d8-5b4b-5188-4373.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b3d8:5b4b:5188:4373])
        by smtp.gmail.com with ESMTPSA id v23-20020a170906565700b00a455ff77e7bsm82204ejr.88.2024.03.03.14.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 14:35:03 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 03 Mar 2024 23:34:41 +0100
Subject: [PATCH 3/4] iio: humidity: hts211: drop casting to void in
 dev_set_drvdata
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240303-void_in_dev_set_drvdata-v1-3-ae39027d740b@gmail.com>
References: <20240303-void_in_dev_set_drvdata-v1-0-ae39027d740b@gmail.com>
In-Reply-To: <20240303-void_in_dev_set_drvdata-v1-0-ae39027d740b@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Michal Simek <michal.simek@amd.com>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709505298; l=837;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=79mbb2+TIDQaUEgPgjGzGyWmQ6IE/7EFKvBoMMEXxSU=;
 b=Ply3oD0X63A0jUQs96z6imU6GNzQvYsqaOQlwrql7jVMEZiC6RdkkNnbXavoo/vKb270qQCxv
 cqDXoIDQ/xcB/0vZryFbg8B/vEZBmlU5k5d551eaGBkg3HYXZacuDvS
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The C standard specifies that there is no need to cast from a pointer to
void [1]. Therefore, it can be safely dropped.

[1] C Standard Committee: https://c0x.shape-of-code.com/6.3.2.3.html

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/humidity/hts221_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index 2a413da87b76..87627d116eff 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -573,7 +573,7 @@ int hts221_probe(struct device *dev, int irq, const char *name,
 	if (!iio_dev)
 		return -ENOMEM;
 
-	dev_set_drvdata(dev, (void *)iio_dev);
+	dev_set_drvdata(dev, iio_dev);
 
 	hw = iio_priv(iio_dev);
 	hw->name = name;

-- 
2.40.1



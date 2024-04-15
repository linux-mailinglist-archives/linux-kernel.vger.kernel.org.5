Return-Path: <linux-kernel+bounces-144918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C34A8A4C97
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1ED1C210E5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EE95C8E4;
	Mon, 15 Apr 2024 10:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dv1Gkktj"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A045B5B5BE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713177301; cv=none; b=FZGdI3dEH+hwhs9NY5GBaGAvkvAE5P7vbi6EahTReRTa/tfIZuc2UfdWJxdAbmnYvhySe3I1qP2XBmDVjcMEBHsYkCEbg5aTc76NYH+Rf3xBLoz1hUxe1rJcChvqnWUgqYE7bkGxQZZsEp62iiocYoY6cuX6/bCF6ujlIYSYO/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713177301; c=relaxed/simple;
	bh=EFqueGpy71r8mk7yd/Fy+o3d7bUXemDhP6mho+kFJvw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hB3JCOAcDGIJItbbdjV+w+bP4HUY/2FCXAXpIy6QgI+saPkj/GBJzc76mH+m9wsU9BT0Uvdklqoy64SmB4f1kKBhg9GPYg2Jh30fNNdVzliNtradVTOZoA07S+y6RsliRXu0FmUzaDkjaNq4MPiVZDMRU6NC+UNbi0aTtHBBlX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dv1Gkktj; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e6acb39d4so3850316a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 03:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713177298; x=1713782098; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=knIjWuJEH+J0HrZVWnDTxaPyryx3WGEM+wJiEZytvQk=;
        b=Dv1GkktjpzGn4iElquo3Dr2zxTu5TkT7XdQVuDmCnGASJRmYkscOM1gRXVFLoaq+Y0
         P23z99qe2HgH1I9knpDS9fyP41NvdErKdj9CTo63pdvvLVuSBPDQaRiGB/Yz5rdHsark
         7YT0I8WXsInWIInVkTnzpED4Itu+mlbMQpHZkfnNlWkR3EalVDGtFPDc9AVe7YZEogll
         3aEYiZgsHIO2AMBrY0RNMPzrBw8qiUefW3ZHyA+1jdpmOfNUQj36EZeNRfTQ/dE3NIaP
         +5RshVaLF0HwppuX1OYpNpgQuQ++Z7QyRegHuy3xs9ne6WKXiBXQ5dwBFW0QcKQbJhCV
         0a2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713177298; x=1713782098;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=knIjWuJEH+J0HrZVWnDTxaPyryx3WGEM+wJiEZytvQk=;
        b=UwVmYjJBflXbRiCnU6nAFbxt9YUpuHwqFXVu0vxSEEEq5MxyO6Czi2zJMgit6YDTL5
         yKxU4qc5w4acRz8baFaZ3e89TtiG76p8pcHEa/RtPukoeyLQa/wUwlJkHh3tpLBrlYLI
         WRw4LzctU41HMXYtN2q2v7fmyWBgSiA4B7m2D4CS05BcOA3f8nKSulWGIs5FzHaesRAB
         uDAC+6J8hj7jLyUevWtPBrt8OxjMF/kx72+7tgwX6EMKvF11EsOrDwlwhcfSE/iTAGfY
         erP3BjyzqK/rTTJ7XvSr6I13tMs8PKBkFtd3cQbN44GKorKHrmGuW26kvI2/5VEMQU7y
         gu6g==
X-Forwarded-Encrypted: i=1; AJvYcCWa0HOObrNisQtW+0DuxzXWyJyVLMjL6raoICt6sVSw+K264xr0iDKP/LQed4Adnf0V+08ErPteSwVXKDJFly6mHTRV5pQkS/KB77AI
X-Gm-Message-State: AOJu0Ywqre2jdc6QYS7egIfcSjfy1Fs4tXmB6p/kN0NyTCnATu0CV9BM
	+UdTewkjYZHWXuvxV5/q9YyltLqQ39xG762xKSzDPk86paEfUdjrzvI/XTM2LWQ=
X-Google-Smtp-Source: AGHT+IEM9DjvbLEs/iTz61CYmfTK7igocYO0I2yXTdxW1t/sbMQroUqeZbwz45KUR27jtpRh0M1RpA==
X-Received: by 2002:a17:906:168a:b0:a52:6435:ef09 with SMTP id s10-20020a170906168a00b00a526435ef09mr2028980ejd.76.1713177297932;
        Mon, 15 Apr 2024 03:34:57 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id xi3-20020a170906dac300b00a52228ce058sm5142470ejb.46.2024.04.15.03.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 03:34:57 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:34:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] regmap: kunit: Fix an NULL vs IS_ERR() check
Message-ID: <b32e80cf-b385-40cd-b8ec-77ec73e07530@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The kunit_device_register() function returns error pointers, not NULL.
Passing an error pointer to get_device() will lead to an Oops.  Also
get_device() returns the same device you passed to it.  Fix it!  ;)

Fixes: 7b7982f14315 ("regmap: kunit: Create a struct device for the regmap")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/base/regmap/regmap-kunit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index 44265dc2313d..9c5314785fc2 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -1925,10 +1925,10 @@ static int regmap_test_init(struct kunit *test)
 	test->priv = priv;
 
 	dev = kunit_device_register(test, "regmap_test");
-	priv->dev = get_device(dev);
-	if (!priv->dev)
-		return -ENODEV;
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
 
+	priv->dev = get_device(dev);
 	dev_set_drvdata(dev, test);
 
 	return 0;
-- 
2.43.0



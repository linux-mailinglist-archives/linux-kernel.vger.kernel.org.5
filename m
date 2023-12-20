Return-Path: <linux-kernel+bounces-6605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF64E819AE8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70941B239EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3F71CAA7;
	Wed, 20 Dec 2023 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OYPftctD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA861C695
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40c38e292c8so2737935e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703062297; x=1703667097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtfgLv97mV5DO9TnNkLsn4oa9MmDYWceuLZDcW6WRCs=;
        b=OYPftctDOd0EGGXIzed/QcvvskiQd9DJ7HpbVsUudecxo67KNuKfqwAJIVl0c/eXvV
         sekrVnWPA2zwJ2fBWej099X777rzYG+bU62078RoQG7uOI9BYSuIb7kGqNYGp49EOGkv
         49GzeBk861GBRNPq6UytDZoj9ugNYmIJXTeJUim5r3InE6W/56tSOu2y/erfIN75lIjT
         8cDslRARDNOCOBaoWsGRA/7pdiht8QGtYSdK6y8riI84uts7QGx9sUSmNj9h9qEFCIQf
         c0EvR79n7agl26lzl9HVPuiQPoRVeSw3dKJqhT/HoKaD4zj6TuzPYfldkBhsDd73ZBed
         1aeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703062297; x=1703667097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtfgLv97mV5DO9TnNkLsn4oa9MmDYWceuLZDcW6WRCs=;
        b=FjRNf98WdToZzK3kcY/4iVdqEYJ1phgsK0bhNomhrqoDtSl86mWX2AIio+zbWVPw4K
         oV/vgsoutabX1m3F548cKWYBKJJt2rXr0hVgnKmi0TFoqt2xrwLtC2KdHV3Eq5wVXoma
         XyvdyrDbvIn7yWuNOwutBqBmJ5a93R9lk7FuT4I4KHhBhXNANvR5CwGdWc0FCFO3TotY
         iJjEtHOWX0uaVaZkPnS1UNp3fFg1vAkJzktfdl79YsGtXx32bCOEcmManJwmIgP0b2Vs
         /NEu37kgFyV8FjWhWHaiN0xFb9seBF5u1OxBoGOhKIBoio8LkfMlKYHXi5I2ZrlPAU6O
         eEcw==
X-Gm-Message-State: AOJu0YzXeq6UZex8OX8ZlrgZpxq24XmbXLPvNh7pj00d5diAgjeu4e+D
	0+89t400zXiNNTF5oTKeDMp6+A==
X-Google-Smtp-Source: AGHT+IHevkVtzLWY4Thk0wPFWCO8kIPI/j01K6/wMrTuOTxuF3jI+CG+Vou8zBvdiOuvY1k7+xUQ5g==
X-Received: by 2002:a05:600c:3590:b0:40d:2dbe:b25e with SMTP id p16-20020a05600c359000b0040d2dbeb25emr882142wmq.61.1703062297022;
        Wed, 20 Dec 2023 00:51:37 -0800 (PST)
Received: from 1.. ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id bl40-20020adfe268000000b003365fcc1846sm10866811wrb.52.2023.12.20.00.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 00:51:36 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: linux-gpio@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <michael@walle.cc>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Pratyush Yadav <pratyush@kernel.org>,
	mwalle@kernel.org
Subject: Re: [PATCH] MAINTAINERS: change my mail to the kernel.org one
Date: Wed, 20 Dec 2023 10:51:30 +0200
Message-Id: <170306224472.10641.8697108168767750915.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219091218.2846297-1-michael@walle.cc>
References: <20231219091218.2846297-1-michael@walle.cc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=431; i=tudor.ambarus@linaro.org; h=from:subject:message-id; bh=tloYJ/VxN2gy2w43xs8TGDo0bshxdXBahz4hd3feM40=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBlgqsQ137AdkHk/hreamHCQIRz1/ZJIE1RSSAq8 ZKniR8j3WiJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZYKrEAAKCRBLVU9HpY0U 6VXMB/958O9O3xvLgiQGRIvFrYToubfyV8srZ5OU4HBYFsKeamX2rCBm0HAEZjIOArE5pDfJ4q1 toVSQbbMfrcXYPgllQg609ri55F0pMcHnwO4O3p7Ved4g4i11kcpKEEVHbImVIEITVAaxnFUo4g NkGUzd+V09d7LyRwUMYsWOkVm8pNk4JFEZhK8rbf5FiPB6G4lZqWnaOx4mmxBuWfwAGLR5OSPdc mF867HobDAIRw9BvGEJLEhpBa0hHfhN5tDN+J5a8aWrTyob+5dtit8O1Db1TheNn53hL0P+m9l+ ScCqckP0L3eEtjWClWpTgoJj1jyFmRluJk4pBTi4ujOH7ths
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit

On Tue, 19 Dec 2023 10:12:18 +0100, Michael Walle wrote:
> As I'm doing more and more work professionally, move away from my
> private mail address.
> 
> 

Applied to git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git,
spi-nor/next branch. Thanks!

[1/1] MAINTAINERS: change my mail to the kernel.org one
      https://git.kernel.org/mtd/c/3c0e1dfa703c

Cheers,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


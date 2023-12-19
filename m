Return-Path: <linux-kernel+bounces-4613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE47817FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83D51F23DF8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1217E468F;
	Tue, 19 Dec 2023 02:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CkbpSk0d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603734411
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 02:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-336437ae847so4192406f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 18:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702954034; x=1703558834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnwKqS75fmoBKZ6JUfdCyxecRAaSaUAJyW+9JW8x254=;
        b=CkbpSk0dBithTV5/aI2vEc83UGFpw8ZDkOh01gNZ1a9mh5qzJFRQbtEUwrXC3mCtRI
         0/yuEjxpIHcifcjItTAWS8kvO1L7CU+x1MpZqHuktTa/UDh5bnxV96kazNejv2yv9VcD
         +WNLiRMm4r8D/lohiCz0YCJ8FZACN/G/gobJn3xJ6mGUYUrt1LxvFXRv7VokfvbljvKJ
         NzZwBgnpXThs90BDoVm+oC2zHrPRqww514Rz/GHFTs8fIFSiyCQHaVkPPMJRWjBnzKEX
         Ie4us8tnxAolZZWQw90enihgV5orD8gokgoh01Rw5J7pE5NODujPhmqv+sAff4VLhb1G
         QX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702954034; x=1703558834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnwKqS75fmoBKZ6JUfdCyxecRAaSaUAJyW+9JW8x254=;
        b=nKCor33fOGwt9nADu6cwwHxvzeUgy6vO304xAQdiftR5wGRxxfmcuGC3GGgSbQyRU2
         10pHdhqTeZFFWxSz/LnL4U4FmXYZ3pXGGkUNVOhMveToNa4XrViS7msu8yPfmQRDSVjv
         s5GySrQ2vMXVsXTurNSm0IPlCAWtDJTSULnUt/zEnfMATbMwIhHYDaDg63XsteZphqei
         +N1m6fz/jjrqMQ2W/xSeN0LQBMv6fOrpQap51RUvpC+upW2kWiaOSz+zcFdmmgPVRHWp
         JXaJjEmugXM4ZWS/stpBn3ZjtyWgP0dUm9MPn7xBY0A7NhGTAKfTSckFHVAcoEWGknuH
         xrRw==
X-Gm-Message-State: AOJu0Yx/k0KeDeKH6VW9sI/LY4OslqTwSBLh1z1hEe+7ly/Pg6KB65f3
	80Xd82goA3sDSGBbqmETtRIVNQ==
X-Google-Smtp-Source: AGHT+IH1es16u7uh0bMTqgZjbsRgfKYgVlo+U8MgK2DplnFlSN3lmCiHelfm/k/tTubXGi9FelB20w==
X-Received: by 2002:adf:ffc4:0:b0:336:6701:e80 with SMTP id x4-20020adfffc4000000b0033667010e80mr1869086wrs.94.1702954034493;
        Mon, 18 Dec 2023 18:47:14 -0800 (PST)
Received: from 1.. ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id e6-20020adf9bc6000000b003366cac55f4sm2717124wrc.107.2023.12.18.18.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 18:47:14 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: pratyush@kernel.org,
	michael@walle.cc,
	miquel.raynal@bootlin.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: richard@nod.at,
	jaimeliao@mxic.com.tw,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] mtd: spi-nor: mark the flash name as obsolete
Date: Tue, 19 Dec 2023 04:47:11 +0200
Message-Id: <170295399037.64561.10229495240556989288.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215082138.16063-1-tudor.ambarus@linaro.org>
References: <20231215082138.16063-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=935; i=tudor.ambarus@linaro.org; h=from:subject:message-id; bh=3k65lHxgY8sTNdZdKmSGqZ9DWwsAKEbwE62VkhhJp5g=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBlgQQtyDhGCTtoQ/AWoWIAMvk3UvtDtHhhM2ESp wP9cH/Ae6uJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZYEELQAKCRBLVU9HpY0U 6dTQB/4qnGysk7VNTyLTeMGD+fDu+sYw8EkWK0XRsJFfPLTJCMi0jFz2qDDBr2ZnyzqS5UO8NYB eZoeWUXae8SnLa1X/55GFvJAbk9ws/oi3dA4I381Gss3HISPzJ7YvNse9891R4D00pbY3OqCAkd pHgvSDQLZj8OsNHqkoPAGlgbBQqozYZISYoEJkuXQqzYPuLevV/c7aDSX4Elwoy2UXoxkJjlaTR po/dWCQZ5nGc6oxByL55mnlWks2roaSZE/dlaYxJo1smhcTMb82+LjwxmFfCp2JBxMdnBvaoj5X yvAjDqvq/xEOSsyHMEEbBDIPTz88tO5evVJhTcqqtfWao9aI
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit

On Fri, 15 Dec 2023 10:21:34 +0200, Tudor Ambarus wrote:
> The flash name is unreliable as we saw flash ID collisions. Mark the
> flash name as obsolete and print the manufacturer and device ID where
> name was printed.
> 
> JaimeLiao (1):
>   mtd: spi-nor: sysfs: hide the flash name if not set
> 
> [...]

Dropped unused variables, fixed typos and
applied to git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git,
spi-nor/next branch. Thanks!

[1/4] mtd: spi-nor: print flash ID instead of name
      https://git.kernel.org/mtd/c/9fcb0999345e
[2/4] mtd: spi-nor: mark the flash name as obsolete
      https://git.kernel.org/mtd/c/15eb8303bb42
[3/4] mtd: spi-nor: sysfs: hide the flash name if not set
      https://git.kernel.org/mtd/c/62f92e62c1ef
[4/4] mtd: spi-nor: drop superfluous debug prints
      https://git.kernel.org/mtd/c/7bf018ea5cb6

Cheers,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


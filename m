Return-Path: <linux-kernel+bounces-122893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B65488FF1B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C922935FB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508707F49C;
	Thu, 28 Mar 2024 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ypwiHoIt"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FC97EF1D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711629288; cv=none; b=eMgzxL+c42GSfO5CKJhEtcw7qT5BCjJJ5djS/CYngA/KvA0CLzaVUZKB4lr7zCLJD4iKby9lMTXtWtpn+lUrpbzfNF2y3cQV56uo3pWFBnEcxcgqjvAZ1IFxN+2DDi7IZ0UYwMKn/uoven/u8ECXOgowYqHuWvvowWdIBr4MJtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711629288; c=relaxed/simple;
	bh=N0VnPgbWrvY1XSHkJSVJnzw1cjtZzFe0yo4Covel7Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DsSY9vHOGewab03beKNRrnshMm03j/heaXjsxM61IjXFOFbAg/PI6LOyFEx7Mxafbc0DE4i+vFql2ucvKY+2fXcCwzYlNYg5+BgIwbh9f/aqAx9vCIdBmxOUeUVjscjudIuQJ3fXIZbf45tByMizl6EfhfXwiDg1eagLmcxmNw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ypwiHoIt; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34005b5927eso608046f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711629285; x=1712234085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0wFpD+++a2qGN194PQlW/ydpKP0vxDJuH65l8GmtaME=;
        b=ypwiHoItjV+5/GIR/MZSqp8UFkl88D3MPWZ5EsBWcyDv7aWwXKwugVn0722FobebGe
         R38jX5z65/G3N1KAV35Mb81InwBIykUshd34indmcysQBvgCZFaketKk+tGrORhTOcfO
         KfEQyusE4TZSKXQccVLabuD52xDppzbGOs/KOZMshkq+VtZUJiJ6VhYEY/3g7pyLFgYO
         W3XOV3hsdu4Oc4pZISXBBCwNgQbcRSI3WAfQd1jAM7bMiiAFZoWrilcMpRArTFuXQcyY
         +HmxL0iHhWL0HvwL1PQofKDHAinW2IAxCDLrzJXsprQmUB39MziU2JraFHTVrDBhJkrw
         hcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711629285; x=1712234085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0wFpD+++a2qGN194PQlW/ydpKP0vxDJuH65l8GmtaME=;
        b=RUapQWQ4EtvWqDUAY1Q+ll8ygPNK5gsKet4umhhWetkrFPkY9vJ9voOLE01xxSRIo+
         0Ea5IMKqToW8lfbH9oQJyYHfF3F5Svkp7hicGABh8kfKldUTBKAV7OKFP0hA2gFD2vXz
         0LW+IDxU5nWhN0g8j64ji9XkVTSOOE8v3WL+5boBYsN2a+uxy8u2KVKNkwXnqQ4Wj35B
         AWQUJ4FPOg5WIYGqQxtVqTylFLOOVZ5EzXVybriBblY7o0oc5TJLlSlU/TWFQD3hQwFN
         ALxayWtQAfpmcxhrScV93jZvKRDYyWvOKQ7QplaJZx+Nis91ZyMJRDu1wo7h5gJNZl05
         Ec4w==
X-Forwarded-Encrypted: i=1; AJvYcCUBxIy2cFG5iMQBLTPjPeZSghRbJrMt2bhFfCWQqTeQRFHCnFIKI7Wd+/KPYXrWhbR3TK14X3Vj+dcs0KY1z+IGNekdzngCmjNf05f3
X-Gm-Message-State: AOJu0YyyRz4ZarXZhnb+qVwnRJJ5Hy5l1NMGCQVNnqkMpmJyXyOxzLMn
	I5IbNXWaRiA5nn2UHfiRYzGY8/9aYma06lpy3XYln31R11Eg1ipXk8FZAyZWRNA=
X-Google-Smtp-Source: AGHT+IGeWvo/4NVkNv2RtRW6WUniovQcsePcpHiG6m59zjQV4C3QR40TEwzrJzXenDVVjdliNkIBvg==
X-Received: by 2002:a5d:6448:0:b0:33e:c316:2a51 with SMTP id d8-20020a5d6448000000b0033ec3162a51mr1524284wrw.27.1711629284889;
        Thu, 28 Mar 2024 05:34:44 -0700 (PDT)
Received: from ta2.c.googlers.com.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id u6-20020adfa186000000b00341e2146b53sm1639671wru.106.2024.03.28.05.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 05:34:44 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: peter.griffin@linaro.org,
	krzysztof.kozlowski@linaro.org
Cc: alim.akhtar@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	willmcvicker@google.com,
	kernel-team@android.com,
	s.nawrocki@samsung.com,
	cw00.choi@samsung.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	semen.protsenko@linaro.org,
	linux-clk@vger.kernel.org,
	jaewon02.kim@samsung.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 0/3] clk: samsung: introduce nMUX to reparent MUX clocks
Date: Thu, 28 Mar 2024 12:34:37 +0000
Message-ID: <20240328123440.1387823-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

v3:
- update first patch:
  - remove __nMUX() as it duplicated __MUX() with an exception on flags.
  - update commit message
  - update comment and say that nMUX() shall be used where MUX reparenting
    on clock rate chage is allowed
- collect R-b, A-b tags

v2:
- reword commit messages
- drop exynos850 patch on Sam's request

v1: https://lore.kernel.org/linux-samsung-soc/20240229122021.1901785-1-tudor.ambarus@linaro.org/


All samsung MUX clocks that are defined with MUX() set the
CLK_SET_RATE_NO_REPARENT flag in __MUX(), which prevents MUXes to be
reparented during clk_set_rate().
    
Introduce nMUX() for MUX clocks that can be reparented. nMUX is used
in GS101 to reparent the USI MUX to OSCCLK on low SPI clock rates.

Each instance of the USI IP in GS101 has its own MUX_USI clock, thus
the reparenting of a MUX_USI clock corresponds to a single instance
of the USI IP. We allow the reparenting of the MUX_USIx clocks to
OSCCLK. The datasheet mentions OSCCLK just in the low-power mode
context, but the downstream driver reparents too the MUX_USI clocks
to OSCCLK. Follow the downstream driver and do the same.

Tested with USI6 and USI13 SPI.

Find discussion on MUX reparenting to OSCCLK at:
https://lore.kernel.org/linux-samsung-soc/d508dfc1-bc28-4470-92aa-cf71915966f4@linaro.org/

Tudor Ambarus (3):
  clk: samsung: introduce nMUX for MUX clks that can reparented
  clk: samsung: gs101: propagate PERIC1 USI SPI clock rate
  clk: samsung: gs101: propagate PERIC0 USI SPI clock rate

 drivers/clk/samsung/clk-gs101.c | 225 +++++++++++++++++---------------
 drivers/clk/samsung/clk.h       |  11 +-
 2 files changed, 129 insertions(+), 107 deletions(-)

-- 
2.44.0.396.g6e790dbe36-goog



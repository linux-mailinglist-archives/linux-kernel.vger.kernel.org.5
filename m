Return-Path: <linux-kernel+bounces-77916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C40860C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 006C1281487
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1829018EB0;
	Fri, 23 Feb 2024 08:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6oWMldV"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5906168D0;
	Fri, 23 Feb 2024 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676421; cv=none; b=hQzw0FHc9+lXfyDWC1GvItBXgpx+lUXDWlaH1ApWFClgL1N+qjQ6JIxIIgRSmyc5cHtW9Ru6Yzn/fDJ4lWSrsx6TumsKCxkEis5DBvonn6dq90ObrPiBRkuvLw21L+ZD/zGqKk5umpSBlwD1hH5IAOueVWmrxuy2xJCrfJps8Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676421; c=relaxed/simple;
	bh=3/tyvtTLYkVikNeiWKkzmPYZ1L/MFt6KSzklylS//MQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pRk0HU+n3jXw1/5jHbNmQJL+oNljqYrNJF+TZ8Z9mDGTRcW6OKghdMsLkXZZkx/2qgJSbboOcGwM90Ut8149hTzWPSUOE+yY7MQPj5QS2Ym5jSB+kf3f9hVQm3KLjd/fw4JM88gyd5gAXAA0HiHibr+l8fRJteXigB91rrhRhE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6oWMldV; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dba177c596so4399965ad.0;
        Fri, 23 Feb 2024 00:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708676419; x=1709281219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sze53a4mLbAZrJRpXbT6ASWNWrGoWY6+1B710NM4C+0=;
        b=h6oWMldVZBtmomhJChDQUWHEgMGYD96KR8JI9aNiklsI6mZFK8wVRYp5zT/oxcZR5X
         wsdbP63q0NY9gKfVk6B/3y+BBNvXUlGRVWqIodZbmv1tGQkuyZjYfqFujpGqXeWzJS8N
         HH0XDBd6HYVSAj8OA0GuE82tDi99qJgaKav4+HQ76MOQV+GbE+OA0Vukebntf36UY3aA
         WlVzJVidtzin3/r13rLPb4H7FygBIKwdmoli0SSWa8Mr65/0LeRTrK8n8GLiCUtqAL02
         f9CxKi0ips3JKqTqVpYo99064cL6A+gwtgRHeQyRRPqjXukUX5yhmfIEbeZ7sO/TIjI4
         74Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708676419; x=1709281219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sze53a4mLbAZrJRpXbT6ASWNWrGoWY6+1B710NM4C+0=;
        b=kNZnWzG+On5Y9DSWVxp1CTKzzH4WWFSCKiogwN0YTfLcpYMhvkxM5lc4TkkCqby/g2
         sxpu7rHq1/w3uETykbUee05TYh7EPFbu48kn3YRSz+ILGqFdvDmFTwCtTzFv9nEvc5yz
         iY4Q1ruQWQ6Uw2lxI03zIaAKT69IK0LxgR3Bkuxx1fm6M1JcLGuy6yDze2E4nvcac3y7
         PnWx2I3W6+7ut2vgJiIpBULtv5QujiMY4yCjQKX3p5bc4ISVAOU8uspIykb6G5JKgfhb
         ELTx3SGX6tjHOVwVfkz/pfy8joh0jFJPw6+FDfNKHAn/TuHkgeXxTSC3rtTWLmdU0IdU
         Zaww==
X-Forwarded-Encrypted: i=1; AJvYcCUnIdgjcLfpJtVOhOsqKvlEGnKVrNTyi5VlAdb2oagO6cxZJ/gKC+6I8hPXR0hdBFLejS1RAF1BUAMXTP0YjIO73U4/TXRo2s9KtBbqxq8eJNjd03HN9SqnAZT68sJnJJfwg4KXPrTrxg==
X-Gm-Message-State: AOJu0Yyr+rZgVhqCoSaUPZGCOB5sBEJLfet0AVu+R9amt3tETANMcvBS
	KZjbTrJn7J0zgwU87S0y79QW3AvvtEWm2yOCsqK17AWxB0FoR664
X-Google-Smtp-Source: AGHT+IHN9p03M6aIBHrqTTDGUkW5yhHqo0eDp/G/bUfb2CZSqyCXW4ZWKB5vivJP5QX2Ka3E7QQ6Hg==
X-Received: by 2002:a17:903:605:b0:1db:c649:cff0 with SMTP id kg5-20020a170903060500b001dbc649cff0mr5932075plb.25.1708676418326;
        Fri, 23 Feb 2024 00:20:18 -0800 (PST)
Received: from localhost ([46.3.240.101])
        by smtp.gmail.com with ESMTPSA id v12-20020a170902d08c00b001d9588f0714sm11163439plv.177.2024.02.23.00.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 00:20:18 -0800 (PST)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: u.kleine-koenig@pengutronix.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	dlan@gentoo.org,
	inochiama@outlook.com,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH v3 0/2] riscv: pwm: sophgo: add pwm support for CV1800
Date: Fri, 23 Feb 2024 16:20:12 +0800
Message-Id: <20240223082014.109385-1-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Sophgo CV1800 chip provides a set of four independent
PWM channel outputs.
This series adds PWM controller support for Sophgo cv1800.

Changes since v2:
- use 0x08 instead of macro
- split if statements based on conditions
- in order to round up, first calculate the
  number of high-level cycles, then subtract
  it from the PERIOD to obtain the number of HLPERIOD
- use new pwmchip_alloc() API instead of old style

v2: https://lore.kernel.org/all/20240212121729.1086718-1-qiujingbao.dlmu@gmail.com/

Changes since v1:
- drop full stop from subject
- re-order maintainers and description
- pass checkpatch.pl --strict
- fix naming errors
- add "Limitations" section
- use a driver specific prefix for all defines
- using bool instead u32 in cv1800_pwm_enable
- check and set state->polarity
- use mul_u64_u64_div_u64
- use clk_rate_exclusive_get(), balance with clk_rate_exclusive_put()
- using macro definitions instead of shift operations
- remove shift operation on 0
- use priv replace cv_pwm 
- hardcode npwm
- set atomic to true
- remove MODULE_ALIAS

v1: https://lore.kernel.org/all/20240207055856.672184-1-qiujingbao.dlmu@gmail.com/

Jingbao Qiu (2):
  dt-bindings: pwm: sophgo: add pwm for Sophgo CV1800 series SoC
  pwm: sophgo: add pwm support for Sophgo CV1800 SoC

 .../bindings/pwm/sophgo,cv1800-pwm.yaml       |  45 +++
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-cv1800.c                      | 259 ++++++++++++++++++
 4 files changed, 315 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,cv1800-pwm.yaml
 create mode 100644 drivers/pwm/pwm-cv1800.c


base-commit: 801de0882d8a95aa1b1fe67df1696e037d785656
-- 
2.25.1



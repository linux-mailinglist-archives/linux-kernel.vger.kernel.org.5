Return-Path: <linux-kernel+bounces-26948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6683882E868
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F752849E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 04:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D024079D9;
	Tue, 16 Jan 2024 04:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="S3/uqofw"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48A8748F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 04:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6dde173384aso4798585a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 20:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1705378262; x=1705983062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CWChxn/etZA7mSQDyr9oFtgmtnkj4VOXoiVZv/wz84A=;
        b=S3/uqofwLHBKs07l+vV+CovnspE1KLCytBwYGJRoDZGiLzVND6UAp923pAYYK1gfo+
         ac+4TWZx2MA5z51oFvkxm1CNA7GbafUMobgYJmBa7c387qlp7kIlOxRMHoXe80mP/AuZ
         PkPu5WA+K+R6sao72nRNbMie6JumBSqbGpX8sH8k6DyGekHKbt6nK10up4ssW6viUZQi
         qiva6S5JWLIsFxuhwhP0K+L57GnLTKgZHBIeyBHpvEDj3IyOMqFnitkCUMP5u/DBxswj
         HqrznQgIKwfEVFWwhy+hFoU7BDDo/hhRWnuVfjFBxeBJAXyiAt2LG5uHaMecuzT7XHwI
         QUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705378262; x=1705983062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CWChxn/etZA7mSQDyr9oFtgmtnkj4VOXoiVZv/wz84A=;
        b=OI+6flxnD74SvDdEn4tISYwZC0HaqMHbE0iyOMrIJFG5Zj8yiuPEoutBsfKiysXzhU
         +R+LPIAemBueUGqDcl+BuJP9MTfydAXe52E9MhR/eThLrawV5j7Sn5ZO/rHE6Au6NrXB
         G6HOigCrVs5eF0Rby/P+BmpypF29ZqIZyPHzDY+nDQa0GdGJZ9u6KrI+Uw1ReeGNeweQ
         /i8uP71kp0MZCXcQ+bYIgYGy+pcshOsCDy04r/qq5A5noctLbEsIziY9ufU6L7hbta+V
         58FnBs2hOu048uNchyBKYZexATvY8ribVGGKgwBscAlCxHXY0kf6c8QRv3w4vXK3gV97
         G2kg==
X-Gm-Message-State: AOJu0Yzk1JpF5cvFD/JeMb/zX6HHQerPs4B2nwYfD3j3tMl5GUC0EsQ3
	VMMq9otZPiKPu/gNuqEGca99w5SJ+0QvUg==
X-Google-Smtp-Source: AGHT+IEfWmKba6ELkIwXAP6st2nVX8PTgS7saJtspXT16S/FqI+k9e3xGVVjwrIlscveCrb7r7KkdQ==
X-Received: by 2002:a05:6808:21a7:b0:3bc:29c2:2b97 with SMTP id be39-20020a05680821a700b003bc29c22b97mr9492923oib.88.1705378262660;
        Mon, 15 Jan 2024 20:11:02 -0800 (PST)
Received: from hsinchu15.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id e3-20020a056a0000c300b006da14f68ac1sm8348585pfj.198.2024.01.15.20.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 20:11:02 -0800 (PST)
From: Nylon Chen <nylon.chen@sifive.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	u.kleine-koenig@pengutronix.de,
	thierry.reding@gmail.com,
	aou@eecs.berkeley.edu
Cc: zong.li@sifve.com,
	vincent.chen@sifive.com,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	nylon7717@gmail.com,
	Nylon Chen <nylon.chen@sifive.com>
Subject: [v6 0/3] Change PWM-controlled LED pin active mode and algorithm
Date: Tue, 16 Jan 2024 12:10:51 +0800
Message-ID: <20240116041054.11641-1-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the circuit diagram of User LEDs - RGB described in the
manual hifive-unleashed-a00.pdf[0] and hifive-unmatched-schematics-v3.pdf[1].

The behavior of PWM is acitve-high.

According to the descriptionof PWM for pwmcmp in SiFive FU740-C000 Manual[2].

The pwm algorithm is (PW) pulse active time  = (D) duty * (T) period.
The `frac` variable is pulse "inactive" time so we need to invert it.

So this patchset removes active-low in DTS and adds reverse logic to the driver.

Updated patches: 1
New patches: 1
Unchanged patches: 1

Links:
- [0]: https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf8453f8698_hifive-unleashed-a00-schematics-1.pdf
- [1]: https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-e68ce76f4192_hifive-unmatched-schematics-v3.pdf
- [2]: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b16acba_fu740-c000-manual-v1p6.pdf

Changed in v6:
 - Separate the idempotent test bug fixes into a new patch.
 - Move the reversing the duty before the line checking
   state->enabled.
 - Fix the algorithm and change it to take the minimum value first and
   then reverse it.

Changed in v5:
 - Add the updates to the PWM algorithm based on version 2 back in.
 - Replace div64_ul with DIV_ROUND_UP_ULL to correct the error in the
   period value of the idempotent test in pwm_apply_state_debug.

Changed in v4:
 - Remove previous updates to the PWM algorithm.

Changed in v3:
 - Convert the reference link to standard link.
 - Move the inverted function before taking the minimum value.
 - Change polarity check condition(high and low).
 - Pick the biggest period length possible that is not bigger than the
   requested period.

Changed in v2:
 - Convert the reference link to standard link.
 - Fix typo: s/sifive unmatched:/sifive: unmatched:/.
 - Remove active-low from hifive-unleashed-a00.dts.
 - Include this reference link in the dts and pwm commit messages.


Nylon Chen (3):
  riscv: dts: sifive: unleashed/unmatched: Remove PWM controlled LED's
    active-low properties
  pwm: sifive: change the PWM controlled LED algorithm
  pwm: sifive: Fix the error in the idempotent test within the
    pwm_apply_state_debug function

 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  8 ++++----
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 12 ++++--------
 drivers/pwm/pwm-sifive.c                            |  9 +++++----
 3 files changed, 13 insertions(+), 16 deletions(-)

-- 
2.42.0



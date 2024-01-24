Return-Path: <linux-kernel+bounces-37648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BA383B30A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 417061C23275
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6446F134759;
	Wed, 24 Jan 2024 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiFgPylT"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0798613474B;
	Wed, 24 Jan 2024 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706128231; cv=none; b=VFaUVBD56dnUYJQwhzXF08uQbX1/Af0LSearp0ijrxEq1eCgQh58GEmnASLWJDtHWpmlujerE/kKGfbB3s+TASKHZOD8FrJp6D39WdINjK0Pio+bQLOPomQ9dxmg30bLnqJbulrPAcqJqIZtSFgtXMyjMlaBrgmAxGnNswhGhjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706128231; c=relaxed/simple;
	bh=Zphw5jSFEs0fQt9R++0K1tpqDhgnJQ1WYKuZaCBTVvU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HP1rveYV/CAbbVrDlmZJzaQ1PrkKrJ+JHZUKbqkqTEAp2fIUzYs1mF8PGKxLik0AOYYznxXiU5PtxNVxjkxK9a9bJgvphwab++A+TckwKgDnU+l23RXnbVKndpusmkWEOIa7w5Isx2lrnyifkG1xwp6OqpxbnGnaUVugOTMdJKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiFgPylT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40eccccfce0so7067265e9.1;
        Wed, 24 Jan 2024 12:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706128228; x=1706733028; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6VI6vBuko+qXcZ57Ez3xJHzWek0A70ejNW+GSI4wbas=;
        b=hiFgPylTBxkOsV3v20WUNj1pzGuxcrLbYiEbnu9kEO6jaWavaog/gswW+bA3M5dsJX
         aByPfKqnldVm7+NZ19dRtuRwT+2suPNPYLAIUDxGipCPRuD48Du6xpReUCxLRBNKWTf3
         2fbrb1/fn+PUIpk55GTCxMWYXZmyXh9BfrMac7a++N6Npq+3/1CDA/Wy2qEF6qHL5SxO
         Hu/zgLrN7h9OGdys0pjN6HiOhD8l287FTjhanXBF+erCJS0JrMKg75WC8aARwIArd46l
         ao/vhrZyguAnhA1vJovNJnMcRO/FIZU9lx28DjpeGa7INoM5/RFEoNmKJ/KMCUXpw2Ou
         huxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706128228; x=1706733028;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6VI6vBuko+qXcZ57Ez3xJHzWek0A70ejNW+GSI4wbas=;
        b=o4k6PTKiNvAobOTh5U33VfW//lz5WV3BwpPO6mq7DziN3Bh8Asm5ZHvw0fMCoL2JTP
         HWQShEZvO8gvqxekmY87a4ydrNx5BN0vB4COb3hwwROqRhIgP6jEv8Rf6apx0hyZClda
         1bnuk+eAyLFI+ys677iWGw4hJiYC7OL5CR2rj+RjZ1EMWh8gy/LO7MMure91PmrYaEiO
         MEoAoboxZ0R7hVQ65zTDQn7ZZIFU15OJpCI2pJ8ZzSPbqBz5RgyRHl46PmkgzOATZZyh
         6adX3MLrpGB9Qf2c3k06n6Mm3wjqTOg5Yxk15do5uTf7H0C+GsIN/nqZdwh8lGjnO9iW
         qjhA==
X-Gm-Message-State: AOJu0Yy76LxQeKmFqXnD9HxebsDncyRTvby6dmV8sS4ZqPxe4ppzrtrm
	bOwlF9RqT0gDQ5bGzBjWuHP3Yyf8RLCFL2zSiSFbxRQI1JFCaoYX
X-Google-Smtp-Source: AGHT+IFyyDsTtkrw64HBFX1IHQsvIYAQH3MtMf9LlLq5GaTxcdXjVtLdyiil/BSAQyvnPaodlfUVWw==
X-Received: by 2002:a1c:7905:0:b0:40e:aee0:125b with SMTP id l5-20020a1c7905000000b0040eaee0125bmr1534637wme.181.1706128227803;
        Wed, 24 Jan 2024 12:30:27 -0800 (PST)
Received: from [172.30.32.188] ([2001:8f8:183b:50fb::d35])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c458f00b0040d62f89381sm174073wmo.35.2024.01.24.12.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 12:30:27 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Subject: [PATCH 0/4] RK3588 and Rock 5B dts additions: thermal, OPP, rfkill
 and fan
Date: Thu, 25 Jan 2024 00:30:03 +0400
Message-Id: <20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEtzsWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQyMT3aJs3ZSSYt3ElJTMEqBaIMssxTzJ1MjcwjzJUgmoraAoNS2zAmx
 kdGxtLQC0LgGSYgAAAA==
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Dragan Simic <dsimic@manjaro.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706128223; l=2476;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=Zphw5jSFEs0fQt9R++0K1tpqDhgnJQ1WYKuZaCBTVvU=;
 b=OXPnsOQ5Iq/W0WZ1F4YtQlFxGEwUcI4fsa3zeywZTfuleBhP1Q23MJwIc0KuetJ9//8ditpY+
 gG16JPhk22uAWhz01j3ISMWisSWRfa07EfXZn7LNtnKOUFyZM7mm0HW
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=xRO8VeD3J5jhwe0za0aHt2LDumQr8cm0Ls7Jz3YGimk=

This is an assortment of device tree additions for RK3588(s) and their
enablement on Radxa Rock5B.

Thermal zone information and cooling maps is the follow-up to feedback
received on v2 patch version [1] - thanks a lot to Dragan, Heiko and
Daniel for review and comments. The patch adds passive cooling maps
for the three separate CPU clusters found in RK3588, as well as
critical trips for all TSADC channels. Enablement on Rock 5B was
split out to a separate patch, where I also add active cooling via
the PWM fan optionally available there. Other changes from v2:
 - Zero hysteresis for critical trips, per Daniel's guidance
 - Zero 'polling-delay' for zones having no active cooling maps,
   given that the driver supports interrupts for crossing trip
   temperature and thus doesn't need polling there, per Daniel's
   guidance
 - Zero 'polling-delay-passive' for zones having no passive cooling,
   per Daniel's guidance
 - Extra passive cooling alerts before the control temperature
   to enable power allocation governor's PID parameters
   initialization, per Daniel's guidance
 - Renamed the thermal zone tracking the middle of the chip
   to package_thermal, per Dragan's guidance

OPPs help actually scale CPU frequencies up and down for both cooling
and performance - tested on Rock 5B under varied loads.

RFKILL patch is the same one sent earlier just before the merge window
opened [2]. It didn't get any feedback back then, so I'm just
resending it here for ease of reference. Tested on Rock 5B with an
Intel AX210 card.

[1] https://lore.kernel.org/linux-rockchip/20240109192608.5981-1-alchark@gmail.com/
[2] https://lore.kernel.org/linux-rockchip/20240106202650.22310-1-alchark@gmail.com/

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
Alexey Charkov (4):
      arm64: dts: rockchip: add rfkill node for M.2 Key E WiFi on rock-5b
      arm64: dts: rockchip: enable built-in thermal monitoring on rk3588
      arm64: dts: rockchip: enable temperature driven fan control on Rock 5B
      arm64: dts: rockchip: Add OPP data for CPU cores on RK3588

 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts |  32 +-
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi       | 374 ++++++++++++++++++++++++
 2 files changed, 405 insertions(+), 1 deletion(-)
---
base-commit: 615d300648869c774bd1fe54b4627bb0c20faed4
change-id: 20240124-rk-dts-additions-a6d7b52787b9

Best regards,
-- 
Alexey Charkov <alchark@gmail.com>



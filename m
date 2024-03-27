Return-Path: <linux-kernel+bounces-122132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B7688F24C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4DA21C2BAC9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F101552E5;
	Wed, 27 Mar 2024 22:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puxN8n8k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADFF1F5E6;
	Wed, 27 Mar 2024 22:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711580238; cv=none; b=HqnWP6O06zuZHSw8eVFLYGIowa64OVYhRiHdpcfobdD93hHMffj+JbwXVjd0+8SAAdThdscwfms0qWEyK48OlPkf4nfceyQDZOFZuprj5aoddg5Evh4rSpGyv/VnwFfKmsryXgMwjhyg0MRdEThEfgJeNvSXQGxhhnutYllSFtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711580238; c=relaxed/simple;
	bh=sQVyeEFBwEdJidDQvMPAc1y+aDkcz+DPIZdUdRxEJ4s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NK9UxVGrAQualqT0Jjq/hbG7mZVL1KCKH8IeCX2t6Tz4yxdYEkLvZ1liKBeMHmPvbFIJ6laf/3u+h0IY78kKd1MFWuFoOjay1eTAIq9q8wgiNfQSZgejpzXEz4cyme6MLugG18BRoOwK90nADN9oFcrgP/KLEu1fPKW0PKalV0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puxN8n8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2ED4CC433C7;
	Wed, 27 Mar 2024 22:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711580238;
	bh=sQVyeEFBwEdJidDQvMPAc1y+aDkcz+DPIZdUdRxEJ4s=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=puxN8n8kPgrnvldg22MK+pHoAxQ5lPDRiyC9wU4EISLTodursiS7mHrRSHbxlFAGn
	 HM3R6CSCNez9vePuVY4zzkSSCaT0q5Ckxi1TSUD2PDDEH4qeVB00j5KVxJuYS3wp6E
	 R1+Pkj/dXDwBuX52PT+PTy+11vDzn1EorfveG9laaOS2YYy6sAM9Kb0NW5YtCKoRzl
	 OvIGXqrqaOZ+/XEd2C02i3nOj/FWFL7FVJmeAMTnFx3WU2RqWcl8exu0eFOB5kTJtw
	 YzGvJuLfF2UmqdC+7MIWV6Qta04nKO68a40nR4ZQT1GrGwmPHZkspt7y1lDxlILhBE
	 jgpcvZdrAyn5A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14342CD11DD;
	Wed, 27 Mar 2024 22:57:18 +0000 (UTC)
From: =?utf-8?q?Andr=C3=A9_Apitzsch_via_B4_Relay?= <devnull+git.apitzsch.eu@kernel.org>
Subject: [PATCH 0/3] Add sy7802 flash led driver
Date: Wed, 27 Mar 2024 23:51:32 +0100
Message-Id: <20240327-sy7802-v1-0-db74ab32faaf@apitzsch.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPSiBGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyNT3eJKcwsDI900E4O0ZLM0UzNTI1MloOKCotS0zAqwQdGxtbUAlYR
 kMVgAAAA=
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <keescook@chromium.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711580236; l=1112;
 i=git@apitzsch.eu; s=20240325; h=from:subject:message-id;
 bh=sQVyeEFBwEdJidDQvMPAc1y+aDkcz+DPIZdUdRxEJ4s=;
 b=YUVsRU80cvty+TKsvnoBkHkPt8VESpOUdQDnZYM4vdcpoIAe8RltJv9jyhEFugMquOEa71yh1
 wZH2k/+n0hUCpU2HCL6Z+QO7KWPEhLAPIw9jJe7Ynq9AhPIbDBPYwdZ
X-Developer-Key: i=git@apitzsch.eu; a=ed25519;
 pk=wxovcZRfvNYBMcTw4QFFtNEP4qv39gnBfnfyImXZxiU=
X-Endpoint-Received: by B4 Relay for git@apitzsch.eu/20240325 with
 auth_id=142
X-Original-From: =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Reply-To: git@apitzsch.eu

This series introduces a driver for the Silergy SY7802 charge pump used
in the BQ Aquaris M5 and X5 smartphones.

The implementation is based on information extracted from downstream as
the datasheet provided by a distributor of the hardware didn't include
any information about the i2c register description.

Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
André Apitzsch (3):
      dt-bindings: leds: Add Silergy SY7802 flash LED
      leds: sy7802: Add support for Silergy SY7802 flash LED controller
      arm64: dts: qcom: msm8939-longcheer-l9100: Add rear flash

 .../devicetree/bindings/leds/silergy,sy7802.yaml   |  96 ++++
 .../boot/dts/qcom/msm8939-longcheer-l9100.dts      |  26 +
 drivers/leds/flash/Kconfig                         |  11 +
 drivers/leds/flash/Makefile                        |   1 +
 drivers/leds/flash/leds-sy7802.c                   | 532 +++++++++++++++++++++
 5 files changed, 666 insertions(+)
---
base-commit: 084c8e315db34b59d38d06e684b1a0dd07d30287
change-id: 20240325-sy7802-f40fc6f56525

Best regards,
-- 
André Apitzsch <git@apitzsch.eu>




Return-Path: <linux-kernel+bounces-68532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A419857BDA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505DB1F260C1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB257866E;
	Fri, 16 Feb 2024 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nE6qel9i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1345A768F4;
	Fri, 16 Feb 2024 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708083475; cv=none; b=Cr2f3WAhDKjZQ5DEBP57fNgoLCl5UT9zX1Tp07apos8o1iccVyjg/VF6JAjDZ00XslrEexj4DDjMkj3eKyq2aqN0ZxyNjG9SOl6/WikN45hwviNVIImoND0vXCZqiOO/CTwc8wS7C/vPRIC7ZWqtBZsqalnkYh73NAGcFcFHJTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708083475; c=relaxed/simple;
	bh=xQgenU1RuH/1sl6zVXoRINQqPjQc+AObioNdVhirHEo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gpw+aQHdpPsdIxzKVvk1czY5ZbW9P9F+8E9zbmsBltVdKutFDh3x+r2ITztYpFlJxA4/yXyVDZtWIDfuLrVhTOxG0r0MrD7RAmDfX8F/XFvnhYfeFQPDey0yqttNUTQS/KeFuyr50fB8ZNdq71uXtNPY/O8GBSpL+MGbI+MRsv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nE6qel9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90B78C433F1;
	Fri, 16 Feb 2024 11:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708083474;
	bh=xQgenU1RuH/1sl6zVXoRINQqPjQc+AObioNdVhirHEo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=nE6qel9igDEND7NN6yL/ahcCE4OXVOXTr7PkE6K3heACD2JUsMY8KL1KtPk4Na0Nn
	 QSGHJsUEc56GYy2cmnFYwjATjTHAJO3aFQX1N2//SWicP6MLQghAbIR4kuidNWBjKo
	 dAXTjjHKfDVNPIEzum69AIWfNVNUqLl6Dvd3x9rFYMLJp5cA7XhA3BR+tJzpJUJQN0
	 OgUDnRXPL71DUyi4PlNJlipZUePYl1/xABXyoZpT1pb4Jd/Nl88zN15OVdpgIRo+fR
	 jSTsHaQkCMTdsLElXvCyeX9bZBEWyFqA9ynOVl/c6GSMicq8tPK9hh1qVnmbNRJuia
	 a0keoFzX2y3BA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7727DC48260;
	Fri, 16 Feb 2024 11:37:54 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH RFC 0/4] clk: hisilicon: add support for Hi3798MV200
Date: Fri, 16 Feb 2024 19:37:50 +0800
Message-Id: <20240216-clk-mv200-v1-0-a29ace29e636@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA5Jz2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDI0Mz3eScbN3cMiMDA93kZIvkxFRjS7PUVAMloPqCotS0zAqwWdFKQW7
 OSrG1tQBqPn+cYAAAAA==
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708083473; l=1516;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=xQgenU1RuH/1sl6zVXoRINQqPjQc+AObioNdVhirHEo=;
 b=97nMuwfwFk2N77rE/E+Z7xVKb7FuduTDlsPB/TDm/akUScmHkujGzAXrn8iw7+wSwLWbtovKE
 od9wqcKgyCICPE5pxHE76StiuaspaYhWRMxG4x5xUGGuKp0E+BzuDy1
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

This SoC is similar to Hi3798CV200 with a few more clocks in CRG module.

Note this driver is still ongoing, many clocks are not registered in the
driver now. Feedback is welcomed, especially from HiSilicon people.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Yang Xiwen (4):
      dt-binding: clock: histb-clock: Add missing common clock and Hi3798MV200 specific clock definition
      clk: hisilicon: add CRG driver for Hi3798MV200 SoC
      dt-binding: clock: merge all hisilicon clock bindings to hisilicon,clock-reset-generator
      dt-binding: clock: hisilicon,clock-reset-controller: add Hi3798MV200 SoC support

 .../devicetree/bindings/clock/hi3660-clock.txt     |  47 ---
 .../devicetree/bindings/clock/hi3670-clock.txt     |  43 ---
 .../devicetree/bindings/clock/hi6220-clock.txt     |  52 ---
 .../devicetree/bindings/clock/hisi-crg.txt         |  50 ---
 .../clock/hisilicon,clock-reset-generator.yaml     | 175 +++++++++
 .../clock/hisilicon,hi3559av100-clock.yaml         |  59 ---
 drivers/clk/hisilicon/Kconfig                      |   8 +
 drivers/clk/hisilicon/Makefile                     |   1 +
 drivers/clk/hisilicon/crg-hi3798mv200.c            | 428 +++++++++++++++++++++
 include/dt-bindings/clock/histb-clock.h            |  21 +
 10 files changed, 633 insertions(+), 251 deletions(-)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240216-clk-mv200-cc8cae396ee0

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>



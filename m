Return-Path: <linux-kernel+bounces-69857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97334858F8E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF241F22CA6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51D47B3C7;
	Sat, 17 Feb 2024 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiDYlexU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2F37A72E;
	Sat, 17 Feb 2024 13:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708174882; cv=none; b=thsOPoms2EcVwOo0l4P0xVJMoA5JCe3n3LWhwcbDi7I/t1xcVMTlaJpMW5ducEzbPp6gi9MfTKnGvA6Cu8DqX/OmIlj0lUNw8KrCK7Y6dY971LK7EgU+WiZDy0lov2yVw9DOot6arepMuG84QmYwpy6IkSeRYNFGD5CuGCaghC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708174882; c=relaxed/simple;
	bh=Zp5MP3tIpNSPxCmAKEOrxtfkCID7BCWlJYIzpEeigsA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u5GjWnvehijvhZDcBRXZvxnShFzZE6gDAPfxQRZhm3AF3RMiyZCaM1HaX/I3wUiZGJoccme1c2rS21St5ADnfmY9uTc3f889nymdoiaMaRY4t0ufMsAqjafh2XCV8AaVp3Fq2tqgX+bDuq4YdeMr/seJ/L6vhkmAjQhCved63D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qiDYlexU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A5B3C433F1;
	Sat, 17 Feb 2024 13:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708174881;
	bh=Zp5MP3tIpNSPxCmAKEOrxtfkCID7BCWlJYIzpEeigsA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=qiDYlexUTzAC9s0/LBJ7uWViBmaZVFnR/cqzZBWa7KPlQHnaNPBxyiTPkBxNCe++r
	 zj4IxiSxyhaWd0dmmn4ETJYFucu+KSg2ABAuf77VAR46RU1BkQJnutzy6UN+Yg/EmE
	 CXswlxLG6Bnb0mUQMJHExFCAJ3jO1zHLySWYP+J/nPbEG8c48POzHJsbveWPRPcL3o
	 A/2fyXKM7rwvAYu6wg05lSRDEkfgjYaGJhjiQPcds8QF9YXjSVNh0uKFEtPjOhEHy+
	 6RhB5QrUB9wjHMPtZHAie6DEZtbt+xXK26IVmw91Wv/5z2qE32vxvaN9HGjlBJ47Bx
	 ei70OE3G/yp5g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE79C48BC4;
	Sat, 17 Feb 2024 13:01:21 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH v4 0/4] mmc: add hi3798mv200 specific extensions of DWMMC
Date: Sat, 17 Feb 2024 21:00:53 +0800
Message-Id: <20240217-b4-mmc-hi3798mv200-v4-0-0fdd9bd48532@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAWu0GUC/4XNTQ6CMBCG4auQrq3pTP/QlfcwLgot0ijUADYaw
 t0tuNFI4vL9knlmJL3rvOvJPhtJ56LvfWhTiE1Gytq0Z0e9TU2QoWCAQAtBm6akted6lzcRGaN
 Gas6crQCxJOnw1rnKPxb0eEpd+34I3XP5EWFe3xyCWuMiUEa1FcoWuZDGqUO4D9cQLtsyNGQGI
 /5HMCEMmFXcKQNW/iL8E9GrCE9IBVIoAVrthP5Gpml6ARFF+alAAQAA
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@linaro.org>, 
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708174876; l=2215;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=Zp5MP3tIpNSPxCmAKEOrxtfkCID7BCWlJYIzpEeigsA=;
 b=oo7aKmDi8ZJR7z7GleltHEw99pIm5AIBwtboaiX8pUPlWmpzM7nCVd1AL9vVEo2E/kwiYjNek
 tD4dZeIIweaAQ3GjEOSAA6WxuFy3xdhnXVUSyQK6t3sAY/7OgNUH0Su
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

it's modified from hi3798cv200 driver, but quite a lot of code gets
rewritten because of the hardware differences. Actually cv200 DWMMC core
is called HIMCIV200 while mv200 DWMMC core is called HIMCIV300 in
downstream.

Pending on:
[PATCH] mmc: host: replace 1st argument to struct device * for mmc_of_parse_clk_phase():
	https://lore.kernel.org/all/20240215-mmc_phase-v1-1-f27644ee13e4@outlook.com/

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v4:
- rename dw_mmc-hi3798 back to hi3798cv200 - Suggested by Krzysztof Kozlowski.
- add r-bs to patch 1 and 2 - Reviewed by Krzysztof Kozlowski.
- Link to v3: https://lore.kernel.org/r/20240217-b4-mmc-hi3798mv200-v3-0-f15464176947@outlook.com

Changes in v3:
- dw_mmc-hi3798: fix bot error (Rob Herring)
- Link to v2: https://lore.kernel.org/r/20240216-b4-mmc-hi3798mv200-v2-0-010d63e6a1d5@outlook.com

Changes in v2:
- dw_mmc-hi3798mv200: use dev_err_probe() helper - Suggested by Krzysztof Kozlowski.
- dw_mmc-hi3798mv200: add missing err=0;
- dw_mmc-hi3798c(m)v200: remove unused MODULE_ALIAS() - Suggested by Krzysztof Kozlowski.
- binding: rename the binding, a lot of tweaks suggested by Krzysztof Kozlowski.
- Link to v1: https://lore.kernel.org/r/20240216-b4-mmc-hi3798mv200-v1-0-7d46db845ae6@outlook.com

---
Yang Xiwen (4):
      mmc: dw_mmc-hi3798cv200: remove MODULE_ALIAS()
      mmc: dw_mmc: add support for hi3798mv200
      dt-bindings: mmc: dw-mshc-hi3798cv200: convert to YAML
      dt-bindings: mmc: hisilicon,hi3798cv200-dw-mshc: rename to hisilicon,hi3798-dw-mshc

 .../bindings/mmc/hi3798cv200-dw-mshc.txt           |  40 ----
 .../mmc/hisilicon,hi3798cv200-dw-mshc.yaml         |  94 +++++++++
 drivers/mmc/host/Kconfig                           |   9 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/dw_mmc-hi3798cv200.c              |   1 -
 drivers/mmc/host/dw_mmc-hi3798mv200.c              | 235 +++++++++++++++++++++
 6 files changed, 339 insertions(+), 41 deletions(-)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240121-b4-mmc-hi3798mv200-a5730edf122c

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>



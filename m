Return-Path: <linux-kernel+bounces-68456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CAA857A77
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2A011F23702
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5530D537E9;
	Fri, 16 Feb 2024 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPzBMoqw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764595024B;
	Fri, 16 Feb 2024 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708079897; cv=none; b=Nay488cUUdlDALR9NVDSDwK4tWWihLPs2lcoWHS0OhuHU9vcj2+EXgUCFBqEAyTYvblCP6TFpI4W56ujR72my2/1vmLhVBQUzlhT6TCYP7HEoz1ZOPqSGWoG7SVMK2brJ8hl8GUSnOo9RmL7ybJJdG7G5SviaJufdx4vrCkG1Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708079897; c=relaxed/simple;
	bh=9w2bI+hdTEUkHwmJZgqnNrTm3dF8JO/74q7G3Kshnzg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ayuCIDlZO2jtlAQobO+xgV9c0C8GHmZh08WoeAsF0yDG/VStXm5LulLbpNDO59TketrHZoepdwhitoRzBhZDlOCaw7RL6Qg4kwVth1kb7jnRDiM2qYL5aZ1UFAMRPUPACIucBgYNZcj+CkGgV1W/LiBPZvUUx/NvnDIeboJHKfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPzBMoqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB2EAC43390;
	Fri, 16 Feb 2024 10:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708079897;
	bh=9w2bI+hdTEUkHwmJZgqnNrTm3dF8JO/74q7G3Kshnzg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=bPzBMoqw+0+RGoWMMXGH+sZy9gF86vpad0FvBYFg40+uCw7fQZqLZxxigctYBc2MB
	 kD5WGbnx4gXWsTdC72CYWhiPsmgD02mwxvwwh5K55VrTdVCDtMvAYaWW43KRC9grej
	 KloAmA/tIWzQvGa3YXo+FKVXr9avBeYbOHQFc1/9Yv8ihUCiT3Xnk7KQ+1A+9Ec2gN
	 sgxzFRY8GGBN+MVQbvqB2NCBh7+udQsEzudNYEMBH3EecPFlvdDKx+wHkIKvVZ5zRN
	 HPU8FU0BSGTZv/s2I5eFMAqNtIGSMGP5r+A2hbR4Ekf5SUn3wsCcTXUg3RbuScEUxp
	 rBj+26qoDAnsw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7984C48260;
	Fri, 16 Feb 2024 10:38:16 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH v2 0/4] mmc: add hi3798mv200 specific extensions of DWMMC
Date: Fri, 16 Feb 2024 18:37:58 +0800
Message-Id: <20240216-b4-mmc-hi3798mv200-v2-0-010d63e6a1d5@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAY7z2UC/22Nyw6CMBBFf8XM2jHtUB668j8MC2iLTLTUtNhoC
 P9uxa3Lc5J77gLRBrYRTrsFgk0c2U8ZaL8DPXbT1SKbzECClJAksVfonMaRi/rYuERCYFfWhbB
 mkEQa8vAR7MCvLXppM48cZx/e20eSX/vLkaz+5ZJEgbVRlekbVXa2OvvnfPf+dtDeQbuu6wel1
 ClqtgAAAA==
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@linaro.org>, 
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708079892; l=1790;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=9w2bI+hdTEUkHwmJZgqnNrTm3dF8JO/74q7G3Kshnzg=;
 b=GVrFnTkcI2ByMKXvsctj030QF9pOAZcH1VUk/BLXeBrS/jKXbM2IJzv8YHTt6Q+PNh5oH4MYT
 zh4EJIa0HHBCk5BmMP1L1yDacgy6TQK6dnyRUkiswHr5UAdADAao5i5
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
 .../bindings/mmc/hisilicon,hi3798-dw-mshc.yaml     |  92 ++++++++
 drivers/mmc/host/Kconfig                           |   9 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/dw_mmc-hi3798cv200.c              |   1 -
 drivers/mmc/host/dw_mmc-hi3798mv200.c              | 235 +++++++++++++++++++++
 6 files changed, 337 insertions(+), 41 deletions(-)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240121-b4-mmc-hi3798mv200-a5730edf122c

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>



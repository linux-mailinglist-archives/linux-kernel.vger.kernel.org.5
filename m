Return-Path: <linux-kernel+bounces-25404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F1182CFD1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 06:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E09A5B21CAC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 05:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854A11852;
	Sun, 14 Jan 2024 05:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AN8QShjQ"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404E87E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 05:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a26fa294e56so796331766b.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 21:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705209968; x=1705814768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TpE1NVzdyPA0spfsjRgU83ibssIx5B/4cCpoCd3mwSo=;
        b=AN8QShjQgGjube4/eiKK3X8iaKhSrk+EzuwitwVwU8aJ7oYdscIupoE3iBIj11W+RG
         wzKayDK+NRt9LNQLi5VnuEDjeyfH4r80uFVQMgxPebXTJRdtooLecyCqhP7Qlm3NN0DV
         LmzJag1tRXJ+tf6/tGL3rNbCgwU24fRjsze81QzAMuxazKlsXG/wgSyxNI1SSFR/trf6
         pGt4ryEYAN3dNX1QznkbSvFkrr42rmvx/oPIM6gR8AOQn45M0o9KznrdvuyqJ3OdGoYi
         c23Z5CQnAScBYDmMkT4VHzPJf46P5leCi1rl/aXgQbPzNfBZ6e8r1YjyhCf6tqZ/ExQW
         vztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705209968; x=1705814768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TpE1NVzdyPA0spfsjRgU83ibssIx5B/4cCpoCd3mwSo=;
        b=B/8PUd6iau+OZgc4rtjDLoPaScxZkdcQjUQvkjImdFzkd84WXNGydRDvdU9r6OUh2L
         z/ksL/e/2sOtRNpbVVaNmAWDfP22HVDFtCwIbTrU28EhG5meRcgmuuM0p35BwMyvl7ul
         oiWbMuh8+6/GBz0+5JPmiRpy7fFtAxOMXzVqS1vsbg3QdcSZiaUUdjGj+IBmBmxz51Vu
         mWGkVTi7FifyfytKRe3fIO7lxTQ6j1+lpGjxdkCQ/1IeGgox0ijY2MzyR6Q1aWpL5RqT
         um4Yb9vKWSeV1EHmMXsgEKPZ5c9yYZ3HJG4OerUTFCpKpDds/WIBDfeBPbGI6bmOydWf
         s6rA==
X-Gm-Message-State: AOJu0YxazNLNE9SKgu9J2LuHrfpbAwNvehx4K27nbDW1tD67/OHXN97f
	ECzjdw3bVAbXxRjifTRcoVcKni/KXRz/eoWi8pO6lH4XSwA=
X-Google-Smtp-Source: AGHT+IGnSzDmqYH9Ez2JzEhhW/pxEtLuWhRtuF2EPADK6g9bJOtwNGGld3t7qmdSbg3+jrCGSbQ2AdfJAyP8yrN11UA=
X-Received: by 2002:a17:906:30d9:b0:a28:526c:a3e6 with SMTP id
 b25-20020a17090630d900b00a28526ca3e6mr1532111ejb.152.1705209968272; Sat, 13
 Jan 2024 21:26:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sat, 13 Jan 2024 23:25:56 -0600
Message-ID: <CABb+yY0AC-_0xfYf3veAkY5X_+=daYZEc4_wnKZ+fUpX82BCZg@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v6.8
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 610a9b8f49fbcf1100716370d3b5f6f884a2835a=
:

  Linux 6.7-rc8 (2023-12-31 12:51:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git
tags/mailbox-v6.8

for you to fetch changes up to cd795fb0c352c1f70e5fa437b01572c8693e1b77:

  mailbox: mtk-cmdq: Add CMDQ driver support for mt8188 (2024-01-13
23:08:51 -0600)

----------------------------------------------------------------
mediatek: add CMDQ support for mt8188
mhuv2: fix channel window status
qcom: document X1E80100 IPC controller
  misc cleanup
xlnx: add Versal bindings
misc: Convert to platform remove callback returning void

----------------------------------------------------------------
Abel Vesa (1):
      dt-bindings: mailbox: qcom-ipcc: document the X1E80100
Inter-Processor Communication Controller

Jason-JH.Lin (3):
      mailbox: mtk-cmdq: Rename gce_plat variable with SoC name postfix
      mailbox: mtk-cmdq: Sort cmdq platform data by compatible name
      mailbox: mtk-cmdq: Add CMDQ driver support for mt8188

Krzysztof Kozlowski (3):
      dt-bindings: mailbox: qcom,apcs-kpss-global: drop duplicated
qcom,ipq8074-apcs-apps-global
      dt-bindings: mailbox: qcom,apcs-kpss-global: use fallbacks
      mailbox: qcom-apcs-ipc: re-organize compatibles with fallbacks

Randy Dunlap (1):
      mailbox: zynqmp-ipi: fix an Excess struct member kernel-doc warning

Tanmay Shah (2):
      dt-bindings: mailbox: zynqmp: extend required list
      dt-bindings: mailbox: add Versal IPI bindings

Uwe Kleine-K=C3=B6nig (12):
      mailbox: bcm-flexrm: Convert to platform remove callback returning vo=
id
      mailbox: bcm-pdc: Convert to platform remove callback returning void
      mailbox: imx: Convert to platform remove callback returning void
      mailbox: mailbox-test: Convert to platform remove callback returning =
void
      mailbox: mtk-cmdq: Convert to platform remove callback returning void
      mailbox: omap: Convert to platform remove callback returning void
      mailbox: qcom-apcs-ipc: Convert to platform remove callback returning=
 void
      mailbox: qcom-ipcc: Convert to platform remove callback returning voi=
d
      mailbox: stm32-ipcc: Convert to platform remove callback returning vo=
id
      mailbox: sun6i-msgbox: Convert to platform remove callback returning =
void
      mailbox: tegra-hsp: Convert to platform remove callback returning voi=
d
      mailbox: zynqmp-ipi: Convert to platform remove callback returning vo=
id

Xiaowu.ding (1):
      mailbox: arm_mhuv2: Fix a bug for mhuv2_sender_interrupt

 .../bindings/mailbox/qcom,apcs-kpss-global.yaml    |  62 +++++++---
 .../devicetree/bindings/mailbox/qcom-ipcc.yaml     |   1 +
 .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml  | 132 +++++++++++++++++=
++--
 drivers/mailbox/arm_mhuv2.c                        |   3 +-
 drivers/mailbox/bcm-flexrm-mailbox.c               |   6 +-
 drivers/mailbox/bcm-pdc-mailbox.c                  |   5 +-
 drivers/mailbox/imx-mailbox.c                      |   6 +-
 drivers/mailbox/mailbox-test.c                     |   6 +-
 drivers/mailbox/mtk-cmdq-mailbox.c                 |  49 ++++----
 drivers/mailbox/omap-mailbox.c                     |   6 +-
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            |  16 ++-
 drivers/mailbox/qcom-ipcc.c                        |   6 +-
 drivers/mailbox/stm32-ipcc.c                       |   6 +-
 drivers/mailbox/sun6i-msgbox.c                     |   6 +-
 drivers/mailbox/tegra-hsp.c                        |   6 +-
 drivers/mailbox/zynqmp-ipi-mailbox.c               |   7 +-
 16 files changed, 220 insertions(+), 103 deletions(-)


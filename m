Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE717DD7E0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 22:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344806AbjJaVsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 17:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJaVsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 17:48:13 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A258E4;
        Tue, 31 Oct 2023 14:48:10 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6d319933f9fso53396a34.2;
        Tue, 31 Oct 2023 14:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698788889; x=1699393689;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvA5jz1SY2yUj/xmQkBX3wSkbpuFj33iQKbU7myJsx0=;
        b=W6Tq6hd8ZwOEXkCdr32k+AKCM+m3ZT8Ivcu/TTSIt4DGzuShse81NzidMGXpZi0YAs
         QUb42OfSE91YmyErquKdMzWw6ktmEg94k8IuFdDx80Ii87TUEKA6AlMH4Pc+xPrDgpFl
         2wyMbCB2OH/SaTCOlg+eCY5SiT/3+ToU/uQUrUGYElwPBYJrHK1El6zpl4ImxI7kWiKq
         S6LO93R8G/0zm5QZUia7abjedUj0hOdvtKZFkIRoftZqlUbVZwYxPWz/vqGksozqrhIV
         ca+IIhWY/A8kXxntbnQIiTzxtv0ivrXOogAJbU6mrdsPOLlUB18V9OafBw9fgyi7z34/
         Oefw==
X-Gm-Message-State: AOJu0YwdxJExYKnNy6hXpqVssNHmmHnRD+0AoBTB0Z6L5TBw4AYK57rf
        uCc1tsHLjFBASq26chk3R2P/jQCjrw==
X-Google-Smtp-Source: AGHT+IGgzJtDF/8nKZ8tgnktIFscURFPxpwSUwj7pp0nKY4N0sWLr704HBXZoTw5BeHtPIKcY416wg==
X-Received: by 2002:a05:6830:2707:b0:6c4:cdce:5de8 with SMTP id j7-20020a056830270700b006c4cdce5de8mr14733384otu.26.1698788889580;
        Tue, 31 Oct 2023 14:48:09 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id be14-20020a056830350e00b006ce32aac3e4sm26617otb.48.2023.10.31.14.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 14:48:08 -0700 (PDT)
Received: (nullmailer pid 2184979 invoked by uid 1000);
        Tue, 31 Oct 2023 21:48:08 -0000
Date:   Tue, 31 Oct 2023 16:48:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree updates for v6.7
Message-ID: <20231031214808.GA2178025-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull. Nothing scary here. ;)

There's one conflict with the USB tree. The correct resolution is in 
linux-next.

Rob


The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.7

for you to fetch changes up to fe612629746cf5cc7040529f780d46929605d0a6:

  dt-bindings: soc: fsl: cpm_qe: cpm1-scc-qmc: Add support for QMC HDLC (2023-10-30 16:28:19 -0500)

----------------------------------------------------------------
Devicetree updates for 6.7:

- Add a kselftest to check for unprobed DT devices

- Fix address translation for some 3 address cells cases

- Refactor firmware node refcounting for AMBA bus

- Add bindings for qcom,sm4450-pdc, Qualcomm Kryo 465 CPU, and Freescale
  QMC HDLC

- Add Marantec vendor prefix

- Convert qcom,pm8921-keypad, cnxt,cx92755-wdt, da9062-wdt,
  and atmel,at91rm9200-wdt bindings to DT schema

- Several additionalProperties/unevaluatedProperties on child node
  schemas fixes

- Drop reserved-memory bindings which now live in dtschema project

- Fix a reference to rockchip,inno-usb2phy.yaml

- Remove backlight nodes from display panel examples

- Expand example for using DT_SCHEMA_FILES

- Merge simple LVDS panel bindings to one binding doc

----------------------------------------------------------------
Alexander Stein (1):
      dt-bindings: timer: fsl,imxgpt: Add optional osc_per clock

Andy Shevchenko (1):
      amba: bus: balance firmware node reference counting

Christoph Niedermaier (1):
      dt-bindings: Add Marantec vendor prefix

David Wronek (1):
      dt-bindings: arm: cpus: Add Qualcomm Kryo 465

Dmitry Baryshkov (1):
      dt-bindings: input: qcom,pm8921-keypad: convert to YAML format

Fabio Estevam (1):
      dt-bindings: watchdog: fsl,scu-wdt: Document imx8dl

Geert Uytterhoeven (1):
      of: overlay: unittest: overlay_bad_unresolved: Spelling s/ok/okay/

Herve Codina (6):
      of: address: Fix address translation when address-size is greater than 2
      of: address: Remove duplicated functions
      of: unittest: Add tests for address translations
      dt-bindings: soc: fsl: cpm_qe: cpm1-scc-qmc: Fix example property name
      dt-bindings: soc: fsl: cpm_qe: cpm1-scc-qmc: Add 'additionalProperties: false' in child nodes
      dt-bindings: soc: fsl: cpm_qe: cpm1-scc-qmc: Add support for QMC HDLC

Hugo Villeneuve (1):
      dt-bindings: writing-schema: add example for multiple DT_SCHEMA_FILES

Johan Jonker (1):
      dt-bindings: usb: rockchip,dwc3: update inno usb2 phy binding name

Liu Ying (1):
      dt-bindings: display: panel: one file of all simple LVDS panels with dual ports

Luca Ceresoli (1):
      dt-bindings: display: remove backlight node from panel examples

Nik Bune (3):
      dt-bindings: watchdog: atmel,at91rm9200-wdt: convert txt to yaml
      dt-bindings: watchdog: da9062-wdt: convert txt to yaml
      dt-bindings: watchdog: cnxt,cx92755-wdt: convert txt to yaml

Nícolas F. R. A. Prado (3):
      dt: dt-extract-compatibles: Handle cfile arguments in generator function
      dt: dt-extract-compatibles: Add flag for driver matching compatibles
      kselftest: Add new test for detecting unprobed Devicetree devices

Rob Herring (10):
      dt-bindings: arm,psci: Add missing unevaluatedProperties on child node schemas
      dt-bindings: usb: ti,tps6598x: Disallow undefined properties
      dt-bindings: Drop kernel copy of common reserved-memory bindings
      of: address: Store number of bus flag cells rather than bool
      of: address: Consolidate bus .map() functions
      media: dt-bindings: ti,ds90ub960: Add missing type for "i2c-alias"
      dt-bindings: input: syna,rmi4: Make "additionalProperties: true" explicit
      dt-bindings: soundwire: Add reference to soundwire-controller.yaml schema
      dt-bindings: arm,coresight-cti: Drop type for 'cpu' property
      dt-bindings: arm,coresight-cti: Add missing additionalProperties on child nodes

Tengfei Fan (1):
      dt-bindings: interrupt-controller: qcom,pdc: document qcom,sm4450-pdc

 Documentation/devicetree/bindings/Makefile         |   2 +-
 .../devicetree/bindings/arm/arm,coresight-cti.yaml |  34 ++--
 Documentation/devicetree/bindings/arm/cpus.yaml    |   1 +
 Documentation/devicetree/bindings/arm/psci.yaml    |   1 +
 .../bindings/display/ilitek,ili9486.yaml           |   4 -
 .../bindings/display/panel/ilitek,ili9163.yaml     |   4 -
 .../panel/panel-simple-lvds-dual-ports.yaml        | 118 ++++++++++++++
 .../bindings/display/panel/panel-simple.yaml       |  10 --
 .../bindings/display/sitronix,st7735r.yaml         |   5 -
 .../bindings/input/qcom,pm8921-keypad.yaml         |  89 ++++++++++
 .../bindings/input/qcom,pm8xxx-keypad.txt          |  90 ----------
 .../devicetree/bindings/input/syna,rmi4.yaml       |   2 +
 .../bindings/interrupt-controller/qcom,pdc.yaml    |   1 +
 .../bindings/media/i2c/ti,ds90ub960.yaml           |   1 +
 .../bindings/remoteproc/renesas,rcar-rproc.yaml    |   2 +-
 .../bindings/reserved-memory/framebuffer.yaml      |  52 ------
 .../bindings/reserved-memory/memory-region.yaml    |  40 -----
 .../bindings/reserved-memory/reserved-memory.txt   |   2 +-
 .../bindings/reserved-memory/reserved-memory.yaml  | 181 ---------------------
 .../bindings/reserved-memory/shared-dma-pool.yaml  |  97 -----------
 .../bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml  |  37 ++++-
 .../bindings/sound/mediatek,mt8188-afe.yaml        |   2 +-
 .../bindings/soundwire/qcom,soundwire.yaml         |  16 +-
 .../devicetree/bindings/timer/fsl,imxgpt.yaml      |  27 +++
 .../devicetree/bindings/usb/rockchip,dwc3.yaml     |   2 +-
 .../devicetree/bindings/usb/ti,tps6598x.yaml       |   5 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 .../bindings/watchdog/atmel,at91rm9200-wdt.yaml    |  33 ++++
 .../bindings/watchdog/atmel-at91rm9200-wdt.txt     |   9 -
 .../bindings/watchdog/cnxt,cx92755-wdt.yaml        |  45 +++++
 .../devicetree/bindings/watchdog/da9062-wdt.txt    |  34 ----
 .../devicetree/bindings/watchdog/digicolor-wdt.txt |  25 ---
 .../bindings/watchdog/dlg,da9062-watchdog.yaml     |  50 ++++++
 .../devicetree/bindings/watchdog/fsl,scu-wdt.yaml  |   4 +-
 .../devicetree/bindings/writing-schema.rst         |   5 +-
 MAINTAINERS                                        |   1 +
 drivers/acpi/arm64/amba.c                          |   2 +-
 drivers/amba/bus.c                                 |   5 +-
 drivers/of/address.c                               |  85 ++++------
 drivers/of/platform.c                              |   2 +-
 .../of/unittest-data/overlay_bad_unresolved.dtso   |   2 +-
 drivers/of/unittest-data/tests-address.dtsi        | 101 ++++++++++++
 drivers/of/unittest.c                              |  77 +++++++++
 scripts/dtc/dt-extract-compatibles                 |  74 +++++++--
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/dt/.gitignore              |   1 +
 tools/testing/selftests/dt/Makefile                |  21 +++
 tools/testing/selftests/dt/compatible_ignore_list  |   1 +
 tools/testing/selftests/dt/ktap_helpers.sh         |  70 ++++++++
 .../testing/selftests/dt/test_unprobed_devices.sh  |  83 ++++++++++
 50 files changed, 902 insertions(+), 656 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml
 create mode 100644 Documentation/devicetree/bindings/input/qcom,pm8921-keypad.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
 delete mode 100644 Documentation/devicetree/bindings/reserved-memory/framebuffer.yaml
 delete mode 100644 Documentation/devicetree/bindings/reserved-memory/memory-region.yaml
 delete mode 100644 Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
 delete mode 100644 Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/cnxt,cx92755-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
 delete mode 100644 Documentation/devicetree/bindings/watchdog/digicolor-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml
 create mode 100644 tools/testing/selftests/dt/.gitignore
 create mode 100644 tools/testing/selftests/dt/Makefile
 create mode 100644 tools/testing/selftests/dt/compatible_ignore_list
 create mode 100644 tools/testing/selftests/dt/ktap_helpers.sh
 create mode 100755 tools/testing/selftests/dt/test_unprobed_devices.sh

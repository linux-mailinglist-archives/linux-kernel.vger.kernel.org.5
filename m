Return-Path: <linux-kernel+bounces-8637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1055F81BA7A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352141C24291
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192AD539E9;
	Thu, 21 Dec 2023 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WeWOwona"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE0A49F66
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d3cfb1568eso7980485ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 07:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703172094; x=1703776894; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p1ibgzicqbTcN+y+liz8Y1ihcqL+Qtrs8u5A28Unpyo=;
        b=WeWOwonarbcpVaWbNSx8Jksf+tLQ2w8O1DFwm9SWMn4fLMRqDoBhHdXYX4T1zvAPMI
         wSUI1MgSRFz8CqERn4SIuaC750KKNAjO0MWp+LFseFduY+/6Lndl5LS2a9nC5bX3CL75
         JdnrGOzn/zTIOHs6zIWRd7QONcBr7ZSRWHpE3eNM3Z8On1APO7ArsOUqOROkxIDvGHc3
         5h47thnbRkvlAtY+zgqef+fQqcWSonO39mDz07RQfpZZO82kfATSPs4CviHH+9V7+bzd
         7kuD3ft0wxES1VJEiw+wI5mOHvu4fWh3wcpM2CACeixOEh+Pc1/4svwuvS97haEgEf3T
         li8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703172094; x=1703776894;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p1ibgzicqbTcN+y+liz8Y1ihcqL+Qtrs8u5A28Unpyo=;
        b=JiEBvEZ0l/naUj29HksfmO4WTc+CkYPP0ndJxo6dG+gNzoTRqKvCrEQgcB23jCh2Qv
         7Cezw9Ju7f7ppioSTUnkYVsXS0th4nzs8tyPqKbSz4DcWkBArIcIC6/X4REj75sVHkpH
         n8ksw8pvtrLO4mNVUg4895OTnu29Uea3YRoVu/BAWVuEHgz+DUXnyrBSKhPchRO7P8Nx
         WA6kH0oWjz4TmqOCiLQXQA0xkRToKsUz+QLDdSWAz4DE7opvsQdx+5xpUdjmJzbLUvad
         QTlE8ZzfRLznQbT5CyOOmVqJydPqBe49TvXhBX9rhGA1xdqAXcXSgHVxYenMYKawHQey
         9KAQ==
X-Gm-Message-State: AOJu0YwNogjr5teib7vO+5OOCp1rFS/tZjOZVvWCPrbVVmoxL3UeKyIT
	QoiI1sJY0i0RTT8Olp9g4nY2bw==
X-Google-Smtp-Source: AGHT+IHWjWx0FboKQHFaw4mZl5/dZOZWNwlvi6cEALoU6ae9uGyvATtJr6Fu8yDyoZkXHAkSLBwOjQ==
X-Received: by 2002:a17:902:f686:b0:1d3:be14:372a with SMTP id l6-20020a170902f68600b001d3be14372amr8164759plg.60.1703172094392;
        Thu, 21 Dec 2023 07:21:34 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id z3-20020a170902ee0300b001d3561680aasm1756217plb.82.2023.12.21.07.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 07:21:33 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v14 0/4] Input: add initial support for Goodix Berlin
 touchscreen IC
Date: Thu, 21 Dec 2023 16:21:18 +0100
Message-Id: <20231221-topic-goodix-berlin-upstream-initial-v14-0-04459853b640@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO5XhGUC/53TwY7bIBAG4FdZ+VyqGQwGeup7VD0MeEiQUjvC2
 WhXq7z7jvfQpOJCc2RkfYxn+D+GjWvhbfjx8jFUvpatrIsc0Hx7GdKRlgOrMkth0KBHmGBSl/V
 ckjqs61zeVOR6Kot6PW+XyvRHlaVcCp1UpODYc/LZpEGoSBurWGlJR8GW19NJiufKubx9Xf7rt
 5yPZbus9f2rlyvu1f+89YoKlCFwBqMnzvNP+Yzq+n2th2G/4aqfUbWoeoryM4wcgBt1fEYdRc1
 gnUtMs4PQqOYZ1YgKwbhkfIiMrlHtXfWAnardVRe01WG0NoyNOt3VgLpTnUSNhlMmE3IM7bbcX
 xUBelUnqrQqIGbL3jeqf1THTtWLig5lEQia56lRw4Oqe+cadnXMMgTvHdpWRXhke5tF2Zbynjl
 ptpggtu49Xoj98drzZZNxHBy4BO07wHvAUEPodfeEMeVMHK2Mw7bu+OBi9xz2jNnZkZ7IMpH+x
 73dbp9jsjDL/wQAAA==
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 linux-input@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bastien Nocera <hadess@hadess.net>, 
 Hans de Goede <hdegoede@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>, 
 Jeff LaBundy <jeff@labundy.com>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=6716;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=lhHzN99w+w4nTL5IPWaxQaPYSZkQloAq8K14Bp98iK8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlhFf18f+Y3AIxzz90sAojSyGovU6jGje5GaCqM0Fu
 7IxrOUCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZYRX9QAKCRB33NvayMhJ0SkKD/
 9Bk2lK9aS0XgtZa/6bmIeRYsXbnCp8W6+o8Xp8Sv09euhWjl1QPkcWJJK3zdrwj6zu/EqGgz90UIIY
 Y79zZcCAnLkaykOa67W6AaFrCZBxQ0fqM4j0z0gfEBxXSUPsGR0Mzvt5OI8DfVKAd424e7wgaHtxd6
 +bXMLzXaGlKUOGeaG4vOCTqUv8E6nbXBvdfmIRgVXLSWROLhoGAVmlIpPQBsiIHQK/yOkP2EZg2IvA
 DJZdbHsuZrjLg+HFu+azE0jxjtCB3J3ackPVqQwbFA8D77vIwdSqlkRQifULgJtZekvwOzYqaw1Thd
 fFjAgSNANH7D9aTTycQI/lBTt9hspsoN0wU4ANDhI+V7EBLZLtMM1/zqCE7u2W69Cg0IwvY2JE2FhM
 pds7j0oZf0/xfiX+0mdAHa7xoeCsfCf9mHzMZ/Whln5Si3Xx0tHNN+IV0f5nwbGEATO6/lsgCjvOQY
 7pSqgBjbYKGN+5etcYi1wAIYBEN4Hb7Hr5YYB2yzOccEmI4cAuCMJcXc2nNeMTKomkZ9k59pKsw3Az
 kEuuggwaejiqzDpTVZLaJSztdb5LxFO54/uH0UlKL9EPG9dNbJ+uL0mx+6OeL6NwXRIDPon+rdnUrt
 m8E/0PH2lROO7w5QS9CrNtYfFjWZfK8Tv9FGIG+DUs7N4yMUudGH0vA0Krew==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

These touchscreen ICs support SPI, I2C and I3C interface, up to
10 finger touch, stylus and gestures events.

This initial driver is derived from the Goodix goodix_ts_berlin
available at [1] and [2] and only supports the GT9916 IC
present on the Qualcomm SM8550/SM8650 MTP & QRD touch panel.

The current implementation only supports BerlinD, aka GT9916.

Support for advanced features like:
- Firmware & config update
- Stylus events
- Gestures events
- Previous revisions support (BerlinA or BerlinB)
is not included in current version.

The current support will work with currently flashed firmware
and config, and bail out if firmware or config aren't flashed yet.

[1] https://github.com/goodix/goodix_ts_berlin
[2] https://git.codelinaro.org/clo/la/platform/vendor/opensource/touch-drivers

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v14:
- Rebased on next-20231221
- Fixed build on SPI/I2S drivers missing <linux/input.h> include
- Link to v13: https://lore.kernel.org/r/20231213-topic-goodix-berlin-upstream-initial-v13-0-5d7a26a5eaa2@linaro.org

Changes in v13:
- Thanks to Dmitry's suggestion:
  - Move core defines and structs into goodix_berlin_core.c
  - Comments typos and rephrasings
  - Identation fixes
  - Refactor of goodix_berlin_power_on
  - goodix_berlin_get_ic_info move to __free(kfree) to avoid leaking
- Added comment explaining how data is retrieved in irq handler
- Link to v12: https://lore.kernel.org/r/20231209-topic-goodix-berlin-upstream-initial-v12-0-eaffaeb53fb5@linaro.org

Changes in v12:
- Rebased on next-20231208
- Link to v11: https://lore.kernel.org/r/20231106-topic-goodix-berlin-upstream-initial-v11-0-5c47e9707c03@linaro.org

Changes in v11:
- Fixes according to Jeff's review:
 - s/dev_info/dev_err/ in goodix_berlin_get_ic_info()
 - remove spurious return instead of goto in goodix_berlin_get_ic_info()
 - added back dropped msleep() in goodix_berlin_request_handle_reset()
- Link to v10: https://lore.kernel.org/r/20231023-topic-goodix-berlin-upstream-initial-v10-0-88eec2e51c0b@linaro.org

Changes in v10:
- Fix according to Dmitry's review:
 - move goodix_berlin_get_ic_info() afe_data to heap
 - merge the goodix_berlin_parse_finger() loops and skip invalid fingers instead of returning
 - remove unwanted goodix_berlin_touch_handler() "static" for buffer
 - only call goodix_berlin_request_handle_reset() if gpio was provided
 - use "error = func(); if(error) return error;" instead of "return func()" when function handles multiple error cases
- Link to v9: https://lore.kernel.org/r/20231021-topic-goodix-berlin-upstream-initial-v9-0-13fb4e887156@linaro.org

Changes in v9:
- Rebased on next-20231020 
- Link to v8: https://lore.kernel.org/r/20231003-topic-goodix-berlin-upstream-initial-v8-0-171606102ed6@linaro.org

Changes in v8:
- Add missing bitfield.h include in core
- Link to v7: https://lore.kernel.org/r/20231002-topic-goodix-berlin-upstream-initial-v7-0-792fb91f5e88@linaro.org

Changes in v7:
- rebased on v6.6-rc3
- Link to v6: https://lore.kernel.org/r/20230912-topic-goodix-berlin-upstream-initial-v6-0-b4ecfa49fb9d@linaro.org

Changes in v6:
- rebased on v6.6-rc1
- changed commit message prefix to match the other Input commits
- Link to v5: https://lore.kernel.org/r/20230801-topic-goodix-berlin-upstream-initial-v5-0-079252935593@linaro.org

Changes in v5:
- rebased on next-20230801
- Link to v4: https://lore.kernel.org/r/20230606-topic-goodix-berlin-upstream-initial-v4-0-0947c489be17@linaro.org

Changes in v4:
- Core updates:
 - drop kconfig depends, deps will be handled by _SPI and _I2C
 - change power_on() error labels
 - print errors on all dev_err() prints
 - remove useless default variable initialization
 - switch irq touch checksum error to dev_err()
 - add Jeff's review tag
- I2C changes
 - change REGMAP_I2C Kconfig from depends to select
 - add Jeff's review tag
- SPI changes
 - add select REGMAP to Kconfig
 - added GOODIX_BERLIN_ prefix to defines
 - switched from ret to error
 - add Jeff's review tag
- Link to v3: https://lore.kernel.org/r/20230606-topic-goodix-berlin-upstream-initial-v3-0-f0577cead709@linaro.org

Changes in v3:
- Another guge cleanups after Jeff's review:
 - appended goodix_berlin_ before all defines
 - removed some unused defines
 - removed retries on most of read functions, can be added back later
 - added __le to ic_info structures
 - reworked and simplified irq handling, dropped enum and ts_event structs
 - added struct for touch data
 - simplified and cleaned goodix_berlin_check_checksum & goodix_berlin_is_dummy_data
 - moved touch_data_addr to the end of the main code_data
 - reworked probe to get_irq last and right before setip input device
 - cleaned probe by removing the "cd->dev"
 - added short paragraph to justify new driver for berlin devices
 - defined all offsets & masks
- Added bindings review tag
- Link to v2: https://lore.kernel.org/r/20230606-topic-goodix-berlin-upstream-initial-v2-0-26bc8fe1e90e@linaro.org

Changes in v2:
- Huge cleanups after Jeff's review:
 - switch to error instead of ret
 - drop dummy vendor/product ids
 - drop unused defined/enums
 - drop unused ic_info and only keep needes values
 - cleanup namings and use goodix_berlin_ everywhere
 - fix regulator setup
 - fix default variables value when assigned afterwars
 - removed indirections
 - dropped debugfs
 - cleaned input_dev setup
 - dropped _remove()
 - sync'ed i2c and spi drivers
- fixed yaml bindings
- Link to v1: https://lore.kernel.org/r/20230606-topic-goodix-berlin-upstream-initial-v1-0-4a0741b8aefd@linaro.org

---
Neil Armstrong (4):
      dt-bindings: input: document Goodix Berlin Touchscreen IC
      Input: add core support for Goodix Berlin Touchscreen IC
      Input: goodix-berlin - add I2C support for Goodix Berlin Touchscreen IC
      Input: goodix-berlin - add SPI support for Goodix Berlin Touchscreen IC

 .../bindings/input/touchscreen/goodix,gt9916.yaml  |  95 +++
 drivers/input/touchscreen/Kconfig                  |  31 +
 drivers/input/touchscreen/Makefile                 |   3 +
 drivers/input/touchscreen/goodix_berlin.h          |  24 +
 drivers/input/touchscreen/goodix_berlin_core.c     | 766 +++++++++++++++++++++
 drivers/input/touchscreen/goodix_berlin_i2c.c      |  75 ++
 drivers/input/touchscreen/goodix_berlin_spi.c      | 178 +++++
 7 files changed, 1172 insertions(+)
---
base-commit: 857647efa9be89a13cf8963c7e167fab062b28bb
change-id: 20230606-topic-goodix-berlin-upstream-initial-ba97e8ec8f4c

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>



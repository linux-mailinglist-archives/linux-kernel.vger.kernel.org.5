Return-Path: <linux-kernel+bounces-90257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2908886FC88
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D933B2810AE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE991A29F;
	Mon,  4 Mar 2024 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnp0AdMf"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331A21AAD4;
	Mon,  4 Mar 2024 08:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709542779; cv=none; b=onz8jKTFhe36I+xXOv3jIc50BskvKkUxpeFY0JqUgVw+QL+mw9oKFHy52Ojhpi9WjitZaCib/GAeSUmK67hq1WJ8ohk63/D9jH4F4N5jUBgzGKghIbjBT0YY0TwwgCGpgEsg2xIBomhQ/6ohdjhy22K7/GXg1YSuNmA6abui7AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709542779; c=relaxed/simple;
	bh=a2u99KZ/g8QH3+B1Mc/rpYOTu5OPl8vhwz5casgIp5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XZfVZwfr4xZUMDyVVD3IVZLeFLOOSR/paSGBvMFYmIiZZS+WyGnh7q3vxJUzx63+Iq01c1zaBcuOH4wNCuTaDb3DaIJe+yLNWXvhRup8cPNYALsEmTYUYsMG548VmtLjGG81upiSSdFBgZqBm0ViNGs+YEemBr0gGgGWqoGPMbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnp0AdMf; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc9222b337so42062665ad.2;
        Mon, 04 Mar 2024 00:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709542777; x=1710147577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NCgMNgIsQ5yH5yGtzt3c+nzo8902LdhWh/xibCGfDJw=;
        b=jnp0AdMfJGu712i5JtvvbNvNGUzKJcu4re/EZ48wxCLuGPad7sN1y1axDUk1ALaLUN
         8Mb1w5bvpxtcuLrwxZCDq87It2KSGx7riU32wzL+aZyJiqZ3uE9IAYNyH2JFOfcr61I4
         zkB+MbQp2s/vyNc/fuTeLHwftqI8SvMrUjMOluxtQvjwAciGUj8FVNxG4li0pUhOcYa8
         wy5N///zkCopQAUIlCVvanoI4ZsS727Z0yitWUHCJ9IkUbMtnlEVNju5krlLrkJhFt/1
         fnHioszQNAyU5OUdY4Q8QgJcTmMBY6AiS7TadpZq3QAzztECOWCJjo4iR/+3DzHKs2h/
         IYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709542777; x=1710147577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NCgMNgIsQ5yH5yGtzt3c+nzo8902LdhWh/xibCGfDJw=;
        b=ss8bEWMzF6EBKEyE6GaO1j/atPgRICqPmV84/ZVFm3WcCbRVjqy0ROD+Sn20zoVujn
         dvI/xBFzDmmJYSwcummi+E7h2O1m6bZ95WSYDj+1GikwtC1HrUnbRUl8WkCdy3XEmJ3W
         Jnwr9yD1oCuhBl1ehPQ4qPbVW5kPeWcHN6u7LqbjdQ88KnfYgusZvRNVokufcFJNCC5+
         97ZlTKS7vpOnPPbxHPpkUcaAxK3UBUHejzBN4WWqjxhV+oV76K0G22NASzRIRFgO4jTr
         uM3GYJgQ1lXTIOXZYaZ7Q5C2VQcEeDAYnpCyCxQQQqIUnRTB84aqWXhj9PRRL2IX6WVt
         HCXg==
X-Forwarded-Encrypted: i=1; AJvYcCVAbVLkKGuIbxCu0JiDq+4ik8qaz4YAZjw1ksNeYPoDKMayftfoSjbBu12uE7ovgGzqY4jq8lmc1PKqhKGqamgYZadfA8OkRURcCW8qGKVtOzZxn29Rq8hZ0KhmMjuBY6pkUl+cniMvrQ==
X-Gm-Message-State: AOJu0YwJwRVNBUtyMvUsqOq0QBKTyT29OBn3q0kTcX5kv/af3/cgp+ih
	IrD3dIv6kBnxVRNrave38O4LAJci/4BdT3vB7wrW+jhj8cbGtH9t
X-Google-Smtp-Source: AGHT+IGJssglye0z9dA/EIYkGmMwL5UqzajKCPrB/EkEGyZOtMVWFHXED5Fw+PmbpEjlmLhJKYdCOg==
X-Received: by 2002:a17:902:ab96:b0:1dc:abeb:22fe with SMTP id f22-20020a170902ab9600b001dcabeb22femr8317535plr.65.1709542777408;
        Mon, 04 Mar 2024 00:59:37 -0800 (PST)
Received: from localhost ([46.3.240.108])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902ea0d00b001dcc0c84721sm7982371plg.99.2024.03.04.00.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 00:59:37 -0800 (PST)
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
Subject: [PATCH v4 0/2] riscv: pwm: sophgo: add pwm support for CV1800
Date: Mon,  4 Mar 2024 16:59:31 +0800
Message-Id: <20240304085933.1246964-1-qiujingbao.dlmu@gmail.com>
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

Changes since v3:
- use macro instead of npwm number
- add support for polarity feature
- add Output-Enable/OE check

v3: https://lore.kernel.org/all/20240223082014.109385-1-qiujingbao.dlmu@gmail.com/

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
 drivers/pwm/pwm-cv1800.c                      | 314 ++++++++++++++++++
 4 files changed, 370 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,cv1800-pwm.yaml
 create mode 100644 drivers/pwm/pwm-cv1800.c


base-commit: 801de0882d8a95aa1b1fe67df1696e037d785656
-- 
2.25.1



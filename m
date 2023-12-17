Return-Path: <linux-kernel+bounces-2814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC7F81624E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 22:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F745282B38
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2C9481DA;
	Sun, 17 Dec 2023 21:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="as2+dxmk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8610C481D1;
	Sun, 17 Dec 2023 21:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40c39ef63d9so26553095e9.3;
        Sun, 17 Dec 2023 13:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702847348; x=1703452148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8lQ9koqM5HR+VAaH2z3fBKlko6ZAPGMVyn6jm18Px/Q=;
        b=as2+dxmk22GakD0mG38ZAn5FglqLQJBxA5N17ew0eMaawA0Mjq0/ecx373dZXsPBJj
         7cg8Q9xFtMx3GKff1qBrGZ6K7DwwSK2TATnhM+42xGGLp6eaUul4q1gmawmUUfg6BZXr
         VCfJFG5WEK/MjotYdiFBjilf5KQw6o8+cIYH4gMH+XvutK0L+i+zBVj8L6/k2zf/xdvK
         c9jXO87v/6NcFAjZ16+HW97BbEkFtL+br3OemXLEwIUEZWjaWeQrxiP4GVG704E4/JJE
         Xv5ypn6zBE79tEmXI/ntVy4ZRWmowTY7fmO2yFxKwDE93r0bP1iTp1d5svVag/Jijrmi
         yVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702847348; x=1703452148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8lQ9koqM5HR+VAaH2z3fBKlko6ZAPGMVyn6jm18Px/Q=;
        b=iCNVLPr8W5hhNFXGLE6UUaOpPbHjWfnGFHPjz97bJDmT1YSOO+pra0L+5LQ7NGsw7c
         yE+QP68BDdnVXgPkVKba7EC09Ftf0P9feutpxSmeZRh6ohI6O9mjTfH5Lgbf35V8Ii7+
         rQ5ejfhLFPg8pxqWVVYIIOOqE8LoRN/L4/cLldj1tL6YKV6SbGJriL2H9gcWGCwOUQy7
         Vg4iPUhdjrG8nDc8AjDlXYsxjUWjW2OY53cecWcZiMEMksjwUBW25VW16miC5kFdjT4Z
         hy4PMLCduF1DQDxax+erQM8tgwvWpUEOqwGiqDXwOAw7dQrWOq3DtYOscbMWOW8Mhvad
         iPJQ==
X-Gm-Message-State: AOJu0Ywb/0uQNYVzIycntviLp30j8kEu+QkZ+4VZseheMBrt2CNLa5Yv
	ie73iqZ1QUFLGu3wz3EZXTI=
X-Google-Smtp-Source: AGHT+IFq0Qw5BzSy9IiEeWETEQaj9PyBVqQP8GjxQaaABXzR63EQjYWKJ9bwUsU+wJyPcCO0JSj5ow==
X-Received: by 2002:a7b:ce13:0:b0:40c:3820:f002 with SMTP id m19-20020a7bce13000000b0040c3820f002mr8188560wmc.94.1702847347408;
        Sun, 17 Dec 2023 13:09:07 -0800 (PST)
Received: from wpc.yadro.com (188-169-139-214.dsl.utg.ge. [188.169.139.214])
        by smtp.gmail.com with ESMTPSA id vc11-20020a170907d08b00b00a1ce58e9fc7sm13316096ejc.64.2023.12.17.13.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 13:09:07 -0800 (PST)
From: Maksim Kiselev <bigunclemax@gmail.com>
To: 
Cc: Andre Przywara <andre.przywara@arm.com>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	John Watts <contact@jookia.org>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v6 0/3] Add D1/T113s thermal sensor controller support
Date: Mon, 18 Dec 2023 00:06:21 +0300
Message-Id: <20231217210629.131486-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for Allwinner D1/T113s thermal sensor controller.
THIS controller is similar to the one on H6, but with only one sensor and
uses a different scale and offset values.

v6:
- Rebased onto 6.7.0-rc5

v5:
- Dropeed 'thermal-zones' node from sunxi-d1s-t113.dtsi

v4:
- Dropeed DT bindings example

v3:
- Fixed SoB tag again

v2:
- Fixed SoB tag
- Moved binding patch before driver changes

v1:
- Initial version

Maxim Kiselev (3):
  dt-bindings: thermal: sun8i: Add binding for D1/T113s THS controller
  thermal: sun8i: Add D1/T113s THS controller support
  riscv: dts: allwinner: d1: Add thermal sensor

 .../thermal/allwinner,sun8i-a83t-ths.yaml       |  7 ++++++-
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi      | 17 +++++++++++++++++
 drivers/thermal/sun8i_thermal.c                 | 13 +++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

-- 
2.40.1



Return-Path: <linux-kernel+bounces-118814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300AF88BFA8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1A82E6738
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025A76FDC;
	Tue, 26 Mar 2024 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L+/8JeGG"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF0A748A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711449388; cv=none; b=HtUJr4O9RMc8Y4Qa8JUTXODV8yTYmPwYYoPqEzpzLMRgk4oDNXPne/r2hoxWTzfhcenYUizKR8Q2cHIr0RqUVAkXMxqVEc+hiXIPVhHBetw0hXc9kPPlvCKbKx5iGqihDwzdy7OrjbhYdz9A4Z6xusrIXn4hEzqDPKXySRQIFF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711449388; c=relaxed/simple;
	bh=xQX9vjjhHlhpIG6Oqh4n+jDkazu37I7c7NJ4aCM4BSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BLV099udYvmZpk+ELMGWp14AL/n7wOz70mSuoQLNlnmt/yWh85p5K2ELrVttgLBDvkfnOaUDa/GXPRj42/7cT0qjXEJkcecwTKxjYDh8w3IHnHl05dg3XODZigANKonCtFGo+1seOIUSoB+rhn6KVjPUPwhiMVkUSAEV/FHV84M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L+/8JeGG; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34175878e3cso3747411f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 03:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711449383; x=1712054183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8cq4cJeCYZBITVK41CQ5JeNyS7iUkkN8uZMCoe8yIaQ=;
        b=L+/8JeGGLeq/aq3gTgECaXKLXE8j8QkcuPT0KsaGfGJ5SR3OlvACMqpthNV/R6mC49
         a4Qx8fTyqO8JwlrtRtxaT6I/U8keaCeRfjHou/oucfiLLP9QoCByqcTnRhldjiCC/cWk
         0C3zVH9IEoT8Eh990JvVqzXQfSFUUvfwd587MnakO67ppt5iymSwdWGJKAUwbVicmypk
         MedxVPRjpNYPlHc08QPBzzinRNYua6ncsosEV0+idYFDNeszanBwCXrfus18EBW4PBM0
         AkDl4yyX7Ar1D4wixTFyhiheYcTSzDQSjW7UC9Wqy1QALhB8MmpqiTo44B4L2LomzniL
         K7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711449383; x=1712054183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8cq4cJeCYZBITVK41CQ5JeNyS7iUkkN8uZMCoe8yIaQ=;
        b=qis71/e4zwUEVdG7EOzN1yAk/JgH9dm1y9r6dVAfHC55P6qXn7DOlkRoxvQjy5C1YW
         Pmu17KQdl1sUKrzppoF2/89B2KAmgnX0JlO4uebvSUqlOuS8cwtA/D/wneGyBy3RHklD
         K1queP3uPqE4d2DBM7jH5mJbCnFqYe86IM2XMBAXE0bWSHv7QeROfUQcBwJuBTzcGSgg
         xkSUv6Y37/LjIvUdvUuBejXrl/LuuveqmhZlAXHCduLqsB1aqIeUu8zoLXrCC09pnO2Z
         hppqSXwWol2Dce29QrpRuBBqa1A8blnLD2MPfm9Sw+wXXeZyNVBazdlMXD5wMYuYMgGy
         61FA==
X-Forwarded-Encrypted: i=1; AJvYcCWyHnvfTAYnK0lT9AmBmbGH3IAeBF9uk4TJGRko/i8GaB0uLh5auLnptnMBTM6/ReStdVkFH1rYqUOBeKjW90S7xAgdxEo89yOn5GXt
X-Gm-Message-State: AOJu0YzBGDhyC4WMMI949qX/5c7zQ6VwmOk9TaYdjDjPLNqAZMl2AGnf
	EO0OJ1+kbc5sSl83B3plwmO9N9yG5TViBWm5ILYttRLCHglK04xHYTC5HJrpirA=
X-Google-Smtp-Source: AGHT+IEQC6F62RP1GVxuaRRJ9iwSF/Nxno04fOCkJFrqlroTRqSWmDZp5Wxx5aVj11C+UY5lPZ9ozw==
X-Received: by 2002:a5d:648e:0:b0:341:cf9c:1c43 with SMTP id o14-20020a5d648e000000b00341cf9c1c43mr3595786wri.43.1711449383327;
        Tue, 26 Mar 2024 03:36:23 -0700 (PDT)
Received: from ta2.c.googlers.com.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id bn22-20020a056000061600b00341d2604a35sm3337954wrb.98.2024.03.26.03.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 03:36:22 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: peter.griffin@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	willmcvicker@google.com,
	kernel-team@android.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 0/4] arm64: dts: exynos: gs101: define all PERIC USI nodes
Date: Tue, 26 Mar 2024 10:36:16 +0000
Message-ID: <20240326103620.298298-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

The series starts with some cleanup/cosmetics patches, then defines all
the PERIC USI nodes.

v2:
- reverse pinctrl-* lines, first pinctrl-0 then pinctrl-names
- move the pinctrl-* properties after clocks so that we keep alphabetic
  order
- join lines close to 80 chars
- use alphabetic order for the standard/common properties:
  address/size-cells, clocks, interrupts, pinctrl
- collect R-b tags

v1:
- https://lore.kernel.org/linux-samsung-soc/20240307135248.162752-1-tudor.ambarus@linaro.org/
- https://lore.kernel.org/linux-samsung-soc/20240307135912.163996-1-tudor.ambarus@linaro.org/

Tudor Ambarus (4):
  arm64: dts: exynos: gs101: move serial_0 pinctrl-0/names to dtsi
  arm64: dts: exynos: gs101: order pinctrl-* props alphabetically
  arm64: dts: exynos: gs101: join lines close to 80 chars
  arm64: dts: exynos: gs101: define all PERIC USI nodes

 .../boot/dts/exynos/google/gs101-oriole.dts   |   2 -
 arch/arm64/boot/dts/exynos/google/gs101.dtsi  | 791 +++++++++++++++++-
 2 files changed, 779 insertions(+), 14 deletions(-)

-- 
2.44.0.396.g6e790dbe36-goog



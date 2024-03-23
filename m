Return-Path: <linux-kernel+bounces-112251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5101F887773
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 08:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF357B217DE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 07:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E88DC2D0;
	Sat, 23 Mar 2024 07:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m65fT+9W"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711D56107;
	Sat, 23 Mar 2024 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711179872; cv=none; b=Fpd8MxdQD762HzuwF29Fs9+q9jOvANaFyMoqeF4pUJyfRH9SSrgbydxKOhFxStynk9WrgNUxC1qLvt14NN/aJINzpDndQ9YTPMfGdx2jQVyFlFlldNpvWUGbrh5Z9mnzgABrtM4Uyw3AoRQEIPsuaxZM15KERZpVmEfwyQgYXfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711179872; c=relaxed/simple;
	bh=vG2ixD67oI7pZv/388uv2qcvWouiFsZXmP0odTodtpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=evzWQbVv+XKtvM6g6iKjKqPwHSjpj1zPKO+h3fFS5WDyhMLNLIYEj1R1ImjOc7ds8Wyta2enPLsgZxojrN93vDcLVH6KRrmFx2tZwvJ7Gi1sZOVqX6+MbLNSxCjE9Ku4UXKSagxuU1VvHdJ/W2CoYHYxLFH5ouCgwwXvnVGz5Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m65fT+9W; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e08512cd8dso15886335ad.2;
        Sat, 23 Mar 2024 00:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711179871; x=1711784671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pFIHxUfDhEjmdeRNyvzrzBdHaOdyGF17bN8Se5iKpPk=;
        b=m65fT+9W0pxnmLbXRWx9sEntCLHjtqOluhcfs/POCXAPQwkQT82KqtWz/y6wqvyTFy
         9aPD3mwSRml9RbwyQuMCcmz+zEpZ+KF6OSbLnfdpCPQq89CyZfm7r7QIVGZrPr1aeZeN
         T51VqvYrP52rO/EOUMrpabemQS+/myb7m/vCSM3VZ55hdB8fsHtyu0uBPLgJk0qMBkA8
         4J1GBJKZ3dIrkgIxR4hHSRlTuKC0T3DqZa3IOcmmy4ctw6VYZvcFFGK9UCxhjh/d7iQE
         QuAhbhyIc7NAz9A91cNRnYB6xxpRCwMtN1/GpDCCbjZIer7wE95EV4AFgfB3spoKsRUF
         JQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711179871; x=1711784671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pFIHxUfDhEjmdeRNyvzrzBdHaOdyGF17bN8Se5iKpPk=;
        b=iCNy29OwkbIVwyycCwzXA1++yJ82sNxxAb8dE4/f1dd9PkZtXB5w+P4icbiTqspBUi
         q2yTRqhTTpv0N71WUn/4/Kee3Aceo4+CEBfSKFLCoVl+8XqtvgV7BTq8heGbfKGH2aTc
         X1GgbWFh121RCiDsX5lLsBM9xs7/g1tMWQt+KmjmGmJolDpzQOl5D1QjFNqvtQp1Ml5/
         DWgxcGMIsSV9s2iX4k0zbUAiNP8lBFQiZZAjkpnqROqsuBpEfgGk1QXLWH9gpK7YCInG
         O2nRCSVYR/a2gre7hVrfjfyqjJv6QfwT+iOSUseUxap1bbnRaNGcOMgepHYgoUx4RzQv
         Bwlw==
X-Forwarded-Encrypted: i=1; AJvYcCX3AUo8iTOcM3BnRGSdKKwD6UfPUec+KO+iLEUum1IvAyHNh9cDjvJe7IHTl+uhH0CW+wg7nHyRowt5cSfQ/RZWKRKPhKN/1Bw7hliZygIdkS6AYTOSwuTDjGInI3XAqlYYEu5IhZCbAA==
X-Gm-Message-State: AOJu0YzrbHDhbS0M+kpuFXc/nvVim/t6GlZzVyv2eOgczW9Sgc+sE9gk
	rwRxUvhuJrTNAc+uT4Uka1rnzm5zENQ9ljvUoMAvbDe9TmDfwcOw
X-Google-Smtp-Source: AGHT+IEj30C0v+2g9xEMtQMRIUC41VW6iffGnxv5pvPvgNMX+B7jKGvVtvW5+QBJZ7LipLK/kLtSmw==
X-Received: by 2002:a05:6a20:a919:b0:1a1:4df8:1ec4 with SMTP id cd25-20020a056a20a91900b001a14df81ec4mr1394890pzb.19.1711179870652;
        Sat, 23 Mar 2024 00:44:30 -0700 (PDT)
Received: from localhost.localdomain (FL1-125-193-23-126.chb.mesh.ad.jp. [125.193.23.126])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902d05100b001e0410bfccasm976825pll.126.2024.03.23.00.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 00:44:30 -0700 (PDT)
From: INAGAKI Hiroshi <musashino.open@gmail.com>
To: pavel@ucw.cz,
	lee@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	INAGAKI Hiroshi <musashino.open@gmail.com>
Subject: [PATCH v2 0/2] dt-bindings: leds: add LED_FUNCTION_* mainly for router devices
Date: Sat, 23 Mar 2024 16:36:08 +0900
Message-ID: <20240323074326.1428-1-musashino.open@gmail.com>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds some LED_FUNCTION_* definitions mainly for router
devices.
Those definitions are useful for OpenWrt or something.

v1 -> v2

- fix sort order of LED_FUNCTION_MOBILE
- improve the commit description of the first commit

INAGAKI Hiroshi (2):
  dt-bindings: leds: add LED_FUNCTION_MOBILE for mobile network
  dt-bindings: leds: add LED_FUNCTION_SPEED_* for link speed on LAN/WAN

 include/dt-bindings/leds/common.h | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.25.1



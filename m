Return-Path: <linux-kernel+bounces-155707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3178AF5F0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27B61F24342
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24D113E885;
	Tue, 23 Apr 2024 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGh+QvQz"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E46E13E03B;
	Tue, 23 Apr 2024 17:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895159; cv=none; b=UVQc+dEmhr30N29Ov0qlO4YTvIJbfNRXE2AM4gGxVU8wHHk3frVld1BFtrx/QYHjKlbTYMC7Kq7wVqzPCLwK0FP/OdwiNayDqqYgmWImlzdUgIkOshqFzXnhJqNEmAHwYCalvstahjqREfFt+dwoSI0h2ynvGEhuewk59OFwZxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895159; c=relaxed/simple;
	bh=9NXPYc75mChmMlPS6LNmk0YKUT2rQDn5XxDadCwqG0A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ijjEesXhIC6SNZrPda5vF9o68NtPLfVT/9wLxmIdkHkOCOV8BzrQ1wEswA6cz9XIoZTwKRIVT8MqApCubnV0pFuFMzCUeX6Z3A2lTexoZNMGgi4PGd5ApZXDHAiOn3IquwPLfUExR2+9M2S8gIIELkfqm8MXQOdUSQLNREVE1mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGh+QvQz; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41a5b68ed0aso17276545e9.2;
        Tue, 23 Apr 2024 10:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713895156; x=1714499956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sZBXeQeCnC4rqFfrrjzeZmrl/Ux913mz2QzkIHpqVxw=;
        b=VGh+QvQzYjpvNPXk11CvykcSsRT1wa3Sh6Vy8iC9Hlh418Ie3H4oFkmQmKLdDjVzTX
         vTGMTHZu3PCBumEiizLRdaj+84ClFk8yA5WoXVkXPMvjg20Cl1dLH3cB1o3gg3IXvvbk
         bnN58UYVcGMXupoOVcbo3FR4Q+gWh6xtwF9mfmjTYTq/STV+vufnbhjI+tLs2CKEX0ps
         ryHwfEUzS2seFG68FERb6gWw7ImbwP6agDtN+9fWi9xt1RIwnBPkAoa2QMA9DRRtCYzm
         nVhMiPYyXY7c7uvFwePtpQiUFCPstexoAWpf1SrwXPz8TO4/DS8rx1zTdydFC3acmcMX
         C6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713895156; x=1714499956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZBXeQeCnC4rqFfrrjzeZmrl/Ux913mz2QzkIHpqVxw=;
        b=dtTF9tdv+5iE9Gn1sxfCoF7gLow4Qx79hQJjNGycoJ6VUOvpEx1OsYhxMrUCxjalMl
         HIvHB7nu/kirhY1kOOvHnmkV37m9O+XPCBwAZL0dfYqd6qWgHiTwHomdbOpPmkyZmqB3
         opiqi/UIv0Er8enCgRG4Y/sYfWn8cGdZreuyU8S2gXLKWEr5yXk4SQmDNOylngobDmSb
         a+yrGPNW8WWOEfzkQZYf+jj+0SDMsbEUBFIvHeXAC0JknUAFHe4Iwpodw17VmxCG+pjf
         Tn4JVhYxOS/rmqCpiJeA4+Omzr/knXL3y4vgZ+k9xDSWZl71BQNW850MaziusiDurmsG
         xsUA==
X-Forwarded-Encrypted: i=1; AJvYcCW1R2d39jFLsGJhkaMOcMZoSt1wyAY7KY7Ku4cMi0P/YVgXYLtbCB8w5m1i4bA6PyTrNDkXPHKj/4wL+APdvxcINnzbmb0qQAG1/xgYIRQecHSh0B57DYAjWCWDPutpOSHKegANaIlRx97GcSPXyMJIPWqpz9dLYV5H/D3lCVQqedh7EKksQefWNTDy
X-Gm-Message-State: AOJu0Yy3i/+oY67Vb3VjXkqnY59uegugmIRtKHSI52ms+qlCpoqJ+gHf
	fEA6b4C4Jpf2sUYmJTHxhvw+9s2vQm2NX8R7kDDP7FBHA15AlKid
X-Google-Smtp-Source: AGHT+IEm8XTfYr7JFPTebKOQ1Jp9fpmnsV/4EY4/dp/36hmRIeQuUa1BfRfqz3254x9Hc1a0mami3g==
X-Received: by 2002:a05:600c:1d14:b0:419:f27f:6b05 with SMTP id l20-20020a05600c1d1400b00419f27f6b05mr30686wms.8.1713895155659;
        Tue, 23 Apr 2024 10:59:15 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:cef0:9ed3:1428:f85f])
        by smtp.gmail.com with ESMTPSA id fl5-20020a05600c0b8500b0041abeaaf7f0sm2808145wmb.28.2024.04.23.10.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 10:59:14 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 00/13] Add PFC support for Renesas RZ/V2H(P) SoC
Date: Tue, 23 Apr 2024 18:58:47 +0100
Message-Id: <20240423175900.702640-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This patch series aims to add PFC (Pin Function Controller) support for
Renesas RZ/V2H(P) SoC. The PFC block on RZ/V2H(P) is almost similar to
one found on the RZ/G2L family with couple of differences. To able to
re-use the use the existing driver for RZ/V2H(P) SoC function pointers
are introduced based on the SoC changes.


RFC->v2
- Fixed review comments pointed by Rob
- Incorporated changes suggested by Claudiu
- Fixed build error reported for m68K
- Dropped IOLH groups as we will be passing register values
- Fixed configs for dedicated pins
- Added support for slew-rate and bias settings
- Added support for OEN

RFC: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (13):
  dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Remove the check from the
    object
  dt-bindings: pinctrl: renesas: Document RZ/V2H(P) SoC
  pinctrl: renesas: pinctrl-rzg2l: Allow more bits for pin configuration
  pinctrl: renesas: pinctrl-rzg2l: Allow parsing of variable
    configuration for all architectures
  pinctrl: renesas: pinctrl-rzg2l: Validate power registers for SD and
    ETH
  pinctrl: renesas: pinctrl-rzg2l: Add function pointers for
    locking/unlocking the PFC register
  pinctrl: renesas: pinctrl-rzg2l: Add function pointer for writing to
    PMC register
  pinctrl: renesas: pinctrl-rzg2l: Add function pointers for
    reading/writing OEN register
  pinctrl: renesas: pinctrl-rzg2l: Add support to configure the
    slew-rate
  pinctrl: renesas: pinctrl-rzg2l: Add support to set pulling up/down
    the pins
  pinctrl: renesas: pinctrl-rzg2l: Pass pincontrol device pointer to
    pinconf_generic_parse_dt_config()
  pinctrl: renesas: pinctrl-rzg2l: Add support for custom parameters
  pinctrl: renesas: pinctrl-rzg2l: Add support for RZ/V2H SoC

 .../pinctrl/renesas,rzg2l-pinctrl.yaml        |  40 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       | 640 ++++++++++++++++--
 2 files changed, 617 insertions(+), 63 deletions(-)

-- 
2.34.1



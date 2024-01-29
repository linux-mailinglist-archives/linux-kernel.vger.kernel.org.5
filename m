Return-Path: <linux-kernel+bounces-43287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C938411C6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C86B3B21AB7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A383F9FE;
	Mon, 29 Jan 2024 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2Jz7KZi"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDF93F9C8;
	Mon, 29 Jan 2024 18:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551876; cv=none; b=gMMM+XSqe8pXHsZWcOBCQrhQ9+bIaIuJchCfoNaSGTHjsBCsGk76tJ/v2EoH111zf3DBXdofreibkN/mHEPNCDsvA1AfdzPcs1xRbCuB4Sc3lEbitCcCOepVlvIIspiDq0sQwHLRc+c1s16rYlQVslE5cVR16GiGdlpguZFY2ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551876; c=relaxed/simple;
	bh=cg9ZpMq1eBbRhnHkIYMMcIo5iPX511/eFMIn9akrJRY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EEy3MDYyve8LoulutOmp7+voE8CZzNoW1KFUTxLwzku5JI/EaBZVWsfMizCbJXB/uL1xZMLAnpN87Jw44aUcwIE5BomnKLoZviwMk9FcikSpZblOZz9gS0S5rhC+XA9aO7TR+HmxzlAxHSERDf2VIWNBFsaz1gPRAToU0g+fKpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2Jz7KZi; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cf206e4d56so31888941fa.3;
        Mon, 29 Jan 2024 10:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706551873; x=1707156673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5PV3kJj5ayeruMW7amNuGjoOtu/eShkyMQti5Ehb51k=;
        b=i2Jz7KZi3Q5KJo7ankSn3XebNh/f9yQvHM/BXyO6fT9gXVoIxkTNhpYObXX8oNA15j
         JnWeDVLwSf9jvg2KmcHxfQiGoh7OtP6yzC18vZ91bWCnex49pMZ4gQ9ZAkb2hE39aZ+4
         84lnvEkaax1brUDeAri4lTu6QS/wocRlIwkwoMMLXVhwyq3mI+4yTrIJOSRNJ6iLIkjK
         ZyR+flTA62eapYjtnujEF/McwWK1anZD5mGA4fI32GGJ589QcmraDdoxuVMMYJc/jxHR
         FxfdWs2BAxECCR/RhtBiTG35tMlZaSrQnptu5Y32HkpMtrgfrSzoL+2mhKMFtP0TnOUX
         m/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551873; x=1707156673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5PV3kJj5ayeruMW7amNuGjoOtu/eShkyMQti5Ehb51k=;
        b=QxmqdR4dNYV56SaSRQLfLiG8ODHDSmunTQ3HS/Qw/RnxAFxIxO8qqigJohfEI9A04C
         CJJKdY3UxrthnxW05pmPHHkckkONisXuKe/vRfZiEgs4WIvoLbacqvEt42JVEKZQWeoY
         d2Bj+q0Z7BVO/WhgZRuCX8Fpn9QkyDC/d44Igpoxs7NHUvM/H2AMFLfx7OrM+YaiC6FZ
         zzg+0KuquhJrbOVs50IHrRnyDgKFZDdQt+YhMevJ0yJmXRNV6zO8IuO2TVpgWsyK7vNR
         mrQqQ033wNKMsQhhz/K/mpc5cmrX0KI8ZpeM9UBWB1fjxf3K7RVijrw17Z8XIGv5lp6j
         GPsQ==
X-Gm-Message-State: AOJu0YwNr3FKQEpwWHNwszKW4O6neMyGFrMyobgQyaRSvJO1N7Merx38
	+/vqGErQMnGi9xc7Bo41aGVSpWPFUEXI8BUZPbjajg3WLNYnreIe
X-Google-Smtp-Source: AGHT+IFBpfv16L9MusHNcMZeERmclRxv3AliyqRZzJFcL6NaCQPqVIYoTU7qnuupN20SyFFzTL/jTw==
X-Received: by 2002:a2e:9b8e:0:b0:2ce:c0f:4b6 with SMTP id z14-20020a2e9b8e000000b002ce0c0f04b6mr4218361lji.39.1706551872619;
        Mon, 29 Jan 2024 10:11:12 -0800 (PST)
Received: from xeon.. ([188.163.112.73])
        by smtp.gmail.com with ESMTPSA id u26-20020a2e2e1a000000b002ccc6f06e2dsm1231214lju.128.2024.01.29.10.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 10:11:12 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Romain Perier <romain.perier@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Robert Eckelmann <longnoserob@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] Tegra30: fix sound on Nexus 7
Date: Mon, 29 Jan 2024 20:10:48 +0200
Message-Id: <20240129181049.89971-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent rt5640 codec update requires mclk definition in the
device tree. Without mclk defined sound will not work.

Robert Eckelmann (1):
  ARM: tegra: nexus7: add missing clock binding into sound node

 .../boot/dts/nvidia/tegra30-asus-nexus7-grouper-common.dtsi    | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.40.1



Return-Path: <linux-kernel+bounces-116725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1930988A7B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08CA0B63C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8953C15ECC4;
	Mon, 25 Mar 2024 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="apATnQjh"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F016CDC4
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711357113; cv=none; b=bl+/ffzEf61FNNZ8PrYtfRXiX4hc1zpqbPj6OuK6dQlPnJz8TinwGloteZfaM7pEYBQ389H9gOS9sAXklVtQqS9yvBc3LQlUI/Ocm3D9uhtsJodr34lO87pyPKBOt7tlX/bM3N1tPu5SsztvjEfHnKBTDuy7V9iq38lrmHFHlBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711357113; c=relaxed/simple;
	bh=1YnavWPOfJLHnYpEEnar4VoxHGxBD4BMYygycN3+S8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fJCfQk5Ht2JeG5Fwsj/v1sSSD4u3gHx6ULElznaNs+UPnZs7y7SUPS/UK6z2LVuXgU/5LACb1xBLcQRSiHm3rdhtNgSZEbFSjcZYLd/rvzWecGv97Y3YIOyfZBaRuYvpcP3oA81fg8jkENCEdgJXrED6i2wkjFwZyvEHq4ASZ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=apATnQjh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41485f6da87so5750985e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 01:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711357110; x=1711961910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WvTu3KoskBMr2J/lluQG6Vin7kG4Wy/TEBNDcrWrPj8=;
        b=apATnQjhkbtlh+XMCZGa0QuEk4ery81BTxEVSZKX38PTaa4CgOKCUMOSBckjyHANEV
         TDCjabUgsBIyM9uUUNaOYYC6K9zSapJKjQ2ME1F4VIXQg7sHbTyalzT6A01bVQ5rh2u2
         sCXX/mCB01iJB2WaGcg+haj3qYpskEtHtH8wA5lhfaD14hpllZqf0NmbfNBrH/AblgbK
         mwlsYpRVaiDUvfXB28WtG/IoD4Wj7BF3m/w0qfVHQ5GPH/LL91Mz76rpju3gzg7G7Q2Y
         a0XLZYBDalUQVs9Glj79KI4tpYw5gZsXWjQUqS1hGPm6HVOHolTrfRQQkdmFqOW0DBfz
         U7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711357110; x=1711961910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WvTu3KoskBMr2J/lluQG6Vin7kG4Wy/TEBNDcrWrPj8=;
        b=Rrki8i130acoVoOiG3l5OwzideBilYIQSifLoBZxmInknYiMeUewVG32Q7jC7kJHpk
         6UecMmz7FjdU1lR8QwwBrf+rj+2fnTpfaepR7u5loIlFi7szQe1//+OXGZZ6gNiFUGef
         Kp7FCFuRf2V5aA7XtGpBfiPT+TQV0GXGi/M3zS1jedU4wSVLzIZTrTknhPS9qGyEA79w
         j2tor5oeGWYA7Za3ggVJF/w524msd2k7bmCK9RZxiBe4h9cYdv6l3TMbl5u8eL1WTnsH
         xBqaGxnSldKlHwIry5UybiVJamFGjiH/fodIE012wRZW92CVOf+p/uq4EjrOwcHMUpYK
         8Uaw==
X-Forwarded-Encrypted: i=1; AJvYcCVsTUYRwppZbMgyDDe8Fa8tJaPLLhYRukiFq4rTw5DMJKNeLmn9vN6eEcDJJoPut1rrpyra1GHcUPV8d/wPg4sj7PNS8T7b41fhFtpr
X-Gm-Message-State: AOJu0YzoKoYE6f/w6joTqC0epzR/O0p5EYsizs03KPebLRe6sx65GGVQ
	H6++FP5knP9PN8B58Z6j/7qBySuRh8zEt0DT+SxbLdijJGan9iZuOJ1XX0GrPTw=
X-Google-Smtp-Source: AGHT+IHV6saW1yuder8fvjhVVwT1UCIgEc/9o24QLMAvLw4+xtgAN5du4nzJ+6ZwZf5Ais0k2tNdxQ==
X-Received: by 2002:a05:600c:1ca9:b0:414:7b98:da01 with SMTP id k41-20020a05600c1ca900b004147b98da01mr4762366wms.7.1711357110196;
        Mon, 25 Mar 2024 01:58:30 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:861d:8b72:a859:4ce9])
        by smtp.gmail.com with ESMTPSA id bh3-20020a05600005c300b00341c1d50756sm5798461wrb.95.2024.03.25.01.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 01:58:29 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [RESEND PATCH] arm64: defconfig: build ath12k as a module
Date: Mon, 25 Mar 2024 09:57:56 +0100
Message-Id: <20240325085756.13843-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Qualcomm sm8550-qrd and sm8650-qrd boards have ath12k modules as part of
their on-board WCN7850 WLAN/BT packages. Enable the relevant driver in
defconfig.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6c45a465a071..937edf09f0aa 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -411,6 +411,7 @@ CONFIG_WCN36XX=m
 CONFIG_ATH11K=m
 CONFIG_ATH11K_AHB=m
 CONFIG_ATH11K_PCI=m
+CONFIG_ATH12K=m
 CONFIG_BRCMFMAC=m
 CONFIG_MWIFIEX=m
 CONFIG_MWIFIEX_SDIO=m
-- 
2.40.1



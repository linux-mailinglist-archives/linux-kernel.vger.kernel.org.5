Return-Path: <linux-kernel+bounces-167701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 895DD8BADAB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA3B1C22070
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F08F153BEE;
	Fri,  3 May 2024 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="H3uby9WS"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D46D153BED
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 13:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714742557; cv=none; b=i7qxEPxHQzo2a8GdQsABlQilOGB5UDZ/1pJuV/h9kSfiZAkR2n/SoLX2vKweKR6jN+YMgdROvFXDIo6r8KbvaK2OQtaTHP4eI7qwO9Pslz+M2yiWiwlt/FRFNFj4BTFjO4rrcCW3zAi0Hy/IwNVOHMoQ2PH0Wmk73vIjjxMfMZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714742557; c=relaxed/simple;
	bh=E+SpOVvHGi3ykjwFD60zMDyQU3xXnUCfecCHq2pmGR0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JvJdIQx5NlPCDYbdGi3kPJeeYXz3mGACwT0TyifebY6uiCA7P6G35EITOYZuWZ1H9gqDbMOgTk3UDgyzilF5ljlBq+8YPU3jx3Vz/AKvp/yp++CNglnZWnLzl8ag6eq1egtPoBXTCv0/xRYyAPaqflpez2g5Gvfd4yDlFRXKMaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=H3uby9WS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41b5e74fa2fso60396675e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 06:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714742554; x=1715347354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kit1TBFVgyt1sxkCYLtPtBHsm3h3unJNtgT/eeVBYto=;
        b=H3uby9WSHlqYlQsoj89ksCUdZ+ObButx0Sdz5iNADIH1ssb+HHRxyD6JK4itoqGrAd
         iGBlJ4rRQNB8BmCAC1/CiNxRfVc7A2Ae7isOgPJmi3poR4f4tu0reVcOWAiLJkMiZzXP
         KLo8XMatacuH3XEbOTpE9FRCPccJwJlPmQTgQGOOrU2r1PjtozpDf2henbS2QBRJiCRs
         knGXpjmIlsc68t3twNRPciWlCeyvmmxVIfGOjDMDrdtiTzBs5O20tgRfJ10CohHrWBx3
         mH+ptt4vz/aGQTd19R8W9rNWE/ah79wCIx4pIelU43f2zGw9J1RDIBayo9x5aBID3tK/
         jSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714742554; x=1715347354;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kit1TBFVgyt1sxkCYLtPtBHsm3h3unJNtgT/eeVBYto=;
        b=uwhvNZ4htipTbea33xsDXQ8sDYVUubN5y8I56pWq/eoaJkSnDY21CB6BOJfGJNWfsi
         ZNkJz/azx4VDgHeaCnsvrsgLvDx0+czbtF8b/k8tQJS6HJ9sv/Le+SC0jzQR+HgHMksT
         cmV5VK19mytEgoeb/K+PpBCMD9u+4+tz0uGw8/q1/kWhudlAUjOZgO0xe2lIbnPQ8Y0Z
         loaDN5+yb+AGqM2czTbDxA2VfdTglSthL4rUESvw59LacCCRsLNeeKdio/LJTAh7QVTG
         biVDo9jhTOQMAlhVAKijoN8QkGSH959dnvH0ZMkBSmhc5RAUTiJbRs4WRG/C6we4bX7A
         uTuw==
X-Forwarded-Encrypted: i=1; AJvYcCXiy79+OTQ5HT1ivWM5ki2p+23tbQmW7yc3P6wDwEktfoRHXEgBOMZczq23mzZmpgIwZIuZPC1YBhrSyEJZ1yxbKP34Sy4OQlkfzEbT
X-Gm-Message-State: AOJu0Yz8jCBg/akiLIjUZYKvcQichcsn2mfk1EIW5l6KFFQbVM6tVBqj
	/pTnjFuhCF7j6gbV8EDa1LKhYK33Wg4vl0hu9gw0VIOiMEEIEKnZ0E/z9n32TJc2axDdN577BHC
	V
X-Google-Smtp-Source: AGHT+IFMN7kbGVdBfJ7UT+4XcxNE33ol941/vCrMnxSahE6k9NpvMQZvsFEr8R/ZH3PzSShRqGZkew==
X-Received: by 2002:a05:600c:4e8a:b0:419:f088:249c with SMTP id f10-20020a05600c4e8a00b00419f088249cmr2174709wmq.12.1714742553772;
        Fri, 03 May 2024 06:22:33 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:1b85:e590:355b:9957])
        by smtp.googlemail.com with ESMTPSA id g21-20020adfa495000000b003437a76565asm3803713wrb.25.2024.05.03.06.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 06:22:33 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20240410155406.224128-1-krzk@kernel.org>
References: <20240410155406.224128-1-krzk@kernel.org>
Subject: Re: [PATCH] clk: meson: s4: fix module autoloading
Message-Id: <171474255291.1335139.15327121235218632635.b4-ty@baylibre.com>
Date: Fri, 03 May 2024 15:22:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

Applied to clk-meson (v6.10/drivers), thanks!

[1/1] clk: meson: s4: fix module autoloading
      https://github.com/BayLibre/clk-meson/commit/11981485e27c

Best regards,
--
Jerome



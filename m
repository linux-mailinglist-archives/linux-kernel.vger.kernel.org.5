Return-Path: <linux-kernel+bounces-152947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A808AC67B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 685C8B22758
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27480535BA;
	Mon, 22 Apr 2024 08:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R7/eS2Wb"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D217E53362
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773609; cv=none; b=N8S8Vky2huF/ZRRj2Fdv8zwk2FZqaLDpZLoAzmHFUVu4SQZr2BmotRCWPsiwmHu4UEG+dbSL1BLkLGVLJ4WuGbU4dnLYTpHd3XjpbSubyd/iYhUD82Wr54e7TyZ+scvu6tc2r5eq0HT/8QKjYDJOxja2+igOAFnFc7TDdQHGkIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773609; c=relaxed/simple;
	bh=KQ7C/RlPe2nyPMn98EMHW78mX3O7mG8DtqL8vkGG53E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pUg6w6Df8SGQzl6oC59IWynMnepSPyS/soIJ0SGrIZu4uulnzPivaZiR/XNLiXwWgjyuzlm6QzRGoWns/SdyxpYXJLhQFyppDydRb+KXVxA/qaaa8rNBO5A3ezkXYT1y55uT4s1N1Adfak7gc+WlZoqbMgPRC0ujZsMVdlaCdUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R7/eS2Wb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4196c62bb4eso17774715e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 01:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713773606; x=1714378406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJA4a5dlfNiF/Mn+2ESih5PJW4UfTetDxjsJggty4nU=;
        b=R7/eS2Wb9pDQ7ob2o7kfviNmCMb37h7rwtjqQDoPeI7e7s5NMtEn7nype3GwDaSfek
         7I0/nIy78Ost361dTueeoRTN7EybmTNu3tQ2pnV7t681+y3oAO8zqY/TjscGBe8TrbFR
         QhqQ9Olcr/jTSRCZMmenly95cBANBfx1+z5BWmbv+TLMtT5XKlZ6BTUxHyiBexranOzK
         Jaj9bbey6aEE4p/9jWUjwwytmWvuR6y6yZKXBJRPtLTA452dg3KP1op28YIEIX0l0vuD
         gxRr5I+kbOJXaDcpx6AVgZFxPZcMrc63zG0BfLO2O+o5LeDQ+dSyzYe/KkLcPgfjlJJA
         J7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713773606; x=1714378406;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJA4a5dlfNiF/Mn+2ESih5PJW4UfTetDxjsJggty4nU=;
        b=RlPG702I7V4wptALzoltwqoiYKRZstkiGGEm7wNHvJLtKEu6iaT2ss2hgzqdSd4qZB
         3aqcSsDupzK+cwzGJYxHPLyoIflFIZLMtkpNLX4472qcemg0Oo5TXW5/5EWX4Xr9zftI
         YvswktlgxPUXNhCoJ8yJkPV9y+3NTitmE5wB0RNI0ymNjVgLIG7+gd3P8QrXwBdz4P/t
         Uq+S5U0zg5NbsgmG/8oVlaoSU0ceZpTXOVxZLh1OhhcjQTMCabDiMMNTR3n0i5IvQPF3
         s6iY7W0SJTinG20+qrOZDHD2ibuhywn7YIcXtY3IFm0FtS0jxlGo1m5XYBuYBcLSzYgD
         /9UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnu2K+DA/YFJKLfDnw9DU3eCdgAY0w6ZAYtCtu1roUIq/9gdhR0oKfi5aY0rUBeOkI7rVHgCSOD2Ajq24omrFBrbTxDGnEl9vhR2HF
X-Gm-Message-State: AOJu0Yzm4Xh3R3Sngv9RQVJLKwR3TEFumfYk4Xsasy7ZdHlh4UpzQvho
	GLXisQkC4aicoDcr5ZLBvfVt5iBqT/jTi63XsVhe4a7K8NdUz/lu68LM+9GfSb8=
X-Google-Smtp-Source: AGHT+IF4cU+n70iM9aZ/bhIOf7ej4TQDcYHB1Zobb6c1Ifw1HLzoA9501M1WkvFgE4TgcpsQDdtYTQ==
X-Received: by 2002:a05:600c:b85:b0:41a:5de5:85f2 with SMTP id fl5-20020a05600c0b8500b0041a5de585f2mr1356294wmb.39.1713773605856;
        Mon, 22 Apr 2024 01:13:25 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c35c700b0041638a085d3sm19437504wmq.15.2024.04.22.01.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 01:13:25 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: airlied@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 Jacobe Zang <jacobe.zang@wesion.com>
Cc: nick@khadas.com, linux-amlogic@lists.infradead.org, 
 quic_jesszhan@quicinc.com, sam@ravnborg.org, thierry.reding@gmail.com, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240419014852.715125-1-jacobe.zang@wesion.com>
References: <20240419014852.715125-1-jacobe.zang@wesion.com>
Subject: Re: [PATCH v3 0/2] drm/panel: add Khadas TS050 V2 panel support
Message-Id: <171377360500.3418456.9021702656512233742.b4-ty@linaro.org>
Date: Mon, 22 Apr 2024 10:13:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

Hi,

On Fri, 19 Apr 2024 09:48:50 +0800, Jacobe Zang wrote:
> Khadas has update its TS050 panel, the only different between the newer and
> older is timing squence. In patches, add new TS050 panel named "ts050v2" as
> make it compatible with the old one.
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: panel-simple-dsi: add Khadas TS050 V2 panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/0546e01d5a0269f02b4aa227f44b30a5a5558792
[2/2] drm/panel: add Khadas TS050 V2 panel support
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/26f9339212db569310d4b0ef4284efcbb462a86f

-- 
Neil



Return-Path: <linux-kernel+bounces-161482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8DE8B4C9A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 18:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A0E1F21593
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D0771722;
	Sun, 28 Apr 2024 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rv05Ycek"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC896F072
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714320712; cv=none; b=FryMRGTfyzIv+bfONgu4spv+hv2BadTjAqm0u1/nUt9Et/iD3RsN9bU33LonfgenhflV+X5tZ1nRt5ogkwciBcTIekkYJ+OuoDEy5TVdXxNIxo/qtcS0gynYTunf0/RiMkDHGIFAVA/6k6q2JZ8AhZrVmy6E3edb3U5KT75iv5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714320712; c=relaxed/simple;
	bh=EU4iG4WuGytpyd5HyDGvsnuRGv3BPHTkxwHMDBIpDWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNbsPXz5q0wKgSMMd7GtGL7o9MEKIqnts81VcoCgpYfjhYgpd0XL/8u67aLSf06CQftPeVMgiWRW5yGGk2kgudQryY+19pTae5cIeHX7G5amGw/T429UqGJ1pfo65udhKzDmlSmLP+xw6gKgN6xuJLPAfVu7Yq6/PoV0uY0JVaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rv05Ycek; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a58c89bda70so271647366b.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 09:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714320709; x=1714925509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Xf4FNSHAHOETwMyiCUOZ7LYnEsnl/s6mjRO381GJqw=;
        b=Rv05YcekDhnBXUyuNMdsuxSU0v94ckhnl0z7fhhVyuhlWqF5VYTqgRJzpmgBLmytji
         Js2RJCe0Bh0cJcUfEsdSdeAMz6GiZsXeUyjPTVKV5zIRoZxhqPY2jNxUl+O1tNylDW9L
         yeltgvQR4F0Ck0gmHzZKIAA6CGhYr6FTaP6nwLo8QCq3TJ7MAWvWVlnp3OoY8EGx6YW/
         Cnt5QOrhXEW3vf1vaJtwqw1SBlHUjXZ+vPl/TdSOfEFyGnwER9d5W8vfvVXryr78nuC0
         L8I2DuftZ+WeX63hczpnjmsZzE+Iu4gJxStPRgxMYHwTqEVl8h7CpGLXPtPYdu/BJqRt
         OKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714320709; x=1714925509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Xf4FNSHAHOETwMyiCUOZ7LYnEsnl/s6mjRO381GJqw=;
        b=MLBhkyZIiJOLb9lO3XaSaex6idFG3+CUx0EllRdxfLgSgV2Fc4yjuMT8GiQ/LGZ6md
         p9qgju01LyL4KLobEl84i9w6xGo9I39HocF72UkYosTdivHrzOHiqyGM5cTqvdOY1iMH
         8G0+EviC0D70LaQVBOuHaNDigcyXu7eEujVPaPxHldgAe9je+SMx1Wcb2KKED0MD99Lv
         LzL+bhbK7/ca54sEe+haYjox1633A5kCfN1rVbi52nw/L7A0GAxVAxX3+wm/hsgdEzyl
         Xl2qOmz9WgSxDvogkvLsOAGjPn9ehyo/xRTtf2gxas3DBG9YOp7/WyfBj4SWWRhqQUu5
         6amQ==
X-Forwarded-Encrypted: i=1; AJvYcCWraZ4FkrJWES5oMSG/7x/GWhAzn34E1e0Pug+uecFeJdVSpdaoJlVqwUD5qeq8lHZM1IBihwgnyrSskuSXhcvc4Ed5nG3iOJc7FP3H
X-Gm-Message-State: AOJu0YyKdCE5EErA6BPEDz2BRSgI0oh+CVno5bfE8Zj5/qlhTlKCHY0T
	l4ubww/TUc21ne3W4fuvnZFttBVHYWXeVoNEB2qEXsAj9OqG7aNILsl0PGWqZyc=
X-Google-Smtp-Source: AGHT+IFyGdmph8IG/7W72vEINCrzDlRkfZ8R9PRIV8GEZ9+E69vClxTdGYF3V//j122hfSWqJb9yRA==
X-Received: by 2002:a17:907:7f03:b0:a55:b887:e08a with SMTP id qf3-20020a1709077f0300b00a55b887e08amr6398932ejc.50.1714320709278;
        Sun, 28 Apr 2024 09:11:49 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id fi29-20020a170906da1d00b00a58f1eff266sm1325570ejb.189.2024.04.28.09.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 09:11:48 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	kernel-team@android.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 2/5] arm64: dts: exynos: gs101: enable cmu-hsi0 clock controller
Date: Sun, 28 Apr 2024 18:11:42 +0200
Message-ID: <171432067234.26421.4847290187146474808.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240426-hsi0-gs101-v2-2-2157da8b63e3@linaro.org>
References: <20240426-hsi0-gs101-v2-0-2157da8b63e3@linaro.org> <20240426-hsi0-gs101-v2-2-2157da8b63e3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 26 Apr 2024 11:03:05 +0100, André Draszik wrote:
> Enable the cmu-hsi0 clock controller. It feeds USB.
> 
> 

Applied, thanks!

[2/5] arm64: dts: exynos: gs101: enable cmu-hsi0 clock controller
      https://git.kernel.org/krzk/linux/c/ea88ccc17f156e9fe937812091d80fb501aeec4b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


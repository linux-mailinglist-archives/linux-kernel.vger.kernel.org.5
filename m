Return-Path: <linux-kernel+bounces-102278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3145887B01F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F831F2A769
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D080764CE6;
	Wed, 13 Mar 2024 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FNQYJolC"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D02E1118A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351456; cv=none; b=oPh81RsnEjLpc024Y1IbkYrN4SQ2BpBidEj2Pvs+nM3FB2IHSJionLTrzwfwP5ReugqmV53djaMuofAp1XycQr5cxfYiyA8T2+JTnNpqpTL96fOg322FXEd2n1OXaJAejejtKZM3CvcBXrNFICEi/ZwRkYJHrreFipWVMdarAWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351456; c=relaxed/simple;
	bh=kZVeTZdyc7DNpCD6W3Il/ao8ZvlQxa4aFunI7XmCshA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iV17fLwJ9XqSAlQOWV64wSgWlSC0nZbqEIA1pGhwhX67mJ3CN6zPy6c0tcDQmle3LaWnOyzZiiiBk21QdGSwAMEABcaN+Jh9fIsnqRUOIpVa3Blk6R5UvweiH/NrOWvYHT9Q6xphECOL+PC7Ps1cgm+n7kp9Pn+MN3IbDtbyjXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FNQYJolC; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5131316693cso173428e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 10:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710351452; x=1710956252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZH9XYoarv6NevCihCH9rFfZ6985R1tiEG+VgEsvACY=;
        b=FNQYJolC9iua/11Va/+AKxmmo6sPGqTuNoBWcr5YWPmrpgWTyEx6Ldt+B/eYhSnc0p
         Wfep4SbRynz6ePNwxR6Gv30v3n5MjHI1s7HHn55oNFN9o+cC0abyGiUpw5+F8uj2z+aG
         MqYmAXoIjN7RRWIouSNquaqfljD6WnfyepsRmgGyQpV6gGrZrT1KtNIFYy90U1ZHFVfu
         gJ3RGuue9finEkWp/qkrcYwxBeUX9NUvsprbcuZNZ5G9Y3+HHf0O6yV/j2GnU9HsMbnU
         HT3kDLEDbDjFLvatKtfzgfxytdSs73vLrnPCuNRtLgMpl9aBtxWOBcjDXU6G1Odbruir
         Qp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710351452; x=1710956252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZH9XYoarv6NevCihCH9rFfZ6985R1tiEG+VgEsvACY=;
        b=weRtMBnXapen7y8SFbQK+bNjvqudNVd90c/qIrzYCHd+I86asxeNtyrUI5/M2DJdpN
         c6cYVcF+8cUKd+xveYtxZN9zyiP9ySfcuDcKTFhYuHKgDdp4G7eJaSZb5t1eJe0T/mPV
         kh4SR+XcemDaM0ib/yIjVjmfZzH5m0fctmr8LZTSA8SmCy/x0gC/w7zFepp1Pcqo43c4
         NYF2kmhxQgZ/cT6/59Lo/Ypia9kChyJQu7d5jilanN2oTCUyiKjIiOLPJm4Gigze/Jt5
         AVoUDDqfBDhKxl9BiIVj6DDp1hZyCj1ceYK/OoDkB8hIjl4B5aF6aAGfeY7+jdx8c8iN
         TlIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVedPiJ5eW3u535BL5KxULa/omkfu0+ZIjgzLYiitImxJnrNj4A76Z5cLaH6ijtn7pp6V7Ta499+t6LZUkcFZnUCCqLB84k36kaL7hL
X-Gm-Message-State: AOJu0YynlxH5Ohk8GMQEyWI+tOCQPxG7Er1sKmL7q82IGgvJebD7m4eC
	/of6d2DyHxQ1eCwJEPigFh0KtGiyAd2ETgcSaZpBhIqlpq5xOGQXOKqMDIRDnoA=
X-Google-Smtp-Source: AGHT+IHv3EW3Wedgv4ApGXEq9qn0lh8eu6xUuhVYlrdISwb1sQOV5/zXUF5PZNcsezYZHMn9OKwzhw==
X-Received: by 2002:ac2:43bc:0:b0:513:4706:1c0b with SMTP id t28-20020ac243bc000000b0051347061c0bmr4853708lfl.20.1710351452415;
        Wed, 13 Mar 2024 10:37:32 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c4fd200b004132f9cf053sm2889617wmq.33.2024.03.13.10.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 10:37:31 -0700 (PDT)
From: neil.armstrong@linaro.org
To: Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Yen-Mei Goh <yen-mei.goh@keysight.com>
Subject: Re: [PATCH v3 0/3] panel-simple: add support for Crystal Clear CMT430B19N00
Date: Wed, 13 Mar 2024 18:37:29 +0100
Message-Id: <171035143128.792807.6928029048259684930.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313172016.387277-1-jeremie.dautheribes@bootlin.com>
References: <20240313172016.387277-1-jeremie.dautheribes@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Neil Armstrong <neil.armstrong@linaro.org>

Hi,

On Wed, 13 Mar 2024 18:20:13 +0100, Jérémie Dautheribes wrote:
> This patch series add support for the Crystal Clear Technology
> CMT430B19N00 4.3" 480x272 TFT-LCD panel.
> It also adds Crystal Clear Technology to vendor-prefixes.yaml.
> 
> Please note that unfortunately there is no public datasheet available
> for this panel.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/3] dt-bindings: Add Crystal Clear Technology vendor prefix
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/fe67bfbd23b0ccfaaa5de9f9176c6283c628cea1
[2/3] dt-bindings: display: simple: add support for Crystal Clear CMT430B19N00
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/2fbb050335f8195b86ebcdf498a6c171bba10f8d
[3/3] drm/panel: simple: add CMT430B19N00 LCD panel support
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/751b58418250a56329d35de29329f547c43e7c7f

-- 
Neil


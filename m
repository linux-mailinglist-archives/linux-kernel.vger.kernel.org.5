Return-Path: <linux-kernel+bounces-156420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E69948B029F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A357B2856DD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C9E1586D3;
	Wed, 24 Apr 2024 06:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VBwv+W1w"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C4B157E6F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941668; cv=none; b=taA2ZSQZIyzcLrmAuqcB8KaCMJ0sH1BXVPonFcaOKU90CgD3E0maZmrdRES/8Y7gXYRRLCEqALb1/+n87d2zSGEYLNRtv3hAtpcVIDNzr//Y9DyJaPrVNDinLguOu3EzgJP4FdCOOy+OwvUFUDvHbX3ZJHtV3wo8Vu0xJcYb7W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941668; c=relaxed/simple;
	bh=f0q/SCjHyB4l4+9ylReVyT+7OsDj9yahqdv4cGOry+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oWeHDOAmwMjen0ePVG9zX1ldZTW1PokgYuL1plYtYePz6QHU8ke/4FwRLugWmsUEGgTl0oM5KXe8UjIHqHIcZLx3fVjx9RuuiW1CX8qWnEFQaXn6OFWe1YF+LhwGL1R3CTa1sEXUMQxbRXCTSE6AeIepHi36uE41UrMtpZ+AZvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VBwv+W1w; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-346359c8785so5394840f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713941665; x=1714546465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRaUQ45Y0lfdRSPs57mWxmiIj6o5tQ/OckUEdj0Rduk=;
        b=VBwv+W1wsh0TXRgwqWNyJ9nAc6jhaDLehi2aCKskmBofBCRpgrGhrtPBZJMpUmTCo2
         PbepKz87g+QzODOUP5Ak/qt/Mw686iMmqRUJXfhGF5W0oifNUyrNyjTtzHB8ZP/bkPU5
         OZ/hRqV/dCbkrDeuNOirIflkRJqz8Aw2XVRkYxTKB2LtCyfztfoIpNijLz0QUUs1AVoL
         U1WHXcQiwDaJ7M4J9Rbiihnx+GjQ9wQZ7jPqxkopeYQjSzV5EoqFRtYKhcyfGGnpzqQA
         lwow7yMpwbCf7xiLCR4Pjsa6lMhWuyGc4viD9jIsE8Ht/MPhADCmX1pUv3i0l3ZlM0mY
         jK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713941665; x=1714546465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRaUQ45Y0lfdRSPs57mWxmiIj6o5tQ/OckUEdj0Rduk=;
        b=Qx53QnJ/snnB0qrHAgAOui9sYPSZ42jT/M/jKGG/Dkx2Fg/9BnCWfAhCdiEnc4wpXP
         G2GJD59x1yte6LQVNSw/vhVvHClk+fWr5eTN5MLIpwHwb/SUsEFsn0MlQrYAtcgOJ6FG
         qD2EfpbopNwVd5NzOTxmoHDTZbQ5V+fGArVhg9HE1yofVfis7krfckbJ6BDCKE57hkwk
         dGMnUGbdY+GgsniBOmNOdQM3c9TnPSRMqawpSeeRD/sYsIRumtIyS9OJGHwb/NoR/WWJ
         rhkGIYX70lYn9s0ZymSf9JZNY7tQbdTx57mCuemAOlcW/m/OP2mxkk69EcsZPYkTSbFQ
         gD1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXMBmZULV/9hN5OHHbKjIhRSuvdPr5nnJZofgQaOpY3q0mimbk5Lu6VYU5OatBMNVIcYVzeS2RlMy+ltU1rnUeqNh9MjeKOSZOe1kP
X-Gm-Message-State: AOJu0YyP2qB+iTpGovvjXnhBNJrVsFjlX7z52SRANgbUQDLAfRirrp2s
	UBxXsWvqqQIV3fJF++VZ0HjwlOv7BopBVT4vx1puVmSoe4Q/4Qmu3D67G11liwU=
X-Google-Smtp-Source: AGHT+IHTPfHRbyq2KsOrRsnnboCgi4RGpC8RuiQEReCnEX2cD9AXY1JepKvPGaDosUa2U60ZxbBjhw==
X-Received: by 2002:adf:c00e:0:b0:33e:800d:e87a with SMTP id z14-20020adfc00e000000b0033e800de87amr815222wre.34.1713941665228;
        Tue, 23 Apr 2024 23:54:25 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id t18-20020a5d6912000000b0034997769ae4sm16338534wru.15.2024.04.23.23.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 23:54:24 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Khuong Dinh <khuong@os.amperecomputing.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] arm64: dts: apm: storm: move non-MMIO node out of soc
Date: Wed, 24 Apr 2024 08:54:12 +0200
Message-ID: <171394159880.43787.1062999487824080581.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240402200818.79446-1-krzk@kernel.org>
References: <20240402200818.79446-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 02 Apr 2024 22:08:17 +0200, Krzysztof Kozlowski wrote:
> Non-MMIO devices, like fixed-clocks, should not be within simple-bus.
> 

Almost a month passed, no replies from maintainers about picking it up. Dunno,
looks abandoned, so let me grab this. If anyone else wants to pick it up, let
me know.

Applied, thanks!

[1/2] arm64: dts: apm: storm: move non-MMIO node out of soc
      https://git.kernel.org/krzk/linux-dt/c/0fbadd0568e4dab360d4d3092d236ce5fafb24ed
[2/2] arm64: dts: apm: shadowcat: move non-MMIO node out of soc
      https://git.kernel.org/krzk/linux-dt/c/4a3e011b7b9955f030df1423c7a54f7e4bd874bd

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


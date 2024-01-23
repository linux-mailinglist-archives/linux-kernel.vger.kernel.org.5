Return-Path: <linux-kernel+bounces-36042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAC7839A9A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9765BB28E56
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0D1539C;
	Tue, 23 Jan 2024 20:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gs1OgDRh"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904675250;
	Tue, 23 Jan 2024 20:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706043438; cv=none; b=QMzO174EVuNExjE+2n94vzZUkrPisfmbaeLjNBzDH1hYKkafS5EOd/wmetM+eHdD2cBLX0I+iXQ5fZyxJfW+ZmH4OatG/h+EFQ5KM8L8ZPgZHPs4KAdhAu136fHOcMe2BBYwDHShHaBF1BrhvefjToZMtSYbqIDohre6okAaXnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706043438; c=relaxed/simple;
	bh=Qk3x8dqsv1qQiDdx/sUfNPuTrucAaY1crd6XyC3bwAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQ/0n1Bz5+keCyaGmyW393pM7PIS1F5oXjXwJvIvMwoy94IUHQEg2n8Z0OwDXO8diQqQssJiDk9IhabnvkQevVOVKs8NuzxT1FSkRctBQ2E24Z+XHV8AoI269RT8OGDENa9Xb9FcKlEIZLiJOgTQdSt1jiLPQoQPlIBLwHpws5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gs1OgDRh; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-339261a6ec2so3147048f8f.0;
        Tue, 23 Jan 2024 12:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706043435; x=1706648235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/zvyCf7Yo4bMfKCjWxvWf8T9kOG2qLOCH9hQfg6UWw=;
        b=Gs1OgDRhdF42X/sSL9eS3JSrcds7M2a0ZrmDu7BLYDIvYt5vz+VD403gjQboxFxAqa
         y2275JZ6YTEDtEc2nQWLq4Ov3nSKhQY3Zn+dwabMRaqYatmf2OOz3JkkAYt5fPZA5NpY
         Gk/bjbkmQITsZUbjS8qo3yD3i75DO2LCo0PFPDQkSP5f1CQaogHEdT1KQp1rhy/gO7Rs
         R2p4r+JImKKAk9MJcUVubQDMwRNmy0QgUC6DFRf8paLTTSj+qv9SuW97wJEhBvCnswhb
         oESBzjYQ3g/OQ+j0yAgKtzQfNkqt3AzlGR8FXok8wzYEvK+21Cz/iIOkIFMUaQnqgO+e
         HBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706043435; x=1706648235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/zvyCf7Yo4bMfKCjWxvWf8T9kOG2qLOCH9hQfg6UWw=;
        b=ZQ9FRpfnGUyt+obvhEwU0dFGmRdRPA6KJy1B29M282SapCTKprKtW6m2RYm1vgFMMd
         16XPWyNmlCEps56t8JwHG7f8azLhHyei7V0ls2Udx93W0KWlp7/v0QE3OyjEldgylhr0
         p8qwxS2Y4Y0w+5yT5n+gvfc97DTrW3Pz2pL8crDJR3V5pM5/5M75hGM2Jn7RQY7mbH8C
         r/IBU5pk0VTQTyq+zdVG92esWJrg8H83ogphmoTkqVcK7lqJptCdmxSFubZEhelgP5O5
         dUOyVUAck0AVs0YGi64iKF7mZXiJsAL3nX9Ct8fEPIAvKhzfmDSs85z9J1q4Bz4C05+T
         F84A==
X-Gm-Message-State: AOJu0Yx/9smP/mF7w8g1xf5gf6x21c702EAjF9VT3hbzcay71Ge9tAaM
	Ab8xaxCkPTKK5Wnh11SGCg9mloOIASs75kVM1LOydI+DF5G+mPzu
X-Google-Smtp-Source: AGHT+IEGWVDOmhMh2CcmH98qX/zmGj+R8TRFm5n1pzOFRnjzDpwsw4e2BFNlV0MLjxy1vjY03h6c9w==
X-Received: by 2002:a5d:5f53:0:b0:337:c288:2595 with SMTP id cm19-20020a5d5f53000000b00337c2882595mr4433474wrb.78.1706043434520;
        Tue, 23 Jan 2024 12:57:14 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-14-70.dynamic.telemach.net. [86.58.14.70])
        by smtp.gmail.com with ESMTPSA id d21-20020adfa355000000b003392a486758sm9520919wrb.99.2024.01.23.12.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 12:57:14 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject:
 Re: [PATCH] dt-bindings: sram: narrow regex for unit address to hex numbers
Date: Tue, 23 Jan 2024 21:57:12 +0100
Message-ID: <9225339.CDJkKcVGEf@jernej-laptop>
In-Reply-To: <20240123083450.20996-1-krzysztof.kozlowski@linaro.org>
References: <20240123083450.20996-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne torek, 23. januar 2024 ob 09:34:50 CET je Krzysztof Kozlowski napisal(a):
> Regular expression used to match the unit address part should not allow
> non-hex numbers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Merged, thanks!

Best regards,
Jernej





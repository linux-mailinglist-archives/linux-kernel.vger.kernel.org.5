Return-Path: <linux-kernel+bounces-156425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2588B02A9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F652828E9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0DE158D84;
	Wed, 24 Apr 2024 06:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VQtu8hvb"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15956158DC7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941675; cv=none; b=GVxOmL3329FX5ehCTvyscOWWIr2w6kLkJbSzDIjhSx7j4f1V9NidH9/yVFAVwiTvRo/+PqNMS+rrRDgDtbmZS8M1Ykhjzqpt0abG6MOw0grC0vEPnlhRX2B8Ei4P0uaUxepq1HdDUrhosLLrNaM9x+vvDOM4Yf5iqCZefjblIb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941675; c=relaxed/simple;
	bh=KiZGqCJkejFHYHtqQRdCaSdnyu3r5yGV15Z4OjCcx9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qLrXnQRBW+L0t0AX03yLQnYK4++IFBVCPiZjFThrDfcNSDq5Xp2Dlqg/94RMWJRjRTGdiXJVry5WuCtJfroNX/ya1ogg3nfhL2mMGhonwSVmzdhH0nilcOCeAV5H1woPDCkS4apT3R4qaTjPY73AoMuQkINuQnre9+jpVZtt8b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VQtu8hvb; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34b66f0500aso1553014f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713941672; x=1714546472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3TeAm5A9mIePQuh7eHFd41oN1Sej5wKawK2CqOUpb4=;
        b=VQtu8hvbZaeeEgJ2CgiaPevrapJpMRiLbDSA0hjz/jk/l9BtoooWqbqNBsUXIja33f
         U5pLBP5nGPSPFR86vV4GS1WeylnKwpyo8bu1jGk+fp6mFY8c76gj+sGzIulqV4qixR11
         eE/PSEl5qGIl2lpvi4g1cFiRy2ip7/tSXrxDrIy95/3k9McFj5xxnzhbdEYds5YbkJbV
         IGg+0qgnCaeA1BpLPE5LkZJqCPDCHFw9m3h7GkYPZOddDof7IcpgYMOHDNy6PUeORSxU
         Xy0DTZxNFC1ca9P/M6yDPPPW3qddPqY3lGzpJdseEV+55LDfwOlkgai131hq/VgCy1b4
         Xojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713941672; x=1714546472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3TeAm5A9mIePQuh7eHFd41oN1Sej5wKawK2CqOUpb4=;
        b=F7eR6mn2i5KIpv4IPyaT1GQA3OTaMccVwNWW3z4NLHpH0YSR0sAXVZ1NlGvyijqaPT
         PyKpdr7McCqgMtEip1JE4VKpSFaUsKbz7bxI9YRzOc3x6ysLJBV3gheJhpW5nQG2neIt
         yRV4Q9gyyIQ1oVSaq6T5NNRChTfvV/x4uvaf0lCPZjWnd3+36CvL+mctPhR9biI0tfCQ
         mrMLf92QPGOAWhKpz+OnrTcnxKGwZuxsH7QcWOjGMR02ffgpUXbDX1uTA7x+Ke6JR2iM
         du2Zae6I9YPiIXvlg9pfEQnSBzMCzyjJiOduVEZ2+O+M2avQiNCS5VnLdX1kkWBAuEBh
         1bBg==
X-Forwarded-Encrypted: i=1; AJvYcCVRsQAmyIwFcvtuFm7QMXvKzjpK1VQc1/aRli9ogKggKnOpobl/pkoMvZ1StVqydXFBZVuFvI6dPwjZdoKatjUIfU/AcgHVqDeYTft0
X-Gm-Message-State: AOJu0YwlZiCFjWE36mXtzfqK5DMz+XtHL+vMqu91YsIAfGvhdiOTr+gg
	3HuHLzj46EUufOoK8bSM9KJILIfNuxWk46RDla+HM8MoKcTODAfL2gneV0XB9jI=
X-Google-Smtp-Source: AGHT+IE9AVXvlCGcToH9YiE2OC1NtyBkLHlUGA1GP639BRwyZEl0itzdMuBGifA4jGIBwqbrv562vA==
X-Received: by 2002:adf:e352:0:b0:347:b501:477b with SMTP id n18-20020adfe352000000b00347b501477bmr837865wrj.33.1713941672467;
        Tue, 23 Apr 2024 23:54:32 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id t18-20020a5d6912000000b0034997769ae4sm16338534wru.15.2024.04.23.23.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 23:54:31 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/5] arm64: dts: sc9860: add missing aon-prediv unit address
Date: Wed, 24 Apr 2024 08:54:17 +0200
Message-ID: <171394159879.43787.6202891863696784201.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240401141128.98317-1-krzk@kernel.org>
References: <20240401141128.98317-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 01 Apr 2024 16:11:24 +0200, Krzysztof Kozlowski wrote:
> Nodes with "reg" property are supposed to have unit address, as reported
> by dtc W=1 warning:
> 
>   sc9860.dtsi:210.26-216.5: Warning (simple_bus_reg): /soc/aon-prediv: simple-bus unit address format error, expected "402d0000"
> 
> 

Almost a month passed, no replies from maintainers about picking it up. Dunno,
looks abandoned, so let me grab this. If anyone else wants to pick it up, let
me know.

Applied, thanks!

[1/5] arm64: dts: sc9860: add missing aon-prediv unit address
      https://git.kernel.org/krzk/linux-dt/c/2c20032e1ed34edee457c64c266d2c5bb1c52fc5
[2/5] arm64: dts: sc9860: move GPIO keys to board
      https://git.kernel.org/krzk/linux-dt/c/74be4a8d52fd49243d7c533649d2ebbfd0f34f97
[3/5] arm64: dts: sc9860: move GIC to soc node
      https://git.kernel.org/krzk/linux-dt/c/653f383e7c02869792810244c94df468e4e322b1
[4/5] arm64: dts: whale2: add missing ap-apb unit address
      https://git.kernel.org/krzk/linux-dt/c/09dddc24eb359ca82b2ae526d3b51583130f4f07
[5/5] arm64: dts: sharkl3: add missing unit addresses
      https://git.kernel.org/krzk/linux-dt/c/e80ab9c9782b8928c8a1392eae7ae52445bd3881

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


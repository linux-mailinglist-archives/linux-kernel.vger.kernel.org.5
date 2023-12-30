Return-Path: <linux-kernel+bounces-13519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A9D820796
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 18:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4031F214AC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 17:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2A2BA40;
	Sat, 30 Dec 2023 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiufmAv6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E5BC2D0;
	Sat, 30 Dec 2023 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3f8af8297so29084565ad.2;
        Sat, 30 Dec 2023 09:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703956642; x=1704561442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKuUOBW2WKM7L/OUaH8vZcmfejQ/Wt+Dd1qvXbLrpms=;
        b=HiufmAv6+BpULbI5tTCqwIG5LBHFdpCejhUDjQ7pT7Ad5LjpmTmtx9MLuACLXVIiIm
         b9O4LLtYnBDxcecC+jrhJR4y4/pddr3pJoJ9omEW8WeqGuEWgMMVFt46GGsEumMI1Pm+
         RhqdihRDIeCabXkkTc3MlKOesoX3mmAn1WVcH2GaRx+SNPrmuZLKPfqNAiiwulC5nmQT
         V2m9ImjipECiSGeZbFP/ChM+TWAUd25z8822xT/TQDnnYcQHi5ibfsxczgftGgV7GYNF
         in8hBF5h+FUFSA7jE2R7SaWZpXxYxmYJDP/GHN8+iNHOvm+ioVmAZ2bOmYXX7Z0G5jLa
         DhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703956642; x=1704561442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKuUOBW2WKM7L/OUaH8vZcmfejQ/Wt+Dd1qvXbLrpms=;
        b=HyNQ7znW8v3RjjhZovS9XGLXtJwh6N2/rhLNq4fAmxxBqpp+8mEdaYAsb6EYkf6+HD
         5tHPjkSz+/gApC4ius/S9Ux4/e0ZXtJEnxik5lk1toij8u3CundtmneXQ16SlYzUGgp/
         UtNHBxM5zFnfTAPPi98zReycdFVcouK9ZkyPmXQXfi5WjDckGx7aTglLeCdVERmePWSY
         x5CB0D8WFtWF5nCGtBpCYEc/C1wYEA8fmiVk8SZ4s4o8YZh3YbWQILCah5r0FeNPngB2
         FxVTj+v6FfKY4fPha4IS/KvgxqaotesnDG42L/fzGWmHqoyWNV16X7KL5yj2W2Y44uXA
         mEdA==
X-Gm-Message-State: AOJu0Yy8Flij0Lm+/RlYgLmBwiH9po1qhqvVJdNtyEI+KbOQHVVYrhY5
	OrZNft5/dsomSH5I17DIuZPUb4DT3J7Fi8Fz
X-Google-Smtp-Source: AGHT+IFTYxLGmFHYKwM+FFOypakP5F+gsWJtJQduPKVjqb5KvG/4MKZ96ZeM/sekpP7W6B62MPuzSg==
X-Received: by 2002:a17:903:110d:b0:1d4:8512:5871 with SMTP id n13-20020a170903110d00b001d485125871mr3675265plh.27.1703956642353;
        Sat, 30 Dec 2023 09:17:22 -0800 (PST)
Received: from localhost.localdomain ([2408:8207:2540:8c00:9802:680d:e03a:17cd])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902b78c00b001cfca7b8ee7sm17487385pls.99.2023.12.30.09.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 09:17:22 -0800 (PST)
From: amazingfate <liujianfeng1994@gmail.com>
To: krzysztof.kozlowski@linaro.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	ezequiel@vanguardiasur.com.ar,
	heiko@sntech.de,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	liujianfeng1994@gmail.com,
	mchehab@kernel.org,
	p.zabel@pengutronix.de,
	robh+dt@kernel.org,
	sfr@canb.auug.org.au
Subject: Re: [PATCH v2 3/3] dt-bindings: media: rockchip-vpu: Add RK3588 compatible
Date: Sun, 31 Dec 2023 01:17:11 +0800
Message-Id: <20231230171711.3912776-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <02e64f0f-6add-4583-9ee4-d5ace6497776@linaro.org>
References: <02e64f0f-6add-4583-9ee4-d5ace6497776@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

Sat, 30 Dec 2023 17:06:48 +0100, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>Your driver suggests it is compatible with 3568-vpu.
>
>Also, nothing in commit msg explains me differences against existing
>av1-vpu.

Yes, this vpu is exactly the same as the one on rk3568, so we can
make rockchip,rk3588-vpu compatible with rockchip,rk3568-vpu, just
like what we have done on rk3188/rk3066 and rk3228/rk3399.
I will update it in v3 patch.

Best regards,
Jianfeng


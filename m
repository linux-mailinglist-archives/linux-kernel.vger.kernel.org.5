Return-Path: <linux-kernel+bounces-75592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF6E85EBAE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE3E1F243EF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80B01292D7;
	Wed, 21 Feb 2024 22:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbkLrD9G"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B2C127B6F;
	Wed, 21 Feb 2024 22:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708553574; cv=none; b=B71t+wd4dGhZto/OFpPlBkreCFrAOLCRa2KFRGt9z+rSwtTN9MvCswFC0v4QHy6uF9M17du5scxLW20c/5alwK+KJ9e86BqavzGqrf6iCXmLj+/IMLq+skcQ5SoY9Key6IMX6C2nYeZuAZmpt8ifAQvgnjm0WQsrMPwuRtDw1pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708553574; c=relaxed/simple;
	bh=RhFTKg9ao3rZOUrt7OqVKcCNafpR0iCJP/rDyRvJXM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e2ACYimZDr4eLGTCsw4y1V+3jHJ/akkQKJzv642n9KyP6i5FPRWfKKAolTTcIlAgiAmUTO2utH3+MNMDo8ZTcf8uwoh7VvQpu3OXiTOWzJ9wa+2TR9Wehg7LHBoprCxmxVWmSk+pFCSxmZ3VMBWIlSzZ1GEFLD4sm0rx7/zdACI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbkLrD9G; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6e080c1f0so6792624276.2;
        Wed, 21 Feb 2024 14:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708553571; x=1709158371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zvHohG/osJUUJ6MrbAQ8TEaNGcUB4t0Qr7/JkHGHUIo=;
        b=EbkLrD9Gl5VYLj5TjQDyrvvX9HqdEBDqpl87b1p8tMfFOrQH2Ky6+VaCkGnBbgJKIG
         BPjJzS1DrYyFlizi4qo06aHfJNBcDcFALXBN7Vgo82LiKMZbkU1OqQBcwc/CvbF9O+Yd
         LDT4ySEIO+JpQzWrnfRvUsDse58/+rwp7wojzUVaaunFx18WntIGKtAHgXDV45hHlBgm
         dv2Yi1D4yzcfag81r98sCilD3vzHJnQpOe0FmDoXclrxKHnBhwmdXCs9pujiLC7dwqN0
         VsTgZ6NCfXgvYHO0lVcbKpe8W3t30tUlyLkGW+1j3o2/9WdMmavHuNVqWsLggDkxVVcZ
         GwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708553571; x=1709158371;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvHohG/osJUUJ6MrbAQ8TEaNGcUB4t0Qr7/JkHGHUIo=;
        b=AJ01ore7ylOjk6CC8jVKB18HYC0O7gEZ2dOmgbe79Nm4HOQaE/L9i30DVvONv0041K
         eUWyrBZd9NlOyxQflu32o8xUPtLPF1XQuYfuk0mVPBebGsIUs+IT1FQ4k6tpJL5Y4qka
         Xng3rS1RVsOE3zwbSpXAGZhqMZW1hlTMulvLXlSye35qxVGONnz9gGtpvxdYrY5A8Q3m
         bd4O0YgzqIKlo7PnvG+fayhgD6Ao6QBU6LLUAcbvvCfHPNIsQeH1eVL8J+ONCXBoNHwj
         r22kd4oRA3X2WJGoJBS8Ls0V6LYEpbxCMmX9n3HxvmcD2Yh6j3FudhO+/ELKbQq2GazD
         Wenw==
X-Forwarded-Encrypted: i=1; AJvYcCUt+WQ3ExwczNwT47hcJ6XJAeWKVv0Z9f41bE1CPyMtFEG8X8w/F51jAkpfBfjTyECsS+813E3eGSt+IkTFjxIUj5TPMd1LFu5uvmEIsxjyR56+jVjxLK84lNkCa9qHyLvJR3tTSbn7jBn8kQn1B/ZeHNN9/geCZmCn4jJhqq5vRWxWZtzfBHlwfkDURqd3bSzvOh2wfBsFrVt6RQHMX1ox1hMM4x9ktVUREJx69uyp70KpYcetjMv88Le+Cp9m1HVxL2HmmqsYOFcCGUcKgMgfcuBtUxnBNAFSFRmx6a0CCoZusUoXL3Jx74iIUbLg6QLv6n9ElcWappWwuEhphWo576U=
X-Gm-Message-State: AOJu0YwuBB52KlfA5/86qoCjJNRAGIjgfE9KzAFvnsemLkVcbUduzc4J
	FECSFxtMMIZWu9Gxq0EIM4sma2Mok2ooJlqs1CHKr8gQifYEIjEp
X-Google-Smtp-Source: AGHT+IF7kP+13CFMgvNV4rXPEp1sBAjlnfLwnWDRvHGUt3wwBoE4opoEpDnOPFhvcnuSrbWo1HtsDQ==
X-Received: by 2002:a25:9346:0:b0:dcc:76a0:503b with SMTP id g6-20020a259346000000b00dcc76a0503bmr692068ybo.13.1708553571608;
        Wed, 21 Feb 2024 14:12:51 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i19-20020a05620a405300b007858c17df9csm4712295qko.96.2024.02.21.14.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 14:12:50 -0800 (PST)
Message-ID: <69a0df59-7d27-406b-b0a0-3e43f18b20bf@gmail.com>
Date: Wed, 21 Feb 2024 14:12:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: constify of_phandle_args in xlate
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20240217093937.58234-1-krzysztof.kozlowski@linaro.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240217093937.58234-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/17/24 01:39, Krzysztof Kozlowski wrote:
> The xlate callbacks are supposed to translate of_phandle_args to proper
> provider without modifying the of_phandle_args.  Make the argument
> pointer to const for code safety and readability.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com> #Broadcom
-- 
Florian



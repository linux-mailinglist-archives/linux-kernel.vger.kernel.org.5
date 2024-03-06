Return-Path: <linux-kernel+bounces-94703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEF18743C5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3236DB231B6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98761CA83;
	Wed,  6 Mar 2024 23:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjiekEWu"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D928A1B7E4;
	Wed,  6 Mar 2024 23:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767156; cv=none; b=cnwLhfQKPyGrr/xNZA7WSOlN4l6YiT0dXMfww5lAS9Y3JhVCERs6DMdyzEd8avPLln3SftkkQA9ZJSw5wgBWqXSp/+KF8rFQakNDsqNf95Vbs8DhCRkp12W1BYGlqYSNIfP4f1Zr6GOP2wiDUrXqsisbQK6eIzNrTZkqc2OL5WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767156; c=relaxed/simple;
	bh=Eet2uY7R5yoExtpUg1dh6EqqYShuHUN2ekYNffXb8SY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BFBVcFQo8JxxUgj/vSUGlZdsy5P4tmZUsDutVerztZrB8xObZfsbxV6cxU59GIzGj7+2Jxd80NSe9E0KleY8Bg660zOnk8dwnBRicSMXCag1kxpWYvjmjV1xb2M8JA+mh3E2AekXGQ2WA6LTdUW40hIfDRBNxGOcm+C8FZmwxDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjiekEWu; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso206232a12.1;
        Wed, 06 Mar 2024 15:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709767154; x=1710371954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NX6Md+oBn19ih0UZU2ErF+IlZhbJrOPTDd81R9SSQ8c=;
        b=IjiekEWuEIRnrN8h/es00gakQ/FVE83Zq+i1Hbe/22NSSnzEbH9Xns4azhsbSI/O1U
         D/H+Ia6Qk+Ou4I6xu5Mvcuacwy7rRq6sOOxfQbG3m5iaMdwn6bD0AaisE1wRO5ger3/3
         z3tDY1auvPCMfgAbTcL6LJkqULwbUCtgBJoKrfC3+jUjI20seq8aip94H33xO8Bevvjv
         RRknPFvTzg3b7z8cYVBEUhkjKTlbaC2NGVl4sA1BPzFaNZsmeogKsEcJA2cwrFdxa+qT
         Nbnw6VeJy2QfI7zRJS3xlZ62X9at8BuyANvnnJtGL3LEpFwddREKoKeh/eIDwPv8w78P
         Budw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709767154; x=1710371954;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NX6Md+oBn19ih0UZU2ErF+IlZhbJrOPTDd81R9SSQ8c=;
        b=Zrpg6yihk6eFvKAB/YG6YxaN8kOgyjDIwP31TiLxRxK46KWPISR2PArIaFM5hBea3+
         21roUGVji7mwo+V+5BRalJl/TQRH4P9qlFeXfmkcWQuDGnZnVEUO+wmWXwXo8rCmLYam
         pk7eEdC2S3vKY5sJOaFLKth8j7eTfVXej4/ZQaVWlXZJk0CYNCZA6MEBQ8n0Yo91oI5a
         X8lU4XHOUVSK1IO3ptzYkcRxW+7NS//xmYuD/IsXoGA7/mop7MJwRMwFVITTt9gC1O3N
         2A04x0t6i3AaX+I4WXnoOlnOp+8TpB+xkKUqU76IHIqzsirJMucnHFbbKiFDLsmOk/uq
         5/TA==
X-Forwarded-Encrypted: i=1; AJvYcCUinUvjTDyciKyboRdrQR7/U6C7MPT/bNMxNVs20OCP0kQhyFAd7r+cJTzdEbnzjJERj4C+BSQvBnO0+VcjwrcdZ6cN6lnW6A/t61ir9aStqXWc7f0L1M6p1/Vh70v1FC3DAW1s
X-Gm-Message-State: AOJu0YzTjxU6hPkFDWtfX93M8dgNGElqx6D1BlZmfOQh5PrMKT3Vz84Q
	+QMhSBkpyYOrwolLC2QS0OlX2c9YWqg9AQqAfwcdh6rnaia3nXUd
X-Google-Smtp-Source: AGHT+IGrk51RqG7G3WgvkCOZw8X03D+lNiySvon8QElRp5ur1Wp6VbX5LJAc57RUiPPzU+mkOe9UgQ==
X-Received: by 2002:a05:6a20:2a20:b0:1a0:e1ac:c4a9 with SMTP id e32-20020a056a202a2000b001a0e1acc4a9mr4974296pzh.60.1709767154113;
        Wed, 06 Mar 2024 15:19:14 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id gd10-20020a17090b0fca00b0029b22d8f5b4sm267293pjb.15.2024.03.06.15.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 15:19:13 -0800 (PST)
Message-ID: <fae80c13-ae97-4455-a024-7b7f40a87f25@gmail.com>
Date: Wed, 6 Mar 2024 15:19:10 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 16/16] net: dsa: vsc73xx: start treating the
 BR_LEARNING flag
Content-Language: en-US
To: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org
References: <20240301221641.159542-1-paweldembicki@gmail.com>
 <20240301221641.159542-17-paweldembicki@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240301221641.159542-17-paweldembicki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/1/24 14:16, Pawel Dembicki wrote:
> This patch implements .port_pre_bridge_flags() and .port_bridge_flags(),
> which are required for properly treating the BR_LEARNING flag. Also,
> .port_stp_state_set() is tweaked and now disables learning for standalone
> ports.
> 
> Disabling learning for standalone ports is required to avoid situations
> where one port sees traffic originating from another, which could cause
> invalid operations.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian



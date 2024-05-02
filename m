Return-Path: <linux-kernel+bounces-166534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 654358B9BEE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9F24B21F99
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D476B13C683;
	Thu,  2 May 2024 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qv2StT2x"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9572475817
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714658268; cv=none; b=TP8bR6V68a844gkTdlk6wK7uceLdT8jqKKSJYQ93tAiVP3fl7jY0GFV919fxsg+zk/tLk/b3/jF7FGeWY04sDhg+IpS6gPkSumZEOrMUmnYTbygUgkITnliFy5V3fBJaf3zAYP5ukZHB5sE5+1XtHOp08tUcEXWe2GLnhAi+qe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714658268; c=relaxed/simple;
	bh=vfyWc1VZzTfDoelwcRKZQNr1/eIW7SJJk68PofOqXkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDDu4xO+iUWh5b0HzakYT6cWGifD7VaGXggyOwvlhOWiCUCm4ZB67+vDmxEd6o2cQ4IbP6nkHyShXhs90HsCwkh2yate5E/HbdJsLeNIkj+sfUHRAFj5rXIMsZkkZNdFso5yroKYA/X1tpEE81F03cIuOStl/riYZAZcxLVY8eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qv2StT2x; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34db6a299b2so1554249f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 06:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714658265; x=1715263065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GlYIl4QUqH+L8aj9RvYS0t2bm4V+sO0EPOMcAswsROE=;
        b=Qv2StT2xA2+BK8/C5rAztS3Q73zPc43n5HoVNrvQ8PnE70EOc47bZ/1X+TDIJVn6qh
         lmUtKCwvmGP2bA4wKeLlo8aPKGN0QGf1kT7sB8+BOiNqHJAqLI6Xo6TF3qFjLotGpQG1
         4CDNiPI2jpa3DR6L+0tYGkET6ZaJ4Q+pntEgD5jeM3OTT9LOvSzNzCfSFshgfBENV3Fe
         QbN95tozjLGS1JzF7wzlYVPOf38eA84Y34lfV+O+6Vgr4XvSjyhMmBZf12yMld4ctQ1Y
         mOAurAVeickMrJlYSY5bBQojdtuQ7/9lnACnpsiAEk1fYhZPQotsCNo4oV2hkHweBgXK
         TKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714658265; x=1715263065;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GlYIl4QUqH+L8aj9RvYS0t2bm4V+sO0EPOMcAswsROE=;
        b=mSnc6h8cRwNvYHl0/+0jD9fWz2HzQAan8kjitJ0HAcGRQyBUa1xG6uaF/oFC0lVVVu
         sShxX0AlcQP36X/4y0XhJLI1o0MGDVYnkY9QfxukQEENs5fdOaNbYZF4tHV7Zhzk0zre
         IZc6cCmq5Wh7vwzDJws72k0d8d5Z7SHBkxxkqIG5dOcjOCDZWc2wqg7f5ehMoaR+LMB5
         i62Yo08HUSTXY+cleuD849RgmqjezrLgLiruqTRFOO6jUWfUe51lVwuZ7RSQpLulZeQy
         56Bbar0ibsaUJWncDQsb6kfJh4dZbpsw5mDt/cKhvagEB3ekGQIYKJFB6GPWEI3/hn33
         XHPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfZ35AI438KCbcFTD2pfigIa/6WNMYO+ihwJKogTr8C1rRCFAelNUB25gIgzDD2FHwzUHA6kDZYm2r+izkDJ8l77k+Lk1cFp4cTvPV
X-Gm-Message-State: AOJu0YzvrNjNX2S3AGBNi+qsMgb4WvvPLpX4Z3jlUCgMYnBK4G91tIya
	eH7E5WP0lewoF4MDq+QEotO47/DS3JBZa2Ag0Spmd2e/KRcbWTqZhi6VudFrzW8=
X-Google-Smtp-Source: AGHT+IGhNquSlVMoOQFiHQHlaLnh4HUaJZiqdBcphg6JrG5dgU2hqq9lotGnLRJR4+p88MqH31hAOg==
X-Received: by 2002:a5d:4c82:0:b0:34c:a95f:1114 with SMTP id z2-20020a5d4c82000000b0034ca95f1114mr3385145wrs.40.1714658264640;
        Thu, 02 May 2024 06:57:44 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g1-20020a5d6981000000b0034d8b0b5329sm1326508wru.87.2024.05.02.06.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 06:57:44 -0700 (PDT)
Message-ID: <63cb0058-0222-40e4-aa55-6fa59e0196c8@linaro.org>
Date: Thu, 2 May 2024 15:57:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: Check NULL ptr on
 lvts_data
Content-Language: en-US
To: Julien Panis <jpanis@baylibre.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Nicolas Pitre <npitre@baylibre.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240502-mtk-thermal-lvts-data-v1-1-65f1b0bfad37@baylibre.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240502-mtk-thermal-lvts-data-v1-1-65f1b0bfad37@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/05/2024 15:46, Julien Panis wrote:
> Verify that lvts_data is not NULL before using it.
> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> ---
> At probe, verify that lvts_data is not NULL before using it.
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog



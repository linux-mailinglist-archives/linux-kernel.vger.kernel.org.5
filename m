Return-Path: <linux-kernel+bounces-81258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C03088672E0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1AC21C21ECC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FB61D531;
	Mon, 26 Feb 2024 11:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g6tuYFyj"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7C41CFB5
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708946344; cv=none; b=RiZkIYMniFsXNcg8QMfqJ+c/o1CWAhBJr6apbWoQHL9tejv+9YK55FAW2Hg6ZcUtMRvPfNVfffdAneKiHAQL90BnXG/Ixgx+JHa/UBTTLvHQlJQ1aT65g0dqBo7sSKAXhYX7BjFE+J93MJx3mXdKy4Fo1yDKJGDztPrjJbhP+sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708946344; c=relaxed/simple;
	bh=4wyKnKQTn/ilBUNl2FlB8PmwSnEw65DtGt/KiCnZ25M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmPlBQtxNeOHNKXXK/m4wSBTdffXDdvrOpy/LW/HrVqg8RHBe39dAAuPkUwq4JBbuR/5GJXzE5Q9d4tLIZVapTI/XagENWxQ7K5P9Z4mUVAzoAfNSaRFyBkSoTunJnLLHcllo3G7zdJlXuOXRr9W8VPD0JTh9lSIA+9inMG4xy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g6tuYFyj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-412a5ed5a25so3243345e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708946341; x=1709551141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EleSDnqn2DmNGxFOm08Vn/gCFQneKHwfcyjKv4Zvj64=;
        b=g6tuYFyjnZtYkMCzO2zh62YdeEDIqinUyvuUFkajm5NpQpQlWwoO/wHQrmjfsAhzj0
         INRIgA3v4E5wig8t10faJSIn2pyCaYlJ71w2Ns1JEvknDxcXAvWstCxbPWbO4b1Ha5BG
         b2274oplYkw7jt3bFSB5d8rsGtJk5VqX2MSw+1RyKez+Zpo5P7zCzUesSsy4ge/2qW4B
         Plklgh3laM1VfQo9VEw9A9IteFHzrHJd4LcNrUMCLbotnnPBWg+Lv0zOLwXk+mFrpipd
         AIlsN9gM93bWZ08Y2tEPpT6Ajw8tFuyDdOpS5fr3wvf4QeKVuGORcBwohCUE3SkE/dVq
         yxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708946341; x=1709551141;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EleSDnqn2DmNGxFOm08Vn/gCFQneKHwfcyjKv4Zvj64=;
        b=J5pI5oI7i4u4bnFcYk5gTECPPRellNyy+Bvl/wQn2POLGDa+6maS8ZrQcqYDuIYB/H
         K1vD8SpZMnhWh/bey++ci8ZRp9y1QxCJbz/pCQR8S1SLYok7P6rLXZXYvOXFwAFzSFT2
         d+UAgUztdTTve4zuTaWcXlpNZSdosA3qLwmkvn6o/Yvzx0QBtWdZsRem8IGfXQLgspnE
         QJ7tMcMIog+Q26N5qwU+1CVrjmP3uONMTF4mCv5E8Hd8FgGdEKdyEPSADb1ZdPqSuIcY
         8cfw79AEX46l0mQ/cLp+y6GhlPMZmQuhJZOJtEqAx789ShHsU8aXfxPYawd6kDz6WShV
         BuSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSsmajVHviwjl7FRQKmgr5HiFpB3Wm/KXPUUSDz+PwM8NhVlTLK78LwdeyCZ4q3S747FlV+8yPEG4EcZtf1P6a4AFeHNZ1ziB1n6yO
X-Gm-Message-State: AOJu0YzmCKdw7ck2tmi4XgoOWIY2RwXwjYkHVGiGcRUU8FuoGicjBvGd
	xNmSFq75Oq+u1AJpHZQK4PCGqPGET8rU9Uh5wmMzftSW2XjihwU7g1In3GRTl80=
X-Google-Smtp-Source: AGHT+IG3bdSVmimZkbgrLNvgYK4xA/yulode1gsew0jXP7RW4d2NEJAzN2NusJojTmT0EMFr2cTDdQ==
X-Received: by 2002:a05:600c:4e91:b0:412:a04f:7f5 with SMTP id f17-20020a05600c4e9100b00412a04f07f5mr2908198wmq.16.1708946341160;
        Mon, 26 Feb 2024 03:19:01 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id r1-20020a05600c35c100b0041228b2e179sm7933257wmq.39.2024.02.26.03.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 03:19:00 -0800 (PST)
Message-ID: <2a017b4d-f437-4752-975e-632b0293061e@linaro.org>
Date: Mon, 26 Feb 2024 12:18:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] clocksource/drivers/arm_global_timer: Three
 improvements
Content-Language: en-US
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 tglx@linutronix.de
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 patrice.chotard@foss.st.com, linux-amlogic@lists.infradead.org
References: <20240225151336.2728533-1-martin.blumenstingl@googlemail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240225151336.2728533-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/02/2024 16:13, Martin Blumenstingl wrote:
> These are three improvements / fixes for the arm_global_timer driver.
> 
> Changes from v2 at [1]:
> - add patches 1 and 2 (which is why this is now a series instead of a
>    single patch) as in the code review process more issues have been
>    spotted that need fixing
> - remove "psv < 0" check from patch 3 (as this check is now impossible
>    as patch 2 makes the variable in question an unsigned long with a
>    check for zero and returning before decrementing psv).
> 
> Changes from v1 at [0]:
> - use FIELD_FIT() to check whether psv overflows the register
> - update the description accordingly

Applied, thanks for the improvements


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog



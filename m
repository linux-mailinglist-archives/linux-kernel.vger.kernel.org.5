Return-Path: <linux-kernel+bounces-123384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B62A88907BD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76661C27655
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB6E130E46;
	Thu, 28 Mar 2024 17:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8THeHU0"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4FE12FF95;
	Thu, 28 Mar 2024 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711648470; cv=none; b=S7t1OydadrwsnBTVnUdZ9Ezf31qvdcORqbHgDQxr7B5NYLSledXWd+bzo/HktFpRAr7VHA3NnlcGnNfQqIbzLe8fSCbP1PWHWPi6mXES5bVzjrBlVhB+bqxDBSscpu7QaV+ITu9+p7Hvvx1UXdOLl1v6Eta1+FcZpuym+QqBQPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711648470; c=relaxed/simple;
	bh=oPS7WA1qHaHGJfLBjDnVLWnKQY0jSE7Qf7DS+Q10wQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdXOSTWds1rtX2V1S0gS0MTQul/CmlYs63qLZORtxjym0E2IqmRf8d1V14n+VpezurBOg6Fa4eO+NegVA/uzficMCMXZitFPn/l2WJDBzD33QHrWehpPIxXRo4o0nKxieiyro8y9fO8WyqBevmG8ZxaqOg+iOWVQzEHRHihEjds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8THeHU0; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e0bfc42783so11448185ad.0;
        Thu, 28 Mar 2024 10:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711648469; x=1712253269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oZvp/lITJDNWxOLYjQgBZB6pagg7Ik04GSqU8vqzwII=;
        b=N8THeHU06YqPfhLHln2Bxw2lLterk9rztBfxyco9Fqvdd6swvE1ipD2FUhWyAIuSRq
         VRTciwlT/rLKfXCdO5uiEdVl2KrMhHXViPj35W8XjM3aDDX95sUnscTvBLPU2NBPRmfb
         0WNJ+RYu++fWQr/4sW/G/7C+n5sjUUuFambcwdJ0pL4juK2v9er2HQ8cagiqZ9x0DzxR
         Rm0XpuGe0KeHWHPQgcMknrGkmBAfZm5B4PH1gbTHFbMiXb1b4i5T2zL5Ij9fEjfvWXsl
         cEx3CtmhemqrttdnZcY2dtzJI8RoMfVm2eY0sVpSbsFlj64/8fVWvsncFGhmaqyf/XfL
         FolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711648469; x=1712253269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZvp/lITJDNWxOLYjQgBZB6pagg7Ik04GSqU8vqzwII=;
        b=iIUCuk9J7oO5p2Y3IKMhjevEch9LgnQPLodVkPtiYfDOiUnpX4v5kZLIksEf9rYsbV
         pFEyJLVxn0iBgRvd021vPBHxJtgxGdcBi03zpaVOYqf5HKJ1JPnfSCxaalqJ9VBK3SOb
         H3Oo5t+K7QwwQCY5Hz9FW9pqlb1HGhf0lZ8m418+yFYa38un7kBwrSlIiMb4xl7iwwxF
         N/YPae8Yqj2tinebub+9cHlv70OM8VbT/gFk2woUjI23Oa10Rs5Z4GAnjAKpwCvaoiXq
         oTWI9xDq9zroFCD7cVkhKof4cBgf7ey3kXLkhUWM06ZPXhDU4G/VNwj5vT/kKm8eDyTA
         ZVBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmNntUnLbtl8DdLlwk4b0J7BAR5FmUlW6ilpWCCEZK083NnSq5QV8U+4WryfdWjmv5dfKgiUIrbEvdMxGUhhHDkw5I80JKv/SVIqz8dg6GVfzFFycQ+eIIZXIbtuLyrxTTiMh4kgaRtds=
X-Gm-Message-State: AOJu0YwJsFIViuDEoWug7f9hNQ/a0hQzQjhTGWHKtkG+VSZ4GmZIP239
	6y8TbN+1ESp8LMmxzkWzs9NjoI29c2AosTmPwi6mif78+GcykLm0xxoTK5Ax
X-Google-Smtp-Source: AGHT+IFRMQqdaniMo9xyMzawxw0tFu+l7drmFv/DHiNd03hzItm5qnsMz3xD1cRBeIVmDfNxU4ri3A==
X-Received: by 2002:a17:902:b08b:b0:1dd:bf6a:2b97 with SMTP id p11-20020a170902b08b00b001ddbf6a2b97mr129367plr.60.1711648468849;
        Thu, 28 Mar 2024 10:54:28 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:493e:82a3:49f9:d88])
        by smtp.gmail.com with ESMTPSA id s2-20020a170902c64200b001e0e8e4f7e3sm1895787pls.206.2024.03.28.10.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 10:54:28 -0700 (PDT)
Date: Thu, 28 Mar 2024 10:54:26 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-input@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: stmpe - drop driver owner assignment
Message-ID: <ZgWu0ouzKLIS7tHI@google.com>
References: <20240327174655.519503-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327174655.519503-1-krzysztof.kozlowski@linaro.org>

On Wed, Mar 27, 2024 at 06:46:55PM +0100, Krzysztof Kozlowski wrote:
> Core in platform_driver_register() already sets the .owner, so driver
> does not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thank you.

-- 
Dmitry


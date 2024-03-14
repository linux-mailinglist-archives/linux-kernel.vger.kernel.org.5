Return-Path: <linux-kernel+bounces-102906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3349F87B83D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655031C223B6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50812749A;
	Thu, 14 Mar 2024 07:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wAeheVaZ"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2DFDDAD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710399867; cv=none; b=rDovBkpxfnuR1AoJzybEp+c9SunB4OBWU5SNQe0xnOaOnLYzEzCsbgExM88lQAKf22uZ6Dd6GP2xeNeHpM2/LrRipFOkd40wr09fdv0rUWeD+ZX3mjv0m3vf4kHyrjJisNWTETxskxt1Jb/D4ANICgcTgytPVQUqqTKlAvqMwq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710399867; c=relaxed/simple;
	bh=ESA+BAU7x6gm8T930yqItEQ7MXJmuXARJY+Dy9dipeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOExd5Qv5EQ+zHYllrXvoBPpHRChpxdu6aIfR6izPypMh5p/Hagg5WRng+rWOc4gV7CY5bKCjxxSYgI5V1AJXrY6qUKw5w3bVM8dXBNgHgkHXabZgtms2iM7WOkoaEGpiGI1RmUq1zt5hd61G6eYwqTPyNAu6cr/yMG5VnL00IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wAeheVaZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-413f2682975so1552405e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 00:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710399864; x=1711004664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=guS8/Cyciijzh6TTeyIVTuVDEBzzzQx5jtXor9e0bWk=;
        b=wAeheVaZRfFm5c8Ue7jM3V7LComF8lwiFOD6+kRL4+T+9Zq8mnJj7w9OHpENDnH83E
         HaD5NcZ334fE1OwYxkhF4ld3mw+PV1b27ke+hZnquVKa01luY92kMUo5zVclpWma8VaG
         /Bi2xA7VzHAr8Do+5YFwNqi6qtRw25a5w0z5d8Ca8Gyp5z54hmyXHmmWQiQ2QX4o5PKe
         JgZu/3SoYXjeiejsjCm+uWMYRlyyQmb0QdMmXPK2R3FRGzv9OKXYlpuKemKdFJ1DG0op
         b5hdI08Byw4kNO65j67CfFGaUMNRmn+ewQhnM7uFn3+qonnL6ZgdYyJMoL4+iIKUJBFD
         0ByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710399864; x=1711004664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guS8/Cyciijzh6TTeyIVTuVDEBzzzQx5jtXor9e0bWk=;
        b=fPTuZJnMx+VY9CMeoKNg48wpqwqu//tRh/sEuEPYSyY08RdXS7W0Rv8MPumB7JwYg1
         rj+yILo0HxAJR+ORcTHrl7uHy0eFPG/nL36i1N9wK33brSrcI9rw1QvybSoQoDge1gye
         Md0GGZKuRlz7HrVH4F/lWbiRa5b49kcSg39Q0SBA0w8eYBrvs+dc98/Qn4eb8FWEnFPw
         dfhHEW9tGM2sBFkffK70FTCZcsbxHS9+Cb9mKWOvmNnytmxLW4pCj7Hw7MeQvILu1EO+
         qRmYDiOI2ONBVXLEiZa1Q5A1a4RBKtafNW5533BqC6RdrY8g6DmrtCiGzdmc9yCc2JhR
         Riuw==
X-Forwarded-Encrypted: i=1; AJvYcCVKiJ3QLsRne3g2BI4QzQ/5GgG83z7bsoDZgIu3ecc/byLFqZuMWUk1m0Vhx0zNtYRr4FUMFtkYwO/sgW0DIaCmPNHBA8wI9jCohARq
X-Gm-Message-State: AOJu0Yx6tiDkNbndgPZy9p0+tONHnivGpsLCmDO6tr9dV3ypGtPwrq8L
	071MlyHH7OQU842EEhNIB40KmvPWTKBvXjLzmlIs9XfYWO3Iyh0UuGL7XvHXKjMUNLuvBRVJeh3
	E
X-Google-Smtp-Source: AGHT+IHujeMOrjOWKV3UzAfwlbNTOdDVlpE4Du2VK/oHCZTRFcL7kCbrTG3u3YZsCnhX8+4UA0nayw==
X-Received: by 2002:a05:600c:19c9:b0:413:1f65:ec19 with SMTP id u9-20020a05600c19c900b004131f65ec19mr647448wmq.37.1710399864190;
        Thu, 14 Mar 2024 00:04:24 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c468d00b004130fef5134sm4616393wmo.11.2024.03.14.00.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 00:04:23 -0700 (PDT)
Date: Thu, 14 Mar 2024 10:04:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/11] pinctrl: aw9523: number of cleanups
Message-ID: <18668ee1-7d0a-48cb-bef4-1d310b030837@moroto.mountain>
References: <20240313235422.180075-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313235422.180075-1-andy.shevchenko@gmail.com>

On Thu, Mar 14, 2024 at 01:52:03AM +0200, Andy Shevchenko wrote:
> Just noticed that the newly introduced driver has some leftovers or unneeded
> customisation. Hence this series. It may (or may not :-) be sent as an update
> after v6.9-rc1 for v6.9 cycle, but TBH there is nothing functional critical.
> 

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter



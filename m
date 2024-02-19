Return-Path: <linux-kernel+bounces-70919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03164859E08
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3464A1C21BFC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35CB210FD;
	Mon, 19 Feb 2024 08:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N+QNVVzu"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629AA210F2
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708330665; cv=none; b=k4bnDKg84dsL3a+un697DusBRJIAl/EbKloC/Zm1bOcJxh+cME7gkI5rkRgf4+TGUq62q538qBeymdEQuv7J+n2P5Itrr0CN5FVYSmUYwN4L2LAAfJyHGY7uEgSIuQQK4+AlBGyPW7i2qsHc8UX7e6dyaz5pAZ5e52GvtB81afQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708330665; c=relaxed/simple;
	bh=HFzMpJTY2CqiCLwGCiBJiA7tDpfaFJpV/KrsBdDmoig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vD9m7cvKyQzpgxCA1QqRuujZeNVTGOP5usFfGqnzMzMsgfKO/CWywPXx3JLYmGxCQjr4g9+7EeTb1JfcO2N7X6KZsAHv82eEbFdTwhiRHI5kurev3cjKl+519mxt/naf0E8iCxhdPOgu4uto5lttOuYgnH91r1X+gXu/YfDnV3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N+QNVVzu; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3cc2f9621aso392900066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 00:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708330661; x=1708935461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+fWtteEBUr3xYhubLV+FegEWhNEJvOAyY8/0VSt5VzY=;
        b=N+QNVVzuXWgZzh0S5uUQWgttKYMJl0lhb3t1YDjwupgN03AjOeba2aWvO7jKCHLq5C
         Yj4IusgjGBvq5uMbmZmA+W+tNUd6AMXRZ7WCphg0XDij0xxTTPKbW8WBtIRCmq13YHds
         1S2vgokxRvV4ltgachwwqmSfcTcIXY93N3XEKq/BTR2g4kvJYCzA6E7MopqzBarhvfDd
         8LuOHUIo90ZGWu1HhKgK3NGYZuA+ho8VBdDaEfVzGRIa6LjuT6EvtDZwxScku169FiVX
         8nf6EfHJvXpanOGcDsIyRRTS1n25HXJcEXcNpn/k72PQ9TQP8RNq4Bx4w2ZixpyxuZP0
         cDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708330661; x=1708935461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fWtteEBUr3xYhubLV+FegEWhNEJvOAyY8/0VSt5VzY=;
        b=Ccn+DfcniR4chwVKipeQNX3/yBbPZ8RpqkUj/cw89OwDlwqwOq13FzYBvbUa5Jw8Fw
         HuyTRqwWoCxWnK/AY5ywGDcG3YTBeka1EXC6y6Yt6kVJDcqGmdAy5TlGIOsf+yLYiAoY
         9WXp+E7rLOzCluXKVe6DYXRVEGX2L4JHY3iyuyFOhEvRp2Le9kwYWTzVKj1iEJjWN9pi
         0sq20/glvbBYU2kRqLjXS6Nk24snQD8HKVHzQzQ7SRAcCvUq030qYiQalNVCQORVbh0N
         UE5bCSfyaxakvtjd4HYgOiFEPRIa/CJxr3+I53QLrxa+d3F42Jg58717O6ouna7VOQux
         Lw0A==
X-Forwarded-Encrypted: i=1; AJvYcCU7Ls1HGJbE/uNOmGcDV3F3yt0gA4TfGfghXbu2Aa5xB/tFhkAI6yKku6/ehLPgCvKR2vtvB7pQteeRKDYK+SP34TjA+yyKpY+Vi4S3
X-Gm-Message-State: AOJu0YwTfPkM27pkvQp8ET/e0NK5haPjVyv1ER0fkzY9bmZrhECV+zzN
	1NmCu5tJWZa/hdC9Qyc0H+WHyJ8jIcrE8AbRxmqF3mFOdDSASpJZSIQPsLHVThRhYJvGY766VYE
	e
X-Google-Smtp-Source: AGHT+IHawomsSVE23ZtZzjbMpXN6JFZ8Y2Phn52Q9rtMSop3nAF0+LO/miE8tv7O7NNAz1YyW/CMRQ==
X-Received: by 2002:a17:906:c417:b0:a3d:e2e9:a7f7 with SMTP id u23-20020a170906c41700b00a3de2e9a7f7mr5649855ejz.27.1708330661571;
        Mon, 19 Feb 2024 00:17:41 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id h11-20020a17090634cb00b00a3d7bcfb9a1sm2688595ejb.128.2024.02.19.00.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 00:17:41 -0800 (PST)
Date: Mon, 19 Feb 2024 11:17:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Moritz C. Weber" <mo.c.weber@gmail.com>
Cc: florian.fainelli@broadcom.com, linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Staging: vc04_services: bcm2835-camera: Fix code
 style checks
Message-ID: <236d985c-1835-410f-b0b5-cacbd5fbf930@moroto.mountain>
References: <20240217211246.28882-1-mo.c.weber@gmail.com>
 <510574c4-ad26-4fc2-93c4-7b67737f8eb1@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <510574c4-ad26-4fc2-93c4-7b67737f8eb1@moroto.mountain>

On Mon, Feb 19, 2024 at 10:38:30AM +0300, Dan Carpenter wrote:
> On Sat, Feb 17, 2024 at 10:12:38PM +0100, Moritz C. Weber wrote:
> > Resubmit these patches to fix multiple code style checks for better readability, consistency, and to address errors indicated by Gregs patch bot
> > 
> > Moritz C. Weber (8):
> >   Staging: vc04_services: bcm2835-camera: fix brace code style check
> >   Staging: vc04_services: bcm2835-camera: fix brace code style check
> >   Staging: vc04_services: bcm2835-camera: fix brace code style check
> >   Staging: vc04_services: bcm2835-camera: fix brace code style check
> >   Staging: vc04_services: bcm2835-camera: fix brace code style check
> >   Staging: vc04_services: bcm2835-camera: fix blank line style check

This blank line patch would be still separate of course.

> >   Staging: vc04_services: bcm2835-camera: fix brace code style check
> >   Staging: vc04_services: bcm2835-camera: fix brace code style check

regards,
dan carpenter



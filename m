Return-Path: <linux-kernel+bounces-119316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C217388C6F9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 001EB1C63E36
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FAE13C8E1;
	Tue, 26 Mar 2024 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UY5g8I1g"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D2E13C8E0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466993; cv=none; b=BBw7V1imicCkbhWNJZfsSHjN7Xq4+rgijkJqlxFN6hDr0fFdUBeKP+YTxJuEUO2/yrZJXccITC5yvkt6iI7tWNpUF/cXCF49xajKLtnZQFjlKgTUoLarrJVihkaEaJuLTekUUzd90rSc7FlR5SblmNGWU/3ZFP2XgOv9amfShBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466993; c=relaxed/simple;
	bh=ENQhz3CFs9PeNkMdqKMu5YXn5aNCoXD+ovnzubZ+amA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEI/oKKc8YGxQxSRWerVk6o5vbXZ2Sv/ZGCJEq20blxmdwf2IIQ60mRvu73OmoYpXjvKBJrZ/YMZP5Sxy3SXiEqzxjPuwpkYYi32Lx9ZQ5LfRjHTXJ3wQEWifn8fz8X/3gOQ/s3m7zaLJesYXjjIf/9CQdwysyV1WEYRKZYsmfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UY5g8I1g; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so7304047a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711466990; x=1712071790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zx8744s6axbOtphhuuWPg2DVYxfpJHRUFo6xljEDa5Y=;
        b=UY5g8I1gjSSp26CR66RZ9c1tutGzu61rIhlQNqw9W7Pt3o2YboCiyBgw5KMpSzS16F
         dpwdC3+bqADhULni2f4Q04cWYtHcBfygri2sXK+i+7h+CGHqliX6I3rZ9f0V0I1747PR
         gZS0kcW9LR613oR0lBQSivfFfkFZxyfAAuvCTM67laDBd2gSP9Bjzmb1Vnfx/4aUDHEX
         y8+crhAnty9ls9himzW0tGpwV6Z12Jn4PedsQ+yrJj9RTnJ47b2xHXbWrxVAU2BdeNeY
         zmyW5vBA70PmUdVeHs50i8y07kxX7AvVZOkBlZnOOcpr2EmkVtJYC77fZoxeamTOXJzu
         BXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711466990; x=1712071790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zx8744s6axbOtphhuuWPg2DVYxfpJHRUFo6xljEDa5Y=;
        b=TxHxvaT5eNsBZ88SvIBl86PtRYeQKTgoA4LkffF4dmgoM+UhLwmJE7aUDEoDRgUjZ6
         pV3ULN6i/Z8agzlwZ4hMh6ONSsiKnKOKKV1BL2VTeC1A1bs4dJGAQUhDEHRscu7hru27
         jgs2iw7dPz2qH5BYyO2TLLCg5iROUGxIrq0LkTaq8tVkuM/2qQN9DgOlKVtfgDgika3v
         6fwI0BWNfpr2Luw6vj64bDxqrVyrMjm2abGls6I1GD1dQYHuSC/kJ0ssdi4kccZTQZzr
         5tSZHhrki6Rme9sTdMUUHL6xurzIexrNkMFtDXoRca1o7vDEMYbqVNYAK/vvaSgu3y9o
         pfbg==
X-Forwarded-Encrypted: i=1; AJvYcCX+JrS+C8WiUwFJ9qj2IA2zgFBsJq4z6tPmkrMQYAx9jZx15tfoABVURz+O2WkXHv4MGhmtFUV+0wMOF8izWYfGINoaRhkG8ivGZlSk
X-Gm-Message-State: AOJu0YwAGPSeUPJjbTajbA/LZ+qpF9L57rxJq0scWBtUPbLUnxZ8r67R
	anwIHsJdVyR5ckoZE/WrsuWuFO/sAPwDezXwP4wuYbJB6fS1Y3pCsH15T5ePwBU=
X-Google-Smtp-Source: AGHT+IF8T6hH3qKrM5nkhcYn361Y+VsXhoLGLfft/P6Yc3wh0nfma+oX4OHMPUNyiquJZfuWalsiWg==
X-Received: by 2002:a50:d517:0:b0:56b:f461:5de8 with SMTP id u23-20020a50d517000000b0056bf4615de8mr8354391edi.29.1711466989812;
        Tue, 26 Mar 2024 08:29:49 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id en21-20020a056402529500b0056be25367absm4252289edb.40.2024.03.26.08.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 08:29:49 -0700 (PDT)
Date: Tue, 26 Mar 2024 18:29:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Kevin Hilman <khilman@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Markus Mirevik <markus.mirevik@dpsolutions.se>
Subject: Re: [PATCH] gpio: omap: Fix double trigger for level interrupts
Message-ID: <6ecd284a-e3f5-4b69-b6d7-129da6b385c1@moroto.mountain>
References: <20240326145439.1293412-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326145439.1293412-1-msp@baylibre.com>

In the bug report email thread Markus Mirevik said "The interrupt
associated with the GPIO module still fires twice" so while this patch
is an improvement, it might not be a complete solution?

> This patch was originally proposed by Grygorii Strashko.

The way to give authorship credit is you make the first line of your
patch:

From: Grygorii Strashko <grygorii.strashko@ti.com>

When the patch is applied then git will assign authorship credit but
remove that line from the git log.

On Tue, Mar 26, 2024 at 03:50:14PM +0100, Markus Schneider-Pargmann wrote:
> Set gpio trigger before clearing the irq status.
> 

This commit message needs some work.  When you're reviewing on email,
it's kind of common to read the commit message without reading the
subject.  See how the patch looks like on lore:

https://lore.kernel.org/linux-gpio/20240326145439.1293412-1-msp@baylibre.com/T/#u

The subject is up on the first line, but it's mixed in with the headers
so it's easy to skip.  Go ahead a restate the subject but in different
words.

But also copy and paste more of the problem from the bug report.  To me
if I were a user the important bit is that the bug ends up hogging the
CPU.

"The problem is that the interrupt handler was is run twice for each
frame.  It hogs a lot of CPU time.  Fix this by setting the GPIO trigger
before clearing the IRQ status."

regards,
dan carpenter




Return-Path: <linux-kernel+bounces-5449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FBB818ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D601F25777
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87921C6AD;
	Tue, 19 Dec 2023 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lxn1w0E6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B92C1CA82;
	Tue, 19 Dec 2023 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6d939e2f594so449355b3a.3;
        Tue, 19 Dec 2023 07:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702998410; x=1703603210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zQaLYjYBXcfRuKNABTIkZjF+l5ZguY6YkJQC0ZzCdeM=;
        b=Lxn1w0E6z5WbooOQpBvcPB3xzQuTskg+vVBb+ZwJqIwMPBxpe3ROxJO4fSe67euHQ/
         knS8LL5VpvHkMoI6FfD8NhFNAJMLR5WzglA4Ghif7j41V/t7t1OBtq+iKiQ2sT1+lrCa
         3zcYnBs7lVVPiFN39RN8INX8HYMneTnhsG0ybRBG7UTBC0WA4GEFIpDF2Y/hauJBtHY1
         DaYlq++hobaBGtZzllsarO39QR1I9rStWZ4vXMeHl7gsm8sLp8m51hcAkfVXoJ7IanWI
         vEiSpWkXTo3emqUZE/+K2BVXEFYh1rEbRNTLMVbvoJKgTlEJJzmQTEFOHYbbX5V7YuXL
         7IKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702998410; x=1703603210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQaLYjYBXcfRuKNABTIkZjF+l5ZguY6YkJQC0ZzCdeM=;
        b=JCUFoDxXHByjePk70Nt5nzJe34tJV4EpbIol3kPlXi1ACOTdSH9zAPx4umBPGnTWm8
         cEMjj5mAVqFGMdagy8dDGjE6I10lAjCJGNmK6+oaOkbmrBnkwoDXSQt+FFEPWY9pB/9J
         wbx70VQ6QCrxCuqXBy80hEiGz7bOdM45FscYZewSTGm0XwQ7px/oZDuePSuQFAKXFU8V
         EEgMqnY2fjRhggo7DZKnk3OpWsMcYh6eaQjL/K9OBAy0YuzQZKO103g9Mf3NUV6dPbk2
         A0ejL6W5KAwT/rxPzsq4nK4b6mFhGWSgX7EMuYx6QzzmwltMEJ9g92y4NHYXqvkgm+HC
         QvfA==
X-Gm-Message-State: AOJu0YwqklhvCDjkUH+uDUOXWnyLo2d1pv2Irn5qZ9TG4G8pyKK+AFNQ
	AI/wtVf/o/a1MO4y6dr+oMGRMHNbGhQ=
X-Google-Smtp-Source: AGHT+IExJM0o5xFuEDtPdfaJz+l9VYTd6rBM+p9/dYGRbjJJBfmCdBJMnI/8JUIG5wGdm5X5DVtR0A==
X-Received: by 2002:a05:6a00:9390:b0:6d9:96d:81f5 with SMTP id ka16-20020a056a00939000b006d9096d81f5mr2589907pfb.15.1702998410316;
        Tue, 19 Dec 2023 07:06:50 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id g14-20020a62e30e000000b006d34571a471sm6245067pfh.29.2023.12.19.07.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 07:06:49 -0800 (PST)
Date: Tue, 19 Dec 2023 23:06:45 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpiolib: use __counted_by() for GPIO descriptors
Message-ID: <ZYGxheEHNzgAvQ-o@rigel>
References: <20231219125706.23284-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219125706.23284-1-brgl@bgdev.pl>

On Tue, Dec 19, 2023 at 01:57:06PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Pull the array of GPIO descriptors into struct gpio_device as a flexible
> array and use __counted_by() to control its size.
>

Looks ok to me, though that might be because it looks a lot like cdev's
struct linereq.

Cheers,
Kent.


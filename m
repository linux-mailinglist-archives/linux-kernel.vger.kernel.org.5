Return-Path: <linux-kernel+bounces-10030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E37081CEEC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 20:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C002E1C22A73
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 19:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0392E657;
	Fri, 22 Dec 2023 19:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AG+ag3tE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2473D2E648
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 19:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5e78d94855fso20630837b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 11:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703274516; x=1703879316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8hDUXP6yXJ35Qqh7bUvtO0oNx8YXg3fARmULn6a4HEg=;
        b=AG+ag3tEbAMW0Y/Z2cq7wAf/AUdTT3KPGmb0Us8d6+9w9AT7ieuYjzb6LofC4j1kBF
         ERpffFRBg3gOcdGdbaIjbrPOBeiJ+onirmRzFgN2W7aoh549f35wetvSrRzLbWmqZouS
         QXFLrIyXfhLBFwdQ2DxQTrs+wo/6PpuX4VhkGn9jN3flt8eHMbBUGRxlQmZR+qBak1gT
         wZ3oqaXiKRGfnUcVbKGb09q3WjHFm13K0zPdZbkxYF9YIA76vn9HCgObHUEFuopgikv2
         nyIVkpF392roKzVwn+TpOvYzkr/6P290I/ey+eKMhNKRvfmGxFlmXydq0m8HWeOXuhcq
         c0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703274516; x=1703879316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hDUXP6yXJ35Qqh7bUvtO0oNx8YXg3fARmULn6a4HEg=;
        b=LnIVM+Zf98sveXqSLjnAf9f3M5Hu2qYeoGryTpmXi5Cquh7qjy+oR7lqAiQttLBHKh
         N/BdJUkjRUIx5BABLwkeRCF9U1FnJGhU0LlCqb1vZfT3b4P9Asp1dMO37E8o0UAyMHl9
         YgNCpSfhaMR+Mc/WY1Pr40EZXFoXvUyXwMbR6IlP8UW9tAGaLrSjonwHnAAt1J7oslmd
         U7e4AY7k3CZkslFWr+nmflLnifD/PKLCT/oQPJyxL2IS1p/epvJz3gP9zKBjhB/2dZBe
         brz7SvnuvnJB2ElvdJ1GbMJtx9QD4xMXsttRT9YtM77EimhGTXY7wcHesG2ifB+ja4ta
         y27A==
X-Gm-Message-State: AOJu0Ywyp1Og1Ydt6tjHimcexz1mM/b0rmEA9UP5vjyQZLlzWWsf4QrR
	eUS8MoaY6X6YQSPT2KXIf8DH6dWhZ5E=
X-Google-Smtp-Source: AGHT+IEHhysxook3n5bdJJuN8GicTWwVVCFBUK5CxPjd+vq08oFZx3+MWdAag1vqEb5ozbVSnaKnUw==
X-Received: by 2002:a81:6d44:0:b0:5e8:a71:aeea with SMTP id i65-20020a816d44000000b005e80a71aeeamr1554095ywc.89.1703274515823;
        Fri, 22 Dec 2023 11:48:35 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:45f9:a891:8661:9fbc])
        by smtp.gmail.com with ESMTPSA id a187-20020a818ac4000000b005e4a023fcf3sm2100426ywg.92.2023.12.22.11.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 11:48:35 -0800 (PST)
Date: Fri, 22 Dec 2023 11:48:34 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 1/1] bitmap: Step down as a reviewer
Message-ID: <ZYXoEtr9dQQnQXw/@yury-ThinkPad>
References: <20231222140402.2887556-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222140402.2887556-1-andriy.shevchenko@linux.intel.com>

On Fri, Dec 22, 2023 at 04:04:02PM +0200, Andy Shevchenko wrote:
> Too many things are going on, and reviewing BITMAP related code
> seems not the best I can do, hence step down as a reviewer of
> the BITMAP library.

Sad to hear that. You're always welcome back!

Thanks,
Yury

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8b686a9fa068..2e0e74681511 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3580,7 +3580,6 @@ F:	include/uapi/linux/bfs_fs.h
>  
>  BITMAP API
>  M:	Yury Norov <yury.norov@gmail.com>
> -R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>  R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
>  S:	Maintained
>  F:	include/linux/bitfield.h
> -- 
> 2.43.0.rc1.1.gbec44491f096


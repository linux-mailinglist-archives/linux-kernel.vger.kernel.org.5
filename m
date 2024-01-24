Return-Path: <linux-kernel+bounces-37805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F3483B5AE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05402870B8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201FA136668;
	Wed, 24 Jan 2024 23:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKK2Ly/F"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFDF12C532;
	Wed, 24 Jan 2024 23:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706139808; cv=none; b=vAO/gTL513G5uhPsaeM3iagtL3rEcwGEJF2PcoLKt1lpS7qSQ91q9bzS3Vnn2a2rE3iafblqVYaKoZl17tecgvhEQd1b4IzV2AYqSX3beQGdrCykry5G8V/GHp8APM3w6RrewuNdG1KwyDiR+FwmlR8QwCm/4cZhXwMNjHe7vrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706139808; c=relaxed/simple;
	bh=if5QS5IfjE1IbQtSKovEiuWi9YTgJzwes/evFLxc5dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVntC7P5OdB58COe8qC7af+fxQgnPbvbGOhSl6kerYVVhjHso5KcBc2ZvL4tPIxPRJmJGTtf3vH3LoC4l86PPmpbcK2gm3TARzQEO+TTtqwB4kKQLTd0GURn1SASXFMePvhcDrMgygPTdpDnzvf5jvGQ7BYzKfnDpcRIUqiUhqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKK2Ly/F; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ddc1fad6ddso720364b3a.0;
        Wed, 24 Jan 2024 15:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706139806; x=1706744606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vK1IoSzjLAgX/p1hW4bNuWN0808a305i1v4S27+aWDY=;
        b=OKK2Ly/FoEAzAmzq/OJ7jzKanrL/PRhhuHRDMe7TCe2HbtXEfsXvlGmDw1U3n3Bg2s
         ijRO7cdvGfQ44xLkbys1FZp+JYwDW+qR2ffXQdx6WT3q33op8TC8Xhqch1C6kXpf6psS
         5T308dcpmVy+XeDmdGVkAzLgXLcHtnDX2DBe2yoHroGp4Yd8maUtJTN113imo6e1DKZJ
         BFqI08D2awo4dZuv7kugW0mgwS630k0tk7FTySJYVwIDgZOBVmXEDOcvCPRMm8e0Oy3J
         fYtcQ/rvmkiiwE2Ifb2u65LTUlLccX+J2OUk4TtRRplZBhWkkRvDENB+xRk8PTy5ZGxE
         ynhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706139806; x=1706744606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vK1IoSzjLAgX/p1hW4bNuWN0808a305i1v4S27+aWDY=;
        b=mqiWO+/AKkvdIjKOLmk+KIpE5CLkO22Es3MFtdtZsUrNLku4aadlgzCbfgs52DbV30
         tQapMDB20l+F2/1AatyygSm9lYGza3cUKEd5tszNxj3AvR0FhwTog7j40EIAtQHJ27Cv
         yN2fkmKnQ/SpZ3k5WIHRPgZ7FRQG3MTM2ExcUbqe3tdX5MkWaKkqhQl/effZUm/iQsCI
         Je5A/WxrT5Lyk7dxzjVcji9aZwGyXy/oNI8JLJ6kGSBOYGu6Y3eHojP6XmxFUeGRJifB
         1CcPz5OxRel3AwWVlmGNTficppjRqdMmUymrJ+VpdH+WG6hUSNiGJso9sN78Vd65OB71
         aUmA==
X-Gm-Message-State: AOJu0YzoJeDJkCxXASS14w30VDJBIE4f3msZH6V6HlhxsmfdDIIVdwZH
	nsLD/8UD5iNB7Xm3DCJ+FUd+RM6FA6GUErqtUN11mHyWt6BBdXic
X-Google-Smtp-Source: AGHT+IFuZzz3VFfngSyBQV5oOOt6tsi6t+7ssiSyEG41SSztVGAFL1dVYOMRkmSTAFz9IsdeXIg9/Q==
X-Received: by 2002:a05:6a00:c87:b0:6dd:8110:2109 with SMTP id a7-20020a056a000c8700b006dd81102109mr3028pfv.41.1706139806415;
        Wed, 24 Jan 2024 15:43:26 -0800 (PST)
Received: from rigel ([220.235.35.85])
        by smtp.gmail.com with ESMTPSA id r11-20020a056a00216b00b006dbce4a2136sm9006188pff.142.2024.01.24.15.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 15:43:26 -0800 (PST)
Date: Thu, 25 Jan 2024 07:43:16 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpio: cdev: remove leftover function pointer typedefs
Message-ID: <20240124234316.GA6255@rigel>
References: <20240124161725.79582-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124161725.79582-1-brgl@bgdev.pl>

On Wed, Jan 24, 2024 at 05:17:25PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The locking wrappers were replaces with lock guards. These typedefs are
> no longer needed.
>

replaced

Given that,

Reviewed-by: Kent Gibson <warthog618@gmail.com>

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpiolib-cdev.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index 2a88736629ef..34d6712fa07c 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -61,11 +61,6 @@ static_assert(IS_ALIGNED(sizeof(struct gpio_v2_line_values), 8));
>   * interface to gpiolib GPIOs via ioctl()s.
>   */
>
> -typedef __poll_t (*poll_fn)(struct file *, struct poll_table_struct *);
> -typedef long (*ioctl_fn)(struct file *, unsigned int, unsigned long);
> -typedef ssize_t (*read_fn)(struct file *, char __user *,
> -			   size_t count, loff_t *);
> -
>  /*
>   * GPIO line handle management
>   */
> --
> 2.40.1
>


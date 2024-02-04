Return-Path: <linux-kernel+bounces-51858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3240849023
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C8B3B22ABD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 19:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1722511E;
	Sun,  4 Feb 2024 19:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="HbIRc+Y+"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274EF250E0;
	Sun,  4 Feb 2024 19:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707075689; cv=none; b=fGkA8lSPpw1h5wYXeCmSnUhda4rSt40Q6MLa9vsqA9Xs4RCvNAG/hfSIdPb5kO2u+7xBWnZAAOvVGySX4TW02lmNHstNZDEcWqHqUwKU+6YEJgxSApTx/IqoDlsE5QUxUvb3taFLjeZu8pFfSLSw2etDqQDJiInOWN65l9BmKSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707075689; c=relaxed/simple;
	bh=3XS7DO9aX3sho0zkyQuoDuzbfqhk1EcjrAHCP4x8oMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJKIZMrODaDSJMzA30qPYwJy2ghn6QwYL3SJJqAbhnZr+9++/AVlbD8Y+zQkgcLxeP112NvCDzd8UQmzX6OibiNGbObJlQobH1mfQiyZPTqGKYn4+NcEy31pz2ECclanx0zvvIA3ag6dA330a2s/3eIpp4ikKN3ebPuCWtGvx5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=HbIRc+Y+ reason="key not found in DNS"; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-295d22bd625so2470634a91.1;
        Sun, 04 Feb 2024 11:41:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707075686; x=1707680486;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from
         :dkim-signature:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoxGmMshbV8Z5WIzuYAQy8r+fTG8koe9kiuY0grIflQ=;
        b=Qq+q6UGhyQTuaejtOOqwcymwGv1eD6MkqguyHIjshNccxkrB/bSC4wUGYNRRL3a2wg
         0gqnkXnGTjLbOK09LhMYC2PfOdfQtidWf3Vc1xXLTkWydHnct56xqtB47tiFeoKmujkC
         E+BM3MGasb0ag3dkBifrdCEF4tKhkXJAFjXaok3BLXNQ2YZ4n9+L53JuuOtCSfOm6HZu
         PctXYr3vZYPvslBVwxytFLBUdpkd/K43SZ9V1z85qg95Sxz65KE03KjSYUYNtMtTzUYT
         sfMblxVffnWuMgMdFB5kKZe3DgyHeZB2faUCjqZbAWu22gnFkyijvnw5mT44Ry9VcBYZ
         XvIQ==
X-Gm-Message-State: AOJu0Yy7N5dxnF+ocTtRs4gJjU0wdz/hVJm/OaW4rc54gFjCXUOdVwSO
	SL5pbn5cvc7lEe6IbZxnDlh73OhgV/GBO1g7o0r76xfpyI/dblnE
X-Google-Smtp-Source: AGHT+IF3dpSqYv9TOi3O0OV3QI4GrNj/u6aCz7wZ6UftI0O9ioNMhEfkDxt+tvxWvy0TKkOcguPzag==
X-Received: by 2002:a17:90a:970b:b0:296:ed4:99b with SMTP id x11-20020a17090a970b00b002960ed4099bmr6585527pjo.43.1707075686303;
        Sun, 04 Feb 2024 11:41:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWR/qomCL4H4khNb70DnEodzKW9EssbPYuB5rMdY7xRW6Qy9cXjFGLY/9Qs1iXHS1ZQJ6npguewS0VKBwq0D0igJCMz5fLT3t0MVkjCflDjzl43nGT4HBU/9aPrsKWPcCsJYiet8xn4+ddHcrmAejLEQYR4auq4zVG8+eWl3zClsbEvob8=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id gj8-20020a17090b108800b0029604b0b7d1sm3637858pjb.15.2024.02.04.11.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 11:41:25 -0800 (PST)
Date: Sun, 4 Feb 2024 16:41:52 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707075683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EoxGmMshbV8Z5WIzuYAQy8r+fTG8koe9kiuY0grIflQ=;
	b=HbIRc+Y+N1kwlI2deLNNE1nTZtki4Yis+Z81wXzrmmuHIVHi6zmHZK4+IwR2IN7WHN8aLD
	gdjrGfoCo0L8Ba+K7kvKXoSXjqt6DTktSRzGoG5xQOUVlbX4tJuWV8w7zD3Er7U1AFz1e5
	sCPCMtyVJyqOI9ZR3BxvAnmzSNjZjsRn5TV11SGNc1S69jxUHXXFZCUVSYp0b36p2LD62h
	Tcyzx9UnuGb8f7bKB6EoYQEX5Z4NAUjacEXpzd9NUO7/GnMkSL14DLpoeEQRPVE4KPVQfX
	ntGG4JqK9ejgE/UudW7q26rp+bHVS78nNMCAiDp/Z95cmQSdPIy7bemv4sAfhw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] gpio: gpiolib: make gpio_bus_type const
Message-ID: <v5cgkajd7vqz63jsflpx56lvofozh77w4kwomlm5kkwcb36uxs@yqlkx2eduqhk>
References: <20240204-bus_cleanup-gpio-v1-1-82d91b4ee1de@marliere.net>
 <CAMRc=MdSApjK2b66LxLE9XZufvT-+SThuqjdr+yG-hsKEb4sVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdSApjK2b66LxLE9XZufvT-+SThuqjdr+yG-hsKEb4sVw@mail.gmail.com>

Hi Bartosz,

On  4 Feb 19:34, Bartosz Golaszewski wrote:
> On Sun, Feb 4, 2024 at 5:29 PM Ricardo B. Marliere <ricardo@marliere.net> wrote:
> >
> > Now that the driver core can properly handle constant struct bus_type,
> > move the gpio_bus_type variable to be a constant structure as well,
> > placing it into read-only memory which can not be modified at runtime.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > ---
> >  drivers/gpio/gpiolib.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > index d50a786f8176..24d046268a01 100644
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -63,7 +63,7 @@ static int gpio_bus_match(struct device *dev, struct device_driver *drv)
> >         return 1;
> >  }
> >
> > -static struct bus_type gpio_bus_type = {
> > +static const struct bus_type gpio_bus_type = {
> >         .name = "gpio",
> >         .match = gpio_bus_match,
> >  };
> >
> > ---
> > base-commit: 3eac8bbed22e940ac1645a884f221bef408f675c
> > change-id: 20240204-bus_cleanup-gpio-57eea8d32a5a
> >
> > Best regards,
> > --
> > Ricardo B. Marliere <ricardo@marliere.net>
> >
> 
> Ha! Does the same work now for struct device_type?

From a quick grep it seems to be the case, but maybe you should wait for
Greg for confirmation. Also found this:
https://lore.kernel.org/all/1305850262-9575-5-git-send-email-gregkh@suse.de/

Best regards,
-	Ricardo.



> 
> Because I just sent this:
> https://lore.kernel.org/linux-gpio/20240201162758.50733-1-brgl@bgdev.pl/
> 
> And maybe I should make it const right away.
> 
> Bart


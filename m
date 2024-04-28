Return-Path: <linux-kernel+bounces-161562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 040D18B4DC0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 22:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B58A61F21284
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 20:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE0F74BE2;
	Sun, 28 Apr 2024 20:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QxIlbbrk"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C146A00B
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714335616; cv=none; b=IzycZj1DWfWPajTWNjpDkjO4yaEEa2/GZ8UHGHxOpfToFWaGip20UP5b6BJsTL8CN/jTPCGvxR6WVE3W4IDsG0HDQt7BEFcxaawsZHq+CO7u87SamLjb3HrtUdApa3jfBJpsvA+Na3G6o8Rs2lDVPJPcYOFPZ24B9CHLuE0erLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714335616; c=relaxed/simple;
	bh=naiSODMjEFZTAWJMatalJfCiiGdYd7LxVoEg+do0Da4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Fo5uU2QJgfxdg/8AwUQacVEhJ51J10Q6MF9upBddY9mG0zJi8bMQ11nlj2lJwnZYhvC1KPYtAJZhOsp8bc83IdqYJy1no29HD6OOu/GZ4yx0L77ZG+Dz+Tl9m0E2exNbMYf+pk3OzDK6GJIuvpXZluYdUfKlSgN5vkr01MeFJvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QxIlbbrk; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36b3738f01cso208755ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 13:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714335613; x=1714940413; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DVGfYkDeFehcb+pRimbLtXuka+P6h44CH3Z8Q2TQV4o=;
        b=QxIlbbrkHgVKpcHLSi6m0PObJ4km2i3FrBMFp0RdxgbiJ+3lwus/exvoFeqXAaM3NI
         6Qi+e+l+WGmnXku+v0sC44jkny8wCNvUuaDsdRpiap7USDmvOxD/PDDr6eIZMR+paPt7
         Rz9SC0L6gUkpLKkGDAEgG/ExdipcxRgx3IiwT3yzw14g+AMplMFnDom4J7ppaJgS02vm
         MKiojn8bTKmguItUE/r227U7+/Ho0Hf0IbdZsV7hALl0Eb8AGVX7VryxGojocuT4luV/
         7Grex4w7PkhfjUXKVjobsG6UyeHHkABEZT5fZmQQOTz1q5OG0UQIxz+dKwedkJFNMGzR
         3XZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714335613; x=1714940413;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DVGfYkDeFehcb+pRimbLtXuka+P6h44CH3Z8Q2TQV4o=;
        b=Ejuj4jarErszzBo79ruBeN/j5Ym0nt+CAzyFhO6Lgf1ddMaytcWORa8Y/zSD6pEW61
         7JUx2I4SoOQSZY6bkXO94XUHgqjL/ADCC7M9BvQwzE9norYblZRo4J1+X3V6RTrXWOuW
         +2eXPoAhnAtzO3T5jFl2lZIl37/jr8ioHI+r5Hyxo13KCFGZe6uXrdrjGAdNOHApMrQa
         SB11AdS4c+NamO0GBGmc8i+iqlnikBZq/zvfPnJ21cRDmP4fyDCt+jw4m4ZqNEot+p90
         nJHBFju08DoELl2h3C5Xf2uvmP/80x2sViBwJ7ImLAK4rhixC7hvnIhnhdjjNJKSVo3J
         RIug==
X-Forwarded-Encrypted: i=1; AJvYcCWIaaVmQhaOE/Ug4GiXsVGbEK7IltGojC4G2t37JoxlC32VVkFK/EsB0wwwFEjMo7pxohhenbq7I/HbU/Ijmz8eCNPJoLZtyptttnum
X-Gm-Message-State: AOJu0YyeJK4pJ3qRzYEGTVY2TlW+noKysdoJoX7QERriW1eFslfchaIA
	W2ZNTTZ/X+mEOTbBZooVP1V70Ny3Adae0ZH7vokQdRiHVNEmA4OwsnTE4yd3OPMsf42vBnuPu4U
	aSg==
X-Google-Smtp-Source: AGHT+IH81P61EWXQeIEgG/0AuvESJvMSetYf9rC+8jw7W1/KdFqbiAVe7ttTUS14mTn3Rgcg2EAvOg==
X-Received: by 2002:a92:c5ab:0:b0:36b:2c6f:ac1f with SMTP id r11-20020a92c5ab000000b0036b2c6fac1fmr293061ilt.24.1714335613530;
        Sun, 28 Apr 2024 13:20:13 -0700 (PDT)
Received: from [2620:0:1008:15:46db:4823:ceac:2ea3] ([2620:0:1008:15:46db:4823:ceac:2ea3])
        by smtp.gmail.com with ESMTPSA id w23-20020a634757000000b00600d20da76esm11291235pgk.60.2024.04.28.13.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 13:20:12 -0700 (PDT)
Date: Sun, 28 Apr 2024 13:20:12 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
cc: Christoph Lameter <cl@linux.com>, Peter Zijlstra <peterz@infradead.org>, 
    Pekka Enberg <penberg@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Vlastimil Babka <vbabka@suse.cz>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
    Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] mm/slab: make __free(kfree) accept error pointers
In-Reply-To: <285fee25-b447-47a1-9e00-3deb8f9af53e@moroto.mountain>
Message-ID: <07209fd5-f6c3-293a-4968-63a11c273ed6@google.com>
References: <285fee25-b447-47a1-9e00-3deb8f9af53e@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 28 Apr 2024, Dan Carpenter wrote:

> Currently, if an automatically freed allocation is an error pointer that
> will lead to a crash.  An example of this is in wm831x_gpio_dbg_show().
> 
>    171	char *label __free(kfree) = gpiochip_dup_line_label(chip, i);
>    172	if (IS_ERR(label)) {
>    173		dev_err(wm831x->dev, "Failed to duplicate label\n");
>    174		continue;
>    175  }
> 
> The auto clean up function should check for error pointers as well,
> otherwise we're going to keep hitting issues like this.
> 
> Fixes: 54da6a092431 ("locking: Introduce __cleanup() based infrastructure")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Acked-by: David Rientjes <rientjes@google.com>


Return-Path: <linux-kernel+bounces-102322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AE187B09E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64C71C267FE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BCB1448FD;
	Wed, 13 Mar 2024 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SRwLPK7X"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EF75917C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352619; cv=none; b=Abjmero0wM0IxigtL0IcoNbNDUQR2Cc72SE5L/eVq6HW3WBbQdkgnJqIqg9hLaUstAiQTkG8Kshtz4ujSQiDTCexwsxvpeSCipUk7y5Df0mHVneqe5nudA2+j9HR35F1fBub29yh5aMDnzoDcm6brUAFUN5ZcvN02nGe1HLssGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352619; c=relaxed/simple;
	bh=Il1ZTrrhxS2JwxtKteGg8c15At7P4qQJlxAx1oYisIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMHwM8431h6xWn7VfvPVAJHUYLvn6rqJH3FocfytORb6W6cvCISryOxS1dscom4y1BB5LiXLZGmT9JdO44pxTzAyqWeuBEUU/Lbj/dyOFFHGY33NBgq2gxXkgOMMxhQPIW3pSSjBBgk11jM7/NnqocrYW6SrI7CDtSY0HcLAKvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SRwLPK7X; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-566e869f631so138721a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 10:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710352616; x=1710957416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gXZwYoXbJPdWtL2uBl+Xzu/HgUqqQqktfQtiEj7JuE0=;
        b=SRwLPK7XQNLhM/5uVb1b6QxlXJGvcB+E2m1BoD0zyrUUKANrDCwrZmq79y8mPPLKTL
         nLMlPoD+6ffugAEXn0V2NtSzii7tIjuAcTDpqpgMShTsptbJmmOhWOE6p+aU8yjrquNP
         DCapgvdi5XjLp/AHhVl42xqjLqftAQwKDBfGcymdp461vdTBoN/4xcdwprQkrkCDVvD5
         s2I8Q3zaGPHHTF0dSV1QU1QUr7XF5volk4RmvWb+MDEaqJny2WAbKEJjSd3zjx/2HL1H
         bD0jpnujGRgrORlboXLms+pbFcOfRXCaVmnmN219rT4zNBLX2VrTY51+A9hsPE3o+bEC
         k3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710352616; x=1710957416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXZwYoXbJPdWtL2uBl+Xzu/HgUqqQqktfQtiEj7JuE0=;
        b=d0GXK2uNUD5135a1h9X3SxcTuMk+T4qlrglpxuxqCXrU7VOuD3XoPwY/u7BkGOyCcO
         1PK8c4QGTOCse7oueQVwTOxAfZHQu3EUgaHGil1gOiZYe21bL2GP+7TaGYGP6cgux8Ri
         L8Si/D4TUcA+22EfHt6kKy1efLRNx7oPmTHClFxeQiLcP0Fb1W58ix25Rc5xqQ1rH7wo
         BrgGdaER4eUeSZ9dlJY8KqeLeXnfw/SSXfAHoJgwtJ9IFPx2nxpYlbfWpqjPf7e3sV4p
         T4l6oXPcjVuBPKiNJxftybTMmDnwMK7LYfxsvqVvx2L4U6XnhXJB/jx/GSdpfOhOB8UT
         nJ7w==
X-Forwarded-Encrypted: i=1; AJvYcCXDKwjp/qCDDXQEO81FaInKuXkwxefoSmFaXFKfPlMjUobMZX5xS03378pPJiOsE0ME9Jjf67DkwV6LUL0rfAPcG8NBlQK6Czmwaz2k
X-Gm-Message-State: AOJu0Yx79hh8Z2eVKxAxVkQEWHrN3mjgzrrpzCluj0B0y3TqPN9jHmq2
	uPESFkfG/oK+tCJh6cIRX2tOYNafeLPwyBkKB/DMzlcwQ3kkR8/TK9bZYYsZNnM=
X-Google-Smtp-Source: AGHT+IFMICn1OAbDlmUEX0+eM+0X564WncVJ4CS+mHVBBJ1+2xobFpP0SJzPOjoFCL42xKef/8oJ/g==
X-Received: by 2002:a17:907:8a85:b0:a46:5e38:29d7 with SMTP id sf5-20020a1709078a8500b00a465e3829d7mr1637002ejc.10.1710352615843;
        Wed, 13 Mar 2024 10:56:55 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ku2-20020a170907788200b00a44936527b5sm5062753ejc.99.2024.03.13.10.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 10:56:55 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:56:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vc04_services: changen strncpy() to
 strscpy_pad()
Message-ID: <2b7d9a97-e180-4bcd-bc75-bde09a6d2157@moroto.mountain>
References: <20240313163712.224585-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313163712.224585-1-arnd@kernel.org>

On Wed, Mar 13, 2024 at 05:36:56PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc-14 warns about this strncpy() that results in a non-terminated
> string for an overflow:
> 
> In file included from include/linux/string.h:369,
>                  from drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c:20:
> In function 'strncpy',
>     inlined from 'create_component' at drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c:940:2:
> include/linux/fortify-string.h:108:33: error: '__builtin_strncpy' specified bound 128 equals destination size [-Werror=stringop-truncation]
> 
> Change it to strscpy_pad(), which produces a properly terminated and
> zero-padded string.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Thanks, Arnd!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

(Greg is on vacation so I'm playing Greg for two weeks).

In real life, 128 is way larger than necessary so it's not an issue,
which is presumably why you left off the Fixes tag.  Anyway, it's always
good to replace another strncpy().

I see another bug here where m.u.component_create.pid is never
initialized.  I'll send a "m.u.component_create.pid = 0;" fix for that
based on top of your patch.

regards,
dan carpenter



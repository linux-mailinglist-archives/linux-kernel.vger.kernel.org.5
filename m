Return-Path: <linux-kernel+bounces-123582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87469890B57
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97B61C2BAA1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B942139D05;
	Thu, 28 Mar 2024 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOUG6jzd"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456BA137926;
	Thu, 28 Mar 2024 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711657767; cv=none; b=Wnm7WXR6//5v0ZW7h/8w9+NVH4gI+Ay8w+1rgTajXibTmumLWalH55d6g+uc6ZQSpl30R3AoUYdezfxVh0M1kq/z5yEw8zgbnYkbhWjSx8vvHo2w4EdSEMvcP3nX/27jdj0KUS4y4/kP/2SylUrtafy15FNOPsyWKxezU+gDi8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711657767; c=relaxed/simple;
	bh=GUHoYh41apx2c6dWTybZgJgEWn4tU++cGOSJbHHvfBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsoQ8oiC3WdL8mKoQZCv2Qo2lCp5ZgFxv1LyD0cQxycXX2RXZPKwWjcIt5cyjjUD2rvXpQY5z7jnfnkUsMrGszmsuAtejRclQSjkTmVlHSbR1g5LVzePFThiYF0QPGevHc7XipxZGgW2h589KHFfT3f6lFvQ0dCvu5hSnCJFiZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOUG6jzd; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dfff641d10so11131705ad.2;
        Thu, 28 Mar 2024 13:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711657765; x=1712262565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9GhNQzSHHc86tRAgn705m3Syl4j6IAhYWdkgbrH4eA8=;
        b=VOUG6jzdkbKLbcwpTGFuPW6xE8X0ujn2Put59SP1SzDqPGOq6BazPaG1pAKxZkcW5I
         qgkk82WA3EEab25+nYhGnrU9mmjKAlFigX5/4bHakULkBHD8xS3N9sHDAHCAZ9Z9IbsH
         +8mHL/kbFkyk+XfeNl9dN78er0XB1a+4lsDdF67kru09NVKvdyAo+XOZCB7hOf7IqeBy
         uzl6e1ao6wZ0eZLkHgMrXdS1Pp0swEzl3jukmmxvh2Od9/xGxCdu2uz8vjf6/eLdQsi5
         iVQ9Rt1KoYiRtDvmrH/j/f1caB/TaAwbVp8W2naJDPYj3LgF80DGXyPHOAFsUkn5GSYW
         U9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711657765; x=1712262565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GhNQzSHHc86tRAgn705m3Syl4j6IAhYWdkgbrH4eA8=;
        b=tzOapL9ibhDzSz9/3zv9B3dnAc7G07QHsaCxkXvm8hzm5osg8/GbLOenZ3pxV02UtD
         jCEygXMR65WUyq2t9AYE/FaAcmZXKjYJi5tLvsydneeGbvlCyRk+LXPtiE+/i32Br9hg
         l76nzwWbbsikZgYf3RMcu3VC99A/hc1JWmULybOg1GRLooAvDyLnuJundgmXRwfNfIMO
         GNkcHv8kqgADBAc4KyngEszccuKSvcKwlEQAP24THaPZqVHlw0xOWq8KATKZ7N0yQ49u
         diGYUoZGIBKvmMGuiEsLIICN7HAXiPFyW03LDPa/60zUQnHULSpSoeryYWDM/x+OvVEO
         kedQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4IoXaqg108L7wk8jSR21EJeXrCEWjlKJoajyI4+OHth8lTR2w/uYdhdGS0ckLOhr0HnkN2opT8FnwHi9UbmPcuDgW9TcNKPaWyYjmNeTrUiQjnlm6CRiumqtd0pALhqj9qCSpgHITJJQ=
X-Gm-Message-State: AOJu0YzDOF9yjfe0NdFaQbzP/iR8aZhLsjqCcx56Ly5Utc82WXrRiQTx
	6bqqcJ8FOv9aJL1fIEHi9oh0jw8WCvJ8zTt0NlTvxowkSrLeIJTM
X-Google-Smtp-Source: AGHT+IFimJcn5l+m2AOuz40t+4uD8F9bzZLa0naXbrZzUKaihGqgPB0DWFwfG02SitApE30c+n5WGQ==
X-Received: by 2002:a17:902:f68a:b0:1e0:f4ce:f1c0 with SMTP id l10-20020a170902f68a00b001e0f4cef1c0mr708040plg.2.1711657765541;
        Thu, 28 Mar 2024 13:29:25 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:493e:82a3:49f9:d88])
        by smtp.gmail.com with ESMTPSA id l18-20020a170903245200b001e09322cd01sm2058971pls.45.2024.03.28.13.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 13:29:25 -0700 (PDT)
Date: Thu, 28 Mar 2024 13:29:22 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	ye xingchen <ye.xingchen@zte.com.cn>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] Input: IMS: fix printf string overflow
Message-ID: <ZgXTIiCvvj-eu6p-@google.com>
References: <20240326223825.4084412-1-arnd@kernel.org>
 <20240326223825.4084412-7-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326223825.4084412-7-arnd@kernel.org>

On Tue, Mar 26, 2024 at 11:38:05PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang warns about a string overflow in this driver
> 
> drivers/input/misc/ims-pcu.c:1802:2: error: 'snprintf' will always be truncated; specified size is 10, but format string expands to at least 12 [-Werror,-Wformat-truncation]
> drivers/input/misc/ims-pcu.c:1814:2: error: 'snprintf' will always be truncated; specified size is 10, but format string expands to at least 12 [-Werror,-Wformat-truncation]
> 
> Make the buffer a little longer to ensure it always fits.
> 
> Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thank you.

-- 
Dmitry


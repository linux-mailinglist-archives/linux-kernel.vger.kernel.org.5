Return-Path: <linux-kernel+bounces-105868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B4987E5B9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FAEB282A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ED52E645;
	Mon, 18 Mar 2024 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="aT6znPyw"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE052D045
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753957; cv=none; b=EWenc0t1pXfC46kdxR75s7omG0x5tGk+km31d7F/uUmUqcuSs7e2zhtpJmDc634Yu2mXPjSklnPIQrSM6svRQj/qaRvlKQigAGsGKUh+xcE0w6eidE3noczPxy8rjF7LL38rmVDRz8q9W2ihnIQ17Yy4AhYzjteg1YqKRl0O4SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753957; c=relaxed/simple;
	bh=zEOm0EiFBqFYUj8BdCzuvUG8K0L0U3LAU+dVKRjw4k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3UvtjBGqw6GeXvDZbMeGtQyq67U8au4nPdpyTMnBe/CfszotIvJPLmKaoBhJ3sl1vuaTIJsNvFtE9C2qFt+DweXX7orDZ9Ux8KacaHNqW8CdE5jvJyiI4gY4kq5JEnoBKCQXPLWa1i7/dxJdqxuZWSTT9dFDhm6RHdq12Ujh3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=aT6znPyw; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e672e10cfso2044177f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 02:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710753953; x=1711358753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zEOm0EiFBqFYUj8BdCzuvUG8K0L0U3LAU+dVKRjw4k8=;
        b=aT6znPywi018D1glJqK/30q2e2xOFfu9dA5wrsZMju/zuzKH5FedzamUWzusnHwRW6
         5zH+99mA1GPtTbVjWVkHOR8Jlrg7v54X/JYa1krfWOJQg0USN7seE1thB8nUChXwt3EQ
         9YJCJwZhrZ084CYttNpyJq4FQoIlz34SA0DXKkU1gTfHEgZxV6gS0wOdzVeKiZWFZBzq
         VsoYDd56uvFr/WRMcD7gMB6syhNo79XBBRgfLTv5jGqt5WE4JZ2GPsBHG0iu+sBEjXCK
         xgQ/MJFAC5H1O3hIFzANo81s+rOGn4COGwal5GnNeWG0lizhPd38rARo6wn2rInTacLD
         powg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710753953; x=1711358753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEOm0EiFBqFYUj8BdCzuvUG8K0L0U3LAU+dVKRjw4k8=;
        b=cQqv9JWQJgFTVkhNGKTjsiExf2xmgk+twGbL96m+YA5U2PqOY1gT0+CN9rI7q9VTi0
         4A30XWvFFTSoORNw5EAkbTn1jmoaOxAXiYo71XRVy2OJA8wprTQwqCJrJoycImzCuT9k
         23u+VCK8WW5PndHOeg+nD0iaZ5ZwWu7HviTFBoyothGRLwhxvk4oOtRAu4Rnp3XQh0eT
         ZKAgSKq2wDd9DKiPDqGBnsM1apc32BMeY6WhktbDP4La1u/tUsM2S1WEW49U9maAKTKy
         jcBUgPIESbjk/2k13fsv9DBEUZECnvmmL7UL4vpgsiYmMsTTe+AarDdvgzQyJxq8iXLE
         rnpg==
X-Forwarded-Encrypted: i=1; AJvYcCXns+P0OVwzizCzp9gLXJocdx/mrN/PWD11VKwgG27GhSbDY9ZFcH6/gZhtzanYOKIiyoTM72vYAlMpB7oxSF9akeT8iKGAfOALddUo
X-Gm-Message-State: AOJu0YyildBeAjnI32tgtOO+jgHuRIYVlsoJ2J4tMAc1bBdCjOuzmTr0
	JCcC+yigAGRobcOcAfKeylXjKYRzMaOY1Y8csEEVyX0D9qBwWywoBRRKknY0Oj0=
X-Google-Smtp-Source: AGHT+IH4VruI12d01sMu0QUhvz+bFlGKzrMX1TpGt3UETCdTqTB1BJVof+0IldCD67i/nPgANjkeRw==
X-Received: by 2002:adf:e582:0:b0:33e:c2a5:15c3 with SMTP id l2-20020adfe582000000b0033ec2a515c3mr8423129wrm.41.1710753953291;
        Mon, 18 Mar 2024 02:25:53 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id f10-20020adffcca000000b0033d640c8942sm9355029wrs.10.2024.03.18.02.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 02:25:52 -0700 (PDT)
Date: Mon, 18 Mar 2024 10:25:49 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] caif: Use UTILITY_NAME_LENGTH instead of hard-coding 16
Message-ID: <ZfgIneq04KwBPWqV@nanopsycho>
References: <af10f5a3236d47fd183487c9dcba3b3b3c66b595.1710584144.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af10f5a3236d47fd183487c9dcba3b3b3c66b595.1710584144.git.christophe.jaillet@wanadoo.fr>

Sat, Mar 16, 2024 at 11:16:10AM CET, christophe.jaillet@wanadoo.fr wrote:
>UTILITY_NAME_LENGTH is 16. So better use the former when defining the
>'utility_name' array. This makes the intent clearer when it is used around
>line 260.
>
>Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

This is net-next material, yet net-next is closed.

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

pw-bot: defer


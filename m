Return-Path: <linux-kernel+bounces-13788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A232820EF9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 22:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C7C28262B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 21:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AB6C13B;
	Sun, 31 Dec 2023 21:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBu98d3f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814B4BE47;
	Sun, 31 Dec 2023 21:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bb9b28acb4so5322241b6e.2;
        Sun, 31 Dec 2023 13:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704059133; x=1704663933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKsBy9hdrgBDv+9lbkkexRpE8/6en4orssBBHouRAoU=;
        b=GBu98d3fQT47mJmFlOcAI+CXeckXDZSD6/6fpp7ZUYnc7MVHsJ4rbY68wM4qkunB/W
         CtBlRUB3mfu+mw5Jlw/h5la0eISpdPZVUsXVhMzrMwhZhGGTMauwIOsTSF0vWNOm1oN/
         gGFV7J/6vs15CMjEv+QLw6iNOffznUCPPvkQvUyqhxlRvLuPyVL5AqYBhr9uwilFisK9
         Jp2arX4+/GbzJ3jJDvLUOPnWzvDXbws9PLywDz+A6Ny+aJRkaoB8VbIpTj/nHeLvfyIi
         CcX9xadWqfLToM+slKGmjLJZKjfHOs+g55sJXYdcXHwLu/lsja5VOKpyZoaHlTvqQ6KT
         3iPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704059133; x=1704663933;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RKsBy9hdrgBDv+9lbkkexRpE8/6en4orssBBHouRAoU=;
        b=ms/1e5Jvw3Q01q9oFljyvrAEPJt4lBo4BefS/bRuQwGYrQARa8OaDYhhO4/uWth6X1
         LMp2NNrUXNOSsazXG5huAaJBsGVha2J5SEfk5tKVjrHOKOnkyrhH0sGOyJ1UBu0nhbkt
         LdxMQls1wsuwTkpLx8LkhPe1AoSN2dOOtG4zcb9mH2p+SLjwyLQWpDDIYo22urolHSDf
         KTB1YkS09BSGy/anlLjhVd9JvUHKOus2kzqBgnPkg65zL1mBKMJsjyvXRM7psx9Aw+Jy
         PJmLhyaidZ8PRW/mvSDDolpNOalQ1QFnbW+bsa+tBEtXgKKB5M71W6QzTjuI8GeMZsts
         iFBw==
X-Gm-Message-State: AOJu0YzPPIu7yCDoQlu6qBx+1frd5FjSLhqJqjMhWWBVKDRjhSYrlpfT
	K8njMPPnFOiShJfGJxttI7A=
X-Google-Smtp-Source: AGHT+IGfBgWzhPIFobt+ZRpXau9Y9HqHLyldknGnqXmMw9U0gV1smzqicW2ERGRPuFW1hCrP5sxQ+w==
X-Received: by 2002:a05:6808:2191:b0:3b9:dd70:7660 with SMTP id be17-20020a056808219100b003b9dd707660mr17086741oib.11.1704059133558;
        Sun, 31 Dec 2023 13:45:33 -0800 (PST)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id n13-20020a0cec4d000000b0067cd5c86936sm8869073qvq.79.2023.12.31.13.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 13:45:32 -0800 (PST)
Date: Sun, 31 Dec 2023 16:45:32 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>, 
 netdev@vger.kernel.org, 
 kernel-janitors@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Message-ID: <6591e0fcb089f_21410c2946c@willemb.c.googlers.com.notmuch>
In-Reply-To: <828bb442-29d0-4bb8-b90d-f200bdd4faf6@web.de>
References: <828bb442-29d0-4bb8-b90d-f200bdd4faf6@web.de>
Subject: Re: [PATCH] packet: Improve exception handling in fanout_add()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 31 Dec 2023 16:30:51 +0100
> 
> The kfree() function was called in some cases by the fanout_add() function
> even if the passed variable contained a null pointer.
> This issue was detected by using the Coccinelle software.

It is fine to call kfree with a possible NULL pointer:

	/**
	 * kfree - free previously allocated memory
	 * @object: pointer returned by kmalloc() or kmem_cache_alloc()
	 *
	 * If @object is NULL, no operation is performed.
	 */
	void kfree(const void *object)


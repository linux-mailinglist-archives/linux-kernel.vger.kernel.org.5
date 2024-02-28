Return-Path: <linux-kernel+bounces-85684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2F086B940
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C426C28BB70
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C69A15DBC1;
	Wed, 28 Feb 2024 20:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmQaJjp0"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3287571ECC;
	Wed, 28 Feb 2024 20:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709153311; cv=none; b=k65WI+qVmGn/uuh8S1Wvc2uiA0QH9Ha/jMU28z33BjnJQ2BCQDhzfKmGR8ekwjf+FgrLhqVi6N+rhSmCz0ofOZJSCtXva1Pt+7Ieo03x4yWUrOttVRgENmuEhCWRtwSsRCZqewprJklJupaSzwTmzLGX0C9yc1ZH/8s31S+HhXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709153311; c=relaxed/simple;
	bh=sc9lmdVdnWjzr9GXmsOHgqaQTFY20puZMxHYxFdT+V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiBacJGN5ok2rGQnEk0VwloX656msZcq931Uu0r2425guz1fXzNa0G6TtPMwLhjAcV9RWvbnT/SfT0dcar8HfU/DClHaARq/TI3K1ApRcWRoemJ9Dseg8rxk4pX4+lvFaJ8ShQI5vcW8MdSkJmLQ1g3hrYjwtJ2wAF2qs57gxCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmQaJjp0; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d208be133bso1956011fa.2;
        Wed, 28 Feb 2024 12:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709153308; x=1709758108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BmqUGFRY/SaPBZF7+G6xmjp7oKqZJPMre8oiME7ffw=;
        b=NmQaJjp0cOwow5W6YgLybJlJKigpdWbUUOPR/nYJLV82vYAbGog9x96xzup52swkR8
         8AV/2C1mLN7Rs+9D639nr954G+pFvr5u/UXom0TtyFjlm146P45vxb3ZPs0JBoZNGEPZ
         EdgLj5fJkePnVUnHHA6aSxVJ+Ha/YmeDp0pewSH7Wt/2LT/6Yr/27XgWsMwAvziRcrG9
         t/8GNDNGTX4bQYFOXjfWFQgkDKL11AVs9YcVEEjbBoSzWdskMVtel8kGXBDmNhcgH3T0
         gRREUOfeiSwNmaZcQbgejkxy+X0H6lf7pQjZ/XylVLbTZ+NO5db8a2SLCwbDhGmlPlRc
         gx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709153308; x=1709758108;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/BmqUGFRY/SaPBZF7+G6xmjp7oKqZJPMre8oiME7ffw=;
        b=PHNakAN55NP7kL3drtpIDhBgQ3ByMJG/Fr2Jh32UVebaiZJWfQxtcQQxptFWGh44tP
         SAhLJsrK2xPtLh1g/Xlpyxa1NnlEnxr+QGAqlDqtCDd/WPQlCnZSEXZ3h+lEzoOTDmao
         8aQcYzAP8ljBmqd9nZsJGymzaIDPiHSJYy7GZgG/MgPchV2KSOgVIpr43EV3A41YgB/L
         NmP+0dKwn3o6sztbhN662WeB3XAdJ/fleOCRRRuQ3qcmaFsmTHRqJm35Dp6ZCkpas60S
         Rw9dH6DvTrBjM/nXKKKbvO5EdhRKw1tF9PlWpCkhZq308yKRmF9Zdw8x6ElFq+IsHmFV
         vj3g==
X-Forwarded-Encrypted: i=1; AJvYcCWLdTZxyHIBaWQSZ6ud4VbfRcskqx3NZ8DyQYMemjIcLnWdrgSIo1fewaKKyMmVLH+DvUUbHg8TUwxzpr6Dmb84keZ0C9yKBrDrrFf473BOTkrfBPlQ+cP7QdJan0kj6jY30Ew7Zo5TElvX
X-Gm-Message-State: AOJu0YyXAHxdQKMJsLrktMngw30RNEsDOdvG52zmhBRt14di4MpVkX03
	x+jF2sT9yAtlLQFBR+e3HLUvojwjHeWeb7oS0GtJTQgrcxigiJzF
X-Google-Smtp-Source: AGHT+IEp4+S8PJ3Iy3G8JacJ/zGYQqYRnXtYNKRVleZnT+aUT6/tQTfndsvknSO9gs11R6K4StiWhQ==
X-Received: by 2002:a2e:b81a:0:b0:2d2:2ddb:28c7 with SMTP id u26-20020a2eb81a000000b002d22ddb28c7mr11257ljo.26.1709153308004;
        Wed, 28 Feb 2024 12:48:28 -0800 (PST)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id m14-20020a2e870e000000b002d2a710f864sm36245lji.24.2024.02.28.12.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 12:48:27 -0800 (PST)
Date: Wed, 28 Feb 2024 23:46:12 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Ovidiu Panait <ovidiu.panait@windriver.com>,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH] crypto: sun8i-ce - Fix use after free in unprepare.
Message-ID: <Zd-blOvXjU4_t8p9@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Corentin Labbe <clabbe.montjoie@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Ovidiu Panait <ovidiu.panait@windriver.com>,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>
References: <20240226215358.555234-1-andrej.skvortzov@gmail.com>
 <Zd76W98Ypq5uJmqm@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zd76W98Ypq5uJmqm@gondor.apana.org.au>

Hi Herbert,
On 24-02-28 17:18, Herbert Xu wrote:
> On Tue, Feb 27, 2024 at 12:53:57AM +0300, Andrey Skvortsov wrote:
> > sun8i_ce_cipher_unprepare should be called before
> > crypto_finalize_skcipher_request, because client callbacks may
> > immediately free memory, that isn't needed anymore. But it will be
> > used by unprepare after free. Before removing prepare/unprepare
> > callbacks it was handled by crypto engine in crypto_finalize_request.
> > 
> > Usually that results in a pointer dereference problem during a in
> > crypto selftest.
> >  Unable to handle kernel NULL pointer dereference at
> >                                       virtual address 0000000000000030
..
> > 
> > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > Fixes: 4136212ab18e ("crypto: sun8i-ce - Remove prepare/unprepare request")
> > ---
> >  .../allwinner/sun8i-ce/sun8i-ce-cipher.c      | 34 +++++++++----------
> >  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> Patch applied.  Thanks.

You marked your rockchip fix for backport to stable releases.
  Cc: <stable@vger.kernel.org>

I think it makes sense to do the same for the sun8i-ce fix as well. 

-- 
Best regards,
Andrey Skvortsov


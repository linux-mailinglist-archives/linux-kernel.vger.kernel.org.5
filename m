Return-Path: <linux-kernel+bounces-48521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 191A2845D37
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26762951F1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F339D7E0FA;
	Thu,  1 Feb 2024 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Rjktm5pU"
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68AC7E0E5
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804808; cv=none; b=TtXisq2HIUlMXLu2R0lzm13yaJ9U0EjesLrZzC/Yf95+HWGzeHluVfSCBsKApKqN919D7v74Q//t6/Y1GLupvSKOgb89oLPMPlc25cvb5NYjGnb2TYzaQ5P+je8D/4onlPK2K63CiiQWauUMI/TMOo2TK2RVsvLR7Yd/HykSeG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804808; c=relaxed/simple;
	bh=S3AjnrNIx5BKudNt+FuYiHFiKF3Aoog4fHYyZ72OBkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hG15K3x9coSWcmn8kRsqex2YHurxsTXNvgsIt3MYQcP0Fherlvc7zTuDW31arSb7qr8cCX4Cfd46X0f5PY3QDQLOwsvtje8mo7v8vL++Uc1VefB701Z56iiAKPJZTbtw1f2OZ1Bh0Yz3TGyuQwEzmb1pGYpgXWQWepTJSj89D64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Rjktm5pU; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-510faac8c57so966577e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 08:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706804805; x=1707409605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iNllvtHZDHAWtrtv2nUVEGYjjg2CQe0uH6p+qaHk/zI=;
        b=Rjktm5pUVyxOb60BFpT4J7/l7XAiVE49lWn3tmI560XqkqFWdPbfRfDCoaQ8/3gDrg
         BCK//eBXLFpLavkyk5ry0s250XSHU1gSOOpY6jU8WwXqgmd/ttNWpSmuEyQqTAyWDbL8
         aGXK5pk7Xi7Z5v5VZ8IhhO1eJLZ94bzhZM4JQIGnIvEDlsgveOWSfELr/8q1Kh6rc+im
         9om+BP8YU/V3yYXOVBBL0RidQ1TILUHs90aVgyUPLn9Xlsk+f5uKqu4wDme2+Qsh4snU
         OuZc/FpwCb7iSb7YOx4NgCU+6XJLy9NjBkAj74s1ricXtQwrr1XVTYwN2/+SGIOYyQ1V
         j7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706804805; x=1707409605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNllvtHZDHAWtrtv2nUVEGYjjg2CQe0uH6p+qaHk/zI=;
        b=hd3D5dMd4C48qdqP9tpN5LT5UIJ0BGGM8k7iiIb3/5xd1zOvwBoVnE5mD6HvVXmZye
         2nrqtmU4DsYlnDqkz2wPFvB5X3TXApjcZzneH32uKNyHjlbEzAkS+OKMZajeaIwm++et
         5Qm7Dj1Q77jqC5W0LVYLO8eia3BAmvdsmocE4JitJxu5DdxuxRodURithLCkryrod0KZ
         j6fRsHGIfNqbSRCrfuL5L/0gol7amhPzjdnmDh2Kpap1qaIQe1j814+n/SLZ25tb7MuS
         4XKtF5Y3a7cYOvDAa42fu9xdfMsSOnfMSCVci1YO7Qst+YyLFa652ThTW6GTYRGJarOb
         kTbA==
X-Gm-Message-State: AOJu0YxZs+L8JXj+AOcRjjE2OMqffoZjPrvR8/sR4VgRIoTh+RSxqycz
	guHfq4jTVQ5jnbFJ8vmwFrICfRjrMpXJYB/lA1fwXKGZVvJQUxKmkCNEiXIGp+txMwhlX6oKhc5
	Fql7wtg==
X-Google-Smtp-Source: AGHT+IFpHJ9fDp3l9urMIz13d5uHrF2tLGi6nIvV59bVO5ddL+GvcU3faJHjeQ/t/EVxkT02aIk5Hw==
X-Received: by 2002:a05:600c:3151:b0:40f:aabd:b83 with SMTP id h17-20020a05600c315100b0040faabd0b83mr4429255wmo.13.1706804501869;
        Thu, 01 Feb 2024 08:21:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU5l2dL8cK1cAB4grrA4V4D/XQXZKGpCwYEEgqMb5x2x4dcX8OR4UqDUNJHrfM/Iutif0muo/x0eAIkmpruVJZnVcs/yVyLqxI39v/alBmjYu2llkaZleZKNi4BNcDVCYzYsTDzuhgU/2EuwOjDZRJgMh8qO/us6VAOPZmnRo6b+n8aBxRVekETd5nBmkVhPgTvzDNc+cgtUoS4hGm3ef41cvU0uknmWbOvNYRMhr90Tw+0z6qHoGbYHnGj0JxhGFn5LnFDw2US/FhLgUITymjqLP1zAZuOLkSzweUB4SQworFLPUb64QcjksWzyPVI+hDEEDCXhPjUkJklVZ18BlRXw+iiv+Kyx0YTRI6g0oRH9nWI1SmaWKiC+OEZYhN2jkPtrvHzuuwxD3EzfixyEg8RJdwl/k034Il6jb83p5xV6j8keHt/nFByX83dtqLhVMqzG27njGZHXKGkc+YvoLDGVl0=
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c154600b0040fa661ee82sm4903623wmg.44.2024.02.01.08.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 08:21:41 -0800 (PST)
Date: Thu, 1 Feb 2024 17:21:38 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Aahil Awatramani <aahila@google.com>
Cc: David Dillow <dave@thedillows.org>,
	Mahesh Bandewar <maheshb@google.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6] bonding: Add independent control state
 machine
Message-ID: <ZbvFEtQskK3xzi6y@nanopsycho>
References: <20240129202741.3424902-1-aahila@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129202741.3424902-1-aahila@google.com>

Mon, Jan 29, 2024 at 09:27:41PM CET, aahila@google.com wrote:

[...]


>diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond_procfs.c
>index 43be458422b3..95d88df94756 100644
>--- a/drivers/net/bonding/bond_procfs.c
>+++ b/drivers/net/bonding/bond_procfs.c
>@@ -154,6 +154,8 @@ static void bond_info_show_master(struct seq_file *seq)
> 			   (bond->params.lacp_active) ? "on" : "off");
> 		seq_printf(seq, "LACP rate: %s\n",
> 			   (bond->params.lacp_fast) ? "fast" : "slow");
>+		seq_printf(seq, "LACP coupled_control: %s\n",
>+			   (bond->params.coupled_control) ? "on" : "off");

Hmm, I wonder how it makes sense to add new features here. This should
rot.


> 		seq_printf(seq, "Min links: %d\n", bond->params.min_links);
> 		optval = bond_opt_get_val(BOND_OPT_AD_SELECT,
> 					  bond->params.ad_select);

[...]


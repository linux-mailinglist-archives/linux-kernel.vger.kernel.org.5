Return-Path: <linux-kernel+bounces-160995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 019E78B4591
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 12:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE46A1C20E96
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 10:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCC04204B;
	Sat, 27 Apr 2024 10:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2B3HzAi"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81E420315;
	Sat, 27 Apr 2024 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714214320; cv=none; b=IA/plOQGAnJ7+JiqqmRLZLfkvyKw6UldWMU0fzeclT3RgIfNsu3CN00gfj+8sCzQeaz5ou7HNXpULM4hzEVoyCKsayUdNx3BUVXj7tR5GkVi5UQQc43z5xkNGiEI/7LAy7tHPU5knfHNdejd+DeVhH2IVzJz1JIzRMGyyXD+qTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714214320; c=relaxed/simple;
	bh=UT0NJhUl3yUFZue60oG3G3YH8EA0gbUMdJK2DTOIcgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9rZ9edyiTlfdf/x/qFAJePnVT6V6fuoOIPJ+40BnaAGdSheLr0In8QD8Ulm6gMACYMp642zjVvQd/FrhLejhzmZepPNEPlalnD+b2RaVYg8CuGkb47drlTwSIfPdDxrpZ8XpbZwMQ7nw9YRLVaZQR6SXDXRjBSGw1Jeuj3+cqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2B3HzAi; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e8bbcbc2b7so27533375ad.0;
        Sat, 27 Apr 2024 03:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714214318; x=1714819118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TFayd8WsB8iriwu4+EdgZBiqge+lZHkuxMsZXJFITrk=;
        b=S2B3HzAiqDOQ2yn3tiFc6znuZ1VLr4RQydi/tteG/9/JNVX1c6D5AB/f24IBo4nnj9
         pe5M1hVN+sNOlEovVNVjmGeN6P+0aUlE/HUAjF0XSf7tiJjl9FTVpm3NN8/5hDYcWfca
         8X9nk9C1Xqr7/X/sQfOu9kONvttAapqg2fNoKpXP4rBcAJdFgvwCfaMkQuWFzSTKBEkX
         RaqhamALuAvQrp6AXc6xyAxsW23/Rwd2AxqdCg/u6gzMlFHFT2FZM/Ic0RgrMPM95yhB
         qkXEjG2sNh9FXZJxMEeDJ0gaZmmBgPvyhP1PArO13RmPqwD5gTG7gDP6+NzUmmsjy8pg
         1fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714214318; x=1714819118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFayd8WsB8iriwu4+EdgZBiqge+lZHkuxMsZXJFITrk=;
        b=M+KEXUyEAOLXWjPPJcdIT8rfu5nbYHy0MSW0IKIbvo6EgLzmPpqr2rHDwTiLcjyqx1
         tN8mx6Is/k2gREAIVQOBa6O+0x/LdhGyPks/weLG/dqbTJeMqX//tBdY1dQc77Bs+9vn
         5zx9bRS0RNgvfFXcLZxAdc336yfSKiQ7bbK8EBxD3ZPgPEwTR0JdSvQaUjCc/8/MWd42
         dRolxP8UrkUc4Rfkt8PuIc8Ft9dSVHxei6Jc+Wo+Vgb6FRvZaaMO9OD78YkmF5lvtR96
         CLjWdRbBu4ynL3rDLT5x1SNcjsayya5XPdm86PZzg6tRqWqUrpc/fDvoZhW6fEbQoQXO
         /4rg==
X-Forwarded-Encrypted: i=1; AJvYcCVG43pWZNwVPjs3NR1uq8CwuyNoW2tpX1n4oXbD4ANVb3fdn72pkSui0TIXSe1KBBS3BUbDNxc5gPpmJ0FDqLcAVbXLbuFxe4ZyZZhby52/bg8cqWgubiuE/CZT0uAnHUAFKUUok4FD
X-Gm-Message-State: AOJu0YwvUsWQID7F/k7hDQVOVPEq4g98U0ge4SB8sWuhs+MTZvYyaBfI
	3NelYOT1GBYXagcb+8juaz9mzGlix+vt45KBX12qsSmVysq2L2+BGotBfb5E
X-Google-Smtp-Source: AGHT+IGleDfSPZgWy+4ngyeFVpozjzdXKe8RGpmXemgZkZV+UI4m4zATaCkw0GgvzwLWHknT2pYTGw==
X-Received: by 2002:a17:902:6509:b0:1e8:5dc6:4060 with SMTP id b9-20020a170902650900b001e85dc64060mr5749859plk.33.1714214318027;
        Sat, 27 Apr 2024 03:38:38 -0700 (PDT)
Received: from localhost ([2804:30c:1f6c:5400:ea32:e7c8:5bc0:103])
        by smtp.gmail.com with ESMTPSA id j9-20020a170903024900b001e8d180766dsm14804058plh.278.2024.04.27.03.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 03:38:37 -0700 (PDT)
Date: Sat, 27 Apr 2024 07:39:25 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Gustavo <ogustavo@usp.br>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	Gustavo <gustavenrique01@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: adc: ad799x: Fix warning generated by checkpatch
Message-ID: <ZizV3UWWJkyH5kmr@debian-BULLSEYE-live-builder-AMD64>
References: <20240426012313.2295067-1-gustavenrique01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426012313.2295067-1-gustavenrique01@gmail.com>

Hi Gustavo, Bruna,

The patches look overall good but there are some improvements that can be made.
First, checkpatch points out email address mismatch. Gustavo address of sign-off
is different then the address used to send the patches. I think this can
be solved by adding --from parameter to git format-patch or git send-email.
Second, Gustavo's sign-off tag is incomplete. The tag must have either first and
last name or all developer's names.
For example:
Signed-off-by: first_name last_name <email_address>
or
Signed-off-by: first_name 1st_middle_name 2nd_middle_name ... last_name <email_address>
I'm pretty sure those actually must be sort out for a patch to be acceptable.
Some additional tips to improve patch set quality:
- Don't use file extensions in subjects
  iio: adc: ad799x.c: ... -> iio: adc: ad799x: ...
- Also wrap the cover letter text to 75 columns except when it makes text
  clearly less readable.
- It should be okay to say in commit message that a change is suggested by
  checkpatch or fixes some checkpatch warning as long as you also describe
  what the actual change is. You seem to already be describing the changes
  so maybe adding that they also cease checkpatch warnings / make code
  compliant to Linux code style.
- Maybe have a look at the submitting-patches documentation [1] and
  tips to write commit messages [2] to help producing patches.

[1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html
[2]: https://cbea.ms/git-commit/#why-not-how

Regards,
Marcelo

On 04/25, Gustavo wrote:
> Clean code of iio:adc:ad799x to avoid warning messages. These include proper variable declaration 'unsigned' to 'unsigned int', add blank line and use of octal permission instead of symbolic.
> 
> Gustavo (3):
>   iio: adc: ad799x: change 'unsigned' to 'unsigned int' declaration
>   iio: adc: ad799x.c: add blank line to avoid warning messages
>   iio: adc: ad799x: Prefer to use octal permission instead of symbolic
> 
>  drivers/iio/adc/ad799x.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> -- 
> 2.34.1
> 
> 


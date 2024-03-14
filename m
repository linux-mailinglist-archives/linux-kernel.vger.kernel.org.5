Return-Path: <linux-kernel+bounces-103194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358A087BC2E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F439B2497F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516946EB66;
	Thu, 14 Mar 2024 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oyy3UeWM"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B546CDB5;
	Thu, 14 Mar 2024 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710416794; cv=none; b=iIN24LQye2RSA343vlmRsFFNoK0ExmUXG63nLrqwyKgPwNuVqyRlsiTOYrsG1KCNuLfLkylV7hmrKYITg7Q3yMdtvqYmXVrvZgC/dENjXzFuTOlYrtlJeMp3cd8XqXD4GWWk/OAdOR3ryv7IzKmYIjN/qhYkcUZRupkbBseHzZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710416794; c=relaxed/simple;
	bh=rVTxIlZr2M2YjqUYASLlemClSium3xGafvHFP+A9HQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sfvdjlSPBMf7FfSLPJr2Ut2vwMm9i/HD1Wsg5L0Np7LwWJf3dYIEjQjtvtPyFnKTlqITWNg7agVLot5vkP1I3gyMZqFrdOfGFCzmnspDNfraOEy1DWlAHiWXD9odggea0TAUKz96JLMH77bcGOfZJXim+EkJqvVxHBoVoIgrCpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oyy3UeWM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dca3951ad9so6232095ad.3;
        Thu, 14 Mar 2024 04:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710416792; x=1711021592; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y+tI7UckBN1Yi/o12xXlz3XnxJFT8If6wGyJEhsz06Y=;
        b=Oyy3UeWMoSMyhvFmzP0uPLWjWaaFkJsU14jhqz7SXGQYLxUasncHDzn4Dr+xyM76aG
         843wf+VXPuxDhRpDNkVa+8Blbq01mFcrqY79l1ifseBn9S2eRy/uGxF9b/MpLZzAe1mq
         +2iMv7Ga8rlJQ3HepcmLOA6e206DuRyvCDFXkZxZsur75386BhSSYVanPsX+jXKS4Pgf
         vSlmc6ju7llYhREInX3H+wBGx7Oyy0N0c+OmZpJrmjzFAQ1BNuRZOwotEk35oEA3I5V0
         N9IIiNjlUGKJtq4YPaHMqZXazyLxpMB/xDpjWXcYaAb4jQGaU0MD3kING6ZW4Yngg3fT
         IeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710416792; x=1711021592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+tI7UckBN1Yi/o12xXlz3XnxJFT8If6wGyJEhsz06Y=;
        b=AjbqmyfmAuZu/9sGPP9veNWs/30KHbHQjS1Tv+WDlxOj17N5Zpah8ko67X2W3am7dO
         LJcIcl/lLuKuamHi5hK0Nt9HzhOVYJWnQmBbg+jedUPbvEdjT1R2FjNZfR58+yFOJsZd
         gxMNWlVBdsjoNtqaQG4ADvYimCM+AxLViJyRClndU2BZ7D8d3ppnwQB4wPy86oXqO/80
         Pep4USZUyrnbsFXU+We4IfIm1LI3733xtcBTWxZGunw2DPaNoYEAhzto1VmaQQUUFETE
         eGGUcNw8D6qcTXbmi6QooINieUFfuo2np6sjv83yangix5inuhGb7cWfEwxKti+dB9uZ
         fGaA==
X-Forwarded-Encrypted: i=1; AJvYcCU0lb0X4P8hHIOfYbXMhBalkAJg/Fos+l4n8DUghAc/GnnD7mdo6D09wLjTTcKhUbn448eaNYLM6WK7KRjyL+6rTw7EWncx
X-Gm-Message-State: AOJu0Yzmj7dijE97bCFEYA3TUIP5U1EGHxVXkp3t6bWv6HDnB7SCKwwF
	b4QI8jBlcPZfb21bjDWON+Q+CqVHeG1nxGrJyg/NGeJBuy0BfcA+JSKPbPUTl22zafqDy982al/
	Tf7BymB9mB8/lZhZR/mGA3kI9UkOKfFhgbqI=
X-Google-Smtp-Source: AGHT+IGHyawOdgJYjSHQOhXi4DF5Jy4M2SYs2DZzAYrxbM0K5I68X/OYe4bEOjL17S8s3G8n47I6kAJ9iCGKl3ebcLY=
X-Received: by 2002:a17:90b:790:b0:29d:e6a2:9b3 with SMTP id
 l16-20020a17090b079000b0029de6a209b3mr75881pjz.23.1710416792500; Thu, 14 Mar
 2024 04:46:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313163019.613705-1-sashal@kernel.org> <20240313163019.613705-6-sashal@kernel.org>
In-Reply-To: <20240313163019.613705-6-sashal@kernel.org>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Thu, 14 Mar 2024 12:46:20 +0100
Message-ID: <CADo9pHis6n7FAtyTUhC0nO8wDaQGT1NzkJk11VcrEzQmG29wvw@mail.gmail.com>
Subject: Re: [PATCH 6.8 5/5] Linux 6.8.1-rc1
To: Sasha Levin <sashal@kernel.org>, Luna Jernberg <droidbittin@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hey!

Wondering where you have uploaded this? can't find it at
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/
but maybe i am looking in the wrong place and or are blind ?

Den ons 13 mars 2024 kl 17:31 skrev Sasha Levin <sashal@kernel.org>:
>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index c7ee53f4bf044..dd0b283998d00 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  VERSION = 6
>  PATCHLEVEL = 8
> -SUBLEVEL = 0
> -EXTRAVERSION =
> +SUBLEVEL = 1
> +EXTRAVERSION = -rc1
>  NAME = Hurr durr I'ma ninja sloth
>
>  # *DOCUMENTATION*
> --
> 2.43.0
>
>


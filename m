Return-Path: <linux-kernel+bounces-143837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CF78A3E0C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 19:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16721B2160B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73E5524BA;
	Sat, 13 Apr 2024 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBj0xraM"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85AB440C
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 17:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713030882; cv=none; b=FUK8iyGO4xyKh3WtyAkeWHxtGghrGLwYKnm43l6Swzt6bwbOnxQVNvYiioqeJMhjG17BV052EQnGMl44mLxyL0sX/hpDoqZjkXztxz06Ggjxq6cUvfArgyn+EsNuHUK97QA1/odKqb86MrhchNmNM1uSlHiKXddWswsBDkfOQ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713030882; c=relaxed/simple;
	bh=Fsj1seXCaJP3QJibKloIszPVOtjnzQS9ds3ZIQylTOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjtuaNDGIY9eSUgfAauK5M8XA+iwnHVEwmwnH45/ggi5S07kTljVCqi2Jv8CQGn0ZrbUCbKVgbpKuHZPIJ0tCSqB5IxiYWp+pz9tKJdJD71QfhfAv6ti4v7EWug3vZ/1fml0NjaTc2iZzs91RIk5aZ62IDb6VD30WwCteGQtD7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBj0xraM; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a49261093cso1074323eaf.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 10:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713030879; x=1713635679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UvUxva6puWWkBcKvrMblK1niUnilpYtFC0S8RUIRK20=;
        b=OBj0xraMrkv87aq3arJmkgKzlefN8VVhGkiEfXz3Hqt5QQ25rOpxAdITzIvx48PVl4
         YB82KZt89EOEf0vKScTevjC62fUvFqBjPkj7ogPnGMZNWKGPnhleneqIf2EiJYeHpvnH
         YdxgZJNgIr6Z3gZ3jWtfKi/xJUEwkYSXk0ItPBVffki+Vz/r+SplU92wOWVVW2z8YJlh
         FG3t2bQjhXjK8jGTcng+iSmMXrmICwmAEWocN22NiChmgauXfz3tpZwG1w4S1gjl0b7b
         1SDkjIk1NzIGLaoDb9wTMblay5SiIYb8gark5uWvqhjHRnZGLgxTjEswKT2ptUDWBsou
         Nl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713030879; x=1713635679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvUxva6puWWkBcKvrMblK1niUnilpYtFC0S8RUIRK20=;
        b=pAWgQQl8z7jjcR7M7lgmn14TI2Ds4bYLj1cfB5lokdHL3lEWI3HADe+ltEYHPOGuRo
         ut88KcdiTL57oR+4NyKEfAB9oOJPRvi0qeS/6nhOFRFFptuIROcDf/RVm8XXWDhm2KF+
         3R2AXHtXVxHqFqpNb0Pt/98gHAo2idtXoz9HeZfl6gqBHkOT8tounVzsb4CWkvwFBb6w
         BkCU5r7BO2OLhcc9g8PeAgEXYmStdXSeEjjQInZSnOuywuEjzMPZi8PAO/53SSXNZb10
         uF45GhN8bUtJI4LxHJ2UHnv9UjSQWSPOlF5wGF3B5/DlQj/LMhSkDK7eTdjLhUo5jc/h
         4vTA==
X-Forwarded-Encrypted: i=1; AJvYcCXvU4o+cPjxwXzkyjSi+jnsYkWEZ+8vP3OSL5KfgqTj78oTRFcyBxMes19B9dJ+aZ3mFhQhl2rgekQD3Wq6KLOVCJscUpF/NxSlN8g/
X-Gm-Message-State: AOJu0YwZYtUnS39sQwbURdzsHy5XFqLcIBYng2WFcbSrRYq9D1xXPw3n
	tXU2jq86YjtyElVr9vP1wwftIi8+sMhFleImKMSaC8ufKZV2yFq6
X-Google-Smtp-Source: AGHT+IH0XucV/2MYIHFbZtM/KomEtorjkc5fs6x4EITdac5R0YnmgFLwihiN0sKhD7zD/85xFN1n1g==
X-Received: by 2002:aca:100f:0:b0:3c5:fc80:56a with SMTP id 15-20020aca100f000000b003c5fc80056amr6842045oiq.32.1713030878668;
        Sat, 13 Apr 2024 10:54:38 -0700 (PDT)
Received: from localhost ([69.73.66.55])
        by smtp.gmail.com with ESMTPSA id e69-20020a25d348000000b00dc73705ec59sm1274226ybf.0.2024.04.13.10.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 10:54:38 -0700 (PDT)
Date: Sat, 13 Apr 2024 10:54:37 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: tglx@linutronix.de, akpm@linux-foundation.org, maz@kernel.org,
	florian.fainelli@broadcom.com, chenhuacai@kernel.org,
	jiaxun.yang@flygoat.com, anup@brainfault.org, palmer@dabbelt.com,
	samuel.holland@sifive.com, linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] irqchip/sifive-plic: Avoid explicit cpumask
 allocation on stack
Message-ID: <ZhrG3RLFVIKmhEbk@yury-ThinkPad>
References: <20240412105839.2896281-1-dawei.li@shingroup.cn>
 <20240412105839.2896281-7-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412105839.2896281-7-dawei.li@shingroup.cn>

On Fri, Apr 12, 2024 at 06:58:39PM +0800, Dawei Li wrote:
> In general it's preferable to avoid placing cpumasks on the stack, as
> for large values of NR_CPUS these can consume significant amounts of
> stack space and make stack overflows more likely.
> 
> Use cpumask_first_and_and() to avoid the need for a temporary cpumask on
> the stack.
> 
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index f3d4cb9e34f7..bf5d2fc6396e 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -164,15 +164,13 @@ static int plic_set_affinity(struct irq_data *d,
>  			     const struct cpumask *mask_val, bool force)
>  {
>  	unsigned int cpu;
> -	struct cpumask amask;
>  	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
>  
> -	cpumask_and(&amask, &priv->lmask, mask_val);
> -
>  	if (force)
> -		cpu = cpumask_first(&amask);
> +		cpu = cpumask_first_and(&priv->lmask, mask_val);
>  	else
> -		cpu = cpumask_any_and(&amask, cpu_online_mask);
> +		cpu = cpumask_first_and_and(&priv->lmask, mask_val,
> +					    cpu_online_mask);

Don't need to split the line here. The new max length is 100 chars,
here's 85 when unsplit, and it hurts readability for nothing.

>  
>  	if (cpu >= nr_cpu_ids)
>  		return -EINVAL;
> -- 
> 2.27.0


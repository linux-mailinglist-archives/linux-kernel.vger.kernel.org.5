Return-Path: <linux-kernel+bounces-147344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DFD8A72C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AAC01C2141A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D43134424;
	Tue, 16 Apr 2024 18:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUbsnRSo"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73F912EBCE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713290511; cv=none; b=hDvpMSYq/dlOOlexQno+00C7VC9KaQeYcxV2fS58F1k7dUnum7g9/QNckU8AtNy4A5FZGIvCYEPbi18eQKfLOfUqxhzW7Zf/K6J/R0SICU6CCrUpameHhkLLSJMtQz325kvp5FS/eCcCZhI68sSkRux4nWWI6BwMw+fqwqx3LtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713290511; c=relaxed/simple;
	bh=znLI4zxgUUfVwkoWj6V0iecQ92LLVJ6EoK5+qpGTLwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQzrRD+7fx8nYRiRqNGMgYTPucu84Jv21D0boA3z3QfHVH1IuPzS9lN6jcA05FEpa/nPou9lxFpWJ8LYMFGxSM7V5L8ZOufTUTAI2Ggd/7MVgPFuNXZUPDF7Sy6GHqP4PkQqKn13IRy3jnKMKYPK9tj3k+llgY8BSpcCsg7Wkzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUbsnRSo; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-61ac183ee82so28617b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713290509; x=1713895309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vUkBLA7UpkIvZvH5R1i37nHgSYLBeEs/jD+f4KMnAhc=;
        b=KUbsnRSouBrIyb/qgoTuevfRRiREhkEAmGyfbYRhXNuvqE+6HPnSycJAnLkSNtc24g
         4LscSJ1GYNi26pMNWeOveI5n4aG9WK5LLsIdzO4d40SNAkI25kNVdkyeAuCRSYbw4sG+
         L3uC/CYEKA591qjbX3GjB62Bb2XjM0J7REI2dfl6XGFoByAINLVN1IG8x9GnA+r9ibuB
         ed1LWXclGnzK0tYyusyeicgW2SiEjNXn85JJbziKYaOj9j8VwndmlUnCNBplAEBl7XS8
         05LDFLXC6rHD/7OYWvh+ty/tyAeRYJDe3YIrlF7WUbFUkFe8D+0wABsho3HI1uP/qycg
         TmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713290509; x=1713895309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUkBLA7UpkIvZvH5R1i37nHgSYLBeEs/jD+f4KMnAhc=;
        b=rxz9con1Vv+z31queHrD47wtFJ79Eb23+a/EmMeUC9dCF1MQdIfg0CRnhXkUi4mxyw
         eJCVmwMx4pOiWN8FlavQ3FYccW3SBoa+Z+OnuLazr5ZgnOvTqjl87IA3vCijNdBS4zf1
         J2TLQ14JmSMSiozEq+72QPqCUXyzUmf9GrkcZq3j2k/5Nhi0K/0d+QRsyetvJJSoeZDK
         URBuWHIvFotdQ6UB21Dn8dnifJxzQ8PLOpPiWZJT8tle2aXTRp+U8ihOzRvy8lZtANGn
         W+mGBINO+qFMfbC+sPAYIk14uWGAF1dleCM53iDSoZqY7wUATScsRqLDXshADv9BL5tL
         QcJw==
X-Forwarded-Encrypted: i=1; AJvYcCUZVjFlKWXEaXnSGUa7YoJ2u5VVblMsE4sLzVDIl9leFqUmH+RIGVyMFsERraMBYOgpJfWHI3R2GeCjZ2rl1ALEr13H0ciOXPAWLrVs
X-Gm-Message-State: AOJu0Yxq7zloUBB6HbqEn7RgFTHgoPRM13Ly2/JjKMeupIdMPfle7LmF
	3fScqBcVUaeDJbDgS0ffG1w2Ckuv5jgNwBY8gbP48L7kW7DY4Ol6
X-Google-Smtp-Source: AGHT+IEXTjg1F7THHEFrWAT56rXYTuwXr2/dkiThVy/LqXzGwzrbeaa6ce/doZWifWma5daBH80UGg==
X-Received: by 2002:a81:a102:0:b0:61a:e4d1:50b3 with SMTP id y2-20020a81a102000000b0061ae4d150b3mr2255358ywg.18.1713290508656;
        Tue, 16 Apr 2024 11:01:48 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:2767:ac3e:3052:cd0])
        by smtp.gmail.com with ESMTPSA id ft11-20020a05690c360b00b0061af7439278sm237788ywb.77.2024.04.16.11.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:01:48 -0700 (PDT)
Date: Tue, 16 Apr 2024 11:01:47 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: tglx@linutronix.de, rafael@kernel.org, akpm@linux-foundation.org,
	maz@kernel.org, florian.fainelli@broadcom.com,
	chenhuacai@kernel.org, jiaxun.yang@flygoat.com, anup@brainfault.org,
	palmer@dabbelt.com, samuel.holland@sifive.com,
	linux@rasmusvillemoes.dk, daniel.lezcano@linaro.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] irqchip/loongson-eiointc: Avoid explicit cpumask
 allocation on stack
Message-ID: <Zh69CzD26Z4hw6R9@yury-ThinkPad>
References: <20240416085454.3547175-1-dawei.li@shingroup.cn>
 <20240416085454.3547175-5-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416085454.3547175-5-dawei.li@shingroup.cn>

On Tue, Apr 16, 2024 at 04:54:51PM +0800, Dawei Li wrote:
> In general it's preferable to avoid placing cpumasks on the stack, as
> for large values of NR_CPUS these can consume significant amounts of
> stack space and make stack overflows more likely.
> 
> Use cpumask_first_and_and() to avoid the need for a temporary cpumask on
> the stack.
> 
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> ---
>  drivers/irqchip/irq-loongson-eiointc.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
> index 4f5e6d21d77d..c7ddebf312ad 100644
> --- a/drivers/irqchip/irq-loongson-eiointc.c
> +++ b/drivers/irqchip/irq-loongson-eiointc.c
> @@ -93,19 +93,15 @@ static int eiointc_set_irq_affinity(struct irq_data *d, const struct cpumask *af
>  	unsigned int cpu;
>  	unsigned long flags;
>  	uint32_t vector, regaddr;
> -	struct cpumask intersect_affinity;
>  	struct eiointc_priv *priv = d->domain->host_data;
>  
>  	raw_spin_lock_irqsave(&affinity_lock, flags);
>  
> -	cpumask_and(&intersect_affinity, affinity, cpu_online_mask);
> -	cpumask_and(&intersect_affinity, &intersect_affinity, &priv->cpuspan_map);
> -
> -	if (cpumask_empty(&intersect_affinity)) {

This was unneeded because cpumask_and() returns true if there are set
bits.

For the series:

Reviewed-by: Yury Norov <yury.norov@gmail.com>

> +	cpu = cpumask_first_and_and(&priv->cpuspan_map, affinity, cpu_online_mask);
> +	if (cpu >= nr_cpu_ids) {
>  		raw_spin_unlock_irqrestore(&affinity_lock, flags);
>  		return -EINVAL;
>  	}
> -	cpu = cpumask_first(&intersect_affinity);
>  
>  	vector = d->hwirq;
>  	regaddr = EIOINTC_REG_ENABLE + ((vector >> 5) << 2);
> -- 
> 2.27.0


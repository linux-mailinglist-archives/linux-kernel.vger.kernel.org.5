Return-Path: <linux-kernel+bounces-131612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAC9898A07
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9811C2A9AC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E7412AAD5;
	Thu,  4 Apr 2024 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OdS0xPAr"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD7B1272B4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240671; cv=none; b=WeJvv4nChcmnKgS1+HgX0kf1ji4QyuU0+ii+3pwiiCorJBS9bMrVkBaAkhJwOy260+WDNYNZfqvCBPC4b2w63uiOxgzj4gPQM40aca45r+N4v79IHMIBqR6Y9N7aAYkGzVU+ddZNwx3IR+bqffyjTw+C5VABjzf9KCkMKY9pnn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240671; c=relaxed/simple;
	bh=Vjs9fiDyEPCiUH5V97YlzYYK9hVDZiame31wpvVYE20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sv6rT5nkAWaqqoWMrsJ2KAg9Pezx1h9ctOgz3mbn8fKQJi+k9dePwzBNLN09gtTHF3VVMS6gg1t2PsGuXdE+A2vC6FlQfnp/G0biqYy1Z0bofrCjbe1SYUJ/oPeyvc9zNlsTjNQK6XlAQ/Tq+wOt4YPsLtUuwNvpBHEqBc4f79o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OdS0xPAr; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4e5ee91879so145749266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 07:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712240668; x=1712845468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=73VFeujZ5zRSnfDeve047kxeX/QzAwRRioVRteiOY0c=;
        b=OdS0xPAr3SPdUwnKKcNya6NXo3tYIx31vHdM4Wp+gKzcowRsPRO1pC6AXGMsho9lMd
         7fpiRYOfp/Rs5RwGzePNVIpJvjm7tC+Y3UuuwEsCRAnu5s0kqLYWMxKyOceUTzv1LPbp
         z3ZtGwHAXYIUqcCJMLxx94Q8k0MNmafxjLAAu2CjUxZxnswImWioca2803X9AgsdGo35
         PpISXs4OLFBmnh11BBdlJ+KzpWN4Zbx6xXzR4ZgrSaBtqbu5gAsmIoyy5XLHrjVGALoF
         6m5O6OI43uT40JfypoPi/X8ctrlHDIFoZwEm/hkFdy0FrNc+kXUbZ0xqLHvM2Nhuqhuj
         OEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712240668; x=1712845468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73VFeujZ5zRSnfDeve047kxeX/QzAwRRioVRteiOY0c=;
        b=Cg5WcxhpT2s0KejtE/sWANvo0DjD9XR8XwfQNCJ+SSkYPRq83XFFnjEPR1isNTPgI5
         LFBaNymbJSH3AZVju979La++yRArwcZ6pG6QwP4MCHDwFo8eRuI3KtWwf+pcS4hNyfj0
         SUdTfcYiRmugXPknQTgn++trxsUHdITmuUoxHVpW5uxUIrAvY7CJj68wXORiEyUvg8f8
         gKEpeR1XC0hpiaKTuAZdNeVOG0kwQMke+s6Pf+njPQ+HjD0nQFGwCB8nqbkmh8U30Hsn
         /2Ik+KmoPLd0HCZqyze6uA1tHO/IrqXOY1z/1ZpuZ6NW3WpQNF5u6hpC6QmScM8MKlRw
         YylA==
X-Forwarded-Encrypted: i=1; AJvYcCXfAAGpZ3yiGlfBoOGyCfy6wILUWDqqv+s0qo56szaqftvVFYo0n0H6V8I2/kfGDf9MtzCnjXdC85rY1mzk36EJQ5vM/SF2b75uVRfJ
X-Gm-Message-State: AOJu0Yy9xW202Rv1U0fwwqjveFYzWz6wwyYRP8saL7YekIpW3A6NyTI2
	lFewLLAs38nr+cXz1CB9lbHN7D4hjNgaCJyeDOM+zxhlbiT6P225w9ppM0luyZ0=
X-Google-Smtp-Source: AGHT+IE95d2GyKE88haqUxd82qWyW9YDQkqTlbBv2liHK6vJPSxaCXRx7+j2iffF7lQ5Hkbtdl0/2Q==
X-Received: by 2002:a17:906:dfe3:b0:a51:982e:b3f7 with SMTP id lc3-20020a170906dfe300b00a51982eb3f7mr348369ejc.37.1712240668315;
        Thu, 04 Apr 2024 07:24:28 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id pw14-20020a17090720ae00b00a4e35cc42c7sm7998858ejb.170.2024.04.04.07.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 07:24:27 -0700 (PDT)
Date: Thu, 4 Apr 2024 17:24:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v6 15/21] ip_tunnel: use a separate struct to
 store tunnel params in the kernel
Message-ID: <5f63dd25-de94-4ca3-84e6-14095953db13@moroto.mountain>
References: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
 <20240327152358.2368467-16-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327152358.2368467-16-aleksander.lobakin@intel.com>

On Wed, Mar 27, 2024 at 04:23:52PM +0100, Alexander Lobakin wrote:
> +bool ip_tunnel_parm_to_user(void __user *data, struct ip_tunnel_parm_kern *kp)
> +{
> +	struct ip_tunnel_parm p;
> +
> +	strscpy(p.name, kp->name);

We need to clear out p before copying to user space to avoid an
information leak.  So this strscpy() needs to be strcpy_pad()

> +	p.link = kp->link;
> +	p.i_flags = kp->i_flags;
> +	p.o_flags = kp->o_flags;
> +	p.i_key = kp->i_key;
> +	p.o_key = kp->o_key;
> +	memcpy(&p.iph, &kp->iph, min(sizeof(p.iph), sizeof(kp->iph)));

And this memcpy() doesn't necessarily clear the whole of p.iph.

> +
> +	return !copy_to_user(data, &p, sizeof(p));
> +}

regards,
dan carpenter



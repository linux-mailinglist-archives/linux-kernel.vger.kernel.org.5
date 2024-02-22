Return-Path: <linux-kernel+bounces-75966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ABA85F13D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04CB1F22ABB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D55154B1;
	Thu, 22 Feb 2024 06:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fefqBz7B"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA10212E40
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 06:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708581631; cv=none; b=DUWWrLLBfBBmqAW6Z4OzsOsV1gxvzofhm8jgyuTIJugzQtg+Z5MOeEPd84b3RfR8lNoDePTBrEpfdayrITUuOUl0roH7R7cQKS8Wcgt/ts/7I2PQ2lsxLnc5IhwmkyWjdcJ6iR1Fn6e0I3AQTmXUo5s61oclYDL+guddovotTBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708581631; c=relaxed/simple;
	bh=Z6JWzmSCwaZHB5bsIRXZgQfwSxV1nVZgUwh6w3gH1tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEoeftulY6WBvQi/sfCBzc1F+Hz9PNm8MW2rXr7R37nlWl/qoqjjjpMzbwSrnlYcbs5kS5BO4FH22S+GWaG47TzJHQ5qXkammYWiBE5ZiZYuopmP2dVMD0O6E0mTc72XHlwOEjdIY4juuVq3QMiNGWT4TcFYKd82mNnMmd1d/tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fefqBz7B; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a020f5a4c5so369409eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708581629; x=1709186429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eQGciLXDluTPnn2IY30P6HSoPGBON7YrfV7nbQOPdy4=;
        b=fefqBz7B0IodNjOicbgr0rM0sLKrW2iNbBsUN3h2gMhAzRie982hlBVvZ1wOxhrkPF
         vO6FXcBKUGeReSx7NebNOl0aYHsw/7OajyxhaSO73iGaydH0Q3Z/u+UCc6TRiEh0pGvq
         7I70QtEBlMCChQXjTQG6TfmLWoagWtRI3jDkaLTyuTukL2TNcmxtCjY06d6zDOtYK6b9
         eQidjCxfIF//beo4wcw5jRcx59A8GQCbFhdLyK988+gBnjZHEH/TYdaIKcEpMM0NVG2p
         unQ96y5kmKMqsxHJVCzvJT04PYPlbuhUGNtEIVpMZXDF+gGS0VXb7rg/7wokLEv4JgoV
         BNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708581629; x=1709186429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQGciLXDluTPnn2IY30P6HSoPGBON7YrfV7nbQOPdy4=;
        b=VJPsWXkr65KKSCf10qU8hg7DWDlz9s0FoGTF+nFwA+uryvVNAN6BQ2IzC7yXIH74+1
         b2rDddNsfDDf+YM9dTZfDE6vXs7NAb8FFlDTL6i+5A/4XUKb9qca8Vq9uMUvb6azM0P4
         kfnZsoL+Suy8o+fwU2gDsWhI2+d/PANDY6VtLyg1gB4qFbXd+byOaPsQUuEdFdJcoPco
         aI3tA1sJX3xORSiU7cm6LDJKW8rk2KqjJZ73xlOA+rJwzD4fwRZyBBPg014f2/cVWHgH
         j9mGQQS7XB6dAF8iYGluXnJxtRbHCfySXqbeGy9c2FrOJNdI1obLBrO6rS5ai1QPh8HT
         pLaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnVpU5jTI0desu62pW+EtQTFrgAvI5Q/83UCXYSx4/opc64eZkdwqQ4kQNSMHwa8uIux0LM6Azotk2S+fKddJDxJi7rz4fh/k8qMbT
X-Gm-Message-State: AOJu0YwVFt0sK3dWmaCZh2mrQF3/cjGHPU1N5XcRK60h5SzduNYSML2G
	PwzVUm/kIeMGHWnbomD1bI4jFu3lFL2sOgCn39ZbS1kWpBsyYi7a
X-Google-Smtp-Source: AGHT+IHY9AhAeH1xjk0qipC9ROn3oMDVZWqWtwxgiYhtBRFzqv5aLia2626AZ9H4t9S8YK+RDEv+QA==
X-Received: by 2002:a05:6358:710:b0:17b:5dd1:a38d with SMTP id e16-20020a056358071000b0017b5dd1a38dmr3400924rwj.1.1708581628629;
        Wed, 21 Feb 2024 22:00:28 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fa3-20020a056a002d0300b006e4c0ce85b2sm1486748pfb.181.2024.02.21.22.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 22:00:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 21 Feb 2024 22:00:26 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu: mark cpu_possible_mask as __ro_after_init
Message-ID: <a1fafb71-cbd9-4d0b-8c3c-2b69be97db3e@roeck-us.net>
References: <41cd78af-92a3-4f23-8c7a-4316a04a66d8@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41cd78af-92a3-4f23-8c7a-4316a04a66d8@p183>

On Mon, Feb 05, 2024 at 01:01:19PM +0300, Alexey Dobriyan wrote:
> cpu_possible_mask is by definition "cpus which could be hotplugged
> without reboot" -- property which is fixed after kernel enumerates
> motheboard capabilities and hardware configuration.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  kernel/cpu.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -3107,10 +3107,10 @@ const DECLARE_BITMAP(cpu_all_bits, NR_CPUS) = CPU_BITS_ALL;
>  EXPORT_SYMBOL(cpu_all_bits);
>  
>  #ifdef CONFIG_INIT_ALL_POSSIBLE
> -struct cpumask __cpu_possible_mask __read_mostly
> +struct cpumask __cpu_possible_mask __ro_after_init;
>  	= {CPU_BITS_ALL};

I guess you didn't compile test this code.

Guenter

>  #else
> -struct cpumask __cpu_possible_mask __read_mostly;
> +struct cpumask __cpu_possible_mask __ro_after_init;
>  #endif
>  EXPORT_SYMBOL(__cpu_possible_mask);
>  


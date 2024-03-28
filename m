Return-Path: <linux-kernel+bounces-123098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42880890224
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6B23B21CB5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CBC12E1E3;
	Thu, 28 Mar 2024 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DZf5k/zb"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE11D12DD92
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636953; cv=none; b=fbWEzkjJRXIU9eBwEqgOzdX1psqnOexfCJaf2qs1OjGwv4sxR0S42onkkJWTh3k5jfhrD+dMgNpDQfdTXZl7AHhs+ICHihECtiPdJuME6McXeQlP42I7l3gbB6h1TyUCPn4i4aLa6r9Z+5fRu5RBndbCMHen9sy4jr1XQFl38m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636953; c=relaxed/simple;
	bh=72e/QGdwx4cgM0WviYJewSYfxMsyz56u03JStMH/pMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGUg7wn5oLo51/NoU4GxODZbdFzib46OETP5401nXLH0Z2MQNCPN41rVQwZ25+BMnu/pJbw4I6Iedm7UNWKjUztz425p7B9yQASJCzkZubTwrkHry55aj9KUdHO0Rf1G+yeDbpe24PWpCC5wJtZgXQ0w1hpyMDJzWEKIHskzTZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DZf5k/zb; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d485886545so16276521fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711636950; x=1712241750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G9hLepNJpbi3DWHCAppFTBwjpcQkCnm+v+TpTm9Peb8=;
        b=DZf5k/zbtiMk1MWgldkra5zu/RGfSAyM7JdL/gGShVAAv5fB++l3wylFGLei9J2sAx
         unDUe1jy3B7gDgYLJ+2hJwKdzEavFFKerSKR6v2ShXx2QT53VYf3ERIWJeWhjBhR2vGS
         Gc3zqWrrorGmvD03lmALMg9FBbI7PbWRNDJBqaFoLG26fr+n+CE2qyLfnXGXurPIFfCk
         GKFylqJQpWdjEoT63Mgf0n0Vf+0cxqbBeK6+I1CyDLlcZY7JcFv1cx9GJesXOaNyPdHt
         RbJF8e94OqEagA1vR0lF8F0l768tlZeldvXi04gEHuylxckC4DDOp5eoengWa1SOQnui
         Hvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711636950; x=1712241750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9hLepNJpbi3DWHCAppFTBwjpcQkCnm+v+TpTm9Peb8=;
        b=k/FJ/DMxF10erDg83fd4I+40KqT1eP2rX9lZ3nblPoh4hsCawp+ZlllUhUjw9dBfUa
         P3+/4kvBats85JiAPWI6HpAE7S6tndJhHkHZMQhnMnt5kmuVgyxUWIORitH7LgX/UwI/
         U3tZ+do2M6WW490R3cJGtljVRmo1Ir3FX5HU13Z99YWIYcwj6vjSebMisVS9XgmxRr4a
         5GbwGb7HjDfqC3B8/wOlFQtoSNzeJVmnAm4Oig9Taw9UrjuP3TW3j+ozJeLjsY6zpHmn
         XUUsNrJnwFuJvIT3nrrf5pDNbCrhdf41WufB0fYyi9JCJs8pg9Fwl9G7kxY4iSgG+TCo
         ksNw==
X-Gm-Message-State: AOJu0YxiigrLKEML0RzABeNIzf88axEqHG2egzoqLD9yW0Tq1P8ZQEa0
	DzsBoQbARS+7ir9yMobt0OT3WAXno4nPuz78+TwmeBiAPZxXuJgE4+8TcFzIF8I=
X-Google-Smtp-Source: AGHT+IEH5jD7Cj+NefM1s0YB32bnuPPntJtJeXj9KzXVwKXJ/p0MTHcCp31F39MAt8QJruB1HUs1Lw==
X-Received: by 2002:a2e:7203:0:b0:2d4:676b:f591 with SMTP id n3-20020a2e7203000000b002d4676bf591mr3208568ljc.45.1711636949583;
        Thu, 28 Mar 2024 07:42:29 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id my15-20020a1709065a4f00b00a46b99a4273sm819990ejc.216.2024.03.28.07.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 07:42:29 -0700 (PDT)
Date: Thu, 28 Mar 2024 17:42:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 01/11] staging: vc04_services: changen strncpy() to
 strscpy_pad()
Message-ID: <508e4ede-ab78-418d-9aef-f657827b6dd1@moroto.mountain>
References: <20240328140512.4148825-1-arnd@kernel.org>
 <20240328140512.4148825-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328140512.4148825-2-arnd@kernel.org>

On Thu, Mar 28, 2024 at 03:04:45PM +0100, Arnd Bergmann wrote:
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> index 258aa0e37f55..6ca5797aeae5 100644
> --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> @@ -937,8 +937,8 @@ static int create_component(struct vchiq_mmal_instance *instance,
>  	/* build component create message */
>  	m.h.type = MMAL_MSG_TYPE_COMPONENT_CREATE;
>  	m.u.component_create.client_component = component->client_component;
> -	strncpy(m.u.component_create.name, name,
> -		sizeof(m.u.component_create.name));
> +	strscpy_pad(m.u.component_create.name, name,
> +		    sizeof(m.u.component_create.name));

You sent this earlier and we already applied it.

Btw, I just learned there is a new trick to write this when it's just
sizeof(dest).

	strscpy_pad(m.u.component_create.name, name);

regards,
dan carpenter



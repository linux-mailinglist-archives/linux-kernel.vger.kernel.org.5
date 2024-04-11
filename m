Return-Path: <linux-kernel+bounces-141564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238DE8A2006
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81B26B25FA5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D6D1805A;
	Thu, 11 Apr 2024 20:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Knz3FE+h"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5447117BCF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 20:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712866660; cv=none; b=skfNkH9rE3UBsmPA1qe+EiL385zi2DOd5vj6xSx4stYyGdhy82s7xwZRvA5SLNAXMtx7NUWsW/yU79ZVU0pHoobbh4ggbRPTSv0iyM2eabVcCYHSJxd1s/uNGKQn4Lt4dYSt86sz16mo3xG5bGKk5eaomVLFeLOdRxTLptsWbxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712866660; c=relaxed/simple;
	bh=CCSNMZUxTrpa3dpyGwuD+xpGXVDYKUY8cALIjx+vkrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4UQ7ktJmsf2900Up78WzDpg0nJVyWcFsTmTmqfOkDW3F+s7GZw8CmDtXzexoObbHQ1Xo4AXbtJBT3NZJRSs5gH3h8XSP7pMQWK05acr93+5X1x1FRisoFlaCGvQ4T0SnX3HXthFQrQh/QrW+crv9DhWDOsaVXFqYfOUorulT0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Knz3FE+h; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-516b6e75dc3so277532e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712866656; x=1713471456; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jnVkVi9PCVLQ2a4WdlMXHYl3KUjY5EPaBz9jWbvlviA=;
        b=Knz3FE+h116Jw56r8DRB5MhfbTQPpKuJ3aOu/rh9BozCqCRQbUtZhiG0aJvWulQNYI
         tDL1PrY0SS9nWsENFLzkiEIlIxEEA80z8l/MP/SJVGmPpokKywCpyEbikGjPo/DBTHxl
         UsG0yIF+0YDRdrjA9/P1zMEElLADiOX3WerCML/Cyf5XUsV4hY9NSS4jAB/lMItID6+j
         8cAMzSbJrQBGWZkATr//ZvJZiN3FbDkR9gK15Sqq+sSk0Dyy4MfJUQOnurLq68bf+tdY
         jRt3fL71IhTf+h8YRn2/kBNYRwfAXYzyek6A8XzVDEDsAkK/joo5oYx00Ze+qNgd2y+n
         D7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712866656; x=1713471456;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jnVkVi9PCVLQ2a4WdlMXHYl3KUjY5EPaBz9jWbvlviA=;
        b=Gc8IOMe7lswbE2FkQZd5OPx8eFHwuljwTBr0VxX6lZ8VsAewlPZ7WGvt0HvybMnj5I
         an7qS2FvBOIUnDurOwgoOoCFFY8JwMy55Q7kPDSSsJIRSHnHI0j5067+AwVMVFnWjT3W
         3wOpS/jMo14SC2izdinag9chQRblKGiaZiMeLYXDKWypayQNTFnkHJQoycXb3pYTKKkE
         8hkrHZ3Es/Wh6I43vtdy1PdPLMfP4o1GCvTyUd+nC9q0c7wYHOWigvAtg5hDmqUe+WN8
         wwuwn/4XPXqYkZgGo37oBIc9pIZwv+SvumahOhSAGE7u4pz3/24Yu0FuST1fjFieiff8
         DMTA==
X-Forwarded-Encrypted: i=1; AJvYcCViynS578s7zpuh5e1QmlTuagcbf18l/fA2mnk8+8bhqPY2LpnAbGXNLlJ0pJL195ScmR2/b+PNGvk6N4hpFMpI/+0dk716NcX2H+wB
X-Gm-Message-State: AOJu0YwGtJ/vHaxrtfL/u+g92Y6JYXVp2jr/jyXD8QjOe1y7CRojEuKd
	8sHqLIhdWxVGhp05b9fCHnpUJ9Hy6oBUUX23R8OsW7IWwZxGa/6GdNsGCzlthDour55UdUuqRI0
	K
X-Google-Smtp-Source: AGHT+IHA4u0Jp+6NhFXOfmsl2KdwlH94xIcKS3tE0NrfLh8isx/EqVT2vR5geDzP5kQ0Wsmf9+Nzzg==
X-Received: by 2002:ac2:5982:0:b0:516:d692:5e0b with SMTP id w2-20020ac25982000000b00516d6925e0bmr374592lfn.54.1712866656444;
        Thu, 11 Apr 2024 13:17:36 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id u23-20020a196a17000000b00515a52e362fsm293917lfu.189.2024.04.11.13.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 13:17:36 -0700 (PDT)
Date: Thu, 11 Apr 2024 23:17:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Pavel Machek <pavel@ucw.cz>, phone-devel@vger.kernel.org, 
	kernel list <linux-kernel@vger.kernel.org>, fiona.klute@gmx.de, martijn@brixit.nl, samuel@sholland.org, 
	heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
Subject: Re: [PATCHv3 1/2] dt-bindings: usb: typec: anx7688: start a binding
 document
Message-ID: <cogegnmniilyhjfvptdws4sybmoyuovo6p37tofdinxxbml4ua@hq43tv4dzr7e>
References: <ZhPTTxI4oTF3pgrk@duo.ucw.cz>
 <e7841ad2-fa3d-442d-804d-51f12e05c234@linaro.org>
 <e6vvuttix5k5fioy7q44ick5wj6u5gleh7mht36s4zjjcym7vy@bziejyohtc4b>
 <7976e254-ed1e-406d-870b-1ecdc4b1e23c@linaro.org>
 <uoo7xltbfx7u6iai7urj3wez7cwotokxt6lwjhff57xbljusqn@fr2xejnrlak7>
 <1502383c-9caf-4362-8bd6-ed719a304f08@linaro.org>
 <vbo7bacecuagu4qzrr6tsdh4qlejrv7ia67yylf6ay4u7qnwge@kqj27bun2m7d>
 <97f2d38d-c863-4c76-91f1-52cd250759d7@linaro.org>
 <ounfv3vgg2esvxk2cxckeqyy52mghiyps2rszh7sf5poryyjzs@ftumsalmthza>
 <025d268f-96d0-49fa-9a67-f80ab81ed102@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <025d268f-96d0-49fa-9a67-f80ab81ed102@linaro.org>

On Thu, Apr 11, 2024 at 09:59:35PM +0200, Krzysztof Kozlowski wrote:
> On 10/04/2024 04:20, Ondřej Jirman wrote:
> > On Mon, Apr 08, 2024 at 10:12:30PM GMT, Krzysztof Kozlowski wrote:
> >> On 08/04/2024 17:17, Ondřej Jirman wrote:
> >>>
> >>> Now for things to not fail during suspend/resume based on PM callbacks
> >>> invocation order, anx7688 driver needs to enable this regulator too, as long
> >>> as it needs it.
> >>
> >> No, the I2C bus driver needs to manage it. Not one individual I2C
> >> device. Again, why anx7688 is specific? If you next phone has anx8867,
> >> using different driver, you also add there i2c-supply? And if it is
> >> nxp,ptn5100 as well?
> > 
> > Yes, that could work, if I2C core would manage this.
> 
> Either I don't understand about which I2C regulator you speak or this is
> not I2C core regulator. This is a regulator to be managed by the I2C
> controller, not by I2C core.

If it is a supply that pulls up the SDA/SCL lines, then it is generic
enough to be handled by the core. For example, on Qualcomm platforms CCI
lines also usually have external supply as a pull-up.


-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-48958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A798463C7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6436028EBD9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907D445016;
	Thu,  1 Feb 2024 22:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaqcIwJI"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A60A3F9C6;
	Thu,  1 Feb 2024 22:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706827718; cv=none; b=ZFbyzjiX6p+475MVNFf0KqV5dOHaekb/bpUCd218QOmJ1Bmz2zZ6nDO0y1tWzS/gU5Kkp1xY+RJUk9Oa0snJ1PN5ZSZsjX+mJh9GpnacJGJOYc0YvVMFYY5qNOoi3MQcqHVxhsh90ubSdfvadaY+rBpOJ2C9tiDAyzimn+ck7NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706827718; c=relaxed/simple;
	bh=qTGnHB0DhHdP+Fu6JUh7KJI1E4IexDxNou/9SW9fmzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGu72JlcfutoeQwUJkZ9+ZUM2axqPaLUBENbJn4ptdIvaYxf51E/2O7VgY14JZKjDCY/FUQPyYhMUYit5LB8+JpGPETDpdTEP+FowB+T5exAitKVOHY9cQclq7EAKXdKPga9C7kOv0iK8WTshUvoiAlVou55VJXPlaXNi8FJnoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZaqcIwJI; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51032e62171so2011705e87.3;
        Thu, 01 Feb 2024 14:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706827715; x=1707432515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sxYrwtr/Z6VwsxCyi+RbcGQ468EzuStvTx+1ulE3Fa0=;
        b=ZaqcIwJIkR/13n2/F2i2xiQJaQ7I9TJ3FD5UZh9RbBnQClJ02+4wgtvag0LUD/RVkd
         jYT90Dc9JsT/F5Xuj3OGE3vka+8nVttCeQphLCllaZAw8VzUPiNXqRCB4F1IsIcpitKH
         ia+sPWXlNkYAWPCsYX0zX/+EGHx5MCqPadX4HIKSgK840ZepzW6S0UkZRzMCpRzLq6et
         nobHyvnpIGPOB8dQ/rnIc0ifPFjyuqyT+Ime7eMxJt1K0tE12Gn6GuTLtie+4Wc7wb84
         IkvKJqOiNfyFHcb40Q0iWLfBhzh93f79vUKhRbGSGcqrLbja3eA+PofQP9R3FWGEv3Ce
         hkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706827715; x=1707432515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxYrwtr/Z6VwsxCyi+RbcGQ468EzuStvTx+1ulE3Fa0=;
        b=FBECb5IGTn/nvb1w14fZQ0nBn8tmso1gPrOP9MC/O8yGekRsmP/etEaJPPaOiwtiQi
         mOGQOB4syvJ8a/cwjiuFBZD3/jDTXg1B2WkGDWSUI26qQAG4/TmMGdquP4KJewjwD0bX
         PcyHopQitKH489Uq3qfBRLPWaZU60z9sWAWcaFtLo35RGEGQRAumuC5uY9vKh0nZTpJo
         RksCrk1sBJT7Hxj8tuVFlPoiu+aeJ7CsYaJtbq2d8pxKHOYCseafGTtqWOwWTvVCMLqJ
         4IjJKbXmf/KhI+fhEZV6yYE0os1tbHvCRE7Nph4GmAHNTP75u76drJPkdlDQm/xu0GPS
         HUmg==
X-Gm-Message-State: AOJu0YyfN3h3Xi9eN2mi/fhvV/h6ltF8FcZu1qYKC3BOstERkgIXBtQx
	zDAEZfeuiWE0ne437wr3nCwAo/639xZ6E1IOAa7JupJrphgfZN5C
X-Google-Smtp-Source: AGHT+IEE4Ce1/WxQ5k63wwHgKBAIR4jpl+gidSzyN0phD4SbsMdkxHrOq8NbJ3sIlCvw6gXM/sljyg==
X-Received: by 2002:a19:4f4f:0:b0:50e:7a04:2229 with SMTP id a15-20020a194f4f000000b0050e7a042229mr177995lfk.25.1706827714998;
        Thu, 01 Feb 2024 14:48:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWgtBvcXo+Vfq8WJCO2coH+abhtj2BfZgjearznhqrmldNjxnHwK4ejVJghdpLPlmYR2igDwoAj0XtbFODJDzeFqAU6djFqM9HDdYcuxqvHWMifiahvlPHaFb3CtdMqMoxyuORS9APmOdk6LAQMgQRzsbRvIYMN7hk5l5z1B/gs6tonu5N9PqFvf1/G0u51nuTx1LFS47CO/LB6gv+utu2Hluz8LP6SVRjp/KKm8rOPm8IFM06zpg/la0QQReI1LVfqtXBSSiWcCBnvegpisVqIHtKuxiR0kVRy+B1EvUOwGsWd79QEutbzIc8UhfXSIadtZpC3WhZncnWgwB8LZ+Li4fUorGs=
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id vi2-20020a170907d40200b00a37024b48d1sm35614ejc.189.2024.02.01.14.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 14:48:34 -0800 (PST)
Date: Fri, 2 Feb 2024 00:48:32 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 10/11] net: dsa: realtek: use the same mii
 bus driver for both interfaces
Message-ID: <20240201224832.w6562z462pntove5@skbuf>
References: <20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com>
 <20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com>
 <20240130-realtek_reverse-v5-10-ecafd9283a07@gmail.com>
 <20240130-realtek_reverse-v5-10-ecafd9283a07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130-realtek_reverse-v5-10-ecafd9283a07@gmail.com>
 <20240130-realtek_reverse-v5-10-ecafd9283a07@gmail.com>

On Tue, Jan 30, 2024 at 08:13:29PM -0300, Luiz Angelo Daros de Luca wrote:
> The realtek-mdio will now use this driver instead of the generic DSA
> driver ("dsa user smi"), which should not be used with OF[1].
> 
> With a single ds_ops for both interfaces, the ds_ops in realtek_priv is
> no longer necessary. Now, the realtek_variant.ds_ops can be used
> directly.
> 
> The realtek_priv.setup_interface() has been removed as we can directly
> call the new common function.
> 
> [1] https://lkml.kernel.org/netdev/20220630200423.tieprdu5fpabflj7@bang-olufsen.dk/T/
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>


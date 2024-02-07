Return-Path: <linux-kernel+bounces-56406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1C984C9C8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ABB32898F8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E240925577;
	Wed,  7 Feb 2024 11:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pUU2CyAa"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7030020337
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306097; cv=none; b=a0jwl9VFKnBoQQmauZeF94Mu6J9H3E/zxiyhBJayMniMj1PnI/s5nUwuaH2HtzGAMEtR6uLySFrsGwWK62XToPgx2UdOhGUhcOijzALYQUjMlWwXab8jiA3NkzjSEtPK6Zjn9jUktl6t6pjrdRylEYF1UlT1qLTZBA6R/qQ5L30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306097; c=relaxed/simple;
	bh=DSEGhs8t89Wdn2lcJ90v4XZSTRSPwqMTcFcLFnVX0eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMIWToXeUSCNYOT0HuXaE66EkSP4v8UE96zrJQCgGMRhkNpBUKXXGzDNjB/n1+By+W5PDKSzyg6XxKWIF1GXnpS7epXC4O6lrMbNpE/eiNamT2aRj/GsBKnPH2+lGiztvfUfziNA9fu+VQFnYmjH8aN126scR4WEOu/vokBYORQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pUU2CyAa; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a38392b9917so71239766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 03:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707306094; x=1707910894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FL3Nd1dBR3qVr0CHzLN14MZA1GoEXteTVfY++m2CnRQ=;
        b=pUU2CyAawOWu5SOU6FqC+q2cP9hFYYwFXOl85B/2Ymo1N6UjJoK5uBD54mXr1L6za5
         pAje+BSDH11MBLgiokdpy5Tn1bxzEvUW4vWdoFe8kzkSyManRzexXlYM+IJgZN4r7V/H
         s59vujz+Ifezfu0cMCJ9xisO8e5+m7yUk0Wz8aGoANIqSCGqYqhloua07fA/QubKqbdA
         HY3JDfS0K3qeIMDr2hNSQwRY488WnvCJTo8SZvRaNMA2cUX46iJFSotXwqMh2Zbf8NoW
         /YmH86TGLrU3IDxd9Cak5TF1oJZSTpysLsQRJKH0G42wIYvzwn98XV+qd0G01ChBWc9Z
         9nVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707306094; x=1707910894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FL3Nd1dBR3qVr0CHzLN14MZA1GoEXteTVfY++m2CnRQ=;
        b=W2ZV+/CKnNbnvpkAw7FMJ7WbQN3ICFkP/8LbCJP6s89UKEjn8FKq516Oegkv5khMjg
         qcJJ/SXzeyQ1QkwqC1WLOUqaKkSJokh4U9nc229STSxe0cUt9/bR5cWcPI2k+OQlCaFq
         braf6v0aur3t9gnoGFoW3ovtRkuMQO4a4kcdImU/SFkAC/88cG+0qfHZRCrv8NOu/MQ/
         5XGoRhV22jewDI7qSDrUJvc3+n9t1HUBUhP1z4yafk8Q4ET6v0i9rcPaJWlXBuWoMJE1
         3AkKQjxQXHjTxhTXmFCb67gvsX2ntAPVQQFW4bjZbCozuMaiVASZtxuJIxN1BXhfGSl1
         Ng1g==
X-Gm-Message-State: AOJu0YxxFwmuEHhFJGnEDmT9XJPkq6fL6ZPNF4MQLQXyVEdt8pKgIzJx
	YIo7XwtnvYXAhOdKwq/XHRS6WcOymrRfrX4FsZjFBQUf42RHr5APTNATjAtKPrQ=
X-Google-Smtp-Source: AGHT+IFNWaPuRkjzOYD4a/taM4lEjaWAuh/+EnUb1hQh75fo50QW325Fjq/rKO3VEl0kkL6PzrQBwg==
X-Received: by 2002:a17:906:81a:b0:a36:8711:f7b6 with SMTP id e26-20020a170906081a00b00a368711f7b6mr4240520ejd.34.1707306093690;
        Wed, 07 Feb 2024 03:41:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWWGh1g4tYG8YziMu+0MDmUirKCnk8R0cuPEipPxa2rQp7fWSiuyuuRRa6ZzjzjiHoBdFDroaFOuzFRbvs4BB+l2pRmYydz7gJyyO9GZ7A9IxetoexL70Fqm8/6HgnPPh5UTONOkihXP+9xszWjM76im7beCX/mGolvJoBM/qPTFYReXZRm
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id y22-20020a17090668d600b00a38291a7f01sm668319ejr.170.2024.02.07.03.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 03:41:33 -0800 (PST)
Date: Wed, 7 Feb 2024 14:41:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ahmet Sezgin Duran <sezgin.duran@linux.org.tr>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: remove redundant braces from single
 line if-else blocks
Message-ID: <c682509c-40d3-4db2-b9e4-c563e6239f21@moroto.mountain>
References: <b97e1f8927d81b9b72cdea7a30f300b35854c38d.camel@linux.org.tr>
 <2024020757-desktop-atlantic-749e@gregkh>
 <54d63b6edc5421a5be2e552b03592eca5cf85b2e.camel@linux.org.tr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54d63b6edc5421a5be2e552b03592eca5cf85b2e.camel@linux.org.tr>

On Wed, Feb 07, 2024 at 02:13:14PM +0300, Ahmet Sezgin Duran wrote:
> > Why is all of this here in the changelog body?
> > 
> > Please fix up and send a v2.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Sorry, I forgot to remove those before sending.
> 
> Should I send a v2, even though Michael Straube has already sent a patch?
> (didn't know)

No, don't bother.  Patches are merged first come first serve.  Michael's
patch will get merged first.

regards,
dan carpenter



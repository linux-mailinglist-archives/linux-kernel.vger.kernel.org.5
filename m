Return-Path: <linux-kernel+bounces-52066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D798493AE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765631F226CC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAF9BE6F;
	Mon,  5 Feb 2024 06:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bXZ+3Mkl"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECAFBE48
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 06:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707113335; cv=none; b=EBUeKPTYBM/KHcBZB7zgdYHNfGahb4pP5iclBTywgjRUDA2IZXT45DDaJFY1IkGmX4foPjH3jaq0scIk/V6UlZjK8SjGg59Thci+PzAMWYN/EdRfFxjHfDQiuX2KbCN3Dp5b3PAtBh9FLsupnhtnBrQvJz+5s9eUUf+EFkPi9ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707113335; c=relaxed/simple;
	bh=euGWotuVuS8Wlf46tGlUby7+LmXb1x7ChtYBqcMvf4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0Xrlpo2G8B0b/Up4X56mOSpG8hhD2swx1bSZKGmV+LUt+x6Ou8pA+bZEj8Suomm6WY5ZmJEuY8Yar/f6uznFDlybguw+yElN1Rw8SSTgz0T/q5FNl/MExZspWVzrBlRPWaNfoAjcOrni5wwWm+vbFwZ39G7uO4sHqStnH/Qr+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bXZ+3Mkl; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so474316766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 22:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707113332; x=1707718132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T1K2hhd5XKdxqTr1V8OgArx6oGJVUK1IYtbVBeZd92o=;
        b=bXZ+3MklIBZ03BdnIfkJD/FRgn8cvICRf3cj0xx0/qH6clBP92r66ORbRG0PZ6nSBb
         4HOtX840DVR9b+XQLpTSTvb1rQC2AJVroWZ5emkogM73z3dtShsyF+ymXba2I48ZutgD
         +zP2YeZOTAp4LFZfTfCqd7s7rzzxATwT56HDB1Uy1ca6etbGSdA4egpTiXahCWxaqNu8
         pbEmCSVbaA52m7IKkJZgtXn029E0abc0Tlt2rrP00xQsYQE3/I3EebSx/XnROo9fxD9V
         AtnkyKjuaH5dP0Mh4/Ni1l6uj+CW+dxLJfjJvM+nl09dEApmTyFxMyen9YD5H06uaAOR
         DSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707113332; x=1707718132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1K2hhd5XKdxqTr1V8OgArx6oGJVUK1IYtbVBeZd92o=;
        b=smnYj1Ip6zl2cZW65SFoXgeJWdmN3qZSfz9qd5a6ZUJ6rRQvQTWFD2ES4KpwswuxtX
         mP5ac9BFL771C3ONqZpXQnZVLlQEfaYlfRm/lg9yJSR2Jt5zmuG41t8ejy5Fb1xfURBh
         ItNQahF4gKKZoF+O1cKOAOgoJwH+CtkO4Eix57cScWusr40TyAygYUkN8aniJZKTuQwq
         zFhXRpuPzIviQv3lPuy7vVvBTCM7/hWUcSaOG+Bjcma60E2hbCzAYrSzxDILSLrwQTTu
         y8hd1njQY0YMy2b2KY5BNcK6GND6zQjyKlncnWAHodqk/epo7tc1duxplvrsR+dlQbpe
         TnEQ==
X-Gm-Message-State: AOJu0YyPJnOoqgQZwCXMuPkBYKezc5/zYJSevu+I9YDBtGZ6KvS74efc
	l4ioG17sXUBJ9vt+0Lyi/ITkfGFH8Qo6F8m1ZAjSYW0SmSIRTIEJiYzqV9OxA5k=
X-Google-Smtp-Source: AGHT+IG++NpE5nVpBwvC+n8aeiDgxT0MbJ14KRG2TL/xu5E8hBQLrX9CI0xGtSX/GS5saSVBFMDKNQ==
X-Received: by 2002:a17:906:394c:b0:a35:783c:edfd with SMTP id g12-20020a170906394c00b00a35783cedfdmr10794692eje.68.1707113331936;
        Sun, 04 Feb 2024 22:08:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVenP0DTqoL+uY7YvWvVPD7DTLBqvMexDE7ASUaNh43PlApb5yvbtjgDWw1A6gfA26u2TNfQCxn1Jv1hGO6yXEY6pzeyg9T4WZRyeadjzHXbe5I/7ob8aufLl8f0j8MkUGO6vQJKUoR+rj8ABVAuGycaOEHC+4+9qmFFx9AFuoTbfxBzHDYQjGCHzdL9Swbgp17jFVRC/f3RDC08etRNbZkjT10G5zCYcHzHyGYPnRy8vRxIhA=
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id u5-20020a1709064ac500b00a372d4e04absm3062598ejt.181.2024.02.04.22.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 22:08:51 -0800 (PST)
Date: Mon, 5 Feb 2024 09:08:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ettore Forgiarini <ettorenigma@gmail.com>
Cc: gregkh@linuxfoundation.org, richardcochran@gmail.com,
	ozlinux@hotmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Staging: octeon: octeon-stubs: remove all typedef
Message-ID: <9066fb52-66dc-4ff1-8014-11aff7d2d0ec@moroto.mountain>
References: <20240204092134.1265312-1-ettorenigma@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204092134.1265312-1-ettorenigma@gmail.com>

On Sun, Feb 04, 2024 at 10:21:34AM +0100, Ettore Forgiarini wrote:
> Removed all typedef so the code conform with code style
> ---
>  drivers/staging/octeon/octeon-stubs.h | 48 +++++++++++++--------------

These octeon stubs are just so that the driver can be compile tested
without installing a cross compiler.  They aren't used in real life.
You need to cross compile with MIPS and the appropriate .config to
ensure that you don't break the actual driver build.

regards,
dan carpenter



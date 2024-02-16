Return-Path: <linux-kernel+bounces-67939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CCD857357
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6428D1C2130E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF6FD2F0;
	Fri, 16 Feb 2024 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffea05ye"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC936D2E5;
	Fri, 16 Feb 2024 01:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708046427; cv=none; b=r3D0Hbd/f3XITW5BgOznKKoXt3gSQcYujmdq5YTDaSE+C4IJUTldsEKRHCNEPRl3MNiZ538OKW7Al8j2jScdZQS2l1aFghA/ovRk+iYPGPd3r5+L/6Pl/FH7mhop/rz/dAj+27it+EyeZ+ePsMhITZ4+KxXPPeyFuiRV/GJWYM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708046427; c=relaxed/simple;
	bh=7t61lVJkbVQf7kZ+oT41ODuJEATKakNHE1QCqqd/EW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=On6fg7Qr8fKVSVIru1kGT/1oAE5FEHgs3FK2zmamfV25O6ZYWhdTSioJs2aqKlHa5n1eB20EUzjLaxha1YZVfeqM1DdalbRrBFpWAGBxg7WIme1PGzFHk+/NkhsjGfNCO9+aS4SwQ9fe8FKBcbByYsDNrl+6/qSSoBPVebqXa0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffea05ye; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4121b1aad00so1380415e9.1;
        Thu, 15 Feb 2024 17:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708046424; x=1708651224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7t61lVJkbVQf7kZ+oT41ODuJEATKakNHE1QCqqd/EW4=;
        b=ffea05yeSWaPe0JCB0snLrmukSNyR1h2NbWswDMCJ4WEnab/3jJA3TEM8Fdt+uO0mL
         wJ/TK3rYufdBtfdfI8bp6ZZsDRk4Ntjxmm7GiXW2bCboVVY6ogwQrI4zc+vSqQkJyljr
         jmmA6v0fJm5ypgHfojRkB4H/6UXS2XVVKEgbfYpQ0+HiwPqvV86/h6ywowlOx/js3LkZ
         /472rLJi6nlQN9mRZWpNDOGXz9chMADGUKvqndDtNlbBm0ERZIdw3oHWMruMiRMqq9ox
         cH4bS5mjrSPQ5Gp+clKWPkZksWqQ+W0MV2w9TbGHf8bK8x4N4uLBrlBJ9RErtwr/DPFA
         uqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708046424; x=1708651224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7t61lVJkbVQf7kZ+oT41ODuJEATKakNHE1QCqqd/EW4=;
        b=nZcMpGHJnornMk/qe2gSmiiBqM94KFz7GlWml6Xs2rJfc/thEwRSnwv2iMyCXQSIjm
         KGB+v4FqDa8FyLCF/nQOWKK1mQMCJ18scU14N/6FfzBTdCwXKCql9TEYlgA1yPmv8ASg
         AMFIyj1hvrynnWxhXx8nJ/xbfXup89AURbBTRU/0K22lx0CtXD++3bVhmD5qoQmQJwHz
         Qr88AfJpAb+pzJ4x06UglCMsuiRzpyRm9KS774JpcHSKrPVsD08hj9J5tGJKSdIepF3I
         Alg2D9RH0ReUBmuCMuBuYSj7MFSqGheu69HR8Y1i2abCI7EvcihDTiUqrCsXTq/W041o
         8gfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgyKeOTro+3Vt9GO4O0mPyJsQHfdQ1L4IsrNuPMaEC4FNHofB9WGyBxJQOdYXYddjZf7nyqjv5jYHXPP7ZZ47jqlG5zqCsytsTpLMrJSgrNL6457PdoQY9g4XvWPA5LaMWcmiO
X-Gm-Message-State: AOJu0Ywsol3sgfSeQLikSkTlnQM/TNqfi50icBQwUUEjZzbXIsSydILq
	pGV5j/9okiR9HwMbMntln5AVuD1UWNYhUMpn/HFEUG9wo8lgyINW
X-Google-Smtp-Source: AGHT+IHKvjqg/vNRPv6KG9VtjTTkifmUOuBvef3+p71jAOJiBIqI7PxZNf+5v/qUNrXh4n13VqZFlA==
X-Received: by 2002:adf:e911:0:b0:33d:461:ebc2 with SMTP id f17-20020adfe911000000b0033d0461ebc2mr2334237wrm.28.1708046423753;
        Thu, 15 Feb 2024 17:20:23 -0800 (PST)
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id fs14-20020a05600c3f8e00b00411a595d56bsm714230wmb.14.2024.02.15.17.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 17:20:23 -0800 (PST)
Date: Fri, 16 Feb 2024 03:20:20 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: patchwork-bot+netdevbpf@kernel.org, linus.walleij@linaro.org,
	alsi@bang-olufsen.dk, andrew@lunn.ch, f.fainelli@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, florian.fainelli@broadcom.com
Subject: Re: [PATCH net-next v6 00/11] net: dsa: realtek: variants to
 drivers, interfaces to a common module
Message-ID: <20240216012020.2qqaulhxuybggiej@skbuf>
References: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com>
 <170773502690.28134.16915655104997076968.git-patchwork-notify@kernel.org>
 <CAJq09z44FnZknHAdmbxXf1F_H2QZW9SysqLLkErdzK70S1k1EQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z44FnZknHAdmbxXf1F_H2QZW9SysqLLkErdzK70S1k1EQ@mail.gmail.com>

On Mon, Feb 12, 2024 at 09:45:19AM -0300, Luiz Angelo Daros de Luca wrote:
> Thank you all involved, especially Vladmir who invested quite some time on this.

Thank you as well for being persistent. Unfortunately, due to some
personal things that need my attention, I have been reading my emails on
and off in the past few weeks, and will continue to do so for some weeks
to come still. Sorry for the delays.


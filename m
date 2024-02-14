Return-Path: <linux-kernel+bounces-64812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467AB854321
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B451C2243D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26763111B9;
	Wed, 14 Feb 2024 06:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNd5u5wS"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72FE10A36;
	Wed, 14 Feb 2024 06:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707893814; cv=none; b=q79Ll6pezL082wtO0Gz8EACpwr9hP9bwo2xCLWlM/b2FegOk4nUPw6zJvuc27l+QNqGGTGfgytMzb9Jibn9hXhop7TLpK7KmxuoPK0VYAaiewVAiajsvm9Va3napXksE9HlnyGvFISFG+9y8dx93vKi3EOvnAI7jI6k0qgd6+yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707893814; c=relaxed/simple;
	bh=ej1BQtIHZiJ+bLZHpdlP2uCwPAjbVbr4Q3laG2jWjMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKShVO0ZtItmfVGd0XvzB4qO1yXDQWzgvCNUDxloHino0e7gihJuFo6HGfr+VEOcem1CD/dFd63vAJ/AH/XLRn+ZUP+LEbRcoCJ9BqQzlIO+vdjncoflWXpQOBG3Q2A/YxpRsgvomsPRVqDcuYHqLXIJcjTxadkkCMCeFb2HmvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNd5u5wS; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d0e5212559so47941341fa.0;
        Tue, 13 Feb 2024 22:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707893811; x=1708498611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QorNyLHCzFQBTdpX8FSaT6urIZmUqpVjItDahBTzfOQ=;
        b=iNd5u5wSl0weZpNClXiJrLpljdHhjftqh3BZDvJ10+d/XcLCsYXlOa3C+xLhTs4k5U
         sp3kd2K6GYyHj9tJNfnQQAM+jfKFCnsKXHoV9z4qKMuxixMPJyKE05B2CNoKR7rP1WnF
         OkZvL1ix+hhtdLaxPaInBf2d0PCsVkL6M6OMJrzqQ5Sc4bnjIqM3VZK/pAQMQVQOcK9U
         t/+e9yASvDdZxiM2ORTb2EA+3Vv0DC5prcprwS6t4GjExYKnw5roBPU/dTSh2L5bIKSS
         EYVqoDG4i+MNc6vsTjoYiYQ36a6BlqA/99UItArU0zUAYwhkAiaF52Jb3OvhcUr4XF0o
         OB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707893811; x=1708498611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QorNyLHCzFQBTdpX8FSaT6urIZmUqpVjItDahBTzfOQ=;
        b=ArzuGQQrgcqqWqtBWrko1Vp8c+B+QuXKjj43uKUPHpJMAqW6gOZtPOcQy7OdMUtzTb
         w2ss3frSqAVqohPZsk6oYdYbsb51mu1xPrqmjbBRNxGmcbVE7SoEuxCT47MVGAZB8tzv
         LlrcES4VclP82si9UdlxAt4dZuX1Jn/yx/5wva9nvBRynHb64iu5DdPJaXLIqHDWpzB5
         1T7Zv+mKHD7nwx60yXJ3nrIcU3pAyG8bmXKewFub0d076Epw4AbPnTHzWGhEPYLR52OE
         eRo5dEUckak2Zxbl1xrKhhG/wY+UYgl21oyNh+BAMO7j+EDV1d0ewCJGQ9DEU6xbLDg5
         DZ3w==
X-Forwarded-Encrypted: i=1; AJvYcCUCS3iOTF2ozo9XPf0Dhb5hpxp8HpPe7snk8wxnm6wjhGYw368ouoCgn4DEqkdpAx7uH0CLNcz3fLZPMA2/N7bcd0XupKc/wF7derFnSWxJYWDhrnAAM2WTKFA5XDc+nooV0ZP8
X-Gm-Message-State: AOJu0YzuLQFh+kZYifzTZ6VyWeLHD53tyOh+uC0c7KA+ey5lLCwPGGwB
	kMCDJnzOu1aBYEDVNF76r8teZ9JNvv2dG+uvq+EqJMEAEe0fleqs
X-Google-Smtp-Source: AGHT+IEFQzhVaCIBrydcsY5zV5nmDj5qCS8gmDaoF3oeKAStErzDYIu5fFWV2EKHTerZ+wjatmLa4Q==
X-Received: by 2002:a2e:a585:0:b0:2d0:ce72:570b with SMTP id m5-20020a2ea585000000b002d0ce72570bmr1403977ljp.48.1707893810555;
        Tue, 13 Feb 2024 22:56:50 -0800 (PST)
Received: from eichest-laptop ([178.197.206.161])
        by smtp.gmail.com with ESMTPSA id u3-20020a05600c00c300b00411ec07674esm622452wmm.31.2024.02.13.22.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 22:56:50 -0800 (PST)
Date: Wed, 14 Feb 2024 07:56:48 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 net-next 14/14] net: phy: marvell-88q2xxx: move
 interrupt configuration
Message-ID: <ZcxkMBfnJo2cJyWv@eichest-laptop>
References: <20240213213955.178762-1-dima.fedrau@gmail.com>
 <20240213213955.178762-15-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213213955.178762-15-dima.fedrau@gmail.com>

On Tue, Feb 13, 2024 at 10:39:53PM +0100, Dimitri Fedrau wrote:
> Move interrupt configuration from mv88q222x_revb0_config_init to
> mv88q2xxx_config_init. Same register and bits are used for the 88q2xxx
> devices.
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>

I couldn't test it because we don't have the interrupt pin connected but
according to datasheet of the 88Q2110 it looks good.

Reviewed-by: Stefan Eichenberger <eichest@gmail.com>


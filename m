Return-Path: <linux-kernel+bounces-47441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29181844DF7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D879C289715
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20372119;
	Thu,  1 Feb 2024 00:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsYdTmXo"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D381FC4;
	Thu,  1 Feb 2024 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706748026; cv=none; b=q5dx9oYf12gXaC1UdIRQyvQfB/H7dUOnCWJ5NW09sJMm4xUuD2wXIa+9QczTf5JLNnpOyulqXbJo7rVPAIN7KzfGRQOsPiEwSCz8H9Qr6t7SpAc49h71m4eyBkfvB7wwXEctqpI23niixac0vARbpZB5UNI2iTe3hYIFVUflcfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706748026; c=relaxed/simple;
	bh=+SYTEiWd3ei/i99ROOIyzPiax6WXGQw8eCHQvhPxfVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEWsVOT9ljXGDY13qSuEqEWLiH4H+Nk4Tzb/e1FEz/UBWctvU8R/z5wG8AABBon4Mh6wP4rJ8upQ0UgwxEs+Bj+pdSl82xu1H0gTeD3h1IuelbD25kLTqlpxo746uKWmeBmCroYV597f/yN6PAB47cBhjxWApnJ4cMPDiBGQYh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsYdTmXo; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55eee4a042eso389756a12.0;
        Wed, 31 Jan 2024 16:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706748022; x=1707352822; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qbjJC98r+qpTu3PyOr00QdakLLKceHFoJEQ7I7tf1IM=;
        b=jsYdTmXowmW1TEAjs34rn8L/0dcpduMXn54MpcdcxzKw8A4Y9qwtAGeXoPebVbj39t
         E7XvE3qT19XingC1ZcUNc35KeoiZz/ZV9+4e9I+/fqkltxn7/o192DM371N8FTUxE92Y
         VauUEIc+xIIOUJeda/Kk8sQVFew4Y0pC9wd9x55WYgbaCcEUEPOXRKjbVMZhABrxeGzR
         WnjEVoNbJESHa5OZMhgWdmFQK8IXhocrfMUdRAR6wsPLR5qrI5/GKvli6ud5IBW0rrh3
         uh/7Drj9waGkdfqc14nPoJKf5ri6ZdNaygWbbE2UQIh2hvq32MP+Ez72XnGdj+6ORpuo
         Y/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706748022; x=1707352822;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qbjJC98r+qpTu3PyOr00QdakLLKceHFoJEQ7I7tf1IM=;
        b=NNOaGrhntz+/oHaIZHDDWO2Pj8t+Vr+UFp2yT4iVv4Tbus9E3aBkNnspZVSjC9TCJZ
         YAfplyDswpFqAuuI0N+PBLjj55Kd1OP1wwQyscDZNpNSaEHQqnKX7fU+79wsar1h/7bK
         ZbbGw/9QS2EjHz7RotxCgfmobdxuXOgy5JW7OplXiah8oaCWdEzYK7hNv/Ec7Ogsy1q+
         ZtCdzm2eWyss9DXSkkxA/x0Z1LRkZ4URe3jra6kwDPmnqzjrv8UhTOM6X77xWY0wtUbh
         1mAt8/LSs3urJR1PZNpEw1zcK0ewkQ/w0HvM/knn6wv+1E0vBHeW3GvwFLJTdReHLYM0
         LB3A==
X-Gm-Message-State: AOJu0YxZVF1FyfZvQjN4S0oOnHuy+Pijo4YwG4FgYCB4cZ5Ij383wkgH
	V+tPdvH4ITq6YHyNZzEmfwes50x/55MMO540Dh+TCeHypfqorUFk
X-Google-Smtp-Source: AGHT+IF/5ZF07ZKq358krBlDzbuHmTzHg0S/Hti0Mw4DobP72TcCHVIFwdSRgOoEdTHzkLIXAjr2LA==
X-Received: by 2002:a50:9517:0:b0:55f:a88:9ef7 with SMTP id u23-20020a509517000000b0055f0a889ef7mr2184217eda.14.1706748022366;
        Wed, 31 Jan 2024 16:40:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVKXwv9V81hnu6ZZLLHcArQpIpKvG2SWqxltsCHFKOC31VlXNlkIC3zfVyymlF8hWshqULZgXA2bpsUv4QOIO/bJvk9XkNi5mR2I33NnCjXXo3sTnmo8/RROOz212Ay9BaI085cLE2hP/xjIdaax1boUbElrDdhQ44pM4k2c48qk/9OpbNCRz7yGR0jVx9aNBqmYVV2u5vcCFYGV2owrQa4acriP8e8ptQmB7TQ/o4bqzgCqbUiu7ToSXIWaqdBA7SwM4mjuQyj5IFAEJ/G+fmcY2zULi6ys2B2Xz+P/KroO22ZbarThaAOwrdmuv3TCeHt8yFUE/nOd8dcbI4L7RCmTTZNZT3OnJk7Fux23pWifqIhkHWSib9nJBFdhX8y+ofyeFqx
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id w10-20020aa7dcca000000b0055f48b49d05sm1922690edu.69.2024.01.31.16.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 16:40:22 -0800 (PST)
Date: Thu, 1 Feb 2024 02:40:19 +0200
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
	linux-kernel@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH net-next v5 01/11] net: dsa: realtek: drop cleanup from
 realtek_ops
Message-ID: <20240201004019.q2fxr5yajqs2b4zw@skbuf>
References: <20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com>
 <20240130-realtek_reverse-v5-1-ecafd9283a07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130-realtek_reverse-v5-1-ecafd9283a07@gmail.com>

On Tue, Jan 30, 2024 at 08:13:20PM -0300, Luiz Angelo Daros de Luca wrote:
> It was never used and never referenced.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Reviewed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>


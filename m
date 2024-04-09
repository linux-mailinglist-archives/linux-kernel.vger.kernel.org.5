Return-Path: <linux-kernel+bounces-137439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CC789E22B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88B91C21DFA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF4815697E;
	Tue,  9 Apr 2024 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwRz3dv0"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FEA156870;
	Tue,  9 Apr 2024 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712686095; cv=none; b=s7scTmkSgexgnaz3DGRoHgPtola9OfW4gD/po5DhRMCmAA9WMSyEXTZR6ebpeWiNq3Rv8zePEvis/7/erqFj+r2IvpA2KXEn2x+8vyVRICVSXlEvN1wE+iZrRto+TFyvZkbI0mR2u1GDXP9bG8W+rPqHAdMx8gyx2V0k4zKrlPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712686095; c=relaxed/simple;
	bh=2I9xZFzWhxswz0ShSCkZGYHy3IU7FgiErcUKJcNqPpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiA1vr8zJKegMstbDy5VgmHTgl+qcdL16N90BsWG6+I7KJrPDkKm7LXx/y5JZEsm6/tOp9ZBIMm1c5ll3LhzT1LmihD5sGdfUWgFngwrtBoiKIoxhPuWqeqrxdMYO/BXklsoxgk8Z4Pl4jDJvfqWm/VQn+9kGS5f4vnuuLtsv1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwRz3dv0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e3e56c9d2cso26891445ad.1;
        Tue, 09 Apr 2024 11:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712686093; x=1713290893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POlFcO8rRiMn4XpW5ioQKkg2ZlLEK2LdmVjbB41yM08=;
        b=XwRz3dv0t/QVi131duexDuB3svITlJZT5nLvY8Ftx6NvYyjXHJQhaIsM2X8N2NEwI8
         m4xNJG4pqmpkaJKdlUEyGd/oUbqdBdo2FKrQ8aC3bYba9mBBhZLaFbW+0EUCNkgOOCAM
         P0DFhkRJMjLBkh9KKd9YmKMlNG2It8yLbhhtpcde+uvRhDeLxOX6YBtucvMA63Rc2YWd
         2Bh5OQDZnNDZDmC/WvknYeuJ3isepmfwgEKvjebQ31bT+T4H2iuuy4+qWcWOuqkmpVKX
         l/EaKEPfl2pxdkc1VZsoxRCkxk4GalLITiZXBGxcYcuI4ChuPSlIGWE+OIhSnBSCQKbr
         H8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712686093; x=1713290893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POlFcO8rRiMn4XpW5ioQKkg2ZlLEK2LdmVjbB41yM08=;
        b=kIf21v0XUdCXeOOvfAYrFMYLl7TwmWnPvUrBTL8QT3Aq6o0f4vxpMYKlopgWEgsoCk
         ugfxO59HnEbT4i1yYo1AECaTfQ1EQVuz15Z3wEeg6e/YXClI6PZQakMJkidr8KbF3dog
         orTjjEl3E1pJ7/ePexPfJxMCxII2l8UF7MvEYAyOkAUR2VNVa89X27qd3f0OFCoeuPH4
         lY11S8+bq+QFgZap6Qfuo0+hgVIs7U4qhgAngwJIT1qUJ7rBzjZk4grlFPVxwOrrbJuw
         ARrOpMsTdWmOOkL9eBJOpQ8lFU9B4TvpJ2Omb/BSpRHXnCIaDfOou/EsEy/MJYQ8iq7w
         +IYA==
X-Forwarded-Encrypted: i=1; AJvYcCXHFWGVIMn7W5SsxY3rNuddgNaanzf4U5wsrVa1Ycu2bltzPRAdIrYIaFRXg/PK1/zMfrLWPi37iD8boE2HPcAjMyJrulmIBfjmBnv8WWs5MBH7YNa7+O8Qi1SaAI9+A9vVh74N5scK3iA2XELGhYyozEsl8F6D6Dw2Gg+LB/G5EeVUQGaP7blx
X-Gm-Message-State: AOJu0YzX92NsSENsKzZFTKW/ziPBwg0119qmSEPZigpx8tte0UERDbqY
	jrxeV+77LTKq2VrkiEVAZxJwrEy1ZC72oj69/wPZ40MbzmZpwyLR
X-Google-Smtp-Source: AGHT+IFzjFhyBMx6hv8MZ4xwZSSjTQZI1dh3fOoNpvvtY6yc9ogy1c4zmy1+R4Fpx4j8O6s7YrZffg==
X-Received: by 2002:a17:902:ea01:b0:1e3:e243:1995 with SMTP id s1-20020a170902ea0100b001e3e2431995mr677747plg.1.1712686093000;
        Tue, 09 Apr 2024 11:08:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i17-20020a170902c95100b001dda32430b3sm657972pla.89.2024.04.09.11.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 11:08:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 9 Apr 2024 11:08:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: PeterYin <peteryin.openbmc@gmail.com>
Cc: patrick@stwcx.xyz, Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] drivers: watchdog: ast2500 and ast2600 support
 bootstatus
Message-ID: <01a07242-22ca-4abe-80f9-72ac4de93fb7@roeck-us.net>
References: <20240328022231.3649741-1-peteryin.openbmc@gmail.com>
 <20240328022231.3649741-5-peteryin.openbmc@gmail.com>
 <47835475-36de-4682-84ae-0163d45d0bac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47835475-36de-4682-84ae-0163d45d0bac@gmail.com>

On Wed, Apr 10, 2024 at 12:28:44AM +0800, PeterYin wrote:
[ ... ]
> 
> Hi Guenter,
>    Could you help me understand the definition of WDIOF_CARDRESET in the
> kernel? If it resets the CPU, should all values be reset to default? Should

Documentation/watchdog/watchdog-api.rst says:

	"Card previously reset the CPU"

This is a bit historic and was probably defined when watchdogs were
not typically integrated. The appropriate description, applied to
current watchdog devices, would be something like "The most recent
reset was triggered by this watchdog".

Not sure I understand "If it resets the CPU...". It doesn't _do_
anything, it just reports if the most recent reset was triggered
by the watchdog.

> we check the POR (RstPwr Power on reset SRST# flag) flag in SCU 0x74
> register bit 0 in ast2600?
> 

Only if it indicates that the most recent reset was triggered by the
watchdog.

Guenter


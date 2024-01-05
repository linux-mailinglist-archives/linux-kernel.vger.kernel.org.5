Return-Path: <linux-kernel+bounces-18396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA4A825C7E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 23:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 110F7285BFD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB4D3609A;
	Fri,  5 Jan 2024 22:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5M4n4NY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4666358A4;
	Fri,  5 Jan 2024 22:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d4a222818so5798075e9.0;
        Fri, 05 Jan 2024 14:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704493237; x=1705098037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fvAsbhn4zJAhQm5EKfY4yEOpwtln0a+WYL/6ejR1+Jc=;
        b=H5M4n4NYKGrs3dW6zD6rZeIeVQN3ZMBl6FIdku0f71gC7HK/l6ku2/uMg+k7dh0O+6
         OGWhzSdSNiaEo4mvr48iPqZMAcdPhG4bZ6m9BMI9WmPMkYuIc+2aWYyqUWRu2oBcIwkJ
         f6X514zAzcIgzU0tkdDmSniqg3ulPTlajPkYyYFaTM5Jt76CtxqmdYcH95FjjXXHV4yy
         Fr0i72zh5S+r/H7sI+nmWe8LHQu8fUI2m96iMkfdHiz4X/FyzXx+FY3JGuHXn8UBpSQj
         790enMq7z01I7NUP0+w1zfXSldnRsxOQ37+hMEqVmO9RbOsKmxh2xzYjFhk34RMzdGcI
         vd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704493237; x=1705098037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvAsbhn4zJAhQm5EKfY4yEOpwtln0a+WYL/6ejR1+Jc=;
        b=h9xDOOugKFaVgnn7k0RtzlhZ3AYokCOfNIgJAjDQZWYE4Gr6aKvJhUOsNSpQ02IrG5
         IDvz4pFzg3+Nt7RRdeHZjDYEL1xCnBypRQff03F6u/Rw9e5Taa37S4F0kpsN8eNl4atM
         xdH42XYH6Ksk5mkEAVNFeiPpbW0/yw1sy/7uYAZVIQyQPV1Nh0n6FNkewaGofohoL6Pl
         DwVIcAHBcrJEoatA91zi7zA26ZAKJiAKBuVMnZXmFhVwqAXOdNQmraNcb+35+1YDoqpl
         mczq+y+T3TRlOOVLJd2eQUp/a6Q2pQiaRCC5+XL3L83SiuIQYnEOX8MuJRk47Mz8tiUR
         KZig==
X-Gm-Message-State: AOJu0YxTDUYGJ9SDkkc1rDZ653Gkjrb4QXGSlItDIuzNJQcNkRPAQM2y
	Nj5lBeMlMCTMGM5VjSsL/EM=
X-Google-Smtp-Source: AGHT+IFcnNmMj2fkzftZMQsq1Do6VXzRlNJrtk6H6XNL9C4WNka4Xtl5CRPRbW5wz9Sfxi8YNcHCCQ==
X-Received: by 2002:a1c:7903:0:b0:40d:94af:6c25 with SMTP id l3-20020a1c7903000000b0040d94af6c25mr62000wme.24.1704493236909;
        Fri, 05 Jan 2024 14:20:36 -0800 (PST)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0040d772030c2sm2716355wmp.44.2024.01.05.14.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 14:20:36 -0800 (PST)
Date: Fri, 5 Jan 2024 23:20:33 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Stefan Eichenberger <eichest@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: marvell-88q2xxx: add driver for the Marvell
 88Q2220 PHY
Message-ID: <20240105222033.GA40773@debian>
References: <ZX78ucHcNyEatXLD@eichest-laptop>
 <20231218090932.GA4319@debian>
 <ZYAqxPZHICtZO15O@eichest-laptop>
 <20231219081117.GA3479@debian>
 <ZYFfzei3SJSts5E/@eichest-laptop>
 <5d545a9b-feda-4908-8f74-9218806451c1@lunn.ch>
 <20240105124221.GA30964@debian>
 <c7b1b220-4a76-4cc0-b68d-cec5977ebadb@lunn.ch>
 <20240105154351.GA39937@debian>
 <ca76b515-9659-4fed-8a1a-402923b72868@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca76b515-9659-4fed-8a1a-402923b72868@lunn.ch>

Am Fri, Jan 05, 2024 at 05:06:53PM +0100 schrieb Andrew Lunn:
> > Hi Andrew,
> > 
> > > Do we need to reduce the init sequence? Since this is all undocumented
> > > magic which nobody understands, it would be safer to just keep with
> > > the Marvell vendor crap code dump. Unless we really do need to change
> > > it.
> > >
> > You are right, it would be safer to use the vendor code. But when
> > looking at the vendor code, the init sequence changed a lot from rev. B0
> > to rev. B1 of the PHY. There are some additional register writes, but
> > mostly the order of the register writes changed. I don't know if this is
> > going to be worse in the future. Maintaining different revisions will
> > probably take some effort or at least result in bloated code. We probably
> > don't need all of the init sequence. I'm not sure how to deal with it,
> > keeping the init sequence at a minimum is probably a good idea.
> 
> Is the revision in the lower nibble of the ID register? We can handle
> them as different PHYs, each gets its own init code, and share what
> can be shared in helper functions.
>
Yes, lowest four bits. Handling them as different PHYs would definitely
help maintaining PHY revisions. Still there is the problem with this
huge undocumented init sequence. Is this going to be accepted ? Didn't
see such a long undocumented init sequence in any other phy driver.

> 	Andrew

Best regards,
Dimitri


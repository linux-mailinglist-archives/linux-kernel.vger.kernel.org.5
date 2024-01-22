Return-Path: <linux-kernel+bounces-34286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F8E837797
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 00:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C662287067
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16314C3A0;
	Mon, 22 Jan 2024 23:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVRE0u/k"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46624BA8C;
	Mon, 22 Jan 2024 23:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705965268; cv=none; b=GrDxpaw2v/RK635fR/dmtGX+Y6qkkJVVQmcvWM9y7DQb/w4FsYpucA+OydvlBr4Hymvpw/YGtFQicohnWZK1QkYgh2Xiwn483B2RTWQHjbq5ei1Tk0hlQLMl/dyX3kDHmdQfsFV5THOlG4IZ2jUWP8pcOcGtVpEbXrTZFJuRBN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705965268; c=relaxed/simple;
	bh=J+Nv+hdqVF+im3TfXxoL+5ny+DELxKOVdeT8dwnwp+w=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIGuohYQVrsWZiUkEdfPUO6hnGzoN9fcz4Qck7kxtaB3q2VvKiXmYxldeI7Gl1MBHYTdDvWznbxkufc/BKYj6dradW4oI+gk0Q38tIKYTtrLb5IeV8DFcyBCwHObFNKhEi3w2o2BnOWL5EK7PG22YwPUZYsdLOrvFAj88jq8huQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVRE0u/k; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33924df7245so2579525f8f.0;
        Mon, 22 Jan 2024 15:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705965265; x=1706570065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LDR/kvoyAv+Kg1rNifyUzWqNwxfd+kAINIMhGDItT0k=;
        b=TVRE0u/kPy6Oto43hmclYfWFqysgvVjLxjBzWWiQY43ZnyV9GotAAw3R0/N2xwx/Zy
         bhizyCUpc6uDgkMqxYTT6w3SEL0affwYOc1PKf2O65dzo8RPXbBPYKriGLdjrCHbMT2y
         VfbSGYwO7cesF30isvaf2ku/xTKNO6NDyopHydHHtuL3QqkzRxlZndx7Vez1Ie6tmgHO
         Fh5mpbcUhvFvxQrGH1iE80zpxCe5OwLM0cgWFEw8r70mfqYYSOtD7gnw+kEr2LlfgArb
         kpglwToM2KOX92hsI6h3Azhm680IH6ZfcV4G1Er8Ful489uUhSDU7MHJAK0O+Noc0xfX
         TeGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705965265; x=1706570065;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDR/kvoyAv+Kg1rNifyUzWqNwxfd+kAINIMhGDItT0k=;
        b=PeeQb/DX5GNJ/4tzQVo+ZHUfLOkeUeoiY2U3o+4mD3/gvCWf1v+LqeUUanrK47fbJn
         gzoAclL+y6Yl1E+HLRb3cEvt1wrqEhWfcsWDe/a1uUEz5fWNU2xPDsvYIT58E5PxkLRy
         85GT7EfPREEV2iGUe+9B+ytmQkAi8gITDiJrLGm9/e3rGYx8wADf4qav6wksORABpboF
         cpb9w+Xa3tm0mDglsVR+3DrzzN6IH0LLo4ghDIEq282H1Qmfjqzv0xbsaYZAiXnKxfrT
         VK6uZHVBqbS5Oowsg2WTMrzPTXq6jYsutZKqGt6wR/YGQu6l3aBWk9LbYwgHRRphdHte
         AQ7Q==
X-Gm-Message-State: AOJu0YyQy68uSURb/ukTXfTV5P9qeoneTbkJj3t/X7nRGH7P6wlLxxAU
	YTJADY9Lu7ANIYaqFraeIMrmNQvFozu6gIrDWdyrKi2pplWsDyCt
X-Google-Smtp-Source: AGHT+IGho5OTYN6HS7J0wQiT0HOnK/Y9tWkjndbiJS4yvlyAFVhGQdAemOhOpY7G9T7boXgjdjTt/Q==
X-Received: by 2002:adf:f811:0:b0:337:c097:db9f with SMTP id s17-20020adff811000000b00337c097db9fmr2745493wrp.17.1705965264410;
        Mon, 22 Jan 2024 15:14:24 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id m28-20020a056000181c00b00339280c57e4sm7465215wrh.102.2024.01.22.15.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 15:14:24 -0800 (PST)
Message-ID: <65aef6d0.050a0220.54d73.c4e9@mx.google.com>
X-Google-Original-Message-ID: <Za72zG-qUjeoywrd@Ansuel-xps.>
Date: Tue, 23 Jan 2024 00:14:20 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	=?iso-8859-1?Q?Fern=E1ndez?= Rojas <noltari@gmail.com>,
	Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Subject: Re: [net-next PATCH v9 0/5] net: phy: generic polarity + LED support
 for qca808x
References: <20240105142719.11042-1-ansuelsmth@gmail.com>
 <20240108191427.6455185a@kernel.org>
 <edfd300f-224f-4ce6-930c-d9419a2077ab@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edfd300f-224f-4ce6-930c-d9419a2077ab@lunn.ch>

On Tue, Jan 09, 2024 at 02:55:26PM +0100, Andrew Lunn wrote:
> > Looks like we're missing some tags from DTB maintainers here.
> > Andrew, is there some urgency in getting this merged or can we
> > defer until v6.9?
>

Should I send a new version now that net-next is open again or it's ok?

-- 
	Ansuel


Return-Path: <linux-kernel+bounces-19712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A10827163
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554361F2336F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFC842041;
	Mon,  8 Jan 2024 14:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGLgrXGW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF4B46459;
	Mon,  8 Jan 2024 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33765009941so1551051f8f.3;
        Mon, 08 Jan 2024 06:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704724282; x=1705329082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d/S7O31EVc7lqt98zrahh+JPlqe7mlmyUlcT0v5GvYo=;
        b=OGLgrXGWQr0czBeYPrSk5td63luHnUVYYuiawwotSNX1xZL5487yFt+ASGzqV+4q85
         f7A0z2cAZ8AGK8uaMcZPcQ3BOPTGkLLmVtgrLCaG6XXQmdHozCdHvjNjqPmmbzLqdNTM
         sf0lYuisaQQ1tvwuti7h31c9cca8KkueoRl30gFajc3WNwyptDddgzzMKSCQU+0pGRei
         9ILfbLhIrK1z+/QjZ/IAcLJYi3vgOK55qIemAKvaOCbPDw5DMB0FF+5ND3X3JI68FxBT
         F910okpevGeBcFzUqrDaO/OdC9/6TB0onB6cn8Sk5QzAQ6pXfwnaxmm3QDt6v3RmdVwp
         axRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704724282; x=1705329082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/S7O31EVc7lqt98zrahh+JPlqe7mlmyUlcT0v5GvYo=;
        b=IbpW40ynp6Tp9Epk9BBOcSYfuXFRfF1QDaDwliQJAk+pkEASkcZypRGarq+dul0pwc
         SwZ4rnN1/N6wxq0djCmMu7jT+4kWvptZYmOkrSD1+/ytQ9v6apwtYFHr/Cou6Zhrs1N6
         sa7UotFjtt/+Ds1T+eyxIuYMqIkJGu6VAZMBXoJu/00vpCmg541byP4MtpGx7FueqARo
         XjY7RGx4ATjBlOURpxhFpWP1LSKRSprn4bC5nl3d/9pPYilCMDhLaqIi4ePfQ5t+nqtx
         QS5swxwZ0HFi4vyoebwyRkQaJaHv/TW9l9fL0/JJTEMdfAdaiJPcIfrXV0FDrrqVVDcE
         Yzjw==
X-Gm-Message-State: AOJu0Ywt5sCil0X32Q4yhdE6uVwqdRUgoNHjK6V5zJ6IYeP4cwM4RCf/
	xyJNddC2jv5MYfxg0fKC+sI=
X-Google-Smtp-Source: AGHT+IF4Uzey1z+1nwigNdzkkGZzJ2H16kBnV0n6wOMwvThY5N69okDM+92FGL4ObGLTlkJG3n+N+g==
X-Received: by 2002:adf:fc8f:0:b0:337:1263:4519 with SMTP id g15-20020adffc8f000000b0033712634519mr1878454wrr.138.1704724282001;
        Mon, 08 Jan 2024 06:31:22 -0800 (PST)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id k4-20020a5d6284000000b00336c43b366fsm7968415wru.12.2024.01.08.06.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 06:31:21 -0800 (PST)
Date: Mon, 8 Jan 2024 15:31:19 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 net-next 4/5] net: phy: marvell-88q2xxx: fix typos
Message-ID: <20240108143119.GB36576@debian>
References: <20240108093702.13476-1-dima.fedrau@gmail.com>
 <20240108093702.13476-5-dima.fedrau@gmail.com>
 <10b09d30-70c6-4f87-8367-19b2579496a1@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10b09d30-70c6-4f87-8367-19b2579496a1@lunn.ch>

Am Mon, Jan 08, 2024 at 03:02:18PM +0100 schrieb Andrew Lunn:
> On Mon, Jan 08, 2024 at 10:36:59AM +0100, Dimitri Fedrau wrote:
> > Rename mv88q2xxxx_get_sqi to mv88q2xxx_get_sqi and
> > mv88q2xxxx_get_sqi_max to mv88q2xxx_get_sqi_max.
> > Fix linebreaks and use everywhere hexadecimal numbers written with
> > lowercase letters instead of mixing it up.
> 
> You could split is up into three patches. Its probably not worth it
> now, but its something to remember for the future.
> 
> Ideally you want lots of small patches which are obviously correct.  A
> patch just containing a rename mv88q2xxxx_get_XXX to
> mv88q2xxx_get_sqi_XXX etc, should be obviously correct, and just takes
> a few seconds to review.
> 
> A patch adding a few line breaks should again take a few seconds to
> review.
> 
> Upper case to lower case is easy to review.
> 
> When it is all mixed together, in a bigger patch it takes a bit more
> effort to review, a bit more effort is needed to look for typ0s etc.
> Its can be faster and easier to review 10 very simple patches than 3
> big patches...
>
It makes totally sense to me. Haven't thought about it. Thanks for
your explanation. I will keep it in mind for future patches.

>     Andrew

Best regards,
Dimitri


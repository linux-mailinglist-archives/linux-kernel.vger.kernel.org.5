Return-Path: <linux-kernel+bounces-5853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C0081902B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02996285A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B39A39851;
	Tue, 19 Dec 2023 18:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lrVUtA1Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E7039AE0;
	Tue, 19 Dec 2023 18:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3D5C433C8;
	Tue, 19 Dec 2023 18:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703012208;
	bh=aP+oDZf3uBfmiJg3JSNLhHNnVs/OqvcxJ8ra0X82FPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lrVUtA1QQbnYGSWhNTQU44tJcv6byJibtmumxObF5u0KcBiqeRdgkUyc5w6UmO+UR
	 sJtek4k1UskwJkokiFTI457+Eozv2INqalst9nHWi9V2IZz0ekMZIBM+aXSzKBzz8e
	 I0fNYZ6X4P2os8jIStQ6ShxZVtpT0Vk2037GBTgM=
Date: Tue, 19 Dec 2023 13:56:47 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, 
	xiongxin <xiongxin@kylinos.cn>, Andy Shevchenko <andy@kernel.org>, hoan@os.amperecomputing.com, 
	linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@kernel.org, Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v3] gpio: dwapb: mask/unmask IRQ when disable/enale it
Message-ID: <20231219-whispering-independent-bonobo-d14a04@lemur>
References: <20231219013751.20386-1-xiongxin@kylinos.cn>
 <7zdg5ujizncarxvdyahnusojiq44rzxx2zybqj4kzsonzr27gq@fm5wj7npqsk3>
 <CAHp75VceVAZYTNsJaYYRN+EMExFZSQARsJowd-CvDLRtuOPKSg@mail.gmail.com>
 <euhbczna4hk5sacb23i2xwqh2jewlek7cfceprfslpsiijhwk3@3d6vtybmgag5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <euhbczna4hk5sacb23i2xwqh2jewlek7cfceprfslpsiijhwk3@3d6vtybmgag5>

On Tue, Dec 19, 2023 at 05:31:38PM +0300, Serge Semin wrote:
> > > Also note all the tags you've already got must be preserved on the
> > > next patch revisions. One more time:
> > 
> > > Acked-by: Serge Semin <fancer.lancer@gmail.com>
> > 
> > I recommend using `b4` for that.
> > 
> > it harvests tags from the email thread, so no need to care about
> > possible misses.
> 
> AFAICS it doesn't pick up the tags from the previous revisions at
> least if the new patch wasn't submitted as in-reply-to the prev one.

It's a known limitation at this time, but it will be improved in the near
future and we'll be able to grab trailers across revisions as long as the
patch-id remains the same.

-K


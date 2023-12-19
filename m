Return-Path: <linux-kernel+bounces-6033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7AE81935E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804991C24D53
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E181E3EA95;
	Tue, 19 Dec 2023 22:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M5kQ74of"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B153F4EB3F;
	Tue, 19 Dec 2023 22:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE32C433C7;
	Tue, 19 Dec 2023 22:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703023804;
	bh=fJoKPF3cIWPPNHv5fq40UZr/K+Cyqvray5TB6Majxbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M5kQ74ofsDk6wtnLVQhl3F92ayuoiLe8MYgoZzYoZytoFQyJR3Sy2UdjB48ecZU21
	 +kf7G+9As/2D4SWxAT7a8Hd1DtUcBIAiZ2u8U3iRJly/19RcmA33XezBOw1r/lcopz
	 LQIC1Q0A9PZ6G22qFqoILvWWSCvuS0ZcUEDFi+Lo=
Date: Tue, 19 Dec 2023 17:10:02 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, 
	xiongxin <xiongxin@kylinos.cn>, Andy Shevchenko <andy@kernel.org>, hoan@os.amperecomputing.com, 
	linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@kernel.org, Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v3] gpio: dwapb: mask/unmask IRQ when disable/enale it
Message-ID: <20231219-fluffy-labrador-of-inquire-fafb28@lemur>
References: <20231219013751.20386-1-xiongxin@kylinos.cn>
 <7zdg5ujizncarxvdyahnusojiq44rzxx2zybqj4kzsonzr27gq@fm5wj7npqsk3>
 <CAHp75VceVAZYTNsJaYYRN+EMExFZSQARsJowd-CvDLRtuOPKSg@mail.gmail.com>
 <euhbczna4hk5sacb23i2xwqh2jewlek7cfceprfslpsiijhwk3@3d6vtybmgag5>
 <20231219-whispering-independent-bonobo-d14a04@lemur>
 <yko4bwzrnlvncljpgyxlsvioqeyf3zxb255qexlawooqjxvedn@dkr7i7fame3n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <yko4bwzrnlvncljpgyxlsvioqeyf3zxb255qexlawooqjxvedn@dkr7i7fame3n>

On Wed, Dec 20, 2023 at 12:58:16AM +0300, Serge Semin wrote:
> > It's a known limitation at this time, but it will be improved in the near
> > future and we'll be able to grab trailers across revisions as long as the
> > patch-id remains the same.
> 
> Ok. Thanks for the note.
> 
> I am sure you are well aware of that, but in some cases the tags are
> intentionally omitted in the new patch revisions for instance due to
> significant patch body change. How are you going to handle that?

The patch-id (generated with `git patch-id --stable`), would change if the
patch body is changed (except things like whitespace). This is exactly the
behaviour that we need -- if a tag was sent to a different version of the
patch, then we no longer want to retrieve it.

> Just make the tags picking up optional? Perhaps making the tags handling
> interactive with printing a text/context around the tag?

We may indeed be able to do --interactive for some of the commands in the
future, but the goal is to automate things away.

-K


Return-Path: <linux-kernel+bounces-8416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F57581B6D4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38A428398D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CB273177;
	Thu, 21 Dec 2023 12:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2erHNGY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC38176901;
	Thu, 21 Dec 2023 12:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB54EC433C9;
	Thu, 21 Dec 2023 12:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703163486;
	bh=033K9TtcdIyt3/7etVd6HveC87mqur9h9WtrpRCSawM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T2erHNGYaQOGesSaimeF3YhAFprC0mHxe65KQE1XcBOFUv4ZFlhFsSh1U8qYBkwMX
	 CepxHEf6UOaUkXzeIW7I60L1/UxHDcqZgkmLWO8owuEmzYdHj2FxsDrHtVDd1yFLmj
	 oKuD8fWRHn3Mu4VZhY53NKzZhm+uJtKjydMzyQ7QBXESSiaqrHIWKcQyYzm2/pLdfx
	 xPG08+i44ri1Uul3+KU5wz0T/MWPDxqDs2kJPKKsEBN9773mlXCrZPGSkYeXbRJaXi
	 Tybgl6xv0GIR8GB+8/fRwx8RlQRD85xGBglADhJMCh6g4wK/m3iO71tnrioqRKNT+i
	 f5p4BV8mctvZw==
Date: Thu, 21 Dec 2023 12:58:01 +0000
From: Lee Jones <lee@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Sean Young <sean@mess.org>, Flavio Suligoi <f.suligoi@asem.it>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: (subset) linux-next: build failure after merge of the pwm tree
Message-ID: <20231221125801.GG10102@google.com>
References: <20231221165805.0c4771c1@canb.auug.org.au>
 <170316329164.542553.8341559295114557258.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <170316329164.542553.8341559295114557258.b4-ty@kernel.org>

On Thu, 21 Dec 2023, Lee Jones wrote:

> On Thu, 21 Dec 2023 16:58:05 +1100, Stephen Rothwell wrote:
> > After merging the backlight tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> > 
> > drivers/video/backlight/mp3309c.c: In function 'mp3309c_bl_update_status':
> > drivers/video/backlight/mp3309c.c:134:23: error: implicit declaration of function 'pwm_apply_state'; did you mean 'pwm_apply_args'? [-Werror=implicit-function-declaration]
> >   134 |                 ret = pwm_apply_state(chip->pwmd, &pwmstate);
> >       |                       ^~~~~~~~~~~~~~~
> >       |                       pwm_apply_args
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] linux-next: build failure after merge of the pwm tree
>       commit: f7baa9ccef93ba1c36a8ecf58c2f4e86fb3181b9

Actually it's:

  f7baa9ccef93b ("backlight: mp3309c: Rename  pwm_apply_state() to pwm_apply_might_sleep()")

But don't bank on the commit ID staying the same.

-- 
Lee Jones [李琼斯]


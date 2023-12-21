Return-Path: <linux-kernel+bounces-8409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C7381B6BE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF0F62827E9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F99F79495;
	Thu, 21 Dec 2023 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYPGxdcM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D9A7948B;
	Thu, 21 Dec 2023 12:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC207C433C8;
	Thu, 21 Dec 2023 12:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703163293;
	bh=gjAnolfE2FcHVQbN5nMQ4XL6hw2OIIhWaB+RaGwAJVs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fYPGxdcM3zlhCV40fpaLWsSbXiTueVZSt/rgudY/P7ITUorDhD9yL4OKOvzNkv11f
	 aRBPJt57GFt6WBQPUEmPQ0ZEMcr5Y6SwSF3dGiWmuRP5BZOlk7mO6jOKjFdrr9Rzgk
	 Jpxt7jLDLAnZlfKD6zNCqkKgfOxAdd+cjVGr619SJAHtHUswQJ4LhLd20381brIAbx
	 H+/063CdJMw/txYooszcwhn2ttOOQa8GlNIYg4Ajb+P/BnqjjcOjGZmXBf7OCOUTlS
	 fgI8PyTdXIb3xMguoIahtJjazaBrtzJFWhN8wFBSScTB5NtXd7ySJbhfOZBIRRbJbc
	 1awPd7MM22z0A==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Sean Young <sean@mess.org>, Flavio Suligoi <f.suligoi@asem.it>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
 Linux Next Mailing List <linux-next@vger.kernel.org>
In-Reply-To: <20231221165805.0c4771c1@canb.auug.org.au>
References: <20231221165805.0c4771c1@canb.auug.org.au>
Subject: Re: (subset) linux-next: build failure after merge of the pwm tree
Message-Id: <170316329164.542553.8341559295114557258.b4-ty@kernel.org>
Date: Thu, 21 Dec 2023 12:54:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Thu, 21 Dec 2023 16:58:05 +1100, Stephen Rothwell wrote:
> After merging the backlight tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/video/backlight/mp3309c.c: In function 'mp3309c_bl_update_status':
> drivers/video/backlight/mp3309c.c:134:23: error: implicit declaration of function 'pwm_apply_state'; did you mean 'pwm_apply_args'? [-Werror=implicit-function-declaration]
>   134 |                 ret = pwm_apply_state(chip->pwmd, &pwmstate);
>       |                       ^~~~~~~~~~~~~~~
>       |                       pwm_apply_args
> 
> [...]

Applied, thanks!

[1/1] linux-next: build failure after merge of the pwm tree
      commit: f7baa9ccef93ba1c36a8ecf58c2f4e86fb3181b9

--
Lee Jones [李琼斯]



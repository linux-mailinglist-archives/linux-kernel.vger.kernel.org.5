Return-Path: <linux-kernel+bounces-166748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0528B9EDF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426631F23060
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D40D15E21E;
	Thu,  2 May 2024 16:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9jc74OP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4C51EA6F;
	Thu,  2 May 2024 16:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714668538; cv=none; b=d2+qCaOlqUL5NU0ck+YPILxaA6/go2Z9ocUyEspnzJz0oLKSsBaUnaOhMLpg/u2iP+cRxu/SnrRZ01siLTm3TLatFz6T8lABmdZrcoXCRsjXjsZjMiV5lo/tUkZMMJZ8fYONopgYPPjZESa1Llnmo+bcbAsgAs7VLP0HuFhHsPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714668538; c=relaxed/simple;
	bh=6KSW55LKrRMaLuZTWE2c+MuzCl3d3O1DhTlxbvZ2JOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYdNjcrRCHDcoqM9gcmUsqUlEuKKNCs29TtVO6JwBxHhAKiAI+mtAty1ECKThRewWZux/cjCaroRDNK6N5gE+DoFhBuUPIHlNB/e8Fo+9K+2wnOPdmqoagJZ1RFpLol4lMPIbzsMMrDXkCU826ofIQo02EiVk5YqDpHBpncpzJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9jc74OP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6B0C4AF14;
	Thu,  2 May 2024 16:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714668538;
	bh=6KSW55LKrRMaLuZTWE2c+MuzCl3d3O1DhTlxbvZ2JOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B9jc74OP9o36h9eW28C1v+9ASBIYZVP17c1rbyhjlN+tm/BtN0ttPRjAtTGrLdJmn
	 sJ9Lxxa6d9V4ar4afrdx8JuGN/m6sNRB3oNc4qS7L5Fg+i08TLm9FKOkZ73G78YH5g
	 CPxx8DvpGBSZ7m//fmNKO8SMHK5dqv50PHCNDMNysfmGnaMFy+ZPsSTFYXhbUny71p
	 IddfpncgZfgxa1EGeHC+P1t2JF0Be0inNgaSMBE8r0KuomUDtN47BRa1Yz/GiVCQhw
	 cJSoesmxBtR6Od6CDGmYMHJkUqM2rPjX/R1GqkcTMOmd0+j3SVGZ0Wr19gKy+Y3LHE
	 nJBeMzQ+XGctA==
Date: Thu, 2 May 2024 17:48:53 +0100
From: Lee Jones <lee@kernel.org>
To: Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Flavio Suligoi <f.suligoi@asem.it>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v1 1/1] backlight: mp3309c: fix leds flickering
 in pwm mode
Message-ID: <20240502164853.GB1200070@google.com>
References: <20240417153105.1794134-1-f.suligoi@asem.it>
 <20240417153105.1794134-2-f.suligoi@asem.it>
 <171466849494.1206441.17324969195592920195.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <171466849494.1206441.17324969195592920195.b4-ty@kernel.org>

On Thu, 02 May 2024, Lee Jones wrote:

> On Wed, 17 Apr 2024 17:31:05 +0200, Flavio Suligoi wrote:
> > The mp3309 has two configuration registers, named according to their
> > address (0x00 and 0x01).
> > In the second register (0x01), the bit DIMS (Dimming Mode Select) must
> > be always 0 (zero), in both analog (via i2c commands) and pwm dimming
> > mode.
> > 
> > In the initial driver version, the DIMS bit was set in pwm mode and
> > reset in analog mode.
> > But if the DIMS bit is set in pwm dimming mode and other devices are
> > connected on the same i2c bus, every i2c commands on the bus generates a
> > flickering on the LEDs powered by the mp3309c.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] backlight: mp3309c: fix leds flickering in pwm mode
>       commit: ce60cddc2abf61902dfca71d630624db95315124

Applied, but in future it's; I2C, PWM and LED, thanks.

-- 
Lee Jones [李琼斯]


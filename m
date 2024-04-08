Return-Path: <linux-kernel+bounces-135435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CE789C283
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A58E81C21EB2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C087E57F;
	Mon,  8 Apr 2024 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WGDbytTd"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A067E105;
	Mon,  8 Apr 2024 13:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582841; cv=none; b=XjUQc4bviAoX90RlYQMsF4XPH1tdUjF8QMTIFC/NnsgZebZYMFBB7Q2E0dO4Sv4YuKIbbkfteUxnje0ju94MDM0aipDaYJuL0wWRpM5k7R/W1aIir3kbIvS8EEgCXbsMS++PhOx4EwndFDpSPhEVNZChYo/Lpn0SfhC26SiMq9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582841; c=relaxed/simple;
	bh=LVS2JIxBG8KePP1o4WY7ACfqp/ywU/BjJFtNQjOpjZY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hnL1ZfQcRo+NUXnQldoldZ2hLMzPOD37OPZqbTgW8035cJuuMl2eplKyuUkX/G6WllSUkntcV1+nmZFEfPPPfU9CJEkw4FuzCm+f8OZpKxvppAdWcf/CzgjJ4DmK0kKt5jhbleEx7fw1Wo9tk+/pFEYGtITVvw5F+M9L3q3gTnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WGDbytTd; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9541D1C000D;
	Mon,  8 Apr 2024 13:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712582837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PT1ktAiGClmeJaCw+6rHWVwenUX5YSLFJgf7PEdawS0=;
	b=WGDbytTdRRWHkzQ7ZMesdhILKWZxktXmxRW/YIOxouEqNY4EcrJIAaIEx00VLDBlKOB/HI
	Kra4Ra+R+4lJFJ5rBWcnvl5giexBTnAfHD025zuLm2q56tlRJO8dvMhJbhkAU70eiylgI7
	h40AiQjGjM9q95NV4fzvovFLNbZQp8NHJ8vjLt3j0Jc+TO4+kMGH/tPl+H5ISyxDq/MOTS
	9DJWHV8qlxfXTH7OmTsaWTF9hTJ2Rwz1DIPubazM21GB4yR/TpTKxM9qkCYDkxe8jQXe3Z
	clgQwSsk+zZcT3DEduawZi07Py9Wp1iA7u4HSfPq/dMCrny8SIuOvJKfQI2tFA==
Date: Mon, 8 Apr 2024 15:27:15 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson
 <warthog618@gmail.com>, Saravana Kannan <saravanak@google.com>,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 0/2] gpio-cdev: Release IRQ used by gpio-cdev on gpio
 chip removal
Message-ID: <20240408152715.37948577@bootlin.com>
In-Reply-To: <CAMRc=MeqiYZv3ViHRKKUsXTqG5Pc8Ev2jUcN=A4VuX3RU7dDtw@mail.gmail.com>
References: <20240227113426.253232-1-herve.codina@bootlin.com>
	<CAMRc=MeSMTnPUYGyJir4fc=6=Gnw_MVP9wfEKMQ6Ck33FYCrRA@mail.gmail.com>
	<CACRpkdZbGUd-u3ZcmmK1POSEq8z9J1aDhbGPAbcR6guKuEpEFQ@mail.gmail.com>
	<CAMRc=MeqiYZv3ViHRKKUsXTqG5Pc8Ev2jUcN=A4VuX3RU7dDtw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Bartosz,

On Fri, 1 Mar 2024 08:21:09 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

..
> 
> I DO want to fix it, don't get me wrong. I don't want to just leave it
> like this, especially since we've made so much progress with
> hotpluggability recently. I just don't believe this is the right fix,
> I will try to come up with a solution that addresses the issue
> globally.
> 

I didn't see anything but I could miss something.
Did you move forward on this topic ?

Best regards,
Hervé


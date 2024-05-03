Return-Path: <linux-kernel+bounces-168407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 961738BB83C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8CD41C2380B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E65084D24;
	Fri,  3 May 2024 23:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jVAD6IxZ"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB45283CCA;
	Fri,  3 May 2024 23:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714778814; cv=none; b=JKyPCOW4GDhhLN6bn1CsbXd2qYDpL7vftwMj99kx0kJFVcH3Bs3bjNoFJVsWqA6kuvWQJpQmv+vpcSIR324kxEICCI9DZbezoC+u+aSFLiBnO5LYhLV3dgwtDOM7MEKlMziuZhByj5m6qntAO2w2Jo/TwAJqoAdAQLtF0dWa014=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714778814; c=relaxed/simple;
	bh=DtSz6oXpCD9XJHdXPqlOjmNGsLAe4fdZHUy5O8ZxcWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvJyKF3T6ilcr4wFa+XhViB7aU8UGFUjRO/atzFRIiXeffDBGX4sJhLgQEG37u2RPPKrox8JK52re6eX5YOdH5a9r9iTPYBu8VuS9Gax/7o+qkb/pz71xpRzaTJW8atHVGX69LkACgLqfJ9Us8hsal+ndaol+nuN1fAQ9cVNGyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jVAD6IxZ; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4VWRlQ3FdKz9sd1;
	Sat,  4 May 2024 01:26:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1714778802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UfM+VCsFRWtZjY0B0g6Ouv8v2sljQiEdfPUlD4nTLDY=;
	b=jVAD6IxZlLv4j/0tQ/9pj/MfZ4sdVUAlWNcy9zZcoBS4giUe0dviIRMw3TXXeLrTuRWyYL
	X/RwFOy7dqGTV8lIcGFxbLVQhuABqCZYvcaqdzeTGeCxsyYI+CCWfSjlG+Fv+Sh4Gx+f6f
	FmD0t/+Gmw8c0/TN6SVmUABN9oR8VD6aT8LTTr9lnorbLSwHBCOzfQzTmdX6EK/5GlJAK7
	Euvdm4GB3rnXAAYYnCcYIOcU/Gl44xJUuAWTdX36nKcZJT+A+ujoJoI9KlwepYdJVZ/WcS
	l8dvl5zP37/TfNfTnJb7dmiapGX6QFxm3LKqe/WM97o+jh/5xw67qnG0txV5Zg==
Date: Fri, 3 May 2024 18:26:36 -0500
From: Joseph Strauss <jstrauss@mailbox.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] Add multicolor support to BlinkM LED driver
Message-ID: <20240503232636.kbygwgo6h2c5evqc@libretux>
References: <20240428162309.32111-1-jstrauss@mailbox.org>
 <20240503085724.GL1227636@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240503085724.GL1227636@google.com>
X-MBO-RS-META: 8b4q1ry5wmhfeq83dd7t5yoo1i38fe3x
X-MBO-RS-ID: 1856478396176a39a9c

On 24/05/03 09:57AM, Lee Jones wrote:
> On Sun, 28 Apr 2024, Joseph Strauss wrote:
> 
> > Add multicolor support to the BlinkM driver, making it easier to control
> > from userspace. The BlinkM LED is a programmable RGB LED. The driver
> > currently supports only the regular LED sysfs class, resulting in the
> > creation of three distinct classes, one for red, green, and blue. The
> > user then has to input three values into the three seperate brightness
> > files within those classes. The multicolor LED framework makes the
> > device easier to control with the multi_intensity file: the user can
> > input three values at once to form a color, while still controlling the
> > lightness with the brightness file.
> > 
> > The main struct blinkm_led has changed slightly. The struct led_classdev
> > for the regular sysfs classes remain. The blinkm_probe function checks
> > CONFIG_LEDS_BLINKM_MULTICOLOR to decide whether to load the seperate
> > sysfs classes or the single multicolor one, but never both. The
> > blinkm_set_mc_brightness() function had to be added to calculate the
> > three color components and then set the fields of the blinkm_data
> > structure accordingly.
> > 
> > Signed-off-by: Joseph Strauss <jstrauss@mailbox.org>
> > ---
> > Changes in v2:
> > - Replaced instances of the constant 3 with NUM_LEDS, where applicable
> > - Fixed formatting errors
> > - Replaced loop inside of blinkm_set_mc_brightness() with equivalent
> >   statements
> > - Changed id of multicolor class from 4 to 3
> > - Replaced call to devm_kmalloc_array() with devm_kcalloc()
> > Changes in v3:
> > - Add CONFIG_LEDS_BLINKM_MULTICOLOR to check whether to use multicolor
> >   funcitonality
> > - Extend well-known-leds.txt to include standard names for RGB and indicator
> >   LEDS
> > - Change name of Blinkm sysfs class according to well-known-leds.txt
> > - Simplify struct blinkm_led and struct blinkm_data
> > - Remove magic numbers
> > - Fix formatting errors
> > - Remove unrelated changes
> > Changes in v4:
> > - Fix indentation
> > - Add default case to switch statement
> > Changes in v5:
> > - Fix warnings related to snprintf on s390 architecture, reported by
> >   0-DAY CI Kernel Test Service
> > Changes in v6:
> > - Refactored struct blinkm_led to use a union
> > - Refactored blinkm_probe()
> > - Clarified documentation
> > 
> >  Documentation/leds/leds-blinkm.rst     |  31 +++-
> >  Documentation/leds/well-known-leds.txt |   8 +
> >  drivers/leds/Kconfig                   |   8 +
> >  drivers/leds/leds-blinkm.c             | 223 +++++++++++++++++--------
> >  4 files changed, 198 insertions(+), 72 deletions(-)
> 
> Just tried to apply this, but checkpatch.pl has some complaints.
> 
> Please fix them and resubmit, thanks.
> 
> -- 
> Lee Jones [李琼斯]
I fixed the errors and warnings that resulted from my patch, but am I correct in assuming I am not responsible for fixing the warnings from other parts of the file? It would make the patch messier is my concern.


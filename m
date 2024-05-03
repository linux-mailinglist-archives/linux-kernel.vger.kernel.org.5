Return-Path: <linux-kernel+bounces-167313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 265BF8BA7AB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56AE28520E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3054146D45;
	Fri,  3 May 2024 07:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DV/8co1T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1284D139CE9;
	Fri,  3 May 2024 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714720936; cv=none; b=RWm9WGOacoZ0XNVpHTsjJkHlYbMeJ2NZ3xa2BOLgi93D5NSfE8/fciHo7f+4H/5jW7xmx8VQ8zq0XT7mw4JPlJ2DMwbtDat6ihsKIX+BlOPgRyiPFoUGNyRwisYxjr5+owREU3dnByfvqhJWX0P5fgIoxlVOsCj07mYS1KHXp0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714720936; c=relaxed/simple;
	bh=mZNPNHX5QiwkCs1px6XTXA4O8VZL26IIA1+vNZMfaKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsi3IkGLkHe2Nk6y8yhlObZ8c1GtgvB5A77isX1tiA1dsu/3e8iMlHwo5oX4RfVH4Vcbp3o+h413atJ4YBlmXE/nWg+m9mlWxo8a9pGbb3lPuSLkZ9X/UuaeO45vZ1R2jRtewyvtggKR2KMU4tlhk8Mu5L6np6JZH8l1ZtHk80c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DV/8co1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F5FC116B1;
	Fri,  3 May 2024 07:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714720935;
	bh=mZNPNHX5QiwkCs1px6XTXA4O8VZL26IIA1+vNZMfaKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DV/8co1TuP/SJrKaa0GQ+YPhnyBWPIogJCCdGUTxRgLO6QHJFRt1woa2XR8ZwCMkg
	 itvc0Ba0lxHjrfRC0sfinStBVhf5B+zBJA1kfftHqlsKUdVrBjjQKjkXhPmjsmodl9
	 t0KhF2aVOB5WUtUIkcLEC3TiDOss4uWEZAQ2Js5WtCqWBflTHV8jcjTjQtr5rF1QFS
	 DB0W5E2wgBDuhq+jiKMFBbdMyuY9yfaVsP/tIZkKF4opFmerXRdyfh5qX0I6YltFsf
	 POq7K3Z4Nl/R3sVyYRhGeUGGo/ju68pylf/cBVKCTgbQ9/uOJ9HgYAW46HCMrb8E0v
	 iUwXndyRg7lsg==
Date: Fri, 3 May 2024 08:22:10 +0100
From: Lee Jones <lee@kernel.org>
To: Aryabhatta Dey <aryabhattadey35@gmail.com>
Cc: linux-leds@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, pavel@ucw.cz, corbet@lwn.net,
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH] Fix typo
Message-ID: <20240503072210.GF1227636@google.com>
References: <y5bqy3p7deaemny5sczd33zy2dwtbqvucgrq6wxqs7ibf4omwb@kpd2gwfve2ax>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <y5bqy3p7deaemny5sczd33zy2dwtbqvucgrq6wxqs7ibf4omwb@kpd2gwfve2ax>

Intentional top-post referencing the subject line:

Please provide a subject that is befitting of the project/subsystem.

`git log --oneline -- <file>` is your friend.

On Fri, 03 May 2024, Aryabhatta Dey wrote:

> Change 'dasy-chain' to 'daisy-chain'.
> 
> Signed-off-by: Aryabhatta Dey <aryabhattadey35@gmail.com>
> ---
>  Documentation/leds/leds-blinkm.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/leds/leds-blinkm.rst b/Documentation/leds/leds-blinkm.rst
> index c74b5bc877b1..2d3c226a371a 100644
> --- a/Documentation/leds/leds-blinkm.rst
> +++ b/Documentation/leds/leds-blinkm.rst
> @@ -7,7 +7,7 @@ The leds-blinkm driver supports the devices of the BlinkM family.
>  They are RGB-LED modules driven by a (AT)tiny microcontroller and
>  communicate through I2C. The default address of these modules is
>  0x09 but this can be changed through a command. By this you could
> -dasy-chain up to 127 BlinkMs on an I2C bus.
> +daisy-chain up to 127 BlinkMs on an I2C bus.
>  
>  The device accepts RGB and HSB color values through separate commands.
>  Also you can store blinking sequences as "scripts" in
> -- 
> 2.44.0
> 

-- 
Lee Jones [李琼斯]


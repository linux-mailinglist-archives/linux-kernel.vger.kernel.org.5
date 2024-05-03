Return-Path: <linux-kernel+bounces-167417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB688BA946
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEAA2283DEC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE861DFF4;
	Fri,  3 May 2024 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBLKzhA1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E3814A4CF;
	Fri,  3 May 2024 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714726649; cv=none; b=XenjzXbF7mPTVyzwo+G+wvfInzj4me0uOLISFgOi9sObgnOpOzErPnNobIvVgcZmCceNW9yftTGxTau97l9J1mcGxXdFn/pOyi4Pf6Sf/upcgOr211pwFU5r+t7cII6M8Gzp2ybFSw4/+/yMAujHj/nfTDls1Q8kZs+28eMQ1CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714726649; c=relaxed/simple;
	bh=KE6X4NcAEAtk/zIP2DW5zLvfDm3IsfaWXALiu1nHQzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2kdJ4ZKYIYw5vfb0JBzA4LOpky8+1GqPXfnfRJV1FvPuU4+aVsoSUGoy/IoEap13fNCuIR6KI1qeaPlJF2iS4eWtgBRr/IH1GzycBFUzGa6DFRo6wtOhx5LTI+6/7gy6jHswkyriVSsltWXNUdEU1hlWm9VeRPzt6JrEUK0Cso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBLKzhA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8ED7C116B1;
	Fri,  3 May 2024 08:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714726648;
	bh=KE6X4NcAEAtk/zIP2DW5zLvfDm3IsfaWXALiu1nHQzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cBLKzhA1CZXI4lSjI3drrzCfz95YrGhIh4of5HUKu5jQG9OxR9L8QhUU/YgrAk+3/
	 bPV9a3U+ORqrPcflc03HEU+Kq7CXXZQIYd49UNZ9T4Qdh7FHcj5WIjztdIm/v5ah6R
	 pQLE4RoGLXos4V9YiIWBUvIy8LYGQ4h8gr87NirZ6XZnnL249jod+YbdbXIK6nwIcq
	 J+IJ8O46xj+AKkdEfe2tMcxd3wcEyONRAbHM0pkC6xoFvzNBfmItjWoyYnAkrzF8H6
	 PvUdsznz9sCW0kELf46EwV1noCENPXCmOfGJ8pIpPkKACQ7cngr2AywdBibqJDb94v
	 jBnSu7DRfuigA==
Date: Fri, 3 May 2024 09:57:24 +0100
From: Lee Jones <lee@kernel.org>
To: Joseph Strauss <jstrauss@mailbox.org>
Cc: pavel@ucw.cz, jansimon.moeller@gmx.de, conor@kernel.org,
	christophe.jaillet@wanadoo.fr, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] Add multicolor support to BlinkM LED driver
Message-ID: <20240503085724.GL1227636@google.com>
References: <20240428162309.32111-1-jstrauss@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240428162309.32111-1-jstrauss@mailbox.org>

On Sun, 28 Apr 2024, Joseph Strauss wrote:

> Add multicolor support to the BlinkM driver, making it easier to control
> from userspace. The BlinkM LED is a programmable RGB LED. The driver
> currently supports only the regular LED sysfs class, resulting in the
> creation of three distinct classes, one for red, green, and blue. The
> user then has to input three values into the three seperate brightness
> files within those classes. The multicolor LED framework makes the
> device easier to control with the multi_intensity file: the user can
> input three values at once to form a color, while still controlling the
> lightness with the brightness file.
> 
> The main struct blinkm_led has changed slightly. The struct led_classdev
> for the regular sysfs classes remain. The blinkm_probe function checks
> CONFIG_LEDS_BLINKM_MULTICOLOR to decide whether to load the seperate
> sysfs classes or the single multicolor one, but never both. The
> blinkm_set_mc_brightness() function had to be added to calculate the
> three color components and then set the fields of the blinkm_data
> structure accordingly.
> 
> Signed-off-by: Joseph Strauss <jstrauss@mailbox.org>
> ---
> Changes in v2:
> - Replaced instances of the constant 3 with NUM_LEDS, where applicable
> - Fixed formatting errors
> - Replaced loop inside of blinkm_set_mc_brightness() with equivalent
>   statements
> - Changed id of multicolor class from 4 to 3
> - Replaced call to devm_kmalloc_array() with devm_kcalloc()
> Changes in v3:
> - Add CONFIG_LEDS_BLINKM_MULTICOLOR to check whether to use multicolor
>   funcitonality
> - Extend well-known-leds.txt to include standard names for RGB and indicator
>   LEDS
> - Change name of Blinkm sysfs class according to well-known-leds.txt
> - Simplify struct blinkm_led and struct blinkm_data
> - Remove magic numbers
> - Fix formatting errors
> - Remove unrelated changes
> Changes in v4:
> - Fix indentation
> - Add default case to switch statement
> Changes in v5:
> - Fix warnings related to snprintf on s390 architecture, reported by
>   0-DAY CI Kernel Test Service
> Changes in v6:
> - Refactored struct blinkm_led to use a union
> - Refactored blinkm_probe()
> - Clarified documentation
> 
>  Documentation/leds/leds-blinkm.rst     |  31 +++-
>  Documentation/leds/well-known-leds.txt |   8 +
>  drivers/leds/Kconfig                   |   8 +
>  drivers/leds/leds-blinkm.c             | 223 +++++++++++++++++--------
>  4 files changed, 198 insertions(+), 72 deletions(-)

Just tried to apply this, but checkpatch.pl has some complaints.

Please fix them and resubmit, thanks.

-- 
Lee Jones [李琼斯]


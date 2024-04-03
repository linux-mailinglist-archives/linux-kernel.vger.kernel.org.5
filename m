Return-Path: <linux-kernel+bounces-129712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB38896ECF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED96928D739
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43954141987;
	Wed,  3 Apr 2024 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWhRTlSH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E00145FF9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 12:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712146997; cv=none; b=HM8IBHo7A6/jj8H8qSHyNhNSQY7L5eqkVp/RnBC3pCUoH3PCmcAPGMBbsdZeJP9ay5uM3c+r26to6JnX+XlB3f1XPToTURue88mHEStl69DuEIe3EvBp4wx3iliSHY2/bI+XdRmNPOILUh7r7qdSmFRiupXgDzAC0uk7RuQpiE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712146997; c=relaxed/simple;
	bh=MIBbxOn+8wtDhVhKo8H9p51yl6Qib+md2knu8G7a1yw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qDabw6aU3hfZUy7ySdjdZJ54ZGzBZ5iy/ff71/E4I+o9oDCD6c0Wwm2+MebVl23GUx/cgA8R5fe/HctT65b1wPuArkYGP0YyTrZSsMW9I0WMhoXzL8c6YyGs1gIZVOSxOeQbf66C6QJfC6P7LBc1mKLowx57/NdLuux5y7VEwR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWhRTlSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD0AC433F1;
	Wed,  3 Apr 2024 12:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712146997;
	bh=MIBbxOn+8wtDhVhKo8H9p51yl6Qib+md2knu8G7a1yw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=BWhRTlSHBbW1iXoNz9Fubsi3oo6kAonCWKtLgAlyVkRXFoq6Ap5SFOWpWPdmftrxx
	 rdtUC2hej4y2ESIY/L3QzBWwvEl8AXPPhAIwwQlejcS2iPNGJ38Zm2WoaoyeV9WBX8
	 6iV4vNBABUgg4s8g8B230WE6x/XkiybhjtIRH6VajKjUIPMnD75DWdY1pWVv8zSpa0
	 SfK4VFVAQOWIVCE0OY9VQfRvAgo4D08GzwvRZn9tzrTiMp9ogQlKdPL3CLvS8Ezp5k
	 rq8FnWS3wC7XYPwJow3JOoS6N7qqntd7MTMmPvsKKYepvDFn1MRQzuxQjfKRYVJUJU
	 JvTz4tIZ428Gg==
Date: Wed, 3 Apr 2024 14:23:14 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 12/34] apm-emulation: hide an unused variable
In-Reply-To: <20240403080702.3509288-13-arnd@kernel.org>
Message-ID: <nycvar.YFH.7.76.2404031420450.20263@cbobk.fhfr.pm>
References: <20240403080702.3509288-1-arnd@kernel.org> <20240403080702.3509288-13-arnd@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 3 Apr 2024, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The driver_version variable is only used inside of an #ifdef block, which
> leads to a W=1 warning:
> 
> drivers/char/apm-emulation.c:144:19: error: 'driver_version' defined but not used [-Werror=unused-const-variable=]
> 
> Move this into the function using it.
> 
> Fixes: 7726942fb15e ("[APM] Add shared version of APM emulation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/char/apm-emulation.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/apm-emulation.c b/drivers/char/apm-emulation.c
> index e795390b070f..53ce352f7197 100644
> --- a/drivers/char/apm-emulation.c
> +++ b/drivers/char/apm-emulation.c
> @@ -141,9 +141,6 @@ static struct apm_queue kapmd_queue;
>  
>  static DEFINE_MUTEX(state_lock);
>  
> -static const char driver_version[] = "1.13";	/* no spaces */
> -
> -
>  
>  /*
>   * Compatibility cruft until the IPAQ people move over to the new
> @@ -435,6 +432,8 @@ static struct miscdevice apm_device = {
>   */
>  static int proc_apm_show(struct seq_file *m, void *v)
>  {
> +	static const char driver_version[] = "1.13";	/* no spaces */
> +
>  	struct apm_power_info info;
>  	char *units;

Heh, I really should mark this driver as Orphaned. Anyway, for this 
particular patch:

	Acked-by: Jiri Kosina <jkosina@suse.com>

-- 
Jiri Kosina
SUSE Labs



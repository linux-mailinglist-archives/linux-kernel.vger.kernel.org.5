Return-Path: <linux-kernel+bounces-56275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE07484C838
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16AE1C243A7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4293C24208;
	Wed,  7 Feb 2024 10:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f8jUNJwC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7776E24B41;
	Wed,  7 Feb 2024 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707300177; cv=none; b=eW+3jPNpuqBsZ63mTf5D8ybMP1u47J3m4DDCiZXzN9tblAzpCMCg8GDmRM/5iyVn6FUJPyS1/YGZls5y7w9alqn3ePcqDYwrejoDNwhw9CBk1yY8sO1HyJElQQ+2J2XSXud/iAKg2oIMWJaBTXpARo+UxoZwZDmWt2UtusQ2KxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707300177; c=relaxed/simple;
	bh=xm7xuHD7FhQxqr7dC2MoC3iL32A8DBYzQX6XTWNEL9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiwyqoBB14oy0shGr0MnlrbSc8NEU2iZ0iiNcabUyAmwwUDzqzs/sODRgjvZKWy0kVYjJ7N8Vn24T2a7DI1IiVWdtM/vikJsv9kr9mxsRBFptxqmHrGXLf0/LJeFFWPZCtk0GGfPqTkfaLNeD1lcpE91AHq4FtQma7fwGnBez7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f8jUNJwC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F51CC433C7;
	Wed,  7 Feb 2024 10:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707300177;
	bh=xm7xuHD7FhQxqr7dC2MoC3iL32A8DBYzQX6XTWNEL9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f8jUNJwC1R+El/P1zoYEmOeoEiJ2b9Eqf/BEaT4yq3EVbwEue0Q9kDh77V77kFcDt
	 g4V5NW1/h1PlYEviLtlfd3uNSJGvs5IEPU5rmXx2dIiRr58pb7DJR/kkFcW1UlC566
	 DZBMOHOEzj9ivmOyuG3ZVSX9An3fETIYiVrgGoho=
Date: Wed, 7 Feb 2024 10:02:54 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Gergo Koteles <soyer@irl.hu>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: tas2781: remove unused acpi_subysystem_id
Message-ID: <2024020745-freight-slush-9ae7@gregkh>
References: <df5c94396256e9573b772962182def52d20c50d4.1707250969.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df5c94396256e9573b772962182def52d20c50d4.1707250969.git.soyer@irl.hu>

On Tue, Feb 06, 2024 at 09:25:50PM +0100, Gergo Koteles wrote:
> The acpi_subysystem_id is only written and freed, not read, so
> unnecessary.
> 
> Fixes: ef3bcde75d06 ("ASoC: tas2781: Add tas2781 driver")

What does this really "fix"?  It's just a cleanup.

> CC: stable@vger.kernel.org

Again, what bug is this fixing?

Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
about what should be tagged for stable kernels, which this patch series
does not seem to fix.

thanks,

greg k-h


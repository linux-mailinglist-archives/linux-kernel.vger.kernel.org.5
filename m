Return-Path: <linux-kernel+bounces-38689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DAF83C423
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C051F22D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307A35EE89;
	Thu, 25 Jan 2024 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfjWcYA8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757685DF32;
	Thu, 25 Jan 2024 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706190914; cv=none; b=gmJISzBoJ28TZ3KkzLCvU9doOkXukeMoltWziv/bCZC3gTsCh+8XzrpvJsKbhr1sFl63StukKwoCKStjCQKeWaae4Hjs/wY7nF/tocBq3x3IQtxxdiTvEojbPmAaFKSBpM46/wHgzcv7Wpwfw+PRE6QfyHWyZhe2js8RuGmQSPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706190914; c=relaxed/simple;
	bh=lkORbup5ysi9TnIdkS3Dfkmedc2lWrIbmKoC0k/1xYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pn/acY52nby70Aly7FmiN7ly1lqljn0GfoC/C6vkAlLxvDaBGsaVQaizBOTPyF7kHYK2YIVwyljLrGKYFerd6XxlSZOC9mDs7IWiixJDGYW/8Yad6yfvMIjqnN+FKkSpXzbVkd3fBG1NRbqqDteh2fasUPPqs4/39WULc7o7bOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfjWcYA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87427C433C7;
	Thu, 25 Jan 2024 13:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706190914;
	bh=lkORbup5ysi9TnIdkS3Dfkmedc2lWrIbmKoC0k/1xYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FfjWcYA8x/ZdkCXMwxd9nfscis8ARlLJ9TXMASZTXr8RcCXgG0/JkPvIoeUNOfUCU
	 gvR/wgSj8qNociAQjVr7M74V/dXIap9wRYKi0AwpcXarzO9mm+aWkEtT5vjVjI53gS
	 ZysyxHwg8svzJZ8CIRV6NKaYHdhb6t8Lx5sAs+MaBaTp1wF4kL9vK/Ia8lRqz7VSX1
	 R8BnnjaZ7OmzhvvgC4Tq7MT6kPlYa+l8v16IMxrPs4FnygK81wyVTUECURjPiNd79w
	 2ltTBtj3SDoRLEri5ovtpQOdK55yXm5IzL2OVEVjxek/z1ENEHb0xQDtsKlEZSG0Ao
	 A9i/zOo3TQnBg==
Date: Thu, 25 Jan 2024 13:55:09 +0000
From: Lee Jones <lee@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, andy.shevchenko@gmail.com,
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 2/6] mfd: cs42l43: Tidy up header includes
Message-ID: <20240125135509.GL74950@google.com>
References: <20240125102555.2621736-1-ckeepax@opensource.cirrus.com>
 <20240125102555.2621736-2-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240125102555.2621736-2-ckeepax@opensource.cirrus.com>

On Thu, 25 Jan 2024, Charles Keepax wrote:

> Use more forward declarations, move header guards to cover other
> includes, and rely less on including headers through other headers.
> 
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Patches look okay to me, but seeing as Andy suggested the changes, it
would be good to get a R-by from him.

> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> Changes since v2:
>  - Added pm.h and regmap.h back into mfd/cs42l43.h
> 
> Thanks,
> Charles
> 
>  drivers/mfd/cs42l43-i2c.c   |  6 +++++-
>  drivers/mfd/cs42l43-sdw.c   |  6 +++++-
>  drivers/mfd/cs42l43.c       |  8 +++++++-
>  drivers/mfd/cs42l43.h       | 10 ++++++----
>  include/linux/mfd/cs42l43.h | 13 +++++++------
>  5 files changed, 30 insertions(+), 13 deletions(-)

-- 
Lee Jones [李琼斯]


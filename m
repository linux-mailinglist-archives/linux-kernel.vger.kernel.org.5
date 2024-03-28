Return-Path: <linux-kernel+bounces-122842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B17188FE40
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C837C29703B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C087D411;
	Thu, 28 Mar 2024 11:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mwwfk5BR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5721D2D792;
	Thu, 28 Mar 2024 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711626096; cv=none; b=Ro1a2j3n8NFo82m3L6dvGyYAKw44M2QPRT8raOhtHyD8UMSW/oA4502M1+Bh0CQXjvQfFwXnYp1OtVMKECL6eCxZvR4tqlM6Z+2M9a7waHZm7O5OeKos0fdvbeCbckSbxF+ZoemLnxpjCjUHkZwJpODL3/FckT+SBzh3UyD0bRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711626096; c=relaxed/simple;
	bh=TY9UdTz3r/g/8VoI8unboOjtiBgPLji8N1MUYjw9Drc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtSFJUSrK8J/MgelzSfjU17E/PzNaQNseEaOm0soyVNUjUlG4oqx5mZL0jRgyPRUTleJoz7owfkbuHn/ltf6+iT9zZlNymdP5W4KLSmeAZCIjpBYthiWyrDPJIFYv9u0xSfxtmI96Keh9WhasgUNK0H0RJ+YRfEnGIvWxN+Ofos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mwwfk5BR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B79C433F1;
	Thu, 28 Mar 2024 11:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711626096;
	bh=TY9UdTz3r/g/8VoI8unboOjtiBgPLji8N1MUYjw9Drc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mwwfk5BRZF/2X+CIdxwFIXcyxaxEIIU3PRZH/lFenk/+rSm7CyDbxXjfT7gVPA8kB
	 yLvTrVO3+wK9AHJhJxaJmEfVDR7f/rY2qZjN9Vcmxhw0Y6Zj1tLbggrbMxSpA+NUnN
	 GBb5M7aGp+jX0cwUzVXZsC2Kb2v2xlgen2neBv0T9pVq7o0ppVj3D8V7EkTecFy9Nf
	 t6MrZr/HJwS2mIX6S9ke+zfeUpqxdiASAo37YQCbAYHgXCUAnMlKxEqRh4q2Z9c9CL
	 XlC5OkOMeu8o4hPzU4AUHP7qBAFZduH8XH17KYKxiBoLFQLZH40SF5MWoyJ7BpDmJZ
	 dTNrwGp5eIGsQ==
Date: Thu, 28 Mar 2024 11:41:31 +0000
From: Lee Jones <lee@kernel.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] video: backlight: constify struct class usage
Message-ID: <20240328114131.GB13211@google.com>
References: <20240305-class_cleanup-backlight-v1-0-c0e15cc25be1@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240305-class_cleanup-backlight-v1-0-c0e15cc25be1@marliere.net>

On Tue, 05 Mar 2024, Ricardo B. Marliere wrote:

> This is a simple and straight forward cleanup series that aims to make the
> class structures in backlight constant. This has been possible since 2023
> [1].
> 
> [1]: https://lore.kernel.org/all/2023040248-customary-release-4aec@gregkh/
> 
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
> Ricardo B. Marliere (2):
>       video: backlight: make backlight_class constant
>       video: backlight: lcd: make lcd_class constant
> 
>  drivers/video/backlight/backlight.c | 29 ++++++++++++++++-------------
>  drivers/video/backlight/lcd.c       | 23 +++++++++++++----------
>  2 files changed, 29 insertions(+), 23 deletions(-)

No longer apply.

Please rebase on top of v6.9-rc1 or for-backlight-next.

-- 
Lee Jones [李琼斯]


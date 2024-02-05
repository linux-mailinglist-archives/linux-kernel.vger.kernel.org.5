Return-Path: <linux-kernel+bounces-53347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1448B84A382
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC4E1F2204B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A957674E37;
	Mon,  5 Feb 2024 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KxZ1K2V5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57CF7319A
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159799; cv=none; b=r8wr5Hvmd3EzL1kLs9CC9iZ+MBWZSWx8mLHYqzJmnMtba/WOGDfYyP0EDZKTjHX20+PYqhYEeRYd8UKp6LIltZCL4sLevT59s1EQpxzgVU0N0FMy6HojkWrBq/IInYJY/MlANvASZQI0RdTbkwaaPZj2no/Dw7Bh75QM9vSD+Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159799; c=relaxed/simple;
	bh=ES8p9LauLrAHUMV4ASKY0YXyfJqfS78JihNa/CG3BrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSGEbqwbYq7C1L/b7FQYQMLcAp2r/APUJx6BiTl6XazBzH6R0hg/Wdp5fSBhNxCYvoDxqLaYUhzPBbGfKGZ56WdyUos0wJoPBkThuDXtbAX6aCimrckLqWwQXMCP7zcTpttJzJfehTDU0OqWrsa1HgPWt2bW05J2HAES+HsYuG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KxZ1K2V5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0B3C433C7;
	Mon,  5 Feb 2024 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159799;
	bh=ES8p9LauLrAHUMV4ASKY0YXyfJqfS78JihNa/CG3BrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KxZ1K2V586N0JhxQp4dXN/6fsL6oFgxNnvkrXA/DQk3Uc/IMNajislxZVxJwqC7AY
	 5j/vthmKqHR67djKEwsrd2PDRAcWfqTZddOYpVGjOHFDE3XEVTDnmnkkYi9IgTfSTg
	 p5aNwjIp24CBRYxnf/VmuBzuxwMV7P5zxXSTF6nA=
Date: Mon, 5 Feb 2024 04:45:41 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] const_structs.checkpatch: add bus_type
Message-ID: <2024020554-brilliant-slug-1d12@gregkh>
References: <20240204-bus_cleanup-checkpatch-v1-1-8d51dcecda20@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240204-bus_cleanup-checkpatch-v1-1-8d51dcecda20@marliere.net>

On Sun, Feb 04, 2024 at 07:39:57PM -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct bus_type
> a const *"), the driver core can properly handle constant struct
> bus_type. Make sure that new usages of the struct already enter the tree
> as const.
> 
> Suggested-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Note, there are a handful of in-kernel instances where this will not
work, but it's not worth special-casing them, they will be obvious when
attempts to change them happen.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


Return-Path: <linux-kernel+bounces-30745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8AD8323DA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 04:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22A31C22700
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB5A1FD8;
	Fri, 19 Jan 2024 03:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/odK3UZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFE217F5;
	Fri, 19 Jan 2024 03:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705635714; cv=none; b=IevBV759+3gMMJkeT9SGBd6hM0zWEeG3bXnppkJ3n0uJFq+UsnrnHwFJA1qFQmWgkSyR6402C/Af8Gp47n3WPjSEyHIZ9xN+mWOnrpz7fSsItEHp+EG1KLy5S4G4bVCqb61a+gDXGg0h7/yitLUMYVo6f8Ya+quJLE2CtHno52k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705635714; c=relaxed/simple;
	bh=mE+18RpMxNDEldgrD0ZJ5krlhYOEQVs6xBkuGihScaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TILmOqgN0H/htfL8cQv2c1A+YaQ3O5850uwsFsjPhDrgq85fO3IlWijmjDM4mSe9LgoHWJ2BilJyLN4J6B7imlrSlVHeT6V1XfxLCevL4hdgVNjpyECpFckU//OPSbKhmnN65+zHfOKBqt8253g7x7MmZdRGw/8RaKZ16TV6k2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/odK3UZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91A7C433F1;
	Fri, 19 Jan 2024 03:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705635713;
	bh=mE+18RpMxNDEldgrD0ZJ5krlhYOEQVs6xBkuGihScaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o/odK3UZhAspATqM8LiRbUA7EABwH9DjMp+ceJHh5JQ1JVKYaRnUd1pPU/sSD+C+b
	 ZMmKNEyeuw6/MPDubdth0gVEFrv0fg6nseI2ehENKkQzHZxS967z3NBsJOFssWtgTg
	 wKQzVf6b442uqXHj3DVLPsCNJsNsJxr+Pd97qM5gZaaELPn/AQXFg9Jcprn4g4Zfxj
	 O97TCssQKtpeWZMF97wnomxE97pi6Rd4fttLcxFWVsyjT5i+kEI5BjS8HcbraM9ClZ
	 i3sfIZR0XRrB1R43NHOwuoP6lc9cAEi+lK0Tv6yNdEDiagsrLJ/z2hxFU7LNV/o602
	 NUtpcd1g8JC8w==
Date: Fri, 19 Jan 2024 11:41:49 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Lukasz Majczak <lma@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>,
	Radoslaw Biernacki <biernacki@google.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2 1/3] platform/chrome: Update binary interface for
 EC-based watchdog
Message-ID: <ZanvffnDDoT0j2af@google.com>
References: <20240118195325.2964918-1-lma@chromium.org>
 <20240118195325.2964918-2-lma@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118195325.2964918-2-lma@chromium.org>

On Thu, Jan 18, 2024 at 07:53:22PM +0000, Lukasz Majczak wrote:
> +#define EC_HANG_DETECT_MIN_TIMEOUT 5
> +#define EC_HANG_DETECT_MAX_TIMEOUT 65535

EC_HANG_DETECT_MAX_TIMEOUT isn't in the latest ec_commands.h [1].  Could you
either add EC_HANG_DETECT_MAX_TIMEOUT to ec_commands.h or drop the macro here?

[1] https://crrev.com/5a76e67210b15fcf67d8a6f90439993598949ae4/include/ec_commands.h#4749


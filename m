Return-Path: <linux-kernel+bounces-102249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1522E87AFCB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C551C25810
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDBF7F493;
	Wed, 13 Mar 2024 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBSMeSui"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEBE612DC;
	Wed, 13 Mar 2024 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350192; cv=none; b=WgZ40kBjnRooezSDSvtlHE9257ZoIp1q4jkuxdPaoG54OAF2fCCzF9zr4/znCDhk/kRECGIvSaOOYm2+FnksIxVWqhcr7YhvMJqEIAVTfI9/x51IOmwDVIOr+LoDdv6iZ8beiMHXXfd/W43e/vxx+1yKbvPdxaaMNQJCVpIjIPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350192; c=relaxed/simple;
	bh=KBmGVG0tShTIOfu5Kdwsr3zszT6tpzb6w2J0pA0Nv0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/qvek9zP+cQF16/Cr7oV4sfV00hCBNnrVIZmzBlGgEUa7hjD9mi/Na3SZ6oOlRL41dHCbesT17I/Ueu/79161KwAYcAp1uWkJ4SWGTRUuD7F3Yj26knzm1WsGT9PBzkz3LS9QIJYil1RKexs58RMElrW60QEZnQWdj2B4QIPtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBSMeSui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E4AC433C7;
	Wed, 13 Mar 2024 17:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710350191;
	bh=KBmGVG0tShTIOfu5Kdwsr3zszT6tpzb6w2J0pA0Nv0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eBSMeSuiQlglw1FhL+jFT9AKmI7Ubp2QrXMzGbvo+ajlxcARM0ID+esgAz3OUVIqv
	 knlq4Zf4VdJXAeFrWNNevaR0HLUWTyM2zKStDhkEsHiEZ673PBluNaGPDuT75cYYpZ
	 2x73+u6Lg3CizeYPJ7XEXveHQIxrGcVs0b6zUWYo+wBm5UvRJ+2IGbPfRUko9ZU+Ea
	 T++884U512glJM+BwQKWR1ebxay+tWOdovBslKMj6SYH1cGI6KDfD7sefGuxdF9O5a
	 oGY6Rb/M69JaCMh5JvpXyMkRaXtEbkqb5BmZPt2BJ7jo4JHUxk5XbZnKXL5nvXf0fQ
	 cx12YbFzuz3Wg==
Date: Wed, 13 Mar 2024 13:16:29 -0400
From: Sasha Levin <sashal@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Ansuel Smith <ansuelsmth@gmail.com>
Subject: Re: [PATCH 5.15 72/76] regmap: allow to define reg_update_bits for
 no bus configuration
Message-ID: <ZfHfbYg8HmIRsdBV@sashalap>
References: <20240313164223.615640-1-sashal@kernel.org>
 <20240313164223.615640-73-sashal@kernel.org>
 <6274f1ce-f2e0-414b-b9a9-bf2840fefd90@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6274f1ce-f2e0-414b-b9a9-bf2840fefd90@sirena.org.uk>

On Wed, Mar 13, 2024 at 04:46:04PM +0000, Mark Brown wrote:
>On Wed, Mar 13, 2024 at 12:42:19PM -0400, Sasha Levin wrote:
>> From: Ansuel Smith <ansuelsmth@gmail.com>
>>
>> [ Upstream commit 02d6fdecb9c38de19065f6bed8d5214556fd061d ]
>>
>> Some device requires a special handling for reg_update_bits and can't use
>> the normal regmap read write logic. An example is when locking is
>> handled by the device and rmw operations requires to do atomic operations.
>> Allow to declare a dedicated function in regmap_config for
>> reg_update_bits in no bus configuration.
>
>This is fairly clearly new functionality?

It is, but like the other commit, this new functionality is needed for a
later fix. We indicate this in the commit message by adding a trailer:

	Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
	Link: https://lore.kernel.org/r/20211104150040.1260-1-ansuelsmth@gmail.com
	Signed-off-by: Mark Brown <broonie@kernel.org>
	Stable-dep-of: 3f42b142ea11 ("serial: max310x: fix IO data corruption in batched operations")
	  ^^^^^^^^^
	Signed-off-by: Sasha Levin <sashal@kernel.org>

-- 
Thanks,
Sasha


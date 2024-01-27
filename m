Return-Path: <linux-kernel+bounces-41270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C568383EE43
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 809BB2821B7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C4B2C19A;
	Sat, 27 Jan 2024 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBV4TCzB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9346128E0D;
	Sat, 27 Jan 2024 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706371968; cv=none; b=DVBMEEi/lwyJxpY7O2pzZ/H7o4mG11Xh8EqVW0ELAvZTgOHZFP4MooKhZMDKH9UPNV4PLj2RYsM+RsAvJY4UA/pamERctmL8uCzm+DI7HPpnGHRUzdbFoWmLkFEyJ1ahvyYsco9Wh2Maj3A+qva0dfFdhH4Wg+eg0wauEaBEMUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706371968; c=relaxed/simple;
	bh=TGGiLiKyxxokVpqJv9Sir8jHPnD4golICtXC1nVJGDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FoEj6JvwMg1zZrZdKCcG9Cgv/JidEVw1k2OckBWeNXoJ4JQ8KfET5olaxCHSPBzM6ljQ2iYMjpZ1nJqBnflT13MEXjtFCDssloPvmHo4pI7zj/uAw6AxxjJuWCfrowRUwY9mT9kWwpA++7f+VeeMufWPd30zdgDEfbropqDhyuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBV4TCzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413D2C433F1;
	Sat, 27 Jan 2024 16:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706371968;
	bh=TGGiLiKyxxokVpqJv9Sir8jHPnD4golICtXC1nVJGDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YBV4TCzBJvGdKGLDHi2VeT/9IiZh9EdG5vShj1AWVsLnTiLVq1mENsx6r8acAAkF/
	 GcolhNBv7apVg7WFWK6dNZnK31UezT8YkKl0+tSGTDIKpeIwCmQ8jxpcQ6hk68OO+z
	 eQ0OvEA6E08hSAaHNBWgey5JmsPSRKbLcQn9JkwwC2S2wi/k2KwlzlUMzu8ga1nsP2
	 s/Xz78GvS0srCTxZ4K9RDQs4g5NbHFUDRZEMxTwQklR33PspqCm0Kw6Wa6FGti4IXQ
	 llIYQAded2es95rtnY2xQ6UhhwTvObYSxYjS1Ud+09/x0cSKjJXK/WS6NAT3lEHXqN
	 +/vq0bdWV91Xw==
Date: Sat, 27 Jan 2024 16:12:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 "Crt Mori" <cmo@melexis.com>, Linus Walleij <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>
Subject: Re: [PATCH v8 2/2] iio: frequency: admfm2000: New driver
Message-ID: <20240127161232.5117a108@jic23-huawei>
In-Reply-To: <20240123081059.5746-2-kimseer.paller@analog.com>
References: <20240123081059.5746-1-kimseer.paller@analog.com>
	<20240123081059.5746-2-kimseer.paller@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 16:10:59 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> Dual microwave down converter module with input RF and LO frequency
> ranges from 0.5 to 32 GHz and an output IF frequency range from 0.1 to
> 8 GHz. It consists of a LNA, mixer, IF filter, DSA, and IF amplifier
> for each down conversion path.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
Series applied.

For future reference please always use a cover letter
--cover-letter for git format-patch, most because it gives a place for general
comments (like applied!) and because it gives a nice pretty name in patchwork!

Thanks,

Jonathan


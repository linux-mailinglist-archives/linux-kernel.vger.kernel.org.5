Return-Path: <linux-kernel+bounces-57869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 285C684DE6E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4A89B2F3D8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EACE2E3F2;
	Thu,  8 Feb 2024 10:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OV+JSx1u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9263E1DFE1;
	Thu,  8 Feb 2024 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707388460; cv=none; b=itgcVSTIF9JwbNsJscbIMz3W1EpKxRY6/nxGwB4E2RdRuwpbinN0Xjhnyoq0ewNXqnXSccyhsBB/WVNX/NZ34lqf2qfsefO7HS4WNy6LIOmBdH8UHVVIOJhl7xuz0uDqv2QBJSjyCcWtfEjwBhrMWQxCtyGyX6Rg6wr6AX07Y5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707388460; c=relaxed/simple;
	bh=1QpF1ZrEfgoKQLbS2UZur7gxZmwRrXLWGrUvFrm7s1M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ECn7sO9InznQ2VVzhH7P4Ra8mQvcNXCqnqGX4yfJTBTfvCtlt/irOYXIKGJZIPYvlZRZxrAdirqzvYqVHGjVUG5Z6JLYzGvZvU1hoe9gl/Ostzos9TpdRioTXzHE44y2vw6ftZoxJSxkLuA+oNuITw3AhqCVKvRkHQBtUGhP3LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OV+JSx1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D625C433C7;
	Thu,  8 Feb 2024 10:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707388460;
	bh=1QpF1ZrEfgoKQLbS2UZur7gxZmwRrXLWGrUvFrm7s1M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OV+JSx1uJUlJzp7ocYy49czqFmZAXSnlas7BwM7XLVRe3aOFmoi7p5wsoparNbmBW
	 BcuHVsjUn+2BRZ+AYF7AWzBJd3uG50plXaDj4PrAknuXqBBmmuKrvzYcPMgQfOgMkO
	 wT9LSUV3XzFyMkfvMOFHLvRYEa+4i9MpnOGPDWz+N+u3R5wfoDTIR/m9dMoguOXNl+
	 vqmqT1BPi4ysWTk4WhRjhKeBRkgk6917sT4iAKGbreepefbt5ptyjaBLukXGzaW+Pb
	 mNbUPgWUtE8Cx5F1WRSneagrZiMCQd+9MzKVObiIVGGvxOsTh8PT/mJtjTlzStQgUU
	 9HNQCdGjMtX/g==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Jianhua Lu <lujianhua000@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240129122829.16248-1-lujianhua000@gmail.com>
References: <20240129122829.16248-1-lujianhua000@gmail.com>
Subject: Re: (subset) [PATCH] backlight: ktz8866: Correct the check for
 of_property_read_u32
Message-Id: <170738845824.913767.15145975279890460106.b4-ty@kernel.org>
Date: Thu, 08 Feb 2024 10:34:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Mon, 29 Jan 2024 20:28:29 +0800, Jianhua Lu wrote:
> of_property_read_u32 returns 0 when success, so reverse the
> return value to get the true value.
> 
> 

Applied, thanks!

[1/1] backlight: ktz8866: Correct the check for of_property_read_u32
      commit: 7c0ff4ae24bf4589b5bb460e4b31817c61fa2bef

--
Lee Jones [李琼斯]



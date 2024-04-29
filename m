Return-Path: <linux-kernel+bounces-162422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1878B5AEB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 297341C20E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970F67C089;
	Mon, 29 Apr 2024 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogSygeqS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BBF763FC;
	Mon, 29 Apr 2024 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399614; cv=none; b=jYaa2nCXafI80Dvqfd9X8eUlNJRiyBKJPId+jX7bFPYmk8laAoHJbpA3nJx0qJ9hhOP3EPNtnh/SzzWVIjhpLUuypH2msWqFCQItMbxeU9m/+FfNOUzcYQJR+dEOVi35Jd7td8/r0++1F9zI5pnw41rBKUCHDxVCCf742UHibDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399614; c=relaxed/simple;
	bh=sJO/Lcs+rY37o08NZeFavwRGMkijjGwoIQvZuzab768=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuIK6Jlpwiogb2jZxw/hx0/WH3RJSzOE6nDyItW4XArDz7v/Ji7rCflM9HHCivNR+jmeDfV2E8q9GuWYF/7zn1hgGBJnDn+CByi0CZZ6XB9K1YxCgzLuY49qaeQzj8NFd0q/h3+q4/Ssahh2Qw8ksIh4Q8pjAZPna3BgNaX97YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogSygeqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522CDC113CD;
	Mon, 29 Apr 2024 14:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714399614;
	bh=sJO/Lcs+rY37o08NZeFavwRGMkijjGwoIQvZuzab768=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ogSygeqS3rlcEe3fU4U6rujK5dm0ka5/nrKXwi4j7NozemxPIl4ZTcKZsbzbLuvSC
	 93DPMYeSc8r0kS2G24ODhiLf/3hhV0N7r+wyRUepwjM32X4wOu4ENBMXxWLYwKOceb
	 CQ3izCEz/t6P9KjRM+Nton6IwVGoZyITXRM389xurXSKfnerXxKpaFV5Rl38yTORTp
	 yDzAbPVtKPEsV6mWpKFqGk3Jm3JmTD5XcF4ywySqVbJ1DDBLvxrcJjYcZ+aPEmN8Dd
	 /GpQ+T4WVhQsuA7Nc4nXcUM7Bd0tZX8ORCoGWcAcWjZjSjq13njAc9U70Q/zxykCIx
	 aZ6+NIwx1x2vQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s1Reg-000000004R6-0cMD;
	Mon, 29 Apr 2024 16:06:54 +0200
Date: Mon, 29 Apr 2024 16:06:54 +0200
From: Johan Hovold <johan@kernel.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Doug Anderson <dianders@chromium.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, quic_mohamull@quicinc.com,
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Subject: Re: [PATCH] Bluetooth: qca: generalise device address check
Message-ID: <Zi-pfqUplv6VZ-aC@hovoldconsulting.com>
References: <20240426155801.25277-1-johan+linaro@kernel.org>
 <CAD=FV=V-pG9+5fLonNvydmjS=ziUFUHAyF8T7YTkEHiO405aSA@mail.gmail.com>
 <ZizKmtcUIYAMpvOQ@hovoldconsulting.com>
 <dbba45d2-f955-4d3a-aeab-26b0900d5823@quicinc.com>
 <Zi-ohCWv58d2h5VM@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zi-ohCWv58d2h5VM@hovoldconsulting.com>

On Mon, Apr 29, 2024 at 04:02:44PM +0200, Johan Hovold wrote:

> Please avoid top and remember to trim unnecessary context when replying
> to the mailing lists.

This was supposed to say: Please avoid top-posting and ...

See also:

	https://people.kernel.org/tglx/notes-about-netiquette
	http://daringfireball.net/2007/07/on_top

Johan


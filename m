Return-Path: <linux-kernel+bounces-55114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3006184B7EA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9EF4B22EB2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A2113249B;
	Tue,  6 Feb 2024 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fRBVnbAt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C167D1E884;
	Tue,  6 Feb 2024 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229782; cv=none; b=DBHdjC2xtCuYHyy5PYoSBFw10hEBw45CE1BFF0NVefuRBttebF6iMdsPzwPojOM1qC6Tp6NczwOIgQqLm3PzYbpVkcbT2UpAuiMIPQ/rBRjho+IsVwQ/gVUjo4fI5i5PHvkPmlAY1J7X6/plTk1UjmN3tXYojKF8Fr5epjItwjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229782; c=relaxed/simple;
	bh=c8qRfz32rL2kHB7TSW2aoey+/E8HYJ30tFUJcezons0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+mx3C89Y3KRbwFbsjY64O8nvo2ZGMn3EQibxV1RIOWwEXLhX4iSD/YWpmfXOzmFzplmpM2qEmx0K8aZu8eTst0P5wDu/ZOd7n/F84c/AXDNTdzW3MkYuhUGHk4dXCP1P8dpbfdJUSk48QHHkY+4H3rQxgHfnuZGX1Lot2Boq+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fRBVnbAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9B1C433F1;
	Tue,  6 Feb 2024 14:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707229782;
	bh=c8qRfz32rL2kHB7TSW2aoey+/E8HYJ30tFUJcezons0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fRBVnbAtn9oMBr+MEG4kTB2ZGaiPPooI18dJkBGO/G5qRpmAO/d1AFRkefSi0nLMj
	 Gl5BEYPgdaFr9vopZys5dnO1DL2+moWFLXaZQ0/OCqd2R1GTOZxuDPtkJY00mRG+aR
	 FW4z7vX0MzwnguX5I4fchpDRrxVNGAhtanrAW7TA=
Date: Tue, 6 Feb 2024 14:29:39 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: samsung: Remove superfluous braces in macro
Message-ID: <2024020609-left-trimester-13c8@gregkh>
References: <20240202010507.22638-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202010507.22638-1-semen.protsenko@linaro.org>

On Thu, Feb 01, 2024 at 07:05:07PM -0600, Sam Protsenko wrote:
> Commit 59f37b7370ef ("tty: serial: samsung: Remove USI initialization")
> removes parameters from EXYNOS_COMMON_SERIAL_DRV_DATA() macro, but
> leaves unnecessary empty braces. Remove those to fix the style. No
> functional change.
> 
> Fixes: 59f37b7370ef ("tty: serial: samsung: Remove USI initialization")

"no functional change" don't really deserve a "Fixes:" tag.  I'll go
delete this when applying, thanks.

greg k-h


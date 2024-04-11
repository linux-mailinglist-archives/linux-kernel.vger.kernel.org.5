Return-Path: <linux-kernel+bounces-140163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1DE8A0C3F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA071C22300
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C35D1448F6;
	Thu, 11 Apr 2024 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+qHnPiU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810A8144303
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827532; cv=none; b=LuQAabiIW9DL01laCn+NSLdMW20Uen48n9VShXmBeFeZXL+0P7oLqRPL3AbjymkC8nOYY5eQS5SY3rJtXfPwT7yHUNS0AYLw47svLnCQ6c4AZT4QJK9eC0dJa+JsCmkl0/54HP87zq7EoWBt6gYaOsfsVTkeJJn4cKYXR9z6GHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827532; c=relaxed/simple;
	bh=SOslugwdkwGEvE8YQr4/ByrHjXqQ2ukkqZw8DxWVEzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6mMODKxqhjcuDAO/TT3pDYyp3c92pBbYKfqiHBWkfv6YmpwOVbRQ+r8Cq7TN/1THoMllxflg4wDeCZ8jtfPudGbRLkIRJfQXTNoHwYs/fj4JqV0HtB1a2niF3pRm6h9X1GBDHM3pF2r3+Qsl/8qVNgW7NsqO2cKN3bvAMGWP40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+qHnPiU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE82C433C7;
	Thu, 11 Apr 2024 09:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712827532;
	bh=SOslugwdkwGEvE8YQr4/ByrHjXqQ2ukkqZw8DxWVEzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U+qHnPiUZhMCeNn1q+cp0d0cUE2SQTcnegykEc8hksbZAfxLl/rOFtN2GEqCLBw8a
	 5EWogGpwcTu4PP2mZDVfmMJG6rhnxqk8kwIJE2Hd8iN+eLCukAkKEzfxyBV2LXoBBL
	 D26y46qsu4jLIGq29Psja2ZnLdd6uAhw1PspWD9kVmCrk2HhBXGElKOMuq+F7n/FF+
	 hSBZCfUVqUJbQJgC9IufDU4hUBAoHkXl/hBi3M5mvUa3e+zNCFCkQ6+rJS2h1/n5JP
	 U1e3f23zhpqVQiAzFIpqnA+YgSt1ktqsKy54vc221Y7SW07lZR3T3Cbng+h0s2LqjS
	 pY3T4hK0xVPmA==
Date: Thu, 11 Apr 2024 10:25:28 +0100
From: Lee Jones <lee@kernel.org>
To: Min Li <lnimi@hotmail.com>
Cc: linux-kernel@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH mfd v1 1/2] mfd: rsmu: support I2C SMBus access
Message-ID: <20240411092528.GH6194@google.com>
References: <LV3P220MB12025CBC81EA7F4351966BF8A03D2@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <LV3P220MB12025CBC81EA7F4351966BF8A03D2@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>

On Wed, 03 Apr 2024, Min Li wrote:

> From: Min Li <min.li.xe@renesas.com>
> 
> 8a3400x device implements its own reg_read and reg_write,
> which only supports I2C bus access. This patch adds support
> for SMBus access.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
>  drivers/mfd/rsmu_i2c.c | 107 +++++++++++++++++++++++++++++++++++------
>  drivers/mfd/rsmu_spi.c |   8 +--
>  2 files changed, 97 insertions(+), 18 deletions(-)

Please send this set again as --thread.

`man git format-patch`
`man git send-mail`

-- 
Lee Jones [李琼斯]


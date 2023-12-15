Return-Path: <linux-kernel+bounces-601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ECC81436B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6D31C225A6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF6A12E6E;
	Fri, 15 Dec 2023 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJP4Q6Qo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D3B125C4;
	Fri, 15 Dec 2023 08:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88EA8C433C8;
	Fri, 15 Dec 2023 08:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702628243;
	bh=Szh2cQjdpxKS6gSz+C98N2jF+H6JysxMy+DDeDo3Pm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SJP4Q6Qog2O0bEZ//nO9Y8OfwqZ9Ju9gbSuJRSLS41rCiCjC67Oa+kdAF+JZqf0yv
	 dCYr/WCt3WRctBj5kxFDot+RjjdcRH7HWhgZ5pcSAmQig2ZMwBbGu7p8QIW2PFA88p
	 36Dv+NCaCxZXUp9tP87Iql9vRFXVxIaOL2khS0CrHf/aT5xzsThNps6mT15MG6wVbn
	 yvRbaemQZcGjEGWftuKB/k0MV6t+tZzYpW8SR3IFIjojFCrWklvqWJEEKGuU8raXcm
	 cHf8CxvQMzd3m3ikedEoMB/tiInpsl2jlYhn3haJERP143Vp/41UlH/4BiXW3MoI6I
	 iZh+M/mNiTNzg==
Date: Fri, 15 Dec 2023 16:17:20 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, keescook@chromium.org
Subject: Re: [PATCH][next] platform/chrome: Fix -Warray-bounds warnings
Message-ID: <170262781699.2920569.9996465840798538664.b4-ty@kernel.org>
References: <ZCTrutoN+9TiJM8u@work>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCTrutoN+9TiJM8u@work>

On Wed, 29 Mar 2023 19:54:02 -0600, Gustavo A. R. Silva wrote:
> GCC-13 (and Clang) does not like having a partially allocated object,
> since it cannot reason about it for bounds checking.
> 
> Notice that the compiler is legitimately complaining about accessing
> an object (params, in this case) for which not enough memory was
> allocated.
> 
> [...]

Applied, thanks!

[1/1] platform/chrome: Fix -Warray-bounds warnings
      commit: 59a9ccf19ee03179faf047822bbec76cac7467a4


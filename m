Return-Path: <linux-kernel+bounces-140383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 090BE8A1396
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8227282B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E217A1482E7;
	Thu, 11 Apr 2024 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLXcyciq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3028579FD;
	Thu, 11 Apr 2024 11:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836298; cv=none; b=XQjBxLhMxW31T2CCpFJ1ssKpuQfXYQFwrqY3t53yRN92Hc0vEMDHs68bdhHX5Pn1UIVbgajjoV+6DXNzbFODHNEw33csI6KVmm6Uoq37T4zwxBbQiYqhGcMQGMJONjsjo9ovOAmE99bDUQ2Ce14Yg2ymiRc5k3OWpIOI7i2AU9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836298; c=relaxed/simple;
	bh=EsZKOSvs9m1TkAQbkYLwTZQ5c3grmwIn+tSjtWzAK3Y=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Plbtzir9A+PzdkYMKx7P18/n67Em+FHBidAPeUIbE8JxCE2vs2jYzFo0RNLXl/U3G2ySvENe7fVf3MX6mVHIJM+/F63eG9+EJOjsdf/7ed25pIxKg6uiFQTH0Jx0gLS4rn3HG3jXAnbBGhrsE4bDN7A7UUGu0YK6J0fYXSok2PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLXcyciq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24242C433F1;
	Thu, 11 Apr 2024 11:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712836297;
	bh=EsZKOSvs9m1TkAQbkYLwTZQ5c3grmwIn+tSjtWzAK3Y=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=OLXcyciqaH2hkQpMJGQeduytddtQF2eaWDgVOTASCf5XkrvPzLEhPB7rr/H6b4COa
	 mKV0cLbJSnxSMKHDin0afq8OQ3SUP5NY1dUaLCtu+2lbGIL8oyBJ63Zq1D8OVfC1oJ
	 9rkv6DPXC7cR0cI7+Y4JeD3X4ckKIguTmbIpj4WHK8dRtXQ4kU7JB2dEUl5qmnML1H
	 xqmJksVUCKPcBj2Vh6TvPLvXILfhJ/pzbgAU7HF1CiHi6qtAZcWH5dJKUMnxLU+lTg
	 BWH4gk+R5ZiVHsG7aFzCMkbH6Ys0TGXENQws+SoSNqZRkIZx2hLf3+ojCZ60ohqqMV
	 tI1bgoWIlErVw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 conor+dt@kernel.org, mazziesaccount@gmail.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
In-Reply-To: <20240402111700.494004-1-andreas@kemnade.info>
References: <20240402111700.494004-1-andreas@kemnade.info>
Subject: Re: [PATCH v3 0/2] mfd: rohm-bd71828: Add power off
Message-Id: <171283629588.2324545.13180942003671878099.b4-ty@kernel.org>
Date: Thu, 11 Apr 2024 12:51:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Tue, 02 Apr 2024 13:16:58 +0200, Andreas Kemnade wrote:
> Add power off functionality. Marked as RFC because of magic numbers
> without a good source and strange delays. The only information source is
> a vendor kernel.
> 
> Changes in v3:
> - define for poweroff bit
> - rmw operation to set only that bit
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: mfd: Add ROHM BD71828 system-power-controller property
      commit: 6ed9be0f9a1481280429d24c60b7d20f3706e4dc
[2/2] mfd: rohm-bd71828: Add power off functionality
      commit: d7ff3cc4d9cdc5880541bb2e04b1fa40307029f6

--
Lee Jones [李琼斯]



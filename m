Return-Path: <linux-kernel+bounces-166277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0098B9862
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60542874E0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0806658AA1;
	Thu,  2 May 2024 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUrsD7Gz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493424F88C;
	Thu,  2 May 2024 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714644117; cv=none; b=WITuCgF9porVedvEPFOEjitsqqsX8BGdfvRvR1HvUqYvHlTcpeddnREnOP4UdNMQZY+m8PeLA59r8o6KkeLdXykJ0etzVXgDw1nUD4Fx5Uf+SCnirAIHpb9xpuNP7BNY1HWgqfMGx2AdMdRClmYUj1yN/4YcR6zj68m74gbAuk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714644117; c=relaxed/simple;
	bh=5MizojhZapYDNM1cW8qYSQdLAZLpGpHIYNcukdk2XZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sswoO3Mf0iQqdHTRYFKUkbUufcAlkoGzIF+ezDVdPt1Td8+UaAF08BzY0AvJEgZyVrbvq0ZhI80rGm909+qgtM2WUrprWkaDiYJ1eCGo1pPZMeKv7eCq4AnvlfxUo89RQcBsLn4M+7fySYiu5tWKosbKQFdxdhIbvgYIgjih7Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUrsD7Gz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55CFC113CC;
	Thu,  2 May 2024 10:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714644116;
	bh=5MizojhZapYDNM1cW8qYSQdLAZLpGpHIYNcukdk2XZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nUrsD7Gzg7Qyu4uWYHmseDBExKYVTRp1n7NMo5YAFtalh0+cMrKvuEIHRPQoQadmY
	 aPHnaGt3H9Vslgnnmj43hG/vbD6s0RkI2Rvoag4ahpMm7Gxn8+dL10eaqD3T53HEjz
	 zIop6nbnCsKQa+0p0/5TmxbH6roAR9wHUqgPSodCs2S45hQu1nFj7kyYi7NLGudAob
	 ZiFW/r6lwnZorO8lCrIABixM4QXACvqLPg+YzOPq+ibD5tyTosds9pYyDl/F+R6tfJ
	 feiOMO0A6FqUBAx1d0zD2CK+rmWdULNziws6Df3O5DhNCaEA+8v0knkVo0ou7mYkz8
	 rhg/zHdbz+gDQ==
Date: Thu, 2 May 2024 11:01:51 +0100
From: Lee Jones <lee@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH] dt-bindings: mfd: syscon: Add ti,am62p-cpsw-mac-efuse
 compatible
Message-ID: <20240502100151.GR5338@google.com>
References: <4b1380a8-0136-4395-ba42-9bcff2e1bdb0@kernel.org>
 <aabea385-16e0-4116-a12b-3ce1e06574e3@ti.com>
 <eb7a0d5c-c197-44b9-baea-e9b54792b447@kernel.org>
 <af61424e-7006-49f5-b614-3caa3674685a@ti.com>
 <083e50de-1c99-4a58-8b55-4dec26d97c1b@kernel.org>
 <9bca7d94-142e-4717-aea7-437805717a00@ti.com>
 <a895ddc8-5c18-49d7-86c4-b995bb946914@ti.com>
 <94bae793-ba4f-467f-917d-213fa3cd6faa@ti.com>
 <20489a1e-51d1-42b3-9014-fc1c00b087db@linaro.org>
 <8a64294a-df1e-4331-aca5-0b23b637b9e1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a64294a-df1e-4331-aca5-0b23b637b9e1@ti.com>

On Thu, 25 Apr 2024, Siddharth Vadapalli wrote:

> On Fri, Apr 05, 2024 at 08:55:18AM +0200, Krzysztof Kozlowski wrote:
> > On 05/04/2024 07:21, Siddharth Vadapalli wrote:
> > >>>> bindings in the changelog or cover letter.
> > >>>
> > >>> Thank you for clarifying. I will post the DTS patches corresponding to
> > >>> this patch and reference this patch in the DTS patch series.
> > >>
> > >> I have posted the DTS patch at:
> > >> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240404081845.622707-1-s-vadapalli@ti.com/
> > >> indicating the dependency on this bindings patch.
> > > 
> > > Hello Krzysztof,
> > > 
> > > Do I have to post a v2 for this patch? You had Acked it initially but I
> > 
> > No, I acked it. All this unnecessary talk was because you did not post a
> > user, but it is not a requirement, at least when we expect such user.
> 
> Lee,
> 
> Could you please merge this patch? It applies cleanly on the latest
> linux-next tagged next-20240424.

I ignored it due to the length of discussion that appeared to be
on-going.

-- 
Lee Jones [李琼斯]


Return-Path: <linux-kernel+bounces-101539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB8487A86F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31CE21F24056
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C02F51C33;
	Wed, 13 Mar 2024 13:28:07 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F974596F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336487; cv=none; b=FJ5bAf1XVgYgfnXiU0SYFBqjo8RP+zzpbtm7B01WN9qgtEqr8TABeivKds0dLwiFqifWJf2I3Bs00cfg/RAYg8lh67eAInFEZKiBFw47+0iMXModRfXcJyF7Ha6UDFk5cSNP2wBLEF9yczK3ve0KCOWhaHWgLlkrtD85khGUy8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336487; c=relaxed/simple;
	bh=oUKxFlvQUukrc/k8muIOuD7Q9XhAck+juMRVGN2014s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IySQxwKnayGhFCMo3HzlyDij3AM3mgNz+j850Guv6u7ZJgHC90+r34fGi1yDft7U8Pw+FAEJMQrkbqLgk47vPghcFpmKSIdeNy6dlCHYJQ6pZFLRy1fzDTWwld+a2r7KZdK61qW6lhK+bBkbrMzT3+RStSmgCAfZzKc5KJ88tds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TvrtC4t8Wz4x1R;
	Thu, 14 Mar 2024 00:28:03 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: npiggin@gmail.com, christophe.leroy@csgroup.eu, gregkh@linuxfoundation.org, Li zeming <zeming@nfschina.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221219021816.3012-1-zeming@nfschina.com>
References: <20221219021816.3012-1-zeming@nfschina.com>
Subject: Re: [PATCH] boot: simple_alloc: check after increasing memory allocation
Message-Id: <171033598341.517247.16641505214585396276.b4-ty@ellerman.id.au>
Date: Thu, 14 Mar 2024 00:19:43 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, 19 Dec 2022 10:18:16 +0800, Li zeming wrote:
> The pointer new adds judgment and should help with program robustness.
> 
> 

Applied to powerpc/next.

[1/1] boot: simple_alloc: check after increasing memory allocation
      https://git.kernel.org/powerpc/c/69b0194ccec033c208b071e019032c1919c2822d

cheers


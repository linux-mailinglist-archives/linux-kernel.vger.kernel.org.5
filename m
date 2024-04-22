Return-Path: <linux-kernel+bounces-152959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3567E8AC6A1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BD0B1C2172D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40A3502AD;
	Mon, 22 Apr 2024 08:18:39 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2F04F898
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773919; cv=none; b=ToyZ9XomjgsBJJxPMBtq/8dH7Q2HtxLrn6geneRuT4lRwU3DnK1ZQh2yeWyADAv/rzenWA2YlahLvciOWLYFbm+EOplDtjl7ZIA4duuWKSRiEzGO7A50Dgt0YFuRzvrjYfR/VSSciC2/cYCLcU10Rjtk9Xc6ui/SO4rwBC109Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773919; c=relaxed/simple;
	bh=4bJRhW1KZ/EKZw6F8c6R+B7TptdBV4jRIe8IRlLKovA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qoMi5LezcsoeNasUg9goGQKFVdRh/RCWvOobP9CWrYZ2mnNjLywM6nWoMG+SN0khidgW+n0RsT8CQAtFOiNVO4QwvdBNvbwX9j/wY0+o+SDaajQg8to9hjcFQwIJw0CFWGrwTYHi2fIM0WO8XcoB4iWr4Zwcxew079k6qlylP5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VNJ6d34MFz4x0K;
	Mon, 22 Apr 2024 18:18:33 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Rob Herring <robh@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Anatolij Gustschin <agust@denx.de>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
In-Reply-To: <20240313135645.2066362-1-andriy.shevchenko@linux.intel.com>
References: <20240313135645.2066362-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] powerpc/52xx: Replace of_gpio.h by proper one
Message-Id: <171377378380.1025456.7660942361911740845.b4-ty@ellerman.id.au>
Date: Mon, 22 Apr 2024 18:16:23 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 15:56:45 +0200, Andy Shevchenko wrote:
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it directly, replace it
> with what is really being used.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/52xx: Replace of_gpio.h by proper one
      https://git.kernel.org/powerpc/c/676abf7c39267080ab81597c6d4f372a10c0fc21

cheers


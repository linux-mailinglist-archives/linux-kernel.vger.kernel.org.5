Return-Path: <linux-kernel+bounces-66946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE1E8563E2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7116F1C212E1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEFB12FF6D;
	Thu, 15 Feb 2024 13:01:08 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFC412B162
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708002068; cv=none; b=EPTR17WEkarSysfiyKTwqhxeQuWj9TeiKH8YYGHEQOKF68UJIRbIW7Qo1h/0SOg6WzBZNR/nwSgjm4jtlDCVT2K49dKWPzJIZlXj69zztNW8WiUYCmrGzqY1NWfc3zq8N5T9Sn4/bXXCwh8N7lwDWys2UaCzkmdQ2hYpfjzzWNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708002068; c=relaxed/simple;
	bh=GNrgykoFVLAJjbhbozAeCMXnqoPQUvfSw31yapRgbzg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=amlV+QZJDdDHaFPaeRUFOQTvkD6Pk4eCDrCCBfPA0iF+ryt1EXa0mKjDyLoAaEMdCuntJMutJjO7Ftu9W0n157U4kVefftjSyk2bhiQjZXCdwituPGrBp83607zR3Uoi38tnrRMbX2OfZZhots0Iznw5li9ZAJqkXD5OzkNwAic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TbFYX2xXnz4wyt;
	Fri, 16 Feb 2024 00:01:04 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20240212-bus_cleanup-powerpc2-v2-0-8441b3f77827@marliere.net>
References: <20240212-bus_cleanup-powerpc2-v2-0-8441b3f77827@marliere.net>
Subject: Re: [PATCH v2 0/5] powerpc: struct bus_type cleanup
Message-Id: <170800202446.601034.7720266826681597500.b4-ty@ellerman.id.au>
Date: Fri, 16 Feb 2024 00:00:24 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 17:04:58 -0300, Ricardo B. Marliere wrote:
> This series is part of an effort to cleanup the users of the driver
> core, as can be seen in many recent patches authored by Greg across the
> tree (e.g. [1]). Patch 1/5 is a prerequisite to 2/5, but the others have
> no dependency. They were built using bootlin's without warnings using
> powerpc64le-power8--glibc--stable-2023.11-1 toolchain.
> 

Applied to powerpc/next.

[1/5] powerpc: vio: move device attributes into a new ifdef
      https://git.kernel.org/powerpc/c/e15d01277a8bdacf8ac485049d21d450153fa47e
[2/5] powerpc: vio: make vio_bus_type const
      https://git.kernel.org/powerpc/c/565206aaa6528b30df9294e9aafac429e4bc94eb
[3/5] powerpc: mpic: make mpic_subsys const
      https://git.kernel.org/powerpc/c/8e3d0b8d99d708e8262e76313e0436339add80ec
[4/5] powerpc: pmac: make macio_bus_type const
      https://git.kernel.org/powerpc/c/112202f34e56cd475e26b2a461dd856ca7570ef9
[5/5] powerpc: ibmebus: make ibmebus_bus_type const
      https://git.kernel.org/powerpc/c/14ce0dbb562713bc058ad16d281db355757e6ec0

cheers


Return-Path: <linux-kernel+bounces-101537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D14787A86C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5D31C21AB9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436364D9F8;
	Wed, 13 Mar 2024 13:28:06 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E94A43AA4;
	Wed, 13 Mar 2024 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336485; cv=none; b=dSOuWcjmkgIbRtph9/TU+s+1fwxUr+pqz9KW8o00hbdORYlNPKF7xYgWuTFuVKbanYwM+XFzEtvROlwUeG12mkpVpH49Mgazj8tv6m29NFy/bfnjrbrfagdno8GzIuIgn+6rRGjSBfY7FXoh+WYtp6OvdwiIMPapJu0pPiT0PCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336485; c=relaxed/simple;
	bh=CHtNAQTIT1rvRWPPhR3rIHeiRbGPnmXiD2gTyBFLaGs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=byF4RuIMTWcCErhOkBA3Q0uIphiz3X9oxe2UDzfK6Es6eAKKDuuzv95ahGbMlFUPC53+/HqtfE3XZGUGV4jyhRwapYYlKg5PHZZmeSOheeRn+mwVZ1kwQhTnVdqle/mi0kolXvjf9q4mg16J8BakWHygG2Jqi1uylunumszfqtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tvrt96D1qz4x4T;
	Thu, 14 Mar 2024 00:28:01 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Dawei Li <set_pte_at@outlook.com>
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org, linux-ide@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-scsi@vger.kernel.org, linux-serial@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <TYCP286MB232391520CB471E7C8D6EA84CAD19@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB232391520CB471E7C8D6EA84CAD19@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
Subject: Re: [PATCH v3] powerpc: macio: Make remove callback of macio driver void returned
Message-Id: <171033598348.517247.10069683831844972530.b4-ty@ellerman.id.au>
Date: Thu, 14 Mar 2024 00:19:43 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 01 Feb 2023 22:36:19 +0800, Dawei Li wrote:
> Commit fc7a6209d571 ("bus: Make remove callback return void") forces
> bus_type::remove be void-returned, it doesn't make much sense for any
> bus based driver implementing remove callbalk to return non-void to
> its caller.
> 
> This change is for macio bus based drivers.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: macio: Make remove callback of macio driver void returned
      https://git.kernel.org/powerpc/c/9db2235326c4b868b6e065dfa3a69011ee570848

cheers


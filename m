Return-Path: <linux-kernel+bounces-101535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DD887A863
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC2611C218CA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D280A41C7F;
	Wed, 13 Mar 2024 13:28:03 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1524D4087F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336483; cv=none; b=GvstpIX6yOoP6yTjY4uho/B80G2t13RMMsuhQC1sOtSkMiUAEWxBB73Wd6gdjOFk2AtpnDJcNFfr7AM4yAbInALpnxvMgLsL7gu0OScfyw7oO0lpwM1aWGvMkn1JzaWcS5xKRR7HOGw7JTxMwYDtAj+SGQDbfycCzI4oeaJqR70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336483; c=relaxed/simple;
	bh=oIZpBfin58bqct5vgY3Nt24FwgYE8ZGEjNda9c0Gwhs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tM1SgXtqRf4IT/K0Jv3A17i/60O+QoXDONm+AfShRwtAOe47IEC++2fuuw5zGZEpq/kuHbj+T49t34L8VJPF8eh08SJDL4T3DwSm0NL+rlTUHDGhScCNHH/HMg8y6r2WjSf8/SAAeZ93lrd1gewYdXUegSOzPeB55Zh8ovEqPOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tvrt70183z4x3q;
	Thu, 14 Mar 2024 00:27:58 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Yuan Tan <tanyuan@tinylab.org>
In-Reply-To: <20240211221623.31112-1-rdunlap@infradead.org>
References: <20240211221623.31112-1-rdunlap@infradead.org>
Subject: Re: [PATCH] powerpc/32: fix ADB_CUDA kconfig warning
Message-Id: <171033598338.517247.12723632351604615144.b4-ty@ellerman.id.au>
Date: Thu, 14 Mar 2024 00:19:43 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Sun, 11 Feb 2024 14:16:23 -0800, Randy Dunlap wrote:
> Fix a (randconfig) kconfig warning by correcting the select
> statement:
> 
> WARNING: unmet direct dependencies detected for ADB_CUDA
>   Depends on [n]: MACINTOSH_DRIVERS [=n] && (ADB [=n] || PPC_PMAC [=y]) && !PPC_PMAC64 [=n]
>   Selected by [y]:
>   - PPC_PMAC [=y] && PPC_BOOK3S [=y] && CPU_BIG_ENDIAN [=y] && POWER_RESET [=y] && PPC32 [=y]
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32: fix ADB_CUDA kconfig warning
      https://git.kernel.org/powerpc/c/b72c066ba85a131091498a15a62d6068997278a4

cheers


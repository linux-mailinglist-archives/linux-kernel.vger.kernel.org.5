Return-Path: <linux-kernel+bounces-75636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB5F85EC8E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A582C1F2321E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46721126F11;
	Wed, 21 Feb 2024 23:09:30 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99530A35
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708556969; cv=none; b=YS3c66vC5UoEfYMvuHh3yxhvldIuKYUXC6YzpE4uwEDGr3gSyvd6Z0DwTpvUbN7sDfh96yD0jW9PNNEHmDr1yci1DUAC8ZHM9ZGzVvK+GVHK6gZg+BuTwThlhAimIQeNvbzQGtMbt4SyGxENuaWVguCFp/ieCCJyighzHDlxMp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708556969; c=relaxed/simple;
	bh=+R/pOPh/EohcZjeWa3vr/yP353/UIkRvyTpmUKuWG58=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=H0Rx3kLU02R2g6AB3Y2VK8bQHFr0nibY3QeW1DEM5Ho2yxu4in/vUnMXhLRpyisHotQHmMPxN72obkbmFgEetpk9lflq2jgAYuGjISg+ipfrDrTWZ6Gs7Kmvy2q2sCBrxFL0aY29QOUpNK2fr+DBYg+wec7niCLl7jsmCJe35R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TgBmk0GGVz4wyY;
	Thu, 22 Feb 2024 10:09:26 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20240216135817.2003106-1-masahiroy@kernel.org>
References: <20240216135817.2003106-1-masahiroy@kernel.org>
Subject: Re: [PATCH] powerpc: remove unused KCSAN_SANITIZE_early_64.o in Makefile
Message-Id: <170855692314.1938434.16998260392268778285.b4-ty@ellerman.id.au>
Date: Thu, 22 Feb 2024 10:08:43 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 22:58:17 +0900, Masahiro Yamada wrote:
> Commit 2fb857bc9f9e ("powerpc/kcsan: Add exclusions from instrumentation")
> added KCSAN_SANITIZE_early_64.o to arch/powerpc/kernel/Makefile, while
> it does not compile early_64.o.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: remove unused KCSAN_SANITIZE_early_64.o in Makefile
      https://git.kernel.org/powerpc/c/97a5253d7c3076ba0dbba8bf30179e079c9c912b

cheers


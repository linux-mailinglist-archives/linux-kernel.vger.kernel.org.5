Return-Path: <linux-kernel+bounces-101532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB08587A85D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E3A3B23FB7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BDF487B5;
	Wed, 13 Mar 2024 13:27:57 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D27446BA0
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336476; cv=none; b=osIvCs/N8jMp2Q/FJG0V7ui/XeIwHJ55Y9fEXt43DOQVCLmggCyDNHylf4/V/MIECyeQHjtKdpgOwLCuxv/QLO+IgVBU77awWs7i1v5cLamxDSlGij5JCqDULnCrIoPmlma7U2eE6WEN1vqgFN28Wq3PDG0lT6JlaB1SCHBH9lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336476; c=relaxed/simple;
	bh=KsqtE0RnoxxjoooDSevmuSJIEOTRdMJjG9AOWbmqlm0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oKS0hb8n7wWwNQWtUr2RDMPKjv+oqTXppgYsK1t7lwB3c+hKZ8ie95ntm7nOaybMIGx2Xl0qGiU2wh82npeXPRnjGwXLct8AO69hVdSqfz3X3eJ3uFMb24YjJlo2q5yLHg4bObQdn8iFd2MUzbF/46j4nEM6DD0Kh9MM4GVAX4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tvrt00P8Zz4x1d;
	Thu, 14 Mar 2024 00:27:52 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <fbf74887dcf1f1ba9e1680fc3247cbb581b00662.1708078228.git.christophe.leroy@csgroup.eu>
References: <fbf74887dcf1f1ba9e1680fc3247cbb581b00662.1708078228.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Use user_mode() macro when possible
Message-Id: <171033598336.517247.12211842941297180348.b4-ty@ellerman.id.au>
Date: Thu, 14 Mar 2024 00:19:43 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 11:10:36 +0100, Christophe Leroy wrote:
> There is a nice macro to check user mode.
> 
> Use it instead of open coding anding with MSR_PR to increase
> readability and avoid having to comment what that anding is for.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: Use user_mode() macro when possible
      https://git.kernel.org/powerpc/c/d5835fb60bad641dbae64fe30c02f10857bf4647

cheers


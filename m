Return-Path: <linux-kernel+bounces-131668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F10F898A99
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE655290D48
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C772012AAC5;
	Thu,  4 Apr 2024 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAF0b0ah"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1400A1CD03
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712242894; cv=none; b=jQYSaMMH+gwGmb02ojRz+TjBLHaPLpBp3y/WbRp3k5AhpAjgNClFk5icCJ/njqaNyUpJisV8NTxf+sM4ygADH62H6jB2hOnoKIisRmA2HisK3UH4XBoLbZNq0YoaAXehvAzk18/auTnvMrwODz8QXnC2ZcBByxqpE+t/dDIX2I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712242894; c=relaxed/simple;
	bh=5+htYdn08xYnGlvtbLFGMnArVl81WICdumRj/WZ3Kts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sW/VwGX2wqpOHgB/xDWGOpdbt17YK9iY4/ZSO49E2zSzgYSy9WTm4OTBDO5i/Nl1yjmgchf7jNGw6fu58HJiQGazuTnboudjuwu4QnbjgpMOLUBH+71ldGkWrmQgn3o8LygeJ0baSfj0EXKj+IleOh2FIJkIPceazujYfTECJio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAF0b0ah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275D8C433F1;
	Thu,  4 Apr 2024 15:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712242893;
	bh=5+htYdn08xYnGlvtbLFGMnArVl81WICdumRj/WZ3Kts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jAF0b0ahnrI5R8fx5iyPuElDzbVv4RJWE5kfOQKINFbYm4QkwA+XAqk2Zpui+Sbqo
	 dl2j7cRvWrB9mIMlQtwPtMlSO1YiyGmQdOOCPayL1LpcmICGIOSga+bG6Tt0shKjF1
	 fMw2b62VE4kjqDZu91+DXBaE80Ioo3PU0wEs8QPILozEFA/rQsKQ1xMXzyP/SxAKBf
	 d4aFx4UJwr+DjaG9GKQmcD6kyMNPz1rXlDWIa6kVxZmFLZkalTnWM717fb8ay0eEpv
	 Zn0Zg6pol6GL14bxAVX9U1l6OFDwmeHsmhBrZZccnxwj1cvEwuawKcNUAgfExJC4lM
	 Y0IPkKYXIA/xQ==
Date: Thu, 4 Apr 2024 08:01:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Palmer Dabbelt
 <palmer@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Paolo Abeni <pabeni@redhat.com>, Charlie
 Jenkins <charlie@rivosinc.com>, Noah Goldstein <goldstein.w.n@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] lib: checksum: hide unused
 expected_csum_ipv6_magic[]
Message-ID: <20240404080132.2cd4821d@kernel.org>
In-Reply-To: <20240404114450.449683-1-arnd@kernel.org>
References: <20240404114450.449683-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Apr 2024 13:44:33 +0200 Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_NET is disabled, an extra warning shows up for this
> unused variable:

Happy for others to take this, but to avoid misunderstandings -
if it's not on netdev@ we won't be able to apply.

Acked-by: Jakub Kicinski <kuba@kernel.org>


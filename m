Return-Path: <linux-kernel+bounces-119788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F7E88CD0A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5463AB21FBF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DA413CFA4;
	Tue, 26 Mar 2024 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIvOQtH5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E410B380;
	Tue, 26 Mar 2024 19:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480807; cv=none; b=nJ8aSeDwVUs9YIo2VdICotYQceiGcqWLMJvkgLfvhF80Vjq976bsij4kmUldLzx3oFQ1s9g5uWrTEC5SQnh3bmGqPU5Yf+xGUo8lc420OArTsvASP36n3W3YqLgmWTm50o0ZSg4v2BiZWta+hCfAazf5q8rfTKt9tQPvD3j6yZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480807; c=relaxed/simple;
	bh=HdZ0wc9vFbqDr5s6m1kef6KHcFxkBxZPZTqoUzXnCms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czJVx0lej1s9J4qMQpSsD1A6pu8qQGcG9ZDO2DypUEcNyKJ5acLnM1b4+WaIVj96+A1eXR0AkKC21nBLezKQemSifYrdorluMgO4J0UBAuOQPkXtgsrRiQytFZJzP1LunEDFTruGtXQ7sHDnOgtkTaCmuEryda7mCbZsYppMjTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIvOQtH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B80C433C7;
	Tue, 26 Mar 2024 19:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711480806;
	bh=HdZ0wc9vFbqDr5s6m1kef6KHcFxkBxZPZTqoUzXnCms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oIvOQtH5JD7SB5Z+CvNS7HV9uvSqO1ARQiZyQtwXbAuH8Lishk01b5shCwL/zcHBh
	 0BuBO/EA1IiE6eTO9GFJ4cSfde/6C8LUPSKXmv01yaysCM1VZ2Y4U9UA8BOZVCbT6O
	 i6ghpOedXzvyMLMSh/wbyb9ktXgZyGHMeAVFeTYXmDaW3Hp/QpGK2ILrRpnc2LAeQ3
	 e89wKp3y1TU/JvmF+PfQNTwU7MEjrOUkj5eXm0/xyDiFXAL45+5igTcNlaeYnGsE7H
	 VhgRecQ7sB0uGPmiaB9tQf0hV9SppWtGKuv7ar4jdbe/IUD+rBL+3dpJ6T2N89wczE
	 eOAiWm4TQQPxw==
Date: Tue, 26 Mar 2024 15:20:05 -0400
From: Sasha Levin <sashal@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Geoff Levand <geoff@infradead.org>
Subject: Re: [PATCH 6.6 430/638] powerpc/ps3: Fix lv1 hcall assembly for
 ELFv2 calling convention
Message-ID: <ZgMf5YDxqK3mD043@sashalap>
References: <20240324230116.1348576-1-sashal@kernel.org>
 <20240324230116.1348576-431-sashal@kernel.org>
 <87wmppip8g.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87wmppip8g.fsf@mail.lhotse>

On Tue, Mar 26, 2024 at 03:36:15PM +1100, Michael Ellerman wrote:
>Sasha Levin <sashal@kernel.org> writes:
>> From: Nicholas Piggin <npiggin@gmail.com>
>>
>> [ Upstream commit 6735fef14c1f089ae43fd6d43add818b7ff682a8 ]
>>
>> Stack-passed parameters begin at a different offset in the caller's
>> stack in the ELFv2 ABI.
>>
>> Reported-by: Geoff Levand <geoff@infradead.org>
>> Fixes: 8c5fa3b5c4df ("powerpc/64: Make ELFv2 the default for big-endian builds")
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> Tested-by: Geoff Levand <geoff@infradead.org>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> Link: https://msgid.link/20231227072405.63751-2-npiggin@gmail.com
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  arch/powerpc/include/asm/ppc_asm.h  |  6 ++++--
>>  arch/powerpc/platforms/ps3/hvcall.S | 18 +++++++++---------
>>  2 files changed, 13 insertions(+), 11 deletions(-)
>
>This commit is OK on its own, but it doesn't have any effect unless the
>full series up to 914d081ead11 ("Revert "powerpc/ps3_defconfig: Disable
>PPC64_BIG_ENDIAN_ELF_ABI_V2"") is backported.
>
>I don't think the full series warrants backporting, it's really enabling
>a new feature (ELFv2 build for ps3).
>
>So IMHO please drop this patch from 6.6, 6.7, 6.8.

Dropped, thanks!

-- 
Thanks,
Sasha


Return-Path: <linux-kernel+bounces-131813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E7F898C19
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029211C221F1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C7612CD8F;
	Thu,  4 Apr 2024 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrYasypL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADEF12BF18
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 16:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248147; cv=none; b=QkjEwG2aX/xVETO/uDzE8Aqfrrt/fCs36k/CNBwmiXJJk6kpuCYzDz3HupHEQfp5wiMNbFSAgr3oVCxIspLoOQAYADxsKTPouu7a1mNKwAAOKLdxDHKzTVJnqCA5KTSCKarbkN8a+N3qTuzGViHvJjyCGvTBUocy6RS5ZhG3yIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248147; c=relaxed/simple;
	bh=skf+V3ENVy6yJFjcoQmpX5VStn9GP1iBM8YMJ5tQsCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BMPygnlppdit6s1qpDku7BBuWztpnIXLJcZLJmQbPcq/Iakp0KZ1OOx1/BhHKtzh74M+7E6SIjPfiHIZOeR9xX+S4o1edPeZ7kSVbld9VMjfChKhl2AvwD6r4mGMa5S3EHIDioL6tLwpU31Y97oJnL1NyehmWBDxw3J0u042Ke0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrYasypL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD98C433C7;
	Thu,  4 Apr 2024 16:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712248147;
	bh=skf+V3ENVy6yJFjcoQmpX5VStn9GP1iBM8YMJ5tQsCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FrYasypLxfsw1lW5CDcwH+dMeTHN5p0i4XoYn9pB5m4mrBqCxlF0rpJudG46bvyIJ
	 hTElVqRQwfQSswUJLW1BxdvpAG1GBXqSS63I5qxwGANrf3HnaIrrqlhojM7b+OUU5r
	 N9jvpqfBAzGUm5y364V2jK+lLWHfEokkRO92T1yJyBXaPANCXyodJTKABwr/uzcqUA
	 BLyVy9WbgQ7WwiWBgJA5k9uIyeLomSepAb26d9bBoKYy1SAEmVQbH2k4vnjsANztBi
	 Ai82dLvDBdYFj06ZyZMFHorxeHZSekzRxc1tFx9/ZOat/LI15DYI1fDNBOmuGIANuF
	 oOjmQSUlvWHFw==
Date: Thu, 4 Apr 2024 09:29:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: arnd@kernel.org, akpm@linux-foundation.org, Arnd Bergmann
 <arnd@arndb.de>, christophe.leroy@csgroup.eu, pabeni@redhat.com, Charlie
 Jenkins <charlie@rivosinc.com>, goldstein.w.n@gmail.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] lib: checksum: hide unused
 expected_csum_ipv6_magic[]
Message-ID: <20240404092905.1270a60f@kernel.org>
In-Reply-To: <mhng-793e0145-42a1-4c3f-b5b7-eb5dbacb4f34@palmer-ri-x1c9a>
References: <20240404080132.2cd4821d@kernel.org>
	<mhng-793e0145-42a1-4c3f-b5b7-eb5dbacb4f34@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 04 Apr 2024 09:23:57 -0700 (PDT) Palmer Dabbelt wrote:
> > Acked-by: Jakub Kicinski <kuba@kernel.org>  
> 
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> Looks like you took the last one, do we need to just CC 
> netdev@vger.kernel.org ?

Yes, Arnd would need to resend to get it into our patchwork.


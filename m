Return-Path: <linux-kernel+bounces-116625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E40A88AC30
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2369EBC82BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2495181CF4;
	Mon, 25 Mar 2024 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpH2ehA0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297A23D4761;
	Mon, 25 Mar 2024 03:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711338051; cv=none; b=ZAcyu6GktH6vcvqBHBP8aIp01Q5SbNKp2JUnlQZkg2o4xyvW2i/qUdFup4ijqc2Hv6OihAdVGM9YFaUPbuWztpmDWl5NAvw/igOEd4WSS9xc/WSb7jSl6OdlO3wG0ur+VOIyNgdOgapJtK7fZV0iVN8XbB0vxfOguVbwCfD1/eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711338051; c=relaxed/simple;
	bh=vDZw/Zf+0jGN4n5carmwkrPgH547FTCtQ0xr6X65jhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaNmmo8ym10PGjhieXw8f7Lp6OV0ELRDkLJKBUllxsSA/yEpM/RUiONJzxumKKmzOSGM6EX+ZLNTlmwhXjZrGpwBIuOpeG8PF21+y6O5Rpy2Yh4jRu9d2jA7eTPHjmqMPbQEz7lHRaDZG1oKO4OOBepVOStPHz93WDv7wumkWas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpH2ehA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9665BC433C7;
	Mon, 25 Mar 2024 03:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711338049;
	bh=vDZw/Zf+0jGN4n5carmwkrPgH547FTCtQ0xr6X65jhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZpH2ehA0f9PsqlY0yhNuCh8cNP8dpBpRR8OH4AnhpRvw6l2fkoepTuQnVR4lV1R+Z
	 a5+FhF7V4CIcomtc+6+Vl8RERHl2XN/JonF+8mi8Kv7CRBuld9UKyLIAMFA9hwwCyU
	 BQnvV/Eiot1FGQ4zJMo5IdVr8J+xqXgk7ux+D8bRxyy0eEEfQp0aedq53YXoqVPrp9
	 l5e8ruNKKqGdH0HK+oliGa1uFeScKlSZ78PwxsUSZSf5Cg2NV4ibV4cNAum+YHAXju
	 D83eNUCH6QF3yh1ypp08zZ+FiVYw3+KbyWoqQ1rOVMTw85ACRJ/LkIXyn3K+7bV7kR
	 gBLXLHG0LCw2w==
Date: Sun, 24 Mar 2024 20:40:48 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 5.15 032/317] f2fs: implement iomap operations
Message-ID: <20240325034048.GB37260@sol.localdomain>
References: <20240324233458.1352854-1-sashal@kernel.org>
 <20240324233458.1352854-33-sashal@kernel.org>
 <20240325033717.GA37260@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325033717.GA37260@sol.localdomain>

On Sun, Mar 24, 2024 at 08:37:19PM -0700, Eric Biggers wrote:
> On Sun, Mar 24, 2024 at 07:30:12PM -0400, Sasha Levin wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > [ Upstream commit 1517c1a7a4456f080fabc4ac9853930e4b880d14 ]
> > 
> > Implement 'struct iomap_ops' for f2fs, in preparation for making f2fs
> > use iomap for direct I/O.
> > 
> > Note that this may be used for other things besides direct I/O in the
> > future; however, for now I've only tested it for direct I/O.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > Stable-dep-of: ec16b147a55b ("fs: Fix rw_hint validation")
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> Nacked-by: Eric Biggers <ebiggers@google.com>
> 
> No reason to backport this, and the f2fs mailing list wasn't even Cc'ed...
> 
> - Eric

I see a lot of other f2fs patches in the queue too, have these been tested?

- Eric


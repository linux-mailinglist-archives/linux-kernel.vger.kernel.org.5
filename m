Return-Path: <linux-kernel+bounces-83742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A71A869DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5545528A6F0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC3913A884;
	Tue, 27 Feb 2024 17:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V58vWcGL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01F02557F;
	Tue, 27 Feb 2024 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055450; cv=none; b=sRJNkCpIzVG9Yq9oR24k/24FuIG+ceHxSIJoCi/wdalRjdK2GEUOmT28I/jx0clEN+hIQOq8rjT49ooI0+eHgLcJcsDeykpS6jJWf3T732iMghZC2isR5FbU9C3jrp6F2/3lwpYIylEced95ufd991F6UGqySRqeUlnPwAmnF7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055450; c=relaxed/simple;
	bh=pnrlfa8DQDug9+FyOX0UkH/g7kBu6G3bz9CK5/sS19g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEOHv8xwVheMBBcICikdCZIjlB8mSr4hI6gUM1BWp/VAQBouoe326razeHiKxc5JiruGSY8lDan8i/vxHwsVXMkJWgsBQBkQeu5Tc+nWca1jauE/aLrWO+tTZyIygktQgXlqCmLN+32jxnIVYc4ycN67PdSSN/BzrJTO2QZ6EXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V58vWcGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE1DC433C7;
	Tue, 27 Feb 2024 17:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709055450;
	bh=pnrlfa8DQDug9+FyOX0UkH/g7kBu6G3bz9CK5/sS19g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V58vWcGLn+yCPHGoHBQgrcEwWda+vEIAfDAF0Y0CdjRI3gZm+X+2DhyvYBvsPGVE7
	 MwKjbYU3ifl+rKNY5RJ1lOxIR4Vr6VmH770i7+V5Xpv2mIpfpP5kNxuB0j32mc37Mz
	 gS7oDRiFI0uXoOguEA5Ui0WbsLgtPKW4h3l+lXMkL5Tq8aWxcZKOwb8jI8Nz1ykUMX
	 vnTV2fOr6hwp/1nMYGDXrXpqjGP2Maif7J0H8s+qKZ1oufo+vIJxCLqUmYhEoJODUj
	 a//csWGw15r5p4xQ8niRqzbaI324bW5mCtLBz8PQp98s8r8x6RZUUDMxsqQWegUDF3
	 GTLWRjYGTUUeg==
Date: Tue, 27 Feb 2024 17:37:27 +0000
From: Simon Horman <horms@kernel.org>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, davem@davemloft.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] uapi: in6: replace temporary label with rfc9486
Message-ID: <20240227173727.GI277116@kernel.org>
References: <20240226124921.9097-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226124921.9097-1-justin.iurman@uliege.be>

On Mon, Feb 26, 2024 at 01:49:21PM +0100, Justin Iurman wrote:
> Not really a fix per se, but IPV6_TLV_IOAM is still tagged as "TEMPORARY
> IANA allocation for IOAM", while RFC 9486 is available for some time
> now. Just update the reference.
> 
> Fixes: 9ee11f0fff20 ("ipv6: ioam: Data plane support for Pre-allocated Trace")
> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>

I'm unsure if this is a fix.
But I checked and I agree that 49 (0x31) is
documented as a type for IOM TLVs in Section 6 of RFC 9486.

Reviewed-by: Simon Horman <horms@kernel.org>


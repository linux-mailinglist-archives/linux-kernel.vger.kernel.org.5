Return-Path: <linux-kernel+bounces-116917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA63A88A51E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710A2281651
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9E315218C;
	Mon, 25 Mar 2024 11:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyJem5F9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93206152167;
	Mon, 25 Mar 2024 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711364980; cv=none; b=t3YKj82yXlOUO+0M1QNdEhOlZhJE7NSc0uLfbBNihwOJeRXnoZ0ojFlYBkb4hhm4MkzqCUCol35Fx5uWGjtfiZYXB7D2PvVl8OYyJ1owO0TKBvUI78Nn6WQuTk16H2haOIzcDrTuvnSgjlMd+Yf9rkEL1ADQNPG7bHoFjLwmp3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711364980; c=relaxed/simple;
	bh=cPxhrZvThN9oJvSfB9xsiOmqXLJlE50QwH8CXPKaVM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcDvboVgfNH+UwSy8DrMt4/sbjNOdfWI2SGz3a27C4D79/dFhwVxEKJH+/UDWzwdkFIJSp6X97K8dJlxn+O3HhBo/Q15gMciwichG3LmmkgpF2R4zm4qdPw1kBpd2ll5Oo56II+fYZqdmXaTyChFxH18YpZ2GmanXg0yUuWyqDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyJem5F9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31CAC433C7;
	Mon, 25 Mar 2024 11:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711364980;
	bh=cPxhrZvThN9oJvSfB9xsiOmqXLJlE50QwH8CXPKaVM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AyJem5F9rbDyzGr56QSdoY3/M2TWLVN92den5wew19TKoFSgbn7GArQV5qo0wwXBc
	 pP4KLqnLmNe45f3DaLoQBCuw3Iuc1sVyukQya+/3ohNwnNVFs62naGTG/jgGnZi5p5
	 8vBV8swsxSbk1WHXzJKCugrpB71bUv2Q+z37MdwMPfgT8n8zYXfXcbeXmGd7pzfEJ/
	 yR3bDbm8fvLBNgn4CUxvQUCuuV7TFwAOhesDTudio4lqBVPf0XGf+u3sOq7Gg777DB
	 1wwF1Qk5D3nAS+qel5ywYHOdeJrzVQ9mK9B1XfQq9A6whSC/RhrdUgaAqMFmdiJJ3S
	 okP0IxRLnPYLg==
Date: Mon, 25 Mar 2024 07:09:39 -0400
From: Sasha Levin <sashal@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 5.15 032/317] f2fs: implement iomap operations
Message-ID: <ZgFbczaoqAz6mWq1@sashalap>
References: <20240324233458.1352854-1-sashal@kernel.org>
 <20240324233458.1352854-33-sashal@kernel.org>
 <20240325033717.GA37260@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240325033717.GA37260@sol.localdomain>

On Sun, Mar 24, 2024 at 08:37:17PM -0700, Eric Biggers wrote:
>On Sun, Mar 24, 2024 at 07:30:12PM -0400, Sasha Levin wrote:
>> From: Eric Biggers <ebiggers@google.com>
>>
>> [ Upstream commit 1517c1a7a4456f080fabc4ac9853930e4b880d14 ]
>>
>> Implement 'struct iomap_ops' for f2fs, in preparation for making f2fs
>> use iomap for direct I/O.
>>
>> Note that this may be used for other things besides direct I/O in the
>> future; however, for now I've only tested it for direct I/O.
>>
>> Signed-off-by: Eric Biggers <ebiggers@google.com>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> Stable-dep-of: ec16b147a55b ("fs: Fix rw_hint validation")
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Nacked-by: Eric Biggers <ebiggers@google.com>
>
>No reason to backport this, and the f2fs mailing list wasn't even Cc'ed...

You're right, it should have been dropped when the dependency it was
needed for got dropped, I'll do it now.

-- 
Thanks,
Sasha


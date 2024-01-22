Return-Path: <linux-kernel+bounces-33052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AA08363F1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60242B246A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A983BB4F;
	Mon, 22 Jan 2024 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpDuKI7y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985716FC6;
	Mon, 22 Jan 2024 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705927923; cv=none; b=lbXq2Wd2rhZqn5Uqqkkq+939jysHBMX4Ndg8GMjlPU+bqwVS7ju0Iv/wtSbVbqPsJM5d1bi3RQAV+XKjdB/gLjynCFaWqNKk4mxc5PhBUcz1sCRif664C+omeNNeeh+y3EV4VBbu8IfJTBKu3boDkjKZGwKihA+RE1E4BHxeDiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705927923; c=relaxed/simple;
	bh=ek12Fo9+h/4gxnTkeDIXoNZF4jS2nFpEnjFmagMNSVw=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=mzL2zGMpGyvv8HlehrkarYNP1H4zYwj/eQqtEsyg/OcL2x6z0p+Xl9pRNOWEYbG+thoC1hB41W5KyDk9syceg+R7c14+K6BahYFhwqBaqbUqX2kfLK7fss5gU/7z5sX/rvUcvD+0xpRMPOO5MR/JO0R6zmfg7hYHuI9vGp+/Cco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpDuKI7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C93C433C7;
	Mon, 22 Jan 2024 12:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705927923;
	bh=ek12Fo9+h/4gxnTkeDIXoNZF4jS2nFpEnjFmagMNSVw=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=NpDuKI7yKNYuy8wthqSQwDgQQBYVZqJvcFqo3awd88GUCmPF9FN0Fxb4UWuev00Pt
	 8Ili9LGviWHYYkkR5jr7h1ejQf7khSKkLS/lFZ+2bQ8/gZZDN9N9IiB5k9HF57G51i
	 C8hOjqvIXYakMF9uQbsa2COrnB8cwbbFbMwOZn1X5FWIsXZaYPkh4c5MllkP4zPdhV
	 07jL4lUzKOZ93chhgwXdAmTKfvVeU8gSUNdvdQ6NJTWGhnV9Onj4155hB8GZmM55VA
	 7b8go8un2NnBrAQPhWikohnHF906uYAUBQ5yA0k+QVV4nAe+mmyUMYzlc2qlAPh8NU
	 0nbV1Nz5pAs2A==
References: <20240118080326.13137-1-sshegde@linux.ibm.com>
 <20240118080326.13137-3-sshegde@linux.ibm.com>
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, mingo@kernel.org, peterz@infradead.org,
 anton@tuxera.com
Subject: Re: [RFC PATCH 2/3] fs: remove duplicate ifdefs
Date: Mon, 22 Jan 2024 18:20:13 +0530
In-reply-to: <20240118080326.13137-3-sshegde@linux.ibm.com>
Message-ID: <87cyttedjj.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 18, 2024 at 01:33:25 PM +0530, Shrikanth Hegde wrote:
> when a ifdef is used in the below manner, second one could be considered as
> duplicate.
>
> ifdef DEFINE_A
> ...code block...
> ifdef DEFINE_A
> ...code block...
> endif
> ...code block...
> endif
>
> There are few places in fs code where above pattern was seen.
> No functional change is intended here. It only aims to improve code
> readability.
>

Can you please post the xfs changes as a separate patch along with Darrick's
RVB tag? This will make it easy for me to apply the resulting patch to the XFS
tree.

-- 
Chandan


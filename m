Return-Path: <linux-kernel+bounces-100952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A1087A001
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795C11C21EE0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BC515AF9;
	Wed, 13 Mar 2024 00:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeaVgAoL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FED364CB;
	Wed, 13 Mar 2024 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710288032; cv=none; b=QByLFyUxG5IQ5wq0L37gJmfsHMAG+f+tXrpnUE/dxhRS9sAnxhZ7g700rlVzfcTVeBM5FguuALUpnystwaeN3DLaox/C/UicJV+K2uVomag9wHGo6X8QzWIpK6Cbc9f9fE3QXGpNXnrkIZxPOfY+i4uM57FKJNpw6fym4hIIwnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710288032; c=relaxed/simple;
	bh=LH0nVjynKjq8K4F2iRsz6QPRLyDYFddaGPJ+zTMGKkg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fJM1uXw7MLzZqafLdjp4ojEA5jBdI23pPiWCo6s55l0Qd835opLIEtKlbLkbKNfg1bRBnakhiGZCFTaJkaPQfVSp8qOdGlc1O8BYxBrgTPFdQ8xYrMtTMk3e7rvsDojSYOyKR7yFSqggNQi8HIE1u2xpYWWpVnJkWiMaBwckTic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeaVgAoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8B1C433C7;
	Wed, 13 Mar 2024 00:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710288031;
	bh=LH0nVjynKjq8K4F2iRsz6QPRLyDYFddaGPJ+zTMGKkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BeaVgAoLlKZvhWIVV+fjzhPa7DBncVqhEBopkkyG2KRN4fFZG1/poRgCAUVTBkZcy
	 Cc9+LItGfImVAsNPNqMwaGPgQkxykdbtJTv4JlTW1Ev+OqJR2v3xZc4c15AB/P6rem
	 8k/W3iEhC+XZf4rWJ8agZMYb2LvvaMj2+dCzczpsWvpSXUQeYfhkXEtAiDjU6+Jb/i
	 QOWKgwzZYITyHuwklIu8hKNVlVxUFHTbNdCPx4XDUmgikvMumtXyJz6osdb6ZbHkCJ
	 WQV4WQUKlO47o50jf+BF8DeaeUGLwVm0tFVlYJ3ToStVpA1o6882M8XHRfwKM7Cq1W
	 rvlsEH9O4bybQ==
Date: Tue, 12 Mar 2024 17:00:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: torvalds@linux-foundation.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org, pabeni@redhat.com, bpf@vger.kernel.org
Subject: Re: [GIT PULL] Networking for v6.9
Message-ID: <20240312170029.66218158@kernel.org>
In-Reply-To: <20240312152423.2bc2ec97@kernel.org>
References: <20240312042504.1835743-1-kuba@kernel.org>
	<20240312152423.2bc2ec97@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Mar 2024 15:24:23 -0700 Jakub Kicinski wrote:
> On Mon, 11 Mar 2024 21:25:04 -0700 Jakub Kicinski wrote:
> > I get what looks like blk-iocost deadlock when I try to run
> > your current tree on real Meta servers :( So tested the PR
> > merged with your tree only on QEMU and on real HW pure net-next
> > without pulling in your tree.  
> 
> Tested on real servers now and it looks good.

In other news Stephen reminded us of a potential conflict with the MM
tree:
https://lore.kernel.org/all/20240307123619.159f1c4c@canb.auug.org.au/


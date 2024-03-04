Return-Path: <linux-kernel+bounces-90624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BF287025F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6CA283184
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AAE3D96A;
	Mon,  4 Mar 2024 13:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="1t2N5Uhd";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="dLqHKolL"
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1A73D3BE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557868; cv=none; b=CN+imdBjSj3Ju7pqwTdUjHzCdHAFngbG/ax5PT237TXRLNSxLzms5c7XSJlcsUOoaHVLIrFgH5KL/60mdIdtsPprtEtvm7tCcuhinwYfte2XYkRkfO++LD91GByDL9ysDtmYgioEvEs9Koht5iVkd/JzXL5xwAtG48jLo1exEJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557868; c=relaxed/simple;
	bh=nooUNjf/FBwMwIpB0WjYml/LaIESHAu1Ci4s4v41dew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRNxYs2MBhuiuWVbu64bVNIfhWfpX2eS6surhiHw6GWrj1gNYRzqx5qTIvFRL8zNn/09sqCadlDNMdbMRiF1uZZo5OtjzYIeeOVpzWDZtq07OU0WhwRXNhFQXjM8s0ScNehydGll6FdnGn/p6w7wb3e+ZHSEUtWaWEk49RuXUIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=1t2N5Uhd; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=dLqHKolL; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 42776C01F; Mon,  4 Mar 2024 14:11:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1709557865; bh=r80fpE+N5xKfTcdTiGFnYd+7aOXoX0H9BY+QrwtefC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1t2N5UhdSJtkmCilLGLMEA2r+jzWWSifV1IlsO9gP0oPJMon7P2l5Rc+8vlf5VSlC
	 PcH6c8TW3ROYl7y5uPaTdDDJOD+1iaboabBGOaECK3qMfcxzzlbfmEbq30pbSsJ91x
	 ALPYfY/hDvT/e3duK4y9gSLVFDOj8X8ZrgYrSXv3SjqeUI1KzMhNsOM8R/Wo634ZIe
	 HWiZKDJgkxts3g6QQoRAnOXdmuaWmVjMiuUKbwJ1TuWqH8odJQyGTdR6myK9/kNMdy
	 L3Jvd9utU01QqRn3cpDyMHCVlaCjjrJ8xub9Spabpj+HkLQ+2DA6B0xsV/LxaOffpT
	 d6WjLXOP57urA==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 9FFA6C01A;
	Mon,  4 Mar 2024 14:11:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1709557864; bh=r80fpE+N5xKfTcdTiGFnYd+7aOXoX0H9BY+QrwtefC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dLqHKolLX5f+oq/CGD2+0Wpsg4QXmxIR6kNcS+EFf0B+4Awbwa9m6mVQO9AwJ8Rsh
	 Wu5SiDJ66VwCjpTPhBZgyy1SsNHxaOIy1LctYWylD9qv4lUhiZktonJGJ8GuPem+MT
	 hFdWT+5uzKQZ7litAv9eCFdr3L4dorwzFrJDXmMb6/sqJLUZ8guzYaJRUwlPqmeYvH
	 lgTP1VUezOgbJKsA8wKjIMSmqxVejoeFTGUr57nJJjk4bPedhRaL5Gbgs68sxYsF2P
	 veCQrarYufi93WhlOmA9ocNdzl7mXTj+BQFIjiuSoKgEdjvZ1my3FdDUUR6vfXU0LS
	 TfPAtSJLctlYw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 3354139c;
	Mon, 4 Mar 2024 13:10:57 +0000 (UTC)
Date: Mon, 4 Mar 2024 22:10:42 +0900
From: asmadeus@codewreck.org
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, vbabka@suse.cz,
	roman.gushchin@linux.dev, Xiongwei.Song@windriver.com
Subject: Re: [PATCH] 9p: remove SLAB_MEM_SPREAD flag usage
Message-ID: <ZeXIUlqnp23qTxo2@codewreck.org>
References: <20240224134617.829016-1-chengming.zhou@linux.dev>
 <2de0d872-0e05-4fbb-8291-0c60487ccd8d@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2de0d872-0e05-4fbb-8291-0c60487ccd8d@linux.dev>

Chengming Zhou wrote on Mon, Feb 26, 2024 at 10:51:00AM +0800:
> On 2024/2/24 21:46, chengming.zhou@linux.dev wrote:
> > From: Chengming Zhou <zhouchengming@bytedance.com>
> > 
> > The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> > its usage so we can delete it from slab. No functional change.
> 
> Update changelog to make it clearer:
> 
> The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
> removed as of v6.8-rc1, so it became a dead flag since the commit
> 16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"). And the
> series[1] went on to mark it obsolete to avoid confusion for users.
> Here we can just remove all its users, which has no functional change.
> 
> [1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/

Thanks for the updated text, this is a bit better.
I've updated your commit message with this and will push to Linus next
merge window in a couple of weeks, as you said there's no change so no
reason to submit a patch this late in the cycle.

-- 
Dominique Martinet | Asmadeus


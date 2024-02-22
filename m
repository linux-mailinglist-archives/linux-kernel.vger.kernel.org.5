Return-Path: <linux-kernel+bounces-76008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B502385F1DA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 465A5B235E1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96671799C;
	Thu, 22 Feb 2024 07:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sxFGqYjM"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D41BFBF2;
	Thu, 22 Feb 2024 07:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708586617; cv=none; b=K91GfVlRvxD+lMV2GjQ6C2WRvSn5rwn1vQnnttXziWzQxhrKjbpUY5+posgOQP49WWEdRHIU1Ry4+opMCK3rdExZGp5cFuGps1jWm02sX8Z5fR+hkodwodUlcjNGvlSePeNKrWAVYBileb0CEluRezIFywBMCHryXZLD1HRxlKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708586617; c=relaxed/simple;
	bh=U48hwvgqhEIEdswwj03YABtvmBx7WhMiKcJ3GZXfkqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGaMVX4O95P67X3njdclgf7LrbE15bno8K8qfQGOakwbBnO4eh232kIlCkm3NBWRVqzHL4E52ZW7PNY95DlqbNzuU3ddWhGpuOuUDk6QisEQ2mi/5ERj9ryxCJ4RFJmDNCUgdnMpua6EzRLJ06wtUH3UHyMw+ofZEia1pG/ooNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sxFGqYjM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=qK+2MaZFtcEDhEaWdoLRlOAD4pAHu2LPjRADBtfdHbU=; b=sxFGqYjMuCWZPr4RlDWt+cqv7f
	qzljRBv4zqwhAg/LgXloVt35JBpbUBM3Rtahv5G3i9+Zi+qeBeFBqwkNmhAijpZvlq5pPs82BhBWv
	RrRNvum3/SNH1UPNYEfgxLGt7TrSE/R0esLDOESLw8pA6MOjJ3nOrgaOdi0oBUfrBZ/Vi32jjPNJ1
	Fh5jcvJ5UcjyU+MlAySGzd7raq+/v6nAZseaPg65SeBL6HBAz1/XL5PrTEFcKg+EdS40UApIZARu6
	cMVhqlZgEmqRVnAYgM0kBX428ZNQ/sFXHHIvJpPDtE1It05ATljdM2tnLn2lySgRV/YG1ZYwEiKP8
	qO3cgalA==;
Received: from 124x35x135x198.ap124.ftth.ucom.ne.jp ([124.35.135.198] helo=[192.168.2.109])
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3QJ-00000002uXc-3NVq;
	Thu, 22 Feb 2024 07:23:16 +0000
Message-ID: <13059273-4b1c-4e8e-a929-25fcf01bb727@infradead.org>
Date: Thu, 22 Feb 2024 16:23:08 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net] ps3/gelic: Fix possible NULL pointer dereference
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Jeff Garzik <jeff@garzik.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20240221-ps3-gelic-null-deref-v1-1-f4fe159c7cb0@kernel.org>
From: Geoff Levand <geoff@infradead.org>
In-Reply-To: <20240221-ps3-gelic-null-deref-v1-1-f4fe159c7cb0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Simon,

On 2/22/24 01:56, Simon Horman wrote:
> Fix possible NULL pointer dereference in gelic_card_release_tx_chain()
> 
> The cited commit introduced a netdev variable to
> gelic_card_release_tx_chain() which is set unconditionally on each
> iteration of a for loop.
> 
> It is set to the value of tx_chain->tail->skb->dev.  However, in some
> cases it is assumed that tx_chain->tail->skb may be NULL. And if that
> occurs, setting netdev will cause a NULl pointer dereference.
> 
> Given the age of this code I do wonder if this can occur in practice.
> But to be on the safe side this patch assumes that it can and aims to
> avoid the dereference in the case where tx_chain->tail->skb may be NULL.

After 17+ years I never hit this, and never heard of anyone hitting it...

> Flagged by Smatch.
> Compile tested only.

Thanks for 'fixing' this.

Acked-by: Geoff Levand <geoff@infradead.org>



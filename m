Return-Path: <linux-kernel+bounces-37683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB2683B3AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2D361F22EA0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF611350FF;
	Wed, 24 Jan 2024 21:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caS/RFD7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E0E132C36;
	Wed, 24 Jan 2024 21:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706130953; cv=none; b=WBZ082EASBTA6ghmXX/cRlsF6+VcDxGoyjnQ8/y2iV3o5/eQf+ngh/YHr4vkuusWSsr/+RDXxel1wEHH9ISq6LXRDs+mkcYBBb8X0JmODmWDrDtEITE3+mNThSpavbOJENhtLi7/eqGfvSLJien+Y57QwGWABvRoN86D/rlCjLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706130953; c=relaxed/simple;
	bh=OFjqtM8lNo2bAKe4BwdtD5hhaNo/ydw8F1ylLt/GzqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7F37RBuUigKZKlyr4eDy0TRZsVwmCqovuBneDcQtwGUZfihxJP4+w6JkOeWmPdCp7WSNwrPhRiM3aug66Zw3DmMInLVhbFqOh7FlDysrhouCPi0QOWMXR8p6HbGfEHJKSwvWmEs5gz+WjSlI/BXnt8HuOPXNiPtb8Wu1G2beiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caS/RFD7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BA9C433C7;
	Wed, 24 Jan 2024 21:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706130952;
	bh=OFjqtM8lNo2bAKe4BwdtD5hhaNo/ydw8F1ylLt/GzqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=caS/RFD7bB8STUKBP6YPbDxUfwAZwF1ziKdoPhSSGTTNQC9Hyq+w1cNFPj/cYymEy
	 MutAIkDY3FgXHocJPLZk+rvy9MsOEzX9C62dn7UclqQHNPGgwXpjYlVJ47IG+5vUXI
	 B5n9SWsHKjnH9X1zdtdwxn7s5jG563Ug0LUTezL1S0W/BWwZ+6Ah1/CUQcG7/ZiTJY
	 hN4uXzBiLkOr+30WNhvfZzVeUy/SwqYjOo1tQ+081OYYQUDiWViEi1puUn9wqJKhlH
	 2QYvWYq/YPexS3ciMba40xx1+ln3eUfXgRGN2pP4kCoKjs/PqAamDGOrwNBDQN9rHl
	 a9cZ3R/zHGwJw==
Date: Wed, 24 Jan 2024 21:15:47 +0000
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Geethasowjanya Akula <gakula@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Suman Ghosh <sumang@marvell.com>
Subject: Re: [EXT] Re: [PATCH net] octeontx2-af: Initialize bitmap arrays.
Message-ID: <20240124211547.GD217708@kernel.org>
References: <20240123051245.3801246-1-rkannoth@marvell.com>
 <20240123181716.GP254773@kernel.org>
 <MWHPR1801MB1918ADCA9FD3FAFAF9CC68B3D37B2@MWHPR1801MB1918.namprd18.prod.outlook.com>
 <20240124103755.GY254773@kernel.org>
 <MWHPR1801MB191860047DEE03672DC642E3D37B2@MWHPR1801MB1918.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR1801MB191860047DEE03672DC642E3D37B2@MWHPR1801MB1918.namprd18.prod.outlook.com>

On Wed, Jan 24, 2024 at 10:43:26AM +0000, Ratheesh Kannoth wrote:
> > From: Simon Horman <horms@kernel.org>
> > Subject: Re: [EXT] Re: [PATCH net] octeontx2-af: Initialize bitmap arrays.
> > 
> > I think the question is: if the devm_kfree() calls are removed, then is the
> > lifecycle of the objects in question managed correctly?
> If lifecycle of the objects are managed correctly without devm_kfree(), why this API is 
> Provided and exported in kernel ?

When the lifecycle of an object is such that it is freed when
the device is detached and at no other time, then devm_* can be helpful
because there is no need for devm_free calls.

I do understand that devm_free() exists, and there are cases where
it makes sense. But I don't think devm_ is buying us anything here.

> 
> > 
> > > 2. I could see instances of devm_kfree() usage in current kernel where it
> > does explicit calls.
> > 
> > Sure. But in this case the use of devm_* doesn't seem to be adding anything
> > if the memory is _always_ freed by explicit calls to devm_kfree().
> I got it.  I would like to keep the diff minimal (rather than deleting lines diff). would this be okay ?

My feeling is that if you change your patch to:

1. Use kcalloc() instead of devm_kcalloc()
2. Not change kfree() calls to devm_kfree()

Then you will end up with a smaller diff than the current patch.
And it will address the problem described in the patch description.


